Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED646E9A03E
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 06:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D60A83AC5;
	Wed, 18 Feb 2026 07:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YQQUWI57";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b8cwBiqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B779183B99; Wed, 18 Feb 2026 07:29:30 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E693B83AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 07:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61HKqbbN2784620
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 06:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dek7vfVlAxKLC5HIr4Nr8V/jE0UNUIT9bX3xYly+7Gs=; b=YQQUWI575lwO1tkj
 6FB1us8KZEBluBGMjGKwecNdtMSnTIX/LcESKgMIH1Cl1hgAm7Hy6lrHNY+iNM9Q
 9z9U6/vHOd13ncnqWniqSuF1TrnoLR904qWNaWdceI26UT1fzzomHtrDbYz+qtKP
 Q37SD9/EcgJYkhzrRDP2GERNw14sruA1RaUt0e/F6y10lzWn8rdkj//8zNwoQtSt
 ZQ+hIOgR0Pn96CJ4K0f22jG8tw3NSupkxQxgGrEH1YjjQpqE21yp2RaK46HE8WVM
 cYZQSHRHyTpuy1EVoMVeJ01GLCV+qsIY7lNgLTX8BMNhq6BTvrg7iKxFvmQrDI0/
 3jP9Lw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccyrk17d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 06:29:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35845fcf0f5so664563a91.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 22:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771396165; x=1772000965; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dek7vfVlAxKLC5HIr4Nr8V/jE0UNUIT9bX3xYly+7Gs=;
 b=b8cwBiqrgkxC9Ii9g8oNTOAFBd3xhr/fz45Hk0ZK6Yn7R7AMlCKNjbpjwhtEkMU1w8
 RyQdLrxCqi92jmAU72rK0JRXEZ4h8wmQEoHtTtbY0cnw3TMcE6/NSGHLgC1TkY3z92i8
 wFtOHvz98BIUnwj/ElovBiR6WbGBtqvuf20cpBk5mWNoGr7JGyANwBKf1+CUHKfZBF4X
 wiQ1b7w0Syxgy6hYYvZ0TDR/UjuboLoqp/9Ftm3qZxopUmi9o9mhbzPeqE8fkUIkKrio
 2rAYdls3c59qnjzhT8RANA6Wlzn/6dgv5R9vCN9ms0mDcGSOEpCm8W23/r6CKliKz12q
 lORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771396165; x=1772000965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dek7vfVlAxKLC5HIr4Nr8V/jE0UNUIT9bX3xYly+7Gs=;
 b=DxROTT9aWb0wpc0CL8koV2+u0gXG6ScY9VKENgDyftw0HYTu4Jz+JBD5EvrbyeHzbB
 IjgCiHHDYY/zUcamxlQ5QExs8nXBPJyoO2A0cCbHGoYAtygR30DoP1iiA6yLqqb/M1uL
 ydfjybefCGcHXQi//gznS+ARI6vHAgul51eWBmn0mjqUH3ua40fCIz9hE4umkD88us+O
 CSG0JhSiSL9eYfJD2wbpxuIFNb/bPY19CgwkzhaJRV/B27CsafQfnI0HYLyuCi94VErQ
 KlenFGCI6OHRQ97X7ZuwFnx7uEDPe+Jr6ypDDpUX3CXthXby4upO6zRY6fR5N61gF12y
 cwHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViyVoSrWqxXc9mEFLTpObrJm3Z7ZoF4OQiIHc/M6CyQIlGLOGa8hNkT020PsTJraTn9NoQNk8=@lists.denx.de
X-Gm-Message-State: AOJu0YwLoW3k3RxWDnqoEIiqnfE7sG6uqrm+d0TmxS4tx8JzVW4mA022
 tU2sfvma6U8J2j35Kv1KvycXN90nuc4SkShS6qWfX9IZMdLNTNKjClgMA399Zp4AmL+EEYlnEZK
 0Fu0OB9LYxmI4jjJz9ICuakEDXJZNGVTNsqOnJwZWrXRsAduxKP7WNjjo
X-Gm-Gg: AZuq6aIQNgMg3xoH730yoh0Tzad+sMJvLlxzNFGy9t9WQGDXqF3PINrkrHLWJSeQpsu
 cFAkm8UmOClVo80+8Bc40N5kEqtEp4qL3XD0dH8qbmDVEkvUiYDVaFsCVB7xDWDkORe1ByJkKXR
 sSiFS02ZQEYrnpShqVUVzWlvb+tgddTD3D7eFhZ1JDkiUy1jlhHj0ThLtmuaWjFWNr9/QLRyZsF
 So4sLAEGbbJliYJMzs55RVAtgP9SynBg0m1ci+ESstiM9SCtagDlKngdyImXW63L0lrhiZobreH
 lqnv3G+gSZgp2+8egGavMkKuh4G5OGtLaCo+L9hAaS+laGLCZoRJzU127m58Z1Q60Z7ox+9TQr1
 fiVlYvnq6guHLZJTM5frDRxS36wPlaiN83rUz3FsxI673CAA7XQllEg==
X-Received: by 2002:a17:90a:e70f:b0:352:d0cf:9d18 with SMTP id
 98e67ed59e1d1-35888c524b2mr807163a91.5.1771396165140; 
 Tue, 17 Feb 2026 22:29:25 -0800 (PST)
X-Received: by 2002:a17:90a:e70f:b0:352:d0cf:9d18 with SMTP id
 98e67ed59e1d1-35888c524b2mr807139a91.5.1771396164644; 
 Tue, 17 Feb 2026 22:29:24 -0800 (PST)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662e537desm24093844a91.4.2026.02.17.22.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 22:29:24 -0800 (PST)
Message-ID: <b3fad3ab-03b3-4e13-8c82-b7b6cef648b3@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 11:59:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 michal.simek@amd.com, gabriel.dalimonte@gmail.com,
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com,
 neil.armstrong@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
 <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
 <CC8AE9C0-F7DA-4EED-BCA0-F739BF75ADB5@gmx.de>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <CC8AE9C0-F7DA-4EED-BCA0-F739BF75ADB5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -6iTCA99dwXKnaDzS9p9PGYxTiknpxFC
X-Proofpoint-ORIG-GUID: -6iTCA99dwXKnaDzS9p9PGYxTiknpxFC
X-Authority-Analysis: v=2.4 cv=eOweTXp1 c=1 sm=1 tr=0 ts=69955c45 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=kX0aPsMa5xAO-LAJy3AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA1NSBTYWx0ZWRfXyuOxMRCXpgT1
 XVcG2GIe4aFexEiNsJkWZPzEv+i1LoIhlsDd1GDbRbfyK9pQO83o8ooLYZzUdur49dLLMNQPfzQ
 DGzaJcetgH1atXQr2HZrUbSJ3AFKLJQlnQclY3ieT1xnSuXlGIdOTEe4tcWzhCj5S/jijOAZqKS
 sdHNvgckredk+zTKoKYLkvDDtcrKAOmT8ioFC4XWY0pQn9sNSRSs+rAp/LlpgUbsereXXcqYwKj
 by+Tx3GmUYwx+Lf1aQ7DUlmPuCyVy/al3QVuefEMSBNdJZxrRB9U5oWld3Gd4ef0HvuOLaNC8MP
 CRPOjnMRxui7Dxh874YlJPLpZ4Q+IFDpBdSl2h6T6pF5cwR8IEVmjc1tgQDG5P3YpDooUPDcKL7
 hS6niJYzn2TJfg8bmeEieqpf9PJtbAY0zDm5QPY/z30938KNnKbfG2pTnbucKYqO8WpRzGy80Ka
 nloqH5x5EpZgwySLrcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180055
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


On 2/18/2026 1:44 AM, Heinrich Schuchardt wrote:
> Am 13. Februar 2026 12:05:26 MEZ schrieb Aswin Murugan <aswin.murugan@oss.qualcomm.com>:
>> The current PSCI-based EFI runtime reset implementation is always enabled
>> when CONFIG_PSCI_RESET is set, but it does not support the extra arguments
>> required for specialized reset modes. As a result, reboot requests such as
>> bootloader mode or EDL mode are ignored and fall back to a normal reboot.
> Are the "specialized" reset modes defined in the PSCI specification or at least compliant to it? Where can I find the description of these reset modes.
The specialized reset modes are not defined as standard PSCI reset 
modes, but they are supported through the *PSCI SYSTEM_RESET2* call [1], 
which is explicitly designed for vendor‑specific reset types. 
SYSTEM_RESET2 takes two parameters reset_type and cookie. Together, 
these parameters enable platform firmware to handle specialized reset 
behaviors modes such as bootloader, recovery, EDL, and others that are 
defined by the SoC vendor.
> If you don't want to use U-Boot's PSCI implementation, why don't you simply disable the PSCI driver?
We still rely on the PSCI‑based reset flow in U‑Boot for normal 
functionality, so disabling the PSCI driver entirely would not be 
suitable for us. Our intention is only to avoid invoking the PSCI reset 
path specifically during EFI runtime reboot requests, since those are 
handled differently. Outside of the EFI runtime reboot case, U‑Boot 
should continue to use its PSCI implementation as usual. [1] 
https://developer.arm.com/documentation/den0022/fb/?lang=en Thanks, Aswin
