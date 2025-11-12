Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467EFCD3429
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB9783C62;
	Wed, 12 Nov 2025 18:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTxvQoAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4385D83C96; Wed, 12 Nov 2025 18:08:22 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 305DC83959
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c70c718a3dso746507a34.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 09:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762967299; x=1763572099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o2UcT3nfyA8FgNa4KAycLURS9bVGRFnxj/ln2IYDTAc=;
 b=GTxvQoAYQo/wr6fZBckU28ZA2B76EmW6lW+MxpzmrBtgMGKy/ZK46iE12h4gyGdrTu
 7+B/2zKmQKw6q0h5CoAn5GmTY52cKm4SEymH6i2cgmeFKu1TtJXgNhxSu9SPszanmqrp
 JONd/M8SZXNs7XsSIA2gA6eTRU0k4Jwc0uoZzrrkupI5e68btW5x+gKkANbovtlax+cL
 Nf0MHURu9LU0ZyDAw4jn77zl4yqn2N02fvntyUp2w621+mkYthf4qz8dRB+P7YCZ5pj7
 J4s9Kc2CpR6YHg2vsAaztrmN1dRYeIstT2msFdFLX0qNhNvsulLlS2myY8w9L9v7M8pV
 ZKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762967299; x=1763572099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2UcT3nfyA8FgNa4KAycLURS9bVGRFnxj/ln2IYDTAc=;
 b=N8rF31OHWvIMxzTU07KJZbhliKoeJM0dt7AeeLm1Ld8bE2rjnrGixnleJqyWNXUUd8
 UaCluUDDFXW7tv6o1U2E1iHsc8cF832XWi9pKLCz8fA6xlFJNkCFkkVkY2chq4982HL/
 M3mEaWqRul6cBOj34DYQmIthEnMT7ETCo9KTTwoiQWyw9gGlvmFx5KLC0TWEYhNbtq76
 wzt2lHcNzPgHPERyUtb65lCIzZhr3nyR5i/jh5q2IM4WwXiGmRzeuEO00IEGQHAGWwfB
 zR4ygoyepfL/+WrkKH+YqdIw/NVwyvVAO+bi74O43GlyOVcazsnrdbW/OAm65VcW8XQi
 9Jjw==
X-Gm-Message-State: AOJu0Yw3H8KPPwchfe9oAZGUxYcgN+aDRHGSV5h018a/QbO14ZyD5kQl
 FhDcInM/6EAS+EBpMd6mgaQnPsRM9iAxyqQWOf0+stJ+Mz0Xz/jLRu1fXKRdbEBtcftyaBkLrsz
 FjS0Q0KPcqunHl6cZY4jKwMB9mycz4+w=
X-Gm-Gg: ASbGncv7nSDwj8l5nsg4qfWdzwXsdgWk9cx/QZlYPY2o+kga8JnTB6Tri7CL+r6UGDe
 LFzc5m7mSjb6F3pNx86acXFSiFxs20YIALzrj5E+4Rsp5wm14x0KXUtx2b45N4cXB5QahLmn7Xd
 NDI2qyiWAMXrVXp1QJB7mPsd7V+HmcTU7hnagqZ3T967QXYiWKBLsd8HYjq3hYNqjqqvamlgFDO
 ikJks0o4wH1/L0JWjRneRcmPkhTDw8n0iJnmL9C8T+t3/ks6PZ9St2v8CuJZTacxNSf6gLy
X-Google-Smtp-Source: AGHT+IFXq70rn87FSnxzLh6XnxyGpk9wDfI92krLPbCeGSnfLyiVJLrkB5v7Pyvq9/vqPDoGIKrHuUOCwSWi5vETsr8=
X-Received: by 2002:a05:6830:2b27:b0:7c7:4f2:e15d with SMTP id
 46e09a7af769-7c72e214803mr1627281a34.16.1762967298870; Wed, 12 Nov 2025
 09:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20251110050040.183-1-briansune@gmail.com>
 <CAN7C2SDGh+PZaP2DNOhn3=D9Stw680-7k=Tus_+2r9UQYoAOyQ@mail.gmail.com>
 <20251112164118.GB6688@bill-the-cat>
 <CAN7C2SB25LPkVWMKYFS=DURg2GkarHqo=n0ogOJVn4Ra0+CnAQ@mail.gmail.com>
 <20251112165708.GC6688@bill-the-cat>
In-Reply-To: <20251112165708.GC6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 13 Nov 2025 01:08:06 +0800
X-Gm-Features: AWmQ_bnYUftyzNPnQfbuuJpL2h4CTN9LLjqw4kUU7avdSDlcdmKyCtFwNa9Kd-g
Message-ID: <CAN7C2SBAD_QxE48f95=e77=oMR0gamLTWzfz_O8a6hVYVhvnQw@mail.gmail.com>
Subject: Re: [PATCH v1] sync socfpga common u-boot dts
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

> > > > Do TIENFONG still handles patches on SoCFPGA? Seems like there are
> > > > no action or response on all SoCFPGA related patches?
> > >
> > > Yes, he's Tien Fong is still active, it's just that most subsystems are
> > > fairly slow moving.
> >
> > For patches that really affect normal boot should push back
> > to mainstream. Those patches really fixes the boot and w/o it
> > system completely stall.
> > For those that are more less critical can be handle in slower pace.
>
> If there's not a PR with them by rc4 or so, please do call out
> individual patches that need to be picked up, that's typically how I
> handle critical patches that haven't been grabbed yet. Thanks!

There is one critical patch that breaks the boot completely.
"[v4] Altera SoCFpga Boot Stall Fix"
20251020133455.1870-1-briansune@gmail.com

The other patch that is less critical but SDRAM involves
communication will stall.
"FPGA2SDRAM setup fix"
20251020133554.1901-1-briansune@gmail.com

Other than that are all non-critical.
The original issue is Altera just consider the new
SoCFPGA series and accidentally remove the
if-else case for old GEN5.

Brian
