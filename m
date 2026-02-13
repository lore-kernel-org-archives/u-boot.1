Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2A2EEA853
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 01:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3958D83015;
	Fri, 13 Feb 2026 02:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="Uc4GMgY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5886983936; Fri, 13 Feb 2026 02:10:24 +0100 (CET)
Received: from ps81.spcmail.jp (ps81.spcmail.jp [52.192.49.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C182C82BF2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 02:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from ip-10-10-30-85.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by ncs82.cs.local (8.18.1/8.17.2) with SMTP id 61D1AIo12464143;
 Fri, 13 Feb 2026 10:10:18 +0900
Received: from ip-10-10-30-82.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by nmg82.cs.local (Postfix) with SMTP id 4fBvGy0VGzzMpsjB;
 Fri, 13 Feb 2026 10:10:18 +0900 (JST)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
 by npr82.cs.local (Postfix) with ESMTPS id 4fBvGl0DXGz3kFhL;
 Fri, 13 Feb 2026 10:10:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgSq6+2x5iBD2EOsQ3m323+W2q92+QgfD1BjlsLWC0mInaY5wbiOaswFmC5rwP1mcnyUvBHrsYZZrj3+DmnnKWV+InbI/U/hI0MlOXEEOc4qW43MCnm17fugjveohS54TEnW4G1YBftW9TuYTweyMjPNIBi2Ouh2azi9b0thgFs1K+4E4xprfZL4wpffOA6mDY+uxCJFXDBEXCtB8wSpBj7G99FL9aydMEL1SJcCAbpuHS2/4nDQBsF4t7JoUcTZSLyK+Sb/SnfBSyrAkT1PsOajk0G5lgAUXXr+Ea7jR2fpLSetP905rLtvDZMNrF4yvXFuOPo4u2dqhxWnxZ+DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gr7X/ZCSBiLehotAkLRgCFPoj+i9ou9Bd0oBTP6mZI=;
 b=T4FtnoeRXxL2fq3aW9wQxgZW4xpsazkvYnS866mlw4oxHZu9DUjzeTFAKWi+LLsoRLywi2O0broAUPDmEU35GXeYTE8bhrzdCyNeKVQo0bpmSDUO8HpUdYq6aaDFaULingJbLJsnp/jLl8Cq+6UcXbsjjR7mLwnTOTPEwQoqnGR+IyNBFM6hXFKqjf9iVH+Ghl+ixCBDlRablKMZ3FHbnwG5r98MeL2VioqaUOJBZK9UovbSwSrQ8y3G2HCAPrZt16a0kNXhz41x+NOIKW5+VN/UkczLCNA4pGIgki2VjEUjluCYdW11KnaUNjKJuObYrn4ZQ9BhN0nJql33FPIvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gr7X/ZCSBiLehotAkLRgCFPoj+i9ou9Bd0oBTP6mZI=;
 b=Uc4GMgY1/UYhClkVBrE5CN8ZxNjbYjuOSwTdurLCN5NdEgFWfdkIf12VoWPjG3Gh5BzCNp7rvu00C5lpuHG5Zl3LcYMai2HS6RoM0984KxZjKbMf3pPHiTUZyc4tlkwTuPRLxl2KzRV99IOGa94Pd98vgBvYR/ylowXwe+UnpxQ=
Received: from TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ca::13)
 by TY4P286MB6151.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 01:10:05 +0000
Received: from TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1a2a:2bdc:a0d5:99d2]) by TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1a2a:2bdc:a0d5:99d2%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 01:10:04 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH] efi_loader: add missing EFI_CALL around tcg2 read_blocks
 calls
Thread-Topic: [PATCH] efi_loader: add missing EFI_CALL around tcg2 read_blocks
 calls
Thread-Index: AQHcm1QC+LKGYFRYjkeIVxYPTRQfBbV/0tCg
Date: Fri, 13 Feb 2026 01:10:04 +0000
Message-ID: <TYYP286MB09244F4FEA58EB2C31A1D61BE361A@TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM>
References: <20260211124314.3406952-1-vincent.stehle@arm.com>
In-Reply-To: <20260211124314.3406952-1-vincent.stehle@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYP286MB0924:EE_|TY4P286MB6151:EE_
x-ms-office365-filtering-correlation-id: 70dfe471-7baa-40e8-bc07-08de6a9c9f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?WlRSQzlIRUovMDc1Z0ZkQnZUYVlpUjNXaFlkcGlZYWZPZkQzeUZ3b2xaY3Fl?=
 =?utf-8?B?a2pyR2QwZE4vV05xZVlEbytya08xUWEzSmNsQnEyYkp6SUVwMkpMVjlZekpx?=
 =?utf-8?B?c3NHMVp0djZ2UGdYTzVLR3ZNMS96bmFxZGh0a1c2Q3NLcmF2QldRT0xLNW1C?=
 =?utf-8?B?WldVWHJ3TTJWSFRsRnVNaXk3aXVaYndVeUZzek91K0RCeDlpdjhzZnlTWFJK?=
 =?utf-8?B?cE5xWmo4NFhDQ0ZHWjhod0NqSGV6Wkc2bVhNMEZheEtrbjZuQmpUZmd1TURa?=
 =?utf-8?B?WXNXRjdBWStvc2FpdmRvZUVQQlg3MmRYSThDNTBnQ05HaUxFdXRtbTVCUWgy?=
 =?utf-8?B?QkZMcGZZQWI0N0xrUlZQS3M1MStFV1ZEeHlNTEticU95R0o5cEoxU2pGSkhT?=
 =?utf-8?B?a1RGK2lyTzZSQ0dFS3kybWdSa1ZQT2x1cVBQajBVNXluUXZCcmd3TU1vN2xN?=
 =?utf-8?B?K3gzNWRnU0U2Y3ozV1R1UWNqQjJIVzF6RDR1N0FVMktUa2kvUUFoYWUraVov?=
 =?utf-8?B?c1hwOUdCTloyMGVTOEdXTGZjYWtzaVZNbndYakJ6c2o2WEdhWVY0K2dHU3V4?=
 =?utf-8?B?SUtleDJ2Ykg5dmhCcjF6WVhEV0I3SmR3UUR6UEM0SjFCQkozOTZ6eVlDVFhN?=
 =?utf-8?B?T0FNeWwyT2JuS1hUMUtSZWJPazlUM2JlbnUwaE52d1ltbGluTit2NUhiQ2wv?=
 =?utf-8?B?V2Y2SnYrSmVML0UxODV1RFVGMEFJQzh1ZzBFUFBVMUtvclhGQnc1eFpSWHZP?=
 =?utf-8?B?RTVpYUV2WTFZb0prWkNqZEdlMVFkNkJ1OUFmd1ZOenlkV01YdXVLcVF5ZitN?=
 =?utf-8?B?YW1sSFlnVjBMOGpReEdVZFR3Z2NSZDI4OU9pYnJnUU0wNzlhclJEQUUyWWdY?=
 =?utf-8?B?RFBRSFJqalBneVZTaEJTOVMrODlqMUJlQ3dpcVhWZnNGTll4Ylhxc3Bjdmwr?=
 =?utf-8?B?WnFOVWF6c3BHTGNoZUw2d0tQNWx0L3hvYmlnZE5zUXcwclR5OTVKMVE0RVFC?=
 =?utf-8?B?ZTJzZ2twdkNmSStEN29pTlU5dTB2TVF4d01DVDk0ajM2WFcvNlkrbWcrK0FT?=
 =?utf-8?B?WVAzOHZNeEhuOTBTSVMrUnJDNUpEblNyemVFZTVGMk1oYjgvcUdySVM0OHFS?=
 =?utf-8?B?TzR2UklUK2Vtd0d6RnVrNFl1Ym1iTGk5cTFYaFRPRGZySENtUWE3SDcvNVpy?=
 =?utf-8?B?dTdXdkw1SkNDUjNIYWdBZGlVZHExWlVZcy9SeUJtNndBQnRWT204alpCVkVw?=
 =?utf-8?B?aEExTmE2bkhweGtMYk1HWWcrSnpYUWZPNzNPVFdPa1pJdE93VVVWSnpaaHFh?=
 =?utf-8?B?eTFnY1AycEFsSlVUYlJwQ1p4NDViNDUwR2tCcGVOSlpwTWp5SnFFV1NGbVg3?=
 =?utf-8?B?VFhMdDc3VzJKdUtQdEVqUWxKS3o2Uy9mZ1FyZHRVbWxEMmsySzdRbWJGRG1Y?=
 =?utf-8?B?Vkt6K1MyUlRsR1Y0bkMvQit5Sk4rZ21pVHNaWTE4SXh1Y0l1MkRtMHhTbCs1?=
 =?utf-8?B?T09TSWZndWR0NUQ0anhGaDlEMTRKTEtKVzZwMXNVVjFiaGN4OHFyM0IwMzJT?=
 =?utf-8?B?RW52aXhaaWtNbUU1cEtFTDBSZXFZNGg5U2lvWDMwVGNZaW1DN3hUYWNWWXNa?=
 =?utf-8?B?dVYraDhibDVXVHFUSVVOR2x5WEJ1UFpqbFNGOTRia1p2S0JzaXlhdnp6VkYx?=
 =?utf-8?B?WWhzTTBHcDRMM1IzMTlGcjczaVBGY0V6Mk0vRnY3QkhtRzBXVi9ENE40YTkw?=
 =?utf-8?B?MkVVMm1ZY2t5M01Rbk9pQ2xwcFNGT2Jpd2JuZkphd0ttNTRrOE5jZXN4U1hV?=
 =?utf-8?B?VXNhbDlxcUZoZzNaN3pQZENlWmVUYzZlZFVPVDJZVG0vWHNZb21qbXF2TllH?=
 =?utf-8?B?dk42Y0Z3TGVEa1ZrYXdCWEppZWJjdEMzSGtHOHB5UkNYQ1lVNEVibFRMenVt?=
 =?utf-8?B?cHYrLytMaG40U2tYUmVlenZRdk8yNVM4N01weE1VUTBsUUt5RTBPZmowbkZa?=
 =?utf-8?B?U2VJYkdRODlNYXdmTkx3SDdqd2s2YmgyRVRYd2dOV1pxTCsxdVBEbmVZOGxD?=
 =?utf-8?B?bUgxdmNnWU9PNU9YcGJnV2RLOWpuOWx3UU9lRkV1bVM1VHJOSnJYc0RaZVJm?=
 =?utf-8?B?NWlDcDZxd3lFc2JhbzZ3NWFLdUdrZEhzYUxSSmhBQjgwaU1CWkZEUWR6RSsr?=
 =?utf-8?B?MUlNUnBNME56Z3lhTmJwY2dUNHhlREJMV1BQQ1E3M05EM2d6eE9JTkpTM2pt?=
 =?utf-8?B?STJPelFiNTBhczFROTdJdFFYRHBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUtTZ29SdUYwOUROczFCMlhRVjAvYnN1K21Jc0xjVHQ1Y3d1dEV3ZEFycDdG?=
 =?utf-8?B?aEVPUHV2dnJ6U21MT2VPZ3JPREp1dzNKeVpZWWYrOGwvZmpKVzJHNWxPMzVp?=
 =?utf-8?B?NXh0UGtLVmpzSTJVYnVQZUhiOUtocC9NSTRWY2dCcVVaQVBwZGlEOGczWmlu?=
 =?utf-8?B?bHNMN2lIV2ExT2IrbnZxUFFMOVFUVmI5TjZ5OGJWcVRLdTBVanlwVWJUWWFK?=
 =?utf-8?B?YXFaRjdTWW5mVCtjWlk5Y1VXN0JyeXBTQmdMMFp3aE50Y1R4VmxVeFJEWERx?=
 =?utf-8?B?enNzeXMxYmltWlBzQkV4ZlBkT0VmYkV4RkpZMWhjQmI2b3Awb1lhQUJhYW1F?=
 =?utf-8?B?NHpWVTRUUWlLV09zZHYxWjVXQkRqb1hYaEYyOEttc25TL2hScWFsb0p5NDlr?=
 =?utf-8?B?cHc3RDUzRy9TcUpEMk0yc2RHdG1IMElJeTEyVUpIbU1RNEM5Mzc3Qk5nY0Y5?=
 =?utf-8?B?Mit2VWhrSm1IRklrRWk3bCszcm50QklwNkJ0ZmR0dmxZbXE0QTdRTVg2eXBj?=
 =?utf-8?B?bVQ2eE9ob25wSkFBaXh2eHhDSEJLNXllRjdrRkcwa3AxaHZQbyszZ3JHSVRT?=
 =?utf-8?B?cERkR2V4MTVJVlpBTWRCL3IybXNhcTlCZVpUZkM0cjl5cFRyNjFvNzNoaEdr?=
 =?utf-8?B?ODF5ZEs4T1RlQzJkWWpIN08zc3hZempGQVBSOUJYN3J3WDNqcEdWY2QyVk8w?=
 =?utf-8?B?amY3TWFpU0ZUcVRvakZhbmt0TnhmREp0K1VoZWl4TG5wV3hGY042MThpanB4?=
 =?utf-8?B?UmVSYzc2VnUwTW8xMmExVktzS3VtWFU4dU00aERRdWNsNitnaFdGeS8wOTY3?=
 =?utf-8?B?N1JydnhsRVhBN0JDU3RLRkw3Z2ZEZVdJWjNPT1ArRGo3SVdodWJUcUExbzBv?=
 =?utf-8?B?bFNKcnlBYWlNSzhsVUdaS0xmeGJ5ZnFKUHZKL3FpK0ZKeUJWaVMvZldBb2dF?=
 =?utf-8?B?Q0t6MlpveFBWY1ZxZEIyallpaVR6NmhzZW0yVDAyTHNxeEJYMW9NVkk3S3Fw?=
 =?utf-8?B?NFJhV09MajlTZ2Z6cHBlTCtNTytWUUR4SGtaRW9vbEVsS21Nb0J4ajJkZUxO?=
 =?utf-8?B?T0dwZ3dkdU5tM2hEcE9YQ3ZsZWJzUk1KRkg5VU1mK0FocmxKbkFlcTJyMUlO?=
 =?utf-8?B?VU9Galg0UVJTckI3QWZaQy9pb2Zvc0Y3T1RFRGw4QVZMOWJCaEMzVjZodzJx?=
 =?utf-8?B?eVFzb2F2SzlnaXpodTZZeGhMUzlvTWcyRzFyY2U2a0o2d2lXSHpOazcxZi9U?=
 =?utf-8?B?UldMaFlVaCt4MmZHVFRUV1AvSTg3cnpVREJwYjhqQzVJQlBsVlJ1R3MvUTNG?=
 =?utf-8?B?QjlublV0WHVLWUpqUnM2RG9ZQkpGY1gwQlhSTmo1UTJIWm5IOGlTVnNSWVdL?=
 =?utf-8?B?WjdKbEt6aEQ5S0xjaDdTNlpUbVFkU3BpcU1SQ2l2TEFzc0VJeU9rbW5ZQm1Q?=
 =?utf-8?B?ZXpUbFZCeGNtT3BsY2dCV0dzdWRMQkEyU05JVWwrekZwMDd0Rkl6L3Z4dmt3?=
 =?utf-8?B?SHVFbkw0NkpBUGs4cllKc0g2YkhUNkk4SStxNExGcjhQR0h0UjFkT243YlV3?=
 =?utf-8?B?SU92M0pnNGlmL0hzQ0xSM2JPZVVUMENLcUtTeFBia0tSeVE1RTQ1ZG15TDIx?=
 =?utf-8?B?SU5KQXlFWWMwTHVuNkhlUzg5UzVSRnJ5aHRqeENYYU9IYmt0WktMTWR3d1do?=
 =?utf-8?B?TXljSE9qR1VUcDZXMC9jcTZVUFgrWXhPbWdpSVNEeGE3VjZmK0hjMmtDSzhz?=
 =?utf-8?B?YTBzaHNqc1lQQ2J0WGZDREx2Z1kyMFlkaytrSFJnTUE2S2tBQlJxeS9JcFdn?=
 =?utf-8?B?T1BCWXczOFhIclRTNFNZeG96eHk3aSsxcW5XMDBSZkEweHR1RHVQZDRXQjBS?=
 =?utf-8?B?a081U3JSWTNnd09odjhGN0JINk1aNWZKZE56dzh2Zy8xSmU3bVIwTVg5UUVn?=
 =?utf-8?B?L1hnMm1FY2pSdU11L3kvZDd5NEJwK1M0dWkzSjgwaENqdFFnR2d3dFBMeFVO?=
 =?utf-8?B?QU5SUkhRRjlWZmdLVEJVMzZ3Mk14ai9qaUdRMnV5TThjajVDS3dRU1JTQmN2?=
 =?utf-8?B?cjFZeDNsTnBaN3plQ0lRTWpvcEowL2YwRUh5elYvU2x1Ui82L1ZzNnV5Y1dr?=
 =?utf-8?B?N0ZxSnFUd2pFalN4eUxKTjRGUkF2T2pLRlRmM0NZWjAzYzVFT3Vka1RlTTNQ?=
 =?utf-8?B?WTNYWm1ERmJNQVdlRzdoT1JNejZxVmVzblpTSXc4K0tsWHpETW9scnBnU2Z6?=
 =?utf-8?B?OUFSaldUMkVnRkE4aWN1Mm1mZ2xRZy8rNVhSdHAvZll5WEhuR09NTENWclVm?=
 =?utf-8?B?MVNJTktlQTdhSlZUc1J1b1pBYmlkYmdaNHEwSWpmOStpS3ErbWFUWDZ1L0lE?=
 =?utf-8?Q?+fWp+fV9SYUGCab4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3kNshTT2WBflSJQVcDkHf/XKLbjfhMnouU3Xs/Acdq559pGKgwZHDiMbnu6YwL2O2v5KTP0YL3sdTvcIzrgq4W4tM+wDJPUY3Vn0NWEh1g6zBousuc6gswe5uT94/BzVOC3bQc/6uRGrjfhHahXP3p1N7sncC2hyi8jlfZxUYvcTJdp+P4Vg/cbXZz+tZpeDAup5hQAwD2I22qWd5JccgB//KbtV//w1z3Kk0Q5SU5flVIhWFeMBvpVBZRsXWGQU4FhsgkgW7yr/2f6CFAHqAUgmyN9xw/O61uJ2cFGTmKBB/j+ug4mG8E3535Tb9ygIA5X/2w5Y3HrrNZsZSPoji7jchrp0QLT6ZNQzqB5Mx9D48W2TPupPjcO1+7xcOdAGEOAu0L8Wjg3Lki9bXtYKv17M2zPiaxbDMYmYuqqqON2lXBkCQ0JkTvrU3VsVqzxpdokWZYguUVA7vBtlK0/Yhg/4WtAV5x1/HdNqS2n+DaCeGAIW/f7tfg1031FjyCPitWN+1azlZINLcS3tJwxhcmr2CnL5msIcH02O0cTPr8ri5MrgdzRUHtgCOmCRGvawvfiSyU06sJv8XlXef4qtaKJ6SGcsBo400ayLd3gfo8nSxpqmImFUIGBulPpNUSSi8SF1DuPMlOUKzKrgcg+EkUY+oi5Dij5Ahm/L61GnNShuCP89uYqm+DOol4iZ/hG6NJ82RILw6SyBeZrMiUtJ74XFKmdO/3ABN38jUqvF6JByV85euVcsOCdAcdnvhh8M
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dfe471-7baa-40e8-bc07-08de6a9c9f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 01:10:04.9202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+Ei21cu5VbHy7DyNyYkYFoANhBar2kWukxru7Hox7F5X1k3hHSnZSLQjYGd5hp3Cyr7YdVVH9prKmIEmoyz584a2BaI1/VGOBahf9+5u2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6151
X-CC-Mail-RelayStamp: CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To: <vincent.stehle@arm.com>, <u-boot@lists.denx.de>
Cc: <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>, <trini@konsulko.com>
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

SGkgVmluY2VudCwNCg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGVmaV9sb2FkZXI6IGFkZCBtaXNzaW5n
IEVGSV9DQUxMIGFyb3VuZCB0Y2cyIHJlYWRfYmxvY2tzDQo+IGNhbGxzDQo+IA0KPiBUaGUgcmVh
ZF9ibG9ja3MoKSBmdW5jdGlvbiBmcm9tIHRoZSBCbG9jayBJTyBwcm90b2NvbCBpcyBhIFVFRkkg
ZnVuY3Rpb247DQo+IG1ha2Ugc3VyZSB0byBjYWxsIGl0IGZyb20gd2l0aGluIFUtQm9vdCB1c2lu
ZyB0aGUgRUZJX0NBTEwoKSBtYWNyby4NCj4gDQo+IFRvIGRlbW9uc3RyYXRlIHRoZSBpc3N1ZSBv
biBhbiBBQXJjaDY0IG1hY2hpbmUsIGRlZmluZSB0aGUgREVCVUcgbWFjcm8gaW4NCj4gaW5jbHVk
ZS9lZmlfbG9hZGVyLmggYW5kIGJ1aWxkIHUtYm9vdCB3aXRoIHNhbmRib3hfZGVmY29uZmlnLCB0
aGVuIGRvd25sb2FkDQo+IGFuZCB1bmNvbXByZXNzIHRoZSBBQ1MtRFQgaW1hZ2UgWzFdLCBhbmQg
ZmluYWxseSBleGVjdXRlIHRoZSBmb2xsb3dpbmcNCj4gY29tbWFuZDoNCj4gDQo+ICAgJCAuL3Ut
Ym9vdCAtVCAtYyAiIFwNCj4gICAgICAgaG9zdCBiaW5kIDAgc3lzdGVtcmVhZHktZHRfYWNzX2xp
dmVfaW1hZ2Uud2ljOyBcDQo+ICAgICAgIHNldGVudiBsb2FkYWRkciAweDEwMDAwOyBcDQo+ICAg
ICAgIGxvYWQgaG9zdCAwIFwke2xvYWRhZGRyfSBFRkkvQk9PVC9TaGVsbC5lZmk7IFwNCj4gICAg
ICAgYm9vdGVmaSBcJHtsb2FkYWRkcn0gXCR7ZmR0Y29udHJvbGFkZHJ9Ig0KPiANCj4gVGhlIGZv
bGxvd2luZyBhc3NlcnRpb24gc2hvdWxkIGZhaWw6DQo+IA0KPiAgIGxpYi9lZmlfbG9hZGVyL2Vm
aV9uZXQuYzo4NTg6IGVmaV9uZXR3b3JrX3RpbWVyX25vdGlmeTogQXNzZXJ0aW9uDQo+IGBfX2Vm
aV9lbnRyeV9jaGVjaygpJyBmYWlsZWQuDQo+IA0KPiBUaGlzIGhhcHBlbnMgZHVlIHRvIHRoZSBm
b2xsb3dpbmcgRUZJQVBJIGZ1bmN0aW9ucyBjYWxsIGNoYWluOg0KPiANCj4gICBlZmlfc3RhcnRf
aW1hZ2UoKQ0KPiAgICAgZWZpX2Rpc2tfcmVhZF9ibG9ja3MoKQ0KPiAgICAgICAoZHVlIHRvIHRo
ZSBtaXNzaW5nIEVGSV9DQUxMLCBlbnRyeV9jb3VudCA9PSAyKQ0KPiAgICAgICBlZmlfbmV0d29y
a190aW1lcl9ub3RpZnkoKQ0KPiANCj4gTGluazoNCj4gaHR0cHM6Ly9naXRodWIuY29tL0FSTS1z
b2Z0d2FyZS9hcm0tc3lzdGVtcmVhZHkvcmVsZWFzZXMvZG93bmxvYWQvdjI1DQo+IC4xMl9EVF8z
LjEuMS9zeXN0ZW1yZWFkeS1kdF9hY3NfbGl2ZV9pbWFnZS53aWMueHogWzFdDQo+IEZpeGVzOiBj
ZTNkYmM1ZDA4MGQgKCJlZmlfbG9hZGVyOiBhZGQgVUVGSSBHUFQgbWVhc3VyZW1lbnQiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBWaW5jZW50IFN0ZWhsw6kgPHZpbmNlbnQuc3RlaGxlQGFybS5jb20+DQo+
IENjOiBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXguZGU+DQo+IENjOiBJbGlh
cyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+DQo+IENjOiBUb20gUmlu
aSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBDYzogTWFzYWhpc2EgS29qaW1hIDxrb2ppbWEubWFz
YWhpc2FAc29jaW9uZXh0LmNvbT4NCj4gLS0tDQo+ICBsaWIvZWZpX2xvYWRlci9lZmlfdGNnMi5j
IHwgMTMgKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvZWZpX2xvYWRlci9lZmlfdGNn
Mi5jIGIvbGliL2VmaV9sb2FkZXIvZWZpX3RjZzIuYw0KPiBpbmRleCBiZGY3ODg5N2Q0Ny4uMTg2
MGRjNTAyMzggMTAwNjQ0DQo+IC0tLSBhL2xpYi9lZmlfbG9hZGVyL2VmaV90Y2cyLmMNCj4gKysr
IGIvbGliL2VmaV9sb2FkZXIvZWZpX3RjZzIuYw0KPiBAQCAtMTIxMyw4ICsxMjEzLDEwIEBAIHRj
ZzJfbWVhc3VyZV9ncHRfZGF0YShzdHJ1Y3QgdWRldmljZSAqZGV2LA0KPiAgCQlnb3RvIG91dDI7
DQo+ICAJfQ0KPiANCj4gLQlyZXQgPSBibG9ja19pby0+cmVhZF9ibG9ja3MoYmxvY2tfaW8sIGJs
b2NrX2lvLT5tZWRpYS0+bWVkaWFfaWQsDQo+IDEsDQo+IC0JCQkJICAgIGJsb2NrX2lvLT5tZWRp
YS0+YmxvY2tfc2l6ZSwgZ3B0X2gpOw0KPiArCXJldCA9IEVGSV9DQUxMKGJsb2NrX2lvLT5yZWFk
X2Jsb2NrcyhibG9ja19pbywNCj4gKwkJCQkJICAgICBibG9ja19pby0+bWVkaWEtPm1lZGlhX2lk
LA0KPiAxLA0KPiArCQkJCQkgICAgIGJsb2NrX2lvLT5tZWRpYS0+YmxvY2tfc2l6ZSwNCj4gKwkJ
CQkJICAgICBncHRfaCkpOw0KPiAgCWlmIChyZXQgIT0gRUZJX1NVQ0NFU1MpDQo+ICAJCWdvdG8g
b3V0MjsNCj4gDQo+IEBAIC0xMjI3LDkgKzEyMjksMTAgQEAgdGNnMl9tZWFzdXJlX2dwdF9kYXRh
KHN0cnVjdCB1ZGV2aWNlICpkZXYsDQo+ICAJCWdvdG8gb3V0MjsNCj4gIAl9DQo+IA0KPiAtCXJl
dCA9IGJsb2NrX2lvLT5yZWFkX2Jsb2NrcyhibG9ja19pbywgYmxvY2tfaW8tPm1lZGlhLT5tZWRp
YV9pZCwNCj4gLQkJCQkgICAgZ3B0X2gtPnBhcnRpdGlvbl9lbnRyeV9sYmEsDQo+IC0JCQkJICAg
IHRvdGFsX2dwdF9lbnRyeV9zaXplLCBlbnRyeSk7DQo+ICsJcmV0ID0gRUZJX0NBTEwoYmxvY2tf
aW8tPnJlYWRfYmxvY2tzKGJsb2NrX2lvLA0KPiArCQkJCQkgICAgIGJsb2NrX2lvLT5tZWRpYS0+
bWVkaWFfaWQsDQo+ICsJCQkJCSAgICAgZ3B0X2gtPnBhcnRpdGlvbl9lbnRyeV9sYmEsDQo+ICsJ
CQkJCSAgICAgdG90YWxfZ3B0X2VudHJ5X3NpemUsIGVudHJ5KSk7DQoNClRoYW5rIHlvdSBhZ2Fp
biBmb3IgdGhlIGZpeC4NCkFja2VkLWJ5OiBNYXNhaGlzYSBLb2ppbWEgPGtvamltYS5tYXNhaGlz
YUBzb2Npb25leHQuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpNYXNhaGlzYSBLb2ppbWENCg0KPiAg
CWlmIChyZXQgIT0gRUZJX1NVQ0NFU1MpDQo+ICAJCWdvdG8gb3V0MjsNCj4gDQo+IC0tDQo+IDIu
NTEuMA0KDQo=



