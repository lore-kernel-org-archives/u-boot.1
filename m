Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3463DD0E6CD
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F0D83FFE;
	Tue, 25 Nov 2025 13:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hfrb4GZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D4984009; Tue, 25 Nov 2025 13:13:08 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE3C83FF4
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZtCVB3g2O8TkAVJEEXD7Fa6CK80g2J/N1jgxC5UlhFrBLDqAjJAd33WY028DwXfOAtj9e6T2aC4klvD23nfvHJv3bf1ULWTYssXTlOaN7VTLU5oZRAtXTx88bmQqH7WW4EmCL/+0bgcWfxouJQ6vvzpAud+mAPEkm9FgqLQhD3lu3QqL2fIS1ptpsyGdG3BrligtbLXBjFnLe10HvnHBwRRjdvd/NKsfP2nA5x37JFx1dpDg31krkrVzjhAXKU03j000GzoF2ZH5KFh2BNieLhCS2ADj5k6BKuZFcjn22hKTZdDQU/7McfMH/zs833HpMiR3hcaiw6kG40uSblqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBEpVtoOC4XAQQ/kaWxkz+4hogIJITb0bO66PJ/FEhA=;
 b=Htjcux6XmDjqvthvcKCBjPtZeYXEwkbe3hldDB/RmFLXwGpLyEUBz9qMda0uf6CrmLvH8OiFyKFv+q+CnwUCi6Ux/6Ea3ax4YK8R7eUL73sdLS6dUv/FAaPbdskf7JaIuwoxkUhfecwLLSPd8lBmmbDLsuDlwyH4JGLg3GgLw2jTcfTcfGh1r+7ty/Ko6vmI+CSaDq200IqmzZzh00TnBxMDholIbnndMkWEaRiHdB56x/vprHlbBYaHYG91myBgwReuoz25dxqggP5uDoiSL8N9Nuw52UQn2UthH1unD8PxK02oH1hAwFhUQxSXUtd1vAuj2qSB+xpXizBDM3MPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBEpVtoOC4XAQQ/kaWxkz+4hogIJITb0bO66PJ/FEhA=;
 b=hfrb4GZmBDhhWKnF1jD2OpZG0cVGgWquw9rD6Wi/OPqtIdxArxrUUys9pAlYpLcEDehz5YN+7B4bZivvK2IdqR+XehTbG1LmVTII9QVFK9Wp9JUkmRYGd0TP1zE5xqRBjJRoZLOHZ4CrSnFEyvtU4SuwH4lcAXu8A6g6kcAoI60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB6894.eurprd04.prod.outlook.com (2603:10a6:803:13a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 12:12:59 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 12:12:59 +0000
Message-ID: <8abc9d21-434a-4909-a854-fa5cf8863bae@cherry.de>
Date: Tue, 25 Nov 2025 13:12:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
 <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
 <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
 <CAN7C2SCODX0Xd+onkiaim0P78csxFdBDnWXP8ZK2eTL-pUHMfA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SCODX0Xd+onkiaim0P78csxFdBDnWXP8ZK2eTL-pUHMfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b84c06-1cba-4b15-1989-08de2c1bf974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0FCRWFyMS9yY1BSbTdYbmUvWUtLdEZ3YlVibEh1czZyZ1IwVU5rR2R5SlZh?=
 =?utf-8?B?M1ViNW1FSlZMUXAxQmVSa1k2YnJpU3JGeXVnU3BPTjBoNFFKYkI3SksxUVh6?=
 =?utf-8?B?RXArcWFNZ0pwdmp6Y0o3dUR4SGFxSHg4WE9ONk9TOVdLbWxYREExcEJpdnpo?=
 =?utf-8?B?b1FJVkE3TUZLMUcwZTNaZ3VTaG05ZmhScThVQ0pwckxkNWJVZDBQRmdldDJj?=
 =?utf-8?B?cmt5elBRbVN2cTFWR3FRSzlTc3htTUtrYVl4cC9pVGEwSGo3a0tlSFVHdHds?=
 =?utf-8?B?Q0RkK3hwangzeXpxM0pqRjJrR0ZUUEc1N05zdW1laDA3UDBuSERTc1lxU1Zx?=
 =?utf-8?B?NE1TM0tKSnVyRDYrY2F5UEpjNm1rVGhlV0JQSGhxRlM2b2Y1Z3RsNUsxOTh5?=
 =?utf-8?B?bUNCNGY2THdNclQzblA1eE9QcW8zTFM1Z01BNnpxWnhnamZzWTZNTkQ2QkU1?=
 =?utf-8?B?blc3eFZFUGtUOXplSHc1V2tHK1k5NmsvR29PZjBaaUhjejhuT0NFRnFRMlk3?=
 =?utf-8?B?MVJhem1jRG5KQ3Y2QUVWanhocW1LNlZ5Z28rZVpvNnhJMElRN2pNL2xQOHhS?=
 =?utf-8?B?RFZyY1NBdGRqM3NIcEttU1ZjSVpmcUpJeXZEcFVoNGMrSDRoMzNSOW0yalBI?=
 =?utf-8?B?bXI1OHdmaGRzOG9HNDNaSHVLa2FWY09sTnR3SDNjYkF3WkpiTmlmdjg0cXRM?=
 =?utf-8?B?ZzdSTXFKY3Q1K3ZPVXJrMHVwUXRWSkYyaFJCK2Uzc3BDVjFuY1NwVkx2ZXJP?=
 =?utf-8?B?WHlMOTJWY3lGZG1JMndMczArMnJwUDRWWmp5cXpia2NQN3ZQZnlCck50VXpC?=
 =?utf-8?B?TGxkMEZHSmNPSlBKSjFyWGNhZEFGWnlUNCtRdnA2dWNqamIwdEJXOEpVRnZW?=
 =?utf-8?B?a1ZyM1J2dXRRVHBJTDhRTXpZR2JBYmRGb0ZkQk5hV25BMmtVQzU1elUxWnFn?=
 =?utf-8?B?TDZma1p1aXY2emtyS2NaQWlLV1ZJRlRrVmhJR0ZweExUdjg4VVVxdWxiSUxn?=
 =?utf-8?B?UDFTbmF0ZFVDT3NaOUFqMDZFSlBYVHhSOWlnMFNLSEQ5bnB2VEhOZnpoVmFk?=
 =?utf-8?B?czMycXlveHdrRURUWW9YUUVuUS9jaHZad0RXUGhONEZzeng5d2Q1cG9LNHRh?=
 =?utf-8?B?SWhvT29ZMHpISWNpV1VoZHl5c2NpelRITHlhYU1zdU9Za3Y3UFJkWW1rSUNK?=
 =?utf-8?B?ajNPMXlUeldmWDBwb1Y0eEhFYTRGOEs5TlVFZXZhTHJ6THJSaVVjWUozbXZJ?=
 =?utf-8?B?dzhyVzVXZXllZW1zOEdWYTFjZHpwMmZuZzBJUElUK21oSWxCRXZhb1ZRMnlS?=
 =?utf-8?B?cGE2WDBjRWFySHczcno4VzdCU2R4MGRycWszR0ZiV3VsWElLOERROUt4TnNw?=
 =?utf-8?B?Uzc5VWVYQjkvMmJwTGZFUkVFV1Y1MUhJSkM3bFhuUi8reEM3WVFYbGlKRWtG?=
 =?utf-8?B?RFRENlFmdGNFQ3Q2YnNRcG81WFM0SXorSFl6SXM0K1pYZnRMaTF2NW1GbFRR?=
 =?utf-8?B?ODhKUlpJNXVWTGgwWXNvNVZWQzd1dG5zeHJ0eUNqRWt3OHFTWWd6WWVWOGRa?=
 =?utf-8?B?RFNkQ2YzZFRQWVlpT2N2ay9Zc1MzdkFtYzJyaGtORnNDcHdKV3hlWjJlMEU1?=
 =?utf-8?B?RkpIK1dBL3NZUDU4WXpldHZYVWVsV1NOTGhJRXlZWkxhRllzb0ZGcXh0UG81?=
 =?utf-8?B?eGExSWRsU00xcWkzM2ZrVGVCMjRSNFBhWjFvMmVQMlJIRVZNSzJkdzFWRk40?=
 =?utf-8?B?VGMyUVEwNWg1ckhMU09VVDd6d2t6dTVoZ3VxQnFlZStmaFdPUEgxRkpUMWph?=
 =?utf-8?B?THFTUmIrYkU5NkZrQjZRN0RNL0ZrUFlQcEZmQ2RYU2RLTkFSTjA3WjQ1eEFY?=
 =?utf-8?B?YytiMTdCd3FZdEdQWGRaUGpLZ0FSMWl2eVdqUi9yMW9JaFBhYXVTVWpjaGRE?=
 =?utf-8?Q?54DpUttuk2Yg4PjWYaNN1xtk/p3D7hKE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlNSG55NnphcnhqTUNKNUkvckxWNEJwV3hQRDg2M1l1M1FnUUNlNnVUUUsr?=
 =?utf-8?B?VGdTN29PUkRkK0lpOUpoRXZWRlNLNTQ5UlNNN2RGTEsza2o1bkNuOXFaRnJG?=
 =?utf-8?B?MTVqalZaWWEwNlFwa0UxMmVGS2lES1dhRE05WWkxVFo1VnhuZTY3YlFHN3NE?=
 =?utf-8?B?RjBoc052VkZSTEsyOUZJemVWZzlpOGIvczZ5T3hRMWNYdzJ1QXN2RXIxWjhw?=
 =?utf-8?B?bXgwRmtUNWhHMzZqdDF4NXYxU2xlVm84RkdNZVhBQTJnbHpmR0t5K0E0MERi?=
 =?utf-8?B?cnp3UXlXaER3WUFGZ2pLa0JyaTIzMmxLN2dRaDAwcXplcHRJMWRZcHZrUm9p?=
 =?utf-8?B?TkNxbkV2RU9qdTY3THJEM1ZqaU9EZUxITGplcThJTE5vQ1l0aE5nekJyMG5z?=
 =?utf-8?B?bnVVekk1anJ5cm00bTRqT1B4VWM1YXducnNxd05SNWtpYzFaRDFrMWxWY0JK?=
 =?utf-8?B?TllWQ1l6eGNYMVl4Mk9ldmM5VmlnM1k1Wk5zY3RQK2NDNmZIN3l5NnZhdHV2?=
 =?utf-8?B?eU13NysvZXN6am5tLzY2d3BjVEZ4clpvODhGYWhvKzBLSnIwMm9yc01GSFFt?=
 =?utf-8?B?Mm1xNmd6RStGNk9iTUZOS3M1TW9yenZnVzVpQUxwc21kT1N1R25DWlc3YVpr?=
 =?utf-8?B?Q3VxUW1iSzQxS1dnRmtMNTNlUkdEL1g4Q0RQNWVDVjdIdGNFQU1qcEpkeXdI?=
 =?utf-8?B?UTlEVTdwRFlickpPdFRMcmF2bndsdjF1TGl5bTZDbUo4Szd2UDNacnFkZ3lR?=
 =?utf-8?B?M0hkb3BoUWRIWWRKWmhER3lHbjdkZmVvRU44eWYzQ2NUVHJaVHg4ZDhub1U5?=
 =?utf-8?B?bkRBU3N4NUxVU1dxY05VeDRhVU1qWVE3eU9JOGord1lXWUhKcGhhL1V6K0Fi?=
 =?utf-8?B?OW1tYlNXaDd4blAyWDBwMnJZZC9RT0ZOUUZvdzVBdGx0a2NldGpuK1Y4ZWJS?=
 =?utf-8?B?QXFoK2xKMExXQnJxdTRva0FkUUxSelpxaWhWS0JvUmRYdEhUR2ttdHcyd1Fo?=
 =?utf-8?B?NzlOMWJWVXN5bkg0bklobEx0L1RUeWgrZTN3SmFIanIvOWJnKzRTdjJKaEdO?=
 =?utf-8?B?Q2cwaXN0M0ZrU1ljckRrZU40Zm44Zk5iZnJpMVlDN3RQSjIrZjE4a2dpT2M0?=
 =?utf-8?B?VUE5UmNaNGZqa25DdXp1QzQ1S2dqR29aRURTU3ViOE8yTDJ0NEdEUnFUc2JS?=
 =?utf-8?B?WWRrK2l5MHRlc1RmYzNJbVJhc1UzNkRrazRoZlF4dUN1RDBnM00vdWlYVXFh?=
 =?utf-8?B?VlJhcWFBSHVnWU9OOXhTNFdhN3JmM1RmeUZIbWxxYWNONzE0a0xsY1ZWeUIw?=
 =?utf-8?B?QmpnamFiRzhzbEcwdmJUOHlrZ1EyKy82STNtTWt3TUhVUXdrajJkNWZlSk40?=
 =?utf-8?B?MzhSeDRGU2h0T0FRVW9xRkxtVjRoK1B5cnlHVVlDc3k4M0krSHdGdHJGbFZn?=
 =?utf-8?B?MmdIeWY2dTVzemc5N3pLUUtLVUlRYkpFempYNDV6aGdQTmsxVy9iQ1p3RGJ4?=
 =?utf-8?B?RTIxTlZvT010TnNNZXRkZWpCallGU3NxS0diaU14djNqNStTNGFLQnFUa3NX?=
 =?utf-8?B?VmlKRWE4Q1NkSFpBYktTbE9Ma2xXZk1zTURUaDc2OThhOG01VFlLMjJQMXU5?=
 =?utf-8?B?aEd1TUZhWDArWTVFeHVrQVdlTWJoVU51M3ljYjQ3eUhpcGNTcGVKazRDNFlC?=
 =?utf-8?B?VkRIdTN1SnFNbk9pa3RSRjg1T2dBZVY0RFpvcW1yM1hrKy95cXhGVFU2eGJl?=
 =?utf-8?B?SkVhNTRPTVhwS25POExLb29kamN0WmVRa0svM1Q0OEJFMjV2dVJmcXZJMVdY?=
 =?utf-8?B?Yzd6SlZrbWFSUWd2K1RrdGpqY0pya2luZUtmZG5ZbWd1cTRveW9LQXBQUU02?=
 =?utf-8?B?N0hCMmVzRzRMQktHVjBNTVlESUd2Y2c5S1pBRHBpVXVTanlXOC80cnVIcXJo?=
 =?utf-8?B?MVRKZmtJVnczdlRSSkRYSlN3WGlKWXpoRjBlWkUrc0EwT3hHU0RGcTFPNkZu?=
 =?utf-8?B?NEJYSHg4Vmx6U2lzcjRuQ01qb2xqSXFpRXhlQ1J4Um1tQUY5TUdyK1RjMWVC?=
 =?utf-8?B?UFBrM1hPcVJZUFhIODdSY3VGT25WU3hJUmFHNGJieW41ZGZGU1RpZTlkbnZ2?=
 =?utf-8?B?cVc1QUtoREt2ZFY1YjBXM00wdDR1ZG1YMlBhcHVNWVlpNHJoUXdCVUs3d1hl?=
 =?utf-8?Q?+xD5MNXD1l8loi+V9AH/AAc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b84c06-1cba-4b15-1989-08de2c1bf974
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 12:12:59.5277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkrQYzKx3EX+mx+3Z8D9f4jT7RTUC8SJhH3oU8s2E61m4QuP150Ul2SsZGpS13/Maoi4BdmNrAdlUQiHpfVE18Z2+sTyeUcqqoLc+LqZuWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6894
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

Hi Brian,

On 11/25/25 12:44 PM, Sune Brian wrote:
>> That's a bandage fix. It would be better to have some idea of what's
>> going on. If this is possible, bisecting between a known working and
>> broken commits would hopefully return the culprit and we can start
>> making educated guesses from there. I also see no defconfig in upstream
>> with TARGET_SOCFPGA_GEN5
> 
> 
> I have found the actual issue now might be wrong.
> 
> default:
> 
> #
> # Start-up hooks
> #
> # CONFIG_CYCLIC is not set
> 
> Normal:
> 
> CONFIG_CYCLIC=y
> CONFIG_SPL_CYCLIC=y
> CONFIG_CYCLIC_MAX_CPU_TIME_US=5000
> 

AH! In the default defconfig (can you please copy it in the mail?), can 
you tell us which WDT and WATCHDOG and CYCLIC symbols are enabled? It is 
possible there's a way to enable watchdog without cyclic (but that won't 
work as far as I could tell), and we should fix that in Kconfig so it 
cannot happen.

> I guess defcondig files are not sync to the latest SPL design?
> 

Which defconfig files are you talking about? Where can I find them?

Cheers,
Quentin
