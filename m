Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98568C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 17:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E03809A5;
	Fri, 28 Mar 2025 18:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0vdLcg+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9673D810EA; Fri, 28 Mar 2025 18:07:32 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B629805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 18:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so2154896f8f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743181648; x=1743786448;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iEYfkC9TGRSuhs7J4+9vnugJ88CcCsz1BTes0YF9LSU=;
 b=0vdLcg+AMplUKlXP5GrsI84RR/MsYzTr2qeIud9uzZDC54XZlXm56XFMIeTpKpcjHj
 gQuvz7hLkkAoQxH4olQd/AEIFp8ewNcmVS3TaIa6EjeX8N9X4VQz2p10LLM/Naf3kMnn
 ewbZCF1CFN7c4nhHG52AtrWW3TJW/3lvMNBWe9bVGF3R97QChVn8i9IB/+D6r4aNHDLn
 7tbWM1ihIf/1YIim8yP48uPPe9GJJq3Qd1ehYwUY6t3QTYh/zjhrh7aNYr7JPRxvLVXG
 OpyQ7LkAM0hQRp0duZPrGFm4jX/zBTYTXWvt8F21ENOmDhkvoAx9VJQabyKFkv5PVk1O
 L1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743181648; x=1743786448;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iEYfkC9TGRSuhs7J4+9vnugJ88CcCsz1BTes0YF9LSU=;
 b=frl8yldhzCwjZGj64dQ1cMtqfLo/iuRXMNtY90HB/6LSGPQdSXmi4caMJNYwTEzTpP
 ARsGvejIa8LqMpviltiy3Mboq8cpIVKokBtEOWsvrBkTJtfbW3qRofqFo8hKu/3bysJH
 jYMBfM5NVVVUF5EKQ1/16YAzxf/uPIAuSd6olOcxJRT9PlIVtnPYUZ/+tIdggBugl6bk
 fcj/aunoaZkjR01mwHD94S570yNzD20/XGY2vuajzFspD0aZGXJ02/A+/bDjKKluTPQi
 xwpDX6eBTwhb1mOJY4nM+c1ITD9u5DsSmK4v14BO1gJMrD0zKfATPLR9mtauflEswbtT
 zqcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp045B6qv0+EBf119ssbwRHaYNOBHreXl2vc8yl4no/7fK+XZ78Br31kwwgj9/9JB1g8Toj4Q=@lists.denx.de
X-Gm-Message-State: AOJu0YywO+2fAX7OHu/sL4DH9ohQaxHjayWiOc4dqvxaxicDp+9loksH
 LfPtwMfzQS0bHQQOjSV3NGYve/efVhhDPMvXLUn63DmpJ3ZMnvm4XCtu2VhZZ0Q=
X-Gm-Gg: ASbGncsK/qpJJzqUUV0L0Cue3JBou74AzGLKBVz/Uix06Bz3KXNu/qN/EEMGsBYFwH3
 L1E5aDcLtBWXuhUA+X3XQc0bv+f0vHPpQ84mi9rfNI8ceXYuGmcJjn/AZF+rdALen1wB3Bi3WDG
 eJu9K7+Wwx6fNcHo8E/ZCJgfUqhtBdXzpDadts8sA0nF92FBTHZh4QUg+Yx8/q+YVStbdRUDVNn
 4zHF8HiuaiTcX5LBv8Xou9d0NBonfrk6doQoxQ4Zf8irmmJQsimOf0K2exl3MQ15beZSurz+6UE
 PBECI0GSjW4ncVyyX/5fB00HUf1zWb8r14Fq5l3QCjWLAiWRNhxNWw==
X-Google-Smtp-Source: AGHT+IHpUTGcW7ti38qGYDVDRmWtv++wJA70o0RurzexF/ydq/lRW7o+2yKTNJsVVCUORVWfA2ixxg==
X-Received: by 2002:a05:6000:2b11:b0:390:f9d0:5df with SMTP id
 ffacd0b85a97d-39ad17751dfmr5372004f8f.52.1743181648314; 
 Fri, 28 Mar 2025 10:07:28 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm3232834f8f.0.2025.03.28.10.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 10:07:27 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Michael Walle <mwalle@kernel.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
In-Reply-To: <20250328155941.GW93000@bill-the-cat>
References: <20250312073655.2281377-1-mwalle@kernel.org>
 <87cyecdpf8.fsf@baylibre.com> <D8RS34QA63LP.296JEK5L3IREQ@kernel.org>
 <20250328155941.GW93000@bill-the-cat>
Date: Fri, 28 Mar 2025 18:07:27 +0100
Message-ID: <87y0wpqe28.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Michael, Tom,

On ven., mars 28, 2025 at 09:59, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Mar 28, 2025 at 10:06:12AM +0100, Michael Walle wrote:
>> Hi Mattijs,
>> 
>> > > Fastboot works either over TCP, UDP or USB. The latter doesn't have
>> > > anything to do with networking, thus should work just fine with
>> > > regardless which network stack is selected. In practice, header symbols
>> > > are used inside common code paths. Add some ifdeffery to guard against
>> > > that.
>> > >
>> > > This will make fastboot over USB work with the new LWIP stack.
>> > >
>> > > Signed-off-by: Michael Walle <mwalle@kernel.org>
>> >
>> > checkpatch.pl reports some issues with this:
>> >
>> > $ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD
>> >
>> > <snip>
>> > WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
>> > <snip>
>> >
>> > Some occurences below could be fixed. Could you please have a look?
>> 
>> I've seen these. More below.
>
> That is also my least favorite checkpatch warning, and it's a warning
> not an error. Best judgement is needed about making things readable
> rather than just silencing checkpatch.

I think that using if (IS_ENABLED(CONFIG...) is more readable in this
case.
However ...

>
>> 
>> >
>> > > ---
>> > > Alternatively, we could add the defines and stub functions to the lwip
>> > > header.
>> 
>> This is relevant :)
>> 
>> > > ---
>> > >  cmd/fastboot.c               | 4 ++++
>> > >  drivers/fastboot/Kconfig     | 1 -
>> > >  drivers/fastboot/fb_common.c | 4 ++++
>> > >  3 files changed, 8 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/cmd/fastboot.c b/cmd/fastboot.c
>> > > index d4cfc0c7a28..be84a482b81 100644
>> > > --- a/cmd/fastboot.c
>> > > +++ b/cmd/fastboot.c
>> > > @@ -16,6 +16,7 @@
>> > >  #include <linux/printk.h>
>> > >  #include <linux/stringify.h>
>> > >  
>> > > +#if CONFIG_IS_ENABLED(NET)
>> >
>> > I think this can be dropped. I hope that since it's a static function,
>> > -if there are no users in the file- the compiler will optimize it out.
>> > Note: I have not verified this, so I might be wrong.
>> >
>> > If you measure and see size changes between keeping the #if and not
>> > keeping it, please ignore this comment.
>> 
>> No, because net_loop(), net_set_state() and NETLOOP_SUCCESS is only
>> defined in net-legacy.h. Thus we need this ifdeffery.. Unless of
>> course, we add the enums and function stubs to the new lwip net
>> inlcude. I don't know if that's a good idea though.

... my suggestion does not work without adding the defines and stub
functions to the lwip header.
Apologies about that :( And thank you for being patient with my remarks.

This patch is fine as-is, and I don't want ifdeffery vs if IS_ENABLED to
block this contribution.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> Yeah, I'm not sure that's worth it either, or at least as maybe only a
> future clean-up or investigate more. Perhaps filing an issue on
> source.denx.de on the -net tree so it's not forgotten?

I'd like to do this future cleanup. I could not file an issue on
https://source.denx.de/u-boot/custodians/u-boot-net so I have opened one
in the -dfu tree here:

https://source.denx.de/u-boot/custodians/u-boot-dfu/-/issues/5

>
> -- 
> Tom
