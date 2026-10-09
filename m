Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9349CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B8134080B;
	Fri,  9 Oct 2026 12:28:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3r8JF5JILbNZ; Fri,  9 Oct 2026 12:28:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C002940731
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548891;
	b=FxQLnQkWSlMS4+DD05KshGUVCSjGxvEzO0dyan1wFFZlOe+EdqZQxf8+CYEuM6/F2qn5
	 gzN/8hDqIClirvQNjrqTHF6FrTM7oeFls+FZF9Fs5X1soaqJ4g7EGXRXjxxOFqpYlnyLw
	 969gVjzSXKieQGlNIpSHIRnV+S9sYo5wwjBbhzU0ly5xlj+IJewnLyHxpJb/ZI5LAmba6
	 efxki/TxZu7NcyNHT8B1b2cUVKnFcfyqXSaSaYeyTEWpGCeCzMrJV2tjfXiDo4dJ7xb1n
	 0gi1GYgMrdjto+DOO2CHmCNQecUDZqH8rs/6nHpT6OCJpBl5rFt1dYAefS3UQiszxyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
	b=ZJj+QESjGSCPd5IrrwSuOsbk4JlyL0DY3fB5/NsMs88FCUqA2UCTOPzkrjE+sEQIwnXV
	 H8EKPmCSraXJVc1+k4Od7RA0hzuztB1t0354BjdWYEIWKeSObj9RSiGiqfmVvO0/Kh7h5
	 h4XeJja4IWz6Dh24AZe+/7VTYPnqqSwa6hkPKzDBwlS7fGKjRTqa9pC4OYNBpRjejT0No
	 LMsbFaYtnBmOEJ8oykOy15yRuh5DGyekKpJZlmtzak3JbHha7o1szjaefuI2lxDKeqZmb
	 3dMJ9K4XLOPNE86MwKuS1/atBsozWjBZ9MzxDkkwfg0QiT/cLo8MujnumJOI/HHnoIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791548891;
	bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lBqPTd3W2f2Tf/yZu9yZ2ARiHH7eiX2e/YlddUrzIVQ/1lGGCZa1Xh+iXI873Uf35
	 HFbol6zK24sopO+KmrZFXz4Cs4nnuqM0szbq3FZe9tvEd+YHBg0d3zy66ARLeqsG18
	 ru1ECqSsRImd8zABjVKqozLXwJPOw061QlS8WePv9mfPo2amk4vmdz2zqmW7UHoNCF
	 tnmTonb02EKP+lyH8v8/tmSKHlG4GebCNLXZmqPWkQ11VD+kmKb8dJ3poxlNDTj40D
	 IAg8C14HcCjle+idcIyXEPBkBeBptjsG4xgI1Pg1+OOjHPqQLe2i5E70hMHjynobem
	 8HMhmbouaSYAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C002940731;
	Fri,  9 Oct 2026 12:28:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9074075
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D561813DB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqFckQxtzO8A for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:28:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE28F813CA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548888;
 b=c+VDSaKXuDHThPdfTx3Xe4UXzygmDUUHq+yA6L0UpXnkrfU2ZIOj/HPIuKQYfmAb+NaY
 aoWWcNZiWJ+qpAPUT9z6sIK8zdNdsKdMOCUxeCaOwpcpUMaLTwLDPpqdhyLns6jdPzISa
 puE22bFHK/vIcJWcliDqAZHjmvtbX+pSqX+xOb3/Ao8+eHZxWcD+2ivcBxAovTj4fvKCU
 6pB3xF8ttg+Z5WcUD0vcEdViqIJo11745WKnopwL+H/Yo5W8qaNpuvAma33gRQloBncTy
 Oj62uSW5K1e5/y7gBy2hKhgpdOXVGNWLLSoyVtxjcmAHdphuKgzsU47+mZ0jbTp70fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548888;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
 b=svMJsQi0LBSPGRjGwv8MvcLGWcEL95F1MbSt3xCvpcgEOx79GFfeWcEeWCy0Ohvj5suk
 N/TQfRosu1iYK7ZblYDgFUZfigO2Z0KqbV4/HW+hSNkVTbxpoY6e37FMMKcAszYqOopTY
 78RKAxuYPgPnBug74E3URTJ2WH03EfjT8f40sUgrDlYpiXTHDCZqYaQY1AFCaCkMjapBj
 b4XcbbrCkrv5A3chjcuCbbc1s2Xf4cI7Lc8wiFbY5fGQWTbfWGl6mJZKzsrpBb4aTtCKF
 uXGlz+NSG1PSDbPaZdNGXgOMaPkvfHEY67AHWzINQLiDvQkq4v74qNNXH2zD2nR5MvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=J3r2hZ5h; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JRLsrLmt; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=J3r2hZ5h; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JRLsrLmt
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE28F813CA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:28:07 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KNJW1223232
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 12:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AjwHog1Hk6Q
 +omLu7CS+KlWnZQoigsQi+ByJXC3MivY=; b=J3r2hZ5h44s2+R73w5iGOeuXa8C
 blygpMuI7YTxoRCyFPjpABoGuZMyf+ccfAzS8DDbFm3fqpsPt0La7kRHt1YcJzWK
 JMIWkXVViCDfWjQ80jaqrAnaPoCvLIGWFtE2hS0C/Z8A1DKQ5z1lCxfRZ8lUHuan
 4fvNuOBU3y+UhYalMnzzy1hjcrv2siybhEWaUt3Xm+WSiFon4rOwshHXqof9iya9
 menecWHUd2t3aodflU49HcEc1QkHjFn2B0IvJP8iK/+huQr59vjJIvU8lJ9r9K0p
 RYvWKZ2adbGaUKrhjmhEDbY8zZky2ZxCKwrQ5vAbOHus3pUIa+xcsn7A4dQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkbe94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:28:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39e3c10ac70so8444979a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791548885; x=1792153685;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
 b=JRLsrLmtGxItVBFF74D5YPGKQeeGl7TU+QXyifeSlADyvcT64hjcwJfozkCQmjJwgh
 IxtmWm+9yy0JZ+c/DO5BpwN9SqTEphPelnUDA3t0vIwqhTgaDQ1BcqS13bxbLr1SnOGx
 +W3qEe+Z4krKhzT3gwpkaByDWozA/yCZDqGpPxxM3f3ZzGJyys4vctzBSToCMHpFZFxW
 HAk8i64sildLAw/Qnmje/+Vk32rjWsoF4x+JdaTcV2giGEn2pWkw1QHTjGUad/l8m+0R
 5/FJoYZFyo/2/U4Q5fOP8gwNQGFwPMWQiMtP6KdA80Ic4rLEG2Nvwjb2qAHUCoYE6zFl
 2fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548885; x=1792153685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
 b=sLjpl+fzUfwFr5oPFndhQjQW/BoNbI35tCzpUc3QI6Jslby0fhnNV6EhXsr2zrREqm
 dyb3NiJI0g7klRF3TYpL3INT6Bikh3JZvZgi5N48MBKkQMsqOxCbhg0oDLjvCKCFTVed
 bV51vKM0oSojZXYAALSy6pD6ThA/1sdFA2T5+FZCtcqhHavNJS6SETDO4MTON0QlR4zI
 61oYiH9pP1cbRzABUcVH2MPCjhct+PIhRquSwFQ7fpkM1ZqWSQLTF6wbA+PwYK72JKH7
 cIZ642WztAnVEO1r+DnO38slrDe8JYkFlbauraOECtBr0FkGWLuCmYd8BzqupeCSd7+I
 BbaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwurFWfTdRObCivr0hXYYil8qRhxwvDkpBO+2rvoAFlcJuap9LTt+b9kjombHW52Rn0kb1d734=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJqY2swGbKs9k2FFYihGCtZeENbvbEw6eTwplowJJb5lhrIz9p9
 M2sqkn0pu7E2KThvzyNbK/vR3TwIA51mXXsEcR24TyYCpJ5vORhCzA2T14bRNgJtjhkxwgI7t2F
 PuSA5HMwo4OHKfTXVEz1bvkuTR2TrRxM/krShCAo0l7ba/9IJHcTRvPc7CAlDG6S3I9aNENc=
X-Gm-Gg: AYBFou3Zh58fqOHHn0if+NOAVTA4+FlzaGN+0nsA0iK7dVXXezsEf3pnaZmxDXizAmc
 02s3jVzS9dqYs1GBG7GgtOkMT8yRjI2nr2L6JTbGZLCgAtzI78tsxSAxRGQ/kXg3lt/ntgZxVhl
 2pDj936NykqtbWSoOwyrSMb1IJWXLrmRd41SQMB4vCy00vZABqPl0lwPdC1PY9mCQ/8BTqtz7Gj
 aR8A/jprppKTN8ZT/5D0WJx3QFH1iCl22BmhliiYfYnq5x0YzMIzRa4VWTx6hI67fOSmsG0Q9Ws
 CFbhsyhKDXdJAyeQUe3EYLg6y9vnDL69rOvVPrdKRVggUWMj5OXg+6O8j9GBnllKsynCNBZu6b2
 FSS+5J9uvTkbHQbZ0CDOxGN4PTJh9bMUxwuJ1i66SecOpvUGbAFa8OAu+KmizOiady/XMnSGw+L
 zRsSe+ZZUsXtJ9IW748Pw=
X-Received: by 2002:a17:90b:57cf:b0:3a0:7cbf:b8cd with SMTP id
 98e67ed59e1d1-3ab3a955de4mr1729421a91.14.1791548885082; 
 Fri, 09 Oct 2026 05:28:05 -0700 (PDT)
X-Received: by 2002:a17:90b:57cf:b0:3a0:7cbf:b8cd with SMTP id
 98e67ed59e1d1-3ab3a955de4mr1729310a91.14.1791548883016; 
 Fri, 09 Oct 2026 05:28:03 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371b2f2bsm3399497a91.15.2026.10.09.05.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:28:02 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, badhrinath.s@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 xerikasxx@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v7 3/4] arm: dts: ipq9650: Add override dtsi
Date: Fri,  9 Oct 2026 17:57:35 +0530
Message-Id: <20261009122736.1185878-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
References: <20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OudRYIPTPGW2R1Kpdv46TQI3q6XlG6jV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX4D9uILHR3zhu
 Lyq1EPR6YboXzZsPCOAp2ulBVG7+C3RslE5gopYai+nBBzLC1ePxjeAyzv5poATtjuV8K+093Jl
 EZbw19FmLiHAF8gVO37Soa39kUweWHc=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8ddd6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kOoMYcB8HEV07GVGuZsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OSBTYWx0ZWRfX55lZcxQw3R+A
 nGtS1eCZhSUmiJVBJ1RvOEaw6pG89fzR+77I/gS5eJz2SHH7iuDs7Cxv2G5ZjQ6K4irlOcwsj+f
 HwjbnwfnxcgP7rJ1nNG1xAsp1gN04Pc4EHcZ2jaJaduG+4ZLYT8CitRTVjWCeWNrsnDZi6cbGoB
 0vjzJXjUKF2cySy4u42S8BoZVFKKi2ahSddGGSx7d8s7n0ge/lvlXIkk3rUWNw5+MjD2J9WOua1
 A5gg6rvhm5nj6Agmg6qy86FXx3nJ/eGIgtch3l4WI8MjYsIZlVyev7Wfc6AWaV3f7MrbnkTQs/Y
 RK1FngMO/1Nnz4VlXwr+UaasAkfkUmQ93h4hbn7dT1uPtD76u/HnD6xEvt4koJbLkjBceCNKMu2
 xSkprpqvXHxYCLy85VTWCUQ2n8aH4nQ+0Hq1dVRYrES8YB/7AqFMXc4Idb6vrc9LdtFpSH2gSTE
 cKalJOeI1DJmeMbyTbg==
X-Proofpoint-ORIG-GUID: OudRYIPTPGW2R1Kpdv46TQI3q6XlG6jV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090049
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

Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
This includes memory configuration and SDHCI reset configuration.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
new file mode 100644
index 000000000000..dd03de98b921
--- /dev/null
+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IPQ9650 RDP488 board device tree source
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+};
-- 
2.34.1

