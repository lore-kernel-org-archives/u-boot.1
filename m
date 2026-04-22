Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F80F9EDC5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB02D8425F;
	Wed, 22 Apr 2026 14:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dspuCLDI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cPLmbBDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D9F6801A9; Wed, 22 Apr 2026 11:13:58 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A75368352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pavan.kondeti@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M5DaSj2123746
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MBkQHtcYv20A9jLWkCZdQNAS
 R+a/WYDf1+/TEc5+2g4=; b=dspuCLDIR6FKaq2KcPkgnP3++X50HodXawEPCCFK
 9HErw57rCjvwUZQfMKMYYPtD6djV/fuka9B5BeOQw7LNS+WTmB3JHewMjkYpYG1d
 29RvBOsCKnoszOzODG+tu6pYltdDOPPg2/UWd2ylSEg78HtM4NtPFnHbp6BCe2/y
 CrNPaxxpefVtijNLlPBbJio9FL5ScSaALXJOshZ6qQHXe/vXRYVU5TJNl4Egi6Gq
 NIQPKa+bCl9vDsZ+dY/Ttw+cUDOeaJSxrsTUroshYy+xP1PWIQHy2yossVx4iINk
 MY192LtCvWeUVEltj1NaOzZEVTujHXXDlCjm28pzf2N/WQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenftnpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:13:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2ec17dc21so59253405ad.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776849230; x=1777454030; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MBkQHtcYv20A9jLWkCZdQNASR+a/WYDf1+/TEc5+2g4=;
 b=cPLmbBDj/hXdxxLKJVu9Vziyou5WvVBU7ND9eRamtwB9SLEwVglwKBiFHHfqCjY2jh
 64T0KLIcXmZRhcvoOmzdnaFgyRIhzKfjpGYRE6H/bFDJ1Gf6F1Uw15PkPEaqz8DwrF4E
 G3D4/3m/Njc5gqjWK2btDAMoydgnKRCcnfHHFJu6FZpFWJnFM9iL/UjQGFdLFytCaMHM
 yW6bTWAljIf5qsQmCRKw0l9akk8uaaL25flmCbVViaKLeOmT2GkeMNiDi5D0XK/Vw5Nr
 jgS3/dwG0umSTi1glWqIpA7tq2jUpLok1jCh1MXQmYn/DHXyaa7eHBceodp8MPYq6R/t
 FP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776849230; x=1777454030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBkQHtcYv20A9jLWkCZdQNASR+a/WYDf1+/TEc5+2g4=;
 b=DIhTgwhZLLBVyBpcSq0z+pwxxErDB3YW27pLi2DAGP8JMZ4CfpX+2PSBeW7Wf1Iv1I
 g18QYJCILwJcRo/3lyntTR1IiCLsCmKsmwtKU3StnUbT07MUalWUjoOMOav409s0YNOU
 2cCzrg+2fqrWJHuXJ4BxNaBKFKL55/3aNsCFgLsxmNOxRLmrhO4nT99UJjufZglDp/1G
 MZp197bCjQ5SkOgqnFfeTXpxech6JaRa4ydN8FJy2docWtiLZdXlc+PiYPDCPemno8tt
 7sjpyXsK5+4YCy3UdTVqA8VML6bmsb74n1kIEdIwo5bUUNGRJnCR5+T8C1us47aj162B
 CcKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86bMvQg/fZyiJxOP55EnTFl5xlfprFa1XkJ6fsHV3BJSvAvVY9/Lt5manilE0JNsb7cwbYjds=@lists.denx.de
X-Gm-Message-State: AOJu0YzSKi3age9lliITudw6iHeiHYHaE8XGeXeXS38DaUUMl4M2yiyU
 V/jqgXVPAfq2ManswKM/erTOzufebwITtTXfJPN1VsFZIZo4ecRscmUYwa6ugTduxDSh/hZyTxj
 r+6GuOAI7mXqxuKrqN+SHOIkZ5Sv83uc4zGh2MGcnWj0GW377gLBzUayqdFnkfRhs
X-Gm-Gg: AeBDieswHwZg7duw4lf50pk7U+Q/hI24kGNvIa96THarRedETd4XzbXp6IUW0hn5IWc
 SD/oQFwfY9AUhv1IbWMaj5c/ZqDeVeDyM6ZIkYwn21XClg79daJlmdMbwyA6DUPX61FkTCPjg/D
 M77ydA6PBUKcqn7+/wvngz91Sm8M1p7vtsLzF2TzxxpSDuElfFJbo1d/DA+EgyZyIQUaqmX88Qi
 GyJwMQq0E3SOx+9a4sDb/1bUN3cr+u6YGCCio9NBcnezvrO1IH1AYlGvMFmuCrtzPzIiEfnY7kd
 UPsKeIQ9cJMrJJhq9B/Hsxi1hOWtXXw0dtv6olHEJzrjO2rlI0+Zo+toF7z/Cxn2APFDTJuvXTo
 Vin8Ns/zKQN/uuTsTtowHXPqx+8uxoxotbH4Ckc/ND3qjD8lFHlJwMEJLUXPk4dUclw==
X-Received: by 2002:a17:903:1b6f:b0:2b2:4d08:9e02 with SMTP id
 d9443c01a7336-2b5f9f3c677mr218390675ad.21.1776849229738; 
 Wed, 22 Apr 2026 02:13:49 -0700 (PDT)
X-Received: by 2002:a17:903:1b6f:b0:2b2:4d08:9e02 with SMTP id
 d9443c01a7336-2b5f9f3c677mr218390405ad.21.1776849229250; 
 Wed, 22 Apr 2026 02:13:49 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab32cfasm202529745ad.69.2026.04.22.02.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 02:13:48 -0700 (PDT)
Date: Wed, 22 Apr 2026 14:43:44 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sughosh.ganu@arm.com, gchan9527@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] mach-snapdragon: Add KVM hypervisor support
Message-ID: <ecb74cec-427f-47a3-9400-1c20f688d62c@quicinc.com>
References: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
 <aeYt6cz5AVXFc5m3@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeYt6cz5AVXFc5m3@sumit-xelite>
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e8914e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=kJSeNkqSAAAA:20 a=NEAV23lmAAAA:8 a=1jvfx5lmMrNINu_u-F4A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: qhU5e0JaZrNfGQidhBPYnrDG2leHH6_h
X-Proofpoint-GUID: qhU5e0JaZrNfGQidhBPYnrDG2leHH6_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4MyBTYWx0ZWRfXz6Gr88BfxCy5
 p4U9DHNx0UIHllPpsueAIBx2f0S9ZQ+8h0NJVnVL7u3OH7AO8wy0WhoK35jQKvou13w1C/zsg/y
 yoIzRZUHIVe0va7dvYWaaPoS/QF79BSWgvpXyBdC268P7zI0zwYI5N7ej6kU7WTJ6SYp/IG22gl
 xWJk3f1QH/QyJDqgZYcD9YcTRxfNJPYq9UmZ/X8oMXkTvmWBqSR90R4Wj5tk2ZpwAYgkiWikso2
 QAZt7UdHdYWYQGLCp18CldkvT93WrIHnAfZpJaYrw/XQEMU6yA1RU3S67Ivezq17oGTGG8fsIBn
 RaNHQaepzl6Peg1L4DD7/ffdTg75ysHZSp6FavXDUnb1wrXUHEDoEdIMOFCENohuIejH3e7fkIE
 cN9vEn24m6AUipHUo3pVaY1OdywPlATDt+7FlW4ur+Ohf1Ei/YLBxkg9xwLKrf6mDN11Mhp7hMJ
 4qZeJnPLmbbhpRBaY0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220083
X-Mailman-Approved-At: Wed, 22 Apr 2026 14:34:21 +0200
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

On Mon, Apr 20, 2026 at 07:15:13PM +0530, Sumit Garg wrote:
> On Sun, Apr 19, 2026 at 11:08:29PM +0530, Aswin Murugan wrote:
> > Enable Linux KVM virtualization on Snapdragon SoCs.
> > 
> > Introduce CONFIG_QCOM_KVM_SUPPORT to select KVM or Gunyah
> > hypervisor modes at build time.
> > 
> > qcom-priv.h:
> >  - Add TrustZone SMC interface definitions and parameter IDs
> >  - Define hypervisor boot types (GUNYAH=0, KVM=1)
> >  - Add TCR_EL2 bit field definitions for memory config
> > 
> > board.c:
> >  - Add qcom_configure_kvm_hypervisor() with EL-aware logic
> >  - EL2: Perform direct SMC call for hypervisor setup
> >  - EL1: Save context, disable caches, run SMC, restore state,
> >    reconfigure TCR_EL2, re-enable caches
> 
> Please don't switch EL1 -> EL2 in the middle of U-Boot execution which
> just adds these expensive MMU operations during boot.
> 
> Rather than that just follow the upstream edk2 example to switch from
> EL1 -> EL2 on the first platform specific init code code sequence. Have
> a look at this reference [1]. Surely you can keep the switch under a
> config option. This will make U-Boot to properly execute either in EL1
> or EL2.
> 
> [1] https://github.com/tianocore/edk2-platforms/blob/master/Silicon/Qualcomm/KodiakPkg/Library/KodiakLib/KodiakHelper.S
> 

Thanks Sumit for pointing this out. In one of our implementation, we are doing 
this EL1->EL2 switch as part of ExitBootServices(). As you mentioned in the commit
description [1] , this seems one step closer to recommended boot flow.

Thanks,
Pavan

[1]
https://github.com/tianocore/edk2-platforms/commit/0a51cc11dd74be199c67eceabc7bf68d36bb7075
