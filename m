Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A946DCF6AB6
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 09:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124BC83B87;
	Thu,  8 Jan 2026 10:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJYdWQke";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VH30TulP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F9B83B8A; Thu,  8 Jan 2026 10:38:02 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7DD83A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6084F7rr2593341
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 09:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zV2RPsmp6kwTwHh2jDnMUZFO
 k6TwsMMDgbKVuIFT0s8=; b=jJYdWQkek620qMh/bkIt9Lm/rRKY0EQWYxwRNDl8
 O/+x17nMEbMwIDmAeEL3dMVPpzLBvgDeRBreaiyQTzPZ+IIDluptKue3TgtM80+t
 n5cIAq4nuHjqr+BFmoHTPdyAok7xoXPxcND/Zgh1V40uYRPxFyUatGmDJNKH6mUq
 6Or6+fL5ZgZQOM7dRs6yE1fBsZDB3sXkjQVp3lXsA5KnwVoAFIXQGNP5cRqsucKc
 qO2rWBeczX2I2DAYodMIkYbDaAzxML3abAza8YnldEHkeiaE3qBG9/R6uH3n6NFQ
 XX6n70P13hJWoQsBzOZmAbqWyfXz7PQggcZPrpJ9Z+wn5w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn29461c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:37:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c38781efcso3721898a91.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 01:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767865078; x=1768469878; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zV2RPsmp6kwTwHh2jDnMUZFOk6TwsMMDgbKVuIFT0s8=;
 b=VH30TulPqkWcAqinjzZ++Fb2fZV5N9bGONdb3yYVjw0txY234GIwhUEk1BRSBs8iz/
 3qIhRWMzVSi1ly+HalYDLlmRR+an3HWocmO8cVJtH6c0D7Ezp13M9IspOy30jMOodhjQ
 8IPyY/7R2bB/SdMvU96H2RnSqIErEu71UdLieuJb5Q3e/3ODydVlwnX3EkzPLKFk7LZQ
 JQ1HMoTiy/Ao5h+pn2eR0+vYbgQ0P8xg/DkE9ZNnI4qrFwmasRirorVnNl1vp10bIyGv
 EWu+SyGznW78us108+plIi982uPHZG0BZPQZ/yhUoinOZZ/Ao6y/nHAJvkp3ORfjx0Wu
 +5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865078; x=1768469878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zV2RPsmp6kwTwHh2jDnMUZFOk6TwsMMDgbKVuIFT0s8=;
 b=S5naG1JHHyulOII7Cm4+EjeXWYtc32Y5qUjEfoigLGRb1RKSObOLtRxBPFr6vh/qKm
 HwtFOekfMRjMNJ5NydmQL2FCoGC2WWpcDQUzJuAJfcO6weuN+RQN/Gsueulw97qhRDgM
 r5QXbriWcduEsoFk9gLqM43GTViptplMCarUFG8nHL5GcZZS9rJA9O0Uzq9t9rmRIiI2
 DCHJctsIYZ7Ey1g6jw3nVE8C9hCSY2CiNVmAgRfWRLibCxOYMIuop651fh+WDkb5oZKk
 e0/u3SrKxSWqXwkaMwnF6I0ZiWukScXzpMkd2/STuOxCCq91mbEa9zoG6ZpPVaxepWxk
 EoHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1v63iFEfcB5dq6Iu6DeOut6lwv3cqVOZ504lR4mqkh38h3JPOIVnqcJudT1zBddZV+fr7A4I=@lists.denx.de
X-Gm-Message-State: AOJu0YwmfFqWZ9m8eQLQOBEBIvuWNaUqI1R6inN0Eao+hYndhCSREeRt
 XrSSVmgotn/i2BdY73qIxiyfweeRQ4H2N2HoWOq38df1P0T13YnOB9goRTw2ev1hMkTa031ZFqr
 z3V3poAfPNgjxZkCmHHR77tYOrjhlKRGZxopBtLjXkfzVvszieqUS38KH
X-Gm-Gg: AY/fxX5CEvd5Ls8kLNryOgg5MnTlhDdBw2oNAgUVirueJT98GlRprlJNbsjhBKdDHzu
 DKOvDNC4bBp3sOVI7YhumYxjNj2M7itiw5Zfw/TuHuHm3jR/qNgemAm3cfcUV4jOdJrxPPkdPy9
 0fw7vNcWeewrJ1mAvXk1BisOSC7IRIYKsfw+vwvcXTSCC2z2cY6OwNTSNl+EnYYBCOorrpy2QIX
 Pw+jfebSkuK3ldtM0GebpZUF+kk56a3XcoIAbJFPaG75k684kCox7yetADF2JrJ1q2sjjkbSR9v
 OPyrBhtWOuWKqvNxtgsxUiNkWTddnvkqA0SZ0I8Y2ljmgvbIrsT19s4UAefgQUATVveXsbhpkkk
 eX4BUoz+ycLLCZ+6W2HNQPC8kfH2LM7RQ1S1Yc/0OZ9nGXsRlFrjv/dIMFSSMoOwJxBoeSHibw8
 d7hNi8FwEA+fAR+N79S2sUz/jxh7TRMylaUEC9QUQ=
X-Received: by 2002:a17:90b:4a03:b0:34c:7183:e290 with SMTP id
 98e67ed59e1d1-34f68cb9059mr5157219a91.31.1767865077485; 
 Thu, 08 Jan 2026 01:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUHp3oe9b8BWhHceX+vqddn9+Rad35kHghiHnXlvygux9hbRV9xsX0qz/emsAIBrV+OGLxBA==
X-Received: by 2002:a17:90b:4a03:b0:34c:7183:e290 with SMTP id
 98e67ed59e1d1-34f68cb9059mr5157176a91.31.1767865076944; 
 Thu, 08 Jan 2026 01:37:56 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48d77sm72696725ad.41.2026.01.08.01.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 01:37:56 -0800 (PST)
Date: Thu, 8 Jan 2026 15:07:49 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, ravi@prevas.dk,
 javier.tia@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 ansuelsmth@gmail.com, mwalle@kernel.org, anshuld@ti.com,
 jan.kiszka@siemens.com, javierm@redhat.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/4] scsi: Add partition lookup by type GUID for SCSI
 devices
Message-ID: <aV967ZD8Hdjed/ss@hu-varada-blr.qualcomm.com>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-3-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108064947.3237361-3-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: hqCwtTouJSPr3kG9wt8CX0NylWFDuaY1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MyBTYWx0ZWRfXzNuI4twy9F8M
 xeffbzI9FdNqQCCacLGnro9Yqk/Asx0txkLbMPqenWx1bv16zjInaOHPSJGWodL1URVgcLEDcll
 YQOEnSoa5b1chV1KUKZHCx+bmcyYSp6meLQkLzV6eOVfhcz+HzbQatPseVwVm7NJIHSmCqtEVUb
 V1agVU+wa3LYpF+tlME0Qfw3wdgO0uytfBypPUnU0BYkM46ooc3zOCliMsWal563lvyCANyWnJh
 qd6YILeAgji8FLKDv5vLN4WwYnV2A1ITXpNkKkwdvkMH677Vss4j+Fbfzd3G8M+R6jqYgURJFNQ
 8gerbIWjU0Iz789AzeO5FXHDlxipzELAHN25BEBknJpvshcNYfv97BnyMnJOV33mbCOJSH1ju54
 K2EUysTxTBm3qWnv7bcHubIwZySdcR5dfBKrgSjimeKRcyxOX5Jc/FBuSQiD6twxZpALnMBn00v
 9K70vwnJgUfFk96HgzQ==
X-Authority-Analysis: v=2.4 cv=P7k3RyAu c=1 sm=1 tr=0 ts=695f7af6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LX9Icu97JxLhj78vYW8A:9
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: hqCwtTouJSPr3kG9wt8CX0NylWFDuaY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080063
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

On Thu, Jan 08, 2026 at 12:19:45PM +0530, Balaji Selvanathan wrote:
> Introduce scsi_get_blk_by_type_guid() function to enable SCSI
> partition discovery using partition type GUID. This function scans
> all available SCSI devices and searches for a partition matching the
> specified type GUID.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/scsi/scsi-uclass.c | 28 ++++++++++++++++++++++++++++
>  include/scsi.h             | 11 +++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> index 3eb6069649f..42a6b5233c2 100644
> --- a/drivers/scsi/scsi-uclass.c
> +++ b/drivers/scsi/scsi-uclass.c
> @@ -53,6 +53,34 @@ int scsi_get_blk_by_uuid(const char *uuid,
>  	return -1;
>  }
>
> +int scsi_get_blk_by_type_guid(const char *type_guid,
> +			      struct blk_desc **blk_desc_ptr,
> +			      struct disk_partition *part_info_ptr)
> +{
> +	static int is_scsi_scanned;
> +	struct blk_desc *blk;
> +	int i, ret;
> +
> +	if (!is_scsi_scanned) {
> +		scsi_scan(false /* no verbose */);
> +		is_scsi_scanned = 1;
> +	}
> +
> +	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {

	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
	for (i = 0; i < max; i++) {

Else, i believe blk_find_max_devnum() will get invoked multiple times.

-Varada

> +		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
> +		if (ret)
> +			continue;
> +
> +		ret = part_get_info_by_type_guid(blk, type_guid, part_info_ptr);
> +		if (ret > 0) {
> +			*blk_desc_ptr = blk;
> +			return 0;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
>  int scsi_bus_reset(struct udevice *dev)
>  {
>  	struct scsi_ops *ops = scsi_get_ops(dev);
> diff --git a/include/scsi.h b/include/scsi.h
> index 8d6c5116419..e0b2f869057 100644
> --- a/include/scsi.h
> +++ b/include/scsi.h
> @@ -361,6 +361,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
>  int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
>  			 struct disk_partition *part_info_ptr);
>
> +
> +/**
> + * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
> + *
> + * @type_guid:		Type GUID of the partition for fetching its info
> + * @blk_desc_ptr:	Provides the blk descriptor
> + * @part_info_ptr:	Provides partition info
> + */
> +int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
> +			      struct disk_partition *part_info_ptr);
> +
>  #define SCSI_IDENTIFY					0xC0  /* not used */
>
>  /* Hardware errors  */
> --
> 2.34.1
>
