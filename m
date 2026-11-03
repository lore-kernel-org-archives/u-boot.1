Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82116606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UnqRxbC8;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gtdxu5KW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GJtlMxhX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F361608AA;
	Tue,  3 Nov 2026 13:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rSPfAyA19W7e; Tue,  3 Nov 2026 13:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 801076083A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711159;
	b=nKiYIt9xq5WZgrxzcQilIodwg/RjlQ38txrGcu/XUbw1QUOlbbyUiCWPseFXTt+YgvNU
	 ROb5itrd0yrgGXV7uoHryb8t2yeOG7OqkZGnAXs8RDN2Bjt49mLqzJVZvY83jaKd3gxqq
	 9AC0abJRyqAGSnj5d5Cbc9TVmcTCuBODPpnlOx6szM10ATyKLTAvRqidaxv3P6mf6tjW/
	 REQuUtud6C4Lllpo0ST1bklAcmtX7bxx0cV1dTmyTZ1dviIm26GnYlWL9a6iEztBjkuaS
	 uraGYFO1ugFYGlizF8/lDSm24zacRym9jzb9SnKUM0erpYPFu2khM1lTYxeWQ8MYdzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DFQWQRF434+B4Ywz4DlMntPFpJUGIYTLc/7rRHHMe9s=;
	b=SRrcXwkGJCZWmuxRD9zP6sQDuVkOzzVXSz/NjKyMGF3leLWpWQreX4Y/ZJYnO1qrJYEG
	 VFk5ctNMcEfT7VDbiVMRoJAKyd6GKaPeFLmsrs+XpfibUMruVbKrtcJDsVJQAYV+08V2b
	 R4Ez75dGCc1OzOw42Ke4duWin3CUcO0kI0TJAFJHN9VGH48zHNtKWoDOjX+7+FQIX3J8X
	 ZcNDbi2UtG2p4vFqBx72csFJnF4XwfjTRKP9b3cfAe7csXugN2c3+LXCZ7CDqK4cpi+uB
	 hMNipFXx4wPuzBQKVJlnrPB81Ik6dc5G3CDiT3OP9/pGwhP5p3bpmxEHXL63rG4gyhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gtdxu5KW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GJtlMxhX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711159;
	bh=DFQWQRF434+B4Ywz4DlMntPFpJUGIYTLc/7rRHHMe9s=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UnqRxbC8gHLSTbsikG4kkAJAGlzt+c4qlEoFVU3J376OzEeJkUk8r/tsFmNm52jyV
	 Hr2h0ADHPY8J0cljS9sLrZwoHUmGbBCVH4Tvxz6V+E3P9qaAvYimm+XB8BnsK4FLZx
	 9M9HkI/otwfq5WE6VsAgj3/2lH3CJ8lb5DF3D8faQmuxbHpZrQiUgtSYp9YMgl/f/n
	 yJ0mTVTYEzBBxi+s8WBNc+aPyDkxW0pMoJPc9sq8Hh2OG9Z2YtVVrqC9i0rq/B3Ahy
	 8SdvIS1cKsiFt2L432YgUxjghnbCCSpyzv/ycx3mAYabfMknCk/igmXwJwLD7crTM3
	 VTsSUPGTFtgxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 801076083A;
	Tue,  3 Nov 2026 13:05:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC041A10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E450606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kvGHzaiCDdSR for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BBC0605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793707487;
 b=JH1E6Wtr85z7WIai2lK869S80qcc3wX12i9BH9SRvkWPLKCBBBboDswobDgFcdJSNkdq
 4imcJyawMRVVLe1E5AXaEA84Br/CNZGNeLYNimSIDAwI7B5UBGDZFfHs42wJbUDQWxqXm
 dtvaeFgNz5eTqsRZU0Qu57dhiyMtv82pT1qplDWR0jIkTlP5oJUx/TckPN96WBIspMu4i
 qVwam63MSb6gUoARjDwkl/VdpqZiKBZOwpXNPbabWIYtKpCYniHJaT9E6XSiF6PqxmESI
 owQzecsPvMrBXyWVpuxBl2Xgj0/On51r1vTBJCxLt3kLGe7f0cM0odE1O1pUFGICMuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793707487;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=DFQWQRF434+B4Ywz4DlMntPFpJUGIYTLc/7rRHHMe9s=;
 b=efjW9dwDGb2rkuWkZlWWiCzB28QXakY7hnKXe8+MSaHgB6g7JYgTe3fHWapkFE+ov6xX
 jX6ZNYyCbNKHXlU4iVB03zDce/WxErHR/SbDEeIPL/o2mvCTmcpgthKRcHj7BY3D2vI+c
 AesCK3ykFBLRlZBRCca8c24IbdgqlIDY+TxHmho0PJIIdoPyoFOOt2biC6LaIqI0B5kR+
 SdN34XSPmZbfapLKuOnHsFyrxerX0Q9yzfYW2y4WHAPgmDVob/qJDBGL+EEJM9QTx4x8k
 mZSpH/Bh6PHAQ0oCWhgRTURCNk0Kw3u2/VvJE26XfvMaAjWqCFAH6DmOYJZaKfAgYAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gtdxu5KW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GJtlMxhX; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=deepak.g10@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gtdxu5KW; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GJtlMxhX
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BBC0605DA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:04:45 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAXRY2201960
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 12:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DFQWQRF434+B4Ywz4DlMnt
 PFpJUGIYTLc/7rRHHMe9s=; b=gtdxu5KWwauYW8dDs2MMCScIj3E7Eh5jw/hx0u
 E2zuThMPCuw4wp5yghCPa7Sdw9cv3xgYl9bHWAMt5j1bWLYCUxarbsZAG8Ph96ad
 qTW2oVGHhZPHUZZhDpCTSE5zOwX39s4iwVuNf+cIU//VhPe8BCRzjzIg5DPusk0T
 7Sh/XuSuMl070XjFpfOjlA/CDeB+KJ0zEhomqe3JFtGG50Q2JyayW9oX0alEACtz
 uWrTZ0FlsK2HJtwRWlKgcTrX5uvshFSxdsFd0WCjA4gRNYLDhtuq3sKHpWt3v+fF
 jXKBa2tpsDIis0EyjPwp6l87UKIU0XNUNWBMGDUkyo4jRpdg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r3mae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:04:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so1604702eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793707484; x=1794312284;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DFQWQRF434+B4Ywz4DlMntPFpJUGIYTLc/7rRHHMe9s=;
 b=GJtlMxhXyiifvM/E5o6wUc8vZby0NsVeXbu68SSFQgLuCfdIL+3psw617iLn2fSxMn
 faxouwJcw18u87w1ZEXavX/e6ix2tN9Gsj8V3Ug33BgOzWXvtMfUyjVYwAoKHaMJJfsl
 KAuvr2nGetvnxNm6O5A8W9sInVnt5/YZqKmRekTMFVtevTOn5Cl5uXRsOVdZ7GomW6dy
 TvEh+iGRYSqd28hyAJCRYwW0DKpT4W1gePqhucceu8J1M1XaiSdnHMhDMQV4zxz/SnH7
 c1N6+W/YlKe7+DvuvfqZrCQV8TZF4KJ3iyYMgaEwFzNoKNOLOrEdQlsj5JcnR/gFnQxI
 hnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793707484; x=1794312284;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DFQWQRF434+B4Ywz4DlMntPFpJUGIYTLc/7rRHHMe9s=;
 b=Xjsu7tYHDYP1jGzW1Rf/g+VPKfYJqcYg4YNzVqgryLdyrpWm9XKy1jThPYTxwTTByD
 q2RxeReVMFbUTSWWwrrpwVz3XiNCgkaofnTd1AoD2TYGPhG/p/tD0PcSnbUnVY5BWhWj
 qnWBaHEjnpVuSSobhgFhQiUQUdgnGTZ6e20HJpkO+t2OtvkLOzQkONKGJDx4se1WYXJX
 VbOX0UyBmNtJJ7qmojjVehiOFDaFJpOiPRopWjC9oKFRrx8q3WhVTI5N+qZLTPFISz0Y
 E6wGKQAJBCyIzWEEdCRkGHC0RZ9/Ua1rzKjckEY/zQXz4Kl93ezmyOBg6XTHYcxQSfjr
 2uCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBLQ268gkE4Oi9GkHt482/lbZ5KlZQDYbSpUekEwnR+9fIrO3QgksBuDwuiJ5pWN1gmgbJkjY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+7cJR2T3UGG8+vM0+oCuqQfV9zOpr2/QuUtW/ZlXwwC1IH8m9f
 9Yv5fl5+qLWGScA+MCCla6JCZtsJl4VGdgPZMP4kTGTBwa5MQAsKXx/hnQANxVoxOQry0Yh91DA
 xIooSPOjK+S6bG4rV1xp1l+YAuuEP018qONhz5CLvXXnfTX87UADwv//DfPp6L3zSRO5pN4w=
X-Gm-Gg: AYBFou1DO9h6HQ8MTNEXIJE5hF8LsffQL1djCZe0+GWTdYFCi8RycYhLXJN9j4lwmWA
 0LHGMzkGPsIN/Jq3eR2PUubbbUuGhjd7J57aVY/RgSQRi54SQQcjkSlzxWwgP1d+O9hVor2oc6M
 nGoW8GIgGCj1Anav8FK20GZpNPjMCu9FrVkuDBzZ58iYejQPPiYf54qcapicmryE7ucjq8nk6kG
 T8gMUO57rwGjelmvvF4BWrYSqadPzgv5gzDf/HDzwCTjHUncfVqhneumVCKJqP09GlpDlDP0Aeb
 JC3kqVNtCkXyNzpzmbUSxSC3M1oWnqw0ORbbFU/GaOdD14/U6pGu7HCjJ2+tysbtQYDuFExnUa4
 JdK4+0q/mQpuUsqoDwGBgce4dKByYqvUkfznk8CrGtn2ViGbO47PYKusJdkJICE5Nk/dBuZxqJC
 AsWLDivesBgSnWL5q36TzbAtL709QjReX9RBYj/iLmU25LSomIW4ENKbm9xcJ8
X-Received: by 2002:a05:7301:7306:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-36a4235f4a1mr17744596eec.9.1793707483531; 
 Tue, 03 Nov 2026 04:04:43 -0800 (PST)
X-Received: by 2002:a05:7301:7306:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-36a4235f4a1mr17744568eec.9.1793707482815; 
 Tue, 03 Nov 2026 04:04:42 -0800 (PST)
Received: from hu-gde-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm41122111eec.5.2026.11.03.04.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:04:42 -0800 (PST)
From: Deepak G <deepak.g10@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 17:33:55 +0530
Subject: [PATCH] clk: qcom: sa8775p: Add EMAC0 clock and GDSC support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-emac_clock-v1-1-357a9291d35d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKvN6WoC/0WN7QrCIBSGb0XO7wR1JcxbiRHueNas5UrdCMbuP
 WtRPx/ej2eBRNFTAsMWiDT75MdQQO4YYG/Dmbh3hUEJpaUUFaebxRMOI165FXqvpStJXUMZ3CN
 1/vk5OzYbp6m9EOb3w7cR6TEVS95qf4lhP8VQHCFxyj3FQJnjoUPrZKUdtWZW0KzrC9Tk4Eq4A
 AAA
X-Change-ID: 20261103-emac_clock-a06461d02699
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Royyan Zahir <royzah@gmail.com>, Deepak G <gde@qti.qualcomm.com>,
 Deepak G <deepak.g10@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793707478; l=3976;
 i=deepak.g10@oss.qualcomm.com; s=20261103; h=from:subject:message-id;
 bh=lSkOqZ2eNzA19n2gujt9ua3rYs+ugAa9bFe5OohVFgA=;
 b=652TIHUIGGVyBfiuEvSqS1yKDEb8PDYFS1sOWxHt5fq3NucH6HeiAOKJD52PDxHko28FKzg+P
 HfMJOi4PSmOBxcMPRhDxnwWo/5c0N98zsittHzlcSa6E2iGNuC0JElf
X-Developer-Key: i=deepak.g10@oss.qualcomm.com; a=ed25519;
 pk=qW/kHLFcYM9A+uLJhUohoPh1HfCPpcsriYKwqHRw70k=
X-Proofpoint-ORIG-GUID: e8g0DANPM85PXv9PimwNev3r1ijhxnsq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NyBTYWx0ZWRfX9TD/MIgLB62x
 6OM25oKoMBuaPj4q5YqJ5nwJ1EM1gBpCCslGe9jZL2Ru7Ql/c6L5bOPtTi7NAwwfCtZhC9Vcy3v
 UxvwVXL4Yo99Ok2ioCBM3ANQxR5ko+PuUXYdubzWG+BSZMTo4jpXKBw/wDuz+yxGK+SyCwF10Mr
 gWtaKIf0t+XBoDTmGAPRxTzrLEsCXNL9Zr3lANM/bHnW4H/rBTZSGy7likknO5bi+U5UmCgV+17
 YZwlqD7ZBIGIuuX9bmRzrF++2NwgfSxB17HZhjl961+70mgOar6eVGLabUePyHMlG0mPbdyaUBD
 Kg2i/FJH6ZB2RT8bO8A3T9fyDmfuyWKPWcb0JrKNWyzQfsAV/Ov+yxaQM/s/DxUOvqTQlhEz/Tj
 lNge+49liO6P/usjIULxUyLqdV+wQ6g64zXJ20p79cc9Re7s9YBudCImRFIL8imsl0+3x1bmKWZ
 +C+na1e38xfD2gQXzoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NyBTYWx0ZWRfX/aCuc4ffXLIR
 vIydZpKsuQxHXHPWzN1VJbdciZBaXnTv905Zv/ugWcGaOiXSZTU9sOVMZyC4uRUeR7hrSo7xeaH
 LiyIV2a1uVqzaahmkZ8lfF9OaQQOBlY=
X-Proofpoint-GUID: e8g0DANPM85PXv9PimwNev3r1ijhxnsq
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9cddc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=NUyU7jg4wpES5qN04w8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030047
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the EMAC0 AXI, slave AHB, PHY AUX and PTP gate clocks, the
EMAC0 GDSC, and rate-setting for the PHY AUX and PTP clocks.

Taken from 08c51ceb12f7
("clk: qcom: add the GCC driver for sa8775p")

Signed-off-by: Deepak G <deepak.g10@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.h    |  1 +
 drivers/clk/qcom/clock-sa8775p.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 32ecda3f5f1..ecbe3833bcf 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -20,6 +20,7 @@
 #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
 #define CFG_CLK_SRC_GPLL7 (3 << 8)
+#define CFG_CLK_SRC_GPLL7_EMAC0 (2 << 8)
 #define CFG_CLK_SRC_GPLL4 (5 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index fa341d05f69..fd495b73635 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -27,6 +27,9 @@
 #define APCS_GPLL9_STATUS			0x9000
 #define APCS_GPLLX_ENA_REG			0x4b028
 
+#define EMAC0_PHY_AUX_CLK_CMD_RCGR		0xb6028
+#define EMAC0_PTP_CLK_CMD_RCGR			0xb6060
+
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
 #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
@@ -101,6 +104,19 @@ static const struct pll_vote_clk gpll9_vote_clk = {
 	.vote_bit = BIT(9),
 };
 
+/* EMAC0 PHY AUX clock frequency table */
+static const struct freq_tbl ftbl_gcc_emac0_phy_aux_clk_src[] = {
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	{ }
+};
+
+/* EMAC0 PTP clock frequency table */
+static const struct freq_tbl ftbl_gcc_emac0_ptp_clk_src[] = {
+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
+	F(230400000, CFG_CLK_SRC_GPLL4, 3.5, 0, 0),
+	{ }
+};
+
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -140,6 +156,14 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 	case GCC_UFS_PHY_PHY_AUX_CLK:
 		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return 19200000;
+	case GCC_EMAC0_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, EMAC0_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_EMAC0_PTP_CLK:
+		freq = qcom_find_freq(ftbl_gcc_emac0_ptp_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC0_PTP_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 
 	case GCC_SDCC1_APPS_CLK:
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
@@ -209,6 +233,12 @@ static const struct gate_clk sa8775p_clks[] = {
 	/* SDCC1 clocks */
 	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
 	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
+
+	/* EMAC0 clocks */
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xb6018, BIT(0), 0xb6018),
+	GATE_CLK_POLLED(GCC_EMAC0_SLV_AHB_CLK, 0xb6020, BIT(0), 0xb6020),
+	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xb6024, BIT(0), 0xb6024),
+	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xb6040, BIT(0), 0xb6040),
 };
 
 static int sa8775p_enable(struct clk *clk)
@@ -285,6 +315,7 @@ static const struct qcom_reset_map sa8775p_gcc_resets[] = {
 static const struct qcom_power_map sa8775p_gdscs[] = {
 	[UFS_PHY_GDSC] = { .reg = 0x83004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
 	[USB30_PRIM_GDSC] = { .reg = 0x1B004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
+	[EMAC0_GDSC] = { .reg = 0xb6004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
 };
 
 static struct msm_clk_data sa8775_gcc_data = {

---
base-commit: 84cc3bc1c6d4b6042ad8d2dd565f881d46c25507
change-id: 20261103-emac_clock-a06461d02699
prerequisite-change-id: 20261103-lemans-ethernet-c5fcad136deb:v2

Best regards,
--  
Deepak G <deepak.g10@oss.qualcomm.com>

