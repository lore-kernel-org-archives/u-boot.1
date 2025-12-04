Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956A6D2CDE4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347FC84166;
	Fri,  5 Dec 2025 00:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y8yMZkQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACAE84172; Fri,  5 Dec 2025 00:10:42 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B2F784057
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so1225820a34.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889835; x=1765494635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PA3rNh8vWTEHVpAK5R2VPPw8Hr9N/Ln1bpDKaYxqvn4=;
 b=Y8yMZkQHjSIy/C3l/c7IRx6jEngBVEE1l1fjQ6YsSoQmZEUyZAO7nlkpGtmv6iXa+Y
 Y2RyFOG3sKrRzxZwZ35TaQQwy7HWLrHoN2pyXkRvuJG4ES2/NdS3ilDwNpBRhwR5LUZU
 BnIiFUYwUaoewoAkuV6AssL2iN+sz6j8Pub6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889835; x=1765494635;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PA3rNh8vWTEHVpAK5R2VPPw8Hr9N/Ln1bpDKaYxqvn4=;
 b=fgCWW9Re3Zp5Gs5erjao072EcthfKpI4cJ9zgtUp6qKkC57d560V48dRRNxjX1bHkQ
 UEcUqyPKT6i7IVTveVmFklknwkBIpZQ6z+CU5NFM0GFiV50/8q+KyKImAFkANc91892m
 EUEesWz2eaiR54+f1NocXoeDc8oG0RINrcADJw9GvwdAjPNQHs/O7ETGZKjyKEzrBtpj
 GPmqZsK/mgpfOn9KIQ0KedGFeUnx6DRsigeKfRmnZfWdynWrGDw+DCVsHcw1ZnW/5wAq
 oKZCIVBlR4futuxvFUWHSonEBprDrokRk8l/2Cpr65XtFqCABNbMEOaUK19C5exuzn94
 KyCg==
X-Gm-Message-State: AOJu0YzYARETwr4gnHl8fFDPhjihe8FbaBJRhkXg6LEpehYlyRb5QuDL
 0vAgFeeMmaBiiLFybvv60btkPKlBKEGrmeXpea4aCAqI2c+zy/MQgKgBR0qmSfDkeBQ=
X-Gm-Gg: ASbGncs5wC7uB+xMUmRYtDc1HPxpfjU6Ri6aO3vthlq6Z7Y+NUluW1ngfDXqldhV8AW
 H0ppuLBMKW5hXs4HDl07rjphaVwICcsifa33RwM4rM0a6AljdRTiUf8VXhqPhQBmeNRNvX8p9XI
 MyBzoHyeDxbtWMiVZs3oKIf8wp5c31cQ+XPcou+Mg3GlPoIcE8m1y9hStlkbGqPdBxUvwTK9VVD
 MESawMAdckyzxwl3HWv7rl+herlKV2BiODW+YXZ0xj/Ub5SHzSTTyWUnJpPGyFcOiOFzkzY7jsQ
 hcI23UKDMf+d9jzbwtO6wwK3VPhg8q0XsJ51AYUSgriN0wp6uD3CTvb3GIaENyhdb9hR16gnA70
 1nMjdIiW0sOJCM7EZNxq8RphAAmlLbasRiA5/J8T83VBHQAphupIv0i+kIFItUoLAlRZ3uqGrpS
 hza4f2iMNGfU6IuG+/GRm+mJl450TDOtXe0ecC8rabJLOr4Zgs
X-Google-Smtp-Source: AGHT+IGGi44LUCGutVPQuTqWS1UOhePXGCK3j9877EvT8e+XEbm2ReGh4wFh2LHkA/3trzF/0e3Few==
X-Received: by 2002:a05:6830:2b09:b0:748:8b42:77ab with SMTP id
 46e09a7af769-7c94d8e55edmr5359727a34.0.1764889834885; 
 Thu, 04 Dec 2025 15:10:34 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>
In-Reply-To: <20251119145522.843213-1-trini@konsulko.com>
References: <20251119145522.843213-1-trini@konsulko.com>
Subject: Re: [PATCH] bcmstb: Make use of bootm_size rather than fdt_high
Message-Id: <176488983427.2091996.3598030784575196703.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:34 -0600
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

On Wed, 19 Nov 2025 08:55:22 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS. However, this platform also has a large comment
> block that explains that given previous stage loaders and other parts of
> the memory map (that may not be in the device tree we see?), adjust this
> to use bootm_size to restrict relocation to be below the CMA area and
> update the comment to match.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bcmstb: Make use of bootm_size rather than fdt_high
      commit: 39b10f534f0fa016b228c8b76d090fd2d62d2378
-- 
Tom


