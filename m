Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEA606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S3LmVqiy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c8Uui8rt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U9rEPJaG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34F9860837;
	Tue, 20 Oct 2026 07:02:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOXk5yyxZiQ1; Tue, 20 Oct 2026 07:02:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DF8660802
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792479734;
	b=ATjg1fYThWEFkd6TdnnUMvZogMJuNxuEbec7Xlv57Erpi8zojAZ4n+Bc9HXJ1V/hEX9Q
	 quwHJ+PhM+HlVQR0fx8zZcdCfh+Z2cYQyUrupK07QqiagomAbHFDegr2OtLIjw6hAS6f0
	 SbfmjhOtx9J8MDDq48LoKHIRgiVZGz7OVsGetSbkBO5Bg9Uoitgq6oxoXnNtUP7x/nN8l
	 YkGMqDuA771ztCy94qeYp9vgVVMsLjAN48+Ni8joiBEwPYBYF14ukbiKDQF71GIhG8+P3
	 5m+cBbtXxc/o5PqO1ezlWnOhBQmj169Sv/jLspuCxf/ZVby490r2wsY74WXWzaFST2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792479734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ybHiqWMtzuQL2xOOBL4Gg0sNFWd2HUMZ0t0CJCsHolI=;
	b=RBb2kWNGPUKRrCX6oV4rcFAMMHh4HuX/A4Gk5mjaOEWKCBFFjUFYSL7f2BrOpa06RvOD
	 yVF1Dnp4i56g1N+LFGCVCqt6L3mDQnnF5vanwMx/XY8FzcGoyRbm1YfFqni9zNSh1C+3I
	 LHBOeKcAGqA3hjVTLE+cADhoUx/dT8jXFY0z/FA0eILc2DrtVrgeR3NP8XDKI1kML6Gqk
	 1mgp+EEKl1XMReMh7I4+COCAr/XtIhE4mXQ8nbCpI7ZRQb14H9pwiiJN1zsR2Ezz+MLEw
	 7n2qdB45rICdypnH4jqmAShFTWSBhgwL4gPNDrhiue/bG+Epm+YvEAUbiMclXW5H4eA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792479734;
	bh=ybHiqWMtzuQL2xOOBL4Gg0sNFWd2HUMZ0t0CJCsHolI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S3LmVqiyK3CeQ5q2HOYpAfAty2r9CdS75srjtd0A4sztcnKOLvJRO0g/kxtwaHc7P
	 Cu8cKVgFrQIGnYRKi8sChJrhN4f+A5XW7xHBaJEPfM4VdiEuGR4R/VOXxEaYpSwj3a
	 RUMqDpt62GlVlAQEyJIc+qcpxZ2VoRLv2jIJwAxj+syGW78sldlZpWLgHsBoYGA7kU
	 b/vCzhlrV7kM2ED64oCW61C884EZ30tsYMEYq3W49NCk3NtCT+30FjCuNrN1uIFFCu
	 VbtLm0LDUJRxaK8JfB4QFZyMkq/i8eff2aKPSX781XNa3i0+LIGXPcofChJLKgZjLe
	 9UpR1Xe/NDkLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DF8660802;
	Tue, 20 Oct 2026 07:02:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C38B23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33BC6810D1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a8CDYDvyrIre for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:02:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2DF7E810DA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792479730;
 b=a04EMLsK0oxx/VkAhmu30tZoDrp4fDJZYJbrEw1bj+nbyySX3llBa9lozsjQGpLmV+ng
 69BbJFDlvUwnnnQMYPXpIL6uw8/kmR09LQkS4tgg5HwkeKtig/oBfgiKwJ2/zUh1A4WSr
 X0L7xWv3smk5A7mxLSeZ8pqsqYiTcVh/TKjZUuLJe5dQgZ6/3nzwZ3y6PihaqHkLxkxmh
 3CuomprlPnBZNktzsfZRUlCIceEIFblSAH3e55GASbCNGTrnVpzvVk/g2d6xcZBgA8QPQ
 1di0sb7eJ72ZvzcrBmKmYTblvvi+yQf0OvwFVbA8KFMhGdxvMMUEQooXkhix3BaRjdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792479730;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ybHiqWMtzuQL2xOOBL4Gg0sNFWd2HUMZ0t0CJCsHolI=;
 b=qA0wX1pv98yDn3Urb9141BFgAilPS2yxDWISqueJfu+xf1VXY+hfM/zTq4XE+ZDnGS7S
 fhXJM5i1Xy5HKgNUtgdUir05A3aPKs3D/hzkvj/oJ4k3QgsAk36vPOEAr6OWwSVuvwKE1
 HzEpZv7jglh2oVoBOK1BmVpH44ejCcbU+FJx/1lp4YUHeWpi5RIyMBMnSecdopBNKKww5
 4Lj3dPzFDBrtK/vhGqJDJYDT2vqQchfksIYzptx43ioDr6wVe9FclGnuDAX7vLVrcIJsk
 wX4wDAAqy1ve9zmXH/eI89gHN0xnbLYmcCQTMXUn/0oYgKLAA2axwPg5d5+LZcp/TZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=c8Uui8rt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=U9rEPJaG; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=c8Uui8rt; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=U9rEPJaG
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DF7E810DA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0t70V4177751
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ybHiqWMtzuQL2xOOBL4Gg0sNFWd2HUMZ0t0CJCsHolI=; b=c8Uui8rtK/Uivbat
 Pmr4/dh3zKK7jFTVzST9ZpFUcgP5RLli+p90nLDCSNlUAE3iUH8kljyw1R7wnW5N
 qNrnulSltw3PZYXc7V4u+TLWFbOMt5LTKUYX4thPmyIMKHgAcqH5W1POLDgeAi/x
 VS+oLOwX8tZSqiX65Qe/RUmeLzFOanqB5Vtz13A1cd8vnR3wc1oD0sn4RRARi0V1
 jImCfDrFMzUVg7oDK6/4cL2jclxVtdMSAtQ4QOLfdNp59cQz2sYSOukKsP1hjjiG
 FRnLa1NoOuufkBHJuoBhrpC/eah1bedzXfcAwvhqmSGQv0mxouak7ygF3Sx2/Erz
 pOLi4Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n18sc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:02:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so8500715eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792479728; x=1793084528;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ybHiqWMtzuQL2xOOBL4Gg0sNFWd2HUMZ0t0CJCsHolI=;
 b=U9rEPJaGx4/FIcx54krs0s5OGxvRvjFdxAWAPV1qAtHs5T1wtey1E0cB5qzmecOAXP
 qpx84EVmqX3IOCblcC1PNHrwKoxCO/kYLr+IGV9aOrW4QWK/Vtu53jYcVz0RorFs9qjb
 hMvAh0PUWPKV12Ml8023pDVFGu5Bqedljq5laAUXGHOd6DiXdzNZAsVXjJQbzaVAxY4N
 sTDuxknGMHTaiJwwASbSj+ZTAVe9m8QA15DrftALzm3imxNzj4QV9MOrGWf08zu16V5+
 MoPHYOastRW1F74LcxMEREtcnUBWM+Ais1KdDNXBFEXO+gP3LqkSzMHveXGcyS/Si+iE
 yflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479728; x=1793084528;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ybHiqWMtzuQL2xOOBL4Gg0sNFWd2HUMZ0t0CJCsHolI=;
 b=2KUhZu1VfLAHzl4K6JzpfIx6dGiwtRv32Cn5KeCJBycDZRKpzu1SMDGuWprpp6PmmJ
 2Ip8yDX1vdsqKJE2mhhb2hRX01dihxv2TW0eTPL3dMAhoqesQQ4cKaayiix/3mp9SCl8
 s16HJfhU0cRoUQ7URoov/9LVNSedhjumAbVN5M4/FHvUEukRJpR4rkI62/1uZx8O4rwo
 FFGSzlAQnSbB/k7FvT1ca/XgSLAcDP5VDALGTpV6qFb5fzBsJb/w/derh9YjFWsb9svH
 rvEuZXpxCFjS4n0LSZNevihm+uPBS2xvp6dwJzduIWDr8Cpr8nwewfPD38FKThyxUHzs
 upNg==
X-Gm-Message-State: AFq9FYLL3I0vUuAjaG+SbdNcdn3DJ6XE9bQgxJa5GbAimiAQYv3NOyna
 XYBKr5tjGw2ONudE88uoeoYJPE4gR+M99FATQJHg7g/8+qeRStmsiTeQw+PSwYiKSgKmtnGz18k
 Bzc/sIsyNqeXlH+Xo+q4qYSt8fuxJ9HDTMB/SgqR2POz3qAtxPH+9vCpvSqeMdbLmA5N0AxU=
X-Gm-Gg: AYBFou08vjX4KGNRBotN/OdJijl1ZISFTog4roRy7EdTiZ1UHQBtxJ8RurZp8+71w1D
 rfMtukdzr7cWoJGf2QojokTjBs9yequlvjFEu3WcSmWX+vq5CZvtqd44Ae/qMkRfTAchIVxPCfY
 zZhju1/xR5aNZ5U77hnVfWyz1GbqfzRn1ajXkgSzSG0bI/sLFXoLvvbnMQghvZ8yDD3WuOnwVFj
 007AxUSHkuAv2Uv9EzjhV1vx/M2bHjdC/ns1UjSJvN1tYHmemLFp7IrHYga8Cychfx2DGsrszx1
 CZwZT5E6pKSTUm56/XWxc+YHbE2/Lf9GzdqZOaPVGMJegfBLn3+shP4tCvmN+RMIYSFIsXel+u3
 BQQj7QUbqHD7MtkE58O5AjDSgx+AvSQnK6aMzZF+F2ZTBPU02PrdnNLGtuDaW12OcCB6TTXWRh4
 E1fSxBS4iu6ZddNeAB2AlaG/MXKkM=
X-Received: by 2002:a05:701b:205b:10b0:169:9f67:a91b with SMTP id
 a92af1059eb24-18511eb675dmr13940604c88.12.1792479726858; 
 Tue, 20 Oct 2026 00:02:06 -0700 (PDT)
X-Received: by 2002:a05:701b:205b:10b0:169:9f67:a91b with SMTP id
 a92af1059eb24-18511eb675dmr13940555c88.12.1792479725951; 
 Tue, 20 Oct 2026 00:02:05 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm38294225c88.4.2026.10.20.00.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:02:05 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:31:49 +0530
Subject: [PATCH v2 2/2] qcom: capsule: build fw_images[] dynamically from
 the partition table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-qcom-capsule-dynamic-fw-images-v2-2-3824f7a66e1e@oss.qualcomm.com>
References: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
In-Reply-To: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792479710; l=31017;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=A+nzG8lmhQgSPM0gKjFfez3IPNt3SpZws7qVYoaYnlI=;
 b=scFgwU/tnjKegcXLK4vvqPowkKDxinMioeg7QesxUbHzarslBhbADMNE7U4tYhScDFeKqyiiO
 cUmXIL2TS9pC2aZjrw6AKX4a7VYlZmHJmZr2tKFFv8qaH8kF48I8/ub
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: sMrF62-NBE-yIcf6OBLI-hwqhSHz4zOB
X-Proofpoint-ORIG-GUID: sMrF62-NBE-yIcf6OBLI-hwqhSHz4zOB
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad711f0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=tQ-cCVJQs4C4rnHrT3cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyNyBTYWx0ZWRfX+lUO8TaF25Vj
 3SbQW0/ozIguKzJEGZK1DocByi/4f3cV7s1PbK2VtCzePc0ENb9jF6LdFxDNdIPnUsCo3YgFcOK
 s2tbqyq/csMgs6QNhFfKKuVtZuRA2i80tYQrPgr6NrJngrlIVOQFDNLwhBBI7UCzeAlOWeg4uqg
 HKn6gFMWqu5jn9zLfhJyBtekXpfBxUzgitTuzR2nvLcc9Dg05EaWeZMTAnwuWb++smqrOUzP8dC
 sGW3+LW/DOkejASEDhyb9CNyHPEpUCezWbpk1dAksFgCxVkrw/j88L7qefZF1+6FgIa1qMnAhhB
 +yKBa/ICpuG0N4jDGDCVDf+dSy0215ZynNOKUutRDAw0whyso58eMaYIyN6xhbxsCDSUyzKu7Cc
 ndOxHsWO9AN/CGP0lTkbsNePrY18YNsPFEFzMCGuYCiEAMfGQHwxA3417B0eSl2W67mZBvfhv/o
 E1GJ+bgSBqtzmEjgyKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyNyBTYWx0ZWRfXxeGqamMh2Km3
 f6lvmq2ZLDOFyEBSy1adn5yP7/lOQ6hP1d74JRI3wHY48QnlH7eV3h+tju70BrEKfdvMRSkmAWm
 36wH8vTxVTzXAskIg/G0zVGh5o4JhRQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200027
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Capsule update on Qualcomm boards only handles U-Boot itself, found by
find_target_partition() and hardcoded as the sole fw_images[] entry.
There is no way to update other firmware components.

Add qcom_image_map[], which maps a partition base name to a firmware
name. Scan every partition on the probed block devices and add an entry
to fw_images[] and to the dfu_alt_info string for each map row that has
a matching partition. num_images is whatever was found, so a component
missing on a board is left out.

U-Boot's own image stays first. It is expressed as three rows gated on
the boot source, so the uefi-over-xbl priority and A/B slot selection of
find_target_partition() come out of the same scan.

Each component has a fixed image type GUID  so one capsule applies to
every board. image_index is assigned in order from 1, which keeps it
within 1..DescriptorCount and equal to the DFU alt number plus one.
The index in a capsule can then differ from it, so implement
efi_capsule_resolve_image_index() to find the image by its type GUID.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Assign image_index in order instead of using the per-component index
- Look up the image by GUID with efi_capsule_resolve_image_index()
- Use a fixed image type GUID per component
- Drop efi_firmware_get_dfu_alt_num() and the dfu_alt_num member
- Replace apdp with multiimgqti in qcom_image_map[]
---
 arch/arm/mach-snapdragon/capsule_update.c | 756 +++++++++++++++++++++---------
 1 file changed, 528 insertions(+), 228 deletions(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 586682434b7..833f9aa7aa1 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -21,35 +21,134 @@
 #include "qcom-priv.h"
 
 /*
- * To handle different variants like chainloaded U-Boot here we need to
- * build the fw_images array dynamically at runtime. These are the possible
- * implementations:
+ * fw_images[] and update_info are built at runtime from the board's GPT, as the
+ * updatable components and U-Boot's own partition vary per board.
  *
- * - Devices with U-Boot on the uefi_a/b partition
- * - Devices with U-Boot on the boot (a/b) partition
- * - Devices with U-Boot on the xbl (a/b) partition
+ * qcom_image_map[] maps partition base names to firmware names. image_index in
+ * fw_images[] is assigned in order and capsules are matched by image type GUID.
+ * U-Boot's own image is split into rows gated on the boot source: uefi/xbl (or
+ * the legacy "aboot" alias) when flashed as XBL, boot when chainloaded from ABL.
+ */
+
+/**
+ * struct qcom_image_map - maps a GPT partition to a capsule FMP image
+ * @partition_base: base partition name, without the _a/_b slot suffix
+ * @fw_name_base: slot-independent firmware name
+ * @image_index: identifies the row, one partition is selected per index. Index 1
+ *               is U-Boot's own image (the three rows below, one per boot)
+ * @boot_source: if non-zero, the row is only used for this qcom_boot_source
+ * @alias_base: optional second base name the row matches, slotted or bare
+ * @match_nonslotted: also match the bare @partition_base, for boards without A/B
+ *                    on U-Boot's partition
+ * @image_type_id: fixed image type GUID, so a capsule applies to every board
  *
- * Which partition actually has U-Boot on it is determined based on the
- * qcom_boot_source variable and additional logic in find_target_partition().
+ * Every row matches "<partition_base>_a" and "<partition_base>_b".
+ */
+struct qcom_image_map {
+	const char *partition_base;
+	const u16 *fw_name_base;
+	u8 image_index;
+	enum qcom_boot_source boot_source;
+	const char *alias_base;
+	bool match_nonslotted;
+	efi_guid_t image_type_id;
+};
+
+/*
+ * image_type_id of each component.
+ * The three U-Boot rows share one GUID since only one is selected per boot.
  */
-struct efi_fw_image fw_images[] = {
-	{
-		.image_index = 1,
-	},
+#define QCOM_UBOOT_IMAGE_TYPE_GUID \
+	EFI_GUID(0x400ffdcd, 0x22e0, 0x47e7, 0x9a, 0x23, 0xf1, 0x6e, 0xd9, 0x38, 0x23, 0x88)
+#define QCOM_XBL_IMAGE_TYPE_GUID \
+	EFI_GUID(0xdea0ba2c, 0xcbdd, 0x4805, 0xb4, 0xf9, 0xf4, 0x28, 0x25, 0x1c, 0x3e, 0x98)
+#define QCOM_XBL_CONFIG_IMAGE_TYPE_GUID \
+	EFI_GUID(0x5a325ae4, 0x4276, 0xb66d, 0x0a, 0xdd, 0x34, 0x94, 0xdf, 0x27, 0x70, 0x6a)
+#define QCOM_UEFI_SECAPP_IMAGE_TYPE_GUID \
+	EFI_GUID(0xbe8a7e08, 0x1b7a, 0x4cae, 0x99, 0x3a, 0xd5, 0xb7, 0xfb, 0x55, 0xb3, 0xc2)
+#define QCOM_TZ_IMAGE_TYPE_GUID \
+	EFI_GUID(0xa053aa7f, 0x40b8, 0x4b1c, 0xba, 0x08, 0x2f, 0x68, 0xac, 0x71, 0xa4, 0xf4)
+#define QCOM_HYP_IMAGE_TYPE_GUID \
+	EFI_GUID(0xe1a6a689, 0x0c8d, 0x4cc6, 0xb4, 0xe8, 0x55, 0xa4, 0x32, 0x0f, 0xbd, 0x8a)
+#define QCOM_AOP_IMAGE_TYPE_GUID \
+	EFI_GUID(0xd69e90a5, 0x4cab, 0x0071, 0xf6, 0xdf, 0xab, 0x97, 0x7f, 0x14, 0x1a, 0x7f)
+#define QCOM_DEVCFG_IMAGE_TYPE_GUID \
+	EFI_GUID(0xf65d4b16, 0x343d, 0x4e25, 0xaa, 0xfc, 0xbe, 0x99, 0xb6, 0x55, 0x6a, 0x6d)
+#define QCOM_QUPFW_IMAGE_TYPE_GUID \
+	EFI_GUID(0x21d1219f, 0x2ed1, 0x4ab4, 0x93, 0x0a, 0x41, 0xa1, 0x6a, 0xe7, 0x5f, 0x7f)
+#define QCOM_XBL_RAMDUMP_IMAGE_TYPE_GUID \
+	EFI_GUID(0x0382f197, 0xe41f, 0x4e84, 0xb1, 0x8b, 0x0b, 0x56, 0x4a, 0xea, 0xd8, 0x75)
+#define QCOM_CPUCP_IMAGE_TYPE_GUID \
+	EFI_GUID(0x1e8615bd, 0x6d8c, 0x41ad, 0xb3, 0xea, 0x50, 0xe8, 0xbf, 0x40, 0xe4, 0x3f)
+#define QCOM_SHRM_IMAGE_TYPE_GUID \
+	EFI_GUID(0xcb74ca22, 0x2f0d, 0x4b82, 0xa1, 0xd6, 0xc4, 0x21, 0x3f, 0x34, 0x8d, 0x73)
+#define QCOM_IMAGEFV_IMAGE_TYPE_GUID \
+	EFI_GUID(0x17911177, 0xc9e6, 0x4372, 0x93, 0x3c, 0x80, 0x4b, 0x67, 0x8e, 0x66, 0x6f)
+#define QCOM_MULTIIMGOEM_IMAGE_TYPE_GUID \
+	EFI_GUID(0xe126a436, 0x757e, 0x42d0, 0x8d, 0x19, 0x0f, 0x36, 0x2f, 0x7a, 0x62, 0xb8)
+#define QCOM_RPM_IMAGE_TYPE_GUID \
+	EFI_GUID(0x098df793, 0xd712, 0x413d, 0x9d, 0x4e, 0x89, 0xd7, 0x11, 0x77, 0x22, 0x28)
+#define QCOM_MULTIIMGQTI_IMAGE_TYPE_GUID \
+	EFI_GUID(0x846c6f05, 0xeb46, 0x4c0a, 0xa1, 0xa3, 0x36, 0x48, 0xef, 0x3f, 0x9d, 0x0e)
+
+static const struct qcom_image_map qcom_image_map[] = {
+	/*
+	 * U-Boot's own image (image_index 1), only one row is selected per boot:
+	 *  - boot_source gating separates the uefi/xbl rows from the boot row;
+	 *  - uefi is listed before xbl, so it wins when both partitions exist;
+	 *  - with no uefi, the xbl row claims the xbl partition before the
+	 *    component row below, as a partition can't be two images.
+	 * All rows share one image_type_id, so one capsule updates whichever
+	 * partition U-Boot booted from.
+	 */
+	{ "uefi", u"UBOOT_UEFI_PARTITION", 1, QCOM_BOOT_SOURCE_XBL,     NULL,    false,
+	  QCOM_UBOOT_IMAGE_TYPE_GUID },
+	{ "xbl",  u"UBOOT_XBL_PARTITION",  1, QCOM_BOOT_SOURCE_XBL,     "aboot", false,
+	  QCOM_UBOOT_IMAGE_TYPE_GUID },
+	{ "boot", u"UBOOT_BOOT_PARTITION", 1, QCOM_BOOT_SOURCE_ANDROID, NULL,    true,
+	  QCOM_UBOOT_IMAGE_TYPE_GUID },
+
+	{ "xbl",         u"QCOM-XBL",          2, 0, NULL, false,
+	  QCOM_XBL_IMAGE_TYPE_GUID },
+	{ "xbl_config",  u"QCOM-XBL-CONFIG",   3, 0, NULL, false,
+	  QCOM_XBL_CONFIG_IMAGE_TYPE_GUID },
+	{ "uefisecapp",  u"QCOM-UEFI-SECAPP",  4, 0, NULL, false,
+	  QCOM_UEFI_SECAPP_IMAGE_TYPE_GUID },
+	{ "tz",          u"QCOM-TZ",           5, 0, NULL, false,
+	  QCOM_TZ_IMAGE_TYPE_GUID },
+	{ "hyp",         u"QCOM-HYP",          6, 0, NULL, false,
+	  QCOM_HYP_IMAGE_TYPE_GUID },
+	{ "aop",         u"QCOM-AOP",          7, 0, NULL, false,
+	  QCOM_AOP_IMAGE_TYPE_GUID },
+	{ "devcfg",      u"QCOM-DEVCFG",       8, 0, NULL, false,
+	  QCOM_DEVCFG_IMAGE_TYPE_GUID },
+	{ "qupfw",       u"QCOM-QUPFW",        9, 0, NULL, false,
+	  QCOM_QUPFW_IMAGE_TYPE_GUID },
+	{ "xbl_ramdump", u"QCOM-XBL-RAMDUMP", 10, 0, NULL, false,
+	  QCOM_XBL_RAMDUMP_IMAGE_TYPE_GUID },
+	{ "cpucp",       u"QCOM-CPUCP",       11, 0, NULL, false,
+	  QCOM_CPUCP_IMAGE_TYPE_GUID },
+	{ "shrm",        u"QCOM-SHRM",        12, 0, NULL, false,
+	  QCOM_SHRM_IMAGE_TYPE_GUID },
+	{ "imagefv",     u"QCOM-IMAGEFV",     13, 0, NULL, false,
+	  QCOM_IMAGEFV_IMAGE_TYPE_GUID },
+	{ "multiimgoem", u"QCOM-MULTIIMGOEM", 14, 0, NULL, false,
+	  QCOM_MULTIIMGOEM_IMAGE_TYPE_GUID },
+	{ "multiimgqti", u"QCOM-MULTIIMGQTI", 15, 0, NULL, false,
+	  QCOM_MULTIIMGQTI_IMAGE_TYPE_GUID },
+	{ "rpm",         u"QCOM-RPM",         16, 0, NULL, false,
+	  QCOM_RPM_IMAGE_TYPE_GUID },
 };
 
+static struct efi_fw_image fw_images[ARRAY_SIZE(qcom_image_map)];
+
 struct efi_capsule_update_info update_info = {
-	/* Filled in by configure_dfu_string() */
 	.dfu_string = NULL,
-	.num_images = ARRAY_SIZE(fw_images),
+	.num_images = 0,
 	.images = fw_images,
 };
 
-enum target_part_type {
-	TARGET_PART_UEFI = 1,
-	TARGET_PART_XBL,
-	TARGET_PART_BOOT,
-};
+#define QCOM_DFU_STRING_LEN	(64 * ARRAY_SIZE(qcom_image_map))
 
 /* LSB first */
 struct part_slot_status {
@@ -67,21 +166,6 @@ enum ab_slot {
 	SLOT_B,
 };
 
-static enum ab_slot get_part_slot(const char *partname)
-{
-	int len = strlen(partname);
-
-	if (partname[len - 2] != '_')
-		return SLOT_NONE;
-	if (partname[len - 1] == 'a')
-		return SLOT_A;
-	if (partname[len - 1] == 'b')
-		return SLOT_B;
-
-	return SLOT_NONE;
-}
-
-/* Shamelessly copied from lib/efi_loader/efi_device_path.c @ 33 */
 /*
  * Determine if an MMC device is an SD card.
  *
@@ -98,206 +182,389 @@ static bool is_sd(struct blk_desc *desc)
 	return IS_SD(mmc) != 0U;
 }
 
+/**
+ * struct qcom_partition_info - a selected partition for one component
+ * @name: partition name as found on disk, e.g. "tz_a"
+ * @part_num: partition number on the block device
+ * @devnum: block device number @name lives on
+ * @uclass_id: uclass (UCLASS_SCSI/UCLASS_MMC) of @devnum. Used with @devnum to
+ *             group partitions on different LUNs in the DFU string
+ * @fw_name: slot-independent FMP name (from the matched map row)
+ * @image_index: index of the matched map row
+ * @image_type_id: image type GUID of the matched map row
+ */
+struct qcom_partition_info {
+	char name[32];
+	u32 part_num;
+	int devnum;
+	enum uclass_id uclass_id;
+	const u16 *fw_name;
+	u8 image_index;
+	efi_guid_t image_type_id;
+};
+
+static struct qcom_partition_info qcom_partitions[ARRAY_SIZE(qcom_image_map)];
+
+/**
+ * struct qcom_slot_cand - one candidate partition for a map row's slot
+ * @part_num: partition number, or -1 if no partition filled this slot
+ * @active: A/B "active" flag from the partition's slot status
+ * @devnum: block device number the partition was found on
+ * @uclass_id: uclass of that block device
+ * @name: partition name as found on disk
+ */
+struct qcom_slot_cand {
+	int part_num;
+	bool active;
+	int devnum;
+	enum uclass_id uclass_id;
+	char name[32];
+};
+
+/**
+ * struct qcom_row_cand - candidate partitions for one qcom_image_map[] row
+ * @slot: indexed by enum ab_slot (SLOT_NONE for a non-slotted/alias-bare match)
+ */
+struct qcom_row_cand {
+	struct qcom_slot_cand slot[3];
+};
+
 /*
- * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
- * the slot status, and prioritizing the uefi partition over xbl if found.
+ * Candidates for every scanned block device, one entry per qcom_image_map[] row.
+ */
+static struct qcom_row_cand qcom_cands[ARRAY_SIZE(qcom_image_map)];
+
+/**
+ * qcom_match_partition() - test a partition name against a map row
+ * @name: partition name as found on disk
+ * @map: candidate map row
+ * @slot: output, which A/B slot (SLOT_NONE for a non-slotted / bare-alias match)
+ *
+ * Every row matches "<partition_base>_a"/"<partition_base>_b". U-Boot's rows
+ * may also match a bare non-slotted name (@match_nonslotted) and a legacy alias
+ * base (@alias_base, both slotted and bare).
+ *
+ * Return: true if @name belongs to @map
+ */
+static bool qcom_match_partition(const char *name,
+				 const struct qcom_image_map *map,
+				 enum ab_slot *slot)
+{
+	char cand[36];
+
+	snprintf(cand, sizeof(cand), "%s_a", map->partition_base);
+	if (!strcmp(name, cand)) {
+		*slot = SLOT_A;
+		return true;
+	}
+	snprintf(cand, sizeof(cand), "%s_b", map->partition_base);
+	if (!strcmp(name, cand)) {
+		*slot = SLOT_B;
+		return true;
+	}
+	if (map->match_nonslotted && !strcmp(name, map->partition_base)) {
+		*slot = SLOT_NONE;
+		return true;
+	}
+
+	if (map->alias_base) {
+		snprintf(cand, sizeof(cand), "%s_a", map->alias_base);
+		if (!strcmp(name, cand)) {
+			*slot = SLOT_A;
+			return true;
+		}
+		snprintf(cand, sizeof(cand), "%s_b", map->alias_base);
+		if (!strcmp(name, cand)) {
+			*slot = SLOT_B;
+			return true;
+		}
+		if (!strcmp(name, map->alias_base)) {
+			*slot = SLOT_NONE;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * qcom_scan_device() - record candidate partitions on one block device
+ * @desc: block device to scan
+ * @cands: candidate table, one entry per qcom_image_map[] row
+ *
+ * Each partition on @desc is checked against every eligible row (those whose
+ * boot_source matches qcom_boot_source) and recorded in that row's slot. One
+ * partition can match several rows, e.g. "xbl_a" matches both the U-Boot xbl
+ * row and the xbl component row.
+ *
+ * The first device wins if a partition table is exposed more than once, e.g.
+ * mirrored UFS boot LUNs. The table is global so qcom_resolve_images() can apply
+ * the uefi-over-xbl priority across LUNs.
  */
-static int find_target_partition(int *devnum, enum uclass_id *uclass,
-				 enum target_part_type *target_part_type)
+static void qcom_scan_device(struct blk_desc *desc, struct qcom_row_cand *cands)
 {
-	int ret;
-	int partnum, uefi_partnum = -1, xbl_partnum = -1;
 	struct disk_partition info;
 	struct part_slot_status *slot_status;
-	struct udevice *dev = NULL;
-	struct blk_desc *desc = NULL, *xbl_desc = NULL;
-	uchar ptn_name[32] = { 0 };
-	bool have_ufs = false;
+	int partnum, i;
 
-	/*
-	 * Check to see if we have UFS storage, if so U-Boot MUST be on it and we can skip
-	 * all non-UFS block devices
-	 */
-	uclass_foreach_dev_probe(UCLASS_UFS, dev) {
-		have_ufs = true;
-		break;
-	}
+	for (partnum = 1; !part_get_info(desc, partnum, &info); partnum++) {
+		slot_status = (struct part_slot_status *)&info.type_flags;
 
-	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
-		if (device_get_uclass_id(dev) != UCLASS_BLK)
-			continue;
+		for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+			const struct qcom_image_map *m = &qcom_image_map[i];
+			struct qcom_slot_cand *c;
+			enum ab_slot slot;
 
-		desc = dev_get_uclass_plat(dev);
+			if (m->boot_source && m->boot_source != qcom_boot_source)
+				continue;
+			if (!qcom_match_partition((char *)info.name, m, &slot))
+				continue;
 
-		/* If we have a UFS then don't look at any other block devices */
-		if (have_ufs) {
-			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
+			c = &cands[i].slot[slot];
+			if (c->part_num >= 0)	/* first device wins */
 				continue;
+
+			c->part_num = partnum;
+			c->active = !!slot_status->active;
+			c->devnum = desc->devnum;
+			c->uclass_id = desc->uclass_id;
+			strlcpy(c->name, (char *)info.name, sizeof(c->name));
 		}
-		/*
-		 * If we don't have UFS, then U-Boot must be on the eMMC
-		 */
-		else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
-			log_debug("skipped SD-Card (devnum %d)\n", desc->devnum);
+	}
+}
+
+/**
+ * qcom_pick_slot() - choose the best candidate slot for a map row
+ * @rc: candidate slots for one row
+ *
+ * Priority: active A > active B > non-slotted > inactive A > inactive B.
+ *
+ * Return: the chosen enum ab_slot, or -1 if no candidate was recorded
+ */
+static int qcom_pick_slot(const struct qcom_row_cand *rc)
+{
+	if (rc->slot[SLOT_A].part_num >= 0 && rc->slot[SLOT_A].active)
+		return SLOT_A;
+	if (rc->slot[SLOT_B].part_num >= 0 && rc->slot[SLOT_B].active)
+		return SLOT_B;
+	if (rc->slot[SLOT_NONE].part_num >= 0)
+		return SLOT_NONE;
+	if (rc->slot[SLOT_A].part_num >= 0)
+		return SLOT_A;
+	if (rc->slot[SLOT_B].part_num >= 0)
+		return SLOT_B;
+
+	return -1;
+}
+
+/**
+ * qcom_resolve_images() - pick one partition per map row from the candidates
+ * @cands: candidate table filled by qcom_scan_device() across every device
+ * @partitions: output array; room for ARRAY_SIZE(qcom_image_map) entries
+ *
+ * Walks qcom_image_map[] in order, so U-Boot's own image lands in partitions[0].
+ * Two dedup rules:
+ *
+ *  1. One partition per image_index. The U-Boot rows share index 1, so the first
+ *     one with a candidate wins (uefi before xbl).
+ *  2. A physical partition is claimed once. With U-Boot on xbl and no uefi, the
+ *     U-Boot xbl row takes the partition and the xbl component row is skipped.
+ *
+ * A row with no candidate is left out, so num_images varies per board.
+ *
+ * Return: number of partitions written to @partitions
+ */
+static u32 qcom_resolve_images(struct qcom_row_cand *cands,
+			       struct qcom_partition_info *partitions)
+{
+	u32 count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+		const struct qcom_image_map *m = &qcom_image_map[i];
+		struct qcom_slot_cand *c;
+		struct qcom_partition_info *p;
+		bool dup = false;
+		int sel;
+		u32 j;
+
+		if (m->boot_source && m->boot_source != qcom_boot_source)
 			continue;
-		}
 
-		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
+		sel = qcom_pick_slot(&cands[i]);
+		if (sel < 0)
 			continue;
-		for (partnum = 1;; partnum++) {
-			ret = part_get_info(desc, partnum, &info);
-			if (ret)
+		c = &cands[i].slot[sel];
+
+		/* rule 1: one selected partition per image_index */
+		for (j = 0; j < count; j++) {
+			if (partitions[j].image_index == m->image_index) {
+				dup = true;
 				break;
+			}
+		}
+		if (dup)
+			continue;
 
-			slot_status = (struct part_slot_status *)&info.type_flags;
-
-			/*
-			 * Qualcomm Linux devices have a "uefi" partition, it's A/B but the
-			 * flags might not be set so we assume the A partition unless the B
-			 * partition is active.
-			 */
-			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
-				/*
-				 * If U-Boot was chainloaded somehow we can't be flashed to
-				 * the uefi partition
-				 */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
-					continue;
-
-				*target_part_type = TARGET_PART_UEFI;
-				/*
-				 * Found an active UEFI partition, this is where U-Boot is
-				 * flashed.
-				 */
-				if (slot_status->active)
-					goto found;
-
-				/* Prefer A slot if it's not marked active */
-				if (get_part_slot(info.name) == SLOT_A) {
-					/*
-					 * If we found the A slot after the B slot (both
-					 * inactive) then we assume U-Boot is on the A slot.
-					 */
-					if (uefi_partnum >= 0)
-						goto found;
-
-					/* Didn't find the B slot yet */
-					uefi_partnum = partnum;
-					strlcpy(ptn_name, info.name, 32);
-				} else {
-					/*
-					 * Found inactive B slot after inactive A slot, return
-					 * the A slot
-					 */
-					if (uefi_partnum >= 0) {
-						partnum = uefi_partnum;
-						goto found;
-					}
-
-					/*
-					 * Didn't find the A slot yet. Record that we found the
-					 * B slot
-					 */
-					uefi_partnum = partnum;
-					strlcpy(ptn_name, info.name, 32);
-				}
-				/* xbl and aboot are effectively the same */
-			} else if ((!strncmp(info.name, "xbl", strlen("xbl")) &&
-				    strlen(info.name) == 5) ||
-				    !strncmp(info.name, "aboot", strlen("aboot"))) {
-				/*
-				 * If U-Boot was booted via ABL, we can't be flashed to the
-				 * XBL partition
-				 */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
-					continue;
-
-				/*
-				 * ignore xbl partition if we have uefi partitions, U-Boot will
-				 * always be on the UEFI partition in this case.
-				 */
-				if (*target_part_type == TARGET_PART_UEFI)
-					continue;
-
-				/* Either non-A/B or find the active XBL partition */
-				if (slot_status->active || !get_part_slot(info.name)) {
-					/*
-					 * No quick return since we might find a uefi partition
-					 * later
-					 */
-					xbl_partnum = partnum;
-					*target_part_type = TARGET_PART_XBL;
-					xbl_desc = desc;
-					strlcpy(ptn_name, info.name, 32);
-				}
-
-				/*
-				 * No fast return since we might also have a uefi partition which
-				 * will take priority.
-				 */
-			} else if (!strncmp(info.name, "boot", strlen("boot"))) {
-				/* We can only be flashed to boot if we were chainloaded */
-				if (qcom_boot_source != QCOM_BOOT_SOURCE_ANDROID)
-					continue;
-
-				/*
-				 * Either non-A/B or find the active partition. We can return
-				 * immediately here since we've narrowed it down to a single option
-				 */
-				if (slot_status->active || !get_part_slot(info.name)) {
-					*target_part_type = TARGET_PART_BOOT;
-					goto found;
-				}
+		/* rule 2: never claim the same physical partition twice */
+		for (j = 0; j < count; j++) {
+			if (partitions[j].devnum == c->devnum &&
+			    partitions[j].uclass_id == c->uclass_id &&
+			    partitions[j].part_num == (u32)c->part_num) {
+				dup = true;
+				break;
 			}
 		}
-	}
+		if (dup)
+			continue;
 
-	/*
-	 * Now we've exhausted all options, if we didn't find a uefi partition
-	 * then we are indeed flashed to the xbl partition.
-	 */
-	if (*target_part_type == TARGET_PART_XBL) {
-		partnum = xbl_partnum;
-		desc = xbl_desc;
-		goto found;
+		p = &partitions[count++];
+		strlcpy(p->name, c->name, sizeof(p->name));
+		p->part_num = c->part_num;
+		p->devnum = c->devnum;
+		p->uclass_id = c->uclass_id;
+		p->fw_name = m->fw_name_base;
+		p->image_index = m->image_index;
+		guidcpy(&p->image_type_id, &m->image_type_id);
+
+		log_debug("qcom capsule: %s -> image %u (part %u, dev %d)\n",
+			  p->name, p->image_index, p->part_num, p->devnum);
 	}
 
-	/* Found no candidate partitions */
-	return -1;
+	return count;
+}
 
-found:
-	if (desc) {
-		*devnum = desc->devnum;
-		*uclass = desc->uclass_id;
+/**
+ * qcom_build_fw_images() - populate fw_images[] from the discovered partitions
+ * @partitions: partitions from qcom_resolve_images(); entry 0 is U-Boot's own
+ *              image (image_index 1), the rest are components
+ * @num_partitions: number of valid entries in @partitions
+ *
+ * One fw_images[] entry per partition, in the same order, so fw_images[] and
+ * @partitions stay index-aligned. .image_index is assigned sequentially
+ * (1..@num_partitions) as UEFI requires 1 <= ImageIndex <= DescriptorCount.
+ * .image_type_id is copied from the map row. As entry 0 is then non-zero,
+ * efi_gen_capsule_guids() leaves the table alone.
+ *
+ * Return: number of images written (equal to @num_partitions)
+ */
+static u32 qcom_build_fw_images(const struct qcom_partition_info *partitions,
+				u32 num_partitions)
+{
+	u32 i;
+
+	for (i = 0; i < num_partitions; i++) {
+		fw_images[i].fw_name = (u16 *)partitions[i].fw_name;
+		fw_images[i].image_index = i + 1;
+		guidcpy(&fw_images[i].image_type_id, &partitions[i].image_type_id);
 	}
 
-	/* info won't match for XBL hence the copy. */
-	log_info("Capsule update target: %s (disk %d:%d)\n",
-		 *target_part_type == TARGET_PART_BOOT ? info.name : ptn_name,
-		 *devnum, partnum);
-	return partnum;
+	return num_partitions;
 }
 
 /**
- * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
+ * qcom_build_dfu_string() - build the dfu_alt_info string for the partitions
+ * @partitions: partitions accumulated across every scanned block device
+ * @num_partitions: number of valid entries in @partitions; also the number of
+ *                  valid fw_images[] entries, with matching indices
+ * @buf: output buffer
+ * @buf_size: size of @buf
+ *
+ * Builds an "interface devstring=alt;alt&interface devstring=alt" string (see
+ * dfu_config_interfaces()), with '&' between devices. efi_firmware_raw_set_image()
+ * passes a NULL interface, which forces this multi-interface parser, so a
+ * single-group string would drop every partition after the first LUN.
  *
- * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
- * are two boot partitions, boot_a and boot_b. As we don't currently support doing
- * full A/B updates, we only support updating the currently active boot partition.
+ * Tokens are appended in @partitions order, so the DFU alt number of each
+ * image is its image_index - 1, as efi_firmware_raw_set_image() expects.
+ *
+ * Return: true on success, false if @buf was too small
+ */
+static bool qcom_build_dfu_string(struct qcom_partition_info *partitions,
+				  u32 num_partitions, char *buf, size_t buf_size)
+{
+	int prev_devnum = -1;
+	enum uclass_id prev_uclass_id = UCLASS_INVALID;
+	u32 i;
+	size_t len;
+
+	buf[0] = '\0';
+	len = 0;
+
+	for (i = 0; i < num_partitions; i++) {
+		struct qcom_partition_info *p = &partitions[i];
+		char token[48];
+		bool new_group = p->devnum != prev_devnum ||
+				  p->uclass_id != prev_uclass_id;
+
+		if (new_group) {
+			char prefix[24];
+
+			if (i != 0)
+				len = strlcat(buf, "&", buf_size);
+
+			switch (p->uclass_id) {
+			case UCLASS_SCSI:
+				snprintf(prefix, sizeof(prefix), "scsi %d=", p->devnum);
+				break;
+			case UCLASS_MMC:
+				snprintf(prefix, sizeof(prefix), "mmc %d=", p->devnum);
+				break;
+			default:
+				log_err("qcom capsule: unsupported storage uclass %d for %s\n",
+					p->uclass_id, p->name);
+				return false;
+			}
+			len = strlcat(buf, prefix, buf_size);
+		} else {
+			len = strlcat(buf, ";", buf_size);
+		}
+
+		if (p->uclass_id == UCLASS_MMC)
+			snprintf(token, sizeof(token), "%s part %u %u",
+				 p->name, p->devnum, p->part_num);
+		else
+			snprintf(token, sizeof(token), "%s part %u",
+				 p->name, p->part_num);
+		len = strlcat(buf, token, buf_size);
+
+		if (len >= buf_size) {
+			log_err("qcom capsule: dfu_alt_info string truncated\n");
+			return false;
+		}
+
+		prev_devnum = p->devnum;
+		prev_uclass_id = p->uclass_id;
+	}
+
+	return true;
+}
+
+/**
+ * qcom_configure_capsule_updates() - Configure the DFU string and fw_images[]
+ * for capsule updates
  *
- * So we need to find the current slot suffix and the associated boot partition.
- * We do this by looking for the boot partition that has the 'active' flag set
- * in the GPT partition vendor attribute bits.
+ * Scans every probed block device and builds fw_images[] and the matching
+ * dfu_alt_info string.
  */
 void qcom_configure_capsule_updates(void)
 {
-	int ret = 0, partnum = -1, devnum;
-	static char dfu_string[32] = { 0 };
-	enum target_part_type target_part_type = 0;
-	enum uclass_id dev_uclass;
+	static char dfu_string[QCOM_DFU_STRING_LEN];
+	struct qcom_partition_info *partitions = qcom_partitions;
+	u32 num_partitions;
+	struct udevice *dev;
+	bool have_ufs = false;
+	int i, ret;
+
+	memset(qcom_cands, 0, sizeof(qcom_cands));
+	for (i = 0; i < ARRAY_SIZE(qcom_image_map); i++) {
+		qcom_cands[i].slot[SLOT_NONE].part_num = -1;
+		qcom_cands[i].slot[SLOT_A].part_num = -1;
+		qcom_cands[i].slot[SLOT_B].part_num = -1;
+	}
+	memset(partitions, 0, sizeof(qcom_partitions));
 
 	if (IS_ENABLED(CONFIG_SCSI)) {
-		/* Scan for SCSI devices */
 		ret = scsi_scan(false);
 		if (ret) {
 			debug("Failed to scan SCSI devices: %d\n", ret);
@@ -305,41 +572,74 @@ void qcom_configure_capsule_updates(void)
 		}
 	}
 
-	partnum = find_target_partition(&devnum, &dev_uclass, &target_part_type);
-	if (partnum < 0) {
-		log_err("Failed to find boot partition\n");
-		return;
-	}
-
 	/*
-	 * Set the fw_name based on the partition type. This causes the GUID to be different
-	 * so we will never accidentally flash a U-Boot image intended for XBL to the boot
-	 * partition.
+	 * Check to see if we have UFS storage, if so firmware MUST be on it and
+	 * we can skip all non-UFS block devices.
 	 */
-	switch (target_part_type) {
-	case TARGET_PART_UEFI:
-		fw_images[0].fw_name = u"UBOOT_UEFI_PARTITION";
-		break;
-	case TARGET_PART_XBL:
-		fw_images[0].fw_name = u"UBOOT_XBL_PARTITION";
-		break;
-	case TARGET_PART_BOOT:
-		fw_images[0].fw_name = u"UBOOT_BOOT_PARTITION";
+	uclass_foreach_dev_probe(UCLASS_UFS, dev) {
+		have_ufs = true;
 		break;
 	}
 
-	switch (dev_uclass) {
-	case UCLASS_SCSI:
-		snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
-		break;
-	case UCLASS_MMC:
-		snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
-		break;
-	default:
-		debug("Unsupported storage uclass: %d\n", dev_uclass);
+	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+		struct blk_desc *desc;
+
+		if (device_get_uclass_id(dev) != UCLASS_BLK)
+			continue;
+
+		desc = dev_get_uclass_plat(dev);
+
+		/* If we have a UFS then don't look at any other block devices */
+		if (have_ufs) {
+			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
+				continue;
+		} else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
+			/* If we don't have UFS, then firmware is on the eMMC */
+			log_debug("skipped SD-Card (devnum %d)\n", desc->devnum);
+			continue;
+		}
+
+		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
+			continue;
+
+		qcom_scan_device(desc, qcom_cands);
+	}
+
+	num_partitions = qcom_resolve_images(qcom_cands, partitions);
+	if (!num_partitions) {
+		log_err("qcom capsule: no updatable partitions found\n");
 		return;
 	}
-	log_debug("DFU string: '%s'\n", dfu_string);
+	if (partitions[0].image_index != 1)
+		log_warning("qcom capsule: U-Boot's own partition not found; configuring components only\n");
+
+	qcom_build_fw_images(partitions, num_partitions);
+	if (!qcom_build_dfu_string(partitions, num_partitions, dfu_string,
+				   sizeof(dfu_string)))
+		return;
+
+	log_debug("dfu_alt_info: %s\n", dfu_string);
 
+	update_info.num_images = num_partitions;
 	update_info.dfu_string = dfu_string;
 }
+
+/**
+ * efi_capsule_resolve_image_index() - find the fw_images[] index for a capsule
+ * @image_type: image type GUID from the capsule
+ * @capsule_index: image index from the capsule
+ *
+ * Return: image_index of the entry matching @image_type, else @capsule_index
+ */
+u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
+				   u8 capsule_index)
+{
+	int i;
+
+	for (i = 0; i < update_info.num_images; i++) {
+		if (!guidcmp(&update_info.images[i].image_type_id, image_type))
+			return update_info.images[i].image_index;
+	}
+
+	return capsule_index;
+}

-- 
2.34.1

