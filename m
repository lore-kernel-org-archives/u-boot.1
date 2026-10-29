Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B269606A321
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TnV1AjlZ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=podNdfNy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BUbrnuPE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36A2F8108A;
	Thu, 29 Oct 2026 10:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KTTrlQsWGCQ; Thu, 29 Oct 2026 10:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5109D8104C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271502;
	b=OzoEccTSLATf3OSf2gqmxvm96QeYwCwhndDPmFHPKv2RU1+vyaM8kYMEsHhRMWxXEcGU
	 KIOTV9I5MAzqj6+lbfdiHAZfJefW4+NLxGpy7NqYwPJTitNwpVKsECOFmeg+hije3OYw0
	 lzfOEewG/4g3raQ6lENi9XkkxIYPq5iqahrVCYrCuM5TZmIOfeQAO2Cq5favrAW1hAG9y
	 rXF4c6EPX2RSozeiFw7Sf0rjhzInOZ/LVVWefj8cNMgH1hOHILoyg4QpqJxkiLKIGRDgR
	 6tFCq5bLRtArm1x2A7UGKDOOniFNKaXWuZ5GuXf6kiaFzziNOJ5dVVKo1xTuHSXPokQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	b=o36qqf3VH8v6CFP54TXhbd+t8cqrChYs7zTrBE3Ryn53TMk30fyDY/wvJx2mUg6OFEiw
	 6VGvLRVcdfYWYq2EJfjx+C2afDEQmgjEtojUoLLffTOLgesxXwA4HvGDcsKSl4qFe6r1F
	 37zKUjL5PTyCL1+aFQBJh923nqrGKQLorUbwOnVGIakqcUweh4kyt8S3ndl35i0JJ6FxQ
	 koI9TNa1/gy56tnqKqWFix5Usz63R/4KdK+shMJpzF+ukf0KP7yBC557kiRTrj76LsASy
	 CmH6p9E7tmv7IQVdc+cRGUXaRZpQGJAdIT6M3AIfx/AcJzxnl4gcWhIorgZ5G95LsOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271502;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TnV1AjlZ8dwKEl5uJqzEJcp5+6PmefH8/n9R/km3NJQE6vWHT+droGkfbDZ8VS18N
	 HkQencB1x6edLrAE7gE848ikxJlEZFuKfnkFezoEESO8JDMYb3F7krmFqbzKLm3tvG
	 13wwjtS5yojEPCbHr4jcp6Cn58oZfj1Lm/2wI9hjNqIS+DTres9nDFwJnWAGqfEyZa
	 1vHdho3X7K2hhLKWCnPbHs/hgyFhbziqorBMZjZzn3e8z2D47dN4BmUBxCDOm36C9b
	 AVqc+1BVnspqYKI7EYFP7WTXpxke9Mu73BtYF2itgSjezkip08mEs/+QJ0GoENFOgA
	 TE0DF8Oq7nRig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5109D8104C;
	Thu, 29 Oct 2026 10:58:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7B23334
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 964BC407C8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSrAIalQSZny for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E53FC40764
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271486;
 b=K1J1rBtP9cN2jW/AD1eKXHTbcw9vZ35l4jbv/OpC0tMe/K/uJqLVwniEQ/M2Z7JcA4Ld
 sUZqhonzeOJjiwTwYQkVGw341qRcIJ9HoLgIr4hIJPlq1nCNXP0f182XM1bD5s0MLx7G/
 NDjJQXuMipW4kEevpYtRXmXfPqDM4Oz3qcOpjB/vhWHGjhmZImx+XV8BCIEDH1eZJ3wcH
 EXoYaxTCLnPQjWJR7Bb+wCdyLw5hSZJmnkxGUL7nG9PgfAGODP9V9IGtTE7Xad6TqFEsk
 vb7mmqgUfnV7MqN2UDEEnMaqc/JTVh6ikpXD/ZvfjkkjAJv7i73iL80rv368VoT8N2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271486;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=h0UabwPSYnjixsPSXRYNSCLNBxjJvYYS61dYT7aY14fQvnf5JUwC0lscuMK0bDdwn+aF
 /1o4PWHdK41ypEnLLLJ2Jplp+mYqfokv03iwqJ/SZC22emf2CVyc5ui+eSTv26dctHXoF
 JGuTCa16bK2u8DmtVReOiCw1YG//tWEnHe0MCBmwewP6yKBXdOXF731OHUye3qWt0UC/4
 cYRgcbOLvgGY+K1ptxMTbmr2jLtn7eaXowHXIO8fKfi8Bni0vk6zv1FJBImVoT/5niRx+
 u++Sjai4pxE0dJNW9Z9o97ZCGeCFs6NX6zW4TqxosSAoFZ17sqh5E+1PyylS33xvP9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=podNdfNy; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BUbrnuPE; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=podNdfNy; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BUbrnuPE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E53FC40764
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vvmn3279853
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6yrV3JbZef4
 GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=; b=podNdfNyDV1sR8TmUkPT2gvrUcN
 NjXK1+8qGMBoRkQmXNrs31xkTj5Modl00trR+R4DtdESzrs4iwbPJsd2T8GOmzsv
 +YdQoNrH5IrOClO+6yab1etpDCXqSfnFN07dH/MpWQc7i+0W0ZCJ/Rcw5C8qKYyX
 +MnHyGsGKC4v33OBZoeQU9SHHgAuVXyBZNegVfj8Shgg0z4cNuZckoF1QWp9tPtj
 vsIw9wj2svXVrdBrEEsDmGCibTnIXFt73jRk2kmRahwYE5Z4llk4bC7gRdaLjHE8
 dlKG+9TgFJi3TPNN5XnjCJgJ7t+OX7Yv/em7KyQa6gYOwSSi1MNaJVjpkaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3nan9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so2440018eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271484; x=1793876284;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=BUbrnuPEjFlYndhAFUT5eyRVC+q+iC/oWsjXps+5rHlZcIUQmISrPrZ+814s27U6pB
 SCAV9iudWVV85Kn8eEs7hBSV3hyf05faVKRlMl2xS9RMVpWF4K/3+ssV2nfUpVfCsbyl
 4Znle9g5GkTetUfWu87hQ0NAq/ncOUtplyHpq2L+91HjqGdcWVC7QEVq8f86mO4OG6Fq
 zfo3nn0PjEQBYrjTIyIUuKxlBs/AeKID6SQBLjHxR4oTnTNhf6tTi46smumOmKqb5E7M
 UlBU5DdhyGD+NtRwRSXSCPEPaT91G5Sha/1ulmUh0aGk6KT75OpjbUQo7Cdk/KOWB4YJ
 zy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271485; x=1793876285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=HiuVJWxa9ZAUltDR5809EfvycIPYivjYx5e/tTanBnNofl5ZXro0AhrLAAyNShWTWq
 PTlMg/HJCYc2clXF8fiZzwnZJIGx8z7HqTxZEzEtE11Yi+u7hSBmkoY0xvZHefJnZPEZ
 cY9xDDUgxV8Dd6KeH9IYXsfrQqhu/SNl09Pkza8JboTRJBae9p5Dk5wAE+HMPp/XVE9o
 YelBecwb7NSeBHNpab0jAiVsooCKu881d8SZjk41IyjH8E2j58ctX2qiavAQuohzqqzY
 /jRPw9yW0nYDOkQ5bxx5kNX9w3L5IP05jQ+ZNeHF0X/kxzr4WcEMDZxbOjA3h8RWwG+h
 v0Sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKxOOs4GWMUWW3BJhBdTz7rD0ufstqIYLuPH6uzvtowYyWrIARwM0rUVoDKqi9TaM1ry46xfI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLsE/wKCldOREpgk5Yg8Hd9PriVAQJILNhktAnANHeE+aPqBQxK
 wXHaAKWG1TLx0mSi7MsvjyRHoxxMkf1qfFSZL6S2xdhaqm1ewJhgN0G235Nk+VnlLDd4EAqksyO
 /nR841r+R2705yIRCpDIX0tGAKc9KEsF2cldAA1fKZ1Wpa7JK7XA8iLoqm45ygiocoKfc/mY=
X-Gm-Gg: AYBFou0obYhqZJo8GSa7Le00P13FDMck1zKxeaijuskrCq/Xc8npIRs1RRJIyJbFEBx
 hNVbm11E9SkdGhekZ0+vvPi3E+lTBlKPZnc+b38t4Lq5kzUEj8IsAHBKwldXc/1mrJjlTGGkiiA
 J7S4DANw0Yxprt04FWhvW32npDikvmxiqGqdz1oJAUHVdX4Lck75N1ZFIEhPVHMx9aFyXwWsdTm
 3K6d+No6DvUBWprHXL24LPiyz5S2cLiUgiWCJzESLoP9IYIViHAyxv0PIZgzSUnqTo/vfnv+P6M
 zLxzsUrDa5jF8CNMwZHRK6bpxOZ6eQ3hlOG6Pmk6V/0Qft0whtCB28cB+nZShJOh2ru32x5c9C0
 6vV+VTWDZhnFtHS8wOmD3i5CLjOtNrGlztJ1DOqHjG3sS713LOpQwkxtvlz9kQUo3H6Vw1dvGwj
 Y/k/4DScwToI0w95e3A0M7yQ==
X-Received: by 2002:a05:7301:f05:b0:369:f126:9ce2 with SMTP id
 5a478bee46e88-36a204d6e15mr7447851eec.41.1793271484217; 
 Thu, 29 Oct 2026 03:58:04 -0700 (PDT)
X-Received: by 2002:a05:7301:f05:b0:369:f126:9ce2 with SMTP id
 5a478bee46e88-36a204d6e15mr7447811eec.41.1793271483587; 
 Thu, 29 Oct 2026 03:58:03 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:58:03 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 11/13] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Date: Thu, 29 Oct 2026 03:57:44 -0700
Message-Id: <20261029105746.3487456-12-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8FFZBphoX2pyybbONknWUULqJqgyOmmK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX6wd4QUa8xnHl
 /KKPa4IWzqN3jxEKPCao/S36zxmMkd/53DA/fsCCy+eXHn6Fl36JNCWv94cl1nfo91OIxjQz19r
 4FoiOJvqR4RDjA/9cpte20qm75LmEZlnb7jo378mgcHiDuW63g6LUteI0WNqJfE13Ir8AR5I6/e
 WXj4XXwxDr6RacRZXnBDIU7pVm0Dk0D6TOrBcXnIBGGLzjSbbRcmt9xP4jmABgvtYYptx+3axbg
 U775aeohrmr454wG5z/FPPL9lBzmtfS002KuXZd3LvjIffpu1INV9cBM3IUrShka7Ax2T6/S74j
 uufr/4F5oa/wnM7Ah2bB8oxlC6qprejd7RR7k+E0TV2Kr/6z+GfYEgxL+ZuLUkBwgeJgD7MmXKy
 MHikkBPPmlUR8F5wCEZAVgXz2xzywt5EYD3vzCl3H7vvyNhAO4GZKBIDjmQMTjjIOTw0flr9p9k
 B327iq7QA7iSxJy/oMg==
X-Proofpoint-GUID: 8FFZBphoX2pyybbONknWUULqJqgyOmmK
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae326bd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=v_ZaApmAW4vm0h-ULSsA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX7q7p5rHr4lLL
 gipi69dwrXDDjwaPlAXyr+TA3N6I/yUErTwoFODMOeiYJph7EoJOnGSKbBF3OO5JU9uDzAbNmwg
 /THsf6s5OdSAUfGimfnvvB8pWg9HWBc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stage the configured XBL-sec ELF and embed it as a type-5
PT_LOAD segment in the remade SPL ELF. The linker script
places its complete ELF image at the configured Shikra
address, alongside the U-Boot SPL load segment.

The resulting u-boot-spl.elf is unsigned; external tooling
performs signing after the normal build.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              | 10 +++++
 board/qualcomm/shikra/config.mk               | 24 +++++++++++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds | 42 ++++++++++++++-----
 3 files changed, 66 insertions(+), 10 deletions(-)
 create mode 100644 board/qualcomm/shikra/config.mk

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 5718b66cde1..b4fb05eec09 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -66,6 +66,16 @@ config QCOM_TMEL_ELF
 	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
 	  boot rom expected multi-elf image
 
+config QCOM_XBL_SEC_ELF
+	string "XBL-sec ELF image"
+	depends on SPL && SPL_REMAKE_ELF
+	help
+	  Name of the XBL-sec ELF image in the U-Boot source-tree root to
+	  embed in the SPL ELF.
+
+	  The image is copied to the build output as xbl_sec.elf and embedded
+	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/shikra/config.mk b/board/qualcomm/shikra/config.mk
new file mode 100644
index 00000000000..51480059410
--- /dev/null
+++ b/board/qualcomm/shikra/config.mk
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Shikra secure SPL image generation.
+#
+# The XBL-sec image is provided to the SPL linker script as xbl_sec.elf.
+# The generated spl/u-boot-spl.elf contains the XBL-sec type-5 PT_LOAD
+# segment.
+
+# The input name is selected by CONFIG_QCOM_XBL_SEC_ELF and is resolved in
+# the source-tree root. Signing is intentionally performed outside the
+# U-Boot build.
+QCOM_SHIKRA_XBL_SEC_INPUT := $(srctree)/$(CONFIG_QCOM_XBL_SEC_ELF:"%"=%)
+
+QCOM_SHIKRA_XBL_SEC_ELF := xbl_sec.elf
+
+quiet_cmd_shikra_xbl_sec = XBLSEC   $@
+      cmd_shikra_xbl_sec = cp $< $@
+
+# Stage the configured XBL-sec image in the output directory before linking
+# the SPL ELF.
+$(QCOM_SHIKRA_XBL_SEC_ELF): $(QCOM_SHIKRA_XBL_SEC_INPUT) FORCE
+	$(call if_changed,shikra_xbl_sec)
+
+spl/u-boot-spl.elf: $(QCOM_SHIKRA_XBL_SEC_ELF)
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
index b2922cd2c2c..387b83ae6dc 100644
--- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -1,18 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
 /*
- * SPDX-License-Identifier: GPL-2.0-only
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * The XBL-sec segment address must match the address encoded by the supplied
+ * XBL-sec image:
+ *
+ *   entry address  0x0c350000
+ *   LOAD offset    0x00002000
+ *   base address   0x0c34e000
  */
+#define XBL_SEC_SEGMENT_ADDR 0x000000000c34e000
+
+/* xbl_sec.elf is staged in the output directory by the board build rules. */
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
 PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
 }
 
-ENTRY(_entry)
-
 SECTIONS {
+	. = XBL_SEC_SEGMENT_ADDR;
+	.xbl_sec : {
+		"./xbl_sec.elf"
+	} :xbl_sec
+
 	. = CONFIG_PLATFORM_ELFENTRY;
-	_entry = . ;
-	data : {
-		*(.data)
-		. = ALIGN(4);
-	} :ptype
+	.data : {
+		*(.data*)
+	} :data
 }
-- 
2.34.1

