Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AB0C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73E1880A5;
	Wed, 15 May 2024 14:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=skidata.com header.i=@skidata.com header.b="xMdvEzP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B6C880D2; Wed, 15 May 2024 14:40:07 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F4887F19
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Johannes.Kirchmair@skidata.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQoIbzUBDvWeTPT1aVy3EurQoNcPHZgwWgaA5bkR+eSv9OM0pjFpOcpKRHRnPt4r99GZGopc+nZHSZ72GYxXlGixDGf2ry4y4DyhGOfqhkDuXPcb2KFUucajk91C5P4cMPiLetrLL3Zg+BDPfkgoc/MSpXp8WE/YGoKmyCMQoPMo2n5QfB6c4yvWzzjA5S1t8MyTgwBWtmzzqLJHEK/dtpMxOx4ANv5gjOFPfWGZfjNJuLHIL5ABc31kpYCPrgbC0xLNQmbEnsIbZuU0OjsjRIpYtzNrR7SzK4rEVfUPJsT3iMNJkABQyKQR1Gkec6GSck8QfiOn+AfQuqP4IFc8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xX8K7+crH2IONfb+fFgR6j062XPLRWdVRUnXw+0JvU=;
 b=RZSARvdwrlEGTxHifkz/Wwnfjaq9GIxAH9v2arZ2SJQddv3pfPCE5QswmA5ubdhVH6uHHqJ3HYLtmjspSXlLlcWN0oJ6m+vQ2nkC4KcD9cI+GrH59Wq9fkNV2wzYRy7q0+odJo7ZbZ+SIu8+SQZQMKSemNqmeA8dUIWbv7sa6yw5v997uQZLN0TlfISnfbdGCV/90v3yXFCtadAl966woQ2kaU2Pfq8HP4Ko2gWoCqS0RxC2vXmuTtztqBAKV1XZ68SxKuw8OthsjWmQ+08z2fJhK6PtP1qxpzP23LFzykL9TJnrs5tbS8yHME4EhK33mnNEWdNleksZUbcm+ufcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skidata.com; dmarc=pass action=none header.from=skidata.com;
 dkim=pass header.d=skidata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skidata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xX8K7+crH2IONfb+fFgR6j062XPLRWdVRUnXw+0JvU=;
 b=xMdvEzP8APgfssJNO7KNFwQ7xSEpHSVl9j1Qbdw9HufVmZMtl+Iv8gNphldYEu6e+iN0EdSsmDYu+6/vxDwQJwaUq5q/5Bn9o89dvRFDfSkv4kSHuapZzWbbfaPlqKK6aW/owKT4lmTgHzyxjAV24klpevhCBO4k19+Od/noqR1gFGuwq5+zxrAWLfENqNCyiItLA0fAFKNkugrxjlf69WRLbht2kcHO2eswVOhhi4lIVxijXxDoRyFPPgPethg+w9tMXNoqlpxfe1maqEO3fQslKt1n+8HUyaA3wEeowcWOxx0mq2K8gdIuqSzDPMrXwtWxYcxY+DgLN0mEqYNnLg==
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:39::5) by
 GV0P278MB0116.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.27; Wed, 15 May 2024 12:40:04 +0000
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c]) by GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c%6]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 12:40:04 +0000
From: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>
Subject: [NFS] fetching kernel via nfs
Thread-Topic: [NFS] fetching kernel via nfs
Thread-Index: AdqmxNtVZ7j6TX9BRqmqRnxh009Epg==
Date: Wed, 15 May 2024 12:40:04 +0000
Message-ID: <GVAP278MB045609BECD802008B0FEBD2C8CEC2@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 2dfc9372-0b83-4f7c-90b3-6e9b729ac039
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skidata.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0456:EE_|GV0P278MB0116:EE_
x-ms-office365-filtering-correlation-id: 69d778f7-ab2f-44f3-8e13-08dc74dc24f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Udf8Tl2sOz+o8hHiDgNXrAUEXKhrX1eBmwsxySD1aj0DQR21Q5yWb72SKFSZ?=
 =?us-ascii?Q?t6YGsgfJwYjl3BiARvW+JzjVlMYoQzGKiLf7GqB+UzKa+f6QpbjBB8I1wMyr?=
 =?us-ascii?Q?IYESI1swQkiRhzG2Lgjkh7S+mAe67K9vKVmkjpfkhr+4sdFYRGN6h12wHHe/?=
 =?us-ascii?Q?yy5ypN8VSV6kr4rk5pdG5xrkvXw3imVQjbrXJJUknRtMDKXmCMIXihsnvmNJ?=
 =?us-ascii?Q?xVDhFosFPrIYd8qON+0vjZOkko2yAwYjLrXRjtj6arcwlWRSlBDiKeBDqztj?=
 =?us-ascii?Q?A4v/h5L6ir+gCwJDjsI7lpHRfEr8i0eVBTio9hMgN0ARIv2dirwxP5xohonj?=
 =?us-ascii?Q?Qp5YBizSyybPMMhkWSkjIU4e+CnEVaxdVkkgb9y2Szm53qIrISi0k1pLjLnF?=
 =?us-ascii?Q?ArrIFKr+zxcX0AoKvi9bm1hh+QdZ73TBuo1Xjrt9EfMMkAKrKKwHBua/210+?=
 =?us-ascii?Q?oh+7nZyRdzVd1rK6sD06wCJ0ZRQPD84GEURvpl0tTO36Ob8+xqvH0AkY3S4Y?=
 =?us-ascii?Q?M7+WdRMb2ItmGuSrxewEoVmesCwFotMeBy5WJdMLwXQcYwJv8Aut4Td7Tj3o?=
 =?us-ascii?Q?U4fdh5M32XyaKXYv6BBNiKrgnORCyXOqSbQneXtwusQHK4mnTIsDdKHHE6Bl?=
 =?us-ascii?Q?x3CRhnJXZEtDbGhUdz6jgxVZLcaPOXcJDhwhNJvb8gNwm5F8+QgkXZOf8QB7?=
 =?us-ascii?Q?3qCLw2DBXJaKATgZvDRJYeZNFBWYzn6kQY3hguTGoKP/FQgFut9V31+U4zfl?=
 =?us-ascii?Q?SXEPNlJeV3Ffv1Va77k621froq97dPbdj2SBHa5M+vLLh+R5S51LMYOPzMQb?=
 =?us-ascii?Q?jikUdwyrNjAckEO1bbJ3a/oqCo4TW0RxHLsNgBd1zSYClk7nRHEZik15HpZI?=
 =?us-ascii?Q?9/k/KxDFu2VxpK9vW+IzN0feJEiENj6+Y/OyyMO1retbmyKCWoUr5CQn31+9?=
 =?us-ascii?Q?j0mkYxrpWmVMxQxbIRbNnNQpq9MX4KYVprW254XMtxqBbLsKn+VAonHHZ7q3?=
 =?us-ascii?Q?B92xPs/AWuY3dVcdO7pTIm8NEH9CfwY4Hdza63TcVTcvHxmWPy4IAfXMEFAD?=
 =?us-ascii?Q?mpvl7YQqlDefNpGtASwqkZcT/9H6nZwf1YWbPkNAHFQrHMm7BMA9fZDEAzHC?=
 =?us-ascii?Q?wpysueydNHXBj5ZEF0n3ztpQetXZZCsY6MlQeMlpMm8krS6Zvk8ntf4HVBbi?=
 =?us-ascii?Q?uA+f7WB0rxSLBI9SOvxThP0gNIm/V5cWibxGj5CQo4hmKQ9oBTUcT82gh9bj?=
 =?us-ascii?Q?3YjvbQcP69VuV6dqw7n4fKkiRxRCCHweeuaum532oO5c1bHqtRfcysiXoFgZ?=
 =?us-ascii?Q?Y/OBp1Kgb5dW12qiYl8nk6ByczCPbaN2AMfNze0YZxFQxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nx6kwLF6cyvg0FdG8fbVjSZusm+OBT8tUvYmDX96ku5Xy/2Pqi1bxVEY7jdy?=
 =?us-ascii?Q?ud5UZ10v0Ocqo8wRLZWbNIJ1SHO0ORrmFlAvIU14jFj3f+RGMdeZ0eTK9mVr?=
 =?us-ascii?Q?5pKRNkQhKiAY3hgk6OluLhxxKnYJbArbDkPLjtpcWKOXYBLkSc13mVadyOzT?=
 =?us-ascii?Q?QPsgqS3jg5qtfu6g7YZ4Cu94M6WOBNsM/IhVMnOCgxTEyYpt+xwOqgvVxXlA?=
 =?us-ascii?Q?65mcSODhEpYNzEjBkmllgFDGtQ/Cn5kqaC1ulG9rRMCBOp5Oz1s39DS9zJyC?=
 =?us-ascii?Q?B5+DH7VTUHydtlAJoYXPuQCEt4aELZ4bWiQgY/8V1VKxP6k9C6jJhKtFgS4z?=
 =?us-ascii?Q?Qb7WnS1GZjRBqw+QMszZRrg3IxgGKmL8qK6kmMyVz1eqlpm9wTvaUNpKLtGL?=
 =?us-ascii?Q?C9HU+j8ABpZ6HCQF9cj10TMFFHLR3f8s9OyC2SmVes0cPMSZQPmYXwv2Dlqh?=
 =?us-ascii?Q?9zOnS2QqF9CkKRNpj61h3cBZKKnO4hh9qMZlrjxA0FvWZcPoeiyERRUUq2ta?=
 =?us-ascii?Q?DF1wh7byfBCII+vA5aLtpklC90knbmiPuLDZKeHekiOuk10+7RBxZ7ba8zi+?=
 =?us-ascii?Q?9tDRZM65iCh8fz7FSgq4HuNlay3uZXGpB4bBuviukKY1XFuw3kVh47T0novl?=
 =?us-ascii?Q?XyAx4Y+ZsrM1GVJSdmdMU9QTwEEQDH1XcAdQsHmNpjOk3QtMTbWDZvnCjaW5?=
 =?us-ascii?Q?nEqGEWvDoMcY/fMAYT0TojCJVKHhvB4E7NDLQzHsmh6K1GqpTaLq7scJlw+z?=
 =?us-ascii?Q?Vj6gKjB7JwamdTNHWQeY9T4Iu3mf+UFg1HxzZz/dn5dah/OAXqh4GPIWOiWA?=
 =?us-ascii?Q?xSM4LSoUmDyST2G7AkR2Bq5UGEcbP66eeXI97WN+ZrSQAyhwuLe+hJExu/mu?=
 =?us-ascii?Q?yDoAsQAXq1RRHYkyL5J4KxmoAZs/IejI0UzEbSsGLvii0tscamX3fcedonyP?=
 =?us-ascii?Q?tJBerBIsDmbYZXGFqcJVl2+ybCNWknzyrlMD406AgSQ50FSChv1NM+BSkuAj?=
 =?us-ascii?Q?73XugRrZS9N1SDWiG72n72sXVz6TIL/DWeG/XGIedFmWo4LGHEqx1CO5S/0x?=
 =?us-ascii?Q?MVUEUUAoSvXuoIVNyO7tXmFsplLj7S98X4IAqDDxfxkPMbIH+HDscSWKKTZe?=
 =?us-ascii?Q?llyhnKzthW+YmGrN7D++czqiR37DI8yBcOK66GenE40WNIP9rcEamm+PUMop?=
 =?us-ascii?Q?HHAd/UuQlS4S3Nlg3An8u1TTqwLwIi0nVWhqwSFFFWyeXHRNIFpZ+rWt4zIe?=
 =?us-ascii?Q?01gn3nOUTjC1Lr4Jzd/fc2AcowtgIbddqLhuExyAjPrqRtP1XXQjZhWKkBFc?=
 =?us-ascii?Q?JwsLSiAYrCA7INhuIRBSGLZtvMOzGi8CQoo6sB3DQEMXBrT1PDWxlujPOs1G?=
 =?us-ascii?Q?tq2QjgRFzcsOIj4m4FxN8nULPWGXVuxhJYfpKW97riB1/f6Jz4xT8IdgpGv7?=
 =?us-ascii?Q?iQVcFLj3dw+mXoti/PCt+osbkPWRXwEoJ/T5Dr5JHkqx15r4RCjflNIy5LKN?=
 =?us-ascii?Q?kKlkKBb5QlrgL6GzM3REKslBrHGI/1QlIeDtS5gS48RaMj/nWMgI0RM8z0UC?=
 =?us-ascii?Q?w9qZNqmotCFHRaILzeTqqa5nSBhAl6ylLvy42aVDBJjqATUM9YD56n3uG5gi?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: skidata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d778f7-ab2f-44f3-8e13-08dc74dc24f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 12:40:04.0786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5733095-4425-4f08-b6ba-487b9a46a425
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdfLPQ2cWhsfbYM8uBupV3yTTYbbotJCpaWfQ9minv8o5/RcqH1DMdVtH9Xlg+e5tEuJf9UD59A8hnRGtO9MDEO4z7VabXCdmXbC6dPRiYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0116
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

Dear u-boot people,

I encountered some problems trying to fetch the Linux kernel via nfs (v3).
One problem was that the nfs file lookup always returned NFS3ERR_BADHANDLE.
This is due to the following line in nfs_lookup_req() function (net/nfs.c):

		len =3D (uint32_t *)p - (uint32_t *)&(data[0]);
		rpc_req(PROG_NFS, NFS_LOOKUP, data, len);
	} else {  /* NFS_V3 */
		*p++ =3D htonl(NFS_FHSIZE);	/* Dir handle length */    <=3D=3D=3D=3D=3D  =
this line
		memcpy(p, dirfh, NFS_FHSIZE);
		p +=3D (NFS_FHSIZE / 4);
		*p++ =3D htonl(fnamelen);

In the NFS_V3 case we add the dir file handle  size to data and then the di=
r file handle.
IUC, this is not correct here because dirfh includes already the size of th=
e handle in the first 4 bytes.
Feel free to correct me if I am wrong.

As a result, if I remove the line "*p++ =3D htonl(NFS_FHSIZE);", it works f=
ine.

Don't have an in deps understanding of nfs, so I am not sure if this is the=
 root problem here.

Best regards Johannes
