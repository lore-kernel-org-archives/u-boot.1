Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F9EE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 13:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1FA8021D;
	Fri, 27 Dec 2024 14:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HumKoaBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220C58036D; Fri, 27 Dec 2024 14:55:12 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA12A8021A
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 14:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef87d24c2dso7476246a91.1
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1735307708; x=1735912508;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M8XUSDrs1aryWiAEihSARQfBU/JydyNeM4pq8qvX2ss=;
 b=HumKoaBVtkDw0+7pl4Nv1MeJTmYHCsWeKXCGSnyUy2SLoNWzcfZjeSO67gIdKXJFFU
 M2qxVfw6ZkyjfBKR5h96w9uECRAcNRNf//i+Vg5SQPkOjHwECMbR+G05zhSL3XU3qa3B
 n2xInAfhSl/jLiY4SxuWoSebqXOeNuFLypttY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735307708; x=1735912508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M8XUSDrs1aryWiAEihSARQfBU/JydyNeM4pq8qvX2ss=;
 b=WaAMVh5X9Sne6ez7cuxpapQ4N/3gYDcCCCO0Ne3o2KCyjoVA/A+skkOJ8aj11JGXxQ
 koLbbZ9zfNbrO7BXQHx3qKoPE5KHKakjqUAhaCh1BezZpT/eUoizMF4A9sOTZeA6MKfg
 +rbRBpdG6wp07hmenkdDsVwRI5nqMUtVnA4CowmrirgUId8rW/vmFrY/TvrOCv8rfz9T
 GhzmClCNj7WmezdpVUi1bMhP5i102X1taa5tidsHUyswRGmlAWFj9wO/LCnalHrG5YMc
 f3BHzXSFhXWmzb2Ca0ycRhqJ3y2lp7nAig+8k7KxNQG0LnbJjXktweTwXz6ItZXyDHbl
 72lg==
X-Gm-Message-State: AOJu0Yzi5XnFVbKXy4xwg6XxLByoDoY77recr/38S5z983N77WqNYiDh
 inFZ1SMtf0v7CM8xr4jAdlyt3COo7GXsod5zYBk8BhDZ1OpigpZ3Z6KYyCcXes2HvbyMJmNvRFE
 RgpL10HEJslhot8SXOMo1xGMM5slNVUp79gDvDAg7Vg3iXeh4fPI=
X-Gm-Gg: ASbGncspwTaBqt8Cdnf34xbOZZiPWy3LPe8X3NZ7L5O0YqOpXSPQocB+XXqiy+jf0Up
 B5p+O1BTtXK13CeVoAsU0MxsSqBg1DePHTuk=
X-Google-Smtp-Source: AGHT+IFbIQN/J4PyaovBESKVAzsFbOgiOjLVtD4b5FgKSdCCSRzkKaXrZY8Myy9ZfpB8q9qW1pwxrWeJjQzZ8vV4Ijk=
X-Received: by 2002:a17:90b:2f04:b0:2ee:f80c:687c with SMTP id
 98e67ed59e1d1-2f452eea767mr33189009a91.31.1735307708096; Fri, 27 Dec 2024
 05:55:08 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR06MB89261150B5D747962890634DAD0E2@VI1PR06MB8926.eurprd06.prod.outlook.com>
In-Reply-To: <VI1PR06MB89261150B5D747962890634DAD0E2@VI1PR06MB8926.eurprd06.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 27 Dec 2024 14:54:41 +0100
Message-ID: <CAOf5uw=0tTbR8-sYFbFyx4YmF6AkZ=Avv4CW-aN8E1myz-+NYg@mail.gmail.com>
Subject: Re: iMX8MN: SPL not starting U-Boot
To: Ayrton Leyssens <aleyssens@idtech.be>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Il ven 27 dic 2024, 14:17 Ayrton Leyssens <aleyssens@idtech.be> ha scritto:

> Hi
>
> I am having troubles booting an iMX8M Nano board.
> I compiled U-Boot and flashed it to an SD-card using Buildroot.
>
> The board starts my SPL, does the DRAM init, goes back to BOOTROM and
> eventually goes to the SPL stage where it should jump to U-Boot
> (common/spl/spl.c - board_init_r  os == IH_OS_U_BOOT).
> It proceeds to 'spl_board_prepare_for_boot();' and finally to
> 'jump_to_image_no_args(&spl_image);'
> After which nothing happens.
>
> I added some print statements to see the contents at the address it wants
> to jump to (0x960000).
> The contents of my BL31.bin are showed on that address, is that correct?
>

Jump to ATF and then jump to U-Boot. Maybe the ATF put the console of
U-Boot in wrong domain. Is an upstream U-Boot?

Michael

>
> Any help would be appreciated.
>
> Ayrton Leyssens
> Embedded Software Engineer
>
