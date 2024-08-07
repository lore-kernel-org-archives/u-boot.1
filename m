Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E6CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 05:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6537288A9C;
	Wed,  7 Aug 2024 07:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SJ0t9nPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C40888A87; Wed,  7 Aug 2024 07:05:13 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3539B88A9C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 07:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4WO+rcWcYLnewllC+AlVZjFfSIaZ2mq9eOtRRgiwTOehLSYDLGmf4/FsdYPYvmW/ZGKAcq5vRQhscztpnSyTAFBC/f9TvlkuH1DZZymPDl6cMY+ITlydQISLmtoi3A/nZYpSPA1BvOXO1HBlP5zJ9oOwVenrfgZP3HkpbiKRwz6X/K17klwqbM9MJKS8/7/dm6X04L3Z+Q/5MfPIzIfxq2ciBy0ytynHC04BZ7T4u1OMhwlJ906TvTZfJYb46xIAXjk5u4BmSwJy8qbp65O37aAQfpW4BHlqRh6dzU/6skgBVnTYBo6b2mH3uQN29t6xgGz3iJlUoP+KxbEM9WJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiV/qyae/L/TZn0mOUE+XD32ufwRdSJXke+W/w/6P+U=;
 b=u0YuWkTO9nXFmREvS5YT6izf0Rf+gd5JK9qJZ1egQWmICcggdbmDh6TJ4vZhiOHdAT93f9kMxUGR8+pw+y/QkybyJEMuoomXooVY7BwsNjctiTYFfPqdAaNpKb9dEKpSVPaEBRhqfP+jMLQqjM9jlJ12vAAZCEeOIv42k/3VeEEA455ndNzL7R0WB5/5Of/v28msrwWea+4fAxFLkM4W6yaAZbwQLErNF7+DyThtD+HDKj8oY2HenQ4qlm3xB9Wb4/LuOzXooluKzaJIK8gHJw6CVKwnVzMMVhq0qRGVv/jFud4qBMGCkSk4p6+8DEFYsq+14e07PBVQLL5n+smjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiV/qyae/L/TZn0mOUE+XD32ufwRdSJXke+W/w/6P+U=;
 b=SJ0t9nPVdq5JvWfNQ1pXx+EAvw/mR50eXcAtShEtkETBHva1dYORKLEGjsig+S+WUxo9qlbPzm65ArXpugP0FLbjYKoGXYCL0kD14j8UUrRVt8X+K8cI8fz/7v1BH8Fuz0e3Qh029SVBY2bRF5bXbIFNph2Fkm70riOEixUd8p0=
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 05:05:05 +0000
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf]) by SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf%4]) with mapi id 15.20.7828.016; Wed, 7 Aug 2024
 05:05:05 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>, "Abbarapu, Venkatesh"
 <venkatesh.abbarapu@amd.com>, "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>
Subject: RE: [PATCH] cmd: sf: prevent overwriting the reserved memory
Thread-Topic: [PATCH] cmd: sf: prevent overwriting the reserved memory
Thread-Index: AQHa5/lJkycRxizd30e+eRTPuO/PwLIaxW8AgABpZSA=
Date: Wed, 7 Aug 2024 05:05:05 +0000
Message-ID: <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
In-Reply-To: <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6685:EE_|DS0PR12MB7533:EE_
x-ms-office365-filtering-correlation-id: a585960a-3ec7-4d23-681e-08dcb69e804b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aEY4Qk5GM2UvT1Jrc0ZvOE1mUW5aemRHL0E0N282a0s0ZFluZTQvUzNCRXdp?=
 =?utf-8?B?aVVDd0hMN0F5R1dxclpLb0lURnhNN3k2RG1tMXUzVU9WWG5obG94dHVrb0lS?=
 =?utf-8?B?NE1sODdLeHhISS9aZVB5UnZHQ1Y4SVBEZklyd25Gb0xvc2tRaUcxenR6czN2?=
 =?utf-8?B?cDlHb2R6VWRQK3FZaU9aT2g4aHprUm9HOW03OVRwWmVxV0w3ZUFQa2ZGZ2tq?=
 =?utf-8?B?M0xEaUhUQk9XdEoyTzlGczRjT29kTWFyRy9GaGxIR0FXR0djaWF1RmVDbWtz?=
 =?utf-8?B?WEJybW1SOCtWUk5ERElYbHhRbHhPbEJmMzV3STlKdXJ0c3lpdmFCVVNnZ0tv?=
 =?utf-8?B?TFNqNVFzQmhwRjhkZ0dJc0VQeC9ZSjB0RDFmQVBFWDZUcW5oMURhUTFxOXpu?=
 =?utf-8?B?VmRHbnRTUkVnSVFGNld3d2pqdUpzS2g3S25mSk5aMFp0WFBLRnEwOWI1U05m?=
 =?utf-8?B?Q25USjBmV20vVmhGSHZuMjlHVWM4UmFFYVZXMTJ6WkxTZ0plZ09NVEEyNDMx?=
 =?utf-8?B?ZTcxcmhHTlF4b1dRa1l4cEpiWVJvLzd3cjBWM1k5ZHdwQXBvK0xiTFZQRUpl?=
 =?utf-8?B?dFV0Y3c3bDFTQlVpOXJmMG9WRVZUWUcrcmd3azlic1VSbGtiVWl5bkFiaVhN?=
 =?utf-8?B?WjJpNVRpSUtBRUtuMHlkdHM3cnZZNjBHWG92bXpUMWRVL0VpZUk4QXVJSVhE?=
 =?utf-8?B?UTE1T0dEdTg3L09TSHV3a3hBYzltVEtyME9ZNkJ6b1hHcXZoTWVxZDlOSlAv?=
 =?utf-8?B?VUFJbm5YQzZEWmdJNUpNcXBSQTkzVWJFMzhUS0ppNmpVSFp0VCtwVnFkSTVE?=
 =?utf-8?B?SWJGakc0RlorbVpxSitrT0FOaGp5dFljdjU1K3RsczNsVHB2a2NLdEpHSEVL?=
 =?utf-8?B?dlpmalpKY1hGaGs3eG9peHljOXRvSkVxTitmU3o1TWhEUU5lbksrWnQxK3Jz?=
 =?utf-8?B?My85Q1Vna0tKUUVkVlBZTnFnUVltZUtya0t3djBsQUpiWXc3RkhuZThLOXJE?=
 =?utf-8?B?VnJyQjZ6cndsbFFTc3JiMzdVM1pxaUhUQXFxR0hTQjIvMFA3RzJFSFJNeDQr?=
 =?utf-8?B?SytRcTNyeFpyWWJIWnBaWUhQUldheG1CNTRveC9XNi9nQW1MWmNhYVdOK3px?=
 =?utf-8?B?UllqSGdwV1A2UE1KTGErcEFYd25UWUVnYVh5dDBNelE2SWNLejYzRnRQbVlp?=
 =?utf-8?B?UlovY29IMm8veklJaDNOcXZVUks5SnkyMU1zeWRmWmdUbWt6M0pBa0lFSit2?=
 =?utf-8?B?R3ZPd0FYK000TC9Xd016MDlXWXRieE44NjZyZGowMFFsQk1aSW1VVUQvOVNp?=
 =?utf-8?B?VFltL05DemxMRTNBZEdOQnEzdTdCWkpmSDd6NDZGU1ppQjZJRGF2dUdhU1l6?=
 =?utf-8?B?alJtdy9JcEk2aW5sU0pXVVVLbURXQzlackNma2JkdGFvYys4WEtuVFNWKy9Z?=
 =?utf-8?B?a1dyeEk0aGppTVd0V0puai9rNmhWUXRISS9HNmpwWWx0UjYveU1KTkxzZlZB?=
 =?utf-8?B?UTRKeTlRTTVaK3IwMmpCWXMyd2x1QlVuL1VLeEhqWkt1TGkwMitDdXpzcCtp?=
 =?utf-8?B?Qkg4MVMrYXo3NlVucno2KzIzdlorVjA0OWJ1NTdWVDN2SE8xbGdNV2hHaTlX?=
 =?utf-8?B?T3RCWVhtbDQwYTRiQWM3QW8yY29uSDJYT1YzL3RLcjlmTGFsVTM4UUZGZU4y?=
 =?utf-8?B?d0ZIY2FESWF2Y1h6bjRkZ3RMOU5SbmRubXp0MEZNMVMrczVxUnlnWlpNM25T?=
 =?utf-8?B?R3NnamZXR01uN3dnSm1PUmpYem5UVUtvOWVjOUN4VXRBT1JLV2JoYWJQN2Fp?=
 =?utf-8?B?U09saS9jR2pJU0o4dXZnaVZUZWlxUnQ0MXhlaHFVRmRZNzVGS085OUI2enRm?=
 =?utf-8?B?VmtyU1RpQ0dhc2VWVEc1aVFud1dpSTZpeXkvbitGdjkrWGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXVJTDcraEEzaktrQXhkTjI2RHVMdkttTWNpc3ZMVjdOaml0RVZoS3RlQU4v?=
 =?utf-8?B?U0RUZmdEVE5yS0xqN3dHcUFOV3RsVFFzd0g2TFZtVTlLMTZycnNkcTZkSm9R?=
 =?utf-8?B?UmdZaXR5bkdsNjkxL1MwK3VmVFpVUE9oV2dHdzZZRGNMOXozSTZ4eDNRUEFo?=
 =?utf-8?B?UUNKZWZraU4zYm1nUzZjNXVKbmV0UjRtNkFTVmdMc0htZ09OU2hjZlBaNU5s?=
 =?utf-8?B?a2pudVNEVWUvOEh2eEVCWDd1YU9mN3NFVVBUbUhkTkVqcTAxODRaalRJRlBZ?=
 =?utf-8?B?SXNyYk1admNBVHVBWkh2eGVSZUs0elZzNEt1YzhwT1FDR0p2VWd4dU9OTzA1?=
 =?utf-8?B?elQ1Ly9hRDBGMFdvc0E3WUJqWVJ0RWFYd2Nvd0F5cHIyZVR5cEg2U1Q2bC9T?=
 =?utf-8?B?N1B2SS84MHhseHVscnFRcTcyU2ZLdWRwejJnY3JMNmRTY3Q4K01YN1Z0cHBP?=
 =?utf-8?B?RU1GaU5MZkxIWm5UdTgvVWh1YVRLZ1hGTk5iSHk4MWFGaXlROWxmdWN1Mm1J?=
 =?utf-8?B?ZTNPSHBnaWd3NWhYS0EzL09KKzFBNFhLZUJNV2NWVmlBSXcwYXptQkkwdXkx?=
 =?utf-8?B?ZmJhc2tDRzE2Ykcvc1d6S3NmN0YyYytRNWx1TDVDdmNtUjc2UVc2dFNMYlhT?=
 =?utf-8?B?RHJITEc1eS9kSTZOcGpIdjgyOHhkd2lxbzlZck90YkdQdDZraUpaVnZnM0lv?=
 =?utf-8?B?RjFLRktueVJwVVd1QTB3Qk12enBRWURVUmhYMXpWMUhIUk1DRS9HTTFLcERz?=
 =?utf-8?B?cTBiTENQeXFDRmxBSHVCUVZMd1lBNll1OU9NT3Z6NjFwTFBRalh0eEltL1Mx?=
 =?utf-8?B?WjJnVGR6b0hLV1JLdENQemZGb2hyZXdBRnNka0VJNklYSmNBQmJFTEI4Wnd4?=
 =?utf-8?B?VmRWM2R6ZXRwY0R5emlURjRrZ3UrSnJQR21UZFBRYzRsbno2OVVhUHdjYjRx?=
 =?utf-8?B?dThZaTBSbUxZUWhlVTYwREdVb29PQ1VWN2VBMExOUDExM0wxWGlzb3ZYTm8x?=
 =?utf-8?B?S2FhenpJYzBjVVR1am9yQlJ6L1c5QkxsZVdvU0FDNHNnT3BCbEFtNHYxWGJ5?=
 =?utf-8?B?WkFSbk9kaWh6RFRTc2RXQUZINlJtL2VVMUNIZys1WlFmWUhlc2xCMG5kLytY?=
 =?utf-8?B?THVzZmxnUTMrZ2V4dzNZa2pqaitEOTA5UWoraDZ4K09RNzkvZE5QRWIveVY3?=
 =?utf-8?B?SzhFalRkVFg2WUZPaGFqOHliYW83dEN5bHhOVDZGZTFjMVU4NmpKNkNzQnpt?=
 =?utf-8?B?MTNyQ1kzRG9ZbWNHelpkcUVFK0pHTCtRMUdKMGRVTWlvWnd0NHRZVlZWakxo?=
 =?utf-8?B?RUNRVmJ5UVZaN09PU1ZzT29CU1ByR1kzL2ZOVXNsdVA4b3VjMFdaUjlEbnE1?=
 =?utf-8?B?S3BKWkpkMG1ja1R2d3VhczdWK0JWaEhKSCtESG5vODNFcDdjVnMwdkdnL1lL?=
 =?utf-8?B?ek91UE1RNHlCcjk3VFBsZVpQV015U0J3WE9rcVJYWXQ0cm93cDM1Ui8wbEF0?=
 =?utf-8?B?Vjh6ajJ0SS9DeE9RajEzQ0oySVFWUlJsREVnc1hFdXpsVXc2OHlMc1ZOWnFW?=
 =?utf-8?B?aEd4WXFJS1NYM01iUFRzMjhHUkp6ZkgrN00rL1FmOE8xKzErYy9pTEJrMDZr?=
 =?utf-8?B?RmlzSlloK3FlV214cjgzYndqNVFQKzR3bE1mS0U5czI4WXFYV0RBZEd3V21a?=
 =?utf-8?B?enZ5WVJCc2g0UlFKNkg2Ly81N2U4QTRRcTRHWWlxQW03N0w2eFNtYktKVzF4?=
 =?utf-8?B?YUhHNmh0OTk0QjZXejcxQWhFN2dPQnB0THBycHc5MHJWOXB3MGZmWkZJNDBG?=
 =?utf-8?B?WlpxNWtrVWtxUG9WVk8xMWpZYkJVL2twbFdkWFpqV0l2MVJseEVRN2FMOTVD?=
 =?utf-8?B?L3VMYXlyMlRBVkJQKzFOZGR1Z0RIUzQ2M0dNNWlpYVAvMHBDQzdHVTBMT3FZ?=
 =?utf-8?B?aERCNkpiNEhadjdTNHpLd3RPd1gzVUhwMDFZQXl3Q3VVSzZRdDU2SDFwQ3Nn?=
 =?utf-8?B?NWk5aW9Sc09aMFUwc25LL2w3KzRxWWtrZkUvRHhqNDhMak4xcjhaa2Q2YXA0?=
 =?utf-8?B?WnE5Q0dRVzZmRGdGVEwrVTE5S0tOZDlxMGJPcjNackZoa2R1eEhDUXliRGRM?=
 =?utf-8?Q?QGIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a585960a-3ec7-4d23-681e-08dcb69e804b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 05:05:05.2803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdcQFYYaO5Qd6y+AcOYXxV7SvpneiXpnO3RWwNBJfJ0rxvFyja1/dTRfw2k3Da23
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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

SGkgR2xhc3MsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDcsIDIw
MjQgMzoyMSBBTQ0KPiBUbzogS3VtbWFyaSwgUHJhc2FkIDxQcmFzYWQuS3VtbWFyaUBhbWQuY29t
Pg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQu
Y29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBYmJhcmFwdSwg
VmVua2F0ZXNoDQo+IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT47IGdpdEB4aWxpbnguY29t
Ow0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgbi1mcmFuY2lzQHRpLmNvbTsgZC1nb2xl
QHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbWQ6IHNmOiBwcmV2ZW50IG92ZXJ3cml0
aW5nIHRoZSByZXNlcnZlZCBtZW1vcnkNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hl
biBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4g
DQo+IA0KPiBIaSBQcmFzYWQsDQo+IA0KPiBPbiBUdWUsIDYgQXVnIDIwMjQgYXQgMDY6MDgsIFBy
YXNhZCBLdW1tYXJpIDxwcmFzYWQua3VtbWFyaUBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFk
ZGVkIExNQiBBUEkgdG8gcHJldmVudCBTRiBjb21tYW5kIGZyb20gb3ZlcndyaXRpbmcgcmVzZXJ2
ZWQgbWVtb3J5DQo+ID4gYXJlYXMuIFRoZSBjdXJyZW50IFNQSSBjb2RlIGRvZXMgbm90IHVzZSBM
TUIgQVBJcyBmb3IgbG9hZGluZyBkYXRhDQo+ID4gaW50byBtZW1vcnkgYWRkcmVzc2VzLiBUbyBy
ZXNvbHZlIHRoaXMsIExNQiBBUElzIHdlcmUgYWRkZWQgdG8gY2hlY2sNCj4gPiB0aGUgbG9hZCBh
ZGRyZXNzIG9mIGFuIFNGIGNvbW1hbmQgYW5kIGVuc3VyZSBpdCBkb2VzIG5vdCBvdmVyd3JpdGUN
Cj4gPiByZXNlcnZlZCBtZW1vcnkgYWRkcmVzc2VzLiBTaW1pbGFyIGNoZWNrcyBhcmUgdXNlZCBp
biBURlRQLCBzZXJpYWwNCj4gPiBsb2FkLCBhbmQgYm9vdCBjb2RlIHRvIHByZXZlbnQgb3Zlcndy
aXRpbmcgcmVzZXJ2ZWQgbWVtb3J5Lg0KPiANCj4gVGhlIFNQSSBmbGFzaCBtYXkgYmUgdXNlZCB0
byBsb2FkIG90aGVyIHRoaW5ncywgbm90IGp1c3QgYW4gT1MuIFdoYXQgaXMgeW91cg0KPiB1c2Ug
Y2FzZSBvciBwcm9ibGVtIGhlcmU/DQoNCltQcmFzYWRdOiAgV2UgaGF2ZSBvYnNlcnZlZCB0aGF0
IFNGIGNvbW1hbmQgY2FuIG92ZXJ3cml0ZSB0aGUgcmVzZXJ2ZWQgYXJlYSB3aXRob3V0IHRocm93
aW5nIGFueSBlcnJvcnMgb3Igd2FybmluZ3MuDQogVGhpcyBpc3N1ZSB3YXMgbm90aWNlZCB3aGVu
IHRoZSBURi1BIGFyZWEgaXMgcmVzZXJ2ZWQgaW4gdGhlIERldmljZSBUcmVlIGF0IGFkZHJlc3Mg
MHhmMDAwMDAwLiBUaGUgc2YgY29tbWFuZCBpcw0KIGNvcnJ1cHRpbmcgdGhlIHJlc2VydmVkIGFy
ZWEsICBhbmQgVS1Cb290IHJlbG9jYXRpb24gYWRkcmVzcyB0b28uDQoNCkVYOiBURi1BIHJlc2Vy
dmVkIGF0IGRkciBhZGRyZXNzIDB4ZjAwMDAwMA0KIA0KICAgICAgVmVyc2FsIE5FVD4gc2YgcmVh
ZCAweDBmMDAwMDAwIDB4MCAweDEwMCAgICAgLS0tLT4gT3ZlcndyaXRpbmcgcmVzZXJ2ZWQgYXJl
YS4NCiAgICAgIGRldmljZSAwIG9mZnNldCAweDAsIHNpemUgMHgxMDANCiAgICAgIFNGOiAyNTYg
Ynl0ZXMgQCAweDAgUmVhZDogT0sNCg0KICAgICBVLWJvb3QgcmVsb2NhdGlvbiBhZGRyZXNzIHJl
bG9jYWRkciAgID0gMHgwMDAwMDAwMDdmZWMyMDAwDQoNCiAgICAgIFZlcnNhbCBORVQ+IHNmIHdy
aXRlIDB4MDAwMDAwMDA3N2VjMjAwMCAweDAgMHgxMDAgICAtLT4gT3ZlcndyaXRpbmcgcmVzZXJ2
ZWQgYXJlYS4NCiAgICAgIGRldmljZSAwIG9mZnNldCAweDAsIHNpemUgMHgxMDANCiAgICAgIFNG
OiAyNTYgYnl0ZXMgQCAweDAgV3JpdHRlbjogT0sNCg0KPiANCj4gUmVnYXJkcywNCj4gU2ltb24N
Cj4gDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJhc2FkIEt1bW1hcmkgPHByYXNhZC5r
dW1tYXJpQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gVVQ6DQo+ID4gVGVzdGVkIG9uIFZlcnNhbCBO
RVQgYm9hcmQNCj4gPg0KPiA+IFZlcnNhbCBORVQ+IHNmIHJlYWQgMHhmMDAwMDAwIDB4MCAweDEw
MCBkZXZpY2UgMCBvZmZzZXQgMHgwLCBzaXplDQo+ID4gMHgxMDANCj4gPiBFUlJPUjogdHJ5aW5n
IHRvIG92ZXJ3cml0ZSByZXNlcnZlZCBtZW1vcnkuLi4NCj4gPg0KPiA+IFZlcnNhbCBORVQ+IHNm
IHJlYWQgMHg3OWVhOTAwMCAweCAweDEwMCBkZXZpY2UgMCBvZmZzZXQgMHgwLCBzaXplDQo+ID4g
MHgxMDANCj4gPiBFUlJPUjogdHJ5aW5nIHRvIG92ZXJ3cml0ZSByZXNlcnZlZCBtZW1vcnkuLi4N
Cj4gPg0KPiA+IFZlcnNhbCBORVQ+IHNmIHdyaXRlIDB4NzllYTkwMDAgMHggMHgxMDAgZGV2aWNl
IDAgb2Zmc2V0IDB4MCwgc2l6ZQ0KPiA+IDB4MTAwDQo+ID4gRVJST1I6IHRyeWluZyB0byBvdmVy
d3JpdGUgcmVzZXJ2ZWQgbWVtb3J5Li4uDQo+ID4NCj4gPiBWZXJzYWwgTkVUPiBzZiB3cml0ZSAw
eDc5ZWFmMDAwIDB4MjAwMDAgMHgxMDAgZGV2aWNlIDAgb2Zmc2V0IDB4MjAwMDAsDQo+ID4gc2l6
ZSAweDEwMA0KPiA+IEVSUk9SOiB0cnlpbmcgdG8gb3ZlcndyaXRlIHJlc2VydmVkIG1lbW9yeS4u
Lg0KPiA+DQo+ID4gIGNtZC9zZi5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9jbWQvc2YuYyBiL2NtZC9zZi5jDQo+ID4gaW5k
ZXggZjQzYTJlMDhiMy4uZDJjZTFhZjhhMCAxMDA2NDQNCj4gPiAtLS0gYS9jbWQvc2YuYw0KPiA+
ICsrKyBiL2NtZC9zZi5jDQo+ID4gQEAgLTEwLDYgKzEwLDcgQEANCj4gPiAgI2luY2x1ZGUgPGRp
djY0Lmg+DQo+ID4gICNpbmNsdWRlIDxkbS5oPg0KPiA+ICAjaW5jbHVkZSA8bG9nLmg+DQo+ID4g
KyNpbmNsdWRlIDxsbWIuaD4NCj4gPiAgI2luY2x1ZGUgPG1hbGxvYy5oPg0KPiA+ICAjaW5jbHVk
ZSA8bWFwbWVtLmg+DQo+ID4gICNpbmNsdWRlIDxzcGkuaD4NCj4gPiBAQCAtMjcyLDYgKzI3Mywz
NSBAQCBzdGF0aWMgaW50IHNwaV9mbGFzaF91cGRhdGUoc3RydWN0IHNwaV9mbGFzaCAqZmxhc2gs
DQo+IHUzMiBvZmZzZXQsDQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4g
KyNpZmRlZiBDT05GSUdfTE1CDQo+ID4gK3N0YXRpYyBpbnQgZG9fc3BpX3JlYWRfbG1iX2NoZWNr
KHVsb25nIHN0YXJ0X2FkZHIsIGxvZmZfdCBsZW4pIHsNCj4gPiArICAgICAgIHN0cnVjdCBsbWIg
bG1iOw0KPiA+ICsgICAgICAgcGh5c19zaXplX3QgbWF4X3NpemU7DQo+ID4gKyAgICAgICB1bG9u
ZyBlbmRfYWRkcjsNCj4gPiArDQo+ID4gKyAgICAgICBsbWJfaW5pdF9hbmRfcmVzZXJ2ZSgmbG1i
LCBnZC0+YmQsICh2b2lkICopZ2QtPmZkdF9ibG9iKTsNCj4gPiArICAgICAgIGxtYl9kdW1wX2Fs
bCgmbG1iKTsNCj4gPiArDQo+ID4gKyAgICAgICBtYXhfc2l6ZSA9IGxtYl9nZXRfZnJlZV9zaXpl
KCZsbWIsIHN0YXJ0X2FkZHIpOw0KPiA+ICsgICAgICAgaWYgKCFtYXhfc2l6ZSkgew0KPiA+ICsg
ICAgICAgICAgICAgICBwcmludGYoIkVSUk9SOiB0cnlpbmcgdG8gb3ZlcndyaXRlIHJlc2VydmVk
IG1lbW9yeS4uLlxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBDTURfUkVUX0ZBSUxV
UkU7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgZW5kX2FkZHIgPSBzdGFydF9h
ZGRyICsgbWF4X3NpemU7DQo+ID4gKyAgICAgICBpZiAoIWVuZF9hZGRyKQ0KPiA+ICsgICAgICAg
ICAgICAgICBlbmRfYWRkciA9IFVMT05HX01BWDsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoKHN0
YXJ0X2FkZHIgKyBsZW4pID4gZW5kX2FkZHIpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJpbnRm
KCJFUlJPUjogdHJ5aW5nIHRvIG92ZXJ3cml0ZSByZXNlcnZlZCBtZW1vcnkuLi5cbiIpOw0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gQ01EX1JFVF9GQUlMVVJFOw0KPiA+ICsgICAgICAgfQ0K
PiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiA+ICsN
Cj4gPiAgc3RhdGljIGludCBkb19zcGlfZmxhc2hfcmVhZF93cml0ZShpbnQgYXJnYywgY2hhciAq
Y29uc3QgYXJndltdKSAgew0KPiA+ICAgICAgICAgdW5zaWduZWQgbG9uZyBhZGRyOw0KPiA+IEBA
IC0zMTUsNyArMzQ1LDEzIEBAIHN0YXRpYyBpbnQgZG9fc3BpX2ZsYXNoX3JlYWRfd3JpdGUoaW50
IGFyZ2MsIGNoYXINCj4gKmNvbnN0IGFyZ3ZbXSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0g
c3BpX2ZsYXNoX3VwZGF0ZShmbGFzaCwgb2Zmc2V0LCBsZW4sIGJ1Zik7DQo+ID4gICAgICAgICB9
IGVsc2UgaWYgKHN0cm5jbXAoYXJndlswXSwgInJlYWQiLCA0KSA9PSAwIHx8DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgc3RybmNtcChhcmd2WzBdLCAid3JpdGUiLCA1KSA9PSAwKSB7DQo+
ID4gLSAgICAgICAgICAgICAgIGludCByZWFkOw0KPiA+ICsgICAgICAgICAgICAgICBpbnQgcmVh
ZCwgcmV0Ow0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19MTUINCj4gPiArICAgICAgICAgICAg
ICAgcmV0ID0gZG9fc3BpX3JlYWRfbG1iX2NoZWNrKGFkZHIsIGxlbik7DQo+ID4gKyAgICAgICAg
ICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gPiArI2VuZGlmDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgcmVhZCA9IHN0cm5jbXAoYXJn
dlswXSwgInJlYWQiLCA0KSA9PSAwOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmVhZCkNCj4g
PiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
