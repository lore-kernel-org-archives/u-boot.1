Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150DEC531CC
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 10:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E6080D74;
	Sun, 26 Jul 2026 10:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q6SFA84ZzlyW; Sun, 26 Jul 2026 10:06:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0989180D5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785060372;
	bh=LDBT222JkS9KB1S6cBs9AaJaT5aIr7lGPGc55byMmAc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pLMACUV/7meFa91JFbiwy5ZujAQiVTKHuR6yO6cUOszMlvYg3KregU32tLihctHt1
	 ryAYdHUeQ4Tt3fXAXB1T+qe9ZlHaiHrRODi/KVHw58WLkFDGU4UGj9gB2LflK8U636
	 r4rx+NLLp9wdAJXi1WiTm9oNgEtCwy9L/Jr+xIEyeKBmAt8U+8GLTcU3QXYjGc18GW
	 vsFCkKbut/xzH/sj1Ajv/CcN1c5xLa3g9jFZc/9l/74hVWDiQpr8RcJl2rLmIUlM92
	 I5I1c0/TzOXad4QAWOExyrF5S+8Nt4OXucd8IDZsyuhBITycWL3msfuanru3ctsHSJ
	 74QEWSNg0WBTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0989180D5E;
	Sun, 26 Jul 2026 10:06:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DCEEB3B1
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 10:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE224405ED
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 10:06:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFqnuGJVdMZa for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 10:06:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AE451405E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE451405E6
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE451405E6
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 10:06:09 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66Q8HbWf250974
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 10:06:08 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmn7van6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 10:06:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso31912425ad.3
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 03:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785060367; x=1785665167;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDBT222JkS9KB1S6cBs9AaJaT5aIr7lGPGc55byMmAc=;
 b=rcrzrpsLWCjin71kmoQpn+FXiCZAc6GStuivDWcnxV8CqTxaTm6oSFNi3hUS5hkL9z
 FPkOlFoMXEdv40pNJVADGSt5G0FSOc8egttKrLN4xkLkUZTjawrCDorxrjEjLx/ZCoug
 NtZzwb5zG8Q5RMcmCTPgiQW8jxr+ada1B6y/aSbyn/aIVNmSoqvfdjmBWAkMDle3/4AF
 dWZtnvVuindsWJ0H7VoesUiFj8SFxso80ISlyUlEEv6KIpGsOrKdSqedJTEFI4w80d6x
 ih1EYnvwPkFp27dCuFdn2lpc95fRJwyDDbkeR+BFjpQjxLz5onjToSlAknNqsd4Pp3cQ
 wEMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpp/5thn4apnpfqxezh0LOnkrO2cUbQSbxbtLIECxAfVbFsjRU2uUTbZm+Al683BorChCeUa5g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwdSCeIXVyCjUYxdtxGDRxbc5bdioXHDDNMF79Nk18DnbvT9skT
 lRF1UbBmfz4BoA97CGBluFf5K994tD8WyxGQwUa5UxlmErGRziQc0aKihs6NrMqBMGjD4nTwfbD
 QBUarpPb3ShEnqIdOdvrE79r9Z7DQWGlm/1ps/OZ8LHWaZPBVmu+BL4MwCiL0dDqdWJGqZeI=
X-Gm-Gg: AR+sD13sUlbrICLV47hzmNCX0s5llzFCPw3Mj5to9DYiYA/GgsxlGSJypFJsEEYC4Ib
 THr9syGf39w+Sm6S4FArTzo51oghPOwTKh23F7ZRB3eDKU7JQm950z59GKJAoalTf97W8TYaXCi
 3Daw7p4Vg/uGlhwQBGugnsYyTgz7KMedrwWpP2kwcboTqj0uFh2R0O1la5+HspMOQEnUhOevmEk
 KpjzotPpKP4kSKCR9Bzd7TpJoX+4Duk4c9zswKRBsEQgBBRCWf0S+UHVWtsG5iKWrdX90MErygn
 mngxr/0DpyIV35SmYlUl2A/l1FKkTxsDuiV4AdFO9VSV+60BeXh2uQAGSIY2DeSzFFDzM3rHsBK
 GeNsRvO8GZHg364mI2SNVGo41fyDdnzo7kjTH
X-Received: by 2002:a05:6a20:a109:b0:3c4:3454:38a7 with SMTP id
 adf61e73a8af0-3c67dfa0021mr4050482637.54.1785060366606; 
 Sun, 26 Jul 2026 03:06:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:a109:b0:3c4:3454:38a7 with SMTP id
 adf61e73a8af0-3c67dfa0021mr4050465637.54.1785060366165; 
 Sun, 26 Jul 2026 03:06:06 -0700 (PDT)
Received: from [192.168.0.5] ([183.82.25.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc57ae17sm16934596eec.22.2026.07.26.03.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 03:06:05 -0700 (PDT)
Message-ID: <28f8341f-9ba8-44b2-86e4-dc47ab66d675@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 15:36:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: usb: dwc3: Add delay after core soft
 reset"
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
 <66ed1858-c0f7-46e9-86f7-8f2e562549ae@mailbox.org>
Content-Language: en-US
In-Reply-To: <66ed1858-c0f7-46e9-86f7-8f2e562549ae@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6a65dc10 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=stvG6kK2hsnlgaKUwms9QA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=iVCiSJhmkHKNVvhTHvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: lVBfYISsl6Xrr_vlcBczgsST7VK-Ot-e
X-Proofpoint-ORIG-GUID: lVBfYISsl6Xrr_vlcBczgsST7VK-Ot-e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA5OSBTYWx0ZWRfX3r5hiHfM7zRN
 5tYsGtMBjRUuWExApKNHhjZ9zMPkvFUZjD1VlxEB9eLpJrheNV4Gmbpks1NWYURwa+lGTN1wzr1
 FA2mdQkm3mSYrfchIveqspRHCDC0/4I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA5OSBTYWx0ZWRfX8n93Udy7oEqx
 yzKMnp8wPz+WPUU+xSTOJOs7IsuyB37NJTOCdKAmnvsKlTqDd+0r3zuvaQ1hJub78V2LAUe01e1
 UJbE3lvWNH8l2Y2+ct66tLxzIEMhCuT/6+8NCbg+a9eZWdPR36tWwfspdV43QFF/CKHo9+mSHvv
 CR5K4VrKvoZGj4nuGPAxGikbN3zvbdVppw8G6+o7tnU7ymmtO7ZXPaj/QmAZysiZThX5ft0KGPr
 jXT5zpZRiBwd3aaq6jvSNzOaZjolZ12VEBYgyRID+X+Ez7smVwPqDjPIH9Rqa6MvCmPIqtEN0uJ
 953XW7BHiqNnMyElHyHr8ZASBJhW5HImpoUqH5/i6jTb8nyUehx79lXsBDOiihYGBxKK3mi6TcM
 +xA+kQxtQEqg4y73mjA5c+YeAOJ5NHVe4RNjosZOkZ2gKglInuH3AgZ2QaxntWrv5R4qp/zNaUD
 Ohk17uNx3ugu/YxqM5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260099
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LDBT222JkS9KB1S6cBs9AaJaT5aIr7lGPGc55byMmAc=; b=KjqLLK/RhLMlkx/m
 Bw2f7u55goctH9Wu2o6FzR4PuOPok8N67I6z/LSWxJDWG+RDzWJYPEPPGXq3zrTM
 /pp5fmPWpGG33Ou2PC73ypCebbCb3SundOclwBpWmwTtM/JaRyJ/BUUO8qQ0QWmp
 LJXfks2ID37Qq/YeLEUsrcq7LB/LZr4j31E9RPQ0hUGcOYKf/Xhe3OOm4O15EoS3
 NRLGMtTcuo83yYfKo8WS+r6fY+6hFGNiGRpjxJXXK9MkyTc27Y+a3GjV4ksWRdiU
 XbhU7+j2rSB0P31/kjOdXZlU4GRXjN1IfYoT6E97/N+HjZehztwosyXLx8xMog6N
 oIvIpQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785060367; x=1785665167;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LDBT222JkS9KB1S6cBs9AaJaT5aIr7lGPGc55byMmAc=;
 b=LN7XiwFPhB7EdQQxfSdP+Y4YjOPnomlrVqhwGIZcK1/M0QoLNZt0ENVmtuIvgwO+oy
 psVABSKqrYzbmL4xG5T79LWNyGK60UkITFLPfFyzy8hCkL9dJoZMf3cAvLeMV3VtsGAE
 g+cTLS8b6j0CRBTO8XMMMj+KIxdCsQabBVOwH89avpWCqioh6G9Qvks6vQO5GolGhtMb
 iSpY7MwRGGZl6a4xEQILbJarmxU778vdEKAcOr5PF+MoXBT+mrBRN8shpztwjbbsD/kb
 orXHgXdVOmFNy9ZIay1PPOe7XMiiUrRiIgcfMrgOowb3SZCtHO7FmJz6RzAg1Re32djo
 Mv5Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=KjqLLK/R; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LN7XiwFP
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

Hi Marek,

On 7/24/2026 6:11 PM, Marek Vasut wrote:
> On 7/24/26 11:28 AM, Balaji Selvanathan wrote:
>> This reverts commit 6de333b5caf035c38d7af9fa7596aeffcc49db42.
>>
>> The delay is unnecessary. Upstream Linux does not add this delay after
>> the core soft reset and the USB works fine without it.
>>
>> Tested in QCS6490 RB3Gen2 Qualcomm board.
> The reverted commit states this:
>
> "
>     Without this delay, USB initialization can fail on some Qualcomm
>     platforms, particularly when using super-speed capable PHYs like
>     the QMP USB3-DP Combo PHY on SC7280/QCM6490.
>
>     Taken from Linux commit f88359e1588b ("usb: dwc3: core: Do core 
> softreset when switch mode")
> "
>
> Can you test this on one of those two listed devices ?

It's tested in QCM6490 (another name QCS6490). USB init works fine 
without this delay.

Regards,

Balaji

