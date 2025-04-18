Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B07C369C9
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 08:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 074F783156;
	Fri, 18 Apr 2025 10:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="meHSCUzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C881583156; Fri, 18 Apr 2025 10:20:11 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF09F82D57
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54c090fc7adso1804072e87.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744964409; x=1745569209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRFxpGb4NbriwoStQ5c6vzmI71e6M+PH+AGlcWaw8jw=;
 b=meHSCUzvf0LqqdvbYDN0pBt6rB6dMw5GmQI/eljWEngOvOhX9eUvK42rRU2S5jQ6Fb
 ZhdEVzNP5A1XQURfugiWHgE7IjMCXbpCscY5mifZsW3seU0Oa/nAV/VlBggfo/j3GjR8
 oefyVxvGTiYeJt8uXWBnc5OIa4ripbWvtLF3kk85Zi/zQvtyDRYixfNGHQc3C5oGlGo0
 C941YF5Jq04H5o+Bv2W2SFdCLxdvg5jZpWXHmYE36NmlyDz1ttKDi227tdM6N6U1Of2Y
 IVu4ebnRHQuZjbyl9GxtO3cE7MB2Oxoc8pfTZ+wp7lMIaH8lWZMAcflQKkU3kV1KA+7z
 j6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744964409; x=1745569209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRFxpGb4NbriwoStQ5c6vzmI71e6M+PH+AGlcWaw8jw=;
 b=gn2Ts/hRunr0i7zw5Z5QnVk+MtT5DPhjzfAMDhezejoPWhQIGkdv46QmiSA4ZonpJ7
 AOnXLZ/SL6gpmvJvJgXO17dfFE1R3gadEWso7aW8Y0JD041kOPUXZkvrfpIS63KoUOld
 gw3St5sYxcOJWx0J86foyrXxo8dXpEf7kcIs6bhzfofAfgTPHkQMdnhANQVzn3MASAwY
 koVy5uAZ6O3GXOi9Oz2WnbnNekgA78JotfJR4SqLpC6Uf5o/60dQOMeNNXLl5e7d8VYs
 46LY39NyVJFfl/LJbrXDEyp8VTEdUWO093zc3C4Y9/nMwoeDknDthbUtMse82c2kysmF
 PXaA==
X-Gm-Message-State: AOJu0Yw9PhlkGJS2adQAaX6FHTZRl0cHoc9xcezmydvhiHnSVtAwWi1c
 s/zQBrteN4iS49rSJ5zcYLIUfFMhdkfjvmfOvYq2pUa533JW1ZNOCcYBig==
X-Gm-Gg: ASbGncsHqQ7LkeZyUuBk/EGYwJn/NzkGK0Hm8t9m1u7PQ4karow48dvlNjiH0QC5sxm
 OJqIgdgxrM/BR28TvStBi4jlZ6JcTzErEsybzSoxeKv8tVZ2YQA1PNAOwKmDkbGjjh9nnDOdWSh
 wKCYgyeXsSWjh9urdgKhxd2BbcxkRDlaB8JMDWlETjWwB2nyIJs+L+IKFn+lmJAQC9tnU7TKkSE
 xso6XiU23rms5H4f8DxdU7RhbxG6L5HOLpeMm9dP1M9c1gNaEj+AqHqtOfrUXahu2v+lOuQzhN1
 CirzJfxInRP0EG7LsCkcULGjeejQXtoBjSFF6fWY4FmMQxhefSdBzYhfP5bKEXEivwmKgKCSaAj
 k2yPCmJ7+
X-Google-Smtp-Source: AGHT+IHgO+nTuY2ZTCl8r4S8Mlm+Dj+RzP01AqtAiXCdTO4j9HZqEqxdTOoUE8KAneWmxLdfa3KviQ==
X-Received: by 2002:a05:6512:124c:b0:549:5b54:2c66 with SMTP id
 2adb3069b0e04-54d6e62bf76mr554788e87.23.1744964408536; 
 Fri, 18 Apr 2025 01:20:08 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e5cfd4fsm128795e87.114.2025.04.18.01.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 01:20:07 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: Fix memory and descriptor leak
Date: Fri, 18 Apr 2025 11:19:56 +0300
Message-Id: <20250418081958.12818-2-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/zynqmpbif.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
index 82ce0ac1..76b7a35f 100644
--- a/tools/zynqmpbif.c
+++ b/tools/zynqmpbif.c
@@ -226,8 +226,10 @@ static char *read_full_file(const char *filename, size_t *size)
 	bufp = buf;
 	while (len < sbuf.st_size) {
 		r = read(fd, bufp, sbuf.st_size - len);
-		if (r < 0)
+		if (r < 0) {
+			free(buf);
 			return NULL;
+		}
 		len += r;
 		bufp += r;
 	}
@@ -793,6 +795,8 @@ static const struct bif_file_type *get_file_type(struct bif_entry *entry)
 
 	if (read(fd, &header, sizeof(header)) != sizeof(header)) {
 		printf("Error reading file %s", entry->filename);
+		if (fd)
+			close(fd);
 		return NULL;
 	}
 
-- 
2.34.1
