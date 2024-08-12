Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FC1C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 05:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9B188971;
	Tue, 13 Aug 2024 07:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bt.com header.i=@bt.com header.b="U+TKVwPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E542E88847; Mon, 12 Aug 2024 18:57:55 +0200 (CEST)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:261a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5234B887B9
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 18:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.gymer@bt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOghymLD5Qgx8FyA5hupep079BVWSAjzSITrTJzSNr4xIzFDpJz5lexm8uZrLYFrZmyQ/EomXlmRjDEUzc11E74SBYT7QsU2MRzSQRrj3Hwm+II8e8yr/k/85ypKQUPgZ0qXZtA8y2iLnx7D6B6OQC4hCT+kNK5ztvaaStNqm4a2Pbbc82rBSyA98+xW2JakgLX4cekF7ayDD201MoQQvtm++MU55dCsGLtX2G/izMmznyclx+z1fftrSqy085I2Mg2VOAJzBTxyYbafjWQaolAOon5GyFN00ICNMWq58A1FcvNpvqKmFU5VofY9MU79vRBqugN2JMXVANGKmgi5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEyZ9gIaD4RRSq0lNnbmIdaj96ed8/qQmf7mvtwf22M=;
 b=PMtzo4q4O1w6u1AB+QFw08Obg1bwanyP8aysxu4wKJ08BDQ31cMwOvgTTa2Xnnir58HvLMtnFwRDKzWTuyhfgDP7tsiuu1QO7mIsZjxsxeoDAZm7vmIzExA59BA7pyML7y+mdeW3iw+6rTqKErfjBtBmtth97HN5LxprU4pzFPxGuHcSXbfClIHXSTY0ZPszkEWbugVvVyqnOOuT8Oo91myMS/OIA+xpvJAN/nlhH3OjebD2XQ3PZ7c+jueFysRdgT9i1WjHdKr8QIgc6j8RcEIN++NxANwpiNgQZap3qgZ2TOibKJ2i1dseHAHo6JMKCnfCGA0pM5vq3Iq9eKY22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEyZ9gIaD4RRSq0lNnbmIdaj96ed8/qQmf7mvtwf22M=;
 b=U+TKVwPYQKeieRCN124Iseod7gfRtDzLI8Pao1aURI2l8+RHWMKKMeluRASAzTaQNyApHg0sn2Wdax6bJIZPYtJlAHetZddork7QzuLbxGV0Mp7uRwxb+oiZjmHkhQTgdsn+54Glc1l0YPH6TroHF1LCKBKFbDs9DlC2pZguonE=
Received: from CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ce::9)
 by LO3P123MB3402.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 16:57:50 +0000
Received: from CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM
 ([fe80::25b6:6ef3:9fee:9774]) by CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM
 ([fe80::25b6:6ef3:9fee:9774%7]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 16:57:50 +0000
From: <thomas.gymer@bt.com>
To: <u-boot@lists.denx.de>, <op-tee@lists.trustedfirmware.org>
CC: <eden.hamilton@bt.com>, <thomas.gymer@bt.com>
Subject: Re: Verified Boot through U-Boot for RPi3 with OP-TEE
Thread-Topic: Verified Boot through U-Boot for RPi3 with OP-TEE
Thread-Index: AQHa6m2WCHm35w9KlEuyOXmtB3kzH7Ij2lmV
Date: Mon, 12 Aug 2024 16:57:50 +0000
Message-ID: <CWLP123MB6393BF66D102DD3CDBB53A89E5852@CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM>
References: <CWLP123MB63935507882C09545073EA17E5BA2@CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: <CWLP123MB63935507882C09545073EA17E5BA2@CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Enabled=True;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SiteId=a7f35688-9c00-4d5e-ba41-29f146377ab0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SetDate=2024-08-12T16:57:49.785Z;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Name=General;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_ContentBits=0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP123MB6393:EE_|LO3P123MB3402:EE_
x-ms-office365-filtering-correlation-id: bc3a05d7-1175-4806-6bfc-08dcbaefe63a
x-antispam-2: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7093399012|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Y+MQFxUg/eaZg0QMRwkbkffjf4LtjGlenjzl/HaoV2isTNPQ2pjKdK+GxCnK?=
 =?us-ascii?Q?c6YH4Tc6U2esZ4A7AT/uUlPx66PFgvFi75eQ8W0V7nxEyKTgkbNbpzjuFih0?=
 =?us-ascii?Q?HjuMyFNmT54UoqxW5BdcRdqhNa9qt3tKMr67kSuoEapmRL/jwNhXqMjmcewt?=
 =?us-ascii?Q?nxqGf5PaeRW2pGrcDJLk9Qm7s2+8vFLdz8Q/tbDnxW/5FaekRnUek3HWONsl?=
 =?us-ascii?Q?XtZ4wPhpWvg4CpzvHPOEO+rfGJ/qBE/VPUovxhXv17pSN7HUQLcnZ8xJ3h5H?=
 =?us-ascii?Q?pHe2i7A6/R+/+P5BTn3v+dWXKtVffqk4kLtDlaMRPW/PGgHPEadAuSTUswhj?=
 =?us-ascii?Q?pnidiE2dCHpdWtyJMWeKmJm/8IeKMVoABJ3cmV6mWWpphrGLKAT80FzGg93D?=
 =?us-ascii?Q?WgPgRgVHE3nLiYc7Yl39MKJQDVUaGyXGNx90suBp8oPcC255lKu9QfV5KDQ8?=
 =?us-ascii?Q?w58e5SfAcP69+VJW1NrQTTTgywkHTYZByhSWMtmcRuo4E09CF7KLYOyCmBLT?=
 =?us-ascii?Q?03V1g7GQqQjY3oFFcQrfZZJcdIxiy3Sc/sdZrwndWFJhfOn9NV7/9OVCqEgz?=
 =?us-ascii?Q?W7bA/4PoAgGkpoWS4tCywWrwTNCKxdA0/bmRgwzBtXLBk5LL+3Lc1ezLF2H7?=
 =?us-ascii?Q?IZ62u7ktXpNXRZsJxySthy4mK+dVuLyhAgZKr7VdDd6NMfEKPy7ovgRjkVb5?=
 =?us-ascii?Q?mtRl7SPKL7sMhCF8yOXwalLxgzISKYgqNHoOksEkw6MWeQO+6RPGb7FXVB1Z?=
 =?us-ascii?Q?91NAuqXkFs+B9od/I5b6lDNhi9d4GCsE1sqMjDyM45AU4mSfqETlItqziQJr?=
 =?us-ascii?Q?RcKrDQQVtL0Q9WKdnNzIxVkXd2n8KABOqn/S0p4n7h9T10jrPk+0mL6KibzD?=
 =?us-ascii?Q?/2zUp4Pp+tNGQmw1MyzffexnNvVPuxrWcfBcocy3MiwQr7h26keCv5ZaxEPb?=
 =?us-ascii?Q?B51U7HC45qxakbv/+KbJffVNu5Gycc3ZLZHrn3rmW96maumx7c0ZnzZy5QwX?=
 =?us-ascii?Q?/O+SjuIkGuI4+oaUHRMIOxQz9RBUFEkAXu2Qs0y82WdTEsnTeaQ/UtIQ6nFs?=
 =?us-ascii?Q?VckF2K2NFbgNLD/RNvjkjbZ2Lwsxo9rFfxEvE5zxtgr2Qq23/tGKYT9Vualy?=
 =?us-ascii?Q?KYbyZ+aM/U5jyfwMMiaFYq2uqWSfl81oS5LC2Mfu4HIo8V6pQQt4PIP97r/Y?=
 =?us-ascii?Q?RieYnEwh+aV7PBFsTP71OzErFQdQhS0LgFSrKrMqSlAax+FWTgEzyYtADcgn?=
 =?us-ascii?Q?b8uvWq+ePJZcTxTX6YpZBg8owjWTbrEJEoRcdrkSzv2OlfzG94MNFAyRPAZu?=
 =?us-ascii?Q?HfbQS4f8UbsjDR8+qLhsBkOzC1vs/p/YnjfiSfM2ZnZaJTrN3onUoe9EFy2c?=
 =?us-ascii?Q?nnLIRqaxjuNjbAqnQktuq5VihAaz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7093399012)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rjtnhd/lNTM04mfpGamoIGZL/ngH/+ffpQ23FQ7WTSErZNyx0Xx9t+M+bema?=
 =?us-ascii?Q?Mxdiy3W8BL+2QOiR5AZ0lT3AprQA+XKeqy29W9+fu+fVREiWomqDhrJD012Z?=
 =?us-ascii?Q?4qCCCsE2XX06MU9SSy6LL1Q/h4AK6PyISYrLU8aGzzR0NiHbOusnfIgqva1H?=
 =?us-ascii?Q?j8rQS7dOLbnFg49391tthU6IAJC/7dWzGWtPyJqp8QJg2Sc6PyyHvNbfbX3u?=
 =?us-ascii?Q?t5bmmE1N7CdhpGrY6Zd7hzkV6mj91b6Hul7k1ivSZN5g66kfio1xthfLDMSW?=
 =?us-ascii?Q?OCut+jVJr5BNi3ag9J7bsYDmFda3l8VIOMMKKmXn6ZmkClYyEXYimI4bBmWK?=
 =?us-ascii?Q?k+ui1NFP2ODeaNgss2g4cTbdc/P5cax8ymI7CqMJdr5SRcw9g9gx26XtNVxP?=
 =?us-ascii?Q?YWa8bkf+DZfd1WmJa9eydOcQr7jibokJ/eRyii8eboqeqFUcx1E+54T3J+f1?=
 =?us-ascii?Q?N8rzR3dA2yZ065BNnazvt0or6gNS3MNMDtQdPOVIzI7BEpeCS/Uxi9Ad910t?=
 =?us-ascii?Q?2E0BpXEJzXPMTzWtH0beZj02xid/wLjVPDFGTqZBe+Un95V7MRG7dc7bHPkd?=
 =?us-ascii?Q?seItwlRyPYvTLYnc89HjRm0zywuHyPSbPOx6PDxSyIBebIHVo5sIWGLGt3Mv?=
 =?us-ascii?Q?NpDGtnenLUoOrfqDDkRemqLMPP7wBeADfh77LnGXtYx85Nce/FKz+zbigWPt?=
 =?us-ascii?Q?Eh++8nGP7cE1C3Z1Wu1GcDEDN/R2F9J+OGYN1emo/GPeznzCbfjhBNszIVR2?=
 =?us-ascii?Q?j9OSUAW6ZJW8qab3XqHhp6wk6JAobQFo5hJjhk7wLLL0IR/ynMtHxuY7hBpn?=
 =?us-ascii?Q?3UnvRcFSpv/d7+8x20KBsKoP0+Hcg0xNRinTWQUT2Acvex/m5saaAG5ufmhY?=
 =?us-ascii?Q?MsgLoiGhtYsWIj2L3uHFgBFfiDPMiywkfzUjEgeZXPsFgK3QjLfOuMvCHdBM?=
 =?us-ascii?Q?DoU9yXgkjWwkv1gozz5XGHfIkhl69t1mM35sQaJQ0sg+O1rvJaP1N40gSfRV?=
 =?us-ascii?Q?HLDGpyRa5NrbdGNw8AEWoRaJvXWzJL6WlQkbNLJmqGtnsTDDzCiJyRbxh7Zw?=
 =?us-ascii?Q?trfLZx0EIDaUhWJMxavmVq8K7v8tDLuozTO5QJCmu/lcp7g+Fq7iTL+6D8Oo?=
 =?us-ascii?Q?9k5B4l/8vmZCj0QaxnYtpskcoUd77nG8Fvw6wGlAa5oopEbdCPMrOOh91qVC?=
 =?us-ascii?Q?x4rKD29OTHGY6NRX9/SAZd7hFWdLMc2ZLgmi/pMyAeoXAgD9/bDHG4XgX+as?=
 =?us-ascii?Q?Lz+u/+Dr473fcMWDU+B7N+tPicg6BRgO/9Ma7KR/0YyZaSb/cC+pqZ72ETRV?=
 =?us-ascii?Q?E54U8t/Kwq7sbypsJieLZx9PgVR7JcBj8SexFaZ7giG9nyhWfXzgJRALma3U?=
 =?us-ascii?Q?DzuZ5LHEsQuzWmAvx3A8aT1mSCQa0p38NPqUnLlxDDFrb/ylmTwWRIzjttlg?=
 =?us-ascii?Q?4ZFncv+tMyjnVQjVUk8oKBRq+6geFwS81xQ46K/6ou9vHMjNcnuaE9+g9bg1?=
 =?us-ascii?Q?hrFcGkBdajhp920oZOXfrG+dXh0m90mUl7WaoQQDkpQ/7lr0NHZrqfdGMNhp?=
 =?us-ascii?Q?OH9khSsKW+JWlm13YPWp/d1BDhbTBH/KPn7JHc8L?=
Content-Type: multipart/related;
 boundary="_004_CWLP123MB6393BF66D102DD3CDBB53A89E5852CWLP123MB6393GBRP_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: bt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3a05d7-1175-4806-6bfc-08dcbaefe63a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 16:57:50.2121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZkG0mCCZ9FYED/6eQQJuHlz1884KRebdfb8KnWsu+bZ2kk8pqYPG7DvyfhpzYHV2m0TPRI1ATDRlzs5g0TJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3402
X-Mailman-Approved-At: Tue, 13 Aug 2024 07:09:50 +0200
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

--_004_CWLP123MB6393BF66D102DD3CDBB53A89E5852CWLP123MB6393GBRP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

Final email from us to both mailing lists like this, further updates - besi=
de any fixes we push to the individual projects over the next couple of wee=
ks - will be available here: https://github.com/BT-Summer/RPi-OP-TEE-Verifi=
ed-Boot
[cid:f4606bb5-79d0-4934-9a6d-3a569d85aa33]<https://github.com/BT-Summer/RPi=
-OP-TEE-Verified-Boot>
GitHub - BT-Summer/RPi-OP-TEE-Verified-Boot<https://github.com/BT-Summer/RP=
i-OP-TEE-Verified-Boot>
Contribute to BT-Summer/RPi-OP-TEE-Verified-Boot development by creating an=
 account on GitHub.
github.com
A few details missing currently (have marked TODO in the README) will be ad=
ded tomorrow.

Thomas Gymer (thomas.gymer@bt.com) & Eden Hamilton (eden.hamilton@bt.com)
________________________________
From: Thomas Gymer VRC7 C
Sent: Friday, August 9, 2024 4:21 PM
To: u-boot@lists.denx.de <u-boot@lists.denx.de>; op-tee@lists.trustedfirmwa=
re.org <op-tee@lists.trustedfirmware.org>
Subject: Verified Boot through U-Boot for RPi3 with OP-TEE

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



--_004_CWLP123MB6393BF66D102DD3CDBB53A89E5852CWLP123MB6393GBRP_
Content-Type: image/png; name="Outlook-1gsaefpr.png"
Content-Description: Outlook-1gsaefpr.png
Content-Disposition: inline; filename="Outlook-1gsaefpr.png"; size=42214;
	creation-date="Mon, 12 Aug 2024 16:57:49 GMT";
	modification-date="Mon, 12 Aug 2024 16:57:49 GMT"
Content-ID: <f4606bb5-79d0-4934-9a6d-3a569d85aa33>
Content-Transfer-Encoding: base64

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
hzdWVyc8e+Hf7ujwNmHtYtvqfSpd1dSQLb9Lo9F07eDSA5tF1h1qsb/WEpI0VNzRuxMvMMC/Z/eu
JA0MXldGhZW+IwBWJ+8p7+dFT6qKRdo/k2Q7Md76IXbCwjCWIwMrIuiDQrAcGSPfDFr8ayeOiw5l
ZvhVkl2fJGU+RimKlkJCaEg//fK7yjrIUydPNF84hjR65DCVAaICQd3sue8dP3Wm8RoSrYlcLq+s
qiIIYuNP20iGijUmk8k+WrU6Ny+//tvSsvJ5i5ZVNhlFrM6tO/e2/PJ7K4uzuqbmrXcX6dd5cvX6
zTlvL6hP8LRX30n4xbfft/AG/fS5Cw3DpCdPGNuSU+kqJe0pyd7QkGBmk2m9Bsfjk6XiLEtdW5X8
paNSqWNGDtf75ONJuxara2qKikv0PrlGVvqOAFiX3BTel5Pv1lZo+9CTSqMERHEX/NxxyGuBWAih
5XpO8Fnye+eQ9k5UmraJNa9S+v3MB88eaHsPA83CoFuD2fHH3r/+Ptx4y/Ahg0zZq2BUXp6es16d
/tvOF2Zn8fj8T7/4dvvOPZMnjR8yaICf9c+WVFFWVl5YWLxn34H6bzt2aDdq+NDoqAh3NzeRSJxf
WHj9xq1jJ8807i4TCOrW/PDjzxt/IAjiy2/XlpVX1G/v3rXL8CEDIyLauLu6SqTS4pLS23fv/3P0
hEq5yD37DowYNjgmOqp1xKlQKD745HOVVfUoFErf3j17dOsSEx3l7OzEYjnw+YLSsvLE5JS4q9dT
0541bvw0PePTL779/pvVOrwa5RX5BYWnzpxv2BIU4N+nd89uXTp7uLu5ujhreZ5//rf8IJNpN2bU
CO0DaLkz5y6Q7O3Xp5cJYiBf1d3Ly9MEMeghJ5dsCkpoSDCXq38xno7t25E3yMrO8fH20vv85Kz0
HTGUI8dPPnj0WNej+vTq0b9vb2u5Ipjd81Tez4ue1JRpW0WGRqdEdHWZtKRN+wHu2icwQIJKpbTt
4/b6F9EHv09/9qBKJtGqy6G2QvLzooRFv3QKiuViuIR+kBC2lFKpfPAovmkNDz9fn5UfLjNfXIY3
Z/bM2/fuNy7QUi83L3/9pq3rN2318vRs365tTHR0bEx026hILQtaWrLS8orde/9SKpVOjo4rP1ym
soR0aEhQ/z69Zs985b2lK7Ialfi7fedefEKSQCCo7xZzc3X94tOP+vTq0fjY4KDAnt27zn79leUf
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
jNaBuViFQilVamR+Icr06cHjFoaPWxCq1tIvdBAjEAIAAAADiMlgPbOzOv9M46WzjY01pqZak8lg
bWkw26z989wukUr8ghRKjcwvWBkQqozP8EscFzhhcbiSBSSGBAIhAAAAMBAZdZbSXF1lob653lRV
qK8uNlQXG+rKDQ1Vpj54hg+KUAVFqkNjNWFxmsjhWr9gZXi8JjpJq/FVSBgeOIQQCAEAAICBzm4X
Gqtb68qNjdWtTbUmQ4ulMLOpscbUVN1afLHFqOvpIhYqH1lcql9AqMo3SDF8tL82QOEfqgwIUwVF
qgPDVSTAIYxACAAAAAwyVou9uc5kMlhNRltLg6nVYDM0ma1We2O1qTi72WK22e2CzWK3WW12u+B4
3pdIBIlEkEglMrlEKpXIFNLYZN/ACJVUKtH4ydVauW+gQqmRKZRSv2CFXMki8mJBIAQAAAAGN7vd
brPaJRKJ1WI3m2zClRBot9sFwW4XBEcDn12QSCQSwfGfIBEUSqlMLrHbBalMQhugaBEIAQAAAECk
aAsGAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpA
CAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAA
AAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAA
AIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQ
KQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIE
QgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQA
AAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAA
AECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACA
SBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEi
EAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAE
AAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAA
AAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAA
RIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgU
gRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIh
AAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAA
AAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAA
IFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECk
CIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEI
AQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJEiEAIA
AACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAiRSAEAAAA
AJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpACAAAAAAi
RSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAAAAAARIpA
CAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAAAIgUgRAA
AAAARIpACAAAAAAiRSAEAAAAAJEiEAIAAACASBEIAQAAAECkCIQAAAAAIFIEQgAAAAAQKQIhAAAA
AIgUgRAAAAAARIpACAAAAAAiRSAEAAAAAJGS93cFAHjKarWez849nXmhoqKqRa/X6fQSQaLV+mi1
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

--_004_CWLP123MB6393BF66D102DD3CDBB53A89E5852CWLP123MB6393GBRP_--
