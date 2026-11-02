Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFD606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wTBY6boJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CT//jmme;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d+ySyUoC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81836406A7;
	Mon,  2 Nov 2026 05:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5y7XzAJ-wRJx; Mon,  2 Nov 2026 05:50:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 868EF405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598606;
	b=HnfDX3i8OGDCKi9xHgThalAW6vO2TfSFaosHPlY3AMrxVAL9eT1Re+/WfoOuLMIBhml4
	 UZM1iFwVYMG1xfDzNI/v5GnfYAVX9moT7EaDoSYjFi99F7xoqcjZiF/jRwJ4JqV/tN8hI
	 x2ftUMQisRz0q9mj58kspRVb+M3yDTLnJAbwFrlr3Cuc8PTxnFlulNMXdEp6JDqL5SUEv
	 x1n+wdHE6j4j7JQ8idLubq48uLYnD4/uKpSQ2PccNIcjrwPQfs7Een9/vTh40LzI2ueMw
	 5ffsqnvws8CTH0tgh6D+SiBdIzcbc/kM0MCaPCpF/fgVCp+p9SQNEf1pJrg0iLM87tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598606;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
	b=pZ2jnyIwEq3B7+PvO4AUSqG0dv77O7qInOCpFzELwjtYmwxQVFQfcQ0Rf0nKU0DyG3uL
	 RudZwiKnzhburPOa0QpmF8E829glwgGw35eZdk9ZvsGSqCTyrcQpFKXixTGDEzK+/kFar
	 LzVsV4pZwUDZKjVDKt08SJwAMJXaxp/xZVms3QIG5O2Z8t1pYRDQ4XQq1itL1e4J/loEw
	 U1f2EbOUFPmdJ4X4XndmpAoWcd7o122cs/+WesZGc9aVHh/oAK64oHlT44DIfwA4NePfU
	 NbJ4LZj9A0YiIymeI/6NjuTXaxsXSh/fX+PraTuOZKDJER6iZn+oDK7Ov0N8vMQhZ+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="CT//jmme";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d+ySyUoC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598606;
	bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTBY6boJLPVrl1zSc1DdEyekVpqiO/HI8E5DhDMHbnZPtbcC2Cc1Seyz6v5LC9Ws9
	 UL7LncT+SUQ2p0h7hUirY8MoYenZ7n5oS4SucbiLbT53jgaOh2W5ybGXAijLVQpiig
	 y5e161dk28ob3H+J9NHYXHkRvrZzpd4vT/Ah3SgkKGVE6yJViCWs+wfFPH+tHYVi4h
	 8SIIrMDm9QXtHIr/0k/iXQmbSuE0IUP+QZLprgvJFVzfq8dRDZYZ3K5y4kehEtANja
	 4CbrYg2lupYdhB1ZPQrZBLuJ4OBT/BQAeMzV69zm37d3zdvTLgaMd2q1iCQ6KOMKT9
	 g+Jen4tj0C8zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 868EF405F9;
	Mon,  2 Nov 2026 05:50:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 635B94BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46D6D40695
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceThfZ2BIKpK for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 861B34064F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598604;
 b=ChipMlBLUUMSwpX3QGBMa0MJDyM/eJHXzuwaen6SClL8JPfrw1zO6qrxFEmfKcjgNwxA
 bY427EI0oV2Wo9qnd9Z/OqAVZGQCYxEgVke/o96uc7Ajejmqo9yoYhPfjVkZg2BOzAn4V
 ZSWMpCNlK684gvCrSrnMH0kucjtnu11aHm34tC9mZS0D2nAlQMC06MkAuykmovqFjIPzZ
 iP2tSz8jDzxCTytHs7LCPxISvh/LhOM/772Cr5eseBARnF+hTjYzl5iUIvk+rqCqkWWrn
 mn/jPqpViwhfo8sbKmrT+r/n6323oqw15eyTN9Bi3ynz2UJP+fMwYxruM1XCB15nInA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598604;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=Wgms6Q//OhE39HgK+A1SeHSieifqlSTEKvXjr/RnnBrcL7o0bqsWwQ+4xqHBxGKMiBOh
 bULlG4fL5vHnKRPSy5/B7i/z2AumBa48Fo9zzmtOKZLoJQVEL9rnlRBDY+9ZdN8+o//V6
 38XfEkAt5ZHgCc190Dn35naaJfnuMJjGFNE5Hp9T2dqcsoBeefmp5gMfVUHtdTdC6KqgN
 XFbE9RPCFCcRoTjp+p2lB6Xhvl44uAV9+xc+/0k9wt4KSRi5iIQi7jWr88NH/5EtXJTjX
 XMzdkhgKmdZVplSczVNEccSFDuuxDhtruruSo1xvX452wOzV12h7TcBt2TKpqMbyIwA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="CT//jmme"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d+ySyUoC; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CT//jmme; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d+ySyUoC
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 861B34064F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:50:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24Ccr61811541
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=; b=CT//jmmeGMmE86F8
 tU9ePDAowY2bQ4VVAUZKs0FuJxMJnJ0wikeH5i756iKQ6/N0ct1gwC8rdVeOWZlK
 W3GZGAmpaZueWiFCtx5+nIZX2hAwsHLAQV2lgrl7u1ZL2yUv2yh+r5CWoMMO2yI5
 /DinJpsnB1fOx/tb44urPfYZCPs736oOcBnNMnRVclAeNpb3eZeOLVya6iRS7clm
 EZt25sL0bSmsuE0X+gw6NzheOEXTwq3HVmG1Snqy9zbxhaSNMSfIn5XRuqmCI7mK
 xdh4sdkkcGEuAC6aliHRh30093A6AbsIRS5yyJ83zFiIKWWDawrLiCwhLmSOPAe+
 1JbI/Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpk9rg81f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:50:03 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1af203073e0so2353431c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598603; x=1794203403;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=d+ySyUoCVeqgXWetmQ9tDuV2VEoRU4LfmfOmaRK+bJXE3xjexq8F3JJcAZsg1y2eiI
 wxkF2FP+aUnccZqGzlUshmV7GYU4YW1jtseFGIy6fx0AbOnenfg7S6X15yfFYZXtf2xH
 kvCeFgUsIX/u7rPg4+7L65eMlHe/qwJDaCZmMGQIfEA4IpSlBbjtptEGvcjuzV1wly6N
 UY0lyPG7cAmJt3U4hLq5rT+T489BKjLS43D6hDQkjpGnimyskBtQ+QvJxbyvyvPFY8+m
 bpu4e8iUXFtcDcuuIrs9rM+Mk6t0D/XkAKvn3Vqg/SNbPqAuOYne6aCTy3b5cz0jcGed
 Xalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598603; x=1794203403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=O2d+CWlusoF2aVpBlcYsbkZX4N1hdHfZct/QqS+qbCfWeywpxkgxHGapNzzcH8H2TF
 UjPCt11hTVSq82IWmTNHrByOuHg2kp5qAAPKfMWe+G3lDnnp/DPkeUExr44RIzJd2qa0
 M4tRuyZw1vcZgqPe7T4IewwkZGXPcOOtPU0TzMWH/kP0kz0DKZ9T0hxCHAlGc/oz89YB
 6+3LGg/Vd76j+BfHt+XBGz+wFeyOZgN/itBqDGpOvBh9gEtWiXzZhELz/QlEyUafDUS8
 LspK4R5AHpBUFjKuqrYnNyYNcQ315w0j59yD/7ewIN9fiwR73AgkWl5PLZ5W+sup7FXd
 ISSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGGLtdLWbcEFQKtYixmueT+UqYVP+YOEQeiTZbEQO1hSR7y8z7mSIsep3M5LeNfQBW/0ZmMhY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLjYvNpLIYUeAQYzMvtaMXCCi4NWou/M4oU2SPa/UKWTkcPFe95
 xgVf0OmoLV6dAYdTqdeAsc4WT4pcl5bcI+qOoT2XVQBGhtr7SY6FiEe5KROYDfm6p+XJ6N2bN2q
 otTdmnbKCtCcSztVwAibHzYVybPbfctJmIUNDc6vpGrwHh6PFuJDFv/plTI9h4cS2Af0rF6f5bx
 7q3+Y=
X-Gm-Gg: AYBFou1aWMq9hQGRh8lVUfiC3urQQ9fXMF/pGknRQQ9P5sSUvjehsMO5gpC6XT2abmv
 t5pGxNN+m/gzSn0nfc8IHIGv0QCJHxBDvQnzw+boprEyRr0jWKj1shc8l2Dtx0JD4e8KQMmhpBk
 Lnzff6oJJ6II+HfzbZglgwdIFpGZTNNLckQpr8m2U5Tv3JvvQkGX+sZAzTjEHuZVFGk3KgvHJ+q
 KWf/E1z2sqp1aShn+LbE/iWosPUJqJ4gRu9g6GfRDN+cFkSrxileama0pfdI4xcfSNE8kIXbGUa
 azQlTfbnJsJ3JEFARJ/ZgRI1hYwQYjcew3g2SUCx+6ss2exFmkuN6PeVkBCuS5wGc8JxVVbgyQh
 hXzrY6VC/1xJc3Dqfn3R6DMpWWYeNmzqXMaY8vRyta08nd9lGomgDmJMpSqUbB9/S0xVemWdqD/
 +XKikDlx1pS8KgwAS0g9t4qbsb7A0AmTcC2bUZ0XOem81WzqiGtAaqfACdHaSxFAEVJWOJIAbOp
 Q4uRg==
X-Received: by 2002:a05:7022:5f02:b0:1a0:e3e2:22a3 with SMTP id
 a92af1059eb24-1ac5e323588mr12060753c88.31.1793598602897; 
 Sun, 01 Nov 2026 21:50:02 -0800 (PST)
X-Received: by 2002:a05:7022:5f02:b0:1a0:e3e2:22a3 with SMTP id
 a92af1059eb24-1ac5e323588mr12060716c88.31.1793598602302; 
 Sun, 01 Nov 2026 21:50:02 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:50:01 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:40 +0530
Subject: [PATCH RESEND v10 08/15] mach-snapdragon: spl: Add DDR
 initialization support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-8-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: iJzZeAiEiN9HBBXxUlbpWMXMsQBHZXxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX0FeX7lyKfRg7
 oeAKUDOA47i/Gd1ILn39h4nWOXRWv5bDZrJdYD6+NaT5pF/QB4OIOuLNIlEyAgxeWlV8egziC3a
 XSVdpLrQoRZG192ldnxJsbcvvJ4VKMj/YDMgm1Ou3eaw0iur9PhRPZA6HzZA6Nq45gBDIajTkW/
 qe6v1+K1kZrER8O0Oy3ihafFXrobLgNG8luTbp0S1Pr3sswhrE/JcAONzTHTjimKVNc+1jgY9w2
 8pArjtG7Ufjq1j6/plKqA2RQcJe1fmcebRZydLc8cOsUlnDbsFTmaXrC/X1yovBXG0HtsUf6Ucq
 wzJSURPEq1j66MsGTx/HgilKaP7kpCXjnufle1F+lmVu3plf2/oz0Psz6+a7wYZCVvLKvbXRlwN
 ORw+XYuS+X1nl+taOiMrcMlb1KQVbrI0taYZepuF31ZACffjgdVXMhGnnyqGo9ovj6pTyfPttKl
 5tzGFaKbSIBXTxUcKwA==
X-Proofpoint-GUID: iJzZeAiEiN9HBBXxUlbpWMXMsQBHZXxx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfXwOMT2iDjOC7F
 a1tlvCsqqG+J0lr+8WIfNapgCkod3yjYQzApPLQhBBpR0xZFeSKf1cb0yF52dWilAyTSwysFvKb
 ErrhVG77xlTNCEHuo/YXu5WTPeuZhaU=
X-Authority-Analysis: v=2.4 cv=LvwHWXdc c=1 sm=1 tr=0 ts=6ae8248b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=OI4x4kLBNDoJJu7lNuEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
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

The U-Boot SPL loads the next stage FIT image into internal SRAM. The
binaries are 'external' in this FIT image. The SPL has to load the DDR init
binary, i.e. qclib and the DDR parameters i.e. qcconfig used by qclib and
invoke the qclib. SPL and qclib exchange information using the interface
table described in doc/board/qualcomm/interface-table.rst.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile      |   1 +
 arch/arm/mach-snapdragon/fit-handler.c | 131 +++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 4f2f35cb9de..2701f7c6fb1 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -7,6 +7,7 @@ obj-y += mem_map.o
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
+obj-y += fit-handler.o
 obj-y += pbl-shared-data.o
 else
 obj-y += board.o
diff --git a/arch/arm/mach-snapdragon/fit-handler.c b/arch/arm/mach-snapdragon/fit-handler.c
new file mode 100644
index 00000000000..fc419bd3f00
--- /dev/null
+++ b/arch/arm/mach-snapdragon/fit-handler.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <atf_common.h>
+#include <image.h>
+#include <log.h>
+#include <spl.h>
+#include <linux/err.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+
+/**
+ * qcom_spl_get_fit_img_entry_point() - Get entry point from FIT image node.
+ * @fit:	 Pointer to the FIT image blob.
+ * @node:	 Node ID within the FIT image.
+ * @entry_point: Pointer to store the retrieved entry point.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_get_fit_img_entry_point(void *fit, int node,
+				     u64 *entry_point)
+{
+	int ret;
+
+	if (!fit) {
+		pr_err("FIT image blob is NULL\n");
+		return -EINVAL;
+	}
+	if (node <= 0) {
+		pr_err("Invalid FIT node ID %d\n", node);
+		return -EINVAL;
+	}
+	if (!entry_point) {
+		pr_err("Entry point pointer is NULL\n");
+		return -EINVAL;
+	}
+
+	ret = fit_image_get_entry(fit, node, (ulong *)entry_point);
+	if (ret) {
+		pr_debug("No entry point for node %d, trying load address\n",
+			 node);
+		ret = fit_image_get_load(fit, node, (ulong *)entry_point);
+		if (ret)
+			pr_err("No load address for node %d (%d)\n", node, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
+ * @if_tbl:	Pointer to the QCLIB interface table.
+ * @name:	Name of the entry to find.
+ * @entry:	Pointer to a buffer where the found entry will be copied.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
+				     char *name,
+				     struct interface_table_entry *entry)
+{
+	uint uc_index;
+
+	if (!if_tbl) {
+		pr_err("Invalid interface table\n");
+		return -EINVAL;
+	}
+	if (!name) {
+		pr_err("Invalid name\n");
+		return -EINVAL;
+	}
+	if (!entry) {
+		pr_err("Invalid entry pointer\n");
+		return -EINVAL;
+	}
+
+	for (uc_index = 0; uc_index < if_tbl->num_entries; uc_index++) {
+		if (!strcmp(if_tbl->if_table_entries[uc_index].entry_name, name)) {
+			memcpy(entry,
+			       &if_tbl->if_table_entries[uc_index],
+			       sizeof(struct interface_table_entry));
+			return 0;
+		}
+	}
+	pr_err("Interface table entry '%s' not found\n", name);
+
+	return -ENOENT;
+}
+
+/**
+ * bl2_plat_get_bl31_params_v2() - Retrieve and fixup BL31 parameters.
+ * @bl32_entry:	Entry point for BL32 (OP-TEE).
+ * @bl33_entry:	Entry point for BL33 (U-Boot/kernel).
+ * @fdt_addr:	Address of the Device Tree Blob (FDT).
+ *
+ * Return: Pointer to the populated BL31 parameters structure.
+ */
+struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
+					      uintptr_t bl33_entry,
+					      uintptr_t fdt_addr)
+{
+	struct bl_params *bl_params;
+	struct bl_params_node *node;
+	u64 qcsdi_address = qclib_get_qcsdi_address();
+
+	/*
+	 * Populate the bl31 params with default values.
+	 */
+	bl_params = bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
+							fdt_addr);
+
+	/*
+	 * Fixup the bl31 params based on platform requirements.
+	 */
+	for_each_bl_params_node(bl_params, node) {
+		if (node->image_id == ATF_BL31_IMAGE_ID) {
+			/*
+			 * Pass QCSDI address to BL31 via arg0
+			 * This address was populated by qcom_spl_invoke_qclib()
+			 */
+			if (qcsdi_address == 0)
+				pr_warn("QCSDI address not set, BL31 may not function correctly\n");
+
+			node->ep_info->args.arg0 = qcsdi_address;
+			pr_debug("Setting BL31 arg0 to QCSDI address: 0x%llx\n", qcsdi_address);
+		}
+	}
+
+	return bl_params;
+}

-- 
2.34.1

