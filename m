Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4FACF65E2
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 01:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F2B83F3F;
	Tue, 27 Jan 2026 02:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KXqG7v7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B4A083F4C; Tue, 27 Jan 2026 02:58:38 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0BC83F2E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj1rglYzcETVafgp55HdKMjjJNLUN+/fz3jfh4or9BS6vf3c/aX3cnKb6UUxSyRA97cUUPNK3/1S4KqkGZ+RgqLxH3vumBRL2V18kQvY3Zc74CBlMmCfhS1QXVMVpvG1DmgaZoGxwl7InNJkf4bLDV3rXtqDmAd2ofTikXpX3GxZkEQ6YkafVwVihjPDk7COyz8W8uSWQc4OgaKbdCajnrQ/ULH0T10iKp3PhgPYFAST1ea/o+QtdBtsQrfKAYwUfurUQZtnlJEf8g6BJmOHcxJhn7Y3Wy7EtBm6l1cChZSSa14WlLcCOyLYM1YSsmgOUeGdlWs4JYYiwLHgfPWUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32jdGFJ04ydwQActYe2NI7VN8LCDNhozM5SrbBUZKOU=;
 b=GTqbFpCE/ix+PGdL81yDHIp/Olid9dGhPDU1qlRdpJnOSMRNd343faFBQ6Xx5x9yYYPFFiYbVJpJlOp8evxhsv5Zejr1NWggzTVnJfdz0NGI/NKdpuDh7OQZU1LB1IArHm/5hFbUnk3YoKyX9hDW4zvht9D2jl5gSlKVxeiWXKz/2wz8WoZwkypuPX3A3kPXUbsY63RkJ+nE29tou+ohWm+sF7jej05FAgz3n334NIyT6CAwfUXZhBrlckuHgkiy7ajxq0IGdXoTs4uBKin6vCUSQTczHkAUnHfLe/9YX//PmDFGqhlW/7JoEGfC0uLw7L6D34JrAKc6wJXAp9MFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32jdGFJ04ydwQActYe2NI7VN8LCDNhozM5SrbBUZKOU=;
 b=KXqG7v7ZW5lOhwOoCtkMKbm1spZYP1FVct0oXgXBBIMwvHNh506deJhv4cSBXy+mVA5eUl9zoymidx/vNxh99yjXwspy1GqQ/ibih5mzcEgayBX6KZPsTPg+IjZg7iX4IWi4Xu+KdGeaxQgO23vlT73CKnHZy7rergg84YG5fjDXJOGLlqv8pPJJ/wQ+IocSY7CVB2Yzj3ev4lnNQKu1hNfJu+JkB/Q5AwokrKPAoWMuOKxBxE+fi4fRbN+tp3KJrDIlYAKAOeWW4qZHQaw0AoSqmwqXptScjBkTEnOfn0kTEaGCAGL6VQuqrp5Kj6gsrWKzSVGFIAtyCg+7dbKeZQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 01:58:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 01:58:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Marek Vasut <marek.vasut@mailbox.org>, Chris Morgan
 <macroalpha82@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Alice Guo
 <alice.guo@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "thinhn@synopsys.com" <thinhn@synopsys.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "quic_varada@quicinc.com"
 <quic_varada@quicinc.com>, "felipe.balbi@linux.intel.com"
 <felipe.balbi@linux.intel.com>, "mkorpershoek@kernel.org"
 <mkorpershoek@kernel.org>, "lukma@denx.de" <lukma@denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "macromorgan@hotmail.com"
 <macromorgan@hotmail.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mian
 Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCBWMiA0LzRdIHVzYjogZHdjMzogY29y?=
 =?utf-8?Q?e:_improve_reset_sequence?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggVjIgNC80XSB1c2I6IGR3YzM6IGNvcmU6IGltcHJv?=
 =?utf-8?Q?ve_reset_sequence?=
Thread-Index: AQHcjzBuZZ/Drg8+Zk240pmJuZVTnQ==
Date: Tue, 27 Jan 2026 01:58:28 +0000
Message-ID: <PAXPR04MB9644CC074890135F23E44799E290A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-5-macroalpha82@gmail.com>
 <z2hh7mpyjljlvgjw53lggxuqundl3y4xcb4mdbczlgouwhygz6@phktqzuxxjs2>
 <d3dd54e3-d20f-4aa0-9da1-3c0e821d6aa7@mailbox.org>
 <PAXPR04MB96444D82A8CC6D3DABD42159E294A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <ngl2z4qam7wv4mh5gxrqpz2bcwl7atdywox26mzm5okozdy5jy@plkmlvh7kvxs>
In-Reply-To: <ngl2z4qam7wv4mh5gxrqpz2bcwl7atdywox26mzm5okozdy5jy@plkmlvh7kvxs>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU2PR04MB8583:EE_
x-ms-office365-filtering-correlation-id: 1a8ed464-4845-4f44-03ff-08de5d479106
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?TGVxVXh1MUJ4ZkhiZTczVUlab3hvZDVwbnI4UjgvQzZIdUxrc29oWUd5L1hN?=
 =?utf-8?B?MFVMWmVKV2sxb0twb3R4bWpBOGRna1A3ZlhmSzZ4Y25tL3hwQmhOOExXQ1pJ?=
 =?utf-8?B?dllvdndidVhnU1hlcEk3Z3IyaC91aGF4ZUhZUU5BSU1xWTg5dlRXQVMvblhB?=
 =?utf-8?B?QXZBUUQ4Ry91NWxvTStPQmxwL1RWVW5zZjhSbXUvdjl2QWhQRHZWeElPSGFl?=
 =?utf-8?B?ZWs2ZnVoeUh2bVNQckVxanpsaGVxdXN3KzdjUFJPdW9NU2xOQmNzYjRESzBU?=
 =?utf-8?B?eXE2WE9yZkZFaHVKb0p5QTYyamlxeFpQSytOcmUweURyeVlqNk5TSDZrNzBK?=
 =?utf-8?B?YlRNQ2tVUkRYbkM0RFdlMGZqQll4T0xrRU5sOUZjYkJPNVJmNlI4OVFmMmEy?=
 =?utf-8?B?bmFwRm9YRkRDRjRuSyszMzVxcVZxdVJFWDBzSUd5MXVPTlBCV0lZUVpZQXdY?=
 =?utf-8?B?ZkIxbTlPSUxvNDIzNUNuRE4zNE5aT2xmdW1CZ3JQTy9LYkc0R0c4ZXFKNFVI?=
 =?utf-8?B?YWVkOE83QkJJUk5Ub01lUU1ZQUd1RXlNSDg0dE5lNVA5b1cvYS9rZ1hHamJs?=
 =?utf-8?B?QWZreTBOV1kwbVNkdTg4ZHppTjJLTnNzNHFVTXAwaklhSXpoLzFna1ZKTFVS?=
 =?utf-8?B?bEFwNEN5SmdYUFVjdGhhOWxIbzRjTEt5Z2orV1J1N1NBZ3UrVWZVSG95MC92?=
 =?utf-8?B?ei9aZHRPWG43b1lyTFZSRktCZDA0ZHRpeHdtbUFOMzB0UnVZNjNTWW0xWXl1?=
 =?utf-8?B?Qk5EbjZCRHJZVTdHR082aEdMQXduQUFpZEN1M2YydFJLRjdZdkI2TUd1Rm9G?=
 =?utf-8?B?allKNy9RWTlnazNSZXZYYnpMYjZPQWdNNGZNWHA4T0RzdEtWUEZXS0dORjl3?=
 =?utf-8?B?bktxKzZWajNhbmsrRkQwNkNjcG9PdzRzYjZKVGtQVzhUMjJ5NXBLMlcyVkxv?=
 =?utf-8?B?OWxUWGRlRWRHbzlGZHp2STJNSTA5UGZ3WVhMUUxJSm5aUW1BeERvQmdKcTlU?=
 =?utf-8?B?OVAyaXFZdGFYaDhUYXRCUUVjUE5yVFZXeXlqQnVqRnFyeUJtS1BzSFNHak95?=
 =?utf-8?B?cXBTRFBjYWxaVTAvelZQdFUxYjQ1N3VRMlhVc0pYVDlWSjVyaThRZVF4OG1X?=
 =?utf-8?B?enFTcUJzMFhCcEpMbnd2Yzh3Umo2YlQyQlluY0d5YlZSczNycmozeE5EKzVl?=
 =?utf-8?B?R21OVGFoTitWdjVzWUxOZVZaVGFTWnBmS0JGbXVOUTloQlBWY1hwSDhoRVFY?=
 =?utf-8?B?bzllTHhyR0gxRXM2T1JpazJBbm5lSEhRTlJQL0pMQWxYYSsxRGhSbVByS2dm?=
 =?utf-8?B?ZmZOZWcwSnZYdk9zdHA1R1p5M3U2elpqWXJDRXE3SGh1NEVweG8xaHBtekNv?=
 =?utf-8?B?czU0cE9pMERiQnpRS0hyNG5PNFA0VGxsZXFsZ1AvV0s5dVFSL09lVzZsUS9o?=
 =?utf-8?B?Um5SenJwekZ6b01xNWZFMThFSnZObmtmeWdSNUgzRVI1ZU9rSkRma1JvTDNq?=
 =?utf-8?B?Zkhra1V5M0l6SXpYcG53NUl0bXJiclMvOVZiT3pSVFlwZncwU1NUWENqbDlB?=
 =?utf-8?B?WWVpQVRQbmVpMFFpRmdJTW54anovNVlpSDl6YlhBVjZKMlZ4eHV3c1RuSHNG?=
 =?utf-8?B?Vzk4OVFpckhqNnR5RVNjZG9WblN2aE9DOEtuS2s4dDBLU0Z5R0s1NUNkbE5Q?=
 =?utf-8?B?OHhKOGZaZy9qZGhQaXBxcjNDWWo4M0NLS2ovTVFFUmNJYUxSek9OTCtFczJS?=
 =?utf-8?B?KytOckJXZjNYMTJBNkw3ejkreHVaUDR5NFMrRGo5ak1NdmJsLzgvZS9WTmxQ?=
 =?utf-8?B?UlF6Q3JBdC9ySm96RUtMd21Jejc0MGkxZnJEQmxiN1dnRDB6dytldDBLQW9B?=
 =?utf-8?B?QlBGMm54Qlp4bllwWk8vUXJobE5OK1VDbU0rUXAwM0tvbGp2dW13WmIwbnVh?=
 =?utf-8?B?Wkc0MStud2ZBRFhVNWZEMGRJQ0N6d283aU9XSjFVcURjSHkxQjRnZ1pnU2RV?=
 =?utf-8?B?VXZTeVlHVitURDJFa0VtMGlxVHI3YUpTM3R2SjFRa2lZM09MK2hjV3VxcDJt?=
 =?utf-8?B?T2hRb2R3U1ZTOXZYRXdYTzdmaWZqWUZwZkNHdGNPeHNLSTVEUVk1Nzd2U1Vh?=
 =?utf-8?B?eDRMV1pKNWpvS3VrUllVa3I4dVJ2SFY5RWlnWGwvZ2kzbzdaTlQrVVB6b01R?=
 =?utf-8?Q?IoB1fC+k261EBp9MPW51oN0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b25jeThVK2FEVy83dXY5VE5kaFJWZFVmVXRieWpoTUhNc2ZjNzhnZmVHMXRZ?=
 =?utf-8?B?eVA4a1VMNVNnK3ROaDR0aTJ1dFdxQ3pmMm40dGppbTR0ZVUyNU85MFk3dW5n?=
 =?utf-8?B?WjkzdWpwTzB0Z3BVREpaSTdPN1E4am4yUittU3FLd0p1S0lnckM1U3NEMmdo?=
 =?utf-8?B?Z0pCWUIzTGRPbUdzcFFKa0ZGSVhWYVFtYm5KR0hwYjYzQ0tjOGs3Zk1tY1Vp?=
 =?utf-8?B?NGUvSHA2MTRZU0srRHYwQnFMTUVoOFdqNEJhazNvWTNNZUY1UGs5Z2VWR1Jq?=
 =?utf-8?B?N3hzSFZ2MkYyQjZYZWpKT2RIbHFDMjJsb05tZ2t6dk5iemJ3Wk0vVHgxdXMw?=
 =?utf-8?B?c1hEY2U3di9jZVpJSEwzK0wvR2Z3UG80NG1IQndmTUl3Rzg4UEdiOGJVdit0?=
 =?utf-8?B?aDM0WGFYcThmYXBkdTRreXZnaVhKbTJ4SnNrS2hGeW40V3JhV2wvOG9ydlNn?=
 =?utf-8?B?aXYyendsYXdtTkVCQ3BjWEkzMjEvWU84YXNrWmtJeDNjNWEzbC9BWjFaWTV2?=
 =?utf-8?B?RmlmeWRXamtxK3hKQTg3UGlsU01sMFI2eitJV0kzVjRjK0xUR1d0ZEU3NjY2?=
 =?utf-8?B?ZTgvQzdRajVNem9wSjlMN0dIQVdZMjFZL1J0U1BCdzMyZVRlK0k0VGJ0VitT?=
 =?utf-8?B?RTFNZGVqN3NkblZReHByL1ZyM3VxUndRYWtudm1oZXUxb2lxN1htaExlWW1T?=
 =?utf-8?B?OTNKN1ZYbFRlTVhNTStNeFdMUGRsL3dLWC9NaGo2MEM1d3YzMnRaVUF4MmNr?=
 =?utf-8?B?cFFBOXovUkk4TnpWcHZiZ2ZOMWpHMjAycWQvemJyZmRtMFZ5SHNmNXhXVGpr?=
 =?utf-8?B?amwxTE55RHB6ZW5BT2dUMGxwRGFwUGp4enZGTSs3dllFOWtIUEVFdzJ0RmhX?=
 =?utf-8?B?dEptSE5haGR1UDhOM3JNZUpIajcrTWtlSElwdEwrZ1pPbEJKbFJNOGNyZnhq?=
 =?utf-8?B?ZkhFTkVTSkUyY0pKZm1vK2NuV3FUNDZWYzYyRzRuRkluSXoyWmhKRXRUczBQ?=
 =?utf-8?B?akNsa2ZYcVlaUk51cktHdWpHWjR1aVRyU0JCek1DdzdsbWN5a2kwdkhlMVV5?=
 =?utf-8?B?NkdMdTVrdlFqUUxTek9GUXE3eGROR0h5UGU3VkMrbHF1MEwwUzJTbURVa0pl?=
 =?utf-8?B?WExmVU1LblBoV1AzNnRDK1lia0YzYWx1K09hOGtIZnJGczRqeGtCMzlFQ2tN?=
 =?utf-8?B?SHVwMzBrR2hWUnpwMEZLSFEwMGdQWldtYVZzVzM4cWhRZ0NEUXEwZlU4VktU?=
 =?utf-8?B?ZG1pM1BVa3ZINmFYdTlkZkVzem1oaUh6QTAvWFFZendtQWdaN2tqdFMvR3Z5?=
 =?utf-8?B?UHlVc0Nkd1E1ek0yZW5jMVdFR1RjdE5VajF3NUpDdk90T3Exb1JsVmc0VGVK?=
 =?utf-8?B?amRxM05jc3NHcUZ6OENrWTBTT1BhcHExV2lLSk9JcUp0V25nUEZHNVVIa2k3?=
 =?utf-8?B?Ni9sb0RVdDBLU0ZuRkR6bXhKOEcrMlc4TzFkbEU0RUtpTmxScGxtekc4ZWF6?=
 =?utf-8?B?dVFZemR0UTBCNjEwQitJS1d5R2JMaXVlSmRSOXF3NEwxeG5lSVQySUtWNTlx?=
 =?utf-8?B?RUU3K2pYMXk4RHZaeXhqL2JLUlA2aURXMG9BYjJKNWJUN05qZXdicEEyN1lp?=
 =?utf-8?B?TTJ3U091WHdZRWlWdUViRUlyM0JPbWo3N1JpU0dJQnRJMTYza2pqWS9LZklH?=
 =?utf-8?B?RVE1d1drdzM1aEFLTVdiQVU0MFJMcHg3aTIzT1VFYk1xTnRacHhoVG1YVUs0?=
 =?utf-8?B?MVozR2JWQTVDc1V0RXltNFhwSk1hbmZqb2l2clU0cVE2akh4c1Btbkp6NjNH?=
 =?utf-8?B?VUhUVHlaSm9kZmZHMExka0ZKczc3WUpzMXBtaDV6UWtIVGVJNHN2eUM2bjVP?=
 =?utf-8?B?Z3hiaFI2d204blVyV1dqeHlxczkrVENCYjRCWHhsTXhDQ2U3Qk9Cd2krNVZY?=
 =?utf-8?B?Y3kyMG5CbWNMdXJ6Q2FQOERHYnM3RnpydFVqbEVtZVcxY1VYV0dUaTA0enV0?=
 =?utf-8?B?YjZKSDJjUllSc0k1bThDbWk4UFZtMlVsdXJQM1BDdGtDSmdralNFUW81aXdz?=
 =?utf-8?B?c05ueWoyV1JMS09mYlgzeTZtTFlEb1NJWVl5VFJ1aHV2OXkvendCeE9tV3hJ?=
 =?utf-8?B?RHVBK3VCRHdmWk9CZ0plZDRrdi95QllwUGtyYTVGU2ZvUXB1c05NRGZzeWtY?=
 =?utf-8?B?NVJDcGxHMGhweThsTndXKzFndnlrYmRobFhHdi80SjFpSkJobGJCRnp3MXhH?=
 =?utf-8?B?OTVTcnlXeGRxdFd1VFlDMUxxblRaWk1yQlhLZ2VKWVhHRUwwd05qckxaM3Nx?=
 =?utf-8?Q?DDbqQFlRQEZcy4MKJr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8ed464-4845-4f44-03ff-08de5d479106
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 01:58:29.0261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSJ0glasGK0zbDoswzMjfWkimh6trkhYQQQNNX1R73HY0UWijsak777r646et7NDngjRyJ/SxaQNNC70JcVNVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRXJuZXN0IFZhbiBIb2Vja2Ug
PGVybmVzdHZhbmhvZWNrZUBnbWFpbC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyNuW5tDHmnIgy
M+aXpSAyMjoxMw0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5u
eHAuY29tPg0KPiDmioTpgIE6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz47
IENocmlzIE1vcmdhbg0KPiA8bWFjcm9hbHBoYTgyQGdtYWlsLmNvbT47IFBlbmcgRmFuIChPU1Mp
IDxwZW5nLmZhbkBvc3MubnhwLmNvbT47IEFsaWNlDQo+IEd1byA8YWxpY2UuZ3VvQG54cC5jb20+
OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdGhpbmhuQHN5bm9wc3lzLmNvbTsNCj4gbmVpbC5hcm1z
dHJvbmdAbGluYXJvLm9yZzsgcXVpY192YXJhZGFAcXVpY2luYy5jb207DQo+IGZlbGlwZS5iYWxi
aUBsaW51eC5pbnRlbC5jb207IG1rb3JwZXJzaG9la0BrZXJuZWwub3JnOyBsdWttYUBkZW54LmRl
Ow0KPiB0cmluaUBrb25zdWxrby5jb207IG1hY3JvbW9yZ2FuQGhvdG1haWwuY29tOyBUaGluaCBO
Z3V5ZW4NCj4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+OyBNaWFuIFlvdXNhZiBLYXVrYWIN
Cj4gPHlvdXNhZi5rYXVrYWJAaW50ZWwuY29tPg0KPiDkuLvpopg6IFJlOiDlm57lpI06IFtQQVRD
SCBWMiA0LzRdIHVzYjogZHdjMzogY29yZTogaW1wcm92ZSByZXNldCBzZXF1ZW5jZQ0KPiANCj4g
T24gRnJpLCBKYW4gMjMsIDIwMjYgYXQgMDc6MjQ6MDRBTSArMDAwMCwgQWxpY2UgR3VvIChPU1Mp
IHdyb3RlOg0KPiA+ID4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiA+ID4g5Y+R5Lu25Lq6OiBV
LUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxpc3RzLmRlbnguZGU+IOS7o+ihqCBNYXJlayBWYXN1dA0K
PiA+ID4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0MeaciDIy5pelIDIwOjM0DQo+ID4gPiDmlLbku7bk
uro6IEVybmVzdCBWYW4gSG9lY2tlIDxlcm5lc3R2YW5ob2Vja2VAZ21haWwuY29tPjsgQ2hyaXMg
TW9yZ2FuDQo+ID4gPiA8bWFjcm9hbHBoYTgyQGdtYWlsLmNvbT47IFBlbmcgRmFuIChPU1MpIDxw
ZW5nLmZhbkBvc3MubnhwLmNvbT47DQo+ID4gPiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29t
Pg0KPiA+ID4g5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdGhpbmhuQHN5bm9wc3lzLmNv
bTsNCj4gPiA+IG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc7IHF1aWNfdmFyYWRhQHF1aWNpbmMu
Y29tOw0KPiA+ID4gZmVsaXBlLmJhbGJpQGxpbnV4LmludGVsLmNvbTsgbWtvcnBlcnNob2VrQGtl
cm5lbC5vcmc7DQo+ID4gPiBsdWttYUBkZW54LmRlOyB0cmluaUBrb25zdWxrby5jb207IG1hY3Jv
bW9yZ2FuQGhvdG1haWwuY29tOyBUaGluaA0KPiA+ID4gTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lu
b3BzeXMuY29tPjsgTWlhbiBZb3VzYWYgS2F1a2FiDQo+ID4gPiA8eW91c2FmLmthdWthYkBpbnRl
bC5jb20+DQo+ID4gPiDkuLvpopg6IFJlOiBbUEFUQ0ggVjIgNC80XSB1c2I6IGR3YzM6IGNvcmU6
IGltcHJvdmUgcmVzZXQgc2VxdWVuY2UNCj4gPiA+DQo+ID4gPiBPbiAxLzIyLzI2IDE6MTUgUE0s
IEVybmVzdCBWYW4gSG9lY2tlIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIEphbiAxNSwgMjAyNiBh
dCAwNTowMTozNVBNIC0wNjAwLCBDaHJpcyBNb3JnYW4gd3JvdGU6DQo+ID4gPiA+PiBGcm9tOiBD
aHJpcyBNb3JnYW4gPG1hY3JvbW9yZ2FuQGhvdG1haWwuY29tPg0KPiA+ID4gPj4NCj4gPiA+ID4+
IEFjY29yZGluZyB0byBTeW5vcHN5cyBEYXRhYm9vaywgd2Ugc2hvdWxkbid0IGJlIHJlbHlpbmcg
b24NCj4gPiA+ID4+IEdDVEwuQ09SRVNPRlRSRVNFVCBiaXQgYXMgdGhhdCdzIG9ubHkgZm9yIGRl
YnVnZ2luZyBwdXJwb3Nlcy4NCj4gPiA+ID4+IEluc3RlYWQsIGxldCdzIHVzZSBEQ1RMLkNTRlRS
U1QgaWYgd2UncmUgT1RHIG9yIFBFUklQSEVSQUwgbW9kZS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBI
b3N0IHNpZGUgYmxvY2sgd2lsbCBiZSByZXNldCBieSBYSENJIGRyaXZlciBpZiBuZWNlc3Nhcnku
IE5vdGUNCj4gPiA+ID4+IHRoYXQgdGhpcyByZWR1Y2VzIGFtb3VudCBvZiB0aW1lIHNwZW50IG9u
IGR3YzNfcHJvYmUoKSBieSBhIGxvbmcNCj4gbWFyZ2luLg0KPiA+ID4gPj4NCj4gPiA+ID4+IFdl
J3JlIHN0aWxsIGdvbm5hIHdhaXQgZm9yIHJlc2V0IHRvIGZpbmlzaCBmb3IgYSBsb25nIHRpbWUN
Cj4gPiA+ID4+IChkZWZhdWx0IHRvIDFtcyBtYXgpLCBidXQgdGVzdHMgc2hvdyB0aGF0IHRoZSBy
ZXNldCBwb2xsaW5nIGxvb3ANCj4gPiA+ID4+IGV4ZWN1dGVkIGF0IG1vc3QgMTkgdGltZXMgKG1v
ZHByb2JlIGR3YzMgJiYgbW9kcHJvYmUgLXIgZHdjMw0KPiA+ID4gPj4gZXhlY3V0ZWQgMTAwMA0K
PiA+ID4gdGltZXMNCj4gPiA+ID4+IGluIGEgcm93KS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBOb3Rl
IHRoYXQgdGhpcyBwYXRjaCB3YXMgc3VibWl0dGVkIHRvIExpbnV4IGluIDIwMTYgWzFdLCBob3dl
dmVyDQo+ID4gPiA+PiBJIGNhbiBjb25maXJtIGl0IGlzIG5lZWRlZCB0byBzdXBwb3J0IGdhZGdl
dCBtb2RlIGluIFUtQm9vdCBvbiBteQ0KPiBkZXZpY2UuDQo+ID4gPiA+PiBXaGlsZSBJIGFtIHJl
ZmVyZW5jaW5nIHRoaXMgcGF0Y2ggZnJvbSBMaW51eCBJIGFtIGluIGZhY3QgdGFraW5nDQo+ID4g
PiA+PiB0aGUgZnVsbCBleGlzdGluZyBkd2MzX2NvcmVfc29mdF9yZXNldCgpIGZ1bmN0aW9uIGZy
b20gTGludXggYXMNCj4gPiA+ID4+IGl0IGV4aXN0cyBpbiB2Ni4xOS1yYzUsIHNvIGl0IG1heSBk
aWZmZXIgc2xpZ2h0bHkgZnJvbSB0aGUNCj4gPiA+ID4+IGluZm9ybWF0aW9uIGluIHRoZQ0KPiA+
ID4gPj4gMjAxNiBwYXRjaC4NCj4gPiA+ID4+DQo+ID4gPiA+PiBbMV0NCj4gPiA+ID4+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpDQo+ID4gPiA+PiB0L3BhDQo+ID4gPiA+Pg0KPiB0Y2gvZHJpdmVycy91c2IvZHdjMz9pZD1m
NTlkY2FiMTc2MjkzYjY0NmUxMzU4MTQ0YzkzYzU4YzNjZGEyODEzDQo+ID4gPiA+Pg0KPiA+ID4g
Pg0KPiA+ID4gPiBIaSBDaHJpcywNCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHdv
cmsgaGVyZS4gV2UgYWxzbyBoYXZlIGlzc3VlcyB3aXRoIGdhZGdldCBtb2RlIG9uDQo+ID4gPiA+
IHRoZQ0KPiA+ID4gPiBpTVg5NSBEV0MzIElQLCBub3RpY2VkIG9uIG91ciBBcXVpbGEgaU1YOTUg
U29NLiBUaGlzIHBhdGNoIHNlcmllcw0KPiA+ID4gPiBmaXhlcyBvdXIgaXNzdWVzLCBidXQgb25s
eSB3aXRoIGEgc21hbGwgY2hhbmdlOg0KPiA+ID4gPg0KPiA+ID4gPj4gLQltZGVsYXkoMTAwKTsN
Cj4gPiA+ID4+ICsJZGV2X3dhcm4oZHdjLT5kZXYsICJEV0MzIGNvbnRyb2xsZXIgc29mdCByZXNl
dCBmYWlsZWQuXG4iKTsNCj4gPiA+ID4+ICsJcmV0dXJuIC1FVElNRURPVVQ7DQo+ID4gPiA+Pg0K
PiA+ID4gPj4gLQkvKiBBZnRlciBQSFlzIGFyZSBzdGFibGUgd2UgY2FuIHRha2UgQ29yZSBvdXQg
b2YgcmVzZXQgc3RhdGUgKi8NCj4gPiA+ID4+IC0JcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfR0NUTCk7DQo+ID4gPiA+PiAtCXJlZyAmPSB+RFdDM19HQ1RMX0NPUkVTT0ZUUkVTRVQ7
DQo+ID4gPiA+PiAtCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HQ1RMLCByZWcpOw0KPiA+
ID4gPj4gK2RvbmU6DQo+ID4gPiA+PiArCS8qDQo+ID4gPiA+PiArCSAqIEZvciBEV0NfdXNiMzEg
Y29udHJvbGxlciAxLjgwYSBhbmQgcHJpb3IsIG9uY2UgRENUTC5DU0ZSU1QgYml0DQo+ID4gPiA+
PiArCSAqIGlzIGNsZWFyZWQsIHdlIG11c3Qgd2FpdCBhdCBsZWFzdCA1MG1zIGJlZm9yZSBhY2Nl
c3NpbmcgdGhlIFBIWQ0KPiA+ID4gPj4gKwkgKiBkb21haW4gKHN5bmNocm9uaXphdGlvbiBkZWxh
eSkuDQo+ID4gPiA+PiArCSAqLw0KPiA+ID4gPj4gKwlpZiAoRFdDM19WRVJfSVNfV0lUSElOKERX
QzMxLCBBTlksIDE4MEEpKQ0KPiA+ID4gPj4gKwkJbWRlbGF5KDUwKTsNCj4gPiA+ID4NCj4gPiA+
ID4gT24gdGhlIGlNWDk1IEkgYWxzbyBuZWVkIHRoaXMgZGVsYXkgdG8gZ2V0IGV2ZXJ5dGhpbmcg
ZnVuY3Rpb25hbC4NCj4gPiA+ID4gSWYgSSByZW1vdmUgdGhlIGNvbmRpdGlvbmFsIHZlcnNpb24g
Y2hlY2sgaGVyZSwgaXQgd29ya3Mgd2VsbC4NCj4gPiA+ID4gJ2R3Yy0+cmV2aXNpb24nIGlzIDB4
NTUzMzMzMEIuDQo+ID4gPiA+DQo+ID4gPiA+IElzIGFueW9uZSBhd2FyZSBvZiB0aGUgRFdDMyBy
ZXF1aXJlbWVudHMgb24gdGhlIGlNWDk1Pw0KPiA+ID4gTGlrZWx5IEFsaWNlIG9yIFBlbmcuDQo+
ID4NCj4gPiBIaSBFcm5lc3QsDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2sg
b24gaS5NWDk1Lg0KPiA+DQo+ID4gSSB0ZXN0ZWQgdGhpcyBwYXRjaCBzZXJpZXMgb24gdGhlIGku
TVg5NSAxOXgxOSBFVksgYm9hcmQgd2l0aCBVU0IgU0RQIGJvb3QNCj4gb3ZlciB0aGUgVVNCMyBp
bnRlcmZhY2UsIGFuZCBpdCB3b3JrcyBjb3JyZWN0bHkgd2l0aG91dCB0aGUgYWRkaXRpb25hbCBk
ZWxheS4NCj4gPg0KPiA+IFRoZSBVbml2ZXJzYWwgU2VyaWFsIEJ1cyAzLjAgQ29udHJvbGxlciBv
biBpLk1YOTUgZG9lcyBub3QgbmVlZCB0aGlzIGRlbGF5IGluDQo+IG15IHRlc3RpbmcuIENvdWxk
IHlvdSBwbGVhc2UgdmVyaWZ5IHRoYXQgdGhlIFVuaXZlcnNhbCBTZXJpYWwgQnVzIDMuMCBQSFkg
aXMNCj4gY29uZmlndXJlZCBjb3JyZWN0bHkgaW4geW91ciBzZXR1cD8NCj4gPg0KPiA+IEJlc3Qg
cmVnYXJkcywNCj4gPiBBbGljZSBHdW8NCj4gDQo+IEhpIEFsaWNlLA0KPiANCj4gSSBzcGVudCBz
b21lIHRpbWUgdGVzdGluZyBhZ2FpbiBhbmQgY29tcGFyaW5nIHRoZSBkaWZmZXJlbmNlcyBiZXR3
ZWVuDQo+IDE5eDE5IEVWSyBhbmQgb3VyIEFxdWlsYSBpTVg5NSBkZXZpY2UgdHJlZXMgdG8gbWFr
ZSBzdXJlIHRoZSBEV0MzIGFuZA0KPiBEV0MzIFBIWSBjb25maWdzIHdlcmUgdGhlIHNhbWUsIGFu
ZCBJIGNhbm5vdCBnZXQgdGhlIFVTQiBnYWRnZXQgdG8gZnVuY3Rpb24NCj4gd2l0aG91dCB0aGlz
IGRlbGF5IGluIFUtQm9vdCBwcm9wZXIuIEl0IHdvcmtzIGluIHRoZSBVLUJvb3QgU1BMLCBkb2Vz
IGl0IGFsc28gd29yaw0KPiBpbiBVLUJvb3QgcHJvcGVyIGZvciB0aGUgRVZLLCBvciBqdXN0IHRo
ZSBTUEw/DQo+IA0KPiBJZiB0aGVyZSByZWFsbHkgaXMgc29tZSBkaWZmZXJlbmNlIGhlcmUgSSBj
YW4gZGlnIHVwIGFuIEVWSyBhbmQgY29udGludWUgbXkNCj4gdGVzdGluZy4gVGhhbmsgeW91IGZv
ciB5b3VyIGhlbHAuDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IEVybmVzdA0KDQpIaSBFcm5lc3Qs
DQoNCkkgdGVzdGVkIHRoZSBVTVMgZmVhdHVyZSBpbiBVLUJvb3QgcHJvcGVyLCBhbmQgaXQgd29y
a3MgY29ycmVjdGx5IHdpdGhvdXQgdGhpcyBkZWxheS4NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2Ug
R3VvDQo=
