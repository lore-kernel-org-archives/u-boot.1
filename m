Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE2606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0vdgr9dA;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=mpUiElGa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C17E3606F6;
	Tue, 24 Nov 2026 20:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 68wyJWHKgOvq; Tue, 24 Nov 2026 20:06:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E03BF6065C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795550777;
	b=ddNR9p4fe71xmxishNFQ3DgbVRYk6p+mGe+gTMV3TYcqiOUC8e/DgxYfwkFOM1xa/fY3
	 O5A1kAAb5e8Ow72xe3FuzpGcMt7g4F8++8Z+DaVKxKJ6g2Pi8kzoofw6XR78lTk5TUmyp
	 5IiUPb9mxoVqQVEHAWSuWAi0SiGKgecHDG2/PWbtcaeiTEUIqyXJhC1xsnVVVPj+rtmwE
	 rbO6OEuT94hYr73GO4fHFXvZS9JItXGd+D1oNVmPOXm7sftAikVcGbOcPEEBmeMXUgmxi
	 Lpunel3jjsPPr+crM+L+PvKTQFHzguAPhaUrxTuwsBfpOjP+f4+KvEOBB/lE8Zwxmxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795550777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CskFwxfLRozh4dziRAmTF5G5JudMlvognYdFaSEHGtE=;
	b=DnhFdHWs77opTP3sQE94GmSTd2CgmyWZZVxTAiBxCW3pTvoti84cknbz1ba99hKLz8fu
	 XTGOhg+jkRMT4fgW6FNt8W4bq23mh5mTBTdc8gx4FOHmQm4P6wTzBYMu9Dtq+dzuse6OT
	 16Ygw0LxHSV6qlQ18b63gRVDs7Z663eMgGR8wq0vHlUFv6xpvji5W+C+RLM6e17w/y1KG
	 eKKTt665+X5CyFkAP+0x/RhL1MYQ/reBHd6yI5JC3ZuqgTQ28PlVGb3TxBwmRmUe8UpjH
	 BxGptlhxhyzKJ3h5WMi13VUl5YqaRfv/TGw7V4UEVRBkALCqRs9FVGhYA4PlUw2AIUA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795550777;
	bh=CskFwxfLRozh4dziRAmTF5G5JudMlvognYdFaSEHGtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0vdgr9dA79Q6hsnFsUKdQ3eYmxwBHBDp+BhqgHFoNqkysY42rzdogeuSLSZHfy/8c
	 mINsvLWWiipioD9To/Yi9qzp8PtQvY6SvxZxtI/WXVM1F1o6AmhUzs6FN05uLfZtvd
	 PYewDP9/XpBGMuIvxyVVwn0acTJODBP0mqBvqEAavE48bIUcXk05II1Yr5WKxh/b93
	 oK1D1TA7NP8kdwwfZRIYue7j/pvqmMi2Ni+x+YecX6LYA9BMlk0oZlQJ9fJWKauXLR
	 06KddzHrnPS2Al/bDCUH4LU5LJ/AXJeTguOrnIdw0kzyljwHilGN9y2gWKyhCH9tSd
	 BxUoW8Eu5+nqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E03BF6065C;
	Tue, 24 Nov 2026 20:06:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B6F91C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0936A4052C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RvDB8h-B0FzR for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0315340533
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=anthony.pighin@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=mpUiElGa
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0315340533
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CskFwxfLRozh4dziRAmTF5G5JudMlvognYdFaSEHGtE=;
 b=mpUiElGaZ9AFQC2ofUQ5BIrPQmXFNPQDp2CMgHCDutpGMk476fEph5aT+STFKU1rIw4TDXaJsVRLj+iw6U+/hoI7EhBPNsvTNJ3KebfMNAHtxxjzYOIOAp0dUhjY0e8DmRZMQJbg1pHH/MloCpI0DseQas8kMhkL8vhnLbgEaM8sTbTO5TmcTIym4bIVQnilEanGlf5ROU/JfzKTXlZx/NygQ6/PAnDCGw8kOeJ9G5xVz2cYjbKqcYFjtXzyZefi4Z87mJIYeHrmSCfiXQ3r7aL3xI8x7FSvgkmgSNpcqe0gmPX4FumMvviETg27osi8spdBCKspx2ne8LpbK/r0Lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by DSAPR08MB846671.namprd08.prod.outlook.com (2603:10b6:8:51a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 19:04:42 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 19:04:42 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Olaf Baehring <olaf.baehring@draeger.com>
Subject: [PATCH 1/2] crypto: fsl: invalidate the output ring before each read
Date: Tue, 24 Nov 2026 14:04:35 -0500
Message-ID: <20261124190436.560138-2-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124190436.560138-1-anthony.pighin@nokia.com>
References: <20261124190436.560138-1-anthony.pighin@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:610:e4::33) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|DSAPR08MB846671:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cffa53-a3af-4402-b3f4-08df4a5dcba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|261009223027099003|3023799007|261021121427099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: TV1NKy7Sax51IvyuyM/WwlfLDNCkZEhZXD8EJEIfe/PWHfDWbTMpigDGZ9IRWMjEY1fU1IZnC8UEN0NGQlTmkypAS6ZUcOCIoXHd6nwltR+fDkNbJqb1emwlRiOPpPTE+S5ai56kYEcKgvjJp5BYM2BIVWbD4fw7fzoaidqaNX5POZEL48h0SKI0+UJpGfZ3IeFF/CfagKKLNghHJmbe8Se7DNyu81qvNramNZm9yIvIvsYuIianetOYxZQ8RKcs+En4O/nJq6rlyJXJz60gRMo2DyPYAqinRlqCTnP4oddHREkgNNC3Yhk9k4qsEQp9LfjbprX6791ZikVc2bM+DUlPwqT4g6kj4uiRRb+MrscICaEpLD8pC6KAuUEQORNLS9/VBpdqp2K4uciF4ceK74ZXTKAjH6HRaxqzpOkKxEPCLcivmD9vNJ/6IfR4Rjhrvs39rXBCNkA1MJ8boS+7T1AhBofiFO43aPLJIhLqU19hZRGNbGgkrfHDVQPpMsxE42rznnDI6T460tnTw7pR2hs3Zw/HwBfz9TJi245xXg+50cHVlVVOD2DO1s1PgdEICH64YAPi6FOHLuRD6iXs2OS6Ub0oNCF+UCpbOCkLqAPGGMDr8w5tLaUBk98E7qKW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(261021121427099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FqdWB7XaUM5ozTkotNO3r8EZXZq0YmnKJxa009G+2+3XPa3D/3eUyriZWniu?=
 =?us-ascii?Q?R/ml1H7YO3tkoSRapAJxJn8qKSo3iWmQPZ5U5HYc6b/9WRZkRCAykxzfveQi?=
 =?us-ascii?Q?bPd2oXmWTqluAF1BchRKgMhYgD/F/y/hck2/6p8IawjCaAeY9ag6gUWQiCNF?=
 =?us-ascii?Q?rEsNvngQuwZSZcsPJGwy+Zcna7DMLe2izvY5NYp9ulbypPpGYyDvb9MnHoTp?=
 =?us-ascii?Q?kYEUK/rdEzv8RZ+fUa09WC1Ubzt/W9Pde+LKj3/AJvX98OrgeNQ5ZDwCe7SG?=
 =?us-ascii?Q?BWwBP5vVW1Avkr/HoZMcKFLmMKTELISXdnepZMX80i7M3IgmsbI+O89vVBNz?=
 =?us-ascii?Q?g5Xl7YDPlCchGuf6a9rRmstHfRuM9No2+IDhX42EiZ4zBzFSVxvoqpLkmvSH?=
 =?us-ascii?Q?A0pCpCueWLFrottTe75CwKB+0vE8AdEAiISDdZ70CmuarCBI/NQM6Qcxlagr?=
 =?us-ascii?Q?7xYGmGHaltpxMaTYEMQGxieGUdm2pdoFjFa3YOVcp+eu/JNH90KGYe8L8NMa?=
 =?us-ascii?Q?mAvmLxCT2t+IlWBC7y2WH6AFa3xf8Fbb4IipUfgLF3ycjcn33Aw8uEcNn+1I?=
 =?us-ascii?Q?ugEqy6U4aLbhV3oEt2vOQTxMz7cOux+0dzdP41ttxePl9QCD7x32vsBfsgw4?=
 =?us-ascii?Q?YGkvkPdFgVYIudRrepGnRjC+VatW8j7qevPg5CvVQ0dOIA3ZeEQBYp5+TNV+?=
 =?us-ascii?Q?VKeWiPsRr0QKO9HDxiOnFARpEtaUvaiRCXuqvb2mZljTXQIY0S1/wwJqptzL?=
 =?us-ascii?Q?zkuGG6vgmSkL4tMVNOpqbFwNTiaiVXT6ZyIPona05ITQGod7T9BiTS+oOIzS?=
 =?us-ascii?Q?PORfZZvPJ5vze50ObdiCUyF1YT6OWhCnNQN1IM7ZNWg2AEthSRKBgxD7VUKd?=
 =?us-ascii?Q?IiNm3QVbO1WvVRoBPWLRNPS6eSVFBJOFQwhQhNzTMKuqF7ilJzCaHc07L/4J?=
 =?us-ascii?Q?oGFAgRWmv2KLD21hwFg8HQbYcj4Z4w+A8y65dLXldhk9rEaVH/5xyuibZdJn?=
 =?us-ascii?Q?1yVUQJlNoJPSjqDIgLDpdOLRRpeIItw3IzpJJTzbZwlMzCWwFxsQmjvFjo4/?=
 =?us-ascii?Q?DPVJmGgo0VEEXHxAgCKhNmsVAlgU48Ei/al2wGEGBoiSNAvcXCkKkIzszx+u?=
 =?us-ascii?Q?unHT2wPHNGW7QFFNErmgTzDytmUCpmxyGZX6+xHVZ6ay0IyjVTCyML9FVy5w?=
 =?us-ascii?Q?1FLu8tqLzAXMcXQqqB6yrp47sjgn2uC79sQ01W7pOl19hjfCH+AvmH0/z+3i?=
 =?us-ascii?Q?4gIDL6pvXzC4yv3nMgqHKMi0pPymFfoEDXlTiUKlnjibU9g06Pfa3DWvE/iD?=
 =?us-ascii?Q?exViqasKFOZKZ2fE+1l4MzJIF4cYpRKPPYlnAThopjRPT+MrYNIQbgAPUywd?=
 =?us-ascii?Q?I8KIJUpj037/uPPAjblSdlcpo8iCTcN2Kl7+ABMZjrOsASyhkUQXJWY8/szi?=
 =?us-ascii?Q?6Z/B3Z9Xu7C4SHw1PjZbNBS1k35AoWMmLEu/Kry75rYDbDnnETW12IedJk9r?=
 =?us-ascii?Q?JK9lZ47zszE2v9yNTG70EWc5EVV1g/1YAfkJ2S91anvhs9AWbVPnW/XLZ/J0?=
 =?us-ascii?Q?q6GQQ8Em2/BM2JRinQq4oYphzCGUAwPZHR9GyShXNyFS6q18/WGuv4QZDPo5?=
 =?us-ascii?Q?yr9ZWDF0oRHIRRuSAVyq/EdZrhvpMZFj/Fy4R+9GbrLru84JGs0oJ+vAMrMp?=
 =?us-ascii?Q?zQVim7e0U+7d78cq8im4PF0OymVN9rMYIZtouuYx6mmPMq5xeAX45r96Vnrm?=
 =?us-ascii?Q?v40duLguI8f9sPTyuZTmNmPbhH+Ablg=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cffa53-a3af-4402-b3f4-08df4a5dcba4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:04:42.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGOzv7NxlfE0hpqJd7U8ulOJyJE2/oTumUDTO/3kmtHFmpDvLFEmMMQYpxhsP2il7bdoqsCCkecZ+PxSsSvBD67ybT9A00alxDOwEcYbbGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR08MB846671
X-Mailman-Approved-At: Tue, 24 Nov 2026 20:06:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

jr_dequeue() reads the job ring output ring once CAAM reports a
completed job, but the ring is only invalidated in jr_enqueue(), before
the job is submitted. On SoCs where CAAM's writes to the ring are not
coherent with the CPU caches, a line the CPU fetches speculatively in
between hides the result. The dequeue then finds no job matching the
output ring entry, and run_descriptor_jr() fails with JQ_DEQ_ERR.

Invalidate the output ring before each read in jr_dequeue(), and keep
the invalidation in jr_enqueue().

Commit 159b6f0e1199 ("caam: Fix CAAM error on startup") added the same
invalidation, but also removed the one in jr_enqueue() and reworked how
jr_dequeue() handles an output ring entry that matches no job. It was
reverted by commit b492f9520c04 ("Revert "caam: Fix CAAM error on
startup"") after the first dequeue failed on i.MX8MM. This patch takes
only the added invalidation. Keeping the one in jr_enqueue() also means
the ring's cache lines, dirtied by memset() in jr_init(), are clean
before CAAM first writes the ring.

Link: https://lore.kernel.org/u-boot/CAJ+vNU1Ge_s4mEFYCn0TPhuKW5X1J-jcV3GyZqc_70GjgsqRtA@mail.gmail.com/
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Olaf Baehring <olaf.baehring@draeger.com>
---
 drivers/crypto/fsl/jr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 3a5032bcaf6..53f8af15f5c 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -243,6 +243,7 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 #else
 	uint32_t *addr;
 #endif
+	unsigned long start, end;
 
 	while (sec_in32(&regs->orsf) && CIRC_CNT(jr->head, jr->tail,
 						 jr->size)) {
@@ -250,6 +251,11 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 		found = 0;
 
 		caam_dma_addr_t op_desc;
+
+		/* Invalidate output ring */
+		start = (unsigned long)jr->output_ring & ~(ARCH_DMA_MINALIGN - 1);
+		end = ALIGN((unsigned long)jr->output_ring + jr->op_size, ARCH_DMA_MINALIGN);
+		invalidate_dcache_range(start, end);
 	#ifdef CONFIG_CAAM_64BIT
 		/* Read the 64 bit Descriptor address from Output Ring.
 		 * The 32 bit hign and low part of the address will
-- 
2.43.0

