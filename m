Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1B8C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 13:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD81E82E17;
	Thu, 26 Jun 2025 15:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nDIpWMAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4561780E9A; Thu, 26 Jun 2025 15:23:41 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC4480E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lv09pl11uwftBB6Lhl5jDzsSfjIg5TTUJUQ8EC0QHDtnxo1xW9xPKqO7k+CmKsAlGdGOAencKtjVK4rjyxV5wNqJFGgR/kn3uHKrnZKNdEYJ3B8v4E5EmFnRYME6vULMJmqZh4ZBQtCS0obTJoFCVHffIBLf4k9t7k667AsVGT6zqVkT47mGfeBTh7eigeCP8PiYtaSdYPapg+G/BKtaLdGehXfPCNWGxs1senk3goFMLTKIKzBJ45Jh86hsY1XQi5SMl/B0EBYx2VR0u5W9vlgOOlGv7vM/DnqG1YuXow85PNF5A1tBHFkLbWfLAGmrTpdQXCOceFLl97W5QXFGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkiBif0MLv6A7tO45e0sCcsTG7J4l+gZ8f3uYC6y8G8=;
 b=eHhCL2Dkcpa4CrvYajLPS56wV/SkD4joAoOveDMklx/glU4Y+hmytNBhn1KEYOKfzzQfM+gbj+6uxbN0DVehN6Kek3ix8I2XZ9SoaOFE2BbkJrZ+aTNK64wykKGC8qfYWlhX+vynExe/iAfkXE8GBUP3qB1If/+VrO6bVcQFdd+gnhlR6AedNNYXwgWdF9Wjd19e4BkVXTVmx8SstrfS/4jL/Y6MYmkHh/9ObJOqnB+hPC0koOMODfw+EIAKwi5iS7pl3+8bDAnKYr9kF6eDfoYog77CAi22btUTtuUgNlEi8xgh6ZJoTjqbUK6XXmreu1S6yVYWOcaHmnc96JKesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkiBif0MLv6A7tO45e0sCcsTG7J4l+gZ8f3uYC6y8G8=;
 b=nDIpWMAD7d58F/nJJVY72ZJakQRerqK8R7r59G4wB+kckn8liqB3PwWaPcQZotrHmISAE+yJE3RjRI/kOFhuizlhS8xSIRECZHQy9q03A0pNbrw4kHXMgLgRVVWu0D9kFMBdg7AxYGG8PX/HNsoRC8U75DP6eg/YJ/CD5TIUUYR4NapT6PiEkEwXkYWkZ0aC6olsceWPuVRrFN+Y4r9lTIappzOVkcIiQKw9exY4KMLR//Dt6IYgK1yzCOEfraP76ovQQPNbUVDr9EtpbLmi/HH90X/Wnh5VpOzYwkxyWuVBFrgynr0snxX1ACmaeQZLzEqaP4kKY6ejoS6CnItOog==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by DU0P195MB1676.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 13:23:29 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%6]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 13:23:28 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Thread-Topic: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Thread-Index: AQHb1UqJu7bU4cfQfUG48IKL6GPmkrP01BUAgADiT4CAAHMUAIAfZvOA
Date: Thu, 26 Jun 2025 13:23:28 +0000
Message-ID: <baf80618bf8e56affb0dcccf3efb146b540acf0a.camel@phytec.de>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
 <CAFLszTjWqhg1baNSF5rLqjYdoDNyjmy=5hXXq5AzwNF_QSfAQg@mail.gmail.com>
 <421b73636b30472302e5751e9c001ffd4e6b4eb4.camel@phytec.de>
 <20250606135056.GK1382132@bill-the-cat>
In-Reply-To: <20250606135056.GK1382132@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|DU0P195MB1676:EE_
x-ms-office365-filtering-correlation-id: 7f432990-32cc-44c5-c277-08ddb4b4a39a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SUtyRFlhaDMxaXhVZjdIQkdhcWl2ZHc0MmxKKytrcTR6cVVIK2xjSGNUeGg5?=
 =?utf-8?B?dnVmejhsU2lyenZTb09YUzdvM1FNUEkvMFhhZFFicE9zWE1PVEsyUS80Zkhw?=
 =?utf-8?B?UVpjSWJrUVFNUkJwcGUxOUtzR1cvVmN6TlU4dGpKZ2lxVDdhZFJvSVh2V2Vl?=
 =?utf-8?B?NjJHZFQ1dkYxbjhiMDJnZ0xKdG1KdHZLZm9hMkZHVFI1VElJZmc1OUR4Rmcz?=
 =?utf-8?B?S0RIU1pqemp1ZEdnUzV1MlJYMVdqS1gza0VGcGFycERpNjVrdjhWODFkNFlN?=
 =?utf-8?B?VWNlbnFqNTcrL2F2Q2cwLzZzaDJ3Smkyb2JlSHFPNmxCQUVyd2xhT2xnOExr?=
 =?utf-8?B?eTNSdHhsczhuZ280TGIvVC9EdXNLV2VFcVpyUWNWVTdENGh6eWhhL1lrYTFG?=
 =?utf-8?B?ZGljNlBVbkNlNkhSTm9UZDAzTndBS1E0T2haQURhT05hN2phQ1luU0JMWVhJ?=
 =?utf-8?B?Zi8rYmdpWmFZQVZnSkEyWjlRdTBzWndyeG9kRStzY0ZrYnR0NGZSdkc2RXli?=
 =?utf-8?B?Zm92VjgxaDA1enY4RlNneXNNWmJORlBSMGZPRWs1dE50cGhEcXAwaWFQcG1X?=
 =?utf-8?B?UXpDS0VQMUttVlFNbk4wQkV2Tng2a0NpTjhRNEl2eGloc0VwM2h0VlVlcDY0?=
 =?utf-8?B?ZnVrNDZEbktiRVNkcjVyRlFwTUxmTDFwRjlkSkJpVlRrSUxlbDJHRm9QQmFz?=
 =?utf-8?B?T0c2eGlCZG1xeEFUejdPeXF4NW82SVErYS9QcFdXb25Pd3JUL3ZnNGowV3A3?=
 =?utf-8?B?MldLdVZuVTF0MlE3bmg5aGhMVDdUbWNYcUF2dEhoSUNISzY0QnhxdEgxZ0d4?=
 =?utf-8?B?VHRlZld0RVlvU1RUNGlET3UrWjNZbVFrR1U3azZvMzlVNWNub25hRTZXUGhN?=
 =?utf-8?B?V0poK0UvTUJuQzlkZFNXanY2NXM5bzBvTFFkNmcvTDFUWnJEL3l4YWJMWUNL?=
 =?utf-8?B?cC8wQUx6aHNUT1p6ZHc5aEpEOVErTUtwQ2lWc3oyQlhadVNoU2VIUmZ0LzNL?=
 =?utf-8?B?bWptZ0JReGRLUW1VbFhZbmZISUwrZ2lUMUhoaE9ZblNSZVp3bDgzeEM3UE1R?=
 =?utf-8?B?VDJPcCtnRlA3ZWJiUDBBUmVray9vS3lBTklzTDVnYXI3OG9FWWVsbXprNG92?=
 =?utf-8?B?Z2IwQ3NLMVlrMjZma1pSekhaZkxGZFBOWDRlZFl3VlBXUE9mbUZkN29JUWdq?=
 =?utf-8?B?ZEVpai9kL1M3cEsybWtzUmxpUDZYUTNSOEFKcjdSMjZsRWNmUG5aeUpqRDhD?=
 =?utf-8?B?aTZGbUp0YVpLandSdjdzNnAxMUJFM0MxZm5IN1dza2RQVDlHU0tZV0JVdnUx?=
 =?utf-8?B?TTliRGtlSUhRZmFHK3RwaGpYNno5RmcvaTdsZ0UyM1dleE0yZlpiVGVSUjJh?=
 =?utf-8?B?N1lKZmF3K0FMS0wvRlNqSzFJWS90b3FHQm9CNTI2MGJoVHpQenAyaWRjaFNT?=
 =?utf-8?B?TXJVVXpBbWtTeEQvaEZheTF3aDNlY01TMVdjdnVYSkZuM1hkSW9kcWNjeXNu?=
 =?utf-8?B?dWZ4QlhXWHpSNmRmRFBzcUNnb3VyVVNqZEtZaHZkM1JURnNuejR4dzZSWklu?=
 =?utf-8?B?dG4vRm5wNzBoeS9NRmxJV0xTR1RBa0ZKWkhFaGptYlhJZ0k1REx3dnFXSGNQ?=
 =?utf-8?B?eWZ2b29EcFVMT2lGOVlYWEYwV0dxVDloWXBleE8zTXkrSWU0UW5YS1EvVlVz?=
 =?utf-8?B?Tk01cGR0QU1sVDVlQVJlNnBVM00wbFZqYUQrQ25pNEZZMDlXa0cyaVNwbkRh?=
 =?utf-8?B?ajFjODJRbXFqUGFzNWVHS3Z2NjRZeE5aZ0ZLR3F1UkJRV0VWcEZpejZIMlJa?=
 =?utf-8?B?VUQvSmxkVkdRM2EvaUpYRCtXS3h2U1g1Q3NHdE0zS2JiMzM0SEVTbGRESlNw?=
 =?utf-8?B?Z3BpZnpmbEppQkNYVzU2djJodm5ucHNzYzhiczIveEFpQXczRm5mdW9qNzBV?=
 =?utf-8?Q?nKbAl5RMQMQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1hIM3c1ZFdTUzFyOHo0c3kvYTVJOEJ1aHJHS1I0REJVMW9XSWJIbWZTYkFX?=
 =?utf-8?B?K2E1ZHB3Wjh4czh5dCtpOXZMaE1DWk5yY0E3MGNQSkthcHNSYk9SNUVoRzRN?=
 =?utf-8?B?NStDK1c4RXQ4SGkrYlRxbnFKTnZ0bW5sb2dXd0N3OE41UituSWpzY3hKU2wv?=
 =?utf-8?B?MnAvSm0wa1dqVFREUlFTS0JkYUNpUXRNM2lVcDcwRTJ3VzZKTXh2cVpic1Ir?=
 =?utf-8?B?WVl6SWFaYWdLYjBYN1BOVjRwKytET0lJZUJreFhIbU5yd1FTdkJIdm5tZFR5?=
 =?utf-8?B?citoZzg1enJRVXh6VlVtVmlid3NPNmRTY0o4d1FEOVplTVF5YkZ1K1owR2tG?=
 =?utf-8?B?WDVlN09kbk96RW9LWHdtbUd4NkpaUzk5NHhvS09zV3NVUGJOek4zRnZ5cmNG?=
 =?utf-8?B?YlNHM3dya3JnSm9YTDhjazVqWXhpbVFaRHlGYmVCZ21yWTZiTmNsbHgyalVn?=
 =?utf-8?B?VEdSWVRsbzFzeVVQb0RMZHZBTi9sZWZmZlZ3dlNWcDFIYjkrOHE1UkdVWWdm?=
 =?utf-8?B?aWZ3SVhxV1JmSW5aL2lFY1hjZXpwM3RUOEN5b1NZUlR3VXpRdmpERXhkUVlt?=
 =?utf-8?B?bDVGWUJudUtMNWk3MVBacWt2NnR6bGJ1aysvUlAyYmc1UnpVcWc4QTlka1oz?=
 =?utf-8?B?TE5BOURFMDB2M05NOTB3TkpSd0RQcWtRd0FCMktqYVAwcjdvS3haVmZqWVZS?=
 =?utf-8?B?cUlBUVF5cjRsM2JhNnhZeUMyYmNnYUg3ZEhQWjV1cVNJQW1nU3FIZkZjUFpH?=
 =?utf-8?B?STZTOTRKMDFYcE9NYWlOZEVxanc3VllRVGdxTVB0RlVkN3pET0FhaVNHMmww?=
 =?utf-8?B?TVR1THFkMGZ2TWhFU0dVVzJ3RHV3OGpzVXI5ODFZdzZMR1VGb0JhWW9UNWRn?=
 =?utf-8?B?anJoejFSQTdmVTA0Wlo1MmV6WGYxeHdkTlpDWHd4NEdMR3BqN1JtV2QxODJY?=
 =?utf-8?B?QTRoYXNlVHMySVYveG5EbVJwYmx5WW5SYmhCUk5icTQ1Tmc3NHhmajRkWkhV?=
 =?utf-8?B?ZG5ncUl1UkE0U1pOL25wK2tScG5qa0o3aVNFMUNkTFdHQ0pXVnlzSGQ5MVgv?=
 =?utf-8?B?KzZBK0htNndDZjAzZXE0d3oyU0ZNY0l0cUV2V2dNMjB3YlRvQ2htc3U4YTZq?=
 =?utf-8?B?dDlmOXlsSUM1eHpBc0p2YkpBc1BWaEM4ZEJ5SjUxRE9MMVBqSjVmOUpLc0h2?=
 =?utf-8?B?SjJJVVIzbHFZbjE1VnBHSjlGOVFLRzhXWE1majhTOXNHbDFRWWs2eXhOS2dh?=
 =?utf-8?B?aDd6S1RhRnZVQXRtMVdNTm5MaXhmNWNLSURLR0RUck1RUWpLUURSZHY5bS9z?=
 =?utf-8?B?VTRmb3VtREVjMGc5RHRjNGZMRklPM1pPWktYWXg3YzNZNGZTUWl5Wi9vVXpH?=
 =?utf-8?B?ZDJUTEo4di9NZjV3RlNVaTFYd3F4N282dFlzSi80Y3ZaaW04RUFzRFhWek8z?=
 =?utf-8?B?cjBTb2ZYb0cxemJ6UlpMRHBHdUVTejRqQ2lHOTZscDd3YU4xditCNHBRRkx1?=
 =?utf-8?B?ZElmV043Nk04bUFaRUhUUUVWc2NMTEhvbHUxNHBpZjMzemw5bzRVdHJWQjRO?=
 =?utf-8?B?Z1d5OCtnbmdlMkl5QTBLRTU1ZUd6Rm1JVGEwNWk4bXhLVWNoSjY4ckJiSy92?=
 =?utf-8?B?TUhwS2thT2YrUzFaem9pYVVUbWRnUTM0bnBzRENOWnFtUnZnL1JQeDNrWGZw?=
 =?utf-8?B?aXdwWFU2MlRYTEtib3oyQ1V6aE0xZUVKcmtSbnRSUnVWZ0xOOWdaV0hNNGtK?=
 =?utf-8?B?RUwxQkNvUFRPZkVPbTVub094WjA3ZjFNVE1YdTZIT08rOHJTU3puNGlXRVhx?=
 =?utf-8?B?T0o5dmxCR2dRVGZocWlieWlYWGFlSUx1dlpqRUowS3ZFam9tbmFERC84N3M4?=
 =?utf-8?B?WXFMdlFYL3plcjd1K2xVeVFDV3FOZEs5MGJwMVVSOXl5Nm9sTGw0MW9BZ3pM?=
 =?utf-8?B?Z3Zrdzh5V0s2dXBQQStxM1ppWHpIc0JJeWdsT01EMGRXelpMcXRCcHpuNlYv?=
 =?utf-8?B?bWhWSFpsZFFNK3dPek80aWJEaFhxODFTN1ZvWXE2V2NLQVY2Tmd1SXBPUmtG?=
 =?utf-8?B?eHNOeENlQXpmNlZKNndSUFlTQmVVR2pzUWdGWldUWjJXK25ZZTM4dlp6Y25v?=
 =?utf-8?B?bytrWXpHZHg4VXFrMzIxaktPYVk5UndpVVU1SU90eU9ZZElEd3MrL1FBSHZE?=
 =?utf-8?Q?DNxTEE3ey640P0bqxFxUY+OZN6LxDYaaA5ODXH4kkOOy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEB15364F957AF47A2BEEFAC32102C2E@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f432990-32cc-44c5-c277-08ddb4b4a39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 13:23:28.8295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLeUQG9mTZO3m15HxRfUmxhN6ORGKNyS5ZENn1n/LlNdEEcjdpWMDn8LFOpqRwUiqlin6QIodNk6NdGG6xoddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1676
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

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBNTEyDQoNCkhpIFRv
bSwNCg0KT24gRnJpLCAyMDI1LTA2LTA2IGF0IDA3OjUwIC0wNjAwLCBUb20gUmluaSB3cm90ZToN
Cj4gT24gRnJpLCBKdW4gMDYsIDIwMjUgYXQgMDY6NTk6MDVBTSArMDAwMCwgTWFydGluIFNjaHdh
biB3cm90ZToNCj4gPiAtLS0tLUJFR0lOIFBHUCBTSUdORUQgTUVTU0FHRS0tLS0tDQo+ID4gSGFz
aDogU0hBNTEyDQo+ID4gDQo+ID4gSGkgU2ltb24sDQo+ID4gDQo+ID4gT24gVGh1LCAyMDI1LTA2
LTA1IGF0IDExOjI5IC0wNjAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4gPiA+IEhpIE1hcnRpbiwN
Cj4gPiA+IA0KPiA+ID4gT24gV2VkLCA0IEp1biAyMDI1IGF0IDA2OjE2LCBNYXJ0aW4gU2Nod2Fu
IDxtLnNjaHdhbkBwaHl0ZWMuZGU+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IFRo
aXMgc2VyaWVzIGltcGxlbWVudHMgYSBuZXcgYm9vdG1ldGggZm9yIFJBVUMgQS9CIHN5c3RlbXMu
DQo+ID4gPiA+IFJBVUMNCj4gPiA+ID4gKFJvYnVzdA0KPiA+ID4gPiBBdXRvIFVwZGF0ZSBDb250
cm9sbGVyKSBpcyBhIGxpZ2h0d2VpZ2h0IHVwZGF0ZSBjbGllbnQsDQo+ID4gPiA+IHByb3ZpZGlu
Zw0KPiA+ID4gPiAiU2FmZQ0KPiA+ID4gPiBhbmQgU2VjdXJlIE9UQSBVcGRhdGVzIGZvciBFbWJl
ZGRlZCBMaW51eCIuIFNlZSB0aGUgZm9sbG93aW5nDQo+ID4gPiA+IGxpbmtzDQo+ID4gPiA+IGZv
cg0KPiA+ID4gPiBtb3JlIGluZm9ybWF0aW9uIGFib3V0IFJBVUM6DQo+ID4gPiA+IA0KPiA+ID4g
PiDCoCBodHRwczovL3JhdWMuaW8vDQo+ID4gPiA+IMKgIGh0dHBzOi8vcmF1Yy5yZWFkdGhlZG9j
cy5pby9lbi9sYXRlc3QvDQo+ID4gPiA+IA0KPiA+ID4gPiBQSFlURUMgdXNlcyBSQVVDIGluIGl0
cyBZb2N0byBiYXNlZCBkaXN0cmlidXRpb24gIkFtcGxpcGh5IiBhcw0KPiA+ID4gPiB0aGUNCj4g
PiA+ID4gZGVmYXVsdCB3YXkgb2YgdXBkYXRpbmcgZW1iZWRkZWQgZGV2aWNlcyBiYXNlZCBvbiBQ
SFlURUMNCj4gPiA+ID4gaGFyZHdhcmUuDQo+ID4gPiA+IFNvDQo+ID4gPiA+IGZhciwgdGhlIGxv
Z2ljIHNlbGVjdGluZyB0aGUgY29ycmVjdCBwYXJ0aXRpb25zIGFuZCBmaWxlcyB0bw0KPiA+ID4g
PiBib290DQo+ID4gPiA+IHdhcw0KPiA+ID4gPiBiZWluZyBpbXBsZW1lbnRlZCBpbiB0aGUgVS1C
b290IGVudmlyb25tZW50LiBXaGlsZSB0aGlzIGlzIGENCj4gPiA+ID4gc3RyYWlnaHRmb3J3YXJk
IHdheSB0byBkbyBpdCwgYWRkaW5nIGFuZCBzdXBwb3J0aW5nIG5ldw0KPiA+ID4gPiBwbGF0Zm9y
bXMNCj4gPiA+ID4gYmVjYW1lDQo+ID4gPiA+IHNvbWV3aGF0IHRlZGlvdXMgYW5kIGlzIHBsYXRm
b3JtLXNwZWNpZmljLiBUaGUgaW50cm9kdWN0aW9uIG9mDQo+ID4gPiA+IFUtDQo+ID4gPiA+IEJv
b3Qncw0KPiA+ID4gPiAiU3RhbmRhcmQgQm9vdCIgcHJvdmlkZWQgYSBjb252aW5jaW5nIGFsdGVy
bmF0aXZlLCBwcm9taXNpbmcgYQ0KPiA+ID4gPiBzaW1wbGVyDQo+ID4gPiA+IGFuZCBtb3JlIHBv
cnRhYmxlIHdheSBvZiBib290aW5nLCBldmVuIGZvciBSQVVDIHN5c3RlbXMuIFRoaXMNCj4gPiA+
ID4gbGVkDQo+ID4gPiA+IG1lIHRvDQo+ID4gPiA+IGltcGxlbWVudCBhIG5ldyBib290bWV0aCBz
dXBwb3J0aW5nIFJBVUMgQS9CIHN5c3RlbXMuIE5vdGUsDQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4g
dGhpcw0KPiA+ID4gPiBuZXcgYm9vdG1ldGggaXMgbm90IHByb3ByaWV0YXJ5IHRvIFBIWVRFQyBw
cm9kdWN0cyBhbmQgaXMNCj4gPiA+ID4gZGVzaWduZWQNCj4gPiA+ID4gdG8NCj4gPiA+ID4gd29y
ayBvbiBvdGhlciBoYXJkd2FyZSB3aXRoIGEgUkFVQyBBL0Igc3lzdGVtLCB0b28uDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGUgYm9vdG1ldGggY3VycmVudGx5IG9ubHkgc3VwcG9ydHMgc3ltbWV0cmlj
IEEvQiBwYXJ0aXRpb25pbmcNCj4gPiA+ID4gbGF5b3V0cy4NCj4gPiA+ID4gRS5nLiBBL3Jlc2N1
ZSBpcyBub3QgKHlldCkgc3VwcG9ydGVkLiBUaGUgcGFydGl0aW9uIGluZGV4ZXMgYW5kDQo+ID4g
PiA+IGRlZmF1bHQNCj4gPiA+ID4gc2xvdCB0cmllcyBjYW4gYmUgc3BlY2lmaWVkIHZpYSBjb25m
aWd1cmF0aW9uIG9wdGlvbnMuDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3Igbm93LCB0aGUgYm9vdG1l
dGhfcmF1YyB1c2VzIGEgc2ltaWxhciBhcHByb2FjaCBmb3IgbG9hZGluZw0KPiA+ID4gPiB0aGUN
Cj4gPiA+ID4gS2VybmVsIGFuZCBkZXZpY2UgdHJlZSBhcyB0aGUgYm9vdG1ldGhfc2NyaXB0LCBp
biB0aGF0IGl0DQo+ID4gPiA+IHJlcXVpcmVzDQo+ID4gPiA+IGEgRklUDQo+ID4gPiA+IGNvbnRh
aW5pbmcgYSBVLUJvb3Qgc2NyaXB0IGxvYWRpbmcgdGhlIGRlc2lyZWQgZGlzdHJvLiBJdCBjb3Vs
ZA0KPiA+ID4gPiBiZQ0KPiA+ID4gPiBwb3NzaWJsZSB0byBzdXBwb3J0IGJvb3Rpbmcgd2l0aG91
dCBhIHNjcmlwdCBhbmQgbG9hZCB0aGUNCj4gPiA+ID4gS2VybmVsDQo+ID4gPiA+IGFuZCBEVA0K
PiA+ID4gPiBkaXJlY3RseSB3aXRoIHRoaXMgYm9vdG1ldGgsIGJ1dCBJIGZvdW5kIHRoZSBzY3Jp
cHQgbWV0aG9kIHRvDQo+ID4gPiA+IGJlDQo+ID4gPiA+IHZlcnkNCj4gPiA+ID4gZmxleGlibGUg
Zm9yIG5vdywgaW4gbGV0dGluZyB0aGUgZGlzdHJvIGRlY2lkZSB3aGF0IHRvIGxvYWQuDQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGUgYm9vdG1ldGhfcmF1YyB3YXMgdGVzdGVkIG9uIGEgcGh5Qk9BUkQt
UG9sbHV4IGkuTVg4TSBQbHVzDQo+ID4gPiA+IFsxXQ0KPiA+ID4gPiB3aXRoDQo+ID4gPiA+IEJT
UC1Zb2N0by1BbXBsaXBoeS1pLk1YOE1QLVBEMjQuMS4yIFsyXS4NCj4gPiA+ID4gDQo+ID4gPiA+
IFN1cHBvcnRlZCBib290IGRldmljZXMgYXJlIGN1cnJlbnRseSBvbmx5IE1NQyBkZXZpY2VzLCBi
dXQgaXQNCj4gPiA+ID4gc2hvdWxkIGJlDQo+ID4gPiA+IHBvc3NpYmxlIHRvIGFkZCBTUEkgZmxh
c2hlcyBpbiB0aGUgZnV0dXJlLg0KPiA+ID4gPiANCj4gPiA+ID4gVG8gdGVzdCB0aGlzIHBhdGNo
IHN0YWNrIHdpdGggUEhZVEVDJ3MgcGh5Qk9BUkQtUG9sbHV4IGkuTVg4TQ0KPiA+ID4gPiBQbHVz
DQo+ID4gPiA+IGJvYXJkLCB5b3UgbmVlZCB0byBhZGp1c3QgdGhlIGJvb3QgZmlsZXMgdG8gaW5j
bHVkZSB0aGUNCj4gPiA+ID4gYm9vdC5zY3IudWltZw0KPiA+ID4gPiBjb250YWluaW5nIHRoZSBk
aXN0cm8ncyBib290IHNjcmlwdCBhbmQgc2V0ICJvcHRhcmdzIiB0bw0KPiA+ID4gPiAiJHtyYXVj
YXJnc30iDQo+ID4gPiA+IGluIGl0LiBBbHNvIGRpc2FibGUgYW55IGxlZ2FjeWJvb3QgaW4gdGhl
IFUtQm9vdCBlbnZpcm9ubWVudA0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gc2ltcGx5DQo+ID4gPiA+
IGJvb3Qgd2l0aCBTdGFuZGFyZCBCb290Og0KPiA+ID4gPiANCj4gPiA+ID4gwqAgYm9vdG1ldGgg
b3JkZXIgcmF1Yw0KPiA+ID4gPiDCoCBib290ZmxvdyBzY2FuIC1sYg0KPiA+ID4gPiANCj4gPiA+
ID4gUmVnYXJkcywNCj4gPiA+ID4gTWFydGluDQo+ID4gPiA+IA0KPiA+ID4gPiBbMV06DQo+ID4g
PiA+IGh0dHBzOi8vd3d3LnBoeXRlYy5ldS9lbi9wcm9kdWt0ZS9zaW5nbGUtYm9hcmQtY29tcHV0
ZXIvcGh5Ym9hcmQtcG9sbHV4Lw0KPiA+ID4gPiBbMl06DQo+ID4gPiA+IGh0dHBzOi8vZG93bmxv
YWQucGh5dGVjLmRlL1NvZnR3YXJlL0xpbnV4L0JTUC1Zb2N0by1pLk1YOE1QL0JTUC1Zb2N0by1B
bXBsaXBoeS1pLk1YOE1QLVBEMjQuMS4yLw0KPiA+ID4gPiANCj4gPiA+ID4gLS0tDQo+ID4gPiA+
IENoYW5nZXMgaW4gdjM6DQo+ID4gPiA+IC0gSW52ZXJ0IGlmLXN0YXRlbWVudCBjaGVjayBmb3Ig
c2V0dGluZyBkZWZhdWx0IHZhbHVlIG9mDQo+ID4gPiA+IEJPT1RfKl9MRUZUIGVudg0KPiA+ID4g
PiDCoCB2YXJpYWJsZXMuIFRoaXMgd291bGQgZmFsc2VseSB0cmlnZ2VyIGFuIGVycm9yIG1lc3Nh
Z2UNCj4gPiA+ID4gYmVmb3JlLg0KPiA+ID4gPiAtIExpbmsgdG8gdjI6DQo+ID4gPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA2MDItd2lwLWJvb3RtZXRoLXJhdWMtdjItMC05ZDIz
ODQxMzE0ODZAcGh5dGVjLmRlDQo+ID4gPiA+IA0KPiA+ID4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+
ID4gPiAtIFJlbW92ZSBMT0dfREVCVUcgZnJvbSBib290L2Jvb3RtZXRoX3JhdWMuYw0KPiA+ID4g
PiAtIFJlb3JkZXIgYXNtL2NhY2hlLmggaW5jbHVkZSB0byBiZSBsYXN0DQo+ID4gPiA+IC0gRG8g
bm90IGNoZWNrIGZvciBSQVVDLXNwZWNpZmljIGZpbGVzIGluIHRoZSByb290ZnMgYW55bW9yZS4N
Cj4gPiA+ID4gVGhpcw0KPiA+ID4gPiBkb2VzDQo+ID4gPiA+IMKgIG5vdCB3b3JrIG9uIGVuY3J5
cHRlZCByb290IGZpbGVzeXN0ZW1zIGFuZCBpcyBub3QgYSBzdGFibGUNCj4gPiA+ID4gaW5kaWNh
dG9yDQo+ID4gPiA+IMKgIGZvciBhIGZ1bmN0aW9uaW5nIFJBVUMgc3lzdGVtLg0KPiA+ID4gPiAt
IEFkZCBhIGRlc2NyaXB0aW9uIG9mIHRoZSB0ZXJtICJzbG90IiBpbiB0aGUgY29ycmVzcG9uZGlu
Zw0KPiA+ID4gPiBwcml2YXRlDQo+ID4gPiA+IMKgIHN0cnVjdC4NCj4gPiA+ID4gLSBSZW1vdmUg
Ym9vdCB0cmllcyBsZWZ0IGZyb20gc3RydWN0IGRpc3Ryb19yYXVjX3Nsb3QuIFRoZSBib290DQo+
ID4gPiA+IHRyaWVzDQo+ID4gPiA+IMKgIGFyZSByZWFkIGRpcmVjdGx5IGZyb20gdGhlIGVudmly
b25tZW50LCBhcyB0aGF0J3MgdGhlIG9ubHkNCj4gPiA+ID4gY29ycmVjdA0KPiA+ID4gPiDCoCBz
b3VyY2UgUkFVQyBpcyByZWx5aW5nIG9uLg0KPiA+ID4gPiAtIFJlbW92ZSB0aGUgY3VycmVudCBi
b290X29yZGVyIGZyb20gc3RydWN0IGRpc3Ryb19yYXVjX3ByaXYsDQo+ID4gPiA+IGZvcg0KPiA+
ID4gPiB0aGUNCj4gPiA+ID4gwqAgc2FtZSByZWFzb24gYXMgYWJvdmUgKGVudiBpcyBjb3JyZWN0
IHNvdXJjZSkuDQo+ID4gPiA+IC0gQWRkIGZ1bmN0aW9uIGZvciByZXRyaWV2aW5nIGEgc2xvdCBz
dHJ1Y3QsIHRvIGVhc2UgZmluZGluZw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gcmlnaHQNCj4gPiA+
ID4gwqAgb25lIHdoZW4gZS5nLiBpdGVyYXRpbmcgb3IgZ2V0dGluZyBieSBuYW1lLg0KPiA+ID4g
PiAtIEZpeCBtdWx0aWxpbmUgY29tbWVudHMuDQo+ID4gPiA+IC0gRml4IHZhcmlvdXMgaWYtc3Rh
dGVtZW50cyB3aGljaCB3ZXJlIGV4cGxpY2l0bHkgY29tcGFyaW5nIHRvDQo+ID4gPiA+IDAgb3IN
Cj4gPiA+ID4gwqAgTlVMTC4NCj4gPiA+ID4gLSBGcmVlIHZhcmlvdXMsIHRlbXBvcmFyeSBpbnN0
YW5jZXMgb2YgYWxsb2NhdGVkIHN0cmluZyBsaXN0cy4NCj4gPiA+ID4gLSBTZXQgZGVmYXVsdCBl
bnYgdmFsdWVzIGZvciBCT09UX09SREVSIGFuZCBhc3NvY2lhdGVkDQo+ID4gPiA+IEJPT1RfKl9M
RUZUDQo+ID4gPiA+IMKgIHZhcmlhYmxlcy4gVGhlc2UgdmFyaWFibGVzIGFyZSBtYW5kYXRvcnkg
Zm9yIFJBVUMgdG8gd29yay4NCj4gPiA+ID4gLSBVc2UgY2FsbG9jKCkgaW5zdGVhZCBvZiBtYWxs
b2MoKSBmb3IgYWxsb2NhdGluZyB0aGUgcHJpdmF0ZQ0KPiA+ID4gPiBzbG90cy4NCj4gPiA+ID4g
LSBVc2UgY29uZmlnIG9wdGlvbnMgZm9yIGNvbmZpZ3VyaW5nIHRoZSBwYXJ0aXRpb25zIGFuZCBk
ZWZhdWx0DQo+ID4gPiA+IGJvb3QNCj4gPiA+ID4gwqAgb3JkZXIsIGluc3RlYWQgb2Ygc2V0dGlu
ZyB0aGVtIHZpYSB0aGUgVS1Cb290IGVudi4NCj4gPiA+ID4gLSBVc2UgYm9vdHN0ZF9nZXRfcHJl
Zml4ZXMoKSdzIHJldHVybiB2YWx1ZSBhbmQgY2hlY2sgYWxsDQo+ID4gPiA+IGF2YWlsYWJsZQ0K
PiA+ID4gPiDCoCBwcmVmaXhlcyBmb3IgdGhlIGJvb3Qgc2NyaXB0Lg0KPiA+ID4gPiAtIEFkZCBh
IHByb3BlciBib290IG9yZGVyIHNlbGVjdGlvbiBsb2dpYyBmb3IgdGhlIHJhdWMNCj4gPiA+ID4g
Ym9vdG1ldGgsDQo+ID4gPiA+IHNpbWlsYXINCj4gPiA+ID4gwqAgdG8gdGhlIHByZXZpb3VzIGVu
dmlyb25tZW50IHNjcmlwdGluZywgd2l0aCBmYWxsYmFja3MgYW5kDQo+ID4gPiA+IHNsb3QNCj4g
PiA+ID4gdHJ5DQo+ID4gPiA+IMKgIGNoZWNrcy4NCj4gPiA+ID4gLSBJbnRyb2R1Y2UgY29uZmln
IG9wdGlvbiBmb3IgcmVzZXR0aW5nIGFsbCBzbG90IHRyaWVzIGluIGNhc2UNCj4gPiA+ID4gdGhl
eQ0KPiA+ID4gPiBhcmUNCj4gPiA+ID4gwqAgYWxsIHplcm8uIFRoaXMgbWF5IHByZXZlbnQgYSBz
eXN0ZW0gZnJvbSBsb2NraW5nIHVwIGluIHRoZQ0KPiA+ID4gPiBib290bG9hZGVyLg0KPiA+ID4g
PiAtIFJlbmFtZSBlbnYgdmFyaWFibGUgIm1tY3Jvb3QiIHRvICJkaXN0cm9fcm9vdHBhcnQiLCB0
byBiZSBpbg0KPiA+ID4gPiBsaW5lDQo+ID4gPiA+IHdpdGgNCj4gPiA+ID4gwqAgImRpc3Ryb19i
b290cGFydCIuDQo+ID4gPiA+IC0gQ2hhbmdlIHRoZSBib290bWV0aCBmbGFnIHRvICJnbG9iYWwi
LCBhcyB0aGUgcmF1YyBib290bWV0aA0KPiA+ID4gPiBkb2VzDQo+ID4gPiA+IG5vdA0KPiA+ID4g
PiDCoCB3b3JrIGZvciBpbmRpdmlkdWFsIHBhcnRpdGlvbnMuDQo+ID4gPiA+IC0gVXBkYXRlIGRv
Y3VtZW50YXRpb24gYWNjb3JkaW5nbHkuDQo+ID4gPiA+IC0gTGluayB0byB2MToNCj4gPiA+ID4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDEyOS13aXAtYm9vdG1ldGgtcmF1Yy12MS0w
LTYzMDhlNzMyZjMxNEBwaHl0ZWMuZGUNCj4gPiA+ID4gDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBN
YXJ0aW4gU2Nod2FuICgyKToNCj4gPiA+ID4gwqDCoMKgwqDCoCBib290c3RkOiBBZGQgaW1wbGVt
ZW50YXRpb24gZm9yIGJvb3RtZXRoIHJhdWMNCj4gPiA+ID4gwqDCoMKgwqDCoCBkb2M6IEFkZCBk
ZXNjcmlwdGlvbiBmb3IgYm9vdG1ldGggcmF1Yw0KPiA+ID4gPiANCj4gPiA+ID4gwqBib290L0tj
b25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA1MSArKysr
Kw0KPiA+ID4gPiDCoGJvb3QvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAxICsNCj4gPiA+ID4gwqBib290L2Jvb3RtZXRoX3JhdWMuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDQzMg0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiA+ID4gwqBkb2MvZGV2ZWxvcC9ib290c3RkL2luZGV4LnJzdMKg
wqDCoCB8wqDCoCAxICsNCj4gPiA+ID4gwqBkb2MvZGV2ZWxvcC9ib290c3RkL292ZXJ2aWV3LnJz
dCB8wqDCoCAxICsNCj4gPiA+ID4gwqBkb2MvZGV2ZWxvcC9ib290c3RkL3JhdWMucnN0wqDCoMKg
wqAgfMKgIDU2ICsrKysrDQo+ID4gPiA+IMKgNiBmaWxlcyBjaGFuZ2VkLCA1NDIgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gYmFzZS1jb21taXQ6IGIyMmEyNzZmMDM5ZjgxOGQ1
NTY0YmVjNjYzNzA3MWNmYzhhN2U0MzINCj4gPiA+ID4gY2hhbmdlLWlkOiAyMDI1MDEyOS13aXAt
Ym9vdG1ldGgtcmF1Yy0wM2I1ZTJkZDg4ZjQNCj4gPiA+ID4gDQo+ID4gPiA+IEJlc3QgcmVnYXJk
cywNCj4gPiA+ID4gLS0NCj4gPiA+ID4gTWFydGluIFNjaHdhbiA8bS5zY2h3YW5AcGh5dGVjLmRl
Pg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gR3JlYXQgdG8gc2VlIHRoaXMuIENvdWxkIHlvdSBw
bGVhc2UgYWRkIGEgdGVzdCwgZS5nLiB0bw0KPiA+ID4gdGVzdC9ib290L2Jvb3RmbG93LmMgPyBM
ZXQgbWUga25vdyBpZiB5b3UgbmVlZCBoZWxwLg0KPiA+IA0KPiA+IFRoYW5rIHlvdSEgOikNCj4g
PiANCj4gPiBJIHdpbGwgaGF2ZSBhIGxvb2sgaW50byBhZGRpbmcgYSB0ZXN0IGZvciBpdC4gU29y
cnksIHRoYXQgSSBkaWRuJ3QNCj4gPiBtYWtlDQo+ID4gaXQgZm9yIHRoZSBmaXJzdCBpdGVyYXRp
b24sIGFzIHlvdSBtZW50aW9uZWQgaXQgcHJldmlvdXNseS4gV2lsbCBpdA0KPiA+IGJlDQo+ID4g
b2theSwgaWYgSSBhZGQgdGhpcyBpbiBhIHNlcGFyYXRlIHBhdGNoPw0KPiA+IA0KPiA+IEknbGwg
cHJvYmFibHkgbm90IGhhdmUgdGltZSBmb3IgdGhpcyB1bnRpbCBlbmQgb2YgSnVuZSwgYXMgSSdt
IG9uDQo+ID4gdmFjYXRpb24gdGhlIG5leHQgdHdvIHdlZWtzLiBCdXQgSSBkZWZpbml0ZWx5IGhh
dmUgaXQgb24gbXkgYWdlbmRhLg0KPiANCj4gV2UgY2FuIGFkZCB0aGUgdGVzdHMgaW4gYSBmb2xs
b3ctdXAsIHRoYXQncyBmaW5lLiBJJ20gYXNzdW1pbmcgeW91J2xsDQo+IGJlDQo+IHB1dHRpbmcg
dGhpcyBpbiB0byBzb21lIHRlc3QgZnJhbWV3b3JrIGZvciBwcmFjdGljYWwgdGVzdGluZw0KPiBp
bnRlcm5hbGx5Pw0KDQpZZXMsIHdlIGhhdmUgYXV0b21hdGVkIHRlc3RzIGZvciB0aGUgYm9vdCBw
cm9jZWR1cmUgYW5kIHdpbGwgYWxzbyB0ZXN0DQp0aGUgbmV3IHJhdWMgYm9vdG1ldGggYXMgc29v
biBhcyBpdCBpcyBiZWluZyB1c2VkIGluIG91ciB1cGNvbWluZyBCU1BzLg0KDQpSZWdhcmRzLCBN
YXJ0aW4NCg0KLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaUhVRUFSWUtBQjBXSVFU
aDlqYzhOQlZLbU1HOWd4TlIzWVU0NTJlVEFRVUNhRjFKendBS0NSQlIzWVU0NTJlVA0KQVRlbEFQ
OU1rcnhKMDFhSm4rTko2VkNObXlzRnJ2eWZ5NHNBdi8xY2d0bCtMQUwvV3dEL1RXNnBNZ3pKZTJM
cQ0KbDAxYjhyUkFmZmsvdDBrcXpUMFhvak95ZmlCc3dBVT0NCj1IdkwwDQotLS0tLUVORCBQR1Ag
U0lHTkFUVVJFLS0tLS0NCg==
