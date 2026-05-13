Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB0CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C9083EF9;
	Wed, 13 May 2026 09:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qAzZoDc6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qAzZoDc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DD48464D; Wed, 13 May 2026 09:41:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA60836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e/LSXjrH3Q4lIW5Rfvjaz0e/u1s9pw8nAiB92Uw1iS7TuBAN9UW+SRwAmaDT0DuKo/ng5wUKTBOx8P7k2v6/FQfu8Hu53B4VAHPs31Vs/GngUMtTZ+jxukGwqEKsWMTitt5/SUdQEWx1j9KBoh4miuH3jBwDePiA+vhozZl2sf08N58EEOUS+F7nNFKUevJkHvemAvKdwE0YVMF+zTc2BvXRQtc7R2WCnlxAT6MeH+B4HwRkz6UKS14Azq0BAMiEOHP8s5Xw3U/d/fhZ6lZzeYU6uShmusRcBe4hewMU60FgtyfuvoxEG2644gg44TBmkVKj1+zjAI2Fc15KGVZhKg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r9KMBKetTG1fvQqoShiMAOJr1SY/uwdjqYTXDTQ9ts=;
 b=lYaMc9Z2yjWc5jWKIgnbzZB1hKCu8xJ4mVF1MUjCYiclS0ROxH8456Iwgln6mubC3Y6qUOVPYxvUdxG2DN1AmKXqirglq7kfhIWS+SiE11KobNjEogrrfAFqLQHy3YYof6+iNQBM81sxZbGAHjZYPzWTWtLEDHKIIrDkWlaiM2No0mZNpqbiItA312niWtI8IjcpgGxyxvZ5TUYWfOIBtYzheiaom1BbPZTe760lDui1jchs8DOMU9Go5VzBapTS1yTs8Yf5ofD7wDes3Zv5XWdf1R7GSF+bNdeNC0NfSODMRpCceV+IqvbmY1BdMHKzxAgSuHdisCMeP+D2JEmPqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baylibre.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r9KMBKetTG1fvQqoShiMAOJr1SY/uwdjqYTXDTQ9ts=;
 b=qAzZoDc6mDzAMR7qnZ28ViDQCIubAIlxGmILlxaIgzAimKijQtp3eiKBrrNgaUHIueGMmWH1x4VhakPT2wCtbD0MGBphcB9MnOCXPcnjNzjk2iUN3Q034BFNidIXoWvoTKYzblhAU0cR4DJJR5q5keADhLGEbpupM3sm+mnQRqU=
Received: from DB8PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:10:110::16)
 by AS8PR08MB5958.eurprd08.prod.outlook.com (2603:10a6:20b:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:41:31 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::bf) by DB8PR04CA0006.outlook.office365.com
 (2603:10a6:10:110::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Wed,
 13 May 2026 07:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 07:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUp0O8EyoEUpGd4z5tEeVTgJUegR6NOz5fKMp4BVt4+l3L5oz366ZUQFpElCl9KhQ0cSPhrWBKx6ISLdHH/xHBnN/Jh1BSFUjcWUAuUP9nLRQahCCC35lBO6+cS5LMnEZqWdt8R4qB5hy9Vll1j3T2gT+gGzOoJolF/D59HOiELg1Z/VOVh9AXVbl/A8hKUF3OYsj8y9jMSoG94LzZ54IlO7galchPxy1F1ajg+zt65dN3OCg8mcbqo/3eMzhQfZ/ktUgbJ0ITl2pPrJToMfYJLRK5pJ+8Y9cJAG3UfSGc9cvwVWpl2RpmwWBlfOHdfYb1L8kV3yvfWWtZsquqVZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r9KMBKetTG1fvQqoShiMAOJr1SY/uwdjqYTXDTQ9ts=;
 b=nXoZYM17i1+2K+wn3MU/j7WV4DE94s2CpJJxEi6NEc3gzV3Nydrntqc9k8rWmVFXY9Yoy44FszUXDnQRWfbxNQ/eUD6pjfrpA2QZseh8ZX36Dww81ODKYuFEv4H+TOmgR7ma44UCrp5sSZ4PeZzenWoKb5oGLQrM6ENaArpZkFbcbdn9N5TKU81t5/3h0A/b990rmlGE2lJ4P2OHuGZiaKnTMpANREcrMY/DFAWTb8xfx508Mf8IfF/qT+pruq+HzP23BDJJ6sO65dotAfYynBGwKRwCsM54leyK1l7B5cpqxbYfDaS4tV7avvb1Gq5Fl+bwqmKAaIP5QmzckiLVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r9KMBKetTG1fvQqoShiMAOJr1SY/uwdjqYTXDTQ9ts=;
 b=qAzZoDc6mDzAMR7qnZ28ViDQCIubAIlxGmILlxaIgzAimKijQtp3eiKBrrNgaUHIueGMmWH1x4VhakPT2wCtbD0MGBphcB9MnOCXPcnjNzjk2iUN3Q034BFNidIXoWvoTKYzblhAU0cR4DJJR5q5keADhLGEbpupM3sm+mnQRqU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB8711.eurprd08.prod.outlook.com
 (2603:10a6:10:401::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:40:20 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:40:20 +0000
Message-ID: <4be0141c-dd60-41f3-a8d3-4c3458092aed@arm.com>
Date: Wed, 13 May 2026 09:40:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: lwip: wget: return errno codes from
 wget_do_request()
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, nd@arm.com
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
 <20260512-net-lwip-add-stop-function-v2-2-85146da317dd@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260512-net-lwip-add-stop-function-v2-2-85146da317dd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB8711:EE_|DB3PEPF0000885B:EE_|AS8PR08MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 810b529b-4fbd-4b49-be41-08deb0c30cd2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: 8xZn612bvouO13darBQ0Xmg++5VBHjGtzXqB6JJkiTqXNvaZCjBt7hUnaks4+IELml9V1JQrZaT/W/cni++1rZ9nHLpSEKTq7la7NyiiVHDt3BdIVvDO/IecJpGRfXe8t+BumfVvZZzjNYFb2xbvYh4vHdp6iKKnY8Hi93OsWXvyFZka/T3kl5fzwsSE6ISVlVlNTo2QvQFcwshxOOysYjN0YJtN1ZwSbXDxS8UnBfiTU8ff2UHb0ob2yJBILSh1b6vhiF7T7jZ3ZMBWs+2zug2H8DFJ7xX6CCMsVwYOP8/NLU8c8puifzq6CiSxhq41A6iPYEyw0ZHSPwTEWHF/e/CwfXKM0eMF4pQssHGEQujQEe1rolPYwoppSRhuVYde0CikS8/zk8NV7wPC9edv66PfZbRrN98uVstnZ+nfx+XZAADvOJ+xs5St11cyfZAhsTITcZAqs4Uez/mODwupeFcKEDmL62t9IknKwUP/SEf9c2L9/pUqlL3kJde6M6eTb6c9nbZv9ERyMzKX0ehF38/8UmkCfFrpo6R7wtf4HqEC77yUd4xSO9nAtDL53zBgL+PusWU0S31wH/KWPRG4OPtEEFW+cO3JjGviwWTHvDlK5kD51E3tvWlmzwX55ekN5QH/zHtLmB3P2GWNLACZvmeiZeWsWn7oDk4MWOIAc+eX0Ji2XVOyMieY+xbwqrMz
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: KbONvdJ3BpyMfTPzG9RFgXHWRRWOy50PM5svZvoiHGUlGzR6ezZbR8u1Chlh9V6Ll6wZAZBCZRHXvTTlZEDXiib6u51BRoIlknQyBwzIhII/l29U1SsYt5lYM9nXAkFwmZLCtRWqnNIlHVgyAsWn2fX0y7IKTVi/07gCR/rs5AJ1IYh22AEjRfNt3KTzDtmXcEvUGjiZYLfs/jEiXFmgy97Fc1fw2BibviCYvjMJsd1dlt0VAPE8TnavexzcaAODs26DKuj2SseFrNohFptP87SNSL+y1p+JrPuj7XHITvuDHpbfEUlNPFht+uEZ1nWc9RtZOUeAusav5ayiumMXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8711
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8561c44a-e5a6-48e2-a664-08deb0c2e276
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700016|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5pngTTfe4QGAvhilhAJkxY9z3iw/l1oEpZPyA56C+esYnByQbgDg0hCLr3FfAux1iCoA8ga9Hzsk8/+7hZp5rI+EmSx24KJv6s9mWTKbGA83hsmHvLdzURyHIbzkkfF46Xn5YREit/j159bdLEZZcQ1dh/YWVe8U8vDaWDrwYYAVhR7II3gJT1eSXniid8oc+OkJrzMnVKL1MQCqjEnUGljvV86XEtipE5my7Db6u8yhm3mTRZFCluDXTU4vgVALMsDO+3WU+tfKeQTaePXWJYq5ntzAdgOiHPjVnnQPgJ0BEaoKqM/mKYXNssn+cj6vqmllbpAMi1jPMTSl959Z+FWvJz6TAOcfxMG+Kb6j9sDpleXnRW7py+evxl75sjk0KTdhohD5ThiLRAUgkSrePrWU2P6RV1ecaLzyvQowgKZyynL+pj/cTj408m4MDmoX/2ryBcOqZKZoCia57jFhJiICkcyYuKEzmzNfZqFEyA3tqvx5Sc3BhxgTdzyed/u+463vfmWJRO5vIN266hccPmBDIn87d1cWBkwTrL61M6NQPluPqQtiHZcuUc22IkYM224Uyx5tuTC9yK8ZM6+WErahgkEvtElYtA7BNOH7coS+lrjvpfEt33ecMcbVlPG1hQosHoO3wFB0EGln7ydHGBXf1pjpJJdQiNXLhPSNLvmDqgGSAZP+RMnSSHVogd7TPfWz6LCKTnfuCn8fuEXQe/i2I/RZXK4JWl7DEP42abM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700016)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V7vdcQ/LG0qX8wOmYjO0LzHBIKV6NsNDSiOVNGV4PR+Jr/oVRhJ6EoKJtpZbbYE2gCusW0k8G/DKcMJTCd2lcLDOSaxKc00K28or3OONTC3GGuI44hzG35OAynC+P8YVpltBsq54VpxbaFkpeB6jZKhr+wLsS06ecg+b091gwWPhwSgOgw6Lypo8TOTQ8sOkjU/nituADunekZVM9SO8z/FQMdWbNeQ3RLTHbY8XNvXPvsu9pFMXtPlCXVBXoQqfIrOqDv+7UZDgu6Yxk105M5zUrjaqNBQ/8yFqtiwERDR5pAFYsjNpfdOIgFrrrlrJUxAnN2fj/iqbrejQIJu07RdU8ITs99OI7EZ1JtIaC3FMReNAn0TYXlUS4E2a9mU7anOQRgJybnpEveVsuM9nTq25Ul7dWdmWwXxrtZ/Sk0tV0c13/oQ2xaPoq+I8ehzc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:41:31.2469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810b529b-4fbd-4b49-be41-08deb0c30cd2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5958
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



On 12/05/2026 23:48, David Lechner wrote:
> Change the return values of the lwip implementation of wget_do_request()
> to be errno codes instead of command return codes.
> 
> wget_do_request() is not a command, so it does not make sense to return
> command return codes from it. Also, the legacy network implementation of
> wget_do_request() already returns errno codes so it is logical for the
> lwip implementation to do the same.
> 
> This fixes a bug in try_load_from_uri_path() in efi_manager.c where it
> checks that the return value of wget_do_request() is < 0. Before this
> change, CMD_RET_FAILURE would not be considered an error since it has a
> value of 1.
> 
> The value of ENODEV is used in places where there could actually be a
> number of different causes of failure and it isn't possible to
> discriminate (i.e. failing function returns NULL for all errors). Since
> all callers of wget_do_request() don't propagate the error code, it
> doesn't matter so much that this is not ideal, at least at this point in
> time.
> 
> Fixes: 3c656c928bd7 ("net: lwip: add wget command")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  net/lwip/wget.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index f89a6580b41..3a0b0dca145 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -300,10 +300,14 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  #endif
>  	httpc_connection_t conn;
>  	httpc_state_t *state;
> +	int ret;
>  
>  	/* if URL with hostname init dns */
> -	if (!ipaddr_aton(ctx->server_name, NULL) && net_lwip_dns_init())
> -		return CMD_RET_FAILURE;
> +	if (!ipaddr_aton(ctx->server_name, NULL)) {
> +		ret = net_lwip_dns_init();
> +		if (ret)
> +			return ret;
> +	}
>  
>  	memset(&conn, 0, sizeof(conn));
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> @@ -325,7 +329,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  					printf("Error: cacert authentication "
>  					       "mode is 'required' but no CA "
>  					       "certificates given\n");
> -				return CMD_RET_FAILURE;
> +				return -EINVAL;
>  		       }
>  		} else if (cacert_auth_mode == AUTH_NONE) {
>  			ca = NULL;
> @@ -350,7 +354,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  
>  		if (!tls_allocator.arg) {
>  			log_err("error: Cannot create a TLS connection\n");
> -			return -1;
> +			return -ENODEV;
>  		}
>  
>  		conn.altcp_allocator = &tls_allocator;
> @@ -361,7 +365,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  	conn.headers_done_fn = httpc_headers_done_cb;
>  	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
>  			       httpc_recv_cb, ctx, &state)) {
> -		return CMD_RET_FAILURE;
> +		return -ENODEV;
>  	}
>  
>  	errno = 0;
> @@ -378,7 +382,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  	if (errno == EPERM && !wget_info->silent)
>  		printf("Certificate verification failed\n");
>  
> -	return -1;
> +	return -errno ?: -EIO;
>  }
>  
>  int wget_do_request(ulong dst_addr, char *uri)
> @@ -398,11 +402,13 @@ int wget_do_request(ulong dst_addr, char *uri)
>  	ctx.content_len = 0;
>  	ctx.hash_count = 0;
>  
> -	if (parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https))
> -		return CMD_RET_USAGE;
> +	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
> +	if (ret)
> +		return ret;
>  
> -	if (net_lwip_eth_start() < 0)
> -		return CMD_RET_FAILURE;
> +	ret = net_lwip_eth_start();
> +	if (ret)
> +		return ret;
>  
>  	if (!wget_info)
>  		wget_info = &default_wget_info;
> @@ -411,7 +417,7 @@ int wget_do_request(ulong dst_addr, char *uri)
>  
>  	netif = net_lwip_new_netif(udev);
>  	if (!netif)
> -		return -1;
> +		return -ENODEV;
>  
>  	ret = wget_handle_request(&ctx, is_https, udev, netif);
>  
> 

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
