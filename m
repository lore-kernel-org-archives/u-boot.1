Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA69606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JOuy4eR8;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cznY4MQV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D/mocBeV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 292F88108A;
	Sun,  1 Nov 2026 10:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bwT800L5rTrW; Sun,  1 Nov 2026 10:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58CD880F48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528412;
	b=qIbMw1VEZwiAAZ60xMl5T6mkssiUpPav7Q6TkugxtrQo/7AzrkdlFeI0riyUGMhr38Zz
	 7JQw0WMoi79E/UVqBTQWrU6saX/A42+GXO0rhz0VK4kxHDuKZTyuFquCFgH03A3n54uci
	 JHt2ksu4cIT0MyGUJBLsr2022/FIIRX9rYzlcqhJ9qgaee4hmxzoMBFwWJIUFqdbsacgh
	 bS8DyAhywo0u2L6iqlhiss7V/66md8fvmNOv+xHl/zUaW7RZFGfW1rbptm7WeRUPlM859
	 dZu6vKxTIiCoGpyVbXGGMZdEnwh21BsqiNApD5N8A3c6HxlPnvLUiHPWVltlJ1tgmkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eSedPWAnspE+sGTpmxYJiGZ+bVRBDsXpN9l/ZRI6WVI=;
	b=PrMGZbRZVE20o1jrcIJzHRPmVrObynPo+aKYUOlDQRUgmGtQVzPe+GpS+ymxH3mRq/qn
	 3b4Ut0b+PKu0wQ3iZDiDEsCL1wGuY6mPqc5HRWS+g35LOK09dG5Oiblo4mcbneXT+620c
	 RhnQqAGzuwR6cRTTyWVJmBIZnpQuzozq7ZDAwfvMd03SdQwTGBm2Nx4PmZHpadyjxj7ue
	 fKywDIwI17KfhygTa+FzL6nLjHaT4j/WGitdQD7SGTU6khpWiJzYOee/YlmRnqjfFBOw2
	 ShZ/k29tmcqIYus4xBAqT3q+8we+/EbfErTWPElYNEbuawmU8SqeU69DgDBCSjobidg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528412;
	bh=eSedPWAnspE+sGTpmxYJiGZ+bVRBDsXpN9l/ZRI6WVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JOuy4eR8jLf7js0GOpAzb+eVIwLYSCvfHSbSbrnTFc5VMGk/q9qW1AS4SA7CIx+67
	 STyutzk5fgB85sxXDOrDpzXDXN16+mCd6V/A4K2eZ8TRsNh/9bMK+I3s6DWhHF6KQw
	 gMxAOBrfjpwPPmE+1wFroUWWQyvfUGbTW73tZUX9wia41w3fVHFrznNWeGkK2S7b12
	 cUy34bX1N9kQfFTpeDPqIlZ7ZICsrpZ5w0jV4Gqz8ke4hzjbMyIB835qw7WwtfY5Lf
	 jOVHjIBfWMFT/kA5wTutohKqa041D/UUYCnRq05MRUMJo4KaGnloeoVRh4ujGT9P28
	 jwnBfIr4iji0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58CD880F48;
	Sun,  1 Nov 2026 10:20:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 497D22AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 305D86065A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5Hh8Wa4SmcQ for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1DA53605CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528410;
 b=g+f2t0k/ta9oENqi7odM5Z2H0hvFquM5wmuTZIdlwrCXyqVXEtefXeWPAUyWh2eZUER2
 vpKxkJSsNh8f0Rhg/RYh/wUxBYWVw8jR7g8wUC93h7k9LCpXIA9W6MJ0Ouq2LmNowxS74
 hezjaZxJIudLXhIzczUdr7KlcncBjasWNmq/S+03n3SHJOrGsBxl2zHxDyslW8sPxj09r
 hPO5jNLU2iau4q0cc+y2JgYWH1hLIUWaExhkbyWxU1C95wTyHErr+Nx3NJojEaeMvkdcu
 X6NOtRBYgw6eUlymJuRqDhdDzncYjHugfbjllAtKu2Bh/kzjtKYKaNtMTKobRvDp5WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528410;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=eSedPWAnspE+sGTpmxYJiGZ+bVRBDsXpN9l/ZRI6WVI=;
 b=aNsGEfV/jJcRfHSAfw0aOj7YCs7pVhUuZyEtYDZIqg2jYs7i1OANIENH2DfaC5A+wyKC
 OeV72sxamgjWaY3lMmovH72SkDM3vOYd/wu0+UhuXW79+TR6PswkU6Zw/Q58lKPeHk/7a
 2pLgbWgMCYcNxRaM6mlIgqwCTxMMfuFEnTcxr+5qdgjk3KEOdFMjfsT6ezpOmby8FNq0g
 FQrPXEmOIQVgbu3qc7riRSk5gJVCspfA6ynHqE2fnFtIpYYU/mjY9czkcxiWiOiXPlYz0
 hHFEOECANyvO1WwUm4xRgiXFMFlIZS8lQnxUE8lmUokpLFIthVbquitVEa2Qm0Kw1+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cznY4MQV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="D/mocBeV"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cznY4MQV; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=D/mocBeV
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DA53605CE
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K2HT3570532
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eSedPWAnspE+sGTpmxYJiGZ+bVRBDsXpN9l/ZRI6WVI=; b=cznY4MQVjhpN9Az/
 i7MCGABOje8BIqI2qFfJnuZNVRYyBAsPXNfG1OB4b431J4QdAX5HL/7g2oPGydqs
 iGTvy4TgIQZJuUUYy2iflc59Xb6SgyOyOKKRjZMR73pZT2bVpbI5XtnX+BczgDQs
 pWlDjLlJ5lvpb1WgZ2EDY4Ki/XXXmYk9zDe92ba4bHlu2aM7HsBQ5N5Ht+hMJk+Q
 oYL3CR0KuVDN7Mkdkd53UZS2bxk6xi3upxU6MgID12EEufzEbbRW0X0h7f6FhP12
 C16bgAqy9wy20vS0KCxsT/at4XafwJYMCDo1FMvEmkQXfMRbwCVbd2YxXdhya0zc
 E3e05A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m9axhm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:20:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36637676140so3023152eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528408; x=1794133208;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eSedPWAnspE+sGTpmxYJiGZ+bVRBDsXpN9l/ZRI6WVI=;
 b=D/mocBeVt6SMrKdIQskXT0bLlcGAVLEBd/H4fjho94gAgoycqt099Q+9lvGLkTCeZW
 V7C+jm6Mx3SY3eC1iz/NQ3HtEN9sQeU/YuxAOUMLUB17MQH/O9/Gf3gdq/6vaDEkbSO4
 pkM6gBJ2iE170larcjL5Q6E+VFznFBREa0NNsMNoEfr1cxYTdGExeM0uz2z+n4sq2PUZ
 +qhECvzW/SdyUF8rRxTF7Fdy0ZkZt1wEghY9Wt0of7tDdCUE8yqqGc5O8H6bBbKa7SbX
 wWa0cPGXUob9HL8TlPYUQvcd6h3Ec9FXC/+XmDHuvQpyNqghnm3HAqTbthID3CCyD+3F
 srPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528408; x=1794133208;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eSedPWAnspE+sGTpmxYJiGZ+bVRBDsXpN9l/ZRI6WVI=;
 b=SbQ667jrIYz/SS7ZjUl2EgXiH/c4nKGkrQe0A80/2wzqW2tk0I4INnt1Gx46Q1JLAA
 /FKDb53M7KufufYP5Iiam1DDdszfMBelFzAt6F6b57XldnlP0rV4ywSia6BEXCcK07fP
 ZPcX464qF5YX4ISdk7A6zkfohd+5x6LcZFM6Pa4Lp76bCKWw9TV8/nCrL3UJ+ADDQpGH
 dgvw0y7zyxercCgNdlYsMUaF7kmI/4nM+oXfJqHeeUs8fjHXB1fZ/ZWOLpoUSSWVbkks
 /lSaKtlW4Ca1VH/yu5LMHY3xKF2xlIIYeHwjwUSYYMd+gxreJe2z+oWCawgMAOogIBXj
 Ogpw==
X-Gm-Message-State: AFq9FYKudfv1maBAbnPPT5/afyJ62EwIb0WBXPFunFfhcpvfh+cObHij
 5TlrvtlwZ6eNgswoF0HX5jFYoL3iOJ8HgSZQHwr9HDEvoPknr8IcFQNb4q8aBclHI37eI1B3ud4
 7aVOW5qVyZvvhkuG9cWASPMNv+t+u0+SKJgR0QBuKs+C94oLF43Lv1G7e0hPABx39beeWLGg=
X-Gm-Gg: AYBFou2ftbm9jy/V5zszuRXxrFetPKcjpDOXuTeEEYJNUvXbcPbWMTNsP6c2l+B6+QW
 yNEOGsqiFkjUrWiIM3pN/hxySupbf47ZDjzOPMcGvxJe2WP9wHekJFiiFhQAVkVdggALHFkQS0l
 pqUPREElzQmNZk2qRAG11tW7u8uo/QY8lWrupmLBAbARTJAKET5zBCJwgEbtcgvF3HdqYx8dbpB
 uAeJIEcOrAi8TYsmpxCOtgkNSm67GLa8lMawCdQ8hJZAvBN+NBLwS+aYHGv+WL83ZZAX4Uz4NyC
 1u9QNYyG0ws4EUjFtVk6R7q5fqiq1quPOMoA4EPJURv7hyoQ0IKe4YeZC+zoi6Q9Ha2gUJ44UBv
 XSP5KoW+uyD30PIbWDve30rIAsdMeT3ldCRPmUWGJjw+/bvJ/nnMbOHgbPe8ltsU1gl2aMAx6O9
 u5+eF5k5SUZc+uPUvBuH9glNbMMinIcSP8F5DWQxVaiGoXIqwizecJESvZdJF16qczF6zwXjV94
 7JGnA==
X-Received: by 2002:a05:693c:4095:b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-36a4220016fmr12962077eec.2.1793528408343; 
 Sun, 01 Nov 2026 02:20:08 -0800 (PST)
X-Received: by 2002:a05:693c:4095:b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-36a4220016fmr12962025eec.2.1793528407589; 
 Sun, 01 Nov 2026 02:20:07 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:20:07 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 15:48:44 +0530
Subject: [PATCH v10 6/7] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-snagboot-v10-6-e73d5cfedb8a@oss.qualcomm.com>
References: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
In-Reply-To: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=2983;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=4UrvY9grUenQmQxCJS4DaUbTVUj5B65MHWgICAPlUYQ=;
 b=QCVExfqVffLQc6JCdrT84lGdLa5gh3rUepu4hPaBufrYaZifmIacsSCDfzQCpo/3ht0Yfmnyu
 CO6b9jJxansB4t5Zn4y59SNxNhLow+aGU3U1INaB3YMrKc/k0LXqr+Q
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: -3GGqXICViVdSlRkUCD-Sks1DXvyII2a
X-Proofpoint-GUID: -3GGqXICViVdSlRkUCD-Sks1DXvyII2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfXyt2Nwo67l/ty
 5acB8mSr2sger6meWpSANvyzh4/SxJ6MkOvlE9NhpmOzqKic2VNrN6Yql5XsjP85u9j/BUBZyAS
 Zld1rBYcv1TVFqQLKlyP31koY8xxgzRxpRQ9ustD4mQAbYIFvLyOLkJVf+PQ44Tnz0ubm+t0Cn3
 hcp8qja947Q47/ntdoVkE/NoDqozgn5a3MWRcirJJI96m4S5AT9wAMZ+eYowf9NQqGvRNgbou1t
 Uc7Spp8ffqgxYCHmxslU2wEm3MJ0+YP6E7pLGZnB/vVSkfcHZzpZUnalUV41MyIJ7+WXJdNzmHs
 43kehWZ2kqhp9ShM4PzedzA7F2Z2cZpmnzYk6KbmnE+tYo4tdpnA91CufpDGP07RdV1Lj056m5P
 lAFMzelFh5MAzgfTRYqDA7L1mgHM7uYp29cVFXPBGT7xCW1NpVxI9ujpLcfNGhP+ufiPPC1c3qv
 lxSf61HsFJi1lFPzVJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX9rVoMHBC5u54
 qPTpOvt77diE/beDC4zZErVQup8Lgpfrqw3z2+dTZGrmeJ2DSUvWLmoyaz8o4aFO7gIBqcOBddX
 5VhUvFt2CHgA0yx9aibXNF58iEJ8hlM=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae71259 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=x_inmcdqPKzw6vfMRBUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010041
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

Add defconfig for booting U-Boot in Snagboot mode on Lemans-EVK. In
this mode, XBL loads U-Boot and directly jumps to it. U-Boot then
enters fastboot over USB for device provisioning.

Create a reusable config fragment at configs/qcom-snagboot.config
with common snagboot settings. Platform-specific defconfigs should
include this fragment along with their own settings.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v10:
- Drop CONFIG_ENV_IS_NOWHERE, now provided by ENV_IS_DEFAULT
- Disable CONFIG_QCOM_COMMAND_DB

Changes in v9:
- Do not disable CONFIG_IOMMU in qcom-snagboot.config

Changes in v7:
- No changes

Changes in v5:
- Disable I2C configs as its not required in Snagboot mode

Changes in v4:
- Use CONFIG_ENV_IS_NOWHERE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig

Changes in v3:
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection

Changes in v2:
- Newly introduced in v2
---
 configs/qcom-snagboot.config           | 25 +++++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
new file mode 100644
index 00000000000..0ba3af32d81
--- /dev/null
+++ b/configs/qcom-snagboot.config
@@ -0,0 +1,25 @@
+CONFIG_QCOM_SNAGBOOT_MODE=y
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+# CONFIG_QCOM_COMMAND_DB is not set
+# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+# CONFIG_CMD_POWEROFF is not set
+# CONFIG_DM_I2C is not set
+# CONFIG_CMD_I2C is not set
+# CONFIG_SYS_I2C_QUP is not set
+# CONFIG_SYS_I2C_GENI is not set
+# CONFIG_I2C_MUX is not set
+# CONFIG_I2C_EEPROM is not set
+# CONFIG_ENV_IS_IN_SCSI is not set
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_ENV_IS_IN_FLASH is not set
+# CONFIG_ENV_IS_IN_NAND is not set
+# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
+CONFIG_BOOTDELAY=0
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
+CONFIG_FASTBOOT_GPT_NAME="gpt"
+CONFIG_FASTBOOT_MBR_NAME="mbr"
diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..25e0e119479
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,8 @@
+#include "qcom_defconfig"
+#include "qcom-snagboot.config"
+
+CONFIG_TEXT_BASE=0x1c100000
+CONFIG_REMAKE_ELF=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+CONFIG_COUNTER_FREQUENCY=19200000

-- 
2.34.1

