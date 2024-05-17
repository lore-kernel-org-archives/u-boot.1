Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A742CC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 01:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C8288481;
	Fri, 17 May 2024 03:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715909475;
	bh=/xZm0NiS6DDz/rvMQ9RbRDNYS5ENkM94TKT7VUVe8Xk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HBRGxs+DhCO6c8VAXSrEeDtnx9ZoCIVfmPMx/wPWiZjd4GnM76oeMzaPsJSiHa5ZV
	 N2U9IQscNt39sx9oNilmlDNOXSuZyoDpRygPsg2DPdI8tIzZUnpD5uI5GVZOd7DnOk
	 93hHyUh/WZ9V/uOeI4kDakKUtKEHoy9cGGIOCO9HPb9ZOa2yY/re4erKWT9QDBLWgu
	 2AZDYdysHtkv+sFbKmLDkfaUuMMNSVtiGy4O7ZaBGKId9hsqgxh3D48sH/r9vD+CBK
	 SSxbCPYXPrAlbx8VEe9VXb+uTwDQL20SiEPEU4pgfRR21aNzCUkvDNmhDLzFKbKG8W
	 wQPFshJjMuSvA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2EB9A883AE;
 Fri, 17 May 2024 03:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715909474;
 bh=/xZm0NiS6DDz/rvMQ9RbRDNYS5ENkM94TKT7VUVe8Xk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZPW1BRbRs0O2jvBAsyumpFkXoZyr/hE08Hu7TY/1Ib4J6NtfTtk571817UOKFm08M
 05SE0SQJG3GiJilAFcnD1pdQsh726AkcBu42/hazdbYKyfm65Q2Rl0CAmNFu2ygLyB
 id1lkBeYGuwBTli8KAr8CvUnElYkHox72rCV0pkrRRb9Q00HfgsNBdhggrdHFyI9/t
 OuDaXxjXi3TQjcnPLmoQDuxzDnbVc73OVIQv6UnSgvq1MRMAlBEjTBqZDvKgCwNv03
 Iyg6XRD5LQvMaydKdIPa555Wqnt99QwWqwYZuREeyci6WPFG9bY3ojfCDMIw8jyMgu
 XatWjy0ReXTgg==
Message-ID: <b5366e76-6642-457d-ade9-a0e68f181e99@denx.de>
Date: Fri, 17 May 2024 03:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] imx: hab: Use nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, anton.gres@ifm.com, ch@denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm, u-boot@dh-electronics.com
References: <20240516213036.89016-1-marex@denx.de>
 <20240516213036.89016-4-marex@denx.de>
 <CAJ+vNU1Sb60gX4RoHwO=o2kf0c9bW85W2i1VwJg3Oa1hFmxADw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU1Sb60gX4RoHwO=o2kf0c9bW85W2i1VwJg3Oa1hFmxADw@mail.gmail.com>
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

On 5/16/24 11:40 PM, Tim Harvey wrote:

[...]

>> -The entire script is available in doc/imx/habv4/csf_examples/mx8m/csf.sh
>> -and can be used as follows to modify flash.bin to be signed
>> -(adjust paths as needed):
>> -```
>> -export CST_DIR=/usr/src/cst-3.3.1/
>> -export CSF_KEY=$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
>> -export IMG_KEY=$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
>> -export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
>> -export PATH=$CST_DIR/linux64/bin:$PATH
> 
> Hi Marek,
> 
> I thought you were going to leave the above env setting examples in
> the documentation.
> 
> I suggest showing how to specify using env (by just leaving the above
> in) as well as by copying them directly to the build directory if
> wanted.. otherwise the documentation is lacking.

If the tool can do env vars now, I would like to avoid copying key 
material around. So what about this:

diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt 
b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
index 1eb1fb0aa61..257ffb45656 100644
--- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
+++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
@@ -144,6 +144,8 @@ The signing is activated by wrapping SPL and 
fitImage sections into nxp-imx8mcst
  etype, which is done automatically in 
arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
  in case CONFIG_IMX_HAB Kconfig symbol is enabled.

+Build of flash.bin target then produces a signed flash.bin automatically.
+
  The nxp-imx8mcst etype is configurable using either DT properties or 
environment
  variables. The following DT properties and environment variables are 
supported.
  Note that environment variables override DT properties.
@@ -160,7 +162,15 @@ Note that environment variables override DT properties.
  | nxp,img-crt        | IMG_KEY   | full path to the IMG Key 
IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
 
+--------------------+-----------+------------------------------------------------------------------+

-Build of flash.bin target then produces a signed flash.bin automatically.
+Environment variables can be set as follows to point the build process
+to external key material:
+```
+export CST_DIR=/usr/src/cst-3.3.1/
+export CSF_KEY=$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
+export IMG_KEY=$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
+export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
+make flash.bin
+```

  1.4 Closing the device
  -----------------------

