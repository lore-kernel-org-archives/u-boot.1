Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6622CCA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E4182E37;
	Tue, 19 Aug 2025 11:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="dEXG6MGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C50981FEE; Tue, 19 Aug 2025 09:55:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED1F802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpijLwCfoLIQbDUwossIKIi1ejFWM0pjpHm4CXJ8F33ULELTVyYeWZUo03l72MhvIto6wnyOfQCrsgXw1HK3EXSrXjmvZ/i4N93o7FZfGkuickGNKFUyMrIU850kPTsEErqVyL7v7tRKiZOqbx3s3JiJazq+GeGIuf8TVFTmEUqTW54zd/IvAPHWPvf0BxkkwOCIff3QDhAv6hQO6SeI6J+QMcKMWh/FyJRfwj/mo6/2ky4/84bWWEryYK5QsLweswPthO2wYdSQf1G5fLVZ5Bc5eCYYRDD2cAN6BTA6gKy+KeumKK4PMzeGS7mLkU0Wtx2TOdciA/YEK1Ts8cmIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR8jEQYFAUFTVVRdxuliWbJR+fjKI1kogAYjzP/DzyE=;
 b=WUpoAxnDiecLBZn4KRsjX1u11LNsqStzUqLciu1vIJqpHDP6wwZAN8hJr0ve+HRjZ7IEQOQYtEkMUJcw7T+oH50dDCM/bk/SzZxel24eg9gr7kAy2y9Q5GDi7Ccnv64CsUdpPTHPouTt0XGPJ2PfQnyRTtDZI0ao0HcbjKZdJvhseSEf99QWnqOgp84wwE8qeGbg9bWb4Wd7aDEnxB8mejJq8h47n/62xZw5751qTF1vO5cmi2gSaguwpWRw4+ncdoK3QqJdMfuZzGBgm1rbUD7dSIv2YO8skWQyklOgYKYEWuabvkB9qmEgsbel1Yb/sBv7i7xjeCA0OzIrBpqLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR8jEQYFAUFTVVRdxuliWbJR+fjKI1kogAYjzP/DzyE=;
 b=dEXG6MGnyrkxPj6ON2kkZk8wgT69CSM05FNwjRM6ILx60meSAn7GmGjdAyH1xugUgpl1GThDR3SSqwahf+ZeArFn3K2Cm/kCPa7BYQi42SD4mLex9nLrTasKOndYuAl3qEZugxco8sIQr/9hxZXZdR6Lw4g5ZxVLL71ug/eDugO8qrLLedVHNfU8E94ostGgg82rHpaeu99jDzWdR4dEyfKh0van8ANg7LpLdZHCFdJSU6KeaJpVaoejMfKB5udw+VuVII2Xzatt5bAwZNSLVAE8Gxn7eJ2ZX4m4xP0yRD+sdEevOocGpRKzIvUMCkrZZXv169ZM/CEK6YXCUIOakg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI1PR09MB4509.eurprd09.prod.outlook.com (2603:10a6:803:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Tue, 19 Aug
 2025 07:55:04 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 07:55:03 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Yao Zi <ziyao@disroot.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 09/12] riscv: p8700: Add Coherence Manager (CM) and
 IOCU support
Thread-Topic: [PATCH v3 09/12] riscv: p8700: Add Coherence Manager (CM) and
 IOCU support
Thread-Index: AQHcAKVGLTciiZylu0yFj9TzjUY107RNgG6AgBw7a4A=
Date: Tue, 19 Aug 2025 07:55:03 +0000
Message-ID: <e288bc8d-f644-4d07-9e43-7a9c042a6ea7@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
 <20250729162035.209849-10-uros.stajic@htecgroup.com> <aIx_Cwijrz8L7IHK@pie>
In-Reply-To: <aIx_Cwijrz8L7IHK@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI1PR09MB4509:EE_
x-ms-office365-filtering-correlation-id: 8c5cd479-0553-4ae1-842e-08dddef5b4ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UFg4ZGJzNlZjL21WcE91Nm96WldNU3ovbTdUdTdxNWhTbmhESEp2UlU5aUpy?=
 =?utf-8?B?S2tmcmRTTkRPaUg3Sk56LzhpU0hBeTVpMVp2Zjk1M0JUTWdWRnorMVNEQnNC?=
 =?utf-8?B?VEx4d2J1VkgxdU55ZklTQ0ZNdjQxS2N3cFlMTHpENnBWQ1cwWGxGTEFvT210?=
 =?utf-8?B?OU5ad1hNRENuTHI4T1g2OXNVQjR5M2NtVnZKVkRHdnFuamtTaWdFNzljb25z?=
 =?utf-8?B?eGlQVEdTS3FzVVV2SDB3c251M0ZjUlBweXNUODZZbGtBN3h5d1UzRm8vTnBa?=
 =?utf-8?B?RDhrWHNQdi9NOTZpRDJXL0xxYmtzcWd5NkRmbzBxeXB1d2JNSE1MYnhiajF1?=
 =?utf-8?B?S21DTUM5b3ZtdXlGdGhWMUNYSGR5TzdTTjB0Ti9tL3F6S2ZyYmhybE5aV1NQ?=
 =?utf-8?B?ZndmakZyeWdlQ1F4K2pkcVROSmJtUjc2aDNvZDY5dWl0WHJBN2FwSGg2c01i?=
 =?utf-8?B?aHVGTnJCRjQ5M0E2cFJyMUE2WjdwTzl0N25BWW4yQ3psSTZOcklmVUxpbkNo?=
 =?utf-8?B?RkFZdG92UWRyYkUxWnVtOTU4eVUyK24wRkFnbEZ2bUVXYWhsSm80UXVlTks4?=
 =?utf-8?B?R0JMeGllemhDOU80QVpUNjIwK2JtS3BZVFNQak92NXA5UGhSSy8wSWlTTEZD?=
 =?utf-8?B?WFlOdEZGU09JQ3JkMGtKTWdIYnd4cUt3WlhTZnRRWG9kMnltOEZDbmNneFJ1?=
 =?utf-8?B?ZnNzZUNIMEJzaSs3NndYWTVFRCtmeVlkTjJsSmxDNjdQUlNpSHBiWjF3OHdK?=
 =?utf-8?B?YTJNekErb2hWS0JNckZSeTd4eVNLRDRnMGxUZjNRSEdwNVlFZ08wVEVzSkhC?=
 =?utf-8?B?bmIzcmFkbktkT0RrYUFNazYzNUFNU1M1bjBydHFOdlIxNXF1TDhZVllsY0kz?=
 =?utf-8?B?cUZQYi85QndMM1h5a0IzSWRxbHBRdkpMbmhVUGF5QnB0MEZSVURRNkswRTF0?=
 =?utf-8?B?MEhLcU5hbGxEcWFicmpjSUhDWVJ1Rk9HSnpKSTJQYVBRc2NYbVRMbTBwV3Jx?=
 =?utf-8?B?M2pyOHpkajl4eXUyMHZhRHNkLzRTajFUUU1lTitCVUtzUUluL1gzMUtrdG95?=
 =?utf-8?B?QzA4N0FzWU5MYjFGa0lheWF2R1lSV2ppek43OS94RmFwVVE1a2hRQ21hNnVk?=
 =?utf-8?B?K2dxMU9EQXRPNU00MHVCTmlhL2IyZmt2dXY4Z3FnQWoyVkFtcTFia0I2a1Vk?=
 =?utf-8?B?VUw5WlNhbmw4OUh2Sy85M0gwTjBnV1pDbVF4bmJ5aGZGMlRJRFI2ZkJuTFE3?=
 =?utf-8?B?ZERwNnNwQTZMNksxS0UrdTFjYUpSMlhIdmY0REkyZG9RcTVjcW5UaklCY0pq?=
 =?utf-8?B?SSs2L1NGMTF3VlBPdHpiYWJqekZvbGdHaUxxVGIwVkxsbFl5dlRhdElpeE9O?=
 =?utf-8?B?OCsxNFRlazlldVpQNHN4eUdGRENoaEx0TStaQjJmZEJiUjVSOWlxdG5ISk0y?=
 =?utf-8?B?S25ETVFaeUNodGtQVjJlTjdpcGsybmFXYVF2MlptaHFtY2hIOS9acS9RNXZT?=
 =?utf-8?B?bnYxSStSVnV3K2k5YWNxNHdSZDkwQzg1TTJHS0VkTDVUOVdPODY3bklaTXpX?=
 =?utf-8?B?L0N2cEkzOGtGRlBvV1FUL0NHTE05Z1JPanlVZ3hIV0J4OTRqQ1VzYTFkVEly?=
 =?utf-8?B?d1d6RTMzLzhaNTJEaHY2RHdyOGhQd01WYnZURTIvYjA3WWhNMFUrNjd6Z1R0?=
 =?utf-8?B?SlhuK2lzb2kyUHdkbnhIZDZ5OHBvdFlEN2ZnZ3VNT2UwU2VJSTU1blBxNUpp?=
 =?utf-8?B?YWpwT0Qwek9jQmpZdzlBQVVDdklSU2NQcWZua1Z2RDU2MHU1UlVSbWpkdDgr?=
 =?utf-8?B?T2wzZlg4aFFXSDB0ZXUxcEJhdjJFRzJMOEtEMmVrNFJiRk9iNEZnTzBZN1VE?=
 =?utf-8?B?L1VRMEZUU2JPQkUxdURramJCSjROdWRFeEpFSU02MFo0OXpMVnAySjZaMDcx?=
 =?utf-8?B?UmV1U2ZSVXo0d0g5akY4R0kveVRoQnBFRXpJRWh1elUxRmE1VERnZGM2aWdV?=
 =?utf-8?B?WEhRcnZ1dTB3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDg5dWZoSS9tblZXRWVNM2dIeTQwMTBpNEVSNmhCdEFTK3J2L1gxb0lqa0s1?=
 =?utf-8?B?WFo5eTl5Z2xyZzlXZUZyMEQyMGZMSDFNRHN4SlFyNlFlbHB6RG5TL2VqMk9E?=
 =?utf-8?B?RGN1ZEF3R1lFUFpSTHo1YVh4S2NJWm11QTNHdldQMWw1VjFWVzBZdk43NEo2?=
 =?utf-8?B?TWdKdTRwbTRydzRnVTFzTm90S3hnekorNUYvaDZlelpwUU9tS0Y2eEtKTEFF?=
 =?utf-8?B?Q0FjYVdZQW1TK2I3NWJZUGFvOVg4dnJ1NUhIVHpadmZJMjJ1QUlRaTZlYUZa?=
 =?utf-8?B?L1BpcW1OVlBkRXh6WjM4NFd5bmFkQmhxU2g4Ly9oTHZKeHUyUTNZQW40UVpF?=
 =?utf-8?B?Z0RvV0FTYXZhNHNjRWlEd1dvNmg3ZWI1N0xXU0orNTUyTmNYckNBWGJUMjJm?=
 =?utf-8?B?dmxiUnZURDhGVXRjc0k1WVU2c3RjV0lzbzI0MVdOQTB1bkN4L05iMFlLTWlk?=
 =?utf-8?B?OHlLcytOVEQrdnV4ZUYrbDRqOGpVUXNMQ0R0V3cwU3B6alhOaHIxZlJoZ1Jz?=
 =?utf-8?B?cmRQZ09tK05SVHlRKzBsZDlzczBaS2JFbU04SkRpTzZ5ZEx5UzBpQlBiRW1I?=
 =?utf-8?B?clM4WCtsSnFyVG93dEhXSEJzMUtSNmhsWkVYbFJxRXlKbThEbWdnRHdaU0xJ?=
 =?utf-8?B?eVI5VUs5aFkvZHJzZEZEcVFqK0xGaFAzakxhMDFqWWw5azBZVWpXMnJuc3BZ?=
 =?utf-8?B?WU85Y2ZVSlozek9lR3A5QkpTUDhIOVNsY0FFMkg1N0NGK0hIU2ZlSzhXNTZB?=
 =?utf-8?B?YjRyT3ZhY2pRRnVIRDFwNThUbTJrUTBINWUvQnphdENRK3p6amV6djVVSk9T?=
 =?utf-8?B?TDVmb1FrRmdrYTJ3YVR0MWt6aEhtYUMzeGVDR0Mzd1BCTXJEdi90and0TUdp?=
 =?utf-8?B?a3pSRGt2NWE5YUxrcnhyZlVCMFFIM1dhMjBqUng0ZUZ2cDJkVU1iR0NUaHk2?=
 =?utf-8?B?UGlxSlRTU2FjanVENDZESVdHMHpEUzcrNTJ3dzd4aVdhTXd0RTEvdGVXN0R1?=
 =?utf-8?B?WC90SVJ1bEFsWkVQc0pNemFzSi8weVljdzRnTi9zV3dBMnV3VXZlem01UGdi?=
 =?utf-8?B?MGI4dFN6elFrRzNzM3JOc0Q1aTBZWFFnVTB6bVVnR0dCNnQvL1hiaTFtL0gx?=
 =?utf-8?B?NVhtY2tHZCtPNWNpN3F3WU9tL0hERkhSdmprLzk2U2RlMEdMOUQvU2QrMzd5?=
 =?utf-8?B?VmdPZ09mRWkrRHZFZ1lpVE1IcXFzRHVFdjAxeDMvNWplRXE5VnZWc0JLUWJ1?=
 =?utf-8?B?dk9yOXdIRzBxWVZGbjhkNXQxMDRHK2pib0doemRJT0ZDL2pqUHVlcEw4UjBT?=
 =?utf-8?B?OUlTQTJRVnNrLy80SktQV2dMNzBmanlheTJPNEVhL1l4bWd2NWEzdzIzNXRs?=
 =?utf-8?B?dFJuSFc3R29xbG9tREcwSGw1bzVHZWh3UklJVDgrSmxmbDJwMUwzaTIzOHdR?=
 =?utf-8?B?Vy9oeFhsYWVTZGNYcUZ3cmxYa0dsNFlyOUlpZnNVQkZQZ2loVEUvRUQvTXJR?=
 =?utf-8?B?K3B3TmVQbVFpV1lZSnRkVnJWZWU4Z0NrNThCREhObjBDUVZqdU9FNUJadXZ0?=
 =?utf-8?B?YjlOd2VtaVNhYisxVjlwZWE3d0xKWEEvMkc2ZER5Mm5YR0Mvc2tJMlk4NFh4?=
 =?utf-8?B?endKM1VvRDE3QjlUcWRaNzh1Qmd3NGtHWFVmcGRqNlVTN1dmWnZURzRSdmRm?=
 =?utf-8?B?SGc5M00wd2Y2LzdWZ2JHdW5OWTlRUnV0L2ZaTTcrVytpK1lkZ2Z3YWpmQUZ4?=
 =?utf-8?B?dDlicE92dmpGYzNOSTkyK0V4WkdLakVjN0lyenV4RjcyaTZvK0N0WUFQc3Zm?=
 =?utf-8?B?S2VDTExaQmgzRUtJclNKSDNTeG0ydkxId24zZVJIaUZhMHpxc3NOZ3ByUWNN?=
 =?utf-8?B?MjkyNXR6ZWg4KzFWT2N0Rkw0cGpJeG55cGIyc2ZhRUEzUGJqeHBEN0tHTi92?=
 =?utf-8?B?K3JXUnVqUVZxbklMT0paeERyN1BVRm1zU1dHVUpPOC9DV3dxUmtRR0V6T1hX?=
 =?utf-8?B?TXI1THJHdC9WeXAydnZmS1pHSzNYck5OSCswcHoyZTBVSVBRNWp1eHhmSDB0?=
 =?utf-8?B?bGVad2w4VEI5MFk4a0M2RWdCRnI2a0dqdWRjQThxcnIwZHVUUWZxTUx2cWFi?=
 =?utf-8?B?MTY4Y0pPOERFVkszbXQvTnlUZ1M2eHZmZmU4dEo2WnJtUEF5WGdJTzFlN3Fn?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57512A4890C5A946A622FA25A28DCE1F@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5cd479-0553-4ae1-842e-08dddef5b4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 07:55:03.7444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjhSvU6iDoN/GFU/dgVc+4JgayEQj33Jei9XOJpOu2RRZ0JxA9whoS2eoknB4JHp2x43EwBjk8x5zxjnBCoQM7aR1agIRCkSLBzZV4llouw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4509
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

DQoNCk9uIDEuIDguIDI1LiAxMDo0NywgWWFvIFppIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hv
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB6aXlhb0Bk
aXNyb290Lm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBz
ZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiBUdWUsIEp1
bCAyOSwgMjAyNSBhdCAwNDoyNDozNlBNICswMDAwLCBVcm9zIFN0YWppYyB3cm90ZToNCj4+IEZy
b206IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4NCj4+IEFkZCBzdXBwb3J0IGZvciBD
b2hlcmVuY2UgTWFuYWdlciAoQ00pIGFuZCBJT0NVIGRpc2NvdmVyeSBhbmQNCj4+IGNvbmZpZ3Vy
YXRpb24gb24gdGhlIFA4NzAwIHBsYXRmb3JtLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8t
eWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVXJvcyBTdGFqaWMgPHVy
b3Muc3RhamljQGh0ZWNncm91cC5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC9yaXNjdi9jcHUvcDg3
MDAvTWFrZWZpbGUgICAgICAgICAgICAgfCAgIDIgKw0KPj4gICBhcmNoL3Jpc2N2L2NwdS9wODcw
MC9jYWNoZS5jICAgICAgICAgICAgICB8ICAxMCArKysNCj4+ICAgYXJjaC9yaXNjdi9jcHUvcDg3
MDAvY20taW9jdS5jICAgICAgICAgICAgfCAgNzUgKysrKysrKysrKysrKysrKw0KPj4gICBhcmNo
L3Jpc2N2L2NwdS9wODcwMC9jbS5jICAgICAgICAgICAgICAgICB8ICA5MiArKysrKysrKysrKysr
KysrKysrDQo+PiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXJjaC1wODcwMC9jbS5oICAgIHwg
IDYxICsrKysrKysrKysrKysNCj4+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLXA4NzAw
L3A4NzAwLmggfCAgMzEgKysrKysrKw0KPj4gICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2dsb2Jh
bF9kYXRhLmggICAgICB8ICAgMiArDQo+PiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW8uaCAg
ICAgICAgICAgICAgIHwgIDg2ICsrKysrKysrKysrKysrKysrKw0KPj4gICBib2FyZC9taXBzL2Jv
c3Rvbi1yaXNjdi9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArDQo+PiAgIGJvYXJkL21pcHMvYm9z
dG9uLXJpc2N2L2lvY3UuYyAgICAgICAgICAgIHwgMTA0ICsrKysrKysrKysrKysrKysrKysrKysN
Cj4+ICAgMTAgZmlsZXMgY2hhbmdlZCwgNDY0IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvcmlzY3YvY3B1L3A4NzAwL2NtLWlvY3UuYw0KPj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9yaXNjdi9jcHUvcDg3MDAvY20uYw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLXA4NzAwL2NtLmgNCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGJvYXJkL21pcHMvYm9zdG9uLXJpc2N2L2lvY3UuYw0KPj4NCj4gDQo+IC4uLg0K
PiANCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2lvLmggYi9hcmNoL3Jp
c2N2L2luY2x1ZGUvYXNtL2lvLmgNCj4+IGluZGV4IGRhMTY1ODU4MDM0Li5mYjc5ZDBhOGQzMiAx
MDA2NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW8uaA0KPj4gKysrIGIvYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS9pby5oDQo+IA0KPiBUaGVzZSBjaGFuZ2VzIGRvbid0IHNlZW0g
dG8gYmUgcmVsYXRlZCB0byB0aGUgY29tbWl0IG1lc3NhZ2UuIFBsZWFzZQ0KPiBzcGxpdCB0aGVt
IGludG8gYSBzZXBhcmF0ZSBwYXRjaCAoaWYgdGhlc2UgYXJlIHJlYWxseSBuZWNlc3NhcnksIHNl
ZQ0KPiBteSBjb21tZW50cyBiZWxvdykuDQo+IA0KPj4gQEAgLTE1LDYgKzE1LDkxIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBzeW5jKHZvaWQpDQo+PiAgIHsNCj4+ICAgfQ0KPj4NCj4+ICsvKg0KPj4g
KyAqIEdlbmVyaWMgdmlydHVhbCByZWFkL3dyaXRlLiAgTm90ZSB0aGF0IHdlIGRvbid0IHN1cHBv
cnQgaGFsZi13b3JkDQo+PiArICogcmVhZC93cml0ZXMuICBXZSBkZWZpbmUgX19hcmNoXypbYmxd
IGhlcmUsIGFuZCBsZWF2ZSBfX2FyY2hfKncNCj4+ICsgKiB0byB0aGUgYXJjaGl0ZWN0dXJlIHNw
ZWNpZmljIGNvZGUuDQo+PiArICovDQo+IA0KPiBCdXQgeW91IGRvIGRlZmluZSBoYWxmLXdvcmQg
b3BlcmF0aW9ucy4gVGhpcyBjb21tZW50IGxvb2tzIGxpa2UgdGhlIG9uZQ0KPiByZW1vdmVkIGlu
IGQ1YWYxNWJmNTE1ICgicmlzY3Y6IENsZWFuIHVwIGFzbS9pby5oIiksIGFuZCBzZWVtcyBhbHJl
YWR5DQo+IG91dC1vZi1kYXRlLg0KPiANCj4+ICsjaWYgQ09ORklHX1A4NzAwX1JJU0NWDQo+PiAr
I2lmZGVmIENPTkZJR19BUkNIX01BUF9TWVNNRU0NCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgKm1h
cF9zeXNtZW0ocGh5c19hZGRyX3QgcGFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuKQ0KPj4gK3sNCj4+
ICsgICAgIGlmIChwYWRkciA8IFBIWVNfU0RSQU1fMF9TSVpFICsgUEhZU19TRFJBTV8xX1NJWkUp
DQo+PiArICAgICAgICAgICAgIHBhZGRyID0gcGFkZHIgfCAweDQwMDAwMDAwOw0KPj4gKyAgICAg
cmV0dXJuICh2b2lkICopKHVpbnRwdHJfdClwYWRkcjsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGlj
IGlubGluZSB2b2lkICp1bm1hcF9zeXNtZW0oY29uc3Qgdm9pZCAqdmFkZHIpDQo+PiArew0KPj4g
KyAgICAgcGh5c19hZGRyX3QgcGFkZHIgPSAocGh5c19hZGRyX3QpdmFkZHI7DQo+PiArDQo+PiAr
ICAgICBwYWRkciA9IHBhZGRyICYgfjB4NDAwMDAwMDA7DQo+PiArICAgICByZXR1cm4gKHZvaWQg
KikodWludHB0cl90KXBhZGRyOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIHBoeXNf
YWRkcl90IG1hcF90b19zeXNtZW0oY29uc3Qgdm9pZCAqcHRyKQ0KPj4gK3sNCj4+ICsgICAgIHJl
dHVybiAocGh5c19hZGRyX3QpKHVpbnRwdHJfdClwdHI7DQo+PiArfQ0KPj4gKyNlbmRpZg0KPj4g
Kw0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgY2hhciBfX2FyY2hfZ2V0Yihjb25zdCB2b2xh
dGlsZSB2b2lkIF9faW9tZW0gKm1lbSkNCj4+ICt7DQo+PiArICAgICB1bnNpZ25lZCBjaGFyIHZh
bHVlOw0KPj4gKw0KPj4gKyAgICAgYXNtIHZvbGF0aWxlKCJsYnUgJTAsMCglMSkiIDogIj1yIih2
YWx1ZSkgOiAiciIobWVtKSk7DQo+PiArDQo+PiArICAgICByZXR1cm4gdmFsdWU7DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgc2hvcnQgX19hcmNoX2dldHcoY29uc3Qg
dm9sYXRpbGUgdm9pZCBfX2lvbWVtICptZW0pDQo+PiArew0KPj4gKyAgICAgdW5zaWduZWQgc2hv
cnQgdmFsdWU7DQo+PiArDQo+PiArICAgICBhc20gdm9sYXRpbGUoImxodSAlMCwwKCUxKSIgOiAi
PXIiKHZhbHVlKSA6ICJyIihtZW0pKTsNCj4+ICsNCj4+ICsgICAgIHJldHVybiB2YWx1ZTsNCj4+
ICt9DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgX19hcmNoX2dldGwoY29u
c3Qgdm9sYXRpbGUgdm9pZCBfX2lvbWVtICptZW0pDQo+PiArew0KPj4gKyAgICAgdW5zaWduZWQg
aW50IHZhbHVlOw0KPj4gKw0KPj4gKyAgICAgYXNtIHZvbGF0aWxlKCJsdyAlMCwwKCUxKSIgOiAi
PXIiKHZhbHVlKSA6ICJyIihtZW0pKTsNCj4+ICsNCj4+ICsgICAgIHJldHVybiB2YWx1ZTsNCj4+
ICt9DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgX19hcmNoX2dl
dHEoY29uc3Qgdm9sYXRpbGUgdm9pZCBfX2lvbWVtICptZW0pDQo+PiArew0KPj4gKyAgICAgdW5z
aWduZWQgbG9uZyBsb25nIHZhbHVlOw0KPj4gKw0KPj4gKyAgICAgYXNtIHZvbGF0aWxlKCJsZCAl
MCwwKCUxKSIgOiAiPXIiKHZhbHVlKSA6ICJyIihtZW0pKTsNCj4+ICsNCj4+ICsgICAgIHJldHVy
biB2YWx1ZTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB2b2lkIF9fYXJjaF9wdXRi
KHVuc2lnbmVkIGNoYXIgdmFsdWUsIHZvbGF0aWxlIHZvaWQgX19pb21lbSAqbWVtKQ0KPj4gK3sN
Cj4+ICsgICAgIGFzbSB2b2xhdGlsZSgic2IgJTAsMCglMSkiOjoiciIodmFsdWUpLCAiciIobWVt
KSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2FyY2hfcHV0dyh1bnNp
Z25lZCBzaG9ydCB2YWx1ZSwgdm9sYXRpbGUgdm9pZCBfX2lvbWVtICptZW0pDQo+PiArew0KPj4g
KyAgICAgYXNtIHZvbGF0aWxlKCJzaCAlMCwwKCUxKSI6OiJyIih2YWx1ZSksICJyIihtZW0pKTsN
Cj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB2b2lkIF9fYXJjaF9wdXRsKHVuc2lnbmVk
IGludCB2YWx1ZSwgdm9sYXRpbGUgdm9pZCBfX2lvbWVtICptZW0pDQo+PiArew0KPj4gKyAgICAg
YXNtIHZvbGF0aWxlKCJzdyAlMCwwKCUxKSI6OiJyIih2YWx1ZSksICJyIihtZW0pKTsNCj4+ICt9
DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB2b2lkIF9fYXJjaF9wdXRxKHVuc2lnbmVkIGludCB2
YWx1ZSwgdm9sYXRpbGUgdm9pZCBfX2lvbWVtICptZW0pDQo+PiArew0KPj4gKyAgICAgYXNtIHZv
bGF0aWxlKCJzZCAlMCwwKCUxKSI6OiJyIih2YWx1ZSksICJyIihtZW0pKTsNCj4+ICt9DQo+IA0K
PiBJIGRvbid0IHNlZSBhbnkgcmVhc29uIG5vdCB0byB1c2UgdGhlIGdlbmVyaWMgbWFjcm9zIGZv
ciBQODcwMCwgdGhlc2UNCj4gaW5saW5lIGFzc2VtYmx5IHNob3VsZCBiYXNpY2FsbHkgYmVoYXZl
IHRoZSBzYW1lIGFzIHRoZSBDLXZlcnNpb24gYmVsb3cuDQo+IENvdWxkIHlvdSBwbGVhc2UgZXhw
bGFpbiBpdCBmdXRoZXI/DQo+IA0KPiBUaGFua3MsDQo+IFlhbyBaaQ0KPiANCj4+ICsjZWxzZQ0K
Pj4gICAjZGVmaW5lIF9fYXJjaF9nZXRiKGEpICAgICAgICAgICAgICAgICAgICAgICAoKih2b2xh
dGlsZSB1bnNpZ25lZCBjaGFyICopKGEpKQ0KPj4gICAjZGVmaW5lIF9fYXJjaF9nZXR3KGEpICAg
ICAgICAgICAgICAgICAgICAgICAoKih2b2xhdGlsZSB1bnNpZ25lZCBzaG9ydCAqKShhKSkNCj4+
ICAgI2RlZmluZSBfX2FyY2hfZ2V0bChhKSAgICAgICAgICAgICAgICAgICAgICAgKCoodm9sYXRp
bGUgdW5zaWduZWQgaW50ICopKGEpKQ0KPj4gQEAgLTI0LDYgKzEwOSw3IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBzeW5jKHZvaWQpDQo+PiAgICNkZWZpbmUgX19hcmNoX3B1dHcodiwgYSkgICAgICAg
ICAgICAoKih2b2xhdGlsZSB1bnNpZ25lZCBzaG9ydCAqKShhKSA9ICh2KSkNCj4+ICAgI2RlZmlu
ZSBfX2FyY2hfcHV0bCh2LCBhKSAgICAgICAgICAgICgqKHZvbGF0aWxlIHVuc2lnbmVkIGludCAq
KShhKSA9ICh2KSkNCj4+ICAgI2RlZmluZSBfX2FyY2hfcHV0cSh2LCBhKSAgICAgICAgICAgICgq
KHZvbGF0aWxlIHVuc2lnbmVkIGxvbmcgbG9uZyAqKShhKSA9ICh2KSkNCj4+ICsjZW5kaWYNCj4+
DQo+PiAgICNkZWZpbmUgX19yYXdfd3JpdGViKHYsIGEpICAgICAgICAgICBfX2FyY2hfcHV0Yih2
LCBhKQ0KPj4gICAjZGVmaW5lIF9fcmF3X3dyaXRldyh2LCBhKSAgICAgICAgICAgX19hcmNoX3B1
dHcodiwgYSkNCj4+ICt9DQoNClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrISBBZnRlciByZXZp
ZXcsIHRoZSB1c2Ugb2YgZ2VuZXJpYyBtYWNyb3MNCmFscmVhZHkgcHJvdmlkZXMgZXF1aXZhbGVu
dCBiZWhhdmlvciwgd2hpY2ggbWFrZXMgdGhlIGlubGluZSBhc3NlbWJseQ0KdmVyc2lvbnMgcmVk
dW5kYW50Lg0KDQpUaGUgcGF0Y2ggd2lsbCBiZSB1cGRhdGVkIHRvIGFkb3B0IHRoZSBnZW5lcmlj
IGltcGxlbWVudGF0aW9uDQppbiB0aGUgbmV4dCByZXZpc2lvbi4NCg0KUmVnYXJkcywNClVyb3M=
