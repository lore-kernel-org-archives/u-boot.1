Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7D7C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BAA082B00;
	Tue, 20 May 2025 14:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1NPprNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C957382AB9; Tue, 20 May 2025 09:58:08 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9736E82A4B
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 09:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-231fd67a9aeso24979905ad.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747727885; x=1748332685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zawZKgQCvo3X66Pff3rWbs27XySL3Ytzy/n5l4fZD50=;
 b=A1NPprNYNsLdw/4O4jcQcGnCdA9TlpOai7ve11tFnvrCn0JIBjqo1XVRcUK43s9Ire
 jh7+Evg6YU4uynFSH6lKrfh7NGCUY9OrBizBOJsML3bTcgThoM6CzfcXHbSkfRh+4Uc5
 3mUPKEBmCw+mtaVFNG+nIWElcNogvPxykhbdaKJ7liQjvqr0JtkLLNDFmMinNCQsmH4W
 bjnrIj6p+SOmaXmnyfSyK1mdx2JKXqbEfRwvPGl2cfBTkJvfWNO1avCB/lkWUeXd+CEx
 csU6adOvNrE8QGMMBIGYrHX3gv/4WjiU1dt1R9a04YyiZOBWVFE8cxgS7Hw0T5gfuFM8
 uDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747727885; x=1748332685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zawZKgQCvo3X66Pff3rWbs27XySL3Ytzy/n5l4fZD50=;
 b=BONgUg3wGcsAuFMtksUoihBX/jwfwBpY8D2OPjWmJmBxqLfGHIDVjI0caaCa/k0m+3
 IO6BNf3/8pRlEyYtjrEmMGNJEYy2jfftiyn06S0ArRvYsgdqbD/LzI/JeESYyRAw/V5a
 1I+ahFjpRTSt5C9zqvPlA3A1HyPLXSii9YxXJirpIjyxOf1c8cR7UIvMh05FOA7wrPyV
 uSUnpU94RWYk4bX3Zs3Gvrh4krUVJ/J/+KuNM5dpyTtquTKFY4GXdUOFD86lpPYhdbkj
 8knLQt4ymY6AWcB7hf4qS7iiHX9WZVzHsAh3q2w4wbNYXj+91NKAoj189NY/DAI2d+Vl
 oiTA==
X-Gm-Message-State: AOJu0Yw2jN4KEMKAsf80tggRfqP39YfUQZk/n+UzwpjONNKjqzL4wDUb
 r1FnvO6Pja3bynal8f0nmyrJPSFRGTdXA+9fiRC5aNpVgKk2i5o9XVZx2FpMSjfD
X-Gm-Gg: ASbGncsGQgIisSm879rQaDU67rowW8b4i208Xk9tgcyz1oZmoJSlepCiWC7MPZNYN9n
 PAUvvo4pE4fyISx5ZtFdYVZe6QMXHhj4Qg7OI78QEBNGTxBTNcqeymRQt1DRWmoqTsySImE8uq/
 AI2Y8/YfAYI+IO8m+FW8qKLIB6FA/OFgoUJJ63E2iY9UeD55BZyVA/Zo/k/h80IVcfKVMcn6D9n
 qBlcj2Eu3ngluTweRT7q0biP9g0+tPtPPEOoaBdSfkLkHc9nJbybV8NIPSxME5mgD+xj92k7Afq
 mYRVNJk2QpAD1TIpAA6e4cfPFmvTWgH9xNTrzmEBRFRzALX7zHa5t8drWT5Z5fAKosskhIaEIsB
 HoGPLqPVZnZwBm6PKSExyjzDEuK/xx1wgEmafFOCVIxeQKjs=
X-Google-Smtp-Source: AGHT+IEBtV44t9sR8Xzu7cG87l9WOjd4N+zkRBdPdOSH+9pQdRgeR/qIdoLLXL0k7M/4tMFOBabJdQ==
X-Received: by 2002:a17:902:da91:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-231d4ae1de4mr221010985ad.3.1747727884630; 
 Tue, 20 May 2025 00:58:04 -0700 (PDT)
Received: from noble-leuven.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4eba49esm71544795ad.163.2025.05.20.00.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 00:58:04 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v2 0/4] mkimage: validate image references in FIT
 configurations
Date: Tue, 20 May 2025 07:50:02 +0000
Message-ID: <20250520075735.132308-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505100852.9364-1-aristo.chen@canonical.com>
References: <20250505100852.9364-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 May 2025 14:28:13 +0200
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


Hi all,

This series introduces a validation step in mkimage to ensure that all image
names referenced under the /configurations node of a FIT source (ITS) are
actually defined under the /images node.

### Motivation

When using mkimage to build FIT images, it's easy to mistakenly reference
nonexistent image nodes in configurations (e.g., referencing a missing `fdt` or
`firmware` node). Such issues are often not caught until runtime in U-Boot.

This series aims to catch these errors early during FIT image creation by
validating the configuration references in mkimage itself.

### Changes in v2

- Use `fdt_stringlist_count()` and `fdt_stringlist_get()` to handle stringlist properties cleanly
- Validate additional properties (`firmware`, `fpga`, `script`)
- Improve error messages by including the failing configuration and property name
- Refactor error propagation in `fit_handle_file()` as a separate commit
- Update all affected binman test DTS files to include the missing `atf` and `uboot` image nodes
- Add a new Python test case under `test/py/` to ensure mkimage correctly fails when an image is missing

Best regards,
Aristo Chen
