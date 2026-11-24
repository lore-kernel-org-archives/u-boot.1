Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22E606A322
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RnteHGwU;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PgNN9bfV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OxlULp0w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 550FC607F2;
	Tue, 24 Nov 2026 05:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4CdInYFoVox2; Tue, 24 Nov 2026 05:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F80D607CB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795499939;
	b=C6J3iNiAu8+B1vz1hbwkQT6bCCoC5VkoRm9Q28HHEZnDKiTRQsvam9vK1FTD2HvIoDGS
	 vdxhoa9a5y4G+ZLFjDsbFJlXkGLcDNg0JbqksrU7sAsXLRBA9rWQqKnDdXwmBnmdjbgoV
	 P6QLoolxftJtEbrpdIOtAJPzjdZvF5zVhtH7XbllHhs3NUtlwPAVc20risZ74pRbPRTPE
	 oTE3cQdssWUHMHXPTQ7VVr6UjmUUK106qoDgD4OUFX2c2DiOqMdGAX6fE3uqhSuGgqu0b
	 xFb+tXBCjhEBib1esAms2JWmG6LQ9Dur7clFFi+QT105muqiyFimVuhwnAtNOgI1x0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795499939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
	b=eJOS9S819vrpOeyCQiNoObrvdJkdRC2Is+DuZlo7bbdyEyc4Rg3yIgRi0Jb54pjY9YKO
	 VOaW8eqaP4kPF7TAfDliV8bRsX4Icgqq/doxbNMOHqwhosBpNLf0kIEaR0FqHOBcwRKCE
	 Mn96rEfKoE1wyE5qGo6u9fLGZFPLbyhsD7vAnQAbM7+a93sYrkoozM4+QU1hIrGVDrcBf
	 mncLMUsKQiARn6ZPEzpz1VQ5JmTr97l9qmAnlAsUSjQAz7XqAFANYJhRnZL9T8Nel0z86
	 z3p6okS9DWYSR2C+pTIcMYxTa8HA6xPNroZWHGmvDOD/iOdkZjrnW93xjFm2yzz3xOQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795499939;
	bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RnteHGwUwhqkh+NZxwfH4QrVA5dw3cKgO5LyIFLFfLZi8yWRffxTSQmzi11G9Vu0y
	 G8YXnvtlGxSMo6FWcUOefbG/u7OEM8hske/f4GKeGBOvlN86b0ucUbl2P5FRlPHfoV
	 FsfkcXpF/PVeuuB9iC1vyhZusEmZXjNxvrsXUMoARWavr81OKEbdFjUNY0+Qfnth1q
	 DkvqD4wni4DQEPU1kD+dWIVE7WwF45FWGtP5cTMijX8DrDwBRZ0F5aNBYjYTawS9wL
	 5j7pLc4gCy51jljolwCTI3FOPChypI+mrXpO3xDtmWch2OkHD2r6akl+ZIz4QhWnFL
	 1q3oqTiTFx8nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F80D607CB;
	Tue, 24 Nov 2026 05:58:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3284A3C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22EEA80D82
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XgNmfWseFCAt for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 05:58:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1067580F39
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PgNN9bfV; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OxlULp0w
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1067580F39
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k5we3225345
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=; b=PgNN9bfVzNzt2ECv
 OXxf//EA1v3IDSik79tPdQaepvMfuFKM5RctiPMqjKZq+zMO+V7In2zFYdlsSMY9
 bIo+LeqNDGifkCJSdKT20DgMAeToUp51eNyR6LdfqJo0jaqMzbiy6u4Ro6h4DPu0
 McLf6PTsGk77tyyBgcsr4ooNOTQBGUz3nexRT08v3B/7OqLuKXI76u9PEermJB9p
 R+IFwsfqQOsKdxZHRiYsQE7Uj5TF//acn6u+kRG1DvMvoyEyHuNZWWEKVMuPLuMp
 Wjasdo3BV8NmAPA/Ru1Yc9DWOl+OKpGUxcuNEtHV/abQ1akYSNUDaqBNe8gL231M
 Ke04zg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f1dyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386177b0516so11057210eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795499936; x=1796104736;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
 b=OxlULp0wV0ZuLsMNE1H9oB0TCOl7cKTjlk8CSuWsI96tVdO4kr+FNh4QYmyFJE4wQC
 mey5U1K5GytmDMIQ6N7mucRkd66jBO93OCuhy2AuDVhEecq+MIaYMPQGTqrMdKfutgc4
 LdsCRQCzzRtbTdnfTiVgd9SYJ5VwGOI19kj05XuZWwYXz7CidSCz/SbDdgoYAVLuxs32
 pMRbM7trXASzGPUOYwd5dX4JaqH+K/BagyaIeCkehxtXOvuCSEpBT1eila7jFcm/KRBW
 LQdUmk+hg8GCe5sJDw9dm5OpnKFeVHzR2rYnDfyhnPVkEtMRJ5T7DRnkYJuLBNiK/1Vg
 sucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795499936; x=1796104736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sv77wKj9ewGEDdqzGaUSCkPEkXPs1SETDBYMVzN6nKY=;
 b=KfAX/ydzNeOperbV+ysmqw64fNbBSo2y7Z8zEHsAvyMPUAC9BkU4zACJohNqHnWc2m
 ukv6uoSuZmvKmNwFki/raIpB5UaliwCrOnCWHvqmuKEpaDhoI2m5SpEzV+i0DftftAHD
 +UBvfwzdz/xeNuT7hd3+sQFFmtuaHLbzuAf3y20UCoS3G9wPLEm+r7SNuEK/cI1mcUw2
 Vzd29cEU/Q2L3AFIaz5gDPyZss9b9kDVruhUPX3GPtbXq4X+dAE14ZM2RtzK51DXxR+Y
 stbUAGbed47h1BjltrtsuDAoE1SBhdzoq9XMgt8XDPBkYbbjh++KUy3p5gDNf8mM4BQ/
 n1QQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEOiiZstlm8v16b3WKhHzYptrh7aqjJlDVQGySkSIPQjU+u+J/KEHt17XWcNfdtXdU1H3jbCXU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/twXbLoRQlhM93mlEgAaZCxuFJqyybw4qyUPwa8BccJoO/j4E/
 ouNfPLy9WAyspckaUH2ReCsMvRXuJYV5KaKtoEK7Ln9pBPF3I2dN7UONtvPdjvGzdifvviwsrcw
 yJTBiXUlKk7rAkJeJ2ynbvCiWiDLc+eUhssWYBHQDb+GE6tzfx7zmgrPc47E+S1aaBOoUA8slSI
 70zf8=
X-Gm-Gg: AZFdTZcF7fFR9vN3oolqh6HzmX6pB+o7P81gisSyp/zvLh/r+sdejoHJVyacPkd5ho7
 rmQKopyqMBu/S4IMfGyw2dfPYUYUwKAgaXUxLBkVx6Ezxw7+JyEeFGtd5IjmPPB4+W4DV4iuAef
 6wxvgETw0JdDZlggsH7UeFlTUSXDr2qpZXqdjAYEH31zdPFFzDORsv1MhIOt+sFE9gFTmrl3+xQ
 vOigfyaqtPFNZb9CR/bMhwVeeD1X4RqVH7wzKUHwkSMC3GTZP+Uvw39vJpX/7JuhElN+A0GBMf8
 4RZajnwZFfghr79RZzIGxvy9lBX52F3pME/HDv2Cnp7P9EbBMFNjqP6Hua3VXzrgWqAvODlTUT9
 ya7ZNN8OspfkPRkNtW1vO+FjTLTKXIklDmaYqQ/VL6QKcixMdZMCS4d/ahLCNVmpv4Igl3cmUgn
 roPwVRsNUrkq0Bhz+bBpzw386UYOiF4TT9GFOS2OGlcUTPj8/eSGR+PLfIYzbKnKt4tqAGMa9uz
 rem/A==
X-Received: by 2002:a05:693c:88d8:b0:386:954f:7c18 with SMTP id
 5a478bee46e88-386954f7cf0mr11388329eec.31.1795499935432; 
 Mon, 23 Nov 2026 21:58:55 -0800 (PST)
X-Received: by 2002:a05:693c:88d8:b0:386:954f:7c18 with SMTP id
 5a478bee46e88-386954f7cf0mr11388309eec.31.1795499934922; 
 Mon, 23 Nov 2026 21:58:54 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm34742351eec.25.2026.11.23.21.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 21:58:54 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:28:37 +0530
Subject: [PATCH v5 3/4] tools: qcom: mkmbn: Add support for ipq5210
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-ipq5210-v5-3-b509d2b05180@oss.qualcomm.com>
References: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
In-Reply-To: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfX6I3T5YKzs2xa
 hP935Dic8zYG63nRsGStzekX68dM7ak1509cZgibDxJHXLkJ5Q1730qaNXTU1AlibGXK9oEyOgp
 07XBQEsRDt8SLjmauaxGGoQwe/KyvoY=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b0527a0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yH3UP6-NtsxmdlPH3hAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: OQUyis0oqXhY59R3mg5h8UvJaxtZG_SS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfX09IKEAHFWYBY
 ypsO/Vz21WEFTJvc7nGh6AN6xjnNIYyTns4wEmbDs+1ZQukuvmS5AU0SYGOjARBgrVodWhJN2Uq
 yALPpBPq9Ffcvj2dK+TTahRXt5ReuH6LmY3s49Cxlk5BH9WjTa7ivJrzC8AlN+uy9fq8Ak8zuxn
 tUJS7h2sSOLpPmzwDsKyQaCHVUPUDAiVIyLKHWFBsbLwFTQozYKN2HgzTaEFDKfNI8WA0Fjnynu
 UdgS4H8RKtEq9I1xGDrSuRK8wSrxaXcz+HHkCyoR8ZPUvffj87GqGVJp7nr296BSm3LJZxKsa8m
 hXOLpN5xAlKqSKBvfQZ3H2wSsR7ADzOugzNa9vOvoA7sHxAScMZQ+AANWZ8Ab295ag42jb6A0Vz
 xjaePox+wz/g9eguVQvmWiXucGHgtUHf0KjSgfYI2xKPSEzvgoXePlPrmJHHq6AYx+Rk/izbFlK
 NAwZu6+zORLAxiWDo2A==
X-Proofpoint-ORIG-GUID: OQUyis0oqXhY59R3mg5h8UvJaxtZG_SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240023
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

- Add ipq5210 entry to the 'boards' table
- Add an argument to specify the U-Boot Proper/SPL load address and
  drop it from MbnData
- ipq5210's boot rom expects the SPL image size to be 4-byte aligned.
  Enable the mkmbn script to pad the image to 4K.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 board/qualcomm/config.mk  |  2 +-
 tools/qcom/mkmbn/mkmbn.py | 63 ++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..1752b651402 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,7 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_$(PHASE_)TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 8d2078acc30..da4d45b600a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -18,6 +18,8 @@ import sys
 from enum import Enum
 import struct
 
+MBN_ALIGN_SIZE = 4096
+
 verbose = False
 
 def log(*args, **kwargs):
@@ -56,42 +58,40 @@ class SwId(Enum):
 class MbnData:
 
     # sw_id 0x9 is aboot/uefi, the most common
-    def __init__(self, loadaddr: int, version: int, sw_id: SwId = SwId.aboot):
-        self.loadaddr = loadaddr
+    def __init__(self, version: int, sw_id: SwId = SwId.aboot):
         self.version = version
         self.sw_id = sw_id
 
 
 """
-This dictionary is used to map a board or platform to the appropriate load address and
-other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
-data should be filled out here. The load address can typically be determined by looking
-at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
-for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
-at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
+This dictionary is used to map a board or platform to the appropriate MBN
+metadata. When adding support for a new platform to U-Boot, the appropriate data
+should be filled out here. Looking at similar platforms in the table below may
+help.
 """
 boards: dict[bytes, MbnData] = {
     # Exact matches for boards, these are preferred
-    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
-    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,qcs6490-rb3gen2\0": MbnData(6, SwId.uefi),
+    b"qcom,qcs9100-ride-r3\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
-    b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
-    b"qcom,qcs9100\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
-    b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
-    b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,qcm6490\0": MbnData(6, SwId.uefi),  # rb3gen2, rubikpi3
+    b"qcom,qcs9100\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8650\0": MbnData(7, SwId.uefi),  # SM8650
+    b"qcom,qcs615\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5210\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq9574\0": MbnData(6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-    b"qcom,apq8016\0": MbnData(0x8f600000, 3, SwId.aboot),
-    b"qcom,msm8916\0": MbnData(0x8f600000, 3, SwId.aboot),
+    b"qcom,apq8016\0": MbnData(3, SwId.aboot),
+    b"qcom,msm8916\0": MbnData(3, SwId.aboot),
 }
 
 parser = argparse.ArgumentParser(
@@ -100,6 +100,9 @@ parser = argparse.ArgumentParser(
 """
 )
 parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -149,10 +152,18 @@ if not mbn:
     args.output.unlink(missing_ok=True)
     exit(1)
 
-log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
+if args.load == 0:
+    error(
+        "Cannot proceed without load address.\n"
+        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+    exit(1)
 
-elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
-elf.ehdr.e_entry = mbn.loadaddr
+log(f"Detected board {match.decode('UTF-8')} with load address {args.load:#x}")
+
+data += b'\x00' * (-len(data) % MBN_ALIGN_SIZE)
+
+elf.phdrs.append(Phdr.from_bin(data, args.load))
+elf.ehdr.e_entry = args.load
 elf.update()
 
 # QLI boards use v6 sw_id is "aboot"

-- 
2.34.1

