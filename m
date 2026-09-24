Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A6C9831E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8382140B33;
	Fri, 25 Sep 2026 02:41:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UeEISmbRdff4; Fri, 25 Sep 2026 02:41:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9F8FA40B28
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304100;
	b=eQ76p0F/l4t2/kX0LZt99m+D8yTU0BwTtGP+AR6wekiCp/SkP+7EJdkU4+nXLMxFoBaR
	 vFzs4DQlw0MdbEU/qslZTkqbT19JFsV4loCELSlP/TY7nc6LiL+EmNPUGgArhlP0AhAO8
	 o1jOQwoHl3gvJNVpZCcciy0KQUMLqShf+NZslyoV/oDl836AzwT/SrJ4PqhhmF/GT04FB
	 Cg8z/OI5QMsIujhBuno1TCFcX/ypyVzE3c+ruzOUgGHbxuBLWz8+ELxt/sjQNVej0uaFz
	 2l+VZ6m01auw80wmyyeCquHZfEFQXBcppM8B3hKRuDZBoKxKopyyyjiH1gV55Pl859Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fRWjvdXJOwc+CL9Cqm0V/YV+62JnSg7teAFqbePLdHs=;
	b=o5dpdPA1KGV/H33hXPSJ/irW5Sr5GhnFMnRrq6+eLRy1KMLPoxxPepjlbwcltbKQ1ZJp
	 47ad4yjpHApuPjvFgR55NN356cFKZ2aIHDeJNVXcmD+8wbRovR7ERf2k63lvd2FDKeuil
	 FHf7eM+RStxZUCqrhsSCpts87nDZETMs4S/cYAGgaNMlh+oH0OSdU8U8NdkrO/9Mb0khM
	 bIcfe8ODLz5RMnVQRnFKYbabgCcMFKlz2RqKKR2IaKUEr+ZnJcepxXpoxbv7KGg0LCJ/P
	 34YVag1cRAex7ZYhYrAyFIsaHvlwpheMz6FHJOPzTh83dVrTXRz4rYB0xSKkylE37OQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OnAvR7D5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VYbOulHp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304100;
	bh=fRWjvdXJOwc+CL9Cqm0V/YV+62JnSg7teAFqbePLdHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ewIputzd6zya8sJxnMahIQrSWXe5fQ5Gk3cJI57xIXLD5BOCvU7gbetGtOtoXJWUb
	 XKrbBL4YnoAHu3Axro/vRCZYr70M09p1k9fb6pZZoO2HD1qSxZFMNxABdxGadkW538
	 4PH7rNYfa0e6L+xqVwjDzUw/9nLIWFo3mPLi68kh+8b7YPpb8Uqy29xw0jkBvZ3L8s
	 OPlN6WS+9VLjAvFWk1fWvuBu9JnMc8h+0ADvDWHplV/RDxtkx92s0UkIpuj5b4H8Vj
	 HjU3FrrwLJZHcGBU5pP3G9rjNHi0OwmfeAaajt5ygwf723+3Lu98V9lLWW9CZNdOVT
	 fwkgVM1Q9SBMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F8FA40B28;
	Fri, 25 Sep 2026 02:41:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F54EA32
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2156340AF8
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCPXXl_opQ42 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D79240AF5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293089;
 b=CDlVJgVt5lH34rBNzhxH5lA5kTmkO0BFzkryMuVeCw1SmvBV2WigOhGlf+RwfqpFKZZq
 FJex2DsApOPRFhXdfir4FUgsB4V+eCd6AiXBurjFrK/utnv7SrfpPHPwxyI+bJBdqVa0q
 b5I10PRN9SKwlu/8/IMV1TIs/rcd3+faJm5OMn9dfQSzbGuG19gtZn3BcOvkBz9XM3QEx
 ZDbA+o1UrmOsc62/6Sx9U3jhYfdjyeEjCMgaRmKKFOP9i5ncbHdrhX0UcsjxzzjQZj9Xa
 1YFS58m9zrbWnviPIiv1Ns1KnjgX5eAt1DJ3CFFrBmiXR7tmsG7+mWIeRo2KouxpV7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293089;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=fRWjvdXJOwc+CL9Cqm0V/YV+62JnSg7teAFqbePLdHs=;
 b=NnCS0UFP61uQNWh/UfgktCSjEt5c3WfOb9ka2jT+zGRey44qeaDQ0/YmN3YppABKrCHb
 rGMT9ELkOyUAeLDQB85l1heg4OHsFfTAYlN3NIghjRiKkBv1JMbNnruSWgHVfxmAGkmOv
 CxTTHiesjvj5e/A0T28lkJumpUXUOf4Mi6ll2Vtjggiv9yaJdBtjtQE/SRTJRjHTEYhaI
 JqDUGCNgrT0BsJyp6coH+bLWHEMGRqG8iPkWAuFkF8JFNoEWsgFNHzQI6wNXCTVUIvGbI
 T6SicigEpnKpHGCjiE6pY4OhF0StWv1r7Mu//pU4o6lrhC/8oAO1rlPXVFENYoNGHGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OnAvR7D5; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VYbOulHp; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OnAvR7D5; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VYbOulHp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D79240AF5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:08 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMP8qB281015
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fRWjvdXJOwc+CL9Cqm0V/YV+62JnSg7teAFqbePLdHs=; b=OnAvR7D5lw7+r8HT
 H3IF767hcDpToJNAdNDtABLIBgI/xeQMgJwxIPqEqd1QfZXNRznZTWlBXD2Dkl/j
 s8cDSSuZ+PfyBz1nsW2z2TEc/TqsItHBzXdD22WUYxhN6hDr5VBeLrK+YqRo0Z92
 sAZuirJJNg4idrUW2o3ILssFYCOoa8nonYlPF3CypMebjBBlT9pMJ7L4K64/K7PP
 GiTaG1zf7OLJ0p0732YKVp3RqOuphWR4MFvMgnJZF89mbmpmKsbum+kvaANs5Wzv
 o+tnABeLo/kOkKUCgzePbVhR7VStib5BXz2yfplmP8I9T1MlrFYb4XQsa6e0l8dM
 uUTORg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce78712-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:08 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-671321441d1so540896d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293087; x=1790897887;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fRWjvdXJOwc+CL9Cqm0V/YV+62JnSg7teAFqbePLdHs=;
 b=VYbOulHpskOlH3Zx2q9nmymKHmvRvIp70G6THV0Gwj0iEj765KzXt/t6i/WSq4SQjl
 8uPx3JXtMEAXz2c9GTd76a2Q4Jn3e7X0bvRsQTAG8vO9LY0ueTGcMMTjoNcF4nOEDJ0V
 5V29lsz7toehS7yA9AQSsodJtH0t9lXD8hsIAlakUfSZEbjsHVbTT9+SLsVSkP+M7p0N
 Zd2GsUMZB6WwLdDVlo1kry8B+rElqIPCOdb93kC8w7oXPPtr/04B7JhBCfyhy4hKcwpT
 /172cSty0TL6gE9ZrQ1+H7IY3tkVYWU/5fQoEAAJQNXFw9QvJhZZlGdglrRHYa5Mpmf6
 ZgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293087; x=1790897887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fRWjvdXJOwc+CL9Cqm0V/YV+62JnSg7teAFqbePLdHs=;
 b=DSDT2SVt82jCvee3vbxG6nD565KK1eqMzVRm7WQXYroIrscTwmFtKEijIsGNjvfVUw
 KqCOfK47SEi/Htltu17NjWh5lnbI/icW/O4cR70HU81pRHvDJkYomU6jmMA4dDmbY0Oo
 rttJe3t54NeM9yzKl9GWCXdAWXxia34NA/XfjGPshxd0jwdrLboaCIn+EZuvSGzTJuAJ
 rsqFyQN7JbYYwV2/hiFfecLQlFmslYg9BgOmIMKQSae7Gq3znmUMgtUCqf430pi/hhgB
 PCJ67lJhTh220uFww7NPuO3Y4MIeaPQ3G8JLxhAQKNs2E30adld6Czj5DAQ4GoThSNyL
 yFoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgKSelRmltsCIKSpE48dY2hxFwAzeGtcVG0+SU/qreVVFn1KdrYAgPEn4MnJ0rh1I+tHcV4lA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ko4lWL/zZ3YHwpwolj9aDZBAZrl23Z4U+UjcuyVD1H3Vs+qx/Y
 ONX9vLVg+zX1UvJHB/Xe2o89WN/OnwyRc2MdpQgMQNJPLXMDtT/FgDAnSfdXR2hPdxUEtxI8SVX
 x+W0wq8qU3YpgsRg0N3R+H6Yukd+lo1HALp5mwCzyz0U39KXgosdHYsosvH1ifSfLLVqDvWw=
X-Gm-Gg: AYBFou0wym63YS2fQBGY+kEe62bRtn/RSMv1brV1Aj+vUqp78y8UUmCam/wBoJD+lDq
 DZ9DFWKkiIl0NsT6MYskxfA4Zud0Hrr6vuteKPxdWfx2LcA0zJmObqsfxWQlFeJczPQXRexPuFd
 +QU/KTbeuoQKYWlek6mc+mVRgUPKIBi9kiQOaU4t//nk1a3x5Jkc4Mfxid1PqTIaaMsWWzNHwpR
 fMfMYWRdHayW7pSGBQd4Y8v1KC+tmRX3Zn2f8/iykTf6XhUuAyHKtPYSCWk4B/8gj6ktzjRfuUY
 DtP4a6dgVGO+6ZvBjwYWbnAXr6/+WWHCReB47S3HuGugygsxQPMHd/jEoVxSJM6ktUthBbvjC7J
 iKxlrGk7Ghh04EfdLysy+c3uhpAz166h9y6ei55Z8LCa2MplEBCLNR3vgtXqOQgPfsLxXU/UA
X-Received: by 2002:a05:690e:e81:b0:673:697a:d527 with SMTP id
 956f58d0204a3-673697aded5mr1531491d50.35.1790293087209; 
 Thu, 24 Sep 2026 16:38:07 -0700 (PDT)
X-Received: by 2002:a05:690e:e81:b0:673:697a:d527 with SMTP id
 956f58d0204a3-673697aded5mr1531486d50.35.1790293086763; 
 Thu, 24 Sep 2026 16:38:06 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:05 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:38:03 -0400
Subject: [PATCH 2/7] clk: qcom: qcs8300: add QUPv3 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-monaco-ventuno-q-v1-2-290b6a4d10c0@oss.qualcomm.com>
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
In-Reply-To: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
To: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.16.0
X-Proofpoint-GUID: 1yQ-c0Q8w71q4CZKdMTO-FWI9wrkXuD5
X-Proofpoint-ORIG-GUID: 1yQ-c0Q8w71q4CZKdMTO-FWI9wrkXuD5
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab5b460 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=jn0L5PBHOaObxGYg8HgA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX9SSXo1KtfxDN
 XbwlIWDugmRgO+DQP8KVMC1StZ69/T2mC0iAGjjv2lW8YQPsTD5NSmt2UvLGjGdDhy1QKLHjC4z
 kL6W2M7TL7FWzObXOBfIkN7Naf8ivroFooy9oEG9f88S3C9o5TpR1Aai3HB0D4nHGlDnNnkEZ57
 5COqjDoJB4iduzS7p44CkeoHYIHDk8YYTK6MDIQiw5t+KOvJtWcOYgt7ysQMK5yXn9h8QejA1bB
 1v++FCO7O+l/ezoFTaF5FDCUqVLDDC2tPiUACH61pnIUXJEnXUA0/yCePoivH1+ZJuECetR8kla
 SR2RZfCEyQCJOjW4ufmcRBWR9aUB0C+TECTMl5ZGR1QTtXeSQTEHjLxpJtz70Um4bIDdqdKZVzm
 HBeCRqsk7VheoM35jUhrcX4B1hiIXL4itGrnpGNc9d1RKsGRbUGYAD5K4iMpHticcGjluFGsihh
 RP5ZghpxNXz5vX5YLwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX6F0VVcSittAK
 oywo/Nkko7VjseEIjarCko6VllcNWynTqziTtWPJvN6YsSS3sTrsTMSGpcFdeHfOCGMd01aRceW
 tnGfBlrHrP+4ahmqP3E/5lM0FGzEaMU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240096
X-Mailman-Approved-At: Fri, 25 Sep 2026 02:41:35 +0000
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

The QCS8300 clock driver has no QUPv3 clocks, so every QUP serial
engine in the device tree asks for a clock the driver does not know:

  gcc@0x100000: unknown clock ID 109!
  gcc@0x100000: unknown clock ID 117!
  gcc@0x100000: unknown clock ID 121!

Add the QUPv3 wrapper 0, 1 and 3 serial engine, core and AHB clocks.
They are branch vote clocks: each is enabled through its bit in the
APCS clock branch vote registers and polled on its branch status
register, as the Linux QCS8300 GCC driver describes them. Rates are
left as the boot firmware set them, as for SA8775P.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs8300.c | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
index ac5b28ae34..361b74d709 100644
--- a/drivers/clk/qcom/clock-qcs8300.c
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -70,6 +70,66 @@ static const struct gate_clk qcs8300_clks[] = {
 	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
 	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0)),
 	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0)),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x4b008, BIT(9),
+			0x23018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x4b008, BIT(8),
+			0x2300c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, BIT(10),
+			0x2314c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, BIT(11),
+			0x23280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, BIT(12),
+			0x233b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, BIT(13),
+			0x234e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, BIT(14),
+			0x2361c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, BIT(15),
+			0x23750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x4b008, BIT(16),
+			0x23884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x4b008, BIT(17),
+			0x239b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x4b008, BIT(18),
+			0x24018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_CLK, 0x4b008, BIT(19),
+			0x2400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, BIT(22),
+			0x2414c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, BIT(23),
+			0x24280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, BIT(24),
+			0x243b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, BIT(25),
+			0x244e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, BIT(26),
+			0x2461c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, BIT(27),
+			0x24750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, BIT(27),
+			0x24884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S7_CLK, 0x4b018, BIT(28),
+			0x249b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x4b000, BIT(24),
+			0xc4018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK, 0x4b000, BIT(23),
+			0xc400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, BIT(26),
+			0xc4284),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, BIT(25),
+			0xc4150),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x4b008, BIT(6),
+			0x23004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x4b008, BIT(7),
+			0x23008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x4b008, BIT(20),
+			0x24004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x4b008, BIT(21),
+			0x24008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, BIT(27),
+			0xc4004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, BIT(20),
+			0xc4008),
 };
 
 static int qcs8300_enable(struct clk *clk)

-- 
2.47.3

