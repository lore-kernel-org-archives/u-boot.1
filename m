Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DB1C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0753480FFE;
	Thu, 17 Sep 2026 17:02:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wdYnpiIc3DEx; Thu, 17 Sep 2026 17:02:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8178D80F89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789664537;
	b=CSUg3OTmVTbd5t8/9EwJZv3tD2Mmf1p/WsSa1mSppYdHPW2yCmutSXew1F0OrwV1YoPm
	 mhYzEfieVy/0wxOYeZmnUt6nxx/ZkPhRK4M8pLUC+3JSJXm5250jU8bIpVuhZeBqZ+5N/
	 lThutr+I29xHwdvACQB3ONjeRzzKgFVDiArsFjvyo9ICsiIRLo0yPjLyycGzrE5WqdbuW
	 cEU3NqftokOBB9AHiL3HFif7xLP1cEd6LdapMoOAYban14QgVygG4/BIZZARllWmwFAMN
	 2yQoqTEKk5aTC6EganAoP7CpKL0htsdmBpKloa/75ktx2sbo8bVRZzzpyK3KOtV1V8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789664537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2orXGjAANhfyN6+lwwpji9q5iw+d7aJTPzFqWOAlIBE=;
	b=JPnSw+sUO5o6K1yHD4FOZCS1OAO4D3EeR0NXrX6lqF72uFVdlwsZ6jktfklIDF8jeGfX
	 0eR4ch8KVhnKKane8XNKM6oVpG7hfasLdxfl6osbV6fnZE/40XsYxqRBzn1p75Yt3hT3q
	 fEu7N10I0HCLcO+qV1t4xslT2ycHmZj5e8jHIx8GUIHFR9bJ1M7oj7lnNWrgSYtrIsp9T
	 4BJNjC4PQAVpESENmBbyoE6MwnbwOnfmYneRo/819BMTZQTTsntY+n9uB1nA0X8IF6fil
	 Uk3rNIlGLFYk2E7fNYMJgIPZNP232Sin57sOYlLhyA+XU+6Y9Qn3vZVjCEyCXUwI8UQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lV8PVDvp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gM1ApEb9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789664537;
	bh=2orXGjAANhfyN6+lwwpji9q5iw+d7aJTPzFqWOAlIBE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uRw7A6HyvLRMWBCVaZIBbnMUTgxzV4JX4CH7iF0Q156Lw9Dd+QKpsyEMmWboqsa6I
	 Y6Rbg5RqTQc1COJzORSnw2H+1onK+TJfQB363sMuJfhde+4zFK4XPcvJspkmu/nyml
	 ZOIB5dUhPKcVf6+CjP58yg4mu68wqpwiL6E5WLvIi+RRIyynJDgKklfldU5o2Q7/7z
	 yfjA/RqXDx9Whn6NYY/JuWJZglHNnN+R3eB5d9JuC0qmZHsEVwWFxDKVtJfjx9Qlcx
	 DSuOOKklVEdUaD+q9Fl787zzvhLLM9LYnvlAWYgEFME8nd9vwM4EQvBGWmbZmz4i7G
	 683DA35B/o/6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8178D80F89;
	Thu, 17 Sep 2026 17:02:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C3403AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D82880F19
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8NGApiYNTXW for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:02:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E265980DFF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789664535;
 b=W9KXgtXjC66E2q9XCamPJ0HaNua7BBIZdFNghE4D3eXc8TlBHntVLz9WjKb/XoWqZCZ/
 667cubnuHmTPHwqyQ1/k4aBK59o9Rrf3CFz55zQ+42R8bccUDN6n4dHRarg8j6tOqYFO/
 zCu5GzL4dvAyU6jax8wvHmYqjJdaIuWmYvBGYSJwNkVfKGpPDT96gM3iUmUFO4JSYIZNv
 79KVedlVRt1KE3ukngrRkRkv1QdQUYT2vzwG5MvzCTCE/s7wuKGq/2fetkIA6WS5gkGEl
 bL1IdYUqm9ZdAl2/uiE6te+RZmN58cQPtEg+bK29tdHu1AVrYDb57khwaPSwxKpeBIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789664535;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=2orXGjAANhfyN6+lwwpji9q5iw+d7aJTPzFqWOAlIBE=;
 b=I2ZERFXeWkTdC97XYu+wwNumlNUHr/ZTSSwqQh0OS88EG3CUwJx/3wDun0cPAG8DKcr6
 uYav/WjEMZ1vnHN2YBtErGpXGypQV4vHvW29C5V88echpwGo8jdbzuCEBe3vU2HgHPmeR
 hvBZdMnGNJhKHpvt7wtBAE49+8nfB8LqCtILMexn0KelYAk0m0H1zHP7AxvKBItDm1RDR
 ug5AmSSBGPLDJUISjhFja6nwK8Foisoo1A1kRkAvvBgKQ8g2gK3xmvctRXXQc3MiZ3aj+
 EiASKg5nnkjgCmfpqc/CvgolrTE5WOf8FgszEGi50KTJlxiqQIQi2HqHirPt/vUgSug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lV8PVDvp; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gM1ApEb9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lV8PVDvp; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gM1ApEb9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E265980DFF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:02:14 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HEChct2496608
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2orXGjAANhfyN6+lwwpji9
 q5iw+d7aJTPzFqWOAlIBE=; b=lV8PVDvpfsMOsMEbbkD1zMLRRLwuglZQxAaaIv
 scwsLZCMirHIbOoKWLOy4jmDeHQTzzj/mv4oMph2ttI73H5I3uYSigM7cW4wkUNT
 HAe54LWSZCM7JKjsIcOQ1x2jy7516lFgY9Vk+76nJiSgDHGhrDjcnb+ykjYoI6Gh
 vwPIxc9YL70l/MlMe5QYSB+GC378jxao2+YKUM7U6rXL/bnRPowdPd6h57z5e5ZW
 RK7B7KOiRUA5eZQHG7Z7FiH7KF0lYOet33KMfz9kbwT/xfGwGOJphTlCR9ru+RbD
 sYdy/WDQ58SfWvPPLKXebxZGZ6rXNgrlWcvjSIHYXGGKqRFA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grhs6gtk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:02:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39d865b11b4so1421262a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789664532; x=1790269332;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2orXGjAANhfyN6+lwwpji9q5iw+d7aJTPzFqWOAlIBE=;
 b=gM1ApEb9ZdKIkoidrFFrzVn4zXv+mxBvjy8Ze8l3MYqPkEzrEyShXQMeCma/jMUYxo
 MmJ20rOayhb3py18nfieD6DfPZBEzm0eyG+X5BxR2KZ15ydCizYrSDh4okWb2YrZ85zW
 SRSTSXhB3bL3/x6hluFdvIaFB89iKRhtAzlm2SkF/RmnNeLsAaPiLZM+nxfGAARtQYPl
 u3ci20Wiq+bJgQ6HhV3S/cNY0zQ8DAq1ArvdAjTaUJDk9YXBN8fbQ0XuutdvKgwNVU5L
 bVbog/dXiAFBVGNh+cv1JkZ81w/rtLpk7HrHrjU9Da8Sf6cltlEvrFi81gg44nvtqxVs
 71Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664532; x=1790269332;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2orXGjAANhfyN6+lwwpji9q5iw+d7aJTPzFqWOAlIBE=;
 b=jgbDA3n3yyLLkJNFpsprCwAp6G9OQvZbQdGJRYMkwAkdVeP93vRnXmQZ4L8q63ek4A
 qXOoAfDDZiS8mk240jaiOsvG/Z8kCToMLnfWb+37STWKenlR2dvSwZOy4muTDolTUfOL
 ikRDsC+KTu7HhZf/ewN9Cey2JXu8kxraSAROExA2GAfwqmJMQe6J8YquZCnIZIF7iPOy
 /g5dBd7+AQwodSMKZUU6dJMWPyTLQJR55bpEcurfP/VLSoCqGaURWyuFfmE6l9IYxGvj
 2MgOyZdvfQoOxr8j2Cg1R53xDk0k1QiVZWVDBF6dbavW8PR/Vcn3KX6xNwZz17iEhbZp
 H9CQ==
X-Gm-Message-State: AFuF++kNMmfl1p9xWzlOsH+KY8uSWoEFkIxKShRh5T/ORxN8ZgLr5CgT
 xNp5S/SvNQ8954/gF62Dldv8cjEZclIiG5D4qeqvDfU2kWv97f87yeHtjIhtsf18RllJSRo2zuE
 8Qd6Enn4ipMv/N0BwzaxW++ih2H3IW2hd29JF4Vnrhfuth7yZfB+FlAulVcgRETA3jAR5ams=
X-Gm-Gg: AYBFou3hIbsJ3BL9vuRmN3iLU7DI8fG7sM9vL0Hgayq18f/2T1E3zdPi4PtrBMMbjhT
 u+ifxwAh5kmg6HPeFnkHmpPxIhQZT5JOhcpziQANamGrfY+suxBW1Zxi3sSpmDy5u9/Jas0bJDK
 +rkADmL7nx43T4dor++uifO0eRVdcVX1Xd8MVwUr/bFgeC2dFnw4CL5M0mlxD5ysLi+SXl2L9or
 a9XePxyMTlhIknIWwYxIVRkwGqL6sVafXkFji73WU16dv5OcTKrPeUAAOiF5GBLc48hEHMXW56J
 H+hxyr7tyHQ7pvQ0azmTcQXKXX94cxSmslXuBYOnr7+NKg7IBR3wEs3ARggzzIvJeKJ8l5NLDPR
 olSNh5ppJJBcjb8pCQozqb5MQbxGBxmMWTIL1kbvidj7tNHhcEKFLysTpUH5xH+JVxblDTSLuSX
 PReliHonxyhEWlfU+g+onNehsmwSc07UPmxayX90M=
X-Received: by 2002:a17:90a:c09:b0:39e:2036:8243 with SMTP id
 98e67ed59e1d1-39e20368cf3mr9957832a91.25.1789664532152; 
 Thu, 17 Sep 2026 10:02:12 -0700 (PDT)
X-Received: by 2002:a17:90a:c09:b0:39e:2036:8243 with SMTP id
 98e67ed59e1d1-39e20368cf3mr9957772a91.25.1789664531562; 
 Thu, 17 Sep 2026 10:02:11 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14397197dc8sm14114727c88.3.2026.09.17.10.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:02:11 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 22:32:06 +0530
Subject: [PATCH v2] fastboot: block: add 'oem set-block-target' command and
 runtime override
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-series2-fastboot-block-target-v2-1-2371f8b15de5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAA0drGoC/4WOQQ6CMBBFr0K6dggdiRZX3sOwaEsLVaTaKURDu
 LsFDuBmkpe8vD8zIxOcIXbJZhbM5Mj5IQEeMqY7ObQGXJOYYYGnQmAJu49gJUXlfQTVe/2AKEN
 rImhhqpILJVVjWWq8grHus/Vv9c40qrvRcY2uRuco+vDdHpj46u1bFT//2Zo4cLBaHFEojQ3Hq
 yfK36PstX8+83RYvSzLD0R9nRLjAAAA
X-Change-ID: 20260824-series2-fastboot-block-target-c8e9418babdf
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789664527; l=11981;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=qD2vbZo+yZhVia9hk6XpHEtufZf9QieHX2/4R0sMGns=;
 b=+BzO0Mto0FCJpQJ0Gn5om7iZMOBma6hqoNL2QeQv2mUrZmaC3gQjoUKmH5xGiRmpXqoDXZ0qu
 ZuipUR0Bi8fBI9l3Il8gFPN2/PLZfmOJzE9b29BGvZBbrpuORJdxzVg
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfX9aGKGoZA7S62
 5yL0HGUUK5izhvaElY3RWxadDG+Iy+YxYO5YmpAvGvu93zlLAbJXml/S8hjbOJlyrHH/s5vtOKs
 pBT4JR2xUoYVvszSM/mHVmPx1Vn6K2DfGXyVl5IEP+kvtR67/+M47vdeW609PldyFsbQOt6m4Ji
 u/MPMQRPk4RM+zSG5+za/7VqQDHPKS1JkRjRQdL/AT+SD/GAT8KK9aN9QLFcfs2sVSVmI/EdMeF
 JYLrbPYJXHEtUFESRl51KnhZVxOiClEEOlaYa6AWIDbaRX+q4XMQZYeIzABW+KP1bQC7dnRPYJ7
 5PhXVb7qWI/je0GfAmENjEbtNFRJOuvmZfpHADc65p/Nj98VKfXqVYbExuLSds+ONPKZQleKEJc
 xySdKj+dvYEnAXe9KK7IC6V/PH3re91u71b+jyE87RRID6rjVe4Buj+Yo17BnmmLHNRf2CoA6j8
 RkrYplc6LvELuEPt63w==
X-Proofpoint-GUID: FFGLXkN5xFqgrIRE1rAeLADxaI_l9F6z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfX2AvKPVorpAYK
 RsxLV4wARiUR9KFORD7EeeJtW2zfCLkaNXDcHnzeS/3m1dG0csL9b38x56ikyupuS/ibW+8AjlX
 ud8hV7wW9x+5vjLY4jh3W1K7cwkXAdA=
X-Proofpoint-ORIG-GUID: FFGLXkN5xFqgrIRE1rAeLADxaI_l9F6z
X-Authority-Analysis: v=2.4 cv=cvwOAF4i c=1 sm=1 tr=0 ts=6aac1d15 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-Yep7ivrQWAXgz-edyQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170242
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

Add fastboot_block_set_target() so an OEM command can point the
generic block fastboot backend at a different interface/device at
runtime, without requiring a rebuild. Falls back to the existing
build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults when no override is
set.

Expose this to fastboot clients via a new "oem set-block-target
<interface> [device]" command, gated behind
CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET (depends on
CONFIG_FASTBOOT_FLASH_BLOCK).

This is needed on boards where one interface (e.g. scsi) is the
default block target but another (e.g. mtd) is also present, so
fastboot can dynamically switch between the two interfaces at
runtime instead of being locked to a single build-time default.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
This series lets a fastboot client redirect the generic block
fastboot backend (CONFIG_FASTBOOT_FLASH_BLOCK) to a different
interface/device at runtime, instead of being fixed to the
build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults.

This is useful on boards where one interface (e.g. scsi) is the
default block target but another (e.g. mtd) is also present, so
fastboot can dynamically switch between the two interfaces at
runtime instead of being locked to a single build-time default.

The patch adds fastboot_block_set_target() to the generic block
backend, plus a new "oem set-block-target <interface> [device]"
fastboot command (gated behind
CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET, which depends on
CONFIG_FASTBOOT_FLASH_BLOCK) that lets a client invoke it.
---
Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot support for Lemans-EVK
Link: https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/
Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device selection
Link: https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
---
Changes in v2:
  - Drop the redundant IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)
    guards from fb_block_interface() and fb_block_device().
  - Retain config_opt_enabled() to keep fb_block.c compile-safe
    when built for CONFIG_FASTBOOT_FLASH_MMC without
    CONFIG_FASTBOOT_FLASH_BLOCK.
  - Use simple_strtol() instead of simple_strtoul() when parsing
    the device ID.
  - Reject malformed and negative device IDs.
  - Generalize the commit message rationale to a scsi/mtd
    dynamic-switching example instead of calling out SPI-NOR
    specifically.
  - Link to v1:
https://lore.kernel.org/all/20260824-series2-fastboot-block-target-v1-1-c8e9418babdf@oss.qualcomm.com/
---
 drivers/fastboot/Kconfig      | 11 +++++++
 drivers/fastboot/fb_block.c   | 69 ++++++++++++++++++++++++++++++++++++-------
 drivers/fastboot/fb_command.c | 59 ++++++++++++++++++++++++++++++++++++
 include/fastboot.h            |  1 +
 include/fb_block.h            |  9 ++++++
 5 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index a4539844d89..c7e0509eaad 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -225,6 +225,17 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
 	  Device identifiers are numbered starting from 0 and the most
 	  common case is to use the first controller on the system.
 
+config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
+	bool "Enable the 'oem set-block-target' command"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  Add support for the "oem set-block-target" command from a client.
+	  This allows switching the block interface (e.g. scsi, mtd) and
+	  device number used by the fastboot "flash"/"erase" commands at
+	  runtime, instead of relying solely on the
+	  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
+	  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time defaults.
+
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
 	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index a8c74e35d0d..e6f998dd2db 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -125,6 +125,60 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
 	return blkcnt;
 }
 
+/**
+ * block_interface_override - runtime-set block interface name, empty if unset
+ */
+static char block_interface_override[16];
+/**
+ * block_device_override - runtime-set block device number, -1 if unset
+ */
+static int block_device_override = -1;
+
+/**
+ * fb_block_interface() - Resolve the block interface name to use
+ *
+ * Returns the runtime override set via fastboot_block_set_target() if one
+ * is active, otherwise falls back to the build-time config default.
+ */
+static const char *fb_block_interface(void)
+{
+	if (block_interface_override[0])
+		return block_interface_override;
+
+	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
+}
+
+/**
+ * fb_block_device() - Resolve the block device number to use
+ *
+ * Returns the runtime override set via fastboot_block_set_target() if one
+ * is active, otherwise falls back to the build-time config default.
+ */
+static int fb_block_device(void)
+{
+	if (block_device_override >= 0)
+		return block_device_override;
+
+	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+}
+
+int fastboot_block_set_target(const char *interface, int device)
+{
+	if (interface) {
+		if (strlen(interface) >= sizeof(block_interface_override))
+			return -EINVAL;
+		strlcpy(block_interface_override, interface,
+			sizeof(block_interface_override));
+	}
+
+	if (device >= 0)
+		block_device_override = device;
+
+	return 0;
+}
+
 /**
  * parse_device_partition() - Parse and validate device:partition format
  * @part_name: Input string in format "N:partition" or "partition"
@@ -140,8 +194,7 @@ static int parse_device_partition(const char *part_name, int *device,
 {
 	const char *colon_pos;
 
-	*device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-				     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	*device = fb_block_device();
 
 	/* Check for colon in partition name */
 	colon_pos = strchr(part_name, ':');
@@ -190,9 +243,7 @@ int fastboot_block_get_part_info(const char *part_name,
 				 char *response)
 {
 	int ret;
-	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-						   NULL);
+	const char *interface = fb_block_interface();
 	int device;
 	const char *partition_name;
 
@@ -385,9 +436,7 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
 	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
 		int device;
-		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-							   NULL);
+		const char *interface = fb_block_interface();
 
 		parse_device_partition(part_name, &device, NULL);
 		fastboot_flash_gpt_partition_table(interface, device,
@@ -399,9 +448,7 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
 	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
 		int device;
-		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-							   NULL);
+		const char *interface = fb_block_interface();
 
 		parse_device_partition(part_name, &device, NULL);
 		fastboot_flash_mbr_partition_table(interface, device,
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..a015669c43a 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -45,6 +45,7 @@ static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
 static void oem_console(char *, char *);
 static void oem_board(char *, char *);
+static void oem_set_block_target(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -120,6 +121,11 @@ static const struct {
 		.command = "oem board",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
 	},
+	[FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET] = {
+		.command = "oem set-block-target",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
+					      (oem_set_block_target), (NULL))
+	},
 	[FASTBOOT_COMMAND_UCMD] = {
 		.command = "UCmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
@@ -589,3 +595,56 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+/**
+ * oem_set_block_target() - Execute the OEM set-block-target command
+ *
+ * @cmd_parameter: Pointer to "<interface> [device]" command parameter
+ * @response: Pointer to fastboot response buffer
+ *
+ * Switches the block interface (e.g. "scsi", "mtd") and, optionally,
+ * device number used by the fastboot block backend at runtime.
+ */
+static void __maybe_unused oem_set_block_target(char *cmd_parameter, char *response)
+{
+	char interface[16] = { 0 };
+	int device = -1;
+	char *space;
+
+	if (!cmd_parameter) {
+		fastboot_fail("Expected command parameter", response);
+		return;
+	}
+
+	space = strchr(cmd_parameter, ' ');
+	if (space) {
+		size_t len = space - cmd_parameter;
+		char *endp;
+		long val;
+
+		if (len >= sizeof(interface)) {
+			fastboot_fail("interface name too long", response);
+			return;
+		}
+		memcpy(interface, cmd_parameter, len);
+		interface[len] = '\0';
+
+		val = simple_strtol(space + 1, &endp, 10);
+		if (*endp != '\0' || endp == space + 1 || val < 0) {
+			fastboot_fail("invalid device id", response);
+			return;
+		}
+		device = val;
+	} else {
+		if (strlen(cmd_parameter) >= sizeof(interface)) {
+			fastboot_fail("interface name too long", response);
+			return;
+		}
+		strlcpy(interface, cmd_parameter, sizeof(interface));
+	}
+
+	if (fastboot_block_set_target(interface, device))
+		fastboot_fail("invalid interface name", response);
+	else
+		fastboot_okay(NULL, response);
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..13dcdf919bc 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -51,6 +51,7 @@ enum {
 	FASTBOOT_COMMAND_OEM_RUN,
 	FASTBOOT_COMMAND_OEM_CONSOLE,
 	FASTBOOT_COMMAND_OEM_BOARD,
+	FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT
diff --git a/include/fb_block.h b/include/fb_block.h
index 189c708e2f0..fd981d95316 100644
--- a/include/fb_block.h
+++ b/include/fb_block.h
@@ -102,4 +102,13 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
 void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 				u32 download_bytes, char *response);
 
+/**
+ * fastboot_block_set_target() - Override block interface/device at runtime
+ *
+ * @interface: New interface name (e.g. "scsi", "mtd"), or NULL to leave unchanged
+ * @device: New device number, or -1 to leave unchanged
+ * Return: 0 on success, -EINVAL if interface name too long
+ */
+int fastboot_block_set_target(const char *interface, int device);
+
 #endif // _FB_BLOCK_H_

---
base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
change-id: 20260824-series2-fastboot-block-target-c8e9418babdf

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

