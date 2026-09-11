Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EF7C88E41
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 05:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD44380EE3;
	Fri, 11 Sep 2026 05:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLECzqUw3jfb; Fri, 11 Sep 2026 05:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02E7D80F55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789105724;
	b=fkOsRNFKRhwSRiqtJKysTOzYrmrU/+TH1G5HYMpZlQ6ZS+tYJsZ+YTlyLAXJhxFWXc4z
	 QXGBGuwl0blh007ushPnQcHxbbSPI4RotPttTTMQseWNO6/MwTqSuIiFYpMDiQWm6XTvL
	 KROxSo+3OS/22kxGlVQjlxdqVLoewJzW4UNqTUMtRUn0I7MeicXYSpxtfSkH7PKInwL+3
	 d7DeajGklqQ1KH2V2hRJBSOddEnmGJMIghPS4SMDCJe2kzHnzwyCOD+Ce1bmgp+vgHAdJ
	 +5dgm0U0Bd21VDiWIETT6RO+bBs2q7T4fzhrNdydgRZwOVf49V1rZBJ6dDxQ8hUF2Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789105724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5AFtGOwzjARhfz9ySfhaVFTtb/cgywhYGIyfUNWMAgM=;
	b=praeKyni8aSAbGRKasLfFuZO3w1YcmmfpL2oi0DXaah1cFI9H5zgM2lzVnaMwuk2p2R6
	 4H7OiUGf26ERtM7qfvJ+emKMHrqg6mliHxbPNE6S5zGAhmlz/OKWhNifnLOTWE+A+L+mX
	 LiShA7EcGSmChre0uw7j65eOwYdWGPsSwsNjpI5hEEKTiq+kevGbvnQr9vQcIV+7jQ1z6
	 n9xk1d2xdk65dLR1e+bciDeCmPjmO+zsFgs/kKxsBKklEUtkdl/EMWp4tKEhM5J/aEIED
	 HzJ0toYA9yHpDEmQSEyyLPGamtqjeZnMFpJBed7EkEogcwcgMLq3N8dRn9ALt3/sg1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789105724;
	bh=5AFtGOwzjARhfz9ySfhaVFTtb/cgywhYGIyfUNWMAgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oEVg8vSWc+s1/mLc9LxZ+YgpYVGe2MHNs4nx6yyhjYf7BBNgy5O88S9nWbn4LiTJj
	 pu52oPDEzR/v4Uo+9T/5w4YIm1n2yQmPSutCbUROlBb5JdK6YMe1ycX7F9HfL2TUMH
	 tgUFC73eNApp9u6RAP1Uy5I/LIjLuK9VU/hT6Cz7gXygrdxHtms9TqLcXFos2+8yX+
	 tS89T+DIvSxRUuwOzTMrUEl5ZSS6q998mdv3QEnxUcT/qXss1OEP6oSD203VjjRo+L
	 ymZ4PKw6hX6EwBsulyUuHjXhtrAHL8mLMIZxvzA4IYcLbn3Hn5d/Ya7y1SzzGPdhm6
	 WXuP740l8GcAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02E7D80F55;
	Fri, 11 Sep 2026 05:48:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 97233493
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89150400AD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFkiaqu_VKxI for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 05:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 02A2340073
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789105722;
 b=slDLGh60mu2v/RA+pLYqFLILN2IY/u0XHBeyuI8869cwC3k+aa2VcEuWcsFlbVENUNFM
 4uaHyL6DkTUYOdcAbNcnlH/JRbhPC1a1K45c1DIrmVG7lTLFVwXEcK9pVk3UrfAvRqEAs
 A2a3GV8IyibontFzto4sXlo5twErLNeZyC8cdYdQ3UJ0hP18AIP4F6FloIKL+iqqJ94J9
 xOmaUenqQcuwEtMGD1UciYLpQEKEZfZC71As8C0+mU+CPP7O4J5jy/DncPlgTuTpesDec
 JuWVMtoiMJ1cGP8ZutPUOgx9vxwCp2mMP0TW00iC4Ht8uBvucFMOJ6hB3BxYwzWs38w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789105722;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5AFtGOwzjARhfz9ySfhaVFTtb/cgywhYGIyfUNWMAgM=;
 b=blV1953Cuxp5z28M4XqS1sQNNMyXGFijp2G/4PV1JJ8l3HPi5Dp4RWagyZf9ZxeLeWgt
 R3JgDcWdcHJ9E+jVn8CsaHXWdc5c+RjNDkdXT32gaOYNjZpXVR3YUJlWnc1ZzTn8WalDB
 A1Id84lKeDc7oJsXHpYhFVHhuV8Q3ecBwPzmZHMS4LmlTOi4qBqhw04uFifK4y/yiec+H
 FoYTTcI9DhWXLkNEmpqmvmPvN4EUh7py+DycaKLIgpkn2DmtqH8Os2Ni5tTguuR2N/phv
 Fe1gzCeXweFqMtVMAypsMlCJqYW5ImblK7TCogwppaeZcwlhbfflGjYWRqDnrXcnd7w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oNQCQfx3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QtHr8UwU; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oNQCQfx3; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QtHr8UwU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02A2340073
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:48:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B4vYj62634883
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5AFtGOwzjARhfz9ySfhaVFTtb/cgywhYGIyfUNWMAgM=; b=oNQCQfx3dHcMmdZQ
 K3FPebjqBEUWiZm5gwvxduFcSU66spC3Edkg0oxTec1bobMgJwOu9LmUDROW5rjL
 S5t/EJ18RfPOzW2SLEj2OfDR2ZlEwWh7GeOpWvpvSIBU9O5zOC08j8NmX0xCNuab
 Hxk+VQwGC/QC0dFOiQbFsPrrhqIy7zEKEzIA8veyCOZsVb/b+qlp8UJJ/+yMRHLa
 kuek1BWpHmEv73gIQ4kzRYRVWuB2AxDPLn24q4hNUTOkKs3kWwWnVXz/e2HVs3Zl
 gK8AdokF1rCaIIHiPEI8WdOOq2O6I9gGphg1mpWbkZnP6OB6fYo5bgEt9e4iJiUR
 g4W+FQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwvx3kdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:48:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so713557a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789105720; x=1789710520;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5AFtGOwzjARhfz9ySfhaVFTtb/cgywhYGIyfUNWMAgM=;
 b=QtHr8UwUPagz/e0L7nDfLIjQjv8Tf/Ry7p6XvkKUc7MITUKAxLr6dBNXMj0aA95U3x
 xkRCHFaSLxwXKCBQiXwXyg1pnCelkQ+ewHuZc2Z2KHTvSSHZnTsQqXkwo6j47JbT3Ejt
 21PnDgMjFE0Ltk+KanUoT5Lwti85LSuWOFcphMTJOTGfrStsnAO218RZtb/7r9D9ubaL
 nvV4Jaek6tBD3ObjHR2hXQuOjBfIF5Hi40lReDHsllbR0HyEyYOp1qmuW8mjFeXE8kdm
 5R4FdZrMqtfPxiwykkQIvF+5574H/bDebRP1XqcSKSeAM339MImSOmsf9UTsQ7pi98xl
 QgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789105720; x=1789710520;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5AFtGOwzjARhfz9ySfhaVFTtb/cgywhYGIyfUNWMAgM=;
 b=gInmeHs8akB/uJ4foCC3F6SP4D3mcmQZlHRiReAKs40WPbCme3ibsyOviHwZYCH1Cp
 +lXM99FONJ+XMRoyN/cnWi9FKbKuFmfAcTYeyciFAILVeDQ0BQWGQmnHV9te+RBTQjU9
 N6J6lCvusKlOo+X8uH1A6Y9vtPbdoWJuKHnDGU5jCmDll4U64NE/gckMbUm5COYDb6s1
 oYRUD0I0nD2JFT3WCO3Zu4TvLMkxAzbywhXC/q4q88TNPFO/bnsdyRSiA1TEEOg0xyps
 JXOsQzHcLG8SuD4ozVtHRgE5N48mV6Y3aiGySO11Cn4TpS2witNFGkGAwXdSmGcqjBvH
 GKLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj+I7wBjgw+ESrmNG1iTKp4OBpekdIz7GmJMviV6TpZ6DgKCTmfFjGqLFZhzQebwV3wUdWxtM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mfBHF6v6UzYoKe5lzjC7qSJqQrBJI/j3VNfP4fQuAVDtkrZ/QB
 8ffx8nRNwtXhKtyCbWG8feh0l56y9W8w9bqlf8S0SKWSm05TiQCQw90fEspom3B1EGJqKaxugpi
 E15Qh+xQOGuBbGTOFH4GXMq8xji5tjMIpQjlOcnF7ySDn3f937jYCVgwWNzF4bXXYhuEK7tA=
X-Gm-Gg: AYBFou090py7HyQqQmDI/ylcb9cUjr4anFU84n6Dph4Sal2wjFe+6Kg/v+Y0gb3dM/y
 QnGu/fhZjlI3F90a7vsa+QF8iQegda4eAlp7itkptf79XKsxsS+qQ095CLkI+4oHO8F9elWtodc
 fYwvPtqrDiSjZOHPumUbMtR690Jyo5hoCfotmovQlEVo3ipf+306mxNrk46Lx3XVIIgTxVPkir0
 jrJ69fOVxBL9imQ/Xc4IoCEKU3fwC3nlx2A0DVoSWii4IzEA2BCpkRkUz5Uc6Fki+JD3fEjaL+l
 qikB3cQp0JVvMMZjq0syKuRnF932TkhkrHElfE1axRpw4ebgeHE47G9Ahx6M8PbjqOT7ZZG/a6D
 3bDqEh4XW3OCp13erFvsU7wDVSBzKjnoUzwaw
X-Received: by 2002:a17:90b:53d0:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-39d9c3597b5mr3692571a91.23.1789105719732; 
 Thu, 10 Sep 2026 22:48:39 -0700 (PDT)
X-Received: by 2002:a17:90b:53d0:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-39d9c3597b5mr3692524a91.23.1789105719198; 
 Thu, 10 Sep 2026 22:48:39 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm3601553eec.15.2026.09.10.22.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 22:48:38 -0700 (PDT)
Message-ID: <f7f92ec6-e5ed-4514-8e70-8bc6179f55de@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 11:18:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mach-snapdragon: Carve out reserved memory at init
 for MSM8917
To: Reza Kurniawan <imkyufie@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
References: <20260910095339.110427-1-imkyufie@gmail.com>
 <20260910095339.110427-2-imkyufie@gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260910095339.110427-2-imkyufie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA3OCBTYWx0ZWRfX9bKNC1aBjkkr
 krIzbfLGwq+ipGYjRnHA8RN+bogKEBMn4lTleGXP+2Dwr3Bf/akHzkYSXKLkqjq47opRXT8o9jG
 jp3CBgTVylTi6JDC1QUxW5dgn06a6GEYyKk+X527lNxY/aOGrOFMV2FC1qkgIJu9j5j6/AavI/v
 /uUN3ydBW0QOT9Y3UG+UHiqp1pkf6ccuGMTZWWeSaI686apFBN8b3vqC2hig23qko60L1FrBtNk
 XeX9Df5yBiZ99w1NibYIvNV0uR6PC4zIl9E6bGElklXM6hLBqjQq5VW7QIkutjWhQycyMflgfry
 FMe2acubHkIALw5d6nb03F/EMsSQhZi5b+YanP/dmaUrIxUwQjIZaTw66RaxUahoIvwUuvic0cU
 REZPGsWyMpB+9jBcr0CVSBYPaeNorkfZRcxuGT2LD9n/9uvGkLzXKSdruUwpxeZH0wNP0q+A4vu
 rN+8SMDJg+cbAzp5ZPA==
X-Proofpoint-ORIG-GUID: iDu5M9soakxbqjfMi-PNhslKwD0_5XFK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA3OCBTYWx0ZWRfX9JrCwoGRpN8m
 re+Qusv9TIOlxKAPdSHKDOHf3NHhKQGEKVlQNlW3cF8jAoYzTayHX3u9ns3E1xKx3TPpi9xpRah
 SnmYcFNyrW0B7AkfO3Q0An7UP2gOexU=
X-Authority-Analysis: v=2.4 cv=AdkkjHXG c=1 sm=1 tr=0 ts=6aa39638 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1sp61-E1uKKZnZyB54AA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: iDu5M9soakxbqjfMi-PNhslKwD0_5XFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110078
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

Hi Reza,

Thanks for the series.

On 9/10/2026 3:11 PM, Reza Kurniawan wrote:
> Certain regions of memory in MSM8917 are marked as 'no-map'. These
> regions may cause security violation when included in the standard mapping.
>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> ---
>
>   arch/arm/mach-snapdragon/mem_map.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
> index f64ec0c67..eb0242ef8 100644
> --- a/arch/arm/mach-snapdragon/mem_map.c
> +++ b/arch/arm/mach-snapdragon/mem_map.c
> @@ -216,7 +216,8 @@ void enable_caches(void)
>   	 * reserved regions as inacessible (PTE_TYPE_FAULT)
>   	 */
>   	if (qcom_memmap_source == QCOM_MEMMAP_SOURCE_SMEM ||
> -	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
> +	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0 ||
> +	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,msm8917") == 0) {
>   		carveout_start = get_timer(0);
>   		/* Takes ~20-50ms on SDM845 */
>   		configure_reserved_memory();
