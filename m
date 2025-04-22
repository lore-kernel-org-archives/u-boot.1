Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072B2C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 12:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB8F81E72;
	Tue, 22 Apr 2025 14:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=student.ltu.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=student.ltu.se header.i=@student.ltu.se header.b="glEz6/zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389B280FEC; Tue, 22 Apr 2025 10:55:45 +0200 (CEST)
Received: from GV3P280CU006.outbound.protection.outlook.com
 (mail-swedencentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA207809D4
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=student.ltu.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danthu-0@student.ltu.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONGNfOFTzvZqwlTUHL+pGLEqBBp/ws5tKK/OSzu2W5w5tQF1mzSXwzjY+Jsti+R8w+R1zIe7NhxVPwjvJH+QsN8o173GRwkZdicDqKosHF6oVHfu9twP++kHUGdxCBofA0p4HhSnd+u3Mo3J4cGrEJuKg40eoX+G+YkFyc4n7tYzgBMeMFg0r49rqbYu9cQBvPvzrD3/KLawlX7JAnAHQhErQQXpVfkH9wuNO9dltj4TWF00En7Jx47Wn1R6/Mg/GOcVe1ylKoMqk9kbX4wSGs++9gMx+VesZllNRjjWTgvMB8KiSFHjMuU4qCoEYQietEuaZWleM/yuX/6arrbPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmtdErfhLag/fU0LOr9ETsxnjfVgy5uzR9Mh1MtGEr0=;
 b=wpI4qonpFpQ3KqoGB0rY6PTl2p/0F8a8Vv3j761picT2BzDa6ZXpAGLQ49ndWfy8zM1qACSJMUjnVqnm8AjNOhNlM3xjiKKgGEJAa0Nl1QpBRkXu6cvWZUPFF+vgL0i6O9IaHpzKHMjwPaBOGY3WSai8bquQjayPvlTW4eQacS6Z3eLg1MA99v3w+Jes9vzkfqeYvn3lZSry4FegGAJ7VXA36epVwfUD3FCJAB05Z/+syFtsChqyNHt381YLEiOKztS07XGpJrbCtgCnx2IcyAcoOw6n1nn1/niwvCK7mjFRuJpV1Z5ON3Ko7wharv58EmgaTi4MpeKps/Djg90ODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.ltu.se; dmarc=pass action=none
 header.from=student.ltu.se; dkim=pass header.d=student.ltu.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.ltu.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmtdErfhLag/fU0LOr9ETsxnjfVgy5uzR9Mh1MtGEr0=;
 b=glEz6/zpCwGgP5Qbmg0L0unOBWQTqM2yPYEOQJysttiUl9/NZyreGlgdqgFIW+QaxKXUPVhNVFWh9fh+pHWrwk69fOy/mjtDld3x4cn/liBtqKN5DyOqpixMopc+kOs6e2UJLmxIK50cOQuRdx2GFfWIvbEmWGTga3kMenlMsgU=
Received: from GV3P280MB1375.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:184::6)
 by GV3P280MB1796.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 08:55:41 +0000
Received: from GV3P280MB1375.SWEP280.PROD.OUTLOOK.COM
 ([fe80::132f:2477:a4e:bd5f]) by GV3P280MB1375.SWEP280.PROD.OUTLOOK.COM
 ([fe80::132f:2477:a4e:bd5f%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 08:55:41 +0000
From: Daniel Thungren <danthu-0@student.ltu.se>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Flashing Kernel + Bootloader to eMMC with Rollback Support Using
 Boot0/Boot1 (i.MX93 + U-Boot)
Thread-Topic: Flashing Kernel + Bootloader to eMMC with Rollback Support Using
 Boot0/Boot1 (i.MX93 + U-Boot)
Thread-Index: AQHbr6DKNIMjszMhJUui837FDGhLog==
Date: Tue, 22 Apr 2025 08:55:41 +0000
Message-ID: <GV3P280MB1375F443D3EA1013E62FB12BF7BC2@GV3P280MB1375.SWEP280.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.ltu.se;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV3P280MB1375:EE_|GV3P280MB1796:EE_
x-ms-office365-filtering-correlation-id: eca060ae-9c25-4698-b087-08dd817b75ac
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jLycfdV7KLsAw/UUU8xhcppnKfKCNDbpRJD+mx0Xptc1GDf6RaCCQsVEGb?=
 =?iso-8859-1?Q?wZUBO2/9C95m+kayrSHRPjMQXNqbevmBNaFhsm3tBZj2QHvDXqAaPkBN4e?=
 =?iso-8859-1?Q?3ZsB4eCWAomctj4pzS/chM8hfg5I/M4lMt1KGfzt+fKFNqxpezBNj/NEuZ?=
 =?iso-8859-1?Q?Us+Z+8ngmUxWSau3r4iSKEWxd5cnP6iYVBE2vSpNvL3s6g/lTCSYZ1T2ua?=
 =?iso-8859-1?Q?8GQ13RL6tyTWRvvyr1n9XX1m9LPa6lkJOASgggtOuKxpCEbuDrwrYZ5ZNY?=
 =?iso-8859-1?Q?O0gMyJbErt8mWhHa57x9I/s5NAP2dmEMOU2BppTNylxD421j+JLpy34xGu?=
 =?iso-8859-1?Q?KFjg1WF2nuTqaaF19ZZ9rXDn4auTVz/aiGncm8CMMQqwmwthcnRnHMSFke?=
 =?iso-8859-1?Q?jtj04vl91pwVvFg9dhDBhqi6oSkVO6H6i6YZrdU9/M5Q51a4M53cf1SdaL?=
 =?iso-8859-1?Q?d1iWEibnh42tzNYTqhTUSEOChA2KnyEHMYBYGGlXe7qNUWQK+rQFLiBQwh?=
 =?iso-8859-1?Q?erYgE2SiZ/QVF/IKLWXF1nMp8OqmM26iSPeVw1yJI7WZoB6VuTYhzeu8cD?=
 =?iso-8859-1?Q?hhq14APTTBzRLlNrAIoU5DxPtAtBMl/k+vRnlByagns3rhrvHfNKAjQLWa?=
 =?iso-8859-1?Q?Z4fBZ96II8iccek8h9GH1kCL+iglG+nHjSiQ8zHpEj2lwMzvdytf6TL+8W?=
 =?iso-8859-1?Q?FJ16KIgUjgZVflMJEiP0NFawjK45RipoDb0mh93z5ey8gUfqaon+zhadQ4?=
 =?iso-8859-1?Q?zpAhhvHhLrpSUZ7ZnKF/Pau1vm+e+yhgNvtP/E/IziZRRc5YzjiaqUYSK1?=
 =?iso-8859-1?Q?HjWBN/lK3hdJIUJ3n8tRo/rG14vjqCVUGwYB0iTa3giZ3vrk+hU+vCgggF?=
 =?iso-8859-1?Q?zBoNWH7Fo7dHYbCIrFDxG+uX/3CXldDsLAPu/7h+xPhplvqlfjsb713ySD?=
 =?iso-8859-1?Q?vsCMAV88SZ4XX+dUS2SnV+cUPfTIvt2wyiSaEsdHEWzmzaOSY2g2zDbWq8?=
 =?iso-8859-1?Q?1PP5oEL66Mfq9ATK5yEXVjlIpwN9t/M3lmEF/MayFy2M7qAXBGQC9MYVXe?=
 =?iso-8859-1?Q?SbjhoPUrA35xZuqLayAxeGB8wunT3qNfS15VnulYy6PTlVu27BXaqWScTq?=
 =?iso-8859-1?Q?dmF8wHTVZHIrgZHidgxf29qQVsLFAia3tvjud1XJzeIGM0RXF3xUtBR/2W?=
 =?iso-8859-1?Q?WDsKNP8XOsXHxXK2r0LLlYmki2yXrbiL6JYPrOsgk+ic5XmEW0e4/nvo1y?=
 =?iso-8859-1?Q?Yo2j140qXOhEQyZaivouMcNDDU8QcwZf6ngloXoYXWbMRiTT2vlgdBz3tG?=
 =?iso-8859-1?Q?YxwyWvEE0Z2fCOMyCZOIRAYOLOm/oZVUKpKc1nOmREAQ363FFpMDsUg8z6?=
 =?iso-8859-1?Q?JussMHBDKJd1Wjwb2jABqJLFurHAxz4nY8cua3UQwv66iPPFoCzMKrUyo/?=
 =?iso-8859-1?Q?pm/sIoQg7AxNV6tq9NUJMrUrVcvOEYYIXHkWmAIT3OFScADjnPC8SF1I+x?=
 =?iso-8859-1?Q?SR1XU5B4AtIU+lxL7vrMYzwbSMHd6QyZFKNST/E64Rxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV3P280MB1375.SWEP280.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y82A65V365ASgvAR8q5NaQFvx2Hs07n3l4e6Wi9MdCoTIM18G/7avQxTVl?=
 =?iso-8859-1?Q?ozasqpBwfKsN98ezsbIb+pPbu63mcM344PveYHipr8GMIJJL/mog4iU4ny?=
 =?iso-8859-1?Q?P7CAIIoSRfAnKNQK/yGQcHjgjaEJ8HrZ3Jx3Cl1WEpV9w7mZqvmuSTgceN?=
 =?iso-8859-1?Q?UzhtaiOmlJvYw4mwPE1g3PUq9YOMc0lSFUYTNZL/jCmIO4OolRVKq1gCOk?=
 =?iso-8859-1?Q?KIuLSBaVt8bR+DOc7Yn0mrtBXlsfFhKj18vbE1aszHduH4e9O3gY467Cq8?=
 =?iso-8859-1?Q?zT2nKUZxoCqA5rGtWMqdQF4SL8KodkluDK57Cy2QXp3Ug+tJf65SgfN+gX?=
 =?iso-8859-1?Q?IPEFRhrhVY1sHcY3KKd3mzbVj8c83hIa9mZpajwN1h5+rKepJ/N+b8/BS9?=
 =?iso-8859-1?Q?8OucHziKMyV7Jc7Os4g7AuIgIvpHvIHRhUX3p9H4MU2WLH7/cGVmQ9BTcE?=
 =?iso-8859-1?Q?O9LqV2iZnYyEWgkEc1WpwbN3zuKS6u1Y1+dhmlzPJLuQhX4pvmBk6YFhva?=
 =?iso-8859-1?Q?pN7m2EDLldZJ65BCQsNt0qZKyVSlY75xH/4F1TKXozd+K5ixN1XdX8EyQ8?=
 =?iso-8859-1?Q?3hylMeIYDC5BnW1SiglNL9wlGXxGD0ZyeLewiWkbDAJWvUxjJYaRXgT409?=
 =?iso-8859-1?Q?TVwIrqkGS2vCjIkafy+XOpTz20efwIAQfWrlmAAntDAiP0TfhBL68SX6Rd?=
 =?iso-8859-1?Q?mHZpkpX0FSIzg2341skOklmZicwcmUMWqtT3FTDoqNktB8/wsd9lHjs3JX?=
 =?iso-8859-1?Q?Zmcdmog0EuD98JY5U9II0gKQhqT9RmlynlxfFjz1l+4j+NlHrx0ZnoLe7r?=
 =?iso-8859-1?Q?T5XL+JJJH3ziHQcet2eOfQ1tQ+RCXUwubiX3U/jy9b52Ni7QIWRVNFVP2U?=
 =?iso-8859-1?Q?5mTN/VdFCvKsx+NN5BrzmlDHXcVptnDwFkXl3pb8QrP5LLY6j+HZ8Kl/Ro?=
 =?iso-8859-1?Q?tPHEdv99JwjVLwatxx0AvXL0SJv/Bel1Xl2cXGgFY7zq+301dqsuySbbv5?=
 =?iso-8859-1?Q?4H0osUmXfAsKPE91CXVyTznYmrXS1k6UR9fALTVlXYXSUNG9ZqomX9GDGF?=
 =?iso-8859-1?Q?xfVd3UAURA1pVAEgiejxio71OcynE4/fFHLNCuQNwfjD/Qr5EWG0S7zexW?=
 =?iso-8859-1?Q?q6GtsGSDVKF+ZG1Vk1jyZ4LFxag7fpBxWl0V5osfKmndwjspL6SYuHMqO7?=
 =?iso-8859-1?Q?oxLuZA5OPBXZwjX6v1hoAgOL9Kq7ChC1dlmD2tM2c6Vl8ryZ0PtFJDUcnI?=
 =?iso-8859-1?Q?frHLP9C7oQQDb2+rbuJrub6+QiHpoH8KsvR0bwqURUvmQk6O8cId7wE8hc?=
 =?iso-8859-1?Q?jYqICKbHERCRf0D2VC7/vwL376VQbs/FPaRhJjMp1oYPI1B1Xlm27+/cdf?=
 =?iso-8859-1?Q?N3LxW394mD8rT3IhXS+q6xHMqlwbNI7pn1KGK7W3+aBtNktbJCrb3BDQ+t?=
 =?iso-8859-1?Q?suenVOTV73TXh4XPji1pSXc0BpGLljxzgMboRzc3KoI+fXQoQWtdoAAvXg?=
 =?iso-8859-1?Q?jNJtSNUA6zKBJrZc3ENhH3nNjdDqdpjiqWZuyZtzrokkTmKbqlibIXhH+m?=
 =?iso-8859-1?Q?lsxwvAoRZaR3zcXPUzS8j287Ol4nIY82hoQSP5GPpHQ+HrXQD3wDBwVzKZ?=
 =?iso-8859-1?Q?ZWOSPS5I3hVjELpTRjj4/F7GruaT0dB0hCHH5536S+CSvbDjy7hzuKOIpI?=
 =?iso-8859-1?Q?aLriidwM3i3liApP0NA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: student.ltu.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1375.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eca060ae-9c25-4698-b087-08dd817b75ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 08:55:41.1122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5453408b-a6cd-4c1e-8b10-18b500fb544e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqErT4NwOKXh6j4REVQgmzWo2FMpQV3yh5vS4K8FFGaRJCyPNCYYgyAgbrRbJed/VLKQCxlk5V+3qfEcahWRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB1796
X-Mailman-Approved-At: Tue, 22 Apr 2025 14:35:50 +0200
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hi,
I'm a 5th-year university student working on my master's thesis focusing on=
 OTA update systems. I'm currently using an i.MX93 platform with eMMC stora=
ge and U-Boot as the bootloader.
Right now, I flash the board using UUU with a complete image that contains =
all components. However, I'd like to move toward a more flexible setup wher=
e I flash only the kernel and bootloader to eMMC and test boot behavior.
Specifically, I wonder if there's a way to utilize the eMMC's hardware part=
itions (e.g. boot0 and boot1) for storing and booting the bootloader, poten=
tially as part of a rollback mechanism. My goal is to be able to test new f=
irmware versions and, in case of failure, fall back to a known-good configu=
ration.
Is there support for this kind of setup in U-Boot? And if so, are there any=
 recommended practices or caveats when configuring SPL and U-Boot to work w=
ith boot0/boot1 on i.MX93?
Any insight or guidance would be greatly appreciated!
Thank you in advance.
Best regards,
Daniel

