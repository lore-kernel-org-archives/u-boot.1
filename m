Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69B606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ta9lbdi3;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QiBUfN42
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56C8560604;
	Mon, 26 Oct 2026 08:14:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MN4eRk_Txl0w; Mon, 26 Oct 2026 08:14:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B0326060C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002494;
	b=cdVkcVYVkbYku4BYl8DJGf0dCQGeHi65BR2wUKkoIX46S0/nTnrP3p2Bp7zxadiU1c/N
	 LR/a/NC59V7DCDl8JsWSRYkl19OS/5LsjeA+8VkyaH4nOF7i665gE+UyyOVgQjsf46psY
	 BRELwr84HktkTy9/hrk351PVraLMBh8uoDYwo1wADn8h6MXbIjfKYs0crnMP2TxIN93F+
	 cl0qCLWRBccbc1rIS4jUTn3JG+/4t29Xx4My9+dOrnavSB0QhPhrBLE2BcJolHomzeKkd
	 adW373QlaPn+8v4zRz86LCArvBmGRWx9XwJgPgOWq2Bu9vWt/qey6enZ/nbZJ00RC2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BYzDgrIefQC2BANDTHDhlrbf5NQ+7XDZOQLddwmsZZo=;
	b=VHxo20fvAItRy/ckfgn3/6+PYAWGo98a9flU6nBCFahPw6q+KXwwPSaw6ogs3rh6Xvlr
	 mpbR6APHpFH94oxWJ+xfNlwwn4+GdPiO/AOTLEBtxbp80XtqlDlW8MJfx+BJITRAFahrw
	 8nLVfecNafx54O5o6QSP1TLnClZFISMHova+nTCQsjpjP1nt+hU4MjoJKzUXFYLqpVUC/
	 PFVhFHEm71AntLetuwuetwPBF/lpc69O4UCrfnCE9Gm1Ir3KAcxGibVBbGaNcl2dg+1lL
	 6lYNvhZf/ZA4v9LArSEFvaPVN8gfj0TqT367nRnB1qTtyGrZ9LdTjT+U7M2AWufBNAg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QiBUfN42;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002494;
	bh=BYzDgrIefQC2BANDTHDhlrbf5NQ+7XDZOQLddwmsZZo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ta9lbdi3vadpFIDIGz/VYtRziF0Gzti/s3SNZcbsa76Z6txzqR/8MiAnqD1qJWcug
	 99erZ4DnmVaHJeTUzDlubCyC6FnjJk3kfEXUo2dCud37tVkxfC6h8UxJty4Ea6p0cq
	 VRIHTKAFMc8qaFqe6lB/MJnEw0Yr3HjGwaNaAiFbk84fD6C4cQ9PQCXFUWpFbMMGA4
	 ZTyzNi9HYjR+pOa3/Kc/wL6wWFCQKAOyiR9cTgDy6HuQxsacloRVO0tlAm08RCFupS
	 PkvRRz7r2F6PTE1GcAJ7ScNVAYRU4u2nF9j8HuTOpOyzXlYJv//qK3UuUqGQqQYeyr
	 zovxwSCeBOSeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B0326060C;
	Mon, 26 Oct 2026 08:14:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 017E5380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F31196060C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lA01PBs-AXGe for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4096560604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002492;
 b=R0St4Xv6gKODMGdDYympOIKDg/lriNLleB+JvOi0uhimoyDQ1vsOOFW/VXFfzIhrNOUG
 AvYaAQvAR5nYyV++BKX+haZAZohf37682u9ZZGZvQscioBLXH81m+5ijPnU+AVXWwD2AS
 /8AbzZMbq5zsmC86OJmCq1kICx4isaw2pQkQHrGEuOCpN1YxeG0ZGQok586fzXUFOBfmJ
 bdKk+h8AXwxRtcdj34v6IqcciN/8EA0DUSecFDCnVj7Eeb51VH/zjipB7mf0A/2UBdaCh
 OJ0yI4IkaMkzmg/ldR5Qs1Hbw2Z7QfIOKn7ABCyvOO5DqOwD6URV7BunLqjCFEwTSjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002492;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=BYzDgrIefQC2BANDTHDhlrbf5NQ+7XDZOQLddwmsZZo=;
 b=NWjogMf9KkjDuHptY/il/5749/BRbsoqzcVTWJwn9tG1/C7J8LIIqQ/QRjBaL5WcrLuh
 uYA7OTqMsmsWZHAc6vu96Gqor5aHnSNeSzCY9lm2RK+5pVmUy/0b+nOMkmSPP6Zq6uUZV
 +vDNfXuXNTGg5pVqrdiOlBpHd4xzMSJRlQgKXGIu78dJJP+EXbZ3mtCR3te3RQuk084jG
 8qaLEZuomGXMD7VD6X9/Mq+f/sD0Qeqyu0NUItYNA9lGkpABqGu17MPdA19EG1DymMia6
 dIFq6j9u+w/voQKQ58CyLd92+yzRrbgpRSH0y2KGEz21560yN8hLjx9WjAVriW6CmWA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QiBUfN42; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QiBUfN42
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4096560604
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPbjbT4LeQ7fH2zZWGClx5D3jwcS1/ZZI2GPVGttX06Dx63CYGVfRTsKTlLLKts+3WwY11jcmgT3/2Fgk97ARQ7ZIbDiQo0l9xeCeG3hBYoAOnYuTqtfL7kenSWY5U1+3O1veJ/kahNo1Q8YF0OPh1ZrcqDU1v2yTmk8nuTVnvZEWS1lFNSMWqOPTpun8DZR3d3k0kImKtdcwu0A/Y5Wqs0+y3ZwYiwYwe3orufOQGybh9PyPpCZaURpJfFNziNH0xGNy4nTLtqhSEJCEUmI1ITHaI9G4dGxGmwcjM9XgxmRwr3p4jrtyIoCSRHnKwgAIrW+rPfqlP8mkFEQ8bFYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYzDgrIefQC2BANDTHDhlrbf5NQ+7XDZOQLddwmsZZo=;
 b=EAmPZaZo3tJP9vDdGc82AkCCFAju8THFaz3YboIBhlkehbIVPzuARXZ9vMD1tdQr74hcKk++bkkAS3HKU296RK4fb5EYa+i9VQUb7ePe8mogOMRO/TArlVP1R072JUSLxDpN2wW0rU7oybcH5NtcsfTlaXO/2pmB1NRiwTdXUSlIA4aDTKSmVBCZj2dWt1VlxSN3TLQP1PRnYzNYnluXm8neY8yK/LEqXPE91F1OpncEUQiHEELr8oKyIJgLZLB1yK3E2rRYIE2Vc6oYdJP+VpfNj1BgG1GGAg/5zy/AOQTZh4gDKfVgxF+PiiqsnkCEzq+VU/eC3uVC4BEYKZTnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYzDgrIefQC2BANDTHDhlrbf5NQ+7XDZOQLddwmsZZo=;
 b=QiBUfN42LqKBKswzOvB5argxYJ5zGx7tyMSQrAnN78LTScYC8D40OlqQpf4JdyPFe/bZDLifNSbrVihg5QNcbJ1hkEh8fInfsX9bvQYx8DY7aPQpVym4ohkJFtw9l6IHsUr8dhN5cgyp+VRfs1dPW1pUpFK6if+vWvNsEHo9tvA=
Received: from CH2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:610:53::29)
 by DS3PR12MB524383.namprd12.prod.outlook.com (2603:10b6:8:608::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:49 +0000
Received: from DS4PEPF000001C0.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::31) by CH2PR17CA0019.outlook.office365.com
 (2603:10b6:610:53::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C0.mail.protection.outlook.com (10.167.23.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Mon, 26 Oct 2026 08:14:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:48 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:47 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/11] xilinx: mbv: Disable SPL raw image support
Date: Mon, 26 Oct 2026 09:13:50 +0100
Message-ID: <570f5e65a956faec154aab717a9c3d4cd23a68da.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Ro/SquzVVQTzw19yJ7KAIoENV49lFavZOzegrD2uOCo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd5z7MUrCqcq3XxmLuZb8b+YPeWe7QDZ3iubx8a+0c5
 vfXD/1Z0VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATeSPKyHA35chvTk1vl+uc
 Kq+dG6ennHm332Cz4gc75tIcWc7wQ18ZGfp7T2TeWabI+LnF7XJX29reOc3M/U8uNMROj2T9umH
 ZPT4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C0:EE_|DS3PR12MB524383:EE_
X-MS-Office365-Filtering-Correlation-Id: 231f516a-724d-43ba-998e-08df3339345d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261022115727099003|261022075727099003|261021121427099003|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: GIuT2zfUtn4CYkewx+pdAE6GYG31dGSa/tYoQqqA6bWgEXBeIBaw/siLYyA6EHyxu+wF/fVOGmhfAyPeAdlqCnBp3+qL4JUBB9EBbXdbB9HvQitlbgQ+BGlN/BgBAeBpCCO6e/znUgqnLUgEMqupKPIjI94V9GZe1E0/4INgwiLVnOzEWWNORHROhXiAByjM9A0bsEcMojfa//Rj5nOJN3ULiRgRYN3nrp3bmGJjwTbmjljM8DQBzckPrgdMxNIp/+lcvQ8tLapWC6sOzC8O8wliW+8GNGR7p+eXbpb/WE2ykwPnej2HdLh6KY1qi/YIPn51R4OMnhrmMWy4VfSmOy0x2+MwVzgSJGijqO6W/ETc7ulxbq+FBlYnHupzXDZn6P1F2CBwUIy/7f0zBAZFLQ+KpnvNv1Aq2/qI8dBIppx4KBekM49JhJWak3iqRkZpXcUKjzA8koA5QmTW+K6QcH7ZAv4qGigLhdNm6rcCWj8dbsn5DDs9B07TPxU4/w2YofJyvzVNlc0vTfwOb6AqrW3HgTJES/jP+amgo55ri6EYlKpwKUlsXIUjEW+vGIgEBrStr1P5anUgxfpnGKLnOJiAq2M0DIRyhc0tdTMOc7tAqNbeakm18IZGwoHbi+vnjBohSMI4ivxmLt0xWGWd5/M76NcA1ZrZXmKDF64QMbJ6fAPxh6p1miQaEJhYs65hQnnViW7jU+w78k9GCgLmRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KStKUrtZupg3CkTUPS5M0+YN3fGcLgpwCPqVnil6bfQtv1WH6mn9IICcvFhvIYmlm2E6rgjwzmsKOKvVllph5gLpkH7rfGy04RNDQE/CDw/6lbeqEEJNMB+dzfZ1xs+E1n7u7+AL8BYtEKTDec9c1cFiixn1/pz4U+73t7hJ+atqqaXVU3PctxRwF7d71h0yCjf+4r62ckZPjtgLUcbvrVL21+OmfOrNnsn8IM/TZ5WVjOZuRM9rXlhxs/GXkt/E783XksgsKG0EHlmJdxWrqqjp+oxdc/mNb0VffQpCsK+qpca7lznhqSBmVY8stm4U9YNdSeY3+40B/KzFjitH+rjcZOSRskVSwQOSUYSYgzf5ULQ8pl/R0znLyOytfaHurfsbwC0z/aHG0mCsFfXW5RxSeUZNpPkYp9SpzByScqu9NRKIk3HqwYMB6OdrkvXG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:49.3863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 231f516a-724d-43ba-998e-08df3339345d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB524383
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Padmarao Begari <padmarao.begari@amd.com>

When there is no valid image in SPI flash, SPL falls back to raw
image mode, copies the flash contents to CONFIG_TEXT_BASE, and
jumps there, causing an illegal instruction exception.

Disable raw image support so that a missing SPI image returns an
error and allows SPL to fall back to the next boot device.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index fd12e25150fb..712194c6b433 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -37,6 +37,7 @@ CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
 # CONFIG_BOARD_LATE_INIT is not set
 CONFIG_SPL_MAX_SIZE=0xf000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x8C000000
-- 
2.43.0

