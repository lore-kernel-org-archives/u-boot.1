Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671DC021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 116C2803CC;
	Tue, 11 Feb 2025 14:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CBvCil6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EA680824; Tue, 11 Feb 2025 14:55:38 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8604A80077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C2754013E
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739282131;
 bh=xn5+BSDb4dR9OnoVAvAwBESMsCyvaMC/lTCPmyIfU2M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CBvCil6Id/KbH8JhbN2XaNTrnHmNfaEH9f2HJBNvHRgWsP0KHH7OKtCA6IJFJqJYR
 uitPdAo65urBWXYTyVdKxkP7e1GpiuelmV6iW/c1xRaB5/CD1EX6SfClFYFTQUwnnn
 PVx0f8T8y5eH8gYckrBV48FApc82Y1Z+EwPbTqb9aJ8mKf0eWw/d3bsCRBf77XW0Tl
 t5eohtpisSjRm3LyuRhqx9pXBqN7VFDNvCN2WWGuHOcGCiC5SyYNwWK0oS+5NSMscs
 kNR1Qc3sZTHxFmdXEaohEgRGTL2Me164YQ89YWsBopuLq2ptL7erLqhBlTflpQzxLS
 gYtd2kBeJSpiQ==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38de12153d4so1255345f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739282129; x=1739886929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xn5+BSDb4dR9OnoVAvAwBESMsCyvaMC/lTCPmyIfU2M=;
 b=Kj3fOGa7xrBg19mWfLzr0BpB+77Q6NNGUpaE6AuSmV0aSc/NCs8lYEMX7s2mM71zqX
 KWK++6TTFZRosxk5BymeuASdG8ElI4DLPiqOOuzOcjZgA3XF504QQutpzoCGD7rYh1pm
 15h6oMBnsGRs8zzYikR3NHi4YOdxuXHA8djz4dj8GUFBwrf9a9NxaaviLU2lHsxrPugM
 XAyzgbBiJez3Elqf2Q6XfetA23bJFHvEfR4aNpzJyv6iY8z9xUv/uJ5029q5smxggcX5
 omSdBR3EMIJozeGR1iAs5+qZl8umXOAV9m2rT7Wb01uoEs5T3Bh7aiCFOxr2K5dtyxHt
 kIbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4WMGK7QZr0tFzHwr1Dzsl81K2PKGKcR/yti6BU3d0HB6ADWUtdAOWq3zz7bBT7imvd/pufRY=@lists.denx.de
X-Gm-Message-State: AOJu0YxegP4PP+hYG7lM7p7T38M0gzOchvzDucH3sYyA96DpWNQl8nPy
 adsr6PuoQsh8PY2rInEXaQq6c7Tw2p6YqAKaix6yedcn9JlSWcER5p1F+FodknNpI32d6RbOf0S
 xyx4hQvnI6OsuL5fx/VhdczB/yCvx8x5lE04AZjguUb62HICPUAgAEgzl1+ayHgqWr9A=
X-Gm-Gg: ASbGncttpLU/FXJZHNAfIFwz6ft2TFgrxhSMe/94Kcy/HDGFAL5noNnLB6S7Wm7XcUU
 rCA/umwog2wreRfl2teCkDq6IwcNK86P7SeGE/nyc7k6svFt2EAYXE3Dve5l4nAd2iIlT14jv7y
 5Ta76lbRRimnX5DAZ4P/p+lMkeWrqg7BxdXoLZ/f0mAS3A597j3tZGYMbkQQ7fSearStttKgxBl
 blJ1Gsp7qob7v1VlYQ28f51SlfMNs2M/U7A1hz8XxBRVaO/SWmt4bY9Wq28S+/GhbXfPspcjdnV
 M6p6BfA38AehNygN5HX2OasomL7L2/XM413+GmGDwOaQ+eJDK2VRmUfr3I0IHmi8+tOJBLNSBLv
 ehIlwE8A=
X-Received: by 2002:a05:6000:2c2:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-38dc8dd9d6emr12101652f8f.17.1739282128764; 
 Tue, 11 Feb 2025 05:55:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYVXqx9/nEu5i8xootEQ1YwkprXhuKO0m6jEjGGTYXBU4e2TZyOFJOEPvPS8KtuHgzTB1/+Q==
X-Received: by 2002:a05:6000:2c2:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-38dc8dd9d6emr12101629f8f.17.1739282128346; 
 Tue, 11 Feb 2025 05:55:28 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4c8ca52sm9198639f8f.89.2025.02.11.05.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 05:55:27 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Dahl <ada@thorsis.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Rasmus Villemoes <ravi@prevas.dk>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] tools: use cryptographically safe RNG
Date: Tue, 11 Feb 2025 14:55:22 +0100
Message-ID: <20250211135522.47868-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

The PRNG implementing the random() function only has 2^31 states and
therefore is unsafe to use for cryptography. Use arc4random() instead.

Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand")
Addresses-Coverity-ID: 312953 Calling risky function
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Directly read from /dev/urandom as there seems to be no common
	function for BSD and Linux to do the same.
---
 tools/image-host.c | 53 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 84095d760c1..e6de34fa059 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -364,33 +364,46 @@ static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_nam
 	return ret;
 }
 
-static int get_random_data(void *data, int size)
+/**
+ * get_random_data() - fill buffer with random data
+ *
+ * There is no common cryptographically safe function in Linux and BSD.
+ * Hence directly access the /dev/urandom PRNG.
+ *
+ * @data:	buffer to fill
+ * @size:	buffer size
+ */
+static int get_random_data(void *data, size_t size)
 {
-	unsigned char *tmp = data;
-	struct timespec date;
-	int i, ret;
-
-	if (!tmp) {
-		fprintf(stderr, "%s: pointer data is NULL\n", __func__);
-		ret = -1;
-		goto out;
-	}
+	int fd;
+	int ret;
 
-	ret = clock_gettime(CLOCK_MONOTONIC, &date);
-	if (ret) {
-		fprintf(stderr, "%s: clock_gettime has failed (%s)\n", __func__,
-			strerror(errno));
-		goto out;
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0) {
+		perror("Failed to open /dev/urandom");
+		return -1;
 	}
 
-	srandom(date.tv_nsec);
+	while (size) {
+		ssize_t count;
 
-	for (i = 0; i < size; i++) {
-		*tmp = random() & 0xff;
-		tmp++;
+		count = read(fd, data, size);
+		if (count < 0) {
+			if (errno == EINTR) {
+				continue;
+			} else {
+				perror("Failed to read from /dev/urandom");
+				ret = -1;
+				goto out;
+			}
+		}
+		data += count;
+		size -= count;
 	}
+	ret = 0;
+out:
+	close(fd);
 
- out:
 	return ret;
 }
 
-- 
2.47.1

