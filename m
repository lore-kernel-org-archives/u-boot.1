Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED8606A339
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZSR+1hk6;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=VDsx2Jou
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D793B605D7;
	Thu, 26 Nov 2026 05:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GVsMBOC2Km3y; Thu, 26 Nov 2026 05:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE53B605D8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795670037;
	b=G0bCeZaXRZeHaa/++GgAUgQYtYPy/2OqVZzcPIfW53Xlq7e7c7q7rXUj4IsWpF6oJumL
	 YIpfudDEIX4rJ7E1LY9SzqiyI1DstPlui40n4fzcaXGyRS+dMEgrONh7UQIbmOMG2JzaC
	 /xHKqWAwfMTFEk6cNQmelmmDxvGWLjoa3VV67rOo26PtJpuGqqwhilb/j3nzlhoCnZTvG
	 ZMD58O6wYl22n9YggCoNZIIg9giTZDpsRSbCOdmYgkygHejgoz7mPqyCm9wbmk4RgNqUd
	 MCg8I2qSbwRrOduJ4YIk3n5fXZ41s5T3uO+mGGB/2L89QEII44AQ6tQ7JQRTyfiPFxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795670037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GlP/qnK7GaJomyX1u2X4fCGFzrkFFk/lafWQTIfuqaY=;
	b=Xz2wFAQ1iVbr40msNIi7qWik2nJGogsi6+oGB4ZkYZeLwCjgtsebi49RkY4w3ptKC0rh
	 N85zziSe34UDHH73BYilWQsULAg/iLjtCHW8CKscgKoj23QTGNig/eSGfqH8E0cIdGnUj
	 TRyUlAGsDt8E7IoV+r7Rq+l3p1TyexiVLeT2igb2ddotq/ZORmU89SZxnGpItDbuL79EN
	 gOdekIX5xSIZVtWJEDrC0TcQA6aojZseKnr9nsoF2JgoyBVj8ASFkmapM8tC8Cs4iiWt3
	 9VdnAh0x5qFRKqN6m9GYIm+H/fogQux2m9Pm+3O7PRjY6lYYDDviGyXQOgxfLSQMGGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795670037;
	bh=GlP/qnK7GaJomyX1u2X4fCGFzrkFFk/lafWQTIfuqaY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZSR+1hk6j80UTD6ffdRxX2W5DSo5V/6v3F7poNEBy0PRGADzNzOsfWX+z70rDBIll
	 zpKHWayV/DIvCyyzqGqSn4UPDMefua48UFAE+8jsg5jFNPCwXSeVUSgq95cSE5q7vH
	 YnFkoIHpbLhmo4dXveH6fgB2WOrqAWBP2sfd8ZLxSf/blMuCIe4rPdOjMZHzH4YReq
	 LToEDnYkmam/dPEOkpU+kRpfOmM0RsF92NcFeAuOSJgwWCBH8mEkZJqUH5Qt+sck3o
	 ScdxmFxwou3SYbkT+dnfZmAEf2/UyjwdRjcz7XERkud/EX3OTDU+bPoJZTxefN9qlr
	 SuWVPX4PUdVig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE53B605D8;
	Thu, 26 Nov 2026 05:13:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA6D0260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC2134082E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5VcN_5yZW6i for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 05:13:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE8584080A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=97907298e0=cyan@meta.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=meta.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256
 header.s=pps82601-s2048-2026-q3 header.b=VDsx2Jou
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE8584080A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:13:53 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 050DB84409; Thu, 26 Nov 2026 06:13:50 +0100 (CET)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC9E83108
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 06:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=meta.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prvs=97907298e0=cyan@meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ47qpX281990; Wed, 25 Nov 2026 21:13:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=GlP/qnK7GaJomyX1u2X4fCGFzrkFFk/lafWQT
 IfuqaY=; b=VDsx2JouX6viH6G7jhEFHXf3pKttm227kzyrgiu5zEOTIDjvirBM4
 MrXaZ5SRXRkB21ZjZcsok8BXfCLiBFJDX56OC30clsKr3UXRW+F2RtzZIIFuXPvs
 yWNNdnb7GCmMlabkOcGk5ohbtcVPh3InWOXZJkmj3Nlz9ayYRSAe5LFHUWIPlBFn
 FFcOHXEXyXEaMG51XcpGxRGX2P70jGXC9aTcua8Evik/MtCNT+sscRF9lJtqKAZ3
 5zbani+hyE7x/CV0+AGwGO/el912T75Dlm5hOHvJPDsL8uZKDTyXuAHtcjAjVK2B
 9jpenEah5Y1COxmM5hyWkMZnv8+GDo1xw==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j67ajhw47-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 Nov 2026 21:13:22 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 26 Nov
 2026 05:13:21 +0000
From: Yann Collet <cyan@meta.com>
To: Ping Li <leeonion.muyu@gmail.com>
CC: Yann Collet <cyan@meta.com>, <catalin.marinas@arm.com>, <will@kernel.org>, 
 <palmer@dabbelt.com>, <pjw@kernel.org>, <mark.rutland@arm.com>,
 <alex@ghiti.fr>, <emil.renner.berthing@canonical.com>,
 <masahiroy@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/2] arm64,
 riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Wed, 25 Nov 2026 21:13:16 -0800
Message-ID: <20261126051316.1050992-1-cyan@meta.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261126030233.2546274-1-leeonion.muyu@gmail.com>
References: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
 <20261126030233.2546274-1-leeonion.muyu@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZpN4uN7G c=1 sm=1 tr=0 ts=6b07bff2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=5IwbW6H4hVdjvO_v7jYA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfXz8YNemU33ufO
 o5xBoDi3IvGzoOGdCZgLYA4RfCYbDMwD7Q5x5x10n25tIsxGfu0vPnXK54Pi+jk5jtFdo/r8/hP
 Wlpf/nCrdY+XvV9a+S6+hzxzOOTjVK+3qjnkg/x3Uz7FU8yqATpyL61Z5ryc1xvbwTyK9SgHJpD
 yjA6BWgJ2I3nHTn36TcDJZLXH3i/v6QVG1flpLib+dJMiT7r4iP2mguElNRzlFtC6gCB6xCNGIf
 kH1aIOX4W848OhExTyGUVptAG2vnTAMlE6ypM3EqJ18NLeK/Mz+bVLj6ewRV46056ROOI0l93Af
 GoL2co+5v//52pZ9hYixbxf5YHFhltG4JGEtFCOeQ3jkXWiQYcLaZI8NE/gv5/r8GyIpQR5EPtC
 C0vmmh+o8Mkdbrb80GsSHqDjiy8Y2HdS7hVqcyT7bRrmM+GxxGVfNxIqNvQ49yvYF+ZbGfuKq/8
 pEHacu9k3tO2Vly4QyA==
X-Proofpoint-GUID: I2XxeRX9jXjlTSIji9u4ZBPn-DT-v1wO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfX3Qn1LInr7CSt
 nk3KkVmaNSHX0zsVso5Ex3vKbIOgZHIZnvbvoxfI/eOZ9dNQfLDbd++cPGe+BGlMAhSqecEZQLB
 nSBOVUqOfiTq0nLyrzfISM4DJbtzt7c=
X-Proofpoint-ORIG-GUID: I2XxeRX9jXjlTSIji9u4ZBPn-DT-v1wO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 11:02:31AM +0800, Ping Li wrote:
> Changes in v2:
> - Pass -BI so the blocks stay independent regardless of what the lz4
>   CLI defaults to in the future; deployed U-Boot decoders reject
>   linked blocks (suggested by Yann Collet).
> - -BI was introduced in lz4 v1.9.0 - older lz4 versions reject the
>   flag but already default to independent blocks, so the rule probes
>   for -BI support first.

Checked the new rule with lz4 1.8.3 (no -BI), 1.9.3 and 1.11.1 (-BI):
independent blocks in all cases, and the output round-trips.

For the series:

Reviewed-by: Yann Collet <cyan@meta.com>
