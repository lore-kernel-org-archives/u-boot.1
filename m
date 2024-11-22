Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F8AE65D0A
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306BC89787;
	Fri, 22 Nov 2024 01:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5X8UMx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D138977B; Fri, 22 Nov 2024 01:31:33 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABF289768
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-211fb27cc6bso16645955ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235489; x=1732840289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1O2jPCVCf4ELvw1NFjW5SuyFVUz8fKW4rQkPSi78Fvg=;
 b=T5X8UMx26tP8ZaMZlXzrCYenkfSmqnMzGDOQn1R0kfmSv7QhHR2/6e5wDs1/ang3oz
 45YufWEF+o+LE+5Sz8unsqqqc/l/ad3tTZSZfMUwOMd5KhMSngTVBMKVj/sIbg7Ypxjp
 VnQUN53X202FMKwMR+RKm4FvcOfsGWQv13eozso1RnnFYLg2gR5AtISJQL7zaZZ63Bl8
 Gjl1pbTFjh3sTEBzZF6G9xb1FoHfTS0+QlPXIWlt+NX7pS6ekXbWVUVZTHbsy3qOrzxc
 9CyuyOdvTHcMYR1C3NkdvUfjK0+Boer+orZyULdmIFOkeqTtczKusWF9cMUqUJnx4IZZ
 85DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235489; x=1732840289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1O2jPCVCf4ELvw1NFjW5SuyFVUz8fKW4rQkPSi78Fvg=;
 b=bpm+kJxostgE9W9xWOmsoZfPRJl7t/vdvvzwT4cwKhIY13+PXzz70OtRYhiDoXnW4+
 zPwJSg2mgr6P6bOuiIZimm3ft6oKMhNEfauCrk/D/gIvA62TQTQEvg24Pxg7nxXQV/lO
 yUHForGKVsEYqeEdud+VQLQ5z2vfSc3esXoYhEIecxFQPt/bQd6B5RdWlRiaDtlY9jCa
 4Sc2c2WI8felMa6DLWuVr6mffWsPEPM7W5r0vs4T/tcHlGnGS6sLdV8Y32CMshoFLgR4
 4PB+Ia+8/JOOGOvAhl0WyZuPwYA7WXXJ7DfRVFk2f6DTrAXQ3ORCr7Nsg3lchEuH3fYM
 4FBw==
X-Gm-Message-State: AOJu0YxBFgv2vGEMhBoZTEFfCCg4q7P+S3GuTiojjENHNto5DWtk3Ln6
 Uzw6BVlgyYE5SLbzhc9FlWUL4UBk8ObjWiR217DoE0rwoeqYrM5CanSy9UJD
X-Gm-Gg: ASbGncvzwLgMOA3CLqu+Bao7NLf2Ky65x/rJP1gClceqvAKBrZAQpxNlQ3pFL5j8UyY
 VDFjiwYeVQtU5NP/2iJ7rqMwQ0b3ULGDYElh1dtsFSngfDt5F3TNAZDqOzkKWjDZRXZBlVjEp88
 a2dYPI97PwDnBb/5IbAAHL0PGWhTUFWpFpBJ4Vhju1PFDHJuGMYmKwaPdm6x+DzNsQbIqG22xDb
 g4kpCzAS34uDfarCqf7K1x/xdgkpKwFbn5OICmfPGoOjg+lv/lIwLQQivlSfI6A
X-Google-Smtp-Source: AGHT+IG/vCyvhFI7cAm2kmc5Mxmama3shA6+HCe82/5jGu8C7PMaI0WaNW0WZ6Jt4VmvRyU7uDIqVg==
X-Received: by 2002:a17:902:d4cb:b0:212:68c2:4df3 with SMTP id
 d9443c01a7336-2129f5d981fmr11595695ad.17.1732235489568; 
 Thu, 21 Nov 2024 16:31:29 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:29 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/7] arm: mvebu: x530: Don't build mkeficapsule
Date: Fri, 22 Nov 2024 13:30:20 +1300
Message-ID: <20241122003058.270163-7-judge.packham@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122003058.270163-1-judge.packham@gmail.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
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

The x530 board doesn't use EFI and our toolchains don't include gnutls
so disable the tool in the defconfig.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 configs/x530_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/x530_defconfig b/configs/x530_defconfig
index 89612be631e3..a5b1cc3f8e89 100644
--- a/configs/x530_defconfig
+++ b/configs/x530_defconfig
@@ -95,3 +95,4 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_WDT=y
 CONFIG_WDT_ORION=y
 CONFIG_SPL_TINY_MEMSET=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.47.0

