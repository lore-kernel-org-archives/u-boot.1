Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A677C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 15:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C3880ECC;
	Sun, 16 Mar 2025 16:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CQxvAqym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B8680F4C; Sun, 16 Mar 2025 16:00:08 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896EB80C93
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 16:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso8351875e9.0
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742137206; x=1742742006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mx0RH0XfJvc6KXvfsQhIioeBalVNYNuCOfEL/cKC4V8=;
 b=CQxvAqymdLdRGOQvwW4u3j4jQETSi7aHWxjk1e7vHE06fIiuKaieuNztMDa52wT7Hh
 xb5JsffZzhhDuBs89GPO1ttWAIdwxjZkl+nKmcU2jfTG9g4/FEt7AflIZCyU5HzFrRDU
 rJd7Gaan5fVFJyzB6oWVEMikReERqmr7Kjt+aV6EePpnBt/eI3qalps0hD1jGRPmEEgB
 VmJbnO9PAfGHVMat5ghKf6jD4eVxhPBF3/nDWJqOkhnpM625lihF5a5uneBrTlW5KYnO
 TQQFGdm8eDJ+h4/0wA+4GqljeoW9t6oZ0rNcxmiEYf8jhkXY6eRt96FbjSoKYH3GfrRQ
 /4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742137206; x=1742742006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mx0RH0XfJvc6KXvfsQhIioeBalVNYNuCOfEL/cKC4V8=;
 b=aV0azKOgeYGg12LBKAYlZ25L6UM3Nxe4DHDIuz6goHMCJ/6v6G//7cePsMHrFHOGaj
 bQ/5XB+G0V8HuskJIvrJzzcTwhpcqikqUzim7JCEpNWjtfFrz7Pwn6SKCTDbohiuP4P1
 9OAa52w4pSqpAFfCtQq/eWz+OHCSMRL11pXpvF20JiEJJPByYZuZ6fJRTuOmhp8TyQWQ
 ctKUBZyLpUMth/jz2sX2UW202nQlnvT77J5Am2wj+RBZoMmxNAlXp7fBrc/hhb9Xs6Gi
 m+uZ55i0dCzc8ZONV8sqTqu8fwr0rUtgkn5qxFVouAHKwcU0B+Gng8eJgFd2FOV2ZJBz
 aOgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFKyydKDL9HTTcMH09bu0aD9zJBcI2MZPKvt7M7LOCTBD02Jhi21vaFDy3DfMqzI4V6aXnu7Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzwhhvO07bTdaXYjg1Zh753WxAT58rU5MM/GXlyjJ7N7c2v2ytI
 wSECdQWaa7DXhBfoQNMYWievpRA6ecw1pdqmPLVltCCIZRNspQbx
X-Gm-Gg: ASbGnct0r9UJPfAGo+YhQ9ToaXJW/8W7+0nRc+QqsQCzZwnRRd/zDVrndgRpCNG9WvJ
 V2Tf+Ipjoas214CnVeKI3xNetfZUrBWY7aXmHd1LDo+radM9CfjMa+ELqsnW7OhGO4ymOB62G+D
 LN9zcIMOg+MI8ILP2H5LTCgWmGem5wDhpGFC6J3IEgL7pFVetrga1EHlFEn3ERau5Go15pnLkT8
 ibjMUF9BSaIgQaneCVKFtGBmwMu5VqVoXhuIvQS8qaawopgN4Co69FxMwzz8DAlojxuhIjXRA6q
 8osXndmR2S/oHARtho1zD30VVjCMc3yQ/Y4qjxgtCbV+pP537FazWtIRaLCj4CNdxpdv/OcWpSz
 vH5V8/d/VecqTi43wN8NImi/0ObdPpazje5E5XPkh2KJs5eqp38C5wm0ZkQT4bMl0XgiWsEN+Z6
 NsWiQ=
X-Google-Smtp-Source: AGHT+IGnrJRhvdUdNjlALXp42pQTqxPQJXlIDgA6R4rKVjRWMsNHKXOi1LvzylxoLZnqqmsC/M9wew==
X-Received: by 2002:a05:600c:4f49:b0:43c:f61e:6ea8 with SMTP id
 5b1f17b1804b1-43d1ec90a5dmr95023305e9.2.1742137205627; 
 Sun, 16 Mar 2025 08:00:05 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cd78sm12255233f8f.78.2025.03.16.08.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 08:00:05 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] arm64: Add MIDR entries for Cortex-A55, A73 and A75
Date: Sun, 16 Mar 2025 14:59:52 +0000
Message-ID: <20250316150002.1913162-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Add MIDR entries for Cortex-A55, Cortex-A73 and
Cortex-A75 cores and update the is_coretex_a entries.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2: Update is_coretex_a entries too.

 arch/arm/include/asm/armv8/cpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv8/cpu.h
index 4dbb589aab8..e906fdf1bf1 100644
--- a/arch/arm/include/asm/armv8/cpu.h
+++ b/arch/arm/include/asm/armv8/cpu.h
@@ -5,8 +5,11 @@
 
 #define MIDR_PARTNUM_CORTEX_A35		0xD04
 #define MIDR_PARTNUM_CORTEX_A53		0xD03
+#define MIDR_PARTNUM_CORTEX_A55		0xD05
 #define MIDR_PARTNUM_CORTEX_A57		0xD07
 #define MIDR_PARTNUM_CORTEX_A72		0xD08
+#define MIDR_PARTNUM_CORTEX_A73		0xD09
+#define MIDR_PARTNUM_CORTEX_A75		0xD0A
 #define MIDR_PARTNUM_CORTEX_A76		0xD0B
 #define MIDR_PARTNUM_SHIFT		0x4
 #define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
@@ -31,6 +34,9 @@ static inline unsigned int read_midr(void)
 
 is_cortex_a(35)
 is_cortex_a(53)
+is_cortex_a(55)
 is_cortex_a(57)
 is_cortex_a(72)
+is_cortex_a(73)
+is_cortex_a(75)
 is_cortex_a(76)
-- 
2.48.1

