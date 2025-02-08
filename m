Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FC6C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5941880C5A;
	Sat,  8 Feb 2025 18:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nCNtVkG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C733980E94; Sat,  8 Feb 2025 18:12:56 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F2780D1C
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844e61f3902so230274539f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034773; x=1739639573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4H1p2/gH9NS25RdFqB6ziUVv2LStqXM5RigLLYHPcA=;
 b=nCNtVkG7j94Y/HvuVF05uxHXOr2yGZQWjMFMr29xywSKgICa0gE0DKoGfmhRqCx32C
 txErNYjxLR9eZL/Tbq+f7X8yRJY6Ifl6xfnevF03Ck71BMwjtj3zf7N5iaAVKtCxELDl
 A13b+oPKhJi4burzVS0eMZKRl8BiPVIj8kp4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034773; x=1739639573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4H1p2/gH9NS25RdFqB6ziUVv2LStqXM5RigLLYHPcA=;
 b=sn0xsSSlSuV5wxVyfbqadY131Hms/9vfhBTskqEMMpRr0coybP8/snL3wpP0iuNRiD
 FEhxQ19x8DPgDiE3B/tIuqC30+4cdnzzuZVGMWdHXG6wjLdR8ONn+KVYZ2DhF8IYl9hm
 4oeQQgGdFzyv27Rnppt98BMvsuxL639X/S1FKb6vvIxinZ0Lwnr3/AuEhcsKqt/tvV5o
 GlVqJYkTUqLY3/53vaAV9waH+4wSpvobaJ5DP7ZL5cFZ45/04ikahpfy9/xpuwI4lQZx
 VJhmjurqxX1CAoDtNm0gEu/iEeOwcXlPSv3Tg8vaEXCwdcTw3OR4PUWlGCAAyi1ByK75
 L2UQ==
X-Gm-Message-State: AOJu0YwaXYttUagaUXTqf4bUpqre6xG1Xz6aTNx+xsfLa4+QMDQQHJKz
 JMc+BtfZD6tK+tkGMzoMZt/KU0ezADt2nP7gJAfJozhH4sM2zkDS9ryaZr6WhWLBIMOh16mPEOE
 =
X-Gm-Gg: ASbGncta9Y5pTGIJiQq9xyKtuAzJd6I4k3klszofZylpk/4zNidOYgsLhO1+GtvqzN6
 Zsuj1lS4RWMmxbWhWVidmTUZznscEcNQ0fahJvSzn5K3zKPsvHuypZs/S4r+IC5Zj3PUuJPTI9y
 ZB4e9iVsBUqsne14/VOKKFM5VINBVvOierflNw67jW2/7XNPslaxJibYDM8V1yk+ixUrSSjyya4
 iAuPoQrmxk8u6dDlHVRO30ao7NsF5WsyZoLsSP4v7zdHl5xXQTj170JF7RNrCkuSqZa4HyRwrY7
 hAJVRs303gmwLYtdoyRS31LP19odt4bga1uIb16QHIeIUBoMiAe5
X-Google-Smtp-Source: AGHT+IFpXVjBt4ufutDq3xOI9TpcQ27NLfy+PNXd2v/9k1eB2wOVaMqXsajXCLvAfRGcZw8sCRxaBw==
X-Received: by 2002:a05:6602:3e91:b0:84f:41d9:9932 with SMTP id
 ca18e2360f4ac-854fd8f81d3mr718421739f.9.1739034772869; 
 Sat, 08 Feb 2025 09:12:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/29] efi: arm: x86: Allow use of the EFI table in the app
Date: Sat,  8 Feb 2025 10:11:40 -0700
Message-ID: <20250208171154.1305761-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

It isn't worth the hassle of omitting this field for the app, since code
is shared between the payload and the app. Adjust the condition to avoid
a build error in the 'efi' command with the app on 64-bit ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Document the x86 field better and add a comment for ARM too
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/arm/include/asm/global_data.h | 4 ++--
 arch/x86/include/asm/global_data.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 8d51111f095..ba12da6204e 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,8 +108,8 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-#ifdef CONFIG_EFI_STUB
-	ulong table;
+#ifdef CONFIG_EFI
+	ulong table;	/* holds the table address from previous EFI firmware */
 #endif
 };
 
diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 1bd1fa92078..0d9fa823121 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -110,7 +110,7 @@ struct arch_global_data {
 	int has_mtrr;
 	/* MRC training data */
 	struct mrc_output mrc[MRC_TYPE_COUNT];
-	ulong table;			/* Table pointer from previous loader */
+	ulong table;	/* coreboot/EFI table address from previous loader */
 	int turbo_state;		/* Current turbo state */
 	struct irq_routing_table *pirq_routing_table;
 	int dw_i2c_num_cards;		/* Used by designware i2c driver */
-- 
2.43.0

