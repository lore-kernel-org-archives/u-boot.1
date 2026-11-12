Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B25606A327
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o/eHqEp+;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LbWia+nm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jf+J5skN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE96B608D9;
	Thu, 12 Nov 2026 06:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a09a-3eFawqK; Thu, 12 Nov 2026 06:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D4B70608E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794466393;
	b=VQJhkXFswI4XTnWsX5AZXL1c1wPKYBfjSgUananghpphJmsiUJiUFHX/ER47v3vNAJsM
	 XcVGz24XJWK3IEnrthOkk9HTmWMy7AnolIx1k9Xf+PySMZDXQc4lvT+lb8GCQm6sjBXQ2
	 4RvAh/4QEOqaxwlX7YEyQgh3rbW1ruTKnqjKQy4wmDf5cmr95rFYSqzuVGrV9eIRJbrIe
	 3BZbrzUupZXaqnVLzhVQZPyUCMfdlhjDlpBlmayno5UuZ17ArndTvXDxuHFdcZ01EcFl5
	 tN6IjROvsMtFqvYjBqJDmwMOELljUf6v65OmnsTz53O3mtYjUpofYnNIpS0ul/Ikg6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794466393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zha2JGsDEwcVNhKMH5tSUdIx/E1Ecpnf+D2qUfTcSIE=;
	b=ZZl/snPwmcKb3FmvsgJOLErqQ+HUpCMpw5RJ/VRTrgQFv2YznpEdfA7a89e2ClEQZ9mB
	 kattoOigyOfxAb8+krfKxXPu5nG8o42nIRuRM2pmC1BfP+qyEkn1GCw07fXA2YrFjKJjS
	 woWJ1RMJBrN9j+Vf5FKDMWPtukWfkE7TNhlxTfc17qcx5zCwGOY6vnWRCKzUYBKML6dSw
	 USQBQ8I5fP92glNOTW+6Um5HAPUoVnL2PYz47zYBiuQFzYixwXzjMyOS56vVJOkR9zotg
	 Z7Knpmqs5OyWxkL/CWy6aqN4WzQ2w3At80Wge8hfAZPn8VAG/D3k3sLKOPPaBcN1W+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794466393;
	bh=zha2JGsDEwcVNhKMH5tSUdIx/E1Ecpnf+D2qUfTcSIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o/eHqEp+tu/AEM76KyMDBAjjZ1fZ/0uKC5NQuwywI4TjXR0ny7Ta08OFa6Fkhxc7f
	 ApsG2jyNgPrY7tip9wSvoBajvc6JxdkWsnnApDpvIVyGo1g3wqn0RbALRZRjTA69jT
	 OYNFN67T8ibtYdmmFvF4OHy9kUx7jr0zZDOKvjlJYa7Q3ovBzGmi0gwnJnWQZJ/0mg
	 muWZnu154no0GWw9qePtPOer23X9TRWQQanmbLKplhAdLFBsmONxmVv93PMIDlfjM7
	 b5NIXbWMbMRhrWUmGfrxPsCgSxzw7peZcNS/+OtyTNsiuq6aYPRSagduJX9Zw7ofFb
	 F26qpfVmluMYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4B70608E7;
	Thu, 12 Nov 2026 06:53:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F91F1399
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8135D400FC
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:53:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ZhHE7pZMawj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:53:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4130B400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LbWia+nm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jf+J5skN
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4130B400F3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:53:09 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC4lut83893075
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zha2JGsDEwcVNhKMH5tSUdIx/E1Ecpnf+D2qUfTcSIE=; b=LbWia+nm90tU/sVs
 DlS0vUk7PdOw0rb3oFaBu3oqeUylAk3J+nblRpzQrSpn7jHYyKX9MvXrEgxMBtpS
 j5CirOgRGEFj0QJhJdxcZuhRFSvInCtML4SeWwq+MUhhoku4Q/LN7KogB/IzqMzK
 9hC5WZgj0T7Ff7QLSYfOWlj0M9GECGV0gF3sb+IM0jjgXZjqy1OvUXu7cSQ8c3jj
 x8sTLso2OzBZ/ots1GzS9g0Ljy3FsSiu2P1BtZTQCuVR8qfTi3vGBy8YxwsxETty
 /xqA86Ni+0pf+RICII1IElsS7daAPQdNHUdC45DO3EZCKd21iDTs9gousl1CjMJq
 pdhkzQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re0cgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:53:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36efb506f29so144685eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794466388; x=1795071188;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zha2JGsDEwcVNhKMH5tSUdIx/E1Ecpnf+D2qUfTcSIE=;
 b=jf+J5skNliBGWE4PU6PggcCdSgHEL2z59Zcz4pfY1/0hZayqHYStm7IBD1bOQpkOWQ
 xFi9hVkgEN/Ngqqe0P7455FNSmdPuB/XkEHoTkZuVYCpBT/ihZF0qLlpHsCadxwEq10f
 pImsHywjHy5BzJb1VyqMiWLyS5O1A4WKjKtLDiLQnKrP5Cy4Qer6fEMb5XmST62UQUc2
 XsozWep80JW82T8reGmH6p3UqhBPtm0O2Jp2ikMO05MpQCzIEukSdxT7WoSD/MS7STdX
 kjwRzF+zkelKkQIFCOt4zDViaV8R8dPpEVUHI9pxei+XXn9rIND16/qacCF5eEFStQDb
 7ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794466388; x=1795071188;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zha2JGsDEwcVNhKMH5tSUdIx/E1Ecpnf+D2qUfTcSIE=;
 b=QRe4F67DVTcAwDvzxkP75F9WC9K25N3p6oNMBZGcAUGkIlcofq7POag9lyD2q0Kbno
 5WhuqoLicmNs/Slrg/Ybs8CpTRrjnKfaVCk2zb1oHwouR2aNYOEjRHoMGnpAJyYxf94Z
 CgHg95MDrZk1jnPbfz4jCa91Dw1VOXyBaAKom/WeX03epBaLJbO2w3KThO5QT3gGR6aR
 JY0xV859HbdLCRNkaXRhQKEFe6Luh2rM/0EHUiR4UOPvXT9NE0eAGrcjblU66h7M2doL
 d879Xz8XK6l+7xn0+pVaMGYJplxcAygCM/8hL0IYCOkO6Wl3bO7ciQVUqdYEo1VhLLaG
 68Cg==
X-Gm-Message-State: APuU4Z8HewVtdPhyB/l8h5J+s5xcKiNxkB2CfCxDddqjtOkt//6/9OpT
 n7xJYc4bTC8CKccfFNVgooB3nBp3nSgFK8VzAhmr5klij6vSm43/OXbM5nDSTHF069TvowChAGw
 tHHQTPNrob1IfrfVdzF+xzhL8ypR3cOB2xi1HN4hQCfDRqn/1FSgcVyTziyUJvGL27AfiVH0=
X-Gm-Gg: AYBFou0MbqQ9Ls+jYrWDLXDXiBzVIRGTAKrVs+CTiy1Y/IxwC1iw+LZ70GREq+VVUPk
 v2XPQXfPUyDUSMivgAbdY1b7jcMtPC2JOhxmCQjHkkVYnH+iiOAQnoPGk9B+KM6EbX4FDxQE3OF
 j9JxrGk5Ujker4/26uhxjriZPbgwICWZs1E93VpIUrRJl/w6u/xDBMNeNMiJBLaDkXqb88/EWlo
 yurBOT0a5ETPYVIk/OZSVPSaL+PZ0kUr82YQgt6CY/EQQTKIfnCck3oq5Vw8aT19p1cQDbf55Xt
 PJowVgexw71FXUv5gABYiL+mWUA6e+AViJOakajq+o1EXX/Jxxx+pKsvlhw2mu+9Fyd1ZUT2JnA
 oJkLsdM5aVehKjVZwO7nsLcpp9rkZPAD8n6Ifpbq3N1IVgOGqQ+VY0aByK6V3f0ikdPHirF5UdF
 xDi9Ra/S35O84=
X-Received: by 2002:a05:7300:681c:b0:36a:18e2:64c with SMTP id
 5a478bee46e88-37685d72786mr5328800eec.11.1794466388117; 
 Wed, 11 Nov 2026 22:53:08 -0800 (PST)
X-Received: by 2002:a05:7300:681c:b0:36a:18e2:64c with SMTP id
 5a478bee46e88-37685d72786mr5328759eec.11.1794466387446; 
 Wed, 11 Nov 2026 22:53:07 -0800 (PST)
Received: from [10.151.41.168] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060dc0csm26233848eec.14.2026.11.11.22.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 22:53:07 -0800 (PST)
Message-ID: <4b386a0b-8a59-4a89-8520-903caa996236@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 12:23:00 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] arm: snapdragon: Add snagboot support for
 Lemans-EVK
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Hongyang Zhao
 <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
 <20261102173911.GG3309461@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261102173911.GG3309461@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xlL9HFfBbL5wZ73i1nxY7qcrBLMCy2s3
X-Proofpoint-GUID: xlL9HFfBbL5wZ73i1nxY7qcrBLMCy2s3
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af56254 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=D3gdSb3EAAAA:20 a=xYRDjPgenIunsg_p9agA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNyBTYWx0ZWRfXz7XotSUuVs7A
 3Ee7Yfy72lQU08iK5ec23JRY2pdlApHNafU9nB4BNdZUOKr5l/YZE63kE7qIqP/hMks9/KptERz
 cV8l1Ssobi3DmI3ZMR9R4zEz7f0172o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNyBTYWx0ZWRfX8HDgBXbgtobB
 xs2LGcQ0oLRdp4+8fHMK136W/Gpg7GPK2OE687UQ2HVXojK915mC3j/1OKi9eFHHsiprgm0/9CQ
 hqPUar0onjYUhoL/Z21I0W0jlpC7TsPBTsmJxZc8DrBjPyUR9ZsqE3kMX8I43hMcWcIFAKP9tt4
 WkaC8Pc5yZxWxZ4rU/uw5eB80K2UzmWIW/Nz9BqpLxspLKJax6FMvEOdJrkJBpY9AqtsRnoKZJN
 BhTnb9jdV0wNJtn6Cm0XgxUgiZSLM62KZwn5tVIjGQ+hzHf9GYwf5hHWnZfhCfP71Ot5lsMzsbD
 fDAoICbrTIfwUAaMCyWZttHO3EG3u5jaKcNh/ROD/fDK/34dsIYSHy8PKfF3BMJXNEtLqRtBGyC
 sXFAlP8CR0OePFcg90IHfNWLR5su0spuL2+qeR7tjC7VOPCWxu1mWLq9IweE7UR1Yf+e4UCFBV8
 N0kIkPAzGHEAKqo5VuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120027
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 11/2/2026 11:09 PM, Tom Rini wrote:
> On Sun, Nov 01, 2026 at 03:48:38PM +0530, Balaji Selvanathan wrote:
>
>> This series adds support for running U-Boot in snagboot mode on
>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>>
>> Snagboot (https://github.com/bootlin/snagboot) is a recovery and
>> reflashing tool that works through the SoC boot ROM. On Qualcomm
>> SoCs, snagrecover loads XBL over Sahara in EDL mode to initialise
>> DDR and then loads U-Boot into DDR, where it enters fastboot so
>> that snagflash can write the images. Support for the Lemans-EVK
>> (IQ9075) is in the snagboot tree, see the Qualcomm IQ9075 sections of
>> https://github.com/bootlin/snagboot/blob/main/docs/snagrecover.md
>> See also the doc/board/qualcomm/snagboot.rst added in patch 7 for
>> usage and build steps.
>>
>> XBL leaves the MMU enabled and does not set up PSCI firmware or
>> Command DB in this flow, so the series adds a QCOM_SNAGBOOT_MODE
>> option, an early MMU disable, and a defconfig and config fragment
>> for Lemans-EVK.
>>
>> Tested on Lemans-EVK board.
> This all seems fine and I'll leave the Qualcomm-specific reviews to
> someone else now, thanks for reworking it.

Thanks for the feedbacks.

>
