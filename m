Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219C606A329
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QWiBqURl;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ob/q5o6b;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSImb8Bf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 635684076C;
	Tue, 24 Nov 2026 16:47:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yE2hN5w8x5hb; Tue, 24 Nov 2026 16:47:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C94B1405AB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538852;
	b=iCHbQINC03QJxeBwHz3n1cRboutYxksUbETHQJnwYJw84FR8IHZS7/3oiuuF2pO5VOfO
	 60xUzUFnsrVfPPqN6C+mSyNDInYNJBcXXMeRMfBK1gXZBnjZ242JwNslfIeFzeg6JGTSJ
	 vleCiV6/czaqPeCiWA3jztv1k7S+xoNkbYTaTnC0d9EGhe1z4+6kkAzMzUjsoi5PTrFOv
	 LbBCPZiTl9XOXIdsqedzfsuaTmyc4PYD6cxpOaN8FxfhOAiwQ1CgmjjdfBYx8XLJ0mBHt
	 bz4I+E1k/FHu6d4pue4JGkdRnl7NqFZMS/BAMsUoQ24LEOLvNPw/K8Gnuzkl7HI6r3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
	b=IGrxdbsrIAM+2O4voITyEuMrlYJFSBNGFTxDI0hSSUuRm70JF7P2VLQahw2qko1o+XZ6
	 FN2CreN4crzqPI7t6GI39bfxybzLJSXooaAQnaisl3Ak7pzPqPnpKD7K+S+wZhZlCt1MM
	 Wb1UScrg+TkIj40Qx0iwT4qWbzK2QAOsm2tErWqNVFJl+OfpxjVOJNLzNejY9Xedk1tcP
	 4254oa45xB1TV1hLeXH/zXQk0wLdlaoa9qH1kWBrDw6UPUzQ5KxSDM410PAPJmzL7RTHi
	 QOH7OpBKIdpB04Y4k/VvjJtF7p5yz+wnNkGMjrBh3L44ItCdbiwl2tdaCbxChvcaF6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538851;
	bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QWiBqURlHZop3QJRMFKAA1mycERWt74AfCkdFvDe6abK0iTuiT/VfOa8hhk8K6Up6
	 hAFDQCq2EYxSK8chT90L2y5Qfg5yetyE9MMtPr/LvXcjKcejQNmWOvAgeUcip0j61v
	 xTfjqky+1tczQGWNMUMP5/qsxzlPhmE2TUpelrVFhf/CjZDmYqirOrcDo/K5cbfg3r
	 T8eIrfW2cvcmHWcLG6r9nySlAQcW8e5cN8BkRsd+q5i83Th/5x/+TdZXDmKGWmhANS
	 mnz/0Cm00xZPecBM5C7Vx0X6zEUqWbyLphgW2kIVjPr5nbzmes70m3HO3zj+4O7Jwl
	 4ok8//PVEK3YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C94B1405AB;
	Tue, 24 Nov 2026 16:47:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD4EB79D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADC8560849
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nmxkZ6RvttqR for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF0B6607DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ob/q5o6b; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iSImb8Bf
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF0B6607DA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:29 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL3qh1696889
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EAbXaIYHumc
 IwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=; b=ob/q5o6brk7+1WlxfHdgd6uvAGe
 V3r9nwGVsGQFhurbbrZzkJkKiQIEhA3gTTVEpECHQwY4c0iJBwxKdMQ0p08Sz/tF
 ZyR/PHuRtMcY92DHA1rKbDGfiXmQS3Udv5EfEy8+e1Bs579+TC03luGSog8h6bX+
 fSpGk7kSd53wQWFQ3ZJQZuD8vvbfSEkeRq6oMoGcNMeeUv8vq3H+HFj2TWsIe+Ir
 FpbuB8Pan24dSmTSM8hLBJNbhA0raYPhV6EmLFH7W7J32K//BM3Rqoq4CdGrI9S2
 0Q5xATNJsZkQ4i0a7wTMzTT+MAlVI896Lw69I6NbL8+1HADOGDRG78VBeWw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b8011da-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5308374eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538847; x=1796143647;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=iSImb8BfJCkYzvvmi0oeujllfAOZgpKjB41FwfpPb/jEDiD0KWmlS7MYkz28MMbQId
 MPsA1Vph+XUbg+b8KpOn598T6MDMoVBwnrTRA1VoIj5s1dO7EJidLhh9vm5k4GZu9yc0
 sREUYQ4fBfveTE99APAS4pjPnrDyKOE11NGrVchOvdKnbdiiVvxBBieDxUzVOuyh2giD
 M8CzA6aTt6U1PQHk0l3UkT8aBu7qzxoXbLiiRrrdysGaImaJAqUteYVL1PHTkwquZXVg
 sTV2qO1tb+gGp1ghbZGKFHFwQWKcgIBbSlkA0aEj2hjdWChpMx32JcooXvQXcAMQmJDR
 r5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538847; x=1796143647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EAbXaIYHumcIwelEbn5jbotZ2P2pZDV9ZTkk9kqq/WE=;
 b=njGvVMc+R9j6qAp+f+/iYYm35PKWVEywtoBVFs3iO+kvHpHyTXydxAbYe+DizwFjk1
 DPzfCAxiWhyseF2kcCti2R6mS+Rpw2CqGCAahiVfcHs9D0GNGtQGvAi5gJZeW2BBPHSZ
 AaWogqme/yQ7e5W2Kc70Ll0EmCHMVSzvy5DEvc1xF0M3Va9S5lqh+l8NLwOYpwXGcus/
 BjpbIAoKomkGo+O87CSb50aCidF42s1uvPC9fFYRfqVBsC132BIQW+dmTwDifVQGRtPd
 /7dp+AWU1HOtVPJlolwh+AHULE3AlCWwb/6PWbYqATpHY9mvcS/bPjp/BOGAYFb6lyra
 iQMw==
X-Forwarded-Encrypted: i=1;
 AL+hErFLtO5j+23kPZFtVH7x+We81yoTOk4+iIVSERbiyFwDbZisszF8r0KHeXnrLpw+jbQiOvhDmkw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ZafAEIBw2xg61TM6p5zqpXqgqSQ41nCgtx5GiesncpbVHo78F
 OxwcYAmwRIq2Lyw43EH2JMwSfHs4Wo0SzKLytjiTW1M+9rOskhbBiu3QGsGvWBUN/2cJERowU9S
 0gqmBHNus/ELKALJXHCMKjxk9PxnbYXyDU1PtdwW0ggwwbIfCcuRF7J4rfSRoJWWoZ8eXOBU=
X-Gm-Gg: AZFdTZc0T43WnR1kZrsVBtylJ8quuV6cVvvoi0IIBW09SEalfqhEjZWU8ho4K6z0egX
 wKUt1WAyYbQyY71/AOuEL8uQmKaGSiWwksxuxtyjOFrkk6UDpjWIMjoVazWC5bSwuXE3KTqs0PD
 NEUHwTe+ap4f0hHwy0jFjgRBjDfyL1R98xBaohOPx9HPQ8kkhqZuoR/3KyQKPuSMRD5tcoGw+Xe
 ZDvNsUVnkzgoASRrF180OnYtGysv9B7N6XUHDj13czyOd0PCNw9HI1ebHhloukKQHcrdUHnWVlk
 SRdMBtbvaqnDFI5/uhz469K7Q/PRQwHH/eSI1+73/WLPrf9CfW1bFGpvOBEWJ+svCqNfgoA0XCE
 T15TyPXojJ17OX0RqLC0pwIXCr42mOHUh9RgomfPTVnzzyd6XoLtlBz9H+ir5YrGEZa55DygPvV
 /maM56UkIo9jFhUaig98/WDgQE275cfQJ4X6K3Bt9VxrXLmWFe5H60dQ==
X-Received: by 2002:a05:7301:140b:b0:386:ca0e:430a with SMTP id
 5a478bee46e88-386ca0e44c5mr920534eec.24.1795538847012; 
 Tue, 24 Nov 2026 08:47:27 -0800 (PST)
X-Received: by 2002:a05:7301:140b:b0:386:ca0e:430a with SMTP id
 5a478bee46e88-386ca0e44c5mr920488eec.24.1795538846372; 
 Tue, 24 Nov 2026 08:47:26 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:26 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 3/9] phy: qcom: qusb2: add Shikra PHY configuration
Date: Tue, 24 Nov 2026 22:16:54 +0530
Message-Id: <20261124164700.1606518-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX2ZGZqKaH2I78
 8UocGkbx7anIMwBk8/S+eeglciXvqe3VRUOIbC0YtpIOPDpsv57bfZ2/+qGtgKHSIdgkjR9JkJN
 k5lDalJ4vU/tgHPQ+UkOcxLYUpgvzhrPiw46K4yoWP148JwYUlmGFAyXWoDLJxT3UX/AyksFx+R
 mn50w1ofc9qNYpKhncoAwFzW9336GTFIkLdKNL83cx3m6mbk/mmc6iZ5wSpT3PgOiPRsIE31ZW1
 ztLumu+lhuLZXx2hHapBoJeuBndGVEkhCXmyVx6JKss++PJMEmliLhiFN+XcYn/Z46KWQpLB2WG
 jsdBYAh9QCU1FcsC60ZqwhTkJp5zp1kwek5ItDfqDD1MjO4VIvdoPya0Qi3Jnf5c9swfXe6Oxtk
 0APl+Z7luB89ZJr5e7Q6u1z8KILb6n/rjUzNqk6Mr5IWUJECBarCdUmReg5uWoED3xH2X2o0fY/
 /2YaJT/7C5Rm6AtAlTw==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b05bfa0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=qtZHeC2-AEtKh8AW8voA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: PlP2zSxzCsaNG0AZrU2hdqaEkc_-h9GY
X-Proofpoint-GUID: PlP2zSxzCsaNG0AZrU2hdqaEkc_-h9GY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX372OAHc7P8xH
 6r4tPyviWZ010bQC7UPwlnxx89VX0jTjFQGe8+J0U/e/g3cjXVnqlnQaMdiFOC3G4UYxnX5HP+Y
 MYKdokllQ5BS9xNnYcJ6w4M3wQiwO3E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the "qcom,shikra-qusb2-phy" compatible by introducing
the required PHY configuration data and binding it to the QUSB2 PHY
driver.

This allows USB2 PHY initialization on Qualcomm Shikra platforms.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index 6278171b100..f5214bffc52 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -310,6 +310,18 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.update_tune1_with_efuse = true,
 };
 
+static const struct qusb2_phy_cfg shikra_phy_cfg = {
+	.tbl = qcs615_init_tbl,
+	.tbl_num = ARRAY_SIZE(qcs615_init_tbl),
+	.regs = ipq6018_regs_layout,
+
+	.has_pll_test = true,
+	.se_clk_scheme_default = true,
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(3),
+};
+
 /**
  * struct qusb2_phy - structure holding qusb2 phy attributes
  *
@@ -505,6 +517,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,qcs615-qusb2-phy",
 	  .data = (ulong)&qcs615_phy_cfg },
+	{ .compatible = "qcom,shikra-qusb2-phy",
+	  .data = (ulong)&shikra_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
-- 
2.34.1

