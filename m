Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C06CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D54D81212;
	Thu,  8 Oct 2026 10:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7gtydvUa7QXY; Thu,  8 Oct 2026 10:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99616811F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791454724;
	b=L0FtuleQ1lA9TlRIgNrKN7U4qubxQ75MyvaPOhu5y/gfg9bLls1h0IlZ5bvMVGCOnYZ4
	 lwJMG7mwXgPNwyB08AgcyYUmu8IgFJEM/lbUoF4Qp8ohrSeVgpT6mlQc1Qsl6m9VHQDcX
	 M1oe4T1Ojlmmh91OsfDAQPAjG8wSChSkAWSXvg9FJ30wDytdBfk25EuFphoVy1t15k07S
	 QFBlqBhhrD9OB2HDMtJafa4R1d0m7i9YoCgBMIHhqB69ZnMZrjINpJkOVRoErL7XCYLI2
	 rllAJoLY9ZQyyRTb5p6U/fvU+k3wj7y7TY2yPiV0qfM0sSECUoqYFw4YG65kLSZRlVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791454724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XD4kMfHX6wO1U4mv/p03itn+KLzlNdzQgIqEDMs+b5M=;
	b=DJbo9mDSTWnNzMiETzoXNVpWW4zF/je7bUe9gOiWXielqgvOH079AxExZQTpN6Zuqdzf
	 8LEvRrSJUtY3qxwGhqZF2jMy7sI28l9Pfc8ZyRRg/j2hZyndDAAP9QrrM7mrPxXgBrTJV
	 v6gaQto9WYfvGpIgewLX6hcPGG1R3s62v+Q9ykiOOq6ZVq5m4yvc71tym45cZIDAf++lO
	 eWcTUFsQ85ytOq0JvFke4X+LAGdf8cseeqzWmQ1CBAN68B5bNb5kZNihnzedr1KafjxjM
	 dyCYl2ZHs94jyGjdO7TCJGDyqDmCBJcDIF8CCWzfKvNxK+sybt9qTNHBeiEyRtVovuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791454724;
	bh=XD4kMfHX6wO1U4mv/p03itn+KLzlNdzQgIqEDMs+b5M=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z1XhoG5sSpnAGVOmKPVIqJdTWbEsixJQsvASjQo97n5VO7/nA9UKUMsi9+2B4xWrs
	 gASlXGLo7H3iKO8Qkf/+A5TMMaG34g+dm00jQEpZ4wQX4+rIEgyUnzOuL3w+vHAODg
	 CC++NlFPkzHCHwGQ7IJJso24jY3NTC243+SgHVXx7a7bPhI9cx3056PCXtgHmLLTSX
	 m0xxdsTHROtmzy6dPByvR1mFO2STrM95XT+goWGFzK0iBNUI6xTi7aLLlvGYmdwmFk
	 zCWPB7JXjvEtxYjh25hbIurlyiVbBsTTzlcUn9ME1wsbwpXkWPt1R8V8Kho9nRYSOA
	 Zt7Pzu2k7DGtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99616811F8;
	Thu,  8 Oct 2026 10:18:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B11BA2AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96E9C40427
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:18:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqrgMYprJ0KC for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:18:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B398340050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791454721;
 b=npb/GdrRtMBOPayDUpcgKyQDgife2PDKmdsJUMdWpYvfweJkx67cTx23IMdTtzBT8FMc
 fgh/ho96nu6HHnZEJu8aMYWtIEIDf8dNKYc7gGumVBZqzJQzKRPSwddau6bTqH+EBugVQ
 2rJ0JJt28aqIeDvT81PZM2FEDUk1rHPr6QNja1/O2x389SCSlOr6RM9BWkrHqXSOUJLVJ
 4EfnWKEDEKgbMKFuBaiRyZBCCcgR2uZbTtcNVO+lsse+vM6lVh2oNRSzFz3VABoFHZc4x
 WBBd0nbfQOzIuW56Jj7WUiz+molIAjye1/0VcRL4+no+QaRRyHUT+TD0LGBH73Hk7AA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791454721;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=XD4kMfHX6wO1U4mv/p03itn+KLzlNdzQgIqEDMs+b5M=;
 b=WslUvfELDVVUDd7nGTBjc9nfBf887hzpr8GqpLfSH6G67jf89T7fjNVBQXEAxq2KwMxV
 P9vJ1tB74mY4WjABt0r9cJMvdMxiHadvAPDQ9Nw9De9oEDEBJkPPoFCqla5Ud2SpwagcA
 g7ld7TddRwJEs0T3lsEhhUQW/0drMHJwD/nSPM2iSukIT7IVUttsb3y4LLWEdRsAnoL8I
 yAW8QyzPKejKSF3W8ggGkDTvumXJatBGnb/DXUEVhHTZHJe5P9UNh9IOM69NRIZYsWNn6
 ut2wkbIS5IVTJkNL2YnwOpbUjTjDYN23jq/0Lnyy94tdxRjzlECBAEDPJrTDjen4XZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=bDs5xxgN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CDkVGd3q; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDs5xxgN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CDkVGd3q
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B398340050
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:18:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987KYf3730807
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 10:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=XD4kMfHX6wO1U4mv/p03itn+KLzlNdzQgIq
 EDMs+b5M=; b=bDs5xxgN6BiAFXd8e6ttIf5QeITvQtChoRe8Df1FnyjYXo3sN/9
 EuzVW0TFyivwu8tlOqW8ItK+UAXGRpHdIiTE4uEM0hcqwRgdEgEA9F+KFKLPdvcu
 MBXJfOtmepH2ITYgUSDF/X6k+o3kyYbzuGzRsWOTXI2iOMZdb3E9GXzQsuu7v7yY
 utgYZs7poVk52+DxaOzPwUSd4fge5P7a+YQxDMGgbg1/bTnmg42p/CmAdJUGSjUU
 LESgYT9Wnrad3R1Ii1GD3z944dV0EG+XXwcElW4UgGAF5kCqbDxEKGwXV0CY2LhN
 fsUWEDqf0HGDjPtRq0OOKrCSdU0Tl00e7+w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe32c4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 10:18:40 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so679891c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791454720; x=1792059520;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XD4kMfHX6wO1U4mv/p03itn+KLzlNdzQgIqEDMs+b5M=;
 b=CDkVGd3qCa8Ry9qAHNrOh7jHoCrFnySsIDrPnKdGQCFuOZeaNpZE65fMS5uxo5yIgP
 TJ6OXWDwY1Jg+YXNps5Cku+dn9nCRXFZZ4L+yawKjcCyTmrSHOg9C9yLr9/Fdnk9vV2j
 q/DZaQt+KQHPE+EMnQrU+PMkmmejhx4g9FvKorePkRWvq/13dDW2C9PWKV2wdddfGnpX
 BP7/7cWonxS/28JdGUjqr54I68crIY/oYEMS8qLKzXDOiZk3N8xkfMMh+FK/OH0QY0cn
 7+Bvd+UATyITD3lE7u4Jp6ROCybQwJfp/8c5nOR/spooj5sPwleblXdXhlGZE3odl32u
 qihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791454720; x=1792059520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XD4kMfHX6wO1U4mv/p03itn+KLzlNdzQgIqEDMs+b5M=;
 b=u6uDV4H4UgEgb9egtXKsw4t1LsDvhner7+8pEd9KwH6QSuigpEPEtUshd/oS+uJwOx
 hExJfYifsykT43W+tGc59fT4NPVXVc7Fe4CY54QLdaeO+w0U2G5lG3gWosPmmRfo/zqs
 uTZCDJSW1xaaR+gqj6DMdiwgc2S8P1Gek0yjsEAOBdu9grOAlgGQ3NQIfpjbjD4PNxSX
 TCwMfSrko/hjJ7wA99f/DZp5Zq7FHDt3nTMyVXZ4LB5ux2L+u4DBpu4F96cWmKUGtIhn
 D9Z7RO0FS4hUMfmBhCWzOqs5jkM00l8gMLJ826kvrC68ACZrAkGO1oanO7nvVqVP/0Pw
 HGog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcjnDhWYYuXgBbuPc2rDARw2Ebk2oN/wdPw+1QTSgbSas4uQ9IHKzGNP8/j0UfjlvdYnKzvUU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nMWWX9vHGdKmHmk2Pson1bl8DdN/tSpPf6s+OGIxhIfScsSPol
 CTIK1BrbuZ9+zqkdiLRdL3Zbm0rmY3o1GK91ucGmAncUQ6wYJzSnUTCwfCCkP5IZ50f6haRG7QD
 dfgeGrbzMqK/0ck5mE6PQwYkY6gkNet/oxnVNwItaLcgkVCiFaKGUPEn+1poTDJOvkla4eiw=
X-Gm-Gg: AYBFou3SWsc2JjCeGsKdojRK37af++KQqDdFFuNH8AK0jbc0l4LBlfPKRmxWXBQxCBS
 tPbQ5oZDKOGD1Na9Va43S75bG6pMKPQ8ig6BnvQb3/NPa0vvsYZDsA0Er0nWfhYMb5iwLyT/MLu
 0Ec4+jQq+DN3LXHmOYXol3dVncbpvPGfPEsprYFpre0LFHiABBHZ0yHL3c5yxKDWJCZc3lx224N
 et3S5nnD7oUJNiScAE4+iGLFQlZsVp352f6ZManzwFH32yOTJTMs5KJoWiYSWOPy9q7je1iGrzC
 DBZz7K726qZp6BNkNs0rW3zDLDYH0K/WH6TVMM08/IkP0dGMvBZXpgWbZT0p4AY9OMJLQ4rKH79
 tqE/9dioXTLrh4kexggSU9xZuFw2n4x9w2uwXSmfGiSFjcXxxKJXbv9TKPvg4ilAsm9vI2bptBm
 DjcnAcFLj4POcCptFswdI=
X-Received: by 2002:a05:7022:5f11:b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-1663e548d19mr1702604c88.18.1791454719356; 
 Thu, 08 Oct 2026 03:18:39 -0700 (PDT)
X-Received: by 2002:a05:7022:5f11:b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-1663e548d19mr1702577c88.18.1791454718710; 
 Thu, 08 Oct 2026 03:18:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16167ef2e54sm12241577c88.10.2026.10.08.03.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:18:38 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mateusz.kulikowski@gmail.com,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND v1] spmi: msm: Fix V5 ownership table offset
Date: Thu,  8 Oct 2026 15:48:30 +0530
Message-Id: <20261008101830.703427-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfXzdh20brEzznD
 pHH0pkpCNGQUxbD0ETBXVaQCSr+wHwGTWZIh60jfHtQDGuj6tvFtzyj2U1jBsJibmRonfedMWF0
 N2zrUKpZPpaZmdaIICON7oipQ4Byt3ST2eaqx9Clt5EVHuEo9pW5WoZkqOGMdi2la2LZUp0cNH7
 gfB14it1EHAetib2U4v4oXA28yOWNI05i0YhGfqYrY6e9pVj48xI4KTGnX2FZeHHhanWi6UVumd
 DBp8i0cyDXF2cO4p0Udl3t45z4G47uUZOGhfLBZOYr7EnQcHmZHHuOUnYElKPZ8otV+dEkaw9uY
 b5W3jGdkW9Y3EMBEf9Ut/ORntMk9qPrPu34GB8J6IGnpVw/IKp8a3Jryte71qVAcQ3Ztap9eKcS
 MDx8Q4D6UL5PlRAeE3D8sVnehdGHG7Xk85wrjDKl5srxmB4AASZ6222jXisdH13HAO5EjB3KVnY
 tLPtxvIBNS0HG46+z0Q==
X-Proofpoint-ORIG-GUID: K01J1YBk_MmL0msrW5_52mUh_v_LNf5Q
X-Proofpoint-GUID: K01J1YBk_MmL0msrW5_52mUh_v_LNf5Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX5PpNLIncr3FO
 u41j8pKh8n33PaPi2wk4aLoe8FpyAquKPfZ/LJzCQr0gxWClRmC3auPsp64dPRxeoFFmGy4CrJM
 i17SfKaT5r9xEGmCAMMmj0qJjbnAi4w=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac76e00 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9AdMxfjQAAAA:20
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_l2AY-rO-Bj6gyqKvEcA:9
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080040
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

The driver reads ownership registers from the wrong address for V5.
The ownership table is at offset 0x700 from spmi_cnfg base, not 0x0.
This causes incorrect peripheral ownership detection and potential
access violations.

Add the missing 0x700 offset to match the kernel driver [1]

[1] https://github.com/torvalds/linux/blob/4b99990cdf9560e8a071640baf19f312e6ae02f4/drivers/spmi/spmi-pmic-arb.c#L1737

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/spmi/spmi-msm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index b89dd0b406b..a665850cd65 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -260,11 +260,21 @@ static struct dm_spmi_ops msm_spmi_ops = {
 static void msm_spmi_channel_map_v5(struct msm_spmi_priv *priv, unsigned int i,
 				    uint8_t slave_id, uint8_t pid)
 {
-	/* Mark channels read-only when from different owner */
-	uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
-	uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
-	bool prev_valid = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_VALID;
-	uint32_t prev_read_only = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_READ_ONLY;
+	phys_addr_t owner_addr;
+	uint32_t cnfg;
+	uint8_t owner;
+	bool prev_valid;
+	uint32_t prev_read_only;
+
+	if (priv->arb_ver == V5)
+		owner_addr = priv->spmi_cnfg + 0x700 + ARB_CHANNEL_OFFSET(i);
+	else /* V7 */
+		owner_addr = priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i);
+
+	cnfg = readl(owner_addr);
+	owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
+	prev_valid = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_VALID;
+	prev_read_only = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_READ_ONLY;
 
 	if (!prev_valid) {
 		/* First PPID mapping */
-- 
2.34.1

