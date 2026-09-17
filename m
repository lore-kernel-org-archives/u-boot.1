Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8D8C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0481140766;
	Thu, 17 Sep 2026 07:00:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ZiYu5y910Gy; Thu, 17 Sep 2026 07:00:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 470A540755
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789628416;
	b=ckoKAhKSKo/bnMQiFrYWFzwK4U2811JLK06HsqlLysK2Ke+PAL+nn1QKciSaPlx7cgke
	 8WKm+T0cSOvi6GB3+nabsaZXcIUh4XlxrFjB+uhRjN4shkpvo8srXtD4mLWLElGX/lPhS
	 YSPrQmg8GvzkKC1YcxiCVVTAcl8TP8TrelK373RC2Isz9fhJD8Qjbu5jHtjrIwZ1cBOuN
	 FMbKlGZzv9+reI2SjGG3f3jeITeMyRT/QpSeCpS8KiH2DoarMZQ3KGtgLGzr0hVB2cunB
	 ENTJq/Geln/vexvggnGj6pPG7bTvpfSsVK8hMqZMIopgvM2vsI6bZYZfk3mpNFe0KFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789628416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/2u023165u8TixIpz0terea5rCPJ25CYoV5Kq4Zw6nw=;
	b=UQVzTQQlcvvrIs0tnnn8nW+DjrkQn30Obd+4/33rzwjxCFBlnMPGIOiTt/cf3lrtYkoi
	 2uiwUt58RbpuOqfNYWXUx5cNvwjER87BBjHfWOZ4lxAMNiwf+/vDGC9+cJCAv/KrVAMe8
	 PYH3j7d6CJfbJFOnlNbtuQgeVEMOrgxXlYK9Z5Pu/SkFziCZeHvrtaZQPDB8G4d+DXYIj
	 k9dAdxQEcL4CFbXWkUc+digZFrSkOoWgO5k1h03ySZr++xJr6mcT5YijYOuM2AZKJkN8O
	 U2p36zwFoTYY4OcKYwQGtV3qpymbGdF0PBbrXTPJ5CaaHXwvVGp23Qe/Q0+V3q8+KbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ewooXgzq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="i4M9l/vr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789628416;
	bh=/2u023165u8TixIpz0terea5rCPJ25CYoV5Kq4Zw6nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZheLtjn2QItbppkQmjKHjHA8XyY7iEa9O0HXiCmlVMZho9xiTVKV3IsEbteQJnbiE
	 tDhXUdYXwIGd547da3aAFciqrX+ElT7loahWrjtWu75mUxyl4sWEnqLCSRk6vDnUeO
	 y0z04JbXUwkU6px97gknul/8K4kJf0vfrzMPiQ1e14gVbuPmu174fVdfNJF8AQG3DM
	 ig9b62D/dPh6aVNtUqaFJyf2PYHnHswfK23XOHhFXBra338c48XWtloOyAXWnxZR1E
	 hr2nND47/Fb1/eoCwomGWbogbeJkiGf5HpkYC2j0WWrN+q4BDNX/z4DYUnS30pcTCu
	 d7d9vsXyDzjDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 470A540755;
	Thu, 17 Sep 2026 07:00:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7494743A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 669BB40755
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OumTvPcUCGK for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 41671406C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628413;
 b=YhByko/A1HemL09yk7S7klGZRm+F6l+OgX6kN+78pNnoL9fnGyLQv9XGCcVcXKzFtDxa
 Nq4W9+gKgIp1L2lTlUhgEVE2IR5agdWGHUN4rMj5Ty5RS555FnSI6jEUsYRR2DoOuBeJB
 rmj9wNxx8zJkqvioROft8Fm4yOIj2iHhria8Nl4U5O3GyzA048y/ES4T5rIoPyWDcFPxs
 jFdPLK0vjTkbLeJnaHnlRJdr4ybwz8Uq9Zp81NDQuOwB7fscGddoBQMYERq96KS3BL1Cj
 cXk6S7/3r+B9wmGN1tjAQJUN7OgzEn+GiogRysf4K31gpoynXGo1QSOVp+cS73za6Sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628413;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/2u023165u8TixIpz0terea5rCPJ25CYoV5Kq4Zw6nw=;
 b=frx/o/8UGNtholLxW3NS+pjpg2aiZVZ9tAbWW5tSEp2dwaqXlNKzFXSE5c1dye9dSrZI
 ZsgRdtH1RTTU1F8uVpU2h8OmTxqu0b5m8krOUxzMyyMt0TIh8+pbeRjFCcfjnhZam0OzY
 t3sJiSH7BO6zJF7wBIn+uUgMcyonFgNSTAj4/6MkKFzaC9324az1dsNRl6K0+k4Fcxy3v
 C0FRLWLlvpclx0aRBlEjuSyQQMDLEm3O3sKhX9DgoAVjWGqcpD5bQEq/miZiJmSPYDZeN
 jzRBlKGlAcBsbr/ClGoUhTymcS7aQgocW7G4rECxKkYQLd8ADv2n6spa5zHFXr5maYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ewooXgzq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="i4M9l/vr"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ewooXgzq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i4M9l/vr
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41671406C4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:10 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60Vfb1211843
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /2u023165u8TixIpz0terea5rCPJ25CYoV5Kq4Zw6nw=; b=ewooXgzqYE6EztSW
 yebYxYaTzEY7Gg2mtpiMo4zzAi7qlxbZoyAB7kdts+WNBdrzykKQbkPfp+jSYoiW
 cpHKad2dYosVBz9in9JKEu3GWRvgE9q8TLKo30qJgNcUcdxXCfAo+0QfHC5iL7Tf
 9uSolNloEuuEDWDjOhWFRaIDH9hos7LDkSc15FNFA/b0L6cpUvfg7kr/s/MwEwqN
 S/ToocLn0hJodDiIsBjjRD9KSOB5YoeZJYTxE16/Iha6PHpgoLUBbcfP6sQTvChS
 jraVF8IsyAqWS1kV9GDb/cPKP/5WegfSKi3+3M+gGB9iyjOQtKPJ34Ws53Z4txpN
 /FnOfA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxayb6rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso762675a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789628409; x=1790233209;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/2u023165u8TixIpz0terea5rCPJ25CYoV5Kq4Zw6nw=;
 b=i4M9l/vr8+BApqHZAO6YwJVHo8UZv21P3UnHzirdv6QVlbt9LbJHL8jc2U51zS9Mnz
 KyZynyCu67Hn+Tw5nplQjED6lRRU+wFKUCOOLzkYqalLHrHB0XRPmZUCoxKQ7sRDae0b
 FfVBBL2sRFDw8qfbCUWiFST74YoHwg/DjKVGHMFHhbuOWxPfSWasqiJWXHdKWAZgnpAL
 5CdWMYLEqHnrmkVNSUQItIehfo+jQyY9UYe/4Ln+S8Yn9GgUlIxBxGhLOPsB80NlKYZq
 dJOH+1KsrqroduvPN68XYYSqp7l6ac4rbRSl/Q47O4LfpJ09UsaTW+SwVE7l6qsOUm9L
 tKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628409; x=1790233209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/2u023165u8TixIpz0terea5rCPJ25CYoV5Kq4Zw6nw=;
 b=H/YYl0oIC+ipaIT8GfjndTzKYOzpq8CQXdtivg6VXdSbBe/EbnZVocqpaPLqTb31tY
 jcBiDmX0jzL2XDbs+Y6gYXc1eQ7rXIoSVptDJFLxiL39jxnBdGxImACKHw+7MvVHnsYh
 GXI7Lguc5jpKmbprD9JOCApwy67QgO0A0E2Og6ojx48m0k6rF5WGgnEyLgDVrBtX3TO7
 +/5r8wXAHjCgatyalPpeqtafLInjZv1LwqoBd1+MjCXvjzweLJuP/b5Wn5NmmktKVAjg
 VE0OchgyCpQ4+Qt6OmuQZo+8SM6+6NFyRl29kC4oiRln1kG3L0mblH+zm/LIdF60dm5e
 wXCA==
X-Gm-Message-State: AFuF++ncxsctBGMt1UUIKVp4PtvAf02pAVgrhL+vwo/y6hEb0JwGT52G
 8DFvK+1HOGv/yxu3aVO1mDJ6iGgBBtn/mHPag0yua25PBq0HoPb7V15RHpYwyfL2lEQC8mctgRX
 KB/D/qGHrJsIV9PbJm/wOCql6sJvzeJR5kYVRQoJqhN8xC77IBnqZ5IuJmG3szAVBnZfjvP0=
X-Gm-Gg: AYBFou1rHFcD9Q+4dVgOZdBxZGlaH3WHFsb2ZWzlN45LnawGxIG4YV8tD1UYksvqJZE
 XhKONmoqvuadg5cGiIRerooIKXZHJ+PIti04L+cBhrrXb1TypEnha+S6+IYrUcz5+hsX+qxsMLL
 gK81hTtE3IqxGs57cWgqEZkw3TL2gOFQSO3MVzgqt6cMeTUWmS3hBfjWyM0Z/Ok1n5l/GPGXTV0
 XlgvR8V4f3q5ltk0w4bqy0kx9cmOsKvwHbLRCiHVwUbY701KIpY5nZQ3dQjjQhCkbnlXXhMftAR
 gyewRwyv1mueL2UKqH+4fYJ31SctjFL4wvJCADfRoOQTZuElNsEoTfPO/B2+9W6n0d5+F5iKBhD
 E8oBV8Heg13Ljj0iTwnzQ6gIQqnKvaQgFRKg/G835OYKgrchUwGA659AhqyX34b9FU+UsBStar5
 8bEAx0MfACzLF64MXrBF3P8gEFsXqzwZxHercMArM=
X-Received: by 2002:a17:90b:3b88:b0:39d:efa9:cd25 with SMTP id
 98e67ed59e1d1-39e1e263458mr16243585a91.2.1789628408797; 
 Thu, 17 Sep 2026 00:00:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3b88:b0:39d:efa9:cd25 with SMTP id
 98e67ed59e1d1-39e1e263458mr16243444a91.2.1789628408212; 
 Thu, 17 Sep 2026 00:00:08 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac47cfsm11974416eec.17.2026.09.17.00.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:00:07 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:29:48 +0530
Subject: [PATCH 4/4] disk: part_efi: force partition re-detection after GPT
 write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-series1-spinor-mtd-gpt-v1-4-d065abbc7454@oss.qualcomm.com>
References: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
In-Reply-To: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628386; l=1521;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=rRzyPM3vV4f6luqQQqIu74exJEnQ3sLcSdB0cB9aS2g=;
 b=ZswqfoBcBtwjCc5csRrXKdVxOVQDjEg6q7S6cXyRqnL1t08LaEwMXhgxqQjdzen8fhznSYCTv
 RHO/BJ501dfC3R9ya2CNfTuf2GVCoClTCUxG1U/p0zIYXxpKVgj3Fn/
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX0zFkD2T62b+X
 uSijMxZcsHWYiMVe+KOXb4QTXEYjBQO6PHHvb7RnXQAnN9Hdvck4cMkK2kjcLt/TyUCvDJFvvmB
 hG+NiPPijO3aJ9DgOyQcmMYQEG2UtppIpI8ecnJpbIwgnCYm8aD7MbwBpKJfh4WYxM3O8Bu5JLm
 ha5G3PHsVUoWPtfT4Ds2umrMDL2mNf4Ye8DiOZTdtuL0qQysbM2YpisrrBb26OUIHLe56N1hVep
 +XF+fYyQ113E4lWT6iwLByOgN/sCfnwRlcW7x/HOZ9IWB6qu7R1OBX1hbNAROl/l/XOLkBUH6Xy
 YF8bV9IWYhdGBteFWQBLaR1T3YW3398+elFs7o9kTCvBCWRIOQV5SK84mALioo2QgBNI/lx3IlS
 kYALDnn8/QxGQhavuspuFbaZLJxg+47jTslHpI7oGEifxoqD34NlATGAcm0SHaSMaMHmSS0R61F
 BIXh9D0Jv4UEgPA7ZLQ==
X-Proofpoint-GUID: NMSaWRZLQrRih-avTGr0HZU3i-0CW3tX
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aab8ff9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tgo4uRLMpLsbOBuB3zEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: NMSaWRZLQrRih-avTGr0HZU3i-0CW3tX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX38kjsYzpw9wz
 pa3i87fUhyZUIkvWKPBojsAlKyWOJB0ExvbOrmjiN5yNI4jnIEu6CFi8TwGy50Ua02/ZeHzvqLn
 g6ro4agN8iyimYtdPrwsyskTkDDrfnc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170093
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

write_mbr_and_gpt_partitions() calls part_init() after writing the
GPT to re-detect the partition table, but part_init() takes a fast
path when desc->part_type is already cached: it only re-validates the
existing driver's test() instead of re-scanning all partition
drivers.

On SPI-NOR/MTD block devices, part_type is cached as PART_TYPE_MTD
from the initial probe, since the MTD partition driver's test()
unconditionally matches. When fastboot subsequently writes a GPT to
SPI-NOR (e.g. via 'gpt write'), the post-write part_init() call keeps
reusing the stale MTD type instead of detecting EFI, so
'part list mtd 0' reports "Partition Type: MTD" with no partitions
until an unrelated full reprobe (e.g. 'sf probe') resets part_type
and forces a re-scan.

Reset part_type to PART_TYPE_UNKNOWN before the post-write
part_init() call only when it was cached as PART_TYPE_MTD, so other
block devices' cached partition type is left untouched.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 disk/part_efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91..e45fdc5f8ca 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -976,6 +976,8 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
 	}
 
 	/* Update the partition table entries*/
+	if (desc->part_type == PART_TYPE_MTD)
+		desc->part_type = PART_TYPE_UNKNOWN;
 	part_init(desc);
 
 	return 0;

-- 
2.34.1

