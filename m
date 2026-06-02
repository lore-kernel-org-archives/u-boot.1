Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF73CD6E5D
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D29D84867;
	Wed,  3 Jun 2026 02:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="C07D9o+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B4C8485F; Tue,  2 Jun 2026 20:29:36 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277A984852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 20:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-59dc1714d44so1195826e0c.3
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780424973; x=1781029773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN0MkXEiMOVsN60m7wJcu+gYWR9z6CprtP6k7eoltpc=;
 b=C07D9o+Xt+ZZH/Mr7L1mPTy/cmVnDeMAbIn9n5oQoXvfDUP2RnmpPPhxPqNGF917fJ
 2cw35vSvXCdFB1Ilme9H9uE9Lzc4eQGonq4F68AY08jfGcNDMLd6M07EpyG1+HYdLuL9
 tL59Sl6lJkm99A1fIUAEzXWBLWCIhGvYKsMaA22Q7uoHI5mbIAZHVlk0lL3oaTJTeAqA
 TN+4gCvI2OzzcIOm9P+kZBzizRiORGMGaLnLtifxDa95vF4dQH7zqIlFb2GSuvw69wH/
 YSUtZ0nFx6McHpIG6+4EZY5mvH5aGYBaqce1gi3jnep5eIxC8B1KyvalCW1rpXHXov8L
 hPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780424973; x=1781029773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VN0MkXEiMOVsN60m7wJcu+gYWR9z6CprtP6k7eoltpc=;
 b=mpJ4MwXK1C8qlUMo2yNiZX2ytD5XuUwtAWRioxP78YXu3Y2HcnMWnREmbal6KsJdD9
 GUDeqPiOH29HP+bg8SDy7z6dxsFIUPBc9J+L947JhMSZQn5LVfOKuzfOcXbjJTeQTLK9
 kcmWzMhnV5QlWaMkNoU33HtN6LInhAIok/CmraPjUksTux5zc8MaY2ddgBuWs5W3+kkh
 m6uFZrn04RNRv+I8eIH9Ff5e4V2vZOphvh/0hHzjKAmORaJ/u2pT8qja6gMJiK/My7hd
 ryjDEoBupqmYfoynbWIMC1FA+ROsV5wttD0liI/RZza00+XgA7uEVr2hWeSorvEmaCB8
 H2Uw==
X-Gm-Message-State: AOJu0Ywj0ofbVooKtkiI6+T/wEsJs4RbDrRjTOlrbkbedn+HQgEoPj2X
 2lROqap357WE+KlwDma3tixnwUQPxLZTRf4u0hSu0v9mq5h86FTg7a/36xhUCXCFoBm2v6pcg2V
 paWHZ0mK50g==
X-Gm-Gg: Acq92OHZafxABeUqnavv1OylIKtIDngNSvLejpqwnu0e3TdC9+W+p3Ur79ll6ISbqYu
 nLNrc1xgRPHkJ8Mp8Oo8w3n4OnHmMDeAwzpf6+yyG+ZP9ffwSktkcyUBkorMC+7dQtIpwi0kEhf
 bRiCvwj1GcmZKjXAr7V1zurAJLCRFirDl6mY/iV5/1/kvDs5TJqVopm/SXoEoPir96aDfY800vt
 47IBPO5XH3OqQDwE3RJBcBTNGmxxdpiYUEuvaCeF67KN2q9AKZh2AEY6K99sNgiPaSbQnEiZ8Nf
 TWeC1qPPByIDt6cnYbEh1azBSsS9h1jBw4ahaoI7S2pLGGCAU7lk9vZP+uRHfdqr2N1pAIPvJUE
 VWqU8HKm+tt7KjOpYjHCFNy43AngGb3IH7VI7eKXMZqWSN56qsJkN9cZQ63cp3NnIK5x9fJ5f/f
 cglPTh93NWjiIKKAfGsbVM4QVcszJasbaqDUN9teC8JpKV5cN5tnfFy800
X-Received: by 2002:a05:6102:5491:b0:605:6773:611d with SMTP id
 ada2fe7eead31-6ea1c3b1370mr1208539137.1.1780424972900; 
 Tue, 02 Jun 2026 11:29:32 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b4d988sm52732a12.25.2026.06.02.11.29.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jun 2026 11:29:31 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v4] image-fit-sig: Validate hashed-strings region size
Date: Tue,  2 Jun 2026 19:29:25 +0100
Message-ID: <20260602182925.62169-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260527112338.9811-1-anton@binarly.io>
References: <20260527112338.9811-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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

fit_config_check_sig() reads the hashed-strings property and uses
its size value without validation when building the region list for
signature verification. A crafted FIT image can specify an arbitrary
size, causing the hash calculation to read beyond the end of the FIT
image. The property length is also not checked, so a truncated
hashed-strings property causes strings[1] to be read past the end of
the property. This may result in the out-of-bounds read during signature
verification of an untrusted FIT.

Validate both the property length and that the declared strings region
fits within bounds before adding it to the region list.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v4:
- Bound the strings region against fdt_size_dt_strings(fit), which is
  what tools/image-host.c actually writes
- Validate the hashed-strings property length before reading strings[1]
- Make size as uint32_t to match fdt32_to_cpu() and drop redundant
  size < 0 check
- Move size variable up with the other locals rather than declaring it
  mid-block
- Add test cases that feed modified hashed-strings sizes and check that
  verification fails cleanly
- Clarify vulnerability reachability in the commit message

Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit-sig.c        | 19 +++++++++++++++++--
 test/py/tests/test_vboot.py | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..9b5ab754561 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -452,6 +452,8 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 	int max_regions;
 	char path[200];
 	int count;
+	int len;
+	uint32_t size;

 	debug("%s: fdt=%p, conf='%s', sig='%s'\n", __func__, key_blob,
 	      fit_get_name(fit, noffset, NULL),
@@ -506,14 +508,27 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 	}

 	/* Add the strings */
-	strings = fdt_getprop(fit, noffset, "hashed-strings", NULL);
+	strings = fdt_getprop(fit, noffset, "hashed-strings", &len);
 	if (strings) {
+		if (len < (int)(2 * sizeof(fdt32_t))) {
+			*err_msgp = "Invalid hashed-strings property";
+			return -1;
+		}
+		size = fdt32_to_cpu(strings[1]);
+		/*
+		 * The offset should be already validated by fdt_check_header();
+		 * validate the size here.
+		 */
+		if (size > fdt_size_dt_strings(fit)) {
+			*err_msgp = "Strings region is out of bounds";
+			return -1;
+		}
 		/*
 		 * The strings region offset must be a static 0x0.
 		 * This is set in tool/image-host.c
 		 */
 		fdt_regions[count].offset = fdt_off_dt_strings(fit);
-		fdt_regions[count].size = fdt32_to_cpu(strings[1]);
+		fdt_regions[count].size = size;
 		count++;
 	}

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 55518bed07e..8fa8f2d59cf 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -415,6 +415,32 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             ubman, [fit_check_sign, '-f', fit, '-k', dtb],
             1, 'Failed to verify required signature')
 
+        # Create a new properly signed fit and replace hashed-strings
+        # size property
+        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        sign_fit(sha_algo, sign_options)
+        utils.run_and_log(ubman, 'fdtput -t x %s %s hashed-strings 0' %
+                          (fit, sig_node))
+        run_bootm(sha_algo, 'Signed config with truncated hashed-strings',
+                  'Invalid hashed-strings property', False)
+        ubman.log.action('%s: Check truncated hashed-strings property' % sha_algo)
+
+        # size_dt_strings is at offset 32 in the FDT header
+        with open(fit, 'rb') as handle:
+            handle.seek(32)
+            size_dt_strings = struct.unpack(">I", handle.read(4))[0]
+        utils.run_and_log(ubman, 'fdtput -t x %s %s hashed-strings 0 %#x' %
+                          (fit, sig_node, size_dt_strings + 1))
+        run_bootm(sha_algo, 'Signed config with overflowed hashed-strings size',
+                  'Strings region is out of bounds', False)
+        ubman.log.action('%s: Check overflowed hashed-strings size' % sha_algo)
+
+        utils.run_and_log(ubman, 'fdtput -t x %s %s hashed-strings 0 %#x' %
+                          (fit, sig_node, size_dt_strings))
+        run_bootm(sha_algo, 'Signed config with in-bounds hashed-strings size',
+                  'Bad Data Hash', False)
+        ubman.log.action('%s: Check in-bounds hashed-strings size' % sha_algo)
+
     def test_required_key(sha_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.

-- 
2.53.0

