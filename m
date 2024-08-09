Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171BFC3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 05:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0D388835;
	Sat, 10 Aug 2024 07:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bt.com header.i=@bt.com header.b="cM6YHLev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA86889B8; Fri,  9 Aug 2024 17:21:41 +0200 (CEST)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:261a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DB588BA5
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.gymer@bt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpzMBH0ckhDx/wGb0B0PKQ1blNopvzyePzdNsBiSKTo9sWJfiOnX4O26i2uo8MXRQ3V8nIW0PFrzSUWmE/vhtX0Fl7O/zSitGx20UGbrJi3coOevRdVz83HmdZrbYLxnsDlTNKg8uvH9n+wfOUra+imXOmZ4FdESG6eSmQOgG3jIKn45Q7leT2oQN8ry4AQwuWdim0VRpgLUBKfJhqY1/s2NcNOd5RE29PeBVQ8kgpk9+X/m4bBgZGQ+3VXFDL8txEQLor3UXV3mrtotHrazO3KKHnSq1Ju115HEMOFomQSHc58OiVZWFCSGvg289OM+3aka9fPnkfP0IijCGZw5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLdXvO1Gc+cd2hrY+6U82hldYFuDp71b0VGMoO3P7hA=;
 b=r47Wgsb6igPsrIsrUMkQf7Daq1YYuftqwqCxXGc9HRteIUhOwJ+e7t67aKxhnXuykyThbHfr0pnUrmOIvhHdFHLIKqgpdAskryFFOxTLe+i2tq2PIuZietaUivW0cBFfgnRqGR6Jiyd7eEXd+cEZ7X+aNpbyaCQPiNqnKdc3BqF697IAQFnjkZFJckeUj/xl69mzuwiSbwyq6y1nWutwKS3cbncPuZBvJYxqaZbxNziW7YG71eX/M6OJ3PPWKSq7QJi+IKjmsP9bxJjqj/L6lFFAL9iVuijUkb0krzQOa54aKgshuOn9xmGxh50/+mA1i6zOI7Ex5DT3UTAhX/NIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLdXvO1Gc+cd2hrY+6U82hldYFuDp71b0VGMoO3P7hA=;
 b=cM6YHLevPj1ggcCCO57Nk32srOZDJwwh4PSP/7sTE/1yx7XUGkG1QmKzhts04c7Bv7eJD+ytvBNxbXPw65Ju/OYLI2b+KCaBb2o6Yaac7gidddz2M4UHruxOahf1vG8k9gziFcCIdA3tIPtJojP4Xr++4fbneu8EhB9+25bptsU=
Received: from CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ce::9)
 by CWXP123MB3192.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 15:21:37 +0000
Received: from CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM
 ([fe80::25b6:6ef3:9fee:9774]) by CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM
 ([fe80::25b6:6ef3:9fee:9774%7]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 15:21:37 +0000
From: <thomas.gymer@bt.com>
To: <u-boot@lists.denx.de>, <op-tee@lists.trustedfirmware.org>
Subject: Verified Boot through U-Boot for RPi3 with OP-TEE
Thread-Topic: Verified Boot through U-Boot for RPi3 with OP-TEE
Thread-Index: AQHa6m2WCHm35w9KlEuyOXmtB3kzHw==
Date: Fri, 9 Aug 2024 15:21:37 +0000
Message-ID: <CWLP123MB63935507882C09545073EA17E5BA2@CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Enabled=True;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SiteId=a7f35688-9c00-4d5e-ba41-29f146377ab0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SetDate=2024-08-09T15:21:37.033Z;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Name=General;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_ContentBits=0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP123MB6393:EE_|CWXP123MB3192:EE_
x-ms-office365-filtering-correlation-id: fb09dcd9-bbeb-4ed1-791b-08dcb886f632
x-antispam-2: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7093399012|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1XUxnV2ztc+ExemmS6XTumBAWYCFDYWfTt/DD+oFr7EllAdo+NwojSKmn6?=
 =?iso-8859-1?Q?5KfHpE1CoONXXhkn/LtMrSUQhJ4pv/h9zdwsIuXqT28iQNMxOpoCz5LD/U?=
 =?iso-8859-1?Q?JC85achQ/9P03LwTyFk1onjCP3q7Zua9LmN/nuP+o8+syr5PpQZQKjS41Z?=
 =?iso-8859-1?Q?f/xyP8kkqR1Xn4FSN6ScW9bQbeLWpuYxgV+QeG+eQoO3g+rhQyfRsZjWqc?=
 =?iso-8859-1?Q?u/2Gv2mwENo0rGRDTW3vvN41P7HE+PSGtMoj52kCNkyENGLYlLMS3DLC6B?=
 =?iso-8859-1?Q?NWq0UGCx9DOkhzsS4bKenIzWqA5W0T+rlUouwDI2GMUspOqSOy/HESeGWc?=
 =?iso-8859-1?Q?r2zM3/0B2S3H8seuzixrmYlT6HI6CsCTZBB01VentQYR0w87NkB4iEhkHh?=
 =?iso-8859-1?Q?CPlhzwbjZJ4mEyfzHyY1tPz2j8AZVvPyVsETmR5YAHDZwe5h5lVrC7a1W8?=
 =?iso-8859-1?Q?0XHys8VuDt5u84SespMvVIHCajeulkKLlB5NsgOSg4MQq5f1zSSQNQRqSt?=
 =?iso-8859-1?Q?monRY+UmLn8IfsYm6JbQMfI3nibwhupQOPW9P1wqicaUnYJhqWjaOtnK3t?=
 =?iso-8859-1?Q?0cTvSEP+StZyix34xUbIA69yf3kL9xl68XGFixAaJiluvKm8JbnscPfRZX?=
 =?iso-8859-1?Q?S1gpjP3u64eycMF9VhBLv8nyac3cXBVkr0bF3p6U9JiB8n6uANhNXi5cW8?=
 =?iso-8859-1?Q?ckk5vhBqzRKbnKGnAUAEes/2kXTPjdwXb8FEXvghOSg7JEhE2XtVceUMSw?=
 =?iso-8859-1?Q?9xckO0BWn9sxOuAiQ4i3N+hRcC4DwKyaXQri0RCb/dFqVlwis6JSvF7X/o?=
 =?iso-8859-1?Q?+ixrE3AxOGdXu9d7A5eDSiVMca1Jovj+wnc/jKYPQuQgCjIyJW0q9390yx?=
 =?iso-8859-1?Q?ONexzbaFb2q5nzMmd/FUlBAoLRvuNVO/vDybIXrSYJ7Vd5TW3n+ohpVLWp?=
 =?iso-8859-1?Q?Vm5RVgDFF0k8ss40Ufhi7QrA294PY8u2UDxbwE4ECcAV98nWqfOTA7aGHJ?=
 =?iso-8859-1?Q?Y5KTj9jhkdsFh0ONgXM+PEnAp6KxgKYF5hluAtaPbt9c7+yUNbmR8DjPzm?=
 =?iso-8859-1?Q?vo4q5twdc/mBzPDmmIdbdnQd4766BBT2zmStIUTqT9dITJC7RVGQsEKcrh?=
 =?iso-8859-1?Q?GmSuy5Jq+IetfWuH/GuD8cFZfsxe66u33UFXV0Islgw2z3VyiH654e+qLl?=
 =?iso-8859-1?Q?IS1Yzkqn4EFOC2ni31iqbG9I5YJ58qJkH6wLdQUPU8BvQ2sQrwyyudTxcr?=
 =?iso-8859-1?Q?w5+tEfEVm0jW5OOb7trqkTeYnoMADhcZrMrM173wlU97mPF6JQsPzj+zXY?=
 =?iso-8859-1?Q?XTZUVAsEmRaL+pHCducR7Lr6Z4Vk8H7WOBkC4+/vC8y4murrcZJE/YahbM?=
 =?iso-8859-1?Q?mQAlI6KaKkIgFrlCxjLnzB5UB4PuYtreMQ1kCy3v7eeh+hj+IxXjbSMhvg?=
 =?iso-8859-1?Q?CaL7VshyTNlXqxV/5wGN1yx2RoJvusAzLz2Dn9tOfl1VJZ0d0oFKH/l/xS?=
 =?iso-8859-1?Q?M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7093399012)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CMGfJYnonkGBcNl6jUnuuglMnTTmj9LYN/XM9UqQAr4UffnOHly6rSC2OC?=
 =?iso-8859-1?Q?Ab0HbRbOUulBIoLvXBbjtJ14QTkP8TnsMxsRiV3cCkXFfUnlHjdIac1pXT?=
 =?iso-8859-1?Q?erT366tPzJ9Bpa4yRjF+0G6w22yoAqiuVqvygX7KkgH7jggAafSHlc5/IJ?=
 =?iso-8859-1?Q?8hpDJeOsrKKVxVHRlhhWQvviXIDAYvch+RnrU7l2SWFgHqPEe4ZOo7zZJ4?=
 =?iso-8859-1?Q?zkQuZQfJ/B30VQ4c621CndcS1epqVXpFaCd4MqaVlpMvtOn7dFcm4Uzxsn?=
 =?iso-8859-1?Q?ajl9YlkIYI9DZkqI8V/JsoYpI0UPCqaqQ11i97TWS2qVUJcpC1CwEa7sfr?=
 =?iso-8859-1?Q?akfbklrH5gbKXpu6nUoIo2dOHTScp72SY5dnaZRhsSVPEANpZ3zuPzL7Lz?=
 =?iso-8859-1?Q?916wcL/UxfXcyIr6DjtX6rCnCn1WYHX5nrmDZjJ4kD8IyPwCzmTFZJneRP?=
 =?iso-8859-1?Q?hKkYmUU3otXTbKWmRnngH47qftvLvwWScbHXME25wk9N+j/nxTgMA9K6pR?=
 =?iso-8859-1?Q?644tMtmbBg1w2qGiw2fLWIJxtGy6gDSaZ8J7/Uf0pur8+8onDHnBLXs9UR?=
 =?iso-8859-1?Q?HRyaX9Tnj7rL6IMmneB6v9H41yP+tpsdMvH/Z2Y/HsT7MvSkaHwXNaw/rw?=
 =?iso-8859-1?Q?BAZIFDedxJkBCCclKhpEj3MsmCIis/P9cjoYAKVbueb8006Xdv2RXwzLvY?=
 =?iso-8859-1?Q?vQEAreZcYkGBMbNayfujHRu2qD3TsNL8bS3BUdt9E/m1qNt0Xi423iuUTy?=
 =?iso-8859-1?Q?UkyB2b6Krj8jb56i0PRj1gOiSG5cGPlimYGQCR1Bs2zOvVwDCEfErig3mG?=
 =?iso-8859-1?Q?XAUrAIc+olcPuny7R3tdiR8HQuKUct1JSTlhRXjcnT0aIzmskN9xeI0uOS?=
 =?iso-8859-1?Q?abhH+ZPObU+S09YQQHGbiPBjRnSjd4UOw/lzpz7YNgyqHH1PDeq/hZoSLS?=
 =?iso-8859-1?Q?dAHiFdWKAQ6OCVlFAUPu/HpGlFnDw3JzG1xYuJcVgIBUjnke5smR3zIh9J?=
 =?iso-8859-1?Q?tz2IncdesoW7jdZ40/hTR5ST2Jl/b1GfJszXJsq5XtVqFZSBElHaagd76o?=
 =?iso-8859-1?Q?jQZg3Fwv3fKE+HuJFPZODZBorVL8phglVnl5qlhgWwci83iOecziq1evJv?=
 =?iso-8859-1?Q?T6R47VbPMwPUIF/WOhWTUsKvbkQsi22MJHs0vpQNQramNewZQDSiQxBh1Z?=
 =?iso-8859-1?Q?O8jihYf2SD5WNHOfL6C4oyncx+tMJgVZBryQqlQIQRqzK0Ce1Tca4Oh/c+?=
 =?iso-8859-1?Q?5+Fqs7RMFA6Aa9U0MALE/XiZ5DbpT+wnNq4Xa6cWULhBivcoage5LXCMnt?=
 =?iso-8859-1?Q?f4CrQpO3tTilEcub6R1p/l5hAkpUaOlw/zPcyxTtwOsfk8fNipjNRp0tWa?=
 =?iso-8859-1?Q?5PFgINjQaFXzobWa9wRKzPKgr1xl6NyRwpibF8luSvw0nsB7QVtvG0hhpF?=
 =?iso-8859-1?Q?0ETooqnzh1ikzfG73Fx2tj/8I6bV/+E6OxrTYRH9/hyO8OnHi7uOrRSg6k?=
 =?iso-8859-1?Q?NKSRndXmbE6nYEQbKu6nFjo/1WY4hYB92g41UOYbNgU0pLhucXjGcdF2v7?=
 =?iso-8859-1?Q?W5VZ+8BGStxpQFLSi5BN0UXfNfrJ3HMMUPDoY0erOW7+eCy/8u+gW/1iT4?=
 =?iso-8859-1?Q?wFtpJlpXnlA30F/xsKE+i+9uu+pYRSNm35?=
MIME-Version: 1.0
X-OriginatorOrg: bt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb09dcd9-bbeb-4ed1-791b-08dcb886f632
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 15:21:37.4816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAgTKn92JNzdzNQzMNR0oOKi/JFj373VPkZrTH1N3Tt2UPw1xfVoclPPiabQd8qRRfLjkiOZ71nNkfCpYSmU7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3192
X-Mailman-Approved-At: Sat, 10 Aug 2024 07:06:31 +0200
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

Hello all,

We (Eden and I) have been assigned a summer project exploring the possibili=
ty of verified boot for Linux with a view to experiment with a TEE, and wou=
ld like to share our outcomes from the project so far.

We've been working on condensing all the information and documentation on T=
F-A, OP-TEE, and U-Boot verified boot into a trivially workable form, a Mak=
efile, for the Raspberry Pi 3B+. Our aim is a proof of concept pilot projec=
t to see what parts of the technology outlined in the NIST standards for se=
cure boot on IoT is currently available, and thus what needs to be develope=
d. This also leads us to an interest in full crypto algorithm agility to en=
sure quick adoption of the quantum safe algorithms as they come out.
I should note that our boot order here is TF-A to OP-TEE, then TF-A to U-Bo=
ot to Linux.
This has raised a few areas of note and a couple of issues on our end:

# Areas of note
- U-Boot and Linux DTB's being incompatible has minimal documentation
Newer versions of U-Boot do have `CONFIG_OF_UPSTREAM`, but I can't see that=
 as a recommended solution. Perhaps a note in the Kconfig entry for `CONFIG=
_OF_CONTROL` would be sufficient
- U-Boot can fail silently if the DTB used is incompatible
No idea what the solution here could be; an invalid DTB inevitably means th=
at the firmware cannot access any of the hardware correctly.
- U-Boot unable to find `CONFIG_OF_SEPARATE` DTB's when loaded by TF-A; thi=
s is a TF-A problem, but maybe check other possible places for a DTB on the=
 U-Boot end?
- U-Boot itself appears to have good crypto agility (or will in the near fu=
ture), with a macro and existing algorithms as examples for the addition of=
 new algorithms
- `mkimage` appears to be lacking these same features for crypto agility, w=
hich would otherwise set U-Boot up to be ready for the new quantum safe alg=
orithms' release
A similar macro system for `mkimage`, or some other schema for defining how=
 to add algorithm keys to the FDT, would provide some amazing flexibility, =
already being able to define more than one signature as required. Adding ke=
ys to the FDT would need to be standardised in someway for this, I would im=
agine.

I am very aware that some of the below issues are not relevant to all proje=
cts, but thought it best to maintain a single list to ensure that the corre=
ct place to make a fix for each issue is not locked project wise too early.
# Issues
- buildroot build fails when the directory length is greater than ~80 chara=
cters
- TF-A does not pass on the DTB address unless `RPI3_DIRECT_LINUX_BOOT` is =
set, which also implies a define U-Boot doesn't need
- TF-A `LOG_LEVEL=3D50` flag has compatibility issue in xlat tables v2 when=
 compiled for 64bit
- `mkimage` ECDSA key adding to FDT fails if there is no signature node pre=
-added and doesn't set `required` node when `-r` is used
- `fit_check_sig`fails to check an ECDSA signed FIT file with corresponding=
 FDT due to `<null>` hash node
- `mkimage` expects ECDSA private key only in a `.pem` and not `.der`, whic=
h would be standard for a single private key

We intend to release the Makefile and accompanying scripts for this on Mond=
ay 12th August, likely ~5pm BST to give us time to finalise what we have cu=
rrently; this will consist of two Makefiles: one for verified boot using `C=
ONFIG_OF_EMBED`, and another using `CONFIG_OF_SEPARATE` on U-Boot v2024.07.=
 We are currently planning on releasing this on GitHub under the same licen=
se as the involved projects, but what would be the most helpful way for us =
to release this to you?
We have, beside the points raised in the Issues section above, no specific =
changes for the exiting repos, focusing instead on Makefiles which pull tog=
ether parts of the existing releases to produce a working PoC as quickly as=
 possible. We intend to also release this to the Raspberry Pi community as =
a TEE solution they can experiment with today.

This email has been sent to:
- u-boot@lists.denx.de
- op-tee@lists.trustedfirmware.org
and the Makefiles will be sent to Raspberry Pi Foundation and community som=
e point next week

Thomas Gymer (thomas.gymer@bt.com) & Eden Hamilton (eden.hamilton@bt.com)


