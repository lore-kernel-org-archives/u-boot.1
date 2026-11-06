Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681CA606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uswOvZqM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RXzio4v4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0125B810DC;
	Fri,  6 Nov 2026 15:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dat5bG9omrDH; Fri,  6 Nov 2026 15:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37CF280E09
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793977962;
	b=iKo3dVerXBTNY+dseYUGJkNaW5DVBxhfRXvZyaT+AqZmd1Jq0B2vzM6F3emE74GifCcP
	 56KOgLHHDpMtSPfZre9FCETSQFK3s2nNIzK4KdifITKp5tHDIrRFZucxtrAtVqJb72QIK
	 E04bcbXJmbwIVcmVVkSZ6sV+YPMvjSGHiBi2revdqBWGfc94EcmqWoY1cFGAlavI49/yL
	 ezBMysKOuZ2KCMhQGU2Hg8CH/fZmjMe3LGpc5BK48txrPcNq/GYvUQvy0MO3AtxLBgchW
	 pNyRC57s6rNSpXywabED9+9B5olqpclkAac20LLml8s+CPlT8eq0bdIYy4VKRrPJmbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793977962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MNBIS7x7l2WLRHyxtDk/DPDnuuNLDpBYik2KY0RMZQA=;
	b=snOzswcuO+G52501aUP1xgfWCtYc8wfW0KVG8GN1CHDRJCtmzjonMu0+XQLi1J904rCh
	 hRxGqpT0lkrMII8AQ+Tf4g23dE2gApKUK9P2v4zkusH39C6Fi+jwhnW0t1sr04BSTY1jp
	 vFfKZ2ffy5/jSmRQzO697+H4Pf2aHuEqjQJQu1CbdcmJKs4Kn8vuo+e2IXRnhHqEHV8QI
	 6fD0UgmYKhNnBZmXqplGnYnYZVu52Zdb9OTXLNTOGE0Bri2FoqHDMXe/fBhb+5Ot9RJO0
	 B3KOo8MRiHWYsMvUAlSLP9vBb4u1EddvxWGr4zjJ9gZE+c96qJ2xaGAbmZdtadYO3XQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793977962;
	bh=MNBIS7x7l2WLRHyxtDk/DPDnuuNLDpBYik2KY0RMZQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uswOvZqMeT2MVpPZ5XcptAMchhg/qGx0XH2cTu572QL3wQPRdbVcXoeTlwHCa4tUU
	 qdeIUOP7zoRJljk32gQmF6EPcTxSo8FAlNwsXat0Sa8z9Wy8aFM1mdLHqDKTgE5Q5y
	 a4bJF9pskYfAebcN+dz0LVmYrsQ+iMoUovgcvvbnf7sVBCELDb3lrTT16yYk6tlfG+
	 rjb4F7BgjR7NMMJEzbV5hau7D1S2mNjWKdzkWsM2s2QpsiTfOKtrU5OF+r4rVWArOO
	 KSyejiM9ziYButOdTq3dwY4PUqL1H7yoDXDSOltKwfYjjKywx1+JITBrPD/DwXV2xn
	 HDiJA0UwVlGjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37CF280E09;
	Fri,  6 Nov 2026 15:12:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACED12AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 15:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E7204016D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 15:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9t7YWxFXU2LM for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 15:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C0A06400AF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RXzio4v4
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0A06400AF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 15:12:39 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b312be5de8so6775947b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793977958; x=1794582758;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MNBIS7x7l2WLRHyxtDk/DPDnuuNLDpBYik2KY0RMZQA=;
 b=RXzio4v4bUGkxYscpkmRCnmAjchnGI4ObuVWhk8net04mFzxoHuHdQXdQ7LfpLjj6v
 KoU0lIA50enUsY/1OwzuXxBCsr9LUKX26YcTxC6pcdG4wrmbrOu+GTYs62hg3BEFQW0j
 kzVm9X9VzAQiDX+glGx49XCEH9uyVXPqnEuSHL5vqJPFACg4w061axlzhZbVrxQV9aFB
 oMmAespMe2VlxPGLUmL9k+Euo8+X2Pv8pAVRK+SLIvGNmTrMdc2a7ntpPX+0wfNNWvc6
 Ef03XylHFONsFEJXK5vlM8ahu7fL1xZngBLmUYmevcHX6frhAT7g3mwex9S2S6Z0CXDi
 XA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793977958; x=1794582758;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MNBIS7x7l2WLRHyxtDk/DPDnuuNLDpBYik2KY0RMZQA=;
 b=uJOVCC1i8LFReUHBviWlSBdSLO8xYOAOk/HZZ24U3jHuNyWx5F5tNtDzo5v36fu7Dp
 OUOsguFJ80n364FsCP5LCMgDkZuQMSpweC2KK/RKb2YcrNnpL1WpY0AH2EmEugonJDRv
 +ZPZYBnsswa825PRaXRxhW/VcbV9dxpL5aTsGg5hyy8nA9nqJq1PlWcYv6/8yoyb2Knz
 a9rbccJPVxkNxl95N2CpwNftOSeVEyyu7W72T6hQBPDvSS69nrRzDG0legW9jkKodLKq
 fhj7ewN4i3jNw+wpim8yTDumAo9l08T47l5xYpbvbnfmVAEOKb7KjacQwk2+Bmg88bku
 GThQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH5bD/UGDbsWc36jHROLxFJC+k/y+v5Zb/fFLDOagBfeNEkAvkIPQGtjDvZz4jUazchBqwpUCI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z96YH2Lx6HKiGyhXqcPGTyKpxEtlA0bgo0D3Q/nwMh6uP1TTXhq
 mwCX4TWJTOIU3uwDZhikCpZFrvKGh3z7PhH/QGsrbxFst/JfXP+HIL1Xe5Nw86fWJcC/VK6e8sD
 PkF4dFf/x0Q8hA78Kfl5U3cx6i30kvMM=
X-Gm-Gg: AYBFou3hTLplv8n5J40ITrRbZ9lj0+9GExhIVfAfx5hXgedd7C4zZceYwpHdlIGRFiU
 mxafps7vFmJMXS+NjUxhPlRaDA6oQvNqdNICXDsRBgvb14tk+acIqTE5uftjndvheFYOQmVvbeh
 AJgiyn7+8kwn0iRsx7xrVP8RXdeaHcpsZnaXb7P67vhm6AJftjbuPOTywMcQN1fu2UG5dByVTaB
 5rvYNk0dj5/3c18H6Ra47Mr/8nUw1linxDQ1Fp7io538eHncNR2dukW/jHwj0ST+UcYcyFx+Wf+
 O5+oKsUP4Qopr6s3IWjUAVpyJcb9Cy/8gsq1KDMEOG7/HgF5o2HZEKU8WgvRTm+mwZAUvyTAOK9
 XWzCwnDgqgpIv4zUwKJGMQcCKYykexzkproePJQ==
X-Received: by 2002:a05:690c:e3ee:b0:8b2:e4cf:c399 with SMTP id
 00721157ae682-8b3418ffb36mr13031617b3.18.1793977957774; Fri, 06 Nov 2026
 07:12:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
 <20261105-mtk-mt8189-tfa-fdt-v2-1-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-1-c168a7b4041c@baylibre.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 6 Nov 2026 10:12:23 -0500
X-Gm-Features: AclHuK8kYPvTsexRYwi717iDlstY7JOpa2xPdH_GbhGcRVxCED6o2_Ik0aet2-w
Message-ID: <CAMDkj5xaYZovwazkiBWAOcQba1DTyGTSAQjMs+ttmm96mNyLRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] bloblist: limit BLOBLIST_PASSAGE_MANDATORY to
 U-Boot proper
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On Thu, Nov 5, 2026 at 6:46=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> Check BLOBLIST_PASSAGE_MANDATORY with CONFIG_IS_ENABLED() so that it only
> applies to U-Boot proper. It is part of the bloblist location choice for
> U-Boot proper, which has no SPL counterpart, but IS_ENABLED() made SPL
> require a devicetree in the incoming bloblist too. SPL uses its own
> devicetree when the bloblist has none, even when U-Boot proper must get
> its devicetree from the bloblist.
>
> Without an incoming bloblist, SPL now tries to set up its own one, as it
> does without BLOBLIST_PASSAGE_MANDATORY. This still fails unless
> BLOBLIST_SIZE is set, which defaults to 0 with
> BLOBLIST_PASSAGE_MANDATORY.
>
> Fixes: 03a76b1a737f ("bloblist: kconfig for mandatory incoming standard p=
assage")
> Fixes: 179010694b30 ("lib/fdtdec.c: Disallow overriding BLOBLIST_PASSAGE_=
MANDATORY")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  common/bloblist.c | 4 ++--
>  lib/fdtdec.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

LGTM and please apply 'Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>'.

Thanks and regards,
Raymond


> diff --git a/common/bloblist.c b/common/bloblist.c
> index 3804f061f87..85138fe83f3 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -613,7 +613,7 @@ bool bloblist_exists(void)
>          * If Firmware Handoff is mandatory but no transfer list is
>          * observed, report it as an error.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
>                 return false;
>
>         /*
> @@ -659,7 +659,7 @@ int bloblist_init(void)
>          * If Firmware Handoff is mandatory but no transfer list has been
>          * observed by fdtdec_setup, report it as an error.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
>                 return -ENOENT;
>
>         /*
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index d25535bf36c..e0b0d4e927d 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1849,7 +1849,7 @@ int fdtdec_setup(void)
>          * If we have bloblist being required to pass the FDT and we reac=
h this
>          * point, we have a problem and must exit.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +       if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
>                 return ret;
>
>         /* Otherwise, the devicetree is typically appended to U-Boot */
>
> --
> 2.53.0
>
