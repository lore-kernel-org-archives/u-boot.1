Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABBCCCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B1C83AB9;
	Fri, 31 Oct 2025 20:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cvwuEa5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D891F83ABA; Fri, 31 Oct 2025 20:32:11 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B321383AB0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30cce892b7dso1368129fac.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761939128; x=1762543928; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cDm4snGLdCs+nE7rUsasAGJoF0+CT9igQoWMhA1/UoQ=;
 b=cvwuEa5dR4HwKoRHw+PtbE1l7b9+wE7dq6d49/rLUJZWs6trOBgeIpq4LOZ4Le7iO5
 DGAX09wwhhEBL5Y29u91zw3df5Rmz/f2Ljv6XI9w7QBQcW5q/bG+yv+JTY+SIzgBH6wn
 IwKwXFUYY1Gfl7M/81WfPEGY01hHa58Vi4TRC9Xmv+PzRx7jI1rTI0kxUehpa/+eTkao
 Nc5K1SNV7pO01YaxDyJrKnWEvdJBbGqF6/7qey+TRze0sX1Tkcn2fojxravqJeHKQJyq
 7H73GtFVvPxs171mA1ISNOZVyw1WZ0olouhJqTV/2/U/OdTdRbKJgm1SCl7iWOmf0WZF
 bgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761939128; x=1762543928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDm4snGLdCs+nE7rUsasAGJoF0+CT9igQoWMhA1/UoQ=;
 b=MYBrs//VR9AzvringeQSiDMKPAei1fo5CdrDIUrs9/mRWHFRFESFs+NpVM7lMh+RBr
 fvybk1GVz4iA9ifnoXguWIcK/JBwsTDuxs6QlZn5hhqqR0dx9dprjMzbWPiSynGnqi3J
 RRYvIGChWykRRPiiUxmXNHvgdOkDkbazwuWXeDiYOq+H9AowlK7HGbasBX2B3hJZSSMR
 FYT7tNg01g3B8joYB8DBIRiUSg1B20OO4a05wjuvUuFI0PToRwghj8ZPHT8jdVf1/ofS
 Y+/EVUDUZBIQpq4nzM/HBMHE/SfvuAESMKIUSvRSMlIxHGvAPKjFVRzUx4mlDxKVvzpf
 u00g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK4UK/OX+iM1KICaHcWDzV++NJ9lnlX7ltDJ8UD1KWxmal+Cbd6mYweXQjadm82YB4VoehpPA=@lists.denx.de
X-Gm-Message-State: AOJu0YxUYMNZz2ocXltlqjNt3KNyZJt66thNBdifYVh+fw8uhjtXXpax
 +3O6V4Zx5QT/xl348D93CsyhvK6YTGJa0e/1PW2GlRqHVgAdJByBRJ+YzXwNddz9nsvbnSc7aJl
 fQQicPUVNw96HevQbvC+zk4CHx5WsYac=
X-Gm-Gg: ASbGncuN3f5iwEGbFoK/NdKsmAo28Zk30+zMi7AsN4RcS7HQAQpMuI+jAfcFnWup9IE
 Gz46Nd6PYSepOwPi6iviau+8X5EnCBVUmUVY/n92tkvPKayiQOT5FPcnAwnmVFI+lA0xuhTWZcM
 P4EnqNPwrRzBnyw6MmfFJXxqRFuAra6fUIn72IUQ4HLyQUS6ZBkYdOEq/0EscbiZ0sMnNfZu4Kl
 oM/muzVy7gqdcsqI1A6xZ10T5oShK2UD41uJeUUvARW7+UIDaAQT3XHpzgS8w==
X-Google-Smtp-Source: AGHT+IFlYVww6Iut3PUUtJAPZxWZZ+pfx6DwHPerGVf7gHiY6h0uqRG+8aRULQfD8AKhHug4na+14lVUoHjhU5A7gWM=
X-Received: by 2002:a05:6870:64a3:b0:2ff:a27f:9c67 with SMTP id
 586e51a60fabf-3dacbfbc818mr2304662fac.30.1761939128272; Fri, 31 Oct 2025
 12:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
In-Reply-To: <20251031191728.GG6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 03:31:57 +0800
X-Gm-Features: AWmQ_bmC0hC9e7WBGvY--Ca21lx1ezJWvA8o4q4oMdvvCn7c9DOGPflcOKZeTgY
Message-ID: <CAN7C2SC5pjU8Dg6mPPuwhx=a_5YQ9u7sZYxO24HPf0UcUimGsQ@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de
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

> Adding the board maintainer and come other active rockchip people.

Thank you Tom.

Actually this issue had been there longer longer time.
But I guess most user uses EMMC as final design.
So it bypassed this inherent issue maybe.

Brian
