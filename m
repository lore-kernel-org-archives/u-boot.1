Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AF0C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 08:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F0F82B17;
	Wed, 30 Apr 2025 10:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="KTc0wcg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7944082B20; Wed, 30 Apr 2025 10:58:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480018216C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLaLNa020901;
 Wed, 30 Apr 2025 08:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=toTrCBe8x+NlqSnXAP0oKJxS
 I6NW0671ejEmY6qhh5I=; b=KTc0wcg+/PfN5k50bf2NCx35bd4GCUhY89EZpRhc
 YCsCiEd5S3cR7jGMssApyKOQ+5nYCEf/ws6IF0qM/LNvFdMlJ1+4O1pk9SR+ZtkU
 +dKU6p5Zu2EF+mhYVHwsTpalovlX3Lc3b+Xqg5yk0NFtR08LwQKTpuXyEEERnbA8
 ezrNrWszVEjy+FoX6NcPLpjBgggPs/dlhSTf9Y6Jn1D/v9UnjPWmTIRlelFjdMyX
 l9jeXJhFnIzzVjaOM/XQEA3pO795on4IUU3qIBV8D+RUySEh68upi/6ZqfSxZ0Ea
 7dnauSutjbKREXxVHhc3jKA+B0NLfG9oUSxtqC9IO0OhQA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u1sfk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:57:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53U8vv1E018960
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:57:57 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Apr 2025 01:57:53 -0700
Date: Wed, 30 Apr 2025 14:27:49 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <sjg@chromium.org>, <ilias.apalodimas@linaro.org>,
 <sughosh.ganu@linaro.org>, <me@samcday.com>, <marex@denx.de>,
 <robert.marko@sartura.hr>, <seashell11234455@gmail.com>,
 <ycliang@andestech.com>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/3] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <20250430085749.cefqgv47rz55kzdp@hu-varada-blr.qualcomm.com>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-3-quic_varada@quicinc.com>
 <1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=G5AcE8k5 c=1 sm=1 tr=0 ts=6811e617 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10
 a=FKl2DLDx2b8VylL7zvwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MiBTYWx0ZWRfX0G1+0RDiPGtn
 N+qyOMbAq98lo3HQhOnUbkFzoF0p6i5Y9mam/dukE8jMKI0qoCv6XEbkbqY6stCpcqno1aK2ipE
 2oFqzvSrfs6LZTXGZl69FANotJmUwS1zeBH/8bPzfN3jkLKaVvl6bYQEhCV3pM07FIv1WnuOOkf
 ocSuMCes3gAAmx5ocoIJrfs/nt4aWvQ/OP/bYQwTh+Mr6d1Nq3L/9tLTt6p9qTSEmJXRqlB7N1s
 2gbo/yhK5efzv7wAoDYfyGS7qlNGrX8xZn6CbUkmXN9YEua+srC6ReODQMNZy+Tq6MX+nl6jVDy
 T/2qSc0YNIJXfra/0T+WnOZSMYmNOybGF2vfFReWewq3+eJq1s1R26sLmpx3+Uc56lVXhlVNbJJ
 GXmZULLWXhVFH0RWPUuKc2pOMyPcAEXq65MFxp0i3jB4AA6rq4UxhCYq8O+pg1axQ17zvb9t
X-Proofpoint-GUID: wq-fQGycldVynJ0ebDPJ0itVMtOE7PKP
X-Proofpoint-ORIG-GUID: wq-fQGycldVynJ0ebDPJ0itVMtOE7PKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=830
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300062
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

On Mon, Apr 28, 2025 at 04:22:47PM +0200, Casey Connolly wrote:
>
>
> On 4/10/25 14:02, Varadarajan Narayanan wrote:
> > Add SYSRESET_EDL to sysreset_t and handle the different SYSRESET_xxx
> > requests in sysreset_qcom-psci.c.
>
> To be honest, I'm not really excited about this. Copying the entire PSCI
> reset code and polluting the global sysreset reason enum with entirely
> platform specific symbols is not good practise.
>
> Additionally, while this specific EDL implementation works on your platform,
> it does not work on (for example) sdm845 and sm8250 which are platforms we
> still very much care about. I'm also not sure if it works on SC7280.
>
> I think this should be handled in an/the SCM driver like it is in Linux, not
> sure if Sam is working on that or if I can send a barebones version of the
> one I have in my tree. It will need to be based on the compatible string for
> the scm node in DT (and checking for the qcom,dload-mode property too I
> think).
>
> As I proposed before on IRC, I think it makes sense to pass the "reset"
> arguments into sysreset and allow the sysreset driver to implement a
> callback/handler for them, this way the "edl" argument makes it all the way
> to our platform-specific driver which can then call "psci_system_reset2()"
>
> I would implement this by adding a new op to sysreset_ops, something like
> .request_args, then have a second for loop which calls this, since we want
> any reset handler which /can/ parse the args to do so before we call the
> normal .request callback (otherwise some other handler might do a normal
> reset before we have parsed the arguments).
>
> For now I'm fine with this new sysreset-qcom.c driver being specific to
> qcs9100, but please include a comment that the psci reset2 call is only
> supported on some newer qualcomm platforms and that others can be supported
> via SCM.
>
> On that note, how does this new driver actually get bound? It doesn't have
> any compatible strings associated? Or am I missing something here... Please
> explain this.
>
> Otherwise, I'm looking forward to v2.

Sumit & Casey,

Have posted V2 addressing the comments. Please take a look.

Thanks
Varada

[ . . . ]
