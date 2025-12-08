Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D837D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 18:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F4283B5E;
	Mon,  8 Dec 2025 19:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sGF6vu0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1E783B4B; Mon,  8 Dec 2025 19:54:59 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AC083990
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 19:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-453928468baso1929386b6e.3
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 10:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765220096; x=1765824896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yfexDkNs2dQvgkcm58SjWXeqmj2kWqhegVOYP9GCvs=;
 b=sGF6vu0P5B+d/Oly9yugpp1anN4lIXR/l6S6qosgjP37ZBP8n7/yfUvdp4PZA6jw4w
 CkSvXyfDnCpDQBTS6SNfkUrci+fRkxHb3QJrqug6OVwEe1mb2hrV1Erkkpaj2wRTfNpw
 gjXsdTM0CtVrmATPylSHdqQum9o0AHDupMWTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220096; x=1765824896;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yfexDkNs2dQvgkcm58SjWXeqmj2kWqhegVOYP9GCvs=;
 b=IXejd1Nt3mpZVuH1XsD1tVllHxBWpKtZuZrmK09PpGI1Eo6TN1JEDHPmbfbKvRG2uf
 /9vOwGcZu89oqmRQJmD6/GqE6iMUuR49NrSF9qXlWuWYGnu28zBw4CInvEJyOoQZZMDe
 Nf0dTLkPJ2XvauHCDkSJQH6Sr4JYPIaxa7y/SRojGcLtt/Pd/dR5YEG+cGoCSgq6Fqyb
 U8psdMpR2plY3EpO6O31shOL/0lRAQIgmjPYb3D2xbvVyYwRedQNfkeICj0tQI10qUQo
 1Gs7RFUAuIxShVsq36LRIQEWp4/rpb/f6nwSUE8jeeA0V45zPud8JrNARaUB6b7HvCGo
 M6+w==
X-Gm-Message-State: AOJu0YzKdM7G1EHiZz5khhQvLAKjNagJaEXq8KIHC7LzRheuSVUSPJ3A
 uxt9lMGkA0lfeNq3o7MiWi2Web8iALLULamccJPn8Pn4oAHoFQ1LoaCZ8j3AjlkJCbkpCbkIvLT
 xwsn2d3Q=
X-Gm-Gg: ASbGnctUcPEWwvpCpSBLf+fy7vxi7hucgfkO+7fNU1a69TFeSGkSLEDn/lEkwrxV0/+
 NF+ikrXZLZ4pE9DEtpZgrQP3+dgv0zrk1aBRpLYPZp259SrNaKHD1Ub6ozziJw+u9+LaSvu39PI
 YWSVXKyPBChOuTgtw2FxcIZgKJPjmdwcEF70VcCi3BtBpTkG0ufE/T68BWWmygpzZTok0D1KhDs
 CXByw9syTs5zUvz7PjRV8kZu9mZDyPFZ4+3ym3vFQ8cZWLDPwlXvs/9yHvHjhm/pdelnS7zSdmH
 +0uhaR9XKsm8DuG2+dVSGDZ4x6NRcUyGk0450S7gjuFkIMEMhfoxfJTE9DET4iYnm48hamKxBgq
 Cr0dVPpuXk+U2QGy8iEBTh6TOwmKzVVUf5sgDIPHK+6qHqJmwzJBoxIFTVKLZn4z+PmKiqNad+/
 bbKUhaeF0l3DYHV1ixVxNma2UYLYAhucNzeAjudsKSAJRiudijjPnc/ND+YW8=
X-Google-Smtp-Source: AGHT+IFdGofMGjz213X47ocXjm/uI+a0C5nUgunQjazYmzys0VlzgXtty2HH/XiLvBH4/XrQ/ceHHA==
X-Received: by 2002:a05:6808:2e45:b0:450:d143:b79f with SMTP id
 5614622812f47-4539e0c610emr3375749b6e.66.1765220096076; 
 Mon, 08 Dec 2025 10:54:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91eecbsm10890864a34.11.2025.12.08.10.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 10:54:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251208181709.39819-1-me@ziyao.cc>
References: <20251208181709.39819-1-me@ziyao.cc>
Subject: Re: [PATCH] MAINTAINERS: update my email address
Message-Id: <176522009554.376851.2191456975540821067.b4-ty@konsulko.com>
Date: Mon, 08 Dec 2025 12:54:55 -0600
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

On Mon, 08 Dec 2025 18:17:08 +0000, Yao Zi wrote:

> My old mail address, ziyao@disroot.org, has stopped working. Switch to
> my new address, me@ziyao.cc, and map it in .mailmap.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: update my email address
      commit: 543900ab530a4c65d0130c10b001378c3290107b
-- 
Tom


