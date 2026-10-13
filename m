Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A1BCC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E61880DA5;
	Tue, 13 Oct 2026 10:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wduQrmSn5StC; Tue, 13 Oct 2026 10:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 11B6280931
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791888681;
	b=JIG1JDyLfvmL3lEkarv5ZjRqwOEeHDSbk/xVWnrbclokyanhLhybBYUP2LvH5tnywK9U
	 MwVMpdw0Bc60JBkBjOruXRKq0PyOJ+/+K1uFmkKcqpp0FjRjE8GTEdaL9gN5gxsWmqBi1
	 HUFDGVqK7DOIr6H4TfpuwkIyGCNvhkMjjz4mjdA9JrKBRBjnfLCSo2PTj/1sxAZPjvVqC
	 hytcxvHRV2gJ8lG5iZjdH1N1/m/MIoILIkDU7kqXTAVeLVdED3glxPAitkMAWYiyhCRri
	 jqMpS35A5MlJRUTxNqLF1nMKXXz82rlyM2xPqpp5tZVepkywbxpQLb8ILjmtshxkOqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791888681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iRT4sOLh5FYOIVPIsQnDoa8nd/GIW07raYFel5pCVJ8=;
	b=XJhdpVNkQ7dPQTzlxXkAAqUrl9ArfbAGJ5boCD3sJ3dYL0mUYd7qMU29A2rmFFPAoSvR
	 A/U4YrEwFWMuzwUFacboRfiCBE/BXEAUOhv6drT+incT/nuACjfqsCYnUyai5wwOd61zG
	 +F010+1CrhemkXw7VPYJT0Zvx/VZ6NRErxu14I5dTjUDFHhuRCGaAoUnmHrezJyHXkvNd
	 n9mpUKNdrARTfvdwYGVWOyWSyndRqtJiZKTlKJ1F80TSwm9Fj59ya/WinT7oPYVcFnvdd
	 zlUZRX4xo/E81hSyz3rhhuISfOsuwGvTSfQmr2xnVZyFxzIBMCfemsAHGT3TTZEgI1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791888681;
	bh=iRT4sOLh5FYOIVPIsQnDoa8nd/GIW07raYFel5pCVJ8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C40IaMBduvbbTElO9hZ0ZPOaxtnQ0p+1YZcr2V+ozUrRSorGCmerr4PYGx9eRvpqE
	 0RctP5Oqzqxp1jo00DmgFejBaevWAaAFYzw+lWhtoDI0oe+1gbyatNHwdAZt1JkOzu
	 6UQFZ4whbtkTgSWxmNemdLoYBBthk9APxgBEGK3OU6Mxf3GU4kBxXbvpHK0vtwGP3A
	 IDvQgHap80Ug1J5998pMWKoIHAbTfvA5Y7CLYnKapfrj5oTckr8nWqBKo5N5GIs11T
	 Y+x30bgsr/5JlaGFpY+PawQlkNr50ErW87EsW+DvIII96NAj1HL+rp1qZ4qwn7JFXV
	 Ym7S+s/tx8W8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11B6280931;
	Tue, 13 Oct 2026 10:51:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E57D94DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D73AF403B3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oiOSbn0yDlYO for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B77E7401F7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791888679;
 b=MH9vcgGRxRG8/3AulXtht63nCZGbVu5PwNovYvz/s/2rYRdD4kaedMhNL2YoksImTq6M
 4la7ETiDuwlji/y/ZXpC2H5UfNNC1vdk1tSeqwZGueiFPLQSqu5wrtsMyOLqIQUOeU0Dc
 HicL4237+BFouWibJbzKV8VdhxJpAPcQVa4eJ8xPDjoipWaCkDcb/ITKbrUipQybYY3Ic
 sWU4eqajZIfbNI2812kg5JzziwSS/220ERp42QtGwRftU353pcTdX5FDI+atHUinkgoiP
 EhpiZeBBW7h6Wyll9xOMBQG+UKLeGy/ycyGTEFMg2/+J4iL1Hc8GHo8+9ssurcNon2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791888679;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=iRT4sOLh5FYOIVPIsQnDoa8nd/GIW07raYFel5pCVJ8=;
 b=A8rWiqsryPsMjaKRXTJBk/0VQaUtThSsQ4W4bNn4VszfYiT5mEVxpJvqm4i/gALfMH9F
 uMg06F4zUOIhENsNZIRqCr2NZ27exy2naZLKZ3h05POv7y01NZZF44BfTTf9AQDW9vJyL
 IhqdkVurYL6B7eAqwHJAN+qILUdH9hotGxrhk9WPyqIHVjEAO24jv99JNjZIAOGlA0GZa
 ZFCGYrirMvB/ft9ZDsFr30bjgXUvOznQHoG+9cILXLbx4JY2CM3ofS+XPcyxYdHGTiUlF
 fhAMSWE0UikFtl4f+pkoaXFomODJUC0jRheBtB0OlxIpQoK2b8a0v3ENGo8h8vwW66w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dJSukWde; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Keqh4KBf; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dJSukWde; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Keqh4KBf
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B77E7401F7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:51:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8Vsxb3054911
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iRT4sOLh5FYOIVPIsQnDoa
 8nd/GIW07raYFel5pCVJ8=; b=dJSukWdesYfZtXfXDOSu0YP5gDK9It7p6R6W7e
 3wyndACOmTDhLXMhHqr+Qz6LTZWKFmat1o9fteBZBbKddPupAQ8dQZ/R/cNz373I
 XnKUATcEoaf8Gxn52Q8fZdb1u4hoAfi9K7SmynELe6zzsI1ZE/1QXQrojdS6FIsc
 4fEXKeDeXy89z4P+9kDdr9obXnzaqfyJ3c22WB+sPEEw9mu4+Vd46nJYFprf/NUZ
 UprFN5aWISsjCstsP8s9BZpsSnay9j8pEsq5p6uk+Eznn5ywDLhdSi+x1UImafF9
 2Xoy51Prtrq4YGaBH1VZJ+oyoKHmRVgtn7BUF53IQCv5NsLw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aeuw3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:51:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so578366eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791888676; x=1792493476;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iRT4sOLh5FYOIVPIsQnDoa8nd/GIW07raYFel5pCVJ8=;
 b=Keqh4KBfebxSYn6BfjsaTSZbpOf9//qP+GgzO6NlcFmBFT2BVBvEPTp6dczW/g2vRJ
 /Z6OvGRmjbdeBUF0Jz0AehNVKCtXiqk7TgfOMtgDK1yIAOmoGlu3L/Zt7KzJchq8ievt
 MF1V7v3x09roSG4TQ2ma3ytmL7Y+S0VHng8gd3dRJ5KgFwFMQXllPY18+W4wC6Uvulcy
 AS3iDzG7n+84SjH/7d+mnsZReA0XiqVPpOdfXI1IlZIzivwTQLwaA3AnVnOkys2B19XQ
 4cnmy+ZJ9igZYedpzrYpTE9Izdim0xyFaeyaZesT+jpHYeGQlBPF9LnKLHdwydObIcBX
 wOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888676; x=1792493476;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iRT4sOLh5FYOIVPIsQnDoa8nd/GIW07raYFel5pCVJ8=;
 b=26DSQwSxnz6ZXCW4QPN+Jnk8ZoTnXyXKdGrfCLdoWpdgkyn3LwGLuCrodEfsPnnuXS
 YKFE8dB4xlzdor0N0IJdUkLMKIUwwqL6RQqhvDS6ezODlhw6PYhZQQ7QaO6PQgoLOADm
 GKrIbwrxPV3sDs5XdVS90YAnfRQb9+O9H0f5QR3SjGOwLK89iFU4EqHsMBJt4/L0gwbs
 pWpPAX+L/GxTMjkOPe2cnwQxLDeyywYcPbuII9xW/89xwIdoicxO1IrAUmY3/WqQ/VUF
 6H32VrwqamWRD/Cb9Y+/6h5OOgZofRaeKSvDU3yl3lKwuWvSzW1Q6qSgPl8yJbrtDcHa
 hNRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy69NwHnU2EDsLA+hg2RBK/fE4avNzCTtjmVoskhcFoLoKqrL4bUfFbxvokFkc+ONJoUYKjSXE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYInoxJ63swi/SEc5fQDLORHMk6o4sMCQUl7m6VtZnJeCtWo1/tA
 6pC8S9dDnb4yIn8CuSdInQlSgiqQBDRWOqz768WJKvF6zZGRG2rMRsHMBawgwrDUN24TSbZS+g1
 Nkw7VgZvZz5HT1uHhlnPFHICKI/HDEKc5pFsMFnKXkFuf1lEBdsxh7H5sx6NNE9OllwsOd1w=
X-Gm-Gg: AYBFou3DID5cPlGn8sTSDIf07Um9ZT4hV2h5mxpSb6GzMScMTE8TTPtdOu+4yDoMzxS
 7xTIkgKfjsQVEroNLrUShw7Hv7UrxhE0gnu319w+H5zpq+j+i3iMGNVDGnAbAc1PzN/PWAb+HVh
 i914Xb1RMjRMe9CIBP1fD2k/keTkHp1OCuXFAKVNQggGYULfUxKK2dRL+ZTtGKZ3+6xEoG14s0W
 niG+nVhUqu1N6LFUF0PzFYX396A8WGnk+lhcMyKOgReFy9NQWuA0w6sVGStEZrU72UVwo+ePIhn
 U0oQv0gQssHezXxCSoUJye0RXZRsSTtrcH/IhYQRszjQwuaOuWgDzms5JqjZJSj21+fLujbUy7S
 lwWAc7Uj3AjVBZ/v3DwqycIOOtb2oYT5brTuyskEQJMoCR+KssKSZMOXsLt7FpSPyDV4+U3DQUb
 cTfjmrvj9MDywHHH8fI3oQ9tUiC2Jf
X-Received: by 2002:a05:693c:88c8:20b0:358:f678:46b6 with SMTP id
 5a478bee46e88-358f6786227mr12193862eec.22.1791888675768; 
 Tue, 13 Oct 2026 03:51:15 -0700 (PDT)
X-Received: by 2002:a05:693c:88c8:20b0:358:f678:46b6 with SMTP id
 5a478bee46e88-358f6786227mr12193823eec.22.1791888675094; 
 Tue, 13 Oct 2026 03:51:15 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm48393237eec.17.2026.10.13.03.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:51:14 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:21:09 +0530
Subject: [PATCH v3] doc: qcom: dragonwing: Improve build and installation
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-dragonwing-doc-v3-1-e6a61688ae95@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABwNzmoC/x3MSwqAIBRG4a3EHSf4gIq2Eg1M/+xONBQqkPaeN
 PwG51QqyIxCc1cp4+LCKTaYviN32Bgg2DeTlnpQUhnhsw0p3hyD8MmJbZwcAGUkQC06M3Z+/uG
 yvu8HB/qI42AAAAA=
X-Change-ID: 20261013-dragonwing-doc-b78ceee130ee
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 William Bright <william.bright@imd-tec.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791888670; l=4085;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=b7FjmNzxIv9WuKZuo3Bss8bgTa48N7vvVugFcUBNo88=;
 b=KRO/1IhJBL4gGdNGJl02zTH/KDqgb86A/xNfe9NtgUdWNO7R6vAWVgVB39nmBIVnmMb/sHsrV
 STeGqjZb9ReDRamZX7fvvBwRWEpqrUnlSKQBgQalwYHKAkvEgLPllZF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: fY7D6ieqYhwg5xq-48K3XtzFQyB7GnE2
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6ace0d25 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=vI1eepND5Z_qa6wheRcA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfXwXeW99XMVgxt
 zn0YmfqThTi2BKTHbGhw6T3SdvoCkoPi39d696Ae+9lC5yKJu6s098GfQ3O80fIcTk9yU4CybIj
 wrH5CU0vBcwdh2dUfuPS5C4O9D2XL30=
X-Proofpoint-ORIG-GUID: fY7D6ieqYhwg5xq-48K3XtzFQyB7GnE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfX5Z4gsmdHtIRl
 BLsaQ5g5++Q2SAd+w46C4EK32t8iuLJnj4mWtE+QMFBzjhpCN9p2/3p24uFAnoJ5L9M2+MqNrk9
 q49d/0wVpAVum7bgMZnGJ3KOKIxi0n/muMN4i6UffLv4Yymcfipia8NuCxgLnVDzJY6ZEDKWqFd
 ftjq6ZsfBpTtxicEhO9NfwICz85S8kdm4ojcBK1SCLRrdb557B6KP5Iycl3/jvJKREPsaMGzKY6
 S3AAwGmg/EQQ5LJKGhCwgDUBRQjgZrDqJS5OwR3HrP6dK8a3p+BD2vDvmxnmdTBd64IsIHdtL8U
 x88Phiit6jDetrPdEjBm7zbK7geoMAAF/m+eLuVtD/XUDuqlV6d4DnIT6T55K1YBBJ6ric5BSbv
 twYXoAxuC0Yq/dZ2BdjMH6kHYcgsuovFgTIiXNhjC0N/O216DuFbZFEiFRvzlCFvO/vXj1YAads
 ydSX6wckA+7CwGLQ4qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130043
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

Enhance the Qualcomm DragonWing board documentation with clearer
and more detailed build instructions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch depends on this: https://lore.kernel.org/u-boot/20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com/

Changes in v3:
- Rebased on top of latest dragonwing.rst file
- Link to v2: https://lore.kernel.org/u-boot/20260507-doc-v2-1-8d37ed72d8a4@oss.qualcomm.com/
---
 doc/board/qualcomm/dragonwing.rst | 67 ++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index 3024c50cdc5..20cc03923f4 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -19,28 +19,73 @@ More information can be found on the `Qualcomm's IQ6 product page`_,
 
 Installation
 ------------
-First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300``, ``QCS9100`` or ``SM8550``::
 
-  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
-  $ make qcom_qcs8300_defconfig
-  $ make -j8
+Build Steps
+~~~~~~~~~~~
+
+Download the U-Boot source code. See the :doc:`../../build/source` documentation
+for instructions on obtaining the U-Boot source.
+
+Go to the U-Boot source directory:
+
+.. code-block:: bash
+
+  $ cd u-boot
+
+Configure the build for desired platform. This command creates the required
+configuration files in the .output directory. Following gives command for each
+platform (choose based on your platform):
+
+Generate the default configuration for the IQ-615 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_qcs615_defconfig
+
+Generate the default configuration for the IQ-8 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_qcs8300_defconfig
+
+Generate the default configuration for the IQ-9 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_lemans_defconfig
+
+Compile the U-Boot source using the GCC cross compile toolchain for aarch64:
+
+.. code-block:: bash
+
+  $ make -j8 CROSS_COMPILE=<aarch64 toolchain prefix> O=.output
+
+Expected result:
+
+- The U-Boot build completes without errors.
+- The ``u-boot.mbn`` file is available in the ``.output`` directory and is ready for further packaging or flashing.
 
 Although the board does not have secure boot set up by default,
 the firmware still expects firmware ELF images to be "signed" in the MBN format.
 This is handled automatically with mkmbn (see :doc:`signing` for more details).
 
-Just flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
-on your device with ``fastboot flash uefi_a u-boot.mbn``.
+Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
+(or the appropriate UEFI partition for your board):
 
-U-Boot should be running after a reboot (``fastboot reboot``).
+.. code-block:: bash
+
+  $ fastboot flash uefi_a u-boot.mbn
 
-Note that fastboot is not yet supported in U-Boot on Dragonwing boards, as a result, to flash
-back the original firmware, or new versoins of the U-Boot, EDL mode must be used.
+U-Boot should be running after a reboot (``fastboot reboot``).
 
 A tool like bkerler's `edl`_ can be used for flashing with the firehose loader (for example, for QCS9100
-the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`.) ::
+the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`).
+
+For example:
+
+.. code-block:: bash
 
-$ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
+  $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
 
 .. _edl: https://github.com/bkerler/edl
 .. _dragonwing IQ9 bootbinaries: https://artifacts.codelinaro.org/ui/native/qli-ci/flashable-binaries/qimpsdk/qcs9075-rb8-core-kit

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261013-dragonwing-doc-b78ceee130ee

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

