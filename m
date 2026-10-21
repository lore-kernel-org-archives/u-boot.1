Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4496606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TaYGtAJi;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXyuQ0ks;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fh8SIv4m
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84DF84078E;
	Wed, 21 Oct 2026 06:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2yisSg5FuEWc; Wed, 21 Oct 2026 06:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7EE89406D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565730;
	b=KbuuT2gfe8IznbsRsyRfkwUjpvdmc9rdqMyUvTWEvP6Ve6fh5XaRqXWys8ljaZYi8gIA
	 cC9hr0ElnOqQ/Xuu+CStZcXchVqQRw+kFi0UOSoqMYyqZuFGy40DfLQtNonICeUZ+b+WG
	 UpnpVYap1GwwMYhrw6fc8nh1rJfsmQbADNUUkVS29//moBj9mqfxT+eA4IKODKaatQX09
	 Wgo9G3d8UqioLfvOMG2Kgtwc/UYefh0R46i4a/rPDR3sMptGqWba15DUR2oLMyzcfZtdR
	 Bx26tbUhx2Ob6Z94PsEg/ZD3kXdrnwPOPYZF/VoOtPyMcC58gbDA59pEuS0frCGDBcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=56Ny/IRCuXzpgDcVw4PUspeaKnL3QsffxpA6wxWv9N4=;
	b=BEo7X/z0S+qS/ZNC6/YoAayCffcb7Yzh7kzO8aJR14uRqJbKenRGqErAfhW9LrtsYlWI
	 966Fq1iNgXNkDUKDVRfEu6PDsr7kN3GYSbh73sEBCchPDRfQoHvT6qhlwE1sIxpNNPGgc
	 IUbz9HMnesPGb8ST72pBgub2jRA20z47hsjqCkcgXs+KTexGrxrCy87TcjF4baHaezGzI
	 KfpTp9/VvMOEzV/OC0P9R7In+DJhfwmxIc20572+PH558HpiviHMtHSu4kE4F83ag+J5r
	 CdRIwOLvdveLIq8kD54iOwWQNqgr1BPp7OvFQRx0pk49JeZAZhanqOGeD7LujnG0oXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXyuQ0ks;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fh8SIv4m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565730;
	bh=56Ny/IRCuXzpgDcVw4PUspeaKnL3QsffxpA6wxWv9N4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TaYGtAJim3R3torVLtFQtZKmt4xku/jpx4vPfRNQkkT4tSVuwDwRXuQ4/lFnbapSI
	 ruHNoAOLFFfU/O+KPJB9oXE/g7VgCFfNX26rlhGJUusQhIjK5wBy73h2NgFz22Jorv
	 bjonL+1SksRIFFjCdiYnrioD6Ha85ENzys2oEQxgRc/+w00ufsK29kchVxuluIVz0N
	 mxTyVQMSVs4My95okw5AylMzH+syQPes0nN6hedRkGkzhHkrjIzV6lewdk8FjzlYC+
	 Hu3xoX1W4yO2u+XmeCUMLycqeVbESJ4Ng6abzE9vb1HNnlwgE3obLfdJLGB7NyiZ2g
	 qNcNvd+QW9bZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EE89406D2;
	Wed, 21 Oct 2026 06:55:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F6B93A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80C5E406D2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMsCLA9jHRWk for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:55:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B94640589
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565728;
 b=AtgCPGOuIF11uAoQb3fxGE6pZX80s03I0PlUu/qOREIQVxPllZ9BMa7crvZKH/woLw47
 aD0asfLge+n6TbN96ZRMQnM3JSduPgiIPSLaQC12mOFYQnlwg9TuddouND71irQp1yjQk
 cSK94ckXL68RkRhuK4jAYZO5AgIZlOKtZv0k6HYNarZSjEmWEW64Ra6aMSFPpv5sEir9W
 +E6WrfQaUp2hmh1PArz39ZOYXzLEyUopBjmmRZITiVWmgbKL2Jg5Zyvi1aAvifBraf/9l
 jBkgynzBSwRSpwO7CNQT2HIDx4XZ6uFiLY8lxOBVehHFz72yIQRD9wF3O7HE4dXZ7Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565728;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=56Ny/IRCuXzpgDcVw4PUspeaKnL3QsffxpA6wxWv9N4=;
 b=sz5lwwWehxwcQmLyRWy02ADjnSFuJC0wMz4gUViNiSopA+KzVEfDcmazIb1CCNp4yvhw
 D5rLW+LCYW0I1s8/1G6ttO/g5lJeZ2ddJSJ767aU7/QLxNCk+IeUzbryRW9VH0dPr5QLV
 9LL2G7ka7plshXB37a3XFUfGS/wvUOce/AMv/2F1aymVivbGT3AYKcHPEgYQJKOgovl2F
 eb427Gx95k8gTk1Bfb05BjbrCJEzLHD1asyxzVtNRTMjhrKSj3Jd1ykh7tXMsOZrmU1PR
 QoUvzn0Irdrw8060CE52fiHnV/s4CLrjZeoyQwWwTWu4Z5l94hz8taQoTvU7/8jGtFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VXyuQ0ks; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fh8SIv4m; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXyuQ0ks; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fh8SIv4m
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B94640589
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:55:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j7sS2411355
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=56Ny/IRCuXzpgDcVw4PUsp
 eaKnL3QsffxpA6wxWv9N4=; b=VXyuQ0ksP7drEJ3CGBgzrRkvSg9kp6N9Uct61H
 d+6SAH8B6GmxKGbDBsjzYU67oZosZ2OF3b10YozTfWEBuaBuw4HFvhzVlFXFj6q1
 GA/YOE8I91N6KpVLKM4ai3CzcmZIfVmV1mA3Q15lLVPU4dYe1pJeyU63kBH+9EGZ
 KbZCR7Cm6DyQFKUPoHDziK9ErXbihZ332GuvocbfJmt064KVPP1C3h6cp3A2t2Vd
 Rk6p/X0uRRmzCs8KHDJusizKeZTp+b7+P0TngzY7jEia7zlEpHvEhoqvduQ2cCjZ
 g6NM7MTp/GALpgQA/jlRwisqZuvnzoVREPP68DXBF/L8iW1A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvbwbn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:55:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so1566148eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792565726; x=1793170526;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=56Ny/IRCuXzpgDcVw4PUspeaKnL3QsffxpA6wxWv9N4=;
 b=Fh8SIv4m6+2+fXnImsAuPhP6fDSEsPCISNoXEC+RVeVC8ynZabrwUZio2rW9K1zm21
 w3fnfXJBuFk1HaK+lyWWMh2eEuRfvowX5pyykO3bGKoU99kFBdMk9XreJ/9p7vgWv3Cf
 rZ3KrkGoByzbIhCobm3MKE7nBKFA5XkD82029WhzHVUM7ArSKXAOBL+o34JLjJDTTwvF
 QZHpQvnvMAAnL+sTK0yRiSYSEWoppWbExEa053YSBILScMXa76GZwUW+briOfSe4+lJu
 r6nQhQ4CdEJWVYqLLkLFLrznGDlnbgj5P70MqxG9078KkcD/DOxkxCbasl3Gec4vSZM3
 HKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792565726; x=1793170526;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=56Ny/IRCuXzpgDcVw4PUspeaKnL3QsffxpA6wxWv9N4=;
 b=YUC8NmVRaFkkdUAZZiqeQqovM73BvVCldFjEI8G5gGr0XEpG9xJQKkebzDtc/1VzZe
 kYnpg9ST6f4soIsrrFRzUrct5j/0+3319Oho2/ik3ikvd6dehHhRknV2ck7g1HjGfVo8
 2Jz12nEWE+QocC4dKOxrv9Op03g5ceUknHVR6fbPi1RBXHAHJZQo+W6NTs4HYjFO6N5e
 UUp4z/Ywy2mc5Lo92OkrgnXiIOVcz98PqoMg/C381Betw5wy2EQM0P14T8rgtftcdAPv
 xJOhcWryiVpcgsMC7e2DV8LC+J5g2DCX0TwB6K7kXB7k4Nx3KD1zHTyCVJHbNfs4lro2
 sjrg==
X-Gm-Message-State: AFq9FYLMsfXEv/AfNdoeuWrEiwVFGCceBRMdOVdprEyj0A7O3qyMffUx
 tdpV2Lz4jr3woZOm6jqr9KfVkysLdaEGaaex3O/W42oojgZXDHaCb1Q2b+oBQvlbuS0ZO2q0nT6
 002u9Jtz4+rp3CLp8JWUXGBGJL0eswyXosGTahEyuNgiaPLzLqP37NnyEzY9G/RN9C5KzYEM=
X-Gm-Gg: AYBFou1MKzlds0+DaoKdwLdaDcLItKMONpKVJPMvjgru+Z5bb86RfIuQKF2n9fvBez/
 TMTLbmTV2hzdJE1RRDGZVQJAHl69zTrXZ2ieAJSz76bs7WsQkGq2C957557YyBKGjCsnWRGgc/B
 sCNmoGBwd91UAWWWSllF5tm53vA803F6Fty3XW01J083Ft5db9BjtH7C9XyQsfxGadU0/DU7Hg3
 NNL1ZwDUX77xMrhjurqOnhFJnHbBITLtgyih4XDMwZ7SaN6PPqRMqMoTWOBAOqgTZEsSKqKPBoK
 b3QhqRBcDqaaWa2YUAZx2WVV8uNBzSfoDSdKxhX+eec7W7n5KV4Vtf8VicGH+2eNOZ9GJMPnj1L
 xNJlaumYhKeCsgdLNePtUn4aIi+qsq9YJgzMsdtqLKS89ngZ/l07a4D+zJnwHTlEXqsHf/RWEHk
 awPbfengj9jZY6BMOX3mzc7PtICJgw
X-Received: by 2002:a05:693c:6382:10b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-3674f6143a2mr1972198eec.40.1792565725666; 
 Tue, 20 Oct 2026 23:55:25 -0700 (PDT)
X-Received: by 2002:a05:693c:6382:10b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-3674f6143a2mr1972174eec.40.1792565725120; 
 Tue, 20 Oct 2026 23:55:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ed295sm4856988eec.9.2026.10.20.23.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:55:24 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:25:21 +0530
Subject: [PATCH] dts: monaco-evk-u-boot: add reboot-mode support via PON/SDAM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-monaco-reboot-mode-v1-1-41cd3c8f15d5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANhh2GoC/x3MTQqAIBBA4avIrBNU+rGuEi20pppFTmhEEN49a
 fkt3nshYSRMMIgXIt6UiEOBrgTMuwsbSlqKwSjTamW0PDi4mWVEz3wVLSg9NrbubKPa3kIJz4g
 rPf90nHL+AAra8flkAAAA
X-Change-ID: 20261021-monaco-reboot-mode-be5847850698
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792565723; l=2038;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=pq1A8FLIb5QhvtqgwZwZ2tQVdrXWtfVz/+l8ktgTp3g=;
 b=tgeTkd1WRgv0IjDPi5JNI2rCxKVcXKxA7Vr1qznVqW2dJZqLe06EByJQdfrgyqacghMxADXl/
 IWaQZwYeC1uCVf31RMr2v3HdXPrBYgEV5P60Kkbf2GrSikTgBHEGfPy
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX0frrb7bUjZkY
 bjjsHlKVuvM+E7zL4HkzQexF15SgHUZIS1voDqNCRLAyhaEMWQ9bB0v093KMD57b/bb1SvdrzVt
 q/mnTMEWC6O2NeM+xCCg8k6kOwcZ32Qtk5W6sPd6bdu8AnJ3cTEvfW2FP2lmDX5KFt0q9Fv5pi2
 bqh+qHZI/NC8lTh3VMhNvmuIPcZaqr4o9elHECXBIA7SaTUvZJNNMmC/phmFUQYX9ZW1VRa4Iqg
 5bSo63qaX7DzOtiMZlVE2+YRJznxrsHeBew6NvIPLY2dE3gZlBqLruL2tyDaGTEJ6XcRw0JixDG
 O1VfmZbG17RG+vJo9elEFEWby5RWmeaJ+MtmA2sCAhOhNpsoo5bPRMvhJM38+JhwZwWUl4o81/c
 aePTEqek0YyY3Z9G1jirrrGrUVh3IbQk9d7aA+fYtFWSBt+eZ0J6YGlP7Ib02r7T/RdQO+vt8JV
 k0a2uWDRYMbKafH40zQ==
X-Proofpoint-ORIG-GUID: G8dRbnGrwezj8SrX_Ch-MppKCp3KdWqt
X-Proofpoint-GUID: G8dRbnGrwezj8SrX_Ch-MppKCp3KdWqt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX2MERjXMity9L
 UIsbuJBaXATlkXoYNthSv2zKN9k+xn3SWQPfKJLISSKm2CS/0S08yD3Qv28/floV+JTDU0IQIt1
 ZNIWFf2Mifoiia3XwZ3xoqn8hzBrxnE=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad861de cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=KKAkSRfTAAAA:8 a=Ki_6cFBqtCwpExSohEsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210027
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

monaco-evk is in dts/upstream, but monaco-pmics.dtsi that it includes
has no PON node and no SDAM reboot-reason storage. Add them to the
U-Boot specific dtsi, along with an nvmem-reboot-mode node that maps the
reboot reason to the bootloader and recovery modes, so U-Boot can
read it and stop in fastboot instead of booting the kernel.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch depends on this series: https://lore.kernel.org/u-boot/20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com/
---
 arch/arm/dts/monaco-evk-u-boot.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
new file mode 100644
index 00000000000..5520d111864
--- /dev/null
+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	reboot-mode {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&reboot_reason>;
+		nvmem-cell-names = "reboot-mode";
+
+		mode-bootloader = <0x02>;
+		mode-recovery   = <0x01>;
+	};
+};
+
+&pmm8620au_0 {
+	pmm8620au_0_pon: pon@1200 {
+		compatible = "qcom,pmk8350-pon";
+		reg = <0x1200>, <0x800>;
+		reg-names = "hlos", "pbs";
+	};
+
+	pmm8620au_0_sdam_0: nvram@7100 {
+		compatible = "qcom,spmi-sdam";
+		reg = <0x7100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x7100 0x100>;
+
+		reboot_reason: reboot-reason@48 {
+			reg = <0x48 0x1>;
+			bits = <1 7>;
+		};
+	};
+};

---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20261021-monaco-reboot-mode-be5847850698

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

