Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB8606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q4SfayTK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZCVoIDK3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OzYstRm/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B35F58116D;
	Thu, 22 Oct 2026 10:38:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8Dgev9GVE5U; Thu, 22 Oct 2026 10:38:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EFA60811A3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792665481;
	b=AktIvXv42jqSPBexSF9EspckWBchF1D3TVhec+xHTdo+hXsioCoS3B7/8tmheEcu1Tz8
	 P5KkEzcfCHM/ry7Lh8vn2oR/FJd5Ge8QoDakJR1TyNDaCbJIK8fl27M94eZP8xI58vksX
	 1AyKNFO919Sn9XoKFeItUKc6eQ6QDwlQ0LCj///i64tZS2eTuWsArtfELWp6JrKPg8cfk
	 BXN6RPYUqP2ACpd+p93qzWCZ5ZsvB5N1l+SEgXot2/0tQ8TDCy9KKuGmF8O4Sub9dTHzJ
	 WMJQwcNnk35zvK22Xrpn4FF9jVx+qWqJ/sA0Lwucflr8Yn5xpQYYKvyXZsgXOC6eC8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792665481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yGrXq1OhrydrQBT6qmBs3atqsLpzakhuhpyjE1x/YA4=;
	b=CpxeK1+s2aPOHmYaRV6olXsOLb63psxcJofZuhGBTtZoN+f23zwHU63qlt2Fn3sEHJTc
	 jAiMA9Udio0KrYQ1kXJ5mQXUyZUMeQpF8X9GjcvkXSlYyi2uOUqvBfe6c02BupKNzaoH9
	 AQT8+yDfNEPIQH+XmoWZ+icnpmG85pJz6PGuLU7aA91Hf2nTtiefydcohKzOJR3diC1a2
	 bVBgPrRf2pOpxnwz4lcpFcqr2a1Jk0wbtmAaez4snJLOoyW8dispe0a8Zy5yTRN9TnDL/
	 HEycubqbxWkYbTPZ8jOOAmg70b/4feP8nIWOgRl+m8rS+YC/sJrKT6Vs5d0IXe2YcIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792665481;
	bh=yGrXq1OhrydrQBT6qmBs3atqsLpzakhuhpyjE1x/YA4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q4SfayTK9GaZeKjd+OjRQ8aq1xxJ7sknWFR1wKIHtYgpwMegXzz6uMy2lgKFRm+l2
	 20dDnMdN8a4tnw4ty48UiF44DM6KI+1CSxUHu+LTu84EDl6xwsaL2sZF10LSNTjzhe
	 YnMP7vhbeuzDrRsGFa9zcnEsBHdJOW1mF0F9piI+ZvUAtUT4H8DUVDeThESlSsHpqA
	 o8W8rHDg/KeVrN5xs2+JGo1LLsgmfyOV6hZRtPc4KJOHD47bA0EoNDSEdShpAsxwWO
	 ru2RybhHKnuCQs6Go0H4oHu687mGVhknEq3UGXqWgfXlJvt9qS9EWLttCtV8VUhTRD
	 oGiB3BjT/AhHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFA60811A3;
	Thu, 22 Oct 2026 10:38:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D3A6356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 039CE60884
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:37:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8B6NLJx5D4ml for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4496160818
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792665478;
 b=loi+R7hZCSVdiWJOxxssY6XG/jl6prhB42KVrdbaNvXmZWxkDc8F2JuvsjI5CsaDNAYI
 mIL9TNA0uVaN78/KgplId3noqhCiPteJ5k4jASzSSgneVCo8mPWsitJBju/MtBlb3x4jm
 Is+oplhcH2VbKrbAdcZ4zVOTMhuShhAWpRf350nuEwXTRsFYCCd2m28lNyTQKVxLJE1+j
 UrF/tXT4PwzzxPcbareuzdbtzYoFmesti/G82JqliSJVLaHOEKtH2NUV4oKAVMno3p3oN
 XOVmANTa6i8aOuv65jcbkZSDaA3MpWQRy8Yyz/5mDuiueA+JqqXnPtlH4j26RqJpWHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792665478;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yGrXq1OhrydrQBT6qmBs3atqsLpzakhuhpyjE1x/YA4=;
 b=aLkJDPuTAnz3cco0gaVzAMvIxxiRZuc5leAVY12MKbHHzOURhfE84w0WkkE1v1obwEJa
 mNROMRdqpBTiMAcSFR0eWZS1ry4i96tCdPfQTMGORf9mO+YkYfWKZTVG8DTy/RfnbxIvu
 C+mF4j8pBbCcntBbOBQ4Lpfs2FtDnphb2hNytg8x7NQxODK+uau5jEGCGjmkLRFgnxua3
 7qw7Cz4r85ZDD+PQJMEcLd1PUAFTOXqfMgbjzQlLZ3BuFhljyajj/xKGyC7GtjyyRVFlQ
 S5fK0TtduQjwsm+rWC6fOQpcZ79jmTt+Fpd+/el4a32WFA9MC/k7XNBUrmM13/cz7aw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZCVoIDK3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="OzYstRm/"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZCVoIDK3; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OzYstRm/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4496160818
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:37:57 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA0XU03923227
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yGrXq1OhrydrQBT6qmBs3a
 tqsLpzakhuhpyjE1x/YA4=; b=ZCVoIDK3yCI8OSb3jjHHODOR4a+Q9b2ws1FJwO
 U6VmTp5QvOnjK+7xxvUzKrpJEW/ck+3+BSLg64cFJ7s0IwYUspXFMQ/8mF+4AJSd
 IzvALBEfqxygBbNatPxQN8JbpSviXpDsV+GN/8hClcB5ssX6FqnP2Y9kRxa/5BXF
 lfHfcuZfzuJN82ZCf+Lx8si1A39g+66x+ipkZc6CqACJh37XsZN5U4pm0Nd6Spmx
 t65wzDAQGsgYSelOZxULROVGHG16P0NxSPfjuBT9X0WT3SXSweIusP5sGJl7cdHn
 LARwyQ0Xs6iXGbowcyY8k4zLftEGF5n+6hpIt2N/OO2wiihg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bj3a2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:37:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f13c143c8so318254285a.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792665476; x=1793270276;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yGrXq1OhrydrQBT6qmBs3atqsLpzakhuhpyjE1x/YA4=;
 b=OzYstRm/bMJpm4xvi1/+Zx50/MUkeIVb4/rnLbumoz6+xrvFEIofx7pAyQ8H2XtkSo
 eDbjlrfwk0Y1rP/E+cpQCC26sFcH0Frr+b+6mprOpWFra+xzK5ZqhjGQE4hcx94H9MXO
 SgoJtAQJ6oThhXTB4S3Ka1ImU5a4QKKiEoEx9GcyDPN6P0IiybMLZBX1Ixm8QuMgUZL7
 Zpha3/hj5+YjbhlkDcz3nDryaZj0hGlWaQCvhP+VJZudTJaECnF6gIRxhlgSf1okiGMt
 IGGZrXrMGZfRgeZfKWe5pfByPy8MlOzgiXmPy6mhEiHPrTQlPi7cb5gwgtYuNAtPYO7R
 PlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792665476; x=1793270276;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yGrXq1OhrydrQBT6qmBs3atqsLpzakhuhpyjE1x/YA4=;
 b=dB8bNbOocsOQZYsc/Q5aQsOTwjOjEUztkGFCFidexgYqvnKYbeZxWdwyec+qOZRhLQ
 ZEuNX/KUsn0XsgQUzuRtC9yHpB7eaBHU3tedfWgg0c8Tuq+Q0a4+JQE/EdCEYv6+thga
 ts2eVqNNjiHH23/vXL2K5zv03LyFU2MhK0wWxptX23BMA4zewQRGgbX/Rx5+s7yMmo/9
 H2BGzAiGSInx/qzovgysCeJbyJrFqS4UTzjdMeCbK1rAmfeETa1BraZ8wV/jNcu48NwP
 uDCOvYusuv4uJ7zEEUKRpa97X3cxXaN19A1dw0fqZIV8lLqMfMw16GKEN0hZVZ4tTYYb
 X3DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmkkNdmJ8vDSoLzTM75VeX8HjxU0wzRIxQGiFM85juKQMSwSmRGPUUKEufyCz4KWdBzL/QCgk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLPcbe5uVPsv89YgblJGQcmNCMZ3l6qNfNLKS7IyJwhaDjj7YNc
 4OxhUW1GeM14TGyvzgdK2Tzy/YFFHw0RXIqw433m9WQT0UDHB6Nm+6MOiQb320pkdCfor5Wb49z
 b9Uxb0FyT23VzMjmJaIQluJZbF3xSL+lfaouIlXxesaMHyTrsIiPXS6aDWbWE2C2FnRbdRNpI9w
 QywY4=
X-Gm-Gg: AYBFou3QSt2Nxxsc8bkIbS/y9Bn5YOeJrwylCeoeIPhc7Xes0qEGvOnfKZPB663MrDv
 0biLwtGGQeoeybKNvlzof19Idso3o7oTN9Drt/o23pvsuTYYq5/DR4VXBH1Vr+PLs1ahpMKuNO4
 mBiQio7r0yHdyt2Vt4rfA/1q8acRyasqbI4d1NdwHBvSFJNkpFjO4mm75gva4Fd3T0uDxoskbyL
 fWQn5Wl7zcC5gMHDyJkLlIOAoVgsSvuBDQMMEEdkOJaAzTwZel9IFmAN+sjuS7AuA5zsc7MI9oZ
 G09sDcgJkT1IxanBmcSlQ9MyeLT9x3ItJQ+CAlNd9rVIKBIlWXZjo0XLg9M2rWLZ7FLVBhwh5cG
 qqzjs2vudIRqjmgaTiiZpBz+QdoyJ8jIOhYxfM3EClB9I
X-Received: by 2002:a05:620a:2544:b0:914:afc1:c66d with SMTP id
 af79cd13be357-93f57e5e319mr816620185a.11.1792665475777; 
 Thu, 22 Oct 2026 03:37:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2544:b0:914:afc1:c66d with SMTP id
 af79cd13be357-93f57e5e319mr816617685a.11.1792665475318; 
 Thu, 22 Oct 2026 03:37:55 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b40315506bsm1717747a12.29.2026.10.22.03.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:37:53 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 12:37:45 +0200
Subject: [PATCH] cmd: optee: report TEE errors of the hello world TA
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-optee_hello_b4-v1-1-c5359b290900@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWOWQ7CIBiEr9LwLLHFxu0qxjQsU8FUIPzU1DS9u
 6CP32yZlRGSA7Frs7KEtyMXfIFu1zBtpX+AO1OYiVYcu1YIPkfKCfLFQ8zAYDFNYVA9v+i+w0k
 Jcx4PrLRjwuiW3/Lt/mea1RM617maUJLAVZJe2yoZ+GXvseTqWUc5pE+9tW3bF79KdoymAAAA
X-Change-ID: 20261022-upstream-optee_hello_b4-9c41e7b2d8f3
To: Jens Wiklander <jenswi@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MiBTYWx0ZWRfX8qwvb5vUH5Fq
 yXCGdhm+jk2Q/8x9FKWh2soEaNilP6/8FJi6CUHQb8ASy0q/SBT354k9aGFaM2p8znHhMs7Y+Nr
 TBzUF4slfT8hX5QfPzCEBMnnzO4STNHIDX/E8FIGHxMdExkkOH3JXXQEwxYn9J9zcCnuwPVtBE3
 drksE7fxWyngh51thoTKZWffrx64Fma8yfe9BSTebYd8q8GbUvcDUSqweQAjkSrQBm545LOpwfv
 xFynoCwBRVvMwDIIBj2KlNqbo+bsSsexu7/UzyqbkoE8HbJzmpBFGpop76Jibw0urDv3DIn9jKy
 vOEBW7zMpPDeDWzY6zImoX+ePwcIlorJkgj3svaUA+C+ziioDh4mD7V5Rafo+scw1zkhVbT88kd
 V1IsOGXSFhQnoVQHclHHfi+w5evXlTnf0pZAiZRn3NlVSh8u4vk+YPTYzC4nT27D86oIaOU3+qa
 ey0uHtds5OQtAbfT2wQ==
X-Proofpoint-GUID: _Ue1C4DfI02BBRtsmR5u6Hwbg7ictGPL
X-Proofpoint-ORIG-GUID: _Ue1C4DfI02BBRtsmR5u6Hwbg7ictGPL
X-Authority-Analysis: v=2.4 cv=CMy/zhrD c=1 sm=1 tr=0 ts=6ad9e784 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dQj8oEp4tX4t3631KKoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MiBTYWx0ZWRfX4CXa/6Zh8FqE
 VEpraIG/DRhDMOBGDBpd1vnfIKGpBjvy25rnQtUBl+wG6PTBBLR5DLj2m2ASG+nuezC2K39jNi0
 NV8LF2lrCPsYSN2wxbsKeGSald+szmw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tee_open_session() and tee_invoke_func() return 0 when the call reached
OP-TEE and leave the result of the operation in arg->ret, like the TEE
Client API. "optee hello" only checked the return value, so with a TA
that OP-TEE could not load it printed "Value before"/"Value after" with
the same number as if the TA had answered, hiding the failure.

Check the TEE result of the open session and of the invocation, print it
with its origin and close the session on an invocation error.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/optee.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/cmd/optee.c b/cmd/optee.c
index 155c9f1bb73..2cbc345973e 100644
--- a/cmd/optee.c
+++ b/cmd/optee.c
@@ -34,6 +34,11 @@ static int hello_world_ta(unsigned int value)
 		printf("tee_open_session(): failed(%d)\n", rc);
 		return rc;
 	}
+	if (session_arg.ret) {
+		printf("tee_open_session(): TEE error 0x%x (origin %u)\n",
+		       session_arg.ret, session_arg.ret_origin);
+		return -EIO;
+	}
 
 	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
 	arg.session = session_arg.session;
@@ -43,7 +48,13 @@ static int hello_world_ta(unsigned int value)
 
 	printf("Value before: 0x%x\n", (int)param[0].u.value.a);
 	printf("Calling TA\n");
-	tee_invoke_func(tee, &arg, 1, param);
+	rc = tee_invoke_func(tee, &arg, 1, param);
+	if (rc || arg.ret) {
+		printf("tee_invoke_func(): failed(%d), TEE error 0x%x (origin %u)\n",
+		       rc, arg.ret, arg.ret_origin);
+		tee_close_session(tee, session_arg.session);
+		return rc ? rc : -EIO;
+	}
 
 	printf("Value after: 0x%x\n", (int)param[0].u.value.a);
 	return tee_close_session(tee, session_arg.session);

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261022-upstream-optee_hello_b4-9c41e7b2d8f3

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

