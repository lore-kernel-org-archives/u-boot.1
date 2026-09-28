Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF3CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13ED380DDF;
	Mon, 28 Sep 2026 12:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8oE3Q97wjUO; Mon, 28 Sep 2026 12:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2E1FD80E7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596982;
	b=Up38dJof0MnigDdQvbEmgG/ZwQxaJW82mTWxu0hFGN+zGd3K+GIb5n6RqBNslx0Vyz2Q
	 FsoTI1a3SFjEja3z5ok4fPWUg0Wb37bPBxJH0Ruo5sSRdKsjzz1RjOvUzZ2PxnQm/piOi
	 Mesr+LS42Cu3cNs9FqfXx9UW4ttGc8Sl74xujez/i/LKfLHJ+DcdZJjrjuew9ek4kKIaH
	 VO8Z4q0El9ABADApjXdDjgLtvHZYjDfT+Mpq7CoBzyD3b7VNNPY/eoC1gan+zM3Ld8lwk
	 RTgPZGdYyx7FGVGfwnU8SP0Ujmmy7Z9IT6RqJpGOP/t8sUhWUoNhJC0waKC3UTWFiPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cNhGOAe/8u3lNoB/Nn7fs2bB+GLuzFGg40/8fNj7swM=;
	b=GWYxdRJLxdnVduinTiHyi2VLhHJ+TjjE2jUzk+NMvGJIhkono144VzSTsRgw089z0LMv
	 DH6j1x0iHn+7zDXT3MD+tclRfQQu9wmach7WZlnAEf6NvxpwEM6YRuR4F6Z0ieu0h0iIW
	 3k5ejufzMLonNbAuc3P52ijpPm1fHzYSTpGlodAC/3AhKvEywxIRrpKm4iuiuSJiFNEk7
	 1zyBaLDE4Fxl1gBZ62WC+dEH++GWzYB9WGBv6BTfMzh6lEc2HWcyjAJ0VGhh5f22k7mzd
	 QK11sM8r0n9yQ2t2V2r8Xc6x+Sg8kxrUlodV2RQPnd8pszuRXXXUmtHNxwxVUbsClcw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596982;
	bh=cNhGOAe/8u3lNoB/Nn7fs2bB+GLuzFGg40/8fNj7swM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRXr84HMx467x0l5ttofSpBuk1wpYxNmwT50kYOfe3FYiCbTJJOG4qTlYOD6O102h
	 8skhQavArtsAPlHCZJEeNeXQZXYwHQczzuqD1qUNuIQi38jTRLW39Bu60bNIwwZ5Sa
	 sCIYtOSMmcXamQ/fjDkhYW1MtX4sZEw/5URV8iA5/AaQXbKTBWY/4Cv8yBL/KElw4/
	 TxTIl8v8vD4z0gR9QixXp6jYQKVx0PUnWnrA3BCp5VexrhkIgWLIk6SDwxb9Vu+N1d
	 FCUkx70+WNclxCEjVJNVyYbPQ0GkmbwHztPX5tpdzQtaNEvPRET9gJRhZ44j80MbNx
	 mcbDErrp1VmFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E1FD80E7B;
	Mon, 28 Sep 2026 12:03:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C62772
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49F4D400DB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wlffFYzmuSeX for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9DB3440063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596979;
 b=m3Ip6Yb9bYvxJcgfFISfIU80D5qwlnbEabjMZBO9U6BBa46oGWqzuq4kB+qMf5SYyfvU
 b7/ery0sZa1yat7gPBqg9xAZKNOpVMwf0HRJpLjYRfeY+7bBBD1zAk6dhD6XHyscmfpF3
 GfH40yMs3XeNp3tEps64o5DHB9I5NwacQKbLUOkO0/+1fx/KQ6qSEDbFvryWVgw6jWguO
 gZhazmmyNbNZbsdXGqV1cm5DXOs5AAOlcbGreo9Ge+Anh4CWtHYqx8fqpGmkX/XGIoiZ4
 1GsKwOYm8o8PKX+onADIqqY7TN2iL/ZIYMPQkJ4mCR0XdmHcDiYeNdUxChYEcgTJM3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596979;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=cNhGOAe/8u3lNoB/Nn7fs2bB+GLuzFGg40/8fNj7swM=;
 b=ot8MokiJmIG060TuAT8G1NkzI8ylFQX26eU74Rs54Q9oyfJabzA/cyNJFFMdMqmOPyId
 Ge+5XAT7shs6BFaoSWgY9J1koHXuaSy+fAWvSPSUiKxMvvfxGOjqR8Km3Im0JcktcMXoP
 Nbi9AiR1BqPrnr0ydA4upaD2/M1cw0ZxlMKpzvSPPcAE8ZmxxwNMVQjyXDcMcKhBtz4l7
 /u7Qo1oRXyiOdlsBpFRGuVs1fAbWw9C3FLysNsom7CnIF1/B2mWXFk96YitY3sofjkqOC
 nUUha1O14Wv+Nbn6q2yBAMRaXjdEzFuQL0rhzjF9Rd313HUWwnU/TefZBckC0/dN0ow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZNfNfuzW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X6CRgojn; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZNfNfuzW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X6CRgojn
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DB3440063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBANvW2404528
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cNhGOAe/8u3
 lNoB/Nn7fs2bB+GLuzFGg40/8fNj7swM=; b=ZNfNfuzWB2LYEpZdlteWRYUI2/Z
 1aIk+YDEagfBk/f6HbaBDEXVPNjvUeE2GQE/hysvzgEMZ4YqpALQd721yjAg8I0y
 t6Ri5w4hfAZSjEK/rAIvFLyOMMZSilX7dfwNl0a8OhGElysCeushxhKvCKipj8Q1
 hpyAXHwoop51nYLBmKGyyVUHaJIULrz/P9DZ3LLL5DZXyc5dHj8xWmBajmsT3uxg
 VEAu/qjHZC7p+VjyFjfEHZrc9UbXAKow0RjnJdZklPWuYLS7+QpyBRr7M/Rr3PIt
 /e6qycQqZhAjz06oZ6dHqpanzqDaOcsfmIM1GEL2O+w68lEgjBBbHsMljzg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t1cn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30f1b904861so4350244eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596978; x=1791201778;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cNhGOAe/8u3lNoB/Nn7fs2bB+GLuzFGg40/8fNj7swM=;
 b=X6CRgojnVr3k9Qg2q6WzIkFEbY9SrKKqn2vvqEox98Ekkr6hU8i0zi/ueaF65euB5+
 TyTJoO1FOH1cL4d/myWQHrcRwQAPY4TCwe4EUKCRF6gSDKSF8Sjb3citdaP6r6mhXt2G
 yecmHhYy9lEjb4LNi9h6GZXeNn4eFGQhaQXx50Ch7hYxb0e+r+6+QLsnM0CV4Omge4se
 0nRZnR6bniapNMAVHIxjNzrsTzyqk3K34VGh0Mqq+/OD2/TaIY94gUC6q+fNqEmKDqkL
 NDJd9VBFt1z7ba4OzapQx79QIXGVBSk/cSNG4DfqoC0wWEavnUhnBS0rzUSDcnbWomA5
 ivNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596978; x=1791201778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cNhGOAe/8u3lNoB/Nn7fs2bB+GLuzFGg40/8fNj7swM=;
 b=Qs8uTEHRByJP5nZQzXuI7Q1V7ksch4VhA40vuwXbKm3xeyA3WpbPtcTvs0J3qpZg3R
 blJp+na2hrbC0aFVBmJjO9OXGv2K8Gpc6bUyaq0pH7uup8qtS/Tj26JLWihyqsqwZF23
 1KELRJiVWjRxxnAJOs2eOey+vfzW2HnYpWGSSrKi8yMFWuXQIC6u+B+c+7XkgMfYNn2l
 KrLti4Gd0f8O5cQ8Em+NzY47r5NmFZjSCGHrThSvDaahygv5M9AwLQIxiFVG8GTfq0iZ
 1XlpHN5G2aINIwda/+YxhFtlwfbEegkr/Lv2Hfk7ifhgbinkRjf2fO4bFpD2UinDa2RY
 FlHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0svMo4eHfPnPY7ZzduTGVk3RopJxdJR7qf4G+xMJjPOTEJ3JpdtPY54oOVzZ622heBy3xqlk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nBftCPKxrTCryfaPamUqp6U0RsN1IjAUSidwe4JAkfiCmnnii0
 9KGNQ6w3OW8bFieM52KW6pgc1sI1ATWEEOr/hvLAZRpHDHmyB4wFEtHxHieXazseGm9ZYyi1Ofb
 Tg4UDkxzihTmbwa0SgbaEO+Gb8UkcLY4VTukYdkRNjxGU0yi/dLxRrRtHDp0ZMEumt/DMcrg=
X-Gm-Gg: AYBFou18ZeUN08TAmhe3YXDr0/NnUa+6KtB9CpyfDqt7UouMf43mV4ePB3V0KTcy78e
 H0JSP7Hy98oHbHHdGUM+KL3NSAFyuKvIoa6IfmDL8Tqb+RHTOqeiFN/6yq4PmG5kYGIzLeKqcXr
 sANlkBIfUr3hREbYlq3Rb/9rScM6b4HQaZQ9YgE1boobfpfNwAfKPPknXQwyNx2qx1Qo5gOjggz
 WcsO5BgcLwxN4GHLHCZyYz1gQ0OLnxPjq6/NI6GVKdhAYBPdJAmS/w8Ej0uxNW4A+1k/QUy0zvl
 iQ44IXyuDHnH86i1aieafvQP2nXHOqFugoGQPttjRFKDE5g0w5Dxe2V+xGjSHRyUGE6suZs07wk
 E5W18OzreryMaQ5DsuT63gOV0KOJxCTbGLB2PAhaApVll7x88eFdPDbQnQyBSXyU5hHObRUBRsO
 /aUV3COLrRv/WktXfIJA==
X-Received: by 2002:a05:7301:f2d:b0:33b:faa4:c816 with SMTP id
 5a478bee46e88-34271a8df46mr8845785eec.19.1790596976890; 
 Mon, 28 Sep 2026 05:02:56 -0700 (PDT)
X-Received: by 2002:a05:7301:f2d:b0:33b:faa4:c816 with SMTP id
 5a478bee46e88-34271a8df46mr8845688eec.19.1790596974889; 
 Mon, 28 Sep 2026 05:02:54 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:02:54 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 6/9] clk: qcom: add TCSRCC driver for nord
Date: Mon, 28 Sep 2026 17:32:06 +0530
Message-Id: <20260928120209.1064781-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX5aLpBV8ZSxq+
 O9n0u3xUxyYEfKN8zB+jQL8TwrhA4GtPb/3hy/kmr0Ooy8j5kRHOHaUQx90IZgZHJiko5IyUvdy
 X7U1koEkHcETalrssulS9bqMRoVcLNtY6gUum5E6mn1dKNZlwgi+cEuCG3zOu5Amj0URvEmGcJn
 MyoTi1wAeGN6iD8cISFiq80rw0ipUAKqmFrF7prfPjVrHW+nqoqS+a/X6JutaURwvZSiAXrUXJH
 LqHnwAjgqVVJJt3Bn8ERM1kUDO5/3Oil7abcDsCRx+GpBPP/1fDNvyPnq3r+XDw6ElksYNRPBlc
 9Qt/prVaBY/ShX41h0qG6NT9kieAoid3biYgXbs2e0gHcujhHHhhiBtQmlh2h7n+aAn7hv++gz+
 SxiSDuEZ0RQcGvqyDrFC2NSB8sr3U2FD50RxYCQTYnIDcyZxaeuFhYIvA7rwtYStGaimb1f0ij9
 fZ4csoYHaLusT1ks4cg==
X-Proofpoint-ORIG-GUID: CIhenFmnJqht_50JKMqmdoFsIWIvR7Lm
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba5772 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=oK3kB6-65Y4gctBAWW4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: CIhenFmnJqht_50JKMqmdoFsIWIvR7Lm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX1s3JhOZeTrXY
 sr5RMSW3Eu1nFHArwV7LwK/BbItUrIZSbGixucUDXo7Knx9rijqzNfjY8ewhvBQtLv8cWRPjjt9
 plksb0JNwIeFuHDHfC0uaKT0Rv3mES0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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

Add support for the nord TCSR Clock Controller (TCSRCC).

Implement the qcom,nord-tcsrcc driver to provide the clocks and
resets required by nord platform peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig             |  8 +++
 drivers/clk/qcom/Makefile            |  1 +
 drivers/clk/qcom/clock-nord-tcsrcc.c | 88 ++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-tcsrcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 6266f4a15b3..d7f05a76263 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -90,6 +90,14 @@ config CLK_QCOM_NORD_NWGCC
 	  camera, display, EVA, video, and GPU clocks and resets exposed by
 	  the NWGCC hardware block.
 
+config CLK_QCOM_NORD_TCSRCC
+	bool "Qualcomm Nord TCSRCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the TCSR Clock Controller on the
+	  Snapdragon Nord SoC. This driver supports the CLKREF enable gates
+	  exposed by the TCSRCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index c9795377d1f..3a2ed6097f9 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_SEGCC) += clock-nord-segcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NWGCC) += clock-nord-nwgcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_TCSRCC) += clock-nord-tcsrcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-tcsrcc.c b/drivers/clk/qcom/clock-nord-tcsrcc.c
new file mode 100644
index 00000000000..cd89e1b34ba
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-tcsrcc.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-tcsrcc.h>
+#include "clock-qcom.h"
+
+#define TCXO_RATE	38400000
+
+static const struct gate_clk nord_tcsrcc_clks[] = {
+	GATE_CLK(TCSR_DP_RX_0_CLKREF_EN,     0xa008, BIT(0)),
+	GATE_CLK(TCSR_DP_RX_1_CLKREF_EN,     0xb008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_0_CLKREF_EN,     0xc008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_1_CLKREF_EN,     0xd008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_2_CLKREF_EN,     0xe008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_3_CLKREF_EN,     0xf008, BIT(0)),
+	GATE_CLK(TCSR_PCIE_CLKREF_EN,        0x8,    BIT(0)),
+	GATE_CLK(TCSR_UFS_CLKREF_EN,         0x3008, BIT(0)),
+	GATE_CLK(TCSR_USB2_0_CLKREF_EN,      0x4008, BIT(0)),
+	GATE_CLK(TCSR_USB2_1_CLKREF_EN,      0x5008, BIT(0)),
+	GATE_CLK(TCSR_USB2_2_CLKREF_EN,      0x6008, BIT(0)),
+	GATE_CLK(TCSR_USB3_0_CLKREF_EN,      0x8008, BIT(0)),
+	GATE_CLK(TCSR_USB3_1_CLKREF_EN,      0x7008, BIT(0)),
+	GATE_CLK(TCSR_UX_SGMII_0_CLKREF_EN,  0x1008, BIT(0)),
+	GATE_CLK(TCSR_UX_SGMII_1_CLKREF_EN,  0x2008, BIT(0)),
+};
+
+static struct msm_clk_data nord_tcsrcc_data = {
+	.clks = nord_tcsrcc_clks,
+	.num_clks = ARRAY_SIZE(nord_tcsrcc_clks),
+};
+
+static int nord_tcsrcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static ulong nord_tcsrcc_get_rate(struct clk *clk)
+{
+	return TCXO_RATE;
+}
+
+static int nord_tcsrcc_probe(struct udevice *dev)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	struct msm_clk_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->data = data;
+
+	return 0;
+}
+
+static struct clk_ops nord_tcsrcc_clk_ops = {
+	.enable = nord_tcsrcc_enable,
+	.get_rate = nord_tcsrcc_get_rate,
+};
+
+static const struct udevice_id gcc_nord_tcsrcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-tcsrcc",
+		.data = (ulong)&nord_tcsrcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_tcsrcc) = {
+	.name		= "gcc_nord_tcsrcc",
+	.id		= UCLASS_CLK,
+	.of_match	= gcc_nord_tcsrcc_of_match,
+	.ops		= &nord_tcsrcc_clk_ops,
+	.priv_auto	= sizeof(struct msm_clk_priv),
+	.probe		= nord_tcsrcc_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

