Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21837CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 08:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7390F802C1;
	Mon, 18 Aug 2025 10:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="JeGcqVQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860C6803DF; Mon, 18 Aug 2025 10:28:50 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6DC8006D
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 10:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFl0ugBmgIsNznrQRpp7nU7ufSgUaM73o3AcMPldJ3Lje1Kd5KNXv418EFXbJL9tuEMiQuMVToTSIg2Ukl9B9xepd/GpJHjNvBU0Y8vZ+t3WuaI96rT9SvreXpZSKdADjeANRnyRJMjsIlDMMjwKHxkZrHMw1rhOdZvCgjh306R4ceM5U3RBi/p85Qqox8Jj343mKlxuVxiVhL9zrhcBYuita6cvOxSv9sst0myTJ1sE14j06J57bhBHpEtoN+rb49o7bWRE5jxFNFszDxkeGWq63KAdioli6KU7eFSa82P8YrBex6f+yXvwlLNhxkmOw96nZSxEvw9bUhfY5UKftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NURx2DdRqnTTUSfsRD5u/K67MT1ytOTPhTdtnbKeysY=;
 b=yGuhJOzTqvlvPmFZrihWmXSH6+d1XwwTSwxmo9FCP2RDYygZSVMtgiP898rEf6eutb09E51w/TH1I3kw/FiYztzWl9F1WtjNUc/yU/dxNW2j701rpEORjsaLd+tbnKD2ztXinpcAicfvtERiarn0t6BKT73+9XHwE02RBCPRZ0OlqFNnt2vV1YSGl9gVopr3wasWhM+sfh6XHWeYxPqmHYNONxlE15JAi67FwQnWxN6/iCg3E9oMZuEpAAGR33lVeliFtzxYbBewc8qn0R5VRHKa15a+QmdDIU5fcNM85Xp4+5IPbdvHsW+nZO1i49UNV/nkvSYypIifnOV8ulFobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NURx2DdRqnTTUSfsRD5u/K67MT1ytOTPhTdtnbKeysY=;
 b=JeGcqVQR07NoCv0cY7T1mBqzj19MvA1pY/zmtyw3syIDz+CuFXRrdzxZLuC3pXN4P6M86N6FTbxR6V9O2mC7IFGOdfPXkiSceWTUjDpS1/7U1Ql5HiKGd2Ll3wG8wV1YC2dGmQddLOKWHopk7HqpVPC1xVNznq3t5QeKX4ajNpX+7K/lUur09OjLhKeneyrpv8O+rwUbLwYD52mO8uIheZjfDN/8FUmBZD33LqJaB6HwQqAOBPivaK15r4LrF44j0Bl/AvZz5z8VtacdRvZwYgdh2K4h8AQSZ96CtuPuzR4+/ZzHPCpiiYQgHZtNMm7SQEDQwwz91BsFTcRnqp2DSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB5947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:28:46 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 08:28:46 +0000
Message-ID: <b6ff9fc3-7660-4502-934d-2cfd85f4fcb8@kontron.de>
Date: Mon, 18 Aug 2025 10:28:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/21] mtd: spinand: Sync core code and device support
 with Linux 6.17-rc1
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-22-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250813234314.3945708-22-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: f08ef6e2-3ea2-417e-1191-08ddde313f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnB0Q0phUXVtMjVqMVpJV1RGamtDSVRFSzM3aVNwVWtvdXhTMXIrcEJWTHpS?=
 =?utf-8?B?cWJhNnAvWUg1aVUrSmlneDlZdzEyYTNNaldXaUNRTU83bTYxK0JpSEJGeUtN?=
 =?utf-8?B?ZDBoVElrZ0lWek11czAxR1dTL25qN003RUZ1NkZwc0FaUUNxdWN1YUZQWXN4?=
 =?utf-8?B?WlloOWRVMXZ3L3piZmV1WC9vK3c2L0hueEh6SzVVcWlKQjl2RGhQdmhRUk40?=
 =?utf-8?B?bkkvbVRwUUIyV2t1VXlpTlBvOUM5WVNZKzZvZlVmVjhyS0hUL1ZIWnFxT2JF?=
 =?utf-8?B?cUloZEpzSFpKd0RhYVl0bGM4NUNmV2wxYS9JVlRyQzdnVUliZ0pMSUpTYzRu?=
 =?utf-8?B?QjNHWW54UmNDZ3d3VVYzcHNTZnNLMk1qS1J5b1h1cTgybFU3VUV2VSswelNh?=
 =?utf-8?B?TnZhUVlaNFFhM0VrbDNMRlJaaTAzTVI3OFNBdGdnZm5pek9VLzBPRVB1QXNK?=
 =?utf-8?B?TlFwci9WYUVkcCszNlpJQ0lGUWdHM0lyeWxXWm41MmJwVG5RV0pDWmg0a1VX?=
 =?utf-8?B?TmlPdENRZUtENXhkQ2w3ZFdQVmdpYzRHREgzVU02MlBwRHR1d1JFR1UxTTZt?=
 =?utf-8?B?VDNiUFNwUkdCYkR4MDF5aTIzQk9IMUtydldwSCtpd3RxdjJzQlZIYm9QWkFN?=
 =?utf-8?B?UXVlcUJ1YjBUdDVQV0tlVnRHU2cxQVdlVXJUbk1NZWdkYkkxcFFmWlhYcHFU?=
 =?utf-8?B?WDJ3Yjl0eGxuY1NBUG1aeGJ3Z0haWHl2WVQ0SUlJb21Td3JwYmdtZHYvNWFu?=
 =?utf-8?B?NkpmblF0QmZtcHF2TXdydlUyNExKMU5Ha2xPU2hFRktGbWVDQ09MRzA5N2pL?=
 =?utf-8?B?V0lWdXFLdWRacExYQTkwMi9Hem8wTkhNdVhHL2lOWkRkRUJORW9pRXN5NE9t?=
 =?utf-8?B?RlZFK3hIc1lTK01SWVpCa0FCeGx1UDhUNlAwM3ltOTVrR1BYTWVsM1U0T1Zm?=
 =?utf-8?B?eEllRkNmNHBWUE5Ld0w2YkJuR3FKSzNwMHhwMmM4UjB0N044Z0J0VlF3MHFo?=
 =?utf-8?B?dGVqdTdWdEtFMGZrQ2lLZmN3TGQyeEFoekJxQzlhTTNnUFZiWmhoQ2swbWth?=
 =?utf-8?B?YjlpSFNvU0JXbDhIN3NVNmxPK2cvTG1aZG9JZm9Gd3UwZmdjL3VjOWExYmRq?=
 =?utf-8?B?cHpDN3dXSnNDUUJYVmIxZ3p5N21aSTlud01lclQ3UUtNM2cxcGlQaUY5TlBV?=
 =?utf-8?B?TXRTWUx6bWQ2Z212TTduWkRKSXZtaUJHSzVoYXR4eW11V2FuTk1rdEgrRlhD?=
 =?utf-8?B?Q25VZlB4UytEVzhyekpkTnNoQUFvb1lOY3ZoUi9PbUV4TzFGclExQmpuTEFz?=
 =?utf-8?B?dkVpeDVGSFZmMEZJS0pVRGU0eXk1dmRJTEVja1RYdEwwend2QVpnaXQ3ZFpH?=
 =?utf-8?B?WkNRRXdSSW1GODM5YWk2Rk1zcDJYbkE5dXpwcml4THgwYmZuUnZObWZ5RDBx?=
 =?utf-8?B?aHdsUmNlODNTWGJBZlNZNDJyUFZWN3Q3L0Y3V3JZenVldG5ET2M5RVVZbUdQ?=
 =?utf-8?B?NnZKcVBJZWRHanFlOHRIMVdNSzdwRUh2Mjh5dmh6QUhkb0p5bHBEMjNHc1Vs?=
 =?utf-8?B?M2xxVWRnTWNSTDlVSWdpSlBlWTM0NXRmU3cxYnhhdlExeXBNQlNpQVhZdmxT?=
 =?utf-8?B?d1RsNHFvSTQ4elVqakN2aE1qRVB4YUJBYWtYS1ovTldEVGRkWmRJcGR2TGFZ?=
 =?utf-8?B?K3ZsNEpJRVVFajY0ek1IeDZOZkRkSFZXUFBHekJUVWJMd0ltWW5aVWpHZ1l5?=
 =?utf-8?B?RktPRDB5ekkzUGRGRWIvTUxtVEViMmRKNWJQZEJtU2MwdGkrQ0FMRFYyejd1?=
 =?utf-8?B?Vm5keWFCei9rWUtIRTNxZTZPQkM1TEVDenJaQkZuVStYdVdJUzVsRVEyczkr?=
 =?utf-8?B?MTVBQUxrcHN5eUI1eUdpSm9oWG5IMFdVbThhdXBqL3MrNzR6M0lXbktVczRG?=
 =?utf-8?B?QjhqbW9GZUZHVmtrVnJmNFE2Qm5tVmRsR1plbE5qaThYUzlEQ1dDL29td2xN?=
 =?utf-8?B?MTlYbHgwOFhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURRU1htTnBQeFNhMC9OcnpnRVlBaTU3c3dJVEhpMjRRTmh6SmdVT3lQeGRs?=
 =?utf-8?B?ZjA4d3BpeDdycVN0em1OMHVJaEZQc2NuVUt4Tk5GdERPMWxFNWFPdFFPSjMr?=
 =?utf-8?B?aGZpZGd4RjVyNGxkQnk2aTRkYUs4c0U1RnZZWTlMWjlNcHFyTXJkaGVDbURh?=
 =?utf-8?B?cDNBTEw4blJnUmhydGsrTWh0MXF4K21NcFhObThLVXFacUdsUVlCRDZvVXNh?=
 =?utf-8?B?aDQ5SzVLQ0hwQ2svY2NyeXgxTlNXeTZ0WTlFQXpvL1VMNzhGejJidlVVT1I0?=
 =?utf-8?B?L21xQ2tFNTZEVlNGZXM3N0ZVNkhXNmg4anR1RTQ0dzNMWG5ibnBtRG5IYXFN?=
 =?utf-8?B?VjFrZUJKK0drSnFIeVd4YjdpR1hxSldScDRQZ25QNFJMdU5nUlVlRzJ0a21U?=
 =?utf-8?B?Z2V0ZDI3bGFqUFBqS24yZHMrU0ZqSHhVRjhuQitrUStBSWtVck1oS2JVVGZW?=
 =?utf-8?B?Wis2WFF5bnlnc29MMGxaZU9lc0I3OFk5bjZFVWxLcWpIc0pleVQxWUJZZHBh?=
 =?utf-8?B?RWpJYWVXQjZIaDFKenhWcnZRTFJ0d3NpTVIwNXVvM01NYUd5VDlubmVSelZ5?=
 =?utf-8?B?N1JWOThtYnFkMldlRUVlUnJvZzBTc1FkdzRPazVkLzJPUlg4blBSNmlVNmJv?=
 =?utf-8?B?SEtaYS9iVDM5Z1h1WVIzcFhKcjdaWVdOZTkxeHFmNVB1MWE3Zy9qSVNCQ1dV?=
 =?utf-8?B?Q3ZZaEpjaE1jWWZObmJzcmd0dmVjZzY4ajhwZ2VXSldTUnhIdEV4bTdxTWZ3?=
 =?utf-8?B?dU5sTHhseUVaSzUxTUtPT2t5RDVzckxFQ2pxbVEycWZ0WUEwb2dzWHB3TXBC?=
 =?utf-8?B?cTcrOWdDWFY3SGpoSmJRRUpIWmluc1VLdkh3UHd1T0RvTEFTK3pDUjU1Z0M0?=
 =?utf-8?B?UGpSdVJGa2ZuemtMbnlHUTZ1b0k4THZKbFcvVStGcTNTN2NCaGZXVHFTelJD?=
 =?utf-8?B?ZDFWZ0ZoRWVCWk5HRXlmSjhjcmUyWnNIb1poVnZjZTMxdGxDU3AwQ0pnWU5N?=
 =?utf-8?B?b3FCd0pUUXpVWjVCVDlsS1RLTnd1dzFRT2V1QU5NVlYrb0FBcDQ3bm8zTGdy?=
 =?utf-8?B?NU9zc0xjV1dNTk1hamlSQ0d6d1N3SG1LZFdMZWFXUUpwLzhFQ1d6SGI5MHhq?=
 =?utf-8?B?MUMrbzBaWkhMRGUySU5vN1VGcWF6d0YwQVJ1WGs5SVNyOFUyN3dDSE5nOWI5?=
 =?utf-8?B?TFJLUGRmam80VklqMERIV21WaDBSNTZvbnMxVFlsckY1NDVBUERXa0IrTzUz?=
 =?utf-8?B?NEY2bzlaZG5UcDRMN2JYYURvNnNnMWtuWFpRK09abUdVb1ZpSllibGRxdXdT?=
 =?utf-8?B?R3FkNWt2dUt5UzdhbGt5dEdmRkFJKzVCN01qdllCNkw0N3JjNkIrT1lwU1Yv?=
 =?utf-8?B?TzRUWVVRMC9nejJ0bkFxL3l3djVjUHBBS1RXMW9aSjY3Zklwa01TcGlKZVQ0?=
 =?utf-8?B?VUNNaCt1Z0hkUDVscXlBWVI2NWRxN1Y3Qks5cEw5a3phbjFMb3NYVFA3b0tz?=
 =?utf-8?B?T0FiMVVLclV5ZUlOWUVoYXZpYTVzOHpYRE5tOVNBM01oenlHRkJhY2luczJK?=
 =?utf-8?B?a0xadGlsRmhsQ3FzcFlpSjQ2UlQybzZRMlVRUjI5cEpYUjd2TFpMRzNrVzhT?=
 =?utf-8?B?dktidnhEYmlkaWQwVVJpcnhicjFZbE9mdHJ0N0o5bkN3dnZrclM0dEw2eUpY?=
 =?utf-8?B?em9mTkpFRU03U2hLTzhPMW1rMGFyZ1dneGxDVG9FUHVYNjljMCtYM0U1WDF0?=
 =?utf-8?B?ekl3L1ltKzVHMzVoaUdKVENwaWhoUEpTclE2SjA5WnhWNzIwM1RrNElXaUhP?=
 =?utf-8?B?K043TlpWOUcvTGMwUksxMXhpbkU5V0N2WG1LRFhWUG9PZURYeFFsMGg2MzZS?=
 =?utf-8?B?V2QxT0hxSkZZTWxmSHhPMDhjbTZ1b0ZpT0lFcEJTUnJxYVU1RllGTmR3MWk0?=
 =?utf-8?B?ZjNVeHJJWEpsbkErcWJIK3ZmVkdTcHJVaVZxZE12YVYzZERmNXRIdUFzTGNX?=
 =?utf-8?B?N2lJVlZHREtQUEsyS0JzUC9wSTJMV3VaNnVCNk40ekpPMUdMYm4ydE1TYWlr?=
 =?utf-8?B?T3JGWnN6SGxkSzk2bnVuUTNvR1l4aktMT1RnN3diZ2FBdncrTytWN1gyUXFk?=
 =?utf-8?B?RG1rSWFFWU1TUnNDaE9jOHhxMVJrR2UvR0Zua2NXOTEzaUZja2MwYVpYaFBY?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f08ef6e2-3ea2-417e-1191-08ddde313f8c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:28:45.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s93N3x/Lp7iIB6PauXB7b/9QvrXQtC7PmVONyJ1gKakoY0RNxfC3eFZuoMlndMDj9R3POzw01T4ZcDXWiGeRnTNT+t/5pUFV8t0pMJM5DYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5947
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

Am 14.08.25 um 01:43 schrieb Mikhail Kshevetskiy:
> This makes the U-Boot SPI NAND driver almost the same as in Linux
> 6.17-rc1. The only major differences are:
>  * support of ECC engines. The Linux driver supports different ECC
>    engines while U-Boot uses on-die ECC only.
>  * per operation maximum SPI bus frequency
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
