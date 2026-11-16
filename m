Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE32606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O7TzNkgi;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZYhalLiZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VSZFD+6b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8FDD607A9;
	Mon, 16 Nov 2026 11:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9OywqjPd4w9; Mon, 16 Nov 2026 11:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 858A86060E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794829162;
	b=EHAi8DoQ7Txvu1QDiuiSyPzVoWsEQfqZ+xFMkahqazXdFeKEZPOLh028+o9g2az+cJwj
	 81YAg9w+yMDaz35sKurjG1lYtSGw/rYMAGZTyWUJSNNU/gR0N8U88uBHsdzfOED1scH2D
	 BWCdJL8M2Zmyy/GLd3oDIXUMaS3bb4E6s7IKU2OswSoPSDc0VcRUeOyJOw33/bM9031ir
	 16vDi22ZrocBHp007YQ0wMHFSYni3Z9a4TZmBLY4q7vQRYDpCj17Pxx0u04va+Rl+550j
	 +OuhJ6yrrMdkTOuHIGwrzANwiaoSm/3EagmglGXYY77BiZM2V35xjiZF5m/RFB3rHkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794829162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sdsi8aXvrDkHixT5ESF32f2uhjHNLhFfaFV85MYt9Hg=;
	b=l61wg4jtjt3u+Ctt1/pEI0WQM1MBMYDkBllOqd9XLHU1oFwX1vpygA5kTHfQgwKCntCH
	 BJzaONKHMBSAetmQ84jxMhvcqWj/zz63cGK/TFim5KTgOjeELCFg9P5DyjAU10qZlP0OB
	 1jmOF5xjxMS/NeFz6cE+iwJqLjO+dKoLbK1W/nqv1r4CQqT6pTAxKEh1DxrGZ+YFmP9YG
	 42XgOEjEDEmPVmuR9HdEWu1zHmWTyc3gvSBBADrP8kS/NX95Z2+NOhxsO4pc77aFc06Wg
	 iy0ZYB92DSpzJl1GFjzCNjwfezlRooMFRh7/m+VNDOT3h2VUGBGKVCNWEX5ucmcirmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794829162;
	bh=sdsi8aXvrDkHixT5ESF32f2uhjHNLhFfaFV85MYt9Hg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O7TzNkgiQxkGjikwZnoQAqz3O113NPdnjStE+7YMszgebZn6wB8++38hG6xVamwNU
	 P9N5brmJFSqorHDIcOcIsuT7E7sNtLxaOx9HQxH0MctrCKKdQz+TmNlmkiR5lIH8It
	 KcUjnhUghVdgY2racnXTdEWKAugotyTamWMojvdXgvpYh6K6nmo0ELxgOh1CBSHcJk
	 onSUOPOdt6m/WiO9VUiBW+rRqY7aHjeR2llCtCU6323NUHS/I6qKUXAQipm3VDFJJ1
	 ogupi+c59yMKw0LO+Mu+95zqfqm4LUn/ayNn35NSo7UpjAJQGiAefV3xI6EAnofmah
	 VFlC/v/qL2WOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 858A86060E;
	Mon, 16 Nov 2026 11:39:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 11B9E1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F235E40301
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 69nuoOXwrdTD for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0463402FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZYhalLiZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VSZFD+6b
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0463402FF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:19 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBM99k3032700
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=sdsi8aXvrDkHixT5ESF32f
 2uhjHNLhFfaFV85MYt9Hg=; b=ZYhalLiZlLq2xuUenSGb5lGPzZeXR6lh3STYLL
 S018plYvKQzyQQjYLKK3XGDh6hY/x+FbQhUargIMp6LrOJCH6D7V+aSMP2Rzil5y
 Ukux0LTcPUDYQokJrgpysZxTs4h/jOPyJuDo4qonM5WGQOKC+dnNMD1h2fDr1iNr
 rKu/rvz9FSSdVlkdU2ytxEqvI9jsKebSdosDFvuUo60CBPo0F2qBa4o3IMSi+hCN
 feXj00M0qD38M7Rr2G4CaO8bhSaU6isxK9CUSaxlKAN65Q+o2rq98XRcwKM3YAru
 Flu0kaue+XZHa4Y7ciPOKH8osHlnw+PdDYx7mt1dwUXCX2TQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxcf0n9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36ecd5db581so3594724eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794829158; x=1795433958;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sdsi8aXvrDkHixT5ESF32f2uhjHNLhFfaFV85MYt9Hg=;
 b=VSZFD+6bCaN5zRNAYvBvv+/YeodoDgtEVQyD47ulrIDJFvgN5N+jDACxJn6sf5Qbqy
 v+LdTaZ4o0OoEn50LaCVlROZObRYxkRWd0NY+YxxpqPzhEYtXqkIITjXyGOarHRC//PM
 bC8xnBTBfJURoai4QhAROozCc2qxsmV9vlA7nvkGrlOpOrzNZiaaWMVgDBlevJOPVC5H
 LkmHDbhDfG1Xd3iA4GBtEfGTz7gMWA4ZwMCC6j0op8LrkFM5KbQ3p2itQyWf1fpYKRzX
 M+aDBtCNW5ZZhPOM7HqOBALKGFL4WYriga7f0WalYRiaT0HIdVlYxdlpCBiuFWg5PUSp
 L1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829158; x=1795433958;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sdsi8aXvrDkHixT5ESF32f2uhjHNLhFfaFV85MYt9Hg=;
 b=y+JViqxF1EsNx1euk+GdIQZYVh6yRX9WWQfzULgnqOTACyzwJ7hWpfKMsfttw8++om
 1+lVSHyHJO3egHgF18VtbIherAXfJvY8512XUKe/ysRiskU5k35/JiM4gma7JjDJeZ2M
 xzm6euSGCJTke9ceHLwYrLVR9wjPs3ml47FvQtBG52TRCsphIvTp4uYlr2B/Qs2Kw114
 b1McitBr76ggFulaxtv2ld9RNyDU4WkImwKcnY+GseKpOwLdiP80keusEMddlIrejDba
 vdT7vLZm/BFl8lrw5YOHI9qrpOchWTd93enJe758qDYds5IXcHAU9OapXiIq1tNS86t/
 mypQ==
X-Gm-Message-State: APuU4Z+mPn4lMG4vZYjq1DnPkk6VhOu7ji36lBbysYTOqa3eq5SqgVeG
 KC2hymfGvijHDR+4WPuwQGq0btnnQ2+q0kO/jY6lhpLpUO9QGCbOUb01Frwxs59epPEOLfKS2RL
 NZ/NcjNRM3SbgA+mu6YL3z1xZArn+U5ffIpjrXyEbv2phqWj4t/KC6gnQiPhYwLfXVVdv0wc=
X-Gm-Gg: AYBFou3623UYBSov4Tj5QNefZ+DCUQ4IOW0FMiXdFX78qAXkz6jtObUaaT2x4zFcRtJ
 KNzvIXZTZcMXka7+ExTmtyyTNCFN5sYPGhW4be8AflneGBTRnIy3liuw5jsnIaVL3XuvOQZfCih
 v9lxCezCo7n3KbPYCZ8/BxNyZWQ20rQQswr8e2eWpHV16Iao/70/9NAJ2bGfdpRKaB20ATkQXZf
 KBMQNugDAPjDgL8sMywgAiDauJSOggmaAVBzfGI0vU1yHT4P8Jr8qJRxzSTL/MAWSqnIaM1yF2F
 p2lhAHcectNyCW6iwfRS3V7fI0Nistccx4a0rPK3K7e5K5job8cJ0ykbpcWTcbZ5GFMh5kxPw4r
 wxkV2DmvAqQbk2v1YSrDoMFSB3fzSvNubgJrgoD+L0iGhLo+UPcswrhViwiwhxDyDO8TaBRqrEx
 Jzpyq6no+O9zLMHxMpTPT05LtO7LMaFQJYnGyoTgN6QZlJD2huRQeQbNpU41y1k84L3ZOQssoBi
 s7Y3w==
X-Received: by 2002:a05:7300:d08b:b0:376:6530:248f with SMTP id
 5a478bee46e88-3796666dbbcmr10957470eec.24.1794829157679; 
 Mon, 16 Nov 2026 03:39:17 -0800 (PST)
X-Received: by 2002:a05:7300:d08b:b0:376:6530:248f with SMTP id
 5a478bee46e88-3796666dbbcmr10957422eec.24.1794829156848; 
 Mon, 16 Nov 2026 03:39:16 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795533170csm34412685eec.7.2026.11.16.03.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:39:16 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/2] gpio: pca953x: enable the driver on Lemans and Monaco EVKs
Date: Mon, 16 Nov 2026 17:09:10 +0530
Message-Id: <20261116-pca953x-tca9538-v1-0-1cc09ccffcf7@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7r+moC/yWNQQ6CMBBFr0K6tmSmQJ2y8h7GxVCKNhHQDqiJ8
 e5W3MzP+8l/81YSUgyi2uKtUnhEifOUAXeF8heezkHHPrMyYCwiWn3z7JrqpZctSZueGPu68t5
 ZlVe3FIb42ozH059TuK9ZvPxLNQYR3sRtsWkBHGLjDJQZEchq1CzPOJXjmtYzT4dZpLyvfPXzO
 Jb5/B51LEH/iri0ha1p7xvoiGsYjLXEnSMmZzpXAXDfeCQcKlKnz+cL7YXLvfQAAAA=
X-Change-ID: 20261116-pca953x-tca9538-2d8a1d43cc96
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794829153; l=1030;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Q1/DO89uxbEY5RgiY4/tJIO3XiHsz0VMiaKt104mCVA=;
 b=U6AculpNXeMO477Zo4ZJjqDlixWUY8iRUDObYe7hkr/tKlw2PleCqpAKv2Eq+iMNYWCpfi6g8
 JSOiST6yvtQAyCgAl30f3hw66oflL/GPBh+SLGGBxlb843G8iBuF83A
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfXx8Th20VP74Dt
 PKRoMufHyL5ivQrm31i2UIpqcdYjJB4VIxmTyOMwHEfoHOpWMtnHO//Kn99tCfWqzevH5yaTQ5s
 HDMqm7dYnTxBzx1sRbq+Qk6YQvYUuX+OVP5uBbwuccN7PRShA9BhrfVEZJ968Z5S3uaDAoL4nEG
 tVHClKtkE9W5ezkfow22ll5Ps/AwEdOrnfbNYPlx/B+tvaYK2pVr79+9yxrDj2r5E8V0ZG7l93N
 77JArVqFI9QOyddgH5g3ktf5DZfQTkdwLPYNGPKQxdjKidMfay1ePRHkRLbKJb+UVbCRoFQnt6B
 WwPEwOLDQuzH7AMiDkcLJ3vT1PPvJWKZQbMTECHRkREa8T5ytblECPoDjGRx1T70DI5QkjX3Mon
 HdwVftwqKS0+pGNKSf2sUrAdBJptuxghDLF3WmzdK2MRx3SidswZF+62r8i0ZA5523rouIpRRqh
 uNrkNNVkcvAjBil+qIA==
X-Authority-Analysis: v=2.4 cv=RtZQvymK c=1 sm=1 tr=0 ts=6afaeb66 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sellme8g5ULF1IPoM3YA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfXx1nQTUvT346X
 7Xtld/J+goaMR1+WRiA6MajYgs9GNiNXaFNxdpPwSPD4P/oRrwO8n60JIMG2cX9yXSZoTrG59S+
 KBhBXCKI5piWA/Yqh9kGh8shKDt2qgA=
X-Proofpoint-ORIG-GUID: L1v32IKHdKtDVDqfp5Sg2oPtCkh-znfS
X-Proofpoint-GUID: L1v32IKHdKtDVDqfp5Sg2oPtCkh-znfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160046
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

Both EVK device trees describe TCA9538 GPIO expanders, but U-Boot
neither matches the compatible nor enables the driver in the Qualcomm
defconfigs. Add the compatible and turn the driver on for the two
boards.

The second patch needs the qcs9100 -> lemans defconfig rename from
Aswin Murugan:
https://lore.kernel.org/r/20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com

---
Balaji Selvanathan (2):
      gpio: pca953x: add ti,tca9538 compatible
      configs: qcom: enable PCA953X GPIO expander driver on Lemans and Monaco

 configs/qcom_lemans_defconfig | 1 +
 configs/qcom_monaco_defconfig | 1 +
 drivers/gpio/pca953x_gpio.c   | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261116-pca953x-tca9538-2d8a1d43cc96
prerequisite-message-id: 20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com
prerequisite-patch-id: ad4add2d4646b5470494d80a4555c3d75ea7319e

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

