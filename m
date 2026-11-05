Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A559606A32E
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jhw87HAF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f+3iSdni;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gbZ5Mqz+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EBB3811A5;
	Thu,  5 Nov 2026 18:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8V1qygtg7BqW; Thu,  5 Nov 2026 18:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 885068119E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903195;
	b=DFOErft+1c95rh139snV/dfOT3daNDqy0m/Y2AJjwsNu2c+79Wa0JrljDL5Vvn4yri0g
	 j6eN2Mhc2Wv7LlzO3Rt8y4Qsxahbg3OGCeJyZ47UJBbTrIzsequicEpyyzKxLE7JdS9sz
	 tL7kGQG0f+9og0xCeDScpqVepfK6SWGKLPXxDl/DNv5waw0YNEF18Td6kONjgn0a0Iwyp
	 hzUyzLCt6/lxXuM//9mYc618Vn8rcIOesL6xoKZhn/kF+QgxvM430I1iOUfCBxZNU3w9I
	 4Q1HMEUIXGmBCQDOKS2kNlWVs+A7YWN0R9jrv5aowCqONStrnGraYyrMcL+tdHBlV7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HpsLM03OnTzoCjY118H2wtAlBUEBrTJ2G/jBMVXJFaA=;
	b=VPLSS+9e6noX3ZNux+p08vCZ8zlhJffn2NGkcQ240CiPPSLZ5n+kdhL7aQhascP67ids
	 BxqlLKeccU8Y/plz2WXrj3Mq4JXkdH3TuU7nVjcjxIzJFo0bwov6BiuSm8RF86uKqV+hD
	 iHthcCgeoO2o15gf3UgmX303+5eRYii7IsNj9Ou/XyQzkSzo3LjOqrzkfh2BA2y5QMG6w
	 HCRoalPh8Jp94D3AS90T6YE050ljUVK2NOezIXaeP6QRXXcpik3NnsCnaa1v3LYRLkhCI
	 vpOLI99nP8+alNP8ADOpbQrUZm1IWuL1/2xxBm9JYhm97bIsv3mTskZPN9mofG+9JLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903195;
	bh=HpsLM03OnTzoCjY118H2wtAlBUEBrTJ2G/jBMVXJFaA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jhw87HAFitP1T/DB44HIQgx7tLpzpCL0zxd9r5Byh6087vcNAm2G7V6wDK7S+sqCy
	 AMHdl6Y3vG3kAPBpG0QKFzod38urSwpgpr5PE2UJJ1MvflT7I6YWY6IbeYwjhZw2xV
	 iLWR653ChmRvCP/88WDLJzSa6NYaGcqt3NHPfN9HpRkRGGOhjG8VcGH9Cw8AyIXnTc
	 fVzLHG6CJLKL8DjArqoXXdnmXtzOvetuITQ0aqfv0aN/IE6EUKdsXN+pBPO+O9RV95
	 OqFDYDfyH4V5wZXX2zzaJ0FZIaJbeSUUgqGfJ8J7krW5j/Ey2c6LoDBD5RrCie843p
	 xMWr8uJgXVFLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 885068119E;
	Thu,  5 Nov 2026 18:26:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E0AA2AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24359400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iIa8I3alg-Br for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:26:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 21FBF40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=f+3iSdni; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gbZ5Mqz+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21FBF40012
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeOBK1440066
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HpsLM03OnTz
 oCjY118H2wtAlBUEBrTJ2G/jBMVXJFaA=; b=f+3iSdniKRx12SO9klAavQPl2Wg
 tgr+J+ig6/x8OjHYpViNC5ayRz0TRoO3QeS8xWOHRNwIRuyxg+dYfNyiHrsaHNjn
 1xi667LIC2VwpfD5XQfHYjQ8kPhrPmVV/8i3VvGlOoiJ26h/kJm2C8Y00nwCB3Tg
 gFzRN7yVqLLRtZTzgsEDSSGfEvd/9ToINujDgA9zTgRtAiJLNDPlMW9YFc29Fwot
 +P1hfYnUyZe2InX0hjFaoVd/q5BykFT7EH7fr7MPZ5LxK6CNWPK1fibGluW3Ao/R
 i1lEhoHDIvX84yHQp71eS80JC9cubaFSO4Tj2J3M6qp89mJQCOXkBEsfv1g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v355b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:26:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36efb506f29so485313eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903191; x=1794507991;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HpsLM03OnTzoCjY118H2wtAlBUEBrTJ2G/jBMVXJFaA=;
 b=gbZ5Mqz+WrP4nb+FQwLjZsJz4Kz32TNTXjGkCaL13KLq22Ses6nWgA/pBxRw/aAQAL
 wU+610nB208As04b10riky6Fjb3JqM9u6ZRNHAmKrE+MHNRdRDFdFg9bleqmPPE8qOs5
 2/7MEW/kpB0kfsO0YHPX/+CwURhbk0SqPOqtrrrqWOE1Om0g1Y8ZFX/LtE9tvxg28cP7
 ycjnMKWq38zaWv2EkjbXiGtLhIiPkaJB5Uipqk5i9EHa1sL86shTocgtz2KdJPASsbqN
 DfYt2VzKWOXPGKSKjuICPR8aYAfCcLZDEVpyVI9JVKXsoSh7qxMyyzwcI8vuwFl6LqBp
 v8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903191; x=1794507991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HpsLM03OnTzoCjY118H2wtAlBUEBrTJ2G/jBMVXJFaA=;
 b=YG42IZ8JqKBIbxofSdKHLNAzf29nURNPH900opVrwYjMOFGaznk6qIXisULfw27R8B
 +lLmHi6fUdWNERJr6zXW3Sml5EnI8xlKmJrdkHj0N0DYO2FEeFUGzCjeLwwxXX7v2RK2
 /jfo2gn1/kfdI29lvf5z6NwTOFgWarnfmqDq6W5b4u6M9XiOHJAexrODlinAd+1GWPi1
 SrUBvxnX2/8ram0L87cFafTRGD9UOGI9cq5yDXSb+8uCYIJ1ysCtwbywKWYbbdZehhYz
 VJvt5fSMMUjJEI8az3HSwHCo2ldQHs7Hblthagy9LMHJ0mpJfURck19SGYqkcDZU9bch
 f6Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwFBERAjQ7936/a3u2nh2W5tqFP0W2k5J6mRONP0RAdEW0NT/fFda5szRJWY0ouuZvUVNAzLQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+HkkkQz2W5Y+/7xjV7cgl1aK8b/BXu4my6iLoLQtx77d3IoL3M
 mhLCLep6tXE69Ck5gcRgpKUkj7eaLTEMx+11nH7Oe7TYmeFCZp5cbpZjJZJESZeg4ItL1e8HzH3
 raYgOuFA2gmMMLFeyRdhT+6jHx0kaI7FzGMCtBDd0UPP1cKgfHna8JMIl94GXyrHDsbHUbCU=
X-Gm-Gg: AYBFou0rd9rPUqcjCV6F2AzkOG+xWHGLOrbWOLXSjgIcm9UKvWTy2QRA+sCFmA/RoRk
 IUWz7l9Kr9P1B1hl17msrYCrMBezXa6CQ/1og9agfJn113FTaRx6R8zl49KOaRv7qYtfnDkU7Bm
 iKzlkWr+s4hMUdFbNEXjF4TxFP7ZHTRgjCJILGS+X6yro0UXjUox8TDD8XFCBYofhr7R7NdZAHS
 NEqzORI/jJyEhOrr8gLgtbZbhi5dLGl8TsiJ6mA9dLx18HhO6/G2+UY5mCBIkbfxOYqtY6wWuPj
 XPTgdjjsvnVg5Jc8d3Pit8XWm1ZQzoBF5duTIZpygFXok2LCen8elFjUKkuaqmE+0rPOL+v3ywt
 FKn6h5rKBTcfKX1GPrZq8J5TgjYS3PiovupAOMvEeSeH/FS49wXEjfJt/utbqoxmYncxfRyxIgx
 RC9wjCRd+/EauzLFd6gSei00oiGxmE/H2578RPJnHpvpF7S2/p4HGmr1BSM/4yuzToNdkm
X-Received: by 2002:a05:7301:2a05:b0:36c:b138:651e with SMTP id
 5a478bee46e88-36cb1386818mr12046771eec.22.1793903191058; 
 Thu, 05 Nov 2026 10:26:31 -0800 (PST)
X-Received: by 2002:a05:7301:2a05:b0:36c:b138:651e with SMTP id
 5a478bee46e88-36cb1386818mr12046700eec.22.1793903190398; 
 Thu, 05 Nov 2026 10:26:30 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:26:30 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 01/13] clk: qcom: add GCC driver for nord
Date: Thu,  5 Nov 2026 23:56:02 +0530
Message-Id: <20261105182614.2405482-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX44Urt5L5XWtm
 PKSP1U8B2etFHIZWr7kwy/hqFhJPIhBl26qk8u9ZaGrYqj742i/BmOgDuRZE/afkZMbhwb61/k+
 pVZF8cdM1KjRnjcfiTzQdfgcA2uIizI=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aecca58 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=80mdcwNe0BwfYoIDu2YA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX37pjIGgi5VCU
 zt4y5vuM6zi3SRvlUOzAJVnv2JJIOkQ9bwF9Tb6rcufCVGvMeABUj+dm8sqwyXVoB09vUyFCKhY
 5O2emA+MQrfWHV4qR0IWlgFELWccuEe7ESvkjFNbU+hdqv2sauOqpeYyilRIz+Qn5eg3w9AR7cf
 j5sSHaCJBdK0XAPweNu/S0vGqKFcr/wGDeF796p6ZinSpXhdq5i63WKtdEbB+ErTBAUxaHaDFPu
 tsXdM7RlWpKLOxLGHrqVthqNQtnDAwCPOd5p/hfcfsordfpEMDyGRzM4nrirGisPxh0yasCIhzc
 9iRgNLeWPtp18oo1CFtIY5gydDUkX+tlHRxQVTXG32TtQRjV8MVqIf8b3EIg5j73VZy2YZL7DWb
 Ewo8c/LBbqAn0J1FLl02EQyYE+4G6JtjYq5Uif5oFSs2CYs7m13ZKgLvUbdMUJPXtedmK0wpItY
 DJmMms37vbjX+VySIFA==
X-Proofpoint-GUID: P6ci7YBUptkLdgrm_tIDg7cSRVDLi_lc
X-Proofpoint-ORIG-GUID: P6ci7YBUptkLdgrm_tIDg7cSRVDLi_lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050073
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the nord Global Clock Controller (GCC).

Implement the qcom,nord-gcc driver to provide clocks, resets and
power domains required by nord peripherals.

Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig          |   8 ++
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/clock-nord-gcc.c | 165 ++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-gcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0d8f5028a4e..09ac473c841 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,6 +55,14 @@ config CLK_QCOM_MILOS
 	  on the Snapdragon Milos SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_NORD
+	bool "Qualcomm Nord GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon Nord SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 73cafc3f938..fe2f796c248 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-gcc.c b/drivers/clk/qcom/clock-nord-gcc.c
new file mode 100644
index 00000000000..ef6afc87a85
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-gcc.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-gcc.h>
+#include "clock-qcom.h"
+
+static const struct gate_clk nord_gcc_clks[] = {
+	GATE_CLK_POLLED(GCC_MMU_0_TCU_VOTE_CLK,      0x7d094, BIT(0),  0x7d094),
+	GATE_CLK_POLLED(GCC_PCIE_A_AUX_CLK,          0x9d008, BIT(14), 0x49058),
+	GATE_CLK_POLLED(GCC_PCIE_A_CFG_AHB_CLK,      0x9d008, BIT(13), 0x49054),
+	GATE_CLK_POLLED(GCC_PCIE_A_PHY_AUX_CLK,      0x9d010, BIT(12), 0x4d01c),
+	GATE_CLK_POLLED(GCC_PCIE_A_PHY_RCHNG_CLK,    0x9d008, BIT(16), 0x49078),
+	GATE_CLK_POLLED(GCC_PCIE_A_SLV_AXI_CLK,      0x9d008, BIT(11), 0x4902c),
+	GATE_CLK_POLLED(GCC_PCIE_A_SLV_Q2A_AXI_CLK,  0x9d008, BIT(10), 0x49024),
+	GATE_CLK_POLLED(GCC_PCIE_B_AUX_CLK,          0x9d008, BIT(23), 0x4a058),
+	GATE_CLK_POLLED(GCC_PCIE_B_CFG_AHB_CLK,      0x9d008, BIT(22), 0x4a054),
+	GATE_CLK_POLLED(GCC_PCIE_B_PHY_AUX_CLK,      0x9d010, BIT(13), 0x4e01c),
+	GATE_CLK_POLLED(GCC_PCIE_B_PHY_RCHNG_CLK,    0x9d008, BIT(25), 0x4a078),
+	GATE_CLK_POLLED(GCC_PCIE_B_SLV_AXI_CLK,      0x9d008, BIT(20), 0x4a02c),
+	GATE_CLK_POLLED(GCC_PCIE_B_SLV_Q2A_AXI_CLK,  0x9d008, BIT(19), 0x4a024),
+	GATE_CLK_POLLED(GCC_PCIE_C_AUX_CLK,          0x9d010, BIT(0),  0x4b058),
+	GATE_CLK_POLLED(GCC_PCIE_C_CFG_AHB_CLK,      0x9d008, BIT(31), 0x4b054),
+	GATE_CLK_POLLED(GCC_PCIE_C_PHY_AUX_CLK,      0x9d010, BIT(14), 0x4f01c),
+	GATE_CLK_POLLED(GCC_PCIE_C_PHY_RCHNG_CLK,    0x9d010, BIT(2),  0x4b078),
+	GATE_CLK_POLLED(GCC_PCIE_C_SLV_AXI_CLK,      0x9d008, BIT(29), 0x4b02c),
+	GATE_CLK_POLLED(GCC_PCIE_C_SLV_Q2A_AXI_CLK,  0x9d008, BIT(28), 0x4b024),
+	GATE_CLK_POLLED(GCC_PCIE_D_AUX_CLK,          0x9d010, BIT(9),  0x4c058),
+	GATE_CLK_POLLED(GCC_PCIE_D_CFG_AHB_CLK,      0x9d010, BIT(8),  0x4c054),
+	GATE_CLK_POLLED(GCC_PCIE_D_PHY_AUX_CLK,      0x9d010, BIT(16), 0x5001c),
+	GATE_CLK_POLLED(GCC_PCIE_D_PHY_RCHNG_CLK,    0x9d010, BIT(11), 0x4c078),
+	GATE_CLK_POLLED(GCC_PCIE_D_SLV_AXI_CLK,      0x9d010, BIT(6),  0x4c02c),
+	GATE_CLK_POLLED(GCC_PCIE_D_SLV_Q2A_AXI_CLK,  0x9d010, BIT(5),  0x4c024),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_CNOC_SF_QX_CLK, 0x9d010, BIT(24), 0x52040),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_M_CFG_CLK,      0x9d018, BIT(4),  0x52060),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_M_PDB_CLK,      0x9d018, BIT(8),  0x52084),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_PWRCTL_CLK,     0x9d018, BIT(7),  0x52080),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_QOSGEN_EXTREF_CLK, 0x9d010, BIT(19), 0x52074),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_SLAVE_AXI_CLK,  0x9d010, BIT(26), 0x52058),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_S_CFG_CLK,      0x9d018, BIT(5),  0x52064),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_S_PDB_CLK,       0x9d018, BIT(9),  0x5208c),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_TSCTR_CLK,      0x9d010, BIT(18), 0x52070),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_XO_CLK,         0x9d018, BIT(6),  0x52068),
+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK,             0x1a004, BIT(0),  0x1a004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x9d000, BIT(24), 0x23020),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK,    0x9d000, BIT(23), 0x2300c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_M_CLK,       0x9d000, BIT(22), 0x23004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_REF_CLK, 0x9d000, BIT(26), 0x23170),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK,      0x9d000, BIT(25), 0x2315c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S_AHB_CLK,   0x9d010, BIT(15), 0x23008),
+	GATE_CLK_POLLED(GCC_SMMU_PCIE_QTC_VOTE_CLK,  0x7d0b8, BIT(0),  0x7d0b8),
+
+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK,   0x1f004, BIT(0), 0x1f004),
+	GATE_CLK_POLLED(GCC_GP1_CLK,            0x30000, BIT(0), 0x30000),
+	GATE_CLK_POLLED(GCC_GP2_CLK,            0x31000, BIT(0), 0x31000),
+	GATE_CLK(GCC_PCIE_A_DTI_QTC_CLK,        0x9d008, BIT(8)),
+	GATE_CLK(GCC_PCIE_A_MSTR_AXI_CLK,       0x9d008, BIT(12)),
+	GATE_CLK(GCC_PCIE_A_PIPE_CLK,           0x9d008, BIT(15)),
+	GATE_CLK(GCC_PCIE_B_DTI_QTC_CLK,        0x9d008, BIT(17)),
+	GATE_CLK(GCC_PCIE_B_MSTR_AXI_CLK,       0x9d008, BIT(21)),
+	GATE_CLK(GCC_PCIE_B_PIPE_CLK,           0x9d008, BIT(24)),
+	GATE_CLK(GCC_PCIE_C_DTI_QTC_CLK,        0x9d008, BIT(26)),
+	GATE_CLK(GCC_PCIE_C_MSTR_AXI_CLK,       0x9d008, BIT(30)),
+	GATE_CLK(GCC_PCIE_C_PIPE_CLK,           0x9d010, BIT(1)),
+	GATE_CLK(GCC_PCIE_D_DTI_QTC_CLK,        0x9d010, BIT(3)),
+	GATE_CLK(GCC_PCIE_D_MSTR_AXI_CLK,       0x9d010, BIT(7)),
+	GATE_CLK(GCC_PCIE_D_PIPE_CLK,           0x9d010, BIT(10)),
+	GATE_CLK(GCC_PCIE_NOC_ASYNC_BRIDGE_CLK, 0x9d018, BIT(18)),
+	GATE_CLK(GCC_PCIE_NOC_MSTR_AXI_CLK,     0x9d010, BIT(25)),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_REFGEN_CLK, 0x52078, BIT(0), 0x52078),
+	GATE_CLK_POLLED(GCC_PCIE_NOC_SAFETY_CLK, 0x5207c, BIT(0), 0x5207c),
+	GATE_CLK_POLLED(GCC_PDM2_CLK,           0x1a00c, BIT(0), 0x1a00c),
+	GATE_CLK_POLLED(GCC_PDM_XO4_CLK,        0x1a008, BIT(0), 0x1a008),
+};
+
+static int nord_gcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_gcc_resets[] = {
+	[GCC_PCIE_A_BCR] = { 0x49000 },
+	[GCC_PCIE_A_LINK_DOWN_BCR] = { 0xb9000 },
+	[GCC_PCIE_A_NOCSR_COM_PHY_BCR] = { 0xb900c },
+	[GCC_PCIE_A_PHY_BCR] = { 0x4d000 },
+	[GCC_PCIE_A_PHY_CFG_AHB_BCR] = { 0xb9014 },
+	[GCC_PCIE_A_PHY_COM_BCR] = { 0xb9018 },
+	[GCC_PCIE_A_PHY_NOCSR_COM_PHY_BCR] = { 0xb9010 },
+	[GCC_PCIE_B_BCR] = { 0x4a000 },
+	[GCC_PCIE_B_LINK_DOWN_BCR] = { 0xba000 },
+	[GCC_PCIE_B_NOCSR_COM_PHY_BCR] = { 0xba008 },
+	[GCC_PCIE_B_PHY_BCR] = { 0x4e000 },
+	[GCC_PCIE_B_PHY_CFG_AHB_BCR] = { 0xba010 },
+	[GCC_PCIE_B_PHY_COM_BCR] = { 0xba014 },
+	[GCC_PCIE_B_PHY_NOCSR_COM_PHY_BCR] = { 0xba00c },
+	[GCC_PCIE_C_BCR] = { 0x4b000 },
+	[GCC_PCIE_C_LINK_DOWN_BCR] = { 0xbb07c },
+	[GCC_PCIE_C_NOCSR_COM_PHY_BCR] = { 0xbb084 },
+	[GCC_PCIE_C_PHY_BCR] = { 0x4f000 },
+	[GCC_PCIE_C_PHY_CFG_AHB_BCR] = { 0xbb08c },
+	[GCC_PCIE_C_PHY_COM_BCR] = { 0xbb090 },
+	[GCC_PCIE_C_PHY_NOCSR_COM_PHY_BCR] = { 0xbb088 },
+	[GCC_PCIE_D_BCR] = { 0x4c000 },
+	[GCC_PCIE_D_LINK_DOWN_BCR] = { 0xbc000 },
+	[GCC_PCIE_D_NOCSR_COM_PHY_BCR] = { 0xbc008 },
+	[GCC_PCIE_D_PHY_BCR] = { 0x50000 },
+	[GCC_PCIE_D_PHY_CFG_AHB_BCR] = { 0xbc010 },
+	[GCC_PCIE_D_PHY_COM_BCR] = { 0xbc014 },
+	[GCC_PCIE_D_PHY_NOCSR_COM_PHY_BCR] = { 0xbc00c },
+	[GCC_PCIE_NOC_BCR] = { 0x52000 },
+	[GCC_PDM_BCR] = { 0x1a000 },
+	[GCC_QUPV3_WRAPPER_3_BCR] = { 0x23000 },
+	[GCC_TCSR_PCIE_BCR] = { 0xb901c },
+};
+
+static const struct qcom_power_map nord_gcc_gdscs[] = {
+	[GCC_PCIE_A_GDSC] = { 0x49004 },
+	[GCC_PCIE_A_PHY_GDSC] = { 0x4d004 },
+	[GCC_PCIE_B_GDSC] = { 0x4a004 },
+	[GCC_PCIE_B_PHY_GDSC] = { 0x4e004 },
+	[GCC_PCIE_C_GDSC] = { 0x4b004 },
+	[GCC_PCIE_C_PHY_GDSC] = { 0x4f004 },
+	[GCC_PCIE_D_GDSC] = { 0x4c004 },
+	[GCC_PCIE_D_PHY_GDSC] = { 0x50004 },
+	[GCC_PCIE_NOC_GDSC] = { 0x52004 },
+};
+
+static struct msm_clk_data nord_gcc_data = {
+	.resets = nord_gcc_resets,
+	.num_resets = ARRAY_SIZE(nord_gcc_resets),
+	.clks = nord_gcc_clks,
+	.num_clks = ARRAY_SIZE(nord_gcc_clks),
+
+	.power_domains = nord_gcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_gcc_gdscs),
+
+	.enable = nord_gcc_enable,
+};
+
+static const struct udevice_id gcc_nord_of_match[] = {
+	{
+		.compatible = "qcom,nord-gcc",
+		.data = (ulong)&nord_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord) = {
+	.name		= "gcc_nord",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

