Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E11606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nruIg5Xt;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UzlPfLAD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e7yTqq7W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3493780E10;
	Thu, 29 Oct 2026 15:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S676sGlTktrf; Thu, 29 Oct 2026 15:45:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15FE380DF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793288710;
	b=NRMGxEpK5h8bMqHBZT2dVh6cos6o7Am04ECMAt1hfyMHwZ+7R6K8Ba0TMU0KPtrzuN/5
	 yUNDtoz/KB1la4EQm4xPfn7FV44TnAD/x+n3LEhtXYl+MZlgWw0d3bi1BptYTBWok9p5a
	 ckmXfE1NGh6A+VXT3kUqgGjcalm96/+wxlHwuuCHMM9D+Qq1JmIGM9jNX2yUW2DgB9WMo
	 XoLfCCnOi91uG6CnLsjAkZ89yZBlcdXEP5y5p3kUaDp1XiqVz7oeMWC+i/NGL443QL3Wq
	 WJfIPQPVWiKfFUfVkyx0Az2AkGTwJATojKqwVuUTywYAyEdEoU1OOqTKqm/ZKs4lp8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793288710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CEGwWTG0SyPHJVyforJKqNPgnWOS+NAdR0tl63lXhS4=;
	b=XPh2lPpJmnx5MQeYwSSJRF4drWCcq75/nTkcX0aNi7INqSJuvbiXws9dBeKrQ4QkvL/r
	 7oOZCFKAeTkbyRsDv4u8mdxD8ERcGPlU6SlgcPp/P2s7XF3p+bltEHPmrbTESWhtIQnfL
	 OY6NtKjJZTe8iKKZLKJCLWKZKbgPv2Do/IMl4Y/6YSE+hfGEV3lJvDyMVBo+zCZlBes/C
	 vw88pW6vvHqylIM4a/2FBQOLzbgZtwf8C65jhgjKwvPSEGCgQBKTq+jbMshR52376CQY6
	 HIgDDKRlN/Vvwl4oyuD9VMn7X/5hH/zxzMMZ96Y3hN8oT+A8JY0mLh66bDUvM6uDogw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793288710;
	bh=CEGwWTG0SyPHJVyforJKqNPgnWOS+NAdR0tl63lXhS4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nruIg5XtHJAUM9j4aqQnnqy27zEffPNZb7QNJ7nVuXnypBEwFdSfrBEuCGxWMjOPF
	 NkMQbxlx1BlE9wIqyUf4r7ruVwarFAtivYsRgSNd+lXb9JDThO1blezKCEhOrJRDYF
	 tZPMbHpWFP6daSRkY4d1BkooQrKti8EOMPlSyU1oP/7QHbQ6Gks11NrHZvbGV7XwF6
	 j1T5WAzKhSJTeqx7oZNo4Ti5kYlYMfJUjlY3stHkVnZcRaEOnHqbZrET94fyGHasDT
	 4NPJdn2WS7Qn55Jz4KJHTnvdfaK7P/t8APt45ISbf5GjTKenes4/O40QncTZ9Bhh47
	 pYdUc1JLkXVog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15FE380DF5;
	Thu, 29 Oct 2026 15:45:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E48ADD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B68E606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBFPQz8RqPPa for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9035606B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793288706;
 b=YpGJ8/bIlkF/8L/cuHeNDzKZsr4R2D8A5cpaR0TQ0lmduMtvFrn6MHd3LJe2pVDwa+v4
 diShMF86julTw3zE4gaCHyhCYwBIfMfwqryoexKt/c1xDRNvUdOLFdCXjDQX61WGRjn05
 FcnrXE9YbszrdfqPpp15TBbZoI8CUMpgLdeyGid6EQesxivBswjqg1c8L4O11IWhRVkru
 mfeznZQ59QkUdyQA4tvlyU4WgdWrNXU0Gbg8PWU1g8aJh89M2YN5oorjDSm9ber/WCV2b
 Sj8hrMfbLraAZVazwueifwq5YVbts7yk8utD2os4QZkYLpE0gMla8gSo3J8i7BEI4Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793288706;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=CEGwWTG0SyPHJVyforJKqNPgnWOS+NAdR0tl63lXhS4=;
 b=bk8/1/dxg8SuXJfMhRhdSwK3JYWwURRFyECzZ41O4G/mbmbONmjOI3NSZWN+wFYdQ3G2
 hq9XyvgDG5QHUWSxQArYm7A4eQlzPeGFUsA44oXRTdZD0rvxWXODs6dPUieSNXFN9tiiw
 yfsaX2FiB6zNP1a8XD7VXKWZrT49mpZnPGko2G0N5uAhaBQpb7IaGn+X67iQk9miQzUuB
 XTjj6p4p5//tzKk6BYMxFK1EFpPDe4/CJmXWbpZjoQcuwFX+uN7ZFFpFQ9kbN9oP1DGNA
 j09Gy2qzwHlO29ypKPfS+LN2ry92a8daw2u2DyzQAbrsxe68S/MQuIkgcm5Y3bhuvdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UzlPfLAD; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e7yTqq7W; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UzlPfLAD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e7yTqq7W
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9035606B0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeBOT068287
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CEGwWTG0SyPHJVyforJKqN
 PgnWOS+NAdR0tl63lXhS4=; b=UzlPfLADyzhKg37+ga6U0jq8JizdALJK/dOhCT
 8wi1DzmurMMHA3IaW9NKg1ynkcMmJE2UCVmzJUhDaOhlSpgA2VIQ00AdIOPXoCMT
 aaCqe9U0mQT2YkpLHaywRPoSFE6VbvYVBP9YORaa9DmqoSn91QpCoZ06Xp/wkAh9
 c+zH04ZXMolpyrbhKYdvdKHWZYz2OT9gRwxskqVo7Z1orinmwbnQtNzxL48fitN1
 PTI43p32qZvYC/Gox8udM6iXsAzNE70o3gAqdkvU0GUa7PcVAWPerXXoCRDLBjo6
 sDuNcVjhkus48IoF5j2yn6jCvmllHceXrF9UD4QErgRMuwSQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshtk26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so447703785a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793288701; x=1793893501;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CEGwWTG0SyPHJVyforJKqNPgnWOS+NAdR0tl63lXhS4=;
 b=e7yTqq7WrHC/NOcVydU+ZJvL71jDUmNu+AvPKnNz/t48HGnNgCdzjwC8uR+S/FSzg6
 jdZfWY7pGYEeCMF8rChbCJXcjDuA2+7g+aRmzMAQNr0YZiIijPC+Q5LHpLM2ng3ow2jB
 C7FCkUbcYEbeKOhReKxEdPQ4Y0Mo3bEv7D4Tzo+4CmlXz7FMzgjP+g4li6sodK3B2KGr
 Pxfvs25tsANJTHlKUV777+z6DBpne2CUO0+Hm3pwYdtur1ajeH/QuOqOrDKEVyGNcy5K
 RwCyL3OynaR78a9xDLpZcGVwm8Ja/4iiX2RBJzN/beKdXVbCuXO1antTnQl8oUDoj9RY
 r6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288701; x=1793893501;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CEGwWTG0SyPHJVyforJKqNPgnWOS+NAdR0tl63lXhS4=;
 b=fIOZS69ci/2bqiHAMMx41rY1rK0lpqOTrbpOXpLOl6F6SlwhbmpOrmyTLpKCopM3L1
 VeRwQCYozZiiGzaALMtG+2JT56TM7+Q41qpfA3jnIG7WvYJgqYcEoT4DAXoSffQaVGUt
 gaaHeN51ZaKVT2A7MD2ta+LZ6FrO4JhqjQMmrp/YXWMQEDgw+uz5D5dhVa+jwNecxxk1
 9eKNau0V2JulWLJ010nrV0siHkaOPMbv8vCNVM9spfR8Iuw+WTdFKz11B1jvJ+eGzGst
 znbQsrUk5pNN2lM5kO7/nAgDNxEfejndOBLWNOqxiJnzSnZ+EkBPFTy6t2Dn99CHI5MN
 2xcg==
X-Gm-Message-State: AFq9FYJL4kCrFzyvEC+h70rocFChS1qOMNLgzSoCRCT+OJBWmWL40wPu
 Gl3nwRxWCohcaGPHknvsCJ+qIPEgYmLEgv83L26MiLxCB+SXat6C+KeBBz1avVvhySM9IO7Uv3a
 yn21DkQT25/akxiEpJrWqMmipPz1npA7BZQZdLjowhNu7fHb6WuDK2nb0JRXW75Oz6n87yu6gg+
 DiJGJOLA==
X-Gm-Gg: AYBFou3sYe6Wgcsu2KUXyiG/s3/6MNA3T/P0XvlwSxcEfW6DJI0gvBQB0k8qHcpDQjZ
 AaIr2b6MttzeGvsmlvUYnOvKmk9ucUZAyAZknDIF2gLXXiLT0Q5WwYoxSeQDAVl3le+phKpJ/mi
 DqklkU6Ch7X2yqzxXKujn3vm0oZOXoGqwY3yXj/IoD9eo29MOSl/OzLKYVwgz3Cy/JJUFhuAdOg
 ehWe0cvxGFiO92Gparb5sIbwC4Cl16+epgcnjX4FD04xwzF52KpaouFbZKAPERkuQSrricZwZhK
 4AXacbPKddjAkbTt6rPF+TF7mv7Fmcq1FtAUFV08dhLWx4zPvT+KjYmbM/8yf72zLABCZqjZ/Ws
 Wk3UhD5kmeGJCBceWpdCM/3z0/g+cWl7NXKPFS9PumMRFjyxsWRIozJ0ngtVUzLrGws0hh8kHNO
 gxrvspnm5t/cqs
X-Received: by 2002:a05:620a:370b:b0:944:192:85ef with SMTP id
 af79cd13be357-94408cb56dfmr947508985a.22.1793288700521; 
 Thu, 29 Oct 2026 08:45:00 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:944:192:85ef with SMTP id
 af79cd13be357-94408cb56dfmr947503385a.22.1793288699970; 
 Thu, 29 Oct 2026 08:44:59 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b496022e91sm2814338a12.12.2026.10.29.08.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:44:58 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v4 0/2] optee: two RPMB fixes for RPMB requests served by
 U-Boot
Date: Thu, 29 Oct 2026 16:44:49 +0100
Message-Id: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNTQ6CMBAF4KuYrq2hPxTqynsYQ9oylRqh2ALRG
 O5u0Y0LiZtJXvLme08UITiIaL95ogCTi853KfDtBplGdWfArk4Z0YwKkhGCxz4OAVSLfT8AVKF
 vdaU5trYUioOSGZMoPfcBrLu/4ePpk+OoL2CGRVsajYuDD4/38kSW3t+RieAMF0YwqI3iWtKDj
 3F3G9XV+LbdpYOWrYl+a3RVo0kr87oQKue0YHpFY9+aXNVY0owsjKXcmlzYH9o8zy9fQQ+9cQE
 AAA==
X-Change-ID: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: sotKzSclm6sNbhPA3cB0x_p_I21iIRp6
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae369fd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Bsyt1ek_QK09mtdjVvwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfXzBVdPsgYM1Np
 CrbLV3SuipRAWcoYD/wMzVFZa6NMTwaJMcd4jV51mILbuQTW1x72ITiqVFjvui/+PVJsetFs/2h
 SD01yKiVcdUpjr7RKWgtbSWyEg87L54=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX0yJf8txJ0jyQ
 ZIwsyLcKyMnt0oHdVZurDTQmi9YxmtSnA3ldxW0m1kmel2aFW2xYvwjH3br3mPrm5CaPQTUu8uO
 BHwJBrR7wO7G3cfOaiGvWaUfHkzEQiMFg7GCPOdUZe1BanyMe5ootvHpY6hsTIoTOBiGt4V3HtZ
 wXF7wfoFe0kQ1fpxa8iGmTHFDqZbd2xbTFzICkR4b7a2Bh8FwR/K77qVIK4n5fDip4xTAfiElCj
 boFZFEPxUfc5jmq16v4shaAbSkVMD0hiJJNIuj/QcnvlqqjLBEqyvZD5q+2OJ9JpdjT2N0ZT58R
 du3wzIss8HsXhrDibGib3OM0q5xnUEodTJwo/xA/WnRqku5HqSOdXEqD4iUYLxsLmaidCUUZkSt
 wsmxRzjO6dh12D8o4rJHNMF/oDzi5tgZ+XY2MfT7kwY2JDJkCPsQkJSiUclMKWhf6JWWEl31/wb
 wYnt3sZ/TyxCowzA2ew==
X-Proofpoint-ORIG-GUID: sotKzSclm6sNbhPA3cB0x_p_I21iIRp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290061
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

When U-Boot serves OP-TEE's RPMB requests itself
(CONFIG_SUPPORT_EMMC_RPMB, drivers/tee/optee/rpmb_emmc.c), two problems
show up as soon as a TA uses RPMB secure storage while other code is
using the same eMMC. Both were found running the OP-TEE AVB TA from the
Android bootmeth on QEMU virt with QEMU's eMMC/RPMB model, but neither
is specific to QEMU.

The first patch makes the supplicant select the RPMB hardware partition
around every data request and restore the previously selected partition
afterwards. It used to switch to RPMB on first use and switch back only
when the OP-TEE session was released, so between two RPMB requests other
users of the device (libavb reading partitions, the bootmeth loading
boot images) switched the eMMC back to the user area, and the next RPMB
frames were routed to whatever partition was selected at the time,
ending in status timeouts and I/O errors.

The second patch stops optee_rpmb_available() from announcing the RPMB
device while a supplicant RPC is being serviced. When the first eMMC
initialisation is triggered by an RPMB request, OP-TEE is blocked in that
RPC holding its RPMB mutex; the announcement opens a nested session and
OP-TEE's second thread spins on the mutex forever, since U-Boot has no
notification support to put it to sleep.

Tested on QEMU virt (qemu_arm64_defconfig + OP-TEE, eMMC on sdhci-pci
with an RPMB partition) with OP-TEE 4.11.0-rc1: the AVB TA reads and
writes rollback indexes and the lock state while libavb verifies a
vbmeta chain, and a TA call that is the first eMMC access after reset
no longer hangs.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v4:
- rebased on main, which now has UFS RPMB support: rpmb.c is
  rpmb_emmc.c and struct optee_private has one variant per RPMB backend
- patch 2: add in_supplicant to both struct optee_private variants and
  document it in their kernel-doc; v3 did not build with
  CONFIG_SUPPORT_UFS_RPMB (Ilias Apalodimas)
- Link to v3: https://patch.msgid.link/20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com

Changes in v3:
- patch 1: select the RPMB partition inside get_mmc() on every call
  instead of in a separate helper, dropping the dead store of the
  original partition on the first lookup (Ilias Apalodimas)
- patch 2: keep the supplicant counter in handle_rpc() as in v1, not in
  optee_suppl_cmd(): the sandbox TEE driver calls optee_suppl_cmd() with
  its own private data, so the v2 placement wrote into
  sandbox_tee_state (Ilias Apalodimas); explained in the commit message
- Link to v2: https://patch.msgid.link/20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com

Changes in v2:
- track the supplicant request inside optee_suppl_cmd() instead of
  handle_rpc(), and use a local variable for the private data in
  optee_rpmb_available() (Jan Kiszka)
- explain in the commit message of patch 2 how the hang is triggered,
  which TAs reproduce it, and why Linux does not need the check
- Link to v1: https://patch.msgid.link/20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com

---
Igor Opaniuk (2):
      optee: rpmb: select the RPMB partition per request
      optee: do not announce RPMB from within a supplicant RPC

 drivers/tee/optee/core.c          |  7 +++
 drivers/tee/optee/optee_private.h |  6 +++
 drivers/tee/optee/rpmb_emmc.c     | 99 +++++++++++++++++++++++++--------------
 3 files changed, 76 insertions(+), 36 deletions(-)
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

