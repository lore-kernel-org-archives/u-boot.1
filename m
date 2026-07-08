Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0CCC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE01838D7;
	Wed,  8 Jul 2026 06:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQtmapG/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fo4YAIl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10FFF84A48; Wed,  8 Jul 2026 06:39:52 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1F1080087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842dfJ1573678
 for <u-boot@lists.denx.de>; Wed, 8 Jul 2026 04:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mHvUme4p4jqPalF0F16Wxxdo
 Tex1yWoI6Cwn1ZSnViI=; b=EQtmapG/6nbTHiHOERBtd1tcBIGwqIeDVRRbMOrV
 ag3n510PA6xmUPRgogmaYXe+Tm6FFjyWtDsv+X3WASyeffRiYkAZho01b070Qnkm
 cVJFlXA9jdWo/XLN/ZjdaMyaaxv0q/Mnah8NPuj/Hs4hjvR4urOct7eEcp56XNOF
 7ZyvyB2qzpUCpM688r00h94me1HZ+wlfeG3Z+YC3G34NY+OXiZZaRPZbbJGmktE3
 goANGzzjmXlLZV1LIcYjSDGacuj+MeFo4Lr97YGoh1+Do2pBS/1PCeupPuzJZCrc
 JlYbzvJNvQRs43Tp5AdOtrSRYig41CdvJc4Meow0RSK3yQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hgsbaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 04:39:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so259920a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783485587; x=1784090387; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mHvUme4p4jqPalF0F16WxxdoTex1yWoI6Cwn1ZSnViI=;
 b=fo4YAIl7XOG7NIPTunmXbMSMlCK9SG5A/zPMA4iUQ5Tae/moJMx5SwJkyZXLZ1WWsj
 4cEuZlbao7iV5CaIQ6ibJTRJa2xPxWfzr7owNiYgQVSLMl2FqKaHjl9hQDHA2g4G9MWo
 7J916mZ3t45Cdj4MpIlY6LhvSBwK6bqrTMMvYnWXJAXYQo3vne/Tx56Be5e1HbjfFDIM
 dojLcOkrFjwoH/nEGHSzxjLXGwhAhckNQlw/cVU5IbhERyHjtZTbMjtWKoX1bTiozdPo
 0EHjV8eewMqeZIZhY36/tAsGpLSlr8gs7XGVjWMzKwJUvzyJhZlQ2Z0fUd9VT7pnpkvv
 uwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783485587; x=1784090387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHvUme4p4jqPalF0F16WxxdoTex1yWoI6Cwn1ZSnViI=;
 b=Ofe81KUGqGMdHjZngqQOciDyvQNxxNNb/2M8eiPibC01T8ZqrsNunV4l5EM72uLkdO
 KidwWQfKRDjfKGhjwCQYDKxw9O8vcztbh3xRZZUmZGywpzAqEwlasQ8eZp+VcTfIKl2e
 vlpfA2avEN9u39uuENPYacUE9NJZGtOmM6l82QfM9dJW4KmhdB2/65E5yiDkn0z3305I
 hCV9FYQd+ZPZyohN5DlmkKOhs/Mzl4mbd+oJO7P4nElGrISKOkf642uYmWAHRQuX4J1+
 TJK0ek32yPnf0Ulr3R3uU86CBMg7Kj27W1V3e918Pmqw6pWKA9h57ZghdS8Y5uGIJorG
 tkTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJNc7j0aWLzFLZwM9wz6A0pTRjviaBxwxZ6HZJfqc1xygP1lyihbUV7bAXd8SYCOePbeKY4qM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzjz88Gy3VWKae6t+NNcw+N3sards1j7AjkGdAakmTQS7GPQ4C0
 MsrhzJ+tCWHMJvbFGt52SfFvFa1G08AF2htMs/DwlRd1e7rM+qAT/F8exDM/rN1Bkw9gaeJtsfC
 VkQciw1esmPMJXfAKqXAveS3co1t3buIgcJNHv/2QVuTb6RD/gaHsxfzc
X-Gm-Gg: AfdE7cm09IOUJ7NWq+pFj1fvVEcykIVFrREn0Q4wtW6a30mNzm7pVOH+2SGW01e7Wpl
 IP/+ProdqbEn6yHpcwMj1bo9kMhHv6VtoJqMx0ZssvgbHziD9UelpJ13Ww3N05lpwsKqoviAWPL
 O0aKoNP10OCdWri9hJTRPAXU0ksCRXOpbnrmdzPYoRGZwXLzGtKVi7DOLro6NxpMdayB13xd9Ft
 MAV6WG3qhlgbehrbyBSyJ7+vsCSbShZB1bhgv/xBAJyFHjYzC02JiNnHtBqorzpLzKpLdzSScsW
 FUUij/D7qjF6/e/jE8lsF/nNzsisC9rC3cT49vWUvLZtIuf+KjVUINFX9ntjHcDcg3FKZorWU4X
 RJZ8/FXwhPe2gInFxAUJWvo0IzkzD2BsJnP9tyqbP50BFbA3nH3qbcS74oiLMvnmKaqaDrjVDGK
 6IshhJ6AF7F/FC4id5idsZrtafHaNpWSlvOlLGlnsl
X-Received: by 2002:a05:6300:197:b0:3c0:9c19:6595 with SMTP id
 adf61e73a8af0-3c0bd1a1e25mr831182637.61.1783485587239; 
 Tue, 07 Jul 2026 21:39:47 -0700 (PDT)
X-Received: by 2002:a05:6300:197:b0:3c0:9c19:6595 with SMTP id
 adf61e73a8af0-3c0bd1a1e25mr831160637.61.1783485586837; 
 Tue, 07 Jul 2026 21:39:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a583bcsm16779230eec.19.2026.07.07.21.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 21:39:46 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:09:40 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 2/2] serial: msm_geni: validate RX FIFO data with IRQ
 status flags
Message-ID: <ak3UjJtHudGWo4qS@hu-varada-blr.qualcomm.com>
References: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
 <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
X-Proofpoint-GUID: MB7keOIlRtjx1nhwpG6NgUHh__yVgAaY
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4dd494 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Tjxo_5PCSijSfI-gPKQA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: MB7keOIlRtjx1nhwpG6NgUHh__yVgAaY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0MCBTYWx0ZWRfX/+8sJhX4S32Y
 EZ8cBlKbO+yZAwaA103hRkaSLK1S8rKMhPVCIjiDNd1RHed4AK2SEu+g8NMjtQzEof2Xai3BQgj
 C9dsoveecucqczi0TeWNGSoqscgCQ5k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0MCBTYWx0ZWRfX6faw5Q0E6Jam
 0EiMDSPOCg2HD/jw6wrptUmOzHYqQL4DWNFfznbR9YwIx2ZuhCozMx8NCdFt/0Yl83bZe9BGh5o
 D0NwMuuJENzonGTVcxCb9ya4MhXrGFCOJbhtcGndt3qp+lrroCUbpzQopT63np42lsUVgsPjz5b
 3tOFWrg2kk8ESRDOgC4RwV+VnALLx4KfpVkqk3en/J/Yk+wOkDqkhQOnfjIL//i5g7EE2DcE5BW
 BkL8dbavPI4FLOJ6YH9gtEctu/U4JJNLbB9+xDFCDt7HEuRyh2sEo0Iu3Npi1XIIMcaVSWf2KDM
 BhEMiXBWHTufCxzMEyWgJUCbOwZVIXpnRFhJoXYa8WZF79Y674ZRd2ZyGQGOmSqcSMCBD32//4t
 J6z6zSIzwtCu/viF17z7OzDT9CkVzTbwLPEy8B6y0ki1hLjl4LQylXd/Jyxm/yohO9QTHpEb9Ir
 rcBBBgZsJx0I3YF5e3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080040
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

On Tue, Jul 07, 2026 at 03:22:43PM +0530, Balaji Selvanathan wrote:
> Add IRQ status validation to distinguish legitimate UART data from
> electrical noise in the RX FIFO.
>
> When the UART cable is disconnected, the floating RX line can pick up
> noise that the GENI hardware interprets as valid data and places in
> the FIFO. So, check the RX IRQ status register for RX watermark or last
> flags before reporting pending data.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

