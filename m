Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69D606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Os8JzjGV;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=paiAeIPl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OsrnMk5x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D04D8110F;
	Sun, 15 Nov 2026 05:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yrkaRt_vJTZg; Sun, 15 Nov 2026 05:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B087881108
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794719095;
	b=C8Hz9WeGctffnhWcB1hTTmP37+1NuFJBLh3mhg7CPLRCHAKPkOmaXjkj54QMMGFdT/1m
	 V6SmCmrtxuD3AQUZjZWUhCeyk9vNhKRo03g6WPCdQ8Ib2Kt4QrSUZ4LZfwqFlMmiJLciC
	 z49sLoMhLQ3EtDPRKZ1Vg726MpE/GWo44dQFwKz14QHHLRS/VHZBDa5B51V1V0G/rWxnd
	 D9KFxpiEeoPfZ7LdOXU6ivRueSb0YuhPhPNZNhkg5nlRLXZidWTifsfjbqYAe8guWf7Vi
	 5JGtejy8V/AV7g8NtRoWvmFEsbvmdJTVUyedaK/gu4H8LnfvlKemo/cOm2duWJd4iIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794719095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9T0V1Q8tX4M+6f4XvkyOlSzo67pEa8mzFPy7CgHNTiw=;
	b=lNRZur14x5gItrXYV8Bl1Ek62a9HfBiFzFJX7iUFvfzx0JfEWFCHNZEk6DOSdiZ0qKRt
	 mDFdpr+4kanS2mSvVOGPFIovUWAK2yND3shi5d8t73r452QpqUuILWmuGGD79ravj1a3i
	 O7lUFlArK4O7LTNiFKa4aSBYEWtQdWy4GvGUh4NNaSRhnKuHUkkJ35DXjiqMlmOH/rxW0
	 IgyPHszsjo6OKIRFT4vmAswDIT9vcfiJo6OzS99qpYsQVK1ONK+FYMsDkxlJsBPHZHlOu
	 y0VZ+CEKn/9izC/kUnjgouoxUFj6vk10qi5l9O0BWRwha5ESVg41lQ93nHTK8mOnDZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794719094;
	bh=9T0V1Q8tX4M+6f4XvkyOlSzo67pEa8mzFPy7CgHNTiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Os8JzjGVDZmNHCHMp+WqgvhlgDwEc/p/dwh/4nzUhpoyLGmCGfI+wSVe2PMVPpaV3
	 wvSlQRcV7rI7X1vDss/r3p0XXYfemKauJEsDuEgO/0ANu/SHOjWD3cnZUM6l+2Db91
	 ruwdS658CgnoB+lxWkWP5H0pENX00YGK3AXd4I9bCktfZRtegHepyW+G5vNHwD3Q6R
	 UoDgYMLG/Dg1aJrAYVqaAZZX6N9fs8z+ecS6Fn3SS1fBNeoalG8sAsAffuC0wPnTen
	 Lb6BG6d4LDasUKmzsarkkxJDKXNByC7+cGpS69HOUBm+yCshg1HRkIP06/peV062Yx
	 2gsp+NcGxBBuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B087881108;
	Sun, 15 Nov 2026 05:04:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67DCE2E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E2C1406A8
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ckEY6rXo_XlF for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 05:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1DF6406F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=paiAeIPl; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OsrnMk5x
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1DF6406F3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4S8pe1715903
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9T0V1Q8tX4M+6f4XvkyOlSzo67pEa8mzFPy7CgHNTiw=; b=paiAeIPlORSceB8X
 61YE80MY0nxou7QOYLPk511hQGSI/fEK5sOatBXmOKI9ideioBoTHK6dvbgh9Nbl
 gmp5Ri0DCFRj/886cX++5wQcvzeVe5FMPHxJDQzOzYob1PFlIz4+8RBDAjZ9JKSa
 Gz+2TIGFSBdElte4P+U98n5iZFhB7oHk0VpdgXjPd6kHUNkDMwpgDrpsWl3Bg/DO
 hxS2ZbvdiWVCk4lNrpAqZqIJvTO8S5AUsJSEkl0ugRBP08ycwA/vuSuQ9+O5lz6c
 SG/OYQxQ9UcDl4KkXnqMGMS1F5B5+k/oZDLEme7jLJ5L1d9sOtFPCVIcc77tfnQq
 XJHpFQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjte63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-375bac6bd21so1869466eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 21:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794719090; x=1795323890;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9T0V1Q8tX4M+6f4XvkyOlSzo67pEa8mzFPy7CgHNTiw=;
 b=OsrnMk5xD9CUuVFmOaU5R0CIdvXK/xQMFhFsVZmRbG5jB1GW4M+sgbY80AIsMXcMTN
 4sjzOzRMTB7EJcOKov/HHA1FfOFXAKYR9kfkeAabEuxRu7OoAZ/29OKIyCLELbIBv5j2
 CpvXTQNG7iZIckRUaI2azKaTssET66txEcj1OmTkbs8sgqDxEsBRmxdI5f8fRwed/ni6
 U7N93nOeLzQddAv0lrAuq28e2m3D5Tr3bHjAht1cPkjzxbiPSf+hsG7nojwXt77IGbQL
 dxkdwewhvHnLCfCG/tdiNeA8OK+fk8ALy0liOHq2R8eVRsTk4Z00Vw7/KMoLqcIXBLbo
 VFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794719090; x=1795323890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9T0V1Q8tX4M+6f4XvkyOlSzo67pEa8mzFPy7CgHNTiw=;
 b=Lvq3nw8TSWTAbS3TYitaTvjlOVfAKRSpyu776JFIo8ViWT/fbrz6PsIDLAmubP8Bbj
 xgKNtAuyC3PLNzwKMdlEttzjQQr8d4L11hr14KWbVyPGZkdoRPtlNKgp6HLaaWZEfqG2
 JnPJgoN7lNoXQ2S7UCQVSNaYGkORxZb8+NPtbifHsAJwn9SYMKflk79cK1dFeV14qvuZ
 tjhsDgmXiiximFOcyFYZKEyBD9AMt/1JUT3jjMKy/cgfGn1wI18yeLCs0XQwmaocS8HL
 glqMtYJfRhJoKSHYMmogzki68IBpr8HC0bgWHTnZxgHmTnXg6U36J4fH4wwhByxfMEWk
 MydA==
X-Gm-Message-State: APuU4Z8j7Ek/xJeE+xx1MpokzTbsPC3Xz0Dhhn5Vf0xxw6pVcwTMkM4M
 1n9p2CIEQoqPPqfTlQeJDapSH1jIhNogmZNMRn/kZaNmkpy6YedWD+nGm5TJrRLSL1C/CQTKmhx
 jUTud0n5Zi9huoEZ5QrV5qxwu2H0W7VPUtHTZDJAV/2RFEcKhGNnmPawxpOIu8FR5M5jClbs=
X-Gm-Gg: AYBFou3oZVGW5Dp3NIsyD7lWOOeurxLvBpAdA1j7+VodDhRFjdeniz1xCHWaBthPGJW
 /L8vWJ/UukowcJdnwLPEVvAk0rC2Yuw+IcMgRsoCBvPPz3goCVUko6D51rdMTNdSEcPz9NxO3Gx
 X9JMYytu+HEc9iUSdpOQTdnEYeQgYMGN292oKTrGDxGMNasCIarxoIeKBV44uFbhrQK2KWhjHLp
 NgeCNVvbgl8VL3Opc0TGp/7zVzaQ7tCNziRBzDvgjzQ0R2AkNXhdWuQIJVCWp7FZU+Y6oPahNYt
 kbvJ5JtTyC0Z7wq7MkqGF+HRyPjJrX56+dze35eEd0lDhl/2XN5ng6dN3/5CMTl1L40FXK6I+fo
 bePTQo07ppcOyaNieidUXPURgSxs7DA7og1kfifKYCWj8CxJTuzuiHAVxcp7/Dl0S4HgrikYnjA
 KdfnZog/bf3r5nfq0tqxThZfZL0LlAhLJ7/EJuBbFW16OJrN7Cty4ySHU/re6N44z78qCtXRQLd
 +PV
X-Received: by 2002:a05:693c:87d4:10b0:371:197b:5ade with SMTP id
 5a478bee46e88-377e1016802mr9557330eec.11.1794719090200; 
 Sat, 14 Nov 2026 21:04:50 -0800 (PST)
X-Received: by 2002:a05:693c:87d4:10b0:371:197b:5ade with SMTP id
 5a478bee46e88-377e1016802mr9557315eec.11.1794719089658; 
 Sat, 14 Nov 2026 21:04:49 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm23487034eec.23.2026.11.14.21.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:04:49 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:34:39 +0530
Subject: [PATCH v2 1/6] tools: mkeficapsule: Add multi-payload capsule
 creation API
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mkeficapsule-v2-1-9fe141b2cc7c@oss.qualcomm.com>
References: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
In-Reply-To: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794719081; l=13789;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=w/TKWp15CcychnVrD+jOlaGyQwhUWgt12vcJU6kOdRI=;
 b=NVgpZZa+MsnOLhpseWsIlQ2rDCvJNIX7oP6XiJ85ia9J4IxircjXAI/tp3O/TreccpODZ2g4x
 RYMYFpqiDRwCODQ3jx9rHFeSJ+DicxgjAmE7Tc2R1oXwoJR8wg4/xun
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX59K4KhEh9rpK
 uO6wtBRFHYJrEx5POw5RPEO21ZUNvrLYArsvOvMWOIrW+h+WcSZl/BDPeUSJ0+zNhUvwIckVXD2
 dG5k8BTLA5NqrE5ZAsslqgCj1SW1h8HCeuzDAnxKnPTDUsZ1WgfYGCzeLLyBhfa+1xFtpIl/5Kd
 1wpA3IkPEsBLBpU8vc8tmPGrlF9FTaSuaYCdnpJZx/Txy2SRPv8940l82WvOoviR1Dah+9U5WS1
 GcnTRcyxnAEeZwy5pOymWVzkIM84UoxMakAnGtFCJxnrc/vbSWHq4SnsnTtlPt7SNHcXVhaUDQw
 l/ydDktO97Gz4zfJfGv/PxmkyN6WJUY7exCsbCrjvcnEsyG9/+uthK5UsI4w3xKIQasoaYlmzaJ
 OYOU7ryVc5DGEdKiNwWEx1BqpGTY6t4AkmfuaAhnw6gzbFXIegoJmNpPi4fcjTCthi9Sf/e1UT2
 O09gFf7pZTNy2kmc+UQ==
X-Proofpoint-ORIG-GUID: rppXx96tCWZ6ST5FEiIP7RDuJq9LtMIz
X-Proofpoint-GUID: rppXx96tCWZ6ST5FEiIP7RDuJq9LtMIz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX2J1fcWA7cfhZ
 18tv0dHYrXFJZWHYtXkq+OxsORl3uVXkg7awUT7KSL4VTb6ZCwQmaRc+PIwZ5qTV0kQKE/hpd+Q
 sUYfFzfzxxWwHSucoHaQay+IyEoQsCk=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af93d73 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_rTo0WJ672u82lL3cEMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150019
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

Add create_multi_payload_fwbin() to bundle up to 16 firmware images
into a single capsule file. Only normal blob payloads can be
combined, accept and revert capsules are rejected.

Per the UEFI FMP capsule spec, signing is a per-image property, so
each payload in a multi-payload capsule can be signed independently.
A signed payload gets its own authentication header and PKCS#7
signature written after its image header, using the existing
create_auth_data()/free_sig_data() helpers from the single-payload
path. Unsigned payloads in the same capsule are not affected.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- add per-payload signing here, folded in from the separate signing
  patch of v1
---
 tools/eficapsule.h   |  61 +++++++++++++
 tools/mkeficapsule.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 292 insertions(+), 21 deletions(-)

diff --git a/tools/eficapsule.h b/tools/eficapsule.h
index 97d077536d5..e51e549e674 100644
--- a/tools/eficapsule.h
+++ b/tools/eficapsule.h
@@ -54,6 +54,12 @@ typedef struct efi_guid {
 /* flags */
 #define CAPSULE_FLAGS_PERSIST_ACROSS_RESET      0x00010000
 
+enum capsule_type {
+	CAPSULE_NORMAL_BLOB = 0,
+	CAPSULE_ACCEPT,
+	CAPSULE_REVERT,
+};
+
 struct efi_capsule_header {
 	efi_guid_t capsule_guid;
 	uint32_t header_size;
@@ -145,4 +151,59 @@ struct fmp_payload_header_params {
 	uint32_t fw_version;
 };
 
+/**
+ * struct efi_capsule_params - Capsule parameters
+ * @image_guid: Guid value of the payload input image
+ * @image_index: Image index value
+ * @hardware_instance: Hardware instance to be used for the image
+ * @fmp: FMP payload header used for storing firmware version
+ * @monotonic_count: Monotonic count value to be used for signed capsule
+ * @privkey_file: Path to private key used in capsule signing
+ * @cert_file: Path to public key certificate used in capsule signing
+ * @input_file: Path to payload input image
+ * @capsule_file: Path to the output capsule file
+ * @oemflags: Oemflags to be populated in the capsule header
+ * @capsule: Capsule Type, normal or accept or revert
+ */
+struct efi_capsule_params {
+	efi_guid_t *image_guid;
+	unsigned long image_index;
+	unsigned long hardware_instance;
+	struct fmp_payload_header_params fmp;
+	uint64_t monotonic_count;
+	char *privkey_file;
+	char *cert_file;
+	char *input_file;
+	char *capsule_file;
+	unsigned long oemflags;
+	enum capsule_type capsule;
+};
+
+#define MAX_PAYLOADS_PER_CAPSULE 16
+
+/**
+ * struct efi_capsule_params_array - Array of capsule parameters
+ * @count: Number of parameters in the array
+ * @params: Array of pointers to capsule parameters
+ */
+struct efi_capsule_params_array {
+	int count;
+	struct efi_capsule_params *params[MAX_PAYLOADS_PER_CAPSULE];
+};
+
+/**
+ * create_multi_payload_fwbin - create a multi-payload uefi capsule file
+ * @path:	Path to a created capsule file
+ * @params_array: Array of capsule parameters for multiple payloads
+ *
+ * This function creates a UEFI capsule file with multiple payloads.
+ * All payloads must be normal blob type capsules.
+ *
+ * Return:
+ * * 0  - on success
+ * * -1 - on failure
+ */
+int create_multi_payload_fwbin(char *path,
+			       struct efi_capsule_params_array *params_array);
+
 #endif /* _EFI_CAPSULE_H */
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index ec640c57e8a..befa01a9672 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -37,12 +37,6 @@ efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
 
 static const char *opts_short = "g:i:I:v:p:c:m:o:dhARDV";
 
-enum {
-	CAPSULE_NORMAL_BLOB = 0,
-	CAPSULE_ACCEPT,
-	CAPSULE_REVERT,
-} capsule_type;
-
 static struct option options[] = {
 	{"guid", required_argument, NULL, 'g'},
 	{"index", required_argument, NULL, 'i'},
@@ -705,6 +699,221 @@ static void print_guid(void *ptr)
 	printf("%s\n", buf);
 }
 
+/**
+ * create_multi_payload_fwbin - create a multi-payload uefi capsule file
+ * @path:	Path to a created capsule file
+ * @params_array: Array of capsule parameters for multiple payloads
+ *
+ * This function creates a UEFI capsule file with multiple payloads.
+ * All payloads must be normal blob type capsules. Each payload may
+ * optionally be signed independently by specifying a private key and
+ * certificate file in its capsule parameters.
+ *
+ * Return:
+ * * 0  - on success
+ * * -1 - on failure
+ */
+int create_multi_payload_fwbin(char *path,
+			       struct efi_capsule_params_array *params_array)
+{
+	struct efi_capsule_header header;
+	struct efi_firmware_management_capsule_header capsule;
+	struct efi_firmware_management_capsule_image_header *image_headers;
+	struct auth_context *auth_contexts;
+	FILE *f = NULL;
+	uint8_t **payload_data = NULL;
+	off_t *payload_sizes = NULL;
+	uint64_t *offsets = NULL;
+	uint64_t offset;
+	size_t capsule_size;
+	int i, ret = -1;
+	struct fmp_payload_header payload_header;
+
+	/* Validate all payloads are normal blobs */
+	for (i = 0; i < params_array->count; i++) {
+		if (params_array->params[i]->capsule != CAPSULE_NORMAL_BLOB) {
+			fprintf(stderr, "Multi-payload capsules only support normal blob type\n");
+			return -1;
+		}
+	}
+
+	/* Allocate arrays for payload data */
+	payload_data = calloc(params_array->count, sizeof(uint8_t *));
+	payload_sizes = calloc(params_array->count, sizeof(off_t));
+	image_headers = calloc(params_array->count, sizeof(*image_headers));
+	offsets = calloc(params_array->count, sizeof(uint64_t));
+	auth_contexts = calloc(params_array->count, sizeof(*auth_contexts));
+
+	if (!payload_data || !payload_sizes || !image_headers || !offsets ||
+	    !auth_contexts) {
+		fprintf(stderr, "Failed to allocate memory for multi-payload capsule\n");
+		goto err;
+	}
+
+	/* Read all payload files */
+	for (i = 0; i < params_array->count; i++) {
+		struct efi_capsule_params *params = params_array->params[i];
+
+		if (read_bin_file(params->input_file, &payload_data[i], &payload_sizes[i])) {
+			fprintf(stderr, "Failed to read payload file: %s\n", params->input_file);
+			goto err;
+		}
+
+		/* Add FMP payload header if fw_version is specified */
+		if (params->fmp.have_header) {
+			uint8_t *new_data = malloc(payload_sizes[i] + sizeof(payload_header));
+
+			if (!new_data) {
+				fprintf(stderr, "Failed to allocate memory for FMP header\n");
+				goto err;
+			}
+
+			payload_header.signature = FMP_PAYLOAD_HDR_SIGNATURE;
+			payload_header.header_size = sizeof(payload_header);
+			payload_header.fw_version = params->fmp.fw_version;
+			payload_header.lowest_supported_version = 0;
+
+			memcpy(new_data, &payload_header, sizeof(payload_header));
+			memcpy(new_data + sizeof(payload_header), payload_data[i],
+			       payload_sizes[i]);
+
+			free(payload_data[i]);
+			payload_data[i] = new_data;
+			payload_sizes[i] += sizeof(payload_header);
+		}
+
+		/* Sign the payload if a private key and certificate are given */
+		if (params->privkey_file && params->cert_file) {
+			auth_contexts[i].key_file = params->privkey_file;
+			auth_contexts[i].cert_file = params->cert_file;
+			auth_contexts[i].auth.monotonic_count = params->monotonic_count;
+			auth_contexts[i].image_data = payload_data[i];
+			auth_contexts[i].image_size = payload_sizes[i];
+
+			if (create_auth_data(&auth_contexts[i])) {
+				fprintf(stderr, "Signing payload %s failed\n",
+					params->input_file);
+				goto err;
+			}
+		}
+	}
+
+	/* Calculate offsets for each image */
+	offset = sizeof(capsule) + params_array->count * sizeof(uint64_t);
+	for (i = 0; i < params_array->count; i++) {
+		offsets[i] = offset;
+		offset += sizeof(image_headers[i]) + payload_sizes[i];
+		if (auth_contexts[i].sig_size)
+			offset += sizeof(auth_contexts[i].auth) + auth_contexts[i].sig_size;
+	}
+
+	/* Calculate total capsule size */
+	capsule_size = sizeof(header) + offset;
+
+	/* Open output file */
+	f = fopen(path, "w");
+	if (!f) {
+		fprintf(stderr, "Cannot open %s\n", path);
+		goto err;
+	}
+
+	/* Write capsule header */
+	header.capsule_guid = efi_guid_fm_capsule;
+	header.header_size = sizeof(header);
+	header.flags = CAPSULE_FLAGS_PERSIST_ACROSS_RESET;
+	for (i = 0; i < params_array->count; i++)
+		header.flags |= params_array->params[i]->oemflags;
+	header.capsule_image_size = capsule_size;
+
+	if (write_capsule_file(f, &header, sizeof(header), "Capsule header"))
+		goto err;
+
+	/* Write firmware management capsule header */
+	capsule.version = 0x00000001;
+	capsule.embedded_driver_count = 0;
+	capsule.payload_item_count = params_array->count;
+
+	if (write_capsule_file(f, &capsule, sizeof(capsule), "FMP capsule header"))
+		goto err;
+
+	/* Write offset array */
+	for (i = 0; i < params_array->count; i++) {
+		if (write_capsule_file(f, &offsets[i], sizeof(uint64_t), "Image offset"))
+			goto err;
+	}
+
+	/* Write each image header and payload */
+	for (i = 0; i < params_array->count; i++) {
+		struct efi_capsule_params *params = params_array->params[i];
+
+		/* Prepare image header */
+		image_headers[i].version = 0x00000003;
+		memcpy(&image_headers[i].update_image_type_id, params->image_guid,
+		       sizeof(efi_guid_t));
+		image_headers[i].update_image_index = params->image_index;
+		image_headers[i].reserved[0] = 0;
+		image_headers[i].reserved[1] = 0;
+		image_headers[i].reserved[2] = 0;
+		image_headers[i].update_image_size = payload_sizes[i];
+		image_headers[i].update_vendor_code_size = 0;
+		image_headers[i].update_hardware_instance = params->hardware_instance;
+		image_headers[i].image_capsule_support = 0;
+		if (auth_contexts[i].sig_size) {
+			image_headers[i].update_image_size += sizeof(auth_contexts[i].auth)
+					+ auth_contexts[i].sig_size;
+			image_headers[i].image_capsule_support |= CAPSULE_SUPPORT_AUTHENTICATION;
+		}
+
+		/* Write image header */
+		if (write_capsule_file(f, &image_headers[i], sizeof(image_headers[i]),
+				       "FMP image header"))
+			goto err;
+
+		/* Write signature, if the payload is signed */
+		if (auth_contexts[i].sig_size) {
+			if (write_capsule_file(f, &auth_contexts[i].auth,
+					       sizeof(auth_contexts[i].auth),
+					       "Authentication header"))
+				goto err;
+
+			if (write_capsule_file(f, auth_contexts[i].sig_data,
+					       auth_contexts[i].sig_size, "Signature"))
+				goto err;
+		}
+
+		/* Write payload */
+		if (write_capsule_file(f, payload_data[i], payload_sizes[i], "Payload data"))
+			goto err;
+	}
+
+	printf("Multi-payload capsule created successfully: %s\n", path);
+	printf("  Total size: %zu bytes\n", capsule_size);
+	printf("  Payloads: %d\n", params_array->count);
+	ret = 0;
+
+err:
+	if (f)
+		fclose(f);
+
+	if (payload_data) {
+		for (i = 0; i < params_array->count; i++)
+			free(payload_data[i]);
+		free(payload_data);
+	}
+
+	if (auth_contexts) {
+		for (i = 0; i < params_array->count; i++)
+			free_sig_data(&auth_contexts[i]);
+		free(auth_contexts);
+	}
+
+	free(payload_sizes);
+	free(image_headers);
+	free(offsets);
+
+	return ret;
+}
+
 static uint32_t dump_fmp_payload_header(
 	struct fmp_payload_header *fmp_payload_hdr)
 {
@@ -1040,6 +1249,7 @@ int main(int argc, char **argv)
 	unsigned long oemflags;
 	bool capsule_dump;
 	char *privkey_file, *cert_file;
+	enum capsule_type capsule;
 	int c, idx;
 	struct fmp_payload_header_params fmp_ph_params = { 0 };
 
@@ -1058,7 +1268,7 @@ int main(int argc, char **argv)
 	cert_file = NULL;
 	capsule_dump = false;
 	dump_sig = 0;
-	capsule_type = CAPSULE_NORMAL_BLOB;
+	capsule = CAPSULE_NORMAL_BLOB;
 	oemflags = 0;
 	for (;;) {
 		c = getopt_long(argc, argv, opts_short, options, &idx);
@@ -1111,20 +1321,20 @@ int main(int argc, char **argv)
 			dump_sig = 1;
 			break;
 		case 'A':
-			if (capsule_type) {
+			if (capsule) {
 				fprintf(stderr,
 					"Select either of Accept or Revert capsule generation\n");
 				exit(1);
 			}
-			capsule_type = CAPSULE_ACCEPT;
+			capsule = CAPSULE_ACCEPT;
 			break;
 		case 'R':
-			if (capsule_type) {
+			if (capsule) {
 				fprintf(stderr,
 					"Select either of Accept or Revert capsule generation\n");
 				exit(1);
 			}
-			capsule_type = CAPSULE_REVERT;
+			capsule = CAPSULE_REVERT;
 			break;
 		case 'o':
 			oemflags = strtoul(optarg, NULL, 0);
@@ -1156,21 +1366,21 @@ int main(int argc, char **argv)
 	}
 
 	/* check necessary parameters */
-	if ((capsule_type == CAPSULE_NORMAL_BLOB &&
-	    ((argc != optind + 2) || !guid ||
-	     ((privkey_file && !cert_file) ||
-	      (!privkey_file && cert_file)))) ||
-	    (capsule_type != CAPSULE_NORMAL_BLOB &&
-	    ((argc != optind + 1) ||
-	     ((capsule_type == CAPSULE_ACCEPT) && !guid) ||
-	     ((capsule_type == CAPSULE_REVERT) && guid)))) {
+	if ((capsule == CAPSULE_NORMAL_BLOB &&
+	     ((argc != optind + 2) || !guid ||
+	      ((privkey_file && !cert_file) ||
+	       (!privkey_file && cert_file)))) ||
+	    (capsule != CAPSULE_NORMAL_BLOB &&
+	     ((argc != optind + 1) ||
+	      (capsule == CAPSULE_ACCEPT && !guid) ||
+	      (capsule == CAPSULE_REVERT && guid)))) {
 		print_usage_mkeficapsule();
 		exit(EXIT_FAILURE);
 	}
 
-	if (capsule_type != CAPSULE_NORMAL_BLOB) {
+	if (capsule != CAPSULE_NORMAL_BLOB) {
 		if (create_empty_capsule(argv[argc - 1], guid,
-					 capsule_type == CAPSULE_ACCEPT) < 0) {
+					 capsule == CAPSULE_ACCEPT) < 0) {
 			fprintf(stderr, "Creating empty capsule failed\n");
 			exit(EXIT_FAILURE);
 		}

-- 
2.34.1

