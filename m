Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D577AC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6207684A3E;
	Wed,  8 Jul 2026 06:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FybyGwj/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GRBx+kBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E0D84A3C; Wed,  8 Jul 2026 06:40:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3BC80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842iPn1625089
 for <u-boot@lists.denx.de>; Wed, 8 Jul 2026 04:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fYUiEIokGgQJ+C9r0t4//D6m
 gKQtNIe67B3ORgFiSI4=; b=FybyGwj/LzmGHt7NrFUrM5RkCaw4vtwlpm7FZLW8
 28+v2roLOxLEjuPFxvFXHIdB0a24BsvXs15EDqRuzNnH1TecQUCn5NEfzNmlSS2j
 Vx3/gK6+SxQrUX1sD1nAqELN8/W/Y0FYVhEcaVrMYt1nwTBCFzgOxu2Im6IPAskA
 i7fV88/UCDazhTf6bxXNHPjL5gxPqHRPYJmO4Tccp7GleRJJ5GvpcTCbrlA/+pcz
 2B+2dRgTmudly/d0ePY3DCb2pFfdp0YZO3bnsO1/XbxfdElneVXIwVEo+77vWmo1
 b5nawZv3vZsd81rtdkUJJipXaas0MpoAQOK5gKMM3d3JBQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2mgn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 04:40:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so298017a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 21:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783485635; x=1784090435; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fYUiEIokGgQJ+C9r0t4//D6mgKQtNIe67B3ORgFiSI4=;
 b=GRBx+kBWa5qiORZWhwSeX7uXVlAUW1AUq5AnW9TXfpWrAAzRAjk0NM8+E8Az/IwgXm
 UbxR1LahJYYsxc2OzpNZG20Ea1ewyKoFjF5j56klH5GUzMnc0Xx+v7v8HMGHQc7sIARa
 p2Us2ZAJhU3kWwWrDTqOFioxMN1Zm6PbKrayi6ujFaWhAnEaRRHEJlctALuHrsydXTxH
 vQ2X995L+xO5wHShOda8KL/89XGfsm9l/fX/dyydg9RS3Op8d6GTyXsAzX7nKHOvlekQ
 dFMVkDj58SOUWuCXa38Lf3A4yZnU8iRyRY5qWiB8rxJDVQ6G2R9qQph9FN8f2puzPlch
 APJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783485635; x=1784090435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYUiEIokGgQJ+C9r0t4//D6mgKQtNIe67B3ORgFiSI4=;
 b=KVadu+InMf0Bw5ssvU8J412sv659zfOV3DAJ8vPgq/HaroRf1OhoDYSAmU/9cztcrR
 PI2p0hDj5fej2yjh5O2UCZ5vbRClkOg6k3cSSBy+szeTvtlPtR5FjmWeqHux5hg4y9Or
 w7kfOVO4/4W7pxHivIh2abEb/8M3NrEB0plqdmjLWdEjuoINlIhFOopQSgqvgbdO7WgG
 vHI219CI10TqsTrboYfolzexdPJT8WNdDm6/+50qzqq93lcP38/n7XAzlv4Po3pH4buN
 SBYZi/hy143OCsIqjAt7c/xBy+NO3Ca41/y/lPgjgleV4X5ngdm6i1IpoAIqNIZmAtuB
 +UsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMDqSK4ddqaDoKVbGeCkb/3HJTS0OYKvue+zeOh/n4XMYzsOkPRdlIdvgA/7hCh2BUvxu8WFw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy72VvsgAv5Zvkrr5J+dEcr82ESXwyQE0UZzEAKVi1zsvAz3li
 J7WE9fTICZ0JOkrTFdgKijF3SrUSNS4YVEpOqP1NWGDGoAgDGF3Ldbpq9EjD7zvU9UQDgQ67uX4
 ZlvA1J3PBvDFMSc+Ug7+CaHOWL7TJo2/3+cts9BbVAsKImhia8TXALNp8
X-Gm-Gg: AfdE7cm9ZZBCbfu2sOKOQrOF4hqP0dsg/kbTbEM8bKyqKYt0vHDFZ9flMVMtZm4ubyQ
 rS+XHq6ivClp6j9t6SOLt1HDIiovt7yu17f9kJNK1rMFYfc+lTr073vaCWk+ak37so/Nnz1RizR
 aKHdreI95sdxoyfI8fKg2JfwH0disZq+Px0ohur0HTuGxFyxLXszgFtiRh4ReYet2RR9izqxY7k
 r/1x4Id1RoC7tMMjb0ImEHSAuavoOgT/Uh5xpNio9C23bS/FyzQHgjY1VCu12dwyShhvrZpJzkV
 InvLwqHjUrGysFNUcsA7UYzLDVX6P3ULazKe2ETJAYBT3huuLf7/MvBXc4D6/6Q8ztaXGQ3ifYF
 hO4BCkH5s1J7jk2+uW/tgAKrKsFg6MmnsXalRsE4HgMIDyO6s00ibbyNmlzxTNrWmDJ3MD85SKz
 Cbkd7ZOyIDwFiK/eHNmez0QZHd3NdjxTyjADvHvSLt
X-Received: by 2002:a05:6300:2213:b0:3bf:96c6:78c3 with SMTP id
 adf61e73a8af0-3c0bce12e48mr820327637.8.1783485634678; 
 Tue, 07 Jul 2026 21:40:34 -0700 (PDT)
X-Received: by 2002:a05:6300:2213:b0:3bf:96c6:78c3 with SMTP id
 adf61e73a8af0-3c0bce12e48mr820293637.8.1783485634220; 
 Tue, 07 Jul 2026 21:40:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483941csm15993182eec.7.2026.07.07.21.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 21:40:33 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:10:27 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 1/2] serial: msm_geni: fix RX FIFO init with proper
 cancel sequence
Message-ID: <ak3Uu5bEAefmuONq@hu-varada-blr.qualcomm.com>
References: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
 <20260707-uart-v2-1-d38277b6c4ce@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-uart-v2-1-d38277b6c4ce@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0MCBTYWx0ZWRfX/+cvPp56yMAt
 cK6tZIRlY+YZk1kUfVlc91XezmUaHbeKUZGSUcU20NQ5spTAki2gQAaGApZ1lGJN1dbzEiK5zVk
 jNja6Ljr/3ZZ712lLhUcwmGOPUBBOX4uEEJvC/R10vRyOSmW7j92FLKu3EMErdL9w+424CxpV/d
 bl1Eq97ivIEGWC5NtLAomB2mAVBV1sQOkHmAL1mr1UfLTPirVJubyXc4gkBU+6RVCl5XRnEH+wp
 XUCuyd5+QMGiXYB5c8tEnBDOmFK0pXqbVbM3Mt5RxDM2JOGXfeh8TH6YKMeJ/gJ/KkbZgEvb0Kh
 63qUO/P+661pEYwOsxxV1OF3U5bIB/5TnUvrlFd9BYdTpbNVkauLCa4oRyKssjSUsnChdTParFW
 q75eGNEdkFNACn9UPEECqpi5cUJ/dI6Nvy6KQK98h5BHnmvynlEpeaQo35GiDbCO5lYSUP5po92
 pPIL74GSqRMzKoucGFA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4dd4c3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Es1j3wYSAS9TwxV7USkA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: AqhEZOr7A5Sze7Q5cm3IwxWK0g85e_ff
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0MCBTYWx0ZWRfX3H4dltFpv8Z6
 41xMX1p393yjdiCXld68Ma+hhdNGIkc9iyGgBeM2DJbQ8O+gnflIA2iHdjEzc+4eICmHS4xrNF1
 3dYTD9CPB8p2E3SqEOQke2DEHN23+c4=
X-Proofpoint-GUID: AqhEZOr7A5Sze7Q5cm3IwxWK0g85e_ff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080040
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

On Tue, Jul 07, 2026 at 03:22:42PM +0530, Balaji Selvanathan wrote:
> Replace the abort-only RX initialization with a proper stop sequence
> that matches the Linux driver approach. The new
> qcom_geni_serial_stop_rx_fifo function sends a CANCEL command instead
> of immediately aborting, waits for completion, drains any remaining
> FIFO data if S_RX_FIFO_LAST_EN is set, and only sends ABORT as a
> fallback if the secondary sequencer remains active after cancellation.
>
> Taken from 679aac5ead2f ("tty: serial: qcom_geni_serial: Fix RX cancel command failure")
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
