Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E5DC41513
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 07:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E831A87702;
	Tue,  4 Jun 2024 09:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20230601.gappssmtp.com header.i=@dowhile0-org.20230601.gappssmtp.com header.b="tv8DQVFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A422E87842; Tue,  4 Jun 2024 09:01:35 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF2580E9A
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 09:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=javier@dowhile0.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6c821775f82so2069930a12.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20230601.gappssmtp.com; s=20230601; t=1717484492; x=1718089292;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDuGsjVAU88Wa31o75RNbmBliKTOAWg/dNSMILHDcro=;
 b=tv8DQVFOovLWeNXwjyo8TL/zLwQaYyRPkXZbHcHXU6U76EJrQ8cOE728Yom0wkz85b
 0D3AgMHZ1+0UJcjk2HBCwWkeYRHnqnxGXbjniAR4KPCTaFXsEbDra9gx7C/0lmF0BZE/
 1Qd4RcOboqRb051GUuQPWDvE4xvyx6J32I3cLvf7D+Yxoifx7G71xegjlMh/Hj/U8Hkl
 z0WjDh1XhyvAvVzj21ph/tjvUEvmHrvmx0g/ugTv03hDB7OLrUTtMFFSabF2OPvv2Ism
 vsOC3iup2b9WQefEh+nuvjKfGgvJIuFL7QkQ7sOLcXis29m6zk97XVx6KhgUCIWdg2VG
 Iy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717484492; x=1718089292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDuGsjVAU88Wa31o75RNbmBliKTOAWg/dNSMILHDcro=;
 b=S4lk71ULbn2K/VUJKCD82B9G4Aurzb/b9ec+gGm5Uz3oMdFiLPf8l0o2eyzAK575/y
 i8+q5K4sSZ+9+sB8UkGoqH3zFMxh2/Btij9FGqQGt6gQXJb/Xq00glVSqHF1M15YDeXQ
 N6ph+3nZbdISAR3M+Q5JvQ1MFAmTQxQVzKZo1LbwvBqYTF5QYynbQeaIJVteMkiy392q
 UCFloQkRV5OTD+cxTdf7Ft+GbYJemEj/CGgQRRHFfA6Crh9bA6i6c4P0T6tZlKzS1hmT
 dkL9JAaKdx22T97RcABjxIVkWk66AQXUsQSunPcH7ZfqkSMrNnDXgGO3MU/S1DG/Zfoz
 ONQA==
X-Gm-Message-State: AOJu0YzOtKX0gnXgvNfkQhuOwiS+IKXxjce6Vq64xFsUubtBIS6wJIMv
 v5olMcNnL5BaZLbLBU/u1LSNod5LqhpmsXJPzSPMDp1hH6q4HK3wh9houW39Bn0spSJFvs0jP7d
 xRZb9vSd6VYQ3HJD7Zf6T+Oz6C5oz23euk44a+Q==
X-Google-Smtp-Source: AGHT+IHlP4hsTu1Xhqgp6maTxHQJYmejMV7vEh4LAGG4+vb6wRgb5ASekfkNdXX1hXz2y1ZbBs2TpFAB+2GYCAfHgxY=
X-Received: by 2002:a17:90a:d987:b0:2c1:a58a:1146 with SMTP id
 98e67ed59e1d1-2c1dc560848mr9156412a91.4.1717484491918; Tue, 04 Jun 2024
 00:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240518130622.219031-1-javier@dowhile0.org>
 <171743651627.1565845.12755270495736547272.b4-ty@konsulko.com>
In-Reply-To: <171743651627.1565845.12755270495736547272.b4-ty@konsulko.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Tue, 4 Jun 2024 09:01:20 +0200
Message-ID: <CABxcv==z46ObVPvUDHCknc3s9+wHGZTbBe2jgYyQcEapxH1M=A@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/4] omap3: igep0x00: Fix boot failure and
 modernize the boards support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Tony Dinh <mibodhi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Tom,

On Mon, Jun 3, 2024 at 7:41=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, 18 May 2024 15:06:11 +0200, Javier Martinez Canillas wrote:
>
> > I noticed that the IGEPv2 board did not boot anymore with mainline U-Bo=
ot.
> > This was caused by a driver change to allocate its platform data before
> > relocation and U-Boot not having enough pre-relocation heap size for th=
is.
> >
> > This series fixes this issue and also makes the board support more mode=
rn,
> > by enabling DM for SPL and migrating the IGEP boards to use upstream DT=
Bs.
> >
> > [...]
>
> Applied to u-boot/master, thanks!

Thanks! And sorry for the spam with this series.

Best regards,
Javier
