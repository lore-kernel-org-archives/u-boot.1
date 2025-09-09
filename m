Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6D5CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 23:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E528319C;
	Wed, 10 Sep 2025 01:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="waDNG6HZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE528320C; Wed, 10 Sep 2025 01:33:38 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B440830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 01:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzGOh4zgEAAtk9CC5tt6dfFpebgl1bqT88VYBchoQuRzC5yRVmHUNgpZVUNyDIiSuwZL01NfJwwY8ff00PjS8iX4oYRkPTNIjEvhp2uXzu2X3wGATgcB4lfWiD4ELtUQwhcWDIyb+1zhsHExBpU2ehKVVHqv8JrUzC2raSjUESI7VGxoxoC65Y0sigHNJ+TdB2kXtYf2bh9DPeWouX5QzORvJrJe1pq0/nJ0fcsZTIWZUnOw5ZWyKuOUiSNhzf6ZQlzpPHRmyTLpYNkaF4ZcQ4EmDVjGrTK+4JIobW/no3Ykk900qroKR8Tn7/Wag2WC1mItR2S07In7JKfZxRLgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpD2YMOxZh3FKRpxtRqS9QGRbvaEMQW22entnD9TTjo=;
 b=mjx1mxHFfZtOvl1EKcmVp2JidVSljLSlHS7hzuCUsVEwO0pcqx8JsIqh6QIcOFzk5FqsX853L7OBroG9npQcxdVVBwkmFOSS79nCUJfrwY+uO5+HeR+88fnMFFlAxwwVwEDhqW4CrqnGUqkLENG3HxFOXwEjwjtkSew3BOVmNLCvLQTUEZa3x3DR1WSr88KVn6AkEmjr9hhcBxbtGp8+sJBJKvzIotNfxpfdclX5VtUeMHmxp/n5x/JZRKQPh/sciCo2aKk+KPJJlyt0GpWu6X9ZCOmpSJuY7AK1dRVv2WgqF7E+S/rhYzhwIn1kC732nZXK/kMwbbxWwYzBeIFL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpD2YMOxZh3FKRpxtRqS9QGRbvaEMQW22entnD9TTjo=;
 b=waDNG6HZMLH0fbVmIlr/DCtJdduxSXEdeZs/phUwRzu+ixiI1GcFdiAUTKDbGT0x2zJ9mox5Jf6NaYxizA0wezFYWTX6TLzMDP4stOAkTAG30jpsGRV8ufg3Rr9wnUZxo1Phs1ndBNv4dfRzjgDbpN8diJHw+w1+YDZatO25a18ZzP5s+lYbdUgJTmNVDD60re+DqnQYUAbz99sDx1Iw0+yzE1zLL1NMcmOt2+ZxutreoO99C3J3WXWijml4AAdaiFhUIg8u6rxjeek/IucAUvskuju6UI0CpMu8Dl/hWdQ8EtQf50Qb9DwcSNtVNim2acZjJGoVKoobenuNORr9Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5746.eurprd08.prod.outlook.com (2603:10a6:20b:1d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Tue, 9 Sep
 2025 23:33:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 23:33:34 +0000
Message-ID: <fa9cc9aa-b2e5-464f-81c0-42ea3c0e7cbb@iopsys.eu>
Date: Wed, 10 Sep 2025 02:33:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] airoha: rework RAM size handling to support multiple
 RAM size
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250909225751.19544-1-ansuelsmth@gmail.com>
 <6758d551-cf2a-42dd-bf2c-5574c89277af@iopsys.eu>
 <68c0b731.df0a0220.1d4f64.2389@mx.google.com>
 <ae009630-e001-41b0-bdb4-70be2fdd0101@iopsys.eu>
 <68c0b8af.050a0220.1b1c70.3768@mx.google.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <68c0b8af.050a0220.1b1c70.3768@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbca019-2238-4c34-8191-08ddeff94aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXpFMlEyZ0dDM011YkFONUJlMStjR05ENUlIdXBOQm9kTXUzamRQUFVqYUxv?=
 =?utf-8?B?UEVqOTNyRkdaaWkrOVFrRWxrbjlIUHNjcUdvZENqUWNQVjQ2Y1VPWEsxeEVC?=
 =?utf-8?B?SjFleVdUQ2tBdHBCU0tubW9EVFBjWDNtem1rTUpkSU5EK09UYi8rb0k0R2I4?=
 =?utf-8?B?WC9RNXQrbEs3NTRHV3NCazRqUkd4ZDBNdWpOd0NrN1VKYnRDZjZ0QlRtSEhH?=
 =?utf-8?B?RGwvdGNKMmVpQTF0cmVmNVlPNTJNaEpXVmMySW05ZHRIT3k1eWVOZVhpenpj?=
 =?utf-8?B?Uy9jdHUrUkd0UmJ5eVFkaWNQU3V4Tlp2UkJ0Q3VyaEVwa2Rhc3M1WVhmM3Ey?=
 =?utf-8?B?bkZQRldTeU1wUHVITi9hRStCb1hOT3Zib20zNldudS9YUGwzeHZGcXZCbkRG?=
 =?utf-8?B?M3B1OWYzS29RM25OcVNJbmNiU0R6SDlaYUwvRndMb3dzQzNmNjBVKzRpZjRa?=
 =?utf-8?B?cmptbnd4N1VVQUZVU0pUZE5mRDhsdkpmZiswa016TG9EVWxvaWZvTkVpY2U3?=
 =?utf-8?B?RTZ0R2VXOHRxOFNDelc5dTcwajdRRjJTQzRJbXc2SzJIZjYvSzlTWklIdXh3?=
 =?utf-8?B?WHQrc2hOVTBxTS8vWUtnNHY3OHFxbzh3SHBCYUJjMTJoeW0rOVNkaUkveGZN?=
 =?utf-8?B?U3FhMFhkbUw4ckkzYXVGdkFUN0ZYR3lTOEpmM3hyVUwwcDdkbUlCMUhtZVNL?=
 =?utf-8?B?US9zQVE3Ym9sTXhmRlNVN3krUFdvYTh6K1lFS0pZdEMrazdXUzdzOXV1S1dG?=
 =?utf-8?B?RVBCbXp2Zm9jM3o3cFF4ak5PZ2UxM1kwL1dIU0cwVkhqYll5NGM5d1RVNDFv?=
 =?utf-8?B?Nnc5Yk9qc3lSZlh6VHc4RitwaUU3bmlkdWRWbTRzZGpKZVJQb0hpWklMTVhu?=
 =?utf-8?B?WExDMUZQdytQOVpCSXNLTlNFeHVKNHlpcXdmRE8va2hVcnVXTk9YVU5VYjNT?=
 =?utf-8?B?eWRlbU9tcnk3dU15b0dEUXl6NWJ1MGFYNkpZekMrQmZ2R3cyQjBoMFJPaU9w?=
 =?utf-8?B?WkVPSXhXYytYM0hBNThHS0cwVTZzV3pkZHpRUk1tanE4WmZ1QUlLVmpwZ2Jx?=
 =?utf-8?B?Q2lSWG9zcFRhWWQ0OEh6d3c5RS9lOTIzWnJQTGY0cUtxQlZjRVBjZDZBY0d6?=
 =?utf-8?B?aElwZFBXWWU5azUvNDdjSDgrd0dNeGlBQ0JpbUVWY0xFZ1BWSTkvVitDbkk0?=
 =?utf-8?B?ME5zZEpsT3BHa1V1MkU1RmNya3dKektwUG0yYzN2dG1WN0Z2N3JhQ1ZGTTND?=
 =?utf-8?B?UnlRL3BNOFNNVFRLTVdPWGRvNkg3bjNGZ1NmOG9iS2R1K2xnbkNoQVg2ZlVp?=
 =?utf-8?B?MGRkcU8rejJHY2Nqa1hjRzdENE1qdmdOaFpPVnlVUzYwZXpZenljYXZpNGJy?=
 =?utf-8?B?azFncklxOHIwdE9CdXdyUE5HcUIwRXNwLzA4c1dSR1NBeU9LdDZ1YXE3MEpG?=
 =?utf-8?B?SXBiSFE2amFRb1pRQ2FueTVZbkdnd1YyS0I3OHI5UC90ZU9TRSt0NXhrNnhC?=
 =?utf-8?B?Z1I4U2pieC9xUkttcXliTTZzNGhUMFdRSUQvZWU4VGZlWHUxSHhYRXN3SkJ3?=
 =?utf-8?B?OHdCS0tURWFLNHI2M05JcDdVYkpKS1FSNmxLZzM5bm1nYmw2ZnlndUJSTUlC?=
 =?utf-8?B?RHlJaUluTFAvbHdEMkdFbnZvd1BoVjdkL21wNlp2bUF5RnhkUGNPNHB0NDZZ?=
 =?utf-8?B?cTdTNE9pZHQ3aXZTQXN5OUZzcHFvY3JOY0h4MTJNQVFKbXZ3emVrT3UzWWo5?=
 =?utf-8?B?OUlVZjgreWx0NGlpSzUvYUNnNmt6TFkra1BWQjFJQnlLS1FFZmlSQ2VIZkY4?=
 =?utf-8?B?SCtvZkN5QmRNZWlOZEVCM3ZpbU5kZjNhMXpMdnd2anR6aHRYYjd1S053NFBl?=
 =?utf-8?B?a0Z1MkZMYXV2eHRKSTVPTnNXMC9rR3llU3cwTENtTG55bXhETm1BaWFQMXl0?=
 =?utf-8?Q?ZVTIXrfRmew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWhaNGt2Z29HaEdJSzhtMWVtVVl4QzRVMllEUUk2eHVhOHpxTUVZQzdldkZG?=
 =?utf-8?B?WE9zMktMeEx4WlkwQjR2bXVQZ01KTk8xRTdKb2s2cDF2aWhGZitwaFh0WWxE?=
 =?utf-8?B?RDhyOWVmV0NERUxDNHlzTThSN3NGZi9HNkZrWkt4TTJ4VUFyS1NkUkNzb1pm?=
 =?utf-8?B?aE5iTThOeFV1U0p3c2pvZEZTSFBNY1JlL0E1R0ZqQXN2MWdPYTFSUjk2bTRm?=
 =?utf-8?B?Nkx3Nk1rc2d4R0VUbmtvb0M1aVg3Q1lpZDlGUUxJYUExNENYN3NLcmh0dW9a?=
 =?utf-8?B?VWo2Zm15MlVGSFVyY2pNUmZzUkdrNjlzcDUwbStBaUEvamU0QktXVENsYUZl?=
 =?utf-8?B?ZG9HVmpDb2dUMitnL3UycjR1N2VINUhLRUV2c0NYZ2xwMUtzdGtrdmFPQkw1?=
 =?utf-8?B?VHFLQTNpaXFDUTVuWm1LM09JOTR0RzJZVlJFZlEySW5yc1ozTEx3UDJBdFc2?=
 =?utf-8?B?ZTJNQ2lEQ0d2YnRRbkE3MndSMGJSMTJmSWc5ajJ5eFljZWlIUnd5eTNWZ1Vj?=
 =?utf-8?B?MEZRSXNSRm9CRDk5UmpDK05iOEZBTWpQZk8xVGdIWXFzc1FCT0VoSklXS3RO?=
 =?utf-8?B?eFhkNmxpN3hzSFpKb2FaNGQzQXlVNFlTcldOYWdQckZ4YmFqQlFUdi80Vnpu?=
 =?utf-8?B?T3loN1J5SnJMT3p5Mkl0SEZIR3Z0eXZlNmV4ZFFpU3pURlUrbllwQXA3Z29w?=
 =?utf-8?B?eXlvS0hqYk51WGpIV0tPM2twRjVPQ2VTV3BDNkgrMDFkQ21FQ1gvZEVUOVY4?=
 =?utf-8?B?a1lTTHdvYXNBMDVQZHEvUWltb2RCcC8wblpFamZjTkUvVk5yV1FpdVNMbVZj?=
 =?utf-8?B?QVAwdzR0YzZlYmV4MVdWc3hNU2Z5MUtZV0ZRTWNmVXQxZ3BnUjh0alptUEt4?=
 =?utf-8?B?T2NlNitpS0dkMjdTb3VYVFdqNWVkVWozem9iMWN1Tnc3bGV5ajRMcFhFTkFh?=
 =?utf-8?B?M29rRXlaVXpvbEt4ZEIzVFJHZWJib0VNaU5veTJZYjlQLy85SlB4OWNINzgz?=
 =?utf-8?B?MUVqWmVHMnBhNGF2YVZiSGpmb09sdlQvanAwalJGVTAzTDhzbENVdFF6RGdU?=
 =?utf-8?B?VTIrOEY3YmdqTGNTVU0rdHZxRm1GTXhpanB0YjZmbE15bTZPdWg5MVZFK3k4?=
 =?utf-8?B?bHZtdE9Mb0FtV1EvbEljMkM2Yld4TWFOK0pOK3MvM3JxMGFFRjV2UC84MFpJ?=
 =?utf-8?B?V2hEV2xzbnpLcUtFM3JCbENIS25zaVpSUDRrWUdIdGF2UTJMQXcrN2xXV200?=
 =?utf-8?B?Z0FvR1JhcUFES1RFb1ZZcU1oYTF1aHIwcUVubDd6R1lSVitKT1VUL0hZeHpr?=
 =?utf-8?B?Ri96eHFnNEFSckZrdzU5SklVR1o3dzlZcWMyL2NXeVc1dzNTN2tyTEc1NG1U?=
 =?utf-8?B?NktVT3JSOXpJb2Q3Y1kyRVR1VkRaNU9TMFEzRHFPTVg5bWxxODhGa0JrTTh6?=
 =?utf-8?B?eGx0SkF0TVM5YVVxWHp5OUl6T3dFRFVWaUo0ZVIwMkRzN1pZTVlkT2dYY3pE?=
 =?utf-8?B?bnVRTWFneVBTNk9adWxqMkJvSkNiZU04ZHo4NXBMNDNzbGI4VlJiNndYQ0VX?=
 =?utf-8?B?NXBCQXhVMEl6SitYZmovVzVESnM2elIxRzhqT0tua01GTjNuYWtxTjlqWGVW?=
 =?utf-8?B?QlRXMU1nTEw5amYxV2NEUWQvVFp5NVZjWnd4aHMxaE4xdE9TdVRDNm02dkpW?=
 =?utf-8?B?a3NBdkQ0T1Q0Qk8vWDhsREZHU2x5K29VUG5CNzF6Rk02cXF0b3JwQTI2dUtH?=
 =?utf-8?B?cFBpYnRrT3NrZHF5TG8vZmg2VEhUVnFIUzhhMStOMTRHTW5PenlBQWUzYW53?=
 =?utf-8?B?WEpoTjlqcjBoSHE0dC9sUm5QbjZpQkZjTHhXSkYrbEg2cG4vdEdvaU80L1lm?=
 =?utf-8?B?NjducXliWmhjQ2lrZjR3cDNrdlV5a0VLTFFrT0xzbVI0eUxuWDN2M1VKbmtt?=
 =?utf-8?B?K2s1cG93OVZaMHdrd3FnUkN4eFBoTWF5MWRBZUttWHlnTml3SS90OUdwb1Rh?=
 =?utf-8?B?QVBmaG1ZWjZITnhHNXAwak9Ec3JvVWRzQUQvMGg3YzVhenVQaHY1V0FVL2l2?=
 =?utf-8?B?aldMVnllNDdrRFpYU3c0NkdCK0xiNDdhenNGYlZ5QU1sbHhJeG5udzdsLzBJ?=
 =?utf-8?B?b3g1ZVgyTkMrK0lzT2wzQ2g5WEsxTlJnbWhYMFdycVFXMUNjdVZIT2VvQ1R3?=
 =?utf-8?Q?+qS6DnzOgUPE1NmvWvgiKWc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbca019-2238-4c34-8191-08ddeff94aed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 23:33:34.1066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cvOl7B+xZ++1tQK9LoX/9MH4Lj5E8k+abM1avSspC+sL6zsIDMf00tH/AWWujd98YKQwIn6NFwM5qqgcHDcY0vrx+JVCGLMqqeSXnBvOzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5746
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


On 10.09.2025 02:30, Christian Marangi wrote:
> On Wed, Sep 10, 2025 at 02:29:10AM +0300, Mikhail Kshevetskiy wrote:
>> On 10.09.2025 02:24, Christian Marangi wrote:
>>> On Wed, Sep 10, 2025 at 02:16:03AM +0300, Mikhail Kshevetskiy wrote:
>>>> On 10.09.2025 01:57, Christian Marangi wrote:
>>>>> There are multiple version of the same reference board with different
>>>>> RAM size and it's not enough to base the RAM size entirely from DT. To
>>>>> better support it use the get_ram_size way to scan for the actual RAM
>>>>> size of Airoha SoC and increase the size of the memory map.
>>>>>
>>>>> Also rework the memory map to account for 2 memyro map. The first one of
>>>> Misprint, please replace 'memyro' with 'memory'.
>>>>
>>> will fix.
>>>
>>>>> 2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
>>>>> rest of the RAM since up to 8GB are supported.
>>>>>
>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>> ---
>>>>> Changes v2:
>>>>> - Add memory map to support full 8GB
>>>>> - Assign 2gb to first memory map for U-Boot
>>>>>
>>>>>  arch/arm/mach-airoha/an7581/init.c | 40 +++++++++++++++++++++++++-----
>>>>>  1 file changed, 34 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
>>>>> index d149e0ee3c8..11992027d92 100644
>>>>> --- a/arch/arm/mach-airoha/an7581/init.c
>>>>> +++ b/arch/arm/mach-airoha/an7581/init.c
>>>>> @@ -2,10 +2,16 @@
>>>>>  
>>>>>  #include <fdtdec.h>
>>>>>  #include <init.h>
>>>>> +#include <linux/sizes.h>
>>>>>  #include <sysreset.h>
>>>>>  #include <asm/armv8/mmu.h>
>>>>> +#include <asm/global_data.h>
>>>>>  #include <asm/system.h>
>>>>>  
>>>>> +#define CFG_MAX_MEM_MAPPED  SZ_2G
>>>>> +
>>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>>> +
>>>>>  int print_cpuinfo(void)
>>>>>  {
>>>>>  	printf("CPU:   Airoha AN7581\n");
>>>>> @@ -14,12 +20,28 @@ int print_cpuinfo(void)
>>>>>  
>>>>>  int dram_init(void)
>>>>>  {
>>>>> -	return fdtdec_setup_mem_size_base();
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = fdtdec_setup_mem_size_base();
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
>>>> I think this will not work correctly for 2 memory regions with a gap in
>>>> between, see  an7581_mem_map. So I think we should use get_ram_size()
>>>> twice (for each of regions).
>>>>
>>> There is no gap between the 2 region. I have the memory map for the SoC,
>>> it's from 0x80000000 to 0x280000000
>>>
>>> With specified
>>> 0x080000000 0x100000000 32 bit
>>> 0x100000000 0x280000000 64 bit
>> Sorry, I am not calculate it properly.
>>
> Np actually thanks for extra checking this HEX calculation with bytes is
> annoying and very error prone sometimes!
>
> So aside from the typo I think this should be ok and should address all
> the memory when the kernel is loaded. Right?

looks good from my side,

With the misprint fixed,
Reviewed-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

>
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  int dram_init_banksize(void)
>>>>>  {
>>>>> -	return fdtdec_setup_memory_banksize();
>>>>> +	gd->bd->bi_dram[0].start = gd->ram_base;
>>>>> +	gd->bd->bi_dram[0].size = get_effective_memsize();
>>>>> +
>>>>> +	if (gd->ram_size > SZ_2G) {
>>>>> +		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
>>>> gd->bd->bi_dram[1].start does not match to the virtual address of second
>>>> region, see  an7581_mem_map. I think this is a mistake.
>>> Assuming ram_base ios 0x80000000 + SZ_2G we should be at 0x100000000.
>>>
>>> Am I wrong?
>> I was wrong, sorry.
>>>>> +		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  void reset_cpu(void)
>>>>> @@ -29,20 +51,26 @@ void reset_cpu(void)
>>>>>  
>>>>>  static struct mm_region an7581_mem_map[] = {
>>>>>  	{
>>>>> -		/* DDR */
>>>>> +		/* DDR, 32-bit area */
>>>>>  		.virt = 0x80000000UL,
>>>>>  		.phys = 0x80000000UL,
>>>>> -		.size = 0x80000000UL,
>>>>> +		.size = SZ_2G,
>>>>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>>>> +	}, {
>>>>> +		/* DDR, 64-bit area */
>>>>> +		.virt = 0x100000000UL,
>>>>> +		.phys = 0x100000000UL,
>>>>> +		.size = SZ_4G + SZ_2G,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>>>>  	}, {
>>>>>  		.virt = 0x00000000UL,
>>>>>  		.phys = 0x00000000UL,
>>>>> -		.size = 0x20000000UL,
>>>>> +		.size = 0x40000000UL,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>>>  			 PTE_BLOCK_NON_SHARE |
>>>>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>>>  	}, {
>>>>> -		0,
>>>>> +		/* List terminator */
>>>>>  	}
>>>>>  };
>>>>>  struct mm_region *mem_map = an7581_mem_map;
