Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC70FC54754
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 08:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C6881E72;
	Mon, 19 May 2025 10:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QkN8ywem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B96E81FFC; Mon, 19 May 2025 10:35:15 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A37803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoaiQgoIaZemlzRr6A4O0sqnXZUVKFqBMXFWP6ZnS9Tmoz0mm+xk0LemOYeuZIrfAWpfwriDuxbDPoMb1FCSRXibfAxx3VmL20c9Oh8dVvZz9lKbL7rEej0ZZN0TUEOpt3o9OBh38XwICiLhqxL78ojuax14tf7T5K7rNNcMrBaFwYn7VPPZTzhRnzqT3N+J3Mryev34dh53ocouK06c7oez8FmgpEEG1qaJximjJILAMxFRXN+xV9uITyS5pgpawsOFzniBgWGq4WHJ02rVdPEKrY3jwmjNJKC5wWb6sLeg9uMkv8KKlT6zGP6OT6aYOT6675v9VGswmb2ABwkrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpmDVyyGJrqUZxHx+V4QiXpO+6nHXh1T38xhHkIKS9A=;
 b=CZE6DncGbxJxyFWzql71W/TvIqygM/m8bEtHx9jaD7RZ9kbS80pHIccnmCTUpc1s9rEGO7ZDihhGPmL1Xg9e69fvWBhUddIJEtooKhcQoZ8LXRX5wQDmMIG75C99CUvHyvnIs76YLzdiL3BcNrCuuaoMyhiqvZyRWYHSdGuGwOAcAK+F2IpiVF93JQy1qT1M6Jbwxegyp2jpiHqwUtzkgAYUlluVxui5T3mF/QXSl4b9laeBRBjULCNvKhZ3GMD/qT/w6A+gmsJZobr8XHmyKVq0jlA9yDMRAVfTqyObI8POs91DuwE6tTJJwcdseL67yWr5WGZsddBIyC0Swzvmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpmDVyyGJrqUZxHx+V4QiXpO+6nHXh1T38xhHkIKS9A=;
 b=QkN8ywemnPNdsbwcrSGA6kUDYqHCQQxQF1EgPFcRZyEHaFURXq464ZTmfiOY3PfETmKrFi6K3/DAE7Q77CpWd9SYBjAZDdZVx6Hpgo7NVt5t8wW+iKxffMPGBn6az8eCyqC6xmKnILqKzKsuSORuUfCqgE9sqc96hDyPQmzS90U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8146.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Mon, 19 May
 2025 08:35:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:35:11 +0000
Message-ID: <8e930859-c73b-4bd8-b58e-474b3e70e15d@cherry.de>
Date: Mon, 19 May 2025 10:35:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] Initial support for Wiznet W5500
To: "Verdun, Jean-Marie" <verdun@hpe.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "jmverdun3@gmail.com" <jmverdun3@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250511180207.42945-1-verdun@hpe.com>
 <20250511180207.42945-2-verdun@hpe.com>
 <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
 <5dc908b9-6659-47bb-bcad-134871ecac28@cherry.de>
 <DM4PR84MB197689F8308F8FBB04CF96CBD690A@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DM4PR84MB197689F8308F8FBB04CF96CBD690A@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c26d88-b2e6-4d5d-2294-08dd96b011ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXl2WFJmNU1IYTE1RU11QStET3N6by9ES1hQRjhuZ2VXbm9ERVkxUjRvZG91?=
 =?utf-8?B?YTJWYVhaL0pzK1lQak9leS83UEJSLzJud253YTM0SENQSEZMVXR0MHJ2NEwz?=
 =?utf-8?B?NThPOU5ZSEloRXFNNUs3VWIrRFowb25abUw1ZE1xNmVLSGFZVlE3V0dnQTZx?=
 =?utf-8?B?b1pybXhMM2dUakhuMW42eUpiMEpPVTJRdmpCemQ3OTR4eE5iS21idlpNNUV2?=
 =?utf-8?B?R2Y0TTNXTjJFZDd3UDBtZnlzMHFzRGVPemU0WmovVzdtcWp1bW56NVgzUi9F?=
 =?utf-8?B?czhMRmtSUjY2R05KQlJaT3RSK2JWekZ6K1cwbDlod0FxTHB3MVdRZlVia0hK?=
 =?utf-8?B?VFFYcWtDOFJXZ0ZBMTc2b2FPQm91WUU5V1ZVUWZ1NnVRYTRUQWY5S3h0RTZQ?=
 =?utf-8?B?OXIzM3BZUXFmVVRBdGU3U0JFbW84WUFkV29OWWx3SVBiQzdoN1VOUGFWa2xP?=
 =?utf-8?B?WEFlU1dKSUV6VnV0UUNJZXFhcndzNUhxNzh3aU4wOEVPK3JLUXVEV1VSWkRB?=
 =?utf-8?B?ekQxTTRpdnJpd2N0QmczN3N0N09XSVFlU1gwWnBNNlo5d1NUeXlpSU5iZ1l5?=
 =?utf-8?B?N21NaHg4QldOL2NZRFUyeXRULzJlWTBQN3lZRy9WUFp6RGdkY1BnRmZtaWk1?=
 =?utf-8?B?cHhtV2dBd2N2R2dDUEY0VGdIQUtDaGZDRjJ0Z0NvZjZFZDhVSmxGcis4cXFM?=
 =?utf-8?B?S3hhWkNGK0NwN3AvRlphODc5U2VhdDN0TkVQaEZ4OFRLYmRpdlFTRHhzRkxC?=
 =?utf-8?B?cG8rMFNXUFVlUjRramVLalRIS1EwNXZjZlR3ZHFDMVpHOUo3YlhkVnlvaTZ3?=
 =?utf-8?B?cTV2ME1peVFUc21MRjZ4ODAweTdYRmZhck1BUzhzWWpUb3hGODlSaHI3Tlhz?=
 =?utf-8?B?b29nejNrMTMrOTlVR1pYZVJTT2UwODNIMm9sclRBbnh6R1daVlJyTGhiRWZS?=
 =?utf-8?B?anNHK1F0RElTSkE0bGlkVHB5Ky9iMU9ZVmNid3AzWXBHeW94Zi9yVnVhQklT?=
 =?utf-8?B?RGsrWkhwdGE1dm56V1E2bWc5STB4Q2tFWHU2NlZxc3c4TytBZk4xdnk1NjNv?=
 =?utf-8?B?NEFoRTZaWGVvcTZ4NC9vN1h1TlZzRE5FRzUyTmowNEJTM2g5RkZRZWFtNlpU?=
 =?utf-8?B?SjdNWkVqclZJL1VVTi9KRmcvSDdPclhaVGU2L3JUMHFXcDBwc0xIMEhmTEFF?=
 =?utf-8?B?QjR3Qk1IdENnUzdNdWVNMERrbi9qcFlHeDVwOVFLR3VLb2FObFR1dm5yc2o4?=
 =?utf-8?B?bVB1bWRSZWFlMTJiMnhBY21hTUZjTHBCbFJFdUJycjRBWnN1SWs3MDl5dW9V?=
 =?utf-8?B?MUNISlpOWFBaUHRhS29Yc3JOVXpWQ3JVZ1RmSUtZQzVsc2doY2g1WG5TUWFL?=
 =?utf-8?B?V013NzNhK010akM0WmFha2U4dmNSRU5NWnpCVUJIQm5IZGVyOUJqdEx6RWd2?=
 =?utf-8?B?RlUzOUJWWXZoam8xa3dpMUk0ajBqWFJ0ckNFbG1xc2lTSlF0b3ljOUhEcEpM?=
 =?utf-8?B?SjV3UFRYa001S1FFTlQxb05DRU9WeExqbjZ4SWV4WGlDa3VwSmM5WDRmVzgx?=
 =?utf-8?B?dTJ4RkVjSHpMK00xSGl4aVRFSUVUblYxZnVRbXU2YjZ4NjdyemRGR3RIMDNW?=
 =?utf-8?B?c0pDSVIrSWNJWU1MaFJURUt2Z3Y0ck1jL2RDOWx6M3o0b0ErTHlhWEJUbzB5?=
 =?utf-8?B?RE9RdUlLMWd3U05TamNUQjR3amtVY3JteHVZNnR0MFltYm9QUVN3bFFpRDZh?=
 =?utf-8?B?WmZERU9pUzNKamczK0dGTm1NUGpBcHdBb2N1enplNDAwbTlnMU90WUxZbUMz?=
 =?utf-8?B?NzJXUUZUZ1prTEN6em45QkkwOU1QeGx5dUFxN2w4aW95ZnVtSDU1akQ0TWtW?=
 =?utf-8?B?alpSWjNZNThXeC9zMWswajA2ZWlXVTE5SUhBdDU3aHgyZW1DaGlwWFVxN3hk?=
 =?utf-8?Q?iMjWdB41zy4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdDV3ZQVlJSeC91VjNaSlFlLzBRM2hzVXdDN3kxNDFlK25hZUxNN2V5SEZI?=
 =?utf-8?B?ei8rNXdrREF0ZWh5YThtd3g5NUFOVHVENDVHYkEvRCs1M3JFcTRvbHJRMkVW?=
 =?utf-8?B?cFhWQmVndGVlN0IyenppcWtpTGRsWVlFSjRMU0Q4OEdQZzNLQUFDakU4dnY4?=
 =?utf-8?B?ck10RjVqMXJIbFFMQjI1TzM2bDNrWDRwc1BoUzQvY2dmVlY1eTIvL3VSV3Fh?=
 =?utf-8?B?NWFsUW0rMjZKYkV5WnJFcVBDeWd0RlRtZWJWWTNtRXdZWXByL0ZkM0R3Zkg1?=
 =?utf-8?B?dUpVSEUzelZJTXRlZytMOUpYbHZZbHdIbHJTRGRsN0hIVFc1cTY0cWlVSGQw?=
 =?utf-8?B?VVdSZXl5d1NSZGpoRWdmNWlBSTF2UUI4bTlQYlhVYWs2RmZ0RVp6YzlCbGVF?=
 =?utf-8?B?TlJwNHpCT3lCRDIzMTE4dWNNeHJQTE5VVk9tNW10eXpiY3pwS0RwU2xJRDVx?=
 =?utf-8?B?UlpRSjQ5Z0hEUXJ5cC9KME9uemkyZEc5RmpaTkIxQnZBdVp4Qkl5Y3NlMXpG?=
 =?utf-8?B?WG9va3ZRb0V1b0hvV1ZLTktNbWNxSW94K1I1WDVhNWRzN0pTN1NoNG81eW82?=
 =?utf-8?B?QlFLaXlLMnNKM2IrTkE2bE9iQnNuUjFlR1lTZGdYUXdCc3dtTE00UzRYVDNF?=
 =?utf-8?B?dHdBWDMrK1dFemtxSGJwcjFUZkNWNTkwRGEvb205UmVkRnU5VEt4TE1DZnpv?=
 =?utf-8?B?RUkvTDYxS2srSk81NjlDZkxzMDQ1Q3NFTUFBTzFHMzRlKzU1eVpXU0dqR25K?=
 =?utf-8?B?ZXZpa2gvU2xVT2daMnNZaGU1dHZJTFc0a3NuQ2FvYThTNU9nMlBzUlZJS3NE?=
 =?utf-8?B?MUFnT3ZJN2l2N0cyYXY1dDd3Y1JuQlh2MzRKS0JCNGw4VXFrcUdLQlQzQzlR?=
 =?utf-8?B?alJyMVI0Y3ozcmp3RTlqVHZmWUdSbGU4ZHdCTU55RE9mdG51ZzlhVDcraVI3?=
 =?utf-8?B?L2RJWWFXN0p1NVh2VElxMWtMVUJTd2VzVm1TdmFnRjRRczhKR1NFVFhXaC9L?=
 =?utf-8?B?eWFTOWt0WVJNWXlWT1VXcWJSYnIwMlBmdC9POEh1TzNwRDd6WTJUU0UvNC9X?=
 =?utf-8?B?R3JaZ1dnTm1KOHBxOEJJMk84OGRlOWd3cERXcHloVDN1VWRPYmg3MlJ5ZVdT?=
 =?utf-8?B?RHhCVUpJQlBzWlM3SXpsODZGZDM3R3ZmVExIK3VDeXl4U25oR1ptQXdaOEhj?=
 =?utf-8?B?RGlibVlIRVN3M3dBc1BFZ2ZzSjc3cTkrOXk1RndFSFQxc0NrT2J1OVRJNnFo?=
 =?utf-8?B?eURjUzNIOEtzS1pZV25haVpGUnc4bnREWXZ6QjJUN2VUdlRlWXNWLzZlVW1C?=
 =?utf-8?B?Ri9qZEpKY296YURFcmVUajgzTFN0NVZjeXJoUnhydFBiYXNid0tEbXFMRkdC?=
 =?utf-8?B?eFBzTzdBaW5vRDB5dDY5dVpIS1pyOHhKeWNCRVZYR0RBcVdyaU9YUkRJUTlD?=
 =?utf-8?B?RUtNcWF2UzU5TWZWQmVqTDRIWlJibi8xOGloZm1WVjZmV1E3VVdiZ2RQSTZL?=
 =?utf-8?B?eEJBU21JS0lrbkF5c3dPWkNjNlh1bjFlZldSNXlBZlhQeWlrNXJVcUsvSTVK?=
 =?utf-8?B?eUE5cThvT1RobWFpVjdoR3B5cGJoSWVaNFhTU3RnS3U0UVZPYlI4SXVISlgz?=
 =?utf-8?B?bS9CRDh1TS9RczU5OWhNV1dZeVNsZzVyTzA5MWtHbTV5M05tS05JUFhKa0hQ?=
 =?utf-8?B?L0p6VS9oV0dDWnIwRzJKZ3FJUzMvUWpKYi8xZ2c5R2drYnlSbVZRWUk1NzV3?=
 =?utf-8?B?Mjh3cCtoQ3Y1ZlJtYnBGTVIrT21JdzAyUWFIVk1zTzZ4anBEdnNtaDNZUDdk?=
 =?utf-8?B?UVhWYlZpeElNeDRPK2lCRmFVT1FCMlVMY0RRNzR1dk14a3ArVkQvOFF0YmlF?=
 =?utf-8?B?djVrQ3Evd1BTaEtHVmQwbElaUm5OWlgrajA4d3FvanBWd1RPOVdlN3B3YmlO?=
 =?utf-8?B?L3d1eGgrWlZIMkFKZU5FbzBGMEtFUTduZU41dHE3M0UvNlVUWHhhVlRRMXM5?=
 =?utf-8?B?d2xkczF0Z21FR3VHUStscEdvZDEvMmNlZUVSUk9XK0tEV1NuUHdDZDcyOTNk?=
 =?utf-8?B?Nm5DTlJJNmJKd0ZQY1dlWFd4SnV1cE4rbkpEc0NndkJGRzNlYytQU3pOVzVs?=
 =?utf-8?B?V28yaDYraU1ZNVFVQWVDdHh4bGlJemRHd1QrRDlLM290Ly81cHAweCs2a1Iy?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c26d88-b2e6-4d5d-2294-08dd96b011ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:35:11.3331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQl1sfxw/J3m3VtZJfp8chW3ezxEgcwYIXsaTUONx4Iv6vihVhO5lFcq7gXy9oH7ZG2RkHi2qqxrtohscN86smqxXocAWhciq+Xx+3rOsgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8146
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

Hi Jean-Marie,

On 5/15/25 4:01 PM, Verdun, Jean-Marie wrote:
> 
> 
>>> This is dangerous too. How do I know if the returned data is an error
>>> code or actual data?
> 
>>> Right now, xfer returns 0 if successful, -1 otherwise. I would suggest
>>> return ret only if it is < 0.
> 
>>> Or even better, propagate the error code and return data through a
>>> pointer as argument of the function?
> 
>>> e.g.
> 
>>> static int w5500_spi_read(struct udevice *dev, u32 addr, u8 *data)
>>> {
>>> [...]
>>>      return xfer(dev, cmd, sizeof(cmd), &data, 1);
>>> }
> 
> I could do that but that won’t be the same logic as the linux kernel
> driver approach which is mixing up ret and data as return value of
> this call and many others too.
> 

Fair enough. You could have the same ternary operator to better match 
what's in the kernel.

Can you also reuse the macros that are in the kernel already? 
W5500_SPI_BLOCK_SELECT, W5500_SPI_READ_CONTROL and 
W5500_SPI_WRITE_CONTROL seems to be of interest?

> 
>>> Considering the only difference between w5500_spi_read16 and
>>> w5500_spi_read is the 2 or 1 as last argument of xfer() call, you
>>> probably want to factor them out into a common function to limit
>>> duplicated code.
> 
>>> If you have access to the info, I would suggest to NOT use a u8[3] array
>>> but create a small struct which specifies what each u8 is for so it's
>>> easier to read and debug later on. This applies to all other functions.
> 
> I can do that
> 

If you do that, please also update the kernel code to use that :)

>>> Looks like endianness swap to me? Is this supposed to happen if you have
>>> another endianness for the SoC than the one you're currently using to
>>> test this?
> 
> I don’t have access to anything else other than an ARM SoC to test it. It seems
> required to swap the bytes from the SPI read process
> 

Yeah the kernel seems to be using __be16 type for that. And the write 
part seems to be done by hand for the address and data.

>>> Please use log_debug()/dev_dbg instead of debug().
> 
> Neil initially asked for debug, I can swap to any, just let me know which one.
> 

debug() can use the log framework if enabled, but you still need to add 
#define DEBUG wherever you want to build the logging messages. Whereas 
with log_debug you would only need to raise the log level at compile 
time to see the logs. Same, but different.

The benefit of using dev_dbg is when you're having multiple devices from 
the same driver, then you can identify from which one the message is 
being printed. You could have two Wiznet W5500 for example, how do you 
know which one's printing which message?

Up to you,

Cheers,
Quentin
