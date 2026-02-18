Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC67E9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 17:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E3E83AA9;
	Wed, 18 Feb 2026 18:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ErGes8K2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9CE83AC5; Wed, 18 Feb 2026 18:19:18 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C433D82A9E
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 18:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=walter.schweizer@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja25qNXaGH5T07kbo/Kr5TEcuvRD3fSuP4416mdbIQA4fsOeGKVD6YX6ljV6WjDRMgB3r1AdPPc6w4nE1epcr2B5ajC272WXqE5QOcOs9U3IdntE4PQzogHJdHZwGv1fkFBsNluLhbycrgsrRNBQq6tElZGw3l40QdK1+ouSEeOS9c5D26RIKSO1Xc8mKXz5m4e+C74+gDTc0+VX3HabkATZjEUB0yspJUwYQ8Oiv+dkRJIyty1XRJWLvH3z1LqACJyJiSb5ZHZagJdkEL3Z/huIqEFMOfiDxtkU4ME3531rscZ1nCYce42zV69nL133cjLQGe8NK5p/qWus/OonJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xyIafoxx03QlWea7Dxc8lRVlP/05gMH7rUbx7l2Ijo=;
 b=EU+QRZCOjq7A3kWfEAHF+JQ7pv25DQ+72QwDI6CfLeL3QvcIA9slpUPj+Ejux16o9RAGqQcqryoCS/VDse83GGN89jVy0bE8J51vMlmJ+YF/dlY33fkWhK8/KoM4Pffjxy7exuFwOl7M6wha6cXsJ8kLtdVY01X2SVDpVO1d1GZp9c+F2ZoTYK8WVEUBmpvT0+rjhU9nFEKrdGfZg2XVewDdi1pwX46iWSc4yp6zIHbGY05+HxlVKjmr8XwmC+TZ/oP0pPgBlimkIl5mUEZ6+qnCLLf1pffTitzolIpkYaM22wC92VP4rslREkqL74qnlKA/fuOoUrqJpJhgsUL/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xyIafoxx03QlWea7Dxc8lRVlP/05gMH7rUbx7l2Ijo=;
 b=ErGes8K2tM7nR5HBLuG46tipDDHlizNnN5EKndunrSoeQ3BL52GiXiJgOfF1dWmHIsdUpjhgLkuQXGRsRiMUUaRzL/78Zb1e1yL+/elxYJWjrWTWJEeRzM6Qid7LujRkv5aKuYbEbFpFyJwzQPY1PECrhcRgUdjqeOLrzgTk+vnFtFw+d9M/XO/DT3B8fJViDya1+V6HA7G9XhttdWINvFF4/vFje9/DvGqrGS0d6JOq8qiKUEY8fGq+IVuQxgFqa0O7lBVjD4HJhXsr2RaNEKUGvQt9JsguZj7+xXLyoAPxBEj8DKYWmDkIWF9+PGVoK3D+RESnRv016rnFFr4BAg==
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::15)
 by GV2PR10MB9654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2ff::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 17:19:12 +0000
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b61d:120c:39a3:9714]) by AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b61d:120c:39a3:9714%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 17:19:12 +0000
From: "Schweizer, Walter" <walter.schweizer@siemens.com>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 "Freihofer, Adrian" <adrian.freihofer@siemens.com>, Peng Fan
 <peng.fan@nxp.com>, "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 11/11] siemens: capricorn: protect environment
Thread-Topic: [PATCH v3 11/11] siemens: capricorn: protect environment
Thread-Index: AQHcoCv7htpI+h8KNUGx7IIaOJTTWLWIs8fQ
Date: Wed, 18 Feb 2026 17:19:12 +0000
Message-ID: <AS8PR10MB75243E1247427727F02CB0E6866AA@AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM>
References: <20260217163911.31878-1-hs@nabladev.com>
 <20260217163911.31878-12-hs@nabladev.com>
In-Reply-To: <20260217163911.31878-12-hs@nabladev.com>
Accept-Language: en-US, de-CH, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=6982f64f-ddb7-476c-b1ee-c8dc1429a70f;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-02-18T17:14:37Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7524:EE_|GV2PR10MB9654:EE_
x-ms-office365-filtering-correlation-id: 1d08c8ef-1cf0-4334-ca54-08de6f11d5d7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?hfsAjQcRSBx7n/6/4Ua18fmiclIJBKn5/zIuFO9usa+6kuLnkhPlDzzbB9hS?=
 =?us-ascii?Q?f+KdI9WWFpY7hhyv8rQooRvoMMQTf4CZeMAZdo0kcbPzB7mGBumj6M8cSEgd?=
 =?us-ascii?Q?nLZwRtRTP0bRfT9urgI1tmJ50ZE7vc+VUzxFABXMOUFgj2+GPnBLqBOYmJNF?=
 =?us-ascii?Q?E6NOx8jPRStl80nvv0qE8PCZwHJragZUfF+lUN0WdkCfbVeUTwLQwgtwKDrv?=
 =?us-ascii?Q?BDrMz5HdfeP4HiAPKEUQ1vY8STZY0ESEH1koK0rbA6FYKROfCOB8esBWmTwc?=
 =?us-ascii?Q?BlslDOsnvQeK56ru0wZbAFJRitnOa4G37iF4yxms3tv5Fz7ry95qerNHv5/6?=
 =?us-ascii?Q?FkljSlla6Gw+FXsjHLxCOGBCsp0tBNLCQFOOqomiFF1oEjDCmUGcWtst2XTr?=
 =?us-ascii?Q?Ul4ALmVi3Na6bfhBAYtIGjq9hY+RzNXcuoH90QltAZc0a1hpGeDcLdcJl8qO?=
 =?us-ascii?Q?uy6+BvTNx4XX5Z1uTciMciiWfKrq7qIAqYcvtDjaUTiL/VDWZir2ANjHmKW1?=
 =?us-ascii?Q?OD9O4kQMKvNeQM4SMZxoG6xUvIWwcFI+j8JgkMEz2kNdOMYwTUyqNInUFC8g?=
 =?us-ascii?Q?FzVW7dl+JwDe0thKkFJieyr169l5dT5BP9g218AV53wFe8Fs2YauRFTfKB2r?=
 =?us-ascii?Q?nBiyKnDHM0oTNM5IwZtGGJwcXlA3DwndRqOrvLhfZFzTfEcYFeKWOFSnnDNr?=
 =?us-ascii?Q?pjO31TrEYgzdiWjLXWRLANcGIlXtYa53Ns85HfpXOEwFzy/jI7DD94Ya/7mh?=
 =?us-ascii?Q?XJpQ0ZMXKN6e+4DvhETWrR4qJVSW2ONVT1SwDc+DL/auQq9flTeoY646xtpU?=
 =?us-ascii?Q?TzzeoZP3Y2KnzV6RoR6PpPx/waP+ckf5HDgvUCe/XU2AbjYdPPLYdkJv+JP8?=
 =?us-ascii?Q?8z+PyiHlmDGE0SRqePrCxeRrKuWFOAgV10tFso4SK5YABcAWFRczPg89owHK?=
 =?us-ascii?Q?VtHSeO02NMT0CwT5N7Tf8bfTLsWF7XWOXF0T0B9cpnht0TgmGo6nZL1lEmGK?=
 =?us-ascii?Q?MWSh6TPqbn9eEMS5iga7Jt/2JzAhmb5SuVYxkilXuRw39oGVv0mznm/EGbDP?=
 =?us-ascii?Q?1pjViWz1TJGL+M0F4Rd/Hg7Kutdr/tdNimpsJkOSk4VFqHLNMyPKkN7ZQBow?=
 =?us-ascii?Q?k+6E9iyXGaVC8AxyZE24VViDslAu6jrxFREH6lHk/W6XICW/p1FHsD+HLTqk?=
 =?us-ascii?Q?OCSkAiRFqlAhkUCDr5OXKYBpox5Xfkh8fCPlqkfwrGgfFgX/yaI7ufKyyUXw?=
 =?us-ascii?Q?w1HARFSQKSWh6yexDXqBgEXTqeI4KqA0XsnhGOfjwgyFf5CadM/ZqPJDQH24?=
 =?us-ascii?Q?dBZyjYPru+ZZMj0wPTwpyYxiWz7brTp1AvOU6R/x4tcnRgOnIOSQxmufsNUR?=
 =?us-ascii?Q?aeSIUA7Gtc5Ta9yMFzJjI6k9kjPI3VA2QbxeBVn0sBzjJfA5fq5AawtTWRhy?=
 =?us-ascii?Q?tmiaPvD0Rc5TuJcoF9eSlDJCc0R2Bwp5Uke4d1A5tvwBly6ToMLipWtBDN0U?=
 =?us-ascii?Q?mP85fyozoG2+52XNaPT4tde4g41tVN1OhEVTGKsvmGijQm/zqnQLSRT+jeJe?=
 =?us-ascii?Q?yg4W1IL2UhMNoldVlqCkRqCrXkUFLk1cI5SY2UaodBAtm95bTjZfoxNChocs?=
 =?us-ascii?Q?bgRlBETkCA6WfsNaHsCcY/M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5or2ZhgO8+9DiytO6QDVGFz4cp9uDolAyrwj0J9TcuixeXDqR7yOGAWsK2xv?=
 =?us-ascii?Q?sO5VL9ylVNRpowjSQG+SoWGtGXJOV3Auv8ab2AlhyLPnrvrh975BEtTol1gy?=
 =?us-ascii?Q?41tzRzqIQ1il2SUkrvRGHPw6EyKDUqpHEuNt6U9grPIWMKegj2uL+WtGXFM3?=
 =?us-ascii?Q?Ky1Y1a5MYtbPVbw4ASLLuN6GhkH4HZg/9YR0wHwClJLr6CqucZxu5n+7TVzg?=
 =?us-ascii?Q?QX+F42ckpR9K5mmKoF/BpSnLhQx3zml1SMzJAXDQMymBayAbItCPNni90dzN?=
 =?us-ascii?Q?U3eFPgILw2RHUeiwmYoGFSV81g+GbbAZ1AmHz8oqmB8dgmM0vkgqBd3HS0vw?=
 =?us-ascii?Q?8kStICbZ59vrBHZaRDKhwvONvUksMpylhlMrctJ2qfJptTiixhjtHOUFQDuV?=
 =?us-ascii?Q?wQIIn+20TNRKUGSMgN53/IGPWluvoFaoUBQO4sUh5zJ4A3tDtVopsaRoD+Zu?=
 =?us-ascii?Q?NYgPQa2rAnJ1rKlWvMF9USfTqtQPG/c7ynxRRBdzqPBB0AXyQI+Fk0EGg5ny?=
 =?us-ascii?Q?UlN+pOYY7uj+1YrQLhmraVAH72M1jmilBwTN8iCWaE7e2T6+eWBQHCR6v7Z9?=
 =?us-ascii?Q?SqaOVrJUBcrnkcto7e11svjXFDsVPBkM851nXqjgIg2obS8GArnyNOUMfrLW?=
 =?us-ascii?Q?EWJftq6GvXVTffShy9kjm9oDyEcuLqCGIjKfewqyBV8edWnQQCbySnUHWn5P?=
 =?us-ascii?Q?4oYez6syZ+hf1EhbBaIAiuJM8tlNBjoynCel9CYDv//Sam9pmTvwrwyDLjL4?=
 =?us-ascii?Q?ovf6ZY9iE7+dRbGZe3w2u/DVq9ZfUHpCiC3DytTZA+isNmkeEhloDyHbAbjc?=
 =?us-ascii?Q?1gpqG8z/Om5Xo+E4Eu722qmbrsHe3ogWqrFbSf/jTmHzS5o+7OmXNYVyUmI3?=
 =?us-ascii?Q?RCRirC3+sqGm4jikqsvcMAHNg1JO4T6Y6Cl7teXvbvQNNfq+8x18bnPrCxsp?=
 =?us-ascii?Q?7drjN8RYAnV68Me6wVmVl6rMFvSJ3ZGrzr9oW1yjoFknKDitiHuD9f9UCBAx?=
 =?us-ascii?Q?xbn+mGYoT0HVzi1SHqbucJFu6+OiNAcxX85JnWMSBMfSTiUB+zs8UeK7tlNu?=
 =?us-ascii?Q?x3SVa3YqkyrMGRb9YfeD9JrJcsztCtXcJglauqrQDXh/Z/2hDbQ7uEQMsPXc?=
 =?us-ascii?Q?A3sbQgk9S9RFkGlZJX6AGFbP7neQ21isAYj+lPq/Ru9GjaNEcvIj4FyKLJjL?=
 =?us-ascii?Q?n9QvI5m+GnnaWoZ9iNQLxFDST9CTCkG/LvLCUmLHN0tpHQbyr6r7hXj2k37H?=
 =?us-ascii?Q?MicY798xIK6F2DUwgWzIJkBhJGOKuiAFZIYq00kTVnmer2nniS5oZ2oLG1+e?=
 =?us-ascii?Q?RQwqo0w+6Ef2Ph1O0JGjCPzTrVs9GVl1sa1RCtVnQvyYRClwzDdsME7r2/GQ?=
 =?us-ascii?Q?LvcB/wl9CyAjCXWnx1Wh3yvtNc7wjg+rxSVO1rr6xDWuAEMzkmHYT60unNSu?=
 =?us-ascii?Q?PvQ5cPPeS2Is8UW4lHpn0PUDFV827zdww/kktStDdWllZEHhJMGIe1Vu7f9F?=
 =?us-ascii?Q?+pfeIZnnLb7DwJRO9p0ZK5Ii3yJNw6tnQOQOHIF7yeNYvoIJGDJebaQP+V3t?=
 =?us-ascii?Q?q0rs15VWzhsf7D7PG2pVx5CrLtAqcBI9XCwh2kKVendxev25cPDkq2qh4m/P?=
 =?us-ascii?Q?oYUUyV10Qjn2DiGxHX72+4ihfX92KIY0rWMAhIEBQ6HVMvpKCiYl0bXOXbVV?=
 =?us-ascii?Q?z+KIQBhOo7l+pfYdeXka5vo6V4WRdrvrsZy4CPpgO/TRDpzXkRViKFKEy/6o?=
 =?us-ascii?Q?2Ms3c/aY5NyoGIF+EclnSLzdiuWqykw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d08c8ef-1cf0-4334-ca54-08de6f11d5d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 17:19:12.4935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpQJOTffRI2XdB4lb3P2pX9/SKmvnTGeEbLH2LCuRG/88uwejORKkw9NpNZ7Qb3AiFgUxGDWKTWqPCqrS/AYH2XhIXUpVcMMctniyWP3PZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9654
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

Hello Heiko

Recently we discovered that we need to add "bootcmd:sw" to the CFG_ENV_FLAG=
S_LIST_STATIC list.

Best Regards
Walter

-----Original Message-----
From: Heiko Schocher <hs@nabladev.com>=20
Sent: Tuesday, February 17, 2026 5:39 PM
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>; Peng Fan <peng.fan@oss.nxp.com>; Fr=
eihofer, Adrian (SI B PRO TI EAC CCP) <adrian.freihofer@siemens.com>; Heiko=
 Schocher <hs@nabladev.com>; Peng Fan <peng.fan@nxp.com>; Sverdlin, Alexand=
er (SI B PRO TI EAC CCP) <alexander.sverdlin@siemens.com>; Marek Vasut <mar=
ek.vasut+renesas@mailbox.org>; Simon Glass <sjg@chromium.org>; Tom Rini <tr=
ini@konsulko.com>; Schweizer, Walter (SI B PRO TI EAC CCP) <walter.schweize=
r@siemens.com>
Subject: [PATCH v3 11/11] siemens: capricorn: protect environment

From: Adrian Freihofer <adrian.freihofer@siemens.com>

With ENV_WRITEABLE_LIST only specific environment variables lisetd in CFG_E=
NV_FLAGS_LIST_STATIC are read from the u-boot environment storage.
All other environment variables are set to default values and are not writt=
en back to the storage.

The u-boot environment usually stays for the lifetime of the product.
There is no A/B copy mechanism as for the firmware itself. That means that =
incompatible changes to environment variables in future u-boot versions may=
 lead to serious issues if the old environment is used with a new u-boot ve=
rsion or vice versa.

Having this protection in place ensures that only a limited set of environm=
ent variables are persisted across u-boot versions. All the macros not list=
ed in CFG_ENV_FLAGS_LIST_STATIC are now part of the u-boot binary which is =
redundant and immutable. This guarantees that the u-boot version and the de=
fault values of these environment variables are always in sync and cannot b=
e changed at runtime.

ustate and rastate are not relevant for u-boot itself. ustate is used by sw=
update which persists the transaction state in the environment.
rastate is a similar variable used by another user space application.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

(no changes since v2)

Changes in v2:
Added Reviewed-by from Peng
Reworked writeable variable list, as we dropped patch
"env: add w flags for net config in explicit write mode"

 configs/imx8qxp_capricorn.config   |  1 +
 include/configs/capricorn-common.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.c=
onfig
index 626634cb09c..2bae5b1a862 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
 CONFIG_ENV_SIZE=3D0x2000
 CONFIG_ENV_REDUNDANT=3Dy
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=3D2
+CONFIG_ENV_WRITEABLE_LIST=3Dy
=20
 CONFIG_DM_GPIO=3Dy
 CONFIG_AHAB_BOOT=3Dy
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn=
-common.h
index 7120a44d186..ee13d2ab950 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -38,6 +38,19 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	AHAB_ENV
=20
+#ifdef CONFIG_ENV_WRITEABLE_LIST
+#define CFG_ENV_FLAGS_LIST_STATIC \
+	"bootcount:dw," \
+	"bootdelay:sw," \
+	"bootlimit:dw," \
+	"partitionset_active:sw," \
+	"rastate:dw," \
+	"sig_a:sw,sig_b:sw," \
+	"target_env:sw," \
+	"upgrade_available:dw," \
+	"ustate:dw"
+#endif
+
 /* Default location for tftp and bootm */
=20
 /* On CCP board, USDHC1 is for eMMC */
--
2.20.1

