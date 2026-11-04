Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F253606A337
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M5ukllw/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPTLHRWP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAQCkY9x
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22BE7408F4;
	Wed,  4 Nov 2026 16:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykesMbMa4GsV; Wed,  4 Nov 2026 16:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5332408E3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810259;
	b=gvFyobWL27A1d9d8XIY02f7BzHI0RWgo+wNemv4sd/SUTLOswuvL7jeuIWBULtNl2wfT
	 5d7Se1JrW/gQ/Hr8RUlP2oLLxohock9YCRIq2UV5h9wBI0fq93PwymziBvQKa1W0vDMNo
	 /VWp+JiSowopI5ifHeLchEQbfD25imPNTWxzfEVMXf2DtuExAJ31EbBdiVZLT6oqMoCyd
	 s5Oz15Sgix+qCFNEsdIRoN6QaozyCx97Y844h6cnSgOUcNEVdhrllTQY671zo3pgtnhNB
	 CELT9OxKbBcUn2grlEimPdP3nuOfnsytrznLMNCrdtJ6ZKZ/dfmvRNS40VzRKjZkx/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DmUnGB3W5d/hk65v52Dbf8FqqXWavqZk/VE5A0Nehn0=;
	b=CAdgMkGBO3205BBXmXzSSQgqOmKQElh8oMcVFlaI8BmEKd6V8jHB/q8PFTC+fqAmnZTD
	 v7x2QtO0Gs4v2XwVIdhKxQQBsiB/uoQtwn4CW85x2QKNLgiBmvPG329iA5v1cG4h2QQT7
	 uodvA7dsZ1hl7qGOq1zrZlRfMl7rj+UbVh5uRZ+1onnDWFpXR4G/c/D2hbd5b7M9C7LPl
	 YwuiQrGiS2mvIpeVjKXZpIm7mTat3n2HHwl344HrsdIkNGrHLvEBLjGIt8EAEFxuKxc1h
	 X6oXVp3Hlgi9FBTzqN51pD6SgulMokLYhRv09c7+DbFhSc0+n6XeXhvQewNM5FlVoZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPTLHRWP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAQCkY9x;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810259;
	bh=DmUnGB3W5d/hk65v52Dbf8FqqXWavqZk/VE5A0Nehn0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M5ukllw//7FXao6IsaJX0K8SGQV/DwK3/D+z6w97k8lZvjukFydWwdlYZ5yqSxmVX
	 TVCn32Vujq612wfda0sk8/I86Vbc07/XYUVeTh8q6DCphAQ1Bpj5LNFCC4Mu2wblg4
	 PJwHb9I2bT2mdaVp5ZbEXgjxBd4Ft6Ku4SQ72bTBPgK+8eXSq14SkTui9c2jsEJJhp
	 4W62IzwBOYOaolNL6iUxSEvAZin1JgVvbzkIEtCGnhCCNWbP81m+7SIMylAGud+KUC
	 9mycn2GHPaHvGq1HImi2jRY+nYSgOxJfUrGRA8PPDRtghcHiXrld0ycZC3N9IJXhh7
	 3p27gsErmZ5Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5332408E3;
	Wed,  4 Nov 2026 16:37:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5C62341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7318403AA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tw38J-bQyVLG for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:37:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1755D4027B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPTLHRWP; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SAQCkY9x
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1755D4027B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:37:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj0j81148893
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DmUnGB3W5d/hk65v52Dbf8FqqXWavqZk/VE
 5A0Nehn0=; b=QPTLHRWPco6a7I9i24eax5ZNnKkjhQzuXpeS8ZiKoatHIlx0J1I
 nWE/JQIWfWASsbJ7fLsENjUSA5wEerxAXHueXUnojgkJVnb2Ud+OkwUW46A0kNLG
 G/GZLwR1HLkj4pvlPsLYqO5JihiUURO5INJOg4IQ6/b3OF1PUhseKyWkUbQ47qlQ
 0/PGXngDIRBgmXeVLh8A8PuCiSWR6NbM2ODnqU/2O3BJVdSGXvbUowmM/BKh+oMc
 v20o3qKHxlx8kopB33oA/7ago15oFF2/4ag43/dlA2+Mc/T0nGcwMntG+jQfvcg8
 KzeVxrhBqmgUUuzhjHlqXA021/9hRSczDKQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3r818hv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:37:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36cec75d8caso840509eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810235; x=1794415035;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DmUnGB3W5d/hk65v52Dbf8FqqXWavqZk/VE5A0Nehn0=;
 b=SAQCkY9xa7YYq65Ra55TE0HeruelQ0XqBaG7sJXaD4IhCcpf0Yec3GhQ3KSuTKzp1S
 zt4MsUMfs+p4jiynN901+lQK38VNT0z/CN0WVX4F2xdARsboWm1AWHH0zthTSnxkvZGP
 YlUfBAuupoIFnCGGZDaG2IOwC8qPIGjEq1CS8cEJu7vzRXMqrvVrWCjQYvP4ZZkTsfO9
 L6DvsZEVDe5ZM/ojuKtC3jijbUczH/r1TJPnYXCb0rUXDE454YqOqm1RxYEyfc7XoEeu
 exo0SuZ5M+QTdzpJtg1M+9golzTixjFPXunGiX53Jduxih+aSoAsHk/BuZFENxRcehGs
 ZJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810235; x=1794415035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DmUnGB3W5d/hk65v52Dbf8FqqXWavqZk/VE5A0Nehn0=;
 b=GBWxp0iSxVudlYKv00eKapYCETDIz96PhAEq0eWKToba553TpdAiAgZZN3wXem8iQE
 Gl/dZ2yBZf55yhs6jZRr+svYxhBcsygWrKyhWLe6rSyljxwLritHwdmvfmcs8RR4NZZ/
 +T6AN7DduUAv4kj5RxYyCdaLXyq76xaXl49krfyqjhaFRtrAs8xrGccfB/0npVBvozMv
 1uKt4uEgB6kegpsduamUnpbXnJ5F1on0u1AIPb4kjmBMzM75B8wL79tH70Rwk07Tg9uS
 zGxaPahJsiVsY6tgHj+21lQgTHydSTUKb+Ri4w5qWkr1jeZw1HQYJcD2E7lQO+3Hn/ah
 p1tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsqWyaRVgGHGDTQYli4fuPGd84ipRsJYyhlYgueYBVqnR6N0eII3apHZzjZ7nHu0xM1wzFnT8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+bqU9l8vzRYGcnEOIewfHa6LgrSg3HuAmijc0NWsqLbFOlc+q3
 ACk1+i+69S+vdFBjx5WpRxEhUv7Si/NLd/zlmbS8QdcsYvuNGjiNO2ImrOpY6RIaqcVAl+6Wogr
 a5gY1jFHrWWV76yFbSFvWA8coizH3y6mYdbOP8aEWcEoQfUtn5S1OaSwLhNITkLkl+7qQOmU=
X-Gm-Gg: AYBFou3CWHKtLUbQMEQ80kaZ6Rj27u8n4WN2lcSNI5HWgJx2ihVdBMcdheBEXLbmAUp
 q8ThGDCJ2wSBCRZetunEKAuNuucK2FcPHusC5iDxeiEjYcsXCFqCXApp4IY0kH7QGsq/Ho8gmp8
 zPIrY6bFGqFctFDDAe9S0jO0Ef/EZpO9nysxc6R4WLolZ0YMICbpCKFJhcvqs7Z2FWI881DnepL
 HofpZpic0fFFu7GU+vcs8LZW9OeWaN7/uk5Q47m7nE+ZocgGJ3bZnovDJ3K87S++RYXxh6Ug5L7
 XPIpgF6+sK+ccdQ6rpw95+XUDesdkW0anoxHmNCiAD14cn32qRMvfH8kYbrK8hGStUmayfkGgTp
 ZKo/Ea0c6mgNdB3l6gms8u9KsM1COfxEI9BTU1RXz6WgObpQCJfoKHBIomakcfKh26ySwRkrtTA
 SqLp7MojS/F8/myUc/1K+z/PdP6JCWJkKcodgI7/KBKObJc70bvrgoaiopCOWk5EPL
X-Received: by 2002:a05:693c:6316:b0:36c:9f5e:9bb1 with SMTP id
 5a478bee46e88-36de6d49be5mr5717eec.17.1793810234487; 
 Wed, 04 Nov 2026 08:37:14 -0800 (PST)
X-Received: by 2002:a05:693c:6316:b0:36c:9f5e:9bb1 with SMTP id
 5a478bee46e88-36de6d49be5mr5683eec.17.1793810233790; 
 Wed, 04 Nov 2026 08:37:13 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3785430sm13057153eec.3.2026.11.04.08.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:37:13 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: bmeng.cn@gmail.com, marek.vasut+usb@mailbox.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Subject: [PATCH v1] usb: xhci: do not abort on non-zero residual length with
 COMP_SUCCESS
Date: Wed,  4 Nov 2026 22:07:05 +0530
Message-ID: <20261104163705.1252892-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jxcDOBrMeP6gTENCanZ-x1SVrMu9-Lii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfXz3GFWTlIBUCY
 J71L2Lk4XLQAalZ8Awyo9wE5DxrLoUtRc3FztPA/0pdBGV9oobuWdFNJhNocRZ7XFNFf3MlffXb
 8f7Sf5Hs1x+fuDeCfao2dmA+spCqSjCF28rAQOUf2SY3ayjD0rD9jB57elNmA2LrQt5q7AsBm22
 EL7inR+YzkXtJRIpSCzDpDxtu86FdyxRuCyPgVBHmrXvz+oMaQifyHNLO9ceT4TwkCfkkNRwQlI
 8PMm9OG+oEDBTEuEXYn95a/MlYFdzLaRSOz0SpRBo+e20mtBSDZnrbYFBpEQ4r07++MZeWEqPdp
 45449QLXn2ZbcETUL5Mq+alTphqw6oynxiwqahPhiZZNkybWxgRD4iy8hTmPGl4uNc36gUcdZln
 KTJNx9dwwokFTDkR+Ydp40WNTCTIk2zIKRlb1v0Tz9Piq71G6DwKNkleCIZs7iq97T1IN9lHDZ2
 En0ijl3MbkX8MgHaZZg==
X-Proofpoint-GUID: jxcDOBrMeP6gTENCanZ-x1SVrMu9-Lii
X-Authority-Analysis: v=2.4 cv=UuP2pOwB c=1 sm=1 tr=0 ts=6aeb5f3b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=OwP28WNxrpaNvI_VbFMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX/+ZWrV/pLWyh
 1KSh1c7/ghv2usSt5nVOQceNs1r+8dLQRHsQpdsIAJl4EDKaP+gPdQCES9OOPsCVyduU3A/1X8Y
 O1Fkz9/z1/TzFsy8kyElVwl4pJK15Ws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040066
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Some xHCI controllers report COMP_SUCCESS with a non-zero residual
length for chained multi-TRB transfers. This can occur with large bulk
IN transfers used by USB Ethernet adapters such as ax88179_eth, when
a transfer crosses the 64 KiB boundary and is split across multiple
TRBs.

Replace the fatal BUG_ON() with a debug message and handle the transfer
like a short transfer. The actual transfer length is already
calculated from the residual length reported by the hardware, so
this avoids crashing U-Boot while preserving the received data length.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/usb/host/xhci-ring.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6f5c4ec97b6..bd88544977d 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -601,7 +601,14 @@ static void record_transfer_result(struct usb_device *udev,
 
 	switch (GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len))) {
 	case COMP_SUCCESS:
-		BUG_ON(udev->act_len != length);
+		/*
+		 * Some controllers report COMP_SUCCESS with a non-zero residual for
+		 * chained transfers. Treat this as a short transfer since act_len
+		 * already accounts for the reported residual by the hardware.
+		 */
+		if (udev->act_len != length)
+			debug("%s: COMP_SUCCESS with residual (act_len=%d, length=%d)\n",
+			      __func__, udev->act_len, length);
 		/* fallthrough */
 	case COMP_SHORT_TX:
 		udev->status = 0;

base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
-- 
Best regards
Sumit Singh Dhami

