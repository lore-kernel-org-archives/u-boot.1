Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F14606A33A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q2KSNw+s;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bpv6Ck0X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h0LKP/9c
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D14E88123C;
	Wed, 21 Oct 2026 16:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-sYhsf2-kPp; Wed, 21 Oct 2026 16:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE5C98121B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599557;
	b=XNdsxn1eBD93j/NcGa877ogQHPSF4ID3Igh+4ICFv58pBz0jbvh6WSnF8nqix5yXv00C
	 bc3t8lauaajFv5i4ul8uwkpXqYCTaS7NA+gMzPyWPqnnE5rTvKqngcZkCkICfcC5/etIv
	 p3Dc1BwM0kVM0pgosObaUhNloi1UTHYAGxmMO3qTg1BAk5DjUzmhAk6q4qcQiefx281iH
	 XigN16jxF+xqzagjLMTZO1Fh78sVfRzkzEMSJx9aMHtHsbXHRUcgD0COuozzLYzH2w06u
	 efHUSUlj5i8rJGSnDzzeFCUw5GJ7FOFrXQUSN7HI8x28p114IGPEna8h+/y2wWY99+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xD94WYEJ489nwbmVGa8Le7btKNba9KFIXVYPkTTb1VQ=;
	b=JnarYcE1pqMZCkc1GpROSu+o8KNFqZBei4m1assK1YGZSdyn1mmerkFiVfrUeMGxUeGG
	 w32G5FtkHsn3dr5h3B/j3OWbRmIM5CJVXdAJwovXlI2fl+03Z2xLdzdNskfbh3Df+zMTZ
	 KyyVMlI4u8xTLjql/SjXL1Skxgr42o+nJ81H1z21AkULrqpciims+jWCl1iFas228Y39o
	 ZTSz4FXDPRQ/5iYFSL+nRe9hyPlozEJgGGD/L09uKmhpvKBEBSjuBGB4sYQhYP6M2bElt
	 8YplIRz0RfUs6/H33SaLCaFRbnwe39MZZBvSvxVmVgUsQ2pZPToMb4ks2+26a3cXE2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599557;
	bh=xD94WYEJ489nwbmVGa8Le7btKNba9KFIXVYPkTTb1VQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q2KSNw+s0O+ztSv3juwZH3ZuDIMg/E0q9jNWb/JUZE8IHalX892AjbJqOlx1IRm5B
	 bVp0ZffKjAUrkcBhc78u6wQP6F5tRFguti3uLIxEDQjmKVLH2smfy4VVjnyaQfIP/y
	 tWKZHGQ6TJmsRG+dKhux8Z6tHx3EyVrV51NiNRPOQELTl9A2uiB8HXDsU/4yJNbT/u
	 eKW45Eedv+7SXPAWQFwxL9XVp8QSiGOSDO8TM16g+Z6gM8hMk5xnZOHF/Rdnpx6A5m
	 LK+hu9I+eoQiXbhRcPVD2/5q+KwHaUjNcTTvW6bhjw2dz5281VCaxzST0YuLf4Am8y
	 pSI4dW6ACPEHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE5C98121B;
	Wed, 21 Oct 2026 16:19:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F17DB95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E15D860EB2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnLsw9IkUcvi for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:19:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D475860B29
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599555;
 b=lO5otmTFwVf6X0LDJOuK2wsqpLOimv7GM47q4nIEJbGAsdO2DBDj7svtVIdiC6JyUvH4
 Wu077R36cmQwEkqmc0NwlrCHvv+Lqpf3S+MNDn+vkEeUPMkcz36ukpDdLr4JJo7xbePef
 7yIUjGdRocqjVP1fYlfFbbJG6L0+kGdbwBcVuGEyXiPQotBg5TxSBw5DZOqiX/AKiauPs
 3BtUhXisESJOu5Ln20pVpH0H8HrtsNo0PTUG1MGHAtoUx3K5hS7frQ0WTpFET0m/DdRmg
 ScsURWk/KSFAC3eE5TfI88Tsg+tMBCX4Lpm54jFp1sAS+MLE45P5Fv/7Th/Di50FO4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599555;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=xD94WYEJ489nwbmVGa8Le7btKNba9KFIXVYPkTTb1VQ=;
 b=N3yNMi55/mxBkLANNfRQ+oVKOXvmEBgPrQLI+MMJDWPHxcUBIrDjgk//XPwf1v2a+yv5
 oUqxP5AxB16jkE49h7W+TXhoeAffhVqo9b6UXTGWp1HLnxe8tf6zZgyewNgnCmfFTb9p7
 pkmjWoBA023NR3AG54cic8+WgimXBg90Q1ktEkT+NW2AgtTAk/38zO+ZUGLKX8Q1mAdR/
 7V0s7m8HuuwdI8dNGs+R3ybWte6QZh4byH4661EUakJ5kAh48OysPdEvsb7O0u4s1B9GM
 jNc5ed4J036cZvX9bamFt83O373XqpOgOV0S7ogn5a8/DFh2Z1eUcmEEWfYEnwO+6ZQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=bpv6Ck0X; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="h0LKP/9c"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bpv6Ck0X; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h0LKP/9c
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D475860B29
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:12 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU06M2102022
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xD94WYEJ489nwbmVGa8Le7btKNba9KFIXVYPkTTb1VQ=; b=bpv6Ck0XvHrU6ihY
 sh3dNbbgLZEPt1usCze5BN893mf34x/kJaVDuFqysFSMuNn2crbYMpqDnM9p4RzI
 lU6wRgi9Ym8I4t3tDbpfwnI75qjVGHxN+cAVqPgg9bHKzCIGI4XqyyaieAlW+m6y
 wud9KLDgvWiOgxVoJVg9ppslLNMUytlgiMpfH7RgiLZVdCI7eHjdYYkXKvQqwVZk
 DW6LhyAnQSSoDeVufOByzRWJAOqi+U9PfGcr8/9lOWuvV1XFSU8rlfn7PUDxw1yp
 HH5jq9WgZWe5G8TaCTfZoq6DInCAh74CL9YijO3kudlLhOWssbV11wpFSG7i/prl
 dEUaCA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhuheqr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:19:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so2279565eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599551; x=1793204351;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xD94WYEJ489nwbmVGa8Le7btKNba9KFIXVYPkTTb1VQ=;
 b=h0LKP/9cT58vOOHxhU99NABi6FIZp6NUV0dOn6b13nIR/73kXZuksb0VGjdmJ09ifQ
 CO4UZfnmFA+eg92KJuSc6RsaxmfVZHPE3pRUUdUQRMCph9JRxWUfNCW6HIKnJJzjrKd9
 ra9Kup7dn6aeAkgiyrdaV/lXlz9cO+4BcEi7c8YnxS9m3PAkQn6x1watymzr3K84qImq
 D/dClHZXiDbMwlSe8eGJSQiO+MNFJn6zgMjxxEb41cLvmA7MFOzuy/jcNT2v1JcNlPC7
 tAinPCujX/7jOUYP7T9+Gp1A7uceJ/meqW0LNpIanFKMu4jnJrpxFDYFnUxOkEFTNzxn
 LCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599551; x=1793204351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xD94WYEJ489nwbmVGa8Le7btKNba9KFIXVYPkTTb1VQ=;
 b=aD1oLTTJ7rxvetWxkMVLsTrn4Eq/9ltvK/gxmHkc6RImUJbYNeyatFQ+SBcsxz8vuT
 JS8uqepZzI93JW5sRqxV8dWka13wSysOYwO1WjinMbMLFjRXo7JKeWUQzrRVV+QiKP0Z
 L2lJa/kSY7KolFsT+yIJv5MCJMsWgyI8EteL74KNVQkFXZsYnK5QBW2z73kd8bxJRZXg
 tb3+3BJogquIb4/1ZAduJwnYh/HJozUwtbI7jbXNVUC7xWuS0BA+BS2hk1R2QrGqWBm8
 RJjlgaYnRrUJbt+byK21oho5HN/gGmrcyQT+mG11wnM30eG4jXtufxaXhjMCKVF5jn5s
 7BXg==
X-Gm-Message-State: AFq9FYLK1MvoftiFIv/DyDNL3Y7S+WYvr0osBXiULDZ1RT98erI8dRO3
 g8eopry6+TQe4s5EEsHUiM+8ZVpxtSjV31n69Gk79bvboZUhbdGYWYH5LX6WGMoBmvOqTYp2O6G
 LLzNFIeEMmwd+Ys3yGCdPOOJ3itCewjF/AitIR4MkOPKAtSE/gqFsW2lIVxoG6lNTa7pLEjM=
X-Gm-Gg: AYBFou02MTCE2iR6EesHcn1anOgdY5EW4zonbJ+Xf490+zV/BHKme05FkpxiZ7dvL+r
 LVlM9Lt9REOtZSdgvbLhnJn9lpvapidZ1gUrxHyJnVPy4fcGrNF4JeRX7S+R4t/0vjSwDAEg/KP
 wuODFRgDVxySNPg6LEt777mYG0vLZLDiUfnrEBWcvzrXXbajAt965CnDhFy7QGBdGzk45h+Ppmx
 4oh59ZeEKUUImr9F2IsH8l2GTiqbZAPSGtGbSAKE2pNFM+kRwR65kV85VOAoFMyoU2y+ijYtBXX
 Xw9pTwGsko+uC9TaUdzjW9srlu9MF7/eiaVjMH1J9NgUmhq35UraSM1FjxVu1yCoj3Dix8GjHAl
 H3GxRcFLNFszTktEylsYRHGwM+mXUmYYcrq9NbfRqnbs5M2MYKAUNLt0FRnaZQr3HtVk0AB5l2I
 qUdHSuxVq87UnTObaY0Tmc0ETtV7Q=
X-Received: by 2002:a05:7301:e118:b0:359:1b05:ed30 with SMTP id
 5a478bee46e88-3674b53008fmr3479127eec.4.1792599551296; 
 Wed, 21 Oct 2026 09:19:11 -0700 (PDT)
X-Received: by 2002:a05:7301:e118:b0:359:1b05:ed30 with SMTP id
 5a478bee46e88-3674b53008fmr3479090eec.4.1792599550534; 
 Wed, 21 Oct 2026 09:19:10 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:19:10 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:26 +0530
Subject: [PATCH v9 7/8] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-7-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=3987;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=khB9eEKB/k43xUg2jWRJU1SEWHD4D4I/mSDRiDU7Qc0=;
 b=PmowdbKjjQ3XR+vUjzQPzRHsN9dh5etQCtseK4uTWABkrLRVJmOCIZ3Z1JbvEwP+3q6mmpwX8
 BlRVDVRurs5Bp3at2Y5JilaulH+kolaa3O7ZcnZ+Wo43jJIxEyHCKNc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad8e600 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=daLpoQ4NbywWfa45J7kA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXw29A/g094FvL
 NiCS4CNiNQ9hbdgxcRt83HCYf0AnvoMRaFCnq28b1l7Msfm3aPq4WdzdQ+cgBput1PDL2qNCScF
 4TUlsBTvWpw3ONtlEahTGCCQDsLofQM=
X-Proofpoint-GUID: TwLBCGC44k60HJDbamumA0w9A5NK4Ii7
X-Proofpoint-ORIG-GUID: TwLBCGC44k60HJDbamumA0w9A5NK4Ii7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX8csbxWlvujWc
 QcrFSIDNxfXjmBSbZbfNzoNzOPvWfU/TiyQ45lD+2z3T+uAH6llW0nYluORCrxx6O7DNzSJc/v7
 BwfAIRGFiMqtEHdRADgVKsGzX22tFGpdCYUXlOZQ4culEcYYY3fk4RqQlhi5oah/CVs8bD6ns/C
 ULxOhFi+AqbNIuYFG/U8qoHcMjTxx2xliMl6Y20M+B2GRqFw3M1MOEFx6wojXQ9l4qlZhc+hB+m
 EykGXOhMW8PdXMII2hYuJWNPGBI3m2mzS6neU1tzM9ZAzT5BcxJ1WDZrA0Zpf9rK9zjv9cOK6jX
 hiqreOfp9rEsWA70U84lmqzH3ySUZQRJRPkPY/OXS8nGTKIlcCitgTSHJcUwy2w2yH5cpahSAkO
 Q7OVg7+0fytkX1qpTzpowmFkNXBMqiRZ8xbUeFFwzqb27k4/0bhYKxyo44pVkNx/na1fP5VvEWs
 WoxMA2mxUq9k3CrLOoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add defconfig for booting U-Boot in Snagboot mode on Lemans-EVK. In
this mode, XBL loads U-Boot and directly jumps to it. U-Boot then
enters fastboot over USB for device provisioning.

Create a reusable config fragment at configs/qcom-snagboot.config
with common snagboot settings. Platform-specific defconfigs should
include this fragment along with their own settings.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v9:
- Do not disable CONFIG_IOMMU in qcom-snagboot.config

Changes in v7:
- No changes

Changes in v5:
- Disable I2C configs as its not required in Snagboot mode

Changes in v4:
- Use CONFIG_ENV_IS_NOWHERE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig

Changes in v3:
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection

Changes in v2:
- Newly introduced in v2
---
 configs/qcom-snagboot.config           | 45 ++++++++++++++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig | 18 ++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
new file mode 100644
index 00000000000..cb395f2a867
--- /dev/null
+++ b/configs/qcom-snagboot.config
@@ -0,0 +1,45 @@
+# Common configuration fragment for Qualcomm snagboot mode
+# Include this in platform-specific snagboot defconfigs
+
+CONFIG_QCOM_SNAGBOOT_MODE=y
+
+# Disable configs that conflict with snagboot mode
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+
+# PSCI firmware is not available in snagboot mode, so nothing implements
+# poweroff (neither SYSRESET_PSCI nor SYSRESET_CMD_POWEROFF are selected)
+# CONFIG_CMD_POWEROFF is not set
+
+# I2C peripherals aren't accessible in snagboot mode (no Command DB / RPMh
+# power-domain data from XBL), so probing them only produces noisy errors.
+# CONFIG_DM_I2C is not set
+# CONFIG_CMD_I2C is not set
+# CONFIG_SYS_I2C_QUP is not set
+# CONFIG_SYS_I2C_GENI is not set
+# CONFIG_I2C_MUX is not set
+# CONFIG_I2C_EEPROM is not set
+
+# Use default environment instead of loading from storage
+# This ensures snagboot mode works even with corrupted environment
+# CONFIG_ENV_IS_IN_SCSI is not set
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_ENV_IS_IN_FLASH is not set
+# CONFIG_ENV_IS_IN_NAND is not set
+CONFIG_ENV_IS_NOWHERE=y
+
+# Disable default env file to use CONFIG_BOOTCOMMAND instead
+# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set
+
+# Auto-enter fastboot mode for snagboot
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
+CONFIG_BOOTDELAY=0
+
+# Fastboot configuration for partition flashing
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
+CONFIG_FASTBOOT_GPT_NAME="gpt"
+CONFIG_FASTBOOT_MBR_NAME="mbr"
diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..d6906c1e501
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,18 @@
+# Configuration for building U-Boot for snagboot/recovery mode
+# on Lemans-EVK dev boards.
+#
+# For normal production boot, use qcom_lemans_defconfig instead.
+
+#include "qcom_defconfig"
+#include "qcom-snagboot.config"
+
+# Platform-specific settings for Lemans-EVK
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x1c100000
+CONFIG_REMAKE_ELF=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+
+# Timer frequency for Lemans platform
+CONFIG_COUNTER_FREQUENCY=19200000
\ No newline at end of file

-- 
2.34.1

