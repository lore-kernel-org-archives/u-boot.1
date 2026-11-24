Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FF606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cSsog+1B;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwbmx9IV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKZgouxG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBF6C4076C;
	Tue, 24 Nov 2026 09:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bz9sZjWoO3Xd; Tue, 24 Nov 2026 09:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B93DE407AA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795510956;
	b=mJuo2LDw95J+DK3cvT8SBBy/w+4PlSy40h8SbWnR+77vZEj+6iZKTBvNxE+8NRb4TBjs
	 J06/hVQscOdu89hryFNaGBvKUy77qSBx/8WohmNU9HBrendAqA44m/MNp6webmbvIj4X3
	 H5FdeDu2GIj6kRORWUAzLaZK9hvJz1jBlocKNji5v+n7uQCoYHP2nrw3wY+SdLATHqZdr
	 nYb49PEWcLvrQk1GkpdXpueV3Ka0AKhuFkkFKMQ5T63wZ3/e7lQFlancwSs6+5mP+8zHr
	 LRcIlDmYJjMMxnGkDYlNxBKoLlzOThM/yJ2Q0kyzeeU8cfraJSv6AHfX+sVPcWRKm/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795510956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WK0CIqNWJpyeOatR2T9pz6pzC0yWxowX3B88CY7NgpU=;
	b=kRASetgrV63d2PXexR9lVAX/IM7cS62MQLiWaQ94nrsrZZX0zispXXUzOyFK2lEU8gLz
	 ZdEJxq+4maN4InhTHqMZ6Q9FSvsvjbMBKcXZGKUpzSyolhHmG1Iv0eezLATrl4P09rhPl
	 TYLhCDDe6nLmQaBcH1Z+vTStHF/0QkzhIxNrq3M+msW2HmCCfWQg8NxjNOadwSscotaIh
	 J1nCY03mzeAE6rySQ/aj4CTrznJcv+fo8yLKdkkAC4rnEt0jkE7rl5AK8Stwb1T3Y24Nt
	 VbDt8/35ob/9YkgAU7Gt/sQ5bzUxfD9uUqYShqr6VmHtc0mX556iNWQmmPsTiqY0FWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795510956;
	bh=WK0CIqNWJpyeOatR2T9pz6pzC0yWxowX3B88CY7NgpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cSsog+1Byyfs5OSWI/IXyXcBMpPRn5ANnioO+8x28vQuqAimFL7iI4f5mX7r3/RRw
	 Z91/SAwSRNP1VAiG0IQvsgngmjOAIp7rdkWaq7Shzrq3ejGmWsRA58lE/JS0h0/RM4
	 wA+9oi/wHshhbEFJE8Mq+JNoj0ra7XiQ4ldDw2oZhdMGUuNMwtoMb5srfVXkTu4doi
	 Y0+0HvOMCI/E+RvnJ6iOm9W+XPSs+VA5csgthYLq8EmoW5OYpFdQ7QHFAsMa+ICt6a
	 Wou+jBtpcU/6plHPKfF8DDJueD3zlCskFqFk/thgP8vIVRYu9xXpkU7X2ab0mIHnRD
	 BGGlzCTAncPlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B93DE407AA;
	Tue, 24 Nov 2026 09:02:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21FF9FBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 143AB402E5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3FtTwoc5hll for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 091E6400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwbmx9IV; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FKZgouxG
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 091E6400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8M2rB3701256
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WK0CIqNWJpy
 eOatR2T9pz6pzC0yWxowX3B88CY7NgpU=; b=fwbmx9IVrX+bOb8Cfl74sfkR2L6
 bmT6UOP4YdncpT+ZyVaCNULPHHEKrBdNws6nNOXGh4YrgvkUEh+JCXwMJDb/dTP3
 OzhZ7S4h9Hf/l6NCSXDX3JAsPFQY+PJ6ykDLgx4EE8F9x7gr8bBUGdCqWo3EYuY1
 uVzZ1Zgd8aUY3UM+qKdz8YrhKmVzI59zv51/A47dr6lF6nXHyaEIZ4mjG6ZnWflX
 A/2SfJL42EF1Lbt0WlHYqSNEP54KmqYY5TwNgwD5L3VBqLWdU03H3OzMIlh4jMen
 fDGbafmtmLrk5nvSBFfRt2DnA6cmMMrf+9nndj8T6m/3o0/jeo6EtGkjgoA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky1nee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3854627c1c8so6353623eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795510952; x=1796115752;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WK0CIqNWJpyeOatR2T9pz6pzC0yWxowX3B88CY7NgpU=;
 b=FKZgouxG3n+939WNUksq/qy+Bi0u34YONyIKUl+1bdIzVAy3W+LMehU/BCNhXx5zwa
 SmBOcwWKwhzn47/C64HFVtYXcldpygGCxTXZY58TZGAvl2SCJU9UZN13GbMPTOUfutpK
 eHycFPm3BTyHBSyrjZfxEH77U+A2oZynEx8IzShuoT/D4FxbcTT2tVlVkKNKcueuxuTI
 fOFQbYtXg13+5M83GWL+j+fMg1FiBAHs2oqRu1fTzzvxmLUAkgzZPzubvvfx5W/eBKdr
 lJPO72r4OiKSmgECYfwHpwpENHpIMcqKMxvI7lSkAO9RhGOdu6SiPMqO4wB+UN7Kr35y
 zT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795510952; x=1796115752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WK0CIqNWJpyeOatR2T9pz6pzC0yWxowX3B88CY7NgpU=;
 b=GDdOO6iX7nXc9USl5XLRrGBCk7/Cl+mypge7ZLjY0Dok8kIrWt87GOYyuvDxYIko6b
 EkgDgd+zTIYbrSfXA+GtzYG8B8JxUaqK1hjn6rz3Vu0lv8OXRJLo5Byc8z6N6iAh/B2w
 LxjfjigRwjTIuJlxerYUosME2QTaWNMIpaCmJqHNBCaVS9fuBdnvSyrwyZl5W3pNoEaI
 vSVhjvIHNvhAG6hZwk25/cAuyWtsb0YgQbmDkrByMBcoxGLjH6NB9NAGVwCLpu/pKHVF
 MHc66Y9GKGNqqM4sNMheCaKpY2zLjYSNxymjq7rI+yDmpBaQLPX01BVewwRQxpVvR8b8
 1gLQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEWzNgYbGMo0jUChFRsCIBvmNRk/BretWjXuQB2l1p5SnJPybzkkZVwgpk2Go9fuA1BAGsZYHM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8BmCS/aCN4HwucnEZdGynHGBEuGwUriFh8peUp3sy5+rgkPhFs
 UvT6d4IEBtsaaSzI/hc+VuNxUomN3EOz24+9bxW2Kb7rXvxXYbSQFd1M5ibviosaN4dmtGLAS8t
 2Sh/xL8n58wmiSkIXzC2FF5Ht30oCq5EtzSesiA+1BsB4rP0plxBHzQ41I7Q1HwQCRHtZ82U=
X-Gm-Gg: AZFdTZeO9EzgfDjiuaoRgv0rezaQbaFQ9QJ/ONITUsDRylIfrngIJ44dvv6QZDpmXfV
 szBslUd8K72vYNz6wjl/QGLzz/Jb/cQCuSIIPx9zLm8drk3bmGNnUBvE5UoEbNqzfap3axXtFor
 hi/6mhzp6/5Ng+4Zbm3RekI73XgSk07JRclcihN1MENMNOuP0n/rpdHIUyaShTFObAyPAnXckmC
 zwa57mSzu5m2KGRQyCXHU3Pa/VmOB+5157lp1kpqzt6gnpm0n19fPpCZlBLG8v84vQyfqFU0w/+
 8t3kzsdIWT/RKXD0e8v3obiaw5UrZ2z7vjwngderkxQO9cR/lQiyOonQpQ5ByFS9d9QpMIl0rRR
 A25BdDs0CMfgr1dhiR90HYLeEwd5srvcd8z5+zqd64jEqF37GI8uU7d/loQtyFRMlF3ZPxT3OV/
 gv
X-Received: by 2002:a05:7301:d813:b0:386:8bd2:da35 with SMTP id
 5a478bee46e88-3868bd2dbe9mr12313484eec.5.1795510951808; 
 Tue, 24 Nov 2026 01:02:31 -0800 (PST)
X-Received: by 2002:a05:7301:d813:b0:386:8bd2:da35 with SMTP id
 5a478bee46e88-3868bd2dbe9mr12313441eec.5.1795510951016; 
 Tue, 24 Nov 2026 01:02:31 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm46429154eec.14.2026.11.24.01.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:02:30 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, royzah@gmail.com,
 deepak.g10@oss.qualcomm.com, dlechner@baylibre.com, 3305708832@qq.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, jbx6244@gmail.com,
 dlan@kernel.org, anshuld@ti.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v3 1/5] net: dwc_eth_qos: allow platform-specific DMA channel
 and MTL offsets
Date: Tue, 24 Nov 2026 14:32:06 +0530
Message-Id: <20261124090210.2560500-2-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
References: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b0552a8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2-k0SVyLfpYsC9YwG1AA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 4yurF-_5moNJOCJ01t0QMAWT-_QKvCFs
X-Proofpoint-ORIG-GUID: 4yurF-_5moNJOCJ01t0QMAWT-_QKvCFs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX+e36fL/HRj0Y
 AdCbxZIL3hmBzCFyy3hWxG08yxi1iNqwOK0Iy9ccpgnYOMI93Z0OiKfBpwnBnXW6DEG+1hqkbMX
 My63oOq803Z9Cnj0ot+m/zvz9iV/Og4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX073tfBzAWz8A
 0WKbZLsmBAvydUq9COTChhkK2MLExn3DJx1lYIg9ZAIj06+UaYwGZSY0Dbg9oRswcxcE9tNEVHA
 CfiDL7fABVk5g4V1T7w+dZ6U8zOZhj/K2ADkfdASlklI82U1k8I184i8vt+ugGr5caefmINsrJR
 EOatYwfZMyXDsAdoZlo/9DB7truzvqlNmbejxJqQ261pC8ps/+J9sSNWKAzn6wObad/kKGJKRY4
 pWeUyhDpNjrtIDWdKMgaZWBhf57NDvIVTYZKk2fWrWmMJISgYyGkPGcTdlUjdPujvOpmXwUlfT1
 zpvUUfA4wjzjd4KB/SCTYfLQ8R/6XHvfNJscpWlELBqFQ4Hqc5Kg7tRlVgL6OHpa+gKseLXo7pN
 bmHpJZbcQM+gUjwZrtmd6faPuYOPQ2oGDnEvth4IrDpgiSzubZUjuRk7Pm/R8CvrquaKST3PADl
 GuNed6lFQm8f1F95gPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The EQOS driver currently assumes that the global DMA registers start at
offset 0x1000, the channel-0 DMA registers start at 0x1100 and the MTL
queue registers start at 0x0d00.

This layout is not shared by all EQOS revisions. On SA8775P, the global
DMA registers remain at 0x1000, while the MTL queue and channel-0 DMA
register blocks are located at 0x8000 and 0x8100 respectively.

Split the global DMA and channel DMA register structures and add optional
platform-data offsets for the channel DMA and MTL register blocks.

Keep 0x1100 and 0x0d00 as the defaults when a platform does not provide
the new offsets. Existing platforms, including QCS404, therefore retain
their current register layout.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v3:
- No code changes.

 drivers/net/dwc_eth_qos.c | 43 +++++++++++++++++++++------------------
 drivers/net/dwc_eth_qos.h | 35 ++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 565bda088b0..6f158202124 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -936,11 +936,11 @@ static int eqos_start(struct udevice *dev)
 	/* Configure DMA */
 
 	/* Enable OSP mode */
-	setbits_le32(&eqos->dma_regs->ch0_tx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_OSP);
 
 	/* RX buffer size. Must be a multiple of bus width */
-	clrsetbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 			EQOS_DMA_CH0_RX_CONTROL_RBSZ_MASK <<
 			EQOS_DMA_CH0_RX_CONTROL_RBSZ_SHIFT,
 			EQOS_MAX_PACKET_SIZE <<
@@ -949,7 +949,7 @@ static int eqos_start(struct udevice *dev)
 	desc_pad = (eqos->desc_size - sizeof(struct eqos_desc)) /
 		   eqos->config->axi_bus_width;
 
-	setbits_le32(&eqos->dma_regs->ch0_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_control,
 		     EQOS_DMA_CH0_CONTROL_PBLX8 |
 		     (desc_pad << EQOS_DMA_CH0_CONTROL_DSL_SHIFT));
 
@@ -962,12 +962,12 @@ static int eqos_start(struct udevice *dev)
 	pbl = tqs + 1;
 	if (pbl > 32)
 		pbl = 32;
-	clrsetbits_le32(&eqos->dma_regs->ch0_tx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 			EQOS_DMA_CH0_TX_CONTROL_TXPBL_MASK <<
 			EQOS_DMA_CH0_TX_CONTROL_TXPBL_SHIFT,
 			pbl << EQOS_DMA_CH0_TX_CONTROL_TXPBL_SHIFT);
 
-	clrsetbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 			EQOS_DMA_CH0_RX_CONTROL_RXPBL_MASK <<
 			EQOS_DMA_CH0_RX_CONTROL_RXPBL_SHIFT,
 			8 << EQOS_DMA_CH0_RX_CONTROL_RXPBL_SHIFT);
@@ -1001,16 +1001,16 @@ static int eqos_start(struct udevice *dev)
 	}
 
 	addr64 = (ulong)eqos_get_desc(eqos, 0, false);
-	writel(upper_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_list_haddress);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_list_address);
+	writel(upper_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_list_haddress);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_list_address);
 	writel(EQOS_DESCRIPTORS_TX - 1,
-	       &eqos->dma_regs->ch0_txdesc_ring_length);
+	       &eqos->dma_ch_regs->ch0_txdesc_ring_length);
 
 	addr64 = (ulong)eqos_get_desc(eqos, 0, true);
-	writel(upper_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_list_haddress);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_list_address);
+	writel(upper_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_list_haddress);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_list_address);
 	writel(EQOS_DESCRIPTORS_RX - 1,
-	       &eqos->dma_regs->ch0_rxdesc_ring_length);
+	       &eqos->dma_ch_regs->ch0_rxdesc_ring_length);
 
 	/*
 	 * Point TX tail pointer at the first descriptor, implying no descriptor
@@ -1018,19 +1018,19 @@ static int eqos_start(struct udevice *dev)
 	 * a packet in eqos_send().
 	 */
 	addr64 = (ulong)eqos_get_desc(eqos, 0, false);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_tail_pointer);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_tail_pointer);
 
 	/*
 	 * Point RX tail pointer at the last descriptor, implying all
 	 * descriptors are owned by the DMA.
 	 */
 	addr64 = (ulong)eqos_get_desc(eqos, EQOS_DESCRIPTORS_RX - 1, true);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_tail_pointer);
 
 	/* Enable everything */
-	setbits_le32(&eqos->dma_regs->ch0_tx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_ST);
-	setbits_le32(&eqos->dma_regs->ch0_rx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 		     EQOS_DMA_CH0_RX_CONTROL_SR);
 	setbits_le32(&eqos->mac_regs->configuration,
 		     EQOS_MAC_CONFIGURATION_TE | EQOS_MAC_CONFIGURATION_RE);
@@ -1062,7 +1062,7 @@ static void eqos_stop(struct udevice *dev)
 	eqos->reg_access_ok = false;
 
 	/* Disable TX DMA */
-	clrbits_le32(&eqos->dma_regs->ch0_tx_control,
+	clrbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_ST);
 
 	/* Wait for TX all packets to drain out of MTL */
@@ -1091,7 +1091,7 @@ static void eqos_stop(struct udevice *dev)
 	}
 
 	/* Turn off RX DMA */
-	clrbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 		     EQOS_DMA_CH0_RX_CONTROL_SR);
 
 	if (eqos->phy) {
@@ -1130,7 +1130,7 @@ static int eqos_send(struct udevice *dev, void *packet, int length)
 	eqos->config->ops->eqos_flush_desc(tx_desc);
 
 	writel(lower_32_bits((ulong)eqos_get_desc(eqos, eqos->tx_desc_idx, false)),
-	       &eqos->dma_regs->ch0_txdesc_tail_pointer);
+	       &eqos->dma_ch_regs->ch0_txdesc_tail_pointer);
 
 	for (i = 0; i < 1000000; i++) {
 		eqos->config->ops->eqos_inval_desc(tx_desc);
@@ -1212,7 +1212,7 @@ static int eqos_free_pkt(struct udevice *dev, uchar *packet, int length)
 			eqos->config->ops->eqos_flush_desc(rx_desc);
 		}
 		writel(lower_32_bits((ulong)rx_desc),
-		       &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+		       &eqos->dma_ch_regs->ch0_rxdesc_tail_pointer);
 	}
 
 	eqos->rx_desc_idx++;
@@ -1435,8 +1435,11 @@ static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr
 
 	eqos->regs = addr;
 	eqos->mac_regs = (void *)(addr + EQOS_MAC_REGS_BASE);
-	eqos->mtl_regs = (void *)(addr + EQOS_MTL_REGS_BASE);
+	eqos->mtl_regs = (void *)(addr + (eqos->config->mtl_regs_base ?:
+					   EQOS_MTL_REGS_BASE));
 	eqos->dma_regs = (void *)(addr + EQOS_DMA_REGS_BASE);
+	eqos->dma_ch_regs = (void *)(addr + (eqos->config->dma_ch_regs_base ?:
+					      EQOS_DMA_CH_REGS_BASE));
 
 	return 0;
 }
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index ef07660a765..b2e35c72423 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -151,24 +151,28 @@ struct eqos_mtl_regs {
 #define EQOS_MTL_RXQ0_DEBUG_RXQSTS_SHIFT		4
 #define EQOS_MTL_RXQ0_DEBUG_RXQSTS_MASK			3
 
+/* Keep global DMA registers separate from per-channel registers. */
 #define EQOS_DMA_REGS_BASE 0x1000
 struct eqos_dma_regs {
 	u32 mode;					/* 0x1000 */
 	u32 sysbus_mode;				/* 0x1004 */
-	u32 unused_1008[(0x1100 - 0x1008) / 4];	/* 0x1008 */
-	u32 ch0_control;				/* 0x1100 */
-	u32 ch0_tx_control;			/* 0x1104 */
-	u32 ch0_rx_control;			/* 0x1108 */
-	u32 unused_110c;				/* 0x110c */
-	u32 ch0_txdesc_list_haddress;		/* 0x1110 */
-	u32 ch0_txdesc_list_address;		/* 0x1114 */
-	u32 ch0_rxdesc_list_haddress;		/* 0x1118 */
-	u32 ch0_rxdesc_list_address;		/* 0x111c */
-	u32 ch0_txdesc_tail_pointer;		/* 0x1120 */
-	u32 unused_1124;				/* 0x1124 */
-	u32 ch0_rxdesc_tail_pointer;		/* 0x1128 */
-	u32 ch0_txdesc_ring_length;		/* 0x112c */
-	u32 ch0_rxdesc_ring_length;		/* 0x1130 */
+};
+
+#define EQOS_DMA_CH_REGS_BASE 0x1100
+struct eqos_dma_ch_regs {
+	u32 ch0_control;				/* +0x00 */
+	u32 ch0_tx_control;			/* +0x04 */
+	u32 ch0_rx_control;			/* +0x08 */
+	u32 unused_0c;				/* +0x0c */
+	u32 ch0_txdesc_list_haddress;		/* +0x10 */
+	u32 ch0_txdesc_list_address;		/* +0x14 */
+	u32 ch0_rxdesc_list_haddress;		/* +0x18 */
+	u32 ch0_rxdesc_list_address;		/* +0x1c */
+	u32 ch0_txdesc_tail_pointer;		/* +0x20 */
+	u32 unused_24;				/* +0x24 */
+	u32 ch0_rxdesc_tail_pointer;		/* +0x28 */
+	u32 ch0_txdesc_ring_length;		/* +0x2c */
+	u32 ch0_rxdesc_ring_length;		/* +0x30 */
 };
 
 #define EQOS_DMA_MODE_SWR				BIT(0)
@@ -242,6 +246,8 @@ struct eqos_config {
 	int config_mac;
 	int config_mac_mdio;
 	unsigned int axi_bus_width;
+	fdt_addr_t dma_ch_regs_base;
+	fdt_addr_t mtl_regs_base;
 	phy_interface_t (*interface)(const struct udevice *dev);
 	struct eqos_ops *ops;
 };
@@ -272,6 +278,7 @@ struct eqos_priv {
 	struct eqos_mac_regs *mac_regs;
 	struct eqos_mtl_regs *mtl_regs;
 	struct eqos_dma_regs *dma_regs;
+	struct eqos_dma_ch_regs *dma_ch_regs;
 	struct eqos_tegra186_regs *tegra186_regs;
 	void *eqos_qcom_rgmii_regs;
 	struct reset_ctl reset_ctl;
-- 
2.34.1
