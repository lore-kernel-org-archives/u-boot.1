Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F09CA9EC0
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E92F6066F;
	Sat, 10 Oct 2026 19:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTJyxKz8FUdg; Sat, 10 Oct 2026 19:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 298F160639
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791659818;
	b=A0guu25Gwd0e7pRb+kMi+L3YKG7kUAxKrUWEVlM71I+iCEXWHeUImWfBPq3E4eBvIpao
	 maOxEx7e2UqGg+if5NiecwAEybtgNrCh8V2iJ9GnsEIyNlXvvYthrTKG5mi0yyPN2R5oZ
	 gw014za9i8rvvC179+8CD6HsFVzd8Kfdf4A0ePKOzYb3CLChAcbXy7Bil2djIOvloQhaL
	 kiu9iq56hxiGrBqGavRtO3+A0jMquId/wZIEu7KAa/QUt0nfEFBwKQuspAW5RfoBzrRg+
	 G6+X6o0K06dT/B+dh9UVo3khOs31NfswtmrmG7rPzU0rg893YR/NLYApM59SO2rEfhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C/KBwZZ4zf3WtWxDKL0CJvTXctpdBjgZq8xcYFSxFRY=;
	b=CyMDW1veFkDEghToqduc7oSYCV/RuGCBDP908yUhLCnAU2S5uD4pEtsi5NtiTLN+0J1x
	 RBD1o42X7vCg9tmB3t8yiHKnEnMOjt17bJn6oKbctx7iq1cdB9XYKn/9FhFhP5xcLneRX
	 hHMkfCDj0w1V/JU6lNWhzpvAFuVn2NRdVguyJetjcyUw1Hl6vxisGuTZKSwjlkaNCfkF8
	 xst0u4g03Viy1AGATIBThLdDtjc6uZ9SEvok2evAHRagCM9bZmbjdF3kDPoVBlDJEX2D9
	 nl8SoPsSCN2vg2YXvlg63w8PY7sr48vlQ+/FJ2RpFHe1zDjiULtgZBAT5LeEDZZY6/g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=dxW6t+6V;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659818;
	bh=C/KBwZZ4zf3WtWxDKL0CJvTXctpdBjgZq8xcYFSxFRY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G7gKISrUwzZE85LTdEZJD567MR2K6FtnwtdJ0Lvj8loDD75ZfCuIPK4Fc4vQBZJyU
	 4SPxnhrVtuQSJBP8DAGmu6ppyTXzCbW6o9DOglJDVm2TPtLGvy+hxV4CCTJ90Qg7mG
	 IyOTvY+lKhajqxBV/cnUWu91xXdGWLJ5u3bGbTUMEVsWwJcB9mmhjpoN+2/mvbIZpE
	 L+PLIRvtYfnXrx68LMq26+61d4ihGCYwr7FM2W8TTHoSgLLhMAN9tlNfEUs8V+KBwC
	 wlo5gy+w+5GIMy6D4vPPGLFEFEpUDAnJHLMEE5VEsjMNqKsbhUb/MX36MSor7+CSz4
	 uecrEfwGJwg3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 298F160639;
	Sat, 10 Oct 2026 19:16:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78B38356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B06660639
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03XAK84Ecz-w for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 19:16:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B931A6061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659816;
 b=Nx2qkDXajxYgbysz93ntllRyReoSkdVSJ6MWXmQwFmdFvGMNOcfhfO+2CpKGI4+qIiWP
 yiMxPhjFx2/typxrJFBQSULnMmRsqQES54OqHqIsedrnIPU3uTIbW73ppHQJ3jbW7zqkV
 t0GRYO4SAP4PAVHWOq74p1FVliwtLawyIqOfrYtO6GK39kIC6d5EthHX6hDXpJ5vm2I/0
 1IefRDkS2bE/VLFaYjDq1qStaIF4RhRuDV1RZGCLQCoeAo7f9sKH/ASMJK2fLp4MfJzok
 y0SHNllkCSCwpoLpO/xOhkdkOz0+6LKIHaspvEM9ArfomA6RyJU71c0Hm2GXcgkoKHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791659816;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=C/KBwZZ4zf3WtWxDKL0CJvTXctpdBjgZq8xcYFSxFRY=;
 b=X0zyTrHv95DjT7oy+E/kLSSxXDu7GNJtgo/YzyF+i+QKhaU8ZrajOgDUCOnc2fDNjuAz
 7p4Lsd1wPI84e3wmBrOTMAuFuOUfwtWSo0qaWj84suRhZVm+RtbI6oIFNbXHOhZnSCCbt
 jIXClDkQfFKRiPxuYvLeEiwt3VeUjakmW8zOVdqsDQ21c4rXPEY9jDIar6N23I1E4Tn/D
 LF694RYPupN8oDKxmdoqQNz157pCZyRhvnkASBh9BZnR8SAlJYHoLjjsWSzFz+h1a1tLm
 qON407xB47Urt3J3to4u73m/JRGniy3d8c1o9YomT2OBIRj1mFZyrhSSlwfI3Uu/bSg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dxW6t+6V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dxW6t+6V
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B931A6061D
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEsERfX13ybABPNU1SERdbO/UpXRyrJvtjBuGcb0tToZGZCeemyeGwJ737hD82SuU7Vo6ic1JIiqaMCvtupaDmClXP4v8s+UK+IHXswfgF+n9VNQDG7EuRq2C56nNPG6L4PcTROGen4rYOvAs8PtBly8Uc+lvOHEOuSf+qTqIkbYdFfVeWtmzJQs61riwTheIPPz4zKG9bvFAHCpyVHTYFUfVDRGX4Ad8yD9JkkoKDpWgkdrIV5Ll9BkjQ8RBjeI2DerGf6AutIToGzcP71CepefUirPbKIAuE/7YBANVCTClD7XuX4EWjDkRoxQpSbPhGijZe6Wv8+/6R+GkCWvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/KBwZZ4zf3WtWxDKL0CJvTXctpdBjgZq8xcYFSxFRY=;
 b=O4CpTIJTcYmKrhs9WkrjW4PWtHFTAUVsNSB8L0XhF/4iF0CtL0pkYtA2GfM1B4+CEKT1OR3/Y2PrEqcTXk30XFwSuJi3cA5MfKI8i5n7oXGPgwptjfxC42RPq0naZfwcAkhLlF/Wfvluy09sydDM3BcOzN/ox+9+y2r97Bv1Ix1U9X2tDweerIVB/lkwIeUYVGNwISyWj2vHEIVCWa11v+uB4h7Kqe2b3L6elH/c37k70cFSv/EqF2Ej9AVNURuFBtfjbC/cRM1w/A7FCN+9+tvRADKPaBPd6aDyheIjw/FUdJszv2cbMpGILD4syDAPbUOxAXI7vAB9VdFKcZJ26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/KBwZZ4zf3WtWxDKL0CJvTXctpdBjgZq8xcYFSxFRY=;
 b=dxW6t+6VXEpSZtkFRXL/P3xjRtu3u4AH6xvFgxSoglOHQ8fPrDiezJP8eTPET9buy2JUSZuiPVrBXVoVh0tBbIrZS9hRzIOrVXxSRiAYmsyexYXwHeHv5/+GLOvO60IrCCpM8G2ltGf/kpl3FQY0LW/0y1UXbTWFkIAvhHozZXplnOEhWBihvvvSRElpiAjH/90nludJM5U/4b7OH/9G6U3x0AQ1KzuhIHIx0PooPXObI5GZYphf3jNIVzo6kBcitlnkivl6nt9raiL4bLMWtf+UBTuYqkfuP++Ez4fkMDqituuctbuUZU029SW/JjG21SHTGTG1PqnjHbldeGM8zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS7PR03MB5509.namprd03.prod.outlook.com (2603:10b6:5:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 19:16:50 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 19:16:50 +0000
Message-ID: <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
Date: Sun, 11 Oct 2026 00:46:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
To: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
Content-Language: en-US
In-Reply-To: <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::9) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS7PR03MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: eb626aa0-6b8d-4617-5a7e-08df2703095d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|55112099003|18002099003|10067099003|260925021911599003|260925021311599003|260925022911599003|3023799007|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: uD9EenXllCzXgSTYWHiuc1TeZtF/3F5zck/FiaLg/RJQzaHQJCFs68eUkFg24R0zm+TOuDH8mjYL6xqdzHJz5prPJwAB6/KV9pztKe4rb6Bz6hbX7ulNsErTTm/bjgW9nKhyCOdRtcKL0gFYLelqIleUXOYoJEIix/bsp3fJBthZAJWLZ7BZ3T6MF30I+ne8gZwjNGJyZDNSczK0PyZ4Wzx4IMUEB5UJT4NK5DFByZJnx2/w8viGGA2W/IViJ7fxAK6m5Df2eUxB8Rafmj9Z7JLszuETWXODjDxTAqfKYr4EHbSew/SlvegHxe9gEi4Iu+wyfUdzEtahliotHdV1I7KG6btGMHinPszZhvPjjuZGXbLw4Mk8Y6HFa+h3U2HxcZ/7eyWI379qsMyQMy6oj5iM418WiXEURrT3Df1T1+ee0AJKeOYTbiD+D67xbFlwfJiUl83vtncG5a9KcRcvXJwaKLfrK0ijZFSp0okH96sz5BxUNU2Y491Q8CTTh14poOINnqSq1eK9cJuR9jZE0ntlYhULmol4VcqfelHtlZuAaHBdCSwe6lRQdA6bRrk7KB2LUrfVYXpg8/G8ScqW3o0EP8f4NwlWIzjQKb3KKqvYKX+9eXRMdzrARgYonO0K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(55112099003)(18002099003)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(3023799007)(261009223027099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEIxbkJKa1NtM3U0MlBaTXFHOXd0QXUzUWJHaTBtQzFKb2Uwd25EcEE2UmVz?=
 =?utf-8?B?ZS8yRktSUGNQTW9sSlN4MTNScG9aMm5rdUova3VSc1V0dURydXl2NzFSS04w?=
 =?utf-8?B?ZFdtK3MwQnJyU3J1VkpqamdoRnRPaWdoeWZxTDdmb0gyUkcyODN5NmZkU1lW?=
 =?utf-8?B?S1kvNjBmaW1rcDBUUDlpeUFJSFJFZy9MSVBVMFQ5WFBzZ2RsVU1NUVpBdWVR?=
 =?utf-8?B?Y05ucTg1bjYyYW5LT2hmSXlpaWZtWG16UlNJZ2xHOEkrVGEzRGpPaGRGYXlm?=
 =?utf-8?B?VmlWTUt6bEVjZTJVSWZXdFN6c1c3RjVmTWRtZGNZZmNRQ3R4ZlpvejU0d1U0?=
 =?utf-8?B?RFdlUGpMYmN5REt2cUF5WENSZ0VxKzE3NlgwamFpeHZJNWJZcjFEZmpwRjBZ?=
 =?utf-8?B?WVNDU2hxV2JlbjZnV2J2NW0wcURjUmFPUFBBYlNMaGtMUHhiZVNlQ3Y3UU92?=
 =?utf-8?B?amhGc2ZqQWdJZHZDSGJ2Q3hMbkxwQlA2UmNPb09rcmZkSXZ6cVltYm1vdVgz?=
 =?utf-8?B?M3Nhb2k3WGJ5SWlyeERjb29JZXZzNUk1YVhSVVV1U01Jam9DMEZPNGxXRkk3?=
 =?utf-8?B?NXpUQlBEaVV4QStKdStzZXp3ZEI0OTB4OW1heUUwWnE4VWwrNUdORVFMYS90?=
 =?utf-8?B?UkU2R3NtR01FUkIwU0krb1k4Zkx0UGhNSW1VZTFTTGxTd1g5TmgvdXR0dzlu?=
 =?utf-8?B?aXIvMVZyOVRnV3J6anhSd09kSzVydDlKZS9OallmVjdsRzhtd2JtSVRxREp0?=
 =?utf-8?B?TUlic2ZnYWNxdllobzk0SlVFTFVmK01FR0x3eUJta2d0WDJlQnM2WngxRDly?=
 =?utf-8?B?dHl6TndiL2VwOFdZdUdJQ1MzbWorb1FRQjB6S3lEMUNvTDExRG54aWJIVSt2?=
 =?utf-8?B?S2ZjTzgrSjVGMmNpbU9HdmljNm5VZU5zZVF5YmZ0MHR4WWhXNnhSRVZTTjR2?=
 =?utf-8?B?VCtVaEQ2ZnNQWHFhc1FJTndFdHlEY2J5bFpDQmpNWnBSU21odU5NaG9HRXAw?=
 =?utf-8?B?RzJNUEhkcGJQNDVIY2FXZ3dlWHJJN0wwTnJtWG5hM3hTaXBwQUU1b3E0N1lr?=
 =?utf-8?B?bm4wZk5uUU1ocFl6eXJvQ21kcTFWRSt0VVp3ZGVZcEZ1UnNHWW0zNWVJOUVh?=
 =?utf-8?B?Zkp0akkxM21IMi9WM0hlMVgxWTc2YXQyRUhKQlQzb3dNdW1tTW55V2xUMUh6?=
 =?utf-8?B?TXFaQkhnV1luZzhxZDYxSlpnaTRRN0tHTG55Qnp2VkpoZW1PVFJrdkt4c1p5?=
 =?utf-8?B?VnJlSUw2enFtaE9kbHZLUXdWR2VJL3k3a05Ud2JSMUVEZGRwZDNMb1RqNW5T?=
 =?utf-8?B?aGRrdHdON0syWGJ5RER2TzJiUm1sSDdkdTV6Q3pFNWtvc04wM3FhalNONGRn?=
 =?utf-8?B?SisySUZZT3BlRlhFb3pVMUJOQmxDbEVzSzBEL3E4RldhV2F1K1VMaE1jQXpt?=
 =?utf-8?B?QmxyOHJ3TFNWVzVwYkFMZzNsS0JXTytoeitDbVdHaGYxaWlwanQzVkpBbmNn?=
 =?utf-8?B?S1hjendlVExrS0IwZVRReDJId0pDdGRxeDFPL09TM25zeXR3T3BhZjJKdTN3?=
 =?utf-8?B?NmtRYlZyTW5hdDNxbHV6YkdLVXNJZXBqamc2UEs5VG85d2hoNEduWEZNaWZi?=
 =?utf-8?B?TmliSDBwOXlHNUZxQlMwV3psRmdUd0x0R3Y0OGxQVGh0d0JQZ3FwbnNCQ2tv?=
 =?utf-8?B?N29pc2FCVlJrZG5NdEd2OTBKL1FLcUZtcGFtZWFrVFBSZitOMzQ3WjU2bzdN?=
 =?utf-8?B?SmNkNnFkOE9RSFpLU0FURStEQUZXeitkb3pyY1FHQTc4d0JyU0kvbzhHQ2lr?=
 =?utf-8?B?RUtQRnNUMXdoVUd6U2M0MjB2NFlVRktYQ2dIZUU4WWhRTVRvYWpvWktRSU02?=
 =?utf-8?B?cmZ4b2tlZXhUY1F4cG1RQjd1QVVNdGhORmpPU1ZtOHVjeURPNTN3aVZsWFN0?=
 =?utf-8?B?b2gvbjkwaDJZb1ZaUVcwWGRxakpTL3c0VlgwSHpMRWtya3BsMTRubTVkY0pk?=
 =?utf-8?B?U05UckxUVXZIbitEWlloT2pjdXQ1S1o3dDRmdjZXSkRZMEJRYVhKTk5vaW1t?=
 =?utf-8?B?Z3ZJYy9YeSs4a1RwNzlUOTgwR0IxemlQTVdHRGxPYjk1THBSdnJBbS9SaUNx?=
 =?utf-8?B?N0pxUjVsQTRBelE2UkhtNzg4TzB5c3BqUkw5QkV3MTFmMi9adWx6L0ZkcFRZ?=
 =?utf-8?B?VWQ0OWdwWmh4d3JBRU1ONkFkZHFFUXM3MFl3UmRlRWd0QURTZk1GTVhHU2pU?=
 =?utf-8?B?N3Vra0VNNmtxZmNjRCthTFBHMGpNQk16OUJWcTBlY2UwaC9lTjNzd3hyQ25a?=
 =?utf-8?B?S1RULzhiTjJ3aW03cUVwWnBEK3dvVytoNmlKbkIvaUZxeHFIakN2c1prZGRq?=
 =?utf-8?Q?Kze2KgHMf/qWH1Os=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb626aa0-6b8d-4617-5a7e-08df2703095d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 19:16:50.6420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwEAHmWw6/u7Cs4ORYAvM/TPMPwCK3MasVQAQHlpZ3GBtFl5jh5W9XmX837Sto8qmLDyk0pqGPiOHiPWuS7Nq6kynaAhrG8UHQPHhAY+szA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5509
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


On 11-10-2026 00:32, Kathpalia, Tanmay wrote:
>
> On 10-10-2026 11:47, Zixian Zeng wrote:
>> Hi, Dave:
>>
>> On 2026/10/6 02:01, Dave Klotz wrote:
>>> spacemit_sdhci_get_b_max() limits every SD read in the SPL to a single
>>> block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
>>> separate commands. The controller handles multi-block PIO reads in the
>>> SPL: the OrangePi RV2 has loaded U-Boot from microSD with them through
>>> the v2026.07 and v2026.10 trees.
>>>
>>> Drop the limit and use the host's b_max.
>>>
>>> The merged v13 cover retains the v9 changelog entry choosing single-
>>> block SD reads in SPL. This reverses that deliberate policy for the
>>> recorded RV2 SPL boot use case; no general multi-card reliability claim
>>> is made. K1 does not advertise MMC_CAP_CMD23, so the MMC core sends
>>> CMD12 after a multi-block read rather than requiring CMD23. Additional
>>> card models, cold boots and transfer-error recovery remain required.
>>>
>>> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
>>> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>> ---
>>> Validation: unchanged executable change from v1; exact-base source
>>> replay and checkpatch pass. The corrected combined integration, with
>>> separate clock/MMC and DDR relocation fixes, passed SD SPL/FIT and
>>> automatic NVMe EFI boot on the 4 GiB RV2 in a warm-boot trial. This is
>>> an integration result, not an isolated test of this patch.
>>>
>>>   drivers/mmc/spacemit_sdhci.c | 11 -----------
>>>   1 file changed, 0 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/mmc/spacemit_sdhci.c 
>>> b/drivers/mmc/spacemit_sdhci.c
>>> index 6488ae0fdb..4284553177 100644
>>> --- a/drivers/mmc/spacemit_sdhci.c
>>> +++ b/drivers/mmc/spacemit_sdhci.c
>>> @@ -324,16 +324,6 @@
>>>       return 0;
>>>   }
>>>   -static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
>>> -                    lbaint_t blkcnt)
>>> -{
>>> -    struct mmc *mmc = mmc_get_mmc_dev(dev);
>>> -
>>> -    if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
>>> -        return 1;
>>> -    return mmc->cfg->b_max;
>>> -}
>>> -
>>>   static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
>>>   {
>>>       struct mmc *mmc = host->mmc;
>>> @@ -574,7 +564,6 @@
>>>         spacemit_mmc_ops = sdhci_ops;
>>>       spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
>>> -    spacemit_mmc_ops.get_b_max = spacemit_sdhci_get_b_max;
>>>         ret = clk_get_bulk(dev, &plat->clks);
>>>       if (ret) {
>> Using the current version of the next branch u-boot (ed869863c7),
>> with your MMC patch series applied.
>> Since the SPI controller is not enabled by default on the BananaPi-F3,
>> I also applied another patch series:
>> Link: 
>> https://lore.kernel.org/u-boot/cover.1790976767.git.DaveWK225@protonmail.com/ 
>>
>>
>> I tested u-boot SPL with three SD cards on a BananaPi-F3 and found
>> a reproducible issue, the specific error I encountered is spl: 
>> partition error (Error: -38)
>> At the meantime, when i was revert the commit:
>> mmc: k1: let the SPL read SD cards more than one block at a time
>> the error has gone. Same SD card, same operation steps.
>> Maybe BananaPi-F3 do not support read SD cards more than one block at 
>> a time?
>>
>>
>
> Hi Zixian,
>
> Thanks for testing this on the BananaPi-F3 and reporting this. The
> same cards and steps failing only with this patch shows that
> multi-block SD reads in the SPL are not reliable yet.
>
> I would request to try one more experiment before dropping it.
> Please add MMC_CAP_CMD23 to host->host_caps and boot the same cards
> again. CMD23 (SET_BLOCK_COUNT) tells the card how many blocks to
> transfer. mmc_read_blocks() then uses CMD23 plus CMD18, and it does
> not send CMD12 afterwards. The current driver does not set
> MMC_CAP_CMD23, so a multi-block read is CMD18 followed by CMD12.
>
> After the SCR is read, the MMC core clears MMC_CAP_CMD23 when the card
> does not advertise SD_SCR_CMD23_SUPPORT. Those cards stay on CMD18
> plus CMD12.
>
> This also matches Eric's earlier note that on K1 ADMA depends on CMD23:
> https://patchwork.ozlabs.org/project/uboot/patch/20260707-m4-v4-3-dbd01185f911@riscstar.com/ 
>
>
> If the CMD23 test also fails, I agree that this patch should be
> dropped.
>

Hi Zixian,

A few follow-up questions about the SPL-only failure:

The callback limits reads only when CONFIG_SPL_BUILD is enabled. U-Boot
proper already uses mmc->cfg->b_max, even without this patch.
Therefore, multi-block SD reads should already be used in U-Boot proper.

Could you please boot U-Boot proper from another device and test a
multi-block read from the same SD cards?
Could you also compare the following between SPL and U-Boot proper?

- selected SD timing mode
- card clock frequency
- bus width
- PIO, SDMA, or ADMA transfer path
- whether the card advertises CMD23 support

Although both stages use the same driver source, they may use different
configuration options, transfer paths, clocks, and timing modes. This
could explain why CMD18 works in U-Boot proper but fails in SPL.

Regards,
Tanmay
