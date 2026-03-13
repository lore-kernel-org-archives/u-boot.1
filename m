Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91D4107BCD1
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 23:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C66884376;
	Sat, 14 Mar 2026 00:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R5Z43/40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43FC884401; Sat, 14 Mar 2026 00:39:56 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D052842FC
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 00:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d74a59262fso2472343a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773445192; x=1774049992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgRgl29kLRSzw0mRc3NevHXW3OQWQyiTH0otsGnOF6g=;
 b=R5Z43/400oW9RY3k37XFkXYRMxmR6JacyfkF+dQxqTeUms9Y2Vkyd3kObBvCysto2T
 9aYjQb5yHnyjPEMnUt2fK5gc09dK2tjLpR/rTbRtCPUQ+hHtVDIgGMJPMMUQAfXZXSqZ
 q1KtiTLJO7HdB1nsYn6ITsD5s4ELcnOZWKL64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773445192; x=1774049992;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VgRgl29kLRSzw0mRc3NevHXW3OQWQyiTH0otsGnOF6g=;
 b=a4/xeJ6cWkhux7jHfOhqpano4gAqEZaXhYtc71/cihLWFy0H9E2cq2BF8NZwaUsDa5
 6GziNIYyivysU7V5gVjGnw+uY+WsO6wYNu1pKa0PFan/HKcEM1GchJ5TlGIhfBDMGjsU
 7ZPj2lHEJADH4W9QyxpjHrvpUaFsszwVPz8xCcv0YxH9ab7cWiPCwNyz4vMLaICNwYKQ
 /1NV90wEEA+/OxXNdlirsTwNATBQ84JIJVXolvqrdysuKzs/1ixuqz8LzM6+ocuqalqJ
 PyLZ6xCtKKEumuP0LnnyHpJB9wzUuC5xtHQ604Qh+/myuvW66U+fiLhBIuZN43hlToHK
 IYgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgiEyUoBqtEJ7H8O8Nn8RKFDALAXLMOSUJ2n9zrs/FZSb28s3DYTZ9fE7ReE+BUcPmagS2Myk=@lists.denx.de
X-Gm-Message-State: AOJu0YxaZZ1VDFw8hlRQyxcWTF6P47YoXFUNWdhAss3kWxB0h8XrCvfU
 rF6l/Gw6B+++C1rYLTlfkjnOYxtgTe6GW4WyA5EV7mVRPOerudFLkKa2sLenTjcn+iQ=
X-Gm-Gg: ATEYQzz+E9eGI5nUBFopXkiSaKgdK8MehKUWs8IHfx+3hI/drxtcj+Ww8eo6kKLLVhI
 BwrXa/b9x2fHCsUtBbyvf1HdLrwX9pjN8EEkxeD9s1jC+7D1g+GwnsKrmfnuRNfFMt/wiUpMbNF
 BUECJ94DnA41DZ7biCLH8M9mcWckYHxozkBE1NC0Sed9GWfPKxvm6jx1pdD7Xlu1O0/PZPCdY7B
 41W1pV89FTx3xBO9pZPAUsldT4UH9mNaas1i/AjJJ8xt6Ek0Szn6Fpz9WD5w7jZCG3HKDcLSDdl
 PwJFonA0vt7XbJasO/uAkqQ92j65m4mesrvSYu02bs59CO4hoJmS+PWZyOjaSPAMpDXGzck+X9H
 2dd9/fNABIsOb+0ygdbBodlsrv8b7+M0lQ0E5jhKIsD2uNfGYl0wsfPi9vId1iqgGp6FSxZJyci
 CeN+EZKbfDRK1NdpckFydeGl6ygZWQAMKHbmpTvO8FdIYMzRrQthgNY4MQy6RAElXMo7Jv5odrZ
 c2kjOymaPGF5pOCwLx0sfqJm3YZgv/5RTfDHdtSSfH5Vrc=
X-Received: by 2002:a05:6830:7301:b0:7c7:b4e:edb4 with SMTP id
 46e09a7af769-7d78249e979mr3358907a34.8.1773445191780; 
 Fri, 13 Mar 2026 16:39:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aec4c8bsm8096892a34.25.2026.03.13.16.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 16:39:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: bb@ti.com, reatmon@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com, 
 gehariprasath@ti.com, s-k6@ti.com
In-Reply-To: <20260226122508.2269682-1-n-francis@ti.com>
References: <20260226122508.2269682-1-n-francis@ti.com>
Subject: Re: [RESEND PATCH v2 0/2] k3_*: Add config fragments for inline
 ECC and BIST
Message-Id: <177344519084.1178192.14206161027418136209.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 17:39:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 26 Feb 2026 17:55:06 +0530, Neha Malcom Francis wrote:

> Typically we do not enable these configs by default but would still like to
> have the option to start building them in our default build flow for
> testing. Also there is the added advantage of users being able to see what
> is needed in case they choose to enable these features.
> 
> Changes since v1:
> https://lore.kernel.org/u-boot/20260220091532.3584771-1-n-francis@ti.com/
> - move fragments to board/ti/common (Tom)
> - add doc patch (Tom)
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] configs: k3_*: Add config fragments for enabling inline ECC and/or BIST
      commit: e56228f32dec59d446a3f12bc1c1d7680d458f68
[2/2] doc: board: ti: Add support for config fragment builds
      commit: 112bb951242b01762d57569b8d0dd406ffe9cc48
-- 
Tom


