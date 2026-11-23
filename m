Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2B606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ewBbhnqX;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=at/tqiBT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KjnSO7tf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F2154064A;
	Mon, 23 Nov 2026 08:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XbgmXnLkR-nv; Mon, 23 Nov 2026 08:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 207D1405F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795423865;
	b=W2lgedcQ/vKBAaBxG0rqYvpXPfWj4wJ0iv5gRubd1X7o+gx/Xey0gqc6tT0ffDz3jNi4
	 byaUWR6di/j8VwakOJnQHKbawzqF0IDbgxaQ8NiywdJ5tnFHwz4/ecsNOt1eGlgW3a8KS
	 e20siN0Ftk+KURa/mejeO7Zq2Q5v6tZyyELwbwDjEQEe+zLqCvmgmx7NDZBqk69dnwa29
	 QwPSyZQUiQxO49Q9p6YB01nZtcZ41GH16huQHbluKQ/lZ9A9S8JHKDBMtyGxdpjGfpK35
	 xvt748HnzpDC7S49ezVmTwflxRlBD8ySi9KYz11+g80eZzvxSJgfZYgQnc9TllTUDHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795423865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N6GYty2Xs0wpAbW+PN13d9fLb3cnPlKMUbV+3LJnpKc=;
	b=bmhn+lHxNPxxZNH/tkELY0UEIsy06jBf8bQJqNPuA23PxEEyk1pJxLcBC4xRJm2SCtJR
	 OxoDHHBD/ekfzBzv3YRTYHP6qA9naJxYzyuj4bviTlHC9g400A9qHMBrMvPYwSTLxnPmV
	 vPxa/JXIUSFeFtex1syKYlJa1YVFhd+/cnTkeRThvUUFt0kSlX3ayQO0Amw7n9vmFMcN0
	 UPQvw2dLc9Lx1h3wRAWvTPB14JrXaSGs0mMg99eQ7g9CLU5KKxAPdh0DVBNAnFWvJcNhl
	 nI81WAy+cH0yz/qihjJP9eXOz2Nprzn72EfkkiceW4KG/J5lu9a/6gyFB15R/P95DrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795423865;
	bh=N6GYty2Xs0wpAbW+PN13d9fLb3cnPlKMUbV+3LJnpKc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ewBbhnqXZPElPf1R2E2BCnNUqK98ExCgwr980rnQEJmaNT3Adhc+cUY/jvIZYO8P0
	 xD6zhzBMsGMGtP2HYbsIvpB2bm/Sfp6zmecZs8HJV+PWO29Sk/Fbvli0KkI8Iuw5AJ
	 P1t2dN+cfU4CYdDvh7Fg2c9iIHkQMnJyopw4EqBf6kntdXF9kEeVJ9CdGGKyqODwMH
	 BL9XGAJLq+A6RNQkmJ6iZHqQFkp3ulxwbbGeI/D0+Gwvm6DAhvzYrVnbsLMD1yb9f5
	 AsvcLIUFiAm3ezVwYgHp//chOZd2bPCYNOHfO9hZChkp+YGJ/CsDEvTNrTBpeoD4VS
	 xMYHkkRhA8Hmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 207D1405F9;
	Mon, 23 Nov 2026 08:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5709422B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4812780D7B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5H69csWRACaT for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E79AD80C35
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=at/tqiBT; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KjnSO7tf
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E79AD80C35
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:51:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN699wQ1011260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=N6GYty2Xs0wpAbW+PN13d9fLb3cnPlKMUbV
 +3LJnpKc=; b=at/tqiBTD4OHEayr47b6RasaSWtfNej5aTnHJ2ZnByf31KFcyZV
 Zkgw2aTMZvs1LCcWzmB38beHqjWq4n84sZLzH1aZRRG8C6qM9LnrFuLW7gy/LhKg
 jyn5bEmFUQ9jAJCBww3wvY2C1NsVviRJWX4+5Bm5CcmM1V+FlER/IlB+QHI7q7YS
 h4QLqwhJ7cnord9YSg7Jd8tkQlgCV/C0cL6+zBvA8SK/yqB0tsTXWFdEhlPHBoDV
 xW+PEjtPEcwah6ng2d6YNa2GOTNvp6xQFCe8pBkrSCDKhEYxteL01BIPQCSd3bvm
 O1tTTIULwukKkProR1LYYntFjFYT/IU8zXg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyh0hu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:50:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4265763eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795423858; x=1796028658;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N6GYty2Xs0wpAbW+PN13d9fLb3cnPlKMUbV+3LJnpKc=;
 b=KjnSO7tfNeFwLvQjnXQP3Kvszks8G41BDjEXM6tXMA9TK8XysdsP7mmTsWV4Vua3z1
 nBX7SYobI9gLAMr7NsQy2uAqfXkFDc+TFikCpQmCQ1V8yDJ1fCFy5Xb5ZZZ9AX8bAJ9n
 z43K7BrFdsnEH5ZXGGmn1e6823tn4/gKpswmF24K1+kz4VxPrsssLjAyVgQljlQ16Bb4
 XJTWPbKGZpCGLWFjMIQzcG+GeHIavpzdqtZzblMUOfph1cuQD+7Dctp64AL+rEz1ja75
 uxucYAViL9mw1NOoa3XFH7BpxwpYCEq0TXjDta7hqeDRZ4X/B0pmfp1VSAPtiS9kW/MX
 ZFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795423858; x=1796028658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N6GYty2Xs0wpAbW+PN13d9fLb3cnPlKMUbV+3LJnpKc=;
 b=fi2Qhkn0o8P2S0+8clUpR5P1/uWN8ni6vXcL4Tvb2IbTf0KTrq/dn/mJVZo0TRSdOl
 0nK2EDGCUhAmwcmxe21bcEu4yszZpnZiWoBUesmSDisgFR7UCkoZiea+7d7dHeZ4PMWw
 kPapV/Rn9u6Q69zSoH60QLAaWTdtx3R+Wf696hDUviYNl7b9DjWqE+Hk6t529VqVsSiu
 wqffOaM2kJ/b5n2N5ti7z+xkJl/no5wsaL06NeXoyzl/vQ24AcxBVBuSS7vAAIqHcH71
 SHhGSa2o8ldWMBF/fa1PLMbqAsphrHOVZ4vcT4VR3mspC5Y7cqYRQ9RPhNfBj3E5dpgy
 coJw==
X-Forwarded-Encrypted: i=1;
 AL+hErHFokk2rJhxQArSJ2G10EhgG4n0uQ5kk4z1KSTntXa2VikNTZ9rx0meC3EkUGHNbydIvQYTaxo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/sWRVU8inGWRGw30GF2EQLWKWMWXmSlsSqm/V85kyenQSA/maQ
 VRE3JmeWv+vq3oQ7tHw5zCubK2I80ArdLESj89bV16pnMPA24KKoy4ldlM6uWS8gQXdEpWYPXOS
 UbsTmZC81nXO6kXSU5KhENKWbRvgaHy44xduYOioV0OfmBxpDfwfhEC4GmrViRJUTims/UDs=
X-Gm-Gg: AZFdTZeCBDhMdHxYVJ67MQwRP0WSxuWLZZ+5onDSLpwYq3TdLSuccGDiyUF/1+9aMbV
 tjVHqroihJg3sZxoMXNeW/iuN2GZwvEDkWXYj1flEEVVpj8vwKh26IpbvWfiIyrk1k6s1oPt5HA
 GPtzx0rar9TwnCD1xBQaLuyBSy4hbEWYRlwFFWTTpeyd+3JH4aM71ueq/cS236YuwkapDCx5obN
 /LuZYrAShqMUViN9RlOjPqvDJyEOhg5z7CdigDIkcZMdaisrXM/lsqLqYjYu96lfX6piTGaT3NG
 Mro+yigfDI1G03QMitsZCC/uhBSYQ8crVTDEhulE9L+vYz2ra6mvDqGlYMOQoOyV7bSmgoimNEp
 kpjHzcQdARJgfP7xvLLsb9rWtMP6JeFz4+JPy8YNkoPmzT2jXi4LBKmzFybn1RFwPa1xvC3hWFH
 COqmedew6uVn7sjnVwnWfJZRjIpx/jScx4muAMi1Cu22BhP2JOWPkbXngpeWngUeUljVg=
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7ab3 with SMTP id
 5a478bee46e88-3860bd88965mr10812157eec.29.1795423858315; 
 Mon, 23 Nov 2026 00:50:58 -0800 (PST)
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7ab3 with SMTP id
 5a478bee46e88-3860bd88965mr10812123eec.29.1795423857797; 
 Mon, 23 Nov 2026 00:50:57 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm36587315eec.21.2026.11.23.00.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:50:57 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1] iommu: support variable-length iommu-map specifiers
Date: Mon, 23 Nov 2026 14:20:50 +0530
Message-Id: <20261123085050.3937034-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NM1AaE6g c=1 sm=1 tr=0 ts=6b03fe73 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WE1Xb73BjVO_zASwZugA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX93lacctg30Tn
 v4GsJK6Z29+WJMfyRPyPDnL0Bih3w/8a8p9Z6+Q8QWYENXTKixh4Ny1+W2QOWGwbeYqtA9bPEeh
 9P99qBXzUS49OBc+nOsSEf1BenZe0n8=
X-Proofpoint-ORIG-GUID: _IYN6vLsqGJqeQZDRUbdYgNiVhO8vbyQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX+s8L1Fz0Rr+z
 n3YsczLvJYDb17mnFXBWYO7MKV/PQDmve1GYJPAowRzwZtReiW7UkOZNIiIWTw7IaVR4M4KIAmI
 dXqpgTAjCrobwxgtrw5PvShXlby8HpkbtHetwro2yLV/dzIDIy+bg9A1m7ZOZrsqvt9K8XFMNnd
 wBt3GuOfmYNdeuDFnJrqrPeXLBtjtzuUs7yXIXrMhuqnIAI4zVvMN38FK/4oNwLnGkD0z4NdwH+
 u6UgkcRHfNiUAaB9Wz4NYZYH4iFVQYIptOvxQJblOMRvGat08ukFGVfcU6r+VT21o03fRsvDcaZ
 OE7XM+BgX3SDwEF9TGfRq8hihmhMWS2SgTADyXpnF1H11UoGM5HslQBmP/CnA5nYLfYhPw8yr85
 Ps5ebBiotNE7fvhOcncAoNqTenkRT4F24VLkTNY7SWwuTPRiY3CEil4J5raix0eCf7oxGGuIJxJ
 cECUdqyuxG7vFYkqXRw==
X-Proofpoint-GUID: _IYN6vLsqGJqeQZDRUbdYgNiVhO8vbyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230035
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

dev_pci_iommu_enable() assumes a fixed iommu-map entry size,
which breaks DTs using IOMMU providers with multi-cell
specifiers.

Determine the entry size from the target IOMMU's
'#iommu-cells' property and validate iommu-map entries while
preserving compatibility with existing DTs.

Based on Linux commit ccb2fd725d41 ("of: Fix of_map_id() to use
the correct number of cells") in drivers/of/base.c.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/iommu/iommu-uclass.c | 94 ++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
index 31b40e5713a..18135c6ebe3 100644
--- a/drivers/iommu/iommu-uclass.c
+++ b/drivers/iommu/iommu-uclass.c
@@ -14,12 +14,44 @@
 #if (CONFIG_IS_ENABLED(OF_CONTROL) && !CONFIG_IS_ENABLED(OF_PLATDATA))
 
 #if CONFIG_IS_ENABLED(PCI)
+/**
+ * iommu_map_is_legacy() - Check for a 1-cell 'iommu-map' on a 2-cell IOMMU
+ *
+ * @map: Contents of the 'iommu-map' property
+ * @count: Length of @map in cells
+ *
+ * Some device trees describe each entry with a single 'iommu-base' cell
+ * even though the IOMMU expects two. Such maps do not follow the binding
+ * but are too common to reject, and can be told apart because every entry
+ * points at the same IOMMU and maps exactly one RID.
+ *
+ * Return: true if @map has to be parsed as 4-cell entries
+ */
+static bool iommu_map_is_legacy(const u32 *map, int count)
+{
+	u32 phandle = map[1];
+	int i;
+
+	if (count % 4)
+		return false;
+
+	for (i = 0; i < count; i += 4) {
+		if (map[i + 1] != phandle || map[i + 3] != 1)
+			return false;
+	}
+
+	return true;
+}
+
 static int dev_pci_iommu_enable(struct udevice *dev)
 {
 	struct udevice *parent = dev->parent;
 	struct udevice *dev_iommu;
+	bool legacy_map = false;
+	ofnode iommu_node;
 	u32 *iommu_map;
-	u32 iommu_map_mask, length, phandle, rid, rid_base;
+	u32 iommu_map_mask, length, phandle, rid, rid_base, iommu_base;
+	u32 cells;
 	int i, count, len, ret;
 
 	while (parent) {
@@ -46,15 +78,61 @@ static int dev_pci_iommu_enable(struct udevice *dev)
 	iommu_map_mask = dev_read_u32_default(parent, "iommu-map-mask", ~0);
 	rid = (dm_pci_get_bdf(dev) >> 8) & iommu_map_mask;
 
-	/* Loop over entries until mapping is found. */
-	for (i = 0; i < count; i += 4) {
+	/*
+	 * An entry is <rid-base, &iommu, iommu-base ..., length>, where
+	 * 'iommu-base' is '#iommu-cells' of the target IOMMU wide, so an
+	 * entry spans 3 + '#iommu-cells' cells.
+	 */
+	i = 0;
+	while (i < count) {
+		if (count - i < 2)
+			goto bad_len;
+
 		rid_base = iommu_map[i];
 		phandle = iommu_map[i + 1];
-		length = iommu_map[i + 3];
 
-		if (rid < rid_base || rid >= rid_base + length)
+		iommu_node = ofnode_get_by_phandle(phandle);
+		if (!ofnode_valid(iommu_node)) {
+			log_err("%s: Bad phandle %u in 'iommu-map' of '%s'\n",
+				__func__, phandle, parent->name);
+			free(iommu_map);
+			return -ENODEV;
+		}
+
+		cells = legacy_map ? 1 :
+			ofnode_read_u32_default(iommu_node, "#iommu-cells", 1);
+		if (cells > OF_MAX_PHANDLE_ARGS) {
+			log_err("%s: Bad '#iommu-cells' on '%s': %u\n",
+				__func__, ofnode_get_name(iommu_node), cells);
+			free(iommu_map);
+			return -EINVAL;
+		}
+
+		if (i == 0 && cells == 2 &&
+		    iommu_map_is_legacy(iommu_map, count)) {
+			log_warning("%s: '%s' has 1-cell 'iommu-map' entries targeting 2-cell '#iommu-cells', treating as 1-cell output\n",
+				    __func__, parent->name);
+			legacy_map = true;
+			cells = 1;
+		}
+
+		if (count - i < 3 + cells)
+			goto bad_len;
+
+		iommu_base = iommu_map[i + 2];
+		i += 3 + cells;
+		length = iommu_map[i - 1];
+
+		if (rid < rid_base || rid - rid_base >= length)
 			continue;
 
+		if (length > 1 && cells > 1) {
+			log_err("%s: '%s' cannot handle %u-ID range with %u-cell output specifier\n",
+				__func__, parent->name, length, cells);
+			free(iommu_map);
+			return -EINVAL;
+		}
+
 		ret = uclass_get_device_by_phandle_id(UCLASS_IOMMU, phandle,
 						      &dev_iommu);
 		if (ret) {
@@ -69,6 +147,12 @@ static int dev_pci_iommu_enable(struct udevice *dev)
 
 	free(iommu_map);
 	return 0;
+
+bad_len:
+	log_err("%s: Truncated 'iommu-map' on '%s': %d cells\n",
+		__func__, parent->name, count);
+	free(iommu_map);
+	return -EINVAL;
 }
 #endif
 
-- 
2.34.1

