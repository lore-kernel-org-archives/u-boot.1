Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6618CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C2F286996;
	Sat, 23 Sep 2023 20:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695495376;
	bh=EHtuytXTDTjAxv5ClkSgPGpP2yymJSHh7C1q9BDaeOg=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O5UzB36xdpmhCK68Wo1SdAv/I1Wu4a2FkpP9eFnSY005w/4ukMBrvDKV6MIWJbBI9
	 VPTIX0czqIAjj+jQMMhwYs9qoJ4hUsNtCq85LHc/KuaLCl1v3ptQgHgshMPTXUyD8L
	 Zq7BIophEHRQxV4ZXzXd/MAj+05d1JgENKS+Ig1OBuO+P5VWqgvvJ5Og1tfduGboJJ
	 Q+9IAltpFOO6ntWYsVD2tIJ4CvdX+Yfi8yS0cLwd0Ry4RoYjsluterTVXR/IMryLK0
	 TXehdLX0YbuvgD35xu1pk3MnLQNwe8+QKb4awD1EuF2rxHmdpTcamacOxLvVULUWRu
	 BCKzmIeFqivOQ==
Received: from [IPV6:2001:a61:6000:d601:58e7:22eb:9e85:77d2] (unknown
 [IPv6:2001:a61:6000:d601:58e7:22eb:9e85:77d2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4320D8640F;
 Sat, 23 Sep 2023 20:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695495375;
 bh=EHtuytXTDTjAxv5ClkSgPGpP2yymJSHh7C1q9BDaeOg=;
 h=Date:To:Cc:From:Subject:From;
 b=GyUrlmkHtBwt4iyR01eX6IqA2TyZaYKZUQ83NTYznw8ejbKxjkhd68dtudK/emyv9
 bRzvR4vpG0xJzFW+jEazD6RCF/uYETy239eUejH03I6hnOTaONg66znaAmb1a+gPne
 bb+ABgkIl7SXQlkIW3aEmx6rRZrKjh/AfBH9mJJYpTw+mwAK0BKv/C7hF4qCB3KMg3
 7UQFY/M70UB/rXTtEv+xTsI8V3SlKLPnaeHhne5N0CzyC6JmBGE32vVHxrpW2FzbE2
 Mz5uMHzTUv0ZdwM2oa7lKzuKyPsjSQcFi4omv/cIU9YBfp3P3UgQgFw8aoc/BepZSQ
 hHAZs6peEcrbg==
Message-ID: <d76d7703-2d2d-4479-a15d-0fbedaf9cc6b@denx.de>
Date: Sat, 23 Sep 2023 20:56:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tom Rini <trini@konsulko.com>
Content-Language: en-US
Cc: U-Boot-Denx <u-boot@lists.denx.de>
From: Stefano Babic <sbabic@denx.de>
Subject: Pull request: please pull u-boot-imx-20230905
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

some fixes for the release, please pull from u-boot-imx, thanks !

The following changes since commit 4cb31a9f3560b293670de95e76c1f3cf2f9e1ca8:

   Merge branch '2023-09-22-assorted-bugfixes' (2023-09-22 18:25:37 -0400)

are available in the Git repository at:

   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git 
tags/u-boot-imx-20230923

for you to fetch changes up to 62a3c66a7c1ee733695b46542c4a9034f3a663a4:

   smegw01: Use CONFIG_SYS_LOAD_ADDR for loading fitImage (2023-09-23 
18:45:34 +0200)

----------------------------------------------------------------
Fixes for 2023.10
-----------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/17831

----------------------------------------------------------------
Eduard Strehlau (2):
       imx: hab: Allow hab_auth_img_or_fail to be called without ivt_offset
       smegw01: Use CONFIG_SYS_LOAD_ADDR for loading fitImage

Fabio Estevam (3):
       imx: hab: Improve the hab_auth_img_or_fail usage text
       imx: hab: Explain that ivt_offset is optional
       imx7: Disable CAAM Job Ring 0

Oleksandr Suvorov (1):
       mach-imx: bootaux: fix building with disabled bootelf

  arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi |  2 ++
  arch/arm/dts/imx7d-pico-pi-u-boot.dtsi         |  2 ++
  arch/arm/dts/imx7d-sdb-qspi-u-boot.dtsi        |  2 ++
  arch/arm/dts/imx7d-sdb-u-boot.dtsi             |  2 ++
  arch/arm/dts/imx7d-smegw01-u-boot.dtsi         |  3 +++
  arch/arm/dts/imx7s-u-boot.dtsi                 |  7 +++++++
  arch/arm/mach-imx/Kconfig                      |  1 +
  arch/arm/mach-imx/hab.c                        |  8 ++++----
  board/storopack/smegw01/smegw01.env            | 14 +++++++-------
  configs/smegw01_defconfig                      |  3 +++
  10 files changed, 33 insertions(+), 11 deletions(-)
  create mode 100644 arch/arm/dts/imx7d-smegw01-u-boot.dtsi
  create mode 100644 arch/arm/dts/imx7s-u-boot.dtsi

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
