Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEACD711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 04:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E5783C28;
	Mon, 22 Dec 2025 05:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0gb7UcJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTVSVKxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F4C83D3C; Mon, 22 Dec 2025 05:29:21 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661B083BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 05:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BLNsKDl3918051
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9Z9cq0jioJIiMy0oDX95f8xj8kYQ1wGcJZUKxy8QEHs=; b=b0gb7UcJ3m0kN3Gv
 CXYNqG6PiU87c/HWP2/+P/4LRNG9wJRYinmEQfYrmdsJmYCuvscJ84DwEbcUAkNc
 IUn3YfiQ669TpbiGa7H05LNfP0tOOUw8n3hq/HSpgNx9q9NzH+a6Rh+wwRnPm/7h
 OEZhDyrlK67BOnVrOsJzyJ0DZ5WjBYg7NgzYev96/Vl4FtLzzFO5VRuJXjon2tik
 7KYveEhw5kvUzi0o4KrT8/DvwHGjlbAjZyLIs1JaIxSCZk08ODdiWd05yFZC1+tu
 5AZ3CWWooE9FMJFMAO3eVnfDLVzRvSXFq/82QpVImjw0kjkkb0PPKYjmar/yZgwH
 ufhrpA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mry3jxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:29:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a0d058fc56so59004365ad.3
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 20:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766377757; x=1766982557; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Z9cq0jioJIiMy0oDX95f8xj8kYQ1wGcJZUKxy8QEHs=;
 b=ZTVSVKxk/Y5izZDBI6cgBqmYzK3GAUrlzm56V9HxXO+vXlxtWeprn8jplepl2/ts/L
 p4CBsrl87vvOnY5tGmH0B5Bt5Qv2JH6sauU0rVFbPiNmn0HNgW3W160smarthREgQ1M5
 niATLWvWcAlb2UiM8TXmVqXmzUcauhfLSH1OaPvpyz54uN/8LjAAiZJJoW2Ws526h2p/
 JxLb2JSa7sd9IWxUnNGPyV7v/4PBLlT0Zi39x72Z0/BDBs8Kog4lXrA5ehzGPVF4aPcG
 mdbpDYQXB5KipE9WhsNwKOHPcU66k6GdyplOOowtP4HGTY0y2xeTTyFvyWRceHPh6soi
 hR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766377757; x=1766982557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Z9cq0jioJIiMy0oDX95f8xj8kYQ1wGcJZUKxy8QEHs=;
 b=AAfE4cSg4CLI6j6akcQ06tCMkwaqlGYYQleD1s7xv5nhFRk0hQrn37+Lvcou8crCk7
 /+8UKWjzdiK1vcM0DlbGfu3PZi0pJwQeBc8zCwHizmVxULLIMloX7+vRrI0Fzl2q112o
 XoZsgBOHyFEltrFaboJMegYDrU6tLQN6T5wAsATLDyqyWIp/xOzCH10+3EvvsR0rXLHN
 /G+FeivEtAnfFRS6iWL39ns+tuUaMOTEdXUb9/hMgmmzx1ft0JegkYFIuFdBPV2phqVW
 +r9UemCqxHPDYfUqwY4aulGKbEUS0NhmA6r4RaEpoHzJ30RvgodXTd5xkfq7ZP7ybV/X
 LPTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVai55KhCbHZ6jPoTeXei0znO7vcRmM2skwCc2dTtiryaO3+hwvP1DDoJBhz8gVGgMKl+1Zmbg=@lists.denx.de
X-Gm-Message-State: AOJu0YyM7r8yPsNdetJOfgikpprStW3tX5RC9WUtfZ45Sw5KW32I/Z3x
 uccSBPa2TeyaB1C0/DhwHhSkRt7XZN0GiHYhkpZd6wmLmKzxf/EP/JjgIpScUW7sexze4ncee0r
 fq29GaWTFEOTzAhcyWYklBYC+6YwaHGfKthd+/++xA+wPdjz7w0BxZW2S
X-Gm-Gg: AY/fxX5/EUkBg3w/FBcyV+RTVPSKaoXj8bwSIMATue5ZFwdDnVFFK4NfNvFRyKl0klx
 Q3lTGAya9Ij8Rze9kqKiP7uzPiF0sxd5Mt6c7M+AukFjyLW+o4w3VOIvf6OLIfKIOeAoDEIBoSI
 XA+nIN8agESFagTbwiPxsA/wuh1qs4DAdjeYuFSz+bz2DkdHvSeC6mY26BYULyo+c5CiO6qr/Lp
 nXSKrv+yqiPyC3ZC8vEA6Y+701hWfqzl4w667fVvfjSCHn1P3YhNEGL15So/uotA7iP4VbZvjrm
 1hO6nr+90m68ewhOR042RCN+vt2viipXywHsJ40ABuhvKN4WBi1uXFNRo6V0HKFnog1/yn257pb
 znZpMfQFHDrxhn1GDyHKcyEXmtQ2mPGVst0YBti5gQoZ6K6A=
X-Received: by 2002:a17:903:2b04:b0:2a0:d46d:f990 with SMTP id
 d9443c01a7336-2a2f2736e52mr105277925ad.31.1766377756796; 
 Sun, 21 Dec 2025 20:29:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwHLNccqS3Mz93qzErDNIcYQ8P8MYiHXMp83YK34F7NH4SzcH4eRGhZVbOWWeC/a2n+pPtlg==
X-Received: by 2002:a17:903:2b04:b0:2a0:d46d:f990 with SMTP id
 d9443c01a7336-2a2f2736e52mr105277695ad.31.1766377756171; 
 Sun, 21 Dec 2025 20:29:16 -0800 (PST)
Received: from [10.151.41.129] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d6ec60sm81614515ad.86.2025.12.21.20.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 20:29:15 -0800 (PST)
Message-ID: <9e7e54c3-d2d7-4c81-bb0e-d3d15bc43dc8@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 09:59:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat> <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
 <20251219162939.GS303283@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251219162939.GS303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cbbfb3DM c=1 sm=1 tr=0 ts=6948c91d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DnT_YvveSy5JIThyA1MA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAzNyBTYWx0ZWRfXxDcpWGl4Ge8v
 VqpQYfPPgqIJqWmAX5h4rq9gK/vlD6uW+gaMQ2miluAGnksqedfAEsiWyqpqkZCnuKN+A1OMXs0
 BkeMFfVEbNzKE5h7T1vXJbD6aYlYTKYZXDBR3AypIWiqUN6z6Hq123FtXCznvvbFVrnHf/92aWj
 Kr+mTkEN8W2IQqps3yGRlGPC8WTlNUE11vPRWV+vYFtcNkmgFopZit7iMcv44EYRip6dq3ZXfPf
 LO+CxM7Zwo5AnyiPs45bGIexBp54RlvD7eg2WTknU9czgxK+YZ65DVm1HZ27MEGf50tdOt2DfUR
 e5Tb/jKl6P01cp1yJobpS9/Oq9vBZSSZJXpYu8mvC7+s4gYCqhXOQOjRkayJRNDxTlZH8YOAhYE
 08KRnFBsZG0IPOkf6iKkCahJmHDcD7KFGJdsj/DoZ7PESEq0lzrnoQtj8H/pBjc1xWmMdJFpacD
 j1JnhF4uMciOy9Al4tQ==
X-Proofpoint-GUID: z5Rgl1d_Q_dnduXCp_kuREA8dlHwrzMG
X-Proofpoint-ORIG-GUID: z5Rgl1d_Q_dnduXCp_kuREA8dlHwrzMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220037
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


On 12/19/2025 9:59 PM, Tom Rini wrote:
> On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
>> Hi Tom,
>>
>> Apologies for late reply. Somehow missed the mail.
>>
>> Upon analysis, it seems the most likely root cause is Tony's 238GB disk
>> triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. Any read
>> beyond block 268,435,455 blocks enters this path.
>>
>> 'blks' is decremented both inside the 64-bit LBA block AND after successful
>> scsi_exec(), causing incorrect block count tracking and (most likely) the
>> data abort observed.
>>
>> The fix is to remove 'blks -= blocks;' from inside the CONFIG_SYS_64BIT_LBA
>> block in scsi_read() function.
>>
>> Hi Tony, can you please check with this change?
>>
>> Tom, shall I raise a new patch for this now?
> Thanks for looking in to this now. Yes, please post a proper patch for
> it so Tony can test and add a Tested-by if it works, that'll make
> pulling to master before release easiest.

Hi Tom,

Have posted patch for this: 
https://lore.kernel.org/u-boot/20251222042533.2024310-1-balaji.selvanathan@oss.qualcomm.com/

Regards,

Balaji

>
