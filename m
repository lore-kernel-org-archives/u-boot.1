Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084E6C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 06:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE9C8070C;
	Thu, 27 Mar 2025 07:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="AJyF7sT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2A1807D7; Thu, 27 Mar 2025 07:12:13 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41A4806D8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jG8a022979;
 Thu, 27 Mar 2025 06:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9+bZS6N/JkESFQqvYYU5GNwt
 k+6SSS+l0UZ0UBGYQ/U=; b=AJyF7sT9bOdcqOlBz/tup113QZmbzjn10AdcsS6V
 w02xNgBKURVbaKRYGlzoYeYdCM6iltEmmJgAY/trJPcAUpRF76QCORIC8dwA4lnp
 e6bXCvWo0ve/gR2ypf+5VhDqAbjOqaALXgm+9o0ZwdWiwOml84uI8pSE0rjKh1aO
 tc54hX+taDwDYOOqOqjlyudMGqqsyayhbZ9K7du0Va0FsQuOXVN17LkddZ/dKj+a
 /+gZrGLVZjSYcTWpn614PSXPcdzyGvrfIBETvRY1BxuJJ8x9K5pzmvanAFuq1vCa
 ZzdlvHfI7103jb+DSnomzqim9ZBGgPRsKWqdUvWEGSUPBg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9muq0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 06:12:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R6C5xj012573
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 06:12:05 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 23:12:02 -0700
Date: Thu, 27 Mar 2025 11:41:58 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <EABachinin@salutedevices.com>, 
 <jerome.forissier@linaro.org>, <rasmus.villemoes@prevas.dk>,
 <ansuelsmth@gmail.com>, <sughosh.ganu@linaro.org>,
 <michal.simek@amd.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
Message-ID: <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e4ec36 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8
 a=B7lkYa6swIx8ZzCZhPsA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dKkmRgrlbTGDQa-B49DBqvvruxGdtJE0
X-Proofpoint-ORIG-GUID: dKkmRgrlbTGDQa-B49DBqvvruxGdtJE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=480 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270038
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

On Wed, Mar 26, 2025 at 09:28:04AM +0200, Ilias Apalodimas wrote:
> Hi Varadarajan
>
> On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > If the EFI runtime services pointers are relocated even though
> > relocation is skipped, it corrupts some other data resulting in some
> > unexpected behaviour.
> >
> > In this specific case, it overwrote some page table entries resulting in
> > the device memory address range's mappings getting removed. Eventually,
> > after the completion of efi_runtime_relocate(), when a driver tries to
> > access its device's registers it crashes since the mappings are absent.
>
> How were those page table entries added?

initr_caches ->
	enable_caches ->
		setup_pgtables (arch/arm/mach-snapdragon/board.c)

> The runtime service relocation might have overwritten those now, but
> since they are not in protected memory this can happen arbitrarily.

To avoid relocating U-Boot, I had OR'ed GD_FLG_SKIP_RELOC to gd->flags
in init_sequence_f -> mach_cpu_init(). Hope that is the right place and
way to do it.

> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  common/board_r.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/board_r.c b/common/board_r.c
> > index 179259b00de..1dd3b96c2de 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
> >          */
> >         efi_save_gd();
> >
> > -       efi_runtime_relocate(gd->relocaddr, NULL);
> > +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> > +               efi_runtime_relocate(gd->relocaddr, NULL);
>
> Have you tested booting with EFI with this change?

Yes, tested this with both GD_FLG_SKIP_RELOC set and not set.

Used the command 'bootefi bootmgr' and Linux is able to boot.

Thanks
Varada
