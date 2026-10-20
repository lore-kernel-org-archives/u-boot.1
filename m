Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF74606A320
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BlnuS83S;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MclFpbYZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LFjvdMrW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 891D960808;
	Tue, 20 Oct 2026 07:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYjOy3oL6P3f; Tue, 20 Oct 2026 07:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C64B607EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792479729;
	b=sQoP2a/LOh0u2TIjlsz9L4pgmePpII3Hw8kCwVo+qWSlsgy8aSQPPPENBhIAVWcSsFQy
	 VjsYajD+fsHIEgwDNeAMhqUQp73eb3CjRQy7KxfZHv/Zi+SCqB7eo2hVmFGNUo0kgRKL5
	 BxldSeWQRQhENX/zZpzVTYAdU8Gw2SmOOgOri6jHkbbSlJP9JRei46dUCGCzLr5EWPEKz
	 wLymWKu9B1aqg0abTe63NXX2R7/EWLFawz3RKEsGeGxl0e86FRjf1aG6UlhI0avT6aeH1
	 YIhTi3l0pe6t1S1sGWt2RttJGYQJPiv3OL58eib5UicMcVf3rknnn0NZMdIgXIpnpTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792479729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8dtOzR3stLDnLaPWOfJM4K5ZAWzv5stZjBpHnGIi9mw=;
	b=OyVyOT7BFNeyMdx4YmLNJYECRUMi6RVqZNx0iVnOu38HeXqx4lKR2O8Sl2mPsT8Qa/3G
	 KFe0hPgo923wYVqf0n4os+0//garoGPjYPTBSoFHmwHV5WQImknAqbIFjNNmu5OHqH+y/
	 e9Bq2gN8riZJB16KevD+w3pEkxxNYEnZOqNFP4FJERQ2mVEcOZDUcPT+eOAtL//fXpUVH
	 emvA85gUNTBw9gVc2vKbD0FFiDxkS3XEZnEHU6qLCKLloDBM2xF9qlslwpjpKdv3UB7bG
	 M9KRLELeIZtAy6zmgfim2yAZ1MzWkSXEgqT9newPuNg50QYUOXMvTFzBiVMWnz3sXIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792479729;
	bh=8dtOzR3stLDnLaPWOfJM4K5ZAWzv5stZjBpHnGIi9mw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BlnuS83SZMT6i7DJczSljUI3jS0EowAgOAa3OOmcKxw6PfdrcHNc+SWnAl7IDopi3
	 Svrh2TysrvtaW7wvpqe/GrJkOL+zGXplxFrVPizYnY4eW3XTz9QQJcslh3vFePuUje
	 lEInD6lpXhASXSrtV8DM0LmyT++SLkBFPbMEF5wjwQsK4OcV7o3zRuZStB2MAA7tZ/
	 2Z6V2WCjgbLfueXaFCu7X+RTDdU7oJAL5bEkUlyHh8gf8Xiab4Q+2N4ziUOHwLIAcn
	 mSizAw42cuhkEPzV/nERhoG6+k28VnuyocEvR1XHC4L7d1lMRcI6M4YKf32pmwFZB9
	 XsFIdfYaduQ/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C64B607EA;
	Tue, 20 Oct 2026 07:02:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAACD1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0C8A40804
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r367rimTWTOv for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43B79407FC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792479724;
 b=kNv0iAG+IpKr2Hy1HSOCc9kbLiD8bpQs7EsXxH4Cd/BAP6i/rUvK7RR7YDBQzf4RGSo5
 +kzexMrIpRRLotUpbDrcajvnKbOuo2vq0PbMm5tZ/pmaDR0Fz1nNC2QNIybxUEvQQ8EIB
 EDJIWEfXNC5Z61fXUvTXSfDRAhhGXUnCEB45OIm5DGOa8UVeIvyCHfkpwR9tu+IloQwEw
 jCTunczOiSmVMwpWZIf6nIL766lHs/4Ie8gfy/IJ8ncG8db0XXLeg6tl6DU6sJqraohk5
 mJcfhcU3OwJOWEOD/lKWAwJnmgeQ7pICgTt0g3yTke+TF2sFunRREa282WsPkM3V68w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792479724;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8dtOzR3stLDnLaPWOfJM4K5ZAWzv5stZjBpHnGIi9mw=;
 b=X+UfwQ3r9QBPtKVNk2qJNS9M3u4EuyIruCA732ixOM58ZXIpPO6riYo22WrB3RXJ22DL
 BSudssZOoVan+vtWOK/OZOTNIupQBqffvuHjw85KKU/EJ7kjmOUz4KVvRrdG7eAfDkYuA
 0yhOjxN6Tmhc1tRzWibN5Kp8tFjSN1sXzNJf+uYSs4C98Yjl4D6GzPO58b9LEmfwvtc16
 kOyneZv4mK/ibEBi3ylRLnCBV8wbnvUf1KKvUNdDFy8DaB9vjPGEydTFT+MBGCl7MsyIj
 rnN33cLZtRSrHsD8R2yFJCl8tvSwZV2W7M2fCkSXmyVrUp4tP8YdhlSKMn4MqVzuTvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MclFpbYZ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LFjvdMrW; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=MclFpbYZ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LFjvdMrW
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43B79407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:02 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tOhl4032275
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8dtOzR3stLDnLaPWOfJM4K
 5ZAWzv5stZjBpHnGIi9mw=; b=MclFpbYZA69MS5Y1JU25wvJOwRo/h4YBrsKDfk
 w4gCxPkwABLRVAZLpJsprPJHwInIDVXeJIUZnGEPZGQpO4IPpPFGqngBLBkYCC/W
 ECH69TezjB3rD1mfC5/91iHYEday+QBK7mxEk9dTcYMe5nHi6c+jCX1w96Qw/EQp
 zVnfB7ca2qIkpQjqG94VNS4ZQXjoECEgC+R/P2jrCPno6w++NzM3NEg2B7PDjTj6
 +UB1NBGAVq2rVIcEAcZ6L1LzWrtWXES2UKmRom25m//yNpbsmkbuiCuzao2zS+xH
 fsHddQY6Z7e0WPkdZKznimTwR6l+MbsWsVrelC5LsH10Xp2A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5q98eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso4372529eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792479721; x=1793084521;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8dtOzR3stLDnLaPWOfJM4K5ZAWzv5stZjBpHnGIi9mw=;
 b=LFjvdMrWVayge/ldP9U3tZPRBE9vwjQ5ex+T1ZvC69wMNyZC+vb+sl1n443XXkQdI5
 sIM/yiKzFN/ujQ+DT2j4hAaUjTIAyGoJW01+6wXpig6DzYg7rVFppcpt9JBw8Wv2PZZt
 SuNqhn0SqJ99NRvfKEkMuMiTdZtbckew5vjZ94RpQSx0kM29nxVnBHhuIlp8g6H01Z3u
 W6L4S3GEdpwgnEPEU2Ywe7bK+VRxPTcR4cYF3u/tUdG413ecYd428utwvnlNmxtGCTZ1
 0JpvyhIdcynknA9tOSGD1VCFI0OkHPMgmwIxiOBipYn+2c/ePpmFG54eR2XP0drm3kpa
 bbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479721; x=1793084521;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8dtOzR3stLDnLaPWOfJM4K5ZAWzv5stZjBpHnGIi9mw=;
 b=Mil2imKHUo4R3QAvI/1V1KIUp6rIcMI+x3nzr2Ak5hmX9c6WNICZTiU0VKbSmnwoja
 BN6Ru3sIbzC4u5P+P/k+bVx8bIYyhfFjp8EbJUCUgHpt/8vo5UxjoKXAgqYekmS8XApl
 OUhioyBvul6SSYH9e+jPlHGWap9NSKa4TUYiUE5iQVsj3TrEDtlQ0NEFqgyc6RVWHBSO
 ORvf/zK/AmOpT8YIygFq3ZlYqJttwhezOaTjgJOU0Tcwy8vIJ+gvPUIpQtu2vYvKIjA1
 7KPLsvk6cO9Fw8B7aTjm5LvAJjQ8mLge0EuJLaviywW47WaW0svf7PhmdlMM1iMCybyt
 XmNg==
X-Gm-Message-State: AFq9FYKxiyBvncOxrlZucbMBwxORJqB8lUz4hPtP2XFsmt6SlFtFgE/1
 MQy8R9mmqj8EeJuDVwj4FrKJFujwVH+MYEYYhF/ES0ezOFyuUXfMwy6YAYxdgcoIF/6s1ettQwO
 6jBcZZG68CTBu3xgRqUrikq51NVWjw1HTkHjVt1XrQXswrEzMEUopNsqpTKMlrc9fD5EdMJk=
X-Gm-Gg: AYBFou3T+w0hid90e09d13wPo5f9+xZPmh90CtGxqZImkPIORcGzpy7MguPrH8T3lMx
 nZqw8I4g7e3Go14BksdVklGcvNtCinR3S5YaZ7rgNnkbUcnXrAPPe/QSwibm2+CmtHMkHGRJuod
 JXV+FI2YOJm9AFrnCmC2wyaf3+s6nBTKWe/xIhKCUCyVmsHd/VNCclxkX1aJDVQPLkpNBW9E0+n
 JNqQRZfSbgFPS0uZ/DbVPTPOENdn0FB1EdKE2TSJTpTdxkV7dCQqxjgPS5jZm7MPuD52Pwl6MqI
 JB+G0cNQr0pRQQvZc9N9HaN0TqckyR2KnuBrUnOWfe85toVKAQyiVKcjUixSno8AfBwJTJoqGZa
 Ha02nyKZ5gaHfpIrjFwWgcjq7vyi6tE3vUy0pVYYPcplCNsgcrx5vqGpuMRi7wwHB5xF5ueacHA
 A7gTTbk1b9DGnEuvdEV2J1g/Mj7Dc=
X-Received: by 2002:a05:701b:2092:20b0:168:3243:c907 with SMTP id
 a92af1059eb24-1851238b3cbmr15321457c88.24.1792479720615; 
 Tue, 20 Oct 2026 00:02:00 -0700 (PDT)
X-Received: by 2002:a05:701b:2092:20b0:168:3243:c907 with SMTP id
 a92af1059eb24-1851238b3cbmr15321183c88.24.1792479715228; 
 Tue, 20 Oct 2026 00:01:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm38294225c88.4.2026.10.20.00.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:01:54 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/2] qcom: capsule: build fw_images[] dynamically from
 the partition table
Date: Tue, 20 Oct 2026 12:31:47 +0530
Message-Id: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsR12oC/4WNyw6CMBREf4V07SV9CIgr/8OwqKWFm1AKXEEJ4
 d+tJK7dTHImmTMbIzuhJXZNNjbZBQlDH0GeEmZa3TcWsI7MJJc5vwgBowkejB5o7izUa689GnA
 vQK8bS+AUV7LgD5lxxaJkmKzD93FwryK3SM8wrcffIr7tT63+qRcBHGxWZs4V5bnM3S0QpeOsu
 7jzaQxW7fv+AZWwti/TAAAA
X-Change-ID: 20260811-qcom-capsule-dynamic-fw-images-f303270b2503
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792479710; l=1852;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Kk3GB8R+tuOe3+Utyd9CnfYam3lRsdtRJ5+zWHcl6Yk=;
 b=3Af7bVMYTHfNamFG6D24/50ZylEGeczMAEVMkL607P5od+ZdbEapbnh/f6D6WoyujV5adi1lD
 V+Cs9bFc6fyA3u339vDn/R9BLhgPNtaby/KUppseyBg3TEuqihGlYVc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: R5xgoVJbM3RRW5rMoEaWafsYhpcpfx6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyNyBTYWx0ZWRfX0VGD+Eex8Ruc
 RU78w10V6LOxPc9q/0HHnSfBY/XdSEJH1jl5Noy+/1bJMGXuoW4pwXeA4oaQurifVeQZXzlwzOj
 yJcxbMCfHWNVQhQpbP5Y6vinrr9piKZduUP3xwIzDeYnEvzwWBuXCp7Q1BqC3Uc+bqO++i12GGu
 8Zyk+NxlJtOB2/SpweWu0ruFKKiJUUwv66h629zlOdu1T7oVzGnnNgFYD0VX6M7+OvYjNPZi6Df
 8Rj9igAOgpBXQrZDe7LjWu6D3Outm9pxsPD3f9BoGBdRxPcgT2iyEhcmSkTRBdBtsbdGdseLJJP
 +NibuZb2AmyKKdmA2rUohg3EpEbo2HTO56C5VjIaYhcX18lPdUsiGVIFGr1KUcyzA6EoGQVsdri
 CWKtMBgFRszoVw0wKqg3ERKRwwV8KhXpJfMSGnHGRcAKPtqJHl9fZWgYJpJr/ZgplNj6DL5CvQW
 L2Gp+PeTN6HUqEW2sNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyNyBTYWx0ZWRfXwsLqoo32Kt8o
 O32rSEnXeGywHEWhrHKkDFj3zpXtZ6GdoOiTMwIHLnoRqywi6m8mzjxsX+kKuFD+CtB2UfEyGXC
 o62MGnTcHVE56SmNQ53MRmC0Ha0xe7I=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad711e9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VqgeFaR0hm7Ch2V_BxkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: R5xgoVJbM3RRW5rMoEaWafsYhpcpfx6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200027
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

Add capsule update support for Qualcomm firmware partitions other than
U-Boot, such as xbl, tz, hyp etc.

These partitions are found dynamically from the partition table, and
the fw_images and dfu alt strings are constructed in runtime.

Since each board has a different set of firmware images, the
image_index of an image is therefore not known when the capsule is
built. So add a weak hook, efi_capsule_resolve_image_index(), that lets
a platform find the image by its type GUID instead (which complies with
the UEFI spec).

---
Changes in v2:
- Drop the efi_firmware_get_dfu_alt_num() series, no longer needed
- Drop the OsIndications patch
- Add efi_capsule_resolve_image_index() and a sandbox test for it
- Assign image_index in order and look the image up by GUID
- Replace apdp with multiimgqti in the image map
- Link to v1: https://lore.kernel.org/r/20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com

---
Balaji Selvanathan (2):
      efi_loader: capsule: allow platforms to map a capsule to an image index
      qcom: capsule: build fw_images[] dynamically from the partition table

 arch/arm/mach-snapdragon/capsule_update.c          | 756 ++++++++++++++-------
 arch/sandbox/dts/sandbox_capsule.dtsi              |  15 +
 board/sandbox/sandbox.c                            |  13 +
 doc/develop/uefi/uefi.rst                          |   5 +
 include/efi_loader.h                               |  14 +
 lib/efi_loader/efi_capsule.c                       |  14 +-
 .../test_capsule_firmware_signed_raw.py            |  27 +
 7 files changed, 614 insertions(+), 230 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20260811-qcom-capsule-dynamic-fw-images-f303270b2503

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

