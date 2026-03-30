Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17E11061B22
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28DDF84068;
	Tue, 31 Mar 2026 01:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+KS1jOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA91A84088; Tue, 31 Mar 2026 01:00:17 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4AC83E7A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-46702742c99so3306480b6e.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911610; x=1775516410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Meg6wnIOC6noXfhIYsBuSjzPYWyH284a2d3KCVvvEkc=;
 b=g+KS1jOFtSXIq52w7QuRTAyGasoMkdrPlGCxClSdWNYU8CO8Xja7maYm4wAeq7bGUz
 GRgTzzvSFAHLHVY5VvVb5IEmGshxK6ejmAGE4aIYwzCPbiXK4m3zAl0ITEaVGyODcFx9
 J15L7ABF4xecP7K3QwC7JLstbgRSeuES2azCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911610; x=1775516410;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Meg6wnIOC6noXfhIYsBuSjzPYWyH284a2d3KCVvvEkc=;
 b=fTEDTWrY36Loa+mlJVew6cQybP/W5NF2buUELsmzcnz0svht17rBnbLhobGSPo3vZj
 dcGeGVfjojwDyyb8UzoQioaCRxS5ChD+RcTdJCZN/EyQMrVd/Mx2g1QS9Hk8MEuG7VII
 QqtagCQiGkva7I4YfI7eL1caTEtOL+hIw1YXDHdsQe+gzUA/k0OsguDBOMAEnZgqcH+o
 pTkV34+T/SRNzivyimmDTG//r3fIcDBC+Dymfn4TjGOu2fbyOcvMGLa928xkYIO/DMaD
 cSJuan6Hnf7vV7Fwr9BVhGSLeEHcONThbrUup2mRSsIaiP3dHJv2WhXtRrsv388Sfcb9
 qtnw==
X-Gm-Message-State: AOJu0YxCS0UWrSNjeLvOZ7XCZvXJXQGSppZqmwoX2jPXLWO3RAOPvNhs
 FMo7h2JTT4tHCZOBJhFtbme3HfDute3jUjwzinrXfV3/BLi09EsUl6iukEYKJac7PzAa7EOejZ3
 /Qt2dYw4=
X-Gm-Gg: ATEYQzxjvHk7AwAs583Wujit7Ot13VHb70pEmte3RB+lixTMWdgaoKqujoFnvbpG6vk
 kr3DXOmfXX9pqV7iniYJ2pMhA2UzmkBUnh9IzKYhoHiqYtgVzXCGw2zmIV/zjtz902rZ2pyB7yB
 7USHZ7Kp1JFbyVfZh8Zwp0HWGIQwq07NmdYWhbMsYwl9HeUkk+QkHWDSAHKZkEz5CqUjlxqbQ1Z
 wyeZpuu6yAL3yQtvpWxQQ6uvizCDuDHyNaX8721XaTj5cBucKeNpDE6+TUnQLSD/Itu10AMjClI
 PuYNm4U7ptahjSjY4PXB4VlGkTa8Noy2MN6ANjrGcaOfXuIA5/Ro6WuQ67MKkJ7xBM1kJQZXIf2
 vGgFOkQJu0HHWiPy3kzXIkVKIy6UPP6/vBNLjwhRrxoY6fjqllG8UHkYAto0wElt6DdAAQX9r5N
 BJw3Ui0AAwdwSSYtHOERlSP9RCg+Bzz+wqodUn5XaQ5rsf8nhk/TC/bjFNwOOylPJQsYR06a6qw
 O/W4rMHUpR6wNlylpkEoU2uPrZJ/E3n12fqdgMGgnNTfD+ICJ4Amr/AvQ==
X-Received: by 2002:a05:6808:220d:b0:463:93a5:a5bf with SMTP id
 5614622812f47-46a8a3ca29bmr6875181b6e.8.1774911610580; 
 Mon, 30 Mar 2026 16:00:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012424.4162441-1-trini@konsulko.com>
References: <20260317012424.4162441-1-trini@konsulko.com>
Subject: Re: [PATCH] sysreset: Rework tests around SYSRESET_CMD_POWEROFF
Message-Id: <177491160979.1028292.4307170404941925693.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:09 -0600
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

On Mon, 16 Mar 2026 19:24:24 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue around how
> SYSRESET_CMD_POWEROFF is typically selected. We cannot rely only on
> CMD_POWEROFF as SYSRESET_CMD_POWEROFF must also be tested for its own
> dependency of SYSRESET.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sysreset: Rework tests around SYSRESET_CMD_POWEROFF
      commit: 4f2875911f67dc318096f5e0bc85c3b82512a2a5
-- 
Tom


