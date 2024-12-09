Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0E2E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2768978D;
	Mon,  9 Dec 2024 20:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VjtvpbTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F3C89786; Mon,  9 Dec 2024 20:27:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A804F89798
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa670ffe302so318368666b.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733772459; x=1734377259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yq6k9hoFgQOzq3UA9Sq9G4/3ZgN3kgv9s4o2wJ8L0d0=;
 b=VjtvpbTZzXKcI1NcJwgJ02/cCb6EaKdHTa5PhGw2tXTivWi/Lzmac5i+atQN4TrGi1
 mMC84Ck8SQfHKBEPecYxuWO72NgBZ0peZI1/ZcZSufpLy/m2JlIrjC9kKEpIqCnTsRYh
 HRntjIt6zy0qVCdH5p6EtQ2dm9SNWXNxwXnTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733772459; x=1734377259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yq6k9hoFgQOzq3UA9Sq9G4/3ZgN3kgv9s4o2wJ8L0d0=;
 b=IzkiINXlOQDkcsvY1t8Aj2QoJf5bjMq1en2D3UQ8JbmmSL0RGwkgtr7d9/MMTkfvqp
 3idAMY8myNYEANpxBx7/yNRS9TLBy3EUhJnPXb23VspGzNHMITa8Wj4RJt519FStNZqb
 J/3D+iZCsIRgJtA3/XLTfwGbU8xNrwrb/MGlpHopOX6O3guTf1vSw6t09iDq2L9NaG9M
 f3drmHVxjr1J/qx39tYXgvge7gsrPAPCsXH+FpIbxyMwwlP5vdew+yPE7Gu7DOVfOsY6
 cMf7Ul0jSHFRMPo2S47wbPObKw62omwag25iB4Tv7Q7UEAAzJ/Uq5CtPq8+HQpDPzpSv
 L0Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ7TaxF91UziH0lZyjtiZlqItjn+3c2QkqZ7k6TOSLdNnLDMcuxYaorq5GSsBGo3jHWU99Xqo=@lists.denx.de
X-Gm-Message-State: AOJu0YyBCXISAAD3ysab8U35FhaT274aczURqjFN6h7kip3+jabz9Y3Y
 BKeTqCbXwNI3TsdjT7dYj6Jc7A2fg8EiZOcQbChXeVSzuGXgw3e4u5/eWhEFtmxrx3MSNaWZVKd
 0F5u8q7ue0bK/aPrqMSTqegkXdCdK3Jzi8eB+
X-Gm-Gg: ASbGncsXQ6LDTdVuecxtZ0sjf0YB9XBW8VD0jmOuQJSYyJyNzIcA7M/FTFy3BR6Ao2p
 xarv3FuV7+VeUqoYOIgEtsWJWm8kZbbuU/iMD
X-Google-Smtp-Source: AGHT+IEYm/kJQRnUiIjavtjwvNi9LcnVnrAVR5rwUJErLXJuC909DrONk2Ni4BwMZBdm0HgfXB/avgIm4l1PSdEqrXg=
X-Received: by 2002:a17:907:9145:b0:aa6:8f39:5c with SMTP id
 a640c23a62f3a-aa68f3913c7mr382792566b.17.1733772459133; Mon, 09 Dec 2024
 11:27:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
 <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
In-Reply-To: <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 12:27:27 -0700
Message-ID: <CAFLszTgR7A5N5NOpE0HX0j-DqQ5QqLR=391Y5tEJ00HPFfshTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, git@xilinx.com, 
 neal.frager@amd.com, Christian Marangi <ansuelsmth@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Michal,

On Mon, 9 Dec 2024 at 11:34, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 12/9/24 16:47, Simon Glass wrote:
> > Hi,
> >
> > On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
> >>>
> >>>
> >>> On 12/6/24 20:20, Simon Glass wrote:
> >>>> On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>
> >>>>> Calling empty function when BINMAN_FDT is adding +64B for nothing which is
> >>>>> not helping on size sensitive configurations as Xilinx mini configurations.
> >>>>>
> >>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>>> ---
> >>>>>
> >>>>> Changes in v2:
> >>>>> - new patch
> >>>>>
> >>>>>   From my perspective there is no reason to call empty function. It is just
> >>>>> increase footprint for nothing and we are not far from that limit now.
> >>>>>
> >>>>> ---
> >>>>>    common/board_r.c | 7 +++----
> >>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
> >>>>
> >>>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>>
> >>>> This is a bit odd, though. Do you have LTO enabled?
> >>>>
> >>>
> >>> yes LTO is enabled. And there are other candidates like this.
> >>> Is LTO able to fix function arrays which is calling empty function?
> >>>
> >>> (without this patch)
> >>>
> >>> 00000000fffc0eb4 <initr_of_live>:
> >>>      fffc0eb4:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0eb8:   d65f03c0        ret
> >>>
> >>> 00000000fffc0ebc <initr_dm_devices>:
> >>>      fffc0ebc:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ec0:   d65f03c0        ret
> >>>
> >>> 00000000fffc0ec4 <initr_bootstage>:
> >>>      fffc0ec4:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ec8:   d65f03c0        ret
> >>>
> >>> 00000000fffc0ecc <power_init_board>:
> >>>      fffc0ecc:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ed0:   d65f03c0        ret
> >>>
> >>> 00000000fffc0ed4 <initr_announce>:
> >>>      fffc0ed4:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ed8:   d65f03c0        ret
> >>>
> >>> 00000000fffc0edc <initr_binman>:
> >>>      fffc0edc:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ee0:   d65f03c0        ret
> >>>
> >>> 00000000fffc0ee4 <initr_status_led>:
> >>>      fffc0ee4:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ee8:   d65f03c0        ret
> >>>
> >>> 00000000fffc0eec <initr_boot_led_blink>:
> >>>      fffc0eec:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ef0:   d65f03c0        ret
> >>>
> >>> 00000000fffc0ef4 <initr_boot_led_on>:
> >>>      fffc0ef4:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0ef8:   d65f03c0        ret
> >>>
> >>> 00000000fffc0efc <initr_lmb>:
> >>>      fffc0efc:   52800000        mov     w0, #0x0                        // #0
> >>>      fffc0f00:   d65f03c0        ret
> >>
> >> No, but maybe Simon would prefer if we marked all of the could-be-empty
> >> functions as __maybe_unused and did:
> >>          CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
> >> etc in the list instead?
> >
> > Yes that looks better.
>
> But we are talking about using macro inside array at best with using #ifdefs.
> Or maybe I am not seeing what you are saying.
>
> >
> > Michal, see also [1] in case you can work out why it 'stopped
> > working'. I could have sworn inlining the function was a win when it
> > was applied, but no amount of toolchain juggling could make it be a
> > win when I came back to it later.
>
> Are you saying that it worked in past?

I wasn't able to verify that post facto, but I believe I do remember
checking it at the time. If you read the original commit message:

47870afab92 initcall: Move to inline function

    The board_r init function was complaining that we are looping through
    an array, calling all our tiny init stubs sequentially via indirect
    function calls (which can't be speculated, so they are slow).

    The solution to that is pretty easy though. All we need to do is inline
    the function that loops through the functions and the compiler will
    automatically convert almost all indirect calls into direct inlined code.

    With this patch, the overall code size drops (by 40 bytes on riscv64)
    and boot time should become measurably faster for every target.

    Signed-off-by: Alexander Graf <agraf@suse.de>

Despite this hopeful sentiment, I seriously doubt any improvement in boot time.

Regards,
Simon
