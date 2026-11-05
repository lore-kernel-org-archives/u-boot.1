Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CE606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HL1yp51/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iJLpyuRE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTIaV3YJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 840A081139;
	Thu,  5 Nov 2026 10:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S576kerda3wD; Thu,  5 Nov 2026 10:39:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB0F7810DB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875177;
	b=MxRg9Xp7SkfpQpV/N8jafSEIz1ixbUFTeeKCGIPYIoJiGIb57PlW3X/zjWlYUGMsXNqt
	 j0pBRJf7PlryHrHvtdGjH38H0qYSuryEFV893fPHPFagkOCBxbY3lEXIX5HSjoEGMVNMJ
	 H7p+SUppoN6HiwQEimG9XMoBexyYCHRiAfsroqzwfpVxqlvW7GON3GI99d/6BgGl4HFGw
	 W0eDZxky7LYHG1f76nbc5dmJMzyEqM96JLzDFZ05UoDsUqURraTO7ch9fV5RH28KcfdLo
	 HL2ZNd2mwFtz3T4YYrN0+pBHKCx6auuCpUgobCdeBgnWrha/hCELf7foj7QqQkWC+Jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V8PYhkSdcaojph27foPMwVVXLb56uxhY/lhjaoTwSB0=;
	b=rS4GOZW1m18IwMQ66GtxN5hxNoLtKLD9FP2iZ0eLBoekwH2XYwSjE/GpPqN9e9zN8vfT
	 vRuaT+4j5KpM+OhoT/qESDJcCH7J5TzfETIdB655Sp9yY/1uLztRRUvdvClsXRRCwSsmk
	 s1QkNJgKB4PgPORd5Fl5jn+63KnZ+OwU/FzPGNjqh/XGq6ETjePSyAYJ0RBdfH8bYD2Vt
	 67igIkI1UIi8SKEN8hi5/VyIAXj+ndPwkkySJCk8ONzpISF+jhZC264VXq8xcLjeZGCp3
	 +6segRuLn11uUqOrkV4Lr1OPZO7pb9xBlkQnI7FXfguspLNzPid528GH13CinV8ZJsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iJLpyuRE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTIaV3YJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875176;
	bh=V8PYhkSdcaojph27foPMwVVXLb56uxhY/lhjaoTwSB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HL1yp51/kD8ctewpEQlZl5oFOTbf3Xi+iUZ2ma1ONSi3vitX8hBEGE0O+GuVBjcUB
	 3D/zcRF7aS3hGJhrDWlFqRdWie0W9mFv1yO5eNMRVUOMzisO1BpaI49HQ5etQYBVhX
	 DA9z6RX9GMFUxRkVv+hjKqSRUV//D+wD80Euieb6qEEsYKo39Y28G1kt1r2UR7skt1
	 oXBSIMW7KpLhS5BZ3WFBA/xw3zaJWzsD1v9z3vMpGRzA2izdmKFDh5XYX6VrV1Cl/g
	 mznEZYmPvtNkHuI+nkGUSA0JNDUnEpLQWNaMpBCdPr80rC16mtOFpq5dx7L9F9Gwus
	 0IBlphwPZ30zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB0F7810DB;
	Thu,  5 Nov 2026 10:39:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 677B431F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D3A2810DB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AiOsbfrfGNbJ for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 90848810BC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=iJLpyuRE; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PTIaV3YJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90848810BC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:32 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tQjD4084534
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 10:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=V8PYhkSdcaojph27foPMwVVX
 Lb56uxhY/lhjaoTwSB0=; b=iJLpyuREU1e8pyY6O8M5zokVjhM/4Shf+v9Nj5VI
 cWnTtIj2VT/M+GMb7VSg2zzW6/3dsA+l2msHBIYXllAgnfLNAxdoVS1dqSW/tIMW
 9BS8jgmGeMVlg9JF++FjdzjRNWPL6ubX4h3i8/ph8EoVG5RwyR41JJYNOWAp+tuc
 gyQpV1OJZVa558bitC6R21TS7mHSmd7BX8SEoYlvBl1/z6NQh+F8Qe843Ic+fVfK
 Z5beZvz5hnBBeqhO1RYBvwIjqB9xh8LPF3Jzi8X3DkIb7jaQBf8BL7ABG8BQOAsr
 UVBnlYqfIcMfRHfQm0WiIwjNO/EblLKXmDCVvbXcfZjiAg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhkr67e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:39:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1acbaf81bebso2349720c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793875171; x=1794479971;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V8PYhkSdcaojph27foPMwVVXLb56uxhY/lhjaoTwSB0=;
 b=PTIaV3YJQ5elP+J3c4v3u4dh/4mw+S90bNB6KfBqdvcXg+chd5JAZwiH8g3IuYZjUL
 HpHkNgvM8r4ee+dOlwqTPsTcCEDc0r+D+i9bVbMePXat4cNrpUnO/NZ0emrJgcQsPSFo
 DJo3BZbwImD1sGgv4UOkmxUnlOKkA+tGHjaNEPgxRLo1J2YfUue3Qm+J7EegEc5cmPBZ
 WjndTLTgh3Ri/uwk/oG6UU+tka77XG2WgBV5Qj+lLI0SviQQfdluvunB/tOuuGg3NL9d
 IWOIpS5K2F6G6IuzqxSEkpsBlWbKwLRu4kpUxkRcxUe7NH/icexd8hBsYJvdQQAhZA6c
 PV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875171; x=1794479971;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V8PYhkSdcaojph27foPMwVVXLb56uxhY/lhjaoTwSB0=;
 b=ndPE3QFwgTiCHTu6PIugoecb7YsqtcYpTmY3DS2N/7LTTqMkqhZ+ysLmvWJOqmnhuD
 6ameKo+q64Eox1F3HdRrQOy8aBqvP5GznlHnNK1lkx60J6nhFbrCmHa0VuAqhGKGCC90
 8inxCRKld8UwPMJQ1ZntTf2DgJzT+LlPKuzZN1MO3FpgjT5wnlMQ8U1TmOplGGJolQfG
 Sr7iobVx2qV7LtGn5XiUexfwaI+cpFs/acKT5F3Oys2xM4ZwDd2LKtuL3UtdEAFvdx/2
 sLna4giMMluW15ceWCXrRUUQ7wWo4XBVSSF7wpUKr3RWPe8uMtLIgcA5Y4/IVTxQwLYD
 gSbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXrrs6mMCARET80V2zALWUmqCNQ2ewWJVxxj/mAPJYu0VhhwAlxylLBq5HBP2l+2CG6BrVLFc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9XF4P1ABnDtrgfnaUf5l0O5B6WtEUVMoaKGXJGgWhiEcxS/MV7
 6uWTWM+15DyKkIroC7+95VxSn8L88hgEefUPvjLpSKanfUy9AfQjWlkJ9ISsvoo7v19qIRNfoSY
 9LnMuNckSD8yjvxDLJBOowhpZ1GjQ7051HZ0OJuGHCbno7HqjaJPrzhP0nggINwsfJKXGDEU=
X-Gm-Gg: AYBFou0DkGer+lXdGcaA1+LIUkIdF6MZeb+Hcp/0K6MKUfsqQLKEgacxOCYU3j1pMIP
 a4B8DsPIFaixvPHep7HlJsdubJXqD/E8lciUV48rBt4zAVS3yoWqiry7OlYcdq0TKDQlTT7WXtt
 Lj7kOGPXzfp7JrFx7rSMuRaJplL+yc7rZXzbyCd4PiK7ifS7bujALadcdFR+hxR7T2+vH+6Iu14
 HbFd1MSK4kEMnRvo4Jlym3QFa1FX/RtFom9y4R2dCpxSfZDA3lvUPjO9HYAel56aYyEzjcjbhYb
 /asCPf0bk1ah11pTM/wSFEalFIcGCOvLD70BLmsQb5F0U0gCpJDXlq8qixTYhUWX127ZBn4Gyzn
 J/i/iA+eFs63OEg6nOYZg7dcww+yZJOp9g4UdmisD+/B5On1R2EWrmqrFaFBehjuDQ+Sfq99sTy
 r12uExsGzR7BgUSbE7W35eE3JL3p4JNsmccY8lXmWyg5jFwdGDV68/HjYv4pAUzcyc1z3+Fc+dd
 qfG
X-Received: by 2002:a05:7022:5f15:b0:1af:d691:1b4f with SMTP id
 a92af1059eb24-1afd6911cf7mr18857446c88.42.1793875171422; 
 Thu, 05 Nov 2026 02:39:31 -0800 (PST)
X-Received: by 2002:a05:7022:5f15:b0:1af:d691:1b4f with SMTP id
 a92af1059eb24-1afd6911cf7mr18857409c88.42.1793875170723; 
 Thu, 05 Nov 2026 02:39:30 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c1c272sm15559718c88.8.2026.11.05.02.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 02:39:30 -0800 (PST)
Date: Thu, 5 Nov 2026 16:09:21 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 nikroks@mainlining.org, jbx6244@gmail.com, xerikasxx@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v8 1/3] clk: qcom: Add initial Clock driver for ipq9650
Message-ID: <auxc2XPx3+tsGRLZ@hu-varada-blr.qualcomm.com>
References: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
 <20261105095821.3009544-2-badhrinath.s@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105095821.3009544-2-badhrinath.s@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfX6CHcs8jTxZgu
 F17pYqya2xTBFOIslIi9KajEdNykgYFIKEbEfQFOhSGK2hWEXauvYwJ/dmfM60zCDFmmdHG94nK
 EHPwK6nbCyhxj7taIHoiPzpxdu7f3iA3aYdvYXoZZ1yCuIhiNRNE19xcpgjo1iIyVyxxTHW3Bsj
 XnsJNqpd+SXlKs36++TDnX4V2bYbOZ870Ky2dEdnXxh1CANtyF9qWNSldSdNNS9o1dFVZJrmezQ
 5Y5TPCnUQd22s+PfptwMSFiG4slLxEfFSlg0nkLZKMBRoUUTOld/oYaJauvjIj0y3GGNI1fvu7L
 NHj4a5on7qc+IHy2zRq5bhj1sgb6GYazOp2zpy4mIFpeH4Qq7UvEdEb35rwmWAwU0wlpI81CQ5e
 ORV7DDMs4xRsc74AXT99pCeBQdur2jKDmZrl4bnaS2msBI426P7qf0EjyogwVJEnmiV/wX1LA+Y
 LkuRc8EVfN5XfOOdSGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfXwDcS8oG7eKDW
 cZeFJrIMj5e4FoHytNweQEIR3tShWAN/1hhD2/4IwAh5NaCSKHxS/X/+ajQz+7BAIvE/HGS1ANp
 Get7XPlqWAbKo/1LmLn/jMwlQXn63pI=
X-Proofpoint-ORIG-GUID: s1aQBj86gILv9IQ5GIVS1SbMeEZKFpjp
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aec5ce4 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=4roXp9W2K8jJTHt4FHYA:9 a=CjuIK1q_8ugA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: s1aQBj86gILv9IQ5GIVS1SbMeEZKFpjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[...]
> +static const struct gate_clk ipq9650_clks[] = {
> +	GATE_CLK(GCC_SDCC1_AHB_CLK,                    0x3303C, 0x00000001),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK,                   0x3302C, 0x00000001),
> +	GATE_CLK(GCC_QUPV3_WRAP_SE6_CLK,               0x04018, 0x00000001),
> +};

GATE_CLK() is deprecated. Use GATE_CLK_POLLED() instead.

> +static int ipq9650_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks <= clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, ipq9650_clks[clk->id].name);
> +
> +	qcom_gate_clk_en(priv, clk->id);

	return qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;

Remove ^^^^^^^^^
> +}

-Varada
