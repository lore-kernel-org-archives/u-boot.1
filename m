Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C497AC7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 06:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579CE82C79;
	Wed, 18 Jun 2025 08:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HSZlfcDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884BE82C87; Wed, 18 Jun 2025 08:58:40 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8649182C79
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad89c32a7b5so1027030866b.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750229918; x=1750834718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpReFvRSWXIJsGV0vq2i/mgseUyQwgltnFDjTnZ3K5M=;
 b=HSZlfcDGEZMovVVcoQxbXhs+1rY8/6zmYE+zHOGyJiiPLjYQ6WFhVWNSJGWKbh16sn
 LM/F9Px6BuUQw8mXbDLYD0uaW2Dh08yHUloD/ljdI/gCUTYP8xFJUZejgBjvK/GO4IHo
 G7udBg73vqUW0i12U31YHudimk2sh8OSo+J6BIrrq2IbAQQSlb7bVlK0WfM8Mte3Vc4m
 0K5uNPWu4gHvypitfHYsInN+J2muzVN2v8F0Q2flqJ4qpNr/LtcJPRdbWSDcUEbpiylq
 9cK9wh0cbKu8xMgnpg4Ajnjflfi0xuU/Ku9JmfQ8O5J5/GCSagGs4CdNPctE2akamTpq
 H9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750229918; x=1750834718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpReFvRSWXIJsGV0vq2i/mgseUyQwgltnFDjTnZ3K5M=;
 b=oI+ZwTvc+Qvuy/InUhT9Yqf9CHQ0cUasiHxddoXOtB7SgehmGuyN0mUgPyeixk5pJz
 /1z9Rm4dqrDU+x87oOiI1P5XJsThvyT0cXINdacChfdlOl1EgskwjvAfhDKUfLHpa0oQ
 LGHaIJCfw4JDZkV+hjcRXRR18Qzsv3wS1OOKG9SlfADpNFCS6eF8K7ShJ/VSJ9ef+Ows
 aQAplbAVi0EPAalZOVbYy/0b/yxokgm5OnL+I3kwjg3umM8zJ2VPZJWDTy64A735QGtS
 Py2MjPzj+g0XU2fe91J3oIJZm8ZoNWGFU3/48jYWwf++r8Rb85Llxpr2p7nsimaa5JPx
 5gzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVebo3O/aFUGNDq7WaPiBBkEeEX7+sPW4cet26P/Z8W+fCn7T80vRhQaVetsdgOppbt/d044Ys=@lists.denx.de
X-Gm-Message-State: AOJu0Yws/CUlDbXURUe+4ytR08RmOle5NvruIRnaiIHABGnup9PDPwLa
 r1Jz6RNuAGIStge54T3kwKUenxOkm/E9Gmh7bURdSKfrGMv1C+9cvZLuAvDIzH+EZrQ=
X-Gm-Gg: ASbGncsUlMBE6ISU70mZ0RukUdyv3OAGtaQWkQIAYz/kgnxYUZX4NI/nEUYZDw2cdT1
 YB9R9AGE32jbY0wgAelE+oCA8fYhx1/lpY14nFFD41uqOAPFyy3PFu2Ucmg1m6QK6oUBCRis1vU
 mJRnmV478+bJaOKm1twGsqrfxVKytJyuKYqJMIPRrBVcPTTNdnMWzqFLEYwvvFBDWygoPxwha4F
 pFCalTgn9Dg17llz4MD2Pm0q3CzGNkk0hHgutFs/5Y6HpDlk1SW852QKXhwpayB+g+/EZKSP/qx
 sPhCsQ/E/qAQczl0F0FC0NB5/eOGopmj1KDLSfy1tlajzsWBoafIAAvIK32pB3t1x86zr9LUGVJ
 kpKwYLgvhSzf832beYirGSA==
X-Google-Smtp-Source: AGHT+IHOdlTufpeTdePXiNFPv4uASexfcQV3RKHJRQJOoUfZqkx5cTrUYO+39BSn/2sXkNn1EROgow==
X-Received: by 2002:a17:906:6a18:b0:ad8:9a3b:b274 with SMTP id
 a640c23a62f3a-adfad4f4b80mr1526051866b.52.1750229917885; 
 Tue, 17 Jun 2025 23:58:37 -0700 (PDT)
Received: from hades.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec897bae7sm978322866b.162.2025.06.17.23.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 23:58:37 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: jerome.forissier@linaro.org, mikko.rapeli@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Boyan Karatotev <boyan.karatotev@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Liya Huang <1425075683@qq.com>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v2 1/3] nxp: Prepare macros for KVM changes
Date: Wed, 18 Jun 2025 09:58:12 +0300
Message-ID: <20250618065828.1312146-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
References: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A following patch is replacing our IO accessors with
do { ... } while(0) ones in order to make them usable with KVM.

That leads to an error eventually looking like this:
arch/arm/include/asm/io.h:62:9: error: expected expression before 'do'
   62 |         do {                                            \
      |         ^~
arch/arm/include/asm/io.h:211:41: note: in expansion of macro '__raw_writel'
  211 | #define out_arch(type,endian,a,v)       __raw_write##type(cpu_to_##endian(v),a)
      |                                         ^~~~~~~~~~~
arch/arm/include/asm/io.h:223:25: note: in expansion of macro 'out_arch'
  223 | #define out_be32(a,v)   out_arch(l,be32,a,v)
      |                         ^~~~~~~~
drivers/spi/fsl_dspi.c:127:17: note: in expansion of macro 'out_be32'
  127 |                 out_be32(addr, val) : out_le32(addr, val);
      |                 ^~~~~~~~

So adjust the current macros and code to be compatible with the upcoming
change.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/spi/fsl_dspi.c |  6 ++++--
 include/fsl_ifc.h      | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index f2393c041f44..545561ad1169 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -123,8 +123,10 @@ static uint dspi_read32(uint flags, uint *addr)
 
 static void dspi_write32(uint flags, uint *addr, uint val)
 {
-	flags & DSPI_FLAG_REGMAP_ENDIAN_BIG ?
-		out_be32(addr, val) : out_le32(addr, val);
+	if (flags & DSPI_FLAG_REGMAP_ENDIAN_BIG)
+		out_be32(addr, val);
+	else
+		out_le32(addr, val);
 }
 
 static void dspi_halt(struct fsl_dspi_priv *priv, u8 halt)
diff --git a/include/fsl_ifc.h b/include/fsl_ifc.h
index 3ac226879303..1c363115beb2 100644
--- a/include/fsl_ifc.h
+++ b/include/fsl_ifc.h
@@ -803,29 +803,29 @@ void init_final_memctl_regs(void);
 	((struct fsl_ifc_fcm *)CFG_SYS_IFC_ADDR)
 
 #define get_ifc_cspr_ext(i)	\
-		(ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext))
+		ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext)
 #define get_ifc_cspr(i)		\
-		(ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr))
+		ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr)
 #define get_ifc_csor_ext(i)	\
-		(ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext))
+		ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext)
 #define get_ifc_csor(i)		\
-		(ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor))
+		ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor)
 #define get_ifc_amask(i)	\
-		(ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask))
+		ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask)
 #define get_ifc_ftim(i, j)	\
-		(ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j]))
+		ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j])
 #define set_ifc_cspr_ext(i, v)	\
-		(ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v))
+		ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v)
 #define set_ifc_cspr(i, v)	\
-		(ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v))
+		ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v)
 #define set_ifc_csor_ext(i, v)	\
-		(ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v))
+		ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v)
 #define set_ifc_csor(i, v)	\
-		(ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v))
+		ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v)
 #define set_ifc_amask(i, v)	\
-		(ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v))
+		ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v)
 #define set_ifc_ftim(i, j, v)	\
-		(ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v))
+		ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v)
 
 enum ifc_chip_sel {
 	IFC_CS0,
-- 
2.43.0

