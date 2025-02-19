Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B24AC021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E483480F6F;
	Wed, 19 Feb 2025 21:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="T7qn1wMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F59801CF; Wed, 19 Feb 2025 20:02:05 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671E4800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 20:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd6suJlFQ9ZCFgvLNTV+yaVqjgCmtYjGIYjBpR3DaB81JvGWbhPvkz8qDuRqhQled9IseK9OqEWZaJL3lgJbwGS4A+X86950mtOHQkgiga2QiVRGn8F2goC925L9Ti9VBMOlIBTqbhmHwGU69+hVvDYuVwtVqefFXC4o4QNQSfipQ6T+9aAgOtOR8OIDOJI20bcXQjTR4UtLgi+aq3iANavUj6HKdgqQEWLKtef0Karu5AIl21IjMAGHC3VbkPQ1+KBlrQGRtBYxiPcFNmrA89hTk3JlN4/ZYk30lLGUs/e+kLIAF+pm+UberZsLb1eYozJZ0jYvUEVSUlvXed/hVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfYYBN+mcHvLOuB8LQsS6N29tLauwYLX7T73Cz3lT+4=;
 b=aLoyxBuKljNfKCxOuFQgKj9JY7qodb+mS5e68xBqYIhIOIs6gWJu64I9BLvsBCTAJOB3k5pOsHJ1m2p/mz2IbInXaEelznQgC1QRQ3fqnH06H1QBE+DKOaSEeKmxQck8+Op6k/DbKZSlgFLxAD9tXo7tBK0Ydi/rk+qBHxrq6uR7z2qCf9QZ+/8SyS2Jm3bywC1QAqboiKUg8j0zCElzTiXJdgkRKAXhNiFifkQL1fIQiuzuI1GQ8wVYndk8/vBSXrl/hwz/8WbOCzh0EX87YX5Aq1xsYrLkuh5KGkcBtCWU755d2jZB6A7AwNhz+I2xWDsL2uW4CTIiUNJBh1Bcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfYYBN+mcHvLOuB8LQsS6N29tLauwYLX7T73Cz3lT+4=;
 b=T7qn1wMXTy/Gp3Ue32G7a6KONnMUnuCtCKViK39JU1DtcWL4+4ejjcEgURWMGmo6R1YN036prfU4WnC+tX9Vk+XHpP2FvSvXikNPJKaHOqmLMIHTMfH2CC8UTmi+gi4FBmsyxM5eydG4xbNszYN0kgRXxdxQ9oCEHdyOqIWGr/l85GIoixnPnPDh7UeO4AxrTDenTUHz97NlzJw7UNx8q7fuD8qx0hNJ/f2xeTIB1XPVxGAoygS9ZyC4iT3sNKa6Hrg+o4C6DseEaqxXY6G5bfjbW9O+3/iz1DPtipCSEr25iQk3rOEXoN4LHg2O0yKG+lzj5b68k19xAkZyoeVMyw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 19:01:57 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.008; Wed, 19 Feb 2025
 19:01:56 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>,
 "afd@ti.com" <afd@ti.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kishon@ti.com"
 <kishon@ti.com>, "bb@ti.com" <bb@ti.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 08/13] arm: dts: k3-am68-sk-base-board-u-boot: Add
 bootph-all property to necessary nodes
Thread-Topic: [PATCH v2 08/13] arm: dts: k3-am68-sk-base-board-u-boot: Add
 bootph-all property to necessary nodes
Thread-Index: AQHbgrvoe5oOdSJ3sES0csFKQSteXLNO/ASA
Date: Wed, 19 Feb 2025 19:01:56 +0000
Message-ID: <ec0ac88d77d25725ab37278c43895e7880a36537.camel@siemens.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-9-c-vankar@ti.com>
In-Reply-To: <20250219104831.2315464-9-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB5211:EE_
x-ms-office365-filtering-correlation-id: 56f7cd29-c39b-4839-e07b-08dd5117e191
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RUdJbzRVTmJIZ3dTdUZBcXY0OW1HQS9zaHFNcGtVdUNVdWhMRWo0MmNGZjVr?=
 =?utf-8?B?Z2FlSUE0WStvZ1gyYlhHK0UwV0p2dkt5dkNRTFJDUC9iSFpwOFM4OHVGc1Mv?=
 =?utf-8?B?MGl0REMySHJHR1Y1aHB5aVRhTlNWdHhhSHEvaklWa1JnMjJwV1JmcU9EZEJJ?=
 =?utf-8?B?anFpZkdsbXphaEJnUDQwMjRFMllvZHp5elpBRTZjbVBhZ0E2OGVoYlRVRlJV?=
 =?utf-8?B?Z2NtdFlEam1kWnBraXBiTlNsZHJiSXBORE1xOHZLQWlJdjI1eWEzRWRNQlFu?=
 =?utf-8?B?Q2RCSHYvbTh2dUJzbXRpUmVsdFpBWkgvS0tTb2ZQN3JwYUpaNDVJbmRVb0Fw?=
 =?utf-8?B?VWMyNlQ5RUMrQm1wbGVKcW1LSzkzc3BWOVo2aUxDRGV4NTVUdVZHRXJxR29r?=
 =?utf-8?B?ZHRmZ0ZnSnFnODN1WGxvazJrZE80YjRQanBTeHhRR1l1V0VKdXRINzhBeGlj?=
 =?utf-8?B?eU1INWJkeFhVS2dqV3FJZURIN0xKNDBWcnRremNaZmtUYjBGVC9zc1k1SWpK?=
 =?utf-8?B?Vy9iZG10L3dxNm9QT01hM2dJekQ1VFp6bFE2QjhzUXhVTS9odHRNOVNHRTZw?=
 =?utf-8?B?cGFtUmkxR21vL3Y2Nk92Yjd4WE8zTzJNYW9rRzNVN2RPRGR6T2J0NTIrMEVh?=
 =?utf-8?B?ZnZTcTltZS9zODU0cGs2Nis3N29ucWpTN0lka3U1K3BzVkViVGlrVHhIZVI1?=
 =?utf-8?B?djFkaS9iQXViRUl4Q2dTZ3BHWm10eG1vZE56bFpJRFExNVBUUktoWXdSaFZy?=
 =?utf-8?B?SVJiWWY1ZWhDSVJWQWU4bWRVTXNsUXhMVG15RHhrbDdVVVJuMEVlenJhTUVW?=
 =?utf-8?B?ZTFTOFA3SWhSREVPQnZzKzU2Z1JZZ3c1MzAzMEU4WjlUU3hZNHR4WGVVVlJO?=
 =?utf-8?B?YXJpL1JNSWJhTUxQNlB1d1RTV21LZmZsendGanZ4MXloS3lVWDc0SjA2bHJ6?=
 =?utf-8?B?OVp3eWVieE81M3pBSkRacE9oWUlrOThnRk9Dc0g4WTRBazJJYituT05pbTNj?=
 =?utf-8?B?MkRhV1J1Q0JQeVZsZ0RjWnJVT1hBZ3MwTDhXTXZnR0Y2QlozNVMvaFZaZFpB?=
 =?utf-8?B?MCt1SGV1UDNjZCs2enZ1ZHZrUis0VVZIVUxRWHBXUGVKWjJJdStWNUwvLzdz?=
 =?utf-8?B?cDlaS3FCcUFiY3B6NU1nTXZzYUZKVFdLMFpXRU1EZ3g1TERWcTFyb1owY1U4?=
 =?utf-8?B?OWJGMnFvdFJuVEFUOUpKb2ROU1VySm4xVTZTWVFSSnhQeU9QK3k0Z290bk9U?=
 =?utf-8?B?ZEZlYnF2UnpuVlNvek4wODJaSGFZamJQR2lkQWUyMk5KS09KNVBFNldEZ1h5?=
 =?utf-8?B?SWRBeEpHVnRpcm4zTlNEeE9aUi9FaE84WTd2VEd4ZTBkSm1BWnJuMmt6QWkv?=
 =?utf-8?B?V3BwOHJCVG1SYXNzM1U0aWJXY2I3NEhiZk1kditZY29reXpLbXM0bjJwOE1j?=
 =?utf-8?B?TFdTcGdzbkZOaTBsTFBiSDhwTnh5cm9JNFJNWTRGSjFMWW1KdUl0MXRwczhh?=
 =?utf-8?B?WVJJYlUvK1RPUUFTVjdyK1M0ZE1BUkJxZkltNVhacGxmclZHbGV2RFBWRGNo?=
 =?utf-8?B?eUJVMDNmK3h3K3Y0WWZNd2REaTBkekN3SmpnRWJDRVgvenEza1RyaWRCSHhh?=
 =?utf-8?B?MTJVRVBqUUt5Z0JabTV0TFgreStLZVZISWZWU2F3ek9ZYlJLM1gxRVVoRTA3?=
 =?utf-8?B?Z3cramMxRVhMd3RnZVdTakNYYnVlaUtkZ0t0SFI5YmtteDNwWGVwWDlBL3pt?=
 =?utf-8?B?TDErVTlhdm44Y0VyRUZwNTloRGttbzllN1lsSTd1Q3kxMjZ2SGR0S3FsSEJs?=
 =?utf-8?B?UmNWVHRZS2FsQUNYV2w1bjBRS1A1ajFmTUxzOXBDWmRnKzNxL091dlBCdmZU?=
 =?utf-8?B?TVJtS1BJUjg3SGtSTEZjYXBsR2VlVnpHWVVkQUgxcHVRYXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0I4engxYnNvOGxhMUZyZ294YVhoRG54bFZTZVBxT3V4Zk1iS1FNS3ArZzJz?=
 =?utf-8?B?MEk4bHBrelg3MGsxQjNjQTVKREZDT1E5V0dhb0xmSWdBVGpDVlIydVRCNW9D?=
 =?utf-8?B?TEVhZFUzcXlvRk9DWUFrdUcrOEVkM0gvTkZsNHpOWW56M01vMVdFNnNLam84?=
 =?utf-8?B?R2FBQ2kyR2hlbjNobW1vTXFZc3I3Vko2d0VSODhvVnVDaitGWGFDN01tOGtW?=
 =?utf-8?B?WllOZVJmSUdvdzNBSDE0bnFVNzZaZ0NDaWpTS0cydktrMWdTU0g5YVZiSWhE?=
 =?utf-8?B?WG5sNVNaYmg3dCt2bG9aZ0RiWk4wL2QvRTRUbXJ2ZjlEWjZrTjZHRWYzSGVM?=
 =?utf-8?B?eEFGSjZYZ20ycWJYNjRSWFNWTUtPRDBObjVPMzdFb2UxTXJEcnJtYUVrckVU?=
 =?utf-8?B?dEhXWVpEeDJxejJoTVNKZHZKU3dMK211Z2JGWEJzSWthbU9paEFBK1BsNGlY?=
 =?utf-8?B?VGhCSGZWd1dZS2ZwYTArSkRUZjlMQUxWbmlSeHlFcHJmVGtjeVBQY1ZaMVky?=
 =?utf-8?B?R2NteitYdWZodVRabHhyRG02K0U0dE1YN3FQd00yOGg5djFPUnZBemh4ZlBx?=
 =?utf-8?B?MEZJRUZvZm94bzRaVmlPekMrcmhxemVaaGd6ZjNEV3dxQ1lmQmlpV2VmRUJV?=
 =?utf-8?B?Uk5OUG85dFVCZlZEcmZyMjhwMlpKSUtPYnNsaEFuQm1mWkFyTkxvdGE2Uy9y?=
 =?utf-8?B?TUp0WDZaYkZGdjB4MldNS1FjanhRU3hrWGcrcVo0V3pDbjhSQTVKSmdUUWFL?=
 =?utf-8?B?Y1pjMjFnYlZTMFJkSlJqcHFrMVo2eUsyVTNJR3B5L3U3a01nclNxak8wem8x?=
 =?utf-8?B?TXZlMmc1UXhVV1ZtVjJhNmM4RVVxNHFPYWdCVlloOUYvVnNHSkh5cHRiU3E2?=
 =?utf-8?B?STIwM3lnaWcrbEZVVWR2K2NFQ05wZkhuUjlmRXF4UEY5bTd3VFYzR2grck1N?=
 =?utf-8?B?RDllYXVQNFpUeWxLOXhRZEpLa1BpMy9oY1N4OEJ2b3I3NTFnWWVqWjlPcWNu?=
 =?utf-8?B?ZzR3NkFkMXVVTUpNUDBYaWpGOWUybDg4N3NLbzdETEVuZGhGeURqeVNCdGpO?=
 =?utf-8?B?TUhRcDNMaW1UK2dLWGJPZU1XOEdpR0xYNzlRb3R4aloxemFkbVZGTnE3QTZl?=
 =?utf-8?B?VGJvWDZ5K2RXQkNGRDhWdy9WUkc5REdXVUR3TDVTNFVNSzdKM2JHQ1gwaFU3?=
 =?utf-8?B?WmY3R2JqYzVxbk8yc1FWVFFrTnE1OUZ3bVRjayt1TjhYWGJtdEErd0hlRnVm?=
 =?utf-8?B?Uks4MFltZXV5VVEySzhWRW9tbVJXTExFTG1UbXdrL2VIOElVcVVOZjRkOGw3?=
 =?utf-8?B?SWhOYkhDWTBZLzU0MndVT0g1Znp4NXpLMC9SbVVJUEo1aWI1OGNLYnVoSi9W?=
 =?utf-8?B?NzJjV0pzYWNGQ0VhQVV4SGpoeEhpYU9QZmFORWRaaXYvejBrdXZzb25sbXV5?=
 =?utf-8?B?d1F5RXgvNjgxZXh4dmN3NkZoZkhoYkJvOG9weUxIQWlyWkxiZE9xNEpoMk40?=
 =?utf-8?B?bGxBZ3NtSGFQTFNZenpoRUZiMysxYnpvdk1ZbTZKcDhCeHFwTXNCeFNkbXEr?=
 =?utf-8?B?ZEpidHRwR0IrT1J6U3J6YVNRWVI1OFNFc1d3aEwvTk5HUUN0SmVHU1ZIVTh3?=
 =?utf-8?B?cEZJMkQxaGpSb09PcXdtWHRnekNHM1A4ZnJOQTMrMkNsdGFtYWx0TDVEWE80?=
 =?utf-8?B?VWtWanMrQWNwU3lZeWg4T0NaeG5CTm80ajFlbEZsRUlVaVJOTGxJOVB6TzU1?=
 =?utf-8?B?blc1aVJmbnM1QWlVYXhBN1BNeUZPdWNvQ25YbGdLWjVWeUlXejkxMmhZb0Vs?=
 =?utf-8?B?RWEvSTU2c1FieTJIdE5WL2ZlWmRBN3NRc1Z2UVB1UFdrRlcrVm1pZU8wdk5G?=
 =?utf-8?B?dldyT05aVG1CSk5uUTNlNktTbk5lUFF5VEZZUWdwVHJtNDFqNitqSHBRb05a?=
 =?utf-8?B?VVROUmk2WXd5U0lZaU9ZaVRrSElBblh1RkNLaXIzUnpBcFRmMmloZ3V0a29i?=
 =?utf-8?B?eHpMT0tmQXpPckZCeE5nOHdkbFpuVEIzS2c1NHBDYzhMdDI1TUxIRFhjSnlo?=
 =?utf-8?B?Vk50My82Mk9EVGtONEJHQkRwZmdLWjNPOGtFcnJWUnBLVENzaktJYURvMTll?=
 =?utf-8?B?ejRzUklNSWdVWFZRRVRVWkIvMEZncTBRTVg3am5TVmdJMTBjV1NXcnFSbVRr?=
 =?utf-8?Q?BoZdB492t/8CCyG4bDIljWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62C8622F3EAF9046B605613600C9ECCE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f7cd29-c39b-4839-e07b-08dd5117e191
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 19:01:56.6719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5pN0u+cBh7BO4ex5JH3VTOUh4UHZ11rdsAns+jvsG5ig9RV7fbCiLcBuHe5ElP/j40McNe28ThS0hEGR4aEx0Nl2rsmgXySTlj+l3DIl5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5211
X-Mailman-Approved-At: Wed, 19 Feb 2025 21:04:12 +0100
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

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE2OjE4ICswNTMwLCBDaGludGFuIFZhbmthciB3cm90ZToN
Cj4gQWRkICJib290cGgtYWxsIiBwcm9wZXJ0eSB0byBuZWNlc3Nhcnkgbm9kZXMgcmVxdWlyZWQg
Zm9yIEV0aGVybmV0IGJvb3QNCj4gc3RhcnRpbmcgZnJvbSBSNSBTUEwgc3RhZ2UuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDaGludGFuIFZhbmthciA8Yy12YW5rYXJAdGkuY29tPg0KDQpSZXZpZXdl
ZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+
DQoNCj4gLS0tDQo+IA0KPiBMaW5rIHRvIHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjUwMTA3MDkzODQwLjIyMTEzODEtOC1jLXZhbmthckB0aS5jb20vDQo+IA0KPiBDaGFuZ2Vz
IGZyb20gdjEgdG8gdjI6DQo+IC0gTm8gY2hhbmdlcy4NCj4gDQo+IMKgLi4uL2FybS9kdHMvazMt
YW02OC1zay1iYXNlLWJvYXJkLXUtYm9vdC5kdHNpIHwgMjggKysrKysrKysrKysrKysrKysrKw0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vZHRzL2szLWFtNjgtc2stYmFzZS1ib2FyZC11LWJvb3QuZHRzaSBiL2FyY2gvYXJt
L2R0cy9rMy1hbTY4LXNrLWJhc2UtYm9hcmQtdS1ib290LmR0c2kNCj4gaW5kZXggNGNhMDVmMzJm
MGIuLjY3ZGIzNWZkM2UzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvazMtYW02OC1zay1i
YXNlLWJvYXJkLXUtYm9vdC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9rMy1hbTY4LXNrLWJh
c2UtYm9hcmQtdS1ib290LmR0c2kNCj4gQEAgLTQxLDYgKzQxLDM0IEBADQo+IMKgCWJvb3RwaC1h
bGw7DQo+IMKgfTsNCj4gwqANCj4gKyZjcHN3X21hY19zeXNjb24gew0KPiArCWJvb3RwaC1hbGw7
DQo+ICt9Ow0KPiArDQo+ICsmY3Bzd19wb3J0MSB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+
ICsNCj4gKyZtY3VfY3BzdyB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+ICsNCj4gKyZtY3Vf
Y3Bzd19waW5zX2RlZmF1bHQgew0KPiArCWJvb3RwaC1hbGw7DQo+ICt9Ow0KPiArDQo+ICsmbWN1
X21kaW9fcGluc19kZWZhdWx0IHsNCj4gKwlib290cGgtYWxsOw0KPiArfTsNCj4gKw0KPiArJnBo
eTAgew0KPiArCWJvb3RwaC1hbGw7DQo+ICt9Ow0KPiArDQo+ICsmcGh5X2dtaWlfc2VsIHsNCj4g
Kwlib290cGgtYWxsOw0KPiArfTsNCj4gKw0KPiDCoCZzZWN1cmVfcHJveHlfbWFpbiB7DQo+IMKg
CWJvb3RwaC1hbGw7DQo+IMKgfTsNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMg
QUcNCnd3dy5zaWVtZW5zLmNvbQ0K
