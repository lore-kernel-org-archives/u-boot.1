Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE0CCC6B2D
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 04:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3DCD81255;
	Fri, 16 Oct 2026 04:32:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqOt-_NZM-mN; Fri, 16 Oct 2026 04:32:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 025978120D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792125122;
	b=ffrzEtwUuARGF2InS/y8G2sRohZLOQ2nvd3sRjY4EVFBreDUWS+y9UA1liTczyeeEYpW
	 a/BoUSGNFvz6/3iNDpkT0aVCqj/77TRHSkc1LZCDipH7fhKutcUItz0XQujA1QLPeLJXs
	 niQlWjo7CIMJBIGYvSVPoHHZ3VpVys4pXj8vzUC6rV+6NEeddPUfKsDsJIYBwQftwoV6J
	 q7BcDGAdWejpn7luqpqxaheY5vKISS4isMxSO8vqWwIPnipf1Oq9EMgryIdN1ZOniJUfQ
	 cADy1rwXT+uKaoTpHZYbfJuL9xIFj7sbpHCUSS6K/oGn+gRifgbDCsP9DBMz8pqZuEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792125122;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=REexbdbFFOGE2G/KDsuUPHCMO5NJM6ANUuG3TXH9lZ4=;
	b=obdFog5P/m8YXtkje9UKF8fYbZVNLpk94ZOxg3L54SgM3oCLoxd1Nn42vyVB2SgpcAay
	 XKJOOAiP3lXfWNtaLBtHqoLTGo6ULD/UzKca548EXngJNcxukw5ijOlYSYXXlnt8J4Z4R
	 ZMMSIcmGo8Y/nXOoGLrDHMaquDid6aznogtsfWfDQ8jjdxFItU1Dqmdj6xb2Qs81J36Ac
	 Ggj1uKZrGdQSAb27o3XnVATWG3KRJ93u373rZvRDSXZW/yLgBd0NCSYYaYGKA68rkTn10
	 AIyANsM3s9tb4i8IEHESYZWJNtu6dgaJnb4jz1MEtkiB8P3J3tuvZHM4Yl3+TydOmVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792125122;
	bh=REexbdbFFOGE2G/KDsuUPHCMO5NJM6ANUuG3TXH9lZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CchQ2qso3kM7cr7cCaxsBFtjTDLl4c3ZtULX0geyuEdrBjWcDfiOs+nk7vReQgD2u
	 nZMtZN14FtfTZZL3Qoe+kyfWthQs9URZjk38BWqFHrieYRbpSUXzAvoUO7yMDkNjVx
	 s49+faZt+Qj0yu81fZGnMg5Owd93WlYSCgVTIpd6TKKFHfjk2hMykJqFJjYX/H1Hab
	 fyq/a3FiA3egLrNu+jPPtG5/fj20CgfoZp6kXBeLrFK6iD/NAqdsRnFZ24zZcqjidu
	 tZPGrJAxgB6vfPRejYqb1Jw4UD4J2/l7OKdKlVa82Qj9oThSlh1bhcbSQIervtkHW9
	 anqYQuAyiPnbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 025978120D;
	Fri, 16 Oct 2026 04:32:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EDDBC362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3F7F400B8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hx9zoRkb_E1p for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 04:31:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F190C4009C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792125119;
 b=iw6Bxki1mBNY0OmiJODqXt+QPxzhhkDlgtOK4z2KkoNxrJuKae2V3XeOHTRwZn7OaSlx
 O7VNrXN/h2+I0sxJMlecU0KGauIhKe2KrUq7wr6RpcVlDBSj7eNF8BTp02t6/Vynu90+6
 3PcCtZCejTMPiy/SAgFimVK0nr0HFF/oG7Mx1zL9KlPWsdeNR59pANpFuBrnveR09dg2w
 YeUN8NETzxLnBgJiOaLnlJaCgxohoRvv/XiDFw0+x7WE0CFytoGRom/sg7ec/5i/PEem/
 G8CM5/gTusFc6fVrUztxOInfYqSNhgVNszwPcN3G9k/LbfZK2vy16OfPliPTJU6+Nbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792125119;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=REexbdbFFOGE2G/KDsuUPHCMO5NJM6ANUuG3TXH9lZ4=;
 b=TE8rG/kElVNiYiAtAqC+lDRP38EVBe98z5BQAMpCvbFR4IYUUVAp8BovXepsnCXJuHgW
 6Dh+g46myfhjLaGNTrm3D/qt5tmIKAQxdIKr3MuvAn+zV8QE5eEvYTTFYuVRtfrjIAGPY
 O0bOUFBkU8yrKI6/R9cZzRtpHQRFBW7rSTjMnOEkYK5/TwSNTFe9zADk1Z1UkR5eaVVS7
 uk4X1giSLwxXjk4gQpCVHNym9j0/pFMIZMslmIzZyucoSgX5dSZfE2BPFsr1SzO+KAbmP
 Vn7WR4M1OBoFsi/b58pE7ISRozjB4R+jwn+Q6Giy8boIsPHUxO/GRX7+7n7xtpwusFA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nt27iCkI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WTLzmI8Z; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nt27iCkI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WTLzmI8Z
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F190C4009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:31:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FLvXxA4126470
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 REexbdbFFOGE2G/KDsuUPHCMO5NJM6ANUuG3TXH9lZ4=; b=nt27iCkIu++ihXs2
 XjxMzzTw0ITBCj/AhJ+WzmFRQj10PAnIeku1vAoTUqnBitDxqjYZ0H1iPu95FX5V
 pebLsb57UhF+0ubUqt8PbkLeY6HqBe7CpZXoR806CpTQFArvGPsP8bg3S5PFCoRU
 xzmHpHSwLIgBhO5lJhz5uhAdtJ5jeO2XL2KyYJy2FOHErKTAjpgXTarQMFyhQYrH
 x8/URdotc/0Q14nt94ZtlwhWlxgjk8J1i5opuyjQf9oYxnaYIFhPPSg2zKVZhjJs
 e1XCWC9s4DSRVS98TkgCWrTiRlMtvsznLJLXQlZ0bJYn5aeB6pG/gEASK/9omUdy
 X0bWUA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m2p4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 04:31:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so7154321eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792125116; x=1792729916;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=REexbdbFFOGE2G/KDsuUPHCMO5NJM6ANUuG3TXH9lZ4=;
 b=WTLzmI8ZPlXYGJMoUcxg7I4I3YhkyMVI0ZYwKVBwf/mhEx7hx9eOnB1fOBxJZDSGwi
 K1dta6JN8AKJLfxEpov5LqJGCNmt87RygquRmpmTtZ5hg/sU57z7JzConooS5gfq9RLm
 Fk0uKDpD3GyEd4wO3XpwdRZjguhLs8HT/MYV3dyNR14Z31Hdzchx9eMqdaN/0XFo27w8
 KUUYV3zSVM5A+11qxQG3HFYjAzdHXqpAvPI25ZOcdl7Pz75G1LtYR+k8kCOgvgp+DoAP
 oAnAoTLkLY0iRAwORUkIFqTL6qyF6Kd5laa6fZaPc6F+b3RHNclpWM5nEZ4aE4dzg/uo
 yiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792125116; x=1792729916;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=REexbdbFFOGE2G/KDsuUPHCMO5NJM6ANUuG3TXH9lZ4=;
 b=dSDfby7yoESFbGmcjU6gN4InEUNsefRkFD2ZplxIgu8Qur3SDse46/Xe2QU40iDNiw
 i4K7EbpDjNWnL5E5YNTpDAKQARHAHoz9KjxVSakSmilp32FkmvraMoU9nGpSeb2ChJwA
 WZETUjrUTsghd/rAuK9baC7twc1IaZy4nikqYbFNUdSpXRkmVg9RdJc9uJZye4C3Dvcn
 PR4QNhKy4Z1a/p+XJphXE0Aca1NMnh6lf2tiMGOmgrpV6jA7mwp3bOVFX8g+7x62qQEx
 JbWaPAcDrwzPxLDMTmz9P+sfQpWIEGlPlnm9DHo/pB8Q+v0pOPUoE5wIfxMgwaDI/GZj
 Xqzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKgVPb0WWKJu2+9kRR6OuPWoqh/NIqwm+ttwe19JbcQNk1A96oo+sIjl3o4ATu6IWfEA/W+pU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKpOqiPn4ZaBTmYy/f5UR9DIaELT01Mk/4u8dF1swCPmShRNZtE
 3n92gMzSHJ1qoCBQTWDhDZnw7buLzidnxWnbpCV/9K/EtiT6OQCnBeTuCyH1A9kRHjpzAELE85w
 u+ZB0gmK1ORnu692tEGanj788nMxUhOUtKFHWbsEjFc30E3cqBN9zlDNwrc1QSNY9QR684+A=
X-Gm-Gg: AYBFou0QgROcbfFuCV2B3FwbJS4GgLSXEbXnxrmrY+2oJhIpH6LlTD+0BNLkphoA+gx
 uD3ofn7YG8IEJ72dhSxBV1Vow7KfnU5KT00L1ggC4AWE+302HVe3HvFdiVriHnUDDXD/lq3YUMO
 9Wlf+V1l80cNFFe2rTCy4dIhYxuxORWNPXWXWnMRyb4H3vzFeXcFoYWylBhZPRIsSgzg/aEY375
 vM6l0mn4whrRVpxmZSDaCnmgcvdX8Uw6cQXT1ZLBxia6qZtjsE/03vLGHA18q8nQI6OJRCqcGCY
 Rr//R/Z0kplLIKzooaNv/JLku1P1M7tEwZPQpctHulKAQdq80ViAxZZLS7d/ftnnL3woNOPtVME
 0oEwFLbQs6X8bZyU/ty6aaW8jxLH7xn2Md1LxsQ==
X-Received: by 2002:a05:7301:1987:b0:35d:f3cb:ede with SMTP id
 5a478bee46e88-35df3cb100cmr14735757eec.5.1792125115856; 
 Thu, 15 Oct 2026 21:31:55 -0700 (PDT)
X-Received: by 2002:a05:7301:1987:b0:35d:f3cb:ede with SMTP id
 5a478bee46e88-35df3cb100cmr14735685eec.5.1792125115113; 
 Thu, 15 Oct 2026 21:31:55 -0700 (PDT)
Received: from [10.151.41.177] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082f7f6e0sm2996827eec.27.2026.10.15.21.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 21:31:54 -0700 (PDT)
Message-ID: <5921f8c5-a0de-4edf-8d55-5a3d1c103184@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:01:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] board: qualcomm: tfa-optee: enable the OP-TEE
 library
To: Tyler Baker <tyler.baker@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
 <20260928-monaco-ventuno-q-v2-1-0e046c8242be@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260928-monaco-ventuno-q-v2-1-0e046c8242be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad1a8bc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=go85u6BCrh05KXbfni0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: T_o5Cv6qB5nYciS4oRttFTRM26LnaCSx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAxNyBTYWx0ZWRfX9H3IKyXXjjbE
 xZrQJUqJO5bNwIS5r/EjtDN30KAJzkWKbsFPT7pOmXvL7dd/V+d9BRil55OYRSwl4uRaA9H9Ijg
 m5njV+5jxEo4eJl3neAE06wv0ODyFOE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAxNyBTYWx0ZWRfXxp35C4M3uIlo
 DuTtA6t7wmp0/GxcKCVgsZ3m+urTHZclU88o849QXcO3aGFNbG6Dal6ccDo/ZABqjwOfwmKe14W
 mapGMwyCuF2ABsWv4JGUL40RtpYR0sZKBArH5hr6dLq9ReXR2MTWW8KquW5fKsvWMm4XAr5QEl+
 W3dU1gxGqcfLkYwBK5utpyMvSVjYFMVrefSaYNYZzHs1x7qD6j6gjNQYQyQ1rVoBOornp6uB4Yo
 rRimw6sebc24SZtAnPr8zeZWu+3eN9UAso+WXdNm6pBIPAoNX5JcNMjuHfsl4X8d134XcmYcfWi
 H9LKA5mxqKmpvd/t8aH60ReCSi5ZqMQFSpsp9+TuWQ3P4IdzQohtRNzoOwhy5VpRa6Zy8tlfHvV
 LFHuvf4n+KCUPr807PyyV5yTwiXint2ZYVu1RgKAYLrUsxzWOELjJB+gr9gWZftEx7Sp/jmSaEf
 bp3kxq0wm8Bhgvv0YKQ==
X-Proofpoint-GUID: T_o5Cv6qB5nYciS4oRttFTRM26LnaCSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160017
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

Hi Tyler,

Thanks for posting the series.

On 9/28/2026 11:36 PM, Tyler Baker wrote:
> Merging tfa-optee.config after qcom_defconfig leaves OPTEE_LIB disabled.
> Enable it so U-Boot copies the OP-TEE node into the OS device tree.
>
> Fixes: 8459d9c3b415 ("board/qualcomm: Introduce TF-A and OP-TEE config fragment")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Reworded the commit message and the comment.
> ---
>   board/qualcomm/tfa-optee.config | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/qualcomm/tfa-optee.config b/board/qualcomm/tfa-optee.config
> index 1e8364c114..ef13d68803 100644
> --- a/board/qualcomm/tfa-optee.config
> +++ b/board/qualcomm/tfa-optee.config
> @@ -2,3 +2,5 @@
>   # source TrustZone stack on Qcom platforms
>   CONFIG_TEE=y
>   CONFIG_OPTEE=y
> +# Copy the OP-TEE node into the OS device tree.
> +CONFIG_OPTEE_LIB=y
>
