Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADD8C0218B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 17:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7021E801FB;
	Tue, 21 Jan 2025 18:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hilti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hilti.com header.i=@hilti.com header.b="juo9cB3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C9D80283; Tue, 21 Jan 2025 18:47:40 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2232.outbound.protection.outlook.com [104.47.51.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF51801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 18:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hilti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Klaus.Rosenschild@hilti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoITwVHKuhxKaGf2T4M50tumh8EVoIaGyP0rwwrJKgf/NJAb42A0tGiPbVwc/MwyL0xw9sJUdprMhR3Y/lYc5pvXaJ9qRQBW0GL6hIHeQHpMu6CO32s6HAZqN0osyZBoHioMjehIV1W0stFe067RJLcw9m/u7prvPTZqA0ZW6FGMKPyD/xok61Aaa3P9RAVGIwgXL3gVKSp4DBmT5ugMthFs43cAF4HG46XhPPxh/2VQ4cZu4umRd+Z8ACHWK7LTXw8siwJMbb2LzlzqFmnyvbmuO8p7FBtCxglS14RXjjBQqex4OyybuGLbIzZV0W8co9ng3iRbJbc8tICtCZZ6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+80iuLiPMV7BP7gdWNJ46irL0B3fKvfoIkziR64IUY=;
 b=GuCaZvh8Hp3Mms8T/KwhUh1+fG0jp6tg5jndYBeXzAmN0nBjR2CWLe2y+seKFsmDvA4Ha2u/uGqW/YyjmkKom7jPy7LoCPu2lgDoY+mTkOHLxpfc5nXOgDNW05tq0PUzpaGrQ1lUU//s87hZOu9paIwbqzA1ySV0YsTtULE7WAh9j24nDC3FdiOi+6J1H9tftl/eWRSRRiFi/IGy0xdvGFbJwaEtpaKg6/OCBE+XGFvAQDXEIKzby0wecLvPZGH0hABlHyv1A/1ni99rtBkknur4VojnWDiYC/GcEWN35sFWEB+US9T2s5Ox2xQZOnQ2chYlIO+93qSveKlhA3L9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hilti.com; dmarc=pass action=none header.from=hilti.com;
 dkim=pass header.d=hilti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hilti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+80iuLiPMV7BP7gdWNJ46irL0B3fKvfoIkziR64IUY=;
 b=juo9cB3sV/HLQHrAIIMsr0nmRti9nBr44UtVQDnG0f5Iz8fy7ypXuLEYnQZrjXEiBT++5y4n6l4dJStRGIPCtxGyZ6rNjxy2ZL0cFKmQE2t6LabWyezODt07RKezeX2AWSRwSQ1rz/ToC68Ml5vaX2FWA08JJFheBmC6/GwwbIlfOpIUL/pKhWoxDCDjQ2w21ek4OQJ3uyjn8pryzNexfUOCB5dgHcClKff2KOExHj/SPm2ewmUzZE+fj9HtdMuhJNMy0ooF8WiFT0vHPqwPbENevkDxJTYEs+GYVkjgkbeQLI6opknXlxt/mRozLHCjWjREj7WzFY0q/zzDFZnrlw==
Received: from VI1PR07MB9972.eurprd07.prod.outlook.com (2603:10a6:800:1e2::5)
 by DU0PR07MB8570.eurprd07.prod.outlook.com (2603:10a6:10:321::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 17:47:36 +0000
Received: from VI1PR07MB9972.eurprd07.prod.outlook.com
 ([fe80::46ff:ad29:1ba0:a265]) by VI1PR07MB9972.eurprd07.prod.outlook.com
 ([fe80::46ff:ad29:1ba0:a265%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 17:47:36 +0000
From: "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com>
To: Rasmus Villemoes <ravi@prevas.dk>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: AW: secure boot, mkimage with external signing server
Thread-Topic: secure boot, mkimage with external signing server
Thread-Index: AQHba2LLLJFSbeH4Sk+XJjDH8Ca4K7Mg9wgmgACKxGY=
Date: Tue, 21 Jan 2025 17:47:36 +0000
Message-ID: <VI1PR07MB9972862970EB6D315D4279C4F7E62@VI1PR07MB9972.eurprd07.prod.outlook.com>
References: <VI1PR07MB9972394B8A364AC9A18495F6F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972E22550B1514AD604D399F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972D12CDEDF3ADFF7D81B2AF7E72@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <878qr4wm5o.fsf@prevas.dk>
In-Reply-To: <878qr4wm5o.fsf@prevas.dk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hilti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB9972:EE_|DU0PR07MB8570:EE_
x-ms-office365-filtering-correlation-id: 15d648e8-b528-4f63-cec8-08dd3a43b0ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GkUB4Dd8e0dX7cZtqhoZ/LlkqduqmcEHWsi2sr2WNs8DEiuuWtFec6busYKA?=
 =?us-ascii?Q?nqS2LfyF/+ylQK9NfnKw5kNTXX5w+u32vFbA68BqjRdePgf487rTcych0FUe?=
 =?us-ascii?Q?7lucgMr3BIWQuRog3QlNzw+UOsVbKahxSkuXMz758owD7tLZo8+RUKpTYUja?=
 =?us-ascii?Q?dVFKaegBvWbc1J12DyIbWWeKGlkwdDEP1cQmGBoRikHOLRGZ8qvR2n7Ocwcl?=
 =?us-ascii?Q?bjR2uh9CEYxKIcyk0W6Nu9rOaXakFtg5TE8BWFci/KL/p6zshnZ7eznp+ocf?=
 =?us-ascii?Q?2WjHdj/XKhrLvGBpVSEkuEnCx6tNrYQu7Z6qwJk6BO5mN1uJj2wFG0Sl4NrI?=
 =?us-ascii?Q?skGJMD/Kbf/tNcXnG1YoYxV+v9EnfjIt++fTFJNVxbX8dud58Mm7LcmqeY5Q?=
 =?us-ascii?Q?mv2muB6WeVbZi9H5Up6Zpg+USzNoOZdl5OJDMqhXqJkaXjlPPyLnXIwYY5T5?=
 =?us-ascii?Q?OE9Xo2CKBik5o2i5T6zwWIePZEffTz0EqIVOUI0gh6BF+yMDsD07pVVVnojW?=
 =?us-ascii?Q?h2UrmhBqjXAcAayVrZg+RAZNlZAF3BPDr5CpPNfP9jPEugfBPoy8M7yABMtC?=
 =?us-ascii?Q?+lNHFWWIe7s9/5C4XDLx4nYGPe56CSnSQ2lcJf/pMz93NyBKhMIvPvysMKVv?=
 =?us-ascii?Q?sEFTCB7tNgiRWebE/DlCz1/OINTYW1hlQFYIkuDGuQ1c4Ct5/ooqEn5gR4G8?=
 =?us-ascii?Q?DpMkrwDdFX1J6p3g1DB39djpnWabrg7jpVOKcJvT57T5V4ED9uaGjcVXBSFY?=
 =?us-ascii?Q?kdfQOQG2Sy2OLKhYcCP4L73rS0NYu3zXSirCKbYJQmxtapu36+vDDy9+152Z?=
 =?us-ascii?Q?vgUFqrbgx4NvIsFQGFdcSadntUmm2BC0dqxyXXasakftyu8aqF21fCaeON7j?=
 =?us-ascii?Q?B4NdCnz06p56Cken4qAx+A1HwOZHdio/oRkT3jY+yFo/bx8XcMs0otEXr/dV?=
 =?us-ascii?Q?nNtyS8Q6KjlBxohzwCCslL4dfsogx1T/dU0VL0+w3aI/9WewnfIliFvzgL0T?=
 =?us-ascii?Q?bJOOT0m+y8/KuHzjH0mEfGpYG+mt5NC96IO6pRo9UOGFphu3yOwUzUcZ6rrw?=
 =?us-ascii?Q?//2fSX29BfexMC+yCiub8CWr6IlurWRx3Ed+dTwwjxyIhc63qoWxk8kDahaK?=
 =?us-ascii?Q?a6GwECye9bS3YXgOyhAJHVUmRB9l090CbkFFke0zn/S4FMOcHucJhJJC8lh7?=
 =?us-ascii?Q?DIlipPLvnXoowIUEP6+NSYt1Ir6wFK1TaMLKTNiFkVwh7Q2CVU6ps98rMeEd?=
 =?us-ascii?Q?Y+9h9TI/TOdEhu2lq2DVOkMdiUIFb+vWWuEMdhr9mLbcPWphwalvjpzPAkxU?=
 =?us-ascii?Q?JKrf8XvA5LqCtDUlwvbXmCr5lf+Ds3jVvfgNeVoKv4gq9F4S16INAw/8pIfF?=
 =?us-ascii?Q?lLn3O2jlfiv1gMmg0bV3JdWBtlN3pCxRWxtl7SSdn4Ont7DFp0W2IWqJ3OYF?=
 =?us-ascii?Q?d4A7CvaDOhsrtKDFEM801mz+iXbD9TCm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9972.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ePqM+B8+IeMUnnDs77CUMBYCMxq/IHZoW+dG/WyQF7p+9YOwpJEofvJ3JTe5?=
 =?us-ascii?Q?bbPKQM+5AmIBInxpqtgb02ejWGVSON+IGMyxTQXb2D8548W26ofD9MGQjAXB?=
 =?us-ascii?Q?rGSuFK92/HoCcxeP8Ee5NyehEkFpcA45MZAcxQF3lyWvPojK33fy+QqWkB5E?=
 =?us-ascii?Q?A6GO2VQ+I1ssnGBId6jlgP1olsRYWuzaT7RiOs+R41QFBHQlqH9jGUkuwnUN?=
 =?us-ascii?Q?Rpeu+E5iSTWIaHjtffVevpxtwoI6/tK9JL1j9EtjdKE8+Q7K5pNX+1ZBmE1f?=
 =?us-ascii?Q?S3sEPF/lcKC/oOdaG0zu1tWMqlok/CGASJgvMYknzcWXZe6c2okiCx5XVRKz?=
 =?us-ascii?Q?x1VEPs977CBUPm9JgjiXbC7IVc9PC/TD0Bm5KVjzf7gISndAtwSR/dzeRxpG?=
 =?us-ascii?Q?ViG8zy0EljCE1fuZ08IaX2Ts47VA6sgda4zCPCYgEjucqOBzyCy+jPDBn9tS?=
 =?us-ascii?Q?GX6hmFAqsvm/RT62gibO0+WQiADAnDoe3esXEEXv63/mTyDgYnJYCfKkyxyB?=
 =?us-ascii?Q?0bOo2B4Hsy1TfneuBvvszI5TuZUxyAw13siiiZgajRAyhXT2oNcpoBXt8kkb?=
 =?us-ascii?Q?XmTtkOs/pzHKahxi2elxCCT/nPaX44DZEK4H2JSZS336iUtq9qrt0Is9InwO?=
 =?us-ascii?Q?tK5kDE8EVzNJDqXGgNO63GxVuSAh+4lC9Lk9qkGfy2SPXOkN9la1o+VEo34x?=
 =?us-ascii?Q?6O0amjI6auWRJ1s9w6ZeVHmAQF8MmrFImN5I4PLJ22a/4xk499vzIWupz+ND?=
 =?us-ascii?Q?Y85R6rA+fzh3lLaArt/2VxPAS+OTEWUVccCyPb+cnfpo6VjAwiCSWwBvD8D/?=
 =?us-ascii?Q?WX+RgRGqEvjR3qTWrTCxOZ+eWmpqDJr5dMaeVbj5KQWuduOiuFcAXFI3z5sd?=
 =?us-ascii?Q?Abhkeont9zvi0repDrPzp7zUi9m3qSXTwOu1HldRgUtocpaAPQj0IWUgJai6?=
 =?us-ascii?Q?j9o0TKQ1cuIbOqLDlG6HsymKnDVl9Yduk+ujsOch0RNJYlVT/X+CWNYlaDRE?=
 =?us-ascii?Q?IGUodleJlfVODqWCUjbNRX7bIv6bmd/i4afe7E7mqsJDfgrmYz0YMtvPvQfm?=
 =?us-ascii?Q?DRnNrHS+h/R6bnA7oAhCMK5xjpqJQ413GKLdT7qDjUZ7wngZOQzfbSuGyV4O?=
 =?us-ascii?Q?FTE13GZkdmvTDtRuv3XLvXAxUUFCXco8SNpHmbJBzG900mXA5Mo7BZmD9sk2?=
 =?us-ascii?Q?pPAx+kQ/LNBadHhnJOpNU2T+n+3EkxzUdbrp1QtnCuuxebxmHvEcWSNvCD1w?=
 =?us-ascii?Q?oxJ6RzXU1L6RN6Ku9FAbbpYbxdtPsdxa5pPMRZreDajIBFQujuE3MkBhcNkm?=
 =?us-ascii?Q?inJNgoyKpM2sd/v1QnSLvT1xakHy6I7bLzqB+FwwARjqpklD+sptk00l5ccg?=
 =?us-ascii?Q?FB5WZr4y6TxEviCV8S9ACCRK0RVPe8mBywL9k21wCvMGl//bgnN65q1rwblC?=
 =?us-ascii?Q?eyq8spMT9rXvxjTp9kzWJ30UsHHsr/Gmnp3WZYtR0FoY88GnB8PpUWJZsqe0?=
 =?us-ascii?Q?FDK6AzSUL2TRffrfR8K0S6V2SMPHG181q8SSx3Xqf+0acLCerrt/ZnB4kSTF?=
 =?us-ascii?Q?5nhNo5I/U2iFtxJqV9c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hilti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9972.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d648e8-b528-4f63-cec8-08dd3a43b0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 17:47:36.1662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f039b656-fc02-4e54-88ba-82626f29b5a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8do9HgJPc5bGwD5KMSxzsUxfqOlw5eueU9H4eC03Z73E8dV/L8SMxbNzORi5mz/uyH6yYCrzA+O7MtnrCkFlpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8570
X-Mailman-Approved-At: Tue, 21 Jan 2025 18:58:11 +0100
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

Hi Rasmus,
thank you for pointing to this option. We will also check on this option.

Best Regards
Klaus
________________________________
Von: Rasmus Villemoes <ravi@prevas.dk>
Gesendet: Dienstag, 21. Januar 2025 10:28
An: Rosenschild, Klaus <Klaus.Rosenschild@hilti.com>
Cc: u-boot@lists.denx.de <u-boot@lists.denx.de>
Betreff: Re: secure boot, mkimage with external signing server

CAUTION: This email originated from outside of Hilti. Do not click links or=
 open attachments unless you can confirm the sender and know the content is=
 safe.


On Mon, Jan 20 2025, "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com> wro=
te:

> Hello,
> I have a question regarding the signing of a FIT image using mkimage. I a=
lready contacted DENX, they referred me to this mailing list.
>
> mkimage supports the creation of a signed FIT image. To do this, we need =
to have an appropriate .its file and pass the private key as a parameter to=
 the mkimage command:
> mkimage -f fitImage-sign.its -k keys/  fitImage-signed
>
> However, this approach does not work in our setup, as we do not have acce=
ss to the private key.
> The private key resides on an HSM (Hardware security module) that is not =
directly accessible for us. We can invoke signing related functions via an =
external signing server that takes a sha256 hash as input and returns the s=
igned hash.
> Then we need to add the signed hash to the FIT image.
>

You may want to look into using an openssl pkcs11 module interfacing
with that HSM. Then use appropriate openssl configuration (set
OPENSSL_CONF env variable) and pass "-N pkcs11" and "-G <some pkcs11
URI>" to mkimage. This is something we've done in a number of cases with
a Yubi HSM.

Rasmus
