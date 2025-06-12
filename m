Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FCEC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 10:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7086A82B7C;
	Thu, 12 Jun 2025 12:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="PdiVQsXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789A980050; Thu, 12 Jun 2025 12:09:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C587882BD9
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 12:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8JgGX029622;
 Thu, 12 Jun 2025 10:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6iD7uG6GngN5z7Jt3IMX45vx
 nvp/nECLP110K9KOMOo=; b=PdiVQsXSBURkdHmP/ovug6CauLv9Qmjkss4EB5ex
 GFAVIhRhHKfZH5xVeOplYQ2zY3v4sKlPAU/Z2OoKJICS3bQCr9EVt5hKv4VEiH/P
 f4OTPHljpQ0jv2p+OpoCDzNwyhfxHqmqDBE/iuQ/GxSWmQJSYlbnaY1Jgz/JbMV7
 g04dmc5BonJPpqyfYDwvwvwnvdd3Sk+zhfVXyFEPq8R5/5aHtJ0gLqbB5U9/1HZm
 tHxBSezaYbNqrAQDzoqbC7DFkoauWDo9Jzs/jhxBFCLqxnz4vCYuvOQP7P/1z2KM
 d6Ke22F+6HTj9bxoE2FqAGzoxGkvkaw7g84ywQZa+iXupw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn6g3md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 10:09:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CA9WuM002132
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 10:09:32 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 03:09:28 -0700
Date: Thu, 12 Jun 2025 15:39:24 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <ilias.apalodimas@linaro.org>, <clamor95@gmail.com>,
 <robert.marko@sartura.hr>, <me@samcday.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 0/3] Implement reset to EDL for qcs9100
Message-ID: <20250612100924.wlowchclk3u7uijd@hu-varada-blr.qualcomm.com>
References: <20250507070733.2871986-1-quic_varada@quicinc.com>
 <fb46de68-c969-433c-8f11-2dbc258afeb0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fb46de68-c969-433c-8f11-2dbc258afeb0@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA3OCBTYWx0ZWRfX5UqnQVUbI7TM
 fH3w3GENnl5/cBbUcFjH/qf2szN+aSLV+cQmIxA3YP1rnKPyeCT8vgfbhzXE6fL93DgnlRPXFff
 8ZKxkqrL3YaPydgKWiEMaR5xt1HHv1Xd/xJi65WLr4C0P2EOUU8nZvM9qEP5yKdG6F4olwhUOnM
 4NdjMHgSvZjt5zB5UL0u9BH4E2k+aj9ZovzyEg4WzsQKJ9EbBl7eY5L7oEpZWOybnpb7jJc22nL
 D2vBEUY9niSghkeklQqPMhIMWCwWih3Qy/IkMBKKC5PNUI8787+eTctqP/RtoqxBuCig0avAAyq
 w91sMYPwFSRYAoPKy13aeKQZ9EDI3A8ddb+sIdH82NwKy233aYhqGZbz2htVHZXGuatocWr58nt
 beDPGiygSKYl1lhxYY1N6msCZwHGIZHU0z7k6VQEpnYJVbFuDd5PBMrr37u0vA0P7Tjy15Zy
X-Proofpoint-GUID: SDWHJltRHtPVS9Zumw2Ymw5O-kWg_9AC
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=684aa75e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=3NsNaJW2YjrzmBb2qrIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: SDWHJltRHtPVS9Zumw2Ymw5O-kWg_9AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120078
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

On Wed, Jun 11, 2025 at 01:55:32PM +0200, Casey Connolly wrote:
> Hi Varadarajan,
>
> On 5/7/25 09:07, Varadarajan Narayanan wrote:
> > Using the 'reboot edl' command in Linux, the platform can reboot to the
> > Emergency Download mode. Implement the same for U-Boot.
> >
> > v3: * Introduce a sysreset op that will pass down the 'reset' command
> >        arguments to registered handlers
> >      * Handle 'reset to edl' alone in qcom-psci driver
> >
> > v2: * Rebased to recent sources
> >      * Dropped the first patch as it is not applicable anymore
> >      * Bind the new driver from psci driver
>
>
> Sorry for the late reply.
>
> This really needs some associated documentation, at least adding the edl arg
> to doc/usage/cmd/reset.rst and the help output in cmd/boot.c should describe
> the edl arg if CONFIG_SYSRESET_QCOM_PSCI is enabled.

ok.

>
> it also doesn't build?
>
> ../drivers/sysreset/sysreset-uclass.c: In function 'sysreset_walk_arg':
> ../drivers/sysreset/sysreset-uclass.c:93:63: error: passing argument 3 of
> 'sysreset_request_arg' from incompatible pointer type
> [-Wincompatible-pointer-types]
>    93 |                         ret = sysreset_request_arg(dev, argc, argv);
>       |                                                               ^~~~
>       |                                                               |
>       | char * const*
> ../drivers/sysreset/sysreset-uclass.c:35:69: note: expected 'const char **'
> but argument is of type 'char * const*'
>    35 | int sysreset_request_arg(struct udevice *dev, int argc, const char
> *argv[])

ok.

> ignoring that for a sec, I'm a bit worried still about how this behaves on
> boards that don't implement this psci call, on sdm845 for example we just
> hang.
>
> I think psci_system_reset2() should be adjusted to time out (though I can't
> imagine a psci implementation that would return execution to el1 during the
> reset, so maybe the timeout isn't even needed?) and return an error if the
> reset didn't happen.

Would checking if the system-reset2 function is implemented in PSCI and
handling appropriately similar to [1] be ok? Please let me know.

> Then qcom_psci_sysreset_request_arg() should print some useful error message
> ("reset2 not supported on this platform, reset to edl failed") and bubble up
> the error code to abort the reset entirely.

If the function is not implemented will print a message and bubble up
-EPROTONOSUPPORT.

1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/psci/psci.c#n554

Thanks
Varada
