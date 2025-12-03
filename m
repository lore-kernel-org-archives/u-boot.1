Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F49D12D71
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1043383FBE;
	Wed,  3 Dec 2025 15:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kE+ups/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D904383FD3; Wed,  3 Dec 2025 15:42:02 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A9283FB2
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 15:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6d13986f8so909665a34.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764772918; x=1765377718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xySDS0Qx31VNT2/8ft2Om8s42OAii5+sYuPZwCoJmfc=;
 b=kE+ups/z1OvlmzRUzGAo8kHZE2Xh/4AftX4W1X/+RhKRyeiLzB/B5kISp7meheD7ZD
 7PwK5FOJrKNK3BmxfCzP2t5kIXpB6GJptR275HUZDrxA/cPN5En2ofqRHMyka5FRcJ9M
 XvIFzYKZa32pYjYKa/1F0yiFRToOJhMJPl3OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764772918; x=1765377718;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xySDS0Qx31VNT2/8ft2Om8s42OAii5+sYuPZwCoJmfc=;
 b=GItPjujREPsSOLfMKAcXZD7ICsPyQIk7CN9B0aCVKhHNGr2fZREo2rSDf7+DlWjW2W
 vFI3CSP+EAt2LoLF6lw7+7uNllFGn9IWcgngUe7bUSBNSK2nLD8fRgkJ+lxULqBBmhKg
 E7qRibKp7Xi62+E7E7HNL+Pp+tAIaNwii92NabMvB5hxJJlzC1YtXIAUJnSEawnY75cM
 R3Vz/UHOjJiOIt3vPGa2+UDZIey6dBJN3yfdRAbAP07OzLEk8dUaXVueRZIh2akYyIUt
 bsIasa0XaYA3bnljdqEZ3mcnvtQJ6gC7UYFDge0AVGsF4azwcVlf+9WJpxAL13wH9k6C
 fRNA==
X-Gm-Message-State: AOJu0YyQ3n3+BvWHRsKMv7QgPXipveB+h3Q1Fn59pBrOBlJ5l74sULJr
 buTvH3oZ/hDJyXikDhGrEkwCVBicIL+vmaxXkZMbKHzV+RLFp7lsL4f/wQydnhkJ2jkBTvZfzun
 WT2G+KJI=
X-Gm-Gg: ASbGncs+8Tm5ZR4sRhvKTlT+WRkXIQKutDUC/3vCf3Fg7ojseaenPtBT8EtaDQ801GP
 A+jsAMNv08yx1oxBlzD979md0CzuIo00DlxOSH4iw/MU6RH69FIIzq07DmkTTn1Q9vu4qRPXRsP
 pUQKJrSl3zueS9tG+kf+qptl3EuSQsapERqMvNLO8FGBavY8lmeeZgiDhi2ITmP58BUEiyM2N2s
 Pv+EbzfTpSLNYaoIay2a4iwT3CEvqkMGpCZa7AcBylOpr1Yq+HcRYhPQBHmF2GdJ3g9YeQ0R3D1
 pFZig4EZEZhaVsFPYCNrMEeRS4S4rMEDun/9iOlz8tIGcwDm0XbOwU+V+uXtSRk6HdyrhMG6hVu
 D0ZMswKyzT6NSAk7/aQaLUjlPJIVnzxHLescDicLRTgTCi9M4sHC/CCUvDKWflvBcrizhKKlh26
 jXFZabu+OfKlT+xKuH1XGyxdoBZaJ8ZluBj4vUkppvBMa1HhGA
X-Google-Smtp-Source: AGHT+IFuPIEDK29VAjb7qD5W/eSIwhJWBFCSiAep1S97u9QbmC41DASQ8t1EygJuAeXn0OVkhET23g==
X-Received: by 2002:a05:6830:2406:b0:7c5:3663:ae04 with SMTP id
 46e09a7af769-7c94070bd77mr4066175a34.15.1764772918551; 
 Wed, 03 Dec 2025 06:41:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd029507sm9846086fac.17.2025.12.03.06.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 06:41:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>
In-Reply-To: <20251203012412.334055-1-marek.vasut+renesas@mailbox.org>
References: <20251203012412.334055-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176477291777.3418979.13462460236948432884.b4-ty@konsulko.com>
Date: Wed, 03 Dec 2025 08:41:57 -0600
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

On Wed, 03 Dec 2025 02:19:09 +0100, Marek Vasut wrote:

> This is R-Car X5H support. It was originally posted before rc1 and the
> changes are well isolated. This is the final patchset which enables the
> Gen5 drivers that are already in tree. I waited with this a bit until
> the SCMI ID discussion stabilized and TFA X5H support landed. So now,
> I can add the final piece into U-Boot too.
> 
> Note that this is still very much experimental, the X5H upstreaming is
> in very early stages. The OF_UPSTREAM conversion will happen likely in
> 2026.04 or 2026.07 window, depending on when the Linux DTs land. The
> compound-clock.c is surely going to go away once SCP gets updated and
> the MFIS mailbox will be reworked once upstream bindings get developed.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


