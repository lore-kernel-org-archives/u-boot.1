Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38617606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xZezBgKG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S9vVFwgq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FexmpfB6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D88481276;
	Thu, 22 Oct 2026 12:17:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMzW0fM8BFup; Thu, 22 Oct 2026 12:17:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE79E812B1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792671439;
	b=rHbf/n+NQZVTVlI+FMWvQe7DgQj+rDzsW7jaIR24K16iqWAquwZAoWx5BrZK2R7MiGZY
	 5fFXTxK7GL/FgPzlMd4cbmRIEpTw8vMraLZygHlIXnXsFTfsaNx+jx/i8Z6Kj6Q8XRuFP
	 cqfeqTMjIdzzF4H0bh8b/JBS0/c7UZSwY9FpNPTAVspHheL+DMUrEgQarCjKNPBgwGHhq
	 2Ygucw9QCsy+2IEfuvS9HQqypGBcKspN/oZQh/7YbHAxmeOhfPeeGYlxSYO+hdGYkG2G/
	 WzaEpo5kBgCEmPzQb72kLxw6ieVmX3a0qvvlRbJZr0zKbCAjxF4aPNcwz0UBWWHiMNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792671439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8JcHUlzEEWx/8diD1DTz8JNYnjl0l0rNG/PsJffnTQM=;
	b=TsQuywnmRRcRxe7cTiMVveoyWEJ6dto7sfuUJp3cUlDkbTGrFybw0CZSMPKNRBDAJIrt
	 fpnp2Z40XHX8JXEGzyhpaHaU/S4L6YkiLBRIBDTP83YiQ6+o6NNvIaqIUf79jyGBkH94f
	 uU53D2PlRT0iEsNylfXVP7y0C+BvBOHxvxYKuq89kgYl0j7MUUmrxbSY48dsbUOY1SkOw
	 x/ySGe5BHpua4oeFPRLlX3s0BzmiKzKrKI0UD8kfCW7oHlncopuBAHe/I9ec99NcGQsGS
	 dWo9XkAsTV7YfPeLOKGV14zoS9z0vJSt71X9Lr0cRu0iSuUVFebOJ1BJMv0W65txeFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S9vVFwgq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FexmpfB6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792671439;
	bh=8JcHUlzEEWx/8diD1DTz8JNYnjl0l0rNG/PsJffnTQM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xZezBgKGjwJO10qjCTCbJFdMLjvaxfaPBYIQrg1NSju2tEU92OXMgRG5UHZrro+Ge
	 OriW4WJ3eyGTHeDF5rkZtPEB6BUJPneroPEyn22g3J2GmfS72lIQFbMWhQNH9qFxk1
	 SP/6HcsJ8rZg1vtwMDk3ZjpX23W6AueC07fh2l2754yFODHpXZtwx33NCqCw1nSJwL
	 CPUjKSsJsqHZcfIarYioDhvPzShKG8QSm4qf83Gy5dmEH9Ljy/Y7Ph0fRcfuHp1oxr
	 m4gJChIFNUU93Cw7I+Fxi8XCszR4x4vKdVTtab0vhgiHFPjeb2hbotDA+9SBLa9Ku2
	 WvewVkNAYgU0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE79E812B1;
	Thu, 22 Oct 2026 12:17:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7F9923A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5702812B7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZTxbboRRlE4 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 81535812B1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792671435;
 b=Lg33qBgHSJFGORuGitCK6+64bOW2bS8zFyW+uN7kD6YUyVg/3qGY3yN2s6tHPEez/o1b
 ukTTg3SZ11EA7A8988uwFmHcDOvL9cC+UX0vwZREduSzZu8obBoSrpXZkYo0v/nGc1KjA
 jloQ5Cf1SjSotLRLUyFLeQS0Dkn0Rn5AiGIJAw2XOxCxIjKZFw9a24K5qYVLQKYWHP5aK
 zvA2P/5yvVGImkHbj38lMAPhUy0CPZQknHWi82i5NWZ9j+mtz6Cj5mq5Q9bkLnxZ31waQ
 DT2LxvPpZHfl+KC6JTgzEmRhsBMML6ZrCxGoRh6Wm8ASrNqyDNc3KjnZPqOMcAEL2mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792671435;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8JcHUlzEEWx/8diD1DTz8JNYnjl0l0rNG/PsJffnTQM=;
 b=pcErB6aIKe/8YQE3fcG7rmVbEROmty9nb+M+Yzst74ZFGQcK4ybqGAWyldKYUbFolz+m
 +ExciuTzWvNaF9GhqPhz1+9ZAwK2qVsbrWaxipVfdzE4qQYu1smmI11X0PA6dl0gyb8sC
 09fpCmtj1xvwoHFPSrL4ZxfooxxiJzg7u93n4RFstiFhdwa1KWQH8k/L5PP05Q1nH97u9
 pC95b3hvh3eToryc5gEqFCBq+uZJHiZLm7gVbgcZZYlrLfNFHqF+89EXUn9CHBxM1WTzv
 gp+Gf73a0yOWIk/PPo3gaPnWnSg7ccbqk3qNKKlW6ysnFGtkxHRO/AqT4WuB+h7dJCw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=S9vVFwgq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FexmpfB6; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=S9vVFwgq; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FexmpfB6
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81535812B1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:17:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MC4VSZ125316
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8JcHUlzEEWx/8diD1DTz8J
 NYnjl0l0rNG/PsJffnTQM=; b=S9vVFwgqWdgL+pJiGI/nb8FN+VLNNTnqSk4l8t
 3JvPtmgr3zD5Y8elu6wLWq00q4mE1Km+2bLxONBzkFTFWGGzFJrvB7mFuBmhDTy7
 SUAz6AsthhVVDWqbz+iQRgEQ5S2At6nk86KecflcC0avg3hr8kXSNHHE9bY8qo5D
 smTHvns1uNw942fX3iwTnTUVfCA2OxOg1huLKZHwY/YaUYzj4R+hwJvKtQRR9AxE
 KjOL2DhuudljOQyb6qj6n558IdA1RoqPVyx47lbP/6TgnNHxBsPk2a2C4IMflUyT
 DlChLITzmGKy0T8BgR/a1njUl41xGRGB0WqTV3sfXu1lF4Kw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93cb3b4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:17:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso62401666d6.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792671430; x=1793276230;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8JcHUlzEEWx/8diD1DTz8JNYnjl0l0rNG/PsJffnTQM=;
 b=FexmpfB69pQKrqrx3/ce/yr4v9wa4urvRlMKUqoyCK7jZhK0jzJiQ9DJ7l/fss0UNn
 GfiaJ1skG0a1rZ+9gOTWndM91bI/N6yXNrCfZ1cSKGD81RX5hLG4sQFQR7vOv3FLheZR
 Vxu7L8+yfJYsXE9R8w7ecUgMdUtfgs+R/WuifpsQPOcWMTnhL3k5qpSk30po0rFtBuxE
 44oq98cj0sKUB1RsbuvB39rzGRGNKXaT67zx3R+90ovj8BYHHwsUigN2t04A2ceu/Afw
 nTs/hfi86kcDB8FnMJZ/MUAJcDIFCtmRFtizGocYTsak/Z1WDL90SqCDTmbTn6/1WXAt
 gT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792671430; x=1793276230;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8JcHUlzEEWx/8diD1DTz8JNYnjl0l0rNG/PsJffnTQM=;
 b=2Vwu10/isSmEb2mGbsG8imSYhz7J8Gt2wgESslwtkLRhxu9yb1ro4SiMVZdlNflJAy
 avYw4bCmku6Hf5842v0NgxD4VH5F3l62cRhwT4yY9RKQ7ts1BqIOv450Ar+UXm95dLt7
 EkJJpdnjoIMGXmk1B8a706OmkCn7XV/zOvZzMpX7dq9IV3jIypSSfQLUn/WhQL0gI8o1
 dE+jE0Os65vW5fSkJsp/kRgZaNCX906euZ473YSQoa2vQgmNYHFmtOhOdPGtBbsgZb/w
 4OqLgVdfNSp0CbrY8YXMJR6nvw7qqJ6RsrTU4PC4Mcb5K+vNyxeFscp49J7Ysp3Ujpjf
 da/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByu3UoYMdSv2N4p9Tv7xCkK9B4XnECXEBu9mYlM7x1RJ8sKvpf2/4BSl8yQreuO8H4tNcDjqH4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK58yBR0tYjzKBSeVXP4wJANycuQynnUFTgZxFAMnD1zmlEzwaT
 gCZL9PBTtliirQ9CQj+H+42cvVHOvK1HhZV5L8YRRpDaDOyku97CSDZlykPJXJR9bnWVuqsLZVn
 lQL19rIHjKOe/JTCdkqFOkeJQQT81nBLFMGiXAIq29/hxCdbynjL0TSo6ecW1TcaY3Hye7cA=
X-Gm-Gg: AYBFou16N8VJhKbN5DZ9ywRojolPLcHRteYgpgXlzg+/PfSnqJbsjLcO3WlRTNeSf0y
 fCq8D9F/oN2h2xX7J+HuCfZ3yOWEw78LHGxQ3PYnQl0/Y8NfLwAK1tLw+mnRVB5+eAjj9lnKDVq
 YSJHAHyZAqW9vysORuzBFuV07LQ+C5FwrJGVvqq0ct3IWrdSaBBaBy9pZ93lg527dLXZFkhyYmY
 tmSbgepf8A0D8scEsD81/98e8JNDqi/JDSSEnwHinz3hc/wnsSHi13cfgKzsXDInrh4HPrrPdgF
 F9yLIoOnnfFRwBrXROiYqJDemUFOugvx528ZEk+si9ErMJ1UjrKNF47zSvqjrMcGaVznwdZcfDL
 zbzY7IPIkY+yj3EBAspIXgVgJuCc0wKeBHJIOgVHPdYc8
X-Received: by 2002:a05:620a:444d:b0:93e:c12c:9dc9 with SMTP id
 af79cd13be357-93f57f69a5bmr924066085a.73.1792671430203; 
 Thu, 22 Oct 2026 05:17:10 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:93e:c12c:9dc9 with SMTP id
 af79cd13be357-93f57f69a5bmr924058285a.73.1792671429604; 
 Thu, 22 Oct 2026 05:17:09 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4031306f7sm1677863a12.25.2026.10.22.05.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:17:07 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:17:00 +0200
Subject: [PATCH] net: fastboot_tcp: implement the download data phase
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-fastboot_tcp_b4-v1-1-466a9f181ac1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWO2Q7CIBBFf6XhWWLB3V8xpmGZCiYCYaYG0/Dvg
 j6eu+WuDCF7QHYdVpbh7dHH0EBsBmacCg/g3jZmcpRHMUrJl4SUQb34rJB0jDSRSZPe84MVJ7U
 zZ5D6wlo9ZZh9+U3f7n/GRT/BUN/rCa0QuM4qGNclC6FsAxTqnvNIMX/6r1rrF/cUq2CnAAAA
X-Change-ID: 20261022-upstream-fastboot_tcp_b4-5d17a3c8e2b9
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OCBTYWx0ZWRfX974mhiyqz5wE
 Qxyy+kfy7a6A/Y97HDvjRybT1YSGF4Y2TFMqyAuMeRCOO7GzTfG2lwi3o7+ENGWEj7yVOhsYPhV
 ASqHI5hchnBa5utBaQa8jGzB2Hdp3QY=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ad9fec6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Oh2cFVv5AAAA:8 a=EUspDBNiAAAA:8 a=QKcHr5NhBwi3YKzeZP4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-GUID: Nxhe4JprVQFwWIVp8v01iUu19XQ8h2q_
X-Proofpoint-ORIG-GUID: Nxhe4JprVQFwWIVp8v01iUu19XQ8h2q_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OCBTYWx0ZWRfX3oW8INapI1aP
 bpkcT+byQnxlMzmhJIY3tmEFviB9NIp2NvE7fRauQdX63xQWQj9YLxnhuqcuW2KNk+YFm+rA4e8
 tNyXtrmZNVQbVXeXbUzZOUr4VIfa+zXzdmSpJXTZhdys9FmEGGqpspBFUTHLrWvwk6kXtID9rH5
 ii1eJ0thiXUco0BuznmHDljFw92Y0oJ58xd7bTA98wtwIgxqvyU+TasjFzJWyml4j6NlDVue8iI
 4kJ2+W6XYQZAyMvTdWJXu6uRBI5K74tWYG+P1H/VvqsQph+OCQvOjrIIcERffuIjVtGGGY5+vM5
 zo6qMmThKiHjjUH3VLiU9cPhGvhGg6Zx2KtUGt5K6sCE+QHWpxOF6PQ0TVZ+KlSnxS8Pv6h/V4d
 sZ/rxmHNRX/2YhGKPt3xpmLgwovhFaLGi92Cha/iy2Ul1fvK/98sbNUVO/disVKusvK/qH2WfOh
 iZ6kIEm6rKPILyY61mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220048
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

The TCP transport handled every length-prefixed packet as a command, so
after "download:<size>" the image bytes were parsed as a bogus command
(and overflowed the 64-byte command buffer): "flash" and "boot" could
not work over TCP, only over USB and UDP.

Follow the fastboot TCP protocol as documented in AOSP's
system/core/fastboot/README.md, section "TCP Protocol v1" [1]: after
the handshake, every fastboot packet, the data phase included, is sent
as an 8-byte big-endian length followed by that many bytes. So once a
download was accepted, the following packets carry the data (the
Android client sends the whole image as one packet).
Feed them in order into fastboot_data_download() straight from the
receive callback, so the image never goes through the command buffer,
and answer with fastboot_data_complete() when the last byte arrived. A
segment arriving ahead of a gap is not accepted and is retransmitted by
the peer once the gap is filled. Command bytes that follow the data in
the same segment are kept for the next command.

Also check the command length against the command buffer and compute
the available bytes relative to the consumed offset instead of using
the absolute stream offset.

Tested on QEMU virt with "fastboot tcp": download of a 1 KiB blob and
of a 64 MiB boot image followed by flash.

[1] https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md

Fixes: 443d319180a6 ("net: add fastboot TCP support")
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 net/fastboot_tcp.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 141 insertions(+), 19 deletions(-)

diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index 3ea25c997fc..ed32e5311b4 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -7,6 +7,7 @@
 #include <net.h>
 #include <net/fastboot_tcp.h>
 #include <net/tcp.h>
+#include <linux/kernel.h>
 
 #define FASTBOOT_TCP_PORT	5554
 
@@ -16,17 +17,95 @@ static const uchar *handshake = "FB01";
 static char rxbuf[sizeof(u64) + FASTBOOT_COMMAND_LEN + 1];
 static char txbuf[sizeof(u64) + FASTBOOT_RESPONSE_LEN + 1];
 
+/* stream offset of the first byte not consumed yet (commands and data) */
 static u32 data_read;
 static u32 tx_last_offs, tx_last_len;
 
-static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+/*
+ * Download data phase: after "download:<size>" the client sends the image as
+ * length prefixed packets (8-byte big-endian length, then that many bytes),
+ * normally a single packet holding the whole image.
+ */
+static u64 dl_pkt_remaining;
+static u8 dl_hdr[sizeof(u64)];
+static int dl_hdr_len;
+
+static void queue_response(void)
+{
+	__be64 len_be;
+	int len;
+
+	len = strlen(txbuf + sizeof(u64));
+	len_be = __cpu_to_be64(len);
+	memcpy(txbuf, &len_be, sizeof(u64));
+
+	tx_last_offs += tx_last_len;
+	tx_last_len = len + sizeof(u64);
+}
+
+/**
+ * dl_consume() - Feed in-order bytes of the data phase to the download
+ *
+ * @buf: Received bytes, starting at stream offset data_read
+ * @len: Number of bytes
+ * Return: number of bytes consumed by the download (the rest belong to the
+ *	next command), or -1 on a protocol error
+ */
+static int dl_consume(const char *buf, int len)
+{
+	int left = len;
+
+	while (left && fastboot_data_remaining()) {
+		u64 n;
+
+		if (!dl_pkt_remaining) {
+			/* packet header */
+			n = min_t(u64, left, sizeof(dl_hdr) - dl_hdr_len);
+			memcpy(dl_hdr + dl_hdr_len, buf, n);
+			dl_hdr_len += n;
+			buf += n;
+			left -= n;
+			if (dl_hdr_len == sizeof(dl_hdr)) {
+				memcpy(&dl_pkt_remaining, dl_hdr, sizeof(u64));
+				dl_pkt_remaining = __be64_to_cpu(dl_pkt_remaining);
+				dl_hdr_len = 0;
+				if (!dl_pkt_remaining ||
+				    dl_pkt_remaining > fastboot_data_remaining()) {
+					printf("fastboot: bad data packet length\n");
+					return -1;
+				}
+			}
+			continue;
+		}
+
+		n = min3((u64)left, dl_pkt_remaining, (u64)fastboot_data_remaining());
+		fastboot_data_download(buf, n, txbuf + sizeof(u64));
+		if (!strncmp("FAIL", txbuf + sizeof(u64), 4)) {
+			queue_response();
+			return -1;
+		}
+		dl_pkt_remaining -= n;
+		buf += n;
+		left -= n;
+	}
+
+	if (!fastboot_data_remaining()) {
+		fastboot_data_complete(txbuf + sizeof(u64));
+		queue_response();
+		dl_pkt_remaining = 0;
+		dl_hdr_len = 0;
+	}
+
+	return len - left;
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_offs)
 {
 	u64	cmd_size;
-	__be64	len_be;
 	char	saved;
-	int	fastboot_command_id, len;
+	int	fastboot_command_id, avail;
 
-	if (!data_read && rx_bytes >= handshake_length) {
+	if (!data_read && rx_offs >= handshake_length) {
 		if (memcmp(rxbuf, handshake, handshake_length)) {
 			printf("fastboot: bad handshake\n");
 			tcp_stream_close(tcp);
@@ -38,18 +117,28 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 		memcpy(txbuf, handshake, handshake_length);
 
 		data_read += handshake_length;
-		rx_bytes -= handshake_length;
-		if (rx_bytes > 0)
-			memmove(rxbuf, rxbuf + handshake_length, rx_bytes);
+		avail = rx_offs - data_read;
+		if (avail > 0)
+			memmove(rxbuf, rxbuf + handshake_length, avail);
 		return;
 	}
 
-	if (rx_bytes < sizeof(u64))
+	/* data phase: consumed in tcp_stream_rx() */
+	if (fastboot_data_remaining())
+		return;
+
+	avail = rx_offs - data_read;
+	if (avail < sizeof(u64))
 		return;
 
 	memcpy(&cmd_size, rxbuf, sizeof(u64));
 	cmd_size = __be64_to_cpu(cmd_size);
-	if (rx_bytes < sizeof(u64) + cmd_size)
+	if (cmd_size > FASTBOOT_COMMAND_LEN) {
+		printf("fastboot: command too long\n");
+		tcp_stream_close(tcp);
+		return;
+	}
+	if (avail < sizeof(u64) + cmd_size)
 		return;
 
 	saved = rxbuf[sizeof(u64) + cmd_size];
@@ -60,24 +149,55 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 			     strncmp("OKAY", txbuf + sizeof(u64), 4) != 0);
 	rxbuf[sizeof(u64) + cmd_size] = saved;
 
-	len = strlen(txbuf + sizeof(u64));
-	len_be = __cpu_to_be64(len);
-	memcpy(txbuf, &len_be, sizeof(u64));
-
-	tx_last_offs += tx_last_len;
-	tx_last_len = len + sizeof(u64);
+	queue_response();
 
 	data_read += sizeof(u64) + cmd_size;
-	rx_bytes -= sizeof(u64) + cmd_size;
-	if (rx_bytes > 0)
-		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, rx_bytes);
+	avail -= sizeof(u64) + cmd_size;
+	if (avail > 0)
+		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, avail);
+
+	/* "download:" accepted: what follows is the image data */
+	if (fastboot_data_remaining() && avail > 0) {
+		int n = dl_consume(rxbuf, avail);
+
+		if (n < 0) {
+			tcp_stream_close(tcp);
+			return;
+		}
+		data_read += n;
+		avail -= n;
+		if (avail > 0)
+			memmove(rxbuf, rxbuf + n, avail);
+	}
 }
 
 static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len)
 {
+	int n = 0;
+
+	if (fastboot_data_remaining()) {
+		/*
+		 * Image data goes straight to the download buffer, in order:
+		 * a segment arriving early is not accepted, the peer
+		 * retransmits it after the gap is filled.
+		 */
+		if (rx_offs != data_read)
+			return 0;
+		n = dl_consume(buf, len);
+		if (n < 0)
+			return -1;
+		data_read += n;
+		rx_offs += n;
+		buf += n;
+		len -= n;
+	}
+
+	/* command bytes wait in rxbuf until they are complete */
+	if (rx_offs - data_read + len > sizeof(rxbuf))
+		return -1;
 	memcpy(rxbuf + rx_offs - data_read, buf, len);
 
-	return len;
+	return n + len;
 }
 
 static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen)
@@ -100,6 +220,8 @@ static int tcp_stream_on_create(struct tcp_stream *tcp)
 	data_read = 0;
 	tx_last_offs = 0;
 	tx_last_len = 0;
+	dl_pkt_remaining = 0;
+	dl_hdr_len = 0;
 
 	tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
 	tcp->rx = tcp_stream_rx;

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261022-upstream-fastboot_tcp_b4-5d17a3c8e2b9

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

