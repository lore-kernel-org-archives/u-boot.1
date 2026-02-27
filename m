Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8816DFEFB7C
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 18:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B0483D1A;
	Fri, 27 Feb 2026 19:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gatech.edu header.i=@gatech.edu header.b="DnApl/ng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C58A83E76; Fri, 27 Feb 2026 19:25:22 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D788483CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 19:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=slee3846@gatech.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5ns+v3m5lJjo/yLzrH/OUgSxr1BK72izhQcgju3LmLMDMuf6BTWtraPakc8ILM/ljbi5H8mTgbap7oXGEAj/lF+O6UPSb+TdKtZ3moTcuckA+ULXzl2bUNs4dor+CidBdD41MqZBsDKDeg5HLcyU/c6tVjPfnSW3gwntQWDZVlVVSqdn6dFeNcHAIoxuBFo+++j4mUhjxyDYvXUKhTTCLNJpXISXM0ID+dXhfnr7S7JRf/Za5z1yPTvBIutMU4pdAePSIE2cSUmImU/a7xtQHHwi/8MfGLfLHen4f6N5yjpiuC9kxNoyi/2SuJUAd0RixYwcZZFutr6EYaipBOWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGLrBpQmL7HhuP91rIieN432u+BhU/psiLkWarRFeag=;
 b=G1ZDFmH0tRP5CHQZv+rlYwemVvnHo3bN6ApWhYPnY/CBaaXOC/SZ8Ec1SYSNLjs1E/0gOxwMfQ0mzROblbVYGIFQLkJgZ44iKUKdzp87iOu4YdFgUZuC9JbCj2p1Zn0ehZsDyQVGgwGuwV2FZku/AK0SjVb4dGNostP8OxMAtT3E328g5BczaLu7Z5Ze62VshtVS7yT6e9kVIdEaEA1/iHgReAYb1XHFHTRAGnz9mRtuZDfqijDo/DoQ1kVGs6MdJdufgz4cbfuuaW6DZpyWsP0jHl+1QXT+UvXBgXOPcx6YKwnRWdS975blxbzc3tlOy9FK7xOJbTuxuyodd/bMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGLrBpQmL7HhuP91rIieN432u+BhU/psiLkWarRFeag=;
 b=DnApl/ngZ8kW7PcPK0HY94pYVJJ7hoUTeHAnIo2N3xgxufcpvfVxOp90Opn4ykFbPhIiiAVp9R2T1DNFZMT+TikI0c9DuRT/uQ69N6VnmS+vm3vIc8tYqU0cG9VSc9gpomzBdWiKWt3T62m3ZR/oLidA3JFVQHm23aCFJYVtPryMYCT1p7mD2nkSEZkAZrYgvsbw1GWSDdKQKXNiUX8FVaQlcjhj0kLDgjmXvNOxKFmRjMslgMNdZ+2P4KCwIagXm4Tacp6MsuPuPUwTyh2TOisAEsv54tKrGx0+ybw8OXVu7pANSjGyYCfSYcXaZZLR9cxsQQvhaHLGbX69EXsU4Q==
Received: from MW4PR07MB8636.namprd07.prod.outlook.com (2603:10b6:303:105::10)
 by BY5PR07MB7313.namprd07.prod.outlook.com (2603:10b6:a03:201::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.20; Fri, 27 Feb
 2026 18:25:14 +0000
Received: from MW4PR07MB8636.namprd07.prod.outlook.com
 ([fe80::29b8:15a9:4cba:aacc]) by MW4PR07MB8636.namprd07.prod.outlook.com
 ([fe80::29b8:15a9:4cba:aacc%6]) with mapi id 15.20.9632.010; Fri, 27 Feb 2026
 18:25:14 +0000
From: "Lee, Sin Liang" <slee3846@gatech.edu>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "Kim, Taesoo"
 <taesoo@gatech.edu>, "Zhang, Cen" <czhang887@gatech.edu>, "anshuld@ti.com"
 <anshuld@ti.com>, "bb@ti.com" <bb@ti.com>
Subject: Security Disclosure: Multiple buffer overflow vulnerabilities in NFS
 client
Thread-Topic: Security Disclosure: Multiple buffer overflow vulnerabilities in
 NFS client
Thread-Index: AQHcp8KHO9No1PLzuUO1ZFAlOSOgcw==
Date: Fri, 27 Feb 2026 18:25:14 +0000
Message-ID: <MW4PR07MB86367A3DBC308E10144FE6A6AA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR07MB8636:EE_|BY5PR07MB7313:EE_
x-ms-office365-filtering-correlation-id: 304bd6cb-4463-410b-9d97-08de762d8ced
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|786006|13003099007|38070700021|8096899003;
x-microsoft-antispam-message-info: hrsdN3C60X7OGFITpP1XY67H9YF3/2N8pu+Q1MhmH/uLcyA93McrTbbqBRxJ4vL7NaJB/ovWVDByyfGBcgK0KQaqq/OK9XG+gsNi//c+KB4G5ntwIJ7kHDWw4d2dpR4IXL2sR4Ekvmww366Pm4R7rR1pwkKCggE4c7VtqHIN9wbwE7yXXVa8d/JXuH9daqXadVvwAU4Kf9CtWkZCG85u0j8aLMy2+5Y6QU2wCKb0wFHJTqFrNUuBTTmWRXUligOH1aQuEidF4THu0ZDYr8yEDAzrHCenhqMLeq00Bn+U69eO/BZQMCQIYJ6sDzQCWj692Iiu1b1nUgqGnBCk+FEz6Y9bN5om1tOd/kWhZVvOs/DX30gdb0riM+yAedJdgPLOcsuwBlD54e0WhYxoJzotDbwhtt/wQ9OLoUvXm63EDO0metiipdYqbjOlvqYgzfKVIg6K8Tj4WZhJTBQ2f44Sgkm4/XgnqzrlIalPowJVT46hC4EZXgZTEkWNMq40e+RkJlLlsOQ7tJQ6KkxFzo9HnJo9LwIfl5QR9q1JY0FIPctutUlWUC0WoFZsUNwTwNkDt0oiGJg0rF/2QTbwza+LxMxgNDb1bxKerXerJyoz8XZUAWu3+3J37+KJ+3pK0XzxK1p/vTn4NnY0mN1R/4WMBea0vpY5OR69RqjDkHxCHDrFb6H24LjuP3Dx2GsaQNxDC0EGmdho748OLqur7EQ3sfjc9fBwfUg1sxlIhEO4hPerHF7twqh7mgPZYWAtb9/H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:MW4PR07MB8636.namprd07.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(786006)(13003099007)(38070700021)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?ZHk0d3IwSGQ3cmNvNGxYbWZaekMxYlpDaVNiMm13VERoaWZQRmF6Y0pYaElGaU5V?=
 =?big5?B?WW1QUXBXZytnNUZyNm0xTHlzNW50UUVKaDNZQ3ZqdlFkbGRjQXBUbGNIaDBucGVZ?=
 =?big5?B?Zll0Nk4xc3VPVERuUmI1VHBPTWhyRUZWTEhsSkJOb2dYeGQrOXp6OUVNYjRPSXQy?=
 =?big5?B?VnhVbDRMRUw1eXMwR1YwNGNCWHB5NEVlZkxZNnVoRWtOWHZxY1IzOWVpM0VEM3R3?=
 =?big5?B?bktHbnhIZUc3N2dwK0t5T1MrcWE2YmhyRnlSZlFoWnMvZzlVWCswbEFqblpBblpm?=
 =?big5?B?bTdPeWdVbDRiRFNtZyt6WVdZUnJiejh1WlMvUDlwaVhsK1hzZ0JPWTljL3hFOWNR?=
 =?big5?B?WkRUNmRoc0lhRnpyNk94WmRhRjRkaFNtZFVtVG5GZGVLaXkyNXEwWVdFaVBUaTBQ?=
 =?big5?B?cEcxTzdkUzhpNGVra3JPQmRRZjd3VEZqY00wWkJERzBETGxzNWNUbGFGbERhbXph?=
 =?big5?B?N0QraWxGTVUza0VJVE9vWjV0TXhXZDgyTUpRREdDUkkvWTZ3dTdOUExhSVRYZUJX?=
 =?big5?B?RitkdFUwRnVoei9tYWcyekxnajNSd2tGNG93K2V6WnkvTDdZakdPWUN0SEJpU2RN?=
 =?big5?B?RFRtK0IxQkhSbWJvMFYydVhKZVNESGV3cWF0WVFjWkk1OHExZ3hzY1NRT3hMejhr?=
 =?big5?B?YmZQZEpiR21Xc3paS3lCRmk3MnR3REwyWXZjVytlZEg0enZRamxIWW9IWElZcFAx?=
 =?big5?B?emVXcVZVeEtwa2RIOUNZWE1OWG9QVVc2OXd0Q3c0UkJILzhlQWFJdmx6SGlFdjhx?=
 =?big5?B?S1N1U3hWTnZPRmlGMWRGQm5SdnRrRmZNWVJkNWg3ZUNqNUJ2M0Raekt1bG9LNmJz?=
 =?big5?B?QVVWUjZnVm0vVnV5Qlp6WitROU9uTktXMUEva3N0dTlpK05aQVd2VGVBNlpRRm1m?=
 =?big5?B?TStnQWl1NzgzVzNOYURHeGVrMVdwTWRWVVF0ajhzV29pbGxJWGw1R2JXSWwyS25W?=
 =?big5?B?aS9CVWwwekZ4ZSs1cEp0T2E1c2pjWkhLQ2RjNkJKUmk1aitnV0lkVDk5RVN1UWYz?=
 =?big5?B?a3BiTjYveDBEU2N2NHl0N1F2MHVtQnFQU0EvMmJPbXJiUUpXRVhvY3NaUGVha2Vs?=
 =?big5?B?NkwxempCQVdWV0NrMXdrdUE5b1liRUdoWERyeElTd054VXdIdy91UUlNcEFJeHNR?=
 =?big5?B?VjdyOTl5NUNsMmVBcWF0Zlp2K09PTG04S2pvUDJISUNTZmhZUUYzMkYrNFMzd2Vy?=
 =?big5?B?c3c4RS9yb2t3bDEzQ3lQaUw4YnFPUnh3TktoVllUNlplVGVCbTdtcjV6Zi9kOTcz?=
 =?big5?B?elo4bC9pZnRXMlpDak5FVlB2ZXRpcUdLYjhUN0FRejdRZlBpa3d0dE5NeWx6YWhP?=
 =?big5?B?WGR1Um54anJIMUJEa0thenpvRmxScXA4d0kzcHpXRXUwR2pTRnpqc3ZwNzI2Y3Ba?=
 =?big5?B?aE1aSkg3RjBCK1lYbWF4blIvWW9icUd6b1FBR3N1QkhZRFB3MnRoMnhzaWxsRk1t?=
 =?big5?B?YlBRLzNkTDRTUWU3eHc0cE9zWEh6clRpRkNUMGlZVnUrY1l1bmZXbUNNMzNlZWJo?=
 =?big5?B?SFNvVzBaZ1RWZkVsdmpoc09iMGI5SkFIc3NEcUdmY1BaMkxZSHJlZDZvYU14ZXZj?=
 =?big5?B?VlQ0aG1lTXJTcUE0Q3d6UVUzUjRXMnRDUGF2TGNjTXdpSUxWZ0FZeTZSNnlxM2du?=
 =?big5?B?OGFEQUJSRGxteFByODdycm9yY0d3Sys0OU9OVDBoR1F5bDlSRy9aQ0o2SjVTbDR5?=
 =?big5?B?WlM2UzRtb3F6SEF4WEVRMTc0MFRlRi8xbFdoMEFhVW4rV0o1Q0t4a281RDJLYXRC?=
 =?big5?B?eXZRandSby8wcW9aclVGZnhaS3oyQXdPODRwWGNBRlYvN1FOQmk5cy9lZll2SkEx?=
 =?big5?B?NmI4RFl2Qk9lOW0rWWdFTlFRMlpoTTZaT29zeDNrUS9xYkhPbG9wKzJUb3dYYkhk?=
 =?big5?B?cnkydnRzR09pSU5jbzljTEU3TzRjQWZUemxPRm9UYW9KMmRNQy95dVRVNGpMcm9D?=
 =?big5?B?bG16b3VkT0pvRlZCTGwvWU16Mlg0dHNhdUFlcHRZOG5IL1FYRW1VMWlNcXRrZmxh?=
 =?big5?B?cXhCa1ZPV055TkJTbzcyVSthZXo5S3lWK2RNMTJvQW1jejFTR0FkWVYvSllsWE1a?=
 =?big5?B?S25TQzVadlhJSCtDRzFUTW5oKzBYbVo1ZVhkRVlRbGRieXpEbkJERXNhMnNPRnRD?=
 =?big5?Q?xlSecarruB+gs7PqO9BFjRVUxz/RSH2SRSJcAWPcrdQXSHJO?=
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR07MB8636.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304bd6cb-4463-410b-9d97-08de762d8ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 18:25:14.3130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHZ+GJUzUNvgdtkOZynEo4Kenjve8GzHobXdOYUJtJWIUe9zjZXPT4GCdbr5DBYixBDXSlvA/aJW1JxP80AJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7313
X-Mailman-Approved-At: Fri, 27 Feb 2026 19:35:32 +0100
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

RGVhciBVLUJvb3QgTWFpbnRhaW5lcnMsDQoNCkknbSBTaW4gTGlhbmcgTGVlLCBhIG1lbWJlciBv
ZiBUZWFtIEF0bGFudGE8aHR0cHM6Ly90ZWFtLWF0bGFudGEuZ2l0aHViLmlvLz4gZnJvbSBHZW9y
Z2lhIEluc3RpdHV0ZSBvZiBUZWNobm9sb2d5LCB3aW5uZXJzIG9mIERBUlBBJ3MgQUkgQ3liZXIg
Q2hhbGxlbmdlIChBSXhDQyk8aHR0cHM6Ly9haWN5YmVyY2hhbGxlbmdlLmNvbS8+LiBXZSdyZSBy
ZWFjaGluZyBvdXQgdG8gc3VibWl0IGEgdnVsbmVyYWJpbGl0eSByZXBvcnQgdGhhdCB3ZSBpZGVu
dGlmaWVkIHVzaW5nIG91ciBzeXN0ZW0sIEFUTEFOVElTLCBpbiB5b3VyIHByb2plY3QuIFRoaXMg
ZWZmb3J0IGlzIHBhcnQgb2YgREFSUEEncyBpbml0aWF0aXZlIHRvIGFwcGx5IGNvbXBldGl0aW9u
IHRlY2hub2xvZ2llcyB0byByZWFsLXdvcmxkIG9wZW4gc291cmNlIHByb2plY3RzLg0KDQpXZSBo
YXZlIGJ1aWx0IGFuIEFJLWVuaGFuY2VkIENSUyAoQ3liZXIgUmVhc29uaW5nIFN5c3RlbSkgZm9y
IGF1dG9tYXRpYyB2dWxuZXJhYmlsaXR5IGRldGVjdGlvbiBhbmQgcmVwYWlyLiBVc2luZyBhIGNv
bWJpbmF0aW9uIG9mIHRhcmdldGVkIGZ1enppbmcgKHZpYSBPU1MtRnV6eiBpbmZyYXN0cnVjdHVy
ZSkgYW5kIEFJLWFzc2lzdGVkIHN0YXRpYyBhbmFseXNpcywgd2UgaWRlbnRpZmllZCBmb3VyIGJ1
ZmZlciBvdmVyZmxvdyB2dWxuZXJhYmlsaXRpZXMgaW4gdGhlIFUtQm9vdCBORlMgY2xpZW50IHJl
cGx5IHBhcnNlcnMgKG5ldC9uZnMtY29tbW9uLmMpLiBUaGVzZSBhZmZlY3QgdGhlIGN1cnJlbnQg
dXBzdHJlYW0gY29kZWJhc2UgYW5kIGluY2x1ZGUgYSBzaWduZWRuZXNzIGJ5cGFzcyBvZiB0aGUg
bWl0aWdhdGlvbiBpbnRyb2R1Y2VkIGZvciBDVkUtMjAxOS0xNDE5My4NClZ1bG5lcmFiaWxpdHkg
U3VtbWFyeQ0KIw0KRGVzY3JpcHRpb24NCkNXRQ0KQ1ZTUyAzLjENCjENCkludGVnZXIgc2lnbmVk
bmVzcyBieXBhc3MgaW4gbmZzX3JlYWRsaW5rX3JlcGx5KCkgYm91bmRzIGNoZWNrDQpDV0UtMTk1
DQo4LjggKEhpZ2gpDQoyDQpuZnNfcGF0aF9idWZmWzIwNDhdIG92ZXJmbG93IHZpYSBjaGFpbmVk
IHN5bWxpbmsgcmVzb2x1dGlvbg0KQ1dFLTEyMA0KOC44IChIaWdoKQ0KMw0KU3RhY2sgYnVmZmVy
IG92ZXJmbG93IGluIHJwY19yZXFfY29tbW9uKCkgdmlhIG92ZXJzaXplZCBORlMgcGF0aA0KQ1dF
LTEyMQ0KOC44IChIaWdoKQ0KNA0KRml4ZWQtc2l6ZSBPT0IgcmVhZCBpbiBuZnNfcmVhZF9yZXBs
eSgpDQpDV0UtMTI1DQo3LjEgKEhpZ2gpDQpJbXBhY3QNCg0KICAqDQpCU1MgY29ycnVwdGlvbiBl
bmFibGluZyBORlMgc2VydmVyIElQIHJlZGlyZWN0aW9uIChib290IGNoYWluIGhpamFjaykNCiAg
Kg0KU3RhY2sgYnVmZmVyIG92ZXJmbG93IHdpdGggZGVtb25zdHJhdGVkIHJldHVybiBhZGRyZXNz
IGNvbnRyb2wgKFJDRS1jYXBhYmxlLCBjb25maXJtZWQgdmlhIEdEQiBoYXJkd2FyZSB3YXRjaHBv
aW50KQ0KICAqDQpEZW5pYWwgb2YgU2VydmljZSB2aWEgT09CIHJlYWQgY3Jhc2ggb24gdW5kZXJz
aXplZCBwYWNrZXRzDQogICoNCkF0dGFjayBtb2RlbDogTWFsaWNpb3VzIE5GUyBzZXJ2ZXIgb24g
c2FtZSBMQU4gc2VnbWVudCAoQVY6QSkNCg0KUmVsYXRpb25zaGlwIHRvIFByaW9yIENWRXMNCg0K
ICAqDQpWdWxuZXJhYmlsaXR5ICMxIGV4cGxvaXRzIGEgc2lnbmVkbmVzcyBmbGF3IChDV0UtMTk1
KSBpbiB0aGUgYm91bmRzIGNoZWNrIGludHJvZHVjZWQgYnkgdGhlIENWRS0yMDE5LTE0MTkzIGZp
eCAoY29tbWl0IGNmM2E0ZjFlKS4gVGhlIHZhcmlhYmxlIHJsZW4gaXMgZGVjbGFyZWQgYXMgaW50
IChzaWduZWQpIGF0IGxpbmUgNjQ1IG9mIG5mcy1jb21tb24uYywgYnV0IHJlY2VpdmVzIGEgdWlu
dDMyX3QgZnJvbSBudG9obCgpLiBOZWdhdGl2ZSB2YWx1ZXMgYnlwYXNzIHRoZSBjaGVjayBhdCBs
aW5lIDY2OS4NCiAgKg0KVnVsbmVyYWJpbGl0eSAjMiBleHBsb2l0cyBhIG1pc3NpbmcgZGVzdGlu
YXRpb24tc2lkZSBjaGVjayB0aGF0IHRoZSBDVkUtMjAxOS0xNDE5MyBmaXggZGlkIG5vdCBhZGRy
ZXNzIKFYIHJsZW4gaXMgdmFsaWRhdGVkIGFnYWluc3QgdGhlIHNvdXJjZSBwYWNrZXQgbGVuZ3Ro
IGJ1dCBuZXZlciBhZ2FpbnN0IHNpemVvZihuZnNfcGF0aF9idWZmKS4NCiAgKg0KVnVsbmVyYWJp
bGl0aWVzICMzIGFuZCAjNCBhcmUgaW4gZGlmZmVyZW50IGZ1bmN0aW9ucyAocnBjX3JlcV9jb21t
b24gYW5kIG5mc19yZWFkX3JlcGx5KSBub3QgYWRkcmVzc2VkIGJ5IGFueSBwcmlvciBmaXguDQoN
CkRlbGl2ZXJhYmxlcw0KV2UgYXJlIHByb3ZpZGluZzoNCg0KDQogIDEuDQpTdGFuZGFsb25lIFBv
Q3MgoVggRG9ja2VyLWJhc2VkLCB6ZXJvIGV4dGVybmFsIGRlcGVuZGVuY2llcy4gRWFjaCB2dWxu
ZXJhYmlsaXR5IGhhcyBpdHMgb3duIGRpcmVjdG9yeSB3aXRoIGEgZG9ja2VyLWNvbXBvc2UueWFt
bDoNCg0KZG9ja2VyIGNvbXBvc2UgdXAgLS1idWlsZA0KDQogIDEuDQpFbmQtdG8tZW5kIGNoYWlu
IFBvQyChWCBEZW1vbnN0cmF0ZXMgdGhlIGZ1bGwgYXR0YWNrIGNoYWluOiAxMCBpdGVyYXRpb25z
IG9mIG5mc19yZWFkbGlua19yZXBseSgpIGFjY3VtdWxhdGluZyBwYXRoIGRhdGEgKDExIKH3IDE4
MTEgYnl0ZXMpLCB0aGVuIG5mc19tb3VudF9yZXEoKSCh9yBycGNfcmVxX2NvbW1vbigpIKH3IDcy
NC1ieXRlIHN0YWNrIG92ZXJmbG93LiBObyBwcmUtcG9wdWxhdGVkIHNob3J0Y3V0cy4NCiAgMi4N
CkdEQiB2ZXJpZmljYXRpb24goVggSGFyZHdhcmUgd2F0Y2hwb2ludCBwcm92aW5nIHNhdmVkIHJl
dHVybiBhZGRyZXNzIG92ZXJ3cml0dGVuIHdpdGggYXR0YWNrZXItY29udHJvbGxlZCBzeW1saW5r
IHBhdGggY29udGVudC4NCiAgMy4NClByb3Bvc2VkIHBhdGNoZXMgoVggSW5kaXZpZHVhbCBwZXIt
dnVsbmVyYWJpbGl0eSBkaWZmIGZpbGVzIGFnYWluc3QgbmV0L25mcy1jb21tb24uYywgdGVzdGVk
IHdpdGggQWRkcmVzc1Nhbml0aXplcg0KICA0Lg0KVnVsbmVyYWJpbGl0eSByZXBvcnRzIKFYIEZv
dXIgaW5kaXZpZHVhbCByZXBvcnRzIHdpdGggcm9vdCBjYXVzZSBhbmFseXNpcywgQVNhbiBvdXRw
dXQsIENWU1Mgc2NvcmluZywgYW5kIHJlY29tbWVuZGVkIGZpeGVzLg0KDQpGdWxsIFJlcG9ydCAm
IFBvQ3MNCg0KICAqDQpWdWxuZXJhYmlsaXR5IDE6IGh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9k
cml2ZS9mb2xkZXJzLzFOa1pCUGI4b0t5S1FHMGlPbHJUaTFST29JWjlzeldVQj91c3A9c2hhcmlu
Zw0KICAqDQpWdWxuZXJhYmlsaXR5IDI6DQoNCmh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9kcml2
ZS9mb2xkZXJzLzFCNGRiUE5DQ3RRRUdaaVhYVUMtejFCMEVTU3JZZjFGRT91c3A9c2hhcmluZw0K
DQogICoNClZ1bG5lcmFiaWxpdHkgMzoNCg0KaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2RyaXZl
L2ZvbGRlcnMvMXJwQ010UVNHZlZSMTVXRzJGZlpjNlpscnNVdjdjV1BFP3VzcD1zaGFyaW5nDQoN
CiAgKg0KVnVsbmVyYWJpbGl0eSA0Og0KDQpodHRwczovL2RyaXZlLmdvb2dsZS5jb20vZHJpdmUv
Zm9sZGVycy8xbFA3ekp0Y3c5QUxYQ3E1NmZuVUhtVjhxX3ZsUmR1amg/dXNwPXNoYXJpbmcNCg0K
Q291bGQgeW91IHBsZWFzZSBjb25maXJtIHRoZSB2dWxuZXJhYmlsaXRpZXMgYW5kIHJldmlldyB0
aGUgcHJvcG9zZWQgcGF0Y2hlcz8gVGhhbmsgeW91Lg0KDQpCZXN0IHJlZ2FyZHMsDQpTaW4gTGlh
bmcgTGVlDQpUZWFtIEF0bGFudGENCg==
