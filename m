Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC773CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 843E46073B;
	Tue, 13 Oct 2026 05:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mG04wY2WqrbY; Tue, 13 Oct 2026 05:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF56E606EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869735;
	b=aThzI9zjQGmTS7AWl5vHdm0s0B8t0/ykJJnu27DtMmumqRwddtK8IiZa4BwexffL3h7c
	 M4zM8xflL50aPaVw4K8km3HNEx+vaAVJdGqCrWeA1pteXEbFxKIwdgNyoZmJ/FOPuW2lh
	 eNTLUJXNScPizhB1GgMAueJT6woCJNjeAx7ofbhaGhJmeyOTAq4k77KYrSlZcr2rdj7HI
	 3PRHMJGHl3wa1Cac/SP3PBM5AQxA6dmszgCORPBCoKLVHYnbFD5WtawCmZaw1ZWtJdj+5
	 09wYqDZ17sLBnDMClnDmahP6VO57AE9JiHhLRgmJvgVAT9n3pEvHeYDLzYqbI8rQadg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
	b=Fid+OkfPo95HU515zX0ny0oEiuU6kES9PY7ArAwW0f5WSd0/ZkBeAOxgNdC5o5xy9mW9
	 B7eGDFj6YTCbv2LaGqBRT3kQlaAlcl6GTb6Of43z6AYcPPs5NUWIsgxYrHAsl6q0pZVYc
	 QXwXurgd8CM2wXQggW7HgdcEwx51YwVlS7l+MHaxARCfvruf407S156Z2m52WEFCBJlAb
	 yl8FoTIG4982roFpUyglqV2GQaoqWfS62VdKVG3XJPGJlO3Y9UDNsiSzXJAnJGmV4VUSS
	 3sN7xn5puT/Sh+2CfNhuxywZsw+/BCbe7p4jzJIdUn1C0B6/Vhv36iVlP6xK3Pu0rHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869735;
	bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fAwfiAEvt1NdOd1c78wXlUiPTzsRg2QHhqbmfUzURe6Z1XCdGFyEvmPijuU63xL/Z
	 EDkWL1ebfCSOv/DIBnSvhg8TMYUcbNNw1bi7/86BQ0VDEpCHy690/kbCPJHPdmgeSZ
	 bwJmOB89FmqcU6J4Ua3+/HLxU1YENYF0l8vmTdrrQbRaNVhB9yNSUhWyXC/zcXos20
	 PlChSNZ652miur1Bh8/8iY6rKC+/P2qyvmUA9m2VDdStRizrZHBxIAagF9jdoKRrTF
	 yS2Qsc/cRwiXqhpF1RYrcuIVbjoE0Gzpop4a4b5f1JxKIzAmhh0eFW58jOYb7yAQpr
	 icDgemdSpUfsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF56E606EB;
	Tue, 13 Oct 2026 05:35:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9723DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FEFA400D8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9s9V_SsZtn1 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DC51640068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869732;
 b=nSXDxu03ejI8jNamliUwQwe4Yaw2GM1cN/RmjtbJ56LaN8B4KpMEHKEtIa+qtEOzSiSK
 hzP0FDcKtONGfszdjVMhfOwBc9eOtB/JCuNW5lnf7mU6jFTTaq+6yiecXBOXJ5Nuwk5Gl
 U2N3afOoZUFP9zqaT7oEQufpyYknW7w9DpaDZIfTRhRQprPmcilN24DDEKU71V3/ccWlm
 Pi4deCSofoAFfR/LGkYPJFC3KbGpkmQJPFEJok6pK09vsq0O7fcPT0g7yiYPFRiUBWHL1
 Go+E/MEhPy6C/eWK1L2BjsCjOpI2R4PhDMPnDSFc9f8DIdNuE7aPFbNS4S3qCNJXPRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869732;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=RToyzVOPpYsjMQwdG381udny+Xgx+CE6PzWuP/+Q2wEehsqBAPKIbifuU6L/ERzmGGfZ
 TKV75gmcrqzR3NsSgyIqOj2CCcEuO0g+otljFt6FDQRBhzKBbgOjKC/flcqywzzTQf/we
 KaWZOY0QPg6QurMyRcM6EgywnaHPk7YYyWO6hFK1fa/9fEJR2zMi6ghTI8ZG1SFNy00jy
 9khH2BF5TlT0EL2kHMMVpzouTVTrhRb/9JTKkJYXiLh+aKGjCM+ULy5GkbjhkPOkJbC/M
 ceS2ELk8sWm5UitTSURy8P3hcW3RiarxM90mdaQfpldLTh+5dv9LaJlJ0z3ipLqf+EQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=K103Pfq4; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bd6I+Okd; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=K103Pfq4; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bd6I+Okd
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC51640068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21Dva3054908
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ErfdW+jlRb
 IWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=; b=K103Pfq4xKGJ7BFMwciutbtEvQE
 upH5KLs/7s0gxyIq0A083R+PdTk03Qz1nSyj+mlTiFoHgIwdOyZVjzogJjUtS+Cs
 Yj6mcB//+pg16MFox868DQ3GwE1008I1oTazfQOmfzOZD27D7KzXF0s0+8RwwTxa
 Ox3cHk6l0Flv+VZLVJpNJGy4r2QV3UbOW14Q5cSTP07vM8Jgb/PHgv0OWtkdtPwu
 k+/x13CF6232404jKZXnvYHQVDpwQNz8RjywSveMvyz/slz45jwjgkGZuQ6+fyWk
 FzTdfmOqM0kf9XL9kTj4POR73HlWZh3m7B+jskWg2NQ1+/Ut26IA8MU16QA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aetjsx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c01f3ae4eso2596291eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869729; x=1792474529;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=bd6I+OkdlPwY+pFZt2nssvfPzscr/OfzTStonBPAGGTwOSmiyGXTzB1X2x5uGWxj6D
 X4nFZhIIDRbGdMnldGvanyjLOhDW43jQDvgI8TPObL9KZ57JJmwO+f04qxiYZoToNeBm
 3racFkA4QDNe+ksV5atH18pkXvUfN/wr41FlZzWsrF8vpNg9zOBIBb2nti3DCL7cbIV7
 LK99sF95c543fXglgFByTvfh6qSduS1XHCHMkJVOisMo9URd3HfGKPO2Z4A1wih8wbiU
 rvjkZNu2TLidbKTZaI09BQ46E/hzFqexw4L3MisBDGuGxbG85MSECT+FVrby6hknk42B
 1EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869729; x=1792474529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3ErfdW+jlRbIWkfd1yEBK+KZFA2mAduS10EWdEU0K+M=;
 b=z/kwEyCRV9s7l29GCJ0zd9sujTxT3SR1kiyxd/cfMIOwR+a//O/LR9ngn9pDxV4ZMj
 InygWjWroXUZNChuHqrb0Zra4WJj26Ac3SDCPE8IeLOfsfxCxDdOvN708NwX+VxoHZxE
 wbY3ywZu7Z68v0g5Yo7Rf+nARxkZ5Ggiqw2GpMI6k2FayaTiTmRuT4pi1HUhHdDBDgqG
 e4q3LDCk9datrVMIHXMcUqgJeHbf2+k53nlnbcUoR8mY3TvOCh/f+NsWS4sTu1/1TU3h
 e6q4yCZGK4yyLKBxHm7mgMQKAzx8NtSeUjJMAvf87K91EghreehgWRtb0vZ1gxcQnmFN
 UIHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/KXu4ZSdO4L9a6y/9F4tmIGlizK4h/xgNF1BQCV+N2Rbtwya2kjB69zl6H46y9Ru6eyXiinY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKqAg+KPYbz8Rx2tja1ONCk1msqiTvhfnlHulhFdx9FDqD1T6pZ
 aAwO3/+6GC/iBUlugZh6mJpYh/6ll3myAc6ygPNGE0ZdXz3cXioBgghDt9pYTSMQu2MOmSasimG
 fvH+xAR+I7Ff/c3/Qx/xLWt+kzAwzJpgksYr/yKjLvnr8Q6CYvZ7OGmaNtrPrc+5HY5Jcwno=
X-Gm-Gg: AYBFou2aPRlsEygvl/kBOjG4Gdp7xc76BRLeVNEQa5SM0CCofaAMm1WLWbyJyz7xfOl
 WjTg1dIAeCTHJVHRofvtLl0QwNX7kfi/W+tS03fR2654zFB1/V1VEg3wLFohztXnk/WA0rYNFE9
 61AcE03Cc+f2aaFEG5Flt5vvA/VP1mGMq0FKfU27Fm/fXUbOosXcgLN+oj2mZQc5jloNmrpEOZ6
 I75vT3sUkoJlvapyJ/aTAHzOa/z9NXLcElqPxpAlI2xrvyu133ZhHqHaQueCJoRHxLWxbJID/fC
 jydzBa5m3dYxp+7pKeaRxHYr+bckphycuD2jDBgonX+jqoi3gzcyoCwJ0/EbwTVd3soNPwbjntA
 mRSRle7Lg7tLgsml49sE3ql8oawxddv0A6Pl2bb5FmUl9tdY=
X-Received: by 2002:a05:7300:d191:b0:353:7f50:a99b with SMTP id
 5a478bee46e88-3537f50ac52mr16467614eec.6.1791869729003; 
 Mon, 12 Oct 2026 22:35:29 -0700 (PDT)
X-Received: by 2002:a05:7300:d191:b0:353:7f50:a99b with SMTP id
 5a478bee46e88-3537f50ac52mr16467582eec.6.1791869728290; 
 Mon, 12 Oct 2026 22:35:28 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm38347170eec.13.2026.10.12.22.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:35:28 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 1/2] arm: dts: shikra: enable SPL SD card boot
Date: Mon, 12 Oct 2026 22:35:16 -0700
Message-Id: <20261013053517.2955571-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053517.2955571-1-abhilash.v@oss.qualcomm.com>
References: <20261013053517.2955571-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Rz3_H1ELI_l_BwM82BQTTmuT2_6NykG
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6acdc322 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=kLX-VyqmV7a6tMBdCCUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX+NsxUZtSuCYL
 3mFqUrPtpo3BQUzCEMpjRQMuAmayKAqOWNq2VyJVwSkMR5qTY/V4RDOzs1FGBUp/16wVRzC9JNQ
 YMZCPCSirrs2c8utelKGvqE/2/wIfUQ=
X-Proofpoint-ORIG-GUID: 2Rz3_H1ELI_l_BwM82BQTTmuT2_6NykG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfXwf53wXyJ2qOS
 gMTtmHTCS3JZl3iIXoIAqsRLY0+80Q9jSGpCjMHzrC3JsElw0VKka89Ivj23XFDL9t9mLy9jQ7J
 jKgXVxluoM5RyWifEsi2BpSZpulDBKHrCNj2SeVf3mdDaJR7QgB07xHDJ34vc4Jy1W9Yd4WCrGC
 pa0SeBo89Jvjf43LiCRi0T//eN0DuoP5deO3iz5k2qk4TR84AxTk1TdcLwY2SD9EMmb3Evnr8WQ
 plXoW51gDPSGkGjizwmfBaoqP4UbL64S8Zq6Dni4N6+1u1qb4eNdOUJq4xTglSnvRdYdtdFe402
 5Kk4dYayjmTv7X5AgiHeRAtnfyIFRg7Ewqx9U3C6znl4adFHCY40SNRpt9R367FGqJWvofN+b9k
 Mdq7fxCd2mwr9aDfhAq83jdKKn6MRFErA1FhFL9CTN9zTJnfL+hM18t7KbFlydTuizOyYmHTh2b
 VXaDC2AuFiqHznH/rUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130022
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

Enable SDHC2 on the CQS EVK and retain its pinctrl
and regulator dependencies in the SPL device tree.

Add the MMC sequence-1 alias and describe the removable
SD slot with its supplies, reset, and 100 MHz limit.

Do not add cd-gpios. SPL selects the boot source from PBL
state and handles the selected SD device in board code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 arch/arm/dts/shikra-cqs-evk.dts         | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e8831da6aa7..8e2ae723938 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -48,6 +48,25 @@
 	bootph-all;
 };
 
+&sdc2_default {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_sleep {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_card_det_n { bootph-all; };
+&sdhc_2 { bootph-all; };
+&pm4125_l18 { bootph-all; };
+&pm4125_l22 { bootph-all; };
+
 &qupv3_0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/shikra-cqs-evk.dts b/arch/arm/dts/shikra-cqs-evk.dts
index b3f19a64d7a..23f416e6fe1 100644
--- a/arch/arm/dts/shikra-cqs-evk.dts
+++ b/arch/arm/dts/shikra-cqs-evk.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
 		serial0 = &uart0;
 	};
 
@@ -38,3 +39,16 @@
 
 	status = "okay";
 };
+
+&sdhc_2 {
+	resets = <&gcc GCC_SDCC2_BCR>;
+	vmmc-supply = <&pm4125_l22>;
+	vqmmc-supply = <&pm4125_l18>;
+	max-frequency = <100000000>;
+	no-sdio;
+	no-mmc;
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
-- 
2.34.1

