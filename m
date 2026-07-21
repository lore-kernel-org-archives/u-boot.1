Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3EFC44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EEDA80EDD;
	Tue, 21 Jul 2026 15:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAj4lJKZS6qX; Tue, 21 Jul 2026 15:16:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB9A280EB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784647014;
	bh=mHon+OJzzL4cqmkTmPTJnFi7nG0Qt5Vi+GYdnhU2kIM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EvcHz7YalBZSilpmpDeuAvRYAuEsTlSfQ22gM8VjcoOHC8gwFfwQI7pl10LFGNb56
	 XWQUtc0c2ld4mEGY7PDWrmFt7KkTY0zh3QenT1w9HWG/wp3NjuMtW2BPolZmbSGGvw
	 59HwVte4zPVmxbHFRvuB418qgqKRaS1KzYEjxCPTNR8lpXMBRolO3CE97N2AwLiqKq
	 bn3mKTG2baqPFeigwGpFc/2PSHm/+u8Futfrf7vZlvlsALGa4e8CFqJf1nuNlpW9N9
	 D99nPWsEUpDodUBSusN78rf9fpdYNBpWbuYD0kH01QReiQV6IanHfdyE34P6rjDe/v
	 l0EYu1UzF09UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB9A280EB7;
	Tue, 21 Jul 2026 15:16:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DA44EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5305F80EB7
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUK28lM6qTjW for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:16:52 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ED31180EB4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED31180EB4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED31180EB4
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:16:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49AE8846A4; Tue, 21 Jul 2026 17:16:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F70803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 17:16:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT9jx9EL2DlHMqGzCTN95zG61gsZGAH2orh2ueALh7OHv6TRz5okQnvH12jMOTuwUUnKB3YPosHrE47sbRalySk/QmA4zws3rqUFtN/wsgotk7q79ylowQn8Vixob1NJLmzH0UWtA04w7AnvY38DQ5As2jeVpY0siW0tBgDGUymVs5QrC26HAPB6W+jKOJl5w3ARuKia3FrrIaon78LfpxFFU9+QWDALm9XTGCi1AGnrDOYr9AVRgvc+8ooQv/u9bXlG7NMIi3gwSP45TQKE9s26IYJXuFuch6wV+Dbg9ko56yaWKELGiHDtnQXFR4GqkIrBOsEbuEnxL/zPYbmi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHon+OJzzL4cqmkTmPTJnFi7nG0Qt5Vi+GYdnhU2kIM=;
 b=alNSwrt9MgXMw79Q/uczE6wYbboR4kjwKeb3W0sPRyHSyMCcHXPXzc4hlrMs9TGCeGDGfWw8N50LpkBYwnbzuhk94vkrCvyQFkoqTILc/3KxYblwr5d6aQqNksphQ+D0HczawstoXFGxa6k0G2Xbd+gaYkB9qr53Q/AAqbJwssTve+VRUlHuUI9GeMaHFmewm2r2mnGGQxc1AlciLM7MsszmAEPCN933Xq53nZUu6HwuIQ4Zk5gUFul9vUhhTZX2ZGpGzJS1Gp8Cb6xqE8lwgd2o6pd3DfokMPmqPH8lqCsAv44UheqrLJVh29+LnVRNgzGbmZBUiFXIoOIFouFz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:16:45 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 15:16:45 +0000
Message-ID: <5a888947-570a-4a34-a714-a6107ccad025@cherry.de>
Date: Tue, 21 Jul 2026 17:16:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] tools: mkeficapsule: Rework pkcs11 support
To: Fabio Estevam <festevam@gmail.com>, xypron.glpk@gmx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 marex@nabladev.com, dwmw2@infradead.org, Wojciech.Dubowik@mt.com,
 fra.schnyder@gmail.com, u-boot@lists.denx.de
References: <20260721141350.45800-1-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260721141350.45800-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0029.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 157f3cb4-0513-47cd-d9d7-08dee73b1383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|3023799007|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xTaz7P1igpywnupx1RO+onwk4N5Haz8oBsdWNIFfj4l/5YllRzojwRS/+aw1gaWtG3WA2jk9Si2/WStiNmMKg4eWPgqKdziJLSr2zPZ3WBAMDiCKVM4HfAAjsyWXH/TqIi9yr9AoNB5c2v1O4oHw8gDO3J9pqIU02vh2EPOhvqIqV8IEyBrmfA2B8K68LoO03Y/o54rnnum8HD/hP7lvLfGj09HSgrjq+eyS4Lit3oEVK3dRdTVYRuWCc+pbLHjeCK0k0LGNm3N4xztx3SVD3IuPccdC5Dqc7KIetGP6ljU3noDeBwVI0AlDfGa3zvla2gmdRLi7XaElEumf9/sGD3NRFTPkj/cu9mgBqMEPzf+gtKcJlQIs/wkfdcYqaYTWFTZ1l8mJfD7RR0OBmcLZSSo87XLLea4MszwMiCjGc9kxSsysaNIZhUV6VS+tM1lOpKo4c3NufgSqhIggTqzlM4Tu7BHRjKJMH0C/RCdA5GmXQLGtvB1v0+qgsOphrhYJe7y+SebrB1MMnmLjKj7wxBzd2CQvQIcJYLzOJYTXcOVlPMr3YQpEc2FQiGzlYZStAHGj75EJzGzDs4OwVrYazhg6AxDNDbs2wbCIC4/RURKOW0oj95qXQUUYOhYnPRrB6XC+1mD/7Wl1pWVOIM1UPk+50abWO3RI31wHS5JJ+l8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFoNG9GVDVzUlQvL0lKdWUyVUpMUUc2ZnhHRlArQ2Jpdkt1Z1BuWHRpd1Rm?=
 =?utf-8?B?c2lNTmdtZ29KeU5WSG16WW1yWjl1WjAxanZ4VGRvRHVROWNZVkwwNXpsb01q?=
 =?utf-8?B?b3dsZ3NVT1piTEhnZ0tSTFByNXZzTFVqMk1tWmN0NXdSWmdCanN0Q0xlMy9Q?=
 =?utf-8?B?T21jQnpibmFKYm12TWJQY0Z5eHBJbjVMOVduNVJSVlE2RTlxRW5KK0g1cnd0?=
 =?utf-8?B?VGMyVkpNd3d0TGhUVklxOUFLYmR6MVpOTVoyR2JDTWJUWHlUMEFhRU1yK0xQ?=
 =?utf-8?B?a3gwUjIyN0tKQ2xYS0dKZUdxY3l4akRvZWVGRFhCZ0VrZ3dZR0ovSThXMi9W?=
 =?utf-8?B?L3FkTTkrVHlLc0dsUklXVHRjbDZvTXNIZ21qQUVQQkdzSUExUFRzbjJHNGEw?=
 =?utf-8?B?MS80N0VSYTJ6N0JFRnpaakVrQUd6RkRKVkUrbWN6U0JlK0JXS2FoV2dZeElr?=
 =?utf-8?B?OStOczNFVDdtTHk2aFNySmNVOHB0YXZpOEdqMmtGSjFpK3VQZ2s4RUJ5aTh4?=
 =?utf-8?B?dFBZc3h2YlV0MzhUakNzNWZqRGNzQUNhelF0b2RxRk83Q3hDdWx4b1NLdVRq?=
 =?utf-8?B?MG95T2NHRVFvVjAySGZIVUtuTnVuUXc4YzdvSzJBVWVBL1k5N1Fod0hVWVBP?=
 =?utf-8?B?T3dxcVE1SjhuSWtNVnhsSDZWK1MxYXlXRXd2S05ZVjFsTSs1TTZ1bnIyVkhN?=
 =?utf-8?B?RW9xSUZnckJuREFPMWM4Tkc2VVoyNC9EZnh1RHlXTlRYdUFvRm05QlcyV3Fa?=
 =?utf-8?B?WUhRUDY2VTZqNmpRUGpkVWR5LzFmMlFOSkZ4TldWV0c4Q2wraDIzUUdRcWRI?=
 =?utf-8?B?UDBwMGJQU0F3a05OWEhwU3RkWTk2SWdXeHNGWnFVMWZOUmkzVDJMbm96eVUy?=
 =?utf-8?B?QzV4ZE9WTUNoeGxOZ2MyREZqY3UwcEg5RWNudTNVcVBCWmRiVU45U21zNVZz?=
 =?utf-8?B?cEdwM0dtL1hyTmhBbkpDdkQwSm84WUw4UlA5Z2JWUjA0NWs3bGVodW1uWElv?=
 =?utf-8?B?OC9Ca0I1bGc3eGF4ZkRUZE1yTnRROWFCNHNIc1k1R09Ja3FZdE5JaWk5VUR1?=
 =?utf-8?B?RTRsb2hGcTNwZHgwQklXZEpjTlJDR2hsZjJ4ZWl3cEZTQW80R1UzU0xmajRk?=
 =?utf-8?B?MUJENWlFaDZpdTZmcEVJcDJudnF3OWJJZ1pQc2Z5ajEzaEtiU095MllYcUdZ?=
 =?utf-8?B?dmFOMyt5STdjaUJ3b2pMZG5aSFh4N0hQNGQ1Nm1kNVJua0Y4WjVzWTJwR2ZC?=
 =?utf-8?B?RXp2NGlzbm5WNW1hY0VMQytyKzU1ZGsvY2VLRVZUQkM0QmtJdE0xd2lNVEMv?=
 =?utf-8?B?amEzeFJJVEIyV3VPUzZMVGd0b01wYzdFTzNCc3BtblNLUE9ldlBSQ1R5TER6?=
 =?utf-8?B?OFc3WXVkSUF6SGY0ZG9ab3l1aWlkY0ZYMnJsK2hHSFhGWWdVOGVIUzEwdEti?=
 =?utf-8?B?bC84UlAzM3lieGhOaDlEU05BcDJaNEtkcUIzUEMxV3p2L2JqQ2U5MDJLWnV4?=
 =?utf-8?B?eFFWQ3lPUkREYzA5b0pQaldjWnZ0M3dmeDFWdGpPb2dxZm9UREVIYWZ0WXNK?=
 =?utf-8?B?dWNubGMrbldaRmJCbk5ha0FRSGxKM2plZ0hFbXRFajRzZmhkcS83NVRJY3Y2?=
 =?utf-8?B?R0FobzVIalREZEJXc0pGTWhNTXFZdWwrbGZnZVJOVnJqMHMyY1Q2TTJnb2hz?=
 =?utf-8?B?QWx4ZWltSUNWU3JSOGFTOGlsck5GV0pEZXNJT0hld2x0R1Q0ZUpKbUo3c0hl?=
 =?utf-8?B?N0ZtM0RnM0FrcmFzbVgwbDM3eTRHQ1BTRFZmLzNBR0dKRENjRTdPb1J5SkR1?=
 =?utf-8?B?U0pFcmVRWEFpeEhwTEFjamYwS1M2UE54TEZiWlpvOEtGWWxKZDlwbnNrV20y?=
 =?utf-8?B?VWNVN0FiQWZZV2V2N3FCNHVNZlNKZDRjTTVOMnkzdDBKMWNTRXZxMzhKZzFN?=
 =?utf-8?B?S1FFVlplN3E3cFZNWXRHcnZrUnpPY0ZoUW5aeitFTXpsU0NRWU1wMm5HUHFF?=
 =?utf-8?B?SnFhZ3htdDdQbUlrVWJsbmpRdEJVaEh5M09xMTdiSTMxdUtQbndabWlVbEdx?=
 =?utf-8?B?ejV3N2F1WE5hS1MwMWFiV0dZWWdwMEtxZWxxMnhzcDlpWlVUQ3Ixbkhqcmha?=
 =?utf-8?B?VDBJdUR5VG5RUXEwQXdvRHN5S1lkdGZSalBRUVhGMlBUWS8yNzd2VHVjNERt?=
 =?utf-8?B?ckJVOU5YRjZ4SGNwZnIwdVFXc1J5RTZabURHZUpmWXFxZVpmQlBxNjZXcWFq?=
 =?utf-8?B?cWQ0YXh0YnRwTkVjdGZjWm5nWVBPRFRkWGowK2ZqcE5YQllGeGhRMEpKU1ZU?=
 =?utf-8?B?ZklNNlhvRTlSaDhjVEFFNG9PYzUvRGg1a3JSMHNqN0J5WWFla2dadz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 157f3cb4-0513-47cd-d9d7-08dee73b1383
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:16:45.1753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XGZI/dlhMxfUa2EAIRaau+FzMUsNlWojqQQEI+fHpIwT+QU18RLinKOSwwhDJ49mxv7eUeCq3tVL7O2pQ/aMLZQZZIb35+ERbdxOJbKHpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHon+OJzzL4cqmkTmPTJnFi7nG0Qt5Vi+GYdnhU2kIM=;
 b=Cv+UqfXgcaNdKUxLdRlyjZ25giFk3koUYHo/mVgFzaHDZ5zfH+MyvM8OQvtPGCU/M5wcMb4u6EMEBV5qAknJ2qQeNQg1c4r4GIKMi8SsoCechaA3xD9ExXVkZnV1RWsGMGtJm3wjcf2uqzWQc/C6AEfiQ4w3/exF4c0CMGDv+do=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Cv+UqfXg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="Cv+UqfXg"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/21/26 4:13 PM, Fabio Estevam wrote:
> From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> Some distributions, such as OpenEmbedded, build GnuTLS without
> PKCS #11 support, which causes mkeficapsule to fail at link time.
> 
> Detect whether GnuTLS was built with p11-kit support and enable
> PKCS #11 functionality only when available. Emit a build warning
> when mkeficapsule is built without this functionality.
> 
> When PKCS #11 is available, rely on GnuTLS and p11-kit for automatic
> provider discovery, allowing PKCS #11 URIs to be used without the
> PKCS11_MODULE_PATH environment variable.
> 
> Document the use of PKCS #11 URIs for private keys and certificates.
> 
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Please list between Wojciech and your Signed-off-by what you changed 
compared to their series.

> ---
> Sorry for the resend. I forgot to CC the list.
> 
> Only built-tested.
> 
> Changes since v8:
> - Removed Quentin's and Simon's review tags due to the significant changes
>    introduced in this version.
> - Warn when mkeficapsule is built without PKCS#11 support.
> - Rely on GnuTLS and p11-kit for automatic PKCS#11 provider discovery,
>    removing PKCS11_MODULE_PATH and manual initialization/deinitialization.
> - Improve user-facing errors for PKCS#11 certificate and key imports.
> - Document the use of PKCS#11 URIs in mkeficapsule.1 and the UEFI
>    documentation.
> - Remove PKCS11_MODULE_PATH from the SoftHSM test to verify automatic
>    provider discovery through GnuTLS and p11-kit.
> 

NACK.

You're trying to do too many unrelated things at once.

- The doc updates are unrelated to the pkcs11 support being compiled 
out. It's a nice addition but needs to be its own separate commit.
- I don't understand why we need to warn that we're building without 
pkcs11 support. Do we need to warn for anything that isn't supported? 
We're working on removing support for OpenSSL engines on select OpenSSL 
versions, should I warn when we're building mkimage? I really think this 
is unnecessary noise. I guess we could have the usage of mkeficapsule be 
different based on whether PKCS11 support is enabled or not.
- We should not remove PKCS11_MODULE_PATH in a patch making pkcs11 
optional. It is currently supported, there's no reason to decide to 
remove it. Yes it was undocumented, but maybe it's used. A separate 
patch is definitely warranted for that if this is something we want to 
do. This patch really should only gate pkcs11 support if gnutls is 
compiled without support, that's it, anything else must be a separate 
patch and justified separately.

The "urgency" is with disabling pkcs11 support in mkeficapsule when 
gnutls is built without pkcs11 support, due to OpenEmbedded having it 
disabled by default. So it's fine if we have separate series to avoid 
blocking the gating of pkcs11 support with other patches for which 
nitpicking/bikeshedding might still happen.

>   doc/develop/uefi/uefi.rst | 13 ++++++
>   doc/mkeficapsule.1        | 25 ++++++++--
>   tools/Makefile            |  9 ++++
>   tools/binman/ftest.py     |  3 +-
>   tools/mkeficapsule.c      | 98 +++++++++++++++++++++++----------------
>   5 files changed, 102 insertions(+), 46 deletions(-)
> 
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 3ca22b572a92..cf7f638f2c23 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -597,6 +597,19 @@ and used by the steps highlighted below.
>         [--fit | --raw | --guid <guid-string] \
>         <image_blob> <capsule_file_name>
>   
> +If ``mkeficapsule`` was built with PKCS #11 support, the private key and
> +certificate arguments can instead be PKCS #11 URIs. GnuTLS automatically
> +discovers PKCS #11 providers configured through p11-kit. For example:
> +
> +.. code-block:: console
> +
> +    $ mkeficapsule --monotonic-count 1 \
> +      --private-key 'pkcs11:token=U-Boot;object=capsule-key;type=private' \
> +      --certificate 'pkcs11:token=U-Boot;object=capsule-cert;type=cert' \
> +      --index 1 --instance 0 \
> +      [--fit | --raw | --guid <guid-string] \
> +      <image_blob> <capsule_file_name>
> +
>   Anti-rollback Protection
>   ************************
>   
> diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
> index ed296730eeb9..dfa9b805ca32 100644
> --- a/doc/mkeficapsule.1
> +++ b/doc/mkeficapsule.1
> @@ -108,12 +108,12 @@ With signing,
>   are all mandatory.
>   
>   .TP
> -.BI "-p\fR,\fB --private-key " private-key-file
> -Specify signer's private key file in PEM
> +.BI "-p\fR,\fB --private-key " private-key-file-or-URI
> +Specify the signer's private key as a PEM file or PKCS #11 URI.
>   
>   .TP
> -.BI "-c\fR,\fB --certificate " certificate-file
> -Specify signer's certificate file in EFI certificate list format
> +.BI "-c\fR,\fB --certificate " certificate-file-or-URI
> +Specify the signer's certificate as a PEM file or PKCS #11 URI.
>   
>   .TP
>   .BI "-m\fR,\fB --monotonic-count " count
> @@ -124,6 +124,23 @@ at every firmware update.
>   .B "-d\fR,\fB --dump-sig"
>   Dump signature data into <capsule-file-name>.p7 file
>   
> +.SH "PKCS #11"
> +If
> +.B mkeficapsule
> +was built with PKCS #11 support, a PKCS #11 URI can be used in place of the
> +private key or certificate filename. PKCS #11 providers configured through
> +p11-kit are discovered automatically by GnuTLS.
> +

Should we add a way for the user to know whether mkeficapsule was 
compiled with pkcs11 support? Otherwise how will they know (not sure 
"try and it'll fail if it isn't supported" is the best UX :) ).

> +For example:
> +
> +.EX
> +mkeficapsule --monotonic-count 1 \\
> +  --private-key 'pkcs11:token=U-Boot;object=capsule-key;type=private' \\
> +  --certificate 'pkcs11:token=U-Boot;object=capsule-cert;type=cert' \\
> +  --index 1 --instance 0 --guid <guid-string> \\
> +  <image-blob> <capsule-file>
> +.EE
> +
>   .SH "GUIDGEN OPTIONS"
>   
>   .TP
> diff --git a/tools/Makefile b/tools/Makefile
> index 1a5f425ecdaa..c156af9fc5e9 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -271,6 +271,15 @@ mkeficapsule-objs := generated/lib/uuid.o \
>   	$(LIBFDT_OBJS) \
>   	mkeficapsule.o
>   hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> +ifeq ($(CONFIG_TOOLS_MKEFICAPSULE),y)
> +GNUTLS_SUPPORTS_P11KIT = $(shell pkg-config --libs gnutls --print-requires-private \
> +			 2> /dev/null | grep p11-kit-1)
> +ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
> +HOSTCFLAGS_mkeficapsule.o += -DMKEFICAPSULE_PKCS11
> +else
> +$(warning Building mkeficapsule without PKCS#11 support)
> +endif
> +endif
>   
>   include tools/fwumdata_src/fwumdata.mk
>   
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index bf98b268ac15..d8f4d4ab2439 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7588,8 +7588,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>           self.assertIsNotNone(softhsm2_lib)
>   
>           with unittest.mock.patch.dict('os.environ',
> -                                      {'SOFTHSM2_CONF': softhsm2_conf,
> -                                       'PKCS11_MODULE_PATH': softhsm2_lib}):
> +                                      {'SOFTHSM2_CONF': softhsm2_conf}):
>                   softhsm2_util.run_cmd('--init-token', '--free', '--label',
>                                         'U-Boot token', '--pin', '1111',
>                                         '--so-pin', '222222')
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index ec640c57e8a5..b81c295f91e5 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -81,8 +81,8 @@ static void print_usage_mkeficapsule(void)
>   		"\t-i, --index <index>         update image index\n"
>   		"\t-I, --instance <instance>   update hardware instance\n"
>   		"\t-v, --fw-version <version>  firmware version\n"
> -		"\t-p, --private-key <privkey file>  private key file\n"
> -		"\t-c, --certificate <cert file>     signer's certificate file\n"
> +		"\t-p, --private-key <file|URI>  private key file or PKCS#11 URI\n"
> +		"\t-c, --certificate <file|URI>  certificate file or PKCS#11 URI\n"

Maybe we could also add (PEM) after "file" so the user knows what format 
to use? (if that really is PEM, I haven't checked myself).

>   		"\t-m, --monotonic-count <count>     monotonic count\n"
>   		"\t-d, --dump-sig              dump signature to <output file>.p7\n"
>   		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
> @@ -207,6 +207,58 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
>   	return 0;
>   }
>   
> +#ifdef MKEFICAPSULE_PKCS11
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +	gnutls_pkcs11_obj_t *obj_list;
> +	unsigned int obj_list_size = 0;
> +	int ret;
> +
> +	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> +						 ctx->cert_file, 0);
> +	if (ret < 0) {
> +		fprintf(stderr, "Failed to import PKCS#11 certificate: %s\n",
> +			gnutls_strerror(ret));
> +		return ret;
> +	}
> +	if (!obj_list_size) {
> +		fprintf(stderr,
> +			"Failed to import PKCS#11 certificate: no matching object\n");
> +		return -1;
> +	}
> +
> +	gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> +
> +	return 0;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +	int ret;
> +
> +	ret = gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
> +	if (ret < 0)
> +		fprintf(stderr, "Failed to import PKCS#11 private key: %s\n",
> +			gnutls_strerror(ret));
> +
> +	return ret;
> +}
> +#else
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +	fprintf(stderr,
> +		"Cannot import PKCS#11 certificate: support is disabled\n");
> +	return -1;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +	fprintf(stderr,
> +		"Cannot import PKCS#11 private key: support is disabled\n");
> +	return -1;
> +}
> +#endif
> +
>   /**
>    * create_auth_data - compose authentication data in capsule
>    * @auth_context:	Pointer to authentication context
> @@ -229,9 +281,6 @@ static int create_auth_data(struct auth_context *ctx)
>   	gnutls_pkcs7_t pkcs7;
>   	gnutls_datum_t data;
>   	gnutls_datum_t signature;
> -	gnutls_pkcs11_obj_t *obj_list;
> -	unsigned int obj_list_size = 0;
> -	const char *lib;
>   	int ret;
>   	bool pkcs11_cert = false;
>   	bool pkcs11_key = false;
> @@ -242,24 +291,6 @@ static int create_auth_data(struct auth_context *ctx)
>   	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
>   		pkcs11_key = true;
>   
> -	if (pkcs11_cert || pkcs11_key) {
> -		lib = getenv("PKCS11_MODULE_PATH");
> -		if (!lib) {
> -			fprintf(stdout,
> -				"PKCS11_MODULE_PATH not set in the environment\n");
> -			return -1;
> -		}
> -
> -		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
> -		gnutls_global_init();
> -
> -		ret = gnutls_pkcs11_add_provider(lib, "trusted");
> -		if (ret < 0) {
> -			fprintf(stdout, "Failed to add pkcs11 provider\n");
> -			return -1;
> -		}
> -	}
> -
>   	if (!pkcs11_cert) {
>   		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
>   		if (ret < 0)
> @@ -301,14 +332,9 @@ static int create_auth_data(struct auth_context *ctx)
>   
>   	/* load x509 certificate */
>   	if (pkcs11_cert) {
> -		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> -							 ctx->cert_file, 0);
> -		if (ret < 0 || obj_list_size == 0) {
> -			fprintf(stdout, "Failed to import crt_file URI objects\n");
> +		ret = import_pkcs11_crt(&x509, ctx);
> +		if (ret < 0)
>   			return -1;
> -		}
> -
> -		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
>   	} else {
>   		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
>   		if (ret < 0) {
> @@ -320,12 +346,9 @@ static int create_auth_data(struct auth_context *ctx)
>   
>   	/* load a private key */
>   	if (pkcs11_key) {
> -		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
> -		if (ret < 0) {
> -			fprintf(stderr, "error in %d: %s\n", __LINE__,
> -				gnutls_strerror(ret));
> +		ret = import_pkcs11_key(&pkey, ctx);
> +		if (ret < 0)
>   			return -1;
> -		}
>   	} else {
>   		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
>   						     0, 0);
> @@ -403,11 +426,6 @@ static int create_auth_data(struct auth_context *ctx)
>   	 *   gnutls_free(signature.data);
>   	 */
>   
> -	if (pkcs11_cert || pkcs11_key) {
> -		gnutls_global_deinit();
> -		gnutls_pkcs11_deinit();
> -	}
> -

Where's this gone? in v8 you used to have

	if (pkcs11_cert || pkcs11_key)
		pkcs11_deinit();

with an empty function when pkcs11 support is disabled but it's gone 
from v9.

Cheers,
Quentin
