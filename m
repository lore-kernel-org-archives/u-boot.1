Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C5DC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C838A83796;
	Wed,  9 Apr 2025 14:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dc4wFGMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14ADF82982; Wed,  9 Apr 2025 08:19:03 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D80482937
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 08:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gaurav.jain@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjOuQX2A/+sw0CCRAeb3WSK1wx/vwIMJzx7JVlbAHjC+dlNUih3EQISbuKDb8Fa9vOK0ohcQdM5K/sT1F40YHwUZAPJ2movfO0Kvo0w8tUCdHJoAwC+qZ/ukNfDgaC3G/DD1LJSe4OeLP92gHF807v4ElEb3VGFlsQJcX59r3/SoUbt5qq+ahutMX3oMoRDoMAwcvnaaTSEgCaQf0gnaXCrgf+pNg4UfdxGW7/1J0TAvK2TcVrsEFdVypEHJ9kw5/0S8NjKHH8eHopbi9mQsSchy8qfCPtDFs36DxW0wmoLV1G40kIYXKePCgj4zQRMt9BFrbZZv0XebvVi6RQ3zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QADpueFtlO98+/yxG3Z4nGeBIoE2pHj43wjvv00vmJ4=;
 b=RZ+0yZQb1RTRVaBLzwiXVb4zlt9cQoDDCOsCpM1QJ79hcQ45/83JJntcJwdkUGH3xEDAeDKLE6t0btvur4FokfidSbcY/s9nON0eS86OO/HFvmRHA2kPjF7ImeBUkzk92DNH0Uw6qYyHCzuMtFvMNy/+AjmXtzxvhqULLbP980mRaDjquwmMHxa/+oFPqx8aXlY7kNoGQ559mJ6t6HyJ6Zygl9p9AeJykw4PkQUjFq2dAGHG0TOF8+JQhhHO61jVmAaw9ruqJd6+s4/V6gHil/FxJ4MkFHlg6xXyoLE9i5JYbloWSAZ2decrjSgeSE+WNF+8LB/E5JeSEbVQVhtSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QADpueFtlO98+/yxG3Z4nGeBIoE2pHj43wjvv00vmJ4=;
 b=dc4wFGMqPQCnLW+0KPZuVGWzXCMmK9IdnnM9ywSiFzqbdr9eUo0HkX3TybJY8y4LBwHd1RJJ8iyIWucYb7g4fswDePW7gxfEqqQRil6Tv2Nv08Y3TsthVR1bw8x0bI5cAxRMF3ahyianY8/65PWeqHe1GS3/4567YySL3kF9wXriTqAYTNZf2pdRYumLn8W+/uF0fgFJ3I+/aOfVy3bw96p1DLf1KxZZ5oQ2yxma4sj0rH0+d76reywaHCeVOkd6OEZTtTQUEMmtMBoaJEgLp23mVMPavvON9W7gPmo6Ib9HnMHLgqEytCaJS56tHzOODiTi7meVh2oJkyuYclX9Pw==
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 06:18:58 +0000
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637]) by DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 06:18:58 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: =?iso-8859-2?Q?Pawe=B3_Kochanowski?= <pkochanowski@sii.pl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Horia Geanta
 <horia.geanta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vaBjTvT2QpjEqnwOdEJdye7rOZjCgwgAAPQACAAT0fgA==
Date: Wed, 9 Apr 2025 06:18:58 +0000
Message-ID: <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8409:EE_|VI1PR04MB9787:EE_
x-ms-office365-filtering-correlation-id: 964feb3b-809b-434a-ba1c-08dd772e69ab
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|13003099007|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-2?Q?f1MMTK20Ynjs/qd3JBLKnQNa2EwVw+kJQlnVU7a3ckvXi5TseciiGPRCL4?=
 =?iso-8859-2?Q?j3C6HbkxZyHvNrRhMDrRGSnSE9D/eNYq44eqsGdVGT5uwEc781qBdep0+4?=
 =?iso-8859-2?Q?1FmH2GNSFBOME7aQliACKD/llZaUUglCTMkbhcXx+jVYoPlz+QMemlIx70?=
 =?iso-8859-2?Q?QNGXQ5ce75OqNbMqxLjv9IK22lRRGaMudCVI3PVNNb0oEHByTw0Xfx4rqR?=
 =?iso-8859-2?Q?nQVmN2lRjQh243sNxptJMf53QYXJ1wAHjkpgSOAtgoHUcSd07JGRMqQtYD?=
 =?iso-8859-2?Q?RPluV7RilmhfibgG7Ctw6ByahKsP1EeLUE67jHsGfpZI8Vxa0/Z14BAybe?=
 =?iso-8859-2?Q?lOQ52L9eeTeeqqW+nKU6MFf6CUZFISpnjkyvMzMobRvf8PJ7BSRBT3RJ+E?=
 =?iso-8859-2?Q?0ypARw1pkoLWvCQKyJh0+gNFby6jkyDiSYda00kZMb3g7yNF8QuLUsREN7?=
 =?iso-8859-2?Q?S2q/Dqg24LBC1/qp0WE/RVD2YCA8sC1z3aOBwJuAWYDI7q/FgSAP1mqJOG?=
 =?iso-8859-2?Q?TuSn2/mhraQ7T8xVAHqbdZ/9q3obnaxX0lCMlB98Ka1QCj8gwODJVhYgZ5?=
 =?iso-8859-2?Q?rFRGKHqROK8gm6DZZZTdPsM/HX8ZgbHUYb/l4Gr83sNFtYV6ZLM8ZqRXuE?=
 =?iso-8859-2?Q?bgqG4ppsxMvfVWlyFcbahO2olNQIqMgXlU4l3tkhZQQ41ZsQaCzu4tA3fs?=
 =?iso-8859-2?Q?bLQLp4kJx22q+9fnP9dPFxtVUpCzls7JUMLp/dt2SCAYtebGLCbBnTWjuJ?=
 =?iso-8859-2?Q?LA0C4/GAaL2YKvuZJqubXGUKM8VcpP2yxH4J17qbVzfjexosACCJMCsrue?=
 =?iso-8859-2?Q?eeC98+aHD6sWr9RfU8xEqgJ3Vog7ShQ9wCrNz+YH0QNjBuRDq08iCCPGdJ?=
 =?iso-8859-2?Q?ZC3N8aq2CJtttCSwEuhUpi1SKSBUsbPnc50WszvwyCaORGZMcCIEQoqwDb?=
 =?iso-8859-2?Q?xKyccT4RLR0rdYQ18GUCvd1f6t4H2PsVZ43VZgR5BdNnPFosKpx+hIJxHA?=
 =?iso-8859-2?Q?esBlQMdnKIWs/9q29e1LtHpYqCgJTTU/tdLell5Axv/BY+7oZGUzhQf/oi?=
 =?iso-8859-2?Q?7gwgawO6/4+gDYtH7eqosC0JaWUvNbS756R8/6NDCoqGrnEZ/Y9tpIOk7M?=
 =?iso-8859-2?Q?xGuhddGS+Vjhr+osTr/1cqEXWcDup0X8/3M66liFofUcLXOko5Jif9MbUs?=
 =?iso-8859-2?Q?NSX1heMhEF1KyBcaqDYZUBHlwh8MuxjzkndGQ9QVLNkQJwXmy4ctCQFKa2?=
 =?iso-8859-2?Q?H//Z6lRSNiCx98RAc58QkKZ3PkYU9zFwZ1d2dmrgETVELIP/xt/Yyw4Get?=
 =?iso-8859-2?Q?r0vAL2/JEHsC/36rjm7drUal9Je5L9UuQeOybaIsexM4q1q+ChJ7Giffi/?=
 =?iso-8859-2?Q?0hc2x79TWommTW3sTmYEN1B4NXdqOq51tnilplqsS+AjqqAvnd2Z8B9O6X?=
 =?iso-8859-2?Q?G2dlIuudF61wtMcC3vvR7QYJn4Xwdu5rxvUBCAOoJGiWUtCT5uVXva1s4k?=
 =?iso-8859-2?Q?umTrSmjSMsgMO/JPXCywGA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8409.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?KY7cqHj+SXQ+BN5ifHUnpaGQYFb5vJBwdfSe9mKw93idhzaDBGkbiciGFw?=
 =?iso-8859-2?Q?bg6PBVnrgMted8V7zGVzFSiSqxJKRRJN2zkX2qwx+xOzVziz1189AXfAnp?=
 =?iso-8859-2?Q?dxlgCmbwSsQ72rXxmhGzeBsJALV19U9RW5yOnNtYCaQfulyLPd5qJViVcC?=
 =?iso-8859-2?Q?mc0VFN0rYZgRe8yFG3f4NhFPRf6ceQpGutlq7W7GNE+UJ/+kXThenoPy63?=
 =?iso-8859-2?Q?7uW4F7jWDAn3/AjHjyLWUFPDZ9/L/FYJdErmyXSfPKPttRImOsPNSECh78?=
 =?iso-8859-2?Q?ClNLxdiD4/c2tp8FwYTOvlfC53ULhAZHV8mElzgfWoaDjaQKkKoQFdiP1d?=
 =?iso-8859-2?Q?h0+auTQRBOWr3dIPtxPdDJJcSb0cvclplDkW+Ntkp/BZ8A8BBiYOE8cPuF?=
 =?iso-8859-2?Q?7EoOfCwh1O+0a1Z51BWfitGlcTnlfo7I3+d6Pt5R9M0XU3K2nY6omrOP6o?=
 =?iso-8859-2?Q?UMT2utuaF43SoXBs55tlrbWMcgPB1iUZd2i+WxQJWSSxgGdAzI6zXtLcE7?=
 =?iso-8859-2?Q?d+6+GVFdzKnBf+ux0B1B/zL2GUlxG3t4daOSse+YZ7wHPNpulpgCDbCrPI?=
 =?iso-8859-2?Q?qAEWEQ4xXipF3WDBSieuznACpexiHq8+voaQUowdx0/IFrb5M2ZQ0TqckJ?=
 =?iso-8859-2?Q?oFiutfNGgJcu7GJTnmP4dMXWHUqOBVgbxCDPT/0fRfjOQ76uys6Sw6YmuM?=
 =?iso-8859-2?Q?EXE4YI2OHq1DrXOXgFGu0bFIxhn7TimAvcBjdbKKpSUuX5MfM5VcoSDuPM?=
 =?iso-8859-2?Q?f6awkaIZpwFr5Ol0xoYCUxiQoOuyr5dqoqOhyx6kI8eOgMWIbvEcM7gCmZ?=
 =?iso-8859-2?Q?9f4jrSV70qi/oUSv9vCpm9oxEvLyq4o3sNeupkF0DtbZbUtAIg+z1JMxhN?=
 =?iso-8859-2?Q?waxPo/RbQZJjJfU56VWK+Zi9X1Asa1F4jg8gZePTLQ+jTWqvKof1Tn0hOR?=
 =?iso-8859-2?Q?QaGz3LB4udzd3uAm9stjQAZ7Kvfn1NF8ka9LuYnREHb/x6Z4/Hr1oxe4ME?=
 =?iso-8859-2?Q?oV+VNSNveAS/WrKJaUHjZ+3YDTMiW3B7wlcxGX6cGxXtFUjkSHamH44+Fd?=
 =?iso-8859-2?Q?MNsjC26cx+G97oOGIOLLF/iCgIvzgh6fJu57LeWbZZzhvAKneLuwH7f8j/?=
 =?iso-8859-2?Q?CivNcatSoqh/1M+6RuCeAU2jagIouRsY1tazuIwf42cMHRvXfKEK9WXUyc?=
 =?iso-8859-2?Q?Axm0ER+TWRKMFnRPxnjtJUygmG9Bmac6kN3Wdc/jmA8I4/7FXgyLmVcF35?=
 =?iso-8859-2?Q?ogyvMJkcBLKPA6vwzgkH06wE80MG6o3dgvnk3G9PC8hVLkWjVifz2tolo4?=
 =?iso-8859-2?Q?fVrEf3dLX6Q9xiQ54oDHT7wUxtR1zKDWUYe/mhO/AWb/8jMxP9ZuvyUzT3?=
 =?iso-8859-2?Q?r71VTd+krVWiW6tFfCd6kgTOS7JKpC62v/cKGgzBrvggZHFvcHaMSE0r+5?=
 =?iso-8859-2?Q?Mo+AYn4ios+XEv5gAmtZPN05vsEbZLiBu/EPutX2cclb2EskMVpOEgt0LW?=
 =?iso-8859-2?Q?GxmgP3bjDTPSF1QeTPA/UkZzJo1nb/YWzQokO/hCIxfR5GUbinT0V5Str1?=
 =?iso-8859-2?Q?yJDIhZY1GW8kAlRdFQ3wpdvoAhUh4p3Too36YtYKZ+9ubIkA69ft1AxTnI?=
 =?iso-8859-2?Q?eo7/dC7qcBgZ+XVqwdxODlkh7elXAFGnjn?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964feb3b-809b-434a-ba1c-08dd772e69ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 06:18:58.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pJdaVkSuWUL5QP8GpTdZfJK7gAazDXGpQDv99FtEynYj7UQ4wCX1oasyGoKZHgPT2fpS04wGzfQZwRrb9h7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787
X-Mailman-Approved-At: Wed, 09 Apr 2025 14:41:40 +0200
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

Hi Pawel

> -----Original Message-----
> From: Pawe=B3 Kochanowski <pkochanowski@sii.pl>
> Sent: Tuesday, April 8, 2025 4:30 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>; u-boot@lists.denx.de
> Cc: Priyanka Jain <priyanka.jain@nxp.com>; Gabriel Nesteruk
> <gnesteruk@sii.pl>; Pankaj Gupta <pankaj.gupta@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>
> Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths g=
reater
> than 16 bytes
>=20
> [You don't often get email from pkochanowski@sii.pl. Learn why this is im=
portant
> at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Caution: This is an external email. Please take care when clicking links =
or opening
> attachments. When in doubt, report the message using the 'Report this ema=
il'
> button
>=20
>=20
> Hi Gaurav,
>=20
> What we see is that the jr_enqueue() called by run_descriptor_jr() swaps =
the
> endianness of the descriptor in place (by modifying the data pointed by
> desc_add):
>=20
>         /* The descriptor must be submitted to SEC block as per endiannes=
s
>          * of the SEC Block.
>          * So, if the endianness of Core and SEC block is different, each=
 word
>          * of the descriptor will be byte-swapped.
>          */
>         for (i =3D 0; i < length; i++) {
>                 desc_word =3D desc_addr[i];
>                 sec_out32((uint32_t *)&desc_addr[i], desc_word);
>         }
>=20
> So the sequence looks like this:
> 1. caam_rng_probe sets correct descriptor in ` caam_rng_priv *priv` 2.
> caam_rng_read is called with 32B 3. caam_rng_read_one->run_descriptor_jr(=
) is
> called to generate 16B with `priv->desc` containing valid descriptor 4. T=
he
> descriptor is swapped in jr_enqueue() before passing it to job ring

I see you are right. In Linux, caam endianness is handled at the time of cr=
eating the descriptor.
But In Uboot, caam endianness is not handled at the time of descriptor crea=
tion.

5. The loop in
> caam_rng_read is called second time, this time the `priv->desc` contain s=
wapped
> data.
>=20
> Interesting thing is that the job still succeeds and that some data are p=
resent in
> the buffers, but maybe swapped descriptor can also be a valid one?
I agree that the descriptor should be reinitialized for each RNG job.
I am also not sure how the swapped descriptor worked second time.

> The effect that we see is that when leaving the command executing this se=
quence
> we get an exception in "unrelated" place..
After your change you stop seeing this exception? Are you sure it is relate=
d to rng descriptor?

>=20
> This is what we see when printing descriptor in the caam_rng_read_one on
> LS1046A:
>=20
> First iteration:
> 0: B0800005
> 1: 82500002
> 2: 60340010
> 3: 0
> 4: FBC94DC0
4th word is seqoutptr: sgf pre ext (ews). Have you also modified the descri=
ptor ?

Regards
Gaurav
>=20
> Second iteration:
> 0: 050080B0
> 1: 02005082
> 2: 10003460
> 3: 0
> 4: C04DC9FB
>=20
> BR,
> Pawel.
>=20
> > From: Gaurav Jain <gaurav.jain@nxp.com>
> > Sent: Tuesday, April 8, 2025 12:09 PM
> >
> > Can you explain more details about this issue. Where it is being
> > modified in
> > run_descriptor_jr() ?
> > Regards
> > Gaurav
> >
> > > -----Original Message-----
> > > From: Pawel Kochanowski <pkochanowski@sii.pl>
> > > Sent: Monday, April 7, 2025 6:17 PM
> > > To: u-boot@lists.denx.de
> > > Cc: Priyanka Jain <priyanka.jain@nxp.com>; Gaurav Jain
> > > <gaurav.jain@nxp.com>; Gabriel Nesteruk <gnesteruk@sii.pl>; Pawe=B3
> > > Kochanowski <pkochanowski@sii.pl>
> > > Subject: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
> > > greater than 16 bytes
> > >
> > > [You don't often get email from pkochanowski@sii.pl. Learn why this
> > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the
> > 'Report this email'
> > > button
> > >
> > >
> > > From: Gabriel Nesteruk <gnesteruk@sii.pl>
> > >
> > > Reinitialize the descriptor for each RNG job, as it may be modified
> > > by run_descriptor_jr().
> > > Failing to do so can result in memory corruption when
> > > dm_rng_read() is called a second time on NXP devices with
> > > CONFIG_SYS_FSL_SEC_BE enabled.
> > >
> > > Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> > > Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> > > ---
> > >  drivers/crypto/fsl/rng.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c
> > > index
> > > 06364948052..440b26e3c94 100644
> > > --- a/drivers/crypto/fsl/rng.c
> > > +++ b/drivers/crypto/fsl/rng.c
> > > @@ -27,8 +27,14 @@ struct caam_rng_priv {  static int
> > > caam_rng_read_one(struct caam_rng_priv *priv)  {
> > >         int size =3D ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE,
> > > ARCH_DMA_MINALIGN);
> > > +       ulong rng_desc_size =3D ALIGN(CAAM_RNG_DESC_LEN,
> > > + ARCH_DMA_MINALIGN);
> > >         int ret;
> > >
> > > +       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> > > +               CAAM_RNG_MAX_FIFO_STORE_SIZE);
> > > +       flush_dcache_range((unsigned long)priv->desc,
> > > +         (unsigned long)priv->desc + rng_desc_size);
> > > +
> > >         ret =3D run_descriptor_jr(priv->desc);
> > >         if (ret < 0)
> > >                 return -EIO;
> > > @@ -63,14 +69,6 @@ static int caam_rng_read(struct udevice *dev,
> > > void *data, size_t len)
> > >
> > >  static int caam_rng_probe(struct udevice *dev)  {
> > > -       struct caam_rng_priv *priv =3D dev_get_priv(dev);
> > > -       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);
> > > -
> > > -       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> > > -                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
> > > -       flush_dcache_range((unsigned long)priv->desc,
> > > -                          (unsigned long)priv->desc + size);
> > > -
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.43.0

