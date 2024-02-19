Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F36C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 16:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4F387F24;
	Mon, 19 Feb 2024 17:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=UGent.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ugent.be header.i=@ugent.be header.b="QUyLG9Xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9556187F2E; Mon, 19 Feb 2024 17:12:35 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0728.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B499887DC4
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 17:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=UGent.be
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Robbe.Gaeremynck@UGent.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPGlnibMgAE1F1zldbT+U3uR2+3pYNbkcaqYlLdH9c61Ml15B1fxgh5Xvy+xf2+ZrDu2p7lBRz08k3W4t4DN+3tTYJGVstTd6Dzc0zPtuhNLwjMmK692L3hIhLvCoVx47te0hQknhyyJxAfhtTjgMaG939edI3tvAKbLmXzT1c8JYerN/DH1jLUTpk1RI2oBLRFDRGSMtp75KFLRw2A52tNrrr+pC5b85JSEJNAS/uK2lBEDvckPytY6Znevqmzssw3w9aDwz0Faw/VLL83SR+iGB/Baf9mWxAS0oq2m/mC68sXalQ+pN38NY90c8Y1pGLLmwTH2aiwgmrw3bM+Qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqC3s6NWpQxsYsoDVXX5jTOaWDOF+pFspKqU8dknpz0=;
 b=WwbW+Dr8EJKENmMxZAb65LOwHakVE3WwWozFVsq35pZABldrr6F3I2IYZN6Qnj4eo5MOF/O+8pRd4DCoGeb+GHdslrGiiN1+MHSywaBYRtRZm+QLNMGnYcbSoERio99TxnMojGfdkQSGuZy7LCJIoJ9q6Z2sHXLdbiLsX1WWA/zH94SrVWOo2uBK0/p0l4LPMWjlRNmMr75aPlPeMgOQKFWQU/zabxegE309VS2YAUaH3/0QWBYt4+bdRTPJyT7Od6x/L50lcyQbT+eAhvLYtXQ7qUwTSr/YCokdpHSs0HMwyO+Kv7ULoM/7JpHmu8tY6lI0hYNkkpHob0n+nH6VlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ugent.be; dmarc=pass action=none header.from=ugent.be;
 dkim=pass header.d=ugent.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugent.be; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqC3s6NWpQxsYsoDVXX5jTOaWDOF+pFspKqU8dknpz0=;
 b=QUyLG9Xe3A9/hLAN7mgDnmA7WqHP8d6+E8SufR5JJylcNhjhZ5doTjkPelNtW6GlE84k62WPzm49wu9fCzHGNHlOeUuq68WFDSjl7nuZ2aTMVZGvYGXU8gkPiuaTbmWYOMMKQLPenItNATxvsjPrmfND38XEkL2S8bocLN2a/l0=
Received: from AS8PR09MB5971.eurprd09.prod.outlook.com (2603:10a6:20b:56f::7)
 by DB8PR09MB4390.eurprd09.prod.outlook.com (2603:10a6:10:15f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 16:12:24 +0000
Received: from AS8PR09MB5971.eurprd09.prod.outlook.com
 ([fe80::944a:f51c:571a:365d]) by AS8PR09MB5971.eurprd09.prod.outlook.com
 ([fe80::944a:f51c:571a:365d%3]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 16:12:24 +0000
From: Robbe Gaeremynck <Robbe.Gaeremynck@UGent.be>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: SPL cannot boot FIT image linux kernel in u-boot 2019.07
Thread-Topic: SPL cannot boot FIT image linux kernel in u-boot 2019.07
Thread-Index: AQHaY0qXjJ7snOghZEqdSKl/yVsQSg==
Date: Mon, 19 Feb 2024 16:12:24 +0000
Message-ID: <AS8PR09MB59712D1E8F1607F9E430CC19EE512@AS8PR09MB5971.eurprd09.prod.outlook.com>
Accept-Language: en-GB, en-001, nl-BE, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=UGent.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR09MB5971:EE_|DB8PR09MB4390:EE_
x-ms-office365-filtering-correlation-id: a60a20e8-8e0e-4fd7-8c4d-08dc31658efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3nWPGV/8H3qQ/24LeQjQzKkvJLtF5Dt4fGyTDXQdHN5jmfJofXKIjEq6EDq+a0Q06GNxnmMUmzu2nVnKLgfT3/8MGMtzCfJ5eUgq1jw1pqkqQO8TtY01WKjJaKyewpGLFdfep/KycREGKYrSU70P4s5j/ice3Y4tgCWd6Ny8ga3j6xVstuYHhaLmtrARC+wjNG4zcR4HGpdHMBTVAIh4yXgTCqO455hwSxfs97VLk1J5p6zepQetYPbUVtuPbBLssunLEz/o/7x/TSq34LyK/SN85pEx4oLxdshYcHsnrw7/JKDed3R+bCBcFZXQ7PKawPuT4bP0i0J1EuW+KFRakX6LOVtOc30zRtFtEKJEWmV4Fd9Jvgv5xRvDRcY8o9CpIqS+20ZkcgXurnuX/0+iwR9vTXSPgMITGhAOjBtzGzL75PrU5FuLXK2i2tPasSRxXxzRjrFCIENm+3Db8yWm2TJEkMpvfdNCKbDwmKdjt0GVowqMZCAO/rjYdmVhL6LtHJZr9RMZIen9rpjSVbUAMv79HDIUq8wr4RA3xMDE41S9Y1vrnRqdiSqFP2U+71oNb2s2bArt70sOjyKgve9jGQrSnEhNFQMMn0KXIEZPy1AtlrxIMncng2A3uU29ZNCd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR09MB5971.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n3tBumS954FHSWMlLD5tqxsj5ZKCPIF24Hze9tQF6Cep9JCVy7WBTVOTjW?=
 =?iso-8859-1?Q?uMqZxgcN49JgneAOVB0c9LbYBjGnulu7IlQY9RUVifx2MqNa19NoDODS7F?=
 =?iso-8859-1?Q?p3etxt71LcaiwAzT1oHo/wqH96D2yK/lkeir8PJgaIpsWiysZFwQB4ZG75?=
 =?iso-8859-1?Q?wNc/Gu3ELrX9j/S98Z0KkSUAnmm6SdbnMoA2qJKUvNd+NatLioXNASI9rQ?=
 =?iso-8859-1?Q?dSceEjGntzBxW0h+a9rrFyxzdvHfH12KOTKzA1snARCEDRD1MyBv0cDTkd?=
 =?iso-8859-1?Q?lH21c/PturmwPS9ni2Bt5mX5bJk4kLm2zSB9VVqKDtjlVwiPDzqSIlt//J?=
 =?iso-8859-1?Q?/rdKIPszpycHBDtpb0zGey3tlTlUWoRoG+mW8TArNO7s/qu/vqdf6SDj1I?=
 =?iso-8859-1?Q?B4yqm98VAyVdHAuf1Gk9d0OK/MurbwLjDDqOH0euSgJdV0FrEr7a9+6W04?=
 =?iso-8859-1?Q?BDLIaPgIR2xGP+sFUsceh4tc55ZFujgpTJ+GDyyleo2/sonthTXkvQY7oX?=
 =?iso-8859-1?Q?uwTYbgKyLe0/ZSiVAnobZy+hNJJfo/V0rXLg4NvLiIDbuLb1NDEeFjv4Dy?=
 =?iso-8859-1?Q?knmA1eQTyhkLrcgkLvCM8/TUaNs2sKJEM5+dV74mraxAE4YWfGyrmdB7oy?=
 =?iso-8859-1?Q?4UMuLKLH4hmNzaYXtAj/AlhW7itBKDPUuG0AOIjha2JDxO6nrTRVvWA8ZH?=
 =?iso-8859-1?Q?KL/8NLiwRCmCyL49KkfZmTTmpeAhZ/P/Po2YkDyXeCC9ylUsykZPsafrmY?=
 =?iso-8859-1?Q?7Ji3bJmzsZ4vzF/zP/ESRylsvrZQWnu44m1AxqQzXu7hYWXmb4WMpaUgou?=
 =?iso-8859-1?Q?o7XvKLSRYNTpT0aSnzhXUqwr3iork5gQbjnQ6xt4XPLCXH+B+qhTuB2WSu?=
 =?iso-8859-1?Q?KaXI1g0i0zluZRY2uhZNszSh/38UBy42wJkL81/1psUFf/qef3ZKTglYoU?=
 =?iso-8859-1?Q?cArC/EChW2ndrnSdU6/4h+tV+n7r2WxLrEPWvKkEWMjSlWbeUbX5Qxj+lx?=
 =?iso-8859-1?Q?/8kQP3BlDkcWCN1VvW6Z0Lz/fTWAV2IXKOHIUfkNNeeyUodoyIruAeTwSG?=
 =?iso-8859-1?Q?WjESd2GMF0bl77/m6YT6xX8jdHtufKzIZ/dpiTVXD/GzsxxQRfzt5NrTuj?=
 =?iso-8859-1?Q?wgvRQExrlamD4+XCqGi2RDUJcoI07XPd9MTq952fSPotQYfwmkXkgUvxq4?=
 =?iso-8859-1?Q?TnBKm5Lkj819KCTV03PPhBuhAOtozhiADzhRMx8g7d8mDGq4TZ9+UYQrTJ?=
 =?iso-8859-1?Q?ZNWN+nu6E8q891CvPjDZ9aQWkGh/PK5hDmzIb1afMYDo/X5yn4Yx5BmlPL?=
 =?iso-8859-1?Q?HgDCwe34auGYjvQihaHeSYvN/aF2b1QWq87ryrxzH1fypeOq0y2tCdp9o3?=
 =?iso-8859-1?Q?9v/WkS7+jqL+qPGeF9QSWLAPYduKgJz1ZxjifiH1F7qRX6MV6Ngzs8Aww0?=
 =?iso-8859-1?Q?uJ5elaYLj1RNiCiBhQC8NNr0FPgAoo4/uVKndiy+QSn1jhxpUGSMuJZu7V?=
 =?iso-8859-1?Q?OysRj/vqGFr1elF0seOkMTtqgkNIGik/tL8cJ1MMNgRmkiEhWP84ADnolV?=
 =?iso-8859-1?Q?vs9I4I7cQ4l9HW4DlDnzxgDOvv93QnS8QYHYlqzyWP/PN/Fai2leTuF0By?=
 =?iso-8859-1?Q?8OOT782ECzBQlgB3iwrEgK77dILph/OTk8?=
Content-Type: multipart/mixed;
 boundary="_007_AS8PR09MB59712D1E8F1607F9E430CC19EE512AS8PR09MB5971eurp_"
MIME-Version: 1.0
X-OriginatorOrg: ugent.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB5971.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60a20e8-8e0e-4fd7-8c4d-08dc31658efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 16:12:24.0106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d7811cde-ecef-496c-8f91-a1786241b99c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+EItrbhpVunksxr1LQcl3KLrMKZGGzW8NvmbBSb63sGwNoeHNlxyZ2XthmM6LzdhTyqawP0Eh/XoBjIYaywj492vxF9uhBJb9dd9gbm6vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4390
X-Mailman-Approved-At: Mon, 19 Feb 2024 17:13:23 +0100
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

--_007_AS8PR09MB59712D1E8F1607F9E430CC19EE512AS8PR09MB5971eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear reader,

For my master thesis in Electrical Engineering I am working on providing Op=
enWRT support for pynqz2 and adrv9361 boards (armv7 32bit).
OpenWRT uses U-Boot 2019.07.

In the default config file (that I partly had to add stuff/remove stuff mys=
elf, see attachment zynq_pynqz2_defconfig), the CONFIG_SPL_OS_BOOT setting =
is set to yes.
This failed during boot, the boot image is a FIT image.

Booting via load+bootm works (see attachment boot_commands.txt and load_boo=
tm_log.txt).

If I understand it correctly, this is a SIMPLE_FIT?

I have been trying to get the SPL to boot the kernel for a few days now.
It seems to be stuck on the gunzip function (see attachment SPL_log.txt)

Does anybody has a clue to what is going on here?
Documentation and more about SPL booting kernel and FIT images are always w=
elcome.

Kind regards,

Robbe Gaeremynck
Student ma - Electrical Engineering - Electronic Circuits and Systems

--_007_AS8PR09MB59712D1E8F1607F9E430CC19EE512AS8PR09MB5971eurp_
Content-Type: text/plain; name="boot_commands.txt"
Content-Description: boot_commands.txt
Content-Disposition: attachment; filename="boot_commands.txt"; size=138;
	creation-date="Mon, 19 Feb 2024 16:08:33 GMT";
	modification-date="Mon, 19 Feb 2024 16:08:57 GMT"
Content-Transfer-Encoding: base64

bHMgbW1jIDA6MQpsb2FkIG1tYyAwOjEgMHgxMDAwMDAwIGZpdC5pdGIKc2V0IGJvb3RhcmdzICdj
b25zb2xlPXR0eVBTMCwxMTUyMDBuOCByb290PS9kZXYvbW1jYmxrMHAyIHJvb3R3YWl0IGVhcmx5
cHJpbnRrJwpib290bSAweDEwMDAwMDAK

--_007_AS8PR09MB59712D1E8F1607F9E430CC19EE512AS8PR09MB5971eurp_
Content-Type: text/plain; name="load+bootm_log.txt"
Content-Description: load+bootm_log.txt
Content-Disposition: attachment; filename="load+bootm_log.txt"; size=1599;
	creation-date="Mon, 19 Feb 2024 16:08:34 GMT";
	modification-date="Mon, 19 Feb 2024 16:08:57 GMT"
Content-Transfer-Encoding: base64

WnlucT4gbG9hZCBtbWMgMDoxIDB4MTAwMDAwMCBmaXQuaXRiCnJlYWRpbmcgZml0Lml0YiBhdCBw
b3MgMCwgbWF4c2l6ZSAwLCB0byBtZW1vcnkgcG9zIDB4MDEwMDAwMDAKNDk0NzIyOCBieXRlcyBy
ZWFkIGluIDI4MyBtcyAoMTYuNyBNaUIvcykKWnlucT4gYm9vdG0gMHgxMDAwMDAwCiMjIExvYWRp
bmcga2VybmVsIGZyb20gRklUIEltYWdlIGF0IDAxMDAwMDAwIC4uLgogICBVc2luZyAnY29uZmln
LTEnIGNvbmZpZ3VyYXRpb24KICAgVHJ5aW5nICdrZXJuZWwtMScga2VybmVsIHN1YmltYWdlCiAg
ICAgRGVzY3JpcHRpb246ICBBUk0gT3BlbldydCBMaW51eC01LjE1LjEzOAogICAgIFR5cGU6ICAg
ICAgICAgS2VybmVsIEltYWdlCiAgICAgQ29tcHJlc3Npb246ICBnemlwIGNvbXByZXNzZWQKICAg
ICBEYXRhIFN0YXJ0OiAgIDB4MDEwMDAwZTQKICAgICBEYXRhIFNpemU6ICAgIDQ5MzY4MTQgQnl0
ZXMgPSA0LjcgTWlCCiAgICAgQXJjaGl0ZWN0dXJlOiBBUk0KICAgICBPUzogICAgICAgICAgIExp
bnV4CiAgICAgTG9hZCBBZGRyZXNzOiAweDAwMDA4MDAwCiAgICAgRW50cnkgUG9pbnQ6ICAweDAw
MDA4MDAwCiAgICAgSGFzaCBhbGdvOiAgICBjcmMzMgogICAgIEhhc2ggdmFsdWU6ICAgNTI0MGQ1
YmIKICAgICBIYXNoIGFsZ286ICAgIHNoYTEKICAgICBIYXNoIHZhbHVlOiAgIDQ2MDAyNzFlNDFl
MDFmMzE5NGE1MzcyNDY3MTc5ZTg1MmIwNmQzODkKICAgVmVyaWZ5aW5nIEhhc2ggSW50ZWdyaXR5
IC4uLiBjcmMzMisgc2hhMSsgT0sKIyMgTG9hZGluZyBmZHQgZnJvbSBGSVQgSW1hZ2UgYXQgMDEw
MDAwMDAgLi4uCiAgIFVzaW5nICdjb25maWctMScgY29uZmlndXJhdGlvbgogICBUcnlpbmcgJ2Zk
dC0xJyBmZHQgc3ViaW1hZ2UKICAgICBEZXNjcmlwdGlvbjogIEFSTSBPcGVuV3J0IHR1bF96eW5x
LXB5bnEtejIgZGV2aWNlIHRyZWUgYmxvYgogICAgIFR5cGU6ICAgICAgICAgRmxhdCBEZXZpY2Ug
VHJlZQogICAgIENvbXByZXNzaW9uOiAgdW5jb21wcmVzc2VkCiAgICAgRGF0YSBTdGFydDogICAw
eDAxNGI1NjkwCiAgICAgRGF0YSBTaXplOiAgICA4NTE4IEJ5dGVzID0gOC4zIEtpQgogICAgIEFy
Y2hpdGVjdHVyZTogQVJNCiAgICAgSGFzaCBhbGdvOiAgICBjcmMzMgogICAgIEhhc2ggdmFsdWU6
ICAgMjZkY2VmMDQKICAgICBIYXNoIGFsZ286ICAgIHNoYTEKICAgICBIYXNoIHZhbHVlOiAgIDRk
MGVlYjZlNzBmMWI4N2M4ZGY5ZjI1NzZkMDVlYzc3OTE5ZTQzMWIKICAgVmVyaWZ5aW5nIEhhc2gg
SW50ZWdyaXR5IC4uLiBjcmMzMisgc2hhMSsgT0sKICAgQm9vdGluZyB1c2luZyB0aGUgZmR0IGJs
b2IgYXQgMHgxNGI1NjkwCiAgIFVuY29tcHJlc3NpbmcgS2VybmVsIEltYWdlIC4uLiBkc3RfYWRk
ciAwMDAwODAwMCB8IHVuY19sZW4gNjI5MTQ1NjAgfCBpbWdfYnVmIDAxMDAwMGU0IHwgbGVucCA0
OTM2ODE0Ck9LCiAgIGtlcm5lbCBsb2FkZWQgYXQgMHgwMDAwODAwMCwgZW5kID0gMHgwMGM5YWIw
MAogICBMb2FkaW5nIERldmljZSBUcmVlIHRvIDFlYjM1MDAwLCBlbmQgMWViM2ExNDUgLi4uIE9L
CiMjIFRyYW5zZmVycmluZyBjb250cm9sIHRvIExpbnV4IChhdCBhZGRyZXNzIDAwMDA4MDAwKS4u
LgoK

--_007_AS8PR09MB59712D1E8F1607F9E430CC19EE512AS8PR09MB5971eurp_
Content-Type: text/plain; name="SPL_log.txt"
Content-Description: SPL_log.txt
Content-Disposition: attachment; filename="SPL_log.txt"; size=543;
	creation-date="Mon, 19 Feb 2024 16:08:34 GMT";
	modification-date="Mon, 19 Feb 2024 16:08:57 GMT"
Content-Transfer-Encoding: base64

VS1Cb290IFNQTCAyMDE5LjA3LU9wZW5XcnQtcjIzNjM0LWEzOWRjYTdlYWQgKE5vdiAxOSAyMDIz
IC0gMTM6NDQ6MzYgKzAwMDApCm1tYyBib290ClRyeWluZyB0byBib290IGZyb20gTU1DMQpzcGxf
bW1jX2xvYWRfaW1hZ2Ugc3RhcnQKQ09ORklHX1NQTF9GQVRfRkFUIDogbm90IHN0YXJ0aW5nIHVi
b290CnJlYWRpbmcgc3lzdGVtLmR0YiBhdCBwb3MgMCwgbWF4c2l6ZSAwLCB0byBtZW1vcnkgcG9z
IDB4MTAwMDAwMDAKcmVhZGluZyBmaXQuaXRiIGF0IHBvcyAwLCBtYXhzaXplIDY0LCB0byBtZW1v
cnkgcG9zIDB4MDNmZmZmYzAKcmVhZGluZyBmaXQuaXRiIGF0IHBvcyAwLCBtYXhzaXplIDQ5NDcy
MjgsIHRvIG1lbW9yeSBwb3MgMHgwMTAwMDAwMAplbWJlZGRlZCBkYXRhCmNhbGxpbmcgZ3Vuemlw
IGRzdF9hZGRyOiAwMDAwODAwMCB8IHVuY19sZW4gNjI5MTQ1NjAgfCBpbWdfYnVmIDAxMDAwMGU0
IHwgbGVucCA0OTM2ODE0CmRzdF9hZGRyIDAwMDA4MDAwIHwgdW5jX2xlbiA2MjkxNDU2MCB8IGlt
Z19idWYgMDEwMDAwZTQgfCBsZW5wIDQ5MzY4MTQK

--_007_AS8PR09MB59712D1E8F1607F9E430CC19EE512AS8PR09MB5971eurp_
Content-Type: text/plain; name="zynq_pynqz2_defconfig.txt"
Content-Description: zynq_pynqz2_defconfig.txt
Content-Disposition: attachment; filename="zynq_pynqz2_defconfig.txt";
	size=1824; creation-date="Mon, 19 Feb 2024 16:08:35 GMT";
	modification-date="Mon, 19 Feb 2024 16:08:57 GMT"
Content-Transfer-Encoding: base64

Q09ORklHX0FSTT15CkNPTkZJR19BUkNIX1pZTlE9eQpDT05GSUdfU1lTX1RFWFRfQkFTRT0weDQw
MDAwMDAKQ09ORklHX1NQTD15CkNPTkZJR19ERUJVR19VQVJUX0JBU0U9MHhlMDAwMDAwMApDT05G
SUdfREVCVUdfVUFSVF9DTE9DSz01MDAwMDAwMApDT05GSUdfU1BMX1NUQUNLX1JfQUREUj0weDIw
MDAwMApDT05GSUdfREVCVUdfVUFSVD15CkNPTkZJR19ESVNUUk9fREVGQVVMVFM9eQoKQ09ORklH
X1NQTF9HWklQPXkgIyBLZXJuZWwgaXMgY29tcHJlc3NlZCBhcyBnemlwLCBzZWUgYnVpbGQgcHJv
Y2VzcyBvcGVud3J0CkNPTkZJR19ERUJVRz15CiMgREVCVUc6VHJ5aW5nIHRvIGNsb25lIHJrMzMy
OApDT05GSUdfRklUPXkKIyBDT05GSUdfRklUX1NJR05BVFVSRT15CkNPTkZJR19GSVRfVkVSQk9T
RT15CiMgQ09ORklHX0lNQUdFX0ZPUk1BVF9MRUdBQ1k9eQpDT05GSUdfU1BMX1NUQUNLX1I9eQpD
T05GSUdfU1BMX09TX0JPT1Q9eQpDT05GSUdfU1BMX0xPQURfRklUPXkgLy8gU2luZ2xlIGtlcm5l
bCArIGZkdCBibG9iID0gc2ltcGxlIGZpdCBpbWFnZQpDT05GSUdfREVGQVVMVF9GRFRfRklMRT0i
c3lzdGVtLmR0YiIKIyBDT05GSUdfU1BMX1NQSV9MT0FEPXkKQ09ORklHX1NQTF9QQVlMT0FEPSJm
aXQuaXRiIgpDT05GSUdfU1lTX0xPQURfQUREUj0weDEwMDAwMDAKQ09ORklHX1NQTF9NTUNfQk9P
VD15CgpDT05GSUdfU1lTX1BST01QVD0iWnlucT4gIgpDT05GSUdfQ01EX1RIT1JfRE9XTkxPQUQ9
eQpDT05GSUdfQ01EX0RGVT15CiMgQ09ORklHX0NNRF9GTEFTSCBpcyBub3Qgc2V0CkNPTkZJR19D
TURfRlBHQV9MT0FEQlA9eQpDT05GSUdfQ01EX0ZQR0FfTE9BREZTPXkKQ09ORklHX0NNRF9GUEdB
X0xPQURNSz15CkNPTkZJR19DTURfRlBHQV9MT0FEUD15CkNPTkZJR19DTURfR1BJTz15CkNPTkZJ
R19DTURfTU1DPXkKQ09ORklHX0NNRF9TRj15CkNPTkZJR19DTURfVVNCPXkKIyBDT05GSUdfQ01E
X1NFVEVYUFIgaXMgbm90IHNldApDT05GSUdfQ01EX1RGVFBQVVQ9eQpDT05GSUdfQ01EX0NBQ0hF
PXkKQ09ORklHX0NNRF9FWFQ0X1dSSVRFPXkKQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9Inp5
bnEtcHlucS16MiIKQ09ORklHX0VOVl9JU19JTl9TUElfRkxBU0g9eQpDT05GSUdfTkVUX1JBTkRP
TV9FVEhBRERSPXkKQ09ORklHX1NQTF9ETV9TRVFfQUxJQVM9eQpDT05GSUdfREZVX01NQz15CkNP
TkZJR19ERlVfUkFNPXkKQ09ORklHX0ZQR0FfWElMSU5YPXkKQ09ORklHX0ZQR0FfWllOUVBMPXkK
Q09ORklHX0RNX0dQSU89eQpDT05GSUdfTU1DX1NESENJPXkKQ09ORklHX01NQ19TREhDSV9aWU5R
PXkKQ09ORklHX1NQSV9GTEFTSD15CkNPTkZJR19TUElfRkxBU0hfQkFSPXkKQ09ORklHX1NQSV9G
TEFTSF9TUEFOU0lPTj15CkNPTkZJR19QSFlfUkVBTFRFSz15CkNPTkZJR19NSUk9eQpDT05GSUdf
WllOUV9HRU09eQpDT05GSUdfWllOUV9HRU1fU1BJX01BQ19PRkZTRVQ9MHgyMApDT05GSUdfREVC
VUdfVUFSVF9aWU5RPXkKQ09ORklHX1pZTlFfU0VSSUFMPXkKQ09ORklHX1pZTlFfUVNQST15CkNP
TkZJR19VU0I9eQpDT05GSUdfVVNCX0VIQ0lfSENEPXkKQ09ORklHX1VTQl9VTFBJX1ZJRVdQT1JU
PXkKQ09ORklHX1VTQl9VTFBJPXkKQ09ORklHX1VTQl9HQURHRVQ9eQpDT05GSUdfVVNCX0dBREdF
VF9NQU5VRkFDVFVSRVI9IlhpbGlueCIKQ09ORklHX1VTQl9HQURHRVRfVkVORE9SX05VTT0weDAz
ZmQKQ09ORklHX1VTQl9HQURHRVRfUFJPRFVDVF9OVU09MHgwMzAwCkNPTkZJR19DSV9VREM9eQpD
T05GSUdfVVNCX0dBREdFVF9ET1dOTE9BRD15CkNPTkZJR19VU0JfRlVOQ1RJT05fVEhPUj15CgoK

--_007_AS8PR09MB59712D1E8F1607F9E430CC19EE512AS8PR09MB5971eurp_--
