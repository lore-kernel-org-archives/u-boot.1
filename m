Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9805CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158948489E;
	Mon, 25 May 2026 16:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="O2jH7rQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1188460E; Mon, 25 May 2026 15:26:48 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EEF846CA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 58FCB3F618
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779715606;
 bh=vTpEGnAhye4nMtR/8x7FXdeNAa6WGVwlZk1oZIKazbk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=O2jH7rQaMJpO+wgaYwjeFmCMapLU/I1oBoQf5SEsjIYqhetT3fmXFT2Fy+WCassDp
 Jtt5QV34YUmNe8p8McfKLYwO2vr2BK8SloCRrDh5pO7ybE2CzFBchNAARLTle8edEg
 r8vy+AMvYsROB75LqCweDN6Eelhm5fO2qLPKAQj3MqWmS0L6s6ySL+OzkS0TlAOvWY
 WZXxADRL7tR5DmPhBYPDYYYl+yQ2YyxVb6yohiNFxzbgoc9hAPVkXzjjQsXaNssbHM
 LETgCEXt+JCXxRWiGVx3YoyS7MRtaWz68Rr/2zEYqHO4AeHLscaIEgSmmChSxnpNCE
 uKQAgr36n8Pkb534En1XeQQM6m+swNyMtKY3+6rXCwcqcZv6v9Wq2UKe6/W6grYmff
 WCh/BQxAmh8n3HM31iHDT8RNHDhgo4W0eXGkMd/psIQIdLa83Yh4QqsfZpKfbp4NyF
 sDJflSq/imFqm+Jd915JqUpXG+1FP7BDVWO15cyH1M+zA/QWWzSSWarjRxh3Tk8GLE
 STKMwdFIhkUrQAyCwJ/FEtx7IPzIW2Au660a96IifIhatL8P/NLa4fp+d4Xxxs4SJN
 B22OpZjQRi6bXawNiVNwulwMZcYl0IGzH+W1v71Ax6HsI2ph1bqJKKd29tCYXgTX5/
 viBaErH0H1qU/E3Crevmk/MI=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-83836443305so4656656b3a.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 06:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715605; x=1780320405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vTpEGnAhye4nMtR/8x7FXdeNAa6WGVwlZk1oZIKazbk=;
 b=OC9DDBqVQYLo6E8Y7UH+HkKp2WkkKA0JRyKgn6x+IkYsEKKFj4Q9uq2bzwlswYrjYt
 DUS9T2wbdF/Ek1K7azq5nQQfzRRngeMGdDbf/7GMAFhkVrYUcCFgj02TFHFFqQiMCNKB
 NaMVYxxExDW8dvY6h+Dllt3ZNkj94cujek9ViDtclMgy5pzmEbu1VU9I0Md7B/KYmCNW
 XIQWChMTFKpvYn09kb9VEG4VekbSKGnLZLOBb5d8+ulkomUJzvY738c/8bctCuCT5Igy
 RHWx7H0pxpg7X5AVZe37TLWYQQJqicTwdVqtdPdCHcwrdOb0RJX+aKbu+HjpHtUasb1X
 aPdg==
X-Gm-Message-State: AOJu0YygEM2bgTczWFjIGy1S808rGi9C5MkrdJ1L77PtcC4J9QDOxuY7
 LZ/esve6Kn/OLX+05WNaGq1utPZfJIVM8/p3VHAhup0E/JnMlvaraUt9jIavIZ5k9kiiIKcmkWo
 Fnb1YeaxMJP9Bqd0g133gJrH+xpgJafFJC8jxRwinTOXx/3Rr1FZnuklwwi6MOsd/7P09Z+zcuc
 t7z+lXeyNn
X-Gm-Gg: Acq92OGbL3RuE5kBdCy+Y7KO7RJCZNDOv7uICCl22JVjKxsvjzcAT+1eVM5jTBSw3mE
 rp5HhK3sxu41Ku/R+jAqjYIrhj1RsCYGER3/cSTsAd3JnpPpK6WuSTXpR8n0EkoaaPcd7an/U5V
 ySuRfVUEK9ra3SN8vcUlQi65hgakyMitdLMZnIJGEu3CWGvYnj1XsPxX5PagU3IYdLnjt6G19Dq
 2bTmox+Thvkh1NU36AONDbqYvWPTna34aTDAZKjPBipyalk+UxACYzIDoTk68XYj0I4fV8fvAci
 4NDgAYdpebwdNxru8Iux4Bb8587885J/ZnZieHgxqf2iqvqoQQ0S0RzqKlQoY1xC51NqBQx5Aae
 b+xdikDSSEPo9lswk+1Tzxu18zEKLMQegz2suypR5C/93NyQV2F2gN9fUUDjQUTVFPpAMG8UmkC
 /fBjKERMqc8425Y7Q=
X-Received: by 2002:a05:6a00:3a17:b0:838:127d:a168 with SMTP id
 d2e1a72fcca58-8415f17bdefmr13628866b3a.17.1779715604855; 
 Mon, 25 May 2026 06:26:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a17:b0:838:127d:a168 with SMTP id
 d2e1a72fcca58-8415f17bdefmr13628843b3a.17.1779715604478; 
 Mon, 25 May 2026 06:26:44 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841648a2bf2sm8806449b3a.0.2026.05.25.06.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:26:44 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Adriana Nicolae <adriana@arista.com>, Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v1 1/3] fdt_support: bound serialN alias length before copying
 to stack
Date: Mon, 25 May 2026 13:26:23 +0000
Message-ID: <20260525132628.755148-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525132628.755148-1-aristo.chen@canonical.com>
References: <20260525132628.755148-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 16:46:18 +0200
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

fdt_fixup_stdout() reads the path stored in /aliases/serialN with
fdt_getprop() and then memcpys it into a fixed 256-byte stack buffer.
The length returned by libfdt is the raw on-disk property size and is
not bounded by any console-path convention, so an oversized property
in a malformed or untrusted devicetree overflows the buffer with
attacker-controlled length and contents. The "/* long enough */"
comment next to tmp[] codifies an unchecked assumption.

Reject lengths that exceed sizeof(tmp) with a warning and return
-FDT_ERR_NOSPACE. The fixup runs during fdt_chosen() on every booted
kernel when CONFIG_OF_STDOUT_VIA_ALIAS is enabled, and when the OS
devicetree is not signature-verified the property is reachable from an
attacker-influenced blob.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/fdt_support.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 1c215e548db..3e9445603ff 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -160,6 +160,12 @@ static int fdt_fixup_stdout(void *fdt, int chosenoff)
 		goto noalias;
 	}
 
+	if (len > (int)sizeof(tmp)) {
+		printf("WARNING: %s: %s alias path too long (%d bytes)\n",
+		       __func__, sername, len);
+		return -FDT_ERR_NOSPACE;
+	}
+
 	/* fdt_setprop may break "path" so we copy it to tmp buffer */
 	memcpy(tmp, path, len);
 
-- 
2.43.0

