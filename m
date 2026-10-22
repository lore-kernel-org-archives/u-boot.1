Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCE606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vFl1PPdI;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TxpL+hpN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gt7C5MaS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9410A812D1;
	Thu, 22 Oct 2026 22:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xzFznuaCvnC; Thu, 22 Oct 2026 22:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBFB481316
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792706441;
	b=okbcqgbG1rq7YY4JyS1tn7ytxE3eKMWH9PReBDR2DwIMdjrvq133qvNZuxa1TRlPPVYG
	 divb5LKSmcRhUnrp5vutI+VYeVGJLWppY/CoM40jZwcEVPHrRzQjnJHfcWq+0uoNFgyTk
	 wE4G6Nd7wSUTEPFxYqVnRxECUKzyA6EtyH/Nm6AESjvjzKfKBmcHK6OBrq9I8ZLFD+ITd
	 g1JdRH61s0fiCc5S2zWHmkYldSQCsaCAUkjeBh28Tjaq9Z/xYIuiyhEIRLdYXhucnNknx
	 82yJoeuOuxEC+AGujasyvt/AND2A+MR81HMflS7+smnIlB1Ev98VCFj+UOYn/iM3Y1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792706441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ftHkYZRcMQHU+b89g6o2LPiFkMd11hQcYYwF3kY/IKs=;
	b=ETuy0V83/MX133hmHf+QDxhRebOUPE7bfkW0p5VkeggyJXdN9RaEj3ekyr9xYfimAhhX
	 7vSB9UXVBQRsghQ4pErnjiQhb7Ba24Nle/DW5Fa0fKA0iLdby9SMrFcvRjI0nb3gbYixj
	 ZnYUTL33qGrKjcdpy7RgOW9kTvc7p8W8wGYrg5zXH3iUJgIKKIZdyhqxkJ7XDk1VywwOJ
	 V/BTsUvFRP8ksdfKBeBH9nTH1MuN+utSYTsaxsUT+wMWMV48xqckUGSevJJrNjGkvBbM+
	 NH2hKb2QAIUetbytO3qOslmEroZz2qbYpuG1n37OeKaZK1GxHarMFYjnajlH24qqEnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TxpL+hpN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gt7C5MaS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792706441;
	bh=ftHkYZRcMQHU+b89g6o2LPiFkMd11hQcYYwF3kY/IKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vFl1PPdIDingiJgMH9gxzWFRkH1SNn8Q0/S8Ic1dUgKYhQxiKV6NaVI22K5quFbdf
	 p+sSSmnnUVxgPueBmblumY4Vg+fPz1H2b/lfJB0cCiFsSx8euDQgv2SERxYv55P0lY
	 9L3k5MHtUWGnmRSu5f5CasE2e5msk/EwAEie3Ly4g6cPPpCv+7wmT+ry9yUaplX+JU
	 vUKwi6dB++JNGhmPKs8yizbXifyMnn5/HNOai+ZadMb4qmscXz7jbmgOBWywRTMxU+
	 FeuJGj2JWTXadCbtYL+OJuJcYh707SP8cRHyo7rhTN9PB6R3RN/yY9iekDc5UeKfGz
	 oGKpw/dqlaqOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBFB481316;
	Thu, 22 Oct 2026 22:00:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9D03A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB72A81316
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKkk3rMyJ36O for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:00:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36FB6812D1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792706437;
 b=nJapHHi1YdTCJ4Wr5NyNJhaIMcRaNBrEQx4mYe61WyjUoxjwXlTOihjjGl7r6VgSlLbq
 9hb017a5eL+Hqd1LC6SGKdehCmVBZ8jQ5OX+Npw0qWnYZtitrWWbi0l/1hVzOP2nlPrvM
 /HV1cjUFGwP8OON/SlGCqK/+MXNOIU+9pNqPwFi9PsltUq6pErsdKjlugYQS0q0kVWyCh
 UZvJ2b6hJK3AI23qbOjsorBbmf4s3H5ThdLaiA4eIXJHtot8WjiVTAnKzZ4cJeBU1uUEs
 WchMxab644vON9ynhsUssolREaRJSm66V5/7lYPzgxYUJYfF0IiEa7x5yEq50PEVueA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792706437;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ftHkYZRcMQHU+b89g6o2LPiFkMd11hQcYYwF3kY/IKs=;
 b=rRKgPXtuF6FGZ+KJ/hFhybRzKmGc1bjELFQL5/9gx4KOgfYcOYrs9vED3MfQ6VT+NBcD
 t6S1aqcVzFBD/k8A3w1EVv2c3Gptwu00gVcAZHHh8q4oTcWNd4tjPBpdwCctuj6JYzuwk
 qPq47J0jZhbFK3VJppnxXiMiV5aQN+6HpOHWGJHXBgSA7wDKfOCjXuVmJDsU1EaO0BFtn
 gfzoi8PfDAEw1yGEVyY0nyi+SX8X2GTUNMI8ohdT9SCXoj/9KPkoPYBMUlAh/2tQIvymC
 vgAZ+KC3Xl1c2DCKDBlu8NFsS93fXS/oVDpBhmsB3yxZZhkyxxX90h/qqF5VE7MBnbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TxpL+hpN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gt7C5MaS; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TxpL+hpN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gt7C5MaS
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36FB6812D1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHEkP3741710
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ftHkYZRcMQHU+b89g6o2LPiFkMd11hQcYYwF3kY/IKs=; b=TxpL+hpNXLZFaElO
 aCSvzFof/vn+fBmcRzNPp5CmgQtGe8cvzELt0qAnCg1uMQ7AAp4DI/sNMtRCvrLA
 NX4MluWpY5gGIbqmW7HP/G1aYuYgGOQp+m0jrvRhT0Gr52mNGM0/sPXlUUpthMqG
 S3sM1WP7biteB9sLF/aY4GUzfh8sCN4bfe80n2yCCzX3uMbAaCupxZjxltUuTUv9
 sj3L+3GzqWskh4rySRaYdVFHlgDxq1qY98tAokwk3FbOjnUZ0XmNTULtyundN7be
 TQL49GbpD+3VIn337L8Z+djN+TH8O3261SW8YmE5jny6Xq+8tTtkGgKnkH67QawW
 cF61pg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0qkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:00:36 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b0e757e70eso5327857b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706435; x=1793311235;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ftHkYZRcMQHU+b89g6o2LPiFkMd11hQcYYwF3kY/IKs=;
 b=Gt7C5MaSWtdI6bGveSm+4YDHAofxtHu4n6Rf48JmHZE3E2SVygLaooufDlOasf0lWf
 5KbbZNor8SQKTW4H18qR/HrmR2XyUgEluwJpvQdKGs3BF/5QKfNxlEdAKlbEjcYfs5Nn
 +bCWYPuKKdb4LzyO1YxtdZz23I7o5zOtaCotqX0ZpA387yluhSZuL+9liz6Ojj2y9sBe
 ISKIbmlX8wSo91F7nqwj59oANK8Wpip3pHePvZOcORa2RTfqTcpM/liLGmK9TbSSZsm0
 7VABQPpI7aRcSdpp8PI4G4a29V0dhrAJfF7uli557kWVeE8s4MtynGD6uQIBfsxTeTGs
 xqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706435; x=1793311235;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ftHkYZRcMQHU+b89g6o2LPiFkMd11hQcYYwF3kY/IKs=;
 b=Y9vwH1rcpfi+EM0Nel6oiVotjvg3LYCMqj7CF3qcMjLDJK7TjDEqBoYizIzkEgmGJj
 gRawnkjv8SnbwBK73lliHoM7jTjHQWt/JIxOhyJxqYx1tHd8sCpzHm0lej+7Y5ebrG1I
 2W9nM7SxsaaOEqf+Q8gB783WrEEJ/jYInkCfhklKPiBt4Wg0N5I6OLxRqpqLcIwsSpcw
 YCfcUyKRznjWJSzFDVAShYXS1nuUMASc0Xo2t0GJSNNkzoTHjKErEsGe+cSzifOS2Wa/
 V8vJGQrt/ubuAjPhZwgWfrFPSZ2myw3CelkncF8lXHNGHKhG/gJbOtQki2QL6ZDOYnMF
 ltSA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWq7kA0RAX6rkiEcMqDBJBDq9ZMl/smZrjuKM9O1WWof96J3aW0HREX0Qmdb5/eZYOFrD/9zg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI5tDBnwAz2hAWD6ugQkAqdK2cKi5vHpxEEo9KGe51YG8EhtjIB
 yJGUeTb2UTNJXwIK2Whk95XeqnuPcKm5vDYceGrE25oogTnWXCzeNLlO8BNujMvADIM1NGgyfgt
 CGq1VDhHw9xyA/S7dt1+MUJzscSPQiqBzE9zNvlK+pmTPqI6H1Sx3Hi/ejSxqiyQyFNvmb3A=
X-Gm-Gg: AYBFou0lpjGr6YNC2hTNmoJQdAQFehr0uuB4zMehbd9iEPqvO6i9kgWmYW2apj6FMgQ
 aXtEPaRZfw5Lxc6erQbfuJlFPXYmEJoh5y+YuY60QPblV6ds9S37K/LI8qPF24/ZExeckuWVdPu
 Iz1cSAi4USTiCb6EKrKzxh7Fj2F6fYBJUAhu12iQ7KdYPcV0/khb5ig1EtgpC0dIq1wbX38rHKj
 wfJXfvhRGWiMseG4yZVPqsSECLKRl5xcAOHQdY4ujTA2yqgrbWUAMaNT7QtYuLTLksJNz3JnfIV
 br0dtyqqhKJb25bGc9Syl1JMu1O0EPx9vZKC+5ciBS3zglBuH5kr7gAm6dPInTCMp0c/QKLpV4Y
 9DY+vdGdBPVcFi3F8Etywm80wMXpCOblNiI6alxRvavkYquv1wqnqrN4vtA8s
X-Received: by 2002:a05:690c:e181:10b0:8b0:6a3a:9aa3 with SMTP id
 00721157ae682-8b157e09774mr1903427b3.52.1792706435110; 
 Thu, 22 Oct 2026 15:00:35 -0700 (PDT)
X-Received: by 2002:a05:690c:e181:10b0:8b0:6a3a:9aa3 with SMTP id
 00721157ae682-8b157e09774mr1903267b3.52.1792706434561; 
 Thu, 22 Oct 2026 15:00:34 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b1560cd2dbsm4751267b3.7.2026.10.22.15.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:00:34 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/5] pinctrl: qcom: Add QCS8300 pinctrl driver
Date: Thu, 22 Oct 2026 18:00:31 -0400
Message-ID: <20261022220031.784390-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021-b4-monaco-v4-3-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
 <20261021-b4-monaco-v4-3-c90f0c01d312@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX9zFNJe+EkzxX
 bwMChmM754ZLhVqzQWjQXE7HDad8oTa3UjuUbYFRuWXGLVSNf7Ce91Aya0kXjhnUdXW5v978obk
 JqsTHFfSB9MjO8HAUKYrjahXwLRBqOpGDCutcsxagNwxIekbZIIS/Z7cnB87QH8xuym/90g0hLJ
 LtGXLWKNBIduChjGIAbVsOKcFpZDsgwuBVRvcuDtT54HpvL+glCBOPXVA5ah7ARh3Ge95d2UIQ8
 Xp/7XnxOg3+1SkCm62xrHd5BXsM0rMDoDYwhsXHzYEDkncg1D0p+1sNMNWkjIa8oje0xMYBf9Oj
 XXiEDlZmWk7nxNm4+JGPT5WqIbXETsvbW2t9630NwnBOfcBkAbxfwSFcnsU3AJr6nwd4blLDQsE
 lWGhnI7ApcbaspyrVnZy03XypjA+a0a/yLcooon4E4+T7/sIs2a5VXt7lVfv0CPHSk3PVWbhEMS
 gz2K1sUAx9Ink2Su4qA==
X-Proofpoint-GUID: -Pm8gUOyigyzQ-etzdBB8pW3AKKkuYgN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6XUFxtAq+qTW
 iFUQIxrLTHv2A9uIMDATiU8LzXQkT85AbgafRTEqYXjE3NmZX0ILyQWsVVMh+LKoFERJb63IqcP
 IFlfg6w6CwDzisQ/4wFRlyrXLJMwoUA=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada8784 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=sOnDfXEmMANyBQqeG2kA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: -Pm8gUOyigyzQ-etzdBB8pW3AKKkuYgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 12:13, Balaji Selvanathan wrote:
Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
