Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B2CEB2CC
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 13:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65A78391C;
	Sat, 15 Nov 2025 14:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kGYTywi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD3D83984; Sat, 15 Nov 2025 14:00:57 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83DA8051F
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 14:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c2846c961fso2066062a34.2
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763211654; x=1763816454; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPD8QxV4zzmdg/UTHjEvfV2eBn/GQ7PPJAi/HRn/aXo=;
 b=kGYTywi9sxEnASFMQo8V2c3klnCgJjBAxZObkvgOCoB2Vm12qrfwkBC24XGKcTbsgO
 MUS2qgkKl6szG0ou4q7yec163VFy0wrNw3UM0fK/YsLNsG9BlFvwwT4BfQhOZn5+G+IT
 5Wn4cw38GVnwBn3e63GkAvDNJqNEDavbJOtf00FbjQf4i14zYO4PdluGAihu5qp5Ueke
 c6anyb/DbLlRQ37ELp0wCttccXkwmieJgIBmVi9p9PqEhN6GkUiWDkkzWMlC4PxjuZw5
 0tQz2Zyp60u14+11m5cxh8lB03ItZA7OwEshV1eGivz2yzEG8L3S3Gep8fMiBR2eL6WX
 b/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763211654; x=1763816454;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPD8QxV4zzmdg/UTHjEvfV2eBn/GQ7PPJAi/HRn/aXo=;
 b=leJuNAiTqSh/lYrmywDrYMReq2okQHFV6HrMU0xf6720qIXhbsQLNvss8cAhgI7FKx
 nmDSRtQuIhNLSQv/lFhQRq2WRTnTIo0buxWDqWN9/Qzv5ZPlByHlgFKudz5nvQoDd1fw
 Inr0YPt/6upD9kUtr6insEAusTDEpjRjoI2bYVv3XeyL8IUNyaVSNWf+42LdW9sgniwp
 qpsgJCbGQuxGWuwDxIwc991kQJd+7XzoXFr+Ts0bP3r5zGrJpNDU0JxwDbQh2Q09ia09
 qrLWAH+CGIwleqvpLeuwCxBwVMbmrc6WNXLfDPTo80GV2NO5DYLygnVvwQ6Bn3guWPBr
 cNhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZDVvWCIR0Q7L/VRySRm6snN88vGPvzNCpini9WhzqegAR0NPqE+BgLKaYptszbeRysAoYfg4=@lists.denx.de
X-Gm-Message-State: AOJu0YyAsu63vbmCYtheYNRfyLXYll1PBYO89lIhgwTe1mFTQm9xvuw4
 oXY4xJIN27JoeHnlwp6AAsCQbX6Z1Rm/nZ8ZTwEWfmTobWMMlLOsDW0j17EjI9dXzXis0giJeIA
 LQlgjHebAFIpb1XqhRvGLPXjG7Mzog40=
X-Gm-Gg: ASbGncsWEDk3WvpAEOCn1O9+fmmwNT5kQtyGHZmETbzHgL9ye9HMFbrREQ+cwm9Ds15
 5+c0de04GG8S1Ky/aeNSB/cnmqmNIoB9ovqLtgdLySJWrrFrObqepU4+/H46bElKTbyFZwhITGB
 EFS1RQyjfRpeHx9U3hcddse6hoxIq89/lzY0SrSz4QulIkPUmhOfIag2+01wII0PShn3p/N6+Y/
 0EbdHcwjiX10uosUr1QhR5cz9yagxHIyMBBCRC/AbGjEs9AKGFEkzwWiW+/jiLNf23aMVlR
X-Google-Smtp-Source: AGHT+IGH3Q+28hWJd6prgrGuhBKlHLMJA8CCuYtPUU9mHdMQ1qBM6jbO6bv20CZpg2GIYNbrEBVueumqc+MaIMtHC9Y=
X-Received: by 2002:a05:6830:6e57:b0:7c7:2cd3:5baa with SMTP id
 46e09a7af769-7c74454dc56mr3362149a34.34.1763211654301; Sat, 15 Nov 2025
 05:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20251115113118.783-1-briansune@gmail.com>
In-Reply-To: <20251115113118.783-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 15 Nov 2025 21:00:43 +0800
X-Gm-Features: AWmQ_bk3Y_noheh2mzqq23vdm3D_T-orYsWKd2XdieE3JFEXyY0mE2N7-_cYnnA
Message-ID: <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> This is a quick fix to stablize what
> currently users encountered bootup stall.
> This fix is found under board boot trials.
> No logical code can be explained why it
> fails the SDRAM calibration but applying.

A bit follow up on this patch.
When user turned on the watchdog on
u-boot-xxxx.dts while having the original
setup triggers the SDRAM calibration fail.

While users those do not turn on the watchdog.
w/o this patch could be fine and not sure
what is  the proper way to link the dts and
watchdog driver accordingly.

Always included the watchdog driver should
not be harm (correct me if not).
What the dts does can either initialize it or not.
What w/o the driver and dts setting to "okay"
does break things.

So Tom I am not sure based on your experiences.
Always attach driver and leave dts to do the job?

Brian
