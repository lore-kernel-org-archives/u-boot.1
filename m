Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4780ACC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 09:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F253180D34;
	Tue, 13 Oct 2026 09:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbKAKMNyAm0t; Tue, 13 Oct 2026 09:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CD0780BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791884615;
	b=efhyoTU+Qky8Y+PhvLYdbAZsx0SEPPnliCMIlRV99VyXVScNWEo/FEiWG8Zag6ILOTq5
	 kL7sp//XI8YEvDBvoRP/UqFEfdD58owDbk+lD4m+kRRhtLUiAWeTmX+iRwoCuNsocSz/m
	 2Y9Ryupm7erItvOsVN8ze+4Fiwh2Gox5le4LO5diy289g9CjZhvyPbGly7+k44Czkes7+
	 qn9ODqDAd9hRpe39kB/yA0hDevmUx0ETo2KXCzjQsLvIuo5FmOVaf+8suO1zWkDVUHGMV
	 YxqW1U1VpudKZ34O9as7educEq9be4LK8Vpwhh8qKDdgigndLyxsvPnqRQeRfXkxZGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791884615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+W4hEPY5BzrbyaPlA7LnOVLxr2KlYGvf6A0DepBfb9k=;
	b=j3i3dBCqAVtNjer1N7nn3yoIn2Abxj7eWoWTWsuiKMjyOVyRy55Vb8/edpZJHUOxu0vB
	 uONEBXF3h1S/DZ2dZ31QiEppqZ0FfCIWhdVPDn0LSagxVmfzL4KDWINZIbuV2OIL5lT6o
	 wF/F0N3bhROE3bU+5Ngu/a8J01WmEbsd8CR3+mDewY5kYR0vpVN8sKv+Oxu+wFfZvWz6n
	 czPlc8VcMkA1Crqlff/mmpsMvJ3n2MXpJfozVYaUcx2K+eIhFCVdRNPCXyplyQeROmDCX
	 EqswipH+v9nLbp1efPT053nvDmN8o3QhIHLkT2YSJWLbvJjMwFKIsQ9mGqlmgeYOWdQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791884615;
	bh=+W4hEPY5BzrbyaPlA7LnOVLxr2KlYGvf6A0DepBfb9k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MJ2lSO7ow+9OmysKrkyFuRMbxpLFT7thxwj+Q02f0yqpBfjVvdadOFRHLFyBD33u8
	 qkd6ZS9g0dZwdtPInR5RQZi+NFE/UkAX/LU1Cl2wy+9vF9VOtE3dhOgjtFS/bbAai2
	 Cde7YUzbTU5/Xr6UU3dF5Y2J6XLcdHZ9yMnIUWKaSo5U/iDzXUK0EAocNXrlMfHfgR
	 MUSaij+WKA5FBCDL14ABuTUPANFSky20Y+9L3gEwgIX3rsv4s5GQJ8BxA3363b8ZDP
	 PWMrnrnCG5El50rtb4n8K16IaM/VVN9x1lBdX35cbs2qa4JZHEjJaaXuoJDAKJ9/yw
	 pFawSGodp3JGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CD0780BB8;
	Tue, 13 Oct 2026 09:43:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 536C1129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 452F240609
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txdAEmgWpXDE for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 09:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 584A240606
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791884611;
 b=roybqDGLMqp4wCMiVWXqrMY1E2UbG1sSEKisPM8M8F4GOLYYUYpbsy3dUOZ+rGAQ7uQs
 UdaSf0OLe8brbg7pv3LSyYOBqNWZXpCgLNTyHFg+L+/gTs/AZBLXp2h8e6ZBY4aQaHU/J
 O8AAp1w6mwJEmCimion3QjL60WsMkUDqObnzbFY+cuXHzMTe5c1QSgDSmibUXYwzh2S1e
 bhIC5Ph5tPtfc4aBf/LXIPK3JxM7zf27S2RYVykdKTod7LlrCkk6lS5FNPt0cIdLdCgSa
 AvFFfsDWSQD1GDY/6JQyS7F2Wse2KXCQLVGgtvCIhycth9tPw/N56G5jCh+jwvaYUfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791884611;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+W4hEPY5BzrbyaPlA7LnOVLxr2KlYGvf6A0DepBfb9k=;
 b=HN/4LYcI+/UNrX8DYp/HA+r6cCuL+QdfONVroCrP/mjDc1nz1IadLJbUtS3zMCeP5DOA
 PbS38doAsvc8skgr4xDyQFTXlLW8sxhDaGXwnm0w5XZEtgisvvXvSF+RkyV0u2Qg/T2gC
 KqtrWmOL+zx09Ec4XwgNySaaE5lvouG0XCH6JWEqnjYf4Wd2lNNfNQtTxWdwu/oQDqGYs
 7kYNKX48Q8lqPuF6biQk5QLQbEyZQTxT8ETjd5pfBGodkvv+MN7twA8jxvMRGYuL/ZS4h
 l7DKKUccd4CkthNDe8ujZwVHp1DnIacL9+suH6uY1mcKkZ7JZ03/ncWw90B8nsc7nJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HPKXqpM6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=E+X52CHD; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HPKXqpM6; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=E+X52CHD
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 584A240606
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:43:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D86A9D302840
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+W4hEPY5BzrbyaPlA7LnOVLxr2KlYGvf6A0
 DepBfb9k=; b=HPKXqpM62YyCxGfqnYigrKSB8oL20rL2BgHMr6JTZNIZJYczmUJ
 KnZU5sI1a8eQhOVw7ZrWHqILibRXJVT+Pw/Zo1ubrbA8rYR3hl/M93hN4Csj5QB9
 23KayRU9rG0lHcpIZVWqnNajhnt5YiGGrWF6tLOqL8Lh90gm9miA1Sn7mQDSPR1W
 3etiEr2oUKV4MH2N5/Xm5x40iqPLZsZWRQQBJoIl+H1aSW95pUNXb5hUEBCm6Im+
 RadsDkEJNJlb0h9wfa0ustbWgaVIrEK28jngXapxHNsje273Lrj31dq2yETVUc6X
 wQ6r5HiACRurRvTRkexVvGW6peydkdwcoRg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqa6jn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:43:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so8168085eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791884608; x=1792489408;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+W4hEPY5BzrbyaPlA7LnOVLxr2KlYGvf6A0DepBfb9k=;
 b=E+X52CHDzyQV1kjTW5QFfOO61k/1vZC8lS7LwVPSU6i5eS9rDW8Ry9KvlhYI4f00JW
 ZkNyUhQ8L/ZyWtig7cA23JcSsoN9ZbBG9bb4kCsySwJwloy14ZPzVv4XoIpg8Ala31/O
 7TcawatKDiQHyCBLHNJIoC+y8sNunMdd18y9y4VZcQKB2Kkm3YXnXMBp5RpBCsc7NSlK
 R7/b8vlBs9T736J5Pilh/5hK/SxUUKQCwwk7sGe9lqIngHjICX3/e1gxKdSwCUYL/zgZ
 siup4PEzot8QjkpD26sn7f+eplJltqGncy7Mp4xT4bSh7TBC04IHWf4KXhdFw92z5Fv2
 EoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791884608; x=1792489408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+W4hEPY5BzrbyaPlA7LnOVLxr2KlYGvf6A0DepBfb9k=;
 b=mtK9ZFkj1qNkS/b+ZQ0KOusBxjcAwamRy8atMFkzsADzbiHbMhEGyiWVpA0vjetWYP
 /25y30jDRZQSMn6PKHVfEuiOI4iXm35H5uds3+X6e7d7918T+7K5sj38oY8lXDANvz2Q
 GZiG2dwSxS6a4lUvJgoLeGXBPMcIzwYLoP393x9smNr8tNUtfgy8JAcCprBRrPJesUQU
 /QvtzUzDvxc1b4fWI9uKYWjfTIVq4hqIqEUIeR+UDXZStV9U+Veo6b8g0XHtqQ5vO+ys
 r75/2p8MVRgM90hUAcMkhBW7h+FI9ywM/vWIGJc5YiNA03XcgdBt72LKNDnow4XwimSY
 pKmA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFJjlECX/Zballf19by8sXwvyzwDWqp+Nn0gIx5GL6iA7uoPemh4QVTuuZKa+jmcnSbYuKQGc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLT7OGOhJ2UrkBtXtgzcoK/KPkTnM9ckUf+c3ydh7nHfxKfVmXt
 0OP2Qqzf11WwgfW5WMBHO0e92FRZd0uIkYq03pR6RwCVKN+aZpfrvZ6ks/uytAAIrcDtPgMIoDJ
 zd9AxHkUTF5bczcsgTtk0xm2laT6OXk5d+cCcA81tvgPFoGSwP/FstUSfvNEW6/5Kgpwbsj0=
X-Gm-Gg: AYBFou1bojeyB+tQlDgfYa/G6ZC1H0GpNcAF1tNibfa1YlOGOoLlZu76PTknR7LXL8z
 W0YR0ehnwIeCWMcGPuPWtBs+4kT1VC+UI1GE6rx4oQRe2IFmxVayPw/w3Op4wQi3fSHXB20FR/7
 nmzzYJCuae/hxRUd1cgOTf9zS1ur7qMj67TTVbsyp4VVkRZUvTK9PV28Ks6fdV6SeF8bo7lpScQ
 Fjmh6l5hBblpcgFOsdQm3VZRUuGVErQyLOcwfy38Ij9m990I5V2W/Y5T65+OaogZB8ztVouQIOZ
 FUGziaQXjrcJa8R+0zgTlZNiO/fZhKLJ6UdqON9Iao/s71HKgub7BKERUWQJKJwfs/Nx267xGQB
 zV66Us/tvBluOKLKqtL28jqogyp+W1jwot/hsc1y16HDOsi2OQsBAyENg1li600DIEIudXCD1Dy
 CZIW9tvIN8rsS/bs7m5w==
X-Received: by 2002:a05:7300:559d:b0:359:8492:2107 with SMTP id
 5a478bee46e88-3598492227bmr11670187eec.10.1791884607682; 
 Tue, 13 Oct 2026 02:43:27 -0700 (PDT)
X-Received: by 2002:a05:7300:559d:b0:359:8492:2107 with SMTP id
 5a478bee46e88-3598492227bmr11670150eec.10.1791884607140; 
 Tue, 13 Oct 2026 02:43:27 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a279sm41665685eec.30.2026.10.13.02.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:43:26 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH RESEND v1] mach-snapdragon: raise block cache limit to cache
 full GPT table
Date: Tue, 13 Oct 2026 15:13:10 +0530
Message-Id: <20261013094310.2408439-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOCBTYWx0ZWRfX9f6k5OWM+n59
 8DAcO15WGswKA1PJexeT4U8aoGoeq30XUhALYbRdz72v6nTPlpV+lZcGWWlIESEcgUHO1BKW5gx
 VLGXQR8Tuk3rx53i6oNuH7WftTG1jxC8o/tmcYG3Cdsl3ONPTFXF3x/afkL47OWviEZSb2cuw+Q
 VxLXNJVBzmRsMg3K+v2XtZ2JTSOPA/jtnfuuo5VQPXiouuQlthrweuSrLsfE8sbUVtIkb0B/XR6
 w7JXSF9yK3b1RRUgyAFkXsskJWUrOTmzxfjJYr3y5Vdffl6Y4bqLeC7IU/sFTL85zp6CYQkHgC8
 8/QX6yYVhmCcKk6vgQ37E7GYbhfG7aXkFw16fPmQfAtTPx6L87cNJeiKnhSd/Xuk3hx0NVQq6Vi
 5/ebAePTU4GmHvYC4eL2RE4glJCH1G1rK629FXPOZIdSo+LOim96cvC0pcUNCPfJFHycZv4ed53
 3fhpOYrsZvWU4CKoKsg==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acdfd41 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=1VxDqnHFAAAA:8
 a=EUspDBNiAAAA:8 a=J54uKDEkSAFcm6cqkTIA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOCBTYWx0ZWRfX1LdfJO7nvtMU
 W6+izY984hselxtblHu4OmGTw07CIkzNx6j10RiiEkjm0ontT/CxEkCC6wuhR20xf779Vm86Pyy
 bPVNBmBau51+DlALUBH334b6uZkWhO0=
X-Proofpoint-ORIG-GUID: tXnQaLsxHS2ejU7rCbpsL6NsTNVIAWxf
X-Proofpoint-GUID: tXnQaLsxHS2ejU7rCbpsL6NsTNVIAWxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130038
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

From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>

part_get_info() calls find_valid_gpt() -> alloc_read_gpt_entries(),
which re-reads the entire GPT partition entry array from disk on
every call once per partition while looking up each partition
during boot.

This happens because blkcache_fill() skips caching reads larger than
max_blocks_per_entry (default: 8 blocks/4KiB), and the GPT entry
array is bigger than that, so it never gets cached and every call
triggers a fresh eMMC read.

Raise the per-entry block-cache limit to cover the full GPT table
(computed from CONFIG_EFI_PARTITION_ENTRIES_NUMBERS) so it is cached
after the first read, turning subsequent GPT entry reads into cache
hits and avoiding redundant eMMC accesses.

Improves boot time by ~800ms on eMMC based devices.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87adb100edd..b87e5ce0e89 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -11,16 +11,19 @@
 #define pr_fmt(fmt) "QCOM: " fmt
 
 #include <asm/psci.h>
+#include <blk.h>
 #include <dm/ofnode.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
+#include <part.h>
 #include <soc/qcom/smem.h>
 #include <sort.h>
 #include <time.h>
@@ -30,6 +33,12 @@
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
 
+/* Number of 512-byte blocks needed to hold the full GPT entry array (entries * entry size) */
+#define GPT_PTE_SECTOR_SIZE	512
+#define GPT_PTE_BLOCKS \
+	DIV_ROUND_UP(CONFIG_EFI_PARTITION_ENTRIES_NUMBERS * GPT_ENTRY_SIZE, \
+		     GPT_PTE_SECTOR_SIZE)
+
 #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
 static void show_psci_version(void)
 {
@@ -153,6 +162,15 @@ int board_init(void)
 {
 #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
 	show_psci_version();
+#endif
+	/*
+	 * Default cache only covers 8 blocks, too small for the GPT
+	 * partition-entry array, so it's never cached and gets re-read
+	 * and CRC-checked on every part_get_info() call. Raise the limit
+	 * to cache it after the first read.
+	 */
+#if CONFIG_IS_ENABLED(BLOCK_CACHE)
+	blkcache_configure(GPT_PTE_BLOCKS, 32);
 #endif
 	qcom_board_init();
 	return 0;
-- 
2.34.1

