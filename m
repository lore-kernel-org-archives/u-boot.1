Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9064C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 14:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A283832E6;
	Fri, 23 May 2025 16:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPE4LzcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C9483285; Fri, 23 May 2025 16:01:52 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3A78329C
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so2773474b6e.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748008909; x=1748613709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gdSnWLppNuNV+1N5pAXpq5pjTpOq/BUmUtxI9KM5Ehg=;
 b=BPE4LzcV9KqRZWod7lzgWSMWtSVXqHex2HpqnFRQsdZ+MPs5JMwzaF+awu/KDeTr08
 MSskph64Ijzwbfg5ikjW4B6PeaXNcbvWtjQieKVzhrjzJLXl5Xa3LdforBadm0G3oITO
 PAgl+AK8UcYIL9QnWxDMctvUitUejy5lQGEC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748008909; x=1748613709;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdSnWLppNuNV+1N5pAXpq5pjTpOq/BUmUtxI9KM5Ehg=;
 b=TCzOvW2yTM5Uj0WzTj8xEJr6+mcVT6JskOFbEgqB9+840cr+cs9Sd57v7qUPIDdk8U
 OYdEFclwbgBueGQlNdBe/FM01k5GdMzNDWdYt/c0WGVnqRADOdWQfFbN6oX/xlMl+j7n
 UMkyRkbIb6LHfqW/rm+YJ/3NTLuM/uX9T+8LuIn9c/Un5WenR3RDOAkWuLrwojGzG0rr
 4zqh5DLZmig/m2hNWiKkSOpFv7p5rcNuuNjHtSGVI33Ab1/KHO8s3U/YD92tz1IBThiB
 usULpHc7QNPcxDlWLUl+w/jcLpOdffQng2H+HzJ8LPHNLCV37GECYZVD5Uze++IDTRdu
 pv7w==
X-Gm-Message-State: AOJu0YyfTtNzYF/VDbmU6oiLdr3umaowPfqTZ2QplXwG/NdTeAC8p/IN
 CK7C5ogruqHadiCM7/TBcGMajOYdbRhalDFLLmsHxfnnAmgQshIcC8yCkWwAj1w3asu2w04t214
 tzS+ycAc=
X-Gm-Gg: ASbGncuwm1rClSg9BlAaWe8bs9jHNKLEiCDW2ldveCmlYlzZxlxcKFRMi5EaOQz4KrB
 53xNc46r2pvbmEORUZI8xIjIuRvFaAsdV/wYaCeLyP9EmFgRNaGW9unI8PoQk2NxelDsInU6Pli
 FIl+wChsF7394NSlQcNPrZeuXhMqdQbJAy+5mmd9nMJDPKlN7yP5Io0MuU5hfaCSqlkdA78kRUf
 aqJv2x8+b0cq6CUeU/kpAkjuY3uuNEXt/RPXLGmf/UvwqzyrVa7U4XZKdK7gija/ZA8T+E95X05
 nZI5TURC9cahoWc4fP1p+GpObV7MLnyXeIr+/DKxrrsAjd5V6vKTXu2/cNgEtFKQQ9xO3NtY75c
 Ik4g9Qhjv+Lg=
X-Google-Smtp-Source: AGHT+IHM4BYcbR98ehF4nFpYTVLtmC+kv9BwnTJ9gHstpDfQWcaX0d2NMgRBmYqJfBxcFQ8kLaU6Pg==
X-Received: by 2002:a05:6808:2286:b0:401:ea99:54b with SMTP id
 5614622812f47-404da798f9cmr19322661b6e.23.1748008908795; 
 Fri, 23 May 2025 07:01:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f303156esm3167610eaf.38.2025.05.23.07.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:01:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marius Dinu <m95d+git@psihoexpert.ro>
In-Reply-To: <20250508120518.1489-2-m95d+git@psihoexpert.ro>
References: <20250508120518.1489-2-m95d+git@psihoexpert.ro>
Subject: Re: [PATCH] EXT4: add CRC16 dependency
Message-Id: <174800890789.2288012.6961800034846457017.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 08:01:47 -0600
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

On Thu, 08 May 2025 12:05:19 +0000, Marius Dinu wrote:

> CRC16 is used in ext4_common.c. Build fails without it.
> 
> PS:
> This is my first patch sent to a mailing list.
> If there is anything wrong with it (email format, whitespace, etc.)
> please let me know.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] EXT4: add CRC16 dependency
      commit: ba57d85e771db791f814f89df9933dbe70c21cf7
-- 
Tom


