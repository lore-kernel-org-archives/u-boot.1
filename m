Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CD0109E529
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 04:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD91D84020;
	Thu, 26 Mar 2026 05:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Student.rmit.edu.au header.i=@Student.rmit.edu.au header.b="2L9/U7TY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DFF83A1B; Thu, 26 Mar 2026 05:41:18 +0100 (CET)
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8074E80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=S4210155@student.rmit.edu.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu48sj8Fs7mOncikfITk38qg7/1s4JgVgyAWMakpik41J/Z5qkAfK/mj9K03YP8TqtO6uSd91Oc6WaSwG5EemSdaaowWB0Oy8BBxf6n0lbPyGZpSNJeHRC4Bow9Ntb3XbnZsLZw50sO8HcdGXqs7P2F+MNQdK+4VHHZSvnZSQx5XeywCQg/6bqe2+ZBfNCAqdcVSxRE9KhcblsDRyva7ZH/CSxp8oOp+pmevXYXblXm4FOAVoVRGlVxzn/iw9/ZfHi+AyMRXv41XcidRtsDIC2p5XnSMYVvqUG23VJKuEtdD6gsbeFQkpL6wNtxb0tElmdv0tO6BKXZcOeV4tasHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5Zlqc09yVjRioKphdG17hdzIlT9W01SwieqgwjGqWY=;
 b=NjD2pfeS5V0yWF56ZtTKncr1xtdXHjJDJwY99PhsQRH6j5754CTKyVy1nZwq5bLS85950M9P0UU8x7oV8FxGnDA2rRaDZVa/BrEww529HyrmEZ+YTdWzue3IwpmDSCj3niGjw/y/B99O5ffGNGCnpw/SBtIxjBPyFsjWgATS5wNTQl6JwdQlxz6eR9XHfxpqVXNZjIiopWGjsJWF+TkpVO3hD6dZbbTfTm5HjeFxMkNmwGnXyRNuwPBNadLeuSilf1PNgwwScRHnXnWegQB2HfKELozw1pJ3gxebbYxkd5zXNyLNrdi4HdRQgNrHhBgmw4O00Axk20WqTlBK9faGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.rmit.edu.au; dmarc=pass action=none
 header.from=student.rmit.edu.au; dkim=pass header.d=student.rmit.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Student.rmit.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5Zlqc09yVjRioKphdG17hdzIlT9W01SwieqgwjGqWY=;
 b=2L9/U7TYS7tT2+PRFnieWCozl4zRmaq1sD0ZLN/etQwFCxQwSxuJURr8uWXwFq1g9Aa7gwZRhGX6zrxoGInOczW92BdroRNEEd2i41JIcrJ3sL8FjPCI/OAYi/WRbmVzqW7U4nltjXGk+bPZSeKUtiJESzuFtQ/cldsITck4RRA=
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com (2603:10c6:10:10e::6)
 by SY6PR01MB8441.ausprd01.prod.outlook.com (2603:10c6:10:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 04:41:07 +0000
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac]) by SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 04:41:06 +0000
From: Tra Ngo <S4210155@student.rmit.edu.au>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "andrew.goodbody@linaro.org"
 <andrew.goodbody@linaro.org>
Subject: [SECURITY][2/4] Buffer overflow in CLI boot retry path
 (CONFIG_SYS_CBSIZE-dependent)
Thread-Topic: [SECURITY][2/4] Buffer overflow in CLI boot retry path
 (CONFIG_SYS_CBSIZE-dependent)
Thread-Index: AQHcvNj/s51O1QK0UU+Cdf4C7DozlQ==
Date: Thu, 26 Mar 2026 04:41:06 +0000
Message-ID: <SY4PR01MB6316C0B6B55E23C0646783549A56A@SY4PR01MB6316.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.rmit.edu.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4PR01MB6316:EE_|SY6PR01MB8441:EE_
x-ms-office365-filtering-correlation-id: 1b068258-7d1c-4492-856a-08de8af1e50e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|6049299003|1800799024|786006|376014|8096899003|4053099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: qElglnzqhQsZm2pkyXyUGdYCSo2E0SvZK8wWnlVwnFL8GqWJSUDtVSmpWHVC01skcaivyAwot1ofd2fHRJfXW4UrsLTCKoY4XFXdbf+48cp9yqY5lMr75jK0wPVIj7AFkMksuF9Egfn84Yi59eO6lrwXbaQOaAiY0NC7wbmKWfnjm8aNztlPBFjZsDRNbm2OvO0VR3x0AD5AcyG7ZGmjGVBkFr/FSVaKp5vcCj22cwjYJHbgUpHIySPgZDI2vRzX5qZroUQEy+pVEEvaPAV5cLESibqCid3/tIGie5Xcd/OmBrcprXZBI0vcl37M9d9QaZ6i2XD2ElmqXObinJNUotiRuQyQEdA6V4jO1akBXA8vRK8XEPw3iZJOc9qIlNWxKldorf+3XQ0vRFVcONxeNGnAyo9rQjRpI3xXC9PciIA3wtEd13/SmSXnN3JkTpKCqbz/NTQEtt1VrK8tULQx5dDiL2+jgx4/je2ONZuPAWrQvelOydyu5jeKco5wFJuFoDa9gTRdZ1DMtip8jGTDxpSt5IkwTPTofzrwmMTE7hJntAUkNh+wdTmauaNE5xkkv690ZgUIdm+5qjFN1tEzcA/txL0AevWkKUN9U/wq1RUpmDOy0hgMySLhJo1QHbdhlSRk67z1iX9dvy2ZNqxM2npw1AWFvtdv/NoXOMPmDugVzp+YpRDozSZiPF5nluOW2Npx5YqMyLGyY1xTfb1LRxOIYmuoKoqqbEGAxYe0/u+oYCT/1N00IYfG3FAwuDpCKiNbYsBT5reQ+iocIHOOKe+/zt8rv0mU43g1Gird49c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY4PR01MB6316.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(6049299003)(1800799024)(786006)(376014)(8096899003)(4053099003)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z9/y/CG13pEcdkws6si2Icu5+vXOq6ooqTCIat5qFUSXGaTeBlzBorYPIFrh?=
 =?us-ascii?Q?ddzoZkqUMDg90p7m1rjK42f1mJwyzxQGvPtlEVi6cKGs2d0HDgbtzGaXhPSI?=
 =?us-ascii?Q?qoYDf06SGxtz9d+Bxd35ADj1LesW1V7Po22YLU06N2ZNYO0zy+TDqvBC4D53?=
 =?us-ascii?Q?LOFXJkvc5Hwl7U9CPMvCixhWszTFzyfstFwvP5+uATY4DI9SBNBAkxwEk/Bi?=
 =?us-ascii?Q?RL5xnHul9iB7rFxTv6vqXo78nNmOYFphfL8YHiySMkR1ZL3plmLoNx/Ur0vc?=
 =?us-ascii?Q?xLXnnJ2ImtvU4wrpVWRE5OQwOY18I79a02AV5EIOX5y4tZ61BxvFhYe/0p6m?=
 =?us-ascii?Q?HkNDhVrRBQPjVNyz/p29YgJsfY6dMnvNrM/iaGyeLFDJDQ9Ff2y9xCRbatWw?=
 =?us-ascii?Q?oblu4Ory7KvwjLnvKcgwAgbjL4hGD9Mr8A5pnB2R9eys4JbEo1t4HdACOgA0?=
 =?us-ascii?Q?o+eOLT/qOfql4s6DKSZXFQxWXW/emfpbNotbLsRJYmZC9U8LBXAsfg/JsXg5?=
 =?us-ascii?Q?+XLb+guX9oeZ/eYlCmXAxVXh9HExOBi1Sgd/56WHTgt27LGCyU17Hh6k7QGe?=
 =?us-ascii?Q?4oMFUihjj4zSqo6cs5caHgLtvCl3J1va65sM2mzckkH6aS0U/VLHVJUDGY42?=
 =?us-ascii?Q?wNo7+h5UEbW4WiL074tujEEH6+hP3z4DTpNrSgk5rSLakyEsfSVNHV7VYUfj?=
 =?us-ascii?Q?W3Ed1gCXFf9KggEkn3xtgNhWmh/owudZh8Kk1G68YH8zmQ1EHOlWh2eBa3l5?=
 =?us-ascii?Q?+kXb0mvDb60hvCeVG0ET6KlqNZB+1wiHprDrxtRO6LJy1xQICsrsWbsxpn53?=
 =?us-ascii?Q?irfxuSxmuajJ4sqBOcsexQP732LUnUoqLjddfPxF8JIA3ibV4KtXhCP7pfyo?=
 =?us-ascii?Q?odyevmA/DghoWw9+qvguHbwehmN7Myg+VaRPHYmzvaSJDoaKTAW2cAjRYpZ0?=
 =?us-ascii?Q?QVI59NaJuKdDGvYko0AvxzF2FghbipufY1U11lC9q39RBz3vOS5aACSpsbrM?=
 =?us-ascii?Q?jxJONr3X5CLoPinaqPkVAEPQg4+WeghVktD9gPQpHuoW+7AxFtt1W2MCIk1R?=
 =?us-ascii?Q?3j7oi+RE6J8L78WgoI2dOZcm/PZwt4GtKnuPtaxxacaWqeTj935lGd/bRvJA?=
 =?us-ascii?Q?FlC1ZEux5nlwAd6Yiz6gJynd8qU19RIUQDNA7sSRLgJQnxP3cVvkcDlLPhZg?=
 =?us-ascii?Q?CIBM8gXmPJqtcI1SM7oFserEy5eNTzx9PCIK3Hl1ktCF7F1qLKWKjCSD8vb9?=
 =?us-ascii?Q?7z9JwjEAFMspZXTSfK07k5AdOH1LJAER5fn1msyZNPt2/1KMAbPZPt8dXlpm?=
 =?us-ascii?Q?/ppQWl7Mkhw72y97i53BZNhNhCMe7rELYWwFEOxnijv8/hMMUrP1toJgcK25?=
 =?us-ascii?Q?lpH9a6QYfkreAb2L8UhT2rBGEbfpxnMdgUf2Li4pHTZOZi34km0iC5RwYjZb?=
 =?us-ascii?Q?qMCjuP6stdX2vGxyMJKAg2b4tPGk3VhsZdrkRUYm5OToCpuJEuk6jLF50HUI?=
 =?us-ascii?Q?4cGqZyNxI78BVIcBwByXPYIWTw9h0rD3Fg7E9KRNXSut4bZ0p6FReA5XCPis?=
 =?us-ascii?Q?biOzf3F7YaWpW3SOwvdCI4LESJUHLJ2V4EcMTfzQdnUmF1cw2GMgOSxHasd2?=
 =?us-ascii?Q?pDgyO7IqtjNZfKjfhHWZBCDeXNVB18k7Dns9+/Y5/X8LDYQ2YjXGuWxTt1Ui?=
 =?us-ascii?Q?rLqOA5MLwxB0v33LmMkjtuVDgUK+5eSF3j1e4Tu1itsZk0YdUSJB6zle6xW7?=
 =?us-ascii?Q?VWg/ISor2Q4aTrgVhfXMkHYnqprl9XViXpsuYn/u1ZCfU3QSkc0+?=
Content-Type: multipart/mixed;
 boundary="_004_SY4PR01MB6316C0B6B55E23C0646783549A56ASY4PR01MB6316ausp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v/0Eq9SGNLQYskQih49Tugo4L7abcQ/DDMJ8MNMhwjM+T/RRxUo+QXEEOJGxj62BzHiyxhJVqKEhbFVO+h0L2FAaSHCf6nc5Jy8IobSOGvdnwC+BkOPw9m4PRDAvQs+9kFahADrfaOxgKpvMkybp9vJ3V/rMhHzoucILsgippNe41FW0VN0H/xyM+RjOM2pe22vqtbSVytgejxUu3xQxbCZtJNGDoCTY6PS0x6kXUD/06AKIxws9W2oBIYZWG5cSX6dgFxKHnYRzYeQuAjQXZSYftSVatRarmPnOwRSrFEP+VpDb+4FaowG/qeKaLJguXE8+TMm+sMTazo2veefzwg==
X-OriginatorOrg: Student.rmit.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY4PR01MB6316.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b068258-7d1c-4492-856a-08de8af1e50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 04:41:06.7253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d1323671-cdbe-4417-b4d4-bdb24b51316b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJnBIXj7cVLuxo9+pLKjBiOpIYxwEAdN/QCUJKBcvbCGpJhoslAfqC0ElDF+O39mUoQJThLsN7SyqHPZvAUOWWoHzUTIt88vbmq62V+KT5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6PR01MB8441
X-Mailman-Approved-At: Thu, 26 Mar 2026 05:56:45 +0100
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

--_004_SY4PR01MB6316C0B6B55E23C0646783549A56ASY4PR01MB6316ausp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear U-Boot maintainers,

I would like to report a potential buffer overflow in the CLI boot retry pa=
th involving console_buffer in common/cli_readline.c and common/cli_hush.c.

The issue arises from an unbounded strcpy() into a buffer sized by CONFIG_S=
YS_CBSIZE, which may be smaller than the injected command string.

This is configuration-dependent and can lead to memory corruption under cer=
tain settings.

I have attached a detailed analysis, including root cause, reproduction, an=
d suggested fix.

This is part of a set of related configuration-dependent issues; I will rep=
ort others in separate emails.

Please let me know if you would like a patch or further details.

Best regards,
Ngo Tra

--_004_SY4PR01MB6316C0B6B55E23C0646783549A56ASY4PR01MB6316ausp_
Content-Type: application/octet-stream; name="UCCG-UBOOT-02.md"
Content-Description: UCCG-UBOOT-02.md
Content-Disposition: attachment; filename="UCCG-UBOOT-02.md"; size=5323;
	creation-date="Thu, 26 Mar 2026 04:31:16 GMT";
	modification-date="Thu, 26 Mar 2026 04:31:16 GMT"
Content-Transfer-Encoding: base64

PT09IFtVQ0NHLVVCT09ULTAyXTogdGR4LWNmZy1ibG9jayBzcHJpbnRmKCkgcHJvbXB0IGNhbiBv
dmVyZmxvdyAoU1lTX0NCU0laRS1kZXBlbmRlbnQpID09PQoKU3VtbWFyeQotLS0tLS0tCi0gVHlw
ZTogc3RhY2sgYnVmZmVyIG92ZXJmbG93IChjb25maWctZGVwZW5kZW50KQotIEFmZmVjdGVkIGNv
bXBvbmVudDogVG9yYWRleCBjb25maWd1cmF0aW9uIGJsb2NrIGludGVyYWN0aXZlIHByb21wdHMg
KGNhcnJpZXIgYm9hcmQgc2VsZWN0aW9uIC8gc2VyaWFsIG51bWJlcikKLSBTZXZlcml0eSAocmVw
b3J0ZXLigJlzIGVzdGltYXRlKTogTWVkaXVtIChzdGFjayBvdmVyZmxvdyByZWFjaGFibGUgdmlh
IGNvbmZpZ3VyYXRpb247IHN0cmluZ3MgYXJlIGNvbnN0YW50IGJ1dCBidWZmZXIgaXMgY29uZmln
LXNpemVkKQoKRW52aXJvbm1lbnQgLyBWZXJzaW9uCi0tLS0tLS0tLS0tLS0tLS0tLS0tLQotIFUt
Qm9vdCB0cmVlOgogIC0gTG9jYWwgdHJlZTogdWNjZy91LWJvb3QgKHdvcmtzcGFjZSkKLSBCb2Fy
ZCAvIHRhcmdldDoKICAtIFRvcmFkZXggKGJvYXJkL3RvcmFkZXgvY29tbW9uKQoKRmlsZXMgYW5k
IExvY2F0aW9ucwotLS0tLS0tLS0tLS0tLS0tLS0tCi0gU291cmNlIGZpbGU6IGJvYXJkL3RvcmFk
ZXgvY29tbW9uL3RkeC1jZmctYmxvY2suYwotIEZ1bmN0aW9uOiAoaW50ZXJhY3RpdmUgcm91dGlu
ZSB1c2luZyBjbGlfcmVhZGxpbmUgcHJvbXB0OyBsb2NhbCBzdGFjayBidWZmZXIgYG1lc3NhZ2Vb
XWApCi0gQnVmZmVyOgogIC0gdGR4LWNmZy1ibG9jay5jOjczNjogY2hhciBtZXNzYWdlW0NPTkZJ
R19TWVNfQ0JTSVpFXTsKLSBDb3B5L2Zvcm1hdCBzaW5rcyAodW5ib3VuZGVkIHZzIHJlbWFpbmlu
ZyBidWZmZXIpOgogIC0gdGR4LWNmZy1ibG9jay5jOjc0Nzogc3ByaW50ZihtZXNzYWdlLCAiQ2hv
b3NlIHlvdXIgY2FycmllciBib2FyZCAocHJvdmlkZSBJRCk6ICIpOwogIC0gdGR4LWNmZy1ibG9j
ay5jOjc1Mjogc3ByaW50ZihtZXNzYWdlLCAiRW50ZXIgY2FycmllciBib2FyZCB2ZXJzaW9uIChl
LmcuIFYxLjFCIG9yIFYxLjEjMjYpOiBWIik7CiAgLSB0ZHgtY2ZnLWJsb2NrLmM6NzY2OiBzcHJp
bnRmKG1lc3NhZ2UsICJFbnRlciBjYXJyaWVyIGJvYXJkIHNlcmlhbCBudW1iZXI6ICIpOwogIC0g
dGR4LWNmZy1ibG9jay5jOjUxMTogc3ByaW50ZihtZXNzYWdlLCAiRW50ZXIgdGhlIG1vZHVsZSBJ
RDogIik7CiAgLSB0ZHgtY2ZnLWJsb2NrLmM6NTI0OiBzcHJpbnRmKG1lc3NhZ2UsICJFbnRlciB0
aGUgbW9kdWxlIHZlcnNpb24gKGUuZy4gVjEuMUIgb3IgVjEuMSMyNik6IFYiKTsKICAtIHRkeC1j
ZmctYmxvY2suYzo1Mzg6IHNwcmludGYobWVzc2FnZSwgIkVudGVyIG1vZHVsZSBzZXJpYWwgbnVt
YmVyOiAiKTsKICAtIHRkeC1jZmctYmxvY2suYzo4MDI6IHNwcmludGYobWVzc2FnZSwgIkEgdmFs
aWQgVG9yYWRleCBDYXJyaWVyIGNvbmZpZyBibG9jayBpcyBwcmVzZW50LCBzdGlsbCByZWNyZWF0
ZT8gW3kvTl0gIik7CiAgLSB0ZHgtY2ZnLWJsb2NrLmM6OTEwOiBzcHJpbnRmKG1lc3NhZ2UsICJB
IHZhbGlkIFRvcmFkZXggY29uZmlnIGJsb2NrIGlzIHByZXNlbnQsIHN0aWxsIHJlY3JlYXRlPyBb
eS9OXSAiKTsKLSBSZWxldmFudCBjb25maWcgb3B0aW9uKHMpOgogIC0gQ09ORklHX1NZU19DQlNJ
WkUgKGNvbW1vbi9LY29uZmlnKQoKICBjb21tb24vS2NvbmZpZwogIGBgYApjb25maWcgU1lTX0NC
U0laRQoJaW50ICJDb25zb2xlIGlucHV0IGJ1ZmZlciBzaXplIgoJZGVmYXVsdCAxMDI0CiAgYGBg
CgpDb25maWd1cmF0aW9uLWRlcGVuZGVudCBkYXRhZmxvdwotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQotIENPTkZJR19TWVNfQ0JTSVpFCiAg4oaSIGNvbXBpbGUtdGltZSBzaXplIG9m
IHN0YWNrIGJ1ZmZlciBgbWVzc2FnZVtdYAogIOKGkiB1c2VkIHRvIGhvbGQgcHJvbXB0IHN0cmlu
Z3MgcGFzc2VkIHRvIGBjbGlfcmVhZGxpbmUoKWAKLSBSdW50aW1lIGlucHV0cyBjb250cmlidXRp
bmcgdG8gdG90YWwgZm9ybWF0dGVkIGxlbmd0aDoKICAtIE5vbmUgZm9yIHRoZSBwcm9tcHQgc3Ry
aW5ncyB0aGVtc2VsdmVzICh0aGV5IGFyZSBjb25zdGFudCBsaXRlcmFscykKICAtIFRoZSByaXNr
IGlzIHB1cmVseSB0aGF0IGBDT05GSUdfU1lTX0NCU0laRWAgaXMgY29uZmlndXJlZCBzbWFsbGVy
IHRoYW4gdGhlIGxpdGVyYWwgbGVuZ3RoICsgTlVMCgpWdWxuZXJhYmlsaXR5IGRlc2NyaXB0aW9u
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLSBFeHBlY3RlZCBpbnZhcmlhbnQ6Ci0gVGhlIGNv
ZGUgbXVzdCBuZXZlciB3cml0ZSBtb3JlIHRoYW4gYHNpemVvZihtZXNzYWdlKWAgYnl0ZXMgd2hl
biBidWlsZGluZyBhIHByb21wdCBzdHJpbmcuCgotIEFjdHVhbCBiZWhhdmlvcjoKLSBUaGUgY29k
ZSBjcmVhdGVzIGBtZXNzYWdlYCBvbiB0aGUgc3RhY2sgc2l6ZWQgYnkgYENPTkZJR19TWVNfQ0JT
SVpFYC4KLSBJdCB0aGVuIHVzZXMgYHNwcmludGYobWVzc2FnZSwgIjxjb25zdGFudCBsaXRlcmFs
PiIpYCB0byBwb3B1bGF0ZSB0aGUgcHJvbXB0LgotIGBzcHJpbnRmKClgIGlzIHVuYm91bmRlZDog
aXQgZG9lcyBub3Qga25vdyB0aGUgc2l6ZSBvZiBgbWVzc2FnZVtdYC4KLSBUaGVyZWZvcmUsIGlm
IGBDT05GSUdfU1lTX0NCU0laRWAgaXMgY29uZmlndXJlZCBzbWFsbGVyIHRoYW4gdGhlIHByb21w
dCBzdHJpbmcgbGVuZ3RoIHBsdXMgdGhlIHRlcm1pbmF0aW5nIE5VTCBieXRlLCBgc3ByaW50Zigp
YCB3cml0ZXMgcGFzdCB0aGUgZW5kIG9mIGBtZXNzYWdlW11gIGFuZCBjb3JydXB0cyB0aGUgc3Rh
Y2suCgotIENvbmNyZXRlIG92ZXJmbG93IGNvbmRpdGlvbnM6CiAgLSBBdCB0ZHgtY2ZnLWJsb2Nr
LmM6NzQ3OgogICAgLSBPdmVyZmxvdyBpZiBgQ09ORklHX1NZU19DQlNJWkUgPCBzdHJsZW4oIkNo
b29zZSB5b3VyIGNhcnJpZXIgYm9hcmQgKHByb3ZpZGUgSUQpOiAiKSArIDFgCiAgLSBBdCB0ZHgt
Y2ZnLWJsb2NrLmM6NzUyOgogICAgLSBPdmVyZmxvdyBpZiBgQ09ORklHX1NZU19DQlNJWkUgPCBz
dHJsZW4oIkVudGVyIGNhcnJpZXIgYm9hcmQgdmVyc2lvbiAoZS5nLiBWMS4xQiBvciBWMS4xIzI2
KTogViIpICsgMWAKICAtIEF0IHRkeC1jZmctYmxvY2suYzo3NjY6CiAgICAtIE92ZXJmbG93IGlm
IGBDT05GSUdfU1lTX0NCU0laRSA8IHN0cmxlbigiRW50ZXIgY2FycmllciBib2FyZCBzZXJpYWwg
bnVtYmVyOiAiKSArIDFgCiAgLSBBdCB0ZHgtY2ZnLWJsb2NrLmM6NTExOgogICAgLSBPdmVyZmxv
dyBpZiBgQ09ORklHX1NZU19DQlNJWkUgPCBzdHJsZW4oIkVudGVyIHRoZSBtb2R1bGUgSUQ6ICIp
ICsgMWAKICAtIEF0IHRkeC1jZmctYmxvY2suYzo1MjQ6CiAgICAtIE92ZXJmbG93IGlmIGBDT05G
SUdfU1lTX0NCU0laRSA8IHN0cmxlbigiRW50ZXIgdGhlIG1vZHVsZSB2ZXJzaW9uIChlLmcuIFYx
LjFCIG9yIFYxLjEjMjYpOiBWIikgKyAxYAogIC0gQXQgdGR4LWNmZy1ibG9jay5jOjUzODoKICAg
IC0gT3ZlcmZsb3cgaWYgYENPTkZJR19TWVNfQ0JTSVpFIDwgc3RybGVuKCJFbnRlciBtb2R1bGUg
c2VyaWFsIG51bWJlcjogIikgKyAxYAogIC0gQXQgdGR4LWNmZy1ibG9jay5jOjgwMjoKICAgIC0g
T3ZlcmZsb3cgaWYgYENPTkZJR19TWVNfQ0JTSVpFIDwgc3RybGVuKCJBIHZhbGlkIFRvcmFkZXgg
Q2FycmllciBjb25maWcgYmxvY2sgaXMgcHJlc2VudCwgc3RpbGwgcmVjcmVhdGU/IFt5L05dICIp
ICsgMWAKICAtIEF0IHRkeC1jZmctYmxvY2suYzo5MTA6CiAgICAtIE92ZXJmbG93IGlmIGBDT05G
SUdfU1lTX0NCU0laRSA8IHN0cmxlbigiQSB2YWxpZCBUb3JhZGV4IGNvbmZpZyBibG9jayBpcyBw
cmVzZW50LCBzdGlsbCByZWNyZWF0ZT8gW3kvTl0gIikgKyAxYAoKSW1wYWN0Ci0tLS0tLQotIFBv
dGVudGlhbCBpbXBhY3Q6Ci0gU3RhY2sgY29ycnVwdGlvbiAvIGNyYXNoIC8gdW5kZWZpbmVkIGJl
aGF2aW9yIHdoaWxlIGludGVyYWN0aW5nIHdpdGggdGhlIFRvcmFkZXggY29uZmlnIGJsb2NrIENM
SS4KLSBQcml2aWxlZ2UvY29udGV4dDoKLSBFeGVjdXRlcyBpbiBVLUJvb3QgY29udGV4dDsgb3Zl
cmZsb3cgb2NjdXJzIG9uIGEgc3RhY2stYWxsb2NhdGVkIGJ1ZmZlciBpbiBib2FyZCBjb2RlLgoK
UmVwcm9kdWN0aW9uIChleGFtcGxlKQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi0gRXhhbXBsZSBj
b25maWd1cmF0aW9uIC8gZW52aXJvbm1lbnQgKGNvbmNlcHR1YWwpOgogIC0gU2V0IGBDT05GSUdf
U1lTX0NCU0laRWAgdG8gYSB2YWx1ZSBzbWFsbGVyIHRoYW4gb25lIG9mIHRoZSBwcm9tcHQgc3Ry
aW5ncyBwbHVzIE5VTC4KICAtIEJ1aWxkIGFuZCBydW4gdGhlIGNvZGUgcGF0aCB0aGF0IHJlYWNo
ZXMgdGhlIGludGVyYWN0aXZlIHByb21wdC4KCi0gT25lIGNvbmNyZXRlIG51bWVyaWMgZXhhbXBs
ZSAoc2hvd2luZyBvdmVyZmxvdyBhdCB0ZHgtY2ZnLWJsb2NrLmM6NzY2KToKICAtIGBDT05GSUdf
U1lTX0NCU0laRSA9IDhgCiAgLSBUaGUgbGl0ZXJhbCBgIkVudGVyIGNhcnJpZXIgYm9hcmQgc2Vy
aWFsIG51bWJlcjogImAgaXMgbG9uZ2VyIHRoYW4gNyBjaGFyYWN0ZXJzLgogIC0gYHNwcmludGYo
bWVzc2FnZSwgIi4uLiIpYCB3cml0ZXMgYmV5b25kIGBtZXNzYWdlWzhdYC4KClN1Z2dlc3RlZCBm
aXggKGNvbmNyZXRlKQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotIFJlcGxhY2UgYHNwcmludGYo
bWVzc2FnZSwgIi4uLiIpYCB3aXRoIGEgYm91bmRlZCBvcGVyYXRpb24uCi0gUHJlZmVycmVkIHBh
dHRlcm46CiAgLSBVc2UgYHNucHJpbnRmKG1lc3NhZ2UsIHNpemVvZihtZXNzYWdlKSwgIiVzIiwg
IjxsaXRlcmFsPiIpYCBhbmQgZW5zdXJlIHRoZSByZXN1bHQgZml0cy4KLSBBbHRlcm5hdGl2ZWx5
IChzaW1wbGVzdCBmb3IgcHVyZSBsaXRlcmFscyk6CiAgLSBVc2UgYHN0cmxjcHkobWVzc2FnZSwg
IjxsaXRlcmFsPiIsIHNpemVvZihtZXNzYWdlKSlgIHdoZXJlIGF2YWlsYWJsZSBpbiBVLUJvb3Qu
Ci0gQ29uc2lkZXIgY29tcGlsZS10aW1lIGRlZmVuc2U6CiAgLSBJZiBwcm9tcHRzIGFyZSBmaXhl
ZCwgYWRkIGEgYnVpbGQtdGltZSBhc3NlcnRpb24gdGhhdCBgQ09ORklHX1NZU19DQlNJWkVgIGlz
IGxhcmdlIGVub3VnaCBmb3IgdGhlIGxvbmdlc3QgcHJvbXB0LgoKUmVwb3J0ZXIKLS0tLS0tLS0K
LSBOYW1lOiBOZ28gTHVvbmcgVGhhbmggVHJhCi0gRW1haWw6IFM0MjEwMTU1QHN0dWRlbnQucm1p
dC5lZHUuYXUKLSBUb29sIHVzZWQ6IFVuaWZpZWQgQ29uZmlnQ29kZSBHcmFwaCAoVUNDRyksIGEg
Y29uZmlndXJhdGlvbi1hd2FyZSBzdGF0aWMgYW5hbHlzaXMgcHJvdG90eXBlLgotIERhdGUgb2Yg
ZGlzY292ZXJ5OiAyMDI2LTAzLTI1Cg==

--_004_SY4PR01MB6316C0B6B55E23C0646783549A56ASY4PR01MB6316ausp_--
