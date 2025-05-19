Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFF5C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 07:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565AB81E72;
	Mon, 19 May 2025 09:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="BXQos7X/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9474881FFC; Mon, 19 May 2025 09:23:14 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C002803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 09:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IMm9xB014902;
 Mon, 19 May 2025 07:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QhthCwjcpNkeK/fmJFc9WzWr
 8bC7TPoqLb62LvlW1qg=; b=BXQos7X/Z2u5rYuEbUZzzGGNWIRhJcDd6AGy5JJv
 wugGph7JJtqVGmyQDJDhctwg9TkvzKhxVjh+Q/KwRiMugJoPviedN1zA+v9z47Le
 OCXOpiDOaUxMNHrIvrwDz00gAUCMPudeNOZW/zHJcZxi5lfsYKG4HUXz8D8TlOAJ
 KXCKhb6hf9IFPypxvX+bPYB2P0D99eF+Z8ezpHu7aP8dOaeGs42mLSdDppZRHD5H
 yl/tNV8ICp5DZTGncJz3UPksWHNnD2LK66eX5RPEWeySPU3o6Ia46ZFZ3xkd7iPM
 c0cFPwEJ24Z3wr1ExKHFjFeHvMxlbVmPCceJNh069Q0a5Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjjsuepk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 07:23:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54J7N45X011214
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 07:23:04 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 May 2025 00:23:01 -0700
Date: Mon, 19 May 2025 12:52:57 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Simon Glass <sjg@chromium.org>
CC: Caleb Connolly <caleb.connolly@linaro.org>, Devarsh Thakkar
 <devarsht@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas
 Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>, Richard
 Weinberger <richard@nod.at>, This contributor prefers not to receive mails
 <noreply@example.com>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] common/board_f: init malloc earlier
Message-ID: <aCrcUZMU3OViHo7s@hu-varada-blr.qualcomm.com>
References: <20241124183832.2476928-1-caleb.connolly@linaro.org>
 <CAFLszThqtA_WBxOU-EnEvw956ZMN9KErx_C4gTzW_+p_tGu9qw@mail.gmail.com>
 <cd43db10-4939-4958-97f2-9a2046d82160@linaro.org>
 <CAFLszTgEhfbk4ug=JoU_jTgdzSkF-fXuqamGmPJHpdogwocbRA@mail.gmail.com>
 <a8cd7895-7968-4ef9-bc5f-dd36c04d9db8@linaro.org>
 <CAFLszThuqGKt+j9y+JgPpwKYe-2f_MJ4DHh=wzWzOjWv715xUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszThuqGKt+j9y+JgPpwKYe-2f_MJ4DHh=wzWzOjWv715xUw@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 9KI53Xetv-TeYS6SD-GsBvUWDdxRItIS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA2OCBTYWx0ZWRfX5LE5MwlkE6o0
 mAxx08GBWaTD8gkIy5diz+mXZKajcB/4jdG/DxFBvHBpvJgWwMTmLyccUnA70V6Riy/d0hAri9S
 vpSiNxjrWZRcKAWz7WKKzVZibo67uRoLU0AfsVEoh1e+vtsUS9IVq55RI9dTz0/Ymym1X2L35w0
 tHzkfdSWjXUjnybOwISSxDbKwr+FFg6lEI8NIYDIdS7/zIMj9TvdSUETOqYQdxbkNhYYpVISXCi
 ifxm+3cywDUQcvxgO1UXfc8HoGQ2kRLEKNnLCem8Yg2S9UTlfisw1e0g/I+BOSPKFGd0Uw2eola
 RZGTCXSDEOAAF8bAD+BECQhjl2ZYFVS4G0R5wtpktAn7ufYsuvWOchmNkNFVHEqI0jEs9Hsol/i
 +M/k4nCXSdvhLrAGFibP11961ruBTh36vq23GoYF/vuOoa0zJOwWxDk09uW+1TKaJ+tpVNyg
X-Authority-Analysis: v=2.4 cv=K4giHzWI c=1 sm=1 tr=0 ts=682adc59 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8
 a=LKnWJ6M9mV0mj8fQErUA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9KI53Xetv-TeYS6SD-GsBvUWDdxRItIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190068
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

On Wed, Nov 27, 2024 at 06:08:25AM -0700, Simon Glass wrote:
> Hi Caleb,
>
> On Tue, 26 Nov 2024 at 09:15, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On 26/11/2024 16:38, Simon Glass wrote:
> > > Hi Caleb,
> > >
> > > On Tue, 26 Nov 2024 at 05:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > >>
> > >> Hi Simon,
> > >>
> > >> On 26/11/2024 01:32, Simon Glass wrote:
> > >>> Hi Caleb,
> > >>>
> > >>> On Sun, 24 Nov 2024 at 11:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > >>>>
> > >>>> Currently the early malloc initialisation is done partially in
> > >>>> board_init_f_init_reserve() (on arm64 at least), which configures
> > >>>> gd->malloc_base. But it isn't actually usable until initf_malloc() is
> > >>>> called which doesn't happen until after fdtdec_setup().
> > >>>>
> > >>>> This causes problems in a few scenarios:
> > >>>>
> > >>>> 1. when using MULTI_DTB_FIT as this needs a working malloc (especially
> > >>>>    for compressed FIT).
> > >>>
> > >>> Hmmm, how does this work today?
> > >>
> > >> I honestly have no idea, I assume boards that make use of it do some
> > >> custom board_f.
> > >
> > > OK.
> > >
> > >>>
> > >>>> 2. Some platforms may need to allocate memory as part of memory map
> > >>>>    initialisation (e.g. Qualcomm will need this to parse the memory map
> > >>>>    from SMEM).
> > >>>
> > >>> That really needs to be tidied up. When does this fixup need to be
> > >>> done? I imagine it is somewhere prior to setup_dest_addr() ? Perhaps
> > >>
> > >> It's necessary in order to figure out gd->ram_base/ram_size. We do it in
> > >> board_fdt_blob_setup() so that we can support another use-case where
> > >> U-Boot has an internal FDT (which it should use) but the memory layout
> > >> is provided via an external FDT which is unavailable (although this
> > >> usecase isn't enabled upstream yet).
> > >>
> > >>> we could introduce an event to do 'memory map' stuff?
> > >>
> > >> We could, but considering that on most platforms the pre-relocation
> > >> malloc is fixed at build time and at a known location relative to U-Boot
> > >> there is no reason for us to arbitrary decide that some codepaths at the
> > >> start of board_f aren't allowed to use malloc().
> > >>
> > >> Just moving the malloc initialization earlier ensures malloc() is
> > >> consistently available and greatly simplifies things.
> > >
> > > I'd like to see a more generic solution to this problem...I think we
> > > discussed this before?
> >
> > I think so. I'm not sure I follow with "more generic solution"?
>
> Using an event to set the RAM location, rather than repurposing the
> FDT-setup function.
>
> > >
> > > To my eye it looks like if we called an event in setup_dest_addr() we
> > > could allow ram_base to be set.
> >
> > Right, it's possible/likely that we could clean up how mach-snapdragon
> > currently does memory parsing.
> >
> > I do think this patch would still be justified even if we ignore the
> > Qualcomm case.

Simon,

> It does put malloc() outside the purview of trace. There is always
> going to be a race between which subsystem wants to be first and we
> have certainly changed it several times. But until we have an actual
> need, I think it is better to wait.

IPQ platforms use CONFIG_MULTI_DTB_FIT and CONFIG_MULTI_DTB_FIT_GZIP.
The gzip decompressor allocates memory and faces this problem. Moving
initf_malloc(), above helps resolve this. Would that be considered as
a good justification to moving up initf_malloc()? Please advice.

Thanks
Varada

> > >> fwiw, I had another variation of this patch which dropped initf_malloc()
> > >> entirely and just set up gd->malloc_limit/malloc_ptr in
> > >> board_init_f_init_reserve() since that's where we set malloc_base
> > >> anyways. But after digging some more there seem to be quite a few other
> > >> entrypoints into U-Boot that don't go through
> > >> board_init_f_init_reserve() (e.g. sandbox, EFI app) and it seemed more
> > >> error prone to duplicate the implementation there.
> > >
> > > Fair enough.
> > >
> > > One more thing I notice in your board_fdt_blob_setup() implementation
> > > in arch/arm/mach-snapdragon/board.c :
> > >
> > > It seems to be using either an built-in or external devicetree. It
> > > seems that we should show this in dm_announce(), i.e. with the call to
> > > fdtdec_get_srcname() ?
> >
> > Yes, the way it's implemented currently assumes that if CONFIG_OF_BOARD
> > is set that we'd never use the built-in DT and mach-snapdragon doesn't
> > fit this assumption. It's not a high priority but for sure something I'd
> > like to see fixed.
>
> I'm not even sure that assumption is right, actually...
>
> [..]
>
> REgards,
> Simon
