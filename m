Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66788606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i+Xzelm3;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KpmAmC0i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P9wYDsjX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A177380FB4;
	Sun,  1 Nov 2026 10:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqVvbCxn6950; Sun,  1 Nov 2026 10:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A582980F92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528772;
	b=HgEgIzrOukNClNrw7kVvc1ctFWiNogXnA9fQY7ZAMpIMoO3ZRoU6x72kzsSOApg5qoVW
	 dr04b8Z+4IL+W9aTG2mF3Q5x88BslXVUID0B+B1sU7WEmdv7rPnto4uW0+brnutvn4LrV
	 RwrNcFzH7aM3dkOA3Nd0OXyuEZhh/tgoWW/6QzohOaPfajFYh21bXASRFrzXrYfJ5foJH
	 RjOoBxpmXR6GVDdCQlH1pBMBF1GIc5T0te73eYQZ/xJUO1pgAElCvmJ9CF322V80uJj02
	 sOUmJJ8mcLHaKkXjxzuOnq3vUpHollxcDGCRq/wj9d06ZQ2hYhS1ADkCqXHxgr9sZqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tXeWKELw4b5ewEb5dqP/bn3tiqEhEawjB1vzuXIy7CM=;
	b=lJg25OwdtZnyqlDo/HL1Lodkzt/ny1YhT+4FUY2af8RX0bcjDal/YR9sygfbTQexJw70
	 4Mprjk5SggFvVoYhX5xTcwOnjDQKO6CiNhANnHraTNh9qnCuP8e5BLeny44AbZXHV3ybS
	 634pI/44rLW/sc+vVbN3K7tNpT6J+ROxCtP/rD5bmx84prRcQlRr8UPCefdJ+Ify3gpd4
	 JOEu80FeuT1LHccisui+1NSeRouKN0Cv7owfbZ82d96CJMcJTVJh9DYJSBJsFKgnNyDD4
	 tDaPg2/qlGQlhbCM1wj+sku0VUCyFz8je8DV/wv93flV8q895elFl48FH5jkq6r5jVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528772;
	bh=tXeWKELw4b5ewEb5dqP/bn3tiqEhEawjB1vzuXIy7CM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i+Xzelm3p846ZpVY5JpKMh0L4P4KTlfR9oQErjdQ0HEumHnrAQHSvF4ikHaH9WJos
	 1SFdbEcf9DhTFPhr7ZFcApxD2OlPbndtej8m/jUVR6+4KcdssjloYKEuFqGhYgN9g0
	 nsAryTqrs24c7kfBWiQwify8D49b867JMDjC/tLkhMEk5xNEpLmNfuoDhM+gkfKnwJ
	 8YvCIvvhUsJ8o7DtejLnETKm7QqIgzK/x1xLVhw9l1VSl0JVxejX7xOV650XPzy2D8
	 LtiEY/2yAKvMLR5qgq5ZHdCuNoPoABcZ3d7PjIiq2/LmnbriEcCKIhPbF6jIvM4pzd
	 5KXCVgNCR/STw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A582980F92;
	Sun,  1 Nov 2026 10:26:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1675D4B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F070260623
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UCyPfZa2AQoL for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0662A605E3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528770;
 b=cFfiHJHUvavoz1HXwuCk5D5yPVKf+7+NSRJ6zS8QpqiORF+I4ZPJ2A6b5ls8VuH6pl6L
 MwCZ6odajlzwP+CFdqRgDjKG5BOQPG5rOIgWwFObDb2SwNNFvoGjPp02nGik9nz7YwEiC
 4ovmriWSowqp3fURPgc4+Iq6jIYsCyESGp6dZ7XB+beT5WnWlCmPAq1yMUhts0OG25co3
 St6GfwDIvKLtOvnVQ9NeHmdJIWwfeH+1p+EBVOKtqHptQgMQt8cisX6MULwQ/hZVp4HBS
 6pN2j/6nv7P6ODGKzFj15ufrfFUwEG9rMSvCGpSN5T4ICWJLIJVuw5M2SlhZO3nqllQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528770;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=tXeWKELw4b5ewEb5dqP/bn3tiqEhEawjB1vzuXIy7CM=;
 b=ZOkOHBKf4Bty6TpSPoOmIx8E23QE6UCGnEalSFtagK6VnctRpx/FjBf1sIOROVL3e9Tb
 co5DPrPmitQOrFndJeS9yxE3kPsAa7PYD7pbAA3TaWAwKxNAHMF2xhZC6GJ8YO80WrxQZ
 Swfu4jRlFm5RrjM9mfjv83R8h73r2zKrGqThgbZmrYbP60b+z75uywDqno5OLYBdc/xfp
 xgPYZKGuXIrZhJ0tmPWqa4JN3VfzAoCvOq+DJeHChhQ9pmt4VAzva0Iyb0VBXXdNtKaEZ
 s2qUsSG8Oe8yjrAFmACI1qY3OtvWUogRKKvzoU16axGsWw4D2+LkPg3oJTutPusCwcQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KpmAmC0i; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P9wYDsjX; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KpmAmC0i; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P9wYDsjX
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0662A605E3
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:26:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KYsX350577
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tXeWKELw4b5ewEb5dqP/bn3tiqEhEawjB1vzuXIy7CM=; b=KpmAmC0iTtELUqZq
 4kv1rjjqCFH2IAUPJvEdEWMwTIg4Y4EJ5fXzj5lJHg9iyN2RDqVC/LgzaUMn2Z4f
 UJxnBVS+CKRRigTcyZ1RLV97dpNyxx4HMKZHfA38rv2oNaU9dyJvdC+Iz46Roc1y
 BJQ110o1Zc14cYpkhf1bJ5icvEuFeR1GmtHbBFZS7yjxJYsl30e50nPv2HKF0vk4
 km3G+TEZqmvZ13ygOiRuF7EiRMFvY+YNZcVJDAwb7mK185zusOQdPlm/fpj+y4ja
 ra2K1/KFOVMk/WnYToGMlz/04hBxVoJodB5HfeAbZoa3HHQ2qSIawOc8RWKFKEWA
 W7dl4Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkkhpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:26:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a3451ea93so3495783eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528767; x=1794133567;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tXeWKELw4b5ewEb5dqP/bn3tiqEhEawjB1vzuXIy7CM=;
 b=P9wYDsjXhVlpfJZ9g2xleVjr1bppdOJyYmuUV8IARQkh4/u5xu5/qTR3mU9QW0wa/B
 khQQirAYIDHo8P9GAr6MVq5zz7k3tShT96pB2XABb6LHPlf92qKkxcSJ7MNzV6WxHMsq
 RRju1+YfAtrCi4Pp/B/zeSCAbxP2xPua8unaGCKWWDENSJNeUaeIb6MJZiVv6jWTBLMK
 c8iJwb0q4puJVIKlQgaL2B6A1oqb/Wl3LJdFdYuziScOfXDa9Uy5dYU6VOB/cFg+cPQj
 aV89GEBMJVJeqqBr+QJW61oTv60wdNG41GdGjA6kg0IaIMqovSyB1qCqfwKM9AvRLZfP
 wZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528767; x=1794133567;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tXeWKELw4b5ewEb5dqP/bn3tiqEhEawjB1vzuXIy7CM=;
 b=pUvpSoL6ghtsfBhvU4ayZnQhUFuOiwLRxdXrdSms0RR0HvnAeOEPl9pcFE0JHvHeRR
 4rUGIHu1sMnrMAw8Or5amfWykla4GRT8u+BH3+F2Bc6xYK5/T54a6sj0JhGY2tTtYK1W
 CnwUlGt0YOMfC5Tm5wbahq9+H1f+igMBnAX6D55peCfqVjuWXgYHLbgo0TvZ8a1iCouJ
 b4JooTZAgMbx7Pa3bjfbYqZDoZP1qPH7a4yPZKfa8t/SSk/jFpi6bd/5S8eNDBM95HaS
 Fzj8M8+UieHvSjyetzWWz1MdrT89D32akVbI96x6maVCdkorZ/S9gL/dDsgXsmjhxhFV
 D9VA==
X-Gm-Message-State: APuU4Z8W2YyHZE46wTCko7N5owe7ABSUQFjGwJPdOQekOKRagwi2vYoJ
 hum4KLc67KVdzajOwA770+bDJDOOUgFor/hLqabz3UjdX00iUimtjQjSIC8tomoDXhDoe8nY+0N
 ANb4/MxoSJkepHg/azOEMRxd7GEGrfGJuU4mNxhnSp4eBbRKdcRu+7S1PsZhA6GSfiVMNo/E=
X-Gm-Gg: AYBFou2FjYBayPlPfEUHbfRPvjQgKsAJmcRJnliqoIpCqN65cgTI019w/cBmb8O8s1X
 b1dY3gynNcNp7/76GksPnHV6F137vKA7Yfrg+rADEBXjMc26rTy4xhhOZbEDzMU0KLwAFdzX0oA
 aaw89YH8qvPRzK8shLRoqfktJucI/IBAP55F3TxmQaLBYhV6OmY1Z30pmvPaVH082xfa5pOX7r0
 OGa84OweHT8z5nVUxwmpVnkfUlU19ksy+zzqytzqtOI2XtU4q8jjJLU0OxBgPNNNBJrJf3e+BVa
 leva1xdwJ7LVMRLmqed4GzfmmWU50oDerKDe4SQBhd/5PXdImEffasOnc967Gj9BYvUN2P3cuoI
 qdMcvNUQLtlRGLFJpFCEAbr0LESYtac45+UcYJ5tA2UiiwEpYFL4eB7P+lgwlzq3zTIlyBGof1c
 382xJ85GvB
X-Received: by 2002:a05:693c:87c6:10b0:351:4a80:d94c with SMTP id
 5a478bee46e88-36a423e1f4cmr12192561eec.21.1793528766849; 
 Sun, 01 Nov 2026 02:26:06 -0800 (PST)
X-Received: by 2002:a05:693c:87c6:10b0:351:4a80:d94c with SMTP id
 5a478bee46e88-36a423e1f4cmr12192519eec.21.1793528766144; 
 Sun, 01 Nov 2026 02:26:06 -0800 (PST)
Received: from [192.168.0.6] ([183.82.206.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429000f8sm25371285eec.13.2026.11.01.02.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 02:26:05 -0800 (PST)
Message-ID: <43b8e978-13aa-4c1d-9dbb-75ba0a11fcd6@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 15:55:58 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] arm: snapdragon: Add snagboot support for
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
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021174012.GB3275858@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261021174012.GB3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ffK-E7iEcYb9uhYs2_1WKajunckGNLAe
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae713c0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tp4+1iC1jwEXx1kf+84ntw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=eAssBoMHPnAcLoovTecA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX+F0SQtedjFAl
 fm1bCg7+G8gQYuGpEkyuhzxU215ieZfddrl8QCsM8eoJS11wJDQDzBn8ASUfQbgfsBjNuzaTXUx
 EQNuthi7sb6S83aCyLCGW1INhLLvveo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX2IGmbdrEbDWa
 uld4CHLEcCNsAVVX4NnmeBaeW84VE3nvbw80nxLQKqtG5cGqSLCXj0iyjCjzT0OHMUSwEC/5CwH
 yXQRCjErSujwR9SPlRXLTQmCNMjGwQAeaPmxkbcJAcgwgRs8qMDrdwzoUMHADndOJEEqLlC20nz
 GnTOMEM7oc+lXI+a54/XNLsZkzT8hVfvdvecd6AhJp6CQEzgp2qQVlleIkOZ+4KnKWy4+be5uC4
 cX7dr/yGhzZRaRQFQNBDjyq+gCpuzd5DhTT3BhQl0r0iZkR9kx7DwEwJN0LV+Lj9711vg5NRse9
 812/u5Rxy0SZclyYZkn/nygadfexc63au1Hu7Zn2b42ysFQTdkI7s/2v+eA1DqHuv980iK9vMUV
 DFFGlB+R7KnAPDp/YQN4Dh16mDpxEEbGE7xIps0oWITuKEXNA/mu8VZshUUqAKy6yCBuTikBLUr
 8PuFcueUlre1alit8XQ==
X-Proofpoint-ORIG-GUID: ffK-E7iEcYb9uhYs2_1WKajunckGNLAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010041
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Thanks for the feedbacks.

On 10/21/2026 11:10 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:48:19PM +0530, Balaji Selvanathan wrote:
>
>> This series adds support for running U-Boot in snagboot mode on
>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>>
>> Snagboot is an open-source, scriptable flashing framework that provides
>> an alternative to the proprietary Firehose protocol for device
>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>> Qualcomm boot ROM EDL mode and Sahara protocol to download
>> and execute bootloaders. However, instead of using the proprietary
>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>> standard fastboot protocol for device flashing.
> You're implying that snagboot is qualcomm-specific and it's very much
> not.

I didnt mean it to say Snagboot is qualcomm-specific; Reworded the 
commit message in v10 to make this clear.

v10 link: 
https://lore.kernel.org/u-boot/20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com/

>
>> The framework consists of three modular components: snagrecover
>> (downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
>> snagflash (communicates with U-Boot over USB using fastboot to flash
>> system images), and snagfactory (orchestrates parallel factory
>> flashing tasks).
>>
>> In the snagboot execution flow, ROM code in EDL mode loads
>> snagrecover, which downloads XBL to internal memory. XBL executes
>> and initializes DDR, then snagrecover downloads U-Boot into DDR and
>> transfers control to it. At this point, XBL has left the MMU enabled
>> with its own page tables and has not initialized PSCI firmware or
>> populated the Command DB. U-Boot must handle this non-standard boot
>> environment to enter fastboot mode for device flashing.
> These two paragraphs, and the introduction, should be condensed and
> concise and point to the snagboot docs and also the docs being added in
> this patch.
Addressed this.
>
>> Support for Qualcomm Lemans-EVK SOC in Snagboot is available in
>> https://github.com/bootlin/snagboot
> I looked a little, and I didn't see it, but I guess I just missed it?

Please find the Qualcomm support in Snagboot in 
https://github.com/bootlin/snagboot/pull/94 (which got merged).

Regards,

Balaji

>
