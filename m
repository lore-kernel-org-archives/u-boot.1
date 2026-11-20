Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C23606A330
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CTgHnfDK;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MmJnQ5SU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TZLUQBEY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8339B816F1;
	Fri, 20 Nov 2026 13:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yDQhX6ECPwk; Fri, 20 Nov 2026 13:21:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EB3B816DF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180885;
	b=dLQjUyQPVhIruBZOKJQwSy992DBlarU3qDhiCPexSBpl4tzhCio1wt9eGoEIqjFCD15L
	 EPzC2dXWqsTzvPWYDZOIAhW/hvCl7a9JPZbHxzo1HaF54HAVaYQQcpDEbRRNjmshzzyKn
	 Xc4EO69H48fqRsg7+eTCT6Yl/upIhdy74oNd1UiNCHASPvgkAH8VY1e/b/vCXezHmHEU5
	 0gd4KywUTO1W0GJhNd5Oh89m0H6WSeYH1Hl16R5O2lnq6gTI6rQ0Hlt6e5qXzXt6iJIDd
	 CHJrQPYwkqEAywokbo2ilLcH7A26ZW7wAjBQsVwWRcF2HEVibnbKCOnqtqC4QJ6yJKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZvpQBXP458PoMuVdgDu5Toa+u8O5H24HYdr08v0JvcA=;
	b=H0H3e2rXCH0o7o5bFrVQEvXoCS+RpnFVfIPs6sj/zZGJYHgTYKVNA/WmFpq505lYuh3V
	 cRZCkeVO0CeLOifEqzTuqLoIBV2uNFfTwqkEsHSRz0Ibd4PjBEx8/RK9ElzeSunaP35eG
	 vF5Etg3ITVOkOehTfz18oenyGamSSyqb5rlEkCWoLjKC74ZVOftUkU5JKw8zD9M5yK1IY
	 0S8nK9sic3rjwL6KMmTUMQ66jFybc4Rs5FbHnckh+C87qCILhP+3DooHNeYAIdDOgjKm+
	 lWxiWHGMJY6twOjhXU+BtP4/YKQHgisa65bjz37xpj3/8vo2/BhfV/FCfXkPgkHAVxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MmJnQ5SU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TZLUQBEY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180885;
	bh=ZvpQBXP458PoMuVdgDu5Toa+u8O5H24HYdr08v0JvcA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CTgHnfDKoeqpqaxOSQSC31B1lZm0ykLRGwO5v0z5K2xmOKUg+2MK/4FBKeK0HsrsQ
	 it4iiHPO+Od9fyONAFKMa7XY/WsF2e5jaMVvL5Pnengk82SgUD6xEaqExw23Nm6R4M
	 gAdGdDCGXjOKSA/wRogAP+3uBgy8ZCoTj0gTwGsDbDqQpikyWP0MyZ0l5+1QuyQc/v
	 SYc2DHgHeJuHG6N8zVMYe+XSJqa1QXu/C9Lx8s2cqVlhrDYPq08cvGuPl/Iu82L1HL
	 IldADzu+pB1hiSBLIXOZddZl+YZ2o85aJxtKOnBFhiQeu3EuLHhOFKhLJzslkaN6hM
	 jUJgZXvs4J5bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EB3B816DF;
	Fri, 20 Nov 2026 13:21:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0527CE22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA89D8134F
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ICg0HMwbfrjK for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 10:24:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7636A81310
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=MmJnQ5SU; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TZLUQBEY
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7636A81310
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:48 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7eqJ4144492
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ZvpQBXP458PoMuVdgDu5Toa+u8O5H24HYdr
 08v0JvcA=; b=MmJnQ5SUoDXrwxaVTyOxswROdz/3nRO5FGoqCk5TAhk/t0F2Uq7
 7lDUO6sORdDxzElQPouHGWr+yPVlA7mxMJ5Lp2rqrLyykYo5xuM+KhPDzan4xDeY
 ZIqeIzXcIZHwG+5fi7XQwTkzUwMCMjZ1WvnIst5Q1EXnYy3WfszTp/XdWa6F3QuC
 zlyqtC42/nE2fh/bS98HLmFuTeMNdCeAHNYZXI4SmbHxP9xAqSxtRVt0waAtq54f
 357ZMKakC1R8pUEs38I10GiXYJYJ+7nO1KXYVmskQFhBcUo4S1EVuTPsN6OXQKMU
 jFiCKjMmK5voT4byytgXO+GglVmJaZinCsA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbh94u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b25d977b91so953768c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795170288; x=1795775088;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZvpQBXP458PoMuVdgDu5Toa+u8O5H24HYdr08v0JvcA=;
 b=TZLUQBEYDQ0+GKKxkmCYHbagMc+nohRGAbZs2dz8p5Siu8oNJEfpiYNIc4dAAr+ldJ
 lFVSJO6dCxAGHsDyktHwNJeqwLmnIf0onIhJVBxLPAK65u03QFsti+rDNCUS5QITI4CP
 pMQRSpApdvRgd1LeJPBYyXmfkJ5ehDeZMwTpwcOrXftSFBdnuwMAN1NYxWP4NDQw5FMt
 AailpdKh/UNI3k1FausV/dTqNLo6tQAjrGlhjyOdCL5qvjsxnQzG8XAJjQ+Pa7cgRHue
 2e+CI0qgi7oA5NtWT6UieiRcvLIcXbek1PvcNj8+HpzUR/VPGXZGmWUy3PPXO6qg2Fos
 Q4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795170288; x=1795775088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZvpQBXP458PoMuVdgDu5Toa+u8O5H24HYdr08v0JvcA=;
 b=dU7IIXG/kZR1f3eB/w5qzaBzsfndLNmqyo+Sx1B3jPB0WgCnpr3ROBV+TkZJf+rLYy
 rAsZMzPty0Lhe12T4+BnQR1y/MX6G4Bys8IaT8MAQP0SG4Zbtojz+A3vTpIUVmSK7RGP
 TZYudJ82u3SWSLMh8hv17QVVGIuUGL+BbWx2us+bRBUldL5rvOA1W68jdPozrNJWzfXl
 iFe6yf3O5YMBZTb6JFI1R9lN6gGE7xjsFybpKJlYncQ2zUJBQWIeK3vr1hNCJwD4jgjc
 DG7vYgYwZqQXiw+HBW8elKen+zBpylu/nWn3bdO3f1c2iMk5JYEUr7G4vVd8SEozgklT
 OHZg==
X-Forwarded-Encrypted: i=1;
 AL+hErFY6Khaqru683nDoR2L2IHtPcxqkA0Cbw/UjQk30utfuzBF48yNiqyK/USootINrHYRRfwwGsc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+i4OJ/AWrsg9EE56wPED90vC69iN3L+A8ziODJCfhN2MOf22kq
 G5CjHQOuR83x9KG0V4TPkIsbvRelp5yIBD9chrll43SHSNbVnekFXSiZNMLMknjQD8G5mS/8Q+x
 oPF+Hf1+yLjXbUl4FQjdkePRbKFojT7uaqHG6XIS1Hsry3KK0Dmxg3RhQYcZAIrSHm1VYOX0=
X-Gm-Gg: AYBFou0kJVsOu24u5TfciCkJ8HcohT9SK1lM/c/22w6LKnBKp9JrEf03ohQaMvAgFQv
 dk5OjLWGmyJ4/cUEh2v7mNPbN8FZPaLW4fLO5kHxEfJyOai5j4IlkO2Csa0ReXRLA3AZQ08r+Cj
 2bHEmybhT4/oTpe4lKl4SuUeiWl7Ste8Xf/5C9mfv/UvaXFqc8tLf4Oy1l127hLS/VYWrEv2dL1
 aPuEAd+sk54qcG9Ls3R4rc6/ksmljbSnOZjEfZbeayGEr2+agCzWwP1+aMypEueQs6zKmGeB3wk
 XO725z/PAmWlO7Ts9Y+ETDQCIFevCJJNxeIP1Rup+SuvPt1Ly4lnzEMWF+ZXD/R02hbYfHhVEG8
 PC0Cx+CMt5c0cswv5Ha2xiA1KmYE3F8MwyMU49ax36Xm4SglQkR07Vx7KVNgkxonAVszQdS63j3
 mT/FcIpc1sp/d0DSpvRyfwsS47ahVoXBpd03yAHwl5xwT5NeLNSmjZjyP10qVZoO/RD2k=
X-Received: by 2002:a05:7022:b058:10b0:1b5:330f:6209 with SMTP id
 a92af1059eb24-1b5568a32damr2330456c88.20.1795170287638; 
 Fri, 20 Nov 2026 02:24:47 -0800 (PST)
X-Received: by 2002:a05:7022:b058:10b0:1b5:330f:6209 with SMTP id
 a92af1059eb24-1b5568a32damr2330438c88.20.1795170287124; 
 Fri, 20 Nov 2026 02:24:47 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556829d31sm10618487c88.9.2026.11.20.02.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:24:46 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 abhilash.v@oss.qualcomm.com, kr.sowmiya@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 0/1] board: qualcomm: shikra: pass TOC FDT to BL32
Date: Fri, 20 Nov 2026 15:54:37 +0530
Message-ID: <20261120102438.1382555-1-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX8AL3awz/D/h6
 nm1qSBlrHF3Q1QmTIO51j5pvKMf4yLA1Dubqcf9/UB5COoqpfygbSA3dcrhLe15YY7BY9cVU+Iy
 mQmG2WPHm4ki2gww5BkugkZq9IaRBnteZPKs7lF2DrDRbatvqan+VrPOXD5ovN+UIKo49c9DxW6
 +wnTVnJZDVuouo4Qs2cCt//Ife2hvH8AbEGqL6j3BYFQeOhiW+VtmhmMJT9vgtizXHSbObRsJRC
 5Mz8xBZAq6n5SLEVBLw3pS3rWQblR7U23xcSIw+GXlxUSZHdnUx5giZdqyTBPPkcoxmjcCb3z3W
 8dzgEVFZeyoD8HFGuGO8tBki7hrZXWkxzTodEGyZMzv7w77w3jh5N+TswaJDFPZj9lP43UR1rih
 wvQzVyr/DUIJ4I5ojBx8KQMfEA1pWfvhCpFEVK9uPc8b+k3//nwbnwp2+UUPTwq6RxHguYvbPRz
 wdHePJITpEqHzfNvfbQ==
X-Proofpoint-GUID: oV6WOGjVetu1iex6m2KOOHZM_MZADQ3s
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b001ff0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=lmuu5eLEHuFIeQ950IQA:9
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: oV6WOGjVetu1iex6m2KOOHZM_MZADQ3s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX9+3X97Y19cwV
 vovn95dJWjjVoid8rMnfTv3RWbg3NKCE3Wdi1ikN2NlAIAq03q1/OgT2HjBQp23FUZ4KH+0JDil
 GdkEgNL5vZzanDxsxIWI12YUBCAgfRQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200041
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass the optional toc_fdt image address to BL32 through
arg0 when preparing the TF-A parameter list for Shikra.

KR Sowmiya (1):
  board: qualcomm: shikra: pass TOC FDT to BL32

 board/qualcomm/shikra/spl-shikra.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

-- 
2.43.0

