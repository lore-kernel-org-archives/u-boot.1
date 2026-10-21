Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B194606A544
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ReIdKrv/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o6/RkBgZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=goZtkUeW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18F9380EE8;
	Wed, 21 Oct 2026 16:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFRIoS8RhF2a; Wed, 21 Oct 2026 16:18:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E77A80DD1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599523;
	b=Q4F8HM0o4Ouoj9j5U7PAmPqfLClg+krNFUHH/Xgib0jeazw/vsoWGXsMn+9m+4O/v1SQ
	 eju9MvDISJULayocPsnhnVvMNSmGqv0Mbl/BEgixYvjJ9YNTjrzCB8gf5rXHDjoMd4Yi7
	 yyXyFC4wsjmEQ4O9Vo+n+FeJy9hR3ykUXmY1YcVP5KgGEHZccMmi0DWyLmQ8QF/fYnT70
	 kCWCEVBWLXfXd626iZu2rtAALPVbZD6HYlCddGIWZLrkaWCqPvRnNshNmBNmhH3s2lBRF
	 MV+c1lkeTxVMmf637ygO64639wJ4lN7ZMWc9cB3/VOaRvh4ptZswi8zYwZIcvX/GtlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	b=CIdomdT01YZZISZDmF/fSvfnQhwW9GYl+u5v6JUFnB6ruD19hksAKJTanzuH84xCRSi4
	 RhoB1aSnrPvBwxQ6p4fqN/Eu3cbc+VHVuag+wZMGQskdRn5i6nN0RFEzoPbk9Y9msktrT
	 aeza/lbQSFxQzPywNxO2zI4P4gG3NlaRH2RM7/du5Q8ckR6ESSW17ERkIgKJV3gMbX+Uj
	 6I4F1PxshkQaMXnU6bnOlGI3siYtanVlv2PgKJlHr/CLagCVvGJ4amrpbpCOLh87vSu5f
	 hks3N+oyeV7LIYjWb/Yw8mheRlPLEcqDsvvjhl+C0nyKxE4/SK1nflBzA0GDHx4LLmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599523;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ReIdKrv/n/IUkJMFOiT9Vnq3UpDHkZTPU+J/5IhTMfXZT9ZvMdPiSI0GOL7VALu66
	 rUvI0wqIJLBPqXtVVm7ut//+/q2KMj4gQb2/f6OdcAKcX4j9wdN3a+8uWgI3TGfMUr
	 JoqiYZ3lbox6wUPGA5NB+Jl7s8+yZZZJn8G8Rom9HK58KYrCGEM6Or+AZn7uV3I2dS
	 sPreaxz4Z0sp/89mwm+hEuJFVLBdRbGkr8kK4BujWAMfk1AakYEJWISBwVarDWbgys
	 fyCjCLzc1pJdWFqYHjkCteRl2ID5D86R6094/jG9oEeKajjC57Y9K4JtJcT45pUUk9
	 NkTJAnCI9OqBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E77A80DD1;
	Wed, 21 Oct 2026 16:18:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9A931E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF99C60844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HPS-8TLCm-c for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:18:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 118D66079B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599520;
 b=NAuz6RUAO3syZQCGkg5vB9g+wesY2QFYumnbR6CkxWdt32MWIl0T/3v0Jq+d2PBWyrL/
 nrjwd5/8fvACzxafKQR/HfxYcssRQZVtjEQjiSqyah5H/d8nPsAKMMxgimF6vPfD9rQVs
 sWqkP5+neeqD9l76aX0WIZ0fjOAOwuGTrCWad8fIPEz4kyZBjmGf67OaAb3Vi29N1FrNA
 w26NLGwamVJEp6lSZkA+Fiw8fIiCjtM6pPrnaue8XGYaBj9fVtfJ+DfeNLqHGAiTH+7L2
 xKQFIdHNZ+Y8BAhorXA6FaiAN5xMFP8oE5e9HSFZQIR9kZ7oCBPG7URQSDtooHTplMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599520;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=SirYR1LMWvrve6a/xVR4XwOsHXIfq/wONhM1KpUgri/8X+LXd+juTYlvHBj/s61J33S8
 h0Jp2BfjIkZ7EtkNzzFtEN3MW3lNIoBlIII14a5WIg3lFIZGUzsxOMCBq8uQTjcLCSO9+
 nnLeD/Rz9Bwyozbsa9dMdNK+jn6xZ19lMfzU3OyGaWWya3GMX6DlLEsiDANoW9z/LXTRc
 ch7fxipi5JsTBS4TcHZizn9URBGQ3cNnoTDIlgTotNrXVdD0pLR7miMchpR4plq81GktN
 yiC8bWehTmDEw2bluMarsuNrbSxbnDBs1i5XnBFnm13jRoLuxh0teESEWYyIoMX4ODw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="o6/RkBgZ"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=goZtkUeW; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=o6/RkBgZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=goZtkUeW
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 118D66079B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:39 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG3QBS900412
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=; b=o6/RkBgZZOyI/uY8
 cbSqOUdvoHpNiMQmxMTeQDQ4iCR5WLB54EKoThwYS95QgqbXJvsZdTInCwCArZMN
 uQZsRDAz4C3BmJOtiAGCYj0HnELSecrOJCrvixy2bl6s9D4SmEgllFg1an8cXzHE
 Y97cl0Zm+U6muDbXWRMezb6kZ2nr1f8l0HGajIhqgxmnvpvHM0xRoONmPKC9g9I/
 4DANCmF933/ttrTVOxprvoXA1gdHrlKA8mdxa4qWfGA1tufzM43GCBjgsuOS7TAE
 Xtqga5SZMRrfKi9cJqfB7juFVaLmejEG4TQz1jkzOrs+pUZNREnA0Ex7G3tdHak8
 3b/Lrw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2g2fs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso3331535eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599517; x=1793204317;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=goZtkUeWIDBlGir1tot9jnOGY8W2UhMEVZepiiPUUwIh5PDn0ACYEqoSR7hMf95bUh
 ciiB4yBTSONpzKvxNTBPIZ1MwPnhY4ycpkDmJYcbxUysGt+tEsN8lewnio6l6dJa7xOR
 PmfEmValUO511rm52cpynSEutOP87Xm8VNldCPbqGLZk+4nS3zF0D6FD4FYqPFLvJC0A
 zmusx6dCbII5ZSIzXPcLpnQtTFgWLcl59K8rZfo75kbNsNRU0BfDuTt0lk/+YCekuaRo
 RIX8oFdJ+mUebgJG+u6f4gfHMgRH4wi1felvmI5ngBMngMz7Qnaz3xQ8Z4DpPTHHNHRk
 vRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599517; x=1793204317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=m9nwQsuA7rHWiyxM5NBzug/juRjimz+Xh/qDWfM+aJaI5TcvJ99KBuHMYPQtzgyM2M
 QdwClnbcxg864jVqOlcZ17ux6+aB1dVkGZ8anKc1IP9jQhhFFUxXK0UF+tfvphSb1FXG
 aHpdcrU4W3HIPX2cqPg8bmYEClzMM55QoXG5Yseo2yqiKCKf7Lq6psR4DAO4a9ab9zES
 XLghrd12wcknsNBPd18S07/ZXsPOnslh+CLW40R/pbBy00ZY290WYeUvDLKbzA+Lym9Y
 HQODposy1SU966mIky00/ccgc5MfDbkCs7wyZ+xO1sUqKDOQiAPeAChUqKy8fUvg05sf
 SHRg==
X-Gm-Message-State: AFq9FYJKHMe7Z6j3MQr2Bp1cMUpxHsnewr8K3kVATXNMZPlW0fBIukHv
 Yxzz0t4D92RgppRsK+kqj4LMbeFOUfzypmKUI9m5WXegmH6K64/8YDgnwSiVtM16IPA1fe2gOAr
 iml2/dxM1lmp/DQS3F4opVL8pKZ9QK2fzQCS9WJLd+9GPyycNz2BpkuZSVD3dUVem0KpGLWM=
X-Gm-Gg: AYBFou3+kl+RLMut89eoEbtMawYLZVXKz+RLcUFkPUx0bQBDuO53OB/3ruCe8wu+1ob
 GrceHbrRodEwGv4vrEFN6qgbPTVjIIXkyNzawUEl5oZ481oIfBVLJWs43FXAjozOnIWB3eQH+ab
 a8KmXWkIKY/kxY30v5ZK/jXg2IpZpvKsSavGHvQtsLGbVvMYhjmhY3z3IlgqDdDlKWmAIObM89K
 wuUPgql+zkjbrqmqTk29D7tkgQj/GbgrhctVCmDCsrKdiuvTcs10ZnyjFeLHfE7+gw81LoEeXzI
 j8FeLABeNKGV3RFWxstf5/ybVUzJvaJ5XkIy5/NiFzMzNLShsNVosuWZLeVAspV8GjImG31v71t
 q7SBKbjNk19BhU83oYqrgzXhXAsA0BrTRHTPFJPQcv5WRjXRhj/Pkh1UwYnPMw0D4p3AicnyZ5C
 OJVwbZsCGaj7C02OMgWFz9y/KP8Xs=
X-Received: by 2002:a05:693c:88d6:20b0:366:e24d:a0f6 with SMTP id
 5a478bee46e88-3674e93db10mr3708615eec.29.1792599516590; 
 Wed, 21 Oct 2026 09:18:36 -0700 (PDT)
X-Received: by 2002:a05:693c:88d6:20b0:366:e24d:a0f6 with SMTP id
 5a478bee46e88-3674e93db10mr3708584eec.29.1792599516013; 
 Wed, 21 Oct 2026 09:18:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:18:35 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:20 +0530
Subject: [PATCH v9 1/8] arm: snapdragon: Make SYSRESET_PSCI optional
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-1-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=1142;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TfHvwBncGiGT5hjC8HrtPimKPWS1PylfevaI2V49eds=;
 b=egThKGHATPIjcbWpcQI3008dzVn6QpOP4nieIQ3ulILyMj94YmSfZqakdUMveD/hjyrZ9vt3x
 yJ59KJhHntZD7uCWCAreKUdLX1y5/9qaGGm1IJUBtwwCkWkQxrzo+Fx
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX0Yc/EtK36tXQ
 3+WOTkcVRZRStNWvujs8G538iEhh1KuWwETrh1SjaxjvE3yo7pXG0G/ydHNXezLPKkahsVjgkQa
 Phefxr2Qu79Z+Cz3oBgUYJiqz0rQUoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX+kgcv9ejmNX+
 I5NM5jCefb8abf1mQz30Iig2t8Ljn8cn0Wd4vSY15Lnts92eePbIiWIRvrPsFB/ylks7nK7Q7kN
 yaGdImX0T5HfoHBtrajjjNclAqkn9RHFWS/Gu1Ocjdwnnd2IAWLwbs1wP8GpjsdZalQ3Ri771i2
 x19CwQ4pBvjQ+MOuxlFc1NkN7Pveyo9MWhDUj+fGlIY9hGJQkXgNHC02dJeFA0EWIgHzJ3Wxx87
 +t2mrd3fXm7VcsNLHFc0jwkBc+ObVFtCw57nzsbI31sG1j0YDsRffd5Emg1mTh4eZ4R4znseZ5K
 gHUGyqGHNRXxzmaxxJxx53xm1+FKLIGabAzVe0nc3Os24iaCuDCJg6iwImN6Yke6pm2glWMjIWq
 C2yk1TqqDvvqPjJTPd8G7ZzFOYcAmE9uK4M7CEjKQjN4Kf4WHQDiAd095s4IpQRz5PGQSYyWaZ5
 ZQ6xr8IyBLLZzTcpkjA==
X-Proofpoint-ORIG-GUID: tHfwg13dsn5euOP-7kvM76_OX55vuEbB
X-Proofpoint-GUID: tHfwg13dsn5euOP-7kvM76_OX55vuEbB
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad8e5de cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=881fuD-RhmhaU7In5wAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210063
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

In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
attempts to make PSCI calls so disable it in this case.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- Make id dependent on both !QCOM_SNAGBOOT_MODE && !SPL

Changes in v5:
- No changes

Changes in v4:
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE

Changes in v3:
- No changes

Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..b438f0b9c14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI if !SPL
+	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE && !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	select SUPPORT_SPL

-- 
2.34.1

