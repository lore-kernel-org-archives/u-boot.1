Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81808606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FESU+eZJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nicwndzt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAVVEh74
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C6FA60A38;
	Thu, 22 Oct 2026 22:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JL4cpx9IKYY6; Thu, 22 Oct 2026 22:00:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFA24608F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792706444;
	b=Y0FeQJXCetbYfIaxs4BxHMDROzl804n2+aqtY4BMWaw++FtyBXsgfEWBiUzOcw2DKbE5
	 BxtQrNtRt4HwAMQz1r9Op18BSCf1pBV6jIHm4ZgODxsDe39JmQv+iae+LGGW3GZs/CVFT
	 WUhmcGFNcDLTBgkedMXgI79xeBpZx77rebcFzDZb5JGaDyKiHeLdECxsyZbcIPQYD2Xu8
	 tvOkEOgL1Vo8v+g4SJiIoX6gtcLgU0L8/jvECPcczGBqWZ66UsOBNKHTawhsogeWFYXWz
	 TquZgUuNxoq77U9ao4EgeQXMtYcCJLksN/qbj/RQYdfqaMFuqq5fCFAJEXxXJVXBgdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792706444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zZU1iNDFvwcSZ/6XuB/CYV5egT4+jCyHSXHXAhiEc5o=;
	b=Q+wdqoyKR4CRYGjbitNp9/xX3RW/hU5ci62KbFiGfgmyzwP16GBUldBVte9nHb1nS0r3
	 OOfuVyoC3QlcbLr8m08xkVCe3h9vQpuQGbvydCMQ2imjCSM+Dzgt6V8ANklTZXC3BAEHc
	 7WgXls5oe2/puCJHVZRMfDKqSRREkDW1nTaR+00f8rdPvdY1BleIdWHfkBM7Wpw9IHPvg
	 IEO8h0sgtm7iYrG4dh29Q2uoj2+C/iKGs8Qvo7evl/nv4FpJpv5dslgjCZvDzr739EhDJ
	 YRAk/mu6Fycnt+DI0k1ljW+vNRY7h/PdsSOwedo2ZNY2s1nSgdsYtLZaKT4FhdizfiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nicwndzt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAVVEh74;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792706444;
	bh=zZU1iNDFvwcSZ/6XuB/CYV5egT4+jCyHSXHXAhiEc5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FESU+eZJd1Rv8SY2XGuaYyQDVxzZtf6bWk5dAwZc6lQsNBG+G7oBXcu15/nbDRYGG
	 qnVengYqmFGFHm4ZA0eQ+eVkW7rDEDnyrctaNlyBDBH7P5gGVKw5xtmmrp/2OqrmxL
	 pnp58xzUdWtB5gjtRX6nxna1TGLlacV34nZS71LDopi5SK4fHk/o4XSTufyibcYWTm
	 hrT/HYvbAxn45op5/dvNpEbu1SQ/PcBWWU4+RZ+uifLU4+me+0RjqWm2OTilVA8XZw
	 Oq79cQZ4OT5cndBtxyrtvY1G7bHgqE3DOipO2yFK7VMHNxlx6Ky2Fub0VTmu1AtsiM
	 KpS1PKtVb43Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFA24608F5;
	Thu, 22 Oct 2026 22:00:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42C2D95C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 200A0608FC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2ZNFOiHfELs for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:00:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 91B87608F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792706440;
 b=eB+mNxjJpbyn78r/hXz31ZXKKKNpnrTJZbWXBR7UkSd4k6EkP1+E7ziNC376ccUOoscS
 rAG7KVQXgNwpKutjni+4pL++CrGQlNgMwgjVS+z0H+npSl0ajzRNOdNQTHeC297YgWN1i
 2de60B291F8aFvqokgxIqkuyXMdspH2tAswvaD31I1eO45zJxQ5R61GYsTedV36KUtEEt
 Y20DyYpyU4R78B6ua/qKFzBBjnZ8isQbDOZCGhcTaI/B+tinsZUYkmFrCCgOsgc2nL+7U
 Qv2zWWLT7hmuUyShF8ZR+2WGvJlSkEsCZocBCDYse7dZE/tbvXVx6GudvPRSJLdMIvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792706440;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zZU1iNDFvwcSZ/6XuB/CYV5egT4+jCyHSXHXAhiEc5o=;
 b=Cqpd0FpKCXja3P7d3587Jg+gOWfoiC7/2q1VhJiYm9lEUX7jxRCM+nrWQqkbUmXXTnLn
 QWKU9My70CqAHeXxkvSvUuoM0CXLTuOLKNSDMp0nQakNkICrRjgRDfig9KAuk4dtBCqVl
 fWaYvaJXzxoiRh2IbHYgrSAIa2ae4xc9wvznQvSPp9GuXIQrHk/LhRDMuyWGiXaKbDEnC
 B8PKG1JdWph5ZQKAs8iVRfVMkLnMv+BDLieXrmHLBsF3Lootj3qXGpUlmeNukvhyJix9g
 piznBgoiur1u0PGL0HmfrDEr3IcV5mkdIVtkKvqvcw++AGRjjRa51m1PGGcMvSh0JyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Nicwndzt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SAVVEh74; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nicwndzt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SAVVEh74
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91B87608F5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHAQO3741647
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zZU1iNDFvwcSZ/6XuB/CYV5egT4+jCyHSXHXAhiEc5o=; b=NicwndztMgIaHtWg
 P927WA+vdNo7ORtFiclozkCMy7gc80ovYKdIZgftYzlbnWMzHUIV4xtPAXnO2n3L
 uFl7+rD57oGWiQuCX+IxGoMxw2Ujjz0p2ACUdTaHvsvVuqGyCfu4H046k20CgFUA
 +sOEoBP0Z59wrArbL6cxV9iV9r2nCsXHQUYGRo/cULzmk48LCbWmjCttHqFc7b+/
 fI7nESBGRyvt+J4bQW1A64fqse45ZK0EBVLj4IUv0KHvxpOgco6c0AYbVjrgwkig
 eGN8foQci1VRh9Dn2KsQ7y6y4I4ec8/hqya3gp1opUCZ5edl42DCMJytw2X+uMJL
 FMVt4w==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0qkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:39 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b09ee23de2so6019627b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706438; x=1793311238;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zZU1iNDFvwcSZ/6XuB/CYV5egT4+jCyHSXHXAhiEc5o=;
 b=SAVVEh74oYRHbPCfDHOGcB82BjaUdsP4O2L29y+u6jhXqH3XF9CAculWDl3/wt+J5r
 nIcslFhbUSB6aXLfYSORe2CPGMm2WlsUI0/DhbiPKK1uxUUCVwTgc1alefBICt+n65lq
 mzQFPCTKQmHSw/yD/fAXtDreG77arqMGUy7NQjxPZEmy3+k+fl4z2FhLOfYT1+x7h6jo
 tne7Uv3nKWVrKBXMK/FEUZbpheUdM8z4jnUxV7/hRJwDmkq2Uq9lPeI6x2q9djIcKCk2
 XhQkWmKfiCSnHDhURPDDf75XOK1bFMgho384D+h2C4XI+hFUan8GN76Rjh+SE0jA/TWu
 v+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706438; x=1793311238;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zZU1iNDFvwcSZ/6XuB/CYV5egT4+jCyHSXHXAhiEc5o=;
 b=cjfsFt0GphS4+OOuHlyYM8DlQS1xFvbtpKMUxiAAR8Id4Zk0Ljna1Nx97B6bHqpjh9
 0pVNs9TIivqivsO5Rlf73Gwi+CeNXm2FA9LhRKF4WeDnaT2tC0r4dhGi4GVSQjeC9EMN
 /7g75PRTuJ+nnDrklEbQ1zl0asRj21ZFyEjHLUTQrymWDJDHfMunKKb23dExI6BfEn8J
 nUoiUsKVNNPpbIYceSKKtFwvW3eA4hPZ1DX7nzp0KoA3x0IbEDR2gZPlccX5GgVKhw50
 gSZKjWWLfe+LRiFQPZ1fHNK9hm4ZEy6IrsdYcO+aw2dtmstr9YnOJq0tsZ05gNYZqsYK
 jiMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW76Ds3PAAImIeafOxGpw4EXI3P9vM/jggVwW6+4CLv8iErHsu1jK77q2yUPnuVSROEb5y4Oo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIzwIGG5W4bpR2uGjIjoOVhcpQczaXW3fzLtpj3elF2+flLhwDL
 h/taduEeRICfWcsu3go2qXyJHjATXimvoDdGYYqn1mVfSjlF43lK4g8YOgqq1/CD0zAZsVrAQHQ
 WUJVUTUr/3r7pKrv7rLGIBP5m2n86O7/5GRdKnmoH2eLPflhBBB2fWq0ooMIXE0X242e2SdSD5B
 ekgEU=
X-Gm-Gg: AYBFou0Ryc0/+xgULuS9UW7h0yYGK2Bw3fh8N8h50/zsgsl1mT8P5ohEjwaMPMYoAQN
 TJOacxEIuhsP2wKR1H1tXOUFdYI3NQlEgAIgwM5KO3tVBVMNNHjfHqkRmNuxqEvOFv3rG3sh9cG
 6a6KKnEyLPlajp02IVsTfrX0pY749PmqM7ibdiyxgDD1jWUbCDnQV50YSMdRkCKmkYYJp03xzGe
 +WVsGfUPxhnMKoNZk+QN+fNAvQ/OJoBHxZWeD9ErhHtxnRCCM++ds/4IIXp2VGYYkpgJV+4hKjV
 Vi5IBTkwXSqwWmo6TpjWrQMPGf5eglWw2OKWppDVP5ihwxzKEZxZbktniMAF4RyTDc3ocgnuvQb
 cpHh5U4+Hlsljinb99PFBOsmC1ip/5o64jSSw+A5YjS/VwHdK1livXfOxjj8Z
X-Received: by 2002:a05:690c:8e17:b0:8ab:a473:fde9 with SMTP id
 00721157ae682-8b157df088emr2452737b3.95.1792706438261; 
 Thu, 22 Oct 2026 15:00:38 -0700 (PDT)
X-Received: by 2002:a05:690c:8e17:b0:8ab:a473:fde9 with SMTP id
 00721157ae682-8b157df088emr2452507b3.95.1792706437709; 
 Thu, 22 Oct 2026 15:00:37 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b155f8db4asm4934347b3.3.2026.10.22.15.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:00:37 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>
Subject: Re: [PATCH v4 4/5] configs: qcom_qcs8300: Switch to monaco-evk DT and
 enable new drivers
Date: Thu, 22 Oct 2026 18:00:33 -0400
Message-ID: <20261022220033.784485-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021-b4-monaco-v4-4-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
 <20261021-b4-monaco-v4-4-c90f0c01d312@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2tzNi5J8vM4L
 8jV9tRbsLiZCSDBjZiIsU2L1oHdldb8JZ1Tha3FHjhCukQ8aHen6E8qBx30HOP52Ydtb6uXGyze
 4St0FPEG7YArqH/8uXgJONYoM6tOW0qicbmOElzf3n+Ni0nu76YG0dngoYNXhSkKZGO3eMw8Z5Z
 nIaJcybk5dNGCGixMC5cU3SELSpzM/wEnRYAn0NOvb5C2ykzy4bFSuIBXcj0Dk13B41r/oLvPh0
 jeltHtwMGeQ5za6/75s4gFSaIMYD20qcrwuitv/DYT9Qo+YvnO1fkwn0clOCe1O/WfK3TfdhMFq
 uFnpQYMpN2Xt84ZCRCGS3ulyXRfbC87TOPDaErW4+ce3y3Q1IsBwAG8gJUiV+OY5Av/8M2dmcTD
 jpAOSbpVufRFAj/mDYez6Vb6Y9OUk6EjLZHHUEyT9WZowm/xykO99G/hPXxXDdkzNJ47qp0gFRn
 HblNxCFEELQ6vPY0n7A==
X-Proofpoint-GUID: XoGvkWOq25XUkQTPZvzbdFT2shjt-3fO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX1UO9rAHPMEs9
 aQwB9qbI2UdMxo56mh0LNm9jLKArdFk47TqZ39LhUqcufVI5dbApqI+d2qcpIUORv7mYiGjaaJn
 /bOnHR7SK/9cKJ+G/S6kEmxQOH60w2U=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada8787 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=p8VvgLCOea7M2xW4:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=HFS0ZpGHbd6Zo5_XLC0A:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: XoGvkWOq25XUkQTPZvzbdFT2shjt-3fO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 12:13, Balaji Selvanathan wrote:
[...]
> -CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-evk"

Did this boot to Linux with the SMEM memory map?
