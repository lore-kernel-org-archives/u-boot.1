Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B4606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gXgyS14p;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jVfbj9De;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GVskU8WQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A74D4811D5;
	Wed, 21 Oct 2026 16:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3I6mY1spDML; Wed, 21 Oct 2026 16:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D70F81164
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598993;
	b=KowwKRNittQksHjQYQPffcv9ArzV1A1JIUDWtMOnPl+kjSxQ8YhDdKCod8bOPMczidGr
	 3aTEdek9CL79hoFEURNmcMVQHGKE6P081qyIWWGFUe/2ORiW+nbNXbn/J32NysoMs6mbu
	 QJjeoUsjVz8qKFFB3P+Unp8I7tyQkOv2UxlJOVur4a1lSL8N++XkwNXuDmv6LL2cWygG/
	 vZ80Xf4TZZadj+Moo8vW+C1+O8spJ5bcVE8rbYhl4UTGUZUmxJC+TgXVSPoVtiSfqS/ui
	 5HYUj/wJYbHxdZActvwv5xnt5SUvLNAmg4tVj/skKEr8bPA83BMv2IArI/CWQ5WASRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8IWbcNYPicBbbTG6zLJBVB0E9OEX6nBbtMrHFizHa54=;
	b=KMYnwcA28NVmfE7bv9niKlWsxdSYA2y0BU7PyoOlHrU9zU5Bmu43NW44uuUSkc6DywYu
	 auASC+eaWd+IdCEu6H0P2Fm4y8h1sfpINWWBX/AkGeEm7yn8Anawapcd3sb44SqKXRmeA
	 wEFnKAFkr7IjK5NBDCv/onh/t+1pD3mquY9gNEvEUuPZiX8ndBIInL7TvLCMtMj25hJZ5
	 9iM9w+lMce3O0JBqNXE0O11Qvf9GU8p4KYaT44GQJa+XZLQl1/f1lTNPlaDb8cFFoZ24L
	 S1YGN5Th/0L7SHtZ49p3g4o2ECS33s563t999Qpf/kSyinnv3UtXNjxofZMOVtDujVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598993;
	bh=8IWbcNYPicBbbTG6zLJBVB0E9OEX6nBbtMrHFizHa54=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXgyS14pLkfijGyULCauO8z8lWf2K9rYWQpMOs3LzMEPUQ7pXZwXYHTYfizIAsy9U
	 uvu8TtjxNDlo6XCzhKQJ95WX92Rv5VW1hzg+cSWKyp4yz4CJI8rlIIVnFFi4KWKXuk
	 53ZYuBU1DoACMEcAKCf5gV2NsDjrtUA8N66gJdAq9OeCstf96ttmFPZumyahbHSuH5
	 03I9ItQYCtgBigCnSa80R2HwAzvEV9l+mnYk6MsyELdIcveJ4iF5dxgGnMlvh/hD+E
	 JOv4oAQl3xd5k5B1za6L3ybKNjvENE5j5g0zIO1RRgnrOenHwIsLZAk7/n1Um+YwY1
	 3JB1czXzJu7hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D70F81164;
	Wed, 21 Oct 2026 16:09:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A4E61E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F00F608C2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFpYnnBQEZUP for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BFFA608AC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598991;
 b=mrTUXAjrNMLQPESyGw4nKHVW01aSSERrCKIoploUxK8YGSVOK7PA2QcKaVe3qOLBO6Rz
 r1usAt3PnQyP6ncf+C1SkJoLKeG6lTw3kzMJ2wkhsJY0iS1Ic0SNLOPEch5lRcZy08d/q
 4EWtdbkvLvaHtRs08wRt1ppW7OVGVBgEqMiS/lGnhMl4aCWGmhDstHWaC9nwAzSd8w246
 RvJ7lpS/AnPHPK5xrMtVsg53tp9w1dOjb5+JGLLOPzaqW1fCiNVjwYs/lcmS8IanrZm0V
 UkXDoTdoWxkDspnC2EbOIX4jaLTryNV0QNnPmcZIzW8Hz3VXJLwIoVP3sy8bTDxIw0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598991;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8IWbcNYPicBbbTG6zLJBVB0E9OEX6nBbtMrHFizHa54=;
 b=S0LfEwKz1G0RpVXk+BtcF6G4uCNCTUpxKDvEih+R+wqE7P5LFUzgK/Edrl9KOx7kvZng
 iVAyUHk14VzTwWgp69goKuEWKlkShei7oRvrnkAQwoQsRF/SO+NX+wC3Iu5Xvt2nZ/xQb
 CvFe5sFlhJou2T06GNcy4QgKtdlhdP6lyn+QGPJJ15MVxfIYSBoBC2edLUYq5LQl1H9qF
 XlDTRjqhbprlp0Pp+Yy9kE5W1eWFPdPNh8ZsBuwwnVkYrsKqj1AXvwi8G3O1P15B0IBoe
 jORGZh9ZFGCbqD5aNkPpwDzHrGl4k/TY7M0HTTHcXCuwMedeQKAeu7jImWsgSc6GrNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jVfbj9De; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GVskU8WQ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jVfbj9De; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GVskU8WQ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BFFA608AC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:50 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU00b3726130
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8IWbcNYPicB
 bbTG6zLJBVB0E9OEX6nBbtMrHFizHa54=; b=jVfbj9DeMRBr8kQ/kohyXvnYSAg
 Jp1xend76wX81VWraR5ksrQBf00MOFIBBo8N9DtPCUHsLcrzNajmdQ02bxzAFKKD
 rzO5YVtd6EuwXsi/pfC8MwbzaeiDK554h2GCjAG2vGO4FaRBTFGcDqw7SxwACD5t
 rHqvf9CPpIHT4mb3wFDQNIP3f7fngHXRHcoxfle/ymknBilgnJSuwSOwQzQ0l3+C
 5A0oy4iYsWIPd0T1rZxiHUy8ffYesAPYarwZV9DdB1CZ4Jj8RiUfMdzLmHkQCl5B
 pO4O4Z9Lhz5WxGZkVnmH2w6cxeDomtvSGIt9U9HKhrbg5Hs29EwXUjWR7DA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79yp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:09:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36696c9f55bso5421eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598989; x=1793203789;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8IWbcNYPicBbbTG6zLJBVB0E9OEX6nBbtMrHFizHa54=;
 b=GVskU8WQ/Ohwt0vtszbIcSs8ENSFXbGqmvjN2LjLDNCqy7cd/pNYDGXzdI5bH9A8k/
 2EBIxNf0vIpi2V/FDQGkQJC28Nu7OGUU3BgQuR60vveId50eABz5Z9Ub/DE4vAehoBze
 VsC7rSlqwXsHcyqkSWPfXWP4erBCz0dlhcoLQHo4W7u+TBEW9iOVL24vP0t0UBjvnOqz
 JxLjT96qzBlnrru8ml9StGJPhUn71qxnq59S5/gIKk6jT2/6btGOZkj9bpAUlJpjZMnL
 UszC3aYXRkRKCifPOw4wrSxOy+BnTAVfIgsgwJTreu3OUjwog5b7okRTP+/4TrZnPNYV
 5NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598989; x=1793203789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8IWbcNYPicBbbTG6zLJBVB0E9OEX6nBbtMrHFizHa54=;
 b=O+Nz9FWqGJcOe9kK4VwxJhO1nGIw38NkIpb+LTbpN7MdwmQX1Tm1Tofl3KgTGC5pL0
 GM/VNiHMYYPu/ofmV2+aOQ57dXeMiYbWhPEwiu7ZaiTYteY8RscTRcZrKZ/FVBfwSIsw
 anm+1epNVvOI/rf4RVNtNfgYsJMoDVx4yfbWqQrE1iXgNF1WT8WqjvxquJr/zF0NJf7Y
 oeIgYCumYyIHQdrj6vAo00Cv6ZAsWzdTrs2QedSQ/NF+ChBAKo6NzE80YcM9w45OCz58
 UMAmoymGtyHVVbsM8RLi7TymCtvrj4YlEq9VzGD/BiZ6DuM8ShbdvYMTkiXXEMuHC95R
 Xl5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBytU9j9ZhApVCIMFoyrvtV+LM8skFdjPHB2xoe31jsXXtaIf8RTMQ0Gr9je6za1ZpNdnhKHIi8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLRdyOBoVQhVlGsjc93tuos5iFWeZPu4F7W0Hh1MwMQ0qCsMaeD
 uXFSITPNORwIJ/Y1vfDnh+z1uZtOkr3Prut2yJolBoW0BM8sM4myVcls29VP3aCGO0A3j5WL/AG
 +kgsl2i4+bkC2ZhHSQN5upiSPDgFapj2XCXG3DAldnywSmDigT0sjLkmf60X3RMtxeGYqKdU=
X-Gm-Gg: AYBFou1SjdaT98SgYMjmrTFpTBl5A6WY1IcJUQMf3BVNxjaNFRElO4fOgYRBfq7oONJ
 EYlzX9mKH94fAWhrwf2yTto6/MPXRsXwgCDFj2/ay6DvtB2x8LqLmoGySIcaGSz8y6rTy3eXKHj
 K3Q+roboK/JbjMBBynioLytNmXT6YkR73EkfPDZ75q+/sn7Zkr4+SHotyS2+c8/gFhR1yPYBhwA
 8/UIMNRniqZMl4dQSyeHBkthPJ+v43vKZ+CAdChVH95RQzf7xW9k+C/M3o7Si1/uZ+LbmoyHCVV
 ULxg5at5m+AXlN9bTOYJby0U4ZB+x4pBg9MckejtALwq50n3E+iJWrz7+2ld1hA/pEhzmXOIb+R
 VEJuP9QuM7MGgFyxoVBC0cP8G0xV/r0m674EU58vzoiu07fhj4aGOWfKpJXy6Q/fP5lw6KVXjZ1
 VtLkmh81ctdBClB5jemQU=
X-Received: by 2002:a05:693c:83cc:20b0:357:ee3a:267a with SMTP id
 5a478bee46e88-3674a418b95mr3764094eec.2.1792598988688; 
 Wed, 21 Oct 2026 09:09:48 -0700 (PDT)
X-Received: by 2002:a05:693c:83cc:20b0:357:ee3a:267a with SMTP id
 5a478bee46e88-3674a418b95mr3764073eec.2.1792598988147; 
 Wed, 21 Oct 2026 09:09:48 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:09:46 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 03/12] qcom_defconfig: Enable Shikra clock driver
Date: Wed, 21 Oct 2026 21:39:07 +0530
Message-Id: <20261021160916.3894471-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: y2-JfdyPcIfYPN8Uq4ti4Lexev1dSj3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX9zstwB2jVWhu
 kyUK3G8jeXkC5jyq1hE8qvctNMhk3dOEmahPxu6CTnxq/SrJ2inVyf1+XCHLnQi0FRmsfdnKWYM
 hbUPtddzXBnHcIZHxpDlmThsrHM6GWIUNXmlljlgNiIc4olLp27l7ey1W901Ep7iUOT2oPMKV5O
 ZpNa1dnjGpXocJ1fcpcXEPLfavDkrTNLASzkYCyc9FN1zxAgEATk3dZ0AWYs72bIbAkaW+qg5jX
 2/BwOHRt7gjCGkaCPqb5tbuJoRYu7X+NvEYXBxQenZrs9KK4rfOaM0VLLbp3awkjk2JaRZsQzfo
 p0qExNF+2vlL85EKmBT5G/5UKDk4XKOg4ffLDRcu4k0kwMWezAoQm6+zzG5UUo+T15TNqI7yzX8
 fuLaJJpQ4dcJBU+pQpVRYcQ1pkL1a6h9cRIxV1krlXKz5Y6ra0pSeCtz3rvwbf6OWWHlGqUZx8L
 7do85W2fVHpqnMpcOTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX1NdKH8rPva8W
 mQ02aNkrwr2B6gtexpZmtFiOY0TTxtoHi4a6p2q2GHz0bzbBX4FHpy6u29HkZL+8oDmSEB2C5cd
 xV1AQEGQ1M85wUUk9QIJ3PLD8B3tri4=
X-Proofpoint-ORIG-GUID: y2-JfdyPcIfYPN8Uq4ti4Lexev1dSj3z
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8e3ce cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=o4w_YnA0ogff4CEjytAA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
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

Enable the Shikra clock driver in Qualcomm defconfig.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 295ce4aa714..cc66bf96f51 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -63,6 +63,7 @@ CONFIG_CLK_QCOM_QCS615=y
 CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
+CONFIG_CLK_QCOM_SHIKRA=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM6125=y
 CONFIG_CLK_QCOM_SM6350=y
-- 
2.34.1

