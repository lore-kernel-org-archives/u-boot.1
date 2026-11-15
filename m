Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DB606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W4Gfq7Dy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hNCMdoI+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K13bbxuE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C48760698;
	Sun, 15 Nov 2026 06:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qLleJGPlKsIu; Sun, 15 Nov 2026 06:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 74714605EE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794723982;
	b=RT5xPfkMm5fzp2WNkj0RdIXGA5itloLL0ZinYhdOK4hU/1AG6Fdc1hSGpXTBfUNDrnTh
	 wsRM0GtFq2nruX2DmPIj0gkjP37f1vSMUyKIR1Jwpq/Otv5k+LYSa8z9j/g4dbZnqIcxU
	 V8cBJi9ZKeAGBw+1aR9uL3JI5fc5T+hapfBisanRkrN5vvTzl+KsmlWU4zCa24p/lv/h0
	 NSAoZ2busYO01IrjbTI1La+g2aRI8hHNcfd9QLl78EMPN2/jYxpeNj9we4SjuY8Qwlm/0
	 ffnbAeoTeHzgz1RfZUzX9zKG6XJg1moKwFHTel+aCy2+4Jj/bMayjZM/U4IFt23xFuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794723982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PLrXd0PvQ4YiPEDvlcSNsFlqDC4ZtVsPouLIr6N22Xo=;
	b=TMAssPgscnvJ86bwXw41V3NFkFMQdTajqcHMllf/995DCBSrL9PZgJxk3AD6vFVm79PK
	 uyYDCBdcGXRFtU2sUnNjcma8xoLEBxUogYPj/9W/qYcTd3oiWhqVBrQImvaFP9xpUmdRe
	 yKDvDVrnZ2BOgK1hBIvRtjZZgmevldHfQpxKgyAEQrA2Yp51NmPjcaGa+OLVKEHjYW9ez
	 HbSdL8sLO8jccfQqhlUgZJKO3d2XdQLlKlZXG+pCJA0Or35H8fqOS2H5GUmy4izwknnLl
	 LUyuItfr2KxQPZOJHXSPJo+MyUM1dfpcdnH6rcVlVXYe7eZujcjhgi9CRHwrE6N6JEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794723982;
	bh=PLrXd0PvQ4YiPEDvlcSNsFlqDC4ZtVsPouLIr6N22Xo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W4Gfq7DyIv1O5UW1ZD4WZJYJhftwUe6m3gZUTKCm3v558HuQZP7iCh38U0P9x7Jl0
	 G5LvqVOhuwTukrOCu1+DS3m9pYf42fr6IUsetip64jLrryTz1xOd8WlxJ7oTcGHmeW
	 1vO8HaSmrLPFyg3I3jKiXVOeTZVstc1EPJINpKnSiESu3bkZUE7MS0tjySdTj6z6mO
	 /dI7PgBxEkhzKnZmTd1mkkelvL12fdm6CAQZzu3uORhzk5cdWllfs7UZck+Lukk3fX
	 vumquwrO84lZTV70mDhRIfNETswdUkiepEx9UYVBEBSBT5o7Ugz6b9jliptqLBfE1X
	 9/aw89oBLOlNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74714605EE;
	Sun, 15 Nov 2026 06:26:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E521D2FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2A66406DA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvQYLp64reuK for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:26:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54D5E406D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hNCMdoI+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=K13bbxuE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54D5E406D9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:18 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4Rwbo771718
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PLrXd0PvQ4YiPEDvlcSNsF
 lqDC4ZtVsPouLIr6N22Xo=; b=hNCMdoI+LdBYOSlg65Spr+vvQxBYyoOk0WdPbx
 knnm35spEINlDgwFx3p7e1AU2QCeEfqPy4mf/i8avP9hTWqo8bfrTUDk+j91DBWZ
 BQybpHT+/LwCqaITCqsVPu7Te4JyoE3Qz/kL8uwgmqCN3nOsyyRq6xNvXVuO90ny
 GDlQdBuLdFDCztQ1IQ8o4QyXMasLUZS0d2UaweHEGGYqlwzPZRl2EyY/q/HCBnzf
 K27/FYV+cT37GNzdCv28PIRnH+zliSc1S88VaWnQRMQDcaso6ZHkf2GPTiHxmYpH
 keFZmqS2i84GEJJ4nEYXxgd2lo5LzFXQtu5x/AAUQJKcq0BQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhjctu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-370230d93efso9917821eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794723977; x=1795328777;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PLrXd0PvQ4YiPEDvlcSNsFlqDC4ZtVsPouLIr6N22Xo=;
 b=K13bbxuEFoR81UKCJiPnriDNqB7NGTWJ2MjyRPWdxKZ1QS4eadarNmnOCvqAwDLE7m
 RiOKQcpGp3Ix7oacgFui+dSmOFU/iy5p16nTLIgndayqGxvEdyejChb2S1HZTUvTPmW7
 9fVCvRhSG2aD/JzRhaig9tvx6iT3uzUU8WHRPwSZ14ILZA1ZQDI+pctfxAfxZtlZNPId
 1rTooO1xrMNOx4uTZUHoom0X67hR3Mua4Zeg1ZyxnxmTGL0OCW0munl0sB3dZ1yNoG3L
 PcFZ5QbbyfWGZcJQLqo2lbiVrLGDiiUeyCMHgcxhgSCdVwRqrWwtfNFpu//jk2AM4o8b
 otqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723977; x=1795328777;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PLrXd0PvQ4YiPEDvlcSNsFlqDC4ZtVsPouLIr6N22Xo=;
 b=Y2bSFv3QOIOFTK7+izDxIO8Kvbsg50GbUtWLLHM/9FpO/YVib+aZpudHjSutbFNC1V
 Pp7oBnoSMA4H3dzI9GYtiHA+P4HZmfj/bdcwSvBHeDvmpzWCiddc3FNCpl5opmjrUIgO
 SSZWsAMTQXeZ8kLEYtRSGBT396mXzMc48Pg2idAW6pe9qngJP1K48RP5y+cm+8m47JyT
 xuzvoGBL/6800B/+47baXZVAJgPf9EQdQ/lRhBfG1hBwWqU8InU1EszWgbtsB5YhYRaM
 l4MPFLRalGKICzuHuMv4bH7cwY+NCqysnw78LVbw731yDS0C8YbSyawO9rE7TcKYIKvo
 1pcg==
X-Gm-Message-State: APuU4Z9ZPpMoj34Mn6BOVHexGMRduv0HtteaBe8JcJauri317l4GU87F
 GqKKM4kewJtc5a6h/QMH8CNuaQe6jO2zBiGHoqSjFzDxW7d9u4NQ0AtcasnoTUGSMAGRJpV/RX4
 bNyVMHfJr17/lpg4vWEOkw+v+bmBUT+3uU7XE+2WUsjIfkJwbocGcyOSuyPYEIokJxm+zDqs=
X-Gm-Gg: AYBFou0hz2QSIba8ECaaNZsNpcJW9C5bG3n6VfodWLV87H64thr+gRJN8tM4wB89W/3
 DLbcrYU2GXsEiTQYTqaYX8Nc4nVtdCJFcDPkh7BDWBwRUy7ElE8XFfW7zhrzqNn5pZn35KQoZwe
 3Nv7Ygs9fmGsDeZAVTSksIXWoB7hV8NjQtqkaycfVcQE4ezPcAiGZxS4YqDrql4LgKrj6dE+CZh
 AEBztkamJxCQFfZxqr5N9ca/J0n+EIPd0u2mAc0gKMkkmcDhkJQg+we5tpzQSN+JcqbcPDuR+fJ
 Tz5Crw8g5UQ7OHKhfeemf7e8na27H9+LAMUMzTrCTe90geLGin4tqmowiGfdK9ylUFANIuQkiAO
 G3H+bahdBwZN2SfoUKKL8oqfBwMDtAkwE+VfhUHSsee12lKiCWAjDK/A5yDBTDarKP60JBMhTg0
 RK+SjKNoYZXmV2bPS9/Dy0wjcLcLTlbQm0yZN7ozAwOc+8DNgP9Er4PqmGWv/KsxFMdtb2repSi
 L25
X-Received: by 2002:a05:701b:2092:20b0:193:9aa3:474c with SMTP id
 a92af1059eb24-1b5030fb812mr7766907c88.21.1794723977210; 
 Sat, 14 Nov 2026 22:26:17 -0800 (PST)
X-Received: by 2002:a05:701b:2092:20b0:193:9aa3:474c with SMTP id
 a92af1059eb24-1b5030fb812mr7766883c88.21.1794723976513; 
 Sat, 14 Nov 2026 22:26:16 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:26:16 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v5 0/8] Add partition type GUID support for environment
Date: Sun, 15 Nov 2026 11:56:02 +0530
Message-Id: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpQ+WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3ZLKglRd85RkCzNzYwNLAwszJaDSgqLUtMwKsDHRsbW1AAJxTm1
 WAAAA
X-Change-ID: 20260428-type-7dc867309086
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=3477;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=3YXnRaEAlgjzRedi7b3lF3ZR3lJt7MK/u7KYgqfvo+Q=;
 b=BYjPcPw4gFDEbY7eBZv28nnaN2hUsEXKapk5QmL0LgpQueqLcT9u0a0In35E0bolpCYmxXGiO
 9EVNu7o6BjWC4kOJNCwfftckRt3yqRv/LxR9qtOFM4Xso2FGKCRJe4y
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: pgsRogdIzdTFkJWvQtw8HnPD1sPxx180
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfXxMGGd5ax4WmO
 LJfeX/b3z+N+UKts4Z5S7NLW40lUV2pphbp2T3UWXY0JTePmsFlli2GqratRm7lowC/SAjYJK2H
 QWvvlgY50LS021pChz7GdXGu51vvM7o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX6S2b0n6C936c
 NVeTF5NVdelquyvQo1FVnxU7umVlNsTtHlQavColstVeZkQ3VNkheF036hhoN8uhFOVMgL6x58v
 KhK/6fcMvOY5R/EX4iTIuFkTY77WQ5MObIP4XyRCy5JJNuISteJzfk0wSaw4rQxmieIWHob+X1H
 KxlPktepFZAYxk2mvvaylI/qzHxeCgzI+RhHP3zQmSr9A82uQTQR7QpgFK7PzrnbSyZVsMogvod
 i8K0q14DA6Yzni66VmXYbILD2qnuTBTZnWQemsEY8MYfEjpHIcDPo6/emhZ+BCaX81PPqHy3ny4
 jvmUniSuaXiCccVq6jR05D7npRd2coIlxNArk5VoZeF8o6ySs2iGD3y2SfHkO5LiFzDmtpZzDUB
 Qa4rMy6MrIHx8PyO8jOcQPwhrtTg4LowfCP/0w5fAuaZqTzmEfBSFuD1xyGLPP2oKUPx+SZ3SRQ
 ufW+XOUSgLn/p9jKZsw==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af9508a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7xg0KvL6PEYBae9vmDQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: pgsRogdIzdTFkJWvQtw8HnPD1sPxx180
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for locating partitions using GPT partition
type GUID instead of unique partition UUID. This enables the saveenv
command to work with partitions identified by their type rather than
unique identifiers, providing flexibility for systems where partition
UUIDs may vary across devices but types remain constant.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Changes in v5:
- use IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) instead of
  CONFIG_IS_ENABLED()
- expand the help text of the partition selection choice
- drop QCS615, which now keeps its environment in the eMMC
  logfs partition
- name the logfs partition in the commit message
- check the type GUID and size of the matched partition instead of
  its name, as the test image has no partition labels
- Link to v4: https://lore.kernel.org/u-boot/20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com/

Changes in v4:
- Create a seperate patch for scsi_get_blk_by_uuid optimization
- Create a seperate patch for correcting default value of
  ENV_SCSI_HW_PARTITION config
- Update help section of ENV_IS_IN_SCSI config
- Add 'select PARTITION_TYPE_GUID' for ENV_SCSI_PART_USE_TYPE_GUID
  so that its selected automatically
- In test code, add more asserts to confirm its a kernel partition
- Link to v3: https://lore.kernel.org/u-boot/20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com/

Changes in v3:
- Addressed minor corrections in Patch 1 in part_get_info_by_type_guid function
- Refactor env_scsi_get_part and env_scsi_load functions based
  on the choice configs in Patch 3
- Add unit test for the partition type GUID lookup functionality in Patch 5
- Link to v2: https://lore.kernel.org/u-boot/20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com/

Changes in v2:
- Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
- Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
- Link to v1: https://lore.kernel.org/u-boot/20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com/

---
Balaji Selvanathan (8):
      disk: Add partition lookup by type GUID functionality
      scsi: Add partition lookup by type GUID for SCSI devices
      scsi: Optimize scsi_get_blk_by_uuid() loop iteration
      env: scsi: Fix ENV_SCSI_HW_PARTITION default value type
      env: scsi: Add partition type GUID support and choice-based selection
      env: scsi: Implement partition type GUID lookup
      configs: Enable partition type GUID for QCS9100/QCM6490 boards
      test: dm: Add partition type GUID lookup test

 configs/qcm6490_defconfig      |  4 +++
 configs/qcom_qcs9100_defconfig |  3 +-
 disk/part.c                    | 37 ++++++++++++++++++++++
 drivers/scsi/scsi-uclass.c     | 28 ++++++++++++++--
 env/Kconfig                    | 72 +++++++++++++++++++++++++++++++++---------
 env/scsi.c                     | 43 ++++++++++++++-----------
 include/part.h                 | 21 ++++++++++++
 include/scsi.h                 | 11 +++++++
 test/dm/part.c                 | 52 ++++++++++++++++++++++++++++++
 9 files changed, 235 insertions(+), 36 deletions(-)
---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20260428-type-7dc867309086

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

