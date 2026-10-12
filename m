Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17440CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F027D40538;
	Mon, 12 Oct 2026 19:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLDcq935AIqb; Mon, 12 Oct 2026 19:57:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 892A94053E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791835022;
	b=BuJhwU90drfuBupSgmYD1fonYIP5cNO1Bccl1WDoJu4Ed8RsqgVwIVNyF1l7Zv2T3/yj
	 7ZkIAlvpZV1d/sx/L8NluB3MDXm3HODxD0YB4Br028glPDZM9j3wsgMpep8Gs4L0oh8Ue
	 98urJwqPd5NpM/cLzT+K06Xr2ruoc2BjAy6FiglPjE93Z12limHEIASjYWlgLpAw5IEZ+
	 zu9B4cAKkiK+bKtnRYHGZoc4JYNF0lTMI1hRDSIjWEPky/KYO5zKu8w+4LZbFuB8iShbn
	 MfPlsRvCBX1DpDGLiYz5pfAB2S2NFeSeFBG8PBDz/iaUbNOCwQ9CFEtUe7StGWBfWcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791835022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
	b=rEmqe1OaWrFQLaxvv2Rfm62IFoq7ijBQBSoqJAtr1lemaEkDzOg6fIrYxzgdGA9YJZt7
	 SsakqVqbGIDAzkCS8vmHaIh904J/oUoytU2qKW9KLveXmS0ZiN6kzAtB5X0W2KLbsAZ5V
	 1jEGkCZbbMAUTPBdSjI1xBW16UGmxo6wPs3RDt0ekXCCYW4FO/jX7akT0JZYmOCEUHW/U
	 itzLUA7ZKl5XBMRHVYzt6NGkx/PdP/Y2/xtZB5APd1uizc5O+5YBbqsogZUMjw+0CKIon
	 91TnzCvHqwG6nZuqAKLBwK0EZHitGpfiAWbIw3YA2gSVIJ/c0kLlTqLIjhHqxUjtANA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791835022;
	bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LOeKJZ1zDTK1bhmieplMu96AF39w+N7IP3PaijBRXmc0lN6wM1/Fogad+0CLz4Lqr
	 cH3pLE9tNpr92WShsMDuYo4UneduO1smEz/Tm3kuFfEPgMAvb6axhjrBkYBEPo+BNW
	 YMawJpDnmTfOwHue4XQXN/uAFBAMLNNXVLBG8t1RHwjscs/2w40AOTpz7ClTVFdhrz
	 UKsxxo0eul3w0K5OWey0r57aMkj8g9A55OsFsZRO/ld/trAEE9G9Rl3K3NpRFvZYnP
	 oXV1Qld/1vE65atIC5/KhHd2EK+qsJeE+8evguNQcdTEMzb7mwPt4ZRIldcvHP+77l
	 bSDD0t0e3AQXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 892A94053E;
	Mon, 12 Oct 2026 19:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BB522A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E0444010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vcK8c3JCQIla for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CFDF8400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791835020;
 b=BYqPeTmyLI5xoopqpdQOBwxjxjVoFAW0CFpriQitom2zHSKBd0zVCkz3wJiJz4xOqb8y
 qltaWl5WdB9/0z53fmYLc3VVPREh2DKayu+W0BqrwQQJDEWZzQwocsbZuJpZ99BuHf3/Q
 i5DOXlpIiad3zM8YR8nP/pBKLT7K987ew2gV9jUYFFswgrGROvyzwTSfKuBciDl5zQfwz
 ourI7+uM7gPmd8FYq+GN8iCNhfOiYB0iqTharIECCaejfOCyTA52hio8Q1OwOKQJjkGl5
 XzDKSaBrDtWP4ZWJgsKhT4lPE//6mM4oopZcUWDyWfuU2W39Ji8lZzMeKIav6Np48Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791835020;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
 b=mjh4fwTs8jPkCGhTF0mKHgOiFSDyJaqjNxGTJo+4chosznqD64xKzdjHaL/XtpVz7JpR
 LA0rb6XraUWtntGvmqG7WV7uwyO8u1KxdW4Mc9Ki9k1IeZ5vq81JHc26ac4pJUqX81mIm
 e1yqbLM7Do0Gz8kjrcV4n1qwPUhvSwbJrZ618nLfpb+TD1KCgY5DtMq0DCm7uUYEaAmyT
 VXu+1TGj0f81df+JSNquPA8ywmzNWpPw5tjWmdjEWwXbpNnfdO7AB5tTYoj6r3288Rgy9
 TSX0I6W+rGybgSeofo8KcdEFNZrx0j6wV0PqRcd1jdQ9dau7gwXUBtTiAKqDBDACx9w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ate5JPJm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UjtGC39x; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ate5JPJm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UjtGC39x
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFDF8400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJMnwI080163
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=; b=ate5JPJmpp9prIAE
 P9j/k8eWfWeptdbHLV41lM/29aZorkaG1Hxog+WOfYJKzl+dkovjMv8NkyeUGfGm
 bGeuab/CthKW3puPvDaRRVdRjJHcYc3ai9FtB8tU0txBMGBOi6K7xETnQbqR6/vL
 HY9S4PwfQeTbaS/0mgVpsbxfUSDsfLf8UXFY804GdJSU2qNW4CNzBgKJqJ5vLN1a
 t/R4Hk/ZKa5fhFrI5ntOHgOHBQz5bnEEtc1+XIr0lmz6Iv8kYGWjfQx/wDVuJ4Yp
 JZg5j0/TpsX9BSF14QTW2hGujg9VCfNpClYeIz0NAuYJdd2V8phFo8W80BfcgOH7
 UqUdYA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3k7mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:56:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b994cb09fso2284516d6.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791835017; x=1792439817;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
 b=UjtGC39xQLbYCf8iT3RdyIRYBZLgjNGK9SO6tlivW7q7vzqnzJ4dftm19SX+uPE0/i
 SplTfBQkxmvOuKApKNgIt/4WCiFf5q/KBjy8fzMNUpGvUeVNwpDokUupLbe1EIWSjekN
 NQM6o6laSuoKKAwqjV/t4olfNMA7Y01jwuyAhqDsL3alcgAmPdwDqy1h1CEzoUDTU+Bn
 MhFQYv21yGnsUZfB2dAC6UjMe4J9qXLaKHrvn58r0Z6+WpdhFTIHK5aeTMRy6NBUmUSZ
 AG44XbxHgZn9D+myDYCW43mzIp3sHHJhgzn8eB7kCzaTYHWBZaklqXdK98z+TcBBSdPm
 eOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835017; x=1792439817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
 b=tlN4kd559LBEl1sDfMJAwcSoSCx4sLvFOLn1V783YWi+IlF0QlisFBLnIlYOLC9kqM
 G46qVhSQfzagLgHBe9744Er4mVDQ28VptMlGUCKDtK00+h2VB89qO1eL7HOiCLbsxtkD
 1YA2WAqE2KdmRujD7+m4o8s43KuZrVMK8p1YZTs2q5+N7FDVVb5GXx9O8J+WirWGi+rZ
 a6YHLnJHd0CK1gmTL9XczqYGmlSxRFNVJoqxKUXXhImv0KwKc2ET9XZpfoNxV382hfC9
 L+BMWBBscPeoGO3kjthUEHmwr4p2Zld1Zg6PP7dJAMqCdP7uS/iROChjycXOT83EeIt8
 1skg==
X-Gm-Message-State: AFq9FYLVpscNMIGTlnHcRFtQ0nrH9iH0ppnqvkIc47ZVGgM0xyFZm27H
 kxEc+B6Dak9RbOksQi31kegCSYlZN3CbftDwLaT/JDzwSEDwcnMe6KLMEKc1fajIRJ8LwgrC9zg
 Gnt8SJ0u6K8zJYTvGT7sNuTDDIgz1bwQiswdCpGmN0Xk61I2mAD9mjOT3x79VSoKjlZefVdE=
X-Gm-Gg: AYBFou399rN2nq1SBdNGXTUx5rANSaWhqlZMP0Y5V4CXgSRMhXl93cEbrjFy9JWihIQ
 G5HzQicJeL8jQLWmN6E6AXakSq2IhMyNSkR2cbdyxeO/iJAn1ROo9r3Jk980A/63dWHQmbkfjey
 lQmLJPrCaX6D1PUWeKtCI6fhnnVV2kBDm15fj1eWOwD5EUKAvemDSQaN1PMk9alweszbO0mFCyX
 hHPMsTcaKf6bjMHjTFFCYI5ClgQ0+Mo/w8V+yZDxb/+9UMikk0DEyWfgXU+JsDtJvPB5m446/1w
 +cv+Ah+OHBiYsu654anv26IxuTahrpc/TBYkN7DOHlWbtVL8F6cOJWmnKy9yXxpTk0Bi8qjYR5S
 TEx/LLvNa+kIh/RweoAkEr3nl77HbqGg6tKKos84P3Oov
X-Received: by 2002:a05:620a:3720:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-93ebd23a1a9mr1726554985a.53.1791835016537; 
 Mon, 12 Oct 2026 12:56:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-93ebd23a1a9mr1726552185a.53.1791835016027; 
 Mon, 12 Oct 2026 12:56:56 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3bbe2sm489178266b.27.2026.10.12.12.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:56:55 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 21:56:43 +0200
Subject: [PATCH v2 1/2] optee: rpmb: select the RPMB partition per request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-optee_rpmb_b4-v2-1-85d76a54273b@oss.qualcomm.com>
References: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfXzbkD4sofueRR
 j27Cca4lDf4BIZ8FpSrrnDCyDmTy+VnIHqH0DbgEow7YVTkbe0zDU6MamWaSWVsa8HhqAEy/wlT
 kognRN/3fJI5kjUV6sdFen0WB31F2SWnD3+ExnmPMMuPicFnaz1TPsJek1UqL2zLk1gGMtgt9Vu
 bYz5EAWXAlytnHdKZnFkP/gXlIfSwpOXXZbQNgbFbLR4G8ZZZzWJ7u1clnJktSPNIl2+ZmNLIAE
 ZRJ3hHUUjKituOhreISx8ISTPbZd59xntV7to33hSZS4zW89A3ArNM8uNV6150PuFyMNuuJa9di
 Rg9oSppvRFnzay0nNwdx6/PGFaq1tXKxovDJZye6M+pRpstxbqimqG2CTGI4QRj+z2n0Vtvx30x
 WhISN7Lks74NZUE5gqtBuaGeyXq/VhR3ygE8sR8s9bYKW8jkKXVPqnd+uZ5d5sq3zc0s6KKXQz5
 ayIMRfy13VmNbtA7PEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfXyQ02bvy0pF+u
 oym8lIwXTMJ6AQNx/HaEdyqmvUFyiaZqQQrJAk0hK17WEK2eFXoNWsEng2JMi3oeqJF4uxsOZ8a
 BVIAJPsOcU85FSlED59/8ac5zF5zKOk=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acd3b89 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=zL1JONcZbJ0eZN6WwLkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: xGCeZfbdYMMtzCms2yhQ9mxh0BOkkEhH
X-Proofpoint-GUID: xGCeZfbdYMMtzCms2yhQ9mxh0BOkkEhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120079
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

The supplicant switched the eMMC to the RPMB hardware partition when the
device was first used and only switched back when the OP-TEE session was
released. Between two RPMB requests other users of the same device switch
it back to the user area: libavb does so for every partition read while
verifying a chain, and the Android bootmeth reads boot/vendor_boot right
after verification.

With RPMB left selected those reads hit the RPMB partition, and the next
RPMB frames were routed to whatever partition the other user left
selected, which ends in status timeouts and I/O errors (seen with
the AVB TA on QEMU's emulated eMMC).

Select the RPMB partition around every data request and restore the
previously selected partition afterwards.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/rpmb.c | 61 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index 7ae6045511b..ea5507af086 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -42,24 +42,15 @@ struct rpmb_dev_info {
 
 static void release_mmc(struct optee_private *priv)
 {
-	int rc;
-
 	if (!priv->rpmb_mmc)
 		return;
 
-	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
-				      priv->rpmb_original_part);
-	if (rc)
-		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
-		      __func__, rc);
-
 	priv->rpmb_mmc = NULL;
 }
 
 static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 {
 	struct mmc *mmc;
-	int rc;
 
 	if (priv->rpmb_mmc && priv->rpmb_dev_id == dev_id)
 		return priv->rpmb_mmc;
@@ -86,19 +77,44 @@ static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 	}
 
 	priv->rpmb_original_part = mmc_get_blk_desc(mmc)->hwpart;
-
-	rc = blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB);
-	if (rc) {
-		debug("Device id %d: cannot select RPMB partition: %d\n",
-		      dev_id, rc);
-		return NULL;
-	}
-
 	priv->rpmb_mmc = mmc;
 	priv->rpmb_dev_id = dev_id;
 	return mmc;
 }
 
+/*
+ * The RPMB hardware partition is selected for the duration of a single
+ * request only. Between two requests other users of the same eMMC, for
+ * instance libavb reading the user area while verifying a chain of
+ * partitions, switch the device back to the user area. Keeping RPMB
+ * selected across requests would make those reads, and the following RPMB
+ * frames, hit the wrong partition.
+ */
+static int select_rpmb_part(struct optee_private *priv)
+{
+	int rc;
+
+	priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
+	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
+				      MMC_PART_RPMB);
+	if (rc)
+		debug("Device id %d: cannot select RPMB partition: %d\n",
+		      priv->rpmb_dev_id, rc);
+
+	return rc;
+}
+
+static void restore_part(struct optee_private *priv)
+{
+	int rc;
+
+	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
+				      priv->rpmb_original_part);
+	if (rc)
+		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
+		      __func__, rc);
+}
+
 static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
 {
 	struct mmc *mmc = find_mmc_device(dev_id);
@@ -130,6 +146,7 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 {
 	struct rpmb_req *sreq = req;
 	struct mmc *mmc;
+	int rc;
 
 	if (req_size < sizeof(*sreq))
 		return TEE_ERROR_BAD_PARAMETERS;
@@ -139,9 +156,13 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 		mmc = get_mmc(priv, sreq->dev_id);
 		if (!mmc)
 			return TEE_ERROR_ITEM_NOT_FOUND;
-		if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
-					  req_size - sizeof(struct rpmb_req),
-					  rsp, rsp_size))
+		if (select_rpmb_part(priv))
+			return TEE_ERROR_ITEM_NOT_FOUND;
+		rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
+					   req_size - sizeof(struct rpmb_req),
+					   rsp, rsp_size);
+		restore_part(priv);
+		if (rc)
 			return TEE_ERROR_BAD_PARAMETERS;
 		return TEE_SUCCESS;
 

-- 
2.53.0

