Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97C2C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 21:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4FD8171B;
	Tue,  1 Apr 2025 23:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="igj90Tzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4A8817C4; Tue,  1 Apr 2025 23:28:41 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770B381703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 23:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22423adf751so112834545ad.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743542917; x=1744147717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S+jfJeQHZrqPX2druk/cR+3dGL/R0b95xbGl9OmiFYw=;
 b=igj90Tzp++m9uQU3fz2+TSLHvWf0zdtNXqA3afKANDONvHeY1PgAJ0+Khrxc3dMOjx
 42TgAkSmnrCXUYYt6LBDb4uz8TB44NxBJ+Zq/dIjssC1ku0L85j9gWPzfcp1mgBlmabE
 VihGUlipr8H5/AlOvDLpjAaDLKw3K9j4cOz4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743542917; x=1744147717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+jfJeQHZrqPX2druk/cR+3dGL/R0b95xbGl9OmiFYw=;
 b=T+bGAHbb7ufxKDgKDR6Kb1Tz32/QbRrgL0JTR2r7s62RSNebC9JiVdFAGmdOknTSYu
 mJkT3H8TVTiQdQAspYqAMJdqRLWOGOVPF3fnQmGpW0PhjJTZooP6vpYKidfqA9bxtNku
 YXXkQFdsJ1r/1waca3mLkXV0qEAYAeigk3nqwnVbXZUHNFXQh+mK0OMAhMtpwr85p/Gi
 /qob2NEp2Ctxqbr3SJNO6WLInHbEl5GY/PMXDc4i6aN3CfCxvRw1w3dWzZEc6t6RW7wP
 AWzsReyxgDPvMq6XBD8ZLkpBCSdAqKQIsDwnVmBAbCPcA16+tq70D16fXkAorHz3xGpg
 Q5YQ==
X-Gm-Message-State: AOJu0YzF3ZbJirI99zctaEzE6yPyRhKO87znQSwVsfFKUgYQiQO6DxxD
 3PltPiTmMmbBzVr8nFp9WBrg2TPSEC7OJg4YYpczlk9SmjwwwYSu3XejLmLxw4uJxCmPx2NDVCh
 Mzg==
X-Gm-Gg: ASbGncuXhzjGtG5TwzEF/JNIvl4KGLc0fA/Qx9czjAtfyKYOuByF5NsHi8MPJhlYAaw
 ++LwtkI/V7jQklhgqZArhto6vWvjbrQ93OVxTDSjX0fq8NkBynGNbeXbBfrrYJ0Wifok3H905rQ
 zwqllYvk9ZPCcwBBtMo/O5QV+3nsKMU+IejefD8IOrpq9YRJ+b27hzI5U+g9kx3SMejKB1ADKK7
 3LrVyixkvXW5cHnxhAXegbwA2lCD29w/jka2tP8jtgngSODd1ZD3hA2/1f+r7gayQAFAVYUUUZR
 Hq4Krz3a1z/fJubNpDXzZzRN5R4y4JwgRGUk4XsAiPY=
X-Google-Smtp-Source: AGHT+IEoDfqji0I0+qhZfnuEeHq5RJhqXGjyhHcfDohGGpi8TZJt52lOF1i688JlGES4/U6o8826vQ==
X-Received: by 2002:a17:902:d486:b0:221:7eae:163b with SMTP id
 d9443c01a7336-2295c103f2dmr61604175ad.46.1743542917163; 
 Tue, 01 Apr 2025 14:28:37 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f7cc2sm93451165ad.258.2025.04.01.14.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 14:28:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] tpm: cr50: Support opening the TPM multiple times
Date: Wed,  2 Apr 2025 10:28:10 +1300
Message-ID: <20250401212821.1363793-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The tpm_auto_start() function is used in tests and assumes that it can
open the TPM even if it is already open and a locality claimed. The cr50
driver does not use the common TPM2 TIS code so lacks a check for the
is_open field of struct tpm_chip and in fact it doesn't use that struct.

Add an equivalent check to cr50_i2c_open().

This fixes tpm_auto_start() on coral.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/tpm/cr50_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
index 08ec179346e..5b2d5ccb146 100644
--- a/drivers/tpm/cr50_i2c.c
+++ b/drivers/tpm/cr50_i2c.c
@@ -737,9 +737,13 @@ static int cr50_i2c_report_state(struct udevice *dev, char *str, int str_max)
 
 static int cr50_i2c_open(struct udevice *dev)
 {
+	struct cr50_priv *priv = dev_get_priv(dev);
 	char buf[80];
 	int ret;
 
+	if (priv->locality != -1)
+		return -EBUSY;
+
 	ret = process_reset(dev);
 	if (ret)
 		return log_msg_ret("reset", ret);
-- 
2.43.0

base-commit: e0695b08a71e167bf5ce83ae25acfdebca554b8d
branch: tpm
