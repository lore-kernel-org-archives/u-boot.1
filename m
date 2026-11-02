Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6B606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bXz22PwI;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j/1dEebb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bY70n/R+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3C9940693;
	Mon,  2 Nov 2026 05:52:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcK8mem6M5Rs; Mon,  2 Nov 2026 05:52:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A0AD405ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598756;
	b=FFksNi82zGo3qUj1fcLqK0CW/ECMvbmSb7gfBcNEw/nHRyJkTc1r/eUnTyZ7qwybHaSW
	 JSzILgnhcdT0suExzhmlKNYW4z5OjWKKdWOGpDwaqwmcvo+3W8mY9qiJ4o3O2TbFRjMtI
	 zB0BLsg1APwkLaqJudW+mRt68pAmnEUpMwcO3bBayjP9EvAh+HKFC4ZzYKfD6Pn9nqLG0
	 ALLxGae5wgKeN7p93Nz5dyVT0UwBAFcESk6MfyOWGwgW8B/D7i8CRBzFN7sbPh0URJG/i
	 yS0aY3anDonyoD7Ojli0VOwiT7+ZJ2+EKJky+LawvYvhb0MwGxBxZfRRteWsVt5rCrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
	b=PAfr/gxjy87aLNKefxrPBbwTOzBjltcgHgtBKeUCe0M5NyMlPkYdLPwKmaOBAWF2lRjN
	 1AU6z2Xo3njAWrnMPgAI1B9Gon2i1usGoQwZB62YWCi0N0vOiiR0vzcMdXeiGKd4/D/5L
	 9KFbVPpTCcddBxyk2edA9l1/krIepbpYtY50fNDVu6Rapd+3Dh+4nQneSaFBiEMUdWtFh
	 ydo9VDcozD6Pkr7xl7+ZhEQbiLP3/6Qz62BZxJTs/o2AC3Ri9F6Pwgo1LVuNv7rN1W1wW
	 PTBAaTjXXAB0PidX+jXbQNzzquyVrQga0fDnL9/TfL4yB6c0/HBPJfO7gxEE2yItoYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="j/1dEebb";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bY70n/R+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598756;
	bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bXz22PwI9/loIpcrmnfc6ii9C20i7pZ6DHvSdrBtFI+4ynoZN1mU4wz7rZH7Z/u/6
	 GDCdWWtuTeaLlAFdPX+2uMWGsiE3F+2C8dpWWKUM3jbgYTdR4YsuPzkcg1c/5LiI1P
	 dOHJOix8JmDr0tswPjY70+yor+KISF2iDRmQUh5BrQsOKxiQYwcqCtoVZyeoy571Hp
	 H6Qx1hpO+tTzeBoRVkk9x21VGdPK+V85mt1QsJoKhnZQj7XVkTjlHGixhewSFjnmL5
	 BkDIDbVQQSic2mRCn8RNTVSGLFkiCwx/JdJW6LqTlGfO4tkPopPd/OW3tt61e2QQJ3
	 xc46uxq+RY9gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A0AD405ED;
	Mon,  2 Nov 2026 05:52:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F207B2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3199405ED
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOmz9y-rvZX3 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:52:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02F6A405C6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598754;
 b=leXMgFb07xg9YJDCjLTmH0gk+E0MF+nyReuugMkiSZ2woPtqXeqUWs3suKHwxDjdVhxH
 tt8cHhiR46+a7HuVz6+gXj3VBqbbFJpLqGXfEL2/uVWJvsdyjsJAJsQFxGQJ0TXQH5S3K
 to8uQG1fGLC2N7F4UBPt6/1dMJm0s9bUwHNq2zC4YFoqr4pLIGJPEOmvtTQ5PQfMzvCBN
 bKc8vy6s52MCX4LeAvpekMA1mHwYpzRdxjExW1Ju0b1nkRQQCeln09GCIM1mHDEIEdzgO
 bNaK310YLVMDygjnchOCzAqroqR4VXMazMOtBXEj/KxR1s/iaV+Ehb6xDFuXnjHYo8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598754;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=PdIF4Vow4Z/cnawqPvXtErIN9zDAGbX5fRTB0rBV9F4hsMeg7D+dO0KXDPU4LpWoP2x6
 egaewr9gkp5V0tDZDG2YA5/rj9xeIb/kjx5d+r5SOfOVQ9jFb+mo6SkfTZ+y4rkmL122c
 f6RCdPZwda3WNMkclS2ELpOyYx7dY/uOicoan2i0hkuUsF/thuOL8feigNv2xQATmEX8G
 weIkYkNGLn/ERm3zgf/4T3LCjeAcY1ktXJ/a4Hr7ZAd9TOSXBOphHLa/gmmKmjrzgbBJL
 8K6gIGOcoX0v5cFYoDBXeNuWSAHfKHeH/E0gCaUgaePopM+Po4jldBb0sBFsvTLFa9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="j/1dEebb"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="bY70n/R+"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=j/1dEebb; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bY70n/R+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02F6A405C6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:33 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24wCx91262393
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hNqixf2OBM/WK4ayNFlj47
 umGz0vK2TYZks2HNrjOV4=; b=j/1dEebbz/9kTda6yhc7n1kfesaA8W0264Vu6O
 YGvtxToNeJq2skARWlravyts8kQapWX1yNaIePwv4LJplP4buJGrhP7ma+iceiH0
 VjLhHuHQUHWjmMCBAeDmktEWgAgovJfvSWLhkjOfLAA3VWWSnEDFqjIlIhcIPcvz
 wyLUBg022V4GGhe7lB8cqytrFBTTooewiNJoxKyGUZGWGX3jFvNfkZovivwReRPm
 VweJTjhUhlglGQ4BJgVejTlTyDInROJZrf6106A22qe9HPyEL9qsr36Z7GyGZ3RE
 tL+9kEiL6L176KTJUBnnNVOolEvUV8HvBKrsoonA0qwLZ3Jw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4g4xm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:52:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a223755e4so11530804eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598753; x=1794203553;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=bY70n/R+bcykWZYLMzQK6Y602iAgO95tsF3whUFjZNUVatOOMYKG4VebVxFt4sfLgS
 UMMRONijz/sbS3QRDBkH8Fx23jXUkpADTsDx8968IamYLAKi15sgryA1LtO8XYA9fld8
 /lZHupexB5nxnHxx6z5RdaniLeHYFH8/5/v3PL38e+At5rMRVwo8EOVSRGPzJtY2XNal
 vWYmG9TLh3JYooKd4PeQ2XhHU42N1apH/pwqnnHYZ369C+Wzo8JdScj9+rQUYc/LcPWS
 1GPQp66RIXVdrro3M31v9n3xaSPhJWQHmbghPh0UbDRmYsXUBcAY2t2UfMQp+LQsKT0x
 mG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598753; x=1794203553;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=zCMlLcrg3Wg8tQjMK43B/g6rflDYDUsfgc4WKHjy+BflVx4sWWiVUFJFn1U+XS3cig
 zeCmy7UrNufDQDh5gvIydukCEis2WEROkQ6uBSnCBuwMPRa30WW5p6mOiDfWqTZ82kHo
 MjQWnhWs3kb0IoDx3ucx4hlwnn8rsCEeWikUB2uVI1tIBLdtAxH+kfZcXsjdVa2xFnZL
 UjmzXJSIAOafZRgsxIKN65AelHTMcExvDBJ10lVGPlSNAKqSpevuFgssuQ57ADHUk91j
 Ijd3rTFfnPpmeUJubb62+k+3ZJKmmYPl+PEVQX2irqWDd94PSvLqAktkJGJJXFXPwQsv
 jwig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGXpwpoIIgnVGIImSAW8C8846EcZ65I/sZh7+AUA8P3e531rydVWu5UKjhGT1IjP8ydUfCdW8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z92T3+ehWTX0HNK+14weTxGl/aXC8NS2UXF8EAWYywEp3PY/YBZ
 4P5vvw4jv8tA/tvTvlea7/1bcgFhas4+I3BwBD9oLpTGt+KXLDTMUIwVSTDTYqSsWjS3TBt9OW0
 ZjWTtrHtpm62ee4epR1BL6Mstjs0aJug4ONQXl4BmphacxY/NZtXE/AN+csWmaERHFOJ9SSU=
X-Gm-Gg: AYBFou0Qdoqj5rWA4aLvlOkY7L2UNl4CILwtWL6gQ+ntI6L7a92zd5+ftYPq3WZNZnD
 +GKOZIBLGpc0LZA6moKwLoQR2huQIDqJU/Fl+BSxrZYMZfAuO93zKAwxjOeAs8ceLWxULPdpbbf
 URpfl9LWiskP3SdVa4k8JqdyhVwDFUkz5IMUkrlpT8+wo+2jzV+4r2SnosyKPrXVGziV6KIbN4o
 cwtlf94HhZHODL5wSVgQLyDmIgHFDdev6c/peTS9K1mhVnK4Ezb1VX/IYLrVOpoxofgdNKkK0rJ
 Sf8D3ngtMVwBr3GuVNRJedLtaW86g9zR4U0058W/t2nsUKPh45WsyBrrwYwedcSnEVkh04yTJNg
 QiICz/h4/wbrYBDg8zs2oDYE2G83U7MoRSXmxyEQlK2bgmjW1c6h1IcpbrDK1MC/VvaZYqNieZu
 CW8WYzOSdUcKcFXKB/sdZMPi+y9A3MCX9zoV0o0RWpk+erH+GYHoKo0/+Vrf2x/IxHK7SldngE3
 dL5qA==
X-Received: by 2002:a05:7301:7e16:b0:361:fd60:3cd2 with SMTP id
 5a478bee46e88-36a4232bee6mr13632518eec.10.1793598752519; 
 Sun, 01 Nov 2026 21:52:32 -0800 (PST)
X-Received: by 2002:a05:7301:7e16:b0:361:fd60:3cd2 with SMTP id
 5a478bee46e88-36a4232bee6mr13632478eec.10.1793598751825; 
 Sun, 01 Nov 2026 21:52:31 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm35456366eec.7.2026.11.01.21.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:52:31 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH RESEND v3 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Date: Mon, 02 Nov 2026 11:22:25 +0530
Message-Id: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 3LrjMeZO7dLHbbmOOMpgGsbHlkhS1U_n
X-Proofpoint-GUID: 3LrjMeZO7dLHbbmOOMpgGsbHlkhS1U_n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX7+4lOJwByh2F
 C6YpXDxUst5DYCnwsSOb2tztH8AKOl2m44WzfDg8rV63g4lY2vCn2V7tlGOTbmgTG55Vt2adVwH
 opBqYq4DvNO6Rl9x8dkcHwhb8Ub6Oec=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae82521 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p580P5g6mWtK41y3Ph8A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX6RCmyMgOXnJI
 WHqukqKXjl/q3yaCVMfIFqFYe0+ltg3BZfj0euFnpU9PwxN/gARaaDXKvaEZWoI5D6QSyfRz2qk
 1/9DZO7ZypB0pOtu/ZneI3yZenmFdTMz1vjIfYTCwWMqLXHF28iyEhrhrW+jxmCxf/MnKbGtjrQ
 KqGhuY9HmpWuvtSnLx0bgq/6u03J3IYSM3TxuwxvFwbOoKyyCZjqNaYJgrEYCoVXM0kEvV+/kDT
 CUFAV2hdq+uleGDV8wXAY+gXW9nyRIrfxnFTPdPe7E29tfzGJbugdkN0vEB9Yae+7bu7MD4BvyV
 d0nJXw8C7cmnOJv4K11uMjfvxwlETfaXCm5LqjWPWEltSjRtVKYuhqg7cAMBTXcEKn6Uk9qXEt5
 DIz06OcKpoVCJX+4L1tTITvoPvNljUvCLvz7ECOorMgmll4hg+SNW8IllJ6Qv/oaNg8nXccZaSD
 OIGOrHPpzvSMceZRHzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
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

As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
the mkmbn script has to be upgraded to create images that can be used
in the ipq5210 SoC.

These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
bringup' series [1] to use mkbn.

1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/

While at it, fix the MBN version number for ipq5424.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

---
Changes in v3:
- Fix review comments
	- Add CONFIG_QCOM_GENERATE_MBN to qcom_sm8550_defconfig
	- Remove load address from MbnData and for all entries in boards table
	- Remove '--melf' option and modify the 'bin' argument to take
	  multiple files for combining into multi-elf.
- '--melf' was actually not removed in v2, but included in revision
  history. Apologies for the mistake.
- Link to v2: https://lore.kernel.org/r/20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com

v2:
- Remove 'load address' from MbnData and get it from .config
- Add qcom_sm8550_defconfig
- Use 4K alignment for padding the MBN images
- Remove '--melfs' option and make them positional
Link for v1: https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

---
Varadarajan Narayanan (4):
      tools: qcom: mkmbn: Fix ipq5424 MBN version
      configs: add qcom_sm8550_defconfig and debug fragment
      tools: qcom: mkmbn: Add support for ipq5210
      tools: qcom: mkmbn: Add support to create multi-elf

 board/qualcomm/config.mk      |  2 +-
 configs/qcom_sm8550_defconfig | 16 ++++++++
 tools/qcom/mkmbn/mkmbn.py     | 85 +++++++++++++++++++++++++++++--------------
 3 files changed, 74 insertions(+), 29 deletions(-)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260714-ipq5210-52e1da5af9fc

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

