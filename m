Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9953E606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ndiFFtMK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nNweZVrF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bX/o+JRN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB297815C1;
	Sat, 24 Oct 2026 17:38:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTXP8bVSr-xe; Sat, 24 Oct 2026 17:38:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1344781179
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792863496;
	b=d60WKlf6exNb+cy2Dma3OGNo/Tz8mZ9kYLUCODWGrrofyZOTbPf5Q20BQrY0yLJROUTb
	 pbowh244t93Npge8GW8Pzzs9Sa3rq6Pa1J8GKiU07ZqlcvvGPoVtGtsOimaTGgLz/UDfU
	 k1NmpHSRMq6ygAOwU8k53tmYNvze5+uQC3KC807Gp9Md5vFD1+MSbKVB63as9qfjLRv4m
	 rB68yQdod2YL+D7nbJ+EcvTP8aKjmGTUJX267hy8Z/sP1tLdSQt0Wx2y3qvHt55fQtNiW
	 hzqWG5hDjq81LS1UVaxTiACCemLooW5bYpi7QxbWYy9agMQL2g03CTuFMJxTk31bPJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792863496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5yGwu8YqWolRFpxgFGSDYcqgm8Dvtnk1own9usgROlk=;
	b=NpP9QYoYItr5YDM7RVAu1qi/QRKHwniVjKMTo1NWzgn+7ELuWfsOWu6snrwzX+JiShRt
	 Dgmn4DJmDIgy9+xkN/s/3aTz/SIzVOfKgWhEehp1k86dqwt8XQFU0SnWiVACdmwHRPsDJ
	 EAHygT6RoELQ30sCMI+m+0mUskanMM0kRNWnoNfw4C9Y6o8zwm0e02rfhJSn6qS/VbzEg
	 /bDuyxUB7O4awK9MzAjX33iY3Fw4ZDDk1Dy8LxNUYJxHTrZqisUsEsIvu8XmFRgfyr6XP
	 m8Fn22gVkj+Iq6GalBHRBYYNd9Sm6H9ygQt4Yl6Uh+ueGltWlm0fdPcxb+DvhFuCJ6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nNweZVrF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bX/o+JRN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792863496;
	bh=5yGwu8YqWolRFpxgFGSDYcqgm8Dvtnk1own9usgROlk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndiFFtMKpZMfRSJL/FjX1UiLKeO86v0TcCLkXyk0U+6WjfzAmjVkG4BRi1O3PDj0x
	 J2hU0f7PVU7vcveZOCofO16lLfai6i4RDU0IrN2FKSBE0WiJzrFuOpuddI5i+KkBQx
	 4Sr7RfyFied8CDL3lSJH6Xu9EIgW/45VdKmUekuXSWId4h5VosibZ3l0Lsrg/dgOW0
	 9vMk63G9XaNOzoGLnIC3R6qdl/1y/6RqlUhD666DKVSWj2mqXtkfOB72H3zW9ywuOs
	 WELZGO++dsnsQEy4tKqY0U953z+cMILYwI8dSOeoNY9BlwrBwI4W2/k37lABWs0QE2
	 btv6QvrgqwZtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1344781179;
	Sat, 24 Oct 2026 17:38:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 147DD380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 061C381179
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCd4NFphB7ih for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 17:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A5BB80D80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792863493;
 b=Iq9zIWYU+KdQ+w1V2/y1pCV68yy6nI9G6+Djp//ES0/ePecrOxF5BldCMoOXbo8qoJBw
 Ozlp5c66R9/rv6vFLFmirr06OLWDQ/k1R3Rb+vV9y6eyyG0PLduFGARl9VIcg0/l1BZeq
 5UhBJ0EECaWGEJv/HGlLiPQp7szqSCTlOmpSFfiFGqOZd1FKSB+rn6QT7UHYNCb6Gv6dd
 7d2lQhRHfYFEV7wZHGrOMVV6CSEegAmRdY15V3OM/pfch/VXLwJC6hXYCYib1Ai/sRKdR
 NJfarVSs5JIe8Xk+C74u847La2XfjiYDEI+S2/TeRhcEFWXlk9hQ+h1CuHLH2oVZ0aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792863493;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5yGwu8YqWolRFpxgFGSDYcqgm8Dvtnk1own9usgROlk=;
 b=kROx/jkteLwodlCGMPqDFdt1aQsHE0IHIMp8yfLa22fp8mfLDle7KkRvbWlAmSxjKbFe
 aGkokOP13NxPP/rQ+lctcgcof+GrWn/7zk0egNBJa9AY2M9KmpKw/oCOSCtjC3KG5J3ZQ
 VTp0xjomNHDiiDMVeFU0fCUgjoJ1ZvMK3Sa632K11d0sESRAO6BXNiP6U0owel9nGmzKP
 /NC0ydeQjE9IO9Efu7If3wi9GNM1jhONTFApEtkmIv9l6wvUAki1zqvwWEenCTuOlkRAx
 rNEOZDtqgzvY1GA1TZgu5N4LXHD57l9pNamB8vc8HmhXGqkekcOZ95C5cjS+qq5YQeA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nNweZVrF; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="bX/o+JRN"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nNweZVrF; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bX/o+JRN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A5BB80D80
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OHOS162154582
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5yGwu8YqWol
 RFpxgFGSDYcqgm8Dvtnk1own9usgROlk=; b=nNweZVrFZbgC8wrQElC1ppaqNVI
 SfOgMitt+eYIKYSDio3qbcVkzHc3HMwIfc7d4x1tFAZkmO5rYfew2oVnot/P0sWq
 OoJTUksOK12qp0TqMSL28Zki9vxbixS/hc8FDcyJJW7/Yg2dNjMF40lU6cT28lwd
 Vmv3ifamhXixHYgaFPh5Sms4jvB9F9gSfLMJk0Y5XHuIR9Liv0sDhvst/n5UjL/m
 I3x6Q/ISjDcqU8s+YoFqrCs8CG5FnjT4lVgSWB4i0UtsT6eSi0NO1Pe3/DgAPJvd
 DBkAByht9Mr+eEt5UhHawZ85jNSVstgW/oB8Wc45uTVerNaPbe/1yw7L1Gg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhev7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so7450772c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863490; x=1793468290;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5yGwu8YqWolRFpxgFGSDYcqgm8Dvtnk1own9usgROlk=;
 b=bX/o+JRN66U7vDRpUcXvxF2fuls7L+b4CHFk9x/0aSXC7aMwOqiZ8UfN0LK/V7zkMb
 IYVl7gBuQ8vpn7EXd4vwD80MuwrAeaJ65TGXJ8K4yj4mKdH4k0NYFhsOgvT3mf7gARUN
 HFrrQjd6s6tfVt6EGxRLMuj/n60OBAd2yS5CpipQgughgmaOlHKL8sHy/4QrgefmuWZy
 2JV1SvGSUrXymoWWcKcowJkknynpyxsXIg37z210uiwUeHLjFvMwOkbEexECeyX3I/RF
 w85MwPSlCw5EzTEtCV6pOiGz50V+2mq4vA1PTSvEdq/W+oLPCL+Xbpmb+ZT63o/wJtDj
 z3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863490; x=1793468290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5yGwu8YqWolRFpxgFGSDYcqgm8Dvtnk1own9usgROlk=;
 b=FaJKAT/mQ+XNLhnrQhXIEZBhmeKTW2qaFxxojR193Lt2F0MIfqaug5W67xzWAzN/mm
 FbepC6pk8p54FT1tawU9tS26STaG/1TFOOUobRuArXVs/PLJ6poNaEu7Aq/L4N3IqAEq
 iLpUBO1z3fizO9s/xYunFjvwAC8ZBqqr8p+eW4kVXEb0s0/CnDZL2AGoQ0NdcMK7gjdg
 aprWOIUio3cLjfu+X6npxvTndIHEtHovvwgn7z3OZ0cPdgHLmpr1Z+fB0jKHN5ckAn4B
 H3RAyJvxGpZoCedfOzKMMDjQtKtDewh0GZPkOps4h8VZOiLo3nV3XoWJPNmv1EPciJKN
 nMRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByb+0zlLUV4DneUC6+7z505zI4k/eTc6zigFfDPje3augUcz+iZ8HZCLg/RKLXWQ7g3Jxj2wq4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKSJNTvQ3mTDhyf/6QP4amavcOb9dVb9f1fwxvrlHKM/TlP53g8
 ABjrpFY/SHOLzc9BOOezmjDmKcxoCnxX0g/pa5U/R3rR4U/Ya7YlbP/7lk6wpHHwYXgkFvSKzOw
 u0wOOLjUkZw+qP2z3s4d3NKoWXM6Sg2MXktsZNFsxgrLBB2uQuVzRW9K4bbUYoaqZf4xRKRsR9k
 aR1xM=
X-Gm-Gg: AYBFou39SQRpOUVEpgXFVmyFdOcTOwDeiJiWblI3faQpMBMgooRPU8YT69RxGvlxA9G
 sa+/Od1aHx8X0tauL5/ULfdGbel/V2pXYJd0crcLQHdhEHtGwTfomFEAXzt8BfIpMVJ5omjO91f
 agS00Sl73aYzbjLi3/7f69BBnGwMn25Te+pq3S8HvLWDKjir34RvPvdSrkiwxEus2rI/iAHAJ/0
 Ni7un8hkYj4nmZMpno58tu7gvLMFNRkxPzKrjrsT0xk9sFtyxY5INSdJxdpWbNySd9V3IlzPTw8
 SUaDFNS1YxarjCVScdui+Rw+vq54uIGHnpEq304awL0OQCZK5seAd2raRUdxE8CUPkgsxxdOD4B
 NGFiTyJZFoenWMeqiz+g+x/6XzBAnZ2WKwytejhnrMGS8QHPIVEJBdISsj4QjFuOAdBhjVxcAaC
 NsJkFglKpTINuvn+P82Ew=
X-Received: by 2002:a05:7022:23a9:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-1993fe81364mr4998242c88.39.1792863490149; 
 Sat, 24 Oct 2026 10:38:10 -0700 (PDT)
X-Received: by 2002:a05:7022:23a9:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-1993fe81364mr4998196c88.39.1792863489601; 
 Sat, 24 Oct 2026 10:38:09 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm10714248c88.6.2026.10.24.10.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:38:09 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, aristo.chen@canonical.com,
 jorge.ramirez@oss.qualcomm.com, smoser@brickies.net,
 ccaione@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 1/4] efi_loader: reduce boot time by deferring filesystem
 probes
Date: Sat, 24 Oct 2026 23:07:46 +0530
Message-Id: <20261024173749.3509050-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
References: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXyGPnsnKoKot7
 LlILLx5KcnYqdzBX+kUBLD/1qWKx956SXaUosdicfTdi5+72GJ8mxe93agsYzryJshMzZgWb+5i
 rikNTbOzph90J82LTwOjXy5BNhczQXI5q40YlX1MOFkpO5+/ahzt8W/DfcXZucJMgSLU3ksMgMp
 wMG4+PK9Ny03GTygnd9ythz3theXZe64+1eBK4RVosVsFV8HnzrrkdmQD9N9E3mZ6bTu277GK39
 ePMvbaAJl9rodiqBxTeQkWzY9oSQtBOTQWXetP1JfmBKb4C6GlKhTAOKz6rqIDUo2l89Tujc9mZ
 8Yrn0lQNiaBRmOVp0xS5HX0MLFrlAWXEsCPbYyaSVb7ECzmkBXol1nLozRmFngHIbz1uV6VNM6R
 QAcIqN0/a2/CDUjvi8z7EPIk5yp1/mZvNWXimuF4Z46lEpMpeQ4vv2gAve6ZfvSlnsPJumTJTin
 +Dw0533cl2r4jVnzYdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/192S+wmrLDG
 H0PHGNqxOaRt8E1oq3C9rAYb42Q9nPxo2h8/ifnY77FLae3OlPJHl2rZZ95A0BYHJeg9GJr06dr
 9eOMdnpbhAik8+yx73DsPgngT315zY4=
X-Proofpoint-ORIG-GUID: TASwrzPe2OfaHafAK7mimuDi24gz68Ag
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adced03 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=SJyPDavngbnDy44vClEA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: TASwrzPe2OfaHafAK7mimuDi24gz68Ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

Probe for a filesystem on a partition only when it is actually
opened via OpenVolume(), instead of eagerly for every partition when
its block device is probed. This avoids unnecessary filesystem
probing on partitions that are never accessed (e.g. firmware
partitions), without dropping support for booting from any
partition.

Since the boot manager's default-file search now visits every
partition in turn, check the EFI System Partition first using its
already-parsed flag, before falling back to the rest, to keep the
search fast.

~170ms saved on Qcom SoC bootup time.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 lib/efi_loader/efi_bootmgr.c | 28 ++++++++++++++++++++++++++--
 lib/efi_loader/efi_disk.c    | 28 ++++------------------------
 lib/efi_loader/efi_file.c    |  5 +++++
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 6b5dad21b06..b5477fcddfc 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -316,20 +316,44 @@ static efi_status_t fill_default_file_path(struct udevice *blk,
 					   struct efi_device_path **dp)
 {
 	efi_status_t ret;
-	struct udevice *partition;
+	struct udevice *partition, *esp_partition = NULL;
 
 	/* image that has no partition table but a file system */
 	ret = search_default_file(blk, dp);
 	if (ret == EFI_SUCCESS)
 		return ret;
 
-	/* try the partitions */
+	/*
+	 * Try the EFI system partition first. It is the partition most
+	 * likely to hold a default boot file, so checking it first avoids
+	 * probing every other partition on disks with many non-filesystem
+	 * partitions before reaching it.
+	 */
+	device_foreach_child(partition, blk) {
+		struct disk_part *part_data;
+
+		if (device_get_uclass_id(partition) != UCLASS_PARTITION)
+			continue;
+
+		part_data = dev_get_uclass_plat(partition);
+		if (part_data->gpt_part_info.bootable & PART_EFI_SYSTEM_PARTITION) {
+			esp_partition = partition;
+			ret = search_default_file(partition, dp);
+			if (ret == EFI_SUCCESS)
+				return ret;
+			break;
+		}
+	}
+
+	/* try the remaining partitions */
 	device_foreach_child(partition, blk) {
 		enum uclass_id id;
 
 		id = device_get_uclass_id(partition);
 		if (id != UCLASS_PARTITION)
 			continue;
+		if (partition == esp_partition)
+			continue;
 
 		ret = search_default_file(partition, dp);
 		if (ret == EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 4a3ace3a304..09d49516f94 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -355,27 +355,6 @@ efi_fs_from_path(struct efi_device_path *full_path)
 	return handler->protocol_interface;
 }
 
-/**
- * efi_fs_exists() - check if a partition bears a file system
- *
- * @desc:	block device descriptor
- * @part:	partition number
- * Return:	1 if a file system exists on the partition
- *		0 otherwise
- */
-static int efi_fs_exists(struct blk_desc *desc, int part)
-{
-	if (fs_set_blk_dev_with_part(desc, part))
-		return 0;
-
-	if (fs_get_type() == FS_TYPE_ANY)
-		return 0;
-
-	fs_close();
-
-	return 1;
-}
-
 static void efi_disk_free_diskobj(struct efi_disk_obj *diskobj)
 {
 	struct efi_device_path *dp = diskobj->dp;
@@ -528,10 +507,11 @@ static efi_status_t efi_disk_add_dev(
 
 	/*
 	 * On partitions or whole disks without partitions install the
-	 * simple file system protocol if a file system is available.
+	 * simple file system protocol. The filesystem type probe is
+	 * deferred to OpenVolume() so this install stays cheap even for
+	 * raw partitions that never hold a filesystem.
 	 */
-	if ((part || desc->part_type == PART_TYPE_UNKNOWN) &&
-	    efi_fs_exists(desc, part)) {
+	if (part || desc->part_type == PART_TYPE_UNKNOWN) {
 		ret = efi_create_simple_file_system(desc, part, diskobj->dp,
 						    &diskobj->volume);
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 7dee57d594a..ac2d165f5fe 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -1229,7 +1229,12 @@ efi_status_t efi_open_volume_int(struct efi_simple_file_system_protocol *this,
 {
 	struct file_system *fs = to_fs(this);
 
+	if (fs_set_blk_dev_with_part(fs->desc, fs->part))
+		return EFI_UNSUPPORTED;
+
 	*root = file_open(fs, NULL, NULL, 0, 0);
+	if (!*root)
+		return EFI_UNSUPPORTED;
 
 	return EFI_SUCCESS;
 }
-- 
2.34.1

