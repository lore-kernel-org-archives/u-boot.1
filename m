Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D094CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5139F6078F;
	Mon, 19 Oct 2026 10:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4y3SNFzgalkQ; Mon, 19 Oct 2026 10:51:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9237C6075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407088;
	b=ruLXA9lRStXtytMVjt96jDpNTtPnjzEsV0e1p4N4isPuBhGgAXOnU0Shfkeo7ZIRYjde
	 1qrlLj5pYQKXsoiTuvhBKkKDYwkXdGS3XJoo5QFc2oZ2EEplCK5OraJ1HlCX3aiwTGe5r
	 EmrVZgepB22Z4USdfhTF59jPw2RH9LU0zlvzH+9YLZMWd44HDzMSlEQO29fCpIBVfWohm
	 N9GnPmKrY9uqddi+pmxvTybMEAp1/OokEJkw8BLFrccAYcyvHFUbFjnU5INrN3DocULCS
	 pkq+ANYkVQlM99VDF4kf4iGKv6a//saXNkiRbNdWh0HFRPci/fqy62CJ65PnZilIFbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M1LyWC1tK1d8kZ1WZRtifjXcZP3dntXTEJrdaUxSUFY=;
	b=OoQPvFgfTfAnOgGTZqv1hFCRvjf8nCmuEIaM3x7tteAhraEpxqN/sKmf9QnYy3MuZf51
	 yVrEs3nFACpt4ydXhNqzfqUCsTNrX0QfWyHfyhqbllTBa9Y3FoMf14LX71M6UxoRk4xTU
	 n37v0xTA7jpNxRJg1BB2r+7zCAuL1b38PvV16pciSfweYQlep7di1SBlVBBckYbPsDBHD
	 TCInxiuqnjxfHyY3fmIQWULS2hC52XX/LMxu9ouP69QXjAaxfdik/XcZr+Xe6Na0zhPYB
	 VB7K47e6umZsJaIgRpLOwNfPhwQAEQSpmQaBQcjBbzInmp/jsSaVq1fdAH8r6lWHMWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407088;
	bh=M1LyWC1tK1d8kZ1WZRtifjXcZP3dntXTEJrdaUxSUFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JChDxwB3Oszp2R07O03siogxp50ZRatm+xFo4ljm/Khe2h8mXVNNY0WVzv9JE8QUS
	 DtpyMdS4JS48ppFX06yT+z+ZnJmyTthewilG1ObFeuiwWihpdMyInC5PiVHOVmULYL
	 c7jrWYKs6Tpy/dLbtu2ZanDu2QZLXrnYP3WqGaTPUkeMXsC4hwlSAtCIpqnD6MCL0r
	 dzL1+n6aweAB+IQ2KuyoaB/LDR2UR3gdVerrPbm1BuIKu3/0gOWrmsdDImZ6mNzRHf
	 auP+bJvGNo0G9K4uu6ZPvD2ZBZDY/rhsPlpRSJYqgVvTouQAeZg2tXwl5dfS44GVmL
	 DoQcCXZDLhaOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9237C6075F;
	Mon, 19 Oct 2026 10:51:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F397E1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D973C8101C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73coeF5hfKPj for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:51:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E841380F82
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407085;
 b=oH0n8K3Tw35b3xW5UYgosOpBvK1V03RdLfGLKehxHLXAZxOyZz43pb6ZJct3YzPYxtBc
 JuhNnuCqRphSlaN10RsSfgFPAQXgcbSz4rzcH9Gn1R0FbS1LebXzPZsEWwUo9IwomHxVu
 MArsp8fTac9Vqix3Q7xWGWc1lstcsIe6y3JPQwCuzTwHRUdEeys1PaHjGMyVOHr4XsM6g
 AOaWbsrka54CEqmotEN6wYEVAMftNpUcPs53PlTLxiBXsWPugZTlNLV2hNGdT7VNlHRo3
 APEHRKCDYzIb/X7PjMiP/ZAtSi/dr5QwvLVWKEdZEQhv3VN5tVuCP2E5AQGf8DzEE2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407085;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=M1LyWC1tK1d8kZ1WZRtifjXcZP3dntXTEJrdaUxSUFY=;
 b=IrZlo+7ITLLSe7HkZS0y778TOE/FUpLzu4k4YSuEeQlUReECPvZh6lU1R5N5J3cYoxmi
 8lwiRxDVIGIFaVEfPonXDr/pYgqreChhBJo0g2azV5jRYo97+IU0mp++PjI3Hq6ocKFdJ
 fPBYTWhbmDiabT5AXrOZ/ZVV9r1AW08B6IPxev2q4LhNWciW+OBV2zPM0Yr6HPOdcldLl
 FbcjLoCvxSS5Qnn3QitjX3afxorxV12OcXc6re2w0w4Pdpm737kkPLDA7kDUlQNAOUIG8
 itMX7CYZLy/4/ZAzUt1oQiK3jYyaGbpxjw/q17U2iW6mz1wMMtG1lzW/7xBgM26K1Aw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZN0NF5Mo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KbBOS6HX; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZN0NF5Mo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KbBOS6HX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E841380F82
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P3nV724578
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M1LyWC1tK1d8kZ1WZRtifjXcZP3dntXTEJrdaUxSUFY=; b=ZN0NF5Mo2jguaNr4
 2UGathZBW1eV+7s0fxlElI8BeeNBm4v+xlqRPzle8OzMUNgl4acNwuLjMl1qSg81
 THubKhU/B4LM6ypwgl+L5/1f8om4pGAyc1G6BrD3BBdxdfYUXxM1091ojj9ACgHK
 zZdB9Jja7t+X2KOyYlMOzbdaQ8cHz9Bad4u6eKDJNdiHW7r5Ngu8knN2+ELSfSUB
 Bdomo7CX2b9sRoI/ngWB95jXWXj3uNiutuUy5/LWfAEhr1aVfQ8vJoynilxS680f
 6UCfyWIZr05bfo8uNndZ0J2h/IlBr79gaSrheImdO+fk8sl0P21zAgmECvG04vSY
 vms/Bw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65gp4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso5423641eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407084; x=1793011884;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M1LyWC1tK1d8kZ1WZRtifjXcZP3dntXTEJrdaUxSUFY=;
 b=KbBOS6HXYXfSY8B7zyi3mi8KywVm3/TOHhiJznR1KmC0bPMIq9JAHbTfIY7EDsaU5k
 LmFFaepJpqDEu2PqLfjKsSeqaajzULW0/GDVxPN8RzY4kckDzD+6T1emmXFz/H/N+wj7
 1+pHIiSSB1LzOoKM7BQX/6hlvsU0u3MpqpBjNgdni8YTWhhw/TBF+E32nOyisaSTczjr
 xLASzU2vTAk0wAJCssvXjZrYYu39DIwmd00nSosE3/m6EvM1trVhlbPcRV4Iln/Oi/zK
 G0dJrT3Z2UaPfXih+D7qv+b2d1OnQxBOaV4+nHhflI/Z8aC3g7Gjdk5OpPLbH4GP4jgm
 YnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407084; x=1793011884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M1LyWC1tK1d8kZ1WZRtifjXcZP3dntXTEJrdaUxSUFY=;
 b=kp8ovgXX9BifcCZ+lS82/xgCkVogaHpWpKtanIOS1j3BdcdBCX1Q0NDl/S8dZMXlvB
 H4N9c8XP813NlQB+6Ep2j23WIdvdI7nPgFA4f4Eb7BJcjxUH7TCABIPV8l1XWRL7TsMS
 c7/vq60EneewFEVu1pjsvc8312LkAA4OGWECVqk4xHVLRZ9ojTPRJufl8PiQ7Y310W02
 C4PWvGh8hajx3Yqi8zV9q8jFaxWIAawxvhd79YSIcXd/lkQdqsV262UatZrKXmCUIwnH
 To+1mI9OgIsl8pVN9PPe+14jHMYAr5ZJaOKluwNM9comUuqwrrI794rDz66019ev26xc
 8PCw==
X-Gm-Message-State: AFq9FYIN4MFxzDxgbpolLS6vdGlTlXbJeMNy2zuYd/EbDp87xo+D1Sv4
 jKMgkQn3+0Bycx8qf7L62yms6clpaJEGGAXZQTBXGxbWkIF39/4p6XOSmipuzgbNLXmhSTCYg7J
 Y7RBFglZ+ISBUDOCqgrR6YROZiy4a0jrVLV572CpCLLUf6YzeqK/RsP7ERHrY+4nchVCpK30=
X-Gm-Gg: AYBFou2nzTfwSDCyyzC7okW02f/6vSzRL7i+2fk2J5VTkJWrKN1m/EWOdB6H0ycg+EP
 78PSSs1MM8C0kmHZ76j8cw6lGT4y+02mKPhc5ZW6FfOISX3QNWoULNvIWTTtXXlYpaoaYL0AKXc
 y4FcZ0yMg9ExRhavlfUC1PsPmmX4wEiZfG77QpnaSK5MFma3KJVjNEZoJMsYwUam6+sU66VoTDo
 cUttleeDYilziM3m70jMITC1ZMDoJD2aGC9MLWM0Jwc3Zgp3203aBoWVoR8O+BqFDu8F291NSkF
 8KEAFVfLkWO1HfIgR/s8oahATrOzmAEozyd1dygFFot55qJZkr+Vyc8Ml8pi7DSkT5CODpefiXX
 ykVL6wATBwszuDOulbotbEHONb99nGsUSEXzg7/PJkyvCHSikmYteZB0qeHq0TO9Rv3HZju/30Q
 yfO/VnBtczOmHbm6uXYFPaR3vS3Wr0
X-Received: by 2002:a05:7022:1717:b0:187:eb7f:b8f with SMTP id
 a92af1059eb24-187eb7f0e06mr6178246c88.13.1792407083579; 
 Mon, 19 Oct 2026 03:51:23 -0700 (PDT)
X-Received: by 2002:a05:7022:1717:b0:187:eb7f:b8f with SMTP id
 a92af1059eb24-187eb7f0e06mr6178159c88.13.1792407082398; 
 Mon, 19 Oct 2026 03:51:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:51:21 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:19:03 +0530
Subject: [PATCH v4 8/9] spl: add UFS boot mode defines to spl.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-8-61432d0b258c@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
In-Reply-To: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=911;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ZT6zlRjG1gSQLPDWLfy4SESHFyPhX9JWtXYTY6IOJE8=;
 b=L6jICuYXgskzSbICnsvbED+HAqYYxBxUGqZdAjvyuIU1EEyqKizgQpDANum+wEd2RfvB9pTKr
 2PfY1yVfx1CBjgkCdEmV0c2AiehAo5o/anrcvQnRFtBsu5jg/VOY09P
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXzNZ4yCFxJj0l
 zaEQWYJxIB0ZxQDSwtM4jWssZ3wdrc9y1vL7N1yAFffWLiny/VLlx9KZOuNRTiQND9gEHwf3wer
 7BJXUP/60DZAYauSZdAQNQLzWzM88T0=
X-Proofpoint-ORIG-GUID: 6HqZlWIVWdvJ1pWzgOuAc2mAt-wgEsm2
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad5f62c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=fyTQhs28pi4JXZ4CVawA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXwPA9qscppik8
 KZ72VkOEXM31Z35dV32BMz0+Z7U7WNx8zmDqr9A+xi+lvq/ST2H430AqGzeJa28QWLC1YYUJFTT
 Wp0HEJ98ccpTqmG7w97ZzXOIU6pHiDRwMH3a19vPuRipdktZbBG+YQIBH4++X4I4NEjPfdQnR09
 Q+fvEKEEarWBX2hy23hcWzPx2ZAaPdM+/Xb7RhsbEssnscwc03+iZSU1zzuuwoDIKXrMpfRT0d5
 q8JT6fPBuNuPGa46GUomp89VdNLWbAoqPej7P22+YxakAC7nv2HhEqivBnyXJJqD549o+W2zqiq
 9B6aAwBABI6hHFwkC+k8qQqOXfJ+QI6oQsYl/N7Tp7JgN1oMJcV/DLbbhh4VSQAiXybB/XrzJKt
 gRk0y7tnK1WNG5+e+WAWsqXg4irmdyM0FEHpZiGhX+zu+R988fGbKfOD4EVjZP7CEjrjA8f4ZMn
 ZFIwi+aIVvEPIYHhqxg==
X-Proofpoint-GUID: 6HqZlWIVWdvJ1pWzgOuAc2mAt-wgEsm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
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

Add UFS_MODE_RAW and UFS_MODE_FS defines to include/spl.h,
mirroring the existing MMCSD_MODE_* constants. These are used
by spl_ufs_boot_mode() to select between raw sector and
filesystem boot paths in spl_ufs_load().

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes in v4

Changes in v3:
- No changes in v3
---
 include/spl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..0b2527ee90d 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -29,6 +29,10 @@ struct legacy_img_hdr;
 #define MMCSD_MODE_FS		2
 #define MMCSD_MODE_EMMCBOOT	3
 
+/* UFS boot modes */
+#define UFS_MODE_RAW		1
+#define UFS_MODE_FS		2
+
 struct blk_desc;
 struct legacy_img_hdr;
 struct spl_boot_device;

-- 
2.34.1

