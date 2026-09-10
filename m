Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20676C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 04:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A18F380F0B;
	Thu, 10 Sep 2026 04:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yDZAn3rvpSVa; Thu, 10 Sep 2026 04:10:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D7EAF80F03
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789013451;
	b=tQd+rtyNdqkuEYM+ZEjbJM85wNR5Xm1ThE0l6aSDzudnS+V2Zy4/5a1qGH04FM3Lya8E
	 3490FQ1YU4Ewq7FP1ZXNf/EdSuRROKAfWwmBkLJEGnneFPO1GghDLMlaRTYxWA9bfeekN
	 MVhJlQ7YzR06Y5cBr0MDL3twAQwwA3HNbyfNYq4UqNIZ3cWXKiTSnC+f96CZ5ab9yjco4
	 fIm7ECt+3a2CCKRdNzCqqFFEOrLo+kpsj3sVOoocpMM/RkR1e+GwnwCKxezwE+pUtF/FY
	 pydzoPTQ6sZJs8fnj8kHlngzuSHzVeU2J1sMuHZWkXf1vtePIF60nZXqT1DqOsrN57A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789013451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+HI4up9vgfqrVDcEitREIlx21Ut6HCie2+AfCXQoCEs=;
	b=AQWoixMTLowbLZT37V64DekVqfn1BdiEuK1mSqE56Hw1//6Z5/CqKv772uNnb2Xz9I86
	 fsa/xoDgaxXo9EXMtDEvLo6bWZ00paQYXWcUUvB8adx+Mx2r2Sc6ULZY0RE57jMQAmGG+
	 +lZxe597yqY4McuXMN4fI5tDzhIXZcF0gtBxFrcOXoUskGkG8+EUP0grWjw3N1nSCLmMK
	 8tRBK/n7OaJINa2K5ng3bnaBSTbAAL6SQiVOqAnV1EdeW10ufkHDhq51I4p1HZ/uT7clD
	 odHfeOr2V6kTHH317ElQYOSOZO4rSU95tp/Rxs3uII1fCsVowTs9ItCQ1H96ho53DpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789013451;
	bh=+HI4up9vgfqrVDcEitREIlx21Ut6HCie2+AfCXQoCEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qXY5xh8DUyeJRLpkv7VZJHPN58k+xK/ron7aNcLirStGXqZ/PDiuaOQOBaVLUJOnL
	 nJIqw+w2otMu5D2n8kyKPOXz8nQ5RXARBw4AhqbNKvJfwAvREs53zeSQjcDVds39Xn
	 kQNccSUDqgtZdYif+OKTuzrm2qNnCg5Z1vyexz621SY1YYaKD7vUzQBKC2ZeuCQWq9
	 uSj+eFA2p3uD8/8aVNYOdc6sAYXQJBJine49dNeoiEh1Cc6lc3yr8DfcXlRa1bVTmO
	 iBw2UHUX/FAnJ3pTYtr8ywQI9E2zMnPZUU+HitHp8Ny9Tl0QxLU0RIg5Uezb/seBAr
	 /gRaRr6iAhvfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7EAF80F03;
	Thu, 10 Sep 2026 04:10:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 529123AF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43F0A40852
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:10:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikGy6JpSAPQt for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 04:10:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9F0940850
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789013448;
 b=ZFNkC3S9k1U51H+Cp2r82fE2Zj+etlCqLSjrvsFwulQYtBCifBKVf80r3p1Aq/Ih+zTR
 fsMM4zHequqiXDP9b3uzIbCzGTOajG44SQbQY4JNNIHxAetBgUETMkHGX7uz5zdMPphwj
 DhkVIlHKboFJrl+gvIhRPf39IcQfILYTWQWKMHQpAT2nTHTnUkUK1qaaqn9ijr2HovWie
 izGgnqjB9gJaWXScKa7N/CO0orZt0spHvTcreE5xRqVU5bPPs7xqmhjRSxeb7S6+MAPTu
 dw4KQ29M3rOYiDh1B/qPmi5BE4FAwl/Qskl8p/1xExm2MwAtRmj5/dQHpJh8Oxh6OTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789013448;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+HI4up9vgfqrVDcEitREIlx21Ut6HCie2+AfCXQoCEs=;
 b=CkcP6S1NNuHyFVikq86ILeEnNqNRAbUkiUfNvus+5sf9Tos4RZvErpyxFZTgLYgaskqK
 A7SAToSXnEX1fc8LeEXsYfwiJnT79iOfov51mXg2tZfUQEDMPsF91c+l4SviGgZV4c6mV
 XTQaTwVhfO82/cpIIiZkFc/96ttQWhI+bxDClE2AJ4XIo5iRdGcXDLI47wblb/IO1y7Bs
 IhspT6ZJpQpzzqAZ61KBEBrXKm6ukVD5R38yosVs5DUD6TqVdjkb48VRBAfrArFsXDO+3
 eiAsasAacHcg0D1F06HTYF6Vx8Djaye9PIplsMuNjJ+Y8M5GQ1XNhtK4sRS4J5Kf2qA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NeV2oFUe; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=If9oPfNO; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NeV2oFUe; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=If9oPfNO
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9F0940850
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:10:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A1mKHo3901052
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +HI4up9vgfqrVDcEitREIlx21Ut6HCie2+AfCXQoCEs=; b=NeV2oFUeE3/bOSBT
 iOKPIbwIlEGbTdk8RxFk585sZZCM4qWIO6QfpAhUwATkRfWr/jef/8Vz3aQRUDOw
 lK7bxeeyOxgvnawkRiCNsNRxII+P3fM7aLq+I/1yl/r4lLPcsc6HCwhuKC0OZDrb
 BxjGZ6PzG6n+cenbgoULGkOsIfFefkOz2f/Op0wLqSvDcpK4rfbk6Z3QrlIlSiBs
 Z/VsWNZD0Dqa3557+Ac8YNsnVAHrCY0eZWZHTJIedEqJnSoQEKOz1MDhXuhVHHom
 plgQl7NbSgGKdtJqFluhzDQg8lZUP0sk5gm8Nqmwt2SHZJx24t3NxeCykl3mRet5
 fflYgA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg21hc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:10:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc2229450b4so6567620a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 21:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789013445; x=1789618245;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+HI4up9vgfqrVDcEitREIlx21Ut6HCie2+AfCXQoCEs=;
 b=If9oPfNOXrzqMQiaT8ygQJm4drbQ7gQeA/zq+pJyOzwfqcFFAsLpzf4gqCAiBeXVOv
 qr1Fe1DbpKJyHxqUKFN3OzwLq+SbQ7YTqRKLUDY0YvuXNo8yc65B9TzypuckB09tpSvo
 LdlToq8k2ZIfdPMMaL3XSrv6c3vOcN7+NK0c6buVlphmoPJIvrtxqr+ADQNwkF5dyCkp
 DP8MprhMqZUtI/VBlF7UWhVu0n6mAgORNrJtdfQkZpip/kPGt7WMGGqRLnFj/EzpnOAY
 ICZeVPQd2HHUxYy6djIQhF64k4XCgPbu9LIXvWv5eP862PWRJ38sYJt6ihtgXTJSyyJR
 dtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789013445; x=1789618245;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+HI4up9vgfqrVDcEitREIlx21Ut6HCie2+AfCXQoCEs=;
 b=JiFqKSUm3uYhfHdjtHEpiA3fDKhGdpBr4jU/6NHRbgyiOl4fyJAORByPMr9bRf5lkI
 wybP7opS8lXoUMyOkaw/smWfydZ5Oh9iUtsDu9dBBZ3AxSOHj6792EZDPHerLD3bY88c
 VbPLorO+pLjFw6PSQiBAiQ9guGGD9+A5BM8xqWNh96FjmIczoYOWlk9YYMg9z7bvGLU5
 3HA6W/vVJIXTGzWm9Gjv/tC3bxZwIfR9NO/nfJvJESvyfqgQK6uRjxPdnqQlH6B7FDpo
 c4O0xVZENgGyOniBIMDdDHQTRVtkUtqKFr1thjOIZf5zdHotH51NkfauWhOEfdxxvJjB
 YE+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNnnO0eDZaT8zPDpBH25UGNmpuuOnrH3S/MmXPVhsC9fFCQbMjbmxPd5BA1hHl+YK/G9rxN4Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k+HjiMV4SteehIxrrA9R3l5HTag0I863sts2VckzL8Q517ODRO
 JbcrOmF+DRfmkxdt3QKkaEcCLXB1jivwuYavm4U/83Hn68P7mi27bUwxv5YoQaQh9KHrwM6wgxF
 XNPzojh5gfPn519lQA0uVPrGUiFO29rTREvEAlV0D8XrP/l5e/zo7g2f9iHmmxGBaJn21ZnU=
X-Gm-Gg: AYBFou17j+LfvEpijCfT0Vx/mCmm8hS/f2uxPiofDiCmEHlnDouNECs5xzdfUKLrzkC
 sHBf338qQ8szfwfFGKCnDofvn1yTZBj+pfbUI+jMe2HXeWCDeY/nswjwIPrL7sq7/QMBLoP9hSj
 6YPYB5ho0ydmAQ2BLe6AKFjds8mfGQR/j9R3GOrdlOm8RZIJkmYpUES2WuABsOodFqEUzPc2393
 ZgKjWddMjT0CB9F736FAsk9A4rf3mzm9r2H1rjkeEe1UqE2/gasJFb9GQi9ei6kQ3K/sJI4E1X2
 Pi+MZI4mbstEzqKuvw2LFGcNHwYCxLL0GAl5BepuVfgeAs6PZkiwY73RXzytyHujgPmUE1KAAG7
 UCmcgM2/Ka2C6v0KyHnTZvzSI6VLccK7WpBz5
X-Received: by 2002:a05:6a21:a97:b0:3d9:3626:1326 with SMTP id
 adf61e73a8af0-3da39b57edemr61923848637.2.1789013444855; 
 Wed, 09 Sep 2026 21:10:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:a97:b0:3d9:3626:1326 with SMTP id
 adf61e73a8af0-3da39b57edemr61923780637.2.1789013444366; 
 Wed, 09 Sep 2026 21:10:44 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3397c13dfb1sm11764483eec.2.2026.09.09.21.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 21:10:43 -0700 (PDT)
Message-ID: <2c22d47b-1447-4764-ab91-8b0c141d226c@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 09:40:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: board/qualcomm: Fix kconfig formatting
To: Petr Vorel <petr.vorel@gmail.com>, u-boot-qcom@groups.io
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260909183222.220855-1-petr.vorel@gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260909183222.220855-1-petr.vorel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vu62kO2n c=1 sm=1 tr=0 ts=6aa22dc5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sj0pQU2Et4ueaxFPnKsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Nf6l6NlzIjq4wjfy8vSRSZ6jb-_9iPkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA0MSBTYWx0ZWRfX8aRLd73n4byE
 cvbA6gejv6hvpDYU8hX5lVfchxjMp9AxExoKpw889lofbfdLg5BnV4zWJ0fN2dyHwE3izXuia4W
 T5F2FJ0S3YcpZppOqM0JDRNbRaCzesplgp2zx3j5SfndCwaOgQg2yxWvByvzi/spJDmAVxUY+7C
 cdpBZdldt7wNPTOGGS+nCkDT+SrLhjPZHfzJZ4RLQNJ7IZhSNSLX0GxZB54xG3HSGEp8V1YJhOe
 pBmKYHik+dJNOu5piGRZOqdCQXwhrmtHsq9ckXUKTqAo73C28d+IAv9J+TFEAWSTitbagQ/J15h
 CipFVHcgY54Kzj5m9OHe9kBasnAVpvVMNXiVtEZMjRNx7IuN0CstX/5TQgZBsA/kBwLz0jiFw+b
 tBceJFyiKefPs4Z1/nQO6SyYPqAav9/lAQlCEt+OOxoWN8QRh/clX+YGTrIBeMnCJ+tkc0FIAdV
 LhzTjlkT6HRnwRCMckA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA0MSBTYWx0ZWRfX3wX5y2HUcvda
 /S8ifEM4vWTVk0doTjk8TsgMOXxkHxO/OvlN8xVxMyla5E0WtBWvu6m9YDofOsYauSciDtwgWSo
 xV8cUYeSHcT5qCar2BySuMuwWtf/ZVo=
X-Proofpoint-ORIG-GUID: Nf6l6NlzIjq4wjfy8vSRSZ6jb-_9iPkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100041
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

Hi Petr,

Thanks for correcting this.

On 9/10/2026 12:02 AM, Petr Vorel wrote:
> Fixes: d9252fcde12 ("doc: board/qualcomm: document generic targets")
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   doc/board/qualcomm/debugging.rst | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
> index 42821f6546c..fb6b0d397e4 100644
> --- a/doc/board/qualcomm/debugging.rst
> +++ b/doc/board/qualcomm/debugging.rst
> @@ -18,6 +18,8 @@ Newer boards (SDM845 and newer, those with GENI SE UART)
>   
>   Open ``configs/qcom_defconfig`` and add the following snippet to the bottom:
>   
> +.. code-block:: kconfig
> +
>   	CONFIG_BAUDRATE=115200
>   
>   	# Uncomment to enable UART pre-relocation
> @@ -42,6 +44,8 @@ Older boards (db410c and db820c)
>   
>   Open ``configs/dragonboard<BOARD>_defconfig``
>   
> +.. code-block:: kconfig
> +
>   	CONFIG_DEBUG_UART=y
>   	CONFIG_DEBUG_UART_ANNOUNCE=y
>   	# db410c - 0x78b0000
> @@ -56,4 +60,3 @@ Open ``configs/dragonboard<BOARD>_defconfig``
>   	CONFIG_LOG_MAX_LEVEL=9
>   	CONFIG_LOG_DEFAULT_LEVEL=9
>   	CONFIG_LOGLEVEL=9
> -
