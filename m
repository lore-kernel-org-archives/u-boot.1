Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A48606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x0ifaSAd;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=krlResPa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLjnO7kp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4FF7405C6;
	Mon,  2 Nov 2026 05:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XuTgWdrXQCh; Mon,  2 Nov 2026 05:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B481B405FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598654;
	b=rbDAMUB7N8IX2ZGVM0zFL0wGQXFW9JYfS8/tZe9OnGkYpRwOh3xZjvvtVJEjjX5A3N6Q
	 KdxFAGcp9NDjR1+pcRDO9wdzZTqCRMSA9YHAwPNHJcBgIRoQPGD67cSzZZn2d5eMJVJYJ
	 GtiFRdsy6i/TCpwP1lufUEUUtuluFYgwibZYxF/7NXJzr4BhJUf1YNmy6oO+3iYvjPytL
	 LoCJJyXA/InYjQ6Rtmlnk97W8WVnLoj4iQ+k98YvBDI95NT0wYTIZL1jT66sEeqMM1E1P
	 QRFV02Q9wGwZrF1SM3oM8dLscAS6c2i1IYpRZK5yG962LX2KEv6MicOnND1ZGcX69Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
	b=DVPqMHUgtLwtJ1YOF9cThgmYAhr5MkI4B+fkhgUMMBTZe4FBZNJM8IjUL/9uYa9kwJK5
	 kAaCjNCvEB+26TwzuyFB4x3SS3al6NOrgBeZJ3r+plyFQHW+/QcySpqwOsLb1s8wQ10v1
	 d9MtjmB+mvGkEbBywzh1p6by7rPe5ddwjLqMBGlL8SpQdEG3FEG8oA11itd5fMVyD255V
	 em0Cj9LnGq7uKLd2GufOXxV9av/Lm5YPJgzgz4vZlAoGMi+344LmqDcijIEgiXCkNGtj0
	 KpiFNHCEahgeUCuWJsWgIsV9avY81A1tVqkRisgoWrO/6YrO4GCUSDGsKSq3VjeLryw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598654;
	bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0ifaSAd28zfN3liPZrjnUWA5wFtjiZ0f+oVT/SgzjCE4QsD/ZbjcacdgH7uBj1md
	 6cdRl3jotXqtv6r4kSloczxwab73SNSNAjJrfS2qEA1ZzZjqefvMyM4xvYUT52MLPM
	 i99LdOdYajp6CEQgpPVgdqPaO54DyRL6bHfaE/03HnA1hP6qBSjxx1tV/9Ak2B9094
	 NuizcBm/nFJNFzhtk9E9SnNmiKL5YPqAHoiRJIA5QxOAQQC0o1q+gGbD6IBcEnI/5T
	 Z+urt9bTQRf/AS7ju0s/2ZF1VE38ypy1gUKvXGipFYr26OMq2nkCdy+YQV61xULKsP
	 zEV17UaiUp2kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B481B405FF;
	Mon,  2 Nov 2026 05:50:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ADB82A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 709AC80E0B
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tLC3mRtC1VBM for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 90C6980E0A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598652;
 b=AHDXQPpV2mdudBG32C8OintIu0JRc/HxnBejGXd4KDjVjS+Bx6HfCqSO282siXG6UA5m
 cO48dc+8F0Az9VnA2GQDK+7IygrGE1r7dBKzy1EuHD7Nf3f7Y/1R9ITp6hDs4EzlmOcke
 FlgOtfGXSB/511vCzQZtosyYLwAeVnAEGBXS1MJOO0UFen1CtSczu9UIEzGEbiFKofV0m
 8JOTVqIxAOTm4d8xLFQwdwte68UqXcj6K5LtRiGVWg7YLq2h+QO3QALe4+wYNUqy6bBO8
 KfmQDFejIz1pRhDvWlrDRGF1Rr0QS1I5Xinsb//dK3jUkt5tC/OSqYKCh0DlzVk9g8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598652;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=kK5qJP0uwPXxdgSKic+GON7WboaqsZOdjW0ILihPq/Hmw349kSeyMnUr6o0Q2UsCi8xB
 O/B1A/t3CIKgOUWdOJR42/cjD7X3u5/rLs+OIncJNkZO7hocdoPGvUV6X7a5fIxHRYj/N
 ofOWJfyyCmS0zN07OlhqqQw8MEetivrsOqpJWehnZ03KWRhejA/j75H5lxfLqA//WfK7Q
 vgaHnk93HfbYFeylGuU6QZJPGg6j4TKRic1gXE6id4AXb79gszLiwxeMW04i02mn+J7tY
 MgUGQeJO3d+f0q+mfzvMcz5So6BLiDi8TM3VNzhrwsmQ22aUVIl6B59A+fD6OTtj6xA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=krlResPa; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XLjnO7kp; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=krlResPa; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XLjnO7kp
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90C6980E0A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vIxn3324658
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=; b=krlResPaUS8esJ3/
 L5EzgOmu8iG3AMHSljkJ1h7OGVzm7yS2OBHAK/eINE963+acgHL2ik/l34/nD3Oh
 eZYgPM2g0PjpjfnCWhJ4ZK/scjA3RiKJfq2bNOpB+M8zN1KEElF0DSMhqsszKAOt
 nK1SZ5Igcgy7ADEqbFSTzm15i5h+FY08Yde5JWAoxjfnWUv0VL45I+7GKsSSzl+V
 S6vzqUn5aQp1YDREOnUXFL6ac1bUmOZdDO/wrqhn24uunvxCqVegrGNyLnWblFHf
 K0cFu2u034xbLdz5Te9P/eH8BjewTMmDw6Pap3KOLJxmmY2d9IA7tHMRpQxqlzdo
 rdNIRQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6nfsn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:50:50 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so5319524c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598650; x=1794203450;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=XLjnO7kp59XLk9ARdFfHMFC88Y0fozDLz9LwlJ34BcNdu7HbhFcywd8c/0fVzGEOET
 w4WHNOu9sznEc3EDKFw0+dbm8cFSWwUOvbqp6qY2quReOZzrohEYtTHQnU0NUFpLoMc5
 /kvZyK72K1MXlxtkF2xfzPJZjjASsGluFJvWZ1BrvQSnXK5qIGFkJtLYccFhxlJOq9R6
 HURoTm/e+Fxx2c3n7lgptFFtqfLZ2qBucTDsQ6bdxXrjfT/kcrN7BBUhXA/8Whw7EDsU
 JBiRFHoh2P8lKM9PBWCAk0q5Jr4nFQBmXh5o4J3tLVV09L5H7/UioKwmVMmKcq9+us9k
 HCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598650; x=1794203450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=U40L2GcJf52UWMuJ6JITeXe3XsniPLmX+3nWFSfkP6/GN4SPKvLDJdA/FLq1BRxikw
 EujiAicG8dMaNcX7EdLgAdtth3vilsJwGSuczO9blSeEfztt7EmGR4AtiTpEnkSlxYQl
 xJD1xJ6ZPufKmEYaYDfEIMMPBbROclFEBbInRIy8jBQoiII81/zUdOs82HRSgnBTs+PO
 P2gMAA4oEIDGXpjiKyCwBDoz/gwbEalhisbMYExUzglncTmKwrEX6lFj9CzDaK/QYlts
 sqGZGlgYZq0CYk6R9d/Fydx7uyNkUHoj5pe4kPkJLR+6cd8MaHa2w8gKNYyLCRoVX/Cr
 G4TA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1AskiVmmw+FFUfgpIoaNfIXvaFFVhZuRvYNEadMVu4uOXHcaCtdYExpt2cMRnp6BkXDIshy4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIy8ojt6+Lj9+y3qZMUrKdsP4yyZsFGkWkQu4wsfDtwJlxF+F2M
 KNpnx5RRXkqxilc4zCW+J+Rn2zEpinYnyWwFQn1bULL6YSr8J0qRw2qEj7tGMuxlde7t3UNyb6N
 p9AtCA0cvVV12BiOtdiedgYCny6AqcL9ZNIq9+zI8wvNy7eyA1wAYj/QfBi3x4XBnAZWmP30=
X-Gm-Gg: AYBFou33CgDFE/QINzv7wC99aiwkaw63g3AT617liWF31c4Zk2zkAYlcWXb9drm8HK0
 1CqgY/Xa7Ho/8J4Te6aI0L6UFlqmDQNqc7quPG2sljs0pog5Pn/NltQ/wbUhQ98VU2OivqmitFl
 Ko2XQM9PEfb5amY8/S8+7QzaMMSLq9gjHmhUKETFyX45qE2ivwFAvJFm0Tk3TWuVJQNN5+9P6bp
 dnMc0by4G4Q4MVbtTWwGL2iQTOYZn0Toh5YMRVHzFotgqhtuXqqGTqdVufpdn+A13EghEBIKIe2
 xBBDeTgPb3URDLzb4mSz74VbfA+1mXl97b+jeu707GNuLpXgnBmgIvslNWK9oKXG0MxhxfpBqx0
 rstLDjTDRGkC1Xv4Kmx08/m6jfCiNBQbS6S4psGGikLCc+2RLI8MjkExvzn8FiF734JHIeLHIiG
 hCvjpaThjXBjHittmDwgrDcscGfh+zBud6xDVN5X3TUV43bXe/1ZNOA119PxkiJQnrE9ATmGwFU
 Yx4aA==
X-Received: by 2002:a05:701b:454f:20b0:152:3812:496a with SMTP id
 a92af1059eb24-1ac5eea0720mr13959026c88.43.1793598649689; 
 Sun, 01 Nov 2026 21:50:49 -0800 (PST)
X-Received: by 2002:a05:701b:454f:20b0:152:3812:496a with SMTP id
 a92af1059eb24-1ac5eea0720mr13958989c88.43.1793598649048; 
 Sun, 01 Nov 2026 21:50:49 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:50:48 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:45 +0530
Subject: [PATCH RESEND v10 13/15] mach-snapdragon: spl: ipq5210: Add SPL
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-13-224d421c6201@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: YRz94Lt-mO4KW98oQwapUql9M-IUAlW-
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae824ba cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=-zc8TOuOcBEM41oa4wwA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: YRz94Lt-mO4KW98oQwapUql9M-IUAlW-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX1CVZbkOJPQRg
 Gm9qucMQliPe/f7j4JWhtjuLaDrzeWGkqF7ViS4HktRKLLwO4Rd3aH1i9GYjIIWqDsHZtciKi2D
 Lv/4lwvrBGKbzEF2C5absWdo1tKIwTU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX/bCLP76Kd1EY
 VXXVHZPaJYYmvP2YyAi7Gfe34fhwz7H3xbrjqaOippyyrjhtEWMaS8FjAIo/5Wjc6Gd7JDilTX/
 kAiyyjdu6VBmbypXNDR9D1KHwnWZBEWu5atAcykA0GLX4cvGcnNCDnh8q5R6nP9I4SAZd6vXi9e
 gy8sx5gZIrAqUv+LO+aZHw/upDaZvEiPsR8S4Cxgk/fQrE/rig1TkxpB493YSe1cWdmTJW/8BMt
 FF/FvS/XxILiW/G1DdurpfXmHxmsbNKvID+fAJ1eRHXSYPDZ+xDFd8bJR9aRMYjGsUGHo/aj/8A
 vqt2mEX/tHr2AUDltygC+ghF7CDjIBMDYGijDW6r9KXiNKeCn1wHbqkVRMzu6hXn1Ij0r27mXI/
 jfI4pbfEpKoyYmFJyDfzcAM2dhf7kDL9V6JbY3jZPpQ9kZpeGz/HUzhwwYaDIwlr2jyJ8vzfymL
 Wxcjmek/Yhu1gQ/U2MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
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

This patch adds the basic board init routines that invoke the common and
mach-snapdragon specific SPL frameworks to proceed with the hand over from
boot rom to the next stage i.e. U-Boot proper. This also provides the
linker script to generate the SPL image in the format expected by the boot
rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c            |  2 +
 arch/arm/mach-snapdragon/include/mach/spl.h     | 13 ++++
 board/qualcomm/ipq5210/Makefile                 |  3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds | 18 +++++
 board/qualcomm/ipq5210/spl-ipq5210.c            | 99 +++++++++++++++++++++++++
 include/configs/ipq5210.h                       | 11 +++
 6 files changed, 146 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 2655803b31e..3293eab8f81 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -12,6 +12,8 @@
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 /* in SPL, we always use internal DT */
 int __weak board_fdt_blob_setup(void **fdtp)
 {
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
new file mode 100644
index 00000000000..50cc8dc4e8f
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __SPL_H__
+#define __SPL_H__
+
+void qcom_spl_malloc_init_f(void);
+int qcom_spl_loader_pre_ddr(u8 boot_device);
+void qcom_spl_error_handler(void *arg);
+
+#endif /* __SPL_H__ */
diff --git a/board/qualcomm/ipq5210/Makefile b/board/qualcomm/ipq5210/Makefile
new file mode 100644
index 00000000000..d808c106524
--- /dev/null
+++ b/board/qualcomm/ipq5210/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPL) := spl-ipq5210.o
diff --git a/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
new file mode 100644
index 00000000000..f0ced6765da
--- /dev/null
+++ b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/ipq5210/spl-ipq5210.c b/board/qualcomm/ipq5210/spl-ipq5210.c
new file mode 100644
index 00000000000..5fc42e64c11
--- /dev/null
+++ b/board/qualcomm/ipq5210/spl-ipq5210.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <hang.h>
+#include <cpu_func.h>
+#include <event.h>
+#include <init.h>
+#include <image.h>
+#include <linux/string.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <soc/qcom/smem.h>
+#include <atf_common.h>
+#include <linux/err.h>
+#include <dm/device-internal.h>
+#include <part.h>
+#include <blk.h>
+#include <dm/uclass.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define QCCONFIG			"qc_config"
+
+/**
+ * qcom_spl_soc_qclib_override() - Populate ipq5210-specific interface table
+ *				    entries.
+ * @table:	Pointer to the QCLIB interface table being built.
+ * @fit:	Pointer to the FIT image blob.
+ * @images_node: FIT "images" node offset.
+ *
+ * Appends the "qc_config" entry and a placeholder "qcsdi" entry, filled in by QCLIB itself.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	int ret;
+	int entry_idx;
+	int qcconfig_node;
+
+	qcconfig_node = fdt_subnode_offset(fit, images_node, "qcconfig_1");
+	if (qcconfig_node < 0) {
+		pr_err("Failed to find qcconfig_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	entry_idx = table->num_entries;
+	memcpy(table->if_table_entries[entry_idx].entry_name,
+	       QCCONFIG, strlen(QCCONFIG));
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, qcconfig_node,
+					       &table->if_table_entries[entry_idx].address);
+	if (ret) {
+		pr_err("Failed to get qcconfig_1 entry point (%d)\n", ret);
+		return ret;
+	}
+	table->if_table_entries[entry_idx].attributes = 0;
+	table->num_entries = entry_idx + 1;
+
+	entry_idx++;
+	memcpy(table->if_table_entries[entry_idx].entry_name,
+	       QCSDI, strlen(QCSDI));
+	table->if_table_entries[entry_idx].address = 0;
+	table->if_table_entries[entry_idx].attributes = 0;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+/**
+ * qcom_spl_soc_post_qclib_routine() - Cache the QCSDI address after QCLIB
+ *					returns.
+ * @if_tbl:	Pointer to the QCLIB interface table, populated by QCLIB.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
+{
+	int ret;
+	struct interface_table_entry qcsdi_entry;
+
+	ret = qcom_spl_get_iftbl_entry_by_name(if_tbl, QCSDI, &qcsdi_entry);
+	if (ret) {
+		pr_err("Failed to get QCSDI entry from interface table (%d)\n", ret);
+		return ret;
+	}
+
+	qclib_set_qcsdi_address(qcsdi_entry.address);
+	pr_info("QCSDI address: 0x%llx\n", qcsdi_entry.address);
+
+	return 0;
+}
diff --git a/include/configs/ipq5210.h b/include/configs/ipq5210.h
new file mode 100644
index 00000000000..5cbf838af82
--- /dev/null
+++ b/include/configs/ipq5210.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_IPQ5210_H
+#define __CONFIGS_IPQ5210_H
+
+#include <linux/sizes.h>
+
+#endif

-- 
2.34.1

