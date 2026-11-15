Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3B606A32E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TVbb7EI/;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CORDx/KG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B4dO8qba
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BFEC6072E;
	Sun, 15 Nov 2026 06:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jamSZT2K2Ylw; Sun, 15 Nov 2026 06:26:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82CA5606EC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794724008;
	b=jaPMvoCpdhpbYmavc4UxbRiPzk66YnNLEc/sdpa88OyrVa6Dp3hDYD+qfDpjbb1wnC4u
	 VDIHHRvAem0tBXDRcg6q/ZtP4byQRFiEjbIcMhozHc0RA8IGWDW55fGWp+Xag3QIHxnzs
	 TBg/lD+HESi7+9NbJlbdkAN8uTreLyEoNbtqTSBu5UxRkS6bQRXFXoibiyD8PF1CLf6Ao
	 3zNzCgr7H6AtP6+ETpkNuYvNVdaYFsvDEtjx45ro2rWjbIV15s52DAKzqddfoEQpqyLEB
	 88gMGwZClQdpLuH5jMW3V9IP+Q2Fh2NO0qAoUIMuN1/Cq5Ih6YuaUQ4dz0HY/uf0aEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794724008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wjRL0Q8zxD1fhxe8/M6IoyAmByYHL0AnL1+rhUzP85Q=;
	b=fbNNZWaCrcnmmxB2Ur0xVd1OeW0Em4WCqCg1hWz98u5zOnVPxmkNfqVvCiTiCH3pbi8L
	 /4qVXUwCnkX+v13mDJqFlXrVXu8aTCb57i5v39U6dYWafiwfuAT40VUTTg1Ui9r1bA6jh
	 VNjzTt7nGIf2uyk2YRighAz4RyqdfVvEBON702711ytYWW0Df1L9r6kuNMcKaXTzhI7Va
	 0lMA40ySj32uIA4RXuPa5fULjVzYJtn8R9qkcpM3w279aXlyixNkRktrGAA5aHsd0U91a
	 Q9sH8HmyOKM4YvgxkXiFPiw9cPduoi+dZdHqtGPbvDQMhv2NP97IGbng0wj1C5Ahjsg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794724008;
	bh=wjRL0Q8zxD1fhxe8/M6IoyAmByYHL0AnL1+rhUzP85Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVbb7EI/qgw3vuaiM7SJAhQEGEBS+OaI5XGE3WUPfP9RbI5YsHaqVMiXU2iJMn4wd
	 5ZrA5BqZrRIckc7GKyjOw8ts4zVJtTlpP8Vmm1m7f+ws2wACgSnZAsfY+T6cse5E9k
	 n3U53RTR7gT6xupBtgehq3NdYr3vjbDCFtW0O+Dr8cu0GnjksKA3VdHQbMqAYUB45G
	 vGHJHfRcZRouRYFgG8rPzf2ReRdn9aCk3DtKcCi5WxbHl7ALVUJ073M7DEg/WCoGXF
	 UZI/CjqXw6EtMDTLClEvfsfqx5XTtOvDXNX1IQ6S37Vdmn/5sJsxQrO7kydWtnTlAX
	 b9g5CbUIv+CYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82CA5606EC;
	Sun, 15 Nov 2026 06:26:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0275B2E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E916F81099
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KkL-JE55jFSU for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:26:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D7E981096
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=CORDx/KG; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B4dO8qba
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D7E981096
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4S4FK4006684
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wjRL0Q8zxD1fhxe8/M6IoyAmByYHL0AnL1+rhUzP85Q=; b=CORDx/KGx8589hmo
 cLVxYUgJfSTWTwEReRztEBnooOudwP1aEi2jKOfUVtbwJF2xWg4hj5cdUCI7NCm9
 S0soDMO/LCbl7PquP/hY04qPdKZvBjYqtMkaeqiCL0AloU9bMDTb9neAcG0YmzWg
 aIJABaOsX3hla/Ck26o+RjJXtD/ASBu7NJi/hf3tbbGTzbW5llzIDOTkjTK1H0Br
 BrCC0NEGxe5zGnEXF70WDyUXD5PYf53igOlz4oYrXySK59IBhKrVBTjiRex80qYy
 w+5GSKoXgp3g/0nUzjc6zrs8kgw2Y2zUK5Iy9MPcHgVOpmjhUOYbnCXaezy6ae+F
 SOFVrg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj42f72-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a3451ea93so2472957eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794724004; x=1795328804;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wjRL0Q8zxD1fhxe8/M6IoyAmByYHL0AnL1+rhUzP85Q=;
 b=B4dO8qbaCXpMZkK826wa5xhogensx60gxG+b5aMw83GZnxV6vb/QrtB9LiXqY8bdaX
 AhL7/cH/8ThJax1L+RjbZF0beb7n6O/6A8CSeoVCWckRXt/vd19wmPRDF33aVC+UJW6Q
 VoRXedl54qAB6+YfWvc/hLg+efYtiqYpeIT5mVwaGvThxZ/S14B5vRHNb/k1idIhPpfY
 fxdtB7T3L4b2FwquQ9+OozIVpGfE0c2S4DhSUxt6yVUU/dWG8QeriuDFAtUwWC4PjP4s
 dQZCh7z37/BzY+tA/9Fw1UrgPu2quwxu0byS3GJKEiKmbWBNKVC1Vc8sO1Idq15FfwCs
 TXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794724004; x=1795328804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wjRL0Q8zxD1fhxe8/M6IoyAmByYHL0AnL1+rhUzP85Q=;
 b=UI9JF9tEedUwJ68wUK9khjM5vKADSS6ds6j2n3Jb//xdVRj6S07Fa3n/8sFX535C+9
 nS+Gt+X84i0RksLSdgyryEw28hxHCzgPwaR4lDdVGq3kBaZVSXaUoIoIN4OgtDTvD3dY
 uZXpvc/s6QoXjO/8t2OE6tmJELSBwrGfXBEBV1T6SPNLo+pU9nHEKR6vddcEQUM++2OD
 5a3BPYJMTwy5T8MhsV7JOYRvZvs3R5yTl7btwKhUqtUhoLWmSB8P17B2H0rIKvth1omb
 nYq4L/R9fRV1X5MoF9mayh1glYpaec0RfqwiqKmQFC2AWPBl7TDL6gUZPth7dVF/l3WZ
 WapQ==
X-Gm-Message-State: APuU4Z8juTIqsIXHYkXmuMZE6nDH2cwNJKM1FJevwjgXqieRASm/3paR
 X98ZTOIVgk8Akkh25jJF2CCjU+Tod3S6BCT8L0QWAVbbFGwFRJFErMN1ZkQf2xi/fikUMux7/uy
 bt1MP51RS5CYioSXXy6/QRiikukBtlNF0u1dKhjr8h1hEn+L48yxhATZAcCZlm8+8Gh9HbjU=
X-Gm-Gg: AYBFou3Zu02xTPte4JgHBHKrOzCxvIOF13AhYqSo5j6UkDvRmGfdIyitPJGZ5GVzpvy
 YORyUWMrZrrCwaRRblrl6R+Hz2M43YBJbjfW54393ULU32apijw+oHqw9g2yOStykzSD217cEte
 Vd9IyEkGfxVF61bN+8qMpa3URJLpn2DzqtPHyA5PWhx2UAp8ooYXG8Uhwqo0NizTM4OUceNGJqD
 KI7a0k9Zm0u0fRk5ADsU/VQlVgfyoAcjNO4KLahZ3tjG0ZE3BQ9Y+oTc+D/vPsfbWmuBqEz8jJA
 bV5N2vrNV9j2uY0op0/lVpI0iybKtwTofP4oeFO8TlZWPlunMv/YJgvEAPIGr7Olpeom8oxZZrI
 yaK41H+UBgBTdb60jXOQafg9AQvNw+aoSOtx+xCIF2hxynR4fmEIrKVkyNcLFduhWYAZTvdfitg
 UTOzuM5pYPaFWKo6OgdDMhL0PeoX3Ed/2ZwHvM9oFh/nHkKS5OJ70eANVX99RYvVIFz0zhRCSuC
 wpv
X-Received: by 2002:a05:7022:3a06:b0:18d:9eec:e0be with SMTP id
 a92af1059eb24-1b5030681cemr7719713c88.2.1794724003695; 
 Sat, 14 Nov 2026 22:26:43 -0800 (PST)
X-Received: by 2002:a05:7022:3a06:b0:18d:9eec:e0be with SMTP id
 a92af1059eb24-1b5030681cemr7719699c88.2.1794724003207; 
 Sat, 14 Nov 2026 22:26:43 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:26:42 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:06 +0530
Subject: [PATCH v5 4/8] env: scsi: Fix ENV_SCSI_HW_PARTITION default value type
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-4-79e76209457b@oss.qualcomm.com>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
In-Reply-To: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Denis Mukhin <dmukhin@ford.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=808;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=FcXLJdoCuD55AW+j1hRnrBLOhR0PRkm4UnQAch9tprw=;
 b=sOpMSrRiX59hy8FYSMCjnZHFVItp1O/sZ8MM35pubFhcTyABjWaFFwLpI1x9QhjPdowqKTPok
 KklpNYr1gq3ARAVWtCI234nEk3e3UU7jIIe8h1hKSL6/XN0nCJtJNUS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX9p0TzHSxymyP
 13ZqIIeKP7mlT3RFRrBAj4evuMYqNvZgT5+cKAdrtCNSPjwWPtbiSvZJda/20uenE2wx532N4uM
 rHHvE/DJmNne/ofSQOzQw2kKkiW8WhMN6t4U8xKtm6eAGm8wULOaY+j+1rAHt1RU10wKlFTx3aT
 1UsZxIzwvyDd7mI7mzhIDig88cfacqfoB4L8O5173AUd4i8H2TbTfQEPhItP1DRqvr7bPuDW1un
 d9iU7DlTYWAaw0ghpf0kqJLpHOgY18kG6sCYUfNB4ouQxKInC4W7pTbsehHmV+/3oazME2GVOS4
 fo2vBvRf/yHHoBSIvuq1/FuPJWVw8Vrrg6237QIURkZWlqZ0HrVU6x89CZu5U/LW9aPyvWQnZ+E
 WIyNBXWHujYTjM8wDizALisppsGpg4TKyOxt0sn9WnRty50WH1bnaao5H53JEmxNldXclDCpWrY
 0jdcUxpAO0lkIvNFOkg==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af950a4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=OGJVZsyYvEKXudgABJkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: P2yCz8eZzx3FKZmMy-s7X5PbjsBqFd3D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX4p27GsPbwegV
 Ds4rfHdo5rLsgGaTeZI1ht4Ykh5fkjECksojST5g3jyGxV0rQrNVhtblGkx5Xv2IO7ul/JiFa07
 S2CQ1C9fMOEthI3XSPoeK1ZBXg8D8BA=
X-Proofpoint-ORIG-GUID: P2yCz8eZzx3FKZmMy-s7X5PbjsBqFd3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150025
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

Change the default value from integer 0 to string "0" to match
the string type of the configuration option.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Newly created in v4
---
 env/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index 394e91833a3..5df86028907 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -826,7 +826,7 @@ config ENV_MMC_USE_DT
 config ENV_SCSI_HW_PARTITION
 	string "SCSI hardware partition number"
 	depends on ENV_IS_IN_SCSI
-	default 0
+	default "0"
 	help
 	  SCSI hardware partition device number on the platform where the
 	  environment is stored.  Note that this is not related to any software

-- 
2.34.1

