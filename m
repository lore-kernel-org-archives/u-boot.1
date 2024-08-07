Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA68C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9340C88C15;
	Wed,  7 Aug 2024 15:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bt.com header.i=@bt.com header.b="VcHhlVJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD9B88A77; Wed,  7 Aug 2024 10:21:27 +0200 (CEST)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:261a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C07B8780E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 10:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eden.hamilton@bt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF8jsBtvgzcffTVIGSfwCqOlYDY14mZ9McpE+F5I1oNTgXWXPCu/0aLSs0N1+Ko4tthKIDU1zCOicSaBs46FE47fpx1RKI5B87yE9CAbOOGbLc195uLzcj+U41fRxjXjhkXoDdMil/K3Yzc+FJkQCh75zf2lGsLgaEGwJLW1+6hhz9UANIIll6kAfw6Fy6/oiekQWbxOgcjQnNVxN+LnKBnPd31iEath7Z7RoDUw+Xe2IK1754dV0PdLkLkYz/e9MCo0lLMitGHPpY21qqBvtr7QDlrOt4rwKiGQjQsM128rpcV9xritQohY6WVBXghC4iZBzkuzXorqqCluQPcOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YipQUZae6orPqA9LQ/V5EbF2ezuKY/N5Fs7gK60NecQ=;
 b=R61WsgLGJ/jBgBiPwz8FqToOWgWRs8GyWhRvwqxpK/s0EvMEUYzU+08TSwIQte1MkVfWmdwokYf1kf2ESZ1asXXFIiYMoRwN9qrF/uU29Q31Gu/zuwiBde3xEqkqnE8OP8ripvCrtgQE0ueOXi35uEDL61kU2E3QkbpQ5v+BK4PBHf+STCMLemCsb1MpWyRFY/jPUEZMCYPu2kI18bA0AGpdUYKpquDGrt5jTjCIiIiYO5IMzS/Tmm0qxXzwbiSZL7Gc5ShDp4ufba4xpKMXxY2GctQLI/Sqv81u+Czp2k/2Ro5g22RiR/RAFA6BrNgY9adVsKrG/EECHdyHGajqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YipQUZae6orPqA9LQ/V5EbF2ezuKY/N5Fs7gK60NecQ=;
 b=VcHhlVJSkRc6EtRpvcdQUMlHFPCbqTOPbd81mXcFJ9v11TPRWYwOmFzHyrWHl6+07GeruZX6FM8UGNOF4GkucR3iMvNIm3SkChRIEwFlUelomUFhHII0+6eynkK5m+MiAAsgGrOS7AICgSKyYhV8uMo47m4T3J+R0HwgomsoBtw=
Received: from LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:14f::6)
 by LO0P123MB6991.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:336::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 08:21:18 +0000
Received: from LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e504:ed2:39ee:a95d]) by LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e504:ed2:39ee:a95d%5]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 08:21:18 +0000
From: <eden.hamilton@bt.com>
To: <u-boot@lists.denx.de>
CC: <sjg@chromium.org>
Subject: Fw: ECDSA for FIT Files in U-Boot
Thread-Topic: ECDSA for FIT Files in U-Boot
Thread-Index: AQHa6ArVh6Up0olr7kOc/dTRhifFmbIaxG8AgACwTRY=
Date: Wed, 7 Aug 2024 08:21:18 +0000
Message-ID: <LO0P123MB3929FC2417E806A1B8F1867193B82@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
References: <LO0P123MB3929703FEE3D03E962D7E6E193BF2@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszTimGrXLOMOheanvJaJFZZd6QujZCf7fKmG7zcEKBV3nGg@mail.gmail.com>
In-Reply-To: <CAFLszTimGrXLOMOheanvJaJFZZd6QujZCf7fKmG7zcEKBV3nGg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Enabled=True;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SiteId=a7f35688-9c00-4d5e-ba41-29f146377ab0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SetDate=2024-08-07T08:21:09.592Z;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Name=General;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_ContentBits=0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P123MB3929:EE_|LO0P123MB6991:EE_
x-ms-office365-filtering-correlation-id: b4cd069e-f391-44cc-913f-08dcb6b9e9ab
x-antispam-2: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7093399012|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?z8f8f/R02SVvE7HGuNpjddDD0d8pwkE9QzzdL91ybYQ97X0e2fv8MJjv5Z?=
 =?iso-8859-1?Q?ndEw9gz7tYX0abxxEoQPQsRryVmPPAC9aJml4DJ71qHzTgDgOlgjKFZrGz?=
 =?iso-8859-1?Q?7EG+qnPvJ0JHhEKH95vjUjH8yjiJT4149Vj/vXp7NNAsBA5fCYFf0qQNzN?=
 =?iso-8859-1?Q?mJIanfQ5MpTob9g8fIS7rSsVJrPpd7OCfCsqkQ2S8eTWdKSpmtB9t17pqh?=
 =?iso-8859-1?Q?2ozkoStnBe8Dl5dotchGyscuVhO2kdl86Uy9QT1jlaiz7dsL/5FGPV35mC?=
 =?iso-8859-1?Q?hWfWa6lAlCymA6EXr6NVJY1+apnhzzcejsDY+1W4kn2WbmcsQz7gv4FRI4?=
 =?iso-8859-1?Q?GAIpdIJJl5j5dHU5JuF85B1aCk8VcRqj92sQNvlNM9QDHBNXf+pw3LILdZ?=
 =?iso-8859-1?Q?3ie1lxdsTMGhkKKYpcYWKsh2yEMpWWAxz0vKFAo5lZ35dUpoMVPNBEPtOS?=
 =?iso-8859-1?Q?TEMJvx4Q24zhA7aYMkVUDY7eP6gdXoQjtqfRqcjHkP8MZq49slcrUCEhrz?=
 =?iso-8859-1?Q?lPiqO8EUmcrMwSM43Iv3Y2uzpfEOMPLojMUACrSSHtlASIPhpMAILYFVgz?=
 =?iso-8859-1?Q?Bn6NgDuFMgYXqgRCyQi87Sy8X8akFKAawoddg8rm1pKhx6lHJPYmhRVrJ1?=
 =?iso-8859-1?Q?AR3UFWhxdAy6IUWsGIrdXnBJb3trvJiAvrv/mMBnBM74nRQ2tqSJwKra41?=
 =?iso-8859-1?Q?cXx4zAv/T5JZm3CHBB24fWQEnfsjSefjljD2VnlAw9S6Xo9Nq9B8FiHAgU?=
 =?iso-8859-1?Q?rL0n9rp2EAdX4ynch/D8rI01dq3+LiN6Ngj3RCNh6gIiThkyhT+la/mE0r?=
 =?iso-8859-1?Q?q58iNE7F8b50NoUHEL1CKF9KG+fU/Toft2+5AcaZb5e+cOAXuKdBagLrUM?=
 =?iso-8859-1?Q?ymmgwnEsEgGXJwtrFpEMHJhDqlIWFTBR6Sr4HdXkI7D7VmL4bIssI+6eBR?=
 =?iso-8859-1?Q?zVJjT1t6V2IueT66NPi0ncgDkUFrIE6czdW8j1Rfp6T4OW13kkF02aUMQD?=
 =?iso-8859-1?Q?ymdgus+yQ+PSBfB+8PYPidt0VBLe0hIAsJvp2oE65f7HvI84hK75/xht70?=
 =?iso-8859-1?Q?1L1zE7cdodrXY17Bug3oUUl+ABCH4uQr+DmAYq6rx4hC7/domXwnKKyJqg?=
 =?iso-8859-1?Q?8c9xaDuWanWzo3MbCrxPLLnThFLZK1Rz4qZyN21TCiANGo6ztCVhCgHJzs?=
 =?iso-8859-1?Q?slNhAazc1ATfovKVvTFwl4VP//ODFmz0nbdf5Kauqbm0o/RW/ZXzdS2Ul4?=
 =?iso-8859-1?Q?uMeQ2hVcu/MYAH2KqwW2NbjmDyyKHqNoQ55SYiSI05jG1h/J9tmDhGrM/M?=
 =?iso-8859-1?Q?K3hc+jUnCPYHMh8hgWfnEtQ2n/cp/gT3OMLhRjWhaCWN4m77b1vAowKDIw?=
 =?iso-8859-1?Q?K0/67Hd1GPtA0xPu1CAq048OxNaJ9EJDOJ/IqKV6q+3lEO5vL9KJAsiiLf?=
 =?iso-8859-1?Q?JJPn8548gegbqhkY8IOZO/U7OZKafxkFrLIH41OZy3GptgcH/vU/R1UU8b?=
 =?iso-8859-1?Q?A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7093399012)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?83r4jo3QQbiMQkz0w2JKt7S23ZAYoMkUt4qAFZhhn5e/Q0x6HoF1tVW90r?=
 =?iso-8859-1?Q?JnIXMnNuXnu4kiRCX5BzfO/7xFNtQwaE86lQrGX006g1myem7E6ylbMjwF?=
 =?iso-8859-1?Q?xBrFFwYRd2cCaGHk+XXu39YzqsiWEjtq729rimBzvtKCRErF0rmf+WTE5y?=
 =?iso-8859-1?Q?Kja3AaZtFAgKHpgRlS0IcNVsRHcfZuFbF7tDZgfze/V4pBBCyWq2z5aB2z?=
 =?iso-8859-1?Q?az4Oso0U487KpaKd1+IX1rntWXhNGjMrmhoYwQBQ9p6WW2zCu2UVbo8oZ6?=
 =?iso-8859-1?Q?0KU4HBnuadJ+n9UlLByyqZvqfO9nXAXAR4E/f+35kGOPH9TtoUWUFqR3vw?=
 =?iso-8859-1?Q?t1WOC+++e+D5Q2nbTDECSFDAbL5cCdL6zaakX1Rv1s3siFZFcC1SsHjuZM?=
 =?iso-8859-1?Q?mXKjI9ywOjty0DlAjY8W9SudFWU9nKuv9MfixngdzM9R4uX0yjRuNsl5/h?=
 =?iso-8859-1?Q?lI1JeafjM7J0oO7hE4Xntk0qXxikOMzVtaQeimg7JEEY92x7Lf3ZnP1vuU?=
 =?iso-8859-1?Q?/xBe67rrdoMdTFj1nTerF1LZK/K6z//7g7g6hazGxewS4Sh3nmVp4E1pJm?=
 =?iso-8859-1?Q?Ga9fdvunugpGD31koRWfCRW5KJbCvN7OW9dlx///bghXy4AYSWBXR92bnl?=
 =?iso-8859-1?Q?4sLZf1bnprFHdM7u1n+/75CkhaIhGLJLBphlt2qYeT2d0BQT5XcohDvicS?=
 =?iso-8859-1?Q?XF72z36ERyjwlOB77bVFpiKhucGcgGsJDZU7IwSZYBHWvGlCDT6hzS210s?=
 =?iso-8859-1?Q?bWmqA6REZk/L0sFtzLYLbJiKGpbAIcOogyYq+K55Zh7y2ZHch4YxzTPg/z?=
 =?iso-8859-1?Q?Mv5Kyn7vGHVFEiJSZ7ITOHfFVdC3ETvb7g79/mCasEzVsSt4USKdzi0ZK8?=
 =?iso-8859-1?Q?UmFxkJE+lMwv4kBuo/7a/hNy+OQJITs0H4R/M0jnpMkPIVuyrWcEm2vUiE?=
 =?iso-8859-1?Q?DvtW7dh5RagqjWWgTlUZdQRYE/2YdRtocKxDTnglABkDuvazs9KdrKH82J?=
 =?iso-8859-1?Q?xPKA3mluxC4/l9+HybkFxzVMcyBQPnMghnYRczt05CpBgye6ZpNZxoIkle?=
 =?iso-8859-1?Q?QAL/A+jmx+gptT0Gnxc4vnNXHqmx0E7mY7fIZJEZ0gSrZgCbDaBx3C9MjW?=
 =?iso-8859-1?Q?+ayZYi9xLZ40Kid8XeGa0Z99yylU5lbTeal0/FHNlHie1ohzYV1qevhxOs?=
 =?iso-8859-1?Q?neU2dkqMDY0TsY7jvm4aVw5uKhweUWo7x34MvV09t5Ehzts39xM6M9NLP0?=
 =?iso-8859-1?Q?9tLlZgO2WdgcePfNhrh9RT9uATNwikEmpK4hj35X+y6RGK7DGe8nJ3+rcu?=
 =?iso-8859-1?Q?XtflrzF6Mk5ZM8aWU8j6qUwE2JIXOkUP2jEbIGyrRF/WtwHxOIP3OcNjC3?=
 =?iso-8859-1?Q?B7SHTJNzmwesqlMKvt1q5M1IfcPa3LHKWYw986/4IX9zXfk8hSO3QQ1CiT?=
 =?iso-8859-1?Q?4YL96aHD/2C/e3qDuxr5VSWM5xDpwJ0Rw7yL3vEgdXldKiVwymALOiWiQN?=
 =?iso-8859-1?Q?igchLSAkepPyTCRhA8naZXql3PseVyK2C2QL3VDw4PNrM2WsrY35vCqVL7?=
 =?iso-8859-1?Q?Qk8Yj3aUBhktaipDhC1UbP2wQVgtLqzeyX7juH8l10EA30ezzFU/4GsAWe?=
 =?iso-8859-1?Q?cWexGTtOtW+jY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cd069e-f391-44cc-913f-08dcb6b9e9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 08:21:18.4759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g50sLyPoQYroSWV/R5Iznhfzj4Hd7j/Q3HxDF5LMPI+iapQ5GG9L5EglgdfJFHdodzGoniimpdfOj/Yl981YEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6991
X-Mailman-Approved-At: Wed, 07 Aug 2024 15:44:15 +0200
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

Hi Simon,

I have forwarded these emails as requested.

Cheers,
Eden

________________________________
From: Simon Glass <sjg@chromium.org>
Sent: 06 August 2024 22:47
To: Eden Hamilton VRC7 C <eden.hamilton@bt.com>
Subject: Re: ECDSA for FIT Files in U-Boot

Hi Eden,

Would you mind sending this to the U-Boot mailing list and cc me?
There are quite a few people involved in the security side.

Regards,
Simon

On Tue, 6 Aug 2024 at 08:24, <eden.hamilton@bt.com> wrote:
>
> Hi there Simon!
>
> I am Eden, currently at BT trying to get ECDSA verified boot for FIT file=
s working on U-Boot.
>
> I have observed that you have reviewed many patches/updates surrounding E=
CDSA in U-Boot.
>
> I have been trying to get this working, but it is appearing difficult due=
 to no examples online.
>
> I was wondering, if you have any examples where you have managed to get t=
his working? Perhaps examples of FIT files, DTBs etc - that you would not m=
ind sharing with me.
>
> If you do not, then no worries.
>
> Kind regards,
> Eden
>
