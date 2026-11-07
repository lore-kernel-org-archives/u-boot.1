Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27F606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0I3GXQWt;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GqdiH/zT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bGKsTyYJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6FEB8195D;
	Sat,  7 Nov 2026 12:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUnjIxIVzG5l; Sat,  7 Nov 2026 12:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2225481684
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055982;
	b=YMBhvfN0vz/U4CAw5IorNFxgynOGnhYN7pY5hYiPXzurgd1UE/CJt+SQgazEpVnzGHj0
	 DxeVkcKNieo/66Nk9TkfWUUqs5+1K9RRLOfDeMe/JpkvPLdPloKeH7T9VZJ5yGSgKEo5X
	 fRGAtyVUY+Xw5XA8nhWAlY764koHgtDrcnA/yhVegcYyfyTTeBS8/rA1XpOpac9qiEE+g
	 RlM1pyFvOk6kP9um5ZTmoGUKCNFwn1FyHopyFtqW8Sdw0y3g08agcRokcw23n5w60Q8MR
	 lroASFp2zrShDVWDEoSD/Gy8Xj6ceEuERIPtBheDh2dpsxCZgz78SqY0eL/fNHbDXVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5/M/RQkLNtJ2CbpZUwZwiJBz0zI9bGo78eztz3oDaXI=;
	b=AWyMdTqgcqeZo8CTrLPsR3JmVz4YDcab/DnPsWnJKGlrGFILKd5Yuek0G1ezStsXBof1
	 qn2an77vgJ54aFgGiTs8HiLu+/PGNF5xMO0ZMQE25JCjMuwY50IPCygVTvalsAwehH8a7
	 fpsfyftWvuHzMNG8xyutHWXDro1o1YIqHnb6pEwAii4fcc7maVXHrYWAUmwSM0p1jpxro
	 sUqE4fOeiTv7gz+lTx/AbCS23KYWiHfCPVBhv4gORvBrJMAZRi9ZJA1TmLUuFQ5Z571hk
	 JU9EuXeevnnXRYPcUG/0K3ERq4emxR+bWTDczntVHHZPXdts3OGG0USiLnMt2ZwSzTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="GqdiH/zT";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bGKsTyYJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055982;
	bh=5/M/RQkLNtJ2CbpZUwZwiJBz0zI9bGo78eztz3oDaXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0I3GXQWtX8k57vyqfJupnf2VAD47KXVBz/T4wn7bktawXEHgDg4wfMiEwceTwrJeD
	 /P2/rZgz6CjZWqx7SSLtzYaBkH7vD7GcKdiuXC9oCngFKoMXPpXD9fb86oFxdbYS7W
	 OvAWe5FiAt0m+TWPEFLyU6LoK1BLXOAVVUzPcRHZ3KQn5WNqDKScX0ltGJfGCfxq4+
	 lz+5sjS+quqwnNwu42epcOs4Hjh93q3S5Yl441OeHKPUEf52uT/Vr70RCYP8nwrAls
	 ulU7S2TY/2LFGNWK/6cgjiJHfDeGvflTiRJs/c1A/GBrfFpZ+ifdmYUWUqfpacGcFy
	 jVjwCfvTTXz8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2225481684;
	Sat,  7 Nov 2026 12:53:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C75F81C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67A2B81295
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUUR1LDLMDQS for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 12:52:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93C3F811DA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GqdiH/zT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bGKsTyYJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93C3F811DA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:52:57 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7C0P2C3686146
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 12:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5/M/RQkLNtJ2CbpZUwZwiJBz0zI9bGo78eztz3oDaXI=; b=GqdiH/zTEA9Fn8gL
 0w12iLEqbejf0Vv25ybxhvncY+3DacXZNSmoH14mVQ0xOUeYUs5BGtULHdSbvD6H
 9sIg8ZFmn1AXOE3SVt0mpiKo2bu4YQaiEFnf72BnoGDwsMb6hgwsEuyupJEvQLU8
 x1MDRTIu2jku/AazmZw7Cv1o/uPupgnX+Xy1iym/f143ixPrNwIB89KyhBViaY5j
 M1FzKg+JIb7FxvlEH+tYFO49buZdpjNmr1MV22ZHaFWWPn7/7AmpCSTzwu0PlIK+
 lxJcXl7Dfx2nlLtmoRb3ri1l8dh3KsSl9+rwtiXipW08kVapKri3+R67s0C42EWp
 KfGoFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf17ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 12:52:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f13c143c8so308733985a.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 04:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794055975; x=1794660775;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5/M/RQkLNtJ2CbpZUwZwiJBz0zI9bGo78eztz3oDaXI=;
 b=bGKsTyYJaQz8PhpabWCwotbpik8FK+leSN7pbBWNExX8tdvGvTkLo9Vj1hg/wPJVer
 WA4Lu+Mss6ktcxDe1STYAayZzErP/4/mrB967J9/yz1asQqibSPpG5rvKtlGxWcd1bbg
 DktZ94Vvm4XlZWOEEGXXkTwVMIr7tU3TAeV9VSv2qOEglg9KLpT3eW914lzCEf7Qw9dt
 HEYPR4FunUwfesbjO4i29XkU3teNtWMxnmpDjjVenvjXXvZE2guoeNC9JyulLZ9d7Tos
 l8p5oiMz8RrVemyngLBLqjpAt4C9I8AEPRI47kKRLGXikKuGahqpH8noM+WfudamjOV0
 uDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794055975; x=1794660775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5/M/RQkLNtJ2CbpZUwZwiJBz0zI9bGo78eztz3oDaXI=;
 b=r3m/4u2YYuLPret1fe/3BTt6Rmei3IUB6WMzNerYteZBTEhrczbJdfRo7QMH2Lb64S
 nYTRIzeMlXKDxS8C6B7fvSuzrMb7newbbAyw5zDCmg+VUg1NR8n879I53gK++8kytL+Y
 BH+tewhvhdVOp9zSoknV+Qen4K3CQEl3j18SIXK9UWkQz+aja6s6sU1AOua6mjOJhny5
 j6sk9ZRYzbBlDTkCSkJdF9L2aGkPtdvOHkp6/+xp/7JV/sxknRaeh/SFUNb8Bm02B2Np
 yVSqKVXtP56QY4KEE9NC2grzfr8gjNEkRj+CQuqsNSt8ICQLDEv/aIG5Z6yQMD7JyChT
 KkRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz39tBdo0MfWGyCPh7UDRkELr59KYcs+oKbcV0IPQhoTqSGgk8TXzBgUre13r7G+OfBdRMMzFk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1jVDdoTFM2+uTuAyDlKisQ7uPxLxKoKhBMZhcRdkGIJQZT2Ho
 LKjLyB28M5quW71jDYSS8a9VL0JViPfrPOIZL7eiiiHOBVtgqDe5+K3VJVg/0spiGc7bGFL11MC
 fDm4JLZyktOFCT8SwXcxVALtznUvEV41a2js+TQocgPvHJQqNBkTJd3n4tF7ByQv3X4rD+8JR71
 yAiYc=
X-Gm-Gg: AYBFou0tDKgktQshYanrOUBDdGOrDnh/5aw+6xVsGjOLaSnaLIEEYPjczWiia1lX6rn
 NJ2DK9XanxWwcjmIpuMUDxEfB9nbXFWZMNAVLGa/KCeYaP9zVpzq0jhrGGAKv6vo6v7JTNbiNyJ
 RZR7PNnNN31TXN7l8pZ3uKPiUN1M9HF4AnhrleABRpRuTF3K/DD3lhu0QCZvaVRGjm1oj+8kgfi
 jxfs+NBgR2w4w1IEMyEKS+H7h1U0bC4oqN3ZyjaPYVxl2RZ1nMN9XF6pyWluI5dGcRQB8ied2MN
 +KheGfYUCcu8xjvD3AB8U9sLsEsTQUPqwn/THiHcSGUbBsnICJ8liswPkivtWE358TiI669XpuE
 5IPDcpt9mtNEk2C3i9pkBjuTFWYPuLtdT0r3IRaUTuEb9Cn6ltah+TmpSGuHbSXZPy2VtAc5g4Q
 Rum77NTW9F2/KO
X-Received: by 2002:a05:620a:4404:b0:936:e18d:763d with SMTP id
 af79cd13be357-945f32cfd32mr812539585a.8.1794055975394; 
 Sat, 07 Nov 2026 04:52:55 -0800 (PST)
X-Received: by 2002:a05:620a:4404:b0:936:e18d:763d with SMTP id
 af79cd13be357-945f32cfd32mr812538485a.8.1794055974972; 
 Sat, 07 Nov 2026 04:52:54 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356c3692sm148599966b.66.2026.11.07.04.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 04:52:54 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 13:52:49 +0100
Subject: [PATCH 1/5] tee: sandbox: keep zero bytes in persistent values
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-upstream-avb_tests_b4-v1-1-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX4KC0JvZLVRQA
 1Icb5cCLnNyFCR0JA3kbHTIIreR+dNfgKgD3v6ILxfJvmfjewNwFhoRePot8muLEyJEe08vwVUS
 dJen95nwlHFNv5opeixNVM67ifkz0AM=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6aef1f28 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nCOOllZ5MXPi54-k6nQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: yrBZvTyI0YteVymHSmFUG89mXYjJ1uz4
X-Proofpoint-ORIG-GUID: yrBZvTyI0YteVymHSmFUG89mXYjJ1uz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfXxFxC+sKKXJQR
 ZLaecM8DA77xUnIUZW0X1c60behuDr8XNxPevMF0Mc/kQov8+iPR73Q+qEBUXRGWEXApPd8XhSB
 J+nFDVgMuAcjFhavhgCC8gxscYEfbHBJuRnJwjBnNwZr6jG7aL5WATa/Mr4wKkORaxv9RMwhuz6
 E5vo5PxxW1Y7TknxL29NE/oumaCsn19GRG3OPBCiOA3DuFoPgf2TDQfehncyy0w6qk2ogPVmdP+
 EgMvn9DYiuiVap5kkmFTxiYJABwGn6utx/Jtrmi/b4hY34re5XjGlY5nEUWWFCs9BxIQEt0CXtX
 PxRpdiVfpxc4AvsmEcqYx5nvoEIFnDqhZqDTzNOfWGcwDUWBejpk48W5nlMEDOnERa/p95YfSPJ
 f//ws/GmgrnXsGmGDaqeVjP+KA+W6BbUPZKR0IvKMWjDSgeJpwWNAUyLyvAVwOCwhZWFrnifls+
 HmzQ65+QUBjVLFoosIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070051
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

The emulated AVB TA keeps persistent values in a table of strings, so a
value is cut short at its first zero byte, unlike with the real TA.
Binary values, such as the digest of a user-provisioned root key, then
cannot be tested on sandbox. Store the values hex-encoded.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/sandbox.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index 16e5d95616c..92e74add3e3 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -4,6 +4,8 @@
  */
 
 #include <dm.h>
+#include <hexdump.h>
+#include <malloc.h>
 #include <sandboxtee.h>
 #include <tee.h>
 #include <tee/optee_ta_avb.h>
@@ -268,7 +270,8 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 		if (!ep)
 			return TEE_ERROR_ITEM_NOT_FOUND;
 
-		tmp_sz = strlen(ep->data) + 1;
+		/* values are stored hex-encoded, see the write below */
+		tmp_sz = strlen(ep->data) / 2;
 		if (value_sz < tmp_sz) {
 			/*
 			 * For TA_AVB_CMD_READ_PERSIST_VALUE2, reject
@@ -287,7 +290,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 			tmp_sz = value_sz;
 		}
 
-		memcpy(value, ep->data, tmp_sz);
+		hex2bin(value, ep->data, tmp_sz);
 		params[1].u.memref.size = tmp_sz;
 
 		return TEE_SUCCESS;
@@ -311,9 +314,17 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 		if (ep)
 			hdelete_r(e.key, &state->pstorage_htab, 0);
 
+		/*
+		 * The table holds strings: store the value hex-encoded so
+		 * that it can contain zero bytes, as with the real TA
+		 */
 		e.key = name;
-		e.data = value;
+		e.data = malloc(value_sz * 2 + 1);
+		if (!e.data)
+			return TEE_ERROR_OUT_OF_MEMORY;
+		*bin2hex(e.data, value, value_sz) = '\0';
 		hsearch_r(e, ENV_ENTER, &ep, &state->pstorage_htab, 0);
+		free(e.data);
 		if (!ep)
 			return TEE_ERROR_OUT_OF_MEMORY;
 

-- 
2.53.0

