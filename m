Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB9BC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD2182AA4;
	Sat, 10 May 2025 15:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aBh/MZGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8DA82B53; Sat, 10 May 2025 15:07:14 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809A5826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso530638566b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882430; x=1747487230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMMfXjjHexKxADos+yfYIdAZC1wk38LH7Pxli9i38vY=;
 b=aBh/MZGJnUcfGoirc8WNiUEx3/R34/uF7XZihwvdL8Xn1DnEJ1bN2DQ6rWzZYO/pKW
 0OFMR8h2zedL2ZsUCsRX2GZYKuVVbEbkSeozcHrf6yL+ne1jr2yOdzwESBBMG1eIyGh5
 dDdT79DFEsxVXRwv2ZqPy45Bty7fzPyYyyAtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882430; x=1747487230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMMfXjjHexKxADos+yfYIdAZC1wk38LH7Pxli9i38vY=;
 b=cRu5k5rB3rjYsl37CNsEFwjK7Jj1lDvjfa81d9IMBiIp/+JIsXMcEhZDYw7GcolN9z
 7rmS8/RkjlSvmL7DvftLr3raKy7QkQoVquwvVJ2h1R8FaGa07itaS3kIqkl/63w3oVyG
 PiI0mN1gVZEJwZQVtG6kBEEBe2pYOcbCrVHzEC67aBmTrFQE75xaLfEGhOhjc8EPJDJ9
 MpXOVlFO7FPbf6ayNSJDzmnURGe2163fmjwEsVSxoPLHcF+r3SEGCe01afUh20sCsjd6
 WHwJSQL8I1DaI3IKP+hJWaEz0pbyQCtC7arMqyYEhJoEH6u2qVQdu52ONoxJTWm2mPC+
 10ZQ==
X-Gm-Message-State: AOJu0YzIqFLICjVWrs6+mh7usxiDQToItmaEdLMIfPgBJFYdjXyJrdUP
 92DG+Uh01DBLFXiqF/5UXHNUI8FvxRaBzQytqtphSMdZCKWcbxf0CrLW5r3TAL1Zei9y0tW+DR8
 8JDNOzp6SOw==
X-Gm-Gg: ASbGncs6pGIhXwdwe/fwmSQ7vyVcHoFwyaPcnfVrDKix3YGR8VHFoyAh+C4zJuKqOuW
 CwstTDeI5EWCOffaEMvPfVV2amoaACQ3YgkcoW66lTg2hapQXIb9woLtgN8RtXSg0gRLeEF/sN4
 lkfHyZe71Yl7XAPyYRZmAkIRotIDQwd5BvQuPxjGJbQIJkaKl53RqPYiQ3ueukQim+yIDoinAWB
 GCZTnlymy8tcLDJNGRCfSkISOv3WYgXaCWkhS/PWxT3euhjJFPlYnNt5LGj9KmQQL8J35cWBbEc
 cWEQf7pexamPJLI5bKQroY174B3J6MVCMqbM6QdWSSpC0Hg=
X-Google-Smtp-Source: AGHT+IEtqztMusQmhbxqFXsgZ2AQLmotcJkdFhK9d8Foys+uZzX23ar9MTLIPpWEMsxE10wa/37zeQ==
X-Received: by 2002:a17:907:6d28:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-ad218f41a8amr658556166b.13.1746882430563; 
 Sat, 10 May 2025 06:07:10 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 08/10] ext4: Set a max limit on block-size in ext4fs_init()
Date: Sat, 10 May 2025 15:06:14 +0200
Message-ID: <20250510130642.1575114-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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

The block size is typically around 4K. Complain if it is much larger,
since this can cause problems with 32-bit arithmetic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/ext4/ext4_write.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index e77fb383a90..9b1e26e86a7 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -608,6 +608,10 @@ int ext4fs_init(void)
 	uint32_t real_free_blocks = 0;
 	struct ext_filesystem *fs = get_fs();
 
+	/* check for a reasonable block size, no more than 64K */
+	if (LOG2_BLOCK_SIZE(ext4fs_root) > 16)
+		goto fail;
+
 	/* populate fs */
 	fs->blksz = EXT2_BLOCK_SIZE(ext4fs_root);
 	fs->sect_perblk = fs->blksz >> fs->dev_desc->log2blksz;
-- 
2.43.0

