Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C5DCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F9E2605E4;
	Mon, 12 Oct 2026 17:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bVyKV4uIRaIr; Mon, 12 Oct 2026 17:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BDE356060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791826359;
	b=s8hFJ4QUivYsOL/KJ7heYiTeptvkavmGpEowmSf0f5qLz/9azR2XFkfnbvQn6zBbEz5h
	 gkf7LIx9LwAJSTsRKTD8hwxh5L8/SzNXDeTAn0+vOQpluLt906Q/6nBQbhxELfQkFBZvL
	 xP8bAaLiGFDEorMAdiuILkmk3lPoZU5w4EdNX/qcC3g+/PZUVczD2HlU84fZTuqmQwpwS
	 UsC3LZ4Ehn6tIzcvHVUhjA3qxN67btr/Lg4Vb+ZVA5xHcDZ1fVmPIm3LcALC1U+SAGYBs
	 AIHMYQVi6v5Ceaot9bRsgINLA/UyOqzbFf/E7KFTlviWCYtEYaElrBg8veKxhbu1DFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791826359;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FDuQ/BWhhr5IjG1uyuRpiwMUks4CGYJGoL8zcjDyHhM=;
	b=YeGiIQhx6ESbKmSaMA50NaGUEshDgcaViRlh7KB85qNuwg4FsaybV8FeR7eLzAA9tLRJ
	 fWeelD2ZCvv9qzwrUMEMBMbOhoU8X0CJomouhlH8vL5C6G8ivIyIvlZ+HMQDMzo+On12y
	 BqjLOznxga30fOFcWdWGl/C56ip9YtMlMrSWmAE7M9rNYQQo+EYYiMWbGSfn/tQOyW7b3
	 tE9sEGvNyZCo6XC39yn2jRWwasFyICCWjHK1HXkdbArPO5aVBm1ciraH9+uCQJ79iRYql
	 dwG38ZqihD9uUkWTipKSRitIIGUZrgAw7gYIoiPSMbsK6cNwjLyOkvQDmFUsp9Gq/tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791826359;
	bh=FDuQ/BWhhr5IjG1uyuRpiwMUks4CGYJGoL8zcjDyHhM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HQNrcjHwYlTFwn04tI/NYTvF15GbHVxEe5oSTSB/Fk7IlfPEM/UpX/KAwIpAgGDq8
	 giu75oot0Ixc+J9Y51MU6gisUOgmfgUfTlyM8T69aXRHWf2aSLXfvp5DXZorERD/hx
	 epAG1pyTZc5caJAKsN5Exlk0CNxeAPPZAxmV0f02e4Y6BFHqwTNiAwFIlOSBtygTAA
	 Pa7VIj6T+zGbyzn8DDeik+FLRSk+j98TuEWAvphn17S3RUKiuRgSzOl5Q8TF2E1k6G
	 PcWuLoO2vyne4egBFNraTrUY+sKf5381RkL+3VuoYioKWqiTJcBDtCvgULI5bFBePj
	 izYmv5glrlQIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDE356060C;
	Mon, 12 Oct 2026 17:32:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 797142E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F66480C23
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9rYK0o8Txz8 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A92D880C0F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791826357;
 b=AS6GegFB8NsbZUv/v3uvE/VSnyICwDOsmpTFNlTAv5TFSz82O/aJG8Pw1p2G82KhjjKE
 0fJNVJp0SKv+cSt1/M/vowNYSpSZ5l9CS2k+SlPd3QbPZ5ImmU0mL/fYhvu9E7RjCaKG9
 vMbJXxQ4okJxgd4idNGU+N39C0GC3PVID0ud5wXhJVhKDIKbFvDjaaxxXh7zyH29zlK2y
 4sMgAQEp2DOnxT8/YzxVxcG6jvOjd/Rvqus7MqgzRHERmlY+SsTNRYX+vho6uHf5TdFsS
 HHeuP12NfrTA2mXw2y+aNX6qlhd7sjRwnLxPHfBMMclOZ8VQRhZ0ZbOAgovJFkYeSUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791826357;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=FDuQ/BWhhr5IjG1uyuRpiwMUks4CGYJGoL8zcjDyHhM=;
 b=FY3SLsIObPDEHKWivS2uCArUYA5PatXG6kOR78G6Yv5oPmbm1xKrxhAcJB4djfwY9oZ/
 OSVXvwPzMJKd9qDX11nLW/Zksj8CcGo5eQlyv3H79K0luUp8V8fbsgSPGZNSnoEqbp9My
 wjdzPRZ7N/Twmulls6DHd7FQRY+zwC3/YOyBdqW7ybWtFGiDMBj5dXMc9k1ejJxdUm9om
 fUIcT3zGfjWL6vYzOkkA7NUydwaUE4wAdA77RcmnyytqS115Gu/85PYOc+w3bGAHgVn3Y
 41jy4ecqNspCVcy5loJY7wxW6RsU3gyaC5mJyUCzea2HhiXTpLyBb77G6IXaUc322cQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Hptu+EKm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RguXdkeJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Hptu+EKm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RguXdkeJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A92D880C0F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:32:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFev731895541
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=FDuQ/BWhhr5IjG1uyuRpiwMUks4CGYJGoL8
 zcjDyHhM=; b=Hptu+EKmuHKbcQYVi6JIn2CwF97eDq48KROYJEjvTcyKWfgiCGA
 Ft5ntwtu5FdzPNot69+3a7MTt+mXJtMk/EmnPc10FWFIHJB845q6lCk6JZWbeQKW
 ya6rOM18Z9LjnoOcagjOTgxXlsc0N4CYUlp8D4M9MpQMRkz0zISewAvtzqe0aL84
 WiGipLyvWxIhP0Wqk/oLAcgeaQeX6OZGx04tlPJ0EHHJwOBjLRmN/5UyHnUZrYBV
 ApW+EGyTxzLqZHrfPXzEqe08+6UIO47WqsdRQoBFW9PtoP3BL5SW/IEOXHc03Lju
 dwnxTqUt9fzzJhGdq2brjOwg797PyZH2+eA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ktcbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:32:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35b68bc1985so776360eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791826356; x=1792431156;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FDuQ/BWhhr5IjG1uyuRpiwMUks4CGYJGoL8zcjDyHhM=;
 b=RguXdkeJSqHsR8ao8Z9EMpbrZ1Fqm9TfFJoWR/4Z5NbWVKCpJOhqYahMh28V0/AuKN
 OZuuLFgUzdvxPkuF9tA1APADIJvdyqyevRWKiZdaG9f8REtLoqZz3HRZEqWeSmCremtU
 rxUeb3fRYjh4RZipKeZ/Knl6uwd/HYHz6Zjump8ZI2kgA2tVMYkyG/6sUBEeY0nXIsrQ
 LTpnlTwVVIULytgYvzk6A8WYPnJXDdt+nZ2DElWeeEMMf1N6mS3V8lTVCPp7njKxPnD2
 /STZT6S+mZX9DB/vWDFc82+SFpACBY4jbzF1HWePKj6+nfVFPW/s/JlfmgxLQnq7EUjI
 C3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791826356; x=1792431156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FDuQ/BWhhr5IjG1uyuRpiwMUks4CGYJGoL8zcjDyHhM=;
 b=jWLPXR4oaDrw93axzqFsa2oYnyT3mxQtVf3LHUGCINIqFd3flxPDyJeLUEiHjrJTIm
 wMhkv0K1w4EmDduoEe8r5Mke7kH7xKobeFZmjFLkZ6Q4ixPdYjOv7GZkpsJ2OARNjBPd
 n8sp/XJTGz57/F4zF4X90pv50FY1pHDPLCchSD+i5/rYmWeqJfY7nlQzmHkR78V9VRWI
 YIcHjgdP6IuQ4AhWHgPgUlC9cUmKu4JJEddXc7g+rRPyWAQwCNrUU87CbmNqj83V6aDn
 js+rtI7Y//acsjlTYtcJ7weSIb1RsFUczdbA630fOExnE/PV0D48FffNx4HejJoSY42M
 mKOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBznHr/sNJrtJGjSKLJkoyuGKiT/t8XZTrBgE0H/D5ekZFnJ/0Njoy9vJpHhvWkBmU2zrbKbJdo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLmiDWuqoCGGLiUnhP958G865wHPwcfO981ITlYOIVuQ3JgWyxg
 LwkLDwdbBe+faU18dCWrJnkv06IwpvntkxwknreIR1Id21ntu6y0yV05f//gDb5NgjNFcxYhjxs
 wsAlOkPTwODaLLiz+xUtfEjnR0UucpUhc2kWIXfF1g3zWivL/BCba8Q/A5PGmyV1Y3H43KNk=
X-Gm-Gg: AYBFou3R6i+mKlYJRiQISzy7vXloZDKxghwnY5uOclBF4Fi8UBrrJOxKGg9Lg7Ng98w
 gSi5ZdUcP2iTL5ECYYfNQgbhbCl5AxTXB26c2MO71/eUt52l/0XwsBaHnAWrSGS+Oy3prdAfs1L
 Etex/BWSxoLHxvaSvF9Tysnbee12SXAsMQuhJOcFQGFSMMtDqVM9hOQh7+Kv0b8d230XCTqzmM0
 hFshi+GrvgAGWqbAp9IG2n3K8nkSZgmISGrgofrgdsYscIr/wJj1hl+pS0K4v9/yxjgTTtocjkb
 cX/1JxT4SgODzadrprthBcvJLc7y9/rG7Z0+pLDZg4H6RA1d2+6DaOQt+cXm519NqGfGd2woacb
 s/jkh8liJYVMuNqcZCdE5bK1VZZgP+uLFYx5PA8sJOpGJ1SEPHHodKVvT5yVJ7VtZPoxJK75UHz
 UF2TxxBtFd3j98u4UkWWU=
X-Received: by 2002:a05:701b:428a:10b0:14c:b520:7db with SMTP id
 a92af1059eb24-16a5ab1a9damr13769277c88.7.1791826356029; 
 Mon, 12 Oct 2026 10:32:36 -0700 (PDT)
X-Received: by 2002:a05:701b:428a:10b0:14c:b520:7db with SMTP id
 a92af1059eb24-16a5ab1a9damr13769198c88.7.1791826354646; 
 Mon, 12 Oct 2026 10:32:34 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a4429603sm30102175c88.17.2026.10.12.10.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:32:34 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND v1] mach-snapdragon: smem: Use available_length for RAM
 partition v2+
Date: Mon, 12 Oct 2026 23:02:27 +0530
Message-Id: <20261012173227.1615249-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OSBTYWx0ZWRfX/yY8wlHzbd3B
 YwGj5+Tj/xfv0ZMwURl4ihJz/GhAKRTfvrdmHNxkRWwQLBN3e0KQ/hqaa+wOD6oD38HIElpJH4F
 mUwqltnNkDa2753oIjhExDPtBnBigkoEJ4lFBO2DgkSFtGis/CumxSgPHt6WGTxEG3LxfW1n21b
 O7l03+Da58ek8NaeMgutCZGPNOdcbNwSZwbQvzJ9rt5AhBAFFc0ouHI1HMZNmrPWUCNwdqpVB5T
 /Sr5GO6+8rInvK3VbNEOhAQt86A990B4K0BNHGC1crx4v+vyR/HOfJsFxXvXkv8I0R4qwN5rQSX
 m8dLVaTUC3VoEXTPE7kFhufm0eoCq0BkIokdLeaaAXT9jVuypNek/rTOLDvXYt2THFksnhEPewg
 9L6Vt2pUSjNwj3NC3aDunEuaG2oPuVF+Njwu6ZmiLxib7k5sFNcCV44UFJM2ueb7P26D6IWXrtw
 MLWloEicTd4q4QnXrdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OSBTYWx0ZWRfX/BCCuamk7YuI
 6CWkGtN8295E4s1oK65VGtFTLWYGHcTna1GETBuuVMITTTQROeru/l4O97tSFAzgS4DxYXDZ3TV
 hDvtYaFI/FOJkDXMebUw5nW8WUt/7+E=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd19b4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=NQbW43lCRD_eDx5gHQUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: GZgtc8QWQosN5n3mM_2GEpjnxUObAhEL
X-Proofpoint-ORIG-GUID: GZgtc8QWQosN5n3mM_2GEpjnxUObAhEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120069
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

Using length field exposes dynamic carveout regions to kernel, causing
crashes when accessing these reserved memory areas. Subsystems like
hypervisor perform runtime carveouts & records it in SMEM.

RAM partition table v2+ includes available_length field which reflects
memory available after these dynamic carveouts, while length field
represents total partition size. Switch to available_length for v2+
to exclude runtime carveout regions.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/dram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index 0b97b698322..914ee6cd4ff 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -70,7 +70,8 @@ int dram_init_banksize(void)
 				 (v == 1 ? ((struct ram_partition_entry_v1 *)(e))->field : \
 				  ((struct ram_partition_entry_v3 *)(e))->field))
 #define entry_start(v, e) entry_field(v, e, start_address)
-#define entry_length(v, e) entry_field(v, e, length)
+#define entry_length(v, e) (v > 1 ? ((struct ram_partition_entry_v3 *)(e))->available_length : \
+                            entry_field(v, e, length))
 #define entry_category(v, e) entry_field(v, e, partition_category)
 #define entry_domain(v, e) entry_field(v, e, partition_domain)
 #define entry_type(v, e) entry_field(v, e, partition_type)
-- 
2.34.1

