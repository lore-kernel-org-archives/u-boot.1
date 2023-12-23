Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D37C4706F
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 01:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FD68753D;
	Sat, 23 Dec 2023 02:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="i9oWsd7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001D78646E; Sat, 23 Dec 2023 02:03:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121A086FF7
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 02:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703293431; x=1703898231; i=xypron.glpk@gmx.de;
 bh=V16r3y5KMEKEFTjNS0xX9/jD6U8jBVmSsoIgU0S0yWE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=i9oWsd7ofi3zG06qQ8z22o2EoJ+86x80pPqqNzWmfI8BB536CND6VLOjOQwTQJRc
 gdSBs0Ht7a9Ql0ITvTBOZIZWkxEYf3h1ff8ih12KEFd0dqoXY5fIAM8ZCJJMeywGU
 nTdFaBxv5aifhFH8gGHEmv95PKG5l5IBlSDUKixpyHPPmmGJDkOCIAdNBrElGb57T
 ShwQJ6YUm+iT0Z6iPNcz9uKNW3VZNQBmvTS+n8Q8z/znVXBp4siE1OjoVBp6bpMeh
 mzwNYBmzHcvvDpg5/2LOahOZL5ZJXA5tXYjOkQIhRlxYPXG1xoQ9a0IJN7080W2vd
 eAkpvkG8ErslCISqkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1qqY5O2xeK-00iAol; Sat, 23
 Dec 2023 02:03:50 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
Date: Sat, 23 Dec 2023 02:03:33 +0100
Message-ID: <20231223010334.248291-2-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223010334.248291-1-xypron.glpk@gmx.de>
References: <20231223010334.248291-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/w5LlgzDvG5EAFM/mHBBwHMJuLEh+oQGJSJK5n0VrAXdBaLuL48
 4ggko662lBBACNE1OZS5+k+vK3mI0cD3mnCiglqUuUiuHz6FAD71Nw6UNL+8u1HkpLKcwFS
 K88rI/ICRBLBjiIPL17l7ZDReZeePXGunj5nQrClgT3O487SO96rwV4NIdCojdWEHbl6Wy5
 BWP4vEQKQSvKiJZsUorZw==
UI-OutboundReport: notjunk:1;M01:P0:3J9xeHdieD0=;JbuVssrIlAMecpX43UZyun6yrhl
 BmAhwmw0h225LePq1+xBK4TeCGff/BHtBglzH+GKdy31e5bI7MIpQXl8rsIhF2hG+J22sJn58
 ym8ZIELKpFHoXe6T0+lM0vfP94xIHAl0//Sqr0KLBUtJrmj+lFTydDxdZ8QAmWiQQW/JcksvW
 zi1nvPAwhVkW56L/aklHpUcp3rF66SfQKyRqoK8Xdihq2PGe3ubWuTyZGxfTjA8PpoOo5GPzu
 OGExQoXWRsIswS57G7+P7CaTe5hJS0DQDQiX6kXfgjOkf1Yfna3udAsDxeWe3UmRyeiFA5miH
 Mb7TTCbVIgWpkWSqBGYT0twoYGAlZBoPsRT3D/Zi5F2cD00GN+XYQuhogq8KFJSEl0VyTFNAk
 uCwOycRJlutswsbmgnvB97iMl+u0g9/AZg60e9tRj+jR/HoRtF+PvWBslg9b3uE6WWvdYIVOY
 376bf7hEIv3E2fxK8wVIEOKYp/40IYZCG8MWl+WSG2hGjBpCT0nnIl73bFoHhPHjWR/DDQLKP
 GG4BD2RGlA84Y9eyHfGsok/YmcRJFeKNpO/eqz3Khc/tAk6W9xrXCw+9pRARYZunnzkw8u9I2
 s6uMhriBuUKFE77fVSVToqSLTzgtUhLk5x8KaOLPmnU8fawsnoIBjfzFQT3FaFrB/UYLIntl+
 +K4+50UPoGc7wQH2mSfgFGiOGabi4S43YCplsG1SeXMCr+S3kGULMFGHR+AbR9TF3zjuog/+8
 nJkO4cNnEAo2hqJiX9f4eDeniF3CV9GN6I/VCNU4/6CXcjP+qdc1f2DrBeesQT0Bu1fTKTHJ2
 oh0CbQ56LO7X7QmPNr8sO0H1aC7fH2Z9iVzan7qjcOtHoPDP8B/4RtjxZvBsJpYrbDf6Ewv7g
 KsUkZJ0FZSGH1hjsZEun6XBYyssPB8FbgTZRZRHoJECqfaR1y+3mg2mVNI77UH2Qq1Cpz0YPQ
 lULR+5V1osmUkcujH0NL3qhXSOQ=
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Add definition of the SMBIOS 3.0 (64-bit) Entry Point structure.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
=2D--
v2:
	no change
=2D--
 include/smbios.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/smbios.h b/include/smbios.h
index c9df2706f5..e601283d29 100644
=2D-- a/include/smbios.h
+++ b/include/smbios.h
@@ -54,6 +54,32 @@ struct __packed smbios_entry {
 	u8 bcd_rev;
 };

+/**
+ * struct smbios3_entry - SMBIOS 3.0 (64-bit) Entry Point structure
+ */
+struct __packed smbios3_entry {
+	/** @anchor: anchor string */
+	u8 anchor[5];
+	/** @checksum: checksum of the entry point structure */
+	u8 checksum;
+	/** @length: length of the entry point structure */
+	u8 length;
+	/** @major_ver: major version of the SMBIOS specification */
+	u8 major_ver;
+	/** @minor_ver: minor version of the SMBIOS specification */
+	u8 minor_ver;
+	/** @docrev: revision of the SMBIOS specification */
+	u8 doc_rev;
+	/** @entry_point_rev: revision of the entry point structure */
+	u8 entry_point_rev;
+	/** @reserved: reserved */
+	u8 reserved;
+	/** maximum size of SMBIOS table */
+	u32 max_struct_size;
+	/** @struct_table_address: 64-bit physical starting address */
+	u64 struct_table_address;
+};
+
 /* BIOS characteristics */
 #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
 #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
=2D-
2.43.0

