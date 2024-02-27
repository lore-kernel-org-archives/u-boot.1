Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82641C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E5288002;
	Tue, 27 Feb 2024 17:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="BcYm0jHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E1488025; Tue, 27 Feb 2024 17:32:56 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA73287FFE
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41RDdgEQ030973; Tue, 27 Feb 2024 16:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=qcppdkim1; bh=883bEPBfcnoPBGSTRumX7
 4I7KwWW5VRfYM1CFbFSdhw=; b=BcYm0jHTywqzRp+2BwS3PRS+xmbAGHcKau5LV
 ed6KC583zy6sbOBhkf+V1D1TDrvvN1EbfCZYKpwZQiDPzQYoKOfXD4C0V6k05Jnq
 l2bbMMhpUynOPll5jA4R8OoCM53IFAWL7fURR2agYUquYqCKTXVl5Auitbj0KXIu
 2xwq/Js688lWB2i+7Ij+K8S5ryciwRaUd+HD7vtZxrPtyajgFKi3OKcweX7+2ZnK
 SHEtpypZJA5QbELGzyiQ57CSBpwPrZtvEbhJikNV0R2ILPsQjxDIFb99qrrT9MLe
 9P4l2VOHDdqixRSg5e/xNUanN7YKHcI+Do0wpZ1sOZWcpOGkA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6nrhu07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 16:32:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RGWZEf018542
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 16:32:35 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 08:32:30 -0800
Date: Tue, 27 Feb 2024 22:02:26 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, Jonas
 Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Mathieu Othacehe
 <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 01/10] mach-snapdragon: Add support for IPQ9574
Message-ID: <Zd4OmoPPzwL/+p+q@hu-varada-blr.qualcomm.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-2-quic_varada@quicinc.com>
 <CAC_iWjKLj396V03XU9Df-OFFd0MVMEkBEQCmdYQ=b+8UYsKGoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKLj396V03XU9Df-OFFd0MVMEkBEQCmdYQ=b+8UYsKGoQ@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: lhfi9Lz40Jv8XN9XMnbWfQB5J7mXcOvh
X-Proofpoint-ORIG-GUID: lhfi9Lz40Jv8XN9XMnbWfQB5J7mXcOvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=646 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270127
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

On Mon, Feb 26, 2024 at 12:20:27PM +0200, Ilias Apalodimas wrote:
> Hi,
>
> Please resend the patch with a proper description.

I had given the description here with the 'Cover-letter:' tag and
naively assumed it would be copied to cover letter. However,
patman moved it to cover letter and this became a blank commit.
Will fix it in the next spin.

> Also, can you cc me on the linker script patches as well?
> Why do you need a different linker script than the default?

Sure.


Thanks
Varada

> On Mon, 26 Feb 2024 at 12:09, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---

-- snip --
