Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0932DCFD318
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 05:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E86C83BF1;
	Mon, 24 Nov 2025 06:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mG5Bj7aM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhqqYRhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C6DF83C14; Mon, 24 Nov 2025 06:22:29 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3995983BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 06:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AO0MoO12193127
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pPy8h8U9GzDzvObMnFOAN5hH04qgnv8YUO1Sb8gbfpg=; b=mG5Bj7aMrk/mi6+g
 d055T/VLZ2jGtfQM57rrkjrPCsCFiZjJ6IbBecaQmp4XdCeNRP5uefq2ChEYYmd7
 9o8nFTHMHyTSwLoBGfNXoYGQkJvaRJw9IS+d6QRmUj6+gJ3pYkrCBkdpoMTIpOm+
 rpVnRsyfTcCBPPbO+58jrWeuNMUqvcOiLcfGL3Ed2W6r6uXWS5hpmAbNCTEnONRb
 Otx+n0N+Q1rkLYHboFqMynmD1pWihrSnPKxWn65XI8K2OswIX4ZsqeyEzCpFWlx2
 4gzZ9jFRwC72712CZ35OkjscFYQsPi9W1AMmkEsO+RTZG9bqf+yFl0gfqHrEllRW
 19vvfA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak6f83pmm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:22:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-297e66542afso142392985ad.3
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 21:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763961745; x=1764566545; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPy8h8U9GzDzvObMnFOAN5hH04qgnv8YUO1Sb8gbfpg=;
 b=FhqqYRhmDb6vN0zRl8NofVKZfFP7YlciaUKoW6VIuFaMrrBgGyWPI24oBDmc7ydUUC
 LgzUaCgCIieBoFyBiLF4H6qnwMSfLNBYTMWJIYlWDYMXYfqVEMffENhqN9+oYIKm9nDK
 4akv5xk7vYwLMZ5ZioqZF+ko5a9bck0+CABp8NMZEZBA2CMTOpYXnc+HkvTJcZ7w/RJB
 JW82WkdFA9y+L0XelX5HwDNvRwa5OTPxr+fGeqqayP53aYNjNxDQZvU0ycCyffs1l8S9
 TARxFljqM91unXDaDX1k03w4vCj4JL6NX0U+tuVZNDxjadOeHwT+B5hSLB1kqkiqIPJt
 rr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763961745; x=1764566545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPy8h8U9GzDzvObMnFOAN5hH04qgnv8YUO1Sb8gbfpg=;
 b=K0e+2bijayXjroEG++lGfZfwhTAE2xD/3fYcKCwPvQ6d0g+bValcU/kxvBhmzZc0Sv
 KsCHG0AhMR7V0kXAtU/BCebehnmHolrmux5JkV+MILWbNJvhyjnm6KB2IQdz3q3QpMH3
 XP9GJB0j7VhQL8j7UhgW/UfDgAHNAEQ3npZB/58TiwdS/p6gFqXPo5/yYyohXzRyC0cd
 oC3Ta9ixBHPpVmWmQ03ccYum7TJcqSq6dNSanbbPSGS+YwD6Nv1jEp1bQ8RoyO9MJD/d
 fyrTZ9ru6S6AE2idfZdSpiKgR6CCidRV1Wzux/0DqRYxgWXi3yxUxCyvHSiwU/mYdWGf
 cpzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDKsmPwOZicc+sMtJXaz5Xd09vpjjH+rmj7K5XMCkio8Zy0LwXX7gHp6j70PPF0FoTBPl4UMc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6v5gwKhNSOqAA3gDr9SRZR51/5Z6hfl409CupFLU9k5mfsr1n
 B1eSQMu2D4JLuzQJ0GqNiMTp4vnf1XYOBvI2jSMncQpIZTbvyxW2AQxOVvKSx+8qG/qej4J4qk4
 4Vcoran0oIFowRJZFIA9+JJphD8mqmZPwtidnDuKv264qLaUz3MjO74+h
X-Gm-Gg: ASbGncuPT5ReCGpWJ3IbqCu/K0xXqz/w/9NkcznD8PKVlfwydbMhZT9+nnd2StuJmPE
 32kJrb6OnHrhM0bK0mHIbv2X/r5ykECPXISoTQXcmHiilcuK6m0+hWDLnOs6cO3kjiRhLDoZptW
 8GoWEE61meNCkHioLqpTLrYeQq0AsX/q9s1xCHEUql4AVySo5DTmsWllNCtOJw5dThsDLpDp4Fq
 4MjzJqI5DT8y4tUUhC3A0rnKUUy0VQcmFtLfATNuLNxekKYaaAtd2/R7naQHY+CckE68wNQmflb
 k9SkgmG+AWU+VfplMJONWKQmcxZ64/C3LvSYcY+19aR9LIdV9LpkOHXRCbxm/NjlDN1+CnykBHI
 RknCt+NXn5si6TMP1t25RcqEBO1rnZxMTztUyZzLNCADu3g==
X-Received: by 2002:a17:902:848b:b0:298:5736:de9b with SMTP id
 d9443c01a7336-29b6bf5c8bdmr86332755ad.50.1763961744691; 
 Sun, 23 Nov 2025 21:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH95Sjb1VJSaGO+F530qYfkmZgjPXQCr6IuE9zVnIGM64hNAVYgrIfoSog2Y7jU50pMKdBYQg==
X-Received: by 2002:a17:902:848b:b0:298:5736:de9b with SMTP id
 d9443c01a7336-29b6bf5c8bdmr86332595ad.50.1763961744293; 
 Sun, 23 Nov 2025 21:22:24 -0800 (PST)
Received: from [10.151.41.95] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd75def6346sm11932672a12.4.2025.11.23.21.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 21:22:24 -0800 (PST)
Message-ID: <0e4e3e51-0c45-41c3-b08e-98f0e5ced72f@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 10:52:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
 <CAC_iWj+_W+be_nXTWXiGkBJ3q01MpDUDzk6+Hr_QRtWwD9Eyhg@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAC_iWj+_W+be_nXTWXiGkBJ3q01MpDUDzk6+Hr_QRtWwD9Eyhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vLSrPhxND-HOnUHS4TjruGXR80yppn3C
X-Proofpoint-GUID: vLSrPhxND-HOnUHS4TjruGXR80yppn3C
X-Authority-Analysis: v=2.4 cv=SINPlevH c=1 sm=1 tr=0 ts=6923eb91 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ByvV7kiTjxqpls6wHGcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA0NSBTYWx0ZWRfX3Z4bsO8JEYFG
 Pn8uIZOpAiVE5gugRuoTea1IfpD9nuwwwQc0hsrpVOquUAk0S312iNaaFFlru5gJ94tBqesop+t
 DPAML1hpkL30SA5QDhscqN0ZhHno2+Q8RUlTvlgHbeDc0m5yJQF4OvpmNModM1YTh7nQni3qLY2
 /ERYBzXrwjf/aYkQqRSd9S5wz0hFEugRjlObVan6mRC7kwD79ji/fT+hATXY/sC/gQJIYdOY9sF
 dfL3rd4yDLVisUUpX4+fZpXUaSLePD02Y1/RDN3YJrs16JAvv97xRupDM9sjWFVaBoc9kOfnJcg
 6teQ0lWaPRrthWLWoLeYGDxtirVa1lprEiBV1CfRo3hWDwqan4S8a/IAB827JXgy3eoNpLIUbBK
 VrLOQUaG8xz5/f/S6dKUvvsZmIYZ9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_02,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240045
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

Correct, it will break other user cases. Will revert it.

Regards,

Balaji


On 11/21/2025 5:38 PM, Ilias Apalodimas wrote:
> This function is not only used in capsule updates. Requiring to have
> an ESP GUID installed to search for the file will break other use
> cases.
