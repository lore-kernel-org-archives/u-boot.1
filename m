Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B68CC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86EA286562;
	Thu, 24 Aug 2023 10:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KmSNWCT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126EC86554; Thu, 24 Aug 2023 10:00:05 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C70286562
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBRtdeCbXc7nTzn1UwNwHERpdxfCw+AMn7VTPgHjmyJWlQn5IIwe2w0NJVVKtAPERejEm96q5B2wgjoc9p2y9gv6RHfJ3pSUDgoWh1n4lcynYb2tSa1vWN+qXID6nSqJvfFCJY9z72YD2JEXAmRFaT88uv+gG8KESPfsjv8Ioc0DJ+Y/eEMJtoCVtf7WOnx/4DmJn81IDVfzR1yncbAQIuKuGmWPaKGMM4c2yDiRWQazKFFx6b2Fw9ogpWzgRLmxCQa3XxkkZFRQyfP4MtdNXY+2iZSMzetQrJgWsEd9AKg2hLWWo57G3cfpdNW502pHxx64CLsDkEyVwyKikbYoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/GWP1sIDT4nufX7RQ5YX5j6M2ERDY6pCAiQcyJmVdY=;
 b=UuPfP4E+/05PgFKzygZn18pIG/FkGfob7jC5IprJITBupEpRjwlhCExjMR/nBNMdwYrkZ/JpwjeKW0AKj28MOvoGq/kIY+feR7zu2hiC1IR//8nO0d/jO16vH1KqcvJDUthLLUnyEXudqzzcMvZQ7JNYUjk++tz1OkOFgCE1hSZtgp3G3h8a56T4LYzq/LOLQQrlPMlpyNSCik3q2s0gg/uGbcfk/k3n3P86hXoodvxtHaip9GSK02KUmeAkVCL2Mb3NhnaAEPRgiAFcRZwdtMnWJcQp0LDeuf9yWLjKVxbgfrhYwjgi8V4smUChuii1IZylMw4CYlHz33zIGunvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/GWP1sIDT4nufX7RQ5YX5j6M2ERDY6pCAiQcyJmVdY=;
 b=KmSNWCT7bhSj0Kn6l1+A3eKql3jJMFm7SX3xRu+4D3POb/PeZ3v6D+/BkJ2/tmxpltVeB4mu7s5U58Te3pS5BzQdMMcNay1FBpUCd1xunZySozJ4jDQllfmV4Mre3UIrEP/Z8XbT+RRGTmrT3pswPZ+W8VqOH5JAUbdUzZW58DA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9569.eurprd04.prod.outlook.com (2603:10a6:102:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 07:59:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 07:59:58 +0000
Message-ID: <9a66ec0d-f87a-ca68-ad1b-e18d4c766d30@oss.nxp.com>
Date: Thu, 24 Aug 2023 15:58:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] doc: csf_examples: csf.sh: Remove unneeded export
 ATF_LOAD_ADDR line
To: Fabio Estevam <festevam@gmail.com>, "sbabic@denx.de" <sbabic@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Fabio Estevam <festevam@denx.de>
References: <20230815134801.780735-1-festevam@gmail.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230815134801.780735-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc32c52-e3b1-4130-9df7-08dba4781c0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2duPepv4efKegZIm5C3N8HRyCHFjFCzRyhV8c/XNuFugGszf44jnC2HWKX9nCLNbhBYajZYA2TY3cZhtRWIZ1AFvKreJ/H9y3kNZeW/BaQhEsgOPZMgi57Be/Afx8XRzBJ+KFoQfTOLCXgT85/ATd/xmGyk9ok81pMWW0HUp4xjodlG72QjfRSeEATCPCClg6/CPqOjfH1tmJTlqbzrOJJYTxWlSCrKzvHQuIkdf/C26vzigDnfvPFXmNsbJYX0E8OedME2fVEn/4/lKdSOJjvDMCE4NCSwg90nN5Lzncx4Pe/ykoc4GAiwJ0I+QRurUxuR6BCchU/9HhOTkIfHzjt2hgPdacM2UyPVVHRoGl1h/VI3R1WLIEz0Sau5iZJkvgeVwBAUyFxjH3yaraybO6UXCMilyXz8XxHaklUKUljm6VIKEWKB471X0HmohWjysLve1e6um5cpZBpnvOgpjJgNUYFwDHw8sCFEPLlwdKNhUplLBMY4KDEyZvh5u9HkorMcEnXKVDdCZTHOacWnpslHvQB4EKgJAfsoKCsnvP/D5U+v735yLUCqVcMyufk5phWTUcRq0b4JfIFkFuRDe+r6AYT2+CG26LiZJqrxSNIhSpqCrvIEsRkIGOFgoaIbFsDZe12c4tt5id8xZJeGjKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(54906003)(66946007)(66476007)(66556008)(316002)(478600001)(110136005)(26005)(44832011)(38100700002)(6666004)(41300700001)(53546011)(86362001)(6486002)(31696002)(6506007)(2906002)(6512007)(31686004)(4326008)(8676002)(8936002)(2616005)(5660300002)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djFDbEhlMlhxQnNDQkJGeWJhdHhqb3N6c29rWkdjTFZXeE02ZTFKWllqVU1s?=
 =?utf-8?B?dEtncW90RWs5ZWdESzdhMHhtbUtUZURCMTlreHQrM3pvdDNIWnVzZ3o5UFZj?=
 =?utf-8?B?REVYdFppVFpwS2hNc3ZOUHhWMEkxc3FFOVQrT3RxZUJxNzFJUDNZcGx1Nml3?=
 =?utf-8?B?cVpaSzFzUEx6amlmbjIyQ3hxa0RkUm9hVDBVTlVmOXBPa1ZtYnVsTVJPR1RV?=
 =?utf-8?B?eTczT2V5NTQzcmxIK093ajhKWGwwYnBJWklTVThJZ243Y1N0SGJNdXFOMEYr?=
 =?utf-8?B?enl0YW5xcERoUGhLaE5rZ2xlWWNYenRwNWsrZ2tSVE8vcERKeERUL083bVBj?=
 =?utf-8?B?ZCtvWnlicVdXdjZnRTVveFJINE5pWFNuNEZESDJlRjZkOVQ5dng5SHdDcTdG?=
 =?utf-8?B?UFZLMkNEcVNBUWltMFZIMXdkNFB6bnFSS3YrTjJ0U0R6RmpEdkh6ZzZUZnNt?=
 =?utf-8?B?WGJTNFVUWXZQZzg0UnZQSXBzdXJNcUVQK1RuUDZpWFBRTWhEa09QeVI4QnVa?=
 =?utf-8?B?TzNFSG8xNTE0MmxRUlIybmRsd1ZhMnEwN1Z3MnpxNE1OWGp0NlFXcGk3bHVH?=
 =?utf-8?B?Q2NsWWVRUjQ0N1ZJbjkwYXdzeVdsaGN2TGl1Zi9xMFBBVDRScGNGamIyNFFS?=
 =?utf-8?B?TDNwODUySUdQa1A4ZnRIQW1RbnZ0bU0vV09tN3RObXJlSHFDN2Q5T2FXa0o4?=
 =?utf-8?B?N1RnS1ZUUUwxQTg0bU00SDFaT011WTBkY2tGZ1h1WlNIWTBOcE5BellKdDdH?=
 =?utf-8?B?Vk1lQzlQaVRQSDQ1S3NzQWdNOWUxUHNON293U3NFcWh5b3Q0S3dXVS9idFJa?=
 =?utf-8?B?NnZxRHI1WEYyYUs1RUhlZEE3UjdYdkdQRUYySWlUZFlabCtJVEczQUJjS1cw?=
 =?utf-8?B?Mmo5TTVhVCtxNDh0eTZXK0dLcHpNNDJKUlozNWNOcklFcDRjZ1g5dXZBUU04?=
 =?utf-8?B?MWRnOVJIZzFyNUhJYitrcGlXTngyb2haanNGM1UrZVpHZXBDK1ZMc0hQRDZH?=
 =?utf-8?B?dlhicUhOSjhOL0ZtZHBldW9VclFBeDByNVJJTDFoYjdQei9yNzVMMlZhdmVF?=
 =?utf-8?B?T00wVFBIL25FejdaZlh0cVk3MUtLUHR4d016VnVCK0cyMTNTSUd3bUFjdStw?=
 =?utf-8?B?K29lNE5XQXdYMFQySWp1eFFPTk9BTGJDQ0oxYWNTZnZFaWt2N0hoVUFURWJY?=
 =?utf-8?B?ZzVBWTk0a1EzMkEyV2RPdzRWMDUvb2xweU91djluT2NDTFQ5R1UzakxNK0Qy?=
 =?utf-8?B?M3B4WUJSM3VSakVmc1ZaZ2I5bXdUM3R4VkR6N0hWMHB4V2hkbzRTVlVuejNP?=
 =?utf-8?B?LzE4K1NJam1LOFB6NzZDaE16aXJqbWVyV1RFS2llZFNJTzk1UU9DSFVidmt1?=
 =?utf-8?B?Q0JNVU1kSi9pZzBoc285SGJTdlp2R1prQzNBU21TUFA0L01ldW05d3Z6QWpt?=
 =?utf-8?B?eC9pMkdYWUM4R1ZlaHVybjN6WFFnWDZZWnB2TkhSU1U1Z3JaY3lidjBTSk1H?=
 =?utf-8?B?RG9memtDV0RaYngyNExsRDkwamcxZ1NGbEVYRXdCZzZqdi9MbzdpTy8rOTFS?=
 =?utf-8?B?dFVUblRGY29Mdmo5ZndRYjRBbGMwaFc5ZVd6c0NpVHFjQzFTcloweE5OazFo?=
 =?utf-8?B?OFh5MktXa2hOSTA0eTZ0aWRUQmJUV0xHSnVaVHVka0RDUmM3SXZmM1VNK2I3?=
 =?utf-8?B?eFRTYXFCOU5rV1pFYTByL0xYWk1oTUJ2T09QZWFmYXJESG90aSs4dzFOS3JM?=
 =?utf-8?B?K1hIa0FCK1kxZ3owaDBWVVpJY1NOR2Fjc2xJMVEvNk15aTRBandMNmROc3JV?=
 =?utf-8?B?bGU3QWJSQnFLTi9hOHFyN0t4ZWxuNDVjNjlvREtFN3FiSTlyMmhzNk1RWHM4?=
 =?utf-8?B?T0YrWmhIblo3Z0hVa0dPdUQvZnpkR3RTdU9qTS9yOXJQM1ZMVHd1dGQrazlh?=
 =?utf-8?B?QTFEdGxyWDN4UDl4dUxZU1o1R0RHZy91QjNselRNelViNkVCallGUzBpMFFZ?=
 =?utf-8?B?Wko0U3VBelNJNTZWbzZjT2RnNFlvZW91Ymp5eWM2KytEaWlRazZWNUJYSUtK?=
 =?utf-8?B?UEJ0R0hDU005ZEZqcmwzNkxSelJ4M0NiK3NZb2NtcC9CMzNpVXVzdVFIbXU0?=
 =?utf-8?Q?p1hi/drowsnFyCwiQWbBMEdid?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc32c52-e3b1-4130-9df7-08dba4781c0c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 07:59:58.1326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4ygbPTVrx0z0OKXRH4YnqQHzzzOfgAobFtqaqt9bJ0dD+XuQ4Lo9wXNCxiiHuLM08fFzbVSYYaTSNI6OYYfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9569
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



On 8/15/2023 9:48 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Originally, exporting the ATF_LOAD_ADDR was required, but since binman has
> been used to generate the flash.bin, it is no longer needed to do
> such manual export.
>      
> The ATF address is now passed via binman.
> 
> Remove the unneeded export ATF_LOAD_ADDR line.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Peng Fan <peng.fan@nxp.com>
