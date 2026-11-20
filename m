Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A0606A335
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d7kYUQZx;
	dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=u82LkQ65
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FDF9607C2;
	Fri, 20 Nov 2026 18:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MUYp9HQdiHUJ; Fri, 20 Nov 2026 18:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B04A60E71
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795200293;
	b=EipLhJLzU4JmHPvFNZaZ/8D7n21iem74nGqLJmHKnyfH7SYTBZL+YrmL4hE31sRP2Nqj
	 GrWOAtJ8+ZtN83o2tHIIAIHl7rncU30+CnukKtfivmzGV4h+FxW+NKFwwgetLMVuvdRLn
	 ZeA7qTroPGuz+mdvxWWdKiESCtB5lnW/m5bD835xK0LWYof8OoxSpALAO5D6UNyf2VgDD
	 7hUdxTTZm/Wl6QDfewTU06I3+y8yYVGCdZeo+4p2KZpi1V+qj1IWyxQpKmdwIxcOmRpR7
	 rdx8W+ySMlYjZ8c23Nr87/pVNpau5NQmyeaXMtvEy+bDZY5M86MtEZSdYRvi8WKYB9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795200293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/H2Fkcrmsu3Rn/rrWlX+yK5gv5bYNv4NlbnGIlRxBno=;
	b=B1VMCfqyooUrPv/cJTaVOXr6vdWs+fdgBpUttAv3dgmzJPMrcjff3KMdLeFQ2XuVVGmc
	 ITM7Ik5Bj91TAKP2o9Wh9K8L2lSb2qHaCY4fxeOISCMubkcdeUL5Bt1i0jimzM25sO+h6
	 Xkihjp3/kl60JiFHbI1Y6A2DS5/2Q3fiTSMzBXP8b9eeKt215VmgHtG5fb/YaSJQcsrHl
	 xr5lwQaY8NJzzsvtRxaO8+ZuVWOJbdhMz63WCrKthg7F7a5jYimG9mN9pVJKKG8Hl5ob2
	 r5aJN6eOVSOCKgvT4Y0gYN2fqEWivUBG7MV6bw4xv2YeEIrnOa1mt0l0HtI5CV/Zu9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795200293;
	bh=/H2Fkcrmsu3Rn/rrWlX+yK5gv5bYNv4NlbnGIlRxBno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d7kYUQZxuPv7GUmsq8TW0WVgIE916StrUV0mhSpkAUbgsRfe94UfVLmZHMXeFxtRk
	 3MUi21NFSxLLdBuzlySFEyvk3yeE1FlFFsitf7v3WtJYdOQXm3Gm8ewFSFKU5syrcf
	 TfETfKd9wPYZgl9GssPD+LYHRLuW4mtXLdPV+GE/9lEQ/4tBLJggQz2o+jF3kvjzeC
	 ASDfnmD0J6S3y75gER3veG4zgRWWhOpnDcowquvromqVmehmAGFvxHYOw4iGRVhdVc
	 LrftvhtEF42MYQ1Npc1dhP1mTJhCagACuOMVAB8+YvLQl29OHmetn4fe8Uwj3cwh+h
	 bEw3DebDHoj1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B04A60E71;
	Fri, 20 Nov 2026 18:44:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 633091E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 553D540098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1J9X_gmQlW50 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8AB5840050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=paul.henrys_ext@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=u82LkQ65
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8AB5840050
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H2Fkcrmsu3Rn/rrWlX+yK5gv5bYNv4NlbnGIlRxBno=;
 b=u82LkQ65enuYZmXxkl3Zfz2kYPPahfUkbIiHpEMD3UY6v2GLQkqxhKdlE4ALsTL8gOzpwcX3qN909XujuJTIUsZjp2pEAnCvyHNnvxkVPBm9cZSFt9D0mQgKUD9xjHKWkoWTxLhIysdslK9mMQlTbgoqXLr3dHfSWUvPZOaou75mHTH6xcKRW89y3RCtSkpGaXHAHo0RbvMhiMMIcN6onWQvIF17GuDXn2jL2xUJyXAJmAZAo4uElFP8AWHFAdo1b4VhqrNrEnxpxSWwFtVf6Xs2tysdMaf+sjXWOfB4cDhyhTSuQrE05WFglbb/X1pNFdrrDTK4wBJTDYS6KATF3g==
Received: from MR1P264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2e::7) by
 MR0P264MB7263.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a7::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Fri, 20 Nov 2026 15:47:44 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e:cafe::34) by MR1P264CA0002.outlook.office365.com
 (2603:10a6:501:2e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:47:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:47:44 +0000
Received: from sah2lpt245.softathome.com (unknown [192.168.72.196])
 by proxy.softathome.com (Postfix) with ESMTPSA id B8B6420160;
 Fri, 20 Nov 2026 16:47:43 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.u-boot-project.org
Cc: alpernebiyasak@gmail.com, trini@konsulko.com,
 philippe.reynes@softathome.com, paul.henrys_ext@softathome.com
Subject: [PATCH 1/1] binman: fit: skip empty data property for
 externally-provided images
Date: Fri, 20 Nov 2026 16:47:37 +0100
Message-ID: <20261120154737.110128-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120154737.110128-1-paul.henrys_ext@softathome.com>
References: <20261120154737.110128-1-paul.henrys_ext@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR0P264MB7263:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba548567-984d-49f8-b49b-08df471d9e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|3023799007|56012099006|10067099003|261102123227099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: VBLKNx2+oMhZH1VnQL6XRfo95c3EecUUUwgqXVqoZCXlHPalDs8jiSMa286aWK1v50+tJpxWaCboIoEQykEIHVhTxBj2Y65FQibWAVB8mwsZMlmZSQL3TEsyZce12cKBJXgdFY+HJzQXaHs29MFiWYlES+9wFci9gfxxb4NbrMz2jc739+K6lsYsZV4SMvGxm6nxx8SWi5nssbGk5b0ASu1zi5h4R3mnYKnDdf/mbAErBZj/15zT8X38ZGmGHTcFanT4yovboNz01Vb7bFtGVo5q5QsC5TLntG82glos9EKRIhDHWAJsr0VksC8ZwsNHevSYzH84FObncyUaOZ2zoPJeGHm+9Ik9FrU8xAaqd4sUulMft28JuLjewbk7j85kao2VBiaxDdNzU3zsPZHwhPJk+fGz/9uZyTR7eTfBaUtJUT826cniV+nTzVFw7xSVebxO790aMPX88PK6kHfiEmfdxVHJZSk6ed8twPHXRIgrBDA6kqNLQo/zsqS5knqe1tK9vim2P8JXoP+M4bcQ629U96Omrzuo4/8/6sVWWlRtO6uDQp5yKWon8NqQrMxiXWNQESPnZDQwApzgCcAPKtsFGwx/5JjFMQlk2AqOWGGj6ooUA6Bac2qLDX5RObBVRE3TrKH3YVcy0Gwkandce/jI036gtWnCTwWV58Dzyr7JRqSJ6fs7aAesySsrZhLIB7z2sZnf1fOuXl83FQJnIQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(10067099003)(261102123227099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UUk+oB0PiyxlqnQbC2I9TUU8X+QA7b858NXmp5gfxPPnDKE3CF4QVjuQeCWwMm/uotxY/3qaBwB8RN/E9z4C870nXqKSqtFPjm3GcUQZt6TegctckpIbBEe53F0J+Qv5O63+bDep0ruPGLNXTyPGDWPddiThNQUPDnbp+tJuAK5SCJBAXLBOaG/6yB0wk6S9p6KWpEQmTjl/pLP5E3/YXXfUDbcv2rj2ioNhpVaPeI4d5SXfE2GJI8pe9OY27N/nwGuw2Bn+KyiSeiiCZDN47CQs0fXH8Sl0lY4NowlRowu/aUwlCVDk3dfxtePsyxLAlhDxZy/hEaul9wHwy+v9BeW1t2ygMAp14TTMa6NlLlSWUy35YbV9iwsI0shp5c7MLufAWA5anrRbYd545K7SXRVtpvlk+n8zgAvaKVcAxbl7w/wJ+T5Vefjh7zKne7tG
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:47:44.3138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba548567-984d-49f8-b49b-08df471d9e37
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB7263
X-Mailman-Approved-At: Fri, 20 Nov 2026 18:44:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a FIT images node has its data provided via /incbin/ in the DTS
rather than through a binman sub-entry, entry.GetData() returns empty
bytes. Writing fsw.property('data', b'') in that case emits an empty
'data;' property into the intermediate ITB. When mkimage subsequently
converts the FIT to external-data format (-E), it adds data-position
and data-size but leaves the now-empty 'data;' property in place,
producing an ambiguous node that carries both inline and external data
attributes.

Skip the fsw.property() call when data is empty so that only nodes
with actual binman-managed content get an inline data property, and
nodes relying on /incbin/ sources end up with clean external-only
attributes after mkimage processing.

Assisted-by: Claude Sonnet 4.6
Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/etype/fit.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 4657ed1fd76..bacafc9b9b2 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -1047,7 +1047,8 @@ class Entry_fit(Entry_section):
                 image_name = rel_path[len('/images/'):]
                 entry = self._priv_entries[image_name]
                 data = entry.GetData()
-                fsw.property('data', bytes(data))
+                if data or 'data' not in node.props:
+                    fsw.property('data', bytes(data))
 
             for subnode in node.subnodes:
                 if has_images and not self.IsSpecialSubnode(subnode):
-- 
2.43.0

