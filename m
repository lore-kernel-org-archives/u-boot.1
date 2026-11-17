Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C32606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XesK4+R3;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RUUJmtUu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G5yMCngd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A98B5608A0;
	Tue, 17 Nov 2026 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZYV_g97cQJd; Tue, 17 Nov 2026 13:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3335860872
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794920521;
	b=WVCE8WQczxKJRRsPz4JnOYFowOsPCp+wNVnzH1Mjk7waolLtLDRiaQxN9f0tTSV/wbrD
	 yFv7B0tNKpHHrvWpjbp1nkphhS1mzxKetiBTZGpv8izUPi1Vug3ZReOSB37OeIFEIq4fv
	 zDqdCDCY0fXHvWjFQAA1Ksb3UrQx1suPrZTF1TSFt3/cFIp77QAiDeeiglZxkCcLv0yJ6
	 jDE7PPbiS+t4qzxXNxiG5NamhQfVlp+rr7L3tzJKX4kqjXPgHPrdKM8QiqIhKawicv2kE
	 g2BeHPzpYV8IIFOWCxkdRQAVA2L2SXz/mbDz7uvYjROOlZ6YTmyybtMUuuXiHQNyaMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1Z9+NSNAonR8IIY4cPioN1cczdH4ipdw3WnerB6wIM4=;
	b=Zs47zQ1tlXYyt8Xl8quIK6TnsblIwb0oxkUozbDI4caWh+3hevlu6HRWi9bTb7m5Ldw6
	 Au89RxAWg01oo/pw7s0cFTvY8hh7v6A2CL9JYi3p0ch8iFkc9br7YJCzndOYL/g4b18Hu
	 FOZk/+NTaFI0vkWxKDGQ+7Vyo2ZFzST48HqUbsjrPB2gwwDjGnpZ5WLUOAZ15x+Zvc6zS
	 rqsL86BVbnt3VXSNrcQpnvBMYkgAAb+tHxw37cBbml07VzngjIogUQv6+/DOmJZ33JcdS
	 zjZ1vCXFNdWTv6AYSZx4Slnnh8gksg3IIbanVhyRgSWTJceYZZhXvYy4AhvNVAd/A3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794920521;
	bh=1Z9+NSNAonR8IIY4cPioN1cczdH4ipdw3WnerB6wIM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XesK4+R3M1AQIK6qJUj+M1vTitvOTHSt6wquVnWOxyG0/vw90ywCh56UkW1T3kVw2
	 2gwRch+gYv+y7Phr2VFPBO6Zyq4feCY2l26DycOQ6e+N1wqbNl7dyYMjw2xDNJ8PCW
	 5PnNiGUEc3sDGQU8GHj10niiYTUuJkH+qjI7OaTZEHFMm/tmWBAA8ttK3yffkIuy+p
	 hIxPHBVhewixY2ZxdSsKA4d6NiSBlCnWVriPmLc3V4Nw2n+yZR1MC2Mlm7WHnILsD7
	 fca/dehbdPQ5v98KXt+osZZjqSDfk1Q9cGK4TkluVYD096ljUljAbhHgYul2Us1ssk
	 ugMZWaTbYlsmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3335860872;
	Tue, 17 Nov 2026 13:02:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 405462FB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31C804008B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgEH38fOjx7w for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 40AD740042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RUUJmtUu; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G5yMCngd
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40AD740042
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:01:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHC0qLA3047905
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Z9+NSNAonR8IIY4cPioN1cczdH4ipdw3WnerB6wIM4=; b=RUUJmtUuBwEQ11jD
 evxwRx05srwZ8OoOW+dvb3caEIIShwINTu5zh4nXQc+PR3Qlg7GM3oGDsm/Fv/R7
 LshqXdXxNngRp1ZBwmyKHAZC21KuF90h23I9q+i/8zRIvrES7D/XfMxWXTksEMgK
 6bvr1efiQCaqvZzrY1z36S3LkabtxjWNgY1NnbvRdnut3D8oc51vpgEe4vbWPgRK
 lDMbQkHYrwGTiSL5+vC1kzugEm6q6kPSuUhZwLtLLgsktIacn1uccXP3HVLlpP0N
 AJ7uH6R7hbe3w8I9LQE+F1yUjq/s8R+UikVAhvJEPX32dlqzgJvFRKrrOAsIWCTP
 jkU9sQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv10nnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:01:56 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b155f4eb8eso70055767b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 05:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794920515; x=1795525315;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Z9+NSNAonR8IIY4cPioN1cczdH4ipdw3WnerB6wIM4=;
 b=G5yMCngdkxGLYZqq7Y5jqJrT+VgYeiTCstY6u+VV3EuXtcY7/Zex+DkIVA+fKlTMki
 ETYlwwkiZWGzjecVzSk0DBwdexdRAm6E+WahF89507Iea7ME5dfjJyHaD2RiJIBJLVZ9
 7QRPCSK72iVOVHIokbqGQ1PKDwVNGdEmSZA+dEx34ZXztFgAj9IhD1ix+/A03hSSGmdh
 7dabi9LG22DU2Y9107yuQA033upbbTr2GB1jIx6X93vakiBfDGLPYcg4HDxMcXFV+xTb
 bzE0MG61r/1ywDSs2wjVu0omXQhlK0DzlChw6pTWf+t9ratbskPljw4pZpyAX4dVJExa
 qpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794920515; x=1795525315;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Z9+NSNAonR8IIY4cPioN1cczdH4ipdw3WnerB6wIM4=;
 b=hqC70p+sNPJe0BFwBf6p+PFzhsMBrsEegcyKIbo2LxRPS54RJabYeJ6AYVCq6iOK7g
 wo4RcmvmPOFuxb3H/H3wfBYxPcygjJrYtRrK74V7Tl2VCbEe4qyAo9f4E59hjnC4kSBp
 E2nKs0D1WiqjD9RBEfCHjIumzG1hnIPkGDCFklyPYfYlZCAPQ6rL+Rd1cxR7lzM8Qb/Y
 pNPfqa0GsIwcXK+KJ1P8LvfdnSmqW5e43EdxzxIYxxbIxkTWbGS6Vcz7cVX9gr8YSUtg
 XiG9lACujKTgDk/m0H/x9y51eVpHGfW6YQxT6vf793dIyWKTGYaap2mBz99e95djiMgm
 bnyw==
X-Forwarded-Encrypted: i=1;
 AL+hErHlniCYQ99/SQBToiwI86EE14NxONOHTJhy/cQZEJLE/OFljUQC5Xq6v1FYpO6ioeAv4dn8fow=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/hRhfFbWws/hOun5cBuGLBcXwh9sQ0IW0F8lWn7GwaU1hvT6Ls
 5tswQcwibUVSuMZrK9tEQgJ3ed3BMxGpdW70cR0ftQ9B88cbuQCM4DP/YVWh4L1bQHxNGFTJ+IA
 VBIeXRWRUEqi90Bm0RTwzoF4ueLuTo+3vOItLJpl4DMSKuRSvWco2ZZUL6lzaQWFihp8+aOrz/C
 IFCspKgOr2VXKABOa4FO7UtPWzEA8CuOnNk8CpkR2unM+xcw==
X-Gm-Gg: AZFdTZfA/Ly3EkPxh8c1CeqTw1WdFsaOknsS62nERKLUERaQ9bjtn4bGo2Q076Lp5Ih
 BjW1JNcilZalkL1L/W5gzM4bAWoctEWyI4ESQsBiPf6wm7wgnGeaUYstDw4BI7kH/CFq6TiNHkY
 cAJzX9tz5+25zImSPXvOcfDHy7dXAvbkGFYvKcjOuj2Kycam94YyzsdI/N
X-Received: by 2002:a05:690c:e251:10b0:8b3:23f3:134d with SMTP id
 00721157ae682-8b4aa2b33a1mr42053607b3.42.1794920515027; 
 Tue, 17 Nov 2026 05:01:55 -0800 (PST)
X-Received: by 2002:a05:690c:e251:10b0:8b3:23f3:134d with SMTP id
 00721157ae682-8b4aa2b33a1mr42053327b3.42.1794920514392; Tue, 17 Nov 2026
 05:01:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117064225.797584-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20261117064225.797584-1-ilias.apalodimas@linaro.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 14:01:43 +0100
X-Gm-Features: Aa3M54pzqnu8ginx_oUUz-lE0898g1CAek9KjfZLGmwtic2xG5yjFLlhFZ8wwkU
Message-ID: <CAPzfCAZcP6t7ian8cg_V12EELNUYHLkpvcCWVdD=52snur2D3A@mail.gmail.com>
Subject: Re: [PATCH] Revert "optee: rpmb: select the RPMB partition per
 request"
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: D8SYUU0Mxf6KU7Ez4Fgei4ZaX6p7F94i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX8z3mHijYurBv
 FS1ipkW7SddKINLMscWax6gHgE5OUCpBdNKV2FqQA6nNo0mz2lCHNoASW5BVarO5lAe4LE69UUt
 Cz50jb4bmqnGZsy08zVSGDVRutIv2tU=
X-Proofpoint-ORIG-GUID: D8SYUU0Mxf6KU7Ez4Fgei4ZaX6p7F94i
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afc5044 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=wU2whtpG63PqJvbzmJ8A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX1X6k1+f9UsFb
 sQ99IkpQLWKgbelIIxaiM+aViFWEJfO3vcDfShXWfZMMbd6PnhRM1eVdf9LVIzQydboib4fwSE0
 IxRVxZ+lJQNFOiriUV3jaa8NK49TUpLDXScld0NiT2+VYBCEPHMAoENWwAkl7Dvbd7z48iZa1rg
 Xn3fx3N6sVX4v1kymSOfUu1dgo11snx9zyoXUWkMN5H0s/ZkBhVZMMCbChvrIbNINqdOLACzhkX
 A0sbR9ToBPGD08ajrzFg4AgPmg1Hw7+58tiWkhgGfNVwNRiJ/8njrVAs2uVfYV9N6s2TA3gRUtn
 sbuY/MHlyz1nweqH8RV+7OY94zlr9LfmglwOHoL/HXOmRHbb+KD9z1yRFbe0Ycs11dyGUMmwQHC
 Qu43gdZ0gwu+SDuJaH2Doo3mSQ1ZSSxU7g03QWMG96sUXDAeKEqH213Dm+YQZNWr2n01QoPegfA
 RTJ5xbxmvbIvVuMVnIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Tue, Nov 17, 2026 at 7:42=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> This reverts commit f473480c43a85961b62a45436a7e095e16c2cdab.
> We discussed in the thread that this isn't need but was inadvertently
> picked during the merge. Revert it
>
> Link: https://lore.kernel.org/u-boot/CAC_iWj+0wVosYVrq3pAyDF+ekjf=3Dsq7oO=
nRZfb_CfddDZq4c-Q@mail.gmail.com/T/#m7cc19b8ca8b05a2ad192b8264629f08c6a5ea8=
6a
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

> ---
>  drivers/tee/optee/rpmb_emmc.c | 88 ++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emmc.=
c
> index a40573c92818..c00e46be9494 100644
> --- a/drivers/tee/optee/rpmb_emmc.c
> +++ b/drivers/tee/optee/rpmb_emmc.c
> @@ -42,55 +42,51 @@ struct rpmb_dev_info {
>
>  static void release_mmc(struct optee_private *priv)
>  {
> +       int rc;
> +
>         if (!priv->rpmb_mmc)
>                 return;
>
> +       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> +                                     priv->rpmb_original_part);
> +       if (rc)
> +               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> +                     __func__, rc);
> +
>         priv->rpmb_mmc =3D NULL;
>  }
>
> -/*
> - * The RPMB hardware partition is selected for the duration of a single
> - * request only. Between two requests other users of the same eMMC, for
> - * instance libavb reading the user area while verifying a chain of
> - * partitions, switch the device back to the user area. Keeping RPMB
> - * selected across requests would make those reads, and the following RP=
MB
> - * frames, hit the wrong partition. get_mmc() therefore selects the RPMB
> - * partition on every call, and restore_part() puts the previous one bac=
k
> - * once the frames have been routed.
> - */
>  static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
>  {
>         struct mmc *mmc;
>         int rc;
>
> -       if (!priv->rpmb_mmc || priv->rpmb_dev_id !=3D dev_id) {
> -               release_mmc(priv);
> +       if (priv->rpmb_mmc && priv->rpmb_dev_id =3D=3D dev_id)
> +               return priv->rpmb_mmc;
>
> -               mmc =3D find_mmc_device(dev_id);
> -               if (!mmc) {
> -                       debug("Cannot find RPMB device\n");
> -                       return NULL;
> -               }
> -               if (mmc_init(mmc)) {
> -                       log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init =
failed\n",
> -                           __func__, dev_id);
> -                       return NULL;
> -               }
> -               if (!(mmc->version & MMC_VERSION_MMC)) {
> -                       debug("Device id %d is not an eMMC device\n", dev=
_id);
> -                       return NULL;
> -               }
> -               if (mmc->version < MMC_VERSION_4_41) {
> -                       debug("Device id %d: RPMB not supported before ve=
rsion 4.41\n",
> -                             dev_id);
> -                       return NULL;
> -               }
> +       release_mmc(priv);
>
> -               priv->rpmb_mmc =3D mmc;
> -               priv->rpmb_dev_id =3D dev_id;
> +       mmc =3D find_mmc_device(dev_id);
> +       if (!mmc) {
> +               debug("Cannot find RPMB device\n");
> +               return NULL;
> +       }
> +       if (mmc_init(mmc)) {
> +               log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n=
", __func__, dev_id);
> +               return NULL;
> +       }
> +       if (!(mmc->version & MMC_VERSION_MMC)) {
> +               debug("Device id %d is not an eMMC device\n", dev_id);
> +               return NULL;
> +       }
> +       if (mmc->version < MMC_VERSION_4_41) {
> +               debug("Device id %d: RPMB not supported before version 4.=
41\n",
> +                     dev_id);
> +               return NULL;
>         }
>
> -       priv->rpmb_original_part =3D mmc_get_blk_desc(priv->rpmb_mmc)->hw=
part;
> +       priv->rpmb_original_part =3D mmc_get_blk_desc(mmc)->hwpart;
> +
>         rc =3D blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB=
);
>         if (rc) {
>                 debug("Device id %d: cannot select RPMB partition: %d\n",
> @@ -98,18 +94,9 @@ static struct mmc *get_mmc(struct optee_private *priv,=
 int dev_id)
>                 return NULL;
>         }
>
> -       return priv->rpmb_mmc;
> -}
> -
> -static void restore_part(struct optee_private *priv)
> -{
> -       int rc;
> -
> -       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> -                                     priv->rpmb_original_part);
> -       if (rc)
> -               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> -                     __func__, rc);
> +       priv->rpmb_mmc =3D mmc;
> +       priv->rpmb_dev_id =3D dev_id;
> +       return mmc;
>  }
>
>  static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
> @@ -143,7 +130,6 @@ static u32 rpmb_process_request(struct optee_private =
*priv, void *req,
>  {
>         struct rpmb_req *sreq =3D req;
>         struct mmc *mmc;
> -       int rc;
>
>         if (req_size < sizeof(*sreq))
>                 return TEE_ERROR_BAD_PARAMETERS;
> @@ -153,11 +139,9 @@ static u32 rpmb_process_request(struct optee_private=
 *priv, void *req,
>                 mmc =3D get_mmc(priv, sreq->dev_id);
>                 if (!mmc)
>                         return TEE_ERROR_ITEM_NOT_FOUND;
> -               rc =3D mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> -                                          req_size - sizeof(struct rpmb_=
req),
> -                                          rsp, rsp_size);
> -               restore_part(priv);
> -               if (rc)
> +               if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> +                                         req_size - sizeof(struct rpmb_r=
eq),
> +                                         rsp, rsp_size))
>                         return TEE_ERROR_BAD_PARAMETERS;
>                 return TEE_SUCCESS;
>
> --
> 2.53.0
>
