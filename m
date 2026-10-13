Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1762CA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A531A6074D;
	Tue, 13 Oct 2026 01:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KpBl6S-m3dAT; Tue, 13 Oct 2026 01:53:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3E5660737
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856435;
	b=jtopW7CMEcmyxZVXQpmBbJhpSHPxlQjHS5t150HzTGQrKd5GHoz/BISJpof+wtyOr7w9
	 92n1bQxKpxJ2vhHKkNGEuyv5tXZGseaYyaOI6aSErPtFThaFBFX7vPNeXccBT9JjLVS2t
	 uf8GP5k1DN6ueKpokm9lzpUSnLf02tRrpMLd8Z9xvGR+ZvMYNS7J7gTHOTnTH0EDW8aNa
	 SDmn0g05CUj9PiVXICIaneuPOW3y+hBZd7plXPFdwr/eWvGnNSTIrajTMSeLMW/St2f0n
	 5MScsoLlKu5lSGfXxDDbLpkn7Nl7/kQWKSEbz3gcFtMszDx8E0o6Z0/QnAWLB8FAwaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
	b=KUYu+kNb+iqKAmBpu3FYLI98ZiBaG0z40IF7PwPb+5bM0c2gDwtkVVn7lUPysTD3SyU4
	 Nx+TKz3ATXqp+MAVOkJcDj8kS+BZqnjMHX2nbx6BbWadDAv7uehUiMRJSNa1ZVWmbB8Sb
	 Q6KLUAbGCL6OV0hd8y2ic+OAmbyUzeMHcosquH1HYj+UzUpPo5kIHekzqxH+qCO/QB3uv
	 Mbmf9/QfDn4Q++vmNWfRNUOINLvcJx7y5NiQfvBaMK5zLHFjdg/HkxBSn4iL58E/s2+7z
	 4WhEtIpNPKE/AUuzB8S1x4dL3kR922THQ4ZnH9Muvuq/zYyF/JjhL9wCUQYKBZVLSMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S89W1VZ1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Pg/bAoNH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856434;
	bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ygytIKZ7USmy9LdlVQ+7OsA8WZEO3ewe7QHVDfsrT3M7zveLMq5auEHyRh/odjKgQ
	 cULI7p04MI/9xg2nEB7Vmyk1uXDvrYP99R6SeEzaMR8j+Knc2dO5AJ1z2bzlmQXjj7
	 WeKs7+4v6GOCdBZt8rs36uVKSDoRJKjZvdT95Bg1pAtPgdj/sRKoZXBxuKf/xj0Inc
	 eJP/bGpOreEcxDmpvYEDDAf1Xs773RrBFvIrNftv20urznHKD57Md3/yR49twPyXYz
	 oP/rST7FWAEux8ufyqi4Sdv4ayXCaewIsgsm/X/DnwDR2zKLV2ZZm7NkYxWJjT/J/K
	 +wPRkdPmAhcZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3E5660737;
	Tue, 13 Oct 2026 01:53:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AA1E2A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F090660730
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FG7sFzPBX4Ig for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:53:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4CCC86074D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856433;
 b=RGES0VwBPfbBXJ6xoQvWjRmU957jhmGw8UJWeCMqMmzxJQ/wSXElZUmpYLJeNnQQ7Iqd
 LRexe96lpRfORelFpYL7wX4Kbdf+PhhnBfmEVnWYyE1CigdxzPzHt9HICNNQwaiuUO/GJ
 sSVmkAa+BvaW2Qe4A6wz7rAgs2M55ObE1gNxfY2fN6KptjRcX/uageFHR/8tDeZICYNpM
 xFjT2+B2Tzea/yvXNtPAXF9CkJhKoo1cphlVG7H2YCXR+kU3IbCi2NWWmozPhd+xtEjNt
 bgd7m+iNbh/JHbOwZr/KCBtPcCG20NoEETH9F8rAx0lSLR0mEGPtJkH1ON0382IxoHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856433;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=pS40eZ6xKkSNhC+1HTvuehhTkUBiJeMvOdCb3EGzSQSWjM16DUiinkmQhewRCIf4xg0Z
 NERMWuZHJEaE7nYj7cIl/W7Xzh/548fZYvdZbwZUYocQPRgr0SR1iqUJ2oNJMr2JAI69C
 /bfNa8m/E4JEZD/v3BOoSCccmx12n4cC3rjPzMwsFn5abcf3WOY/fH8vyM9R/6UEHKXaK
 G0EYqfua4R37BPaLsjGbCWTp69PhowY4bmtjySP1/rzIP0BoNkxIThQhRDESgWUQg0OO0
 Zg5wRfeWDUWGsVhmPbsfA92Q3fQeGst7axSS+fkPVpoP7ygCUousxz+WKGAK4AgP21w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=S89W1VZ1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Pg/bAoNH"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=S89W1VZ1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Pg/bAoNH
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CCC86074D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJMxWo1779137
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=; b=S89W1VZ1FvOxnDPR
 2cDKs8w8tSZOzceaS+X3MahZwVi/W6B4WqS6SHf7g+/oTMwXHRuy5jYTqHAY/jsQ
 t9SQgeL6HuaoSxmyyLm6QxxMJl4q+UV7sM3HpYRHIsqH7mZ6uCyQzHXoEVy8rcXe
 JqO8gaEE8yTFIIweELqkaycjAj6Y1SGGyBVy3UcPcDGXn6EC71iJjg+Fpww09r2K
 u/iR2xnA6LVE9gtq7EZwtgT+CWb/YJ4v24HoMhg7pacgfje2aJl+zUGhQDTp341f
 Bv1d7rlW0sDfDtRHWeKqSJ7H0ZU+5nLMxbyGoamC25yqgub4JDSz6EQ3Ne1wHRR3
 no8ZFw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcukdw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so3885910eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856431; x=1792461231;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=Pg/bAoNHaxpa/+4CZdB3pSO87aLyqIW1OVv4f99oHxpAp7R1xOLm7zX6XmOAqT+JFF
 6MID7eO3RfiKroQm/DhNd/8tmwUG9ol8XM9/SAFqWZci9wVwNbbLV9wlbNHrdvKL82vo
 AaNQeKSHl/copcgb2R6PQ0fRnuliMdfnpY7xG4xofXzhUHBOCsg73+ah++dyD7fjFS3U
 UfNDzZdlRDWJG8b5ReeO0umE0mga6ZVP02MVgkU5l2bYQE8pKR8FCBfEEUya1RA4B30o
 3JzdKY6yXI5k0ycvLe4SRlKwB/9ojh50/Arni8sHBcuBBsTWLGsM7Mb3gYbkw1y/JVs7
 N0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856431; x=1792461231;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=JUMxUPCplLr1VrWt566jPy5zRdADCvCqHud14lzL5EQzroJ3vsuqq+svk3OjLCrh9O
 NOolLIpdVbu3nhK6Aw4HTlw7SluRFr8xUHzVTONMDNSC3eLQG/+0gqzD9IOHS68BaxQm
 hf4XzjF3smLvBIke94HIJ29Zg7LDo9TFYpunkOgKbnaEoVfX+1UNUGRHO1qyoReD79tJ
 zDK867I+ew3nDx83kq1iwTbe9za/Rxlk4ji5r4VxpWpEoHly1AAhrCT4jdKJc1hiRw2+
 6VIZP1SQOA86F67PXARP27HrtfS8ijC0s77L/A9GygW+H+Q9YYiOJk/7dpNwJVmtl1N0
 JSfg==
X-Gm-Message-State: AFq9FYJEv+frUPIacvQK+8VB+Ux+Gkl2jVs3N2RagcstTld/ycRnKGXD
 BO2uk7aGo/mVsJu8K5yDMU5JZg9+ja0pGCWqLle1sFMnouvkJKHdesuzVViKF7K2gVDBeamOtiq
 J1J9efs6MvvT7SzDhhwIOOa6Wy9wTJe/ksYNdrvVIxbA05e6yfH7wva+wZ5N5J+hykTMq+fU=
X-Gm-Gg: AYBFou3A79hiSAwmYH9jks08fcrtmeNg/NhJa7tpAy+apfr31RM/AkUhBhwFrMxyG9w
 uArKQICIYQLJalD29b1yecDkvNN+WfTYxUHgLDCOIcvH17/UenMW5e2cCgL3yRwXWWg0lu2QK97
 ZijNrXmy8VOnyMVueAxfDX7vJM9ECcSLpuU4t9JK490/m9HpOHojDXnq/HA2bN06C3Gb0mWtUVs
 jUEZvQLBPFskFZGnt237QXecTkblJoAtCcvVD+xipJrQEDDrbZ7er7BycqVpQX6bFrPnDzT+1/j
 1t8IZBokd0umkUxaQRpPqffPFlexI0u1GB2IFQ430NbnHV079U++eUIs1H0JkvAwET1jYVh6eQ7
 iemc3Mp4FN8OAWTtyiazJE0I4DSd7pFp9XcPiLK1mehIr2/i4RA3+V6FQe9MC8vQy/U5VcZ2RRE
 K5TuDeSOXgR/2dx9PGe7dk+nOBHUk=
X-Received: by 2002:a05:7301:6186:10b0:343:8d77:1d97 with SMTP id
 5a478bee46e88-3537e07f071mr16008247eec.39.1791856431500; 
 Mon, 12 Oct 2026 18:53:51 -0700 (PDT)
X-Received: by 2002:a05:7301:6186:10b0:343:8d77:1d97 with SMTP id
 5a478bee46e88-3537e07f071mr16008215eec.39.1791856430886; 
 Mon, 12 Oct 2026 18:53:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:53:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:14 +0530
Subject: [PATCH v7 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-snagboot-v7-5-fc296a32836a@oss.qualcomm.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=1942;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=UgnSfcvQN3KxWw8blo6gGammTjNQRx3KkF+Wvh5C7Is=;
 b=tD1QH9RYxuWqsqXL2j7gk9ML8sNfXfPluM+asb1knBpdjPTnrkeeuNgcnZfg82oYbRFx18ODd
 PHfwlFcpc9xDcbwZxVeRaR8236k9ZI9Az5jwmnRW6mRSs2/P38rqD3W
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: UWArWA5M_u3ZCSFBtJZyEMsEjTT5SjZq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX4t1Svh3QgSuZ
 Ba8hKs6Vju3BppDnIhZ9wT4wOwNJXip55HnmvlGZX0dLTHcZNIeeMjmMC46t5Sd8mXx2mL/FGVQ
 uSwcKcLKInvjEUarCuQwKylI/NIqtY8=
X-Proofpoint-ORIG-GUID: UWArWA5M_u3ZCSFBtJZyEMsEjTT5SjZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfXxTZoy24Npojb
 +diza9j1JFCU7FJGHZ3cxRFNeakLY8xIxlMEHj2n/ud6DKNCThp5Ie65WNxckYuYybd3MwasCkT
 5b64QkQbAsSk8zWSDcT2njbUO1QP9vrYftCmmGua7tfeT7ABgi7aXBPo69g715rL6skN8XfFnY1
 mLiFxBMha9UUxFX+FXjDf+6i02d/gLJMjImAVRYAU9UY017rAMDBM+NGsTtqqmIywwJQFKwvnRa
 8wS68MAU4xpxSL09G+8QjEOQ9ddN+1yUk7r2rjPe+9qS91umi9CWWJxpUrmp5CiVo7jij023GyJ
 7UlyOLEycbWDvtEds8IFDaJQDqmSHtXRWq66SXeotdOeuWfLNEZORSTC1/ltphlDLfa4vyVj3C8
 HAadMm09gB6YrRZbr02OAXm1eJiMsDMbd2pJtDATQTsCSWidwG3IJK/YD+qdvL1X+BYt7m5Wi5s
 rxUru7myY817zqFLlNA==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acd8f30 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=GqjHzkLP_lxEehVDorYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130007
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

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
enabled and CMD DB data is present, we log a warning.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- Remove QCOM_COMMAND_DB_OPTIONAL definition from Kconfig as its now
  not used

Changes in v4:
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Drop these warnings if snagboot mode is enabled since that's the
  expected case
- Log a warning if snagboot is enabled and we do have a valid cmd-db,
  since that isn't an expected usecase

 Changes in v3:
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef

Changes in v2:
- No changes
---
 drivers/soc/qcom/cmd-db.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..c94a90a2903 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,19 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		log_err("%s: Invalid Command DB Magic\n", __func__);
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+			/* Missing CMD DB is expected in snagboot mode */
+			cmd_db_header = NULL;
+			return 0;
+		} else {
+			log_err("%s: Invalid Command DB Magic\n", __func__);
+			return -EINVAL;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+		log_warning("%s: CMD DB found in snagboot mode - this is unexpected\n",
+			    __func__);
 	}
 
 	return 0;

-- 
2.34.1

