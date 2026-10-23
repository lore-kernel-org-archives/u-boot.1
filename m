Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F36606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VuDAvvtJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N09eGbFM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dYgC73Zy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C96940894;
	Fri, 23 Oct 2026 06:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlC4-AyI9g-0; Fri, 23 Oct 2026 06:48:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C17E440855
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792738107;
	b=VWLUX2Y2QE5wozUdLDVjW0h+U17z/A45Mt38y4mz9QaVZSdJS8qVXQEJd6+wg1KdLske
	 D3I8URBBnlffbv/MtbrjbRkCvXumjKb+YEcvPnEz6RDr2CHFGjVreD3Nm154asVUDDYhL
	 cQK8bVg7RrbhXVwl82ct/oAA/PX8zit1AGuV3+2CYd0m5eo9Ade6JpfsyjpSByQ389gHs
	 uCGCl+DNekv2hpz+7V3coPR8NQWJEsUlJaISOEgL/FZI2eSj8A2i83LPX+hoqm0dvVzR4
	 3d097a/ThqwEG0nH6XJCZDIm4xAcoflKXpCMBmtzQgmBJclOz4fh6nquOEtkkQp1YyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792738107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mJuFjb6mYGuILeIwMvJAZrQFu3D6ZcH6F7h3xuq8fAg=;
	b=G3Ss0a233JXF3+unB3lDtEviTLpGAD+taeo7S8Y55s5EA9P4xONzOdfaOWI0fO/qny3Y
	 sUq26oyYmdmmWQwBbSFRbTHOtzOfBhvrqwA8n4JjUTpgfnacsWKcXkfeIIIsGP7FPL9LP
	 55M0Ax00XtdpnYx6gbQ5pxjUPTQ5Pu96v1O+yWRo0iTqwAcknqs1BSJV1C+yFGeiLuQsj
	 0CGl48Z9O+tbZIYCWZwLAeDoBHCxoVENv6Jo5hytIJDMjflG0DCNFOG3rW3Ksxb+zhbIr
	 X6iutdCcX1RM3BoL20cV+YuKUW11koHHXTZ4U7BfF/yDx+WYlFfzAUIXNJ30yvSnIlQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792738107;
	bh=mJuFjb6mYGuILeIwMvJAZrQFu3D6ZcH6F7h3xuq8fAg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VuDAvvtJfKRMJsQigj9+/3bATC8zNvDkQf5z+ww4GgvI+HAIoP0L0BY1p2vbB1uIU
	 Qz/jy+RQo31ETZTZUbWQusOWVfWiGxr+uS5Djj0DmgkcWrWuluw7z89Fj4fJKCxOIP
	 P6vyjyyaAcY98WKmsT+oCezFXFJppsQZilj3wmn+QvpKmCGZ9nxmqbPsktzqUKhWFu
	 B9aZZFlMWb7TQMlSX6YDdF8ydo+dK9YWqNMtHJVxpfgj7vzCalw150ICbaPG56i87f
	 Zwg/HW81OYpoMvopOmH8n3KW/O3X4TwRvyt0KibnlAJIAMCu/KbN6ssNH14c4yTb5N
	 clgCDMIU2Xm6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C17E440855;
	Fri, 23 Oct 2026 06:48:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4069E1FC8
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DCBF81092
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id woOorwW6pR5I for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 06:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7930980FFF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792738105;
 b=UHbc0kAS41HXf66ylEIMVH6nZX1FYrzqsD2JSqs/HOX627rOAl8nfRZR8FqGKEbEtL0u
 /1VfmGBzAOHAD6cgWQ3ZzaYwZ9KR5J4Kzv8zOxvGfsAcCNq2rHv8p+E1UiJ99AfeoIaZl
 RRLgZsVdGoEzRIh/zC0GjAl3haRl6Fvh1x2PE76hRr4WCrJEpU3Tlm7nBYdkHddDYJYtB
 a8gRiw8oeICXuLWg9dUkE2jcYkKHNiSSIm19jAP1L1M8znX789oxFZldsVaosAaGLu0BO
 lF70Xglqma7jtM3u5tmtqDHtIuPA0OaSqNIBAAGKDJehmSweGlE9F8VYla0Om/5bMJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792738105;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=mJuFjb6mYGuILeIwMvJAZrQFu3D6ZcH6F7h3xuq8fAg=;
 b=UUAvR1oPWqcePH9Q/glZrGvvheCqEN9jSObQ/N7iu7YbPmgkmBZAhAYMTQMpvOeYG8mE
 +iaxR3f2Huylz+v9aLSVhZCheXmI+z1fMm7/c1+BgvGB0yJ5Dif4HbT1H4Q5L5NtKLfBN
 teCRaoUyrzKj092ZJOtmNYLZx9a0bqtOtMTININ+XM/CF68KKETF3+gQKIZUv10qgXmW5
 NP6D3f8xR8br43IkOyUaWHp+KOsbRQnWpPyjlqdZtMn6McuMaJjgDvrnStfvl8yELBUeL
 WH2f6Gl1jtgCLINDIcJlThju6xT0lMvXAo/DpadIBoan1KMt6SoHli+/KQK4L3h6XGw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=N09eGbFM; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dYgC73Zy; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=N09eGbFM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dYgC73Zy
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7930980FFF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:48:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FkZn4008217
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mJuFjb6mYGuILeIwMvJAZrQFu3D6ZcH6F7h
 3xuq8fAg=; b=N09eGbFMEHBHxrc8GO2ntKMOlRVEKHIHdxx9PaATEaTEhaW1ts8
 3lj6As6zOVaXDbG0wj2CWVTlsM+lvPaqQ28Ryl2whZabpWbaNBc9E+OkkeQ7FfFq
 0xzzUZ1bTCBWwwtWobHYE5yc/DuMLc9CLTkrxdXZpkXa8ZpBliC3KTABz5O/2KDy
 ygTOIF/Phr09C22eYamq3KwRHfFBEX5zHJZY+bB4cutnrRiBKJwNOQDAHEj6+uhU
 4EQNgUCLaxeNLygVWkuu4Pa/NozUtbQPGJZhpHeu/BqoLVHUrB8GnjvTUxjGyDsS
 392LgHbHVW8G0NOh3ybHxuLvhkaZTqegF8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmast8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:48:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso979634eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792738103; x=1793342903;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mJuFjb6mYGuILeIwMvJAZrQFu3D6ZcH6F7h3xuq8fAg=;
 b=dYgC73Zywt1gUhZxal16kLaixVI+3VjOJsaGXo8NMAQZ/UP4FeeqOxxcvhSKeR7BtN
 fsFGyw5jgXbxyZP9psmBcRCoc9tqWZaQv6VxmInjBa8CiTDAOAJsAwBPVbp5e+7QNVKU
 EG14zoqii7+H7oZl4o/v5tVMUllQHLYvRhPTvIiUvJTD1sDn1+/dMbyWeHixZkfUkpiu
 yCvxAhE91eSbHt+UsBUCm0gsXtnFyVIoBPuarSuHoV9TCOPFC8EwkHHlzkUAGqnJylUA
 AwJiLgBh5nH9cXxRF2xtJWhz9Xsah3Y8lUZdnp4fjD01zfjyrMXM3N0YuVwwtOJ/1wd8
 yjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792738103; x=1793342903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mJuFjb6mYGuILeIwMvJAZrQFu3D6ZcH6F7h3xuq8fAg=;
 b=Mm0me9HInw5bfulfzxYpfqsT0Ml/OhOjt5vSHmU0xfGzKcptqJbqbweH9G0vJ2fu6d
 lfwPDYtGf1C+eaiE+ICGsL9QC522sliC8ch7+xnXj4e/HtWgFil/RWhKwzw8nuJGlxqK
 koQjGHlff0gKN+opEkd0FfcSvlhwgxHqrbnMKLlJ5aTOBYLijUQ8cAadIOegAUOaLHu1
 PQrC1uU6ptUiDwBWNIfwNVf9O3E0mHfbq5A6bKAs8PZcZLiIRN0NXNyzBhq712DZa7ZB
 t2j2oTG68IDRp36bma6/JUG32XN32wHI+QwPQGE19wmIAOIrkxRfwxCMSwuy9fmbb0nt
 45Ug==
X-Gm-Message-State: AFq9FYLhkX+0nwDgisWGr2M26eDVaHUQSNeCuigj6+zvW+EBxowdog5u
 /ya2MmgnNf4wj/bDYpcCMo26ZIGkzAOegX0h/vqpPWZWZ5ZBXmuM/RvTztCxMjsn2jEvQ/p3/9l
 tk3hHDs2dvFxckc2hfUNT8Y3+NYESqijU0NuvaI8fKy5DnZCX/4LFI8LczDwyLWYlujwt/16Mpm
 yE+b8=
X-Gm-Gg: AYBFou0dHeyioQN/jQV8WCa91Z7gk+wYRLmL29ExJA7GwpPmNQ/qMYubN9UnQGFP7hs
 Gh8/aPu+J/TrjpOpKXJEWtVHieerEA3cMg9BBwV97UNoPOhbGua7G7n+Slv6ITPptf33QHGvU2r
 WGQ/NNUZts/20CArRA6zWNPFZ2aYqiHmR5udgDf5CriPkH0GRfxssJLOPJP4mlrXQinV9Q9NHPO
 B7FaV5bkIFMv5mkDHwurEyehF74NyXp7jUKvCHwKQdCZHqlV4B02V/fIWrMQkXEUhlPHKRIIEsn
 muy9Ao46OxIVMxS6z9mWkUmTNXEdHplU70AiidzraD0kcxn3mlU02YS/yVR4V5pqnPeeHy+QA59
 8VD0LmtmmLJ9Y6EK+VOnTqSNeEzqF5wn+WFBEis93K3eWxFNgtiaWV6lGTftf4CjAMEoIVEUepl
 2DH5qBthVwZRnl7JcSDuqgz01Zs82QYt474A==
X-Received: by 2002:a05:7300:e9d6:10b0:35d:ddf2:e986 with SMTP id
 5a478bee46e88-369d973192bmr2140016eec.11.1792738102853; 
 Thu, 22 Oct 2026 23:48:22 -0700 (PDT)
X-Received: by 2002:a05:7300:e9d6:10b0:35d:ddf2:e986 with SMTP id
 5a478bee46e88-369d973192bmr2139978eec.11.1792738102095; 
 Thu, 22 Oct 2026 23:48:22 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9defcdcsm7501794eec.23.2026.10.22.23.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:48:20 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 lukma@nabladev.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH] clk: qcom: ipq5424: Configure SPI0 clock
Date: Fri, 23 Oct 2026 12:18:13 +0530
Message-Id: <20261023064813.1059535-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb0337 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=3tfM_TpoLb5ewJlfP3kA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyNiBTYWx0ZWRfX/xzohj24rakJ
 QRHPIhpptxQykNrLRbc4AnYbfWDjAjZ0eduB1mdNgqVwjLFdyP5fuKrOcG/Y8L+5h0rGFNMKXow
 9O1hieXzToRmWkCWlRbXTDMGAMHakYY=
X-Proofpoint-GUID: A-iOkAmJhEbb_vc3YohrEaF18zyjBfbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyNiBTYWx0ZWRfX5cVRXu99ck7y
 KkpuA2obBHgN1D/uGCjhmLuBJ/sMnhsjD2n+B2KtQNfBk6mLkneXr/jFB4lo/DRFqbYV3bpEEyu
 Mh74fpZD/AZQVsorzqycpUUBCwHeLEx5d805pshU88NVegVA3Eb2jxeXTw8v91Jq3EwcMee3LeI
 byJjNYTu/aVbXIFrXA44mwkvKpn7RA9Jt3LC9mDUaSPCmlBL7AZiW4I+Nt64zgy2DyQNiTZpHrg
 m0dvkCG5lWChVZGQy4cw1Irwl6hQRu2656lLLTCaApCn6q+juGVh6d/6Kl35zfGTcxCL5Eq1GVO
 QaHJ5a1vDURV/o/TmbfH7s92mt1D2eAm5/vJW+mmY5NSK12YN/HeSl4HWeKUGVVw169qfzCuCYh
 50jSuIIxkzHJ4+EXZSKPbE8NaLFvB2oKYxw3BQbDSGeaNA3NpNamKB4BhwMLfJso5HpixIgukJx
 lJDjOL78adkbznOMYDQ==
X-Proofpoint-ORIG-GUID: A-iOkAmJhEbb_vc3YohrEaF18zyjBfbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230026
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

The SPI0 serial engine needs its clock configured before it can be
used. Add the SPI0 clock gate and set the clock source to 50 MHz for
the RDP466 board.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>

diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
index 56677cd6f6d..4da734e2c91 100644
--- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
+++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
@@ -17,6 +17,11 @@
 	};
 };
 
+	&spi0 {
+		assigned-clocks = <&gcc GCC_QUPV3_SPI0_CLK>;
+		assigned-clock-rates = <50000000>;
+	};
+
 	&sdhc {
 		sdhci-caps-mask = <0x0 0x04000000>;
 		sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
diff --git a/drivers/clk/qcom/clock-ipq5424.c b/drivers/clk/qcom/clock-ipq5424.c
index 40823a30ead..927ec7a38ad 100644
--- a/drivers/clk/qcom/clock-ipq5424.c
+++ b/drivers/clk/qcom/clock-ipq5424.c
@@ -20,15 +20,28 @@
 
 #define GCC_IM_SLEEP_CBCR	0x1834020u
 
+#define GCC_QUPV3_SPI0_CMD_RCGR	0x04004
+
+static const struct freq_tbl ftbl_gcc_qupv3_spi0_clk_src[] = {
+	F(50000000, CFG_CLK_SRC_GPLL0, 16, 0, 0),
+	{}
+};
+
 static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	switch (clk->id) {
 	case GCC_QUPV3_UART1_CLK:
 		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
 				     0, 144, 15625, CFG_CLK_SRC_GPLL0, 16);
 		return rate;
+	case GCC_QUPV3_SPI0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_spi0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_SPI0_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
 		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
 				     5, 0, 0, CFG_CLK_SRC_GPLL2_MAIN, 16);
@@ -38,6 +51,7 @@ static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk ipq5424_clks[] = {
+	GATE_CLK(GCC_QUPV3_SPI0_CLK, 0x04020, BIT(0)),
 	GATE_CLK(GCC_QUPV3_UART1_CLK, 0x302c, BIT(0)),
 	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
 	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
-- 
2.34.1

