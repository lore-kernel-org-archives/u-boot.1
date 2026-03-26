Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8896109E54B
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 04:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF1584127;
	Thu, 26 Mar 2026 05:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Student.rmit.edu.au header.i=@Student.rmit.edu.au header.b="OdcmeAVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6995780517; Thu, 26 Mar 2026 05:41:22 +0100 (CET)
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E2F83E76
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=S4210155@student.rmit.edu.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkNHW8Ta4EeC4lAwUMQjXvGTpFhdnYgHHe8HXlhIt8gwcJlmjNoBr8NPLt3stftWgFFnWQPNaLgCES+L+vH20s3v48p9DbGZ70PszzC0BAp7o3IS/h1fU3GGU3kEEkqMqzShI/4AwODcMuYxP0evCzy8ANhgbobf07CoBrSzHkiJrD7W31JEY5rseuEbrwt5YIhqC5MC3o2bi+cdIDPctOfMpBOwrnMnmyv23FZe2GywkktUCu9k0wXDL3iHECQsvJBF1vB7CTrS8+UwzqLBqSItRrMhexE/jHemGLvbXnujKAEijh5mhP50+tfXeicZVEeEN9TvTK8LKmXz7aasiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGGU+TLzV1TQO8JJddD/1o1zI7AM9bgWoQBSPqgXOGw=;
 b=X7Bz4UluNUbz2VdgT2JBeR8tMeMVodvIRg3e2hs9eTdaEhz/RJ+inF4UzXJ6srlF4+PoWg0h2FTKSVvNTW1vpU8sL5MQFHR8vM1TEvWrWxiGOu1ECay5OSDSsTHF6KojIHMdHh1EAQnhbEuyZnJmV05PpHMhERZA/L8NjdNqj/N4E3bpzF8I18eEJzRZuqdiwOciffNPXgk25NCiV6gEmCYHLFxMp4hMx25qhZXktOUkPiRGZWib07390/TLIq18NvH3Ax6T1jtYnzzcD9b6v6JfOsWx1+s3+QvcUNJBhW5fgvVXQpGYlhv7za/rhIKgBZ0HfKHYlTCoeuQSTufDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.rmit.edu.au; dmarc=pass action=none
 header.from=student.rmit.edu.au; dkim=pass header.d=student.rmit.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Student.rmit.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGGU+TLzV1TQO8JJddD/1o1zI7AM9bgWoQBSPqgXOGw=;
 b=OdcmeAVtgTsNZNt5pUQ0dSg2UWwheD4oCVVvkfVfFdx7sXDFdQ/+NQCgqMleNHzqSae8QdWiGI8hTCUIUGy9JpkIkdiq9VuH89Yt53VWQPoi2SskXnAOXNCBs985Yx7N9rJlHIyvaMwzJJZpoGQiPzW+VwFAwgtVsC8asi7b3cY=
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com (2603:10c6:10:10e::6)
 by SY6PR01MB8441.ausprd01.prod.outlook.com (2603:10c6:10:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 04:41:10 +0000
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac]) by SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 04:41:10 +0000
From: Tra Ngo <S4210155@student.rmit.edu.au>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: [SECURITY][4/4] Stack buffer overflow in Samsung board code (sprintf
 concatenation)
Thread-Topic: [SECURITY][4/4] Stack buffer overflow in Samsung board code
 (sprintf concatenation)
Thread-Index: AQHcvNlotvifXdiKDEOh+0XuIvd/hw==
Date: Thu, 26 Mar 2026 04:41:10 +0000
Message-ID: <SY4PR01MB63165899EC06BC60BB36A5659A56A@SY4PR01MB6316.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.rmit.edu.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4PR01MB6316:EE_|SY6PR01MB8441:EE_
x-ms-office365-filtering-correlation-id: 3f8ca751-0247-43be-aed2-08de8af1e763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|6049299003|1800799024|786006|376014|8096899003|4053099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: jli2NdukloDrZF2habT58up5T7PDsy5ocCEJOnWiQBcbYOI/SIHVdUL745x8+fAs2a47WTKMiXFfIm1lSJUAafJVzCO8aNM0jip5jPTaVOFC9YjL/pFW4RaBuG++EyTMrVwMtbH/OXRv7KizhoHLhwUXefALiOpqw+ZoV6GX/o0ISpbLq3l8I7YGNP2i1+yTTR03ndn+WDQx1FmOOwhera7WDXmYudYQJqaGp16mlIgGXccqRG4WIggfCHQtl6OerS7dtTVDm+mT3wc96FVX+3iWw5GMePkUkwTl/mP2xZBepkNCAssFGbXK43tavaJiA9UqFjIpQ5WSRkfhIe4onpmk+yHwe8RGX10SCEuDedFJaGiJ0NjU2vBsetWkTA2xnKGRdqiPcQWX7icsdHIjZwBSHPgVCjlECueBnE9jAYXz4GEsrwllE6w9KXK2XAoFzqRxunbCenWQ+hOw9TCcSuijkw2aYNbSc9c+v+Coyi0trVm+Brdqz3EeFBWaECtI73oFTyJnvFMl8fhcstYz9t7pDFMJLdTfMCORy1m4Y7HbAOz2veytm4cBsIz1CB8YkEaLb0AUvNKlu0JeAq7v+6B7jdGvOmnC7iEInl47hMXLeK2m8WzmsDC07vsTWVsNDU2ejkkFGQh63ZVsXI2yp3+551n/X/bftVQLpcYa5NQJ2fvIg879+6xoxHeJQx5y4mqR9OapWLZFnhfwVRIyT0WsgX0ot2uctaJKBvAiemE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY4PR01MB6316.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(6049299003)(1800799024)(786006)(376014)(8096899003)(4053099003)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UmCXJA6IS2Kgcpr2J8dKKZ1k6c1Ps0KCXjSP0JE6AIwpV/UZ2fg5K+h2j6+I?=
 =?us-ascii?Q?lDD20pnHk1tFXVT1bw3lFed5Pg9l634DhP3UBg5Mn2ln+7SqwIUIebbfiRTV?=
 =?us-ascii?Q?X3n2rAPtla3cYUo1HcKMHNj7lyqoCHLFL4sVxnNJxqxS91CkiGKldIep1MMD?=
 =?us-ascii?Q?Rbg6SJVM6zvdWXjPZzP++0kGLPwXRfLUglK1u6+aU2af+/C9v07t8X/MYu3p?=
 =?us-ascii?Q?+mWk+W515eVQSlNWMhATNqSX1JJILUK8LOQLmOD1QNO1oJxvGU+dRJZGqJIP?=
 =?us-ascii?Q?PwTyZM9AmBPytUAVL2Vho8XCKb24dKhUFkB3UcohyUr/nQO0VLBgvKzI5zQC?=
 =?us-ascii?Q?uBX5gtBkTArJQYIu0itxMsYogRokV4nrhSwTQr+VCQHx+Dlcvc4DreGyzHNv?=
 =?us-ascii?Q?OsRXuTxv6RgbxcWPToKw/T4dXwJXAPW4URjDuzsxK3CVvDPH2WMU1sh44JG5?=
 =?us-ascii?Q?W+RpgQbvcEj0PH+ieurP+ElJDNbbhoc8QkISubGDlte0Qy0w+Jvsh8AeagtV?=
 =?us-ascii?Q?EqhxcVv1nueYld8zRtu1hBWCcyVd6E+bEbOg3qafYsPqJxhRm/9GMOK+QDmE?=
 =?us-ascii?Q?nJfhpCbrsYbMwivjCi8EZlH40X7uyOpV/Okw9KM8GJl172I86S81QokqOdbo?=
 =?us-ascii?Q?QGsqfk+pvw2GK0SmbUbc3GoxGxQQA1O6BmsHnP7IN2nCcLtJNTMgBKnGbxcU?=
 =?us-ascii?Q?JR3ac7EQy5ZJip5d6+7ONNImqU+Jgh9qqRhl365cjuFPLkICIdit5RnMrqt5?=
 =?us-ascii?Q?T3gGVCO/0uCdT0kVJ/O9pVJC1pPaLZZPGHkqRBRcAcEr90x7+FaOl9xmF3eb?=
 =?us-ascii?Q?oA93i8fQ228+XbtUuGZkU+xAznnAxwSwMOzaAH/mpZ0m8ihbuxn5e84w6vyS?=
 =?us-ascii?Q?HtlOXBwTiLXVeZ/t+amV7oi47YXPg1qEXePg9LEZ7giyoqSJBoOU+eV1z68M?=
 =?us-ascii?Q?uBLiJwJx7Key+F8Wc5OMEXXLtzeZ5c+/vKWhlzJFCjzCCSAwdRUrJsEQHOT7?=
 =?us-ascii?Q?KqrLACZvbCsLFdIviAfOFO+onKUCmI3DVdmzDi4Qme8Hz33e+M+kWbG3jd+j?=
 =?us-ascii?Q?zeJa1uas8Bs/TtmzPeaU1fE73F3nIvZujqkhfHjf6/eQeAVwtlLcYcjYoC5c?=
 =?us-ascii?Q?noHVG015uU0mbp7Ie4vktKwY7w9HsJ+U49dFSEnU+SQGbjr0IfWkvHgMxsFY?=
 =?us-ascii?Q?ZURIMsRZPC+rHBdmyj/x66ZTb/94ziMmjYWIoVuQHSJjm14RN+MBGlPeqXA1?=
 =?us-ascii?Q?UXPg7Gob9+DzdHLPhmXMmd2kPiwFAfMF7htj+1QRK0pLr28DDGhNariLtixH?=
 =?us-ascii?Q?GOCleQ1SpnWyUDny0nbaJE8DaJeUeBRgI8b9Bbq+pDzPYsADugKY0OU7yX52?=
 =?us-ascii?Q?z4wwT5xIb+iQqkG8V8yAUG/G8fLDoNBN0swHakCq749MAoH3gzc587dey+Ws?=
 =?us-ascii?Q?dYCTsmzCxbAQpCqpJrfppXe3PQFTFvRy5sYMKK219tp7cKwNrTD7PLhy/K/Z?=
 =?us-ascii?Q?nCU7stMgcfj/TUhjYocJah3cEJYeBGZo7jjoHVNuFc20VMn5aLQgbZ7Z6GQV?=
 =?us-ascii?Q?tr1G0hNdGtugMBguic04PTCm6o1Nmgeu4tVAXdBYZrrN4ukC+el1/MXYCSJj?=
 =?us-ascii?Q?EFa4QgCmtANEdeNW6L+p0s1TxV5c5OObhQHePgojKYP1/I5/DnQNT2u9Lx1c?=
 =?us-ascii?Q?OmF9h0pPAszFK52SCmvoaTBAXL3oTAIJXURgTuYxhPajpXqsj6ax1PifRQo8?=
 =?us-ascii?Q?FamGUTQoS/gYEE2b0yiEZw2Kq7M3BxbSGQlQJ6ByUDAvrZh+YlW6?=
Content-Type: multipart/mixed;
 boundary="_004_SY4PR01MB63165899EC06BC60BB36A5659A56ASY4PR01MB6316ausp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r/M8s2x74xIDof2dNQE+LPZ/hsmf89oJcm/6AnzoUTqGXd4USr+zd7kTRpv1yZWb0tFxvG/89kWnDrWHbFBdgCqlp+1fP21WocDkniyxeBxoFr8gfPbtatKMCgW2fPX7J1ZpJv5u/KajM5cZutX+RAOWvqOa7KSHhZafXcgM28cUZN7v5LJE1FFu8RggLuiVVEayLMcnVLpjqLqX0ms+wZlETEKxRg7imn4Sw9yuY9eH8WY0LLw1++WFJnURHvQr5JSf9wB9pvnI3Jwe5+ktQCaACZMtjYtfLmDT63fHQ8H2OfSwUUtmFOJVnFXhZ9QqSjuZ4yNypZTEnuQFbj7hFQ==
X-OriginatorOrg: Student.rmit.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY4PR01MB6316.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8ca751-0247-43be-aed2-08de8af1e763
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 04:41:10.6764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d1323671-cdbe-4417-b4d4-bdb24b51316b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTIb0yw4wkY+1Tvbnaihk3FVJqPQoWisgjfY5P780n8Z2n94FDh5qOhpEeMuOsCO4wnoqpGeVRKpeBHwr4sfWmBbRbFHDYFzpfD2+Bvctqk=
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

--_004_SY4PR01MB63165899EC06BC60BB36A5659A56ASY4PR01MB6316ausp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear U-Boot maintainers,

I would like to report a potential stack buffer overflow in board/samsung/c=
ommon/misc.c (set_board_info()).

The issue arises from an unbounded sprintf() used to concatenate bdname and=
 bdtype into a fixed-size buffer.

This may lead to overflow when the combined string exceeds the buffer size.

I have attached a detailed analysis, including root cause and suggested fix=
.

This is part of a set of related issues reported separately.

Please let me know if you would like a patch or further details.

Best regards,
Ngo Tra <https://aka.ms/GetOutlookForMac>

--_004_SY4PR01MB63165899EC06BC60BB36A5659A56ASY4PR01MB6316ausp_
Content-Type: application/octet-stream; name="UCCG-UBOOT-04.md"
Content-Description: UCCG-UBOOT-04.md
Content-Disposition: attachment; filename="UCCG-UBOOT-04.md"; size=3683;
	creation-date="Thu, 26 Mar 2026 04:31:31 GMT";
	modification-date="Thu, 26 Mar 2026 04:31:31 GMT"
Content-Transfer-Encoding: base64

PT09IFtVQ0NHLVVCT09ULTA0XTogY2xpX2h1c2guYyBzdHJjcHkoKSBjYW4gb3ZlcmZsb3cgY29u
c29sZV9idWZmZXIgKENPTkZJR19TWVNfQ0JTSVpFLWRlcGVuZGVudCkgPT09CgpTdW1tYXJ5Ci0t
LS0tLS0KLSBUeXBlOiBnbG9iYWwgYnVmZmVyIG92ZXJmbG93IChzdHJpbmctbGVuZ3RoIGRlcGVu
ZGVudCkKLSBBZmZlY3RlZCBjb21wb25lbnQ6IEh1c2ggQ0xJIGJvb3QtcmV0cnkgdGltZW91dCBo
YW5kbGluZyAoYXV0by1pbmplY3QgYHJ1biBib290Y21kYCkKLSBTZXZlcml0eSAocmVwb3J0ZXLi
gJlzIGVzdGltYXRlKTogTWVkaXVtIChtZW1vcnkgY29ycnVwdGlvbiBwb3NzaWJsZSBpZiBDT05G
SUdfU1lTX0NCU0laRSBpcyBzZXQgdG9vIHNtYWxsKQoKRW52aXJvbm1lbnQgLyBWZXJzaW9uCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLQotIFUtQm9vdCB0cmVlOgogIC0gTG9jYWwgdHJlZTogdWNjZy91
LWJvb3QgKHdvcmtzcGFjZSkKLSBCb2FyZCAvIHRhcmdldDoKICAtIEdlbmVyaWMgKGRlcGVuZHMg
b24gY29uZmlndXJhdGlvbiBvZiBgQ09ORklHX1NZU19DQlNJWkVgIGFuZCBib290IHJldHJ5IG9w
dGlvbnMpCgpGaWxlcyBhbmQgTG9jYXRpb25zCi0tLS0tLS0tLS0tLS0tLS0tLS0KLSBTb3VyY2Ug
ZmlsZTogY29tbW9uL2NsaV9yZWFkbGluZS5jCi0gQnVmZmVyOgogIC0gY2xpX3JlYWRsaW5lLmM6
MjY6IGNoYXIgY29uc29sZV9idWZmZXJbQ09ORklHX1NZU19DQlNJWkUgKyAxXTsKLSBTb3VyY2Ug
ZmlsZTogY29tbW9uL2NsaV9odXNoLmMKLSBWdWxuZXJhYmxlIHNpbms6CiAgLSBjbGlfaHVzaC5j
OjEwMzI6IHN0cmNweShjb25zb2xlX2J1ZmZlciwgInJ1biBib290Y21kXG4iKTsKLSBUcmlnZ2Vy
aW5nIGNvZGUgcGF0aDoKICAtIGNsaV9odXNoLmM6MTAyNi0xMDM2OiBpbiB0aGUgYENPTkZJR19C
T09UX1JFVFJZX1RJTUVgIHRpbWVvdXQgY2FzZSwgd2hlbiBgSVNfRU5BQkxFRChDT05GSUdfUkVU
UllfQk9PVENNRClgCi0gQ29uZmlndXJhdGlvbiBzb3VyY2U6CiAgLSBjb21tb24vS2NvbmZpZzo1
NS02NzogY29uZmlnIFNZU19DQlNJWkUgKGNvbnNvbGUgaW5wdXQgYnVmZmVyIHNpemUpCgpDb25m
aWd1cmF0aW9uLWRlcGVuZGVudCBkYXRhZmxvdwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQotIENPTkZJR19TWVNfQ0JTSVpFOgogIC0gRGV0ZXJtaW5lcyB0aGUgc2l6ZSBvZiBgY29u
c29sZV9idWZmZXJgIGFzIGBDT05GSUdfU1lTX0NCU0laRSArIDFgLgogIC0gVXN1YWxseSBsYXJn
ZSBieSBkZWZhdWx0LCBidXQgY2FuIGJlIG92ZXJyaWRkZW4gYnkgYSBib2FyZCBkZWZjb25maWcg
b3IgbWFudWFsIGNvbmZpZ3VyYXRpb24uCi0gQ09ORklHX0JPT1RfUkVUUllfVElNRToKICAtIEVu
YWJsZXMgYSB0aW1lb3V0IHBhdGggZm9yIGNvbW1hbmQgaW5wdXQuCi0gQ09ORklHX1JFVFJZX0JP
T1RDTUQ6CiAgLSBDYXVzZXMgVS1Cb290IHRvIGluamVjdCB0aGUgY29tbWFuZCBzdHJpbmcgYCJy
dW4gYm9vdGNtZFxuImAgb24gdGltZW91dCB2aWEgYHN0cmNweSgpYC4KClZ1bG5lcmFiaWxpdHkg
ZGVzY3JpcHRpb24KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotIEV4cGVjdGVkIGludmFyaWFu
dDoKLSBUaGUgY29kZSBtdXN0IG5ldmVyIHdyaXRlIG1vcmUgdGhhbiBgc2l6ZW9mKGNvbnNvbGVf
YnVmZmVyKWAgYnl0ZXMgd2hlbiB3cml0aW5nIGFuIGluamVjdGVkIGNvbW1hbmQgaW50byB0aGUg
Y29uc29sZSBidWZmZXIuCgotIEFjdHVhbCBiZWhhdmlvcjoKLSBgY29uc29sZV9idWZmZXJgIGhh
cyBmaXhlZCBzaXplIGBDT05GSUdfU1lTX0NCU0laRSArIDFgLgotIE9uIHRpbWVvdXQgKHdpdGgg
YENPTkZJR19SRVRSWV9CT09UQ01EYCksIHRoZSBjb2RlIHVzZXMgYHN0cmNweShjb25zb2xlX2J1
ZmZlciwgInJ1biBib290Y21kXG4iKWAuCi0gYHN0cmNweSgpYCBwZXJmb3JtcyBubyBib3VuZHMg
Y2hlY2tpbmc7IGl0IGFzc3VtZXMgdGhlIGRlc3RpbmF0aW9uIGlzIGxhcmdlIGVub3VnaCBmb3Ig
dGhlIGZ1bGwgc291cmNlIHN0cmluZyBwbHVzIHRoZSB0ZXJtaW5hdGluZyBOVUwuCi0gVGhlcmVm
b3JlLCBpZiBgQ09ORklHX1NZU19DQlNJWkVgIGlzIGNvbmZpZ3VyZWQgc21hbGxlciB0aGFuIHRo
ZSBpbmplY3RlZCBzdHJpbmcgbGVuZ3RoLCBgc3RyY3B5KClgIHdyaXRlcyBwYXN0IHRoZSBlbmQg
b2YgYGNvbnNvbGVfYnVmZmVyYCBhbmQgY29ycnVwdHMgYWRqYWNlbnQgbWVtb3J5LgoKQ29uY3Jl
dGUgb3ZlcmZsb3cgY29uZGl0aW9uCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotIFRoZSBp
bmplY3RlZCBzdHJpbmcgYCJydW4gYm9vdGNtZFxuImAgaGFzIDEyIGNoYXJhY3RlcnMsIHJlcXVp
cmluZyAxMyBieXRlcyBpbmNsdWRpbmcgdGhlIHRlcm1pbmF0aW5nIE5VTC4KLSBPdmVyZmxvdyBv
Y2N1cnMgaWY6CiAgLSBgQ09ORklHX1NZU19DQlNJWkUgKyAxIDwgMTNgLCBpLmUuIGBDT05GSUdf
U1lTX0NCU0laRSA8IDEyYC4KCkltcGFjdAotLS0tLS0KLSBQb3RlbnRpYWwgaW1wYWN0OgotIE1l
bW9yeSBjb3JydXB0aW9uIC8gY3Jhc2ggLyB1bmRlZmluZWQgYmVoYXZpb3IgaW4gVS1Cb290IGNv
bW1hbmQgaW5wdXQgcHJvY2Vzc2luZy4KLSBQcml2aWxlZ2UvY29udGV4dDoKLSBFeGVjdXRlcyBp
biBVLUJvb3QgY29udGV4dDsgb3ZlcmZsb3cgb2NjdXJzIGluIGEgZ2xvYmFsIGNvbnNvbGUgSS9P
IGJ1ZmZlci4KClJlcHJvZHVjdGlvbiAoZXhhbXBsZSkKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQot
IEV4YW1wbGUgKGNvbmNlcHR1YWwpOgogIC0gU2V0IGBDT05GSUdfU1lTX0NCU0laRWAgdG8gYSBz
bWFsbCB2YWx1ZSAoZS5nLiA4IG9yIDEwKQogIC0gRW5hYmxlIGBDT05GSUdfQk9PVF9SRVRSWV9U
SU1FYCBhbmQgYENPTkZJR19SRVRSWV9CT09UQ01EYAogIC0gQWxsb3cgdGhlIGNvbW1hbmQgcHJv
bXB0IHRvIHRpbWUgb3V0IHNvIHRoZSB0aW1lb3V0IGhhbmRsZXIgZXhlY3V0ZXMKICAtIE9ic2Vy
dmUgdGhhdCBgc3RyY3B5KGNvbnNvbGVfYnVmZmVyLCAicnVuIGJvb3RjbWRcbiIpYCBvdmVyZmxv
d3MgdGhlIGJ1ZmZlcgoKU3VnZ2VzdGVkIGZpeCAoY29uY3JldGUpCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCi0gUmVwbGFjZSBgc3RyY3B5KClgIHdpdGggYSBib3VuZGVkIG9wZXJhdGlvbjoKICAt
IGBzbnByaW50Zihjb25zb2xlX2J1ZmZlciwgc2l6ZW9mKGNvbnNvbGVfYnVmZmVyKSwgIiVzIiwg
InJ1biBib290Y21kXG4iKTtgCi0gT3B0aW9uYWwgaGFyZGVuaW5nOgogIC0gQWRkIGEgYnVpbGQt
dGltZSBjaGVjayBlbnN1cmluZyBgQ09ORklHX1NZU19DQlNJWkUgPj0gMTJgIHdoZW4gYENPTkZJ
R19SRVRSWV9CT09UQ01EYCBpcyBlbmFibGVkLgogIC0gSWYgYm91bmRlZCBjb3B5IHRydW5jYXRp
b24gaXMgcG9zc2libGUsIGRldGVjdCBhbmQgaGFuZGxlIGl0IGV4cGxpY2l0bHkgKGUuZy4gZmFs
bGJhY2sgdG8gYSBzYWZlIHNob3J0ZXIgY29tbWFuZCBvciBkaXNhYmxlIHJldHJ5KS4KClJlcG9y
dGVyCi0tLS0tLS0tCi0gTmFtZTogTmdvIEx1b25nIFRoYW5oIFRyYQotIEVtYWlsOiBTNDIxMDE1
NUBzdHVkZW50LnJtaXQuZWR1LmF1Ci0gVG9vbCB1c2VkOiBVbmlmaWVkIENvbmZpZ0NvZGUgR3Jh
cGggKFVDQ0cpLCBhIGNvbmZpZ3VyYXRpb24tYXdhcmUgc3RhdGljIGFuYWx5c2lzIHByb3RvdHlw
ZS4KLSBEYXRlIG9mIGRpc2NvdmVyeTogMjAyNi0wMy0yNQo=

--_004_SY4PR01MB63165899EC06BC60BB36A5659A56ASY4PR01MB6316ausp_--
