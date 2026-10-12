Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A194CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CDEC80CBD;
	Mon, 12 Oct 2026 13:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94eYcWmlOWIa; Mon, 12 Oct 2026 13:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F67A80DBB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812221;
	b=H177o+2nIyzAM/mpDmZx3OyuLHF25teTPfZAbYUzhLTkA4YTfBfOpkyEYhw1c8Hqx/p7
	 PkD+J57rGIREkHt/1xfDsfnnPauOJHESGeJOl6eZPKc/wmPDWilfw/79ABtYlXMc16JlD
	 E19FDiIIStkSyafFXQVeKWtINsWaGbin6R7ia1S7DyfGjkDDH2Uq3tyeNhnDF0Yr1wjmO
	 NeXItTgmMhSNZHdtup9evtfXF53yv5zVJ2Bc1QFn1pNYJUWOJHtADKJ+GDia3oF0SEMj0
	 a9O8g/UMDrqcvSkScqbkFL0dKsSdETXkJoo+4UnY8cTRmThGjC3hqhIcT5ZXSaMIjqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812221;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KNcNiQ9oyP+KjU+k2ndbGm0+pDkQd88DFWNVBcxdQPs=;
	b=i7e+d5VrW/wiuWnqWWl7D0JbSne11rhvt4b3At7fvZkIFnoRgy9yKuRjrfn+0GVowQ8l
	 qpM5/97lxgz72gyUPDtokllSU1a/ek9gKHLibCXabN05mAP+Syk5igHFCIkL2EAXxCflG
	 EhTvV9TQF9Ala1yLrPfS9WNzLS/kk568t2+xOmScE1MOVh4728dErSIC0FKJO0V48PgEt
	 Tqu0HZcgMg2gplj4sxHLqeJ78INPRWhHJQwKDgMbEEnc2FXrJDcuqaazxXqrdQFaYJQuQ
	 nRdBLLnQZ8u2my2rX6+J3mfpRvMYLfFbr3wJotkXJ5GqmBVfqEa4KqBVx889sW7tgFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bnR4k5Pq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jtiXIk25;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791812221;
	bh=KNcNiQ9oyP+KjU+k2ndbGm0+pDkQd88DFWNVBcxdQPs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W0+hof5fSqkZiWzFRJOv1Ai1b7P4trNCfZGG5E2LZmEXqyT8fp3IgfBxqXUfuZfEL
	 H6uK5ncHK/R6d2/ZrqaddpGHiZ4k6C7C7nzxe5+HCr5osan7tNLrIProw5C9FLI0DS
	 eyKYHx748I9saRfISaJXmtnoQdX4rHs8Aunl5sY4xCqZ4Mgvi/wTXqdtHGZ9JTWjR7
	 fU2GiCKOkkWYzVrouh04FVGBEiosMM3444oXAty7Hd67LDChLwA3DzkkV5wq3p3CJo
	 vg1HsViOhCmiANrIc7mS99Iq2JfBkisKY36wvBzHxjQhVdqDi8bhQ9J+/oQYTKmkHX
	 sxeRIUZ1u4uJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F67A80DBB;
	Mon, 12 Oct 2026 13:37:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA2109DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7A8D80DBB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TCMOkRriPM8H for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30C2A80CBD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812219;
 b=G6AE7bF5Wok6cgjjmWr6/kRTS/63TBcyxib7u/LrfLrwy+EfVjuoskfZxMfIGvhr1/3p
 DEn/NWK5Xq5moWcIJJZDAwh3SMNrao0WBrJ0f6+vDrPSUypoINcZTT6OsNTPE/ZJELB81
 YtaVTCUL3r4yFgRzTDbkDSYXKKdKA41IGlKr22B0KDZ3r+A5WEAAFg1761NRPLBzPLu8K
 LrCYPTvJ1pGv1znm7i3E83unby20UdavswnwBZWaMrpPred1O1TsOwoWcNVX9ZhAvXgRT
 tcZq1QMcXN0xci75CeJ4xaQN20Mpso55hYNtglHztULI9DJ8JODUFhnKIE1h+Nlimvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812219;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=KNcNiQ9oyP+KjU+k2ndbGm0+pDkQd88DFWNVBcxdQPs=;
 b=WUWppNxIMbsbeZwgUHOZn2M/0bCSLLxikbt0dzljdYuQEnoeTm9A+RyZUOskCo9hbLx9
 cDfmiUZuzAPY5Z56TYh67Tvz89JXJdGan8dLi9jRkodz1nH8Hydf9VFLz9AjL02+Zjuu1
 T5ByZbEkPdNOby6uwXnoAjfFaap/mNRuzSFgX5D9NVR0TJozq8ovvgzXI7t7VPTia7mxD
 B45hlGdwMRSCJloMq+zZqVrA1Wc8EkQlWnGjCKOPvj5b8c9k2yyTKpy6pqkwv/2c93zfx
 9JlKHIVEnoMGO1kns36WSq3MPNIk/bYLCLWFlLMyLq0fQ32gL3q4FnPs3ggUTs12MWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=bnR4k5Pq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jtiXIk25; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bnR4k5Pq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jtiXIk25
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30C2A80CBD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC01TN1405000
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KNcNiQ9oyP+
 KjU+k2ndbGm0+pDkQd88DFWNVBcxdQPs=; b=bnR4k5PqHvD7jcU8xKG+U+db8kD
 zlUMGjrqb7k3T9ii3nEzDaJpTOidafIlBEltWZKh9S9V3JlUn3MSW89hD1VGguKj
 mELu4DIrU3orO9tNNJwh1815jMDgLwypvvHC+hLKY6j7rk8c6igahcM3SAxLRh5m
 lnSAWB5w0vYhPhfRs/XeMYhbiXgERLzch80tByCfa4CVmT7Ss3TD/3hq0cr0zOzX
 KzCVVjvP6YaCR6TXCOUlScrjEU6bYXMX8NDB+XcUZaFIFcF1pj9rc6XtuydcRYE3
 AuVUjV3EFppDvGDdTB+X1cYVciv3bkzVIy9qF3c5mXdr7gyEKBy31yAF6ZQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ksa9e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3515266f6eeso3635394eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812217; x=1792417017;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KNcNiQ9oyP+KjU+k2ndbGm0+pDkQd88DFWNVBcxdQPs=;
 b=jtiXIk2571d6I/GveBPg15dm/GZxgZhKrEgUgjQc1gezYr9lsl9nvjJYR9H/h2erPL
 1V46w5TfmULTSxk2hWnKq/ScRjXclQYgZNClAUxu6KjDHFA0SnzuuFBYKctYOs5XCqbG
 X2hUjZR2V9bi4Lw5lzsqi5aOy7iLhKGadGyQkgPKtVc7PACKbQe4xDmk3nh2dnownOPK
 H/fR7qmDz9N1KMAVLerqEwr1rDE3j9M0mvSxhe/hYq17j/P77eZAvl7cRV+nIBIXc64h
 b9vJm4W6pyIA/kzIs7irLOpnCtGL0kyIaRKINNEpjiurn0wihLjAGytBjHVJ+WkjwIrV
 D82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812217; x=1792417017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KNcNiQ9oyP+KjU+k2ndbGm0+pDkQd88DFWNVBcxdQPs=;
 b=bPqwZ7yzS2oVEcjiR43ta9/5+rduaGOl3chEc8axNazVGV2YezvS8CiM7lZJgxTtT6
 k1NIiVzh6u1o2q/1NgcNZvJOrCRYMWit4KB9fk797twIbHh2WafoWvI/FZ/+jGTPdZtJ
 9BigtnUWvQ97RcDHEjGLCtlxxDMOhGQwVqud5IImxTgJfdCvlzvyNY5ZKeEGGl2quURl
 k0s1OEOz4fCja2rTOTS7o4WPcBXJo17tiOtJ7Rwww27hr2ZfAlJWcehwwsHP75e8CJlv
 YrQ2MRaeAgSMlrj9HxJIRGml3afidMTVncY69prBMXlvE5r3+ijqLa7pB6Gk0/H8kvAk
 1AIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzo3YQAaYV7ElY/AO+CtstMXxT/g9U7VTd+Vxij4UAQsGQ0YAvYDIoImT9ltCi3gySCK20fJQY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI3jq9G5XFJ8NB+l0RWUxT00egdZ31Om2XSclIFdLbpyvRhFwGW
 vXJLxDES6OpU8ffyenobx+HkEPHg3gD6BLCBiXJ0WdcbmVuToMfOPl08xPR92jZG7XcFILO7hcp
 xqaV7KwTYWt+Pj0ysL66QLOtQOv7U6bdfZ1M5EutFerKjBk/9javNSUo3z6QGw0dt1TikV6Y=
X-Gm-Gg: AYBFou3aYyJC0StinfTc6p0GJIkpJzLA28lOy4P3Ioa0qvYmHyN5Qb5HRt/6yPJsoT2
 hLhSpOKT7Vo+zwKfdELSQbYJLimr6+FJZqyJeriVpknBz73Qa0HA76bYU9TmdVDh2d0+0bADVDZ
 R9Vrany6eb0SL2jRFE4AU3k9EAzC8oUnZtqVJD9XYs7zYsgtGed2t4vjnEN2ZZ9MYOQ92Jfdx3o
 PtSnkNn1dtg/2o6eOZDz1S2jzsZDD/tXWaCMLbj64+nSKFA2BwJZlRW08yLdMMAXC9gWzHC93qQ
 C/pldVmCY2bfgejiXlqTjmAUmr/M8ajvzd+Xa3+lvkufpAh88nXDUkI8e5AD6Zv15U7u6FPhSfn
 +FyIoWR7iVrKHnhG6K8Tni3Sj0GhLhYeT8CuKFrdVBAdTsNAQcaeB7ufmanww3r4N0CiCNlaRUR
 tlA1Kx2+2WqBELLS3I5YH7
X-Received: by 2002:a05:7300:559d:b0:359:8492:2107 with SMTP id
 5a478bee46e88-3598492227bmr7783202eec.10.1791812217154; 
 Mon, 12 Oct 2026 06:36:57 -0700 (PDT)
X-Received: by 2002:a05:7300:559d:b0:359:8492:2107 with SMTP id
 5a478bee46e88-3598492227bmr7783126eec.10.1791812216177; 
 Mon, 12 Oct 2026 06:36:56 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm18323802eec.20.2026.10.12.06.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:36:55 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 badhrinath.s@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 4/4] configs: ipq9650: Enable fastboot support
Date: Mon, 12 Oct 2026 19:06:28 +0530
Message-Id: <20261012133628.1569010-5-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
References: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX81JBRYo9jUe0
 mqVQ/qi3KtHbHJa+S+bjHbRNWYw76+ihfrV7V8AaJWo35FafeO+T4k6eBL/7NdeBLAjNzV8jKzT
 Uj+3cL3IlhOrvCBhuvQ9+CQhyWwwno2D2kVpw3kGO6VbKPx6sRYoA6gP3EcXkqH8M8RYm7kUrPy
 Jq3niJu27bOrPL5nx/N0mQxmGXmC5+eUjboLrrMlUFd8ehig41p2HNOxaobrHrSRMPg82CCFhD2
 bP7vc5ywO8Cw4iUDBXRswgt07CDbjRQSwFKkjultJ3wNgfx2qSfyJak5yu6BiWj5ltuH5dGDRVf
 aRK1Ga8bhs/dJcFclsFgog49W2aMG698pKG1523xpDMUNqLj0xldz9K6IKwKr5TjK/mqk2qR0zh
 3Cf8fJFVvF36eAw/N9hTBe7waHj9wZhiTsSzEgJT4Hnqqo7Oq7D7HcenRmbIqqxJcRDIwp8XF4K
 E8+NftiLpYHyS+AYYvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX7pcyx5Jk/hLu
 TU371QDqfr4GcN3a7ya7RJ4wlE4QvQvR1rF274cWgAwf1GP42dNDO/AHiN6m1/sstLtcLQFL/UC
 WatCqHuTUxPEqXIl0ooqBYnH3zauQ1c=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acce279 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EWUJToNoAiMeazlblUQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 1Tg6I6JoQPM0N0u0t8JzWotDKerfRJ3X
X-Proofpoint-ORIG-GUID: 1Tg6I6JoQPM0N0u0t8JzWotDKerfRJ3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120054
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

Enable USB PHY, gadget, DWC3 and fastboot (MMC) configs to
support fastboot flashing on IPQ9650 RDP488.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 configs/qcom_ipq9650_mmc_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
index 9438f4844d37..87dc3f56fc93 100644
--- a/configs/qcom_ipq9650_mmc_defconfig
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -15,4 +15,21 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_PINCTRL_QCOM_IPQ9650=y
 CONFIG_SYS_MALLOC_LEN=0xC0000
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_CMD_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GADGET=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT=y
+CONFIG_CMD_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_BUF_ADDR=0x90000000
+CONFIG_FASTBOOT_BUF_SIZE=0x4000000
 
-- 
2.34.1

