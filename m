Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B71606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y+G/Jo42;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mTC+9fKc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JA8pZ9o4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1622340681;
	Fri, 30 Oct 2026 12:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxmI01mkLx9t; Fri, 30 Oct 2026 12:34:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 456BD406A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363674;
	b=PpDoTWerC2/WwF4Y1Xg5pn/Iuu07THCxDgKYlDSRpBi29ohuFUqIhlz3gGPCENI0Zd9E
	 p+fu+UT9ASQ2Gcq6rd7bJ71DgGJs4mrKo7RmWN6k1bT0PYoJg59iMNQuc54eky8d/5Ts4
	 +RFe6fbVKTZXKgM8nkSLLDOKGGOMYrMzsIj6gnvLhU6DMIQ2czVUmUNturI4UIOnLgICw
	 WijdIE8s+qxQpgmkxDLPSDcy8hSxz2fjAwrS7suEYwdHywodGpZpQ0ttb4GbzxtAV+gIi
	 ryq/S/LjYR2p2wM82+53+ZG+umeBk0TJh2HWxPtdulEKWqMvYGR5M3E3xER02df/hqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BZd62wNGvPlXPYELXOwOMZRbznV5qNgR/hwrD8q1Ci8=;
	b=gxrn2JU/fRQm0UaJqAJ4vbQAh4IYKReqq28Q0XYuLHbdi+ynMVTd10Ec82mkhriSHOtZ
	 8BHjq7yL0Al0wY6t7Mo0lZIN4H96iLWBHedAQSbEHCuyfW2Vm246tCgT8EGqCwGiEIgLc
	 QUJci59NZjbbr+TRK8ezvkg6DhcLW1ocYCWxMpbP9JSCFgi65zVb4xEXAJvq4wBLpPtJR
	 N+kkGpZm/DZ8Uov+kE0EKJR+d7igmU/2eDucBnMk0R1/q+gWzKZKqhIeO2972YFGE0mx+
	 pgPaab6Tfmkn/IPW7j9tVWKTpPy+C1f4KYj+vsL9wVs/rH4jMGpbNg/qBphZejZ5GkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363674;
	bh=BZd62wNGvPlXPYELXOwOMZRbznV5qNgR/hwrD8q1Ci8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y+G/Jo42rbG+9aR9dZmGKs5fKXSCXbvEwdfPbFuFcdEoN0qO9tQeAgPwPWJs+EAX5
	 71TqZiGbmdCA1IfyfHUipuEcg5xO+0sw8hMCIqdkcXxubTmTgSQUUMyVa6Oes2S28K
	 q1c03ASgh3Q370XJLoypVsT53UxZuMiOXqxZ43PUBK/+eweNfF2N0/ZUCZflcUicAm
	 JitLTYFVNwo3wdcuyPdWjfHrDnIEGZLnY2LDlJI60hAvLnzX1+h/d2bich66Jlptyy
	 cSWoT3P7ga5fy7SjMF/7e5bAqakJl6eKHXXePXZG/8h/2TR3MJhK3li49v4TbFemNM
	 iLjtYemZ/q+GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 456BD406A1;
	Fri, 30 Oct 2026 12:34:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D9F2362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EEBB607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iaVa1zWNuItS for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:34:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B27760613
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363671;
 b=lD9z1kXPeK3gO7k2dK9WvfMqywXpPGY8gEzIju+9cORY9W/Bmo3KmBxZH9sQPq5RLx5Q
 0HvM7hvdJ/rdsswWzW7N3+niY7X7yTyx3pQk4fJixD0EVrLm0qlYln0RAJHIEMbDSpkUH
 L/smAn36UQbsNape2tJyvO4M2DSQndUNmJDaK2u98JLZDqywTkXMEZRwtZ6Gd7BrPiR0A
 oKctL8q6Ll1reADsBLfqGyASXBDGnQnoKQZPylgRTqeKEJU1df2159fwotMwOV0hfpuVm
 uKZpI/N0q7+3IhfiNVmA8TFnOWqaLBZkV5my6vgrnMRvWZMDfbabW3CKu2WljmSYinA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363671;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=BZd62wNGvPlXPYELXOwOMZRbznV5qNgR/hwrD8q1Ci8=;
 b=cV2ytGPciltLqAD24uUQdfFAIgN3zFgftCFvNUO7IMxfQpOSitkpoXhBMxgUd1c/1MoN
 ey1u2NAbPfwnG6un0osEdYafX3O6L/r5ZtguIcGUS4gkKU1jNkzA7zNzn/lP6GsrXaF55
 11rUzEmnJsyBCJdKYRmi+U11EiXwDPNEqq/V29vsveuEModGOCDuk/ArqDcHNjVqFQa54
 5PBThvF7ZjtQGOu61tRlCKHGiTFDGneXgRRj4HqJOt0YX6YGskCDn5DoD8uhPaCA4PffP
 jjhvoqipkZN63G2I+uodcSO5OSCbdJxqIU6gCrlJywx7KEGruoIqEzQxz7+NVgLT8iA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mTC+9fKc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JA8pZ9o4; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mTC+9fKc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JA8pZ9o4
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B27760613
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:34:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGWPq3679086
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BZd62wNGvPlXPYELXOwOMZ
 RbznV5qNgR/hwrD8q1Ci8=; b=mTC+9fKcLb4Pu5UznWFlVP854+4YmdbQdI+6MU
 oVUd7ZHDjBJ50O6jAAXGr/0wZmCASYhYZt8wxpshA0GrUR6Dz9yqMEnUb9jpa/Zl
 8qsYgI1h8gVlPcOa6jX+tBvn1/nr5Ae/LL73numlf410EBgPvfighg5GibcOdqf4
 5/lfUdICOjO12diqOwVYdTUaXYPHG04wIwZwZHbcrfbwPzlTCu/KgCTb7jrmNPrV
 B8n50smFvueiu4SQlTofGeiPw5eo2voBjPLeMhOHClUHbl6rFk9h66ekvZ6+UNgF
 9BTV8BWAlhIodcOvkhaWmcCnf1AXdgYCkw1Sr97pD15hKvhQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk1pm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:34:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso76344985a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793363668; x=1793968468;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BZd62wNGvPlXPYELXOwOMZRbznV5qNgR/hwrD8q1Ci8=;
 b=JA8pZ9o495HIMritywCbCoG2P+ZXvgjVBNElJyDed4D+c0sqvHMqUCJ+0g7DW6yvIm
 PJ1v9+jr9ATgdvFfdYogxI8d05XAb8gljDTM8tbyM7BAID6eMy3zL/Khdbw4INc+UL9I
 nljCbtBrGEWLmifP00r7rUP4LFCocBOOZHbMSyn7H3tPKdQEKhjX+CPzflMXOlP60rHw
 fH+SFRRV8AxGUETXQ7NJvk3+qCWLCN1Xoc9DuTs7LqvV0MW5nbzmNenrH5CxLmZj+z87
 9XJiHcixM0VT3XEdtiNoVOLOl+JtyK7zyEHNpKmmG4u7Pkqv7QVUlbjr4FJVdeuzZ7SS
 Bxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363668; x=1793968468;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BZd62wNGvPlXPYELXOwOMZRbznV5qNgR/hwrD8q1Ci8=;
 b=2gN7T+RqJ5F3us9Ez/TP4LJ2CJfbhsWCU/0biqQDBEDNgpYNyCUGMmfq1OGeWet/ZG
 GCBPZf4EIIxH7b8sA1RoLD/aOprhfxvuS5CT85G6FsUDDPO2hm4x4DmShOrBXBIYHP5s
 gbq55Xo7AwDdfIMw6fBHmOLzCE2PPlJ+QOS2TkY2E4dIAOTIQ+RB6x4o3cOOxd41XSCj
 /CRDz1LCz6PcvVDqfHeSG5ixPKfMNtbTYDiR9/jZsJTRHnY0B2lfUrnyU2SNLWgbbzPD
 d1qS9D0GCownhz38kFNheS2Iq6MxKxryrdfWIsIH5sJXC0v/JVoaYVeWpRKxF1rawNDs
 Ahcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBznCoI5Hf9o4dFJFd6uXZTxmcMyqkpIKkxkI/fmcfDZ9yW1q1B7yPp99euEnktCY2B5gd4nt1Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL/zzbaStU5rq7W6t+NB3EakdqIIU7u74O1510Qr7u94of0nWLt
 UAg0oa0X1FOKU0kbs1NqHx7GtKH/DE/Xi/c20on5I+dgzZ7efSai+EZKzEqvNggizmjum2g3ZGv
 Jo18g4rRzBMnycJR0lJ6wHev78+fpBooNV6s6T6hdinKeLDKGODAOKu5IHq2RM9kxe8Pfzbk=
X-Gm-Gg: AYBFou1llR0fx+plSLlgAu60L34jTkA4RW//F0BN/cM5RXxfD0u0QMVFk4x2ASNgJnV
 1LcfLPbBBpqEH+jp0bchwCG69uobMW9NZLowYuTiTZ+jlgTGhNgDM0gI1r9dD7ISxmDzJPih6D+
 0lnQBbcJ0OoL6WGrIrQs44/3hi2pPe+YKkwuwjSRL5SWtRWPgko2GQ4Vcek+LEI1hV/UZtRdf5X
 S3zdx/S/k1FRzz8d8NP2YTWuRUiT+vXiIjYL6yca9byz0Qs/2MbfgHLZyLfUE968woMcHHdEpMh
 PkWyU4mWZB56tivQwwc+I7ffy1vAXdR1qVqO/4BA6VAZ23PGHxPJR4hNhlh2NLBvmbUfWXAwVHc
 N5bUoc3oXG5V81pSiYiPVc5jrluwZ2E0J6glEM+s0XAbhkrGO4vpjya0eLV/nLGZnojUbwiLaSk
 XnUo1EDg5m5WpM
X-Received: by 2002:a05:620a:2893:b0:93f:5677:9950 with SMTP id
 af79cd13be357-9442171a746mr383356385a.53.1793363668512; 
 Fri, 30 Oct 2026 05:34:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2893:b0:93f:5677:9950 with SMTP id
 af79cd13be357-9442171a746mr383352185a.53.1793363668018; 
 Fri, 30 Oct 2026 05:34:28 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe0f37esm61518966b.33.2026.10.30.05.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:34:26 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:34:05 +0100
Subject: [PATCH] pinctrl: qcom: qcm2290: add the QUP pin functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-qcm2290-qup-pinctrl-v1-1-f7940c974a30@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAIBQArxJvneCHBLtKtAh91oMy04pAunvSa
 pjFTIGMiTBD3xRIeFOmPVQRbQN2mcKMjFx1kFxqwRVnh92kNJVXZJGCPdPKJq8647RV3BioZUz
 o6fmvw/i+H/hfvQJlAAAA
X-Change-ID: 20261030-qcm2290-qup-pinctrl-af359d6c3099
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfX4m9IgHB+sDwX
 Qao4pYQWUeZixi0i14AFMwVHIbDoaasT01jjMKuEJW3lhRT3xoduWHhKy1bmNhBcuQSr8l2Y1my
 NNlY2SFsBlKr5mTi6sFXhLQMd0X/6u88CkIyzOE40OmbudzFz3ju3kOSl0cvI+loyMnhJBxhpDe
 NzGbNi0crSIPl7liY7ECVQKd7NzhEC6cKMotA68d0fePmzdoLErmo3Z4zNiwvGg0LZTIgu2im1o
 fTvbq0pwIBZrdZNewtXgcG4V6Ff7uykD5DIt3xWkgyAxqcZtlfkza1MSsDB4T5TzSiV0WDuOtKB
 b0ATa8gq4Y81BG2WUkABs1skR2nJeDHKD1JxlgQPMYdmqpfu6Jp7G5s68DeiOzOzZ073QUyM9Zq
 2XMayEHn7ee5RdVkonhJmFXzMH97hcZv/20jJqwEsOh56BCJuM94IBinQk2GLAwb+TZsl9/TbOf
 nteAY2fOQePxxMIMSGQ==
X-Proofpoint-ORIG-GUID: wPCEd4wiWLTEnH0l_PFbUGkcVY99v51p
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae48ed5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zrH52x3vBimwXsXJAtsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfX8XyTUPf9UDdM
 2fpBU7tsdPmtayzLBbb0GfxPE5fRW1wahDk1DZiKIJtd2ZNj352L0NPIEeRf3FkVtadLlo5OzeT
 t5Y3j9RSqCs285ceA4m+16BHRVDysvM=
X-Proofpoint-GUID: wPCEd4wiWLTEnH0l_PFbUGkcVY99v51p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300049
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The QCM2290 function table only lists "qup4" (the debug UART) and
"gpio". The default pin state of every other QUP serial engine refers
to its own "qupN" function, so the function name lookup fails with
-ENOENT when such a device probes. On the Arduino UNO Q
(qrb2210-arduino-imola) this prints a warning for each enabled engine
on every boot:

  i2c_geni i2c@4a80000: pinctrl_select_state_full: pinctrl_config_one: err=-2
  i2c_geni i2c@4a84000: pinctrl_select_state_full: pinctrl_config_one: err=-2
  serial_msm_geni serial@4a88000: pinctrl_select_state_full: pinctrl_config_one: err=-2
  serial_msm_geni serial@4a8c000: pinctrl_select_state_full: pinctrl_config_one: err=-2

The warning is not fatal, but the state is not applied either: the
lookup fails on the "function" property, so neither the mux nor the
drive-strength and bias settings that follow it in the state node are
written. The pins keep whatever the previous boot stage left there, and
a driver using one of these engines only works if that stage happened
to configure them.

Add qup0-qup3 and qup5. On QCM2290 each QUP function is in mux slot 1
on every pin that can carry it (see the pin groups in Linux's
pinctrl-qcm2290.c):

  qup0: gpio0-3, gpio82, gpio86
  qup1: gpio4, gpio5, gpio69, gpio70
  qup2: gpio6, gpio7, gpio71, gpio80
  qup3: gpio8-11
  qup4: gpio12, gpio13, gpio96, gpio97
  qup5: gpio14-17

so a single mux value per function is enough, as it already is for
qup4.

Tested on the Arduino UNO Q: the four warnings are gone and the board
still boots Linux through U-Boot.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Add the missing qup0-qup3 and qup5 functions to the QCM2290 pin
controller, so the default pin states of the QUP serial engines apply
instead of failing with -ENOENT on every boot.
---
 drivers/pinctrl/qcom/pinctrl-qcm2290.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
index 84f76b63b93..766c7cd0db2 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -13,8 +13,14 @@
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 
+/* The QUP serial engines are function 1 on every pin they can use. */
 static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{ "qup0", 1 },
+	{ "qup1", 1 },
+	{ "qup2", 1 },
+	{ "qup3", 1 },
 	{ "qup4", 1 },
+	{ "qup5", 1 },
 	{ "gpio", 0 },
 };
 

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261030-qcm2290-qup-pinctrl-af359d6c3099

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

