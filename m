Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4DCC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 564B860837;
	Thu, 17 Sep 2026 07:47:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id shJdGLQhTIhs; Thu, 17 Sep 2026 07:47:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 780946075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631259;
	b=HQ5VMvgBs+TEUlh7J8scUv3TeN32NiQjq+M/ddHm8dAwXFsBkA/BEFpuBDytHW2ctA7D
	 aNiaqDS4j+K1WiINFA+IllCcQiAhXb/glLdF6L6BKxRBJtOj7U0l3sZJdJmz+LvMc45Mi
	 OaQACgHGyxoTb5x1idR2WyKaHR1GkPcBSgb7fvmnZJHxFVCeXJ/dn5Ie41C5Wp1fXKwLh
	 XznBSKqqcvYY/c/DEgCzWQ9BptSdl/Hfm3ClBpXns7Rv0r9MXy7OjuYkt4ownE71GuxkI
	 aCnEL0bg5lZKZNFG+r4R6qNLo2ftya+rqaN+R02NyWUH9D3iyQZAw0jhNNaaZ2lDbHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
	b=GY20HPBwcoQCCS98F8uiBGgNPOPeAxy4NrLrw4y2MNx4fOF+zGdqkl2pSdd4DZD3R3S8
	 Ybx0B996obOw21SVAoyxj/tsERD7Zz6SHC7NTvo/tIJbBzdXVELdA6nMzCCLMWAtPsEGT
	 c9r6A2x99+AG0Vi/ElLgnUgC6RhBc0PsiMuq/qok68pp7gDqkjiiElATDxi7gy1iDVHk+
	 uhvr4jsZ9a5eCg0yV/p9ByZNwskxCUERTjb+igdZwtG/wWejcdHWIJL6mLq4X4i/7BwsT
	 qEdmx0guchpoQ7FFsj5r6Y5ZNz9E2nGh8aNxr9yU+2c+GFBVrwvf+q7DeKb9s5E+Ylg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631259;
	bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AwdX/5RG9afhXo1QyPHUQeDApDNbWmewWblc3/34/E6fUSinvjtfeUkYY3cJwqt4V
	 eCewa6Ht6/+cxd5vD7uKgUdRU452lJnz422J5AG4RnxwrZvrEWnYMmAyrwlZO9wgjO
	 lqyvbDrRxC0zeF2RlExSJMtx/cfmXzjnfoAUSnUVhljcrGAkRsZsoBA4YP0hWk4z7j
	 /uja5uYSNuyZ2lVfxBHt65cmsqkmcJQr5DVGB+HgFVogTOvEyhNFr/GU7+d03Ys0O0
	 A1HSJScWXS7ZYcasPxw3rV6E+9IQJwb2+FDs94Hw/WgwltijRKsC7xKwr2Ix3BSc3g
	 Lmm5mf9uvTzrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 780946075A;
	Thu, 17 Sep 2026 07:47:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 152B624D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07600404E9
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mw5bhWyJC7Hk for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:47:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48C86406A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631257;
 b=NdALxhuDOsL0mIrqV5RyuDBjj6tpUXr7knfT2BlT074qbWb3xbqNbZVW24VDjh3imsbm
 yhtv+0Gnv5iC+TyRFr+XvKIRirE5Y4FWRSjNtEv+4IVcAPbmn/j3f6kKenx8woEruwFQJ
 a6PerwQZvc2PJUOWOPEM3avgYZgfwdmPXSfxhwHpdPk7IsLv2V2plLaCMygDLmn9ImZnW
 fxDbm5ylvftzqdi8PG7S57OQVDfheKoG2lXv9+cmbevdsHDxeaG3unDKyJFqXQRZIac+s
 4La8VIn5waCBeA709kLmMdGVOyypm+beZjuJoh/gBBz5bJkMnmDwHeiuLQgzQYcDEzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631257;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=CviAPVeUZg+agIUl1FoU7rIJWEsasRsil6uUj1fKZ7HdU6duujOpLWtRWEJFVlkl7E2y
 JGteCNkD/7gnJPyLlGk5sOyG/P0y4phoV3JvEL7N6BLk23uBzKUvVoRljpW4aGfgjD/3r
 kZCoOYANWjeliMoVSmVaOgq+c3jtnmCVPjPAxVHSTA3yUoLIcDmlIXUXl3Ep1E9dssBSP
 zQBBIV7x188dbvdp/RQAlYUtHc0rZQ6dMnPqOzTUuppvRirLoSI8ch1hiPxBx62GxxVjN
 a5g9nI3h1/UEY2OGQ+ij9vrX3yexWTNCVc+Q7xYy51xg7ic66hi155TVqz6VADFIGow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Q+Pby3/t"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d09ectXJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q+Pby3/t; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d09ectXJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48C86406A0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60Bwq091826
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=; b=Q+Pby3/t2GK39nKG
 PI1vVOvvOZUjE7/SPLI/YnBAm3l1OOTEhxShkfIsgF1YtQmyR6ZDM4TixKGBahDX
 0FQThT+zo1NcVOZn8UBuKiDfnjA0zRsYHbjbeQkHz2SDCLGn6ER5JpuZXX1wpt+s
 F4H8wtGOoP6X1G3PtcmIV1AxFAQl4SueUOUfIeZWjAeIeEV+S1VSPfbeDlcyfzFM
 zIT0hD5cjpRTjJWWG5aODbl0RrrTOmMYNR+2CSiCugaMkLK4li1kG1O+01/nYl8I
 nWePZ22QiLKuF1xrt3xiBWJaJ/valhBiB0oXrHoNQqtF4xrIkb9yhizeXVorG+tJ
 3qJ6Hg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw0spg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d6fed0652bso8332775ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631256; x=1790236056;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=d09ectXJCKvAKZ6FT9aAt4QC13PVmZmo9wliGipmDvKWUBXONI9FODOjxcQZWCFkp9
 8f/XjiQ2DVmKrer3w7P/TANbasXGqjDnSvUqheicWRZY/v+WsrITJ5FCvKV2pJEhLqaQ
 OnbWrK1c3rjAG9/lRYG6RN81rKxHPtn5A8cXVa8IygWZjIh+Y8KuuIXcXq7+4tI8yiLB
 LKdHZB+rfpM9ZtQSafIhKJT+5BL3Ytnew4bHLx6QH/btlFqwislgo4z7TpKg8fxgMUsp
 uqhCKh+hFGw+DQe3Lgaq3iOFF56CUzVs1LYvchjWsmGNz81/G6rYRU0YPw7fcJ6sMH9i
 1ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631256; x=1790236056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P04PlNazN62bSWH36OmY4Rz38s1ANgkW4tRxn1kgL3Y=;
 b=prLc+qzr4Kmfz0ri+kUHoxqKSRkNOje/iF486lxY12fdwZw40ncGSYHG3rZKAhkm1e
 3GWmZ4Cx2dtl3GpdJUqtHzrX2zBQ+dktA4IZWNXGmuddIqKbjjpDXS5IUPSemx5Dnhaj
 6fG1mHZut6pEqoFdKmpxRL7cxnK/vIyCECHo1ONFnfvUGEy+OfzMOQJl3weM0GrkeKe1
 YQdhGiE5bx4vEMImfR68U0yGsVdmPwKfkRrhtVljYVRj9la1a44oLf33HvGAmQzQzpVA
 t7Vz8fOSNrVUP+bIThOjMxgdb1WXoSY/rAkNVYEhfp2dLDGhK+kCMgSTQC7zTTQ91DUa
 7rvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwatP968gj02gbZDp7HNvchANpHEQiqatwClCzcc4ehklWciRTgy+FT8ZgUC2d2mw9kuBN+8K0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lg9uplc7LdQYfISbTO39zYVscC+A4x5gcCUnENLq3BbWQ59/5W
 MCVJwJeJJWSNd5znVxklbu3Zqj/RNEm9U/zsX8FttIqTqfZij19S4VAh3X3aBD4My4c2S3THCOO
 Dt5QFtMoHp13wexLeWOmFlVX45iECCq+uUkIDuWnfVwNlp3OrCkndD6Bzw9/8SNiIjQ2XBxo=
X-Gm-Gg: AYBFou3+QSsBN4uIwjo3XzINMPT42JxnMi+cVDtyg5XXBcjhiJD5GLEKZxx/CohEhny
 EtWuXKWOpA+4MX63W1wl1PWBICGE2RAefPrbBoKFMWStJdzcSEVUoeuHITNqCGiynmc8oNcxkGk
 3ABBZB2o/bh/pX1TY4/uPMYi61uqvH06uJ9xqo5o8weNj40odOO8x0QUqSEbdcCEMs1P9K59iXl
 m03nKdOvfdZIhLqzguTXsS3fFEj0t7txopBlrbdjn9deWLb9/AWJuBOsgzwIMWs71J3dskS/1Ty
 5qLYf6z1kMz9Ec1OKmC6imf9RjaTKssERtIXy6mOVg8CldKuFnqcJ2HGnXPVfY5LhxWlJ/hV98C
 G/n1LtrTLuB2aaZPQMfmkA3Be5LeSeMouzmhohgoopexzsFbchEyjKvBvhnPyevyygf+zYhW/HF
 XHl3/6r7MItKDGywW97tOyVGyr6cxIKw==
X-Received: by 2002:a17:902:f64b:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2dd8dd0b0b9mr129382675ad.2.1789631255889; 
 Thu, 17 Sep 2026 00:47:35 -0700 (PDT)
X-Received: by 2002:a17:902:f64b:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2dd8dd0b0b9mr129381725ad.2.1789631255253; 
 Thu, 17 Sep 2026 00:47:35 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:47:34 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:40 +0530
Subject: [PATCH v10 11/15] clk/qcom: add clock driver for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-11-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: mcUIpTQ8rG21Y2qvlbrnubTfETpGFEG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX9RhsVYjKahl5
 mpX0MPCsPz00Fei2P1MGGDvaqEkOXLjk72sUlOoeEcOii/jcE8sl3soBFZGG/h3Eknsj8PyziwD
 UNOZkq6C3lbpMRrhmoa+hu49mReZfAXoZtB4nf8sIZSd8Vp7pb6b7/8oRFX4BJljphqR4/+lO2/
 fEXDzIMQqVx5SPZZuuxnAl1+sNfE7S4se1M3nAbsoSdPBSReLJaY2Jl3e+hd/rlPlq3Hrbv+N+p
 kWOgOjZRMoRKBKuBl/DjGzlOrRNIB8W65bwLYNtU4JqDYH93tdTooPJcYj8zriIsCWmb4tjs1wk
 AJuVx7xCpoyWFw4CgURrtBX/tKUgnAQn8uC4x62JgSV5NcnD6ulCaD4Bo4QGxnhcSfq8GSQU0qi
 cSmm20rI2qVrCRkapzdssD6T8wkZiR+tazrcTiWkqI3PdXv05qBTmY5OhdqrMyPuIaLpl2U+gAP
 hr8aFtHnQk5wHS25K4A==
X-Proofpoint-GUID: mcUIpTQ8rG21Y2qvlbrnubTfETpGFEG3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX6kZ0ZBWIDWCX
 cBEE2RxAySU1EmhQrIsCOinODV9dAzSvMieFOXwryPLL1/9FsH+6T5J2vkbGAjL9iqstTkaSdtw
 zTF7trLFJmQmNxqvoJ5hUqNLoD1irs0=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aab9b18 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=ttnG5VEth79ohM5wMFYA:9
 a=kETcTEvuJSViBEbj:21 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

Add clocks and resets for enabling U-Boot on ipq5210 based RDP platforms.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 ++++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq5210.c | 93 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a3..a142890acdd 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
 	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ5210 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b11..8934635fb48 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
diff --git a/drivers/clk/qcom/clock-ipq5210.c b/drivers/clk/qcom/clock-ipq5210.c
new file mode 100644
index 00000000000..cd82b238bea
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq5210.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm IPQ5210
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/reset/qcom,ipq5210-gcc.h>
+#include "clock-qcom.h"
+
+static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 2, 217, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	case GCC_SDCC1_AHB_CLK:
+		break;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     0, 6, 25, CFG_CLK_SRC_GPLL0, 16);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rate;
+}
+
+static const struct gate_clk ipq5210_clks[] = {
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE1_CLK,	0x05020, BIT(0),	0x05004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,	0x3303c, BIT(0),	0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,	0x3302c, BIT(0),	0x33004),
+};
+
+static int ipq5210_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks <= clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return -ENOENT;
+	}
+
+	debug("%s: clk %s\n", __func__, ipq5210_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map ipq5210_gcc_resets[] = {
+	[GCC_SDCC_BCR]			= {0x33000, 0},
+	[GCC_USB0_PHY_BCR]		= {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR]		= {0x2c070, 0},
+	[GCC_QUSB2_0_PHY_BCR]		= {0x2c068, 0},
+	[GCC_USB_BCR]			= {0x2c000, 0},
+};
+
+static struct msm_clk_data ipq5210_gcc_data = {
+	.resets = ipq5210_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq5210_gcc_resets),
+	.clks = ipq5210_clks,
+	.num_clks = ARRAY_SIZE(ipq5210_clks),
+	.enable = ipq5210_enable,
+	.set_rate = ipq5210_set_rate,
+};
+
+static const struct udevice_id gcc_ipq5210_of_match[] = {
+	{
+		.compatible = "qcom,ipq5210-gcc",
+		.data = (ulong)&ipq5210_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq5210) = {
+	.name		= "gcc_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq5210_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

