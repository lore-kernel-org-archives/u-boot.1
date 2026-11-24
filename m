Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC34606A33D
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xXngLv73;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ce7Wu3Rd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NuaCE0YH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCA82607DA;
	Tue, 24 Nov 2026 16:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RD_AqZ7MTQX7; Tue, 24 Nov 2026 16:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E0FF60806
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538858;
	b=sNLuEth5/uRv9sYkNaYNGzVKW+DQlNNfz+utd+5+TTYUUklkqPKVZRNzMEuHwsjE9xsV
	 0U/5jfZNMSzSPS5UvTsTOZy+etlK0Sud9xnRiMGz5mziKUQr6YXx2wp1wHh4PZqEJzwu3
	 fRkDKQ6ds1BCdTQ0w6LdSn8fnqqhbVeuSmkVOfaQ5nfXbuNAK2Qn/3zO26z14c9+J/Xp5
	 8nQndoeaZWeI6avpGj5TnwCo2I4vsjJbHZi8kAigE04NiWYmF/cyl2KiqvEb7iMint4xa
	 D38cTGpFUYEGW58DeJZX9loigkFtF6CIvUNYg0xz4LxgVjKGudRzlcXYwJ5xFoUGxrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kuanx1Ei48hLwuJiUQtHbAAGl7qp311jlGFImV7CnsA=;
	b=lu7P6xRkWUGafpyn2JS6tm1Ey5TSOWZ7skOufLC+plMuzwP1mZI4V47/9J2ZFSIE0VYA
	 neklf17Z58yzybIMBZwOkfIi9KmRpil4OE4QW8GZh1dWlirXHtK0X9jaA+huXDnYXbJOp
	 3htYKxywa+MaYT1L7QdoJILcnR1hxNkLWEuRjgRgnugynIUzKfBwC8n7V7TKBKiy2prLh
	 f0Lj3XfuG/It5DMVPb0tg9ObX3G/qS3yjIKZuw1LLygZYytiSNT47pAG2yj20nDOzXroM
	 kz1PbxiRwDOJvms4MGxfGWbzvfPspc64ZO2Ib+8FfOx2KcMU9jTypNMzQ3nSfmbvmgw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538858;
	bh=Kuanx1Ei48hLwuJiUQtHbAAGl7qp311jlGFImV7CnsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xXngLv73Gb8YzIXyHZFX0RfaA5BrNfZs77CNmfRcMiO0alAlYnlHTJ/Wlxp/O9vR6
	 Pw7GBIbRWBSi60MHDPDDDWcPEiMLhMHwk51eyPFK07h16EKoq3KJdYFytENq+369ob
	 IRz4dnfjZUdxks7IJit8fKQY519ano9l5sqHPHvlmhV7eBx0ybJGqk+gzylULOva2k
	 mxjl0kT6XJEMd6Db47OzxMWEWovOa5D/ix4qx4b1nhxSIk0I1siuH3fTzfr2OfcJna
	 AkYIB7gAFFD1HbXCiGg3d6pwpP7nIv4PUGA1yftVYfozNA+VVEyMqO2RMvhNb8gY4M
	 C0Tx9MYXFt3Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E0FF60806;
	Tue, 24 Nov 2026 16:47:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC5781C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9D264078D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YvTOkMVLDqxN for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68DDF405C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ce7Wu3Rd; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NuaCE0YH
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68DDF405C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL6hP1873502
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Kuanx1Ei48h
 LwuJiUQtHbAAGl7qp311jlGFImV7CnsA=; b=Ce7Wu3RdB07sE3i+zuf/01mCvfB
 phpfn78tosXy6hgsrxajx1H0L2BIMorBmj29zHjgD5/JyGy283yRDbUG0cAngWRk
 TM246pdXsdgeULr3P6CB57O+ntAlAM4LxfQaXrnBE1qR0O2+qB3ho+dwhfWfgLtG
 LSHUTBbzdtjlIc8hgRvoS5U6Ac0usa8uKBzDtrwwwhAm/uoJMwfsOk10YjLz5tCz
 SBvEWWfIA5OWHkugIqAM9ynMpRg4oz2aM37AMd0DYVAUvGF+IaGX/aJqlgAJqiyn
 yTwjzsQ9zW+9+STWIDwY6mMRTJtKW3JWMZwYXZ90twhiXr95hfBrsSHVfQA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxk8f5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386a0f79047so4820438eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538854; x=1796143654;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kuanx1Ei48hLwuJiUQtHbAAGl7qp311jlGFImV7CnsA=;
 b=NuaCE0YHOiTCZsNYf4r+pIgakKilp7dCgfzBaV2dY5LM8zfs8MMuOk1BVKEUbYXjhP
 t12w4JXcU4tjIw22xwpJst/XQW4Hx4hJdizsSsDdvVvpM9yuXqNR/I4UBVGTyV7YTdTw
 PQAubGNeErAynfRsty7MP/T3Gwy5hyCMgohAVZWjkvnYm1UDnG/nV28PRN8SpBUKfe7E
 PCfgSBrS8rR07Pi55ZmbE5U5vHtFzKR4NUIoPEcls8i2MaT9uz/5nShxbPsNj8T5PTH8
 0+CLfD3fkolWSqExN/CZWqZmxKKJAyH9jP+cDcEYpYndTtlMkMJc0W4g4/KZF0MHFL02
 hW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538854; x=1796143654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kuanx1Ei48hLwuJiUQtHbAAGl7qp311jlGFImV7CnsA=;
 b=ha4wo0bdJHQ4VrOPWeHdnTes6LhbycB+oaaAtbp5PSr0+h72sSDWLvnnkR6EFyeCKd
 PxwSey6HlcxVE9PXpsjzYorjtZOyTu0VjRb6cGhQlnTdu1y5ELXlw1M4fDJvXuPzILYa
 WvA51Phd5m7w+u25nEyp6MTfhtvVDutS4jL9hhJbH9PA5igfj9vEP6nrcYSPraJ5X1jK
 /ruMOP5i8fe9OfHDlc+nYJuSq4CzdJUm7Q1aeprQgCuneT5aY04rT7ccXEOmpixFr2gN
 6j3oVCUgeCHJci4NvkB6jgtAO2ti7BTS33ABqWmOE9G70oBxItpyMbgcjB/nF8ymfVCS
 4uew==
X-Forwarded-Encrypted: i=1;
 AL+hErEPygbueg1zT6ridSPU5pZvHa/VkhmycEKPhVWbYl3nfjFAMn8rtSp07obX0xgXbruXrOYJCg4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9fpZm9wXAsybcNfb8Xvm/kAUSV6wdWfO1Cc21TAOt+JHI+3YmD
 aygJ+dwq6wgiYyxcyLI/kZryFEiEGS1rvyzOxtuhFOTo1X9OkjRA8RoQcHzKjp98u99D6MINj9a
 9curzAa3C5zH3aIq7VCNwqOWp8pDz9gewvwBrOev75jGWhNwDP4LhCbLwLcBENjzKWqmcI60=
X-Gm-Gg: AZFdTZeXLGFuGwWOjG9+Z9jfMJBFs0dfJdfxRwwFHnNrXqp9yCmh1f/gpijZE9M7q1n
 nchLsHN6PEF9646qsLTdoJfwO4JcG74OlTSSqrvjDdLtZ3Gs56VyIiRRARhC/f2qUgp/c2sLXEV
 4ZGprLct0ptIX7RMzRhh3LeSEoANyI1Dj6GT8zHmaHWazwIGuO+e1XmNEjSdEtXYmaiBV4jkeAi
 eXJHJwg1SHD3+gJZHOIfu/5FxC5ujoAebE5RJvPqFx2NqscDziS+vVD8QTeQjlWSl1R5i20LfO2
 SqzdhIs3l4Aesrd5X2iueAHnWABaJ1HboPhoAAzogb3lvq8NcRVPmFt2Jz5mkojyVWWLMFEvqA8
 7nFbfz0MZ3BLIaYCh0UK1tw5jiAh6asu8woGeerZq1P+QZL7BOKEgkJvhgIXibmgQlhgZWBuVho
 oxg9W1J0KHZJ0z4YfQR6WKacmwhSes70lE62zxuq1PCULq0PHt/akOgcz/KCaUG0pY+6Ae
X-Received: by 2002:a05:7300:bf11:b0:368:7c2d:a612 with SMTP id
 5a478bee46e88-3856fe59b16mr15597420eec.10.1795538853315; 
 Tue, 24 Nov 2026 08:47:33 -0800 (PST)
X-Received: by 2002:a05:7300:bf11:b0:368:7c2d:a612 with SMTP id
 5a478bee46e88-3856fe59b16mr15597379eec.10.1795538852483; 
 Tue, 24 Nov 2026 08:47:32 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:32 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v6 4/9] phy: qcom: add QMP USB3 PHY driver for Shikra
Date: Tue, 24 Nov 2026 22:16:55 +0530
Message-Id: <20261124164700.1606518-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX0fhlbhHEknsW
 opAGi3k58mPvUBLnU9hoo6u/BKRPr8f4XlUTWl1+17PnqK1FBNOxPEoAN2bK5hUdgh9xjYVEXhj
 S9ETSRy9PxJGTnz3ZSPJgip/d0cktvSZOJL6HHogxRkNNPwAvKxnK3PgcBjQ/cOd8RiPX0tgDOs
 yjWJFqug9SBWR70CSzv+MggQ44YbTk246X2+QfAXr3MjJdfsUlVQEkQH9/Rp3CvHRBxgkw9PwWk
 W5dPRl/I2//jeYKD16nZas4gmFkkJKFHxBAjV+OkND54IQdjlCfWO8Vcpehztl7mvCV2EFi44TQ
 9+xeZJgO4piAH6YgA/kM7pmHKBBgrGI5fIBBmAx3y6u86iIoAgxPmzi44yrNi0SYjMjJH4kWRm1
 VVZATb96okWBKqujjniCahSfZjz0Xbt9DwJWenJCiZPDaf2AVm6mgefPsnHxka1aD1EppIUEMkn
 wZy45kfkJiu+swJwgng==
X-Proofpoint-GUID: nvc4TeVS7-eKa_MM3-dv-QqDTV6FHfZo
X-Proofpoint-ORIG-GUID: nvc4TeVS7-eKa_MM3-dv-QqDTV6FHfZo
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b05bfa6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=9AdMxfjQAAAA:20
 a=EUspDBNiAAAA:8 a=E7ACQvf2dqk3oRFqq0AA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX1Mi6gpmF3EJe
 JWsuoqcpULdmY9FrtJ6XicKCyGb0/JPOTN20vCncTFlkYG9UdLeENgt5Ac9Tz2djpRuS97JWXh3
 Yfd/WLAgSBM/A1oYItdxU0ejfEVfKvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Shikra USB3 QMP PHY uses a single-PHY DT binding (#phy-cells = <0>),
which is not supported by the existing QMP combo PHY driver.

Add a dedicated USB3-only QMP PHY driver for Shikra, porting the PHY
initialization sequence and configuration tables from Linux
drivers/phy/qualcomm/phy-qcom-qmp-usbc.c[1]. The driver is a
stripped-down version of the Linux QMP USB-C/DP combo PHY driver,
retaining only the USB3 functionality and omitting the DP logic
that is not required.

The driver is selected through PHY_QCOM_QMP_USB3_LEGACY and enables
USB3 PHY bring-up on Shikra platforms.

[1]: https://github.com/torvalds/linux/blob/master/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/Kconfig             |   7 +
 drivers/phy/qcom/Makefile            |   1 +
 drivers/phy/qcom/phy-qcom-qmp-usbc.c | 534 +++++++++++++++++++++++++++
 3 files changed, 542 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usbc.c

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 1fdadaccb12..b1748055448 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
+config PHY_QCOM_QMP_USBC
+	bool "Qualcomm QMP USB-C PHY driver"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the USB3-only QMP PHY (v3) found on
+	  Qualcomm chipsets such as QCM2290/QCS615 and derivatives.
+
 config PHY_QCOM_QUSB2
 	bool "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 714013dc572..2e9d3b35294 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
 obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
+obj-$(CONFIG_PHY_QCOM_QMP_USBC) += phy-qcom-qmp-usbc.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
diff --git a/drivers/phy/qcom/phy-qcom-qmp-usbc.c b/drivers/phy/qcom/phy-qcom-qmp-usbc.c
new file mode 100644
index 00000000000..c1d79b96cbe
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-usbc.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/uclass.h>
+#include <generic-phy.h>
+#include <reset.h>
+#include <power/regulator.h>
+#include <usb/tcpm.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/err.h>
+
+#include "phy-qcom-qmp-common.h"
+
+#include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-misc-v3.h"
+
+/* QPHY_V3_PCS_MISC_TYPEC_CTRL-equivalent bit, USB3-only PHY */
+#define SW_PORTSELECT_MUX			BIT(1)
+#define SW_PORTSELECT_VAL			BIT(0)
+
+#define PHY_INIT_COMPLETE_TIMEOUT		10000
+
+#define RESET_SETTLE_DELAY_US			10
+
+struct qmp_usbc_offsets {
+	u16 serdes;
+	u16 tx;
+	u16 rx;
+	u16 tx2;
+	u16 rx2;
+	u16 pcs;
+	u16 pcs_misc;
+};
+
+static const struct qmp_usbc_offsets qmp_usbc_offsets_v3_qcm2290 = {
+	.serdes		= 0x000,
+	.tx		= 0x200,
+	.rx		= 0x400,
+	.tx2		= 0x600,
+	.rx2		= 0x800,
+	.pcs_misc	= 0xa00,
+	.pcs		= 0xc00,
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_INITVAL, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CTRL_BY_PSM, 0x01),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
+};
+
+/* Per-compatible config; add a new instance here to support another SoC */
+struct qmp_phy_cfg {
+	const struct qmp_usbc_offsets *offsets;
+
+	const struct qmp_phy_init_tbl *serdes_tbl;
+	int serdes_tbl_num;
+	const struct qmp_phy_init_tbl *tx_tbl;
+	int tx_tbl_num;
+	const struct qmp_phy_init_tbl *rx_tbl;
+	int rx_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_tbl;
+	int pcs_tbl_num;
+
+	/* clock names fetched by clk_get_by_name(); "pipe" is fetched separately */
+	const char * const *clk_list;
+	int num_clks;
+
+	const char * const *vreg_list;
+	int num_vregs;
+};
+
+static const char * const shikra_usb3_clk_l[] = {
+	"cfg_ahb", "ref", "aux",
+};
+
+static const struct qmp_phy_cfg shikra_usb3phy_cfg = {
+	.offsets	= &qmp_usbc_offsets_v3_qcm2290,
+	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl		= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl		= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.clk_list	= shikra_usb3_clk_l,
+	.num_clks	= ARRAY_SIZE(shikra_usb3_clk_l),
+	.vreg_list	= NULL,
+	.num_vregs	= 0,
+};
+
+static const char * const talos_usb3_clk_l[] = {
+	"aux", "ref", "cfg_ahb",
+};
+
+static const char * const talos_usb3_vreg_l[] = {
+	"vdda-phy-supply", "vdda-pll-supply",
+};
+
+static const struct qmp_phy_cfg talos_usb3phy_cfg = {
+	.offsets	= &qmp_usbc_offsets_v3_qcm2290,
+	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl		= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl		= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.clk_list	= talos_usb3_clk_l,
+	.num_clks	= ARRAY_SIZE(talos_usb3_clk_l),
+	.vreg_list	= talos_usb3_vreg_l,
+	.num_vregs	= ARRAY_SIZE(talos_usb3_vreg_l),
+};
+
+struct qmp_usbc {
+	struct udevice *dev;
+	void __iomem *serdes;
+	void __iomem *tx;
+	void __iomem *rx;
+	void __iomem *tx2;
+	void __iomem *rx2;
+	void __iomem *pcs;
+	void __iomem *pcs_misc;
+	struct clk *clks;
+	struct clk pipe_clk;
+	int num_clks;
+	struct reset_ctl_bulk resets;
+	struct udevice **vregs;
+	int num_vregs;
+	const struct qmp_phy_cfg *cfg;
+};
+
+static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+	readl(base + offset);
+}
+
+static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+	readl(base + offset);
+}
+
+/* Quiesce the PHY; shared by power_off() and power_on()'s error path */
+static void qmp_usbc_quiesce(struct qmp_usbc *qmp)
+{
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+}
+
+/* Fixed orientation by default; use TCPM orientation if available */
+static u32 qmp_usbc_get_portselect(struct qmp_usbc *qmp)
+{
+	u32 val = SW_PORTSELECT_MUX;
+
+	if (CONFIG_IS_ENABLED(TYPEC_TCPM)) {
+		struct udevice *tcpm_dev;
+		enum typec_orientation orientation;
+		int ret;
+
+		ret = uclass_first_device_check(UCLASS_TCPM, &tcpm_dev);
+		if (!ret && tcpm_dev) {
+			orientation = tcpm_get_orientation(tcpm_dev);
+			if (orientation == TYPEC_ORIENTATION_REVERSE)
+				val |= SW_PORTSELECT_VAL;
+		}
+	}
+
+	return val;
+}
+
+static int qmp_usbc_usb_power_on(struct phy *phy)
+{
+	struct qmp_usbc *qmp = dev_get_priv(phy->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *status;
+	u32 val;
+	int ret;
+
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+
+	writel(qmp_usbc_get_portselect(qmp), qmp->pcs_misc);
+
+	qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
+
+	ret = clk_enable(&qmp->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		return ret;
+	}
+
+	qmp_configure_lane(qmp->dev, qmp->tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, qmp->rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
+
+	qmp_configure_lane(qmp->dev, qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+	qmp_configure_lane(qmp->dev, qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+
+	qmp_configure(qmp->dev, qmp->pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
+
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
+
+	status = qmp->pcs + QPHY_V3_PCS_PCS_STATUS;
+	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS),
+				 PHY_INIT_COMPLETE_TIMEOUT);
+	if (ret) {
+		dev_err(qmp->dev, "phy initialization timed-out\n");
+		clk_disable(&qmp->pipe_clk);
+		qmp_usbc_quiesce(qmp);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_usbc_usb_power_off(struct phy *phy)
+{
+	struct qmp_usbc *qmp = dev_get_priv(phy->dev);
+
+	clk_disable(&qmp->pipe_clk);
+	qmp_usbc_quiesce(qmp);
+
+	return 0;
+}
+
+static void qmp_usbc_clk_disable_upto(struct qmp_usbc *qmp, int upto)
+{
+	int i;
+
+	for (i = 0; i < upto; i++)
+		clk_disable(&qmp->clks[i]);
+}
+
+static int qmp_usbc_clk_init(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct udevice *dev = qmp->dev;
+	int num = cfg->num_clks;
+	int i, ret;
+
+	qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
+	if (!qmp->clks)
+		return -ENOMEM;
+
+	qmp->num_clks = 0;
+
+	for (i = 0; i < num; i++) {
+		ret = clk_get_by_name(dev, cfg->clk_list[i], &qmp->clks[i]);
+		if (ret) {
+			dev_err(dev, "failed to get %s clock: %d\n",
+				cfg->clk_list[i], ret);
+			qmp_usbc_clk_disable_upto(qmp, i);
+			return ret;
+		}
+
+		ret = clk_enable(&qmp->clks[i]);
+		if (ret) {
+			dev_err(dev, "failed to enable %s clock: %d\n",
+				cfg->clk_list[i], ret);
+			qmp_usbc_clk_disable_upto(qmp, i);
+			return ret;
+		}
+	}
+	qmp->num_clks = num;
+
+	ret = clk_get_by_name(dev, "pipe", &qmp->pipe_clk);
+	if (ret) {
+		dev_err(dev, "failed to get pipe clock: %d\n", ret);
+		qmp_usbc_clk_disable_upto(qmp, qmp->num_clks);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_usbc_vreg_init(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct udevice *dev = qmp->dev;
+	int i, ret;
+
+	qmp->num_vregs = 0;
+
+	if (!cfg->num_vregs)
+		return 0;
+
+	qmp->vregs = devm_kcalloc(dev, cfg->num_vregs, sizeof(*qmp->vregs), GFP_KERNEL);
+	if (!qmp->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < cfg->num_vregs; i++) {
+		ret = device_get_supply_regulator(dev, cfg->vreg_list[i], &qmp->vregs[i]);
+		if (ret) {
+			dev_err(dev, "failed to get regulator %s: %d\n",
+				cfg->vreg_list[i], ret);
+			return ret;
+		}
+	}
+
+	qmp->num_vregs = cfg->num_vregs;
+	return 0;
+}
+
+static int qmp_usbc_vreg_enable(struct qmp_usbc *qmp)
+{
+	int i, ret;
+
+	for (i = 0; i < qmp->num_vregs; i++) {
+		ret = regulator_set_enable(qmp->vregs[i], true);
+		if (ret) {
+			dev_err(qmp->dev, "failed to enable regulator %d: %d\n", i, ret);
+			while (--i >= 0)
+				regulator_set_enable(qmp->vregs[i], false);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void qmp_usbc_vreg_disable(struct qmp_usbc *qmp)
+{
+	int i;
+
+	for (i = qmp->num_vregs - 1; i >= 0; i--)
+		regulator_set_enable(qmp->vregs[i], false);
+}
+
+static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_usbc_offsets *offs = cfg->offsets;
+	struct udevice *dev = qmp->dev;
+	void __iomem *base;
+	int ret;
+
+	base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qmp->serdes = base + offs->serdes;
+	qmp->tx = base + offs->tx;
+	qmp->rx = base + offs->rx;
+	qmp->tx2 = base + offs->tx2;
+	qmp->rx2 = base + offs->rx2;
+	qmp->pcs = base + offs->pcs;
+	qmp->pcs_misc = base + offs->pcs_misc;
+
+	ret = qmp_usbc_vreg_init(qmp);
+	if (ret)
+		return ret;
+
+	ret = qmp_usbc_vreg_enable(qmp);
+	if (ret)
+		return ret;
+
+	ret = reset_get_bulk(dev, &qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to get resets: %d\n", ret);
+		goto err_disable_vregs;
+	}
+
+	ret = reset_assert_bulk(&qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to assert resets: %d\n", ret);
+		goto err_disable_vregs;
+	}
+
+	udelay(RESET_SETTLE_DELAY_US);
+
+	ret = reset_deassert_bulk(&qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets: %d\n", ret);
+		goto err_assert_resets;
+	}
+
+	ret = qmp_usbc_clk_init(qmp);
+	if (ret)
+		goto err_assert_resets;
+
+	return 0;
+
+err_assert_resets:
+	reset_assert_bulk(&qmp->resets);
+err_disable_vregs:
+	qmp_usbc_vreg_disable(qmp);
+
+	return ret;
+}
+
+static int qmp_usbc_probe(struct udevice *dev)
+{
+	struct qmp_usbc *qmp = dev_get_priv(dev);
+
+	qmp->dev = dev;
+	qmp->cfg = (const struct qmp_phy_cfg *)dev_get_driver_data(dev);
+	if (!qmp->cfg) {
+		dev_err(dev, "failed to get PHY configuration\n");
+		return -EINVAL;
+	}
+
+	return qmp_usbc_parse_dt(qmp);
+}
+
+static struct phy_ops qmp_usbc_usb_phy_ops = {
+	.power_on = qmp_usbc_usb_power_on,
+	.power_off = qmp_usbc_usb_power_off,
+};
+
+static const struct udevice_id qmp_usbc_of_match_table[] = {
+	{
+		.compatible = "qcom,shikra-qmp-usb3-dp-phy",
+		.data = (ulong)&shikra_usb3phy_cfg,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_qmp_usbc_phy) = {
+	.name = "qcom-qmp-usbc-phy",
+	.id = UCLASS_PHY,
+	.of_match = qmp_usbc_of_match_table,
+	.ops = &qmp_usbc_usb_phy_ops,
+	.probe = qmp_usbc_probe,
+	.priv_auto = sizeof(struct qmp_usbc),
+};
-- 
2.34.1

