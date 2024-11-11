Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8544ED12D7F
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1099089171;
	Mon, 11 Nov 2024 09:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ZpT/gOZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D8A892ED; Mon, 11 Nov 2024 09:03:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB598910A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmWicTrsCeG5ecaWEY4IU2NKVIiPbxeEBqKQOkD60zUx0JmG3hzdphhimCVLLNTnEACmO8FkHiGza6SHp1ZHuF4BmEe9/htoPUVRvWKuVyOtXzWnls3Ws2RnpwRWDfStapbMy6YsKF1cJ4XrkqYgFbSjLGDyqd241ysAwcZ5E9qdgh8ESy081cR6lQU2mLcS0bC89X20dX1VkfE21//TuMkgKapYtFGFZcUO+9ilC/tgAJkqu/ZX/AGQM+SLTogKfcR5EWts9wpX0g9FpJS9yHv/6B5BFoAK3gU5uhLq+mtpiCBiVO97FnWNNP05dUn0JKsNvXmUVj38BLg1ySxAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awwvtyQ0cvIZFWZjxDbkF3NNuqohuz8aCzET3s0lcUw=;
 b=eM4/aLGgj7g8DLIADG7mDSIC/an5xT1GPUP+7eFUtPTsc9CWAnQ6a5JK0ZBhBoCtU/b9m2K+NlP++NN1ZtFhNAjXX05EkA77r3itfdr8L7qUnfj6cxvGOXQ1PFnmx7IRFZmrpxR3uBNAWni2/BhbakCgr+ZMa2sPLkxfSM4ejf3Riy5/StnpIx3SwkNFVWQhzWb9e5tLkQLjlfBf0vr8iat3DsrNoiquWMDZssFrgeegt0fXVH23xvYclom8K3VKefOV0B9P7oECA5JBUqHSsP/p7tbj/PVNjZsIiVfW2UAf3uiy4g2nQ6q8gOh4xs1EmNfsFLevzn68OWQ9S9R+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awwvtyQ0cvIZFWZjxDbkF3NNuqohuz8aCzET3s0lcUw=;
 b=ZpT/gOZV6dHnMV0tuxmlZXp0jW3d4oX0mH7iLNPIwrJPBhyedJmD8XVVAMxRmi4T0KHZ5N0cKTaapSSU5pEjwDkafSaA8Fn0ZRUS9JQPVcqHG9NaRrn/7dzA+Xdg2Ou/pAq9BoitcWq1YfINncn5BXjPPsH7cs4QzKBApyudS3ZnFvG9gMwS6FU7WNu26so+1zUPkxWq3tIMprMChmMS24GJmzyTse2GLr+QiBvBHC/bvFNp6Ssmd2OlNjpBVNF9yBrMTsjB9e19tfg16vItjQ2tOrYVPBu1Gqo+rK4kctrJxATD6Us6FsSeVozCbqCNe3lDaqThnbbfwroP7z2ZaQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB7488.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Mon, 11 Nov
 2024 08:03:33 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 08:03:33 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "Schweizer, Walter" <walter.schweizer@siemens.com>,
 "bisson.gary@gmail.com" <bisson.gary@gmail.com>, "Leto, Enrico"
 <enrico.leto@siemens.com>
Subject: Re: [PATCH v1 03/22] tools: imx8image: Improve error message
Thread-Topic: [PATCH v1 03/22] tools: imx8image: Improve error message
Thread-Index: AQHbMZ4hUC7rqmPp50+BCDj4LP70VbKxvSiA
Date: Mon, 11 Nov 2024 08:03:33 +0000
Message-ID: <36ce8406810513373ea7143f8ef832e56d082a24.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-4-hs@denx.de>
In-Reply-To: <20241108052143.26874-4-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB7488:EE_
x-ms-office365-filtering-correlation-id: 0a13dc17-c34f-44f2-62cb-08dd02275671
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WUxqY0wxczVlVHBhTWJXT01ubE1yeklTYmpFQ25GbjkvMGRzVW0veHFzQ2ZN?=
 =?utf-8?B?UnVkY2JmaC9FckkyQXBvRmU3VWpkWHBmZ0l5ZzAzVDkrdXQ5MFBwYXBGVkRq?=
 =?utf-8?B?c2tKdFhKNEQrQnd3aVhhQ28wUDF0bTIvN0ExTmUrQXViamxIVzJwaVBRbXhP?=
 =?utf-8?B?d001c0QyYkJIbndJSHhCY0JaazJwa05zMnhya3I5S2xkbHc1b2FzN21sS05r?=
 =?utf-8?B?NWZFSDFkWUpYQ0p6czFDV1U2azJHWlJCUWJtMEZreTZqTVJGRWY0SU5oYmNF?=
 =?utf-8?B?NHdSak1kWXZBY1JxbGFmOHFtcjluZW8xTkQ5K0pNNWo3amlmc2tkc01RdU92?=
 =?utf-8?B?a3l4S0x0RlA3cGExbWpXZVh0Q05JWURZejU5SmkwYk9LM0lGR1pDRUE4cTBG?=
 =?utf-8?B?Q2xjWDlrTHIvRkNIaTJJNjc3a0pMaTFDZjVUSGZ5QTVtWngzUDlyVzdLT3JY?=
 =?utf-8?B?NG9QM3A1MVlHeFE1QTVRa0dWR3FVMTVQaE9idEdTbXU1Wi85bFVmZi9KTUwv?=
 =?utf-8?B?SFRreFhIZWNaQXRReXZmUUtjQXJhUmZHcUM0RXJlVzdmcXdxSGRFUXBwUzBS?=
 =?utf-8?B?M1U2dzRsejlncUNLbWhrelJMNHdYdzNQMnVYVFdqWnpDdGRiN000RnMxUEhM?=
 =?utf-8?B?NGorQWFkWWNUVGpkdG9FRTFsTHcwaUl3ZlJIakE4NUxSUVJHcDdBdmFiTnBZ?=
 =?utf-8?B?d3luKzRYVTREem9VQlBUNm1NUmFabkxrMzJGUmd6dTAzRjhyeWNRelkxZ2dz?=
 =?utf-8?B?d0lxdGUra2R0MlFSTG1EcFlQNEc0RVVWUWxjdTBhY2VjeWp1OHdjY2g1c3pY?=
 =?utf-8?B?bGJhQUV5ZmJiMHhNQ1VtQmhmTzBjT3N0TWpxVFRzdThIcDFjTVlqY1l5b2Mx?=
 =?utf-8?B?TzBPOG8xUGhTbS93Z0ZEZ2l0Z0M0d0dqYXBSbU1YU21qWUgraytmQUNkZm5s?=
 =?utf-8?B?bVNNZHNycVk3b1ptN0ZHYlRqYlZJMzBQQVR5VFhKcnAyN0p4MjFjNzhhYXk5?=
 =?utf-8?B?bGgxdkFyMmVEVWZxUnVraWFYVlZrV1pPYWk3ZWJPbFVnNHR3VzgwcEpqYk9a?=
 =?utf-8?B?UkprcVhFNTFxd1VBQUYzNDBQZWZ4S2NaYmtEYWZKc1RTZTJZK0tMMDhoZGhm?=
 =?utf-8?B?YzBoSW42TVVPUjY4WWNZbHNaSzVTQ2ZrTm1XWWs1eVdMOGRYcGdOUHA4dU9R?=
 =?utf-8?B?a0dqUzRTWDZVUUhUUkV1MVRnSDZ6YWhDSE9GVi9IbEpINXptNzBTSXcrVThE?=
 =?utf-8?B?cFRIcHFmajhEK293Ty83UEFFNm5tblFYcGU2WmQyRmk0MFdkOFFRYW43OG82?=
 =?utf-8?B?UndLaUJxNHY2V1lvdUdQdWJXclJuQ0lONW1ockd6bUp0MUFxNEJ2QkxPUHc5?=
 =?utf-8?B?N2lWaG9XU0g3c3lSQ0VsNmtBSSt5eGFhemtkYjkrM3RvUU1ISlovRk9NNmZr?=
 =?utf-8?B?b01QTzdLaEZWVXdPTTNuWnNraTBYSTBGUlY4UzVTWFYvM1hmVjlOeElTc1dk?=
 =?utf-8?B?dlN2cGtNVnJ6ekoxUzg3aFJ5YnQzYlo1R1ZIbkxpd3lKRE8vNlNnbFFXSnJr?=
 =?utf-8?B?SEx4d1hVR3NBYkJnMnJ6ZWNSVWczTWpid0l0NWV0TGhxRzB6QWFZVE90Z1RV?=
 =?utf-8?B?N25vWjlVZnNPdDc3UzRZdW50Tk96dUlQeklHd3VkYlVmY2h1MHJDN0hOVEhR?=
 =?utf-8?B?bzl1MDEwZlRPUC90SHR4cGltQWhwdkNsam1nem1oZWxrMXh0M08xOHk3bFJz?=
 =?utf-8?Q?cCqKM/adeHrvwyVFJhEI4eunJBFmWp1QZtbiTPK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDRlV3pJSGpyTVQ3d0hJcXJGMitEbGViell6eHNnMU15d1k1ZDJTUXN5Nzh3?=
 =?utf-8?B?RjBhYXI0NkkxSlhIZHdqUVozai84V2pHNzZYa3g3d0lXaXh3WnF3SHVhQjNl?=
 =?utf-8?B?SzFvdGN6UmswVmdycmptNy9YMXRrMDlCWWhFOS84VFNKYW5jSU1sRE1SbFNo?=
 =?utf-8?B?Q3JReXowTG5zcFhNQjc0alQ5VmxPZExDTEJrWDJweTZXNElKKzczS0pzZW0z?=
 =?utf-8?B?VFh2YXptUVVPVUMxdkE5dGk1MHdHRlMzeVY1dENwTnptQmdoRFJDM2pJMmRD?=
 =?utf-8?B?NE41all3dExIUWFsNVlQUjNNdmd6ZGRodmd0cWJZdUk3UDBldGxFUkM1WGtN?=
 =?utf-8?B?OHEwV1BaMTVLYmwvNGxUWWg5cHBsWVBIdHFXbFRhVU8xOUxhSUt2VW83RVBy?=
 =?utf-8?B?S0ZOdHdGUjNPVjVBOGx0MTYvQmFwb2RvUzFMY2hkSUJONE5uSit6MGJxZ0oz?=
 =?utf-8?B?Y0M1cXhMamJOTWxjQWVyWGExQzlTdUsxZWFCOXdTdDBHTjJhZXg2NVJuWklj?=
 =?utf-8?B?dU1TbGZjTFJQcjd3aEZTUEl3aE5xS1owbmYxWWpPczEyZmd2ME5VRFdub0F4?=
 =?utf-8?B?Q2F1WFVuQzhMa0wzMlNabWdVajZnbzVUdCtLZnpkdkdrclgwSkFEblNCS05p?=
 =?utf-8?B?enpSZXpEeVhkSDh5MUF2SlpJWWdNT3UyK1VldWdkakZQNUtXWm05aENIQTMv?=
 =?utf-8?B?WjJwMGNaNERzaWd1Q2xVMDg5akNBZE5WWTJVOXVzWG1UQ3lzZjBwbXVQZHZI?=
 =?utf-8?B?TFFZdndrNlRab0pjNVlsV0c3bG9BeDJ1Z3RuZmFYTlpUcWJuL1M0aitvbUFo?=
 =?utf-8?B?eWI0NW15WFlMOGlLZmFkUUlBZWNSNFJsdlJxL29GVzJtM0l2NUNMSTZEd0gw?=
 =?utf-8?B?cGg1UjJvL1UwYVd5M2NHWmdqbHdMb2w5dDFnMURoOHVRNkxwaEJLa0hvUGdP?=
 =?utf-8?B?NklKQUR0cGZHRUpzaEIydmdEaU1VWTllcWRtTUlrYlJLZGVoNmlhSUtja0Fo?=
 =?utf-8?B?b0d5UXhlbmFrem52SW1NWHN6RVBLd0pTd2x3VHVJL2JndUxzR25XblV2b0N2?=
 =?utf-8?B?dGFzM2tzMTl2Y0sraUhTRS95MTFoYW1Yb2w2ZUFPWlRkUlhXNzRBalhUUUI5?=
 =?utf-8?B?RE0xbnZ1ODFuRTFnbERERmxzek1FVFNBeTdqL1JPR2tBVDdBQXI3UG9ueGh5?=
 =?utf-8?B?TXhFa3J1VEYyOUpDSkowK2liK3U3OTlJNmtxNGxmdjVRTmJ6RnVoSnZZWWxD?=
 =?utf-8?B?eG5jVVRUZjF5bDZObW91REVIU1NnVWtIeU92bTZ0NFdhRnZXbm5hVjFadUFI?=
 =?utf-8?B?c2lrQkJ6czd4Vnp3Ukp5Ti9qMXhkZG5SQ2N4TndBVzRlVm1vR3FlZFU3U1Zm?=
 =?utf-8?B?WFFKWkNUNDZuaTBaR3hHRG5TMG1XMmZlRUVVbjNnTmNaWkZWQkk4dUZENXNQ?=
 =?utf-8?B?WkhxMVRWQ0x5eWJpQXNHREgzRnYwT3AvZUh1Y0RtQnpjSCtVcW1tNG1kY3Fh?=
 =?utf-8?B?Z1A5Q2x5K2JrellkQmxoV3VHRTQ2QmxORE0vZFJlZDVMMEJOZXFRbUdkcTV4?=
 =?utf-8?B?UHNJcEVrRVNaSlVabDFJdkwweDJqencxcTJuejlWbmdkTUcxeVZsUDNFaVZE?=
 =?utf-8?B?NFNjSGdENXBubHhheldUZklMeUlQYnZPYTEyckIyOWNZNGhaM094SHpEK1Az?=
 =?utf-8?B?WXpxREhObDZRSk4yQ2Y1Z0tISDR1UVFmY0JTVGVkM2dkWDYyQkxXVVhwNG1E?=
 =?utf-8?B?eXlLR0RkRnFmNXdORWFVOHNDMi9UM0o5WC91U3BOTURQeXI3dlYzU2lVdE5v?=
 =?utf-8?B?eUI4UVRidWZwQitPWHd3Mjh6TldOQ21aeTlkUGtIc01IMjM0alRad0xHU0lr?=
 =?utf-8?B?RlltSVBET0h3aW5Gak9NajJzdjZiRnhpZkF2cENDay92cVBnS0lkZHU5Uzhr?=
 =?utf-8?B?a1h1OWRBOFExa1BQb01xc0xCQTYvK0ZBRUxUMUR0V1VQRmV2cGs3S1MxZzRZ?=
 =?utf-8?B?ZzhlVG5uQkI1YmtwbzNZQzE4dTFOamtBaDFMYzh0KzdhMHpXdXE5bXE1SXVW?=
 =?utf-8?B?VFN4ZHRGeWVpQi9xbnpXdmoyajJFQlQ2L09tWS8xWDRmMWpQZUkrem9uUEtj?=
 =?utf-8?B?NmFra0NPZlV5NWhydW40dUMyQm4xVm85bkJHK0I4cGs3eStrUlQrVlRVeXJh?=
 =?utf-8?Q?yVAhDJbkimh1n6no9OOj9SY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <482BBAE20849A846AC40DAE9B4CC312E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a13dc17-c34f-44f2-62cb-08dd02275671
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:03:33.3576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLedqvmGQ4PvOYchnN28V9hzXdDnKEwDtRvPjm1ilY1SvgixCftyRIT8Q3dsx8l3Z2rp0DVbNOSlYEbyH3U9YL+2G4o1UwI2KK8hCnz37f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7488
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

T24gRnJpLCAyMDI0LTExLTA4IGF0IDA2OjIxICswMTAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToN
Cj4gSW1wcm92ZSBlcnJvciBtZXNzYWdlICJoZWFkZXIgdGFnIG1pc21hdGNoZWQiDQo+IEFkZCBm
aWxlbmFtZSB0byBlcnJvciBtZXNzYWdlIHRvIHNlZSwgd2hpY2ggZmlsZQ0KPiBpcyB3cm9uZy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFNjaG9jaGVyIDxoc0BkZW54LmRlPg0KDQpSZXZp
ZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5j
b20+DQoNCj4gLS0tDQo+IA0KPiDCoHRvb2xzL2lteDhpbWFnZS5jIHwgMiArLQ0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3Rvb2xzL2lteDhpbWFnZS5jIGIvdG9vbHMvaW14OGltYWdlLmMNCj4gaW5kZXggOTZlY2Uy
OGJkNmMuLmIyMmU4YjIxYzQ3IDEwMDY0NA0KPiAtLS0gYS90b29scy9pbXg4aW1hZ2UuYw0KPiAr
KysgYi90b29scy9pbXg4aW1hZ2UuYw0KPiBAQCAtNzMzLDcgKzczMyw3IEBAIHN0YXRpYyBpbnQg
Z2V0X2NvbnRhaW5lcl9pbWFnZV9zdGFydF9wb3MoaW1hZ2VfdCAqaW1hZ2Vfc3RhY2ssIHVpbnQz
Ml90IGFsaWduKQ0KPiDCoAkJCWZjbG9zZShmZCk7DQo+IMKgDQo+IMKgCQkJaWYgKGhlYWRlci50
YWcgIT0gSVZUX0hFQURFUl9UQUdfQjApIHsNCj4gLQkJCQlmcHJpbnRmKHN0ZGVyciwgImhlYWRl
ciB0YWcgbWlzbWF0Y2hlZCBcbiIpOw0KPiArCQkJCWZwcmludGYoc3RkZXJyLCAiaGVhZGVyIHRh
ZyBtaXNtYXRjaGVkIGZpbGUgJXNcbiIsIGltZ19zcC0+ZmlsZW5hbWUpOw0KPiDCoAkJCQlleGl0
KEVYSVRfRkFJTFVSRSk7DQo+IMKgCQkJfSBlbHNlIHsNCj4gwqAJCQkJZmlsZV9vZmYgKz0NCg0K
LS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
