Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAC8C5AD7B
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 04:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7852980EE7;
	Tue, 11 Aug 2026 04:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_Ya-6q7eRg6; Tue, 11 Aug 2026 04:28:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81DCE80ED4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786422483;
	bh=bmTz/gaxPjmrx6AjnSI1gWgNkaAmvtrs/Q+kgA7lRM0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sRrjB5zjwF4pzqp+OVSgmwnGKHQWY98Ts1ZQGbw4Y2CNB4Cdr2ZT9E4HM6OMuiJBB
	 Gz+R786Fs9far4FYKZRqxhBMJW9u1h7Emex30RkBqabHHjREoSBv4CZsXpTrjuA27l
	 0XIEtRMecI/nR1ZOU7fL6Y/UFL9OZeuthwCt9QKoAcxyxHXYyJ8zCMBF1uW0dMsPBw
	 FomTDMyyjJSvpCwikB4to1CQOT0/q1x77uKIGOlcnuv35KPiuYT6mMMzs5JxyHZJK1
	 Pr2NIvHj/tfK7W3jV3ZXxLME5H/y4aRexox48AK+rap4FOMIfWj6krW3CrOu42ZtEl
	 Bro7ZPfugLPDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81DCE80ED4;
	Tue, 11 Aug 2026 04:28:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1791A40A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 04:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09A284005F
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 04:28:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jgqk6J1cLDZt for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 04:28:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E537D40050
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E537D40050
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E537D40050
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 04:28:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMqRai2997292
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 04:27:59 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf284q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 04:27:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so4264823a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786422478; x=1787027278;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bmTz/gaxPjmrx6AjnSI1gWgNkaAmvtrs/Q+kgA7lRM0=;
 b=kFdkAB7X4Ilq5j86S6fPqf3ccWmg7l5S20FsPYTUwdtkNPdfGzTsc+BYmUorcUrRfS
 ZsIt0PdwbrlHixnwBbKU2b2BBwv8iUWjfOQ/Ck2jhQ7mS5tktHSMgkPRcZfOv96otKaW
 3RrLqQWq6Vlb9Ar8jUWWYXZfO31FTROUku+9dkIRPa6+twIgfMUi2R4RJu+JnXgQCaKB
 SDIrMMTS5xy9l0d7LiPQgUNUuID8SeeZiRO2JnN0erv3aZxa3SQRC2MdmfP5EJ2OqKdg
 6ypq2ZRSkopLwWpvmVrID9THNJLnHKwAy09FwC3qDGyxrRIBNfQAlMPY3p5oIfVkzlX/
 A3Ew==
X-Gm-Message-State: AOJu0Yw4O3zvLkFglLvjtTh2dii4bBi8rJ7rOzNfxXILDCl1zMKqHWQA
 ST/1jfsJWt+9Wnxn6h8hp47zz3TjDDD84w/rHLXgqBl67F1rdeZW+M4XvpqfPHEichoKwXC/nwY
 o7z6TJMBJbymjxKbJB0/87SZLuvlTcQ3gGx9PKtcfMpe0LbdyX003DOQKi1jyAQJm5ISrRjI=
X-Gm-Gg: AR+sD13u7AgYWs5itjIqSa+259DR0wC+3rMxy+Wc1B5cJ2AxaOqMJIZZ8gw3/OwgJZ4
 ExiffjEsLaADj37UiuS/Ram7jBils9YZkOXDygaSql00bkTqHc1V0K8SmVqRwBAM48epfjsP3Js
 Zxzxnoq6buzOrT7GEWWsrPp19fD2hEDi89EAYbKKXrefZLnfahAtQL7EGw3qkcOzVDYB/Ph3OX+
 r7dteIy5INDfZDGDA/i8nXuhrhzagjLrVt5kkQHkLV/TWlJc1XL08OacpujpULy75BnGYeLZwVM
 UmW1vHslRciiVWWtpWEBN3az64w7He57/tLulrIp8oVIsAh5ifB8nOIpujUUZnxO7SWOLkV2Xwj
 ShsFs2JhbnJLInv3JX217R3TKXYHCU6TAOhMnQg==
X-Received: by 2002:a17:90b:51ca:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-392ec4d3ab2mr552595a91.5.1786422478322; 
 Mon, 10 Aug 2026 21:27:58 -0700 (PDT)
X-Received: by 2002:a17:90b:51ca:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-392ec4d3ab2mr552552a91.5.1786422477900; 
 Mon, 10 Aug 2026 21:27:57 -0700 (PDT)
Received: from [10.151.41.168] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14120443659sm795043c88.13.2026.08.10.21.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 21:27:57 -0700 (PDT)
Message-ID: <129bccc0-d5fc-42b6-bcaa-ba3a34ad9afe@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 09:57:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: image-fdt: suppress spurious error on expected
 reservation failures
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Randolph Sapp <rs@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
References: <20260810-suppress-fdt-res-error-v1-1-e9641eb0aadb@oss.qualcomm.com>
 <20260810181637.GC1160436@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20260810181637.GC1160436@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HQOtuNmUWkelPGIz8Cz-G1BrivgCD6Qe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAzNSBTYWx0ZWRfX1W697MM4remk
 mb+O3Vxm/t/5fFNkGIEp1U+x0kPqobqeqKL2CJINYviSEMF8VtEXN985/n8ZHhStjr4kO3MHhvk
 /BMDUaatnvQfG9kX/DmTtvSKwMmv2aU=
X-Proofpoint-GUID: HQOtuNmUWkelPGIz8Cz-G1BrivgCD6Qe
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7aa4cf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=jar1TuTubjI1eGnWS9QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAzNSBTYWx0ZWRfX5MkcuPtwqZ8T
 NfT8a3Zr7a/GR3ro1+c8UtVgJ5+faH/xtbz7cuZvyZS7HjrWo9L706l7gjy7IBfmIoWIODz/XYr
 YCWBGqvJdpdXJPjYtRSLLxxyAt/+CxLaQOo5/C0eacR9i36W/iemU5Cy9CbJDJ2yF6MUBS36rOH
 /kntwPviQGW0z3wN6lxHlfAoHNvaXeCgDBJWHLyM2lE2PVQhq8/boiE4oy1aOtueohPSTRKrNHC
 585CLorQ9+PUyMIvbaVu+ed6DhsFP3FQKE1LmYOwh2iBHlpRDfkAvdOd+x09dLj14CCkLy5U21N
 ByLYRydZuPXy6Ys0lWcjDFyVrOvZ2cqYPoWQmCZXHUDWDnlAEqvpsjPzWUCm5mqrTXWVIeyecfQ
 hRyv2oQQcDsC+caCMu1Glv2gRM5Zk/n9XxHmEX5JenWNkknEFZVzUnlO+RQhZtCgBjPbWtkfjKT
 orfeniBpOKX0R3SwgjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110035
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bmTz/gaxPjmrx6AjnSI1gWgNkaAmvtrs/Q+kgA7lRM0=; b=mPeMf27GpNaqX7A4
 M18dANWrkwiKzmaZzawiIkG2iDPbLMgEcnPMb+hGUzWV8sHFZyzSeN4i6XXSymYJ
 QKCuWGL1Q17UG4a+88Q/GnlYV+Jn7Gp3SIkwo4o+6+stYqGCnfVxr0uL+bLuoCUB
 +UxGhe4v8d2Op600ZeMh8bNAVn9a4r4BCCg46dZoNwxQ50LK2Sn+dhf2ykGI8fWI
 OXCpedyCOTDlUokrEgvRGF23abvz7bVkpynAwuQyjUCM6e0q83TXYe7zX0VSAd+t
 ghQqk+XbEbTwfX6iWP0iIdpUC8R0z0vlUHKW/ONiiJ7ooNh0/AD+nFYuY5DBWexg
 98zenQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786422478; x=1787027278;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bmTz/gaxPjmrx6AjnSI1gWgNkaAmvtrs/Q+kgA7lRM0=;
 b=fdm3YkOE7cs/gw5ueNTgPd4+5ZLrqoaTlQu5mKKjddiLlwad66e+Ek15CnlUpq0jPD
 Z7KGIUUG/z7gsWqCn+XfSpIZgoiJZ9iyqnmQxNt0PpLHhhI8o7iGPYQQWEpy3YvnPpy+
 KsGm3/W7TTxUW/ifwHNzBOAsP0RZQHe9+w6u9bRThFXWToe6H4y9afbhUdkyCufFTT80
 BJ3iacuw5XuY4eU3gs7Dpj6iFxTEzmPADDMZH+GFVaSUCwooZYorDF8mbRm+PyMi0caY
 awpsbtnJnl7XIpzS+pDzOsgYv4b7VMn2kw8wRtaVZfcBKWfyWshloI+shOQKcj/Rllbq
 aZCw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mPeMf27G; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fdm3YkOE
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

On 8/10/2026 11:46 PM, Tom Rini wrote:
> On Mon, Aug 10, 2026 at 03:04:53PM +0530, Balaji Selvanathan wrote:
>
>> Before commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb
>> reservations"), boot_fdt_handle_region() filtered out -EEXIST and
>> -EINVAL when reserving an FDT memory region, treating both as benign.
>> That commit added the free/reserve toggle but dropped the filter, so
>> these now print as errors.
>>
>> -EINVAL in particular is expected: when a reserved-memory region falls
>> outside the available memory LMB knows about, _lmb_alloc_addr() returns
>> -EINVAL. This happens when a carve-out described in the kernel DT lies
>> in a range the platform does not report as usable RAM, so its
>> reservation fails with -EINVAL and prints:
>>
>>    ERROR: reserving fdt memory region failed (addr=91a80000 size=80000 flags=2): -22
>>
>> on an otherwise clean boot. The region is still described in the
>> kernel DT and Linux reserves it itself, so U-Boot failing to track it
>> in LMB is harmless.
>>
>> Restore the old filter, scoped to the reserve path: print the error
>> only when freeing, or when a reservation fails with something other
>> than -EEXIST or -EINVAL. The "free ||" guard keeps free-path failures
>> always visible.
>>
>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> This is the same as:
> https://patchwork.ozlabs.org/project/uboot/patch/20260627204851.1151419-1-jonas@kwiboo.se/
> So I've added people from that thread to this one.
>
> It seems to me like the last message there wasn't quite everyone being
> in agreement on the next step, so, what is required next at this point?
> This is clearly a problem in some cases, in terms of "scary" message to
> the user which isn't meaningful.

AFAIK, lmb_alloc_mem returns -EINVAL for 2 reasons: a NULL addr pointer, 
and "the region isn't part of the available LMB map" (_lmb_alloc_addr()).

In boot_fdt_handle_region, I think we always pass a valid &addr and bail 
early on size 0, so the NULL-pointer -EINVAL can't be hit from here. So 
-EINVAL could only mean "the region isn't part of the available LMB map" 
in boot_fdt_handle_region.

Maybe we can give "region outside the LMB map" its own return value 
(-EFAULT) as Rudolph suggested and have boot_fdt_handle_region() ignore 
that specific case (to make it more clean). That seems like a middle ground.

Regards,

Tom

>
