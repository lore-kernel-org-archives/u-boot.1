Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7726CC6B09
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9260740619;
	Tue, 13 Oct 2026 05:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mwxP0SH_b7UC; Tue, 13 Oct 2026 05:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5262240609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869586;
	b=djaofFkqv193VEnR80JeLOVlz0RF8vHtL2BR0Ld39TiaOtp/aFXW3H+l0INL53VkdgAn
	 eCyxK1tH21CjFs9K95cWXBKj3HHFztQ1kfI/ARgmKbkZztGL9w3ZGKNHGnzkniT/LtNDJ
	 Dq+2XjpDsr4YG2dUMlRqAxK+V9W27/+f5qWpYenpSrNSQTA23/bqPNPstSeCwMGrenXDT
	 MddpGyspl+96Rksut0kCCkW3NHozfszU5GHJpq6D4xNLMCP/5xJenQ8eYSesqF0QSvuca
	 FraqYesn1bwBncWMrBLtiAfezcrx8Efq1zrU29hGbgjt2lKDrQCI6gzxXQEoYctzkMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ygxSnPWxhgArOS1rZEYGjrzBJF8Hcz/S+UHkJFJynwg=;
	b=jTfN0RImR/V1nyoPTg9TGTNvn74SmdXKxmt7HoUDxu8ir12lrl9vun1lUns9Sq2+S2q9
	 4ZfPwIbD79cc6Oxbz3ovFthOV6T/rSGtV2xv+nLLNGSSWZVzQ4D61rCbyCZdbr3EuqM0J
	 tSbClNI5noZwLGP6T4H6gXZNAgmbW6pQzsm87JrW7p+QVqTVczftvPQ/v+RciQJHVHsr0
	 ZhTt+6YtYZhhGOpSFXyWLMj1et4tjJ+6njIt+FO5YwJqapb3bCXkCczwltlTF0sf4cp5h
	 8m2EpTfRB4StOovYAOU52xfW55sgK6lABF70ToNNZ9WwDnzoUtAXP0wk3q+icmPWnsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869586;
	bh=ygxSnPWxhgArOS1rZEYGjrzBJF8Hcz/S+UHkJFJynwg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nvlgN8UhMeR8LSJIDVMul1aJ7FHgrw4UC9sx1ybXcIwjeQnNdDna9EWWSevcgQtMC
	 8Pi0iOjVGDjWUswiEsFqxBhL4ARtdtCoMwN3Iw1gucSLcHlQDpSv6NC91V67NfMe4i
	 295jDnT1f5s4nEjDFH8Z/eFkxR00iS1+DMRh1hM8bJnyryLBOucO93VZuoMwKrWkKo
	 +JOCwU9oGJLjg/5vCoQqtKA2UjFgNcOga2azQUFEgWfc4NfVkSWK5ZkJJ8pe/jXrQr
	 VAWfTUCQqdgEaTrNcit7jtJOxE8y1Brqot+X0a15WnW5FmTxXSjwu1ywB0dLGQHdoH
	 /iFXVP6tTKuUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5262240609;
	Tue, 13 Oct 2026 05:33:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A90F2DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E8EB4008E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-CPTiVa5bLN for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9A1ED40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869582;
 b=KPwsPf4SBgEXrfyA/wM1BI85DoHWqgRImR9YLGHkr8nZj8hnKJVBpvlXh+PevApn4RiC
 ThxikUXBqPTTmIbHaLjhg1N5QSEeFr8MCOHY0IV5L8F/acA3zSJXC1Pl5w9NRUEyEMECd
 RlfNGDQw5SDBw0feWUEPziaei2gUze/CGIwbdCRzZxvD/RPCZiHV3gHaXOvtcn/GP7zQv
 an5h5QZAT6TA27Q29gXxTofvizsULnh76Q4zJ7RkjK3poNlxp4O1A7stWac69r10NGaCq
 cmm6NSjLEOFHQ23PAHuPk0hrbUOop14S10ILSDYPe3bAh0QA5Q+QY1voxmR50jzfdnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869582;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ygxSnPWxhgArOS1rZEYGjrzBJF8Hcz/S+UHkJFJynwg=;
 b=PxSgFPtqPvl+ZCNSSlf5BXP/t7N4Hls+ao2wSIswMW6PKqKaSO2vqIdklM4WK5X/hb46
 EZKy8yKG2f6rFiFjP+D4qLmx5YTcPiYaepkaH3QXKDvg38jeeXt2QB21vh3WpkdG7s2Q6
 kHKcqlyZtfrLSP2vxoexCxooX8vMUgNxn4v8wAoFmT+fv53T4NRvjQxnHtqbM/eRZMfjy
 ZYMY1i9N0Fq9JnVZHdnNUiSFYS7ZVy2CzufF+FNmeWhStxIork2NF02Ync0IKln2BL7+a
 KVafDtcBmVhTz8h7sRf7VqYfZSPRpkj0aI5shL7WvU8cgq5+BmAdf9ngVvVxxzDlTBw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BCIZJP0+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WnsHybDM; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BCIZJP0+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WnsHybDM
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A1ED40068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21J7c989880
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ygxSnPWxhgA
 rOS1rZEYGjrzBJF8Hcz/S+UHkJFJynwg=; b=BCIZJP0+yXIjXNOK6SF0ChHdfp6
 tlzNW58YDNqBRQUdK1Texkt3AJPdfAhgRAnvIuZznvJD6YeQT9vCMCLxUls4cFxE
 9nx7eVpUmvUXes12St010ds1Re1ynU0h5ouAG/gJWJ4kzDBeT6PZH8jhdos/Yw9a
 7zXFXI/LQFRS/kNdJqXhOBX4G4/mcENmH8j66+js5bV2R6G1fhDolFNxVLj7aPGj
 pSrmMOQsQdB3UQYaz6xBx2teaUmF842MiIQOutkgwAZbIb7vk311v0zWGyeUZblR
 lPjJD58JiGF/VUSsSfFVMz3vgSytD1KwCPdaFfXPgaDRvlpO1VgbNk+wVIA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hc97y0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3515266f6eeso4924605eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869581; x=1792474381;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ygxSnPWxhgArOS1rZEYGjrzBJF8Hcz/S+UHkJFJynwg=;
 b=WnsHybDMWMLHajI2dl0Y5wN/olOrsTmUd7+ypQWNcmgYBmyWpaJx9nzKDHNueHPDnz
 ZNnfc1Jhhn8KMFt/vQe1JKSJnZK7X6VSumAdQWEiaIgCCGN9qhFPOsEDOhngUtwZnW/d
 IKmc0Ss4/7dQASQ3MFnKiqV5TJg4PO7o0Jwq0YmyaIT+qeOC1gfxHtdkorqzM2Hh3kip
 u1sI4MhfsppAWWnUT6ysWUEPJoqfaCJawdQdxxg+8EMF3WXYYl7XWC6k2kRxLMHeCVCW
 gNimMMErPFyIvZe4nTvN1SfrW2ZbiU16LR0py557BpMCT3Awwo4QRSdrtxKlH9BKI3MZ
 AY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869581; x=1792474381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ygxSnPWxhgArOS1rZEYGjrzBJF8Hcz/S+UHkJFJynwg=;
 b=vN3/Sggz3l8T/vHcEsiqzCSsmjYvze2Ru/l3dFEg7zeelc2p6vkh03O/bWd5lONnnI
 z1lCs4y7TCL9QHnmYswMIUT1si1befg3yXawh6iFx7VY3qRPR8wE+2XhJkLxjR/vwK30
 vCeRScmUWzwlTgMjNdRTRCTj/yL5wgh3XG9NBhtL/ZV85fZ1gLccveExb/ko+0iMkS6P
 H+JqushNdMGzLNxJvVuIlHTzkn5kQg9ZrGKlRhIHSt21URaA7kaAqeFAff6//NxDdtg9
 XdwNyIvcFNFjudsdD3UjneV2XP+tdabliqacICtx9Pnfv9KeH8A5dOSmCPdZLpTQmqdc
 I/oA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxa2CvsW2oRX9yw//uOPBYuK4VmUp1YnsMAqY+tGOgYKBJRFye9OlEi693ZCp/sEVNJXHaY81M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKC0t1q07vJS4F/i9UpkVCsNKRPO3vb5WD42RwmIpXhyA63Tdly
 anPERbRWhAfauuq8JOBOfgOPprZBuX1INKlyOdGjxZbA7C5uyLs+TVcDMYEP0cW5WT/uO/cOTJ3
 4Z2aeNU9RlxSCLOlNfjmGPjh3nRLtLReiKyJAzUwfmVCWb2a8chBwurUE1GkL5/lxtInN23Q=
X-Gm-Gg: AYBFou2DHs+uYCMafyTULN8atZMANsW7Xrnab2EcMAn6F4JQqedbJXz40XaBJNfqQyz
 iY4z0R1FeDRG+B8ut0OjUAS3ES5Aw3MM6kGgrtRl8pTKhzGQRNzDRpsb3oLS5AkCIhSuEXkeyJD
 nQRFYrCUuRaoCiCzAxApFJkkSefxEtc8zu4L0tp2tSO356Fri3Nc1Q4bgpqM3bPnHre+ukKJEAY
 lwXpH1A22FojagQQAzuhEihieABn3etVRBvp03MbEbQMKi/VuehwN+z6zPwGZmh6rPa/9W0Y8BG
 O8WqVYQIiEhWIhC2i3PngLFf9gCPRH2dJ7t0E4PS6WfDXFPE3eShjuHcxdN/3SWFqWEwhDpFFbO
 nlXQTJG2xRGSllQOfEDOWz/YBV4tOsLoKTQP5+J254oUKPuw=
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr22202850eec.14.1791869580598; 
 Mon, 12 Oct 2026 22:33:00 -0700 (PDT)
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr22202803eec.14.1791869579802; 
 Mon, 12 Oct 2026 22:32:59 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:32:59 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 03/13] board: qualcomm: shikra: add SPL board support
Date: Mon, 12 Oct 2026 22:32:34 -0700
Message-Id: <20261013053244.2954876-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX7Z7J+BPJqfVf
 IaoKhjIQvboefqqnVkIl3qYlOP+YJNX25uJr/pget8mR6n1d0X2OCt9Sn8462bPXTVqmC2ehWYq
 0OZGG1eprFnqhVq3nfXv9jlI8J3/EOm6hIxkT0BDBQAFxxfahnb8l6VMBT8gHctsON6xk3/c/Ek
 AD7ZjNfglgAAOfs56IBUuMPvkDMiuh/KhF+5OMP1oAEMAu48OcKEkryES4g0W6y0aJLi5cjB5Ab
 iMSTanfdUXBcb5sA1Ezp6mX4WEy7wYGL02I0yxts8Xp2qZRmfNDsbuX+yw3rHe8VMgxoa+NZyLL
 K/4zXBnmY6jHy8E6z5WmvxMgld7CjXr13z7kQtJObog2++rCQ/oOYmeCeTI4V+23lStjR7pBM2S
 Q9CiJFRVyxsSIVFZYkQQz1L3Vl6NwzRrowIkpuPKAPtTAMLRZj9h+53iu8+UC9zenomj4HCT4H1
 tFbOdfLVlWHdqdA9aWw==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6acdc28d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=YyUQqFQuVdnxO9SPxD8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: D-KOpl1GsxpW-nQ-e1MKgo49LWfCJ71m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX0xPYupsww9gS
 fWi9HAaklZfpmBOyYl8xQ9bNOjZt8J2w8QzEVD4GDHw8m8EVEXn12mc+WLoTE2JIyUemCOibdN5
 0kAeic5K5Y+30J8Qgqu9aIQRplOnBhE=
X-Proofpoint-GUID: D-KOpl1GsxpW-nQ-e1MKgo49LWfCJ71m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Add the Shikra SPL board implementation, build rules, linker
wrapper, and board configuration header. Configure QCLIB
handoff data, early reset handling, and MMC boot-device and
partition selection.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |   4 +-
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  18 ++
 board/qualcomm/shikra/spl-shikra.c            | 227 ++++++++++++++++++
 include/configs/shikra.h                      |  11 +
 5 files changed, 261 insertions(+), 2 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 4e3b2527a7b..31a06b1e002 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -141,13 +141,13 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  *
  * Return: Partition number to boot from, or default partition on error
  */
-int __weak spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	int p_no;
 	struct blk_desc *desc;
 	struct disk_partition info;
 
-	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	desc = mmc_get_blk_desc(mmc);
 	if (!desc) {
 		pr_err("%s: Block device not found\n", __func__);
 		return -ENODEV;
diff --git a/board/qualcomm/shikra/Makefile b/board/qualcomm/shikra/Makefile
new file mode 100644
index 00000000000..eb3961a3ead
--- /dev/null
+++ b/board/qualcomm/shikra/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPL) := spl-shikra.o
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
new file mode 100644
index 00000000000..b2922cd2c2c
--- /dev/null
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
new file mode 100644
index 00000000000..52c13859afc
--- /dev/null
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <blk.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+#include <part.h>
+#include <spl.h>
+
+#define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
+#define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
+#define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
+
+#define SHIKRA_DDR_INFORMATION		"ddr_information"
+#define SHIKRA_DDR_TRAINING_DATA	"ddr_training_data"
+#define SHIKRA_DDR_SR_EXIT		"ddr_sr_exit"
+#define SHIKRA_PMIC_COCOS		"pmic_cocos"
+#define SHIKRA_PMIC_WAILUA		"pmic_wailua"
+#define SHIKRA_DCB_LP4			"dcb_lp4"
+#define SHIKRA_DCB_LP5			"dcb_lp5"
+#define SHIKRA_ECC			"ecc"
+
+#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
+#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
+#define SHIKRA_PMIC_COCOS_SIZE		0xbc00
+#define SHIKRA_PMIC_WAILUA_SIZE	0x6000
+#define SHIKRA_DCB_LP4_SIZE		0x4800
+#define SHIKRA_DCB_LP5_SIZE		0x4800
+#define SHIKRA_ECC_SIZE			0x400
+
+#define SHIKRA_SHRM2_SPROC_CTRL_ADDR			0x0c36000
+#define SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK	BIT(1)
+#define SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK	BIT(3)
+
+/* GCC_APCS_MISC contains the RPM reset control bit. */
+#define SHIKRA_GCC_APCS_MISC_ADDR			0x01491000
+#define SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK		BIT(0)
+
+#define SHIKRA_RPM_STAGING_ADDR			0x04690000
+#define SHIKRA_RPM_STAGING_SIZE			0x1363c
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"uefi_a"
+
+enum {
+	IPQ_SPL_BOOTCFG_DEV_MMC = 0x0,
+	IPQ_SPL_BOOTCFG_DEV_SD_EMMC	= 0x1,
+	IPQ_SPL_BOOTCFG_DEV_EDL		= 0x2,
+	IPQ_SPL_BOOTCFG_DEV_NAND	= 0x3,
+	IPQ_SPL_BOOTCFG_DEV_EMMC_SD		= 0x4,
+	IPQ_SPL_BOOTCFG_DEV_MAX
+};
+
+static int shikra_boot_device(int *mmc_seq)
+{
+	u8 boot_device_cfg;
+
+	boot_device_cfg =
+		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+		IPQ_SPL_BOOTCFG_DEV_SHFT;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		if (mmc_seq)
+			*mmc_seq = 0;
+		return BOOT_DEVICE_MMC1;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		if (mmc_seq)
+			*mmc_seq = 1;
+		return BOOT_DEVICE_MMC2;
+	case IPQ_SPL_BOOTCFG_DEV_EDL:
+		return BOOT_DEVICE_USB;
+	case IPQ_SPL_BOOTCFG_DEV_NAND:
+		return BOOT_DEVICE_NAND;
+	default:
+		return -EINVAL;
+	}
+}
+
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	static const struct {
+		const char *name;
+		u32 size;
+	} fit_blobs[] = {
+		{ SHIKRA_PMIC_COCOS, SHIKRA_PMIC_COCOS_SIZE },
+		{ SHIKRA_PMIC_WAILUA, SHIKRA_PMIC_WAILUA_SIZE },
+		{ SHIKRA_DCB_LP4, SHIKRA_DCB_LP4_SIZE },
+		{ SHIKRA_DCB_LP5, SHIKRA_DCB_LP5_SIZE },
+		{ SHIKRA_ECC, SHIKRA_ECC_SIZE },
+	};
+	uint i;
+	int ret;
+
+	table->global_attributes |= QCLIB_GA_ENABLE_UART_LOGGING;
+	for (i = 0; i < ARRAY_SIZE(fit_blobs); i++) {
+		ret = qclib_add_iftbl_fit_blob(table, fit, images_node,
+					       fit_blobs[i].name, fit_blobs[i].size);
+		if (ret)
+			return ret;
+	}
+
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+				    SHIKRA_DDR_TRAINING_DATA_ADDR,
+				    SHIKRA_DDR_TRAINING_DATA_SIZE);
+	if (ret)
+		return ret;
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, SHIKRA_DDR_SR_EXIT, 0, 0);
+}
+
+void qcom_spl_soc_shrm_reset(void)
+{
+	writel(SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK |
+	       SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(0, (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+}
+
+int qcom_spl_soc_pre_qclib_routine(void)
+{
+	qcom_spl_soc_shrm_reset();
+
+	return 0;
+}
+
+void qcom_spl_soc_rpm_reset(void)
+{
+	clrbits_le32((void *)SHIKRA_GCC_APCS_MISC_ADDR,
+		     SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK);
+}
+
+int spl_check_board_image(struct spl_image_info *spl_image,
+			  const struct spl_boot_device *bootdev)
+{
+	qcom_spl_soc_rpm_reset();
+
+	return 0;
+}
+
+int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
+{
+	struct interface_table_entry entry;
+	int ret;
+
+	/*
+	 * Clear the full memory region reserved for the RPM image before loading
+	 * the post-DDR FIT, including its zero-initialized data.
+	 */
+	memset((void *)SHIKRA_RPM_STAGING_ADDR, 0, SHIKRA_RPM_STAGING_SIZE);
+
+	ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_SR_EXIT,
+					       &entry);
+	if (ret)
+		return ret;
+
+	qclib_set_ddr_sr_exit_address(entry.address);
+	return 0;
+}
+
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int partition, ret;
+
+	if (!IS_ENABLED(CONFIG_MMC))
+		return -ENOSYS;
+
+	if (boot_device != BOOT_DEVICE_MMC1 &&
+	    boot_device != BOOT_DEVICE_MMC2)
+		return -ENODEV;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret)
+		return ret;
+
+	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
+					  &info);
+	if (partition < 0)
+		return -ENOENT;
+
+	return partition;
+}
+
+/**
+ * spl_boot_device() - Get the boot device.
+ *
+ * Return: U-Boot boot device identifier, or -EINVAL if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	int boot_device;
+
+	boot_device = shikra_boot_device(NULL);
+	if (boot_device < 0) {
+		pr_err("Invalid boot device configured\n");
+		return boot_device;
+	}
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		printf("Selected boot device: MMC\n");
+		break;
+	case BOOT_DEVICE_MMC2:
+		printf("Selected boot device: SD MMC\n");
+		break;
+	case BOOT_DEVICE_USB:
+		printf("Selected boot device: USB\n");
+		break;
+	case BOOT_DEVICE_NAND:
+		printf("Selected boot device: NAND\n");
+		break;
+	}
+
+	return boot_device;
+}
diff --git a/include/configs/shikra.h b/include/configs/shikra.h
new file mode 100644
index 00000000000..7d88dc0e670
--- /dev/null
+++ b/include/configs/shikra.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_SHIKRA_H
+#define __CONFIGS_SHIKRA_H
+
+#include <linux/sizes.h>
+
+#endif
-- 
2.34.1

