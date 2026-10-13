Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1995ACC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 17:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50060607BE;
	Tue, 13 Oct 2026 17:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlKZ_g9l2laP; Tue, 13 Oct 2026 17:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F6A46078C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791911300;
	b=Q3oXJGiHeTxmUgu3aSZ1jjkH+OMuRWi20X+NfW8wm7kqCLpPRKpA26N8DCwOTuX3vh+a
	 B8R2P/y3mWisF9/HTJiVewut7yyYVOPfsMxCqYLQalby5O7fvPajy576eXoFHheoyzKZB
	 GyYVXg/ok1Th2pV/vnyw5AY/9/KQmrwdY4gW5DSAPdc93sk8U8ORGzTA+tKHMBxXXjArS
	 r4I3gFu8p/VWbFIMQ7pGENWgcl9XvPK7k3PGZZp7BLSIiowkLgbLqqm2aPNXAPVKBQDnw
	 5jZgIKJ4VKY6nwnrNtY0RdxOjzJNHQLRkb1MFTsUYVNIIIt9ZjSECP7HLrsJPr2X04g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791911300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HBDvGulrxTHB/RkszsCtMTzLc8oV0QhCLP2Ps9HbWfY=;
	b=sOvKEQF9ZBUzzL+ghIOGVAUk+zZ1h2XwYtCD6nQo+e0Jrff4t9CvtHCT9IW+ud0aqMnv
	 70wW5ES4X7JFcugwV3igh8am+kKZY3schXS4PFcTFeGK63WfsU1uHxcSKdImMRLLBUbBK
	 zpQ2+ZXG4QZPqm1X3wnR0nFZjMQE09gfOOAC0Fr5A8uoGYtBthYbfHQO4GnSxudN2zLSZ
	 Te8YhYTuEtiPQlv7KA/sNVe4ZdzYmTudq+EV7aDEAMqxPTVyyHfyZ1ZNfoSg4tGCTOV+n
	 c52w7szUY6/WA0SVnSoTEZjj9TnCERC9IKheP8M8m4Vi2vl/608zj1StMHDeqr4enLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Otl/JXj3";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SEhrG6m1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791911300;
	bh=HBDvGulrxTHB/RkszsCtMTzLc8oV0QhCLP2Ps9HbWfY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ylR68ucJf74Fi/T8A73LUHmifxlXcjjrlB5NBQEL6JyeiAIQDTMvnQhrxxZ+k6fGg
	 AkEj+CijEDlWhWvYUoUFHKPb3okeQO8mOu4wA+p3LKiv9cAkZi0rNwmAD4bMUNqtlE
	 u7eiA4GZ/uI78NOi4d7fmtAjy3E5VB7wchPeak8cjL37v47LFfSh+xH2II6QWloBBD
	 EDFILSZzXi6pB8FqzpEIhlfGUUvlMALt/jabUN1alz6X/iUfRa4pkDuoOxTxjZdcjC
	 kFFbeN30i6nRGW4IvaZyMbs3JhA5eLa+7p9cpiSpBabn7g8qqsoXX89Qi9vQDQVo3O
	 8OYs+t8fkyb5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F6A46078C;
	Tue, 13 Oct 2026 17:08:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 35E7D1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B9A06078C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-GOho6Y_s-E for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 17:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 080E8605B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791911298;
 b=NPBO49C0QDl4tQgwIv+lMlFSp+ExF4NDahhNCMErimsp0uvGBo25Vrbe2NU8JnDmSjEm
 dDuhpqZXKh77dSt38jW85Yt/sqvJywzjMm8jcvPMXEvAz5taAG25QkxbMlT1EsJOI+U47
 vc6yl4/3i0bERiEDjQN3jMPY3DrILbqaG2X93so2yKoUfyZ1uu/rY5UHGCaKvxUkjH2yr
 4KQMYbBPLgxS3rYG/tLbojCIcr18Id1TTdJx5nuJ1uEnW+be9T+hKOOXl3FGD55iZ4rAS
 oXmNl4x4J3dje2ERzWwxARPqcheXV7IYaQCnNfchYsMO/Q/Xn+xDgYBuAvb8o490x2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791911298;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=HBDvGulrxTHB/RkszsCtMTzLc8oV0QhCLP2Ps9HbWfY=;
 b=bn2hWkeHrtQQms05OqLaEqWQexHc5B3NHTu6+UVuHon+n3OjrUsXU1GhE3SzxuDVPUi3
 BJN49YZpnOTpoEz4LI1Q9GvzA2oScDRqcTHh6JeAbTFW3wpcc9nB5Hix0b1nTQPK77z87
 NSiU5vdKZpyzCCsY8NL6o8kjnYXfD6u1ESpVRYVMz7/HeBZhXr0/NbvPO/BqoaCEKbOrK
 mTeVWRz2CYMkb3Ym13Ybmb5WjJ1yb608icpkNAWRjbAq6etwDOhMecLy6YKrteKq9UrV+
 fnf2FOD63WSuzhOJfV+reSX+pHuGItks01JZfSJzT3fzRz8b7TuvQQL7m1mzCPP3ZiQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Otl/JXj3"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SEhrG6m1; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Otl/JXj3; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SEhrG6m1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 080E8605B0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:08:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3wX41492081
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HBDvGulrxTHB/RkszsCtMT
 zLc8oV0QhCLP2Ps9HbWfY=; b=Otl/JXj3NPAMIerK3XSnDZOWLGFl3n7KzUIcXc
 T94n1JE1UuO5r+IHrGuWs5+RCcre7Knzt4JHrJSbfneBM7wqUbl+vv3HBj5hD/Yr
 QWNBQPtT/KqTX4nCxaunDEED5KMn0hnuZi9gAERxXwyXdyRSPMkDZQoL75eaqgnS
 w75/6QTRxXlF4KMY69E58/A+g0BTwBt+jVsQCcduwe7mRftHz7vT63awzpfv+OK5
 iBg7hlJQEbRIK9z8PnE4CH3b9WaaR3LSiMPShaFg+uL73Ut7kqvA3uoLv2OSWS9X
 sk5LktwvMYw7x+TR1Upg3PSBYzhmfx+c9w4QVXyIwlExhgVg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqu85f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:08:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-890a9a4e168so1952277b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791911296; x=1792516096;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HBDvGulrxTHB/RkszsCtMTzLc8oV0QhCLP2Ps9HbWfY=;
 b=SEhrG6m1Z5+RC/YS3AG2YZF7SC8/r2PVxwPYrKZKQcu9wu1tt+sHhOBjBfGysXQPF+
 sXpIR4miHqxqotUqcMNWHISIyXhoJmxL6pe7KuSPaE8wqx52ItkIeb3aE6R1u0w3GkCx
 0jUMlOSFlVEoOvuVskgl8fX2vXat3rfPOa3NDnevRWjsFxgh+zGsV6L6yuv2BtJ0n35i
 eGt61b5JKkuHwXGdz1HHWewbjgSJADHY9uCdJZD1sv1Zj0KF9fCj8vm5/JHcYX6Le1xt
 oLntNSH+Xna0T1rfkgb2ircFzzvz9Fjjs8O/zzcDnfKye5HgkxmgqMVnfDQyz4OqDuMV
 r24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911296; x=1792516096;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HBDvGulrxTHB/RkszsCtMTzLc8oV0QhCLP2Ps9HbWfY=;
 b=eGcHR/69HUt4P+rateYSDQDp7ejzXaLedH9YDVI/pu6/nq91TH6xwJiMZLgqVpZYkF
 7NKRnmAE1ynRWws/XcDhsDsUPmTIvS7t8lI51Fn9xu3oilYw4nmLeS7LcDkxaWe9ATFL
 YZzsJNdiwRqt1q/ghsDjz/69J6JOIf1k8mpem23wi1i7nHPb0TMs3kw4tAK/oGKtY3EP
 Jq5VsREhAqHLEcGLzQi0uuoaS53EP4/lSR4oeKCkUUD6w9uzz6UyMcB6dCg+I0VQeFIE
 by4XsFmHqQEjq12MjRTsPZPONJXtn1EK3kYy1/IKGiMNniuqdlVKBODIpdcNiZhGGc+n
 80lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5FvSb8EgY0Fw3GMqWyB1kL49EfV/FLuQdRT+pMkrLuBAXuajq+kg87bw0GrgNpsWkFu/zgU8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIjm6mpfFvSSu0axGdZlOIGGd/QvU3XC1XuNp4pBbBMQPiHnYSt
 4AWbQhj9K9GnunageiCD5ijTPnpn/fvFnJxGXVExqqdmW+UFXkbfOXULzY6Hcqhp+XIgR00DWRB
 X+xsV6QYyFXQIlOaFhY/4pcXIZOH7y+Ux1WdJQS9x5aUDfiD8FI/uCdY0XawRnAn7xfUqoU4=
X-Gm-Gg: AYBFou3SYo+XBUlpB3PluPt7oDVRKXlfuv2eaQaDJ/TaOjAgH6Lec/faSyWk9mAH4mQ
 oRIS9TEVYol23Ti9U+TW3GZ+DIU9BfuVqRQ2xC9dB1iW/2fF20AWP7pnpFUghUrYxUAqGohtQAF
 yfdQl31aEcxCigU/wOX0rcauSrKe8LaxG+P0v9ZOSUbwDJQy9h258v7Q2KiYveIrKcYD+Qk6++R
 3D82mU9ObrsA+Lw8b4BJ+B+siuRcSqU2pE7c0iX3ZXHzYhyP2KYFKs0LIkHTdKn9jqnijBCuyec
 JtUHxcZus4GNekNHs/Z0ShBYaRYCagK0papU5XfRSJy29bGiKeBUc7yORw1etdmyciKqPtjluMH
 WjCasDAXN8dFULCNMzux953mYC2gIAyjGXeN/YzUChuOpyH0cqn4l4UF3SGg+YAldqFz0qFv23s
 AL8rKiApChwsasw6UbKq74bknSlJJG
X-Received: by 2002:a05:6a00:6c83:b0:88d:6375:af05 with SMTP id
 d2e1a72fcca58-897c7ec0e7bmr10647396b3a.55.1791911295933; 
 Tue, 13 Oct 2026 10:08:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c83:b0:88d:6375:af05 with SMTP id
 d2e1a72fcca58-897c7ec0e7bmr10647361b3a.55.1791911295374; 
 Tue, 13 Oct 2026 10:08:15 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d804f02adsm152022b3a.44.2026.10.13.10.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:08:14 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 22:38:09 +0530
Subject: [PATCH v2] phy: qcom: qmp-combo: honor USB-C orientation for port
 select
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-ss-orientation-v2-1-8daddb44447e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHhlzmoC/x2MQQqAIBAAvyJ7TlBDkb4SHZbaai8abkQQ/b2l4
 8DMPCDUmAQG80Cji4VrUQidgXnHspHlRRmCC8k731sRW7UoJ56q2iVH9DFRdglBo6PRyvc/HKf
 3/QA5my9UYAAAAA==
X-Change-ID: 20261013-ss-orientation-d85a156e806a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791911292; l=3173;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=1KBBzXUvcQHzB/1UUOkjglsPSHwLe07m2bUeFHv5pI8=;
 b=aMHaRjEkz6RwdnGyLcUP9TS+r5d/lwDzKqy9mBEP4fIIzx49GRaKTEUawMbGKM/GGgmvdXbKw
 5kYmzoM4+UIBRKme1DAGiopyr4+Q1S2nZGolnnl4d1pBzBWKgdwgU9h
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: q6RMjmtn37GlZz1Pi-jkLQAiOt9PNhnF
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6ace6580 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AXj-kUE_TWZo8C8MWVAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2OCBTYWx0ZWRfX6SHQhfy5cGvg
 xuMYXxPwiq/1dXDwmKmvIsuA3KkT1LbNw5qkWNQcq5ZqYtTHfUqVHGJ88BHfjTdNXZHN2a50DXV
 R45bHBKniO5w6kgTe2AAd15JaCBsUvg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2OCBTYWx0ZWRfX6qgoMyNUeRo6
 LA88dnUE04ddMeOht1+d2LtJNcuJQHseoF04PVOW/hO5rJwqxslrQcf4BpJVWgWygV9NWYP1HuW
 6oLLFfZCeuscTZjxx0osD6SJWATu4HqWRPEZvnb9xmA4deQzKj+JJi3/7RDakNu7plHbovwNyTx
 So9DJFM0Wjr5GJNBscNuYxpQLZNhw+uuK3AgP4ERJHixC0Se/2mPZ3m76F/VHxKAiqF8OLR150v
 k+npgDKe8oqII23QBFimIgIJ5gM8sDHpGY1gI0jTnwEOWSiiWgrAXU3DPPqf0dw9f5FdDuQrdHW
 2hWYYS+nrnfMxyW23c2vqNw8bOGmdJ+aweNYdgUGxVldxgXy9AW0gTVxmdDyEJMAFomnrJ59sQU
 dlunNegknGaM4t1W9ZoIYcrhO/BgvWn3t1Y+Id30ccpQDuA44KVv4PIW+bpndL3y4dnhL7EI2zn
 YoeRQ6FYdmcB2igmbBQ==
X-Proofpoint-ORIG-GUID: q6RMjmtn37GlZz1Pi-jkLQAiOt9PNhnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130068
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

The TypeC port-select mux was always programmed with SW_PORTSELECT_MUX
set and SW_PORTSELECT_VAL left clear, regardless of which way the
USB-C cable was inserted. On a board where the cable goes in reversed,
the SuperSpeed/DP lanes end up routed to the wrong side of the
connector, so USB3/DP never comes up correctly.

Cable orientation is reported by a GPIO on the qcom,pmic-glink node
("orientation-gpios"), and is now sampled each time the PHY is
enabled to check for the orientation.

Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce
orientation variable").

Tested on QCS6490 RB3 Gen2 board.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Instead of reading the orientation at probe, read it only during the PHY init
- Updated the commit message to better explain why this change is required
- Link to v1: https://lore.kernel.org/u-boot/20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com/
---
 drivers/phy/qcom/phy-qcom-qmp-combo.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
index 0d63e482ee4..65141489d51 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
@@ -7,10 +7,12 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <dm/ofnode.h>
 #include <generic-phy.h>
 #include <reset.h>
 #include <power/regulator.h>
 #include <asm/io.h>
+#include <asm-generic/gpio.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/delay.h>
@@ -39,6 +41,7 @@
 #define DP_MODE                                 BIT(1) /* enables DP mode */
 
 /* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
+#define SW_PORTSELECT_VAL                       BIT(0)
 #define SW_PORTSELECT_MUX                       BIT(1)
 
 /* PHY slot identifiers for device tree phandle arguments */
@@ -283,6 +286,27 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp)
 	return 0;
 }
 
+static bool qmp_combo_read_orientation(void)
+{
+	ofnode node;
+	struct gpio_desc desc;
+	int ret, val;
+
+	node = ofnode_by_compatible(ofnode_null(), "qcom,pmic-glink");
+	if (!ofnode_valid(node))
+		return false;
+
+	ret = gpio_request_by_name_nodev(node, "orientation-gpios", 0,
+					 &desc, GPIOD_IS_IN);
+	if (ret)
+		return false;
+
+	val = dm_gpio_get_value(&desc);
+	dm_gpio_free(desc.dev, &desc);
+
+	return val > 0;
+}
+
 static int qmp_combo_com_init(struct qmp_combo *qmp)
 {
 	void __iomem *com = qmp->com;
@@ -333,6 +357,8 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 
 	val = SW_PORTSELECT_MUX;
+	if (qmp_combo_read_orientation())
+		val |= SW_PORTSELECT_VAL;
 	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
 
 	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261013-ss-orientation-d85a156e806a

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

