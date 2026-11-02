Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F67606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dTcpjQ97;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O5wZYhUI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FgPv3S9j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7752E406C5;
	Mon,  2 Nov 2026 05:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_ehv22b86KC; Mon,  2 Nov 2026 05:50:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54D734064F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598616;
	b=hEDvi9f3pv8C4OXE+pmOhIBwe34+uY8IadAocVuyxysCNp04prYIereFsoQ8KFPC1m5X
	 7APv5z0HBbR8nc0Bypg9RTnXrRAN3iWNArDmAqIjW4X0s9nU+2lMl/XWIbVhIxvTd/Ti0
	 aKJgSws15DMs7FmtdWUzLQazEbZ0P3YC5qdmHUG2GC4qeyew8igjNgLJllYqwDsMJMFpq
	 3n1FOwirH/9nMs5glofGcHemgWptKftejk8E7yFfXkUf9a/kIVXyendSjaCPWb5GgQWA5
	 Pb16NndMtlkrz2G9BJSwULqsJBGV26GGGUjsJ871zvAFpM18KW7A3OQ00xajY4iemxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
	b=TQobN4AO0ihDOaguw/9GUTZNxtDixI72ZsXukaYJVeXCA+pncUuHj3ylnQ73MGGMFI2R
	 y2JNNOUVD1CjDqKdA9rhZtGIcGesEYHgr3QtzhmGIvgxRwkK8URH1sgIMIVPuVTZHGqRq
	 daEq2M4MNBjAdW+WzkVROHbsSO4FJPXry7JLGBYGFygW2udlLswYzXmutz9XPS9/1UF/M
	 JR/oIyonQt5FsoQiZXOOM4091tHzghZpZmm2O4FAUPtPQ5HSRbdkj7y9bbKipkwtu3Xq4
	 AxNZ3QK58sGpk4jRbHRSGHfmfjYfww0h/6nmuH/6mGXUPITYoHyHLZFWnV30KsxmaQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598616;
	bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dTcpjQ97UbXY28uWOYJTSIymfzxiEg7JXzYGP9veRqRksKABFZwRWwrYzC81Lb1Rs
	 wI25Gg8PuHGZE6xvchti0LPET6l4ftu+ktfjMaQgZsKU/4ImG4Q4hcLevaztIISWkl
	 2cEZ6Ayip0EHzwXJyjciapBvE8t0JtpdnirO2JqJ47A5hTh9p6aPX2YgSv9mndXh4D
	 4QYS6x+OT5I0bGfIabjsK6WgZKXVaJqgFqYvORjb173Z+kyvMwQGNTFKeqOp4VdWK4
	 iwS6W2du4YsXhwZeKRCLsX29OnOD7GjI3PW19yRXJEQOEnZxHHqA0Y+7mzXWQcxNRj
	 VqVEyOlC9uUpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54D734064F;
	Mon,  2 Nov 2026 05:50:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF53E435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C571B606C9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZKg8Vt2J0f8S for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8F35606D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598614;
 b=PtKUVMboJPoQYT34NhG3pyGhwm6Eu1FXHtQvB0102unpdh8FDOLWWXvcahAMjBEaEaue
 laj+g/rDp7yPN/UYP/vwjMw/lFS/JTMF5eBqnq1h+HkynhmExUaFhhiEaczNkvKWNhLP5
 ouxF4ishNToKDw2V9ibVMDCvipFwPnVaIwz9CBOxbKlm9Ycr3iDm1n2+4732h2gdNWZU3
 AbqYSi71LCrYVwZm9eRDhqZEkMiZwPLajeZ2p39R2nEm05FYgY7YvK/eyF1wmsCSWYJ/x
 nMnF0uIyyvDrLDfyS1lin/mM8nMSq4ciDF4bhzrGdy99HkayeUaxp3OO91CLnJNO9UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598614;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=a8X+HlYlLMwnrjMPwGRcaLrNh6pAh4tmbDKewOKUvhwqXtvujcGpfw4Q4EYVMacgJkCO
 1AHdFu+rCZwy+WLAw97LyOqMSv5QsMoniz0hgS+OINqL2uLC9Pv0cN641h6gKyqXykn5E
 wrQR3bXphP2h0wXgET7Y53uXKLGttx0ONod4I/AIvWXSeIXVWvZNVIvXezzkvfMH3Z/LU
 /Zh9PHuY8jOO28CN2JDBG23RqlEFHTPeIucsKajTbG4nFqIAqrkcobvWRvlmhkp7We+CL
 vdfdXEuWa4p8+IDjVx72ahPOYaEp6UDz8LPD3gciKGgPN+OLCjSlPiJ3gbPUsCRkp4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=O5wZYhUI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FgPv3S9j; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=O5wZYhUI; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FgPv3S9j
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8F35606D7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vNfg2715895
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=; b=O5wZYhUIhEd0xRLs
 uh1EYg1NdSUJYHPBr5TR4AN8OMMEKLjIBrzSVIlDVDwlPgHe0QbTMeIh231gh8zp
 QIfWSj1wEZmf5plkwamG6J+5OwJdA0WFc76Qlp29J9/c/b7Es7TUcU5KjLHb40BO
 IwrRR3AMLJquIYFXJQAB1sH6Z1St2a3fFaNYMjasGUKt8T9xpLddnUMAFIBFt4A6
 vumeLIT1jUQMynozCrq8WEHYqI+yRPe5eydcfBn2mBCHzQGy+2QjUR7nD6dfWh3w
 crKGQwlq0/wSLLYOVmu2rqotfai1qai0bk0EqeRSytJLzsesOMbKKAwGeeIGj6c9
 nqrObw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8j2wbgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:50:13 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso3740262c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598612; x=1794203412;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=FgPv3S9jvNsOISTZtA0A8N+iMFRqn71uc2LMITZKv9V0Lo9YROFl7wT7DLtlEI34Er
 OPSMOO59dsF7hkQN+UCMddEDKiBbohFhy+p/w3dSh24OZOYnZX8jWycoP7RR7fR+hq9r
 ZSM+//e9UqcvvPdPB4DQf0wdIk0we3REQs02uo0RwTWks2teTsE2xgb7MJRX3Rmk2fxd
 ZXoYpCRK0oEi+OfS3OZbeK/6paswzkQRT31dX7pNEyq5cHT7AL4NzWe+BUlkjlcAfNll
 Kq/6IZc34TuajxoIaw6giItluTiLLSBL9oEZSjRgHpR+ReXCOdbWRdHdTyI0DDWUBf0i
 lJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598612; x=1794203412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=ii88aueTBRuyCOaFv7GsnTAbB/7JHtDqHyOpQq+v7I4g+q36IsvTR0AJnzz7ZsCfoq
 XcPSiQ5sYwA24jmlnYw11slrooHn2hlJetiRAklrQCJAhEEVCRb6Nv9PKzqhqJ6C/XjV
 vgBtg5oKNJscwE1LPH/YUCLnajWcE6JEsitEyeIx4fY0Pmiw57UKwQeXI14BaceQrM9C
 UaK2zff3/xnegj72Bbs26GpKUM5g5ffFgKCo0RzRaeRuvOivTvcsAztIProN7w6/OFEh
 if20oKXAR7f/O7OR5n0RDu2rWeWqxUq4wtV9MDSulSPZzcEQe6AgLOK8cYiEB4ezQP1a
 rDHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywUTpCapQzgZeW5wsVbKmDlghSBw4ngFDLVAD7RsgzR0pDg8PdquPMHlvr86YkDVndAIvjP4E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLY9Xeuf5xCfC7OsEf2cAuUjjfgHikEg/G9O3hFnB24+azmXcpF
 2kilsAkUllAagptJZjDIBxeFK+nzbADIiYpY4hOOoKAVh+rIgkEnoowPHi6dYPH0SMg51INSF75
 lVqAeoHeRQABQL9GWQ8rXdWXyPsqzPC6SDdC8EnT9lEPNJcQyfXy0ELn4PMPwby2fIOalsGw=
X-Gm-Gg: AYBFou27CLpSrO3YULlgRHJ5Hsyhdt/n2Hmd0Vi8HW5O+jpsT3fx3RkE3bVGPTZ7cef
 AlcgcBGuWGPDthnKBw06wmogu+lBUCprOCIjuwhbdS6VkhovHwmbjoWUOAXuwGpZ8i29A4DBkdw
 Woo58eLAWpv51bXIAgUMOMf4NatqfvuSica+b1xPoG1Ze5VqOk+O/k+eiZvp01Lw8iN7CXYeBVa
 3QO/WWN4q2oOyU5fWiDxHHx5BNJL6ekWit4SC0LBH34Wm47K8LWU7J6grL4izRYVa34gBgVLHuI
 TG39XpDAFntZQcrQXl82P5kTPlnpZ+ChPvE7otBMypUD3U8iG7VtJtbOfOK+eLeAzz2Wdrh7mPX
 k4yW5gRCItIHIdReFCo91j8L6o2M/gM2qRNJdm+kPgonyZeBGd4OGLr/wba/H809/WtKuqhV+bt
 hKKR0B5nUQAcd7aoOTBsAG45MyCqYbIlw4PQm4IWp1QHtjA00AUzBOVbESGNSW9XgKdsU1itSRG
 LAHew==
X-Received: by 2002:a05:7022:4392:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1ac5de53bc8mr22811852c88.29.1793598612143; 
 Sun, 01 Nov 2026 21:50:12 -0800 (PST)
X-Received: by 2002:a05:7022:4392:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1ac5de53bc8mr22811784c88.29.1793598611515; 
 Sun, 01 Nov 2026 21:50:11 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:50:11 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:41 +0530
Subject: [PATCH RESEND v10 09/15] mach-snapdragon: Add Qclib handling support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261102-spl-v10-9-224d421c6201@oss.qualcomm.com>
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
X-Proofpoint-GUID: bXwwaGP5HZv1rZcKRfrfMEeQxnYdC5cJ
X-Proofpoint-ORIG-GUID: bXwwaGP5HZv1rZcKRfrfMEeQxnYdC5cJ
X-Authority-Analysis: v=2.4 cv=S5RMU4sP c=1 sm=1 tr=0 ts=6ae82495 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HzPM5V0Xy-isX-7IJPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX6yaVYAY8wyyk
 bz8crrtqQNEp7le4o1k/Wi1gLQCJPC9+tUTwq0qTXRmc6l9+wUbqwV44nnJ7uvmVNXM+fDrChyR
 kjuhkQTbSK4Vfw49NFBenNFZLXPp4Ro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX6bkGEcjbsZbh
 yWeCS0lFgf7IQ010Cvkw/fCNhZASwtbQ7UPjDCH8RVuA/TzmPkSmSQ5Cd+XtUkzmogz7jOvmfCH
 lPD1xzZMG1bjQdmlcILRfq0BQ1hQSupdKSQN3tLoMPFU8UAttP/GGrIF/BMWKUezZ/kFvR3cCkk
 +6O7fiJnrq6Sp55uuW2mZZ5NH7Qoo5bl27dc68ndDWz6/in2Jk2kbnesnt/RKLVI172VQFr4NMt
 Xs9dDY7rbOhTyC7MlYGpD288kED3koSWucsY1MgnOmONPbfmYxYChe1po6ODjKWmg4mDJHSawbO
 dZOPwa7YPaFDkWfw5lu3FGfjPUSaytu/tU/8Tz5ECTfFEWShXpIMTBCC71H/9oyZjDOzAlt1TIK
 FX1ygw2DdUZXQ44dpDae8LvsfKyUrfacPcPUWWde/fj3m9FaZv0OT50msFWzPvPDYh3ALZ6VCur
 Q5mocjz2o4o6RZGaPvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add functions that handle loading the FIT image nodes having the Qclib
executable and executing it. Also provides 'weak' hooks that can be
overridden by SoC specific implementations.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile             |   1 +
 arch/arm/mach-snapdragon/include/mach/qclib.h |  82 +++++++++++++
 arch/arm/mach-snapdragon/qclib.c              | 160 ++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2701f7c6fb1..fc39f7381b3 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -9,6 +9,7 @@ ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
 obj-y += fit-handler.o
 obj-y += pbl-shared-data.o
+obj-y += qclib.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
new file mode 100644
index 00000000000..b44874c514e
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCLIB_H__
+#define __QCLIB_H__
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+#define MAGIC_KEY			"QCLIB_CB"
+#define MAX_ENTRIES			0xF
+#define IF_TABLE_VERSION		0x1
+#define QCSDI				"qcsdi"
+#define QCLIB_LOG_BUFFER		"qclib_log_buffer"
+
+/* interface_table.global_attributes bits */
+#define QCLIB_GA_ENABLE_UART_LOGGING	BIT(0)
+
+/**
+ * struct interface_table_entry - Meta data for blobs in QCLIB interface
+ * @entry_name:	Name of the data blob (e.g., "dcb_settings").
+ * @address:	Address of the data blob.
+ * @size:	Size of the data blob.
+ * @attributes:	Attributes for the blob (e.g., save to storage).
+ */
+struct interface_table_entry {
+	char entry_name[24];
+	u64 address;
+	u32 size;
+	u32 attributes;
+};
+
+/**
+ * struct interface_table - QCLIB Interface table header
+ * @magic_key:		Magic key for validation ("QCLIB_CB").
+ * @version:		Interface table version.
+ * @num_entries:	Number of valid entries.
+ * @max_entries:	Maximum allowable entries.
+ * @global_attributes:	Flags for global attributes (e.g., SDI path).
+ * @reserved1:		Reserved for future use.
+ * @reserved2:		Reserved for future use.
+ * @if_table_entries:	Array of interface table entries.
+ */
+struct interface_table {
+	char magic_key[8];
+	u32 version;
+	u32 num_entries;
+	u32 max_entries;
+	u32 global_attributes;
+	u32 reserved1;
+	u32 reserved2;
+	struct interface_table_entry if_table_entries[MAX_ENTRIES];
+};
+
+/* Exported by fit-handler.c */
+int qcom_spl_get_fit_img_entry_point(void *fit, int node, u64 *entry_point);
+int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
+				     char *name,
+				     struct interface_table_entry *entry);
+
+/* QCSDI address accessors, populated post-QCLIB, consumed by fit-handler.c */
+u64 qclib_get_qcsdi_address(void);
+void qclib_set_qcsdi_address(u64 address);
+
+/* qclib_log_buffer address accessors, populated post-QCLIB */
+u64 qclib_get_log_buffer_entry(void);
+void qclib_set_log_buffer_entry(u64 address);
+
+/*
+ * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
+ * override for any of these; the defaults in qclib.c are all no-ops.
+ */
+bool qcom_spl_soc_check_dload_mode(void);
+int qcom_spl_soc_pre_qclib_routine(void);
+int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
+				int images_node);
+int qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl);
+
+int qclib_populate_interface_table(struct interface_table *if_tbl,
+				   const void *fit, int images_node);
+int qcom_spl_invoke_qclib(void);
+
+#endif /* __QCLIB_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
new file mode 100644
index 00000000000..7f25f37b5d9
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
+ * hand-off to the QCLIB firmware image, plus __weak extension points a
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ */
+
+#include <cpu_func.h>
+#include <errno.h>
+#include <fdt_support.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <mach/qclib.h>
+
+static u64 g_qcsdi_address __section(".data");
+static u64 g_log_buffer_entry __section(".data");
+
+u64 qclib_get_qcsdi_address(void)
+{
+	return g_qcsdi_address;
+}
+
+void qclib_set_qcsdi_address(u64 addr)
+{
+	g_qcsdi_address = addr;
+}
+
+u64 qclib_get_log_buffer_entry(void)
+{
+	return g_log_buffer_entry;
+}
+
+void qclib_set_log_buffer_entry(u64 address)
+{
+	g_log_buffer_entry = address;
+}
+
+bool __weak qcom_spl_soc_check_dload_mode(void)
+{
+	return false;
+}
+
+int __weak qcom_spl_soc_pre_qclib_routine(void)
+{
+	return 0;
+}
+
+int __weak qcom_spl_soc_qclib_override(struct interface_table *table,
+				       const void *fit, int images_node)
+{
+	return 0;
+}
+
+int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
+{
+	return 0;
+}
+
+int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
+					  const void *fit, int images_node)
+{
+	struct interface_table_entry *log_buffer_entry;
+
+	memset(if_tbl, 0, sizeof(struct interface_table));
+	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
+	if_tbl->version = IF_TABLE_VERSION;
+	if_tbl->num_entries = 0;
+	if_tbl->max_entries = MAX_ENTRIES;
+
+	/*
+	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
+	 * QCLIB fills in the address itself; SPL just allocates the entry.
+	 */
+	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
+	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
+	       strlen(QCLIB_LOG_BUFFER));
+	log_buffer_entry->address = 0;
+	log_buffer_entry->size = 0;
+	log_buffer_entry->attributes = 0;
+	if_tbl->num_entries++;
+
+	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
+}
+
+static int qclib_find_fit_nodes(const void *fit, int *images_node,
+				int *qclib_node)
+{
+	*images_node = fdt_subnode_offset(fit, 0, "images");
+	if (*images_node < 0) {
+		pr_err("Failed to find images node in FIT\n");
+		return -ENOENT;
+	}
+
+	*qclib_node = fdt_subnode_offset(fit, *images_node, "qclib_1");
+	if (*qclib_node < 0) {
+		pr_err("Failed to find qclib_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+int qcom_spl_invoke_qclib(void)
+{
+	int ret;
+	int images_node;
+	int qclib_node;
+	const void *fit;
+	struct interface_table if_tbl;
+	u64 entry_point;
+
+	/* Get FIT image from SPL load address */
+	fit = (const void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+
+	pr_debug("QCLIB invoke: fit=%p\n", fit);
+
+	ret = qclib_find_fit_nodes(fit, &images_node, &qclib_node);
+	if (ret)
+		return ret;
+
+	ret = qcom_spl_soc_pre_qclib_routine();
+	if (ret)
+		return ret;
+
+	ret = qclib_populate_interface_table(&if_tbl, fit, images_node);
+	if (ret)
+		return ret;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, qclib_node, &entry_point);
+	if (ret) {
+		pr_err("Failed to get qcom-lib-1 entry point (%d)\n", ret);
+		return ret;
+	}
+
+	pr_info("Jumping to qcom-lib-1 at 0x%llx\n", entry_point);
+
+	/*
+	 * QCLIB is a separately-linked firmware image, not an AAPCS64
+	 * callee - a plain C function-pointer call risks the compiler
+	 * caching a live value in a callee-saved register across the jump.
+	 * Pin the args/target to fixed registers and clobber everything the
+	 * ABI doesn't guarantee QCLIB will preserve.
+	 */
+	{
+		register void *x0 asm("x0") = &if_tbl;
+		register void *x1 asm("x1") = NULL;
+		register u64 x8 asm("x8") = entry_point;
+
+		asm volatile ("blr x8"
+			      : "+r" (x0)
+			      : "r" (x1), "r" (x8)
+			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
+				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
+				"x19", "x20", "x21", "x22", "x23", "x24", "x25",
+				"x26", "x27", "x28", "x30", "cc", "memory");
+	}
+
+	return qcom_spl_soc_post_qclib_routine(&if_tbl);
+}

-- 
2.34.1

