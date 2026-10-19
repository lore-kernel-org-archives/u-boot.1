Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A427CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57DB2606BB;
	Mon, 19 Oct 2026 12:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQeLVT-B6szX; Mon, 19 Oct 2026 12:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66A0160714
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411861;
	b=FsoVpt9a740pGfvIt1S5DPL1Zqqxx5P+BzpBdp2KRJZ+8Sr27SR96Ft+xVwuoIeKC8hR
	 c0qUuBNXjJDs1S7NybdEyBD0hWQS2sQKQ5CgUnVT0xNmW8CXQb3mY4Ze0ng5mSwoOOG0j
	 1xxq3WHpzA+VuNI1/ScZBtWWIQ3a5tUGZa4AxW1kN4cG81LnSACRmSTNjFThh1jN60oNa
	 7FWptw+rQ0A+9E4WqFnnjJdjR3sGWegJ5NTcCIH28hv4DFSrqKjECbLaQH5exzOvc/Chu
	 M0C5X2GUbge9xlCRVN1Xz8XTvaLEf0sTET29Q8agM7ZMIvtWOT3lQDzcru620rLz+vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=na6/kwCNTbwf+XCdHAu0E3OEEF9ccxFmOSyg6cHFQbA=;
	b=KsaPWVMupts9xnUg6COeb+t+IMI9y2aDGCMPJF+zEvLIJB8YG54m3xMK0z7YpNEVEuVn
	 7L9bHPXWSN9r6k7a9HxacGCWa3AMXv3c3Sfqt6C9rD8HqX3v+QODLkuPDZYuyu0EblCCw
	 4Fw2vVKlKWYZl6ZGAWn2PErTYTwFIwGVpl0IMD4W31I6yBJuIPkItKORQgDsTdVZ8wx7r
	 cUCcmMSGuJNAyFbe0G7xw0JJxB71c1MW1Ku6r8KvoC2X/DcT8kO9xak73ARnqPJMvvDkt
	 e24ZdhQZgZWkdp9lFBzK20fjx8jN+zZ6WdKF5xbPNa8rZ2zSK5k6cUI2ps32l1E3JTA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411861;
	bh=na6/kwCNTbwf+XCdHAu0E3OEEF9ccxFmOSyg6cHFQbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kL+KtGjpJ2/fdmkXiuttxo2UO//rc1WL31V7cgsysDr+wXvO1Y/pwWNvdbsUCoSRs
	 Lm3WVYUch1atrd9PEl5k/SYcSfFwwW79avHZk5kl3HmLyXVUx1IIXhv4o3/QeDYZwj
	 +fCs/7dyNdsiqG9/29imT8lHAO5fvoKpUfX3hM/0yvwjemkL4Rz+OFLeyilQVIKf8h
	 FHZDW0nuU2cQrYx+p9Q2AuvJGJl1MGKV6QLEZjmH9ZljsVxHEeBqxwo4MBllOc7tid
	 Cxtc+bDBfdxYdjvoRmmZceqkXViAqYl9Ljg6BIJy6ScaJ+CWJLvgPmeGL1XxpJjBuz
	 W52QIpkYOWVEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66A0160714;
	Mon, 19 Oct 2026 12:11:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B02841E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1D2980F87
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMzOeURnzEh8 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:10:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE48580F7A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411858;
 b=g1D05oXG9Ejbv51m5h5OqvkBvk5WxX14OSYAFlSZrVc4IlzJ/fSs/hS9Te8VlJYD0Rsg
 w47NVWvRgjp13Pz0+VOaQS+nrEQP5hfupIdiftH2du29LpDctkJuSPKnZ1fHrYqgCQI11
 EzSxcxTi/8sHXkmw497102CU8zvoynY3buYQ5uw8Eop8/kuvocjgxjv+Lcs4A+cxEjH1f
 GAYg1d7M2AmTucU6W+yQRB0f85+rS81omy0Ret5lJrn2vnMfhDBWHJwt9od4NRX5sdbpF
 tPx7oW9ez1HUKBMQVzT2OZPk5MqlS4p98rmEdJAJb7nsUe4GXrxJeYHDzesaFcTqqAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411858;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=na6/kwCNTbwf+XCdHAu0E3OEEF9ccxFmOSyg6cHFQbA=;
 b=i/fO2o7i19wgiZXHhVdhVrSOiN/YFR/241myCh0QiqGgwTJ8Wk+l7t41Rr1ox7jX2/hM
 RihQYlYh3IjghNW2sJS6Fbxx/quXrKP+2Kd7shTKO3GKoMWuhLLtxVnvTyitnw2BcesBr
 3qTCf+dKQMZ4isL1J0Cs4rh8Ufz48fosm/HAk3ArSsMyIxIHJBCnfSolmj1rdjBne+Xy0
 K/vYDZrILrOWC7Gqx7zrUwY1tFZwU1q+y0pLQNdDStGRvFxVzuMBZecixpTxIoHe9oMRr
 UpNvaPkXCH37jTjgUkoE1vJoZ6RSc8+Zcf821BBye3QWMUu7Ar9WM1Q+0jIEiuhGSAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="aBzpAV/2"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OtWgtU7p; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=aBzpAV/2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OtWgtU7p
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE48580F7A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OtNu3256621
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 na6/kwCNTbwf+XCdHAu0E3OEEF9ccxFmOSyg6cHFQbA=; b=aBzpAV/2BreBLdKD
 nry/hl+Oh7G1lEre+jXuNatIRhwzMg4zQXZy7O1K6Q4ehpJZA/Ihlv4Z6VsE8E7P
 usYienqdB8MJsJRZe88czv2czRYjVr6BdWiy1Oxk/RxnnPfY+OSbZUSAqinaF9ll
 V8lYIxTKsUfBv4ETdSmFxL3reChFrbnbjYMJw64vtsKDQ2bwKztoYY7Keb8PVs1P
 JOIBuOCKFyPUmo5+EfhM2CHGLbopTw8j1uF1JLTVPBUIbSsckhxnCoQMGL5rTmam
 M7oXi+UYc1+qg9+B8FBtlN8U3jJjreH9nHpJsSev06w8RoriUEht4EshM/szL+8i
 jwS0eQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f9073-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so409782785a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792411856; x=1793016656;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=na6/kwCNTbwf+XCdHAu0E3OEEF9ccxFmOSyg6cHFQbA=;
 b=OtWgtU7pbOtlFDBoxn4EDQSPuIb3ybWEprhQkH/J9I8zRlQ0G+y2cPFwCGMRI0yLS0
 e9zaPwparCWZApKBDJ3rQPpVj1uhw5buYvOjLAzdSwGqbOfLMUt9PEqbEk98pwcss/yw
 bCCWuS+O94q9lVQ5DVEy8/eO7+3hO5kiRSQ1DHxZT7JV9kIdLPV+nFGbtFSDCfup0U8B
 ikI4SRM5J5KD+H5Qd4UyTATlxIniigs7pntLaqAEK0z72hid+ddG71XiWcu6DaDvAfjo
 cgtGPz2TlsokR+m4zkfUxJ/Ig955PnJx7LUNFHfimsPPOoOHe7KggF4xxR1N1wHcCwJS
 +ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411856; x=1793016656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=na6/kwCNTbwf+XCdHAu0E3OEEF9ccxFmOSyg6cHFQbA=;
 b=KnU714Lqjg+IIjsD7q/3xADg6q5a+SeJGYtYFor8Nf2pOR0eOR5snsa9ccb+toWSnM
 OM+Kge9BoTQMkqQ6RHd8mvVUA+MWS3aAUzzHlGzJlk7+UQAZYqECJpw/uCgSdz/lq34O
 ItB8j7nN3LG8pRSb6bbWXg4F8oy9/hvaSyBm/rYYVDoporn+RwoNg2mlQjXSTNuLwPco
 +pWide0hnXGoOGUzNy0Dz6kfhz0/gSVJDIhigM0rFpp4UXloS5HlzhwXkfIW0MoCnd9U
 wBF6IsBc+0WfU4zZF+9tbQTOVW6aiBCZYaG9vRZbRCp5Ano5vrngrP85tcbNkf5wCiJx
 +mYw==
X-Gm-Message-State: AFq9FYIEaEjASsbix4Yk29XtRUefBemOlECvd29dIIFIHPgJ/hKPQaCV
 +QklrfMcZ/sWSFqv2tC5zuVLmM0QgG9J5TUfq3hNFILUMPXPKRKTjH77SCJ2O8iVk1qLz9t+v7V
 S5x1TPBn3eaJA7MbiMxSEoAX5Eda86lPmGvcknXj3HJCj9+xIAFfzFiUjs/ny0vbHRojVCS30go
 7NVzM=
X-Gm-Gg: AYBFou3ZAB2T75eM2UH6GETpUuZtxBbBfqZ6Dvv84zYacGvvMyVrtpV+z1hvExh7jyN
 +ctHuxiR+40W2SLiAxViiRttD8X31dM4Xqu2WiEFxb9J47mI3urdq+Xff7mogqg2qBbJEWKDNXx
 7fHmYZtiqrKSZHvRgA3+8iMtP5Dv4XlwBmsXwoBcsf8q+MMWvhd2qGxGuBh76rcU8XPen/CieDk
 1zx4Co/c9q0ycp6avEDolcHz1eyq9fKHvpdHRjcTTwGcO0eSiGmNnLHPldT1K2p4FqQW6/UaXfm
 wmFj/iqsaYiAyzDENCEPzHnIo+SluDO4VOhHx9PcnCdp4XTh5VB9txHwFIz++bdZl1E6l1fAoXz
 HxMRKk+AF/LGAGK+BUEy5hu9slORmW8zfDmAFTaefVig1
X-Received: by 2002:a05:620a:bc5:b0:93f:1d71:41d5 with SMTP id
 af79cd13be357-93f29d7bca8mr1169653885a.52.1792411855659; 
 Mon, 19 Oct 2026 05:10:55 -0700 (PDT)
X-Received: by 2002:a05:620a:bc5:b0:93f:1d71:41d5 with SMTP id
 af79cd13be357-93f29d7bca8mr1169649185a.52.1792411855040; 
 Mon, 19 Oct 2026 05:10:55 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1c6364sm3961522a12.14.2026.10.19.05.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:10:52 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:10:41 +0200
Subject: [PATCH v3 2/2] optee: do not announce RPMB from within a
 supplicant RPC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-upstream-optee_rpmb_b4-v3-2-c97cf24fc56f@oss.qualcomm.com>
References: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
In-Reply-To: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: MyQKi6520fVhxRmA4dshrYLryrBfjEcU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX0yIIv6ureFwh
 6YChH++S2WFbfbW8S19N1VStKgHtiTgKjvFUqaDziNIT+IVqQsqpb6LHpx0f6KHv7UaGPf5VMy1
 xBVIothy+sh2HGOoLIcl2tPzZf9NoPBUV39tDb7BD2TlQw9P9wgIy+g8wvWYrEOMomlMKIke2eC
 lTcx94uu9evzg2f0Tvp7GMbr/Jy9SmquQNV9Ses04yXC4pROghkjOS77C2K07Cfxx12kKhIbzde
 JjRqJCnOe7CuxXQsyzsn0G9/nRxd41O9KGMYiGyfEV2Vw64uVgHJ+gxVG88qsY3tGBffAnCDsQv
 3FPf8Z+N+TTnzmzHHXZkpfwcRJfwBY9q264r0nBvyL2af1/77yaggH3KnDcVIYIoJsOhBHlfL9Z
 5znyfwVLws3WlLZqcqKZAlBSS/OutJY3tSVseRrj8Oivd+/8oosX22M8HjQ8QlUxeQmDWcNwRcN
 MOQdPDlS1Gfa7nDVbng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX6Jp5P3X1tITG
 kh4feb403E9/ISCY3ENHZg50CFS4TBr5iidcopI+A8ergFF2WEUunJ4er92DPZUiQ6LOJeiOlhM
 FFpsGrWDj9ZiCElzaEWQOAbWTcDBvUU=
X-Proofpoint-GUID: MyQKi6520fVhxRmA4dshrYLryrBfjEcU
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad608d0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Fwe_xU4FC06Ln0gWJNsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190048
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

mmc_init() calls optee_rpmb_available() once the card has been set up.
When the first initialisation of the eMMC is triggered by the RPMB
supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
mutex, the announcement opens a nested session to device.pta, whose RPMB
enumeration takes the same mutex. OP-TEE's second thread then tries to
sleep through the notification interface, which U-Boot does not
implement, and spins forever. This happens whenever a TA touches its
RPMB secure storage before anything else in U-Boot has initialised the
eMMC, for example a TA call issued from the shell right after reset
("optee_rpmb read_pvalue" with the AVB TA, "tpm2 init" with the fTPM).

Linux never runs into this: the RPMB device is registered by the MMC core
long before any TEE client, the OP-TEE driver announces it from a
workqueue rather than from an RPC, and the kernel implements the
notification wait. U-Boot serves every RPC synchronously on the one
thread it has, so record in handle_rpc() that a supplicant request is
being serviced and skip the announcement in that case: OP-TEE is using
the RPMB already and will find the device when it probes.

The counter lives in the OP-TEE driver's private data and is therefore
maintained in handle_rpc(), which only the OP-TEE driver reaches, rather
than in optee_suppl_cmd(): the sandbox TEE driver calls that function
too, with a device whose private data is its own sandbox_tee_state.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/core.c          |  7 +++++++
 drivers/tee/optee/optee_private.h |  2 ++
 drivers/tee/optee/rpmb.c          | 11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a47c76811cd..f7670096b61 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, uint num_params,
 static void handle_rpc(struct udevice *dev, struct rpc_param *param,
 		       void *page_list)
 {
+	struct optee_private *priv = dev_get_priv(dev);
 	struct tee_shm *shm;
 
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
@@ -450,7 +451,13 @@ static void handle_rpc(struct udevice *dev, struct rpc_param *param,
 		break;
 	case OPTEE_SMC_RPC_FUNC_CMD:
 		shm = reg_pair_to_ptr(param->a1, param->a2);
+		/*
+		 * Tracked here rather than in optee_suppl_cmd(), which the
+		 * sandbox TEE driver shares with its own private data.
+		 */
+		priv->in_supplicant++;
 		optee_suppl_cmd(dev, shm, page_list);
+		priv->in_supplicant--;
 		break;
 	default:
 		break;
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index daff3e04493..92e3b3bea10 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -42,6 +42,8 @@ struct optee_private {
 	struct mmc *rpmb_mmc;
 	int rpmb_dev_id;
 	int rpmb_original_part;
+	/* Non-zero while a supplicant RPC from OP-TEE is being serviced */
+	int in_supplicant;
 };
 
 struct optee_msg_arg;
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index d4abc48f764..a40573c9281 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -210,6 +210,7 @@ void optee_suppl_rpmb_release(struct udevice *dev)
 
 void optee_rpmb_available(void)
 {
+	struct optee_private *priv;
 	struct udevice *dev;
 	struct uclass *uc;
 	u32 tee_sess;
@@ -219,6 +220,16 @@ void optee_rpmb_available(void)
 		    !device_active(dev))
 			continue;
 
+		/*
+		 * mmc_init() may run from the RPMB supplicant itself, while
+		 * OP-TEE is blocked in that RPC and holds its RPMB lock. A
+		 * nested call would then deadlock, and OP-TEE is about to use
+		 * the device anyway.
+		 */
+		priv = dev_get_priv(dev);
+		if (priv->in_supplicant)
+			continue;
+
 		if (optee_open_enum_session(dev, &tee_sess) != 0)
 			continue;
 

-- 
2.53.0

