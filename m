Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9A1C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 09:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 632C840816;
	Wed, 22 Jul 2026 09:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Md5ty3mFAFhb; Wed, 22 Jul 2026 09:48:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 016C140793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784713687;
	bh=5h6iV8i0u6Ctu//X2BToVLyY17hxCEJ9MlYZqrx56xo=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=i4sdyHig39wKHClkiaWs7D25ZWOGT9YG87N7meg7k75/7KCnWx8iqV4fBW2oCcEQc
	 21fwPaM8+OiYFcobcC9C4XWp17npqfSKvX31Wcp93kDQMRnIXVOHUpLmJRntYdvfjk
	 hBA16a0u349k5S3Kp5yBjuqRnl18yUnJKZ2XHuQz3zQN95TNv+kv+XHA42O/D91dUm
	 JICwQLYzOyZuBUkLH+lZYDdG0HinIKVOPn1Nqumc5IluJgsYqkwXkC/xDly3bwpvKg
	 ChIq1Z++dH5DvbAAwA1OEc0DB3sEtkJX3lOa047sBct07DbeLv37OCyOB1GWevmIl7
	 jcGN+ks+Bzvog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 016C140793;
	Wed, 22 Jul 2026 09:48:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D4FDF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46402607A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qv7s52y3_SkZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 09:48:04 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F338C60737
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F338C60737
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F338C60737
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:48:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664D5848BA; Wed, 22 Jul 2026 11:48:02 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EF0803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:47:59 +0200 (CEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x5Uw1400161
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:47:58 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr838xgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:47:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so298724341cf.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 02:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784713677; x=1785318477;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5h6iV8i0u6Ctu//X2BToVLyY17hxCEJ9MlYZqrx56xo=;
 b=c961W7ey9T+eoezHUC7E9xW8kkDhd2PoOouOWwbNbBF5YtLJ1n1KxOxc4yANNwsCdx
 0087oGh/RyHczl+OHX6tkCPpYt6XkXQor4rc/d/00flhvzSSC6IC489QnMrttOf0+yvR
 5UVPFdZTBCAkVXDBY5FRFu3Z3dAproPZeiKFBY1V5rFH9/3AqODUsUiJU81v9K2FIW9x
 Q0wU7b0XOUduIBIr2fCYsMqpvEgZeSnijv6E0f7Mix8P4XVc436y4hxHLG33ojxfl+E6
 eC2wJDX7VETaCSMaDlT34PJH9ZrDUkYutr3O50ZrUbXr0Z0hQqbAqv9b8sSkXAbZgTnc
 iBdw==
X-Forwarded-Encrypted: i=1;
 AHgh+RowLADe8ghNGlq+QpjDuY6yHgjDt2uzpQCnEoLFoP7wQg0nEMIgdA0KXXxLEqAzmSPrY6PC++k=@lists.denx.de
X-Gm-Message-State: AOJu0YyKwd68HtpTmQhImXtzDWFnGfHjLRioSqLyJLZaUlfpeK2MhNmH
 ql96wfkqfKtB8bldYKRiTADCdYtMTMyBomcGzGbHXQF/adLnkDT6kO4h5+h3K9qr0g86Gmg+u6j
 ZaTD/XmqZx70w/dispCaB+hJFLu673xiGfcfZsM1rcN9vLLgqDTqOKnP1
X-Gm-Gg: AR+sD12zLRrGHHN1BStahaBxlyQfnselkuBWnAal+wlY2k1XAnkbxPxw/NUSB344Pda
 99E1Mir7JVIW5Dm3n+WQfTjUw6qyIAh2siu+cToMXibYR9jAtMovo6N+5Bn1kk/TSIJXZpb/RV8
 RNbVQx/i5bttJiPAaMWzh2gSn0UdyhLnbagS3noXde8SD+KuvlLhY6AvVqHEtFrYuanKmO439Zc
 jHK6wWESpeyjDrj0pY1X2hlAFToVhG4rqzU2WBrqLWZ+rxOxanwy8g0QvZx7QwpUBdqn5ZxYTgg
 vi0ZH9TCD7LJ3ZYedNg/rpzcu1jfb9t4WzjxNWtHlIw5UP97XMcL8MPa8VNJk3ohBMAZK29JSxA
 hqmyP7cEyLvhHautl3Ll/QnecnKFZ1nnmb6Y=
X-Received: by 2002:a05:622a:1e0d:b0:51c:7b11:41a8 with SMTP id
 d75a77b69052e-5213f959c7amr217732621cf.85.1784713676904; 
 Wed, 22 Jul 2026 02:47:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0d:b0:51c:7b11:41a8 with SMTP id
 d75a77b69052e-5213f959c7amr217732391cf.85.1784713676454; 
 Wed, 22 Jul 2026 02:47:56 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a967289sm55064875e9.11.2026.07.22.02.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 02:47:55 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 11:47:53 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/5] ufs: derive the per-region RPMB CID and size for
 OP-TEE
Message-ID: <amCRyXy9Us8VZK-2@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-4-jorge.ramirez@oss.qualcomm.com>
 <32a5043d-d44d-434f-b512-e869b81d10c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a5043d-d44d-434f-b512-e869b81d10c1@linaro.org>
X-Proofpoint-ORIG-GUID: xEZOoxQZPiNvgAfbB4T2bc85ecwj2WOE
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a6091ce cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2kKJMhpEJMGxI8Zohw4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xEZOoxQZPiNvgAfbB4T2bc85ecwj2WOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5MyBTYWx0ZWRfX4dhTz07UZh4F
 /3bWGy70HmgzYNI40sO7nCgC4/19QaZtrred/FBNxNu2b/zE43n0OXIHVqqU3PSt3idamfAAaAJ
 gGzUp2+vnIkqQQGTfrN+K102vOHJq2s0p4anckzhzK6vBnP06V4MJ99Vn3PNeDbvWq1M1hf3e2N
 VWthu6/10i/gifUmBLyoOTRMyaFaUpxpyKNYO4Qt2+Stccdl9YedZa1IJsd+Ql7TzNLCNVKEuS5
 pnXYFgZAGUNrlqitU1bmTAj76ShNPmIKzPpEoPqdoArh9Ed3a8gKJUhuxSsf70nwS7KtLbuoYLK
 GPva8+OJR02k14wGMrPLqGuhlJfrGSZFNY2FYI4JAUs1SnB/Idd+wHd9MX8TTYE1SALxSlouYj7
 41dV0udSEYIMbKYXBOYW87uLj5r2gpL3BnGx4tidchaU6mUORgCAsdh01T+2Z5etX3OnlXf6EKn
 EfNslFZwxZawZ9YQrKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5MyBTYWx0ZWRfX6NdElJsbWseh
 MX7dMhUpI7KTIMnLyvwxyOI/lAtN1mb+vMEF5RKhKe/CxShIVodiztXPWzACoRah8ScIe1iTUiT
 GfVtKt00xQ4JuP6NbCi6Ht3AzFZwLTA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220093
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5h6iV8i0u6Ctu//X2BToVLyY
 17hxCEJ9MlYZqrx56xo=; b=cMYqZzz3L/4+ByTWXsY4rMYvHAE4ZTdAdiRMsEYq
 3K9KnRCoTrOA1u03+1iDTQP1yeYVhLPh/jWg+S4KW7XjANhoMPzN4KEeG/OF5JBA
 VU0vZfXiUELFVEppC7oIBRhXfRnAWP+1Y3fWDOMiwBeKkM0u7rCzWL8WOGDA/Xgk
 KKt1DcRdrjsg7mCDw4Mk8ZYn79krEzzQqUMFP2oJsGbiuO8XcHFdZ24eYyleCtPr
 4xDNHKN0+4SsWSSakwO7HyRTEZfpbN7SxKpSRkVQPLOjZkaYL1PLP0TYuoxph2L0
 hWabE2zb1YVvojs4U6b/NKqlbF/cIwiYSEFuurprwxlDCQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784713677; x=1785318477; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5h6iV8i0u6Ctu//X2BToVLyY17hxCEJ9MlYZqrx56xo=;
 b=NGJTnSPCATOlb8wxCv+l1OIaM/nULHerhz1yglpNuHOj4xARD28R+Nu5Bk90UQ3HwY
 jaPNkBfiKEJF07o2kGAVgfGRY4Du9EuxAzbJ6iU3LMOziYbVm+jlkis3ZS+Ht3nH2Ndm
 OxVTM/+3ghmzcE3gzO/XpM/NSCk6vZiRtdDKeujAjfKFUsoRlyJMMKyW3EsO9IzEVc4T
 1bU/THb9WIuLmN7UrwounzHUWNbTdZrLg2OUJ2q9NAkYXyuKXG0Z3RmlRGFpcCHasjxS
 cPN/tRSb4SY6SnpJ+68sbOVwhz91hiSPZiSHZDjTdOXJEsjl2mNtYkT4ofntoIkuL4Xs
 MHZg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMYqZzz3; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NGJTnSPC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMYqZzz3";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="NGJTnSPC"; 
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
From: Jorge Ramirez via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 22/07/26 10:33:29, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > Read the UFS device, unit and geometry descriptors to report each RPMB
> > region's size and reliable-write count, and build a 16-byte CID by
> > BLAKE2b-hashing the same device-id string the Linux kernel derives
> > (ufshcd_create_device_id() plus a "-R<region>" suffix), so OP-TEE derives
> > an RPMB key that matches Linux. Exposed via ufs_rpmb_get_region_info().
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   drivers/ufs/ufs-rpmb.c   | 141 +++++++++++++++++++++++++++++++++++++++
> >   drivers/ufs/ufs-uclass.c |   4 +-
> >   drivers/ufs/ufs.h        |   2 +
> >   include/ufs.h            |   6 ++
> >   4 files changed, 151 insertions(+), 2 deletions(-)
> > 
> 
> <snip>
> 
> > diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> > index e320a6dcfbc..3a0bcd287ea 100644
> > --- a/drivers/ufs/ufs-uclass.c
> > +++ b/drivers/ufs/ufs-uclass.c
> > @@ -1801,8 +1801,8 @@ out:
> >   	return err;
> >   }
> > -static int ufs_get_device_desc(struct ufs_hba *hba,
> > -			       struct ufs_dev_desc *dev_desc)
> > +int ufs_get_device_desc(struct ufs_hba *hba,
> > +			struct ufs_dev_desc *dev_desc)
> 
> I still don't find where ufs_get_device_desc() is used.

you right, missed it. will fix in v3
