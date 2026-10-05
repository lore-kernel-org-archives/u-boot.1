Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D6FCA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADC6C406A8;
	Mon,  5 Oct 2026 07:01:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upRjr2mQ8V4y; Mon,  5 Oct 2026 07:01:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 38D5540699
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183672;
	b=H13Vm7+bM8s+PqrWYNJ2uHQzDpVlWtjMBQc7XA+rvtMqXsfxtoUALt/Ej4rDUUHodiOf
	 4FicJdZtee0VvZPPQqzW5w8CZamLj6ixYB9GyGAf5b15dKDhfNzyBQQrJDxqGfWb236S0
	 TaAGnKqtNcBbOFSZ1otmEBXfeAHLP032xPOu83HizhiGXhf1G3pTBA70KkhC//QEJYKbj
	 y2oE6wucLwzchJsJeu5tvoEP9d2boD+TMFN/4HEMufM77frfS+VkVdhzdy0V1eeH1jzTl
	 M3vwKEb9LYkNVtNuEnZDxdB1lbrmX+hmocLJmwHfIzV5U8ZsVvxvCEq4+xQB56zX1eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
	b=jaUAVoKNZuRHH7OtxrfA3tDBfnCWrngPIi8QRJo5erEZrKhlN7C9ldUzmK+DhAF43KOt
	 SL+JISm69Lp/5nUwejGCmb41YXykyfI0vwWnNZn1+WalRJH0KwdRylXJxIumJUKuQNemi
	 ldTEvvIqpnvCUPLPGD1y1WI9CvrD6m/lgkRgJ8FDLLpqHXLnI1yZmwWcXfw/F0vU2uPUV
	 /jcpLbX/GyKNICmuzTssMt3vEjbjFk6nVrUHe6xc2giJxmS7m67gSqw3JIGuAbKXdH4Pg
	 ekUXh321MjhhxFd9kizy6iMGkLtnUvFTViTVau1V8YrBjTbsCLnd0WBJ02WbrMMeHqA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183672;
	bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TwFVxwalOIgVKZ/d0gYBwzLSMIxlYcMk3ZufiKQKtg/yRPbFcyBQQgBxflAvY0f9p
	 70FMPEk/+DlCfbJ1mtqcwBjJfY5d3tDXMHMqpVlINUssctjs1LnVbFv3xpXuEKfVRK
	 kAyrE5FfJPHLeQmq+g4B1FAfvQbCaWQSmg94Q9uYqHWs9jqvwn4nzH/GIPRBJCwC9B
	 tZlAI2XTN/tEQRRO/k67iFsdh5B0upsUA9ETrNUppg5cQpC+ulyNGMwW3qlXcYRcYi
	 YRC9YLbg6F87xvBitZo3zOYNFBofdTf9AqF2W5daf0FEIRqoWG9HEIVJEhT0uRQYPA
	 fRhCh7n0T2fRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38D5540699;
	Mon,  5 Oct 2026 07:01:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B5F975
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D07460606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uTMm-AjFgugU for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:00:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ACCAA605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183621;
 b=UHLnEJQh0vwxeiFqFkcw3buzVDKpEhJyYyLFSomWrOCMbD7YdXGd4E2+stLY9fOmJV+p
 /Ib1VIwPj8yCPhGtEr/gfPpr8+7p8CN/v14WSGXJ8dM2JjjFKux0LzODRN3TK1HXnpNAG
 ePIfXZeKSGKxangKn0EzCENSZKL2QbCV68H3kVVURH4ZtnyE7AP/+FMW+PuOKG3VPJfUf
 BFC89P6BG4u22XNVudfkv87aN667N/Ml7zfGVEfE0zK8YLGa22crXVeBXR1ErfZqHOP1b
 qtuwKGvVvb2SjnA1FsIJl72H95tSsOmb0PdB1KiII8a5vNsNb67K5oq4BwMYNEhUdDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183621;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=HHK7NdSEnlDywlS+FYIJlK5yxJ0sQ8GEEKUtMCPGi1HFdRvgSadbF3oupE/SngU9R+P/
 5+Zt7XGA+f7QHuw7fd5w5mfzmwis07Sf4uYPwle4Kbzo+i8srTVM1tnsyL/K4sv7cZP/+
 fabGWLx2jF15rBMcmo7hqt5bbdwCFJ0vkvilP5Kt6SWhruCxn0r8E2nA5tEU07jn1uBTe
 zXp9kK/d0tTs0V5R8ew3UsC+Kox8yy1qt6Ro6kgiSWDi3rkv3Ghf6OCe2zKIKRIbV8O99
 6g1bqDdsKa456VKZ/TBDjgsM3eIM8vNlqgBOlIfZ1Bx0zlQQKC2ht/kmArzrtosO/cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=W4EUT5Ox; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="M/Ekn5kL"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=W4EUT5Ox; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=M/Ekn5kL
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACCAA605F3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:21 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695105ga3242494
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=; b=W4EUT5Oxhh9FPg+r
 6jGeE6F02WeEEVbV3A1kcyq1A4shVQLTsCZKqTMq/8gm4IfrkEFZ2sFAwqvEu2m9
 8+Ib8aFN8afHbEC04bh/Gdyq2hTM1cpCtFiTmj5+zGYaGYhA8lcUfQFXPAxwF6IZ
 xK8wezxWt1xXWJkNSHY9C4XohNwhiF5/0TghNEL1YIG0vLeEabI+IEAuIh2oZXE3
 IG+01SzrHn7IL1QnmZbPxBpR8RavCYGx7gdeo6bs6bqeOJ6BunGahiynuLwF9bXX
 VoY9xNo3VC3JqprejqT5qWu08lCJ7vpECawD9xc+lJmSzvTgSdPGxoeXgvvKtIK8
 LrBicQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvevnuy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:00:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3425098ae4bso824699eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183620; x=1791788420;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=M/Ekn5kLX3i1AW2y9xrmmO2lqbE8cE4jzTJP7d89U/2wTlTMa/wylPLSuafGLy7qpx
 gxdnHPP2OeW48OIdB1GaVI0QHo2jo0fAWBh6HZkNE/FKKWeM876tSP79NELwUidfK8+p
 b7hyW+Ck8Prw6foyNhJrMI9cqSm5TBhScdFpGJSxpwmG7l+j5E3WRZsZkEF74gtfJ+H9
 uICq0s+0K9oOF6lxSZ5gQmbVAWdpXvsL2X4beDzBEm541Sm6th2EMecbHSzSDJ4diib9
 iUWNHzWKRiipCOhTIyRyQTyj0T9BERFkmBnIV/lPPl5t2coBdpjZQ/ZaT3A6jKLdUdI3
 60tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183620; x=1791788420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D5tP+DOcXPVXRVA1cr4Ipawd8AyhFUkjQgo7calCeNg=;
 b=Bq8KbADzZpHP2TyhfKfp+JtWLb01AmQRDFds8G0V26JEtZoa5ui5ZViwwm5hVXyj7t
 G+9s4ySHkp5eyCmk8VWlKxsYrtNdMhJestg0AfDhqJMBmgoVlOqHChW2UFBJvQjQPkpc
 ZLFnJX2TqndOiWXBonKhhwYvzf8NMic4W16nOqW2xtNwuvbqPt/sW3MR/pw6M0uLukrT
 lRlF+STrTnwzeHOjKEyjfzF0ytyF+F/oyMRZWbdWPljG1kfKV3tpsRXevXscwWQ3xcNg
 ONVViGcPwvlxCZdGQZUhFdwwAc0lbkNe6KIxL2Y835QxJNEsxlUnYpTsBm117QyCXlPh
 wTkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGQd8pZA9fSohLqXSnNeUSYfAku9Pw77r6Xgmn7SD7KhPBc/z2kX3VfTHBF1RokhhI6zm0sVs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ncUdMIxWhRWjWZ+dttY0tJiXSrBgYWknJdqNIRNOvBYtdwQ+AU
 pbwBqMHB/L82A8RtVbTXCJEaj/0c9p+XwdEm3Xsujb/MOcb5+D3FcT3xJ4o3EjilT7KmqVZdLDC
 6gKjKfQ3S/PApiLTJpZllxfYz9e5IRA0LQspDHg/9CQYaZrpHP1vBzNTUbqkhh1S9rg/ZJZOPjp
 mY1fM=
X-Gm-Gg: AYBFou2Ii7iuiQn60/Ro7Wi+EaEypr8k+4/VIq02jBmKKPIly7xekanqWIOzw4/Y4m1
 064/1wZIWsYiHmSiXK8W7VUoZbuuxhWa8vh0BJkIL4p32K5qshuDHBZanaCW/Pp6Xa7oN/XBiEh
 zWCSWRO7I97yjmWqQFlAYQILkNsuTo1noXkqAd4m8V/Jy2I3wuOhhWjUBfvH11b3B5Hcowauwjc
 fFIGuqjJbHC9N7qgv43EYFn+gOp+Uobr2tfqi+Il3RDjmCalXM6olivSUdFK51P+/rkTyCselKZ
 zcPIgR0/Qpn8DuKOHNwYxs0Ua9pYbC9Fzh53NoWsixQ+EJZuJyd6++9gYoMn5aCQpfECNu5ssnb
 L3g5LVv22RjSUTwgJ678bpiX2VZk+lp440bf+93z3GxkX9hsxY7T41tiZi6XKj4cuImmEw+SYWy
 z7gbwqCCVtC0+spKdmqbbLMr6fGVKy
X-Received: by 2002:a05:7022:4386:b0:152:97a1:dd36 with SMTP id
 a92af1059eb24-15297a1ddc9mr12013326c88.10.1791183617746; 
 Mon, 05 Oct 2026 00:00:17 -0700 (PDT)
X-Received: by 2002:a05:7022:4386:b0:152:97a1:dd36 with SMTP id
 a92af1059eb24-15297a1ddc9mr12013133c88.10.1791183615608; 
 Mon, 05 Oct 2026 00:00:15 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fca985c6sm27963498c88.10.2026.10.05.00.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:00:15 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:29:56 +0530
Subject: [PATCH RESEND v3 3/4] tools: qcom: mkmbn: Add support for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-ipq5210-v3-3-e0ec14fb5796@oss.qualcomm.com>
References: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
In-Reply-To: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 75p5V8a0WdjpdTZxqv7UKmvKH66lr8XM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX+My85kNIYpev
 HDC7YXnFCsM2WrWUY7P0MDTXxRzlv8wkY3g4qeMy54M4ebYrK8P1IaA+2yt7UhwodKOseiDEWc1
 c9JkxZ4u6aW+7CRVGgh+ahN8ycvLmsQ=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac34b04 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yH3UP6-NtsxmdlPH3hAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX1Vbbs/sZxx+j
 h7IKKCPYdNk34OUw4NcbUahI829cokQJ64EeLEbwkH6RftrJ8BdYOEkY0HeUU8TwmZP1T2R3a+g
 fLEQqsuboA8iGlZeKq7jjsfKihif3pobX6MBUd18swUCr/Y9c2Y8NXvtJW5Zq/bYwEJWIZqyKAR
 kDeJqnexjNCGaungFoXeAo+w6iC5ynlVEAmPIHGnlelzdFQYY0BJqKC3q6Il07TTsyI3IG5Em8m
 dBkbV+G9Xe3fU8yRpgOpFNzxkO7qpMHN/9kLkDOL7QZCK68VoPN2GbGcb7ohWgE/2rX5DooIU7R
 AC95JwCwNBxJH8K3nZbvaU8bdvkuTopZP0zdCJCU+2FicB6K6oaTk3dVIx+Ua81H/Nc4XFVXo2U
 GivPY2wu5ecekbLnA3hkiVHBKZQ2MyeHYXE3LcFPvoQzHW6vBWVLVlpLDKInbPynCuvUNDUMpil
 xn3sSCAvFpFFWnEQoFA==
X-Proofpoint-GUID: 75p5V8a0WdjpdTZxqv7UKmvKH66lr8XM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

- Add ipq5210 entry to the 'boards' table
- Add an argument to specify the U-Boot Proper/SPL load address and
  drop it from MbnData
- ipq5210's boot rom expects the SPL image size to be 4-byte aligned.
  Enable the mkmbn script to pad the image to 4K.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 board/qualcomm/config.mk  |  2 +-
 tools/qcom/mkmbn/mkmbn.py | 63 ++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..dd61ffd98e8 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,7 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 8d2078acc30..da4d45b600a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -18,6 +18,8 @@ import sys
 from enum import Enum
 import struct
 
+MBN_ALIGN_SIZE = 4096
+
 verbose = False
 
 def log(*args, **kwargs):
@@ -56,42 +58,40 @@ class SwId(Enum):
 class MbnData:
 
     # sw_id 0x9 is aboot/uefi, the most common
-    def __init__(self, loadaddr: int, version: int, sw_id: SwId = SwId.aboot):
-        self.loadaddr = loadaddr
+    def __init__(self, version: int, sw_id: SwId = SwId.aboot):
         self.version = version
         self.sw_id = sw_id
 
 
 """
-This dictionary is used to map a board or platform to the appropriate load address and
-other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
-data should be filled out here. The load address can typically be determined by looking
-at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
-for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
-at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
+This dictionary is used to map a board or platform to the appropriate MBN
+metadata. When adding support for a new platform to U-Boot, the appropriate data
+should be filled out here. Looking at similar platforms in the table below may
+help.
 """
 boards: dict[bytes, MbnData] = {
     # Exact matches for boards, these are preferred
-    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
-    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,qcs6490-rb3gen2\0": MbnData(6, SwId.uefi),
+    b"qcom,qcs9100-ride-r3\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
-    b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
-    b"qcom,qcs9100\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
-    b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
-    b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
-    b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,qcm6490\0": MbnData(6, SwId.uefi),  # rb3gen2, rubikpi3
+    b"qcom,qcs9100\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8550\0": MbnData(7, SwId.uefi),  # C8550
+    b"qcom,sm8650\0": MbnData(7, SwId.uefi),  # SM8650
+    b"qcom,qcs615\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5210\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(7, SwId.aboot),
+    b"qcom,ipq9574\0": MbnData(6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-    b"qcom,apq8016\0": MbnData(0x8f600000, 3, SwId.aboot),
-    b"qcom,msm8916\0": MbnData(0x8f600000, 3, SwId.aboot),
+    b"qcom,apq8016\0": MbnData(3, SwId.aboot),
+    b"qcom,msm8916\0": MbnData(3, SwId.aboot),
 }
 
 parser = argparse.ArgumentParser(
@@ -100,6 +100,9 @@ parser = argparse.ArgumentParser(
 """
 )
 parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -149,10 +152,18 @@ if not mbn:
     args.output.unlink(missing_ok=True)
     exit(1)
 
-log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
+if args.load == 0:
+    error(
+        "Cannot proceed without load address.\n"
+        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+    exit(1)
 
-elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
-elf.ehdr.e_entry = mbn.loadaddr
+log(f"Detected board {match.decode('UTF-8')} with load address {args.load:#x}")
+
+data += b'\x00' * (-len(data) % MBN_ALIGN_SIZE)
+
+elf.phdrs.append(Phdr.from_bin(data, args.load))
+elf.ehdr.e_entry = args.load
 elf.update()
 
 # QLI boards use v6 sw_id is "aboot"

-- 
2.34.1

