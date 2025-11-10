Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8824CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A115683AA1;
	Mon, 10 Nov 2025 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ej22K5Yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7455583AA0; Mon, 10 Nov 2025 18:37:58 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E87DF83A94
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu46ftyC40XJMnMFqUfeAGZplbZ3lrD9RyPOYKOwf4WS6l03d8KXtGepnc9KvCYupg6ur5Ohm4qFsQKbImPKxT2XYzfutOCZ0Begz8AofZnGlR/zzOL9b0HH8WFiW+Cf6QxrtxdMDF5LC9MxPreL/DvthlEIAKGONYKQLuu21dJjNkKQn+Nz0p9Mst+UmIBnLsuNEMIggywe+ypcCuLVmrc1niAW8QFI7zodjQp7pc9Y3zNocfMfAAjGyzBQHjKeN7IPddL30B4esTsR/n5rwAN0JrZGyLcNHu0pzaIgN5eV/GgQnqAVyzhKPqjT9UaadibOnOMVRRbQxpLTCMp8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u763ua4SDYQrb21FeBWSnQYENTclou28ywM5wOVGZhU=;
 b=EcgBUGKxzWpiEU/FH+D/lI9lJfMJt93qJj/MEIvOyI83HRiFwkGpQRHJuVfwej1bJ6mNhuI7Oy3eEufBcVwjGikfBQnK/WScnT1Pq1LSxRddNwq1qCIdrUg/bNuTtRKsQ5MZuXpBASPrdwjKF+8Yn9/f4bjAQWRisVRMQ/EdsQ2YjseOLRuWnaKLIeN4YMEu9TQrUHYBbl4Z1A4LShgxacpOtuAvA+EYrir9aJNKRFHUVqw/TE7tgOnFp6+vDXJxqOokBH/dFNnCTqV31dJvrXe2YlVZEgwFbz+egeBPN16cAC8pbFl2UnH/hebi/E1IJMrHTEDI9fL84zIsuv1XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u763ua4SDYQrb21FeBWSnQYENTclou28ywM5wOVGZhU=;
 b=ej22K5YnFnncjyOwI3Y0THQH+2hrkncvYvvZ48vL6L3UesAfjzCPiGFgFDGcMsLBTrk3Oc9okPbEN79TAiFd6VXe1uOZJKZRwBIpQTcieszTAiWpkEm1vvQvxzY4ZXJLu6vRcDmwL0AM+ng2auoCm717OBFufW7v42AhhqjWXHq77/2OIUYO1Ua6fYTuw8tsE3FXtP+k59ruehZaK044uSnIJKBzAMpdVljYy8Pa2RcqOg6X1sC5Z6be3n15DbgVkewprico+LFZKFW3Ss8TPcIka7SdsIgo7fQzysFQieKD0m2wHjCBcyWKTPdTFnodvzz+vz4hocNpdAe7uF3frw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM4PR03MB5984.namprd03.prod.outlook.com (2603:10b6:5:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:54 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:54 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 7/8] mmc: sdhci-cadence6: socfpga: Fix DT property naming
 convention
Date: Mon, 10 Nov 2025 09:37:36 -0800
Message-Id: <20251110173737.24545-8-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM4PR03MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 46556084-2719-4ed1-261e-08de207fe0d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVZmcDFaMkFOdFluRXRjak9NSTh6MmNvT0x4bExCVVJYMndGcUdrWkRRUkNo?=
 =?utf-8?B?ejV4TlRsRXpGeHpDMlBnT3BSalpWUkwzWS85RHQ3NXFuQXVrYlNORUZNbHBF?=
 =?utf-8?B?WmJIOVBXdG1nWGNtQk1uN2FqdnhYWTJNNWV0RFZrTTZVSkszcGh4bnVxUUY0?=
 =?utf-8?B?VlN2ekdIYURuU2xGWEJWNm92Tm1HNlVvZlVDVng3a09tV1ZxUlNqWTdFWDZh?=
 =?utf-8?B?SGV3bTFqdUN6WGo2NUFpclpnaXNVM2l1alF3Z09Za0hOT1ZGTEViSU9sMlkr?=
 =?utf-8?B?cHd6emRtYVJ3LzNKMHRCRk9yRHVBU051WWJtVzE4L21zNUdGQVo2amZTQ2hZ?=
 =?utf-8?B?TWJNNStCN25razhZbmhSMTBBYkpVNm1FV0pDaWRZRisrS045dG9YQ1VQckRx?=
 =?utf-8?B?a0Y0Y1VTSnlRaG93eXJob21EV0p4dUFnSXlpTXl0VUd4MXkra2ZVRDNKMlg4?=
 =?utf-8?B?SkpZZngvdytNUU5aQWdLWUdsQWZlRGFJYnRYY1BMWXZMOU1iWTloSkMwSENr?=
 =?utf-8?B?QWEzdjRNbVk1eVZMV2g1cW5WYUhtZFlhU1NIL20yRGNTNzFaNHkrMVFZamN6?=
 =?utf-8?B?NFZubGt0cy9DOWN3b2U3MkE2WFpYSHRIYlZ5ejEweldDdGxuOEcwV3lXa2o5?=
 =?utf-8?B?QjJNTW5HdnB1d1RsNERNTncrcVdDakNvYlVRby9IVTdPQlR1eGVhaVVVSWRR?=
 =?utf-8?B?dGgyT0owMGYrQlFrV0E0WEdpcCtMVXJDbmpuWks5cm1zaGJWT0ZkczFyU3B0?=
 =?utf-8?B?ZVhjN2xoeGovSTBhWnMvQVpvWHNkN2hOSUY0MUVIcXBtVlZmME0yRklEd3Fi?=
 =?utf-8?B?ZnVUcnZJWU93emd5QTk3TDlZRzFvOU1Lc2NpNmN2cGZwcXZYa3BvT1p5cGdD?=
 =?utf-8?B?ZFo3UlE3TDNTN2ZjSDVwbEZOVDViRmZ6WkNYRkJOOVIrcWdmWGhKWURBT1F5?=
 =?utf-8?B?UStHSTM3TnBtMWVnS1NJU0p5ci9DMjEySWlOK085c0VOS1pEOVRENUdkcDlj?=
 =?utf-8?B?SExKL0tobjNpZ3hPczZ4WTAzTnhjZ09rNlBUQ3UyZWxkb08vUlZkZ28wUDYx?=
 =?utf-8?B?R3I5dGs4OVV0TndEc0JhNnJoemZITHdNYmlkcHh3UUQycVB3cEM5cWJkMEFV?=
 =?utf-8?B?UHFvMi9hVWd6WnZkK0hxTHdyWnFmK2xiYXJwZFNFMEZvcnh1YUpZZ2tsQndC?=
 =?utf-8?B?QmppZXpvVUNxVERYY09BOFVqTmpKYzFxbTVXMStMSzNUckZucFJxVVNWdUVR?=
 =?utf-8?B?bHRoY3hVeDJHdkJXeU1XcmRJbVRmdXZBWWcvOWw0WEltMzlkbFhJRkozVzda?=
 =?utf-8?B?OXFPOU1VSEk0bmRNWUxuMVhiM0RGQW4rejBMeklzV0pjd2E4cllqNXIycnBm?=
 =?utf-8?B?akVTUGdEYytTNHJyTVhydnI1dmpyZThNd3F4Y3BjZTBka0FrbzA1cEs1eE00?=
 =?utf-8?B?WSt6YnBsWkhEWFNTSGsrb1JwVFV0dVBueXRheFJHSC9yYm5SYXg0ZWxMUnVF?=
 =?utf-8?B?ZGZKWUVJL2o1UnYyNEZtTmJBMkZFMDBlalJ0UjlXT3dVT2Nhd3JSelRCNDFl?=
 =?utf-8?B?M2F2dXlnY3RMakYzQkN6WHVqY2NXM3NNcjY3Mk83NGM5ODRSN3AwVGx2Mzhy?=
 =?utf-8?B?T1BNazFXVmUwdFg3OE9tWHNTZ3JzMk9GVFBDRmJ3L2hOeWtCdktSR2JtTzh2?=
 =?utf-8?B?YmpETFZ0d1kzVmN4ejVucllWT3F0bUt6bm41ZWt3UDJxdEo1SEc0aEFPVEt6?=
 =?utf-8?B?dEY4R1RNMVZxV2Jrck90ZHlLK0g5M05qWTVaT3VET3lKSmN5ZktDcy9DSEVa?=
 =?utf-8?B?Rk5pd21ZaDB5RStzRWkwZHFCNVJSQ3RlcDUvc3Z1cWozRk1QMnczZmJVSlV2?=
 =?utf-8?B?VzJUYVM1V0JxUmF3OGdaamdPNzExZ3RXYXZRRnNIYlFVVHBjS3ZYYlBrYllZ?=
 =?utf-8?Q?0pY2MHSHn1wNrHc7FrtEjfOemFMDuj8B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVESytCQkN6aHV2Ri93aGU2WWJtc0ZLUUNYdklOUGNoVVNUOTRYdXhsVlRp?=
 =?utf-8?B?STRpeWtpRXBQbjFsRmdkS0UwS3YwbnQzQlZuNjlsZTFtS1RHOHByZ2xPVGtU?=
 =?utf-8?B?S3IraXhRSkhEMFFZVVJIQXBkeC9EZklGRFZPYjJ4R09LRWdBOWtNR2Q2L3ht?=
 =?utf-8?B?ZWhhY3BKMzhyT3NScmtBWGFLSXRPdVlJcTEzbXh6dzVFU05aWElrNUlqSGZ5?=
 =?utf-8?B?amNNRUthTGJDeW5iOTFpTzZlRzNwaFIvY2dzZ0hjMWJ3QjJuUmdEZ2JMVVVx?=
 =?utf-8?B?U3hySFZVem9zWVoyK3Q0cy95Smwra1JvUWFpYVN1UUtrVDZWME1jbnVZbGll?=
 =?utf-8?B?a2praWY3YkRUSnVMSlJwZURQWU9tMEc1cVBPdWpDYmg1Nmd3Q3FDQU5rdndE?=
 =?utf-8?B?UktudGQ5UTYvMk9Qb2RMbEV3dnhya0lCZ0gzcitwK1N1OEM2WjN0N3UwYVdK?=
 =?utf-8?B?WFNTMWFrTkNCdHhlZW5Bdys3dzlGclhCVTIyeng0LzRzMjl6cXFIQTYzOGp1?=
 =?utf-8?B?eTBqWFF0eVlyb25SZnAyUTBTSnZra3VuM09IVWdsSE5qNklFOGhxQW4vMHlQ?=
 =?utf-8?B?ckRNYWdTVGhVYWliaGdYektWbkFsTUhDeTFTRnRsNUpwaDVCMDJ2amliYU1T?=
 =?utf-8?B?R01idmNkMWh5amJZckhzdlkyMDlqKzVaeDgyRVhYT3JtQk9DYkFQRzg5eDBy?=
 =?utf-8?B?S2NpUktPb2hJUEJwMytPWnFNaDVGY3FvVk52RktBZi9hbklxM3RjbnZkdEJw?=
 =?utf-8?B?aGNGellrc1dGK3dCOXBwMy9MTHVGYnZ4TndZSzdoamdvWjlrVHpwRFlUT3pT?=
 =?utf-8?B?anpJdUFmVS83MDNKREl6aGpFaHZuaTJJeVViY2hyVWxTVGFsQ0hlRkpTSWl2?=
 =?utf-8?B?aWNqTmtNSUFpTDBhTWlUdTdLdVYrUHFZYXQ4ckdKRk01ZmJoOTlJTnFQYm4w?=
 =?utf-8?B?SGtLZFFjeERVTXdJV25aL0htRTh2Y1l1WDVXc0dJQkRKSlBDRmVmVFJmTVVu?=
 =?utf-8?B?MzdpUytCaU1nczlFM2xPcDZiNFgyWStYbGN1WFpkeWl0aDRaeDFKQnVyZ3Rj?=
 =?utf-8?B?MDN6Z1d5RHJrZjJGU0F5dHloR2dXYXV4b0lBcHZ4TitXaXZNVTR3UUJpR3NJ?=
 =?utf-8?B?bUNkdHpoQ01PT2FEK1RJbzBCc0kxUk9WcVV2QXpNbEI0cUxHdE1yVmFaZm9F?=
 =?utf-8?B?eFFNaHBvbGtjNThCWXFxMWdWczEzUjNkSU5aU2VKSUVoMXNKMUoyL0ZmazhT?=
 =?utf-8?B?MWQ1alhNUUgvUkI1L21YZUl6cDR5MzMyN3I4Y3g1RXN2V1JGVzlPR0JUMVVs?=
 =?utf-8?B?elRHZ3MyRlYzcmh4YTJuU3dRRndQRnpGbHhNRWdiR09Yck5PL05KWEVnai9X?=
 =?utf-8?B?L1RmWkg4ZHJ0VVdWN0ZlY0R5QlJweU5RRllWWFZac2d1clZTZ3VPSnQvNjN2?=
 =?utf-8?B?c3dLelVXZ2NjSWRYdVZsTEQ1engzdk91dmxyQWxUN2lOdnAwL3VGNTd1N1Nh?=
 =?utf-8?B?Rml2WlV3cnBSUzIvQk1yb2RSTzZnaGorcFFBNzNYbTBBbFFBOTFCV1Vzazc4?=
 =?utf-8?B?cGpPTVczdCtrQng5VUtxVlVMVFNqbHhuWEhIOWY0RW1tTndaNER0T24yMHpM?=
 =?utf-8?B?S3dxWXFoVEFCVFZ6a0FhTkNqMG5sNDFkeUhvcVdYNW5sNU9iOE5rZTIzRk81?=
 =?utf-8?B?WE9wV05IWnY5dmxCdy9OVnExRlptbWdZeWcyUnBXNURidmZGQms1a1pjS1d6?=
 =?utf-8?B?clpHSnRJWDllWm1hOUlqVW1Pcm5iQzl0aUQ4OHd3bEczdHNLLzBDM2ZtR01n?=
 =?utf-8?B?QVh6L3NkdFpvZlFXK0JDSE85Zzk0Yi8xWXU5Y3FmZjlnamNBNlIzemtRMnJv?=
 =?utf-8?B?c0F4Wko4Y1h6ak5mYTNTTS85QTRyWDJhYTBYYVlLclM5L0htNUUxaHJJT3lY?=
 =?utf-8?B?TEl1WGJ6d3dyb0ZVOUFaU2s0YUd0ZzFkV24xbmZsQUZUSWRjREZWYmtsekpS?=
 =?utf-8?B?YnNMNEU2WEVsTUc2WWZMZ1ppcTluT1BITzFqdWREK0RjTHhXc0o1ZUVJa2Ey?=
 =?utf-8?B?Z2ZDNW5DeGhtbTB5OWtxZ1hjSDJ5T1UrNUd5OEpjVmlCZkhsMVNkRFhCOHZn?=
 =?utf-8?B?UWlLUmtudVJ3b0p3NWRpbVhFbjVyaXV5VlpPTUhNZ2FUelkyMDJuNjBudW9C?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46556084-2719-4ed1-261e-08de207fe0d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:53.9817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhsa5C2CHjz4lterRa5NtcTZyOY4Vnk6yxnZvyJ5iGjHBadOSStY5zwWdqpxWCeq8fPlBHeySO1wADJfipIiwsbC49shYP63UAFQB/vUC4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5984
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

1. Replace underscores with hyphens in device tree property names to
follow the standard DT naming convention. This affects all
"lpbk_ctrl" properties which are now correctly named "lpbk-ctrl".

Changes:
- cdns,phy-gate-lpbk_ctrl-delay-* → cdns,phy-gate-lpbk-ctrl-delay-*
- cdns,ctrl-hrs10-lpbk_ctrl-delay-* → cdns,ctrl-hrs10-lpbk-ctrl-delay-*

2. Fix typo: semmc → emmc in eMMC SDR PHY property name

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index d4e2cb1c83e..d9467293807 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -73,84 +73,84 @@ struct sdhci_cdns6_ctrl_cfg {
 
 static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-sd-ds", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-hs", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-sd-hs", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
-	{ "cdns,phy-dqs-timing-delay-semmc-sdr", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-sdr", 0x01A00040, },
+	{ "cdns,phy-dqs-timing-delay-emmc-sdr", 0x00380004, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-ddr", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-ddr", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs200", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-hs200", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs400", 0x00280004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-hs400", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-ds", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-sd-ds", 0x00020000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-ds", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-ds", 0x00080000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-hs", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-sd-hs", 0x00030000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-hs", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-hs", 0x00080000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-sdr", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-sdr", 0x00030000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-sdr", 0x00080000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_ddr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-ddr", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-ddr", 0x00020000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-ddr", 0x11000001, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-ddr", 0x00090001, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_hs200_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs200", 0x00018000, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-hs200", 0x00080000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs200", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs200", 0x00090000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_hs400_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs400", 0x00018000, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-hs400", 0x00080000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs400", 0x11000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs400", 0x00080000, },
 };
-- 
2.43.7

