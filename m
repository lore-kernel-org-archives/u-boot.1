Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E128EC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 04:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1928D88031;
	Wed, 28 Feb 2024 05:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b1Ly9Idn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE2D88019; Wed, 28 Feb 2024 00:57:27 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D527487FE9
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 00:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso4500051a12.3
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 15:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709078243; x=1709683043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LMLlyxla8Ad5TwJfnLW6WYTzIty0z6SmsbL54dVR91s=;
 b=b1Ly9IdnQSLwVogIyIxKQrQlvSoLMu9uflA6esYLYT63mKKh4yi17qliyTQIKSLOKn
 63h9noUjVLNJpvjmJ3k2S9wcGUXgOYd9TxyJPCCrMX/8vTFtcaP22hOX0v1uZN8Qwahz
 66p00H4/vNabCeg1XJOnTpJsrtDV1NDHk4qXCYF+B9yKFGpNdyjXmksTJbYFdeMmcOZz
 Om5HNqPM6JOdKW94HcBvJHPEaMqIuyYF/e+u+fzXQ9sjf6XSkJL9yvph5auHgk9T1idv
 i3+OywA9Hbxf+wc5BFvSie4pwTPCTkcOV0sVDvvVehEnSTw7SAw5xcbspUoHmyFxDheL
 Qb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709078243; x=1709683043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMLlyxla8Ad5TwJfnLW6WYTzIty0z6SmsbL54dVR91s=;
 b=R1sgWdNAFV+BeCWd+89erT+EqTgGzqGvsxu35/+wsz6aztg7LW8gqLWItpqYhpMwPJ
 dVSUUJ0Aj8wobH1vRphnSVzNXyI8kx5CxZLmLBm7D8DOH2NAxKrITLJot9rc/nFZUsdK
 JvS78K/z2zg8ns20YV1FVLbxkix29DCtrNhFMkcoLN8KOaWAZPQ525V3fJqDaO921ROg
 16WlSrLmIMLmhXXg9wEhYe+TB0eqmmY7kd8qspHXoOYPyBgWKkQYCzS4pL2FobGYiGfS
 aPz6hLY6L8NROsfoTyfCxQHS6T9Ui6/WKoNqukmNGrkQylSRc9RqkKql7PvrR6CYzRue
 9A+Q==
X-Gm-Message-State: AOJu0YyQG7xckvrTbAtSx5KNYYVBFHC/qPUMuhrzhNx6ne0WN2jFNM+2
 8nXicz/4lNf3AmQRxi7NhjvfmJwDu4LTPYLG991CrCSINQ7Kywt18wE6jAhb
X-Google-Smtp-Source: AGHT+IGfKa+PfOAkjQxdDLcsc2lEY59fRdVYY3uSh1kfrX3b6goNvht/Qhg4NqDXkxi2+PUFVFG6uw==
X-Received: by 2002:a05:6a20:9f4a:b0:1a0:ee90:7790 with SMTP id
 ml10-20020a056a209f4a00b001a0ee907790mr4501226pzb.48.1709078242618; 
 Tue, 27 Feb 2024 15:57:22 -0800 (PST)
Received: from localhost.localdomain ([12.125.190.90])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a17090a2c8600b0029981c0d5c5sm145917pjd.19.2024.02.27.15.57.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 15:57:22 -0800 (PST)
From: Bob Wolff <bob.wolff68@gmail.com>
To: u-boot@lists.denx.de
Cc: seanga2@gmail.com, pbrobinson@gmail.com, Bob Wolff <bob.wolff68@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Check curve_name for null to avoid crash
Date: Tue, 27 Feb 2024 15:57:03 -0800
Message-Id: <20240227235704.48386-1-bob.wolff68@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Feb 2024 05:09:50 +0100
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

If mixed rsa and ecdsa keys are specified in dtsi, an rsa key can be sent
into the ecdsa verify. Without the ecdsa,curve property, this function will
crash due to lack of checking the null pointer return.

Signed-off-by: Bob Wolff <bob.wolff68@gmail.com>
---

 lib/ecdsa/ecdsa-verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 0601700c4f..4d1835b598 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -31,6 +31,11 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	int x_len, y_len;
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
+	if (!key->curve_name) {
+		debug("Error: ecdsa cannot get 'ecdsa,curve' property from key. Likely not an ecdsa key.\n");
+		return -ENOMSG;
+	}
+
 	key->size_bits = ecdsa_key_size(key->curve_name);
 	if (key->size_bits == 0) {
 		debug("Unknown ECDSA curve '%s'", key->curve_name);
-- 
2.39.3 (Apple Git-145)

