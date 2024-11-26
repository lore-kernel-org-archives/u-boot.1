Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA45D3B988
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 12:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 853A58973D;
	Tue, 26 Nov 2024 13:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wU+fQ063";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD058973F; Tue, 26 Nov 2024 13:22:17 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEB78969D
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 13:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso892440266b.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732623735; x=1733228535; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=36aNWPiEqxEPm8mta5MLWlvBfIC8w2HUm3cDhO046EA=;
 b=wU+fQ063KwmiyRFge/YnibdGoPRyFQrkZviHZuBW7QuV27IkKGBcAsBmDeU9FI3q1Z
 maguMWgQ3mPx+lAJjx0umotcHP3E/7taQ/s+L0Y74Ioby1ETIK02A5GJbTRDUNYAksw/
 Cryp1Iail59bJxE/B9pVtmF03dlaHIZ7m6yk8dazuq4n/M6dUg/ULmoiCldx/JZtxvf+
 4Iz4lOeMwZQVMVoCb5fDwo7aXGwiMKDfqbWKB3/TtHnvvIpczjO/EbWcnnRmBTHKR490
 1exLt0idWyCvMGdIZgCjEOUhf4GqeTZtXXczmfcAtzrUUSD2VwZC/tH2JjLZ56tXaEjt
 Xu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732623735; x=1733228535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36aNWPiEqxEPm8mta5MLWlvBfIC8w2HUm3cDhO046EA=;
 b=Derg4C25r9PgeWLwLO8qpXXQzrKrAAtC9hUUupJlfiaJFsvOxdu26saRBkrDE190mk
 CPQH7Kadsqw8QzFwx5/XuPsHivjQF7D79B1/xNOIfdKaUAJa8ELgWscO8R63Wdtsn2nX
 +Qi79fKHXATyL7FFPUNDOVST5aljBnxZ9xzqi38OpCVth2J+o4IQbT88iKqgoAbEBPKI
 j4tULKI4GYEdAEiwT6zdxHeP0N98eAvDXbD4F6N6uiENKHiryjdWktBw89A8sCrUf4fq
 G7zuCYKShCXZRu6K50o2lMeVHwPmUXHtH1QPMPLu/UZsddq6ubLw5w+1wqyV4v+49KC2
 H3pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNvyi1xk8yB1ibB1hzUH64wO4pkjS0Rmfom6FNaV8++b9vs5keWrWhVzUuiQc3XVGZZbkccmE=@lists.denx.de
X-Gm-Message-State: AOJu0YwMpRB5Z7ZhLCTHlfJWhJ3oEEy7eLaOiEVta0mzf8boBm5pinh/
 q0YDwFORXPgpg8GLCY0Q+RduY56kTU+be5+Nol8Kd5YSpaweLJPRXMPcyqUgqVo=
X-Gm-Gg: ASbGncuZnrBK0InlCNl/hlwVDEdFX6jXfZN2HiA8u2rojWhiSk2BCDIs4TUiI3PyBCL
 bbr251iVizpKzD/vOdRO0JFcs/pEN2vGiRta/chdwqrMsvCk5DidMFlRkXD3OjiGzQmyn34zwgJ
 uu96dPMgV/d72RJU7U0G8cXzlJCEHqnjnSEwUcsT161V8uom38CzvHUVRQ5TcXoNfhSAp4EnbZW
 uPVuHXFxxZiHyNTX4PKMyQ8KaKnMpDzvtpM7myU/VWqPvWiRGlNRenUroJ7RVaMbAVxnYnSUCJF
 0v1sJ3b9SeDLWmmmlgSPtVuoB1v8aqnw
X-Google-Smtp-Source: AGHT+IGoaM0krpwvvFZP9tKTDMeaVvp2rcuW3+U5L2KrWcIrhwauHXNufNk2m55M4z4Ss3DoFTCwTg==
X-Received: by 2002:a17:906:314d:b0:aa5:2268:1075 with SMTP id
 a640c23a62f3a-aa5226814f0mr1053507166b.5.1732623734923; 
 Tue, 26 Nov 2024 04:22:14 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa54a6c627dsm307547766b.139.2024.11.26.04.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 04:22:14 -0800 (PST)
Message-ID: <cd43db10-4939-4958-97f2-9a2046d82160@linaro.org>
Date: Tue, 26 Nov 2024 13:22:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/board_f: init malloc earlier
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241124183832.2476928-1-caleb.connolly@linaro.org>
 <CAFLszThqtA_WBxOU-EnEvw956ZMN9KErx_C4gTzW_+p_tGu9qw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThqtA_WBxOU-EnEvw956ZMN9KErx_C4gTzW_+p_tGu9qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 26/11/2024 01:32, Simon Glass wrote:
> Hi Caleb,
> 
> On Sun, 24 Nov 2024 at 11:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Currently the early malloc initialisation is done partially in
>> board_init_f_init_reserve() (on arm64 at least), which configures
>> gd->malloc_base. But it isn't actually usable until initf_malloc() is
>> called which doesn't happen until after fdtdec_setup().
>>
>> This causes problems in a few scenarios:
>>
>> 1. when using MULTI_DTB_FIT as this needs a working malloc (especially
>>    for compressed FIT).
> 
> Hmmm, how does this work today?

I honestly have no idea, I assume boards that make use of it do some
custom board_f.
> 
>> 2. Some platforms may need to allocate memory as part of memory map
>>    initialisation (e.g. Qualcomm will need this to parse the memory map
>>    from SMEM).
> 
> That really needs to be tidied up. When does this fixup need to be
> done? I imagine it is somewhere prior to setup_dest_addr() ? Perhaps

It's necessary in order to figure out gd->ram_base/ram_size. We do it in
board_fdt_blob_setup() so that we can support another use-case where
U-Boot has an internal FDT (which it should use) but the memory layout
is provided via an external FDT which is unavailable (although this
usecase isn't enabled upstream yet).

> we could introduce an event to do 'memory map' stuff?

We could, but considering that on most platforms the pre-relocation
malloc is fixed at build time and at a known location relative to U-Boot
there is no reason for us to arbitrary decide that some codepaths at the
start of board_f aren't allowed to use malloc().

Just moving the malloc initialization earlier ensures malloc() is
consistently available and greatly simplifies things.

fwiw, I had another variation of this patch which dropped initf_malloc()
entirely and just set up gd->malloc_limit/malloc_ptr in
board_init_f_init_reserve() since that's where we set malloc_base
anyways. But after digging some more there seem to be quite a few other
entrypoints into U-Boot that don't go through
board_init_f_init_reserve() (e.g. sandbox, EFI app) and it seemed more
error prone to duplicate the implementation there.

Kind regards

> 
> Regards,
> Simon
> 
> 
>>
>> Move the initf_malloc() call earlier so that malloc is available during
>> fdtdec_setup().
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  common/board_f.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index 98dc2591e1d0..bddfa6b992b9 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -867,15 +867,15 @@ static int initf_upl(void)
>>  }
>>
>>  static const init_fnc_t init_sequence_f[] = {
>>         setup_mon_len,
>> +       initf_malloc,
>>  #ifdef CONFIG_OF_CONTROL
>>         fdtdec_setup,
>>  #endif
>>  #ifdef CONFIG_TRACE_EARLY
>>         trace_early_init,
>>  #endif
>> -       initf_malloc,
>>         initf_upl,
>>         log_init,
>>         initf_bootstage,        /* uses its own timer, so does not need DM */
>>         event_init,
>> --
>> 2.47.0
>>

-- 
// Caleb (they/them)

