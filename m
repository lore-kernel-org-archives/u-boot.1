Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC16C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6EA80FC8;
	Wed, 26 Feb 2025 07:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="kQWZ/brC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84F68006D; Wed, 26 Feb 2025 07:50:19 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3035980FC8
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMYHto009609;
 Wed, 26 Feb 2025 06:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZivJEmQE2m4RM6TA/dv2gKGW
 W6wbEoBLpuEenU+Sk4U=; b=kQWZ/brCJxwuAOaUNTA9V+k2zS8lsarbMtraGmk5
 JXRTZ3LQzG/aBCnAzsNRgYJcOBGpPAcV4DU7Xu08likOXU8/uUigRRBheu/S3qku
 oKuQV148Rcjsdp7yqE33cXQ0oR0yGGfz5zaUqJOv0rGXUNCKRp+5K1olX5NSvYai
 KUFaWfZpsrpIAP+wzEGjuSNPMHIkSWjz2Ldo4CvasAqIFxVds5yPjIeOrafczUIp
 iSMEoOKD4XEtSQ72YB+4MFFLbKNOdKGqJaHrR85kOpLVBJ76b1r3ubIXqo5Nj+vu
 4aK1KEyVryr6XXM/rfL4oRer91XKbOWNQZmuNo+Y/Szbgg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prms0sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:50:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q6o1sf001299
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:50:01 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 22:49:56 -0800
Date: Wed, 26 Feb 2025 12:19:52 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <trini@konsulko.com>, <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>,
 <lukma@denx.de>, <seanga2@gmail.com>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <robert.marko@sartura.hr>,
 <luka.perkov@sartura.hr>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <pbrobinson@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH v5 3/7] clk/qcom: add initial clock driver for ipq9574
Message-ID: <Z765kFuoMAZiBJ8r@hu-varada-blr.qualcomm.com>
References: <20250225065303.342174-1-quic_varada@quicinc.com>
 <20250225065303.342174-4-quic_varada@quicinc.com>
 <a33d1a99-9e88-4fbb-bc16-290230b174bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a33d1a99-9e88-4fbb-bc16-290230b174bf@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: BOjRoCc3DXVxdFUPOzHIs33PSgGF_nEe
X-Proofpoint-ORIG-GUID: BOjRoCc3DXVxdFUPOzHIs33PSgGF_nEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=814
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502260053
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

On Tue, Feb 25, 2025 at 11:42:43AM +0000, Caleb Connolly wrote:

[ . . . ]

> > +static int ipq9574_enable(struct clk *clk)
> > +{
> > +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> > +
> > +	debug("%s: clk %s\n", __func__, ipq9574_clks[clk->id].name);
> > +
> > +	switch (clk->id) {
> > +	case GCC_BLSP1_UART3_APPS_CLK:
> > +		qcom_gate_clk_en(priv, GCC_BLSP1_UART3_APPS_CLK);
> > +		break;
> > +	case GCC_BLSP1_AHB_CLK:
> > +		qcom_gate_clk_en(priv, GCC_BLSP1_AHB_CLK);
> > +		break;
> > +	case GCC_SDCC1_AHB_CLK:
> > +		qcom_gate_clk_en(priv, GCC_SDCC1_AHB_CLK);
> > +		break;
> > +	case GCC_SDCC1_APPS_CLK:
> > +		qcom_gate_clk_en(priv, GCC_SDCC1_APPS_CLK);
> > +		break;
> > +	case GCC_SDCC1_ICE_CORE_CLK:
> > +		qcom_gate_clk_en(priv, GCC_SDCC1_ICE_CORE_CLK);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
>
> Last nitpick here, the reason I proposed using the gate_clk API is because
> it lets you drop this switch/case. Since you don't do any prep before
> enabling these clocks you can just call
>
> 	qcom_gate_clk_en(priv, clk->id);
>
> With that fixed
>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>
> Thanks for sticking with me on this.

Thanks for the feedback. Have fixed this and posted v6. Could you kindly
review the 4th patch [1] of the series too.

-Varada

1 - https://lore.kernel.org/u-boot/20250226064505.1178054-5-quic_varada@quicinc.com/

