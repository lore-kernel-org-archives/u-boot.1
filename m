Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A200606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UDID+rn6;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dR19A8Mh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SlwWk1ut
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41D9B40805;
	Tue, 24 Nov 2026 15:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z7ZY4bDETmVR; Tue, 24 Nov 2026 15:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE08140808
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795532633;
	b=gfBWVGpesZsPiXYPi+seOZsf1vIDDNFy2Oea/rh5ACWRxkKU+E20irAuVEGqTspCyF1B
	 2gtIU1aj3oQaTS2XjjhY//PZYFKdtX0J91nPCX+VBVzbPQYcWSEOy0x/5ZKhSvex+xokq
	 lWWFjQs3Vb8CNuMw0EmRnMkGrnmXsCeehs/cGwTghaLn2Go5I9e0TT2FukoaEURpkLCfz
	 78TGRTOLXbDSIv9k5JDCgVgAxVyZUngikDxDXNG0EKc2GpbWELezDbqZGoMuGTm3Zcvmu
	 TC3OzS3Q2leA1ce9EWGe3DhspkBzp/PREbZIuQeK3Vfc57f8M8/deXSboORExwl8CzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795532633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I8zDwnqZdOI/8VZsKbu4uhHv8PDtSiqLUCXMNTYGJps=;
	b=jT0c5VSCBVMEbjq65B1VpFJUbQJOdR3uv6x61/gdg70tiZeuIRUZ3zNFCB/9ejl/oDwi
	 Oli+fdofjED7sqklbbLrQwUtE0pKJU9CDNy4RUTj0xXaJdYko4dbpyJlqyKxJ8dK1jWjN
	 AhBb2KnXgAnKb+8xc480tEv/yuMF1bCt4p2Y6rdNj7+6k1wSRA6pM0aa2TlthfhjMsLHc
	 3aE13VuJtWbxXsoF5VzI6a+0Kr9SLbK304KhSo63nzpD0m5QhJwOTrZ3BoJS3aFTgG52h
	 a3Tj/U+G4/7qJfReS4DF1V61f7pU5FUPvXL1X4aCGZHFcuPhW7oZ0atqLH0YiN7ZdEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795532633;
	bh=I8zDwnqZdOI/8VZsKbu4uhHv8PDtSiqLUCXMNTYGJps=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UDID+rn6mF//J/eUDuxBYSjNzZ5e14FrtMtHbwhpQ0cIjKO1jOIDNAitBqMLkH6gb
	 0AWPTF7HYwT6pMhsK3OyMdZS5Crol+x/i24wYufsd3tJ+tcThtPZx8JvykF49LLD5s
	 LaB2xMZTdsCkEI7R9wY1C3wJTfldSva/aKHb9u27OTsGqr0KrexqU8ZLtR5KVwEvWM
	 4esLqP8St5jUBUZOpUebWoA0T3XV7K9wX6ac2vism/XYJTgP8dSw9ziY4OJO09eE8L
	 3w7C6LXUyyJ2WLz5CHP4tOVuYdedVeXIjda0vWGXm7kF2Hzs8+fXd0ufDf8Ycl7sm9
	 5moXhxY5t34Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE08140808;
	Tue, 24 Nov 2026 15:03:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72EC379D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57D52607C7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:03:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWb-k7MMebW3 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 15:03:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4065960843
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dR19A8Mh; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SlwWk1ut
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4065960843
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:03:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOEbtRn1236719
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=I8zDwnqZdOI/8VZsKbu4uh
 Hv8PDtSiqLUCXMNTYGJps=; b=dR19A8MhPXo1hT3g+qST2sSE52qY0yIRkWSPpa
 9S5ZhD04RnXtOv4D+OCY+a/NOyof8XWOJqrZq0d0MpmAmy4seTvBJCWHSIDPth2z
 a84gZW68eejEOx5Ka6JXVwjkhUj9EQLUQPvOPu340jG3XhWEiL8ntXOjt2xX/wfN
 42pABEBj4zqE1hCcy2yEG/7RwGpEC2AQb0XsaMgrD6LswtlrhJYD3WGq0xFfkaPF
 BkRNWvNDrWaPKPXcGDZvylgFdkq7LA+KKmubNONmC05ZtniU4HnGMlT5iqbkezcJ
 xl1Xzg9EFDumKbar7v+tt6djd9L0XgUajfTE9mQYIvUqAFlA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb3dd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:03:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so2646895a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795532625; x=1796137425;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I8zDwnqZdOI/8VZsKbu4uhHv8PDtSiqLUCXMNTYGJps=;
 b=SlwWk1utSkHzgB7fnq41B5rDmJj1mYXe/hgu2FlmAfN2lEOgSHtTQdFwXjHD5UvbrS
 0ZtyrYsYBj+tAjuAPasRaxfxalWVxCmXDOz0m7H4uM5abqtI1kAIcfgsC45ySkulmskM
 dDUyJRQPqJglQPnIvd0+TaLii+7YKgHH8J31vEQuZp5OxBXD3eIuCleiNB5PWdPJhhJr
 Wif8/jGpbOVwNwzvEcgAE9OeYqn7XAzuXvMvcc/tbXc0AiNTqGo5OeA509ktaNC8ffmb
 EBoYhv8TXEEBWA3ChsjtScK851qXdPxrQvQrl5HYA6T7uk/5VdLjwzZ6qCPG6uc6o0AI
 5FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795532625; x=1796137425;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I8zDwnqZdOI/8VZsKbu4uhHv8PDtSiqLUCXMNTYGJps=;
 b=ZTA0jorzWoIgjAmpelBdUkazlPIzOFa2wBrR7UVdBooTw//KAR/5pOs00uJNn6ZE7f
 rnHv1Wv3mgkluVsKDV1y8oqIdhnwUptmhU01iupwbYP7N3g67+xLs5V4BsFuVBvAm17M
 rexRezYhdSmcRNoPDVxKuRjMk5hIilyFm0PDIzuHt5jjB806acVKLn5uhS9IBfvcRnmL
 mBtwsWeRGoRWBicmOjG8/HCqnNiLcg6dDb1bc4bjHxdF7PK232dIFJwg64pqLzTLYYA9
 IHcJkFuB1M8NxJb89+fx+RLHz/j+2Q76qbccNMbh2sgjK1/D0vwl3Yu4GcYsHyigb9N8
 iTRg==
X-Forwarded-Encrypted: i=1;
 AL+hErFBPeheddzfLF08/Ny0Qq/ymDKgdo2J7NO1W9EXFiHnLcxC7atgF7GgH6EW3/invRndWM3wPw8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9M5YnzkfWFhUwxkLI1hXeAOPmCSKTTrefuzPEvqLw8tg96+7Rr
 6Fq4Dqa1/gjdsRs7UiShMYQ/AL+Lva+ZuvSwKK2OOT7c7/cLP2AhQ0Q33cJP0ppL52VsMEkMf4p
 xmB8gMp2YbhkWF+na3q3669UCP2x93cUa4QuDBoj1FnZOf5OoRoCj7wqOqj4YPiBo64YBRAs=
X-Gm-Gg: AZFdTZcE3bpvcIgffRNF3cdOtVKBJR71T+Vn8xYzeoNT324iVvJGlFn8Kiu2Qvu8/6X
 QktlE5/gd+9ZRGjtS7QLcgYTYXIh+gIrRlPAYtPFk5XN/xvqBDhxKcGchojV0m0FkR45TBkmtwH
 y+sHWAeaBo+1qEtSwgLgjJj1oFyKzhlHFDBIkiq53Xva6kua2dzBxn7d3tonVdi6gqzbmlfcizk
 WEoyYJcTZaGOTOvfRZiVbMBRivtG328BJhBI/JZsiGs6vuUJEK8MXwDVPUgldsmuet3TSvSo0x0
 +DMoZ0bal1C2uzyGsb+IdPNAEA4XuDEsfNcrjdwVN0YrOerjUams/hIGD2SkZylirMFNDc1G9YM
 J3VMCqdE8LuVxbixCKhRO7QiMkAH4L5W6j72Tl69A6nUABO2RHwoDL/KoWRNR55DJkbTj5h7zB1
 xWYZoDn6wHt1RB
X-Received: by 2002:a17:90b:134e:b0:3b0:a7e7:68f5 with SMTP id
 98e67ed59e1d1-3b41c7b638bmr11449504a91.7.1795532624707; 
 Tue, 24 Nov 2026 07:03:44 -0800 (PST)
X-Received: by 2002:a17:90b:134e:b0:3b0:a7e7:68f5 with SMTP id
 98e67ed59e1d1-3b41c7b638bmr11449470a91.7.1795532623996; 
 Tue, 24 Nov 2026 07:03:43 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afec08asm532085866b.73.2026.11.24.07.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 07:03:42 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 16:03:39 +0100
Subject: [PATCH v2] net: fastboot_tcp: implement the download data phase
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-fastboot_tcp_b4-v2-1-e32162bbab5f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6tmgrIrjyHoaQaRmkRih2CsEQ7
 i7FuHczyZs/8/JnRugMErtEM3M4GjK2W0HuIqYb6O7ITbUykweZioOUfOjJO4SW10BeWetLr/t
 SJfxUiTMcdYZS5Wx97x3WZtrUt+LLNKgHah984UIBIVcOOt2E1c+873DyIW8MeeveW7dRBM8fN
 UbBBU/SFPJaZAK0uFqi+DXAU9u2jdfBimVZPoCraWr5AAAA
X-Change-ID: 20261022-upstream-fastboot_tcp_b4-5d17a3c8e2b9
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b05a752 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Oh2cFVv5AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fQQLlaWUnKom9Kcrr7AA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: KLw2YCJIWOj7zl5KiDSoTOYd8xgAON17
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1OCBTYWx0ZWRfX12jJg/Jmf2yo
 8oYdor9vzyhvzuW6iMpQpWgiDOsqYbeX6tdBaKOBiIpCKZJfbv1DsVXNGy6ahtDlI9zl2ijMmjA
 BE6Os/HBgyvSz9s9zCyonktlOWbt0SQ=
X-Proofpoint-GUID: KLw2YCJIWOj7zl5KiDSoTOYd8xgAON17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1OCBTYWx0ZWRfX1khy0RqjiHur
 zf5hMsuWQR/6rDFjjBOBSrVHihQp18TpFAfpb8gkgLv5nPU+6NLHqbO8ujPTmuJ/4+EVcCao/L0
 Oc4DgQg084DFaDRbSVyAZZebPZhcoOXQCa2EalNXVXu67Op6gg63Pm5TxhhrCSNPukR/yHgpzE0
 75Ahkfqagg5hl4kr3Jmt7JGYzBM699jSmkX02A4vddG45V27ZxSF8L9ZiN0NWeoYAtRO9wwLID7
 QH/MYi6CIgixTXYE5JNVW+VEDZFpkAKpPXHGYpzIadvAsw1K8IcYsntTsiQjMWfTqafSsO9h5dL
 cDggtcp/KpaGJzBjRqXVlI1pIpFJWRsfWZG7DfPDwVz/168YMsk4CIUukiFzT6H9vs1SkKVtyVq
 QkJ/xqvo+fvo1wM4YpRY+mgXmbPN7FeS516QFKPBa8BhGTRQvWfbM1zdIZmnRHehT+2y6R2TxyE
 wnMu8YpcGgwjvaRpb0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240058
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

After "download:<size>" the TCP transport parsed the image as a command
and overflowed the 64-byte command buffer, so "flash" and "boot" did not
work over TCP.

As described in the TCP section of AOSP's fastboot README [1], data
packets carry the same 8-byte big-endian length prefix as commands. Feed
them in order to fastboot_data_download() from the receive callback, and
reply with fastboot_data_complete() after the last byte. Segments that
arrive ahead of a gap are left for the peer to retransmit, and command
bytes after the data are kept for the next command. A new connection
calls fastboot_download_reset(), so a download dropped mid transfer
doesn't swallow the next session's handshake.

Also check the command length against the buffer, and count the
available bytes from the consumed offset, not the absolute stream
offset.

Tested on QEMU virt: "fastboot stage" of 1 KiB, "fastboot flash" of a
64 MiB image read back with a matching CRC32, and a new session after a
client dropped a download.

[1] https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md

Fixes: 443d319180a6 ("net: add fastboot TCP support")
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Based on next, which has Carlo Caione's "fastboot: invalidate stale and
incomplete downloads" (c99169ecd5a).
---
Changes in v2:
- call fastboot_download_reset() from Carlo's patch on every new
  connection, so a dropped download doesn't break the next session
  (reported by Guillaume La Roque)
- shorter commit message
- rebase on next
- Link to v1: https://lore.kernel.org/r/20261022-upstream-fastboot_tcp_b4-v1-1-466a9f181ac1@oss.qualcomm.com
---
 net/fastboot_tcp.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 148 insertions(+), 19 deletions(-)

diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index b9b4f707b14..5c16e59f4e9 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -4,9 +4,11 @@
  */
 
 #include <fastboot.h>
+#include <fastboot-internal.h>
 #include <net.h>
 #include <net/fastboot_tcp.h>
 #include <net/tcp.h>
+#include <linux/kernel.h>
 
 #define FASTBOOT_TCP_PORT	5554
 
@@ -16,17 +18,95 @@ static const uchar *handshake = "FB01";
 static char rxbuf[sizeof(u64) + FASTBOOT_COMMAND_LEN + 1];
 static char txbuf[sizeof(u64) + FASTBOOT_RESPONSE_LEN + 1];
 
+/* stream offset of the first byte not consumed yet (commands and data) */
 static u32 data_read;
 static u32 tx_last_offs, tx_last_len;
 
-static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+/*
+ * Download data phase: after "download:<size>" the client sends the image as
+ * length prefixed packets (8-byte big-endian length, then that many bytes),
+ * normally a single packet holding the whole image.
+ */
+static u64 dl_pkt_remaining;
+static u8 dl_hdr[sizeof(u64)];
+static int dl_hdr_len;
+
+static void queue_response(void)
+{
+	__be64 len_be;
+	int len;
+
+	len = strlen(txbuf + sizeof(u64));
+	len_be = __cpu_to_be64(len);
+	memcpy(txbuf, &len_be, sizeof(u64));
+
+	tx_last_offs += tx_last_len;
+	tx_last_len = len + sizeof(u64);
+}
+
+/**
+ * dl_consume() - Feed in-order bytes of the data phase to the download
+ *
+ * @buf: Received bytes, starting at stream offset data_read
+ * @len: Number of bytes
+ * Return: number of bytes consumed by the download (the rest belong to the
+ *	next command), or -1 on a protocol error
+ */
+static int dl_consume(const char *buf, int len)
+{
+	int left = len;
+
+	while (left && fastboot_data_remaining()) {
+		u64 n;
+
+		if (!dl_pkt_remaining) {
+			/* packet header */
+			n = min_t(u64, left, sizeof(dl_hdr) - dl_hdr_len);
+			memcpy(dl_hdr + dl_hdr_len, buf, n);
+			dl_hdr_len += n;
+			buf += n;
+			left -= n;
+			if (dl_hdr_len == sizeof(dl_hdr)) {
+				memcpy(&dl_pkt_remaining, dl_hdr, sizeof(u64));
+				dl_pkt_remaining = __be64_to_cpu(dl_pkt_remaining);
+				dl_hdr_len = 0;
+				if (!dl_pkt_remaining ||
+				    dl_pkt_remaining > fastboot_data_remaining()) {
+					printf("fastboot: bad data packet length\n");
+					return -1;
+				}
+			}
+			continue;
+		}
+
+		n = min3((u64)left, dl_pkt_remaining, (u64)fastboot_data_remaining());
+		fastboot_data_download(buf, n, txbuf + sizeof(u64));
+		if (!strncmp("FAIL", txbuf + sizeof(u64), 4)) {
+			queue_response();
+			return -1;
+		}
+		dl_pkt_remaining -= n;
+		buf += n;
+		left -= n;
+	}
+
+	if (!fastboot_data_remaining()) {
+		fastboot_data_complete(txbuf + sizeof(u64));
+		queue_response();
+		dl_pkt_remaining = 0;
+		dl_hdr_len = 0;
+	}
+
+	return len - left;
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_offs)
 {
 	u64	cmd_size;
-	__be64	len_be;
 	char	saved;
-	int	fastboot_command_id, len;
+	int	fastboot_command_id, avail;
 
-	if (!data_read && rx_bytes >= handshake_length) {
+	if (!data_read && rx_offs >= handshake_length) {
 		if (memcmp(rxbuf, handshake, handshake_length)) {
 			printf("fastboot: bad handshake\n");
 			tcp_stream_close(tcp);
@@ -38,18 +118,28 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 		memcpy(txbuf, handshake, handshake_length);
 
 		data_read += handshake_length;
-		rx_bytes -= handshake_length;
-		if (rx_bytes > 0)
-			memmove(rxbuf, rxbuf + handshake_length, rx_bytes);
+		avail = rx_offs - data_read;
+		if (avail > 0)
+			memmove(rxbuf, rxbuf + handshake_length, avail);
 		return;
 	}
 
-	if (rx_bytes < sizeof(u64))
+	/* data phase: consumed in tcp_stream_rx() */
+	if (fastboot_data_remaining())
+		return;
+
+	avail = rx_offs - data_read;
+	if (avail < sizeof(u64))
 		return;
 
 	memcpy(&cmd_size, rxbuf, sizeof(u64));
 	cmd_size = __be64_to_cpu(cmd_size);
-	if (rx_bytes < sizeof(u64) + cmd_size)
+	if (cmd_size > FASTBOOT_COMMAND_LEN) {
+		printf("fastboot: command too long\n");
+		tcp_stream_close(tcp);
+		return;
+	}
+	if (avail < sizeof(u64) + cmd_size)
 		return;
 
 	saved = rxbuf[sizeof(u64) + cmd_size];
@@ -60,24 +150,55 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 			     strncmp("OKAY", txbuf + sizeof(u64), 4) == 0);
 	rxbuf[sizeof(u64) + cmd_size] = saved;
 
-	len = strlen(txbuf + sizeof(u64));
-	len_be = __cpu_to_be64(len);
-	memcpy(txbuf, &len_be, sizeof(u64));
-
-	tx_last_offs += tx_last_len;
-	tx_last_len = len + sizeof(u64);
+	queue_response();
 
 	data_read += sizeof(u64) + cmd_size;
-	rx_bytes -= sizeof(u64) + cmd_size;
-	if (rx_bytes > 0)
-		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, rx_bytes);
+	avail -= sizeof(u64) + cmd_size;
+	if (avail > 0)
+		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, avail);
+
+	/* "download:" accepted: what follows is the image data */
+	if (fastboot_data_remaining() && avail > 0) {
+		int n = dl_consume(rxbuf, avail);
+
+		if (n < 0) {
+			tcp_stream_close(tcp);
+			return;
+		}
+		data_read += n;
+		avail -= n;
+		if (avail > 0)
+			memmove(rxbuf, rxbuf + n, avail);
+	}
 }
 
 static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len)
 {
+	int n = 0;
+
+	if (fastboot_data_remaining()) {
+		/*
+		 * Image data goes straight to the download buffer, in order:
+		 * a segment arriving early is not accepted, the peer
+		 * retransmits it after the gap is filled.
+		 */
+		if (rx_offs != data_read)
+			return 0;
+		n = dl_consume(buf, len);
+		if (n < 0)
+			return -1;
+		data_read += n;
+		rx_offs += n;
+		buf += n;
+		len -= n;
+	}
+
+	/* command bytes wait in rxbuf until they are complete */
+	if (rx_offs - data_read + len > sizeof(rxbuf))
+		return -1;
 	memcpy(rxbuf + rx_offs - data_read, buf, len);
 
-	return len;
+	return n + len;
 }
 
 static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen)
@@ -97,9 +218,17 @@ static int tcp_stream_on_create(struct tcp_stream *tcp)
 	if (tcp->lport != FASTBOOT_TCP_PORT)
 		return 0;
 
+	/*
+	 * A download whose connection died in the data phase would
+	 * otherwise swallow the start of this session as image data.
+	 */
+	fastboot_download_reset();
+
 	data_read = 0;
 	tx_last_offs = 0;
 	tx_last_len = 0;
+	dl_pkt_remaining = 0;
+	dl_hdr_len = 0;
 
 	tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
 	tcp->rx = tcp_stream_rx;

---
base-commit: b7ed8d19d83d08d34b24b15c3dced7fd6c284939
change-id: 20261022-upstream-fastboot_tcp_b4-5d17a3c8e2b9

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

