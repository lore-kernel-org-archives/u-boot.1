Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4934AC79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BF8980EDE;
	Fri,  4 Sep 2026 08:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vubl3w5z6lAa; Fri,  4 Sep 2026 08:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2596E80710
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511066;
	b=D8+QHJ4CJBXpD+1AQVTsN/pPhAqU655DqHe+0qmEr3JnvEda6mOOyU3PW5oB86ULXpBB
	 OubTyvCxH2Okw0yz2+L4vZ9FSm+3VjMycfnwjB0gc/t9kOLbq6/x9YptRMqtVHeO8RFo3
	 zkshYwPSY9p9pqEXBIhkED2KtdaxXb/3qs9NaIzYebVVfUO5p/ieXeJ0F+6Duf2VZVWSe
	 3KjV9xNwqSVdKLG5Mj6AxMk2u83wfVu8p4bbMps21ZqSgJbiAEhRpbYryZihC9zP4K154
	 I5tOhHKc3x3NZrbSgGR0+OTLUt2K2/Yl0oDIaCvHII/IeL6hlJN1e3aesThF61NUsSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511066;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/3xrIK0cgCRiyoMfzbrrH681/LxFmrAWczGzNjU9iXk=;
	b=a8Yr6179kHy3YkwsPM+DHPE4NbV4exIB+svcYTGGaSczHAnOVkH+tCgEBGayXe8oI1yR
	 ot1CbNQxzof+hcryVUAEuoxeIitJsd92lfmRUmoDVofLZ0jVo8F4Ok78AM8geiDHkx4eX
	 b4eODs8Pi3IAVm+m2b26UIQv/vXN3CsDzoGMBbbkI63NySbi+k7eiT3h+Jaf8+uSMk1g1
	 EaUHYs/mfmYqR5KVJjHbMaojB6WUDhHiwDVqZiUdQZP+Fgn+YR4lv7bjuvKRU3gy+wWTc
	 ssXTiS32q15t+IkDuQOcDPDTi1+IToBSscuXIW8thwHelx39s6YUjt5dqaxjdrCvDAg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511066;
	bh=/3xrIK0cgCRiyoMfzbrrH681/LxFmrAWczGzNjU9iXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lA1GUuxtVvpq8okPPPIuMjgfJoOBeSkz005/IiiRwvdSc90Jut3nCrcaQtPnE/ql1
	 veV0A3rGkEdot8lb9kEQ2lT/gpEGMerW83g62ipjpkmEvbZs/B5OI6k1yPc4c0N4XG
	 a2vNRXXvpwLzQoCK+xMr48PJPzxncepY2t6QJIgjySZ2QNajNQ0V5BgxVVQV7yYF3D
	 wUQDdfS3LylKEnTMZHEclEYlS6pfZZgoGvb3sezWLmmViEVfOGoONXkrEpa13orI+/
	 NBkNUAAgpPyO5xhlVzgIsnKv9W0pBZJCDCWXGLLl03p9IDyvkD4jEuHvOhTPdZ+DC/
	 kcYzQQOer1M2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2596E80710;
	Fri,  4 Sep 2026 08:37:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB0133DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D09C74031A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZIpeDDrRA9iG for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8300A4013E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=Ikn+rKrAcPmHS5rv/o438rfuF+2AQDtsheKerI+ipRubsjR19sy/4uM+TTPiCBgjQsH+
 9NtMt8l9Ys5VgqOTr/Du3rBN+kZpb18wSw//j0GG/tu4C9xolrcHBzJ5Ww9Q7fF196yVr
 ZXrbJhgJGyKT36ku3+TklaVbzQ1GV2dDvpJXulnI/0SeTrPWjiF4DanVVvZlSgzBNK+nX
 yrpInNE5ALtcHWDYje9XjVz5909nw/eQhcwJ860hVt8iMIO+UNcZwY/KCwZuXySO2ddyB
 F7YIt8z+khC7MWdNCk9lkTDXk6/EWSI4xB1xypdR8MIx/cDJTVRi/OOrJmFp6CtwSNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511049;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=/3xrIK0cgCRiyoMfzbrrH681/LxFmrAWczGzNjU9iXk=;
 b=Dk/16Pm3Hf4m0IKbSYHJq39YfiUgoxOyYsvgPA7IIb3m3KWPFaun+95JJevyrc+tzlRG
 2mPNjWK2/YhF/497aqLhBZaXDt5YPCvNXR8Whimsuo1/Ac5DssD1e6lbfaYhpf2WnHnnF
 gvh2r0WXiTVI2mQDq+ILiMUHAbivuDvwupO2Hz3aiJPoHtSrHacWNDP3DDsP9OuI65zEL
 NRm7+H0dHCGFCDL3ZxIr0SUs2/7nfpP3ferdrvhhHmnpimg8GHIFCVgZ7k0fG8Lnyo3vQ
 idmOTauRII8CLrPD3DEY0uHyhaTiBYxPDvxz/4q61SBzO1Gmje5+V6np95Ys3spxtfw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=CT98DJuM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=CT98DJuM
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8300A4013E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmmj9B2Y5gW+mVO1d3iTnWN61qI0ewiL0L3JlPY4sPCYShOkW9Mok8Kd1GCXWalG56wkgksw6WsYRDtO4mGMmQtujMzyzjY4O2IgZubGBUp6SBDNkGsvBlDv5R0jcxUI+xgv3RjPYsUQlirtZIRuZo7V7zTzqqrPck2mySiSJZWV3IPn3iLv4BoqULLR5adMySpHMGvyKuIHwSfKWuP95J35NUlP0BqS0YzbqNSuF+5n3s/IRNoqEzGx/tPWfKvk9Kqh5RhRDfPu513KL/u8HxKizmUqx/R/8DlYqrtkk3TbYPXZlLxQJUksmcsOSmLHXh/KRlA10ix7KG3A7voLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3xrIK0cgCRiyoMfzbrrH681/LxFmrAWczGzNjU9iXk=;
 b=YGm/AI3zem2DsVJ/Nq8oDMeNQ6MF86ZCgv4OjL1LtZBwiedIwF428x0jbvCLbhUURHp69vLC1TP8srfHf2bM2+PYrqLHddndxtE6X6++A1R0cN3jSvO6PBvnDddU0Cj3WeyjI5VemcQhFgGXOUqvHBgithF6fMnuSV+htB7hVNLtGoKkb3gFAh6cc+mb95XG0b69iBF1IFPHKiF5yuWgf/sz8fAgBskMfwUi4KkZBTdIFUfUj4whd3MExXeMdT/LjzRbUs1FiNJ9IG3bW1CI29rJcKqi7Ei2rf63avcOgMSyJzUdHQ96jfSzDq5ZghtzT2uqfZ/EjtPewJQadX+lJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3xrIK0cgCRiyoMfzbrrH681/LxFmrAWczGzNjU9iXk=;
 b=CT98DJuMLD2GDPZi0/QTFTmOLKB23c4RnQBnBLoMPQ7zubvPNjjQJSdqJV5sb2TBTSCc5Ak/kolzQl1rnEHIu3G0jTCH3Ov0m1jDbNAInlyEWJdjDE8TzE7IJcAxLDc41u/Lrt0XvVcWSEGA8NMvie+csz77kpZSOe8meu90QC28D1z8wTloVjMLBtfMFVCjihLEflXsX3b7WGUD5bXtVQ+OSRDBCfRv2OD/PqRmCzVtTARfrkclKa/cqvoxsFl+/EMPWDnsLFteNpLLEayy8ug+JFXBnUVtHg0UocRMZMfVHAR7DqpMuOEst/BZpbb6dxWehUgyGTra/gEf0erW6g==
Received: from PR3P193CA0018.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::23)
 by PR1P264MB1598.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:23 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:50:cafe::ab) by PR3P193CA0018.outlook.office365.com
 (2603:10a6:102:50::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id AB115202C3;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 10/15] tools: mkimage: pre-load: add support of ecdsa
Date: Fri,  4 Sep 2026 10:37:14 +0200
Message-ID: <20260904083719.53132-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PR1P264MB1598:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d694c0ab-c4ec-420a-a6a8-08df0a5fbd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: oX7+NR5wFUazAUSMY8Yage0V9j/rDAfQvwV7HTd0wcATh2M/pb4ZRFFKylddGZXyCjrEKAknZAIpExInIEU3Ou2rUe/MaJ5JX10NrUkpYF9MHD6XeG+DBK0Is/BGiQ2Nop+Pzk9X1kcMEKkPy89FLWJsC33dNEnzMFS+4j37ioWkyRwb2c2GjhgaX4oDT8EvX7ZVzVxlY1adRVNfLxlQrellBQ+NMGJ2655g53GVHOvVcNV3BRB7qKi0Tg7wnnCLibui8edHiEIkKLmuD5qCWaYW620qS4PROP/Zact2+fWiPPcrdUOj4LDmsf+9/uOUHlEM0cr6bY5pXcvIKJBfNth4MHGum39UgwcYxIZ1OvDXLH03Zs19JNWaDy0nRk+pyQgO/Fr3CmLL/8WKmqaL3rdaBAWkBYroJhXv3d1aYttzTLF/Xw5p0lpkwJMra2/ucuNCebOTa9U5f0+HEOtC9vryVjDTIsSDOiUfjrvuMIYdESkPFQqF/Rlq4oWopSdNkkKQFZALek7aTgKxfO/iyw885gnhC8sXLDOZtfWY+2q/+GIsV6yvZrVQ3ATkHU8LJ1XxKCahX3P/nO9YRixc14tsY1G3JVVg4DXG+hJO1L6M10e4ET7/IGW664e+5ZGWwYb02bh3tYKQR2yUMMy9GAZnNvGaEct+hsqaLuR2SBIKQun/2ZNxhmFstoKGNuaVVBb/mw+UaDGfRAu5+a8WsA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 55zWUwHcQ4x/8rtuj5S7odsRBJFAERywFMOubr3YfIgHkJt1c3zSSXalM2VnYbTJJs9SWIUFSq7+TGJM2btVinGkcEX3dFU4BAePanQ6aU7NNHO8B6dxDIjhPQdDwisRv7iTuOK29/FqddWq6eFpurh/y8LwWfEQVBdAt8L08y5n9Umcdg9+pChsYfYxLyDcSLX4/RI5r2eJQOLMUR1BvcOsOSd3jcs3Fa0adQ8ZnPvPn/q1hN/E5w6Hp72HUh+v32XJlP9VXj/eGGVMDK4b7IaPu8o6WE74f3vnEuRKjIXrzF3/dGYacLaqqU8QYzUGLX4XTAHzlBZJYwNKkfKRJ2pr6Y5oRjLvv9vr4a7YZbWPzCqh0GOX4xgXMkPh3Fw9ppY36M4WWRNyaL8eEASLUzZaSpqhkz0nnwsGzC7wDfTwqQorCW3qel52Dxlzqu8u
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.8368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d694c0ab-c4ec-420a-a6a8-08df0a5fbd97
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1598
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

Right now, mkimage can only create pre-load header
using rsa. We add the support of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- use pre_load_noffset (do not compute it again)
- release memory allocated with strdup
- clean code
v5:
- check checksum and algo before using them
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change
v10:
- no change

 lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++---
 tools/image-host.c          | 92 ++++++++++++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index b3fc75fac48..5e69782424c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -517,14 +517,9 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ret;
 }
 
-static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
-		  struct image_sign_info *info)
+static int search_key_node(void *fdt, const char *key_node_name)
 {
-	int signature_node, key_node, ret, key_bits;
-	const char *curve_name;
-	const EC_GROUP *group;
-	const EC_POINT *point;
-	BIGNUM *x, *y;
+	int signature_node, key_node;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (signature_node == -FDT_ERR_NOTFOUND) {
@@ -559,6 +554,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 		return key_node;
 	}
 
+	return key_node;
+}
+
+static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
+		  struct image_sign_info *info)
+{
+	int key_node, ret, key_bits;
+	const char *curve_name;
+	const EC_GROUP *group;
+	const EC_POINT *point;
+	BIGNUM *x, *y;
+
+	if (info->required_keynode >= 0) {
+		key_node = info->required_keynode;
+	} else {
+		key_node = search_key_node(fdt, key_node_name);
+		if (key_node < 0)
+			return key_node;
+	}
+
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
diff --git a/tools/image-host.c b/tools/image-host.c
index 9a85a3dda2f..ed1bfe68a31 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -14,6 +14,7 @@
 #include <image.h>
 #include <hexdump.h>
 #include <version.h>
+#include <u-boot/ecdsa.h>
 
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -1681,13 +1682,74 @@ err_cert:
 	return ret;
 }
 
+static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
+				     int pre_load_noffset, const void *key_name)
+{
+	unsigned char *pubkey = NULL;
+	int ret, pubkey_len;
+
+	/* Read public key */
+	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
+	if (ret < 0)
+		goto out;
+
+	/* Add the public key to the device tree */
+	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
+			  pubkey, pubkey_len);
+	if (ret)
+		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
+			IMAGE_PRE_LOAD_PATH, ret);
+ out:
+	return ret;
+}
+
+static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
+				       int pre_load_noffset, const void *key_name,
+				       const void *algo_name)
+{
+	struct image_sign_info info;
+	int node, ret = 0;
+
+	memset(&info, 0, sizeof(info));
+	info.keydir = keydir;
+	info.keyname = strdup(key_name);
+	info.name = strdup(algo_name);
+	info.checksum = image_get_checksum_algo(algo_name);
+	if (!info.checksum) {
+		fprintf(stderr, "Can't find valid checksum from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.crypto = image_get_crypto_algo(algo_name);
+	if (!info.crypto) {
+		fprintf(stderr, "Can't find valid crypto from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.required_keynode = pre_load_noffset;
+
+	node = ecdsa_add_verify_data(&info, keydest);
+	if (node < 0) {
+		fprintf(stderr, "Can't add verify data: err = %d\n", node);
+		ret = -EIO;
+	}
+
+ out:
+	free((void *)info.keyname);
+	free((void *)info.name);
+
+	return ret;
+}
+
 int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 {
 	int pre_load_noffset;
 	const void *algo_name;
 	const void *key_name;
-	unsigned char *pubkey = NULL;
-	int ret, pubkey_len;
+	char *name;
+	int ret;
 
 	if (!keydir || !keydest || !fit)
 		return 0;
@@ -1714,17 +1776,25 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 		goto out;
 	}
 
-	/* Read public key */
-	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
-	if (ret < 0)
+	/* Is it a RSA or an ECDSA key */
+	name = strchr((const char *)algo_name, ',');
+	if (!name) {
+		fprintf(stderr, "The name of the algo is invalid: %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
 		goto out;
+	}
+	name += 1;
 
-	/* Add the public key to the device tree */
-	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
-			  pubkey, pubkey_len);
-	if (ret)
-		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
-			IMAGE_PRE_LOAD_PATH, ret);
+	if (!strncmp(name, "rsa", 3)) {
+		ret = fit_pre_load_data_key_rsa(keydir, keydest, pre_load_noffset, key_name);
+	} else if (!strncmp(name, "ecdsa", 5)) {
+		ret = fit_pre_load_data_key_ecdsa(keydir, keydest, pre_load_noffset,
+						  key_name, algo_name);
+	} else {
+		fprintf(stderr, "The algo %s is not supported\n", (char *)algo_name);
+		ret = -EINVAL;
+	}
 
  out:
 	return ret;
-- 
2.43.0

