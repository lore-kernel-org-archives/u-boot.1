Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7A1C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F063580F5C;
	Sun, 16 Feb 2025 21:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SB1H9iwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 200D680F9E; Sun, 16 Feb 2025 21:45:12 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F2280F88
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8556adad825so285968539f.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738707; x=1740343507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=SB1H9iwRUOqzSMb79kHkyJGNunWSMtIvCRicFnQc76zQWqWXbw452xndU+qaNINvMV
 8/roCmy1kutFW0ODfoUPBRBAmCwDagrBIbLQqmhq+6XVktsM0OUfYQuCWjsd/053s08N
 x6zwZHOvZzfj3WWjFEptt08DXV3Sv1hRQmKI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738707; x=1740343507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALveOlJ1YYPaatt9hXqXziYO3Z3wJwBWWAuV27HIJfw=;
 b=fzx1mUY8uaRfx8QzRRy0qV5+SOxzJnF1Sgvr64FbuDEa55nspw75wmzMoOWaHlbyD/
 GNOGjwddYJbw7I3lIekZ64iU+4OLk0ZkIufG1VVVgPtKVoi2wqreaBGT5TiAy1WTSe66
 mWc5tPjxr5nGeNI4ppn2amwjAUHaw1LsiFK9H+3mNp3Rwozz8cB7/mY85pnaroXoiErp
 J2QhEQmQuv8sWdPkO3TF4uyb+sq6aocWIzbeKFs52k/QhQlZLP3v++HgFaIyl/iJFtnk
 Lvg44kRoR0qQD/hG8PeqyUTE7msHw7DqEaYCTCkpmlElSgm3m8M6HwyPDhdZIfbPoZwg
 1XGQ==
X-Gm-Message-State: AOJu0Yz8Aftfg06FpvsnYEe3MHo1zqSV292ryU1rB7+JmOTbAeT6/WDx
 u1IDGxG+HaZCHWb4wqXtflFb2b7A3V0Y/xklya6rGBqCeh9YSLTll0XQyH1YpukUosnFslAKZoE
 =
X-Gm-Gg: ASbGncvxiU7TYnLIMp2EMPr0LP/ZsjTIwhsm2fdu99xlUqBpyui6SvgY/hyhAcjcFqD
 Y7Cd8ca8Suorlwk2aUUX0q2kuGs18pWdPR0/n+PwV7QFRqodzh9XTGQpnYTrXfK6oHgmwqTnN7Z
 jPAfxUgygkTRI/pg5kfVtkvzeOX3/5c9F5yLawJh4SegqL70KfGISKPdQMOdZxtXwdiu/PyiFhM
 r+tpdMLGYLmwpCGJPCmdW7Vl3jMD3o0NlZVxorRpx9R4U4hirDn/AxKyS4uyb8tP5wQLxa5TV2z
 ZxgZmAlnHISCPR57GlC9N/blMSrTGSJJ0vdGuJW6Gu8/tPOtd3Nt
X-Google-Smtp-Source: AGHT+IHqDUYSwBMr3jpnIdSgK4C+CqoQairkA3tYY3TBvshQ+9VFyQerXtyk02HWCLXWE/tQ30xz7A==
X-Received: by 2002:a05:6e02:3984:b0:3d0:f2ca:659a with SMTP id
 e9e14a558f8ab-3d2809b0cccmr51476305ab.15.1739738707117; 
 Sun, 16 Feb 2025 12:45:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/28] x86: Avoid clearing the VESA display
Date: Sun, 16 Feb 2025 13:43:53 -0700
Message-ID: <20250216204421.3560012-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

U-Boot clears the display when it starts up, so there is no need to ask
the VESA driver to do this. Fix this and add a comment explaining the
flags.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bios.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index 5dfe5a647eb..de4578666fb 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -231,7 +231,11 @@ static void vbe_set_graphics(int vesa_mode, struct vesa_state *mode_info)
 {
 	unsigned char *framebuffer;
 
-	mode_info->video_mode = (1 << 14) | vesa_mode;
+	/*
+	 * bit 14 is linear-framebuffer mode
+	 * bit 15 means don't clear the display
+	 */
+	mode_info->video_mode = (1 << 14) | (1 << 15) | vesa_mode;
 	vbe_get_mode_info(mode_info);
 
 	framebuffer = (unsigned char *)(ulong)mode_info->vesa.phys_base_ptr;
-- 
2.43.0

