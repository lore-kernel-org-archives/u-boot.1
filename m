Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA902C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C5B78132F;
	Fri, 25 Sep 2026 14:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3P-8gs7C4tNo; Fri, 25 Sep 2026 14:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A345E81342
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346405;
	b=W6/ccfp1jRyXBwBAZsMNNyqaD5175+snVVE2Sm/bE1lQNSSw3H3c7T1kYW/Zy5sbqB55
	 dmCYB1FUI/RDIXdZdJRAqvKKkByNtpgrSfcPYZXWDDfMLRAgldtntkMkNEgORwbaBu8QD
	 wT+4XjpzUAn6DRPjNlFLDNjfLJf9YYbJsDAhH2DSFDS51oDX7u8Z1xP5ordcrPRbSOOtB
	 w9AJ8gVe16v2PReQN9DYnis+KzetxTdB8Itd+lHdZ92erC7uIM1FwHGEP5BwZJz02kqvV
	 TahDWo7wHNd4jA08D/hgx/7wTDIyyt8pDyyZUNK3qNVPBGSOQf9x3UJltP32uR2B/OQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DJTBi7FYMjQ5TUiaCJn91SPSYlfZSFgs6NtJ8p0mgRM=;
	b=iHYYZKGjStASA+WPtGR0A4Lzj2nfvoBgpYTThXjt0ogcMqyFgIazN7kTSxA5Yk95qaTe
	 GnKbBUNLmiSmouNIyi3a2QI3x7weCjQPrlkipiYh3F+QIoOsu3XMoOBaE+AfmvRrvSvyc
	 PHB7GIabyyGTBeM+ivIr6azbpt28x6gBO/Ie/J2bDX+mv2ov6LbuIWRM2ELNy2xFGkyqw
	 5U7heQK7s7/pUA0wvYRpyfP5C3bbBYxtKe9UPkt9jM2MGAP8BezaBWUgJaKu9So4F9mFx
	 CgCaYh9mUeXTvc1UwzOtXil0QMtS0/FFe6QIWESBa9WqWtCRpWw+5DKENKk581xlw6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346405;
	bh=DJTBi7FYMjQ5TUiaCJn91SPSYlfZSFgs6NtJ8p0mgRM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oMu5uT6JweKtlEfIvBoCw09lSbb1+8mehdTtiWRCczL6IxGf4L9s0zOIsx77mYrQ9
	 AuF8ACQfLOlSri6IxagHMCVVTOQTI8HFSErVEd/89io6ZhM1qYomRmaBOSaEMmbq5D
	 r2bw02Ma0pnTYAuPkN9GblWBuXoOrYPZXq1nxTuO8g1hjIuARjknMFueMaCdpzXqMe
	 XZnxBnt9HkNlzLHQqgIp4W0+LCEgxPYzy53B4kq41km0ykJaxUQS604jP5Ao8vz8sW
	 p3K+cJoum8eRLfwiNa/7LokFa7jkOYwQa4Sc+2Y/30vMzYPfIlrJfjVIGNO97xYlmG
	 UmNVqAx3+zFbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A345E81342;
	Fri, 25 Sep 2026 14:26:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BCDC35A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81BF540180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bjX1pwaLr8Hz for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:38:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C23D540042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343499;
 b=W1mZW2etByelvPj6y5koQLl5krAUbpX7lzVQisAbHJuaqKCOFOXLekIXGpn68INNfLxd
 wUrA8jlaeiAKkvZ/UE++d5mfmHkVklyOYNsB04BMNl2akHTyq7BubI0DfV3tMq9hJ1PYf
 jCVmOP9K7uGyWX6eEbROW/m6LMsOxqRv9ZN4d2PpcHenARYj+jy3WUXAmtGVynU4jR8j+
 qSd9/hx5U6yIoumFPICMV7wpCwW/Rcm02k65ju3bCl+awDJCt/TKlvE6Lm56mgF2LJizS
 5tB3x41T2MWIEaxKTGtSbgrrj5YxIj3JIUFUOP1uk+YOhNgUCpCwXQKVwuTcJYkzErQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343499;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=DJTBi7FYMjQ5TUiaCJn91SPSYlfZSFgs6NtJ8p0mgRM=;
 b=dyVM/Z4Mmfd/I1Wll15GpEmIfw0oerx4laRkci2o/sO5YzZM2egQt/ATKSRkyY+xQOOq
 SAWAEkv80SN0XYS19M7QiJqGNFDt+rxKRJrA5a2KVGSge+D73nT5jXqYXdFcW/YKk5OYr
 rIVbxp14AIC8LwjozFKb8R8wL1npa9rOOFYkV5ywdBwqq/rOtWVanCvyw37xZNWvVFMb3
 y5pvCnq8TxpxbE+EukAogriUxeyOsG3FnwK3JHMRG2oz+SUjNQPSLa3lG3OI7fDI/x6kw
 0goq4noCf+PF5tr8bKJEzZFNBQScptC60/nGgfTEsM0Z6jlaJ8uxCXTYl5ArRNPqPFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=FXyoTj3b; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eFk0ZQLY; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FXyoTj3b; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eFk0ZQLY
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C23D540042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:19 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDBIuf3532401
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DJTBi7FYMjQ
 5TUiaCJn91SPSYlfZSFgs6NtJ8p0mgRM=; b=FXyoTj3bNeqea064W91SAucs/fS
 9l0k8GmVblotm0Qt/DN12XZLr8J8bvnmDikdYcqrxrgVzB+XJA8gxUa3ZUKWiVB/
 Q78pSK8DhD6FuzUKoNJwQY6Rbu7DrNGonEAYcLLZbQcgVhVTO9ZWjTOnWRNv6LGh
 yA4lZk37vCVuIdPhJM94Hxm9Yoe3G5PVWFoZCY0ABHj58oGaRJlstkHQxQz5oLHN
 m1R+nFkkgPeM/9zSLhS25gjoiHD28tcv8JRd12FdpXq4p0Ciir4cJgLZBBMAHu4P
 05mK1xT/32hGYsP+veYwfONHxhyE+LSPQ/+zDDUZfJptanf5H6/8UtBOUSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kbch8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:38:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30f1b904861so1450291eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790343498; x=1790948298;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DJTBi7FYMjQ5TUiaCJn91SPSYlfZSFgs6NtJ8p0mgRM=;
 b=eFk0ZQLYi+qYdXbxRx7qRcy1kCGw2nXzkJ8iNHGxkMQdVnKHodxc/seYhhhxaoclU7
 jB01MOyeo2lZ+aIzMdZLFGzLQ1j1ECqj6Q1lVZbIIJ/YjRe1hl4o0EUAn+QdKDR3Cc9z
 8zGA++v6HSz2bjm1K+7QCgBFKE8NspnFTkI3ASgnT6s0TYvacHwxgN/uJiSUwjpuyDnf
 T83MnkF/OD+ImuXzofIAfR1+Na0GOKE8xvmp+gjjt/XXQ56wrVOIwmpPJgurhQ1bxWEh
 n/UKI/9bS/RR8dvHKNokNmZy9P4IYpnI6OuGtIlAWbOuWclIq6NwVzZ/gUXQeejARKCM
 DG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343498; x=1790948298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DJTBi7FYMjQ5TUiaCJn91SPSYlfZSFgs6NtJ8p0mgRM=;
 b=JmhjHfllNV6Fye8VoG7qh1R10AG+5qDPD7Hktv6u5d4Ejs3jgKvx1mt+o1rl/3Vj7G
 /GAj12kyxcx9TCOlRcSseClInQBf3aWp2BIK4PG45AULeNGUWUxnEyKaD63klNkrUMSL
 OgAuuBXbDhRooPUday/ileDLmRzsyYSppay7L6M99SwCOlFFzPBadAw39lxNKWb8e343
 cODTNPx1g4CLUXFsxdUXyj5Nk33ds8xI8b3tFZPA7RVf5d9WNc9wknSouPhaDlaYCU70
 zFlFwDqWrEm+ggGX1nXy9RX/cssQQMKMoSdmQ917goXMkB2a+049SUEke0YLMmRnB8ie
 m21g==
X-Forwarded-Encrypted: i=1;
 AKwUvBymN1iQIJNJhsfVG96i4/8jAxYXL8bCiH5wOGJGC+4QcIhD8DRcPBtPdDsuFT4UGU1OI7TZp6o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lN+mlI9nj3qQVxAHXDqijjrTHW3RMxMszIMEfKSKt7pa9bI4Rr
 y8uq3TQfDokii/29I4bOcqL+XQgE1nkbhKWtQeGPoYnyH+FumjdAj1hQGg0bFOYWLsMYkxyZj6s
 6pqgZ/opNsGeuKX3AwBFViK4QT44ltf6C8fom8E0LLL3JMY9SwmmKbhovJ1t5AiKSJMjvgT7vjm
 HeKkU=
X-Gm-Gg: AYBFou2ELVTVellbWwQkS7oavE3owetWRjmiv9BzxcyoKdR+5HC0wLHxid4NXyHX1mr
 onCYrNWl0JNNULNbRb2OmqK4FO1EP3CzzdMCqNGgBhAXuF5XfBwITxAq0BRCueE+/UXBO/Krz0G
 QX51elfYkDJMdYglPBPNv1ygleToSPQqmXBqiPqdG17NOhW/IgdUiQNVSbBS523Vjdv+IcFbxvz
 PDpUaaCQamb4lhXJLH0V7QdYDL84KG73mf2RUw51vpL9o5tpAGQZ6Y6P9SRcGM4x/V9kNAm0YmC
 rY3JdRtXHj755+Eiw8yeQwpTLlgZzACBVzdOF8/p7EpZ5TQDkuaY3ULFGoRCYpqMnWLqEBecRRj
 BMkUKqEgRgHoYLNrEqohRlEg803uQ61z9PF9zRTT3oqDt3b8=
X-Received: by 2002:a05:701b:4292:20b0:143:298d:c1eb with SMTP id
 a92af1059eb24-146d096b191mr247692c88.43.1790343497745; 
 Fri, 25 Sep 2026 06:38:17 -0700 (PDT)
X-Received: by 2002:a05:701b:4292:20b0:143:298d:c1eb with SMTP id
 a92af1059eb24-146d096b191mr247655c88.43.1790343497135; 
 Fri, 25 Sep 2026 06:38:17 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145adbcd1bcsm7706290c88.14.2026.09.25.06.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:38:16 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 08/12] misc: qcom_geni: load firmware from declared storage
Date: Fri, 25 Sep 2026 06:38:02 -0700
Message-Id: <20260925133806.1403713-9-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
References: <20260925133806.1403713-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab6794a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=HP6otEFghPAS_JqAjQUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: HmaG4OOyBHUmsnSQTAmV4klSNk2LEsOm
X-Proofpoint-ORIG-GUID: HmaG4OOyBHUmsnSQTAmV4klSNk2LEsOm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX8ramTbkykjpp
 rzI8AKS68dxkYV3EOjhcmHzZ7zdcDa2KNjy9tbFnONMSDxxoHnIlNBBMQcG2X0ogYDb7ZK9Bkxv
 ADY7yYfLnBRJK5ln3vp8JscNTaufGdH8OcgmCdSn6GrSe36KFU5P363aZ91rHht7Z1lc1bBvfgZ
 KJqz0jZhxZlMWJNCEpIYd1i1mG8zHGF6w7zyEgqISJCdC1bf/01rWCokeMsJuS/5k9ZtWbxteu2
 MrKo1ZctvKkpVHB4hpN0y7MCaBQ3loWf5YYg6G6K7LWJzroJwQaEPdqV9fMNTu3og7Be6i1h8K8
 pJ1JLj8dyuFpg+yNfn8KkYrh533ETwTpOFUV3f1mES8SLjf8POmNzeXcI+uosa7khcFuEjWr7ZJ
 q+srouy9G7BZngQ4lYHKNFws17XZ16QK4OgS0X1eMS93xrQeVHrMJj1GqtgZfG3oUqd3kw2G/Rv
 CVXoOz4mJhLb/d5mLPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX+oavMCFOcKAB
 jOnxEkKSDePivCQFP4OvChpS16bjbJ7Cw6+wxNb4qkh9mfXSM9bk/EvMWXlSB+EUqNcGyeZn6Av
 CMRQetzHKj5boIsYoqmmM9ulqfmr6iQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:30 +0000
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

Obtain QUP firmware storage from the wrapper DT node,
initialize the selected MMC device, and load the QUPFW GPT
partition before probing serial-engine children. Enable
wrapper clocks before register access and release dynamic
firmware after all consumers have loaded it.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 98 ++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index f3133f85885..f77afd5bb6f 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "GENI-SE: " fmt
 
 #include <blk.h>
+#include <clk.h>
 #include <part.h>
 #include <dm/device.h>
 #include <dm/read.h>
@@ -17,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <mmc.h>
 #include <misc.h>
 #include <linux/printk.h>
 #include <soc/qcom/geni-se.h>
@@ -34,6 +36,7 @@ struct qup_se_rsc {
 };
 
 struct geni_se_plat {
+	struct clk_bulk clks;
 	bool need_firmware_load;
 	bool is_mini_core;
 };
@@ -446,14 +449,30 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
  * We need to determine if firmware loading is necessary. Best way to do that is to check the FW
  * revision of each QUP and see if it has already been loaded.
  */
-static int geni_se_of_to_plat(struct udevice *dev)
+static int geni_se_probe(struct udevice *dev)
 {
 	ofnode child;
 	struct resource res;
 	u32 proto;
+	int ret;
 	struct geni_se_plat *plat = dev_get_plat(dev);
 
+	/* Enable the wrapper clocks before accessing serial-engine registers. */
+	ret = clk_get_bulk(dev, &plat->clks);
+	if (ret) {
+		dev_err(dev, "failed to get wrapper clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&plat->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable wrapper clocks: %d\n", ret);
+		clk_release_bulk(&plat->clks);
+		return ret;
+	}
+
 	plat->need_firmware_load = false;
+	plat->is_mini_core = false;
 
 	dev_for_each_subnode(child, dev) {
 		if (!ofnode_is_enabled(child))
@@ -476,32 +495,63 @@ static int geni_se_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int geni_se_remove(struct udevice *dev)
+{
+	struct geni_se_plat *plat = dev_get_plat(dev);
+
+	return clk_release_bulk(&plat->clks);
+}
+
 #define QUPFW_PART_TYPE_GUID "21d1219f-2ed1-4ab4-930a-41a16ae75f7f"
 
-static int find_qupfw_part(struct udevice **blk_dev, struct disk_partition *part_info)
+static int find_qupfw_part(struct udevice *blk_dev,
+			   struct disk_partition *part_info)
 {
 	struct blk_desc *desc;
 	int ret, partnum;
 
-	uclass_foreach_dev_probe(UCLASS_BLK, *blk_dev) {
-		if (device_get_uclass_id(*blk_dev) != UCLASS_BLK)
-			continue;
+	desc = dev_get_uclass_plat(blk_dev);
+	if (!desc)
+		return -ENODEV;
 
-		desc = dev_get_uclass_plat(*blk_dev);
-		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
-			continue;
-		for (partnum = 1;; partnum++) {
-			ret = part_get_info(desc, partnum, part_info);
-			if (ret)
-				break;
-			if (!strcmp(part_info->type_guid, QUPFW_PART_TYPE_GUID))
-				return 0;
-		}
+	part_init(desc);
+	if (desc->part_type == PART_TYPE_UNKNOWN)
+		return -ENOENT;
+
+	for (partnum = 1;; partnum++) {
+		ret = part_get_info(desc, partnum, part_info);
+		if (ret)
+			break;
+		if (!strcmp(part_info->type_guid, QUPFW_PART_TYPE_GUID))
+			return 0;
 	}
 
 	return -ENOENT;
 }
 
+static int get_qupfw_blkdev(struct udevice *geni_wrapper,
+			    struct udevice **blk_dev)
+{
+	struct udevice *mmc_dev;
+	struct mmc *mmc;
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_MMC, geni_wrapper,
+					   "u-boot,qupfw-storage", &mmc_dev);
+	if (ret)
+		return ret;
+
+	mmc = mmc_get_mmc_dev(mmc_dev);
+	if (!mmc)
+		return -ENODEV;
+
+	ret = mmc_init(mmc);
+	if (ret)
+		return ret;
+
+	return blk_get_from_parent(mmc_dev, blk_dev);
+}
+
 static int probe_children_load_firmware(struct udevice *dev)
 {
 	struct geni_se_plat *plat;
@@ -558,6 +608,7 @@ static int qcom_geni_fw_initialise(void)
 	void *fw_buf;
 	size_t fw_size = MAX_FW_BUF_SIZE;
 	struct geni_se_plat *plat;
+	bool is_mini_core;
 
 	/* Find the first GENI SE wrapper that needs fw loading */
 	for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
@@ -575,12 +626,19 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
-	if (plat->is_mini_core) {
+	is_mini_core = plat->is_mini_core;
+	if (is_mini_core) {
 		fw_buf = qup_mini_cores;
 		goto mini_core;
 	}
 
-	ret = find_qupfw_part(&blk_dev, &part_info);
+	ret = get_qupfw_blkdev(geni_wrapper, &blk_dev);
+	if (ret) {
+		pr_err("QUP firmware storage device not found: %d\n", ret);
+		return 0;
+	}
+
+	ret = find_qupfw_part(blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
 		return 0;
@@ -623,6 +681,9 @@ mini_core:
 		}
 	}
 
+	if (!is_mini_core)
+		free(fw_buf);
+
 	return 0;
 }
 
@@ -637,7 +698,8 @@ U_BOOT_DRIVER(geni_se_qup) = {
 	.name = "geni-se-qup",
 	.id = UCLASS_MISC,
 	.of_match = geni_ids,
-	.of_to_plat = geni_se_of_to_plat,
+	.probe = geni_se_probe,
+	.remove = geni_se_remove,
 	.plat_auto = sizeof(struct geni_se_plat),
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
-- 
2.34.1

