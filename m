Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523A606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CBuVU9jh;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CusaHmup;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7nUd3UB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E2C640AF1;
	Fri, 30 Oct 2026 13:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n31F1eTXlOh0; Fri, 30 Oct 2026 13:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6B1240AAD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793368667;
	b=P0ngfx8tosA2BeS0CaWQDOrC0cWpuJkRB7EgCqkDisnBkTlgjr/YUwHCzcFWcIrylQyZ
	 SREES0kDZ43O07q0nNgd6251zYsaQXfQmFQVTOTwue8dHqD1a+FnRRSHaj63xTAy16vOW
	 RxUZ2UMCV0zrpvxOfQ7T5gK1xlEeVuFuHI8b0sz4gGNpt3rRfKkgd3AyOddfiy6hCScuz
	 nPAJmidtaLTl0I347VgG89EEEbpwLzuvNwzpg4bTpCVXQrEHqceZlHjMEvZNW+XzrpUNI
	 SWYz7d8H/NKhUJqhvXlXpAKBwAHFxiWJrohUyLrs8f2Jvc1iKS9mStIHFrdwuGYbYlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793368667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RLwTFiI9y2P6W9V8mwyJE68dg7rVXssW+jx1+IPfHvc=;
	b=MKWyKF8bCHiM1Eu/SQdEbFPaZxPdBSMp6aGhA3OW98KhhFsurVZIyf9OUCs/zYx2iJlB
	 yHbwTp2zjD38xGMs5qdfcfWbmqJvs9BTW5TD4ZDumnIUNv8OfPyrbxtoR1Q+cH0sAiZg5
	 pOnuL0rUPNGLJIcyMV2X0Xg/eL2oGZ8iVe1gkZ8RYWoQoQfo+Ohnh+UllCykOuCc3Dl7n
	 9fCWZBIZMgmuLphgMykZaM7+gdDtFl1ceFS2LxbTkt1dWxM6TDPyc4lG/m1hyQCiHkdlT
	 19bbi3CeMRfl9lsvOQVIh5mrGGDJCCkhIeqA9/CwjlaOFsGvAt5wbysQ6kjKXnC9exw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793368666;
	bh=RLwTFiI9y2P6W9V8mwyJE68dg7rVXssW+jx1+IPfHvc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CBuVU9jhT2BW/XrBJ0A6b1jOtjbsa2jCl1Xj96HRsDyi3W7A3vCl3mZ+J01hU4LrB
	 rhtHFmesWJylIodiNzXtn1muw0naKfynyUdS1iJRlU5EQhYFC02OGgrwvNrPEFep9M
	 AkyPPNiZ3+T5uODLusEufYgBxwSW/ZXIPLwT7G5CJUD4K0V+3GbJmXwbz7KO5r224s
	 CDlSWDbwBptjYhYi2htQc3508fBHC7KZTkfwIQ/jGfxM6bhp1VlfHH0jpIlZtW9wsx
	 Bb2ZxWlQJ5BhVHOYPjMkk44Gmv+6KV7m8Lpc3FY5FH5cBQCYYIQg19BnkU9e85fRpC
	 8Pq/3TROXR+Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6B1240AAD;
	Fri, 30 Oct 2026 13:57:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 25DABD38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B92540243
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKb8TBZz2pPh for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 13:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 46A40400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793368664;
 b=Ov7uvxUMtW2/JCw1Pl7uB1dEEj1QAEhSX2SE7J+eBUchwaxjmEYhX0SUFWmDiBsSYwj1
 xTADQFjVf5qnZWdYm7n0PszFiBIHdWKT4wktaE9QD1MTIP39U3mni5QO1EBaQXOAWxeO6
 lB7/p1qFdtamKBd0RNhkBM5AP+2xNO9iYNquS67jPSINzD2dYqIJ6zThSRP6T52QU285p
 j51FonrNrlB9lKf5pjj4DCLFs+CQoMLU7irAtC1BSd/fS13wAsr/ZYoTolZMBXBs7sC0u
 jCdC5Ca61OsvQmShlgwmWo4Zf7fEHYkX30C9kgJBgrnjzRJrkGpUIt2jXb0fs32bJbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793368664;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=RLwTFiI9y2P6W9V8mwyJE68dg7rVXssW+jx1+IPfHvc=;
 b=A6ORPcnxyoQk2CfMeZgXm/9BMBG8bVxnmLbz/KvpktjLWaG2k/GUD1Vao07VfqazCHH+
 MmE9jBN+IgrNxGB8UkElUmkoNxg+BGzE4AuzMtXLG+N2LMV1juNRfxscAWWen6p3YP8Ns
 WTakXMPhlolT0ufRQ8rwiVm4w4gNdz30oOAHbOuprpgbcJEofW/hSLdqHEqKtkgbEiWqr
 rlEPy3P9PTjd7JABYpiAQzOAEjhKRRgLj4QeB1Em0QKZ7cfGZwimqfOmCEuZ4AQdYrUmZ
 X4c7P5QbGwHDCRKr9RirDJu5r5rcRg3CQCc7PRQxN6eznVe8Dp6QcACVZYEig6ouTEQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CusaHmup; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A7nUd3UB; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CusaHmup; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=A7nUd3UB
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46A40400D5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:57:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UDnDnr4019637
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RLwTFiI9y2P6W9V8mwyJE6
 8dg7rVXssW+jx1+IPfHvc=; b=CusaHmup1Y1auuFidxl0b3nM3XSaecTbIjKq6a
 +BwGHhA8gVjKxeCKhcA+xdJpJtmvPTLy5gB4Kl12TsT1qMcDlTt/7wWpCutr5O9k
 U3yLIwXGpCRBwzvc73SAPEqTcOftyehk9bKMK8ZbrXkjvOaYDZrtxFYwLA/80j3C
 xiSabSWcPyiYrIEIghmz1QvmRcKHEUod2vA7BLELbBKDoJItlaufe/Mfu0i9L7QF
 MeU5R3Iy7IW1G8nBYjWWpg2RRq5ajA5v0bv5rvyr8HPlEIxKkLSjPcDz4wU40ij3
 U0oA+T8AjpDHjVdrnybOmgTUmRgeSDcuM+cDnLzk51zDqNGw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkbfg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:57:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c046843f1so21930476d6.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793368662; x=1793973462;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RLwTFiI9y2P6W9V8mwyJE68dg7rVXssW+jx1+IPfHvc=;
 b=A7nUd3UBaMLFsfrDlXNA+mk3zwWY2rwGW4pudeYQSgFWMOSrtSNC7Tplbotkh+Ly2z
 50mBms181Dqu+WjQA4rSJURADm+lwcTz5WnAVBOcO6Ea/ltXDClZLHcnpxK3Yf8egmDa
 drOffBVUgv8mprKatpp7eMqQJABKN0mkKqH5Kl8mkVu1FUKhTmin2YFqLX9bO8mBDUCJ
 z/ZvAJWDKKfiu2dPMOzkwjQUeX/CFyHy60iLF7PuVKT01z1NQncURoo0RUjoxgcyqlgN
 fpZOBd0OIfEZEd5MYqNpDFn0f7WatYZnO06dOVx992s0u6N/2TpBCHVTky+jWfe1Q2PE
 2V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793368662; x=1793973462;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RLwTFiI9y2P6W9V8mwyJE68dg7rVXssW+jx1+IPfHvc=;
 b=zqJmkuPJP4x1goKfhqD+eAov6dKA0ZlvqI+Qg7lZ86k+z4BQHdh7GBm8hBYA5ziltB
 Uapy6BzlRwlI3MzlrqICDV0G/HclHiWmM/ZQJgyNEmPEKoRS0CC5bJbd2P39RvhH7YbP
 I205aqqVuoeaNlkgvMH6TD+eVSKXQzDHFRDS15fTsHWnTBi7opTb15TTuDbnDmS1Z9+8
 JoB3RN/IsSN0gRxBbhRq6vhJN0qQIt9K0vze4xnNRSYpChINHcM9n2/UkAqKbJ9jKeMx
 UqTo6LQHQLEjD+Qz+uteMWzmUySjlz6s29gE/wZswztm+yAWdt7Y0b+4yb8GsssOQCD1
 7tfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgop/R9srpZ5EOeWXQEvMvaeiIgE/fjInW+8NOQctkMQvc7RxW+rIMew/2sfocb7hNlVoL/u4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKyQPI6uhv1SLUmIxom4DJgmvUICJV33RJTA93p3zH21gt0kGGT
 BqbDgOw5ybYTd6DS89EOIfGDxa5UYu7OmgVBN81EnfDynzcE+F9ireK/CX8EqFQJd1duycdTvrL
 qBpjJEZ7Ts/1UIwUNAMFuI44UHOZ3aCrOOnmZeabmaP8vUOf/JtEcqXHgVCDVvCeAz7QpXY4=
X-Gm-Gg: AYBFou3+e5A05mdd117x1jYJZ+M9ZMIrQXtkacb4gLoqr3zxBGbTZ8jDqspZKkg+Ssb
 57T6VdKy284rBsQeY5bE0Lq5hNGzdzwzQ47CdT+svVu3UCJFNIwXPCg3G2pzlT8ubza5qbs5W2k
 B/CX8ZS+jXljhsNZ2wjqhJTXH/2t59k5hISBChPK/adCAyYEbzTLaxCMz2kAsnMfoN2rBQ7k1sI
 anGilHsOhSuIC0JoWWEpscmJWuCXXXUbPhePPTPD85zrzx7okHa5Iqj8B5oNlD++da+2bvNMImT
 13JwTCJ6K5WiU/tP4XknNv7zLDcQ3NDgEZvKnBAvL1WNS+5VW5/zhFNSM/wp1hJfhO243BUsGnJ
 wVGZyOOV3BMYTnNbeL6mI1W8lmyfmcWjQcDfPwzo42v04W29wyUcWxOXWZSYMEsINu31GlRIt82
 q+4yGUqdcHRQlj
X-Received: by 2002:a05:620a:271c:b0:93f:25a0:6aeb with SMTP id
 af79cd13be357-94421712deemr403783685a.23.1793368661550; 
 Fri, 30 Oct 2026 06:57:41 -0700 (PDT)
X-Received: by 2002:a05:620a:271c:b0:93f:25a0:6aeb with SMTP id
 af79cd13be357-94421712deemr403780585a.23.1793368661058; 
 Fri, 30 Oct 2026 06:57:41 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfdc3csm67678466b.17.2026.10.30.06.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:57:40 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:57:00 +0100
Subject: [PATCH] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IJp9PqV6BC61R60cKMC6d+Tj
 gMzk0AoMgkMRYJIFwvvIUNVFmC3OayE7DKDVrqplFHoxaO4zTLeM58oFBxa77A2nVl022dRQ66
 PSAs//3mc3vcDG6Q8P2kAAAA=
X-Change-ID: 20261030-msm-sdhci-wait-send-cmd-4383f2792022
To: Sumit Garg <sumit.garg@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX3YEc6lOdpx6m
 /5aAhWK+wr9Axg9MWXwe+vyo4y1m/HRannh769LyYQE0Q3D1AEYCQ0YhMBZ9Y/fFaMyA3VqWf9S
 9c6bPbeK2/9sSMmC1GUic0RREJla0Fanm239DVUgE8C7AqIe1B5R1zYUIHPcZQU/xzeSwqMkdLo
 AzMJ3YrEw8TP6xrlJEUCAWciKloODmU+qshqDFgb9QqeQ/KpVEX9BrEY8PBb2/Ygzqn/dN/0CRM
 tEZPRj5L4Ard6phicY/py3I5kFpftVIgWkwWkqRybvBXjiyPvS0276fng5Aa5zh26rQgN/vcEPQ
 YrE4VHPpVsLHWyaTYN5tL/njAfLZyVYRf6Oq0+keCfzHJG+wJzTL6V6Jjj6rtydPTERFu7of4WY
 3ATSl8ao/21t9AFT+YZJh5ZIUdf6g1Y/blN9jdhsV/w9bwrMGIwdhCTk+h9L46sFtnLiBBxx4+5
 4vUxUfQOPuv2a8H0niQ==
X-Proofpoint-ORIG-GUID: vgPLXJ_ftcCIyE9gLcapk5PL2_HLDfdW
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4a256 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=73V_8P9vMaRJ_QbUy-UA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX0NeIPIwwSKrM
 AKSV6spoaP9xFk9Ch47PNuSFwzyqy9u4aKSpw0WqQPPdRkBrLci6EPHm6nsvayYeGjfcrG6XPKe
 0SeTlBoleYH+kSkgKHWFqeMWefpJQgI=
X-Proofpoint-GUID: vgPLXJ_ftcCIyE9gLcapk5PL2_HLDfdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SDHCI_QUIRK_WAIT_SEND_CMD makes sdhci_send_command() sleep for 1 ms
after every command. msm_sdhci has set it since the driver was added
for APQ8016, back when it only did PIO; the commit gives no reason for
it, and the Linux sdhci-msm driver has no such delay.

The delay is invisible for large reads but dominates small ones. A
multi-block read is CMD18 followed by CMD12, so every read pays 2 ms
on top of the transfer. With the eMMC in HS400 a 128 KiB read takes
about 0.4 ms, so USB mass storage, which reads in 128 KiB (FSG_BUFLEN)
chunks, spent most of its time in udelay(). On the Arduino UNO Q,
reading 1 GiB from "ums 0 mmc 0" on a USB 3 host
(dd if=/dev/sdX of=/dev/null bs=4M count=256):

                     host throughput   time in eMMC reads (10.6k reads)
  with the quirk     46 MB/s           26.8 s (~2.5 ms per read)
  without            201 MB/s           4.5 s (~0.4 ms per read)

A single 128 MiB "mmc read" runs at 255.6 MiB/s either way.

Drop the quirk and keep SDHCI_QUIRK_BROKEN_R1B.

Tested on the Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, ADMA):
- on main (eMMC in DDR52): 128 MiB "mmc read" at 75 MiB/s as before,
  the CRC32 of the first 128 MiB read in U-Boot matches the one Linux
  computes from the same blocks, and Linux boots from the eMMC;
- with the "qcom: Enable HS200/HS400 eMMC modes" series and the
  mass_storage SuperSpeed descriptor patch applied (eMMC in HS400):
  the ums numbers above, same CRC32 check and Linux boot.
Not tested on v4 controllers or on the boards that use the driver in
PIO mode (qcom_dragonboard410c, qcom_dragonboard820c, hmibsc).

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Drop the 1 ms delay msm_sdhci adds after every SD command. It costs
2 ms per multi-block read, which capped ums on an Arduino UNO Q at
46 MB/s; without it the same read runs at 201 MB/s.

Testing on APQ8016/APQ8096 (PIO mode) would be welcome.
---
 drivers/mmc/msm_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 9cc11a5e269..ab217393a54 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -198,7 +198,7 @@ static int msm_sdc_probe(struct udevice *dev)
 		udelay(200);
 	}
 
-	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD | SDHCI_QUIRK_BROKEN_R1B;
+	host->quirks = SDHCI_QUIRK_BROKEN_R1B;
 
 	host->max_clk = 0;
 

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261030-msm-sdhci-wait-send-cmd-4383f2792022

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

