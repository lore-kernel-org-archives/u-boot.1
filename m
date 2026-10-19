Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3E7CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73447406CA;
	Mon, 19 Oct 2026 10:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55FNSktKyK8z; Mon, 19 Oct 2026 10:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9328F406E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407252;
	b=YJNL0Zu2KURI3xhxSnxbADjiFUpcmo1cvFLdAwBFbB9Umy5k4jl1KT3vp6oys++vAosK
	 +SygRhKadlcjaWrGcS6GNDvPegFE+/80q3cjGF1fsfQ/QHexuLtXSBIm7qF/DuJwJP4MG
	 Nqx2SapDP3cFnNVnS3IakkjFIyS+IaH6/uK5fM7JqghciQDvNBdWbu/pDyS7JDwbD8NAr
	 6VeUMjvnpwoDvck9XVpjMqu3NKr7apn0UBUigkpPBi1fNZ04zwzjSjUiTC5OFeyqHfzTL
	 lkhOxM8JFnWAr6xiGLmktvH0+PYcfuGdPhNgUnbh41w6XhrWuxEVt7ytv+8iT2lajjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dcMckTjoG8m8U5MCk3tyHMjMswXkKfHM2xa0P+vnws4=;
	b=QsGUVB1scpq95VUzhNzYV36BMviSXy1Zibz2T2QtqmR2BSOVTclmqY6uOHRdrNqrPCCu
	 QW3WRinaqntoxoNfaRnTUSe3C5sZYo3qigqA4N0FhJnvBKCnu2E+r7F4SdObaxk49uZIi
	 fDTbaeDv+AqSzIQkjmiStGniaxEiuMcdyJI1vmb1i4S0+frMrqeAgDSokCxwNf2N0tqK/
	 ZkrufIR6kkb29HMmyBnu7z9RRJM2PFNVbPNjMpnARaVrseFSyTgl0Gzm33NYExmmqxF6g
	 JbOMVo5XTSauodDxv9FAla/qN+JR6rMqWDMpCgS4gNYm99RPwZilIsagE4EL+twK65g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407252;
	bh=dcMckTjoG8m8U5MCk3tyHMjMswXkKfHM2xa0P+vnws4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xn4oRCj84MeGeZKtMlzlVrnp0FZcDXKsMVpcvPOevwn5aNJJNWwCemMQr/gBroXTJ
	 kZj3wHq9Z9m0BoR/YpZfQ4TAFxF6qgkW1pORI298b67xDc3RoQsh+Yalx6mz0jZCsO
	 dhF5AvTcduyO0iLrCkNGOqnxWXYRGFdN/4GkKfPjuJV+owXKG91m0GAc+Bb4qW/+n6
	 pR0PJZTIiUf4n9VhhQf4qQ/3vZTYsS3GlXQmzkkvM1v9gWkv9tP0skxdVo4mX4A7HM
	 RvF8OhszWyu9cSAsh2JAbRsB5pnReFxmEfTVswofOaY84S7qReJcndLpjvai3NLkCm
	 Z2zg79hwGnUCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9328F406E0;
	Mon, 19 Oct 2026 10:54:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81D5B1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4600380C25
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEef5Iz5aJv3 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:54:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C38C80DAF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407250;
 b=DzPSYpItZMG3HC7ZHcPbCpGNoFNJTxyVso1LoP62DAQPtrFX8IJwtE2S7F8sYYgwEGDf
 gF2bgonRqE+PaAXO8Y7OYqD8Z7NCFC0763ZkIAfYhHW1TygZM6fZ3thUR3VxahB2BH/5R
 Cy/paezUICP1jiHwfKtEla/t9LRQNroBXfTL9ixxMrVzVyPkhAIFgiR28GlKbm8X/TSkD
 Q06y0fInB63El4FrnEIit4oe+MkwJnGILZrpaTjRPpRoWuiK78ekXyMBv7DDrxAdm2Zlt
 81hOMfJJh1/Ygn8XJQ4NbIiJn72zIs3QsfrKXZYev7FoRFSD9GmAZyaIFH4oOeIm76w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407250;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=dcMckTjoG8m8U5MCk3tyHMjMswXkKfHM2xa0P+vnws4=;
 b=S9AJzHg0qfRkZl/nqE0L4iaZip/Mf3qY8lF3nC+IKEnNn6MsXfQAhNc1R13uiLd9c0mV
 P+EBS70878gI7eUCEmQ67rgkM6/5oVBw5f1wP2trxqDMC2GGCCy/uS5E7Ye9Id0QhPSKH
 EZeHoDi7SEHeBO8/ggTfQQJqpc5SgQV2gz2x02FwzZIvg8nGvcSyPjFe1+i77C3oU2wu3
 9oEDHQSHnDSeYZUs6B6Q1B+PmRpLreFWPE2kYWNYuv4Y5TTPlt2Z2x4fJRCJ36to3Fiqi
 oA1e12RupyR9ZL1JfQfURN0gAWazjLkwtEsQ16g03X6W7GTogvPC3TyKSrVVKr8fplQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RSNdyFpy; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YGJnqPmn; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RSNdyFpy; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YGJnqPmn
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C38C80DAF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:09 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Ott1723143
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dcMckTjoG8m8U5MCk3tyHM
 jMswXkKfHM2xa0P+vnws4=; b=RSNdyFpyiBWC8ZM+kJ1FIQEi3k1mInFdNxDBOK
 5lSM6xUR+XAEmwZD0wpI/46dCVr6N3A1FHjeY7QsTVIrW1Ln/Ud8OtIbXQV2niXb
 9fuEfq25I+xlWQHOCzMq4PABU/lelhkA3PFpzocXEScK2NK5MQpVA2TsFh7+aq8F
 qRlPXV+0Y2GDexGdA1/tmJEECX2cq0tpjNWs/PaVypjCUpxEhV4bjaSSE3teQQ1d
 Hczw4cjchJEZrzWIBRi5qsEVImelEhM6u4U2DZuc4ftlOqKCjhj520i0FMGGF2Wo
 Aleot+/RbvBgEI9k+PBvLXUQQr+XapD8I0z8CddODWvWFL8Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65gpem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so6189818eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407248; x=1793012048;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dcMckTjoG8m8U5MCk3tyHMjMswXkKfHM2xa0P+vnws4=;
 b=YGJnqPmnVsWMSLePQgPXCNvLFgqLdqNZH4xlS7uSHKuYA3igp0tAzWbvgs4/hPx2p7
 BjEqHgLPiFa8LTHDN8MvnfQDOK2V2lE7EB54Hy3qxsd1rpVoIrfeo93SKqaxRgqto/jj
 nzCEdSVr/j0CVCR9/EpwUmxncHNjFBJiJ2Uk6UQ953GkPAwMF8iCUNSLMnkcr/scbsjk
 zXTPqbh62silygUZLa6RnuaxsD8LYjEfFtrt6NWjNzCHYSbjC45ulB8qtMp2cC5HOXYZ
 H1d9IkMMzfadm8pIAHVZx0io9n/vipAkP6XpRztsobkSMPtDQo2O+OwRZf5oUGihP+P9
 0u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407248; x=1793012048;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dcMckTjoG8m8U5MCk3tyHMjMswXkKfHM2xa0P+vnws4=;
 b=mTc/C+e4cq6Nx9RS5Dz9VQC9x5peRvi9ZfEX+Qaa7UVxnDj5rHWkNGrlKTXtZmIUT6
 tHmJ1lBOyOqZgYGYIAMaxqAqenjk6ZaePVPsXwEu+/T8J2AG+5/zokLE560JUE3Jwuci
 CMVNn/uw40Ydvu/Xvq7fqRAT0J8ETqsxLL8xgJbQhDqGpJ12/yKbZgKIF6ZPNbIRPhRd
 AqFEV41dvXKNyerQlLepRm9WGANDZ2IXE5zozBnXXdnOK0EqDOHTsJ0kKKbKnmw6ZbYN
 M70s6IvYOB3lX92CtPpECYC+EIW/Ilxtl2kRWiRPNNOq6RKU+RbJdKMTLHvvcVAtO6ls
 y29g==
X-Gm-Message-State: AFq9FYKFobqnoHFVhFGiP4RdMgYtAUWjZaSx0224WE+xBLM5dro1JcH2
 meNlf2eEU19ojsEY8tobzJkrkNP4gch0TWala9D3abLgUUyAH8RpgBFhPI1UkjzLWIZwL5rig+M
 19Qj75My/rOhdw26YYEEi1G8UKP8Qyr1W09+DaTt+/zvtodMyIbBRqjaWkGLzPVZcIDnznT4=
X-Gm-Gg: AYBFou10UEY8tmdBnkw4pfIRXUXBptXyxlmi2B+flLRDKLZIIq2/SRtfvZCCwc9viQO
 0Mje2CnV0+dXRWFZ8VEohvTNSJMxxoeqF8UBr6N0U/NnCoazB9JWcFU8dsvhJo60H/lEvfj2DJT
 +RxlgsonxXFujA+UHVasf31xWuG3quQQdVjuw22WcBhaE3zDDR0zIilj88dex7hUYkRyar6tt1P
 CBdfAUi9FcXRfHmfArA6wmdvfWDKF9N7IzEyvySQ5KGUojSAvAHcauTbIuUk1QL6LK2GTgDxYsE
 3V17MIP/3gws+9nM9hBmRnycN2pMQM80CNu5mm2hq8VoDU1ihbvWFJVMlBjG6UGQZKMNOburdZj
 u9A2zdh9IKKIpNjzYZ5FWpez509+QNoQx9Gf8USqpUyLOKHdlRhr8Mj+/+EZipm0kOAuBpXLpzc
 nd9qhp46bTke0Vs1iFCIg9YSxwu2xQ
X-Received: by 2002:a05:7301:fd82:b0:35e:7bfd:4613 with SMTP id
 5a478bee46e88-361a302ab1dmr10465750eec.40.1792407248075; 
 Mon, 19 Oct 2026 03:54:08 -0700 (PDT)
X-Received: by 2002:a05:7301:fd82:b0:35e:7bfd:4613 with SMTP id
 5a478bee46e88-361a302ab1dmr10465717eec.40.1792407247488; 
 Mon, 19 Oct 2026 03:54:07 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ab80f9sm50709421eec.12.2026.10.19.03.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:54:07 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/6] spl: qcom: make Qualcomm drivers buildable in SPL
Date: Mon, 19 Oct 2026 16:23:54 +0530
Message-Id: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAML21WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0NL3eKCnPjC5Pzc+IKMxOJUXSMzM2MDC9MkU7MkAyWgpoKi1LTMCrC
 B0bG1tQCHHRusYAAAAA==
X-Change-ID: 20261019-spl_qcom_phase-2663085b56b0
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407243; l=1446;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WVn/KND8dqbidux0MTdvzuPNgW4tyDnvPqbRLQVzZSM=;
 b=kTGzRgJw14GRDzNnA+PawmXhqZpuDysCNfdSVmMl2I0rtQ4Pu/Uu022YSqZbEjGTbXUYC0VZN
 VmWiHVSAfj1A9gCfz34Y2vaKM2vVXnSD4b4T0Gl7axePd9swX41XvBE
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX3g//P6GpYlnx
 CJTfwtBxvwhMjVZ3AWbrzs4ij/fgrNcHJ7XPv7JPIBhgrmXhu+vDGHZTzKzbQEBoxyCcxm9wAIQ
 cCSuuE+WtjDkAqjQJNSWGRAk0dF//QE=
X-Proofpoint-ORIG-GUID: lVzBqmPMv96xxcBwQcX4GGBgEQ68xvT0
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad5f6d0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EhJJBH0Uh-cEjipSaHcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX2uN+BFWxhnjF
 gSghj1LYVOSwv460lVA4gkauSGsKUShY/mlG5Y92mwqIVX4VnJ6Dk/GJm0QBRpmanW+DPINo3fY
 A3tPUkGgpJ+3ZCxzz3gav0to0wTB9agHOWbFd9vhQxa7tGlh2mYjTamH782cnSQTx6CVY99L0Zh
 8nEj7r0yQc13F5GTYKySufSDjolsC1ogFvmd2o9ixwXk4zhvMZyY78qroP6NlwRpdkABfOJ5mLS
 jJwNJhILQtUboQGIoHeJUh5dvsFu9hZP+lgm6o5H2meRqqRdTfgD3z2yLKTqCV4qfm0PFErafGo
 nJ814V7HHnrWIH96/5MlpGmWnDqIO/6l8r+E0FYDhISq3SOSz4TSwUNtKsAwcovciRwYPywZa/2
 5/bX11Ffb9JqoP9gW/eSVxvrG0CbbQuT9mcAfoNLUycaE/WMul65NKFcOk1WRidh7CT+PaDr//L
 lpbESjn/+bcgZnCKnZw==
X-Proofpoint-GUID: lVzBqmPMv96xxcBwQcX4GGBgEQ68xvT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
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

Make the Qualcomm GENI, pinctrl, serial, PMIC, SMEM and SPMI SDAM
drivers buildable in SPL. Each driver either gets an SPL_ Kconfig
symbol or has its Makefile rule switched to $(PHASE_), so a Qualcomm
SPL defconfig can pull them in.

The SDAM patch depends on following series:
https://lore.kernel.org/u-boot/20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com/

---
Balaji Selvanathan (6):
      misc: qcom_geni: add SPL support for Qualcomm GENI driver
      serial: msm: add SPL support for Qualcomm serial drivers
      pinctrl: qcom: add SPL support for Qualcomm pinctrl drivers
      power: pmic: use $(PHASE_) macro for Qualcomm PMIC
      soc: qcom: Enable phase-aware SMEM driver compilation
      drivers: misc: add $(PHASE_) for QCOM_SPMI_SDAM config

 drivers/misc/Kconfig          |  10 ++
 drivers/misc/Makefile         |   4 +-
 drivers/pinctrl/qcom/Kconfig  | 206 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Makefile |  50 +++++-----
 drivers/power/pmic/Makefile   |   2 +-
 drivers/serial/Kconfig        |  20 ++++
 drivers/serial/Makefile       |   4 +-
 drivers/soc/qcom/Kconfig      |   7 ++
 drivers/soc/qcom/Makefile     |   2 +-
 9 files changed, 274 insertions(+), 31 deletions(-)
---
base-commit: cd3b33872cd10cc1a8093c942763affc265063fa
change-id: 20261019-spl_qcom_phase-2663085b56b0

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

