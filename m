Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80732CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 16:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 449D6846A4;
	Mon, 15 Jun 2026 18:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JEwqwuKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E004C846B0; Mon, 15 Jun 2026 18:51:00 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CA784105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 18:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsfILq/p4ag9yGgi5l0PX+Hwps6dRZZ/t1j4ItFXR84BtPqj2weyS6K74CGhep7m8JdNrfHXYYwqp1/ry4WCXYZYWmvmaXqRc1MoLlE4ipneGiORY4zLCCWzGL3sJo+UBMZ8P8or3XyVkqhiSvSBGWEMmhvq0akvVQVeoOnLBs0tRTf5h+SOLzFSkanBBOfP7l/AYzhskhbh4ZRcQhB4qdVGX4g784Y5cqjFuUpqSnWO9kYFpf0+nsQGNyudBL210K1u2JPxrCpHpxh6fmO1Ji/BV6cQOecwECf6D7bMRkKwDi3QsSI+FtlroJBUs3WiT5cknqWFvkPgjWOLaAYrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoD7YafIXVymqS808rGEKa6ZM9lUqkXWWXHDrmQLU1U=;
 b=K5v0PZjzl6XD4nXaSM1lPHAuxoNdiPrR3AlS2xCltSKJ7oiX0fBZZF4H2w1BqojwmTo6FRjZyXeMzVXJy0lpBiGfcSmHrPXf84NyoIMq2lDCclH56ifZS9y+jelW5XinK7vQsJpGsFW4UlAZJvB1wbwko8gyUTM4jdVoAELz89GfQZ1pLUqAIFSVWcsJl1bik/bOu4dZzeF2OwcAyxpb61Xf4JJjtD7PExjLEghP53Fogc2IonTbyGxeGxW5Npeg4SBJijjFbBu3KMyTibnqLmiLptjbCbS0LvKcw19QgP9TLFJ5wOUbMmMz2dk9IrjWDwXo26+2vn6gWln99nxTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoD7YafIXVymqS808rGEKa6ZM9lUqkXWWXHDrmQLU1U=;
 b=JEwqwuKCTTXJgeai2cznH4oZG39wieqDUEsPCIGDpbvLR1qCen32S0mEU8wN9dv0j6GQsghRjUBjOWVw4q/DtsWZA3iZ/syubogHgX/+3i3Xx1LGNtrlWyjOc874jFSLCDk3IRGxvKV/b7dzVEApLRxBTWK/wI5/C5EM++D6FEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by FRWPR04MB11149.eurprd04.prod.outlook.com (2603:10a6:d10:174::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 16:50:52 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Mon, 15 Jun 2026
 16:50:52 +0000
Message-ID: <978a771c-678e-4956-9aa0-ba4fa8469350@cherry.de>
Date: Mon, 15 Jun 2026 18:50:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: fix building with OpenSSL 4.0
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Tobias Olausson <tobias@eub.se>, u-boot@lists.denx.de,
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
References: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|FRWPR04MB11149:EE_
X-MS-Office365-Filtering-Correlation-Id: aba7d9da-8386-48a7-5c63-08decafe42b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2Q+hXzSYfOk/ETkMK4jTF6q91/xJfrLwt57Cegyjbm7yN2kOEMPxCVvDEQaAM3XgzkyRdJ+XbhxtK2rMZLpp+/QHPatC5PxxQIn/s1wS9ZElZ97NmRLR202BaIFpUdrnY6shI/knBvRVE5d1BS3SxaSIPuJfW1/vEvtMd+Jed86dYQJXjPmGqbU+cmxTJrv+VId8e4GX4WdZXG++NvwpF+on+0rfIiIo65ktd1XkjaGCnbfYsDMtLKSOAHIPsEkifdK3j73hnn90++1i3aKl3rCXWYfUTMA+tni2weFRX9wqZ4XKM7nqeDiw4F7v8jrA2YL7G7KGwrb5H65IPduLHoeKkTT4ZTvFJPAPDxqVXBcA/48s6vzg/ckDGsOMyC5IpO8MMyhFIUBe8rvxFvUXKd7CWAca9HQOkrEa//hqvM2pHC/L5o0Fr5zCfSvmWwmYuEVgzxfjw0xzp41qxnqYH4mCe4zqj26ErU7vg5PJHazS5/kOW3fKfuzpuDscGwVkqdLSjoJnp83kdFyNV/v4FlEpkQIWLSbHU7Upu1FAiAliWrDAXe7JkfoBzM6hzn366foyyCuvHMgQYTpOZ+I5ctDA2aIdF3Mhfx3LgXck080D4bUbnpCfLywI49dFvT6guz+uxCNZWfhtUKq5gUou8FmrF6mQo+It7ufP3eRbMrXTmxHu3EVdkrtlxetYkoJfT5qkEHbRSSBunPFjYKdZAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRhK0dCcGxDcUlvTXhlMXVyWEZjR2xEWnNDR3p0TzdVdDgyTDhoU3FJRmkv?=
 =?utf-8?B?N1o0QktGMW9GZU1LMXlRZHlpRFhjN0ZGYUs2VmhnTUFkQm9rOE9VVW5YYjV2?=
 =?utf-8?B?QU95Z25rNlQ0SmNuUDQrZjR2YTRod2dQV0V0Z1hrZzd2aFVhQjFGYzlkSk5T?=
 =?utf-8?B?ZXM0WWFPQVJBK01yNkorTDFDbU9oN0FyNGZxWHVEcGFJV0M4VUhJYjJNYlFy?=
 =?utf-8?B?c3gwNVZGNEFFUGNIMnBXcGEyZFZrMzhnajI3K3p5NGVoVVlSYkRmVnBkcHNH?=
 =?utf-8?B?dTNIbFFzQUpJQTVybXFXMnVsS3crcUZXNmhpUnhKQXFIempNMDRhUXUyTlc5?=
 =?utf-8?B?eE5SdVRVcTRmSGRNa2UxZVhYeHBLbHVmYmtzdUhTV203TThtL2VqTGdTZ0hn?=
 =?utf-8?B?bWhpN1cyejg5U05rWVFtMXlDZlhaK2szTWZsZTE0emhwL0JUWEJUblhwMHRB?=
 =?utf-8?B?SVFkaUpzZk0yRUs2R3BON3V6cHFuTlp2d3RWTXlMUi9jTE5xODk1MCtkVHdp?=
 =?utf-8?B?eXVwQ2pmdmVGa21mS2R0ZjlIRm0yOWZ2aTJJL09FWnl4ajhoTEIzckZ3a1Jz?=
 =?utf-8?B?RFRmYUlLS2YwSnErOCtINU5ZdjFOd3ZJU3dReXlMTzhud2IxYU9RTEFBWFU5?=
 =?utf-8?B?NzgyWGtNZjFkMkRYZ2VTQW5jTWtyRmxMVUJQeE5rYU9xTkJEMEM3YnZSV3VR?=
 =?utf-8?B?VTVsTURCQXh0YWloUnBkamdpbzhRRSsxclZjNnA5c3NpajBmUkJoeVVuL0l2?=
 =?utf-8?B?SXBQQU4rNUZVdVNVNEZuWFU5R2g5RE9adzhONUpXYW52eXBFQiswckxnNUhW?=
 =?utf-8?B?V0wxVWpnamVNMW56R0lPSFY3cUxEdm5qZGlqQmNENHpNOUdkZFJrQ2VjTnZQ?=
 =?utf-8?B?TzRYdUJGUkhGdWVQZnZLdkpad0orQ3ZkazMvcnVsUXUzdWU0UTQ5YkRkRHV1?=
 =?utf-8?B?K0VKSFY2UnNEbUNValNCOTJycFBDZFpHb1gvRkk4K3BTTUpyZjBJTkVoYUZq?=
 =?utf-8?B?UWJFR3F2cDlTSXRjTER6WEVFMmRaRVcxaXg1MXkwK2kwcEs4YzhkTGltbVFm?=
 =?utf-8?B?OE5LOXVmclpuWGM5NTN0enB3TXdCczByYjJEWmlPS3k3Q3JoU21acldCU1RQ?=
 =?utf-8?B?WitobXRlaWpnTkMyUmRxODRUZ0lvbkY1cjFlakcweks1RHJoRU0wUHNyaEQ3?=
 =?utf-8?B?UGg5dGR3N1Y4T1VnOStMV1dwWWFOb0pmdktkSmczTlNZc0V2U2tqeFZJVG00?=
 =?utf-8?B?VGpTMVA1WnFDRWpDRzE4allPRE9GV3BVMjF3cEZ1TzRVUmI0bFBaclQwM0Q1?=
 =?utf-8?B?QlYzS3I2OG5SQ1ZYZnZ2QTZTbW5ucTM5ZnBvM3diUGRRQngraEhsTk1Pa2RE?=
 =?utf-8?B?VGJDTXhwY1ArVVdTVnJpQ3ZwclZSMGd2TGV0WkkycnpxWFpLMW9lR01ua2JM?=
 =?utf-8?B?WjVEQ2s4VEUyU2JLV1lLUlFsU3pDVHViOVMva1VyVTlORS8yYUtSQzRYZzFp?=
 =?utf-8?B?amFmdTUvbEJjdFg3dFJ2VGFhbzVFbTRaaHo5WERMNUp3QWFYcWFLbTF3aWpX?=
 =?utf-8?B?Sks5YWRvREQvRU9WdDVGaWxEellFQWJKQjg0RkVPa0NDMVQyR3NuMHRRRXNB?=
 =?utf-8?B?cllqQnU5RGFVeTJNeGRhbnBKbmRDSjEvenAwT0wrdEwxQ1EyTXp1OXR0R244?=
 =?utf-8?B?Z2FBRytMUll3SWw0dm96WXBTQ2ZBSW1aa3FyUEcvNzhXQmdOaWVXdlZ6YzF2?=
 =?utf-8?B?TUFMMEtpQm5vQkZvV2U4MEVoeGxEWS90dnVqd2JLTmlPWElGTVlyOERYMEJa?=
 =?utf-8?B?aTNSY3IrRG55LzhxbGVGTWlvZFE0cTUyZW9YMWdWYzc0d1B4UG1vaGlIY0hC?=
 =?utf-8?B?LzFHR21Sb1ZtY25SMmpQN1V0Y3BMc2FvcGx0dlVhSHovdk1sRDE5eGl2M2Fm?=
 =?utf-8?B?VXMrNmZiTS9uTys0b1BTTG1BMkJvMEtDOExjMHBTVzkvQjN6bVlYOGk2UWJU?=
 =?utf-8?B?NzBXWTZGUGVIWVdXTXRiREFYNzZUeFNoZ3oyL2pXb214QnUzdDFKbG02K0JO?=
 =?utf-8?B?UUxTd3lTb3p5TTNXYURaZzNYSVhETVJ1U3BnVUcrWGMwQVFHMHdtV01nTjBj?=
 =?utf-8?B?aExjTFlxTVFCclBMTTBsbFA5ZzBGWmpicElaTmMwVGt5N21udU1mMVdyQUZn?=
 =?utf-8?B?TkJ5d1JSdjFhTDMrd1RGdE9DaTROenhSMUJLWHMzNXBxTDBGSUN6ekF3V2Vq?=
 =?utf-8?B?eWJUNUJRbVJ0RjlEaGNab3RkQndiaW1JbDRMM05WVE0xUDVWRWhMTjFOWWI3?=
 =?utf-8?B?bTZETDRqS25UTnJnMk5kWG5GVDFWZUtRcVRNUVgzM2doM0wvamE0Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aba7d9da-8386-48a7-5c63-08decafe42b1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 16:50:52.3930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVRa+5oka9hWteZm5RuyCLW0bddG+kdWS8h9vylOl2vSlNdjHDx7jhKOKNJY0c4DGJF8mw1MdXrPRJrwebyA4RSCnG5GTvG6q42ZWhevjTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11149
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

Hi Heinrich,

On 6/15/26 6:07 PM, Heinrich Schuchardt wrote:
> Building with OpenSSL 4.0 fails:
> 
>      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
>      ./tools/../lib/rsa/rsa-sign.c: In function ‘rsa_engine_get_pub_key’:
>      ./tools/../lib/rsa/rsa-sign.c:115:9: warning:
>      ‘ENGINE_get_id’ is deprecated: ENGINE_get_id API symbol is removed.
>      Define OPENSSL_ENGINE_STUBS to mask linker errors.
>      [-Wdeprecated-declarations]
>        115 |         engine_id = ENGINE_get_id(engine);
>            |         ^~~~~~~~~
> 
>      rsa-sign.c: undefined reference to `ENGINE_load_builtin_engines'
>      rsa-sign.c: undefined reference to `ENGINE_by_id'
>      rsa-sign.c: undefined reference to `ENGINE_init'
>      rsa-sign.c: undefined reference to `ENGINE_set_default_RSA'
>      rsa-sign.c: undefined reference to `ENGINE_ctrl_cmd_string'
>      rsa-sign.c: undefined reference to `ENGINE_free'
>      rsa-sign.c: undefined reference to `ENGINE_finish
> 
> Add -DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations to the
> rsa-sign.c build flags.
> 

Please no.

We should not build OpenSSL engines when they aren't supported at all 
anymore.

Fedora is already complaining it doesn't build on OpenSSL 3.x anymore 
for them. See 
https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@redhat.com/

The linked patch is not satisfactory though, and I've provided lengthy 
feedback a few times (although often with a big delay).

I'm waiting on Eddie to answer as it's "gentleman agreement" in FOSS 
that the first who posts a patch gets to keep working on the patch until 
it gets satisfactory enough to be merged. I do admit I took a very long 
time a few times to answer so it didn't help with getting this forward. 
I am unsure how much longer we should wait for Eddie if more people are 
getting hit by this issue.

As told on the linked patch, I have local patches (that I need to write 
nice commit logs for) to support OpenSSL providers and remove OpenSSL 
engine support for releases and variants of OpenSSL not supporting 
engines. With (binman) unit tests passing.

Note that this patch here is also not sufficient as, sure, it makes it 
possible to build U-Boot again, but you won't be able to run the test 
suite as we build dummy-rsa-engine.c unconditionally and you'll have the 
same build issue then.

As said in the linked patch, I would welcome an immediate patch that is 
disabling OpenSSL engine support with a big ifdef (still won't fix the 
"dummy-rsa-engine"-based tests but I haven't come up with a way to fix 
this "nicely").

Cheers,
Quentin
