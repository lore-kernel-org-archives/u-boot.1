Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BCAC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 04:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E7F83390;
	Wed,  9 Jul 2025 06:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="Xi+RE/ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F52283390; Wed,  9 Jul 2025 03:18:53 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D628331F
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 03:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=anthony.pighin@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fr13vetXhrYdkYvtSxs9UNnDT53Qlv/pv8Q0PDf4KNURDVzDxFMe20ZiAK5gzncrUrRqyWhKlE0q4hZDNAEnUFTVJaIhGg8M2KIJFjjN/6ffiSxo/12vaAN9WSw2nGmGKRjUmLo3CP5w4FKJqCwbmYVAdSDgYbibhZXja7187ewm9Tco7NpHBgj+9fr/zliddZM2rGKTfDkO3teS9KvMvnIaAC5oiHQeIOh5VvKsifcL575j/gvnvgYsECLj/0hgNon4R+LiAz8+DOtktKEigVnpPfBJ/loCZFrYDu02kAyYv4gZq0bM+sDj71A0dWC3HK/Cy1Mx+sLXPUTLp+PUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IcKYZbAoQLf28LIwB8qBdS+LlR9XpnuR/gamK8Vmf8=;
 b=AjoU1NKcOhZyeJYsQmin5pjIPZ86ttp/JkXdvCmANyLMelvHjwr5tv9+dIXthmVlTt89pWTIbP4E1NHVTCf/HdBCFIhN6OygmAVtpj4vjL/4V+1SaqiLLIjVaL78XqsCqTMeg6Zg2V+OpJRJPQsrpb/pfwXTIKU1MbRuZW4SdxGAMUtikNNL5cCM5gmOes2lrSfzO37Th4upg+5d7nTJy+65mHxNKXulDv+qMcd4g5fNKkqiQJh+bJDJWiRHVtP9BHkzBgh5yKgCLO1zpdpVWrARtVj08BXsjlAyLKYzVp0EO3GSDGoTH9usjoCrZGkSjvBT/6Prge80VMn+zXdzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IcKYZbAoQLf28LIwB8qBdS+LlR9XpnuR/gamK8Vmf8=;
 b=Xi+RE/ftFEEgd0Am9VKFXBL5btohvpqBXw8Keid3gdX6JX3dba9G6mFqW/23B+Ok+UdFEfFCQEV/U5wpMXyfVRl/FBM8grVEUfhiOM5sE+cepzf5KDNLaVBxnAPIkzlFJ274Pe4UQVSaOznIAbN85yBIas418y6H36mXxDvNv8FKibw/A8v32fh7AZQoULJQOi62KXni8wnSNUE9xcs/UY1NAljdmlwbUhX23pPQ8RhvLlTUd0lK930nrz7PpOikxCbqaspfCp2Ut+PidBP/pvE0B8eR+hFiZOhFcFx+rv8Zb2xbQ4sgalK9CleTvYQO4svrzvDSTHD5W+/L1D03BA==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by SJ0PR08MB8362.namprd08.prod.outlook.com (2603:10b6:a03:4eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 01:18:47 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:18:46 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "gaurav.jain@nxp.com"
 <gaurav.jain@nxp.com>
Subject: u-boot corruption from EFI CAAM RNG request
Thread-Topic: u-boot corruption from EFI CAAM RNG request
Thread-Index: AdvwbwjgPSuIydQbTdSM+RLk38cMCA==
Date: Wed, 9 Jul 2025 01:18:46 +0000
Message-ID: <BN0PR08MB6951B4921AD52EDFA06E885D8349A@BN0PR08MB6951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|SJ0PR08MB8362:EE_
x-ms-office365-filtering-correlation-id: cbbb85c1-d448-492d-b157-08ddbe868d96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kIQistgpMOQlfUD/k1PTc7V9hiziUG5JC7CqsDbSYva0GpCwYvKvvD4/AhWV?=
 =?us-ascii?Q?WDeMJiarx3jQvOzKTtNEGc8o0f73ymucnXbDVNa5clXU0ZH75VfWd1nv4/2q?=
 =?us-ascii?Q?1BMm8qkFuCdZIpQV7XhBodJ+AZILndK3BumslZ+nFOJ31XEQ/oWIdC/I8y/g?=
 =?us-ascii?Q?gZR3qBBr2dMh2CMXVakJXGUIaPKAxP9WZJe8u6neyZIns3yZyp3Eg1OGXbsx?=
 =?us-ascii?Q?/cEgrxLUdxYUQTNj0eIc41JHPZtT+xMW3+foGlI5Yx0XpFrT+e9ohinNKCB/?=
 =?us-ascii?Q?fDYTloSLAnV9ThyUJE81AGYS+ZbcRB2mm2yXINOO8h+dXtfrWsjXkV3dXpA1?=
 =?us-ascii?Q?7SbW/olGOisqpTL4FNit65VAK1sFn+bbFOWB2yYxLSwJDZdITPF6ZVl1WOGD?=
 =?us-ascii?Q?ao1IJMDL8p63ohqYzCd+cvonT7QH0f2pwY/Be/alqlvhNTMMD4zpw4UF2VVx?=
 =?us-ascii?Q?4jFAvXXwYXurLDIWzRypwH3aTT+9UFDmUk8FbZVd8G+hqoo8E9kbpyraW+Av?=
 =?us-ascii?Q?3kobRoQgN8iwwJzVItx29UlgxXzq5fSlgRRnt2kFwEazv301C3LtO2s3X1Jo?=
 =?us-ascii?Q?s4YPwOPi/dt3dFFkOPHhBGzFUlj7QObPuwdCcu2OSm6/3rRkTj+e5n7UHuqM?=
 =?us-ascii?Q?KPBd2G8lUrTL4gSneFBdwbq3w4dxmHWediG4IClxEIMDaX0cDsiUWBdHr+p7?=
 =?us-ascii?Q?pbz3dOVVzkhRSK+EFPUfUO9khl7gju5fYuOk4Fk9P7jynaUCtqWqQXeNVWQN?=
 =?us-ascii?Q?81vX2FfPPb6cDGrg4KmYRhnMBaeoIrf9DIqY2em47ticlAOsM1qG0kzG2xG3?=
 =?us-ascii?Q?BN/ntVt82/FUjyk1kBwcqo3Edh/3kC4Vtzf8d8nK/rCqOx12iB6vL2a5quP/?=
 =?us-ascii?Q?7s7V55thCVoGoTV+OVt6L72IPrS/lvEZ+2eQX+CAyyG+NRgPgzvqxOG7Gf3Z?=
 =?us-ascii?Q?aDqI4FXBhSqDapFoTW8KwVP50ZI3bESbMcsZOrBSVY3GBGElaj0wF2GPmm+3?=
 =?us-ascii?Q?K+pUkj5XmxHIPYLU8ASS8nFeTs2hVSqRd/IFZP4a0Jbxn20k99c2CVqK1dtB?=
 =?us-ascii?Q?Ub8ow3BZEv2adPF2DkCTKEJQIK4tbx0IDatFNawOBpabEpRCfM5hUqxJrAdS?=
 =?us-ascii?Q?/+8Q8KzCvwQpH5hNIAjyCvZBy5YWl6jGtu25ZHrktwZPuXyxd9Li7QabO+Ie?=
 =?us-ascii?Q?nDz68U0vNsQoKEHdGrc7gwb9CqKItP0vIrVyS/NU+Y3BbCmGgA3HCjRvorq9?=
 =?us-ascii?Q?/bF71Qnack6cTMtpgxOi0+Ti1ky+eOnTLWkqjctofK7yGxpd8xYfiE9CYPyp?=
 =?us-ascii?Q?fl4ZhqSo6Rl/5h1m7UnoSuiJ6Y49SY5MHFO8arK5zkxxFnhksb5+nvMjE9OS?=
 =?us-ascii?Q?pjyehFmSFcNRorOC5Hp0ekWnyIW1k1nfiaPCrGDPEWASPeeZmSq8UeSx3ZXm?=
 =?us-ascii?Q?dK99b/5//RNGkCxzjqd2DS2Ch/36qk6wQl+ZS/x/duaDg+jfbAP8lw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AKnTc+IdR6I8PkWobZak2+xujpCjyM9T7t37IjKKFB4/Gc3dDV+qH7nQpdnr?=
 =?us-ascii?Q?q9414goZpIN0oqTf5b/DELKCrWoGLHfEAogYuCfDoyFi1/tUC4lBpmyHTR7s?=
 =?us-ascii?Q?1FKSZT67l5jR2jwgUb+vpKkA+m8V1To+PO7WvDacPasGAPYAipIINGnVdLt2?=
 =?us-ascii?Q?S5GOlFJEtOKdpyAY23tJyOnB5/jaWE6WvVqaAhj0xp4YU8bd+WKKQYKGKWsh?=
 =?us-ascii?Q?/0/jNk4+flIs8N9M1rokEEG5hB9tZ+zonkpiJRqzurZ7W43OzVVlT8QZ2LLK?=
 =?us-ascii?Q?lu9D2zuogZoY8xqvwS6zXawfeeHINdiXTAHHV2q+jxROx2ZY53PnrHxNQXPx?=
 =?us-ascii?Q?mnRdP0oTVZ3eztNK8QbL4hNHGPc1M4R7ogFkHldHjgI82lPYHW0qoQ7AaiYa?=
 =?us-ascii?Q?wuz0NrMnqpkXG+ysDrxdQKdhlbO12bCH0oX5/IY2Et4uTgNUvkODJua1OWx3?=
 =?us-ascii?Q?LPW7Smkqq/noKPWnuumLIceDlj2rJ+f6GPnUcmJvpxMWHAem8qQktqS57vhI?=
 =?us-ascii?Q?QQ1dDBWiTdXYcB42a/Wv/cnoC75n1NBvAsx9fARQUm1MiO2GYNeMsRgzJqcR?=
 =?us-ascii?Q?wIoaNqBpY2ihNgrU0yE7sllZfvl3EQWGfWrwARJTSqnvhmC38lXgPVaYyEFV?=
 =?us-ascii?Q?LVtjUsjGEjoZw6MZhGm3J7AfiwIf5UQe6YQqaZ0mnnJeoPqPI6KAtQ1aG+TF?=
 =?us-ascii?Q?3BoMioesdY8v33TuvYGWPjqxyqXO2wJQd0Dupn4SL4aDgv5Jhz4jEZPw+iFE?=
 =?us-ascii?Q?7vfa3cLoHZdbye6Nuc6++cTWTnDQ/CFhPXdOjtbKTZ2fh5JBqaMQULgOBIGo?=
 =?us-ascii?Q?bN7ezCFbQVvX/7rALbB0g+5fCp59rhAs5qesSK3Y3Ws/k61YLxouOTr+tDLn?=
 =?us-ascii?Q?gTSw6fMB4GRoJ1gYikyB9tr+Zyd8IPMVlwUHBXBdSnbuSGhm5ZxRCaVmQWyk?=
 =?us-ascii?Q?gwffecSAoYCOzyTOh1jJWvgXCza6V1Lw54uGjsDlX4vEx5dX0EMh/q3BG/Sd?=
 =?us-ascii?Q?A/fBmw/tgGKoNLxoxo7rYpbD+wUkdXba5fIcm41V27dnIRAWPiz+ZRmeG9es?=
 =?us-ascii?Q?Rqwr9SpX/0B2K4eIsZ1QiJriMN3SVXSOx53BoOV5RV0Wlc74xXPnr7bf0nX3?=
 =?us-ascii?Q?Uabx/Z5kOmz7wvMTH5b0ak1ILm7GIsgK88mTck8I46zV5OkkO2OhOKDIjdXc?=
 =?us-ascii?Q?2X69SaoDoWUilqVeFydX9bI5TQQCjshMkn32JgBzBJN2lXHTw3Gk1eiALuXg?=
 =?us-ascii?Q?OtQsv119DrRPVrfyOQ2iB4/0wM7C1YNpe6avpQnHjjkBbylbiv/YEwkXTzQ+?=
 =?us-ascii?Q?4sescNeIxIOeu8IQs1VHaefqUl9FCiear3erJ91gUljr7Yz79pMN/4SX7+Lv?=
 =?us-ascii?Q?Dmrl3fZF2jlOztwEU5EVpZ7inqYVprSHsqG/Q7F2wlPErEVk8pSex1BfC/dj?=
 =?us-ascii?Q?wQw0e3BxR1ERlpVAGb3XEV0m40p8U5/vtiOR3+u+fk8PHcQKI7+K+xAHDp3S?=
 =?us-ascii?Q?HFkzei3HE/s5OqpwxCEEk3fSOpJIWcj2L5wbZaNQgRONTGILMeG0njwUcKRE?=
 =?us-ascii?Q?3ON/t+p7WEehac6NhTGiL2A/fLgK0232W2EHqn9D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbb85c1-d448-492d-b157-08ddbe868d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 01:18:46.6540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nclYseExla1/BKiqroRCMf/eN6lbxJvW2YccM4cvg/lKaSk+RZ5rZaky/L1hum8e0JrmTpAYei1tRzcc/zKcmcuCa5kD4RPGbTCEcq8f+Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8362
X-Mailman-Approved-At: Wed, 09 Jul 2025 06:38:57 +0200
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

u-boot is being corrupted following a Linux EFI callback to get_rng(). One =
of the many
footprints is a corruption of the EFI protocols linked list.

Turns out that a request for >16 bytes of random data is broken into smalle=
r requests.
Those requests are fed in a loop to the CAAM RNG, which uses a job queue ri=
ng for interaction.

The problem is that in u-boot, the job queue descriptor is created only at =
probe time, but
then u-boot needs to endian swap the descriptor fed to the CAAM RNG. So thi=
s corrupts the
descriptor for the next iteration, since it will be blindly endian swapped =
yet again.

Two issues arise. The number of words to endian swap is taken from the inpu=
t descriptor itself.
So on the second iteration, the length has been corrupted. This results in =
a corruption past the
end of the descriptor: whatever is after in memory is corrupted. Second, so=
me of the entries in
the descriptors are DMA addresses. So if the descriptor is still valid afte=
r swapping, the data at
the corrupted DMA address is now corrupted.

Linux properly initializes the descriptor for each iterations.

Example:
Iteration 1:
desc[0]: 0xB0800005
desc[1]: 0x82500002
desc[2]: 0x60340010
desc[3]: 0x00000000
desc[4]: 0xFBC17380
jr_enqueue: Start swap.
0xb0800005 -> 0x050080b0
0x82500002 -> 0x02005082
0x60340010 -> 0x10003460
0x00000000 -> 0x00000000
0xfbc17380 -> 0x8073c1fb

Iteration 2:
desc[0]: 0x050080B0
desc[1]: 0x02005082
desc[2]: 0x10003460
desc[3]: 0x00000000
desc[4]: 0x8073C1FB
jr_enqueue: Start swap.
0x050080b0 -> 0xb0800005
0x02005082 -> 0x82500002
0x10003460 -> 0x60340010
0x00000000 -> 0x00000000
0x8073c1fb -> 0xfbc17380
0x00000000 -> 0x00000000
0x00000000 -> 0x00000000
0x00000000 -> 0x00000000
0x00000000 -> 0x00000000
0x00000000 -> 0x00000000
0x00000000 -> 0x00000000
0x00000000 -> 0x00000000
...

Anthony


