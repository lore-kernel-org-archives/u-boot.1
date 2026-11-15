Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA1606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LKmPfA/E;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jMDV1f8O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HONeuAS/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6725660650;
	Sun, 15 Nov 2026 11:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXd7uhF4-FNa; Sun, 15 Nov 2026 11:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A84D66064C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794740745;
	b=rKOMETQKGQYHcBtJ/OROCWw4pt4iG5zXKjWXmOnZgat+3STiSG8vsZ1GCsQtg3MS8f2q
	 mwKNikaQ6g8/i0cljzsB83iPxlBwvgE/nE9xZmgxCmn9EjVSPbMwvRyyjKLsUBHxVmFOt
	 e1seNxFYtYn7TS5LQkmSaIx7lI71xyW5vJf542+0h+sO+TrizNfH0HzLPy2MrKtaMymv0
	 el7pCkqDxBJTiXA1eaP/t0TwzrkxDWg6EEAP2iszy9qqLZc1vTBshxELk1/dvd5R6ILz7
	 fa3lASExoI1pDWz4J7jpoQsj8tfqhoOKjjbArvB47T0EbkrUbxvjxAfviUESvEXo/zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740745;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=stFHMbB+NtGIBW7dyJrfxPszSoUjcYcAo0Jnh3qm0o8=;
	b=qHNUKrNrSgQ+mO9RCFbDxZtr4rdJSHdJrZGB6wjwzdnWsNOv/XwWYDoI5G8TMH2tOi+k
	 rYz9bFWfJ09gukGBdDn8yL1ya3KND/Os/nvJSn3eJeqVmGjkR2nBweFKwi3vUn80dMMgQ
	 /0LxdgLxcv7Afgf67jPEWgfP8+sYCws52s+ndAbjrFjufwfCaKEep0skBIwt6oIwv2e9R
	 diEsL+3aTrvt5hP6DjSHN6+EqU7kCAOYZvxIkSLFK5RTizXd5L8mTEI4Dyuco47ujs9YV
	 xPeqHFLLpnMB7Sub8Ip71VXfCXpUccJD07xra/ZDCoRWGcXxUFckKBKbTfEaduUxbnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794740745;
	bh=stFHMbB+NtGIBW7dyJrfxPszSoUjcYcAo0Jnh3qm0o8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LKmPfA/ECRyAqWeN9q4GwJOrsVq6QEK29GmhbFe5IQn+sdE8o/JPSB81w02ke83zB
	 8nwHR2PojPYWhpuokAmywU0pXUYuYl94f1lGE/Dwb67L3pTe5gLcH7FlACsiCCHw1Q
	 3ayN8Z4XJa/Ol/OFhQACk21YEgKR/pgcYQ+V6o5J690eKJQitT1guSQfN9KdTZND5b
	 WpbW2SJwB+bjeG2xQrHQ+2ntWy7LnnQ8al/K+mnpLrYb8JfqcenSfZ6iutzGEbkMt0
	 hT6VfK5/gJjOHZVh1HP+tn58HSiMGhikbkMJo0A3N8KKRZbtbCaCB9i96hrxR7sXpT
	 /tWT4nYpvh2pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A84D66064C;
	Sun, 15 Nov 2026 11:05:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BB9DD2E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EB53406C4
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0umvWCvbL9C for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:05:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99C9B406C3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jMDV1f8O; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HONeuAS/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99C9B406C3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:43 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7xmJm3780451
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 stFHMbB+NtGIBW7dyJrfxPszSoUjcYcAo0Jnh3qm0o8=; b=jMDV1f8O9dgrOhdM
 3CGKMGnWoR4GpPE88WSh6Tp67Ul230l13vBSwtLF68B9VXrdnBsNjNxKh9o5p/1e
 gbMngnG3huPO3FX9TeA4Llg+Hnfogqn3CoEh2pzfbsN1YMgaJWEmb70pXPuMlFe4
 kkXXT64kgCKa6ImY7VgwNuDfEwEkMBPD4hH5gL3mxmpjFevEA85g4Mt+tSLPMDUm
 qyGazw9B5NPD2vQjFNSHufRRf+0y/llNWL2YeG4bOIgEmr7XLB4UzlnL8GY7BWtk
 tZrIbDTgM3BzTGKlvq6AUI9r5XJFLk7NZ6xVYpujq2hBaEju33A2sWm1rrjB0y9b
 MYgIoA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8tqnf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36ecd5db581so1269950eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794740741; x=1795345541;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=stFHMbB+NtGIBW7dyJrfxPszSoUjcYcAo0Jnh3qm0o8=;
 b=HONeuAS/H+qbOr3zBQB+yyjHKFHKETEyDxtAG2ChVy/cH+M1mHIQHYxkEEWvXRvcch
 VUtnGAKEjFYbs5I6Qdoph03r8+M5/KCx/3grpdCxawolo0skiizjPwbkCMM/koQ+4zRV
 1XjVadmU2+nHWkD+ZCVxDQ2CewUv0TWCt+XUTWgZbkZWFiRaACbBFj1Pdf5PQ7gGfeHV
 aySG/Op4dq06Pb/ukd3QNfsKseYn630cWMPgLCSmIq3pYP3/TVdAPv/qT/UyvSO/wDe4
 xcikZBaJ6/0rXRmn/BItIG6n2h4gFHOCvzl9xL6mwb5BUQXIqRg5pjlAkExfDaDyr4K0
 sgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794740741; x=1795345541;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=stFHMbB+NtGIBW7dyJrfxPszSoUjcYcAo0Jnh3qm0o8=;
 b=E0i46JaJHl7aKbgkUS9WmqxIfmUAzBIEj6bivCvYIAmdn2cNrUtu/j2jUtyy53127T
 9a5CPEfgn+8qr5Byg83W/uXxCM64Bd6M0+USQpYoib0TqUtcn0rgEvKo1HGAWc3xKKSx
 Jq0MyFm39nRsi6efYK17DNS34YNhRUcGKE0WqaodbgFx7eeksG8dqU99VB1radFVyudz
 XVULS5+VmSENHaAWgmWuItx9Ih3xShfbTVwabZtvYJnZ/VWPELZm+vYncvJKu3A8Qw1a
 I8fGZyoaDpm1C18tt1hffXyEAmink9i6lqC4jThibnyljR03v5B05I+CUrD3pmfQtBuw
 TLdw==
X-Forwarded-Encrypted: i=1;
 AL+hErG7gR+RFpoTadbz3/lq8ZxcFgiKJ6cqcC7NuOfTGuQboM02ZWqK7w5BfRuPP+8gUouktEyXVZ0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++bIpnqCRE+ve2amBl6RgliyDLbOT3v4wON42O3nYlgfWuPk3e
 pPBcrtA58TBu89CmhWehgnV1hizlp2CkTkOMJTPFk0x3GctDpghVkKiJSoqqfqlhgTi/+tmz7Lu
 QYDrrGVIKBiXjqK4jGqCo5ZvTc5+TA6M2xPcCmEx4r17Jr46xN176n7SOIbxPLYTwa2QPIZ0=
X-Gm-Gg: AYBFou0alnhgCy0nkfc8RpWpO9kw1hqjs8uDZgGG88EB5HNqNINx2CGFGWxNPA6W91c
 KqLiHbpi3diV9FvCDDPz3Tqtc8d1fPZ/60fQlSEhB5lJyMNM1krBxtWHYrTEPOYhfHoIZoIWZLH
 9gfcK7p6hMqSzwm4gELK0SkQvBLsmK2XB8NohwXKlwkff2otiFnbxCf1BQZ5mkGsjA8OZSTjFDj
 oeixwgpPzRPn2NeDmwXhOQ+PNFU9RB4RWAjCehMX1GnFV6nimrMHDfM9B982K7iyUMMu88Sc/OB
 6J5fiw1LlYPF3Y7gY7swpWY8Mai2HfmClJXb3X4eFOmL7ZHyfTcLT/boWs+a1nXxRPFpyHllODt
 fjhOKDtrWaGi+ofzJl7FPUiGhmx7GLhiMRQgMlyk7+JX6tBCl2u/kN2pX049sTWVHZ1C2zpDbbS
 uaU5uqRkFnF19H7WzhHq2LFNRChSj1fm/bTHspjAVxBmhvUed0W0L+DEorCd6nYp9wXLg+4fj0O
 dRZ
X-Received: by 2002:a05:7301:4287:b0:36e:53bc:4681 with SMTP id
 5a478bee46e88-3796731594bmr6551037eec.37.1794740740537; 
 Sun, 15 Nov 2026 03:05:40 -0800 (PST)
X-Received: by 2002:a05:7301:4287:b0:36e:53bc:4681 with SMTP id
 5a478bee46e88-3796731594bmr6551009eec.37.1794740739980; 
 Sun, 15 Nov 2026 03:05:39 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm43456454eec.21.2026.11.15.03.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:05:39 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:35:11 +0530
Subject: [PATCH v3 4/6] fastboot: block: Add GPT/MBR partition table
 flashing support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-fb_gpt-v3-4-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
In-Reply-To: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Masson <jmasson@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740710; l=7103;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=wbJkfQzMX08h4BJKUd2u4ndk4riYcXFaQOqa9fC/ErA=;
 b=EUhCxqu1EAm0OBimFcoGhdwFRUIMljJdyxczAoKdXRMZPywz8fO0pqZWPiV6FtlNUWblcJcb5
 eg9dBX5ITCnA/RQ+DXuJz4RyuZNg5evORmSqNakkwk6aoFo8APyOlvE
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af99205 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Jc1x3kMOLBwOpwBr6UEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfXx6JGQevPreHT
 ZDn64QMyv1K8r7kBdbU1Rz5KVmn0T8HJcaBhMHNRA8xxUBIpyBLAcYSWZbcC5F/SPKWJvXOfIHT
 hax6d9CnnjXp6BRqfgl9IAlP5dXw0Bk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX3gAOM7QB12U7
 n+N9RBIUqMy+2+EMuMV4+Bf4srL1SY6+EW8NCxGkdrZIlEMwP8EjbFNVUFl/tO0vH9fF9LUTcg9
 AXMiLU/MH7cLNp5evtS0W8GvsKLA4jIJSQ3lEe6c4WXCwq/M9SSwNni4qLgtFUK/Lx8Ea+oLqS+
 chr8/2OGYq+MP8lBCvrMF2zyW91ahrdoj8NgwLn3emMI+yH0BDVNMuBnStFsH22eBE2i2QukjNF
 +H90yOcx+CudhEgt8G2UnppmUS3lqapG6wR5580i3WL9OsHwrBtBGlWOVQk57A/+FeVgim6A4v/
 JYSyJj+/nlojDYKU8XAlRkCXBpWORrtjbMiYVXhoQIykNEJxf/HnfPVwWpTUJQ3DJqcwpfmlW+h
 1ORAGaWlyWauaDrUhlZfJrsRmgqMKbE8UPnBj4v+aQj3Ht+7/kSReGZxd3XHmvV28hUVeDcRIN/
 2yNpkidgdyepIeGl0nw==
X-Proofpoint-ORIG-GUID: QPvzcmQr1YcH7XuQMjriD1LVmy8KfI-N
X-Proofpoint-GUID: QPvzcmQr1YcH7XuQMjriD1LVmy8KfI-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611150043
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

Add support for flashing GPT and MBR partition tables to the
fastboot block backend. This enables operations like "fastboot flash
gpt gpt.img" and "fastboot flash mbr mbr.img" for block devices.

A device can be selected with "<dev>#gpt" or "<dev>#mbr", matching the
"<dev>#<partname>" form used for partitions. The device is parsed by
blk_get_device_by_str(). A missing device number, as in "#gpt",
is rejected.

Update Kconfig dependencies to allow FASTBOOT_GPT_NAME and
FASTBOOT_MBR_NAME to work with both MMC and block backends.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Use "<dev>#gpt" instead of "<dev>:gpt"
- Merge is_partition_table_name() and the device lookup into
  fastboot_block_get_table_dev(), which reports an invalid prefix
  instead of ignoring the parse result
- Share the interface and default device lookup with
  fastboot_block_get_part_info()
- Drop stray backtick in the commit message

Changes in v2:
- Newly created in v2
- Adds GPT and MBR flash support to fastboot block codes
---
 drivers/fastboot/Kconfig    |  4 +--
 drivers/fastboot/fb_block.c | 82 +++++++++++++++++++++++++++++++++++++++++----
 include/fb_block.h          | 22 ++++++++++++
 3 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 9a5251d4b60..9099db33907 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -261,7 +261,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
 
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
-	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
 	default "gpt"
 	help
 	  The fastboot "flash" command supports writing the downloaded
@@ -274,7 +274,7 @@ config FASTBOOT_GPT_NAME
 
 config FASTBOOT_MBR_NAME
 	string "Target name for updating MBR"
-	depends on FASTBOOT_FLASH_MMC && DOS_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && DOS_PARTITION
 	default "mbr"
 	help
 	  The fastboot "flash" command allows to write the downloaded image
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index cf03c600772..f6fbc18f8f7 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -28,6 +28,13 @@
  */
 #define FASTBOOT_MAX_BLOCKS_WRITE 65536
 
+#define FB_BLOCK_INTERFACE \
+	CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK, \
+			  (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)), (NULL))
+#define FB_BLOCK_DEVICE \
+	CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK, \
+			  (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)), (-1))
+
 __weak lbaint_t fb_mmc_get_boot_offset(void)
 {
 	return 0;
@@ -130,12 +137,8 @@ int fastboot_block_get_part_info(const char *part_name,
 				 char *response)
 {
 	int ret;
-	const char *interface = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
-						  (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)),
-						  (NULL));
-	const int device = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
-						     (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)),
-						     (-1));
+	const char *interface = FB_BLOCK_INTERFACE;
+	const int device = FB_BLOCK_DEVICE;
 
 	if (!part_name || !strcmp(part_name, "")) {
 		fastboot_fail("partition not given", response);
@@ -163,6 +166,50 @@ int fastboot_block_get_part_info(const char *part_name,
 	return ret;
 }
 
+int fastboot_block_get_table_dev(const char *interface, int default_dev,
+				 const char *part_name, const char *table_name,
+				 struct blk_desc **dev_desc, char *response)
+{
+	char dev_str[16];
+	const char *sep;
+	size_t len;
+
+	if (!strcmp(part_name, table_name)) {
+		len = 0;
+	} else {
+		sep = strchr(part_name, '#');
+		if (!sep || strcmp(sep + 1, table_name))
+			return 0;
+		len = sep - part_name;
+		if (!len || len >= sizeof(dev_str)) {
+			fastboot_fail("invalid device", response);
+			return -EINVAL;
+		}
+	}
+
+	if (!interface || !strcmp(interface, "")) {
+		fastboot_fail("block interface isn't provided", response);
+		return -EINVAL;
+	}
+
+	if (!len) {
+		*dev_desc = blk_get_dev(interface, default_dev);
+		if (!*dev_desc || (*dev_desc)->type == DEV_TYPE_UNKNOWN) {
+			fastboot_fail("no such device", response);
+			return -ENODEV;
+		}
+		return 1;
+	}
+
+	strlcpy(dev_str, part_name, len + 1);
+	if (blk_get_device_by_str(interface, dev_str, dev_desc) < 0) {
+		fastboot_fail("no such device", response);
+		return -ENODEV;
+	}
+
+	return 1;
+}
+
 void fastboot_block_raw_erase_disk(struct blk_desc *dev_desc, const char *disk_name,
 				   char *response)
 {
@@ -384,6 +431,29 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 {
 	struct blk_desc *dev_desc;
 	struct disk_partition part_info;
+	int __maybe_unused ret;
+
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+	ret = fastboot_block_get_table_dev(FB_BLOCK_INTERFACE, FB_BLOCK_DEVICE,
+					   part_name,
+					   CONFIG_VAL(FASTBOOT_GPT_NAME),
+					   &dev_desc, response);
+	if (ret > 0)
+		fastboot_block_flash_gpt(dev_desc, download_buffer, response);
+	if (ret)
+		return;
+#endif
+
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+	ret = fastboot_block_get_table_dev(FB_BLOCK_INTERFACE, FB_BLOCK_DEVICE,
+					   part_name,
+					   CONFIG_VAL(FASTBOOT_MBR_NAME),
+					   &dev_desc, response);
+	if (ret > 0)
+		fastboot_block_flash_mbr(dev_desc, download_buffer, response);
+	if (ret)
+		return;
+#endif
 
 	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
 		return;
diff --git a/include/fb_block.h b/include/fb_block.h
index bee069a1dff..031cd7fbdae 100644
--- a/include/fb_block.h
+++ b/include/fb_block.h
@@ -27,6 +27,28 @@ int fastboot_block_get_part_info(const char *part_name,
 				 struct disk_partition *part_info,
 				 char *response);
 
+/**
+ * fastboot_block_get_table_dev() - Look up the device for a partition table
+ *
+ * Checks whether @part_name names the partition table target @table_name,
+ * either as "<table>" for the default device or as "<dev>#<table>". The
+ * device is parsed by blk_get_device_by_str(), so it is a hex number with an
+ * optional ".<hwpart>" suffix, as elsewhere in the disk layer. An empty
+ * device, as in "#gpt", is rejected.
+ *
+ * @interface: Block interface name, e.g. "scsi"
+ * @default_dev: Device to use when @part_name has no device prefix
+ * @part_name: Name sent by the host
+ * @table_name: Partition table target name, e.g. "gpt"
+ * @dev_desc: Returns the block device
+ * @response: Pointer to fastboot response buffer, set on error
+ * Return: 1 if @part_name names @table_name and @dev_desc is set, 0 if it
+ *	does not name @table_name, -ve on error
+ */
+int fastboot_block_get_table_dev(const char *interface, int default_dev,
+				 const char *part_name, const char *table_name,
+				 struct blk_desc **dev_desc, char *response);
+
 /**
  * fastboot_block_raw_erase() - Erase raw block device partition
  *

-- 
2.34.1

