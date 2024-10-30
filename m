Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A58FD74961
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 04:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F30D89099;
	Wed, 30 Oct 2024 05:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUCTo+hh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A56891CD; Wed, 30 Oct 2024 05:37:19 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC258904C
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 05:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq2zZTkl8MGTGcGRfz9S7UPUAB5z21jSSzHVX7Jqq0cehFAUUNLNEwY+9oq1J5+r7HToHid0MvvqglQq6GLuH1gKPcNYthSEFM0gt2rbGeJRyTKh+tYu/EHkH6E6QjdakJO8x7jLFJMyMhrMPDiWdzCATQpmCkgaMDAKYq+l9nMkf1RvI26OvSloQqqaOtMscyqROZ7yQUPRG5WLKqILwrJ1EKeClC6FviMjOk6AJMdLrFachJt4RRjZ6AL0wx0eacSL9S/BFTs7Qie1K30sAsEL+mm/rYutMlayYfyGDOUIdd7VENNFEBvvsQH6cSNunbHPGrUcRU7lfO+tIYizvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an/2FJ8qoihBEOCa7k9JtQHDytx4khhi8ODhjcR/4rU=;
 b=NhJoGllFdc+K14F71GW8TnjW5QHc1wpfvQ0V2TfiCoSvrTgLtpLP9In0O13qdIcEGWOiq17UAOSviODOBzpe7gUewaKqxeH0y+EES8qRv7oRJMYKjA/PhPMNVn53ketkTuiA3vKmryV8/4C6IPPdemeZQcUQjJIt7M4PwjQcx0DabEcdlx1VgCdRSuKFQudijziRDEarSX2nTxUNNUEBZOKu4hUw0VhujCiq1996NZ/4jH1cuTXCkOa4vt771O4dJKLVYu/NW2LzTolkiJMrLEkGnS9GzA/M/4PdzG35SKz5pnQ2/fwrIgGeedE1YdDoJeI/PM6bDnm4b/s7wep6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an/2FJ8qoihBEOCa7k9JtQHDytx4khhi8ODhjcR/4rU=;
 b=DUCTo+hhePzqAu6Z0tyvuCXVTNzxedRuayRVw4DOgcg9V9YuXqAeYiFTT1l8Sc+4Q+a6f5bl0qq67wPRgwCPo1pOpewidiZSzthnZKDlnZ1E6K8UsrgJOqDbaBwvSiZYFt84n6KRbIhlj6/2DxNq3uMvw4rgMaUuXSyc7qUcTuE=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 04:37:08 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 04:37:07 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>, "Kumar, Love"
 <love.kumar@amd.com>
Subject: RE: [PATCH] test/py: spi: prevent overwriting relocation memory
Thread-Topic: [PATCH] test/py: spi: prevent overwriting relocation memory
Thread-Index: AQHbKfhaGtl1FFD6qEa+Jda/78BVZbKeGSqAgACdHNA=
Date: Wed, 30 Oct 2024 04:37:07 +0000
Message-ID: <CH0PR12MB5266CDC27F39EFC6AB36AEECEC542@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <20241029114709.3983243-1-padmarao.begari@amd.com>
 <20241029191253.GH4959@bill-the-cat>
In-Reply-To: <20241029191253.GH4959@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|CH3PR12MB7596:EE_
x-ms-office365-filtering-correlation-id: d003f7a5-e04d-4634-7532-08dcf89c82d7
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VZmO+81LFpUh03N6tgbzH5jBnwm59aquT0VVKs8HuRF7h0HUf+1IgYjMapxj?=
 =?us-ascii?Q?NOjfv13ztWMkoSuNUVtQgxX89ZT8pQbBJy9587pul9iBrz5nYzzW6lmdgZSX?=
 =?us-ascii?Q?KIsw7G5XkBsTu6GVnxk+YCb/hWIiC+MJq4sn49d0jnVWQnrr89ao6NzCP3yo?=
 =?us-ascii?Q?wAl/vkijySn6PDczm/9OjoI0Y/XfZSlq69yrUY4U9NKT5reniiVBhR99Dk8q?=
 =?us-ascii?Q?g4ew8ARXHOFREUctvNpmMZ+yU723C9DL2oaYvSLA9NNw8D+F3t8EsVifozLA?=
 =?us-ascii?Q?JgDB9HvyS6elSiwSKsBwCKxkQplqfClqmhRIsf588NFB+5E5QKydY669TceR?=
 =?us-ascii?Q?MFXaKdJuFO4chnoo+PBphgfCA1YSEtMJNB6ECajT3aaQwydsiFbMwz0HP2l6?=
 =?us-ascii?Q?/kCmaoA4UPRSqFKCamYhwKUnXyZ8mcoC42RqFo9Ocf759MgbkPIChWKmi3WO?=
 =?us-ascii?Q?UWTIKZX9pJCg41sUY8lgHpg6i1yFwJTFgstPbFEtPye9OngvvQLw9r9Mn51m?=
 =?us-ascii?Q?j4a+4gAu68P5oSK2mU5wlsKcbbI+vI0zCYms+bu565YHm9eChlloW2uz5ImD?=
 =?us-ascii?Q?+6jS8J68pk+l7zaDo4Gx85uYylj0RXAoc2VK4W67hIgAPlRQKbhivHROh0Ag?=
 =?us-ascii?Q?RhOGeHxkKupyQ876jONNnqg1z+lHynlBkPLtj9pw0i9B+OHWb3XaHy53Hatb?=
 =?us-ascii?Q?s+2xQY5osJEoLHAMw0bV7C1LdBo7y8miY7k/07U6BrvWcNWfnJHIvtU+4YeN?=
 =?us-ascii?Q?Uv1CcIgnjqOJ8xZL6dj/xUXsbEr4LKuzQKmF+nCyC+3KO1LDaKMAv0eHxbKU?=
 =?us-ascii?Q?zE1B7yNiZLebGmUVpa5rETqSW/tZkXK666LMxUJHnNXkQrjNp/Kq2ZcUqxDO?=
 =?us-ascii?Q?yjRH3Cw1zxxRCCZuCxjeUfYDPq8Dxs7EznOpeBoN6UyoEVIxwc8/7gmryvE+?=
 =?us-ascii?Q?u7pdElXmzLWBu0R79Sd4tLeC7HIXKvff19p9XtNdOTO+zRdSJ2uYv//pROYk?=
 =?us-ascii?Q?BxrnpJpGdcBWaeM9vPFFOM3ioIVrzKJxd0zAsUFflDb2zIATchO16wV79sg+?=
 =?us-ascii?Q?6vznzggXsOy8TJbzR8X7Wm7D8eo5c/nWKuatolWS8h/1V+X2ct1TSQlfffmA?=
 =?us-ascii?Q?nsk5EVWcz8AaOd/CZWe5efUYgvT/tG5oHCCJISt88ZL9JatgpoNzf0EzA+KB?=
 =?us-ascii?Q?zrNDilpcvq+2ziDACLFDtKM8nUpJtKFikfpQ9BC+M0mPRxRZD2BMFCL4S8ly?=
 =?us-ascii?Q?eSJ3AGB36/pJpa+aGLy+EJw/jupZD5w6mbRE4OM8qtNFKy1ABTGbGkp4n/E4?=
 =?us-ascii?Q?wUTYPMRGEe6MKIBBjJdZBp/rIaUSifKP10o7e3JqTu4CVWVw69WcYwRJRP0e?=
 =?us-ascii?Q?qkBI2TM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Jg1eI/V4w+U0bn0XtuzomEcVW5T/NqFjuJHikkV5iXbbJg1McmUtqudJ0j+?=
 =?us-ascii?Q?ovex/YZu6yQyQs4LRen9tQiQC503qhzcmbtDD75WYm9/m29ixs97Gst1rU3v?=
 =?us-ascii?Q?xI3SKccSfEkfJ/zfFloEhtYemyDvDYGKqKlGic9QkL+ei6425VjYXev1G9rG?=
 =?us-ascii?Q?dWxjOOHkhofCnfsL9XpE4yDhYiqKEiI5T8k2VwpCmUHxrrpYdpPaXYwWRgar?=
 =?us-ascii?Q?IY4bdBuypg9mcXBCH9cdDwTP1Pl4jyUlLj+h6sdP80hnh+bLoLpaSGFk4iT7?=
 =?us-ascii?Q?/BakSeuIVhdQlSlBIVcrfUi+7r7OYPtUo41NOwkEKc2YMa6ZR2Z5eCUD1X4n?=
 =?us-ascii?Q?9I1J/+I7Zv4C4Rg5kB20M++dMxTVXLTBjCSEX6yxBPuv6mgEBLDyHkdbhfbY?=
 =?us-ascii?Q?xaqzlH7rcPnNTPT+v4CAgw39ItmrxmBTfLpVnBpyMQhWlT3kCTHKQfPhLcE7?=
 =?us-ascii?Q?0+uBWkumOOszv2RZP+IIkSva5kFiO2hcFCrPY8FX4/MK5CmKrp9Jk2TiH06C?=
 =?us-ascii?Q?gF6oMPOibutjyLtRb03asFBxBnGOrQYRqnpvNjDn95K+GVSqQENU787uOf+5?=
 =?us-ascii?Q?CgUEH9/BE19cT/N20lVOxgxlIDia2aC0pU2All/0zCpbnU/8VsYRf35zm61s?=
 =?us-ascii?Q?BMwIdJQvRMeH0Nr13XbWmPviHYdFdGy/ywKrCTZxy5Cnk7rVXyCff62KnUbZ?=
 =?us-ascii?Q?+E7CYpcPmdUR/6riypowQMCXGfB0ACSrsSNZd8oMUxY+1WZeIiuEVlT+rCME?=
 =?us-ascii?Q?Kq06ZZg+mEgOBYuBdhG9O74ZOkk7Ytnb+qS7yyW04kFEECYjZTUQSzNBBOVi?=
 =?us-ascii?Q?wpAASTNU0iUL9U0ntSMf6etkXRIfPTlbinuRnqEaykzMjYzz7fQFoZ6qbn4i?=
 =?us-ascii?Q?48OiMEm9uk4TA71oc9hTR3GTpIT5BM8gViAXAfCj6L3Ktb6gCKoWnHp6Qr2B?=
 =?us-ascii?Q?BegzoxGDoIke/Pw5Vo9Or/4ObURbS8nDbYDNkecgbszMLKjNiiweJdPzOUax?=
 =?us-ascii?Q?6/oygNnKLSY9mVJdNVi5DjhxVXnUuSmWAI1hXxBP5865yVl8FAy9PCtvyX7o?=
 =?us-ascii?Q?ViuWuF4XJuU5nVZ/YGsWnWm04F2+iiYLG7N56KMI+4ExVtZiMTKJKjb4U8Ic?=
 =?us-ascii?Q?xzQDZpC8lBcfc/nwe+r920eQWnUd3xRVqb0ZL0cmejQ3bsk4HfKowtokTVqZ?=
 =?us-ascii?Q?z+fXK+xluEzzIzpImNWdkZbIaQQAJrjiLqJmLxlAxFJQWcKvKE2gK4W20Z11?=
 =?us-ascii?Q?J8iyTwGKRpOJj7hipFF2w8B8cKfDXuQOKvLAlIv7GYuRsObhg8dPDMgNxeI2?=
 =?us-ascii?Q?1XYrejKaOhoDrXFyNLad+yEN8YU/zDUuWjYExfTN2px5Fkv0oeTtKjO4oWgl?=
 =?us-ascii?Q?MHUPi8OyPGAG6Kxe0bu5s4r5JrVBk5G0WB6zwCbqWNXTXRtRlqbzM4vVPgzr?=
 =?us-ascii?Q?jC6DEa2kFWu9CCzlPJcNroALsR9iLPT4C9DCJVrAhgPRezIiTCYOZXvMBRNY?=
 =?us-ascii?Q?pvmiQzxV8e1NlCMKNbDVwb6hBnFW7AcYRlbdLl0AXjU7EHpz/pZ8E2pemyub?=
 =?us-ascii?Q?CV3uZxTPUk55lAG8iSs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d003f7a5-e04d-4634-7532-08dcf89c82d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 04:37:07.3010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/lQiq9LSB6rGtgFkNMgNFkqQDYrpbmv/o84R61asWETvfc2a7uMwCKmx1pWUeCtzbj27oTeKXRbXO2MBcQW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
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

> From: Tom Rini <trini@konsulko.com>
> Sent: Wednesday, October 30, 2024 12:43 AM
> To: Begari, Padmarao <Padmarao.Begari@amd.com>
> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Kumar, Love <love.kumar@amd.com>
> Subject: Re: [PATCH] test/py: spi: prevent overwriting relocation memory
>=20
> On Tue, Oct 29, 2024 at 05:17:09PM +0530, Padmarao Begari wrote:
>=20
> > Update spi negative test case to prevent SF command from overwriting
> > relocation memory area.
> >
> > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> > ---
> >  test/py/tests/test_spi.py | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
> > index 3160d58540..caca930327 100644
> > --- a/test/py/tests/test_spi.py
> > +++ b/test/py/tests/test_spi.py
> > @@ -693,4 +693,16 @@ def test_spi_negative(u_boot_console):
> >              u_boot_console, 'read', offset, size, addr, 1, error_msg,
> EXPECTED_READ
> >          )
> >
> > +        # Read to relocation address
> > +        output =3D u_boot_console.run_command('bdinfo')
> > +        m =3D re.search('relocaddr\s*=3D (.+)', output)
> > +        res_area =3D int(m.group(1), 16)
> > +
> > +        start =3D 0
> > +        size =3D 0x2000
> > +        error_msg =3D 'ERROR: trying to overwrite reserved memory'
> > +        flash_ops(
> > +            u_boot_console, 'read', start, size, res_area, 1, error_ms=
g,
> EXPECTED_READ
> > +        )
> > +
> >          i =3D i + 1
>=20
> This got me looking at test/py/tests/test_spi.py more closely and this te=
st is fine, so:
>=20
> Reviewed-by: Tom Rini <trini@konsulko.com>
>=20
> However, the error message 'No env file to read for SPI family device tes=
t' should
> really say that it's no test device configured (and similar change for
> env__spi_lock_unlock). A follow-up to rephrase those error messages would=
 be
> appreciated.

Sure Tom, we will do.

Regards
Padmarao
>=20
> --
> Tom
