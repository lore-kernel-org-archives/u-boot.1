Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABF0D68BE5
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 07:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA92483C2B;
	Thu, 18 Dec 2025 08:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MegasEVr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvSQVFjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C6783C54; Thu, 18 Dec 2025 08:04:16 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C8783C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YSwt527628
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UK4PMyoE/QKcnyTHVi8fszGH
 5LydjDyhlUxaByG6JyQ=; b=MegasEVrxxEtOGNtKEVT0MJbe8W7qpBQzLl0DWu5
 s0pQulEf6ktmCjFahzOILYwAKq8L7ustwUlz3J62lGbA3RgvXphYHYJZhBT/GiZ8
 4tSs9+SHEKcRVAfO35UtaMQF3o9Epn+BR4g4KynbNVrFY7skvvxRv0NTcJwPmky+
 6LRCTCf1i1EKPCPkVoYLg5hntGK6Tmo/cV5sxgcAR8/ynhCX1Q5o4GbL0i7mjEtR
 CiYf6APCp8RxgZ9XH5wYAbbZPizQZXiXVCYOWl4NFKbl1mjBs/jWHjKNjxPHyjfu
 Gta3SAVYsgHcOYCerMq3kcoIWvbiKG8apAtj/IBkyFa2eA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43mb1gu5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:04:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7ba9c366057so1100922b3a.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 23:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766041452; x=1766646252; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UK4PMyoE/QKcnyTHVi8fszGH5LydjDyhlUxaByG6JyQ=;
 b=GvSQVFjs7ttvt3QntV5kYwA/VxA6yeFyMRuN4yDfXdU+mEt6xaB3w+fVNTSMWL9Xpc
 bB/mV+70oynHYuqrKFGrSA7/QxwMi2vk1PwakkOmKerqqAUkPhDk1Sq191Nj/z/0zlVe
 /bKvL1JUKHaaoc5F87JaRn6y8NZz5RnzOxhjY9wH8k9LwpIhSzV6f+PU6Eg7tUpUIC+7
 IlK8imOy8buhPPp+Iqhy3UdjHSAhD69AY6XnSTZNV2Z3Bg7sL1hofLnK343MKCkliAjp
 7IBQBpGxGmdXo0lQ6lHI1aTckxNj5dIiAwntQQrZgwQQtssuEOpkWLhaMJ+G2UvuTVg4
 SoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766041452; x=1766646252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UK4PMyoE/QKcnyTHVi8fszGH5LydjDyhlUxaByG6JyQ=;
 b=CVUaNiToDqHOQ61BoaWT+6E5U2cOO++Fsi21Hz0Q9mKvOtxcwy2l/0Q+33dKTAK/KH
 vnjXTAGZc3R2yxfR+GvUPkuzmR2gnACnDHHT+3k6fSCgEAKMfvj31Qj/fUCWo9D1LyLl
 wJL1dZau4ZHxVmRr4Ci0f1+Q62aJ8AwREqYzTFP3HWHVhd2vx6K/wn8lr22XE05aUXz0
 Ah7dSCPF7zOdi4RB+LJ5Y7iP5S6QPmXufbrqQeMmGVUHT9olL7oWFbXylTCoYw8rbmAU
 vESKstcuqj6g/lITeWugSRt/nAv7u3FLLFpgDhgGwjJKvCgae7qk12aun1zD25hYvJ0y
 0Q9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSaI5wb4bOCccTSPZXvZ/AziDUR0TzWXKjhFq/wuoLL94PCdCYzKdK/paWAoNCe1Apg6I1P8o=@lists.denx.de
X-Gm-Message-State: AOJu0Yyo4uQlRcxWyW4M4cWkhv7vj52iutS7iq7rxl+TVUoBYte8q/sE
 YflCTzWCAxAkCs4/e529sIGiHxvEhc+HI95p44cURcbwL5Oo0Zt9TKXMj7d3KtihptMrlDAqdbO
 NTchSbm6tqyQKvO8pbcBVyq7MqKw2ifhg4CvodhslvC3Gnlx4c8CE7vZg
X-Gm-Gg: AY/fxX6eNgKxQpfKw+WZqxeEwm03yq6YScFAvZkL7qlWlF46pksDzGcP5Yz3Fom8Mr/
 cv6GQCVN9Kbcw+W277hr7Ov4R6zwthzpnK8hRViZslfsZTFkZFDFm2xDJXH8ySoULLU0rYx33CJ
 7zEwQ5G8k2NifQzMLsgQYXoKE6Tx0eClVkj3PllqJ3erQQXT/w/CtH5h6C26s6NkoMRxCFi6QDF
 DfekXr/iP7GDS1FbnAHwSF4PgYZVQQm8QlPZ9HvRoddGjOpLsIjrsOQ38XpOwFelyZcshq0vcIB
 j32kdXxtxBvaEDsNVoZdy8lOuSqvuIFnGwlowSNLPP4Ak6INk7GJ2J6m5ezbkPyfp9K1/msqbxV
 FCiQq4DEuA2SOCVkR9TxNmGdoAJ4x1pzyVr12E43YPT2jVFhgCU/IuTpqahk0YyqNArFyhqDpLi
 V6++nFNOQSkDUBF3N7IecipC7CE/aMImT/MF6tFuI=
X-Received: by 2002:a05:6a20:6a11:b0:34f:1623:2354 with SMTP id
 adf61e73a8af0-369af813597mr20355493637.42.1766041451699; 
 Wed, 17 Dec 2025 23:04:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd4fLonvA499g/j3pEQEyMJBVTNfJp771SO0OZLoqqhqSNBRUrVADyWUKyaYmp/AakQD+UpA==
X-Received: by 2002:a05:6a20:6a11:b0:34f:1623:2354 with SMTP id
 adf61e73a8af0-369af813597mr20355471637.42.1766041451197; 
 Wed, 17 Dec 2025 23:04:11 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d301e592csm1321470a12.28.2025.12.17.23.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 23:04:10 -0800 (PST)
Date: Thu, 18 Dec 2025 12:34:01 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 2/6] drivers: usb: dwc3: Add delay after core soft reset
Message-ID: <aUOnYY4A8j863h0J@hu-varada-blr.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
 <20251203110735.1959862-3-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203110735.1959862-3-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oFx8Or7WDRvCnCF30q7Sp9-FjICHxqSh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NiBTYWx0ZWRfX44XsSB6xAtSJ
 GjdwK/bilSD0o9bmYdYVfQqiTrblLw/6oJNJ0OtBslAI9N/calqjNA9Yk8ZrewW1zAjDajwyJ4S
 G3MkQythLNvlyddMhTv+7n9Wt/1wWWuBJCV7e8WiFq5fF+a92vM3iWDy2P3cbVi5lR/YV0pggWh
 i9TP/X3k21s8bvsNsrfZhBkE1pjxiloWBQLuC5gLUNAU/1EbxKbbvwDe/yHDPzvj9NI4mNSacDl
 NM8ZSp+Txe01Rozd61UrWFKPp8I/vY6TIFajhbM/zwAHoChttrcvwXV7hBmmKJvay47VXXzp8h0
 SFgFvOY8onH98drkQvlLgdiD6xWQfsccFwkwiV/DlsSXnRj4IWSkYcERWcNSW7WleFDlvverpW0
 cLtn4gNhK+8g6CZOeVrQzoGYX5NvZA==
X-Authority-Analysis: v=2.4 cv=NPHYOk6g c=1 sm=1 tr=0 ts=6943a76c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=unJKp1IeuXrvse4MWkAA:9
 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: oFx8Or7WDRvCnCF30q7Sp9-FjICHxqSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180056
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

On Wed, Dec 03, 2025 at 04:37:31PM +0530, Balaji Selvanathan wrote:
> Add a 100 ms delay after clearing the core soft reset bit to ensure
> the DWC3 controller has sufficient time to complete its reset
> sequence before subsequent register accesses.
>
> Without this delay, USB initialization can fail on some Qualcomm
> platforms, particularly when using super-speed capable PHYs like
> the QMP USB3-DP Combo PHY on SC7280/QCM6490.
>
> Taken from Linux commit f88359e1588b ("usb: dwc3: core: Do core softreset when switch mode")

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v2:
> - Gave correct commit id for linux implementation
> ---
>  drivers/usb/dwc3/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 847fa1f82c3..ff0bca0dd8e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>  	reg &= ~DWC3_GCTL_CORESOFTRESET;
>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>
> +	mdelay(100);
> +
>  	return 0;
>  }
>
> --
> 2.34.1
>
