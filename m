Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C73C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B40A580DCE;
	Tue, 15 Sep 2026 12:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FjOyVtJRMNkh; Tue, 15 Sep 2026 12:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B830A80D81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789475069;
	b=SUqDZHA7S5NdtqV2MzKui/YX39gWL9VbzU3okHpnKt7ZPVVHmV72kPN0/RVFc6c6UCyr
	 jSdFGR02WVJ9SJAVf8TW6DJDVKCawpue7WRAw7oo9vWx1aC+JutclfHjcQgDyrAHo1LzV
	 zs8zYeM9hjN36qkwdxYssF5dY/B1yJ30mnonqLZ7qLYcMn7zrp5LZO9/jozLe6pVLpbdS
	 1MCY4o/X7RxwicVQzy+mGCpFod142DI9IXK1j1rlQmnpbSCaTId1PbVkp+jt4VtGsjcGB
	 Fdh10gmzgJ6H21kao2kjHhFH8ZndrXQxm4gJnV+56tfVvp2bwNCgpiWCPoC5z+xN6dQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789475069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E89aARzI7epos83QPRc7PRmnzsBNfcGmh2DPcha9dW8=;
	b=aY67P7LA9fit55Rany1eyrbM317oWSC45gXcTv7I2fbtfbysYAs9wPs2vWg250TTCoxQ
	 sNeaGPKt7OxhrHtM+REDiDB0vM/OxSgqG5bxJgAS82HrhJklyq4MbZwo38Lefov7cB6oi
	 qbCh1Dzir/d2/RTB0EA6aGsBrZXE5ZahCYeN1rTk8aHYR1ySHyQTdUADvhkpi6lemO0Eo
	 1Ub4jUskxXrXKNFz7oYsqDDllrHigfc6YZvfHOQt+sOQd9VG3ZrVNseC9iyj+0kK3s+qB
	 6tqA/iCQIjWg0jGGd/2g9ygl0WYQBZSADX7VMnZW420uAn9sAIp9kTfJOleILN1+CGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789475069;
	bh=E89aARzI7epos83QPRc7PRmnzsBNfcGmh2DPcha9dW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rXRGz4QmbtuYAHrxI5Jv9rHIvmuskcMVp/iq2o2X//QWJvXiT0JfJXSCg7pQiS3pb
	 wA4FeEWbYEJunOhdKq3gYDuAXWQZr/Tbcmw+L3l1BoAl8wy5iIu3lVAhNa5S0GOkv8
	 0W4yqcpgyXlbcKEYG9iv65hqxNy65XYsnAybu3//O95uQ2zJj5U7kSTcMQ1S6Vmm6S
	 FZ9qZsON2k+l8U+ZWvyjPD/Wh2md3frt0jurU83ILA4equdJy78hwBLJK490jI/B5Q
	 2MCWL/bIJNOoDQd+o0DUsOruvv4Mz2vBGta1BC1pFy9Xv+RacsVHo4rNFoOLI0ib1r
	 Vuuk4WDZzItZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B830A80D81;
	Tue, 15 Sep 2026 12:24:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49DE1224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F8DC40564
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:24:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmOtB_hNrbJ8 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 14D0A405A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789475068;
 b=UcYfi7HSmjrN3YPoawFGcyySJXQ5POvBnmYFwfTn6usi6tQwzJTvkvrCI/HjmfZaQLyg
 OgKchj/nMCl9XCLwiAN2lNRKNGScaxowtPHD25NaEeA5r6Igw6aXsyw0ECwz9rLmbgbvT
 OIXcHifgsjglKd/UoPi5dZ3kiazuYhtramhSCzQUdC8uGFvSadg5B9m9aO/8atW4x1P2O
 X+E/DSr83DK6FpFeahlz7Fw6647Lhw/kz4WP2cMjiYiRPCjbO6THadrp/P0gYXT6ba6Ek
 ZyuqyIiceLRMxmQdSVrHWKIdPpBDAOab218DEfG+gefq0uh4U0h11ffscyVURSBft/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789475068;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=E89aARzI7epos83QPRc7PRmnzsBNfcGmh2DPcha9dW8=;
 b=JupRtZD7RjkIDMKV55Bz/WsfyXjbXTKA89lqBYGrMuDAyrX0xjITM+kP+NpWKC0VtyyK
 s9UzgMZzl315ABXRvm8iT9qxMWP4KtWEQoOxD9hdbUzhAE7TA0IfyMN+4wIMqSRDKrD59
 J+6P6JR0oKkUdlT2Hk/R86nZJBaLUowx/D/NY/OhvGO0jaxsDnG/DkNs6AE32eg35Yxun
 zbgetzB+CfeIQGXVdsOfIFOC6adIW6gGV7ZUHszi/VPFE6fL7RQqC5zWAFPCumJtX2L5z
 a2GkXEzPkaj8G8u83LVxIuKKuw5eBwinmqliC6b6igiwb//ebYagZiziQY3hP3Orriw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=b8Gj4mtr; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=F6yEeV2h; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=b8Gj4mtr; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=F6yEeV2h
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14D0A405A7
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:24:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9h6tg3217508
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E89aARzI7epos83QPRc7PRmnzsBNfcGmh2DPcha9dW8=; b=b8Gj4mtrjEo+rKwu
 Cw+iTXTQCPAAP+fRmK9O6d0blsEqsHkTUHU7WOis6Y7WpNIo1L3YeQHWJC4TiaY9
 0bQpICISIgwM5tYO5YKl+CcpbiOui7OLbdMaUFMIjjiy1xIox8DWZth6w/ghevGN
 oqJx5meMEfzrI7ZOSLKfi9DrqR8etHHEIqb2Jw12eTuwis8X6Yxrpo0WsuOn9MrG
 AHEgQAsSTbTuSp05+cgRtAfLUO92iDR5yNYSqxrJ7437ZsPqdQiw8YDR+ga0RFho
 WBHUFHFOgwmuVWvccl051nehKEwRftVYXwtgX5gtChlDp4Kv6yivSvahYsS7GVru
 zaL+/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2gunk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:24:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so10922453a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789475065; x=1790079865;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E89aARzI7epos83QPRc7PRmnzsBNfcGmh2DPcha9dW8=;
 b=F6yEeV2hmHBMredZlVLDL/W/rf1lDV4iw+qWjnFc9tz/HYVliEXNjadlYbLqtY8dZi
 ZTcV0BVg3AaekQNRZ3Hnbh21xiz4AyFIUTTVWHZPfelcYv+WhtCcwOi4ceL4RexNMUUQ
 DHfrfE30RDWMmbScdgizIZ+pmS/hP7/Yydp1zllNz3lARWexDObSNhzUH9/z75UzjznI
 mNTD/r3cBDR81pWsmjn4Lz+wzjU4eRApy2/b7T29jj2+hzIl8ODNS2J+TDnhUNI9DaXO
 VLY1kyWG0kkGd3G6vxV+mx6SLV6XM5PVmqwU4XYng6c1elSEfBvtp3DuOTkmIUEJmm6K
 Pq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789475065; x=1790079865;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E89aARzI7epos83QPRc7PRmnzsBNfcGmh2DPcha9dW8=;
 b=WgEmwsWGuWUaFAFuQHPFzVfAW0vEBWF5I3+/z7lnSw0KvA0WbM7Cytf/NST9vXc5aY
 4/JRB/b4H9HrFzdwwAfjCW5zL3G7y97Sbw7EnPFN2qnkZgfJqNRmYeVQde5ZQ+438+tY
 18HeJI870Jh1o/UaoQlWZlYj+U2Bboeoj9gzboFOHL1pZX9Ec8Odyn13e+w3dD4t46Sk
 Ej3P/322iRm3jIck/4l0B1IueXd00WdtPogAhucnX0z0YBPaD19UdomkSnZZ12GfSMWv
 dmheOhBQBY0+fJa2tepPHiwU8t+/p8xG0bKQkA/srmFyegRF1Z9QxzwV8/b0NDLXts9a
 hpIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjkGF832GhxwCspXw5uB8hd4zJ7IIw57Sp1r0TgpOSf+VL1glvqOelidXRMsoUFF9DpINcNUw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lyJ89XlG0gcl6adPrvTckhh5A0jqUysXMyDkS+AvFwr5gsDfl3
 mROE75rDZH9Th696UPiWN7panCWB3EuZN6s1PsyfE2Fj/Ztg3puuxZKGExziVTU+RXlPNvkk3ek
 Cdss0sORA6EmEMWoos1RXPOwnAT/OufgSaZifW9QcWUUQDQrux9ZdzJlcslvd7S14rGiaYfZVCH
 hWB3Q=
X-Gm-Gg: AYBFou1KUMA5gGgav0zr+4RspxNAXfVdLI++xVkwleQY0vjYTa3WKU79M+F/ttS+P4m
 XRGec5XbVohr9NEESWtRu/jZtl2o+HEhh780uafbCvsMpOsCBY5y1nZslpoYbhcy3j1NiZJXWjU
 UJ8OxYXJR25RNQRqlnxa8RHr5gwMs9sohUn0Uw8V0m7rhPP1lVkx5Msi0SAFPI0iYAcXMcZqqUC
 sUuqofurKGVk8qFwk2SOa5Hi9akN5hgoiRQIZsmRAnQpmObAk0TgYkn3NQX5JoZ19YFCvo5EmXh
 VhvT+5L2EOHJm0kKo3zcw5eUfwT606dNyQpjtLatFv58OQ8D6DmGxKBNbbzaEZIJ7srqdwkN0a1
 dmGJ+JX0ya5EeghCR9SCHfbsBEPUXmEH1btiLcsE=
X-Received: by 2002:a17:90b:2e4b:b0:39e:d2a:e2dc with SMTP id
 98e67ed59e1d1-39e1104906bmr1236183a91.12.1789475065195; 
 Tue, 15 Sep 2026 05:24:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2e4b:b0:39e:d2a:e2dc with SMTP id
 98e67ed59e1d1-39e1104906bmr1236100a91.12.1789475064526; 
 Tue, 15 Sep 2026 05:24:24 -0700 (PDT)
Received: from [192.168.29.107] ([49.47.242.47])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm35142090eec.31.2026.09.15.05.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 05:24:23 -0700 (PDT)
Message-ID: <baf0f0b0-ef54-435c-9603-39dffae10f51@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 17:54:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: qcom: Add an option to poll for GDSCR
 GDSC_POWER_ON bit
To: Reza Kurniawan <imkyufie@gmail.com>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260912072619.244101-2-imkyufie@gmail.com>
 <20260912072619.244101-5-imkyufie@gmail.com>
 <461c7cb9-0e21-464a-9d11-72239ead6e93@minlexx.ru>
 <CAAq9HC4tA2CvgQxgT4fDKA7AJP-8vzOi_bOdBS31JpHcJSeDig@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAAq9HC4tA2CvgQxgT4fDKA7AJP-8vzOi_bOdBS31JpHcJSeDig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _jwm1C7B91SG6DtpfCSewVx_NfhIF7u6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4MCBTYWx0ZWRfX1ZaGFuSGwjT/
 0+QOyhSYRH3sppwDR0UpQGbuMgl18HkdrUWNYG4bWWmzXM+KkzyMOsH7+6RsBYT5ecda1h6v1L8
 vIL/H4jT22OgsSgOktnKPji9TekDKWVAPP+KY/wuMu2CHR057ADx0W3ihTD7GQNEaAOU2nog5IH
 6N+vMMPRXCfUnOF3KBh/I8yq5g/KVY7VJI186FdS3EDKqP9noajJJ76ktSQdeYYw1M8FxM3s2sN
 3jAMzIIWjsfH5RikYMKnamFZ3EISmfKfaFXWhZh5Lx7y5yxFtaZ5IYUpTH3AZJ878F0Kj2qb5L/
 lau/o0ddYr629HTQCZDiOrSQSi9LqL/7eRnZiswaWwEwa9TUsMwVAgMVujcWfipGMzKGKXJUKDw
 DXxzOhh/LXBpO6OPhqHueT8PMznuKeFJbMAyFQAz1t3P7XeglzLF6Ioz8n/aJ93SLLAgLGmEaQx
 LlbExYNWKjDZVmjXF7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4MCBTYWx0ZWRfX4NOdPcw5VLt9
 M+KNVNVJ7KOlknt5vvr8KWGXXDyADK31idsOz5vPZbeZ21vPxRJ6PhUNGn0EnohXIdR3SOQYBeN
 ohKBn4dhXqR1cpqg0l5OZocGEc8cF14=
X-Proofpoint-GUID: _jwm1C7B91SG6DtpfCSewVx_NfhIF7u6
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa938fa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=5Nx5MsSwb4TrFb0eIr6Pyw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=ZEkBDfZtAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=klX1Xq4RppceMZGoYkcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=Soq9LBFxuPC4vsCAQt-j:22 a=IqjDwHP2KxQYjTbYCZGP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150180
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

On 9/15/2026 4:50 PM, Reza Kurniawan wrote:
> Hi,
>
> I didn't know about the submission when I was making this, apologies.
>
> Yes, you're right, it is doing the same thing as your patch.
> I also wish it could be applied first, then I could put mine on top of it.
> It seems like a more elegant solution compared to my own.

Or you can send your patches on top of Alexey's and say in your cover 
letter that your series depends on 
https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com/. 
I think that should also be fine.

Regards,

Balaji

>
> --
> Regards,
> Reza Kurniawan
>
>
>
> On Tue, Sep 15, 2026 at 4:45 PM Alexey Minnekhanov <alexeymin@minlexx.ru> wrote:
>> On 12.09.2026 10:23, Reza Kurniawan via groups.io wrote:
>>> Some SoCs such as MSM8917 poll its GDSC power domains by reading GDSCR
>>> directly, as opposed to GDSCR + CFG_GDSCR_OFFSET.
>>> Add a poll_gdscr flag to struct qcom_power_map to facilitate those SoCs.
>>>
>>> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
>>> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>    drivers/clk/qcom/clock-qcom.c | 24 +++++++++++++-----------
>>>    drivers/clk/qcom/clock-qcom.h |  1 +
>>>    2 files changed, 14 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
>>> index 6b46d9db7..754ff4ff4 100644
>>> --- a/drivers/clk/qcom/clock-qcom.c
>>> +++ b/drivers/clk/qcom/clock-qcom.c
>>> @@ -505,9 +505,9 @@ U_BOOT_DRIVER(qcom_reset) = {
>>>    static int qcom_power_set(struct power_domain *pwr, bool on)
>>>    {
>>>        struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
>>> -     void __iomem *base = dev_get_priv(pwr->dev);
>>> +     void __iomem *base = dev_get_priv(pwr->dev), *poll_addr;
>>>        const struct qcom_power_map *map;
>>> -     u32 value;
>>> +     u32 value, mask;
>>>        int ret;
>>>
>>>        if (pwr->id >= data->num_power_domains)
>>> @@ -527,19 +527,21 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
>>>
>>>        writel(value, base + map->reg);
>>>
>>> -     if (on)
>>> -             ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
>>> +     poll_addr = base + map->reg;
>>> +     if (map->poll_gdscr) {
>>> +             /* Some SOCs such as MSM8917 poll at GDSCR */
>>> +             ret = readl_poll_timeout(poll_addr,
>>>                                         value,
>>> -                                      (value & GDSC_POWER_UP_COMPLETE) ||
>>> -                                      (value & GDSC_PWR_ON_MASK),
>>> +                                      (!!(value & GDSC_PWR_ON_MASK) == on),
>>>                                         GDSC_STATUS_POLL_TIMEOUT_US);
>>> -
>>> -     else
>>> -             ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
>>> +     } else {
>>> +             mask = on ? GDSC_POWER_UP_COMPLETE : GDSC_POWER_DOWN_COMPLETE;
>>> +             ret = readl_poll_timeout(poll_addr + CFG_GDSCR_OFFSET,
>>>                                         value,
>>> -                                      (value & GDSC_POWER_DOWN_COMPLETE) ||
>>> -                                      !(value & GDSC_PWR_ON_MASK),
>>> +                                      (value & mask) ||
>>> +                                      !!(value & GDSC_PWR_ON_MASK) == on,
>>>                                         GDSC_STATUS_POLL_TIMEOUT_US);
>>> +     }
>>>
>>>        if (ret == -ETIMEDOUT)
>>>                printf("WARNING: GDSC %lu is stuck during power on/off\n",
>>> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
>>> index 3a4550d85..0b514cc1f 100644
>>> --- a/drivers/clk/qcom/clock-qcom.h
>>> +++ b/drivers/clk/qcom/clock-qcom.h
>>> @@ -76,6 +76,7 @@ struct qcom_reset_map {
>>>
>>>    struct qcom_power_map {
>>>        unsigned int reg;
>>> +     bool poll_gdscr;
>>>    };
>>>
>>>    struct clk;
>> Hi,
>>
>> It's doing the same as the patch that was already posted, right? [1]
>>
>> Sadly it got no reviews, which kind of demotivates any further
>> contributions to u-boot/qcom.
>>
>> [1]
>> https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com/
>>
>> --
>> Regards,
>> Alexey Minnekhanov
