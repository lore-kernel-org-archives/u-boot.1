Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD42606D816
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xGO0O1BV;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NhOx6PSN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AopsXeau
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7740660822;
	Tue,  3 Nov 2026 15:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24WDSjG6Le8m; Tue,  3 Nov 2026 15:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 597676070E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720305;
	b=hbQc5evLI0d7zC9rntI2oRbagEphPihZ5VzhRd+gKNmziII1A5DmBVxKFVXTLMBNxMiV
	 vHK2yJPKJ3CzRq4XcNA8RU5JNhI/RsWdiMYPulXhr9oyoP4bXbDOztmZrTrJPlvBm+1yr
	 BroqDGolX1Ki929NMB75eB7CECaWDvWQJNHldDaIG+Sd52RmdOSIFKz5VZ+JHDoU5y+d2
	 CR34QJ5z+IBolTt8jnpV4CUHMnOJsNjxR6p+P0wwtU2GKDZ5+TWK6pR81ouNTUPzZnR7u
	 GbsJdvUGzRULVs1MjK5P2mzxeeiYbPa7JCjamauxaME1u9/8gzvNDQ3XWne5cbwfAaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720305;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nbUpJZNPw7qJ3qVwxrDW/gcLpUvvDPf4eKrClsWVq8s=;
	b=dsQ9YH9YA3b4mrdtU+H+6URlRljlf2j+aRbX2J+nIzyboz9ruYF2sGeIaphSszOufLmh
	 Au5wIQizdkeCRk+7P4w7Wh8/gLOOP7gLhFF7oD540dQ8ZDcbgPpdoXeb6VOQbHFA7W/Xb
	 fW89dIA8Imb4f9pCBuAfDO+GONwkHxzL23UATUew0IsWH5LbBnSDoszC0m+U5ZGYTfkXS
	 WgEy4AUR4fqJ4HRQLms41o4iDgtWvGTvdMyOqOgiXKEZUqDA5kEd6QKiGQQHuIQAhNOIY
	 ZfhqJFJwIItbuDPhVrKBk9AHCg6qJ/AbYZMMyENujy2YXaiXSZJQaiw8lUv6wGKBQ7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720305;
	bh=nbUpJZNPw7qJ3qVwxrDW/gcLpUvvDPf4eKrClsWVq8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xGO0O1BVUwyA+PVtZvwOLdgPLuZONISZwaQHr0NLGo5L45+qNqZawaKT08u/Taq38
	 Yo6TX19UK43bSzGPadLctqkZ+qIsT8JSYYhSYD6a/4h6yiOsroKYjN8E2TA4VElDM3
	 IP0Y2m230vn0/02Gip42wL09vDGUG3zxiKgKmdbMt+eEcS1cMkr9ephOM7SgkCPf0/
	 T1izUAzG51L/K081farwHAhMVhcE9cg8cejMP6RtV0ikp7Vpv2Zyp14jfKfBevyMHJ
	 /SRFleNl/1SMVXVxmqUmZzkCtzTn73v5n5WEH0DhDp1QT+F5gBnv70PBazgiezkkSW
	 s6116smlHtM4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 597676070E;
	Tue,  3 Nov 2026 15:38:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F1A0A10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C85E400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:38:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6eW1RfOxcwC for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D92B940068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720303;
 b=F3oy+a+7ZhNX7t3C8cmyrBBU5eY5TPobuoS4Hs9Wxdxwcqlxq996IQ64hhPNTmPkM+4g
 kxEFbD6hX72OQohPy6onGiLq/Gc8dMgyLInisjIC38wI6Z4kOZUUdHZx9i0dBVHm2Mejc
 xnv027w5hM6lsCNgmBsUejL5G+cFdZj8UjMMQrpX+OzGao1U6p2utMPxYnAqujaWTx0pf
 4KKkDDZmNsiWcfG9uKGWWP+FMb6/fMWHFhpq59i3ZmKSTjm54Uxp7QUP+Mz9spbLRKMyj
 LhwjiTnA8Rr3OLEkPiFG0HUOzOOKIQRN78164TOTzt/aObe87c94qVXF/TxUcfiUiwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720303;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=nbUpJZNPw7qJ3qVwxrDW/gcLpUvvDPf4eKrClsWVq8s=;
 b=Y5EuKssgdwHoZIhAJ9IRbM18yy+gkf4wPiZlfQkxxRAmJ2+NzZaiIYyxggpQmDtu6HCb
 8DRYdLxJucUpwE9OP9FE32f+1+0y9h8FOAuKj8AndhkNJxJEdcDhvc6Q48jzMS/rpAZSI
 /91hzWIR6zWRACnkg0Kt/EmAeKY2BN1S6f6gJVhLA5e8OGZ+n4agI9oXLYNElmnBDNYWB
 +aaIzQX49uIMNhNqrfxLZOIa1KbBhP+lhsLAxtXwtVVCWy/zN9H3onxdLG6B+Ver+9sP4
 wpx/uvCsssnIlYMxY5O0q7nqLGC1nxdJ1sf4vsg5q81WE+/00gSWJbsHvxOF6u+dv7w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NhOx6PSN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AopsXeau; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NhOx6PSN; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AopsXeau
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D92B940068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:38:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3EA0JA2727756
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 15:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nbUpJZNPw7qJ3qVwxrDW/gcLpUvvDPf4eKrClsWVq8s=; b=NhOx6PSNDz6HtXXW
 Mke1dP8tdCSrPhxSIS0RO0zTkJFUmojWOl59Ef6VCPlzwH/6OkQNX7E+C9TXdHet
 RRXFdNL/suRtlmw1dhSV1yFOebxu8VJk5YJLMVChU1oq955Rx94W2FhtHFMUZXqa
 xUG4WSJKuxVxmr/Sm3emikcUb2n+lScwIMEdXK2TZlJNaTPi3MSyv4Kht9+4tHq4
 ViinSVV+3VAS1uleFcjlj9ONyzeeqIjGUZQ57v92Hz/uXOwY2InnJ2EQFBDR5PIG
 uzqLxSBp2IVBdY6vp8rPz4KZYS3hxfmHdxdwVxB+HJdqQGjWT12i2nE10YV1Jfcr
 LEaUkg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bgcw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 15:38:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso9158986eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793720299; x=1794325099;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nbUpJZNPw7qJ3qVwxrDW/gcLpUvvDPf4eKrClsWVq8s=;
 b=AopsXeauhPqqgPizVQE6+P+KcCLiQyUBAxJsrE44TP2wOds/S3FN0rfyRH+DWD5T+6
 aGvRRYNGjRCtiD+q3RlJPh50t4uJES+ZJUxpmzNdfvzn9jh+07TwxHnCFv60zu19oF6x
 rRciD724e7DET98+7rgpVmrisjo8WOjfk5vQHPtKUeoOvkYI5lTVcXeIMTgdpCpsGGMF
 9B/VhA7Y7ghBp++TLHVRYTiGRWOUZmxPhZ/0FepP7fWZvgwxy2cFP2e2ZNMOy+PBRuFV
 zOf6hD5HwX8kfkp084fgZ91NcvROAmq5EfY0dey8FPGywxGzJIADqzY7Pd/2sSaqchfb
 vhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720299; x=1794325099;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nbUpJZNPw7qJ3qVwxrDW/gcLpUvvDPf4eKrClsWVq8s=;
 b=YzvDepW1dGqtT7BTqQuAmLtc72fk0yqtW008RMYV+qvciOqR3gJKXeq7zkRhQhT1wi
 ZId7sRApes8JMjPqOuudw4w3vToluBoUmR8dwEpPjMhANHAiZCXeO+TaE3iDkXsZxQkM
 AKOM8wRflj+r5GjJojRE/XonLyLG/Wv1dIpUgbKryllcFgW1iH7ZdRF0tuj4ifspvru8
 bttR0yqzmijn5ceksn3uAcint3VWo2INicQHufH700ZTDt1AMzrVDT3rifUutwfrcLg4
 rrFV7hvOgFkXXCiwfizDqdyiaJbZ4QZXkCL1+9CVXZDdTYEeCmG/u47fNE4q0PBq+u6A
 1WMw==
X-Gm-Message-State: APuU4Z88qOipbKCFtYtstxBCENMcctBMpzy+6xq/GBxhW7YJnwDQTJcz
 zzT4WqYEaJYgs3eynR/bxQ/jd97+R94k9gy8QL8b14pnLZR/qAByrC5RGDAN+UdhkE9Pu21dEce
 EJlQiFeaGcCz8QJwT+KIX/8SNpyP2wGkhdK85WxkEzcXOcFSI8Fo2vRpPTlL4ztzzLwXge4Ud88
 YPTWM=
X-Gm-Gg: AYBFou2HPK5WraoNIdrLJdoqZyXgsjew4wMILhT6LtbhGBXssqbUHF6UppQEoT8CA82
 fBMn1yD9I7hIpSA+h7HThDDkjtrYBgaGNAEEXjBqQLGyF/kDo4dkTMDwf6ReN5syV8hWzeYIsO0
 +QPtWOU0jkeib7VSMl4lX7IvHcvmRp6SvzWPOBmODwhmH4UxiRrT281ZtzsvYDxvMwGR8F2rB1C
 wsliJi/jgO8mG/4670YalUDqvQaJA6qqLHuklHY3b+1dh1fauzdEAhYRBn4+Ekg3NfVhGlScjuJ
 PH3JGd/t9+IRF/znsEHqIBz2aRL6mdW6/jL3yXyCnc0wh6L9ybOoR/wyJgdjOHQ1+S5FzCr7irc
 7CT7Bnvmtt4Hw+0tRyX7IudCOxRoeVb7pnpP1mMm97gLCC6v7ABODWKLPad7IXEpYU7eQfJt5/g
 RHmYGHJg4=
X-Received: by 2002:a05:693c:41d5:20b0:368:d0b6:b231 with SMTP id
 5a478bee46e88-36a4239256emr19315980eec.10.1793720298895; 
 Tue, 03 Nov 2026 07:38:18 -0800 (PST)
X-Received: by 2002:a05:693c:41d5:20b0:368:d0b6:b231 with SMTP id
 5a478bee46e88-36a4239256emr19315944eec.10.1793720298258; 
 Tue, 03 Nov 2026 07:38:18 -0800 (PST)
Received: from [192.168.0.5] ([49.206.97.141])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm56444204eec.22.2026.11.03.07.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:38:17 -0800 (PST)
Message-ID: <1271c5fe-ea33-42c2-a578-c6ba87b6f930@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 21:08:11 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable U-Boot SPL support for Lemans EVK
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Guodong Xu
 <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>
References: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
 <20261102195900.GA506741@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261102195900.GA506741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX/o//cWzDJJRl
 W5YdgQUuGOcqaxCOt9iNsICW002qCnmQGlcItIln2pRoYsHlMtvbw2Uu5qbc91xWzK3VkHiRUMt
 6h+OuzXpPhed/iOWUyMQylqbTuy7g5I=
X-Authority-Analysis: v=2.4 cv=Xs1vqlF9 c=1 sm=1 tr=0 ts=6ae9ffec cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=nNSuycJrq3YNisLFxgOcLg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UcrxqIhXtRQzHO4K1FAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 1E0C4wqXagBgrvC4mPL7_u5GSHfuWa9W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX2xfyfeCf8PHQ
 f5VpENzZWSZGzPktWD9VOL/C0J8CESipGfCLkIyPApGZqcXk9bbfMD+4hxQSZHH7eveKLCweNmB
 GjOq1GvEmPN0uhC+OPJyvnlx9Z6Z8asIb2k9isnZ43zw1OD5T0eZfZTzGp3OFl3g9ML6wzmorPn
 MOBZpsMO+bQ+nP/mOwRMH2xEfCXdY7eXqlBNTt/CyV+pTA3mz8Lxd1PnQ57KIlyRkwL9aMKlco7
 Wg0pwNt+yual2SdHzPRvGj8N7TNSDflCfJeZggyRwVx6EySnRd7/dXEeDSG4bRmxIJhCtj7cCU4
 EpI53PeTUo7CqvcuZwyPnpUjbIm0G3NDSMT+5LIrPF2g7QHevjdTqB7YDTtzaJiw2W/HCBy4gUd
 +scB4fxq3hFK4R+DIEFNGc8IGsflg0qFK81SEWBwYU8H7bBC23HQcZ6Tfs09MPrLd4zB5++2zMr
 7KGzJLdrBsjG6pMhVnQ==
X-Proofpoint-GUID: 1E0C4wqXagBgrvC4mPL7_u5GSHfuWa9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030062
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 11/3/2026 1:29 AM, Tom Rini wrote:
> On Mon, Sep 28, 2026 at 03:58:13PM +0530, Balaji Selvanathan wrote:
>
>> This series adds U-Boot SPL support for the Lemans EVK.
>>
>> In the Lemans SPL boot flow, the sequence is as follows:
>>
>> PBL -> XBL -> U-Boot SPL
>>
>> XBL initializes DDR and then hands control over to SPL. SPL loads the
>> TFA-OPTEE-U-Boot proper FIT image from a UFS partition.
>>
>> This differs from the generic flow assumed by the new Qualcomm SPL
>> architecture, where PBL loads SPL directly. SPL initializes DDR using
>> QCLIB and then loads the TFA-OPTEE-U-Boot proper FIT image.
>>
>> This work is part of enabling SPL support on Qualcomm platforms,
>> specifically targeting the Lemans EVK board.
>>
>> This series depends on Varadarajan Narayanan's "Qualcomm ipq5210 SoC
>> bringup" series, which introduces the mach-snapdragon SPL architecture
>> used here:
>> https://lore.kernel.org/u-boot/20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com/
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v4:
>> - Remove memory node as now the available RAM regions are taken
>>    from SMEM
>> - Link to v3: https://lore.kernel.org/r/20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com
>>
>> Changes in v3:
>> - Rework the series on the new mach-snapdragon SPL architecture
>>    (board_spl.c, fit-handler.c, qclib.c, pbl-shared-data.c), replacing
>>    the monolithic arch/arm/mach-snapdragon/spl.c and the
>>    SPL_QCOM_BOOT_FROM_PBL Kconfig option this series previously used.
>>    Lemans SPL support is now a board file with strong overrides of the
>>    new architecture's __weak extension points.
>> - Add board/qualcomm/lemans/spl-lemans.c and include/configs/lemans.h,
>>    replacing the earlier SPL_QCOM_BOOT_FROM_PBL-gated code path.
>> - Drop CONFIG_SPL_FRAMEWORK_BOARD_INIT_F from the defconfig as now the
>>    framework board_init_f support is removed.
>> - Link to v2: https://lore.kernel.org/u-boot/20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com/
>>
>> Changes in v2:
>> - Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
>> - Link to v1: https://lore.kernel.org/u-boot/20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com/
>>
>> ---
>> Balaji Selvanathan (3):
>>        arm: dts: lemans-evk: enable SPL support for UFS and dependencies
>>        board: qualcomm: lemans: add SPL support
>>        configs: qcom: Add qcom_lemans_spl_defconfig for Lemans EVK
>>
>>   arch/arm/dts/lemans-evk-u-boot.dtsi |  51 +++++++++++++----
> For clarity as I try and clean up patchwork, this series needs to push
> the dts changes upstream and then be re-posted once we're either on the
> correct devicetree rebasing tag, or can cherry-pick from there the
> required changes. Thanks.

Sure, will push the dts changes upstream and respin with the other patches.

Regards,

Balaji

>
