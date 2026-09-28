Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC7DCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B4C980DEE;
	Mon, 28 Sep 2026 12:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANn8C776DFwT; Mon, 28 Sep 2026 12:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0C1A380DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596959;
	b=qn61qikCiKR9l7FEI1GaDHUZvQOJtdwHD+cpnm0QCkFtUB3EBkf5YLMJD0J8azdt55lE
	 bo3wCs1tI5sq94DFHDNA6+JviS0CrfTRkxXOxCt3/wJGLGGnrmHJZQ9ByB5A0n6fELL0d
	 xrr1tEEF+WT3hoWO63WdaG78sx/CrD4nkISNhWE7eOChxQGu4xNYbQGqNF9aTdTDeEYbB
	 UzwjdEtVs0sLyT949b9DFtPYc36oIOyVlix5/Oqh5aD1h2aevkZmPh0SkSyC4I7yRDt3D
	 OhNnKgCqpuha8gbgQeAFTvvY2VDPFN1f4zI5KCK37EcaYq7aeuJK4MpwaVsz9Ddt3PQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CO4cgbaHm2QAjMvrLP3gOaoo6TVuq5mQvX7WAuAl6G0=;
	b=o6DC5rBGEbZxDgSdiOjZhMv62zDLCOS2+NIxBmBOvS+6oFSs63jG8+3hUOK/RDlGl3u2
	 TqhbK7erO9EVjofavW3TGtILhrOqXQVNQrF+Upj/kU22XNqAuX0FeyyrLWmE8H47Hr4my
	 9FFoYhTTeBl0t6nYDWZndxmpOyN1LomDMwU/e+4l0sq9TF4Al7cnqSSAz2cVzv/EUFxCb
	 ww0uZTNtZnCyKPVW9pQ/DMCibqsW1+xnyHAA0CGkiiacIWmFHi7newHZUQzaUCyp7fh60
	 IG42RlYz9jAHhfXIidzzUq5pq2IOwOfHFm73J5ZqGCmzQIZ5zU6F1xh6nMMHy1ebRog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596959;
	bh=CO4cgbaHm2QAjMvrLP3gOaoo6TVuq5mQvX7WAuAl6G0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCyCRRRcDurwuBey199imvyqK54GZgCTI5kpIAkxeDCat3lfUGVBkIVjaJVMv9jQR
	 UlRSJ1Q1qv36RVTOaW5MVhq9Xd26yH+YDyENjLytBXAY+owfWM3r8Yc+6CHEY6Ij+4
	 M0nT0C+NY7/eA/HJ4bW5IGXgiFLjQwzrvVMu4uPk1fUr+RLcLLJYh4RKmm7yd9gIK1
	 wr4IWq2lAw/XAMTq+7RV2Btefmbt88uwUS8v0Vbn7EDsobQ6DbU+wvU1fqYfF3FuFO
	 Un3t8ICZFx3m5AHHABy23opEkzuDYxtuYPS0TcK/zSym723unz4gmc14lhePbKJiw/
	 Zo1igK88x20uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C1A380DC5;
	Mon, 28 Sep 2026 12:02:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E42A32F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 221C06064A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqqFTP2CclHr for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2CC7260625
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596956;
 b=GkCZJtwCpT8+T1YFXZvae20gXQAn3REwcRRd0/lbi7+GRPVCmkBhFMU4qLPHnIfjMoJt
 idaU1XBOhGgrINoNkVa8iYuZqrMmuGHxfA3d/v206j5scfxKXNO9buLmI5VVMFL0F9wg5
 71P14fibPbYjNgGcqVCRuWh63df9LMkgBjNwPMqKEO7XqLLRzCmYt2R7BGtMyQVK/82CH
 5F61h1laCyPX9TI5glZiOljqKS/Uca3NuOZ2cB/Dflun6lt689MbWZgOCQ9Y9IdiGOJ2G
 c6EsMN8kW4aXloojFpWueZ7mG6xckE1aHrD7bxckT8QMphXpfq3Nsb//ssmDn9lNoWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596956;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=CO4cgbaHm2QAjMvrLP3gOaoo6TVuq5mQvX7WAuAl6G0=;
 b=XAqermWg1nGzrPBwMdW4+n50P6M1jxMhbM5KlqNQMIccaxAPxsQWzf/GWtZ+T3WpHNf6
 MtIdWa9O+F4xP7SRsw8IEqWvwnRZB4cARSRktQkkW7y/MSDGwL1dS+cdFHipsEEVSBwHg
 nXUTLSVLEYrNhbe3tZ0YR8GffBF6uWmVzprX75uYjvbDwHxKRulxR3CTE2Os4nOvzmZa0
 YTybkUT+1R8aStgMd/wea2enlyGsySF83GOjoB2i/PD+OB/aEJu1pxOlY5C530bix5d9y
 LuBpDiZNQfGkPwtTNjJ12tfsMdh2of6GyMhEvYHoP2zIJRm/kgHm/O0ByXZngULBR8w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="b214/CVL"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SRbTUmD7; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=b214/CVL; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SRbTUmD7
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CC7260625
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAWQJ4115827
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CO4cgbaHm2Q
 AjMvrLP3gOaoo6TVuq5mQvX7WAuAl6G0=; b=b214/CVLsFr4anXM1qIChUYgYmC
 ZOdYDd9+nyUM8qGl8Hd5Uz9WiznS7dDngsMGVBhtmGrWm2m5e0UPu/rGT/k7wkgF
 svoPTXOnbFesBlWD1UDlzYzrYzCZnnQd8BdURh8LQnbRZI8sPiVbhjKjb3UAiBph
 CsN0wKXMQ8weZTaqEgpNfdT5LMbnv5SIbLphlQe0Vu6P2EaKAqXdE2nkaU9iYmUH
 k7zw/f1XB5dpoQ4iFCQaemdndyzoIfaTbdcr5I5geGomHc/avaTVMPHtCCw76py5
 NGHvfK4GKfnUuNXFc4HstPdzhjj0FHRX5GQhmEZQ+CT4LuF+7PLTKhtovaQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jwvkk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-347536bd6fbso1268105eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596954; x=1791201754;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CO4cgbaHm2QAjMvrLP3gOaoo6TVuq5mQvX7WAuAl6G0=;
 b=SRbTUmD7zLCgC6j5kyhbb2WUAYorf8T49dV8OgCxmclooNmg7WAWTKOYZXXnXhQc1c
 4OuODj6S7pUJCiw8w42nqb+hkG1MF10smphNoTxi8YJqY8VIITaT/iztqchBJz1GZhsN
 N9xKWrAdL18Oi8O0nh/A5/F6KnlRIKxic2SQ1qkywTXHVzY4aGcEpA43qsfgy57dNQ45
 yEjI7jN30OEh6eiWdxeHp/6HOnYBiat3fAarD3T+BiMx2N9U2GuBVr6xE5TG3QFG9ze7
 unbsbmRJw5PAfXK8h2NMKZwXXCzHejwy6x7GbHl2FGtC34SgHjQO7FdTA04PwMepmJ+N
 7B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596954; x=1791201754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CO4cgbaHm2QAjMvrLP3gOaoo6TVuq5mQvX7WAuAl6G0=;
 b=pYon7hxatwLCrqKkNR2erUxxNx8jFOlKEzq/qebrMJqgCQfbkp/7lS3B67nn69XpF/
 X3D/u5apf1VOvjPZfzHmRzKYDe81cXqVPdeKp7ZvVAENlKxrF/S9HfueFDQlsvfpWf4f
 uu4Wz2cX+bRTD/m1MKQ42Lks+iy2Jh0Wj2f6Zz4QPnzEnX2VgdVr8+BDzSD00w7xwJae
 iPyVKQpAp61F4XboPG9hdRnCCUxSMAuzgtP8WqaBFVo8sdzsjGZyO7IHgcHAWFs+Zsag
 iFkgwf0IxjcYxbfFPNIIdSo7gXaRmTLdpP0z6H4NEhrSwliL5nEQlqXYiCRR8th4WYZw
 /9Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvByPcj1qO/f+mbIlwD2BkjoCZ0Hx718NTz3O6e03pgYRx1PuMBRG+fi+snyuIK3aXKvb7k8Xq1I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lrCK6STZ6hobSmY8Dy3MeuFY09qyBF1oCq4X0rez8nMsguxgl2
 4Qm0u+NSY/TALZ8EsGku4QJ4gf+bUkKbziSzQpla2qYUQpJRBO+sSyJZQ/8m4ayd+hleIWYz7GI
 2HUOZhM9y2BbrOIsPimjsNcF/j5qAZJWj5jcoDA76rp1QWphz0ug/aljiDBnSyX3osDCY9vk=
X-Gm-Gg: AYBFou2YAiRKuWDRjHSRvbg86i051hsOdr25+5tNY3b+Qlh+tyejEJPw3tJ9L9kc9RJ
 OkSWamOtpLl3vfFsjOSmw+krkbNedeh6ILIEA7pKeVQIz8QBg/pKL236lH/wKGWPvUpGRvqgtcR
 60jV7C3v/oRIaCr2qoRDDXOfg/NgWCP8OLhSNij5g3i53PShFGifq6cFhd6/DtlPYNOkj2Dpt94
 pbeOkrD6jjCzoZPwJ1dAlJIywgGdlcfgOkTvcBywoxhFbjgZG5Y4HVE0JA4cmrk366073XMgEYm
 1H6lowRWmcuOumvILg7kdF+hR7axQGFQkMCHdrnXFwSkzhVeEajzh8/WQx+Z0f2X5Yh50R1b4Ki
 ogShrh/B4iPI8hI/7+WttRJlhXT+/Wk/tbr8DEr/ZTjp/qGh6czjUfSRst8H7Xf7WQw6fJjlDcA
 nD1SJ0wTITTJbH2/p6pw==
X-Received: by 2002:a05:7301:dd97:b0:341:8e9e:28f6 with SMTP id
 5a478bee46e88-34273946002mr9012662eec.41.1790596953529; 
 Mon, 28 Sep 2026 05:02:33 -0700 (PDT)
X-Received: by 2002:a05:7301:dd97:b0:341:8e9e:28f6 with SMTP id
 5a478bee46e88-34273946002mr9012622eec.41.1790596952785; 
 Mon, 28 Sep 2026 05:02:32 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:02:32 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/9] clk: qcom: add GCC driver for nord
Date: Mon, 28 Sep 2026 17:32:02 +0530
Message-Id: <20260928120209.1064781-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfXxZ3TKnoU51Dy
 fM2ABsSu2mUuCHCiQoI87rvDxAApfqVjFJOS3uW8b45/mOJy73yWwMuiitVBLnpnOuzWdddNEFK
 iFaEJ0kcxf82AiZhbinYROeAjAeWQpU=
X-Proofpoint-GUID: FvvDXq1vR1qRGkP6hLzArM3To065euck
X-Proofpoint-ORIG-GUID: FvvDXq1vR1qRGkP6hLzArM3To065euck
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6aba575a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=80mdcwNe0BwfYoIDu2YA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX6qfxmMom7MNt
 PqDVL7/Ii4FIEwKAoCRZQlwZaTacK1cONtH+tZkSXn0WfhPoxLIUJY4+qvUPK92AYxMtjuYMo9r
 y/30h3p5j8LCpgGEhx1ZFkYS8HRzo3ONBLkRKdWs9OooHb52zuA1TvWmwBJdGYTSLBvKAQEH8cs
 4oOzidsrukzl88S3pxKz8vehjextVWrToffHtBZ7riYiyC4O7k8xjwpU7PEKN8bZL+ogmCMzL6l
 BC6aSL/bdJyAW2vih8w9kdN9MQyztJHMORoyoCjnHfvh4mOZhz+Lsuj8wF0Oj4G+/fqKMoD8gHm
 MzdCbsE1ssLdmt82FHYwV4RRVcr0otPnMVRIXGk0XeRl98s+skH9FJGSAojvp2MRDnf3RCZMvz9
 xL6JhCZV5UBdF7+A2bJjZJR+X5PoUacwlCPZUypvHtQNghuU3EcJhZUayCBB5uLgiq/8YvhWiVS
 PORpQuSgnUvrxM11dZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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

Add support for the nord Global Clock Controller (GCC).

Implement the qcom,nord-gcc driver to provide clocks, resets and
power domains required by nord peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig          |   8 ++
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/clock-nord-gcc.c | 165 ++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-gcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a3..2eb0354d487 100644
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
index 1adca029b11..fef48fc324c 100644
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
index 00000000000..af38b3b1daa
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
+	GATE_CLK(GCC_BOOT_ROM_AHB_CLK,          0x1f004, BIT(0)),
+	GATE_CLK(GCC_GP1_CLK,                   0x30000, BIT(0)),
+	GATE_CLK(GCC_GP2_CLK,                   0x31000, BIT(0)),
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
+	GATE_CLK(GCC_PCIE_NOC_REFGEN_CLK,       0x52078, BIT(0)),
+	GATE_CLK(GCC_PCIE_NOC_SAFETY_CLK,       0x5207c, BIT(0)),
+	GATE_CLK(GCC_PDM2_CLK,                  0x1a00c, BIT(0)),
+	GATE_CLK(GCC_PDM_XO4_CLK,               0x1a008, BIT(0)),
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

