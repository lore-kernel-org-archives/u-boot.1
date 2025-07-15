Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8C1C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5963D830EE;
	Tue, 15 Jul 2025 19:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="km4/LNry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6018309D; Tue, 15 Jul 2025 19:20:27 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F33F8309D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c14138668so2158859a34.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752600024; x=1753204824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJhzmqVpi+eFtMv4M5pLZFl6IrtC0hQzuqPvis3Y8JA=;
 b=km4/LNry/HAEzxVD2MsyL/Nqo+IVsM5gAa83tTrIxLchNyyiwZYPH8OP4SiZfEZqrQ
 EFNu7/kJMPJSK3NuRSMJgVovRgfdYRQ4EFFS0n7W0oq4nE0yHze3jRKnqP89+xX+rkbO
 Xyhzw13/eEc8CM0dY7CMwY8y4cSPThVybEQlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600024; x=1753204824;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJhzmqVpi+eFtMv4M5pLZFl6IrtC0hQzuqPvis3Y8JA=;
 b=b5a8sez3HGNaKyy2IcaYBlf0kuk4dtDzz40Gbp3x/SXnU8AVGit6FzmAf8kAXg/CSM
 g3BWnYIG7TE9Vo6y/BkP1qcWBpUA3Af3+6/tiJtuc71YBnYaJy91ErfaMDHWdeNSxG5F
 SPhuVcc3vLNWbfK5VqJQD6OY95V2Gfw1x8ngjmPyfpr2fHMRzH9bz+4W6xMgYqD1tcl+
 caLmpB+f7tShSo4l6Rbd5VMGmUsb2VxfHFVmnU4pG6qjImYH5kVe7eCFWaCz19rDqJEg
 CYFy6vkliEEMwE82c4n+VxrwYkACBwWXSsHeCFLzH9RRUZX40WKfeF6JFfp1vdsmlFDK
 9NAA==
X-Gm-Message-State: AOJu0Yzx94N4RFPK67cMfDdICgpUQU1/WI7kzwui/znRD91MPtoXL+aA
 /x9NUH+k5hbUpbVdPaP8kvxbDWPUT6IDgqEydfbR6fSzrLIZV83B8ttCSdkSKW2T1r2DyzctFBX
 7EUreWlk=
X-Gm-Gg: ASbGncuH1ve+FkH+uvbcmEhxQnD/bBaikLR0WZ6PzsJgNnd5As6vh2zI/9dGVOkMyNs
 meJUwIk+5mi9Z/w0WfOHNeqj2ehQrk8xfCYK7K+ZFj37qIWxgSzn0MctRHCu7eHrY/EOdAX7TKO
 bh9g2Jwib1puBVXThQwa33u19XeUhEhsHUDlzaHUapcVGRWpbL2Oz9PESG7ppwOyjfhSwy7vbhS
 pVmlgLvCwn5cxHc1RofYEDDQqq/EDmz7AZf7UT0Rp7HSH2f6voqzMSGKpBJ20aOXWWVr67Zn14M
 P9OnL+or1x5WZWIJy/De4syuONmfzjZmKicrfaDCKwdIkNoEm9KakZUQJAAX30tmBNcL//duTmM
 tN/YE+zLE28afrEpc3vAoNIVp3Ad3faOgwNhYs5aXGexKdnGdzrVLhJ8sl1Xxc5Q4NA==
X-Google-Smtp-Source: AGHT+IGnqXWEYhe/U8idSr3/mq14YqHUlUEAZ8xYhOgtvmmlrSu9/+yEGzlNH6OxRL2Y87ay36mfEA==
X-Received: by 2002:a05:6830:7307:b0:72b:9b1f:2e1d with SMTP id
 46e09a7af769-73e649c5ed2mr196178a34.2.1752600024181; 
 Tue, 15 Jul 2025 10:20:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6142b0961fbsm988894eaf.35.2025.07.15.10.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 10:20:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20250709083449.656724-1-ravi@prevas.dk>
References: <20250709083449.656724-1-ravi@prevas.dk>
Subject: Re: [PATCH] tools: mkimage: make size_inc a signed type
Message-Id: <175260002343.441891.8572271709599005937.b4-ty@konsulko.com>
Date: Tue, 15 Jul 2025 11:20:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 09 Jul 2025 10:34:49 +0200, Rasmus Villemoes wrote:

> In the Fixes commit, I initialized size_inc from the return value of
> the new fit_estimate_hash_sig_size() helper. That helper may fail and
> report that by returning a negative value, but I overlooked that
> size_inc had type size_t, and hence the error check doesn't work.
> 
> Change size_inc to have type int so the error check works.  Inside the
> loop, it is passed to another function as a size_t parameter, but
> that's fine, because we know it is non-negative, and its value may be
> incremented in steps of 1024 and is capped at ~64K, so it will
> certainly never overflow an int.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: mkimage: make size_inc a signed type
      commit: f08e29351dcb4c07c940b8a4c6b7b3899b803980
-- 
Tom


