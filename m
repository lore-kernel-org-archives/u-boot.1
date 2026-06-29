Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1284CC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 14:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C84A84942;
	Mon, 29 Jun 2026 16:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MEqLNw18";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="La36crUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12958496E; Mon, 29 Jun 2026 16:13:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5673D84931
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKWA2656156
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dUga8FLbYV78xqDbYn23P9Wv
 0erfDLGGJ/EqoJTYXtI=; b=MEqLNw18FTGybgs6hr+DQmi803b+9BstuHt7dggb
 1+xRM+chSyt79VgBXbFvF0YeK+orvyP5JjMUUoJKnsPgXuU1PIVCPI8Vns9tx8a4
 8IlIxnE9MsFwuCdGzsb/vMeWEJMJvudIvHxXFmZG4+Y7RJEl0Zj5xQojd1CKfkVa
 cc94AVHstqA7V088D7kNHO0CapGBwocIjGHcWTZ8PsEQqJW1Dq2n071YOaeNmGTI
 gUd1xFuM3DixRtsJyZpjFzYufm8EPCOn2rd7CUTV64vMWtkA11Mo/XoneRne+nX3
 AvA0HpVXfZ9osW6repMOiI6e8nq01hX/HB94K9Iz8EEz6g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7h6g2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:13:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30cb5001ed8so3204591eec.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742386; x=1783347186; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dUga8FLbYV78xqDbYn23P9Wv0erfDLGGJ/EqoJTYXtI=;
 b=La36crUYn31JXIkBlKLBW2A1mFLfs2bfsdHo/SaNfHSYO2cV8wjVvJl8IeE8cUZoma
 ZLJYWJqdDZL6ebq/OJ8tnDv+sQTDwOGsTOIfX9KMdrddYBueJ9WwoBfU2uEguTIbVayy
 f5dlzbtHd0XBnWr3xjC99gpBK3Y2mNPFNzP++ce8ifvcVuTQwCxxFrAFxKLylXfZZsT0
 OtSe1HjNf2Zzs4Qmdj44ir7GblxdW6sliwn78rghyefrihH8f2Q+MQKV5rDzHUp+wo3L
 K495dqvQVwolXNQEVQA2qgcOXJSMvLVS+je3u+C3D4trTDKpreQTAYoDNa2O1WsWmhQu
 jpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742386; x=1783347186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUga8FLbYV78xqDbYn23P9Wv0erfDLGGJ/EqoJTYXtI=;
 b=fqWN6H+hKjioCIgtaOQqH7lCSoHSQmYmtTk4Sq/ZssqZkgxQTjKV63F3BXKtaGr0BU
 2dQDHhY7PcTp4JZS1flsfyypwWwFLZEqnPIks7uKAI8b5Y+rk5qcC9396JvqspoWO9zj
 OgOa+8TkeOk0dL1I6v1amJ7LTEHErJ4HHLhQnwPkrCXtb2jgd8XqX+G1PnZX3MHesfpi
 XRQyjnhCsQoUh2wpHhNbr7ycqZd8jIF+xB1gnmeZMnNheAAkne94tcxytriu1gErHHYN
 J3ePTn47Mbg93rQmzIhYjdSv5wUbsy2cUIvpVKmbX1BRBtvWWvSqXT/o5T3Rf1ixm09J
 uFOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2QpEQOAASxxa3uIYZmEW4W9DssdYkQIOvF8vKzWol6tHfnqRTF3lmPpJCsD9R0lTuDy2o/G4=@lists.denx.de
X-Gm-Message-State: AOJu0YzWou+vBQymfVEK190/jAUUXEGt+UzMNYFMtTrnjco6MZ+K9KbS
 hInAo1PLvzfAboJy7ooAO9SwIjNjMWgvDuCkTrALqvwrolrtn3yzmd/moaHHBaDXF2y9lA4X/An
 /rsYNM77ntXZHTAOssWFc58wtPSXWn4r/Sg94HJ7jSCZXhrpXKkUizDxu
X-Gm-Gg: AfdE7cnVfwuBXf7EqVTi7fufgngjkZkv/0tJ8qhPkhuYKq55+JWreYeoV4KJ7UhZfhS
 FxzKyb3rAIpeAHkbEX4lgQYpbBV8cDyRCO/BN4NVpmzul/IEtknFwkNT4dqiNlFI3NyIEY6Tjs4
 raZOsnxbwmi72NWOQDp5Or/P6o10uCjaaUvJpLZt/c8ConsnLrolzxeq4iisaa95GR518dhMFf8
 xg0AYvkRbdv1zuakNJ7MpVSlgzam4GnqjzrdG78RAonuCLw+YqibS2vvJPcqI7rVFvdRknOdwpQ
 IMfgkBwGstSRrUltztjKIvTU6SMfyEbb10zsM0X4FoR9Kmn1ts9cRbMuSXqMNwt85QfW+5gX73O
 kgMoHy13L9PcvxevqH/UJ6dXOIa/cfrpqUCcPz7g97i4XmwVnXPdU9OpxGN+N9FyVv+y03Fq6Se
 QBDcuekSfjqG7KwXo5bi09VuclaeuOc8VIrsXHUzlW
X-Received: by 2002:a05:7300:50f:b0:30c:3ce9:fed with SMTP id
 5a478bee46e88-30c84d75523mr16367607eec.23.1782742386363; 
 Mon, 29 Jun 2026 07:13:06 -0700 (PDT)
X-Received: by 2002:a05:7300:50f:b0:30c:3ce9:fed with SMTP id
 5a478bee46e88-30c84d75523mr16367579eec.23.1782742385837; 
 Mon, 29 Jun 2026 07:13:05 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ec79d4746sm14496096eec.13.2026.06.29.07.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:13:05 -0700 (PDT)
Date: Mon, 29 Jun 2026 19:42:59 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] serial: msm_geni: validate RX data with IRQ status
Message-ID: <akJ9a4aSo9Hk1HKJ@hu-varada-blr.qualcomm.com>
References: <20260629-uart-v1-1-cbc46fe1d7d3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-uart-v1-1-cbc46fe1d7d3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX+f9qEQr7fIgI
 UWrQmUq2hTSHJt3y13U3sQ9kzlmuoTZbIBiGv5ckfuLi+QBAPdPH0XnuWH1qezp+6ipchAiwU3g
 7OiIMCB432+dkO8EgrWu5gyHlzlqrAqRb256U10+7UknPRbJ9AzYhjTnrsiaeXNuYk6ybsAWC5G
 ao5cY014HKUHD5R22BYKN34iU2K4xBGoPFNG916FtINpl+rgMs+1br6pH1y+0/QIflYoANFgGAK
 WC4o34oCKQubn6S8UM9ilaYgpMpm9XLOi0cyAjVcjWCxaSIbPiXvs61IDW/mGB8wcZEUCx5ICuf
 cLBt4rmyQHYIHpTV0HTRvo2H1vlc5pHWlzBviUw5nWMXD5XUsuMmm7qYoDKtQQ4OKIHIGIji0gb
 7DjBg3XVMwh+lg+iY80apf6h+qiyaAP+X4gZslCMGJ+ouDj7sjvXTNYk2pJ3f2zs6rIv2gaFaSs
 wlvVu/TwYaX/moLnT/g==
X-Proofpoint-GUID: 6ojPHS1lX-5yrpQv73V_1mM5txddreGg
X-Proofpoint-ORIG-GUID: 6ojPHS1lX-5yrpQv73V_1mM5txddreGg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX5azKCArmJpr5
 4LBimlZbA/LsXFhtXOnnw/E2xfgN0EreQZJaY05wCwG+u5zji7lnY8tA6eVWaMGfD75bNDtrVqG
 a0zuEHxybeODOK+o9TNV2me+cPLxgV0=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a427d73 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XLs7tYeM7wNmqge5gkUA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

On Mon, Jun 29, 2026 at 05:01:17PM +0530, Balaji Selvanathan wrote:
> The GENI UART hardware can retain stale data in the RX FIFO.
> The msm_serial_pending() function was reporting this stale data as
> pending input, causing U-Boot to incorrectly assume a key press and
> stop at the CLI prompt instead of continuing the boot process.
>
> Add IRQ status validation to distinguish between legitimate received
> data and stale FIFO contents. Check the Secondary IRQ status register
> for RX watermark or last flags before reporting pending data. If the
> FIFO contains data but no valid IRQ flags are set, ignore it as stale.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/serial/serial_msm_geni.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 3dca581f68f..6d30f150966 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -424,13 +424,30 @@ static int msm_serial_getc(struct udevice *dev)
>  static int msm_serial_pending(struct udevice *dev, bool input)
>  {
>  	struct msm_serial_data *priv = dev_get_priv(dev);
> -
> -	if (input)
> -		return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
> -			   RX_FIFO_WC_MSK;
> -	else
> +	u32 rx_fifo_status, s_irq_status;
> +	int result;
> +
> +	if (input) {
> +		rx_fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
> +		result = rx_fifo_status & RX_FIFO_WC_MSK;
> +
> +		/*
> +		 * Validate RX data with IRQ status
> +		 * Only report pending data if valid RX IRQ indicators are set.
> +		 */
> +		if (result) {
> +			s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
> +
> +			if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))) {
> +				/* No valid RX IRQ, ignore stale data */
> +				return 0;
> +			}
> +		}
> +		return result;
> +	} else {
>  		return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
>  			   TX_FIFO_WC_MSK;
> +	}
>
>  	return 0;

It won't reach here...

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

>  }
>
> ---
> base-commit: 6902fb4c17faa375003124c451c2550deab5463d
> change-id: 20260629-uart-e07d893e4508
>
> Best regards,
> --
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
