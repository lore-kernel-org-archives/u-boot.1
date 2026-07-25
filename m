Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01534C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 11:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97D9840790;
	Sat, 25 Jul 2026 11:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UGaNs3bTvO1L; Sat, 25 Jul 2026 11:58:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DFD14076A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784980684;
	bh=lcQbkD5Pq3/JweeyFkXPuR2oHisQCElp5rAqa3yMO1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ub8H9NtiECRJ2K6IjLSSyo1aXF5q5JyEoitO4oKnGTXVk9LuVMnK7iJifppPO54i+
	 FlV4G/nq3/jWth4CbTFhIiziLeq58mmjKDH8p+6PcEuqhNRWsEBgyRyAJODcRuYoKv
	 AHRGBbUhbz0H8W9z5l6JjdcLsJ9f+w1M192Xp6/jmezjP0hvyEpDK2ZkUb98rhGumP
	 9Ste0mKDtE8IY+m0z2Twit9ss5DuRcLVbpdEmN1EYzlkQXaCVIQit2yL/sQvvd36IQ
	 MV9B1wVqnr0TmpuKHQ8welYgZvVK3bXUdsJVe9EyJbujpzjW5sAPm2g7PY+oWyFYrn
	 qDiFPUf/d9g1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DFD14076A;
	Sat, 25 Jul 2026 11:58:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 650CC490
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 11:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56F81400F2
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 11:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OoYp1JPUvyKu for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 11:58:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EDD6A400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDD6A400B4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDD6A400B4
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 11:58:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17AC8800AE; Sat, 25 Jul 2026 13:57:59 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3FD8005D
 for <u-boot@lists.denx.de>; Sat, 25 Jul 2026 13:57:56 +0200 (CEST)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6b554044fso1039414a34.0
 for <u-boot@lists.denx.de>; Sat, 25 Jul 2026 04:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784980675; cv=none;
 d=google.com; s=arc-20260327;
 b=JL+zq2U2XXna7TYdW43guHsjjV5R9tptivY4E5eVWcQWCuHLqaRk/Tp2jfBElmpj2z
 yJXaUHlLsuqZUYckv+XVwrObGU95hOQFtIadhKnSfM52lBJ+WaH92X8jAkyfQLvR/wa0
 c56uAIb0h3wV0ZCeUlGYVZuX7MoDx+zGuFpPD+1oqXBGA3Sq1d7AkZkoxcGzaYJqBMB1
 pCLZXFtQ3/dpKCF0kVQ68v+mQm8QUJbavPHABbZrrZ+6PoZvjN0fYDjy95mwgwyX1Vt7
 pn5q2ZcichaVWLw3X2Y5bb03VoKTCsoXsvB2FzuryPK0Qh2VEIWBiLtaancKargexBy2
 iKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lcQbkD5Pq3/JweeyFkXPuR2oHisQCElp5rAqa3yMO1o=;
 fh=OJShTVXSEQXjlfD4NKPWRhOgtpfXSqnO2zwlw7yYJZM=;
 b=FmdA/xEFZB9kMLNYAzpLNhLe4iQ6a3MoQ813P+alGyKqDuTV5j+xEfGHCrVlEDQGVt
 z0kPBdBv3fBaOFFb9cwwlAt4jdsoBUfB5bHMk8o8I5QoRoln5IKgidMaNrQ9n4NtjRC5
 uRENFsd+TvFG9MtSncNzT7UrHgxom2m0ld3nxL0mRX/9XIqJKshSoUSBP/35nhRKR9Uj
 tL0y9jUVQsfPclZx1sZmVfhxS8Z8z1Qseu2E1SvT3hxbdLd/MRnaLUOTiB0J/jthdAn9
 sk2wO0emuZkNHq7LH/crd1dUps/AjDIH6Q2bZ3PicB4flXhYnO2r7m6IgBWERCbroKui
 UOMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784980675; x=1785585475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lcQbkD5Pq3/JweeyFkXPuR2oHisQCElp5rAqa3yMO1o=;
 b=XjqGwhg8HJjBuAF1HjPW/4/YpPBUWPJZt+OL5BjGKfkXduSc+fuF8sLpNTaw4/bpX4
 FAalIBze9e5GXjN/ThtcJgnSWP5jCjdpFjqdXAgnW94OOJwStIavshhq/gZXM6gYpgYn
 gcAwE5g+pLSGQxw3nKLh1F5pIiH7GMYGekkHxN+2rZ77XJyL1kLwbl8hJQVbkUiVlmN0
 VCOSC5NxsdZUGV8jo5wb+aGt+FY9QNMejNyWqJKxdQCGMEnOMXYriyYX+Da8ELtNorMM
 ADPM54QnF0EG6V73fqYzwOEv6okaXuf8gg1/xt1Le8xbUBTDNSz16SoywH4RkmDy80Rb
 jnXA==
X-Gm-Message-State: AOJu0YwbvyUaI7wM+rbQVxFpywhmMq2iB9jUVhHXPx2VmNrhuUaG9ZvH
 m+DeFRf58OzKOUDKZIolOlMlmyOBjCPWcjdvt63wo6ORVj6TCDOxrLYjhiuOMvvbBEDq8tQJvlx
 yUHbf1oKWQsMBhQ3SdIdbz8WTIkvhhhg=
X-Gm-Gg: AR+sD105fEetE0Y7V9MXcsGDJZAEU9CZbi3QxK+fnI+066Vbl0dwWwaCaGzIGjWou2+
 UO8nTCm01NkMjD5FBpQC47dkQ5cF50wUCraG+jH+BVxOggffC2T/fHugN3xuxOz5oOvX8u0jBft
 ra+aIpKYuk9tvQkyGZgcWM1NSFL3g9tt7R/LohM2pw6iGi1GS62WCLPt3K8CKu7lzAFbODNVfOo
 8//J7FP1Q+S+VogEvvbXiAutZdpiZcSRQh4hjReRogMlPgSGIOgxuMu5M367oycSEVffPDl
X-Received: by 2002:a05:6830:82b8:b0:7e9:c8e3:4473 with SMTP id
 46e09a7af769-7ee78d5acffmr1678794a34.16.1784980675094; Sat, 25 Jul 2026
 04:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260723024306.9888-1-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SDhSzVabXx+EswLksHbQSEyK4GxgkgUVG7Z3Kx7RdS6JA@mail.gmail.com>
 <a4a2481c-fa1f-411c-ac21-380b3a35a4c2@altera.com>
 <CAN7C2SCatXrdU-ObZWW=-sRAO2oa4chFu7pRsTVjcAaqs=w8VQ@mail.gmail.com>
 <0200e37a-7790-4a48-b43c-abbfbb1603f9@altera.com>
In-Reply-To: <0200e37a-7790-4a48-b43c-abbfbb1603f9@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 25 Jul 2026 19:57:44 +0800
X-Gm-Features: AUfX_mzwx0gITMZQfkSB4rdKrA2xmW2Qg4EG7akbYQ9AH2V7hXYQMF94XJWp6zk
Message-ID: <CAN7C2SC-9+NxKsMs_kMu-rUV8E4uicty+v+_HLvdtmud2LYaLQ@mail.gmail.com>
Subject: Re: [PATCH] arm: socfpga: Rename TARGET to ARCH for SoCFPGA
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784980675; x=1785585475; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lcQbkD5Pq3/JweeyFkXPuR2oHisQCElp5rAqa3yMO1o=;
 b=mPoUCa+zMntoHrv1u3ZXTDJ19P6P7yjtwLFWUkzRgc7l8Mw9V5as7kKWe1ky4AnQiA
 Q3GQEyfDYJIeDaPryIVLY3wqRyIBigI/aUtJ7eLgxHjRTk5oC2vqITxADTUcJhLOVYIA
 lH1wA1tSfBexNuFuhz0yVUuApEGM0vvqZkKjpsD+U4GMsrocY/zkt+vZPip/122c4Auo
 1bYGj+xWKjz8VnujqRMC34w71ZGSGez4Y3N2sOOZOC6rkdFvGXEBVIretVx0HUGv9bWP
 tzku2UuZTWmfPL+/nT7kN/pJV275e8lMARLtB+4rxHMuaHlEnniFyOcsPzjPeyyuJ7ZE
 rlzg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mPoUCa+z
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=briansune@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPoUCa+z"; 
 dkim-atps=neutral
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

Hi Alif,

I am not too good at checking the history of these patches.
I think the board.c is missing naming sync.
As for PL330 the original CMD is done by me so history-wise
I can trace more easily.

Is it possible to update this patch with the remaining board.c
and message the patch with the PL330 the current reviewing one?

Not sure how to due with the missing board.c

Thanks,
Brian

On Sat, Jul 25, 2026 at 5:49=E2=80=AFPM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
> Hi Brian,
>
> On 24/7/2026 6:25 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > On Fri, Jul 24, 2026 at 12:09=E2=80=AFPM Yuslaimi, Alif Zakuan
> > <alif.zakuan.yuslaimi@altera.com> wrote:
> >>
> >> Hello Brian,
> >>
> >> On 23/7/2026 4:59 pm, Sune Brian wrote:
> >>> [CAUTION: This email is from outside your organization. Unless you tr=
ust the sender, do not click on links or open attachments as it may be a fr=
audulent email attempting to steal your information and/or compromise your =
computer.]
> >>>
> >>> HI Alif,
> >>>
> >>> Just reminding, duplicated patch:
> >>>
> >>> https://patchwork.ozlabs.org/project/uboot/patch/20260407153650.26404=
-1-briansune@gmail.com/.
> >>>
> >>> Which is under reviewed.
> >>>
> >>> Thanks,
> >>> Brian
> >>>
> >
> > Hi Alif,
> >
> > My original patch does grep the entire u-boot repository and update it.
> > However how T.F. redo that patch or any missing I did not double check
> > again.
> > Tom also noticed the new board's naming update is missing and updated
> > the naming as well.
> > After the patch applied, the board.c did not notice the missing renamin=
g
> > but only the PL330.
> >
> > I am okay with the old patch removal due to the title not properly form=
ed.
> > I also suggest doing a full grep again to verify any missing.
> >
> > Thanks,
> > Brian
> >
> After grepping the whole repository I found that only these two files
> needed fixing.
>
> Since this is already under Tom's radar, and your patch has already been
> submitted and reviewed earlier, I think we can reject my patch here.
>
> Thanks,
> Alif
>
> >> Thanks for the heads up. How about the fix for
> >> arch/arm/mach-socfpga/board.c?
> >>
> >> Best regards,
> >> Alif
> >>
> >>> On Thu, Jul 23, 2026 at 10:43=E2=80=AFAM <alif.zakuan.yuslaimi@altera=
.com> wrote:
> >>>>
> >>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >>>>
> >>>> Commit 62f7a9460209 ("Replace TARGET namespace and cleanup properly"=
)
> >>>> replaces the TARGET namespace to ARCH for all SoCFPGA devices.
> >>>>
> >>>> Some of the TARGET namespaces are still left out, update leftover TA=
RGET
> >>>> to ARCH following current SoCFPGA naming.
> >>>>
> >>>> Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly"=
)
> >>>>
> >>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com=
>
> >>>> ---
> >>>>    arch/arm/mach-socfpga/board.c | 4 ++--
> >>>>    cmd/Kconfig                   | 2 +-
> >>>>    2 files changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/b=
oard.c
> >>>> index b202ca258bc..b662afc1ad7 100644
> >>>> --- a/arch/arm/mach-socfpga/board.c
> >>>> +++ b/arch/arm/mach-socfpga/board.c
> >>>> @@ -210,8 +210,8 @@ void lmb_arch_add_memory(void)
> >>>>    }
> >>>>    #endif
> >>>>
> >>>> -#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
> >>>> -     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUI=
LD)
> >>>> +#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
> >>>> +     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD=
)
> >>>>    unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> >>>>                                                    unsigned long raw=
_sect)
> >>>>    {
> >>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >>>> index 35ce42f8397..b724f4f8d49 100644
> >>>> --- a/cmd/Kconfig
> >>>> +++ b/cmd/Kconfig
> >>>> @@ -1911,7 +1911,7 @@ menu "Shell scripting commands"
> >>>>
> >>>>    config CMD_C5_PL330_DMA
> >>>>           bool "Release Reset DMA Channels for PL330 Handshake"
> >>>> -       depends on TARGET_SOCFPGA_CYCLONE5
> >>>> +       depends on ARCH_SOCFPGA_CYCLONE5
> >>>>           help
> >>>>             Provides access to Reset Manager Per2ModRst. Enables DMA
> >>>>             channels for ARM PrimeCell PL330 via reset release.
> >>>> --
> >>>> 2.43.7
> >>>>
> >>
>
