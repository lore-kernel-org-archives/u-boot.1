Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B6C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 06:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CCAF60638;
	Mon,  7 Sep 2026 06:22:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOUG2VbUl3IF; Mon,  7 Sep 2026 06:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7EA626060D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788762170;
	b=HPFuZD5OfCQXrZ61HhcTX/yIWOSGv6EmFfECfOG0Jp18v7VWyWdZZmrT6xibABGRW84z
	 FvO/OC2vzR/m9gSOhtWT5Ijit83Ktl0cwrMSGyfgo6jx8I+7mwIdrgh+0aggne89WwKGM
	 /enqib+GEfo2p5NIwSQ+md6+d+a9d9JPN9ZNaGhJikJ5jL/JSSsj0ehytj8d0S0rLBYzW
	 n9MJUyIN69pUPTQWPjiMTU/C93syM+qy4Cxb+3nZGCOsNhf90hsZcuHTC46OWdw+1YuyD
	 ExXUVxS+gldsw0i7Lurk1lgE2C4h4v7x8Enuny/GTWEokt6ntZh/b/G6nhrxjgL6HeA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788762170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=boG2xl9h/fFKTP7lnp7bg2p5g5qJfFeTQiatA1fu+JU=;
	b=oXQKoXCzTkSF/XKiG9P9xZkJFDI4b4IXhobHvXOAVo3CfM7doKO7Jg+/oH94TV1uMawc
	 inrA/hEpXDwiV6YjXI2sGfYU1Zo1L2LRynIiljJjJ+0c1EeveeLPCkfWzGrw/yI9xX1e+
	 EcuT6gNK/Ej7vnrGcACFCEq/6BQrN7p5nnp9znfFzg6dJVKVhcKYaN2eT2i5PK7wQ5mAN
	 JxWPDs1mIuHXurhllrnJhi4pMV2qX6VcoENTB1X/wQbhsELnZ/Y8arUeFfJx6tIH+h8ng
	 f/bSFhRdKrSQ3ue/x4qC3GTx0J557SFQo05gtB3S4InqrjLgFiO4Uf9skE7cPbQu0Tg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TlVy+Jbu;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=HBYufWo7;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788762170;
	bh=boG2xl9h/fFKTP7lnp7bg2p5g5qJfFeTQiatA1fu+JU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHMAQs6PrKJKXma4zg92O5winCSnwaWEMrdgSBPnhhngodtqtZsb0Cu8h7AvVp8UC
	 4SVO+QAXB0OMkQ8CQNgYiR94LBV9s+N/AUScifMpBMAo3G4863GUsf2lpTKwKXCLi+
	 5ggBjECokSRXwwZEZxWGW5SRKt6zfTqOLyNpC/AILWZ4gUNOjA0dJeNQqjvKmA67MO
	 JuvURcaCu+5FgGLf/iif/4JgVXJOrDHHOJwVMLs2THtsiZSUo2fsXdHNyaY5n1mDSq
	 Gnhg+pnh8MBXBnGAFtDC3WrO9qOdCofnYOFlOLl42FsUmidLFuLucWe2jILcYvd8xO
	 W3sgw84Cmf3AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EA626060D;
	Mon,  7 Sep 2026 06:22:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99338990
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86B006060D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-zsemwK6FW8 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 06:22:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D1DC0605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788762168;
 b=RsfZkzRDi7C7/FAxtbe122PKfgqHVwhZFhPLUKuLsEccVd8Y4L2tSl10V1yN/KZVgiMc
 v6nxMQg22d3gVJw+tUrSOzDsTtMfbeVi9KQTta6uFBS2mSRqIHnvdFU1ZuJ//b5m8Uwo0
 su9rb1MxJvL/WfsV28S6i2qzZZ2wiqmlKhgPcjeoYLWUfBhlAM7cV+ik29F4yqIJMhNJ4
 BLcU0pHs6hEOCxeXfKEXQ8nrbsdg0cDxBv3WCDgqIoqHiObULfBQXiUQ7CJgD49CbTYPD
 kBR/2atmpRyBtb0wVgPINTvHvabKCalq8EbUZloWt/tLJXA9aSuD0xyLMWfmEVKLz+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788762168;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=boG2xl9h/fFKTP7lnp7bg2p5g5qJfFeTQiatA1fu+JU=;
 b=lhzi7K3/Ev6Gn5VQGqMMxCWRJtqldyrid/hjayetNFGvXspYjjh/I9mfIFY3AkLB0zG7
 OXcLZPnSi5Deh/dIegb8DunykEudNbbjiharD+9BIPWxoS2LFIE/P/nRp19ikFfaxqKi9
 xWYQv/4VoQYITSFmuZVTIlfczyw0xT3/0ZY5FfHd7NmVCi8Z3zPekgYzmDr5jDtExQgMB
 CDSzmclO+woUU4QDnBFbMUXHN/rT/wMAwtkZ1V5ChHR64WCcn9yCYNC1PnQUdb3Ab4hMW
 OIV4Ai0q9R90E8eT5/14GoEbmyOV7OKBgnNBoP6rH0UdSWc/WHCGLzqF29LaDOODC4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=TlVy+Jbu; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HBYufWo7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=TlVy+Jbu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HBYufWo7
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1DC0605D6
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:22:46 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6873iwnp2016841; Mon, 7 Sep 2026 01:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=boG2xl9h/fFKTP7lnp7bg2p5g5qJfFeTQiatA1fu+
 JU=; b=TlVy+Jbu8k1TIENQRMukmtlXlmySonGZQ//pGyCD27u/aTskrBWX6uUPE
 IWnypYQ6sxR/hYXFRzikYJscaUgokmOyeTqhp88PRbon0J6teu+JvQJzPGeH5oO4
 5uG41rEc/l4TEAlUOYeYdrak0WR5b6dK2yj6p2BrovFDh8VRT/Y8snQVDZdXltn/
 5UrOn5c682bcayvmcrePoVQTYOctb9ALfkdJsD8m8WduV02cSIOa1E4zaWEe+G8l
 giSrlXkKZabqru5zBktHZIPdVOolMN48xUmtHInTZcHVjAkwdsEfnJYfjQMjckaN
 VNYn+xFoMUbWZuOSYp6U2GtJB1dNQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh27q4429-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 01:22:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcpuRAvHpDEz+tJmTB+4o7WaKfacbbGXGXye6E5x9Wfgu3/txagJHFfwLR+UIIlKu/MGU1HqwUVnp95I0j2pLDXAlBdk3c6l+VaFTSTY+pUK7duVrzas6jednyduAGe3PdIPd8K5/gvs9TtWt/yriz8hIntOTVN9wB4EBYLY3QLkD7tcz1jh0hWdf0zJCi7PibjWrv198hK4Cc21gwLfhz7tk4wTpHrEmuoscMOT6pa0pblAQ8+qkjt0A5DyTzSgkSjeFy3pO5M6yoS1SRxrNSI1DM1WXFTec4MzWaRLfQGn6Eo9o1sItNWE+HhQYc9Tv3ui4Gu9yGeKt3Ko9Ly5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boG2xl9h/fFKTP7lnp7bg2p5g5qJfFeTQiatA1fu+JU=;
 b=Ilit94tZmElwWXKZ7xOVyjmxFwgPEWZ1pUYqIq3M1TZAVc+m73nqsIluN+bgs57rHQLgfxKtpEY+BH6zTDMQ18wBu6zghjdNU1OOB8eklD9YEfiFJmZqN0oN2NC3yFMRNro9NrRveN92mX+BYT/el0hWOLYH8qmVYj0vNSHw+fwmRZLfjeb0l2AP7RbGqq+gUZGwRiFKjxAX9NeCbNQ8IdGrj25TmeMqh2XecG4oxPzOr+dQ3GSnH6YBwgtWbbsdXyhTa46cuCfbr131FP9LB3JLfB0BVxOre1E3/OGWhYxsYUc38eUyYgFrBWDAZcPuOJXoeVnf9ri7hvPJsW5G/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boG2xl9h/fFKTP7lnp7bg2p5g5qJfFeTQiatA1fu+JU=;
 b=HBYufWo7Z0nsRabn+s/2hLQvj/sJ9I8xHLJvn2l8MFn0TtVzxLtJM+otfggf84nsLS8V0ujwkr6czKJ8WghqaP+ouxZPmxqQSw7L8/498dkoYSJ7qjGcWgYrJqcqQcpnpBkLRWncCUpHFP59T7Udfge30/HxNOaNdfui+bqNUi0=
Received: from PH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:5::17)
 by SA1PR10MB6639.namprd10.prod.outlook.com (2603:10b6:806:2b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 06:22:39 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::ad) by PH0PR07CA0012.outlook.office365.com
 (2603:10b6:510:5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 06:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:22:37 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 01:21:57 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 01:21:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 01:21:57 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6876LqqE4153281;
 Mon, 7 Sep 2026 01:21:53 -0500
Message-ID: <6438b592-dc18-46a0-9369-38a21be7fd78@ti.com>
Date: Mon, 7 Sep 2026 11:51:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/21] mach-k3: r5: common: introduce
 k3_deassert_ddr_ret()
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-8-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-8-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR10MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7589c4-4e4f-4e2b-c900-08df0ca8696d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: utVSFRhSdyjeTk4JvdlsSoHWx6gOs/u2kZ97Any/2KDfdvFJeVjsijDmg0B4ledJaaI2HmTlbsL60q4SZHsgUduo8t7DCZ4Hg0pY6zPhphly8WhXlSNlhCd7Hu1EuSmsHSc03vxloJNoNhvCi2Ey8n5/iRSVIK7FQ12PkBIsJI9kfAg2383x8KoTI6EXeQ8j96rougsRzrnsBDC9DULtwbpaeVoJ5xPahkK3uktxpH3tgYwxoJ5GSRLgdcNsUaKxWrOmIbNddiYP8LLNOArOcYmVWVmWFwNoH92iltHGaBSF4L3Z+p9U7Gf8GNHYZqsHuykePoEM5Mx1vERuRGuAJBWjKxeK/jD3R8sN0bSsSmOMI/gp81abB5yHmn4LZFQpoow0NbY43kjZy1WhwqvGKr6MoyrZ8/N5QMQQhLW1nWUgVpEoyaneUF2E/LOHeXMds115G8L7y8jIpkoQRIs8+OU8ewHMxBmjf/Hfm09d/rTCY+JT7L/0Le/F0l6uLO3t61AuiVZv0MB74uX2Zgopmv7xlngkCjb/LkHMxpjSEZEDAIGXb4JeBn5QaGf3URlSOSrx62f6zWSQMQsSQH5cAmApnDnsPel11KN5wPmE0R8HKRjuwFuQxsPQafZKR+DSG+G0bDLq6Ga2FamYQJV2MJ4beko/iBWH4rfXRXDtL79UxJFflAxUVSsjddj6woqFuOSzMnBiVHhbFaz4ssX6ag==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Ztkf/AYb4js15QBKBVq/oFJ0HD6rZhcv+P9ku+zMLaz8GFAU3ng4gzekY5fs1mWprdfgQadooahrnhYVlzxgMe3SOHuI/XTVf8XVVEEATi13LTDwMS+GrFL6Ap6O/duX+fABLloh5QH/kshooCL+DDDSj2+5E2xqzMQRljonnSidRzptCvMB4LyVNAutY3j/pWjNj0ALQaXTk4HnBzBrBgHbf2O0cGSZXJrMFGS6cFplSshwH5vXVcenNDDW+uc0R1uO/TpCQs3Y3nxeJ5VrKmWLVQXRYLWG5+ymYAIlgR2vkS/h/H98dH6RN/q5dreflEp+rMfg9fKwS4W2erNbg/lBGqEZ8h/Xq7TlfW6fxeDItqG4DpI523IfpShMH/CHX/pfa4h54JsH7yW0t1MsFLs8f1BAv1NqVZi4eK5c4y2N7jr+ZDFSqDq4gk8rUSd
X-Exchange-RoutingPolicyChecked: 23cUlpJz+iNg2YrdYaWRF+lEIyj5g2wv72ERG4poqNBO6B5LYBVeq1MaJQiYXU76ynwv98yTbYz/0ouo5ix8SzMQC7vdyzrzxneix6ANtP1qGGcAN6ykjiDS9NRKMovarKhUlgJt+z8UUbuLX2SMhOWJ8C/0qEuwcB/sKDVMO6AZruSM+MUhBQd5rYk11szbfyZ73k8LFngZjHSuX6NQ8WDivB8HWX8BD/3pXV1V7AO7CMVTJ4aOU07Z1WlvENKHqsfCc9NDcdMPw5i2jf1qq7I73Uq2GQZfIngwz/sKagtN4AH3JfdeHQYxc6iuFzGYRF5k6e1F/jx6QqCZPcN/kQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:22:37.1912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7589c4-4e4f-4e2b-c900-08df0ca8696d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6639
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA2NiBTYWx0ZWRfX2h1PQnZvNRUl
 qUSNbs33un3EM93zkaH0Fhp9oSO5AlgT+LkpBM6n4mDQnt6F3OWo0cOCL9YeaeBpSrsei1ctPGy
 WEouQBxWTDmW+KL+g/CSvrecLYCaJcStS4lYiigLxrMoa6ehav/9T7A6CYx+9Y2z1sxACcw975K
 jWADkueDDB7cr1QG0wq04iC7suepMSH4m8v7PWne3FYHIG9D0hvwXiTxe482eylKr9zlf9GBIzt
 BucaCV4s6vYzeRHWg9fGqTZftHYbgU3egoiRAUFooT/3D7C8mcqGyqMXwY4quKuIGSsDkpXwzIb
 r9+TgCMOs9GimuYPMsFuHkaN71KukJB5xDKr3rKuMKbWwB6yPqb3x0hps4dnfKR8+uHZl3x9rG0
 cpPLvWSK4hiSO6Yrxb1J9f2J6SlFke874O2lIetUQcrUitXS+EWUyz7Xm6dy2ZEkrbM0hlFYbYP
 K2TeBwkvGc0Z0IYix7g==
X-Proofpoint-GUID: d_wi6hg9PHZ5D2xQT0KYlsXcsZgDfpMY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA2NiBTYWx0ZWRfX7AG9RptNoESl
 RcyL8qGHoH21/c2fR+WRGj+6mjMHcvim7jKulSAMk7cNqa+B7XVyn0rarfT2eaDhQj6Q/k1TijU
 k7KOdLM+OMht1vbQTaTviPQojGc5K70=
X-Authority-Analysis: v=2.4 cv=e/82j6p/ c=1 sm=1 tr=0 ts=6a9e5832 cx=c_pps
 a=+ZJ6xWA4Xs4q+gTfm6sIbw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=ITAC2O0bFtFOHSqH4-EA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: d_wi6hg9PHZ5D2xQT0KYlsXcsZgDfpMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070066
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> Deasserting DDR retention pin is quite similar from J7200, J784s4,
> J721e, and j721s2 SoCs.
> 

Please drop J721E from commit message, with this change

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> Instead of duplicating almost the same code, add it in lpm-common.c.
> 
> NB: On J7200, there's a latch, so the clock needs to be toggled.
> 
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/lpm-common.h    |  2 ++
>  arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
> index 83e0fdcca6ca..7dbe72ce129e 100644
> --- a/arch/arm/mach-k3/lpm-common.h
> +++ b/arch/arm/mach-k3/lpm-common.h
> @@ -11,6 +11,8 @@
>  
>  void __noreturn do_resume(void);
>  void lpm_process(void);
> +void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
> +			 unsigned int ddr_ret_clk, bool toggle);
>  void k3_set_lpm_core_bus_node_path(const char *node_path);
>  void k3_set_lpm_core_compatible(const char *compatible);
>  
> diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
> index c1a8c8e940de..ab39ea0cd67d 100644
> --- a/arch/arm/mach-k3/r5/lpm-common.c
> +++ b/arch/arm/mach-k3/r5/lpm-common.c
> @@ -41,6 +41,33 @@ struct lpm_addr_info {
>  /* This is used by J722s */
>  __weak void ctrl_mmr_unlock(void) { }
>  
> +#define GPIO_OUT_1 0x3D
> +void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
> +			 unsigned int ddr_ret_clk, bool toggle)
> +{
> +	struct udevice *pmic;
> +	int regval;
> +	int err;
> +
> +	err = uclass_get_device_by_name(UCLASS_PMIC, pmic_name, &pmic);
> +	if (err) {
> +		printf("Getting %s init failed: %d\n", pmic_name, err);
> +		return;
> +	}
> +
> +	/* Set DDR_RET Signal Low on PMIC */
> +	regval = pmic_reg_read(pmic, GPIO_OUT_1) & ~ddr_ret_val;
> +	pmic_reg_write(pmic, GPIO_OUT_1, regval);
> +
> +	if (toggle) {
> +		/* Now toggle the CLK of the latch for DDR retention */
> +		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
> +		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
> +		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
> +		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
> +	}
> +}
> +
>  /* in board_init_f(), there's no BSS, so we can't use global/static variables */
>  bool j7xx_board_is_resuming(void)
>  {

