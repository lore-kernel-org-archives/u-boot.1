Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38C4CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DDDB80E73;
	Wed,  7 Oct 2026 16:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kY_rRbUkIhO1; Wed,  7 Oct 2026 16:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AE93E80E87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791391010;
	b=f7xYfc2GOtkaR1ZHrpk1xOHzlkyjZv07ltXPfM/KNRcOvFzH1EXxLcuj9hUeTRNhZ/Sn
	 cvd/cxy1idmQ44wSadvLCj6DLRb9LMpzA9ikaEwan9LTocxRoNWIe/zhe+MXNCEign/ve
	 kIhszt5qaG0aUXitg78B2kVVyeTpFcZJ0iQJmY+HF2Bd1v+v1lNRguqIoDmw8e2eA64/o
	 T6fWvOX6wxMgdsuV02yhh7O2UvgeP9iW7d1+vgfm+0gJjhj0M/fgHgxFklzNWBZpgNZi8
	 hbwzkYGo280mh+K/2ITT6IxxlhiwZ/05SgGF+1ayXqpdWpbm9OlFIyIwHS+jTxdtYMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791391010;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KSOlpb/dkvniyu83u7qWf/subbLLCeyhwrYOIz4q+u4=;
	b=TZXF4EsmurWWI+TQLvOMIAoR//NDpOTTTNXtc8jnop8oOzwY3FHLf5I9MPdHUih+mXYI
	 vs+zPDNtgj5cFe/MSHNv40MpKMiOs+7RqwtCKekETR3DtndbQnDGawAnz0BcuO2F8H2h9
	 EidFIxClb2MSdVlFQiXy6QO2UZu8LTO+9mpnuLbPj/bAhRZrGZvrXBnak/HLuQeih8RLQ
	 irKH8YUrEWaaCOwd/3WbvT4kR6EQhHo+JSy0GyG0illI6StYgnoucowMzhS5PVjM9Oy8o
	 jsTMy7zWczrkaDvIIQUyYsRHc75yRJhtgR3/xaUG25WDRlCewhWRTX3n2gfRzOJnSXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EgbPiXSh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dBKtTRUI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791391010;
	bh=KSOlpb/dkvniyu83u7qWf/subbLLCeyhwrYOIz4q+u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JTI8ksyhK+Vl7fo/0PNFuvShUSz2z5Sjg45CjdURZ/Y3VjRoZVvHrdVdaW7a6glgT
	 143PcZyZbqv6Ck/Myr2cRYjLpLX0qTQ/MIVyMejjvr7lrqJQUjvtE52ynorIaxwLAr
	 qBdZNfar0c9pIErMhb/w/gQEJBFWEgZZEKiErwmNnLexsFa+x4xM8R7Kw6uWvGHDOu
	 aA8rLhrNSnTBxJkoe5ZrP4L6OZ1W6zB+AYO51z8VZE9nGA5dR8td+V4FwNbiRtwIKM
	 y4dlPF8jIfhfdTtuQiz3Vd3HOUlb9Gv1qGp8LhVXURwDLReZAer0swbxCQcSWSpGiN
	 uDOVJXQ3BodGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE93E80E87;
	Wed,  7 Oct 2026 16:36:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC10332F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE6E080E34
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUxsrau_0EfA for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 692FE809CA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791382108;
 b=oUD2QxlQrP10iCw/LH6orhwVryZ7ZDyxnQqa9mPK41H+koTu2vO3C815jWbVElP+Ypjj
 PjhMvmBah3KNMtHrt18+uk6Sn6aNcw843lCLXuCbFICzlJb/KUKXRpdzU8NRPYEr89O2g
 2oKNlQDrXF3826W+vrjLX+ADSyGuKro+xRp0Y/G2ULo6CIf2XlJSo8kb+GeMsPrShJ0fQ
 U1la8AbN45KX1paAa2hNPSeMcTpPQ8pWxuNpg4ag7wwye2isssq/smbTBEOVsjf5TQUv5
 UXmE3BlrIzGdeD1do73rMYxopdrYO+J9r3/XLvQwLyxYWn+W3fT84qQrRnHrainDDXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791382108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=KSOlpb/dkvniyu83u7qWf/subbLLCeyhwrYOIz4q+u4=;
 b=PbeyZ6MNVEvcbjwuMni0ts6IaFGbKTFExj8rSTJrM9NHj+RCxT2nTd7hYNdE++2wXMq9
 a6cw0O4AOhhQgn9bGjR//Lg2wtUbeF27DJHmuRMHZgWObG0MPGGMGX92MV0kaKyNtnReH
 RoGOWiwTX92438CCCxhrsMLpG5vXQDzEfNpoYXttjvWig7ULanKIQy0k0DWaRaiLZISjK
 I2+Uz/RORQjdrlnc6ACg3n1+jX/7lL1UXELGQbs9x9mG+YNeTShyOt7whf5cS3P+bSwcD
 59a6q2hYRHPW1XT8thxhdsVqW2kdgrzTpmgz5Bjz7g/PSNtQKPKDThKPlg1DW10Okig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EgbPiXSh; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dBKtTRUI; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EgbPiXSh; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dBKtTRUI
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 692FE809CA
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:08:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVKQf3463148
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 14:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KSOlpb/dkvniyu83u7qWf/subbLLCeyhwrYOIz4q+u4=; b=EgbPiXShO6tKSTpI
 JRCcvD9Nhzmd9QmnTD4GXOYPIarjuvOJ5uu5cHx5CQHNcoiPaI7xGUdTzTmSq1fX
 vgRnOveXCkKYnZ6Hv4lc+O9L0w/W0r279SckbJsmptRts/VukOmMZm6cGYG/pB7f
 k9S1L+NmOVTd5eRqYlCQVGKL7vqPomiJVoaqsSRvuvbbvd+8Pp7LXt87lzZiY42u
 OAF5nkTA536Ig2uPf9Xz6bzZDBIxIZEAkrSbAA2xEFZTmoHx+8Z/kDXOZ5OODPrL
 VK8fErVK07dyz6m6J9ROQjRafJY1eOVQHsiyfEVJn9vrQX6L1In9xpjpbqeWwyS7
 VoW25A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c67adup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 14:08:25 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-98c46da4b04so3101883241.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791382105; x=1791986905;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KSOlpb/dkvniyu83u7qWf/subbLLCeyhwrYOIz4q+u4=;
 b=dBKtTRUIJ0Rr7DEuDr4kjP5+RdBfIaliO1xRoV+OtV9BkrFDAZ8v51f0dQcoN11RV8
 ms8GAaJxmn6lczykX1mxVSYNLVyUR8Cgc045dblNwoLW7XthyjL0laJFVOCejNiQkHAu
 NquiuwuiLXQgh5WSVcS+Dr3+5aByCKkSd/vthXhQc8Eh4SiKjdB2WzioF8WCcL7etkrH
 NQZh3A3RGU4vpXppIqh3zFGjAPMDKhryrjTF+Q58qKdYv3aFSMOZy6LMqYcTOhZFD65C
 0Z6Mv0WLBk7SzfM/5VXB2+kujn7CHCMxl2swngUjyaU1kfCDeiqniPjIx+Seo5dglLH/
 kf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791382105; x=1791986905;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KSOlpb/dkvniyu83u7qWf/subbLLCeyhwrYOIz4q+u4=;
 b=rxD1kSTDxCsGjpzoF0oeFyEb+0okKw2vlLITBah/UMlndyfkOZcKyNfOOaL0NSImII
 9GwF3wz6FdGVrlOEObhEpOdh2u/viSVwLJuXIm/KOLVngnjFOJu9eQJBV07INWQHOLe/
 M7kamM+Tb3jJmHTkUQdYyOaDRIPuqkTR4OOr4Bsh8BgxsVox9K3B171eOMA2RehUCp+i
 zapvmrLOEF+lLUMFutM/St70mJLZowiLz4qOxSeR0/Z5P5y+zlA9GkKU/PKXBpJVBf25
 Y+mxmaZbJ8uZ+suxv6xkEB5ArsXRrTFGOhPm/O3P6i8yMVXN6rBJBDVbsn5wC9n9suF8
 LJLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxkKl7zDpxev7pNwmePnUuhPdTu7VNmEM609d1GNSK/DOS7HoSkCppAhkavXK3qCva/Ya3xa8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKraeD/niVLj0+N5OrQklYVeADPk9+SnW5uf8MV+35RqLBfK0TF
 DGpS0Pfwf5yqOJ5gIbKdd8N52dFUQBWNsP2hu+/3Um2deVHPvq+23q+VcmxpUehrSzZoMu6ufvi
 Z99WVGtZJ4YhF/mb6ly/JZ7xEZDZS1RPcU8t8CjqDgKYRJ1z15/gXLpaO28XOzVIUS9AIN0lYlg
 fiYLvDRQ==
X-Gm-Gg: AYBFou1pW/BOgKGt4WBXgrMWFLmpw+ssNtkT4ZMp/+46ZHIWI/i+mnMPApUCWquI4r1
 bW6LD6s+qSDi+m5KqktgxaiwWTGNju6aal/NdVVwTi6h/xwUbgqpLkHLe7sLkkAjIwdZKP5hMVq
 p3XnBvxlBwFbyNAOGC2ZVS4QiyyI4E5k4hLpibC5gKBCJ3oi0rhF0nhRLF3Y3h8nnUL1tvEDpR5
 J24LtLu2xXo8nVNixJRzXtZd405RV5o0UFCUEjh+2jCYhGLTNK2knvzAPOH8r6PwrUo6Ve9Kcfm
 qsxmY2Azb2YnjtzmrvwKW5zlommkVSL6L8t+Bn2Oy5hNKDth1MwNwG4tXjvxVVIt8PPTr+P7Ter
 qVkAU5JKCWRIIaDti5nAbMfl4kC+wQefeLw==
X-Received: by 2002:a05:6102:c50:b0:7c4:6246:6ed7 with SMTP id
 ada2fe7eead31-7ca38dd1ca2mr770701137.26.1791382104741; 
 Wed, 07 Oct 2026 07:08:24 -0700 (PDT)
X-Received: by 2002:a05:6102:c50:b0:7c4:6246:6ed7 with SMTP id
 ada2fe7eead31-7ca38dd1ca2mr770696137.26.1791382104297; 
 Wed, 07 Oct 2026 07:08:24 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c317bdb3487sm108724566b.5.2026.10.07.07.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:08:23 -0700 (PDT)
Message-ID: <fa463da2-c4c2-4e3f-9513-d05c2e20b128@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 16:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: imx6: Restrict SCU reads to Cortex-A9 variant
 detection
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20261007110316.143181-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007110316.143181-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX/XwHsiI1Uwa3
 uxbcfiLw8UlvFwf4xgTuQa2vxPlKFey3ao6jc31T0u9/xM6aS1PE4B/v8v4qLvfKSyYErheeDbV
 VBuzXuxcQDNOjKv/VyJwI48JXa1xpUc=
X-Proofpoint-ORIG-GUID: kfKccFyCjFBTYkqvjFne_v5T0E0gCTl7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NiBTYWx0ZWRfX/jIJbyPKEon0
 HhhXOL9qXTkhDEDClAnC4tRqVm6vlWAWsHyISzOtMUHPIBfeCx3V5NYlYRc2RYRrtvokSWKEuWi
 CvLr8PsuCYh2F/2rzYXMMgb/BQbB0Mc9eaFk/ozKARcbJKjm7kd7SAx/nL8Eg4fssDCt6FE9hxY
 J35farS0Y5oRstpIMk8EqoSWaqaF9OJogyU4N7WVS4Pr8whrqdXbsBequ4xNOLELRyLFxmTHXWr
 VhflCCTE3EAWgb7nSlXDPwUZRa45tNSsJZA+YAimUTu5TFaZdYdfFMHWgFDBVKCIyL+GppNRSq9
 mPTl6TsgMQvt8HRiAQ8O69WGBCo7ZOnUgrc0wQz7aEtkce/Gga6px0O22klVHihZQJLF3nxnEcl
 S4l5nhsKwALEcDw/YYmNOtjoxchOEn82wqxp7gY1dMAObXKY7pFl/PtAytQzyCwf7iWQdZvauqx
 peEXFSbebD9lldlaiKA==
X-Authority-Analysis: v=2.4 cv=OfcNnRTY c=1 sm=1 tr=0 ts=6ac65259 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=H6XOjDzudmMbVQCwyIAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: kfKccFyCjFBTYkqvjFne_v5T0E0gCTl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070056
X-Mailman-Approved-At: Wed, 07 Oct 2026 16:12:25 +0000
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

Hi Bin,

On 7/10/26 13:03, Bin Meng wrote:
> get_cpu_rev() reads the Cortex-A9 SCU configuration register even on
> Cortex-A7 based i.MX6UL, i.MX6ULL and i.MX6ULZ SoCs, where the address
> is reserved.
> 
> Read the SCU configuration only for the raw MX6DL and MX6Q IDs, which
> need the core count to distinguish Solo, DualLite, Dual, Quad and Plus
> variants. Other SoCs skip the access.

$subject is a bit innacurate. Suggestion:

'''
arm: imx6: Only read SCU for i.MX6DL/i.MX6Q variant detection

get_cpu_rev() reads the Cortex-A9 SCU configuration register for every
i.MX6 variant except i.MX6SL. On the Cortex-A7 based i.MX6UL, i.MX6ULL
and i.MX6ULZ that address is reserved, so the read should not be
performed.

The value is only used to tell the Cortex-A9 variants apart: MX6DL vs
MX6SOLO, and MX6Q vs MX6D.  Read the SCU configuration only for the raw
MX6DL and MX6Q digprog IDs and leave 'cfg' at zero for all other SoCs,
which never consumed it.

Fixes: 94db66557997 ("mx6: Distinguish mx6dual from mx6quad")
'''

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
>   arch/arm/mach-imx/mx6/soc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
> index 02df86156d4..824e8ca6d8a 100644
> --- a/arch/arm/mach-imx/mx6/soc.c
> +++ b/arch/arm/mach-imx/mx6/soc.c
> @@ -71,15 +71,17 @@ u32 get_nr_cpus(void)
>   u32 get_cpu_rev(void)
>   {
>   	struct anatop_regs *anatop = (struct anatop_regs *)ANATOP_BASE_ADDR;
> +	struct scu_regs *scu = (struct scu_regs *)SCU_BASE_ADDR;
>   	u32 reg = readl(&anatop->digprog_sololite);
>   	u32 type = ((reg >> 16) & 0xff);
>   	u32 major, cfg = 0;
>   
>   	if (type != MXC_CPU_MX6SL) {
>   		reg = readl(&anatop->digprog);
> -		struct scu_regs *scu = (struct scu_regs *)SCU_BASE_ADDR;
> -		cfg = readl(&scu->config) & 3;
>   		type = ((reg >> 16) & 0xff);
> +		if (type == MXC_CPU_MX6DL || type == MXC_CPU_MX6Q)
> +			cfg = readl(&scu->config) & 3;
> +
>   		if (type == MXC_CPU_MX6DL) {
>   			if (!cfg)
>   				type = MXC_CPU_MX6SOLO;
> ---
> base-commit: 8d7bc8add17bbc69a58dfe0002eea039dd2dc1bc
> branch: imx6ul
> 

