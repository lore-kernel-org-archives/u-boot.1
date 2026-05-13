Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7A7CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 16:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76C78341A;
	Wed, 13 May 2026 18:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UL9mwbat";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q1PaszOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D7084663; Wed, 13 May 2026 18:06:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C8980F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAsolP978141
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/HKmuUdxXXple+YsxDzQk94o
 K+FkexrvukhzNM3DPaI=; b=UL9mwbat7vgAC12oDRjVpTbT9EQ5KatpTSeUbFEz
 m0b9eWrMelMf0m6g92wuxFabACVvuRzTWAr1+K3Y3Bni9nBvV7pLREE7Xc6vy9+1
 2lCAGNXrqybOioYH/LjPz0waOmddM7Gv6FulQrJjzU9Oy3kZv7yQb/LzOPpLqCpj
 ovu4Rfa39jg+D1onUGErnw0PmUDeLu6+vHALDNYnYSELoUuQp4jnKV3Xkno+aNMc
 gUwu85ibKTBz+TmbcyTQCzspI+LB8MpnbXApt7BwfKMHAGdQInT2x7xueVq8j3Co
 byCqv/FE/VNrpMMjJZWbDCdAjRQ4Y4a1FlVCqQ6NU3JFyw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e46s9w45a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:06:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa1c94b37so7681449b3a.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778688364; x=1779293164; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/HKmuUdxXXple+YsxDzQk94oK+FkexrvukhzNM3DPaI=;
 b=Q1PaszODkFyN1cASCFf3kiZwUQi0WN/4Ubb/HTfYAqkHf8v9BfvpkjsOctVfy5bJW4
 Vrq8kuDCQGuTVufwn29o9wztlEjIsLwy3yWTF8Ac9YvNu9WkANv/nL6NKsHUJw0kl/uu
 K5LkIZJDl+A2E7a7l24SbsYWl5cJEVAnII1HCKrOkOnIpkhgDvXBxGRIQdmCyF/2EHsU
 XUKc8w+e1Xpk4z604pwo/Ie6GYrvocaYYEBEtMOPFG+BLlU2K7yilTCFIvMuMSI7eLfB
 VQLaxquGB4UXXbnM9wjDrKTpchSXTt/7Gyhormqj5thHVHSeIvkAj6kX3j41wEj75hds
 xllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778688364; x=1779293164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HKmuUdxXXple+YsxDzQk94oK+FkexrvukhzNM3DPaI=;
 b=lehTYPumv0ywLoV6CdL+pCsKUmwc6jqyDKwomlVPYlSZCeIFBR2+AqGls3iA/bVE5r
 fdhp6L8UHG2AIp37w/g7OG6fw1ubhJ/Ae6m8wgP7gepBEC7bvTxCXL4FDr1h/+m9+Hi/
 5tFxTMMw1crzayuFcJ1fJ+of1V6Z4X4Eyglpj6BUY0hrEDy352nkwUPC7WecbRrHfSn4
 4otc1FygNhz5NoXZMePIOnqpXwA+2rqsmYc4SXegj9qpK1fj5zhbJ65D+gRUJV4cjo8G
 pc/fIlNdNQAq0xxi6FwGOq4DazfN1I0vRKxDoGwyHcL30UPl9zOZJkqZBXZTLCfrpugk
 aoAA==
X-Gm-Message-State: AOJu0Yy161sQSxyafiU8IVDAmNmxzZDZ9Vttmh9o6E7ix2NiNluRYa2D
 PPkts8rcFP2zl5DyGSJnKK1lxELOL0hwcL+ApLOolXATUxoCBLDzA5+9nH/llaQFilRYo+CeeqZ
 UXsY62AVFnPvtHBOqlx0IraUrh6LJmgNgtyZdIsHPAfjRwXQgJCbJ60PWWOapFhW3
X-Gm-Gg: Acq92OFjAbMU+v5+0Vz4yiZ8KDzmayPiQ3WHAPNB/CV1T4So+rx58hNT1FNtMIw8OK4
 Q/hYdeDeaxsNtPNiB0h8DDNsvBaMoYzMuunhwcwiOd1Xw1RHRh4hiVN9Koj9eXOSDV+ffI/AQVI
 gqgzEhOMfscn68RgpZ31kCGkinY44DF478XtJgq0cH7iy9GaaYzeaSwpJOTtZBv0qMQSquz5E1t
 7h++w1wfEDJgPZPkUCauru3wOSKuq0W62tbgcW1octTuRAJqgZikcqr/ASwkNPBvVGOiSE7sqgC
 ntRQ4u29Fs9n3NDcr5StAYV8TJA8oVXC9WWMzcaQ2PXtXXmtrYjOR07HVzv+JUIMhNEriIHn+QF
 1KJzhPbu29siOBi0rFs7MSlY33TA6/gMxtaD6hZ7ewlSuNDG0XmbtPlgAimus3F6KqLWxzCX0VJ
 rVTyzrHYfV7aSwVUaUUxdB2W8woIkYWTDrKcu4WuyEtjztBpH3pEE=
X-Received: by 2002:a05:6a00:368d:b0:82c:7420:82bf with SMTP id
 d2e1a72fcca58-83f18e7a624mr95208b3a.19.1778688363780; 
 Wed, 13 May 2026 09:06:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:368d:b0:82c:7420:82bf with SMTP id
 d2e1a72fcca58-83f18e7a624mr95155b3a.19.1778688362825; 
 Wed, 13 May 2026 09:06:02 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f38fsm26321201b3a.8.2026.05.13.09.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:06:02 -0700 (PDT)
Date: Wed, 13 May 2026 21:35:58 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 04/10] misc: qcom_geni: Add minicore support
Message-ID: <agShZibHyuPCI8JA@hu-varada-blr.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-5-varadarajan.narayanan@oss.qualcomm.com>
 <37198853-5546-405f-90e3-54ee98e15744@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37198853-5546-405f-90e3-54ee98e15744@seznam.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2NCBTYWx0ZWRfXw8jVLKv8aUtk
 bdGV77+vIelNgfwuTYG4uMz2KWLME0ihVQN8XS8lyWaQIAyx53S+5OUSa+omLHVb54cs57kyfwr
 lkmgZPK7ADQZRboJBmhYh6PKFWmLnPUX+DdWHUao6zBSR1zT3vuaRDkgU+P+tm702CxiYMDZmkq
 baR7LVtOaBAamxipLW9ZsoiBidTeQAdMTbNIQ285MrA6YQ9uHS6PETTOdCbltefHIyys/0hr29k
 PuPYPXaywocpWjmI7HHHbzdjF3+EpziXq/pBVh5V7pqynp90IAkMTfPj1uvwtJFkqfs+sgeVOxk
 22vPJCXE9V1z7fXHiphUmfQM4rjjhKZKDX2eF78zFTNeqGQ9VNFkT/1L1gTbiReBlUVZMxQp5rZ
 v3o8/0OfHDoC/ILQqUVaLfG2B/0waYwz2DCT7DLZdFWn7yFNkaKIEKfuOR7ZcTH2xpY1ol/vAiI
 EWd6J1uO8rCpCEmCgZg==
X-Proofpoint-GUID: pKrc2ydjZGUlNTKd8XSo9PdlEyEJZEZ0
X-Authority-Analysis: v=2.4 cv=L68theT8 c=1 sm=1 tr=0 ts=6a04a16d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=apn0q0EWAAAA:20 a=VwQbUJbxAAAA:8 a=gb_dzryzzhddaQT0KEQA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: pKrc2ydjZGUlNTKd8XSo9PdlEyEJZEZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130164
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

> > +static u8 cfg_reg_idx[] = {
> > +	/* 0 to 18 */
> > +	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
> > +	/* 64 to 113 */
> > +	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
> > +	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
> > +	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
> > +	112, 113,
> > +};
> This [1] says "Configure GENI primitive table.", and I have a sneaky suspicion
> that only the first part is actually that (iirc the Linux driver even errors
> out on writes to anything >256? I don't see any bound checking in u-boot,
> which is worrying...).

I see that the same loop is used both in U-Boot [1] and Linux [2].

> Also, these are registers with names.

For some reason, this space is arranged as 2 blocks.
	1.  0 -  18 regs, from base to base+0x4c
	2. 64 - 113 regs, from base+0x200 to base+0x2c4

These registers have the name GENI_CFG_REG_n with 'n' ranging
from 0 to max as aliases and that has been used. Since we are
dumping the content to these registers don't think names are
needed here. If the registers were in a single block instead of
the above arrangment it is just a memcpy_toio().

> Since the firmware format can't be changed and this just mimics it, I'd say
> it would make sense to improve that comment to explain what it's actually
> doing (since it's setting more than just primitives, whatever that means),

We are not privy to the information that is held in this array.
We just get this code from the hardware block owners.

> and if these indices are going to be in this array anyway, why not replace
> them with defines of the register names? Or are those SoC-specific,
> seems that whatever ones the driver is accessing by name are pretty
> stable at least.

Registers accessed by name are not part of this block.

[1] https://github.com/u-boot/u-boot/blob/master/drivers/misc/qcom_geni.c#L204
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/qcom/qcom-geni-se.c#n1251

Thanks
Varada

> [ . . . ]
