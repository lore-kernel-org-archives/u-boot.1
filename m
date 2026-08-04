Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDBAC55172
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 07:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E24FB40703;
	Tue,  4 Aug 2026 07:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8KAqO9UZg_O; Tue,  4 Aug 2026 07:45:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20B1D406F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785829554;
	bh=/onTGiZ1K7eD61bTlIl1fo5FznSLsdmizjdu61GGU8Q=;
	h=Date:From:To:CC:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k86vhrQJHPDYB1chFXCaP9sw4a3bUM15OyAKW8nWTM+d3Ay3nGf9w1ofAiCcqLtSt
	 5kw6cI3Dg5dXesxFN3vEEA+AzcGuK+x6qxHS9zvstOb/e5gz5b4qLLG63K9YLObmp4
	 WIl3rN3nmGeqjScVCEPOVrY9J5vxJEZnLcbbNcc4cSkI4ONp9K5zC+sxw3vEdhkgCl
	 ywJPMouVGtniAGayT8H05OnkRixMwJZTzy6QwakItvX2HDj7wA28QJ/oabKg76OzY+
	 3VvjPRR3y22aJxnxMuu9av/UDF6Rv3a8BOGdOJeCb1Rgju2u24eMnUqxyAg1ntGiRL
	 4lTyb2MpD8xlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20B1D406F1;
	Tue,  4 Aug 2026 07:45:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DE03198
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 06:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF7A880B42
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 06:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nnjh4Ors4Tz1 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 06:14:49 +0000 (UTC)
X-Greylist: delayed 1987 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 04 Aug 2026 06:14:48 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 03B3E80B19
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03B3E80B19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.156.173;
 helo=mx0b-0016f401.pphosted.com;
 envelope-from=prvs=9676a5f00c=akashn@marvell.com; receiver=<UNKNOWN> 
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03B3E80B19
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 06:14:48 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6741734v365479; Mon, 3 Aug 2026 22:41:32 -0700
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fu31d1bga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 22:41:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 3 Aug 2026 22:41:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 3 Aug 2026 22:41:30 -0700
Received: from hyd1-dt91330 (unknown [10.29.36.146])
 by maili.marvell.com (Postfix) with SMTP id E5AAF5B6921;
 Mon,  3 Aug 2026 22:41:27 -0700 (PDT)
Date: Tue, 4 Aug 2026 05:41:26 +0000
From: Akash Nair <akashn@marvell.com>
To: <u-boot@lists.u-boot-project.org>, <boon.khai.ng@altera.com>,
 <jerome.forissier@arm.com>, <trini@konsulko.com>, <clamor95@gmail.com>,
 <marek.vasut+usb@mailbox.org>, <maxime.chevallier@bootlin.com>
CC: <akashn@marvell.com>, <rkannoth@marvell.com>
Subject: [QUESTION] Architecture and roadmap for Synopsys XPCS driver with
 APB3 indirect access
Message-ID: <5skppezbdkanp336d4nr2jv7yp24kngxs2wcewll6mrxgwdtug@mygftq2jjbjo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MiBTYWx0ZWRfX+WhqoYuP+eKt
 ycpVF02ncdPJaUD9AQu2hOshrIcrhE6E7fzypHNkSbZVwGXuBbrQ2a2vcAfXVB4b1H4s++AqiIi
 dS9T5q/NBepaUS7cZ3+IU8o3YNc+HIqo4avOA/SXSxsEZaVRPqT89BDhxy69bNbJr32xs2tLQcB
 St6tZ+7IPz6TFIWyATMxaFyxap+sD7E54p/L5Ox2PfcZn4J+OfzV6/s5StxrYnA/NGsCEgoHMkA
 x29neR+9BnnwI5sn4Vlu6PX5AsVTJrSphdVybAjJlUjuX3a35bApc/7vXMOurFPz1JR7/lraWae
 MpA7hBREQWydcwlJfGp+3YzhGwFQ1KotnkE0CpldKc1yLxt1ZAFVL3Pqo+HJEd4wMGSWz6MGTo2
 hruv07MLAu5n0dlTIqVZf8qNVx4zIkrUiEOvxhIAzQybAj4r9x4rPPgNjCO8OxulP6+QwcIX+/Z
 px71r8rAvZ6oVbodNAA==
X-Authority-Analysis: v=2.4 cv=T9K8ifKQ c=1 sm=1 tr=0 ts=6a717b8c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=JGFfrT4xk0um10-Nj50A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: z5ITZffx85hw_MQzOP-ZJ0OHDCTpexD6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MiBTYWx0ZWRfX728fJ9XxFRTL
 p2CLpfHtxo7WtA1LMEZpmE/yQuUEudwwQY7H9eMR4WpiOToGn2LdgfX5WpLVjabWzD+FLFzuHrK
 U2PVVevInLsSZ6RjwJucpJH3tAe9NVM=
X-Proofpoint-GUID: z5ITZffx85hw_MQzOP-ZJ0OHDCTpexD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:45:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 pfpt0220; bh=/onTGiZ1K7eD61bTlIl1fo5FznSLsdmizjdu61GGU8Q=; b=YSW
 mtCcrA0mwuAJ+TVvxvy8Yq7DIRjYk1k9qmISSI8F5H7bWB8v1xywiVB8kOuS6NAO
 iaAuRs/XczoX5GIofpIHs6JwcIC5PwYCwPG6ijogG+1FpSeeiJnSNvTO60akOmuL
 kdABz1AqrDLrPXhf8aSO8k1d+ZFCTpOwtFPc+8K0PBMSEvWzy3HmC6YSpXcCAiiS
 ykLf7b3FVuiE2ymv7B24OMoOhxB/aixcCNx4Xd5cSu7Gxyhxo7o7kKiYXXVFziJx
 a4xBArkGh43bUdi8JxuR5OEYDIDkFDwGaF0A6d0C64OHUDxsdem2ZhbLbvVjgGrl
 VID9FC5KzaOsNa5e4Eg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=marvell.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=YSWmtCcr
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi everyone,

I am currently working on Ethernet driver integration for Synopsys IP in U-Boot, specifically focusing on the Synopsys XPCS (Physical Coding Sublayer) block.

After reviewing the current codebase, I noticed that while Linux has a dedicated XPCS subsystem driver (drivers/net/pcs/pcs-xpcs.c), U-Boot does not currently have a standalone equivalent.

Before starting development on a standalone driver, I would appreciate your guidance on a few architectural questions:

1. Existing References:
   Is there any existing/in-flight work or reference implementation in U-Boot or vendor trees for Synopsys XPCS handling?

2. APB3 Indirect Access vs. Clause 45 MDIO:
   Most typical implementations access the XPCS registers over MDIO Clause 45. In our hardware architecture, the XPCS is accessed via an indirect access mechanism using an APB3 management interface instead of MDIO. Are there any existing driver patterns or abstractions in U-Boot handling XPCS/PCS over non-MDIO register buses?

3. Design Context:
   Is the lack of a dedicated XPCS driver in U-Boot primarily due to design preference (e.g., relying on TF-A/BootROM pre-configuration, or embedding initialization into SoC glue code), or simply that a generic driver model port has not yet been submitted?

4. Upstream Integration & Guidelines:
   Is there interest in upstreaming a standalone Synopsys XPCS driver? If we implement this driver under U-Boot's Driver Model (DM), what key requirements or design points should we keep in mind to ensure it aligns with current networking uclass standards?

Any insights, historical context, or recommendations on how best to approach this within U-Boot would be greatly appreciated.

Thanks,
Akash Nair
