Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52079C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 10:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD37588080;
	Thu, 16 May 2024 12:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=skidata.com header.i=@skidata.com header.b="dCx3qUCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 383CD88258; Thu, 16 May 2024 12:53:42 +0200 (CEST)
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB9B8803A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Johannes.Kirchmair@skidata.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeJL3mS9Nq1XYHwl3o3GDMP3cupR83AkeqaNG1AzV9UuD4na0Fdr+tOcTQC/8pUSC1F76AdfxRFlxWKfeMoPOam5KvDw2MnSl2Pr+Yf0HMdqoO226KlQKfW41W9xsPC3/wOSQufENZn/9cJeZxE0DPKAwmVBC6eKcXIa77URGVLxylbyQe3pganFLqfJsp3uVJOf/62gBFZS4rbh4pquPsG1kz9hIqBAavQXoyLtGovsyj5PANZFlHHjYwpLtpb1G/NIE+3DXRriJBJGntKPLM8Jtjs00XJ7UYag0Cf4/uB/Lj/Ea6vOcv6YZN7ZX9wmDmdhBgVgYadzPqM6o1G18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq+cHNneuptk+b3l6jAtbjGdXoW/5QurOyLzOdzDeyQ=;
 b=YnqI2CY60ShEdKaFKhhO6iyUkk+DWGpgsp/DfO2dTi9EeOCsWFDN525w/kfmJoU4jgJd6e9hqWduCgYtUQF4K4Kwye+GeoeSA0ZXvJy3KFCWXzN/auNdIYlqCx3qL+cZiYp1FQrgMqj8Zfg3uMZAgttHFDYOzFECoJC8X+Dyc9Z9KZWy85WvjMLb+KRiq8c+G9M8pDsREcLBg0qAsoRHtol1ZtoIRZBcFC5ebm7zYxoRV6maI2TR85W3Q6IPXrAgTaGdX7VgwzDH0idFVrDoaM7kwN0hDOEf0VcxSmK+gRyqSJTFU4uMpwFPsnsXrYTh/9giOAQSo+5SWksH/w4j5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skidata.com; dmarc=pass action=none header.from=skidata.com;
 dkim=pass header.d=skidata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skidata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq+cHNneuptk+b3l6jAtbjGdXoW/5QurOyLzOdzDeyQ=;
 b=dCx3qUCYR+vP16DRE+BYXXoT7U00QPDEzy6cVu/n+m/ubChwImolmTBjXnhnyvM2TbQDCwB1UXbpdUNFCa7SF+j0KQdVlbv6Z70jea43lPf6S6N8ZB3DKfxaLa6SQzh145WJ/lE1fcA+qXHe5c2ApzlmjzEI+p4AgX78qs++H1jSy+VSkAF9eLP9PqMrjn2f3x+Nipv3hWibDpqVHPC5qa2SszjLv2Ofr5LgapDf5uEKYtK11M4oV6LA2swq++RKkEEyrZD+f9EfSJkiWp4ehxbrfjui1meeBnXShjWXmol8q9NM1nUbrqITf0qGtiXwEV9ABpoW06+UXS4adP32bw==
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:39::5) by
 GV0P278MB1141.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Thu, 16 May 2024 10:53:38 +0000
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c]) by GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 10:53:38 +0000
From: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>
To: =?iso-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: AW: [NFS] fetching kernel via nfs
Thread-Topic: [NFS] fetching kernel via nfs
Thread-Index: AdqmxNtVZ7j6TX9BRqmqRnxh009EpgAI4FwAACWipOA=
Date: Thu, 16 May 2024 10:53:38 +0000
Message-ID: <GVAP278MB0456BB0B0B5FEEB5CC0F22118CED2@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
References: <GVAP278MB045609BECD802008B0FEBD2C8CEC2@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
 <5b5d6fe5-d436-4ac0-b6bf-7485196a97db@armadeus.com>
In-Reply-To: <5b5d6fe5-d436-4ac0-b6bf-7485196a97db@armadeus.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 0664f8b8-f804-4673-8cdc-e4f1afdb9d16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skidata.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0456:EE_|GV0P278MB1141:EE_
x-ms-office365-filtering-correlation-id: b3751ab7-7aae-4758-3894-08dc7596710f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jfva+pZRUZKU7hFbklIwfFNZfWBE/eLNNNDqCRap/T5uGe0iw6aXP/Mjba?=
 =?iso-8859-1?Q?wPHv2bGruPgaCLmUq/0ioWoWy80ZnwkSJyoQA0g5gBcI99crx972Ihg4f0?=
 =?iso-8859-1?Q?OWQn3Q3aHA5Ys3pOUvX66UUewmIbrgcdtOvUfNjbtz7EhvDRsj6Y2rEO5b?=
 =?iso-8859-1?Q?xEJS0WZOikh4IL1xIMrs3fggaelZ8VqF6CzHbSI9LgOUOaMZ0zTanqZuas?=
 =?iso-8859-1?Q?hfiq9h9Aog/RQuT7YDyto50fmFg3paUcGPnhF/KaFOXnglBHtp6aVYYPNM?=
 =?iso-8859-1?Q?p2Dv4NcPnTOv1Tts6mRJoq5Jqno8/pofs4JRn8oMX2WfLgAE+Nf9aoRAo7?=
 =?iso-8859-1?Q?BiEe9RY+CDstkx1i00T9cNfXZ/6YKwUq2702eFsfKiKyuqMOuBwjs43qCF?=
 =?iso-8859-1?Q?el6Bs+YLWMCHr2eyswMZujqRU8EaoXxL+Gpo0yOWwG3GJnuIa0tt24LDNB?=
 =?iso-8859-1?Q?n2y305+UvGp79BHTR4DBSlk2GqXyVwqLCWbZAut/Ta1rAW+yOK/7LSaYav?=
 =?iso-8859-1?Q?sUK+AwAhx3AW9aJTNavs+jyQOg4yX7TY4R+X557MX6vRjB++jnIC7qneqE?=
 =?iso-8859-1?Q?mNxifItoiWsph5W1awyoDMpPbpmG4njQY/zWg+detBQ8bceFQ9pcDJX5NH?=
 =?iso-8859-1?Q?Kov/KKechpt2BdJN25sb633kc7aE1TVnJO7d1ISjVCWaMsNBcRBYDLVZyo?=
 =?iso-8859-1?Q?92HA7MBPi93vwOseTx4y0PD6WMjWImJ3V2qO0szWIzNurFdzOQWFqpQ/aR?=
 =?iso-8859-1?Q?nYwJuOJmC+EoXecigKZwty/FG+SvEufwzCHvDIcH2hl1amjSMOyE5cn0dd?=
 =?iso-8859-1?Q?AA058l0qWMs0CStg52hnfbUKDQXMpkywGtSOX93GSJf5X5nKummZzy2ybB?=
 =?iso-8859-1?Q?rVMmKr4oXCwrx1UzZKIVET+giKrQIB6SQu87MeEsULtVbI5dXpG3sOEymv?=
 =?iso-8859-1?Q?6AIoHK5tq8z0P4QQQduInlWA6kitQcl1IW/QcoEP8+TAdRXqTxHy3SOpPV?=
 =?iso-8859-1?Q?/uF3InwZVQdeEfn2+fqE1KNvd+x/x63gyaaWvluRkKu+CIBWvu7pNLcJwn?=
 =?iso-8859-1?Q?MBr0JCDxDpJLE2o+PM0IE3eJ8JFSYLGwiPqJ/U+TX/cLUJtYk+cBLO0T1I?=
 =?iso-8859-1?Q?jhUatqdKjaHTz9Mm76L3cEXvjybIPxsvQp+zUMBw57aZE8TSyWO9rdKm4W?=
 =?iso-8859-1?Q?UUgSjvLl9OAw7YrsiK2pVdlQwcl52gou5HRKa2suIr1/QlPdWuW+Ox7XP/?=
 =?iso-8859-1?Q?u/DHgCNpyftASoVjjar6ogJ1hkCobuEmFdwquqFdWLLpx+Nzsp0kmOSKl0?=
 =?iso-8859-1?Q?PzsfVjHAoMzPewx9RQcQFb4wzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FCBc8BCKVpMyV1ddw2bA2NmbTDaoAH7XaK6WMembL/vNmTOGpogt66HSBZ?=
 =?iso-8859-1?Q?yoAJxxio+wKw9vl7DOEGEhf2ny4+iAsg2FnWENd4Ppln2qDpXCLCk6AhlV?=
 =?iso-8859-1?Q?nsICcmZzrcM+ikPe1uJG5UfjmVOW0iDluZFQLnxZ/Gnla7r/dCTYkmg0At?=
 =?iso-8859-1?Q?07jJWN34gRUXWlcB0zzGn42Zxqoo6mjpqYHnqHlmghSt+b0EzMoq+sK817?=
 =?iso-8859-1?Q?QNEDEt58VCx8GDZOuLVyNpIgLaEei2R29IYyof39E77Kq7/DOG4lzT211R?=
 =?iso-8859-1?Q?w3/Y6IGci27h6aRD+JdR0Bz6DWCel92wyq32X1dUO3dlJzYNu5Kah0rFlj?=
 =?iso-8859-1?Q?NvbFJ/7ZZYm7Wp8DSIeSeRRYMkI7/BsYm1lWUtPLFioUpIVnWZDkHEbfFX?=
 =?iso-8859-1?Q?xg6TUpdR6RQkLcle2uC+pGOHYOGbPobPG+klW/oF8LohfA9GusN9Jq1TFP?=
 =?iso-8859-1?Q?irb2tF88mK3BdISZjDSYZDvnoj7YcSsmB6ai16Hd9ZEcWWuo7HY7wEbNWe?=
 =?iso-8859-1?Q?JhLnuFsgxDMh1yCpYTPPlCJS8sdzSAppkAXuOzZ0aAyq9XSrrTlcNs4nie?=
 =?iso-8859-1?Q?BUsm1reHRNz/rnRpyvJI8N0M+kh9qHTA99rsBJuFfloDHELBCZL2URJYNP?=
 =?iso-8859-1?Q?YzJ58aMyLKKa3Meb9lBQI1nrLQ48g8bkqbkOEc7v/zgnpwdzMP173sYL2Q?=
 =?iso-8859-1?Q?80AgOzD3m+iex13rbu55kCYmrzHWork8um7c08BYhs8Ie0ynsWII0KF/UV?=
 =?iso-8859-1?Q?Rpm35oxnYQ9JlOqiVk8S7j+wjGHdrJHuJ1uv5D0OQq2jZ663gRSU79Ioh9?=
 =?iso-8859-1?Q?Cy00jsSaVGCQDe3nPkIwwPuuqZ+4spLbGL1wfnNMEOedRyR7049aCHPyuZ?=
 =?iso-8859-1?Q?hq2KNcC81Ew0KRbaphC8uBp8sV0xAiRWNiw3EpcMx1GNc79HxA0oRFvr3M?=
 =?iso-8859-1?Q?mzK0JEFJx3mlYVB/nXtGQFRjsnex1R82Oa1Fdw0YgZ0jDrf+gzBBv7WcOq?=
 =?iso-8859-1?Q?T3N9u+YW5wwOPzf9f/GocbjE4coZS1t46OudDWCI7G6TLdOlnBPjMhmIGS?=
 =?iso-8859-1?Q?0VjJNhnSJAHXfFxhfXlabrshW4itz9F5oLp720d5OL/MaM4xUEAnXCrbTe?=
 =?iso-8859-1?Q?7LkR9OXtFEE7ffZSkaGyeteABOADhaN2Ust/JxW4tQ0Wz7XpXiWYAWgiJU?=
 =?iso-8859-1?Q?Bgnkhu9lunYsOwqxcZOXBLCPmU8S3Y8BBkSXB3aA9fNGNqiegyBAs64CjS?=
 =?iso-8859-1?Q?iZ1GIjexbYv1c+di3KH5QF890avf4fdw5oTXzdqn5wDAlS6IduYHMsgrDR?=
 =?iso-8859-1?Q?+Xkq7r83+Dv963tYg1zAMwTBAXL+xwvId3QRxC0jyz2nbBtuBYbQcUCS5X?=
 =?iso-8859-1?Q?CpStOzBeIdDtR/Hr1M2GkdHNMaeLcyGdl0G0fFDVltXFkuE25aZ3uG7w7A?=
 =?iso-8859-1?Q?WZzSH12/KWbdmj+uL7RS+u3LPJJp+uuWOzT/U9zRjSda9es80YFQ+QiOg9?=
 =?iso-8859-1?Q?t5omQOPB6Pr2fmVrjnrl1pcwkzvRvcXG3l6s7voz6mWWAC5ZDUKRxhpuG5?=
 =?iso-8859-1?Q?XA4K0OlR1zPBacZUO/6VLglqrn+2TcwK23munUXl3IiBp9VdNSpj04I3kQ?=
 =?iso-8859-1?Q?BEfXf9q7CYc9WOlWa5bpdDASD5osBwVxMpw7p2Lj5etMB1T0RA5YZvsg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: skidata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3751ab7-7aae-4758-3894-08dc7596710f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 10:53:38.1909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5733095-4425-4f08-b6ba-487b9a46a425
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOB5bmmbtTS8sZA74UyNZ4ij9bcjaOlJQK5vbma8SsAVqF29HPFT9NmC6SDOyzLSEAHFWq6/5HSa1oplZvmFVY2bkPaNagkVdbPjFkDW7L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1141
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

Hello S=E9bastien,

missed that because was testing on v2024.4.
And did not think about looking at master branch because it seemed to be br=
oken for quite a while.

Anyways, thanks for the quick response and for fixing this thing.

Best regards

-----Urspr=FCngliche Nachricht-----
Von: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>
Gesendet: Mittwoch, 15. Mai 2024 18:53
An: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>; u-boot@l=
ists.denx.de
Cc: joe.hershberger@ni.com; rfried.dev@gmail.com
Betreff: Re: [NFS] fetching kernel via nfs

[Sie erhalten nicht h=E4ufig E-Mails von sebastien.szymanski@armadeus.com. =
Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka=
.ms/LearnAboutSenderIdentification ]

EXTERNAL EMAIL


Hello,

On 5/15/24 14:40, Johannes Kirchmair - SKIDATA wrote:
> Dear u-boot people,
>
> I encountered some problems trying to fetch the Linux kernel via nfs (v3)=
.
> One problem was that the nfs file lookup always returned NFS3ERR_BADHANDL=
E.

I have fixed this. See:

https://source.denx.de/u-boot/u-boot/-/commit/d2986567b27dae764b19886bcda1d=
24b7c41d075

Regards,

> This is due to the following line in nfs_lookup_req() function (net/nfs.c=
):
>
>               len =3D (uint32_t *)p - (uint32_t *)&(data[0]);
>               rpc_req(PROG_NFS, NFS_LOOKUP, data, len);
>       } else {  /* NFS_V3 */
>               *p++ =3D htonl(NFS_FHSIZE);       /* Dir handle length */  =
  <=3D=3D=3D=3D=3D  this line
>               memcpy(p, dirfh, NFS_FHSIZE);
>               p +=3D (NFS_FHSIZE / 4);
>               *p++ =3D htonl(fnamelen);
>
> In the NFS_V3 case we add the dir file handle  size to data and then the =
dir file handle.
> IUC, this is not correct here because dirfh includes already the size of =
the handle in the first 4 bytes.
> Feel free to correct me if I am wrong.
>
> As a result, if I remove the line "*p++ =3D htonl(NFS_FHSIZE);", it works=
 fine.
>
> Don't have an in deps understanding of nfs, so I am not sure if this is t=
he root problem here.
>
> Best regards Johannes

--
S=E9bastien Szymanski, Armadeus Systems
Software engineer

