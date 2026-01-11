Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C16FD2502F
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 15:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE0183AAE;
	Sun, 11 Jan 2026 16:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tandemg.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tandemg.com header.i=@tandemg.com header.b="vJMvTmeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352BC83B05; Sun, 11 Jan 2026 09:21:18 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0085383A9F
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 09:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=tandemg.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yanir.levin@tandemg.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGFAlWMmsDvIj2BdWqLy3mK63r+NmmL6m4t0+YYku4hi+eCP7+V1cCedi/t1gr39O+5fDKhEGI2f8xEuCNptm0NmQmspV++uJhFlyrZvnN9Qn7ufkzPHTbGRLNpiaKL2oaR6j0Yvz2hCwZw8X74zqDD9bYVIjP84FZzrEOv/8bGhOByyYiy9jraHsPtay6q+TgbLX6M+cem57KFipL55el7X3YHWsyQvKueOvh4plNSbJuFxaCuuVKeYEOICdZv4EWCB6P8LbrCpUFnqPS23noSkXdH5SxEasv5ZLlhlrI6kL6y2qM5UyrrdX7LJhvu5esOtW9vdCq4wG7ccle/TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY1bdD6mLdIYbhH8EZJDzR6P5VMJ8BuBmTZQqLWGRNY=;
 b=dd2citAfpk8V9kTVjyJDSTuvxPwGFWzGeyegPWkYuLViNGG5R1rBIlwZOlWY0w+xalE36KIiUE3DJpER6a7hCvYMdEN42Z9bfuZlrlpldF/N13KebzhJz5u858f1AAAnDsRBc9iJ2LFUbcfHZvsicYm/dAOCRO0ZUj0++TM7HaDBnC9gLBiqJm1nBpzOjTZsMJPf310/B/ZJzDvbvNkg9PwNY8dL7BGJfwMhmpCiScZUIAlAS3toKqiZrjjBbVKTN0CEx8gcRxGdoi2FB5Vgcs17aA1ekTsJkVGrlwJwYfi+uxZ2lpyW7atu6L5BvB5JaQyUsU7LfikIScOhRT7D3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY1bdD6mLdIYbhH8EZJDzR6P5VMJ8BuBmTZQqLWGRNY=;
 b=vJMvTmeE3CHOsbdRoLiJ+oMG7OQALkmE/OnDmSDs903VLASwlV1P1SXQ+z5+j29vqRJopKTESGRKVIcg3/bybBwb6k/FeozhJQQdP01S+AUbzH1TXhhSoiUjsAv8ia6Go/v4t80p5s7LrEIBJ6J/oFWUEFYj1BzmwPito6PSVCOzlsFLaacnGYxThY+ERxCMJTrjxqWaipKdz+TG41YlKDKOUpluQb8ArHWpcUuQ4HnIf+EhiR88sk89rTEQG4Qh3qz8LrkEg3LNQ9vWvW4KIgsPadofsrmIYN0dBeC1d3H6Z+R7S3qhwMW3hwRDoKgCzMbvJXVqXWNwgJjutCBWxA==
Received: from FR8PR06MB10550.eurprd06.prod.outlook.com (2603:10a6:d10:1b7::5)
 by AM9PR06MB8099.eurprd06.prod.outlook.com (2603:10a6:20b:3a8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 08:21:13 +0000
Received: from FR8PR06MB10550.eurprd06.prod.outlook.com
 ([fe80::e2b9:dc4e:b8b6:864c]) by FR8PR06MB10550.eurprd06.prod.outlook.com
 ([fe80::e2b9:dc4e:b8b6:864c%6]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 08:21:13 +0000
From: Yanir Levin <yanir.levin@tandemg.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, Eran Moshe <emoshe@gsitechnology.com>
Subject: [PATCH] mmc: Fix retry logic in sd_get_capabilities
Thread-Topic: [PATCH] mmc: Fix retry logic in sd_get_capabilities
Thread-Index: AQHcgtFZGJeSqEeDI0y6txNE6OKhAw==
Date: Sun, 11 Jan 2026 08:21:13 +0000
Message-ID: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tandemg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR8PR06MB10550:EE_|AM9PR06MB8099:EE_
x-ms-office365-filtering-correlation-id: 04a61eef-6453-4c76-eae2-08de50ea627d
x-ld-processed: cd9e0716-88a7-42c4-a82b-7a64f204926d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fzmzT1c7Hg9esgkLMnzLuRMRENmx4xHgDEA0va+2Y+NmN2qeeH/APNYrf2?=
 =?iso-8859-1?Q?tf/O/bhmU3pMI3n0ooFpV2TFMNhlITw2NlpXWSepxnCHLKIxI4qiE4RWx0?=
 =?iso-8859-1?Q?xcz9ea1jLmLdV7+RsxlodeTfInXXB5ocB0DPvyI5NKT+4FZjeZS00NM2gp?=
 =?iso-8859-1?Q?TrfT2qtOwo6lyfeXIYTqeK7Y6H97CNX6QGDIvDG2WWEEyO6qwektLxChYq?=
 =?iso-8859-1?Q?3ab0DDVDRXwb10DN0tZf6NUg+5wIXDZc/NqC2lj5J1ppH8OzZwJUsjl4II?=
 =?iso-8859-1?Q?CQypjh4sYASNX4s5jEbOUhBDmB8bJPn0lZhc1OWJZlCQcYe5h+tWdV+82o?=
 =?iso-8859-1?Q?AZavD1SyF1BTzVe2/hillziSrZ88cFtTatEEY8+2lsIJC1eMu55xIto+wh?=
 =?iso-8859-1?Q?lMKehokwqMFQRLd3b3bBvWg4LmCSlXTXQ8k7/GWR8FEx4lU6KtVgSkrk56?=
 =?iso-8859-1?Q?ptG8mTIJOLJDoo6m5Jq5ymPvLaOM02IQ6KXk4bzWR0It7xhg8wDKmzQ9I1?=
 =?iso-8859-1?Q?5IrWSQ/r0W/U6djTtHRh0SkXkWx203mamumrRyfoQAS6dGmlTeN7gdcnoT?=
 =?iso-8859-1?Q?HTSM0xaPgNRUsgpISjKVS55Fy6u1fcFEzVbbSTldgY/JbHLgF01UlgYO7v?=
 =?iso-8859-1?Q?be6Wna6rUbFc2hbBhoNwhX4X1f+hOyoTMfynL/v14ZuWkJSwyLKAUb4alB?=
 =?iso-8859-1?Q?a7UsITIpZgl8pOkFR01RiwM3Ps5kL75Pw7VX52UQG4d1UFb5RQVY7X/ihM?=
 =?iso-8859-1?Q?eUEeIGBiVnleJ2toptzCaCKzEyqH1HstVWziFq/DXCyjrcsi+WPFlZEeqG?=
 =?iso-8859-1?Q?rvDQ09LnsDaXeIpnsg8uBJgrmAOM2GcgiuRNk7gTeKQKsLaub0VzLyczO0?=
 =?iso-8859-1?Q?PNDancMSxvmO4wbVYfkh+nO+rpLsBGgZA3uC7Cf/VC8gf6VBEWUFjJkuJo?=
 =?iso-8859-1?Q?TkcLO3w+JNRIN2iSL7ZTNBoe4kRXYoDPbogCFZ8QRLL+o0mcmjEwEzl50H?=
 =?iso-8859-1?Q?07onUgUZkaUtyMqbKyubWh/8HqWZ1uCK5JLXM8Vq+q7Zn43fL/0HAApssW?=
 =?iso-8859-1?Q?RkZXLR0Jdm3jdY83qo5HzRFQeNYAU3rJm9Ha7zIKQ3+JALiX3Ibu3VFMEi?=
 =?iso-8859-1?Q?v9AvIl8R8D3IPZzHA6HecAzucLK9TCNPLJYxhpm5qetDKTQuofDHAzpKA9?=
 =?iso-8859-1?Q?i074ckI+kTnPi6wzVh+GzJqZdBDkvQ+byrexRcg8IT5oN5WnHPwWGhcQPC?=
 =?iso-8859-1?Q?vA33eBzxGrrY50YuZR0Pwgbj7CQ5Y38wA1ZAtVrc4BHM6xVShxWJ2sJx+E?=
 =?iso-8859-1?Q?nb4CYD45kfuy0kB+8IXW1JKv9QRE+monMMvnwA7TOZrYuCzwsKxkN8OFLS?=
 =?iso-8859-1?Q?SahjECxRa4dBOimo82uGuy2QSJWJ1GJXEmOvu70zZ9NGwkKpcE3RCGjJhI?=
 =?iso-8859-1?Q?HUiz/Hq+uUkbgecdCCUg8u+cd4K3TlRJye5AN/VI0vkG6gT9DTtMsTbPIb?=
 =?iso-8859-1?Q?RRIWTiquKm4zYRWsISO3HErqR1wpcQFJeZ6flCUtKyoHtcH8VLlY8zyCJO?=
 =?iso-8859-1?Q?VAxtbiyBTHEx/2efMmWpJG8Hvx6E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR8PR06MB10550.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p4MypVxarMbIP6u819xaCG9wOgtnYzsJv0e95SRKYlUbjlQyLEU2VhW5jh?=
 =?iso-8859-1?Q?gkYADQzRUZl9kl8FeHC8ZlCaCxsB4GCdU48cMZa3y8iCZCm9QyZlT+KrKE?=
 =?iso-8859-1?Q?nSOaXN/n42SfsHSqIxGjgd8pSopEFdOoIjuBHGmED8TMuwzdDpL+zNj2p4?=
 =?iso-8859-1?Q?G10Zyb4uJErOp/jgXElIvHcNXBJwX10/CfOLdGEWgbF6Fu1IkhU2mL1q9v?=
 =?iso-8859-1?Q?N/o/MMY/Jl0PfINKodCpuFf0n7E5A3llUYAcMfiYXSd6XUHAJdj+4q1hTW?=
 =?iso-8859-1?Q?8VjEiAiu4EKMOkQ3qeSCwBaShkmcvyh+VlCLHzGEdiy81TA+qWlp+rTpUm?=
 =?iso-8859-1?Q?vNnTfqx++8uvAD5+W82sfXf9au9wsiz7+dgMYDYVKEl/vFw4SVnJf/eCWz?=
 =?iso-8859-1?Q?QbRDOrP4NYCszrCUaFuDMMekR+58t2d7mEENUU60B5YYvZIYF+y+rqqXPz?=
 =?iso-8859-1?Q?5jEBtxeInH/X91VN0PKs9vNu0rx74RLUCNKz4QCCyCUUPmHKN/v4xl86xz?=
 =?iso-8859-1?Q?kpnKSPCHEGDwHJ2Stm+osZOiEjUFHPdrhzJinkMZnd0ctZfxXzJ3ncKdGq?=
 =?iso-8859-1?Q?ht9PWXuB5/uay5cvBTVbFdXfJp8tJlTbkCctpATthTEL6jrCnPF4rSzVNd?=
 =?iso-8859-1?Q?nLxF/bLbm8k/S6YpW38GoLnNyU/fl3dNLDCJz9nKqrXzX6XZpQIEo7EiMt?=
 =?iso-8859-1?Q?4LGdHfDIz67wU2oPdAtQ3XUd07Ifgwq2Ho01PTOHRpGTZFsQc7+iPO3F7r?=
 =?iso-8859-1?Q?On123h5J2jb0GPFRuNnGICNiIXOQB1phWgfz+OH9yzHDfcLJV+HT1b4CyW?=
 =?iso-8859-1?Q?gBeyp2VT+MhAwTD4g8DxcnaMMxN3d3Q+axO1bhJKnf9RbVUfjLOtdK+x3N?=
 =?iso-8859-1?Q?yTsM0asnmh9vZeOTT2h/idEruAjOyk1zYtKYEbtZNMDa639YD96fl+rws1?=
 =?iso-8859-1?Q?3GLXrRE41bjTKoKTgxS4arWUGPtfiYq4Yj9oF6bPTy9rwIpK6pa7yJ6hbY?=
 =?iso-8859-1?Q?GcV0dHb21TNwVZWpEhTJNuhDUPuG4cICDEbzg2W/79fg02rhY1XWj3DCzk?=
 =?iso-8859-1?Q?jWajizvzUk6COx17WgOhR8j5fd1Obq/hX4nnRzDmhhnK3dA6wTm9KNU21D?=
 =?iso-8859-1?Q?Ntv36rTsUBoxnd+XseSMtB4JFi1zzHL+sukpBgRoNtk+N9PuYYmJWa3xAg?=
 =?iso-8859-1?Q?3szZzWESCCQoTtnbrnQI84vEgBJ+GlJVSkPwqaCv3vaoGFfP/e9aOiRE+m?=
 =?iso-8859-1?Q?LzjUMXtqEB6DNW6LB3b5v2b9IMVTr3aZ+Ns3eLWwkOXpD4vSGurnhx8Hap?=
 =?iso-8859-1?Q?XRKOM4NtVX9isLe2O7gmlPUuZ20K/ThfvegR60GKQszg8CFIAQlK6+N/IN?=
 =?iso-8859-1?Q?xHSVFML3/t81nwyoQSMMEQZN4kxWpGHZqBWTuleFeHdu58TeA1XAKOZwCG?=
 =?iso-8859-1?Q?NpLCUmVCVcY9N9DL4BskUpogcYM6BZwgnpkm+kuPPMtxNRZrLtmlDaOg5U?=
 =?iso-8859-1?Q?wv17iSLeW15RvCVgwWmpSh70TNPGVV2VcCXKbjq6+CQZwklwOa7Oxn9CfB?=
 =?iso-8859-1?Q?/0ygJnwqsUySDFl4xKvTqo4C4NLMbY1zA3z5uFuSCAyA3VpR90cIrXOPs6?=
 =?iso-8859-1?Q?UaTZ0wXWQ8MEgaHiDgTSGWLdUT4+T9x25EJJAs5hFJs8XfiI52JLfA8aMU?=
 =?iso-8859-1?Q?QxCS6OwCllGzx/dF834u1aywGJ+n+qN8V11+aDvMbz9DOT7yP7FBA3+EXq?=
 =?iso-8859-1?Q?vbhEEgWUoAWtzkfCrjzMDlQzx6PasK046KcdecHL9kDzXPywWBfaZdC9Ux?=
 =?iso-8859-1?Q?vFHYrnFKow=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR8PR06MB10550.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a61eef-6453-4c76-eae2-08de50ea627d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 08:21:13.7953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cd9e0716-88a7-42c4-a82b-7a64f204926d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVzQsEiin5Vk5sbzn0S7FSeHFETJKBsLMBg+bQQMcD80ueUisOG6LiPl7Nd5MOw1VqIZxS/qG41qWBY7zEvd6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8099
X-Mailman-Approved-At: Sun, 11 Jan 2026 16:22:46 +0100
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

In sd_get_capabilities an ACMD is sent (SD_CMD_APP_SEND_SCR),
which requires sending APP_CMD (MMC_CMD_APP_CMD) before.

Currently, the ACMD is retried on error, however APP_CMD isn't.
In this case, when the ACMD fails and it is tried again,
the retry attempts will not be handled as ACMD, which is wrong.

The fix performs the retry attempts on the sequence of
APP_CMD and the ACMD together.

Signed-off-by: Yanir Levin <yanir.levin@tandemg.com>
Reviewed-by: Eran Moshe <emoshe@gsitechnology.com>
---
 drivers/mmc/mmc.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index bf82c515600..c1146ab3648 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1389,25 +1389,28 @@ static int sd_get_capabilities(struct mmc *mmc)
                return 0;

        /* Read the SCR to find out if this card supports higher speeds */
-       cmd.cmdidx =3D MMC_CMD_APP_CMD;
-       cmd.resp_type =3D MMC_RSP_R1;
-       cmd.cmdarg =3D mmc->rca << 16;
-
-       err =3D mmc_send_cmd(mmc, &cmd, NULL);
-
-       if (err)
-               return err;
-
-       cmd.cmdidx =3D SD_CMD_APP_SEND_SCR;
-       cmd.resp_type =3D MMC_RSP_R1;
-       cmd.cmdarg =3D 0;
-
-       data.dest =3D (char *)scr;
-       data.blocksize =3D 8;
-       data.blocks =3D 1;
-       data.flags =3D MMC_DATA_READ;
-
-       err =3D mmc_send_cmd_retry(mmc, &cmd, &data, 3);
+       uint retries =3D 3;
+       do {
+               cmd.cmdidx =3D MMC_CMD_APP_CMD;
+               cmd.resp_type =3D MMC_RSP_R1;
+               cmd.cmdarg =3D mmc->rca << 16;
+
+               err =3D mmc_send_cmd(mmc, &cmd, NULL);
+
+               if (err)
+                       continue;
+
+               cmd.cmdidx =3D SD_CMD_APP_SEND_SCR;
+               cmd.resp_type =3D MMC_RSP_R1;
+               cmd.cmdarg =3D 0;
+
+               data.dest =3D (char *)scr;
+               data.blocksize =3D 8;
+               data.blocks =3D 1;
+               data.flags =3D MMC_DATA_READ;
+
+               err =3D mmc_send_cmd(mmc, &cmd, &data);
+       } while (err && retries--);

        if (err)
                return err;
--
2.43.0

