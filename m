Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E1BCA9ED6
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A556860745;
	Mon, 12 Oct 2026 05:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id praCIx95iPjB; Mon, 12 Oct 2026 05:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 501A360725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783322;
	b=YSyXd3Gr8dLq2/XyvF2KnswAgo5zBm/l9YE9ltnzPB6kV+dGZwmGCeYOHxWaUPdQobg5
	 d/Uu6LxTraDe5Gc7FdoBURt11zvfpkXSIBdbrZtyaaobJKjp+4cCVupGPIrgUYIJCtJDt
	 9oCOjcRJwYbV4b6PNsOJGMw5G16HlwOEZB+WgL7E4rE/Hfh2aEC0MKXCGZK6g1d44DZP4
	 9n76EGYaJRJParbpPukc2Sp0qCJdHYQRJ1Qdb0I9D/d7Fm9+N1B47q1eErc2uqUPTyL4L
	 aisPQARYiUwEiv1E5hCkUpFepTssbUwW1safbKVGyFUWyF/EIyS0bTjP2J/BIfVtimg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	b=BK7nKZ8O06EWxsnFYmNBNmBGHcl4OHczT2xk29vRH79FsRtm3m1ipUboKUtBks0s97CI
	 /vUwNbdeLMTm4OhWQwJv/sjK2SiuN5BSijGLhxuNimbYz9fSHOLWTgwKaHFcYWyWMsUrq
	 M9kOUr8zzkc4hO5uLVP6L4zmiHxlYZXbrKJppeO9+lO9NZaVo8DcDAXMPUMI5XrsWISXU
	 ApGcfTuluHL6yxz6AIjra498HDZOeg8oa2gcJRBrPMbC0uptOzUmpfCweDnj1jj4sdGP+
	 Y9bynxNcDLCOVQT4sD7eMv5su7EfQeaTdtVtqGiVL2x3NB6iTvUtBo1iYB95GxwyJJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783322;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y9zrSa97gzG+maIZblVSL8K0mPfv8pzXbpi1FnlSzsxDKCftfJwkrfnvPteshvc2d
	 JbKk6KXyD682wl1LECoP/z2RNu99sJhc+HajBuwoPNxE1+INmKMrpUG+b0GLiFs6t+
	 pybStZLY+JKaNQg6kS3r+ung+8i1Cyx8h6BHtnZ4Wdfa0oXxzx5VLT7bpdTBPxOe5l
	 nOenbLHoZmpVQZ9iawrHs/P48GB954O7Gq9slgwBR1mrHtyH94Q7MChAu4/nmB0aeV
	 fTnKH7KUoadCP1eb9fb2yTg354SL4jK1oJbk749aWrnMLtBhMtVA+kWn3PKbMZoouK
	 KovMVV/0klcyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 501A360725;
	Mon, 12 Oct 2026 05:35:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CD16F9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3382400A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bic7sfQVj3vi for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0BF264002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783307;
 b=s4j6IDAgFONmmYTlr1CRJE4/Lh8H1pJYBusJsnDsFDk0di5afSeOEwc+ei2dum5Ei5hp
 7Ezb73M4ICFXu/x4Lm9MwYcLUn9QOSsK7vX/9PSOZjUhBFDqqsHvVHhe8FnfWunOiBS/W
 e6uieDZq6+f6oACJpqoLLVzDFrQQsNKGmSG8vZWv5pkduEGfbU+dm2uOmsMWreAXmI0mN
 QK4DYLnqa30hdeAjtHmp4KFSogIyGpI5HK0sfpwncOWspi0iTvSmFpABuMZB5/UJL1FwE
 ynsCc7vq6f3zB2t5TCyYD2kPlIH59TvjTxglCRpF66fLK5LJJwbB4kxWxEjLSnenHVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783307;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=j/thV9j3z7GV70WMG9LZoaMPTt5Ge1kiv1+OesiVUZFiXW9dpWO4aZekyg8NL5V8OM6X
 Y4m3qdDufHN44hPrIyVpjkOd797w2yNAM0mEkGxSDXe0/bQSWAav2d6y0XwNR3V1BnHn6
 7QTTxyW0nIQDJKpM+xJWR4Bpadmk6KbCigt3w7nT+tZDLR6vyWMDldygp0DWnB8ua1yd/
 4rjVQhT2VKTJU+VQqxOrATeMZb4XR5EKH9FnWialbXAeDeCH74Ju7mwA+9vImRyidcr69
 VrdFcDpRzArJFhxY4ivHeudE9yZhvmtpsVsj7GWSRmG+PAagXQ+F5vYeRVOQw9353+A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="c3bw/Du+"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fwfehv2B; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=c3bw/Du+; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fwfehv2B
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BF264002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C56eVl1003368
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=doWJbh7Fqia
 lYmi81CmpvlL5mjRVCir1a9mrILO97bc=; b=c3bw/Du+4nAjnEgPxyRSIOKP26q
 ReVnW+gpBnv06gW2V9WbUT1xi/coVBUViIfbJi2DrdQBiEUidDI5Q6acrdZQjvnM
 39hnSKtTtrgeALtIA/anJ0rlHPD7Cwafjpzb4lh4l6WChaErzysviTR2I4eLRteB
 Gq+RNxLb61cPHOv/h/NW0iGbTw4DwaA0fi9NV/cwot1pEICyTSv+UmwBNEUbos7B
 mL7t90tGjsyJFY/TH9rLHPTBKG062yXO4Pb3c6o/rjPHlij+yZlxA3XV5zC8RzQL
 S6GeVPNJuY1GIWrGDWp4d8SKh8CtHT9hamGxf2QQXhLw0KYq9FEN8KcrERQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkgakw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1403791eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783304; x=1792388104;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=Fwfehv2BJ6VDqQ9aHW3zwKvb3Ic3MTg+c/9PtAGJe0tRFutVKYzmT2yaut9SpYJ1mS
 Dr4+SwepTr0yuUqtAY0TOR22wqzWi4TCodIdg7NLccjZGd2myuQ9SK3YsYNJbeOCFgXD
 nALByBYXwni/uR7HA72gy+muZYzz4R8j7druXhOWxOy+RB2MfGjeYeu6F3/UfRkN01eG
 I1M9TxC0XSMIhF1kkJ3Lms4f1175Xf4nbTgpsI4Bg6/u36cOhCqWEhwZR/FgUUQMPLRK
 9x72L64qAN3dTit5zp6iB9jBUXVcGTSNfJyBNvcSXqiqgQXcIAGro63OUFjGWEV3Dmrb
 kT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783304; x=1792388104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=crorClbwLJEKqxkEy3pM0D1IqKosl7nFuLrhmBKm0qGoKTwq0Dq3IKOAXUUwCrMhE3
 ahYc6od0w5YO0iiPAE75wCPYe6l/PX+dv7j3u7V1M3KXJ379YiCslWJG/H9F1Ql/7zPt
 Tt9DNA4uxx2vsnRIE58HhWwFYbR489OUauoKMHWjWzUJVkwTOA7dmcbc8tLUBz969F3k
 lFeC4kn0Aq0cXjJuNLXWeLyJUwZhbybgTRNBE97abHcj+sHyDcSOKKNNjY+JXUU9rcsl
 Dpe26UZUpyo9AindAliiFQVMRku36mckeYnMmDy9dORVDM6TXjKzUfoxT6DH8iKDGySX
 2jlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNqQk8o7ON/0IduclNy5xxaf8iJNSkdeq+Gp/w3AWHvp5cJMuP8TuHroG7fwILvhwFxdRSQZs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJA5x3/nZT4hzz03umDTQyDY3CimKOIfhFU/7b8nFnO9hac0w2J
 h3x91Mjs7aUHFsBh/QAr4QhPA8Mt9xZa5+kL2sm4FUAdPLUsiZYKaznIoqsH1PqDbC1yLNxzevH
 vh8YaA2vjOeKUH4veKFwFRRvRJqGAgMa+z08WYaE5aJlKV0fCvmb6lJihOrmU07ZX8VDJt9KpST
 gaRHY=
X-Gm-Gg: AYBFou1wmVuIVdVe8uWrlMZNZOjmtfmyftCUtTvBDe1TgaIDbDlDgiX+dxedm251RaX
 pSiAam0TCBXcGZyxidxXpbdA5M9aHzxkx48yzToDlHtRIHN1hOwAw9T7MDWQ8hERd9rLTZQCrue
 6CbHVA8iplVkktAbaJHZVLXGQ+GxXle6fLyWUzm8OCYmFNK0e3j7xQ/fv8T6WIBQRn4px2lRumh
 iUjjDdCtiJ1JNTI61JY9gF+PkWjzuopS7jCL0T/cpPP+OIAvo7baUe8DABJpRsLDHjBs9OXq1Jo
 PMxEzhYgR8uG3Ayy3TfxIGkEDLPxeWVjyjNuz6n5I6FJ3FnvmO2gBYkkNicm3tcUh/WsJEN0wSq
 jiWyA2nV/seh2FyHUpQdkIWuQ5CHlECE/hrqAhcMqYfk5FC5u
X-Received: by 2002:a05:7301:6e9a:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-358dfedd5fbmr7029890eec.5.1791783304447; 
 Sun, 11 Oct 2026 22:35:04 -0700 (PDT)
X-Received: by 2002:a05:7301:6e9a:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-358dfedd5fbmr7029851eec.5.1791783303921; 
 Sun, 11 Oct 2026 22:35:03 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:03 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 07/13] clk: qcom: enable Shikra QUP wrapper clocks
Date: Sun, 11 Oct 2026 22:34:46 -0700
Message-Id: <20261012053452.1567885-8-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX0ctdbvyRlxx6
 4p4GnNXynagesHjAPb2o7kJwjB0hSPGWEHwPbDi9LKupG32LJMecg51zIdKgnHUCpVE2nggb9gm
 TLlfLTBdTzKu+EF0lR0zmTpIybXe6Fm0E1Z+8AwHp80ChFa07/zZ+COZh1lV4xUpVGRx9s2a1XX
 iaiMC43KAzOmfhT8+dqCd12VguQITK6a/xHahO4LslJuvXkzylk7oE7S7X6slxtXs/pXKGmnIwC
 opDKI05LkNlf+yA9YwslSROuCVKUci0O+CrNfs1byQC7DT5p6vXM0oGi5OV9tPIXSB6cC4cWMkL
 PZ0k9lQgtNtfoOTSB3TJftjSOBllXmEfq3YY/cNh+kRHAxbjFBMPbb/FNqqCOcwQ2Cvo84gqS7A
 Qkhyg6P84BVklEpj9T9hNvRLUbbe2ANYUd3K47GEjhpAOj7YyW+PGd1ZSbnBLJtYwaugKezHeij
 WexJeoo0w4UjhNCL02A==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acc7189 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=mb1s1FuMAeZDaavxsqsA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX39gooRps7WOv
 ayw4SMBpZg5zgdp6rnUaXxeDa6+PHt9Kfzd0m3Jp6wVDpzzJZOdVGCfHH75AijzNN+QORUUZmf2
 h+6aa3hlYHLEtbWZYkpcrHhbUMw2UZI=
X-Proofpoint-ORIG-GUID: skuyGw7BQEzr5280RvIYgcTU1VgnQRAh
X-Proofpoint-GUID: skuyGw7BQEzr5280RvIYgcTU1VgnQRAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022
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

Enable QUP wrapper CORE and CORE_2X clocks whenever
its master or slave AHB clock is enabled. The wrapper
requires these clocks for serial-engine register access.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 94501b838fc..a74d529f4cf 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -315,6 +315,18 @@ static int shikra_enable(struct clk *clk)
 
 	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_0_M_AHB_CLK:
+	case GCC_QUPV3_WRAP_0_S_AHB_CLK:
+		/*
+		 * The wrapper's core clocks are required along with its AHB
+		 * clocks, but are not listed in the wrapper's clock specifiers.
+		 */
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	}
+
 	return qcom_gate_clk_en(priv, clk->id);
 }
 
-- 
2.34.1

