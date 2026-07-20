Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0BFC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 05:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14FF582991;
	Mon, 20 Jul 2026 07:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iSadSG0p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gd7pOKM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6220483E76; Mon, 20 Jul 2026 07:36:41 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A5980517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 07:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNumbf853166
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 05:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Z7jEZDLd8erVz5BWEld3D3Ks
 oxmYkOu/rp2twG8w2Qg=; b=iSadSG0paj5vOIn7GpoJi4fqdZM7t6chI/PJeaIh
 cVpxuRH5nT789Q94Fez0K+6bBuPorhvInyUt52jAWFqXQNHkPhdBkHehWvq4ulGJ
 BKxjP9LFDdsOaTJwsGnvW+WHNKMuCIsHXqPo0561IKOkSE6hUv0UAMjbviOrmZ/M
 KOlvCWVnpI/QlPaRF5YnnpOiK32EOpVEKsof5TGogqGrB8ET48o/TmB0Ygp/SFCE
 ZCqx7a3sU/iQpprLrbzbPk2W1FkZm6vAjjXQCX7qWKB8ufY9UGcvk2gz0C1TsI77
 l8FRPpM7RYObZ3qb6QSt/5hRiS6PRhqZ+Mq2P1KmGkaZJg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc4hpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 05:36:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so6903198a12.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784525796; x=1785130596; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z7jEZDLd8erVz5BWEld3D3KsoxmYkOu/rp2twG8w2Qg=;
 b=Gd7pOKM0kdLwFD+Ao5VKlwfgSUJ5w9tLiOAde3zh3n/nUEHfjhKn7BQ5rWcvdDF17e
 xv+xfNlyje47O+kH2RNcqUSmjBH2azZQFEYXxr1XXVTqsGXQG7Czfig8sE1JQcxow1YY
 QXkbkyThNg4YfecONn+uO6VWWFRk+yc3eLXawDy80UX/ws2xPhA+J2/v4jzlVqDDBvy3
 55w0BuqeP9VlyFqF7KXT16oygfwaAK9AoB3T7B77b7NytzFIczWz7zYIIfLbhpwtwMNQ
 Fb2UCOjYcYie/+emNTwQ0N1IerloJb5nU5IY5a8eEvj579ChlcTG0/cr74+KFt3lkCqi
 QmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784525796; x=1785130596;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z7jEZDLd8erVz5BWEld3D3KsoxmYkOu/rp2twG8w2Qg=;
 b=LHUHwl3xHMjHPPqmsO9zxZonUCl7PicUulzkuU39tAfyU+mG56bQ8xc6dKSrVnFLfq
 paAPJEr6UdgpcTz63tjrOLgkErWupZg30d027aPlUrZpLXQ+GJMnrYxHc3G1xkte/X26
 jZBFXw7nuGz357co3OscPQbK2MuZhN+8Q59skrO6hHohYmTFUNZw6amKNF9ah8R7Fksc
 71HEQ3I3CVrnOgC9fx8Y4adCk3XLj4Punej5f6i/vylGPBGKdeUw7CIr1FxtZQPMth3W
 ZhWTk6I8QN1paIBOLIUuUQ++fXfMNpPGcBHXL1aorGSSezkV9ecPxUIP/BpqFYnuJKoZ
 WR4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTQ3VqBdkQVjwfyuQduCTpgAzgXqjLm9Bb2+cUkLdrY8fkDQ+bvQs40mik1NoS6xkNqSfaogc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywfiq1T7Qeafex/fS0LoCm5NNAzMezoiA1pYySLDP+0sSVnSIeT
 SqVvBD+NG6IHiFP/0zCHMHmfBmfKnhPBHXhaAZ+L8mRMeviV8J0Bm0xGWBjlJwHwclPeatV6lgI
 +GyA1/L5adRO+021XhJmHM80CuismTjAnnMJKvhO1ds0vUMPK+jWkUCl/
X-Gm-Gg: AfdE7cnHveQV1zz1MxvmSzXuXX/0WJf+cbjsCJAK3hmm3iODHh9NUMKb2Q03faJyNVw
 nB6UJ+DYV9GgRzo3uC1xkmmLDJk9T10tSsCCUD6C59N8D3zB7e8avtmcew6w2cnuxg7Zn1BmU6Z
 EyCdolny9KhqbSIBGf9PWFwUVomMHIlC0e13iuGZT/q7BZkcuNgOwgOM8v+dU2RLmKQhjHEPbUF
 fe/iKmZ2TWIwXz8qvo1+WYSzUvzMB4ABIyEN9X7edmrC2vsHt2y4o1VH7E+uFHXyslgjivGY/bT
 A/mrQuwR3YYV1RPTy9Oeb/qAcq0iHbac3QGqGHJIJ8In34xKrcC4yCOZ2W0py61Q9WLsei9FMB2
 jDNW4grQnIfTvJapbc9gji0cjQiZ7vGPh/qi6O+lTdhT4BN3TpcsY9xP7FMp7zOUZI/fn1WLMTh
 uOuxKFPOlaceLlk3/xwOc2htCCbk8VgQ==
X-Received: by 2002:a05:6a20:ae2f:b0:3bf:b68f:4685 with SMTP id
 adf61e73a8af0-3c3ad7aa9efmr14063911637.23.1784525796546; 
 Sun, 19 Jul 2026 22:36:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:ae2f:b0:3bf:b68f:4685 with SMTP id
 adf61e73a8af0-3c3ad7aa9efmr14063882637.23.1784525796024; 
 Sun, 19 Jul 2026 22:36:36 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fdbd45sm32112360eec.12.2026.07.19.22.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 22:36:35 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:06:27 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: Re: [PATCH v2] misc: qcom_geni: Add minicore support
Message-ID: <al2z20ZrVAVl/RB9@hu-varada-blr.qualcomm.com>
References: <20260716-minicore-v2-1-160af559b273@oss.qualcomm.com>
 <178428299564.1171703.15456210253429165016.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178428299564.1171703.15456210253429165016.b4-review@b4>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfX2eEGR5OcrtDx
 gMHOjcICf4ULWP99fxuP9jsYxAvTdngcYG6L8g/iJat/iCBxg6BtWg/Dblz8AlMffchVRmabN3J
 VhhAyusnnGSEbuGEC8IJUjdpZ068RWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfX6BGRZpDnuFNJ
 3jG8gVAJKfgJHpvFNUpQMekF2I6upTZyNL3NEeGQ3Z/W4D7tf6JHjio+kOZHl4+y594OYlIqTrw
 70+UPIMmvHNHX9apD22gu2a8IAuJx0w3XCxbklpelkqHld8YDe+J2uCEN6gDTbEF7A8w7RhY4iq
 HuANDBM+NcZWZCvkTspccBZW1TQpkIBkHNiKtzIhTal2a08MEn1NwJFV08yXylGj9VBX95YqPYn
 XxD3eCtGwGZbz3QbtSqBdZ7GrgfYLcM2LGSU39xFmSAzvtYi6KMHdwweKMABo+zpbxYRIRYHQOB
 q9SAAOrmQ2T0B3EPFrc5G6eHVk+V+iASA/FDqChw9K0V5rD84sqdA2WrAMIbgZK7TOKvfo06wuf
 GeMHqsi6/MVne0RRpbrACC7VjAUhZhwv+jeCRoXPFKAx3fnX13W0u9nT0UQ7BKYYTDU5hWGZSz8
 aL0MKRbJFYLJQTrg6cQ==
X-Proofpoint-ORIG-GUID: D2rIaSBkf4hUNOp-2a6mOTYCgSnX5-pd
X-Proofpoint-GUID: D2rIaSBkf4hUNOp-2a6mOTYCgSnX5-pd
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5db3e5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=OkA5tPPiBfA5EVN0eloA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200060
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

On Fri, Jul 17, 2026 at 03:39:55PM +0530, Neha Malcom Francis wrote:
> On Thu, 16 Jul 2026 14:15:51 +0530, Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> > index a62ae6a2478..f3133f85885 100644
> > --- a/drivers/misc/qcom_geni.c
> > +++ b/drivers/misc/qcom_geni.c
> > @@ -414,6 +468,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
> >
> >  		if (proto == GENI_SE_INVALID_PROTO)
> >  			plat->need_firmware_load = true;
> > +
> > +		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
> > +			plat->is_mini_core = true;
>
> Add IS_ENABLED(CONFIG_QCOM_GENI_MINICORE) to prevent accidental NULL
> dereferencing in case CONFIG not set.

Not sure if I'm missing something. If plat was NULL, it would have crashed
while doing 'plat->need_firmware_load = false' towards the beginning of the
function itself.

> > diff --git a/include/soc/qcom/minicore.h b/include/soc/qcom/minicore.h
> > new file mode 100644
> > index 00000000000..9f2071ed86b
> > --- /dev/null
> > +++ b/include/soc/qcom/minicore.h
> > @@ -0,0 +1,25 @@
> > [ ... skip 16 lines ... ]
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
> > +extern struct qup_mini_core_info qup_mini_cores[];
> > +#else
> > +struct qup_mini_core_info *qup_mini_cores;
>
> else #define qup_mini_cores NULL

Ok.

> > diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
> > index a67a93c72a4..df8a615b46b 100644
> > --- a/include/soc/qcom/qup-fw-load.h
> > +++ b/include/soc/qcom/qup-fw-load.h
> > @@ -14,6 +14,7 @@
> >  #define GENI_INIT_CFG_REVISION		0x0
> >  #define GENI_S_INIT_CFG_REVISION	0x4
> >  #define GENI_FORCE_DEFAULT_REG		0x20
> > +#define GENI_OUTPUT_CTRL		0x24
>
> Redefinition from geni-se.h ?

Will remove.

Thanks
Varada
