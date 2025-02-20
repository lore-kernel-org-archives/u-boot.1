Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72582C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 12:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4EF5801BE;
	Thu, 20 Feb 2025 13:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="DymUFc3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDDA8007D; Thu, 20 Feb 2025 13:55:21 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC3B8007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 13:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAutWTN3cNPtGpY2LJBd9ApAoKRABlcrXqS4GTvOeTf5z6CE/Tekj9JPpg+J5mPxfEQ+NycHCmy89MtXR5kKD/3HuRG7V5rL7HdcUVV4/zHgivhyzVxu6TctHsITUxLI2yR49OXo1SEEo4CJ9KOwXv54YO5leP5EN9TxezaXXpMPHKAIwCGkeJ6DM5vqFmoT2gJRcY1OY6EiR+g3cTpjHY4mW4TFdcggpIhyc2dfmDO7sSXqv/kc6D90UMqYLrTlW1OyFN2gukW5sygE/j/vRsGMJO7IGctG2GZQkeQmGEdLVjOqIXnK9+tqYkThzjk07IhHx0E+xw9zbizgNtI5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OgMJ1CgkdK2e5IWvbGIP/7+LyaPXXj48Xxvqb/XxCw=;
 b=kxoKNoS8Vu60+LDyLoh4D3UNDyzt4JdLgp9d0VF2tf7xv0ombSjjHj2wifc7tLrDYL9i6rbqHLbXWcLsb0vbBGZ+XjCQWxwTSKAqTCYjFC517YFNEkNSw1o01MkoRT8ZtD2F6O3uJYbNfNWR9J13R3paVBchAk7VzmSKAK4kY8fisrSenxNGUq0+cYBivW+ZNYFc8L/THcy0wrA67hIiHTThnxbSmFiru4i/VOKS+iDSD0kCWugIiXFdxLcHetMWIkAEi3LdeqKLT085bRcdDWHRulOTLZa7BpXlowpGzPuj4loY7B1qPI2i+5X9avBzkLRrXQiYkeRo6AJAUylVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OgMJ1CgkdK2e5IWvbGIP/7+LyaPXXj48Xxvqb/XxCw=;
 b=DymUFc3WDVmAjhsz978C9MHyUgOxSm6IzLHKF4yMopriUNDStsTIRI6i3Rtmo0aIuxLOeBQS78Ctnhq7dqx0uZz3egex5TGOfQJs4ieiJdCVSOhbtMW5F+/ENntMBPzjHDwcpUxqgS78scHbdmX+otvPRhUNa+ihrkTPiYbKcl+eehE/7jkgtLmessydRQRHbDR3c192CrRVsy5hr2iS0MtaY6mqAGUSBSz6gqc4SXVqv+eaQ9DGHheSW2vnuMrV4aoT+lbEJQeKXINEKVJ0usNu0jSfSqC9slrqTA1qjn59SHY7Ppa9r8QZdeIgSzr9jyEiV/SmqHeEjKY9qPPPSg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU4PR10MB8653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Thu, 20 Feb
 2025 12:55:17 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 12:55:16 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>,
 "afd@ti.com" <afd@ti.com>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>, "hnagalla@ti.com" <hnagalla@ti.com>, 
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "sughosh.ganu@linaro.org" <sughosh.ganu@linaro.org>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "sjg@chromium.org"
 <sjg@chromium.org>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "kishon@ti.com" <kishon@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "bb@ti.com" <bb@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Thread-Topic: [PATCH v2 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Thread-Index: AQHbgrvn0zPeRVmEjUqeAavhl+tFeLNO+HyAgAATpgCAARvFgA==
Date: Thu, 20 Feb 2025 12:55:16 +0000
Message-ID: <c3287f3b4a023fd7b99df1a085ee61e67fe464aa.camel@siemens.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-2-c-vankar@ti.com>
 <752c404bcb63afaf78055f39d583055db44f82a3.camel@siemens.com>
 <2d6a2eae-3825-4a03-a29c-4775f38dc535@ti.com>
In-Reply-To: <2d6a2eae-3825-4a03-a29c-4775f38dc535@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU4PR10MB8653:EE_
x-ms-office365-filtering-correlation-id: b588c42a-3bb1-4f65-4322-08dd51add314
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Vjg2L0UyK3lxellFN1NNYytRMVZ5VzZhRlBsVW9hN1dtcnFWbTFZbFE0bktI?=
 =?utf-8?B?bWZoM0YzdldOcTlqYXV5WEc0NWNTVC94b0ZsMm51SkxGZG4xcjJraEMrcE5C?=
 =?utf-8?B?NksrN3ljL3MxV1h6UExBQ3UyZEN0cmxaRXJzUzNSVk4zU1A2dXhsb1M2VXpk?=
 =?utf-8?B?bWp6TWxMRWVzZU1INGI4L2svTGp3NjdxYk1GLzFUdlFyNkpNWHM3UUlBY2Nh?=
 =?utf-8?B?TVJsMG5WdnpLNUJNUjdFaEQ0L0ZqYlpOSmFkV2NST3hFTzRDL2VTdmFGOGxR?=
 =?utf-8?B?SkdjUGFvd2lJOFVGRlZCQlk5RUtIZU5UMHFiRFNvUFpYWGxyR0o3aldDVTZO?=
 =?utf-8?B?N0cvcDRBYWowVDRyWG9GN0xTbmY5b2NocDVPUVk1OHQxeFRPUnpTRVBybGpx?=
 =?utf-8?B?ZGhNY0VXdW1SS1BmMUJxSWtMOEMxU3Rva0JjUjZ1NEJ1Um82UmdOaEtXQm9w?=
 =?utf-8?B?dnFQQ0poNEhCUWM3Y3hrU2RUdkFkb2Y0WHVHZ3VKMGVkeXNKdUsySzRoNElH?=
 =?utf-8?B?bDUrL2VkZlU5UnVCT2I0SFlvS3ZmbXNON3F4eVpyVkZHbUF5VFRLdHE0Z3Jk?=
 =?utf-8?B?MnZqaHg0RlFuTUc5b0Q0UkxkR0xyb0ZmcWozZCswRk02bWR4ZVhhU2pJMi9y?=
 =?utf-8?B?QTVUckN0b25KOFFBTW5uSEN4OHJYeTFjOUF3dlJVV3lmSXNOTUJNZVZhQTBC?=
 =?utf-8?B?bVVXUUYyeHdGb25VTk1RaFhTd1Jaazd0VCt2RzZLMXNOOE5waFk0OE5FbTRr?=
 =?utf-8?B?UkRlcXg5OVpiN0czNGp0R3pDWjcrd0RrUzFLT2Jhbnh5enZJMVNuWUNDaG1X?=
 =?utf-8?B?TVJTT1JzN2liSUpqdGEyMzk0NHdiMGdoQkR0Nzd2Rk5XZVIzSXM0ZHhBbGtC?=
 =?utf-8?B?dW1nbW9WZWtQZDBpTEJiTk9IbXNYbUN4U0dXcFpuQk11aTB3MTVXUmo3a1lR?=
 =?utf-8?B?b1dFa2NFMVp1WnhOL1gzeGozcjRMOTNQa21qR25oOUs1V0hGYlU5YUl4MldQ?=
 =?utf-8?B?andRNVhYTnJEQkZLYUxJS0dlOFhQVGdEaEZMUHpmbTdaT3VON05OaGZQYlVW?=
 =?utf-8?B?dGNGRmpaR0s0UHRJK0ZlbGJPamlPZ1ZMRmd4aWx1aXMyNEJvYVhTT2hpRVYy?=
 =?utf-8?B?aU1NNFhrTW0rYVpFcVpqSFZUZC80QXUrUG1GcjZDVnJuVEk1OTRkek5TdDNE?=
 =?utf-8?B?TE1NaTRpMXA2ZHNjdEI2UW1YNDFpbUdwMVhmWGFsTlZ6SzlVOCtKeDJJMWlG?=
 =?utf-8?B?SzVkZ3F4emlNMWp2em8ybldrajc2bWl4TWUxWVdOTU01ZG90a2ZnYjEvdk5r?=
 =?utf-8?B?Z0t2YTVpdW5pb2pTMDNYNlh5b25nODJUSXJFWHdlenhqSENhOERVWWR2YWpB?=
 =?utf-8?B?MmpCWU5mQkVxdWViTlluK3pmdHkzbzBrTGp4VXRzYW1IZDhkWmw1TGJrMlpk?=
 =?utf-8?B?andUQm5ycnNoaDRmbVBuU0pnR3BoZjEvU3czQzlzWnFMa2FiMzcxcTVNaG12?=
 =?utf-8?B?RlNZQTFTK0xyTzI5VmpOd0g1RlNFTUNiSHo1NFVNMGZHanJMQ1E3dnAxNUow?=
 =?utf-8?B?YjhhU0JUU1d0cWpwUDUzeTVEWWxIMlgyZnhMcGt4TkZxdGxlYVZBS2xHM21C?=
 =?utf-8?B?N2cxTEZrRzF3SWpvUHJSazk4cHJtQ1N3Ty9JWGhkRTEyb3dYWFFJNmpJYmdu?=
 =?utf-8?B?TTY1YXlCbnlhUFZGRGxmc2M4TkRoTU5VNEJxREpkTmZZd0Q3VmVxZHlGak1x?=
 =?utf-8?B?UERyd1JJOEVOZ1c2aTdYcndQeFNrL3JocWpPV2x6T3l6MTVobDdxK2dsZ2V3?=
 =?utf-8?B?UWt5ejhyVWt0a1BSMVJZeExseTdSa3pCSitSaWVseGF2TjhVVWVDN3lOcWpy?=
 =?utf-8?B?eXA1ek1TV29acGJiM1FrVDBjanpaT041WEJrVkNBVmRtVUdGOVdZUnVla0V0?=
 =?utf-8?Q?0YWhzlbB20w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUNIZzY0U2NITEN0YndxNWw2U2FzcnR6Wlo1WjNjUm00KzczWHJpVyswUThw?=
 =?utf-8?B?TEVQSDAwVVhXL1hDSW4rekYyc3Jadk9IOU1nSTlkQ2g1bktWOVh6dGs3ZlJj?=
 =?utf-8?B?QjVJSjhtZWRFaXlzZEx1d0VER3NQTFNjYVJKZzBXaGZmWHNYaFVOa2k2NmY3?=
 =?utf-8?B?MG5oVUVQcDBBUjdvVjViYXAvMHhuVUhkN0c1K3hzU0hjYytLSGxtZ2p5alI1?=
 =?utf-8?B?amFUYWlBekwxaDNPNDNFUkJVTm9HUVZUUC9HbTYrcGZJdVpObjN5a3pRcTdQ?=
 =?utf-8?B?ZVZ1TTdnQjAxYjY0YndhVjFHMzBHckJ3RUEvQ0RrdENoeWhSeUQvcThwaWxh?=
 =?utf-8?B?S2MvOG1uTHpIcG11dE8rQzIvQWIycDgzd2pONWJlZ2ErTnN1R2JONzJsVGhj?=
 =?utf-8?B?MTdpVDRkcG5QUEd0eU1vRzltdTJKUnBHMjN0L3FNdEtTaExvMFBtTHNlc01U?=
 =?utf-8?B?dWVFMjVReGJnQlNBczg4Wm93L3RLV1BNbHFUb2IzN1Fyb0d2RjA5Q2hnVC9q?=
 =?utf-8?B?L0w5V0FjSjEwR1JweE1yQjVPV0VMTWpUMlo5MnJKSWFjaCsvNDM5Qi84WDdN?=
 =?utf-8?B?ZGkzSklod0x3ODg0aWptLzZuSTBPbVJ1MFVyd1I3MEYyQVRFNkpCeUhCWXRv?=
 =?utf-8?B?b1dPNmFDVVJXUVVIMzFDVnFxVU41c2RpMGFkWDl1RXJNMW1qSVNPWFE3aEdx?=
 =?utf-8?B?cnBRMVdFb283QVZaWXJUb0NGTlpXenJrNmN6VFhqK0dTYVNUMGJsT0NiZXV3?=
 =?utf-8?B?L0QwQ3BFbU16ZW96bUhDVkhsWTR5Rmp3a3N4akFIaXV5Tk5xdW5GRGVRZlFO?=
 =?utf-8?B?TzZxTkhYUWo5ZU8vajc2dDltbW5KYTBqTlB6V2VmYTVFZVpHa3JMQXdGVVI3?=
 =?utf-8?B?UEdvaENLMXh2MGQ5amJtR0FuS1RrdFlWUkdsRk84WjJnUW1mdlluMUZyakFE?=
 =?utf-8?B?OWt0blg5Q0t5dGV5d1pKM2FjRGxTSVFPZytqMzFiQ3NScnZKTEFoUlIxOVdz?=
 =?utf-8?B?Y3JTaWtyb29NWVFNdUczVzA3YXlJRE9Zc2xvOWRWdmVtSG9ma2NudlRXVGph?=
 =?utf-8?B?VmNYTFJrZ0wrbW1OUVRMdmMxV05lSEdzZFJIUW42dUVyc01JSEN3VEw3eEZ2?=
 =?utf-8?B?NDVJcGN6V3NIeTdxV3orZGZFRUdFY05IN3o0TXFkM003UzJKWk1JVzNUZS8z?=
 =?utf-8?B?aEswM3p1VHhuZTBIc2tvYldjT0grZFhRS1BhbUo1TkhGWnpLREY1bHdwdG1w?=
 =?utf-8?B?aTAyUTlkQm50N2E1dFA4cmtwMjRsM0J1eDI1ZUVPNXVFN0JMTGttWHpuSEg1?=
 =?utf-8?B?RnBySy96aHJZeEFDT1pZZXVkS1ptRFkvc3Q2ZmxxclpqemJMN0lCT2YxeUYw?=
 =?utf-8?B?M2dPRWhTYUpqL0NVL3pyK0xBU1hxc1VtOE1CL3BoeitiMTBkVmJHYXpzUE43?=
 =?utf-8?B?UXA5UkxnNDZWK0tIK2tleUgyVzFSYWkvUnorZHFHM2hpNGhxbjdpbXphdE5G?=
 =?utf-8?B?UysvK2N2RlZBbCtYRng5Vzk4dGN3UzNNN3JRUVhDdmo3YzJsM3MycTkvbDlZ?=
 =?utf-8?B?eXNENklDcUxWSFdEM2ZWdCtBMlZHVXJKQ25xUkQ4SjVlcTU4b1M5L0V6QmxX?=
 =?utf-8?B?U0s4ZmdOdDA1RjQ2MmlvMlFnZ1FNMmdQQWIvZVB6bUpVRFpIOGlkQ0xXSTJs?=
 =?utf-8?B?L0daMDV2Z2RKajk0c3gyRVhqZkJjYVRBUlJRVGZROU9zdlRUWEtCV1VkUXk0?=
 =?utf-8?B?TStlUEFuNU5kWlM0MWxueHhoeXVjV2xqZGRZbUZjQWhqcXEyU1NqVTN0MGw1?=
 =?utf-8?B?SGpTN0d3MXA4U280MTByd2tTZkhUdGFHdzlhQVdMbFM0eHh3SnFWOGNmZ0pX?=
 =?utf-8?B?TUcvMnVraFJuUXdiOVVYaWY3a1VSR3RJSmhRMmZwTHprYVI1RlkvSXA0bmZ0?=
 =?utf-8?B?bW1wbkZKOXVGQnUwMExIU21oMlFwWEl5VUdrM2dIMExBcTM0K09XaUVsVXI4?=
 =?utf-8?B?Q1c4cllLZmI2Z3FXcm5mWk8wb09CNUlraThETi9RdVAvRTJCVVI5RTg2U1h4?=
 =?utf-8?B?V3ZUVTVUTUh6Y1BVYmhxd0JpU3k3bEF1QWd4NFJBUGxOV3NZRGRTUEhCSTha?=
 =?utf-8?B?WUJ0MFc0dzRjYXlCYmNtQjVHMTYzU0RoWkdMUGNnQm1xcUg5REhrOXJYYWVm?=
 =?utf-8?Q?tKYuNpRwqv1wDJiRT0rNScI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F53AD4F3B1C0A42AD2138E8C52D510C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b588c42a-3bb1-4f65-4322-08dd51add314
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 12:55:16.8955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1k20VebrACgi59jkeQ6HuoAfbCtbU6MAUZR0OmfzVMTAp+/Fnw273nBp/lJ8VSxUg0uWnpeicTNDQTMIqQZVKU/PnU1fY3uMF2ch2Coyfgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8653
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

SGkgQ2hpbnRhbiENCg0KT24gVGh1LCAyMDI1LTAyLTIwIGF0IDAxOjI5ICswNTMwLCBWYW5rYXIs
IENoaW50YW4gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI1LTAyLTE5IGF0IDE2OjE4ICswNTMwLCBD
aGludGFuIFZhbmthciB3cm90ZToNCj4gPiA+IFRvIGFwcGVuZCBhIHN0cmluZyB0byBhIHRmdHAg
cGt0LCAidGZ0cF9zZW5kKCkiIEFQSSBpbnZva2VzICJzcHJpbnRmKCkiDQo+ID4gPiBmdW5jdGlv
biB3aGljaCBjb3BpZXMgYSBzdHJpbmcgZXhjbHVkaW5nIGEgbnVsbCBjaGFyYWN0ZXIgY2F1c2lu
ZyBURlRQDQo+ID4gPiBub3QtbnVsbCB0ZXJtaW5hdGVkIHN0cmluZyBlcnJvci4gSW5jcmVhc2Ug
VEZUUCBwa3Qgc3RyaW5nIGJ5IDEgdG8gYXZvaWQNCj4gPiANCj4gPiBJcyB0aGlzIGVycm9yIHZp
c2libGUgc29tZWhvdz8gSG93IGRpZCB5b3Ugc3RvcCB0aGlzIHByb2JsZW0/DQo+ID4gDQo+IA0K
PiBZZXMgdGhpcyBlcnJvciBpcyB2aXNpYmxlIHdoaWxlIGxvYWRpbmcgdGhlIGZpbGUgdmlhIFRG
VFAuIEkgdHJpZWQNCj4gdHJhY2luZyBiYWNrIHRoZSBlcnJvciBhbmQgaXQgd2FzIGR1ZSB0byBz
dHJpbmcgY29weWluZyBpbiAidGZ0cC5jIiBmaWxlDQo+IHRoYXQgSSBtb2RpZmllZC4NCj4gDQo+
IFNpbmNlIGNvbW1pdCAnZTJkOTZhYzllZTlmODFjOGY3MjQzNWJmZjU1ZjkyNGQyN2FkOTJkMScg
aGFzIG1vZGlmaWVkDQo+IHNwcmludGYoKSBmdW5jdGlvbiB0byByZXR1cm4gdGhlIHN0cmluZyBs
ZW5ndGggaW5zdGVhZCBvZiAwIHNvIGl0IHdhcw0KPiBub3Qgc2VlbiBiZWZvcmUuIEFsc28gZnJv
bToNCj4gaHR0cHM6Ly9naXRodWIuY29tL3UtYm9vdC91LWJvb3QvYmxvYi9tYXN0ZXIvbmV0L3Rm
dHAuYyNMMzQ3LA0KPiB5b3UgY2FuIHNlZSB0aGF0IHdlIGFyZSBpbmNyZW1lbnRpbmcgcGt0IGxl
bmd0aCBieSAxIG9uIGV2ZXJ5IHNwcmludGYoKQ0KPiBjYWxsIGJ1dCB0aGF0IHdhcyBub3QgZG9u
ZSBmb3IgdGhlIGxhdGVyIHBhcnQgdGhhdCBJIG1vZGlmaWVkIGFuZCB0aGF0J3MNCj4gaG93IEkg
Y29tZSB0byB0aGlzIGFwcHJvYWNoLg0KPiANCj4gPiA+IHRoaXMgZXJyb3IuDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IENoaW50YW4gVmFua2FyIDxjLXZhbmthckB0aS5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+IA0KPiA+ID4gTGluayB0byB2MToNCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNTAxMDcwOTM4NDAuMjIxMTM4MS0yLWMtdmFua2FyQHRpLmNvbS8NCj4gPiA+
IA0KPiA+ID4gQ2hhbmdlcyBmcm9tIHYxIHRvIHYyOg0KPiA+ID4gLT4gVXBkYXRlZCBjb21taXQg
bWVzc2FnZS4NCj4gPiA+IA0KPiA+ID4gwqAgwqBuZXQvdGZ0cC5jIHwgNiArKystLS0NCj4gPiA+
IMKgIMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC90ZnRwLmMgYi9uZXQvdGZ0cC5jDQo+ID4gPiBp
bmRleCBmZDljOTQ5MjkyOS4uNDIwZWE5ZWNmNmMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvdGZ0
cC5jDQo+ID4gPiArKysgYi9uZXQvdGZ0cC5jDQo+ID4gPiBAQCAtMzQ3LDExICszNDcsMTEgQEAg
c3RhdGljIHZvaWQgdGZ0cF9zZW5kKHZvaWQpDQo+ID4gPiDCoCDCoAkJcGt0ICs9IHN0cmxlbigo
Y2hhciAqKXBrdCkgKyAxOw0KPiA+ID4gwqAgwqAjaWZkZWYgQ09ORklHX1RGVFBfVFNJWkUNCj4g
PiA+IMKgIMKgCQlwa3QgKz0gc3ByaW50ZigoY2hhciAqKXBrdCwgInRzaXplJWMldSVjIiwNCj4g
PiA+IC0JCQkJMCwgbmV0X2Jvb3RfZmlsZV9zaXplLCAwKTsNCj4gPiA+ICsJCQkJMCwgbmV0X2Jv
b3RfZmlsZV9zaXplLCAwKSArIDE7DQo+ID4gDQo+ID4gQnV0IGl0IGRvZXMgaW5kZWVkIHByb2R1
Y2UgXDAwMCBvY3RldHMsIGJlY2F1c2Ugb2YgJWMgd2l0aCAiMCIgYXJndW1lbnQsIGRvZXNuJ3Qg
aXQ/DQo+ID4gDQo+IA0KPiBXaGlsZSBkZWJ1Z2dpbmcgSSB0cmllZCB0byBkZWJ1ZyB0aGUgcGt0
IHN0cmluZyBhbmQgSSBjb21lIHRvIGtub3cgdGhhdA0KPiBiZWZvcmUgdGhpcyBwb2ludCAnbnVs
bCBjaGFyYWN0ZXInIHdhcyBnZXR0aW5nIGFwcGVuZGVkIGJlY2F1c2Ugb2YNCj4gaW5jcmVtZW50
aW5nIGEgcGt0IGxlbmd0aCBieSBvbmUsIGJ1dCBub3QgYWZ0ZXIgdGhpcy4gSXQgd2FzIGp1c3QN
Cj4gYXBwZW5kaW5nIGEgc3RyaW5nLCBzbyBpdCB3YXMgbm90IHByb2R1Y2luZyBhICdcMCcuDQoN
CkkndmUgbWFkZSBzb21lIHRlc3Qgb24gbXkgc2lkZSBhbmQgY2FuIGNvbmZpcm0gdGhhdDoNCi0g
dGhlIGFib3ZlIGZpeCBpcyBub3QgY29ycmVjdCBiZWNhdXNlIHRoZSBvdXRwdXQgaXMgYWN0dWFs
bHkgc2hvcnQgYnkgMiwNCiAgbm90IGJ5IG9uZSBpbiB0aGUgYWJvdmUgY2FzZSAodHdvIHRpbWVz
ICVjIG1pc3NpbmcpDQotIHRoZSByb290IGNhdXNlIGxpZXMgaW4gdGlueS1wcmludGYsIG5vdCBp
biBURlRQIGNvZGUNCg0KSSBiZWxpZXZlIHRoaXMgaXMgb25lIG9mIHRoZSB3YXlzIHRvIGZpeCB0
aGUgcm9vdCBjYXVzZToNCmh0dHBzOi8vbGlzdHMuZGVueC5kZS9waXBlcm1haWwvdS1ib290LzIw
MjUtRmVicnVhcnkvNTgxMTQyLmh0bWwNCg0KPiA+ID4gwqAgwqAjZW5kaWYNCj4gPiA+IMKgIMKg
CQkvKiB0cnkgZm9yIG1vcmUgZWZmaWMuIGJsayBzaXplICovDQo+ID4gPiDCoCDCoAkJcGt0ICs9
IHNwcmludGYoKGNoYXIgKilwa3QsICJibGtzaXplJWMlZCVjIiwNCj4gPiA+IC0JCQkJMCwgdGZ0
cF9ibG9ja19zaXplX29wdGlvbiwgMCk7DQo+ID4gPiArCQkJCTAsIHRmdHBfYmxvY2tfc2l6ZV9v
cHRpb24sIDApICsgMTsNCj4gPiA+IMKgwqAgDQo+ID4gPiDCoCDCoAkJLyogdHJ5IGZvciBtb3Jl
IGVmZmljLiB3aW5kb3cgc2l6ZS4NCj4gPiA+IMKgIMKgCQkgKiBJbXBsZW1lbnRlZCBvbmx5IGZv
ciB0ZnRwIGdldC4NCj4gPiA+IEBAIC0zNTksNyArMzU5LDcgQEAgc3RhdGljIHZvaWQgdGZ0cF9z
ZW5kKHZvaWQpDQo+ID4gPiDCoCDCoAkJICovDQo+ID4gPiDCoCDCoAkJaWYgKHRmdHBfc3RhdGUg
PT0gU1RBVEVfU0VORF9SUlEgJiYgdGZ0cF93aW5kb3dfc2l6ZV9vcHRpb24gPiAxKQ0KPiA+ID4g
wqAgwqAJCQlwa3QgKz0gc3ByaW50ZigoY2hhciAqKXBrdCwgIndpbmRvd3NpemUlYyVkJWMiLA0K
PiA+ID4gLQkJCQkJMCwgdGZ0cF93aW5kb3dfc2l6ZV9vcHRpb24sIDApOw0KPiA+ID4gKwkJCQkJ
MCwgdGZ0cF93aW5kb3dfc2l6ZV9vcHRpb24sIDApICsgMTsNCj4gPiA+IMKgIMKgCQlsZW4gPSBw
a3QgLSB4cDsNCj4gPiA+IMKgIMKgCQlicmVhazsNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
