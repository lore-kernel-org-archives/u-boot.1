Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F272FC2A09B
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 11:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411C083CBD;
	Mon,  5 Jan 2026 12:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkrkK+ga";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DsEv+In1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC30B83CE3; Mon,  5 Jan 2026 12:38:50 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4960839DD
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 12:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6058wAoc594026
 for <u-boot@lists.denx.de>; Mon, 5 Jan 2026 11:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XONa+2HybbD+UMtx5dR3/P53
 AvROPc3de0uIcdi2Gxc=; b=XkrkK+gaT1muaBOhlGhpd2DkuSjm1g4pCC988evw
 B4Lliz2fCoC48WW6AaRjkZauOzSjqZJs2/B519krn9UIO5WHxAFjfN2ASM8IHhb9
 JvgxsNEzabWGt82f9ueOj37AxK4hmxriF1Hep6GmwQXuX19X/6UV0aQWNgyr47Wy
 XNBxXvXVdWVbsUUgF3JCzf4mxxeSBZjSHToGWHY0Kkauwnj9yTH4BuSgAdYDhbhT
 5KO7F82FGNa6J2aqeOS1+76WE8rIcsyu4sXbs27YlqUbg3vkiW1m8qwvjICgN41J
 7fkoXFo7sF11yYkR1wqZcVT9v1t+yzYlRYN+KwdmookgrQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bga8pge7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 11:38:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0dabc192eso325860935ad.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 03:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767613126; x=1768217926; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XONa+2HybbD+UMtx5dR3/P53AvROPc3de0uIcdi2Gxc=;
 b=DsEv+In1xpxtx6XIGX9cpzpxN9xzXqBFmP0cEGCacCGKShA9WJzoEoYHfPLwkc3/40
 JeRxRq6CRwhtbE5Q1cSx5iro7Btkz8MFd3aA2uJea+1WORPXcFPFT7fNZ4pECQawxWs1
 oBp0Zr52PlP/zgFmr0CvWqQW//sBoF4PSsPV2y6GhG16r/63FqEzW0Uvn9H5cO0ipE3q
 9Q3HLyxsLH7N+A3Hmn+jbGMFJb80jZ5uuhEnlnaX0F0QcPbt4v5eIh8UF/6fd9Dcepgx
 fxhZyrlGP3IFKWYCezozKV0F8o/CfKXkCKzniko6NNFgu5msfz5O28fkuDO5zqxwxx7Y
 7CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767613126; x=1768217926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XONa+2HybbD+UMtx5dR3/P53AvROPc3de0uIcdi2Gxc=;
 b=sFaU8Y1LA+H+5T4zduMDDfb0sQNS38uYotpB4le5KSsl5IUNB6KMEZpnwxN6FIaPG7
 G2HrzwlXeloMB4lKTA09k5M7wAwrDP29bvXjyPNRyDGvKC4/99LYVQxVhZUVwtW2ks0t
 CZ2xGOT1/KPbQbBLjinw2lY4AzeGFu/+9ZVEFVC6Ax80zkKFwIsRc1jHvLrySvUUFTfj
 JIbBwundRKIPSm8aVnVKR2otidDr1h0YXz3SaLWdr07FxWYyHlP5tlOS9qj50d5a+Qsg
 f+bxL7UIPJXeV0oD1t0gvcRnf/FWeSuXC2sz5EoVNppsHRPHZ5JfFA7oB8hK3gGTU85r
 cQiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsKGJCuNp7L/bcai9ak6FB0WSE4sXB1GeB1xmIj9SEu5vQhQJx/tor1ZrBS5PqXmnzksLPcZo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqp+q4WnWtKqqkytqnBSwoPADjnQEA61k/i6VZJafgkJbx0FvJ
 2Off6W3QwghXfgBl29vOR7K7A9u2rEHcYp0UNUVTrWFkANxNEySLnPMMPLJglCSv5wX2LkrhqTI
 1h6ghUHfCe+CuE+w8+gQGFjljtFrzNDikStZFkU/ic14iz6drsa4jO/X6
X-Gm-Gg: AY/fxX5Yce90+yxZuo/Bl5L3yUsVAT7U3F5VT50vsolDJl9d288qQmaymiWezZo9uNu
 G++wKf36ryfkXtm3inCXLCAAxCWLXulqZm58LfsNFWMEZuCxGlvGGISEfXZJW1YWmqONCGp49Qo
 wClnlF0ufvvHzy95WvjJQhqTHLNzJOYvIqOxHfX9KHYDKOomBO1YKk8NvcwTgCo0qTmzGy1PjJM
 0Niv2pR7HpCB/1dK6vW+y5aIATcym5bPP/Kb7yeFaHYxQv7zlqWeaVyDVDo4KJyze3F4Ea7uziI
 RNooi8sOFz1i4sTbZ2utHDENgeJiYbwpVMDuWrFzkU2vFy/svKjtWoM7Fppa6iqYNrJ5vfELEA8
 WAfBAXdAcY5/72o3PkMhGh86dSW2FYK5Jf6F79qDHABU6E+BMrdQ2n8kaScsUjlqqyrJgCJ19iD
 NefDCMK97MucbIpJG7J/ym5bPBqD05x5dh3MjmH3U=
X-Received: by 2002:a17:902:d2c6:b0:2a0:7f60:9786 with SMTP id
 d9443c01a7336-2a2f2329b92mr478057315ad.26.1767613125818; 
 Mon, 05 Jan 2026 03:38:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm4g2aCkVzaX3ytZC3EmWgYXOxCWvdltbAGg53QyofZoaoQmgA6+Rlm54xWxrNiC4sNi8cDw==
X-Received: by 2002:a17:902:d2c6:b0:2a0:7f60:9786 with SMTP id
 d9443c01a7336-2a2f2329b92mr478057165ad.26.1767613125366; 
 Mon, 05 Jan 2026 03:38:45 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c839b7sm452946825ad.37.2026.01.05.03.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 03:38:45 -0800 (PST)
Date: Mon, 5 Jan 2026 17:08:39 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, casey.connolly@linaro.org, 
 quic_varada@quicinc.com, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] scsi: Enable FUA bit and remove per-write SYNC_CACHE
 operations
Message-ID: <aVuiv/ZfPHWs3QfJ@hu-varada-blr.qualcomm.com>
References: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEwMiBTYWx0ZWRfXwFSxmpD7498d
 r6WMJ7V/Pdbs+nsRiw8O+N+nezN5dzADNzcua8keUpLEpYTzKWUU1deig0SWmtRKtA8XlK0/0pb
 l+JmRaX3dxkxwS7ihVI9jmEVVS49n1jcfaObyQy9j/asUEoEqu7uQx8vuI2WNIl9ZYZYmptyi4y
 j9EMMC5ZnlPZ9RbT34vVuD9LCcyr4TvwvvcqWaSEtw5pEP3isTB3mZmCtu1BtaT4IaiXDrL0cBo
 d/ZqCwNNd4kEyNLyprYh0E/xytvsNY+z+keO+tZiWuVCE3PjiNsOZ4BuFAvRgTakIyWcwlWwSD+
 UaSQL5luweitfo+B/CVYLhKKU03n2TM5GkIbFqcMC9N+aCFxyaudK2dII2BOnwgnncl8hXLhFSZ
 PsOZle9ANVqdeGQ7LXj+ddKGywKjKMzbcRzmMNCmZdqcce5Xt84kMrjPGU5tGhpb4B7YXF302to
 CdepiByhH50neZYUkgg==
X-Authority-Analysis: v=2.4 cv=JfWxbEKV c=1 sm=1 tr=0 ts=695ba2c6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OpxT9wzapyYwnj1NZEoA:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ny8k0TVo8clPe_0kWwNdVSJmSrKcWiMP
X-Proofpoint-GUID: ny8k0TVo8clPe_0kWwNdVSJmSrKcWiMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050102
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

On Mon, Jan 05, 2026 at 10:55:26AM +0530, Balaji Selvanathan wrote:
> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
> ensure writes bypass the device's volatile cache and go directly to
> non-volatile storage. This provides write-through behavior without
> requiring explicit cache flushes after each write operation.
>
> Remove the SYNC_CACHE command that was being issued after every
> scsi_write() call, as it is redundant when FUA is enabled and was
> causing system hangs during large sparse image flashing operations.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> ---
>  drivers/scsi/scsi.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 8fe6b38a8c7..b755616bf3f 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -124,7 +124,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
>  				 lbaint_t blocks)
>  {
>  	pccb->cmd[0] = SCSI_WRITE10;
> -	pccb->cmd[1] = 0;
> +	pccb->cmd[1] = 0x08; /* Set FUA bit to bypass write cache */
>  	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
>  	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
>  	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
> @@ -301,11 +301,6 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>  		buf_addr += pccb->datalen;
>  	} while (blks != 0);
>
> -	/* Flush the SCSI cache so we don't lose data on board reset. */
> -	scsi_setup_sync_cache(pccb, 0, 0);
> -	if (scsi_exec(bdev, pccb))
> -		scsi_print_error(pccb);
> -
>  	debug("%s: end startblk " LBAF ", blccnt " LBAF " buffer %lX\n",
>  	      __func__, start, blocks, buf_addr);
>  	return blkcnt;
> --
> 2.34.1
>
