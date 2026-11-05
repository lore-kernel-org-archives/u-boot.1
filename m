Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28860703EF
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PfRFLAUD;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YFqs5PP4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W6u1HyPw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6234581105;
	Thu,  5 Nov 2026 17:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvCHaAd63U_5; Thu,  5 Nov 2026 17:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF81C810CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793899097;
	b=jmAXJ/47SUf0jj0MoxHjswguqJzNxiNgKJef5BD9WaK1ylm8V6PWNWa8X4GFO2zYQlpk
	 VWWTPgrJs3OOHNbT8cydsy1UjsHkYku/+CtdgX3hNjLxGbFZp6Kp84IX0/ifawaQzPTSt
	 pOS7stlG9R7KQ2zPOsp6+fSN4r7PLhLMzevObIIzAJW0gi3CliqO1fYhHRX6j2/lF7MlA
	 YZWjMkRteFnTU67sLQgbjWD8qeAORmfOaGU2VTMdm0jD0ORaPntTaFlWJ2RRA31sa0uQK
	 nxrOXwiiQlJB+pmV8IwpgqAbfWpO2sT0dTAAEpkTw2UZq/BoCPUblsFvDec5xhcFs8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NktdGlRe1Ktby7v6H1lLPjSaweYIbJbIXM/HKn9ZFng=;
	b=CC/AerriTsCw6MkPwaGWUM2Jgvoeu3UxzYpRBhkizDfD/TwXd+6l9DToIRCaQmODY7ng
	 5QAMfuxHYv908XMup9Acz0HTpqqbYfCzqvpPr6YqnPQhi+OM+lMZovCkXa7kjs/FF05nd
	 qZy2lU/WCF2x+KsP+ypcA7NAX99CBtlq5nMmgUz6i/BWlyEqAB4OKarbLGmpJwCKnR+rn
	 SwDvSGJR/bQQMHTPUwVxuLvN5thgRRVISrd9yDtB1BDTtt9ZfzVfji8/eWCeKHmDVowCI
	 A6Z/zgPxoCxCVqbOGc3QXPkB/DZqtOCZmXEmrmonOCPtSf7xKf8PzZSnhimQWwp4kCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793899096;
	bh=NktdGlRe1Ktby7v6H1lLPjSaweYIbJbIXM/HKn9ZFng=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PfRFLAUDE+u91RQDHtgRlsHw506LvUTr2BkWaeAKN+JjLcH4Q7jRv3eQjx80BbFB1
	 os1Oxvawg3PcBtv6BE39RcR8pr+QABdo5JnlJuS78057etkANE+TufNSBzAa3OXOnh
	 B4GuitM8JqCaVvO4VVaooncJ+THRhGdtHu60kT3el1s86w3UUy1Sr1o/Qz9Qb5h8C1
	 oXwZWd0ftx4IpF8HdnNujZ3XYsRASVq4CXxm/riSUG48C8X1P3ZIi7TA9qQLOFopPW
	 JDbnVov6GPjkXXhp98XMgFQRUo01Cq/jVox3ffHCPvWGmGQzngm8pf5rBtPK7NrybQ
	 cbZb4VAtMvxQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF81C810CF;
	Thu,  5 Nov 2026 17:18:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B94731F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D4C140877
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klJiAGdzDc5i for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:18:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D781C40875
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YFqs5PP4; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W6u1HyPw
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D781C40875
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:18:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EPvdn2081396
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 17:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NktdGlRe1Ktby7v6H1lLPjSaweYIbJbIXM/
 HKn9ZFng=; b=YFqs5PP4/E10UlDf16Pr0GLGzn1oASOqDwhUD0rSJhrzpEuVAry
 QxiI7/UwoZPXxaCSZNDAtoSQt1JZHGhniuVMpgZGOV0eK6kyg2FHskxK3KHnQ3Tz
 BM2uWhaGYk9PmoADMbEF4O7hGI9V4A7q2PsWeHUUoyBnpt3uwzSW/CL5eoz/kclb
 w0mqDrsNNNI/GxuqFEQeDuLmSaYV9N6+8EpNy5blTNFA72SJfanZbkF6EV6/Xz8x
 TFg3BUvVQhXH3GFcU07XAmijf75siaIJPYBsSzJ2mjzlS/Oc9FvlpdG8QETjnx0K
 jqyNKbTjjLqCGSsv4YIOxAS3WXjz6ng482g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrraasqws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 17:18:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so3582238eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793899092; x=1794503892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NktdGlRe1Ktby7v6H1lLPjSaweYIbJbIXM/HKn9ZFng=;
 b=W6u1HyPwVM4vcpkJO8LSNP8+wsq0+Y3j9di0wA21GJkLevJ+6g6jqNfi3ua/Pf+ddv
 h/5g2WU9ao0dl4H4R6p7QsBAtJm4Gr5tDw1w8oWbkTJFRhbt018oBsLtuJnkOYlneMWS
 ygEVieCRpNx0veHx7DKsUYVZjpXmux7xiZ6QsT7sIib1kKnIEE/HEjZnwvUCMj7E0HQJ
 /ykZP1ALvM9cgyFrdDa3fLWXkbDpdK3rOlsP7f3J3yd4o0M/yzEhMnEwAHnLBJDd3naB
 Af1v9hEvSFGRtZGaIc7OPISEd0oc8MbNxC1nSBd0ZXgQ/qmt7QCReOUoA2NLvuJTIKJ3
 KC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899092; x=1794503892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NktdGlRe1Ktby7v6H1lLPjSaweYIbJbIXM/HKn9ZFng=;
 b=RvmWi8VXn1VzuimAVYV4ZZGEHM584Mznv8PdkuoWaGlmY6KDb/RkTVAtltpAdKuVQf
 767w/2SRdIbOkrCDjd9aQj1pBsnblOXI3f42+IsTQghO3sqGjNP00+FXUQqA4ZwmDS2m
 ut1R1Zl6aan+GQbHjtCSKQu455C/s1snL6ytdP11jSQrqUJgGrDWTzBAkqPZv1FwPT2j
 jHJOwihBciY6E+oTjRiHuU147euIucdDjOQ2SUjP6Ln23+wZ1WpUVaMB2QYh+yb9JceS
 3ZAjFf2evukjZzQn2kVImbHJ7rsOJVhncBz477umbgwgqo5oXSzR+Mov9pqdHUlAjy3U
 nkww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqm1xmzMi/KkB5BPaJn8lFGL1TnPsgj1ouElHqa1BTq8cVGcxhgKMmiicWmIYM2TWkukoXHHU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+bWAsN3A8NKJzI47Wl7Nj4IoEULUxVn33PgIphKplaCCKvaiU5
 kzE6coxTZ0dqB71R+MRAwXhkbP591phFwwqgjgCqj/KddjVm6/RI3SCpk2YveVP6teWDyy40344
 SRLDWTyzGjxsWx0xVdUZrc2be7g2sFliLprvHufz3+HdQeyX7tBCHWS23TRIpbE6rN26du24=
X-Gm-Gg: AYBFou1HuijPzd06dCcigqh6abnDUuUJz4D4/1jJ9ZNuHk7dZZXAzj5z4hldWxmzZ59
 RID0jAwltDUWKILSfYHJGuz+TH9/DmIQoiqQRcswywrDN4FoxUAr0JDeOQxIXa41RhW8fYsAK9d
 53p4d9EPUcmKmQmtT6rRRqu+jJBHjd8vg8ZWxd1FZDgBkdJ4Y3pWCe2tOclsglpjEWwUqLs4P3Q
 LLQHEuy3/lsJ+AAiN7JJdxAGiv2m5V/F8m25oI6rPE8tTkHx+cWEYBmmZd2b+6VQM3x8lWcPA78
 BRWvLQw2Qzdz6nmolvoykKomFgVGVo0Gcbzmr9Vndl9upl9Rasz62uwRFW/g/6dXLigDOqVzK0D
 mxtW/QRGv3pf8rRu15BL6iaRy9N1gJYQTyvcK45T/c/Afk8AprqLwl9OrmilcYDqzPRZdD+hZgs
 geA9lLaSy49cDsPFyDjGrBHAyg9kaHIobi7DqB63C56TTP6T/UsJLfXuZRrJLy+NxmhcY=
X-Received: by 2002:a05:693c:8815:20b0:356:4b46:9393 with SMTP id
 5a478bee46e88-36a423e547fmr29687318eec.24.1793899091325; 
 Thu, 05 Nov 2026 09:18:11 -0800 (PST)
X-Received: by 2002:a05:693c:8815:20b0:356:4b46:9393 with SMTP id
 5a478bee46e88-36a423e547fmr29687270eec.24.1793899090628; 
 Thu, 05 Nov 2026 09:18:10 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3785430sm24923271eec.3.2026.11.05.09.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:18:09 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2] mach-snapdragon: skip reserved-memory regions outside DRAM
Date: Thu,  5 Nov 2026 22:47:52 +0530
Message-Id: <20261105171752.2344459-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2OCBTYWx0ZWRfX0o4O9loGkJRR
 whTFeO44ji2mb9MKwK9sjANHeC0Q1n4JKNpm0D7BceIHvwS4Xa0RDL3QDxK0WjVd2/S4VHNhCot
 UVOvSUtExMnbA2lol/V51Toq8eD3rTk=
X-Proofpoint-ORIG-GUID: VcIdhwt30BVqH3fSv2TkWM9VVMnaG7lX
X-Authority-Analysis: v=2.4 cv=U54Hnuru c=1 sm=1 tr=0 ts=6aecba54 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MCfFqREL0UPkeaSH4fQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2OCBTYWx0ZWRfXxG0kRaHNWudj
 oYvWAAF65SbZj0CrcY9kf/qGIX6QQsu3qwS2McqjAcMDCa5p8b4dRnz14j7L95LimwOnuN7L0v9
 bIozIoFTaNY7TDTvQfY39FTopTu1tbO3ptSAVXhT63ejh5GvjJ4bgMljBmNwvyOFoEQbVKaI9MA
 r3hqeor0tsF7sYpkjrdYrDcWd9jAccpU0zxyOPu+ggF8Dh/tkhLBT0/3WrrNAyNKdaHpJnFKZID
 TgPygkY2PhWukbn5WE7ABGbW3FovFkre4o4ZoJGW8BkkNIow4dVdEGM7s772hFKHHdsl/t6ZbnQ
 QsFTOhnug7wF7EXVZVTNORPcJEStdU9Hq7fJK7o5BbbRc01sruunEtpJUjGYn7AyFQn8sjht7SR
 BTOdChxn0KR8FATRPGfAvMmF9fIGJn2E960PGeQ8M62vCo1Be9WHOkoRhJEbf5ZmhbAcL5uRCqv
 nF/3jT+HFuOWuw0ouVA==
X-Proofpoint-GUID: VcIdhwt30BVqH3fSv2TkWM9VVMnaG7lX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050068
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

configure_reserved_memory() updates PTE attributes for every
reserved-memory node, but regions located in inter-bank gaps were
never mapped by build_mem_map(). Attempting to update such regions
causes find_pte()/split_block() to fail.

Add region_in_dram() and skip reserved-memory regions that are not
fully contained within a populated gd->dram[] bank before modifying
PTE attributes. This preserves unmapped DRAM gaps and avoids MMU
setup failures.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:

- Drop the previous approach of mapping inter-bank DRAM gaps as
  MT_DEVICE_NGNRNE regions to avoid reserved-memory MMU failures.
- Fix configure_reserved_memory() by validating reserved-memory
  regions against DRAM banks and skipping regions outside DRAM.

Link to v1: https://lore.kernel.org/u-boot/20260917091932.4150797-1-aswin.murugan@oss.qualcomm.com/
---
 arch/arm/mach-snapdragon/mem_map.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f3d2308b4bb..7a7e0c0160c 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -83,6 +83,25 @@ static int fdt_cmp_res(const void *v1, const void *v2)
 	return res1->start - res2->start;
 }
 
+/*
+ * Returns true if [start, start+size) is fully contained within a single
+ * populated DRAM bank. Reserved-memory regions outside any real bank were
+ * never mapped by build_mem_map() and have no PTE for
+ * mmu_change_region_attr_nobreak() to rewrite.
+ */
+static bool region_in_dram(phys_addr_t start, phys_addr_t size)
+{
+	int bank;
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS && gd->dram[bank].size; bank++) {
+		if (start >= gd->dram[bank].start &&
+		    start + size <= gd->dram[bank].start + gd->dram[bank].size)
+			return true;
+	}
+
+	return false;
+}
+
 #define N_RESERVED_REGIONS 64
 
 /* Map and unmap reserved memory regions as appropriate.
@@ -140,6 +159,19 @@ static void configure_reserved_memory(void)
 			 */
 			res[i].start = fdt32_to_cpu(ptr[1]);
 			res[i].size = fdt32_to_cpu(ptr[3]);
+
+			/*
+			 * Skip regions not backed by real DRAM (e.g. in an
+			 * inter-bank gap). These addresses don't physically
+			 * exist and were correctly left unmapped; updating
+			 * their attributes would panic in find_pte()/split_block().
+			 */
+			if (!region_in_dram(res[i].start, res[i].size)) {
+				log_debug("Skipping reserved region 0x%llx-0x%llx: no backing DRAM\n",
+					  (u64)res[i].start, (u64)(res[i].start + res[i].size));
+				continue;
+			}
+
 			res[i].attrs = attrs;
 			i++;
 		}
-- 
2.34.1

