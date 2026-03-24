Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1280E9A75A
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4586E80077;
	Tue, 24 Mar 2026 11:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYNdIeFf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DQt57HJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3524E82A9E; Tue, 24 Mar 2026 11:06:51 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C7B80050
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O8xgTm2322865
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Ca+Iu7ocGDElKFxhjDkdM2wY
 pC7exP+3VKYd1k1eC7o=; b=FYNdIeFfcgHg3Xc7NxQnedlGF9SvZc0pfg8uZwmV
 rkaRW/sgX/NqCEOPqUGkqxIo6ZjlIrWs+wohtpUV1ffcshf1BLssZPetVWGj//VU
 PAgxWNlbdoTNQkZSWtY4Hiw374YN5VKh5DzqvwXALjS4gt1e0YW6zhWtSaEyYZdM
 h+Lz7msWT/GktvBCvM69mYI7SNupp//5U3fL2PN1EqAz3W+cOhNyJ/3XL3ASl63O
 aInPOLCEZ1aB+XpCsEsJhbJfx9D7oG0lamgB2wLkpIubrY5gP16rjYGq2YovMcWw
 Gt5mtcQ4ALgJU8ZpX+uCfUoXf0JiptJgacn5vhyKFhFczA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qker9dj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:06:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35b901d542bso3020033a91.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774346806; x=1774951606; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ca+Iu7ocGDElKFxhjDkdM2wYpC7exP+3VKYd1k1eC7o=;
 b=DQt57HJSL3BQ3VkqBOTyJZCRDRO9cmNWZdVFNieWYWPH9bDcWgpmghd4MqS81qJkP3
 5no83A4XzHBhXfbVApo6CcgiaNl2aLx/Wmd1ISjO7uxOKHeYbMBCQETI9jrDoQPlOkyQ
 rK9l3TxszNeABkp6d0m3NFOwvq8kkYk0tw+954JdeV0nC+Wn+lCJtSKVHZXAnfXJayof
 x7XprH4mkH8uy7uGNVpyQz7Ft+1VQ1i4ppR6hM72lW4oRMDdjnITXZf10NumrFat1Arp
 Zn7MkO0M+RuY+9FnZJOkxcIHEliOrZ9yd5nwU5181qgtyP5oJi0g/0jiwNUI+PKL06nz
 w9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346806; x=1774951606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ca+Iu7ocGDElKFxhjDkdM2wYpC7exP+3VKYd1k1eC7o=;
 b=idTh4OXQIroukZJo4AXNohcUmA4hKef2DbLqryncXU3krlSVvFpcauGfj12zcXICc0
 TRgg7TZ3xoQGuzCJIrWKfeSRv6IyzR5KLNM0rfWM6emyC6Omsup4ysgAow/kritN/MVQ
 Pzng7Ml4r6tpc7Rml0q6wZVjUbNYrAFJDi/Z8rz9VGQqST+m1LPEJzXU3yv9aYfwxa0B
 ilzYzyoBvvGF/YpdqeJIP8oiJxZYVRVyWoJaqeGKEUHO0GHln4Q2wH1AnzOULEKWpDIC
 gjTyyCodq8tyPmVKeUHIUlVlslZHak3NXsuEbmwqSs9oNJlL+itCvyfNnei9fbGKfpBr
 Fk/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8gfHkIKTLYBQTZlcwqBpsYSaven3ToxYwrAdcxqC1wCZ2lKwcGzLJpKq+97H+EdGvb+M5JpI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywcyf/+B87aia6jcI2XBVXEbaht1JOW7+5rQPvJfudS4rCrPxk4
 Z2sD/X7Gs4BInLS757qa3lxiQe1teyVcrL7nSWhUv83zMOjiiSdBGGazz0XX9TK1HWMQpzh0Qle
 lbDDp62KWl8sAhQYQXU3G+eFrmV4TIJoUNqrlsQoGoe9TEYD/FajzFXTk
X-Gm-Gg: ATEYQzyXWXxnbDr8GWSjzlY2bYioRsHrPITDd8uJNhiOdNrDtdzYB2uxdi0QZllsBsH
 KKaBGoYS9SbrTMZY8dINSdyIz+NrmD9HTbcExVO8jws1IyaQ0z7xa8EFHEs006mzfWH4L9CncJL
 55FEVhTAltUiVMiEjTPdfaztdsqHZ7j62mVz6RH4KWLG7TTMiLbAoNaB4TtPHy2f+jWIRzg4NG5
 HTRFRC/Kz5UAovxf5nhmzSgzYk6J0nlNg954oQdAZpxdeAGvhpY1pdtxlaRskqahbqK7tAifew0
 +nycXA7/eTdIv6P9jWcjKsCqIEyF+RAmQY9svXkKr3azfOKlcZ/QKi5/QW/bSKqTYlWfi1PFcel
 6mgWsvTkhkVY9lZP+l7xkxe6hfVEMp7HV6I4izsiTyDNsbjQQWpRhB7IKrOAVftJmzP1cTy+Mqu
 dRzSwBES6sGVoEiNe7onFEUs4UxQq3m6ionWJYpXOq9Yg0FjzbSeU=
X-Received: by 2002:a17:90a:1182:b0:35b:e4d7:9694 with SMTP id
 98e67ed59e1d1-35be4d7975cmr5063141a91.19.1774346806476; 
 Tue, 24 Mar 2026 03:06:46 -0700 (PDT)
X-Received: by 2002:a17:90a:1182:b0:35b:e4d7:9694 with SMTP id
 98e67ed59e1d1-35be4d7975cmr5063131a91.19.1774346806000; 
 Tue, 24 Mar 2026 03:06:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c03124a87sm2317126a91.3.2026.03.24.03.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 03:06:45 -0700 (PDT)
Date: Tue, 24 Mar 2026 15:36:38 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: Re: [PATCH 1/3] clk: qcom: qcs615: Add SDCC1 and SDCC2 clock support
Message-ID: <acJiLj6XRFredehd@hu-varada-blr.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-1-883a45538b6e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-emmc_sd-v1-1-883a45538b6e@oss.qualcomm.com>
X-Proofpoint-GUID: oufXKo-5CtKui06Y7Bc2Z-dU169gEV2U
X-Proofpoint-ORIG-GUID: oufXKo-5CtKui06Y7Bc2Z-dU169gEV2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MSBTYWx0ZWRfXz3m97lRTX7/C
 Okzv8ArQjl+frj4xZleR8U+U0QUAwst3NfETsJpEJOzBchWQnN61nznqVHYlz9zU9nxBqq8cnTO
 7V6CgKZhdB15B3R/5/abcyJy4QBVmLNdMN5y5Atsw6nbZIYiTF5ByxrHoeaBnQjJsoxQulM9qvc
 OKIt1YpBkL7j18yoXrNEkTFU6BguF6FQ5NkiE5ehQwvhnmuoINiZS+zmM5kEJncfVB6oS+Jaqgf
 g58A4U7YVQ7s5jwWHGzzK2HUJixUhug5UO2ds0OwrEK5wkI79YX9DO9evHKW/ssC3lzXx0pDXQB
 sjDIt8YeVfHAQwIO0AkQQ1CRkY7cMgWJPaJ//ZUX2WoYq6Csi5VLAJejeGlk8oxHsEFHfPQ81iD
 kAWQN4pcEJMmOU5U93OYv/oCis1UKmg3PItHckfRmghqTAl3fxhrnveN5vVWQE3bc9emPlwhUi/
 kkhCHtROFkmY0iJhuPg==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c26237 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cjBMemDpsFTr1MPu70gA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240081
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

On Tue, Mar 24, 2026 at 11:22:34AM +0530, Balaji Selvanathan wrote:
> Add clock support for SDCC1 (eMMC) and SDCC2 (SD card) controllers
> on QCS615 platform. This enables proper clock configuration for both
> storage interfaces.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-qcom.h   |  2 ++
>  drivers/clk/qcom/clock-qcs615.c | 46 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
