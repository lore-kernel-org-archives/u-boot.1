Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578D2EB1052
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 11:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C0683F2A;
	Tue, 10 Mar 2026 12:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="waaEavz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5988E83FA7; Tue, 10 Mar 2026 12:45:59 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A6883981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXI+D6kOffzglmpf1ovJoZ7ZcRa5qZYiWBvxe4wMzz2ypEY0Okl+/UyRZh74Je0vZDz5j32x/d6t5MeKWFxgdf9FsyGNcPJ+YoQu3/AD1nBwfDm+6vfOp0qN8so+S5GwqynyzheApUlI3o3kAJxWe580wbbXOaZf08by1bZYSnEpFLjfu4JEIN2+nATcRwxfjxs04dyrq+cCgG/X240E1oOBia/y1DsGDbC61Gq7LStPVYAMxa9mll8R/Cxpq9txDEIrJGZ0++dQjdOPKtKbxiSKXZMGZGqoDBfrNG6vBhsf7YDjQNeFdudB4FRk/jPds/3Ur6EVc5mncOxSh5Bo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAcv+SIGxELcK51vqiaukB8OX3bh5QzMxF7OXXcGxJw=;
 b=hcmW6ARG59QJzgoepOw4aPeaUtFi4iRKM8bfkDUpbVxrtXhRRMz8KV29yB4GDhbzsXF4j4xGBMRPvzZ/wCp/CLT/Ew4Tl/sUbvywwvZLuyeCMz6O3ss6EXkLQEz3zbAk7goeUjFYIHzNR5fuyNNH0YlVXHAui7o0WbmRLVwgIYGf/SOFlbaxdpC7g130awgvVTPIO78ZJVktcLxKoRWSK24yccxR9PjoQ+yiRKu9HArK9bZeicLOGSBOomvJurzzTJJBErQhbBqtH7Dnc7Wud9tXN87LpVBELDhomyMor0TLZR/EcHm7dAj69p+qlO3VBqZM0D7zhYQ1SHn7Q6exug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAcv+SIGxELcK51vqiaukB8OX3bh5QzMxF7OXXcGxJw=;
 b=waaEavz8HXZSL7SfQ/+OdCRBM2lIQ7wni2U45ZdQ06g7kpFQ9LfJgpimfoe3Sv4EwHda7T/fe9X3StQej9PAorvJd17VjXaWt9EiH4jvDRoCRdd9WJkhmGY20G2n4fmzkcMZ8rfIrXMR1SqcADMnSXr30Eu4HCbR/zCy6rqn+Uk=
Received: from MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:45:49 +0000
Received: from MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049]) by MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:45:49 +0000
From: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier
 <jerome.forissier@arm.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek, Michal"
 <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>, "Begari, Padmarao"
 <Padmarao.Begari@amd.com>, Tom Rini <trini@konsulko.com>, "nd@arm.com"
 <nd@arm.com>
Subject: RE: [PATCH] net: lwip: scale buffer pool size with TFTP block size
Thread-Topic: [PATCH] net: lwip: scale buffer pool size with TFTP block size
Thread-Index: AQHcrGserHaJY6kj4UqnErnQGLOUGrWl3tEAgABM2HCAAJBTAIAA4Z4Q
Date: Tue, 10 Mar 2026 11:45:48 +0000
Message-ID: <MW6PR12MB7088B615B7E686BCEFCC0B7DFB46A@MW6PR12MB7088.namprd12.prod.outlook.com>
References: <20260305064033.8726-1-pranav.vinaytilak@amd.com>
 <a3262e83-95dd-46fe-a0cf-fd6d7e429ab1@arm.com>
 <PH0PR12MB70963209D076B0D27A12FFDFFB79A@PH0PR12MB7096.namprd12.prod.outlook.com>
 <25eb3b47-976e-41ff-b51d-fc828314e200@kwiboo.se>
In-Reply-To: <25eb3b47-976e-41ff-b51d-fc828314e200@kwiboo.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-10T11:43:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7088:EE_|DS5PPF2FA070BDF:EE_
x-ms-office365-filtering-correlation-id: 61484013-1f22-4af5-e55f-08de7e9a9300
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 7SvRsM2NDmsyWdz8dBVMN+HDjpysmGP3w6yKGLZ1iyd6QrAcEv3RQsxzDy2IeDc6JBUgzdL0sSeLOtXEkd1oUdmW9sxG9bQjlYh/CWzOnF7zLVbubnPlFnHwBzMNXDLWqncixQWeghBppJPEKTnTNBjt8Qm14snyP//6tLananrn11DRdegdUgBu4B1vGfkh0PJf51UfungguXBww/cZZnzBaCmFC0Jf0RPag37SjhGwrf2hTYBBhhv/atZgw7z6r8ZBXyYy/Px+VQUR4Mf6jhr2MMSza2jtemFy8kRz2DtuE3E0fdaqXtCsEgxTqarNHnwbzVTiUF48XsOKmu+MdmSEq0sZoNlZG9BMV6Cr4sf1e2GABVvyv1Ij39YRlmD72ijrEwuCxaZs9ULUX1H8hW7NnNXREmfvaH8m7vZqEbmGY4jjaJF7xE602B/SMmoqo4EZeQnDZIxR6cLQT6v6xzwfmrjSl1xyHUKwf5+IOoEhXJoqfsVQfdueVPCRiGqfZuvi+dIjup5mKAJN5UvafRjlffmD8QdVlCjtnzarfiCxYsm/H3YymdWfNIwv+zwWTkkss6J9FLKvCgooPUSbGYjjg4ftw9mX6V/QLJRPTjBb4UFTRlqNMflrUd7J8WLYK9ktYRTmyRwi3s/BJzaYi6ZKF6BMEAQock5YGN3NCPDlKz8P02XJFkKozkbHreNnG5rloM0+j2GSjZ8IZFYHNRqIR9jc9qU3he/6bbd3ZOp4DLFrxiOKikFz6Slf9xSnK+aqMtBqcCsCKsFQsELoAqNS5FQ3I+RrYttzjoN3Nb4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7088.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZvd0xJY0lWNmpVOXE0bnl3ZTBpY21iSjFKRHUvTzJ6LytrY0pnYnZQdjF1?=
 =?utf-8?B?OURaM1F4emhjWUN5K0xWVWhpQWthT0pzOGlyOXdNV2dFbjRxbTdoSSt5d3RC?=
 =?utf-8?B?THNQeU9uYlFNSVdZMjVlMjBJakZVQXBseTAxY21kT3FvektGbDRDSThEeEUy?=
 =?utf-8?B?K3BhejhEMTB3c1BucTJyUDFJTUJTTmk1YVlVNkozSERsTmJiVjVxSURVRlNS?=
 =?utf-8?B?emJOUjVyRUs3TnNPd0pQYXFZcG5nV3hZMVRqdEVUK3hjRWNIcTFBeFBGNXp4?=
 =?utf-8?B?bFRYVkNiU1NkQXdORDNPZW5QUFUxc242T29mQ2N6bUV4S2h1OElqVVZ2bG1J?=
 =?utf-8?B?YWpSMXh6cEtLbHRiWDV5UEhCTmdtQ0VSc1pEMWZkNm9objZadlpWaDlrVWJz?=
 =?utf-8?B?Y3Y1UnRyTDRjZ3haUmx5YUJCMlFpd2hPY1U3WGdMNVYwSVQ2RDBFUEQ3eXZX?=
 =?utf-8?B?dndQajlPRjhDWktZMER0SUE0WEYvbUx3YlZNaE1NaHNqWVpIODRrYmpvOXFp?=
 =?utf-8?B?b2VTUm5JUTh6K01qbGlHNnJ1ZHBHeHBpVzRjbnFKd0lsTVk2REIyTU5jZVl4?=
 =?utf-8?B?SHhsME5lSW55VGlJeTdCM2VpNTJUVS9DR0dqZFlWMTZqSUZsNFRpSkZKanhE?=
 =?utf-8?B?OStxVmRnZldCY1dvZzllazdzNDRvcEJtQ0l2bFZJMTBtUXhiTnM5cGxud1hn?=
 =?utf-8?B?bTcyK0tyc2NXTHFJRmpUNjdoaGlwVEE5RWtjNWg2aUFWTDNrNjJiQi8rNVJU?=
 =?utf-8?B?ejB5YzQzSGdLSmg4VlJIZ3IxYzdDVkVqVGtnbEo2T1ZjUDlVYW9IVUYxQVdX?=
 =?utf-8?B?ZitrcHhBUExTSnNTOHlETG0zcWxBaVdDenpuRVE3SUxHeE56QjBOWkRCUXRD?=
 =?utf-8?B?ZE84WUtlS0o3RDMzbkRjanVMN2lONnc2aGlETXVRUmlGQThibnR4S2loMStH?=
 =?utf-8?B?OFpiUHFObDUvTFZGMlJmem5nV3hic3N2bERIbXpaYldqMnkwRGg3TmV1RUZw?=
 =?utf-8?B?RmJLRGRzUFB3Ry9jbDFtUmlscWZ6Lzg1RGNsdW5kMjYvL2JUMk1BZkJVVCtP?=
 =?utf-8?B?cnQ1aTNTMmp0azNNZXFOUDZUZitjVzN0RENYRnFZU1pYbTlKOXBEdFVkWFVE?=
 =?utf-8?B?VTJnM0VCSGM3N2RGQ3ZTWjZ4NExvY0RQOGh1WU9GL3Y5NWZyazR6MUdObUMr?=
 =?utf-8?B?ek5xYmpURDNEME4vRGFjbnpaZ0lNakZnNUQ5V3BmbnRucXFZV1NKYmlydTJH?=
 =?utf-8?B?R3RXeGdGVkxoUnpaa1FzcGhRVG8rOHdxRXQ1S3hwVGhtWk9Ed1lyQnVVa2Ev?=
 =?utf-8?B?Z2JrZ0VvckgzYmR0bnFJNXVSb2prek5PZE11aUJnWkM1UVR1eGtrc3l3bENw?=
 =?utf-8?B?Y0hiVGRLc0thc2t3bFZwT04rcTZubkJwaEplamVNNDZ4SDVHS0tpNHdrcWVa?=
 =?utf-8?B?NS8yMzVVRjBEK0V2RTJhbHpXVU5lOGlBRTluMmRGMVE3MEM3cjFMZnZGRVlT?=
 =?utf-8?B?N05HMW10emxlNXBCVVlpWU5YeWZXcHZZVFpHb3k3cU9VQytIMnBBT0UzbS8x?=
 =?utf-8?B?U2srbGM2V29IZ001VXlPRmxCYVpVOUVxY2l1cytXTUg5MG5GM09yWGpUS1h2?=
 =?utf-8?B?emhtaTF6bDE3UXduVHVBY3pYRDR0K0lXSTk5WGhlZ2dEWGlFb2FZSThZSll4?=
 =?utf-8?B?NXY2UVBqNDF3T2lxTUtvTWFyNTRQcEl6VFZZZ29wZGpQYzBDR3ROdlhJNUxi?=
 =?utf-8?B?N2FOeG5FUHFOeUNhVTUzeVFiK09WZ0IzNXhoNGx6NndzUEsvOFJmUEVTL25V?=
 =?utf-8?B?VHNlWmpRUlJQSjh1RXNEQVZGT0lTWURqWU5MZXRESTVvNXF6RWduN0JyTDQ0?=
 =?utf-8?B?cERRL2UyWGpRNTM5eFBvNk5udFZ6eUtiVGtlOHh0WlpTS3JRZnpHczdoYWtj?=
 =?utf-8?B?Z2V1MFVwNjJhdWpBRDk3MitjQXZJTDVRbm9GMEhtTk1Mb2RzQk9uUElZd2ta?=
 =?utf-8?B?VWorM01kcW95dGM0a3hOWHBnT0N6SVZ0RWJjMGZDNUcwWU10bW4xOFVqTW9j?=
 =?utf-8?B?TXhpNFFyeVpZZjExU3BqdGswZUNaSHlSQnV5UmYyZVMrYTlDam1iUmRXdXMy?=
 =?utf-8?B?Y1BqT2t3dHJWaCsyK3VvOGszZllrZVR5eVdCdk5OVDB0cVRQYTR4MWhRQ2Rz?=
 =?utf-8?B?eTdOYzBSZkMvOUc3cXlpTE1BbDJuT3RhVFZQNmJwdkMwc0FRTFhXNHJWc2or?=
 =?utf-8?B?TnZUUXd5TWYxQUFLZGZ6c003U01jdjh6d1pWb1o4KzEybVhXTWkzamFnZFda?=
 =?utf-8?Q?K+JzjAgrgqG6ZdI9g4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61484013-1f22-4af5-e55f-08de7e9a9300
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 11:45:48.9472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkwLRC13STSmVvOdiFWFXNU9ac66e36gBu6SZJPWsXn4NEvm3CuUUjxXXWNz9NmgykcdXrseIOcvqxweAzbrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
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

W1B1YmxpY10NCg0KSGkgSm9uYXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogSm9uYXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNlPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXJjaCAxMCwgMjAyNiAyOjQ5IEFNDQo+IFRvOiBWaW5heSBUaWxhaywgUHJhbmF2IDxQcmFuYXYu
VmluYXlUaWxha0BhbWQuY29tPjsgSmVyb21lIEZvcmlzc2llcg0KPiA8amVyb21lLmZvcmlzc2ll
ckBhcm0uY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IFNpbWVrLCBNaWNoYWwgPG1p
Y2hhbC5zaW1la0BhbWQuY29tPjsgZ2l0DQo+IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBC
ZWdhcmksIFBhZG1hcmFvDQo+IDxQYWRtYXJhby5CZWdhcmlAYW1kLmNvbT47IFRvbSBSaW5pIDx0
cmluaUBrb25zdWxrby5jb20+Ow0KPiBuZEBhcm0uY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IG5ldDogbHdpcDogc2NhbGUgYnVmZmVyIHBvb2wgc2l6ZSB3aXRoIFRGVFAgYmxvY2sgc2l6ZQ0K
Pg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNv
dXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xp
Y2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IEhpLA0KPg0KPiBPbiAzLzkvMjAy
NiAyOjE5IFBNLCBWaW5heSBUaWxhaywgUHJhbmF2IHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4N
Cj4gPiBIaSBKZXJvbWUsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogSmVyb21lIEZvcmlzc2llciA8amVyb21lLmZvcmlzc2llckBhcm0uY29tPg0KPiA+
PiBTZW50OiBNb25kYXksIE1hcmNoIDksIDIwMjYgMTozOCBQTQ0KPiA+PiBUbzogVmluYXkgVGls
YWssIFByYW5hdiA8UHJhbmF2LlZpbmF5VGlsYWtAYW1kLmNvbT47DQo+ID4+IHUtYm9vdEBsaXN0
cy5kZW54LmRlOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gPj4gQ2M6
IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsgQmVnYXJpLCBQYWRtYXJhbw0KPiA+PiA8
UGFkbWFyYW8uQmVnYXJpQGFtZC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsN
Cj4gbmRAYXJtLmNvbQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQ6IGx3aXA6IHNjYWxl
IGJ1ZmZlciBwb29sIHNpemUgd2l0aCBURlRQDQo+ID4+IGJsb2NrIHNpemUNCj4gPj4NCj4gPj4g
Q2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2Uu
IFVzZSBwcm9wZXINCj4gPj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPiA+Pg0KPiA+Pg0KPiA+PiBIaSBQcmFuYXYsDQo+
ID4+DQo+ID4+IE9uIDA1LzAzLzIwMjYgMDc6NDAsIFByYW5hdiBUaWxhayB3cm90ZToNCj4gPj4+
IFRGVFAgdHJhbnNmZXJzIGZhaWwgd2hlbiB0ZnRwYmxvY2tzaXplIGlzIHNldCB0byA4MTkyIG9y
IGxhcmdlciBkdWUNCj4gPj4+IHRvIGluc3VmZmljaWVudCBidWZmZXIgcmVzb3VyY2VzIGZvciBJ
UCBmcmFnbWVudCByZWFzc2VtYmx5Lg0KPiA+Pj4NCj4gPj4+IEFkanVzdCBQQlVGX1BPT0xfU0la
RSBhbmQgSVBfUkVBU1NfTUFYX1BCVUZTIGJhc2VkIG9uDQo+ID4+PiBDT05GSUdfVEZUUF9CTE9D
S1NJWkUgdG8gc3VwcG9ydCBsYXJnZXIgVEZUUCB0cmFuc2ZlcnMgd2hpbGUga2VlcGluZw0KPiA+
Pj4gbWVtb3J5IHVzYWdlIGVmZmljaWVudC4NCj4gPj4+DQo+ID4+PiAtIENPTkZJR19URlRQX0JM
T0NLU0laRSA+PSAxMjI4ODpQQlVGX1BPT0xfU0laRT0xOCwNCj4gPj4+IElQX1JFQVNTX01BWF9Q
QlVGUz0xMg0KPiA+Pj4NCj4gPj4+IC0gQ09ORklHX1RGVFBfQkxPQ0tTSVpFID49IDgxOTI6UEJV
Rl9QT09MX1NJWkU9MTIsDQo+ID4+PiBJUF9SRUFTU19NQVhfUEJVRlM9Ng0KPiA+Pj4NCj4gPj4+
IC0gQ09ORklHX1RGVFBfQkxPQ0tTSVpFIHVuZGVmaW5lZDogUEJVRl9QT09MX1NJWkU9OCwNCj4g
Pj4+IElQX1JFQVNTX01BWF9QQlVGUz00DQo+ID4+DQo+ID4+IEhvdyBhcmUgdGhlc2UgdmFsdWVz
IGNvbXB1dGVkPyBDb3VsZCB5b3UgZmluZCBhIGZvcm11bGEgaW5zdGVhZCBvZg0KPiA+PiB1c2lu
ZyAjaWYvI2VsaWYvI2Vsc2UvZW5kaWY/DQo+ID4NCj4gPiBXZSBjYW4gdXNlIHRoaXMgZm9ybXVs
YSBmb3IgY2FsY3VsYXRpbmcgdGhlIHZhbHVlcyBvZiBQQlVGX1BPT0xfU0laRSBhbmQNCj4gSVBf
UkVBU1NfTUFYX1BCVUZTLg0KPiA+IDE1MDAgKE1UVSkgLSAyMCAoSVAgaGVhZGVyKSA9IDE0ODAg
dXNhYmxlIGJ5dGVzL2ZyYWdtZW50cy4NCj4gPiBJUF9SRUFTU19NQVhfUEJVRlMgPSAoKChDT05G
SUdfVEZUUF9CTE9DS1NJWkUpICsgMTQ3OSkgLyAxNDgwKSArIDINCj4gPiBbY2VpbGluZyBkaXZp
c2lvbiB0byBjYWxjdWxhdGUgZnJhZ21lbnQgY291bnQgKyBzb21lIGhlYWRyb29tIGZvciBuZXh0
DQo+IGJsb2NrIHN5bmNdLg0KPiA+IFBCVUZfUE9PTF9TSVpFID0gKElQX1JFQVNTX01BWF9QQlVG
UykgKiAyIFtSZWFzc2VtYmx5IGJ1ZmZlcnMgKiAyXS4NCj4NCj4gVGhlIGx3aXAgY29tbWVudCBm
b3IgSVBfUkVBU1NfTUFYX1BCVUZTIG9ubHkgc3VnZ2VzdCBQQlVGX1BPT0xfU0laRQ0KPiBpcyBt
b3JlIHRoYW4gMnggSVBfUkVBU1NfTUFYX1BCVUZTIHdoZW4gYm90aCBJUHY0IGFuZCBJUHY2IGlz
IGVuYWJsZWQuDQo+DQo+IE1heWJlIHNvbWV0aGluZyBsaWtlIGZvbGxvd2luZyBzaG91bGQgd29y
az8NCj4NCj4gICAjaWYgZGVmaW5lZChDT05GSUdfVEZUUF9CTE9DS1NJWkUpICYmIENPTkZJR19U
RlRQX0JMT0NLU0laRSA+IDQwOTYNCj4gICAjZGVmaW5lIFBCVUZfUE9PTF9TSVpFICAgICAgICAg
ICAgICAgICAgKCgoQ09ORklHX1RGVFBfQkxPQ0tTSVpFICsgMTQ3OSkgLw0KPiAxNDgwKSArIDYp
DQo+ICAgI2Vsc2UNCj4gICBbLi4uXQ0KPiAgICNkZWZpbmUgSVBfUkVBU1NfTUFYX1BCVUZTICAg
ICAgICAgICAgICAoUEJVRl9QT09MX1NJWkUgLSA0KQ0KPg0KDQpZZXMgd2UgY2FuIGltcGxlbWVu
dCBpdCBpbiB0aGlzIHdheS4NCldpbGwgc2VuZCB2MiBwYXRjaCBtYWtpbmcgdGhlc2UgY2hhbmdl
cy4NCg0KVGhhbmtzLA0KUHJhbmF2IFRpbGFrDQoNCj4gVGhhdCBzZWVtIHRvIHdvcmsgZ3JlYXQg
d2hlbiBJIHRlc3Qgd2l0aCBURlRQX0JMT0NLU0laRT0xNjM1MiBvbiBteQ0KPiBSb2NrY2hpcCBi
b2FyZHMgdG9nZXRoZXIgd2l0aCBhIFBCVUZfUE9PTF9CVUZTSVpFIGZpeCBbMV0uDQo+DQo+IFsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy91LWJvb3QvMjAyNjAzMDkyMTA2NDIuNTIyNjI2LTEt
DQo+IGpvbmFzQGt3aWJvby5zZS8NCj4NCj4gUmVnYXJkcywNCj4gSm9uYXMNCj4NCj4gPg0KPiA+
IFdlIGNhbiBzY2FsZSBvbmx5IGlmIENPTkZJR19URlRQX0JMT0NLU0laRSA+IDQwOTYgZWxzZSB1
c2UgdGhlIGRlZmF1bHQNCj4gdmFsdWVzLg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IC0tDQo+
ID4+IEplcm9tZQ0KPiA+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUHJhbmF2IFRpbGFrIDxwcmFu
YXYudmluYXl0aWxha0BhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgbGliL2x3aXAvdS1ib290
L2x3aXBvcHRzLmggfCAxNSArKysrKysrKysrKysrKysNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9saWIvbHdpcC91LWJv
b3QvbHdpcG9wdHMuaCBiL2xpYi9sd2lwL3UtYm9vdC9sd2lwb3B0cy5oDQo+ID4+PiBpbmRleCBl
OGEyYzlkN2EwYS4uYjRmZjMxMDk2ZmUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9saWIvbHdpcC91LWJv
b3QvbHdpcG9wdHMuaA0KPiA+Pj4gKysrIGIvbGliL2x3aXAvdS1ib290L2x3aXBvcHRzLmgNCj4g
Pj4+IEBAIC02NSw3ICs2NSwxNCBAQA0KPiA+Pj4gICNkZWZpbmUgTUVNX0FMSUdOTUVOVCAgICAg
ICAgICAgICAgICAgICA4DQo+ID4+Pg0KPiA+Pj4gICNkZWZpbmUgTUVNUF9OVU1fVENQX1NFRyAg
ICAgICAgICAgICAgICAxNg0KPiA+Pj4gKw0KPiA+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19URlRQ
X0JMT0NLU0laRSkgJiYgQ09ORklHX1RGVFBfQkxPQ0tTSVpFID49DQo+ID4+IDEyMjg4DQo+ID4+
PiArI2RlZmluZSBQQlVGX1BPT0xfU0laRSAgICAgICAgICAgICAgICAgIDE4DQo+ID4+PiArI2Vs
aWYgZGVmaW5lZChDT05GSUdfVEZUUF9CTE9DS1NJWkUpICYmIENPTkZJR19URlRQX0JMT0NLU0la
RQ0KPiA+PQ0KPiA+PiA4MTkyDQo+ID4+PiArI2RlZmluZSBQQlVGX1BPT0xfU0laRSAgICAgICAg
ICAgICAgICAgIDEyDQo+ID4+PiArI2Vsc2UNCj4gPj4+ICAjZGVmaW5lIFBCVUZfUE9PTF9TSVpF
ICAgICAgICAgICAgICAgICAgOA0KPiA+Pj4gKyNlbmRpZg0KPiA+Pj4NCj4gPj4+ICAjZGVmaW5l
IExXSVBfQVJQICAgICAgICAgICAgICAgICAgICAgICAgMQ0KPiA+Pj4gICNkZWZpbmUgQVJQX1RB
QkxFX1NJWkUgICAgICAgICAgICAgICAgICA0DQo+ID4+PiBAQCAtNzYsNyArODMsMTUgQEANCj4g
Pj4+ICAjZGVmaW5lIElQX1JFQVNTRU1CTFkgICAgICAgICAgICAgICAgICAgMQ0KPiA+Pj4gICNk
ZWZpbmUgSVBfRlJBRyAgICAgICAgICAgICAgICAgICAgICAgICAxDQo+ID4+PiAgI2RlZmluZSBJ
UF9SRUFTU19NQVhBR0UgICAgICAgICAgICAgICAgIDMNCj4gPj4+ICsNCj4gPj4+ICsjaWYgZGVm
aW5lZChDT05GSUdfVEZUUF9CTE9DS1NJWkUpICYmIENPTkZJR19URlRQX0JMT0NLU0laRSA+PQ0K
PiA+PiAxMjI4OA0KPiA+Pj4gKyNkZWZpbmUgSVBfUkVBU1NfTUFYX1BCVUZTICAgICAgICAgICAg
ICAxMg0KPiA+Pj4gKyNlbGlmIGRlZmluZWQoQ09ORklHX1RGVFBfQkxPQ0tTSVpFKSAmJiBDT05G
SUdfVEZUUF9CTE9DS1NJWkUNCj4gPj0NCj4gPj4gODE5Mg0KPiA+Pj4gKyNkZWZpbmUgSVBfUkVB
U1NfTUFYX1BCVUZTICAgICAgICAgICAgICA2DQo+ID4+PiArI2Vsc2UNCj4gPj4+ICAjZGVmaW5l
IElQX1JFQVNTX01BWF9QQlVGUyAgICAgICAgICAgICAgNA0KPiA+Pj4gKyNlbmRpZg0KPiA+Pj4g
Kw0KPiA+Pj4gICNkZWZpbmUgSVBfRlJBR19VU0VTX1NUQVRJQ19CVUYgICAgICAgICAwDQo+ID4+
Pg0KPiA+Pj4gICNkZWZpbmUgSVBfREVGQVVMVF9UVEwgICAgICAgICAgICAgICAgICAyNTUNCj4g
Pg0KPiA+IFRoYW5rcywNCj4gPiBQcmFuYXYgVGlsYWsNCg0K
