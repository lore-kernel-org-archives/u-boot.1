Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F706E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 09:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8C88967A;
	Wed,  4 Dec 2024 10:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1862389534; Wed,  4 Dec 2024 10:45:13 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazhn150130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:dc0f::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DE989685
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 10:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacobe.zang@wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNhjDjDihaOynZscl/fBoM/dLZQXBdpvOU6M4wc3lWmj9qyKyb2XlbbniX8Gylo8ut/4F00YaXNNLodly64O6qhDANnDuyLao8tSP0R7d0JUZO0QNEW4UCWPflnsHeCI6znl2n3caM5w4iwqHnjtbgJOsRt8+6grPPct7hdoyTCO5Toifcdu0cEgps7RHnQSN9Rda/3cXiLIM/20ehq0lLtTVsywRsoyv3HuT0hvEIvP8srFb6K4cp3mZSqhKDh9Fti0YwOKWvo/4iCBNUuTIsTH1slWW2HxJV0MDU37LfJs68u7DMvV7WxE9lbLg4qspx5JCRyseplQ8NiO/nzg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8hBj/Btjks2FKFPmQ2HuloEQnDZEwWPEhcBsXg3XwI=;
 b=qHE7pR6vobZM+BmUGNtHW5wawGZzuMgSrYSaQiYDYtukvotSGXpMLuQ077Tjr1scj/YvN49iDeDWB5BnFJSfka/LQZanfG8Iwwn8uzXJSFBVJEYEa+nL3hQxVUx0wVv0CVRJ3XgqG2rJjBTdJ/9whZQAZTaPXKhXZMKvx75x+JAw8nRNobjomnce+uLH6/ggwn/8RFjUdNmLaQrxwQyOkKyEhgfCnyBZvtCkp+rLrGhEWMBW4PYnaK98StVZELQ/JHSbuZxGULarvuSH0XSKJtNnJMabHBYU1VzYsCdA7Uu5eKyqquKY05RQOeOTRfn16oyMd0KRkn9Bcnbqebch6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SG2PR03MB6828.apcprd03.prod.outlook.com (2603:1096:4:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 4 Dec
 2024 09:45:04 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%3]) with mapi id 15.20.8207.010; Wed, 4 Dec 2024
 09:45:03 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 04 Dec 2024 17:45:00 +0800
Subject: [PATCH v2] board: rockchip: add Khadas Edge2 RK3588 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
X-B4-Tracking: v=1; b=H4sIAJskUGcC/12NQQ7CIBBFr9LMWgxDahVXvYfpYgpjOwuLAYOah
 rtLu3T5Xn7eXyFxFE5wbVaInCVJWCqYQwNupmViJb4yGG1aRLSK/cRG4YWcttRaTSPU7TPyXT5
 75zZUniW9Qvzu2Yyb/S9kVKhG1O7kz53pHPVv3s6PLjxgKKX8ADbu/wSbAAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, jacobe.zang@wesion.com
Cc: u-boot@lists.denx.de, nick@khadas.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733305501; l=9212;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=AYbdYuUDKLtRhpFhYMDHHHjR03o6QfjhO1oUxUwbknc=;
 b=ejSRES7y7GUAN9YrRRKWLwKQvnD0keed8jkjto55etPnIDXSPO+sdkzgYd6v3PlQuQsN0P1RE
 QUK0BsiT1E1C8WOAdwOGq2MkRT9Qicduu0GCLNjboqw/mUc0WNPLHzh
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SG2PR03MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5e026d-b99c-4680-b37d-08dd144853a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0YyQzR3K0ZBWUFaMGJZSGtVSnRyTUlmYnJneWJsa29IWkFTK000REtlL0d1?=
 =?utf-8?B?WDllbEtSVGRhTkYwbmRJazhKR1dYOGhlM0h3RVhWOGMyUHJzUGFObDY2WUls?=
 =?utf-8?B?VTNnSjV3R3kyL3hncmJhaEdYUTBvUVVtV21qbVlCMEVESHNJWm00TGhJdmZ6?=
 =?utf-8?B?UkEzNWNxWmcyakRLa2tjTHBVRXpMRXhtQTdVem5iRC8zRFlKY2lZK2dQaEJI?=
 =?utf-8?B?a0swZGJGOWM3SSs5Vkc5V2FwYW9ZaUxpMTVobzBDcjJ5VHBqNkZ4OU5aVFBR?=
 =?utf-8?B?ekRCbnRNd2t2b2NrQVBwYm8zRzhTakdURlR2NkNKRlhVUGlxT1I5ZTIxOVRp?=
 =?utf-8?B?MzF0S1JPN1Q1aCt1bkR4b2cva01pQjVWN2I2QVhpL2dZSjhvZTlSdGlEcmRv?=
 =?utf-8?B?Mk9nZmRYWEZrZ25FMUVYMDErUjNxYVRQK0ViNkEza2xLdVhBc0pRczV3OGwy?=
 =?utf-8?B?VjFXeTRxNnIycXFTV3p5Wm5SU095RTNRWFRMSFlQV0kzNGVPQnpYdkxLdmVQ?=
 =?utf-8?B?emNuc2tPT1VvU2NiTHRyTkI1R29ibzZ5OXo0UE1rSDVhU0R4a1NJeGJzU0ZB?=
 =?utf-8?B?bzVkM00xM3UvSFJkdWR3dkJUcnB1cHZYdHRoT2ZoaDgwVmRtMHErSFlPZEpE?=
 =?utf-8?B?Q2RHdTNiaWg1bXlGZ2VSdFVBNUh3MDVicmE2NWdJcnh5dGlmb0RCeXlxUFR0?=
 =?utf-8?B?dzRQYjNUbzUvbm1Wbk1hN3NjUG82Z2YwZEsxOU9SNVdMVWxtRDFGSWZNZWEy?=
 =?utf-8?B?QXd4dXpyTDJQRTZZTHBqM28wSVFGUlA0WWxpd0lhL0pwU2huZTF3Sm5ROTJH?=
 =?utf-8?B?R2ZZSGdzdmdHdTVUZTJsQnJiQU94WlEwbGxxQ2JQM25YbU0rS1VvcXdWUHZn?=
 =?utf-8?B?QnNNQWwzdEt5N212Qk9GZElsSmsxVm1qOEdkS21yd3ZyVWptbmFSOEdIazU1?=
 =?utf-8?B?bjlSalNBR2JCUEdycW9ianVVZGQrRmxQVEY2RlAyelpvbE1Xc1NLY1hwbkQz?=
 =?utf-8?B?OWswUzJxdW9STDFWR0U0dkhsaTZKT3JYQ0tJMHdUZ1UwZUxrTGNPNlM3Q3Qx?=
 =?utf-8?B?eDNENERYclVEbHA2aDVkNUNMNFdBd0tJaTMzOTFZM3crRnZBSlRtRW5mZ1I5?=
 =?utf-8?B?c2Vhamt5YldwckIrYi9YbmhyQ2svK1piazRQQ0FjOW9BOHU0NytoQjBxN2Iz?=
 =?utf-8?B?QjU3ejdEckxKS3BBYTJuc0MyUy8rVzI3cllZL3JlRnhEUi96VE5Jd1dzWkRh?=
 =?utf-8?B?UFBnUjdtd2ZqVWVHNUtvRkpnM1JpV3UyZWs3bERBZ1lYeEJPK29VRVZKbEVs?=
 =?utf-8?B?VlRsRmxhY3hUMDhPaXQ4YWhnZldRUWtEYngvdUw0RC9zQi9qNGQySGxoOWMz?=
 =?utf-8?B?TEFyOFVsZnFSc0pzaXhsbkVtOEM5UDlLWlpQVTZyZ3JxT05hU0kxY0NoSGwx?=
 =?utf-8?B?RzV0K3p6NGNnN1FJUTR6dWIwSXNsVEU0a0tuRjZQclZZTjZSYytQdG9zR1l1?=
 =?utf-8?B?SUptdEd6V0xYamxFckdaeVR6b29iRFpjWDlxY2o2Y0MzcnNaMUxuNTRtcXhF?=
 =?utf-8?B?Y09zSmxpUHppazFzRU0weWRSaWtNYjFqeTRlQThNUEhreVJONzd2OFFyUFBU?=
 =?utf-8?B?TzRkSk9CQVE0K1VBblRreFlOTTMrU2Rqdk1Cc0ZxOGdsK0pZVmNBQi9qT21L?=
 =?utf-8?B?YXZPbG80b1VRYzg3aEZ3S1lDS3YwQm96dW9HU1g1bEtUL0VMbGNLSjJMbmNJ?=
 =?utf-8?B?ang5NXZhN3FLSElQdEpFQlVsdDNzMmZYS1Q2L3pQR0dWelpDa21URFJEcktJ?=
 =?utf-8?B?YkdJQThBVEtOSVZTYTRFQ1lKbEs4cVhaWEhrdVlhZjFiazFpQ05TZTdPQUxs?=
 =?utf-8?B?OVdVa0d3RDh4d0VmWFBaVnVQa1NRdUwrY05ZZzg3Ylg4ZjFyZnNDYkg3c2ww?=
 =?utf-8?B?OW1XLzJaKzNHOGphbGpTTlhKclFpT2tybE1zWWppbjU3Y2MxTElnTnVMQ28z?=
 =?utf-8?B?ZmdhdUx2YXJCNzVpZG4xY015OG4xZDJXcUZhOVRtVzl0SHJVTVp0R0dLcmVx?=
 =?utf-8?B?aUQ2R3ZnMjBGakljOENIY3pzaVVzZVNOS1pGc3pEcE54NmRTMmxLdWxYaVoz?=
 =?utf-8?B?SGdvOUhvOXdITkhLdHRqOGFDSCtCcVcrWFczYXo1dkFQejBlZzl5UHNTYzZq?=
 =?utf-8?B?NzRCZ3IzZGVSTFRZenRPRjBNamxEOTFsbUNSZ0ZXYlVmSU5lTTcranp2blMv?=
 =?utf-8?B?UktCTHpXWCt4YlYwL2JGYjUyZVFzUjFhVUdKMGoxMlZOUXRDNmMvdUgvYXNa?=
 =?utf-8?B?TVEzd29FbVVyZ1h3c2Y0cktsVGxkQ3ZsTXRUMXFBalRYbHAySiszRlpWbUgy?=
 =?utf-8?B?ZFIyMENyNXBsbXB2WVlEYTFKRmJjTjJ2Rm52VW5kSWRON2tkNEpmTW40aENE?=
 =?utf-8?B?VUVQSVQzMlliSWFiZUVMSm9LRkhYaEtpZFVkRU1VdmM5QjJ6ZmxSc3dCTG03?=
 =?utf-8?B?Z0kyODBYVE14NFRxVkdCZ0FxQjVtVEcvRTNxV0FDdVhRMW5nVGRNa2dYUjZZ?=
 =?utf-8?B?ZnlLVVNtZHBrMENJYjZlcUF2MG41UFRiN0x2RUlwdDdObU80TThJbit4dm8v?=
 =?utf-8?B?eVp2VWNWTWlrYm95b3hkc2UrcEg2dEN5ZFhsQlkwRkxGNWt6NWJmQ3ZrR3c1?=
 =?utf-8?B?bnJzeWtqMHdTdVdaOE45Ym91MEQrRzBVemc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:5; SRV:;
 IPV:NLI; SFV:SPM; H:TYZPR03MB7001.apcprd03.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWp0RllsaHZsTGFOZW9KMmVGcUZGU3hLc2FhczFPRGVGYUtKaW5OMEFaSjBV?=
 =?utf-8?B?Zk1EQ0FLZFZRcERkeTQ2cXZyc09xZ0MyQk14RWQ2SzVwWG5jSllOWnVyRGI1?=
 =?utf-8?B?OGQ4cG5XU2dvdnlCa2krdFpKcnB3bzhha2hhVzJyRHRIb3h6MmNPN2ljNHBP?=
 =?utf-8?B?Zld4eFlFeTluVkppUGFQd2ZPZlM1YlBPOGlOODhmblBzbi8wamtYUWlDMTRJ?=
 =?utf-8?B?a3FJZGt3L3hVd1lieGxKRjBTTWNiN24yaTRQemo0UTF2RmxQVFFtNWs4QVBW?=
 =?utf-8?B?dDdiM0g5d3RMY1JEMy9yODNUMXQyb1dLNjZSMnU1RGhUMGtKZ29iMVBZQkNJ?=
 =?utf-8?B?TEFKb2lJak5QR2VwSHBNMWtLREVuSW5qNjgrZys0WXBnWlMrNDZzNmRtc0t1?=
 =?utf-8?B?RGVEdW1rT1Zaelp1VjQ2UTJ0M1hHRW1ZZnNoNCttNkJQTEpMeTgzUXJ5RDJS?=
 =?utf-8?B?TzBIZ1BOZWdtUWxYYytPVFhKTm5Gdm56UlBMaXdYblZPQS9abm5OVnYvWnpX?=
 =?utf-8?B?NE5vdzZPZmZFS1hjN2w3emJra0hoWTBrVlNacGZQa1UzMUFSYnZFRUF1aHdH?=
 =?utf-8?B?ZjNoWVpyNyt2bGxpdjYrQ3MvTlJPUGhVYUZLb3ZLVHRGWVdnVm8xMUkwbnNx?=
 =?utf-8?B?dXg2a1dZYlZ6MDkvSmNTamszcER2eHduTDBWbDBkcDA2U0JkSzJRRjFPSndp?=
 =?utf-8?B?UE5BVXZhNkNSMzdQTjlkUWhYaHdjQWQyNDhVTjV6aStpeE0veWJ3YVBIMmlK?=
 =?utf-8?B?NzNlb2ZmeHJ3VndJbzF0OU5YWnhYRkhKcnB0clBCTVF4dU5PT3dtSlB4eGQ4?=
 =?utf-8?B?Rk9hZUhjQXlyUG1TZkdRNTl3UmV2WjdvcWdyVkkyNWhCZ3FCdUg0ZTl1RmVJ?=
 =?utf-8?B?bnFnVmZYQzlsSWFITU12MXpnRzVpMEgyOXZ0UmtsUlpSbDlaTlp6WEdBS21U?=
 =?utf-8?B?bEQ3dWVvbVVMSEU4ZlBzNzNrUGo4MUl3VmlQU3lLTisvYWMvWitnQnlVRUZZ?=
 =?utf-8?B?TDRGVjVlOTRQcml2SUdhaWtFQXFuTllORmo4L3BLQ1pZSFFUdWJxZzhmcHVi?=
 =?utf-8?B?aVpnQ0hNVDY5czBlbzZheGRMUUlwNFIvL25uamJQcXdsV0xHL2tpTi8yNkly?=
 =?utf-8?B?QVVqK09peFAxeVVyOXhhdnpDV2tDNTdLVXZ0T0IwOWxWZ1EyM1hqM0lMdWhv?=
 =?utf-8?B?VmxMSFJPRTZkMTdDallXZzJ0cXVjNm4rRk9rYTNJcjlMQmJxaU1KNnMzcWhv?=
 =?utf-8?B?SkVhTXJRZkhHRk80Z1lCQ3MxTEJKa3BkR3Q3M25qNHVQL3lGRUI3SHMvbUZU?=
 =?utf-8?B?MFdqNm1zUzN6T2Z2VTY5RThQZ0VpbzFzMXQrcnhzMHVHdmlCSU9GOUJrY3N6?=
 =?utf-8?B?WnRzZEM4MDVCeUJXT3l1aDlsdk5wcU9KNVIyd2orRTZhM0JtYzRCREZGeUNa?=
 =?utf-8?B?eGRQR3Jwb2luak9YODlJWUxXWG5XcFo3eUVudEltTWg5S1ZPWFFsQ2tRSnVH?=
 =?utf-8?B?V1ZmNjJ0RXhzbTdEcXBXS2VCVzlCTjM5ajdjbUNJWDF2L0JIVWZXNXROWmJi?=
 =?utf-8?B?TUU2ZFZTQmRxZGx3alZmcnk5RnF3c0plY3hibWR2WUFBRXUwL0NFZ1ZpWVZj?=
 =?utf-8?B?dWlzMURIY3BVUmpaV21MY2dwY3lYRW5VQ0o1RkZUMmczUlJQSFY3K0wwTjZ5?=
 =?utf-8?B?a3MwcEMwdDU5VUVhaHNLczJkQzBDZ3ZScnlybzlsQysvaWdOa1FSTld5YUJx?=
 =?utf-8?B?aG1xWVVmRTd1VUNDZnNsS3FWWkhZSVVsVnhjY0VpUm0xY2xRMEx6QkZDOENJ?=
 =?utf-8?B?ZWpmR1FJNzJPUlQyVFFFb2EzNnFPQnRoRWxxZloxV2FvUzUrYTFCYlFMZGV6?=
 =?utf-8?B?VWx6amVVdDZJUjJRMk9DeTVLd083Sk52Sjk2MWlmSjhPOXhhVm0rU1BiVDlN?=
 =?utf-8?B?aHIvd21IcWNxNkF6TGJKYk5aTGU1Zmd2Q2FMREVjbGlOM0FEYm9VOWo5dEFL?=
 =?utf-8?B?bVBYeXBvUEE2NnRTSUdoenRSSG5DcnVSZDZjUlpTZlVLYUViYjd6ZzdmVWV5?=
 =?utf-8?B?TUFPSmszSkhnbC9VcW9WWmVHc01kYlJyVWlmZTBxQ05qL2RGSitlR3cyYXQ3?=
 =?utf-8?B?d0YwYUExVUYvamoxSGNOa1psUTF0Y0lKckxpRVA5UkZrWXYrWGJUWUJwWFFX?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5e026d-b99c-4680-b37d-08dd144853a1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 09:45:03.1234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N8dWh/AshagkYFiiojOzhwAw4pPVh5l0vzI0ailqqlNeaiZkjoTIS1wkpPzuXO9EMXrKnOyCvc1C665w2qaHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6828
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

Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
by Khadas.

There are tree variants depending on the DRAM size : 8G and 16G.

Specification:

    Rockchip RK3588S SoC
    4x ARM Cortex-A76, 4x ARM Cortex-A55
    8/16GB memory LPDDR4x
    Mali G610MP4 GPU
    3x MIPI CSI 4x lanes
    2x MIPI-DSI DPHY 4x lanes
    32/64GB eMMC
    1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
    1x HDMI 2.1 output, 1x DP 1.4 output
    USB PD over USB Type-C

Kernel commit:
04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
Add support for Khadas Edge2
---
Changes in v2:
- defconfig: Update defconfig made from upstream
- Link to v1: https://lore.kernel.org/r/20241119-edge2-v1-1-b10c5d7626ca@wesion.com
---
 arch/arm/mach-rockchip/rk3588/Kconfig         |  23 ++++
 board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 +++
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 ++
 configs/khadas-edge2-rk3588s_defconfig        | 146 ++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |   1 +
 include/configs/khadas-edge2-rk3588s.h        |  15 +++
 6 files changed, 203 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index b5a0e624a53..7d817e7f1bd 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
 	      - fan controller (AMC6821 emulation)
 	    * 80-pin Mezzanine connector
 
+config TARGET_KHADAS_EDGE2_RK3588
+	bool "Khadas Edge2 RK3588 board"
+	select BOARD_LATE_INIT
+	help
+	  Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
+	  by Khadas.
+
+	  There are tree variants depending on the DRAM size : 8G and 16G.
+
+	  Specification:
+
+	  Rockchip RK3588S SoC
+	  4x ARM Cortex-A76, 4x ARM Cortex-A55
+	  8/16GB memory LPDDR4x
+	  Mali G610MP4 GPU
+	  3x MIPI CSI 4x lanes
+	  2x MIPI-DSI DPHY 4x lanes
+	  32/64GB eMMC
+	  1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
+	  1x HDMI 2.1 output, 1x DP 1.4 output
+	  USB PD over USB Type-C
+
 config TARGET_NANOPCT6_RK3588
 	bool "FriendlyElec NanoPC-T6 RK3588 board"
 	select BOARD_LATE_INIT
@@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
 source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
 source "board/hardkernel/odroid_m2/Kconfig"
 source "board/indiedroid/nova/Kconfig"
+source "board/khadas/khadas-edge2-rk3588s/Kconfig"
 source "board/pine64/quartzpro64-rk3588/Kconfig"
 source "board/turing/turing-rk1-rk3588/Kconfig"
 source "board/radxa/rock5a-rk3588s/Kconfig"
diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/khadas-edge2-rk3588s/Kconfig
new file mode 100644
index 00000000000..dd7b6cd8054
--- /dev/null
+++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_KHADAS_EDGE2_RK3588
+
+config SYS_BOARD
+	default "khadas-edge2-rk3588s"
+
+config SYS_VENDOR
+	default "khadas"
+
+config SYS_CONFIG_NAME
+	default "khadas-edge2-rk3588s"
+
+endif
diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
new file mode 100644
index 00000000000..3f16923b0f2
--- /dev/null
+++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
@@ -0,0 +1,6 @@
+KHADAS-EDGE2-RK3588S
+M:	Jacobe Zang <jacobe.zang@wesion.com>
+S:	Maintained
+F:	configs/khadas-edge2-rk3588s_defconfig
+F:	include/configs/khadas-edge2-rk3588s.h
+F:	dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
\ No newline at end of file
diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
new file mode 100644
index 00000000000..bc9e8f39ec5
--- /dev/null
+++ b/configs/khadas-edge2-rk3588s_defconfig
@@ -0,0 +1,146 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_ATF=y
+CONFIG_SYS_PROMPT="kedge2# "
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
+CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_SPI=y
+CONFIG_SPL_SPI_SUPPORT=y
+CONFIG_DM_SPI=y
+# CONFIG_DM_SPI_FLASH=y
+CONFIG_MMC=y
+# CONFIG_MMC_SPI=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_TFTPPUT=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x1
+CONFIG_FASTBOOT_BUF_ADDR=0xc00800
+CONFIG_FASTBOOT_BUF_SIZE=0x07000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_I2C_MUX=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SPL_MISC=y
+CONFIG_ROCKCHIP_OTP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_MTD=y
+# CONFIG_NAND=y
+# CONFIG_MTD_SPI_NAND=y
+CONFIG_SF_DEFAULT_SPEED=80000000
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_FUSB302=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_TPL_RAM=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Rockchip"
+CONFIG_USB_GADGET_VENDOR_NUM=0x2207
+CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DISPLAY=y
+CONFIG_USE_TINY_PRINTF=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_RSA=y
+CONFIG_SPL_RSA=y
+CONFIG_LZ4=y
+CONFIG_LZMA=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9bab86d2347..ea98b73d33c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
      - Generic RK3588S/RK3588 (generic-rk3588)
      - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
      - Indiedroid Nova (nova-rk3588s)
+     - Khadas Edge2 (khadas-edge2-rk3588s)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
diff --git a/include/configs/khadas-edge2-rk3588s.h b/include/configs/khadas-edge2-rk3588s.h
new file mode 100644
index 00000000000..d279cf3826a
--- /dev/null
+++ b/include/configs/khadas-edge2-rk3588s.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Khadas Technology Co., Ltd.
+ */
+
+#ifndef __KHADAS_EDGE2_RK3588_H
+#define __KHADAS_EDGE2_RK3588_H
+
+#include <configs/rk3588_common.h>
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#endif /* __KHADAS_EDGE2_RK3588_H */

---
base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
change-id: 20241119-edge2-18ac09a490ab

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>

