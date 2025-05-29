Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0196C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 16:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 688EA82F8E;
	Thu, 29 May 2025 18:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9sASoSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FAA283010; Thu, 29 May 2025 18:06:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C498582E2D
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 18:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1Q3x006932
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 16:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PUO1Fo9H7OWxMgc3TwWxeVhiSPzti9siG3NxJq+yhyc=; b=C9sASoSzuyOtlgbV
 ZThDDYu1Lq4BSVajzXRfDkRkJOdAX4zi/++rurizBzjaSX8toY+62gO9/RAxXGKu
 ANpq7JgooMM82a1s82F505Hrp4EP0s8yweaPOzsn+pAOyzM6wsC7GqcmFc/jKfpz
 Ci7RV3o+EpcemzyWk3S21uu6A1YCvNmo9fWvd189auTvkqDkdPIk58CU+A35+F3H
 6/nS6xd2NLZov4tf0ddEStI8NVfqXTTVwR00hkF/v+Y25O5oTAFAFt2sI0aQMo8X
 6IrhBGuNc1LJWoJmz/jBg+Skztgavp3i+kISSZ+qlbFsg13lwCzJ09vKq07RtZfk
 mmZIQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u3fqee8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 16:06:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2349fe5be47so8482505ad.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 09:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748534806; x=1749139606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUO1Fo9H7OWxMgc3TwWxeVhiSPzti9siG3NxJq+yhyc=;
 b=JjByg0PnRvDG1y+tI7ajSK2ardytN0PGmMNJfqS4eVaDro08h3QQ01jsIdHvYt1axf
 kME9nxr0VqL423MXnX/kN8h4+rkiyPTKwVxvdvdRBUrBEzq4pDECgqfjsDr4R26/BMiz
 PJsvQl+Qyedm4gXDtnJyU7ZMtUIXHDuBebrPGbKQyZNUOS7X+nxiP1IZ5RAoKxjt6T8O
 waUhzrl/O3ISlKn+9WROiZJdxpWfly2IajuuGg16n3OjzgjJnr7U2ZDt/OP0kraGK9vH
 4FXPISoUqdOREUJ67FMQ6qIJFl7T3WQjZBH8+UlignWToPqv6Hu4hVeh1APtRRuX+PXH
 eCmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2EI0OL0dcOKsPMm9wuRNG4RgcPEnYU9allfpX6DtYmd/LdV6Du/b+T5gZHIM3qmh7Wtvh1cQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8XKeX3F0GV+oGRaMpofczjJ5Y+hVD4K13APQgkF7kgXVrJJ3s
 6Ln6v4PDw6h7nmsHvvwjZyobGVgQJOpM3R+b4zTBr5G+O4yG2QNUVe/UgH7rRMhMsJfBvDzFL7X
 4p/GM803OWDoGPZ9DLQv66uULMkH4VqX9AFDIxKHuotU4/34xGFRnILef
X-Gm-Gg: ASbGncsdqkqLo2kwPCbcXUU/dL7cPFK4s7/IHdvaDF2y5hI1SblSw8dhESJix72uypQ
 xyKQX5xaKyUZgPZco6dYH1ovvo2ILt7QZo4P/prdTEOC0cTSz4CLVfzx6NrJir6HM9CEA22d9ad
 Mi2NRLSk9tJbbRoTUtLCVoX/Lv20bDkp7oHgPKZxhyyh6oyPVyXH8XH0PT3GrIw56q5uPXUDYTa
 0s7i8phZQ99nzQ05/pT3CnW3+6JOzF5rYG54spJs2Q8rUZcTlxLEGOR60yKO/b1+4hJOY7gZzaX
 tWjoFMpXp2QWrhvqwH3xADbYqk7uTBe+1K3mcoLmZL8=
X-Received: by 2002:a17:903:184:b0:224:255b:c934 with SMTP id
 d9443c01a7336-23529b46808mr1821035ad.51.1748534805756; 
 Thu, 29 May 2025 09:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0JszkJQGSHnzwZzVF6gKUk2TY22IZjlcv4J8WWCWFILO9jMrpneTDwZ2c2DNrRgRNR440SA==
X-Received: by 2002:a17:903:184:b0:224:255b:c934 with SMTP id
 d9443c01a7336-23529b46808mr1820485ad.51.1748534805214; 
 Thu, 29 May 2025 09:06:45 -0700 (PDT)
Received: from [192.168.0.2] ([49.206.97.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd34edsm14011765ad.126.2025.05.29.09.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 09:06:44 -0700 (PDT)
Message-ID: <1af681d3-5dee-4431-b619-48dc095d013c@oss.qualcomm.com>
Date: Thu, 29 May 2025 21:36:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] doc: board: qualcomm: document Dragonwing board
 building/flashing
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, me@samcday.com,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org, sjg@chromium.org,
 lehmanju@devpi.de, bhupesh.linux@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
 <20250521094442.3522036-2-balaji.selvanathan@oss.qualcomm.com>
 <43bdeede-85ac-4394-80c2-ae246ae6b197@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <43bdeede-85ac-4394-80c2-ae246ae6b197@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yKWIgyafNIQ8DNgmgw7QOMBrta81aq0t
X-Proofpoint-ORIG-GUID: yKWIgyafNIQ8DNgmgw7QOMBrta81aq0t
X-Authority-Analysis: v=2.4 cv=X8FSKHTe c=1 sm=1 tr=0 ts=68388617 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=F4hkcdt4JzA9jL8HvjiHYA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=qC_FGOx9AAAA:8 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=hBlZPJNRg3lnjCDeoEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1NiBTYWx0ZWRfXy1g7mXDMMkuA
 Hf8+4eevqewt3THhyOqeI9kAyHNC4AdClSlXUfu+nzmhkA2KATR7dRM4kWcu9+WHZBpgv+uNMfG
 V2+OZqIzCLh1vpC8LZ/9A1sR2PFLmy5XooW6G7zZDgl1sIEgtmhBmZPNQQ2VBkw44uaRBut2Lgw
 Nb1l49r4GnU51ll8WFTc/qPz4WJVl73HIAwreUOwWTAPgGItdk4dSqSvDzc/pOqF9Qu0jrwoR1H
 NMmbJF90Yzm09NJYqHRVZ72BR8M2rcQH7gxoTnfMw5rqDT38WLsjuvc78DvhqsQvtadbQXF1N7d
 lOE6uYXnTxkOcgbjN5nJIJaNC2AeN7WBMgj4IRImX7St20EBaTKthSCYNt+OLAp6+gv99180XyM
 ldOKFVCNCuIrWj8GVmhVVNPp7sa+1eIw3dLGXdKMUwiYDuA+I3v8rz8K04no5wb/fxpk/KKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=724
 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505290156
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

Hi Casey,

Thanks for the feedback!

I've updated the documentation with more detailed instructions on how to 
flash using the EDL tool. And yes, I agree—it would be helpful to have a 
dedicated, generic "EDL flashing" page. We’ll look into adding that soon.

Regarding the firehose loader links: currently, we only have the 
firehose loader available for the QCS9100 board, which I’ve included in 
the documentation. Unfortunately, the binaries for the QCS8300 and 
QCS615 boards have not yet been uploaded to 
https://artifacts.codelinaro.org. Once they are available there, we’ll 
update the documentation to include those links as well.

Hope that works for now. You can find the latest changes in v4 here: 
https://lore.kernel.org/u-boot/20250529154931.1879976-1-quic_bselvana@quicinc.com/


On 5/22/2025 3:52 PM, Casey Connolly wrote:
> The flashing steps here are a bit vague, with the edl tool it's 
> something like
>
> ./edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a 
> /path/to/u-boot.mbn
>
> All the pages are a bit sparse in this regard, we should probably add 
> a generic "edl flashing" page at some point.
>
> As a final note, is the firehose loader for these boards published 
> anywhere? Otherwise there is a major risk of bricking here. Could you 
> include a link to them?
