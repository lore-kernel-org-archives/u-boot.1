Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9894FCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2405836D1;
	Mon,  3 Nov 2025 19:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MnLkAJoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5615838CE; Mon,  3 Nov 2025 19:56:10 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828168331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c29466eabaso1248265a34.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762196167; x=1762800967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NJ4b83dOJrien/Nmo/SYcAOK3uocYIXxW3N7l/sfohw=;
 b=MnLkAJoDQm0p4yDxDSiBgKsCt+O7Eq3BbJbSZ9HtLZr6ilsUPOYk/32sXRdC40SBpk
 YgCtFNnL1g+BMWACw4Xlws+EXV5Mv3Yu6zK3HLxMKTBgbU9arEsf0DpE2V4C87x0BWSv
 yD/dHjboMsPxds49J8A+YLDxsFTsrNxK09/UYXaB4YL8/jK5zuwiB9iq/AUzW4F2D+JR
 7628Umq4nlBZFhBAl1ZR9iNDRAOPn7+QcjrAkqV3iMKRK2S8d6uSFaO7CEY6OWOVZ1rl
 YPDH89PrQfjlbHo8RLhs+QPPg2VQqXUstUZGLCIlva5vN1nWc4wxbWZoNZPejXpCNfh3
 1iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762196167; x=1762800967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJ4b83dOJrien/Nmo/SYcAOK3uocYIXxW3N7l/sfohw=;
 b=YL4SDzkvgR22ufTVUZiwPydDPPQU4eDn4wGNc6EdJ7dqEGkbFQsRMiH65z2/5wVeM4
 PDRuFl4MhF5oVo0PiA3BlM8R/vD3gE+GMLUInQp7jtRVG3CTQ33ZkB3KBa9b6v4YbrIC
 VgT1e8/abdEOsDorxDOjQrjkYY2lzE7+WncD3Wwy8Z01aS6OcpBkKBzyNfFU+l99Y3gy
 FlX6Xyn1o4LNMtsyOw68A5j/XFjz3g5mIIIrN1C7GfVZxwVhXyu+Meb4EBWozGClEfJE
 dw5rOpf+yC4KA6Rz0gzEZBB/0+eCnQPf/TInE6cLY/2ro0njpMMotCNDa3oeeml3gLx3
 n+kQ==
X-Gm-Message-State: AOJu0YxfIm40VFslwkethZIpLsEmazXXDErRRnLNPfL4s20VaJJ3mauf
 2pnrbIq+n0ntnhcdlrfTC7oK9gVPgXP374HkzLmHEZ5yVM2gg+TR8Mqa+x8YbJmLBcYfm+CaavV
 Ac36udW+HHbtSU62KMC3GZbmlf8z5uoc=
X-Gm-Gg: ASbGncv72VO3xUwwg2clB9gz6W5dLCkh2R9DD2RM8qEQdlka7oD7MZ8xWtVlpZGmoBy
 JILAz5cQu+kZoCQrRtzTyk9a36sdksqWK6KiJiD2FtaCP/1Z8OE2sy1NdlXL3T1edEB6Gy4W37F
 6U3uYPJgJ5Vxnoe9OOXFQIinVUOtcGQpfYGqYgNndEzRvn5b7LGHW6esjn1Bc6k0TgEXCUHKlO7
 0lSzSkBl6tYpbxOZVX6a1QUbfePtLhvInvPrnjIdU2r37ba6SWWXBX0rj7Jqg==
X-Google-Smtp-Source: AGHT+IHlPm37/Eoqiv1/TiyoX/nE8DL4rQp+KIolJ5kV1LRVo6Z/KEWBwmh+pRl8YsRUPJbyr5ElN9Oc1uto31s/NVM=
X-Received: by 2002:a05:6830:4422:b0:760:6ff1:2995 with SMTP id
 46e09a7af769-7c6967dc593mr7283869a34.30.1762196166908; Mon, 03 Nov 2025
 10:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20251101035252.261-1-briansune@gmail.com>
 <20251103153657.GO6688@bill-the-cat>
In-Reply-To: <20251103153657.GO6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 02:55:53 +0800
X-Gm-Features: AWmQ_bkjPuNuQaRT1yWZhwm8BPhqY5nVlU6ZHTcGCNRm81Bf8_YzQ7C2DPZM7ok
Message-ID: <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
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

> OK. I was hoping that we could just automate as part of the regular
> build process seeing for example $(BOARD)/foo.xml and invoking the
> script to re-create foo.c and so forth, but that doesn't seem to be the
> case. So, no Makefile logic. We should then instead start on some
> content for doc/board/socfpga/ and document this tool there. Thanks!

Ok what you expected on the automation flow.
I can give it a try. But the build flow for Altera project side
is that the compiled handoff is in the form of a folder.
only foo_bar is defined by user other naming on C5
should be fixed.

hps_isw_handoff/foo_bar/

|-- alt_types.h
|-- foo_bar.hiof
|-- emif.xml
|-- hps.xml
|-- id
|-- sdram_io.h
|-- sequencer.c
|-- sequencer.h
|-- sequencer_auto.h
|-- sequencer_auto_ac_init.c
|-- sequencer_auto_inst_init.c
|-- sequencer_defines.h
|-- system.h
|-- tclrpt.c
`-- tclrpt.h

Documentation is not an issue.

Brian
