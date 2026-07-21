Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4D0C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EA1C40874;
	Tue, 21 Jul 2026 09:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNjzCDTtyZX4; Tue, 21 Jul 2026 09:58:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6108540827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784627894;
	bh=gPXT8S/t7ZHh0ldSwgLo5DBp0R8qEH5ORpjfAcb7uIY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0Om+8VJFZCvxKKEPGUMUoZH42S49Qk/bjCvGwTBijy4a9DXnobNvUc1Jzf8DD2KAn
	 h9A8rpAkRzS/DWnl8eFf031hfkpw6qimghBKgfGP8MESZohlWViFlaBVrQzDtkgHkK
	 zfyjNd/OvUK+x4+En9S7wTTAYdTjwzv2uFX5xmGckZrEaMjDrTSb75V0EEEDO1iIsR
	 7F2Y074oZcFxBrlWkFmhe80LZODyAz5Uy6hebsXhTulDzKOLsJ/iILrAAjeWceOzVY
	 Dl3lUaf5odQ9gO7m/9ES20mNiMZ33YuaZHBIEAE080UEYds7nS/767SMYtpKYLoayp
	 uXvdAQ1EFhLfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6108540827;
	Tue, 21 Jul 2026 09:58:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CAB8E42A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7E704006F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DvlmYLOQvk1q for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:58:11 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5F2EE40063
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F2EE40063
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F2EE40063
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:58:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CC884659; Tue, 21 Jul 2026 11:58:09 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676D7803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 11:58:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoDRuJO99elGJOKchVAVunLYcF0UXYccf4zX7VVic0ZeGbb2MNROzi2PcmtA4uCkYHBbGZAGCQ3/cT8qrm2Tpj+HW+W3WxZ29nkt9fo+znwVct11iGOgw96v6iwO6swpvuG0qEz+9PnYizuuWPwsPQLsJaxskuYZlPqRQU5AMtDOjc2wxJWTkwdFoP9Rc/ZGvdmlxMne/XuMtdgSRVKgzQHKT4x6vVBLhphzRLHZnZSoyWPLad503HdUlRC3rHC/ocBGsCCMgoQo77HHBsWTogph5y+m0v4E22JAv1AHzm+nOpAXWniLghxgTKeUOEqCcmE25ypWoJvd8boXLKdj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPXT8S/t7ZHh0ldSwgLo5DBp0R8qEH5ORpjfAcb7uIY=;
 b=xa9TfgZl+Cm2aD5obf0g0xlaqZ26BES/+Ep6IUzLbJYLQisyynCimASxlTmVGeC/OvACilKygxmjOccSZLl1emmWoi1Uy9RQStKI3Sjz7QNHwWqajiI+cbvKeSIi+qsza8TJOeagEy5MVpcBw1pcgI+hKk4YysVXhHbfFXz5WTj6M16tG+DUixKgribjr6ZTeorQ7+K+5dlH7e/oxcteU34riN4mS8YYAVmt0IIXobT1RTwwKfOVpH55T+Do6h7knUar/CA8a5Iy1zEV1D91GptYHYE3lQ931bGP2H1PRLVUCCw4XmgJhuaFaa+1dke7zGkCKarcVRNlCWwfuAnRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:58:02 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 09:58:02 +0000
Message-ID: <6ae6a52d-63dd-4216-8736-26d8caa91bce@cherry.de>
Date: Tue, 21 Jul 2026 11:58:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] spl: Use CONFIG_IS_ENABLED() for LIBCOMMON_SUPPORT
 checks
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-12-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260708220540.3368825-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 521a933c-4e16-484b-0c52-08dee70e8d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: OFWabtMc1t6zpRgqYJqXztzifbDmY6qXgda/TX4oohRx/gNIbjw3Vzd7cxwRGodqpAiDjXk5lah7flocur+5qBXbyTET3lcFXOpuZQCGDPBk3ZdboK1NebQ3hCqCYXjx3FBgz5frJjyedL0yyTH4KvO/wMnfSAxY1ifPHuNYFjv/xkjnnUNVZFk/B556LwS2Idbp2UbuvywnzKGWrnZWJth8nwm33iteCscP2MRlddH588xfHIs7szDXjzawruif1gfFwoeysQaW5ZmCbihq6jQ7eI/KDsbiMoVPmF4kVn4YAM+yb6QIQbu1k4DipoGDzRrcbTFqdQpkrxZgjbccyTciD+T7AFm+Tbxw3E1YhqPB2Sk08giGDw4EljfaQivQ5XPdAgWUPFB1cjOo5WAhOIAwv1PTeWWdpV4kQ7lGwFEUIAlfda9ZgXViF2ymEumJG5O1IyNabxkeBjXLdSpyR+U+Dzk/OR7Ez0mXyaLKQFKnXhJFSp4jNw7eYkludxeK7KmXQ7Ccszy3VhMLQJxF+aPjXeXnscqDnrVDxGwPKB1QLmg1jfwoZAtLtTPZf0GdlT+jLjfIzLihHLvqlJVuZ9qoC+9Z3A5XZ5OCnbOuRZcw/IWgefBF7Sy8MXesnMdGnTgVTg0wzN3Mw7UdGSjntCMj72nk9mhJly8sok1Obao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajk1cGFzc2hjTTJhdStMK2VNNDV3OTl2OWhQb2ZhVE96VnF6cWl0b3hrandv?=
 =?utf-8?B?Z3hzalRTWWE5N3BRRGgrR3MvK3kyNjNtQ3dCcFhRUms5M0NEMUVoWU1DL3pZ?=
 =?utf-8?B?SDVLOVJZUmhsUXRsOEY1emNMcGRlK1VTM0QxUnVpbXFiUkJuKzA5NlU0N0FI?=
 =?utf-8?B?ZFhneEZjVDdhdGp2d1BrOHE3ellUczNBRjIrektBb2g0RmdyV2NKVmNJVU1x?=
 =?utf-8?B?TzNGeDJPZXdScktRUHoxb2piZnVKQmQwSk03WUlwSk5peEFXYkRCRGNob09G?=
 =?utf-8?B?UTM5SHVraTZxSVR0WGRRMmxKdVp5QmgzTlpXelhNM21DMGJ4VVFicHFNSGZm?=
 =?utf-8?B?K0tLQ0cvTnZYWS9QWWVCNlJqc1hTTTNLaklVSzdsNEV1amJhc1ovaG5kTjRn?=
 =?utf-8?B?UEpWSU5icHp6cmg2aGRsVm80UXJiNzRuYWs1c3NlM0V1ZjFuMUt4ZGMxaWo4?=
 =?utf-8?B?S29jdnpmWGJMcmJYajVsYUptak5EZFJaclpJTWpUdUdINjVSUzQ0K0ZOb01E?=
 =?utf-8?B?bTI5YTJocXMzVUJwaGpOOEFSZnY3NkhBMmQrVS9Nc3RsdWNDanArZVhEMXVY?=
 =?utf-8?B?eVdrNm1NL2JnUDVhUDQ5SzJPVXJ5SFdFK2dJMktPS2NmUEgrV1QzZ1lPeFdp?=
 =?utf-8?B?RWVJcnhJVE4vSnBQb1JhMFZlMjFUZjcrK24zalVzYllDdWcvYVllQ0lML245?=
 =?utf-8?B?UVV1QXpPUE1KTTRzLzY2QmNWNXo3ZjJBTHVuaWg2eVZENWdGTk5GRG81Z1hK?=
 =?utf-8?B?OHBkcEtnRDU0WjNKUi96SndkWmp1THVCK0Q4ZlAreTRnRXBJVkxSbzE0SkRE?=
 =?utf-8?B?YWZrWjZvT3o1VFdYenhkUThKd0p4eTZRT3NuZDZ2VEpUZVhWM1NVbEx3T0JC?=
 =?utf-8?B?YytJYmRvNmMwUTFhUXFwV2MzOThWRGRTNzJkR3JJaUhtYm11a1NHaDZzckJO?=
 =?utf-8?B?OXRHaVZ6MWRxTG9iZHU3VzYzQ3lJUWR3UC9YbnVkS3VXamg3b21PMUJvYlRX?=
 =?utf-8?B?N2dXQlcxOUx1aEIrTXVSTWhlSGIrSFJTc0RjYUtkL3ZhcnV2WUU3eXNIT2Rp?=
 =?utf-8?B?Q3FzWSt5ZzJ4OXVlWmNuYlRDVmV0WlNEV21PZWhlNUdLS0pKZHVqNWY5bWxW?=
 =?utf-8?B?Z3hmZCs2UzRKTlVKeXkvWEZhK01YZzdLMHdnREJXbXhpckgxMDlrQzhXTGZ3?=
 =?utf-8?B?ZGVLWmVaRy9FY3VxdTluYWNHMHd3MGhBbUVEaTF5Zm1XT0Radng5bWVyak9J?=
 =?utf-8?B?QzdaUTRIZ0NZRnJGL2ZDaDZNK2NDNTJJa0kycEYwMCtEMEhvY1dVVUdCbjhJ?=
 =?utf-8?B?T09YaXR3QmU2SjhmRDZoRlBkMG5ndUYrcEpkcFQvY2paN2ZZdmljWm8xOHVo?=
 =?utf-8?B?eWJFcmp1a2tJYnpJK0owODZpRkJYdzM3RGRWV2NOZGExcmRJYjM3WkdDSmdK?=
 =?utf-8?B?d2phdEtvalJ4cVl4MVdaZ2lIUW1WUmRQV2YwMkd5QW9EU3lqTktXNzI0R2FP?=
 =?utf-8?B?THRQdEhLREw0T1J6VmlaNzVlVlRYcWpTMG9ENldLMTkxbG5Ia0hBSkNQbjZr?=
 =?utf-8?B?V1dzcFlYc2s3ejI0NzNkM1g3SDFZbVRlc0NwQjdkQW01Umg4VFRYR3ViUFBo?=
 =?utf-8?B?aVdWQXQ5Y3V6NzR0Tk5FcjBaOFdKNlh6d3VLMm8xdmJYcHVqTTBwdTEwQXli?=
 =?utf-8?B?dEc1RlduTXpnU2xvd1pqa28vUHQ4bVBhUEZWdXdWdEV1TXNjVXl3RDhWRFp4?=
 =?utf-8?B?dW5uWElkemdSRkZ0K0pxcHh6c3d4NXhPOEt0R3JGbmpuZzFpQTg2V1BvQzZt?=
 =?utf-8?B?Wm9lSW0xR1h5MGRsWWFaRnNrT3NOU21VVlB3TGhhZGpkMFQxUGR3UmJtY3hI?=
 =?utf-8?B?bFZNV05jczh3aVNYcWxkWjZ1eWZsWmZWMjNlT0JKOXcvZ1Q3OHBuamJHOG1E?=
 =?utf-8?B?RHppQkJWRWJ0REJYVSt5NW5mSUJMVTduaDBOT1RlNEZ1aUhBVEQwY25XaVI0?=
 =?utf-8?B?YzFRaldxM0xEWTJ3YzROSGt0a0FLQzNlR2REQ0hFNGNMWXl2TG4zR2FaampP?=
 =?utf-8?B?Tm9PbklPWHBBVXEwdTUwUXFTSmI0RnRFV29LRklWMkE3NTdYRDdlL09xUE5W?=
 =?utf-8?B?NGl2ZTFDRDV3WndrMXdtN0gyQ3lHZ3J3TWM1Y3JFTzduMDV3S21PR0RzdUxT?=
 =?utf-8?B?eTdsL2EzZ0ZuNGd5b3Y5aXQra0w0VysyQzU1ZjBpY2xIRUc4VW5HY0N3elVx?=
 =?utf-8?B?amVlMjMzcmtybXpQcUY3QTBrVUVwbDlwREhxQU0vakRUTVJ2TnE5T0svRTBR?=
 =?utf-8?B?SFVvdDNVdTgzSGFobGFIOVdJR1NmRkUzZ3JLWGF2ZEtDRGYyN3pVUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 521a933c-4e16-484b-0c52-08dee70e8d6e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:58:02.2501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pB0KAG/vw7K88Dwo+kG7LIevZeg8wynOaDEwXGuZI8DaBbm4nkHHx++su/4vTPL5XcSmnW4Mkc2nfuzlWpjstArfs+gZg2UH0klQWyfLOmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPXT8S/t7ZHh0ldSwgLo5DBp0R8qEH5ORpjfAcb7uIY=;
 b=m+03EBXAgOy9KnyDNz86BOFuk5TSOyBP0sRA6ytpiK34VIlq6mYbAOoLQVNvhezIZ7F0yn023KJNt6Xf0PlfJMIF9j7lM5BEIe0BsmmZgGx1icMptTm6xVGUEm57YzR1YnUVudc0Fh9tvNg3NF2/lVPYpT5F5cmaBMBb9OIMyeg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=m+03EBXA
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="m+03EBXA"; 
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

Hi Jonas,

On 7/9/26 12:05 AM, Jonas Karlman wrote:
> Use CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) instead of directly checking
> CONFIG_SPL_LIBCOMMON_SUPPORT when guarding printf/log calls to depend on
> correct xPL_LIBCOMMON_SUPPORT symbol. Also change to use IS_ENABLED()
> for the XPL_BUILD symbol checks for consistency.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   boot/common_fit.c        |  2 +-
>   common/spl/spl_usb.c     |  2 +-
>   drivers/mmc/mmc-uclass.c |  4 ++--
>   drivers/mmc/mmc.c        | 16 ++++++++--------
>   drivers/mmc/mmc_legacy.c |  4 ++--
>   include/spl.h            |  6 +++---
>   lib/hang.c               |  2 +-
>   7 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/boot/common_fit.c b/boot/common_fit.c
> index fd434fe28e19..9dcec1cd7d7d 100644
> --- a/boot/common_fit.c
> +++ b/boot/common_fit.c
> @@ -53,7 +53,7 @@ int fit_find_config_node(const void *fdt)
>   	     node = fdt_next_subnode(fdt, node)) {
>   		name = fdt_getprop(fdt, node, FIT_DESC_PROP, &len);
>   		if (!name) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)

I'm stuck on this and cannot make sense of it. I understand we don't 
have a CONFIG_LIBCOMMON_SUPPORT and we may want to printf in proper 
anyway...

I guess the issue is that if we use 
CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT), we will not check for 
CONFIG_SPL_LIBCOMMON_SUPPORT in proper (which is incorrect but what 
we're doing today) anymore and thus the printf won't be compiled in.

I'm thinking the right approach would be to define a

config LIBCOMMON_SUPPORT
     def_bool y
     help
       Enable support for common U-Boot libraries. [...]

and replace all

#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)

with

#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)

I'm assuming we don't have an issue with TPL using SPL_LIBCOMMON_SUPPORT 
without TPL_LIBCOMMON_SUPPORT as it won't be able to link due to missing 
library support in TPL?

Then we can simply replace the above in boot/common_fit.c with 
CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT).

We may have an issue with
libs-$(CONFIG_$(PHASE_)LIBCOMMON_SUPPORT) += boot/ common/ cmd/ env/
in scripts/Makefile.xpl as those directories will already be in libs-y 
via the root Makefile for proper?

>   			printf("%s: Missing FDT description in DTB\n",
>   			       __func__);
>   #endif
> diff --git a/common/spl/spl_usb.c b/common/spl/spl_usb.c
> index 932da56ab6db..365d57063c9d 100644
> --- a/common/spl/spl_usb.c
> +++ b/common/spl/spl_usb.c
> @@ -31,7 +31,7 @@ int spl_usb_load(struct spl_image_info *spl_image,
>   	}
>   
>   	if (err) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
> +#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   		printf("%s: usb init failed: err - %d\n", __func__, err);
>   #endif
>   		return err;
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 698530088fe7..ffb5e9800fb5 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -318,7 +318,7 @@ struct mmc *find_mmc_device(int dev_num)
>   	ret = blk_find_device(UCLASS_MMC, dev_num, &dev);
>   
>   	if (ret) {
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   		printf("MMC Device %d not found\n", dev_num);
>   #endif
>   		return NULL;
> @@ -390,7 +390,7 @@ void mmc_do_preinit(void)
>   	}
>   }
>   
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   void print_mmc_devices(char separator)
>   {
>   	struct udevice *dev;
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 2e5655606564..f24a66c389a9 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -328,7 +328,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>   			break;
>   
>   		if (status & MMC_STATUS_MASK) {
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   			log_err("Status Error: %#08x\n", status);
>   #endif
>   			return -ECOMM;
> @@ -341,7 +341,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>   	}
>   
>   	if (timeout_ms <= 0) {
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   		log_err("Timeout waiting card ready\n");
>   #endif
>   		return -ETIMEDOUT;
> @@ -483,7 +483,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
>   
>   	if (blkcnt > 1) {
>   		if (mmc_send_stop_transmission(mmc, false)) {
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   			log_err("mmc fail to send stop cmd\n");
>   #endif
>   			return 0;
> @@ -534,7 +534,7 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
>   		return 0;
>   
>   	if ((start + blkcnt) > block_dev->lba) {
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   		log_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
>   			start + blkcnt, block_dev->lba);
>   #endif
> @@ -2769,8 +2769,8 @@ static int mmc_startup(struct mmc *mmc)
>   	bdesc->blksz = mmc->read_bl_len;
>   	bdesc->log2blksz = LOG2(bdesc->blksz);
>   	bdesc->lba = lldiv(mmc->capacity, mmc->read_bl_len);
> -#if !defined(CONFIG_XPL_BUILD) || \
> -		(defined(CONFIG_SPL_LIBCOMMON_SUPPORT) && \
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || \
> +		(CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) && \
>   		!CONFIG_IS_ENABLED(USE_TINY_PRINTF))

If we also add a
config USE_TINY_PRINTF
     def_bool n
I think we can remove the CONFIG_XPL_BUILD check since 
CONFIG_LIBCOMMON_SUPPORT and CONFIG_USE_TINY_PRINTF exist in proper?

>   	sprintf(bdesc->vendor, "Man %06x Snr %04x%04x",
>   		mmc->cid[0] >> 24, (mmc->cid[2] & 0xffff),
> @@ -3028,7 +3028,7 @@ retry:
>   		err = mmc_send_op_cond(mmc);
>   
>   		if (err) {
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   			if (!quiet)
>   				log_err("Card did not respond to voltage select! : %d\n",
>   					err);
> @@ -3083,7 +3083,7 @@ int mmc_start_init(struct mmc *mmc)
>   #endif
>   	if (no_card) {
>   		mmc->has_init = 0;
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   		log_err("MMC: no card present\n");
>   #endif
>   		return -ENOMEDIUM;
> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
> index 8f8ba34be717..d29c611011bf 100644
> --- a/drivers/mmc/mmc_legacy.c
> +++ b/drivers/mmc/mmc_legacy.c
> @@ -44,7 +44,7 @@ struct mmc *find_mmc_device(int dev_num)
>   			return m;
>   	}
>   
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   	printf("MMC Device %d not found\n", dev_num);
>   #endif
>   
> @@ -93,7 +93,7 @@ void mmc_list_add(struct mmc *mmc)
>   	list_add_tail(&mmc->link, &mmc_devices);
>   }
>   
> -#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   void print_mmc_devices(char separator)
>   {
>   	struct mmc *m;
> diff --git a/include/spl.h b/include/spl.h
> index 45dd44e03d13..98d1a8fda409 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -792,7 +792,7 @@ struct spl_boot_device {
>    * @load_image: Function to call to load image
>    */
>   struct spl_image_loader {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
> +#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   	const char *name;
>   #endif
>   	uint boot_device;
> @@ -809,7 +809,7 @@ struct spl_image_loader {
>   /* Helper function for accessing the name */
>   static inline const char *spl_loader_name(const struct spl_image_loader *loader)
>   {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
> +#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   	const char *name;
>   	name = spl_board_loader_name(loader->boot_device);
>   	return name ?: loader->name;
> @@ -828,7 +828,7 @@ static inline const char *spl_loader_name(const struct spl_image_loader *loader)
>    * _boot_device is the BOOT_DEVICE_... value
>    * _method is the load_image function to call
>    */
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
> +#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
>   #define SPL_LOAD_IMAGE_METHOD(_name, _priority, _boot_device, _method) \
>   	SPL_LOAD_IMAGE(_boot_device ## _priority ## _method) = { \
>   		.name = _name, \
> diff --git a/lib/hang.c b/lib/hang.c
> index f3c3c896f0ab..42c5722740a3 100644
> --- a/lib/hang.c
> +++ b/lib/hang.c
> @@ -22,7 +22,7 @@
>    */
>   void hang(void)
>   {
> -#if !defined(CONFIG_XPL_BUILD) || \
> +#if !IS_ENABLED(CONFIG_XPL_BUILD) || \
>   		(CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) && \
>   		 CONFIG_IS_ENABLED(SERIAL))

If we add a CONFIG_LIBCOMMON_SUPPORT, I think we can remove the 
CONFIG_XPL_BUILD check since CONFIG_LIBCOMMON_SUPPORT and CONFIG_SERIAL 
exist in proper? I do think this would help make things clearer in 
general. What do you think?

A bit of a tangent, one of my biggest gripes about U-Boot is that we do 
not differentiate symbols that are meant to be phase-agnostic and those 
which are specific to a phase. I'm thinking we should have a PROPER_ 
prefix for symbols that are expected to apply to U-Boot proper only. If 
you have neither xPL or PROPER prefix, then it's meant to apply to all 
phases. But we often have mixes and it's difficult to know what's 
supposed to be used or not. I think it would make things much clearer as 
well.

For example, we have some ifdeffery in lib/Makefile around 
USE_TINY_PRINTF which we wouldn't need, had we a symbol for the proper 
phase (which can always be n/y and non-selectable by the user), then we 
simply can remove a bunch of ifeq ($(CONFIG_XPL_BUILD),y) checks.

Anyway, nothing required for this series and likely a big rework that 
may not be worth it in the end.

Cheers,
Quentin
