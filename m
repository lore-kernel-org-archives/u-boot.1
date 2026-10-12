Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A18CA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD87D80D0B;
	Mon, 12 Oct 2026 05:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L067VdwsZjD7; Mon, 12 Oct 2026 05:08:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1592180D02
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781728;
	b=sIP3kWHLt+ag1Rc59mwUERK47PsiTaN6RivVLiiTHK3GrSixGcYamJm7+bf7bOe81yse
	 w00riiflCocbP8dcD9maG1XLGroqYiSezVYIjvB2h8+hKNUrccZE4O4VxF14RrrStAG8R
	 5FuGQUK6d/D3HG7QMpo3S06HpBb4MYvCxHVz7kXGeki3A+BmceQSSZ4wxLQEFCHI0oCPg
	 wEuP1olMZZJ47usX67iamOYdo/8Ik8DGUQ2Gw3E9QXgT/px4owMTj4dpWCujK/OIoDYYH
	 e+MNc3j96UIjgrIbXaI+rWvaqe0kUne92kZV2DQZ/zh2DYANeXBOzkeUgmT+1ikivNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
	b=sbsbLZP8Wd7F4tgxpg09eypGnS4UYjOD+mpbgimlBeFrp0qmQDmUtmZg8lE6Jt0irWDZ
	 qAyw9t6UNnGrq64SshlkaeQvuFQLBMpWKcS41dweUzOq9PDYXfnQxMSDljKEZJ41K+Ju/
	 2XGs1bvgfs9qg8dcboyYkswacLP61iNqKY9BFdiR/J91xHnSUCSso5Uy3YCgJ2iA56nk2
	 cjB6VZytclN8PHb2BpK4th22Kp90/iP0MGzcFzis9BrgXYv645jqpu1327I/qLVwN4Ayy
	 RmZ29Qz5svIYJ+eVxf+3gay3O4IFRsl8vgDki8VWC3xI7B3Rk3I2hISAMgZmkTut6Tw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781728;
	bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kceRk8LgLvUQtR4AKcXBAHHp9X8gsHu8vlz3i/7qPhRMC6BG/UoO76E3qdx821jjC
	 zQTRgj0hLVT+H6aE9uDxNtfhS2FoZihYT9AEVWSIsQ6C7o5qKTHp6KiFIMWQ5WbxRr
	 X6b62xJB3MLJrpTZEv6uSarId1Rt2lC01qgyme2svSjVbVr2I0Apq7VGza443gKUmt
	 s3OOp3YQWYJAB0iF0TuaeI6TpuXIrVF5uLYuXE++3Mk+iNTqj2sfqOvUkkrJHCkE0s
	 e+88guRw0rE1pXqLhgOt0Og1jbOs56yq5CrXhrM07eDN2kh489V8VQxsO2/7zJgk9D
	 t/9lUHGVar57Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1592180D02;
	Mon, 12 Oct 2026 05:08:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30BA31DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2231A4052B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omiuYN5RZC8X for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 680474055A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781721;
 b=fVkxuxFocQCh1fnP33FkiImRipGu5iTr48/hSvLUC74NJmSt4qEFnVBoFfTSyzRvc76n
 yYYmAutnH9fbN+B1DdUqvODyL4npDg8Qtmv4H4Vr2k3U/YwmC3fXAX7do4UOzsfSGiVA1
 QL37lHI32dGJjeWZlRoxNUzCjdW42k35DgGL3BWLL1+C7iOwN04MHvF7ECP7YwXIaLld+
 W90swr9uPaoqjNddsSqAoXXb/Ku5dEhrV4ECeDE+z+B2ZnCcaDWKV1WXb7NR5ve2nMjgz
 1weEhaBiHE7/vgiWQHmBAGGl4MOkB909UyXccCu2tXGXXFyW8J5Qb3INEDBV1NHCMRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781721;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=h7EjGMF1rwxrqA0iqvMT3Ygow0t0/VOTuHk887dJr92tdy1XmpUqOPVKBwM9VOKwChLl
 Lm4gKrhONqHwgi7gd3Lv7SkdF7T76ibqvazROQZrtfpC0fGrEcWjgfgsb7PHgYVzYW6Hi
 HBC6vF6wKfeGrRk04N26oBvp4HPWJM4UoTwFaO31GGXAFFvDKpYcOKEr81uDIF7kao5L7
 QtcCNKeSjOdzjfTdrSLxI5RLf1yod0Ss73w8ebXjr0GTnzImkUmrCQbIfwveTZ3h9Ll7r
 1hq67lAP2jLLIHDKXQkMgCglgZwAc2+H+22duJiBL6prv2xwaykWUS94/IZ6e3QTS0g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=csOm75gY; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fgW2neVH; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=csOm75gY; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fgW2neVH
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 680474055A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:41 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55gGO2355030
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VWuDDnKQ/kx
 wdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=; b=csOm75gY6Z6MPWXcoL9CGxCUam+
 mPY9mZ1/vEvg66qyJKF40kzAXH3SrEprqAkLfY5PdOFKCdWDoyQ53giZTSDzeVvO
 Htv8bfBS0gg2DPEQZIE2WWEQcCnprDhu40eT98AlTKXRsTGtW5WmMk9FvQSHg5sZ
 euPRpah8lGSo3FjRx3QY9HKJacBAu3LYuUsOz+2RFUTyuQJE3xMybW61oonUuyWp
 4Iemz4iCSlBBe932p/HCtnl7AWD8HNFsBzXRRP4Q2rz2mZb8tJLI30VmfQmVEgkH
 d5GZDRbWxHxNcHhy6ibyeenH7H4ezV+lNlqvWb1QZf8rTqVye/fp2LqhJoQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cascy4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35ac5255f1dso1824551eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781720; x=1792386520;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=fgW2neVHcxXNrBN8dG/H7eSjep4kT/S30I5Gy7dkKo5TUk7CLMZiKNCSuAQMKaqLTN
 lJRm8xTy9f0f7VZdn/hnElUIGHDtFVJRc0CXr4hJW0elPzXpxIc+lYkU53rkyDCdOrDR
 RI4jgq5TGLjY8TRHD95Io3RNyGLJpS1So3X4iOL+K+Sw/eX/gg4bHosEEZvU7jM8qQzY
 zOo+wwIzND8JbtTFMo8YmEzoG8LQ4OEKpt3GAUDGZJwEgPZUcxjbXSEcShDT4pw+rI97
 05qZMghz/XiWQ0LTgdYfm2nL0+jWFnclPsuWFEXSeEewdovGyhANj1Pgv/86WF71VEgH
 EyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781720; x=1792386520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VWuDDnKQ/kxwdTVkGwvcyzd5NbG/KQJZen2yuq3+LUY=;
 b=qYwfmm/zvFqivb7B39sKMrg4Nyfr2hp76Om9gDe2mU/zf/y+mjPW1w4TVZqjRBeNSZ
 33U9935skJhFpvQaTmpSXrHlrr44FvXNn/PygVQvEsujtM4vdEIknzEm3aOOHn6voZSj
 c+EYT2yRX50f98icHcHfITvNw4PktcYdDuTYpWHLsZTiy5YDIIe6pYkXa4lkEthiWYsk
 kSQhsvo15Hi1GCvSHTHtI46y8iV5cUklhbBMc7AKd+oEJtKktdf0DK/x9g6WZIHpiFm+
 3KYvXaOKkeaG1CrRH5P6p4bybAPJTID/KQrVYYYnMu1LgmV0aRILXRVNZ5DTnkfv9wX0
 NuDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlSLvm4gMWuQYk74Hfjb1kB8rLRbuSYzoFU4ZKdAxVSxTozPHc9TQqi3T4p2BeZUZ4+n/gdnU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKgvSMG+3/UxCLvDkMaARLh5rivugG1XL+1hEtKfGTUJXPErpz6
 Ofwh1OKd2t0HIDZ4d/knPr1qIdQtRhY3qT9gDQSM7vSfMry0mlai5upurd8iz38SbYjfK7JqJ9j
 NhVa7B0+YspLYrWrzHQv312sGQxRNj+XtxYHn9m4MbOq/YP6GA6+DHzIZeVM8LGoR74t2loA=
X-Gm-Gg: AYBFou36eOlQpySbrUv6wS8ChFAet3JVzuMmon8pY12cHFb2SSxkfzitfUnFdNkwh0I
 F1eVragXTFGGRputxoW2UGzBMFVTqf3bET392byW7jMepDXji8mFUwfTXR2q3arbYOnNis8G1sY
 qDHIIyU3qg1vy9li7sU7TU6jGcZfPoeQA4wr2cP9Dm4dKbHyRCProrSLJv2mAM0xAvcwBtEYy5R
 iupHKbfBSRYjpgSZ8M4erSrxxTzDZjlG1nuK1ihUy9XxVyYT4KY1Km4ognRkeTQ+QmYPiWDgdfc
 LttkZbhWL+OXTpLzFhsDGBzNZCxdfcyz5NAxlFfSJLIWJO6JFiCx1wen5V50CpdhEbyaSZvHlJD
 3ejJeBUPNGzJNoBXiE+Kve3kH7MHYmbT9vJnXcSma3Er5mB8=
X-Received: by 2002:a05:7300:d20b:b0:355:a930:ab65 with SMTP id
 5a478bee46e88-355a93fef2amr11552091eec.31.1791781719747; 
 Sun, 11 Oct 2026 22:08:39 -0700 (PDT)
X-Received: by 2002:a05:7300:d20b:b0:355:a930:ab65 with SMTP id
 5a478bee46e88-355a93fef2amr11552062eec.31.1791781719221; 
 Sun, 11 Oct 2026 22:08:39 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm30362095eec.26.2026.10.11.22.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:08:38 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 3/3] clk: qcom: shikra: gate PLLs by clock source
Date: Sun, 11 Oct 2026 22:08:33 -0700
Message-Id: <20261012050833.1554624-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012050833.1554624-1-abhilash.v@oss.qualcomm.com>
References: <20261012050833.1554624-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfXxOsly3pTG2B3
 yhhM4CT5m7JrxNZ7OKnjQpR8WJiloEesC/mEvRReLOOw3BACVPmpupiAEbgaBxadEsisutrBcGC
 8pzoWZY3oVYeL8eALGiYZ84rlNZr/RM=
X-Proofpoint-ORIG-GUID: puDLu2m71rEg6GJd7evSUOoYjaVbxHJG
X-Proofpoint-GUID: puDLu2m71rEg6GJd7evSUOoYjaVbxHJG
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acc6b58 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=cbElVB0p0K_n_hLG8QkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfX18P1rr2L5Cxk
 3gNZdjAcnyts2zhbXnbCKUh07958SQK/nQxuJ7HALBw9NVb/c1PeTOnTcyie/9G9oJyGAng1+K+
 x/DA9GcRmhl98OqtqaN+1g4PxNXZiQQL6ZWm3oxavAwcIck+71WeRw16bkwlz9ezz8Wiq75MTIm
 5BgZqKozkyzAP5fkFf4GZC4c9gQSfVapeAh9fHHbpVuxl+Jv4GX+rX4t2eUjAwTequN+vzPK0W8
 zNsT3Ghgei04CK2uBCdVlS2OaUDaGyQgoCZQdSnCuU/uHKWvWSrSxSow1sm3rJy8rfkZPwSArsc
 5ucb3OaF3NjjHuIFYSph/G7PxqzEf0LIMxdiyjx6LUJvsYpv7e98zTAijGFY0aYdc1Ibpt+i/4d
 QJmyTN06cwZkwB9bq0EiGHAzb7i4K4czHgi9bQqQ8xYppgpdHwJ7y8e4y78/QOY33GqJUoC1z3N
 XGHT92FJW1WAlIG1i5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120020
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

Select the QUP and SDCC2 source table entry before
enabling its PLL.

UART rates from GPLL0_AUX2 must not vote GPLL6. SDCC2
needs a GPLL7 vote only for its GPLL7 table entry. This
avoids enabling unrelated PLLs during SPL clock setup.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a74d529f4cf..72b6696127a 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -138,9 +138,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/* The QUP clock table includes a GPLL6 source. */
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
@@ -152,8 +152,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
 	case GCC_SDCC2_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL7)
+			clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

