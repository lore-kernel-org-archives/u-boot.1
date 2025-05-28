Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999DFC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5855839FB;
	Wed, 28 May 2025 10:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ACo+ULMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E98A839F1; Wed, 28 May 2025 10:26:35 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB74839E8
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3dc6b2a8647so11804785ab.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420791; x=1749025591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2OdpZaTK1M3NF09J9xGkDdUTnQRspTMNQZoNf+q3/Q=;
 b=ACo+ULMoW/vyZ6S3Flf1Xsim2EgGdiYY10MyZ9Ahb+UO+girOaDf7nUnAB6XgN3aJI
 rqxb4iqbv6g18LIF6fPdsZNiiFX2jS2FpM8ToOKrndyej0F95K5lPXaO4uRtLVbvq6iL
 4cWPMRsEIGN/NL5T/x60RMtpjDvmdhr50ks+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420791; x=1749025591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2OdpZaTK1M3NF09J9xGkDdUTnQRspTMNQZoNf+q3/Q=;
 b=pBDMoa2l5Ek9/p6CI20jjeUlI/6Xq2F2dkjFz04ReRw8OCy6Hljnu7eMZx9FHgkrLV
 L7FfLHWftrHPX9qrEegzZq4KiBTJKeWkhyDBwMglX5NT2E0YmNgva0RcMTcimHHcGMaQ
 45+wrZPBgskYrDNT9KCQtNX6LV7kG7tSH84nWCkX0zVDgYX19B+goVMbWwJbDndR2/x9
 4czfistSPXwMjaK46IDVSwwJOUDgfC++uEHQJUXBdf9W39L/JBMglHweUpVi+XwiXjXC
 GM8LgunljUz7DXQfewmsWBhwem8e5e6L31JbsDccWg/8q35z5RlA7cEKk1EElT9tQkVg
 9sTQ==
X-Gm-Message-State: AOJu0Yy1X+diPuOsOPhOzzgo+XoVF4jh3Ku27Y030m/Lv3tx371NOJpA
 JXUCtAtr20ML/mksA5kPnRMlVM8KvUB2ufgu2BMW8S5XqbKaoK46y2aVsh/T0R6Bvw2LDq+ONBE
 pcd4yQ1Bv
X-Gm-Gg: ASbGncscD9WYu5LCEDLduViguQ64lHdI796Si4/1W9m14dnDrwrGU6NRbAX2/Y27He6
 M9vh7dA+2kLwU4qbpvmFePinnN2j1lZSUEVvSAhJ6iyf7g4B/qsyQES2jFKHFC3A7JNK2swyZR5
 ksF3qKqufrDi6NZ5FaPetWPO9CzxG81plTLgjxKkGugOUUDpyOKATq1fkTigrevGrcnU7WqE5EG
 jbVXb3tHAfQWEiemJPe7xANQV56fHghjKWzZ1VdtbKUrbmKO4C4uf0jwAkjakjTvEpd22FMAJuu
 ZMN63tx56QV7Fyn7oLqrqZeGIoa54JvNqrA6sa5HGmry+lGGL4ludFhSz7lXnDd92IzACZdzKsW
 iVj80fsD1M1HsJQrRKO8NQ0U=
X-Google-Smtp-Source: AGHT+IHsxBSabOjG+763fMiAVbNmJPwZ+HDzvHJ5meRGmLS624SKvYxBIimLFgpDwEWb8asBFQgxwA==
X-Received: by 2002:a05:6e02:1d82:b0:3dc:79fa:ed70 with SMTP id
 e9e14a558f8ab-3dc9b6ad3a5mr150171675ab.2.1748420790879; 
 Wed, 28 May 2025 01:26:30 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/27] x86: efi: Avoid calling arch_setup_gd() from
 jump_to_copy()
Date: Wed, 28 May 2025 02:24:48 -0600
Message-ID: <20250528082520.152391-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

The EFI app has its own way of handling the global_data pointer,
regardless of which arch is in use. Skip the jump_to_copy() function
since it calls the arch-specific arch_setup_gd().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 5b9203fec18..50726bfe32e 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -737,7 +737,7 @@ static int fix_fdt(void)
 
 static int jump_to_copy(void)
 {
-	if (gd->flags & GD_FLG_SKIP_RELOC)
+	if (IS_ENABLED(CONFIG_EFI_APP) || (gd->flags & GD_FLG_SKIP_RELOC))
 		return 0;
 	/*
 	 * x86 is special, but in a nice way. It uses a trampoline which
-- 
2.43.0

