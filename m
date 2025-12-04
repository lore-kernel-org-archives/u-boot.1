Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7426AD2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 963BC84131;
	Thu,  4 Dec 2025 21:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="py2Ori2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F03084166; Thu,  4 Dec 2025 21:28:54 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A14184148
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 21:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c76607b968so615186a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 12:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764880130; x=1765484930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W22Aojrb1YvKy9b0CLlm3lu5oOX8yX0CBCOmHmIBf1w=;
 b=py2Ori2I8R3pzWXYKGaBWRjCrThw6GSxxY3RB0Ibl64LukRtjGVdgoZKDsfNaJV8FX
 tAQ1+vJaLTKEwLwKOxU16Cw7uKFr8AlL2X81RyDmYXakezBrc28aeWZiuY036bCox8kK
 IKcv2oS93FFmPq56yNeCpfY07rG5hP3v9shmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764880130; x=1765484930;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W22Aojrb1YvKy9b0CLlm3lu5oOX8yX0CBCOmHmIBf1w=;
 b=g8XMbcad0b2YCxKtyhyLp1EDX2JifGVRXqkA9Kgo7zI4nET+AwgBmh3hI40PjPh3rk
 oSSwo/IDRUgqM5aSbXqrgawpxUT2ks9JeNGEC6ofLSZRMIUoouP5wvSbEGwpm/Tpu462
 bpk5EzNUgtCZGbczC2LHlH9yRDPeXRST4ExO1L7JEbvDjOb0v6BOKKIVaGT8DOabxXcr
 Ib83W3U5okxv1NpyjcOPuOz5eKMKizYE+xj/eGqADkaP5QyRKgVNr1RaK63QNHiklvMq
 oxS+rk/xNz/DOeaylNfA2DRgrGI9PrPkphP3s5M0HrnxZ9NVscCOrUVXqaisBEb9+gS0
 7Kew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc6ul/LRcx5cM5v7YA8RZ+4wLhQxbfe/jDvSyMcU9tur87c0VmlG5zgvZreLdv/8ZYofLuuGw=@lists.denx.de
X-Gm-Message-State: AOJu0YxUqU1cw8nidpUkIt+LoTbGojEZuPbfEGGthS7HRMAs1LxxGWUJ
 YfimlxaQaGJmt1CnOYlWOD0F26j/IdsS+ALn69cuIwjFjAWrJqlV8eF1huyJA8Q+ie0=
X-Gm-Gg: ASbGnctSyip9qG/Swmn56nn+W4X/qbRbwsuUrJPS6rZvChPAod1ObnTkML5SZPfi1Dt
 PSdJKq0kTiuNHW1h5+Hvg/tBbe8LZnlP3AwSzpu/4V0/1A7tdQtMQZIJjCNmCizJIrf/O4LoI+y
 1ujF1AcVIXnZJXL7ry4otkEjgiymhwEuoEOW7QA1XYRsTiotVn8HpEoAn4BT6UklnfJiOFiqxnK
 ytldSH/Vq/oCxMiSN/Lll4exhV5QZjsHKSC1mgEph+X1wZ7VrUoUjFevRv9rJvp4ZgMObqjEdDq
 EwoQ30fKw4fGjf7KC27a/i7C3qt6FExKeIcBpMcp3JVcWJBRFBAiFNEGDMxUuJ5HSUaCJvdnzrv
 Rwxls75q6AizMQLDNXUO+U3E50rqFFspyTiryi3q/fJv5NHLLTcuVZsX42P2MjLQ2OLFfJRd9dG
 FPJgrSKjH5n+VIczsTgZLFilNuZlvOigtpFyi48xNLmQWP8P808IeN5jnCdi4=
X-Google-Smtp-Source: AGHT+IEWx07jkR/CxaihEytppeRb457SqAaj7MBV6LG6T/+um8ExBemB3iock5v8dTG+C3L5hlUVDQ==
X-Received: by 2002:a05:6830:4112:b0:7c7:5907:b1a8 with SMTP id
 46e09a7af769-7c94db4a335mr4941194a34.13.1764880130139; 
 Thu, 04 Dec 2025 12:28:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8f8d0bsm2336131a34.5.2025.12.04.12.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 12:28:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20251202100000.372409-1-amadeus@jmu.edu.cn>
References: <20251202100000.372409-1-amadeus@jmu.edu.cn>
Subject: Re: [PATCH 1/1] binman: fallback to importlib_resources on Python 3.8
Message-Id: <176488012941.2061624.17973242173177808066.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 14:28:49 -0600
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

On Tue, 02 Dec 2025 18:00:00 +0800, Chukun Pan wrote:

> Python 3.7 and 3.8 lack the files attribute in importlib.resources.
> Use importlib_resources to fix build errors with Python 3.8:
> binman: module 'importlib.resources' has no attribute 'files'
> 
> 

Applied to u-boot/master, thanks!

[1/1] binman: fallback to importlib_resources on Python 3.8
      commit: 02aa1a56a7cfcb858973ef8965e54cf539060fd9
-- 
Tom


