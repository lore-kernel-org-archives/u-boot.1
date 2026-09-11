Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63894C79FA1
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 05:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECFB1607F8;
	Fri, 11 Sep 2026 04:59:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lppl6rPU5Pum; Fri, 11 Sep 2026 04:59:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0918F60705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789102799;
	b=Q3yCvjedgRSv4AthzZ9e4EMmo9S1qLW8c2JX+5m2jwfUFk6SAm92oOZ/Rm+LeQTvqkRo
	 gAFMF1aLahBgm+AWXyHpXAx8L/q9blIAGSpyJ8XQXD7goCFULEvxYiD/SqX68wf2LmmUC
	 tshoX9675omiOWRxLqjWtY+fxU0fkCmepd/nmhuWdUlYuBcZJ4NBdnBOtdBhvNnG96KCY
	 IE9ktdlQiQeglRzHt0jinlGo9HfbWRiq49kAHyir93UU0Xo6MwKl9TuEenhyuu43DZULZ
	 IUWGIv7v5X2YFu5ddaeWH2gVAjz41OPNPMZQx+gO0dSvDrS9BEkamSmvppk50mzKRUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789102799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xjdnAtCm9fbCh1rUapdTXf8CwNEPbnriAsJ4Tts1pto=;
	b=E0d/WEi5c9DMQxO396sEUbKDi5+tCCpvBFzyHkRspD8Lh0gvqSQvJ/G/6eT2LVk7GMNG
	 VdRAa3lkp1NEmJeIGJoJTpJNPYcFt/W+nx6pOVmuGyABuBuQ7DBzoKeiG54FuhMlLoV4a
	 C4kXhyWvDh8wSjwyBUQpm4+ryVg7/ewtniDzrpZSpsXILeTHt/o7hfiXwqpSB0erU55nU
	 t76cG6zFd/+TtpZw+Xu+tyzw3GfMc0erronSKZrOEg/q/I/oM0g0IX1YCWjRp70iISaud
	 NdAAGs0VC93v2X2QCNcQAUwcO30szrs/1sPv7ISmkkYYrAUwvQBgxtfn2X2k0+WZiBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789102799;
	bh=xjdnAtCm9fbCh1rUapdTXf8CwNEPbnriAsJ4Tts1pto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bhE9e2CljPD7SDjbujG1qHgbhKxty/g13xn7qMXm6SnSCTKRDHnoSJseCtHjZl8hG
	 a39RWNOt39YLJWJ8HRrfJDXpMDMd0lxMFHjci0tPVFJYVOAU6AeZxpHLqMlauF4zA/
	 lO3mKnsARWqLq/ITZlhKT2YxfTkUuy1+nNeK+fGugogI5KjnW3C+0PPs+EQhTBTbSR
	 ZLuXPmcPolfZCy40+j6c/rrYbXBKviE5nOCPPxobOEL5Nj4L6BMow2WJk0pGp5xVMz
	 alqDIzY3qpzr6c88cugtUN8U1DeHtQEx13Dxy97j1tTDQyfJ4KWPhPWO9XEFaHX04U
	 e6hrElCnBu3Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0918F60705;
	Fri, 11 Sep 2026 04:59:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7150362
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDCB2400D2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsBfM0n2I4AK for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 04:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 01975400AD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789102796;
 b=WS+qJKGqfaEdRw/Dzi4BhzHh1NEx/XQe86bOAdocJ4U/F+EaaZrDsCmhLaJv4tVpM+hP
 uurbpfSHnEpOntKs/UzBKchtbYWleOAsoZKd0RyLbktiybdNKqIvm2vmZ8HUysNyaO0O0
 iTLC+NpmKwpbREimGXk/fWKTcbSi4K3/Juqw6AQPj/Heex+wqX2pA57xbwHOpDZIUYR73
 LaarpO+/OvIgF9x1JMb3Lf225zwxZUaTEPshUfvfAUsGH6Lq/ShQ5b3EMD99yeeTkwSFL
 JXTWSkc1DfJYbtoV0SLMureC92wbsdbI1PtsI9wlZcGzLzt5BmIU+vIeG3JCczIG6Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789102796;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=xjdnAtCm9fbCh1rUapdTXf8CwNEPbnriAsJ4Tts1pto=;
 b=LsxGDRZ3Z1DNTSDnvWa9pjYmonfibhq485wOyi43YL+7gBAvuaB2pCLAOQu8+ATsTAtE
 Nm2E7I9oFtNSMfRDj7w8qFbyFeZPR6nL2Cl7wd9RSbzYTff60+CJhMaz/aJWK5tUb5Icg
 l9KMmZiwhNe2WqDmsLo7q0CKPpu+sJtc8QnPbg1B81Q7boxM+PF6ivh6MqhGHPP46PpMP
 vtBHFLihsb/G7o/XbDY3WxPT7zAwhCAvXZk+O3iXUVoahzv74EmbzYv2ppn0wkOcWZk5f
 FnOG/1qGEd68MkYp9zJYN3ONQmAngQ+Buc1UEgtu97d+sqNDQVhZNNa260MCeAy6/4Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=fbnT6Zyj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=apMPEB1k; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=fbnT6Zyj; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=apMPEB1k
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01975400AD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:59:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B4wQwJ3956484
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xjdnAtCm9fbCh1rUapdTXf8CwNEPbnriAsJ4Tts1pto=; b=fbnT6ZyjYDAtg0qN
 zWKSiiKn53x94Qx9/depJIYEsemJ0j9WuQw6fBT79mpQRSg/AaSEe2gqFBU0pWuE
 o4rDvUWplS1tpgLjjg/lfbatKt7r1yP7rv3mGV//YIQB//eBjK6os0iLV4eOY++X
 Vxw+q24gdzYV5qNoeMe8aieP9dkQvGyopq5Q31rJ2wKclHdeaeIeX8stt40gIOP1
 6+9gc1n3wDaaKrXWPnP1kZVegbKQURv5X2DNmsrlEcz6RrRm7qCQX6EyhmR0M4b/
 CsSHeKm0R1vUySC429JizxK2G/cwKV0i9iJCwMaDIxcvfLpab7aVFLtkeN/8+QbQ
 impdCg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxd8u5wn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:59:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39b77130a7fso894842a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789102794; x=1789707594;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xjdnAtCm9fbCh1rUapdTXf8CwNEPbnriAsJ4Tts1pto=;
 b=apMPEB1keiZZRmFRrNiV808j0myiA/f3MF2iMuQJAyhV3TG4MYAlm4hQ9LBjI7+6t4
 96A4rgOQIOMMkXCGnwu4Fq/N37OB9xS82yplrtirPzBX5I801h6olZS5l+HeCcpixn+y
 53XxaYHsTvbu/ZNFoLsz1fSHRZUuzpASDqIgrJP44vVeYmPDwVlMywA11TsBhup3LaoC
 QxjkSetZ5eZYGWdzwzq8wKEtP5w0efhx5m362+gMSpztUQ18BkSMSlBIGImLM7+4KoI5
 lQt0PesFkvQXuYAXMDfgcrFvWwMdL4PqLIP90U8VcyIW6qIH8ZR5hoh3JTu46+MUpG5k
 pkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789102794; x=1789707594;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xjdnAtCm9fbCh1rUapdTXf8CwNEPbnriAsJ4Tts1pto=;
 b=deh1CX8LYlmK3CYlavQVJg+dg5mtfwVqh+uzu/soBr1IqNjJ2CMQZ8uXCXHqT/3CIC
 eevkB/kNkwYI8ZarAQ4DPzj26rgkLYt6888Cbw8k5k5OyTxlKlF+MOsVYkPX+KtGmHRe
 MKdm74vc6reAzgc0FQv1eon0Z3MtCWy4zFVz83SR33ECMUXptuwn8SccR83xPoMDwrFo
 tYBUERqnK4OzbhR59G42v72h5lbUySOgUKyVvwgj/IrDfVnrhH+rCE7nnxQAcYTbwO19
 rEsCcRhd/FcqSBfNG0+7nQzQ4LkhxO/TjqZsAgvF+bbYB+YjICZhxLktL/ZC9a9BqGBl
 IVjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlQY6QXJf8kBxqpFHf0hAte2c+LfRm0RDZzRUNuLftKLxmwrTTCFe2kB/jmA1c2hioAY2ITbo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l/+wujDDowe/fEN+ho5DQTGrFlx9gKpGP8J/LSdwJjcbZK1Jt9
 RFXOJRSX8tg+9eV5orD3RehI5ju/0mj7lb8iPea7U+KSl4iQY+kTCZp0o1oU3gH7g3xiItG66yh
 OfOF4YVcrdaTJQzDPdWsf0i//ZjYa7ZjsitdnSai3Qw3wgitB7JYjTvVlHWryrUaK2KI+K5o=
X-Gm-Gg: AYBFou0ptJxE/bYvz9p3U5lPBm7stxh+UwhF1lc59lRUia2DzMEYuZdNohbhshJoGbI
 Sn4ay9QmsQwt1kDSdbIV62ICpgjxKj2wHNixhjMMPhEO24Pg6KXfXuG+6OOS/ji/O4XWS4H8NJS
 WfMUK+9ajn02q3P9RLNKFuUlnGXXBgPvJStEL+J/l+e60z9YGi0GJ+H4kcUeSvi0uvF/jbRVzqQ
 hmokjVL0Ye9v8XNq/kGz/zVqZUUzQdcsH8osrFAj5aUsi0jDJfAGE1T53C/YBK7/L4S20aVRPuK
 cnGmlvtYmSO2Jm5PgLiLrVY2iSmvsT2sWlMyLO68oitPCfd1NFxd6gHIbCCGn/EcYufcrXvHL3/
 5lO1RxPGPTD2Nw3SY8J7gkx8NdKKL6jJCyNK5
X-Received: by 2002:a17:90b:5287:b0:398:9bd5:490d with SMTP id
 98e67ed59e1d1-39d9c22e224mr4184349a91.20.1789102793928; 
 Thu, 10 Sep 2026 21:59:53 -0700 (PDT)
X-Received: by 2002:a17:90b:5287:b0:398:9bd5:490d with SMTP id
 98e67ed59e1d1-39d9c22e224mr4184282a91.20.1789102793291; 
 Thu, 10 Sep 2026 21:59:53 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf31c1sm2924626eec.1.2026.09.10.21.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 21:59:52 -0700 (PDT)
Message-ID: <feceed65-1ad2-41a8-b533-235d372ce99f@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 10:29:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tools: qcom: mkmbn: Add support for ipq5210
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
 <20260910-ipq5210-v2-3-d209f7dc0fc5@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260910-ipq5210-v2-3-d209f7dc0fc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nMiDjV-LTSBZLReoPZ5QMaxgHs-v3vwr
X-Proofpoint-GUID: nMiDjV-LTSBZLReoPZ5QMaxgHs-v3vwr
X-Authority-Analysis: v=2.4 cv=PchqFShd c=1 sm=1 tr=0 ts=6aa38aca cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=RSnbo2Q2l2dcZMhO71IA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA2NiBTYWx0ZWRfXxVtSpKKmqc+Q
 CuXK8IQmWLyJtb8/Yfhhh9Bg5DERBnXFFapT1JoLu6GjWjnjCUAWOiSI7gJCEep0/B8cHoumA2c
 Q7Enlv1Cv7G2lq3nxHmYb2mbBnptuVzSw+u9PGr/wpq064N8C4P+xgX8IWX+h1AQHM4v4QwLCML
 +l2e50GQ587csjpBWzPtmhJGDe/vwZhttS7MS9GbFX1eOd0QHlLN2YHEgp2be5+4mBWz8BDuxvY
 IQTsrLTB1ch8tKZ7t0laXQr9YMstOkvJ+ma1strbfTOq2Y20RzvJGCg73W+OUkASnJzhOSeu0K0
 SO3IRcHfd8Rt2aesrYcfqWv12K5bOv3n68v+2aEVlFsg+LB8bo9j1LMIA5EALJPLn/kgyRu7glz
 JtdyPv+IhI86i1zarmFgRlq6hdOIIjelGi9t9NfPfGfLsk/QOIVaDw1gQENy0vMv6K8+6x95+gk
 o5+Mls+gghasS7oa2pQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA2NiBTYWx0ZWRfX/MIZU9iRonXG
 vyr5PB5qsgcJa12GYXjtsBa9r7eMVdGJQR5rWyJ6z4eJx+kukCtSETIXWG/83dqQJME0jMXgx+R
 hHPNp9Uhxal/HXjpCBdv752igiC/GF0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110066
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

Hi Varadarajan,

On 9/10/2026 3:59 PM, Varadarajan Narayanan wrote:
> - Add ipq5210 entry to the 'boards' table
> - Add an argument to specify the SPL load address
> - ipq5210's boot rom expects the SPL image size to be 4-byte aligned. To
>    support this add an argument to specify the image size alignment to
>    enable the mkmbn script to pad the image accordingly.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>   board/qualcomm/config.mk  |  2 +-
>   tools/qcom/mkmbn/mkmbn.py | 34 ++++++++++++++++++++++++----------
>   2 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
> index 769e4a51ca0..dd61ffd98e8 100644
> --- a/board/qualcomm/config.mk
> +++ b/board/qualcomm/config.mk
> @@ -8,7 +8,7 @@
>   # Create Qualcomm signed elf images
>   CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
>   quiet_cmd_mkmbn = MBN     $@
> -      cmd_mkmbn = $(CMD_MKMBN) $<
> +      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
>   
>   u-boot.mbn: u-boot.bin FORCE
>   	$(call if_changed,mkmbn)
> diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
> index 8d2078acc30..6fe66fc4e55 100755
> --- a/tools/qcom/mkmbn/mkmbn.py
> +++ b/tools/qcom/mkmbn/mkmbn.py
> @@ -18,6 +18,8 @@ import sys
>   from enum import Enum
>   import struct
>   
> +MBN_ALIGN_SIZE = 4096
> +
>   verbose = False
>   
>   def log(*args, **kwargs):
> @@ -63,19 +65,17 @@ class MbnData:
>   
>   
>   """
> -This dictionary is used to map a board or platform to the appropriate load address and
> -other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
> -data should be filled out here. The load address can typically be determined by looking
> -at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
> -for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
> -at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
> +This dictionary is used to map a board or platform to the appropriate MBN
> +metadata. When adding support for a new platform to U-Boot, the appropriate data
> +should be filled out here. Looking at similar platforms in the table below may
> +help.
>   """
>   boards: dict[bytes, MbnData] = {
>       # Exact matches for boards, these are preferred
> -    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
> -    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
> -    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
> -    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
> +    b"qcom,qcs6490-rb3gen2\0": MbnData(6, SwId.uefi),
> +    b"qcom,qcs9100-ride-r3\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
> +    b"qcom,qcs8300-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
> +    b"qcom,qcs615-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
>       # Fallback/generic matches since most boards for a platform will
>       # use the same load address
>       b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
> @@ -85,6 +85,7 @@ boards: dict[bytes, MbnData] = {
>       b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550

Can't we remove the load address from MbnData for non-IQ targets also? 
Pls tell if i miss anything.

Regards,

Balaji

>       b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
>       b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
> +    b"qcom,ipq5210\0": MbnData(0x87980000, 7, SwId.aboot),
>       b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
>       b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
>   
> @@ -100,6 +101,9 @@ parser = argparse.ArgumentParser(
>   """
>   )
>   parser.register("type", "hex", lambda s: int(s, 16))
> +parser.add_argument(
> +    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
> +)
>   parser.add_argument(
>       "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
>   )
> @@ -149,8 +153,18 @@ if not mbn:
>       args.output.unlink(missing_ok=True)
>       exit(1)
>   
> +if args.load == 0:
> +    error(
> +        "Cannot proceed without load address.\n"
> +        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
> +    exit(1)
> +else:
> +    mbn.loadaddr = args.load
> +
>   log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
>   
> +data += b'\x00' * (-len(data) % MBN_ALIGN_SIZE)
> +
>   elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
>   elf.ehdr.e_entry = mbn.loadaddr
>   elf.update()
>
