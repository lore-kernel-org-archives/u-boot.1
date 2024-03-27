Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857D7C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF038880B9;
	Wed, 27 Mar 2024 12:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gBZcWz+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DA3880B2; Wed, 27 Mar 2024 12:58:26 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C2A880AC
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 12:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29e0a1fd9a7so4420945a91.2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711540702; x=1712145502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ92Ram7A16wUKV6ZzhUVL9HoXJ1+/IKqvMFAryqktM=;
 b=gBZcWz+DDCr/vq4DEFOvzDmk7f616Gu5iP0i9v67DFcQ2SNexpC/dW9Dstx6vpBfEr
 UJ+0Ij1AKheRW0JX8rnp4NMmkW7XZ7EpLFAbzJs2ULvtJWpqr9sJicDd+jbtWMIURYWy
 vZX8WZ65TEfrKHuDODBsuDl0QjJ6X7jY7MIdCXZ/TDXzXP6opbi0SjAbaBu5XAX2myZC
 2dXcA5QpSy10DtO/mdQ3hm1DxxTchoA3BdKrrUj8H/neoXbCIAZ5B5taiDa45JzIZInV
 kL9fnCXJOmrO4f1H1MDSB0E5GY9Py9K2m8AB2QDqhSRGq566xc3oqnQMu+fZs+svJjZf
 n6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711540702; x=1712145502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pQ92Ram7A16wUKV6ZzhUVL9HoXJ1+/IKqvMFAryqktM=;
 b=fXcixXJ4sD63hXRv5nBaxBo2NGamsr0esXhjPBLKngr6w13C/gPAn1NrDmfc25I40C
 q5LAmk9vNph1zcpmmrfCTZrxC6J8dngbrFTjQHhhPsLz15cgplF8kj37/ZQK9F+XVmaA
 fhsBuekSTBA1uI39RCxUkrqtTsakJBmCu0BrG0lJrNNHE+f57qY5mH9maBlX1c493Ukh
 k/pzloOUoOKZadxgJh8h2xG2y90gkEBvxCOPDMD79z7DRwTpFQKyqHQs9sagqW0hUsHk
 CZuPUhUXgqfe6iWF5UfsCBsVWw0vb9wYvbMoHqCVXVOpDw27jvYi51zIzLXyXY02stlL
 MRxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWN4933eMdyQ3aONcSPYxLb8Jvhj7zXQpcC4h0fj2Jf/LNXWF4O4mppA7mmCKdbtfr9kR+hU72rpljx8m96NX5X+0QDQ==
X-Gm-Message-State: AOJu0YxpiuV2ZwwQKCdpP47+3dSIQjHWi+Jth5/E13xXLtLzqVjzleri
 QDdV56J83cNHfNZ1Vm8GPBl9we0IIst9Ptcro1exoIZybLOpikF8v5A3Ad0xh6CW/F4lEvUayHr
 IE0weq1txq3K99kyA6eVFwGhgGHY=
X-Google-Smtp-Source: AGHT+IECtHg8MBUKNJY9vjSro6pm9IU/YFQpjqmqzJu3m7o7ryMWdPwMVfpCZonyv81D6WTT//rcB6pfT8/jNjHd95k=
X-Received: by 2002:a17:90a:ab90:b0:29b:6da4:277e with SMTP id
 n16-20020a17090aab9000b0029b6da4277emr3671181pjq.1.1711540702448; Wed, 27 Mar
 2024 04:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240327114959.2084525-1-festevam@gmail.com>
In-Reply-To: <20240327114959.2084525-1-festevam@gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 27 Mar 2024 12:58:10 +0100
Message-ID: <CAH9NwWezD09DC=Wd_HKD=OOgHbrp+ryLys3nVq4D3o3JVX7a8w@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: Fix board revision detection
To: Fabio Estevam <festevam@gmail.com>
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com, 
 u-boot@lists.denx.de, cgmeiner@igalia.com
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

>
> Currently, an i.MX6 Cuboxi board is incorrectly detected
> as the HummingBoard model:
>
> U-Boot 2024.04-rc5 (Mar 26 2024 - 15:59:22 +0100)
>
> CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
> CPU:   Extended Commercial temperature grade (-20C to 105C) at 26C
> Reset cause: POR
> Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> gpio@20a4000: set_dir_flags: error: gpio GPIO3_8 not reserved
> gpio@20a4000: get_value: error: gpio GPIO3_8 not reserved
> gpio@20a8000: set_dir_flags: error: gpio GPIO4_4 not reserved
> gpio@20a8000: get_value: error: gpio GPIO4_4 not reserved
> gpio@20b0000: set_dir_flags: error: gpio GPIO6_9 not reserved
> gpio@20b0000: get_value: error: gpio GPIO6_9 not reserved
> Board: MX6 HummingBoard
> DRAM:  2 GiB
> ...
>
> This error happens because request_detect_gpios() uses the GPIO DM
> API, but board_type() still uses the legacy non-DM GPIO API.
>
> Fix it by using the GPIO DM API in board_type() to read the
> board revision pins in SPL.
>
> Reported-by: Christian Gmeiner <cgmeiner@igalia.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Tested-by: Christian Gmeiner <cgmeiner@igalia.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
