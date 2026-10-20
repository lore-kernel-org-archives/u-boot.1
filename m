Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB189606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OcrOSPCv;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1SiOIMOw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8982B80DDE;
	Tue, 20 Oct 2026 14:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_3WAjC3bSqh; Tue, 20 Oct 2026 14:10:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C018E80FC6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505423;
	b=VnqzdyO+S62MbsCnt+/ShWnrYlsnN9g0Orb8esvwlu55DxFL5sOrc3bn4ORHtuVIwevf
	 QfdTch0xAQJHh0t/6n0EKCjHB7Ii1HgpQPhGnUebDO0qbyPV/VJD1yfzXWkzCAIyeElpm
	 CB+YEOBWe68MkcAYYslhonP+SEeEZCy23zOoT9WsMMOFQ518EYN5jelXSaNEE3xyik45E
	 hiiRSHbgcKd+06xUerKs2W0xB91AUP0yiuDIdRaB8i/gz2DsjGh2H7t4eOF5rS/7gqQk5
	 C3mXyFyJDpSrKB1rrJrabWI+RGPi47ZPE1vV66X88bN6Ol/v8wnLjo9QjnSsxaJd/5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/bPe0gwyGcT27WfMbBnSG/NDbMByl3y0s8I36WfFsQ0=;
	b=mESC/tM0x/FU4d9VFE8ZKDBFtOhLPf/f+ejF50Jl3pXIgz7db8ZjZ1CmZtbRYQcRNIJH
	 K6cRYoIWXAwQwn72jOP4TvFBGr29LmcK4uMu9GN9WtTUoSmbl2FUvLvKoq2zJepeyZJ4q
	 0p4O6aOCPxmZTQqMkqTQ9iY33BrhWRWMId5jw/18nCAOuFl0niDVcXqoVGadslC7sUQAI
	 ep/6+5a+AIao0Ze0nFSHZCIPDStcb9ePtBvpQykBnaYkJ2F5BET7uvwbcvhR5ZnDoR4Qk
	 MKjE90fmO3xthHTudFJFimcRSe9vMA/NwANQaqBDPqKSwrjr1B9rOrXiNpVz28VH2fA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505423;
	bh=/bPe0gwyGcT27WfMbBnSG/NDbMByl3y0s8I36WfFsQ0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OcrOSPCvtWpMo2/dkWzpLwI63iSaBGyKbRtbsXRTJHkAY75+ELuua4Vbpn52Fmnm8
	 +5TnBhGn2KMwrMKrXYMvQs0iHUpm2Ym4Bg/6/p72J7wkJnw3LeXh6v8nC2mSoSgqMP
	 ichXeC/IeKoAa+aRA/q7QGFwUXrYlAYFdpf2J+a1Iy088s5DTZQ6DL2H9WzZ3QvtR7
	 Pu7cv7Y/TX7UePqarS27o3ZFe8P+NG0Vth2DnRwhiGTXNMMWaYv6CGfsRJ7sWoK9GK
	 KHfS9LbFFk5Kib3Yo3D3nsssySDGQhPIny5KJAKiQTdEhxeRln95Ab1SefO93gB/Wx
	 XA4iwI5txQTGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C018E80FC6;
	Tue, 20 Oct 2026 14:10:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D946C1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB270608C1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttqliD1y71sy for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6EDB60885
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505420;
 b=BF1WfSbXpuzTaHtaPRjvccBj+zRX/sjzdX4hOqsbcO73oWC9m1MOIqJFOfcXPggHydlN
 EXI/h0kCW4VzIC05tAhBjQJH++dXKSJHjiZjslNg+Nv/GERBf0eX0X/M77FLITa3H5wqB
 k1gL/dp/yH7VNOu3QBiLm2VEfaQ0iBQOUWZ2bKWpnHQTr3gVDoOUY+aVH5AfG3qoP4L3O
 J1iAn0N9ZDX/zvACa2qAKYqOJ8NG/71YlNJheUJLq9zhZJRH4aAwwg3xyiDklbN7YWUna
 alF2EJGbiZ5mWI3RN4QVKYnWM7dvUWjmvRiElqodKDhnoP92EiUrxqjg9oB0grBpxgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505420;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Type:
 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
 bh=/bPe0gwyGcT27WfMbBnSG/NDbMByl3y0s8I36WfFsQ0=;
 b=Ex0ZPD3KRiVs+l034+eGYg4+5ani9hWLhoKT1Wt2ljh/431RcVi9BCl0rNih8588ojU6
 A4LDUHw/XCQX4FNDkBjXRbALNlLBhjf5mCixdo+e6GPYmP5XYBT39YqQgDBA1hXdkyJOV
 sFljPROSznxN9Iosvnhcxmzpdn7b5ttqnUnYSQq8rzGqimKP5p/cb4nyBeC4dFxpAD5Vv
 xOgu7/9WvVsgpa/uvLkvsOdxAu8FGe6H5k/A6l/I4sNF+09m0zPfGfl6SlK9TITs64CIl
 bklCNQ2TPc74H0lXYqzxk4K65/vQukvaTXprg21RQkuJdC6ozMY5iQvfPvq8/T8YXMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1SiOIMOw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1SiOIMOw
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6EDB60885
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEwoZ0iSCR+GIqzCgSwhvHvQRFzpEJvQ9FK9mZxIflutVmj1LSqAqCxNYQBcLr0LaL2Ji4gY5+R+woy/msxmB0nkDmO2VHqbS/KOJPxR0dncCUSGjPvfwZfgH9xFSk2jEwHjXTrONuZUasVbcnAZpfE6Fe3U6WF1JevhXqg/0haiJDBovYmzOMcbl1aKeaOUKs9XJZi657uWKsoMMeoCnEaOEJ8Mh+Lm1SigaJ6HRAgB8WzP8fDEePmjbJI4hOPc9o06/zaj1gVotJ7Bq3sw4wYPXSlG9fNEBe1QjYTWz8X8Nnv7LM7YZycjRhNhkcluoAVifUqgREdlN0vhXqx1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bPe0gwyGcT27WfMbBnSG/NDbMByl3y0s8I36WfFsQ0=;
 b=o9bwBYsRaji5m5tJiWfOOqIwgaoILOfFQlLuMPaiWVF5qnoHkBBdJ3XKb/Pxe8B/ARf31wXn35F9sX5/JFb25gBLDHQdIq9hbumKMwKqyqV/zwTkisTRvBumnEoC2tFI9gZZhXh+shEgTpQBxoVcT6mRZguaO0XiOWcn9xmMxi4ClemFCCGUjNzJA6c1SSyJrVKpqFkuL7OjgLo8MvQ1DwMVtjLl+mPSBWXPFvj8thr/vLhz3CaBgPdAybrBFA7GKS4xFYbtgB9sGQLAkzumC8nqHb/0m5/IaBUWkmYKTU/0FPARmvfgLTscbBtzOcZ/hw2jq/V8s6zM/GI8oA8Gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bPe0gwyGcT27WfMbBnSG/NDbMByl3y0s8I36WfFsQ0=;
 b=1SiOIMOwhB5uxclagKk5MWsMI0rJXcb3zFilJthDMbl2OaBbcogagrM36e9DGGqZ5bShYr/JlkZ4rSAEeq7ZpEkbw6MyI6z0mo+LLrIjOkEOOx5LqfMMB0AloTUIyLkiNIxwPD3OuuYaprsYsjug8QVjjrz5M4v08XngdS8S/dE=
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 14:10:13 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::42) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 14:10:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:10:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:04 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:10:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] xilinx: mbv: Update stack, heap, and OpenSBI memory
Date: Tue, 20 Oct 2026 16:09:28 +0200
Message-ID: <079c7e9fad214a975efd5d90a6776c39cf72bf3c.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pZKCdvvxPFYA2JFeD0yKIgWvcO4ZFMP602mj6I68y8Y=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5MLljePvpYUM/lqZN/h5eIiTtxJPZfObbgkmDaf4
 W77M54LHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRtgmMDGvVekLn/f82M2P2
 sa0zFpqnnq/jaH341uN7rLt60vEZX/oZGW573OauXLNicv7S22wPpZO/q5lxX/jaGP7fyYohttH
 tBicA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 46944aa7-52bb-4058-0255-08df2eb3db5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: dSCeaWWh9lnysR9IYxEgnZKN3qHDFHVOnM0J+AOgxpR4jwTAUm5+OhUDhFMGCW3D/vYUYdSiyuDzfZ7BdxF9b/9a0dA3nQVEYc9UQgqiA6kN3dPYnaaNcEM7QkxcfBPwgZA/jXWloWgW/VaVfK1vJHuU2K0HHQvAZ0PFWtch6ypyS91sR5yMpJBhyAnPw83b3Qo+aGRphoG/ynAARkdR43KCNf3GSGo7tBft7OYxcyo2mF01alK7kSj/Q0drtbta7KwALTAuy+yEeQEdSanughVizebIJL/9KJwJSdpFlXYET5qadu5XPDfnUyTkdrzt7rbFuhqTkh/CAQs906quQCIZZm2A68L57TiVhgFIuWITUitQb8N3wuTtgG3MAm7f/TdgKKYorpEp79F9U4TonLFVXOjcMbCXya2KbtCTRhNT1pcT1RtN6MEmpZMEKDsostXsG3MBzhyNi144LAvQ7fkO6ViIksVaDbEvo5N3AhlHrhxTqd7Eh0FSYlaa7+Dj0DNffNA0oy4PbUpJBFl13w2l5Dr+e6xTVJ5VUOD2OE4BWDIWMMM7BjTdF81sed7HjKCrXf3kc/62QFM4UO5N+ghbz6jYwdBwZHDnkfx4FiLtJm8i+pLhwngU4UlIVtSQHr7LiN3nDmhMtH7v+ie/UGhio/zPRmBivzQfsupRNbrQRe2+JTGI9dOT3L/cLjEBicbX57FhUY9vARM7jAWBWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nLlF5Vys5RBEF/urPGIDPjH9tWoJr1ec60D4y8Tsg76TKpgAsUVYbx/TiT6I0mbv5zHhjpJylz/1N4zW+ViMsKAY5t/B/CKh5cyqAAUjIWjxdupkvJ7VYoXfl2nE7khM0/bXbDNAprnN/UNkCn3lu1v1dCytg4Z2FV6dkvjP3Y9pj00THAnekB5WfysXaMdIG+A3nedvm8OEADk7KoBwVDQiT0nULz+kY0RBBSCMy6eE8vIjUNwmIcXogMKFJXyW2vUq+Neyp+NSb8hUDXDgVyyEg3KB5OrWg9f2UemkHAtg933e0Vwt4oP3EQmwW4SSIDnEbKtqGFYOAVfuWAhepuml0esKWIMZEEmtB3mw22Xm/dqamtAGyKvNctLG4O5CVfjaNRlGbXBnBXa7YA//9R+h5VGlLrFqlKobhEo2zhgNOA5dTte7GCfwNuLQPDa7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:12.3005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46944aa7-52bb-4058-0255-08df2eb3db5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Padmarao Begari <padmarao.begari@amd.com>

A 2 MB region of DDR memory is allocated for U‑Boot SPL, with the
heap starting at address 0x80000000 and the stack at 0x80200000.
However, U‑Boot fails when using OpenSBI v1.8 because OpenSBI begins
execution at 0x80100000, causing an overlap between the SPL stack
and the malloc region.
To resolve this conflict, the SPL heap and stack are moved to
higher memory addresses, and OpenSBI is relocated to 0x80000000.
The SPL heap now starts at 0x8C000000, and the stack is placed
at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-Boot.

	_________________
	|		|0x8FFFFFFF
	|_______________|
	|  SPL- Stack	|0x8F000000
	|		|
	|		|
	|  SPL - Heap	|
	|_______________|0x8C000000
	|		|
	|		|
	| Full U-Boot	|
	|_______________|0x81200000
	|Load FIT Image |
	|_______________|0x80200000
	|   OpenSBI     |
	|_______________|0x80000000

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig       | 4 ++--
 configs/xilinx_mbv32_smode_defconfig | 2 +-
 configs/xilinx_mbv64_smode_defconfig | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 4195fe0f05a1..d75d7e2e8ed4 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -9,7 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
-CONFIG_SPL_STACK=0x80200000
+CONFIG_SPL_STACK=0x8F000000
 CONFIG_SPL_TEXT_BASE=0x0
 CONFIG_SPL_BSS_START_ADDR=0xf000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
@@ -40,7 +40,7 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0xf000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x8C000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index dd1221a6904f..a72f13851acc 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -1,5 +1,5 @@
 #include <configs/xilinx_mbv32_defconfig>
 
-CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80000000
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 56bf0bdc7e4f..d7cf108692d6 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -1,5 +1,5 @@
 #include <configs/xilinx_mbv64_defconfig>
 
-CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80100000
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80000000
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
-- 
2.43.0

