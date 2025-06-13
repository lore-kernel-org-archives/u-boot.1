Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5C6C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 05:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F771828A2;
	Fri, 13 Jun 2025 07:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="obEnx53p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0757C82AA7; Fri, 13 Jun 2025 07:34:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDDB800C1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CGHdQu026034;
 Fri, 13 Jun 2025 05:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FApad76wJrYO/iR34CN/NCKD
 0ArvsZ0MeCPbEmaFzHA=; b=obEnx53poPFXZEK4y/wONiBCDFbzaMjm6Gf5jkD6
 BGkppxiZTSRJ4RPMIrB8KnBe0e1BNtLv0vivezUnYEcYPDfNKHzLTAAduPXocXej
 j7ahStQXMjRBSGAXQEznTAauyvxiQDPdZqa91dVfa/qf+Vb2DDC2KnFiVs1ZK7N/
 41CK2uab93RIO+EHgUUStUlP1rHmy4j7cSey9QNwjtLPB36FNG6fFbpf/xzW1Lqf
 0J81vcR9XpVbRecZDp6vzPKA45dgHpK5pXc8cwu3vi8D7rR6oQ6ikwz9qiEkSUdU
 sFRQXURIDM3MB1wy3KWvskexdVNcSYq8KGrKulUPBZpV9A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2ydhqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:33:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55D5XtLH028378
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:33:55 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 22:33:51 -0700
Date: Fri, 13 Jun 2025 11:03:48 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <ilias.apalodimas@linaro.org>, <clamor95@gmail.com>,
 <robert.marko@sartura.hr>, <me@samcday.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 0/3] Implement reset to EDL for qcs9100
Message-ID: <20250613053348.mtaugrwt5enyobla@hu-varada-blr.qualcomm.com>
References: <20250507070733.2871986-1-quic_varada@quicinc.com>
 <fb46de68-c969-433c-8f11-2dbc258afeb0@linaro.org>
 <20250612100924.wlowchclk3u7uijd@hu-varada-blr.qualcomm.com>
 <57061d19-294e-418e-b74a-4c3d6411b9a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57061d19-294e-418e-b74a-4c3d6411b9a7@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA0MCBTYWx0ZWRfX6tgKRYjtT2W2
 8abZj9Cv72TPUbmPN8dMbMNwkUVdk9C0zPQPOMjZupFqYUM8MYGl2let+oVrW18nsKp+yOFlsQY
 ENESQw+nyO+7oTlugjO2CCZlZvdgPHxtwaMw/tTUkpooNCIycfhh5nxqZHDMWaH1TlPCzp+SvFH
 3ZqdGlCGgZ6sbRtl+l04HVBTf5JZmoPwfUSJxTrm2rOOduAVwzEyWrqhDqhCItRdUFfVxONQogW
 t52sHmf2Lgk/H63vONXlyk5M65CnIo7EDufIrOf3loVuI6BCMtEhwD/LCh8D10IqLjDfOWtxaXB
 wJ2qDgaIYht7J8eZD0Tbp2HXtUF6U3/mN3DkDbdDHS+HCrcteROjmkpWBoGJ+x9MLJ6akO80p2I
 knUUqc8mBj95qjSyN7wAyFGrgAqPg/AEvXHrEJFOB8zkDpuEpuiUzBhHPn30B7Y2w8yjabee
X-Proofpoint-GUID: HAvScg5efH36rw13CLgSbRUPLT-V2cS_
X-Proofpoint-ORIG-GUID: HAvScg5efH36rw13CLgSbRUPLT-V2cS_
X-Authority-Analysis: v=2.4 cv=f+BIBPyM c=1 sm=1 tr=0 ts=684bb845 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=7l8Om-yzq88bIukuR4kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxlogscore=936 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130040
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

[ . . . ]

> > > ignoring that for a sec, I'm a bit worried still about how this behaves on
> > > boards that don't implement this psci call, on sdm845 for example we just
> > > hang.
> > >
> > > I think psci_system_reset2() should be adjusted to time out (though I can't
> > > imagine a psci implementation that would return execution to el1 during the
> > > reset, so maybe the timeout isn't even needed?) and return an error if the
> > > reset didn't happen.
> >
> > Would checking if the system-reset2 function is implemented in PSCI and
> > handling appropriately similar to [1] be ok? Please let me know.
> >
>
> Yeah that looks good.

Have posted v4. Can you please check on sdm845 and see if it returns to u-boot
without hanging.

> > > Then qcom_psci_sysreset_request_arg() should print some useful error message
> > > ("reset2 not supported on this platform, reset to edl failed") and bubble up
> > > the error code to abort the reset entirely.
> >
> > If the function is not implemented will print a message and bubble up
> > -EPROTONOSUPPORT.
>
> Makes sense. Thanks!>
> > 1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/psci/psci.c#n554

Thanks
Varada
