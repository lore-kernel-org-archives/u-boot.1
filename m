Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24247C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B16D80762;
	Wed,  5 Feb 2025 02:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HmY81iSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1CE805D7; Wed,  5 Feb 2025 02:56:29 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52144801F5
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f31b3db5ecso2575172eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720585; x=1739325385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mI9kN+in3I73WXtmjk7/ryQQ7mb0hm86m5PBtXTeWo=;
 b=HmY81iSc6ZZif2H5mSlMq1j7yhe9O5UD1pjpQHNR2Hnb0CWMqmn6rD3WCUX/4rT2mM
 Qn2IU5ERzWgQzN0aPloPM2g+EXDCdq4y1thGApy+aDkrRNMVHyeD1qmVmCDPP5P/ub+z
 1DBv+vO2FEoHr02d+ICmmJSYxsU944Lw6F5pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720585; x=1739325385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mI9kN+in3I73WXtmjk7/ryQQ7mb0hm86m5PBtXTeWo=;
 b=t4EI3S44w2PygQ9IJbQ4f/Bli8GP8qz2zInf1I9vyCWooqgppY/nb2kRSew7Fa8yWF
 bZbnKcRtvkWcZVZ2Uuk2fu417MA2FTqNKXmfy8uLbPm8F+2FFqv5V85nxxajl330XIQJ
 1r59p0YNh9wR3We3ajuvJpolR4Wze9gWfq7zlbScLKGzmCazHh6nAFjwHSXUglF+pbRS
 4DQBerb9Xkc2bHXRs0uueFMj8PwZBulExvZc3/OamDYvCxafDDPjxNqKnTszwETQ9l12
 ZU6PlJscIGkTdHWSuDWKG96tWfzAaPR/fBv7AkO/PZ/Gp9chCQWFL3eOPsDmDeVKEn+J
 iswg==
X-Gm-Message-State: AOJu0Yx+68ZrqGUITdrjvMO6rWbExTRk2sfz8IiRCZLd73TSpp+AFtHd
 3PTJHHgiqfQWNHIpJgZ1pnK64kXW+EnvuTneEDUR+fED9eK+q8YbSZlCaltBnDrGaBLkDeX6qJk
 =
X-Gm-Gg: ASbGncsOPD0Sz4NdfD3X4NamhPfG6gcCimsiRvmxuwWHLlJHfvfGL/pYEtjbby4MFpa
 0190LvVRVJUUwluycuJKh9iIkW8pYryTmS8igvcGgaOX9/adwiKexdCUugCrhGKCUO3WK0jjXza
 L0uS+mMR2z2dVTJTlUH7l4Xvm43ZZicYwWJZc4UWkDySiCSoHmZVt1wh+ZDqLKyqvTw0WuP+Ntg
 TIB02qktlCGnS5zj24S3LDdle/4e2sGbWm0sj50Bq/UtdudpPOGOT8rqh6/lvtMeegy3CfRg5FF
 CogTNIYL7+BBgNMx71RfmWwftiuTiUKi9tR/tVEdXD6VTHqqfl0H
X-Google-Smtp-Source: AGHT+IEYXZiA9vmRgJ/3ymSidI1wcRkQz7Va5SPPRcXu6H0BDVtsL68ot5XJX8DFrC0JzXv7Ehexxw==
X-Received: by 2002:a05:6820:627:b0:5f6:e60a:776f with SMTP id
 006d021491bc7-5fc478df888mr984998eaf.1.1738720585511; 
 Tue, 04 Feb 2025 17:56:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/29] spl: Adjust xPL symbols
Date: Tue,  4 Feb 2025 18:54:52 -0700
Message-ID: <20250205015606.2686149-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Update for the new xPL naming, which was missed in a previous patch
which proported to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
index 324b98eaf98..216c0f36623 100644
--- a/common/spl/spl_reloc.c
+++ b/common/spl/spl_reloc.c
@@ -59,7 +59,7 @@ static int setup_layout(struct spl_image_info *image, ulong *addrp)
 	uint need_size = image->size + image->fdt_size;
 	margin = buf_size - need_size;
 	log_debug("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %lx base %lx avail %x image %x fdt %lx need %x\n",
-		  spl_phase_name(spl_phase()), spl_phase_name(spl_phase() + 1),
+		  xpl_name(xpl_phase()), xpl_name(xpl_phase() + 1),
 		  margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
 		  buf_size, image->size, image->fdt_size, need_size);
 	if (margin < 0) {
-- 
2.43.0

