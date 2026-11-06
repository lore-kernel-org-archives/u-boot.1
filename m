Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683D606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hHzPykYv;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Nm8qoLvG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E89260890;
	Fri,  6 Nov 2026 03:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6SlQKOXwxKS; Fri,  6 Nov 2026 03:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E9B26085B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793935134;
	b=FmaQ5/slIQNy1AbXh1bUthA282JWaXHG4xylg5/2CvIzMB715Pytneh21PbWmxmnPWQx
	 I3YXiWrxMHTuhpuAbWYYuvDa8hOkYqrzaFvngDLJTtBcW+QhD04NU355fLapl+/tNGZOX
	 9K15cNaWx8S/rBhD+A8iEX11V/OyBvCFZXoTKwhFQYXF1kisG2PzosQAKr0syLT3vKnYC
	 z6D8YVfIKd9oYo4EMuaSXpJ2cxCPm8jad11VRsKQ1FxjxeLxeU3KFEvhOqDWdGJkUIp1a
	 gqFrMJYqb/i2iYQCtQtfhHcw30Lvd22jZKTKs+niY2egCfujAqCkObLT7FJaXTQklWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
	b=TQDjyo7jLoRV6QdMaNfJHkLSlA0B/+4FztqbWXKtJYKWEmSdkUnEIEPySw+wxrw7X0QR
	 R5zxN0lWeWvmO6GT9JUI9MRkdsXdQv4WD5z8cbYlCY5ktSmF7A1/+GRaAlkelaqVjJHsW
	 6NBbrno+nb87jx57o0PRaqxA8S4PRQ+OyMK/mbKbYedZGaTb1/xmfyqKqIxD2IwdN708+
	 LJZB5nLOPOEFUZSdl3hKz5SXQltoan3OCNwp2x/QU4OnTZekIxcn9G7Ty/UMrqCMZ5j+U
	 +RS2T8X/jod8V2TUMGxctX4NWL3G/hXqy2SKIR3ZglhkMujaZ8y9MUxyuqu3y29yWHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793935134;
	bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hHzPykYvOsbolwcjXrTkOFv65mQakb+sEBYegTGjsC3zLhzSJjSOdU+l3OXgfcg1Y
	 +FbxGWQ6yAnBnRe9DxHSnnJSYjeZ5Mqx3L4NgLXKxpq7TmWMhHzCjWJ8t7EILK3pGz
	 78G11r4KabFpTfhQceYvYnL1zmYCHNxBvbxQHgSxsIuOnaS4gJMtHNpPzXy5cZxE2G
	 ReMIf/AGWRmr0op/Oq/VJLJiZSQEhX0RgQSymfb4cL6MnqSl2FaMvoQ5PBPhCJZtNt
	 e6GJJXTrRfOcuAZnKdVk0pGxjZ5E737zcy4gC3QIVuP86t1fkcTjjw+UTD2ETMZ+/L
	 DxCTyetWAU1Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E9B26085B;
	Fri,  6 Nov 2026 03:18:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FBF637D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30F344090B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LKnCK9BKnbB for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 03:18:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 340AC40900
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Nm8qoLvG
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 340AC40900
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6xr67G52joFDXc9V8wuw98hnOMPycU8rbwktb/uYKg=;
 b=Nm8qoLvGgNiMCtj/+2tI65Z8lKgPjeGbXpWCzmrnH3+wHfCIYWSgOuzue6Tr4nU2fhbotmW9n0i4vLznKvP8vt2+FWOoN/p1SIqU5k1s/LThQC9gTpSODPSgVh9mYCiRw9dReHCVYIQ58kr/wIWjqSK641DZIMpNUh+DAaRO/O8MbJE3ZKW6nPMiJzy1y1jiYkoHnFbYVB6vXd9LVLD5OdFjqZCf7l1Xv+wSFWNH+QKdZIzBKUf5+AInVaZx09dGGsOsVoFLAcod/8QP/rv6Ut4pqt9kXPF7ar1LceL4m5xvqLtCDGcQL940cuwUOJ6YcQNo2VqZdkYKRAIkdSNyXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7301.namprd03.prod.outlook.com (2603:10b6:806:2f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 03:18:44 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 03:18:44 +0000
From: alif.zakuan.yuslaimi@altera.com
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [resend 0/2] i3c: harden device index and detach handling
Date: Fri,  6 Nov 2026 11:18:28 +0800
Message-ID: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8762d4-a75c-474e-cc53-08df3bb4aa32
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261102123227099003|11063799006|56012099006|261009220027099003|261009223327099003|261021121427099003|261021123027099003|261009221727099003|261009221227099003|261026140227099003|261028144727099003|261022105027099003|261009223027099003|18002099003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: 21zcmNhlBGa7B7SiqWrtTadDcNdOyOiXcRQCNiCQowJO/t/iFdI+IPCsP9Pap7h81JmRKkN5KZgKX65RE8/pw/tDuypslxXRC1E4Og1s45Kgr4WSH/ry6CKduc4tjoXPfWaYUfmkr2YI0qutAXHYLD7w5WfH8tPwHj66Efi+QU7VAPppE0lgUtxfVwwRXo9/7RH7quIzQ4Ubd/nDYtSt2a4zGhg3kjsbShQIZeg2DmbRrsn0p3RYcKvyZljzWrHPGru8RTMcf5MP1hNRDtOaP80Eicc3+N/Hb4XUKPqAqfvjKJrYq/20NgaUTRpDUjl59CyeKp8IDPZ3I5OSkDOVdcEHFJH5W/WgMgJFa170xuGs22MFLFV0yyT4xqrmWDcRxxZ1eNbeckuIBp0bdcl9qqUmYWvgIb5YJr3PUJ3CEEWHzW123lZhIFVs6QQwb2XHTk03ZhRsNcJhmiHsa8j0HiBgli750FOTKTvjAYbYzXl5zaLghcnttyzswogwdp8OrJtI0J50JxL3Dm1dQqczVTGKc7SbXtpwFwzpkT80cUXL2lvXVYx4iHm5oW0csnCPCtgg8LhTpQt5PfPLxgpHnufPAcNoxqU5Kq3EwEKRdVVjgJ1IzjxBl0puAFx8sk94na0YDstPTaLjq5uaVpcjb+q095jDIwWmdK1pKBeBmu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261102123227099003)(11063799006)(56012099006)(261009220027099003)(261009223327099003)(261021121427099003)(261021123027099003)(261009221727099003)(261009221227099003)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(18002099003)(55112099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0K6nn1UpvLQILUH3o8cgvJADdMnlZtsCKxZI84rDmSBLCpvN9M6R6kPF0zzY?=
 =?us-ascii?Q?cGipWAwozjGZKfw/p1abwPsz7fsvdk4CN8HfmbaOffaa5N1pS5aONN7hxXvB?=
 =?us-ascii?Q?WLEvnhK3A8x63yvawUUS9D9mCvZ6THw3CoQpZdwjbw7JNOVDgxzjTqowIr8L?=
 =?us-ascii?Q?nNP5BjwkmrEu0nto7Tb6HR3CmmPbPam9EjH3zzHw5UwPBO4EAsFHiz/N3z3n?=
 =?us-ascii?Q?gYIWgnstOJJMBeC4wFF+6TCnWEG4/9xx6NdXTCCPayqqBjlki4ZFsQTmjuyK?=
 =?us-ascii?Q?k/V3gKvBT44aCX9Q+pH8Rb1OU1zejC8FD5JanHIuhjCCVWe+w/ox0yvv6yEK?=
 =?us-ascii?Q?sY7otpKWz9znpadpsWhcu3/TGfHprk/XN2DU38+nahyIkTN3reNPkDUpJZD5?=
 =?us-ascii?Q?w1Cyj4LSN+RUFWiQBC3jJc+8DFTgVqVZsrdsw4bxoliiW8unNmBOXW+NDYQs?=
 =?us-ascii?Q?nOg+6e8LdVlOhTXT6wBf4XvRK4mHhnaBPV0otzVNxNOU0eQhWHFsHUSSf/0g?=
 =?us-ascii?Q?TLpy0rs/FHAFul0Hu0XJ2LNJC7BpzgvsiKZbA4IkToM0H+Sak7pMxwsbBQf7?=
 =?us-ascii?Q?TYoRrVALaIdNXRACO574pA2dR51NZFy1Y0BuocPebp0lk7soWmTRw9QMBObK?=
 =?us-ascii?Q?GXZKaZEeGnkXmMwqnKJRbHv6FqW894BBJVNp3DjW2CkxoODKru67EOd1UEmQ?=
 =?us-ascii?Q?swa5829Ho+KGrLFT/Acj4SWKwZdRo6TdJBMM4PPTdSICYgk8HPf10/jmZVkw?=
 =?us-ascii?Q?mGjtfjlKcztzSPkMnDatEo7U+8eTLM+VTPkaX3Ov34W6G5zcKDl2eFdB2/rK?=
 =?us-ascii?Q?VpsIZCuzGnG3fcOeNB05Ey0LUFJPdcW1vhFr4Ndxe9aqyehH6fsQ6yKc8qBx?=
 =?us-ascii?Q?QXQxpViAnb+IvPsMLshOsps/09pvnrMWi3RyhFUyhCpAnqdZvhQOFxruTswS?=
 =?us-ascii?Q?SnoBnTLF1uJrRuqy3iBoaO53g+FQ98iRCZjXM2FqB9kZmhUdGLP9mA3x3JpG?=
 =?us-ascii?Q?SIR+FT1EHeW5GT945rgJYD2gL+5+kvF/VumW8kJAEUove2BnuT5//ZF8VRAz?=
 =?us-ascii?Q?01izCSDxxscph+YtQF43n0Ax9LQHJKrH3B7gbel6GSXQdehCK/DFmJVbW0Uy?=
 =?us-ascii?Q?nWK6/ns2SiSZvLn0We83v84CU+C2jUdsAhVkSU/c7VfDErEiW122szG8IljG?=
 =?us-ascii?Q?vE/Mq5cPkh3qTvmh/Pz1Hr6BseRkM0pMGdYmfKX5Hb9hwmXPI90WMBlf7rrm?=
 =?us-ascii?Q?LYbnJh3PnB+nnQPMW89RhToimKKh4nk04As227ELktRaaDD6UX6W/ukb0rMc?=
 =?us-ascii?Q?DYB4Vq2VRvzvC6uzKM0Auk18dYPiFR8FPQKenlgazVS9Gaa3Z0aFYlRZ1SUs?=
 =?us-ascii?Q?dO8WYY4lkWJeOeg2tji036rLZxPHOff7jIpNGB56cMUN01euDFnilSkiaFh8?=
 =?us-ascii?Q?z9k9bctTwSunJELbqmtuVqt8GFairv9HPM+1v8fegdVUKxOQP4S9+xPxpdIe?=
 =?us-ascii?Q?QfJBaWPgqmVQpFwps5rKJc+MLlXjhEY7PlNHaCWG8U9t6QkaMbjVUdtsoSPI?=
 =?us-ascii?Q?MrDrp1H1JMSkTFJjeAu2TqbPT69UexKTiLSWa5N0w8KKz9HUoTXw9b9Tt4MD?=
 =?us-ascii?Q?RfnAHX8BZwVEZmDq0R0ozAWmeP4lceTbKXZE7mm1zzShnuI4rqYWW7jx9Dc7?=
 =?us-ascii?Q?hIOtwPfAs+OpuzwPcXsjGt6UbP6S33j1HspYTXo5GyPNe5qb4nEoVfQwsPIi?=
 =?us-ascii?Q?KdpYSmtqLknuHiP6l3J+oqqbTpMUJyw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8762d4-a75c-474e-cc53-08df3bb4aa32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:18:44.8785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiQXR4dBmidftmLnfcyb6snPyOWe5CfYeYSJhvi81ZmAbal6dDSjqHR6AFd8FnNZOAPNmxUH7i+nnN8V4TuQjHZ+6cTxTIkalOC9aoK1UwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7301
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The DesignWare I3C master indexes master->i3cdev[] for transfers and
listing without checking for an out-of-range or empty slot. A bad
device number or a detached DAT entry can therefore NULL-dereference.

This series rejects invalid indices on read/write, clears the i3cdev[]
slot on detach (leaving num_i3cdevs unchanged), and skips NULL slots
when the i3c command lists devices. Also drop unused includes from
cmd/i3c.c.

Alif Zakuan Yuslaimi (2):
  i3c: dw: validate device index and clear slot on detach
  cmd: i3c: drop unused includes and skip empty device slots

 cmd/i3c.c                          | 18 +++++++-----------
 drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
 2 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.43.7

