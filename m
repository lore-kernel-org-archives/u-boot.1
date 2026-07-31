Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C88AC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 09:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDB34608F0;
	Fri, 31 Jul 2026 09:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IOWPorw-THHt; Fri, 31 Jul 2026 09:37:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 166926083A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785490665;
	bh=txQoyQq44RIwDPhcubUO00XbE596usBnHhTDkYIg+3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bUGDtLHaXf2lTtPrkJPlNnYIuKjIO1zYr6aBXtdh04cjBmVpC2pIjtnDXaa2ZF6UE
	 Kzaxt2C86tYrqC5hb1bHrYkVfBuRsdnsrwHMcoOEjI8Rpjk2igD2YdFWivWMcb3uZt
	 SQ4vix4baQRfqzRjLRDI06/pXmQhWJHUBFKRF3D5qw1h5NdVdxVNU33vaU0SiWoYtt
	 JDigR1poh/h/0I3Ks1zP8acMmFR5X2wMmyMApZ1Q4Xk95ClAGkniIpHSBhjI4wAIZ0
	 H7ap75ZaREyjB/AviVvThQJ4yKuIwfoUgTCkcncYzvLZapAlmLEdW47McUQ3dGSbNz
	 1KaJ0OnmlxGiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 166926083A;
	Fri, 31 Jul 2026 09:37:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0715823F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0EFE401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4_d3ppG2c3L for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 09:37:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 416B240074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 416B240074
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 416B240074
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:37:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D18584A0F; Fri, 31 Jul 2026 11:37:37 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFA9849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 11:37:33 +0200 (CEST)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66899c7b57bso1011361d50.1
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 02:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785490652; cv=none;
 d=google.com; s=arc-20260327;
 b=mEgsvcRRIAadH+/i3sDnOrBcjK0aOozzE7KOy3Y1a6y69O6FxaH1Guad+sXL6Mqlhs
 Za7nrY5bFo0mipJDc7khdqSd8v9uwCmp4Xi2/U7rq+28ByLnLIIeHFM5qlPgZEjq0vu0
 4FSdWPIl4a08OXUmIoKd2bItlIFDp6Me8OahICI/rW46qA8h9QYvA0YpfChYxQk4F64w
 ZRhGnSTmsyzXaLLYd8yqQfdg/DBt/O/AkPuwkT9MuBvE8JhSMSbOhZ43z6RoWln0HCVX
 6BmC0TeloShMcimbqCNBNSHAiT69ynTLshbzzYYP86Enlsd2Z3HmyS/Bp65XqdEp2qQf
 oyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=txQoyQq44RIwDPhcubUO00XbE596usBnHhTDkYIg+3I=;
 fh=LsVIlS6i0skvT/rILwYyZ2uWxEZ7EE+HybnsgqccmkQ=;
 b=Fvd2QAtlHED4SyQp1nxUzaCKdNGOkXC2thUC2p2tsKVc9Ve9Xo59qM/0D+D5QYsfY4
 ZRQPo1ospztf7FfsxgBNq+mjIBPk1KgufFygWB2q0pBXMHIBKyOUPUsCNanIA2eZy6Q/
 K1jaF8qZ3ayEdCRjcIICdsg5aIDFOHTbRpu+jMVwa+eAzwkvWPNOlQtWpfXxcnlZoDNO
 3p8D5p1yq0RW9GvMLAbdKmNQcC1W/H90OZfkCVxwBHmDx9HAAHVEm5UjsiCQqhD3RsI2
 N6Vd0egHKfrmss3w57tuvq+nM/tla5W9788WpyoWPdb66OxaljTJJhkPSQF8ErFI0Wg/
 C3TA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785490652; x=1786095452;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=txQoyQq44RIwDPhcubUO00XbE596usBnHhTDkYIg+3I=;
 b=eJhJB7Az8Ero5CuW1o1KOKMnGQp7YPTDFnkgmcBw62BYKn2Oh9oZdXyzwuNOZXtD+e
 SlGkva+0rMHtS/i1N6UC61NNm61lc+GrufKCnWeZWnSc+CjHkHiQ5AND29JxyM1M5iZV
 sjNjFH1IY4ZR5aYKGDvRYwTVz2AOt8jOUmP9BdBBK7v3cq7dIYTG2D89eSdzUMiZSlsG
 C2+6WjM9gPyKEQQPKIGgtQ9LmFgcXQNK0zt85co3+EOxBUiEUoifWWz4uqpjb5nimxfk
 411aBwYO+TVOvabomgrmr7o+1bMDxbagnYVApr4+xK5krBajqt/Cal5q1NrRPCydMNN5
 Ui3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrsq6ercawVMlkUhEBv/Kfloq/v6VonhVVKdbEm9DgiBsbrVwLL4Z/Wur581M2c1e2M3mpApRk=@lists.denx.de
X-Gm-Message-State: AOJu0YxjAjOKL7Sbvm4oQANSPYsv/BXdcrP8HkmOIvBemRMhnrGTmbpa
 zsnCIfm2CKHAKAXwoDgBoD26H9gH6MheixoS8n1JWHaWW3N57W7m7o03AY4XXm4xsx0Vw5H5OQ8
 POTL+aezS4rUba4OUy0bNRB2/t7I5To0rUfIQvgHyaA==
X-Gm-Gg: AR+sD10YAkaitDwqF0TNM+nt7/5egDkFU6DPCZrUR5NoEnYV1lZxUohpVudypok90Kh
 7vEBahXsk20VBupjeZPpU4NrMQmLsL9b6d+n9qKu2winUcSQuHtmgGx2TzssqcHBRf7nN5CJPHA
 rr75TXYiW+zUr92KMNrYXtWBRlKmz2SJVUbHBSggLJQQgJo94TKZhFEA22OJDlKedar4Jl1nq+I
 B8yIUESr+xb/kM89jIzmsdeh8uihcHmG1bhNgWO/UCjJ7/IoXpnLFs+is1WeBLajr8C2dxve09S
 62sBT/zmU0i7v+HOd1DJKkm3yS/qmi98hqg905o5M/+bsSfXzc7a0/R4IDRBPWLx2+BshFyjkw7
 K3avdSae1cDC/eCtRHiwu2yk9QkueMSuc/q1h2M7RktDK6usxOJP6mz4JAcrPai137qXKhXaH+U
 wi5PRuUv/RrRA3gjKkuOXWbFdqykGbOVgFVZkFvdjE1yXvvec3xajvhsaH3pCezA2iBQ019NexA
 l4oYCO3XndYX0OXGxWcXI+9v3Q0NDBvQIbgWpPWU7SCl4MhwIf8rDrqJhNPg7/J0mACscSdakMO
 OjSShU17U8BSCvh01vrZ+MnranN4V9H827zB2Z0JiG/loX0QyULwAKsxhVVSqHJpfFBYhGPiy4n
 Qkxv1wEMGPDAlV7YPAzsQm4S70BfBSuDL1Oc4b396wt/UxxxKbbhwqjR/v+jaNG/Q6p7LTS2YSc
 rqIA==
X-Received: by 2002:a53:c050:0:10b0:667:f20a:4cc8 with SMTP id
 956f58d0204a3-66945365d8bmr689984d50.51.1785490651645; Fri, 31 Jul 2026
 02:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
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
 <CAC_iWjLJRk34i4S04L+3bKMVji-JzmieBKrEmYUZmEuc7Jd-4w@mail.gmail.com>
 <bea27826-0028-4de7-a4c7-94ba3eb2f1b4@oss.qualcomm.com>
 <e1ca0b58-d38f-46dc-a9e4-e0695e69a950@oss.qualcomm.com>
 <49cc74de-5d73-44ad-86e0-6acd0f61ff1e@linaro.org>
 <eb42084b-b4ac-4b6c-9caf-256d013daa25@oss.qualcomm.com>
In-Reply-To: <eb42084b-b4ac-4b6c-9caf-256d013daa25@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Jul 2026 12:36:55 +0300
X-Gm-Features: AUfX_myXUkC3SgFv3xaCPTnVCaKTm8E7EYI7j2sw15wSsZH8LSW-760T5V4Co-A
Message-ID: <CAC_iWjJVzs=s2NbVtUt1QKbdKzWs93ioLe5+7CZoKcFLs2wOwQ@mail.gmail.com>
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
 d=linaro.org; s=google; t=1785490652; x=1786095452; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=txQoyQq44RIwDPhcubUO00XbE596usBnHhTDkYIg+3I=;
 b=FGO/s/0Y4nKvTkey6m8DKdRM7nCG8JWFhg+S9o04v4ZHV4VgbmLJ1aBvI3kLNPI2+2
 WABgnFxLlkxr/aIlhWLoN7pEbHwULZQzyZn6XOEZCRs1Pp9tQCB+hvT4RAiJdA1kLyr1
 LoCKbcrz45la2oXh3PMt1P2Un31mCAwutBnPILljY+JVWBmWvmVDIgULCmze6A2/Nlzu
 d4GuBrbSBuXyNvlFTE3NHx8b4j0tBWZ+PAv8FjhA5Jj3TEFkwFDWZFfyxBWYRVkA7I3c
 EsOVOr0ljL9zuNEy+Jf5iZ4XjLjM5M2OYDIiREw12pIlLFmR2scPyLnopY7OwWPwdkvX
 gfCw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FGO/s/0Y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="FGO/s/0Y"; 
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

Hi Casey,

On Wed, 29 Jul 2026 at 13:45, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi Casey, Ilias,
>
> On 7/28/2026 5:51 PM, Casey Connolly wrote:
> >
> > On 28/07/2026 13:44, Balaji Selvanathan wrote:
> >> Hi Ilias,
> >>
> >> On 7/27/2026 9:57 PM, Balaji Selvanathan wrote:
> >>> Hi Ilias,
> >>>
> >>> On 7/27/2026 6:11 PM, Ilias Apalodimas wrote:
> >>>> On Mon, 27 Jul 2026 at 13:00, Balaji Selvanathan
> >>>> <balaji.selvanathan@oss.qualcomm.com> wrote:
> >>>>> Hi Ilias, Casey,
> >>>>>
> >>>>> On 7/24/2026 12:37 AM, Casey Connolly wrote:
> >>>>>> On 23/07/2026 18:43, Balaji Selvanathan wrote:
> >>>>>>> Hi Casey,
> >>>>>>>
> >>>>>>> On 7/22/2026 8:19 PM, Casey Connolly wrote:
> >>>>>>>> Hi Balaji,
> >>>>>>>>
> >>>>>>>> On 22/07/2026 11:23, Balaji Selvanathan wrote:
> >>>>>>>>> Hi Casey,
> >>>>>>>>>
> >>>>>>>>> On 7/18/2026 4:19 PM, Casey Connolly wrote:
> >>>>>>>>>> On 7/17/26 18:16, Balaji Selvanathan wrote:
> >>>>>>>>>>> Hi Casey, Ilias, Simon,
> >>>>>>>>>>>
> >>>>>>>>>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
> >>>>>>>>>>>> Hi Balaji,
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
> >>>>>>>>>>>>> Hi Ilias,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
> >>>>>>>>>>>>>> [...]
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> To support multi-image RAW capsules, we would need to:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
> >>>>>>>>>>>>>>>> There's an equivalent tool in EDKII that can produce a
> >>>>>>>>>>>>>>>> capsule
> >>>>>>>>>>>>>>>> with
> >>>>>>>>>>>>>>>> multiple payloads. There were also patches posted for
> >>>>>>>>>>>>>>>> mkeficapsule,
> >>>>>>>>>>>>>>>> but need some minor tweaks to merge them
> >>>>>>>>>>>>>>> Can you please point me those patches? I did a search
> >>>>>>>>>>>>>>> myself, but
> >>>>>>>>>>>>>>> couldnt find those patches.
> >>>>>>>>>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
> >>>>>>>>>>>>>> sughosh.ganu@linaro.org/
> >>>>>>>>>>>>> This patch you mentioned here can create capsule with only =
one
> >>>>>>>>>>>>> payload;
> >>>>>>>>>>>>> means for multiple binaries we need to create multiple
> >>>>>>>>>>>>> capsules. I
> >>>>>>>>>>>>> have
> >>>>>>>>>>>>> also asked the person who made this series to respin, but
> >>>>>>>>>>>>> havent
> >>>>>>>>>>>>> heard
> >>>>>>>>>>>>> back from him.
> >>>>>>>>>>>>      From a quick look it seems like it would be fairly
> >>>>>>>>>>>> straightforward to
> >>>>>>>>>>>> extend mkeficapsule to support multiple images, the capsule
> >>>>>>>>>>>> header
> >>>>>>>>>>>> has
> >>>>>>>>>>>> an item_offset_list[] array with offsets to each image, toda=
y
> >>>>>>>>>>>> we just
> >>>>>>>>>>>> write 1 but it shouldn't be too much of a challenge to put a
> >>>>>>>>>>>> loop in
> >>>>>>>>>>>> here and extend the argument parsing.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Given that we a) already use raw capsules and b) they are
> >>>>>>>>>>>> part of the
> >>>>>>>>>>>> EFI spec, I'm gonna try and save us all some time and just
> >>>>>>>>>>>> put my
> >>>>>>>>>>>> foot
> >>>>>>>>>>>> down here. A single raw EFI capsule file can already support
> >>>>>>>>>>>> updating
> >>>>>>>>>>>> multiple images, U-Boot already has all of the machinery for
> >>>>>>>>>>>> it with
> >>>>>>>>>>>> the
> >>>>>>>>>>>> exception of mkeficapsule but I expect that's something you =
can
> >>>>>>>>>>>> tackle.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The upside to this is that you will be able to build capsule
> >>>>>>>>>>>> files
> >>>>>>>>>>>> for
> >>>>>>>>>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and e=
dk2!
> >>>>>>>>>>> Thanks for the detailed feedback.
> >>>>>>>>>>>
> >>>>>>>>>>> We agree =E2=80=94 we'll drop the FIT capsule approach and mo=
ve
> >>>>>>>>>>> forward with
> >>>>>>>>>>> RAW capsules.
> >>>>>>>>>>>
> >>>>>>>>>>> Here's the plan:
> >>>>>>>>>>>
> >>>>>>>>>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule
> >>>>>>>>>>> series
> >>>>>>>>>>> [1] to support generating multi-image capsules from a config
> >>>>>>>>>>>        file, so we can build a single capsule covering all th=
e
> >>>>>>>>>>> partitions
> >>>>>>>>>>> we need to update.
> >>>>>>>>>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code =
only
> >>>>>>>>>>> supports a single firmware image (U-Boot itself) via a
> >>>>>>>>>>>        single-entry fw_images[] array. We'll move to a SoC-
> >>>>>>>>>>> specific,
> >>>>>>>>>>> multi- entry fw_images[] array (defined per board, e.g.
> >>>>>>>>>>>        board/qualcomm/<board>/fw_images.c), so a single capsu=
le
> >>>>>>>>>>> update
> >>>>>>>>>>> flow can cover multiple firmware components =E2=80=94 each wi=
th its own
> >>>>>>>>>>>        ESRT entry and FMP image_index =E2=80=94 instead of ju=
st U-Boot.
> >>>>>>>>>> No need for this, just build fw_images[] on the fly derived
> >>>>>>>>>> from the
> >>>>>>>>>> partition table on the board, with an entry for each partition
> >>>>>>>>>> that
> >>>>>>>>>> can be updated. You just need to add a map from partition labe=
l to
> >>>>>>>>>> fw_name string, starting with the xbl/uefi/boot partitions we
> >>>>>>>>>> already
> >>>>>>>>>> handle.
> >>>>>>>>>>
> >>>>>>>>>> The entire point of having logic here was to avoid per-board
> >>>>>>>>>> stuff, if
> >>>>>>>>>> you're thinking "ah I'll do this per-board" you should immedia=
tely
> >>>>>>>>>> wonder "but can we do it dynamically instead?".
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>> Casey
> >>>>>>>>> Hi Casey, Ilias,
> >>>>>>>>>
> >>>>>>>>>       Thanks for the pointer =E2=80=94 agreed, building fw_imag=
es[]
> >>>>>>>>> dynamically
> >>>>>>>>> from
> >>>>>>>>> the partition table is the right call, avoids per-target code
> >>>>>>>>> entirely.
> >>>>>>>> Can I talk to a human instead of an LLM please?
> >>>>>>>>
> >>>>>>>>>       Plan:
> >>>>>>>>>       - Keep a fixed table mapping "partition label =E2=86=92 f=
w_name + a
> >>>>>>>>> fixed
> >>>>>>>>> image index", this mapping going to be a superset list for all
> >>>>>>>>> the Boot
> >>>>>>>>> FW images supported in different Qualcomm targets.
> >>>>>>>> This reads vaguely like a rephrasing of what I proposed, not
> >>>>>>>> clear if
> >>>>>>>> you really understand it though.
> >>>>>>>>
> >>>>>>>>>          Sample table:
> >>>>>>>>>
> >>>>>>>>> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
> >>>>>>>>>         =E2=94=82 part_base_name         =E2=94=82 fw_name     =
           =E2=94=82 index
> >>>>>>>>> =E2=94=82 guid
> >>>>>>>>> (fixed)                                =E2=94=82
> >>>>>>>>> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80|=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80|=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80-|
> >>>>>>>>> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80- |
> >>>>>>>>>         =E2=94=82 xbl                                  =E2=94=
=82 QCOM_XBL =E2=94=82   1
> >>>>>>>>> =E2=94=82  QCOM_XBL_GUID                  =E2=94=82
> >>>>>>>>>         =E2=94=82 ubootspl                       =E2=94=82 QCOM=
_UBOOTSPL=E2=94=82   2   =E2=94=82
> >>>>>>>>> QCOM_UBOOTSPL_GUID     =E2=94=82
> >>>>>>>>>         =E2=94=82 uboot                            =E2=94=82 QC=
OM_UBOOT      =E2=94=82   3
> >>>>>>>>> =E2=94=82  QCOM_UBOOT_GUID            =E2=94=82
> >>>>>>>>> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
> >>>>>>>>>
> >>>>>>>>>         Target-1 supports xbl and Target-2 supports ubootspl.
> >>>>>>>>>
> >>>>>>>>>       - At boot, scan the partition table against this table. O=
nly
> >>>>>>>>> partitions actually present on that target get an fw_images[]/
> >>>>>>>>> ESRT entry
> >>>>>>>>> =E2=80=94 nothing hardcoded per target.
> >>>>>>>>>
> >>>>>>>>>       - The image index for each partition type stays fixed and
> >>>>>>>>> published,
> >>>>>>>>> so whoever builds a capsule (mkeficapsule) always knows which
> >>>>>>>>> index to
> >>>>>>>>> target, regardless of what's discovered at runtime.
> >>>>>>>>>
> >>>>>>>>>       One wrinkle I want to flag: today's SetImage() path assum=
es
> >>>>>>>>> dfu_alt_num =3D image_index - 1, i.e. it picks the Nth entry in
> >>>>>>>>> dfu_alt_info purely by
> >>>>>>>>>       position. If a partition from the middle of the table is
> >>>>>>>>> missing on a
> >>>>>>>>> given target, everything after it would shift by one position
> >>>>>>>>> and the
> >>>>>>>>> wrong
> >>>>>>>>>       partition would get flashed =E2=80=94 silently. Since I'd=
 rather
> >>>>>>>>> not touch
> >>>>>>>>> that logic in common code, my plan is to keep every fixed index=
's
> >>>>>>>>> position in
> >>>>>>>>>       dfu_alt_info stable by inserting a placeholder (U-Boot's
> >>>>>>>>> existing
> >>>>>>>>> virt
> >>>>>>>>> DFU backend, which just no-ops) wherever a partition is absent,
> >>>>>>>>> so the
> >>>>>>>>> position
> >>>>>>>>>       math stays correct for everything after it. The missing
> >>>>>>>>> partition
> >>>>>>>>> itself simply won't have an fw_images[]/ESRT entry, so a capsul=
e
> >>>>>>>>> can't
> >>>>>>>>> target it
> >>>>>>>>>       anyway =E2=80=94 it'd get rejected before reaching DFU.
> >>>>>>>> Skipping past this noise... Ilias probably knows better here but
> >>>>>>>> yes the
> >>>>>>>> way dfu_alt_num is derived from ImageIndex does impose a
> >>>>>>>> limitation here
> >>>>>>>> currently where we need to ensure the indexes always start at 1 =
and
> >>>>>>>> count up.
> >>>>>>>>
> >>>>>>>> That being said, it's already quite complicated to have to
> >>>>>>>> maintain a
> >>>>>>>> database of the indices for each board, and even more complicate=
d
> >>>>>>>> when
> >>>>>>>> we have boards that may or may not be using U-Boot SPL (for
> >>>>>>>> example).
> >>>>>>>>
> >>>>>>>> Having fixed ImageIndex values for each image would then seem to
> >>>>>>>> make
> >>>>>>>> the most sense as we could just use fwu to set dfu_alt_num (or
> >>>>>>>> another
> >>>>>>>> platform specific mechanism), however the EFI spec is clear that=
 the
> >>>>>>>> ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <=3D
> >>>>>>>> DescriptorCount
> >>>>>>>> as returned by fmp->GetImageInfo(), so we would need to also hav=
e
> >>>>>>>> dummy
> >>>>>>>> entries in the fw_images[] array so it doesn't really solve our
> >>>>>>>> problem.
> >>>>>>>>
> >>>>>>>> https://uefi.org/specs/
> >>>>>>>> UEFI/2.9_A/23_Firmware_Update_and_Reporting.html
> >>>>>>>>
> >>>>>>>> Currently, other than for setting dfu_alt_num, the only other pl=
ace
> >>>>>>>> where the image index needs to match is in efi_fmp_find() which =
was
> >>>>>>>> added by [1] seemingly to prevent an incorrect image index in th=
e
> >>>>>>>> /capsule/ file causing dfu_alt_num to be set wrong resulting in =
the
> >>>>>>>> wrong partition being flashed. In other words, we should be able
> >>>>>>>> to find
> >>>>>>>> a way to safely remove this check.
> >>>>>>>>
> >>>>>>>> But alas, it seems like we are stuck with fmp->SetImage() being
> >>>>>>>> called
> >>>>>>>> with the image index from the capsule file per the spec, and it
> >>>>>>>> is the
> >>>>>>>> only way to identify the target partition without doing other ha=
cks.
> >>>>>>>>
> >>>>>>>> I'd like to get some feedback from Ilias on this, since adding d=
ummy
> >>>>>>>> entries really doesn't feel like an acceptable approach to me.
> >>>>>>>> The only
> >>>>>>>> alternatives I can think of also don't seem great... Either:
> >>>>>>>>
> >>>>>>>> 1. Sidestep the EFI spec by either caching data in the call to
> >>>>>>>> GetImageInfo() or by assuming that the void *image pointer
> >>>>>>>> immediately
> >>>>>>>> follows the efi_firmware_management_capsule_image_header (this i=
s
> >>>>>>>> true
> >>>>>>>> for us today but would be a fragile assumption to make).
> >>>>>>>> 2. Use the internal image index (looked up via the image name an=
d
> >>>>>>>> type_id) as the index when calling fmp->set_image() - going
> >>>>>>>> against the
> >>>>>>>> spec.
> >>>>>>>>
> >>>>>>>> It's not really clear to me what purpose the ImageIndex property
> >>>>>>>> serves,
> >>>>>>>> since GetImageInfo() is meant to match on the ImageTypeId anyway=
, I
> >>>>>>>> assume it relates somehow to the fact that there can be multiple
> >>>>>>>> instances of the firmware management protocol, but in U-Boot we =
only
> >>>>>>>> have one.
> >>>>>>>>
> >>>>>>>> I think the other way forward would be to use the only included
> >>>>>>>> escape
> >>>>>>>> hatch in the UEFI spec with a custom GUID in the capsule header
> >>>>>>>> capsule_guid field which would let us have a custom mechanism
> >>>>>>>> which in
> >>>>>>>> our case could just be a soft-fork of the existing spec with min=
or
> >>>>>>>> changes so we can just remove/ignore the UpdateImageIndex field
> >>>>>>>> in the
> >>>>>>>> capsule. Maybe this would be the most correct solution?
> >>>>>>>>
> >>>>>>>> Hopefully Ilias has some time to chime in on this, I'm sure we
> >>>>>>>> can find
> >>>>>>>> a way to go about this that doesn't involve exposing dummy data.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> // Casey
> >>>>>>> I feel we are complicating it by trying to go for dynamic fw_imag=
es.
> >>>>>>>
> >>>>>>> Rather than introducing a solution that diverges from the UEFI
> >>>>>>> specification, shall we use a board-specific static fw_images[]
> >>>>>> Well, the solution I proposed at the end very much doesn't diverge
> >>>>>> from
> >>>>>> the spec, that was kinda the point.
> >>>>>>
> >>>>>>> definition. This approach is simpler, remains spec-compliant, and
> >>>>>>> other
> >>>>>> Simpler for you to implement or simpler to maintain? I think that'=
s
> >>>>>> quite debatable...
> >>>>>>
> >>>>>>> vendors (like NXP, TI) have also implemented static fw_images (in
> >>>>>>> board/
> >>>>>>> nxp, board/ti).
> >>>>>> The decision not to do this for mach-snapdragon was quite intentio=
nal
> >>>>>> and was the motivator behind dynamic generation of image GUIDs:
> >>>>>> https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-
> >>>>>> v8-0-79b31b199bee@linaro.org/
> >>>>>>
> >>>>>> The image index issue was always bound to come up, and it's absolu=
tely
> >>>>>> something we should be solving and not just sidestepping. We alrea=
dy
> >>>>>> support dynamic fw_images[] anyway and it's already being used by =
some
> >>>>>> devices, so we need to maintain the existing support regardless.
> >>>>>>
> >>>>>> As I understand it, Qualcomm also intend to support multiple boot
> >>>>>> media
> >>>>>> (UFS, eMMC, SPI flash) with a single U-Boot binary, so to some ext=
ent
> >>>>>> this array must be dynamic. And since at boot time we have all the
> >>>>>> info
> >>>>>> we need to generate fw_images, keeping a static list per-board is =
at
> >>>>>> best lazy and at worst will just make things even more complicated
> >>>>>> when
> >>>>>> we suddenly want to support configurations with/without OP-TEE and
> >>>>>> with/without SPL.
> >>>>>>
> >>>>>> So unless I'm missing something here I think there's a strong case
> >>>>>> here
> >>>>>> to add support for ignoring the capsule provided image index, but
> >>>>>> we'll
> >>>>>> see what Ilias has to say when he's back from vacation.
> >>>>> Okay Casey.
> >>>>>
> >>>>> Hi Ilias,
> >>>>>
> >>>>> Request your input on this.
> >>>> So the problem you are trying to fix here, is that you have boards
> >>>> with multiple configurations, that their image index might change, b=
ut
> >>>> you want to update them with a single capsule right?
> >>>>
> >>>> If that's the case, we can have a board specific function that does
> >>>> nothing by default, but on the qualcomm case, re-arranges the capsul=
e
> >>>> image indexes *after* the capsule authentication has passed. I think
> >>>> this still violates the EFI spec, but I am ok with it.
> >>>>
> >>>> Cheers
> >>>> /Ilias
> >>> Hi Ilias,
> >>>
> >>>    Thanks for the input. Just to make sure we're on the same page:
> >>>
> >>>    Our understanding is that we'd add a board-specific hook (default
> >>> no-op, so other vendors are unaffected) that runs after the capsule
> >>> signature is verified but before dfu_alt_num is
> >>>    derived from image_index. On Qualcomm boards, this hook would look
> >>> at the partitions actually present at boot and remap the capsule's
> >>> (fixed, published) image_index to whatever position that image
> >>> actually occupies in dfu_alt_info on that specific target =E2=80=94 r=
ather
> >>> than assuming a fixed 1:1 mapping between image_index and position.
> >>>
> >>>    To be clear on scope: we're not ignoring the image_index value
> >>> itself =E2=80=94 it's still read from the capsule and used as-is to l=
ook up
> >>> which firmware component (xbl/uboot/etc.) is being
> > no, the entire point is that the image index is bunk, why are you
> > feeding these emails through an LLM?
> >
> >>>    targeted. What we're overriding is the spec's assumption that this
> >>> index also encodes position, i.e. that dfu_alt_num =3D image_index - =
1
> >>> and that image_index stays within descriptor_count.
> > the spec's assumption????? this has nothing to do with the spec
> >>>    Since our FMP descriptor list is built dynamically per-board, a
> >>> fixed global index can exceed the descriptor count on boards missing
> >>> some partitions, so we remap it to the correct DFU
> > no
> >>>    position ourselves instead.
> >>>
> >>> Is that a correct read of what you had in mind?
> > please use plain text formatting for emails.
> >>> Regards,
> >>>
> >>> Balaji
> >> If the above assumption is correct, then we will have following proble=
ms,
> >>
> >> During authentication, U-Boot performs anti-rollback checks.
> >>
> >> As part of this flow, the Image Index is converted to an Image GUID
> >> using fw_images[].
> >>
> >> Since the capsule Image Index does not match the fw_images[] Image Ind=
ex
> >> at this stage, the anti-rollback logic may resolve the wrong GUID or
> >> fail to find a matching entry in fw_images[].
> > I'd like to understand from Ilias why we need to authenticate the
> > firmware first before adjusting the image index, I'd hope we could avoi=
d
> > that? Unless changing the index would invalidate the checksum

I was remembering the FMP parts wrong. Looking at the spec again, it
seems that UpdateImageIndex is not part of the signed payload. So you
can switch it before that.

> >
> > The image is authenticated inside of fmp->SetImage() at which point we
> > don't have the image type ID or name so it's too late at that point. We
> > would need to adjust it earlier.

Yea that should be fine

> >
> > perhaps we could go about it another way, what if we add a dfu_alt_num
> > field to efi_fw_image (and add a flag to efi_capsule_update_info to
> > indicate if the new field is valid), then in efi_capsule.c just before
> > we call efi_fmp_find() we can call a new weak function that would adjus=
t
> > the image index of the matching efi_fw_image so it matches whatever is
> > in the capsule. Then we don't have to care what it is since we can use
> > the right dfu_alt_num field anyway.


Doesn't that have to be defined per board config though?

> >
> > Maybe this could just all be done in efi_capsule.c and not even need a
> > platform hook, either gated behind a config option or just behind the
> > new efi_fw_image.dfu_alt_num field being used.
> >
> > I worry that's too much of a workaround that might cause issues down th=
e
> > line but I'm not really familiar enough with this to be sure.

I think the workaround is not too big of a hack. You are essentially
remapping some image indexes based on runtime info of the board
because you want a single capsule to support multiple confugurations.

>
> Casey,
>
> We have checked and this approach seems to be fine. In this approach
> though, it comes back to the issue we saw earlier: the image index (from
> the capsule) could be > descriptor count.
>
> If this is fine, then we can proceed with this approach. Atleast we
> won't be creating dummy dfu strings.
>
> Ilias,
>
> Would like to hear your view on this, so we are all on the same page.
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
> >>>
> >>>>> Regards,
> >>>>>
> >>>>> Balaji
> >>>>>
> >>>>>>> Regards,
> >>>>>>>
> >>>>>>> Balaji
> >>>>>>>
> >>>>>>>> [1]: 7cf06f09cc51 ("capsule: Put a check for image index before =
the
> >>>>>>>> update")
> >>>>>>>>
> >>>>>>>>>       Let me know if this approach sounds reasonable.
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Balaji
> >>>>>>>>>>> Will send an updated series once the mkeficapsule and qcom
> >>>>>>>>>>> capsule
> >>>>>>>>>>> update changes are in shape.
> >>>>>>>>>>>
> >>>>>>>>>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
> >>>>>>>>>>> sughosh.ganu@linaro.org/
> >>>>>>>>>>>
> >>>>>>>>>>> Regards,
> >>>>>>>>>>> Balaji
> >>>>>>>>>>>> Kind regards,
