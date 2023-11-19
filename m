Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8F7C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 05:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5472E86D3C;
	Sun, 19 Nov 2023 06:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7gUdClI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F8A86D0E; Sun, 19 Nov 2023 06:01:07 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B5AB86D3C
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6cd1918afb2so2273215a34.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 21:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700370061; x=1700974861; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wN0mAhNB3GeUXrkqxk2jUgeCgTeUWiL85KWlNZs9/Eo=;
 b=f7gUdClI0DXL0QYD+gxFVvPL5bTzF96RCUdoUu6XlOcJMbpKG+7Ut9A/VnJA7p+hSp
 zD+QyiPILXGQdul80rpUu08blh16iTizCOZnSji8Rsd4qNIhIOQfIMluNdCHKOyvsIhJ
 wCBeCY6D9YwHwJxX/c0PresLODayi8t4tVESwXZ/rlbRFK/oCERnqAbsH7S8nyo26KZm
 +HnD7reLJo0CQhVrBRbLuG8a23ap3h9tLE2HaZe2GCOI1FXL6aPxbr1cFytshF2rcfsF
 e626Z10eU3m7QuhryJnmV8rcG/WMN8LD2c2lSxFS39onZdrg5ueQ5fOZm83V53lQuvt1
 8QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700370061; x=1700974861;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wN0mAhNB3GeUXrkqxk2jUgeCgTeUWiL85KWlNZs9/Eo=;
 b=oaqoGU+QKnnLydYAFkxrnjUv4KjAIB6MIIfXhs5zwc0GpG2XhYKzAY8WP3abAKlDwK
 lmlRrxz7gLDeHU5m0XThh7dmFunNNv+g0PTfVKEkSEYvszPve/EFJCKushwMq+sG27B/
 2LMVcGzjSlQZowoKuzyq93thBeD/trlLEWYOA4a1agepAN3mDMoteiRFx2PY32COaDJt
 LPp1ueMEpSKYf6wP+NpU5QDCnNaYjpMvzT9bnHL8cpOZX3BgCbcqqWDPt2uns6Zwzl9p
 ftwJI04MKZuwE7YKH7bFkHNQV+sORJ3E97DkeP0szhFsFO67ERfaJam9xOmvooc39nwE
 1gRA==
X-Gm-Message-State: AOJu0YzZuEDDtjLYrB59t2aR8PPBGPilMZbwYkWI4M7SLkNf+t6gw7R5
 bhOEQNi+g9VvsQCQrCxIUjY=
X-Google-Smtp-Source: AGHT+IFz/sINqDiCBaf+e3ZUu6xxTqpG/V5S6mAUaknMmG7vornjsGOXimLNtoHhfBVmqJWlkgOuXA==
X-Received: by 2002:a05:6870:aa8a:b0:1e9:b9e6:98db with SMTP id
 gr10-20020a056870aa8a00b001e9b9e698dbmr5899923oab.26.1700370061228; 
 Sat, 18 Nov 2023 21:01:01 -0800 (PST)
Received: from neuromancer. ([75.28.21.198]) by smtp.gmail.com with ESMTPSA id
 eg51-20020a05687098b300b001eb7196de06sm876042oab.54.2023.11.18.21.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 21:01:00 -0800 (PST)
Message-ID: <6559968c.050a0220.d4ead.53be@mx.google.com>
X-Google-Original-Message-ID: <ZVmWiX7041bo7DaX@neuromancer.>
Date: Sat, 18 Nov 2023 23:00:57 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 1/4] board: rockchip: Refactor panel auto-detect code
References: <20231117211506.1396929-1-macroalpha82@gmail.com>
 <20231117211506.1396929-2-macroalpha82@gmail.com>
 <CAPnjgZ27Ut4mQXtjDYPeMhfzS2w9Jm_MKOhuRRAxJw2Z7A4OwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ27Ut4mQXtjDYPeMhfzS2w9Jm_MKOhuRRAxJw2Z7A4OwQ@mail.gmail.com>
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

On Sat, Nov 18, 2023 at 10:10:04AM -0700, Simon Glass wrote:
> Hi Chris,
> 
> On Fri, 17 Nov 2023 at 14:15, Chris Morgan <macroalpha82@gmail.com> wrote:
> >
> > From: Chris Morgan <macromorgan@hotmail.com>
> >
> > Make the inability to detect a panel using the auto detection code not
> > fail the entire boot process. This means that if the panel ID cannot
> > be read we don't set an environment variable for the panel, and if an
> > environment variable for the panel is not set we don't attempt to
> > update the compatible string. Changes to the code also ensure that
> > when there are multiple compatible strings required for the panel
> > we use them both, which solves some issues that will pop up soon
> > for the Linux driver.
> >
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 115 +++++++++++++--------
> >  1 file changed, 74 insertions(+), 41 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> This seems similar to the extension_board command in some ways.
> 
> Raspberry Pi has some vaguely similar logic.
> 
> I wonder if we could figure out a generic way of handling this?

I was thinking about that. Given I need it to run so early and with as
few dependencies as possible, for my specific use case I think this way
makes the most sense. However, a quick way to get into recovery mode
for other devices would be desirable, and I think the best way to
accomplish that would be to have a way to set the ADC channel for the
rockchip_dnl_key_pressed() routine via a config option or a board
specific define of some kind instead of setting it permanently at
channel 1 (for all but one of the rk3566 boards I've messed with so far
it would be ADC channel 0 for such a button; ADC channel 1 is used for
board identification).

Thank you,
Chris

> 
> Regards,
> Simon
