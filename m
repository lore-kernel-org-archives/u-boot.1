Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B0ECC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 05:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DBCA6090C;
	Thu, 15 Oct 2026 05:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zsIDXrV6hcfi; Thu, 15 Oct 2026 05:48:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D2CA608FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792043338;
	b=tMi9vQwJ8nRsiIg+EGy9p8ct0cxYX20uU2quuKycYdfy4euiKFYnNJYTgBxfR7dnG5mC
	 /scI7pU6gNWdySEHmMKefVofjdpShX6Zp5uRaYYe0hjONbjifG3+AIHv8Tem1x3nfOPbB
	 ibSc0+izcvrqO3zl/p2WYUie+ncCGLcEb5+dd3+6I9Ko6Tn1vq+YzVihCt+P9wic6o9mP
	 LhVH6zVyoIBT5dgO/Vw6Mk6WJ4E7weOtsWki+Os8iP5Q6FD+n6TSq+QtHk4XGp3C3kAEK
	 /DcHwnxGTsnpBwPRCjWeaiE/fgUZKMA2qltAizE2+s8lI8aj3ehmqKGwk48Z9Chpwyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792043338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=24+wRPMNYioYiR032eL8HX0PpjrlUjf2bEqcilEroEw=;
	b=TN/UnQxS25kgNlfnh5NFlJe0EHK/IUgJC7RgwPpa7Q7hIdDLLlPeMyJQtVraEZnbKTP6
	 vAOwK63dkV7mfX+FqsdQlbulVz6YHTsj9ys1EltH3lUbp61Rx6yrovg3MxC727q/DFBTl
	 ewxqzueKI1OUjfbWjntinajSsJbUL8l2MT5Cznsj+si46+P139yGtbBh20k3RiKXSU1Ll
	 JxFz1UncarVDkFrkDtatHpSCbI8A1q6hylxWSJrtMC76mNGEY6Pq5kZlZwl2FRkDlxVDN
	 LnYYGNZipLU46QU0cPFfqAuE5TKkFNbi0p9hiCpNOrk6yAqKVLY+EwC51eqFKdxJ6hQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792043338;
	bh=24+wRPMNYioYiR032eL8HX0PpjrlUjf2bEqcilEroEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMW+pMws146GQV3F3G8NqQw1tbxkK/YTIbUUrjCnMzioLSdsMsfRyn0mBfjKH3iWu
	 e6a18L+BS8IltBvMAFvcwS/FfrdHN5oNg/l0dvRr9nduYG/tyWZntOC2HAd9fjG/5W
	 3OH2E5EA24mhF/2vYbM8bcoDctkGap94wov/FoJ+zgFPaeNm3uV7C6o+Hez8CfeB6b
	 cSNg1mApdF/VAz48pNQrNTjNFt4l+x/makNsXWWmnipiz1nIYx0P+JZ2B9k46yJVcT
	 oXds1gb75EcTbgltqwVlJmXlJq17x7J4s7Tr4WxAxzCItAxBg8TUA1gyVbY8ex/zLM
	 +1bsbbRSAd02g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D2CA608FC;
	Thu, 15 Oct 2026 05:48:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5738C1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 550F740376
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oofwZkEkZuAo for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 05:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A138E4009C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792043336;
 b=ikkkxwqzmFc3x0OWrkYVlrDn05LZMOSBweg49LQmQ/rTiws8bU1w6qrbaC3r0/3yDVzU
 w/orOR391LDSMtFjUT8C6KUD3eW1aywyjBqWzCInqtkk1BBgpKqE1wgnQ5IObtSUaMziF
 Zr+bEGA7LIGaFI0AbuMKnseJ2JC6YOtUK9L6W+d8kzKzduCVvTvaMHoAYzaHXzNlb9Jwt
 EWKHJoAG6dFO8N3MWAY1Wgpgs2fgBVTJX35rtqGUGiWy6Lot3lVuaTTC/5PhBvnzp56Zm
 OJATaCDv22Ca18JYTORvgFGF9uWN4I4UQxgrFjkn40xHscxFhTMsKdR4KUVGuNpwK5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792043336;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=24+wRPMNYioYiR032eL8HX0PpjrlUjf2bEqcilEroEw=;
 b=iQvjOQRkn+um8qntQMWbC25IU2/vtF8C6390l0/hdWfhXMNJG97IXIrcdpFs1lSkA4iW
 4p/61Tscb3yy1Mv3k0odkuNH1tmjqyLj64cmkjYV4z73cy4yuIiTW0/Tou5N9EKnreSDr
 /L5UpMA4LfPdmXZa4Ob43Kz0jCdU52eRt1MA6zp4DcQqKLZ/rGehEv0kjrEVqFM4IANGm
 72hL3p/wa2hAebyveNiH9cnC7AF1fLHdqtAI5e9cPwjP4FOhxcQrugUugbmZt+ya5wFif
 5d0wel3mU0exdz29T9gadhWTNVixGMuFouFA7Umed/+gvpAPPWqbK433Pv8gjZAc7pA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hFvOW3HD; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z0E77N4n; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hFvOW3HD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z0E77N4n
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A138E4009C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:48:54 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F2AXqB841678
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 24+wRPMNYioYiR032eL8HX0PpjrlUjf2bEqcilEroEw=; b=hFvOW3HDUjqxHgG9
 84ZlGbdMIlO2CAE8/CJq2ohA1i8vsoqzmUUXNRVZmKcbvR05ug2JCfhPHAENvEXJ
 Yr3QWsOyR5Y6nY9orek1/PYm0A593S/amJwnnyU6c+rcWUCH/xOKn0otfkAMAXfy
 NTpZIiue3yBGdsj4mOwq/pOwAf85yIN5t8v8TnHJsV+VvCHuQXRVcAUsBgpWb7wy
 YcPis7asq7qMTt9r52xMLCfnlYqQ+BgeCcAOgVKPbYtnjktbvzea8ipTvDseG0ll
 pHdSoSwxmw7YDpqlHAdKGKgLB7oweTEc01vOXbs16/XwVhZIBAvnr4rqfn8aeUO9
 vDk89Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wtbs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:48:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3515266f6eeso3197263eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 22:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792043333; x=1792648133;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=24+wRPMNYioYiR032eL8HX0PpjrlUjf2bEqcilEroEw=;
 b=Z0E77N4nSy5wX0MTqMZ9swB+QBbuvi/YzAlIh31DNOtKP3ePn9rLECya0/xl+sx0EH
 03hG6EhSG0Np6HIBeXWcEsv8RP5j21aSnQG0CMF97vCXfMIeISEIXlZDOeRisIgCrU89
 bG8nEMorfeBRSXO5/Dfbjk6WmGOt4RA6oKQB20MS806BmJLrXv0ZvlEnNzP854WDfjur
 z3IXd2UHUUrjsAbp2leGJA7ynkmyJpWGNjbFlJdKSPmEfDDe6uTbgMlgstP5kYHJ/Od+
 P2Gqs4yZkBAqtSUYEAoJ2oTtcNTf5lkPCtvyZ5D10w5Qd1RXFXY7TOnxCEexsauZRF0t
 bVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792043333; x=1792648133;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=24+wRPMNYioYiR032eL8HX0PpjrlUjf2bEqcilEroEw=;
 b=k9pwbQ01ngkg3elF7IC2GzMzDZpXcoYfYWVTyK+E+seNXUSOsp0mHJMXdleIF9U7mj
 3U4RI62wK8g6lGph4aTZWsDkMd99Sk6Jqipob764gf7PFrnC+KdLk8PBEUHQQ5XjBxHA
 xNr8jlDuKNKvcs5bp6Bpmo2QXkipWGKS0DbRttroLQX5pBz8js7jCLRR4AOgxHgPyB62
 JW4rcQTpbaEURyebMCHRhMNYvT2KM/eRdj8ISSMQ0jFBorh5nc5D4/8b9po4VSW8Hj/u
 p0N2Lv+9D+gdi2MLwR/lZ6eVKPu2UiWIiNmGuwj10YYmL3SlDXMGcFJ4ZcKE7PZaFyaB
 fvQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF+u58ivmAteqYl560Ah1tSRvHnruYIsZbL51xCSaP/COj2gyLrkC+iVlsFSqA17Dqy0tY9Ec=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgU6bgiMveVoM+GgbUMb1FGK6oSo6qR9vQTGx8BvWRwTq2xXlp
 Jv1rWsSReBvaGNXIvsbJCpUO3GCUq0jWoBK/Kv52pjA2coxI9e42NSJ4DJpeHrAB8KaRCxHK777
 o9tCvxwBUPZzDHy789H0PxwM/dkW8R9umEhQyIfi3SXS0k2SOAZrEb3TBszJzWMNQXz8pTkA=
X-Gm-Gg: AYBFou3v49A/upIWeGe+zKRTFFIwioQpOmXXbNNI/cHtRFjFCmTxRn82+XEsAqpv2zy
 1KBSaGvJ/jq/Ccg+ACqFQZ5X64AgdS+kB+OMbYJGPA4ruobDvZERAJG3l6mn2+g7ZPy7iLWHM76
 BbJwWXcgR2ZjyLZ0u42/BiyKVnQjpQJyi/BsWTK5kOBso3VbcL6kAwSbAmbPuwV/u7YlSi9zIFR
 0tMfZxBuJOKXz1xpIP63DYh593xZK98Fql6q2w7UCvNR2qP5x5SuCR50VPgL3rxXTk+G7LNCSZE
 lVu4PhwEDCXMPeJRyk3iSxzLUZ3csHhIOAznDcyiyI/7b057vGjU0Am5kJYXVuC0HSCmFgtENyu
 BJnHLziBHNFZzh9exyad5qfW0jeuIStIc5dgVnA==
X-Received: by 2002:a05:7300:559d:b0:359:8492:2107 with SMTP id
 5a478bee46e88-3598492227bmr19636765eec.10.1792043332883; 
 Wed, 14 Oct 2026 22:48:52 -0700 (PDT)
X-Received: by 2002:a05:7300:559d:b0:359:8492:2107 with SMTP id
 5a478bee46e88-3598492227bmr19636726eec.10.1792043332289; 
 Wed, 14 Oct 2026 22:48:52 -0700 (PDT)
Received: from [10.151.41.177] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm44843369eec.31.2026.10.14.22.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 22:48:51 -0700 (PDT)
Message-ID: <9993604a-8d24-4760-bf66-c77947b81f86@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:18:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: sa8775p: Add QUPv3 wrapper 3 SPI clock
 support
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20261013-b4-sa8775p-qup3-spi-clk-v2-1-bd6365d81a7b@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261013-b4-sa8775p-qup3-spi-clk-v2-1-bd6365d81a7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyMiBTYWx0ZWRfX85etrronkW/t
 l431Vch7RJEozUu2WGHs4KOBIyvcad0rjaMsAkDLCYXUusactxIvTy58IpDMWwhC9GrSgDPBjrf
 HTG66wRANuyya53cXXSa3XLIkl30fBM=
X-Proofpoint-ORIG-GUID: YKUbdIWWaK8yKAkwAgB3oCMsNVyz1csu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyMiBTYWx0ZWRfX5UC1XmywoiTk
 ymqGESki7i/2cv3h/8tqZjnzUeqoNuwWM5U9onN9AOAiPRqLp2qAoiZ6bBKBrt562HMMlLqFkZU
 scc8/EfEfuhwudbgT9EyR8ZJu5Pt4zFcck6+qQX8Dm5i1501nAP8OM3zX+km5i52kOiQrYZveBt
 De33Mcjv6r8O2ix2KfwkPquNH+M5w1gNLZAVcQRbXpArtyz/DwqP+3Mg2H08Mt6U2UigZbrQBVb
 H+vG5bm+II2tJFFq8z83RTYP9+GcU9AhyweJN8fbjNivKc86GlCuq7yJvd0B/KQ6MOJSUNW7jw5
 oxxZVW9h/Nwp1nYcKHYxWfTOLtN2ljxgrOLWG++i8QnjdgEYVMgbupykNOojm1UUkpZ9qiLNGPr
 S94wjeu0+6kikZog0Rxcx3Bz2fGj84N5+HXd24/o7FfN9HHruEzmJtCMRcLZl48jZUVrpbqLP2e
 phluqVNMtrNRGOz4SFQ==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad06945 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=r6LF-9bVAAAA:8 a=EUspDBNiAAAA:8 a=Ic7GsHKTbPjmH27owjIA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=sL0kBDm1BSwOBZmmfnro:22
X-Proofpoint-GUID: YKUbdIWWaK8yKAkwAgB3oCMsNVyz1csu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150022
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

Hi Vandhiadevan,

On 10/13/2026 12:05 PM, Vandhiadevan Karunamoorthy wrote:
> Add the clock RCG, gate bit definitions, and frequency table needed
> to enable and configure the SE0 (SPI) serial engine clock on QUPv3
> wrapper 3, GCC_QUPV3_WRAP3_S0_CLK. This is required to bring up the
> GENI SPI controller on QUPv3 wrapper 3, e.g. for SPI-NOR flash
> attached to that wrapper.
>
> Also add the wrapper's M-AHB/S-AHB clock gates, and the QSPI/AGGRE-NOC
> gates that are auto-enabled alongside the SE0 clock.

Pls mention the kernel commit this was taken from.

With that,

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

>
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebase on top of upstream main; no functional change
> - Repost: v1 was sent with a wrong author/Message-Id domain (test.com)
> - Link to v1: https://patch.msgid.link/20260924-b4-sa8775p-qup3-spi-clk-v1-1-8e9c297a20b6@test.com
> ---
>   drivers/clk/qcom/clock-sa8775p.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index a7bd6c43004..9ac914802a3 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -18,6 +18,7 @@
>   #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
>   #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
>   #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
> +#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4154
>   
>   #define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
>   #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
> @@ -50,7 +51,27 @@
>   #define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
>   #define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
>   
> +#define GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT BIT(20)
>   #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
> +#define GCC_QUPV3_WRAP3_QSPI_ENA_BIT BIT(26)
> +#define GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT BIT(27)
> +#define GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT BIT(28)
> +
> +/* QUP Wrapper 3 SE0 (SPI) clock frequency table */
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
> +	F(7372800,   CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> +	F(14745600,  CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> +	F(19200000,  CFG_CLK_SRC_CXO,        1,   0,     0),
> +	F(29491200,  CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> +	F(32000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    75),
> +	F(48000000,  CFG_CLK_SRC_GPLL0,      2,   4,    25),
> +	F(64000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,  16,    75),
> +	F(75000000,  CFG_CLK_SRC_GPLL0_EVEN, 4,   0,     0),
> +	F(80000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   4,    15),
> +	F(96000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    25),
> +	F(100000000, CFG_CLK_SRC_GPLL0,      6,   0,     0),
> +	{ }
> +};
>   
>   /* UFS AXI clock frequency table */
>   static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
> @@ -148,6 +169,12 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>   		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
>   				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>   		return freq->freq;
> +	case GCC_QUPV3_WRAP3_S0_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n,
> +				     freq->src, 16);
> +		return freq->freq;
>   	default:
>   		return 0;
>   	}
> @@ -190,7 +217,11 @@ static const struct gate_clk sa8775p_clks[] = {
>   	GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018, GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
>   
>   	/* QUP Wrapper 3 clocks */
> +	GATE_CLK(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT),
>   	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, GCC_QUPV3_WRAP3_QSPI_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT),
> +	GATE_CLK(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT),
>   
>   	/* UFS PHY clocks */
>   	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
> @@ -230,6 +261,10 @@ static int sa8775p_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
>   		break;
> +	case GCC_QUPV3_WRAP3_S0_CLK:
> +		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_QSPI_CLK);
> +		qcom_gate_clk_en(priv, GCC_AGGRE_NOC_QUPV3_AXI_CLK);
> +		break;
>   	}
>   
>   	return qcom_gate_clk_en(priv, clk->id);
>
> ---
> base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
> change-id: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea
>
> Best regards,
> --
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
