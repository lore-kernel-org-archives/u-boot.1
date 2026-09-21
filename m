Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0B0C982F0
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 04:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB27C80DCE;
	Mon, 21 Sep 2026 04:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVNUzoAyaoB0; Mon, 21 Sep 2026 04:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC93880DB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789965268;
	b=SZAwKcBJOP/+9zkh9wcV/ZC7tAGJHM5NmLu93iATgFNyG7qo5JxNOoXudqxc019tCDmX
	 CYQoGRGTvZimnTRV6mRblRvQsmSfpJ3iJie1+IS6JivRGBpQ7OVK0H3jKp5RgFqXJrocm
	 +QTPkrPlismF5R+p7L7Sbe4nwjBHxRV8u0im2uaKD3p+FAw9sr+1yEJLUwo6sUqBxkEbA
	 bqEARqQFkuhXN8mxTDO7pgd4XMvVk46kDwEDbXM+OLIkA6hK+nkM7CD4hneBoGxHszqrs
	 dy/a079FkZbWUg4fpW3WE68hEMO3sy1OrtO/8KpcXiuxejK3yDdhMypGcP68jE6TfnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789965268;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
	b=nT9D87YXn4nQg1+QdXwAotWuPTAwfkA3wK5G1TzoEg9rrNn955xfFJdQcCUya7JjHr/D
	 nutaGcCuzZ8YHyQL2Po7MwlOc4GOjpCpP7IERAbSVV1iE+3iFRb+8wBIfT5y3wY1ZOBap
	 FibwQIgrSZWONeH392X5rYewFnE20rFLjqIPKohNpj4krHdSbi3+CS8mMZBtcNi122suG
	 0IlfBUQOIqiTdSU1QU8q2BiZfVw1bgwNuOrKkgTIYsTgRw8lclQdWimUR8xy0hMjpy0pd
	 cyLM7zRN5kph1qcPa37ICbpUEIAgsdtPn1JDqg14fVYIzKUb8UZZcbK03ph8aAgBipQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789965268;
	bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wr3PSUeSFPXCxgAU5zALuC7DqP+36LIntFeH11lCunCu8QXrYoyqcTzRAUrHUvzrk
	 1X0ONDjsikn5j5ERuXGmh7pPyJSbUtrAI3EHN7veV/+DcK10hiUBMDkcxZM1qn8fKp
	 3uoNRl+P5/AMZsaWgaIzJ9qK3ZOa0yNn1NTjFf20B5Dd/AltFYI2ZAsiilDPeJLY3x
	 3xoE1on8oLJGeWV8198G1RDuKa4wx2n3PY7FUaiRV/bvaY0OSajBDdE3Oa7yOuKkKX
	 fJ30XL72nrRbTZbfHNkatzK0JaFdhxi26juqYkV/nP851D7Ul3KqDGfIGsHZS9ekrF
	 XKyd6e2imMTWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC93880DB4;
	Mon, 21 Sep 2026 04:34:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C55DD1FFC
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7C7F6060B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqyl7gh_GYbA for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 04:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9664060608
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789965266;
 b=qynp7s00apI4x1DHluwWf4DvnuVtmlrgGw29MW+M9k1BXu2SN9LUX/HfDedFacnsC6mu
 P7TdgGsVeNlOsyCkwJ9rH866JkITuimfImn0uSrCafjviNnV1Z8j+q2CkmpbfrtcnjnuY
 rojBCasomge+lJY5c1zmtcPP4DtqyHbRF66tSU3TMKXaX5A9qc5fpX1YYDptwGmsD657X
 LnWzfEyTon2pKLI8ZmYGVKDcMWl+R1xxs0IKj+B54dUT6n7S7l+cUm2Kik7n+oRckobcu
 2RNOC4YIzJebQsMkJnuyC6+WhbTH3CtyOqLaMoRRbAVlKyUm5hDJhY9XzgnUWozMBHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789965266;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
 b=pLtnCw6wrwwHY1qlTTU7dVyR4XOFx4x1TAyQafyVv/RJZOGsaFr7jUWUaQB0MSUIBg9W
 5OVFiyquxVX8NusB6VL4tUvGofs3zdXp5+pHfAWDnD0seU1B49+rR5/IyQ7GrBQRZk93m
 3gsnyjd0WEE+su4zPGKVHUGOa24swmLX/riH2giSlI45rKL3r4cygIcibo7XXA6gvjjgN
 Z5xo1IQvi39r7DSiE0ZC5fgHwE1A9XEuHx04SRWxiLim6MGtnMA3MXCkLJaFdrWKkoL1g
 SzTxo4JYWvMTrv/KxRon7u8SGpjgsPHX9kGsYinJWofniK18JLJva8eoJdBqL3Z4YsA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gYAx8IZm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kEUpUfCy; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gYAx8IZm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kEUpUfCy
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9664060608
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3Z5Jr485236
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=; b=gYAx8IZm5bRuhcrE
 ZGqE7u8bGspXmDqzOA+v3oPBnbSENZv4DphsiVKAun7mI941ZQJqMbboY1sAZ9p2
 l9PpL3NDVWu8rA5/Qc9bR1gzk/tdsPRovJlAufxzLR6riDoukXkNrD1RpAAJ7NYX
 hhJU3TWS5ZmviKFdedFxjc9/EvVGjfpwC1q11Tp+oEmCgWjtX+AckQN1o7aeC8l4
 I9Jqrh6VPwRtPvWsEr9NPbpwTUaenz0ad8yB/XRVZp0SxzFlHYdDpyWhgDMMCdaE
 OfF+M3fZkgfaP5VAFHnxupCKt6BFVsfF9YkRrKnEtwmWuK9ilMGAPGjwSm9IXDeS
 rIIszA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq7j8v4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e087a17dfso4779464a91.3
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789965263; x=1790570063;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
 b=kEUpUfCyZkBsFATd8TJvEIcB8uCJUpOsYJEkWLNixSTyQDnYVeGcfMb6Z0KG8PArxb
 Uy3KcbHYGhNs+l1G6yEkS2yFX6f95IkKIKtZMswYp153GVod1lxpUZ8E7riWCeO/xVES
 cdFZ/rMVcsgswbgZ2kSPbgoxLldyLAnc0RBHvYcQ3B7cXzqnhfaNdYs8rUGyZ0pPIA71
 ktOJNM/jYZl6g37y3pSpTPjjvGPorc0xBzZBEa6l7OUlDJT1hinGaz/PHxVLi5qhIkwN
 pQihU4DLpBng6GZHG54rgW8P84YJWKthGN1fgcG80DFkQ/QPxsg76HhBsm77/TW+2Qgb
 g45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789965263; x=1790570063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
 b=t732IlAHqzXLjbTDfmPpHy1iAZa/iZN934nAYfzpM9yf2nLuzTgYSasIUezCd/ZNCo
 YZM6rjDGmnlZFOO2PyF74+u0TkUHEOjdR7WmZd5L5ZXD/t05HYu+ojKY8TcQWOZ4o92f
 4uTG/sRB774QJJd0phP3QGJOVK6szwopo5CJlbkpR5wF+NBVCuOTV74tPVKKOf9Y9iJQ
 ZW5doQuuP1/9UWgiOhAMnbGGeTpjO3aYa2upUOCsgSoS9G8Fnl0R7KranEBU+uFztlMG
 jGkxWxGamD8jIYCo92wQvgQ8jO0DlJ5nF74GtXNQiafv5/k+bLV3hhG1+vk29+V2157X
 xHow==
X-Gm-Message-State: AFuF++kJqUVOfqNKZqwxgCqepthFvrOnNOSNuT4v/Ww/mrN/dTpANmCB
 5xRlEGCdORLPkoN3aDZTL3ZrimLVITOKyW6ULNXqsySxps+V+/832tpNzrdTzfc/p2IbI/y8QeV
 +fsOzCHwV8ytdP/qsIkIGLMJbfCoEWVlCXu4sa1l7raLW0pA6mYkyJ9ayxZ7d4HTFscEdQxg=
X-Gm-Gg: AYBFou0MpCqBlNrzUDdAkUJAHHpjnbFhMzMMBsdnXEpHeBIa094JQpBCdIOESybhmOA
 cAZPU/zoudeHPq6gVQnHoLZXL0ikd0/51pXbSi0mkyMIKCL7iqbqMbvweLPrP6EV/gLSbb7u0tR
 v0d9D3hKnnGHoDGOxosqRoiuvKLqPifThzADzkVm/dqiB/o4LQPsU9xGo9TkJzCxjW9JTPhMBsq
 eFWEOaiONQv5+Bfc4Wso0k0qyGg+KX33i2tq0RSeRLgGlPXZ8CsLIsZd0mHNcOqL5w8VxqBmgio
 gYP9+uM8PBK2uajL3bAIINkpfkCt1NBu2wMZUgxoihDV3UOOOXQDhSXdcRNcKnvu00T1YL+GF2Z
 P8xC5vZnoo9ikbt7h67RnhJDth1+isxA4+rUadpdVOsljVB+OhIOEghybAqgv0EkwyNl9O2UZkz
 NELnibfC5KzBELad7i4Q3qODqJwNNa
X-Received: by 2002:a17:90b:224c:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-39e54e7c18emr14171337a91.16.1789965262839; 
 Sun, 20 Sep 2026 21:34:22 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-39e54e7c18emr14171316a91.16.1789965262356; 
 Sun, 20 Sep 2026 21:34:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm19427279eec.30.2026.09.20.21.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 21:34:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:04:06 +0530
Subject: [PATCH v3 2/3] board: qualcomm: lemans: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-spl-lemans-v3-2-de4b54320c71@oss.qualcomm.com>
References: <20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com>
In-Reply-To: <20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789965248; l=3706;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uL9829iu1Sowg7vKPlObXA1MGhxM7+CD9a7R3Dy0m+g=;
 b=x3i9y1vMaYxDjU196JQCNKnbrlBzqXee+AesvFPf7dRtfZoUcYftcHwKS3XMF7ehgFPhMP5qW
 MQhFbiwQCLdAfXIfk0YSTdo4PHbnzU4/D/Ts6y3B4B05iPdEIpbXVD4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=HIZWhYtv c=1 sm=1 tr=0 ts=6ab0b3cf cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dbnLsFstSkEHw6BWF9QA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA2MiBTYWx0ZWRfX85J3hcf7Ulvk
 jFqAPxvDjRrcPZ7WifN70W13yzRQrvlR/GSGhyu/Zc2nbWndIKztg2xVL87GyLMH8gCtD7lT1Md
 AoZ9IdFQyWXHLMnoyxRUp8H50n6cNsc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA2MiBTYWx0ZWRfX645UtIuLxSj9
 L1uVzdJdIRQW9Rwx56mr18+kuWkyYEpgwR6rSi0uCS6XEvOavrJsQwD/tGtLDjRs16MaEQqz5lp
 2Cw2/FZAxr5g+cgbIpf7SljOdEMJ2GT1Eh5chODbHNXjH0gwxy1o61vzHBNdszWjUqa0cf36Zlt
 4r0AhvMonWfNXAHXh1qf0D50X3yCfpQ0JBwUOyho4LoOWe1OmSFAkzeFWk56A1DjFyAJNJnMJce
 8K9rvULoREcBILTRhmbxNps8BIOEedL38w7iZFl9zVqXCEgS9F/9yIkiQUjDofApYJYt5K4WDbf
 FSny6odBempwoBzRmjP5jmikmV6TODYcEXFaQwh/+GNV4JtSYNpVAIMRaysXeBvhZHJInepQD3V
 hXoLRap/geEsMgdhwaf0PRexQ6GW+VFQI56UjcYdvqbXCcU24DFqOsPkBbWcgGM+dYJbZQPnJI/
 M5EIge+7mO98nMFDDcQ==
X-Proofpoint-ORIG-GUID: d2d9x9zEW73xO0yp4ER869H3Zu9EZdGV
X-Proofpoint-GUID: d2d9x9zEW73xO0yp4ER869H3Zu9EZdGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210062
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

In Lemans EVK's SPL based boot flow, it boots PBL -> XBL -> U-Boot SPL.
XBL brings up DDR before handing control to SPL which loads the
TFA-OPTEE-U-Boot proper FIT image and hands control to TFA.

Add board/qualcomm/lemans/spl-lemans.c with strong overrides for
board_init_f() and spl_boot_device():

- board_init_f() mirrors the generic mach-snapdragon flow but skips
  the pre-DDR image load and QCLIB invocation, since DDR is already
  initialised by XBL.
- spl_boot_device() always returns BOOT_DEVICE_UFS, since XBL loads
  U-Boot SPL from the UFS "uefi_a" partition and leaves no PBL shared
  data to parse.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Rework SPL support on top of the new mach-snapdragon SPL architecture
  (board_spl.c, fit-handler.c, qclib.c, pbl-shared-data.c), which
  replaced the single monolithic arch/arm/mach-snapdragon/spl.c and its
  SPL_QCOM_BOOT_FROM_PBL Kconfig option this series previously used.
  Lemans now provides board_init_f() and spl_boot_device() as strong
  overrides of the __weak extension points the new architecture
  exposes.
---
 board/qualcomm/lemans/Makefile     |  2 ++
 board/qualcomm/lemans/spl-lemans.c | 64 ++++++++++++++++++++++++++++++++++++++
 include/configs/lemans.h           | 11 +++++++
 3 files changed, 77 insertions(+)

diff --git a/board/qualcomm/lemans/Makefile b/board/qualcomm/lemans/Makefile
new file mode 100644
index 00000000000..2a908f948ee
--- /dev/null
+++ b/board/qualcomm/lemans/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SPL) := spl-lemans.o
diff --git a/board/qualcomm/lemans/spl-lemans.c b/board/qualcomm/lemans/spl-lemans.c
new file mode 100644
index 00000000000..0556028248b
--- /dev/null
+++ b/board/qualcomm/lemans/spl-lemans.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPL support for the Qualcomm Lemans EVK.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <asm/sections.h>
+#include <cpu_func.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <mach/spl.h>
+
+#if defined(CONFIG_SPL_BUILD)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * board_init_f() - SPL entry point for Lemans EVK.
+ * @dummy:	Unused.
+ *
+ * DDR is already initialised by XBL, so unlike the generic mach-snapdragon
+ * board_init_f() this skips qcom_spl_loader_pre_ddr() and
+ * qcom_spl_invoke_qclib() and proceeds straight to board_init_r().
+ */
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	preloader_console_init();
+
+	board_init_r(NULL, 0);
+
+	return;
+
+fail:
+	reset_cpu();
+}
+
+/**
+ * spl_boot_device() - Determine the SPL boot device for Lemans EVK.
+ *
+ * XBL loads U-Boot SPL from the UFS "uefi_a" partition and leaves no valid PBL
+ * shared data in r0, so the boot device is always UFS.
+ *
+ * Return: BOOT_DEVICE_UFS.
+ */
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_UFS;
+}
+
+#endif /* CONFIG_SPL_BUILD */
diff --git a/include/configs/lemans.h b/include/configs/lemans.h
new file mode 100644
index 00000000000..b9e81fa26ac
--- /dev/null
+++ b/include/configs/lemans.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_LEMANS_H
+#define __CONFIGS_LEMANS_H
+
+#include <linux/sizes.h>
+
+#endif

-- 
2.34.1

