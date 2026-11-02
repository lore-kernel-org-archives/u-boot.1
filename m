Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE20606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lPHxl2ZQ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VAhdfkvY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GVji9nFx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DFB860705;
	Mon,  2 Nov 2026 05:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKu1GyG_HhNG; Mon,  2 Nov 2026 05:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C431606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598672;
	b=tHPRmcwDhrpxH9evlPOJG68a+wI0Fj1Wgb31SXDoQMkK04dDROWOm6mBSPALtXHrJH3w
	 tSjX34zZeS9RB7Z/HBagvIozrJn5wuw1lVWWbn1yKjO4lsIjE0FKrGOaNBWxgk/M/J+da
	 F2Z75yue0aelf2pD9ezK/9FmT2ytf2a6VMc5qOdvUiltd2fQrVfSXMzb1PIvQ4NrX8FM+
	 iM5PyeqKO8QFNcsgqwSRY8R3WX8FbL4vPOMVc1Cr3y4ZoabLL0iqLE0lplgBz/3rJ+vyd
	 0ZcTY5R+h4pQsW44arDJwoHz1sgpNAvdVQ/5EpFFf1VzrfqmKydfulsjXYlM5U85lgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
	b=jiTimskvejYf+SrDganybPUtMaAHYWmPO5gts9qplZLw6KFpDG9ak+inqbSLoXkpDSBP
	 UI/ef2sM44hfhxvMTDlOLyt6JkQS7VjY2VuMVWcE8+PN+uUsAUqXpxeDT9PdsuiJXe6ey
	 Z7bfkv0OKz16xv1cMCY43YSKjVly9ek/a05Y6IkPCmE9aYgzsUeo6j8xTnK/iF38kAY1O
	 vCtCYdYSPwmGI0czHriIzWwvpzkNUxjMQO1iVShZHv5cbTnFgaKGrPMUPHZHoH9FDiO0S
	 90tquF06IRdWuCqB/kCV1w6ZPQhAxgapPYmkdq08AZAc/8H41pJX6dIgH2oZktCXDag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598672;
	bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lPHxl2ZQ++t7PyQV1MHx0uJ9Z++KT/jcjh87xxfwh/8SnPeCI6s89A1qHhGcYt5Do
	 W4L3Y3uwq2MyYGw9uAocJ+pq6TQ+KecM//Ypaf7qqgIGaiCyHPWvfZu8JPn0LSUxtX
	 xdYNoJk8X7YgV21pMLitc2aLysxbbVO46XCQMUIzsgv5kHfzvC54mtN8YWREpe6IeD
	 i9mWiSCwa07R3suMj/469lew8v9wRllJtTIoFV+I0BW0y7q8CVq8R1Tkc1/dxLL+vr
	 JtxZUif4Q/WgeFKcJG475ijJ5wPDVqvthEaMZoilfmj/aTA3askdf9Oj88GZHZlHfN
	 GiaWhzk/1FRgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C431606B6;
	Mon,  2 Nov 2026 05:51:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CBAD4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29DF9406B2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q25MIWeYMkJf for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37AE84060E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598670;
 b=WM+S6QrJPpZilV9RLN8It4tuLe10YpWPY7aGaVp2kaJYWTbkURD/+E1iqgaJRrO8ishu
 r/HSL4UhayLDPzpJcRS6L9ytADpXFbDmgBPTIc35/PxHZtcOq2W//YiVOcmd6KZpJ77SG
 9BGjhaERG21NR10+5d464rMGQqQC+WKJx7KMYFC4IYFe/Q1ok+2XM0p5VrD1nT6LtMJZT
 oLaZUpD5AkLNNsPS1VjRSMWtway2u8xP9KcbdzgAo1eegQcg+Z/Nd+RqpqsfZMHBk0dkq
 6u3YOUft8o5b3r1PFFmfbvG56UaZYCUgtgkNtLM/xq8gJrZGpttwm4OMWCtT/s0vMgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598670;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=cL7i4tmSR9QhmMKiuRaQIYjUGoZvwBwBPin5Nl5PjVG/8ZioNaG+TPxpEwaOpK4sDaT5
 qkRW4mNeUJQkSv538ht+GosJg9OeMwXn1qA0uKOXY7XsptN6k778qf/JPt84b2+9oQvs3
 A4z8jqpKO0rHNVEjR2fxea8MnRX7UGJrpiwYFjzXYy12r0eiguaJd5m9y7lrmAB2IuKmS
 uL3LsWsrgfiANgvWEabU8XgitQPZQ0xZbevp0jof10YGYxhQKNhcEART0R8dYUNSqHpog
 fGThzSRDOdOFoehe3AB7GFdLhjvQePGnAJPKg9mu+3ujTG6xHGq5Kz5thPadLAiVK8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VAhdfkvY; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GVji9nFx; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VAhdfkvY; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GVji9nFx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37AE84060E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:51:10 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24CYOX1811485
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=; b=VAhdfkvYRMajKrnT
 NFp1rzbavgViZfn4bGNKsf2NA/JTIyf1jAz9Hr7rr5XyTa1/vPmQnutd/PdudLgs
 XDWlF4SlV+wl9tndp5Zzdg0x7HDn7XE9lHKNLh1JP4/6CP9IoETw/YpX8jjkhkEN
 N8kBGTY3zzlGYuABHAbIfIsNJQLnG8uJrt0fkF3JLly9OsVPUFNxxvrT0jJ778Hq
 jHofLKo9cVcATRQRxOh5w0wjo583yXu3vVys+pp9oIkB90gmu3Hk9/U27lplIqzN
 slJ/rKiXvVT7xlH3dga/d369ZE12qYIFxwKSmn2xL4N+cR0TOqsGNx/tfAUSHPLD
 pNydVA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpk9rg85s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:51:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5291722eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598669; x=1794203469;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=GVji9nFxxyLanboYPDvTo7cPBOeKMsp7gtS8oNNHO4ESSnt7kx9WwdQwuJ/sst6TQa
 d4OHl5J5Eo1T9Nww+azKSPnVOBSo0ObIpssLOdi0q/BpuJq9pgWHBx/UWRjkMu2fMX2+
 VVrQAtel+LxpL0elBXNTPiQ06obYnOHOp2QRuEUaCZh1EmGo8DF2KoB8wPSaZh4a4rCy
 M/fl+yQYG5/qVB/jyC6MewsQ2KuT8x2TnqNYqQnKpyTs3MFdTuO2CUAGJk/Le7TNEl/n
 GpCqJAQM4YKUkZ6x+/uAzk7M5FuQQrQaUJYPRUrfogMXWfpslS1Lo2hzeXoO1MPcHmiO
 iUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598669; x=1794203469;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=sQcpI5f8QaPTA+zgNPIHhYiU4JLJwfAhah17OlbTCAewZsekFI6soXz/7VxJwFE8Lp
 ZuyjpJ0aLreFFxnvCy3zSKmPv1jrPyPnBXdX+J96YQHw/TZQJINqboQwUyckx3rSwFXm
 +6Z+3DMKS7KrrZcvM1C8x2fOFwD4ZRKhBneqLGLXjEHvPtwGe5/remK/fHDknGgKrE4Q
 qLiqxT2y7pdg4DwPv1DPoJjE905xzvdF8PyyAa/Q30Ca1q4FS2tJ29EfYCTEzFL2lUUl
 TFCP/n76rAct+fxHBFaJwRYg3XJqpeIJ2mbizpU/D+g+39IfqvsG2iGTOeQ73xZyjInc
 98PA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0X+8BZowW471pqXYadLr/HMcUEzV7F5RefdnBQT8Z1c+nVVPUtVD0q3cRq93/rVLOFMnPu9Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIs+u5/gRt7eUuUN71QEpPyPtWPiim0i7+qznll14gtk8ezRutR
 3Nltzt7Ci8igS3T3wxaSi1PZq7JLqIoR/gw8mY4ibSqh1PCnwSntimfq74mczscg+uC6qndPJml
 cvsZABDEuyNudU+Ck34Fe2yUPvtUswdDFJudUSky/BOtzKGwOuczFL+uXX60Ufsl8HvBO3Ls=
X-Gm-Gg: AYBFou3/ECcFbLYdjg1zhTTu0O8EzSJv1HJjr7BBf1Q3eiEANAONch8bCgtjfRvxcOt
 m9oyUI5HZ982Q0+DPMQX6usQowypYg8LPNUXd60hyzsUAhWlBwwhQsJhFGwrL3gmISO/qFgYul+
 xmVUkmq54gVw00tr/fqKvr/iNN2surPHA53K8oVFlJl2S10rbn8OOVV62LVjHPXcd6AgghrlbVI
 xEEhe9F/XhnJFvmBavg4SQUXht+ugtKtbyBWJ6wplAirZY7jV7fTLPn7WkEwoxRFWf9xdDdP3Wz
 brXpu3lM3cd81CXYGr/InnTKquidA544GV0dg4JlSd8pbsuZxOS4og0OpQ+ru/KZW7PDVKvlc5o
 Dh7a6KOjOgXicQA5MDZbY7JN9P+pTWYiBxzcteN6uzOJTBhp8jk97zo+qyY/+F+X6hiaFjsKuTW
 S53T1YTMcP9Dwr1Vb8tGgetRY2arjzU9x19scl4sOKm6H0kVFIxZ0D0o/N9yEmUfhc+fUnTyIel
 ZMI1g==
X-Received: by 2002:a05:701b:450f:20b0:17d:7b45:f905 with SMTP id
 a92af1059eb24-1ac5f36ca91mr13398604c88.31.1793598668741; 
 Sun, 01 Nov 2026 21:51:08 -0800 (PST)
X-Received: by 2002:a05:701b:450f:20b0:17d:7b45:f905 with SMTP id
 a92af1059eb24-1ac5f36ca91mr13398536c88.31.1793598667926; 
 Sun, 01 Nov 2026 21:51:07 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:51:07 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:47 +0530
Subject: [PATCH RESEND v10 15/15] doc: board/qualcomm: Update RDP build
 instructions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-15-224d421c6201@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: O7_Utvy9yoNNB4b6_r2C_dOcaDBZNRh1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX8phlh2EV2TKX
 0Xd9sBp90oZtTvs37eLbe426Q2rPFBP7iYnkYRUhRI3zUVNW0PTn+BfNhrKX5z9quepm4V2KulN
 yUBSK77t9v4N1CPimnbcfKtSLSOx+ZsaXm2y0/PeOkh9e28OaRIjnCinyWcb/k5Xz27ciLeT0zY
 1VbqHC1WxGcheSB9neEmFqknFJft5CNHll80UMaHge4mqBTI6sIThSsAzkX76dRS8Tdt5iAEIN/
 4tJfk/w6xuButUWp7TLLyYoWObUu0Lc/+o361lcdvoTKGuVi20qsUvUC/f3p2K5dW+4OAZjt4cG
 MG88VN1gXGi6MUXG25XnGAOG3YzTS2VCiUq05mFtcJaR1OW4l7zk5MsJh6ArVUxPrtSgdx5eW03
 0igdSIk3HetjvWlbqHz/57HqHDL2YVk4BNn0GxXTOqgWqqjVuNSTeCu7E4544w3sLpTM+EXUVmN
 ZazvhxELVBDlDtO+mSg==
X-Proofpoint-GUID: O7_Utvy9yoNNB4b6_r2C_dOcaDBZNRh1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfXwVyQZk54vNdL
 DoTlRzCcjLkXZKwfnCowFaPgoS15kwwg/zXh3kVgScOFkMP/NqR8VZ5T+eNTdUdwPcg/zNXuL54
 f8gCUDxAJqdoZn7XZeDFv+0mgazpwfs=
X-Authority-Analysis: v=2.4 cv=LvwHWXdc c=1 sm=1 tr=0 ts=6ae824cd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=FmD-qdgRN1vrldnJjaMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add details about the SPL & U-Boot proper build steps, converting to
flashable images, source URLs for the needed binaries and scripts.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 doc/board/qualcomm/rdp.rst | 96 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 4e63fe624b8..27101cc2d0d 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -25,13 +25,17 @@ about image signing can be found in :doc:`signing`.
 The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
 can be used to convert the ELF images to MBN format.
 
-	IPQ9574: (MBN version 6)
+IPQ9574: (MBN version 6)
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
+.. code-block:: bash
 
-	IPQ5424: (MBN version 7)
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+IPQ5424: (MBN version 7)
+
+.. code-block:: bash
+
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
 
 Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
 on your device with::
@@ -43,6 +47,81 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
+--------------------------------------------------------------------
+
+Please refer to the following URLs for more details about the platforms.
+
+	F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
+
+	N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
+
+1. Since U-Boot SPL is enabled on these platforms, the build command generates
+   both the U-Boot SPL and U-Boot proper images. Assuming ${uboot_dir} is the
+   top of the U-Boot sources and ${out_dir} as the output directory,
+
+.. code-block:: bash
+
+    cd ${uboot_dir}
+    export CROSS_COMPILE=<aarch64 toolchain prefix>
+    make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
+    make -j8 O=${out_dir}
+
+U-Boot SPL image:	${out_dir}/spl/u-boot-spl.wrap-elf
+U-Boot image:	${out_dir}/u-boot.elf
+
+2. Convert the SPL image to multi ELF
+
+.. code-block:: bash
+
+    cd ${out_dir}/spl
+    python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
+    python `create_multielf.py` -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
+					-o u-boot-spl.melf
+
+This u-boot-spl.melf should be flashed into 0:SPL partition.
+Please see below for the location of `tmel-ipq52xx-patch.elf`
+
+3. Convert the U-Boot image to bootloader image
+
+.. code-block:: bash
+
+    cd ${out_dir}
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+
+The u-boot.mbn has to be combined with `qc_config.elf`, `QCLib.elf`, `TFA`
+and `OPTEE`. Please see below for the location for these ELFs. TFA and OPTEE
+can be built from the sources using the following commands
+
+TFA:
+
+.. code-block:: bash
+
+    make PLAT=ipq52xx QTISECLIB_PATH=path/to/`libqtisec_dbg.a` SPD=opteed
+
+OPTEE:
+
+.. code-block:: bash
+
+    make PLATFORM=qcom-ipq52xx -j16
+
+These binaries can be combined into a flashable image using `gen_its.py`.
+
+.. code-block:: bash
+
+	python gen_its.py --arch ipq5210		\
+		--qclib_path `QCLib.elf`		\
+		--qcconfig_path `qc_config.elf`		\
+		--tfa_bl31_path bl31.mbn		\
+		--uboot_path u-boot.mbn			\
+		--optee_path tee-raw.mbn		\
+		-p qcconfig qclib			\
+		-P tfa_bl31 uboot optee			\
+		-o output/hm_503_test_uboot.img		\
+		--template `template.its`
+
+This should be flashed into 0:BOOTLDR partition.
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
@@ -55,5 +134,14 @@ U-Boot should be running after a reboot (``reset``).
 	Note that the support added is very basic. Restoring the original U-Boot
 	on boards with older version of the software requires a debugger.
 
+.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
 .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
 .. _edl: https://github.com/bkerler/edl
+.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _template.its: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf

-- 
2.34.1

