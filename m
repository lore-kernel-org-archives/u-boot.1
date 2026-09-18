Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8B8C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A4CE60C13;
	Fri, 18 Sep 2026 20:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qKg193FkB4tN; Fri, 18 Sep 2026 20:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4421060BF7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762529;
	b=oP4oDVIeUtnbf93lgjD8Owhhx3drZvqWhOPPAE+3bgYxxAifsIHV7O2KalSoefELDGi7
	 w17iyWVurltyw44ir6vaWkmaZ04vFQ1EuQEzS6g8BczPNa0ELN7e9fQIr4utATWoMm0eZ
	 3ie35+xMgxqqM0SWcT0XptDgl5q2AdNj9w/nEprD7qY3vYVKDxDHko10lS7TkXmCKthI4
	 JDmxh54/Hv2RjPPA69613+LLmFGsnQ3dTUWOIqSjS0ds9dQAH5Mzc+WGi7FPx4rB67wGe
	 6iPOVfmdhB5ks8mBvEh6Lrm0RWjP8Xk8Q5QL1svfuk/0hDb5Z155qAn/eU6naPmn0rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TB3ZSPZnks6esKLctIpqYok4D7JkFfG7y9UJ1sa6f7Q=;
	b=oxSi4lzPxwSgg9+1A4MZ1ocANo6J25NuN2WDoHCzxFoyvIVv21aROuRzh54n17iavIj5
	 GMJTAQF+lwhWar7mV9lB3AhqyR+b3hqLoAK6Z5yCTLL803RQLE5Dq20Vi0BLwQZbeFCO9
	 bB3LbmYwEr2iAqNvAArCFZqXdl/+OIyFlu9P++EkXIntrDGQ87Ao7GyTevbMKQGd9hh3+
	 k6iPbR32m6KPlvKH1FMrHTduk2C5FwEgksDXaAD0SD9EjMP+hvefNCj0tMPtWBOMNGgKG
	 fZ+uAL57V0wWDqryEegPbfcMBu/eXbxMDtx8XgTD2bqOzyK0plYKFoojeWRwmZlUklw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEYwCsN2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rfw4lghI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762529;
	bh=TB3ZSPZnks6esKLctIpqYok4D7JkFfG7y9UJ1sa6f7Q=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D9njyLAnUUmAHQ2b4dMWqKaZGNqme2Rvyo40HKrv8Alc8RCpi74Z4mFVCq8+uG6PR
	 07wT32Bef+r2zGrVTSHwJdAL+RO4XdCzXoyIeNoURC+UvSy+buA8i3DHUTt7hr45DE
	 Lq0vnOqMN3Lw0BGCywW4w+Sd11dLJvlCJthjvxI2j2rE/7QHIUD9ul6rDSrPka2CDc
	 Qo7pZwYK2S+fx1pmm7N5Qqi2hWVNajpWxCYu8fGl7N6+8NIh/tzdFAGj1VXtLI6LPL
	 AyGnFbTxuwOcih/EN8bQlK7Pkx95UXf3x6UiM58sI/qperQvaoBW6mPLe7zwnot8oa
	 fcHJSIMSbMfxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4421060BF7;
	Fri, 18 Sep 2026 20:15:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB06813D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9179760BF7
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSeqyRw4s3Q1 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:15:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 870CE60BDA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762526;
 b=KCmj9HE9JpP+IH7zovtmVQ9BwX+1kBssBz2o3gKIY4DO2+BzFKv8k4Lnf5VULtjgkvwp
 f88JME38/PHuu4OQ/tMc4EBpD47EaSIORfZQyjDIwH7HfQNLZ3pVBjDQ4PaplXLWZGz3N
 Flb+qblptLW0UO6N2c4A/6Av95ILIRAFbr0RWZCP8YyLPIGZDJaSiQ9XczSgDc5FVsO3Y
 UsS2+9uboC195+4g5TZeXXCeL8ZD0NjoBc90ViJ8kw6aaQGwJw0IEXUNNeG5G73xmMNUd
 zj3emSLWLuzvO8mt+LJvb4rJdtyyOxVhV/LlGCGrR5mpPlMr2BWS9ZHGiuKiNWM0iHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762526;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=TB3ZSPZnks6esKLctIpqYok4D7JkFfG7y9UJ1sa6f7Q=;
 b=AFZc43kuKrfkgpq5NzfUVCMoH9Lw4Wk0ZetyZLI+aKPq6kdWaGlDj5mW7GkZBjzDtBh2
 rMiXyXBdD/NIlIvQ33p5zNGqSsJIbjwc1IgxmdlOMzECyl0oTHdVQE6GOuzFp83vbQ8rH
 U2x6x3WQOD4m9IK3b8JmIUOmIDx0YovKhBBO7DDHo5YdKXSEBr9B07jznk1UfMk6soc+Y
 ++9jtbvS6goj/RCT+BH5vBL09kD8cjcMHLgr0jrgBfuvpXWkfMifrmVvxWLkImGSTKsOM
 VtvsdjGYZny8lYoL3HhyZaGmP/ES1IRzhuVtWBUyv1Qjtzg4/1bMxd81ECEv3+XHT+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TEYwCsN2; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rfw4lghI; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEYwCsN2; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rfw4lghI
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 870CE60BDA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:15:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IKF4Bx2265394
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TB3ZSPZnks6esKLctIpqYok4
 D7JkFfG7y9UJ1sa6f7Q=; b=TEYwCsN2Vw1R2uVvIDtPkRZDrUTokqpQCcK3AgwD
 sIZ17Ba12uk1kE7ixiLFZMVpUlMzNZPJCal62NmsWkV+8UieTNAJS4PEcTRnNZiV
 X+UveDThzM26MjHX0g8RjD5/jWNSA3BUG7/Cz1Gvt2F76afCw86UV55cKu3Vvr19
 hfuclysUmSZol5FIiZLh1BDqiPOMdnLruQL2gKXTV+QgPSj9D/+qdMV6gO8Ufbfq
 2950g9HVEz1tnRypKBUMuarG2zGBCdNt6vE3WRIYPE8zPRZz5twkBV80OoceOm1z
 n1B7AOqA7CuxJbxVL8Sjly+u05TvUAFwfzgb/fx+VeVTCA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs2hvakuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:15:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a0050a554so281170085a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762524; x=1790367324;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TB3ZSPZnks6esKLctIpqYok4D7JkFfG7y9UJ1sa6f7Q=;
 b=Rfw4lghIDMvBbmNfADzHs6dpoDgFif8Tg3rE9SSc2bETEFfG8WLBeZCZuSNXmlopjw
 IAF+v/OBswYbh1qnfEn16MZ5aEr69VC7g0m5MMd3j3WtJWJO2SKa3SybUMMMQJqHzwJK
 HjWex9JiL+WaYRFWbE5bULGsuoaQD9ht2z0NmOYsLhZCcWV+hmeoyAa/nKKlOeHcJJZO
 l09fKbqnu82ctAqm6EVjoHwD4VTjahf0wjrvXe+inv6lKdO2xbxYlRDizuKPbUyLyEGN
 9sXhw8EsVeb8QjQCdyqywYKtFmdk0B+RHVBUo6URblV2uQErE0eiMA3x+RUrBpKlTHz4
 g4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762524; x=1790367324;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TB3ZSPZnks6esKLctIpqYok4D7JkFfG7y9UJ1sa6f7Q=;
 b=Ko2SRhlNDINPZiVBACT7pA920tKvHqf7ZkH+mZDsQxOhacu32ZiKgKSUUUqqa8gE9B
 pebhqHzRIsjTouakdqqBBbV3n8rybkuSu934Ia1ZPO7VbIfLBTMz+3pwB58mEMdj7tdD
 EoThhWipFzwRaQ3LFQWp0DT0ZVBNd2uXd/hGtUXN9QUOknK59bRsalag1M7GKoglq1Ga
 JJqH9Wm2GWznJzKpvjjZz6Rs8LGFa15Jo+8n5hg8UO/gzXgeBn7ji34X/IbBe/EgNC2X
 CPCCSBKaLCRLWoD6A1mFbEixT0gv558FpNRQ4+SSzV/OobhnDr18Kj/esIo3zdDb2fKf
 T5fw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLUDGEv/hGZG5xI9ADUlg8D2Fm239xjssw1TkiLuL/lI5mOBPxbk3UInPUvCeTkuq+UF35nDc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lnWYFHlT15E68exP2XOjblyJhI6wGtwyaOhjSXO0mdY7Nnlaye
 TgXkpDV3WrQBabT2V9u4fh1dbYRQTkG28K/51pirfRjYp5cpnU6uPkmtu/hYHGV8Fee2Vo3C8UO
 GNCKbw266eEOMkSZfxZ4YdvfWx17pCaAiMO+wFJoMV3uBMEYejw4CWVdk2p5ds6PY+LlDj1k=
X-Gm-Gg: AYBFou1soraz9Ep41svYXRbLWvvCmcc6LgIHfxeNhS1jNdUJ1Rb/MnAnKSZtgiE825U
 2usiBgusoYDoy2wntfEDJ4+5t+4bJQj0IDqPvRDcfmJ1eR0A4blE3jhmoc5k4XDGNjOxUjRHBNg
 /Ot673y6HxNV0jzKptL0H475ctI8pUog/jbFwYV3hgDTHZ0X4N+n9+kn5mPlDwGN8AfduNfpL2z
 F2N3OoUxbbCBc4rFQtbvdFZsIYwREUdJ+nsClOiX399UaxH2rXaEQRv6s2CWmay+IX620Prd6Ui
 dQ+tpBoF1p+JWtBdgZeHfdHbMPmZ3loUtXFFL8bg+BAvOL1FY41o8DHipH29cMENOFOw0Y2EQlU
 q9GjcJfXxyqGf9Ql1FOmNiI68Wz4wSU4=
X-Received: by 2002:a05:620a:17a0:b0:93b:d79e:18f6 with SMTP id
 af79cd13be357-93bdc7ac02cmr525520485a.57.1789762523883; 
 Fri, 18 Sep 2026 13:15:23 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:93b:d79e:18f6 with SMTP id
 af79cd13be357-93bdc7ac02cmr525513985a.57.1789762523353; 
 Fri, 18 Sep 2026 13:15:23 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcce144b1sm29415665e9.0.2026.09.18.13.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:15:21 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Fri, 18 Sep 2026 22:15:20 +0200
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, neil.armstrong@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, xypron.glpk@gmx.de,
 s-vadapalli@ti.com, michal.simek@amd.com, jbx6244@gmail.com,
 marek.vasut+renesas@mailbox.org, sumit.garg@oss.qualcomm.com,
 jens.wiklander@oss.qualcomm.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Message-ID: <aq2b2AspOcySKRvl@trex>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MiBTYWx0ZWRfX+KN+0LMQGFHi
 ZlNG5b4onMF2T0gsEsyIT6PuS1toCcu5+JAOA+XL4FTkO3FyHVL1uVuwtCSq8XqocUx91z5LT2w
 ccXc3tc7AklC74O33k1H7nd6ErWD73Y=
X-Authority-Analysis: v=2.4 cv=IOWXmQvG c=1 sm=1 tr=0 ts=6aad9bdc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=D19gQVrFAAAA:8 a=NEAV23lmAAAA:8
 a=gDVWFVDGi8OQoqQKifYA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MiBTYWx0ZWRfX/eoaRs+PAirG
 2HD0fH3mgVy/3c8Vp4a8na7fv4eRqZk7WMKEPXbGpof35JGPE2rM7kBmwsZ5Ke6t/CXeRfl2s3r
 pA6HC5IbDYbGSPM3WYegQ1kR3DWEu4QqSJBrD+fhvpMK5ofFPG6EBFhT1BmMlKhgpDKXVFkIdIP
 CGMKoRSIYE6PX8TAIZ0fVOAEb/4svmjuAhgjKD3Zn1YEvSBhl985wJxHLdTJ98RRVhCJri99FR6
 ozKwbHFSsIIK8VwZ+pdgHBF+LWAn1gztLr54tD4xCuQnJjnVOlriIAVRX7MtznAnlX0MNTug1hz
 S+hnWsFjYgzPs8F6nuKN8bUVZCgfpsFF8i3ymla95fgUq8Wc3vEhZVv/edPDBwMvWEXbyGQUvT4
 dJwTk70v20YeIqyTA83ZC4tOgTT91Ptp0geriTikkjZnYpRSfhzpUew3YXiVUfPSQBANIWiYBRw
 KnZMnpwTzuO320RHPCQ==
X-Proofpoint-ORIG-GUID: GY3w7MFUNSeT1RTlpJgNCjY1vS9tnTUy
X-Proofpoint-GUID: GY3w7MFUNSeT1RTlpJgNCjY1vS9tnTUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_06,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180292
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

On 18/09/26 22:06:32, Jorge Ramirez-Ortiz wrote:
> OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
> U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
> interface, which is bound to eMMC. SoCs that are UFS-only and have no
> eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
> secure storage from U-Boot today. This series adds that support.
> 
> It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
> (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
> the RPMB device and reports its kind, size and CID, then carries the
> signed frames. The legacy eMMC supplicant is preserved unchanged, only
> renamed to rpmb_emmc.c, with the new UFS backend added as a separate
> rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
> depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
> single RPMB transport. The subsystem interface is UFS-only for now; eMMC
> can be migrated onto it later as the legacy path is retired.
> 
> On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
> to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
> The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
> device-id string the Linux kernel builds (ufshcd_create_device_id()
> plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
> the one Linux would use.
> 
> The first patch is a standalone UFS descriptor fix the RPMB path depends
> on (UTF-16BE string decoding). A small preparatory patch surfaces the
> RESPONSE UPIU sense data from ufs_scsi_exec() so the transport can retry
> only on a power-on UNIT ATTENTION; the transport patch also bounces
> unaligned frames through a DMA-aligned buffer for the RPMB WLUN.
> 
> Note: reading UFS descriptors reliably also requires the descriptor
> data-segment cache-invalidation fix, which has already been posted and
> merged separately, so this series is based on top of it.
> 
> Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
> programs the RPMB key through U-Boot and reads/writes secure-storage
> objects, with the derived CID matching the Linux UFS device_id ABI.
> 
> Dependencies:
> Linux kernel:
>  https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
accepted in v4 --> https://lkml.org/lkml/2026/8/27/369

> Op-tee
>  https://github.com/OP-TEE/optee_os/pull/7881
and also following Ilias review https://github.com/OP-TEE/optee_os/pull/8007 (both merged)

For reference, at this point Linux can access RPMB and just u-boot pending on this set.
