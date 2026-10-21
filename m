Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC847606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JfmsychV;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R15rlCMt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4/acDNI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAC4681155;
	Wed, 21 Oct 2026 16:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wo87rSRl3qa0; Wed, 21 Oct 2026 16:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02F6381164
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599036;
	b=EnvcGsVVfLMRJ7RCUtS23pXPKdPL8V12NaeG5r+e9XMfNcwc9FATi6/9+k4WpYOwkhhJ
	 MHr9+qyY6pBL3bOFE8Dj7uzv9Et5hAcCBx5XOK+3DUVUhIcAytfiiEXl+DHoerUgftZoW
	 KfFW3f7A9OWQe6s+ABLJ4AhuAVplxmixu4wePLKcsuw60m4WYiYGaTHbqe1A8OCHs5nD4
	 jSIyH9Z1fgKCT0EweHwD9tkTwnVgXaqvZsiAFHr61c03I8YFVjaufTKaA+cXtbdq0uGNz
	 psqhr7ZjTLG7KirZdLjPaQvEb2HLB+2VC8W2C3KHw72ECGkcSWrDha/Wr4LMeI4xUAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RAGavN6aoZb2WXpdnxKL0iIPYitph9WuqWROIacj5gU=;
	b=HFmRAPBNENYvxJ6bjnjMCq7VMdi1Uw9pnCjDTvyKW8/SH8JdB/E19SKfSxnjf7FP047H
	 13qhY38k2nNUSI57i5yclMH5cISu/Kr+fEwa2IStwgRCaKK/BS69IWPhHAXLLbd64RzqG
	 WaJmmukJcXtCRYsxne4C6VTQhiXWJ8EbL4eMb0HjiW3lEPeg+K5eij89+3hc0TML3YWvG
	 BeJYvtfB/VoKacOCR8+D/y3iMN1LAd9fmUzQGd387vDAwSuts3TPZ+L0B/mY8xFXtwVJN
	 ckLYRLLJtVOiOpCrmFLcG4PhI83LJ+4J+yK7kS0JYlpJIUl8jPLuC7hXXnwaDrTBiOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R15rlCMt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Z4/acDNI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599036;
	bh=RAGavN6aoZb2WXpdnxKL0iIPYitph9WuqWROIacj5gU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JfmsychVaZF0EHUA4iAyjEkfsfSGGND7lwd9B9t91vJQJavTvPcZAd/ZFC12X69Fw
	 lcjeKga84RFKi75yben+5Mg2ACo69niOV1Hb9RpoXQoFgakhXs0wc1CAuQeMs1wv86
	 H0AFJB6wxu75tWLL/3S6BePDC/3czPrnMrR9f8+jDvL3uG9ccfkrQKDrgFj849uKTJ
	 VviUaWSGZ7MnxGoLxPzh/sl/nqRyptGv5yAsPibUi8NB+o99LzEQ4ABMVrznm/AiPH
	 Xf6o5Wdyy4n3Ht6W1zgQ1AOFdjCaAonlTbVvlQ+en2w0tTe7JvgyIUN8HldDBVFYEP
	 HI4PDrLnjt5tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02F6381164;
	Wed, 21 Oct 2026 16:10:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3B8D1184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A971081164
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6By7CiZsC4vx for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEE6581155
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599034;
 b=Xr3okgZSVs8d/43pSycaGgrkF8Tf1VbCwCcZlqlJIWUWBdNy9ES7tPcPlPXAelXU4ZAz
 1uykngxras0qFBoyXYU+60fCYi2JlfEIExxgSgn+vlAuWHfba5Jsc4wAQEc4aCCZR6Vpt
 5JJiTBiC00HZNrqAgxK7o+CKmCOpxUu+ZQ0z8VyF5mIKLsKHNe8vhxX0M3YM3JbCYYqlI
 C/LW3hwihVvSEMiZgHRvcMCNbdFsAZs3ppSc6c1NzkXQlDX9bM5ov0cl+p3SG0754F0A4
 9Ri3fboxcaG78QvhLyx6ilDvq8HQIWjw1oMJkggjxmFxyZBtj+fH3zenaZfAm2oWCYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599034;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=RAGavN6aoZb2WXpdnxKL0iIPYitph9WuqWROIacj5gU=;
 b=MwOq03x56FBF5n5a/PVoz5/FNpVEdmbJ1Xonm8nZ8kua8TD2fB+1J9AcaCfiUmYH5SgH
 OMcZq+5lLWM/Caki1Th48MBiQjDFGNJesI9tbzrBKtzbDltkKjnt3JR2XPlDME//GKafZ
 CiN1vaULzMhCGyhGJWnqzJQ40ixPX0vUpqnSQ5o2aYweXDLy07iMdzX6pgKGjoEBS1hED
 Q7W7H37pokbd8KNsitS6d/DtCR9EMV1Mpc2p6MgUazyGv1jt8/txq2CH4saO1sHDux8gd
 ClRdnloykz80ZnuzHWizyWN7elryIrZf+JRTRFH+IxGt0qD3Xu+tI5uzFzj36QDfj8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=R15rlCMt; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Z4/acDNI"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=R15rlCMt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z4/acDNI
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DEE6581155
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:33 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTwGW4158360
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RAGavN6aoZb
 2WXpdnxKL0iIPYitph9WuqWROIacj5gU=; b=R15rlCMt9yZGFS1aCtXcUDF4pxt
 n13F7PQJmpu9vOrincpKAeJgOngGtGBY8dDQ7SCM1GzO5u3aIY3O1yJZsnFko3uk
 1g5ROWLgEeMYp3AOWmgl3tPr68ckPmW6njDfmGtiT5md4X10ChB1WZQ5aVwH8X6G
 eWKu9ElvVVjeOd6MCFZEVIDG1x6iAtOY9EQGZgwh9fuLxEp24yfXjcMsHOa8vOGy
 9idcWKln5025OEoBoCsDMzav4Vq12Xeb1eHwUUHlVnHUiUW8o8Z2u+x8GysAf/OW
 pRh6pnHOqXXLQ1q4OR+aRNFhLwxYThIrfO51KKlTzsI8Cf732lLmBAHkhEA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q8ryd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1540837eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599030; x=1793203830;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RAGavN6aoZb2WXpdnxKL0iIPYitph9WuqWROIacj5gU=;
 b=Z4/acDNImavVpFPkwcLb3NQD24LHPQ56UpaPc48EGTLZB6RwIy/uX4zEEN0yUQg/gb
 y1ZiflEXWpmIUbpYYi8vcdQaT99fsrNDvMHlGukPVbcS6PC6Y6TP9xSTxfOpUtk+5H08
 g6hcLvJCdw6S5nquoy+8akFS37bfbV/Ers2aSsEoaF0d+ltuH1W9XeF1MZeR6KaP60Cg
 do13o7cBqywqPTEnirVYIptNhVDKVJ4bdBRvgNUDwitmahHzFqZ/n8YZk6STsj0UuSS7
 IBhFoJIyo6cmvSXmvF2YMVV2tcf2VIz0T4meLj8ReJyY/J0lN5hXuoWurxwKo048dznK
 iTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599030; x=1793203830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RAGavN6aoZb2WXpdnxKL0iIPYitph9WuqWROIacj5gU=;
 b=Do4UolT4QgSrp3LzvWWzXhONunGqsU72uO0OFpl8Pn0fttjDTmOhZ3J4i0JkncZVJ7
 toHtXINKclYPuhciKG9r+L23/NQzbFDz6rJfNUxSkPJBS5ox3AiMmQbfDsIx7K0End5l
 brpEIG+8hEseknAHhPYCguWZhR5vD7LMSjGmO6l11pc1+oj9lUXlF4Ol4tkRyK+s9ppy
 SCssEki3PyRNCHqirMgP83AMgEMp4ER7uYNzlHYZmI4pFJA0IqDhXS4uw4dU2kRXD7HJ
 Yr0zgMNBEMLTkup217nODBEBqP5erj2R8YTTEUsTI7cSnvMndCsJNDIyYgafwCag/hG+
 pqSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxgIlMLJYZ7AuXIJhR6t+CWc150BLgM/8n/07rTG9musNFubI/0RjIjhF9e45MxH4fkuVN6tE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKmbTtBDXGJEoZhW/Bz2Mu4g1DQKLLZ2Zs0ZlqsHvQD5Mo5S+mp
 ypbQUTH2OFtmn2uBxzNzNYSkQbtcE1YDg3Ae1qTSs9jLtUh7Kt3+KP2WyBUDcRKjTreYM7OxUO3
 Uh1RJJsW+UjlicdifZDGDrXJkZSZixyBJ+SqFPXbBOkicZIfGHKHdi1tHQu/MNoXRdNnZzls=
X-Gm-Gg: AYBFou0zLJ93fcIREXWG4bQDslhin8z1GyeT0M8aHirBCDGFQnnq1GTMq4asfBSvQMe
 7+xJ6WhVFNSIdeMalsWydKRz56CRyEhEFhMv88rt8YcIgbLsQ3XoNWXLk/xm7V7XxxwtcBkM9lj
 26U2SFwsudJTGnX0weUQ4hT7Oqbdh/TpY7k/MF7qs07tNMpERmqrJNGNKWhf1GLIpgjA/iTui1W
 vKLqctCDYcMekKZ1CAsOGUdmZZad6k5nMargdlqIuBZY7J3Gk+BAypPrH4LYLGv54m2uXdUgN7+
 74uZTFsdIa/Ak1qJDNzytCD5IQNpBttxm2/QUvfHkw7AzID/55cq0fZtbNSJMKmI5Dvq5tsPUab
 2gvYJ2kvyG9A5yHiXkedDf8DuicWpMhrT20Xi+Q15QXMui/Y6Qxd3uZjlkNvTS6Q4k4DhejMe5a
 QuqV4o+/G1hmH6jVC9C+o=
X-Received: by 2002:a05:7300:33a7:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-3674e04eb32mr3348501eec.37.1792599030178; 
 Wed, 21 Oct 2026 09:10:30 -0700 (PDT)
X-Received: by 2002:a05:7300:33a7:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-3674e04eb32mr3348471eec.37.1792599029663; 
 Wed, 21 Oct 2026 09:10:29 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:28 -0700 (PDT)
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
Subject: [PATCH v4 09/12] configs: add shikra defconfig for IQS board
Date: Wed, 21 Oct 2026 21:39:13 +0530
Message-Id: <20261021160916.3894471-10-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX9Hmr4x2yU7Rk
 5gz3lzmHVLr1Zyw5RbdTG/9ttfyrCStwYm9Jg0shbGlwMYRGuEQR7oYkBGscT9Ds3lfo3nwn+th
 S6s31hgl1u9tmAX40pJEo+K90zsMw+Q=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad8e3f7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=tVlL3TDT3zpwX-DPz6cA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: UQTkyMqZkrxT9rzP8a8MLW-gCvl7yFwU
X-Proofpoint-ORIG-GUID: UQTkyMqZkrxT9rzP8a8MLW-gCvl7yFwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX0xxaZaNjff80
 gYA9fdM13Mq76UNMXjaHTg3Zg10/++fk9+b4uMuqhQ2w+0YGcqji5A2BTrTkL3D+JTuYG6zJErm
 TPM4wIT/QPZ11uwfdTekT3SyxXtksmfWxb7AUE8moPAUAw1xI+1qFXW+/xZ0jzhsDDhB/jqOlZw
 b+To7zqq8P+4q4VkG2YGML1R3qM3I5jr3r0cqEEqFOlzxINO+0+MUmQ2WTfImyON0UXHZ9gf200
 fQC70T9qgPgXu1JlffnX3JLs8ZaZnoWbT2673J4K74ucaMz0Uw0hzdzKlU+gHP9JCGJPsmDcnub
 EP33Rs/xXul+l8BoagM2LV+50wc7W4xbiYyL6uTgBJHrf1TIMB+aiz/DYthtiVFeSVSGioMwzY5
 IoX6ZyBQRfrGwNtHm7PapGQBVK8TsNj1Hv7xbLiHSuoQsmU0QNeKLaJ2XQipYkq0UTiP8jGpNak
 CaEqYSDKRBn6lBBUKCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210064
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

Introduce a defconfig for Shikra IQS board.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_shikra_iqs_defconfig | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 configs/qcom_shikra_iqs_defconfig

diff --git a/configs/qcom_shikra_iqs_defconfig b/configs/qcom_shikra_iqs_defconfig
new file mode 100644
index 00000000000..3d602dc1f77
--- /dev/null
+++ b/configs/qcom_shikra_iqs_defconfig
@@ -0,0 +1,31 @@
+# Configuration for building U-Boot in Shikra IQS EVK
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/shikra-iqs-evk"
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x9f400000
+CONFIG_QCOM_GENERATE_MBN=y
+
+CONFIG_FASTBOOT_BUF_ADDR=0xc5000000
+
+# Shikra has eMMC only, not UFS/SCSI - override qcom_defconfig settings
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
+
+# CONFIG_SCSI is not set
+
+# Environment stored in eMMC logfs partition
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_USE_SW_PARTITION=y
+CONFIG_ENV_MMC_SW_PARTITION="logfs"
+CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SIZE=0x4000
+
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_OPTEE_LIB=y
-- 
2.34.1

