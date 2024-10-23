Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB70DCFA474
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 20:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5271F89397;
	Wed, 23 Oct 2024 22:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=al-enterprise.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=al-enterprise.com header.i=@al-enterprise.com header.b="Q2u3KoVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA9F68919C; Wed, 23 Oct 2024 18:35:11 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFEE892B8
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 18:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=al-enterprise.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=girish.kumar@al-enterprise.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZ9dJWDsty/ng6zrD7u+9Q1VqDvtKXGc3Sd4LLb4AIh03SVoNsnnMOuy8MVQm1nDCQFeO+YZ7KbLeRt4k1Nj7lcfnL0HDjakQHwzI17IFsEjRQS8q/l0+TSQ/AY9k3aez/EVbkMCKZH+9g1T9CFaNdeadvoFXnZK8hLktalXCFt1LW+zadnMMrNX5S0788g3f3siHCBr7RnYV8n1q4ihnhsmPk2fIdbIoaR6Ep8jofct4ZLf5ac60GJ5XAYQblu7Og41EJcf0Fb+RRG0yEIKPCsRi0bW4Ogjpc02PjRhOjeyoVU7MCMeky9S5Yu+u17nVWW/jeLwVHEx4Dp6UHkxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NI82VU6miOHySO+Jx7ayag66ZY+RAIIrdjwBsg+v7g=;
 b=OUWAk6zVVSWrcuTfSCWysnkqbshPijyg6JJEjCJwmVv85Dem3fjC6JMap3gbVqlxpihSpRFkZ9FBgJ6VxQq1/Pqz8OcDEo3BlRKUP7VloGEqTdV8V+t77Koi73JDmVdUqTOx7beS0CoXf/qTVR9HhgDwPJI6lxxva7if99Hk/OBtUQkN3d7jmqVjZ0VCusbAW7gKL2vAbRJRnYd1VDTFBFkj2zMA5VTf0PPGgdwchpZjA2wgRbD3Uhy6wwKO4T2zHqGvd6av8CV1dfz5ylmGtBX+OiQBwvCi7iduLThrdPThBgxhGSFZbUFMG0GdJ/B9MRFt8AUJhZFkzo0E92Hv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=al-enterprise.com; dmarc=pass action=none
 header.from=al-enterprise.com; dkim=pass header.d=al-enterprise.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=al-enterprise.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NI82VU6miOHySO+Jx7ayag66ZY+RAIIrdjwBsg+v7g=;
 b=Q2u3KoVaHiaRD/Hrg688HQ16UkBKdbCSW7leXMP6Ym232/H3hM9zCk5sD4WRqTLoUCVLiVVv1hYOC1K8G79dO+9wNIkkC+pBEGshi3RAO4lsoruvBY7fjGmm3ex7duSOSI3hg1etYgbK8Yr/3ZmBrcs9mydcX4vPB1OZPa7ailg=
Received: from AS4PR08MB8167.eurprd08.prod.outlook.com (2603:10a6:20b:58e::16)
 by VI0PR08MB11169.eurprd08.prod.outlook.com (2603:10a6:800:252::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 16:35:04 +0000
Received: from AS4PR08MB8167.eurprd08.prod.outlook.com
 ([fe80::2da2:6fd5:19ae:5f73]) by AS4PR08MB8167.eurprd08.prod.outlook.com
 ([fe80::2da2:6fd5:19ae:5f73%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 16:35:04 +0000
From: Kumar Girish <girish.kumar@al-enterprise.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Patch for 2018 u-boot : Fix "EHCI timed out on TD - token=XXXX" error
 on ehci-hcd
Thread-Topic: Patch for 2018 u-boot : Fix "EHCI timed out on TD - token=XXXX"
 error on ehci-hcd
Thread-Index: AdslZ7yOimV/I94/T7SDOm7sLs0d0A==
Date: Wed, 23 Oct 2024 16:35:04 +0000
Message-ID: <AS4PR08MB8167C4DB165AF2FB28C0751DC04D2@AS4PR08MB8167.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=al-enterprise.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR08MB8167:EE_|VI0PR08MB11169:EE_
x-ms-office365-filtering-correlation-id: 0cffc352-259e-4552-ea89-08dcf380a5ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7zXPEOXxL0nYk5ceUttdW5x3refgXHGs1dFpzjj86JqOyTiPAOfyJDikqgwJ?=
 =?us-ascii?Q?RbVj/5FcFfuElcTWSg15mejWKi6cCIz3Jxqhm8T7zN4zQjinlcssmBJfUcCz?=
 =?us-ascii?Q?/6jOKBTB7x14UjNMlKnRN5n9fbcgAcZFmVpdNPU59khibp4MYVrb/DiMUH3j?=
 =?us-ascii?Q?lyC2X2MH4sL5oRQZhm0CCjuKVO35PulQnJ2z8uAOwML+l+im1eBszMYTGVr2?=
 =?us-ascii?Q?O98PAxe0u83lxQN3SOGQZWaIAyiImilAKEXQmpWAfFiLKsMk/ieiZPpg/9LQ?=
 =?us-ascii?Q?pWoExUkCP+sacWOjXAEbsktSE8ED3PmMPwmBwjZUC5eDIo7zLZP6Z5ir8NuB?=
 =?us-ascii?Q?jYrG0EoBCmf84ud3nQephwRe7V4iQ28JWHI/p58Sd20fAjAV/Q8g29WMv9Tv?=
 =?us-ascii?Q?fLmYF+CakwaTGBt18u8Uouaw4qkM8OwqHki3HAsUD4v2KoFsLWoJE5jC5q41?=
 =?us-ascii?Q?zMRPxDqfsSGORqaDBG1pEzM0WvBCV2d9/xff2BBaQONr10k3SS6rqanRc8jg?=
 =?us-ascii?Q?/Dj0ufGM9OeIdZVej+bsyo3MquWQG6UY+m42uaHINcbJoAAkXxT2/0OkdbW+?=
 =?us-ascii?Q?o4Skq+neg6qdlzzPV6xItLFPzWWvD0Kiss/LOvXpfZDnBqlF6DeanFv2jinH?=
 =?us-ascii?Q?VoWLOXJd/fHf9bnpA/Ku1ZPzTI1Lt+fSS7mUB7I/umeuDkPww/3D9KDitbZ2?=
 =?us-ascii?Q?xjpQ1u46fm8nFRX+ejp6t5pVQcq8a1YXYCpoevwyb5fh4+4J+DK1g6zsn/cF?=
 =?us-ascii?Q?da7C1f+YaUKFDVlxwRsN5o8gp3lyBlYsDjqhP2FZ3pwM0Jyy/dyTdWNYaH3D?=
 =?us-ascii?Q?u+Py3b6cyQne7lxnJHNA15yl7AK26968B2hDG6/pnneIWtlNDoxF2HMipd4v?=
 =?us-ascii?Q?h8un021/8Z2dFjXpFYsDaojEwRZCarJPz4m7Hb6ghbjN1wWb//pf+Cl82dqo?=
 =?us-ascii?Q?RnBB57adGCUViy2RSBsHM44LDsBMQaO4JOEUN3CXdnTPUb1D2Lrc34Wtzads?=
 =?us-ascii?Q?eretP4urXPehu0CqKRO+F126c0YalJXhqioVHnFZLfaLCMtsBrE8E1hiPT+X?=
 =?us-ascii?Q?Evu81ujPcQxVDkGWQpjguQzGYb0ExjQ3Hf2xYtASqE+zURXXNXcw+atz9c5H?=
 =?us-ascii?Q?vlvtYkSRhSOPxKRYPp9uK1IMMwkNDKX5M4FmWm90CTq5ak3HwxtXnR162Ebb?=
 =?us-ascii?Q?HxwZpf3Gayq/M4NtNfQjhqlImlhq9AgA/mG8stb7AwUxc9Uho2Pg63LywyFd?=
 =?us-ascii?Q?MnYcHj5AhPOGKMM9N5vFNGRvIypBrM7Nvedqkc6CZR59adBh8a5ucMywMj1C?=
 =?us-ascii?Q?dsC55avojGGQB2+t4pnL1Zzt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR08MB8167.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h/8IidS3Xlrxhl27aWZNbKJxnTQD4iUPSJMK+GKjdYDngullQkm3de669eiq?=
 =?us-ascii?Q?hhxIDVvUuOL2oGWcaxeCF+ksfVajmw1+MVoeiVB9eb9yBc+QUXbLajPgWoMx?=
 =?us-ascii?Q?xewU218mlu8KRXdw+mH2d8U4r6tdY+ZkQIgOyOFcyN6o1BMAZUD3TBuQFInX?=
 =?us-ascii?Q?sJp4KVz5bbtmIr60TtliZsaY2Md9Yx/lenRjB6CCpoxFbZHznvo/sqNwDEd0?=
 =?us-ascii?Q?+BddBO886+sGGIplldDjxBzNoSdh/Z/hBKzYmKCAWcBTw+q4hPc6+E/lYEH2?=
 =?us-ascii?Q?vudckzXmjwBOEVFh9HWz+iF8rHVUJHWZFz8bdUavjdY2xbvIOphl0HYVk/5q?=
 =?us-ascii?Q?JlPlDPD9HH9/yAzMR0vrcZGwd7oA8om+SB+DhcUtI73SJXGSAbneOG8yO1g+?=
 =?us-ascii?Q?6RVT29EmU2uL3g4897JWHhVjrYmBGL2xm7Mm1r+Ytq+b66oF050gRl4LMJZN?=
 =?us-ascii?Q?1f/Myuk8+1FGXvDQEWt9HJaJ63E/Rphkypg+6guDs3U1Cqk/d3BLrTZlRBKn?=
 =?us-ascii?Q?b8NofGfi6v19EPmac5rebfOUol+LEiTyHKf4s9ohn5Wt6Xr8CwOrjCVhiE7l?=
 =?us-ascii?Q?AJyIuCuDb/QVa/o9/+WXsTlxKn6U77taI2dJ3keUpZM57dwfi5ZFcdYr12sy?=
 =?us-ascii?Q?MOFGWv0PKmYiUPStU3uByQ515VtbIrYYtue63SsoZSq0inzwEshbY6kHFqiY?=
 =?us-ascii?Q?UbHFNkrxIL1esySexX1g4iyXGa9LQLL05f768Pfd5WX+gBgtyv/jenVUkO8Q?=
 =?us-ascii?Q?+4xZy9Y4S/dAGq01tCb32kPxCWTRzl+tb9OdJwSTq2sZkVCFwRov0l+qO4/Y?=
 =?us-ascii?Q?m6balf34DJ8FJIhXVKiXFaIJl6T+rQub9ZkjUhMF8IpQ22GFUHSYSlHO8PTv?=
 =?us-ascii?Q?ic/iRAj8IZ9gin3LtWCgt/daNcyKndp7g0MNCZYkeonneOgib0v7dmGV7mnh?=
 =?us-ascii?Q?k5qdPCSDSqg7s+rsASo3HByJBemgDleY0+ono9uJnjpHoSzcHDgt1kFP7FXP?=
 =?us-ascii?Q?kk3hlNNFDGJm7ZiLOUHAyr4AinUTIFBli76GhkK8Da0Z4X+8QVnLL2ePMORV?=
 =?us-ascii?Q?SJ1fFDl0DSy2JM6SrrbbMH8APfavz84Quq/jOJRCp+tFkCzphCAr867S7F59?=
 =?us-ascii?Q?m/vDEJSrPSWG7uaBq8xKezlaJbT96Dqdl/FM8nnfNtnVyXfnSLbEjKTthFjJ?=
 =?us-ascii?Q?KWt4eC1I4Nw0glQtDmdQEZXNPze6O+wDdf5x8IolvSaH5Zd+SGp8UWZDb4RD?=
 =?us-ascii?Q?/0lVaRPbgArnMPTXN1d7BEX4O1GUr08FLKKooKEX+hp8R9XH7mXSU9Ju9zN0?=
 =?us-ascii?Q?5y9B5gZKv8SrBP8RprW3rbkTDPrtCKQT8WBn1FUA/T4DSXF4JvNTivN91OZ+?=
 =?us-ascii?Q?EpklXNVvfOX0sj2OGSmjaon71bsXmvCeHwgCrU0Dg/E471Dlvf2FNCCMmJ1s?=
 =?us-ascii?Q?1rmJJitmP+8dQojBnRZahUemHG/ScFfUA3lSWSqO5uIGZO2mC92nfAwfPz5M?=
 =?us-ascii?Q?SN8ybGR0VK73AXnXx3x0zToc6MYl4sysU0Vj9h1BbEYJUEzhJLd7wFt6JAa8?=
 =?us-ascii?Q?vK7viiu31FsPtkCiJk3UWr2vPN0mY0roEX5xAL2W3e4YSqPAinDChFRm2Ebn?=
 =?us-ascii?Q?Dg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: al-enterprise.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB8167.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cffc352-259e-4552-ea89-08dcf380a5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 16:35:04.4326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e410eb7-628b-4a1c-ab28-642f4be058a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owSTTJGU4noq9i+YfYYdfHItadbyNDzDd0LbNX2qaXkh0xevtj/58+Wocc5mvmgdPZjQC5JbWauqE/fpgZqKHaUaXd1HqhJMW75WfOg+XZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11169
X-Mailman-Approved-At: Wed, 23 Oct 2024 22:55:07 +0200
Content-Type: text/plain; charset="us-ascii"
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

Hi All,
I see the error ""scanning bus 1 for devices... EHCI timed out on TD - toke=
n=3D0x80008d80"

From the denx site, I found the below patch. But it is for 2016 and 2017 u-=
boot version
https://lists.denx.de/pipermail/u-boot/2020-March/401784.html

Could you please provide me the patch which can be applied on 2018 u-boot
Thank you for your support.

Regards,
Girish
