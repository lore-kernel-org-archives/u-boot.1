Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A81EC79FAA
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 14:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4197B80BCD;
	Tue,  8 Sep 2026 14:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-Bjkprqs8CU; Tue,  8 Sep 2026 14:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB08280BBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879367;
	b=ayp67XO29gYiMn9ePJHcsrQT0jy3wKe6lgu6O//78614xv0TsUzVna6e0xSsU7/83CLb
	 ieGqI8sRfxVZYYv/V5lJAkVzalU4oY430f4etFuYMGaYhQbtMwP12P6zLIgfAUve1m6kb
	 l5nk6IOZYIb7YecacNUhxZYLbBAh4wL6cRqiPeYdvaKmFPUZyKqvNo0cZbxJYc6jFTWG+
	 2IPTGK52kBNceo7PPfqPyBrrN8FzsgwB1MQvtVhCClCOtcytX8peV1TcCahFIGl4u5hdk
	 bdslW+NJzlUQ9SkPb3gpOirEXWQVhHPMhZnZvI5qMZDks6e6mVfbLwGh+sJVmiScVaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:X-Google-Original-From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YVn3zWBr6seisRtADkcJwdwSZWqEHvIzNbMJ6cOpZrM=;
	b=dbSyphYqn0DYyg8KG14cQ03l819da2XWjAqDeP9MNy9EzJWOgKzngWuPvmFJ9VeNh5Od
	 Kue8tnAIv6cez+sJ+PedC93P+9cwvZq+mkQtI1lQjwayJ7S87g6i0JgpVW5yYD1CI8STU
	 yyE2rTY+pvi93WM5fNJmUq2FNcgTdLakO/U0SqdkKPWUEO9k4Z0DYa279YGT1GukzWMWR
	 9C4gfhHsKioEr/8Du2JAyXs1BHrNT1nzwnaX/muNJyLbisAT5OqhX4x+swMmsD+QmY3O6
	 gbi3JCAn8FZWFpU36sgydUTgGKQfPAee0tbL4d/W97XPdfVOx2KaJHEV+kUMRmHIAnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879367;
	bh=YVn3zWBr6seisRtADkcJwdwSZWqEHvIzNbMJ6cOpZrM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vwSn5aaoVcWJ1uw9QfBOMOHGDLVdJjg84211OAWCSPMAXRiFUOwlnXwLjeXH2m9/3
	 0qSREpuizYu0iv+KqzrTDKMlfqwdJi4ITaOAdzc8fHgJHQIJjsGNFcWQ2pM93aVF2D
	 X/dHGAJS+/+o01go2V8fbFg1m9RHy17ItbXZFKOBEtDEdNoP/TORy3OwH/mA7JezU2
	 bc+bPlng9O4M1iqWpIWo1UaTQ9zvf1aRQTXAIk0jL+FSrGkaZJHikf34+KbO4Gwv7g
	 quk5679ADN9u1AQrpc0JwPt4ivt+1oTSp1ru+nYH2f0rENv62EEvqCtRDvtYyGW4d9
	 nFMwjdLtn1nYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB08280BBC;
	Tue,  8 Sep 2026 14:56:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70B68D5F
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56AFD40151
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:54:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hbz3Ld4UUZsm for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 12:54:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1F84E400CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788872091;
 b=ibcXNlq/07cnkZvNUr+YZUVgr0K3pcEFcgJIQTogbG6w5lhSseXDDtot4Zo8kKH3anvB
 GoDaQ9X4AEmsjslJVF2CHyfm0+AaxGDkQhvmsfkQDTqoqNXFScubwEBEq4pSgi/e61Vs6
 cC1ce41kMiC5k0ASqILhoefA8Q9K7hXUbgiEdCAhGxlXWjToPV3urmp+TCZJ4sWyBW3SI
 N3eWylRhQb5DxrQ4sPJnFY6FHn6PdfdeqQe32v3gVhLit2s5lQvkv/9xaJcgYzqMh2zh7
 4LV91SPa6X9msJzHNWBUfH1IAVdLxMjYRtg4MM54nto2wTseYJMbIlfxX16D6bOOfmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872091;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:X-Google-Original-From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=YVn3zWBr6seisRtADkcJwdwSZWqEHvIzNbMJ6cOpZrM=;
 b=X5XaiJ+Qp94uvGSBDGUWsASWnAWhqALqOuNCsgM0hnryeCFHwhYDUwBFrPbIfg+a+xvs
 /dys06myoxaHNigLewdGOLXcytnTHy0QCV8KlHnA8LhMLW3QbcgreSNGVC3pyQ/qyXSGG
 LxQt47920iTIp82WoOFG8rSYD6FKrwT54RfA769ipRe9vd+100F04Cmmly8V6XeMbbW5t
 6alPe8Mm2vBzpNvtNQh1vHX9MqgTDAGZdiWtrvvDgxzVYmUQ/UapaxNXFpzzog8nCbZqB
 RkUThyZxYJItAg/Ji2lId+v6FpWQ47+HByybzXsswcZgAeNPyPgBGfcs5BLfiICrDqw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IDKz7e3C; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=a3lnmgyz; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jens.wiklander@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IDKz7e3C; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=a3lnmgyz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F84E400CD
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:54:50 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Cl1sm2932867
 for <u-boot@lists.u-boot-project.org>; Tue, 8 Sep 2026 12:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=YVn3zWBr6seisRtADkcJwdwSZWqEHvIzNbM
 J6cOpZrM=; b=IDKz7e3CbN0x47p7O+ODmZmrBSFmZkPLeyE9maCgV72oNKg/wd6
 DZN38KVntzcKMwZw6RYWrDcjTZnmSz+424AAyiIFW8mWuJko5r7ZjMOhNnpo2zLx
 IsH9+iQFXHQOIxMLEO/fFfQm4sJEdUTEBj+3w7YVEzsHiWmNF68pyqA9PAFS8b+E
 alOstWS90qU4Drl1AusBSZLBvAM0P7e4ONELqkLKTzhkN4C5AoXXkaDWKRyfPjtg
 uycPT582VlbNNF1WrSHjGduiNmdUhV5U3/YmRSW072Gg0K24CvxKkCfVHjdFN0Vc
 /5AmdsZQB9o4/oGQWz0lQnlcBMrLyrqOXiA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjf1cgyx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 12:54:49 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7819910f8adso3959072137.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788872089; x=1789476889;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YVn3zWBr6seisRtADkcJwdwSZWqEHvIzNbMJ6cOpZrM=;
 b=a3lnmgyzN9ujUJ7qHkjzL9cTOmHVdG17G4z3nbjAIai3DXkfCUir/KG7ELGIuOaEzA
 CPgbIz3A/ACYiaai8J6WyMFymKb4YBP3K0Y/ELK2K7D+bmYQikifGWLdzOprsd5OJ1c4
 JZVsH0KXugE0kT2u7Nz2vAe4W3T6q+L3qI3LJTbqJeHG/8gfgzyvOqPis+c1oGCtG99K
 aQiHVajTEPQ8XWepMsiKCGF4FCHZqBmH1ZAuChqasvkaFkytMHwR63l+QcElN0ZivDe7
 vXDTCoxlOOr7se8v+x8njZ/yN+Elppd/2EFl4AL+6ydjIa6VhRJfCTXOANldTHyIWIU1
 EGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788872089; x=1789476889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YVn3zWBr6seisRtADkcJwdwSZWqEHvIzNbMJ6cOpZrM=;
 b=aYq6e35lPCcqzonE2UBvKWY1m03w/20Jacb7OADK1JMZQ3/UvGbsTnSh5gCHuSw1+v
 TIgUZj+Z9UZbggixNOQT5/a6KxBemAx9an41g0211/EV1H8kpt9kM0IngxYGetS1qtTl
 C8IUITqDh7RFNrydDf+Pom/rXLwE2+YS6BVy377Na8SHUvBhd7B0Y5sttgz0ESrPVXG2
 O6i6VPwP5wRt9FosuIfeNr+LBmvAFjlP9+gc7yKJcEUtGoY8YEM93fdDqKYj/C8+Lk/+
 m869uNo1pQKMbytbYnJKHxz8dLbnqQMk8BZdZCkCUj14F3rpi6fr3n2KNnOsU4SOCDav
 gGbQ==
X-Gm-Message-State: AFuF++lNGS8Ync00daksM9jLBoE5zAZHSoNt06buhot5pNKOS4R80XN+
 b+4zubd1m9xl7NF/R5C6b3QD3aXxlRUNJivpy1BZxmpK6avE7eoEwWseyRyVeT1pe75/hO2mz6P
 /90Sa+dC5RrIykiRDPXtfw+9LbC23IzfeMhtC40iYEKEHwB7dOamjT4U3ifjOnTmByVaZiLZWC7
 GpR2w=
X-Gm-Gg: AYBFou1tdhbkjmrCXHenpM+SSRJxP+E6pK5yReCAZ+tGPc+huvlF/spmfy7bBNAygWA
 zkDH9WZ/j7IwK3p2et7CpNnzm7Xn5IDX2DIMhvegz0WxYA7oltVaNWRFSSg3YzfxXGYkZMZSmJ+
 oExgT6SvT23clCw3vIHeAl1DifIkCosGCn5sJVu6LjCdCVPSUG9SLQuuShigJe61I35k03ZiB5o
 b7Y5Y7s4cne95wGpLjscfhNnBdZkMpVFwfVf74V+cl0s6Tp6SDDpZ5e8OLQmYGaqu9YWIWvjWvN
 SJs4Y5ya86AA8oEcoD5OZXt9JoylEpwVkfyd2Xb4qWdag6REJSAcCEeMUIMN+ORHWUNHWnftHSN
 9NsL5GNBG+5uv8CnuR/FTuX+OruQWRaEPAY0Zchat64iWBJtt
X-Received: by 2002:a05:6102:2c8e:b0:785:b0ac:54bb with SMTP id
 ada2fe7eead31-78a4a9eebcbmr11376730137.7.1788872083974; 
 Tue, 08 Sep 2026 05:54:43 -0700 (PDT)
X-Received: by 2002:a05:6102:2c8e:b0:785:b0ac:54bb with SMTP id
 ada2fe7eead31-78a4a9eebcbmr11376696137.7.1788872083540; 
 Tue, 08 Sep 2026 05:54:43 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e68a6e0esm5796628a12.9.2026.09.08.05.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 05:54:42 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
X-Google-Original-From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: tee: update Jens Wiklander's email address
Date: Tue,  8 Sep 2026 14:54:33 +0200
Message-ID: <20260908125438.2720215-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VN3tWdPX c=1 sm=1 tr=0 ts=6aa00599 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=YfCOm-DyAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Am4ss40yAAAA:8 a=NXpJzYs8AAAA:8
 a=KKAkSRfTAAAA:8 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8 a=RwHePtW7AAAA:8
 a=7CQSdrXTAAAA:8 a=qecH7QTNAAAA:8 a=6hizN-QJURE5XGzEQWwA:9
 a=-aSRE8QhW-JAV6biHavz:22 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=lf-hbUz_c89dky27wAWH:22
 a=cwV61pgf2j4Cq8VD9hE_:22 a=cvBusfyB2V15izCimMoJ:22 a=FqraQwd7dyEg5dwJgZJs:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=gi-vqOKiZDi0Ea6LBHCW:22
X-Proofpoint-ORIG-GUID: 3xLSQe8quB555WvTHGq_09wyVKJaQc0x
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEzOCBTYWx0ZWRfXwlncdFqvP4ls
 T6iisXXKzEEYv5RjPyP5NUvT+wG+N7u9CSN/peNkujFdXjojUpq+9sm5eb8WOrz4hVve/JgeQf5
 uCy2aBhU7Nxnx9k5F7B73j4rLllPzKg=
X-Proofpoint-GUID: 3xLSQe8quB555WvTHGq_09wyVKJaQc0x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEzOCBTYWx0ZWRfX1Za7vNVvbvlk
 pJwIqCGAvwiLPlJhAzJY4gK95lnnUuSTrLzaP0XBw4lO+Pg4OWl65K2RseyrkinFiKXQPIo06D3
 wLYy6jF8Uq9tVJl1IniGWygUev0fpM4hymxofVAWTmAzE7pFVzn0dVpxbwat0D3cC09iaNopXXU
 cholRT41mfwK/2EZ9XwjaJYX0AH7BSU7XwL7618gRVg406NmY+64ManPd6hl/vxlOv9BSR4sKrJ
 4iCIM8rJI3V4rfVcynZElyl6J4mHT8/kApnsOUolSYQxXfebzLcVBxPKfBbouCPeNOvUfDaTlF0
 1i0jnR3E9Nsv0BEkOoF+/Su3sYQgwYUSvnQFxYuAxLLJ/p6WbGmv+8c0thsASGpnmw58DPmtzXf
 QSvPcyOBGWRXFiR7GFgBpC9qy3UoKZEyp1ol7OA5IhisYziimQAeEHy9rA9gwerudf2q2tMDeb6
 M4MEgBH0J/wxIXtgbUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080138
X-Mailman-Approved-At: Tue, 08 Sep 2026 14:56:03 +0000
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

From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Switch to my kernel.org address in the maintainers file.

Signed-off-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 76ba0a7fea30..f7bdfe53f4d6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -72,6 +72,8 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
 Javier Tia <floss@jetm.me> <javier.tia@linaro.org>
 Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
+Jens Wiklander <jenswi@kernel.org> <jens.wiklander@linaro.org>
+Jens Wiklander <jenswi@kernel.org> <jens.wiklander@oss.qualcomm.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
 Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
 Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de671..125a610a384d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1883,7 +1883,7 @@ F:	include/configs/tq*.h
 F:	include/env/tq/*
 
 TEE
-M:	Jens Wiklander <jens.wiklander@linaro.org>
+M:	Jens Wiklander <jenswi@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
 S:	Maintained
-- 
2.43.0

