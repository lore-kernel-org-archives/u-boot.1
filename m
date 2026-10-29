Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC09606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qzK/bsDE;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NgLcSAjV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j4QJdWOt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1845980DEA;
	Thu, 29 Oct 2026 08:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9Cn7y0cJFNM; Thu, 29 Oct 2026 08:28:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B23F80E39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793262483;
	b=oDca6OZPYAITUoTRApixevNe0DqZ5analC6o3JCNSrqlvs2TjZ8U9RvdQwI3QwUIV7Dr
	 IFNChRFby2W4zCJcmo+zrkiuiDLZN+eDffabdYsIKlK0cfglBgLf0neJ76O1TWb3yCyA0
	 Q+NldP3BtN3OA1lvbvPLmcEF8WxH2qIhIB3mz9U9k1lYBVwBcQ2E6j0fJLWR95PNiDFUO
	 +gjXCz66wGCfHSHtY8vzkLn5354dhgz/0SxeUKndhXrCvuV9BloWqxViKdm8j3S/kauZE
	 5qT8dgL1UNsCo/JhQW3K7l+EbTPX5NR4rBXrrqT3F0wqvESMEcg8ydJDv3/RzVISWyQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793262483;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4U59QaUfHlhMbwGMbQPyq7x6JRPptxPwpjIJPU6Krs4=;
	b=lK2lSvNYVpL6MOx0qV3rYDBdHtkoehM79A7tErgDBq+GRvDinE+t1c0Tygpk+M8K7KWV
	 oAhMFkdoEAuwStnV7khvXs0mb7ABGv4RGAt9N71sZrYT3yMkHdatKvHVNSYacpWx8VKgH
	 DHwnc90FzEu5YserL443bWxKVuILe2ujx+zShcqRnaH1aNMg0kB5W5suQ187mTypvDBJq
	 87Ku/wUfYv0Q5b1SkgvYnMK43CE5Lmu9+6cZCZ9yWFPky+cjwuaJV5iAKc/hRgYnHzMyK
	 Dv3AcpTvfAthwisaeCLE0NDuCknHK0NiXc2YlLK+zfVU3FzTZLp9iOQC9cnxk1NLRGQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793262483;
	bh=4U59QaUfHlhMbwGMbQPyq7x6JRPptxPwpjIJPU6Krs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qzK/bsDEOUAf2MFZ7QnPuaL9l5HV4YhQZavvf42UqCfzxPpq267cjiYZFuK0lNyVV
	 OjBOsAqCSeEWC6LwwBxJfb5CMOjqyycNIQv2HWAWvkaBXzVRmuQ3GG17ONJ8B8Toi2
	 zeM7qQHO+f6EyH/FZH3PCD1sq5HhhI8YHqdESI6Z0KMCstMCqnqMWh3j26ZGjUji2i
	 vpWDp+RGpNPsaFqMx3N6m6WgtN8Lx2OeV6qbLYq2vxhQJLYHSMgTt544DL61/d40UN
	 OhcFVY2cPkX0zB7ESyr/2zjnTIUQoxru+Vo2EG12TJlqdTgG/Dw5bmYQtjsOtDwtRD
	 acEdghxbXpsew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B23F80E39;
	Thu, 29 Oct 2026 08:28:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BB3F473
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8911F40664
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:28:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TgX4WIOi1Eoi for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 08:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E23C240665
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793262481;
 b=dmUKQ128cmsf2zPU4UdnokXpofdGULiHyW/aRrjKdOm3quoGqP9ySEEv8VjsZxZF4B9H
 l+Bp/9niPOIKnQH2+PRPkMoNnEG3PKYfYpZS9ehTRzy9vCAgif7STUOdTxfosBp66QTbD
 ZKqH2G55V0iWNUvGBxLTMZep9tB/0jboAMzoyiQfdDmXWWHFB2n3dBXBfmobBWEEtwwcc
 v2azFIQ0ktV83A3pd/rzJ5Rmx8qC67v97bLZ3/KWs9tZqvfpVdh7rxzcIK6yWMFkz2m52
 OMEHfmsKYy4pnEmBEAfB+41CSSDmVoBLdG1bIBm3+hVw7KhGjCmxHJ4mlTngtHkur8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793262481;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=4U59QaUfHlhMbwGMbQPyq7x6JRPptxPwpjIJPU6Krs4=;
 b=ZMLWI7kDMBbB1OAkGrcYFjSSOGLag4E8Bp1gPwQUGjdAs2CybKu+Q0/zNUlxkY9g6uxy
 CwOaPfLHZODIgiO4Y1bP8EsEwtqZq09Eh16yujY4DDcdkQUZdw2GuZ1eGQGnSmbr5+lgp
 DqaSWz1La6aywTHzV7m2QaeLsZNu5IkNUy1Ed8kOygSXN2upHKkiPPDjGrd3NofpLoV0r
 087OHUVGM07yAxoVkTGfF+usIsQtxMnM3Mkxvs/1J0D8KYZaRA9IYm6T3PAUtp0/jlIkH
 916Hf746MPRVkWec6d+c+pFLGP4XwHz/4byuQjYkqxwc6jkwdVb3qaheqhePnBAH93A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NgLcSAjV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=j4QJdWOt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NgLcSAjV; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=j4QJdWOt
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E23C240665
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:28:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5GoA6176843
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4U59QaUfHlhMbwGMbQPyq7x6JRPptxPwpjIJPU6Krs4=; b=NgLcSAjVKlXyI2xC
 XzUIE2nM2M1+CFDrn0u+qGVvHtp/boSFrA+R+IHahctMUQoqY2E2NVoBTkzt+vYO
 ECiJEvaZ9CiGJqq4fFc3S6MiNJyivUvnTmMihVSmFKB0mA7bOgyatOxGQIiLhM5F
 aluRCJDnMe5K6/KMXPhOZdG/Kgy8B8Qf4d9eJETdItoWRpSDWBe2U9XYzavkuhnp
 NQhaJdeQTR/74cOmz3o7M1zc7SDcHVjSXUCecMHuxOojPmVuB5DIyVWxq/xPF1qc
 GOaVE35jHQs1YbLUDQjfKAaNpQIP835DospH8iV6rVSxK6uOFDDV2idae2+jA+Ii
 AVRSKw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehunut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:27:59 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-679f81e0f96so2764803d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 01:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793262478; cv=none;
 d=google.com; s=arc-20260327;
 b=PH02W5Ae6rKqxSOtWu/cVZe4JviG829bQ559ryPKPA3gQnaSMdfmuRctXKbh5hUn0a
 58A0M965jmKVJm4p/WP8CSloVALO3cCugq9AOAYYDxAdPSPzUzKhOTNLI42S/4CZSFu9
 v5+U+HeL2jvVMmwd5GMPSZxBl8nF79SJPf4w4bXQJPaSBsorxKSfLb5kZ/hFxZZYUDRK
 T4eG7pt+lQ2VWZcKkRSGAaySAkVI4Bbc0RDgX19VHFJTa/9HZAg7rt326S1xM9SXCR6w
 CyNA0JFeMXE5SGghAg4UcuJNO/23VLdqzvcgSYx359Wt82r/uHqyZWFOYcEM6Omc2Qnu
 ufnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4U59QaUfHlhMbwGMbQPyq7x6JRPptxPwpjIJPU6Krs4=;
 fh=XifbPUnY842I+PwtW+I1l20kM4gT0FYusYNu16rDDlo=;
 b=rTph8bSZwh9ks4umw+ZGPgcbX13Yw8DSj0TyYfaqwg4pvI2O0uUAHoyaQXEdUHyHtF
 4n8pf5/c3ZvU3ygTz79Y9M5vWgkUCybRrLeB76tqC0RCUeGTMWDfyU2Q6xptbN+xGAn7
 kAPwWyXF4Z/kcDCteUlsP0NgrPCMZXcllId7dR9uN7Tt9DVMtuLhET/NtFT3mmoauFQL
 d9Vuyx5KGAgsaKZoqgHC1zl7MBidG9fRY+izvScBnMtQXfJeZsWIhXo52itT/ErlE3Ge
 89O7aGIlRKO2ZdrirNPVxy0Pj2fjlBdfDsjJ7oBgaFTssQEphpdurafT9I/pSk6j5FNG
 wYEQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793262478; x=1793867278;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4U59QaUfHlhMbwGMbQPyq7x6JRPptxPwpjIJPU6Krs4=;
 b=j4QJdWOt4MUqQt/o3XRewtXdQ7YuF1qqAPkFfFbeshn1g1rdnhXSQXUUlTemBaUl0m
 uQqyfpeXKocniDoN2f89EqJ9Lk9xoogZIpWodyOM/ch+8asA4HR8RIR9KKBoWFML5uvG
 bVJQiFu1owBcxA6quSOVTO5JAQ+9LUcwSPIpMg5GrpXqMBIV7qzXCQF6Fdmfjlpd9JR1
 g/SqS1lbRZ6BHvWA0GRkjLcyxjSZG22UNDpP/mwLYdn877vhuGarulUx5O1V7Qve2205
 /sgHGv3LiFNEjK4w+SCz/4LLZH51JwMTMXNUU6M7KTubUcFqvxJBZ299mtp37UFPvECT
 EImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793262478; x=1793867278;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4U59QaUfHlhMbwGMbQPyq7x6JRPptxPwpjIJPU6Krs4=;
 b=Co89P0iQXZ0qQsnctVSe08OA9iwPwlLpA6Ba+QLayek8r6SJMFIAyRfTJtHgTQ8hL9
 pVFf1JmT93e/edysEntLxuwzu6DSGpo+uzCfhWxVGbEVD8gOtM2Zer+zqOSBJP7r1eFD
 9QJ+gGL21HM+NptkzxFb0/Hqw5Zeq+RD6hTr8ZpsWUVfhT9RLOD5h2NdLZ2wtVzv5X/G
 Fx7fyLkqqvQfLbRU8c9MXoyqsq36N230Q4NXIrRqndHb2morI3Quz2OJ6moF9r90oCpd
 pl/xEnzfLvIwpMx4Kpd4tbESQuQBn9Rjt/AqdAIVetVWB5cjlC2eQUiMQgu0iGB3hKzK
 pYaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAZ0R8BU7N50O3e9xktcE8yn3IzqOWkIsLCFJBGr05/uUF5YR6NU1PB8EPy1eZw9L3A3rbaHg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKOE2rEdpr3rt8SDILINirUYjDE59z8yitOv4pt1GOdMBTizgDN
 mc/Vg5LYKWDofdRfC5hTh3XOu12JQ8YbuHejoxehXuNxcb0llX9DD46z6QQhvDhC7YMcHGKFw/i
 YSIVlahdDp8ZKSkMGHWLnxIGRDoVZXRT4rdK3GJR8ssgOU9HLCPaeU9KhhdBFMnHSVzkgrYX4rv
 ZaGaToqwEZFbGSW0v4S5p6LYW6S0msH40+f5Mb3JZl3YLfoA==
X-Gm-Gg: AYBFou1pXLQMJ5vcJRkyi4GJiJGNBOcFi0dYG1KyC88400krodAtIJOQubqov6zmcwz
 Pufq1PNB3mScGd7IlhfVG/a1IOI/oCxyy0X7qWpL26oNJiXPFYvaZPHMzsm0sQXSFzU9TwOAFaK
 hyrNwxHGOlxGVWUqsE//Y41Rd6UM8J6IgeEHjyMEDj8BQyY44uL0bztGA=
X-Received: by 2002:a05:690e:4550:10b0:679:975c:3297 with SMTP id
 956f58d0204a3-67a7bc54d10mr2006271d50.25.1793262478377; 
 Thu, 29 Oct 2026 01:27:58 -0700 (PDT)
X-Received: by 2002:a05:690e:4550:10b0:679:975c:3297 with SMTP id
 956f58d0204a3-67a7bc54d10mr2006256d50.25.1793262477716; Thu, 29 Oct 2026
 01:27:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
In-Reply-To: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:27:43 +0100
X-Gm-Features: AclHuK_xHevGPw0p6eH1lZlVqqbci5wK_cW8DUQ3-QRNd3_qYvu9H7f93skTCi4
Message-ID: <CAPzfCAa_J=Ztz6yLqqTXD3N6_k+55KnqJHeXei1wB08CjrEizg@mail.gmail.com>
Subject: Re: [PATCH 0/2] libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: vWmSxHl-WIFsKplpGJOyizC8CGJxvkmu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMiBTYWx0ZWRfX+fn0uuQvJgo/
 lBxsyS1ai/bUls+vlP+Cv0QEoRzp3CbLvLXDRA584qBtOXTn7WQt/0A9wadEZhaljozGfqTc4Bb
 ZP6eHh8OqbAX5CO8g6bAE4s8hEbclSML3lN8LUU7kkDBQt6J9GAxDTre1B4p9DszDI4bv2G3ah+
 QrC/ctNdphonziMSlh5tgXF9xMMUiBfptjSR4OVfuzUGLC1pv5SU7PAxFPIzBFk9ChVhWj3yQjz
 ZuCHnfWjVpvh+XhMDk+zf8br7ErSQh9J0E1986Q46ptwypY79IKWBZo1vHXiyKPe/LiqpWEcOfA
 xsfewKyo+llhlEQe7NZ9zn4c7ohFwW7rI3ebBGjt05rwI7Wzgex+2J7U+HUmSXj3MHjy9R9lMao
 EwUfP/bL48CWsJFTmzXuBwT0FevywYnlS46TASFEKmmak9k6IWTqg5xWPXCXYs/CWMy/QttXpDs
 pg+KFqeZp0zI3qXN1fw==
X-Proofpoint-GUID: vWmSxHl-WIFsKplpGJOyizC8CGJxvkmu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMiBTYWx0ZWRfXyHKFl6GYvQ94
 CR+7XTynKZSwRciBuhU9snDj6rdujbnmrC2/WvR7rE0FL4EfIPSx8J8MLvbZBSM0cAR9raAG2m6
 RFINZLlDBMiWxO0NhJ8RzfLd0cXK4Ek=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae3038f cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=Tt0mXCxwEv6yfE-P678A:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290032
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Fri, Oct 23, 2026 at 9:51=E2=80=AFPM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> lib/libavb is a copy of AOSP external/avb's libavb from 2023 (1.3.0)
> with U-Boot glue. Upstream has since fixed a verification bypass in
> chained vbmeta partitions, a silent failure of RSA verification on
> allocation errors and out-of-bounds reads in the key parsers, and
> added the vbmeta digest command line properties that newer Android
> releases expect.
>
> Patch 1 builds libavb's SHA-256/SHA-512 on U-Boot's lib/sha256.c and
> lib/sha512.c instead of the bundled implementations, following
> upstream's crypto back end layout. Hashing a 64 MiB boot image is the
> dominant cost of AVB verification, and this gives libavb the hardware
> accelerated and mbedTLS back ends behind the same API.
>
> Patch 2 is the resync to AOSP 1.4.0 (external/avb c5066a96caa7),
> The ML-DSA algorithm types are imported with
> a stub back end that rejects such signatures; the bundled SHA
> implementations and the BoringSSL back end are not imported. As with
> the original import, the AOSP files keep their upstream coding style so
> that later resyncs stay diffable; checkpatch is expected to complain
> about them.
>
> Tested on sandbox (the AVB and bootstd tests pass) and on QEMU virt with
> OP-TEE, where the Android bootmeth verifies and boots the Cuttlefish
> Android 17 images with the resynced library.
>
> Based on u-boot-dfu, which carries the AVB lock state series this
> builds on; there is no dependency on other pending series.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Just a gentle ping on this patch series. Let me know if you have any
comments/objections.

> ---
> Igor Opaniuk (2):
>       libavb: build the SHA functions on U-Boot's SHA library
>       libavb: update to AOSP 1.4.0
>
>  lib/Kconfig                             |   2 +
>  lib/libavb/Makefile                     |   8 +-
>  lib/libavb/avb_cmdline.c                | 109 ++++++++-
>  lib/libavb/avb_cmdline.h                |   2 +
>  lib/libavb/avb_crypto.c                 | 348 ++------------------------=
--
>  lib/libavb/avb_crypto.h                 |  21 +-
>  lib/libavb/avb_mldsa.c                  | 136 +++++++++++
>  lib/libavb/avb_mldsa.h                  | 144 ++++++++++++
>  lib/libavb/avb_ops.h                    |  10 +-
>  lib/libavb/avb_rsa.c                    | 398 ++++++++++++++++++++++++++=
+++++-
>  lib/libavb/avb_rsa.h                    |  10 +-
>  lib/libavb/avb_sha.h                    |  27 +--
>  lib/libavb/avb_sha256.c                 | 375 --------------------------=
----
>  lib/libavb/avb_sha512.c                 | 361 --------------------------=
---
>  lib/libavb/avb_slot_verify.c            | 116 +++++++---
>  lib/libavb/avb_slot_verify.h            |  13 +-
>  lib/libavb/avb_sysdeps.h                |   1 +
>  lib/libavb/avb_util.h                   |  10 -
>  lib/libavb/avb_vbmeta_image.c           | 118 +++++++---
>  lib/libavb/avb_version.h                |   2 +-
>  lib/libavb/crypto/avb_crypto_ops_impl.h |  43 ++++
>  lib/libavb/crypto/mldsa_impl.c          |  57 +++++
>  lib/libavb/crypto/sha_impl.c            |  50 ++++
>  23 files changed, 1166 insertions(+), 1195 deletions(-)
> ---
> base-commit: 4dbadf86e2799f29c9c6043d3bcd81012a82ae47
> change-id: 20261022-upstream-libavb_b4-7b2e94c0d1a5
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>
