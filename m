Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5A6CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 05:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E38F83BF1;
	Mon, 24 Nov 2025 06:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sc7pnzrm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvRg1X+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFE383BF4; Mon, 24 Nov 2025 06:20:47 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563FF83BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 06:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ANMl2ie2538376
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Aezh0ux1CBbdMgHO5YqYmdL6/0NWiNxGqzenw4ZF+9g=; b=Sc7pnzrmX7NEQcNV
 BPIa0EBZ8m8CNk3/FBIuKh+hQ3sOoo3VuMZfS7tNBcukf1+wU4/G+n2kWm1+9D7r
 1w75cQgb03uorpxuv607tNp32sOSSDcS2akUxpT9XPhmGFaEHlb/4c2IwLuvAMgv
 lq5KYz1xNPhyU1QhaOEdrKW55F8iELUQFuRP3ppq/zfYz5dHx/3mwIH7tvbZhUeq
 4gavCMLoFdUW5vm1GheSWwAsBBD9croysc4k4z/jy7soTrfPrafiW7xZYlquoYpV
 Z7SNAbD+ct6l6VMxEdx+PKPkCNhZS1j4tkx/dUsmr47cEmPhSWvzC1F5JBpKZCcZ
 +WSXaA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak6cdup0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:20:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2980ef53fc5so121824035ad.1
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 21:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763961643; x=1764566443; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aezh0ux1CBbdMgHO5YqYmdL6/0NWiNxGqzenw4ZF+9g=;
 b=GvRg1X+xq+fo0yF1JgriR51QnVrk/MYmdV51iryU7mEqkijxH2OKTEu8Y8chuL5Tks
 uJRRGpT/fjtU40i3ONbPJYNaNodyVK4PHjZAqPLxuzM770Lo0N2jqxVw1777ZGbYWUgB
 COOmE2V/lz0tneT770M2R/8v08Ho7cOH/NFof24iqv0EhJQxS8JVrYHkEPMK5mPC/rZC
 ILoCStDspge+nbMaUNIOFms5n3hV8Q1C97lyDn8JKNL7wGJJ1ywfwqIzQZ1f1WLGK0+T
 Luw4T5kHoznSPcUK61YhvNNGloxtDaL16OWCq+j7R7NXR2S/IhaXoz3Xdk8+mNbwtT+s
 lXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763961643; x=1764566443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aezh0ux1CBbdMgHO5YqYmdL6/0NWiNxGqzenw4ZF+9g=;
 b=IUQvd9cqbBKFrtIE6JPH3Kt5/kgP9hE6uXUdqYlD82HC2brNWvDD+LTRebx8cNtDUp
 FeHZNLVeCrYuVhzaiadDVdiAXXIt7FXtLLOsRtUp3GaBUX60WUzPhzj8tM3fXW3w6a3u
 /3+6W8Yt00MIUKdKWgwxSkLHu6CCEAYk35Gut3JHTuYII19wSThafQTMFUjJ8O11rBtX
 SyEmv2q4GWYnXyVIjC5zm8Ou4AKxE6P4TirDTDOhPJjuGsi9nDZRka2KaFtMZs/BOfFA
 TxSg3/RfvZg0izfdUgGmoOP5IHbH9+8gF2VRgFF0Ccoj6y8oVa0gB3r2FDLAPTOtaDYM
 L2CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXslwNVSvbLjDPhMtELmYOHiXJcI2YBh0kOedMvGUc0LvIh8yEYhG4wu+427P9Bz3vXACq4JY=@lists.denx.de
X-Gm-Message-State: AOJu0YwS/czgrcgEDPCeOqvflpCFIdizYd8beD8zJ7UzqJI18ApnJKT/
 fSsKGQpnTQIl9Mrs2cUt1t/ya75FK/ZrjcWYU+wtosRxpgpmEUQ8t/d7yQQV1SPPiud7hEkSMuP
 VV3/9vUHL5M4zMwNtU86KDHtgv49vxCq+ZGNAlpi0mZJHLzMRgAhtS/qK
X-Gm-Gg: ASbGncvwgWag9WRa2iS0AdeMcj0bi0+Vt502spmsNgh+6tyeNo64iC51ZVRtj0DpK3b
 XgcR6eaFvpafobiWjNFU0ycKy7rJ02BmafcT30coDo0UB4GrhHsl2rkK73yXdJQE2W+tU3OvTGx
 9PL+sp6IiXE+QzVbd03z5Eb5+Jr+t4jpXlANrmc1/ErnHb6Bo2Th+cmYZLp972u1m6SZfmw/qI4
 tmzeFZ+IlOs+oKIFGQnDctuiAaQDtnAEqdyJjntenwojwQC2teq5HBSlbhLF4WMTATyiqI5F4wt
 Jj0gkhYNrRfMI8maCNlA9yi2s0JJiZuOC/gGibk5asfCJPb/W79eWsRxZ1tHww25ay2Rqp35vAR
 uh8jtY90oRkTrkW6+n9/MHrI7UH1AA9iMESXetjyZVg6pJg==
X-Received: by 2002:a17:903:2c9:b0:298:33c9:ed99 with SMTP id
 d9443c01a7336-29b6c684bfamr119181035ad.30.1763961642769; 
 Sun, 23 Nov 2025 21:20:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgnkt5ng8rKRdmILN8r8wE19h1i1HHAOppxljlR3/xSQwo3oR7did8y0TsOWaXS4lxlr4dkw==
X-Received: by 2002:a17:903:2c9:b0:298:33c9:ed99 with SMTP id
 d9443c01a7336-29b6c684bfamr119180805ad.30.1763961642310; 
 Sun, 23 Nov 2025 21:20:42 -0800 (PST)
Received: from [10.151.41.95] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13a865sm122424025ad.33.2025.11.23.21.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 21:20:42 -0800 (PST)
Message-ID: <2710290e-ac17-43fa-86c5-5c15c539bc41@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 10:50:36 +0530
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
X-Authority-Analysis: v=2.4 cv=bsdBxUai c=1 sm=1 tr=0 ts=6923eb2b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IHLB5yTOsD3JpOeUS_UA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: myHlw3_A2yB3_jFPFYVj-4rKuccyGFg4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA0NCBTYWx0ZWRfX07bviUm1OoAL
 80IjMjpjX00F1G00VXvXHAcASAq5iwOHO8ifYFj0c2Q/tgg/haqRT/j0gNN+g8Cv0/Hd3LutIui
 BjRbwsFU8LhhJvWmo96wOVPrYQWTlcP1XJmVNy3A6nvs3WzMbfesGzwpRuchTgr0nPoubmqmA7G
 lcPBxg/KFn5/UY97lfmq+fd8q7fNxubDcpd5PaQFI5TxuaBfmY2id6y5VnvSl2+RwTn5ve9rHgi
 r/OatkgFew9RXO8jWY7wH5g+kl4cLno21FaZ4pZcJ9Nke16YGemnLiT4H2aNQYdDVpuzFMt3pVk
 0x05ayRMbJT64RLeJuIrvPJThIcfmeUVtQIP0CIzyJvWhyzU6qqFVKevuzQa9x209lIeN3vw9TB
 PQwGa0JmlOAEqt1RyXnzMljFAJHfJA==
X-Proofpoint-GUID: myHlw3_A2yB3_jFPFYVj-4rKuccyGFg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_02,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240044
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

Yes, device_is_present_and_system_part() is where the process fails. It 
fails because efi_dp_find_obj(), which calls find_handle(), is unable to 
match the boot device path with the ESP handle since the ESP path is longer.

Regards,

Balaji

On 11/21/2025 5:38 PM, Ilias Apalodimas wrote:
> I am not entirely convinced if the change should go via find_handle() yet.
> Is what eventually fails device_is_present_and_system_part()?
