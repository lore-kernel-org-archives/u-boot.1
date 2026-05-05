Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DB1FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017C9846D5;
	Tue,  5 May 2026 09:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="bzhkw2df";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50E6846D5; Tue,  5 May 2026 09:50:00 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C66846C7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso28828765ad.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967397; x=1778572197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGrbc/4l/TSqQwCNcxixwV3mUv/nAdhQhh3tWv2DeYc=;
 b=bzhkw2dfSNpsWnS/v5lfuVViV+l+E1xl2WCxJ9ZztUx2ooLSN1nXaz79XNwA4S6F6X
 U+NoXoCUFvSPIoql4QBAAd9z/L+Co5itZfE56d8Ege2NR3gMWlcxErSQYbOjoDgcHkGU
 GARwhKCIBwlMZeJrsTbLRml+B9sAcdpMtLtvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967397; x=1778572197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mGrbc/4l/TSqQwCNcxixwV3mUv/nAdhQhh3tWv2DeYc=;
 b=g4ruCap8PENkNrhlwLtEoQy4dcsD/xrfRRLWoKEe5r6/Che4CXm1pllzk1mGpUQr0N
 UoGO6FZC7rzFucz9ogsxiuokqf8D9KjBEQ4KK9LaYU7Nl44CWhAa4n8o37zsBM0YiWzE
 ZkkPWHAop8lpJXyqKojVxLqhVMoMe5WbcZ/Xp0y40yqzQ6vx6Bm4tAoXvEPig9TNHo6i
 6JExGdCoLB6vtUnJRLryI8MlDCAq9m/q4ngKllv8Mtte3gxQfllIOOMLp4MUMqkQ0Xx4
 1jR0djNZnGBH+MdHNlrfnpl1irXMTjCJyHzRw2Ul/Fr80wihrmq3ZcvxBNjsh3b4F0Zr
 rkTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cHHWJp/blem8D5ImA76H4orLeI+nb6PCkfpk20kf6PBGXKQCu6sSJXV4OsAe1zMu3hZyosOQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyqYcgrP6xbnHAneNFPPY+XKJ1ihCSJff6FvIDRWmpVSSDDJg6y
 c+0tlqKW5l8BqxMCroYosbdXPe4W3t2lG8NJxwdw+m/3ebb55w0CltcIYVo7vqqLX9A=
X-Gm-Gg: AeBDiesjcq4FSHU9rKhz+2i+KS2yuDEc/zxg9JWyEpxSseKcfsk5AUttMKCb+CZ9tZ0
 YlBo9xkQ0Wx8LihGi3hLk42zn5/XcPrim9V4IuHYG7Gv8panC41twp7TjHU52UE0WiBn/yv/Ju7
 HfsrunJnubrytK2GqfVDnLqOLSpN1Fro3KAlGh6XFYA6l7qhxtL0RBgATluI8CoVnuAXOUxHUwL
 OKceedqUJ42WEEzF3Db/LwCr1M+F2rd9Ix0Vro7SzKb+XwYW5G9DT7jA+tApf1O4qSdcMUBC0LU
 /Izz8AhTq1a/KVT62a1EFJ1jUSDZmP2xz+bh0+QLiMbJQ8kY6vICmI9Simq/+5Iq2IY8EQ6hXs/
 M3ZqPRqt1HGHuviI0+eJaOjOAymgp2qxuMXT8AYuiPp/LvEb3qPdAQhcVKN1mdNivvbwtcl5cyq
 aXhp4ORrngGreMEE797cX5n0pLra2kagSuaMeDn7d+SprlZ8M+ey8hzsXL45fRwqMfLCR5Sjl68
 obpkj/1P54gJDCASa+XMfTl4PH25L3LEh8Y/A==
X-Received: by 2002:a17:902:ebca:b0:2b9:f8e9:70e2 with SMTP id
 d9443c01a7336-2b9f8e973a3mr110162625ad.8.1777967396601; 
 Tue, 05 May 2026 00:49:56 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:49:56 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 1/8] sysreset: qemu virt: Use __raw_writel()
Date: Tue,  5 May 2026 16:49:34 +0900
Message-ID: <20260505074948.2603870-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505074948.2603870-1-daniel@thingy.jp>
References: <20260505074948.2603870-1-daniel@thingy.jp>
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

The virt ctrl register seems to be native endian, currently this driver
uses writel(), which works by luck because its currently broken on m68k.

Use __raw_writel() instead to avoid breaking this driver when the
endianness of writel() is fixed.

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
index e7cacc9b6e98..5ab16001922b 100644
--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -38,7 +38,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
+	__raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
 
 	return -EINPROGRESS;
 }
-- 
2.53.0

