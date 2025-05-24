Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CE7C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 13:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD3A831C2;
	Sat, 24 May 2025 15:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZK7O735R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F4E83055; Sat, 24 May 2025 15:06:54 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941AD83082
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-861b1f04b99so23474239f.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748092011; x=1748696811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ws53s08/7etMDHXbyxGS6X0VsmBRIyaC68+EFKmZm8=;
 b=ZK7O735RbOcITxkTRG3v/aubnD9t1fdamrXMSQLq4TCnKNTdD4b23vIbetL9yjGE1F
 97Kmczx9iee8LOIsysB5ih12fDHHYIto6IZEGna37d2r98QtC40tnum6H1diW+/ZkZmX
 IsrXqtl90RzTgcJsEe6hoqRuYvO5acd2yUHo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748092011; x=1748696811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Ws53s08/7etMDHXbyxGS6X0VsmBRIyaC68+EFKmZm8=;
 b=JFpzxI3Pt5ncbH2OsS+H44LvceAyXIy/eR6kbYuQq4HxXigKubPWSq2sBwvVK05Y6v
 k/eZwulItmR09HBaCDdEwj2UG96Whd7sVRygb5A9ske1aRSdIxLlHetkZo+p0esf/aDV
 ujURsNi4y4t+LJ6wbQeZpFP0VklSG4IO6PWrYboRhiOZOvy2YHB4gaUoKQDs7oq+fx+A
 UTlh7KZV0XL1IfS6zP9MKWjISHK+mEwfM9WsFaYng9nsCCDC8aI919Svo89/aooTW7NR
 bh2FYcx8W16+e16ecRMxSjxZUrCKN7Vodgp4qNPKNTVoeEE2tOKdEsalSsW6ncns24nC
 xB8g==
X-Gm-Message-State: AOJu0Yx4inr4kZDFpnKSYXE6zlMmz7kQaR3bKWv1J8Kfu9b5+p/ZEpDN
 amGuBoUYuGk9/crDkDYtRw7TbXneY+oo26SKZRZ17S0xhsG/FFTLILyNnp4SGMg9gKe7lrfEf/k
 kqwlHyZyF
X-Gm-Gg: ASbGncvy5IUDyNKWpfmsPaJZ0LtwhNOhafwnPS3oJje+uZUaoIw1vlQ8C+VZpvuXBS4
 +fvVvd6/MXqckmWhvURHM8kUH2WG7NOATpDzBjmecSrfIl74kqn5Pn2kdnsStx5qYe9uMOGL+g5
 KfTM3A2+3Px1aokUjsEL1IXmR/jcB0iQ6GTxVhBgeA6zo1fdFl7qNiv+5Mdxcr3hdPxRWymlxr+
 x8S+WsCaLOsq/Ei7wAnjgtPqARWCZc1uhzGgpzJhrEx6vR4o66Yz+rlBAlwsZ4MVR/n/8tOn0tu
 NgPOFb/KejAw5zZT2qfT+KdCwuEwjkHcEtEdlyIKnOoJVGgwPqLL03jXADyrA5nUHuyM/QGqpuR
 scJ9REdaOPIDi
X-Google-Smtp-Source: AGHT+IED4w1kHzqwkcuml0CHsPo8QbV4CEKiPPCMFjY052/CTx+LKwo59TKhfHX+9WAIHDTXB+etBw==
X-Received: by 2002:a05:6602:3a09:b0:85b:3fda:7dbf with SMTP id
 ca18e2360f4ac-86cbb88b0bdmr322294439f.9.1748092010742; 
 Sat, 24 May 2025 06:06:50 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86a236e898dsm373238339f.37.2025.05.24.06.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 06:06:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/4] tpm: sandbox: Support self-test continue in emulator
Date: Sat, 24 May 2025 07:06:34 -0600
Message-ID: <20250524070636.v3.1.I2fad865da519b36eb7d5879bb9ab552db8055e1f@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524130642.902486-1-sjg@chromium.org>
References: <20250524130642.902486-1-sjg@chromium.org>
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

Add support for the self-test continue command in the TPM v1.2 emulator,
to match the functionality in the TPM v2 emulator.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 drivers/tpm/tpm_tis_sandbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tpm/tpm_tis_sandbox.c b/drivers/tpm/tpm_tis_sandbox.c
index 2bc7dc87ed3..d7341062b31 100644
--- a/drivers/tpm/tpm_tis_sandbox.c
+++ b/drivers/tpm/tpm_tis_sandbox.c
@@ -221,6 +221,7 @@ static int sandbox_tpm_xfer(struct udevice *dev, const uint8_t *sendbuf,
 	case 0x72: /* physical set deactivated */
 	case 0x99: /* startup */
 	case 0x50: /* self test full */
+	case 0x53: /* self test continue */
 	case 0x4000000a:  /* assert physical presence */
 		*recv_len = 12;
 		memset(recvbuf, '\0', *recv_len);
-- 
2.43.0

