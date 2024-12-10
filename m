Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A012E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FF98027D;
	Tue, 10 Dec 2024 17:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MKY4EGsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C189980283; Tue, 10 Dec 2024 17:17:33 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A7580269
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso1095015466b.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733847451; x=1734452251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DSDabWmN3+PQqSUuIeFNdZXyC6hihheJ5Ob8+LFcAMI=;
 b=MKY4EGsa8DOicrsgFf+JClC3V/Qu4RY1diweqEG1mWxY/vKw18pIHgdJ/yyN3poQDB
 WVifTxy0h7lFlJA6F+H0w282TikjQU4JQgLz/ZBqPnZE8Up0MMguwDBhm0jgV+chUBui
 +ImiYL+hxxAFHM7g6PvZMqY/mHwJfFEXJXj90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847451; x=1734452251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DSDabWmN3+PQqSUuIeFNdZXyC6hihheJ5Ob8+LFcAMI=;
 b=Ou6WQqh+7EZ0lekoBcxZ+QtLypKKvJ51eecW8MldKCOAhYfgBEpfLjt5FdaevULVr0
 eX0arBQK/PNDxuVSDGp7FQL4Ab6gGu42FlywPHa73BZm+UKO3io2BgAuJyxAODveQjLX
 jcIb7WnPRVF+geTlpQFvmPX57eNIdCSjeN2xdOhJTOHCNAErQmyu+gvVx3kPAq1bW8di
 E2icL5mV0OSiNOE7HL5VPNCUivdGwKPpr0HL93hj0t0nv7EUFvZf5ng8Xnrk0Kv2UpTL
 ItnsrDeHErU9phEjT/si2FbjM62OtEVmTzUcjqvBSDghSvUk7fuxAtmaIP2sbvw5uhit
 wA6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0R7IQwxG98msVf3qdtqbYS+EvMbnM1i8Crb4Xwnzcu8rfZcyXwZjFC9O+I3DuKC3MliR6V28=@lists.denx.de
X-Gm-Message-State: AOJu0Yxip2CCxYusYF+IN/eVtCI0IuvEyh5q/OOH+OXw/sDXXECkAgxj
 bT0WUj/aNXXN/ILXCys9NMt7re3mbRafO/40cnGyDhHESjE6PnD8CQnVEZp20EgmwlJsfb5x0Bd
 +HwuNaybPIbhn8dUpXF3UsJC5zNydUEev/9jyTrg05qFCL44=
X-Gm-Gg: ASbGncsa2bb7WT4xqcFu/EKnJSSzzoXpTbxOHdDCComtHBd/x2/moTDgmLSvhSzMbjt
 wIvFV4rv9jBzz6DH6dBCnGcZhwKHCnOuLbSw4
X-Google-Smtp-Source: AGHT+IERosftr1I6L7B0rjA04xRVGEYPh0cnbP2HhAgqx1/dkJ2uiboCEsSCvFrvxTWo0J311FL548FnMt9+9nUFT4Y=
X-Received: by 2002:a17:907:c987:b0:aa6:5e35:d730 with SMTP id
 a640c23a62f3a-aa69cd7ff43mr473461666b.24.1733847451064; Tue, 10 Dec 2024
 08:17:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
 <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
 <CAFLszTgR7A5N5NOpE0HX0j-DqQ5QqLR=391Y5tEJ00HPFfshTw@mail.gmail.com>
 <3ed2af58-9e45-435f-aba7-a07f775f76cf@amd.com>
In-Reply-To: <3ed2af58-9e45-435f-aba7-a07f775f76cf@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Dec 2024 09:17:18 -0700
Message-ID: <CAFLszTj0eQFLf9oD03VTXGCtQH3HAiZUC7YtNgdyuQ01tAg0SA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Michal Simek <michal.simek@amd.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

On Tue, 10 Dec 2024 at 05:41, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
> On 12/9/24 20:27, Simon Glass wrote:
> > Hi Michal,
> >
> > On Mon, 9 Dec 2024 at 11:34, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 12/9/24 16:47, Simon Glass wrote:
> >>> Hi,
> >>>
> >>> On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
> >>>>>
> >>>>>
> >>>>> On 12/6/24 20:20, Simon Glass wrote:
> >>>>>> On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>>>
> >>>>>>> Calling empty function when BINMAN_FDT is adding +64B for nothing which is
> >>>>>>> not helping on size sensitive configurations as Xilinx mini configurations.
> >>>>>>>
> >>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Changes in v2:
> >>>>>>> - new patch
> >>>>>>>
> >>>>>>>    From my perspective there is no reason to call empty function. It is just
> >>>>>>> increase footprint for nothing and we are not far from that limit now.
> >>>>>>>
> >>>>>>> ---
> >>>>>>>     common/board_r.c | 7 +++----
> >>>>>>>     1 file changed, 3 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>>>>
> >>>>>> This is a bit odd, though. Do you have LTO enabled?
> >>>>>>
> >>>>>
> >>>>> yes LTO is enabled. And there are other candidates like this.
> >>>>> Is LTO able to fix function arrays which is calling empty function?
> >>>>>
> >>>>> (without this patch)
> >>>>>
> >>>>> 00000000fffc0eb4 <initr_of_live>:
> >>>>>       fffc0eb4:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0eb8:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0ebc <initr_dm_devices>:
> >>>>>       fffc0ebc:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ec0:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0ec4 <initr_bootstage>:
> >>>>>       fffc0ec4:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ec8:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0ecc <power_init_board>:
> >>>>>       fffc0ecc:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ed0:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0ed4 <initr_announce>:
> >>>>>       fffc0ed4:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ed8:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0edc <initr_binman>:
> >>>>>       fffc0edc:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ee0:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0ee4 <initr_status_led>:
> >>>>>       fffc0ee4:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ee8:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0eec <initr_boot_led_blink>:
> >>>>>       fffc0eec:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ef0:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0ef4 <initr_boot_led_on>:
> >>>>>       fffc0ef4:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0ef8:   d65f03c0        ret
> >>>>>
> >>>>> 00000000fffc0efc <initr_lmb>:
> >>>>>       fffc0efc:   52800000        mov     w0, #0x0                        // #0
> >>>>>       fffc0f00:   d65f03c0        ret
> >>>>
> >>>> No, but maybe Simon would prefer if we marked all of the could-be-empty
> >>>> functions as __maybe_unused and did:
> >>>>           CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
> >>>> etc in the list instead?
> >>>
> >>> Yes that looks better.
> >>
> >> But we are talking about using macro inside array at best with using #ifdefs.
> >> Or maybe I am not seeing what you are saying.
> >>
> >>>
> >>> Michal, see also [1] in case you can work out why it 'stopped
> >>> working'. I could have sworn inlining the function was a win when it
> >>> was applied, but no amount of toolchain juggling could make it be a
> >>> win when I came back to it later.
> >>
> >> Are you saying that it worked in past?
> >
> > I wasn't able to verify that post facto, but I believe I do remember
> > checking it at the time. If you read the original commit message:
> >
> > 47870afab92 initcall: Move to inline function
> >
> >      The board_r init function was complaining that we are looping through
> >      an array, calling all our tiny init stubs sequentially via indirect
> >      function calls (which can't be speculated, so they are slow).
> >
> >      The solution to that is pretty easy though. All we need to do is inline
> >      the function that loops through the functions and the compiler will
> >      automatically convert almost all indirect calls into direct inlined code.
> >
> >      With this patch, the overall code size drops (by 40 bytes on riscv64)
> >      and boot time should become measurably faster for every target.
> >
> >      Signed-off-by: Alexander Graf <agraf@suse.de>
> >
> > Despite this hopeful sentiment, I seriously doubt any improvement in boot time.
>
> I am not able to replicate this observation on arm64 or riscv64.
>
> Loop unrolling is not happening even if you pass -funroll-all-loops flag.
>
> Maybe different toolchains should be used to see this behavior.

Yes, maybe. Or perhaps it changed for some reason.

Regards,
Simon
