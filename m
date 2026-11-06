Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41F606A920
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NDsn1Ve7;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m5B4J3IX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LdDg+dfE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 359D5409BF;
	Fri,  6 Nov 2026 09:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2GnS1FzdF-eP; Fri,  6 Nov 2026 09:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C62D40956
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958211;
	b=Bz/31T+MM2TG/v3KzaJWmbMgCde3QvuQZkTp7lsHOmEo1J0FGD8gmvB+fIg02N9To0Gm
	 nDkvdRSy41uF33YoTf4Eqj5FdkbnRXZF71h/eZwaNIaDcN/x15Fyv/0dTUBaN8Y6nnvpm
	 3iNfFsStWj9GLZiGvy5icT7lAJ/mwKMGJ9/M6B/AjHGqz6S2yLlKH9yebc72xAh6XswrN
	 WbuwV04fM649QiqaHpPLr1CCcxVs8AWfw1/4oBRcmzmim9I8+AiQKOu5bqs0q+Lwtlvoa
	 8++GdYzu41Gb9nz/4VO5pavJgq+uUN3Ak1lh008iax1h/6diT7/XG5mA352euWcIifQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5al+WUCtr5MXs/KX+GfUI2362MeVPEPHpPov4kwMKNE=;
	b=qLTawUi9b1df5XrpVHEb3CtSmKdhXqTMk8mjEvRzsSy+4YQClW2s/iGNY29Axwfz5Wb1
	 fHqp/j8Ju91ymhfqbnFtXEX8SWuodK4hww3jPxtgpuM/18PZ8/OVB5futBX4oBJUdYYuv
	 SCgp9Up1tAZ0OtsD3BFsh9lVm/sNW3MtI3C6M0g94fohWKW+WfIqpBxV/nphMZtb0PoQ2
	 rvBisIE9DmQiyBCC6QAqPTQNxiq6GRJ8z+22eXLsbD4k0Rye08MtG7CsMFTK//VqRZbcq
	 adGXwZUWuoDxXxras3OvvB7R92i7qoogJXpx2OLAHNW+lpIf6nSaz9vGIK8xN+9uw5g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958211;
	bh=5al+WUCtr5MXs/KX+GfUI2362MeVPEPHpPov4kwMKNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDsn1Ve7YO3aor72sagMwqoCqXyJyB99lQkxi6LRA8zn/4FFCYuqXOVmUNT9aoOor
	 tHMA5IEN/AA73NWpM6PGLjp+Nk5bOHDkGqO1/ZvXDQkezuNpuoCMlhg4Hfg3zfqQVe
	 0t4Y7UhyiXpzFUp7MEn66D5OEt1zJuF3gZjrHcxcnJokoxLNvY1MII22H6m/5ggC8x
	 xCnjiVJ+t+2MfKUba+FpeWxPKIfuVQKJd3U30DvaVLQI8mxhA+mU+KHrJDLpfl4Jzd
	 FCfsFicZpqGdQf97JBr9392l/UgPGb2CvGw7HIc7RZ+oc2K9WX82hPSF03IZ5DD7P+
	 bqO3gQGM2ihiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C62D40956;
	Fri,  6 Nov 2026 09:43:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3A3B2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C578C403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGN7dPqFH7YK for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 34CF6400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=m5B4J3IX; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LdDg+dfE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34CF6400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RMe9045441
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5al+WUCtr5MXs/KX+GfUI2362MeVPEPHpPov4kwMKNE=; b=m5B4J3IXuombHjtP
 EA2/K5XyZ/wLzmBijvvV8/dSC85mghvWBtdGYb0rePHnrNmdyNtBAaxBXELDaDVR
 nfvZfI7GV132NFiILGxTdgB+WI9IQwIyVHHnpbU0mjhhNpkWVBZopyeoIhmBXO6F
 vpKu+IT5actz4jaiwN2800aPYKL6LU+Iv92CEcyMbGMdjTk41V+dzIPTSbwDznye
 jbzYbnL2M5ELq0w0P2sbO88VBuQxsnu+/AZtvwUJkLlMHca0G+Lf7WlbK0iKGnKP
 RP393yJ13Z//5jhhC9pglSAV8060myYQU82JcP2XPvuHKtqlvR6qUXLkM7Wn+N2V
 yJx6Og==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9t733-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9440b27c1feso82411485a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958206; x=1794563006;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5al+WUCtr5MXs/KX+GfUI2362MeVPEPHpPov4kwMKNE=;
 b=LdDg+dfEyCsRNqchb6hQDIhP8OCTqC2Xraqs6k9ECI9/VruLWuUCraAraWWdVnpT4W
 Bp24tCjvI0xI3clIMv9ICy6kA2MjMH/gnIuf4rK9XupfN9GNLyDIPD++VLMmu2adj3TI
 G864O2Js63g+z6057/SzEQO2G0Qb9sUq3/PEElq0/5wJnB88dmEMK3rtYMhAPB0rZd5N
 r8Dc1ATOllJf04lFnPaByisn4HTMaaansnDzbYgtxEuz6cmzibo6LW08i/beOgvSoE1k
 jRN2O5CToVFjz8XjA3GDJjoNHnZ2fiFb+ODOedQHLI4sUE7IhGc6t2UrtV5bphF8Ey+q
 gaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958206; x=1794563006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5al+WUCtr5MXs/KX+GfUI2362MeVPEPHpPov4kwMKNE=;
 b=Jz8kRLkVZJc+3SJN/3MBzYobpaAeOP5BZ856pP6MNYSpjFfIpjZMD80Z8v+24x+DtP
 RnuQsEP2PmNYHr3uhbHUzXf86H2osnlHWx0tTSTUF/vwAJMJHj8yVnLk0YNDbFDXPMxr
 7JWFyAMgceEBgqMFAmXt+d4jjv39rNEnllW+Pv8Dzr0SFlGJMJwDVEOLHcDcuwJNqgdd
 to/t7kvI8MnVo1w/ZnA3QSFgWup4OUosnJOlBvhLQiPKGD/uOhqs8+L2QtMauzXhzyI4
 I6RpfgnY4gV/nf57x9LTbB28PnNHXp9xs35wk3k9INOWMgwTUeuuClwxJD1fPeY4bbDz
 xiLA==
X-Gm-Message-State: APuU4Z8cBeM9lSB1AuR4ihYLPv5t3dnnXVBoVw+TjSeKKNEvVkrDRnmn
 i7K14k1heiPrcLopV1AuGqXSPAjVpBFoigIG3NoIHQyCtbY3zNDcU6evjWFXlSLM0FQP4ci1EUR
 ebkkCbD4D6Mna45OjKDpt9/uZN6d/oDihp8em0HqbyaC2WFMNJZ/veVL9GnCblVfeKX4CNTM=
X-Gm-Gg: AYBFou0QDtenjmvFNtW5qP1qWOdBTyRT3LMMoO3x/nyy+Ll6olx4s05IK8UoUPWsL8v
 VuykGoTDgREfUHVnERkuZbODDeWq4QqbaTPa9/bBGpmaSSKvCoQmR8gBRZwK+Pwh+AgyhruPEet
 aDOnF6G+B87Y1Z+o+AlPGWZfnCwSsbsPki4ZGsB+Yw7l+waBK6LeZREN67QNFmmAqIbW306VzAJ
 s9BHulerjnbGMTd3FD3xl2Y7Z9O6NKKjk4gSteHwHzk6jNpS7I2XwHMB7VIn0EL1ddMrKcGfdZu
 HLSorBghL6vHF4XlKawzdOP8sN61Rh2OsquqFBN6ysh++2YekHC42Pz6/OQCId44IHuaqk990dn
 pNQ8yaLp4ojz18SrfDCweqBESe/wDWrUhUK9Md1h97hAwOxb5o7Oqa2lHD1wpeAF7R7keXzEuaN
 98dqSFAXDNgPtJ
X-Received: by 2002:a05:620a:4156:b0:93f:6c76:215 with SMTP id
 af79cd13be357-945f3585205mr256697385a.50.1793958206561; 
 Fri, 06 Nov 2026 01:43:26 -0800 (PST)
X-Received: by 2002:a05:620a:4156:b0:93f:6c76:215 with SMTP id
 af79cd13be357-945f3585205mr256694085a.50.1793958206135; 
 Fri, 06 Nov 2026 01:43:26 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:25 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:45 +0100
Subject: [PATCH 13/14] test: cmd: add a firehose command test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-13-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfXzI33xzkVOqgT
 lj5Ze+7dMOfh4BZrOH7bUfPjAqKozNCCr1K14481ZSnNqgWdHrFLKdDbfqZZJoRYGgTijhGzlq5
 ZVww5qAifBiEkodiczRsNPM9Rx0gFKQ=
X-Proofpoint-GUID: 7ZUm50nfiCBfCN6nNn794bwNMJpOM89a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX2ZccaLXKZCbY
 A7kKtBqKJ+F2/50IcGKzCOxZu+aFqAOWxfq9RpiIx1nhrglXF1CZNQjCqkK4KjGJAUX2vODLnvM
 GZJDtSM6azgWec+wJsOX/8AiJAPu9kURCtsipArImX8fVTbh1L5ekk0RoAMdeDxhVAu6jIaWm1w
 Z/w66DlVwm4C/yuNY3hBWTshoITkaL+v9pM+Q+MX4S2sMYvP97iIbftR8dFDhjFxIOVNHNs67om
 xrHmbbcdulXAue8L2uVcGXY2DZO5hVA/pE5PVM4h2nmgGnpnql4JbvErpLxE9UCTB0IeCmPQL82
 s+ItURc0L/vLx1/H4OOeLdhyCWo22sz6jVzitVuEC6RsyjA6uR+xLXHWZKjppxO2+oarR8DHefw
 QHrjE4l9RVaEQFqY2X+Zkqg9fcF244yHgy4bh/NsY2mMdU+4zqIjSrEXyzdXVvk1DJPEh/sFaYQ
 1li3XuIKViZbA5HwoAQ==
X-Proofpoint-ORIG-GUID: 7ZUm50nfiCBfCN6nNn794bwNMJpOM89a
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aeda13f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=TWjx2tOTmMvf_zwj4Z4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060038
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

Check the usage, the device lookup, the form without a device and the
missing USB device controller on sandbox.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 test/cmd/Makefile   |  1 +
 test/cmd/firehose.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 79cbb291250..2b890bc451a 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_CMD_BOOTD) += bootd.o
 obj-$(CONFIG_CMD_CONFIG) += config.o
 obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
+obj-$(CONFIG_CMD_FIREHOSE) += firehose.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_I3C) += i3c.o
diff --git a/test/cmd/firehose.c b/test/cmd/firehose.c
new file mode 100644
index 00000000000..12601d91afc
--- /dev/null
+++ b/test/cmd/firehose.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the firehose command
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <command.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int dm_test_cmd_firehose(struct unit_test_state *uts)
+{
+	ut_asserteq(1, run_command("firehose", 0));
+	ut_assert_nextline("firehose - serve a block device over the Qualcomm Firehose protocol");
+	ut_assert_skip_to_line("    e.g. firehose 0 mmc 0");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("firehose 0 mmc", 0));
+	ut_assert_nextline("firehose - serve a block device over the Qualcomm Firehose protocol");
+	ut_assert_skip_to_line("    e.g. firehose 0 mmc 0");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("firehose 0 mmc 9", 0));
+	ut_asserteq(1, run_command("firehose 0 nosuch 0", 0));
+	console_record_reset();
+
+	/* Sandbox has no USB device controller */
+	ut_asserteq(1, run_command("firehose 0 mmc 0", 0));
+	ut_assert_skip_to_line("USB init failed: -19");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("firehose 0", 0));
+	ut_assert_skip_to_line("USB init failed: -19");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_cmd_firehose, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.53.0

