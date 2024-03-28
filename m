Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB092C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A30880A3;
	Thu, 28 Mar 2024 08:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iY3wbVbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5385287BF4; Thu, 28 Mar 2024 08:08:53 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09943880A3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2a0782f0da5so1271895a91.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711609729; x=1712214529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ozddIoMdCX8zRCPaAaFwKuAOg/eG7ygUE3X+1kUBE/M=;
 b=iY3wbVbIIVRKz7AerEvIWizXmVUrlWiJnXMgVrb6R4DiIUkywo+UOiB6ZU4f9swvIo
 LQnSvOmuXXcTraEVSmAE/wRHj9GShNWFbAsfx1QmFHYNR94HJQ1BggwbuyPl46Mk9yMP
 EXw4EXCzKk+Saf/BTZ490gcPrtcB3FGuK1h3uVhlaaI1S4VrI3XyWNOHJmviUbn0bK8s
 083Qp2U7p84z2dY649e32K+74EzJ0/no9W+Lsn1rfld/GQioqBQhI5JQIzS6fdjx8AwK
 4ujEV7rI6NHRC10sKpvkKM28LTD3Yy3KwNVj4KkjYLhGpmBIDUCBc3jwm8ZX4Z1YhMqT
 OzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711609729; x=1712214529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozddIoMdCX8zRCPaAaFwKuAOg/eG7ygUE3X+1kUBE/M=;
 b=aAJ4VyaBPE6E/kP+TM1oTNrf9umMUSdJnUWt1bXZVGaEsuLMCp9yxIQK0la2qw156q
 98mvo+o/0RoezizNgzb1WuKLqq0aJAq1FUkzdBDjNQWwjFgGM2nlgT+kXlUHqDJJ/gva
 xBm1Jx4AAe9LR/A4YL3ZZ4+GXGQrqpjimZY+GupXj3Nqz77i/Zmgl3PsHL8UuOIvBxxG
 LbQcAWVzOf6E7SXOSb6A4AgkABTSy367TpLBifvG/m1AD6gEks71fxk8nzZ7s7z4Gf/w
 uUn28ycoxdNEe77sfabfJ4Tq4bLf2Mf6VEbUud5TlRCE/O0Lel2co2icZJG/Cb6TD2/c
 e2jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9vecmQXLKYyLWfNDerAhQMBE6SU9KBVULsWntcQ4J7jpM8aCc2JPMZzcmiIJUMdt4I/tFWSwnMy/euKK7AJFfjLG2Pg==
X-Gm-Message-State: AOJu0Yxm6bgSv6JjGhjRDJ1izuPH/TB2DR4eCWZVZEcE9ME5na5uY50j
 JT+bZNWZIfS3V7SBKSkhPnwQLlPyul+owl7ifI+Bmkhgbn1Aq8ZCI7A3sxyMeTAYL7BHxMWsuCO
 epWzQKW+tFgI58k0+KYSqAIibfdg=
X-Google-Smtp-Source: AGHT+IGSu6p0KHFRbSvRhpwDGeYDtDIkHj2hKB88UawMgmYCW4yfWnrHKQJ2M2D0At3YF68LrWVOgexkNGp4/ai0CS8=
X-Received: by 2002:a17:90a:be07:b0:2a0:8eee:5603 with SMTP id
 a7-20020a17090abe0700b002a08eee5603mr2236665pjs.6.1711609729370; Thu, 28 Mar
 2024 00:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220728070540.28554-1-josua@solid-run.com>
 <CA+EmdG5+QYxVo27C-u5W6FkuDgcoey4i-md9L4b9cs1gtsv+1g@mail.gmail.com>
 <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
 <CAOMZO5AQArxRN25J0+M1hjNSwBQUoLsGhD9cChDkfUrv3ys=Rw@mail.gmail.com>
 <CAOMZO5AjeShry9xQRpEq==zswOc=aL5RoKyL=Y439t1wtkKRuA@mail.gmail.com>
 <CAOMZO5AH0BS_Jhx0jR9gj_cAuPPzVuVM2FeWF2xh_RiXpSkOQQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AH0BS_Jhx0jR9gj_cAuPPzVuVM2FeWF2xh_RiXpSkOQQ@mail.gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 28 Mar 2024 08:08:37 +0100
Message-ID: <CAH9NwWcnG+z5_U4vpw8udcBTomwH+6dRvwRBOEKFJB+41QP_Xg@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: fix ethernet after synchronise device-tree
To: Fabio Estevam <festevam@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Baruch Siach <baruch@tkos.co.il>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

Hi Fabio

>
> > I took Josua's patch and modified it a bit.
> >
> > Does the attached patch fix Ethernet?
>
> I forgot to delete the old ethernet-phy nodes.
>
> Please try this one instead.
>
> If it works in U-Boot, please also test Ethernet in Linux as we are
> touching ft_board_setup().

I am able to load kernel and dtb via tftp and ssh into a nfs debian rootfs.

Thanks a lot - all my problems are solved :)

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
