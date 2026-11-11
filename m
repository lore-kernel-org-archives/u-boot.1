Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2211606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iJrPBiUP;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ADVh7qMR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 821F340A36;
	Wed, 11 Nov 2026 13:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxJYmIlY09fU; Wed, 11 Nov 2026 13:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51B5140A4E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403855;
	b=E1DzJHwjoMmqUZBT61mIl78LY5yk01JnX8dQc+fYm8qEe6X4RInFNrYESw1Fzogrj8ED
	 ce0QpNpLIwr8ehrUjWm/2yPNoW7+gzdhFeqfxz5dzpm2BHFvbGC8IUE6aTWmQxC+o8apL
	 7SDCIfAptTLEf4fpEvsOxlFGebxPOWVWMI5JkhkOGC2nKByWPctkGzCK3ulAetfl2c7vZ
	 k8J4Z0IWizXAvwRS+Y17P3SfF69wdXrbXsnfiLfwm7SSVE5fQkFdrg6ZrWmGnwQFKWauZ
	 MBxYjRNO59lvowV2z2E1cLR9HTLJhYbvhjNAS3bpgGCrHmyGbs8OBuTqs4rsR+JcvXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403855;
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
	bh=tNEAJvTJhA76e1Gg1kaPkEBxPapYomX5DIF7Dl1Rwrc=;
	b=tISXwWX/PkYlYkiKWb9oa+DvTzGojtIdxivcGKHtnByV6iJuZSagzhArkBn4jJmbSp8r
	 1cRrpTSDLOcovI6zaOcJ6ylZm9cgJfWOhbDzF28rBU64+MqBFWjsOBOn9dDDc+LzIIrJs
	 f9luT4S766SaVBmJqwC4kcnDgGvJoaeVc0Z7IMLM27pf7gxzqVzp7f/W4hBEYc5isCms1
	 R8hUWdYGNfAoEa6JQL2Z/o5Mo63y8wnX4+56kXeepGAlNu44PSNufGAZb625XFUhQaG89
	 8pn97GDB0FyU8h2Dxmss9CYpenvcNdV58ybLysVlDSiFn6kMor6H7GBrsweSdREuvXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403855;
	bh=tNEAJvTJhA76e1Gg1kaPkEBxPapYomX5DIF7Dl1Rwrc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iJrPBiUPNFTv1u2vGcf9/YZJ658OUzeuBLXyGLEIMEvS2MDOLYD6tuoGmu9HZVHL6
	 nieTySp811bZ1Z4jkB+PR5dY/ps8QFpzrw/TVFLNcyeSReG83hfROkC5XfpUJdKAxP
	 yvelFVJiNaqEAtuykRSFKTrR/O+6T/n3i716k0fHwJwvnWIC4+2IbmwdAGEvHV23yY
	 L8muDsgmlYruQPUC7DaIHgH3AfOzu0XQXVQWJr0qMCYw3NMrXkjJGMUdAXR5XIkV7L
	 T4gMkKRajKwPyQmSlB7hu6F5f0Ebp0Zmsa5JsTqBRKJZGGyug5i7EX82qT7Y5UcCFw
	 iWRAC53i8O5dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51B5140A4E;
	Wed, 11 Nov 2026 13:30:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8672731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE3056089E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ty2IDDR_srvT for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D18E60677
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=ADVh7qMR
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D18E60677
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNEAJvTJhA76e1Gg1kaPkEBxPapYomX5DIF7Dl1Rwrc=;
 b=ADVh7qMR9tcrYDZ/BsRyyRa821NfmjFQ42HiLDJb4sSqMq8cwtYh0DEDAm0IIvSbvrbC2ooYXvEPlNK5+z38ELOA/fqzZMPJ02pPhdYjDo2ISnDV/VFe3DWP5wREjM+5NTVcPx62O1fT4idrRZpTV9pM6l3kAmKQbTFl0s4NDjpxdSsi4nuzV7Ry7QPBLT7TBqSjIKDuaYoDQnD6aDmTicpHWw05nzf4HB5u3+4+1Bsw0DoJAfmKyMNlhVjx768jDtpX9jlDX9JCRTqf5XqQ4sceeY9qU8tkefCIZ0jrWL9YYvjgAePvNRlv8FecsGExOamizomaJNxdMgR+HMB3sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by FRWPR10MB9356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:187::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Wed, 11 Nov
 2026 13:30:46 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:30:46 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 0/5] Implement the efi timestamp protocol
Date: Wed, 11 Nov 2026 14:30:24 +0100
Message-ID: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|FRWPR10MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ea2fe1-47bc-4533-3235-08df3ff7fe10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|6133799003|10067099003|55112099003|3023799007|261102123227099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
X-Microsoft-Antispam-Message-Info: ufywH3WaODLPfA0/xDl5oxokf1CkpH/zMorBfeztbpUqe2WXBJ6+LqO5yQjLBwNw6Sh8kovXFxwI8KL+z25ijmJOuYLSuFys1pYViS2+Qj2/PFB39MR95Cn34qmo8Ypp2NZxtXGIUeaLUsBse6M8zWK7Sij3sxB4FZJoBF+urbMcxkBzJDzIcDaXYoKdMre4v0256sEbTqRXA1A2IsE3y9+D9svoXm1TSGln8514jpEwIuzHQ9TOVvZ0RI0HdcDWkL+6N40B120U9a4Ro6wfAetgzT4WdSzGetQzLtJKnwJm29rmE6pdKEU2LTGwHTUwhhZQcGTK+QcFKiThXcK+MrGpGyh3zwB9vuFx1CgFoieMueEV5cecbjlAk00FX54qO5uG3wipPG2eriFKMQZptnVuBaQ5bWR0XTZVbtqCyrReWgWSd5N3qXelAmdlWap/CeHMfdqqvhUsW4ReikAQQA5ppce9u6/cuVoq1fQhy/5FBwuQmsF5CMxUwvTpDZ/NlU85ZnpVWQF/STGRo01yAD3aMCLl1OFxVDyVAoYb7w0jiXa51Vo28Xx3PRmIqcK1ttlNMYKPVgYyUbJZ/q2LeY6ZRnHMdAls47ufPMbEmea7DsiT3/pYVQmzVcyN9V2e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(10067099003)(55112099003)(3023799007)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWEtTptg0UEBnWe0kZxkPHw5VZ13Ye6vYkW+MerIrvAhZftin4F6SeLIDogm?=
 =?us-ascii?Q?FOuqkrtzISnrn/CucdxVWERx2vg340nijws+ChU7bqLjyJeceJus6/mj8Mrq?=
 =?us-ascii?Q?7uCsN3XC0reWZJe5ZVTR+9UWQPWzFMjs2FfKDyWhSSvhGfkfhVXvykA3cxdm?=
 =?us-ascii?Q?geNaWxuNewTr2YUOY2lfHUgO1mtTgab64piRkgZnhGe6MqilnqWqhUQrhVnd?=
 =?us-ascii?Q?vVuVEQdV1ETtx9EAN9wiad2i0T0ZcRS6BoxgVUSA8fJsKtJCVvPdyIlFTr01?=
 =?us-ascii?Q?yOqrNULfsFiZpAtKony73sZLclHx9FDaRPNVVrBAEdjUBAIFa/mafcvKz9Wb?=
 =?us-ascii?Q?h7HVCyXr4uMB4j6A+YBjFHMwDS94AdYpooMC38Y1zj6XPGisKaInBPYSiR2T?=
 =?us-ascii?Q?g8yXCb4amnk4H+csJgwFyObx/uZyHHortcUOxj24iedYxUIbIdHMhfQgGAqB?=
 =?us-ascii?Q?VWR9JeiFQx/i5aH7edvctvWw25qKPNfXBpwjHklqjXMUIs8vSYyHErVGeMFa?=
 =?us-ascii?Q?UTyxcUlZvWn3zJBUqr+1S3ax12CtYHxgcswshUuwYjMnthL/Upxe9Ji3N0Mg?=
 =?us-ascii?Q?+9R2sFLfRApibBAG2JaQJkxCuR0F26+U1M0OFiRrNQYlNauQZ0VBJ2b71PtL?=
 =?us-ascii?Q?yLkx+aAmstvDPWKNwrvJPEWKVtIRKq46WKVm+d0eR7xSzvNAeM8zHkpJq9Uh?=
 =?us-ascii?Q?KiCGkaE/x0TQ63GnoN8BMLaAqLMecuc+3ozMTi0gPmwI+DFLuH5EYMxOPr45?=
 =?us-ascii?Q?0Nc2r1hhJGB50qJz/Hgid/ssIlih9przuw6NGSIPF2BMO+6VDfR+pCA5cXsH?=
 =?us-ascii?Q?4+lBMbZ+nHLgi8+bW3TpNmSbcOfncpjNMhVgFskTrRb1wTiq/yrXd1gOc5wI?=
 =?us-ascii?Q?6Yvisf4ngII/c77ZamBmwec6bYM1BrJrDe7N5I+hjAsdL3qi2n4wMq8Hrrk1?=
 =?us-ascii?Q?zbDcKjLBrOGlWN5csGB7kJocg48rUV1Q2lTaBe3EThXDbXd1VPxTlbNQd+HV?=
 =?us-ascii?Q?jxox3herm3jTeDJBi6ximlzjVgMgrFdPz9SnUeQ3qJZfSGoGeAqMupTd3XfZ?=
 =?us-ascii?Q?lAyksWEQoKqG0LcfX85KMhga6lshVDPbK2kpPovtV58CHueLEwGtyIH4wqrI?=
 =?us-ascii?Q?gv/LoePO8FCtm18dY1cYZKhpmjeCCDzAfvDzb7yUKARs9oEu14KDHJuPsELA?=
 =?us-ascii?Q?dCuDdhb6ykKFf9vW3bsLjnd877FOzRK5x7N4z954VjQzLwptYiS+H9F35m5m?=
 =?us-ascii?Q?zzREG8tZ1EPTDHffqzQ+Fq5xt+NrmuqLAZTzzMD8FTqaF5VKKDvgWigo/Ky2?=
 =?us-ascii?Q?OCIccJI3oSF/LT1PEPlfbtst5AtHpyifUWpkwIo+HH4QZv4iZvE6mK53xfdQ?=
 =?us-ascii?Q?AvQk0e1buKTkhocOn2o3qGQTlkErmQqjIBDvcJfBK7ywJQu/irKf3zNf4XFE?=
 =?us-ascii?Q?XPNTc5AB5ojtPbfkFTLtL9xHETk10iZl2LH/p0wDPcVky5oy/bnrRikV5BAv?=
 =?us-ascii?Q?WFnRSYaUbM4o2MErEFgPYv75W1qSTfImyc7bMXMOHXEu+ZbeDrtKHJXtNin9?=
 =?us-ascii?Q?N8/jZakTkV32QzOqaQd/2rf0nUN8C3xHRNfDC7B+LLXaIdbrpvDYs3d+rdN3?=
 =?us-ascii?Q?oOReHdeO0RMxX5EkdreuP9TpT3sefyi+eyfSYIJ+9fh+K47WCQ26ukCMydZl?=
 =?us-ascii?Q?+hbsPWzV8zmrLxgG8e8kC165j/QLHVFJiTvGPMyHgz+a7nGZS5wNgXL6XVw2?=
 =?us-ascii?Q?YaaQJYjuMYKl7kiEGRz0CW4lqV24vWE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ea2fe1-47bc-4533-3235-08df3ff7fe10
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:30:46.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGE3/ZK10lwqV0aMvhHxJ/TIW+COVecsASKPWxf80FI5X5TAkb9IotmlsS0cNgNAYoHfiDj6qbhMBF/fcPhH95yamA/xsiVioJoVY5o8jdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9356
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The protocol is used by bootloaders to obtain timestamps from
the firmware to measure boot delays (and where they originate from).

This has been tested with on the corresponding efibootguard series [1].
The corresponding EDK2 implementation has already been merged [2].

Note, that the protocol is defined in the UEFI Platform Initialization
(PI) specification.

Changes since v2:
- add interface to get end value of timers, update drivers accordingly
- update documentation to reflect counter end value interface
- only enable protocol if !HAS_BOARD_SIZE_LIMIT

Changes since v1:
- p3: clarified the docs around counter wrapping
- p2: reworked the selftest to test against an independent time source
- reworked commit messages
- rebased onto main

[1] https://groups.google.com/g/efibootguard-dev/c/U0SED_2Kaok
[2] https://github.com/tianocore/edk2/pull/13343

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (5):
  timer: provide the counter end value
  timer: set end value for drivers with narrow counters
  efi_loader: implement EFI_TIMESTAMP_PROTOCOL
  efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
  doc: uefi: describe EFI_TIMESTAMP_PROTOCOL

 doc/develop/uefi/uefi.rst                 |  15 +++
 drivers/timer/ast_timer.c                 |   1 +
 drivers/timer/cadence-ttc.c               |   7 ++
 drivers/timer/sp804_timer.c               |   1 +
 drivers/timer/starfive-timer.c            |   1 +
 drivers/timer/stm32_timer.c               |   3 +
 drivers/timer/timer-uclass.c              |  15 ++-
 include/efi_api.h                         |   4 +
 include/efi_loader.h                      |   4 +
 include/efi_timestamp.h                   |  35 ++++++
 include/time.h                            |   7 ++
 include/timer.h                           |  10 ++
 lib/efi_loader/Kconfig                    |   9 ++
 lib/efi_loader/Makefile                   |   1 +
 lib/efi_loader/efi_setup.c                |   7 ++
 lib/efi_loader/efi_timestamp.c            |  77 ++++++++++++
 lib/efi_selftest/Makefile                 |   1 +
 lib/efi_selftest/efi_selftest_timestamp.c | 142 ++++++++++++++++++++++
 lib/time.c                                |  13 ++
 lib/uuid.c                                |   4 +
 20 files changed, 355 insertions(+), 2 deletions(-)
 create mode 100644 include/efi_timestamp.h
 create mode 100644 lib/efi_loader/efi_timestamp.c
 create mode 100644 lib/efi_selftest/efi_selftest_timestamp.c

-- 
2.55.0

