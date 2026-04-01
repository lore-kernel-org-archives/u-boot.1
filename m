Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEA9D35144
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5981E84010;
	Wed,  1 Apr 2026 08:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QJy3Axq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC8C84010; Wed,  1 Apr 2026 08:44:11 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DF383F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6501d242e3fso5576664d50.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 23:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775025847; cv=none;
 d=google.com; s=arc-20240605;
 b=SK3TY/8KK7KP2xEGASu144By7pLxarRVy2dQkfrIsHt2hOWg3gDzSmR9rmbM7WyBVk
 erp6gYYurM8o7ywgQxTeMctq+vQIHqbUAsqeVfjGm0fdkUqptpNCALknarN7ANsUaneK
 YkiF54yeF996asFnBh4BDwEqu62FuWfj1+UNZec7+p1kRHUI2ymXg0E0+JEJj3RSIUdM
 JvCJAFZk3E8BTQ4248HCoZPVzJ46ne5afD2OJKr3B0XXAyuaClxKQoDIwX6ONrgjU+uy
 OtBSOYmj0huEas3JXnOvBLc2gahmrKQLa6o9XMcSE21Ak3bul+SoEPq/EupJr/AEKBRn
 kSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jZcZT6ZIsMOsFcne9cUgyY6AhuzNt98aSWqOgcoGd0I=;
 fh=lSFpkYIYt00WImqZ2VAjRCTnKq9YqCMBEgnu2nAxKJk=;
 b=YjsAPURBTfkUgoCi1Rw5SnEcF5GcabH3q2s2lbwcblFy0WANvjJYRrNy9Fpla4KTSj
 xWgaXmLUzv1VK33RtWKa5YC3CpFvG0sO5qz4/gzrKTPJRtZPSGXQ3oWZoWESX5aloZ1t
 PYfLZaPO8AMRHmLuO6Kk3TIK9bk7+S6faI//kDT9dN9sFi+tqBSW1lKbQeerSTDad3QK
 h4yh4jo0xjw6wFR+vXrDtnOOWuPvWZTlqucznU8Pmslx9wpMyIf25vBw0Mk2wa+dtZDz
 9Wf55YUG4AZUMEWywspYh/5g0a7xMim1OK5CseT+huNQU30eBHpIhRKDoMHTMl56Fhv3
 gnoA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775025847; x=1775630647; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jZcZT6ZIsMOsFcne9cUgyY6AhuzNt98aSWqOgcoGd0I=;
 b=QJy3Axq+fp2yV3MPEknlsvcnrEcF4qeTSipNGluzBR2QIQNcyT+LGmJidG6tNc40Yd
 ZPFNhN6rto/1zaFxAZCKouNv+2mDJhymNYewJqcUMYkHM04oB1hFN4pNhYDUHDeolvjH
 cxvhaWDtZaXRgsvwRlYyaFfTllB8KOGTGpnDwBW6imcxNIkz8S6ckdRHk/9O57LO4nJC
 juO7hf686rjk0Z8aqC2HcKUSEqFPgDxVzD91ZyNhe4Ciodz1RXKF0z2I9sMQg1Ie6ZLR
 ghgFyzMnMus+wIOhPzshkHg4jD5S+1WANTYOS6AM/+OkwQ8kKO8VxwLrS+0K19rwQr2F
 tb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775025847; x=1775630647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZcZT6ZIsMOsFcne9cUgyY6AhuzNt98aSWqOgcoGd0I=;
 b=iEXKnLETmRgIjnVC2nkm5pzcKEqBMo7Tl9aXO2Q9HtfrNuSptUUzyFiz+RMGrgY+P+
 IbNTdzyX0L1mGKxstNXwNY4Da4rPo20cENAwjG5hCeN9/CvVD11Y/OQLUCRMYoKBH08x
 bmlRyqvVB93VLRm5LpTSLdFHM39tZiaHd9NFM3fsuagp/JK9wYl2og5dXSegjWmGDq8L
 geKLnwfno3QPCaQSLVtdV27/wVtPo+BGK6DkOMfJ4YSrLqupZ5UsbUzW4Hi8Mm9d1plL
 RTzpAe3KYa8XTznw6l5WP3MIu7lvh7b4KfUPCr0uCFkeeTarS3WxD61oNq3FMYNlMTlU
 0Iyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5vzZoVs/yGyr2p6GSKaB5ObXTkETZEMKjIRrRh8Q1eEDojaMAZQCWIp/gp07oSAGPk4XtXVA=@lists.denx.de
X-Gm-Message-State: AOJu0YwuDR25ovpQR3+Cgwig3gPonS4fbev2ggkB2p0Z4/oyQZgclHZT
 NRxY/Y6iQ5IgsKAQL2FOsH16lvGoSmjcmMFtVeRle8GrHNDBaGoqj62uVQbO4KMNkrMz8T6lmZx
 wtCrmgKpG7q2bmY6/iErcz938L+p/2Z6YL670X/uDZjhcg76j1Fn2
X-Gm-Gg: ATEYQzztBgHJ17lNbNxS58eBzOu2mIHUJHJ9xZog/ezfoJvOBQL7x+Ct2rQbrQiMyUg
 xdTi9RgX2vC2KJDjxcs9jK2OZwkXkVUo6mAjlUsA1U/9SRGk7RAMLHBNG8A2VE5L9MBDejY2y+Y
 dkXTisSnB9qed251PoWzRQ/jjdWoGzJVMijktRIBrFdvu0gHEMh/I6cs02hFU08o8mXV7MSfnqk
 FXOgihxVyvHnLG+rs2nu7Aj2va3D+E1hk5iGLMyawXV2mH/00eLLqp0NAakqaDrYZAWolVVXwRX
 LiMrN8l5rj+gx1zzGlIXY4+RXFhTVN5XLyWkydt7ykIjSTz/aAEyPvtSR0rnwK6Lz3dZxR7G2xB
 TfWcWMtT9xiuseT/+fDNTAnG5Yx9xp4W/rVscKxp5hCNf1xmCTLOt3zTJJl3YJ9crlI4+hmbVj0
 ukOtu0wK+oda8HFMUJdwOXNwSC4EFPut8ozzvqPbM0LfXa4uHg60AFixHnrAW87uLI3DTsnfVqn
 nNJnU8kRpR3zj8Ny6Y0/GVcLsSWsBbyiLt6/Ll8kM8TOT+4+NQHDysEij1/cLliY9kgeqiSC8ZG
 y0ljm3nxx+MI3bem3IWuae4y1aS3fCJ7j/qkbYqVDlq2
X-Received: by 2002:a53:ad4c:0:b0:650:1c44:ccc5 with SMTP id
 956f58d0204a3-6502fdd5842mr1786320d50.27.1775025846780; Tue, 31 Mar 2026
 23:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
 <cbe4109d-7290-4104-8142-076b3296e13a@mailbox.org>
In-Reply-To: <cbe4109d-7290-4104-8142-076b3296e13a@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 09:43:29 +0300
X-Gm-Features: AQROBzAs17DRPQxI238ky9caEe4lFmwfVjzlZwRO0dS22VuvjHj0gSjRnvQkhxE
Message-ID: <CAC_iWjLOJs-C4W=9EcY2DEVRde8Qqmmqb3b3h4+hGn1r9Pab+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to
 determine the memory size
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

On Wed, 1 Apr 2026 at 01:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 3/31/26 10:01 AM, Ilias Apalodimas wrote:
> > We previously added a fdtdec_setup_mem_ram_top() to determine the
> > topmost address of the last DRAM bank. Similarly the overall memory
> > size must be calculated when U-Boot gets relocated to the actual end of
> > all available DRAM.
> >
> > Pre-patch:
> > U-Boot 2026.04-rc5-00012-g5789f787c8a6-dirty (Mar 31 2026 - 09:13:34 +0300)
> > DRAM:  4 GiB (total 8 GiB)
> >
> > Post-patch:
> > U-Boot 2026.04-rc5-00012-g5789f787c8a6 (Mar 31 2026 - 09:12:59 +0300)
> > DRAM:  8 GiB
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   include/fdtdec.h | 15 +++++++++++++++
> >   lib/fdtdec.c     | 18 ++++++++++++++++++
> >   2 files changed, 33 insertions(+)
> >
> > diff --git a/include/fdtdec.h b/include/fdtdec.h
> > index 26e40c3cdb46..9bccd70bbdb6 100644
> > --- a/include/fdtdec.h
> > +++ b/include/fdtdec.h
> > @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
> >    * invalid
> >    */
> >   int fdtdec_setup_memory_banksize(void);
> > +/**
> > + * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of
> > + *                        all banks
> > + *
> > + * Decode the /memory 'reg' property to determine the memory available in all
> > + * banks and populate the global data ram_size with it.
> > + *
> > + * This function should be called from a boards board_get_usable_ram_top().
>
> Is the board_get_usable_ram_top() really the right place to call this ?
> It feels like it is being conflated with ram_top here too.

I don't think so. You are effectively calculating the top address you
should relocate to. You should also calculate the difference in
ramsize. Those two should not be separated actions

Thanks
/Ilias
