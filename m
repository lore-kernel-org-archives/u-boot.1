Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E779EC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B028605F8;
	Mon, 27 Jul 2026 12:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O85TBTdmo5SU; Mon, 27 Jul 2026 12:42:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 406D960689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785156122;
	bh=8e2br6fTUEahwvAv977L6cLl14GFWqVae08wZ4p8EYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SbCrKIKn2PSISNxLItUQtcdm2p9MmdFEbYi3FaratKyIFU7kcPNOKdrTuf5r7PGlW
	 Vz+qdK7oEu1xe6zc+uqtq/mLVjsIt9doaJ+HB0NvLB4RrTmHOkXQ3YC9uChKJKZrJw
	 /upfLdS+MiW8cTUj6IBkD0E4Z0z1ICsgBWzRYOvMJLDMlwSguNrWW6jHOoXO8Y7yYN
	 QUya05iuV57nFq51RAqMIs+eMYa0kRUbd7aLSaWbLJqMLYIZzqBby4fEcf5NaB3XEJ
	 Vg49KLMukQLyS4Mp584JmgVnpwNQ/pIIySd8z5RlUqyUF3ixaWFqqMG6+N5KbXV3+C
	 zGaIsp3scAg1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 406D960689;
	Mon, 27 Jul 2026 12:42:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 377E9357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D9FB80DD4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dl4ShneUpcf2 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:41:59 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 39DAF80A76
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39DAF80A76
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39DAF80A76
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:41:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2503584671; Mon, 27 Jul 2026 14:41:57 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3241182991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 14:41:53 +0200 (CEST)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-80bb41f7f3cso24168717b3.2
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 05:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785156112; cv=none;
 d=google.com; s=arc-20260327;
 b=pWRsWTAz8ubalJQ8NZRlezpJSGAlhZV2XstVw04ijMBuEzaJZ2vJ4wVcMHL99nIeva
 /t+vOCjSiVMle7jTnMP6ahDcYYwP8w5xY9xgLuwI9+lO8VJDiuB8Oo8HXlBWsEoDDfhb
 eKHElAZ2H4Lk2uTqCJYxikxUjMpGT5HFZmczcPDiWx0pJXBd91kGA/0QWQww1Cf89u+Z
 PTiv3FqXKjdMIUDwSsPjzxY+cGlOxZRGPinciqrOWG9xjWSuSGnfUUT7OTiOB8E1iAXx
 3vJg6a6sG5znQr7bOYD3/7GScdwZTyaX5v9vgoO0UaHLD1VxLD1wxoPWtCvbLIw+9h1r
 BwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8e2br6fTUEahwvAv977L6cLl14GFWqVae08wZ4p8EYI=;
 fh=Pq4WXUvEliLpa+7WnXGpGtRAVWZT5HQ9RUStgK6v8D8=;
 b=LuIZbGON6x8a+mN+lHr/28O1QTLb5Q0R4UOt/uO1TiB0g/QEKi3dwjE8nQjbVoLJg9
 L0SikMkWVileGKYk9FbKl8Lvp0tmtcYoLivtHQu4xQviqvPXgFnEMayHu2+RhFn1M9eG
 NWBb4FoKyIs9iE0coiau0JZ+gNh9RusiAm6EMDDaFSLdOTzJwU4kNlXJwiI9bhzGKnS2
 1rYFeg/LlxOs9nuGei3qah5exGheppve8kfF0f7W7cDyYPXsJzO7aqNxhExrXoXf5oJJ
 FUvWfaO8tSJRSTVCLUiB6lRLVG2KU23FDauml2iLOhJyer8ZHj+o+5WENE7ufQXd02ay
 MSKg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156112; x=1785760912;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8e2br6fTUEahwvAv977L6cLl14GFWqVae08wZ4p8EYI=;
 b=KSwVDaPFA2hAg4lkz60+eO1nCuDmp2SaQe1zGoRcPn41Cafn+CprMzkoIWDIjf7Sf3
 KI4Cd4w5eWRev5nhcnBPxyH9HQsu26RioN7hOajQa0lXtQJY3mTr/sBob4aCs+qRY1hW
 XfOfz8LhjPyLIBkjS6AmtgVFmhikq3gZfV28jaHYfBpQcGFUJyA0wAEUE0fWzZSttbVR
 RjoLhOIbhE6PQKIT5Osu3HUd1p8xkEyg9IPY2UcRmu9bCCOjZie1cfwiSiRcYpjnCi25
 BRcbl9VNazp/E/bQrnz0KvIXCnR/IFnGF0utpuDa0qYfm3hdwD2G83GHYYFevNxu7n5J
 elPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdAP77nGAZdu0u4FCd562sMuxZ71uO4QM1YZaT3DSyhu8hm6oBTt2/6mq/OPqtJ/TVOMxt+DA=@lists.denx.de
X-Gm-Message-State: AOJu0YxksLat++Frdp8+1HxpCD770nzZqu5FjgTc3sU8u52jjo9BydGk
 Tp56ryleXJrKWIalcqYw+W8gL2u4eNjIfGZfMvJoFxhcLjQ5PiSmeoZqJNzDuM9q+LTOhd1xw3k
 6Dge7v3X5hEgHOFqp5x+V8cR4w7vpKbTYR6UMMkr2Dg==
X-Gm-Gg: AR+sD13qCet57ovI+Ar96DiI6DNen7vLCb8VCyg2TUi7ZYkcVGXx3eiNzINEeIYj8F4
 B20q5c0RRPWfUU1mV6JtWgWVAJre5j1ZgOXIX4bIpvcovz2uQcF7H7SCsE/oE3NTgxhv69VKle6
 uQysO3hGGinkA5Uwm4cXV3v0HR5esSZis8TTjcTdUoOcocZ+MnRizOd18Nym9JqezX7z6db15Y3
 6qnT49eaAW0sMKYmLLm8suXqnfxZu/yB2bti1wxwx9U95u5T+zW0zb+4S0YnufBR9eFkHH//sz3
 ui6cutORmBZIXx2Ba67MgPW3HIIDhfncU0KrJgJ6ZTjVJsuYsTBHiAqPiPWfoOPywudKB7Jg/60
 aXbTUNGBdOsz7pImna9zp5tsg6u/6D4vw8UaEuhd95e0YAqu/4mkKEV/5Ccv5cew540Pl+6/asC
 4QuLakLKf7CedlOHQIn7fXRCiFyTw4ckOH4oz6t0ljTo2mcc6U9z5UI/LscB7ppJkyF1801rQSh
 Dq5lIM+qfmIVxofJbIYuuFjEEj6XBGr/0MiLFkvlcFI4eaPev8GmuyjcfcLFHOmas9ZzZgtUMIM
 zlww64avMMAt0FXsy/FlmQdPZHErY8O6lnHgwkzMPD1RBbs4HlBeQk5spw+4
X-Received: by 2002:a05:690c:e3f2:b0:812:c9fa:9910 with SMTP id
 00721157ae682-81f69d3142amr25378067b3.29.1785156111471; Mon, 27 Jul 2026
 05:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
 <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
 <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com>
 <20feda09-ab10-43e4-831b-6a8647f5c62e@linaro.org>
 <37b8a403-b299-4e0d-98fe-b4b3ae660b13@oss.qualcomm.com>
In-Reply-To: <37b8a403-b299-4e0d-98fe-b4b3ae660b13@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Jul 2026 15:41:15 +0300
X-Gm-Features: AUfX_myE4bQY3vTfl21lV8WzI4aoPfHelVAYbASqH4k-rop-89qOfitp7495NMo
Message-ID: <CAC_iWjLJRk34i4S04L+3bKMVji-JzmieBKrEmYUZmEuc7Jd-4w@mail.gmail.com>
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785156112; x=1785760912; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8e2br6fTUEahwvAv977L6cLl14GFWqVae08wZ4p8EYI=;
 b=RH+o61SefCERA9+3LUBJolf3zC84EW7qdJv4ou793fNlFuVzIDjkhdEu3TxGf0yi1V
 MfRLqn64o3jz7/hNZRNg2auIOfDJgqozzzQboF0fKEnlFpmIuh6p7aFcVyz7gRIPziCf
 IRE4DH0oEcN1H/6I9NPUqVOJOqdro/K0yFCUg8USfn/uT09frJbQo8yp6FGrJLZZuEe0
 y4aMlD1UFBCcHMBVdnaTJSQpcSonAD5jYz8nMnUbE89mC3/xAJxBpdOv5C6aWBZNaAQu
 bYTXZU93mKQ6+8snqNm6WtmnSorMgorawy+YjcwUJM50gn8v/6m4269EHJOwfBws/L1h
 urgg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RH+o61Se
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="RH+o61Se"; 
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

On Mon, 27 Jul 2026 at 13:00, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi Ilias, Casey,
>
> On 7/24/2026 12:37 AM, Casey Connolly wrote:
> >
> > On 23/07/2026 18:43, Balaji Selvanathan wrote:
> >> Hi Casey,
> >>
> >> On 7/22/2026 8:19 PM, Casey Connolly wrote:
> >>> Hi Balaji,
> >>>
> >>> On 22/07/2026 11:23, Balaji Selvanathan wrote:
> >>>> Hi Casey,
> >>>>
> >>>> On 7/18/2026 4:19 PM, Casey Connolly wrote:
> >>>>> On 7/17/26 18:16, Balaji Selvanathan wrote:
> >>>>>> Hi Casey, Ilias, Simon,
> >>>>>>
> >>>>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
> >>>>>>> Hi Balaji,
> >>>>>>>
> >>>>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
> >>>>>>>> Hi Ilias,
> >>>>>>>>
> >>>>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
> >>>>>>>>> [...]
> >>>>>>>>>
> >>>>>>>>>>>> To support multi-image RAW capsules, we would need to:
> >>>>>>>>>>>>
> >>>>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
> >>>>>>>>>>> There's an equivalent tool in EDKII that can produce a capsul=
e
> >>>>>>>>>>> with
> >>>>>>>>>>> multiple payloads. There were also patches posted for
> >>>>>>>>>>> mkeficapsule,
> >>>>>>>>>>> but need some minor tweaks to merge them
> >>>>>>>>>> Can you please point me those patches? I did a search myself, =
but
> >>>>>>>>>> couldnt find those patches.
> >>>>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
> >>>>>>>>> sughosh.ganu@linaro.org/
> >>>>>>>> This patch you mentioned here can create capsule with only one
> >>>>>>>> payload;
> >>>>>>>> means for multiple binaries we need to create multiple capsules.=
 I
> >>>>>>>> have
> >>>>>>>> also asked the person who made this series to respin, but havent
> >>>>>>>> heard
> >>>>>>>> back from him.
> >>>>>>>    From a quick look it seems like it would be fairly
> >>>>>>> straightforward to
> >>>>>>> extend mkeficapsule to support multiple images, the capsule heade=
r
> >>>>>>> has
> >>>>>>> an item_offset_list[] array with offsets to each image, today we =
just
> >>>>>>> write 1 but it shouldn't be too much of a challenge to put a loop=
 in
> >>>>>>> here and extend the argument parsing.
> >>>>>>>
> >>>>>>> Given that we a) already use raw capsules and b) they are part of=
 the
> >>>>>>> EFI spec, I'm gonna try and save us all some time and just put my
> >>>>>>> foot
> >>>>>>> down here. A single raw EFI capsule file can already support upda=
ting
> >>>>>>> multiple images, U-Boot already has all of the machinery for it w=
ith
> >>>>>>> the
> >>>>>>> exception of mkeficapsule but I expect that's something you can
> >>>>>>> tackle.
> >>>>>>>
> >>>>>>> The upside to this is that you will be able to build capsule file=
s
> >>>>>>> for
> >>>>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
> >>>>>> Thanks for the detailed feedback.
> >>>>>>
> >>>>>> We agree =E2=80=94 we'll drop the FIT capsule approach and move fo=
rward with
> >>>>>> RAW capsules.
> >>>>>>
> >>>>>> Here's the plan:
> >>>>>>
> >>>>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule serie=
s
> >>>>>> [1] to support generating multi-image capsules from a config
> >>>>>>      file, so we can build a single capsule covering all the parti=
tions
> >>>>>> we need to update.
> >>>>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
> >>>>>> supports a single firmware image (U-Boot itself) via a
> >>>>>>      single-entry fw_images[] array. We'll move to a SoC-specific,
> >>>>>> multi- entry fw_images[] array (defined per board, e.g.
> >>>>>>      board/qualcomm/<board>/fw_images.c), so a single capsule upda=
te
> >>>>>> flow can cover multiple firmware components =E2=80=94 each with it=
s own
> >>>>>>      ESRT entry and FMP image_index =E2=80=94 instead of just U-Bo=
ot.
> >>>>> No need for this, just build fw_images[] on the fly derived from th=
e
> >>>>> partition table on the board, with an entry for each partition that
> >>>>> can be updated. You just need to add a map from partition label to
> >>>>> fw_name string, starting with the xbl/uefi/boot partitions we alrea=
dy
> >>>>> handle.
> >>>>>
> >>>>> The entire point of having logic here was to avoid per-board stuff,=
 if
> >>>>> you're thinking "ah I'll do this per-board" you should immediately
> >>>>> wonder "but can we do it dynamically instead?".
> >>>>>
> >>>>> Thanks,
> >>>>> Casey
> >>>> Hi Casey, Ilias,
> >>>>
> >>>>     Thanks for the pointer =E2=80=94 agreed, building fw_images[] dy=
namically
> >>>> from
> >>>> the partition table is the right call, avoids per-target code entire=
ly.
> >>> Can I talk to a human instead of an LLM please?
> >>>
> >>>>     Plan:
> >>>>     - Keep a fixed table mapping "partition label =E2=86=92 fw_name =
+ a fixed
> >>>> image index", this mapping going to be a superset list for all the B=
oot
> >>>> FW images supported in different Qualcomm targets.
> >>> This reads vaguely like a rephrasing of what I proposed, not clear if
> >>> you really understand it though.
> >>>
> >>>>        Sample table:
> >>>>
> >>>> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90
> >>>>       =E2=94=82 part_base_name         =E2=94=82 fw_name            =
    =E2=94=82 index =E2=94=82 guid
> >>>> (fixed)                                =E2=94=82
> >>>> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80|=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80|=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80-|=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80- |
> >>>>       =E2=94=82 xbl                                  =E2=94=82 QCOM_=
XBL =E2=94=82   1
> >>>> =E2=94=82  QCOM_XBL_GUID                  =E2=94=82
> >>>>       =E2=94=82 ubootspl                       =E2=94=82 QCOM_UBOOTS=
PL=E2=94=82   2   =E2=94=82
> >>>> QCOM_UBOOTSPL_GUID     =E2=94=82
> >>>>       =E2=94=82 uboot                            =E2=94=82 QCOM_UBOO=
T      =E2=94=82   3
> >>>> =E2=94=82  QCOM_UBOOT_GUID            =E2=94=82
> >>>> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98
> >>>>
> >>>>       Target-1 supports xbl and Target-2 supports ubootspl.
> >>>>
> >>>>     - At boot, scan the partition table against this table. Only
> >>>> partitions actually present on that target get an fw_images[]/ESRT e=
ntry
> >>>> =E2=80=94 nothing hardcoded per target.
> >>>>
> >>>>     - The image index for each partition type stays fixed and publis=
hed,
> >>>> so whoever builds a capsule (mkeficapsule) always knows which index =
to
> >>>> target, regardless of what's discovered at runtime.
> >>>>
> >>>>     One wrinkle I want to flag: today's SetImage() path assumes
> >>>> dfu_alt_num =3D image_index - 1, i.e. it picks the Nth entry in
> >>>> dfu_alt_info purely by
> >>>>     position. If a partition from the middle of the table is missing=
 on a
> >>>> given target, everything after it would shift by one position and th=
e
> >>>> wrong
> >>>>     partition would get flashed =E2=80=94 silently. Since I'd rather=
 not touch
> >>>> that logic in common code, my plan is to keep every fixed index's
> >>>> position in
> >>>>     dfu_alt_info stable by inserting a placeholder (U-Boot's existin=
g
> >>>> virt
> >>>> DFU backend, which just no-ops) wherever a partition is absent, so t=
he
> >>>> position
> >>>>     math stays correct for everything after it. The missing partitio=
n
> >>>> itself simply won't have an fw_images[]/ESRT entry, so a capsule can=
't
> >>>> target it
> >>>>     anyway =E2=80=94 it'd get rejected before reaching DFU.
> >>> Skipping past this noise... Ilias probably knows better here but yes =
the
> >>> way dfu_alt_num is derived from ImageIndex does impose a limitation h=
ere
> >>> currently where we need to ensure the indexes always start at 1 and
> >>> count up.
> >>>
> >>> That being said, it's already quite complicated to have to maintain a
> >>> database of the indices for each board, and even more complicated whe=
n
> >>> we have boards that may or may not be using U-Boot SPL (for example).
> >>>
> >>> Having fixed ImageIndex values for each image would then seem to make
> >>> the most sense as we could just use fwu to set dfu_alt_num (or anothe=
r
> >>> platform specific mechanism), however the EFI spec is clear that the
> >>> ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <=3D DescriptorCo=
unt
> >>> as returned by fmp->GetImageInfo(), so we would need to also have dum=
my
> >>> entries in the fw_images[] array so it doesn't really solve our probl=
em.
> >>>
> >>> https://uefi.org/specs/UEFI/2.9_A/23_Firmware_Update_and_Reporting.ht=
ml
> >>>
> >>> Currently, other than for setting dfu_alt_num, the only other place
> >>> where the image index needs to match is in efi_fmp_find() which was
> >>> added by [1] seemingly to prevent an incorrect image index in the
> >>> /capsule/ file causing dfu_alt_num to be set wrong resulting in the
> >>> wrong partition being flashed. In other words, we should be able to f=
ind
> >>> a way to safely remove this check.
> >>>
> >>> But alas, it seems like we are stuck with fmp->SetImage() being calle=
d
> >>> with the image index from the capsule file per the spec, and it is th=
e
> >>> only way to identify the target partition without doing other hacks.
> >>>
> >>> I'd like to get some feedback from Ilias on this, since adding dummy
> >>> entries really doesn't feel like an acceptable approach to me. The on=
ly
> >>> alternatives I can think of also don't seem great... Either:
> >>>
> >>> 1. Sidestep the EFI spec by either caching data in the call to
> >>> GetImageInfo() or by assuming that the void *image pointer immediatel=
y
> >>> follows the efi_firmware_management_capsule_image_header (this is tru=
e
> >>> for us today but would be a fragile assumption to make).
> >>> 2. Use the internal image index (looked up via the image name and
> >>> type_id) as the index when calling fmp->set_image() - going against t=
he
> >>> spec.
> >>>
> >>> It's not really clear to me what purpose the ImageIndex property serv=
es,
> >>> since GetImageInfo() is meant to match on the ImageTypeId anyway, I
> >>> assume it relates somehow to the fact that there can be multiple
> >>> instances of the firmware management protocol, but in U-Boot we only
> >>> have one.
> >>>
> >>> I think the other way forward would be to use the only included escap=
e
> >>> hatch in the UEFI spec with a custom GUID in the capsule header
> >>> capsule_guid field which would let us have a custom mechanism which i=
n
> >>> our case could just be a soft-fork of the existing spec with minor
> >>> changes so we can just remove/ignore the UpdateImageIndex field in th=
e
> >>> capsule. Maybe this would be the most correct solution?
> >>>
> >>> Hopefully Ilias has some time to chime in on this, I'm sure we can fi=
nd
> >>> a way to go about this that doesn't involve exposing dummy data.
> >>>
> >>> Thanks,
> >>> // Casey
> >> I feel we are complicating it by trying to go for dynamic fw_images.
> >>
> >> Rather than introducing a solution that diverges from the UEFI
> >> specification, shall we use a board-specific static fw_images[]
> > Well, the solution I proposed at the end very much doesn't diverge from
> > the spec, that was kinda the point.
> >
> >> definition. This approach is simpler, remains spec-compliant, and othe=
r
> > Simpler for you to implement or simpler to maintain? I think that's
> > quite debatable...
> >
> >> vendors (like NXP, TI) have also implemented static fw_images (in boar=
d/
> >> nxp, board/ti).
> > The decision not to do this for mach-snapdragon was quite intentional
> > and was the motivator behind dynamic generation of image GUIDs:
> > https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-v8-0-79b31b199b=
ee@linaro.org/
> >
> > The image index issue was always bound to come up, and it's absolutely
> > something we should be solving and not just sidestepping. We already
> > support dynamic fw_images[] anyway and it's already being used by some
> > devices, so we need to maintain the existing support regardless.
> >
> > As I understand it, Qualcomm also intend to support multiple boot media
> > (UFS, eMMC, SPI flash) with a single U-Boot binary, so to some extent
> > this array must be dynamic. And since at boot time we have all the info
> > we need to generate fw_images, keeping a static list per-board is at
> > best lazy and at worst will just make things even more complicated when
> > we suddenly want to support configurations with/without OP-TEE and
> > with/without SPL.
> >
> > So unless I'm missing something here I think there's a strong case here
> > to add support for ignoring the capsule provided image index, but we'll
> > see what Ilias has to say when he's back from vacation.
>
> Okay Casey.
>
> Hi Ilias,
>
> Request your input on this.

So the problem you are trying to fix here, is that you have boards
with multiple configurations, that their image index might change, but
you want to update them with a single capsule right?

If that's the case, we can have a board specific function that does
nothing by default, but on the qualcomm case, re-arranges the capsule
image indexes *after* the capsule authentication has passed. I think
this still violates the EFI spec, but I am ok with it.

Cheers
/Ilias
>
> Regards,
>
> Balaji
>
> >
> >> Regards,
> >>
> >> Balaji
> >>
> >>> [1]: 7cf06f09cc51 ("capsule: Put a check for image index before the
> >>> update")
> >>>
> >>>>     Let me know if this approach sounds reasonable.
> >>>>
> >>>> Thanks,
> >>>> Balaji
> >>>>>> Will send an updated series once the mkeficapsule and qcom capsule
> >>>>>> update changes are in shape.
> >>>>>>
> >>>>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
> >>>>>> sughosh.ganu@linaro.org/
> >>>>>>
> >>>>>> Regards,
> >>>>>> Balaji
> >>>>>>> Kind regards,
