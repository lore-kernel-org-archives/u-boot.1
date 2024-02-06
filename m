Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02838C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 16:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B61187CA6;
	Tue,  6 Feb 2024 17:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="oCj75vCA";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="oCj75vCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C891687CAA; Tue,  6 Feb 2024 17:36:38 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC6586284
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 17:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Pz3VmJ7jz8aP+B+YrhSUEUodu1+M/pKjlAey01pR9kMq7LlAAUOnknFbHkL+03GGh3Y54146To0TQJWGTUAwI7xmmZtaYpMtm1E9pDWfIEEZW+kBJcPHgWU/cB6Ucd4BPqqZma8tKPrOHquu7/XvxJNWqXu4+uNOzeB/M0rZSdBsRiVUCBgLcRltAx0DLVYRF7ZcTfhZq553W9TjJfVn9IG9dWXpo+mfNeAD5bNuYwC7TjmirFfBcy0jb4ncVvP9UJRXgXHYmALuymTbCwcP8eLg8z4hhT5FkV0/W2eJ74pgNk992qA9vrJCS8h1YxqKLIqcl5gre/vWa1nELOt6Xw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoJ/0NOcfX4polS85s/Qx47xuFYjkz6Bp7oorgwaVQc=;
 b=kYQrC3yDhiet6tnoH08V2FWs/xI26LKcYmW4Wmtw9Na3vtrkhzRn2ialVg5kCLlpIdzCdHGk49OBPXEOfLFPKdO5DIb5Ai+lf4ekkajkej6d39NX+8lBfkltE+TFf9+Z4rRY/5mAE361ilUIBr6vOHT2r1UH0Mm+6bdSgKwKCnmtvd3MGqiBEYS7OZARfIN5CXXzIIjREQZMy0bCLSJOS/ImI2WXOtAvEbJOLUzYJ1DKSgj27iuF1mXZfd7038jChhjlrRFGHjS1+qXKewCgDdCgirLH9NUCU1uBc6QmwK5KvR93Yd5qyCb8hSVx7+5JHHxF2VVvdazTDBJQYS0ckA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=chromium.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoJ/0NOcfX4polS85s/Qx47xuFYjkz6Bp7oorgwaVQc=;
 b=oCj75vCAB5IaVxHSzXdHSbZyMCdktOgIRIMHCQFPCQo/8GB1LfYfy0PN00API2Yd8+CAA0J7yR1iWxxiQApEyao73w1iaN99mSk9p/5Y459mhM9RhFrDf2qB2SpMWl+60V9Ihxmngea7IFPoZXzQcLiHkmMMdgvnkWqdb/DAFEA5uuw89UKG1C9yywQ1MxuqUyxAYkNw2mE2tSp+MfARcuz1nFQZjqNHZsStp82yUt6NnYwwj4aGdwchLIkTxoX5MHYxK37eBF9qNAsEBEmAgMkwEjB+ack87dV/umy+/dBh4BhZiTflPgOKrUwpbT71jiHhFIRiVMUfFHRNd8Io3g==
Received: from AS9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::7) by PAXPR03MB7982.eurprd03.prod.outlook.com
 (2603:10a6:102:21c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 16:36:32 +0000
Received: from AM6EUR05FT046.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:542:cafe::70) by AS9PR01CA0028.outlook.office365.com
 (2603:10a6:20b:542::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 16:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM6EUR05FT046.mail.protection.outlook.com (10.233.241.175) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7270.18
 via Frontend Transport; Tue, 6 Feb 2024 16:36:32 +0000
Received: from outmta (unknown [192.168.82.135])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 73FBF20080F8A; Tue,  6 Feb 2024 16:36:32 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.14.51])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 0F5F12008006F; 
 Tue,  6 Feb 2024 16:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adRuy4TOvyJHRLR2gvzEiddv2iHN0DxIyZXdg3ZC5ZK2PIfgEp5J1Uv8lTRexd46jOQ6ChLxx5VH1T3IlxF8ERDuQOdPm2DqdzHHLfFSGVNp2XWUT1fvKzUqCylYFmbLtcHRAa5MGSQWr810Vt7nfVqKHgZVgLUlrS335fUnQOZ+PO2J4ecSvrxCEqLM1tSUnAvBp2mb4mWRHaH/gANDX2poYg/NeOeB+sIQzRSyORd0ExB9DnK9cQ6Y3n6in7xLxFf8vLRQ/SmKV727NP6WhrXiuxRSSbehmbaPgaNKu1D91YzkuvYLb7Scn4AzOhAWMV1zlbEtBuqM56mgf8JQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoJ/0NOcfX4polS85s/Qx47xuFYjkz6Bp7oorgwaVQc=;
 b=YObs0s634HfDVbmZL/psATaMI91OMON8VfxX2rFiji4vlUJ9+jRjGNWrR3NoF8f8kla39hVyATnqBek/STjAJuQeu8QGVV3UtX0VG/WQ1I+iCj8jgJ3tllAYoy6z+X1E9AcJPaHW41e/FwA9clKtiW9HFi074tl4eNCRT5C64koMbsm4BSDnxhCXSb4IA8LTKEc4MBxFmB8GVIISYwxW2vo+/MpTPvTS10Fc8rGN1slcox3uAlLdvmgzCScZ07tBX2wpCwQw9wjDOokEnCG7hLqShK0gnCgVUGQCRA7av8Wuq9A+MBlVVY/tofl/ilZ7s+H0/jP5i8n0zgOEqbIWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoJ/0NOcfX4polS85s/Qx47xuFYjkz6Bp7oorgwaVQc=;
 b=oCj75vCAB5IaVxHSzXdHSbZyMCdktOgIRIMHCQFPCQo/8GB1LfYfy0PN00API2Yd8+CAA0J7yR1iWxxiQApEyao73w1iaN99mSk9p/5Y459mhM9RhFrDf2qB2SpMWl+60V9Ihxmngea7IFPoZXzQcLiHkmMMdgvnkWqdb/DAFEA5uuw89UKG1C9yywQ1MxuqUyxAYkNw2mE2tSp+MfARcuz1nFQZjqNHZsStp82yUt6NnYwwj4aGdwchLIkTxoX5MHYxK37eBF9qNAsEBEmAgMkwEjB+ack87dV/umy+/dBh4BhZiTflPgOKrUwpbT71jiHhFIRiVMUfFHRNd8Io3g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DBBPR03MB10535.eurprd03.prod.outlook.com (2603:10a6:10:53d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 16:36:25 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 16:36:24 +0000
Message-ID: <4ce463f0-f010-4735-97ee-75097b87f0e1@seco.com>
Date: Tue, 6 Feb 2024 11:36:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] board: Add support for Conclusive WHLE-LS1046A
Content-Language: en-US
To: Artur Rojek <artur@conclusive.pl>, Peng Fan <peng.fan@nxp.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass
 <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Tom Rini <trini@konsulko.com>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?Q?Rados=C5=82aw_Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de
References: <20231128103457.45802-1-artur@conclusive.pl>
 <20231128103457.45802-3-artur@conclusive.pl>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231128103457.45802-3-artur@conclusive.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DBBPR03MB10535:EE_|AM6EUR05FT046:EE_|PAXPR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4aa07b-0411-4aa0-5909-08dc2731c711
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6lpwsbf1b+ttSkfrJ0q4A8LaeH4vfijaAlNZrhemv1LUH9D4a9bwp0JqwK4O/emK9bonwAqM+m3qx3Hg8wA0qRXezOttpTDVivfMmJsbp/Jq6Bd2/1DlyJuIPw4hHGqGqhvLCOF9VmcS1X+N8mFHiVpyY05gx/ndYNgjbvywaR0/0rKg/BPNKKrjS4ruQjBoHBhMW7+a6umNeMP9rKex1im9Pi/q0h06hVT+i+MS9H2I7/qrBYmDDxRqCWtrS+NtBDHw9wMduGSmx64FFrzJ8ypHl0X0Lc4fiZC4eHuRGbdTQ3k7MQBGBp+YB4rTgNeDHVUCJunZFjHiYLdzWOhHuTCcQmKVB0ow79vyOaiWvHra6vGV5k19FFXQfS55b6vfQ0ztuEWrBEP3l5qDlR8WBfL4e8JC30qux/IGH1ev+QKfguoSY63/3gOH+U57i3kj8PoHEya6BpToRmmovT8+Qz5nBmSqtYTyRUlhhhwC4tGVWBV5WADdSULJgarbC40z0og78FrTsN63SSyKLVAWI2Kl0jd4YETWi0YL3QF+375O81vpNFYrhdVKoxcWYVS80N5S3jj0ZnipOBLGnZFnQiO0SzNFHex7cctDGYzgmMegBEBPvN++s1RFwNW65J7QJqjUCg90QFPz55sTEuwGDvyra5jZBSMKdBgLqp7xVDE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39850400004)(396003)(346002)(376002)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2906002)(31686004)(44832011)(30864003)(8936002)(8676002)(4326008)(110136005)(5660300002)(66476007)(66556008)(66946007)(54906003)(316002)(2616005)(478600001)(966005)(6486002)(6666004)(52116002)(31696002)(53546011)(38350700005)(6512007)(36756003)(26005)(86362001)(83380400001)(38100700002)(41300700001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10535
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT046.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6d32f993-bdb6-45b8-c245-08dc2731c221
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km54V98iNM0oEPoMloxbYvDn0gbwIwf0emvylODtvlPRO7CJQ1sakKNgapZ1SHIcR9UPENyGYf3BhUUsn9f3bkkf7ID8Xasly9J/9a2rxsC3LAfdbX4ijuM8sVm+Z53bdkSBQR5R+2BWK9w/IWfykEgs8hvaJQA4JVz3wnRLp6JiuvhsS7sEpV92rW38lo2b80+AHQMwNEtJ/ucl3mSzyoOJATbXy1VgCJlYElZpo+88RBicgkB+6vZhBFDUnrJ5W8Sb6pDp26E5I3CTRjFKmW+/SuWVjaZY3suL5X5dDh3rwbGImk957cDww0RTEPwpw9ckwXEFlAMZzbIRaExmhRsSIX/3MJulj3YiVIrB2iubGFy1Dped7smjkY9vxQwwU0jQJ1fabf/ilBfJHCoguTRiACvqz8OWY+QGM7W05gNfyYEtzvz81Y+SspaqM5af/E0rl1Z4gTysZTw803npWLdAznR7Jmo10xXzXwmGWVWaMpI8i7vG8SXVswGVFFmMRFQ35swJJZwjkgJiNiL9HtbLIitFZdbx6AO0aOvJLZ0dvC0R/TcHEXPn/vOzBD4KwvmVXpKN0Ljg0YfotFORUtyd/6pVsjeN0GpB1YsecpmVSbEKgxEvcbku0CGGRWsko+HDkd/2p0SGXWQRe5tz6wMD7SQ5FNOP1VF5qlziilt/zIusPRYB9a596Gg8BbUb7he5m646p5TCWsM7eQBcLnWq7fp83NmbP4jAheiqelZrGzi5TZ9LcI46dQDrz4u0EKbI8GrXOWthEYfRjKmTZsD5XVEOz1FZhXNxNswEzf4=
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39850400004)(396003)(230922051799003)(230273577357003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(47076005)(82740400003)(7636003)(7596003)(31686004)(356005)(36860700001)(53546011)(6666004)(40460700003)(40480700001)(34070700002)(83380400001)(6506007)(31696002)(26005)(86362001)(41300700001)(336012)(2616005)(36756003)(4326008)(8936002)(8676002)(6512007)(44832011)(2906002)(478600001)(30864003)(6486002)(5660300002)(966005)(70586007)(70206006)(316002)(54906003)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 16:36:32.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4aa07b-0411-4aa0-5909-08dc2731c711
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT046.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7982
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

On 11/28/23 05:34, Artur Rojek wrote:
> Introduce support for Conclusive WHLE-LS1046A Single Board Computer.
> 
> Co-developed-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
> 
> v3: no change
> 
> v2: - drop non-DM_ETH case
>     - clean-up defines in configs/whle_ls1046a.h: remove unneeded ones,
>       move others to appropriate files in board directory
>     - move environment variables to whle-ls1046a.env
>     - move away from distro_bootcmd and use BOOTSTD 
>     - fix i2c-mux node parent and ext_i2c address in Device Tree
>     - style changes to eth.c
>     - fix CONFIG_MTDPARTS_DEFAULT value in defconfigs
> 
>  arch/arm/Kconfig                              |  19 ++
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/fsl-ls1046a-whle.dts             | 208 +++++++++++++++++
>  board/conclusive/whle-ls1046a/Kconfig         |  15 ++
>  board/conclusive/whle-ls1046a/MAINTAINERS     |   9 +
>  board/conclusive/whle-ls1046a/Makefile        |   7 +
>  board/conclusive/whle-ls1046a/ddr.c           |  21 ++
>  board/conclusive/whle-ls1046a/eth.c           |  65 ++++++
>  board/conclusive/whle-ls1046a/whle-ls1046a.c  | 215 ++++++++++++++++++
>  .../conclusive/whle-ls1046a/whle-ls1046a.env  |  13 ++
>  configs/whle_ls1046a_emmc_defconfig           |  83 +++++++
>  configs/whle_ls1046a_qspi_defconfig           |  84 +++++++
>  include/configs/whle_ls1046a.h                |  47 ++++
>  13 files changed, 787 insertions(+)
>  create mode 100644 arch/arm/dts/fsl-ls1046a-whle.dts
>  create mode 100644 board/conclusive/whle-ls1046a/Kconfig
>  create mode 100644 board/conclusive/whle-ls1046a/MAINTAINERS
>  create mode 100644 board/conclusive/whle-ls1046a/Makefile
>  create mode 100644 board/conclusive/whle-ls1046a/ddr.c
>  create mode 100644 board/conclusive/whle-ls1046a/eth.c
>  create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.c
>  create mode 100644 board/conclusive/whle-ls1046a/whle-ls1046a.env
>  create mode 100644 configs/whle_ls1046a_emmc_defconfig
>  create mode 100644 configs/whle_ls1046a_qspi_defconfig
>  create mode 100644 include/configs/whle_ls1046a.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d812685c9842..609571e6e421 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1851,6 +1851,24 @@ config TARGET_SL28
>  	help
>  	  Support for Kontron SMARC-sAL28 board.
>  
> +config TARGET_WHLE_LS1046A
> +	bool "Support Conclusive WHLE-LS1046A"
> +	select ARCH_LS1046A
> +	select ARM64
> +	select ARMV8_MULTIENTRY
> +	select ARCH_SUPPORT_TFABOOT
> +	select BOARD_EARLY_INIT_F
> +	select BOARD_LATE_INIT
> +	select GPIO_EXTRA_HEADER
> +	select DM_SPI_FLASH if DM_SPI
> +	imply SCSI
> +	help
> +	  Support for Conclusive WHLE-LS1046A platform.
> +	  The WHLE-LS1046A is a high-performance Single Board Computer with
> +	  extensive connectivity features that supports the QorIQ LS1046A
> +	  Layerscape Architecture processor:
> +	  https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fconclusive.tech%2fproducts%2fwhle%2dls1%2dsbc%2f&umid=bfe70e04-e3cb-4832-a510-cd7686941d3c&auth=d807158c60b7d2502abde8a2fc01f40662980862-65691d364ff53ae48e02cdbc52323838b4503b62
> +
>  config TARGET_TEN64
>  	bool "Support ten64"
>  	select ARCH_LS1088A
> @@ -2299,6 +2317,7 @@ source "board/cortina/presidio-asic/Kconfig"
>  source "board/broadcom/bcmns/Kconfig"
>  source "board/broadcom/bcmns3/Kconfig"
>  source "board/cavium/thunderx/Kconfig"
> +source "board/conclusive/whle-ls1046a/Kconfig"
>  source "board/eets/pdu001/Kconfig"
>  source "board/emulation/qemu-arm/Kconfig"
>  source "board/freescale/ls2080aqds/Kconfig"
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 1be08c5fdc2e..8dcbf29df363 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -615,6 +615,7 @@ dtb-$(CONFIG_FSL_LSCH2) += fsl-ls1043a-qds-duart.dtb \
>  	fsl-ls1046a-qds-lpuart.dtb \
>  	fsl-ls1046a-rdb.dtb \
>  	fsl-ls1046a-frwy.dtb \
> +	fsl-ls1046a-whle.dtb \
>  	fsl-ls1012a-qds.dtb \
>  	fsl-ls1012a-rdb.dtb \
>  	fsl-ls1012a-2g5rdb.dtb \
> diff --git a/arch/arm/dts/fsl-ls1046a-whle.dts b/arch/arm/dts/fsl-ls1046a-whle.dts
> new file mode 100644
> index 000000000000..1aed3e8c4701
> --- /dev/null
> +++ b/arch/arm/dts/fsl-ls1046a-whle.dts
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR X11
> +/*
> + * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/dts-v1/;
> +#include "fsl-ls1046a.dtsi"
> +
> +/ {
> +	model = "Conclusive WHLE-LS1046A";
> +	compatible = "conclusive,whle-ls1046a", "fsl,ls1046a";
> +
> +	chosen {
> +		stdout-path = &duart0;
> +	};
> +
> +	aliases {
> +		spi0 = &qspi;
> +	};
> +};
> +
> +&soc {
> +	pcie@3400000 {
> +		status = "okay";
> +	};
> +};
> +
> +&qspi {
> +	status = "okay";
> +
> +	gd25lq128: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +
> +		partitions {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fixed-partitions";
> +
> +			partition@0 {
> +				label = "bl2";
> +				reg = <0 0x100000>;
> +			};
> +
> +			partition@100000 {
> +				label = "fip1";
> +				reg = <0x100000 0x400000>;
> +			};
> +
> +			partition@500000 {
> +				label = "fip2";
> +				reg = <0x500000 0x400000>;
> +			};
> +
> +			partition@900000 {
> +				label = "uboot-env";
> +				reg = <0x900000 0x10000>;
> +			};
> +
> +			partition@910000 {
> +				label = "fman-firmware";
> +				reg = <0x910000 0x200000>;
> +			};
> +
> +			partition@a10000 {
> +				label = "dtb";
> +				reg = <0xa10000 0x10000>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	spd@50 {
> +		compatible = "spd";
> +		reg = <0x50>;
> +		status = "okay";
> +	};
> +
> +	eeprom@56 {
> +		compatible = "atmel,24c64";
> +		reg = <0x56>;
> +		status = "okay";
> +	};
> +
> +	eeprom@57 {
> +		compatible = "24c01";
> +		reg = <0x57>;
> +		status = "okay";
> +	};
> +
> +	leds@62 {
> +		compatible = "nxp,pca9633";
> +		reg = <0x62>;
> +		status = "okay";
> +	};
> +
> +	rtc@6f {
> +		compatible = "microchip,mcp7941x";
> +		reg = <0x6f>;
> +		status = "okay";
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		status = "okay";
> +
> +		pcie0_i2c: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		sfp0_i2c: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		sfp1_i2c: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		ext_i2c: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +#include "fsl-ls1046-post.dtsi"
> +
> +&fman0 {
> +	ethernet@e4000 {
> +		phy-handle = <&rgmii_phy0>;
> +		phy-connection-type = "rgmii-id";
> +		status = "okay";
> +	};
> +
> +	ethernet@e6000 {
> +		phy-handle = <&rgmii_phy1>;
> +		phy-connection-type = "rgmii-id";
> +		status = "okay";
> +	};
> +
> +	ethernet@e8000 {
> +		phy-handle = <&sgmii_phy2>;
> +		phy-connection-type = "sgmii";
> +		status = "okay";
> +	};
> +
> +	ethernet@ea000 {
> +		phy-handle = <&sgmii_phy3>;
> +		phy-connection-type = "sgmii";
> +		status = "okay";
> +	};
> +
> +	ethernet@f0000 { /* 10GEC1 */
> +		fixed-link = <0 1 1000 0 0>;

Should this be

	managed = "in-band-status";
	sfp = <&sfp0>;

or do you actually have a fixed link

> +		phy-connection-type = "xgmii";

Should be 10gbase-x

> +		status = "okay";
> +	};
> +
> +	ethernet@f2000 { /* 10GEC2 */
> +		fixed-link = <0 1 1000 0 0>;
> +		phy-connection-type = "xgmii";
> +		status = "okay";
> +	};
> +
> +	mdio@fc000 {
> +		rgmii_phy0: ethernet-phy@1 {
> +			reg = <0x1>;

Missing compatible.

> +		};
> +
> +		rgmii_phy1: ethernet-phy@2 {
> +			reg = <0x2>;
> +		};
> +
> +		sgmii_phy2: ethernet-phy@3 {
> +			reg = <0x3>;
> +		};
> +
> +		sgmii_phy3: ethernet-phy@4 {
> +			reg = <0x4>;
> +		};
> +	};
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> diff --git a/board/conclusive/whle-ls1046a/Kconfig b/board/conclusive/whle-ls1046a/Kconfig
> new file mode 100644
> index 000000000000..5778fbd5cd22
> --- /dev/null
> +++ b/board/conclusive/whle-ls1046a/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_WHLE_LS1046A
> +
> +config SYS_BOARD
> +	default "whle-ls1046a"
> +
> +config SYS_VENDOR
> +	default "conclusive"
> +
> +config SYS_SOC
> +	default "fsl-layerscape"
> +
> +config SYS_CONFIG_NAME
> +	default "whle_ls1046a"
> +
> +endif
> diff --git a/board/conclusive/whle-ls1046a/MAINTAINERS b/board/conclusive/whle-ls1046a/MAINTAINERS
> new file mode 100644
> index 000000000000..1dcf067a06d8
> --- /dev/null
> +++ b/board/conclusive/whle-ls1046a/MAINTAINERS
> @@ -0,0 +1,9 @@
> +WHLE-LS1046A Board
> +M:	Jakub Klama <jakub@conclusive.pl>
> +M:	Artur Rojek <artur@conclusive.pl>
> +S:	Maintained
> +F:	board/conclusive/whle-ls1046a
> +F:	include/configs/whle_ls1046a.h
> +F:	configs/whle_ls1046a_emmc_defconfig
> +F:	configs/whle_ls1046a_qspi_defconfig
> +F:	arch/arm/dts/fsl-ls1046a-whle.dts
> diff --git a/board/conclusive/whle-ls1046a/Makefile b/board/conclusive/whle-ls1046a/Makefile
> new file mode 100644
> index 000000000000..9197ec93a6de
> --- /dev/null
> +++ b/board/conclusive/whle-ls1046a/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> +
> +obj-y += ddr.o
> +obj-y += whle-ls1046a.o
> +obj-$(CONFIG_NET) += eth.o
> diff --git a/board/conclusive/whle-ls1046a/ddr.c b/board/conclusive/whle-ls1046a/ddr.c
> new file mode 100644
> index 000000000000..cbefc779d55d
> --- /dev/null
> +++ b/board/conclusive/whle-ls1046a/ddr.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 NXP
> + * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#include <config.h>
> +#include <fsl_ddr_sdram.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int fsl_initdram(void)
> +{
> +	gd->ram_size = tfa_get_dram_size();
> +
> +	if (!gd->ram_size)
> +		gd->ram_size = fsl_ddr_sdram_size();
> +
> +	return 0;
> +}
> diff --git a/board/conclusive/whle-ls1046a/eth.c b/board/conclusive/whle-ls1046a/eth.c
> new file mode 100644
> index 000000000000..05b83352b0ab
> --- /dev/null
> +++ b/board/conclusive/whle-ls1046a/eth.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 NXP
> + * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +#include <config.h>
> +#include <fdt_support.h>
> +#include <net.h>
> +#include <asm/io.h>
> +#include <netdev.h>
> +#include <fm_eth.h>
> +#include <fsl_dtsec.h>
> +#include <fsl_mdio.h>
> +
> +#define RGMII_PHY1_ADDR	0x01
> +#define RGMII_PHY2_ADDR	0x02
> +#define SGMII_PHY3_ADDR	0x03
> +#define SGMII_PHY4_ADDR	0x04
> +
> +int board_eth_init(struct bd_info *bis)
> +{
> +#ifdef CONFIG_FMAN_ENET
> +	struct memac_mdio_info dtsec_mdio_info;
> +	struct memac_mdio_controller *regs;
> +	struct mii_dev *dev;
> +	u32 srds;
> +	struct ccsr_gur *gur = (struct ccsr_gur *)(CFG_SYS_FSL_GUTS_ADDR);
> +
> +	srds = in_be32(&gur->rcwsr[4]) & FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
> +	srds >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
> +
> +	if (srds != 0x1133 && srds != 0x3333)
> +		printf("Invalid SerDes protocol 0x%x for WHLE-LS1046A\n", srds);
> +
> +	regs = (struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
> +	dtsec_mdio_info.regs = regs;
> +	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
> +
> +	/* Register the 1G MDIO bus */
> +	fm_memac_mdio_init(bis, &dtsec_mdio_info);
> +
> +	/* RGMII on MAC 3 and 4, SGMII on MAC 5 and 6 */
> +	fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY1_ADDR);
> +	fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY2_ADDR);
> +	fm_info_set_phy_address(FM1_DTSEC5, SGMII_PHY3_ADDR);
> +	fm_info_set_phy_address(FM1_DTSEC6, SGMII_PHY4_ADDR);
> +
> +	dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
> +	fm_info_set_mdio(FM1_DTSEC3, dev);
> +	fm_info_set_mdio(FM1_DTSEC4, dev);
> +	fm_info_set_mdio(FM1_DTSEC5, dev);
> +	fm_info_set_mdio(FM1_DTSEC6, dev);
> +
> +	cpu_eth_init(bis);
> +#endif
> +
> +	return pci_eth_init(bis);
> +}
> +
> +#ifdef CONFIG_FMAN_ENET
> +int fdt_update_ethernet_dt(void *blob)
> +{
> +	return 0;
> +}
> +#endif
> diff --git a/board/conclusive/whle-ls1046a/whle-ls1046a.c b/board/conclusive/whle-ls1046a/whle-ls1046a.c
> new file mode 100644
> index 000000000000..6b4bd149cdb2
> --- /dev/null
> +++ b/board/conclusive/whle-ls1046a/whle-ls1046a.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * whle-ls1046a.c - Board init file for Conclusive WHLE-LS1046A board
> + * Copyright (C) 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#include <config.h>
> +#include <i2c.h>
> +#include <fdt_support.h>
> +#include <init.h>
> +#include <env.h>
> +#include <asm/io.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/fsl_serdes.h>
> +#include <asm/arch/soc.h>
> +#include <asm/arch-fsl-layerscape/fsl_icid.h>
> +#include <hwconfig.h>
> +#include <ahci.h>
> +#include <mmc.h>
> +#include <scsi.h>
> +#include <fm_eth.h>
> +#include <fsl_csu.h>
> +#include <fsl_esdhc.h>
> +#include <fsl_sec.h>
> +#include <fsl_dspi.h>
> +
> +#define	BOARD_REV_MASK	0x0f
> +#define	SPI_MCR_REG	0x2100000
> +
> +/* Retimer */
> +#define I2C_RETIMER_BUS				0
> +#define I2C_RETIMER_ADDR			0x18
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static inline void set_spi_cs_signal_inactive(void)
> +{
> +	/* default: all CS signals inactive state is high */
> +	uint mcr_val;
> +	uint mcr_cfg_val = DSPI_MCR_MSTR | DSPI_MCR_PCSIS_MASK |
> +				DSPI_MCR_CRXF | DSPI_MCR_CTXF;
> +
> +	mcr_val = in_be32(SPI_MCR_REG);
> +	mcr_val |= DSPI_MCR_HALT;
> +	out_be32(SPI_MCR_REG, mcr_val);
> +	out_be32(SPI_MCR_REG, mcr_cfg_val);
> +	mcr_val = in_be32(SPI_MCR_REG);
> +	mcr_val &= ~DSPI_MCR_HALT;
> +	out_be32(SPI_MCR_REG, mcr_val);

Shouldn't the SPI driver handle this?

> +}
> +
> +int board_early_init_f(void)
> +{
> +	fsl_lsch2_early_init_f();
> +
> +	return 0;
> +}
> +
> +static inline uint8_t get_board_version(void)
> +{
> +	struct ccsr_gur __iomem *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
> +
> +	return in_be32(&gur->gpporcr1) & BOARD_REV_MASK;
> +}
> +
> +static int settings_r(void)
> +{
> +	serial_read_from_eeprom(0);
> +
> +	return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
> +
> +#if defined(CONFIG_DISPLAY_BOARDINFO_LATE)
> +int checkboard(void)
> +{
> +	const char *serial_number = env_get("serial#");
> +
> +	printf("Board: WHLE-LS1046A, Rev: %s\n",
> +	       get_board_version() == 0x00 ? "0" : "unknown");
> +
> +	if (!serial_number)
> +		printf("Warning: unknown serial number.\n");
> +	else
> +		printf("S/N:   %s\n", serial_number);
> +
> +	return 0;
> +}
> +#endif
> +
> +static void board_retimer_init_rx(struct udevice *dev, int chnum)
> +{
> +	/* Select channel */
> +	dm_i2c_reg_write(dev, 0xff, chnum);
> +
> +	/* Initialize receive channel */
> +	dm_i2c_reg_clrset(dev, 0x00, 0x04, 0x04);
> +	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x0c);
> +	dm_i2c_reg_clrset(dev, 0x2f, 0xf0, 0xc0);
> +	dm_i2c_reg_clrset(dev, 0x31, 0x60, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x03, 0xff, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x3a, 0xff, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x40, 0xff, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x1e, 0x08, 0x08);
> +	dm_i2c_reg_clrset(dev, 0x2d, 0x08, 0x08);
> +	dm_i2c_reg_clrset(dev, 0x2d, 0x07, 0x02);
> +	dm_i2c_reg_clrset(dev, 0x15, 0x47, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x00);
> +}
> +
> +static void board_retimer_init_tx(struct udevice *dev, int chnum)
> +{
> +	/* Select channel */
> +	dm_i2c_reg_write(dev, 0xff, chnum);
> +
> +	/* Initialize transmit channel */
> +	dm_i2c_reg_clrset(dev, 0x00, 0x04, 0x04);
> +	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x0c);
> +	dm_i2c_reg_clrset(dev, 0x2f, 0xf0, 0xc0);
> +	dm_i2c_reg_clrset(dev, 0x31, 0x20, 0x20);
> +	dm_i2c_reg_clrset(dev, 0x3a, 0xff, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x1e, 0x08, 0x08);
> +	dm_i2c_reg_clrset(dev, 0x2d, 0x07, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x15, 0x47, 0x00);
> +	dm_i2c_reg_clrset(dev, 0x0a, 0x0c, 0x00);
> +}
> +
> +static void board_retimer_init(void)
> +{
> +	struct udevice *dev;
> +
> +	i2c_get_chip_for_busnum(I2C_RETIMER_BUS, I2C_RETIMER_ADDR, 1, &dev);
> +	board_retimer_init_tx(dev, 0x04);
> +	board_retimer_init_rx(dev, 0x05);
> +	board_retimer_init_tx(dev, 0x06);
> +	board_retimer_init_rx(dev, 0x07);
> +}
> +
> +int board_init(void)
> +{
> +#ifdef CONFIG_NXP_ESBC
> +	/*
> +	 * In case of Secure Boot, the IBR configures the SMMU
> +	 * to allow only Secure transactions.
> +	 * SMMU must be reset in bypass mode.
> +	 * Set the ClientPD bit and Clear the USFCFG Bit
> +	 */
> +	u32 val;
> +
> +	val = (in_le32(SMMU_SCR0) | SCR0_CLIENTPD_MASK) & ~(SCR0_USFCFG_MASK);
> +	out_le32(SMMU_SCR0, val);
> +	val = (in_le32(SMMU_NSCR0) | SCR0_CLIENTPD_MASK) & ~(SCR0_USFCFG_MASK);
> +	out_le32(SMMU_NSCR0, val);
> +#endif
> +
> +#ifdef CONFIG_FSL_CAAM
> +	sec_init();
> +#endif
> +
> +	board_retimer_init();
> +	return 0;

Do you need to call pci_init here?

> +}
> +
> +int board_setup_core_volt(u32 vdd)
> +{
> +	return 0;
> +}
> +
> +static void board_config_mux(void)
> +{
> +	struct ccsr_scfg *scfg = (struct ccsr_scfg *)CFG_SYS_FSL_SCFG_ADDR;
> +	u32 usb_pwrfault;
> +
> +	/* Configure IRQ01 and IRQ02 lines polarity to negated */
> +	out_be32(&scfg->intpcr, 0x60000000);
> +
> +	/*
> +	 * IIC3 is used, configure mux to IIC3_SCL/IIC3/SDA
> +	 * IIC4 is not used, configure mux to USB3_DRVVBUS/USB3_PWRFAULT
> +	 */
> +	out_be32(&scfg->rcwpmuxcr0, 0x0033);
> +	out_be32(&scfg->usbdrvvbus_selcr, SCFG_USBDRVVBUS_SELCR_USB1);
> +	usb_pwrfault =
> +		(SCFG_USBPWRFAULT_DEDICATED << SCFG_USBPWRFAULT_USB3_SHIFT) |
> +		(SCFG_USBPWRFAULT_SHARED << SCFG_USBPWRFAULT_USB2_SHIFT) |
> +		(SCFG_USBPWRFAULT_SHARED << SCFG_USBPWRFAULT_USB1_SHIFT);
> +	out_be32(&scfg->usbpwrfault_selcr, usb_pwrfault);
> +	set_spi_cs_signal_inactive();

Why not pinctrl for this? On my board I have e.g.

	pinctrl@157040c {
		compatible = "pinctrl-single";
		reg = <0 0x157040c 0 4>;
		#pinctrl-cells = <2>;
		pinctrl-single,register-width = <32>;
		pinctrl-single,function-mask = <0xf>;
		pinctrl-single,bit-per-mux;

		/* This register is big endian! */
		i2c2_pins: i2c2-pins {
			pinctrl-single,bits = <0 0x00000000 0x00ff0000>;
		};

		i2c3_pins: i2c3-pins {
			pinctrl-single,bits = <0 0x00000000 0xff000000>;
		};
	};

and then e.g. over in i2c2 I have

&i2c2 {
	status = "okay";
	pinctrl-names = "default";
	pinctrl-0 = <&i2c2_pins>;
};

of course you would modify this to mux USB instead.

> +}
> +
> +#ifdef CONFIG_MISC_INIT_R
> +int misc_init_r(void)
> +{
> +	board_config_mux();
> +	return 0;
> +}
> +#endif
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	u64 base[CONFIG_NR_DRAM_BANKS];
> +	u64 size[CONFIG_NR_DRAM_BANKS];
> +
> +	/* fixup DT for the two DDR banks */
> +	base[0] = gd->bd->bi_dram[0].start;
> +	size[0] = gd->bd->bi_dram[0].size;
> +	base[1] = gd->bd->bi_dram[1].start;
> +	size[1] = gd->bd->bi_dram[1].size;
> +
> +	fdt_fixup_memory_banks(blob, base, size, 2);
> +	ft_cpu_setup(blob, bd);
> +	fdt_fixup_icid(blob);
> +
> +	return 0;
> +}
> diff --git a/board/conclusive/whle-ls1046a/whle-ls1046a.env b/board/conclusive/whle-ls1046a/whle-ls1046a.env
> new file mode 100644
> index 000000000000..fd82a9a6b1d8
> --- /dev/null
> +++ b/board/conclusive/whle-ls1046a/whle-ls1046a.env
> @@ -0,0 +1,13 @@
> +hwconfig=fsl_ddr:bank_intlv=auto
> +kernel_addr_r=0x81000000
> +kernel_size=0x07000000
> +kernel_comp_addr_r=0x88000000
> +kernel_comp_size=0x04000000
> +ramdisk_addr_r=0x90000000
> +ramdisk_size=0x08000000
> +fdt_addr_r=0x98000000
> +pxefile_addr_r=0x99000000
> +scriptaddr=0x9a000000
> +fdtfile=fsl-ls1046a-whle.dtb
> +console=ttyS0,115200
> +fsl_bootcmd_mcinitcmd_set=y
> diff --git a/configs/whle_ls1046a_emmc_defconfig b/configs/whle_ls1046a_emmc_defconfig
> new file mode 100644
> index 000000000000..a3104b0023e9
> --- /dev/null
> +++ b/configs/whle_ls1046a_emmc_defconfig
> @@ -0,0 +1,83 @@
> +CONFIG_ARM=y
> +CONFIG_COUNTER_FREQUENCY=25000000
> +CONFIG_TARGET_WHLE_LS1046A=y
> +CONFIG_TFABOOT=y
> +CONFIG_TEXT_BASE=0x82000000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1046a-whle"
> +CONFIG_QSPI_AHB_INIT=y
> +CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
> +CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
> +CONFIG_PCI=y
> +CONFIG_AHCI=y
> +CONFIG_MP=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTSTD_BOOTCOMMAND=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=10
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p1 earlycon=uart8250,mmio,0x21c0500"

You should just be able to use earlycon without args. And you shouldn't need console= either.

> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_CMD_TLV_EEPROM=y
> +CONFIG_CMD_BOOTMENU=y
> +CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
> +CONFIG_CMD_DM=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_EXT4=y
> +CONFIG_ENV_EXT4_INTERFACE="mmc"
> +CONFIG_ENV_EXT4_DEVICE_AND_PART="0:1"
> +CONFIG_ENV_EXT4_FILE="/boot/uboot.env"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_USE_ETHPRIME=y
> +CONFIG_ETHPRIME="fm1-mac3"
> +CONFIG_FSL_CAAM=y
> +CONFIG_MPC8XXX_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_FSL_ESDHC=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_SPI_NAND=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHYLIB=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_PHY_FIXED=y
> +CONFIG_DM_MDIO=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_E1000=y
> +CONFIG_FMAN_ENET=y
> +CONFIG_SYS_FMAN_FW_ADDR=0x900000
> +CONFIG_NVME_PCI=y
> +CONFIG_DM_PCI_COMPAT=y
> +CONFIG_PCIE_LAYERSCAPE_RC=y
> +CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
> +CONFIG_DM_SCSI=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_FSL_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> diff --git a/configs/whle_ls1046a_qspi_defconfig b/configs/whle_ls1046a_qspi_defconfig
> new file mode 100644
> index 000000000000..7d6a6ba50eaf
> --- /dev/null
> +++ b/configs/whle_ls1046a_qspi_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_ARM=y
> +CONFIG_COUNTER_FREQUENCY=25000000
> +CONFIG_TARGET_WHLE_LS1046A=y
> +CONFIG_TFABOOT=y
> +CONFIG_TEXT_BASE=0x82000000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x900000
> +CONFIG_ENV_SECT_SIZE=0x1000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1046a-whle"
> +CONFIG_QSPI_AHB_INIT=y
> +CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
> +CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
> +CONFIG_PCI=y
> +CONFIG_AHCI=y
> +CONFIG_MP=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTSTD_BOOTCOMMAND=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=10
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p1 earlycon=uart8250,mmio,0x21c0500"

ditto

> +CONFIG_BOOTCOMMAND="sf probe; mtd read dtb $fdt_addr_r; bootflow scan -lb"
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_CMD_TLV_EEPROM=y
> +CONFIG_CMD_BOOTMENU=y
> +CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
> +CONFIG_CMD_DM=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_ENV_SECT_SIZE_AUTO=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_USE_ETHPRIME=y
> +CONFIG_ETHPRIME="fm1-mac3"
> +CONFIG_FSL_CAAM=y
> +CONFIG_MPC8XXX_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_FSL_ESDHC=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_SPI_NAND=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHYLIB=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_PHY_FIXED=y
> +CONFIG_DM_MDIO=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_E1000=y
> +CONFIG_FMAN_ENET=y
> +CONFIG_SYS_FMAN_FW_ADDR=0x910000
> +CONFIG_NVME_PCI=y
> +CONFIG_DM_PCI_COMPAT=y
> +CONFIG_PCIE_LAYERSCAPE_RC=y
> +CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
> +CONFIG_DM_SCSI=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SYS_NS16550=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_FSL_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> diff --git a/include/configs/whle_ls1046a.h b/include/configs/whle_ls1046a.h
> new file mode 100644
> index 000000000000..597d1b274940
> --- /dev/null
> +++ b/include/configs/whle_ls1046a.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2019-2020 NXP
> + * Copyright 2020-2023 Conclusive Engineering Sp. z o. o.
> + */
> +
> +#ifndef __WHLE_LS1046A_H__
> +#define __WHLE_LS1046A_H__
> +
> +#include <asm/arch/config.h>
> +#include <asm/arch/stream_id_lsch2.h>
> +#include <asm/arch/soc.h>
> +
> +#define CFG_SYS_UBOOT_BASE			0x40100000
> +#define CFG_SYS_DDR_SDRAM_BASE			0x80000000
> +#define CFG_SYS_SDRAM_BASE			CFG_SYS_DDR_SDRAM_BASE
> +#define CFG_SYS_FSL_DDR_SDRAM_BASE_PHY		0
> +#define CFG_SYS_DDR_BLOCK2_BASE			0x880000000ULL
> +#define CPU_RELEASE_ADDR			secondary_boot_addr
> +
> +/* Serial Port */
> +#define CFG_SYS_NS16550_CLK			(get_serial_clock())
> +
> +/* Miscellaneous configurable options */
> +#define HWCONFIG_BUFFER_SIZE			128
> +
> +/* I2C bus multiplexer */
> +#define I2C_MUX_PCA_ADDR_PRI			0x77 /* Primary Mux*/
> +#define I2C_MUX_CH_DEFAULT			0x1 /* Channel 0*/

use I2C_MUX

> +/* RTC */
> +#define RTC
> +#define CFG_SYS_I2C_RTC_ADDR			0x51  /* Channel 0 I2C bus 0*/
> +#define CFG_SYS_RTC_BUS_NUM			0

Use DM_RTC.

> +/* FMan */
> +#ifdef CONFIG_FMAN_ENET
> +#define CFG_SYS_FM_MURAM_SIZE			0x60000
> +#define FDT_SEQ_MACADDR_FROM_ENV
> +#endif
> +
> +/* TF-A */

this is not related to tfa

> +#define QSPI_NOR_BOOTCOMMAND			CONFIG_BOOTCOMMAND
> +#define QSPI_NAND_BOOTCOMMAND			CONFIG_BOOTCOMMAND
> +#define SD_BOOTCOMMAND				CONFIG_BOOTCOMMAND
> +
> +#endif /* __WHLE_LS1046A_H__ */

