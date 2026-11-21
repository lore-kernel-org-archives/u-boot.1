Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F2606A335
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kujfac2h;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wc+T1X1h;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fQF/aXhs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A70D98166A;
	Sat, 21 Nov 2026 06:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UvaTkpd5iHEe; Sat, 21 Nov 2026 06:40:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 097FE81670
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795243258;
	b=iODpP77jfBRysvxe8jb66seELJ8ankJlElqu8CimD+OpXMoXHoo+QI5NDNJl8MgkQEqc
	 OEuZ4I8lRWe1HfPB6f1Oi6j0RNfv7nCyF1hG20agvC6qZF3rDaEB1D6yMHHtesDpNWql0
	 WG9igWT6fZalo+2ya5fsB7a1KkYy7bz7sgg8/wGJSUvdZ5hgQe5QNU7fqSbuVV1E1XSuW
	 idFKU4ZjBJvPMd96ywNTIW+AMOMA9JCkqbh1A5TqJ0wA25JW7v4kiZxaWx/oe5tXkWM4P
	 v+LkTwx7bu77xgpHJugZodEAvcN9ucHLV4Bp8ygfa2GhgSq+xGbntSuTOR8Ee3Koc4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795243258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nmPpj5ny1dA4M1cOtsEmfepfctL8Fw+lSGFDp90ZFm0=;
	b=o7MiMzg5L1fhnc0iryZlX9HV7WqRzZ1rlQ6evMZH5tqiJofPE1Wkz/ff6zlIV1unxFFQ
	 HYdGK8f9beP2Svycmmo3unkMeswxSaaxOSlwGLOJsf+n6iHk8e2FQ9PGC4CEmhfbFvDHk
	 YJvgNMjDxMTLxJ0PaQa5kwyvPJGcBp8UU1F8CeBJzdTZkz9glZN4NNSjGJk3cycOYqAsZ
	 uBohwgaNzeG4iCSjm2KrkT/KNYk3gv0QOVkv0+IJGoF2Nhm3Kj8M2/mz0dOUAWtY/6H9a
	 4B6aA/ZdAm6EyzAWGeUP6uO9sNt+qtMcSzQdNvstP9jG/vH9LiQTLbzMz0g5zwMwsrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795243258;
	bh=nmPpj5ny1dA4M1cOtsEmfepfctL8Fw+lSGFDp90ZFm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kujfac2hd+JH6bscfRkvLdP8+J5k0zbU/wrGPKppbpX1E3V/SN2fN0OtiGwsyYTcT
	 TnH3jLnDRiPw06jHWV1yAFaFAQ+Q/zFQhO3p0GfDc9asnSFtARjqpmFaQGioOvtM2m
	 SG4q97ySBuMTabg2t6ADfSMo9U59TldrxWhKzolV4hbNCCX4AKB0IuRR8MPgfvfe/z
	 1LKAfbJEm1wrQpoDHUtyGnCvVQO9kWKxko+yPzindNIVF5jFuVxz1RRJ5eS1bMl2HK
	 Zs3x0JAtC7FMOk/+TLbUZ131xBKPiA619M/L75Skq13F3Agm4GWpZvIIvywWMOLAi5
	 w3JkwdYF02mbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 097FE81670;
	Sat, 21 Nov 2026 06:40:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC4909C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDAF040E4B
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zvv4X-L6pYFQ for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 06:40:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2F7E40E44
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Wc+T1X1h; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fQF/aXhs
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2F7E40E44
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AL4dpr22092312
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nmPpj5ny1dA
 4M1cOtsEmfepfctL8Fw+lSGFDp90ZFm0=; b=Wc+T1X1hz1n00FczgZ3VqrGYb2t
 PC5GdxHa9aZ24bWaQjEbPIaP2za7MSUrs2YTWAI7cXzioqENBmUSvOOM7r4YisL8
 whKQNL8SpvR20/WEKd3gWnNswJnXLLoe2lbrIGSMDNJ10K/q51naWD6aBnIqq/eA
 RT1usckdxcgFda4EsmKQlcveWTzsQEMWZyJ6Z0FGAT2MmRlEKhvKdVEXC3UPgfEG
 pIMaUyCa9cGt6gKodaaPgjN5VWutNGtuzG93/9D0zDJnReCJjgwfWbEmzvPYScpb
 kZV/C3CyNWW+TwzRXcN9iV1A9mZv/n0Yz4l4AnlNBGPDeegUXwPUqIiOqFg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34fk06jn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386a0f79047so35987eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795243254; x=1795848054;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nmPpj5ny1dA4M1cOtsEmfepfctL8Fw+lSGFDp90ZFm0=;
 b=fQF/aXhskrIwR3y8vP9DuNjoFJv/zCftQq2tbbIr2fSkB89jcdxedou54sBuR69hUM
 GiC9UfkeABbxrH1N3H4/1gBG+uU5bCIbF4z6omkL07QNDr+vP9tustFNAXC09f1WOQ6D
 Wuw6EISAieREF3D0cnrmW5k1drz1oEUP0xI/KxDXdQtFiacRYSyJNyBMDosuEq1WZWN2
 VjqNNtSQ7T2smg5m8xUBS6bxcTrY98m3Y0+kgU/I7+BryWKIhkVACktvq7Om728vYelS
 0tosnPHzUYAv526yh0mmrRVzJ0s2gxJdFTLwb5uvabcIoOT0gE/ngdGtJKgMl3/Dj2FH
 371Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795243254; x=1795848054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nmPpj5ny1dA4M1cOtsEmfepfctL8Fw+lSGFDp90ZFm0=;
 b=qoz0rv+6txUNeXHLf3qh2xubocdPv98s3AaeHNXWdo1/itPT9GEsoyexXlq/XqIzUf
 WUMsEDBEqN2BFRyPYFjnt2ZnQQBuuzq1O8Lzkb5VRz3cwy5GLcjlpYat72jI579bckP+
 efA4NslL3wzk1gkaDbqbniorMxB5pj1M9/5XLCtYF1fUbW3Nx1PN735h+UngVHoqosQg
 l3OuNuFyLMU/N7hZfNcw2RGP2ZQc6JS4jnru0zQ/7VMG4GvXlKkmp4fZ7dsOAPjbpP4g
 EIfntQO3b7tPl2ibRlpSv4Gg3O1stH/6eZGzMWqYJ64nGbOaCbrbGxc7j/hm+u1c+F4N
 WkXg==
X-Forwarded-Encrypted: i=1;
 AL+hErEF1faKHAj7P1k0BlxIqQWsMqVwQDyHS+d5RCNhe2YNaZWD1sjDGLrV/1q5ZyPFdEDe5rxPtA0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/19p8JqGp7U8KfkhIla/m/AeKLdTMHJLYMz5ktGU2wq8hWn/0N
 6ojvtMXOjgGF0oZxHH0Sa/tDrIliUPrNogHKlrBvkCDERw7MiBABa5b7a/Wdl9UHJDRLSZSzJ2N
 3OXHU+1cn7lvLeBduv4T57pTlVH0EAooRELJSjfbqjGDzYBFBf79vVgvzMA2x9pYlL91eIjc=
X-Gm-Gg: AZFdTZdrCLXd3CGjPUM1GMbJ0z6unoNYq+R4x7a+1YQ/JXrUHuoBgFz+p7lQpbIp1HM
 KhzRJx3q5SNj1ik8gg+GYtUm3WB+B0zvmZahbyNz4Mqf9DyxxaEhQUZJFzRw1C37WoUgFyUgttG
 qo/Jc7hKdYWeHeyhiREjXM+HmcxpJ9b6gpjYDODXOOG2WmmukeVJ02hmqQIZN2Oq/ijicqw49zh
 W81ZrZpk7HTW+mwpWYl358IF6z2hp3izVbTPd0DVFxFKImVPjCu/02/vxIXv8XS77K/pRRgtYAs
 QGKJ9IO1OI1YgECL4ejo6a8kCk6mgvbA3E+s0CIUBe4Zn3ckUI60d0KOSxjW2GNu+1WGqPVyOP2
 N/dpJAa0+l1rYvCKS9I54GSndaYbYKZurmo8RkNbWqwRbmsIOTJByOAZHUL+HG4aNboXCqrfBF/
 3r
X-Received: by 2002:a05:7301:1703:b0:386:319b:fb0f with SMTP id
 5a478bee46e88-386319bfc98mr3951676eec.38.1795243253866; 
 Fri, 20 Nov 2026 22:40:53 -0800 (PST)
X-Received: by 2002:a05:7301:1703:b0:386:319b:fb0f with SMTP id
 5a478bee46e88-386319bfc98mr3951640eec.38.1795243253192; 
 Fri, 20 Nov 2026 22:40:53 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm16970487eec.11.2026.11.20.22.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:40:52 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 jbx6244@gmail.com, dlan@kernel.org, anshuld@ti.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v2 5/5] clk: qcom: sa8775p: add SGMI reference clock
Date: Sat, 21 Nov 2026 12:09:19 +0530
Message-Id: <20261121063919.3313168-6-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oEmJ_mW3HN4CdHycxUM5b_OPhZSJ11fq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfX2LwkuEXqXHGi
 db9hoeR2hRHPJSlb1w3LO4hXmZ+rdEXp+eEVmbHkNsLjXrI/3du9hq3IZOGzb8X1OzQ/OPsgIJ2
 FLwvJe4rLVbyCOHU7FfqohEZY8Medex3d1y/OlT0u1UoDlT0U6EyxOAA8xRWGm0qCc0GKAgMPgE
 TBcozUmw8qnjOsEd195bzBL1mTIw+3XqBDnWzjFnCRSv2wXjfv6xL+9h42qR30jEVCpqXm1cSNP
 jvKk+uCZtALwqrIMUsSb4puMv/aEtKT0ga4xdGtOupasd4VUEykaigCHkxCMcHwGd1LrtSf5HJg
 DPZsm0PpMpAVOl7qg08/JhzYqUjDJy8ct4wIO+QlzqRaBzUnKmagUI5YfWMOP4hs5MUAcuXwRG5
 uKZ0q2kua+GZhMGCZxVUR1oirb6lPWE2xBgx3nGYVn4dX2aSjVl6hsUboWHd3DHAqiViC0sy5C6
 a4j62iKAT9hPLodSbxQ==
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6b013cf6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=WdjrKUAYfTe7CgnA5E8A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfX7VAjy9Dq51n+
 4mmVRT0X91X9TOCt4b1xxugAmTAVx2qV/UT2H4YjldFF4WwXv0/Dt0iP8UmA8ORc7FdqaFFBFWP
 fZfUHRlEsk2dZKnzHY5+1phQo0dN8U4=
X-Proofpoint-GUID: oEmJ_mW3HN4CdHycxUM5b_OPhZSJ11fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210026
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The SA8775P DWMAC SGMII SerDes consumes GCC_SGMI_CLKREF_EN as its
reference clock.

Add the SGMI clock reference gate so the SerDes PHY driver can enable its
"sgmi_ref" clock during power-on.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v2:
- No code changes.

 drivers/clk/qcom/clock-sa8775p.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index fd495b73635..65f8bd42a15 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -227,8 +227,9 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
 	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
 
-	/* EDP reference clock (used by UFS PHY) */
+	/* Reference clocks */
 	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
+	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x9c034, BIT(0)),
 
 	/* SDCC1 clocks */
 	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
-- 
2.34.1
