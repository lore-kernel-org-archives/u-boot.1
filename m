Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F7606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1Anx+W8L;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c/p2MwyR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TAvUO5DB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B5AB607E6;
	Tue, 20 Oct 2026 06:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8XyN7AsTWz9y; Tue, 20 Oct 2026 06:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF730607EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792477779;
	b=fSFuSCSvYrIkxxw6N1AnidPcEoIyB8kaTAkQO8nJ3Sgl7uLE2lSPXsBBK6iv0QCcsdjB
	 B3yNglPDwXhecje6y5mxYyWR+EjYuvZzQvmgBhiqkNf8Z190DuJRXTtjLhDEdI6/WEVRK
	 sZio++9jfx9o1mTseGkjc7WBJ/5ez4O99UBdqQDPpqmyUOcEP1GVoC9FAx22phTO+ezAE
	 GlIyYbqQPPRWvqS/Au/tQcFPM987gsTy75ZxlTiKbkzSm3+glWvzJGRiw538t1kJ78t3k
	 +g5XYSI/lKZX8Xdia879CifatTXhGFFWOvr1w2+yB7Kme3hLU+a01MJKOtDgw77W2Ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792477779;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V+ar5XH6qC/U3Pu/f5Z02QN5zYfCA9mX2NJCUwd8Jz0=;
	b=AgL+tH9YKYvvdc5YQS/4fexLuOGaxrqASnwoEU0wAREemeEV/ZVCw1QfczJpjp430zOa
	 L+C6V5T+8kMRj/pP3nasmnQ6egLruNo1eWs7H/bUKLXYhOjLHhGe2iGD7Pb+8ZKFDXv5y
	 wi8TepA9wymfUPc+21nP1kzM0RyhG3VNAGszhs2xHK1SaJr9/9dgnnCfdo/vhwOWDb74g
	 H2IbeYEbCyRYBsR/eiX8xUh3oLOmMPeH8cnVU/YcJTiPk/OjDBm4JTdRPj7Z9X1+VbW86
	 Btn4XY3KAOWXEkc+etr8kIhkGglV2jNEizo4leHD6Bw5A4o0AKAkPRjknUSi3nBp/Fg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792477779;
	bh=V+ar5XH6qC/U3Pu/f5Z02QN5zYfCA9mX2NJCUwd8Jz0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1Anx+W8LJG4qXqufGxBSvBtjnbmTSjyPJ/it6XtwwJ/SgNrAs99y8cAq01GvZsogG
	 YpdU7Xlms3UWsGfzQLAMnZ36Q0ku1CIp2FyQrgFTXCwCbtDV/dIrPRITVp5LVC4iWN
	 tGrrQRzpitagcGZMXoJWoucKEqUup79S9DubTm+2qJy4zuoLB09xMteAUe9GYacBpc
	 n81tkFtD2z332SOLxMt/N6HKyEW/BWw4vMfhSk6FlQOAy/FKxCb8h8KnwkgSb2f6EF
	 eRAriAJeWCX2AHdUW4bWnMiZfPavVmxsjI+7jxNnWNYSN3UQgHNbxheQpjvF+//1cX
	 MTYnClBFWsXIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF730607EA;
	Tue, 20 Oct 2026 06:29:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C06423A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E003400D2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:29:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WA5zIjAMzZRz for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 06:29:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4CEBF4008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792477776;
 b=BC1aUgNfOBmnUsPocVRAFoyq8gxXtNhuFZgu5lNNI6oYq4dwG9NGpjkmiQYHQgGFFApY
 JhFDIbCNYJE4St5mJu3YYqvtnY8vHUpGw1kw10EDQzSCkATS/m/ZucXQd3dONT8LnRONr
 lVchQxg4ZWYk0P70vCsIyN50Aa0Tx8G1FhxZ46bpuph2NPDf93cn3VDHLvaKDM+JGhyE/
 g4+/EetkRpexQwgdIRg8J2p7dpVamRoXgKjkqTwBK1PPoKn8JzwGaN1uqHdLLG5qno1j8
 OaDvRIFeuFsrdWhSrLt2LNOZS0EyjKTcrJEfin9sCA+rUkPcEfyAEgORhCf3OsxwX8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792477776;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=V+ar5XH6qC/U3Pu/f5Z02QN5zYfCA9mX2NJCUwd8Jz0=;
 b=i1shtRgjF5lY6Tp1mAIEDA5RTaWWZI7WtEI+ZRQbJYiKCGRIJxMqgRPXVNZxCMd2L2SI
 uYa2TEVI5aCEdiWGT7W1HHyHKtnIb7VfHnL+TO1e+Tx81u/3QuSEHS6YXK1ascl/29pGT
 VTIN/LjUFfHiYfRmy81Jdn6kQwgK26m+JXs6o4eJAROG/DeVZyt2omEzAAFfEAAXxpbPt
 rSy1a2SPqja5nDOyDdspLB5JzHyFjQ4Wn3pCXCUzwx31RvqzGJDFa2Z8J5AcsaBJhUpUn
 j3avlKq+OgHwHpk15Tf0RnX2TjaZrl92niQ7+siNS6VoUbMDwChYeyPNlfX2Cv0pzlQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="c/p2MwyR"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TAvUO5DB; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=c/p2MwyR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TAvUO5DB
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CEBF4008B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:29:35 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K55tJ2675257
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=V+ar5XH6qC/U3Pu/f5Z02Q
 N5zYfCA9mX2NJCUwd8Jz0=; b=c/p2MwyRsScF4oncqB4rTEKRs1YZTk2M1vB4Zy
 8x5dmAZjSoC78HSIdiHyd2CvLgos56EuDInuZhfK8BeNnQ2Crpzm9jLco6KJJsJ8
 p9ttv3Xl9KMC9jdClLZpv6MaHnGry8sXKYQ6+dqiNID+h3s4dBm5t12BTwR4k9z+
 Nlijyunb9YvwC8LFcqYokIjbwLD4SSDf0CVPwwTNbGNZWoYn/JdCKFjvD/H+kPGi
 FeAzUXVkufNnN1+IwWHw7PeCwu2mZf7kUifXBziQd9ouotm1z7WSN+kLwohJH/1m
 8Ehokn+cvSgrrwDjdgbsJletNBuA0mCmqz2eJ1vqR3HKpvwA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n169g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:29:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a04491c56so459064eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792477773; x=1793082573;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V+ar5XH6qC/U3Pu/f5Z02QN5zYfCA9mX2NJCUwd8Jz0=;
 b=TAvUO5DB04u8WUoymYjFAccvEzxTB3G9j1th10memeVLdgcaYtr9MxaQpDL++7BnLW
 8aVRtve9mN2+ZaEiLbehoOPZQ8NnWNbAkwHts6SDfJoWJi5bsFhSBDqtDG1Y5Cwzu6QV
 zpJ7QOVmfvmtW/j9GCkV81mBCVBcYr/wmNkC8CmbxGN44Y4gcbDrae+zk1mEeC8eOlIL
 P1FGb8ij3Xg/3ccBGsmCQLXcvktpl8buuRLEQlnmDPd6bCHJy4cgCinz/b7hMJdoedvq
 fpzscAhq2OmWPAN/2/QxW+m2vNtxXyGfylk4TieAGjqFHJpLfg4CKNXwgd4/0DCmibEE
 GPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792477773; x=1793082573;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=V+ar5XH6qC/U3Pu/f5Z02QN5zYfCA9mX2NJCUwd8Jz0=;
 b=jHgMCxTq3I8YPb44Lct2+lbsL/Lkak9IvDzrSwr3Lqyyc6ZPlt9tCAu/mTnqHXpTPp
 16yn1DWG+gyhrzqPfeq3MD6aCDB4Pr2827Sxk7tSfpW0j5HLI0GIrfPv9faKCKS/Dhb5
 BJBWm1h7nFqvFALjqfvMQuNxTUc9udvEbxhE3lyjzBeI3TvIoY9pEjBfs6oKZ8pOK0J9
 7+XbCJqmAOKzshHmAQ2iGEwVVT3j/8z0NvoEepbonhUwIg8XyeVUEybj7a/c0ETr0NC3
 yByZZh9L/ugkrgN7fM9b3OLnUlUcRt7kXlTxdP0UIDtK92NoXfDPpbJZ4VxS7yxS4fv9
 aZPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZBi/E8SUF1eHr1PJO5RnZS8aUp11rPODpmyjnNoHC/DdNunVOPZcapwGNhZHgIPoAH5lR5u0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLAvsycGOlLL+B3OAYg34Fm1CwS5gIhW5S+7H5tqT03vMrM/BnQ
 39CFCuh+L+8vgernLh+EhW4QzulFVp931fX6mrb3toQuxKJBD53KhaLqZ12ilDvLyGS3aCr94IO
 oxTvhC6WFGgRZuBj5n+OvrwRM7S4FTHvLCy5E2VpZWJkcFBVyGmJ3ub1EJBTm+RJzCgchAeU=
X-Gm-Gg: AYBFou3KhtQT79DB35ulEnEVScl5fC/36RKIZSQ7U1u7YuOLzMVdmB6Wo/rji9BOiCb
 Jm5F2wuGrTMVQVhajvk2Juf1+P3SHp9NYGeSYP9ug/dKXJr4NgvHc1djpWPoD2ab8eso4BSglVn
 VRJ5uGmc+/7S3AXHVIRJwpTDC/eRuQS8gTvQn4UjaRYjiTxkUncnq2T6VU+k2B9HQv0pAwK1sG2
 t4QRFzMb70kOZUxmwG2wtXAbx6O1Wr9enRbYuEn1rUBSo7GtrEsCl3JdgVsUFFp86mWs4Lp0fnf
 cVINGutiQPri6GgDyAvxKV7hllcYQGSvDtpDDUi6tpccIMQjVMdf+Wk4e+WtoQ/q/6ZLgSsjjV5
 fsmV1kpWYt52iERm4+quJOD9kGxJ4cNhzPkUrgPlYrLc08bUvJs2xjq9osCcOiDQZmWZoUZ50Yf
 iEhLE0X3quZL4EjjtRngZU8xH+yA4CwE3SDGh0TQ==
X-Received: by 2002:a05:693c:65db:b0:361:cd8f:7422 with SMTP id
 5a478bee46e88-365f93914e5mr1476720eec.9.1792477773144; 
 Mon, 19 Oct 2026 23:29:33 -0700 (PDT)
X-Received: by 2002:a05:693c:65db:b0:361:cd8f:7422 with SMTP id
 5a478bee46e88-365f93914e5mr1476693eec.9.1792477772579; 
 Mon, 19 Oct 2026 23:29:32 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607ee0e5e6sm38260801eec.1.2026.10.19.23.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 23:29:32 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 11:59:28 +0530
Subject: [PATCH] mach-snapdragon: dram: fix SMEM error pointer check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-dram-smem-errptr-v1-1-b79712e1b39a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEcK12oC/yXMQQ6CQAxG4auQrm1SJgrGqxgXyPwDNRkkLRgTw
 t0ddfkt3tvIYQqnS7WR4aWuz6mgPlTUj900gDUWU5DQ1BKEo3WZPSMzzObFGNJKOsYTzglUstm
 Q9P1bXm9/+3p/oF++H9r3D8ix+MF0AAAA
X-Change-ID: 20261020-dram-smem-errptr-e070f4d5e8fe
To: Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792477769; l=1741;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=k7WA3FpSQjKfFACRAUtfU5JQHQErhDEac6kbJvZtZ1k=;
 b=/z1t6m/hzWR0gw9utdbDU0qdcLiyeDCGixFxNE32wycJQXuItdNNv8yhn6R4g8qIJemvlPBTt
 2Ivj1Bi7XT/AAE4xop7Mf0BtQ5ITbMDwSJvNyt5tz3PnUvgESFpQ/K4
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: VW0KlTLBB_8Ild_OaOF8qpGAMNBOrKvt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyNSBTYWx0ZWRfX9Nx2CDUQKV2e
 RBchkhkg4tmTDjWl94BcI9zyBuwWIbVLEtlur0iIj2j67trNuK4EWKVx9XCRsu3d87sTX4dsXme
 L/IGlWTss9Ahs1l0uEzd7wVC6zhXKvI=
X-Proofpoint-ORIG-GUID: VW0KlTLBB_8Ild_OaOF8qpGAMNBOrKvt
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad70a4e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=eVHWfhVU9NhPQ88CbWYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyNSBTYWx0ZWRfX1Kaidv/nAOIQ
 ZjEnoMW7KpmXoakj26eIQjgeaWQScfknY7WDicohhIXyrVhyp7xzhdyD5CVRKYrCTezGAmzAbym
 mvFhFm4BCjWpKh718wMa05+QJ6tNOq7L3xQ5L06gKJgHSlWB49TxrP3hrlqmTIeYPaorm0YKwbV
 J4F0tDO5Msgg9shwDoHvd8iWZ4AtEw2psotQ04VIifWtv5Q88Hh7FYfTuR9hgeTvIlHV7EKkEGT
 y9gl2eqha17MJRqrK8ZBNZDsVqVIMlg48syKuVW3rW7wSpvtqdxp8Qi2WX5Cav8IXQrpAzYPV7I
 kRhF0CPpDcajdBFyw4dzR39mVQrWtctTNlDMRrsjgMvxVgFx9pgL3L0SJOb65eVSxbDj6MtPowx
 oDn/t0lw0OgSIAT7ecif4oxKbHbc/jp9zhEClkUbRuTxAdBEqU3Isbc4ExaPUNo31S6xq+V68Sl
 ECAl2k+W3dQ/3sVDvtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200025
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

qcom_smem_get() reports failure with an ERR_PTR(), for example
-ENOENT when the item is missing or -EPROBE_DEFER when SMEM is not
ready, and never returns NULL. The check in qcom_parse_memory_smem()
only tests for NULL, so an error pointer is treated as a valid RAM
partition table and header->version is then dereferenced.

Use IS_ERR_OR_NULL() and return the error from qcom_smem_get() so that
qcom_parse_memory() reports a missing memory map through its existing
error path instead of faulting on a bogus pointer.

Fixes: ed40a06be832 ("mach-snapdragon: support parsing memory map from SMEM")
Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/dram.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index 0b97b698322..04b6d167848 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -8,6 +8,7 @@
 
 #include <asm-generic/unaligned.h>
 #include <dm.h>
+#include <linux/err.h>
 #include <log.h>
 #include <sort.h>
 #include <soc/qcom/smem.h>
@@ -92,9 +93,9 @@ static int qcom_parse_memory_smem(phys_addr_t *ram_end)
 	}
 
 	header = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_USABLE_RAM_PARTITION_TABLE, &size);
-	if (!header) {
+	if (IS_ERR_OR_NULL(header)) {
 		debug("Failed to find SMEM partition.\n");
-		return -ENODEV;
+		return header ? PTR_ERR(header) : -ENODEV;
 	}
 
 	ver = header->version;

---
base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
change-id: 20261020-dram-smem-errptr-e070f4d5e8fe

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

