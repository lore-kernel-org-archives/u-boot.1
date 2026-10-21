Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12181606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=br7s2hdT;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K5kV1CCN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MNfQQPuu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2BEB60844;
	Wed, 21 Oct 2026 16:10:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-hRtzLMKVl8; Wed, 21 Oct 2026 16:10:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32C0660856
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599052;
	b=ZQomEaeyqEeyMVd6UdRavFd1ZWtJyFdoguEz1uo+1hdOv81TaLuTZm7JnNWFuKWN6Thd
	 BQvTJkND69lkOU5vc8ntl85dx/KYUrOGWif/EU6pFafkn7py0JuktQmamLXO/1NWSfUXn
	 qUGwtsQmwLdXKyzQOu+7GUyhAr4t1ACkV4YTkdpkC4kicWcZ2yfSk7pQ9vEnOQGjJnK5d
	 dKxiK2cHvz5vmX6MmZIEjZK1hz2KMfGK9qT5dm86UOqTRrbQnzJjRrxDAxlzIwKzoXxWG
	 8ytoD97ZGObmXYfZ6IRsX45e+VsyZyWAvZZ2nVAxKRiiNG/PQgIloDpdisahd48MuiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599052;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gLATyHerr+0gnqQJpQbcRGC8XwlZ1t5zo0KdmJWUQy8=;
	b=fkRj/42RLSYg/XAB3nFCyWx6zdAayidSRLFKjqiCVBiN48nVqHlgiuCcvJnBlTIZnQb9
	 O90iM24EREGrBGmiRBLIO92CXgLZJWNL7W0pv2ACFncPGoJuz7FLcg5iOtXAuEhtoQVU/
	 HqpdoZXjRwdzIHaWGRMYWZcmk0vVg+3lYtQtKBKO0vwWvE2r/mepR5PhSoNF1Jvn6YfwL
	 Q58zadFNvZPfkw1BjdWINdVFrErnWudO04B2NcU7z50fo0Y+M7l4APID9zMqzKkjev8Iq
	 EQcHqfSrcnG4tv8XYNSskLfaEaGNjTwG1vVB9JhDnQvqqvFZI67r2964md8AyWkyjMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599052;
	bh=gLATyHerr+0gnqQJpQbcRGC8XwlZ1t5zo0KdmJWUQy8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=br7s2hdT+EoeaHtJhkFLrjojApuPu8bW2oB5uO2btLi+/GLByWllIPEg8HMrDVvZP
	 k08yPorgIRUGm5P3LY9rZJ62WNxFjmxOYmT0yT5p6ZGGuie5dISSvz3c9CtDt7zsAj
	 2abhI+D02XmQHMgW8OYZWWdYOr/0ikA8GgrsE2H3RYtebRRorYamLIm4kB6Z08pUBR
	 5u1lOehNJRm0eYOaEihPjSryozYuKoXxlOzSnpjf8LL+WacBqbl0oB83g/Nk7kkwzQ
	 aWDJKURXhr6AKfYMUiAYsOn51w0wS93HFhoThSyQkysG9QY1snHZHh8aegPQZrwhj5
	 n5M+bVdZO6KZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32C0660856;
	Wed, 21 Oct 2026 16:10:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D087356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EB1C4039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DM0RXMOMSt9q for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8AF9940077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599049;
 b=dLvZIX6x60eeVyOcmkqOWZItBEIRoCHmfxI5MnjtqhLXnfh3AxMGCy5yAVyzUeTkBJIk
 cruNKDiJbY2MBwGfjI9GltRRiz5F8OLH2N4KN/N0PYVVQmgnP9Vg1Fq0eUUl5wK2EIBEv
 wXabDtbAtxbVZv5peK39gpf8DcHvhaCAMLZwxLu9UpBgbaJCmEdllvEgvthnrSZMvyJ4x
 8aFYL2lskp/BCCw1wxFyN7VD5xQMKHbCTmZJ+1TecPpfcvLB2CygDvjTYHICzjxNyzmAT
 xp2o5wXUdd217EBaEtQc7W30Wtwwf7AxYR+wDvh+x/rnxNxadmCsPoMr4HCTjcT0CBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599049;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=gLATyHerr+0gnqQJpQbcRGC8XwlZ1t5zo0KdmJWUQy8=;
 b=e0rPZI7OSrGQihQjY4azqzw0cx+0V3PPFbEugcEqOIBWRZHIwwvJFtFKgU7sCEKzhMd8
 rxGnaBSgX7aeZGh3e0w7hn2zLCIo+kmqrrVyXBrvqTXv2iVdZrb8+td9dPTD1KZ2DQuLT
 xgiLv9k4/uXFfetQ6RbZ+iPKDgwQ0qSyW57SVWbc5dCFOrficQ6FrRqwzSizKMqyNE7MF
 HYYGuJCDOq+HAGvnmPNHUFEilDnYJiMXAKXPNNAMhj/YgJlRR5/LrlWF3AmSNeQWmiZDU
 kEHBTqVs08ci/f/8WSYoJqb/vgCQdueFCaYmKbCrz6yCp8ErGRa9KI7Ovvsa3kxqONA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=K5kV1CCN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MNfQQPuu; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=K5kV1CCN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MNfQQPuu
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8AF9940077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG10gC1060503
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gLATyHerr+0
 gnqQJpQbcRGC8XwlZ1t5zo0KdmJWUQy8=; b=K5kV1CCNSOfNPHM5t34H/5TUGZq
 NEXK/FFQGT3jLVQwgefXE/23V6wNAIhj7fCvp69HL+vzqD/Sct5XQQEsFSXUZwDa
 HlvWeTteQ1gjjIqcZAvZAHnNNyk97kXN3fjPm/Pvma4pw1D2KFIfAd1cdfzZmGGZ
 58DL7xM0LNTQDDfAZkhI3o7FWR2oHXn/Ht1k0os2vLSbc8RRjynTfwnoqOxnrAyc
 610uzir8zDAN2AUqghHpPA153jCqH7LndIiOaFUXP1N44vSiK1WIUkys/ivLDU2E
 L0IIqkCsj9RAINTsHo6HLd6lSg/XnQW85dGpgSCshsnFcp6z4+oJ8wgQpig==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r3y00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36803927a49so1345073eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599046; x=1793203846;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gLATyHerr+0gnqQJpQbcRGC8XwlZ1t5zo0KdmJWUQy8=;
 b=MNfQQPuud+Kv0sRDqAUknU/QJKFoMGsY8L98R5d9QeQGiQ/aOecEGannCLGczzUyxU
 oPbLfGrvAaI8fk5NM+sd6ghbdmEz9D7m3DMwjZaMoISbnV8gPd/EUiddzEKGJTib6y3a
 TAmZs+OcAZDliHzzALxJAP6mt2ojsmNF+M2s/YE1/neY5cOFw5ZkXDn82x3oQfTQ2bGZ
 1ZM9a+5oP9gHem4+MQZH4IWCelk30PtNOZWbNTV6rPQ1fwRDqyuUTq3QZgw7jyWy+jN+
 67+JPO4Hzbp5Gcm8MjETanS00YZlFUMAYlf+SETfUcU524D+QtucGAl2mD7bIM9OBECr
 k/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599046; x=1793203846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gLATyHerr+0gnqQJpQbcRGC8XwlZ1t5zo0KdmJWUQy8=;
 b=iEP601BIYGh73eLjtrV2DPL3JbM/lG008YgAA49p+VU5MJ2qHOujlXYc3OmO77+Rqv
 pgF3/Whe6z4kQqMkUJdVphxZWhCwiKcRDKj2SsdGPFm2+j4JmuXOsrPm02EYTj7t6HRC
 qj+6CLQI27KO8l5KxbfxbnLdzBDXAISPBTiUCFq7HC336fMrTaCMh3Y6Nnh4hIHSNlrY
 fjy+wQY2tJ36oAdnznQEtsbSUrYDpDlPA/mBZoNOb3C0pwOS+mKEAr4OmcN7yWX7wGFQ
 aVc6pnOVMPuKnWw3pXd9JuP/oIADvbz3fq1cPAkF3RjZwYf6f4OxgjIjiGcS12pFOX/R
 XpYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTge/rg9556mF1MVHnnkLoBgtH2MnOOxDaEbRQEX3xHHob3mtMxDaus306tcqpd6WlZZP3lhI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKfAUVEFaThoPSnaEkJ0Tp78QzIBhmhiJSq6GMcMK1rN1mQta2L
 HOv/pf4M+kuh2JR/KHJ0JzgdMYwsoTNjJVj7MwCJSEMvklKDfjnx0JkqsL3ecrqpDAjY8xKTR2o
 d3HrF24aqY3rwhTBTghe53iO0BUxB5Dg+VLojkd+EquCP5NIMab9/emOIDHPiiLNWJwl2tV4=
X-Gm-Gg: AYBFou1fKPlsXpgqYC1bOJtWY/iZaajqv4ELo0zh1yoAvSNwxnQ9J3nJAJ8/OEcq0Lh
 ta4ZNRZ5KHHVDA3HFUzdr/eAhRaJPbfipwPVPDBENK/WJSz32iGYtq8uolkhHv8goUeMJ3nlyv9
 ueY85X60UlE66ywIuc59P5hwf7LevXfJVJaCmA8K6M0WIhkEsy4jJxfEMz5B7rUvEZvaKN2fep9
 QN3m91tAygd5QFndXS+NPRXbwXpMxLpTYflN/MsdA+SkGG/aqMdKOrgwvQAeylQkO8Ww8E3U0n1
 sUKo5q+RSX5AdJ8tlP1xQHdrC+sqrX8jUeLW4fs7soy6R8EKYAgrRaCvPm4IvQnsdlckQUToyeW
 yG6kVarAec/y1wCmXR2jEA2yxJNCsxxV6cVNNR8Kyf4n+bcDVVIK5M6j9IxPPaDLGtYpSalNvWz
 +eBfUSwvuzRpuFLDA9WFw=
X-Received: by 2002:a05:693c:894c:20b0:351:52ec:60ee with SMTP id
 5a478bee46e88-3674f81fb30mr3727433eec.28.1792599045674; 
 Wed, 21 Oct 2026 09:10:45 -0700 (PDT)
X-Received: by 2002:a05:693c:894c:20b0:351:52ec:60ee with SMTP id
 5a478bee46e88-3674f81fb30mr3727382eec.28.1792599044864; 
 Wed, 21 Oct 2026 09:10:44 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:44 -0700 (PDT)
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
Subject: [PATCH v4 11/12] board: qualcomm: add MAINTAINERS entries for Shikra
 platforms
Date: Wed, 21 Oct 2026 21:39:15 +0530
Message-Id: <20261021160916.3894471-12-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e407 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=0qS0ShtDTrQMTPoL9qcA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: i3BHgUpE3NDgkTxMxqZntyLT90tpiX24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4roNvVKJoDSu
 KLrJVL/htOw/ejoeLx0ea597hLtLxLglY+qLoGMZ3wPGZk+vBYm3h7VD3e2R2e0XlW9pMLluzLL
 +vLikolJkLQQZFQRf5EFwaHbwwPQXbMj0USr/WP3qZP9waUiZ9g7BImOmSVEmMQ8+wrGXsB4Q++
 a0FmA+V0QwhDWPoxpqn6+cLnDqip4AUt4hoZs/vccelKTXZX1onHI+znlIP/oew0joHqnbXKuRB
 8ZN7sGhdoiUfLHCgaYEeFZs+KP39kOyDDoN/hk46yfUJjlLOxqqbBKuY5zcPlKBgi7HL3m4d5TW
 +qhFJLBoHOS2plRTGXXiHM9oLgs5bnLLtsOAwTYnr+Sx7DeefiCkxoUgzqr+HLEsSN+hdrCbJt4
 Th5x3MLtlj0FWWGC1OFH0wmAN70OnDnRztfDVbY5htfLZaGENtlr22XWmLjb4eHr1+gEf9866NZ
 zMMhol2zE6b8EhInlvA==
X-Proofpoint-GUID: i3BHgUpE3NDgkTxMxqZntyLT90tpiX24
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX0kcZ/GnPflYK
 PU3pJL9S3OqoEoINsUsl9oWdf9LLzIKzFsmPxppn1+GfbzJg6gn74h+ybKn7E328qpUi0xCpaaD
 j788knfNPiCAehtRyChLUQs0rWdbfCQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
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

Add MAINTAINERS entries for the Qualcomm Shikra platform

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a7949..f8cd20ee60a 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -6,6 +6,11 @@ M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
 S:	Maintained
 N:	qcs615
 
+QUALCOMM DRAGONWING SHIKRA
+M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
+S:	Maintained
+N:	shikra
+
 # RB3 Gen 2 and similar boards
 QUALCOMM DRAGONWING QCS6490
 M:	Casey Connolly <casey.connolly@linaro.org>
-- 
2.34.1

