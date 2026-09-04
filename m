Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C08C79F83
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E62CB81172;
	Fri,  4 Sep 2026 08:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJvbCguu_FtJ; Fri,  4 Sep 2026 08:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E4AEA81173
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511060;
	b=HB4TyyAcVBMKyvjGHJAVmJS0Q+JuPodcMmCFkVhh9vQM4UiYkljqrhLSiY13fWRAbvIp
	 B2zvUPw8VGM08N0BjyHkFsDFpnvfhOj6zrTwy/ARhu2oPxXV8VxokyxccxDqG7c+PCfPa
	 QD3zKVqfEJ9Bd6mR+bR4Sy95xKmmbKGuoorwz05H4m6Ujw/0LBTUv4/M4fTHP/o6tRfRr
	 EUupv71XH3WPyhcE9pM5D0Q3jrIYSs6A1ShCzm9GvHvhnNrK54Avsuj2fEzak+3d4iVCS
	 cvihD9e9IqA44wnbXwr6giJaG0ak55Q63AUA5SqeqQMM21XhmuXvxXUUWAYxcsPhxfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511060;
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
	bh=vDheWDcFY1UOfZNDDR3Ro6TWoqNe0RMuul5g/vnPZv0=;
	b=bjD0RwN/wCGvAym8dUqlyMWWofJHyMYfQJpb7W1Da2YHVZlHYfWxvH38vo7yeLCaoS79
	 0b+TCxLHpC8I+Yk1xAxIlwRDTZi5Sc9K8P8AVR2xtLGHU5NPBPK37Rf/IXBTZ3/9bVuXP
	 MIjSAq4iCdbIttjB8WpAL55SyOKqmDdF1fStTaSw8tLYcGu8CeTdSbJSMqLZudWvugFDB
	 WK1fqEbExy4sfBIR3PLlQi4VFoU9Xhe1Vsy1tChl46AdfvFGXA8gJHSaXq3ZOpNxg+5xU
	 8hK+x9erPw+DsbXtbLKfy3kIit+LgVDezQa+M9MDRnNJEFDpusqGbLHYkojPNm1baDg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511060;
	bh=vDheWDcFY1UOfZNDDR3Ro6TWoqNe0RMuul5g/vnPZv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOKMfbl6Bp0TG9u7RNdNdXDVadZdYyRn9dHiJZMWJS2qA8S7vKvir6UKvlj0KnE6b
	 RASVpO6Dqh/WbhDvJWvV+GvwR+rKhWRiMfLYACKmwgWFDWr/3ZqdNYitrPjo1Y2zc9
	 vMfxIqrpgv2kst6Man4b9lqpV2xXOd7xlo5qygY0Z9xHGGenv6yJNUGtLFYA3OCk9A
	 j9mxtmiIp4wSICqsP4+xtF03WAGGAaIYU22BwfVaacA7m6AKKFoiEPh09zbFaa0mpv
	 gaYb45ZwaecPFTgz5xRa5+y4LCsPuFeYZtzf1MUeyEOnGHmFLegLpaMLWUQXbc9Ql8
	 aalX0y8v4j++Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4AEA81173;
	Fri,  4 Sep 2026 08:37:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C6B873AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC4D140398
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aFXawWeA7t7 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BD8334031A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=ItAC5mEIpplIZrsyz1xdo5IZ5LlLuy8dukCJVkwonhxhkDOYl7t1UkTcCH69uUDQ7zNk
 N3VX5/PO1wY6ThqSGGauNXBScnwSXY4dzvmd6poS8A4lzVav1o8APOet/m/V/GnFiMQNA
 +CyEy6Q6eBXO5XxK+DGZcOetObKTP3lwV6/5ryRuMH3seS6WgQ1+uy6OZQgFjUyALFz8c
 5ewtSPp0fax5JHsV3q3c1Cq0KsmhaMIAqTSAWuI8Q/hMNVRcW/IPNeYlWWoc4a9aPkF4R
 MU55ck8uYGnG4ssiHYKyusuK9zvANlBZrvSuwQYgmrHf6Xem8Q2OhoRHvO7dy4gRbTg==
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
 bh=vDheWDcFY1UOfZNDDR3Ro6TWoqNe0RMuul5g/vnPZv0=;
 b=ZkQ34AatJF/3v72bghEH9pIM3FG9ulmD5pmtEKLFq7joCIWkIDnyWuou2eW6DC5Jedba
 7cttLVEgMSs2vt5JNlYtm9A3x3VxW2Y24bJ7fq+hxguvc8R2oRba1fyFDQoC4/DaD1rae
 wMrWcM5SkOG5RAK/HEHEkSLpAVEewDpLDqiJ9iytVrb3+9GlmZndDCIrfJZJGYKJdavdy
 LYZkhsqWOfH9wDaTR+VPTzxZgwJdLAC8XQLp3TaZx+XDrB60i6mqY+aus3PedidD1ry5n
 mqj4GwvQLWD6Aask5EXbpAYRxKOg7zWGLDcaJv711jbkglrML4b83jzzadnRMfpKblg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=rgSP7jHk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=rgSP7jHk
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD8334031A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgQ7psyuYNyLonTKWFztvjH6dReTJlv/nNoJDmYjLCi5TBEvcBPF4hrUVoultkeigzkkxGnNcVO2S/wjFO+KknZyGyYAvenPiPsIUl+5BLxhY2qfF1L7SBEp5aQudBfNWtD1We/0cONrkLMmZsN9F7RGKO0oMvpDwEL+D3GTd46wJzRBeVPzxxD8K3YQAN9ZBi5oS01UdWyoV0gqK994srCknXMjUrgX4BU8VPydPkBE06cYk2uu3a+O9kr1sAkwDJimgREi4gyREWBCM7PEJpF0gv4+XmCbpc80QEVhSNaiKEJCGncV88jEqwOSekqTa4JIOJYt4XHUxyI8JZwF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDheWDcFY1UOfZNDDR3Ro6TWoqNe0RMuul5g/vnPZv0=;
 b=QddyfJGCs4W3l02whqsE8a99gbCy4Z2o0/Jmh3iD+RMKTkhpXPGggmsclLgRL+Bh2SYc/0BgY6QRI1O86U18iMRXXkNC0B0VXiei5tsTeXeGiveEhMsNuyYLu+A63uQV/Uff2/vP0FyxA1YLXm48Tj5qjUr/rTHbN3AVINSYBmlpc5dIk1aD5KTe0sjJmKMse3CjLZEeMIJner9kDM9aK5fQqRDODMvyE3ZxbIdV2dM8UDCskMrfggamQmjw3LuMB6kD1Cwgn6HnYOs1SI8w4JM3qen6Jbr+JcLh0DvjkssqNS1sHy6Sd0qqhgh7/gWfgketqsmaFWzuR5Vm9t70GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDheWDcFY1UOfZNDDR3Ro6TWoqNe0RMuul5g/vnPZv0=;
 b=rgSP7jHkpwgDr+eWFzfbvTxTxdZ4Fi4uRSLg00rgdKKwxMngOIW4m3se7rLDjuvdPgpzUOlSiQbg0TvLrdJsD2k1hZ4ha64qxJ4DNTjfUQWZPnhjmP1vewZ/EKl9AsL8+gBv0mcDv69teTtWqFTVIIuFBa0K3HadgCcVhRv8eMHc9/rUmRy17k5ZFDzsLlvpamEz5TjuD2WwH+c4SRwrvgoFXwuikn8aAVKVVhjzUYntXz5YsHLUdxq4syHkn/4nWbsugdrTkGRPlPl08cIy61d5Jk9M6L0G3yF+Q1pHb1eiLu57WOSucBbM1VtJZ88NlLK9oWbuVqHJzoH0xUgEVg==
Received: from PR3PR09CA0014.eurprd09.prod.outlook.com (2603:10a6:102:b7::19)
 by PATP264MB7540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:58d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:23 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b7:cafe::4) by PR3PR09CA0014.outlook.office365.com
 (2603:10a6:102:b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:23 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 14DF8203AA;
 Fri,  4 Sep 2026 10:37:23 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 14/15] test: py: vboot: prepare test for global signature
 with ecdsa
Date: Fri,  4 Sep 2026 10:37:18 +0200
Message-ID: <20260904083719.53132-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PATP264MB7540:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b05b5074-c787-422a-b9b6-08df0a5fbdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: T+GhaKxlvn/NZVLWtZKUoA74RazH2bSr2rcChJuUSD5woHWBWQSe7VasSXScUKCL9R1j0cgcFcLmkxwYjmwpTkPuOF4AUTXpu3TicL4bqIyW1cvX+vzFnzheae8CxVXQUG/SCZGcZ8KVRnUl1WYu39jsAN07evB0gW7ZyPV1chTWddGeucfmsc+lNdMMG8GD4ciDVmvxGjgLrN2ibihc2pVcD3oq6uX7zV4eoXy6bMZSxUVNqf09gcw/qpgq5BEO04ynLCgL4TjF856NtNJ6qzgwoaREU5HUdCjqx1aGIbBecp5fsxnMrOm5jKTeh07s1dKgd5YBYMgzN1H+pqb6+2AurIPz8wYhbYBCnh3QKZ3DoNkJMubg7Oab/xujGS2NejQSW7VV+XeZNavjemdau4kVKLEpHMnyfORsXASDIQPkGhQr67asIccr+bbugrPUBfcgX1ASxlbnrwa+CGoWzqtlaWrLDtPFV/g94xJs1J9b0xBBXOFRm8pn5DqNQ9swIB9jT5rvGPz93Skmc2K/N2aq7dRhj565phmwsTzIHEv6zZmNvDd0bUQjX9zOURLnfNzjipphDW5GNMi7ohcfYH/zlhogf3UXtqf1GEiOtOkz1zdRhxvNlhDDNHhfV2cfFMe7iNT7VnOrIJ2KIoSYNLs1bgMz6f0uOg4fkVtSYdDzlONXBUG1FbPe/ZwiVgHbqzYzIvJU05TFDCWWq2aIRA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jDwqfm/7B5KCR19tIkGanb8yDKIF3zLEVh11OGjnBBw/x/riWfStlPrLev4S0zDian2cVTIIrA5cNfC4pih0uprM6lMfB06Sg12ojlSsb93DYcdSuB+gHwgXquocMjOZO8E+0SXR7t39nDqxpKe1SpqHVG3hd2cOFKRwSVvmSrYliKMEYmdouma+6kbRP+s9AQwQ/uwDXJVAP4MoM80/Hq7AStnjproj4hr2FU3GyG0poejcWflJgd2r2URulzwL6SffkRbWy1VZdrr2yo+sfMXndw5v5nj0EY1inkTlC5Uc/KN6tbWV8O8xxVwV0YXw6oP4ZDLWffjSXzclAxhyPdAPxuGv3fAoli/sFcGV4/W8Huz26TawBLzYxHCL84NAyIP9Uq2U40vgoTSQQgr/1B1k+FFpRdFCuB3nuPvY60twe7vkJSmMSf0ancAgV2yU
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:23.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05b5074-c787-422a-b9b6-08df0a5fbdd1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB7540
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

The vboot tests only consider rsa for test with global signature.
To prepare the integration of test with ecdsa test, the signature
algo is now explicit.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- no change
v5:
- no change
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

 test/py/tests/test_vboot.py                          | 12 ++++++------
 ...binman-pss.dts => sandbox-binman-rsa2048-pss.dts} |  0
 ...sandbox-binman.dts => sandbox-binman-rsa2048.dts} |  0
 ...pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} |  0
 ...-global.dts => sandbox-u-boot-global-rsa2048.dts} |  0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename test/py/tests/vboot/{sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} (100%)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 89876ff030a..e3996486ab6 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -536,7 +536,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                           dtb)
         run_bootm(sha_algo, 'multi required key', '', False)
 
-    def test_global_sign(sha_algo, padding, sign_options):
+    def test_global_sign(sha_algo, sig_algo, padding, sign_options):
         """Test global image signature with the given hash algorithm and padding.
 
         Args:
@@ -545,14 +545,14 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                     rsa signature algorithm.
         """
 
-        dtb = '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
+        dtb = '%ssandbox-u-boot-global%s%s.dtb' % (tmpdir, sig_algo, padding)
         ubman.config.dtb = dtb
 
         # Compile our device tree files for kernel and U-Boot. These are
         # regenerated here since mkimage will modify them (by adding a
         # public key) below.
         dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
-        dtc_options('sandbox-u-boot-global%s.dts' % padding, '-p 1024')
+        dtc_options('sandbox-u-boot-global%s%s.dts' % (sig_algo, padding), '-p 1024')
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
@@ -561,11 +561,11 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
 
         # Build the dtb for binman that define the pre-load header
         # with the global sigature.
-        dtc('sandbox-binman%s.dts' % padding, ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-binman%s%s.dts' % (sig_algo, padding), ubman, dtc_args, datadir, tmpdir, dtb)
 
         # Run binman to create the final image with the not signed fit
         # and the pre-load header that contains the global signature.
-        run_binman('sandbox-binman%s.dtb' % padding)
+        run_binman('sandbox-binman%s%s.dtb' % (sig_algo, padding))
 
         # Check that the signature is correctly verified by u-boot
         run_bootm(sha_algo, 'global image signature',
@@ -615,7 +615,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
     try:
         ubman.config.dtb = dtb
         if global_sign:
-            test_global_sign(sha_algo, padding, sign_options)
+            test_global_sign(sha_algo, sig_algo, padding, sign_options)
         elif required:
             test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
diff --git a/test/py/tests/vboot/sandbox-binman-pss.dts b/test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-binman-pss.dts
rename to test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
diff --git a/test/py/tests/vboot/sandbox-binman.dts b/test/py/tests/vboot/sandbox-binman-rsa2048.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-binman.dts
rename to test/py/tests/vboot/sandbox-binman-rsa2048.dts
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-pss.dts b/test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-u-boot-global-pss.dts
rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
diff --git a/test/py/tests/vboot/sandbox-u-boot-global.dts b/test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-u-boot-global.dts
rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
-- 
2.43.0

