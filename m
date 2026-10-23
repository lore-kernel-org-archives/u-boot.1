Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CC606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DlYdNMG7;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pTnRaLc5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q3Hw7/kJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46F3D4099C;
	Fri, 23 Oct 2026 15:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4drNuiK_NDu2; Fri, 23 Oct 2026 15:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C0CA409D5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792768322;
	b=i1MBQc4XzE1AydytplQ2AH8NvwwaERa/hakV+ValyifuslHkAA/wgnRqOQHN3FOEFO6r
	 GiMAh+p3hjAfcPzmcMJjHUlbBRKBuaioEvAjvZjzYaYHSsqAUc48J1r8lYyPuByoDWVTl
	 EsEDZjJPGARnrkys2tnw4/PdIrx/qLZeVbTNEqf6H5+PUNoOYqjB1PFUQtUe4y7pI9lyj
	 GdsS6SxWYCQfiQyS/JtwXiLyygUHQbrrmYH8os1OVY8x8hk/by3C2LFX2LUJZBCcHF+qW
	 ZLpN/w7F9VcTvfwuNc7VTzU8LsB+7ucoKAaLNrRFfPZzLGBVcpcA9oJDYIdf49FlFZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792768322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VLLJDpzxyE8w3yG5QpCB1c+r3F+i4ZVIjaE5q6dGSwE=;
	b=PvutmSf16HVV96rLouS7YRBlmYT+HB1xGBC5eBRGeg+T3sTEis99HTz0CkHLELrH+NLz
	 1lyzRG8lXQWHbHXCfWBmdiyCt1t54yNGAUmr3k5F9Fe5ESHi3L67r+3+hadOQBaJ5Alz7
	 HicvyfSw1kCh8GLzbZQDvdkHDf7kddfRaXKxZP+Zw1dRpP6dLPGwWOrbmkY5Ty+eIPNO8
	 vbR9aTe7rqC9aOJoRwQOM6MC/mBBFpRWw6cyt60S4BuApy7OEVStxr4vqvtecDuWRRJyz
	 sNTheLYYAdX+U1wsXI1jUPpwQSggL0Gx+YfgqykZZ6os0WVnF1cfYEFKKIC/GYKP44g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792768322;
	bh=VLLJDpzxyE8w3yG5QpCB1c+r3F+i4ZVIjaE5q6dGSwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DlYdNMG7QUPAuI4VyryRE6dqGFDdxGUymXu88IVVxRD3c+1xcxg3Z6DS9TiY4bxaG
	 kXcJ2edoJQ23OqLd91O4nDV74GpOxdZ7V7LkxX7vi8Oy21Pa1r4lp1PmNheX7gmYE6
	 6PEU94TTeTrrQyAIdlToyqeBkc78hkzvxg1BKTg1RezN9WxUKHK8r78JGS0IZUCdHC
	 Nxws2DIb3vTXXUuwKyrfhE0g8kJHcsVJN0njMaNZhS2nZ2Ma9gHPR59TNvlnbjor9i
	 k001gOfP86/eh3uzOEiCcGYj5ixtYbkIwAH/OTwbsEyKUPno6BB+nSxiMBvipVL3Dq
	 UVCZ/uAJFaO0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C0CA409D5;
	Fri, 23 Oct 2026 15:12:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79FD8235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FD5E60648
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yvI04scCnuIe for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 15:12:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0046B60628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792768320;
 b=nk0mpcL0jczJRwm/gV2ly8JTBltyb8/nkFSK6QeMJtE6qPs12Hkj7JrOUhsWmD8gL2Sr
 0d0ikex1QISpO8qzXkKvsik96rKQpQp+yzbmykf63A5IThNvjOEDo2VTu2VQk14idqaL9
 ZRh5q1yK9CA0dAzTyI+4XeICG42jxRr9pQ/dL1wjxZTZ+4G/o9KL02jejH8KNKstC8vmc
 tgpnXWq2uX0IKwwqzsprvz1vf5r0wjJnTYAHB8WrIEUzcJe7JSQ6o2yuCdK4Ie3dI/Uu7
 F9Q2wUglvokWcSvezKEuXhxMsq0grwk6IwJgAf651FYWWg0T/4dHVM5KK4nMjirfGPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792768320;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VLLJDpzxyE8w3yG5QpCB1c+r3F+i4ZVIjaE5q6dGSwE=;
 b=j1NATn+5wmOrT4FyxvmoRJ6ORtgrtgpJa/h7bDJ6xy8+UszvswwIZMcr03rFOCWxmxou
 asdJZe/5mWghrTixSuCMNJ6kfKKQdPgATYp3kd5mhwu/5eKRsgzyWpUKjFbccwg1vaYI2
 5x2Otsk65qYlyS1jFVQKjEol0ZhzIRUlVKJmZ2WyT5rtGABofEisPxrXKS9C3ynebCZHJ
 /rgKJwFtStopgYrUt408/2xpcPD5DKeeivCvZxfCGOeeNEIfQv2VjvPQRAJtdV0ZLcA9z
 JOHuOSu/l3qC/ry07jcpmXkDM9W+EB5CUOSc+fn1KMUswN8iatP9/6GqfkPBl4wq/VA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pTnRaLc5; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Q3Hw7/kJ"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pTnRaLc5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q3Hw7/kJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0046B60628
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5v5W4063351
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VLLJDpzxyE8w3yG5QpCB1c+r3F+i4ZVIjaE5q6dGSwE=; b=pTnRaLc59BjARX60
 Qm3AGjp5jGzYqDbjK1tgIuKG/7iZf3gtfYul6mKMxbSxzfwuN4SSv5cfXiE0OW9o
 ofjo+pvMQjlgbfCHbEA/lTSrOyxk3q7iYa0scKR3Jg1pLf+xmo3cKvdu6bYfvkNa
 pdYJIsDGg6ljVu6iuJkwKOdj1BL494kIDVX1GGuKBtGjAlxP11MyKbPnbWHzMInc
 hgRprLOsNVr0ZS+r0a9CKJMKxAATQibo4/41pxyaIXSkUMi9/WcqOvjU+An7NmBY
 59Lmvy/I9U1g8uSF75OJ5dNpW+w+BXe2BEFYkN3D9j+SsaxX3Yi85aVWlH6BjXUw
 jxJfNg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrc8e8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:11:58 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-98a9c848bf0so234239241.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792768318; x=1793373118;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VLLJDpzxyE8w3yG5QpCB1c+r3F+i4ZVIjaE5q6dGSwE=;
 b=Q3Hw7/kJjh+NgRdgnHLdaZCCxYPGiBv1eSst5uvUKGJ35anU1hc6T/2JTBw4Njhb6q
 Mo9lgT7fLWx879rU53UmtiudqmqICBkvn1w91HWna+LXPu8AUmqPuD5U2x748zc7l0+7
 KLVK/lM7jR+fECWIfOlvIavd96QDHwmDK0nbxdSTFiRYkC8SS/vloD0LXYyFwe+ti1fx
 8C/NREmh5EjqAqqV+Xk+P/2gW5d4WNb2oDQGpmNbXycLdzOonqEHU2srSpM7s1TZGE8r
 lGV6GbImRON8RwmWX6NxBzP8yTP+Z8G+XQhEH6ZT1nRu8dzrTjanTrnDMH2ojn1yuWeO
 dTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792768318; x=1793373118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLLJDpzxyE8w3yG5QpCB1c+r3F+i4ZVIjaE5q6dGSwE=;
 b=mtcryR1137YrMcwYpAJ1w8OzrEcGQNy6l3Y25vnmsD6Kuo4CbZ4qLl5UyJs7eyGQYL
 og3ae5AeRaFBr7o/XICK1bLeszqZytldMwdf/z0np7i2IwGCD27xxKzxrq8m8dS0JyUN
 CxRBJAtRIP7jde/twRqHdl2nfUqesj8iz5+yN7UOAS5di8D+BqoOascSBWHgUXSWDDiu
 l23dE0tl83MLZoQcYFhV0Apq4ti47gQR7Au+G4PN8ruA00q1cdipbDUeNtBVCPtSuEQS
 cYlafGHCeB56EduYLCkgIlZbhHKOOuTjtoBk23bgPFsLAmyQP76PfYPe7qGeLxuBd1Ei
 VjFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwt8GsRYJE5kKVwEvW0GUX2E5lY1UlQiTj3dAVxPJsIcnkVLFb2A1v3ukscQblyt0TOpqCg88M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJIfSLlgYHbRs90Wdka1Zrf6PNGQ2CDR04rkCuyx6TqIYorryTd
 WyUUtBlGepUQkA+x9ACMcKtQm27UxyH7TrL0IeVUroWrVEFjsshyKYO1T581MNhTZZKaZTmUnr9
 sDehNxs/S150eL0rchb3N3mRYXe6nNIrS1taS9KV0AsFbYPedFr1LIc9QM2zH5t3/wmtNgV8=
X-Gm-Gg: AYBFou2W1tguRPDoaQmGmbaRfmwXrqsRQg5MQC2TV831zEQFTWyHY9dhb1zLiikhkNe
 CSGM96/za7uesEjFFA/7BplEVBBmCoxqoKsJxOIRX0kzglzr7As2ZXZVPfp9gwwzG0Stu36L0Oj
 MLDmO2xTj9yfgIjFTdPFaTAWMKH7ZW1WPs1IxZWRCMGGKQXIjDoaiUxNf5Gv6qG/6eEfCLOFjg7
 YXCA+spzWoZxQdl4vL3+MFnr71YECImgWUEfsTTDlXxzGjmw0vXGyke3U4V2SK9AWOFNDoWD1zJ
 QSXJvu/f8gR8QRnOAkeIAI1iKGOb0jf4xRATYfCof97LCWstCr7X+opXKV7ohoV91oC9mkCelO/
 SzZuPu/DflTygqUw5J8W0qz+vkEmAT9hUJqv4rWQKESZRGOY=
X-Received: by 2002:a05:6102:83d9:b0:7c1:f530:2d8e with SMTP id
 ada2fe7eead31-7ccc34426ccmr857669137.35.1792768317196; 
 Fri, 23 Oct 2026 08:11:57 -0700 (PDT)
X-Received: by 2002:a05:6102:83d9:b0:7c1:f530:2d8e with SMTP id
 ada2fe7eead31-7ccc34426ccmr857646137.35.1792768316567; 
 Fri, 23 Oct 2026 08:11:56 -0700 (PDT)
Received: from [127.0.1.1] (185-164-143-216.cgnat.inetia.pl. [185.164.143.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46b8bc2dccsm13229866b.42.2026.10.23.08.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:11:55 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:11:43 +0200
Subject: [PATCH v5 4/5] fastboot: add flashing lock/unlock/get_unlock_ability
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-upstream-avb_lock_unlock_b4-v5-4-6453a6f63028@oss.qualcomm.com>
References: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
In-Reply-To: <20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: WUg3DHtEe09rqKDvxCLzogsUWrIUSqoX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXxlyJVOBwLhv2
 DMvsffo/77Leu8jar71g6kiabzRM9td4IVN4OQFx+ba/JgRjOHBgRWUBdgr8sW4mBciMbz7Q6Bo
 DKdhUhIImzHKiJhqH2bWFWB/x8/nT/I=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb793e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+XDFW8w5h4l+9U6kKVkjeg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=5JHqtTIscBY7JO8zqbAA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX9bBK9Dh6VTAF
 erK7GRVEdNBiNW2Rr1mw1WCp1zTISa14aQXo4kr8SWt3cfbIp6XZYk7BXCp3p1ixQ65Leyr+SE3
 8t96vQCVGnatVnlN94v63StJPAVF7L3budjkKLWXfuV3Xt0TxIqNpdXHNyJ3XasWsYfLCMeof9H
 ldLO36W3WMImBJ0FQOk0Pcl24JVIrqrjKc2Kx1oxxM8njqdwuq+29GAtnsexuKe6oWdn9SEFVWC
 NXqqxN/3ANVKSzOS03VhQAkENI/V+xXuloeBxjQcLNg+Zfavp7SfBlZBJz7KGvHL2b9ofHep+95
 Tw/f19CTatJkjvhhpLepqs+EK22tNiYULS/2LjikjepGmaC2XuqydttYd3oomZI08J+OwsATN3K
 XrEU75vMYMTnFBZjZU9Tpmh9dRC+btDIe/eP6ocBi7vDFeH7HFy3i7oLHrE3k1ddWtAVCGvY2Vt
 amB+0hrQNIiXsLG/I2A==
X-Proofpoint-ORIG-GUID: WUg3DHtEe09rqKDvxCLzogsUWrIUSqoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230059
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

Android's fastboot client changes the device lock state with
"fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
the "avb lock/unlock" shell commands) but no fastboot front end for it, so
a device could only be unlocked from the serial console. The state also
had no effect on fastboot: a locked device still accepted "flash",
"erase", "boot" and the oem commands.

Add the three commands and the "unlocked" variable behind
CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
userdata (and metadata, which holds the file based encryption keys) before
the state changes and are refused when a partition cannot be erased; the
TA resets the rollback indexes on a state change. A device that is
already in the requested state is refused without a wipe. The erase goes
through the configured flash back end, like the "erase" command, and the
lock state itself lives in the TA, so nothing here depends on the storage
type.

While the device is locked, the commands that change the storage or run
code are refused with "device is locked": "flash", "erase", "boot", "oem
format", "oem partconf", "oem bootbus", "oem run", "UCmd" and "ACmd";
"flashing unlock" is the only way out of that state.

Unlocking follows the "OEM unlocking" developer setting the way Android's
PersistentDataBlockService stores it in the frp (persistent data block)
partition, looked up on the fastboot flash device of the mmc or block
back end: the SHA-256 digest in the first 32 bytes of the partition must
match the rest of it (Android formats the partition otherwise, which
clears the setting) and its last byte must be non-zero. get_unlock_ability
reports that and "flashing unlock" is refused otherwise, so a device
without an frp partition, or with a back end that has no partition table,
can only be unlocked from the U-Boot shell.

Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
erase the partitions and flip the state reported by getvar unlocked and
"avb is_unlocked"; flash, erase and boot are refused while locked; unlock
is refused while the OEM unlocking byte in frp is clear, after the frp
digest was corrupted, and on an unlocked device; lock on a locked device
is refused without a wipe.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/fastboot/Kconfig      |  19 +++
 drivers/fastboot/fb_command.c | 363 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/fb_getvar.c  |  22 +++
 include/fastboot.h            |  14 ++
 4 files changed, 412 insertions(+), 6 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 88ed42ca5b9..9a5251d4b60 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -282,6 +282,25 @@ config FASTBOOT_MBR_NAME
 	  specified on the "fastboot flash" command line matches the value
 	  defined here. The default target name for updating MBR is "mbr".
 
+config FASTBOOT_CMD_FLASHING
+	bool "Enable the 'flashing lock/unlock/get_unlock_ability' commands"
+	depends on FASTBOOT_FLASH && AVB_VERIFY && OPTEE_TA_AVB
+	select SHA256
+	help
+	  Add the Android "flashing lock", "flashing unlock" and "flashing
+	  get_unlock_ability" commands and the "unlocked" variable. The device
+	  lock state is the one AVB enforces, kept by the OP-TEE AVB TA. While
+	  the device is locked, the commands that change the storage or run
+	  code ("flash", "erase", "boot", "oem format/partconf/bootbus/run",
+	  "UCmd", "ACmd") are refused. As required by AVB, the userdata (and
+	  metadata) partition is erased before the state changes in either
+	  direction, and the TA resets the rollback indexes on a state change.
+	  Unlocking is only allowed when Android's "OEM unlocking" developer
+	  setting, kept by PersistentDataBlockService in the frp partition of
+	  the fastboot flash device, is enabled and the partition's digest is
+	  valid; a device without an frp partition can only be unlocked from
+	  the U-Boot shell.
+
 config FASTBOOT_CMD_OEM_FORMAT
 	bool "Enable the 'oem format' command"
 	depends on FASTBOOT_FLASH_MMC && CMD_GPT
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index bbfd1637860..63b0f5705fe 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -13,11 +13,17 @@
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
+#include <memalign.h>
 #include <part.h>
 #include <stdlib.h>
 #include <video_console.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+#include <avb_verify.h>
+#include <blk.h>
+#include <u-boot/sha256.h>
+#endif
 
 #define FASTBOOT_DOT_LINE_WIDTH_DEFAULT	74
 
@@ -37,6 +43,7 @@ static u32 fastboot_bytes_received;
 static u32 fastboot_bytes_expected;
 
 static void okay(char *, char *);
+static void boot_image(char *, char *);
 static void getvar(char *, char *);
 static void download(char *, char *);
 static void flash(char *, char *);
@@ -51,6 +58,14 @@ static void oem_console(char *, char *);
 static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+static void flashing_lock(char *, char *);
+static void flashing_unlock(char *, char *);
+static void flashing_get_unlock_ability(char *, char *);
+static bool flashing_refuse_if_locked(char *response);
+#else
+static inline bool flashing_refuse_if_locked(char *response) { return false; }
+#endif
 
 struct fastboot_command {
 	const char *command;
@@ -123,7 +138,7 @@ static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
 	},
 	[FASTBOOT_COMMAND_BOOT] =  {
 		.command = "boot",
-		.dispatch = okay
+		.dispatch = boot_image
 	},
 	[FASTBOOT_COMMAND_CONTINUE] =  {
 		.command = "continue",
@@ -181,6 +196,20 @@ static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
 		.command = "ACmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_acmd), (NULL))
 	},
+	[FASTBOOT_COMMAND_FLASHING_LOCK] = {
+		.command = "flashing lock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_lock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_UNLOCK] = {
+		.command = "flashing unlock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_unlock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY] = {
+		.command = "flashing get_unlock_ability",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING,
+					      (flashing_get_unlock_ability),
+					      (NULL))
+	},
 };
 #endif
 
@@ -265,6 +294,19 @@ static void okay(char *cmd_parameter, char *response)
 	fastboot_okay(NULL, response);
 }
 
+/**
+ * boot_image() - accept "boot"; the downloaded image is started afterwards
+ *
+ * Refused on a locked device: nobody verified the image.
+ */
+static void __maybe_unused boot_image(char *cmd_parameter, char *response)
+{
+	if (flashing_refuse_if_locked(response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
 /**
  * getvar() - Read a config/version variable
  *
@@ -416,6 +458,9 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
 		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
 					   image_size, response);
@@ -442,19 +487,27 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  * Erases the partition indicated by cmd_parameter (clear to 0x00s). Writes
  * to response.
  */
-static void __maybe_unused erase(char *cmd_parameter, char *response)
+static void __maybe_unused erase_partition(const char *name, char *response)
 {
 	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
-		fastboot_block_erase(cmd_parameter, response);
+		fastboot_block_erase(name, response);
 
 	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
-		fastboot_mmc_erase(cmd_parameter, response);
+		fastboot_mmc_erase(name, response);
 
 	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
-		fastboot_nand_erase(cmd_parameter, response);
+		fastboot_nand_erase(name, response);
 
 	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
-		fastboot_spi_flash_erase(cmd_parameter, response);
+		fastboot_spi_flash_erase(name, response);
+}
+
+static void __maybe_unused erase(char *cmd_parameter, char *response)
+{
+	if (flashing_refuse_if_locked(response))
+		return;
+
+	erase_partition(cmd_parameter, response);
 }
 
 /**
@@ -465,6 +518,9 @@ static void __maybe_unused erase(char *cmd_parameter, char *response)
  */
 static void __maybe_unused run_ucmd(char *cmd_parameter, char *response)
 {
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		pr_err("missing slot suffix\n");
 		fastboot_fail("missing command", response);
@@ -492,6 +548,9 @@ void fastboot_acmd_complete(void)
  */
 static void __maybe_unused run_acmd(char *cmd_parameter, char *response)
 {
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		pr_err("missing slot suffix\n");
 		fastboot_fail("missing command", response);
@@ -566,6 +625,9 @@ static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
 					      (-1));
 
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!env_get("partitions")) {
 		fastboot_fail("partitions not set", response);
 	} else {
@@ -590,6 +652,9 @@ static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
 					      (-1));
 
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
 		return;
@@ -617,6 +682,9 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
 					      (-1));
 
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
 		return;
@@ -672,3 +740,286 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/**
+ * flashing_flash_dev() - block device of the fastboot flash back end
+ *
+ * Return: the device of the mmc or block back end, NULL for back ends
+ * without a block device (nand, spi)
+ */
+static struct blk_desc *flashing_flash_dev(void)
+{
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
+		return blk_get_dev("mmc",
+				   CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+						     (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+						     (-1)));
+
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
+		return blk_get_dev(CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+						     (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)),
+						     ("")),
+				   CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+						     (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)),
+						     (-1)));
+
+	return NULL;
+}
+
+/**
+ * flashing_avb_ops() - AVB ops for the lock state calls
+ *
+ * The lock state is kept by the AVB TA and these ops never read a
+ * partition, so the storage device is only informational: the fastboot
+ * flash device when it is a block device, none otherwise.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: the ops, to be released with avb_ops_free(), or NULL
+ */
+static AvbOps *flashing_avb_ops(char *response)
+{
+	struct blk_desc *desc = flashing_flash_dev();
+	AvbOps *ops;
+
+	ops = avb_ops_alloc(desc ? desc->uclass_id : UCLASS_INVALID,
+			    desc ? desc->devnum : -1);
+	if (!ops)
+		fastboot_fail("cannot allocate AVB ops", response);
+
+	return ops;
+}
+
+int fastboot_flashing_is_unlocked(bool *unlocked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = flashing_avb_ops(response);
+	if (!ops)
+		return -1;
+
+	rc = ops->read_is_device_unlocked(ops, unlocked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot read the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_refuse_if_locked() - fail a flash or erase on a locked device
+ *
+ * A locked device must not let fastboot change its partitions; only
+ * "flashing unlock", which wipes userdata, may be used to leave that state.
+ *
+ * @response: fastboot response buffer, filled when the command is refused
+ * Return: true if the command must not run
+ */
+static bool flashing_refuse_if_locked(char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return true;
+	if (!unlocked) {
+		fastboot_fail("device is locked", response);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * flashing_set_lock() - set the AVB device lock state through the AVB TA
+ *
+ * @locked: new state
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+static int flashing_set_lock(bool locked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = flashing_avb_ops(response);
+	if (!ops)
+		return -1;
+
+	rc = avb_write_lock_state(ops, locked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot change the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_wipe_userdata() - erase userdata and metadata
+ *
+ * AVB requires user data to be wiped on every change of the device state,
+ * in either direction, so userdata (and metadata, which holds the file
+ * based encryption keys) are erased before the state changes. The erase
+ * goes through the configured flash back end, like the "erase" command,
+ * but without the lock check, since this is how a locked device gets
+ * unlocked.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 when a partition could not be erased
+ */
+static int flashing_wipe_userdata(char *response)
+{
+	struct disk_partition info;
+	struct blk_desc *desc;
+
+	erase_partition("userdata", response);
+	if (!strncmp(response, "FAIL", 4))
+		return -1;
+
+	/*
+	 * metadata is optional on older layouts: skip it when the flash
+	 * device has a partition table without it, otherwise its erase has
+	 * to succeed like the one of userdata.
+	 */
+	desc = flashing_flash_dev();
+	if (desc && part_get_info_by_name(desc, "metadata", &info) < 0)
+		return 0;
+
+	erase_partition("metadata", response);
+	if (!strncmp(response, "FAIL", 4))
+		return -1;
+
+	return 0;
+}
+
+/* blocks of the frp partition hashed per read */
+#define FLASHING_FRP_CHUNK	128
+
+/**
+ * flashing_unlock_allowed() - evaluate Android's "OEM unlocking" setting
+ *
+ * Android's PersistentDataBlockService keeps the developer option "OEM
+ * unlocking" in the last byte of the frp (persistent data block)
+ * partition, non-zero when the user allowed the bootloader to be unlocked,
+ * and guards the partition with a SHA-256 digest in its first 32 bytes,
+ * computed over the whole partition with those bytes taken as zero; on a
+ * mismatch it formats the partition, which clears the option. Apply the
+ * same rules: no frp partition (or no block device behind the flash back
+ * end), a read error, a bad digest or a zero byte all refuse unlocking.
+ *
+ * Return: true if "flashing unlock" may proceed
+ */
+static bool flashing_unlock_allowed(void)
+{
+	u8 stored[SHA256_SUM_LEN], digest[SHA256_SUM_LEN];
+	struct disk_partition info;
+	struct blk_desc *desc;
+	sha256_context ctx;
+	lbaint_t blk, cnt;
+	bool allowed = false;
+	u8 last = 0;
+	u8 *buf;
+
+	desc = flashing_flash_dev();
+	if (!desc || part_get_info_by_name(desc, "frp", &info) < 0)
+		return false;
+
+	buf = malloc_cache_aligned(FLASHING_FRP_CHUNK * info.blksz);
+	if (!buf)
+		return false;
+
+	sha256_starts(&ctx);
+	for (blk = 0; blk < info.size; blk += cnt) {
+		cnt = info.size - blk;
+		if (cnt > FLASHING_FRP_CHUNK)
+			cnt = FLASHING_FRP_CHUNK;
+		if (blk_dread(desc, info.start + blk, cnt, buf) != cnt)
+			goto out;
+		if (!blk) {
+			memcpy(stored, buf, SHA256_SUM_LEN);
+			memset(buf, 0, SHA256_SUM_LEN);
+		}
+		sha256_update(&ctx, buf, cnt * info.blksz);
+		last = buf[cnt * info.blksz - 1];
+	}
+	sha256_finish(&ctx, digest);
+	allowed = !memcmp(stored, digest, SHA256_SUM_LEN) && last;
+out:
+	free(buf);
+
+	return allowed;
+}
+
+/**
+ * flashing_lock() - lock the device
+ *
+ * Verification errors stop the boot afterwards. The AVB TA resets the
+ * rollback indexes on a state change. Locking needs no permission from
+ * the OS: it only takes privileges away. A device that is already locked
+ * is left alone, so userdata is not wiped for nothing.
+ */
+static void flashing_lock(char *cmd_parameter, char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return;
+	if (!unlocked) {
+		fastboot_fail("device already locked", response);
+		return;
+	}
+
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(true, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_unlock() - unlock the device
+ *
+ * Refused on a device that is already unlocked, when Android's "OEM
+ * unlocking" setting does not allow it, and when userdata cannot be
+ * erased.
+ */
+static void flashing_unlock(char *cmd_parameter, char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return;
+	if (unlocked) {
+		fastboot_fail("device already unlocked", response);
+		return;
+	}
+
+	if (!flashing_unlock_allowed()) {
+		fastboot_fail("unlocking is not allowed, enable OEM unlocking in Android",
+			      response);
+		return;
+	}
+
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(false, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_get_unlock_ability() - report whether unlocking is allowed
+ */
+static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
+{
+	fastboot_okay(flashing_unlock_allowed() ? "1" : "0", response);
+}
+#endif /* FASTBOOT_CMD_FLASHING */
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 2eacc84c465..a85e1b0915a 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -28,6 +28,9 @@ static void getvar_has_slot(char *var_parameter, char *response);
 static void getvar_partition_type(char *part_name, char *response);
 static void getvar_partition_size(char *part_name, char *response);
 static void getvar_is_userspace(char *var_parameter, char *response);
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+static void getvar_unlocked(char *var_parameter, char *response);
+#endif
 
 static const struct {
 	const char *variable;
@@ -87,6 +90,12 @@ static const struct {
 		.variable = "partition-size",
 		.dispatch = getvar_partition_size,
 		.list = false
+#endif
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+	}, {
+		.variable = "unlocked",
+		.dispatch = getvar_unlocked,
+		.list = true
 #endif
 	}, {
 		.variable = "is-userspace",
@@ -354,3 +363,16 @@ void fastboot_getvar(char *cmd_parameter, char *response)
 		fastboot_fail("Variable not implemented", response);
 	}
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/* "yes" when the device is unlocked according to the AVB TA, else "no" */
+static void getvar_unlocked(char *var_parameter, char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return;
+
+	fastboot_okay(unlocked ? "yes" : "no", response);
+}
+#endif
diff --git a/include/fastboot.h b/include/fastboot.h
index f02d2559f2b..f3aa6fcc229 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -53,9 +53,23 @@ enum {
 	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
+	FASTBOOT_COMMAND_FLASHING_LOCK,
+	FASTBOOT_COMMAND_FLASHING_UNLOCK,
+	FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY,
 	FASTBOOT_COMMAND_COUNT
 };
 
+/**
+ * fastboot_flashing_is_unlocked() - read the AVB device lock state
+ *
+ * Available with CONFIG_FASTBOOT_CMD_FLASHING.
+ *
+ * @unlocked: set to the state on success
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+int fastboot_flashing_is_unlocked(bool *unlocked, char *response);
+
 /**
  * Reboot reasons
  */

-- 
2.53.0

