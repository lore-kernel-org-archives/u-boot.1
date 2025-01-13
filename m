Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A19E7719E
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 06:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A787180141;
	Mon, 13 Jan 2025 07:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="neh1aNhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F9A80141; Mon, 13 Jan 2025 07:39:08 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A9D8007D
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 07:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D5t1gG007147;
 Mon, 13 Jan 2025 06:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=b0K6Ee30mIUri6R60K9FW6J4
 sxm5ngdNMgiZTcz74Tc=; b=neh1aNhUqY1OQ49Ak223pl3hC6H9lIdudTVMHnI6
 6SaBFsyRMfChCqixz7pw6r6mL1XUVrJGzUok3Sj8AFYlsXBYQT3qDJe2wICYSghd
 NTuW6JCdDwaQZfxhjjIqFW6QhQdj+BBrX3oxPeH53JSm+nzcZ0fE42e/0FlF4BhT
 a2a/cGahvZNRngUpow7GkrohlLERL5M+7LTlvf6b8lKeWahYKoiUWCyjhsgfq1y/
 F1Mc3bynUFuvG7awEdW40IeHX4Z7q4kTSOgUc0rSq6Aw4mWsPz/mwRQXaq9HfuZN
 EtYwXqrGsVcMjtEaL1Ge7oU1o7JZcqsrkxErUXms3mXEfA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444w368368-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 06:38:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D6cuEl023049
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 06:38:56 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 22:38:53 -0800
Date: Mon, 13 Jan 2025 12:08:49 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Marek Vasut <marex@denx.de>
CC: <trini@konsulko.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] usb: dwc3: core: Fix timeout check
Message-ID: <Z4S0+YLNHJ1j4j+g@hu-varada-blr.qualcomm.com>
References: <20250110074306.3897847-1-quic_varada@quicinc.com>
 <7f7962fb-1772-418d-b06e-97ea33099ade@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f7962fb-1772-418d-b06e-97ea33099ade@denx.de>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: MMnMUoisVA3hstaLlHNepsgi8vDnb4Ux
X-Proofpoint-GUID: MMnMUoisVA3hstaLlHNepsgi8vDnb4Ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501130055
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

On Sun, Jan 12, 2025 at 09:48:41PM +0100, Marek Vasut wrote:
> On 1/10/25 8:43 AM, Varadarajan Narayanan wrote:
> > dwc3_core_init loops 'timeout' times to check if the IP block is out
> > of reset using 'while (timeout--)'. If there is some issue and
> > the block doesn't come out of reset, the loop will run till
> > 'timeout' becomes zero and the post decrement operator would set
> > timeout to 0xffffffff. Though the IP block is not out reset, the
> > subsequent if check 'if !timeout' would fail as timeout is not
> > equal to zero and the function proceeds with the initialization.
> >
> > Make this a pre decrement to address this.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Does the following patch work too ? It removes all the fragile open-coded
> polling
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a35b8c2f646..7e7017d4be7 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -29,6 +29,7 @@
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/bitfield.h>
> +#include <linux/iopoll.h>
>  #include <linux/math64.h>
>  #include <linux/time.h>
>
> @@ -587,7 +588,6 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
>   */
>  static int dwc3_core_init(struct dwc3 *dwc)
>  {
> -	unsigned long		timeout;
>  	u32			hwparams4 = dwc->hwparams.hwparams4;
>  	u32			reg;
>  	int			ret;
> @@ -610,17 +610,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	}
>
>  	/* issue device SoftReset too */
> -	timeout = 5000;
>  	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> -	while (timeout--) {
> -		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> -		if (!(reg & DWC3_DCTL_CSFTRST))
> -			break;
> -	};
> -
> -	if (!timeout) {
> +	ret = read_poll_timeout(dwc3_readl, reg,
> +				!(reg & DWC3_DCTL_CSFTRST),
> +				1, 5000, dwc->regs, DWC3_DCTL);
> +	if (ret) {
>  		dev_err(dwc->dev, "Reset Timed Out\n");
> -		ret = -ETIMEDOUT;
>  		goto err0;
>  	}

This worked too.

Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>

Thanks
Varada
