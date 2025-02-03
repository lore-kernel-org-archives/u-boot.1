Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D13C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5839800B3;
	Mon,  3 Feb 2025 18:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dronetag.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dronetag.com header.i=@dronetag.com header.b="iYkxJtZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03A9800CF; Mon,  3 Feb 2025 16:56:23 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FD780077
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dronetag.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.peterka@dronetag.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLZBNJ9yIvW5SJj6VdSQMHuYdQuozYRd4cWbFqMfHKDgehFhYb9AB4TTpL/lT5XFPWJUOZsMXj/EyfPV8IXdu1gEpOroj1hF1CZiatQhhHin3H2qnQXT7RsuqDLs3tTQWYs6ayQ+Rao1TMuflHcV/44x2/JL5ouNj5kuuyQLCltEl0oygvMSnD9eA3oJLuIroD5LD6Hjl/bF+kPaWfWJldzSLs65UQ5IwL5lpDQetIUrilB249jAofiwI0fYINt3mEfHHH79u83Ndwg0sSMlxvTHCEhjpXnXYQ7mB0eQ7tzz56sa1aG4Sv4ZRMTe8HB5M7bt9SCUFqgye+cpzwWuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ygThdMuDr5id44suE3LL9dMBIJMGXYsJ6em6FJ4QQ8=;
 b=TTINjbmrl7u6wZasbj0yo5YDsa/stf+4o+eFQ13S9tBbkbVRmdWPJVtQrTR8opdrKTn64QDVXND60xXBFoNkh0yUOM3MH0eqACKOeLB0P4PsEh5+TWbfYzMuOXpwPNCFPtLRKp+HrEKImPDt/Iy2fGVTxMqqWLUhRHh1X34QgOU9f0e59H00nyl3zlxfGbgdGYymYY6468NY9XbsgkjxlCtc+kWO1AS3cfcfr4EJl16t65whUj55GNoxqePaPG8wNwpdDtpGZREGsM2+SQKPsdRibPylU6mS3jSGjW/vnE19Yc0cke1OH6HI+9d9JVFJEKX5rRZcxNgqsYPk51UkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dronetag.com; dmarc=pass action=none header.from=dronetag.com;
 dkim=pass header.d=dronetag.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dronetag.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ygThdMuDr5id44suE3LL9dMBIJMGXYsJ6em6FJ4QQ8=;
 b=iYkxJtZZakBNfhSrtNfxqXL32KvfRHZROyvd7snwb1h+PloRoDjpJsmnZMqXMlpq90KTAQETUGF2nFh++quesJ1fCaPmB3oprVYqHiZ3nnJ5xj0w+alUXOkpEhR1TP+mK9inuSXaqfm6JpffjZ6a/JWSOwlM1H9rvmokm0eEzkYkBBJa93tB0sVhLEC4RK83joKFCtzVWO3BxpK+xup4ewVGqfmSJKwM9f7cM/U0NsfMW9MndIbP+tNFtazip52KH4fQkGpVHcirQlwF4FhYXsah74n91ZWC7VODkBXPWguzK2mUeY0vcMpe/B4Qi3T7WAMjTJlvtyc0V2dLcV7/6A==
Received: from DB8P192MB0743.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:16e::22)
 by AS2P192MB1984.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:557::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 3 Feb
 2025 15:56:18 +0000
Received: from DB8P192MB0743.EURP192.PROD.OUTLOOK.COM
 ([fe80::6829:18a5:6e10:c601]) by DB8P192MB0743.EURP192.PROD.OUTLOOK.COM
 ([fe80::6829:18a5:6e10:c601%4]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 15:56:18 +0000
From: =?Windows-1252?Q?Tom=E1=9A_Peterka?= <tomas.peterka@dronetag.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?Windows-1252?Q?Tom=E1=9A_Bene=9A?= <tomas@dronetag.com>
Subject: Re: [PATCH] Add Kconfig option for altbootcmd when using
 CONFIG_BOOTCOUNT_LIMIT
Thread-Topic: [PATCH] Add Kconfig option for altbootcmd when using
 CONFIG_BOOTCOUNT_LIMIT
Thread-Index: AQHbcytyFZq1DXMpLUGSNQRnnNGSEbMvhxcAgAZK6QA=
Date: Mon, 3 Feb 2025 15:56:18 +0000
Message-ID: <75e42366-c190-4a57-8f69-b01da25acd19@dronetag.com>
References: <DB8P192MB0743F697B33A404BBC96460383E92@DB8P192MB0743.EURP192.PROD.OUTLOOK.COM>
 <20250130164758.GC1233568@bill-the-cat>
In-Reply-To: <20250130164758.GC1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-imapappendstamp: DB8P192MB0743.EURP192.PROD.OUTLOOK.COM
 (15.20.8398.018)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dronetag.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P192MB0743:EE_|AS2P192MB1984:EE_
x-ms-office365-filtering-correlation-id: 74cf1254-5bb6-4a3c-ffd5-08dd446b4bdd
x-ld-processed: 22487ee6-dcf2-428e-9245-e760401ebd0a,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?lL427BTsrHVBtkzesSLh/KN3EN1/12tfg6YyXvQuADj/9YIShL7TyzLR?=
 =?Windows-1252?Q?wHKLI20jnFbAwp1DDwoPILbRtJfYeUdFofvONpl5VBPQq7Kd744wsfBS?=
 =?Windows-1252?Q?L4zQf8wwjRBYG2VYh54HugsyFlZ4CMx5NVHFAxZIiRQfITcYJ7LhOx9S?=
 =?Windows-1252?Q?nmHb+eY1fHIO4aOLhLxz+VEB0FLhq/16WqOzVumwNzkfBGzbK0gDc6Av?=
 =?Windows-1252?Q?50iL0h89dSisBX/d+n3SNfu0UvSHV/Os+3BhcD7rciZln8IRO3QXlWGu?=
 =?Windows-1252?Q?G9UmF+mOv/Elgq34QgIR5WZ50mIt8dTEkvxvJDJOXseOcQnf9M5XnUBT?=
 =?Windows-1252?Q?xCq7YQo/p3Vkj4UtnxM+Yr/+3pxTn+5sXtyY1FS71uorWjoLSFpm58CQ?=
 =?Windows-1252?Q?DqYqaMhoLLZbAb8JTctgwSZYIGpf3WYI6Pt31Ckjg/TTztog8gEAr5iw?=
 =?Windows-1252?Q?Txv+ylpuXyJN2XR2zM871PZikYShFIPmr1eSyCJFwSbh04S5eyBrA6Tf?=
 =?Windows-1252?Q?zGdGMGtY5VNdhTpTcPDwJbBq3jMqR/TQBRoXJcDw3zU1gf6yqnQPve9w?=
 =?Windows-1252?Q?/dSTDRvYKU/Q9m1p4CEBFAmClTrGwzVqVIdYOFpBCDz0dY5eScynZmXo?=
 =?Windows-1252?Q?pBO76X5HESgFZLdyOdmm89bZaq/lQLmkaNRZEhI5Q+/2bf6vx4wjHLqc?=
 =?Windows-1252?Q?SLjkxiXRHxbpMQkSq7c5O3qioDE5lKSEc2A/EjZJ8OnBL5DCz6qmedZH?=
 =?Windows-1252?Q?zTOnyCGfJJ+tJjJYfcLEX7+o+WCIuYA8+y/1kloCQJWhw5AR/eV5xRfe?=
 =?Windows-1252?Q?JeiHIOu6i8g69WvPyfKjIZn0glE/+1b+1t1qCyLEx6nhWeMo+OKAAZ7i?=
 =?Windows-1252?Q?UA4WoOxcHCNjUzRdbbX+5yucVPhsTzDCoRgT465Cz6w1ek84FJZIqYK4?=
 =?Windows-1252?Q?rcn7cJYHlMdEclq8PpuKfGNSNYj1IWcxYqfYs7qRZmcrx45WBGARLvgN?=
 =?Windows-1252?Q?si1A2B7LojjsvEfnzHatS+hNWFMloQvkpx/jCJYTeSBoIDKXS8zoRQuU?=
 =?Windows-1252?Q?4SJCZ0/946l29Fw8PUUM+HhIiHJ4oEJUBvW5TmiGy/bhJDfaNPEjBYey?=
 =?Windows-1252?Q?q38U1UrfBxMZe4SAKQbWKGK9ORQ04SgXWG8qmYLvyWgDBJCBnUTXRXaD?=
 =?Windows-1252?Q?caL2vxWD1ZeLqb0eGOzAYH3BE5s1gX5CFf4bOeJP1pdIABiXzkOX1tw/?=
 =?Windows-1252?Q?BrxXXpqhrmqqkUXClKmCfPxLMW9HjL5wAOCaFVoIU+vaCIDDNH/tcfk9?=
 =?Windows-1252?Q?BkiYILYFC/HVyHpZ+rT/iXBMHEpAWyFLX3ACWeXHes4S/YCZtQh0/k/8?=
 =?Windows-1252?Q?PEiij6oovtm91kzV0q1upfvuj59Q1PiYiflRj0KeFDTsf9cqCh1sN9fF?=
 =?Windows-1252?Q?bbhsG8OsSTlzf6Z2K7OUbhUnZcl8fa2+F74VVWaau9ljCLT1dwXst+bx?=
 =?Windows-1252?Q?aYDdQkeVu4lpFxZXbWXQEzPByvo4HUjeHvmGMfsxiLHYsYyWFXP157lM?=
 =?Windows-1252?Q?PdR/Q9gnmY90RHim?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P192MB0743.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?KZNITmQArW/43sst4E6imZE2Kyzz0vsDWyVHth8dI6UgJUw7afitHAmQ?=
 =?Windows-1252?Q?oYEV8z4S7XbCWf8jSjlBBJzCbwEGwRHsI61BIWrh84Vz2sG/j+PR56Wf?=
 =?Windows-1252?Q?EdaJOjoW+/uDJNybqmmYgpHmM7oVl6GpVRftcTQslMbSVTtTlJnCyhUM?=
 =?Windows-1252?Q?S3o6jJ1eXjodhldZh+ss4kNDIxmg9pzv/Pbvpl1pnfP+nYs4yVXVbnif?=
 =?Windows-1252?Q?IzXH0Ni3AvLKCK2a3SFZ/t5LTn+r0AIuOAlgTIi+catd/YaipM5fPbzI?=
 =?Windows-1252?Q?82nX2n+m1SlocZ0ikMmY/iZelgx58MYl72t88thZadig3r/LVDhCmp59?=
 =?Windows-1252?Q?SmNfxOSFiB1OYS/iD+zayxZwDd2u477HaYMF67fCHHAkh0MHseoqoYlu?=
 =?Windows-1252?Q?kGoxXYRO3F3I/tli2miWKShb5KQLYMYtIhsyYHEiTQndAZO/AwPkO/i+?=
 =?Windows-1252?Q?v6Lk9dhleWQDA7y92nFbSSrzVMYpASJrQ27CPC7hbteTpiRo/QXePlPp?=
 =?Windows-1252?Q?JtEfuV6b72j9DK/DlTZkhWvJDaYGaYBmKjuelQlG0xEsgkWAYysMxi/v?=
 =?Windows-1252?Q?0xqx1dB0VrH1wyFBS7jKmksn1QomHlsoajKe0S/SnIpu7m8Md/573qNi?=
 =?Windows-1252?Q?Pl14oF+03j1fvDJHZBux5/gWdHjCkNJyMOTNGBpjOOkjF7llkOoVDpXY?=
 =?Windows-1252?Q?hhM1HYMjKAGzkalsy4+oLj9gmaH8dooOBxU/jLtVwBNwa6xH5MTGwETA?=
 =?Windows-1252?Q?kI57GPKbtA1yI7oqJ+FQIrcOM1lULfl4JOp57d6o4tLiI/aASCRGq58p?=
 =?Windows-1252?Q?O8K6/tUnpePc0lehR6grMngUeCbOK4e0QxoJbpuN5OP0MmF50MBgoHnF?=
 =?Windows-1252?Q?D+fHGk7LEg9xraBy/C6BaPAUzvwRBcTGxP4o8WkvEqA6pS1jbjBG191c?=
 =?Windows-1252?Q?XOPDP3s0ahSXiwckDL/CQE4vxLzFjQa7iAq/YAnJc22+w9SYM7QxDhxp?=
 =?Windows-1252?Q?2aQWxJkTn0y2VdW8PdueThn4SlKJu6swE5WAT6br/58IA9ec/XnAwmmm?=
 =?Windows-1252?Q?81grs3v6w1zGhxcBqgr/Bvq5w8Y/6LbkAupCdxg8i2/eCRdF8KlmUtG9?=
 =?Windows-1252?Q?sdqHvkJoc10z09CjKLXmXA6E3YlqchFHCbRFLejoFPvf86LMU+5JT6QW?=
 =?Windows-1252?Q?o+kpmIa6ck8mrttK3Em/suvpRbujttu6JbS4baIky8CF/xQYURYe4xl+?=
 =?Windows-1252?Q?p/vqsWNhxYMi5WcwXksaEOMuWl0ZBJ+81fY1PIArl7MPjA+DZXTnWxdF?=
 =?Windows-1252?Q?lFvNBTIQW9bAf8Q7Fnpo2GX2Babmtg4461FOk4k38XY4eJEk3KonRaMa?=
 =?Windows-1252?Q?uyGLKcGSpMOt5+sQnJVuQz0c3GGmDhGEHjZE35lh7UDlmk4HjhV2fw5h?=
 =?Windows-1252?Q?Ot1VfsOPjLvAdcG4ZtakjOfgVwOyydAej4Cw4Pq831G93DvDqy5TqFAR?=
 =?Windows-1252?Q?zvm8d7jnnqEQVGt5Op5OyNENBDd6nnSTK9/kQPl+Y8KNz/UTUAYiCBZl?=
 =?Windows-1252?Q?/4NT9RvpF6X8GV/rKOJJMmfQxGRDIYUmC4hRmIrWMYbfHXNb9FbM04K1?=
 =?Windows-1252?Q?s90xpjfixLEtwCMlI2FigECuaeVT0A7hrbSRvkA+x1MGmSqUgYpLVnky?=
 =?Windows-1252?Q?6IvMANkKDFY9K4vejrXz+KfEmU5/+CpN?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3EB96003C2DD2B4FB6F35D1270FC0E8B@dronetag.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dronetag.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P192MB0743.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cf1254-5bb6-4a3c-ffd5-08dd446b4bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 15:56:18.1406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22487ee6-dcf2-428e-9245-e760401ebd0a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bamdzXWNyYOXh2+AMdH2k9eLElmyL1qgCsQT2MolHlUwWQLmenUWPm/6BkrJTWMPLCrIkb+SW45wgzxMe2JetzkQdhlNvyOiI2I48OtIDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB1984
X-Mailman-Approved-At: Mon, 03 Feb 2025 18:29:30 +0100
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

Hello Tom,=0A=
=0A=
sorry for the formatting of the first email. As you might have figured =0A=
out, the it was not send using git send-email. I tried to do better =0A=
later and I had to use different SMTP server and account =0A=
(atheiste@seznam.cz) because our company email provider is too much =0A=
ahead in the future.=0A=
=0A=
Hope it didn't bring too much confusion and the new patch made it to =0A=
your mailing list.=0A=
=0A=
Regards,=0A=
Tomas=0A=
=0A=
=0A=
On 30. 01. 25 17:47, Tom Rini wrote:=0A=
> On Thu, Jan 30, 2025 at 03:44:11PM +0000, Tom=E1=9A Peterka wrote:=0A=
>=0A=
>> Hello u-boot maintainers,=0A=
>>=0A=
>> I would like to merge a simple patch for user-friendliness when configur=
ing u-boot with Yocto. The problem is missing option for altbootcmd when us=
ing the feature CONFIG_BOOTCOUNT_LIMIT.  Simply adding the option CONFIG_BO=
OTCOUNT_ALTBOOTCMD into Kconfig shouldn't be a problem when there is alread=
y CONFIG_BOOTCOMMAND? Users then can use CONFIG_BOOTCOUNT_ALTBOOTCMD instea=
d of misusing CFG_EXTRA_ENV_SETTINGS (and friends) that are usually used by=
 configs of specific boards.=0A=
> Thanks for posting this. In general, yes, this the right approach.=0A=
>=0A=
>> Many thanks for considering this,=0A=
>> Tomas=0A=
>>=0A=
>>=0A=
>>  From 9f5d1863e99c3a33893381cc924f25797b4b6f8a Wed Jan 29 19:06:55 2025 =
-0600=0A=
>> From: Tomas Peterka <tomas.peterka@dronetag.com>=0A=
>> Date: Tue, 30 Jan 2025 09:00:00 +0100=0A=
>> Subject: [PATCH] Add altbootcmd to Kconfig=0A=
>> Upstream-Status: Pending=0A=
> Here is where you need to explain the purpose of the commit. Ideally=0A=
> this is what you should git send-email as well, as that might help with=
=0A=
> the next problem.=0A=
>=0A=
>> ---=0A=
>> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig=0A=
>> index 0080d2a165..982ddc9826 100644=0A=
>> --- a/drivers/bootcount/Kconfig=0A=
>> +++ b/drivers/bootcount/Kconfig=0A=
>> @@ -183,6 +183,12 @@ config BOOTCOUNT_BOOTLIMIT=0A=
>> counter being cleared.=0A=
>> If set to 0, do not set a boot limit in the environment.=0A=
>>=0A=
>> +config BOOTCOUNT_ALTBOOTCMD=0A=
>> + string "Alternative boot command when BOOTLIMIT is reached"=0A=
>> + default "env set bootfile altboot.scr; bootflow scan -lb"=0A=
>> + help=0A=
>> + Set the alternative boot command once BOOTLIMIT is reached=0A=
>> +=0A=
> I suspect due to how this was sent, there's whitespace problems.=0A=
>=0A=
> Also, we shouldn't specify a default here, as that ends up being=0A=
> per-platform. Migrating that in turn might be a bit tricky since you=0A=
> need to take it from a few different places depending on the board. It=0A=
> probably involves doing some loops of building u-boot-initial-env for=0A=
> all the platforms that enable BOOTCOUNT. If this sounds a bit too much,=
=0A=
> I can v2 things with that if you like.=0A=
>=0A=
