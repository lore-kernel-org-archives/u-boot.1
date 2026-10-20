Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DC606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XL/WqCe/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TsRZq4hd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IFv+kwIw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17C1A81021;
	Tue, 20 Oct 2026 12:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lI5roIwqC9qa; Tue, 20 Oct 2026 12:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 405EA8100D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792501043;
	b=jfVreQXYVrE9IVQls65M6Aw4cp0cmuxz5xzba9mQPhhcCeDnPAz9YzEKcZwE0pi39Iyg
	 W9UdnkUxDzBDw50kQMBpLf5b21CR0+QX9Fvlm2LNSnjKGUXVg4L8xVP1nL6Chd55sdXrY
	 XvdgU2SEr1M60ED+V5L/02ww9RQBnrqjh8YSHv0w5hKAN4wXPkvW/JTacQ2EpYGTTMO7I
	 jql9W++C1tuX++WkUQR23WZgXusmjcGkdyLmI812kR2/ruci1dTrDxJyxOArbd3G4I33m
	 LYur5mAyzq5Awp94uIL/lnZHBd6c5hZ/6jQx6V0bx5hpB/kGS0Onc7y2851t7rR55Rw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792501043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8LJlxs284lqsE+NcCbDii8k91IndCU7LSyV/mXhmppM=;
	b=kMAD3Bz2DGgJbdycZnxONUkVNYfyOdoSmfcsNxAw8aPL8WhbbYn7MJ20GSUJRem1kFSy
	 DSMK8BMuPftj8DvlHLoo+uFNAiYQuFBpIddg0YKsM1sIArk5bWTW0UxkCAes3XBHF/kAc
	 dQWI0cMoVYnpOx01GQYZez0QHhKoSlT3BWpjaC/Ah7IKdVs/7zd9QVe7tZB1E5U2ByCP4
	 gylplAPJxWjGlc/zgTwuL2Z+sy+63lwnUgv/BVwofJtKc2MkONFCNXvCdp+m0TsaoCWVi
	 nqy+uY7NNjVR0tRr+DFnE2JvuoVjbYBE9KjzQvc2T4Z7Lkk+HzX8CKncH4qO1doaVKQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792501043;
	bh=8LJlxs284lqsE+NcCbDii8k91IndCU7LSyV/mXhmppM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XL/WqCe/ROYX36tCuO4Yxvgw7WocBewHR3iV26WxehHzB1G1AGC9k1v9tlOkgn5hO
	 WGfeoXxD3b7s9rjRWjllApxJg35CrhymOLI4d1598r+5J05XYqCGNcq9CeTFpqSAsE
	 +CEY5c3xZaxtIMFUeyIXtDu8Lbrmo6J+WXKw9MCGs++TVjyaAkPMr2mMYRYBPVHNat
	 6dt3eDBF7ZUNrjf13910D04gD2hmQCRNNrapXpCCCLvrGmV8BIsy9vHu/fsLaJXzqH
	 KwN12GLuTTD6bOQx6Mvv6UOZJJI4WDmJ03FnR0CYgSJWRq/fBFWtBcqFnLuqu3zmk/
	 wQBMxhHHLisaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 405EA8100D;
	Tue, 20 Oct 2026 12:57:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81A4C769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DAF640191
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3k905vleUKcS for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 12:57:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 970A2400F1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792501040;
 b=NXc5sTICza6LWpcTTxGjzuHrVomTeAJoPU8wwEBWgpPWWhXGFCWvEocquoLmcZh2cjtN
 5aPq+TF0Zu2+Ey4uQ7BxOKpflbvROsbyTOuWJthmar5WiI2frZlLvDow8+lGKa91/sZeb
 SRjJuX4XREsklHFM2ZcsvyLA3QFcxxAMeFJH4HG5CE8URXG1kpzIZIsBq/xr/a/F7Xvru
 8R5MuATuhVcDzGKpy2bleZXkV27LBtm8XrYbi9FiXH8J/JuHRi0Kkwt4+i6E/atuWrNbL
 /6hUMXqak1gAmP7wT4zHw4vpcGoWJUP0ae2M9VXfiHtssvDl27bpBReGqGmoz1qlhLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792501040;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8LJlxs284lqsE+NcCbDii8k91IndCU7LSyV/mXhmppM=;
 b=i7wOHvbWy6nfwq6e+03fwbN4K5VQhY6W5TiEsAokm/0ya2RyTycMDL3jnaNabVmg1MTF
 Z4Wy8Wo860FdSAkLACkHzdBSpU2/sNCIX9Amem+h1Ec8fZ8sfqyTZ7iuBzTTlYmwAxUEl
 gfasyvuzaIFedLiLfNp5wGSjGK3CSmUxnAT9Mu8aQB+L4tdpBbgQvPO8LpNF1bOAlyHcZ
 26oNRhrW+jtiHFTCXcUdTJPZ3j/QtyZTVmD9+KoLQw84Ns/Cy5sVnyiRy03r57v1JSimY
 Y/5HWNzrwe2yv8U6HmlYQAoB42Doy2052ayihiFiPyS4p3fFCl9+3+ByOReQes/1w9Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TsRZq4hd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IFv+kwIw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TsRZq4hd; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IFv+kwIw
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 970A2400F1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:57:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KBWSEg1571650
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8LJlxs284lqsE+NcCbDii8k91IndCU7LSyV/mXhmppM=; b=TsRZq4hd6jK5QIEX
 kwd2h1ALqhF+4flM2AY+Qthy7MOH5jy9Q0PXtFkTcxLISsEK0zgCgwJk1OwRjy7F
 t9GurWM67ZlxxCsMztKiEaiv3Ncx2MjM5pbWcXllnNI65oVgs4sPTq9OQ2vh8Yir
 BpbAvelZgc8S6xB48oKKQ6BkENKlsNj5J6xcyX339ypVKVlfRFQGwfXbonaf5Nu0
 b3FRAnAoQuBAA550dL+N17EOD7tsCB4Gw34Z14I+P6xjN2b4gM167/hvQoYWwQPl
 1NO+25HhZdmsrvYDUzu2I0ipnr59ISXlmbHfWbZ5T+mQQGUQ+lC/ckmsjFaPlJEL
 0laJ1A==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h288rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:57:19 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6768601940bso912019d50.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792501039; cv=none;
 d=google.com; s=arc-20260327;
 b=ZK19M+KBC1Ot6X/pslSM43R6SIsNk4UI//bhNTmSr2OAklYL7tuPgut3ofwGjaf02W
 juVCeerqR1dTjnZbMXEZa3EIGU9mpWHKiTkimpIv+TRpwaiAdKDTfOn5vXKqlM9sm1VU
 IubHuUXh486cdGo4lgP0iuDW3WIbQcK1wsaQL/oxh5pIwVyOJQtDaEho7kpUlVnZ6A3O
 67RAjotmemujLyw960ukOMJlg+UWAwyeEJ3TwODqiRvOnFeakxUX5U8otI1shzFYKJXk
 2lNAMSITZFuC79zF0hBbGBL9mkoz+0VWWiGzesqHysShFwykto+O9nOxyx5I+wDzoUiA
 9HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8LJlxs284lqsE+NcCbDii8k91IndCU7LSyV/mXhmppM=;
 fh=quFAl8BWclN9OSwwwU9UVLEYlYnleK8Mp7C3qIqY3+k=;
 b=a3Q0svtel2HCcXeRSdf2xS7++6o4KeZ8BhyQG2FPS/C3bXZGGqIPd2X7Rh1KwNrpS3
 KPF9AVqBh9OmSIyvEM6PCa8H97uh500UnC/P4Pud5xSEE9wKPnCDPakffJz3PwYOFL9f
 2YLHu+yytOExgwA3AjCByU8wrpZT2PF49lLWF9X945agFMbLK5bSE8CZOixxGUXWVOFg
 1ATMRppXbDjK9zc2yIZeIOS7w5ho6CSLiHH2ix5JwdtcjjlqgokU9hOwNzsTkUBIIltf
 ELn8ChV5Ft6L3GPqqkX9dqsyrRIFf2xFH66PaXxbaS1hKrWvavJwrlxCrCtn6PeWKIZ/
 6wXA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792501039; x=1793105839;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8LJlxs284lqsE+NcCbDii8k91IndCU7LSyV/mXhmppM=;
 b=IFv+kwIweliJt90h7J5/xSpaFmpnREVKrFH1Cf8Mlvl40Kaq63RRElTGweX2HkOUZl
 si9g3yOsQi1EaYar5FeKu+Z0LeD+MDLDE2tQonKBF28yA0YuUpFSvPs9zJOxEv9xtjKX
 k4Oby/MGevWkMERutrFyOB3G7+fiC1gBOAzE4/wq7HiOlhqzGlxmezW74e/yUFeF5dSU
 jnp+BusogbytoMHKeWEVnPKz5iTAk0HKlpHQVPQ7so7stbIxIIrNY9Xhd8toBPLe1Lkd
 7ZNo2vMrQqhDPvoEKMBHrdpt0ymodPFqOAVTT6wZ5oZFDAWXe8pGBo/GqG/jfcTlOb5j
 aTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501039; x=1793105839;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8LJlxs284lqsE+NcCbDii8k91IndCU7LSyV/mXhmppM=;
 b=nsEiOdHUeYTwz4jxF/8OpcnmrS6u3muHTAPfh3VxOTE0pR6KnX4amZKt0HKJIrxw4O
 V2x76hAKAxlNFrnT/KdQ0tp/Wsp2VRYpVs9O8tf2YVpTka9QaaogZwa1dwLqRSMqA5M+
 WY60TbW91qtP6h7GQyhd5V4eE8Br1WfZbaeaEcXkx82ZseA7e03fxHceEMzQd8NrqH1o
 zKt8m0Fh2NDzvBrYXqt5u91tt36QO6TXxAkhW7j+zOcKrbQYo7LXiv23YzVnXKTGCUS9
 PcR4rvgJP/8nNL/CB49L4L7b124tERHh7b/I6uRrHFtzHnUajxdTglb3HXNEOZKuG8mM
 CszQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqBwauHAuZuo2ROrTLeF1WTAoeDT0+Mt43BchFKfdhlUsStt9WqOzvc5z9c8aXkkdoCGT0L6Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJnypMS2HU3qx1fWUX8St/073T1w0j4RwXc4xaMID1O1L0u3glr
 d2MLR7aNh+LUxX81Q6j/ac1h2xs+LY58UeZRwsdDvDiHM/JPlt6DjsJjFDntUchr0gDnGrwrEyp
 HnvmI5uNO08RuMkY5onMdmQ6jOnE47F8/lMpr8g01GCzWdCLFucDRqd+5SRhtxmDLo3rMzb8szP
 KV+maPxgryBpNLJHp0FSqW+tJvIZtHi6x6euTeg5MqMzA5Hw==
X-Gm-Gg: AYBFou3epp9pAAIoQdN1nhxg5w+kvyZf4+B8T59IKzhhp+o6gOGMB6vQOcDU73epGIg
 BHyoSAGhzFM89R2KPS3+ftCL8w+2mWGXwePbRJclawnQCtLGFai3n1YmDnpUaa36vZjtUf4Z5RB
 LnZk5WlmEcKcV42GNiaymN+uKmSsDStFPswwL5O+Atz0xYFTNAnt//jx6LpA==
X-Received: by 2002:a53:ee68:0:b0:677:ede9:3d46 with SMTP id
 956f58d0204a3-679fbbc1659mr497780d50.2.1792501038668; 
 Tue, 20 Oct 2026 05:57:18 -0700 (PDT)
X-Received: by 2002:a53:ee68:0:b0:677:ede9:3d46 with SMTP id
 956f58d0204a3-679fbbc1659mr497768d50.2.1792501038225; Tue, 20 Oct 2026
 05:57:18 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261016072640.772964-1-jan.kehren@emteria.com>
 <20261016072640.772964-4-jan.kehren@emteria.com>
 <xhkdb8q3s4mxe.fsf@mkorpers-koolstof.csb>
In-Reply-To: <xhkdb8q3s4mxe.fsf@mkorpers-koolstof.csb>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 14:57:07 +0200
X-Gm-Features: AclHuK_aPXW-dAjaBzR6ojqrSgvTO3BRbEdKpvdX0v2tb3ar5nsFk_yhGxOHKwk
Message-ID: <CAPzfCAash-859YOP34C=BWq_znN2CWxvAPvLmy0yREzwT5pAWw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] avb: Take a storage interface in the AVB operations
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org,
 glaroque@baylibre.com, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: c6XjBMsGcJNWpl1PkQz_-SCYHIplBS6f
X-Proofpoint-ORIG-GUID: c6XjBMsGcJNWpl1PkQz_-SCYHIplBS6f
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7652f cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=HAEnkh90AAAA:8
 a=kCfjIDE8NJRr-TueptcA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=LzkeyO55kmtmzvcb4Ayl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MSBTYWx0ZWRfXz7wsKgaOiS2c
 J6ldNhf9wrQkLBtZuVv9v46ntXbyeD9tcAsG1rYNLHCC0+ieNJoe5CUA4jcHX1TjWaNj1eVXgAn
 DTBDpxDpdO28YOeHoWdgxdPHkC65+JE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MSBTYWx0ZWRfX6Z1Tlf0BBDYy
 yytdkrVfnsjCsD6/Z2Fn0wyyONi7wsb5zmdW9oMikvp9eyn98dUf0vSWhxghXwOaQd0GOWSEwEB
 K6J8eVYBOmDe2wMx047VRwy5ZAYE9a4eQrdvhUR66Dp4NY9QJqLsrYPVi6Ldhl4Gt3zB3I2Ex/+
 L2ndh7NTTbXuvpAj6AJc8dM0U8dSI+pNSLHcsGpd+nXVoLEGiwHAo/kP3hPRrQ6Y/c8eUGR2snD
 8R2bnqgUI0+MMFGkaPZEbMZ47YHhdt7TzjSXC9z35nfSv0Ov7Mv2BHh7zlM3YKZfIU43SW8nfTI
 YLRs5jujEWo32awVhAEfn6a+I85BxT7OlSkmEbwliGp5inS9dEFRHXqlEyYsWVyvSBsUcpuJaK7
 b14UmWTizTj9i6y3tu/yeXyAb/MVqApyKtHx8IXIeNABu3rb1+6zveXwBGNzFyvELdy9t9fZqae
 rIAWTxX7RZ72oaixNFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On Tue, Oct 20, 2026 at 1:43=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Jan,
>
> Thank you for the patch.
>
> On Fri, Oct 16, 2026 at 09:26, Jan Kehren <jan.kehren@emteria.com> wrote:
>
> > AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare dev=
ice
> > number and get_partition() called find_mmc_device(), which rules out
> > verified boot from anything else.
> >
> > The user that benefits is "avb init", where boards already expect to na=
me
> > an interface: board/armltd/total_compute/total_compute.env picks betwee=
n
> > virtio and mmc at runtime and then runs "avb init ${blk_dev} 0", which =
no
> > release has ever accepted. bootmeth_android gains nothing yet, since
> > android_check() rejects non-mmc bootdevs through bootflow_iter_check_mm=
c().
> >
> > Carry a uclass id alongside the device number and resolve the block dev=
ice
> > with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
> > partition switch on the mmc path only. "avb init <dev>" still means mmc=
,
> > "avb init <interface> <dev>" selects another bus, and neither touches t=
he
> > device: it is still resolved on the first partition access.
> >
> > Only mmc is started by AVB itself, so say that in Kconfig and avb2.rst.
> >
> > Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
> > ---

Hi Mattijs,

A bit off-topic: it looks like this patch series will land soon, so
should I rebase v3
of "avb: device lock state, root key provisioning and in-place verification=
",
which I'm about to send, on top of this patch series?

Best regards,
Igor
