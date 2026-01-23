Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300D5D6CFBB
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 04:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5C8839DF;
	Fri, 23 Jan 2026 05:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BNinnRel";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PM64OI1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4884839DF; Fri, 23 Jan 2026 05:40:16 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D419839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 05:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60MK7dhI3110251
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 04:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=haVIU4pOfXWI1YPMLb7opxo0
 ZSG109TpJncXyWYZAus=; b=BNinnRel+pZ1kACjXBJFVI1QdWp/9phyxI6b3j4D
 sh70CsrrTKH38cH+v6qhnoPi1T6dcLXXD52wSNlH2c92L1xGPDwKPWup5+l5Fr9P
 Rx6RMb5DRUzLzfK3I9klUduh9VvxHr0oIkf0sNsTHLI/4nISUkhzFK6sa0uqok6b
 RorpVOiobYuTx10+zqxNAiauauURg4/hNykSJGeisrXN0ybzwD5qFjn2fgsx9WGt
 A3euDewaWcGCfSofynDuHBDg7tUbdkSXPCptZEK/b2JykvcV/ADdqbqQ7BCns1Tx
 3+lBSh5ySZYI61chMCfffYCIkO/vYPJIq1xnVRS7EHoKqw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buq3ga9r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 04:40:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a0b7eb0a56so15969655ad.1
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769143212; x=1769748012; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=haVIU4pOfXWI1YPMLb7opxo0ZSG109TpJncXyWYZAus=;
 b=PM64OI1PHWMdTsWBasP5NnwO1gL8R+pJUJa2bhJtKy8sawj0mvMX0E7JiP6/XfWk8Y
 L5h7drWK8oTTlC5S3QyUnkBBF+yL1PT5epane9LlO+AgnRiiAPcNl419RMErGg2hKm+i
 MAD46NIjnWew9d/2RRd3ONXDbCeLdHhNf79EuaSl/FQx1NS1YAckpTE8yx92b875ehAO
 s2yVtBRccg2f8OVxxNnBMd12MUsEibspF5nn57rS4pUvT3a2WPlJCa6eOnYuqOyz5obl
 5cEZqi2kBvLV1qEWI06LrhJ24s/z8LsidSvCH7FN1EDfAq0rIfNZDxL/cNush3HeAjAC
 TGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769143212; x=1769748012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haVIU4pOfXWI1YPMLb7opxo0ZSG109TpJncXyWYZAus=;
 b=VKUmXoVb28ilED9c579p82z0csOOeMcMoLBI9pIREeCySxLq8LtT45f7w7nc/pWfd9
 PMvGcNX7KDvG1unuGtbR7KWBCivXcFXFdbT+FepNXwaXiTiEQdF9G0huH3EQxMPtlgOi
 i8VQujmPzXhph40bzxxMBe9B77ELmvDz059R16+TyhIhuwkZ92EZYPpc4fennMBerBjW
 EpxUCvUSRdKaIGBUT1/dWafbJm6zMNYK0YQDslmg70qq7jFMLmXyW3E9THr2CQ4to31z
 YVYzJHY/AgEE2MyBxevQZ0vmvwk2hy5BWckPvI9zlMTPnt9/yTrHFeX2K1wwAmf0w/Ru
 2stg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyr3qKV1K0/9Vq4/GXTIh+VblR5FDhLcFye4ULR89eR6NrDdRuelQIf0Z1puppxvUvvGLY9Qo=@lists.denx.de
X-Gm-Message-State: AOJu0YyDbAxfVYOYs/+FxJapaqMqqvUvvQcOLwD/VrfPB0LBfoMXNgHV
 LFCnI+yexw88iJ9TJd3IZMGOxN9qeNLdbQ+vQDu3fpaZgfu1hUxQIu5Tj50WCFq8a1VeJw4b8Ro
 IHZOpDLatFIBe1+qAJzPIaL5kPNhfXjTSqeZvQfQINRKQ+5eo2EF9AIyt
X-Gm-Gg: AZuq6aL2dV1L+SXYbWDbfNLczbJ4N/o2FuiWUsBR72hxuLNkjzzt58Bw13m8P5fVJdG
 OwG+hQw+xP3kzRb+YewrAWNXC+yhXF4L6dmzfoci+5L/oKmBRw3HcjTpc0iPnPZ6VlKR32NwUfw
 U/vZ3nQolnrwNSOtp3BkNpBE2g6OPdrTpHQU+Jtu9N0eOewIWuTnGosP8gHqpomDl4PpNIOELAc
 FlU+fFlsnksHmDC9C8Hrj142HEm3r3VcqTLGyC3vkFJCkQeeg3qnc2Jq1LksBjePR56L88MhvtW
 1xFuR0PJFgRL29q7qhy57TTgkmpMNOS+1ef9dwFgXoaHia2N5Wyn80k2voxeeMyCga6OVzJxgno
 Ezo7Ponhg6A5DrJNXD/BsquYCW26MQLfNausEI9UW8dIVCe8QpXrEOXkJWOwIs/YaFkQEaD1Rqc
 +n+AKkqARNJ0WgfmXMP2SLmLJh8iKFnYrplsdtqUA=
X-Received: by 2002:a17:903:4b07:b0:295:5dbe:f629 with SMTP id
 d9443c01a7336-2a7fe43ee1cmr10941365ad.8.1769143211851; 
 Thu, 22 Jan 2026 20:40:11 -0800 (PST)
X-Received: by 2002:a17:903:4b07:b0:295:5dbe:f629 with SMTP id
 d9443c01a7336-2a7fe43ee1cmr10941145ad.8.1769143211344; 
 Thu, 22 Jan 2026 20:40:11 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3536d8ad7d5sm795297a91.5.2026.01.22.20.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:40:11 -0800 (PST)
Date: Fri, 23 Jan 2026 10:10:06 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 casey.connolly@linaro.org, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] scsi: Enable FUA bit in WRITE10 commands
Message-ID: <aXL7pq7yK7YPsbFm@hu-varada-blr.qualcomm.com>
References: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
 <20260122083954.2722972-3-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122083954.2722972-3-balaji.selvanathan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I9Johdgg c=1 sm=1 tr=0 ts=6972fbac cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OpxT9wzapyYwnj1NZEoA:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDAzMCBTYWx0ZWRfX3KIJbBZkMKJE
 j8jJd8r7tOYYpKxL7pGj+xhtCfzLAQ6Tc0Kc4gmLX34XD2vY3VIkfkG+h98oBlO+kYBTM5Q+VNy
 S5Hj+D9wR3e7ndVcl2XpdQZl0pldMBySLox+3ftLyRoh/ATh2m0bpkOY60uyTzkOJycytYBgNRd
 ElEXdd1FZ5kgh7OLq/StyvTjoAYraDO5B5MVCogOKcbUIL4N0WpK/WdIs0I2r7DmYUVxWh/DwHe
 jv5kDDmhhS0/0SABBO0BPda+lulwvXUN8pNjVvpA7aP7GnpzwZiabKB6Uz8GzVbQRIAU8iyt/K6
 zYhqnjLBjwbgFor2QO9XDkeORExITXhJa4S4KNTf/AiZeXMYs2x9OlIQHfTjdXlg+GfkS0UDMOq
 RU+d7pj0HCBUpUpnT1G8PenFPI90dev5k4xumdpCSFb2iXlIkraLpmrzM4JEaYAP66mPGd9RFeu
 CQdNvtdQM74Br4CphTg==
X-Proofpoint-GUID: tkcXCbe2jPYwkeAHiG-U7ctXf9nM6J4z
X-Proofpoint-ORIG-GUID: tkcXCbe2jPYwkeAHiG-U7ctXf9nM6J4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230030
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

On Thu, Jan 22, 2026 at 02:09:54PM +0530, Balaji Selvanathan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
> ensure writes bypass the device's volatile cache and go directly to
> non-volatile storage. This provides write-through behavior that prevents
> data loss during board resets.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Add your Signed-off-by.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> ---
> Changes in v2:
> - Reverted "scsi: sync cache on write" commit and then set the FUA bit
>
>  drivers/scsi/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 2e99f68cc5a..153b4841add 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -107,7 +107,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
>  				 lbaint_t blocks)
>  {
>  	pccb->cmd[0] = SCSI_WRITE10;
> -	pccb->cmd[1] = 0;
> +	pccb->cmd[1] = 0x08; /* Set FUA bit to bypass write cache */
>  	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
>  	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
>  	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
> --
> 2.34.1
>
