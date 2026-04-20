Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C0AF36C40
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D38839D5;
	Mon, 20 Apr 2026 09:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHUvx1ad";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h9e+cLH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1924839D9; Mon, 20 Apr 2026 08:40:58 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625C2805D7
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 08:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JMUahd1341653
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+mwXPahJVRvaLgPjoQXORJxj
 69nMBv4KBmjQmrXmEIk=; b=WHUvx1ad/Y25JoXwRcEsjihdMYDaoE31PYrWEDKV
 PDH07lWIrt84qShpv/6BIAEFTkF4AQyj1rmU6RsJ1ZodJgeL/rxe7ZKd9VlK8GvU
 v3nPc2VYd0vTTFBNjTo2xn7emlOUeRXRQIQvK4sefl6LkJBFVIEhxEtWP+y89N+T
 Y5Vf9CnXANG+LuYClbavnKv95BGt85Q6SFyPoiWzj3vZ7+xFqkzJZeHONVgstbgd
 VzUjSJMIeknPuk8t9XJY4u+WQlyWGZtDFlffimDgXpUcgkxM0Rhjn9kt4p+e6ZkS
 D/kQL/yEB1/p8sM3sFALPLB/KkmYfB+b4gMBk3g25/O44A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm34hcbx1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:40:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76bb22a8ceso3070857a12.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 23:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776667254; x=1777272054; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+mwXPahJVRvaLgPjoQXORJxj69nMBv4KBmjQmrXmEIk=;
 b=h9e+cLH/U5q6Ab6o7OGbR14vlXeaJUip6vVPTGk9IZwzKTsZ8I07qo8T/rGFGat7e0
 6XqVgAkB9kyZc7tuAWUyImQX75Hc9V9kDNzAmAMd5HW4+QuhcpjV7Ru9kqvoLJd5BA23
 jUueNkNyhW5wL8RF0GQIbV5g0sDEuoGouXSAiVG/lBRQOdF0gvN0/i4JDDBPD3JBMA2S
 gqTklDKMydRP/ytTXe12Jm9K/wgbPtg+bYzR5ZViBHpkPdXc8wk79lWwG5IarNIdM1d2
 wEtDX9mYU8YejCM5r7H3cQsO1UQZTEskT7TopLNc6L0o+xjQKrKm9EIbWdlSwj5PDaJm
 vy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776667254; x=1777272054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mwXPahJVRvaLgPjoQXORJxj69nMBv4KBmjQmrXmEIk=;
 b=oxiB/xg9aNcc0gtyXD+q+Gem1bHaQqWx8eeMVAxTn+ch1Qse6QuqsdhW2HFLeZq3e/
 krSiovo5Mx+vTSo1H5L9N4kWBBgzCIi+PxM8KD5NlvmDWMGNFHDakS7dKeHJkQloiMpw
 PfhScXr0WDNrhFefZoL3eX7qLsP6SX6a4s39KW/i8jRtbA/T14SNaPV5LxZJU1I+gjWj
 T5kBFOvpytpekSUayFOCEf3mF3pHlszdrKA2OkF5JVYSrZOggJVMtQC1lB66cwA3PRCy
 sFKMtTp8RwGNa8So9wZRrrNYpiaKLN8CF8X42FFjJvpH+QSJNWQWpkzP9rqFVLt+PgwF
 vX/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kM6G000QUTYUGdE0YeiR1ztp4GX+MVPlITe6qd1cSmvvSlnv8tfyRecOURPL6g4QNK4BiS4I=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2/65FmaLNCZN/MBlwpKwkaD0/3m/MEDt2BqSYAYbq06p84V/e
 HQZijRrsMxD4eQGZVfneM/jEqDQfwePV0shBos2Hmj88RPFBUMAwzXNuIKyW5h8KSqxJ8bRJYxQ
 sXRomKU/y8iEoQjSkfEJ83Ru14r5dlseBTlSRMbiRYShI1czNQPf7l4L5
X-Gm-Gg: AeBDieuUoHszektpsFzhF2KTHir4pBmmA45xVvkc7KL9mLTwn1ZCSoy+u5CNbyhxR1e
 WhAoMVJYsYZNAdMP3qQ4a4n3AVdcyb1ABGI5y2s3iIYWpB/+p+syyEOnHtgVPwmzWErTKwVnafp
 fEKKDrosKCrPY9w/7svL0dL64QdCc4Wd9ptApN0bOldKZz7mrmMI/mUSI3bp08g3kZjAJvic4fO
 wjG33NdsS5ayiM9LKWPTGqT7eZlnOcMnUntq+oT2w9+WlzUSNTCX2CAMJCl0HTE3wxagzd18kSs
 /hnajPHPzdMpyqvUDjvGxJfo5uc3jXfqPvVLlLwmGTQPfv90+72sNf2nuKhiMXyd3+V701A3Tro
 xB3JU6zMhsEdRyfmk8YxmnVGZa1wHnpBDUR6tpOb3tyALhp+2tzn875Hrox2AWMqCLdmP8DYUc8
 90xUIJ6gZRm9gYhgbrxDrCh3dKUhOGl1PyM2cHWezTI11j7ftsSdMlbYG5lNTlfA==
X-Received: by 2002:a05:6a00:bb91:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82f8c902072mr12338412b3a.25.1776667253591; 
 Sun, 19 Apr 2026 23:40:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:bb91:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82f8c902072mr12338379b3a.25.1776667253112; 
 Sun, 19 Apr 2026 23:40:53 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe6642sm11893057b3a.45.2026.04.19.23.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 23:40:52 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:10:38 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 02/10] clk/qcom: add initial clock driver for ipq5210
Message-ID: <aeXKZvVE6ViBz0Az@hu-varada-blr.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTj=iQO73XC8+d83Um8sw-QPd0ceTDLN6zU53GDD8B3aSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTj=iQO73XC8+d83Um8sw-QPd0ceTDLN6zU53GDD8B3aSQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=J46aKgnS c=1 sm=1 tr=0 ts=69e5ca76 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=MWgSPYugQ9fGs0IJWzkA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 9dpVBPR99LoH-kS-716yM1mcjpnKYxJn
X-Proofpoint-ORIG-GUID: 9dpVBPR99LoH-kS-716yM1mcjpnKYxJn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA2MyBTYWx0ZWRfX1vT/c8wWMEM4
 xYaWtWopwRRs+9nYk56GcUJU2D1iIna9qs2mz027e795Bf0V2EVVHS56f298FtoJJKUDHk6pHqg
 ItFBwiLWhiyabroso9KGiEOeDdQo8Nn4L9avsp+w5/7SnvP93pvtW/rSOj/y0xWnfxxhsoGV92P
 zy/Sn0hUc5V30e82LCXvVeUKKHq7i/NBv+gZPUzaNyIUqGS/zjcN/TNk8nXOsVlzu7/nGa8tKMb
 gHclxxw4mbTfizUIWVcbtxSQO2MMniHAKNYTAP3xTTa1KliAcpcY73IwTvVl7XM7GBCy5y1L/FO
 uqdWwtGODBjhpX3LxgFxvNpuP9VU8VaZhhUfwuGWQkceoVyLCIAVX9Uoe65t8imljgnHyDpw5SP
 hJfMraggfUDPh2ZK5Po8vTINg7rCOY0edYkVP/gulsAoZMsoVmL6SPyHsxTC+/bueEt0c3jHodd
 tlMJ+KLfRrRLfWPYBdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200063
X-Mailman-Approved-At: Mon, 20 Apr 2026 09:45:05 +0200
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

On Fri, Apr 17, 2026 at 08:52:10AM +1200, Simon Glass wrote:
> Hi Varadarajan,
>
> On 2026-04-16T05:39:18, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > clk/qcom: add initial clock driver for ipq5210
> >
> > Add initial set of clocks and resets for enabling U-Boot on ipq5210
> > based RDP platforms.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> >
> > drivers/clk/qcom/Kconfig         |  8 ++++
> >  drivers/clk/qcom/Makefile        |  1 +
> >  drivers/clk/qcom/clock-ipq5210.c | 97 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 106 insertions(+)
>
> > +#include <dm/device-internal.h>
>
> Is this needed?

Will remove.

> > +static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
> > +{
> > +     struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> > +
> > +     switch (clk->id) {
> > +     case GCC_QUPV3_WRAP_SE1_CLK:
> > +             clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
>
> cbcr_reg is a bit confusing since that name suggests a CBCR register -
> see the ipq5424 driver which uses 'reg'. What do you think about using
> reg consistently, or maybe add a comment explaining this?

ipq5424 used GATE_CLK (defined in drivers/clk/qcom/clock-qcom.h).
That has been deprecated and ipq5210 uses GATE_CLK_POLLED. Hence
the difference.

> > +static int ipq5210_enable(struct clk *clk)
> > +{
> > +     struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> > +
> > +     if (priv->data->num_clks <= clk->id) {
> > +             debug("%s: unknown clk id %lu\n", __func__, clk->id);
> > +             return 0;
> > +     }
>
> Shouldn't the comparison be <  ?

No, this check is right. The clock id defines range from zero to the
highest_id. So num_clks will get set to highest_id + 1. So a clock id of
highest_id + 1 is invalid.

> Also, should return an error, not 0.

Ok.

> > +     qcom_gate_clk_en(priv, clk->id);
> > +
> > +     return 0;
>
> Should return any error from qcom_gate_clk_en()

Ok.

Thanks
Varada
