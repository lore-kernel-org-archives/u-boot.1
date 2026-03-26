Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A36109E529
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 04:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D0A84106;
	Thu, 26 Mar 2026 05:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Student.rmit.edu.au header.i=@Student.rmit.edu.au header.b="Sk7ztA25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B35A480517; Thu, 26 Mar 2026 05:41:21 +0100 (CET)
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA8A583A41
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=S4210155@student.rmit.edu.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwHlgIKtSYwzuPkmjxWUgVkMylkIiOBwTAYDtEQb11QESYlVwgRG5P9UgdIsm757Vwx5CO0JZuHNYJ+OgvSJH4JX4v8LXrAyKMa5AcryR6j+q3LyxOtf94alPbgFS2/DkHujacm4OHKfWewwFoF0R+vQc8Hk6b+181r+FUO4GlGRvdOd0BzRLgSkdTaaTnNevi7DbiaRy5OROW3tJEGaPWycdhiFyZ7ekHNdLu73b/SrAi2sO5mmRFfdX6GIecTuwzV06KX7P+tJCvigg68UbBNt3WfwCTCqwufj77aoJOn1w3TfLOLzJcvBVCpQJ4iijsPwpHRZqKreiRBIxOEzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC/KLVgznFfZ5oq9b4SW8YrbEn0QlN/e2hvgEuc9ACI=;
 b=mM07aIvXNqYubB6lUMYK4s3DPGf7XZ0sNL2Z+33GOzhRFvOOniTdap8ZVpKDMJ7KYwoLnesYS5GIty055xh2X1U47M7dVcDyuh8sSHSUMx1cjOMjvtyywYnpinRQcX+YMJPu7u66nRz6lhZZ1OarFLG0y3Fw5C0mZz+x0QGfUfCgxvH8BDdx3HtPmCPRZ2hCZBJCuJY4ttObQs3dR5qg3hDUhVYNOkB7iSyr2xGD+cyS7zKZodxFx7aybJvD2z0LtB6l6v14tEIrAyyCmrFkIYKamzGufxy10VCe/SA/MMaxR9DvEheKUkVR1vQqtilLmvIokGOODYQmKe61eov2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.rmit.edu.au; dmarc=pass action=none
 header.from=student.rmit.edu.au; dkim=pass header.d=student.rmit.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Student.rmit.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC/KLVgznFfZ5oq9b4SW8YrbEn0QlN/e2hvgEuc9ACI=;
 b=Sk7ztA25S2vm7/8hTqCm6MByowm4O52WKTyD9DP5eIIb6C8mBdl09oUuQObIRjgu/SpVI7AT1S0V8DW7NnoON3KqEuAVcxisgnOmOGf2YL4LO9Igkucn09D2bLz60MarLWBpU9QJAz6LGoTmb5uOT8rjZEOeBkXiVGxAG4ehxrY=
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com (2603:10c6:10:10e::6)
 by SY6PR01MB8441.ausprd01.prod.outlook.com (2603:10c6:10:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 04:41:08 +0000
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac]) by SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 04:41:08 +0000
From: Tra Ngo <S4210155@student.rmit.edu.au>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
 "vitor.soares@toradex.com" <vitor.soares@toradex.com>,
 "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: [SECURITY][3/4] Potential overflow in Toradex config block prompts
 (CONFIG_SYS_CBSIZE-dependent)
Thread-Topic: [SECURITY][3/4] Potential overflow in Toradex config block
 prompts (CONFIG_SYS_CBSIZE-dependent)
Thread-Index: AQHcvNlj5MQfQseTnEedB2obrZma9w==
Date: Thu, 26 Mar 2026 04:41:08 +0000
Message-ID: <SY4PR01MB6316D801792AE3B072CC459F9A56A@SY4PR01MB6316.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.rmit.edu.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4PR01MB6316:EE_|SY6PR01MB8441:EE_
x-ms-office365-filtering-correlation-id: ad22d02a-f670-4181-fee3-08de8af1e642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|6049299003|1800799024|786006|376014|8096899003|4053099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: t4Y9U7QK7ZZMIqiXC5y89RH3P6QahZEoqcAE3kOzITgONkkszE/sI2LB8pc5JSc2a6MdlJ4pzyxKOMuDOlGUXE4uoJpgdfVAOYLGhozwJvFHl18et8Nug5oWN+/EWjHtsuHrIdEA/ewbxMbF40ewJXZOn3IcohB4915wPjbm5923WZEQUZ0nk3PZU8MQnlsd91Kt9EDZVFxm/SxyM/xc0XKpbwXJETBAQlclikuB2jAhPnhsDkk+Uo8l44lIVGzALPJ3qBlPVnIcoJPlxkIjVUTUtn0zV9EOhFx+jnZCUTi84BqEQ4Zx+j/woeKduYWOCgBEW01zGeTyhq+afAUFdG1ZY52+9xfI6lnzlYoxVjbLqVLhKOzDZo09E1AeDQyJ7u11Rj5z2HH2hnigTf84pYRVhE4GJW29A2qAKB2hQupiRb8r6dIfnIUhBwC0dngAKMY+rFlNpOJNsiPXDIB7PuVG2dlg3dA8/O8+wuK2sGm32y92MC+h90Z/97YW8aCNqZ5PA0m3FK6i3Q+cViqtLjddXUGm/uG4obpqyr3xNLdb41nZi6JYo6nq5ZNqDlufUg7ZR0bKibBZ2yU4kcKQdKGArbVF1j3HqMN0BxGQbSgXdgquHENtzvCm82eSCHqlRslPI0+/VTISD6p7S4tcLaeW1NQlONBmJWipL3lJ8h5mP/7byrXBDeu1WoAx/o7sWWnoQoW6etJWhe+Vqq4t4RHHxVIXNRAH1vjZpzFpp2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY4PR01MB6316.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(6049299003)(1800799024)(786006)(376014)(8096899003)(4053099003)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zhq5Ygl/KHCJ4STTYp8azekdjFwBiVktcYXdHY4XLEPfne67g9NGJtfHgGwC?=
 =?us-ascii?Q?cEm2gJcpGGYCQH0ojwy2hmJxyVUsipwIGKrg3OuL7rDPPH2KIPdtCPVv3i4z?=
 =?us-ascii?Q?xr3mdCYiwAjCxPGRNvrhZja7/MoM8+htjmyFQt5Yq/Wcl7IvjRB7X9a8CCO7?=
 =?us-ascii?Q?EyWH7dI8RUWelhbdnJGLUoIBDHjeb+ttu4dJVdXyVAOj0P5WhrIbd6M8cWvM?=
 =?us-ascii?Q?GJ50xIYARFgs/Wya3ova87zf6v1hftHrsUT+MTVt50gUuG9frNvzbTqFePOg?=
 =?us-ascii?Q?cAZ4XTKtKCPh1Sy6sTmfazc7OGaf/f/9ylwoe+9F7R6dzgO0zleqRIUdUHsI?=
 =?us-ascii?Q?Pb91IxiYvj7j0F6P2HbVJcIvr3HtvFmNfVfYj/KyPk1qyS6q62TVQm6UhVo+?=
 =?us-ascii?Q?BBtpOxhpD6hW2GeMLzo7+WZ8PqrlHxJe1uCki8N8T5SgnvjbqURN19gPd5DZ?=
 =?us-ascii?Q?bCZEuLBl3sg6i/X5IzXxIrYhTdQyOfc3iw2VZDHmfKvuFG8nbDymFP1tWs6A?=
 =?us-ascii?Q?CJfO1xXyoMfvM/LGjd+ykm/7cGtN7GgFi12v34adq7tGff8zLYpTSq93mIs/?=
 =?us-ascii?Q?nZMJqn9zQ0b0obJ8XlXRnT4/TQS/DrrWGsap2AppuAFDsH/gvplTcAaDNq1u?=
 =?us-ascii?Q?gkABxWMwXNBzGTo+00PTkGgA9fvWccKlfm+Wbct0JD/5HSQZ9gXy8QsXLW38?=
 =?us-ascii?Q?LAu+PQUDGLRenRGKl4UZbmcUErBt5ea9MAaA15msXg5SK15dvHS2Ixgcex2t?=
 =?us-ascii?Q?JXxI4f27xNtZowVLvWt0b7ac9FB7FLJbP1Y3+D2lGuiIqcQMvoukE7qnojXW?=
 =?us-ascii?Q?VkdYEfvmlydWdcSTqOhz1s/SzGxLy85SX7L3uQkVEg676liBsEWnnlmDvGvv?=
 =?us-ascii?Q?sKoWozg9tUPrdD8+JjJnES3HQFxcKIFS+qynKHBtaQCGtPAu4LdAsPlfO3ML?=
 =?us-ascii?Q?/CbNkJZfRxk0AiCrHQRmWVyrklXdO+BDvvEsNTawWx5NQ6zAcqsdFiOGibuD?=
 =?us-ascii?Q?HpbESrbmZirFWcf1GS5H5yijfU2SR8Me7gs6gxKIjnjugiHHbt9fUqfvlWgO?=
 =?us-ascii?Q?BegpNUbf85TdWXbT+11sw7nfVycolswavLh4PKfnTm5AWx3WoQtkPPOIhvGI?=
 =?us-ascii?Q?ImKfaKb5ai0MC+emh8KJOBXGNfTrcovz/oY1CvO1l7pjPmuDnJj7DJ6/uV/O?=
 =?us-ascii?Q?xtKv4Ni26udimWImeKhdgtKnnJGWtjs3vuq+jQi2GkYkyYPolHPKbLXxiwnb?=
 =?us-ascii?Q?tlht0t24h4AMmpupyJqDylrNAtoGPB8xpDEcmpECCAZzhpufD4knm4D27HcC?=
 =?us-ascii?Q?6wEMzD8YqkML6OYlj/eXLqoZh1dFIcKOZ3tKK+VRh0Rs9JfBoeYtWt2eQ9Oq?=
 =?us-ascii?Q?WXtFnFl2asrElqvvFjtk4QrPE7qy5Xs/CnBNxR2U2FombSUvWsnUaqW/N3R4?=
 =?us-ascii?Q?uLKQKDympqUV2MI3zGuy/V/JeM4de7xYOBk9Wmly0bPFYiwy26n/GlIeFvee?=
 =?us-ascii?Q?0jyGOmUl3OTxFkKXfS7ul7SDF2G2avqScryxlZoFXFgMWUp35MUh+/88PuU3?=
 =?us-ascii?Q?yDIU4S68SZuZCPtTm1tTc4I7/MKaL0u+DNvsXhNEma4QebdiDPYgrRaD8Dxb?=
 =?us-ascii?Q?7OMecemr1I7Z/ojaCeov1lJP1GTiLht9CkZ98dLaPCJvvCLJ89Oaophg5Vy7?=
 =?us-ascii?Q?cDnHGZnAvo8doWiursBrzS/ex1ROs+fi38iCBThgUr1oNXVQil1tT0lwnzz+?=
 =?us-ascii?Q?p54ZtuqnxLpWUa3GR4LHePD79fqGgqYYESROCChQ1IrhNA3zBJir?=
Content-Type: multipart/mixed;
 boundary="_004_SY4PR01MB6316D801792AE3B072CC459F9A56ASY4PR01MB6316ausp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IpteLwJddSQ+KzMnI57uHs9cwfYakZrUnEu6EoM007F9xQXZaWJg4tpwu8yZx2UUPi2dv6ZRjpDJDLX7VgOpib3PjjnZh/NBylax8+zA+LXmfKeNbBbu808LnvpV/9w0GJD5V+N2Fu4L519VKz5aXiVQB1q/PpqJV/rlO3aR/443LdSuqui41FDz4mljn25ULwzkvguEGVKEiVWxpG6GUZiGTGdYlv9jb/fAGVkXBLlj4257gIozBN4KJ+W3nq+SyDYWL87qehlv3rgrUZ7sV1mek4fgBtOeoEfoCdw51gMImxw0PokObpGPq2c9FvwrdwWfcJnTkO81AYdBEcYu6A==
X-OriginatorOrg: Student.rmit.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY4PR01MB6316.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad22d02a-f670-4181-fee3-08de8af1e642
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 04:41:08.7734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d1323671-cdbe-4417-b4d4-bdb24b51316b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6613AUxpz3VqxAYxPegsvjOB1EQnXXJRDbxxywcYB7dwYlPTs7dnIrj+weP4sSwi1zA6B+HHvp5Z1XexkRgC50j+5T8EQ6kysRol1NJ5Is=
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

--_004_SY4PR01MB6316D801792AE3B072CC459F9A56ASY4PR01MB6316ausp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear U-Boot maintainers,

I would like to report a potential stack buffer overflow in board/toradex/c=
ommon/tdx-cfg-block.c related to prompt string construction.

The issue arises from unbounded sprintf() calls into a buffer sized by CONF=
IG_SYS_CBSIZE, which may be smaller than the literal prompt strings.

This is configuration-dependent and can lead to overflow under certain sett=
ings.

I have attached a detailed analysis, including root cause, reproduction, an=
d suggested fix.

This is part of a set of related configuration-dependent issues; I will rep=
ort others in separate emails.

Please let me know if you would like a patch or further details.

Best regards,
Ngo Tra <https://aka.ms/GetOutlookForMac>

--_004_SY4PR01MB6316D801792AE3B072CC459F9A56ASY4PR01MB6316ausp_
Content-Type: application/octet-stream; name="UCCG-UBOOT-03.md"
Content-Description: UCCG-UBOOT-03.md
Content-Disposition: attachment; filename="UCCG-UBOOT-03.md"; size=3243;
	creation-date="Thu, 26 Mar 2026 04:31:25 GMT";
	modification-date="Thu, 26 Mar 2026 04:31:25 GMT"
Content-Transfer-Encoding: base64

PT09IFtVQ0NHLVVCT09ULTAzXTogc2Ftc3VuZyBtaXNjLmMgc3ByaW50ZigpIGNhbiBvdmVyZmxv
dyBpbmZvWzY0XSA9PT0KClN1bW1hcnkKLS0tLS0tLQotIFR5cGU6IHN0YWNrIGJ1ZmZlciBvdmVy
ZmxvdyAoc3RyaW5nLWxlbmd0aCBkZXBlbmRlbnQpCi0gQWZmZWN0ZWQgY29tcG9uZW50OiBTYW1z
dW5nIGNvbW1vbiBib2FyZCBydW50aW1lIGVudiBzZXR1cCAoYGJvYXJkX25hbWVgKQotIFNldmVy
aXR5IChyZXBvcnRlcuKAmXMgZXN0aW1hdGUpOiBNZWRpdW0gKHN0YWNrIGNvcnJ1cHRpb24gcG9z
c2libGUgaWYgY29uY2F0ZW5hdGVkIGJvYXJkIG5hbWUgZXhjZWVkcyA2MyBjaGFycykKCkVudmly
b25tZW50IC8gVmVyc2lvbgotLS0tLS0tLS0tLS0tLS0tLS0tLS0KLSBVLUJvb3QgdHJlZToKICAt
IExvY2FsIHRyZWU6IHVjY2cvdS1ib290ICh3b3Jrc3BhY2UpCi0gQm9hcmQgLyB0YXJnZXQ6CiAg
LSBTYW1zdW5nIChib2FyZC9zYW1zdW5nL2NvbW1vbikKCkZpbGVzIGFuZCBMb2NhdGlvbnMKLS0t
LS0tLS0tLS0tLS0tLS0tLQotIFNvdXJjZSBmaWxlOiBib2FyZC9zYW1zdW5nL2NvbW1vbi9taXNj
LmMKLSBGdW5jdGlvbjogc2V0X2JvYXJkX2luZm8oKQotIEJ1ZmZlcjoKICAtIG1pc2MuYzo4NTog
Y2hhciBpbmZvWzY0XTsKLSBVbmJvdW5kZWQgZm9ybWF0IHNpbms6CiAgLSBtaXNjLmM6MTA3OiBz
cHJpbnRmKGluZm8sICIlcyVzIiwgYmRuYW1lLCBiZHR5cGUpOwotIERhdGEgc291cmNlKHMpOgog
IC0gbWlzYy5jOjEwMDogY29uc3QgY2hhciAqYmRuYW1lID0gQ09ORklHX1NZU19CT0FSRDsKICAt
IG1pc2MuYzoxMDM6IGJkdHlwZSA9IGdldF9ib2FyZF90eXBlKCk7ICh3aGVuIENPTkZJR19CT0FS
RF9UWVBFUykKLSBFbnYgYXNzaWdubWVudDoKICAtIG1pc2MuYzoxMDg6IGVudl9zZXQoImJvYXJk
X25hbWUiLCBpbmZvKTsKCkNvbmZpZ3VyYXRpb24tZGVwZW5kZW50IGRhdGFmbG93Ci0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi0gQ09ORklHX1NZU19CT0FSRDoKICAtIEtjb25maWcg
c3RyaW5nIHVzZWQgYXMgdGhlIGJvYXJkIGJhc2UgbmFtZSAoYGJkbmFtZWApLgogIC0gVHlwaWNh
bGx5IGRlcml2ZWQgZnJvbSBLY29uZmlnIGBTWVNfQk9BUkRgIGFuZCBhcHBlYXJzIGFzOgogICAg
LSBgQ09ORklHX1NZU19CT0FSRD0iLi4uImAgaW4gYC5jb25maWdgCiAgICAtIGAjZGVmaW5lIENP
TkZJR19TWVNfQk9BUkQgIi4uLiJgIGluIGBpbmNsdWRlL2dlbmVyYXRlZC9hdXRvY29uZi5oYAot
IENPTkZJR19CT0FSRF9UWVBFUzoKICAtIEVuYWJsZXMgYm9hcmQgdHlwZSBzdWZmaXggYGJkdHlw
ZWAgdmlhIGBnZXRfYm9hcmRfdHlwZSgpYC4KClZ1bG5lcmFiaWxpdHkgZGVzY3JpcHRpb24KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotIEV4cGVjdGVkIGludmFyaWFudDoKLSBUaGUgY29kZSBt
dXN0IG5ldmVyIHdyaXRlIG1vcmUgdGhhbiBgc2l6ZW9mKGluZm8pYCBieXRlcyB3aGVuIGNvbnN0
cnVjdGluZyB0aGUgYGJvYXJkX25hbWVgIHN0cmluZy4KCi0gQWN0dWFsIGJlaGF2aW9yOgotIFRo
ZSBjb2RlIGJ1aWxkcyBgaW5mb2Agb24gdGhlIHN0YWNrIHdpdGggZml4ZWQgc2l6ZSA2NCBieXRl
cy4KLSBJdCB0aGVuIHVzZXMgYHNwcmludGYoaW5mbywgIiVzJXMiLCBiZG5hbWUsIGJkdHlwZSlg
IHRvIGNvbmNhdGVuYXRlIGBiZG5hbWVgIGFuZCBgYmR0eXBlYC4KLSBgc3ByaW50ZigpYCBkb2Vz
IG5vdCBrbm93IHRoZSBkZXN0aW5hdGlvbiBidWZmZXIgc2l6ZSBhbmQgcGVyZm9ybXMgbm8gYm91
bmRzIGNoZWNraW5nLgotIFRoZXJlZm9yZSwgaWYgdGhlIGNvbmNhdGVuYXRlZCBzdHJpbmcgaXMg
bG9uZ2VyIHRoYW4gNjMgYnl0ZXMgKHBsdXMgdGVybWluYXRpbmcgTlVMKSwgYHNwcmludGYoKWAg
d3JpdGVzIHBhc3QgdGhlIGVuZCBvZiBgaW5mb1tdYCBhbmQgY29ycnVwdHMgdGhlIHN0YWNrLgoK
Q29uY3JldGUgb3ZlcmZsb3cgY29uZGl0aW9uCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQot
IE92ZXJmbG93IG9jY3VycyBpZjoKICAtIGBzdHJsZW4oYmRuYW1lKSArIHN0cmxlbihiZHR5cGUp
ICsgMSA+IHNpemVvZihpbmZvKWAgd2hlcmUgYHNpemVvZihpbmZvKSA9PSA2NGAuCgpJbXBhY3QK
LS0tLS0tCi0gUG90ZW50aWFsIGltcGFjdDoKLSBTdGFjayBjb3JydXB0aW9uIC8gY3Jhc2ggLyB1
bmRlZmluZWQgYmVoYXZpb3IgZHVyaW5nIGJvYXJkIGluaXQvcnVudGltZSBjb25maWcgc2V0dXAu
Ci0gUHJpdmlsZWdlL2NvbnRleHQ6Ci0gRXhlY3V0ZXMgaW4gVS1Cb290IGNvbnRleHQ7IG92ZXJm
bG93IG9jY3VycyBvbiBhIHN0YWNrLWFsbG9jYXRlZCBidWZmZXIgaW4gYm9hcmQgY29kZS4KClJl
cHJvZHVjdGlvbiAoZXhhbXBsZSkKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotIEV4YW1wbGUgKGNv
bmNlcHR1YWwpOgogIC0gVXNlIGEgbG9uZyBgQ09ORklHX1NZU19CT0FSRGAgc3RyaW5nIGFuZC9v
ciByZXR1cm4gYSBsb25nIGBiZHR5cGVgIGZyb20gYGdldF9ib2FyZF90eXBlKClgCiAgLSBFbnN1
cmUgYHN0cmxlbihiZG5hbWUpICsgc3RybGVuKGJkdHlwZSkgPj0gNjRgCiAgLSBFeGVjdXRlIHRo
ZSBjb2RlIHBhdGggdGhhdCBjYWxscyBgc2V0X2JvYXJkX2luZm8oKWAgd2l0aCBgQ09ORklHX0VO
Vl9WQVJTX1VCT09UX1JVTlRJTUVfQ09ORklHYCBhbmQgYENPTkZJR19PRl9MSUJGRFRgIGVuYWJs
ZWQsIGFuZCB3aXRoIGBDT05GSUdfQk9BUkRfVFlQRVNgIGVuYWJsZWQgZm9yIHRoZSBgc3ByaW50
ZigpYCBwYXRoLgoKU3VnZ2VzdGVkIGZpeCAoY29uY3JldGUpCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCi0gUmVwbGFjZSBgc3ByaW50ZigpYCB3aXRoIGEgYm91bmRlZCBvcGVyYXRpb246CiAgLSBg
c25wcmludGYoaW5mbywgc2l6ZW9mKGluZm8pLCAiJXMlcyIsIGJkbmFtZSwgYmR0eXBlKTtgCi0g
T3B0aW9uYWwgaGFyZGVuaW5nOgogIC0gQ2hlY2sgYHNucHJpbnRmKClgIHJldHVybiB2YWx1ZSB0
byBkZXRlY3QgdHJ1bmNhdGlvbiBhbmQgaGFuZGxlIGl0ICh0cnVuY2F0ZSB2cyBmYWxsYmFjayB2
cyBlcnJvcikuCgpSZXBvcnRlcgotLS0tLS0tLQotIE5hbWU6IE5nbyBMdW9uZyBUaGFuaCBUcmEK
LSBFbWFpbDogUzQyMTAxNTVAc3R1ZGVudC5ybWl0LmVkdS5hdQotIFRvb2wgdXNlZDogVW5pZmll
ZCBDb25maWdDb2RlIEdyYXBoIChVQ0NHKSwgYSBjb25maWd1cmF0aW9uLWF3YXJlIHN0YXRpYyBh
bmFseXNpcyBwcm90b3R5cGUuCi0gRGF0ZSBvZiBkaXNjb3Zlcnk6IDIwMjYtMDMtMjUK

--_004_SY4PR01MB6316D801792AE3B072CC459F9A56ASY4PR01MB6316ausp_--
