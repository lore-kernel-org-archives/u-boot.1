Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D6CC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 08:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDDEB406B2;
	Wed, 16 Sep 2026 08:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3z5FQZi8c6D; Wed, 16 Sep 2026 08:06:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ECCE240639
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789546001;
	b=ncb8vEvG/l9M5aGpYZVSt4ySfyNgqnhZYc/5PUW+1KIkr0O/c8MP3xj9tyKVue8KzZLK
	 xaKDG4ucoMR25lPMskekj1GoqagYqArto94ULZvdiuKvlIGgSylASnKRchXBtjlGfBRvi
	 GnF2ioNBc04eX57g6w2yzf7dGPvuXM0lmHNHRc7ePaEZzeo3ybyM4hfO3OHQCxOV4YfU1
	 XLA84Ae2ClAohqAvcz6XMH3QGxSyefnvvrY6lo74gutIvwB//3pXMbvmjuYXGsUCbkvrz
	 Q7CsBGthSbCejSsRQqOyWCZv+o8LQS9d0vDUMJF84pizs38TLiLNyd/HpMaeyjh1aJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789546001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qYPxeuhK78oX+OPoweEIxK5E9QF+zzyUs32Txt0g63g=;
	b=XPJnDYx3VQqh1TNlF85YKxRxDBgMBP2izvmfMPEDu4l22Ndc0PxByfuepD/e3XNeNu/2
	 nz1eaEbJYGU1xIS5N33/NWhPOBTO6rLvwzVmIW4XLe4RkqXSG6qdz7kJCs6wHBNsUYQ2Q
	 +J4H48iLOnsOCU/KVtYjmvq6gtw3W+sO/VnJCnGrTk0S5uhdUTB12aSxcv8YvU9I5zBYV
	 8yEdeVQh2MRQNOc9iaQfbprKUjvFeITIfufMGKrlnK+MeiE2hdQqzgY0mw/CkH0wvc3xv
	 z97fQOs9eMv6qqUTTDwdWgeZZjO6a/Dt6UY8RTSaCNY+L1MfaFfyChlyUlKucumecQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789546001;
	bh=qYPxeuhK78oX+OPoweEIxK5E9QF+zzyUs32Txt0g63g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RVNN1u4wI5aOD0RI6FoEL+U50m3qyF5MdDdVatqomrfYpb6XGr/831y4soIaIxDxA
	 0MPVtKuqWnq87izoPJgoIkwEYtHeVJLGuAsUqk4VZdlywL2wWthWa9L1CnX+u2r1yx
	 8lWarCLcoI3mjqndsdVVT5KNUGlnPWOp9Reknt1Z7TPNBsnxHFyQZW6295aYi5rteB
	 fVfMW0dYwumiNSeAK4zlhJDAqx8xgggl3KYOBoW/mSfhuun2TQOZsPI60VW0PhHTF1
	 ULo3dLlv2S6DWWHsaqMbBIeTpA6Lt1l0+f/d/6FmXnU8XN9+jZN6LwJ5a+3onngirU
	 3r4NkAktcbUqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECCE240639;
	Wed, 16 Sep 2026 08:06:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DA0829B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8342A607CE
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZnl3eeRguuY for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 08:06:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 694DB605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789545998;
 b=ij0xqEx2EI0l5cWwFERPW8wOQLXGKYbMxbGv9CbRdPGJlwxVaGtzh9gvt2VqNs82Y2VP
 bKKg8VpZdmSETD8yrAAebIVMYmsPqq1xUpPu9ItO5hk8YP0izAezrumwymWPLBuF2u1MK
 kKda0+efcWR40PfOIpoVCYqpIS/4oJALqE9F80SJrNEti4WnsViXzxypAiUIoPjYO10av
 wCasnm+c8nyjllEfu09hvg8GiJS3nFkfaXQNl3AztZ8ucck2ZGamWkTPEhD7Kl+/obqgI
 2G8gb9fM68VwLrE8fpnurI2xnKFBSpo26JzNk8g/r1SIkeSeclAPjYfqC7BiQKFfbYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789545998;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=qYPxeuhK78oX+OPoweEIxK5E9QF+zzyUs32Txt0g63g=;
 b=eppCuKhGmdbQqGbdje6JWYjvfpayOUgV2Gzxl3SDwcQ0JnFkxVarqzLg7WgN7dqK3eTA
 F7Mi1pH+cCxFzCAhkHosNNSl/5EXMNLSp36IxFkpiU6D0X0N8thJGzQtLvBdf/BUc3bYA
 LKOC1GcVc85bf18m2RUp5jPN09C76gPxxCN2VBBLQvYMVSW1BG/I1lfRu/qj2YmhomTms
 NlsaEk8ih2WQdk/8YnMeExZSVFD3ifwFdIsCQ7dpc6QJRaScFap3L8FYWU2Z5ApNghJ5x
 CzA33yJEN1UkE6DbIHVn2I77zogJ7GqCyOYAtpBYsJobkSkZNxCUtoEQeyCdcxP3+iQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=monstr.eu; 
 dkim=pass header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b="cO/T6oTF"; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cO/T6oTF
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 694DB605E6
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:06:35 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60590a85cso1354119a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1789545993; x=1790150793;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qYPxeuhK78oX+OPoweEIxK5E9QF+zzyUs32Txt0g63g=;
 b=cO/T6oTFj2HgirPytTB/Ic6zQie7Caf4QGNAVbx+lV/6AWqEQ8dg9uUcbkT8vD062Q
 Eo5NaaYbWEPyJ51NW5Pz6WReG4ORbdD1Ch2+ej/iEmqrGpS4AKUMmnkbydx9yKPLc+cl
 RwdA873yNUuUfzsXroV5SCVea0yvlLeU2k5tnHrQGLXvAULunfnZAAGgGcf6Z5vhFl/x
 eLfOqD30S000JOB4TqyqbyExEnvac9ponqRHi/gyFCCFjSNeY5C80IOMLd5JJ1LfjrIh
 TLeqsezBg/w7KVs8g171z46Agc14wLCLOs3nMz0uUl28P/uPxdJkCqioFAAm14vzvc8j
 9tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789545993; x=1790150793;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qYPxeuhK78oX+OPoweEIxK5E9QF+zzyUs32Txt0g63g=;
 b=kVf9guS+B74t1bNVi9OW2XJhBFRatxvZZmKVyb0vS/xVG2+5oMR4mihqshhpxN8pjb
 eMpxaeX1JzyaZkU8eLbTmz1Iyk0YXzQHQbZvhlA74LLKd696mXG5nVXBn1bb5GN2gaKf
 JHoaDVEJebf2XLGwh0gOCBrAAoH72Y5GA3W2AwZe5JLCCMuZrm6W9yGg6MGsV3h6BL1V
 luiqggpsd3AnBTJuTl2b4dFQ97eHExaMRCG3vhccgBbes78rp+GPqnHinMtfcJ3IZaIA
 Zdjp0DR9L8szV3vS6mEJkqD6K542yp7eId6c9YV/5xz2sc6ZMFR17qa0tUBopX82k3nk
 g03w==
X-Gm-Message-State: AFuF++l7A2+7toOSLm8Fw85dHTScJ+6TqWng/0dpxy0wczP6uAQGSciE
 68fW1x+0puYOQwFQ2CY33FbHmyIwdDFN74g0HjoEVB+XmTrjDzCCFjV0/DCBNZP7H9+NyR/IKs3
 BbLTiTg==
X-Gm-Gg: AYBFou2kS2noKAF99HZyWTsLtixI2KaWJFWb+0KGc3LBG73svdHk7aCzLJ3wp/+rmxj
 FYEltDxuLAbks0Hoh2qnNVlCDiIFY97TbCc/GHimE81M3dmPi6XnVj9Nn3pipZ/PS3GFAQUw3mt
 Tx8BjHQvuGE0Ccno6l/IMC6b6lpuGMwdswMA8tsLqoSqH3AY6lieXY433daOU0KL2jUfIOYH7CU
 qQsGVBXMECk2LL02Ihyc/6QI5IPV0v+iWole4HCSrgIFH9OZkV/S0fwCFrslNA6N5WqUJmvDkOW
 fnQbzLH1CEUZqRPk5S+H6z8ggUDFzUzQdqY6oqFCdyX3P4OCkdoPGEFG85tRPIs8YK+TWjzsP2M
 DfJBvTIz2o/pZ/CrSwns3Ltp0Jdvy91e15hLrZ8JBBdjjZ4vlr8o1kKmOvFtdm28F5tMKPv3BNm
 qxBv6VYvtAuix0FOuVVIYT18QxqlexCnRMWB60h1CnDDrrBSShbUGq2i7BzfARFX7wynJZSbs6C
 rZvlIqbRr5Khn75bHuGE1V7+OeQINDM
X-Received: by 2002:a05:6402:1ed1:b0:6a6:32f6:c with SMTP id
 4fb4d7f45d1cf-6aa2238242emr1061096a12.18.1789545992894; 
 Wed, 16 Sep 2026 01:06:32 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d228edfsm1101025a12.10.2026.09.16.01.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:06:32 -0700 (PDT)
Message-ID: <43dddd2f-ce41-4b4d-aafb-d006694729f7@monstr.eu>
Date: Wed, 16 Sep 2026 10:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
To: Sriram Sriram <sriramsriram@linux.microsoft.com>, maarten.brock@sttls.nl
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, ankluemk@microsoft.com
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
 <2ec7a375-ef8c-4ecb-ad1b-cfbf3ce12b96@amd.com>
 <GV2PR05MB1194135296D564695A241EA6183BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <905a8de9-8c62-437a-ba4b-0c8b4ef8fe00@monstr.eu>
 <aqmbXo4nLvq+EGOO@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <aqmbXo4nLvq+EGOO@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

> One thing neither patch touches, which I am happy to send separately if
> you want it:
> 
> 	board_local_name = calloc(1, MAX_NAME_LENGTH);
> 	if (!board_info)
> 		return NULL;
> 
> The calloc() result is never checked -- the test is on board_info -- so
> an allocation failure leaves a NULL destination for the first
> strcat()/strlcat().  And that early return leaks board_local_name,
> where every other exit goes through the error: label and frees it.
> Both look like the same typo.

Yes. Please send a patch for it with also 2/2 from this series.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

