Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB1CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 20:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AF78144A;
	Mon,  3 Nov 2025 21:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iY0w9Lm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D3482A9E; Mon,  3 Nov 2025 21:50:40 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721D18004F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 21:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c532d70cfaso2889246a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 12:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762203037; x=1762807837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Q51E8uD+h8GzpYz23WCfSVVAmBiULPk2SZK2w2733I=;
 b=iY0w9Lm0s8v8tA1+pKq+KwnuqRlfjt5mG2FD6AIQZIY5x3ODTIEkhwZwQZ4GefqQb7
 wvUyAQV3TSYxpF2g5E0V8v9bbEzq51FNh2rQ0ZNiSlbcLt5+MusZ1OicsQKgX7yuWV0n
 7dIKlbz53B2aI/DUsoBvhSYUHeTfDKVhdkEuGopvNRv27JcXCqb/JcV5HVQMYe3T41G6
 pIZYBU9voJ7v6q02QMTkD2vqqII4lAjztmD38qNzeboI+fGNVH+NUwmtkCioCzOSxOHx
 jcVNybm1GubG4AbscdNNZag59CHXK30dfP1xWUhXWFTMUrsqcAYR+ORrsjexLbZziV1i
 tkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203037; x=1762807837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Q51E8uD+h8GzpYz23WCfSVVAmBiULPk2SZK2w2733I=;
 b=VUwxyYQis7eAeb6LVH6jVXEKVGOcpvjdU5goKedgLj+tH1Q/et7SW2VoAU0nsrvc8j
 jAy6ABQ1r8WL3bP1/TPAqunuoOVCS9PWOoKcfil7JME0gWzWBvEU1ltuxgzzSHvcLi90
 139hcg53dBld04SvDALcH3ZC7lOk/8laJC975fY4v7RCQPoJooYaZpzSi0M4a6jS2u+U
 JpvWz5erUW1fCaWciv3x++jBAwZBaJUTuB+f0fQvagwaBQjtK6aR9RhJ6JCgCbOwSqOR
 rImidtu2/JCBQ6VioeR1ZR1v16sJ3bZEP6DHpRby2thAuscuOjH3Ptbsb5XdnKWioqhk
 +vdg==
X-Gm-Message-State: AOJu0YyVv3O7Niy++/twn9w9EApqt/s6tkPsBeEGNAC9+o8bn2ZPTlJ4
 1LNNkaD1PLuSd8zfHEKZ5BK1isi6C/SRkbqMDbR0uiFLkNVdDVcZ3CJoZicrQi5+lZsVmgF5nAc
 tu1YojxG+Tw9QWQtQLaK9It2C18bJFeCe07jSXU8=
X-Gm-Gg: ASbGnct0ST0N9EwFMWe5g/PKHtcDvjxfPTBCWvBiVgu3vja/gsOHenpB3iIK9LnCtUZ
 LmdNRZCy6kAPHGYgv6I31DpF91unFrwLrfEXnMFyqCiujRYV1njbfh3PLpUDHXUq0hX6tICaY1T
 18OwUMO/IGgdDPbcNiG2mEwuhYb/zgJ9pfYUFqmZVFa8s9vFu2Y4t0ueGoUtTsXldcBqUc8IyfW
 Z1n7v9UYb3aLVKwydIRJsXZ7k+6di0Vn9Dx650kUJi/lEjJsZVn6RNpO/B7GfChqJzBG68z
X-Google-Smtp-Source: AGHT+IHqXSqYp8Fkl4a8cccTSe2a7ZSGEId22BDCG7xXXvKVOM0c5WLYtK1MHoSYynSIbux9fzoaKyFVd+TDEdh44iA=
X-Received: by 2002:a05:6830:4114:b0:7bf:6c53:b558 with SMTP id
 46e09a7af769-7c6966fe86fmr6957851a34.5.1762203037144; Mon, 03 Nov 2025
 12:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20251101035252.261-1-briansune@gmail.com>
 <20251103153657.GO6688@bill-the-cat>
 <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
 <20251103200959.GR6688@bill-the-cat>
 <CAN7C2SCY1Q2_YcJWVMs0Zv+ymcuXLXEhrkX2JGcJviOaKDf0sQ@mail.gmail.com>
 <20251103204237.GS6688@bill-the-cat>
In-Reply-To: <20251103204237.GS6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 04:50:25 +0800
X-Gm-Features: AWmQ_blASE-XTqyHrd_9DQYBURpnt_B3RmOBLIr9o4njkRsnT3EqkFhAw_nMtro
Message-ID: <CAN7C2SACKPnE07-dtwc437f8xr38936h3RWvP1R5Ha_v1KfCng@mail.gmail.com>
Subject: Re: [PATCH v2] Add make feature support for SoCFPGA Handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> I think I'm not explaining things well enough because I don't quite
> understand the tooling well enough either. What I would like, but don't
> think is possible, is something like:
> $ make O=/tmp/myboard myboard_defconfig
> ... goes along and sees that boards/myvendor/myboard/myboard.xml exists.
> ... Runs the python script to re-create all of the C files, assuming xml
> ... is newer than the C files.
> ... Now compiles the new C files.
>

No, I think your method is just a bit more complex.
What my last suggestion is just put the handoff folder
next to qts i.e.

board/altera/abc/qts
board/altera/abc/hps_isw_handoff/foo_bar

Then once you run maybe "make prepare"?
It generates the new c sets.

Flow always:
make xxxx_defconfig
make prepare <- this is the place it should be automated.

As the user defines the board then what you need just place
it new to the qts so it even removes the -o -i user parameter.
And maybe leave the foo_bar naming for user to enter as
it could be renamed by the user during the Quartus project build.

Do you think this is good?

Brian
