Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115ECC982E1
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFEF360EE1;
	Fri, 18 Sep 2026 20:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3JQJjDhq2sR1; Fri, 18 Sep 2026 20:07:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86C9660ED3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762025;
	b=rb7Ir8pKafSm9YJBdvwUkwxPtTSdVX8kwLqPlXHxlY6dkn8Ec+MmZWOhcvQmdhLpM404
	 rxF2d3USbDDQTfexwvlJJ9Ul7VUBEq6IVnao5w85XqsbI4QyTnZ0S0f+7ETlokTnKkSjo
	 idK+RbFDIt3FCr/5tDTMEro/iDy/jqvw2BTCSwSaFMaypVK3/9mvkK7WKSuvv8nGrqOIh
	 ptDFMI88i3MxmwNvG2R8saOgTwQKrziEdbvEeV0CXFOpF5vBxbcGynfMMdHa46YpMrMhf
	 F83Iu3M9HX26xtS9dCBdyu7S1ze5ilGvlHPMQVvBZb050X8Z0ikxVytB5COY7UGqP7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uUU7Y0zJzWHuXY3YRPU1QT2hg0q7BygZAO4yI0HWYjs=;
	b=OQkv0lkgilD1BE0tZ0WrbW1m5Rm1nbVoMmFscND9T5qvrXYdouE0zrcbScDCC2eL/JaJ
	 f4prXtfQSfLABucj68NgOGq2RcvM8/oVu21djbTbK+VDrTks7ea60ODcw8de1DWWqGbXb
	 2q1bamjncrKvWsghWjhmO2BT38mahLGS1bD5COFBPVxmt7ucykX4oNaoVG17KhjpuRCAl
	 My3q4keZX8F681Mruq2PRUXN5ntILuA3xvdiDOzQstjVIifaiFfutVzy6k59reSZ9NJC4
	 t1J97PAHy1/1c553PNYrZBjaWrHaXdwvg2DXfkTeuRkTAGWEmqzaBHEgajvGWvY0vkQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E4wZ4TXs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i1nU7hVY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762025;
	bh=uUU7Y0zJzWHuXY3YRPU1QT2hg0q7BygZAO4yI0HWYjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0NuvrzpKaGy96vwdjHVyulxI3nDaLvMLb47QBn21GXsGvUc4tiYmPATfuVC2//0+j
	 auS0iy+A8M7tAwWa3f2OZWWS/zSFvCNxdyy6gMGsI9Q4RObK+7SvJIyohMgQLfAkx0
	 TbFiXm1x8dCkPTp2xNM6wCJcN2hkVpjZnsX9P4Jovw5mtNL9TF5E0xRu0s5ZKQXjer
	 dH62IUfWAmmmrtU8v+8WzFzsAKyvpMpVPDR/v5wjt4EixYEwR1cc2/HraRA+pe0tul
	 N4+cNklp65fbYGyZn24Nh0fPjxsqduQl7ai3venF4AMmvssZ8i50+mhyU+yLj3jiXi
	 leefKlT7+GlWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86C9660ED3;
	Fri, 18 Sep 2026 20:07:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8987B42D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BE8F60EDA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZY5MrvZcOJY for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DAE360ED7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762019;
 b=JEmovwSwDdEqPjag3JG+VWn3yL4CgTte/t5wcBp4f+sWcdnW+2QP2ZPEsBH1Ln7KTFCx
 dlq5VDtxcw0EiWz4VRNE7/YshqBXMxAyrKgRx8UcVTIY597/xpmKgk8KXsAiQZ/AQP1GM
 p1GO+LY69ezNVlnUVFAMx1FORN6DCZZ0LsxpHURQbHHtqlyg0IXwS6fENfVOM7mMe5ld7
 xMDWCcJnRY5mxKquVuB++CnmVx1XEhpTc8V5b+NCti/Iaz5qGdp+pV6diMwIGX3xuo8eT
 mRv+JNPapBSoreI/d0A9whXZ4rAmePGOetsVYUa+kVMed92HOEczOjocfhX53MW5cpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762019;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=uUU7Y0zJzWHuXY3YRPU1QT2hg0q7BygZAO4yI0HWYjs=;
 b=UOY1IEO4YrewaqnZvhhpV2+P1daf9qBplz9CbEj0Ga/4ddU3pP79W99gjP3+CQv9TtQV
 BXS00qDO2YHPCVUOvq0+7zxa3xvEuJ1aiDS0sGPE3UZrewjzcrTlFleXOpvywEo1Syk1Y
 YoPgUyULb30htqhAw/ZE9Qud0mYVSNKDdw9ABg4FJOe8vWRulsU2Ab/0qTA8bUzRSiq0I
 jDx4sGhCEtqdKFGQ2I2on5vgge1yj54QreF9VxGNqjcJfoCmQ+Lci8WiXoHmRq2bc2Xss
 kEf/Vx1siydeMdoEpJEwurpLx9C1KvHdtvciIq567lqa6ydNr5uaV4w2L4w0wIzqrAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=E4wZ4TXs; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i1nU7hVY; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=E4wZ4TXs; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i1nU7hVY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DAE360ED7
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:58 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGo3Vo565800
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uUU7Y0zJzWH
 uXY3YRPU1QT2hg0q7BygZAO4yI0HWYjs=; b=E4wZ4TXs1p5UmoV+5/qWhQp0eX8
 n/S4s60jEFMdeW+FGgDEDlg6BMqpm6TEX8wAQ+N/l5Z5ISDlCUynUY3xxH64Snxh
 cBZJSvmzrE7kWGz5akyKWzBJ7EG4JF2olivkg6KvJmmz5ZW8/4VqlunxAHF19CMc
 /pd8BwkCTucnX1xXQBu/lSLHWkPyixwmndcNidZYMszrWinlzfQcS+5MuqL8yMSJ
 KHgnXaqvHTjGLksqImqz3CnsKPrRqXaQpOGB1iKFFx3CFPHHBrSnAh9uoGARXkMc
 k+Gycw0E30YGfh7zZNtxtwbJHvoLhE/nWoLcvYeNozsjXEHzOtRkPpgAzSg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs83wh5gv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:57 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e9e1dd7fbso689207241.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762016; x=1790366816;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uUU7Y0zJzWHuXY3YRPU1QT2hg0q7BygZAO4yI0HWYjs=;
 b=i1nU7hVYvvF8fe4ybBns6UR4uSGrlvFALVGsU7y7OHH6ph3WjWRbjv11Fu4QYuJR/o
 ghp7P/mQJ6U72WK9qumcWvVKLfElCSm9I2+ll7z/8F72YpUY1b7zPH0709suGjybv++C
 LH6+NTNa0qH3uR8RmlZmt6OAVf7KoETfpFoxp6UcTuiK5MbvCd0Ci0dHUZi/xcq8fYeF
 zvUxMw50r7KvFUGSfVXHltabNz+Y+F0rqwhbu8Y9wDtBce/9QSRIYc5SypVvv3ZnXqM6
 7F+RjHp7kBd3GueOgrtxXhuqovrlv/n9aaBMFAZZFAFr4MG1xJ5kFObBPBfkfxXG8nZk
 dBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762016; x=1790366816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uUU7Y0zJzWHuXY3YRPU1QT2hg0q7BygZAO4yI0HWYjs=;
 b=tlNzgUOhTfBG5mN5iYh86ejiErqN60huUkRCPuXD4UZZouybvponcGEftQz1r6rdIU
 O2aGfkOyw8M58sp73l3KGIDzAH6dN3HPe410Cy+fDFiUukQIWqfZcJPEzFlMJwXWdGx5
 UplfivD6toupY4OFT3SR/f8u892/6eqIH9DMdUnNka1kPynwh938aDDA18t/IX3FBy8I
 A3cELEQx+Q02T6yMJ6Q/D3xb8GwIXjIBFCAdOgdhrflvOK6U+8LjOYOKn2A3DoRNkury
 Z/B2QNpD0kpUasLEkKuM5YZNoXlu69xe+UzRkM92fuQWBdJDzU/l9vEMX1OP3aBtwE8U
 anZg==
X-Gm-Message-State: AFuF++n6s9aHMk2x7lsRi/KnTelCyyqZRY4e4OyFhSw5GgN0ix3dZdbj
 BpAJ6ROtoDklUj3uCrGAaXtrqlHUfXGHgPw1Ty4ZVnEZ+aqZ28YmpVosDoAb0qf3Sd93u8ceX2f
 Vp3PuxTq7J+Ayl9FjOuTsbYVPNbanQtiLYLTf/MFRQ5igrSL/KajSR6iKg24LKHVR4ou0d6c/jd
 S6MkA=
X-Gm-Gg: AYBFou0MFxg6olo/uGXj+Jf7k/AbwF7R0KSuqesipJsM1xbnc9aV06bwSCGWfn2B9qw
 QQ7vaEgGfQyLH3yMuAY5a1f8ekVaV8sBlxMXAhJ/e+pLmp4SDQBdPQu1wU4AIpqCnfhq+6l9lQt
 50I5oVvDUpWGorifl9+mkHxy93Hoa0inS2kenS81i5ZIZJvLTZfWMkR/EKh8/rqjQhjzjRAiSRE
 EpqvKqtpXleIQEQNGHN6K9zb0ImOhvKgrEkEdzIb9qms44M7Z89VYCq7b0wwW2Uz2QmeFolrrL3
 O2CDL/70Ni9ujigCp6ZdKEUNkF8EGK3/Pl85NJrR0YupfR/bHjExZMzFn6XGxrre5G8GDFs2Che
 zDDTdzQtqhLQnvSM01MLM5IfZ/MngLmHQ9WbNhZJd/7b9s+Y=
X-Received: by 2002:a05:6102:5549:b0:7a1:f7c3:3a43 with SMTP id
 ada2fe7eead31-7a55c885639mr2211371137.16.1789762016345; 
 Fri, 18 Sep 2026 13:06:56 -0700 (PDT)
X-Received: by 2002:a05:6102:5549:b0:7a1:f7c3:3a43 with SMTP id
 ada2fe7eead31-7a55c885639mr2211352137.16.1789762015881; 
 Fri, 18 Sep 2026 13:06:55 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm1136798f8f.30.2026.09.18.13.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:06:54 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, dlechner@baylibre.com, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v5 4/6] ufs: derive the per-region RPMB CID and size for OP-TEE
Date: Fri, 18 Sep 2026 22:06:36 +0200
Message-ID: <20260918200641.2286077-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2wtWKJrKXcg0fbHNXrQJCHo0EwKLQhA8
X-Proofpoint-ORIG-GUID: 2wtWKJrKXcg0fbHNXrQJCHo0EwKLQhA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX7exIcEtFBzqs
 /4eA42M5dredA/CikhtD9MJdTcFY/1Sqmy952X/ZCa3W4WSdstMZ5PqUt+oFk/j0mvGEv0TnEUE
 w+fcU5dkI3PuMX4sO5WUu+e8E9uRsAhLuZWaEtqTTV12hU4v8pH5alCsg5qG4ZLbNsw6pOS2mvJ
 fNGnLrSiKQviu8YxSyE4a9v6qhWRR85VkqoKxkkzkzRAiiQTV4JnHt4gc+P4UVLDOkVnVHef7Zj
 5JpA6rkNAfc1L6/3qFTxahWIO2N5ssOOidWha1dlydZRqIL97py1fNIPBRI8bbgmh/iOMSCd0NE
 zRUYmabz/MhGCyusIXVQlrkwvaBZd5oTDXTfpdxHrNjsK77H26ANNgu33jkClKvNJR19spMYZZP
 sVQ81Gfuy1x+q4aRNvG672EgZq6epkbV1oKzpbt84bViykL3qg0zhXKvWv7DY+jzw7RjtrqrRvo
 UUK+BysJlsQ5XW8qCLA==
X-Authority-Analysis: v=2.4 cv=ScRi5fRu c=1 sm=1 tr=0 ts=6aad99e1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=_wGwWCd7Qb3L-efQH6IA:9 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfXw97VN1qLat/O
 QlQPQntxHP5BnjBAIsZd3X4iu60n2gPy2ndaIZVOKgqbzjQYBMsgZQa1aMSx8+6dS1uDNMUzNVj
 zNgvESSyEtOpj1ij5u3I3DHeV448gbo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180290
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

OP-TEE derives its RPMB authentication key from a device identifier, so
U-Boot must supply the exact identifier the Linux kernel uses; otherwise
the keys differ and OP-TEE cannot access RPMB storage provisioned under
Linux, or vice versa. The RPMB probe also needs each region's size and
reliable-write count to enumerate the regions. Provide both so secure
storage stays interoperable between U-Boot and Linux on the same device.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig    |   7 +-
 drivers/ufs/ufs-rpmb.c | 181 +++++++++++++++++++++++++++++++++++++++++
 include/ufs.h          |   6 ++
 3 files changed, 192 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index a0067b1f203..648b58b46e4 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -95,11 +95,14 @@ config UFS_TI_J721E
 config SUPPORT_UFS_RPMB
 	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
 	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	select BLAKE2
 	help
 	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
 	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
 	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
-	  The OP-TEE supplicant handles a single RPMB transport, so this is
-	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
+	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
+	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
+	  single RPMB transport, so this is mutually exclusive with the eMMC
+	  RPMB supplicant (SUPPORT_EMMC_RPMB).
 
 endmenu
diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index e6e0b2aec33..18230786abe 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -1,13 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dm.h>
+#include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
 #include <scsi.h>
 #include <ufs.h>
+#include <vsprintf.h>
 #include <asm/cache.h>
 #include <asm/unaligned.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <u-boot/blake2.h>
 #include "ufs.h"
 
 #define RPMB_REQ_KEY		1
@@ -24,6 +27,17 @@
 #define SEC_PROTOCOL_UFS		0xEC
 #define UFS_RPMB_SEC_PROTOCOL_ID	0x01
 
+#define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
+
+#define RPMB_UNIT_DESC_LOGICAL_BLK_SIZE		0x0A
+#define RPMB_UNIT_DESC_LOGICAL_BLK_COUNT	0x0B
+#define RPMB_UNIT_DESC_REGION0_SIZE		0x13
+#define RPMB_UNIT_DESC_REGION1_SIZE		0x14
+#define RPMB_UNIT_DESC_REGION2_SIZE		0x15
+#define RPMB_UNIT_DESC_REGION3_SIZE		0x16
+#define UFS_RPMB_LEGACY_SPEC_VER		0x0220
+#define UFS_RPMB_REGION_UNIT_SHIFT		17
+
 static u8 ufs_rpmb_sense_key(const struct scsi_cmd *pccb)
 {
 	const u8 *sense = pccb->sense_buf;
@@ -165,3 +179,170 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 		return -EINVAL;
 	}
 }
+
+static int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
+	int ret;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, 0, 0,
+				     desc, sizeof(desc));
+	if (ret)
+		return ret;
+
+	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
+
+	return 0;
+}
+
+static int ufs_rpmb_read_region_sizes(struct ufs_hba *hba, u16 spec_ver,
+				      u8 sizes[UFS_RPMB_NUM_REGIONS])
+{
+	u8 unit[QUERY_DESC_UNIT_DEF_SIZE] = { };
+	int ret;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT,
+				     UFS_UPIU_RPMB_WLUN, 0, unit, sizeof(unit));
+	if (ret)
+		return ret;
+
+	memset(sizes, 0, UFS_RPMB_NUM_REGIONS);
+
+	if (spec_ver > UFS_RPMB_LEGACY_SPEC_VER) {
+		sizes[0] = unit[RPMB_UNIT_DESC_REGION0_SIZE];
+		sizes[1] = unit[RPMB_UNIT_DESC_REGION1_SIZE];
+		sizes[2] = unit[RPMB_UNIT_DESC_REGION2_SIZE];
+		sizes[3] = unit[RPMB_UNIT_DESC_REGION3_SIZE];
+	} else {
+		u8 blk_shift = unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE];
+		u64 region;
+
+		/*
+		 * bLogicalBlockSize is a device-supplied log2 block size;
+		 * reject values that would make the shift below undefined.
+		 */
+		if (blk_shift >= 64)
+			return -EINVAL;
+
+		region = get_unaligned_be64(unit +
+					    RPMB_UNIT_DESC_LOGICAL_BLK_COUNT);
+		region <<= blk_shift;
+		region >>= UFS_RPMB_REGION_UNIT_SHIFT;
+
+		sizes[0] = region > 0xff ? 0xff : region;
+	}
+
+	return 0;
+}
+
+static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
+{
+	int nchars = ((int)raw[QUERY_DESC_LENGTH_OFFSET] - QUERY_DESC_HDR_SIZE);
+	int i, n = 0;
+
+	nchars = nchars > 0 ? nchars / 2 : 0;
+	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
+		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
+
+		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
+	}
+	out[n] = '\0';
+}
+
+static int ufs_rpmb_build_cid(struct ufs_hba *hba, const u8 *dev_desc,
+			      unsigned int region, u8 *cid)
+{
+	char serial_hex[QUERY_DESC_MAX_SIZE * 2 + 1];
+	u16 manf_id, spec_ver, dev_ver, manf_date;
+	u8 serial[QUERY_DESC_MAX_SIZE] = { };
+	char idstr[QUERY_DESC_MAX_SIZE * 3];
+	char model[MAX_MODEL_LEN * 8];
+	u8 raw[QUERY_DESC_MAX_SIZE];
+	u8 blen;
+	int ret;
+
+	manf_date = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_DATE);
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+	manf_id = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_ID);
+	dev_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_DEV_VER);
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_PRDCT_NAME], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	ufs_rpmb_string_to_ascii(raw, model, sizeof(model));
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_SN], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	blen = raw[QUERY_DESC_LENGTH_OFFSET];
+	if (blen < QUERY_DESC_HDR_SIZE)
+		return -EINVAL;
+
+	memcpy(serial, raw + QUERY_DESC_HDR_SIZE, blen - QUERY_DESC_HDR_SIZE);
+	/*
+	 * The identifier format is an ABI shared with the secure world. The
+	 * kernel's ufshcd_create_device_id() hex-encodes the full descriptor
+	 * length (header included), so the serial always carries two trailing
+	 * zero bytes; reproduce that here so the derived CID matches.
+	 */
+	bin2hex(serial_hex, serial, blen);
+	serial_hex[blen * 2] = '\0';
+
+	snprintf(idstr, sizeof(idstr), "%04X-%04X-%s-%s-%04X-%04X-R%u",
+		 manf_id, spec_ver, model, serial_hex, dev_ver, manf_date,
+		 region);
+
+	if (blake2b(cid, UFS_RPMB_CID_SIZE, idstr, strlen(idstr), NULL, 0))
+		return -EIO;
+
+	return 0;
+}
+
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 dev_desc[QUERY_DESC_DEVICE_DEF_SIZE] = { };
+	u8 sizes[UFS_RPMB_NUM_REGIONS];
+	u16 spec_ver;
+	int ret;
+
+	if (region >= UFS_RPMB_NUM_REGIONS)
+		return 0;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0,
+				     dev_desc, sizeof(dev_desc));
+	if (ret)
+		return ret;
+
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+
+	ret = ufs_rpmb_read_region_sizes(hba, spec_ver, sizes);
+	if (ret)
+		return ret;
+
+	if (!sizes[region])
+		return 0;
+
+	ret = ufs_rpmb_read_geometry(scsi_dev, rel_wr);
+	if (ret)
+		return ret;
+
+	if (!*rel_wr)
+		*rel_wr = 1;
+
+	ret = ufs_rpmb_build_cid(hba, dev_desc, region, cid);
+	if (ret)
+		return ret;
+
+	*size_mult = sizes[region];
+
+	return 1;
+}
diff --git a/include/ufs.h b/include/ufs.h
index 1bec3ce73a4..a8b7d370f78 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,8 +20,14 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+#define UFS_RPMB_CID_SIZE	16
+#define UFS_RPMB_NUM_REGIONS	4
+
 int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 			  void *req, unsigned long reqlen, void *rsp,
 			  unsigned long rsplen);
 
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid);
+
 #endif
-- 
2.54.0

