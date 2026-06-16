Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52121CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 10:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D5F84119;
	Tue, 16 Jun 2026 12:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vT4KDCDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D701846CF; Tue, 16 Jun 2026 12:40:47 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D0C984105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6626cd98209so4566327d50.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 03:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781606444; cv=none;
 d=google.com; s=arc-20240605;
 b=AI8R4TavLmH2Ildy9Yi//9uAYyKmWrF2fJlqDlLmWTl3/lL5uE12h1VlRUCq3RTJs3
 GG1ZoAjpVm5NwOW1qHg/wnYjWtvkmsT6G3xTxthlyY41jha/WO4R+uXdm0ISja/d4oxA
 3Kv8ZP4CFH183KuVJEMxYsMisuzv2f3fByxz2vZDko9kHGfTd6OJjgRVZTLw0e8yc9wC
 McfhpRRsRNVqLB4APX/zkOmZJq9UqdtVB5rCjfP7bwb7PCVRxzHQ8h7j26Wp702QyvFU
 5cygo9cePi+X7A4SD8iF9PI8tBP4NzOJSIGtnHL0OzEBl+QWdK3Q1PliArY6JCRMsH79
 ZYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IF5WCDDUxz78z6QIZB8vCf5y6/6ge9hfvfqqJWiBryA=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=Htf9+Bm3kcH9SNNyLwxQxf5oVNwI2SJ29lrt/dnsaWrNJoe+Rsb2Ls2n9fs9Ve27g6
 0Fnh8l0698G5QcH+jsShd7CBbBs0iMTLTqYWOfmGPJ5oc1drWZLkQgNicta4sIIlUdcO
 g169c60a13+M+BSDiTZa11JsHe/b8PMDF9WP2s3LceaMQoOH+T4pIAiCCri8alQ95IlV
 OmHDz2WTRXrtF5Ksc7GjfomzX3e1IpWxI7uSxzxOvYbdf8dUMEYm9GQdR6IqnFSO/Wdm
 2rR8nt0Q1q/lKVHZIEQ9/FADy2chskYXk1/hbTtAp4cB5VU2Ox6SjgZJF6V+iocht5Vw
 +obA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781606444; x=1782211244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IF5WCDDUxz78z6QIZB8vCf5y6/6ge9hfvfqqJWiBryA=;
 b=vT4KDCDwP8WNLb1LtvVsnPH5Oz5HZOqWs4RgbhpE4Z1oCxaFUnCJHKshFzr2EkDmA2
 ZMZRFkGFE0FzXea6BbvdmnYJrOh8KSYK2CDbL4t/B3cXVw/+GCrNrVk4Pp43qIXtCGD4
 9dPrOsj9Zb/MJeDWls9DpdC4By37bHSvzILN4guRRj+gIoACvzN8+rLrY4wjyi4mQ9K4
 DhqZC44y29q5xBETRkc5pHDnBEgKaRGABdBy756x8R8Ta/fx+K2unWzTue3fs17Jo5/W
 aqFMvfSLQkbQ5QxCAt98CltKXXOMPVxiRj3ntF13I5p21/Ln+t8yBwwpQjyTNYBvK9zH
 68cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606444; x=1782211244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IF5WCDDUxz78z6QIZB8vCf5y6/6ge9hfvfqqJWiBryA=;
 b=U2Iy0MReALRRl4lb1D2EQXtGqR7skJ4+kr4/HtcdITuhXfLmphTHu3wkhfupFQ9CZU
 RJ7zJaRBcxm1OMWnN7RuqkXPqd2GijjeXMy1QQQcXho0BCDgRbhM8fg3I4oLUGud8otn
 1a/VoYcCm7n17mtUc02xAgoWT1uQbzy7FIxrDbtwKkppyB0wrvQ1C8RZBsMxC9eYniGF
 yJwyTwPvl7zTqIk7rreEOmrXWKB9Ypx5FsYM3QyHgJYx6yJ4kwj4Q4AfCTmaVRLlH9bK
 pxEMX0+f+oXH2s7gcVFHC6rT7YABd+xvmtBvdz7f9lFXHGDJuiFufAvbiBiOTXhPpwTY
 zhng==
X-Gm-Message-State: AOJu0Yx4rewXE4vEdPboMUhGeajx3LQOcriae+iMUVsseCtSHbvlaOud
 xsmclVM5/LY87mR13NX831JwWlL3//gLqv5qZlMzbRotx70WLoTnLGc0b3/ZIVATCdR87M3Nu8+
 6tuX6sWqkrJn1KdgJVGyciqWeh9XY0LNp5ula73EKEA==
X-Gm-Gg: Acq92OFVQJWhoG0tXjTYJwjo2SsURjb/KL+m7I/1Zj9RSjJxj3SKTwXFNvwDGfEejCx
 OYrxvmwCQ7TVCmU5VVIwwQLnfWhvRq5cSstH6YGVhZbZOHputFlKWAstn7z8TnN4y/GRRrVY+9J
 botLAZXV9GrpY6ypl8sHii/vqbjYO/umrVJd3KqwSp8Qubue08viZo//KwjOQfSd8CUXHCGU7Bs
 1gGckamfZIREw0PgCUBPO/niajNKfZKCbafHQ58MPkz7fqEa2IdBBEYfKe7GgjOF2+eza7BVSd8
 U+TcIqTAHi59g18Ktpamk9tZHqsiTN1AJg+5ZHu1WV+xObCXSft4BQ17ss/JzuwpB626YXDpbkh
 XvaEpeD34Ny4oqqqJyaK5HWsjSFK0h7hvEqQ+5ugiOYfhEdfRJ5MZ+jeIUD3qT6Vdb+CQhW5+9K
 W4MIOvK2ADTpOBZCard3XQSEu1904AVwBfSGEphJDc3XHW1guRShrMP3B+X7oNCt7/cm7wSq8Uq
 CDyV+vePQcnrvqaXV/Qn87yrtTsc+seitcaURpcqNSMBa6gCXNRncvr8rlk21h44CkMnscPkYJU
 7GBCo7DnDjSfvzu9FVmUvKdxeGOZZ2xIR9DYc3ZRvz814fiAzpDJrUKRdoYkAyAu18iAU29DkTR
 gfgfKvw==
X-Received: by 2002:a05:690e:1489:b0:662:a4ee:104b with SMTP id
 956f58d0204a3-662b614e2aamr2122354d50.48.1781606443854; Tue, 16 Jun 2026
 03:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <b7449d8c-f4ce-4112-9060-3f76963813d2@siemens.com>
 <CAC_iWj+twmGF84XQTHRuRXUU872Zr6W2_C53KzKS5oZbOC43Cg@mail.gmail.com>
 <ddc049cb-fce4-4941-83fe-f7ac38633fb6@siemens.com>
In-Reply-To: <ddc049cb-fce4-4941-83fe-f7ac38633fb6@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Jun 2026 13:40:06 +0300
X-Gm-Features: AVVi8Cd3eUrHwP2ksssFTVqHGhlb4MNbxJdfDiq18xJpX1tQv-FZg_ghGAUNdlc
Message-ID: <CAC_iWjK73JCHY+UvDBpYUDKCWRPbB_Ez+w45adk1=XuZah3GtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

On Tue, 16 Jun 2026 at 13:34, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 6/16/26 10:40, Ilias Apalodimas wrote:
> > On Tue, 16 Jun 2026 at 11:12, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >>
> >> On 6/11/26 11:57, Ilias Apalodimas wrote:
> >>> On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >>>> [...]
> >>>>    /**
> >>>> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> >>>> index eb6afe49e77..db3f6f486e9 100644
> >>>> --- a/include/tpm_tcg2.h
> >>>> +++ b/include/tpm_tcg2.h
> >>>> @@ -162,12 +162,14 @@ struct tcg_efi_spec_id_event {
> >>>>     * @log_position:      Current entry position
> >>>>     * @log_size:          Log space available
> >>>>     * @found:             Boolean indicating if an existing log was discovered
> >>>> + * @allocated:         Boolean indicating that the log was allocated by u-boot
> >>>>     */
> >>>>    struct tcg2_event_log {
> >>>>           u8 *log;
> >>>>           u32 log_position;
> >>>>           u32 log_size;
> >>>>           bool found;
> >>>> +       bool allocated;
> >>>>    };
> >>>
> >>> I think it makes more sense to define an eventlog state with a u32 and
> >>> replace the found boolean with it. e.g
> >>>
> >>> #define ELOG_FOUND BIT(0)
> >>> #define ELOG_ALLOCATED BIT(1) etc
> >>
> >> Is there a specific reason why explicit low level bit operations would
> >> be preferred? Since the structure is only used as internal data
> >> structure of u-boot, what about declaring bits like this:
> >>
> >> +       bool found:1;
> >> +       bool allocated:1;
> >>
> >> Looks like that style is also used within U-Boot.
> >
> > With the patches I pointed you at there are a bunch of booleans before
> > this as well, so I doubt declaring bitflelds will make the struct
> > smaller in the end. Padding/alignment will probably give you the same
> > size.
> >
> > OTOH the patches introduce more states that are conceptually relevant
> > to the eventlog.
> > The updated struct looks like
> > struct tcg2_event_log {
> > void *log;
> > u32 log_size;
> > u32 log_position;
> > void *final_buffer;
> > u32 final_position;
> > u32 last_event_size;
> > bool get_event_called;
> > bool ebs_called;
> > bool truncated;
> > bool found;
> > bool allocated;
> > };
> >
> > The TCG2 code behaves different if GetEvent or ExitBootServices has
> > been called as far as the EventLog is concerned. So I think it would
> > make more sense to encode the last four booleans to a 'log_state' (or
> > something along those lines) variable.
>
> To clarify, you are asking me to change the code like this, right?
>
> - !elog.found
> + !(elog.log_state & ELOG_FOUND)
>
> - elog.found = true
> + elog.log_state |= ELOG_FOUND
>
> - elog->found = false
> + elog->log_state &= ~ELOG_FOUND
>
> If that's what's preventing the patches from getting in I will do it of
> course.

Nop that's not preventing the patches from getting in. That's a matter
of taste mostly. I was trying to see if we have cases we need to check
or modify two states at once, in which case I'd prefer the u32.
Otherwise, I don't mind.

Cheers
/Ilias

>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
