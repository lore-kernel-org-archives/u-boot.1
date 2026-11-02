Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC6606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aKsCf6ey;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aB44bbUi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VT3WVuNu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 592B6406A5;
	Mon,  2 Nov 2026 05:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FVxThITPmZW; Mon,  2 Nov 2026 05:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 816A740695
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598664;
	b=eOFaYwkt2jfbMhI6XjaVXUScUEuKM1Tz6ktRFbpjth4lV+jJ2qXKgUEJJOatsBkw/vhF
	 m6JRYLBPej5DJ+TcTaa8qinWlR/ePw3BW5fCgzq/sxBAaLZLb5pm2R6USFpJ7i8FpAWPj
	 PzlK/xBbK+sOU2engZXH6FRG1ljTnOeDOab+kXBzTEnmnMXxfoAHWIfapdDNLygVFEUPu
	 ICaPTWk4Ior4lGz31VX+cL7jm5gvrX0fIzAMkXvB61L7TWhsmLxoCCu0wNeWVgrgqw7+W
	 A4qKWII/GABH5ORpB5lSxvkNEYsfArz1LEEh4wjkqjQWVAgx31V6VbWLx+HiMiQgHUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
	b=DX5HuNu+xxPRB0Y00czOXhHdRkqGfhcvOaZh4QHUfGaaHBzC+94z0wQp1aYDGA3pjVew
	 75MEwLaiulRzsfVfdkXz6w97TpS29IuguiXb8etFpz1SO0sNWF/gJkxCWllfiixrxY976
	 NsoNcAJBOxfivvg6/ii+QalfYPUn7B1gE5wdZOA9Fkw5fpXWjF5mX7r1V5y1nCrEpITwp
	 CDwDnVw6wRdphIxkIN4fvPMHLTMSM/lGlApHE294eGOmCQbqbb55DaYZJkFFNx8UF/3Hh
	 9Rkr1TyvMol4NA+FR+/TC4RAylIXdVno101Etl/kbsOVgJ1wnbopMoAGnNLU1+mwuAg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aB44bbUi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VT3WVuNu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598664;
	bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aKsCf6eyNDHIkZ2n7aUUI3978tGt+CMd94yO6Q9M9UM/dA8fjH43ifBRnRDej6Oj9
	 AbjKWlfxVg9FNS2gH8uNLz1sNqpKBq57hKCk5spGs4B5Ajsfhln+uZ/I/NNRMrIvD1
	 /UjOVH9iZfxkuihpPcOFI3+ubjqNTlE2xLdQnyNXe4LFpveIcugIbgETuirkuUZUmB
	 E5zUEBi/Z9EVqPN0ozr0v4Bt9sVXJE01U/sLnlPBT530tjNT6/qYL3iGNo6KHmNiZB
	 ZRIL0bO3/+RaG8N7j8Q2te3i1A1GCUHkoBlGNJlyGtvIAgTW+85P2ILdGVc7tmWB17
	 pT17cfaHeAzvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 816A740695;
	Mon,  2 Nov 2026 05:51:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 818162A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67A8340698
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfdGobUerMaf for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E2F640695
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598661;
 b=o33zSI+MSvxbzV7lo0gIZCx4JNiNXZOXCn2IiIyhxHLpOj5vBxQ5agUcY7OXsMyc3s+5
 /QpGO024GnH7Bc9UbLHW//xbVTq8i8jEFwxf69ga+YzYNR80l9yPY+KcIUQUTwZU+1o9Q
 KN6W0r84QlOSAnJuIzOUBKyXRriY1HRaKarpfmo666QRkk1L6WyLqLW4gSMgMvxV33IyI
 5ik1zbPC8ladf4qyUx9mSipdOSjgtO/b7eIYiis1/ICu6HUDSdZetFyQQlSWYl4bnyFr4
 WtyNluRLVgExV81dVWdbnV9sBOYfZWDcNztlw1xHaCbjiIUwJdmyXo1/eE5QDYtA59Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598661;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=T5DtXBuPJxWIyztwusxs2MmRWTwl4QQ5Q3IY+JUq5KoS8gJM0vCIoz+u3b0WTrSywzP8
 adxa0VMHkDR+xxwSN9ieO0UQUcvpDMqkvyWripLWqCrEZ9SMcgbY5EGUWaWAQsF/yqkou
 5y4xdl1keBuJhQmP0QzTxU3Ehvnf5VDY6ZTOiw4WQUC5mjytlD3eOQo078O5Gxe9L99N2
 NlOAsqVQOjTFdDLavsA01KTfVkL+F0accknM6b5SCfRwQFEVYDeOsmejpcAsO0L/2b9XC
 eV9K9jyAyy1w7f3K63QJQ7t+8psaHNKvS9VfMDozBgHuXy+gkju+D9TlT3DRRc3Jz2g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aB44bbUi; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VT3WVuNu; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=aB44bbUi; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VT3WVuNu
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E2F640695
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:51:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vNmg2745512
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=; b=aB44bbUis3syhdY3
 R4EuhkTdZWzU8Y4D4ovTqBggOImkw0S0d3NTO4OwpVNASFsK7US92y5ihfjIQAPL
 hvaPnXn7J/WNbDjWOdLQGBDDEGonAAVO929DfgIODWKuhn9RB9BX6snbi3PJDfpE
 4GFIisqoy8oNc091BWDc03tjml91zh3fQWvSUyeX4FmfegpIJozr4qCpI77VUsqH
 JsIqVczmdkAgAzxgJIpHU8yPzEX7gSyvba8wt1il7Q1HB3YJplWgekHKF7JhzBbg
 OyS7NNzwG1CybaogBS4aiupCesCUMzXlRwuKOgHBFlbhbYL6/t5gE3LfmThBuNls
 lleY4g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8dudb0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:51:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so3820783eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598659; x=1794203459;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=VT3WVuNuZHiT+1irIZ9lGvq5D0rCiMpB9A6XmaEAUyH7OFvQWcP+/A32tXmgxXE0hj
 NPRuzNy3WbGMr7HemidNWWq7hVnor1/Oi8ZdSbMv0+1L4dEZaUeL3JFP2UCiFqrAi6AQ
 k7eReCbT1MT3FsP36sZTs3t1NUSygZP1OPcp6Cn7D4D1Gp+hpZGNdn5wk9uw8t7OutnD
 Jyq85qaXcj2HRA4R7pdPqA8/x94s91/kvbP+NRkKT8ZBjP/3nbkhwGQH4qvCxxFLTT0X
 k4SAs4yFO3sw3kZp1h95nRU1rtcphwhrQ7lPQBSDNHBJhSmoy5YsXhFtJO7Hx8VfHO6b
 e49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598659; x=1794203459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=Du2iOmX/0EZo6S9tpmt7zi8QeyTVN5pC02e6foEZbdH+9jxEb3WnSz+wOi6LCj7iWM
 uToqgdPt8vZylxnQUooUg52yGXSXJqzneljqmqZ0+l85JjxzRYJTMVgNrAQc4wNCZTtZ
 KAPtXvKU8x9kflHOjmEF1VAnwT44HsPmFefHCgY/CYcPFqETIuyAb0/H7JL9UcoWQ5k2
 EYrDunlJwmRT715qaQNQL3NHah/MNgW47VMscHBrx5/4iURrNfecvsEXdsF2nKNih9Pm
 ZyR3wirDW2fXTq9/z3ROHvYkHsyq9ZuN4fCY6HpQoYtXItSWMTdMOoNo+tI0x7WbFA/c
 4bcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7AVf9mrxSZYppWW1vlN2nj2ORisP99x6cY/JWJZbba8Wq7hB5hIxdrSCReE5irsCJK7Z2m3w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLoU3+yM2j7f5W/MXVnX2vFbCgkoY2p4W569w6i4jeLoaHvy0RI
 xdVmiadv3/CC016C5GZ4BEUOongLsI0tsucj7KfQHzr8O9/aDJiiyAty4zNUQPA1PxmHExsDtbz
 7kRcYr3BniKxMM3u+mjSE88ErNsa75oQUi/RQIa/PBhCD3ZMqeUnnO+G+pN6K67K527duL1E=
X-Gm-Gg: AYBFou3HsoJMQI0w5m6zxb+r+f93YFVJ9/DRPGeOJAbQ7lHR4ZtguA0qkgbR6bSIDZB
 bjYw6c95TsRky1RdJ830JIypQzCG+/h0qnUfwOGLYgcLQhxQvC3td7zHSUIOmNRv90g4fLnfmbK
 O8cc8mS9zSHSJPB8gefGQV5rk2v8G/77zEzLOdDJcDtRnJrX+3znKrh4HgqdWGD1Psc+ir9FNXq
 YnYXfygO0UYNBTkbyaqPMvb+dcUT7Tjs3vqeZT017T/KwWGiQsBAY/yMjB69KPFUMp4pdsa/Mhr
 BJggjwEcLDyd/ENaayG0UKPI35epJcmoHfW5487z7qsntooTgz3hSods6pSMAg8M5ESD4GcgWhS
 A7X0LkA026De8GTLRnWTHRBxQeFdOZLG0NCv8rBbLztBEVZH2ABuQsFotJk0jAACOZ5DsXwSbuy
 BkyJPu8amExLeUdfeB+TIJC4ZCjDG6IqjJW4muIbHC4SVOhMyihZXJCwhIbANa3UwLigsnw+0uH
 SLzFA==
X-Received: by 2002:a05:701b:2702:b0:144:fd7c:84fe with SMTP id
 a92af1059eb24-1ac5e8dea79mr12530068c88.35.1793598659171; 
 Sun, 01 Nov 2026 21:50:59 -0800 (PST)
X-Received: by 2002:a05:701b:2702:b0:144:fd7c:84fe with SMTP id
 a92af1059eb24-1ac5e8dea79mr12530014c88.35.1793598658523; 
 Sun, 01 Nov 2026 21:50:58 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:50:57 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:46 +0530
Subject: [PATCH RESEND v10 14/15] configs: Add qcom_ipq5210_mmc_defconfig
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-14-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae824c4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=bkeBrEV1CVOi_WhrbfQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: IIHQAH8t8d-pUVRaJ6_yjhLZxgRTnG0H
X-Proofpoint-GUID: IIHQAH8t8d-pUVRaJ6_yjhLZxgRTnG0H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX+elwaOIgkEuu
 OKHHFZS2rmmGQoIAuybiJSxc2msxb2a5nq4uwcC1AFENJvuPX7II5xd/raEijkOR2zZjQUrRyfK
 Ieiyr1kkVu5aSIUOvzDXd0HuwJ/BZ1ffKj9EuTUJ3VCwnZeambOtJ5JD1Mr45XSKv8SoqWu1rap
 mXWoihraVODdW6DzKyI5ptfmyH/kp8cftcqLbUDgwNhsUc1pasNTFzer96KvHsJOD4k/aaNKacw
 BrugD1JD+sMLKO32bYvvx70XtswAmAdLz47yJsB9Y+FbDwOADWEiNbzS4u0tCfyAFMQCfyPzzu+
 hvRAZJ0P7fWc1N7ZtAkdZ0287nQiRWBRu+VfznfWpvoJoRTH1Wmo/rqUtwNdXSDM5Fh481bgk8Q
 dcu5l5KzgTgR2EXpjKv9CFgTN8AN7Nbb7Aeo+URfogap5SK8DxLrsP4o7KtX7yJCGRVjKD6zgzE
 TRUQaGGfu5LazbMVjwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX63d3hxfA8bBv
 PYbR/ommf8xPsqYS15xe6hpbTzcyHknQtyY+CxhamX2g7NPYOKFAc8GTl9IXq1u8JERXPLAl+RU
 4zMq1MLrYINec4rf3KO6J7XjP8YY8WE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
Presently supports eMMC.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq5210_mmc_defconfig | 113 +++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..56a22ce346a
--- /dev/null
+++ b/configs/qcom_ipq5210_mmc_defconfig
@@ -0,0 +1,113 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_EVENT=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5210-rdp504"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1024
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_IPQ5210=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_QCOM_GENI_MINICORE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_IPQ5210=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SPL=y
+CONFIG_SPL_FRAMEWORK=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x08c2e000
+CONFIG_SPL_MAX_SIZE=0x3D000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SPL_STACKPROTECTOR=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x08cbe000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x08c2e000
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_EVENT=y
+CONFIG_SYS_BOARD="ipq5210"
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds"
+CONFIG_QCOM_TMEL_ELF="../tmel-ipq52xx-patch.elf"
+CONFIG_QCOM_GENERATE_MBN=y
+CONFIG_SYSRESET_PSCI=y

-- 
2.34.1

