Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71F1C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A2BE40719;
	Mon, 20 Jul 2026 18:25:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gYgCgYr6Y7NK; Mon, 20 Jul 2026 18:25:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E14040649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571925;
	bh=EeSc52aNQ8Y1HXGVT9jaodhPlFslKKRVlkoOUQ7jM6k=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RzC9SzYZ3kUfslzH3rOBJmTGR7JZunr0hBHXcO04L73pFWKg/e4tuIWNndLaJ9djS
	 lP8J9XToeWdWFzqKZx3xsE1SrlZ6fj5UKC7ou88oOSUm0Jx+eaZWVq+JuUCS/sd/7a
	 lCuy7NfsEHtChdKc7fKf4VWJOW8Qpb81giIbw4fcfTzcKGBLCUj2scyLxCVKjcAKM2
	 Au9ux3+Yrt6ky55CWyigWtfDlpv90J3fl1yAGNbKEZQ4ce2gKy4C0EhmEpURrNsVfx
	 ZC94SppNMpzQH/vYu6fHhhfue+JsDFLt+eq0gN3gplJCwgZ/cDSrjQhaZkj8SsQHEF
	 9LgJkN3docvmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E14040649;
	Mon, 20 Jul 2026 18:25:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF8A042A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E094080D1D
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GX8en8mAfL-z for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:25:23 +0000 (UTC)
X-Greylist: delayed 2396 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 18:25:22 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C394580CBA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C394580CBA
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C394580CBA
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:25:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C65846A5; Mon, 20 Jul 2026 20:25:20 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05251844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:25:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcOMIbaWWetN1zZ8bM77GP+GXaKdrXF1oLNh5LV9uUd4NJ4Ss/aO0vV1bj1H9Xz7FjPaWfDKIW4U0miFfQsLElBOAR/kqzYn5ZW+OOPDvM8WxJlcj6KWTmbnonLPjtaQys4cCc4x8ijUFhlf2mGBqC02Ds8SRzuS81w6hoqwVYArmH1F0cPX7yzkcZxN7ZDH3bGzztpe0qDxzUdqD3HHWAvzkkIaI5Wq6wLiTU4fDW+rESrOztrYAc33M0suClHExwSBRcsWOIiUUhPwyL4K52gkaiGxuosk7Ey0PWoqed3i5SJ6eJKEtJfUVD8mHflR6xxRzldpEuJguEc+sjOoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeSc52aNQ8Y1HXGVT9jaodhPlFslKKRVlkoOUQ7jM6k=;
 b=jZOQQ3R6h0JMAXy0xuwTKEEL/0N3hylIouyC5CVEIm8XhePO4aVqbq82d3tCf8dwUyBg5S36SkFVWx6RY7j6D4oJwjIxT/o0y3iI+PJsj5VheXuGgDWm4B5jYn2rWBbduo04jE3QMfluZ8S+wmM4Yvmpflp/wyeFjzsqmTMyGiC7r6Z/ZFvp2gpUJ1Z/jnN/EP7wiUxGAJYhpXeLRGz/xyRC8Ai/LhkRbc0grgnQtdGr96qAATznziy4nE0NGXlIh7VNrI39/AwhsIECAinWAZf9YhGXGJdAKYq8aH7qs5bwtMmrDeQqbaxU/gvwiKzEhOh9hVUtUJ3MqU3Mi3pS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8730.eurprd04.prod.outlook.com (2603:10a6:20b:43d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:25:16 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 18:25:16 +0000
Message-ID: <e108fe69-533a-4734-8728-b17b172c4be9@cherry.de>
Date: Mon, 20 Jul 2026 20:25:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de
References: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
Content-Language: en-US
In-Reply-To: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0150.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f3b4c0-070e-45b0-5471-08dee68c3e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: stdZyuqNx5e0e+jFI52Va9PGKpVhXFjxZy73eo+SP4P/2pTF1HoF3xErX4O74HtguKyWXKnSdUwmMxneR3YnwZh+xQRpvhbhot+Sxx6+Ue+xmJqVzVPNZkXfDq+0TnYfYW0kztDcWaFcC/U7YnnRsK+EonkWSRDI9MXQY6OiOocaSsgHLiFDBZK0K5JyOI4sG3ca9UYAGUnAjvIMS/sV9I9Hf1H+JzARLjvYDWIoga6wZ6gpa1sVKt7p1RTljqFFZ3UOV6FF6Qt3pjLVz/6OWYV8CmO2zqOa7LVUfKSP7A3MnwemG3ZGdOFV2miarKzL1pm/n8a2nir8NTcfoiNO2QUixcoXJ5NVaz+sdX6I5LeUthVPszkUuw0YudQUJ605/JU7Wa+6wm0jHPpHJzFd43XE1YAoctF77LGVC5i/86ghNQSs3x4FNeGOfudq9MHg/AZWqxUhHjlCcOP6ifLbH7ZatwLIHtFUA/grGLSUW+MORAGxRDIyvGWaQgLEaLFgJDrLEiBYkEpq3QRtC/npmvmrbovfSWbPqwHNPGvYj6wmbaArBhtuN7I9ntFRpMrj8Ohuc87QrXvFjnYg6SWbgeXhWB99rZemIdubOWtzNf7P3crTLaaCYpZjfd5AD+j7cxuC4RbyXNKTsLSAR8E09v4oqVJhSJmPYrx2dLf8irk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlHV0ZCU0JCMkpBUDdqejJYOHc3Z1dNMUE4S254VTl5VkdqNU1ya3M3OWhI?=
 =?utf-8?B?b2NnNmJYdDNka0x5MnFubEVPWDBnUDNrRW5Bc0F3N0pDYzI0bE56NnkzaWhu?=
 =?utf-8?B?c1lzVUVoTzQxcG53Z296MlFpQkovbGJuZ1ZqNlgrYlJFOGg3cXEzZFFkTUtH?=
 =?utf-8?B?T2ZDc3VjTVhtdzhPL2dhRmtuemRyWU1wUFQ3d2ZWRDJ2WnVxWkRzUEpZUVZF?=
 =?utf-8?B?TXJUbVF3eEdLcWZNMitUa2tGOERjanVhMnZsSDJEVzkxOThWWDE5WGdHZkZ5?=
 =?utf-8?B?N2pWbklTdWsvRWYzY2dOWDdoSVNONW1lZ2hBWnkzbUJEMzB6Zjc2UFp0Wndw?=
 =?utf-8?B?a043bUtrNTgyWmZTWEFFbUdibEV3Sk9wSFlBRTczVnhMZmRqSU5Qa1JSSk8x?=
 =?utf-8?B?bTlzdUhkTFg4M2ViMlBybHMxTVFvczBtWHk3a2VzY2hUbmFYdEhHRFNyeEdk?=
 =?utf-8?B?bEdhK1JpQWpDNzg5TkxrTUpkMWcyc24yTkgvK0NIb1FXdDFqK1BTV0w1bCsr?=
 =?utf-8?B?cGptdkJIdnA4ZldEZzVqc29NL3JXOGVEOVhyWjlxTlVsd2FuWlBDUUg0bUlN?=
 =?utf-8?B?b3V6bWI1RE01MEhEZDJKdzNwVzNRcWs0aVRmUUJ5cmFZSEJQYmIvTFQzeTRV?=
 =?utf-8?B?RVhDTlJENUJJZm9hQTVpUk1XT09zVlFWMkN5Sndab2p0VDdPZUw4Wk11MkFX?=
 =?utf-8?B?R0QwZVNtam8xdWZtaysrWElMNG1kaThQNGN6bG1xcUZrZnBtZlBVdHE3bWlI?=
 =?utf-8?B?bVByS0FWRTZVcmllcDkweTVOSVI4c29qd0lGQkJjcVF4dVZSVE9pQS9KL2w2?=
 =?utf-8?B?bDF3K3BpSnNvZUk3ZitDNklCTVd1OFNTTkNBSnhKRzlQWmFpT3I3VXhwR01O?=
 =?utf-8?B?RzFKZGtNWkRjRkk5Slk1Zk9KZUJzcVBRRXVieHRxSzdQSzdITzB1dG1UMlo0?=
 =?utf-8?B?YXZZQTNUL0tSYXNFeEkycUo0TU1jc2lIRTZpTnJGWkMwelJSM2o3d251dHVE?=
 =?utf-8?B?bWRRZ3F3cWYwUVNPNTJFWE9qall1R3I5UDFoM2RjSXR3Tnd4c1VFWEwvckMv?=
 =?utf-8?B?aUpIQlZTdWw1emZ4emY2U1R2Nlc1Yk1JMFNSSTVBR1E2QUlTMTR1TXR5VUg4?=
 =?utf-8?B?bC9JeWZFSG5VS2FIWnovSE11cGoyQkg4cTkzaUxlQ3ZQL29oaHRiV1FEblNR?=
 =?utf-8?B?b2liZGxzTG45cGlqaEpibUNUQTliSDMrR0VRdnZBTUhlMUtWL3BzUFIzMVAr?=
 =?utf-8?B?NitEVXd6a2VnZmM4WUNvNkdJZmZwanNCUEM2UjBkRXNzRWRIRVJzNVFVc1ls?=
 =?utf-8?B?ZUpsTkJXWGJvZ20yUE95Vmw0TVplRG1pRVlHNFRUTUZxQ0preGoyNmc0amtL?=
 =?utf-8?B?WnlCVXFwQ0taeW11cVk3WjByL210b2Flbm9tRHJURnNEZGhVRDFEd2RwTkM2?=
 =?utf-8?B?R2lrTU5XVTJJTE5MZ2k4RURoR3MxY3JQUFZMNEJVa2NqNHJaWVkyZ0x0Q09W?=
 =?utf-8?B?cWFaMWtVdUtjM1ptUUxqSkdFTjRtZ0VUem9NU29WRFpMaDRFLzdWdi9uZ3lK?=
 =?utf-8?B?TUE4WFV0UVJjY240bXhkTzJsWi9mTjNVeDlwNkQ4RHRWQ2JWTUVSdkJjQTkz?=
 =?utf-8?B?RGx4eTZjN012TmluWjZLOCtwWTVMUnYzN28rejlhTFFBWlNvRS9IZGg3SUhH?=
 =?utf-8?B?V1VnUGJSVnJWM2UrQWI3dUFVZDVoMmVCTytzcFR0dGVjdi9YNzdFVStadXEv?=
 =?utf-8?B?ZmxmdXRjcDZQd09RQXJoZHJQRXRsRHlPYmJxWWJ6bGpDejBDL21hTElXVHBt?=
 =?utf-8?B?TCtlN2FvblIrTS92MWFkSkYrbHZqWkxiTWdzQjNTbnVMaSt0WmFYa1Racjdh?=
 =?utf-8?B?dWRZbkpMT3pKOXVCa1VPVnU2MlRMNEYrTzhSZFRsdlFrZjg2dytvY2svKzgx?=
 =?utf-8?B?RE5oRjJGVDVvMHBwUmF0YmZ5SktnN1BsMnMvSTFtQ3pvZXFTc3c0cXhtd3Iw?=
 =?utf-8?B?d3JHV0RnUndwZnRHR0I4WEZ1U1Z4bU85RzVNQ1FUZ0Y0SnFtNDNpK2U1c0Z6?=
 =?utf-8?B?VXVtVkVHbnRlSURhcUxyQWpITDZhWG5TRlIzQmxRK1BKUjJrV1E2ZnVwdnBL?=
 =?utf-8?B?UGtnSG1ZYldYdHBrbURBMm52VDczQlVBb0lYaENLbFNMZkNvZFhLbkpRbVp0?=
 =?utf-8?B?czF3azZvazlYZnZXUTFqTjIzczhOc0hJY01IQk9pTXFKckl1WDhHK0pMaXd6?=
 =?utf-8?B?MUZ4NGtET3VEdzlpQUlBTC90OERKYURvSzBYaitJRlQ2aVMvWW1ndEZkTlho?=
 =?utf-8?B?Qlo3TlA4Q0Yxa2h3Y2MxNGxObDg1WThYSzJUWktsL01NTjMycHYrQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f3b4c0-070e-45b0-5471-08dee68c3e3d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 18:25:16.3852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D73xM64yQn1F5VxZejNWaDj4kop0aqlsDSqYy/jbp9owoS7lP9772Rvam043wqwEOfpBAPSk5Z1Za6tlv5VjqQTEpqcgQli6AF79aVcrwCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8730
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeSc52aNQ8Y1HXGVT9jaodhPlFslKKRVlkoOUQ7jM6k=;
 b=fCdY77n3nyyrXMbeiDqvCgTC9QofNTSV63iS6UDPMpv0TLKLK4gp+iuHqUTr20yyirKYqMzWZkAyzG710k/cuSF4BLSC3qx38mvbMV5pHnH0/RXhRsiXIjbjbajyC7E10h3SpP98191WKgGdRYLVbbuekmIbb+lRwJPoc763cZE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=fCdY77n3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="fCdY77n3"; 
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

Hi Johan,

Resending because the ML rejected my mail sent from my other address... 
I have to figure out what I set up wrong to trigger the spam filter :)

On 7/14/26 8:39 AM, Johan Jonker wrote:
 > The Rockchip boot ROM only checks for NAND chip 0 and with
 > reduced ECC strength. Currently only the read page functions
 > have this condition check added.
 >
 > Fix by adding the same condition to all read and write page
 > functions by dropping the existing 'selected_bank == 0' check
 > and use the NAND_IS_BOOT_MEDIUM option that was introduced to
 > U-Boot more recently than this driver to behave
 > identically to the Linux driver.
 >
 > It is now the users responsibility to apply the device tree
 > property "nand-is-boot-medium" to only NAND chip 0.
 >
 > Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and 
others")
 > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
 > Tested-by: Hüseyin BIYIK <boogiepop@gmx.com>
 > Reviewed-by: Simon Glass <sjg@chromium.org>

You don't explain how the bug can be triggered. It'd be nice to provide 
the usecase when this is an issue so that other people looking on the 
Internet for bug reports could somehow stumble upon this patch.

I'm thinking the issue is that we currently verify all NAND chips use 
the boot_blks and boot_ecc from the boot medium whereas they might not 
be used as a boot medium (they are missing the nand-is-boot-medium 
property) so we cannot actually make use of them. Is that correct?

Considering boot_blks is 0 if rockchip,boot-blks property isn't set, 
we'll never be able to meet the page < pages_per_blk * 0) condition 
anyway so we would never enter the if block... or can page actually be 
negative????

To be clear, I don't disagree with the fix, I just am missing a lot of 
information that should be in the commit log.

Cheers,
Quentin
