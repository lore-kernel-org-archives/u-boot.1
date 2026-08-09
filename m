Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9CCC5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45CF1405BB;
	Sun,  9 Aug 2026 00:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrenUxRmdQSt; Sun,  9 Aug 2026 00:34:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6B26405AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235646;
	bh=mo/RF9Ie75pnUp5U08z86GEXLyaZfJorjrDj8FkwFHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eN6UzkCusnuB5OQugV5LjUQAbjopFa9NzBgaE3qUvMfEEgWH0K0+l5kJHiMEPg7p/
	 TKtOEsu4DRev1KA92z7eBJlzvuHu+VJ/R7iEH3k+eZwsWhRc0SEJQPwsTRsTag1Poc
	 2vuzYGs4hcQtW7dHAgbKEDfgf4G3euHcZGV/VETqrbObo/722/9SaCkEI5EI0lXqUg
	 VzhC9jW3THqR86ZBuEtDe+vWRiWpD4CRIj4/DPl+mrycfb1r2W3Pt1ejEpjBuLrhoI
	 sFmt4LKiYFmzciQbp8KAfo4QIrzfggmZALK8qXBWFjLz/46LGDKuRG3blnD5CSM3xA
	 3DSSrkRG8M6xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6B26405AD;
	Sun,  9 Aug 2026 00:34:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62297296
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FA2180D9C
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bVSjROhQ1xxo for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:34:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2E4F480D97
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E4F480D97
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E4F480D97
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:03 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so1044393a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235641; cv=none;
 d=google.com; s=arc-20260327;
 b=JlMp5x/8qV37YX7neE7V0xRfSgl+sK4GkEHbMxM/b1Ck0ylWX03h8ZvwBx+PZUlbd8
 FY1lfvEi4VIEq3QgOIvcFgWdCaV7yAV0M/K3T7ZzWC/fM/bdLLAFzB1sRTVg+Rny+WZS
 5MzYSnst4oXugLr7KwYkGlWXbjDcLYseSh4BtK72FOU5aMzAA/pDfA4OkKnhh1S1IhoW
 CePQY1zsidVK8my5S5pOMSe0qf5kdjbqzns2maI/kx7o/eiK+4rV7D8RHTOBzN0YaJWw
 Xk/2kqsfA90d/6ouXt+9Fh13mU5wiMDIhmzZEnKAeSSZ/dmrAGSq8F66WmgsDg+k/Z+7
 PQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mo/RF9Ie75pnUp5U08z86GEXLyaZfJorjrDj8FkwFHU=;
 fh=Lsvb378PYsd7oR6GMbT31K8p8RernAV81/LeSrv9Z4g=;
 b=F/PfMHA3+CHM+02doKAvQoktLlwSWnek0IwJNBLxGkkg5apsR2OZNScNzPTqyzbQiq
 UJNuMhiBbNC0Ookrh5gHB41rnBQc3F94K9ql8b4/N/uQr8WyurFyXkbsZz5skZKZe/SL
 36bIjcyFNO206fCc33zgjxSPeL+ZSbwzoJzN5Ldz+YMSbsWYRHC9tUqqSnIf8cfcUr4p
 eoTViGdDhL25xHIQNLBPTi1R7YkBGGRLq/3aRacw7/KoH54sa7gmtBEvaqYulvLCZ2k8
 Kfj2oyZvlilB6sVUGA/dzdkXP+opqcRZbyPHgTZpr4xIPC8ztpcYyHEj9eeHnTFeeR2l
 2tig==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235641; x=1786840441;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mo/RF9Ie75pnUp5U08z86GEXLyaZfJorjrDj8FkwFHU=;
 b=b95GYF6iGEaloHpTcZ3+fqw7KAu5qRTAc6oobQBjRNne/O2O/XIC9cir5Rz414JmiY
 oDvJsijJUKB02gTsWATyPagQmA+jG3+FPRPiiNxAWOGc2vPlCcN9LJ5s3B+RaTd4KETz
 d+3wLOXsdJhnu8xmBsVRy/MHuCf10YrLei86BwhXZYZ8sdMwQeJnHW6SSIrs+OVsT4O6
 82jU4tvH9ruw7gbQvus/zMTaCzzxtm6AOfJEFBjPQ+v0fRymkg+MWNFYBm6PW2IAaS+u
 wYu/aI/qEpZXYOsr9h23OUDSrpQrmjzIZtt6/0Isk3QfDB1KuEB7Vki1OffLOEK5X7Yt
 XmJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPcQFaqULQFvOTjnonxO9CI/yWhVRUTHntOHSNyEmeeHey5BHqgAa6CjDgHan53yqriRbRw0k=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzviHKN1QDRn/v3nHK7aLAKvF8/SpLIuo0NyGbbjXb3lcrs1ca7
 /ou8HD3An6JN/iNRnHbtAulE/i5rvpDh0rHweH5JYQYMYnhB0MiCpVZ59/callwcVBAxdd02JS0
 sxL6SCTEjHUTQuYFj7IXaCX9HtEjYHL/X6e+heFM5
X-Gm-Gg: AR+sD1280grlwBlo0Mk7PkgECrOj8Pj7p8nIo9JsTk9+gr6YktDIw3110dPg8jnhJbn
 OlFilysF0PKkYHN73gDxy2oXGvf4x0psfJXlOBL2YKF42Bc0CdcndBeR5GFhpNvE8UcQP2TwTQp
 1iCE9UDHyv6EZ3C0eBKvjC2Jwo2IFzE4tqSkbOB78dEu2o4DdpsYzA8fz+8NzXVw38qInpsKghv
 JYqucBVdwSwaRVMFLG1ByVwAuVORzKXmMbafa8J2rPu3Yzgw9mM8DaAchrgxaRG+MQCAsPmTlbw
 DeVPA2ZVvZezxTLSCGn0czQ8fE/10g6cGjsMjUNkeZU=
X-Received: by 2002:a05:6402:5d0:b0:6a1:245e:525a with SMTP id
 4fb4d7f45d1cf-6a14f26eb8emr16863091a12.19.1786235641079; Sat, 08 Aug 2026
 17:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260807090431.464978-1-jonas@kwiboo.se>
 <CAFLszThA3502QnQxSGyQL+WPEz3tovqE8VA7512gjVKUPSBMEg@mail.gmail.com>
 <a1436f49-823c-4708-b640-92c67fc6362d@kwiboo.se>
 <CAFLszTgso=ayEMwx+cF9FDPis1VmO4yQYH+3qoxWbah_GSnfug@mail.gmail.com>
 <da12d1c4-d3bb-4b11-82c9-1210ee1ac97f@kwiboo.se>
 <CAFLszTiLeLB-OB_2oXZFNV2Qe+O1LV9PLBjXrtGNNQGg=jsL+A@mail.gmail.com>
 <c7f337f5-6a14-4f90-81c3-eee1b6ddc8e0@kwiboo.se>
In-Reply-To: <c7f337f5-6a14-4f90-81c3-eee1b6ddc8e0@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:33:40 -0600
X-Gm-Features: AUfX_mwU6pmXYkDu7OU29GqRwDi4kmUtlbuGh5fVrGXV5lhkULaT6i6NMDV8sGQ
Message-ID: <CAFLszTjLSjMiBbUjvdf-cz=E6oK5V0ReAPGNxAKZszHBQXSsnA@mail.gmail.com>
Subject: Re: [PATCH] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235641; x=1786840441;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mo/RF9Ie75pnUp5U08z86GEXLyaZfJorjrDj8FkwFHU=;
 b=ASXa6THcm4+IyYDRBVfe3kgyp+VUEGCFmCI3u8SluVj6y8bZ9NQOeTQoErmhQvKgEn
 xnyXWme7UfGEM7m6pb3+y9+SAUgvKlT7PrLWulBoRrfvy72HdwuYMSnPvTY30cJrCQSD
 j0eggMYar16iylQMhjw5ThvpyH3ECIo+iNVGU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ASXa6THc
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On Sat, 8 Aug 2026 at 14:45, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 8/8/2026 3:52 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Fri, 7 Aug 2026 at 17:06, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 8/8/2026 12:00 AM, Simon Glass wrote:
> >>> Hi Jonas,
> >>>
> >>> On Fri, 7 Aug 2026 at 15:41, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 8/7/2026 10:40 PM, Simon Glass wrote:
> >>>>> Hi Jonas,
> >>>>>
> >>>>> On 2026-08-07T09:04:31, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>>> rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region
> >>>>>>
> >>>>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> >>>>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> >>>>>>
> >>>>>> SRAM addressing only seem to use 14 bits, meaning that reading from
> >>>>>> 0xff0e4000+ wraps around and instad reads back data at 0xff0e0000+.
> >>>>>
> >>>>> Typos: 'seem' -> 'seems', 'instad' -> 'instead' and 'possible looks'
> >>>>> below -> 'possibly looks'.
> >>>>
> >>>> Thanks, will update in a v2.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> >>>>>> reserved region for its global data, malloc area and runtime stack.
> >>>>>>
> >>>>>> TPL on PX30/RK3326 does not have any use for the malloc area and the
> >>>>>> generated GD_SIZE is typically around 304 bytes.
> >>>>>>
> >>>>>> Current memory layout possible looks something like:
> >>>>>>
> >>>>>>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
> >>>>>>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
> >>>>>>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
> >>>>>>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
> >>>>>> [...]
> >>>>>>
> >>>>>> arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
> >>>>>>  common/spl/Kconfig.tpl              | 2 +-
> >>>>>>  tools/rkcommon.c                    | 2 +-
> >>>>>>  3 files changed, 4 insertions(+), 4 deletions(-)
> >>>>>
> >>>>>> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> >>>>>> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
> >>>>>> -     default 0x2800 if ROCKCHIP_PX30
> >>>>>> +     default 0x2c00 if ROCKCHIP_PX30
> >>>>>
> >>>>> Just to check, the layout shows [0xff0e3c00, 0xff0e3ed0) as pure
> >>>>> stack, but BSS (e.g. dram_info in sdram_px30.c) sits after
> >>>>> __image_copy_end and is not counted by the TPL_MAX_SIZE assert in
> >>>>> u-boot-tpl-v8.lds, so with an image close to 11 KiB the real stack
> >>>>> headroom is a bit less than 720 bytes.
> >>>>
> >>>> You are correct, current BSS is 72 bytes, will update the commit message
> >>>> to mention that the 720 bytes must fit both BSS and the stack in a v2.
> >>>>
> >>>> What is interesting is that global data is so large, especially when in
> >>>> this case nothing here is really using global data. We could save 16
> >>>> bytes by fully disable CONFIG_TPL_SYS_MALLOC_F, but that was too
> >>>> intrusive to be part of this fix.
> >>>
> >>> Well we have DRAM in there now. Actually now that Ilas' series is in,
> >>> we could take a look at trimming and aligning things - some things are
> >>> long which could be int, which matters on arm64.
> >>
> >> The px30/rk3326 boards do use CONFIG_NR_DRAM_BANKS=1 or 2, so dram
> >> should at least be limited somewhat.
> >>
> >> I think there are some DM related fields that could be excluded to save
> >> little bit more space. With below diff the GD_SIZE is down to 240 bytes,
> >> 16 for TPL_SYS_MALLOC_F and remaining 48 due to the DM related fields.
> >> Not sure this is safe, but the odroid-go2_defconfig could be built.
> >>
> >> I do not think the global data size is really a big issue for this
> >> board, but rk3036 only have 4 KiB that need to fit SPL (2716b),
> >> BSS (0b), global data (160b) and stack. SPL image is down to 2716 bytes
> >> after upcoming TPL refactoring at [1] (tpl branch).
> >>
> >> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> >> index dfdea66cd70c..c5fd6514010c 100644
> >> --- a/configs/odroid-go2_defconfig
> >> +++ b/configs/odroid-go2_defconfig
> >> @@ -118,3 +118,4 @@ CONFIG_USB_FUNCTION_ROCKUSB=y
> >>  CONFIG_TPL_TINY_MEMSET=y
> >>  CONFIG_LZO=y
> >>  CONFIG_ERRNO_STR=y
> >> +# CONFIG_TPL_SYS_MALLOC_F is not set
> >> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> >> index fd116b0cebf2..886c12900ddb 100644
> >> --- a/include/asm-generic/global_data.h
> >> +++ b/include/asm-generic/global_data.h
> >> @@ -174,10 +174,12 @@ struct global_data {
> >>          * @arch: architecture-specific data
> >>          */
> >>         struct arch_global_data arch;
> >> +#if CONFIG_IS_ENABLED(DM)
> >>         /**
> >>          * @dmtag_list: List of DM tags
> >>          */
> >>         struct list_head dmtag_list;
> >> +#endif
> >>         /**
> >>          * @timebase_h: high 32 bits of timer
> >>          */
> >> @@ -228,7 +230,7 @@ struct global_data {
> >>          */
> >>         long precon_buf_idx;
> >>  #endif
> >> -#ifdef CONFIG_DM
> >> +#if CONFIG_IS_ENABLED(DM)
> >>         /**
> >>          * @dm_root: root instance for Driver Model
> >>          */
> >
> > Yes please, that's a huge improvement!
>
> Will send out above struct global_data in a separate patch, CI seem to
> pass with above changes applied, see [2].

OK good. Ilias may have some comment too.

Regards,
Simon


>
> [2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/pipelines/924
>
> Regards,
> Jonas
>
> >
> >>
> >> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/8c8b98a29aa35880b93bbacce8daf68edb537eca
> >>
> >> Regards,
> >> Jonas
> >>
> >>>
> >>> I also did some work on struct board_f which is another way to reduce
> >>> space, if we can find more things which are only needed in early board
> >>> start-up. I suppose we could even expand that to include the
> >>> board_init_r() calls.
> >>>
> >>> Regards,
> >>> Simon
> >>
> >
> > Regards,
> > Simon
>
