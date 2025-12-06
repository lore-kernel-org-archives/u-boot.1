Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DBED3B7D8
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 18:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D11D83837;
	Sat,  6 Dec 2025 19:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="d+GwLHQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1408283981; Sat,  6 Dec 2025 19:11:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854CD809A5
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 19:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHT04Yjk1HuS6hm2Xx5ubAOPhpBse2SD6Yn6/svXGQlZlv0qNhh51EUM1zf2ibmdl+SxC0TPVaOnEdWgV2YxSkpyjD5zG02xTeptZh3fm/fYDf4xO2ub6ZTFKzqp0xe9+KSGQr/Afw9uYUjz9cjoOH7b9YwLerW8o/XUWa0RjpS/BsUvL1baVPor5Mja8WLfhqsS1qtibjuHpE+eH75p+tqBs8BUofUALZEIoed/qL7+5mxZlufGvgdEsZ5vCQ+kBTt/KWo2BTVsbKJS45O7v9F8wfJdVmYU91qt7DabHJDVSYJieJCzzBkfJ0FKEDV9CWC5O0ujFq5h7rxigwne2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHeeqg2eDHc8aWvhvGZ7sXEeqG82YgfMQQGViY7Vv2o=;
 b=w4rnfq2NH6ESRpyo+v/umHExYEU5xwIFY3v2PFP2bkP4VtXLPoNdJ0jcEnxGlvPWncBcPChTS8MIGVvgDJskjmh53rGR9z57u4QfvPg1ur1eFdpvdE7liw75TZSqGs80otuvkU6IJSXyc0m8nE9gnQbS4/QsRG5UizK/5NIR1+oZnHtuxUWLsV3y6rw1NIS/r39cZxM1d3CO0gztMwdTeNJCwEB5TDoBw8pDJWH5pRKfQPVpttIrMQpsT0FPaeHdargrtongO6/4IXOEJoupYNOygfvNvX5S4gE9vlE1c8b3aCL3ghUhaAnjapiTE3Fn0mZ0H4Cwzr7wq939FmRUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHeeqg2eDHc8aWvhvGZ7sXEeqG82YgfMQQGViY7Vv2o=;
 b=d+GwLHQ/ffMDZKHzgkb+Rk9DmLrYTjOgCNlig13w9A/Qd/zSXoOeKTzruHKZyyYPbXfzmdrbHnz7VGnzn2DjeEOjBs3QivwfCaV2sF9MxEexwQEDnjUWukJ6S3pYPOZx/15hyxGVI4OsuIvfLnnFlk0NmuwezEcVZhnG/8f+KzA0LK6wbFbAYZERR7dXEJ4fAZSh9/r6CS1zAUGIGSKtasL9vd3Tfi2XdfZjmOtp1v08Eh1DZvH1TFO7+Qv9ZwCZ9G3Ne/odofZDTuO9azqAJH2LpJmqChEelATTZmCoHtRdTOfByQj7/eoKmA+9JOjNOOBbK/+HyCak7U/YbL9l6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB8P195MB0485.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sat, 6 Dec
 2025 18:11:41 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%2]) with mapi id 15.20.9388.012; Sat, 6 Dec 2025
 18:11:41 +0000
Message-ID: <b1484162-476e-4377-b08e-635d1b064a83@phytec.de>
Date: Sat, 6 Dec 2025 20:11:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 2/3] board: phytec: phycore-imx93: Set
 boot_targets dynamically
To: Primoz Fiser <primoz.fiser@norik.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20251205111044.3195322-1-primoz.fiser@norik.com>
 <20251205111044.3195322-2-primoz.fiser@norik.com>
 <26dfb03f-ce98-447e-a931-ba9a34b2f8be@phytec.de>
 <da69ba4a-b23b-4a64-85b2-afeed14ce38b@norik.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <da69ba4a-b23b-4a64-85b2-afeed14ce38b@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::38) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB8P195MB0485:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aaa610-0f7c-401d-b998-08de34f2e817
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnNVOFgwbVlwTlo1REpublhTeGd0bGUvRWMwa3FkMkNEaDVLbVVzL0ZDZ3ow?=
 =?utf-8?B?V1lrU3J3OUJ3YU5IdlRSL2xCdzhFVjQ0V2FHS0haN0tTbXE1T1RIM01BcWdX?=
 =?utf-8?B?WXVmTFJtWUdkT080T3JxYi94TDBRa3daMXRESUlhZitaTGxpeFQyQnJWOVVK?=
 =?utf-8?B?VEVyWERTN0hsRmtaTWdJbVZpU2pkelc1Q2FLSFJIWno5OWQ5aUlReGlCWnhQ?=
 =?utf-8?B?UC82dXhZMExreFhGRldPNW9JZ1JzYlZ3M1krelhXUGFkcnZrYU5BczJFc1Z5?=
 =?utf-8?B?dzJOYXhEQWplUEZ3UjZuQTlaa2cvUHpDSDcrRXNFd3B2SVRDRC9PM2lva3Vs?=
 =?utf-8?B?NEYycE1rcENSak1TeW5xWUNzSllmK2hKNGlsQlo4VmxleWxBUENrY3F3T3Zl?=
 =?utf-8?B?MFNPYldXWFBhV2sveHovc3VlbjVEeTVrdVNsR1dLQjRtNDhyVWEvbUprV3Bq?=
 =?utf-8?B?bDZDZDc1Q3hkbUZvdmVFVy9LTDNKMGVTdVFBRjdyN1UrRHBEZmJvVWRmZFMz?=
 =?utf-8?B?Y2hHdnM4R2M2T2JyS25XYWRSdnNhVnNScVdDOWhIbEd2VWY3S3NKTTZ4cUl2?=
 =?utf-8?B?OWRPalQ0RU5YdHFpQWRJTC9OQUprKzh2U0hOVUJrajRzT2tpaG5PY1VPVG4z?=
 =?utf-8?B?NTRlNTlnNUViWXdpNnhXOWVYVGxObzB2Rko5TEJTbmpLNzRBd1FyZWtrOVM2?=
 =?utf-8?B?UWpvc3h4UzJzbzlVRjRTWVdMTXpZK3dRWlJBWmJuM2x1ZnBkOGpEQVVVdUlC?=
 =?utf-8?B?VVlpQytpNnBiOURRWG9RVWhWWExXMjFCSmZQZEVUYlptMTlLRVQ3a203M1Y4?=
 =?utf-8?B?d3hzR3V0OGoyUktKaDJqRDBqc3BaTDBHKzk4aGtONU4rVGlDbzUyOXJHOFdj?=
 =?utf-8?B?VUs3aXhlZEgvQXhiVVFpN0ZNWlRmOHd5NTRnRzJoaWRpZGoxc0QwL1FBOG95?=
 =?utf-8?B?dnBIbDQwR2NpOVkxVjc3ampMMUowRjdoR1VBb2FhUENwc0d3NFI5U3c5WERs?=
 =?utf-8?B?bXVYOGlmL1FybkFrd2NzeWRBemlldktmZzVXOWVSM25MZW4rZDIwcUtiYjd1?=
 =?utf-8?B?eCtZM29hR1JxVGsyMEJoQmJaNkZjK3BtRExCSlhNWldSVFhaMXo5RnE1Z2hN?=
 =?utf-8?B?cVJIS1BZQWxQZVpPaytVS1FreHRSYmVCTVhUT3lFTGd5N2F0WjFhNFR4ZGRY?=
 =?utf-8?B?cFBPSVlhVWhKTit4NERTQjZSaVRLZUZ2UDdLb0Z1dGp4blZTZ0tLMWwrdy9W?=
 =?utf-8?B?Ymprbk1qQnppOUdNQmlKRVMxbWp0WlpCSmQydE5HR2RFS25OeVhEWFl6YTJl?=
 =?utf-8?B?VzV0a1Z4NTI5UG5jK1VhMkpVWjc5NUh6ZHcxdlhOeWJjOUJ1aHhyN3NDTzV2?=
 =?utf-8?B?aURGOHlDcm1jYmdGdmk0d29NSWNXV2pobW1waUhGZWkxQ01ndGhzeC96VC9L?=
 =?utf-8?B?MXFSdkQ3RkpzV0FBUzB2R0RhVHJCV1VLQ2hIR2NPdWlubDBiSW1NSEJLK2Qx?=
 =?utf-8?B?UmdSVzhXd3c1NlByVlJGR21Jb1ZjcE96bnBRb1BqRzZCOUxLcEY1aktvY25a?=
 =?utf-8?B?aDcweS9yZ2R2WnB5Z3dYbUIrRnhYSXp1aEE1NHlrNFpBbmVlTDA4cHJTMTZs?=
 =?utf-8?B?SkNwYmpSdXlMUHpTZ1dTcEx0SEU4M3U1Z2Y0bDFEQjJSNWIyYnEwcExaN1E0?=
 =?utf-8?B?RDFzalViU3B0UUJvckNKSDcyTFZvVENza2h6M09kZEkrVTVSM1c5UWJFVGkz?=
 =?utf-8?B?TEdkVFBIMjAwV2ZPVmpIckR3ZUR0UlZDSFBkY1RaQ0xTc2ZmdDFab3lQb2xl?=
 =?utf-8?B?aWJsTjQ5aUoydmhVWEF3aTFVTHFDbEVyZDhzTGoxbkt0ZmkzaDU4T3FwOUpZ?=
 =?utf-8?B?Z3Z6QWZVMVkvWmU3Rkc3YUQxWStQSkJVcUlFTDBieE1TeXFyNDFwZVVna2xx?=
 =?utf-8?Q?xoOeWVu+3wWBvjhA4tZpZ5cKNh39cRjn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNKekp3Y1pNQkNacE9pWHp4VFBiNlRCUG1vdFBBd0NjTy9mYTl5cjAveS9s?=
 =?utf-8?B?ckxRWEwrcXNYc2xmeWw2alJDMFh4U3l1UGFOYitZMlFob0I3cEdrbmgwR0sz?=
 =?utf-8?B?S3lUUHMxcWx2WHYvZ2hDZWhwVTdMallDL3NHNGxJdG5kN1hKWmYwcUkvajgr?=
 =?utf-8?B?YnF3Y2hrbHQvU2h2Y1l6YjlGRXoyeURJU3JBTFA3SVkxNEV2d3phUGsvSkpU?=
 =?utf-8?B?NnNxekE5TXR1WTZ3OG1kc0JXU2dyWU14MWp1TWVnK0RCYjFWU1dJR0Fvc1Qw?=
 =?utf-8?B?NUpNNXhtUWdXWHRFc3hHVFZHeFNkV01YdkZqU2JCY0dnaVBpbHJJUjBDSmhY?=
 =?utf-8?B?QkEyQXZSQkdlSzdzRk5ITHUzamtWZHMwNE94R3NWSCtSOVBzTEE2NjBUeGEz?=
 =?utf-8?B?SUJYR0FicVVoOFpENm50d1lEZ2NGcSsrd3pJYXJKVkJjQVJIcHU5TkwzV1JR?=
 =?utf-8?B?WFcwN1RJRzhZKzhhUEJLNGMvUXpiSGtSSnBzUE1ybmVJRkRXa3VjVEhtSDcx?=
 =?utf-8?B?MjM5SEpoZUd2L1pXeHpwV1U3NWVrQXZOM254MC85VXRqNnk2Sll6bVZkSmF6?=
 =?utf-8?B?Q2t3empYbnBESXAyU2grOUIxdEFNRmZhMDFyTHBsOStuOU1GZEpodWI3TkdX?=
 =?utf-8?B?T2pKbTRFYzRzejlwM0QxaUd1MmxlckExSisvdWVyK2g0MnhTMC9pUmgzNDVz?=
 =?utf-8?B?clovd05yU0xZbE9ITDJYYmlVTHMzT2xUV3g5UGEyek5zRm43ZjNTbTVwbk05?=
 =?utf-8?B?dytxUjdJNEF4aEN0R1lTQWZFWHNoWGtCZElXcGp2U01aL2JEa09vT0xjWU81?=
 =?utf-8?B?cE0ydDRRakpTVHhsNHNMVTNpcENUTjZJOFQvV0E1NmpZU1ZlcEFLSiszVUU3?=
 =?utf-8?B?c1FyT2wyUHI3VUZtd1FtbXlqZFJ1cnAzR0c0anFjb3NXdlRhZUp1MXBYMDg1?=
 =?utf-8?B?YkdtQjRRV0U4TS96QngzLzBER2tJWjFJcVRKeXRUSSt4MEFmcUUzaFpqRWhn?=
 =?utf-8?B?T2ZTQnYvdmd0QUQ0aGMzQ2hjTDgvT24xdXZ1U2hveDBxUUdRSktwY2wzQXE3?=
 =?utf-8?B?aEJ2MkdyK1U1b3pnbGgzRzBvdkc4QlBJNmkwRnFnOW9yUDNjOGRlUGhHeG43?=
 =?utf-8?B?NnBHcWV2U0hZeW13Z3VrL3Rpd1Y0U0FSOGRtdnErWEpueGZLdXNWVzN6VU5J?=
 =?utf-8?B?bEpLYkxHTXpUWkJXZElFQVF6WklyK01jcDhFbXZGN05yT2I1MEsvblY4dlVx?=
 =?utf-8?B?NFF1WUszdERPeVRXMnovZ2tjYTFUV2kwUFdwVzJ1L0lDYXlEUEUrT0FLS3Ew?=
 =?utf-8?B?WnI2cDF1MktnbFFEY0VJQVhudWZONCtzN3dtQzlCczl5dDN2U0FtVmkyYW9S?=
 =?utf-8?B?LzZjb2sxRDRhbFNJSjJ4K1JpSDdtYkRYMzduZEpRN2pxbFBYSjZxTmd0VTNr?=
 =?utf-8?B?VEVnYjJQaUh0WXViTEMwU1lRdkZCL0FSZldhanZIelV2dzdhVGN4T0JyTHRY?=
 =?utf-8?B?c0I4UFNYWmJCMUtkZnFiYWxIZ3JPVXQ2OVlaZHFkbTk5bHV4S2hnaXBwcXRn?=
 =?utf-8?B?R0hSWW9FQ1ZxRit5Sm5GKzBuNFdZbUxRQUNGSHJwUXhwM1oxWS9MMjZFT3Rh?=
 =?utf-8?B?OFdONE1IVVNSZjc5YlVWZy9tNXY5OU5HVkVSaFRIODAwN1NGMEF4L0dCdkFv?=
 =?utf-8?B?NkN1QWRKS2tjOE9DckJnL3M2REJJa3pKeEV4WHEwOFZzTnNaaGtkUTBINUNB?=
 =?utf-8?B?SzdxNjBkVVI3aEc3c0EveGxManhwbmduSGtEQnhtVmtqcVBWc1NZdFJ1QU5n?=
 =?utf-8?B?RTVYNyt4Ky9ub003UjluSGN5VGFIWG4wSXlibjlpWFhhQlpuTGYzQ1VmbDNJ?=
 =?utf-8?B?VWtpLzNBNWNWMzh1WFRWMmlRQzNoSk13bGlLOUovR3BEYVM5MjdxMkFjRzdn?=
 =?utf-8?B?c0djZHBMeTRPMGsxcC8yWVdTdGlWZk5TREQvOHFUWjdyU2czdFRpMWp6NEEv?=
 =?utf-8?B?UWpLczE1dlZWTnhCVmtpU0xOQjNmUFdTSWxSeUErMm1LRXM1b3BUc0hhSk5B?=
 =?utf-8?B?bG5GTEVzcHYwbW1qRGlCYWR5eWgvZG0wbzJVMEtGUXdnVDVRWWlpc2FIT3Nn?=
 =?utf-8?Q?b0vwV7+e1CGgYKt/lUMZvX2KX?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aaa610-0f7c-401d-b998-08de34f2e817
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 18:11:41.4971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h90WUGtmVMm/1DKEVNttojdnqRa/KZX1mNM9Pj08PdQw+TMBfo8tb7MgoYD1ZsI5WIKTzLvOa9mvktrhxDSq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0485
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



On 12/6/25 2:27 PM, Primoz Fiser wrote:
> Hi Wadim,
> 
> On 5. 12. 25 16:40, Wadim Egorov wrote:
>>
>>
>> On 12/5/25 1:10 PM, Primoz Fiser wrote:
>>> Set boot_targets environment variable dynamically, so that when booting
>>> from SD-card, boot binaries are also preferably fetched from the SD-card
>>> by default. If the user decides to set their own boot_targets, we should
>>> not overwrite them.
>>>
>>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>>> ---
>>> Changes in v2:
>>> - no changes
>>> Link to v1: https://lore.kernel.org/all/20251204080744.3868067-2- 
>>> primoz.fiser@norik.com/
>>>
>>>   board/phytec/phycore_imx93/phycore-imx93.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/ 
>>> phytec/phycore_imx93/phycore-imx93.c
>>> index c6a4e923b074..cfc6d91f20f2 100644
>>> --- a/board/phytec/phycore_imx93/phycore-imx93.c
>>> +++ b/board/phytec/phycore_imx93/phycore-imx93.c
>>> @@ -38,6 +38,8 @@ int board_late_init(void)
>>>       switch (get_boot_device()) {
>>>       case SD2_BOOT:
>>>           env_set_ulong("mmcdev", 1);
>>> +        if (!env_get("boot_targets"))
>>> +            env_set("boot_targets", "mmc1 mmc0 ethernet");
>>
>> I guess you don't define boot_targets in your env so you don't need to 
>> check for default env here?
> 
> This check ensures that if the user manually defines boot_targets in the
> environment, we don’t overwrite it, as described in the commit message.
> 
> So the intent is to only set boot_targets when it is not already present
> in the env. This mirrors the behavior Benjamin implemented on the PHYTEC 
>   i.MX8M boards.

OK, thanks for explaining.

> 
> BR,
> Primoz
> 
>>
>> If so,
>>
>> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
>>
>>>           break;
>>>       case MMC1_BOOT:
>>>           env_set_ulong("mmcdev", 0);
>>
> 

