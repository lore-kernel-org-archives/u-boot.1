Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD6606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jksaRkrG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Od7B7qRG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cj/d4iN/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 311FD40430;
	Wed,  4 Nov 2026 16:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyCRY2OwPA15; Wed,  4 Nov 2026 16:34:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E08640312
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810077;
	b=lPgTGCeJ7pQen1Jx9OhxZfq4Efck97KzOYmsmKiKcc0RzdKlMIw0TdpkIVvNASZ1Bln7
	 UeVaRL2nHY2jwRmgtSqGk2/XQ15zf2Mfy1wTXbWiMO+Y7msOj7baoZ5J5N7U1XMXJzj1z
	 xkYVuxr5lzyH+HI83jlvRrAa17JubwlIQdHMUXrZDFBBAqaP2eqktFUNMZ3Gzvl1nKH1V
	 SnAIbZIBR5CEspyTkg8uBmr/2oL//+ti+KJieR3d2IEdOZIL6xo0yenUwzoy74QKojE4L
	 fV2UsLl0J2mwxFN7clDwX37JQh5tZ9tmCM7DwJ/2LbvWZLr+ZPnnLEFJpROEnQ0aJog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SBBYoODnzugy5VYuZjRbv4j8W/vQChcRYsBljq6OREk=;
	b=kaAVBfWNJMCBbKqZ0bLilWjC8BNprLYiCYeDG3UGMAZo9m0qCRb93yN9d+VSy27Gcuqt
	 9j6NfPUHE87CjeoUqYuVd+RVzQU32YnSaeYAVVPfefwXLtS3QdLfPqGElS8Fq5z4u5jRt
	 NP32arSoUI9lVAus+ylKXpoz9qkfDUbAAJs5zvAgzsbjqCs4BZ4mh6g+5pBNzmblpvREJ
	 PL895BVqNAoxwqEIiVxs4RwEETAOiUQZoteEI+rTisVTA6VWR/i8LpaPbOfOi6aVq+9Vu
	 NoaqPcmY/cTpiiX+nZNIyCmJdvnFP2DLXbTb4psvHlxmr13KwgVJDAuDPQa1kk1AwDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810077;
	bh=SBBYoODnzugy5VYuZjRbv4j8W/vQChcRYsBljq6OREk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jksaRkrGj2bPRP8+o7C/UEB6TfOotK+ysubVc0MzkAYXzSvV1f98Mjwv5Q9aUWEdv
	 MU+wi905Tzzl8BZPJFoY6pE9FiS6B7ZqGzN0cSGQQjIXmt9vDUMk5mWh9u/5cAMITV
	 zWnYiBqpoDzkuiszXMwMBwFhBkGYciundBfEx71TCU4mymN6Bc+nXUsyXIqyDHpzXY
	 6evx6g7/NfW5seRpFDEPvh+K7gMFECILpFP3ghLvBTF6rYRaEKaNSUM8FRlX5MSgPp
	 7wNb3zj17dXcU6UDLBTtr9F4+J9bkJ8O9mIqhBRLRWDU25H3TFLSss4xIGjpOVQ7ak
	 zxLjpKzwS+lYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E08640312;
	Wed,  4 Nov 2026 16:34:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49734280
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AE8180D30
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wtr6I_DNvnzA for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63E9B808AE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Od7B7qRG; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cj/d4iN/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63E9B808AE
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:34 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj0MT1148894
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SBBYoODnzug
 y5VYuZjRbv4j8W/vQChcRYsBljq6OREk=; b=Od7B7qRG4EH0JlXUBbGE0xBzANq
 GcKcGLY1934vaTIjtYMwdeFM3lLKztAPAqpiKqAsJj5xETRUT2ifOA/r9SOp1JqF
 qte3GI1hmRDxaHQO6ka7xZmvvSLBre9X8jnxcdYljIvZEOY542g7IJBf8dM8P+Vv
 YKKb3I3yHx++vOvX3mu4XQcF9RzUOsnZhXmM5WK8JX+WdjUPdmB2Ha6UFZyE8aL1
 8v5EvuOjv7qZb/XCC7U/eNCbGpLF+pC6cD+aX/zHTzZzKU9GGZJaXewYmHERIF33
 +tMTe4/Ko1SvXLMCaRfUv+qnaKzZo3cWkTxYTIffLqmdjACrg5Ls4hqtKow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3r8186x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:34:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1637794eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810072; x=1794414872;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SBBYoODnzugy5VYuZjRbv4j8W/vQChcRYsBljq6OREk=;
 b=cj/d4iN/340D4uyCMHbSRdsqv7zhT8OemsQRQqTISQ9wP3wOI5fdE5RmgrYYtBdDaJ
 I1pDefGyyGNU+2jzzc8m4yfNM02aDMW/8Xy6K9GbQpB+4s2ekNF0v1WRPeUi/YAzRqsP
 Jhtduvz5YBCdU22l5izLpvtoxM0z97dKXq0ecEGH/uZTNMrXfHWX3uwj6nazxTwF24Sy
 iq/yk1nOEvm4r+YWLovarxKZ5TMSaB2ip5Q9Ck3/eRFED5WZpvCDfUZu0FYC92KZ0tq1
 BwUAgRotvMquEArLvhfNLQ+3yUgDfCkqY3hq83GLY8LvH8QLtM0Xld/SbVO05XnUo0gk
 N9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810072; x=1794414872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SBBYoODnzugy5VYuZjRbv4j8W/vQChcRYsBljq6OREk=;
 b=1mJemXgUSGVdk/DeCrg4TB0oj1O4iFBFUHom3aOdusFDTIwx76aSSJEzMfMEuTDusY
 +Wh5gDSQQywtAvpap9rs656h2STUSsyJHn/x/sxrUJg0G5hVXgSHR4g5NvFejy16m5wZ
 ukIzrOiOBEFB6qOwhuxMK1AYtLrD7Om+WEOk2i/YGGgLpQE4d+uZPmq3hw5bdeqzKQn2
 MWLNA/CnPwDQYn347T0CB9HrGaD9ceQXtJH3hLidRhBhFxXXNAdba5ANkb8/NefwXgyJ
 n1APBSXVKgOyCZ/uvSsXxTwr7GTp1MPyL/Tx9cdJCOi/7zeY+79oXmPnPyha6qfVwqtc
 Skmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBySCmtiCgQTBI2fp3Di9S1lg8FU5V5XbPmfXjlxbQGU6GX4/vSbaLeKNPu6R6RSySN7M4rXuj8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/lH+WouMtY5f+nQuW4HpIfAGQo69zHjPTgxOJm1wqv4EaH+Zey
 Y/fIp241YWtEKLyRyLX8PeqSw+IXhgCGtD8RsGJFlg2j+iu2wq95FdpIP/v9uLNDYq1OaHObtvl
 ew+1ZNeZhur405ymstQFk17wBQbuw8t+dfFRb/d2Wb2ByKM0nhL4bY3f1cbDuLe9oq6yYdHY=
X-Gm-Gg: AYBFou2fi5wupN3l7LmHCiWL4hbqHWLMub0OFRNW61exPGMM6TVCZ86W9oo2QDhC4UZ
 VmB/LtIBx2+T0Q91C0jB9veTpRtEIQZ1dPuJkK6wkcI8cn201b7GjgvwB0VSZiic0UP4j2iNIpt
 mVtkhK8gGHLXdMLB4iVdcoYTrB1EKQ8QtNjyhxzZu853wl7jtHJdG9CrXE2/GwHyNoYB2n8VTpI
 KJaL+t8jQCeYEBgDdWIvXUydx18E/3UfQ5vuwz4RsBSzz9hn4hafoERUHmkZW0P1frJ1aWoqGKg
 UFvuOemPuDJ90xfKov51d3MfNhgpez60moTQZrMR0JlNhSnZuNTDmnAPQL+MQPvicHfiGY1H5EC
 fYIqmzoLmtbAArptudj5XzM7jWmx1bqREw7ww5tff3IxcKiLs5DxW/s+3dUvNZmmZMWbnXxoalQ
 1bU5+nfW1mf+dg6SJ/hLG0S/99SCCdzI0yNjAdbNGI/PzjS01cz5Y8DS8BT3EcWaou
X-Received: by 2002:a05:7300:de06:b0:36d:2b02:86a6 with SMTP id
 5a478bee46e88-36d2b028b7bmr1918419eec.4.1793810072013; 
 Wed, 04 Nov 2026 08:34:32 -0800 (PST)
X-Received: by 2002:a05:7300:de06:b0:36d:2b02:86a6 with SMTP id
 5a478bee46e88-36d2b028b7bmr1918359eec.4.1793810071202; 
 Wed, 04 Nov 2026 08:34:31 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:30 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/9] pci: dwc: add inbound ATU window support
Date: Wed,  4 Nov 2026 22:03:50 +0530
Message-ID: <20261104163408.1250410-2-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XCK7q2d2JAcgETzv1XuyA7ENjTBVA5ks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX3JwHWZ+qxGZT
 IN6X97fkWeIiDODbOks2RJrsARmoTzxOK9C54MHQF/JqEqmuZxCwYjrF1XVX6mLmQks1mokJjM1
 IMosUDOJ21S3zP/CFzcnWePMtvnGdEmuh1YzesoHPPGpzBUz1LslUT2ZVo0L3MzwOiudRrU4oTs
 kU8Lm6U/WMsy/fRZM5lqoPzFYDnxEgR4Wtx/tIK5E+szAyLgL6kZ8pDVvaYw+VN5RyX4VYK9tYm
 jeoUYLfI/Me9AO5exKFatN8qs+GSOOJ/O6ETtuftYo1HfI1V+bOtNl2tHDCxFRNIH2A3QU63W7a
 jA6wszmY8ekTpvEZKA/kpSDGwfThBDres4a2pKkIy/940bDlJGo8D/eTIS+QAU0YcapnMQcONa0
 iUMMcyBhhPJAnv45gmWuMQZLk+dEJ1b6CqMOK4OeoJaaICBlT/29hcXTZO5HV+uGeBaODNMMpb2
 DXrHGAikhC1Tj7wWUOA==
X-Proofpoint-GUID: XCK7q2d2JAcgETzv1XuyA7ENjTBVA5ks
X-Authority-Analysis: v=2.4 cv=UuP2pOwB c=1 sm=1 tr=0 ts=6aeb5e99 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=QEqSwg7Z05fB6wceGJwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX4tLTJZEqw25u
 dW9DrWJuHwK5c1TEU0Sr67CAtk0DibT1p2rS/34izw9bb6+F7zNzM464Jw0zSu8Z/yCx72BYw3H
 WP+bp6ZEFy/se0p9vvS50QmQFgyciXY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040065
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

Only outbound ATU window programming is supported. Without an
enabled inbound window covering an endpoint's DMA range, the RC
drops incoming Memory Read/Write TLPs, which surfaces as a
Completion Timeout at the requester with no error logged at the RC.

Add pcie_dw_prog_inbound_atu_unroll() to configure an inbound ATU
window, mapping a PCIe bus address range to an AXI/host target
address.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/pci/pcie_dw_common.c | 59 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_common.h | 23 ++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index 4113a9f03cf..cdaad0960fa 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -144,6 +144,65 @@ int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index,
 	return -1;
 }
 
+static void dw_pcie_writel_ib_unroll(struct pcie_dw *pci, u32 index, u32 reg,
+				     u32 val)
+{
+	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
+	void __iomem *base = pci->atu_base;
+
+	writel(val, base + offset + reg);
+}
+
+static u32 dw_pcie_readl_ib_unroll(struct pcie_dw *pci, u32 index, u32 reg)
+{
+	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
+	void __iomem *base = pci->atu_base;
+
+	return readl(base + offset + reg);
+}
+
+int pcie_dw_prog_inbound_atu_unroll(struct pcie_dw *pci, int index, int type,
+				    u64 pci_addr, u64 cpu_addr, u64 size)
+{
+	u32 retries, val;
+
+	dev_dbg(pci->dev,
+		"inbound ATU: index=%d type=%d pci_addr=%#llx cpu_addr=%#llx size=%#llx\n",
+		index, type, pci_addr, cpu_addr, size);
+
+	/* PCIe bus address range that this window matches on */
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
+				 lower_32_bits(pci_addr));
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
+				 upper_32_bits(pci_addr));
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
+				 lower_32_bits(pci_addr + size - 1));
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_LIMIT,
+				 upper_32_bits(pci_addr + size - 1));
+
+	/* AXI/host target address to translate matching accesses to */
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
+				 lower_32_bits(cpu_addr));
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
+				 upper_32_bits(cpu_addr));
+
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, type);
+	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
+				 PCIE_ATU_ENABLE);
+
+	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
+		val = dw_pcie_readl_ib_unroll(pci, index,
+					      PCIE_ATU_UNR_REGION_CTRL2);
+		if (val & PCIE_ATU_ENABLE)
+			return 0;
+
+		udelay(LINK_WAIT_IATU);
+	}
+	dev_err(pci->dev, "inbound iATU is not being enabled\n");
+
+	return -1;
+}
+
 /**
  * set_cfg_address() - Configure the PCIe controller config space access
  *
diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
index 5fa50f3dc3a..6384dac6f0a 100644
--- a/drivers/pci/pcie_dw_common.h
+++ b/drivers/pci/pcie_dw_common.h
@@ -48,6 +48,8 @@
 
 /* Register address builder */
 #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	((region) << 9)
+/* Inbound iATU region n is at outbound offset | 0x100 */
+#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)	(((region) << 9) | 0x100)
 
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
@@ -142,6 +144,27 @@ void dw_pcie_link_set_max_link_width(struct pcie_dw *pci, u32 num_lanes);
 int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index, int type, u64 cpu_addr,
 				     u64 pci_addr, u32 size);
 
+/**
+ * pcie_dw_prog_inbound_atu_unroll() - Configure inbound ATU window
+ *
+ * @pci:      Pointer to the PCI controller state
+ * @index:    ATU region index
+ * @type:     ATU access type (PCIE_ATU_TYPE_MEM for memory)
+ * @pci_addr: PCIe bus address (what the endpoint sends as the DMA address)
+ * @cpu_addr: AXI/host address to translate to
+ * @size:     Size of the translation window in bytes
+ *
+ * Configure an inbound ATU window so that DMA reads/writes from PCIe
+ * endpoints to host memory are forwarded to the AXI fabric. Without at
+ * least one enabled inbound window covering the endpoint's DMA address
+ * range, the RC drops incoming Memory Read/Write TLPs silently, which
+ * shows up as a Completion Timeout at the requester.
+ *
+ * Return: 0 on success, -1 on timeout waiting for enable
+ */
+int pcie_dw_prog_inbound_atu_unroll(struct pcie_dw *pci, int index, int type,
+				    u64 pci_addr, u64 cpu_addr, u64 size);
+
 int pcie_dw_read_config(const struct udevice *bus, pci_dev_t bdf, uint offset, ulong *valuep,
 			enum pci_size_t size);
 
-- 
2.55.0

