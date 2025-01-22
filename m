Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF14EC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DA3801B0;
	Thu, 23 Jan 2025 14:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hilti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hilti.com header.i=@hilti.com header.b="wFRryz4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B40801B0; Wed, 22 Jan 2025 22:14:05 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8298001F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hilti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Klaus.Rosenschild@hilti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkFUlloU3QWz9lse1qi6VnmCQEQHaBJ0jDF5DE19voDDKFqNGSqpAshqlO9o3gZaDVnQEsNZnOy170FAPL1drlp2eLibGR3B0h+DS0rYEvjZyV3uwCk8LU+FwgM6hwtIWw61Twxwnaah14Ofz9KimyKG9Hb0XaikZ0jbFuFjNPLGCEQ09YrVSflWDvpvdLlX9lVkYzNPfuGC2jds0mq9xq8kr6VsHgLN44t4zbdVZxOK1fHtkNdy+pYPjqf5W2aG0/g/xAhCgiO3Kr8732+Ug3rbjJS5kJy1jkhOdR9u/KU+kD7hpiVAfw+1K4lVuZdQkttMStuR7eRbVPOevnPFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8zu89WSZ22HSIPHYBBlhpxchhQWr/udxG1WaiUkU2Y=;
 b=ek0+9APWAE9MkBUoK0sK89TRyulkr8k3Ln6h2TXj/rDM4pL/n34dUd+zJreU5xNOjvfe/zBBDb7LWCDFmanb3dH/bFCt9iBvMgo3ZXvLi6ZRzakiOsja9OnbO61yJ9wpuUgBZsxIMFIqlShJOeidT5v1zEvUi+EhKimuwTV8XixiZ1Hxb7hxn6LS1M491bDlXhR/IUG1cMjyvkCZ/9sMVawguZ6p1MsOfLFyw/GLNckWuSFX+Q51+FGU2zsUfCcLuYon5h1IODQzxrPzIrbsevlET1P53rNSkjFmXJwhs75DfCx4NMNfVrcK4raND1zMmec9mjJLFGDEhd6hXoTAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hilti.com; dmarc=pass action=none header.from=hilti.com;
 dkim=pass header.d=hilti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hilti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8zu89WSZ22HSIPHYBBlhpxchhQWr/udxG1WaiUkU2Y=;
 b=wFRryz4FB67iCPxzmuriEzls6d6XQpDXTKM8tI+Pc/Z0Zxpf9e2hhjkhSv6FxIkeewmYuH3uEB13L+ZDpI2oniD+AP3UCQfSHCOWYrTp11AHAg3qa6uWoxxJE82BJXER3gKqAN28ktf+bf1lIOENEOelZRH+Aiq7H1HbI0CXHTK0usvjbN9RB7x8vKLII03VpzpCcgCVEB9zlYmPxm915rjFWnceYiYqhYBpgrMfyAXF7ShhguxfL8mpueo77ctzOkuh0xj+JEvLEPSKzhKPXirB5RuI7t8KaSZ7uEGk4rKNw77eLN7mbkUtCsgX2iWbxgLWk5nt4Az+vD9WhfNRbw==
Received: from VI1PR07MB9972.eurprd07.prod.outlook.com (2603:10a6:800:1e2::5)
 by AM9PR07MB7924.eurprd07.prod.outlook.com (2603:10a6:20b:30c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 21:13:56 +0000
Received: from VI1PR07MB9972.eurprd07.prod.outlook.com
 ([fe80::46ff:ad29:1ba0:a265]) by VI1PR07MB9972.eurprd07.prod.outlook.com
 ([fe80::46ff:ad29:1ba0:a265%3]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 21:13:56 +0000
From: "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com>
To: Rasmus Villemoes <ravi@prevas.dk>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: AW: secure boot, mkimage with external signing server
Thread-Topic: secure boot, mkimage with external signing server
Thread-Index: AQHba2LLLJFSbeH4Sk+XJjDH8Ca4K7Mg9wgmgAJMDsM=
Date: Wed, 22 Jan 2025 21:13:56 +0000
Message-ID: <VI1PR07MB997209D177C705DD5371F0D6F7E12@VI1PR07MB9972.eurprd07.prod.outlook.com>
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
x-ms-traffictypediagnostic: VI1PR07MB9972:EE_|AM9PR07MB7924:EE_
x-ms-office365-filtering-correlation-id: d11fadde-f235-436f-74fd-08dd3b29ae63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bbrvPPSy3dsFqMZPoPhbXaOBtn5pbqPUp3Ur1fWRQ/U6iR1YBCnCl36cHw?=
 =?iso-8859-1?Q?SWa6WsI+S+dlbIyY/Sa1ZTVOt3KuOmQvGYT5DdVM+gisPNm4InH613IYq6?=
 =?iso-8859-1?Q?H/xbAuLOBTZ3bBNvarsYWEdlbe8qcclkls0FPNJRugDpIPhEPHf+ldVkDR?=
 =?iso-8859-1?Q?z2To7R35jx07BeotNKslvDBVFsZjwmVkhkmCVAdgQ+BWuuw4NzmdPLdJrz?=
 =?iso-8859-1?Q?EXuSaoKAxMhQ4R9B+Erp4Cj+poBUgrIUovM+a8CQtA4m/Beg1mZGSUG6p8?=
 =?iso-8859-1?Q?m4MGw/t+BEwgx3p47cCNsg68sNRrZjxy9KpW9ovwSQlda/lJZhlFkNNXxH?=
 =?iso-8859-1?Q?+MyUAJ6S38mxTZ4EUMbcGmrFKRWmBAQZYu3pSO0ir+jF9TwwKhww/js8lc?=
 =?iso-8859-1?Q?7lMfliZ1+/m4pUTYjX39FPdn02jrRvQdxNHzkMT09s+OBaAh6BU8mLEzQI?=
 =?iso-8859-1?Q?4a14XRmpsZHXj/N6FlkcED7GMfWwabt4XvaB85ya/GThexSBup2y79czQ4?=
 =?iso-8859-1?Q?O1heuqyl0+1blmTPhvgKG+8z+RzDcv+BzaV1v4+YfgwUapsqWw2znYc+JE?=
 =?iso-8859-1?Q?wJ2mQAIrJQE0jzqcNu0sylLTW/nHp48mThb5A+Jn2HP9JXFfp5GFxtK0CY?=
 =?iso-8859-1?Q?pSyZrk1l44+t6AKk1i6KVGsNs+mmlgVVocmVf/+r/P57Q3c31MG/TcgTd6?=
 =?iso-8859-1?Q?Ya8fcHRSSASYC9oTZQEolXuwo7Fs68FyKrMUeK8OPj6dfuP01ny0N55zyV?=
 =?iso-8859-1?Q?Nxd+scFovFk82/AQI9vg/jrGkUXdv+5BT5LNBn8yEvxwNOl0zCHnGuyOLC?=
 =?iso-8859-1?Q?Uxpya7F6DpQh8jrcU34F2u/pmdex56FkFTRtkqp7gCr64C5RhLOHo5uQ9N?=
 =?iso-8859-1?Q?1jjYJDBeio0m91G4Xx1RDNY4kPT6NnKxObCY5lRbIC2KNURlHmY/M7JmoN?=
 =?iso-8859-1?Q?bD6yTsfEm2LTo39zZ/GHh/CpkJ1MbK6MMQpB9h5MMoH1uC8nCxAjfJlNQL?=
 =?iso-8859-1?Q?DJDzrU6XJ8u9B6Kxksdq8pKnKoD7sAZFzyaALdC8Lq+DfNN2hd5y8cxmpa?=
 =?iso-8859-1?Q?sPD4ZoRHSPVp4h6vMegWR5GGSnrjqzSMMuZmbuMWTHsuGHLlWEbbfRBIwT?=
 =?iso-8859-1?Q?N75UPqOi/dG6NSP1k8QUsHKAz2wLxNc8x5h9raKTcdA3ObqHIh8VSt/tov?=
 =?iso-8859-1?Q?ohgVW9OWcVqSdfDIDNhXUC4KtNigXp1F63ApcAbuj1KvSohQ4ZHfwqlc9x?=
 =?iso-8859-1?Q?GeMfxnlCAFDB+FCV4JGFXtMuQXAlDZ/GlFnZLmmYwCkAMyfYczHUDBRbLh?=
 =?iso-8859-1?Q?lKh1cqI6/QBUlPqkcZ7DAcct/5Rub9hI1L/kvwTuGmaZc8Sj18bAsSZ//D?=
 =?iso-8859-1?Q?yd1OmmxxpspeWXfos8gmSIS5IzAZypgjJgOD9hYjCm3LPJzS8U0yiNCzKK?=
 =?iso-8859-1?Q?+PumvPm7diezzFUg+dBh6gxztdTLVnF2fryA3k6DePp2nvvV/3C6Yup5/P?=
 =?iso-8859-1?Q?DApuL9xcLH5wKY6ALE0XKD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9972.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fuithW2CKz8jmSCNAKKmvUgG/7UyhSjGXkm0cHccYpdj97OKSoo5px2n4a?=
 =?iso-8859-1?Q?b9GnEgTWk4RljQj17f9SY8YyciWRr0bx+4RfssGCM6JS1ZdEKiotEUkeNT?=
 =?iso-8859-1?Q?4OiZbtnFnOjWPo6HWpAMsTXmUG8GbPEZGKVsDaccEHDUXoN8QaUv6nCgBH?=
 =?iso-8859-1?Q?XiIHeWUmBUgmJ7cZ6/9M8owoQcRLJ14BDXdeXyfpLZs41aLUOFS5QaJstL?=
 =?iso-8859-1?Q?hMkOZ9hz/gzb4CSEtqPz2D15vOACiEed9UtvppDgGdwIh6kReMPa6lsEOU?=
 =?iso-8859-1?Q?UI+Y1OxnO1OXMT0deEVCqQfD9WA7PChPuB5I/vCTRbbB1gD3xJ0zpnAiB2?=
 =?iso-8859-1?Q?19NhPLVvTc9VuWqWlk2Hy3J71UWAE3kV9qXdF7E08a1/o0XbQ1rMvvMqfw?=
 =?iso-8859-1?Q?1B1eASFFbvtZZky/v8geXVIazecNmCpny2L2bTokogDRfVjKbaaVls3ZcQ?=
 =?iso-8859-1?Q?CQmDCOKYERu2vaBsIpzo3qhi/u1h4FDSEaxv0urTkGmfhdpg5GOOPRDNRM?=
 =?iso-8859-1?Q?1zktC10tEcu5z+tcQLPzamYBo2hfvJRUdWG/9pNDIjFBu5I7l0oXNqV3Cu?=
 =?iso-8859-1?Q?Ov1ruq01GGxKhRFTVproQYWkDyA9pcFbRLmq4guCi/4wLcqZBxfk3drsua?=
 =?iso-8859-1?Q?lRQHCSckP6v1ujVoBvWSxzdT5UiVzS5QU2s6VNuJ97tbdYLfWxyVfwphji?=
 =?iso-8859-1?Q?sTn8qqbFI1iXhwsXlcX2J6NDZOt7tpd7dKqwB71h+2geoA9xmnA2VenI5g?=
 =?iso-8859-1?Q?NnFqYavJPNMsHHJZzpH4pA4ET76JyRmhPiZuA6VFahaKaqag7yXWxHjPOE?=
 =?iso-8859-1?Q?UGPvR8C0C5FCUZKzrwIxNFqNz/+Pnqe7lihjKmZsVu6Twm4tA/TnKxqJJO?=
 =?iso-8859-1?Q?mOMkAlXQyRrzq2732XAkpk1E/UO+Joo7gp/XO3gai693ILAp3yqrRQVKE4?=
 =?iso-8859-1?Q?vbNZ8WHokPSBcwClL0qyOyX8XSYWmRBbeVz7T+zaI7YPxbEwDDaLowa1lz?=
 =?iso-8859-1?Q?GF4lPX0j2cse1CRfQ8URCzEmkHIkXZ1un4B6RKSEv0r9ksZgCvmNhkZPdm?=
 =?iso-8859-1?Q?4sWAKm1qB+uPNgIvVuYOsuvKzOsTobMvDITA19VBO60/RSdABZ4VpH4lrT?=
 =?iso-8859-1?Q?xcaHqd6A48P6mA4SBfBbbJ/5FMdmzm7g6pVO/4C9gowGRRSQAcSK4GhNFg?=
 =?iso-8859-1?Q?Y/4pX24tAtsd03X7KOoFJYldwVzQ153Gaw0L7ATrtxAZ4KF1BaR8bKAU6D?=
 =?iso-8859-1?Q?SgLGh7ooIWV7WysuuydupU9diCtNsT41QjDF3NH5zfD+Exyqd5Fmxmi5Sf?=
 =?iso-8859-1?Q?D8p4pWOg9O2Q7Z/Z48GKrgyLDiub6fNswATFNDA35PXWhvu0N+yuxbXcMQ?=
 =?iso-8859-1?Q?Z6V29q5IVzCqMZXte3E6RiOW/jDQe1258phgHJCmN5zCN4GDfFehzYkjuO?=
 =?iso-8859-1?Q?x/0FjSAzPd+RuzLg5AcIp2/etgmpDH3Vek7/vwPu8pSFGtnKtLm5r7I6PF?=
 =?iso-8859-1?Q?euIH8jPxb7oG8AKVjcirkTY90QTyn+BfRepU7bD+8CEwXQYOtlYzoLLmsL?=
 =?iso-8859-1?Q?hL/nxOxtTiZuy3LF59VSE7/3+uq4tJ1LmLsAm/1le1qxfEfnXPsmox8Wwj?=
 =?iso-8859-1?Q?IboLk4d0G2pCA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hilti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9972.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11fadde-f235-436f-74fd-08dd3b29ae63
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 21:13:56.1613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f039b656-fc02-4e54-88ba-82626f29b5a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgQz4x42oDAXB85k0NTYctETiOBGL2GMJjYewdEvKtgV7e8kLvbsly4650iYXXJ2+TiUw1dE0YNflu48jFgJ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7924
X-Mailman-Approved-At: Thu, 23 Jan 2025 14:01:27 +0100
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

Hi Rasmus,
thank you for pointing to this solution.
I think this is the best way to do this.

However, our signing server is very well protected and making changes there=
 is a long and complex process.
Right now, it only provides the following two functions:

  1.
generation of a signature of a sha256 hash using the private key
  2.
providing the public key, the pure key, not the certificate

I found a workaround to determine the hash that mkimage uses to create the =
signature of the configuration without re-implementing the internal algorit=
hm that mkimage uses:

  1.
create a temporary rsa private and public key
  2.
run mkimage to create a FIT image with signature: mkimage -k keys-f fitImag=
e-sign-orig.its -r fitImage-sign
  3.
extract the signature from the FIT image
  4.
re-generate the hash from the signature and the public key: openssl pkeyutl=
 -verifyrecover -in signFile.hash.sign.bin -pubin -inkey ../keys/build.pub =
-asn1parse
  5.
now, I can send the hash to the signing server, get the correct signature b=
ack and re-enter it into the FIT image (e.g. via python libfdt)

However, there is now another problem. I also need to put the public key in=
to the device tree file. So, I have to run a slightly different mkimage com=
mand (with  -K option):
mkimage -k keys -f fitImage-sign-orig.its -r -K bcm2711-rpi-4-b.dtb fitImag=
e-sign

However, the -K options requires a certificate and not just the public. But=
 as described above, I only have the public key. For the certificate, I als=
o need to have private key of the signing server (which I do not have).
I also do not see the security gain that a certificate would bring here.

So, my question is. Is there a way to make mkimage access the public key ra=
ther than the certification (dumping fdt does not look like it stores certi=
ficate data).
Is there is simple way to replace the public key in a device tree file?

Any help is very much appreciated. Thanks a lot in advance.

Best Regards
Klaus



________________________________
Von: Rasmus Villemoes
Gesendet: Dienstag, 21. Januar 2025 10:28
Bis: Rosenschild, Klaus
Cc: u-boot@lists.denx.de
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
