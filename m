Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B9606B661
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X3LF4zW/;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fdyTXhZP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 129A340873;
	Tue, 20 Oct 2026 13:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQY2vB66w2N3; Tue, 20 Oct 2026 13:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E4FE40847
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504176;
	b=L2cstOSVqTFGUK9JmK6EDoiVoLRaZLaKJss2h0NPW70lanGkat2c9NU4zBgZ8USt+EIN
	 ONYYdwqIwDSqEQfd92gYRP/M94VHLib12ducTp1pYMc+Iyrm8PlLOEunwodffeTn3YgSv
	 cKzdVUAYteve3fE557i9Uo9Ws4Z7D8f3TddI0Zta3AGmOzyVEGx6JS9ghJyrlMr/Lveq7
	 +uzmqlEjtNqksV+7K5io8rGEufXp95HzjeAByP5uhsJW5SZ6YHALMj7c2eiMlVdKlMu/H
	 8DnxmrDEh1Pt/SGmTtDhsAgj4v/oPRbVY9mggM0Ellg87zWqMSst3FLLXPYsdXl33Og==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=IWX/24jp9oUIL7DHDAIFVMichwAaBbBbAEw1dxR669A=;
	b=PLWn+sQpJ/bJthb8gC2L9fVxDSB8aES0EGk6URIJVwW8NQNJ/247f9ud1k6cEeRLrQg8
	 XTBfVxwdcYvtlstl1qfwfBfz5MXubuSFFhdCf9kZUbF1WYWp5NfwvqdjhBbGic3bBbwUY
	 qEOWveDNzXIqdo8o+1E+U9GG6kvYicRs65C6ZbusYcipBGyzc3YSaNnGJZyV99RxvK8uQ
	 tHyEYWUimFJAiOvnEB4Zr9A9tLdS+vRcIqAEKEF3p9CrY1vJcfJYHfQ7Gxd8p5wphP8v9
	 UQAq2CljjWqcYZCrf7X1b5vjEF0soxqfOppw8b5c2ZAWEWlhDDZoivZxuQrokcWRTUA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504176;
	bh=IWX/24jp9oUIL7DHDAIFVMichwAaBbBbAEw1dxR669A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3LF4zW/7HdKuTpmn0X8vPfelsAJL281B3llgleQVw+7CgaJugTttM/XsM5kNkw3b
	 BrYU6Qx+hiIuexsoVL5nYETsXgqAQrkVvMX+nTF6OFfnEKCVKIPvbwztdfkq8VAK4A
	 Uhimcj0+uPqmKVgJss1kqHhqyhU9RNDjIfYD7/Ig+xc7xXFdolbCrn0DgfMpNRHgHk
	 ccx3qvcxxC6G86hAhhLNhzmjjavEIwgxdIDz5tbPmVJlRVCU1TXge9PsUYjCLn0mSK
	 rpmGzb1J6Ko1L8HRfDKeDMD5/lknQCeqCCq9Lx8bOv7Eg16zIEbTWS8HILRAm4Pi3U
	 q65rdaHPOJzdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E4FE40847;
	Tue, 20 Oct 2026 13:49:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24C541E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1680860826
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bXA1iYLq4Xj4 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:49:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC1FE6076C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504174;
 b=bU9LJbsSoBTcDEAf8QEsc94M3IVV6WJ1w5gOobvtlFl1xzpFbVw0rdheJtsxGp6AnptX
 coD/wQkTyCWDjRk5kdgErBBx8ketNsrxO6wNtllZMxEodj0sBC6BWost3PB8iC2AK+twM
 1csexvVFZo46ex7pfXCglhgTRH6cykk+kn82YW3XB0+GOdAQ1ttFlPu72El7NQmMcDzGN
 5UwUPIpKXNn0OwHX8TNDgpHUb6v2SmMSNKLWWJ/531FOUCD04hKQxsmQmuG9DU3AOxLbQ
 t5OJLDZZtXhba14wU7cPDvz2N/Uv+sYgKAfMU9gCSGpynv8Ci0MtkFfPlbZNTh/1bPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504174;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=IWX/24jp9oUIL7DHDAIFVMichwAaBbBbAEw1dxR669A=;
 b=YVi3dvXTIO1elE6CBWPQE3RRIMIPCxXVnJbFoetEeKEHnMfQzCX3iOudBWlpRaCPLZR1
 GIKp9qddeMxhFLkhRElKa0vTTNUs4lVJ9I/3A5dKn+nOXA5fYBzh44aJvU2uE9THUm6yt
 PfcljAtCC98aE37XxuDIws5QbQsVwUw6gsgtbZ+NDbQJwb49e2XXoIYnKb0xGTReacfYb
 PX/aRW5pwBf5JZ+EE81bixNZi30Y1vfVabkQOoWSjd9DNv9z9dd6gzGN7NZwulu+krZJ2
 mJyb03nmhzGhqLv6T4ZI/gXu4Hi96KCseRD3N1N9U4IJrNtOMXM8wfIwOH5jqNA6y0Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fdyTXhZP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fdyTXhZP
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC1FE6076C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jumpiCRKvoyHPSlmXnIur742igJOMiSxaS2ePyrx//7banCWXWKQvlykoiOrE/KD4jdoelBVc79oSNYJz1y6e6YzgtfFMc0ToIbFmeH4ak65B1D2oAv4V7qPkHonX90139DigSfad40xG2eb6LB5+QU7eErlW9BRoM2G8X/hegRmeMOYKE3YiyvQaAKRXaxLdUP3P0clzkcec7c80AWNf5m/7j9nmP/LK2b6F//Ze0FSpHZJOCvlDpJo5KXyI40ChOC5S2+MRtEq6evvFKmsdQP+JAEij7MaxrkjFzy2tDVnIOlX1hN5eziQ67578bssV4hbfW1ej9amXUYVvq/bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWX/24jp9oUIL7DHDAIFVMichwAaBbBbAEw1dxR669A=;
 b=J69pJkHvFpR46RH42bYZusM/1e2d2EYldoMDemH38aunhuz749hEkrl0f5Xni71e4TEy5q6FPEBx+T/o8iomt/ZFwULWOLNQTbRWZN61Q7ptqdRjPicCN8i93KUn49qLvhBZ5EPCOedZ7AXoS70io2PPCA1hXd63l/nqZywC1fnh9dyEwMJVYbIaTQSY5/eVILx+gVTt7iMuhqaI5JNmm/pss5lTwLQi0zVZ2qaqppmdc+GYz5AJwEP4A12BMxkC+6dud3+32D46EEqQDp8eWHw/Y9iXRFvMH5AnzUCrl1b3ecmm4l/zX2X7k0lYCNghiemtaoC4DzIRb1H8aQdJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWX/24jp9oUIL7DHDAIFVMichwAaBbBbAEw1dxR669A=;
 b=fdyTXhZPbNobWDb2B1URoNZgdfMpjhg9OYHIqUJoO5gHj/cam2CmOqQgH3fppnBxw/PsGhPM7qwP7hjGaGE1YNTVOroJuTwnd7EhiE07envCvp4D5My94OE2rP5D8YdM3ipPMjVqi5QZ02kShdMq+Y4XvtxLPhrhIx6Bh11QVyA=
Received: from MN2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:208:234::12)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:49:29 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::15) by MN2PR16CA0043.outlook.office365.com
 (2603:10b6:208:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 13:49:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:49:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:49:27 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:49:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Suraj Kakade <suraj.hanumantkakade@amd.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] fpga: zynqpl: use actread for bitstream scan in
 zynq_loadfs
Date: Tue, 20 Oct 2026 15:49:06 +0200
Message-ID: <f99817cfd0358f751574816d6d93efc5ffc2d57c.1792504143.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504143.git.michal.simek@amd.com>
References: <cover.1792504143.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=t1p7iitLjDoORdGO9CxlbKZV6h8cMDk1my+78we9hk4=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGrXcVmiQrBjI0M8A/jKI4isjHgZv0TPtOGCnHoJpJApHUBLQ
 oh1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmrXcVkACgkQqwf+8E71EfUfvgD+PB+2
 amAElvPsrh4UlCXo3Md1HqDMKOWWVLk5uHYvACEA/iMw/cn+9TrwJ/OPr+DNlM5/uiDy7MnwvWI
 JNFKc7hkI
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c9cc8d-a3e7-4e1c-9be9-08df2eb0f62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5Woknlim7QhCk6gokaiPOFXMeNeANmy8oAHpjGJNxqZX3hxwSdBznWNqboiu6BwU0ObpmGaJd5KS4VI54/LQvJYvYPRZzokfjALDqEKv7zvWUxnz284fVzjZm1ZGWvmZRszrRYKbO9ZY96gP/XO4eODND2FEgO7guQeKyMk3p7jQZtth2JB1+w3ePYJpOTbs1QN/gaLD1426DnYRjeEvzkEes6OoJgp5ln2+v1KsEpmzD/zg64eiGaTKI04UwEdDxWlrTRa9Wd9GnTIzrRprsFBoI9Of6TpqeVnCF8Rfs8TKMG404OZlcL4IT3deFIvzXiYc+qo3ji8XyxXV0SQDDVlb5NoqNs4tNtAXYtBquoufW5GRX0cYxwP2G+/lGcSLrxrkoj0VcmUw4YaylL0QcsKWg6SfmBQLilAvCYDfRCuWxOKND/bGISNrcaxV2YUPT2RyRJ+UkNxd0pCAZyeewFacTmNmfSZwLuohhu3yvQj82AMg71UCUnn9wUQ0W9Jkba4KWTwk6E3Mg9ddcwLO5X6ruGx/xAww1A9+IuH2qt9I+yzN0xV2YeBS2+okFOvSQYnp7SMMqwLC0JQ++a3r6jCYG6Lp5MuqGe034C2rI/bsaebQ3BawYonrkYKK+3NQsXvsLiiCZSllV5ONSG+ll4YKffppqil0pnHlrUpH/0ZBZp4Csdonl0zrrVugeIZLam9qOuDATZXfNVlzaxHS2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AF7iEHYW+RdL3+62gjjrfs9/jsWitarVqEmmfQxtZyeJopllOu22FKscNK2iEyr5ULNQOrdAC9vyWr3RcKnPR4psT+NxiFdguiQQW8cW/cRyM7JYOz0W9IBwAfL8G7aJSGwA7VB5zY6YImpBrm5JxvzmQaCJAZmmN8yJ5eOlaoIkrYmj+iFj4fK6Q2te2+yR1G4fVnsMur0kYMvaL4Bsaf56ncFlbYV7lJlkofri9kaEExlYkzOOBRJSrREXWAA2aKjF4NqPJA1k9IDUckG+XtSFCNHvkyGcz3DX7IL98U3UczsKrLy34UB6YA2wpKUGg7et+bTdL+F1mjKT+0KdSTSVJcmpcpgQCwGSTC0++kdo123ZAidB5X1qmNoH1GPjSVrJSeNJjZD9XDz+DTfoZhirnRmKRT/Yvy317ZBTUopYnscpMPy6easCJUmydAuC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:49:28.8868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c9cc8d-a3e7-4e1c-9be9-08df2eb0f62f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Suraj Kakade <suraj.hanumantkakade@amd.com>

zynq_loadfs() called zynq_validate_bitstream() with blocksize after
fs_read(), even when actread was smaller. check_data() then scanned
past the bytes actually written into the buffer.

Pass actread instead of blocksize so the header scan length matches
what fs_read() wrote.

Fixes: 1a897668ac33 ("fpga: Added support to load bit stream from SD/MMC")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/zynqpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index 5a37a33b0a70..e8046995d7ca 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -445,7 +445,7 @@ static int zynq_loadfs(xilinx_desc *desc, const void *buf, size_t bsize,
 	if (fs_read(filename, (u32) buf, pos, blocksize, &actread) < 0)
 		return FPGA_FAIL;
 
-	if (zynq_validate_bitstream(desc, buf, bsize, blocksize, &swap,
+	if (zynq_validate_bitstream(desc, buf, bsize, actread, &swap,
 				    &partialbit))
 		return FPGA_FAIL;
 
-- 
2.43.0

