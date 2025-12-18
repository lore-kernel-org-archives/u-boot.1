Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620E4D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2C00835B3;
	Fri, 19 Dec 2025 00:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ccLSo9f8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141F983642; Fri, 19 Dec 2025 00:23:03 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFDD83106
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45391956bfcso915135b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100179; x=1766704979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+KC+cYhCZyUgUjfldUS0XrURl2C8yj+S9tCLFAkU0Zk=;
 b=ccLSo9f8JVvepXFBfQNh+K83IWEZwi0Q8wTouXhRFJSIeW9/X3Jg1v4QKBThgbWq1+
 zsYWXVffFeVCwlmRsWG7qGf3bemgzxtWfGbQvLwldawKL9tGMNv9CZw2/XkxyttBcj5q
 QYYE7MJFKzl6l5NMKy1QV6t0ePSCYZWP3vt6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100179; x=1766704979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KC+cYhCZyUgUjfldUS0XrURl2C8yj+S9tCLFAkU0Zk=;
 b=C0EpYpxSGOhLUku6DuKkETVqeuvI0kaBARDb/GO59ml1UU7B3zkkKFa1JHXYrbmibo
 acs6jebpOX1wJWXRdq7j/UJEI5GVmCIRlSoiUBEvwGRP6RBsgXGFelqA9V4AV8xr+bPP
 7PVUNhl/78hI8IZ57Rib3r94ifu4NlSOiMkYi7tw0lznl5zPWaLXZ9eDxNKQPk7GN9r4
 5fTWNBvZVoULptQaWXdM0keKpjEGlCLutJyRMEa4nhOlu+TOCB1hVT4id3ZLBIap7Ke/
 aYmiVloDU1MOglYF/dY8z9ZgpkBTiz3E2bG4/rPAOqm3WjsxiwSVEvyEXM8nhFVHZAsU
 p5hQ==
X-Gm-Message-State: AOJu0Yykkt+7u/olRM4LffGse43Lx+WOt7AMVwwcYIaz34wdDlCi4yQo
 6nbi8PxLEfr+fx4d7wLiMiVdkAITUN0sRwKaBA/MjxphiA9M/GaoJ9GvozQaZ78g3LMl7UfJCgJ
 2Ydfp2o0=
X-Gm-Gg: AY/fxX4ZpaM8oPUS34WU7OOy06gdxYjGSvoW1jGY2QztcQ6tULRigUicKAnWpGgzjFq
 r3NPu2bg2ejvsnyJWOvvI6l0/fbVUP5KtuWRFCmOeQoUUzN2jm3ESEnDhMVLdmVkbyJQuSw0WjN
 5bI8/V7Vhh2pyHRz5dZO7hXx63Dr6Bzuifbz3ID/qzjwALnc+njj+oVcx9tkDgLVM8e5YbRnlnV
 MtylFwzx3lxXt9n4+ZTDjo2gNl7ipJ1afF8scWCoetL0VyEAgRt49aq11ysKcBBt0MJtg9BWrVM
 DxqtM2uqwa0p4WOCBs1jnJ34BtjG6O6HQ+0RCvYy/H4gs+EKRQhwXWsseK/zXBiwlYrUBlqybm5
 2kttA+bRSOfnQSb9ScHCMNZ2lq9DE/+h8R06fldcOgfVCAiXOhkhooFtxOaC/k8yAqyhR+9ZIwL
 6cdf8x7CTBMYR8ubxKvuAdkAS4w7fzSybDzFXp408nFsMmxG02orJdtIFDeFCmlLg=
X-Google-Smtp-Source: AGHT+IEZgbzb4OgjkfgOkwC/qok854DcJVSqW6GfoYtQe/YtjXVjgnNjZ4mtLf/xY19+6+5Mc6JUFg==
X-Received: by 2002:a05:6808:c1b2:b0:450:c09:92aa with SMTP id
 5614622812f47-457b20eb9c6mr677911b6e.12.1766100178893; 
 Thu, 18 Dec 2025 15:22:58 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:22:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 0/9] Update lzma to current version of LZMA SDK
Date: Thu, 18 Dec 2025 17:10:12 -0600
Message-ID: <20251218232255.3934258-1-trini@konsulko.com>
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

Hey all,

A long while ago, Darek reported that our copy of the LZMA SDK library
is quite old and so vulnerable to at least one possible security issue
he found that was fixed upstream.

This RFC series does a few things. First, we introduce a Kconfig option
to enable LZMA's size reduction option, and enable it on
gardena-smart-gateway-mt7688. This is not critical at the start, but is
as we move forward. Next, we remove some files from our initial import
of the library that do not make sense to keep in-tree. After that, the
next 5 patches update us from the imported version to the current
release of 25.01. This is split up such that few have the very few
places where the update requires some slight changes to our code be more
visible. This in turn is mainly that the file that says the license has
changed, and that we need to guard around some unused upstream code that
also conflicts with our own code. Finally, we restore the spacing
changes that our copy of the code had, and then improve things by adding
SPDX tags to the LZMA code so the license is more visible overall.

I've marked this as RFC in part because I plan to follow-up with v1
shortly where patches 2 through 8 are squashed together as they're
mainly separate right now for ease of review, but the split doesn't make
sense I believe to preserve in git as our changes are so isolated.

Link: https://lore.kernel.org/u-boot/CAC7rXdTb5u5pzP-mr_+pddCxzfcO8Vm_t-=_+5wxRitMjy6-JA@mail.gmail.com/
-- 
Tom

