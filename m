Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839FDC982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 05:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 852BC60C1D;
	Fri, 18 Sep 2026 05:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KxQ2RX4ajJ1v; Fri, 18 Sep 2026 05:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BBA5260C13
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789708961;
	b=idLhvKpEzgV8rF5UqqCeApcLI2xfgzlInqTAIl4GeBJA0G3rb3eUc+3Gf8aWbVHfM4Nx
	 PiRFOAy4S37RbcqMe2yAj72Wax33YLJTvkeW0M0RHbtnC3sUktFEEfwVSiUEniHsphRhA
	 8moIh+rWUHs8fZfcEcU4uuVjCqtmRtltulcYBzrIWSJia1MygRC/LKf4scDiIeZuIodHr
	 zmLxGwthAo4+Z1TSHJy7KEqdCKCaM5whJZZ8zj98XEcAy8Pd2fJ4VFxGr2y4RmqB6e7FS
	 hAG3FqEv1LxxeSy5k+LfsMJu19ApltpXkkxNrkVKqfdnfEJ81seIw9VRvr+89XZwy/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789708961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6LhTQs2//whyHASrqEmggY6muz+/M2GoI4Kf+meKBLQ=;
	b=WjsQMntLGXVzZaOJdYA370cft/0wLLNtuvBqt3ZeOl33khUQ4nktyaHRmUtdLG5+FUf7
	 deRO8Xa0v0PlWkNkimqTA+Ix153Zhv/eOvzuCDtoRt+9MQQzgc4/7m/3Rx1CCHsXMEL4Y
	 3BwfFaN5TwkRHbTnVghJ9vOur9o3nt5bj8vq5UE4ARmlA/FTA5dq91r7cQOuwFeKzsuNz
	 ENO9gX5KpmSuqzsyN3bncRT3oIShZwk5Lwi5hGhlb+0BdYRUTMGnav8ZTN7l6jZwvyteO
	 ulUJ4BfJkiIPJJckbSgRuS5bSjrb4R0YiLzEKsEhbLR1igUdcIdZxgoGYObzCSuyynA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789708961;
	bh=6LhTQs2//whyHASrqEmggY6muz+/M2GoI4Kf+meKBLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v0sVxKRGxaY4XXWemvU6bYAVyOOj9nNKO15n6tvL4sMB3/77vDMO7D2sr5Rogj1/b
	 0Ayh4/aZE+egTUOFKx4f5DsNHkbxZrvnDLAO5dLM/mmdv3/JtKP4bdq6jttiFLEwpG
	 WOakS9mHD1D0Mi1W/K4XZ/gTFZSog77ocVojjqnCJbCrmqwtCAaxVi6QsnQniZgYRL
	 uBKCEEyBnygiFJMdwLSr/+qAKVFilvPPTnK+sBnXyICpgeIpl/R4PCZtPxQvIvohOs
	 +IMq/eTLOnjWh4DjP2zuXfq/jCoMsWnjgiZ6U6AoddCcu+yvCsKM/wk8ljMY2REKil
	 S7gyi6C6+Hnug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBA5260C13;
	Fri, 18 Sep 2026 05:22:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C36B3B6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22AE5809B4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEkbm3bfIVch for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 05:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7004B80994
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789708957;
 b=T7cV8fVUQ9LWI32sdMDKkAknYrtaFFNFbCjBUe36+SDyxxo3XUImb/ysaKjMkdbnCLJ+
 OG+XrjdQ5r9vFM5rt5WrUCEcs94Pj6ZQqCNOx9ceppD1hNUJdaxzrydurftUwD/1PnklK
 M+kDeaFERnM4xjYXSMcbljUyXgXzfmBp/YnK2wvYn52bZmJF5IaB7L3g3QsU0ogPxcZZi
 GSPYL0b0dykukZytxkjz76pZSItlnqNYg0UGPxMgEsJjBQkqAnZODoqgInJ56CmETGaAv
 FsckPoMwnqtnb73dFyctNh+lXwmgBKBZ705oTXEYEhOLo2OKCEAyL2wRB5F4v1tBWPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789708957;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6LhTQs2//whyHASrqEmggY6muz+/M2GoI4Kf+meKBLQ=;
 b=U7JweWaQCgmIB25lGR1oc/04Xn/HJOusNIW3SyqT8N3jsK7IZ2nGKPvhI8gSMhOeoEgt
 IRgQKQH0pXf6QGgPNoTM4UVinmL5qivNJDaZMXkacp+exmwmhqrSYIR///Q8MmmwEyVga
 xn2H28bOaSxtfXvaJTuOCJAyFwRPRO+eJyjxkCB/kkRjtYeG9kcW1Z1QGC9hylHEhEAKX
 HLZRCAzF3pAyfmjYTNdbeeyC00wiJnxEchVHCu3RyxuxvFeONozpl5BqIGFFcoobXiGIh
 pFp9ZnH1MWBGQ+haIJqk4QV8aAPGnwTjMxyi0PUphoqnrIxTuKwDD62jq0IK3z+8lug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=a4JwMVij; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z2zQByWM; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=a4JwMVij; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z2zQByWM
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7004B80994
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2UcYU2851911
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6LhTQs2//whyHASrqEmggY6muz+/M2GoI4Kf+meKBLQ=; b=a4JwMVijNs/Z+usj
 JxIUhbkFlNUeRZjc+n35U09TEaU7Ti+BCwNHr5rmj2/K7lIgZvSOtjykzP772z5c
 VeyEZfeCwHW0R4eQZxuASXEKwBppmyxIKkAA7kTfXCTQrwHjwUvcS8D5B4k/kfA2
 5QkCxRQoWS0ECQ2vEx/wPKLUMPrhd6pEjpmKCV+mFtk0NNMi2Vp24gdvjh0Fx+Ju
 x7brbmAo2W8FAUReVIRvtJTy339Y4fqEY88uTEOwp3fWM759oR3Sfz749UqEHJWg
 N1owZUJS3tN2lh+UaAjcvXFrkO+ml1nlQZSaKnUAWCzrSSAV3WoNFTbE7EETFOLE
 CVwwGQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grq2ksw07-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so461708a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789708955; x=1790313755;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6LhTQs2//whyHASrqEmggY6muz+/M2GoI4Kf+meKBLQ=;
 b=Z2zQByWMOOikM039MOODPL8BWItx2O7k+J07xlKyroMwI3CE40rJB/ftO6HKnrxNro
 k8FtP+plztcMwQ638eM84TpF3cJof9LhrdHFjC2dhBrm0pFiIlhfXXOQka3+01SHG08S
 picgWkqOCqgM+2lYV0tMGOt2QHdpsHhaQIIsqiFLFQkhWCktVY94S3QSMoJRL72YTD59
 CCdlXxuRdmfTdqspf541w0V/dEcBKuNyjLvx92r2fwu83BfvbEj0bcl9fGb60yiR/+JB
 w92a0UT+cseE4lOQ0/ilAjSxj7y98qg2Ew47vs1+mW+9BxSPPsTDmKbtUfO3hXR+Hu65
 Znjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789708955; x=1790313755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6LhTQs2//whyHASrqEmggY6muz+/M2GoI4Kf+meKBLQ=;
 b=se7hOAiBFhVWGabPwWgkwlyBIxu7Qx8wn1iXgGYMg5SB903SJysTKlc9WI03GS2BSL
 Ts2j497cw5M/kvb1T3aV3o8GKuPhij01XjCr76KmtSd5FMlSis6lVJbnreIu7eU3Iesv
 roJOZwQKQU+/5D4WMLPubnBtyEdxuNiU2v0Q6QvwoaYsPX/ekBsGcUNIi6VGAIWbQhlv
 oc7TlUif5EidOUHbHBpiFcUHr0fzLq2A0ysbSYw8eTV1JR8GrrBpeb0UM1Q9eN6nV++F
 nnjabuKmYsAm5kRbhK9TwDcXHSRMN1bkN6oyf8o5N7vNGK8lEpb2obDUJgiYJPUurn4/
 UG2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhgyW+7o+01ktjqETPSFoxS1A0DuiMUOTKGZlwgZCYZgxAbZpNWOdi3Wo7L5r76Y8xrVtrSZY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lQ1LIxY2oFev8Ej7QzJbxcINXBdiAsWec0ZXqoCz048pW34s76
 GwRFf9J9I9YgU1lJ4QCU/OyI+HlFWCM6JJJyMuU/cYXZUX9UP9M8qghciCogMu2nawFCoNp5jQM
 v4iGlr6nCKnVYrM3UXj7lOtirzFAFlCpBQayF9CYwBHMezPT/vMB1tc8memzVSX4h4/Q4Xho=
X-Gm-Gg: AYBFou1eqQ1z+QaX3Rakmb6omgV3EcXPJct+auA0I5B797epqDUxvLeYD4XxxtYVrQB
 DtaExmmDXPkvoS94/okzliFOsQBsOfLv6JoeGT1Sr2WEI+yCebE41ERK4coaCK0sHEQOl6Xel1O
 YMNBAPrCYAHLR+rVI+wSrp/fbBTGqqUtzTxIL2gCnHySQv5IpT+v1MOt1x6jeaee0WZRTrzSs8I
 SzYkypZL5WI1heLfHDHm5xqO559QlNUWNTDqnORVqS6djUOGITjScz13HYBUcpIt2g+OuE0Xnqm
 jYT6XqyLlUF5vDcQRsn2IJs7MjI96g9k7J7b57LHIlM3CbuY8KR8luTOlFVAtzgxauEbwy1oGI/
 mW7NMBKFlHXsQrnTqJqiC9LZ2UVZ0nb/treo872v20WXFmwxi0+iVSpPWSbgBzWa0GhB5miBiQx
 iTBHJiaAAXla8movyVx5WzzdcvesCfA9sNel9hECA=
X-Received: by 2002:a05:6300:670b:b0:3dd:85a8:4c60 with SMTP id
 adf61e73a8af0-3dd8c5badcamr2608237637.39.1789708954983; 
 Thu, 17 Sep 2026 22:22:34 -0700 (PDT)
X-Received: by 2002:a05:6300:670b:b0:3dd:85a8:4c60 with SMTP id
 adf61e73a8af0-3dd8c5badcamr2608199637.39.1789708954561; 
 Thu, 17 Sep 2026 22:22:34 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286dc939sm1162060eec.6.2026.09.17.22.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 22:22:34 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:52:13 +0530
Subject: [PATCH 3/3] misc: qcom_geni: fix NULL pointer dereference in
 qcom_geni_load_firmware()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-series3-oem-spi-nor-init-v1-3-319dfeed6c2c@oss.qualcomm.com>
References: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
In-Reply-To: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789708933; l=1161;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=J5areqK0QzxfHI0wzqvg9Sy1uM9ptNvDuAQI5Tt8dGs=;
 b=f4xbYOaQJBaJARKKVU1qYZ/boAD+mMEu+zsdCWgLRn/PtgE8CIiWyMnXA6MZfgd3txfhwUxi/
 PrEhTb17X/DC+oQaG/756yWRlozUtHhPXQT0UW25EwxPgJowL4JhOdM
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfX8f61clxdMQaE
 o+mnMknHn56gnZnPJ3iSCFpZ8HLP4eYQEHX9FfsqoCtIdPptQGvsfKfCcb7siAQy0K6ezqo7gyS
 uoBlhVeyfulaBI/4+OAKb9Ny01sfgygKiTkdnOTaAQBWKyeozcUmTCfdhKyGDP6qPjUkVbHvIYi
 Jibsa9Ly/EPE7wviYYyFx+Kgowhr0ImWbTSzvnbI/DXHZZvboEJ+43F6EjssvYPBjB+lDwiukgo
 BTkdEPbXYSU78sky2fM4Vpcs28oSAMPbxnrk16VP0LYyLsMes8NZWFhQd8bpAWHiX2PbnNxAPvL
 QFSYzpKsNA5zSC6z6dQwXcLb5XzlZfIISpXZNFgkD8spbv/7RRZUOEqWXO2JAXXjfNDbelrQxLE
 OHc4a9sxRzVZpxTTDtlWZf7J+X7MMvFYwQw4PV21M5HbdegXkeLRNsg4sbyQRxFESn626b50/Ad
 zGrheIZC9jGmJWy4XaA==
X-Proofpoint-GUID: 1YtB3ikBB_EAeE-Z8WkPnzunBPd1uhAl
X-Authority-Analysis: v=2.4 cv=bcD+w+PB c=1 sm=1 tr=0 ts=6aacca9b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=M4dTc-2S2o3kxq7vbtYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfX86urBZ18M8yg
 8lPTUIg8EJyKGlDQdv3F1Z2UYpUNqgsATGcV74Zmi7ejKGrTnfyIarfZltWUYKxBjAK7hCFz8X7
 t/uSC6YpaGCwrBY9AV62v/YfdnS92xg=
X-Proofpoint-ORIG-GUID: 1YtB3ikBB_EAeE-Z8WkPnzunBPd1uhAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180069
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

qcom_geni_fw_initialise() only populates the GENI wrapper's private
data (fw) if it finds a firmware partition at EVT_LAST_STAGE_INIT. On
a board with no MMC/UFS storage and an unprovisioned SPI-NOR (before
any image has been flashed), it leaves fw NULL, and a later GENI
peripheral probe crashes dereferencing it in
qcom_geni_load_firmware().

Add a NULL check that returns -ENOENT instead, matching how the SPI
caller already handles a nonzero return from this function.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index d14d74e4216..f721385ea83 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -377,6 +377,10 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
+	if (!fw) {
+		dev_err(dev, "QUP firmware not available\n");
+		return -ENOENT;
+	}
 
 	ret = read_elf(&rsc, fw, &hdr);
 	if (ret) {

-- 
2.34.1

