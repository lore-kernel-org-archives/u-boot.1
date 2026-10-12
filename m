Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79511CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24F6C405B2;
	Mon, 12 Oct 2026 20:25:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lDWdSgM9j6K; Mon, 12 Oct 2026 20:25:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13CA340574
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791836739;
	b=IC6fLMggG9udawhJeXgpizEeJWSbw3/8cFMmaF8FlU2oaj5RXY1ormncLTDJPkzeizEi
	 4IUY1kICe3MdwSHfPHhBtRWoMw6pV1RPTxRwfgj3y3JXfysLhjpmy4HWaX/ekMF7+Kf7p
	 3lGRDBrizDnW0OLTsmuk2Z9NfZNQ/AinnAqwUqvs2y6sQKi73OZlsgmXAhmJ450bOO0iH
	 bFY7/JY/WqeJ3lN/7K2E2yqjxHaALLc1xqAEMcFmWEpM2hlNFN/DidnwHY7wHctwCc+xN
	 cqB5io0l3vCvtW56cLh1ciqVCCmX48peApQfaEex6F2BZ84CgCtQq6eIb3Wb+AEKMMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791836739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
	b=jOZ3GvFPuHX24Sn1rtHPux+xQOici2O7XKDa3KmisqbqYwJAY2n2+5kFiyYwW6WOUP3Q
	 rE1U4a93MF1hBkcXdT5mTdtnEaDfB8ZhN1Hgsi5BJEyCgQS+Jtqj3RLHb/4Mlq3N1T4pY
	 VKI41FfM7AbmJktAmMO2Cby/G/mMCAXwu/ceU/QZYIriyUqet/kaXrMTzIk9G2VmERBUA
	 VI75TwC8iMyOqmDb0P2aNBfhjz1OAf8uXNyBILmm9vnkW7A8VBclkNU5xV0r2FWq3zFVq
	 aobFiEfRfs7uQpj3ptIUEWN6iFKD8iQsHLkh0kC401oH6aA4o4YKCz5Qg562ej0rwSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XnGQvaCT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JXKDOQed;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791836739;
	bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pfWXfapyvF8y1yn3in5BYGizWc/RamzlkwpihBPxK6znDh1IiGMTqv8zOj4gR/AEY
	 qjQjRINe76kDo3tiBQf2ysabCCO22RvED7lVl2r7upnCmpJqX85pUv17KIWHFRa90f
	 qayyfPOxivwZxH2XtMDpA3rgopKEYAqZyrOYZNfZEH/lf9p7QZ2LCP4cyxEbN/w5Q+
	 c790bFJT6s4ktYmoGavbxPgSkKoBCu4rlr7zYZD8lLYleFDOlK5dB6ANMXEU7I3h5E
	 nOo1KCYm8skRz4nEwWCUOjuI4Z9l9M+kO8SDvlwyokv4UsKuyrHCV0jq0BWlaBXl3J
	 L/UrDeWXfRkcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13CA340574;
	Mon, 12 Oct 2026 20:25:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87049731
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7943140577
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7L9vw3BtxCZ for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:25:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8775A40564
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791836735;
 b=F7JAwnCEKMPBYRv+JoMHO2UrqVG0HCvk0O5mt8nJF8G45brxmxLXLy4rjLw/mCo9WCYt
 CMxO6EqAIz/70h6YdzQPm+gWEmYNc1Q9XWvT8R7xtOGbCYkRoaoZlscBkjJAbKsEkJ/Oa
 8MgnJMEGo9zANPA4bMozm/Yr0aob+PDfcG6gXHQMofH6Vt/yVvmlEyM7sRYDrzl3EfYsG
 UPKWAicrck3adDnfJYjMBFPvyZX/VrOK8dUKUBEunLcuzS8VajifJTtzlUMluqhft287s
 Xm+sWaYX128ZrhAGMbOs1DibiN1oNKJJLQWo+rLSE6UAJa53NcF03h3SnUey+KD+NXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791836735;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
 b=NvzoXhXsWJItpPNMN2MYIIA8B5Y2HeKFsPu+GQq0zOuiBEUc4yHkmd3vK5glOMt0KC84
 oLpoqnscT9wi1m4cwe2AFoO9kYFrBe/R8F18DdeRS56SB8bJ6GkwgjoFujElTyol58ZAl
 8If1ZywQjnIQGWgzINWo4VA1bAYlHE8a1T2lyQ57EmSN+zrx8zubwG+42DEghDSigwl8Q
 ng4GGxKXlrUUC62G3Ikr3KnahXQUCUkl7FH56pnBrs9qUn5IYxWE7BcrN9s8pt7llCR0C
 e4V9WDdzKOtJZ5fMjsnfl2qvFexXHzQ5j7choPTAB6Bh3QlMWU4WAVK3nxkeK2mJcrA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=XnGQvaCT; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JXKDOQed; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XnGQvaCT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JXKDOQed
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8775A40564
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJMtjZ2384231
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=; b=XnGQvaCTVmPqDAjN
 HKM9OnlRmepmU/95re28KKG40mJ5M3rtIbcApHWtWzuXQOKZZJrPmNeKrGzCZmHn
 BY4HaGGPFsl1HEGIsbAGwSQif+Cp2iVRlFHJyuid2VCNXJW+RXkenaq3iX/eWMgP
 291IctqohL25kQXeLZJyeRPWXP1YdTgZD/IwDIxFuEXkKNc7YBK5aiPYSL8RLBJ+
 p/4uiTH+3+ufFsL8zenENn760r0fGwLG/zLtU1LvBWyCIwu+hnqayox22p5YNGb9
 l6YA+kaAcHcnz0AlWlC9G3BzagX2bixHTekM8QMItp+OsdQo5gDeNcsr7qwrjnOk
 hvtk7A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ku2mp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b861c0618so20304326d6.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791836733; x=1792441533;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
 b=JXKDOQeda41vUHxBxricwFUPp++iSUpPh3+03kQ0PgCX0NptaxdkUFST0HhfCR8hl4
 ty9GTCTPe97Mdo8sTaNnCFa0WQP9NAbC8RB0Yno42DgP8Aq1ioS0seD/OgFM5l7h2i8i
 wX0dclQH1uetnpJ+bR2n6iJoBoKWqnQYahwDCNJVwcEeBXCCtyLdwqkGGqL4dJ23Xsv+
 v44MDVTV4RI/yDsYNLUojqtLmnHn2wmMNZMw1jdnzIyQnZPIemC2lTb/Za/HJh6mjBLj
 s4omEuWMCRh5wVMJ2ZFJkPfYk8jiGx+13MSa/nIxMerGw7O284yGyxI5wGAoNe63w30N
 kfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836733; x=1792441533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
 b=DRQ+lugwNeE5Adheb3kVmAR9JwTu/ONIWnfMxxMEjLKTF44EpvzpfAkB6+FlbKJ4U2
 QnwVYHPrh15mxmP4kGQ2UlXmbToKBJBueSZ2ChLfA56IvLrwlpfiFaNt3eWRE2aXC/l9
 hMzVK1XffAPnULx4EeURcZ/pfl24zemaEMAwZGOoL/WCsWtOmmL1HwwINidWqnEP4yBa
 /+DpSMxBmwd0D2JVE3DGdVb9kXsUmPcr9ZK+KGBbjCooQqe419wBeafIoOojxjaHGxhQ
 3aWiADbjDHg3/lfUxehrXtKT6VlUXNhkUqn7B9KZ6CVzc4ysCbPUcOppS4JJifjSXNoD
 XkZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxh+g34Fmpz/CEOf34MsNcdSg0IPesbx9TIoVrUFevuOToVLAYo9BVSzwEJujaHRbbdsRettps=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYInusyb4nIwz3WGQnsepUSrygByuIwh6prhD4iRxC2OqZpTS7sn
 9DmA5y081zOVARyubfC/E4dPOBD+XD2Ojp8XKmcuSp8RQVszRk0sVzH097w0Xu0r5k0w/5v2QDB
 lV2KX0G/ZgeksnC0kdTl9pstj/V93nqxQ+XoYllz446ljubg2Co7cjLAi0Zswv0GdRkl3KrzRDV
 ONzXM1dD8I
X-Gm-Gg: AYBFou1bQSck15RJdg54bC3nUg8VfbGv9CuWYsYhEfjhyvm+gBeCk6ydl683N22BD6X
 In1/oozwmC3twpYXvpQRS+4/vplCBClEwjSFzRIa1sLC8g47i0QC6HS/rlE/n9Ja3O+NNqTU7kn
 3PzV5FYqTKdyGOfurU4g2O3gRSoUq2wgb/hEERcHdUGXqFbe7DtukqMIWDiTuPYJweeverIZ1LP
 eUcn4Ko6RacQN9jrRRvifgh6XMom9yF4sN4VZQ91NnHbTuhp9bdScb7kLvACpjBfeEzrYEyrSRA
 nG8Oyjmfnx/ik8dcGPmb/ZCQVUGMBLcuJ8c6BmVWlI/opgvcP1Pt0gXbvztpQhG0z4ITin+viYm
 f2VAVWKPPumX49KSC8h3itiTVD5oxS11cqkbFWlAX0iTv
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9dce with SMTP id
 af79cd13be357-93ec12ca060mr1167058185a.78.1791836733350; 
 Mon, 12 Oct 2026 13:25:33 -0700 (PDT)
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9dce with SMTP id
 af79cd13be357-93ec12ca060mr1167055385a.78.1791836732899; 
 Mon, 12 Oct 2026 13:25:32 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ae6fb7sm491260966b.84.2026.10.12.13.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:25:32 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:25:07 +0200
Subject: [PATCH v2 5/5] doc: android/avb2: document the root key
 provisioning and lock state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-avb_lock_unlock_b4-v2-5-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfXzq40468mutzH
 dGOnZ0iLMshPaJ/aArmQkpaiFBZKl2N6digLN43SIZAcxwqURd1skUbPORpbACsfNILzIQXl7za
 p4rIaGWfiTUFKA3niqkSHcGYU3wOZcMNI+gZPlUlj/EVxQ8aJq9tYSLbiOsZXStkVdMfrQOqYmR
 V+LqkJLF8QXdP5is9gt4LR/y3acKsHxjJk5r6p7Qu8n4lRgdDGXnBXC+iJrjBdX6hrZwK4ufCky
 GUVjBAOwiV/HT04ta/95K6sLNMs57yIRDpTw7AbTrWsdXpA0dFxMEcxLqB0NeKgfN3opctuEuSp
 SLUiH9H8JMbDutmn6M90jHfY7owMXj3bZbs+pGgIz/Y7/BsUhLqO177ngiGe+bAp3gQWePjh5i1
 J+2AUx1cwZ4631FEL5G3gIVjcGpv3gctG/XOhxEH7hUS3oBlhKP+41ckHdZvPibimfNsYiLdBJR
 nTWkDySuLYlgf3O68HA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX7DCM2LHmOP3F
 1uFGiVryKGm0Pe+i4FT8unvFGRy0Kc4HbNlTQNdl29GBAajt67ABGuLRjPNK+DtqP51VsA8RNIS
 QM5XzS9pB7xHPEqNGYu96JNB2g6i+hg=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd423e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=8x3teu7IPyAgyLZ5nhcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: L3DNIvD7bqKdc0NZOWypeb3TUAaKQjIO
X-Proofpoint-ORIG-GUID: L3DNIvD7bqKdc0NZOWypeb3TUAaKQjIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120081
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
how to derive the SHA-256 digest of the vbmeta signing key with avbtool
and provision it into the TEE persistent value with "avb write_pvalue_hex",
the fail-closed behaviour when it is missing, and the device lock state as
seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
mandatory userdata erase).

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 doc/android/avb2.rst | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index a5147012413..b43b58a07a6 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -74,6 +74,62 @@ Note that device lock state and rollback protection are only enforced when
 backed by OP-TEE (see `AVB using OP-TEE (optional)`_); without it,
 verification is advisory regardless of the root key source.
 
+Provisioning the root key digest in the TEE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+With ``AVB_ROOT_KEY_TEE`` the trusted digest is the SHA-256 of the public key
+in the AVB key format (the 1032-byte blob for a 4096-bit RSA key, the same
+encoding that vbmeta embeds), not of the PEM file. Compute it on the host from
+the private key used to sign vbmeta::
+
+   $ avbtool extract_public_key --key key.pem --output key.avbpubkey
+   $ sha256sum key.avbpubkey
+   7728e30f50bfa5cea165f473175a08803f6a8346642b5aa10913e9d9e6defef6  key.avbpubkey
+
+and store it from the U-Boot shell as the named persistent value, which the
+AVB TA keeps in RPMB-backed secure storage::
+
+   => avb init 0
+   => avb write_pvalue_hex avb.root_pub_digest 7728e30f...defef6
+   => avb read_pvalue_hex avb.root_pub_digest 32
+
+Until the value exists, ``avb verify`` and the Android bootmeth fail with
+"Public keys are not accepted"; a wrong digest is rejected the same way; the
+value persists across reboots. Provisioning is a one-time factory step and
+should happen before the device is locked; see the note above on protecting
+the value from normal-world writes.
+
+Device lock state
+-----------------
+
+The AVB TA stores the device lock state next to the rollback indexes. A
+locked device refuses to boot on any verification error and reports
+``androidboot.verifiedbootstate=green``; an unlocked device boots with
+verification errors tolerated (``orange``) and rollback protection off.
+Changing the state resets all rollback indexes in the TA.
+
+From the U-Boot shell::
+
+   => avb init 0
+   => avb lock
+   => avb unlock
+   => avb is_unlocked
+
+Over fastboot, with ``CONFIG_FASTBOOT_CMD_FLASHING``, using the standard
+Android commands::
+
+   $ fastboot flashing get_unlock_ability    # OKAY 1
+   $ fastboot flashing unlock                # erases userdata and metadata first
+   $ fastboot flashing lock                  # likewise
+   $ fastboot getvar unlocked                # yes / no
+
+As AVB requires, both transitions erase userdata (and metadata) before the
+state changes and are refused if userdata cannot be erased. On a slow
+(emulated) eMMC the erase can take minutes; a TCP client may time out
+meanwhile, the device still completes the operation.
+``get_unlock_ability`` always reports 1: the "OEM unlocking" setting Android
+keeps in the frp partition is not evaluated.
+
 AVB 2.0 U-Boot shell commands
 -----------------------------
 
@@ -93,6 +149,13 @@ different testing purposes::
         <partname> by <offset> using data from <addr>
     avb read_pvalue <name> <bytes> - read a persistent value <name>
     avb write_pvalue <name> <value> - write a persistent value <name>
+    avb read_pvalue_hex <name> <bytes> - read a persistent value <name>
+        and print it as hex
+    avb write_pvalue_hex <name> <hex> - write the bytes given as a hex
+        string to persistent value <name>
+    avb lock - lock the device (verification errors stop the boot);
+        resets all rollback indexes
+    avb unlock - unlock the device; resets all rollback indexes
     avb verify [slot_suffix] - run verification process using hash data
         from vbmeta structure
         [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)
@@ -134,6 +197,12 @@ OP-TEE::
    CONFIG_OPTEE_TA_AVB=y
    CONFIG_SUPPORT_EMMC_RPMB=y
 
+and, to take the root key digest from the TEE and to lock/unlock over
+fastboot::
+
+   CONFIG_AVB_ROOT_KEY_TEE=y
+   CONFIG_FASTBOOT_CMD_FLASHING=y
+
 Then add ``avb verify`` invocation to your android boot sequence of commands,
 e.g.::
 

-- 
2.53.0

