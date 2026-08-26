Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E1FC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 09:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0253280BA3;
	Wed, 26 Aug 2026 09:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ZHjV6B61yzr; Wed, 26 Aug 2026 09:17:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787735825;
	bh=HbkyBuMyba0o28OsRo8UQl8yXsE0LANx8qKHtrzMdck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BFKnFLBrYMMFzLYf92EbXbnjLijDYenAOU2/WaDCQKdNeL9R6k8zdeL5Tll8yTq2p
	 VV2p7Ty5SyMYAKkS7eoi8cJ6YP6nbJgHGaORBPfXMyJWIQPVm3qw2oZYRbnuxpZqlW
	 ICO5oAk/RoEdNwnBG+kD+AVNgdcg4dQl7/P2vjFP29yJzAKr7MeA0+GZSQe6yU0ZE7
	 /cC628VJXB4bnVeCk3xOAZwGdH53gz/yaVC26/6bYfMi21Ij7aM7yuZhiLIIffuNiL
	 BWQ2d4TYNOxtK91eKXczcmBQncfHyS0CMnl2tBejIOmI6GtugARtbbJvOeVY8GPAuv
	 wDQma297I55iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 198D880BC0;
	Wed, 26 Aug 2026 09:17:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B28F3AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78D9140130
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZttH4A1yVI8 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 09:17:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=E4tjp7L/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Mgmkr+3v
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94D9C400F2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q9CZwu1062588
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HbkyBuMyba0o28OsRo8UQl8yXsE0LANx8qKHtrzMdck=; b=E4tjp7L/lRqELR+J
 iXoaS8NLkbsdKL3yWB+tkBof5QT/sbbIYQ5o5oFOJiHh6z2ufRdN4LuiisWhsRyu
 p/Q5+m+PeDHAHTZf8ef3F7zTj+ug4UfoKrlIasPrGYBW1RqVIMyYYbsHz5mReKNG
 aHJUxwH7ADExcGN+pB3hhz8yyhAQcQ+Eq7thJQbYap9oWMBZ5GRG0e8X00fQ0bVZ
 Njs5GRvTOCNJv+Iwq5AjU4xUY0af9nxeLup9/Fkf7VNuFc49qGhAwrq634T02B7d
 NP+e0TYIfHRB3EOPcxPGqF8cox+/PUa64OvfJnIJcY1Zolb3SS68fFPNq4LgYbEL
 ilj41w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgxk546-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:16:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so2000742a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787735819; x=1788340619;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HbkyBuMyba0o28OsRo8UQl8yXsE0LANx8qKHtrzMdck=;
 b=Mgmkr+3vLLrl79Fkn+J/DVvMUsPzzf5RXZTLzM8ctwMJVZnbT2hlnjFWE/H19S04Lx
 BlUBN35ecfRaOXVLX7QTzN/L+/Pbgg4Tc2DqqZ3E5yy4OTU57l8hXkspgx6fwjyHhFnG
 DHE386M7IB3zJAlFjJP42PvH/eHhimJ7kIWGOMrT7Okot7OWHnAAj1nnl/b/xGu4hfJ0
 bxVuJOSX6ko/R8nYJcR2xoJhNReHYyH2XSN4Co9TYMt2DrpLQBpA/hREzLPaWM23G8Ik
 AeV2AQZz37SZt4VjetaF6AvAxHpXozyxttmA/VumKKGIuJE/c1Gmj2SOHDXMwr6FiTVn
 /SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787735819; x=1788340619;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HbkyBuMyba0o28OsRo8UQl8yXsE0LANx8qKHtrzMdck=;
 b=H1Aj+g/sAPu2KXI9B7sJuvv5++JixTf7m6IBFEPAW4VKNzoL4fmjssXD3BknEgY8dc
 nMMprKlqF93P82THkWrjVmRkTfSli+3r//f1VFLVyIn5V2pnT7m0aoU/zWMdmEWhkEuZ
 hc0jS2USM9n9XRT6EQLIWKekus7XA27UCb7KsTTsC42ppCjVBNazdxwWlwPf4V6XfN7y
 vt5euMz2MWXvNfa5uSNQOMapC/n6WiLp4GCx35hb20/ku9Ej0aLZ4DoJkFkMtjDHrAIW
 qnYTOkTFgdbvWZWVtjQnugLLWWbdodIK6TNcX8rDTN8BedK+7nezurbwC8uWeyS8SF+O
 Z3+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSEKyeBB58exL4/YPEOQM034j+/55VMYUQMk+XI6Ooj5Z66z9vocWovk/lNr+wHcdgRiFh+XE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kbdkJmwwJdZVR0ef1jZ03RZGol+jp9t2yH0VZKYYzFfhWf4VAJ
 K6niqviN9OvfXRY1ChQ4I2pL+DG6mOU2fSaq38sW3EDGXhL2Mn9pA6CGi1M9WSsvCW813yc73Yz
 flOqyk+IIXUNsfO0LtxMkaLuu84S0HKkt7aYWLEzvQoFau0Euu+3MG+WtCo0uYB8OWJNoFHI=
X-Gm-Gg: AR+sD13bbv2QU0rVJ2d8rYFi3zLibtv+pYs4C4fsiuZFlsSPqUoqPx9rM1Dlcs9qKwQ
 ljyEwxkPO8394SvjHKK2X9XqQIpVakBnI9PFH1hl5UOHkoEOgqEygSXO4BvKzbJMB4oYSvTGzNC
 QXNCPHORKPcC81DD7I73X3QoTtuCS3m1WBO8sTb9ZJ7HlDtrnBX/xRfP6UEYf5MAuOa8xNEHphx
 EUreUWF7aOzW7Tbnv1+AY06w8bn6gzaTgnTKyMZZ1VEyfW6/XjFaJ9WWxjyIJ2QQPeD1hJsaaBa
 e2tAezfYs5Ymfv1FhsAnjAVYclurp1VnQp9LVRtMo4YmNjVXUODSr4jiS8bUMwJRHKWkLLYaHr4
 vP6v/qLhRZ8zNbEe7Va+oSJm5cb7kKci7Dik=
X-Received: by 2002:a17:90b:5444:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3966d8e30d6mr11648671a91.16.1787735818856; 
 Wed, 26 Aug 2026 02:16:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5444:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3966d8e30d6mr11648591a91.16.1787735818411; 
 Wed, 26 Aug 2026 02:16:58 -0700 (PDT)
Received: from [192.168.0.7] ([49.206.98.18]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8eefd82sm6192438c88.2.2026.08.26.02.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 02:16:57 -0700 (PDT)
Message-ID: <347a9029-98e8-46df-af7c-22c5a2c5d010@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:46:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qcom: capsule: build fw_images[] dynamically from the
 partition table
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Biswapriyo Nath <nathbappai@gmail.com>
References: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MqZiLWae c=1 sm=1 tr=0 ts=6a8eaf0b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ixBiRExtVUu8ZU8EgKly7w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q7TSgqoHGAxXEXfRoKsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: pb_-E2V-FMMqmQuvFdY7cV15CFjYCdWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3NiBTYWx0ZWRfX9tP4f9ZWGowg
 cKVI2+RBo8i41E/C6nL+RqVFxDIVJ3je7i2bC30A5yFK4n2jxh/fWzKvVmKgFx+qiKuWf6pYC3q
 hPIsTj8UeJTCUhv3Uh0zTJ2rf9FZFJNG9mHNdiR1wMUYMk8CINS4IN8sL4UdnVrAWyAFBjEy1dL
 /SxHtDZ6TEm0Ad4a0T4N2znzBQMwiT3Njs88hTVsrKhr0pMOAYGy4nZEHkwmCCwfC5k5mDjebW6
 S9fPn8Q95/XFhLbay5v3AzqcNc97kdeehipeEX1E9JziYw3DItqePOVbR3gFHh71T59i+SNopty
 fGSZKZW8P3g2XICWexOOw/NVHZ3lyOB0Vezw6AKYhf/brIPqQUvUOntEL/O+88P6xC1RLTVDRwo
 gwaAMlRDb9Nec8pq1sykqHFAau63QnkW68U3Ac2o8mg0kbZZNH00psEr1P+JqhVHFgX40k31Rcf
 ZhNUviYFG4lFc1hJ5vA==
X-Proofpoint-GUID: pb_-E2V-FMMqmQuvFdY7cV15CFjYCdWG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3NiBTYWx0ZWRfX0Ssw+vxYD/71
 HbVswTjtKyNxPgBsZ2Xi9Abj8epfgXUj5jXCKG8JazM/BvBmv0bxKbOnTswpSl73TzBxKDgOTKl
 8gCXB3mhBfkU/Oe0AIBpiER3O7THdRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260076
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Ilias,

Request your opinion on this series.

Regards,

Balaji

On 8/13/2026 11:26 AM, Balaji Selvanathan wrote:
> Capsule update on Qualcomm boards currently handles exactly one image:
> U-Boot itself, located by find_target_partition() and hardcoded as the
> sole fw_images[] entry. There's no way to update xbl, tz, hyp, aop,
> devcfg, qupfw, or any other firmware component through a capsule.
>
> This series provides a way to support capsule update for multiple
> partitions (not just U-Boot) in Qualcomm boards.
>
> This series depends on following:
> https://lore.kernel.org/u-boot/20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com/
> https://lore.kernel.org/u-boot/20260720-runtime-v1-1-7f904b4cb3ed@oss.qualcomm.com/
>
> Balaji Selvanathan (2):
>
> qcom: capsule: build fw_images[] dynamically from the partition table
> configs: qcom: enable capsule updates on qcm6490, qcs615, qcs8300
> ---
> Balaji Selvanathan (2):
>        qcom: capsule: build fw_images[] dynamically from the partition table
>        configs: qcom: ignore OsIndications for capsule-on-disk
>
>   arch/arm/mach-snapdragon/capsule_update.c | 757 +++++++++++++++++++++---------
>   configs/qcom_defconfig                    |   1 +
>   2 files changed, 531 insertions(+), 227 deletions(-)
> ---
> base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
> change-id: 20260811-qcom-capsule-dynamic-fw-images-f303270b2503
>
> Best regards,
