Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A182BC3DA61
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 01:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39ED884C5;
	Thu, 25 Jul 2024 03:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bSde0CE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43ACB88800; Thu, 25 Jul 2024 03:21:47 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D42871C9
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 03:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXkm67Z5mi8ZFQHhQoMz9QAcmkb7TryM57nesCvtpuAR2LGSyexCt8FhWlVSlLNYycMi7BvUY+nHgh6cjhIjly0ikZ9y9DhJRCcpUu3od4cnne2gSZcu1rt7q+/mu7fJgMMqZ2B0RMSh2vmC0wpToMrPPD52vM80wMnZr8PcIXsoXQccaN1WsY0qHWFz6nF9fs0CU6zdbpt97H+X7bnrDQqPTOLUl+oPrFHpQKtxaxzVbVGGUDmHA7pftKvwbvl84AXIV8vcXjBZLepozvASLFxpqK3IQGGxYGb8XoeZIQEqGnR7hNMCcJ37mY5YmTWN2SzA920ke314KReeue+1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAwQCmID/9+I8RklDfL50bXFJK/8KI0Js8pKU9ppXmA=;
 b=GXWwcyrdni7pcgl6ERu6raU1w3W/81k5Q8LhgxBD1jNCNk0zsFuJ1M5HVisjetPaJj0GsXflKlq3QLuQ69tNZmedKIH3A0G+PmHCWD7vlUe1OV7TN5+X/xURcd5bI+aI+VGVHQG5vArYvGnRJXXGxhyp65QRpXFQBeZtwzuwHnAMc4M/HF2x8chnwEQ6t6m3Z6MlAOikCVdIoAPAjdPHNBmjFUcOOyagrwtbRWufZXHCWZCgeWQ+VT9gg45Y2erAcO6V5edZ7yPjJfS/dDWTAa8hrz6uBCi5oz9jYPvpcGSAkSedEFXnndP8h7fHWdxDf5fizlavJUjA+bEyOFchxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAwQCmID/9+I8RklDfL50bXFJK/8KI0Js8pKU9ppXmA=;
 b=bSde0CE7iJ7ZsOrbtF/rhqWhQsWzj8siBLGMRlf+q7pR8SYeEh2mGg/rjL6m8xXE6xGDXjpDGygvTnBAQPE4y72V/bGxuTK4OqWNPKiOl4sf1oRzU438kK+VRm6nIgMc1KbIjzIvcDuDdLpIhPLppTa0Wmkb8A7FXzzfUJqHHkpLQCjHTAkzw2Vg/452v5BmD3sipy9WqMee4EEtJzejesFy7QMs8/lJWus8tR4enCxt45xC9GXoOLVhJDQN8dsoNhQglobWy0rrfrxE6oJ/pftUvL0ivXPNOtMy5d8mgGiCxVFS8/c4UDRRTNuoV2piOF8iM+3IhKAlmWXDvTRcYw==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 01:21:43 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 01:21:43 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>
Subject: RE: [PATCHv1 1/5] cpu: add release_core callback
Thread-Topic: [PATCHv1 1/5] cpu: add release_core callback
Thread-Index: AQHa3Q6p6AQz5shBmE2ldOYdLY+pzbIF89SAgACzIRA=
Date: Thu, 25 Jul 2024 01:21:43 +0000
Message-ID: <DB9PR04MB9236A0F6BD4A1934E13E885C84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240723150400.16650-1-Zhiqiang.Hou@nxp.com>
 <20240723150400.16650-2-Zhiqiang.Hou@nxp.com>
 <CAFLszTiXhnZ+=e1d3k0izMAYtPOHKb2bbdubrkB-kPL+KdXfjw@mail.gmail.com>
In-Reply-To: <CAFLszTiXhnZ+=e1d3k0izMAYtPOHKb2bbdubrkB-kPL+KdXfjw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DB8PR04MB6986:EE_
x-ms-office365-filtering-correlation-id: 430861cb-9d35-4fa3-0508-08dcac4824f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkJZQWRLSnJneHFyU0FjVTB0b1ZPYjB2ZzBZT3h1VlRKM0FJTktjQzgyZElV?=
 =?utf-8?B?SnJXWFpHcEMzUEprWkl2cVl4NWgzeExYdWtVWmNaMGpxeXBPSllsbU9FaEZH?=
 =?utf-8?B?d0NZUHVxV2VTd3pxYnZndzVhQWYwYnpha1Y3ZHAraXRMVUJXdEttaDYxOXNC?=
 =?utf-8?B?Sk9mcVVObkhJUEVLVkQyN3NnaUorVDg5Wkp1N1hTUUk1RlJlZ2tnQmFFM01I?=
 =?utf-8?B?UVZBVTNQYU1LekVsNFNVU01heDNCQmN2cVppN2dEWWZnanhCekUrS2d0Wnpk?=
 =?utf-8?B?cjNjTitUUzgzbFZERHQzeWw1N1JNMTRXMS9sNG1PaVRJaW9TZXk5ZDM4em5L?=
 =?utf-8?B?YXJydFhyNVdlcXFGV0daNWd0d1orY0Y0SitpemJKTGJjZW1UeTRUZGpIN0JC?=
 =?utf-8?B?TU5NUlFKS2VTSS9RVFdkZVBPWitHTWo5UllBdVdlUUk4dDBtMGJNM2hveGpL?=
 =?utf-8?B?Mkw5bXBEMmQ5elhYZW11K3AzSkpaSlBXcDB6dmtuOEExYnlVTnlnd21vK2RJ?=
 =?utf-8?B?dW90U0NiUXpOS0Q2OHJ6TFZCdTcyVkpSTWlhUFJkNisyaTdOaEpoYjFBd1Jn?=
 =?utf-8?B?VFBjMkk0NzAwQmFZSlpJMTU1WklDQm1TTzlXSlFIZnRUUGR6YTR5eTlDQTdq?=
 =?utf-8?B?N1h2V0dmKzJ2cWFyazRmeU1wZkRZT29OZHhWaytVVHUxQVUyOGkxbzcrQ0ww?=
 =?utf-8?B?RTJ2RXphaXRZYjFXMENJTmZFd1lmeG1weGV2NjdQbzRXN3JLTTcwS0dnaUd6?=
 =?utf-8?B?aGl3RFp4Yjk4UmcyTldGZVlSRGVpNWdvUWMwd3I3UDY2ekZ4YXpiNUdSRVJi?=
 =?utf-8?B?RzRXSDVnMWdPeld0RzQ4T2lzN2hhN05hS0RSR0pYbUo4VFFBbEdLbHJvOGZ6?=
 =?utf-8?B?UjVvY3NBMElFdDMrTElWZUM3dkhWR0NQd3hBQ0tFQUdkZEFLTnRLSVNIWDJr?=
 =?utf-8?B?SUV5Z2dublo4aHk0cU1INmhYTGVpbTFlb0J5NzdGTE8xYlROY2RDbGZpaGk5?=
 =?utf-8?B?S1BWRkRXN1Jwc2tWQ1c5elE2cjk4b01VYW0xRUNtcm54aUM0Ymh1WEU0WDgv?=
 =?utf-8?B?WDJhNTdpVklSZDcyam1jQ2Q3dTBLTjQzbEZGdHRQSzRaTWRmQ3F4ZnU5TUd3?=
 =?utf-8?B?Q1ZFeEUxVFZuSUJjejhNeDdRV0FRT0ovRkdSRW9CbFNMTFJZQlpzTUVibk83?=
 =?utf-8?B?OGV5bTdWUlV3WjlHYkRRb1F0WmRNNkNUeUVEU1h5M3QvRFpiR0NVQXNDTHdl?=
 =?utf-8?B?MjVWTUlEaGRNRHhPaTl4M3JudUhrMnJzT3RGMU55MWdJVlFNeW1WQnV5UzZa?=
 =?utf-8?B?Q3FqaVRrdGNWTmRhRExaSTBCZmdMTTFyZldxWVBBYXlJbStFZXlqdk1sRVFW?=
 =?utf-8?B?SkU4ZXArZVlySmtLNkIrM2ZJS21xWjZTRm5MZ0NJWnBzVUxpaGZSdk8raERa?=
 =?utf-8?B?RDVhOW5FZFl4V3pEMWRoQnYvWXd2M2puNEVVUGxaNVREaUNiM041L2FFYWRI?=
 =?utf-8?B?a2ZVMnViU3hiSWdjSGtLUEVYNkhFZzVIYXo5bVBuV0k4cnBpYUZUTEpFMkZJ?=
 =?utf-8?B?cjVmY2pWb2pzS2pDRWxPcExLV1BXOHd5dFE0aXpMMFdZRU5FcHBaS1Nqelgz?=
 =?utf-8?B?bWcwbVA3NlRmNWh3NXlXM0duaGFpeDVQY3lmMy9pbjdqSWY1S05RZWxsTzl0?=
 =?utf-8?B?SmMzQjAwcXRhbVdwZFVUVUFmbVlYVEhKYUFUUGt3Q3g3SXRXWDZnMGR2MUgy?=
 =?utf-8?B?VndjOGNlSmlxblBObjEwOVJSMDY3R1d2RS9BNDVWcWVZSVlhYThzbFVhR2ps?=
 =?utf-8?B?TGlPUllJRklhczB2ajhwTTBscFJQdFhtb2JGeUFnQnlSaGw0RkNMdERCWXRP?=
 =?utf-8?B?eHcrNHdYVXIrd2tMZVQ3RHFEYUpTaElYMUdUYmFYUTZSdmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWpqbGlsQm1TMVZ3ZHFjMDFvd281Z3FMNWREZWNSa0NmUlVXTmIvZDR0T2ll?=
 =?utf-8?B?Ly80ZGM0aHRSL3NCNW8xbmhVZktDVldObmZCbFJlYSs1cGlWalJXOGUrSDN0?=
 =?utf-8?B?b25ZYUVpMGJDT2FyUEx0R2krMFQ1M3hNeWJ4R2dzRHZ3bFlRMUhaWmZvRktk?=
 =?utf-8?B?djNOZStmS1IzbGk1SXVlZG5iUzhWZU5WZUwvTWlXamhHN2dHQWd3UXJRQWtW?=
 =?utf-8?B?eE80Y0RnMDF6VWJVSk9ad3JkdVZUOTNzb1ZHMU5iUnEvRmFrWkp1bzY3R3VN?=
 =?utf-8?B?T20zSXV3M3hoVDRmN1h1OTA5ejRielVZVTVWb2N6SkFQbUNQK2lMREFwRTVn?=
 =?utf-8?B?U3VicEpKQVVkVzVwQVNRZkx4Wm1hSFc3cDYweElRRkdSVHdMd1dTNldSNEpp?=
 =?utf-8?B?N2lqc2kxekVDSHZWMGRmSFpsT2pZTmZ4QVNXQXpaaXdQTXRSY0tDV1luRHF3?=
 =?utf-8?B?MnZ6L3FxM1dHNUFqQmxJS2pQZmpHYzdUVzBvSmJLQ2FhTHhXUXh3NHBSWmpq?=
 =?utf-8?B?dUJTUVlWWERRSzBGK08yNmdKaWVDS2dEVTd6OWF4UlRHNWlhV3U5dU95elk4?=
 =?utf-8?B?c2ZNOEliZFJ4Zkgrc0paeXc5cUszVGpqQ1hKVVpYNXljS2t4R3dkVTNSSTEy?=
 =?utf-8?B?d1dHUVBHMS9vR3JnUFQyN3d3ZHIrcUY0WEQ3aFhDUEU4Qldkbzc5UUxVaEVj?=
 =?utf-8?B?eWtiYXhWVkg0OGFTY1dLZWNhT0pWbmM0b0ZvL1VqSHBrVnJIRXFtWXl4ZGJO?=
 =?utf-8?B?bGV4UW9pMUIzRE9nNFpLb09OTDNDOTFqY1BveFp3RnRWZ2FZYVdZaXV6bFFR?=
 =?utf-8?B?M2NiMTc5LzhrRytGMVdEaGIvTStGOFpBMG1BNWdQZHc5QkpiTEZJV1JjNWZO?=
 =?utf-8?B?cjQxTTlUakQ3d0lxMjB1cFBpK1NQUHZQZjhVZjUzd09iQUQzYUFhSkNZN0Rp?=
 =?utf-8?B?NXcvL054T2cvbVkvY1pXbC9IUHM3WjdGZEtwcHBEVGZHSHkwZEgwT0V2T3Uz?=
 =?utf-8?B?d2hiYmtEOEZjMzdWQjdVYjltaUNBbWoyblU1RHRaaDlzQnhDSlFnY1dXOFdM?=
 =?utf-8?B?RmF1Zk9yZUtkRkcvbWVsQzJVWHd0SEVNdjN1SFhlSXBFdENBTVExOGZlNktl?=
 =?utf-8?B?U2lZdWlRS2s2N2pSSTVWQ29VUE1odEtWNGJLd04vcWQ2bkNDMHcxeVlhdnJ1?=
 =?utf-8?B?N2VvbGFxU1ZiZ2RGR0FqU3EycCs2RWY1MlBVQXdmdjkvMC84TmZDUDJxZ1FY?=
 =?utf-8?B?S1M2Z2IxWmhOZWdrT2RkbmlKRmVQOUVYMHJnSytEZFNvV0tVMVUwS0ZrV1V3?=
 =?utf-8?B?QkVRTnhKRldmVGIwei9DZjRqUktZdUYxM2hXbmlrN0FmeTNYZFE5T2xYbmlo?=
 =?utf-8?B?MjBpR0lKYlN3bFB3VGNIKzlKbVhKSUJ2R3dTeHBsdWlwbzBRcTZaSDZSaDJz?=
 =?utf-8?B?bENXMlE1UEw5RzVoK2xYWDR2Y0lHcHh6QzdQUVhjbFMzcGtvUldOZ2t0d0lZ?=
 =?utf-8?B?Y0hyVzAzTmJrQThzaHV1a3FkWFhpYWxEL3RUeHFGV0FjM3dQVmR6WmhNT2py?=
 =?utf-8?B?Q1BSUjRpZEVTbk9KbEFFVWRuc2ZoNTJnY3V0VzNWdmduV2xZRjErb2g4dURw?=
 =?utf-8?B?WWI3REwwYU5tVVEreVlOT1JzSUpxb3p2dnEvQ3F0aE5JVWRZTWxkZnBDY2Mx?=
 =?utf-8?B?N1ByclhsV3pvK0RUNnF4RlQrTk10Tnk3NEU0QVpWMktYQnRjK1pEVm9IMjhr?=
 =?utf-8?B?R1Q0Qjl4alE5L2ZjVWFyZDhmZkxsTVh3MzFBZmFUUmF2ZzhsR1EzcElVaFBH?=
 =?utf-8?B?bFhxYzFyTXNBRk13aHBQSG13YTJTZFo1TTZ6WEtGazNUZDF3cGZVZXJrcy9y?=
 =?utf-8?B?QXFhVkZIU29xejVwYnpxTVY2R1IxOTZOazBGTHJzTW1MS2V5NXJYV054Skpp?=
 =?utf-8?B?Y3gyTndYUDhqdEpHSlJFN0xHa0NpckNTcS9rZ2c1aHpXeDFvVG1hMmplU0FL?=
 =?utf-8?B?ckxlaHduM1N1MWRsK2VPSjVHUmRqVHZzS2crZmNteElDdE5RZSsvM25DQVlm?=
 =?utf-8?B?SG5IUlJQdGRjQU9PakdEMXg2ZnlkUEtNQVpkc3VOenpGMkRzdkUwWjN2SjlJ?=
 =?utf-8?Q?pxaGwYUdKxsDhxA0ei/gySoIf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430861cb-9d35-4fa3-0508-08dcac4824f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 01:21:43.6622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBshhn3lRpKLr9vEnR4DMTpKL4Rw6E5GESp3YZtvBCPZBct2ka3zi4wCU+PuFK2xwA3RgkLcVDl/w1j5OnwRWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyNCwgMjAy
NCAxMDozNyBQTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzog
dS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNvbTsgUGVuZyBGYW4NCj4gPHBl
bmcuZmFuQG54cC5jb20+OyBmZXN0ZXZhbUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SHYxIDEvNV0gY3B1OiBhZGQgcmVsZWFzZV9jb3JlIGNhbGxiYWNrDQo+IA0KPiBIaSBaaGlxaWFu
ZywNCj4gDQo+IE9uIFR1ZSwgMjMgSnVsIDIwMjQgYXQgMDg6NDMsIFpoaXFpYW5nIEhvdSA8Wmhp
cWlhbmcuSG91QG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxa
aGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBhIG5ldyBjYWxsYmFjayByZWxlYXNl
X2NvcmUgdG8gdGhlIGNwdV9vcHMsIHdoaWNoIGlzIHVzZWQgdG8NCj4gPiByZWxlYXNlIGEgQ1BV
IGNvcmUgdG8gcnVuIGJhcmVtZXRhbCBvciBSVE9TIGFwcGxpY2F0aW9uIG9uIGEgU29DIHdpdGgN
Cj4gPiBtdWx0aXBsZSBDUFUgY29yZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2NwdS9j
cHUtdWNsYXNzLmMgfCAxMCArKysrKysrKysrDQo+ID4gIGluY2x1ZGUvY3B1LmggICAgICAgICAg
ICB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdS9jcHUtdWNsYXNzLmMgYi9k
cml2ZXJzL2NwdS9jcHUtdWNsYXNzLmMgaW5kZXgNCj4gPiAxNmY4ZjJlNTIxLi4yYzhlNDZjMDVl
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1L2NwdS11Y2xhc3MuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvY3B1L2NwdS11Y2xhc3MuYw0KPiA+IEBAIC0xMDQsNiArMTA0LDE2IEBAIGludCBjcHVf
Z2V0X3ZlbmRvcihjb25zdCBzdHJ1Y3QgdWRldmljZSAqZGV2LA0KPiBjaGFyICpidWYsIGludCBz
aXplKQ0KPiA+ICAgICAgICAgcmV0dXJuIG9wcy0+Z2V0X3ZlbmRvcihkZXYsIGJ1Ziwgc2l6ZSk7
ICB9DQo+ID4NCj4gPiAraW50IGNwdV9yZWxlYXNlX2NvcmUoY29uc3Qgc3RydWN0IHVkZXZpY2Ug
KmRldiwgcGh5c19hZGRyX3QgYWRkcikgew0KPiA+ICsgICAgICAgc3RydWN0IGNwdV9vcHMgKm9w
cyA9IGNwdV9nZXRfb3BzKGRldik7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCFvcHMtPnJlbGVh
c2VfY29yZSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9TWVM7DQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIG9wcy0+cmVsZWFzZV9jb3JlKGRldiwgYWRkcik7IH0NCj4gPiArDQo+
ID4gIFVfQk9PVF9EUklWRVIoY3B1X2J1cykgPSB7DQo+ID4gICAgICAgICAubmFtZSAgID0gImNw
dV9idXMiLA0KPiA+ICAgICAgICAgLmlkICAgICA9IFVDTEFTU19TSU1QTEVfQlVTLA0KPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2NwdS5oIGIvaW5jbHVkZS9jcHUuaCBpbmRleA0KPiA+IDIwNzdm
ZjMwNjMuLjAwMTg5MTBkNjEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9jcHUuaA0KPiA+ICsr
KyBiL2luY2x1ZGUvY3B1LmgNCj4gPiBAQCAtMTAyLDYgKzEwMiwxNSBAQCBzdHJ1Y3QgY3B1X29w
cyB7DQo+ID4gICAgICAgICAgKiAgICAgICAgIGlmIG5vdC4NCj4gPiAgICAgICAgICAqLw0KPiA+
ICAgICAgICAgaW50ICgqaXNfY3VycmVudCkoc3RydWN0IHVkZXZpY2UgKmRldik7DQo+ID4gKw0K
PiA+ICsgICAgICAgLyoqDQo+ID4gKyAgICAgICAgKiByZWxlYXNlX2NvcmUoKSAtIFJlbGFzZSBh
IENQVSBjb3JlIHRvIHRoZSBnaXZlbiBhZGRyZXNzIHRvIHJ1bg0KPiBhcHBsaWNhdGlvbg0KPiA+
ICsgICAgICAgICoNCj4gPiArICAgICAgICAqIEBkZXY6ICAgICAgICBEZXZpY2UgdG8gY2hlY2sg
KFVDTEFTU19DUFUpDQo+ID4gKyAgICAgICAgKiBAYWRkcjogICAgICAgQWRkcmVzcyB0byByZWxl
c2UgdGhlIENQVSBjb3JlDQo+ID4gKyAgICAgICAgKiBAcmV0dXJuIDAgaWYgT0ssIC12ZSBvbiBl
cnJvcg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpbnQgKCpyZWxlYXNlX2NvcmUpKGNv
bnN0IHN0cnVjdCB1ZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90DQo+ID4gKyBhZGRyKTsNCj4gPiAg
fTsNCj4gPg0KPiA+ICAjZGVmaW5lIGNwdV9nZXRfb3BzKGRldikgICAgICAgICgoc3RydWN0IGNw
dV9vcHMgKikoZGV2KS0+ZHJpdmVyLT5vcHMpDQo+ID4gQEAgLTE2NCw0ICsxNzMsMTAgQEAgaW50
IGNwdV9pc19jdXJyZW50KHN0cnVjdCB1ZGV2aWNlICpjcHUpOw0KPiA+ICAgKi8NCj4gPiAgc3Ry
dWN0IHVkZXZpY2UgKmNwdV9nZXRfY3VycmVudF9kZXYodm9pZCk7DQo+ID4NCj4gPiArLyoqDQo+
ID4gKyAqIGNwdV9yZWxlYXNlX2NvcmUoKSAtIFJlbGFzZSBhIENQVSBjb3JlIHRvIHRoZSBnaXZl
biBhZGRyZXNzIHRvIHJ1bg0KPiA+ICthcHBsaWNhdGlvbg0KPiA+ICsgKg0KPiA+ICsgKiBAcmV0
dXJuIDAgaWYgT0ssIC12ZSBvbiBlcnJvcg0KPiA+ICsgKi8NCj4gPiAraW50IGNwdV9yZWxlYXNl
X2NvcmUoY29uc3Qgc3RydWN0IHVkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QgYWRkcik7DQo+ID4g
ICNlbmRpZg0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCj4gDQo+IFBsZWFzZSBhbHNvIGFkZCBh
IHRlc3QgZm9yIHRoaXMgY2FsbGJhY2sgdG8gdGVzdC9kbS9jcHUuYw0KDQp3aWxsIGFkZC4gVGhh
bmtzIQ0KDQotIFpoaXFpYW5nDQo=
