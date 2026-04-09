Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D2F364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5E58419C;
	Thu,  9 Apr 2026 20:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="FeHmlx/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C23C840D8; Thu,  9 Apr 2026 19:45:58 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEBD83DC9
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 19:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 09 Apr 2026 17:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775756754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDT9IRniGLCX54nJ+/EKi6ZehdAxmUXRe8zPP4607nU=;
 b=FeHmlx/52b5M9vsVtzonQboJdwgKv6qcKlxII9qiSAmUgnVom/azDH42MMoj+URAHuJxt9
 DqDJYYpDBpjLrvDgYy+VD+0/vp3bRTMW3SL/Bp3swKyua2/Zvfg17EDS67kIsxCUuy00To
 OCFj9orKe9BPSHhUkQr+KnxSgk676JIVenSP+5LyFlaBRYiS62CWjR4wXcSkP479m2YSVk
 kUzCEPpXNBbj9uXbLj2HT8Gnh2jv7ZP23NMjOyxvj0yk9Yz09H1sNOHCCJFK1noge+Ddh6
 3aKOBMjzFO6cYBjgXsGvHYxl4YFxhIk1tBOaCVB2QXdSiDrGKg303hINuK4WYw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Jo=?UTF-8?B?w6M=?=o Marcos Costa <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners
 .org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 2/4] drivers: ufs: qcom: Add SPL support
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
 <20260409-spl_ufs_only-v1-2-f7e0e243d805@oss.qualcomm.com>
 <td8mkt.1mmhaeeba0rbd@postmarketos.org>
In-Reply-To: <td8mkt.1mmhaeeba0rbd@postmarketos.org>
Message-ID: <td8mob.383jxpa0zq07h@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:23 +0200
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

On Thu, 09 Apr 2026 17:38, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
>Hi, some drive-by feedback:
>
>On Thu, 09 Apr 2026 14:43, "Balaji Selvanathan via groups.io" <balaji.selvanathan=oss.qualcomm.com@groups.io> wrote:
>>Enable Qualcomm UFS driver to be built for SPL. The ufs-uclass is
>>also built conditionally based on whether SPL or
>>U-Boot proper is being compiled.
>>
>>Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>---
>> drivers/ufs/Kconfig  | 8 ++++++++
>> drivers/ufs/Makefile | 7 ++++++-
>> 2 files changed, 14 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
>>index 49472933de3..a32d51cae1d 100644
>>--- a/drivers/ufs/Kconfig
>>+++ b/drivers/ufs/Kconfig
>>@@ -55,6 +55,14 @@ config UFS_QCOM
>> 	  This selects the platform driver for the UFS host
>> 	  controller present on Qualcomm Snapdragon SoCs.
>> 
>>+config SPL_UFS_QCOM
>>+	bool "Qualcomm Host Controller driver for UFS in SPL"
>>+	depends on SPL_UFS_SUPPORT && ARCH_SNAPDRAGON
>>+	help
>>+	  This selects the platform driver for the UFS host
>>+	  controller present on Qualcomm Snapdragon SoCs for use in SPL.
>>+	  Enable this to use UFS as a boot device in SPL on Qualcomm platforms.
>>+
>> config UFS_RENESAS
>> 	bool "Renesas R-Car S4 UFS Controller support"
>> 	depends on UFS
>>diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
>>index e7f3c1d30c4..7056066ce25 100644
>>--- a/drivers/ufs/Makefile
>>+++ b/drivers/ufs/Makefile
>>@@ -3,13 +3,18 @@
>> # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
>> #
>> 
>>+ifdef CONFIG_SPL_BUILD
>>+obj-$(CONFIG_SPL_UFS_SUPPORT) += ufs-uclass.o
>>+else
>> obj-$(CONFIG_UFS) += ufs-uclass.o
>>+endif
>
>CONFIG_SPL_UFS_SUPPORT depends on CONFIG_UFS being enabled, so from my
>understanding, don't think this change is needed, is it?
>

Oh ignore this, my bad. It is needed for an SPL build.

>> obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>> obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
>> obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
>> obj-$(CONFIG_UFS_PCI) += ufs-pci.o
>>-obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
>>+obj-$(CONFIG_$(PHASE_)UFS_QCOM) += ufs-qcom.o
>> obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
>> obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
>> obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
>> obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
>>+
>>
>
>Best regards,
>Ferass
