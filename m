Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F888CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 18:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89D8846CF;
	Tue, 19 May 2026 20:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IccVqmuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E51846DD; Tue, 19 May 2026 20:56:07 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30A0E846CC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 20:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo8513265a12.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216964; cv=none;
 d=google.com; s=arc-20240605;
 b=GKIJwaedIB+/8w/gl9/kqrPRub2Se82Weesjc1EfbKWyx6ZKf/I6EzqzPUnxD9roO0
 I6zCAoJ0P8795PGC1MFvG8DXg4qZqHCbXwkQM+FLCi2spc3QgRtEAjsO0Y4Ir+us/GMb
 qCq5bR9bOdm1QSPXvSp+hkc58f39xqVlCpo/J5z3WToMvXw+DVCAUKRd2XG6r6pR7fDJ
 WqipKMUjmJwY6tQZK6x0TJcLBBlFMh47Q827pWl9CEkxUCbY2VC8VFeTBoi6L834KBGE
 SorwpBWsnxjLJzFNoxnKaKQdqRk3CfDHFAiRr+DaXib182CT9XxFmW+7GlbueoctlYtL
 2VvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2z1MKhgSRUKCxKcMsmbZ2SKx4kIRm+/RWr8n7/BndPg=;
 fh=IwqLF2dgqYm6D8vLEczk8aDsScMBn2DMvaaVsVgq2NY=;
 b=G7KFz+W6pDrSb/g0oHd7iTHcG/TIDONVBK5o0GkyF8STOjTxd72xCvYZ0Lone+0SOk
 UJaZG0NlZjyEUhpQ2iIxRJu4FsWs2OCH2CL1zgoelj6l+zKgjuZ8znRSCWvqN5CleASa
 TROMo7r6MD81jro+4h+NfPT11im1mdJgNdp3d86EaBO8wG3QQHVxvyWk+S2Q5mSnwk3v
 Rkb2aaN+QDIov7aAQzTARQSR7KvCUKpbiLK2+L0ijBZeWn7kmQjW1sDkKvJuQ7Xq3HGt
 xRhRSqmMDXacEvLiktHVmCc0j+cgYi4+hzc9pwwDinWAQ8kpaE0tedLWrcxr8JdqXb9K
 DljQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779216964; x=1779821764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2z1MKhgSRUKCxKcMsmbZ2SKx4kIRm+/RWr8n7/BndPg=;
 b=IccVqmuYkebMzTIqDiN3pJyE9d5acf55Zy7brZJLK5Z+3osteTguI0gVcUkVTLTBiF
 UOgiU82cFKdn4agoA8KuroMLgthBg96pbgBxkuBOk3i5UZojR0VH+s8h/r2Lbst6Q2mR
 Y2eZrUrzMCyScsI3N/DWdo7BWvjDMgcwYgA8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779216964; x=1779821764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z1MKhgSRUKCxKcMsmbZ2SKx4kIRm+/RWr8n7/BndPg=;
 b=dMjMLU8zxFQtUotqZ+mDb/qsc7EhuUoFKM6qsXR7qKi53XF9/pGG5vmUPL46Sr7a2n
 EJFG+CEJiOGsg6FjemNGBe6zu2kUmM4TlH77bsKfjDdqAhkbSwS4fgMzebIvsa44dupm
 CyzU60I00nAitMDdwAHfBwIwIM7A+KUbaWaSByZRyZkOFlJaUS0010MD0YWrw6VLc68M
 Scd6e+kxUTqIVh0cTn8GUSuYp1ENVwrkIlfRUjiLDAI+PxxgoQZWIeNPPatMeYPVYWUz
 GeNyQWyPAqKv8+EDmZvtCXqq4bxhqM9BHYyurqrkiTOMBPg5Vm6tLf0L+QRODV7TTscU
 q15Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TcD9RBunkHIREZe2Fs6i/VIR5xyRHxGKi2YGPfGi5/D9R8ZBpwYTZ5M97j1yjUrvEDUM49D8=@lists.denx.de
X-Gm-Message-State: AOJu0YzjT5P8PGhSJSsUGNwAODFop+ar6rAG7ra6g6w0v5dSYvpm6f37
 IgAFcNS0d5YFA66UBQhfUcb3SwQBJE0r6uJdC2ZxHiWnTPbcNYKOvWQ7E0M1YKNJJb+lGbkkf6o
 vYkePikjnwAbeqQfd17aInDgTdlAWfykTnLxKJXZW
X-Gm-Gg: Acq92OGa6EDdNBPx9U6WyUdOlMu4YonGSmOYHjQrvvuCOiaTfAsvCldyB3OfezDvApt
 El/RXI0zkhBq/bkaQKnns9aqSSzvbEqZw02qa1iEt4ahBhxCtewUMwVZ9U4cfXliWgiuJKGiuAk
 yI0FUsBXysnl+ObrEpqzZ3DG8kCjWVrA3BXKKK4lpyWFYbAI4WmEzKMgGEEQVsc5Y4Vzn52SQT5
 yfuYoTj6uZXv/BS3bOouJiwTBXfWVmu0BoOgo3cbNKx2AXson7NZazlJPf3qLFebZkUrq1W+mhk
 3CDjNdJQENJQDa7N
X-Received: by 2002:a17:907:9805:b0:bd2:fcd8:4cee with SMTP id
 a640c23a62f3a-bd517aba140mr1235644666b.44.1779216964568; Tue, 19 May 2026
 11:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 12:55:53 -0600
X-Gm-Features: AVHnY4JU2IMivRWIamc1KNpAHR181SK7mZjwVx8mH50CDtp5b4CcGP-yEetosTo
Message-ID: <CAFLszTjZjRJaLwET4SAUQ3Y=fBupo3R7BA34ei6s1aOC2=7FjA@mail.gmail.com>
Subject: Re: [PATCH 1/9] fs: move struct fstype_info definition to top of file
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: move struct fstype_info definition to top of file
>
> Structure definitions should precede code using them.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/fs.c | 86 ++++++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
