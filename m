Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657BECA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DFE840588;
	Mon, 12 Oct 2026 20:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iwwq1uqmTDAZ; Mon, 12 Oct 2026 20:25:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E850640585
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791836736;
	b=I7ZQRQM2dJhXfkO7I8YqWgzlStCWlsCm9OwJbJJ+75HKLhZi7HoRqZIgBd45RWJx9BCT
	 rF0MA6NV2IMBcctuPZTd9k+EXGtPIj5nExgIX9dT7UUNz110Cr8Qazl2ZEpyX6TUaHOlp
	 0LuX0Ea1uqjl0jqtisJSyak9SyOGQ13DWIRnHJB/sYbGUjJw+Hbz0ysUVWFc4EC6DI3Wk
	 om99bDD8mcBBRcOIMDlLBCuSKZG6J+Do8zdNhYTMMyt8sNgDlcNH90eShSkMdh/fygDfv
	 2BnTN5PkjRC2LSxZBOmwLgYQxnXUtztfMAn4rmXz4ubrImQZpgfKFYwiYUZBbcF2Tbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791836736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
	b=SF5LlMTu5BDbX2IEY4rAx2wAT8ynoyhV5m7DUWtLZ8Q9M+t2dt0kZpEZCQ/9tEovMdlf
	 q3cEflnbhfwefuK3bWsCSVkPlejfLmrdJn5q6q9iDIdIyIKZELxt9e/HxKk+GNanz7QfX
	 JX6RV6s6GG81u+CF+VdBD9AeZ0OS0O78MYfmOPNMmlwQKjD3VNHvvGLYFZVQCDLH4fy5l
	 8oLSjlCses82ne2zRSj5c2oSQ1fTcCZL9pyXkYTIlA4v82lt1qnDH4JAnFRJfwY4YNXME
	 FOEYuU5pU+ZECfao2ygQoo5XV02uqMqW1nGBlfg6Xcoyu2t0hahjpFYTFdWSMotRgwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NROcC9Hw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wyptqj4D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791836736;
	bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o4m4bZ9c/rgsSh0YRQmKhmBRnyhw1pKs8e0atFDP8AHJfGQkg6yD646TUL1xLK06P
	 gCGyqTo3eG2xeBgUYGEAfTZnrYLcLmwYOw/Pzk4eX7p3RHFstCvMOLSAEP7LjhOXKV
	 bUP77JgJyEkTrOAPx7lAh54YUdjwlhdrnub/uXhuIdjNhVxqnXAEnTJu+4yr9HA26n
	 Lw512lYtO5fquxZUw2hG+PdaaDh7VuW4/CYa6i3i1qKR+bme/5IIfdOsMNvJKJb99e
	 wf0l8z7Qr2lF16YLcVWhPihvi+qvFTriSRfhRKGhHXB+8s0M0U7YTTMI/eyw2bI3li
	 QO2GQnJ08p9TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E850640585;
	Mon, 12 Oct 2026 20:25:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6741B2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57A8540558
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JuOQA0aFdf5t for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDDF640564
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791836732;
 b=FqWN6hNVeNclcTJddSxqbpY43e+dCxzAKQx60IYVzODtu7FC2OdEyFYF7yrJZ9FEqp5E
 3hdx0JeyHRN0H5I1d9/RWcXUQN+5j9/Qj7HSxyV8fV1BMl8pvBNkPOABIKUeJwVQKwefZ
 Rxr6SOlddJnzlMu22QlEPEd0phA912zmRYpnffN8gZteVU2f+ARaevwK4PuhO+/ym/J23
 jK3czs9AZWVQeXHGEXaKEFD9SwvRS9XI80ZwvX4Bw1B2rIZUzRE6upCare+ycNFsAF2lZ
 Tzugb6ILQDQguyId6db7K76wmVEr2IDcY71y7Kt3clFquA5Pn1LcohvOECjcnUyrFUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791836732;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
 b=mDOr1tAG+ywtLz+IKB4q4G7+OxbiYKMPvIu/621JyMWeadQ3CA1EAZv6maeE38V2k/DO
 EcBzyha0qjwPjo5tFWLzCUczygkj3D3NOA7OauIsw/Y8dExqDkwHlvV0qlSKcFtf+5SS/
 u3AxuSuG31SqaDM28vZxb4luEJZZJ6+SW7vOUD+VIxV/jA7jyM+2Cg6DwBOKbWFkfMqIR
 VQQQeoaqBkfPvgExBH8ghbsVDAp7w6KzWsUL+wZtfJMJHEDaqjJHbCpaJxcOG72gq3nYR
 LhwjwMBGqgtFx48of/ihd1gXSoU/wdkVzQ7n73n/yqnM9LniL0TUlIjBdLQItKNyw3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NROcC9Hw; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wyptqj4D; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NROcC9Hw; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wyptqj4D
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDDF640564
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:31 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJgPU93106424
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=; b=NROcC9Hw2HTn8v7I
 Z32I+oMJKtz0Yj4L5rWAbhEXdMSolRVNpz/weVfYvWMYCDwnQ1HQ9DbOo5rbZqXX
 HkHgExAegMWgrblzxK353NUFbq3CQJ1bSoE1tnQN4DGSFC3ZlPACBEwcEj5gjevf
 mTMfoLHJOPagEY81r4NYJlt/nCcHjcM4fbqfy+HS6SQcvNXA6noKMg3evGHyvkLu
 6L/oa5Dn0NbU2jDhNkq8/9oVO6JCgmiLThjb8fFBkYkPqq8JqWPgJk08jDR5VTPE
 IzqFLqQAuS/u6z5/rQF1ND/l0dwbxooXABia1IzdhsnkXjqp5gcJk9asc5PVnFzo
 vNsoOQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqr4r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917bab67568so76018246d6.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791836730; x=1792441530;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
 b=Wyptqj4DEEHK2UCdiI9ibGZ3UlvGtp97hM3p5W9Ldl+cFvLW5tN3ynT7nLUrP97gfe
 S02wHCzqeEzp6HO4jWl7bwewMxortKGfyck8oZBx7M1MArv4ossAEfKeSKUOXOFpYwz4
 MRXfF67Gd+Sb1C/HcYb8CNlFGQ9ZqrvOa9SSY5N6MN2V1NCpSHrmpafGOgziCqrm27fY
 98xMs3hZBFnrRW8VkvFFmWXIIrW6EHjCnj6HpLWWKea0v/jaLteq1QIb5CvjtR0z5RJn
 33NIBW77FFG/Z16feFDIel/fGevbUAndSsbEIHPDhmVC85Lw+h28QwefyGs+5IABZfSw
 QGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836730; x=1792441530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9T1acm+3+e6yIuknXRNxhmx5tiszW75+w5CNgOztod0=;
 b=ChvovC31FTTrLWfNso7oTEv5EUPq7gByMT84c3aNKOHn6uxI/vQ2hRcJvg5HD/fsSp
 +ARRW72WoGHW+8nD+eftVt90kypkOOufGjRJLhHM65PSyI1olPr37+7+GJaNADijY8A2
 tcHrMBtzclONcGOB/FMLx5seNVisNfMkOR3bKTf1a7Y1FudhyoZGQ9al2GeESGv3OazD
 8cxuG84Z+JSlgSFtHefFeuNgqxI5ud93A6L2oXgRGZZu8y8MTtbkWIgENT979+GROGX2
 SU2FuCGR5+tgc9ht+Qsw0cSqnBE7HwsQpR0mq7mn9oZ3i/ixyAVhkSaRy2inWEud+uJN
 n5uQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYTsyRgbB4f8slzOp0FVaMMcb+KKKLblMACZwTUYEmzHB8w/KbdV9GhU6GZCQMU6FQBx3PLJg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIY4TVlBhdqqQX6xGJjVMCMWLd9D8PPWA4iTfWytoQr1hCBIB8n
 p9XlYZkklQ8j7FRYYonIUyl72EgD8imvWGfQG7wTAVhF2BWI3BcK4EhcI+bGdjUqG+So7lhaiJ2
 OVClGlpsahE1ukKXd55LHgjS2Ct/QfIEKs2Z8OLC+dx9GrxgbhLlFpWLBAtHoWLXX9W9awdm1XB
 PvL0W4otw9
X-Gm-Gg: AYBFou1it+TXF9vTooKHv026ocemz3qX6UbmzzUpsBlwKIPMWv1W2uf2Gxvi8QdnWcI
 VvinxB6DEpauJXuIDpD4Jth7aLDfwfMggFovXaUCP2brtxpCScYQ8uCw/xIKjqpu1EVzKwJM4L7
 1N7TWRG4OBl66dqjxvhz5rxELl4dFJK0daAyOSV1cX7flYTKS9jy0qoBBuJOMzDasZ8zhFlMGmq
 HzcyJNeWlRbMbUdgaKSbH+8uWng4+2j4QO4vxliJ9f76LiQmEtKgJPiynqbQDVtgr0e+2DyDEth
 etwdzC1Nw8OEj5096Fq/A6SBYE3O1/6fpmk/vEWwJgM5YHyAdQwHnmmzkp0Uqj8Q16YR4sy4o46
 ay7ppH2SIqcXgsSjAHZ6FoU2pZNaftFhRHVkknidXBOqh
X-Received: by 2002:a05:620a:7111:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-93ebd2a5cbbmr1870842785a.65.1791836729594; 
 Mon, 12 Oct 2026 13:25:29 -0700 (PDT)
X-Received: by 2002:a05:620a:7111:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-93ebd2a5cbbmr1870837985a.65.1791836728955; 
 Mon, 12 Oct 2026 13:25:28 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ae6fb7sm491260966b.84.2026.10.12.13.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:25:27 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:25:05 +0200
Subject: [PATCH v2 3/5] avb: verify the boot images in the buffers they are
 booted from
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-avb_lock_unlock_b4-v2-3-87460a24e559@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfXzKsTtR3P9rjk
 8Jbv3x9eEdUfhDRoqP393U5VD0WvHr3kYHqDh35IBKsiUPTWO7fMFeBtBTfhWAOPXkwlzXczJqk
 6lLWfMc2jGjik+dfasUYZOsepKyhIXElPuicWus49U4PCDffjL5Ij/83s8/0Q0wI0oVHBbGm7cJ
 tuLuj2zgdyOyJtYni2kx3X+5NjWbH+apyTDukwDB+X4WgbNJEFL4liXklRfPbOnu8gnR0UDLTW6
 jFcg6NMPWtlBrYM8lJhjlkt7LpulCxDUeAHMqiJPRJ1nJjAQRkLA4XxT5dp80Sh+vKSQmN5PYUr
 hqVCxfL6Sn7r1IWzWhcjlRsdvIhWV9Jg6f5Dkcm+oEgZpTjHLbtQgQqc/Pax0UJzOA52AXSk0f1
 9rP5PKz8dJfw7lEo7W5Xmk9KICS/KtrU/OZVoHEe6vEOeIV1xwLquc0HzXlOCi6VeByjJ6GGt5m
 nxLCgcfSq8SalVRAeQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfXxPCgGJXpcgkf
 La8T9wAkEy0kPCW4t1UvbCD1cBKXO6Mt+CYKSPzyne+VCXMlG1zQYDUXWrL90GhDR6+lkpigeTA
 cFJbqucLsL/eOpb3t2r8Fk/R0ki+GbU=
X-Proofpoint-ORIG-GUID: DkkY34-XpVTwh7gHI5AZ3SdczsDNMO1R
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6acd423a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=yEqb_-nEaZmDm_Th2vkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: DkkY34-XpVTwh7gHI5AZ3SdczsDNMO1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120081
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

bootmeth_android let libavb read boot and vendor_boot into its own buffers,
hash them and free them, and then read both partitions again to boot them.
The bytes that were verified and the bytes that were booted were therefore
two separate reads of the storage device, which an attacker able to
interpose the device can tell apart (reported on the list as a TOCTOU
issue). It also read every image twice.

Load boot and vendor_boot first and hand the buffers to libavb through
AvbOps.get_preloaded_partition(), so the hashes are computed over the
memory that bootm consumes afterwards. If a hash descriptor covers more
bytes than the boot image header announced, the tail is read into the same
buffer, bounded by the partition size; a descriptor larger than the buffer
fails verification.

Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 boot/bootmeth_android.c | 73 ++++++++++++++++++++++++++++++++++++--------
 common/avb_verify.c     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/avb_verify.h    | 36 ++++++++++++++++++++++
 3 files changed, 177 insertions(+), 12 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 0db08d4f861..862d0d67a2f 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -48,6 +48,11 @@ struct android_priv {
 	u32 header_version;
 	u32 boot_img_size;
 	u32 vendor_boot_img_size;
+	/* Where boot and vendor_boot were loaded, and the partition sizes */
+	ulong boot_addr;
+	ulong boot_part_size;
+	ulong vendor_boot_addr;
+	ulong vendor_boot_part_size;
 };
 
 static int android_check(struct udevice *dev, struct bootflow_iter *iter)
@@ -353,7 +358,8 @@ static int android_read_file(struct udevice *dev, struct bootflow *bflow,
  * Return: 0 if OK, negative errno on failure.
  */
 static int read_slotted_partition(struct blk_desc *desc, const char *const name,
-				  const char slot[2], ulong image_size, ulong addr)
+				  const char slot[2], ulong image_size, ulong addr,
+				  ulong *part_size)
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
@@ -396,6 +402,9 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 	if (n < num_blks)
 		return log_msg_ret("part read", -EIO);
 
+	if (part_size)
+		*part_size = (ulong)partition.size * desc->blksz;
+
 	return 0;
 }
 
@@ -440,6 +449,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	enum avb_boot_state boot_state;
 	char *extra_args;
 	char slot_suffix[3] = "";
+	char partname[PART_NAME_LEN];
 	bool unlocked = false;
 	int ret;
 
@@ -450,6 +460,35 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (priv->slot)
 		sprintf(slot_suffix, "_%s", priv->slot);
 
+	/*
+	 * Hand libavb the buffers boot and vendor_boot were loaded into, so the
+	 * bytes it hashes are the bytes that get booted and the partitions are
+	 * read only once.
+	 */
+	if (priv->boot_addr) {
+		snprintf(partname, sizeof(partname), "boot%s", slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->boot_addr, 0),
+					    priv->boot_img_size,
+					    priv->boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload boot", ret);
+			goto out;
+		}
+	}
+	if (priv->vendor_boot_addr) {
+		snprintf(partname, sizeof(partname), "vendor_boot%s",
+			 slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->vendor_boot_addr, 0),
+					    priv->vendor_boot_img_size,
+					    priv->vendor_boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload vendor_boot", ret);
+			goto out;
+		}
+	}
+
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK) {
 		ret = log_msg_ret("avb lock", -EIO);
@@ -566,6 +605,26 @@ static int boot_android_normal(struct bootflow *bflow)
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
+	/*
+	 * Load the images first and verify them in place: libavb hashes these
+	 * buffers (see run_avb_verification()), so a storage device that
+	 * returns different data on a second read cannot slip past the check.
+	 */
+	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
+				     loadaddr, &priv->boot_part_size);
+	if (ret < 0)
+		return log_msg_ret("read boot", ret);
+	priv->boot_addr = loadaddr;
+
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
+					     priv->vendor_boot_img_size, vloadaddr,
+					     &priv->vendor_boot_part_size);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		priv->vendor_boot_addr = vloadaddr;
+	}
+
 	ret = run_avb_verification(bflow);
 	if (ret < 0)
 		return log_msg_ret("avb", ret);
@@ -575,18 +634,8 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read slot", ret);
 
-	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
-				     loadaddr);
-	if (ret < 0)
-		return log_msg_ret("read boot", ret);
-
-	if (priv->header_version >= 3) {
-		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
-					     priv->vendor_boot_img_size, vloadaddr);
-		if (ret < 0)
-			return log_msg_ret("read vendor_boot", ret);
+	if (priv->header_version >= 3)
 		set_avendor_bootimg_addr(vloadaddr);
-	}
 	set_abootimg_addr(loadaddr);
 
 	if (priv->slot)
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 9231366d5fa..e7685c29d65 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1079,6 +1079,85 @@ AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
 }
 #endif
 
+/**
+ * get_preloaded_partition() - hand libavb a partition the caller loaded
+ *
+ * Without this callback libavb reads every requested partition into its own
+ * buffer, hashes that copy and frees it, and the bootloader then reads the
+ * partition a second time to boot it: the verified bytes and the booted bytes
+ * are different reads of the storage device. Serving the caller's buffer makes
+ * libavb hash the memory that is booted afterwards.
+ *
+ * The boot image header may describe fewer bytes than the hash descriptor
+ * covers; the missing tail is then read into the same buffer, up to its
+ * capacity, before it is handed out.
+ */
+static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *partition,
+					   size_t num_bytes,
+					   uint8_t **out_pointer,
+					   size_t *out_num_bytes_preloaded)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p = NULL;
+	size_t num_read = 0;
+	AvbIOResult rc;
+	int i;
+
+	*out_pointer = NULL;
+	*out_num_bytes_preloaded = 0;
+
+	for (i = 0; i < ops_data->num_preloaded; i++) {
+		if (!strcmp(ops_data->preloaded[i].name, partition)) {
+			p = &ops_data->preloaded[i];
+			break;
+		}
+	}
+	if (!p)
+		return AVB_IO_RESULT_OK; /* not preloaded, libavb reads it */
+
+	if (num_bytes > p->max_size) {
+		printf("%s: %s: %zu bytes to verify, buffer holds %zu\n",
+		       __func__, partition, num_bytes, p->max_size);
+		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
+	}
+
+	if (num_bytes > p->size) {
+		rc = read_from_partition(ops, partition, p->size,
+					 num_bytes - p->size,
+					 (u8 *)p->addr + p->size, &num_read);
+		if (rc != AVB_IO_RESULT_OK)
+			return rc;
+		if (num_read != num_bytes - p->size)
+			return AVB_IO_RESULT_ERROR_IO;
+		p->size = num_bytes;
+	}
+
+	*out_pointer = p->addr;
+	*out_num_bytes_preloaded = num_bytes;
+
+	return AVB_IO_RESULT_OK;
+}
+
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p;
+
+	if (ops_data->num_preloaded >= AVB_MAX_PRELOADED)
+		return -ENOSPC;
+	if (strlen(partition) >= sizeof(p->name) || size > max_size)
+		return -EINVAL;
+
+	p = &ops_data->preloaded[ops_data->num_preloaded++];
+	strcpy(p->name, partition);
+	p->addr = addr;
+	p->size = size;
+	p->max_size = max_size;
+
+	return 0;
+}
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
@@ -1146,6 +1225,7 @@ AvbOps *avb_ops_alloc(int boot_device)
 	ops_data->ops.user_data = ops_data;
 
 	ops_data->ops.read_from_partition = read_from_partition;
+	ops_data->ops.get_preloaded_partition = get_preloaded_partition;
 	ops_data->ops.write_to_partition = write_to_partition;
 	ops_data->ops.validate_vbmeta_public_key = validate_vbmeta_public_key;
 	ops_data->ops.read_rollback_index = read_rollback_index;
diff --git a/include/avb_verify.h b/include/avb_verify.h
index d2136b2ce02..cac8b816c03 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -22,6 +22,26 @@ enum avb_boot_state {
 	AVB_RED,
 };
 
+#define AVB_MAX_PRELOADED	4
+
+/**
+ * struct avb_preloaded - a partition already loaded into memory by the caller
+ *
+ * libavb hashes the preloaded bytes instead of reading the partition again,
+ * so what gets verified is exactly what the bootloader goes on to boot.
+ *
+ * @name: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: start of the buffer holding the partition data
+ * @size: number of bytes loaded so far
+ * @max_size: capacity of the buffer (at most the partition size)
+ */
+struct avb_preloaded {
+	char name[32];
+	void *addr;
+	size_t size;
+	size_t max_size;
+};
+
 struct AvbOpsData {
 	struct AvbOps ops;
 	int mmc_dev;
@@ -30,6 +50,8 @@ struct AvbOpsData {
 	struct udevice *tee;
 	u32 session;
 #endif
+	struct avb_preloaded preloaded[AVB_MAX_PRELOADED];
+	int num_preloaded;
 };
 
 struct mmc_part {
@@ -45,6 +67,20 @@ enum mmc_io_type {
 };
 
 AvbOps *avb_ops_alloc(int boot_device);
+
+/**
+ * avb_ops_add_preloaded() - register a partition that is already in memory
+ *
+ * @ops: AvbOps from avb_ops_alloc()
+ * @partition: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: buffer holding the first @size bytes of the partition
+ * @size: bytes loaded in @addr
+ * @max_size: capacity of @addr; a hash descriptor covering more than this
+ *	fails verification instead of overflowing the buffer
+ * Return: 0 on success, -ENOSPC when no slot is left, -EINVAL on a bad name
+ */
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size);
 #ifdef CONFIG_OPTEE_TA_AVB
 AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
 #endif

-- 
2.53.0

