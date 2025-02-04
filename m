Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0DEC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771258070F;
	Wed,  5 Feb 2025 01:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mpF53F2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8890805D7; Wed,  5 Feb 2025 01:08:07 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC79807B9
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71e287897ceso4387249a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714077; x=1739318877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a5yu2eu30wwNZYrzcYKoj8bX7QTw2AocemOCYkLyMQU=;
 b=mpF53F2AwQfTxD3t8kozIDpqB1tI6okTF3Yg30DCf/pbBA2Pc33W5co9j4r+BqnSuF
 BMu5z0iiaOPIwKtnEEvNao2y5+i6whwNdou9/GjVpvaerJf8Nmnmry+0d4zdeIcVRZZA
 JVlYXlIRNJImuZJvhGwnKZwfT/Z5AfeB1BGM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714077; x=1739318877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5yu2eu30wwNZYrzcYKoj8bX7QTw2AocemOCYkLyMQU=;
 b=FjAhc/763EjgwdziVH3N+DBVoAXF8r77/jj5ENvYf5RtuicLyH6Qbe9ubloczCxQ0r
 WWUp82pf7LtqhX6qN9LBmfsyGG3Mo3DD6vMK8EXWvsS/1do3glRhj+AsA3DKDwv26rXy
 oudaTK980rd7TvgwNCc4TZ4a7NlPfmx/7oy52jYUkNozNHjwfy5IytY1tjHnZmkGhPBC
 f0vBDkAQam1IeZXWQMj7qulbOPjVu4IZ5oKO9bouAfMJf7Gn/Zi8osKCspHeIQCQHI0b
 Y5YDjguOn7377lEsO/0goHeARn1rL+0jCEesibu03ivVX0mcDEE09rzTg1vAX+HLc/M8
 IXnQ==
X-Gm-Message-State: AOJu0YxrAfUCR7nrk4mACpp9hSahhBCHYjUaiYy9diCW/I0qQG0dLNzz
 HWWBDDfmJ/GGXQs7e7SFSkRQOXrGqxwg/huE3K5Par7TjLsW8MaRc5gbOsh/sts+pA4amEjib1K
 HZIU=
X-Gm-Gg: ASbGnctSfHRd1PjdHzRcqo2jGI2jALr8q5PHd8SgDyWnu4tBAWZaGiOzf16ihNIgtJt
 8z6CiJ8gqswYlBe4kuhmbYgMu5gbYSkj5FLJAZO6I2FAjORSKYl4UdiT1n/dAipXUTN8kOM7hl+
 NhCJXdAcy88Y1E3U9+D5kI82wuVCQMwkgragnf7Z8iIu0LzXlq82QzCGIHR0w23GHp0ww4wEeaQ
 EL74EuRsG2OHquf+GPQTpiF/HT1G6ZXSjglngH81bGJKQKnkbG0tkEpGu54XlTs1X6WgD9U+A7z
 B9+ojuKI3rgNb/Pr1g==
X-Google-Smtp-Source: AGHT+IFEI+EM0bizjMsbU3KK8deENtig60mbl7iRpD7K7PYZI6qrJ895LFengzlYwkTTB+QEzonjPw==
X-Received: by 2002:a05:6830:b93:b0:71e:959:d73d with SMTP id
 46e09a7af769-726a41ac3a0mr732259a34.15.1738714077038; 
 Tue, 04 Feb 2025 16:07:57 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc105d40b7sm3428552eaf.36.2025.02.04.16.07.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:07:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 6/6] Dockerfile: Update for having more requirements.txt files
Date: Tue,  4 Feb 2025 17:12:09 -0600
Message-ID: <20250205000743.949790-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000743.949790-1-trini@konsulko.com>
References: <20250205000743.949790-1-trini@konsulko.com>
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

Now that we have more requirements.txt files we need to grab all of them
for creating our cache. Also, we do longer should install
python3-pyelftools on the host as it's not used.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2848ab85f35..85d67848327d 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -122,7 +122,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python3 \
 	python3-dev \
 	python3-pip \
-	python3-pyelftools \
 	python3-sphinx \
 	python3-virtualenv \
 	rpm2cpio \
@@ -308,12 +307,18 @@ USER uboot:uboot
 # COPY / ADD directives don't work as we need them to.
 RUN wget -O /tmp/pytest-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/test/py/requirements.txt
 RUN wget -O /tmp/sphinx-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
+RUN wget -O /tmp/binman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/binman/requirements.txt
 RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
+RUN wget -O /tmp/patman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/patman/requirements.txt
+RUN wget -O /tmp/u_boot_pylib-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
 RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
 	. /tmp/venv/bin/activate && \
 	pip install -r /tmp/pytest-requirements.txt \
 		-r /tmp/sphinx-requirements.txt \
-		-r /tmp/buildman-requirements.txt && \
+		-r /tmp/binman-requirements.txt \
+		-r /tmp/buildman-requirements.txt \
+		-r /tmp/patman-requirements.txt \
+		-r /tmp/u_boot_pylib-requirements.txt && \
 	deactivate && \
 	rm -rf /tmp/venv /tmp/*-requirements.txt
 
-- 
2.43.0

