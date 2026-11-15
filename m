Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F13606A31E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p4EVEv49;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KiI7gJs6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y5YkVNlf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F189F606D5;
	Sun, 15 Nov 2026 11:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BoLU5MBtGqVg; Sun, 15 Nov 2026 11:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F32F260698
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794740739;
	b=cJGpxJNK646sZq82WwxxaBEsyWUEggLzweU+P3ZgwqXOFO33u1NfEYHUcj04nusdyXNE
	 DugNReqPZIyFAJ5OaB8AUDw+eecu8bzfILmkGgvE6JosWs9NIiUb2NrM2LHFrJ9Rbrcw9
	 7n0NvX8PeUEgd3TDiFS1hOHijXvkDvR3BknoYh9tZ6zhY16ppmB7DggTuj1MXYpd0Eav7
	 hADERSpzs3SCZYj638eRUhklIvSzBmmasvTUcPYv+8bWhyriqhg3HcK2fqLxY7RIHKx4h
	 ReXvqmq7hQSf11XkIGd3p2ktW6Kk+MP3JFwLAgxPr3bjweNwyZav91EmMbhw9di1mGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZXy6ds77TdAYYBx5Xr/agdS7u9W0Hhjx4Dyb8s8pYY8=;
	b=CybycNaZnN0kgLOXmOT5fbn8ViM59TRv9A3afK1bql7BMJtgu2te+eGxnR9WjnnaNifF
	 dVcehTQyBQMyMS0cabdz5dBL9bvOu3B+ds1mSXClty+8cgP7RDhwMEobgP3p+OwHMSYLB
	 VoRkFo775jhR+MyrWDVn7NaZsxYcc+7T507yXdFx14OaN3bTX+D4vP5u36K+qFpAbrk73
	 sxxhkyVHUjkzwVNNzl500aEdYp2nbOnbx8vn+K6D/jekBA1SH+frMmFaE8yuJAHLufyki
	 o9EBE01moGUa+tilr4ALQtDadGx7BMCKusRg1H1cl/NT0mif9haJPJX8BiAM+wzqo9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794740739;
	bh=ZXy6ds77TdAYYBx5Xr/agdS7u9W0Hhjx4Dyb8s8pYY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p4EVEv493E+fNismmWXVpN7qrzlTVhtzO1DYenU6SYHtsN9JPz8twUle1cRY4BmSe
	 Hi1wDt3nHl/dNMO9dHTedwB/rWKAlX5zcJAzaMqtC2F2B9cOWE+0cSgnZvS4ALOuqU
	 IbmH5EGXYjQSE5PIFBU0W2xJ6LzYh6NO64yn1jd1F1Y+dFIjTrvh9D0vD2MBAU6lVL
	 5E1GZPKHV+Mm08aERWsI7U95mmK4UQaBxIGyvSfz0ZHt+aJ2ZAEKYCikJnIjtSjebk
	 za3FpGy1n/UMr9BHHzcej4D5GHMPZBjNP9BUX+B6butxT4qfRQQagj3iktGjf51UEY
	 PE8OgWLTaWmIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F32F260698;
	Sun, 15 Nov 2026 11:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76B0C70B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6874A80FF4
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oxm60vA_Nmtp for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D5E980FF2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=KiI7gJs6; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y5YkVNlf
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D5E980FF2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:36 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7w2413140037
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZXy6ds77TdAYYBx5Xr/agdS7u9W0Hhjx4Dyb8s8pYY8=; b=KiI7gJs6sftu3tzL
 q6jyTyffS4XLwQsxSYsI2D72l31zLK7nyokbAoRsZzGX0pdzQHY0A3lWPAameFB1
 tYl6Ng59btOm3BMUjKlTLc+qW3ocTKHBNadISSgXdJyZh12/5r0iOUnsIMMuL2mG
 YrFoX755KWHPQVzVZQ3PGJeJP6Bn6oPPfAyemVHOOib3QLWMcrvHSkNaRq1iwBCh
 EiIhi0N9YNXpQ4jOEsGJenEXj6yaiRRAzEffWv+AekaEFNL9/PeDX8bpafoR6mO5
 3Crmbbz1Oat0zkAW8JYs7Y64EuNIQ8YL5yatV8UJiZzpJX3yn9cuMBgOoz3FQ/OK
 6YfGqg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdtt26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36d1353fdcdso10920065eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794740735; x=1795345535;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZXy6ds77TdAYYBx5Xr/agdS7u9W0Hhjx4Dyb8s8pYY8=;
 b=Y5YkVNlffF0r+xp2GcmlE2vvN+KhcVtQVQjDdjxUVwOsf4PUe+uVn1jgLrAUREP1EW
 tXPR0zr2E+6NbMgEMhhNg7UCEGBDfA0Ka2tWvOZ3Jh/LV8FOJoZWNVf1gVM3AX8ZFsff
 ZUziIPLouUb6mvTf2Q27DUSwkbXHa52TZ+lKCrnJRwvoJM8jzScKAac6rwla/UBfTIDJ
 Jef2DCpPkLmB7pyXK5phCJwtgPP8tyqXXJOSio8tGcgF7cGtE2KJjwzD9R6RXs+e3sDz
 OtOVgXH3C4k2KlmyQyUsy5httkwgI3TMydDY7wS1XK1M5Wk2HFb6ntiFmSfdQPJtKKKz
 126g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794740735; x=1795345535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZXy6ds77TdAYYBx5Xr/agdS7u9W0Hhjx4Dyb8s8pYY8=;
 b=oBCavmjabvJvPeO2WUA4h5+sKyCWzq8YUfwa0TYsqc25B0l4ewQ21TOKvqOveoVia0
 iQe4dQJUvdaDaCiLxVals8jitzYZSgTkB2OJYtu3BhRyFXn1sUwkiMgAVBKHy1YSfv7d
 3iyVYW0CjH1uUsf1219PhbNYFGLnMNVGT5GGo/uDUnw04y3iLnkPNqcw+UtXAZNcdBGy
 cH6bhP8HEOQ+VNOYUbQk9OcEFfLSgGgm2r0tel5XZMWHNZYRX6BhTUR/LSjTefFBZgpY
 lI5GZKOiBIeX8FG3LT0FfvCl5wJ6qCESpqJumVUQPhl4VJL+7YUPP7YDu/v6+sNixQ26
 zcOg==
X-Forwarded-Encrypted: i=1;
 AL+hErHByggXwJJTOhTMzd/izKruFYpuZfJoqDR5xrLcrjX3DFE08gvtXedhV+aYw6ueyhn0HyzKvRI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9eB+q4gG0zV13vRuYUBA/eCpRjHdv+BFsmQ4FE0PZ/oFSCJt5V
 looN0UB4nRzT0TmGLbqT2Khjl041dCPacwOxlu6Yrpi8FQf93dXCnR+82kXlP2t07YzFAHOa3KT
 n6A6Qnig9tqAtsCMhe0/wHndqImv05Z95Q3kf+ZahneRgoMajy7inIHbqEmNRRWK2MCv9B5A=
X-Gm-Gg: AYBFou35AHBcBmaP/h+yul5KuOdGEQxUBzFDwfaAqI0qcHF/GR/Blg4pNNBxee4NB8M
 s2LCRauDTOLZhid0U3IpudzaUWiq1L9nEDVhl/To0d8Ff9ndbtmqg6793FdlcjQfIm1oE7dKL4O
 EcSwH8yVDqDNsucefK8w33xBOUxqOjqEbey4vf/ckuqg6NCEjpswn1AP3xu5+UGvypTseDfQMx+
 BgCwqDtUvcWMqlszMQvJx5+mZUyZ1JFqnHq0y1cUYYzCPf0pLJbIlmTF+QS/KFBarBF1h5z29te
 +uEQySgEXAUTNeWGqptdlCHeuauhnrJxXrMs7NJw9MTDls2A8NSglNwtuThwCoEqtLe36sy9Ygt
 2n25PlbywJ4625Mvn78uG3vPqOHaTKxiQmMojZe1ZheldQyJwLvflmGcTd8oAQl+Yagd0GSNIUV
 pIHEb7YUuoSjnJuRhmCDwn+3PN8Wm6Pn0DlnmrZirksb9poscwHS75w4bRtHohscP6mjglAAMqg
 xO6
X-Received: by 2002:a05:7300:8812:b0:379:24d9:cb98 with SMTP id
 5a478bee46e88-3796048149dmr8764418eec.0.1794740734668; 
 Sun, 15 Nov 2026 03:05:34 -0800 (PST)
X-Received: by 2002:a05:7300:8812:b0:379:24d9:cb98 with SMTP id
 5a478bee46e88-3796048149dmr8764382eec.0.1794740734080; 
 Sun, 15 Nov 2026 03:05:34 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm43456454eec.21.2026.11.15.03.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:05:33 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:35:10 +0530
Subject: [PATCH v3 3/6] fastboot: Add GPT/MBR partition table flashing
 helper functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-fb_gpt-v3-3-7ddd7ef832f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740710; l=7493;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Kyoj+HePmWqG/irwGL1ts9FPT1WIr1t8ZtjHtVsBwr8=;
 b=NKh4zQ/KnIZYRdL4WBXTTL8y1ibbZW+ZJCluz8q3T0JjGoIyNUdGqsRwEvJUh/8KvqSdBirsr
 BB9JuzyR4FtDhzshMTzvrwygR8mxanJo798QT1MwU3oP3lcTDNMsPnc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6af991ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=wEes3wv5SSUDXGofCeUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX4527ovttnFzv
 YkNQGlUJlHpRob173fTDPiLBtYD2w7bP94BqYeUEQ/2tfYKtfivi+iqExF2YbvGgSZYvmuXDAho
 56+ohx+mX/xbuiAD/rXkVWaC2VqqTsE=
X-Proofpoint-ORIG-GUID: ky8BLxiEqdL-SA0valLmKD7oQR3aFiRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfXzPXs4dkm6kPz
 sPAHJvOTiiQ9U3ek+QsHdujVgkXZECfNbFmoThc3EDpQ5Y8/OkTJFvW9Hz9fnmh5SzVOhW0CgQC
 k6rhymQzu3kTdbcIvVv65G9X+fWRu5RfLsZupLbjSImzbNylaJijaW+dJIJ+ukCf/loLUmRH/4D
 I41F2706PxGtPUDDhBOGIvEqOkSXN93+Mi3/JpajcL9BOJjaYTQ7GRVz6S8Jr5bi7Za/QRYT89O
 KoMfGmdIMqEdXdS2ACOHGVuwev18MjfW5fJA5SXEQZKyblz2zlu6VQRdTxkD6YvLZj/j4hJgHRT
 OvTDx8QgoY2CiJNRK5mgOnKkbYt090VhBM+eouSQgaIvrpDlsPTPLFILvQMrFopPfx2tXUVRpAN
 7LKwpQJxYo1mLqy+9HgvkMKoYkix+6ye5HIN1IE2Q3OvCpgMCQv13GF6HA6NGBheb7GY6PWf53v
 z5bASL0Pu4Ysrgu+/ag==
X-Proofpoint-GUID: ky8BLxiEqdL-SA0valLmKD7oQR3aFiRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150044
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

Move the GPT and MBR flashing code out of fastboot_mmc_flash_write()
into fastboot_block_flash_gpt() and fastboot_block_flash_mbr() in
fb_block.c, so that the block backend can use it too. fb_block.c is
already built for both the MMC and block backends.

Both helpers take a block descriptor and share one function for
validating the image, writing it and rescanning the partitions. Only
the validate and write callbacks differ.

Convert fastboot_mmc_flash_write() to the new helpers.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Pass a block descriptor to the helpers rather than an interface name
  and device number. fb_mmc.c keeps using fastboot_mmc_get_dev(), so
  the DEV_TYPE_UNKNOWN check is no longer lost
- Share one validate/write/rescan function between GPT and MBR
- Move the helpers from fb_common.c to fb_block.c, which already
  includes <blk.h> and <part.h>, and rename them to match
- Drop the interface check from the helpers
- Drop the __maybe_unused on fastboot_mmc_get_dev(), no longer needed

Changes in v2:
- Newly created in v2
- Adds fastboot_flash_gpt_partition_table() and
  fastboot_flash_mbr_partition_table() helper functions
- Update fb_mmc.c to use these functions
---
 drivers/fastboot/fb_block.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_mmc.c   | 45 +++++--------------------------
 include/fb_block.h          | 26 ++++++++++++++++++
 3 files changed, 96 insertions(+), 39 deletions(-)

diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index fb0face0429..cf03c600772 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -315,6 +315,70 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
 		fastboot_okay(NULL, response);
 }
 
+#if CONFIG_IS_ENABLED(EFI_PARTITION) || CONFIG_IS_ENABLED(DOS_PARTITION)
+/**
+ * fb_block_flash_part_table() - Validate and write a partition table
+ *
+ * @dev_desc: Block device to write to
+ * @type: Partition table type, used in messages
+ * @validate: Checks that @buffer holds a valid partition table
+ * @write: Writes the partition table in @buffer to @dev_desc
+ * @buffer: Downloaded partition table image
+ * @response: Pointer to fastboot response buffer
+ */
+static void fb_block_flash_part_table(struct blk_desc *dev_desc,
+				      const char *type,
+				      int (*validate)(struct blk_desc *, void *),
+				      int (*write)(struct blk_desc *, void *),
+				      void *buffer, char *response)
+{
+	printf("%s: updating %s on device %d\n", __func__, type,
+	       dev_desc->devnum);
+
+	if (validate(dev_desc, buffer)) {
+		printf("%s: invalid %s - refusing to write to flash\n",
+		       __func__, type);
+		fastboot_response("FAIL", response, "invalid %s partition",
+				  type);
+		return;
+	}
+
+	if (write(dev_desc, buffer)) {
+		printf("%s: writing %s failed\n", __func__, type);
+		fastboot_response("FAIL", response, "writing %s failed", type);
+		return;
+	}
+
+	part_init(dev_desc);
+	printf("........ success\n");
+	fastboot_okay(NULL, response);
+}
+#endif
+
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+void fastboot_block_flash_gpt(struct blk_desc *dev_desc, void *buffer,
+			      char *response)
+{
+	fb_block_flash_part_table(dev_desc, "GPT", is_valid_gpt_buf,
+				  write_mbr_and_gpt_partitions, buffer,
+				  response);
+}
+#endif
+
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+static int fb_block_valid_mbr(struct blk_desc *dev_desc, void *buffer)
+{
+	return is_valid_dos_buf(buffer);
+}
+
+void fastboot_block_flash_mbr(struct blk_desc *dev_desc, void *buffer,
+			      char *response)
+{
+	fb_block_flash_part_table(dev_desc, "MBR", fb_block_valid_mbr,
+				  write_mbr_sector, buffer, response);
+}
+#endif
+
 void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 				u32 download_bytes, char *response)
 {
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index faf345fbcbb..289f1046e19 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -397,26 +397,9 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
 	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_GPT_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
-		if (!dev_desc)
-			return;
-
-		printf("%s: updating MBR, Primary and Backup GPT(s)\n",
-		       __func__);
-		if (is_valid_gpt_buf(dev_desc, download_buffer)) {
-			printf("%s: invalid GPT - refusing to write to flash\n",
-			       __func__);
-			fastboot_fail("invalid GPT partition", response);
-			return;
-		}
-		if (write_mbr_and_gpt_partitions(dev_desc, download_buffer)) {
-			printf("%s: writing GPT partitions failed\n", __func__);
-			fastboot_fail("writing GPT partitions failed",
-				      response);
-			return;
-		}
-		part_init(dev_desc);
-		printf("........ success\n");
-		fastboot_okay(NULL, response);
+		if (dev_desc)
+			fastboot_block_flash_gpt(dev_desc, download_buffer,
+						 response);
 		return;
 	}
 #endif
@@ -424,25 +407,9 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
 	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MBR_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
-		if (!dev_desc)
-			return;
-
-		printf("%s: updating MBR\n", __func__);
-		if (is_valid_dos_buf(download_buffer)) {
-			printf("%s: invalid MBR - refusing to write to flash\n",
-			       __func__);
-			fastboot_fail("invalid MBR partition", response);
-			return;
-		}
-		if (write_mbr_sector(dev_desc, download_buffer)) {
-			printf("%s: writing MBR partition failed\n", __func__);
-			fastboot_fail("writing MBR partition failed",
-				      response);
-			return;
-		}
-		part_init(dev_desc);
-		printf("........ success\n");
-		fastboot_okay(NULL, response);
+		if (dev_desc)
+			fastboot_block_flash_mbr(dev_desc, download_buffer,
+						 response);
 		return;
 	}
 #endif
diff --git a/include/fb_block.h b/include/fb_block.h
index f60cd3d9635..bee069a1dff 100644
--- a/include/fb_block.h
+++ b/include/fb_block.h
@@ -95,6 +95,32 @@ void fastboot_block_write_raw_image(struct blk_desc *dev_desc,
 void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_partition *info,
 				       const char *part_name, void *buffer, char *response);
 
+/**
+ * fastboot_block_flash_gpt() - Write a GPT to a block device
+ *
+ * Checks the downloaded image, writes the protective MBR, the primary GPT
+ * and the backup GPT, then rescans the partitions on @dev_desc.
+ *
+ * @dev_desc: Block device to write to
+ * @buffer: Downloaded GPT image
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_flash_gpt(struct blk_desc *dev_desc, void *buffer,
+			      char *response);
+
+/**
+ * fastboot_block_flash_mbr() - Write an MBR to a block device
+ *
+ * Checks the downloaded image, writes the MBR, then rescans the partitions
+ * on @dev_desc.
+ *
+ * @dev_desc: Block device to write to
+ * @buffer: Downloaded MBR image
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_block_flash_mbr(struct blk_desc *dev_desc, void *buffer,
+			      char *response);
+
 /**
  * fastboot_block_flash_write() - Write image to block device for fastboot
  *

-- 
2.34.1

