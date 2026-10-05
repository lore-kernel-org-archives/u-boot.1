Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60BCCA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6917560606;
	Mon,  5 Oct 2026 07:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qj9zXxe1Lr99; Mon,  5 Oct 2026 07:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 92CBE60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183886;
	b=ilTZkmTb2drZ5TgQK5nseQjfEhmL6OBbhts+lrIGOiqG+hgYnHNGNlbXcJGlskr+VW3E
	 nOwl0mIqqaE12Ar8i66ePJSmWtZyLIBjSYi/qvE6Lm/y0vD23cmb5yuO42WxoHkE/UX95
	 jubIlLTK5oXd2vsKaA+QxUcvUsT6W7nLJHdDm1LaLeLR0L1yiqJRRV/QM8+t8IjgLHLPp
	 m4k/aEvp71cS9gMUVT4DNfHMQ+PgDuxvA074lF0CrmI/dmkrjbu+5fzgZ+7JJyzRAog7Z
	 XsAjTjK7gjqPop0GqC+Ac2whS44VwJ/7F549KwG3I2M+voGRJF1ZMrP+s9+XnScJiqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
	b=UexIRQc5rifQpIgPwr3ArthEWXoHFGcaTJtH3yLJEraM3OBxpzRJaj9ru0Yn30Gp+3dt
	 p9P6lvX64lV9hieQb3SiaYOGtMCMj4259SE448g3tYq62n/GXIHSV8JRCbjqm3T/3+thd
	 C0s4wn5XYmQAXy5ouA5XZSJwirk0HNCwW0ySycxslU1SgpO6vEZMIFYd2uk5y9Vlr76Tf
	 VnDiTlXmE3Nqfg5HDr0cgWR4Vtu56D2i/EF8+rUWFuTIp9Q21M/bTwPMEFM351YtkIwEh
	 CLrD2FP12JQo8OXzWBy49KqhFlv+gu0qhS7y3fg1U3i3BpZw4hfHOXaQ0vEWsGOuBvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183886;
	bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HmXstRJ67bxnzNSpR7676X0cuMz0nuUAzk4pDlZd+BcbaUbJ+p1EHKREk35YqJyro
	 Ozi1HtlN4JIrXkRJ4ILt3hbfM5/LELKq5VB0z0sKd99RBCNnBctbo6B3ezxSwoEfH9
	 bBCvtBxU5ttYqB+6lt4E3u8jKAM9TwShIJwJnMYuHiWp2oSFGGqWZ5wy4/UCOwrtf0
	 JkjisY1O6h7C6eYRe8jaVaz1oyUgBUuUDqH3Ov1qQkQO0fmo2nGsXtzEmxvanFrMUG
	 ee5K6LGmjqLensIcqKkBs5CpK5/O3Obwkrxb+cKXc+q2e9865KWPnFeZu6UpCpMz/k
	 jdBp9JlNHmGgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92CBE60613;
	Mon,  5 Oct 2026 07:04:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E47934D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6468A4040B
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5sEGmFKcR3x for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C08C940401
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183809;
 b=qKWx3bmg251dGKx17wMsx0IP/U52nK7TRWsD4LfsRM7ehoR9T/s/ujQnMFW6uQdi2CSk
 Pqinjrd36J0Ah3EkloqMEijKXUDCLvNWrT2Utbg4w/O18vdoTfMVPuvgAhIGo4HwGNhKD
 g62O3eg7t5/iRq3Heu4YvmLhG06PIVSlWLkk1pwu4Ed2AtJytZ1Ze2CdQZy3OP1qjqqcD
 p6I8RPyydIhS5gyBKfx2LAmMwP2LiWJfVDjoclndOdMlo9SCUp/nVobhVzSQYkscMkPZX
 zcd516VFJOrY/Gyh+a3DZDz/ET9MyAM1vJKVAZ04nLr0lVUbsjaVObeyO+mGGteTdwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183809;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=DTgOHnOCPqwL4+bE1/1xo69gPKO8hAT78gxOsWSI09+FDDGDmvXACYH5N+GcohdtChTw
 lTjA39ZCN7z2WX1s+qiN9hlTjA7M3nqSAH7bP36l/VEwc72nsOFCA/Vebe/f9y53hVB6o
 eBJSXzaY/FHR0pEEg9L/uRuHidWZcQ8Pafz9mzTDwgLbt56ST9ouIaw4nrSXdzYHQzNlP
 5YTskAtWzYW2fU4fQNev/9eHrHoxM5EPu4GdP6xVZhvfy5bv0qbYHOY5HSLohfldLdnwG
 ywEHuxVy85tR/ZsCQ70RMMNBd8B5HubNljaezf03T6mTj06UTjr4Q3b4s4+iCUwf3Ow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="EAJ2I/yt"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LHBQI3tK; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EAJ2I/yt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LHBQI3tK
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C08C940401
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510JmB1465131
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=; b=EAJ2I/ytR7B1X+JF
 qqZnfC2qwB8qv3GgAC1P0jHNZJ1APD+GOHyWgLvIOUgqUNBSL1t39j3YmjPO6wd4
 vQGmg/LMndpNEl5svGazfgZgTkSI1kpUEMeBCcdfK9W2rBFiBTJPataIKYoQTr+W
 sPnQR+FMtzmXt4NtHZQfW7T2leb8GUII6DNqa0wl7jTcj8OCfI8KUcCykhFSgBRV
 +aKl9J5G3OXLUJ89aJGWbBMGi9Hn4Bt/k7lID1QImIcBQnvupBT56HXoM5QUHuVw
 1bpUr0gsollqvLC5jFV/R3ltITtjcwf7/scOca6QwS4E257ilu2AgP0xhm77/GHJ
 qJXIUA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssmseu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:03:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso827565eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183808; x=1791788608;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=LHBQI3tKW947+84oZiY72Nt1xxiNLWJSMQJQWdufloQhAYCKdJX4jsJ6WJRo91YP0Z
 CdoO1YhN+VFD3JGPSedkur6aQDScP+KYHxLs/t44NByncRTaz0AcMw6Gv8UftcIACT5w
 N2JGCSn6+Db30rCHKHkp1zNL9+LQ/oPg0Fj3lAa3OI/giMkCuqLKWVF1RD1rhkhL0R3e
 M6UkqboBNd+ezgZ06M8hgfHHzzOGd78SVs7GPaDiytMza7+R5zjuI2XW2o+Jz/R0CRUp
 w39+GbHoKgqKsV2mowao78dSTLZUyEAo+a4ubQGKqUh8Ot/EVfP72xphnbPnsKQePHqk
 q3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183808; x=1791788608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=a5+fqi4NXBq4zP1bvx0+o0tMjC2i+La2pmDNs6wW1nlHd5nmXt5H6eDb/zi/RFrdWP
 0WNy2nts57VRqbBV24SJIjj5TOGlXjp43KymhWKv3ZpzWYMa4i5VPDLoD2WgrzskgfJR
 T2mMdGXjNbhlwFIA8oEPmc2KXKNVcn3c0vXJ5KA096w9GPIU+rDCwmNQ5KnEYlFKxop6
 UGnFCiLULse5G4hcylmjXdkPXcQYInUm+tWDL2FhB0g5d9OEgqRNqjGPTOSzUCx9cPo7
 Embl6vrk5tObP8jWSzT+dR2KDCmgwsJL7GpsckU6FrtNev1BZnnFNHxEiDMWQHpBcsNO
 1tMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxmF06IK7fNKks1TcnrBsFNTP9LNF9CmW3Vw64/ncVCJieG80zsPwloFSIJT6nqPYLUoRvVGA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kzqiAwLajEG0PBq8nixcfQARsn14DFptht3F45g6HaAuhXIiyS
 ohMzv3vq0AYS99tGuwdJfGpdRTGtKe249YfIGPJwOCDj+loSh6Xv0RV+dt3QNBZi12xLvIZ54Fq
 TRwWEWpvzkvnJx5/o8w3K6IZpzNL85wyp+ZOGDMl+vG6hMJyIca/4REePGNgbn1E2vYl9//o=
X-Gm-Gg: AYBFou11PiK2O/fYhkjq62gumt2FRCSUNoVgCKW/Tua0kU0pDbj75j+9+8bad0MB7rb
 DH2G9+GE595bLDaf/+tiggrCM/j8czhhpfFhMP+oKlIGUYmkYynWeYumuHi7ZIsP5TE995tqP0B
 PLiwtsl1EU0RECs7LhE9rnGiyHTpOzF7q1pPwbKNhM04j5aQm+9/0/K+ZZGX+0i/KiNALMuJWWp
 XTs8gSXdBTHs3MssvbqLrgfYKUiD0rC/vUmXBQEHA8RHFtn8xgEfb6XtMkweH0irZSsf/hn7QfM
 zMs1WSWfufrw9UEm/fQpVAfscIwpUAqJiahxR/+3rmRcu61TtB1EVa0aepB4KMWLGOJMotfUL5U
 9hjZhbSEEIbjvS0QD/55MTg6Oof3Mflu3GTmwYnUOBeec1bVMAdn3JqyrhefPJm/A/PyFmBSM35
 eEFx3J+5SFKeY6n+PqyRdCAc4kpRkV
X-Received: by 2002:a05:701b:2518:b0:143:1bb1:3300 with SMTP id
 a92af1059eb24-14dd1487022mr17824861c88.17.1791183807833; 
 Mon, 05 Oct 2026 00:03:27 -0700 (PDT)
X-Received: by 2002:a05:701b:2518:b0:143:1bb1:3300 with SMTP id
 a92af1059eb24-14dd1487022mr17824827c88.17.1791183807316; 
 Mon, 05 Oct 2026 00:03:27 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:03:27 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:22 +0530
Subject: [PATCH RESEND v10 06/15] mach-snapdragon: Kconfig: Add rules to
 create SPL images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-6-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX7D39+dovxvCQ
 +37bUmSU3dlQvvzMsOdACcqcbhNnw3vzWgEWWS45auKecXJDr7/V8AOaWiR2c6YnulJVQbofXMh
 w8mbADNhOOuo4U3Emib+DKzrAX4+Zuw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX9Np5RoYnp9NX
 obHePoQ7FPhnGe0PItRQAgGq8u9DqfPy72q/lU0qXOySIUow0DFfanZMTNneVgAwXT+mXHCQMI4
 ooY4XJJe3mxkFgvN7ujpei5XPWHvKHtRY37rhTWpWf5kYb7cirGCNq2oSONs7I2At4h9Y8PUAgv
 x67xCW3Hnx3ryPayQIoGGXQV/sBLQeVrKEn4Tq8UI3ycYLBJjgWYXC4XYABot531HWEieMKjKNx
 GvW+ChEdUbShWwbf7TfAEdGtleioZdakUWxsvrbmDe2AnwdI3Szt418pDcOV7LO2SUTBfrHVuZd
 QK83PwIXPFa2YhHC2BtlEbNdikPlFJCE7i6/MIMz9RKIXzDgxWUAv2dktckEVovl5vqUU6rJBE5
 Cqz1ZCJvsF71rWvQ9uRlQx8NcXcDe8lkbulGlkA1TWf3RIF/vFW/N60EJZL4DHB5yYkzyghP15I
 mpg1dAQBsfc8W5cQtcg==
X-Proofpoint-GUID: l-YgdL_vcaRu25aZp2p8WXJ8zbrEGor3
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac34bc0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KPGK5uzhZNYWFyxW8pwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: l-YgdL_vcaRu25aZp2p8WXJ8zbrEGor3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

The boot rom expects the secondary boot loader in MBN format followed by
the TME executable. Add rules to board/qualcomm/config.mk to create
u-boot-spl.mbn and u-boot-spl.melf.

u-boot-spl.melf is the combined multi-elf file that has u-boot-spl.mbn
followed by the TME executable.

Additionally, this patch adds a config option to specify the path
of the TME executable to be used to create u-boot-spl.melf.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig |  7 +++++++
 board/qualcomm/config.mk         | 25 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..5718b66cde1 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -59,6 +59,13 @@ config QCOM_GENERATE_MBN
 	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
 	  supported.
 
+config QCOM_TMEL_ELF
+	string "TME Elf to concatenate with U-Boot SPL MBN image"
+	depends on SPL && QCOM_GENERATE_MBN
+	help
+	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
+	  boot rom expected multi-elf image
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..5c45f993a41 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,30 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
+
+ifeq ($(CONFIG_QCOM_GENERATE_MBN),y)
+
+quiet_cmd_mksplmbn = SPLMBN     $@
+      cmd_mksplmbn = $(CMD_MKMBN) -o spl/u-boot-spl.mbn -l $(CONFIG_SPL_TEXT_BASE) $<
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.mbn
+
+spl/u-boot-spl.mbn: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mksplmbn)
+
+ifneq ($(wildcard $(CONFIG_QCOM_TMEL_ELF)),)
+
+quiet_cmd_mksplmelf = SPLMELF     $@
+      cmd_mksplmelf = $(CMD_MKMBN) -o spl/u-boot-spl.melf spl/u-boot-spl.mbn $(CONFIG_QCOM_TMEL_ELF)
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.melf
+
+spl/u-boot-spl.melf: spl/u-boot-spl.mbn FORCE
+	$(call if_changed,mksplmelf)
+endif	# CONFIG_QCOM_TMEL_ELF
+
+endif	# CONFIG_QCOM_GENERATE_MBN

-- 
2.34.1

