Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECF606A334
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aV4nS/FV;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ATRBC3j6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HqOuwtTm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B937404EC;
	Mon,  2 Nov 2026 18:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADDr7-vKL_eN; Mon,  2 Nov 2026 18:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FC8440506
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793643394;
	b=PLTpm2BMXl8Z9T3lanSyQr3PNoI2co1RoM68eGk0/omusRhBzNckAbAWhaXaV0PHTTII
	 qMP6EQTprIRG3eU93pjMpPZH5HnrNbt8ayMEyKPZ4EAe8urtkjlZIv4Y+OOYXW07ezJSz
	 SoNZnO8w3nc11O91PK9JTIfst+eyH9gosO1My/wZeztZOjbBjlt7IhhvoXwXGB8UoBrNL
	 pcUTf0/rpbKLLB1a3kwVQm9Mowr02AWngCQORNQh2MVt7ZjpAHREeNFwmg5vt3utvHgqQ
	 EeNvh1m7vbby+WZQWHIWGQA3ssJkVHlXlm6/VQ3sO1eRDFH5NTHb5tRWafhQ7fuMpyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793643394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8Gy9o2o2dJdS5TNBhcjvrN+sLW/PiaD1YksKSaD1WNY=;
	b=H0t4Z6Xb1nxMeWoUZpIIj4EloMEf4U6qCN3faJi39dPpK9LsJICe7oY8nHRODb96ZfaE
	 mKy62K4B7mdZHZNoVHAFfsgHiAexZCxQyuHXAldGfKV4dPuqQXkOprBWZ3/ORCDILJ/E7
	 oyTUx8mg3bbdJb0iL88Mq6/X7g03P58/kHfhzGcPKZET+A8JbQpqjCMhMNrlF9FRn0PZK
	 gLDX081nDbAcDAXix2TC+4h728DS/b0WHFLOYkOjJqQLUYEj6/CsGntHdHuUxjomfOrkr
	 TqFpfQJzeYEXmpkCO8FCaUM/PfOUbllhs3I1X4wEI9gWsZJ1Q0Sf/5U70QdeaSzL05A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793643394;
	bh=8Gy9o2o2dJdS5TNBhcjvrN+sLW/PiaD1YksKSaD1WNY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aV4nS/FV5hGaAjaohI3w/mmcKkPAThZzfUqbPtFRIjGL08lvi20AD+/ANsNNI7ijB
	 ZK0WWqIO55/GoZMK0g1ZACw0mEzO4FMuMpdJKMg3nn7iBrEr8gpZXki75Dm5iXtFw1
	 sRJPMp5vpxVWx66/nw6k3OY0jLiHQMCXlGqF3XZUlDJnhKU76kyGbJcOsGDWvdL6Mb
	 dVAJ16dwJAOG+gAEUr9eU0M0fuh6CXaZwNd6mUeUj1h6fD1ZGnV8cM2TrrT7Ups35Z
	 l1lUPLyNL8GsTSJUbVTPDkvCuxjpAI/sRB0R+zhHsD3RnP/CPIzJHGhQO3o+rGBV9Z
	 QWhsQpDL/IjDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FC8440506;
	Mon,  2 Nov 2026 18:16:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A1AC24BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 870C9400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4A-8xrdJFOTM for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 18:16:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD1C34007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793643390;
 b=DWjPQj6S3BU3piQPUIXKhu2/UPc8VuX2kjuXUfsZ+Yn13PqNMxfkJhFOOncUOBes7FAC
 9jOpouNdLU1yDzApgKJpnwrynXUK5z1arsIW9WBvWP0X7M35g86owP6+X07fpRxgZq/em
 +njXkkEfjG4dgjZPhnL9vreW0Ok85y7PUfmefrdEDW/p6TC+nXuIRWhHsvZ1O2+6xhaLn
 Oocb1tNo3BamGXfsj2AU0H1DymmhEr9JSRLSFy2/iI+slAhplunKuoK8TVP1D67gMwePk
 ClnNYXeuXDs6wO+motZpIPvRIsPcs868dAraSqJtduKfwcwFjJ4ccGJYBxV6fQLD00A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793643390;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8Gy9o2o2dJdS5TNBhcjvrN+sLW/PiaD1YksKSaD1WNY=;
 b=suHBIu6atvE9n15ppGda9Rvz1UmySCnPLVkKNe7HKIKXUokaf4S0o6T35ez86Nv9Rq5s
 7Cuvev+nGF5r25eNISGHkSeKT+f1sv5PhAUaT1DgNDz3JbnncpENzE7x/OI7x0kfJHXk/
 /cSq+JWOQIkEjmbcbLWQUJcoiVK6/gos/1IIZFQpGyv9PMYyuP8YU1lLumG/+3ZJUZ72S
 fjvDbsP6/KrmTvDFStYbQ9dSMP/qn6ZSzDjxJFmJZcmS4JK4/QWvD7USKCGXXPdx0iCmB
 si8KqjYKN7DiyWLfBet8LeL4xzKnMWMg/0Mw8tkVaWKWx1fPba/UAn71AojtJBKm7+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ATRBC3j6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HqOuwtTm; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ATRBC3j6; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HqOuwtTm
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD1C34007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:16:29 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HP0Tn939190
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 18:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Gy9o2o2dJdS5TNBhcjvrN+sLW/PiaD1YksKSaD1WNY=; b=ATRBC3j6hBKQRfOn
 7X1Od3pvhMbVJOFpBvHZqFcrsbmDIgq1GRnNY5uNn0ZMYHJMEb9OTNw3tGO/u8Ts
 TkWW25lqcj5k/Pyhl1uX0HADKPYFvmxseuzgjABj9/QYSZjNfuoh1nIwP2YmXC/3
 bBHE7LtdJBpIn/xah2AzOtALNWPo5Zy9lsGvgPeNmqONc0dfNKATLJ2ntnUQ8WIM
 d++1pkrYT5PO4JDuFEznvXusTlAPjTNqRzfX6iJJhlU80cKieJq6/4QCtKz+2sYM
 Fh0kse4EJCqqcxd/z6swvUxVd2AeXkZw+8EsMsKggFVPn0dR+q6Oj7cbnDYFs4Xt
 WX4/0Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6st1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 18:16:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so6330664eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793643387; x=1794248187;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Gy9o2o2dJdS5TNBhcjvrN+sLW/PiaD1YksKSaD1WNY=;
 b=HqOuwtTmhIGLqpKPY9IIAu+5mohz9o+2GB8At/IDuiCSv/GypIMMnlWjSCVM0iJ63L
 /k0bu9slCo/tcvoRRDcsaJ9aVy2Mrq1yB3eIWwacRWF4xSbwQsYWo4yRSaAEUj/LDl1G
 N/HVIx/Avkzk7WGN6PNNkc3Y7nGaUgG/2DiTxaZ9TxjnFKv1XabomR/ATH/S00f9Cfo/
 +sE+HsUH9nfZMLzzS8cgsPZKKSnAFSBCY9MC/MKjgCuvc9BSOzkkX7dcaVAAx2eATcij
 s9zGTLe+pX8KRw/NSwoYJ+RHPgTk1OqAK4VrBRPj21mz2hJi1YaduHOgzL/HspcrksH5
 kxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793643387; x=1794248187;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Gy9o2o2dJdS5TNBhcjvrN+sLW/PiaD1YksKSaD1WNY=;
 b=yPoU8ZhtMmJcCJOUVev3b0Z+fPbem8ijkMypnymexeKtiEB+1kZ3jEv81Bvn61omy5
 6wCAFUU7LaPEjpAf46IT6LL7gAhdfj/UFmXalj2vteM9RLIzuvCxuJ5fyPcxiezLQJd1
 TmLI4swdotxd0Zf3cjWy8+3tdm/vOJb9yVKVOIOR4wXlp/BRN4CUIvIJr76upcrWPwxb
 qSTWwKHoj4r03eDiKiKMxGr2PEf5zPSPJCc7cjaLyjJ+IMpKdEp7Z+Gzwurq25aVf61q
 nkviQTwRBhEKQpsl16WOdytHTtNU4CS3BKsRz3/hJ6/5uQR72vSXfg3ybO1jkWSGLGZY
 60BA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxskexTQ6g1tnOBzaZn1w8M5vyOhg1gVC15O6cMa1GEaUCm17seT9yCwiStchHmw018VwQCqig=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLDg+qm0Q9LjCFDgM+jqCfqImlrixxgtjdiJTLm0rmR4BPJIpri
 gAPF3pZMXdUIezpKMJ2LgEoMCQjVm2txdkDAJAJopdOURySppIHleQGOucEnJlibvoPz0geXoRK
 zBiQIAAPhUYveKBUnamGrbEaSKkMdoplbPpA/fJQbJptQo/8Lvt674vanfKM5wEqKT0/q9s8=
X-Gm-Gg: AYBFou2c+aAegMcMHcXqVQK854MtmaZv69BN7yDt156fMIWZzj2GL6rKEm8kPWhhXqY
 kICIJl6RoCgmK8Nf/zd4ya3rHq8/CD573RV/OQsprhbdBSgA9a5tX+Fn9KofmlqAA7aGTRbm/SQ
 QAxYi5QSwe8p+X7oCfFQ1DqLKO9y1KVnrhgrBetx/1xnvZ0nU2CYJhyC5RZAHgkC6zZiAJ2Fv9r
 jpCE/+RM01uptVB8vHECGmBGwVzfi+2zMc+I2BJdhjnq783W+dzCspKmD/EM1gSRHAXz0sXLK2g
 XBqi13qg1ZhwOABgJMDHREIMQdbURX0BwYFRAHW+vaK7r8y1Jfo7VAnPgnv43shv0jAlyGlfIis
 Tes3s9Dj9hgLXDa/RGpFsDtBUCNYxBPJguzPi7kFnrsmj1xjTlNagF2YS9o5IEmPiUKWmZ2Fvlw
 1dWS/8FWOgCtAu+Vha/Lb9Uhutsr8v/2HvXB52Bg==
X-Received: by 2002:a05:701b:2816:b0:1a0:f970:4f5d with SMTP id
 a92af1059eb24-1ac5bda42d5mr14821241c88.17.1793643387003; 
 Mon, 02 Nov 2026 10:16:27 -0800 (PST)
X-Received: by 2002:a05:701b:2816:b0:1a0:f970:4f5d with SMTP id
 a92af1059eb24-1ac5bda42d5mr14821202c88.17.1793643386272; 
 Mon, 02 Nov 2026 10:16:26 -0800 (PST)
Received: from ?IPV6:2401:4900:1f2d:bd1d:fc33:324:5225:5efd?
 ([2401:4900:1f2d:bd1d:fc33:324:5225:5efd])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23b847348sm1843821c88.4.2026.11.02.10.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 10:16:25 -0800 (PST)
Message-ID: <fb1270cd-f0b4-4181-bc6f-57debae4d51a@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 23:46:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] phy: qcom: add QMP USB3 PHY driver for Shikra
To: Neil Armstrong <neil.armstrong@linaro.org>, casey.connolly@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-6-aswin.murugan@oss.qualcomm.com>
 <1a3bfe51-c21b-401e-ac72-d12a7a6f15d8@linaro.org>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <1a3bfe51-c21b-401e-ac72-d12a7a6f15d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3MiBTYWx0ZWRfX/d9P9Gm8/8RN
 7pBCdVG6ejHlF27OLt2oayLv48/69aUrBCcdneZCALW796t7bxFUHdlTOa+ZjcHd7/zu24l1x9U
 AvZhtIpmG4JNuUa2dnpLfZNjvisyp2jeJmgbh3ytLU+NtWhsyNahb55QGioN6uRX2ozxUm67mNY
 Xk3v2aMesfpWupSfydh1DNiCvhCEwKz07WP9EImNQDztgSn0SPHbqc/BNWAkhXe1dFXuxv2ybXE
 4GnEZEfMS/MYk+k0hyvd/alhr9RAbVKPrJvvNutDf6IyqKRrT7HEmx+HerflOOjyIzIZJvxiMwd
 gOT6YsNllY+kX8MyQLu1qftNEQssq5Gw5956EpJmh+mFqKLJzcvFgXUkxX5fH5UwJ2MVHwbIr25
 KeILT1jgV47WBewh77FJQ47JwXjbP61i2xmvIH6bet+CNdUTwGVgK0nTzC4Ry2cv/lJp/YVua3d
 OPjwFXKxLedvckQ9jHA==
X-Proofpoint-GUID: 06i4LF9KKOnOTJLhI87satNJvVxyqqlR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3MiBTYWx0ZWRfX3qRfE5tduKS7
 p3levKBC6wtViA1ZjXQPAGhChcNrVly/rRZkX8kQk6qEKtVDDLK3Q5TaH6W8EbD8DlqHLwQ43ei
 aBZmGuYuPxO5W3nwrPi5s9kbtRT8/88=
X-Proofpoint-ORIG-GUID: 06i4LF9KKOnOTJLhI87satNJvVxyqqlR
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae8d37c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=iG00HmjbxPVAyK0iPWwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020072
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

Hi Neil,

On 10/22/2026 1:17 PM, neil.armstrong@linaro.org wrote:
> Hi,
>
> On 10/21/26 18:09, Aswin Murugan wrote:
>> Shikra USB3 QMP PHY uses a single-PHY DT binding (#phy-cells = <0>),
>> which is not supported by the existing QMP combo PHY driver.
>>
>> Add a dedicated USB3-only QMP PHY driver for Shikra, porting the PHY
>> initialization sequence and configuration tables from Linux
>> drivers/phy/qualcomm/usbphy-qcom-qmp-c.c. The driver is selected
>> through PHY_QCOM_QMP_USB3_LEGACY and enables USB3 PHY bring-up on
>> Shikra platforms.
>
> Why LEGACY ? While looking at the Linux patches, I only found [1] 
> which adds
> the usb-dp phy in the usbc driver (qcom,shikra-qmp-usb3-dp-phy).
> Add a proper "phy-qcom-qmp-usbc.c" like on Linux and name it USBC 
> instead of LEGACY.
>
> [1] 
> https://lore.kernel.org/all/20260712-usb-shikra-phy-v6-v6-0-1b3e51bf1541@oss.qualcomm.com/
>
The intent behind "LEGACY" naming was that it's a stripped-down version 
of phy-qcom-qmp-usbc.c - USB3-only, without the DP/Type-C combo logic, 
since we doesn't need it. But I agree that's not a great name since it 
collides with the actual phy-qcom-qmp-usb-legacy.c driver upstream, 
which is a different thing entirely. Will rename to phy-qcom-qmp-usbc.c 
/ PHY_QCOM_QMP_USBC in v5.

Thanks,
Aswin

>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>   drivers/phy/qcom/Kconfig                    |   7 +
>>   drivers/phy/qcom/Makefile                   |   1 +
>>   drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c | 534 ++++++++++++++++++++
>>   3 files changed, 542 insertions(+)
>>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
>>
>> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
>> index 1fdadaccb12..ffb523fffbb 100644
>> --- a/drivers/phy/qcom/Kconfig
>> +++ b/drivers/phy/qcom/Kconfig
>> @@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
>>       help
>>         Enable this to support the UFS QMP PHY on various Qualcomm 
>> chipsets.
>>   +config PHY_QCOM_QMP_USB3_LEGACY
>> +    bool "Qualcomm QMP USB3-only legacy PHY driver"
>> +    depends on PHY && ARCH_SNAPDRAGON
>> +    help
>> +      Enable this to support the legacy USB3-only QMP PHY (v3) found on
>> +      older Qualcomm chipsets such as QCM2290/QCS615 and derivatives.
>> +
>>   config PHY_QCOM_QUSB2
>>       bool "Qualcomm USB QUSB2 PHY driver"
>>       depends on PHY && ARCH_SNAPDRAGON
>> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
>> index 714013dc572..dfad1f1e56a 100644
>> --- a/drivers/phy/qcom/Makefile
>> +++ b/drivers/phy/qcom/Makefile
>> @@ -3,6 +3,7 @@ obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>>   obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
>>   obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
>>   obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
>> +obj-$(CONFIG_PHY_QCOM_QMP_USB3_LEGACY) += phy-qcom-qmp-usb3-legacy.o
>>   obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
>>   obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
>>   obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
>> diff --git a/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c 
>> b/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
>> new file mode 100644
>> index 00000000000..d1aad6e7952
>> --- /dev/null
>> +++ b/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
>> @@ -0,0 +1,534 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <clk.h>
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <dm/devres.h>
>> +#include <dm/uclass.h>
>> +#include <generic-phy.h>
>> +#include <reset.h>
>> +#include <power/regulator.h>
>> +#include <usb/tcpm.h>
>> +#include <asm/io.h>
>> +#include <linux/bitops.h>
>> +#include <linux/compat.h>
>> +#include <linux/delay.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/err.h>
>> +
>> +#include "phy-qcom-qmp-common.h"
>> +
>> +#include "phy-qcom-qmp.h"
>> +#include "phy-qcom-qmp-pcs-misc-v3.h"
>> +
>> +/* QPHY_V3_PCS_MISC_TYPEC_CTRL-equivalent bit, legacy USB3-only PHY */
>> +#define SW_PORTSELECT_MUX            BIT(1)
>> +#define SW_PORTSELECT_VAL            BIT(0)
>> +
>> +#define PHY_INIT_COMPLETE_TIMEOUT        10000
>> +
>> +#define RESET_SETTLE_DELAY_US            10
>> +
>> +struct qmp_usb3_legacy_offsets {
>> +    u16 serdes;
>> +    u16 tx;
>> +    u16 rx;
>> +    u16 tx2;
>> +    u16 rx2;
>> +    u16 pcs;
>> +    u16 pcs_misc;
>> +};
>> +
>> +static const struct qmp_usb3_legacy_offsets 
>> qmp_usb3_legacy_offsets_qcm2290 = {
>> +    .serdes        = 0x000,
>> +    .tx        = 0x200,
>> +    .rx        = 0x400,
>> +    .tx2        = 0x600,
>> +    .rx2        = 0x800,
>> +    .pcs_misc    = 0xa00,
>> +    .pcs        = 0xc00,
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcm2290_usb3_serdes_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL2, 0x08),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_INITVAL, 0x80),
>> +    QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CTRL_BY_PSM, 0x01),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcm2290_usb3_tx_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x00),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcm2290_usb3_rx_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x80),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FO_GAIN, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x06),
>> + QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0a),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x00),
>> +    QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x00),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
>> +    QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
>> +};
>> +
>> +/* Per-compatible config; add a new instance here to support another 
>> SoC */
>> +struct qmp_usb3_legacy_cfg {
>> +    const struct qmp_usb3_legacy_offsets *offsets;
>> +
>> +    const struct qmp_phy_init_tbl *serdes_tbl;
>> +    int serdes_tbl_num;
>> +    const struct qmp_phy_init_tbl *tx_tbl;
>> +    int tx_tbl_num;
>> +    const struct qmp_phy_init_tbl *rx_tbl;
>> +    int rx_tbl_num;
>> +    const struct qmp_phy_init_tbl *pcs_tbl;
>> +    int pcs_tbl_num;
>> +
>> +    /* clock names fetched by clk_get_by_name(); "pipe" is fetched 
>> separately */
>> +    const char * const *clk_list;
>> +    int num_clks;
>> +
>> +    const char * const *vreg_list;
>> +    int num_vregs;
>> +};
>> +
>> +static const char * const shikra_usb3_clk_l[] = {
>> +    "cfg_ahb", "ref", "com_aux",
>> +};
>> +
>> +static const struct qmp_usb3_legacy_cfg shikra_usb3phy_cfg = {
>> +    .offsets    = &qmp_usb3_legacy_offsets_qcm2290,
>> +    .serdes_tbl    = qcm2290_usb3_serdes_tbl,
>> +    .serdes_tbl_num    = ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
>> +    .tx_tbl        = qcm2290_usb3_tx_tbl,
>> +    .tx_tbl_num    = ARRAY_SIZE(qcm2290_usb3_tx_tbl),
>> +    .rx_tbl        = qcm2290_usb3_rx_tbl,
>> +    .rx_tbl_num    = ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>> +    .pcs_tbl    = qcm2290_usb3_pcs_tbl,
>> +    .pcs_tbl_num    = ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> +    .clk_list    = shikra_usb3_clk_l,
>> +    .num_clks    = ARRAY_SIZE(shikra_usb3_clk_l),
>> +    .vreg_list    = NULL,
>> +    .num_vregs    = 0,
>> +};
>> +
>> +static const char * const talos_usb3_clk_l[] = {
>> +    "aux", "ref", "cfg_ahb",
>> +};
>> +
>> +static const char * const talos_usb3_vreg_l[] = {
>> +    "vdda-phy-supply", "vdda-pll-supply",
>> +};
>> +
>> +static const struct qmp_usb3_legacy_cfg talos_usb3phy_cfg = {
>> +    .offsets    = &qmp_usb3_legacy_offsets_qcm2290,
>> +    .serdes_tbl    = qcm2290_usb3_serdes_tbl,
>> +    .serdes_tbl_num    = ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
>> +    .tx_tbl        = qcm2290_usb3_tx_tbl,
>> +    .tx_tbl_num    = ARRAY_SIZE(qcm2290_usb3_tx_tbl),
>> +    .rx_tbl        = qcm2290_usb3_rx_tbl,
>> +    .rx_tbl_num    = ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>> +    .pcs_tbl    = qcm2290_usb3_pcs_tbl,
>> +    .pcs_tbl_num    = ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> +    .clk_list    = talos_usb3_clk_l,
>> +    .num_clks    = ARRAY_SIZE(talos_usb3_clk_l),
>> +    .vreg_list    = talos_usb3_vreg_l,
>> +    .num_vregs    = ARRAY_SIZE(talos_usb3_vreg_l),
>> +};
>> +
>> +struct qmp_usb3_legacy {
>> +    struct udevice *dev;
>> +    void __iomem *serdes;
>> +    void __iomem *tx;
>> +    void __iomem *rx;
>> +    void __iomem *tx2;
>> +    void __iomem *rx2;
>> +    void __iomem *pcs;
>> +    void __iomem *pcs_misc;
>> +    struct clk *clks;
>> +    struct clk pipe_clk;
>> +    int num_clks;
>> +    struct reset_ctl_bulk resets;
>> +    struct udevice **vregs;
>> +    int num_vregs;
>> +    const struct qmp_usb3_legacy_cfg *cfg;
>> +};
>> +
>> +static inline void qphy_setbits(void __iomem *base, u32 offset, u32 
>> val)
>> +{
>> +    u32 reg;
>> +
>> +    reg = readl(base + offset);
>> +    reg |= val;
>> +    writel(reg, base + offset);
>> +    readl(base + offset);
>> +}
>> +
>> +static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 
>> val)
>> +{
>> +    u32 reg;
>> +
>> +    reg = readl(base + offset);
>> +    reg &= ~val;
>> +    writel(reg, base + offset);
>> +    readl(base + offset);
>> +}
>> +
>> +/* Quiesce the PHY; shared by power_off() and power_on()'s error 
>> path */
>> +static void qmp_usb3_legacy_quiesce(struct qmp_usb3_legacy *qmp)
>> +{
>> +    qphy_clrbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | 
>> PCS_START);
>> +    qphy_setbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
>> +    qphy_clrbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
>> +}
>> +
>> +/* Fixed orientation by default; use TCPM orientation if available */
>> +static u32 qmp_usb3_legacy_get_portselect(struct qmp_usb3_legacy *qmp)
>> +{
>> +    u32 val = SW_PORTSELECT_MUX;
>> +
>> +    if (IS_ENABLED(CONFIG_TYPEC_TCPM)) {
>> +        struct udevice *tcpm_dev;
>> +        enum typec_orientation orientation;
>> +        int ret;
>> +
>> +        ret = uclass_first_device_check(UCLASS_TCPM, &tcpm_dev);
>> +        if (!ret && tcpm_dev) {
>> +            orientation = tcpm_get_orientation(tcpm_dev);
>> +            if (orientation == TYPEC_ORIENTATION_REVERSE)
>> +                val |= SW_PORTSELECT_VAL;
>> +        }
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static int qmp_usb3_legacy_power_on(struct phy *phy)
>> +{
>> +    struct qmp_usb3_legacy *qmp = dev_get_priv(phy->dev);
>> +    const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
>> +    void __iomem *status;
>> +    u32 val;
>> +    int ret;
>> +
>> +    qphy_setbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
>> +
>> +    writel(qmp_usb3_legacy_get_portselect(qmp), qmp->pcs_misc);
>> +
>> +    qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl, 
>> cfg->serdes_tbl_num);
>> +
>> +    ret = clk_enable(&qmp->pipe_clk);
>> +    if (ret) {
>> +        dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    qmp_configure_lane(qmp->dev, qmp->tx, cfg->tx_tbl, 
>> cfg->tx_tbl_num, 1);
>> +    qmp_configure_lane(qmp->dev, qmp->rx, cfg->rx_tbl, 
>> cfg->rx_tbl_num, 1);
>> +
>> +    qmp_configure_lane(qmp->dev, qmp->tx2, cfg->tx_tbl, 
>> cfg->tx_tbl_num, 2);
>> +    qmp_configure_lane(qmp->dev, qmp->rx2, cfg->rx_tbl, 
>> cfg->rx_tbl_num, 2);
>> +
>> +    qmp_configure(qmp->dev, qmp->pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>> +
>> +    qphy_clrbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
>> +
>> +    qphy_setbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | 
>> PCS_START);
>> +
>> +    status = qmp->pcs + QPHY_V3_PCS_PCS_STATUS;
>> +    ret = readl_poll_timeout(status, val, !(val & PHYSTATUS),
>> +                 PHY_INIT_COMPLETE_TIMEOUT);
>> +    if (ret) {
>> +        dev_err(qmp->dev, "phy initialization timed-out\n");
>> +        clk_disable(&qmp->pipe_clk);
>> +        qmp_usb3_legacy_quiesce(qmp);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qmp_usb3_legacy_power_off(struct phy *phy)
>> +{
>> +    struct qmp_usb3_legacy *qmp = dev_get_priv(phy->dev);
>> +
>> +    clk_disable(&qmp->pipe_clk);
>> +    qmp_usb3_legacy_quiesce(qmp);
>> +
>> +    return 0;
>> +}
>> +
>> +static void qmp_usb3_legacy_clk_disable_upto(struct qmp_usb3_legacy 
>> *qmp, int upto)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < upto; i++)
>> +        clk_disable(&qmp->clks[i]);
>> +}
>> +
>> +static int qmp_usb3_legacy_clk_init(struct qmp_usb3_legacy *qmp)
>> +{
>> +    const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
>> +    struct udevice *dev = qmp->dev;
>> +    int num = cfg->num_clks;
>> +    int i, ret;
>> +
>> +    qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
>> +    if (!qmp->clks)
>> +        return -ENOMEM;
>> +
>> +    qmp->num_clks = 0;
>> +
>> +    for (i = 0; i < num; i++) {
>> +        ret = clk_get_by_name(dev, cfg->clk_list[i], &qmp->clks[i]);
>> +        if (ret) {
>> +            dev_err(dev, "failed to get %s clock: %d\n",
>> +                cfg->clk_list[i], ret);
>> +            qmp_usb3_legacy_clk_disable_upto(qmp, i);
>> +            return ret;
>> +        }
>> +
>> +        ret = clk_enable(&qmp->clks[i]);
>> +        if (ret) {
>> +            dev_err(dev, "failed to enable %s clock: %d\n",
>> +                cfg->clk_list[i], ret);
>> +            qmp_usb3_legacy_clk_disable_upto(qmp, i);
>> +            return ret;
>> +        }
>> +    }
>> +    qmp->num_clks = num;
>> +
>> +    ret = clk_get_by_name(dev, "pipe", &qmp->pipe_clk);
>> +    if (ret) {
>> +        dev_err(dev, "failed to get pipe clock: %d\n", ret);
>> +        qmp_usb3_legacy_clk_disable_upto(qmp, qmp->num_clks);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qmp_usb3_legacy_vreg_init(struct qmp_usb3_legacy *qmp)
>> +{
>> +    const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
>> +    struct udevice *dev = qmp->dev;
>> +    int i, ret;
>> +
>> +    qmp->num_vregs = 0;
>> +
>> +    if (!cfg->num_vregs)
>> +        return 0;
>> +
>> +    qmp->vregs = devm_kcalloc(dev, cfg->num_vregs, 
>> sizeof(*qmp->vregs), GFP_KERNEL);
>> +    if (!qmp->vregs)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < cfg->num_vregs; i++) {
>> +        ret = device_get_supply_regulator(dev, cfg->vreg_list[i], 
>> &qmp->vregs[i]);
>> +        if (ret) {
>> +            dev_err(dev, "failed to get regulator %s: %d\n",
>> +                cfg->vreg_list[i], ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    qmp->num_vregs = cfg->num_vregs;
>> +    return 0;
>> +}
>> +
>> +static int qmp_usb3_legacy_vreg_enable(struct qmp_usb3_legacy *qmp)
>> +{
>> +    int i, ret;
>> +
>> +    for (i = 0; i < qmp->num_vregs; i++) {
>> +        ret = regulator_set_enable(qmp->vregs[i], true);
>> +        if (ret) {
>> +            dev_err(qmp->dev, "failed to enable regulator %d: %d\n", 
>> i, ret);
>> +            while (--i >= 0)
>> +                regulator_set_enable(qmp->vregs[i], false);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void qmp_usb3_legacy_vreg_disable(struct qmp_usb3_legacy *qmp)
>> +{
>> +    int i;
>> +
>> +    for (i = qmp->num_vregs - 1; i >= 0; i--)
>> +        regulator_set_enable(qmp->vregs[i], false);
>> +}
>> +
>> +static int qmp_usb3_legacy_parse_dt(struct qmp_usb3_legacy *qmp)
>> +{
>> +    const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
>> +    const struct qmp_usb3_legacy_offsets *offs = cfg->offsets;
>> +    struct udevice *dev = qmp->dev;
>> +    void __iomem *base;
>> +    int ret;
>> +
>> +    base = (void __iomem *)dev_read_addr(dev);
>> +    if (IS_ERR(base))
>> +        return PTR_ERR(base);
>> +
>> +    qmp->serdes = base + offs->serdes;
>> +    qmp->tx = base + offs->tx;
>> +    qmp->rx = base + offs->rx;
>> +    qmp->tx2 = base + offs->tx2;
>> +    qmp->rx2 = base + offs->rx2;
>> +    qmp->pcs = base + offs->pcs;
>> +    qmp->pcs_misc = base + offs->pcs_misc;
>> +
>> +    ret = qmp_usb3_legacy_vreg_init(qmp);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = qmp_usb3_legacy_vreg_enable(qmp);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = reset_get_bulk(dev, &qmp->resets);
>> +    if (ret) {
>> +        dev_err(dev, "failed to get resets: %d\n", ret);
>> +        goto err_disable_vregs;
>> +    }
>> +
>> +    ret = reset_assert_bulk(&qmp->resets);
>> +    if (ret) {
>> +        dev_err(dev, "failed to assert resets: %d\n", ret);
>> +        goto err_disable_vregs;
>> +    }
>> +
>> +    udelay(RESET_SETTLE_DELAY_US);
>> +
>> +    ret = reset_deassert_bulk(&qmp->resets);
>> +    if (ret) {
>> +        dev_err(dev, "failed to deassert resets: %d\n", ret);
>> +        goto err_assert_resets;
>> +    }
>> +
>> +    ret = qmp_usb3_legacy_clk_init(qmp);
>> +    if (ret)
>> +        goto err_assert_resets;
>> +
>> +    return 0;
>> +
>> +err_assert_resets:
>> +    reset_assert_bulk(&qmp->resets);
>> +err_disable_vregs:
>> +    qmp_usb3_legacy_vreg_disable(qmp);
>> +
>> +    return ret;
>> +}
>> +
>> +static int qmp_usb3_legacy_probe(struct udevice *dev)
>> +{
>> +    struct qmp_usb3_legacy *qmp = dev_get_priv(dev);
>> +
>> +    qmp->dev = dev;
>> +    qmp->cfg = (const struct qmp_usb3_legacy_cfg 
>> *)dev_get_driver_data(dev);
>> +    if (!qmp->cfg) {
>> +        dev_err(dev, "failed to get PHY configuration\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return qmp_usb3_legacy_parse_dt(qmp);
>> +}
>> +
>> +static struct phy_ops qmp_usb3_legacy_ops = {
>> +    .power_on = qmp_usb3_legacy_power_on,
>> +    .power_off = qmp_usb3_legacy_power_off,
>> +};
>> +
>> +static const struct udevice_id qmp_usb3_legacy_ids[] = {
>> +    {
>> +        .compatible = "qcom,shikra-qmp-usb3-phy",
>> +        .data = (ulong)&shikra_usb3phy_cfg,
>> +    },
>> +    { }
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_qmp_usb3_legacy_phy) = {
>> +    .name = "qcom-qmp-usb3-legacy-phy",
>> +    .id = UCLASS_PHY,
>> +    .of_match = qmp_usb3_legacy_ids,
>> +    .ops = &qmp_usb3_legacy_ops,
>> +    .probe = qmp_usb3_legacy_probe,
>> +    .priv_auto = sizeof(struct qmp_usb3_legacy),
>> +};
>
