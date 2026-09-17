Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319E1C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8C8A80EC6;
	Thu, 17 Sep 2026 07:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRi5xgcxvJRM; Thu, 17 Sep 2026 07:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B37DE80EC8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631153;
	b=Y7m/YxxmYiCuX44s5815x2fnaWhlHDtCkzvrxRVx1A9GQB6xpJNuRoOCCpTp5PBbO22O
	 Deo5ci6X7MAi5+ol0Tj0LAMo3TepjTs2o59gTt8hgFiDUxwQaCQ40I282G8bNYZoO8P61
	 TwjNDlIfEADVxk1rs1gbQggKm6r84jRwo8m6QWkOENmn7PHjh3Q19/Ru+RJGVVeDRgzGX
	 AjA7YmkLWGBSOVS9wl+GqwR47zW1j1Gfk+pQmjjkjw2RptlihMCipYxQlirKXW2Q6Auts
	 XP2IvSqHl9feKv8MtfvEA16jldFwqfhknmqRiHHCyru8/T/exQORiXpB9iOAEm3wliQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631153;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
	b=DvjYnVhulp3vhqn+kRRJwjOvkiUb8zXrXXfH1LsQvGvq4wu0+xLmV4gdaQ95FGRs2sy/
	 XEGijLX3T22heAKO5AaPVKehzknwW5LgOIWhL0O/dMNhFekyO4ZhNlO7OnGql10vPqG+2
	 3TlCeq6FJItAoC8sd8/QsbIyNE5iXoxL19GWMgVYjjC39/PBicYdtbwW+thqAOU9PAu97
	 o/icvnkM9d3CbddaLGG5ry8DxDMPaGJqsunt9Xt5sg+bP6Ygp3QZLEPwI/6AsZNj0sm15
	 Pr+RLbDu3zlEFHLj2Re9xtzKj/t6bMcGLbLIXQj45K2vPKyCfw3l02j/+01GKU5tMLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631153;
	bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PQuHoQ2Ku6JYXM9gMfp2ge5MqCRyPG1qMB84K5JXbo5POlrKoLlx9q5/h4BQGylu+
	 PVvf3ggX5yHK0WineOT/575XgQ4z/7+pivYJhD6SNUUcVLKLi8e/423RXVZCB2gFC5
	 V9cNbascpycCKh3/JVPo0pLOwnjbsUnL9M5xJajslaMRys0WiAXCmKbR17zaFy3zOu
	 QHEgFZGw+SzDsTaW3Iw3A9sRqSvGOPUm+5R3wpPI2VeJOyiBskzCbO7Z2mHU2wtMMk
	 z0B2bTGCnfTKYj69seBcAr8QQACV2A9YVUIldwWxXg5yggaMlvNvKZQx1XF/p6Pw8Z
	 zol06hYLN9/2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B37DE80EC8;
	Thu, 17 Sep 2026 07:45:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CD7224D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12DF6400F6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7cc38l0KQUYj for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:45:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EBF84400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631151;
 b=j+bETRLEaSjHgl1ilqbVnsk8vjHSeTO3Z+IcgzmnXQIudRXU9TdPhKP6tUIqbRFxsKtx
 n/Yg/v78SmadxFFEeQRzl34E43tX00f1plXT8OWlze9ocx08rTDQDpvDhuS5tAvCMeAVn
 qJ4KKoQ3gEK8ChdtfIVdW5/0vDuakkGOyM/+zZVYH6zJlt2c+p9/ifCyreSgsDsKwTxF1
 VyoZaWeTgInz8porSVyJTZKAjQuCGY9LQhYdeYmOjW0t+fK+3UJo+JsJn5NadUHfLt1uY
 +copgdCFIP5KXxuK9qFI1a2dnwXIEW1/JC3SETn8bEHzxlR8NePNxjjt+Tq14kwRTyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631151;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=aWRqloLR1IuVFMQUG6zY2dyDwvu6VlrXRDtyqqackeDTqZGGpe1ZSdbapj+HpKWtl+4i
 zYneyyo2Sxw33wcDfa6gQTAz/0qjhFvDnxDbnX8mk+Ko8gHTb0sl6W6WvvlDyW8juBPUz
 8NKr7ir2/Go9UagsbAWXi8chNNGogDzDMtVDKcRAnQsnbGdFphq84jdvZtQ3ssVBSboW6
 NXvJJYHCg49Sqm1Xlfm8BMg+Fq8GqzxPJFsjAwzKR7P/Rh2wqORcWcnYfeY+YEgtpDQ05
 mMIdUplmKJijBZwKan/MmgkjoPsH/vSvONIdVQOg+iSICU7El6gL2xqU/r7FBII7w5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Ki+Gf7At; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aXPjli3V; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ki+Gf7At; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aXPjli3V
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBF84400F3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:45:50 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60G8E1721193
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=B3BAWWuwvVM+YbLBq+arqo
 UrzzSN9fGg1B2GeTos2qU=; b=Ki+Gf7AtFz8pqiTNSxErBb7h4Co5Q4RdIgTqI5
 bDY8A7MnXHiVCs+rO64yBIr01rI6l191SfwaDgPwP3NZqnZfEWYpr7I55uRkzlc3
 Gm6hRhPXN1tJOwJ989e4DtOMC+FMrNIUk+LmYt2FSUtTG1pehMz7CMvP+ESQV/96
 Ngx8MgPWvTxxVYi+4psYq1WsYXELop87zccpG/+FMmkHLs7N/uOfShmqePuFZVmC
 fHH4+ed0/f4TuuRp+wcS/A5YhJyhirXL98EwrkXMmu7xrDisvo6OEYlhFhzH5sfQ
 ZAzZrLHb8MOKiMZYrKU6MJYx8AGE+/2AmthMdvijGkIo9Qhw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr79m14mf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:45:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so468626a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631149; x=1790235949;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=aXPjli3VP5+olCvVudsNbJ95EFBx+6JHF8fRMFq6X4wrwErv7nkBR/2i9mMZh4uGDg
 JSXsTGu83O377Y4YVyU/22QS6NzPIp+DACSVJGvDsSvPmgrrKYlgGke3+gi0DQvNTmtm
 lToArjirmPNOcFBHpmCMMaO7cPVsjHaX6Pa5sBr6fflffw2FYlx/WqyUsWlLpCzBRyTz
 vGQZtKl1qtzu4O/7WAe3b1DCBQsRn/bi6rN/88aYxwIE3XnN9L5PIIm0oXbDSiT1J0Gu
 1TRivOfWW84CcZzh4+auqP+hksXyNl02yveUWyVdJKo6tuNb2kvWtJqlh5t4kotyYSGX
 9XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631149; x=1790235949;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B3BAWWuwvVM+YbLBq+arqoUrzzSN9fGg1B2GeTos2qU=;
 b=DzbtOGr9C5gnwP2mOhA+atR82BZO7rscmA6j58ezzqxjXrrw8UBfAdRfVZGcohjedC
 M0lQkuyJ9AzKR9SsvvbhZJqwa2da4oMj01pcQhuSlt8ps3iMpEen9tPZGd4S1YsHiUtv
 LF/6hHBV2LZYpd5Zz+QDxX/MLOxbvr2xtk111ov/c9rBTIxySw+EuIDpOLyNOiNzGe0P
 V34YZlZr4wub9cDEVJFY5lLk9Dd+isK7+XL8r2m29nKwJO5PSUeOk+CGisG31L8P7avq
 G+KByjIwHxY+15nUdIKl3x9rQbTbXZiLsDow+H9tFgQkphEPzfFt8TamsCxql7Mm3M5H
 kQ9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByRLeT/mLyZoJ1ccrMJG6b4B5Ql+1GMVS2BaPHHQPNz2F/fd+yC8OszFYFVkCYh7gXcP0ouVm0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lNGB7JEJU54xOA2suTo/jtDF6yzvWPaGTzyEkJBa6wvw8KXGMd
 AY677keAQYTbdMaptlQgez2yXHb0cvg+f1jV8bDPnoBk+ct443+FBBdBgDrIaCANYBk1Yp3xAjP
 oCxvYare+/0erUzG44JJAbdjgewUSVaWD/WZInlD5x18bz09bU6bHHHnLgoGMOYeD0Mvh+ds=
X-Gm-Gg: AYBFou0HSJZ7zavNP7uAFQuPimkcUAZQgyL5HE28uRtarD3zFJC+KVw5lf1aYGi4q/M
 5gejYC7CCyK+XouXmWHN53KyeNj5MdlNM8SnJWeSZoWi822/ibkudTJjIp+/mVgNHWso9xP83hZ
 YLtK2DywFVbIOlyJvSBW2qvm+bOYUL6KHTC/P2EtVlbZVuT5rTduCedofNoWLRd6rBS6CNOe0CD
 H/i0LmBc/AciDqAqgSYm10fg2cmb2c8vcGgxh3aptm76veSlrPceDmhHy5Xsf3T+yK6tainlYB0
 SVddFPmpdZSycGqFj7AOVuKsHn0wqBbQuKTMxu2XJ3s+27zJXeMHjfkNMM8mPKfDefXHLNkj62y
 Hnhu6Y1hmL3sSzNBF7ROK94kt5U/fV8bWMqJ7AVYXTE+FD/eNWl7cmD9SVOPgv2hSE0wX4jjUwv
 AmT3faNikJFLWf2YpIUeCHe/OXTGfCNA==
X-Received: by 2002:a05:6a20:d43:b0:3d1:c99f:efbf with SMTP id
 adf61e73a8af0-3dd5f5d8819mr15637931637.14.1789631148833; 
 Thu, 17 Sep 2026 00:45:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:d43:b0:3d1:c99f:efbf with SMTP id
 adf61e73a8af0-3dd5f5d8819mr15637869637.14.1789631148424; 
 Thu, 17 Sep 2026 00:45:48 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:45:47 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v10 00/15] Qualcomm IPQ5210 SoC bringup
Date: Thu, 17 Sep 2026 13:15:29 +0530
Message-Id: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmaq2oC/yWOQQ6DIBBFr2JmXQwSqeKq92hcCAyVREVBTRvj3
 Yu4meT/vLw/BwT0FgM02QEedxusm2Io6CMD1XfTB4nVsQBG2ZPWjJMwD4RzoyRVFUOpIZKzR2O
 /SfNu7+xx2aJtvUuQXUCi3DjatcmQomGc8lJLuPDehtX5X3piF4lPc6K453ZBKGGmrGsutKpo9
 XIh5MvWDZcxjwfa8zz/SRySo80AAAA=
X-Change-ID: 20260825-spl-55fcb0c72ebd
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
X-Authority-Analysis: v=2.4 cv=Qf7zLcbv c=1 sm=1 tr=0 ts=6aab9aad cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=voM4FWlXAAAA:8 a=YfCOm-DyAAAA:8
 a=7l9ilokc8PBLwnsvYBYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=IC2XNlieTeVoXbcui8wp:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-GUID: 5zC532KIZHeQdTbv3uz9I4Y4kuKKdCYS
X-Proofpoint-ORIG-GUID: 5zC532KIZHeQdTbv3uz9I4Y4kuKKdCYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX0tqCMYZkUGK2
 J+KZ/8aAgti0CFu1pZrFXVUw5V3oTIJE0ErlaFhPJxZfwwHEeHwubvHCI2ENq20rpYZWdHViLRJ
 Kk8j7iIgq3X9uBweaQlRVp6QG1GwEyBHSDWMee5Z3PenCwTvGbDi07Gyu1pGvWUhZpBwrY+i+aH
 Kp708bMtlCYNQWbutlgavbl+ww7Yqo1aPfNE0nLOWZcP60bcc3MB4R7N3DqgCzKNgJiaFISfJ5w
 NcGTmbJUh034GrH3Dd/xJ1sxLNhaCgwTHzf2AKzKRC16uQ1p8l3upnVgiGyjfXZjB442qw4X+Od
 54G1jJMSn2BgVVBnI7B6Dw7WU+nAhbvPdaqvjgpuG9BjsT44dZeQ6q/U7Jh4MYysJdLvteV69UC
 aUVQNGI7usZod3aPPRl8MSU7Zh9fFYmyC96Nk0j45In8BliaddpqWn+WI1IzBh4fiWCOtOR7EjP
 N34LjpDemjA/i/0EkCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX6jSQuCSkBgzf
 BELdnW+lxVIGCG0UXEkwL6RmX+iIJFVlwLOTBBamK5VuokNqILrcmiw0A42QNpNwarWV8xLDDcm
 fkrYOJZ7m8wwYcAX59vCiOftFDt9Ezs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170104
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

Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.

The relevant DT files are available in linux-next [1] & [2]

Working features, as tested on RDP504:
	* Serial console
	* UART
	* MMC
	* Boot sequence transitions from Boot ROM to U-Boot SPL, proprietary
	  binaries (a.k.a QCLib) load and execute as appropriate and eventual
	  jump to U-Boot.
	* The QCLib handles
		- DDR initialization
		- Clock setup

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq5210-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq5210-gcc.h
2 - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Changes in v10:
- Update board/qualcomm/config.mk to work with v3 of mkmbn series
  (https://lore.kernel.org/u-boot/20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com/)
- Fix mailing list e-mail id problem
- Since v9 was sent to old denx mailing list, lore URL is not available.
  Please use the patchwork link below. Apologies for the inconvenience.
- Link to v9: https://patchwork.ozlabs.org/project/uboot/list/?series=523494

v9:	- RESENd because sent to old denx mailing list
	- Address review feedback
	- Move qclib handling to separate file with some functionality as
	  'weak' functions to allow SoC implementations to override it
	- Link to v8: https://lore.kernel.org/u-boot/20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com/

v8:	- Rebased on https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
	- Address Casey's review comments on v6
	- Spin off GENI Minicore support and mkmbn support as separate patches
		[PATCH] misc: qcom_geni: Add minicore support - [a]
		[PATCH 0/3] tools: qcom: mkmbn: Updates to support ipq5210 - [b]
	- Re-organize the functions from spl.c into board_spl.c and fit-handler.c
	  and remove spl.c
	- Retained R-b tags since the code just moved
	- Removed references to MBN and multi-elf creation steps in rdp.rst since
	  mkmbn.py takes care of it
	- Add details about the interface table in doc/board/qualcomm/spl-qclib.rst
	- May need to update config.mk based on the final shape of mkmbn patches [b]

	a - https://patchwork.ozlabs.org/project/uboot/list/?series=514770
	b - https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

v7:	- Fix inadvertant typo in doc/board/qualcomm/rdp.rst
	- Pick multiple R-b tags
	- No code changes

v6:	- Move binman related changes to separate series, so that the
	  SPL changes can move forward.
	- Restore v3 build steps for now
	- https://lore.kernel.org/u-boot/20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com/

v5:	- Reorganize SPL related code into common and SoC specific functions
	  to allow SoCs to customize according to their boot flow
	- Fix documentation related build errors
	- Please see the patches for specific changes
	- https://lore.kernel.org/u-boot/20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com/

v4:	- Add binman based image creation support instead of special scripts
	- Identify boot media based on PBL shared info instead of CONFIG_xxx
	- Address v3 feedback (see individual patch for details)
	- https://lore.kernel.org/u-boot/20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com/

v3:	- Move stack range
	- Split spl.c patch
	- Move documentation towards the end of the series
	- Pick couple of R-b
	- https://lore.kernel.org/u-boot/20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com/

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
	- https://lore.kernel.org/u-boot/20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com/

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

---
Varadarajan Narayanan (15):
      misc: qcom_geni: Add minicore support
      mach-snapdragon: Kconfig: Auto select options based on configs
      mach-snapdragon: Add PBL shared data defines
      mach-snapdragon: spl: Update boot device information in SMEM
      mach-snapdragon: spl: Add support for MMC booting in SPL
      mach-snapdragon: Kconfig: Add rules to create SPL images
      mach-snapdragon: spl: Load next stage FIT image
      mach-snapdragon: spl: Add DDR initialization support
      mach-snapdragon: Add Qclib handling support
      dts: ipq5210-rdp504-u-boot: add override dtsi
      clk/qcom: add clock driver for ipq5210
      pinctrl: qcom: Add ipq5210 pinctrl driver
      mach-snapdragon: spl: ipq5210: Add SPL support
      configs: Add qcom_ipq5210_mmc_defconfig
      doc: board/qualcomm: Update RDP build instructions

 arch/arm/Kconfig                                |  12 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi         |  12 +
 arch/arm/mach-snapdragon/Kconfig                |   7 +
 arch/arm/mach-snapdragon/Makefile               |   3 +
 arch/arm/mach-snapdragon/board_spl.c            | 255 ++++++++++++++++-
 arch/arm/mach-snapdragon/fit-handler.c          | 131 +++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h   |  82 ++++++
 arch/arm/mach-snapdragon/include/mach/spl.h     |  13 +
 arch/arm/mach-snapdragon/pbl-shared-data.c      | 125 +++++++++
 arch/arm/mach-snapdragon/qclib.c                | 160 +++++++++++
 board/qualcomm/config.mk                        |  25 +-
 board/qualcomm/ipq5210/Makefile                 |   3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds |  18 ++
 board/qualcomm/ipq5210/spl-ipq5210.c            |  99 +++++++
 configs/qcom_ipq5210_mmc_defconfig              | 113 ++++++++
 doc/board/qualcomm/rdp.rst                      |  96 ++++++-
 drivers/clk/qcom/Kconfig                        |   8 +
 drivers/clk/qcom/Makefile                       |   1 +
 drivers/clk/qcom/clock-ipq5210.c                |  93 +++++++
 drivers/misc/Kconfig                            |   6 +
 drivers/misc/Makefile                           |   1 +
 drivers/misc/qcom_geni-minicore.c               | 103 +++++++
 drivers/misc/qcom_geni.c                        |  85 +++++-
 drivers/pinctrl/qcom/Kconfig                    |   8 +
 drivers/pinctrl/qcom/Makefile                   |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c          | 349 ++++++++++++++++++++++++
 include/configs/ipq5210.h                       |  11 +
 include/soc/qcom/geni-se.h                      |   5 +
 include/soc/qcom/minicore.h                     |  25 ++
 include/soc/qcom/qup-fw-load.h                  |   1 +
 30 files changed, 1824 insertions(+), 27 deletions(-)
---
base-commit: e0ef25054db31fee49d031ac337099b12c67e5b8
change-id: 20260825-spl-55fcb0c72ebd

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

