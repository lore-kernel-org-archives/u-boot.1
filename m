Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F209CD98F0
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 04:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B6B849E4;
	Tue, 23 Jun 2026 06:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FX10bc2h";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="syN/DL+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A301849E4; Tue, 23 Jun 2026 06:59:06 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6D8849D2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0mSMk296979; Mon, 22 Jun 2026 23:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=d4eNOpwAQiRKtuBwxZJkh4xCYQp+tNhUrDLHHHr6C
 dE=; b=FX10bc2hxPcUhacX4+6ZIcfSNTsHDTTHyiZREvCljD0lpP7VnoQ6nz9bb
 NgQlAKvp8oczgRDTB+UHrfJbGrULnPpBeCc78sIpZb/hqQqnTP6k9BkDTRcCQ79j
 pQwcLeA3vqLl8a0DDhR7nz1W6Plug7uxpQtNYW6IHUq5fkIWfuQrFHw7RtbR/wdY
 Gpdk31C7d5UnGxHVtLWcZJ0dfz1lGOp3dsuUDAhnpEVnU8IgMpnGQAPfeY3FdHen
 RYu6WY0HVRrqgYleETgpVuiqb/GR//wb711mGChyER6UwUMq0cKZ7Z7fXNJEYQ74
 pzBozgjdJ/N0NuglD06WlWhkombKg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ey43bn7wh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 23:59:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOimYGTFTH7e69kX9ZnU93TRJF1rvGSrn4HYYntMEaQzdKvBFlb/+CqRdQKhIN8kjC+3Dai+lJsyBSLAGaKBZgrtgY3BJIDiTTEsH/XgCHvyssynUDJo6jOgHBSTApl0H2vdIMbHU2nL5ye2i+QMqDPfweSGW+Wp6KsR1hCMStvdhksBdminXmjPCWFhbFiO2ZFwaqcwxAlD+X3p+lt+/W5z0opHRmUwqpuFJCeeQSaLkWupmYb97PEjftgNfr411s5JgM2ILLURpoKtlYdO66wBJHl76oOSPxNE98WQbd5bfb7HOtONmQHtEg2FxO3+TgXC8SIAVXbze5v53LO+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4eNOpwAQiRKtuBwxZJkh4xCYQp+tNhUrDLHHHr6CdE=;
 b=OdL2FLqtQUB7758y4oaCdZ9aRCHG0Zoh05q6XroqRRKQ9O53LSnieIj5ptI52bYiR8RZqxwEC7u1kTMQH/hbkuLASWg5qnrNzvnaZlEl7xrkmhcKCtEkc504/GlSfygzvJW6NqhuZd3Ev1d20q7hYA6QY1K7VLzYadtQduk1P80rckJ9NBunJkFhEeIPxEavXNSXU6/YBbMT0wheQdjho7XMfCBVWvoMZ6a5ZDlK58jl5vH2nfc1ubi3KAVYiVgfMFkKMcf9PpvAbXFpFg2ppZ0ftrwef+SS1iQPv5pq7kNXB+xjDpqVWJW3jRUZfG5g7MmVRj18uC1ovzbVLD0Ylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4eNOpwAQiRKtuBwxZJkh4xCYQp+tNhUrDLHHHr6CdE=;
 b=syN/DL+7hcu0q1GRY/ieIhGaybmtGW6X374lkACquAyDSqn4mKGcvs1DF+5C5akvIivdkXGbZgIC+Lv5KX/e8eFwcED+Oz9K/3idJ0hgAknB8IMvxb/SqbULXTetA7BIAv/PX47L5WrwiCV8l8sUg+jF7hLIMkob1yaeBTZ+UMs=
Received: from PH2PEPF0000385C.namprd17.prod.outlook.com (2603:10b6:518:1::6a)
 by DS7PR10MB5951.namprd10.prod.outlook.com (2603:10b6:8:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 04:58:58 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH2PEPF0000385C.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 04:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 04:58:57 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:57 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 22 Jun 2026 23:58:57 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N4wt8P2083522;
 Mon, 22 Jun 2026 23:58:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/4] arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for
 AM62D2
From: Anshul Dalal <anshuld@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>
In-Reply-To: <20260609181006.460401-3-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <20260609181006.460401-3-p-bhagat@ti.com>
Date: Tue, 23 Jun 2026 10:28:49 +0530
Message-ID: <178219072991.1099376.14818652164726228126.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782190731; l=270;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=xuKJJXpddACiXtFuCLR2YmbQbz7mU9nfDLg2wcwDha8=;
 b=Wh39JJrO1pIT6mV6C79+nKAllVJI9Oe1RTj7ulImsqbTl6hULMdsoNelVf43cz5rmlZPhx4LW
 moh2gE9fx2mAfzhuW5viCEuPIhdJEq95fhZ9QPENNqTwIqjPeoEs11k
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS7PR10MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da48356-df67-4e52-7cfc-08ded0e42217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: pytslFOXSzjf64fo+U3NrZd9IPdTQEC1eUWmJtj++Ky+/1UHr5iVI2w4qedMfergCr/HmVRVcjKjoCRYf4cr9GiXHWH7umRqKJg7NkbpUhi6FFeTOdKbHGyKn9+2VwQdHIWMKp2tK1Ll3ldK66r0v6bl5YY5pbTa48dmozrQUaEooOOszze2hWrvtc5HyZQEPJv1tGAMuI3+xURT4Y5HmAniWxMMyxCi3sBNnx5Vb8L61RnybjhdzbgIUCj5ylzkXNV32MxLt7YFs3ilPbv/yPdKmnlWkBFbngj4lTqwhzHK04jkswzFg5HnIbH+liHOvBYxHMTHaxMh5+yMAy9lqjk/+kVn0InbqGJ1HEpCthPU+YMvOUo51eixsd5yNDwnQZPOEg559pC7jkkGCNdlw0qfPf9/0cSmB9p1++CPtjXBYudLdolXaV1xLffRN29vz07jX/3AK2p0KFrYRQy574236wjS0Fs5MZI452+VemV2R/Hf0mLCvhZXsDVJ1uyYs7d42I/d3nisbM+vp5bgaZD/OHZKM2rAYfCi21h0rCMnpf1UJu78A74k42bLzMx54YNCjsm/wiGUaHDF4p5my4QaQRSdOCRve4Hgg1ok5gqrrdCuDUfxITmt7AyUdqaSZl2InodFlgVoPcmzb5pmoCv8mtRcGVzesW/17mGsOQUwSrvJmPWdb5l2xxr3BPfcfI5GiBqZe1u+ODqs0Q1xhw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rHnBHpl9GAWvVNpLTU4xeXdV6+GL+ElADALjWF2hwUuujVcKd1hkDGJJdIUrwIZW8/WnSbi5kJ/hLC8bqtULXHgxaNFQ0cT7TQ/3m/lha6VWQ+vMlJr7rFkcjKTyEHIfqBqWD2jYUqhe3YBgSNerBljwX8TqkhgqgNU+EtGiSox6y2jNuOUmmQxIvKyKMy8BfBeJj7LEFbAnoBwPoka8gzpzFI/aYRaSR60fJ0gahgpFe2UUPwAAUCJRxiE8a40b5KN3ai6hoKDTGAWGODfeZKhWk2zsxbG88E0vltCKrrXIFRe4c5Mx0DpQVvhsJaHZt2mf+r1KeZ3if9Stta8J6NWJxeBf5r3GGjpOL79ceGECcvGwEQe2jk7zkkeyCCsNMZ6Ptr29hXbl03ZbdML6auxdReBQBSGpzkkbIUuXhSrviiR8UHvjsUfo0KJg01lk
X-Exchange-RoutingPolicyChecked: g99lIdxyzy4qtfHuwbrgznwXcgZSjmZ4VuX183Gm6GNVFM4ksquxmQyHrPqnKDAxdIHJhevcZOvdG69NJmjs1mDG4F7LSuHPT1dezJHVfc3MTzV/BCpRtmSxC81zzHyoxtYj22XvqQYuYTPST9TXS5k4Wrjx42uVwH9Jr6Tj4a5ffDV0cT9URnQTrh3xhU6saAdAvA40Zi2G00s1vdLgW4S7TjcKcXzzxB/tWZ20eMhw2MZOH954bZsy1TXM1lgCSKw0JIoJQwcB1CWE7CoJ+uDK7JQwBMFbHMYM4yLVJ4YCmqq+aCMhfNERFeGatMbxku6qi9iiFgJqaFd41nhyZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:58:57.5406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da48356-df67-4e52-7cfc-08ded0e42217
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5951
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX8AjaR5sG4Jk/
 MeoUXFwX7oQV0Pf4X62pdTstXZy9lReBTJIuCDdPCWAYhSh1iFwYgI0uWOdbF0o0fody6wO7P4q
 CAOD1u7gDFuN2CVVUST6PAWQ2rlPRFk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX5ak16l7h5AeE
 WnZDWZiKWyrocbsf9QTC61bSdu/EH2aL58u3Pw8vQyhwCfzu2sMIdzoPKioTp7oxLo8GTgbdbrw
 hzPBtwko84Wl0DJ3goIEqejYaKuxE5gmjegx7TqPnzp0syflWS6rjFAjpOtTPiDYIvfvTePan0C
 P416EoNWm5OYjzdFZiKhRPUMaET+znSxBCAhsiQ5ORbOo+g6Pjkenok40w0WbUcNVOV8/7Wi+JW
 NOzKGNAZ/clhbePoQxnvrO5QkOqQFGVDamKq0BC7TAmvD/NO+Ogb0LihSzEnxi+iSHV1rOMhh5c
 vHgzO0UpG4Iv+Yktrv89pk6P0fsFYVwMjJZaW812AN80xckkrc1xl+sH1RvaehnRxvCPgUzhZBs
 vBnlT++BF9vf/aV9ea1hHKxx9Y1pJBiJBhw29h4VESZ+WJkKMHd2BWR8UadNkJq9LhfFFaC/OoJ
 67TjLUHTy6IQ+ucHBEw==
X-Authority-Analysis: v=2.4 cv=TPl1jVla c=1 sm=1 tr=0 ts=6a3a1295 cx=c_pps
 a=WaebrhBVOVZn7IYqRlctMQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=snwy_YDMnN-wGQhtr7AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ar2VHec9aFlP5xZk14IFMpxrYsGICgBj
X-Proofpoint-GUID: ar2VHec9aFlP5xZk14IFMpxrYsGICgBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230037
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 09 Jun 2026 23:40:04 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
> Enable OF_SYSTEM_SETUP for AM62D2 to ensure FDT fixups are applied to
> the dtb before passing to kernel.

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
