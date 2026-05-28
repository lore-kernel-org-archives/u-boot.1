Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D18FCD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF42E8469D;
	Thu, 28 May 2026 19:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VUqRruV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD79846F4; Thu, 28 May 2026 19:11:06 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F5380087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e61e25199bso2264383a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988258; x=1780593058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=VUqRruV42Axj4ej3t4mIqRzcfAnIlc01mbcpLjX3MshthiU4P6LlugnWaOQNRAVE58
 XW0HG5t1F63eMrTZgaQ/PSk3xRfDgtZnAia38R7GgeLPDx3C7xp6Of/vMZBsQj044JE+
 haibmaFdUhpdx5j0L7TpoTBIKB13jCSdH4GfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988258; x=1780593058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=KLZL7X8e4sCWw9Rxn6fy/TP2qnmZLQLvjSFvosb/tKEokX8UTWMjXQqM3gyFsPN/rm
 Emhm/WOPphxFn2ovqm6bmDDLDh9JpToj3fJXe+DHcBVL18HXVgdZStRbil7Oel7+CFto
 bHCd05Fj0fp6Q4iiXG2zhq+nVxBbHeufm1pihLtR8RK0z8KP/nITocTRhX1xwxWYjGBz
 XsGQ4JRg+F0MD7+KYWjKHLcX1+zI16WkfeBt6zV/88aO2qa/znwkeWxRmqkiMpoY6ukh
 1Vp6t1TcxP7c4dCDZkM+Z/swBGmlDgyPwHJceKaAdVb0vyc6FfzfpWcqfqvVJRmSL2JG
 6ipg==
X-Gm-Message-State: AOJu0YxOqgOAaFyw5JbQQNVIZr33fvh+8YQSL+tVqcWvpVrWgKqZg6LX
 /RexUjw9xmStkDWS0Zfp382VfJT0chHy9Evrz9EqLlNGDGDz4acSOnoYzzzvN8gPQSvXJdPA+Jn
 MWso7gI0gDaY=
X-Gm-Gg: Acq92OEUwUOxX0hufBmnCV5/bv924jNbMIgghhpAJHCitDKDqMlwtxkOYG5uF6tzu/k
 1X+LgavPE959098h8jR56OAQoqqkUga4LLVQYqd18JIpf6LBMfTQSyvjj7VLXooogVZGWGmQpVz
 7v8RNpL0e1SLrMA6v53Py8xP9YRfjyOr1QHg5cXIn0tDSA/gV36pVh3mVQyPMotmyL8pp1vfg0Z
 D+aAEaXI3IYyrI/BHRDvyoqXzomJqZn3OB4MMv1mD4m50+tmKX4+1+FzHZ8z8/MN83khZfTaEV/
 WJPkivRQEhItcmNcyZHp+sBhoyiopgcbRd0EfwpKDqiKI2xCTU+aicmq1cMpsmBqSDBf0KsLJy6
 4OEOazUmv6zGPw3PAvG6Dc/inEg+TAPjVYL6zvYzCb0dAN8/Wv5Xv67pcBuWeB0f4beWWXyBtcB
 FawrZfi1WDV+oItxASIi0tAeXLqZn1
X-Received: by 2002:a05:6830:3705:b0:7e5:f831:508f with SMTP id
 46e09a7af769-7e5fee16e35mr17094887a34.15.1779988258553; 
 Thu, 28 May 2026 10:10:58 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:10:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 01/22] spl: Adjust xPL symbols
Date: Thu, 28 May 2026 11:10:08 -0600
Message-ID: <20260528171043.910264-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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
which purported to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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

