Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B994DC61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 04:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D583482B18;
	Wed, 11 Jun 2025 06:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="fB28rjNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083C882B20; Wed, 11 Jun 2025 06:47:42 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742D08004F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 06:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIPtGD028783;
 Wed, 11 Jun 2025 04:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Sqbgq7SeIGxT4cDMeSmPWmMS
 wJB/8LkVXRCzxUWHO6Q=; b=fB28rjNg8S5TC9hRc84CbYxOlmBNDTcfbdoGqSIN
 6wRz00aycZ1hV4L/IF178b0FqP1vwph7IKHe5L0K/k5RO0bHHdjUcWzzc6B6TTJa
 2ZL4tNBu3dvWa8FwXl1Ga4FwxJ8JtvWgtqrbgAnLChWul+h1Dxauc/mvZFWOhr1z
 HiPWUB5PBzzj7raDssKYlBb21HkweJu/YV883Iuyz3yWz4kLs4kkT+oC5WN0Pd6l
 9IpPLfIw8dtbDVGSqbzd+UUf46Dr9aaVKsFLIXxDWzlW5uS0YRzGITzKsvO/q4RA
 YBGhEprnh9Ii1S7CR9+l/DhfSAuGaiY9//mT7NJQ+WqvBg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476jrhancw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 04:47:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55B4lUkd031095
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 04:47:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Jun 2025 21:47:28 -0700
Date: Wed, 11 Jun 2025 10:17:24 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <trini@konsulko.com>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] board: qualcomm: Add MAINTAINERS entries for
 Dragonwing platforms
Message-ID: <20250611044724.thdcl3ke2dnicgqs@hu-varada-blr.qualcomm.com>
References: <20250610093732.2060702-1-aswin.murugan@oss.qualcomm.com>
 <18193912-d05c-4584-bf45-e9f2f97be7f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18193912-d05c-4584-bf45-e9f2f97be7f7@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=EovSrTcA c=1 sm=1 tr=0 ts=68490a63 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=6eiW-xrz1GzZlbkjhPwA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vTN2mMITAMzQQR3kb3y_9W5ukyA3xR8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA0MCBTYWx0ZWRfXzopksna9rsKD
 k1x1owI2xZOeIFRpA7bCLu664LdiebO6+MLGCoGxbkqHZ+LdWgLwFxA3aMIHJyQtvoOWwXhb067
 337mwz0XKSm25IXWIfAgq14B8p1oN19wr7mkQ4DfRfyxFTMfU6yvgUxyN/a4YDo0Kw7Qpw7szie
 h9ojegwk8sPapiLSTx8DOFyk4Umt1By2+cfFokTUCEEOuOT2MXCKfOCjZv1OLbqgsNyg5aX/jgJ
 /rqFDditUymhbKX3/+2jtsaUeGPCO4+Kg37jaZ4pXFSp8/+9CeBpdplDLYCixgUzgkwLylKRcSQ
 KLkGy2R3f+yfqQPnn5yEg7T6jGkH7IHaTpm4Nq7K7Agp6Qv2vBXQjahySwUMGDAwk4695u3e0i2
 l6Cv25O58I0JGeAcLPpwdEu4jF4FwPaqe5vFsYfZi4yM0kzDOq8h3OxLg9aiDzbPw9ZDwYuZ
X-Proofpoint-GUID: vTN2mMITAMzQQR3kb3y_9W5ukyA3xR8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=636
 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110040
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

On Tue, Jun 10, 2025 at 05:22:28PM +0200, Casey Connolly wrote:
>
>
> On 6/10/25 11:37, Aswin Murugan wrote:
> > Added MAINTAINERS entries for the Qualcomm Dragonwing platforms, following
> > the discussion in the referenced thread.
> > https://lore.kernel.org/u-boot/20250603192206.GK1382132@bill-the-cat/
> >
> > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>
> Balaji and Varadarajan can you send Acked-by tags for this?

Acked-by: Varadarajan Narayanan <quic_varada@quicinc.com>

> Kind regards,
>
> > ---
> >   board/qualcomm/MAINTAINERS | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >   create mode 100644 board/qualcomm/MAINTAINERS
> >
> > diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
> > new file mode 100644
> > index 00000000000..9196310f117
> > --- /dev/null
> > +++ b/board/qualcomm/MAINTAINERS
> > @@ -0,0 +1,14 @@
> > +QUALCOMM DRAGONWING QCS615
> > +M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > +S:	Maintained
> > +N:	qcs615
> > +
> > +QUALCOMM DRAGONWING QCS8300
> > +M:	Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > +S:	Maintained
> > +N:	qcs8300
> > +
> > +QUALCOMM DRAGONWING QCS9100
> > +M:	Varadarajan Narayanan <quic_varada@quicinc.com>
> > +S:	Maintained
> > +N:	qcs9100
> > \ No newline at end of file
>
> --
> Casey (she/they)
>
