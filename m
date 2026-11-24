Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4A606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K6VXVjOM;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q5LV0osN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NHDg4nyl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9B28605CA;
	Tue, 24 Nov 2026 05:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6_0dLyI3_GQh; Tue, 24 Nov 2026 05:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1213C607DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795499943;
	b=AUrWdNgEIa6FYRZFQb4FFmd0h6Ma574GYgGt5ACiLKwclGOTV98d45ZjdFoF/UBg6cy+
	 GWt0pkxGvSmNq1jZOhA/7DrG1Tp9M3D4sc5k/ASGCdNT8I9FGlJBHnQyit46zES6W0rmJ
	 JnINXTk+t1Ff4m6MjH42FSNIvbvOPPZKI9eo554ib06aSz4FAEXTtDk2H2vR4QUw42ysm
	 zLWOrAqfu0CyjgJrhFpWqdyc9cNYy23LCM2QCwpGJocm3CTsr+GlBQqpA5ZCCIAERYJOW
	 S/qqCRMVel1pc9PSpUkPdtcZVd2+Y5Zjg1kB4oC8qt5jJabr3g8Bq1MBOFiP4m0KQZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795499943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
	b=IDqF+tkUVAxxOPbaIzVX9+jdDH3CTKh7l68kPaXbgQwMlzmi4+E2vpZlAfMttDADf7U5
	 TIBXraTDdwRbZAxM9EhoDg0/7S+7Hb68bY03gJWtaUzHWUaF4ZkRT/9uAUUX4CIzQkeuT
	 jtmN3Ng2B3iqTMa1lrujVotiSyRYrBrtzh+DX2nhyExP7Buwyi1CDT2rGamn+InNH9u+7
	 arOeNx+VwhmYvhik+RJrXt0PhOmQpPN4qI4hvOlcNZTxOp3dkRNE76SjxQcgL0jbTLAnt
	 BVUOlT6a1vBI/Oc39dIpmQ7a9K9WAOl/qVaG0oZCTEkhZbm2gQQt2Sm0IfBIdTNZNfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795499943;
	bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K6VXVjOM0r6MzW6M39FoA15f3dnpOBLb73ou38AibuhyF/sUwvr9vRY8VAnl8LV+4
	 3xQ5unckckY+jIFCESPgY0hdAtkRI3JPqtYk6+XZugv/g7MU+fo6KLEgzuaj4287/8
	 Cfos05Wc5fbA7dHBznr0R3xjgKk8W02eG3RRoIk/9jy5+61yqNDfjWlbM00ncl4KOB
	 cPRYMhtIUh1CuKFZGFoifvLT9UrJXV5Fi+k+A1nlnX0LfdhXxYLsvN7F5vDaTfba/w
	 vSDrbtTG70WqwLuTVYcJP5hvnE/rtJJ/q6lAybYk8IscxS0pVE7VZnOQdZNxKjpZ0a
	 7t+nwCqgqyNPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1213C607DA;
	Tue, 24 Nov 2026 05:59:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2156522B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1328D405CD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1_-G67UwypZ for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 05:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13E08406D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Q5LV0osN; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NHDg4nyl
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13E08406D4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO5lstq2848176
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=; b=Q5LV0osNcYzSKqsY
 U8qIfhD18ir8oTJh1g83G07lO1v49ZXBOHYzdyVP2tyCKUMXPlfMXpL7H1n97Qmg
 xusPyjz8aRZP8LreS9rTfxc0p9Qy8kndRHJyRr0dGol8XxhMzQqXl92qWy9mD7SD
 K0ZtkbAkAQCRYVcGYInIcifMq0kp4ZHXeTHWN5SBMRL+RoEf2daeHsZICfoTHSJq
 +SMMRnOM5/SnNbhjHCj1Uaa6OG3tcIO1zK+JNN1g4kgZHMADQccGfMraoF2qBOrg
 uIxrbgkVGZbnWqv27iccVstLlQqTxj9EzTXXf1peeuyT1XOIvjtbNqspzdcOqt5n
 xVIa4Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rh8118-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so5138151eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795499939; x=1796104739;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
 b=NHDg4nylaJXyb3rxLJ9NKnRbyPNqZ/uurwX+aTsnnhpUEwHBUxiTLZ78/8ky+ZLPZC
 QFzS0x2OY3osJn3ofIvqUEojozSEkeyYsInOPWqwMIDNQvPxJ+eAsFRdPzQopq7nSkiR
 ZwMXdV772yYQFy5R7VkbTM7ldBh4nMr42TqVD61Giv6rC3Rs+Pl3jIgQRWqBbnORJe//
 4fX2gF4hSLcT4OC1znvbwC8hqaJWq59/cJ99pJh4adkSTRmC//FtNhscO5/44PGywcoF
 P5F299uDGxdx0ogRCl+gNR24PKi5WQWvdkWEJWn5R41rhQNw0hq346b/1FLFeTgMZFNk
 +PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795499939; x=1796104739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
 b=00FRdrltnubaf2bAfC7ksOfJbn7cHLapper6tGR42fsGMWVUV5K+tIj7kusmaxos5K
 CljqTTNpmVLZPgy601lHH1QnI8pUcboucUyWSh2M7G8+rnUqSKabXipDp6YlgJIJ0KNC
 QdvsGW03+sPmAe4gZ79SI7/Q9njeVomc+9xqEMwTIplt0bqlm51wTmnEwGOU9H0pexYe
 uaBalGbuxZRlc+oMDaHKIwU6Bt/YNmEtYm+NQPm0RXgPU51OU+AZuKB/pKQJVf3Idkc9
 ISD9JJrMpUJ6LbGMcXUgYHBPX3SUz7hoQbIIV9a8JL+yNu4yeWL+djZ/4Ur85dyH3KkG
 S3rQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEKpR5b5c8PO79kT4RG9LLoET198Qiza9xyUSsxSwJXMB8Hj6TC2HhOFnHDHXsecDsZq4mU4xY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9qIdVqHE2Pk/CcpBnSSLf4F4mf190rBYKbyjIXDvaltV92fnGU
 pr04X9ehGSD5DN/vbWrRv51eCQVg6qQATQ3+RL681KuBVfVGd3Fp7kAm9XyAL03WkBONhXsgLze
 Ja4kqdqx8zDM/qSkk6B8lpyclnk1vfzyWMrJr97pHV+jGP6Z53jHlhXKuEdgsN6P1PCZy+mzCxZ
 YUZj4=
X-Gm-Gg: AZFdTZfS3k6tCGvKBI51u69sE+S1aoNoI0ITmmpxFYD5shC5sVdzUsD7eGe2YDxrkq8
 pktMZc/9pfDPWRSicR9SDWBzKOYF3ehYprJHh7DupCOhAd2xkWdE31uFK8CaBIu//KCnm03ZHHx
 hj+7hRnulpaVKtTTFq9KIXdXuEmWC2kwj7Gkq1p09AtImatZMVlTvc6j3K4PpesAVjfQlPWt05K
 BHdgczQf/KUJ+i4/5RRpIrEyXxtJyuGy4J936PqPnUeIrQCSp6UMPkx65fk96F+fUWCyrm54XoB
 RFYqXJY3osmczhp2j/xESuc3CrXPhLVJEzmqIMbE+v86krv2Q6f2iEVBk0Ne+pWL1mIDYRcUMAo
 vBBd72+k+BVRc3wUhl5wJG7H+ydZ57b6961heP42R/nVTdn/ys7ndu5221MKmqiP/q96Y7UqyX2
 MaMYt/u6pHfLO+joOPF8PtKnb00umjxSovkbaC8Bb47SztNiiU6Rmj2RrMxfaxQ1vix9K3jHSKW
 NA1MQ==
X-Received: by 2002:a05:7300:430a:b0:382:7375:1306 with SMTP id
 5a478bee46e88-3856fc603eemr19681269eec.14.1795499938632; 
 Mon, 23 Nov 2026 21:58:58 -0800 (PST)
X-Received: by 2002:a05:7300:430a:b0:382:7375:1306 with SMTP id
 5a478bee46e88-3856fc603eemr19681248eec.14.1795499938170; 
 Mon, 23 Nov 2026 21:58:58 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm34742351eec.25.2026.11.23.21.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 21:58:57 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:28:38 +0530
Subject: [PATCH v5 4/4] tools: qcom: mkmbn: Add support to create multi-elf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-ipq5210-v5-4-b509d2b05180@oss.qualcomm.com>
References: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
In-Reply-To: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b0527a3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=R4u_GeB_J0YJdhSkb_YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyMiBTYWx0ZWRfXwFwMzOxWKPXV
 2FwakMYbs3DIe1sbTkxV8KNp7rqLrd3UN1nmlr8f2gpQKkN+kJzBuLR3noFVHU51ungkQyBMJnT
 nO5iP2AXdNYBNKhirT/n0wVtwzi7Y/E=
X-Proofpoint-GUID: O62G20DUQaRhzcmhurhI9UpJJWjXg3ie
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyMiBTYWx0ZWRfXyXPNObJmzGLz
 QyB5Fh/C7xsptGcp9D5WZn2598XLsqq5CmZKzY7NnKtQC4BRhH7aOOCNCCqscv+v7/q2OJJVgeT
 HVuM/uRJhadmBlih3Smd5uv5MOxhRTCT4NiR3kF/7UfAE8KaCbOEEeBSk/Y22PID7Mhtx1M9vu8
 0SwTr78NWKnxvUkCyyIM3dyBOG8E167G0ZLmazDKgzPa7KjbPMm57OSc1ZK2a4MOXr3JMIBmyXV
 QG3U5Ty9ioneh+kCR+1Za8so77NETmeNpctTYdhrBafn8+Yl48o/MNQFn0yZUC4n0b3B9m7nBJx
 VztKLAbdYrLJlvGJbooKVlvwrly5MLJ39GgtrfcFWQgLjI6Me5P7tgrrRl3K9OQ9VycJJblSw8+
 JS3sghGwvqiky/e1gI361pEotTIZSsBLqK8cNkm8TkW8Ytz/YukWdsLrA/IQzJ483/CNRGg3/p3
 6P1dJtWk5/DP9FGa99w==
X-Proofpoint-ORIG-GUID: O62G20DUQaRhzcmhurhI9UpJJWjXg3ie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240022
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

Modify the 'bin' argument to take either a single file to convert to MBN,
or a list of files to be combined to create a multi-elf expected by the
boot rom.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index da4d45b600a..7afaa463d87 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -110,14 +110,32 @@ parser.add_argument(
     "-v", dest="verbose", action="store_true", default=False, help="Verbose"
 )
 parser.add_argument(
-    "bin", type=argparse.FileType("rb"), help="Binary to embed (e.g. u-boot.bin)"
+    "bin", nargs = '+', type=argparse.FileType("rb"),
+    help="One or more binaries to embed (e.g. u-boot.bin) or create multi-elf"
 )
 args = parser.parse_args()
 verbose = args.verbose
 
+if (len(args.bin) > 1):		# Create multi-elf
+    try:
+        with open(args.output, "wb") as f:
+            for path in args.bin:
+                with open(path, 'rb') as tmp:
+                    f.write(tmp.read())
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(1)
+
+    sys.exit(0)
+
 elf = Elf()
 
-data: bytes = args.bin.read()
+if args.bin:
+    data: bytes = args.bin[0].read()
+else:
+    print(f"Specify the binary to convert to MBN")
+    sys.exit(1)
+
 
 # dtb is at the end, so find the last match
 dtb_off = 0
@@ -155,7 +173,7 @@ if not mbn:
 if args.load == 0:
     error(
         "Cannot proceed without load address.\n"
-        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+        "Ensure CONFIG_TEXT_BASE is set.\n")
     exit(1)
 
 log(f"Detected board {match.decode('UTF-8')} with load address {args.load:#x}")

-- 
2.34.1

