Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D091FC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7D088719;
	Tue, 11 Jun 2024 22:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZZdd7Dck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FCF886AE; Tue, 11 Jun 2024 22:02:20 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ABB3886DA
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-375b2fe7003so6751535ab.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136137; x=1718740937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNy79vFX3GihHub247LitC8y+80SEFlHKgr0PfQRDQI=;
 b=ZZdd7Dckp1KpZDFgOuACgBEE5AGax4MxCPU4cksACVh3aHMpfgIz6DpI+bhqyHFEs1
 3US1qkozcSYGZC3Kr1I4fcAHQzrmdBewNofd0/IDwdKbpDF0TnGPomdd+7lzTFdaRv8i
 oY8BS3/JhIEkC1muHHMZ+ET0yGIWgjgaIOE00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136137; x=1718740937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNy79vFX3GihHub247LitC8y+80SEFlHKgr0PfQRDQI=;
 b=mxJWQGrAJXV+SA8EHLBAAj//+ldKNT3F/Qd2rg1oIQSWOaokcts0JX+N3Sxbdzhq0u
 l4UTjrr5cF35EKPj85cQ4U2EDbWFiPBx32yfXvLcvylA8G4GJHqJWFImUHFTj0C+/sAm
 cC/I9meTWLf84jZDOdzhFT6YmmZM2b2oM8sr0y8QAj720htikip4MMwgYIO6wQQNno1C
 EUQW2AUjEEuoSI/s3j8Cfucfl8hHdGwz7SQ0jxF2irc7BK5ftFFZWKx7DycpcLPs3AVC
 1En/uF1Dgp5Y5+29VzWq0vGIacUe6BUgD86B9K0hsYw6ca4Hlv9UwZsntUYepuZCCjSH
 vn5w==
X-Gm-Message-State: AOJu0YzBHhptlD+SURIQ+MtQJKWaKpJSIeo7eFvkxrrH0sfQvedOcJV1
 JF24JxzWx/brNG77MpWTY7Xzv5syBv0PJziHpE9sVbhoha7g7KxxnGyvv3r0BGDLbhBg/amaw8W
 PyQ==
X-Google-Smtp-Source: AGHT+IEiM6pht5MH2kMNlUTzz/a2Etxhr8GtufZSKlgd0FERnwFu0hBhl50Pg/js3dwhKIiCxqDA/g==
X-Received: by 2002:a05:6e02:13a7:b0:374:593f:914a with SMTP id
 e9e14a558f8ab-3758030b7b0mr168990835ab.4.1718136136738; 
 Tue, 11 Jun 2024 13:02:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 03/42] binman: Regenerate nxp docs
Date: Tue, 11 Jun 2024 14:01:17 -0600
Message-Id: <20240611200156.2245525-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

Regenerate the entries.rst file to include this recent addition.

Note that more docs are needed here, to actually describe the entry
type.

Note also that the entry type needs Binman tests added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 531a92e2e0c..ecccf77d112 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1528,6 +1528,28 @@ byte.
 
 
 
+.. _etype_nxp_imx8mcst:
+
+Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
+-----------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,loader-address - loader address (SPL text base)
+
+
+
+.. _etype_nxp_imx8mimage:
+
+Entry: nxp-imx8mimage: NXP i.MX8M imx8mimage .cfg file generator and mkimage invoker
+------------------------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,boot-from - device to boot from (e.g. 'sd')
+    - nxp,loader-address - loader address (SPL text base)
+    - nxp,rom-version - BootROM version ('2' for i.MX8M Nano and Plus)
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
-- 
2.34.1

