Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3D5C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 10:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C81F480FFA;
	Thu, 10 Sep 2026 10:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FATXnB2HBsM4; Thu, 10 Sep 2026 10:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BC8080FFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789036201;
	b=BgAEl6ZaTuE21Psa5AOnPVdDlFl+QCbg2uNiLWAKFYPfsfZZDjrM5z+oVUqKDvq7Ipv9
	 A5OpLHliy0b5yzyCrTzHuVGcrFbFr27PwY/MKlGydew+sXYSyj5/H0rn3mDkTwovLHtzM
	 XGSknbNYRG01aSp5xEQKuuqN6JBE7gGyUtSiS4t2o1eFdukPLE4mtkIXoQsD1NQBVAyaI
	 OA5BxdOykJFnzjktkFb3zcIlRozq4PH6Xd15f4S+rka72clIOPhANNRCqo9GPTYdhUgmf
	 sugoNGLTs3KREfofAOjmjGESihbKgGusI5BiCSHFZdG88ZMzkJbWsqJglgQ7XDVwdiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789036201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xuUlnIKRu2PiXK3YpYvD4ZcEe3zm+MjkyxZNNYC3idA=;
	b=Owxe15vllGI2yxShFRZaozaLX5yG/7U+3+dsuU8IZfMcCC6CUcfskBthU9IshX/LkPdR
	 I0gQq7YhLQSI0Difz9dScjuDZ+P2xmmVezxC29hMEcZdjz6WeOkQB7euIxPWihFtLtHM3
	 Fg4SOMQaTwaUOPzH2nzDt9j0PZ4SXRTT3/fvaGQ39Y8Gff9R87lAEYRBNlqqxZv2T+yv4
	 8l4PIi3LqU1flzuyXEpq9nU3K02Kf+KgBByPTlLOIN5nhsUdK4VgmvHn6y4yC76J1MoBI
	 wgUG9gtUxMs20kEy3fDjPS7N9tYT/4cGA+FQIvv41na08FU/UBKhV39DFva5dOm3+dQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LZ1rTuFX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jaOjgVSl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789036201;
	bh=xuUlnIKRu2PiXK3YpYvD4ZcEe3zm+MjkyxZNNYC3idA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q6vLGbvxnNt7MTe8vOhPcvdBsCI72LPPTk1j6Rr57F/VB5a/JMGo1/uITXcQZL+yV
	 MP8l0UIg/1wJdD7G5w1iUTbhzEuq0my2spRzqkwDdljB8IWFion5IaeC/umvBAadx3
	 mJCbJj9SUkhrYrK/o8157FcVGsP9HCpNw+spmMMhpTRMGJXPvQcDX4jnDS74y7i2z6
	 joZ34WR+iICn219Qq5vrlqyPMxTh2YM2EwDlw8TX4b5F/Gj6ZoL8c6n4esigg4kDNx
	 OglrJ2JFA0LDqA5m/TflQdSZWUkcuZYxYUFq+MLlBVvdmIUA1jF4YO0y5Q5I++HpEL
	 AATrbbdAISfGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BC8080FFB;
	Thu, 10 Sep 2026 10:30:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECC66E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA85180FFB
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4fdC4dJX7lkY for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 10:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD23080FFA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789036199;
 b=dTMgCCigAH0XTDMtmg1KcecAnwtAMOFrTgnFAJGAoJkyyyFvtKtko5H8tpM661XrVBkE
 Gvj5Gh6PebTVq2VVxVEZ7T0kMS9Q+laA+mDpp7g1LTtES3TLHqaD+ipuZ2IJdiDSA5RcX
 LT+xQPQuXuO5MSyHdQ3jSbXHHyFLrxKQzS7MO9M5SUR7yTvF5MQBj20VmVCv43eQlMTcq
 q4orIs3SGo1RJVW/9vhnU+mNDGsY3l3LTBs4pTgzAKOLjMNKjI2kzxHaA37PdLAXb1iC6
 uqcnDFAWdqwHGFMq56LxqlDAHTG8vYU/3inilHVBMyCoD5rRrZbi2fDAEpH13xLNUSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789036199;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=xuUlnIKRu2PiXK3YpYvD4ZcEe3zm+MjkyxZNNYC3idA=;
 b=ibcxnLkxT7foXmNXbIaSeAoh1TnlnwIOonNIWnDKbVCXy0QEUR0FmMRiSkzmmCGInUgQ
 J3U1KwUf964FtVkTJKBROkkyTzrNRxxLx312qtEiefNAM7Ajf//25PmloLcyIk7fhzVcl
 fQf1S86gVUy3v/f4U9Jc+evFLDD9atm5nxJ2ypA+ZAWq5Ur2gizRvl/kcY7rShbkm73j2
 2TS9gKKINNlEBKb4RCFw387/X+BhU5BwytiQ7c0gBDHKCS8ezlIS/ikMiyga0nkYhemhh
 uzqaJLu9i5nZdx63NFXv973UKWztYiVBmPwmRLiVo1cEMuCOrI4JgDFP6jSEqAnmHQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LZ1rTuFX; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jaOjgVSl; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LZ1rTuFX; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jaOjgVSl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD23080FFA
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A8q1R7427139
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xuUlnIKRu2PiXK3YpYvD4ZcEe3zm+MjkyxZNNYC3idA=; b=LZ1rTuFXQ9MoLEQ1
 Hag1BiN7xM6EBceumZWC5oKPnYub3ZS7qO4Ah1z3IGhTKjf6jxWNwRCtC3eauTq0
 LlrxdMpuvGNeQ8M+djz5BcQ0+o5UPwhlHmKvEpZWwVJ0aJM/27EHI8d5osVF7oGI
 HytQ/+MdaOdoq1vt1XnHJa8zodp9nyOVkW0GMUIEJdK4qwSYwiHcWs2BIHKgDBy3
 4clZ4UDQlb4okHi8K1x9D06R23izMNDrdawbijhytQmPTT5pkxo8YWKdTDlVQphJ
 xQz9HBlQ+Sz5hx+HNXrDVdue4tLYUjGEOWUwrfxdjQwzgKtx++/z9ake95gDatbS
 DMjwZg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd3b7r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3968dfff779so1430069a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789036196; x=1789640996;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xuUlnIKRu2PiXK3YpYvD4ZcEe3zm+MjkyxZNNYC3idA=;
 b=jaOjgVSlS0XKQx/ZdKw/iMbVqH5viV8R9tKlF1mMGm43X4ZRWpdzTP0mN4x8pDnhWJ
 X3vVEfMkLhdBlexmgwUddws0lq2Vx2AlOdgKvlwSayNMEiKvpSkv9UfskJdqA286bw4H
 MTfMCaTdPIrqPDGruxkeCKhmeJSlVZ9uTpHvlKPBXVNYGckCIQgQRQG2+yLsxNK/4HsT
 LaCcT0K4bf+WeR+lYW0FQx9VjxEE9k/PqdWhb0en3i+GlOggQQ3TQsIGOvlO4JyoDMVx
 ja2aDKAOyA3xEXAZ6oQz22ace14Ujdk+qhPnVBXav6rfYwebrAonJKvXgcdrnv3FmtCf
 lTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789036196; x=1789640996;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xuUlnIKRu2PiXK3YpYvD4ZcEe3zm+MjkyxZNNYC3idA=;
 b=BdeBEUwA6K+BZjySXy26emB7ksNSjlWnIcm7kSgcEzj85yGhQuRlV9aGCj6sGibYKi
 +waurTfE4FpbfqDuvtgTtd6/UXpDNM02du43mQTDJ+zUTQdteBulFD5ygAQr6090Q56E
 R1Kj5gqZUhV7TjQgWIJGCQeLUh8bIUgcT6qTHa9QiE5RBasdXGC5VkJKFAbIAbtE1c30
 GGFuUUzL1+6HppGSYJcua8QMAlTEJcFUyHeSbcpbAME/VA4KGW30bLQG3UfBQP+SPLEx
 LFtG6vi4oEPYmQXyvjuQNl8kUbX9WfFDn2QhMcNUsralj7Lqs8Z8zxeKtDzbKwPmCrc5
 sYGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdLbhe6kVlzkb+dG67PCYizjfLCl+PdrZAtJyuurmY1khnQlsfytHkkpvCjSTCF5YZdhyksFs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m2eZKVek6cBK9MTgLpsWlHRvlG2l+IygHznufAL8iIMTKxuy43
 xAvP1Ksow/Eiv2FlaEfxthXIvbguItzMat82sKEvsb5N9xFUEzebLNiPfDr+hAvqfEr4U9eibql
 +Zs+0GPdQpnwtTaROSc8YzGfuFtirusibC01z6rHaAqdNw2MuwCC0wdK6TbGKiaAjR7plROw=
X-Gm-Gg: AYBFou18W3DqqJr8HZPUMUQMXPm2pyBuw0u/wepOVqenoegA6GQTQGfvONKRRyXCf1I
 p5v6wDlDCMu4pr9ZoVflitem/t3SzvX5IALGQAJpcTnErwCcRL4fNDqhYVQoDa+0BJL5oIi+95Z
 0qY60FPbUnFUgJ9E095nSB2lfb9uLwFBEOb9nKmGlSD/fANEllF7XFkEBK2lcIH3DvaB9L04SIO
 NLAOyZvgdmSqVctnTBZFWa7gihpBO559nwoUtJi2U0utRxuQQOvUUwb7Vhxvbz090qQMyW2sIJD
 MsEvuX9D7p0Fh5rnEdIfwZjkJ8GByV7ZdFYdxcRj+x+ue0juEy1Ec6h+iJnTz0P0Q35GLJkF+u2
 3LMnWE0+MtD1sSvw9vFZY4avgrhQQq1tUlGI7Y3NYfUX7DFp0r6NFPXhiOvy0vZX7m3z6/7hgFJ
 IrN3aWuCSDHWZG3QYN+kJOC1Qk0aWzIg==
X-Received: by 2002:a17:90b:5291:b0:396:7c01:553f with SMTP id
 98e67ed59e1d1-39d77b1d014mr4705247a91.21.1789036196091; 
 Thu, 10 Sep 2026 03:29:56 -0700 (PDT)
X-Received: by 2002:a17:90b:5291:b0:396:7c01:553f with SMTP id
 98e67ed59e1d1-39d77b1d014mr4705203a91.21.1789036195611; 
 Thu, 10 Sep 2026 03:29:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a62be87sm42824576eec.6.2026.09.10.03.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 03:29:55 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:59:40 +0530
Subject: [PATCH v2 2/4] configs: add qcom_sm8550_defconfig and debug fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ipq5210-v2-2-d209f7dc0fc5@oss.qualcomm.com>
References: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
In-Reply-To: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: bUIEv43o4Ho8wGgkypPuhMnAE6uaBT2L
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa286a5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=unZPNS3TcTlehdJ43tMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: bUIEv43o4Ho8wGgkypPuhMnAE6uaBT2L
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX+ZospgoVfsMt
 lqoz24WUX5TwfNuDHtldwcUcp83rPPXy3K9w7RdhvjBxoBdO8gQVEYkOCwp8UsrFntoVskNNfc6
 XCcBI3Ni4g7fgZpcA2zenAm5mJKu9ts=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX37u+FGlRSyno
 IXHDkQkqIX0CQ26lftQrghBX/au5kaSWgUwHIdr6inxFlz10rWx/UTeiLheURk1/NHAlQLlB2XB
 M/HogabsAzyNPKU0Ea7wU7LZCO3Xh5lZbWoeF2ejIqgnv8xkpqCO//b4MNF8iURJ4IIwG5bVyNk
 zloVO20j9iMaEX9taHmh21X/8ysAH+oSiCCgwQeseA+/ugVNoSf/rdYYdceyDa+PeM0Z9bIyKgI
 cOG6Xgsmc5/ERcB1CZxa1v5nc+fYXJeP9cOkyx98wfGsbyqias3j2Em3aSP7KBGsA6wwuRLv7le
 RllFcLaFTpxRa7swr7/2vD6Ay2HpaToOqU9HNqG1k373B1rZFIYwKMtS62Uv9yXeMPQ+nThUCzx
 yJLpI9LCzSz8HTWX56mCM5fNHZtxx0KnP0XknP4EO4icFO3Fy2jbr4HssqY7qKklwJ4Aji4alzX
 UXpzMke7m9JJ1HFv3iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100121
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

Add a defconfig for running on sm5650 as the first stage bootloader and
associated debug config fragment.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_sm8550_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
new file mode 100644
index 00000000000..30d11f36eb3
--- /dev/null
+++ b/configs/qcom_sm8550_defconfig
@@ -0,0 +1,15 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xa7000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"

-- 
2.34.1

