Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829AA606A331
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lPiauKhO;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FCO4YrEq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y3DM2Aa+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60FEB6064C;
	Sun, 15 Nov 2026 06:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUBb6o2sOl0A; Sun, 15 Nov 2026 06:27:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F7C56075D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794724022;
	b=B6j2hCGsP+x88Hw2sHFEDUaJprRRfWfFyBJ6MTj9cKg50jaKn1CGZb7kYjjNU+CggHiy
	 8Dg48sqy4/rRyeNvV6tYBFCD5cQjMXdvMZ20usvmoZasNzTq75GeMmSFJE/cU31XfgoDh
	 0C1zLfgBHcBoymEJZwsV4SGBGA78rPHnc9aN9kyV7wwHFYUDS5sAdoRdNKag5WNpnT5oJ
	 qFcdPpz08JnXZio9wrqffUWQN5yreeohF7ioKa3V2YtiC+pdr/9RgxhkNl9Fi088/rnGB
	 PeEXceXLJYGfUN7QSGJJsb19vZt7pzCHQ5jy7Bn4l0tFS6A+K69B3nWvQtsMNraTgYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794724022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=;
	b=og+ckWi3huVZ/a8CXwz4lXv5VTzHtSkpJY26CdwKxSWjz1FH/mpS/WbnryNYG8f1VBXW
	 U/iYLUj7NsMVoJmbcOhcvLrIygq6av+Phbdm9Jhnyc7Se7IC3/3LGGOjO9hnTpH6vlP0o
	 KHwh5VTGygIgdy5phqxjG3xyLB8hUnxjqutTdnNGRmm734k9XUTWaKkmtDYL8GBA5+J0I
	 TGxhIpwOUgR2qeymOEthHYHPpiOhPf27PkIMtYNqL3sA6MJq0QAZlAwvIkGXOQZxpPg7w
	 +6rKz5C97aNNenfxYWA+nggSFfqUqbzi2zjVVzU74A+d5042pFidQk/SJD9O41yk/Tw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794724022;
	bh=Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lPiauKhOZI5iBNmGWOB4c4f5UQQzYbopoKR8A5vReGp10KCKy/HfY+wnqTKoTxK+U
	 NiAfGzaZcZaG3uSL60dwJnpXqYrQIZCNc/IMfIyBl7RVmhXN8DKaMCaP6e3SOJf+Ns
	 +fD4ZXHCRv86Qi7hzJXlx58yK7RV/xKDdzRNC9dX93njlQh7A1qlv+RhuvufLkpuhP
	 iE7U+sZXd2mf0mgvrBmd3NMbFnh7/peQerzswrGsYn77Pf1TURFBHKV3r4qZ+7GLl4
	 zAQaW52KehPyGzkOT8y9rwKKKiug6EwXsR4srtsvAPFMLQQWeUR/26hXtO1sEDMTtM
	 Dr6DKjflGxnQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F7C56075D;
	Sun, 15 Nov 2026 06:27:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 47029109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44F7440080
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Tv-UOkYIKra for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:26:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F06BC40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FCO4YrEq; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y3DM2Aa+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F06BC40061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4S2tU771871
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=; b=FCO4YrEqqDsHhlG3
 a8DG/vkv+bJJ98TertxGf9gmMo0vO7kSsdvl9c0wbtTVjPSqYcV6Tcw5M6CPYDJI
 in8zKRaFQcU/N49ed3ZWZGitY1mD369T8TJZyoC8lecm5+oo8HsvHFnw1je97/nt
 wlqPwrWkHirtJuCNzb5M3wZnFrhm4BEkQ+rAVVGg646bWttml7ErkQzqEaBFiC1w
 RF8vexsEFFs/DzVzbs+Z2ArILiEFBL2Fa1k8zst8wLyFqBDaQeEmNmz+7ah+C5Hh
 ZkRcCMAyCbvb2hMMrpy8Ghpb7bYFwnmDjKX8Z/uQfIMJVZnKLjxrf4R/E36+nboa
 VC1R5g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhjcur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so2901427eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794724017; x=1795328817;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=;
 b=Y3DM2Aa+rdrnWZwWKd5o6hN1Fb5zyfgPQHSL4FWigyk9HWXQ4jRo6ikl2PfBfmmg+i
 QZP9UZNOKzVIDkE6/oH1YDTyDLt9vUUW5Db+qSC8B2HOBc4is+jV+hbE2f73qku4uJ0H
 Afb1wpsn6sOHqtpus41eniJMVJ2JBCBXIcDC3mqOlv0Rb+YETanDr2orEUNelDyeoqrM
 3sxW1Ktj4KUcwDMrLrvN2AhRMjyWjlqsW3avflC6+HBPxpVs3iJChFVPpikO6Ik2shFL
 LqvNYjzybnzfy/55cyoOy+ThFo4EFtLpx0Ke3OnWesuvoMM5gobezWMB4JWVV1vOIjSR
 5zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794724017; x=1795328817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=;
 b=EyqDIgmZUI7hbePQ2/4hfZk5IaQGxUdw6p/haEM5yniz9cG51zGNkjPu3bMHV2hGRM
 /V7cEsioPB1LYDWtne7To1rimTiNk7sNiYvA2v/ImNB2IERpIr18PWHkkFDVyl3p9da6
 uKGcBcuoghsSE2Pz56ZFWeOMg+0xJ17dlEyhv0EmqclVs3PDqO/fOXqRcnjm1Uk6cvKK
 ltBXXa8gSOXyC+8ryU3EhWd1cSRiNKEIQxwtk9Qo0crrH/PFVeH7EwGBfS50iFHO53gy
 VqB9e6mIH7QpBWbCAO6v35jQDKL3PD+Z1KcR99tKDNtKpdtOTXmWTsvEHYH+tlS1BryI
 OR/A==
X-Gm-Message-State: APuU4Z+FXD0T32xiYfGg6tqnsxott0bzPh4dZyhqxtUQvjsTVUijAV4d
 6+qpmAHUh6w5V09EggoAxtHWzSZUc1dVrrfphlkDsWWQQLpdvPDnvG0PTx/YH1TcUPjdQe0i/iv
 46zonEaTLJ3JijV9LhFZ6g57/Ae4uHsQ2HVZGJcbgZDqePcCBk1TLlpW00nYV3N1AbsxFCqQ=
X-Gm-Gg: AYBFou2bEFCCaAd2utihJHO/C5rB2J+YyM+OZz49CCl5R4PenAXNPk2UghRjYdeqdXh
 FJYbbx/SkiSwA8jfuzjPTzi+bllLWDWQP6Bfjx6QCSxgJtP68Q6iYEqWE1PLHERpGNQSL67dZgu
 7xdKb3u9Y0Z+twbr4upxhVW3dSWOOAX4ox6XTBfQePiH0MQ47tERmJdsZV8VHFo01iWQTl8GlsP
 zjRLlqvF6orVVbfEzt0aWsM5Eaf4/YHo0+edfAT0ERCUvngWlMq4987H/1p4Gk4NZYK0L/xUiYG
 78LcVdrFyU6LgrxiOhcAox7wF4O2JlqqPDBZna0ilqQU26tRe4G0G3FrBq9pWLO9z6xBHPlFm1n
 H9TlbDvVhLFMmzKiuwd9IyhVQC86nPmTCPSomlbCLeaPpORJdCPua2dt3wfNIWIuYIiApDKxsdN
 mVbV5hpY/ZB9bE8jce20i2JSowcnPJ3LX02ovVQwiXs6qoAPyhzzciu1BqDL0k2blxmgxTYwAak
 GoU
X-Received: by 2002:a05:7022:283:20b0:1a4:4194:fc04 with SMTP id
 a92af1059eb24-1b503121772mr6599910c88.28.1794724017289; 
 Sat, 14 Nov 2026 22:26:57 -0800 (PST)
X-Received: by 2002:a05:7022:283:20b0:1a4:4194:fc04 with SMTP id
 a92af1059eb24-1b503121772mr6599876c88.28.1794724016672; 
 Sat, 14 Nov 2026 22:26:56 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:26:56 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:08 +0530
Subject: [PATCH v5 6/8] env: scsi: Implement partition type GUID lookup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-6-79e76209457b@oss.qualcomm.com>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
In-Reply-To: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Denis Mukhin <dmukhin@ford.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=3571;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=gyxq1cM7icXJKBWHSmqo+dS93WscLISnfug6uY5QpIE=;
 b=ToLRXH7U+J7Q2OFC2itIDQ5CVaBdpg/Itj0nv2DZYdJuZ4R+D4qtWUXRBlmhBQjixnyhFY2d4
 ytYzbaJEg84AXaBFfol6ZhaREpQ5u9SBt+Ma14kKbJqZSLDn377ul6I
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: MgmA6--UzMkvAyTQgp38zuBRcM9CRH6_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX1PA6oeEFgYtP
 JT4dqQJE6Py1qaO7JfaGdNLHnqYpuFivS1eyWj8xGce/kAgdJwYvCc6SK/uTS+imUDYp42fmV77
 /EiTTZWnK8AvTe3ui75IAzgtrFSZoKw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX7k2swS8wVGEr
 i4SWAJZxHWkgKd8UFTOTY8LVOadl/AsZfoLgnfumZMlw9ExdYLyL1bVUISJ3pIdNBhQC52O8fCC
 FbYOCgTQeFJIsdlV0rJjRCXyaTiekdK32YdcXb6Vh59R2qse80Xv220vTZlxiWUhQjlumLcZ2uf
 5vW0yjHzvVfZ3RNRSZyjHh+QIfeqgzr7W4uho3T4/gP+Zlt3rnU95CrYtUefm58JBuIMFmf/izx
 KNaCtIqlzuaCDWALULeA4X4wjBtchWZY87xzYjzKlnHaULIeFP9ygvRH3LmD8OJk+vaSwtdbG2d
 v/UT4y3gD+KzLfZeCgGyPzqWVFWXdCS16FzmDpsIyMoYapo98i4rQoTOMUSE64BPHhXHtWkx071
 0Y8MCLmu8KOEdmqy9xAscTNcCiCgEGfkUAe5fZ77bs1yhCuYM0KSQrmvSh187M8Ldk0IG5t4SKF
 mWDtKYUCljnWUnkCcJw==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af950b2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=9j1fX5knQuk3s5Zjpq8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: MgmA6--UzMkvAyTQgp38zuBRcM9CRH6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150025
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

Update env/scsi.c to support the new partition selection methods
introduced in the Kconfig. Replace runtime string checks with
compile-time preprocessor conditionals.

Implement support for all three partition selection methods:
- TYPE_GUID: Uses scsi_get_blk_by_type_guid()
- UUID: Uses scsi_get_blk_by_uuid()
- HW: Uses blk_get_device_part_str()

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Has only changes related to Refactor env_scsi_get_part and
  env_scsi_load functions based on the choice configs

Changes in v3:
- Introduce a new choice config: ENV_SCSI_PART_USE_HW for
  ENV_SCSI_HW_PARTITION
- Refactor env_scsi_get_part and env_scsi_load functions based
  on the choice configs

Changes in v2:
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
---
 env/scsi.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/env/scsi.c b/env/scsi.c
index 91a6c430302..b170f4ee0c7 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -41,14 +41,17 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
 		is_scsi_scanned = true;
 	}
 
-	if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0') {
-		if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
-					    &ep->blk, &ep->part, true))
-			return NULL;
-	} else {
-		if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
-			return NULL;
-	}
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+	if (scsi_get_blk_by_type_guid(CONFIG_ENV_SCSI_PART_TYPE_GUID, &ep->blk, &ep->part))
+		return NULL;
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
+		return NULL;
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+	if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
+				    &ep->blk, &ep->part, true))
+		return NULL;
+#endif
 
 	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
 
@@ -95,20 +98,24 @@ static int env_scsi_load(void)
 	int ret;
 
 	if (!ep) {
-		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
-			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
-		else
-			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
-
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+		env_set_default("partition type " CONFIG_ENV_SCSI_PART_TYPE_GUID " not found", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
+#endif
 		return -ENOENT;
 	}
 
 	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
-		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
-			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
-		else
-			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
-
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+		env_set_default("partition type " CONFIG_ENV_SCSI_PART_TYPE_GUID " read failed", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
+#endif
 		return -EIO;
 	}
 

-- 
2.34.1

