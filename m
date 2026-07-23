Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C261BC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 16:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B1DC40A86;
	Thu, 23 Jul 2026 16:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rr-NOk3TbyFN; Thu, 23 Jul 2026 16:43:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D85F040A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784825016;
	bh=pH6I7TRJ1NLfGqm+r/DC8yn6eEHgUtWZhEie/RCPl0E=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pRr1ekRWdSvg9bBVHyVpM83WAvUDcJLDDtPcV2Qnttgl2Ke/xE6lF4jp92Ii71K7m
	 21qx8dNKHm4VQlbxyvAb3achYPnVkR6MjcEI3V/cVDhx6lvDvSFbV5an8PwMujqwJ5
	 2aXJlDfA+1EG06cF7rbdZHYmfJZ08LRNHnU/pWLFl6pEe9ziC5y990uodQz+7qqe4n
	 lq3wUhhQLnvCINBq0wG//ZoesbOW8xi7FtEQWfWC0USgGxptscv1yvjJLr3VEKUeGW
	 VTSN6dVhiqisB7QA+OH55uM1+5M319qE4JihQChV9NV4qneqQwwZUX8n6uicQfD/Dd
	 TVhfMcRc3gK9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D85F040A54;
	Thu, 23 Jul 2026 16:43:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C35314BF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0D4760A4A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GEycLgJwE4Hn for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 16:43:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1D71E605D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D71E605D5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D71E605D5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:43:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BD080287; Thu, 23 Jul 2026 18:43:30 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C249A800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:43:27 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvn1P011757
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:43:25 GMT
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayhb8y7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:43:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c7f385887bso17106955ad.0
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 09:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784825004; x=1785429804;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pH6I7TRJ1NLfGqm+r/DC8yn6eEHgUtWZhEie/RCPl0E=;
 b=HnmCZ//gWp800iw84K4qtBTZlr3fUp1ioBXGJAt5shshpVkcxneE3oICGYvUFiJ17b
 MSTgi87kAdP8rNfIKTB6QO+AUn/z91nPqkAb4vFlfTk6Zww6BTYIcqcTYDVHN0kHlF8y
 ri+/EFy3MQAuw7AGkYNDocFjDucqBtt13QWOENK/EjvnJ7QM+f6Hfh/kkz324vBbVJVK
 cr1zEL2q35A/HIrjJ0VcO342h6bjhY8ochLdbbxmgBVKJZ/AA5MsuIv6E1z15nmCKRLt
 UnoYhIz6a96Oc3z8q3oh6GIjqqg8aCwDH5PHyXMWvDvkma5kui+316wi/Y6Gaj1ga6jW
 nDnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+Ud5kKptxAgtKV4lG8xFI6/xdc4JQDWizpkuQZ0Drs5IiOMnbSvwbTQt2iyAujSGQu5WN9pY=@lists.denx.de
X-Gm-Message-State: AOJu0YwOkzCsjVbWTkif/IUtCsggegFcE4nFq30GN34bkqvayZ/VoMeq
 7I9vBcxqoEyk/1GBVt5vZrQuoXHixM+FjqZA3TqoKCIZQsMq51wUBnwEN0ZAtEixv5FIQNIKdwl
 kGszebXv35nGXErZ6o995WLU20LKcV9kW87FQqWt1cPAPVH0jZMsMO8zg
X-Gm-Gg: AR+sD10OLUAbIQ7NVZXkDWwQkiWWKLn6mlbEsl/dMQkLIeD2NhO4uzefepAp6AH7RIA
 4lYZO+xpYsGZAgkOmdOBdsytrDZUEObIv9UH+wzKacgvpmOdmHrqCm5rDkLM1zkedpUpMEmK0wm
 /eLjGbd/WOJDSPCxqstuDtx4XnWIqsMg1Vxs1Xez5I2DZ48mRRUhQZ6ulWdcNxAMXGYFXywsCsJ
 l9RwcNbTHROEEyq4hFWL2J1kUbOAHSrN/dZcq0QWgV2YLEvObFPZzuE4Q3sxpcF9YCjEgmPvR/C
 LFe6Huvzig+xL+t+SKJRsRXTGBR4qfwAsx6HS/7v3CG9avWe0lRmEf7eJu6pVxSE31BC7ehcaEM
 aq/AXW131IUoYvcY2oHxpF5xpD02Pa0JGpNrV
X-Received: by 2002:a17:902:fc85:b0:2cc:98b4:e7d7 with SMTP id
 d9443c01a7336-2cfa6f8ef8bmr52104935ad.45.1784825003646; 
 Thu, 23 Jul 2026 09:43:23 -0700 (PDT)
X-Received: by 2002:a17:902:fc85:b0:2cc:98b4:e7d7 with SMTP id
 d9443c01a7336-2cfa6f8ef8bmr52104465ad.45.1784825003052; 
 Thu, 23 Jul 2026 09:43:23 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.206.17])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df0ba0asm19911911eec.18.2026.07.23.09.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 09:43:22 -0700 (PDT)
Message-ID: <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 22:13:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
 <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
Content-Language: en-US
In-Reply-To: <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a6244ad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=okWHlFwwgSc0V2PvCYU0RQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=dw0t6H4-AAAA:8 a=KKAkSRfTAAAA:8 a=dttmaJee0PmIuaMyIUAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=wVJa4CU9-Z26yuRAZDil:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DbDZoRJvpcq2G19jrpDnTQNSh-gpOGMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX4o3Fr0T5TBZN
 hHtMIEhBZ5ynTN9A4s/0tjM8nMB83e5rFH0byWHE0T8NmCMAjULC6kpOD0oGrKpRWLfbXjPz1jI
 nbuQjI6WcO2GqRvRuZqxGk84bZlsval3uWOaGT0QOupcmn3gWKxrilhDy3NZu9KxNdGBzDxhtwf
 Le+L4bfJb7IKQcMKsljEvLWQ8VRAdtY5usgNHSFRcUU4nDoV3xGd2m3Q1fp9jwOH4g4gl5NeGfH
 hliCQQdMJYJwR7mtl24kNBsgnMFngJ5sWaUfUqubce6WvtF48Pz4ehENRpRizkfcRxLm1RnZ5Xw
 X76uUJLRzYs/1jvZMUy7SNfvo2fTinaZ/ZmDvF1v4k8nz89qRaBdTKHqIcqh1mwx82prPCeEYod
 7uVa324J041oNwudCsUZSRjpQtd0YZzmo3sTCx1fwl7DLoJd60s8oWquK6c+qbOV+haROeV4EYg
 0RcNIdBIq2Ux8l/uP6w==
X-Proofpoint-GUID: DbDZoRJvpcq2G19jrpDnTQNSh-gpOGMW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX46ky7hjN7JW7
 uKacvMvXXAcchZX/Qo9MfEtwKUHw8uYbYHzh9QpAr+r1ws73khqyBavj2F4gsWzZGL0hWIBYLst
 3CfDN1JdVoGMw0Fo9/vJ3HOWHNxo3UA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230164
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pH6I7TRJ1NLfGqm+r/DC8yn6eEHgUtWZhEie/RCPl0E=; b=J1R0ZyvDSizCASF5
 oaLLevkedc4+/2mPoiMJHSfzOTjxgAzwGiE2uGyd3sevGFfDAa0rKjwrK930Fe8g
 yNucykCtkKPtTa4V2pSJsoUA0vhGuQgivssivnfXy9CXKEfZBBBCYqIvHOSCboJ0
 2PgWEnVPFUC8XFcFAEcGP/MoO7tVOu+Z4Kvfo/+13852dBmYLJg4A4CQPTroYPpk
 EhwI/j8fW/r6T1c/qsf6Yc2IvNYo9mtRqyipIONUs/xP6LkbvTCCTNCve+xRVjsH
 A6X3GbPo6M247/aPlXEWjWYXPYmXdALEu/1S8GpFgcQNs6A/EsIZJAqf5Td2MaHW
 toNSug==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784825004; x=1785429804; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pH6I7TRJ1NLfGqm+r/DC8yn6eEHgUtWZhEie/RCPl0E=;
 b=iVRCFRoqjejXUaqHrLiHrP1enO8rZUwloJXschYOZ4xwJWWmvUJd9QRyzKzCuzurz0
 rXnsymQDCrBfE4AJxVQ2+ZT9JFlDBpMWH/jDaodWEf8QT3AugdMZqZJps5fVRhIf41S3
 eGVPzsItRTFKmlpOCBBAU66iWz9SHGIxyj6EFvNm1IwjXQQaXj8/jCx96GZqypIkIqRu
 0zu0MNC2uXFy8LkWZnMy99KJweg1Gssk41ChyrodEIg8qg2xaHqPDDE+VWjIoBLCWF/+
 6bJsD+m5jUVI90RsUxCFYEqbikMH6f/o6vNFMGISA90GZJYv1UG9Rr/BKJaFSCwaRFoU
 gdzQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=J1R0ZyvD; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iVRCFRoq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1R0ZyvD";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="iVRCFRoq"; 
 dkim-atps=neutral
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

Hi Casey,

On 7/22/2026 8:19 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 22/07/2026 11:23, Balaji Selvanathan wrote:
>> Hi Casey,
>>
>> On 7/18/2026 4:19 PM, Casey Connolly wrote:
>>>
>>> On 7/17/26 18:16, Balaji Selvanathan wrote:
>>>> Hi Casey, Ilias, Simon,
>>>>
>>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>>>>> Hi Balaji,
>>>>>
>>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>>>>> Hi Ilias,
>>>>>>
>>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>>>> [...]
>>>>>>>
>>>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>>>
>>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>>>> There's an equivalent tool in EDKII that can produce a capsule with
>>>>>>>>> multiple payloads. There were also patches posted for mkeficapsule,
>>>>>>>>> but need some minor tweaks to merge them
>>>>>>>> Can you please point me those patches? I did a search myself, but
>>>>>>>> couldnt find those patches.
>>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>>> sughosh.ganu@linaro.org/
>>>>>> This patch you mentioned here can create capsule with only one
>>>>>> payload;
>>>>>> means for multiple binaries we need to create multiple capsules. I
>>>>>> have
>>>>>> also asked the person who made this series to respin, but havent heard
>>>>>> back from him.
>>>>>   From a quick look it seems like it would be fairly straightforward to
>>>>> extend mkeficapsule to support multiple images, the capsule header has
>>>>> an item_offset_list[] array with offsets to each image, today we just
>>>>> write 1 but it shouldn't be too much of a challenge to put a loop in
>>>>> here and extend the argument parsing.
>>>>>
>>>>> Given that we a) already use raw capsules and b) they are part of the
>>>>> EFI spec, I'm gonna try and save us all some time and just put my foot
>>>>> down here. A single raw EFI capsule file can already support updating
>>>>> multiple images, U-Boot already has all of the machinery for it with
>>>>> the
>>>>> exception of mkeficapsule but I expect that's something you can tackle.
>>>>>
>>>>> The upside to this is that you will be able to build capsule files for
>>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
>>>> Thanks for the detailed feedback.
>>>>
>>>> We agree — we'll drop the FIT capsule approach and move forward with
>>>> RAW capsules.
>>>>
>>>> Here's the plan:
>>>>
>>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series
>>>> [1] to support generating multi-image capsules from a config
>>>>     file, so we can build a single capsule covering all the partitions
>>>> we need to update.
>>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
>>>> supports a single firmware image (U-Boot itself) via a
>>>>     single-entry fw_images[] array. We'll move to a SoC-specific,
>>>> multi- entry fw_images[] array (defined per board, e.g.
>>>>     board/qualcomm/<board>/fw_images.c), so a single capsule update
>>>> flow can cover multiple firmware components — each with its own
>>>>     ESRT entry and FMP image_index — instead of just U-Boot.
>>> No need for this, just build fw_images[] on the fly derived from the
>>> partition table on the board, with an entry for each partition that
>>> can be updated. You just need to add a map from partition label to
>>> fw_name string, starting with the xbl/uefi/boot partitions we already
>>> handle.
>>>
>>> The entire point of having logic here was to avoid per-board stuff, if
>>> you're thinking "ah I'll do this per-board" you should immediately
>>> wonder "but can we do it dynamically instead?".
>>>
>>> Thanks,
>>> Casey
>> Hi Casey, Ilias,
>>
>>    Thanks for the pointer — agreed, building fw_images[] dynamically from
>> the partition table is the right call, avoids per-target code entirely.
> Can I talk to a human instead of an LLM please?
>
>>    Plan:
>>    - Keep a fixed table mapping "partition label → fw_name + a fixed
>> image index", this mapping going to be a superset list for all the Boot
>> FW images supported in different Qualcomm targets.
> This reads vaguely like a rephrasing of what I proposed, not clear if
> you really understand it though.
>
>>       Sample table:
>>
>> ┌──────────────────┬───────────────┬───────┬────────────────────────┐
>>      │ part_base_name         │ fw_name                │ index │ guid
>> (fixed)                                │
>> ├──────────────────|───────────────|───────-|───────────────────────- |
>>      │ xbl                                  │ QCOM_XBL │   1
>> │  QCOM_XBL_GUID                  │
>>      │ ubootspl                       │ QCOM_UBOOTSPL│   2   │
>> QCOM_UBOOTSPL_GUID     │
>>      │ uboot                            │ QCOM_UBOOT      │   3
>> │  QCOM_UBOOT_GUID            │
>> └──────────────────┴───────────────┴───────┴────────────────────────┘
>>
>>      Target-1 supports xbl and Target-2 supports ubootspl.
>>
>>    - At boot, scan the partition table against this table. Only
>> partitions actually present on that target get an fw_images[]/ESRT entry
>> — nothing hardcoded per target.
>>
>>    - The image index for each partition type stays fixed and published,
>> so whoever builds a capsule (mkeficapsule) always knows which index to
>> target, regardless of what's discovered at runtime.
>>
>>    One wrinkle I want to flag: today's SetImage() path assumes
>> dfu_alt_num = image_index - 1, i.e. it picks the Nth entry in
>> dfu_alt_info purely by
>>    position. If a partition from the middle of the table is missing on a
>> given target, everything after it would shift by one position and the wrong
>>    partition would get flashed — silently. Since I'd rather not touch
>> that logic in common code, my plan is to keep every fixed index's
>> position in
>>    dfu_alt_info stable by inserting a placeholder (U-Boot's existing virt
>> DFU backend, which just no-ops) wherever a partition is absent, so the
>> position
>>    math stays correct for everything after it. The missing partition
>> itself simply won't have an fw_images[]/ESRT entry, so a capsule can't
>> target it
>>    anyway — it'd get rejected before reaching DFU.
> Skipping past this noise... Ilias probably knows better here but yes the
> way dfu_alt_num is derived from ImageIndex does impose a limitation here
> currently where we need to ensure the indexes always start at 1 and
> count up.
>
> That being said, it's already quite complicated to have to maintain a
> database of the indices for each board, and even more complicated when
> we have boards that may or may not be using U-Boot SPL (for example).
>
> Having fixed ImageIndex values for each image would then seem to make
> the most sense as we could just use fwu to set dfu_alt_num (or another
> platform specific mechanism), however the EFI spec is clear that the
> ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <= DescriptorCount
> as returned by fmp->GetImageInfo(), so we would need to also have dummy
> entries in the fw_images[] array so it doesn't really solve our problem.
>
> https://uefi.org/specs/UEFI/2.9_A/23_Firmware_Update_and_Reporting.html
>
> Currently, other than for setting dfu_alt_num, the only other place
> where the image index needs to match is in efi_fmp_find() which was
> added by [1] seemingly to prevent an incorrect image index in the
> /capsule/ file causing dfu_alt_num to be set wrong resulting in the
> wrong partition being flashed. In other words, we should be able to find
> a way to safely remove this check.
>
> But alas, it seems like we are stuck with fmp->SetImage() being called
> with the image index from the capsule file per the spec, and it is the
> only way to identify the target partition without doing other hacks.
>
> I'd like to get some feedback from Ilias on this, since adding dummy
> entries really doesn't feel like an acceptable approach to me. The only
> alternatives I can think of also don't seem great... Either:
>
> 1. Sidestep the EFI spec by either caching data in the call to
> GetImageInfo() or by assuming that the void *image pointer immediately
> follows the efi_firmware_management_capsule_image_header (this is true
> for us today but would be a fragile assumption to make).
> 2. Use the internal image index (looked up via the image name and
> type_id) as the index when calling fmp->set_image() - going against the
> spec.
>
> It's not really clear to me what purpose the ImageIndex property serves,
> since GetImageInfo() is meant to match on the ImageTypeId anyway, I
> assume it relates somehow to the fact that there can be multiple
> instances of the firmware management protocol, but in U-Boot we only
> have one.
>
> I think the other way forward would be to use the only included escape
> hatch in the UEFI spec with a custom GUID in the capsule header
> capsule_guid field which would let us have a custom mechanism which in
> our case could just be a soft-fork of the existing spec with minor
> changes so we can just remove/ignore the UpdateImageIndex field in the
> capsule. Maybe this would be the most correct solution?
>
> Hopefully Ilias has some time to chime in on this, I'm sure we can find
> a way to go about this that doesn't involve exposing dummy data.
>
> Thanks,
> // Casey
I feel we are complicating it by trying to go for dynamic fw_images.  

Rather than introducing a solution that diverges from the UEFI 
specification, shall we use a board-specific static fw_images[] 
definition. This approach is simpler, remains spec-compliant, and other 
vendors (like NXP, TI) have also implemented static fw_images (in 
board/nxp, board/ti).

Regards,

Balaji

>
> [1]: 7cf06f09cc51 ("capsule: Put a check for image index before the update")
>
>>    Let me know if this approach sounds reasonable.
>>
>> Thanks,
>> Balaji
>>>> Will send an updated series once the mkeficapsule and qcom capsule
>>>> update changes are in shape.
>>>>
>>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>> sughosh.ganu@linaro.org/
>>>>
>>>> Regards,
>>>> Balaji
>>>>> Kind regards,
