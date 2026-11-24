Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301F606A326
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v+pLEAc4;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dy4G0are;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfYLE+f4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65F5A405A1;
	Tue, 24 Nov 2026 16:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHw6QtBAfPBU; Tue, 24 Nov 2026 16:47:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 456064056A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538834;
	b=Jocn/EcDRTc6XNffBwvx30mPFxJlKfXJ+3VEa+SdlscyDhgVlO5LQ8xeihPh/kH9qphA
	 OTxyYgZoykIqejBdkpClFocabATo5IeJwNfNMUcYAPk6JoskvC7A0R/QNLt2LyBZCVvY5
	 E5P8KMpAC3TX0yi+NLWcLEvwz8UIAa669fcN1beoFR5Yqvhgu9QLf2cFLL21UciPK3G/9
	 3puI1pK3LY5Ya9zlwvdLjXQ2HQBNFG06J/R4bafPjyRUuV599HQRkYeVhFl6nGDi1x5Zd
	 08ukCn4mxPZke/xc0jCK/yilB31dHqAFFqr+WAyiNYi7IJ+IvsU7Wb/nIa+VNDR3nSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KHnUqciaEIYzj1bDGLX2ZutdGxNMsC6ZxmY74MaWLkg=;
	b=L/sDmWv+ztUbLSSbAxrEXT7WObHIn1zBVwHySaAsTYQsrFdkw+cYDyHZsgZ2crz3BxPO
	 z/m3aIDbhg1ETzuBqL91k0FADDsPlkDFOSoo5iZOIGhNy/wdd5EF7ZXkaZd/uQz2ZUVyH
	 3NUSu/RjwqGJbkwxUSkLEw6Qa4fMBGFc5lpPuIOVvXT32iHooqArD2+rpZn2S4FZJtrd9
	 oLaPo6Ks0/uNMRcv1DlcA7AZ86mnZEHaV28PoRhnKadAGPJamG9XMFCHfQCdxBLYVChgd
	 a83v9H0/UG4jpN9DzuyDl4DMJ9z+7vPjDNK/FtxBLwZwLgxf65NLWyYMb7VUK0KQHtg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538834;
	bh=KHnUqciaEIYzj1bDGLX2ZutdGxNMsC6ZxmY74MaWLkg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v+pLEAc4/WFkT9+ThunlC3hlDex0bevyDgtI+xWWvsUQ12Iv2yEInKMJ/hUNAWfrx
	 iwZLEAwyoDTUEgcbVvY478/d/AlxPGPfBd+GsZrHGQZHh3aO9xK558bj8k1gafSn2q
	 Lb8BSMmblYj1WyVuW7Rsqx61+y9jfkZzfVUih/hcfK9Oqwc7Bc+x/C4sBjsB1R6D1l
	 6F08yvjhMyT6HMX6JPRXWlc2X52/RFzHVQ9f5gHPRz55d796JqfMQxLJegvmYnsCe8
	 C7yB8Q2zhgY7eKQDaK0yQdvgc4DpqyOiz8rlPpi6jTPoQkXV6TivOWVAuun6ihtwLz
	 ieJX9UltUPwTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 456064056A;
	Tue, 24 Nov 2026 16:47:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B968715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0660C80E5F
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-_5b1Ripzzt for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A9C080D6F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dy4G0are; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YfYLE+f4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A9C080D6F
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL6hI1873502
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=KHnUqciaEIYzj1bDGLX2ZutdGxNMsC6ZxmY
 74MaWLkg=; b=dy4G0are98i2aPiWsSohvzZqkin6wL2YllqZ6J06gZYi2lx9zaJ
 VCA52Me/pdJ92s+m9Ffj2fE46/c+gexpoIy+QaRXE9oJ9vpaY2kAiliCBQkR7yeu
 8cRV5SWLQ+rw/6+KYAFBlv2NXkkDgAvxOl6B7EcPlEVANwVepFujGpX26Hv9oQpa
 xUT4kKHqgYfdijG4uXnbA75dxseCg+fQiE9v2uxx6josuWKzNaDn94LUFEjeL1gG
 ymPk3cQeYIXTZh+vvwbaACRG0OrVKIvpo9BRPDgMbqYIsEQXZgz03QTW6X3TAjjq
 WST1UFc/+cfxAJMPcq/k/OCaAkowOybFiDQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxk8f3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-38531c1a566so4249921eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538830; x=1796143630;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KHnUqciaEIYzj1bDGLX2ZutdGxNMsC6ZxmY74MaWLkg=;
 b=YfYLE+f4fmgfwFDfa3o87hL6foof39hnINnOOhNYcjUhRXWobu3eOoLaTTwPKfDVbm
 iqZuC9OvHmradAuZamxbsydhONYWo63EJuOfc4++nOiGWqsHMl7wUQXcvCJFeUSyZA9R
 QoRKuAshOJk25L9r6w1uFmfd8mL9mh+tw+ePGrWb45m43o/8HzmW1wcGY4Y4Lg4DniqS
 fUWtbV8dsAJ94CnqgX/P+Qp+lFIAFeZDhLeY+3ms52bnspuvzV5kaphNQTDZIPKd4Uv7
 +Y6NKF64ZOmNAKFesIYjJTyKo+iSghcKYcr/7ZI7DxOI+9yY5lFIcF58e5nB/ueCSKRa
 gomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538830; x=1796143630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KHnUqciaEIYzj1bDGLX2ZutdGxNMsC6ZxmY74MaWLkg=;
 b=QDzwA4Rw29NKzoE8yPb8s9ByOJ/S4tkiVc5Vpmr7XC6X4YUn/LNYVSpWmvagiAhxn5
 B8tMEmpg4/Jn4bfMAB9nAs//g4EcCf7Uiw2QU9ev0hh2w64ueRltlsCATRA8CkCFnjf+
 7oYtkAgTV8+mWdoiQwXkXgzUdxuqpjyjTn/Y+CHi+XSWQ2MwZxTUpg+Pjasl/jsRPk1s
 Wxly5dYVDFjNEhdRIOPtkAe9w7JFbfn5V0Q9FiIZRS4uMyr1fBvJDKTAUQQKxk3Y6Y3H
 P3zforHdDQaVNjsk1GcW7aO3PKnEvaesLy29uw7xZ/QwdiDSBpPD9Nv/fqCQ4B5y5BS4
 73FQ==
X-Forwarded-Encrypted: i=1;
 AL+hErERFVMUcYXPyUKCjCjVUyZ02h6ns51x235jLWfMr3qihwswbH7JAmX31tA1aacQETCzlRS5ySg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8T0GAxc96ZVk2PzhzzGkv+hb/Jqdfv8UjHvc+T4uXd6qZepkb5
 y+P/m+VB0Rbyn9Ks8GeQPG/05diHHL9JLHibsnLYVnQbpfwRbWdo2ldLodH2m2DH6n1zqPPHFLQ
 0B2HMxztZfBbFO/E1rjtfuYkz4YwmgbgwS0YS7Ohy6cojzB1nGH4rCzlL9vpvaswHXSh2Ps0=
X-Gm-Gg: AZFdTZf8fwLySMTYpYFeyBraRx54eF8Fa/KppqCzbvdWlNDrrPFf8AC9BdCK4Oa0tG1
 0Hvf0KgMY61HzBvztYhGk5BVBP73iXHGWDUwYAXdsONNRFl7j+bS+9C2oaJ5USme2y9bSJZHhzX
 CsTjsUBJbphvMhHNJv2ehFt6oBG8TCKeD0BA+ITzAlCG0fT+V8MYnzzDeq8sANgm4ablBxcTJWj
 oWOarKG59FCTLIGmuChVFt1+36Epr3PnYS9mxEx05diiZW2p1TB6z3YNSPVkfoQB/Rwq53gZHYu
 0VP8ivcabrEQMBZrLnSNpwkIQkL7r21Tgd6fximqwZ5KZq5B8uD1bxTKrfpOxG9gkIBUvAXP9qw
 9IBUiEhChONRJshqxNGFlxwBm3NTGG1t51lwaFombOr2m9VefB95UzIKaUfVDdPhpDHaom3PFXD
 p3U5nmYlTKQahlUAY50YlFrBbK+DnVkZKoP7M3glTlyDV2hWxwqtDdrkLO3USgEi+TyIEx
X-Received: by 2002:a05:693c:880b:20b0:386:b025:1e1e with SMTP id
 5a478bee46e88-386b02522d2mr7147946eec.16.1795538829850; 
 Tue, 24 Nov 2026 08:47:09 -0800 (PST)
X-Received: by 2002:a05:693c:880b:20b0:386:b025:1e1e with SMTP id
 5a478bee46e88-386b02522d2mr7147905eec.16.1795538829116; 
 Tue, 24 Nov 2026 08:47:09 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:08 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 0/9] arm64: qcom: Add initial support for Shikra SoC
Date: Tue, 24 Nov 2026 22:16:51 +0530
Message-Id: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfXyIOJq3PkZ1ma
 b8w71IaZekfFv+/u2Ia7Xxz3YUgTtfZOJh0kQneFXsbV0XvWDqRr6clYmrJrUOd4PlN2eBhs3ZL
 Y0rRBkLpwYAwDTt9B9v0/h/gRw5CC4swppvQpp61F9AniuY5Avvf/FH/hKq1Hy+5wyCMiJNZJnN
 VnXy/p1NR14hN7t2SGkewC+hX+uxXQE4Ztd8U2zAVSn5AOtPAaFqauYl3o6D44aGxuCMD6rF/ll
 yjRLccZ96enohxMxet2dnE52aBUayR1MDRPEu+nSz2ExdMRhFC1tSguIvWBfvFiquGU9t7U7Smj
 HUUVO+5XZ7pcWzrP7OAQ+NCWqQ4F2/YLngtGCrqWXhI3LGGRNZbXVpgt3zs0xGsCE9bv76uNXnZ
 czSpIMue8fLBcLA2raZbKfdiRXE/S6eZeWux6k2iSoOcq5JFWg7j4+KY40MONf7WqEOZnuQe1+l
 PB6F+5otWy4S+mp9HsA==
X-Proofpoint-GUID: ejPu9PIJB72PC9q5Ch2YGzXNbml7rG_1
X-Proofpoint-ORIG-GUID: ejPu9PIJB72PC9q5Ch2YGzXNbml7rG_1
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b05bf8e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=XM3drYV-cKaoLeI7bekA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX6htqBHZT8mqm
 Yp5nIeF/f0MDAXicV9eFkv9HxAVPElf+kp6sbyST71q7oZuRr80XGBvBgX6FfWgJw+VLhq+rVvg
 DbO/BD6CTLjChKzovz13D10kTng8QMo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
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

This series adds initial support for the Qualcomm Shikra SoC in U-Boot,
including device tree, clock, pinctrl, SMEM updates, USB and configuration
changes required to enable early boot on Shikra-based platforms.

The device tree support is ported from a Linux linux-next branch

The series includes:
  - GCC clock driver support
  - Pinctrl driver for Shikra TLMM
  - USB hsphy & ssphy support
  - SMEM update to support higher host count required by Shikra
  - Defconfig updates and Shikra-specific defconfig
  - MAINTAINERS entry for Shikra platforms
  - Documentation for Shikra platform

Thanks,
Aswin

Changes in v6:
- use CONFIG_IS_ENABLED() instead of IS_ENABLED() for TCPM check in qcom-qmp-usbc

Link to v5: https://lore.kernel.org/u-boot/20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com/

Changes in v5:
- Use GATE_CLK_POLLED() for CBCR-backed gate clocks that require branch-enable
  polling before use in clock driver.
- Align the Shikra USB3 QMP PHY driver with the upstream Linux
  phy-qcom-qmp-usbc.c driver
- Skip remote hosts beyond SMEM_HOST_COUNT during partition enumeration instead
  of failing in smem driver
- Add MAINTAINERS entry and board documentation for the Shikra IQS board
  enablement patch.

Link to v4: https://lore.kernel.org/u-boot/20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com/

Changes in v4:
- Drop DTS files already present upstream.
- Keep only the IQS board variant defconfig, remove the CQS board variant defconfig.
- Add documentation for the board.

Link to v3: https://marc.info/?l=u-boot&m=178668446732727&w=2

Changes in v3:
- Added USB3 support
- Created defconfigs for IQS & CQS variants
- Added WDT & fastboot configs in the shikra defconfig

Link to v2: https://marc.info/?l=u-boot&m=178595470886921&w=2

Changes in v2:
- Added USB hsphy support
- Ported Shikra dts files from Linux linux-next branch
- Created config fragment for debug UART

Link to v1: https://lore.kernel.org/u-boot/20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (9):
  clk: qcom: add GCC clock driver support for shikra SoC
  pinctrl: qcom: add driver for shikra SoC
  phy: qcom: qusb2: add Shikra PHY configuration
  phy: qcom: add QMP USB3 PHY driver for Shikra
  qcom: smem: ignore partition entries with unsupported host IDs
  tools: qcom: mkmbn: add Shikra board mappings
  qcom_defconfig: Enable Shikra clock & USB driver
  configs: qcom: add debug UART config fragment for shikra-evk
  configs: add shikra defconfig, MAINTAINERS and doc for IQS board

 board/qualcomm/MAINTAINERS             |   5 +
 board/qualcomm/debug-shikra-evk.config |   5 +
 configs/qcom_defconfig                 |   2 +
 configs/qcom_shikra_iqs_defconfig      |  31 ++
 doc/board/qualcomm/dragonwing.rst      |  16 +-
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-shikra.c        | 344 ++++++++++++++++
 drivers/phy/qcom/Kconfig               |   7 +
 drivers/phy/qcom/Makefile              |   1 +
 drivers/phy/qcom/phy-qcom-qmp-usbc.c   | 534 +++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qusb2.c      |  14 +
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c  | 478 ++++++++++++++++++++++
 drivers/soc/qcom/smem.c                |   5 +-
 tools/qcom/mkmbn/mkmbn.py              |   2 +
 17 files changed, 1456 insertions(+), 6 deletions(-)
 create mode 100644 board/qualcomm/debug-shikra-evk.config
 create mode 100644 configs/qcom_shikra_iqs_defconfig
 create mode 100644 drivers/clk/qcom/clock-shikra.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usbc.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-shikra.c

-- 
2.34.1

