Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB53ECC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CC6F6078C;
	Tue, 13 Oct 2026 11:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJR_UDWf5plr; Tue, 13 Oct 2026 11:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9CC696068F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791889589;
	b=mZU5nNHk3MJASsMbvb+vnFNZA+k/0v5rL1bhcCH5jh5sn/6K7qP9vL2hYqNiWCvwJ8V6
	 zusAhxmm0cveaK8lVpTvg/pwiNz6B5Ln0QYzu+9EYOA9+UiPeSCBpDHRXo8eVTdFOkY3d
	 q+QJ5H+erAqiXzzC+aekzPUgTdpXAiKR/BPOYQGKo0476JOWCIMC6pUpk/AiKYKB1u6I/
	 D6Xl9GidkNWZyLmfQiKYoNclkROSM953Fg6DR+TDGZJL3xk4DRlQi0o92e958lJJR+PeY
	 fsADVYhv8JR8JA5iZ2yRmyVBSa+vrIlhxZmgsVhA+4Rsc3UXAt9m2+bRIjkq0FRxzFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791889589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XWoM0Gjx6h+PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=;
	b=aOrgGbylPjqPv43orf+S4ktaFUep5aXXdt6jQLjprGNI/95LBEPuuTMIlIGSGtb0q//z
	 QYZMo2kvrQNDO1WTQvqM0kDlFN/fiGMLltziFAgtivhmUFIS46u4Ma8HNjuhqEsSKP87e
	 oKg/C2EedSMEFP954MX3vVKlpAAjxApazB85ryMHrOKkapVHDRNmNyXYDXo6Y+jrmzNR+
	 qiuaTNv4+cbSn0YnwOvFugD1bZtwx3CNF9O4TFVQyRZZ6HPu4FE1z4lt4cUTT3AOytMU4
	 5CS1jozbtvinXfawxjilqanvaCQrVRwbw4bX+mu/3TOd9FC+EdxxYO56XzxRpr17sGw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791889589;
	bh=XWoM0Gjx6h+PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uzMOZw8QMJvQtNySCpdYRD8ygPsutIT4ixHIp/2CLjwTkNRTm7IGIR8iDYyh8NkTq
	 3ZHKLvlPWoIrSAfzLmmY0SVmpj4rn56vHFWVRoSyHLBTepH3YLymmDwzp2BgNodaDy
	 go6JdKoNwHZuN4UNxEQp3UfYbQyXGL/s3UoyvifTw9NqSXIOc8kXC36XSzx8XcYAGx
	 yGZDI1ZvW0cn3RRl4CcVHtsELAszkcZD7nZU5mCA0f0AKSJrCCP92lFTuv6qjRm/f7
	 WZcIKuUVAyGtqERjniAhuZzLNi9lubftlCNa/qyFxOz5GoDudSXMojhP2fGGFSR+f3
	 4m+F6keqAkbDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CC696068F;
	Tue, 13 Oct 2026 11:06:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00C124DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F286880D7B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EE2HAtHbPPMH for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5951180C8F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791889586;
 b=jzblcB0jARwcHheDxBOmDLavVcFvXgR/DzO+RvjCcxlu/aEXymP5jhxu4MqNZ55WTq89
 aON69RA1hAmKTdtWcG9wslUb+aFWLaW9W2AqyudaYPK/4k/o9mImhro7/dOTgNMgJdFKo
 SQemw/IlaHkkJobNKU6AyfxjV+YxqVvaP/YXBT7moqy5MbVn+m5bb2V543hO1QsLXDLrg
 q+j3duD9chO5/tebwU+0FzH2FqWr+/S5lxqq+nUB+yix8klrUMSgURzaEw5COVdbTGvNa
 GIczfwzLjE0+wtAi/al06wB+L7IfYPAuEVFI1bGMKFrAKpZ7sn0OsJ9a54pv6XAJOag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791889586;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=XWoM0Gjx6h+PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=;
 b=XaKnSqnNjwiG2omG1SUMAgZcgQyH40vP94udoG1bq8fP7/a79cGB5ouGv7LAtt6HKmmd
 6uWK6d0nNItvyePBGZpDJM5+l3p43mZdYXLqG6K3dYppZXdXZyRSZKLqmorG0n+zXQQI6
 PbEYRrbcfAOf7LC+uBTdbgRO/1wNy8x6k+0zD96V8rYkcRlh2B78rsUOmWSCO9ALzvXAf
 QFFUrU8uThjTtkcuYOMYAK0KyTyPM8xpYfM7gA6oxe2MIrvaEa+Us+mdWUOjtc9agkyU0
 vEKcCTrFjClvOHlrcFB+h6EntebiENaXSH5a0KAecJ9rHUUB8xhtT+jYvuTwttTU2Hg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=AP6ZoTwe; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="N/BLIdG2"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=AP6ZoTwe; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N/BLIdG2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5951180C8F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D7OWjq015185
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XWoM0Gjx6h+
 PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=; b=AP6ZoTweGerBn34zdIDC8Kwg+Nj
 fgL0EuFgOo3oNKMIpo026lBZ1NbjgF1FvxHuisDu/aXUMI/DDGF2z72DIKlFWKpY
 wiivq3ANcJeg256cDouDCh2ucV5ppRXV1eoa7N1MTRsKK9mBhJTSzUXOvIgXOrc4
 QgJ0hqU0Ms8pRgRbYD1Z62ZR69/jjAO1+yuanLHiiuBeC219X6qeK4vwTTD9P1SG
 L0d7FxprH747zN1Ba3EF9T7CSqxdJXJfd9XiREfUTf8mSwBfUWtHBe8EN2m5jb+s
 hc2vHQ6oV/MAii3q6RemKe2p0v6VMOBpounrGnmhd0XzF8i8Ni9ANuh5cow==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugx18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:06:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so2340616c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791889584; x=1792494384;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XWoM0Gjx6h+PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=;
 b=N/BLIdG2N6qnIu323iwGx0i+59LHxbi8aInCNeGPqijVbMlpgVPZNHQr/hHiBoAHHE
 rDjWcuPWsLOOmmMqCP5L/YC2YVFaH/E+JhFETzTXHB4gw65nqiT2B/RzY/42Szh3l9zK
 LObvvcmmx6R80osFTNBzO4HZ5/j/3FP38MVQsxfEa+YhiB6enuSlQka4i45ezGbOsiBC
 V38Vjf37NX+CsugGXgxRguvbE76d4ke6D9wr/eQ1cdNIJbL0SwCInVLC9/hAtMJC+BVt
 uxif1Ugw9kqGgaQVhR4CizXItsbmt+uF06N4j6wz/H1aZVWj4S7I5ZwuU0IRZyG0zb3r
 zCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889584; x=1792494384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XWoM0Gjx6h+PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=;
 b=dJsmD+Dq7MCkursHo5vEaf/SZm/qoJ7DtVC3p+MsJpO24Stc3AfrgjB/jjhSyza4Bp
 Wm9aAZE0WxbKALHSgi0+KiLM3VwPoDJ21HaCrvAMOcmF/dEJdWgq5Bcx8BFr9TLBspxl
 lu3GbzfXCzPDSBIXVxjI7JG8CaTMgsYu66T2SCAsK6oallqlXgWy9xQUD4jxTY6gKwnR
 qPvRWyEpgdUJ6ihbXpHClDSlzoRHKHdv6xmFsmADq5tWDlVoaZgn7rqe+382f/4iZQ/V
 Nak5KN6xEbeex5ShiAzNDrK+wZXO+f/C5PfZ9Xhs9oErvdeaVsRyOl6TqnU/BW6RdLzI
 Y34g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOywcktZtyr6dYNbq+IdmO5n2dfolFiMQpqgvkdYF3wGaeLumrILa7zkDTQfBZ9C+LweRSJu0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK755gAB40cOUUR6+3Wg+7vbQCYk9gtWpsycpAD5/yuqx6/p6/p
 pzWECiPsbzL6qB7y+vb0Ao1Zr3OxXJkwyjn0BRez35hFH8iBBIebvQYWKT8zYgYGTHbsHzGyKPR
 fEM4hVjbfa3F9hQOPTNi9ONFSLbspgsY0KrGFSoIBIQYJs9015mUcrztcCx59Xg8QjbAp1yc=
X-Gm-Gg: AYBFou1PLq2b9rlRGiG791Cdnv2srV8FBWGoOGgDbehzwJIRXKa65jr3lyrBEbJbvi6
 31ru0DVaLTLgTdlmyMe2j1mxT2oqnG0aHxSYrNtDaOL9CHESIQJFRlnPLH5oNqewSd4+R/FkQAw
 jRb6gZv3qqj3HRRmABopNjJqfJ9ieMu9WU/Mk7L5f/692znG9KmdkPVn+ogJ1c3z9Inx1mHVd9t
 LI+Dpc70eH8zsxQ5bvN4JmRugfna1bq4tYhST7VgUPcjZJt5c5rUgtkpJQ0OrljMkK2fQ2N85t4
 7oLA/nJldFzEDCqWpxsneL6jThqrUQYQO11lBhKRRaTKZD5Avg1QOp43hTSmU2ZhdG8YPjBkDXi
 MoE6FUDuRdOE3lynKrkY56rqpUkMEQt1jusk/VxiP98kQTAs2I6JCwkXSy5E2rOrVqTUlzoq+ju
 LxHLAB1juTzzzjBu9B9w==
X-Received: by 2002:a05:7022:7e08:b0:162:e05:e43f with SMTP id
 a92af1059eb24-16a5f208bf7mr24387821c88.23.1791889584348; 
 Tue, 13 Oct 2026 04:06:24 -0700 (PDT)
X-Received: by 2002:a05:7022:7e08:b0:162:e05:e43f with SMTP id
 a92af1059eb24-16a5f208bf7mr24387769c88.23.1791889583805; 
 Tue, 13 Oct 2026 04:06:23 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1699718c547sm37460642c88.3.2026.10.13.04.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:06:23 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v5 2/3] configs: qualcomm: Add Gunyah exit config fragment
Date: Tue, 13 Oct 2026 16:35:24 +0530
Message-Id: <20261013110525.2465737-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfXyr/d42viBhDn
 MPRVYeX3Y3Aj82sZ0Rn1zMj+V7N09SmOmnhmDsgb1CqPUEOn4J/UWRXAfBYM90+QVkJ+eO+cMkP
 4dDhfd5nxVhISGEum97TqKLC2ZVT3DvpJrKFpTOv1oUBmIEfNiOwOMhS57XMhXc/cVtAnErmGcP
 AriD7NCAwUKpjgOYki9XqGXupvBOOsunVuZ75A2zJ9x0V5kTHHZxahrqX0WrLdl+mpPQm1AuWiT
 A0x99Qf60K5qXRuaWbbSD972GLGt/56q9gNuEA3r8q/22dwsrHH9zExN9yHM1UKaCkmLgu/fnpN
 vMI3dgmgkTwN8ofxSDceVrmufYjkos3mGPDXmhMthajJ9aTzsYEORkhd+mLJtnFClNEtSdy6hXm
 zKcMS/qNF/oQBdcaoIrDplHlHMJ6JMHH+SBNTQ3EC9fFqiHsWdSFis/pMRby+jBH82VAHhWF/vl
 AYHVnEICb+74I72lJSQ==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace10b1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=4FSSibxLwv_P-sZjzEUA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: 7XFKFtMX_E95VUFaS8ZJg5v4MUm84cds
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX2xYzxyEG8RJU
 0e+S1WRjhp/2j2o4S+aeQPgpUGVpgTGvWRYDNY0mIIgUj87Lh0l1g0maiFhcm9VPOv/7fvjzsW9
 IJzpNMUohPDTLrELrkR82oxP1ViUQpI=
X-Proofpoint-GUID: 7XFKFtMX_E95VUFaS8ZJg5v4MUm84cds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130044
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

Add reusable config fragment for exiting Gunyah hypervisor and
switching to EL2 on Dragonwing family platforms.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/exit-gunyah.config | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 board/qualcomm/exit-gunyah.config

diff --git a/board/qualcomm/exit-gunyah.config b/board/qualcomm/exit-gunyah.config
new file mode 100644
index 00000000000..b9b99184960
--- /dev/null
+++ b/board/qualcomm/exit-gunyah.config
@@ -0,0 +1,4 @@
+# Exit Gunyah hypervisor and switch to
+# EL2 for Dragonwing platforms
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT=y
-- 
2.34.1

