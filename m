Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE390CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16ED82D6C;
	Tue, 19 Aug 2025 11:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="YrmIQs2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBA680FA1; Tue, 19 Aug 2025 09:47:38 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A4C802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8UEPLcqBS6Ze+Yf2q8OcaRn2vXwJRCsfjjDm7uGHLVVGd46gWBsgtTRrzHNpSzjOaOx8RmXLLjx3CMrpA0TL671hYiQC1fUiQ2IcSXN4wZI4uoBeC3iJ1Hoi4vqwacUx0iqlhyixr/oOQbLoUcPl5iiLaLZEbu3VNyb3mD6Mp2YHqbWNCDpEwhIzb9+xBwW3bB11PL9pIWiu34Uuli8iboxLp5sfgr5BJUtb7L09Q4bd283TluOcQ8l2nptjydepoBxtX4kGgVQWy+3kqmJfaznprkE6+uJdS3fvF02fI1uIvVTL7AEAKOxZWaWtduTfx/ulaoDxGVxk7I+b7NExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD0UTiQWTmeCkDXWQDefqQ0qbp9/h2qd3eb65kodMPI=;
 b=M4iNKPXuGHHBymASlztRtaZSqvqqlXGzvvUFYg8GrM3WZOMq8uKINRkd/0/+6dveuw6PFmsONvLe31aCGmOrn/0wbjQYaJOY6/IKd6CPigdydTJf6AX8DuOhtW3hwKtYgcysaxJpcgNfXS0//NI9mEx9NDRPAvMOgG4d3mJ5Ck2OnsV6gr2eYdCDtByHtlKyUw0jSxddNdwrdtpMzftwFJIsirM1JyQiOmlz2KBB1YtdFIwSruzrW/TVfTIeN6l7p/LZihK+TPbk9BCba6HXxY2rBdiTyNIklxaVZbxvRKcIqxNS+Vs0Br5qa8gZH86cKz/fEz7i+dkBQAAGBJtJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD0UTiQWTmeCkDXWQDefqQ0qbp9/h2qd3eb65kodMPI=;
 b=YrmIQs2XLaSlqoT7xrO5l323/8HFJmTvo1qUIsqR3ZdIuWpmdWAyP9Ay0ujYip8FO0AYv1OX2BEtmy5nhYV8R6SNJQgHmkyYX84TUTKMgaFd2ENPOpdHEnl9bSBdCPD64RIktWWJGGG15OXwjtBysQPJxB5trNANszIw4gxm+Bp0/yzdpgIipGd1vc+P3BJmO1J5/X4oumZTTRuPQx67NMnKnhmaMT71LioKtMZXS6mvyEy/qrC14n0HxM1bv798HGqXK8daAkzv7Tvz+Ca76xR98AtvuSbjKheQ74h0uEYiLIpNf5eGWLn2JkMoUT3QJ6GkE4N2/6Wof1hjVp/rrg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by DB8PR09MB3692.eurprd09.prod.outlook.com (2603:10a6:10:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:47:34 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 07:47:33 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Yao Zi <ziyao@disroot.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 08/12] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Topic: [PATCH v3 08/12] riscv: p8700: Add software emulation for AMO*
 instructions
Thread-Index: AQHcAKU7iK9HHJHXb0+m511k9Hmdy7RNcauAgBxIFYA=
Date: Tue, 19 Aug 2025 07:47:33 +0000
Message-ID: <087075d3-e841-492e-beaf-5b339239a556@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
 <20250729162035.209849-9-uros.stajic@htecgroup.com> <aIxxeVl7xsQm3QnJ@pie>
In-Reply-To: <aIxxeVl7xsQm3QnJ@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|DB8PR09MB3692:EE_
x-ms-office365-filtering-correlation-id: 7cd7f398-7cbd-44dd-da4e-08dddef4a874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ckQxdGVGSXFiK3N0aWVzSWgvd0MrRFVDamRQN3dDUzJCSDgvMEtuRDhvMjk2?=
 =?utf-8?B?cU5VV3hUcHI0eUJSVzMwRWhEOVhqRXVQTG51SllNeXhZOGp6UDlmNHdFbU5M?=
 =?utf-8?B?d2JPbXdmVjdoV1NpeHl3cnNWVFZiZktpSUx5NEZjUDNGQ1N2M0JRYVhOeHlu?=
 =?utf-8?B?NGwxazZaeDBFaFNrL2hYQkVKa0FPQy8wMVFTOWtqQzlMcEp0dzBldDNJMzhR?=
 =?utf-8?B?eFhOcUJ5NTVtZ1JYQ3k1UnNYRzJRV1JwekpRUlJ6ZlZqZEU2d0hoZGVBVWQ3?=
 =?utf-8?B?Uk4yd0FoTUpmanRMZjlvVEl2ZkVKaFUxcUdkUUZ2VGZ0QW5IUGdqcUFqOE0y?=
 =?utf-8?B?WDNVWE1peGprQ1B3RmpzYjNvWFR6bFg2NUZ5M3dFeWtaMGQ3ZjFMVWlmL015?=
 =?utf-8?B?QXlrUXN4aGt6L0VVaDZNZzFRZDVZTFg5M0MrS3ZzeVhsK1VWUFR5Q1ptOGxu?=
 =?utf-8?B?SzRWcEJ3UzZMVzFlK0k1RDNsVEpZbDk1SzNBUTY4OGQ0NUlJeDZwZ21UZmdR?=
 =?utf-8?B?ZEFsWGY3YzRucW5CZkxNVjlWOUl3b0ZqYlFOTUwxWGxNZU81VjRlWkFGU2F1?=
 =?utf-8?B?K1l3dGVvSHVQQ3JXWEhuK2Nza3R2TzE1bzdCTFNGUXZnd0Fwam9XVXZ2Qm1a?=
 =?utf-8?B?UTNsV1U2VXBQZU5VMER3N2pZWFZ4MFRoUGtqWHFJcEpWTW9UTGpQSkxrUmNK?=
 =?utf-8?B?WnBrNTJ1NXhZRCs0UGlCRzdrWUNyQ1ZrQWhOVXZXUW5NY3ZYV2pPRldVTmNI?=
 =?utf-8?B?WU1VS1RNTTl2bXdjdS83UWdkOUZwOEU0RFhIRStWRGIxQ3YzbEc4RFdMR2Ur?=
 =?utf-8?B?RVo2ZjNIR2ZvV01PZDBqSEQ3THZOQXl1U0RJVHJBZkZqLzJKTGRiQ2kzRVBk?=
 =?utf-8?B?SENwYkhXbFhnVDRaMkdSWHNjYVhJM0kzYWtVWS94MGlaTXhYL2EycmtYQXc2?=
 =?utf-8?B?N21USnZPeHFLdjNIQURZNDA2T2RCMFVYR0dsS0Uxc0FOZEVJZWlFNWtIUkxy?=
 =?utf-8?B?SXJ1cWFPdGxzbFBiWlVhQ1RDMExOL09sRU5VeFFoOVhJTkx6UThBcC9NeUs1?=
 =?utf-8?B?SmJ5ZUsxQ0ZNbzM4ZExVRUhFUm1KTXJwWVBCYWRqaFpJeGVlcE8zQkFvc3VL?=
 =?utf-8?B?RVBIVm44TTZNOXVaUlF3V1dOZ1M2cU4rbThUeXQ3REhURzNTSWpSSElWS21o?=
 =?utf-8?B?RFJ2b0g1QVlQbnFOb0Q2VVJlcWtiNnliY2drWkJnM1htVHYyd2xDSm9QNVhQ?=
 =?utf-8?B?V0RaNjdDWVkwaXhnZzhLalk0TmE5cXVRTmE1YkdqMmxkbEtWeDRrOWtJeElj?=
 =?utf-8?B?MXlCTHRGZlQ4TUNCYy9mRjBTYlJEVmg3cHp6bjRtbWJPdGhObnVnSmdodk1y?=
 =?utf-8?B?eHBEbE9GcWYvVW12NjF0K3BqQ3k4bWxhR2lvdk84RzVmQllISUhyUU45ODI3?=
 =?utf-8?B?dWFjVGFqMmRzdVlEL3ZRV3NKUkV3cmpydDJpRHRYd1Z5VlRkNHVET3BLak4z?=
 =?utf-8?B?ZDNxQmNVYzcxMmhIWno0Ly93VzF0T1BlTTNFOFducURSRDFaMHY3ait2c3Vx?=
 =?utf-8?B?UEZrWmV3UTEvc25OVG1MSVZrdjgvWFNZa29VMEx5Ujh6d0ZUaUd3RFFpNnNN?=
 =?utf-8?B?T1VXcTZxTGJpTEN5VXAvSkpQREd6RmFuaERUU0JmbndDNmRlT2lycDZnRDVt?=
 =?utf-8?B?ckVJbTBJTnhLYUlFZEVEbXpaSktSZys0Z0sydmZ5ZjB5bm05STBZS3ByZHpD?=
 =?utf-8?B?dVhVZTgzSWZFUlpjTnNBSmt4N0wvVHk3SzJiejU4RHBkYnZXakFybytSemNH?=
 =?utf-8?B?Q0ErMWhHQTVna2xOOTU1bFBaekM3cGxSaHkzandnOGxsT3MvTy9lSmt3SC9s?=
 =?utf-8?B?Tm9YZncwNnNQUnZ4VXlScHptcjExNnM1RFNSZGlLMEFsNkI4bzBhQVgyUnVW?=
 =?utf-8?B?NExKbmFpNy85UlhvWVh5UmVuUzhLZG4zUmQ4anI1SGlSRzM1Y3QxckhQeFNP?=
 =?utf-8?B?OEJEZGRWQjJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVptdE4rMWlHMmJ0VDcyclhvWVpaQlRhSlRxUUgyYUM5dHpXNWl5WVE0cFpq?=
 =?utf-8?B?dnVTMWxHSXcrRkxWNTFhZER1TVZzNlJaaWZDallxZmdYcXQ0VVk0R2pWa3FB?=
 =?utf-8?B?OGxqdUJ5djFMNFhXRVZEM2haQXQ1WENQQlhjTDE2Y05WOXQ4QktFWTF5d1Z6?=
 =?utf-8?B?L0svQW5DSlRvMlVKWUJkM2NONVgzYnpPYks5TFpESUJVNVR2bk5kUHExVCtW?=
 =?utf-8?B?SVNYd2dKOWVJdlpqQWtrREovU3BwSEM1YzE1QURVS3QzMkpvWDFUVFVrZXNE?=
 =?utf-8?B?NTZMQTRLTjhEYzFQVG4xOW4wRTBkUnYvSGZUMHhxT1FRTUNhN3pqampqVUli?=
 =?utf-8?B?djc0cldKRFcwc2FycVR2cmxZVnRwWXBkNEdjVTduTjNqTEpkQm5LaHljTXF6?=
 =?utf-8?B?M0hMSzVGeGRGUGcxODZseVhOVnFlZjRoU201eDRWVktUME8vdnlvTU9pN3VK?=
 =?utf-8?B?alhORWlBL2lSV0cxazV4SjdOVE9JTTdzbXFORys2a0JJWnVxY0diMW05TDIv?=
 =?utf-8?B?Q1BaU2ZIL2tUeldlRUtaVk51TWI5RkowT2RQWUQxbkNOekI5a0RpeG9aNFc5?=
 =?utf-8?B?OGtDT2NtQWhzOXpxcGJqVnBMYllGVCtYemdoKzJUeVRlNHlKQTRPdnpCNzFP?=
 =?utf-8?B?L2hqWVpTaHBWT0RNMDBhQmRLMHVkSWlkbFlpZzQ4aEcxekZxMlY3OWxLVVpJ?=
 =?utf-8?B?cHRmSUlvZ29TMGZsMlJTWDl0dkZhR2NMVldRbUcrYzJRcTlaMmh4ajNHR1NB?=
 =?utf-8?B?dlJ1QlVaV1RpVDIvSlJ6QWtpNnhLSmFTTGplNitzSkpGWEcxSys5djNZOWsx?=
 =?utf-8?B?eHI3cDlUVDFOdWJGSWkzbEpqUk40SnJWd0lUcFNZdzM5YlROem9tcUNnNjVr?=
 =?utf-8?B?R1NyS3RiNFpsYUozdkRadVE2RFRrUWZBSGFOay9rUlc0aEJieE1JdGpsWDdm?=
 =?utf-8?B?Nk1STmcxSkN3WEErU0ExVmVIVEJkYlZOejA1Zjh4QTlyVnpUSDZuWEswcWhV?=
 =?utf-8?B?QXh1M1ZoU2lPUEJNZHdOTmQxTzlRSzBXTXdVeWpNNDAxek5JTFVveVMyQVhG?=
 =?utf-8?B?cGFrbCtoelJDVmdhNkRpL0hzc1BLREYzaUdWZVJ4eTdoaHJjcFEvSS9JSUgx?=
 =?utf-8?B?M2djOUNSK1FOcGI0NUYwanlZSUdKeG1uclpUV0RkYWV2T2VmSWQ4TUJnUEYr?=
 =?utf-8?B?ZFgzdk5jTnFQL08wM01JN2FyZ24zM2l2b2ZlcnR2MWg5Nnc5dTloMFFkWmhi?=
 =?utf-8?B?MVdNbjBoT3hUMUxmOHdHdm82MHA3aFlROGs0UGpQZVdlUXZyaG05UWRuTlI0?=
 =?utf-8?B?aWRaTElTL2hTaFRqSE0vWFdnWmw1Q1llR25LYm50RlhyM0ZrcFY4SXpwb1I4?=
 =?utf-8?B?RHhBVVJjblNENTRRbEJHQlJzVDNrb0dOeXVXdTIwUWY3NlpsNisvUCtmT2V4?=
 =?utf-8?B?R2cvQ2l2Nm1SMlpuaklqWkdhbkVrMjVNTFI3U1pldmtCc2doSnVFUzRvVVlR?=
 =?utf-8?B?WnZUd0NqaUMvWnBFeGQreUZlNEx6SDdiZlJTRHB1dExXcmtkUmU0QnBGRDg5?=
 =?utf-8?B?SGZER3dBaHVXcmNNK3RZNEoxVUc5TWlYY29LODd4REE2alNkRzdoMC82b0F0?=
 =?utf-8?B?OEV5ai9IcWdGczNFMzExNSsxUUZwVm02aUwwYXpxdkt2aTFIYSs0UDl6aS9M?=
 =?utf-8?B?RUdDUVlGdWwrcE52SmZyUGJsbyt2NTRvWGJUeDE3UFJuQy9GZm1XQVBENjNr?=
 =?utf-8?B?SDhVUzJjNEVSU2ZUZDRRN1pRMGI4TVlLT2Y3a1k4eEpnWVFtckJqYVlZSTVz?=
 =?utf-8?B?RXQ1dFRFMEV5UW9OeVlEekN4TmZIMTdmbGVZdHpKNVU2WExNRVo5TTJyQ0xS?=
 =?utf-8?B?dlk0UGlaUG5IOHp1L0JuQmVZZnN3ay8yVEt3MmdVRko3aXRZV2szQ29rVWFD?=
 =?utf-8?B?bkMxWCtVY2ZhbGgwWHlOWXdWTlBIL2JXQlcyRDh2RHBJcXJDK1lRdGhKNGFG?=
 =?utf-8?B?MWtVaXQ2WWdoZUwvTUpET2dVS3BRZzZsNzc1czNmL2p5NVd2S1p0NWt5ajNR?=
 =?utf-8?B?YytuRHFaeFdNblFxdlZqMkQ0ZXU0ZjA0eSs5RkswUWdqNVVaRG5rVEd0UHdq?=
 =?utf-8?B?aW90QjRuTTZFNktpSG9kaHcwV3pNQ3RKU0xiSjhUeVByVm1IWEtvaDZVa3or?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C99CEEEDE85B6E4885FC782E0ED3E0F4@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd7f398-7cbd-44dd-da4e-08dddef4a874
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 07:47:33.5467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qz+kF9basxNRcQYujxU6EUw72DoOu0pRpzWXEJo2ZJbTci/HSlgZllBOHeq9OggyRZox5wU6bz4EyYO7FatbqnqDcB/GW0vZoQ9KkA/Sayo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3692
X-Mailman-Approved-At: Tue, 19 Aug 2025 11:52:11 +0200
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

DQoNCk9uIDEuIDguIDI1LiAwOTo1NCwgWWFvIFppIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hv
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB6aXlhb0Bk
aXNyb290Lm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBz
ZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiBUdWUsIEp1
bCAyOSwgMjAyNSBhdCAwNDoyNDoxN1BNICswMDAwLCBVcm9zIFN0YWppYyB3cm90ZToNCj4+IEZy
b206IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4NCj4+IFRoaXMgcGF0Y2ggYWRkcyBz
b2Z0d2FyZSBlbXVsYXRpb24gZm9yIGF0b21pYyBtZW1vcnkgb3BlcmF0aW9ucyAoQU1PKQ0KPj4g
aW5zdHJ1Y3Rpb25zIHRoYXQgbWF5IG5vdCBiZSBzdXBwb3J0ZWQgaW4gaGFyZHdhcmUuDQo+Pg0K
Pj4gVGhlIGBlbXUtYW1vLnNgIGZpbGUgcHJvdmlkZXMgYXNzZW1ibHkgaW1wbGVtZW50YXRpb25z
IG9mIHRoZQ0KPj4gYWZvcmVtZW50aW9uZWQgb3BlcmF0aW9ucy4gQ29ycmVzcG9uZGluZyBoYW5k
bGVyIGxvZ2ljIGlzIGludGVncmF0ZWQNCj4+IGludG8gdGhlIGlsbGVnYWwgaW5zdHJ1Y3Rpb24g
dHJhcCB0byBjYXRjaCBhbmQgZW11bGF0ZSB1bnN1cHBvcnRlZA0KPj4gQU1PKiBpbnN0cnVjdGlv
bnMgYXQgcnVudGltZS4NCj4gDQo+IFRoZSBtYWluIGJvZHkgb2YgVS1Cb290IGlzIGV4ZWN1dGVk
IGJ5IG9ubHkgb25lIENQVSwgc28gSSBkb24ndCB0aGluaw0KPiB0aGVyZSdyZSBjaGFuY2VzIGZv
ciBhdG9taWMgaW5zdHJ1Y3Rpb25zOyBkaXNhc3NlbWJseSBvZiBhIFUtQm9vdCBiaW5hcnkNCj4g
YnVpbHQgd2l0aCBxZW11LXJpc2N2NjRfc21vZGVfZGVmY29uZmlnIGNvbmZpcm1zIHRoZSBpZGVh
OiB0aGUgb25seSBmb3VyDQo+IGFtbyBpbnN0cnVjdGlvbnMgbG9jYXRlIGluIGFyY2gvcmlzY3Yv
Y3B1L3N0YXJ0LlMgZm9yIHBpY2tpbmcgdGhlIEhBUlQNCj4gdG8gcnVuIFUtQm9vdC4NCj4gDQo+
IEkgc3VnZ2VzdCBpbXBsZW1lbnRpbmcgYSBMUi9TQy1iYXNlZCBjb2RlcGF0aCBmb3IgSEFSVCBs
b3R0ZXJ5IGxvZ2ljIGluDQo+IHN0YXJ0LlMsIGFuZCBpbnRyb2R1Y2luZyBhIG5ldyBLY29uZmln
IGVudHJ5IChtYXliZSBDT05GSUdfSVNBX1pBTU1PKSB0bw0KPiByZXByZXNlbnQgdGhlIGF2YWls
YWJpbGl0eSBvZiBaYW1tbyBleHRlbnNpb24uIFdlIGNvdWxkIHVzZSB0aGUNCj4gYWx0ZXJuYXRp
dmUgcGF0aCBmb3IgUklTQy1WIHBsYXRmb3JtcyB0aGF0IGRvbid0IGltcGxlbWVudCBaYW1tbyBh
bmQNCj4gZGlzYWJsZSBDT05GSUdfSVNBX1pBQU1PLCB3aGljaCBzYXZlcyBhIGxvdCBvZiBsaW5l
cyBhbmQgbWFrZSB0aGUgY29kZQ0KPiBjbGVhbmVyLg0KPiANCj4gUmVnYXJkcywNCj4gWWFvIFpp
DQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBVcm9zIFN0YWppYyA8dXJvcy5zdGFqaWNAaHRlY2dyb3VwLmNvbT4NCj4+
IC0tLQ0KPj4gICBhcmNoL3Jpc2N2L2NwdS9wODcwMC9NYWtlZmlsZSAgfCAgIDEgKw0KPj4gICBh
cmNoL3Jpc2N2L2NwdS9wODcwMC9lbXUtYW1vLlMgfCAyNTQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4gICBhcmNoL3Jpc2N2L2xpYi9pbnRlcnJ1cHRzLmMgICAgfCAyOTkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGluY2x1ZGUvaW50ZXJydXB0LmggICAg
ICAgICAgICB8ICAxOSArKysNCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCA1NzMgaW5zZXJ0aW9ucygr
KQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9jcHUvcDg3MDAvZW11LWFtby5T
DQoNClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9ucyEgV2UgZGVjaWRlZCB0byBwYXJrIHRo
aXMgcGF0Y2ggZm9yIG5vdywNCnNpbmNlIHdlIG5vIGxvbmdlciBoYXZlIEFNTyBpbnN0cnVjdGlv
bnMgaW4gb3VyIE9wZW5TQkkuIFdlIG1heQ0KY29uc2lkZXIgdXBzdHJlYW1pbmcgdGhpcyBsYXRl
ci4NCg0KUmVnYXJkcywNClVyb3M=
