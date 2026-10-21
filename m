Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6F606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lbM3q01G;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T7rDORBu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duax5VyV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BD1160895;
	Wed, 21 Oct 2026 12:46:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8wF4U_FHnvP; Wed, 21 Oct 2026 12:46:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C69CD608DD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586763;
	b=Zfv2m7oIhnLVS4t+PEle+yAlLyZgbMXRYPuYFVoRC8V2U1S1X4MY4emKWuJ9O4X5Ht35
	 Ec5uutn7UIxdUIlxWaCpB9gHsEf4FTtCMRKFeaTu4FTEAsvlBu8RYT4tgvITKzCReZ8xt
	 ZyCeH+IuM7N/OsdkAsCK/c4ostgfmVIf2bQzL/f+pL722WRl6GfL9VIQHVEGZ/6WrNMsD
	 F7L0WJ19bJtAiQ1TMfKvuN89DyUtcYR5qRcfpbyoIkjnMgazggA+/REiohIuslNr9KsCW
	 vtlGlZgcpabZhKq30Br/oNYuy6bvCrinUToFFKU4XOG8TNw8j/XBBmVO3WPrAqw7YsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sITdi405vnDr+bvL+nrsjfaAu2igOgOFniPKBgzKWyA=;
	b=cVELCHvsnH4KQwdyKbwEqWISaJU3X9LJnylF06Col8OAq/jYTcQly9fxJttze9uPJz9Z
	 1dW1Y/ehIdnxSBeFmskzY4d3YC6T18AwhkGrmrYgaPL4MvX9/xLYDduBitMcO5HVSCE9f
	 IjsCNZC0jzH3YIFB+c0rqMU1aOyzb8bQxzDHSRFj/e5RXZA3+BCk79brgfhr3LuiuRS2Z
	 1k8esWlv+oJWDMKwLZV7x0RBiovsV0VqcCWjdnEZf5D9xiQewN81EcV7fsNY/Wwkq0eFL
	 7r+3AzEjIIh/DQrnAb6k+1TMIdHF+zbT853QYVTi+zgSndFThStM7mD3vSS3LALp+Xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T7rDORBu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duax5VyV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586763;
	bh=sITdi405vnDr+bvL+nrsjfaAu2igOgOFniPKBgzKWyA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lbM3q01GclMnTqNIG57m4U8pdlAb0Dapx2vkUe3D1ORNXAGIFDfKG0/dxhzH/ffuR
	 5O+lPZ6piHEA+leMmrJ3RIIuU6PD7SrGLRs3xu7x4o1Rp1zVPk/P9Do8xsaYy98b63
	 ZZnq2AbKc9e+Qz7RMQh35NJ6Z7gS+5tfQ4XuiSN5cu1dUpl+ltKd3Dh6xICB43DSHn
	 soa78TlwIjpFz+Vh70PawcZ9Xf1OexvlfSKfTDeJva8vUxS5CoKG00eN75slkQv7xF
	 1GHpJcb0zNcqEdhc16ZdguGJ59JPX41U13weS3GX+imxkWdTVGLMV7NjDUlkCCNBNA
	 6QYDG4oiq20Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C69CD608DD;
	Wed, 21 Oct 2026 12:46:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 787E9279
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EA1560773
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WXb4vBhcCQW for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:30:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 55E0C605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578635;
 b=F4P7tzaA1LtkO6Tx5w+eC9fce9B3clylf8W+8WmnIC21vza9KdVOR7VGEKbmvSbWLJ4L
 8MPHbbvKudoGw6FhEWSReGO+CPQD1aWcmID4Dm6MvIA/2Gd1x/jHVn2LpFz8NVskwjqKG
 OFHQ5eWEmioMjODFXj+BX5dFDSLrKolqLQigO5sLXKZgItjvPc6PtV4BVavp1KxaBSfxl
 yhdFuIPvgqC2kDZXnWU9GGxYqhLInpG7+5h5GQ5D74kA8dCyNB3KvcRRnsSnsyQ6LCXMQ
 Mn/Q9FOe+lDtruMypCMYTRSTSVslMYJEArO+aQ8cjC++le1PXdLPXlsd3QGKJ6V4Z0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578635;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=sITdi405vnDr+bvL+nrsjfaAu2igOgOFniPKBgzKWyA=;
 b=XejF5/99xFMlSJttiB6rpR64eyyz6N1mMsUXO4uQXGOEVNjbOrhpGiDcPeghewpRTSNO
 i7+m3+PlDXkVLqIW/GmxNKRc4AzAHyEgtMswCZxCFJeulYoXIskV0lh8eu/JvK0F1ifuA
 d/Z419sDoray1qKoiLUFOpn1LZhumFByHFFS8gwQZsHH2CILGuIpIMGiIksRMuicfUotD
 RQRUuI6OfEXslxH3CdibKeWFgum2LRZM0jnZe73Lg/2ivmO0eVqXYT0rwFR+VQ74+6Dfc
 jdBmOIK+bYa7DqDAyib0xwg9Zmc3uf0eFjQjR6KORP0n04495K9ujpWnbQ/tDkgppog==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=T7rDORBu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=duax5VyV; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=T7rDORBu; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=duax5VyV
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55E0C605F5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:34 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA5nmU3449758
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=sITdi405vnDr+bvL+nrsjfaAu2igOgOFniP
 KBgzKWyA=; b=T7rDORBu3Dqv/1u2V/aAchRGVQo5Xk4tI1K3HimWFopqZgEoiyX
 aU7OAmTLMF7vZvLiLRArDTMDPBeAF9IBbnsi5msVKtspUW8rvuXlMOHJPeqotjw8
 qFvngHsQoCTCuX+fq/qxfnVQuVjC92d8RFEh0AfZ9sOqlcLENCepqv3FNXA+OkB7
 EWHHvsbS2bNEST5y5Sy3pTDcR94AWtHhaNrNuFTIyu+N0BhWIXEvDPRfl+mcJzsx
 PuOsn4n9Lfz/qRIzyneBFsAr3pQpITTxI+HOpPva7Dh5hs+wFOF64xV6wh0mfiIg
 fNtKg1W3mQrJv1mvoGEZSamBt/zahs3/YpQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9b9gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3580c07911eso1617754eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792578632; x=1793183432;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sITdi405vnDr+bvL+nrsjfaAu2igOgOFniPKBgzKWyA=;
 b=duax5VyVnKyPLINpSwj1wZbjWchAI8VAVTvHqH0zx6CUgyTPU0hMnme4cQwqJpvPBe
 vBS9wGpOp8Y4wWS5vT6k0/4jTdjfdXccByQ2WcRrdDTL4KG7tWPcT7i3T1zzPsP1mfyz
 v44P5CC38XCEeTrFBF1vQcLIx1GLTdJY6Ulg/b0VyFyIw+vnDw6Rdt+PVQscCXnhxJ0E
 gzyqeQJzEmj2UkOpyn4Bw2P0lEITNY+6hvBtscOs3hQXrzSRg712/b4pzipXAxo7vyQL
 vLsEqkeJ3dV+CFp3WPq3PL3gvX1ZrviNpuA46Nqw8RpXE4ZlAZrpnF3LOt+GLLkVN2TC
 r6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792578632; x=1793183432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sITdi405vnDr+bvL+nrsjfaAu2igOgOFniPKBgzKWyA=;
 b=vo6x9n0JQH60Q0TfRAcGCcY9ETZif20ttkBHk2SLrnQwP5eWdHZNIrTC5lbTxW3UzL
 ciqx30rJOIeMIyKEYq9zOEv7t2Oc7gqfBpGbcWmz00cKQCheA0TkdWGK+ax7wFP+DKE5
 HIm28fslbpa1eDNjnf+75yzX9KEsluOIerdOE1YG6ZgZ/Ri8DHIidBniFGBAV0xIwtSZ
 h66j22FVhh1N8u6CPCZGNaXnbN7OJ/R7ZKkYCZnKyKuPC9SpLLyuhoLPf65MYZB6Bj9/
 X86ONHmAchalV9M6Dvmw0tlNE/ejODCCyDxlqibiGoxM6XJu0oVRxobi6z195z+u/Kbr
 x8hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6GLIf7+dflF9k5uLcLMisJkAkLp/9hPADluXuugt3HW/uXElYmUg0ZxSpjUfFctFgQqgeG/w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK751IapqQ4NPtMsg50Qma9zcTQvB4NS5giLSyJ1LcQvI38l5Xr
 449vk+kXTtrAJf6+VQYA6KlqWtO6Y6sU7k8Lvn3qYYhTSIT8LNE6wA1mSM9QnUVpVknJTNGz1Aa
 MCu9QogfltbrLAIkwUd5io8CAOJ6c5fWyU29pBs/sJWrAMlA4XNAvn6d11Odh5aSqYyZ1g7U=
X-Gm-Gg: AYBFou3FsdaW7J4KD6hC57ecJTyTEFcOUkOcsSDF2FydjC8G2fSu2J/11RU5Ps2w45t
 mX1Ck+kVTDk/U//Chn+b2CluobxhyLApcGlNPDJrsgmTm41TBoVjn4zUY43ptigwC0YxwHVLpC0
 kzxen1vjHVIFjNzHuI8Yk0Y2in7NyuAUQ5qJfqnOn8yyGZkdiM/A2qQ05bjCNES0LUbB8jUVcd2
 XZsfKr3wUWeq0m18NP7KA6x+tLeLn/PFQIwSKNxXdqeVGR7a2pgEQC6CnWzlW5mTUgk2OzFX7lm
 d6uU+mCSV3T8AU563zUmDXG1Qt8jox4CoH4pe9i43HWzjKX+6PBdu0xa0kHW0VES4f03G4tcdqh
 zBTb+rc1g/ieB0lYtzS0TbySHisybgp/8537cKcW+4XsLGgFzooIZjvRWOwhUFH+zdiJkdWKP7M
 5HWPg40R4NqLSjOJJs
X-Received: by 2002:a05:7300:72d0:b0:360:444f:a56b with SMTP id
 5a478bee46e88-3674e450f0emr4179715eec.12.1792578631894; 
 Wed, 21 Oct 2026 03:30:31 -0700 (PDT)
X-Received: by 2002:a05:7300:72d0:b0:360:444f:a56b with SMTP id
 5a478bee46e88-3674e450f0emr4179548eec.12.1792578630328; 
 Wed, 21 Oct 2026 03:30:30 -0700 (PDT)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405edd7bsm6147480eec.6.2026.10.21.03.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 03:30:29 -0700 (PDT)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot@lists.u-boot-project.org, kr.sowmiya@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 abhilash.v@oss.qualcomm.com, u-boot-qcom@groups.io
Subject: [PATCH v1 0/2] Enable DDR training in Shikra SPL
Date: Wed, 21 Oct 2026 15:56:00 +0530
Message-ID: <20261021102602.3815107-1-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfXzF8k/W/+sp4b
 zUA4bfpm0CoUDuy1kz+sKwCEnmd1n1yzmYThaeF5Wtt9FuBUeEx39WAVBFqrX/aZ95FQyYIW7dk
 4Or0xIYVHZtyvyN708uFVcmgBzQcODE=
X-Proofpoint-GUID: aWIEDamb0BPSwIU2y6l9gbBWi06C7FWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfX+XPTORSE1zrJ
 N1QyHPZlaswSd/VHYHAKhxP+j4xaTRu6QvfO6KBAubezrfmbZGKnE+J1tQA2DZqH2pnbp3SoPzc
 efMI365UuddQhzu5v2LMGtcG+puy4w7LjKHQyZaq8c4lEPWR8M+T3J2uRE2tEpZIU27R4RyFJcE
 Em1RE5R1EKD0RZrBVuvpHJMFq/+sEleX8+A5ERPLcefijYKRg7USUc/Mrlnem7U+7vKC9LR8GuG
 wMd/uHCix0eVjZJv5bWbjTpw67wMX7QBL62BtM9stS+lxg7xqmDU26cMA0iYES2FDws/OzLbbbN
 /N3REl3gbfkQqz1vOv0ayrlpRDsGH9OzBkPsO1m9bNcp8xmpxs7PqPiwtrwnhm6A4owNvpGkTO8
 q/fSwu82DhmJA+XCT9QsDgHcAOjr80djLrWcUSRqEPYqZuNYqGf/dEfKzEXHJKhMFgIOvLaOrAC
 mYk1Yi+FcJMs/enGoyA==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad89449 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=R0JtNs4P8E7CgTWNuXIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: aWIEDamb0BPSwIU2y6l9gbBWi06C7FWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210041
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Added support for DDR training for Shikra.

Following are added:
Reading DDR training data from eMMC during Shikra boot flow and sending it to 
QcLIB via interface table.
Saving DDR training data in eMMC when QcLIB performs DDR training and sends
the data via interface table.

Depends on:
https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/

KR Sowmiya (2):
  mach-snapdragon: Kconfig: add DDR training configs
  DDR training: enabled DDR training for Shikra SPL

 arch/arm/mach-snapdragon/Kconfig              |  43 ++++++
 arch/arm/mach-snapdragon/board_spl.c          | 138 ++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h |   3 +
 arch/arm/mach-snapdragon/include/mach/spl.h   |   2 +
 board/qualcomm/shikra/spl-shikra.c            |  35 ++++-
 5 files changed, 214 insertions(+), 7 deletions(-)

-- 
2.43.0

