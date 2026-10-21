Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371A606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IBiwVKTH;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XvNMXAx1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N+2SvmgQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AF0D4090E;
	Wed, 21 Oct 2026 16:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPeeLADP1LYl; Wed, 21 Oct 2026 16:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5D17408DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598999;
	b=bfuVV5JE7hIOpJwk1ZkBy1vf8S/XkD/u/aNJKrpJ0y7H6J7TfgnV657mN/tb+IbJCAl/
	 9K+2Xj0/8kye9J9gDOcMnQZkR8Xhm21rE8c8PVgEWoXVpbZ6nxX1fxkdZvCn50hmgfVny
	 YV5oORNoE1dv55n+roAEmuRE/DWmTgJPgyVApv8+ZQKY4/XfcUvpz546rWJawIJaFcM0F
	 YCec0FEwxiBUMXMqurlUOsLag42uxEFXHu0VdxNVh6Pj/zv2c622pR1ZB+yY1n0j3ysYx
	 2E5Z0oVCpH01N2N/zSps5NSVCwt2OdueEHfN5YiKp8VtgjVRMI2Mjuyp/ejUXtDuw9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
	b=GGT2fTtiroud6DTomeQiAGQIWTpcZDsgQHLf+/wvk3Bm+J4TdV6hDtQUbrC3uDxJ58ht
	 +ScKReVb8X7txqffsIsToXFojnJU17dxtoHYc3vqeETKlTxMVvwNJH190cbIqqWUrKp9Y
	 hmvKcxB53QLWhc1/OI9jBCsaacMJsy1ahTnDpxK5Mxefb4yAhC+e3DpxAZR/leN/IR79s
	 zSDcubc4KzweHZxpa/IL2yNJUVv2qbyPUQ8Rv6aIBJStSVY06LgqECxU6wk5A0iSr+XjW
	 RjH1NRwRP51Ht+oB7JLImd74mJuGRU2OBV9QGPfyIkASv+S4gomHHqNk1/jo8RtwsiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XvNMXAx1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N+2SvmgQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598999;
	bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBiwVKTH8P4+uoWZ3k7xoVbJ9nUESwa3H+e48l2XlXh5JjQjv/hnVN9I3Q52Osc7A
	 lnG4EMlVARzL0gIg2PsSLtoGmIGxVK6HBuD+t7Kkxct0pp1ueDYyIvGtU7hV0TKUoi
	 76nGXGZioabM3EtAefI/iZR7qqsXTtf4Q4cgm7mhttI7X+fjV7wivkLZ3ot2SZAkPm
	 cFNIGr7SWpsnHygkklP02aKodkckS9/M3/tHxV85z506RXrp7XnHyAWFBdvxzirpjg
	 CtUJPGvhhBFz7wt/FKVcwMOoJDRwbAYQsMuWXdmIkix7PdL6ByWOEFM/Fz+u4TzaAm
	 8POddEzPayX4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5D17408DE;
	Wed, 21 Oct 2026 16:09:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80CF195C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72236408DE
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ki8nJMxAiGor for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:09:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8170408EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598997;
 b=TKstA64GkmMyyuj2odg8oPkCQiQeB4g10cpoGX3GXG6Cylr8TOpy1ct3barhujW3iIdH
 Q3CFp16jx+27Wb9SM8gnv3MC0lEXkXOqw2rSWagB4a0rFhTra4UZWG5iK4FuJls1ySFwV
 oma1gUeR6JSmsLCtAXdVMHSxUL+qGQj3ZpXJU5z4dsCpvx7BN98EQ5rgbVoX/y0vd2RU8
 R8wnNZchwDF/zGAGf+JIfa6RzEQ0RhxWrg3zZp8PmIXljCTHjoj8b1+Q27zs2QKIr+ukr
 9L8TvDBiIsdnjp3vOF7OyUdfQQTwlNigD2KvjEwIiqRVXy4Cspd5xmGH2tecOmZFWkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598997;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=WKIkW02wH/a1+1PjmM9vEWWeIqQXpBuCwbXOSNCYgX77RjkWaRuCXJIW7gUDleNcJYqa
 pS3TFmUj71F4/2yGFJ4MyzAJR38xvfEWgCwwXTqOeFNAnTgTVKInQ2iWanVWBqjB/g7SK
 iHt/4gRpO/XTvRoD+votykkmlVzVi8Tvq0b/cByyOl9W2e3hgeSIzLxl5yTnuuMraEbTH
 wTwG7HZ/q+65DyFYk2GgBpl2NtmlucGSZ7oDZ94WcZ8UuD5sQA8gKGwRBGmIwEV+KheP9
 dQOlU7CCtRE7RlInpJnnGWtMcLXZ2Kxp2sv1SJ0zuqNAnWOUE2W96UEJMz0mM8VqJNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=XvNMXAx1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N+2SvmgQ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XvNMXAx1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N+2SvmgQ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8170408EB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU4gv3727088
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EAbXaIYHumc
 IwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=; b=XvNMXAx133mBNDURxPnn2cy361s
 xvFRlstzNdMCWGcjFM2IRa9ZZaa9Vyu3OjOvGnt9lj6BcCXsZ2hWtqWbJUFRk9AB
 eRcjCcWM4Tlse/ZNbaOi/sLOHMUuccjXPqRXuBNzO2Nej54G46Ymsgo4P3O/3vs2
 WO2US6kKkSZNnXsNVun1pkwcJWTJbY0ua89KtX1ieB8E+uDnzM+SGd/WSTQXA/BJ
 gzSd6Gpd9vcf0Jz5SgFUijBWZpOEcLPemvHYeeFl2IsxL9RK75HKHAvk+9MA6pVn
 9/CP/lRPatZYoga+XYaT4MLnEuhb3OUWULaB9pg+O/LwqdFrTrwAPTW/XXg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79yps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so450082eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598996; x=1793203796;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=N+2SvmgQJsT9sKUhXgJ+QKPSaYUPCL9spHwxLkoIU/JjWTdSouqTIyeWfX8ExXER3X
 vQOWgg6N0KYfmNbT5Zqn22hfxeuXj8iB/RVSnLwG60HaZghAa7LsQJV6i8grzlLBvZLA
 50GE3v3joYM5qpr1GokPrfPBjpYBpUTQp3e18RwUxqzi5qzAEWzJsgxvI/Ev4LudYHRG
 A71B1Yttbqw+XhLwV9OLP6syNFzYmBD7oMd/SOvSPrF4sXi/ZpeUysDsf5mlZzYIadR5
 EI2oz9gdPw136d1vP4Ex0qH/QM202gwJhZGPTZfINuhyvQZ9AIbzlzHIqk42zCIF9pR2
 KQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598996; x=1793203796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=SXygvyT+M2L+Hp+UWh+1CAYV4HgORSLDdnC68Iz9aI0FoqjK+/w9RUpeEG+sOGLjMn
 JI+q2Or+AtOMHkXciRvPSos0hg934n5Xrrg7Yzesl0qoP2aUY2RzWShWn94nLghFGclg
 gNOR/3IsVRe5cB4vpHKjJdqNHJpuS8rxPrqiQQE6xZSnpm68C32x76utmBw9riXAvsvx
 QR2/I/DyIGNHBHHcV0M+bs41PzzYDKszICGNo2UtO7DW7qG/9ILg6WkcE+a77WNylJ5V
 jsTmeYxLWv/YB9hC73XEqUtziTyT995FngfrzU8Dl18zJ0GPmHkOFdOocOdBD7C75a+O
 3ZzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbH0Bkj9HoZFRsVNux2tEt8gbilRWM0G+sHmfKAj8scc+UDuKxVsX/U28CDWLNh5x048WiRp8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSdzIQnJeaHpQ+DO3Oc6DfEFIdaUSvMj18VLJFvsyI5L2O3EDz
 7u6sOZ6HRo6u7BwbYGBEMB1JJjK9wnmrX8epEnpKFNyJEGcGEKIHLauQw/YKftHn8S9oHTqfpfX
 cnc90XBIJrSOiR48DSinIPlS7MWW+MSzeZiYhNCWM/dqaybhosvw9GUkDyFDuDBJyyEab1NM=
X-Gm-Gg: AYBFou2OTTcYXXwwnmE8xBpbTcbwhfUji7QHYrv09XvRDI+fWds7yWOasJY6vllV7Bf
 RclPSJvKzHrZNF7EufQSEaHT/4/pNlS/NPNiEnZPfJ2YQdcvfEVQ082IdVMrtP8v0uddqtOkn6u
 uIEBzMqSG9mnEUE+ZJG3bmlrbPbI1/CWteky0vkHeAbtLzwQV7fQx0JGzAXAPV7P1woXMsQ5o6U
 KsVwN6ZzhNmqv71A54aAMKerFbET+Wqziw1OxS8yp+CAxtQ2jtK6j7bGgT0F+bpwuBF6F17hn8s
 nL6ozxWtH0aYRdSkNjknKPmHQcckMxsTqs0bf+nRgk0jxjsJHbltgpL9jpAjCmcVSYAROuMi2Ad
 rt9850A6i8mtwXWsfw3HY7B0khIF4JmlvhHPq4r+Z5v6I4V1qwa4AGuyiNZmVZtPaTJZ22rI4Zh
 X25SVJRIrPbH0eS24ju+E=
X-Received: by 2002:a05:7300:d215:b0:368:78c9:159b with SMTP id
 5a478bee46e88-36878c919a3mr408991eec.27.1792598995740; 
 Wed, 21 Oct 2026 09:09:55 -0700 (PDT)
X-Received: by 2002:a05:7300:d215:b0:368:78c9:159b with SMTP id
 5a478bee46e88-36878c919a3mr408935eec.27.1792598994889; 
 Wed, 21 Oct 2026 09:09:54 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:09:54 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 04/12] phy: qcom: qusb2: add Shikra PHY configuration
Date: Wed, 21 Oct 2026 21:39:08 +0530
Message-Id: <20261021160916.3894471-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gtEgVug00KsUIgzwX-ditzimN-AfQ88b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX6DRORHZ0Ln89
 axhzrdVHjlHwRCC/4YKQAbyRQA/Stzyhmo8Lh2ImneIaNzMxNvYD+n0roMWf0SrNcBm8ToROIsw
 5zZxl66ssGYq8YTdCXLE1gGkjvi8jrF/ecninWPLwgm3loctf/SmIBXEgCmxh7mvnI0YqNQpAL+
 cpb+q5FcK523SLDRiufifaUzaOe188bh+Fg7MqDmBQAONRBWhNQGURpFOWkH1oaLfaV5DmedBmo
 pgJYk7pKv0Up7A3NOxtHwbx2mdbnig2KD9FHinDli4dR/GNfYMpBq0WM0J4+INJLPd/yQo6n+3u
 1duJ0dKoGT4JKs5RAOcL3DNOwkwMLU9PJ7fLfHD5A0b3Rg1G8CPz9/NDakhIrpN7kx8+cTUEbSc
 G+NzCGuk0EsOjfNrYfZNMB2dL2GbYw2TCDmBk9dHe/3c9905dT246lH0HGPZrO7HHoa5iuPs/N0
 aSBUGFYbUhbRmzPROfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX9haUG6YGHIf2
 bfkvSRH7tjjHCzftMSdj7ov9xxF+RbEF6C22U7ms9M2v7Jv10hTpQC6uQT4GkSGP0Zt9/c+N/lV
 NyrGXQKFzHvmqmvwly59qZxEPA1ywiM=
X-Proofpoint-ORIG-GUID: gtEgVug00KsUIgzwX-ditzimN-AfQ88b
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8e3d4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=qtZHeC2-AEtKh8AW8voA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Add support for the "qcom,shikra-qusb2-phy" compatible by introducing
the required PHY configuration data and binding it to the QUSB2 PHY
driver.

This allows USB2 PHY initialization on Qualcomm Shikra platforms.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index 6278171b100..f5214bffc52 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -310,6 +310,18 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.update_tune1_with_efuse = true,
 };
 
+static const struct qusb2_phy_cfg shikra_phy_cfg = {
+	.tbl = qcs615_init_tbl,
+	.tbl_num = ARRAY_SIZE(qcs615_init_tbl),
+	.regs = ipq6018_regs_layout,
+
+	.has_pll_test = true,
+	.se_clk_scheme_default = true,
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(3),
+};
+
 /**
  * struct qusb2_phy - structure holding qusb2 phy attributes
  *
@@ -505,6 +517,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,qcs615-qusb2-phy",
 	  .data = (ulong)&qcs615_phy_cfg },
+	{ .compatible = "qcom,shikra-qusb2-phy",
+	  .data = (ulong)&shikra_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
-- 
2.34.1

