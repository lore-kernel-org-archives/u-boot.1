Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE24606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uEMN5rAB;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MP0zNJDK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QflTlpVD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF3598174D;
	Sat,  7 Nov 2026 12:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBbBf8LZWqQU; Sat,  7 Nov 2026 12:53:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15A5281769
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055984;
	b=TM2dIXqo1ylF6kySASCu0WzmIJAMzzilfarzD9fLp0UsEc4z6RUFhrzjFViVhCBd3tr3
	 vviRFTmekRWsrjMjaghqGz3si5SWDwYRgTkwOHQJSWHmEyXbS5ik5PBx7jyvV7HEG59qg
	 qyo01/jilcDb8z4GBc4yyBZTRpLLUAuHKjw85INpGcAA6amQTnSeUNmDLl0ZxqVuelypo
	 oz6eyvyP3qiyRMcRvcKPrwQQb1rqUeNaxdhpoapWDpyr1hESMbyfYFQjqSPQiWzvU9JJI
	 Sj4HFuKnXg3/dmy6Yf/ArqS3okeyPIuwCmjyhRXJehd923grQGfz7LxG9gLQhme1Ezw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tgoU70R91LNL2XseBXm+sx1/LxDIowkd8Mr8rSdiBnY=;
	b=YmPTWOQB/IrHlUyUhn0LAjjlOBMStcD2Y87/DZ2TSRUqUYwyzj6xp8o2XgTj9KHDCbTg
	 zNMaofRKWoTs/YukZUfy7cO7y6UpO4Ul1MuQxZGtIt6Ld4OE0BGVu28Ue4gZjD5Y0W861
	 cpnaQh7J+AXXS8zL9z68+7uJyQIv5t3D/hRGetr4AEBhH8ONZfzSms32dIEUQMupmVkwA
	 osdGvXNF54Ph06/1qUeFA2dvWmUHMKSFDOrj00CECm+lUNm7Ov9ETa0bDpsv1XjRYp6p1
	 8wLpbx9gIyzGkm/18rcOn7sarmGeW52vM25SYxGF4psS9gk2sCFq1G6Y1blLMB7g6Jw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055984;
	bh=tgoU70R91LNL2XseBXm+sx1/LxDIowkd8Mr8rSdiBnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uEMN5rABUH05pV9PALNvryeKUhkQSNJW0xEyv4O272TluigAo4ASgNrNi8mDU+VX2
	 +sPA0boXQWwTYgTJfxwIoeWxQN+wBgy5+yTP+ygrrZqhDUSligNVJHkhOp//Wd0+m8
	 AXOtal96TFXuQjXAYBCcY68AihyW007dEzfsj/pmygnDi1jywtmjquCgHIVIuNCLuJ
	 jYiBZgDXKfIs6WpO1QIM4D3VdlLYfAAbfQSyrEc8lXZMnSjRtlDe93ENZMyRWntHHx
	 0Vrm+iqruaK+frDkKoAgT0o67DestexaaKuF5/GxhQOdXOtncrfHTZRzRecEF3jDEo
	 azAF42d41AyZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15A5281769;
	Sat,  7 Nov 2026 12:53:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92A811C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 844746078D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yi7qNy6ozP0E for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 12:53:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A21860684
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=MP0zNJDK; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QflTlpVD
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A21860684
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:52:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7C1C4N2711879
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 12:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tgoU70R91LNL2XseBXm+sx1/LxDIowkd8Mr8rSdiBnY=; b=MP0zNJDK+hmPcwda
 jiFRCLkFq07aCDnfMT7Hhry2UULQ9n48ziU/CtpId8WlXlLhRpAP8AaQWQh8pwO0
 HDw/3AHdWlzWvPRYjIb4Mc8Sw74K4VMWd6Sf9IGHq99ZLyGZZL0r+JzV+2Cr1p8q
 WN5YdoHR79hdmfKyXXtg2k0X6ligo9YodNsJIsFu6A2jJADM83yddyH8oYs67cTt
 +Q2iQfdR2G8xS2x0yPvb7m58ed2dHrln8tflp/uMnSD2eucFofhE9oji1L+lqBFj
 L55S0eZZIVfK+MuDNm+0LXOFOaPU0/pJz/klCLdNCAwmO+0hCt80ScNRyV3M7+da
 4po5LQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hssbns8xt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 12:52:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb93c874bso128671685a.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 04:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794055977; x=1794660777;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tgoU70R91LNL2XseBXm+sx1/LxDIowkd8Mr8rSdiBnY=;
 b=QflTlpVDOs5oiTMWE0mjNjUlKLIYoPw1JxJnEANJ1A5/SOX6jB0SHVUznYrONx1I6+
 iGviYf+fvtesKBXvJPcdl0CVKbX3Imo1MS/pWJhqNM1r6XuTY0kgOfpMK2faIlY242al
 sqJpx+fJCVwz9EgXKWo7v5aoE75KVYbJ4DiAiaCoIYW5e/w2MwF6kzolJT4tbXcD5aMW
 Xi4J9OQmOqXMyYI4WQUChpY5hvtBw97W1fSCtkzubB+hF33DnSCMjDt094CAADHgefUP
 5BmJr6D8Mi8ip6nz+zUijAbepagASFInmdBOnpZU3Htkg6KBr0m65pXiuxm/+lNK2av1
 fXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794055977; x=1794660777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tgoU70R91LNL2XseBXm+sx1/LxDIowkd8Mr8rSdiBnY=;
 b=Ov063Keq5WtPbjbzHBn4BA7C36pw6HFkXTEHMrKAJd7svhhN95TZ9gY7KzxlrBIVZl
 EsugDjiLyyxGaxkPI462DQy4Zg5tI91NvEQkxyHWxZNNtdHxrSQQdCpWra5y5DFK1yan
 Qr/fVSnN06IwVJkCTh7sB+LXukfqY3bPzx2NBgfSnjoNvrGqCUDudW9rSsadHf7ZDSA+
 ZcdC0nnCAzofK1r+Z1adbndV1nsINvnJydJMG6w7qZ3kBBD8/I9jSc4nBtZ2CyXBHRz/
 uQEEzR8Y/rxdMov9FLRuR4sctBAS/fNqkxygBkf6SQCLb+1AKwOPJVSd0Y8xSqtiMQpQ
 nVWw==
X-Forwarded-Encrypted: i=1;
 AKwUvByxVPnLTrMeLHnvU2jESevNDF9q+pdEu4ARndjh2TQ9aPeSF41H0sLrL4j3W/WNGVFDxNkC6bk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8w49DBB+kTDx2iWHyOi2Tpyi4zYPDK5yRXNYzPDPWYtOIVoPtV
 Te5tE/1eCboM8u8cpLIYnIkECJogoqgjhYF1Mv4oP593gD41FHWrOE7S2/wsT5xhtueXL/vnG30
 k985u+RyT3oBOJb+xrvZP7wFH3oA+xY4vQJd3Ym24wIHJ8ZHmQPnUEZuHx5lUfSh5n1ah8ZA=
X-Gm-Gg: AYBFou0nxeGWc7mMTYZ87xWXgySTxTsfV1m3nwDAbOVBkPKqaEHWLyzH5Vffx9n3cLh
 8pbs/RM12ptQ1x/Y1ocBTqerd3ermmw0SyV8dlNr0fTDN+d4TIR3Wh30xQh7maH6/n/bKcPcogX
 YdjSh7i1a05rwIf4BayZeY3KbBAxwbXwYNhjqBSj45STZBRjRSEBU/8nW0LOAPIvpPVie4DIb8h
 weB8iugnzIKyr38T8UrC7BZHET+KdAx8TFWoJpeql1m15kijXDIIsid4APokEIbwuxZBO94kP0E
 x1wafZ3VLcSiKQbSJzcOL/nvLOPuuGwszn0dBXItARpl3KiGUJvpvnFOziTSqjbZyXKcDavtlQK
 XFjjw4J4Ea8Yq72+VhQZ7Hf2z97N9SDq4tJ5cIhOTGSLC8Bo7NgDyLpwPVylIo/5Zg1M2aaIktF
 2sUoTgKnDFEA86
X-Received: by 2002:a05:620a:1a1a:b0:944:1e9b:e674 with SMTP id
 af79cd13be357-94604d56beemr275748985a.17.1794055976979; 
 Sat, 07 Nov 2026 04:52:56 -0800 (PST)
X-Received: by 2002:a05:620a:1a1a:b0:944:1e9b:e674 with SMTP id
 af79cd13be357-94604d56beemr275747085a.17.1794055976466; 
 Sat, 07 Nov 2026 04:52:56 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356c3692sm148599966b.66.2026.11.07.04.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 04:52:55 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 13:52:50 +0100
Subject: [PATCH 2/5] test: avb: test the hex persistent value commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-upstream-avb_tests_b4-v1-2-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: xohQbT0F4XbokzISjGislvG3HqzvhnmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfXwqsAXLqD77gK
 ntxqAJammXSww0/stsnMTEp1w2l3znxJ3uLjr7cUo1fNIVLOMY1asx67tI4ATLxYkmhwjdlWRBy
 2OgtqeiNYmjeG325zQSP65zu8TRaKqIw62uvXN5r9ODuc9aKPo8wMbDxa0cPBc7p5HYJLYqlIw2
 4HYIIgzqIzl7N8rIr7yAzh1EYdTffNUam0pTq54Ai80uaOILfcR13R5HbCK+DhNXk9QuyX92poy
 66b1YDc+FllUGjL/gPqWMizRgrUNEa0XtwXUtWmwh5SEEg53CKe4d073sLe3FWW73er+uDFGF4p
 jDvxPTpFFNsm+IadAI8RUCeJQDDudKBMRtfC3s216jqa9UKbYTneKqkFfSd9+1/RkV2uxdlAoVi
 i1ZuWu8KZwnHkhKRiwdpAKwtIEtdjHk+HgooXicWpAO9YEyxYvPS5hNOEyvG6r5AztxyuGQRV4f
 o65xKRD/+6ZBejBAfDQ==
X-Proofpoint-ORIG-GUID: xohQbT0F4XbokzISjGislvG3HqzvhnmS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX7PRBdCrB+iIK
 2ZL+FOMWVeD4o1AjTp6emZUocv7zRHAk2EsfmdY0uGfD2dVIKRudvhrPTpfZYAevldb2mY2xBws
 TtDYHG1119A9ZyUmvfl7nHK4uwKdh4A=
X-Authority-Analysis: v=2.4 cv=JtBkP84C c=1 sm=1 tr=0 ts=6aef1f29 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=a8p-q2BOvgTI9nRn-vcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070051
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

Persistent values such as the digest of a user-provisioned root key are
binary and may contain zero bytes, so they are written with
write_pvalue_hex. Test the round trip, that string values read back with
their terminating zero, and that malformed input leaves the stored value
alone.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 test/py/tests/test_android/test_avb.py | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 8d7814c06a8..4dca5849ced 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -170,6 +170,42 @@ def test_avb_persistent_values(ubman, avb_device_id):
     assert response == 'Read 12 bytes, value = value_value'
 
 
+@pytest.mark.buildconfigspec('cmd_avb')
+@pytest.mark.buildconfigspec('optee_ta_avb')
+def test_avb_persistent_values_hex(ubman, avb_device_id):
+    """Test reading/writing binary persistent values as hex
+
+    Values such as the digest of a user-provisioned root key are binary and
+    may contain zero bytes, which the string commands cannot handle.
+    """
+
+    response = ubman.run_command('avb init %x' % avb_device_id)
+    assert response == ''
+
+    response = ubman.run_command('avb write_pvalue_hex test_hex 00ff0010')
+    assert response == 'Wrote 4 bytes'
+
+    response = ubman.run_command('avb read_pvalue_hex test_hex 4')
+    assert response == 'Read 4 bytes, value = 00ff0010'
+
+    # A string value reads back with its terminating zero byte
+    response = ubman.run_command('avb write_pvalue test_str ab')
+    assert response == 'Wrote 3 bytes'
+
+    response = ubman.run_command('avb read_pvalue_hex test_str 3')
+    assert response == 'Read 3 bytes, value = 616200'
+
+    # Malformed values are rejected and leave the stored value alone
+    response = ubman.run_command('avb write_pvalue_hex test_hex 0')
+    assert 'Value must be an even number of hex digits' in response
+
+    response = ubman.run_command('avb write_pvalue_hex test_hex zz')
+    assert 'Value is not a valid hex string' in response
+
+    response = ubman.run_command('avb read_pvalue_hex test_hex 4')
+    assert response == 'Read 4 bytes, value = 00ff0010'
+
+
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_avb_init_interface(ubman):

-- 
2.53.0

