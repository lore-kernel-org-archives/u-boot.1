Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3CAC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 05:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17C9840607;
	Mon, 27 Jul 2026 05:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wes26H24qY0p; Mon, 27 Jul 2026 05:49:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F06C405C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785131354;
	bh=e5muBUUJrtYGWojStwEUuvifl4Cm++cR4wjdBMRfY7w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3RDhW+SbKAvTUhMNZlOYNG7EbdKKx5j5FSZV+LTN/4JhxfDyn4EsyPdZV92ZLRNJ
	 +LezKjkIWa2Sy6euZIfqDkS3/2CClaSbIc+OWx1OnQV6HAinMMZX8qzaL161YX/W+y
	 3upYjX4/tffPjVBCqadZ++lFxlnXpeYXiQSlsSrweGehxwySVtor3K84eqVRhdgVWl
	 GqPhB0toD0Y0NmGchdZzSua0KH7HWNZfim6gVb82GcqdMRkKfhdfsBycFq3MJmuHSg
	 sCXIVBR6BOefhk7ogFHVdHdpdMSt+tuGsCmc6wwZTRVel+vx8nCqFakSc1MZKkR6CD
	 +vlTOo4MHQ0lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F06C405C0;
	Mon, 27 Jul 2026 05:49:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1B9239E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 05:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A674F80C9D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 05:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYYnOaK1I3LF for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 05:49:12 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=y.moog@phytec.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8F9DB80C94
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F9DB80C94
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F9DB80C94
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 05:49:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722F082991; Mon, 27 Jul 2026 07:49:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B5582991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 07:49:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5wi1nQ7hBZXjrOVBNZ+EPQJqGOuSEQXxQ9nqZWdIfQtsvNUnxLd8tGXfqV6811fysZdI/YwpnPPVkc10knLrMLX2yHbwVKSYL2YIutWG+2ep1i3n3Jzxo/zMX/z1I/qNWS3tVdLNWzlKDNF5kVSOkvpuM5C2fyAK9PuZ1VfVnpDlTQBRq1dhYFsyEJFIWJRc1FOBqQW8BiiwFa287BDePKf4rb5HWo1vN3h7XCx9klqoUZig+lkwTw4jHUILWoVU1UzaSg6K9mmccBXf3MWAN39c8ieyulYxI0zuG6eRaSB1eC1XOQ76nHYr+NzKdelV0zq56pTpOqyaiqT1HpT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5muBUUJrtYGWojStwEUuvifl4Cm++cR4wjdBMRfY7w=;
 b=ohsaPEzIvOgnIVErcpmEdbMDPSEzU4ywM5cmCzVEXTEH5dyOyp/2f2obzbgGuZUXd6ycb73+2pWF0pOmHXWqN1nmcnqv4IE3NAUF/M6k2ob8gwDhPBf4iSEfpjmyvP9w+4gIv16x8UlZGGhvCJQ8zgfN31o8lVDwFhdd70RZsIfj43m7eYu5wUF9GGLKQmDvzwSbZEBS4GABcXKM9fnVeL4tp9Ea0GF6HyjEcLJuzisx6Zj7aG9qeZt6jJ4S5hdJzpmGl4XxHovKmIDEx1FNqpMyIbFhr33QbpWm40TUP9zulGHohXTipAkT8izZxjPwkuRrnSIofpDoGz/jH7fC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by GVXP195MB2590.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1e3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:49:01 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:49:01 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Topic: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Index: AQHdCKrnZwSzILPPFEWG4EepumfAgrZZ0MsAgAEBKACAAIObAIACfCYAgAKlIoCAAKeQgIADtgAAgABNU4CAFxTOgIAEz2CA
Date: Mon, 27 Jul 2026 05:49:00 +0000
Message-ID: <6e4a83bbeb9e4c11fa1873f4d86dbb760261f0ec.camel@phytec.de>
References: <20260630160951.122230-1-marex@nabladev.com>
 <0e9071095b0b590c45a139eacb210192e160823f.camel@phytec.de>
 <3200f8b6-6e5e-4275-8442-03ecb6a48597@nabladev.com>
 <5147fb9ef450d4a6963b57dbfdd6ee03eb2ae29a.camel@phytec.de>
 <95b68d7f-e0e6-46b2-af35-8da68c2a9b6a@nabladev.com>
 <8b8468aedb4510d4956ffd548e6e6a8c69cbafe3.camel@phytec.de>
 <6da789b2-de94-4e9a-80dd-3125e8df36ba@nabladev.com>
 <9f59f0c1cd31c7f7fa55243526f472119f899d8a.camel@phytec.de>
 <5f75b4fd-3e0c-42c7-b4d4-4c2e37dd42fc@nabladev.com>
 <a77c8950-6377-4e2a-8059-f6c3e0cfd824@nabladev.com>
In-Reply-To: <a77c8950-6377-4e2a-8059-f6c3e0cfd824@nabladev.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|GVXP195MB2590:EE_
x-ms-office365-filtering-correlation-id: 404371cd-9590-4737-bbe3-08deeba2c24d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info: RUBoy0SVA6c1p7rDRqLAc8AsMNdpXTPYmPrFrl2U+vyJGfQtXJs25La95FcipQP6h8qxiLZXCOeWriU6kd3vC/W26MM5r5931oYVTLQtl704bUAjMvHm9lm5gkvJeaOBlgt6zUficCpPyLYCddMccbAh199GBRa2FT7i+iSoBkwEz+pMCy05MwaWhpfPiZN2dlGkB0aIiDDe3u23s2QEtBQLh9cPMOGyS1N5ep6qtOQfxNMfDSEM4FuwOQEwISudQAr9g7g/APjwzVbUHBLeQBFkCiWPIBYjuXlgOEJ6uDF60BEmVKufZV8m3cQr96P8ObrZONfbSiTlPrRiXLw3umJcob2Frddq/jj4MYZPe6dX97QHxZJDR2Nf+vbqcbwEJ765I6f3XZr6bmTK9OC0gAtweA4P4ch2bYxkOMDlYwMXevDCgxF1i6HMbRpKz9V0WKhbPG+P9R8pWMpKIO4b9lzFfEi4y7EUUYmVgr/PbA/upYBnogR7uAKSBgueNBkwbmYYj6KaIDI5yalfMU+2IF2EmU+5f6euNu/OP20kcP1oI01ZwPkLfyi8lXo2B0PXnq4gQQ7h1ccH6bKIB81rrAtO9QUMpPTGoVJeDwCQCFSNaMHG7HIof/vM2WS/tuWeem39Vi5/3G/YzyUYVLpws5kcI3JZEjozmbTPdzUD2wra/WHH7plZ9XlxS6qDcMQYuRVrb823tTAc6zEuQb6S/q8H94r9cC9G9pStpusQlqY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkp2VnlsTTVRWnNGcDNSMGt0N2dkNDZwalJlcTZ5eWh5U3RjTXU3V1JOa2kw?=
 =?utf-8?B?RjBWejQzb2IxVkJiWW1veVFyUjYyYWpQcWJYWnozWmpCSHNhNmQ4ZCtCQWRS?=
 =?utf-8?B?SU9kbkF4U1pQMzRhZlNucXJEVDE3cUJjZklMbmdSNTBZdDJKMFIwb0NSbmlH?=
 =?utf-8?B?MkpwK244OUoxOXBOdC9NM2Y1RzAwamlHZjBFVUZVTE1FM1NoYXdSR3BNMFBn?=
 =?utf-8?B?aGF0Z0cyczBsdmhGVjRaOHh3dlhXeEhZOStSTFZyK2o4QmYvVEtkL1ErZmtS?=
 =?utf-8?B?N2o2QjV2VkpBUXl6SFdTZ2l1N0NKaDEwaVp1dG1rdlFIN0JQR0MvR2owbXp0?=
 =?utf-8?B?WmJVUElHUFVxeUw3Z0YrZjVLaUI2RlFwVWVxREZLTTg2OUJ5WnppMlVIdXkx?=
 =?utf-8?B?dnpFV0xpbmZncktoTGp4T3V4NmxRTU1IUXQrMXBuY0RhYkRKOFVERmdhd1E2?=
 =?utf-8?B?c1RXc0RCWHMyWVAwT1hBR2VwYTlGMG1ndlhqWFpGcmtpaWMyRVA2ZzdqbU81?=
 =?utf-8?B?WDhYazNuU2pYRERFTEtPZ1ZhOVBCRmNRYkNRQU5nR043RjdzRmZhSUhoOVZk?=
 =?utf-8?B?aitsNHRkUStMRlpVUmJpWFhmWFViS21lVmQ2Zy96ZHJLNEJEWlZ1UHA2eCtH?=
 =?utf-8?B?Zkx5ckxxaVEzUHd1Q3BOYi9IdXdDV2J2VDhwOUpMWDlhZ0tLV2pCenNFSE9J?=
 =?utf-8?B?V2Npd2gxRmNlckIzOTVLcHB3cDROalBwdWVUT0JMNnhyWkJUN3JPS1NJMjJa?=
 =?utf-8?B?cW5jV0IxT3U4cmdVSjZrWXNpL1l2WUZxL1R2NGZ3OTBEZ3JsMmFUNmxHdDBz?=
 =?utf-8?B?MzRsUDNXZDBwMEVxZmcyRXhRVzhNK1ZhTUJIeXdYMGtsaHY2cDhLZzBsVXo4?=
 =?utf-8?B?MzJuNk8zdDFoNDMwaHVpUHRVMTNpV0tpaS9ockRhME8yakk4ektCdTZWQnEv?=
 =?utf-8?B?aWNUSGhoNkJUQWVTZTZGQndOZGU1ZGg4WURRYWMybVBzS0QrZVhBVFVFSGlG?=
 =?utf-8?B?ZnFkUkgrMDQ4MWJUMWRzYkl3REVOZm5pNTVTUGd6MUtJaFZKNm5CUndWZkJ4?=
 =?utf-8?B?UTNBNmdaa1FBd1NZczdmU2xqYkJZaXNwK243amU1ZVZiT2V1d2ZBczdqdkJL?=
 =?utf-8?B?UVMvanFjUU83ZDkxVlFMbEdlMmppZ1JqTFhvYkxYTHhCUzNtZTcyNzFpYkd6?=
 =?utf-8?B?bGF5b0dQVlJ0a1BsRVp1R1BwelAra3lSR29LUWRCczA3MWc2ZGV4cmRHNXVH?=
 =?utf-8?B?WVVDRUtSV0ZERStKY1hIcnNVbEp0bklNMjZ6bENtN0xGNU9JZUYvcGNYS2Jm?=
 =?utf-8?B?UjN0SFJMWXBJeVpRUEJ0OWIxdVVobUhTVkVmSjlVMHlaVFhEOHhyZEVLU3lJ?=
 =?utf-8?B?d3pNZlEyMDRRVkdKeHc3V0JrbUpHanovNVR4bndidTBTTEp1WGRKdE96cndu?=
 =?utf-8?B?anE0c0dZcWtCQVRNZWhiZkJ3UmlwcWluT055ajNnazhZeERvdVZ5REpkZ0R4?=
 =?utf-8?B?VG1IOHU0OWRoVlkvZS9zWElUb21Qdm5aNllydm1aYUdrRjBtSjBzaXhjNHUy?=
 =?utf-8?B?YURWdDBCNUtSYUR1Q0IwZVpGMkg4elJtRXNqVEtpTlZaWkViSm1KNjZzTUk5?=
 =?utf-8?B?UjY2dXNtNTVNT2FzUVY1eU9zay8ycEYzTjZrOU1uc2dqZU1SR0thWmRoaGVL?=
 =?utf-8?B?Q3QwanN3UUN1WnZ1RXoxR0VrcXlTejRTWTdaM0dIQ2MzZ3VLQzRWRzZKZDhq?=
 =?utf-8?B?WWZmM21nS3YwMGdxVVJQZUZHd1JWY0RqNDl5MklseVhITmlxQjNjWjR5L2U5?=
 =?utf-8?B?bjREYnZkVTRoMytEbkl1UlJtNXJGRVVDUXpaT3VxL0svNEkzTkYwaFk4TjVk?=
 =?utf-8?B?bTdYR25TRHZnOWdqYXg0Nm0xbTQxWnY2c29NbEhWSEVJbjZIRHZjRUg3MEtP?=
 =?utf-8?B?Y0NEQ010RDI4SFZPWkJKYURMelU0VU9BUUd5MGc0SUxPK3p6TThaQW5YLy9Y?=
 =?utf-8?B?d3JyMjJpV2JQalBZazYyMVR1ZEtMTFJ5TXpKR1J2ajBZKzJKbG9oWXhxeXNG?=
 =?utf-8?B?T2J4dGxOeEROZ0ZSOW9xUnJ1ckVBVW03OXBxangzWTNoZ2t3ajhkVWFyN1RI?=
 =?utf-8?B?MVhVMEpvbnh3bzhpQkdkNnZTQk1CK21sVTUvbG9MMnNuOFJIT1I0b1FlMExI?=
 =?utf-8?B?Rzh4SGN0VXdxMVN2aHZiNG1sdXFRRjh2VU40UzZuZTVHeVVudDYrR01FVHp4?=
 =?utf-8?B?TENRd3RCT3V5eC9IdGRPY25sNzJjQWVPcFREd0VMZUVRZ0ZvdHYzQXE1ODdL?=
 =?utf-8?Q?UPw0oh8fJLvi3Z8oWf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73D11BE4E9B20E4CAE8CC365DA2B8200@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 404371cd-9590-4737-bbe3-08deeba2c24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 05:49:01.0154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80UnzKdYZpiY9a4O4I2jrYLbj3dmtHlmzFI9uPGQkkSNAJAY6Bb/kHenlEcm3Yvq9KbOpyER74P2X0VU3dXd1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2590
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5muBUUJrtYGWojStwEUuvifl4Cm++cR4wjdBMRfY7w=;
 b=dBrX9mECopLr9t/7CP2K3vIq9hxunzydPbX1hHmo6gvzyUlV/vYg38MYQ9NtjfdodzUOsIYXfz8lewbtXwx8XrCNrHSOFwsxP2tZIHXs8Z9boFWVFtgj919eOC5dqrA5PBWiwUhi+6whUMbotqdztWkMWjG0b1fWIyeHxLLaMP9Uav8uw3+SORWffL9P4yQeAabIKYP5EtvzbAuKkQuerk8J+MlAQ3ka1oIVs1nv+mvzcYOjReqy8g/GZ4pw5akAReW6kXgwd7XsQITkEUmSgCo79CYVRzGteqnMAlbN4M97KpdAnTBZXu8ebjsA6w6EK7CdoeA8iyGl3SDffB4LbQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=dBrX9mEC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Y.Moog@phytec.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=phytec.de header.i=@phytec.de header.b="dBrX9mEC"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

SGkgTWFyZWssCgpPbiBGcmksIDIwMjYtMDctMjQgYXQgMDY6MjEgKzAyMDAsIE1hcmVrIFZhc3V0
IHdyb3RlOgo+IE9uIDcvOS8yNiAxOjUzIFBNLCBNYXJlayBWYXN1dCB3cm90ZToKPiAKPiBIZWxs
byBhZ2FpbiwKPiAKPiA+ID4gPiBJbiBjYXNlIG9mIENPTkZJR19PUFRFRT15IGFuZCAib3B0aW9u
YWwiIGtleXdvcmQgYW5kIG1pc3NpbmcgdGVlLmJpbgo+ID4gPiA+IGJsb2IgLCBJIHRoaW5rIHRo
ZSBub2RlIHNob3VsZCBiZSByZXRhaW5lZCwgYmVjYXVzZSB0aGUgdXNlciBtaWdodAo+ID4gPiA+
IGluamVjdCB0ZWUuYmluIGludG8gdGhlIHUtYm9vdC5pdGIgYWZ0ZXIgdGhlIGJ1aWxkIHdpdGgg
c29tZSAibWtpbWFnZSAtRgo+ID4gPiA+IC4uLiIgaW52b2NhdGlvbi4KPiA+ID4gPiAKPiA+ID4g
PiBJbiBjYXNlIG9mIENPTkZJR19PUFRFRT1uICwgdGhlcmUgc2hvdWxkIGJlIG5vIHRlZSBub2Rl
Lgo+ID4gPiAKPiA+ID4gSSB0aGluayBJIG5lZWQgbW9yZSB0aW1lIHRvIGRpZ2VzdCB5b3VyIHBv
aW50cy4gWW91IGRpZCBub3QgY29udmluY2UgCj4gPiA+IG1lIHRoYXQgd2hlbiBDT05GSUdfT1BU
RUU9bgo+ID4gPiB0aGVyZSBzaG91bGQgbm90IGJlIGFueSB0ZWUgbm9kZS4gVGhlIHJlc3Qgb2Yg
dGhlIGRpc2N1c3Npb24gaXMgYmFzZWQgCj4gPiA+IG9uIHRoaXMgcG9pbnQgc28gSSB3b3VsZCBs
aWtlCj4gPiA+IHRvIGF2b2lkIGRpc2N1c3NpbmcgdGhpbmdzIGZ1cnRoZXIgZm9yIG5vdy4KPiA+
ID4gSWYgd2UgY2FuIGdldCBhbm90aGVyIG9waW5pb24gb24gdGhpcyBkaXNjdXNzaW9uIHRoYXQn
ZCBiZSBncmVhdCBJIAo+ID4gPiB0aGluay4gRWl0aGVyIHdheSwgSSBhbSBva2F5Cj4gPiA+IHdp
dGggdGFraW5nIHRoaXMgcGF0Y2guIEFnYWluLCBpdCBpcyBteSBvcGluaW9uIHRoYXQgdGhpcyBp
cyBub3QgYSAKPiA+ID4gZml4LCByYXRoZXIgd2UgYXJlIGxvc2luZyBhCj4gPiA+IGZlYXR1cmUu
Cj4gPiAKPiA+IFBsZWFzZSBkbyBrZWVwIGRpZ2VzdGluZy4gUGxlYXNlIGRvIGtlZXAgdHdvIHRo
aW5ncyBpbiBtaW5kIC0tIGlmIHRoZSAKPiA+IHBsYXRmb3JtIGRvZXMgcnVuIG9wdGVlLW9zLCB0
aGUgc29mdHdhcmUgc3RhY2sgc2hvdWxkIGJlIGF3YXJlIG9mIGl0LiBJZiAKPiA+IHRoZXJlIGlz
IGEgc3BlY2lhbCBjYXNlIHdoZXJlIHRoZSBzb2Z0d2FyZSBzdGFjayBzaG91bGQgbm90IGJlIGF3
YXJlIG9mIAo+ID4gaXQsIHBsZWFzZSBwdXQgdGhhdCBpbnRvIGJvYXJkIERUcyBvciBib2FyZCBV
LUJvb3QgZXh0cmFzIERUcywgYnV0IHRoYXQgCj4gPiB1c2UgY2FzZSBpcyBzcGVjaWFsIGFuZCBu
b24tZGVmYXVsdC4gRmluYWxseSwgaW5jbHVkaW5nIGRlYWQgY29kZSAvIGRlYWQgCj4gPiBEVCBu
b2RlcyBpbiBidWlsZCBhcnRpZmFjdHMgdGhhdCBvbmx5IGdyb3dzIHRoZSBzaXplIG9mIHRoZSBi
dWlsZCAKPiA+IGFydGlmYWN0IGlzIG5vdCBnb29kLgo+IAo+IEl0IGhhcyBiZWVuIHR3byB3ZWVr
cyBub3csIHdoYXQgaXMgdGhlIGN1cnJlbnQgc3RhdGUgPwoKTXkgb3BpbmlvbiBvbiB0aGUgbmVj
ZXNzaXR5IG9mIHRoaXMgcGF0Y2ggaGFzbid0IGNoYW5nZWQsIHlldC4gQnV0IEkgc3RhbmQgYnkg
d2hhdCBJIHNhaWQKcHJldmlvdXNseToKCj4gRWl0aGVyIHdheSwgSSBhbSBva2F5Cj4gd2l0aCB0
YWtpbmcgdGhpcyBwYXRjaC4KCllhbm5pYwo=
