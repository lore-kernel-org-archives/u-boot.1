Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C79606A886
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oc/brsfx;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fjDZ49s7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EtI065db
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF35E406C3;
	Sun, 15 Nov 2026 11:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVknT6tPCwQ0; Sun, 15 Nov 2026 11:05:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4FE34406C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794740751;
	b=S2iXwrt1nACJaFTbqodu0Js46cU+vWQEW+9ooHVq2zM8NqAaly+0STGMdc3dOSBQEsKB
	 H+FcINEJKS6y0DCBCwpQji4qfEDt/wK0zqs6jxpR/87RkAXhGTZNRGq8lhq2HR5KJsdFq
	 hbey3PaRhAhFRM41G9gJWjfYn/mDQb+Am5LqqPaaMj22Zei71GTdolq+3nRqVMEk+MJS2
	 BF/JP3P5DijUcVLJfWtIVWQt3Dt/9hrSvNq+Tu9RgabtN1tYj7w9+eFFWWDlFpSFuBjIZ
	 5MSLgsbSK3G1sy4ILPxzaiftYOLm5/WkRK7FJZKeTbjVV4hRWv3qv/8HFTPBMglRH4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Z7Zb+bNRs8VN1lwAj+40J/HyVTDSHQDsZ9jmdq6YmA=;
	b=ZYFhy9ZWRHfeYcwFye4nb017fgyZl1befoWazi1Xiva4JoY/God5v21inQ3/7m4EbFFb
	 3+YbHJEkw+8q2rCHsFAjylX3C3c7UqioVd2mW4nNI3dVqjEgvmhH3huynxgqM9PxplkWq
	 MY9q7A4mB/himgdQwm81AQ3eQ9bJU67qXBeKlmr3JuccaxM832/GoomwqeUW5Hp8oOjze
	 V88YG8SPGH/JJNtX0o5KSvO1jSH38BOWUtJ33xDYAD1b84DVjXbRC0s+aOzpHRPWkcHiD
	 rLbe8lyybDXsUThdK3MrNjZWYDSrq6pFo2K5imgryLHoy7tVnZ3TyboVF30IIvkuAFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794740751;
	bh=7Z7Zb+bNRs8VN1lwAj+40J/HyVTDSHQDsZ9jmdq6YmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oc/brsfxNMgUX0/vlnjafebR8LSwPNZeI5QlxCzO/bDzOAAvGAH1CS+tq2RkxVnG1
	 wOYvqXonf4782OYh9U9ekldHn5KPxsBAVzl3D6dxk6TQg/TMQub55dRcJwpGTkQTCp
	 svSz2ETNdAnq9bqhy7cIog2US39NoCgOXNcOP1dEKoVSYv0lWup6l9zZXHYRJ/kgon
	 yukYjfnoXrZKNcwykC2v8oPyhpSwyQxSU6ojXJ5D7NnPQQllyVRzZ9SQceFwjCnCrL
	 1wWjmy5jEqCoyrUKjRGisLxHNk6iYPQD7bn8mqTGHAPCUxy0Mfmk5Dy8M+2gGZkGqn
	 Y4jDs+kMmYt1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FE34406C4;
	Sun, 15 Nov 2026 11:05:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CF421A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41C9980FF4
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMDWgnaOIsTX for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:05:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6788880FF2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=fjDZ49s7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EtI065db
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6788880FF2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:48 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7wAR6236316
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Z7Zb+bNRs8VN1lwAj+40J/HyVTDSHQDsZ9jmdq6YmA=; b=fjDZ49s7kc7cd8kE
 lpTI8ntFCMMugt/Gl/vRz8n0PA+LF8ev+iW2Uw3S1+BlmYUn1UsVSWlcRuKpQ4wb
 aA5tC6aboKuVhzVQgdIL5aovwH/DPDg7Vkrncso3KR5eTIiU48PUgaW9Ea7n8LJz
 mX0yRCDq04Fh0DjYK4fQMEkZdjVSkcH5sFFrsTf0E5WEJJUUi4R88MrAHYiZWG6t
 D2HFd8T/ZEIkXsmdnbXLW6qD2qtjkUcS0fd1ldB8YqVqpkqd+0Faamw3yP2kvSAO
 ZJ/GsH4PC2dW7NhPuhzRiouoStFKR/iCXQClAXo2cYSYivDc4KFsUcGppYVMOZI4
 +7vPhA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj42u85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so4002606eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794740747; x=1795345547;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Z7Zb+bNRs8VN1lwAj+40J/HyVTDSHQDsZ9jmdq6YmA=;
 b=EtI065dbJfe9t0IPEBJyEo7M3VLtXjXoB1bGenR0WgCitkE7OjCqXcjIF+8fsFhGEs
 XC8mapTNZ8sKNda954MOkMnGIO2uFVEtKBaEH5KLTfYmZDoLZ/PFxJm6UHuQCzUvmlBG
 ZlvmYdrenQbzVlIJtykIX9RGedie1fYsuqGvqfh0bavIsPDzgqwU0aFL8aNW4OWlNnel
 S4GkWFp3i2eNd3bBLhVM3eBwK1K7rSuAeoG+ecRsiT5IbuxUkGd7g7ZHaSCQAedyepU5
 1M2ZXj0k+CWU0cb/8snFGfEE2eLf/RoeSZa+0xiW2UZJZNzwJayqOhm+NI/xekPVrunE
 wivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794740747; x=1795345547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Z7Zb+bNRs8VN1lwAj+40J/HyVTDSHQDsZ9jmdq6YmA=;
 b=ep8qVAe4w3CzcUQU1wDIqkrSQryDHudpawvGyY+1kgThDhKhAGDt5wa3T729kMsjfO
 +ga3AyfAEzJ1NvRXegOMV5sQ5YnibaI3ifAvmSGR1hUEB0dvrq72ggl+Rzk8a3cPW1wo
 1OG0Nl6Dt8E90SQBmH7co5NJ/lYBHQhZpfHe5l+Ux0scXiLFcR9LOnbQEh1ac8vcD3kH
 4i/kdUT9RfP/VV/kdxrIjobrloXzPAdgMSzZbQ/u9mXLcgmYVi1bc6/ScfmlTpnYTkno
 na9vxs9xiwi09/H99S73c1aBreOLSCqGdPPr/IaxyArYxn0Ztn35kwLa+VAvSsHxWxwx
 SwjA==
X-Forwarded-Encrypted: i=1;
 AL+hErHbPVz59TGPsDZvckmCvrrI0TqXOq/+153hUJ8eqbwZCSQ1MYdnTQoEVpBxgtQg7AZkUZ5s9VQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8BtUO40TswLDPR42maJpwXocTp3gkgqVBsqLH7ow/HWlN/dYxf
 wrX4SyqA04mgwdHxLL68QR+XtBFLcvhRP/u26ktOsYv586mkOJD+i2+rJrLEx4CFO8XUuAvKWhg
 CB6ardI+6ndX/o0XB178Sgu5Ajy9CRfxeQR5CERK/5ueqK+1/QZeMaXa033132MMqTmh1XmU=
X-Gm-Gg: AYBFou2mfpATr0eZHVySzrenUnHSXB1cLN2p6KQG8CtrdvumYXcMRL9wZOhI43C5F8E
 1dMER8IGZcI/jcFC8gzDdgGg0fttNRdssr5e44PuuCYv/O5i9TB04LR2josOsxwmII5c+hPg/SV
 N5MfxycYVETHwYwPSNJO0Fmpcoz7N8/85R9GeBEOel6bn890Pv0E5ZueZj4U7ZXVdR9naGbyBIY
 fId8FX0G9Im48e8fnBRlx0TSEKZLuzwI7QgZAWxGlLZByrYkNTyQLqeDXvYG4HL1DGNg9qY6KmC
 CjkvTBhEzb4dvMncvoSiMxzEtfLCr/qbB/ciO53QS9YFP9sALIGrV3944WNaRW5cxRcBnXV0/kW
 fD6vNBRqWEn/UPkKWlcEqIqXdknOdBObDKtwAzrVkcHGBPsCgW2uRm9SGlA4oD6I3XmdgnCLITL
 SHm5zRQe9kShJCQ6sksi7zS/IeREEKlGa2ZD+BTR50v9eRCdeM44CgRWxNOrIRi75hWif0CAS9S
 L4K
X-Received: by 2002:a05:693c:600f:b0:33b:c24c:d31c with SMTP id
 5a478bee46e88-37965ca872cmr8734837eec.7.1794740746453; 
 Sun, 15 Nov 2026 03:05:46 -0800 (PST)
X-Received: by 2002:a05:693c:600f:b0:33b:c24c:d31c with SMTP id
 5a478bee46e88-37965ca872cmr8734800eec.7.1794740745864; 
 Sun, 15 Nov 2026 03:05:45 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm43456454eec.21.2026.11.15.03.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:05:45 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:35:12 +0530
Subject: [PATCH v3 5/6] test: fastboot: Add test for block partition table
 targets
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-fb_gpt-v3-5-7ddd7ef832f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740710; l=3728;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=tTHiBqT2ixAIdkiMQdToSKepQk4+H0Y3nqg0tMTxAPs=;
 b=tpgSMwg6XhHryuq5k4igiYQ+Mcbl6I7+diD0XipUA7NdtAU9Y5hk0z2ofpG3B1tegCetyxCk2
 BEx0RyLwh3/AG+ino256vUBEr2LsoAQOEPxUGH9B8ZMAuOTHhtKDeLj
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX0IN8m4L5LKty
 JGdjdM0OpiKgtZ0stF/44GW3TKv88KPhlTaw4tD/FNbrSLogfbi3q8Vf9jaJHsxhV0T+i+ldHZq
 51EJEW7ooHaW8he09BEBG4IFhk24wP7kZQ1kfKEe+Pfbf7blLsl/E42HewTRuSJAKymu3BzSwvd
 PSRr9U5gPDDlPf+C8hPPCunlFQmD3lMd3XrkNsZiVRH0mjzp1BcKKFobYwbY+znmNcHE8dnA6Mx
 tplCgF+dkYfR28LWbfgovykwVDsjtvfaiVRN0iL40j+539A4sCiFN+TUfPfsRUrOYeiCdYooZ//
 NJEIx5G+aBeEVWq1EQ6K2w28dDM+765GDkOWm5ZIQJQHGZXOQtEaaDLS0w2odSy+cLGTSUofzU5
 gWx5qCHSgylLlD6Yv3qnRVdzx9Tx5awz75D2lqFxVePTg4EDbenvf8k5DhI2LsNjnIjHp6v5LMj
 E+2d3GIH/b6S6JKADEA==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af9920b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=8LGuhJddHssPv-lh_2YA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: _nCUD8MWrUHQo0tIuZirwBNd5lsgu3B2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfXw9iWy4Jxfq2S
 axG+2jQkXWlqLnF1dpL+jSZnSOhLFErXPPRMFTpzTTQjgqM3zZ4KHW9wG4ixDnJT/iXGRvwyEhG
 Iv27CM0gInTCJKsfX+/BYAFChMvMqjk=
X-Proofpoint-ORIG-GUID: _nCUD8MWrUHQo0tIuZirwBNd5lsgu3B2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test for fastboot_block_get_table_dev(), covering the default
device, an explicit "<dev>#" prefix, names that are not a partition
table target, an empty or invalid device prefix and a missing
interface name.

Sandbox uses the MMC backend, so the block backend cannot be tested
through fastboot_block_flash_write() there. The test calls the lookup
function directly with the "mmc" interface. Lookup of ordinary
partitions with "<dev>#<partname>" goes through
part_get_info_by_dev_and_name_or_num(), which is already covered by
dm_test_fastboot_mmc_part().

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- New patch
---
 test/dm/fastboot.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/test/dm/fastboot.c b/test/dm/fastboot.c
index 5b51b6bf9dd..6c008d20df6 100644
--- a/test/dm/fastboot.c
+++ b/test/dm/fastboot.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <env.h>
 #include <fastboot.h>
+#include <fb_block.h>
 #include <fb_mmc.h>
 #include <mmc.h>
 #include <part.h>
@@ -93,3 +94,63 @@ static int dm_test_fastboot_mmc_part(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fastboot_mmc_part, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_fastboot_block_table_dev(struct unit_test_state *uts)
+{
+	char response[FASTBOOT_RESPONSE_LEN] = {0};
+	struct blk_desc *desc;
+
+	/* No device prefix selects the default device */
+	ut_asserteq(1, fastboot_block_get_table_dev("mmc", 0, "gpt", "gpt",
+						    &desc, response));
+	ut_asserteq(0, desc->devnum);
+	ut_asserteq(1, fastboot_block_get_table_dev("mmc", 2, "gpt", "gpt",
+						    &desc, response));
+	ut_asserteq(2, desc->devnum);
+
+	/* An explicit device overrides the default */
+	ut_asserteq(1, fastboot_block_get_table_dev("mmc", 0, "2#gpt", "gpt",
+						    &desc, response));
+	ut_asserteq(2, desc->devnum);
+	ut_asserteq(1, fastboot_block_get_table_dev("mmc", 2, "0#mbr", "mbr",
+						    &desc, response));
+	ut_asserteq(0, desc->devnum);
+
+	/* Names which are not the table target are left to the caller */
+	ut_asserteq(0, fastboot_block_get_table_dev("mmc", 0, "boot", "gpt",
+						    &desc, response));
+	ut_asserteq(0, fastboot_block_get_table_dev("mmc", 0, "0#boot", "gpt",
+						    &desc, response));
+	ut_asserteq(0, fastboot_block_get_table_dev("mmc", 0, "gpt2", "gpt",
+						    &desc, response));
+	ut_asserteq(0, fastboot_block_get_table_dev("mmc", 0, "0#gpt2", "gpt",
+						    &desc, response));
+	ut_asserteq(0, fastboot_block_get_table_dev("mmc", 0, "mbr", "gpt",
+						    &desc, response));
+
+	/* Bad or missing device prefix */
+	ut_asserteq(-EINVAL, fastboot_block_get_table_dev("mmc", 0, "#gpt",
+							  "gpt", &desc,
+							  response));
+	ut_asserteq_str("FAILinvalid device", response);
+	ut_asserteq(-ENODEV, fastboot_block_get_table_dev("mmc", 0, "foo#gpt",
+							  "gpt", &desc,
+							  response));
+	ut_asserteq_str("FAILno such device", response);
+	ut_asserteq(-ENODEV, fastboot_block_get_table_dev("mmc", 0, "ff#gpt",
+							  "gpt", &desc,
+							  response));
+	ut_asserteq(-ENODEV, fastboot_block_get_table_dev("mmc", 0xff, "gpt",
+							  "gpt", &desc,
+							  response));
+
+	/* Missing interface name */
+	ut_asserteq(-EINVAL, fastboot_block_get_table_dev("", 0, "gpt", "gpt",
+							  &desc, response));
+	ut_asserteq_str("FAILblock interface isn't provided", response);
+	ut_asserteq(0, fastboot_block_get_table_dev("", 0, "boot", "gpt",
+						    &desc, response));
+
+	return 0;
+}
+DM_TEST(dm_test_fastboot_block_table_dev, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.34.1

