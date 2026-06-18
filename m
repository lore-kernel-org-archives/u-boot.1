Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3A8CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 10:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA818460E;
	Thu, 18 Jun 2026 12:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7aTB5HR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="geZLevsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8890C8499C; Thu, 18 Jun 2026 12:42:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1295A80287
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 12:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8x2j8722620
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UTHqzA1IDfZR+ao10s1vDdz8Tb4BplaiYDdBEksbQ8g=; b=m7aTB5HRiZgRX3Nn
 X91Zh2MmDlQbxjVz1r3o9oapjxR//uV1ypJ226RFaW4Svh0iyRcJZHAV+JbDOetr
 71audVPoEPqq3bu/Fua1zEG+cit1k/3aZAgIxI5aQQ/UfZvrm2GgmHeSck1FJPBu
 OrWHNdJrA9HX4Bq1vDvB60SXnUzfatSjbDOt5FW3FENudlC9eqYAopS3uKaOi9t5
 /hNQp4TY2krdZEAOBXtxtzoiCIWhPZEDVK3gwmA16g8i5L48fJ01uNtx9le+cRKL
 SQviQ1SQmoJEFJDEprgiNFXtuFK7BKldgC86UOEmz/TRf9peV27kM8RJ/tn6tGjo
 kQ3R+Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn40bpw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:42:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-842208d5b0eso540525b3a.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779324; x=1782384124; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTHqzA1IDfZR+ao10s1vDdz8Tb4BplaiYDdBEksbQ8g=;
 b=geZLevsCJl/pR5EeyXc+KC2ejP/p2/aGXzke4NKRYryHUpSWpJiefjr805qO5bOrxl
 5oklMyM2cINrJ55MAWvvGtIEVfORdGWr3JbTUomx9TS4jqXIuoG2qa+vA75kK6ubyxWb
 +fMkzP11gG09L2omfEdEICSEhG0xjVF1wd5HXyoB5JlJ547bAPJDcVrPNZN8tDBKDJlG
 SyOs5lQ1yp3Suz9qgX74T28598EVcOY9vKXaMUiOxTpiLYNFFBzaB/GHLuhAJyUgWgiN
 fR0Zlt4UdLSTSfOFohJPRWJYq22DU7yG4gNcNOk9I2TEKZ0dKekHpVLT8V99wsnCew+/
 ETlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779324; x=1782384124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTHqzA1IDfZR+ao10s1vDdz8Tb4BplaiYDdBEksbQ8g=;
 b=lXV+s9eFVCX7RXVoVx4d06v30ah/6tagULeF0kGDsHJctS4Qjr7WOwUqDFCEobimHS
 xQJ9oWeji8k9E3o3m3++BlF7Mowbmzw5Ta4e1Q6u8UYyJAPtl3FuRDxrpjqpWerHlPLI
 hgxgx+syh7rwYAi6tDw9flKTz+9hDrS3wryi7gcYi/4jxO1uXZiVcZBkH7d0RGuEf87K
 P51gDiH9csfsmOQ6CL2NLjtEyJFZZydpDcQPGYsbN6FSLyJR4NNtj3Tmcj7JubXF0802
 zAWKB2qwpGpoy9gPPxCgqQNB99t0iDuelgFbPlAAzaSGYYlD9J9HXtm0Tf86afdiHgwM
 AEhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92i8f8i9W0J+d+TPx+xbXOP6VTaVvzyigwVbasv2XCkn/zxdWXdRXN5+ugK0mXMALRI916MlQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr+oG64plo17ctTpFGJeBGs/hxVFnKo2mty90uTyiNom1Oz49d
 pL+drtUw1c1xVXAK7VdFI4lrWuHiiwQWA/szYMBIGhmuKGFJ+yH3dqfNOr5sbFBKkSGp3esuvI6
 z6C0TkrfnOpRSzAufon1wtJFt0kOlhfHY8dpZyeeSsDtojrpVUhlpJCPdxSUaDQmIyAY=
X-Gm-Gg: AfdE7clqXHNZY6MXPRR9S9US+xV5NvXJ1l1BZ76uU6cSi7rldONgrLaAIRNedrmF4jz
 EuxtI9NpzD9ynybbDRrhFkwLuBQz9Y11sEg/gXN6hpSRIDo6heDyZm1/0mcKA6fV2gwC9Sji2jp
 f5eXpRJHo16pN/nd7DMgRLxhsnC82iuiVkul4oKKOebl9GsKwL2DNoLBctlDPbWF99K04xTqmge
 +IAHtVdmev95YbzkxwNOSKryqLpp0CY3DVTlYQfQPE9FBX1JuEwLLYbtr3L9J7GsTmxHBsrTHqz
 Tz+cr+u2Kf0qi92FCQM1QtB5Iw+j3BxYZxrlYE9JpgvdQpamqPZnHHDjaRe1g/XLmuQgg2evLj6
 zA3XdyRhswQgFli2AdDiuMBbzXGs/hTw0Fmsa5gAhJFFvjT4/
X-Received: by 2002:a05:6a00:4218:b0:842:7992:bdc5 with SMTP id
 d2e1a72fcca58-845247b84b3mr8547933b3a.41.1781779324272; 
 Thu, 18 Jun 2026 03:42:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:4218:b0:842:7992:bdc5 with SMTP id
 d2e1a72fcca58-845247b84b3mr8547889b3a.41.1781779323683; 
 Thu, 18 Jun 2026 03:42:03 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afc8fc7sm20663321b3a.37.2026.06.18.03.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:42:03 -0700 (PDT)
Message-ID: <c1a02c92-3df6-47b6-bc92-8e1c721ee36d@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:11:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
To: Ferass El Hafidi <funderscore@postmarketos.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
 <tgqh8m.i5334p2b63jo@postmarketos.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <tgqh8m.i5334p2b63jo@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX0mmAKwqfXIeC
 1ygMwLrgGyelLrTBmfOQihvFGmKyrYcgTEwQRsVQllXK/l6OBB3gFTuZDDqjb1skiR38jjRUopL
 HDRDPjPLGCqerKwK+zWyi/EzXMv8Sf5+55g1+8jI713tR6jNv0t0oFqAdfRo/0kTuOVNZHllsFI
 7k4YE/SZn649rUgrKhSLtrgE7kzAWxK8EK616CxWeKKEND7/Qec6fHguOUdT86v5x0hsFX7FPGO
 lHVKVZUWXk8l3yLDpMSQC/LIFTW2URoLOyuOANK/wDffKhsOblfpNHtOFQkI5CclvrhBvUJpRG4
 C2fZeltHUCFOM7ZcHd+GDvR6Og00SW0R4+Kfs0su7ipm3PSTv0U3EzDagooop2Oe0oVxV6i5S3K
 ZPyys5n/XTyAlcL5B5UjxzOzCj9awtl2km7LFhO4DyaCys7BD93tUdK1yUK2CPC9Q21yDOL4t4P
 ssJdD9V6GSdmVTEQtgg==
X-Proofpoint-ORIG-GUID: JeYIJrUIOD7yNYb2JzHvwi1G4orz8EMv
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a33cb7d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=l0xRoyPhJoKGvZmW1_8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JeYIJrUIOD7yNYb2JzHvwi1G4orz8EMv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OSBTYWx0ZWRfX8Dfs6fymPePU
 finn72A5U5SgT+VsnMYHZXJlCeu5XvB+7MemlAqz8qj7ILRBu2OmTYkbhu3lSYML6GgkDUiR55J
 R5POA4Z5N5JeNuI5uUS0Ah7ANP5/zFg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180099
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

Hi Ferass,

On 6/16/2026 10:12 PM, Ferass El Hafidi wrote:
> Hi,
>
> On Tue, 16 Jun 2026 12:26, "Casey Connolly via groups.io" 
> <casey.connolly=linaro.org@groups.io> wrote:
>> Hi Balaji,
>>
>> On 16/06/2026 11:22, Balaji Selvanathan wrote:
>>> This series adds support for running U-Boot in snagboot mode on
>>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>>
>> You didn't respond to my reply on v2 of this series.
>>>
>>> Snagboot is an open-source, scriptable flashing framework that provides
>>> an alternative to the proprietary Firehose protocol for device
>>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>>> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>>> and execute bootloaders. However, instead of using the proprietary
>>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>>> standard fastboot protocol for device flashing.
>>
>> Glad to have some more info here. Please also add a doc page with this
>> information as well as a list of supported platforms.
>>
>
> I suppose they are talking about this snagboot: 
> https://github.com/bootlin/snagboot
>
> But what's confusing me is there is no mention of any Qualcomm board,
> nor any PR to add support for it. Is that in some downstream tree
> somewhere? (to be clear I'm just someone interested in understanding
> this better, snagboot is a very cool project that already supports
> plenty of SoCs and it's great if it has or will have qcom support)
Sure, will add more information regarding this in v4 respin, which i 
will send shortly.
>
> Best regards,
> Ferass
