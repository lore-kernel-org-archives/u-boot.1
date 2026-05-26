Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C52CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 03:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0973284958;
	Tue, 26 May 2026 05:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RehzLltV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D15848E7; Tue, 26 May 2026 04:09:53 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58756846D3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 04:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F1F953F2CA
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779761390;
 bh=oaaOSUCZjb6wWcX+3uSPzVdbg6nJdhtZnOgqYKObcr0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RehzLltVieaSC9gwWb/smnnqtQlEtoek3VRF5i5nrQDVsgBqMMcELJrudLYZWt0yA
 8RFFFKSYFDIOMkPvQQ2NdL3KeEpGHoIK4J4oSMb01T9x1P8xI+lffn47qfXNjdU98I
 11L7UOk9mxTQHvGHg2nUbpj5w7ivu9XPQQV//Cgt5kGzqwHC5/CgOufky9D0R8eMLR
 aaIrbUJzxrh3OPfqp62+gmKES6uLrCZeLLfny+msBYHow8WbZHPa2SURKqhjJL2SHo
 9gY9xsDJ7VXgrRFV0lePujeTfRpudfCqYVj/701dectMY3c8CnWZiO1lBf7cY1Aw8w
 hv7VYzDCH76dEvn4GoinNPo2Lf9nhfr8pSevOUtcqT4e8MOtGSkVkXi9rNqB8V+1hL
 8Jq5Ll6euNrGgSx70i8zls8CRX/8duyULq6fYK0G0c/a/Nvo2cESqYjodLfEFfTgFV
 o9cXKdMDediMMQ3Mx+ycUSbmkL07+AG2an0bZbJxYp9sgpVRjRYmUfj29tctx7EdW5
 Ei8uDD6vAE7IirEQnHt+N6kukD2VoU3GIMt5AtRySPwF7RRGyeFTH8hmWBhw69xjte
 0NVkgQrccpj2Aah0m0Q/2cnL47xj1HBRqb/86gyuhkJZhjNcusvREw8VxdQaX7Oztv
 VvOvcuKZSMYfvfN8H4b99rNg=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba054e0304so88521705ad.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779761389; x=1780366189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oaaOSUCZjb6wWcX+3uSPzVdbg6nJdhtZnOgqYKObcr0=;
 b=fdzaUBal651H7YYTFPqhLW2e4tFb2qf6J0tqRTDX9OBPldH2rbPPLayHAGuL0nHJ2N
 O2DELcUdLh9GNRpMEytzJa1ynuz8B0cPXAJlecWD9GvzgBnXcKvpQe2xzlZqyr3DWZmr
 7nHaow7zHRP+GTG9WqqpAIIoSkA7ea7oIDebQrLcDsm4WExf4Mk8fJlCmyQizkogUFs4
 YTWMgKJcHhhzV5OfrtZtKp12TDbSJF01KPZTZ6lOVCb3vtNtcmFCMqDM02KxoreWhb7R
 nGmRv0j7qNBVkwZdUV1XoWz4sBnti0IDk29P4RSDI88v5c8MDip+3MZFWaV1idf0mK5n
 E+Wg==
X-Gm-Message-State: AOJu0Yy+FLNj/Y1waw2eMJTnzAcGgYoSvI+T16ehS1JUf4HmbstYlRow
 ZX8RM7SFZKJhTLOZW2TQlb8gDZlfyD68G9Dkw3MXwV5xAXtYo8VK0BaYFLUSSQ+4mSZan2I9qkv
 zeu945nlPe0hEZd7KwhGCR3+H9qorkv/bjCqKIm68HCDyiF5IQvzZ7XgeO0IxwwO2xbDLnxyHX3
 1B8wcWKM4L
X-Gm-Gg: Acq92OErZVlxtAkNo0IWjdMkqEi3IkfJ9nbFWzMYpKXEWIfgemGTfNja+68Ro24S+Ea
 gvv97Yw6iIDvvNmVOSYJ2llrmGQn1x4J4kaE64aia18cSsmSHmBEZbSOFrUWZ0he/fiiiIULFE0
 /TGqeVKZ5OC6MKtXQ+SsFFtcuqcyYAMnoTlxQwiaTECNJT8NoI+Jy8cwVFWCE/bKn9I5sYfelr5
 Fo3cEGyjppP9vbTORldl1u7AflMd1emYq03nnBZ5bIIbIvL+uvhnBSkaRX2bHpsWZKNmgFFUB/7
 WkL5AILpqIbHB2d4ise1mc/GXdDNe2JyZ66kWdPogbx1UHvofzlbXaoHFX2RjV65CPN1f0O1EFL
 zefn3sLj8ifG8vqOxS3zsH00zIV8fLkedqyORgFX0DXqQo4xrERQTjm9gu+Ql55GYxDf2mD0YF4
 VQ1FYjyA21i1GtuWY=
X-Received: by 2002:a17:902:ea09:b0:2bd:d6f1:3388 with SMTP id
 d9443c01a7336-2bea240dd66mr188738405ad.28.1779761389418; 
 Mon, 25 May 2026 19:09:49 -0700 (PDT)
X-Received: by 2002:a17:902:ea09:b0:2bd:d6f1:3388 with SMTP id
 d9443c01a7336-2bea240dd66mr188738175ad.28.1779761388983; 
 Mon, 25 May 2026 19:09:48 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695b2esm101522015ad.4.2026.05.25.19.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 19:09:48 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Weinberger <richard@nod.at>, Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v2 1/2] fdt_support: bound serialN alias length before copying
 to stack
Date: Tue, 26 May 2026 02:09:14 +0000
Message-ID: <20260526020917.8438-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526020917.8438-1-aristo.chen@canonical.com>
References: <20260526020917.8438-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 05:44:15 +0200
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

Reject lengths that exceed sizeof(tmp) with a debug-only message and
return -FDT_ERR_NOSPACE. The fixup runs during fdt_chosen() on every
booted kernel when CONFIG_OF_STDOUT_VIA_ALIAS is enabled, and when
the OS devicetree is not signature-verified the property is reachable
from an attacker-influenced blob. Using debug() rather than printf()
keeps the rejection text out of production builds so there is no
.text or .rodata growth on space-constrained targets.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/fdt_support.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 1c215e548db..bdf651364b4 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -160,6 +160,12 @@ static int fdt_fixup_stdout(void *fdt, int chosenoff)
 		goto noalias;
 	}
 
+	if (len > (int)sizeof(tmp)) {
+		debug("%s: %s alias path too long (%d bytes)\n",
+		      __func__, sername, len);
+		return -FDT_ERR_NOSPACE;
+	}
+
 	/* fdt_setprop may break "path" so we copy it to tmp buffer */
 	memcpy(tmp, path, len);
 
-- 
2.43.0

