Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD56C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 08:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D591A81F7B;
	Mon,  5 May 2025 10:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OVgtgktm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC5381F7E; Mon,  5 May 2025 10:34:40 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927EC80BAE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 10:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akmUWFoIZK0TSTjxjqzVZb3cjm9n7D9SEhXOML3pPjkgwIxPczLR1oOY9XJFymj2PSYQjo3NqN/nOnWWQaKYzBNEudS8O5R/mKK/zYlJsZpS5xOXK9682Caz7fjXu4h+eb56i7qCz84ldSoUpDarTFgCp/PUbTBxQvfi67IUgXo6jUDXCiPi/H5QYZuKV/LoETEMFsXNkbNLaVukyRF0dQCz4gC05AvhzEN1xta1Rc74WbagaofM8q4k6rbD2CiQc7M8c9slwhHI/7z2L8/oJLsWBOb/5V9UiPOr2FPUII54lAbCGKeylVHW/VyFIxkr0w4KkYNoIYX713f98FxxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn/CNFfv6PIYNELB3qYEUAgq/bHZ4ucHvW2qoCJ4v2A=;
 b=Dp6grGq0UsPthxI+/JV2V9lMSnsm+LkNzTNarD1/lxnoQAg7rf8fZFCZlUcgQ3G6ythmVL82md6fZo4zUtGuQirMRUeWRUZwPg7AHtj+0KE9RJLkMqrjW+Z9UD1DOL7XFBTtGLCwkYnaBt3RpIZn7t6GLTUg9gIoQalMuKn5sIQvJLRJubS161QSUiDTe9jebE8QsOpfydUnU/vpm+MaE1v/TheS6hcNfKXO4xzb+Gi5VL2h1ZWTT0Q4qmxdtn6B0gULN9rsN2kDNGPvuv+Xc8MrikMgy+Y1+pBlcvwlEWZV4KAXEYkD//4LHih71KzAkhb9T5hGfMKOVf1hHZxJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn/CNFfv6PIYNELB3qYEUAgq/bHZ4ucHvW2qoCJ4v2A=;
 b=OVgtgktmfYpcTz8w35xpjbi7mz0sP5DInE3fFLWd3GOVpp+E/e4EhX9gMayXO7QlBwlDMoc/y6LveXmWJrcLsk1O9iE5EGI06/uz5aIUzJXYYaLYhIzKGFGEs1WZCTwxtaVbZrPMfaELdGjeKnhI920vSynJpqmpbc96BZ6swe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10337.eurprd04.prod.outlook.com (2603:10a6:10:562::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 08:34:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 08:34:36 +0000
Message-ID: <5403d72f-65b3-47f8-912e-d1b64e111f00@cherry.de>
Date: Mon, 5 May 2025 10:34:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] bootstd: Provide a command to select the bootdev
 order
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-16-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250501133726.2627373-16-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 13153358-e6ab-4582-9ba1-08dd8bafaad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTBFRFRkZnBZZW1UeXB4WjZqTThEdDVqQ2JMaC9FOUJSdkcyVUJGYWVseHRS?=
 =?utf-8?B?Uk5mbnVOa1BtSk1peVpCYjloUDNmS3pvbjI0eUZQK25ib2dCQ1hwaDE1bXk2?=
 =?utf-8?B?Q2V0SER0ZjA0KzhQNGRRUnl1M054Sk5VTi9rN1pnTStGSllQTExHcFpweC80?=
 =?utf-8?B?R2FVQk5KRXpTeFliOWx3RnFpRkN5cXdNN241UitEMitERUJXaWVzNVVBWnA1?=
 =?utf-8?B?OTkyYTNzUUMrNUI1TVdjQnBUWEc5Z1l3NUJTeFdnZlQ1czVDeTd0OHIrVFY4?=
 =?utf-8?B?K3VncVE5SUR0OS9VNU1kbjI2UkkySnh0QWp2TDdHZzNQSkFxNE8xbmpraFpQ?=
 =?utf-8?B?K0VTTEM2VTZkQU56UmdUTzZNWjBvRTkyVS9GT253OXdSNzhFaHhJT3BvTFJ4?=
 =?utf-8?B?bzBRRVg1aFA0Vm43Vnh3cFAyeWNCVjVpOUhRWndYdjRENEZ4RTl2dWZSTnEv?=
 =?utf-8?B?alVBRmRvQ21OY3ZWNklBWGVMQ0liVlM1MlpEVTkzc0hXdnNtTnBlWUVlTXdE?=
 =?utf-8?B?WXpPTDVrVjRCeks2Zk8rMnA0WDlrdDdUTmpRMEFVaENuRkx4bm0yTGd5Wk81?=
 =?utf-8?B?bGk2ckRpYkZuRlNQN3JEak5uZXJwU1ZZQnZ5T0gwLzd4NzExbVhoUWtZY2lW?=
 =?utf-8?B?NFM4QUlyME9ROUh3ekdxOGRucWZoNTNpbGMrMGJ5U1lxTEhkSUpqRmZGdlp3?=
 =?utf-8?B?NDhwdG1sMER1RUNFZTVBS3VGNXJFd2hBTzdKTnNZKzUzTURQYUpNTDlXKzVi?=
 =?utf-8?B?eFZBSlh5MDJHWWcyZ3cxc1Eyc2FJN1dIeHExbUdYNDJwMWVrUXdxKytoM1li?=
 =?utf-8?B?LzV5RllIaWduSmRUdmYwcjkwZkI1b2NsQzlQRFdWdHZtZmRqVGxvZ3hZV1lH?=
 =?utf-8?B?RGJqOW81aXUxc3QwRTAySElCOW43QmJhNXREQ3Z2aDErUk1ta0JyWmZiWnMw?=
 =?utf-8?B?Z0ptRzFyNGpkTHNRMkozZysxYUtRblhKZ1hyOFBQVkZmVjd0Rlg0amlwbDU5?=
 =?utf-8?B?ZlRwQVZiN1VVUWdWRGg1VUtxR3BySXhxUXVyb29Ob29KVnUvYjJGc3h3WGRa?=
 =?utf-8?B?UU80d01YWnlzdU1LZ09SU1FpTWlsbG41U1FKWGpvNzJMMStlaVRhbnpnUXVo?=
 =?utf-8?B?bVRGc1NaV0xqV20wZk5NZHRyR3ZLWkdjT010MExReEhZWGRLT0g0R0tYTnV4?=
 =?utf-8?B?OGhiWE5LOHE5dkFDNFNjUTRqRVozL0RLd25XWUFxVFRmd0kwVWx0SEsrOTBh?=
 =?utf-8?B?d1k0Vk9iamVBVTQ1Zkc1b1ZaUVlqbHlSQ2ZhQWhabXdOK3dzeE56SERLQXFq?=
 =?utf-8?B?L2pnb1pZSS9sRW5OVG9vZnR0VTBtSm0vWE0wRjlHaGpVdW1PMW93LzY5dUN5?=
 =?utf-8?B?cUVOb0lEcERRRFhzT1VDUnB2SmY1Z1BFSTZnL01MSUhXNnQxcm96Mm0raXVK?=
 =?utf-8?B?QUdNNXlTQk83dUl5QzNrczVmRUcxcUl0UGRNNmVmY2JoNWQzNjRybDNsL3RQ?=
 =?utf-8?B?aU96czBuSkxwYW1EU1J3dytHWFdOejF4QU5Ia0Y4dzJheVJENE51UUFTYU9I?=
 =?utf-8?B?OU94YnVWVTExM1VmRDAwV3kxNDM2aE1xWm5nNXdDWm5vbngzUWNQODUvWHFm?=
 =?utf-8?B?UzgydTdhK2ErcHIwSFNXSTFqVURlOGxXSDNndS9aRElBZEpWV1g2c040TW4r?=
 =?utf-8?B?d1ZsQmtUKzErZnlEZmx6L3gzaU5PNmJON0kyb29GTWM1VCtQa2lldjVndE4z?=
 =?utf-8?B?UGdDdlI3ZHpkL1pmTzhUWk5ZM3d5SDlyY3ZNVVZvZm5lOExHTjh0ZmN3UlIw?=
 =?utf-8?B?amMzVlRyeXh0bWcyZVI4ekt0K0wzaTkwcityVUdVenYrRGxiQVA5ZStGNzBT?=
 =?utf-8?B?UWprTXpGTmRtcU1LT1M3Yk05M2lBYVA5R3NKVkVqdkdXSmFHTHdPTDNmWDBs?=
 =?utf-8?Q?DaY0/YhD+oQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZlc3owQUNrL29uWXV2a0tUdlJUYkQ1ZXcrc0dKTElEK3pvQ1hoelN6ZWEy?=
 =?utf-8?B?M2c0Q1ZCdDZQSzFCTG5KZnYrTVRBZHFWMnZIcUFKa1V2L1RXK2ErcXhlQjF0?=
 =?utf-8?B?ejJiWGxQM2VmS1lOTkpIUHI3aGRyU0tIY3E3RVdlaVczcDh1Mm9vUEY2Q2xB?=
 =?utf-8?B?YWxwY3R6bjltZk1JQVpwTG5yQkhnNkZhbERvSlFhZE8waktYVGhIT2hWQ3Jh?=
 =?utf-8?B?MndFMHNXeEJUT3psZ0tvVE5HNEdwWGUwb29RK3Z5V1htT3ZCRmh0TldJNGZP?=
 =?utf-8?B?NUk0dFdKVFhUM1R2L0NEUjFFTnpLeHRMM1pob1hLYWpTVm1sTkZuL0dDSFFn?=
 =?utf-8?B?WmVVRXQ2UkQwS0hzVUppdGYyb3dudlJ1SnhNcHV3QTRlTGt4V3hIZjlhSE94?=
 =?utf-8?B?dzJlMFRSeExjeXdUSXd3SzNkRVByYUtEYytndkJsUkpFTzNjQ3JETFRXaWlQ?=
 =?utf-8?B?bXBNemREbmNTendzd1UzMm0zY24zTTlXZzQ0WUc4eW9mcnFHd3Y5R2kxWWto?=
 =?utf-8?B?TDd2T2YwNnhtZVVCcmEyS2gyclVnYjVVaXA1T2owTTJsaG1jSlQzN2FSN1V0?=
 =?utf-8?B?Sitrb1JWUUg2LzNTOGZ5OU02RzZsdTFiZDM2SmpRWmt3YnBHekNoYWdWSndo?=
 =?utf-8?B?aUZJRlRDQjZrRnRlc0t3L1FQMTZoQkRqVE1MQ1IzK0M3VlZpbGQxRzQ1SVRE?=
 =?utf-8?B?RGlYOWdkVlFJYlBsM3Jmdm0zTElrTkpjYVlPMVplTkp1bmlkSkNqZXJUWURj?=
 =?utf-8?B?SjhZdEsrY3V5Sk9oczJObVlCQURQMTlLYXF3ODVJVWxyRGNsZmFPL05GbXFn?=
 =?utf-8?B?eXdmRzRQd1NLdjJKbkdQUStyckhNdDEyQmJFSGc1aC96VC9MSHBxamxCaFNs?=
 =?utf-8?B?SFdvM0JIcG53OStGeDFTOXRlZkJsMTJoNUcxeE0rOVE3c3ZkQk93aExNNFVP?=
 =?utf-8?B?QXJKREU0NGdwVHR2V015TzBXdUdjbVUzbWQwdFByTGl5aFZEZFhRVWgzZzhS?=
 =?utf-8?B?V2tmUGc1SHZOS1JzUUxzV3A1Z2E2ZW5UWFJPOUVQb3lWWENrc0Y5cU52UFZt?=
 =?utf-8?B?MjdQTVcvT0VicXFRa3M4SUYyZ3JlZUE5bHd4Q3VqR3UrUkNMOFhtUFNzK0h2?=
 =?utf-8?B?b056dzNyZEhpTUlwK2dHc25tcjBnYW4yVUNobkVrSEZTRFNQK1lwNUJUNWdr?=
 =?utf-8?B?VGdFZzluWUN0QSt4TmpqYUdWa0tNa0FRanE3WWI1emVUSDJlSG5TSExnNFZL?=
 =?utf-8?B?d08vSTZGUTViNms1SWhFSHJqa3h6QlppWHp1SnI3cCsrb05WcGw3eU41YlB5?=
 =?utf-8?B?dE9nK3k2TklLdy8yNDNncHRUU1lQL3loQWpvbVp6blRFUlg3cE9TamNtQ01n?=
 =?utf-8?B?WUVyeHQwdURQNnRENnpXME1rUWU3YTdsaWhlanhMOTBUSFhrU1lBUUpDQVli?=
 =?utf-8?B?M1BRbXAxYW9YNElwRCtxbUExK0VRVGU2S3FsTlhwNXplQmlycEgzTGVqR2Mw?=
 =?utf-8?B?KzJtRFdndUtSaUtKT2MrVkJvWWR4QUtnTHBMSjVSZlpTbHlRaGJiVHRwNTRa?=
 =?utf-8?B?ampSR3hZcGZaM3c3NWk4QU0zenYzL0VYYUlDc2dUNWlGU3JKQXVLeWdDck1Y?=
 =?utf-8?B?ZVZ4c2hOZUEyRXhGblQyWU5jRDNIbit5QjNVdlZpSEc4Z0RVQ0dUeUVKL0lW?=
 =?utf-8?B?OSt1VXAwL1F2aHU5a2szKzhUNnd1NGszUkxrN2UxTU1jZEZidVBHbDFMRmFL?=
 =?utf-8?B?WlR5eFYwVll3T2JqVXc2K3hLN0cyTzJ3cVduK2N0dCtLUXByVmtFbUttbERk?=
 =?utf-8?B?dU1PdHRZdXdrNWJQTmNGODlhSUFZZm9ZQ0FHN1FmOXdaVEFpbGpXUGxGZTkr?=
 =?utf-8?B?bEVXM3FEQnFhZXFGV0QwRkt5Z3M1MVJJNlJQRXNxMmgzQ0Y2QndBWHdxalor?=
 =?utf-8?B?N2lxN2U1TW1YQTBJakZRZ1hqcU0zTnJsVmE2SUlxUTNXcXFQczJGRHFLMnVo?=
 =?utf-8?B?QmRqWlljV3lnYjZmOVVsTXJZMFRtU2d4QnpROTNLRGlpM3lVVzFLZ0hzajZT?=
 =?utf-8?B?djRKT09iTzVQUHE0Z1RTTVJZLzRhZnM5ajR1aG9GV01XQXNrR2U4cnQzWndL?=
 =?utf-8?B?VjNpK1JzSHIvQWtDWnpxYlJBdHFGVGV3dVR2QUNUWGZncktxc29BS05vMzJo?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 13153358-e6ab-4582-9ba1-08dd8bafaad9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 08:34:36.0696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/dxMqpaHPB99C+4hTDodw0JKq6zNZDx81mjWWPVMlitBM94WOIYz2zCx5ukD8FBEQSCsnFZ/KLX7OE7AprX9s+yOEpTVe75RCZMggJqQ2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10337
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

Hi Simon,

On 5/1/25 3:37 PM, Simon Glass wrote:
[...]
> diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> index 9bee73ead58..294865feb64 100644
> --- a/boot/bootstd-uclass.c
> +++ b/boot/bootstd-uclass.c
> @@ -6,6 +6,8 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
>   #include <alist.h>
>   #include <blk.h>
>   #include <bootdev.h>
> @@ -132,6 +134,22 @@ const char *const *const bootstd_get_bootdev_order(struct udevice *dev,
>   	return std->bootdev_order;
>   }
>   
> +void bootstd_set_bootdev_order(struct udevice *dev, const char **order_str)
> +{
> +	struct bootstd_priv *std = dev_get_priv(dev);
> +	const char **name;
> +
> +	free(std->bootdev_order);  /* leak; convert to use alist */
> +

leak? and aren't you using alist already?

[...]

> diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
> index 98a0f43c580..abede194cba 100644
> --- a/doc/usage/cmd/bootdev.rst
> +++ b/doc/usage/cmd/bootdev.rst
> @@ -13,6 +13,7 @@ Synopsis
>   
>       bootdev list [-p]        - list all available bootdevs (-p to probe)
>       bootdev hunt [-l|<spec>] - use hunt drivers to find bootdevs
> +    bootdev order [clear] | [<spec> ...]  - view or update bootdev order
>       bootdev select <bm>      - select a bootdev by name
>       bootdev info [-p]        - show information about a bootdev
>   
> @@ -78,6 +79,27 @@ To run hunters, specify the name of the hunter to run, e.g. "mmc". If no
>   name is provided, all hunters are run.
>   
>   
> +bootdev order
> +~~~~~~~~~~~~~
> +
> +This allows the bootdev order to be examined or set. With no argument the
> +current ordering is shown, one item per line.
> +
> +The argument can either be 'clear' or a space-separated list of labels. Each
> +label can be the name of a bootdev (e.g. "mmc1.bootdev"), a bootdev sequence
> +number ("3") or a media uclass ("mmc") with an optional sequence number (mmc2).
> +
> +Use `bootdev order clear` to clear any ordering and use the default.
> +
> +By default, the ordering is defined by the `boot_targets` environment variable
> +or, failing that, the bootstd node in the devicetree ("bootdev-order" property).
> +If no ordering is provided, then a default one is used.
> +

Not sure what's the benefit if we can simply set the environment variable?

FWIW, it's what we do in 
board/theobroma-systems/common/common.c:setup_boottargets()

One of the benefits I see is dumping the order if that variable isn't 
set (and also not in the DT), but shouldn't that be information we 
should be getting from `bootdev list` instead?

The point I'm trying to make is do we need yet another way to set the 
bootdev order? Printing the order would be welcomed I guess but that 
could be as simple as printing boot_targets environment variable, the DT 
property or whatever the default is if both are missing.

If we are to keep the clear command, I would use a flag instead of an 
argument to be consistent with the other bootdev commands, e.g. 
something like `bootdev order -c`.

> +Note that this command does not check that the ordering is valid. In fact the
> +meaning of the ordering depends on what the bootflow iterator discovers when it
> +is used. Invalid entries will result in no bootdevs being found for that entry,
> +so they are effectively skipped.
> +
>   bootdev select
>   ~~~~~~~~~~~~~~
>   
> @@ -171,6 +193,20 @@ This shows using one of the available hunters, then listing them::
>                   Capacity: 0.0 MB = 0.0 GB (1 x 512)
>       =>
>   
> +This shows viewing and changing the ordering::
> +
> +    => bootdev order
> +    mmc2
> +    mmc1
> +    => bootdev order 'mmc usb'
> +    => bootdev order
> +    mmc
> +    usb
> +    => bootdev order clear
> +    => bootdev order
> +    No ordering

Shouldn't we be provided with a default one?

Cheers,
Quentin
