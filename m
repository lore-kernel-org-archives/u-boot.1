Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A15CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EAD8484C;
	Tue, 16 Jun 2026 14:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fX2LmFT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EB784895; Tue, 16 Jun 2026 14:50:50 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B05A846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyH9cTpQ9G8p9f/XWFuwLatV0GNHdCjAMEEPe13TfHtPtfGL4DyLFgN4bOrv5Dm5DqRy+KEZDJQ0eNqas6T1nyRnmrjmiYxawsP/LZHSFFru116Ew3gvy9fLxFIQtSSkZc6Wb6QXNHTXGKzOMnzZnk4XPZ0qDcIUqmp+/7EQD5SSEpXVENqd/iG/6uUHJCtIKPTududhD/8hVnhat0YERyomRYMqYBkmqLdCRf2t7T6DDetO6TrUqSg9KV3zL+Ah8rS+6jUTn7003kT0dNSld0PogqAiQrG/AWU/iCm8fS0gdVx2bM1RTf0OvFA2tYUXXkTlMvZ2s79DuseE8dr0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9uCY08g8sHQGKEoF0/623GKYIIP88Ijkn6K/J2i7bs=;
 b=I2JbFLc53NKeoQbEtjW+/jdIXU61TuPjw0xtocpF1Mc4HiuzwOd/uNg45lHAjmFon7fyaDkKJP+ENcQoyKQp2li+jHdnZsZB7jKyV+tYGMmuvdFtzcLSDP5U/HraeA5NzOShGRpvV+QMqm9B8U0UkV2WpyJVFkgwynEoXvI1BJljmCoH3VVdkcBKjwRoj0EoazUmT9RuEkC7db/ttEOeJVk3D9ByLRSJ9NGR2UVIciBaPNBBRlJuEOWPXFYfoIcwdfOQJo6mbgQ4SzKlOk3hxZM/IH8vpRERoDoYc/ylgeXveOiwL1pr14BZaCvD9FRaoM1XaTg7114UX8bblitODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9uCY08g8sHQGKEoF0/623GKYIIP88Ijkn6K/J2i7bs=;
 b=fX2LmFT/G+C1C6gTUmS5+SP5JQvYy++S/kj64v4AOGS1zHZa+8mFT6xt4jIvO06VX3ocApfhpTuW+5/MiOXOdnhbyDMwT01AxHP9iG6eFjWMjlBZTqhPb2c53RHDBypROHVT+crRvPV9xyIzpZ7Nuy9GmJZ/PWGholDWkJh/ygE=
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:50:44 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::58) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:50:42 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:50:26 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:50:26 -0500
Received: from DFLE204.ent.ti.com ([fe80::7070:5561:87ec:432d]) by
 DFLE204.ent.ti.com ([fe80::7070:5561:87ec:432d%11]) with mapi id
 15.02.2562.037; Tue, 16 Jun 2026 07:50:26 -0500
From: "Mahaveer, Vishal" <vishalm@ti.com>
To: "Brattlof, Bryan" <bb@ti.com>, Wadim Egorov <w.egorov@phytec.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Anshul <anshuld@ti.com>
Subject: RE: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias
 from 3 to 1
Thread-Topic: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias
 from 3 to 1
Thread-Index: AQHc9SLuHmPlRfX5q0ODpFuO58ewq7ZBbCCAgAAThYD//7M5IA==
Date: Tue, 16 Jun 2026 12:50:25 +0000
Message-ID: <9821d27c7c7944368b724fe2b8c809ad@ti.com>
References: <20260605193829.395161-1-vishalm@ti.com>
 <20260605193829.395161-2-vishalm@ti.com>
 <b5ff80b6-d40e-42b0-a8a5-99f72e61aaa6@phytec.de>
 <20260616122417.olghe5g5hksmxoud@bryanbrattlof.com>
In-Reply-To: <20260616122417.olghe5g5hksmxoud@bryanbrattlof.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.247.75.170]
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS7PR10MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f6191b-8b3a-4551-62fb-08decba5e026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BpiXEoqjahnnF4HTWJarE0G7JAziOqshfuVtM5OI77suzhYBtHLhlrBNWfYYMDlG08Z2+9LN7Utg/6jFB1/CQPvZNW6LJV7XudKtLEoDMO52HSKHDMNK5PA1p5w5Ap2cNLhDm50qc2wlib+DwdC3/JYM47YUXgXpydwHLuolExb1uR62yAJuRzBfIc1J0qxhV1ofGsvtfRjmlhghJnrWn6eg7sb69n2K/EXrAFD6rKOx+uG8mGPpTkXq2r3xILNaiEiwUA3/uxLW8RNNvd2A5K0MOfbwIS4ie1GFT8frDi527pJhVpQlumLBZNDK2bJ4nLKgnWU6qz82jIjiAb5FlI8Lk1+x4/bV7+s3T4T2emvuwfNjqX/74D9jfxoY8MSun3fL7g0Vwguos4n6iWhzKBzEjjwWA8pZ3Av87zHysXZ+FyDQuVNBv81oZ0D8eR+Ze/hLV7Tw8hsgCqJNcKZIFz2d4qAff0Zl9LvkJ7aOxSk+DnfDx7WszrLtXH4z4I+nDjrpdZxip1l+kaYsMhvWU+uzNV6IcGaNavVexQTUJG5Tvbvquo7oKstyfjPU4uQx9NYbqCOIzZ2VI92ikw39PkG9hoGaS+PQnLzqGjDn3L/v7rsEjG8t8DARhSEyoR2SQhff6PsuyjcCBou/Mqvyw6mwP1bxyngRQK5b3xk46NIUjfk0j/I9SUBe9TRfFoJFwMy8AfhgGeFY8Xdya9wpewPUw0Xn7rIUVxjvVe+naV0=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4wEftmgz7c6xbi8bGm0umGXYSPzV+MciIWDB/oz+GIlsYn8/VQ/QuSPRlXXRuyV++wHOrjcWb2kXmUXDYjk1hGTV8pV6Nk98Vuwaliv96fWl1/r/GMjV48Pj71qG+f4Cc8fO5JjKwBD71GocsXe9uFKIXb7UjPwDFEWwPU5Gd4QBfbso0XGFNPWDVxjPfnUl13XYYdoVC5Xe3uIEd9JrBKr/JC6jjh7aRf8svjNVuP2NJ+3gCN8TkFSYO4X/wj4PIPVeEkQrbOpJ4D4ovN+Atvqh5UjITOfkQ9o2sOVATEPaFYQTKEMhC3f2WzUbKLCsXA6Hav/TAoUANIFhMVaIS0jJXSbvDxeVZ4YzLqn9+cx5vSXD0XNkHeVd/eccGEqZBxapOngPMAnDo9Djh2H7vunJd8GoJ9Hctvio6XVpbJNoGR2X8RKbDTgwaAgl2KSs
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:50:42.2629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f6191b-8b3a-4551-62fb-08decba5e026
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
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

PiBPbiBKdW5lIDE2LCAyMDI2IHRodXMgc2F5ZXRoIFdhZGltIEVnb3JvdjoNCj4gPiBIaSwNCj4g
Pg0KPiA+IE9uIDYvNS8yNiA5OjM4IFBNLCBWaXNoYWwgTWFoYXZlZXIgd3JvdGU6DQo+ID4gPiBU
aGUgdXBzdHJlYW0gZGV2aWNlIHRyZWUgY2hhbmdlZCB0aGUgc2VyaWFsIGFsaWFzIGZvciBNQUlO
IFVBUlQxDQo+ID4gPiBmcm9tDQo+ID4NCj4gPiB1cHN0cmVhbSB3aGVyZT8gQ2FuIHlvdSBwb2lu
dCBtZSB0byB0aGUgcmVsYXRlZCBjaGFuZ2U/DQo+ID4NCg0KRHVyaW5nIHNvbWUgY2xlYW51cCwg
dGhlIGFsaWFzZXMgY2hhbmdlZCBhbmQgdGhlIGNvZGUgd2FzIG91dCBvZiBzeW5jLg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwNDE0MDczMzI4LjM4MTMzNi0xMS1ubUB0aS5jb20v
DQoNCj4gDQo+IEhtbSBhIHF1aWNrIHNjYW4gdGhyb3VnaCB0aGUgaGlzdG9yeSBub3RoaW5nIHNl
ZW1zIHRvIGJlIHN0YW5kaW5nIG91dC4NCj4gU2VyaWFsMSBsb29rcyB0byBoYXZlIGFsd2F5cyBi
ZWVuIHdoZXJlIERNU0MgcHV0IGl0cyB0cmFjZXMuIEkgd29uZGVyIGlmDQo+IHRoaXMgd2FzIGV2
ZXIgd29ya2luZy4NCg0KSXQncyB0cnVlIHRoYXQgaXQgbWF5IGhhdmUgYmVlbiBicm9rZW4gZm9y
IGEgbG9uZ2VyIHBlcmlvZCBvZiB0aW1lLg0KDQoNCj4gDQo+IEknbGwgdHJ5IHRvIHNlZSBpZiBv
bGRlciB2ZXJzaW9ucyB3b3JrZWQgYnV0IEknbSB0aGlua2luZyB3ZSBtYXkgbmVlZDoNCj4gDQo+
ICAgIEZpeGVzOiBkMmVkYWJmYThkZTUgKCJhcm06IG1hY2gtazM6IGFtNjQyOiBMb2FkIFNZU0ZX
IGJpbmFyeSBhbmQgY29uZmlnDQo+IGZyb20gYm9vdCBtZWRpYSIpDQo+IA0KPiB+QnJ5YW4NCg==
