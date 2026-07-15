Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E710C44507
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0D884D5A;
	Thu, 16 Jul 2026 03:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gatech.edu header.i=@gatech.edu header.b="ciHEXpHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FD984C73; Thu, 16 Jul 2026 00:21:25 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5A484C23
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 00:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hibrian827@gatech.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaQaq8fqLGwDWGi/wQJyPE/MwrSS8P7Pen7P32Ix3tYVXE9VOi/r+OhufZ+jHpTo/hnC6ipN19cFM9O1bOAvdWbwBAsZQePdBYrQ7l29JJS2MuMTfM7vMt31EvhlFT8uzkdCJMwYZPfkroeH0Dx3qyDc4jpScEmxnn/wKJCUpRnTJcczWCTEj4XIHLRa4xAS/1FVJhQxoNXxi2AxBpY8FskhxhnlaqezO8OQXINLzHwO6d1Q0v/E/JHEWLEK4m8UCLC39OYRranh3ggNZK/ynxnsKzRlFpuOIbhRQ0fhqf2TSz1SCLSxmuTJ3iwC3o99+dAe3XhjcomdtxW+GuMAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkzUvG9w3Ub/XNFTD52xi7CvsKcTAY9r/JHCck+GC4M=;
 b=NUDQrEFYC/fi8OgNGyPK+zI+nLqKmm6VzzoVhIrHQvbAF/EjrN7hkah5M7URVB30DiSnwMbjHIe0m4TA0fB0HKhL+3rtppZNMACMwn9BSE9iyve8R8qF/WhJgpw4+gzkNMdSCh2/r7uGjI6YafyOen7NceyXsPIvYVqrDSbuSe0p4Te5QAYF7KRnk9NMUEbqpCl1H3Gtnt7aaapWNl/5D1wPKiLEzhVwKIalOB932L66tnZtVtYf14krkSru5mqV15+Dbv4F4P/aeX7mCVf/hcdHKbjZq/Du1oMlrHof9hXnXS4+d1nrB5EMOoRaROZxeEzphq4gzqRMljbV9TOpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkzUvG9w3Ub/XNFTD52xi7CvsKcTAY9r/JHCck+GC4M=;
 b=ciHEXpHo5JecodA4RxYASS+RWvtTiiPbNWqk2JdtLCpURuklCQZnUS66F6PholQA/gllM3xA0VQBP286+ACHhqGnR3MgDSueNfmLUeTGrn3drYHU0/WRR2k1UDZYBKHe63D8Pg5u4lquzX7irxqfE3EZQgrSFWlhx1LTmL5hHEw5HyPtkNCPxK/XdJ7bZo7D/kqF2+/nbxhxEgFWQolCMBNhrfWoakHBFFh1MXBrAsPZ+EDh3T0W0FAMB4quHAztpIeoYa2TjAIog6Ni5VLTxZx2LP5ii6soU5eJq6FmMxepndkWm3WW46CL0/bHa/+Lv4YREwtKh1AVZHHfCWi2AQ==
Received: from DM6PR07MB4377.namprd07.prod.outlook.com (2603:10b6:5:bf::19) by
 DS2PR07MB11761.namprd07.prod.outlook.com (2603:10b6:8:32c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.18; Wed, 15 Jul 2026 22:21:12 +0000
Received: from DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059]) by DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 22:21:12 +0000
From: "Lee, Brian J" <hibrian827@gatech.edu>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Kim, Youngjoon" <ykim3186@gatech.edu>
Subject: U-Boot NFS READLINK short reply reads uninitialized path byte
Thread-Topic: U-Boot NFS READLINK short reply reads uninitialized path byte
Thread-Index: AQHdFKeuXj7gLsiht0y6FRQIVBLflg==
Date: Wed, 15 Jul 2026 22:21:12 +0000
Message-ID: <DM6PR07MB4377345499126288E3256596F6F82@DM6PR07MB4377.namprd07.prod.outlook.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB4377:EE_|DS2PR07MB11761:EE_
x-ms-office365-filtering-correlation-id: aa24c1d9-a847-4bc5-1808-08dee2bf60d5
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|786006|23010399003|10070799003|376014|6049299003|6133799003|8096899003|18002099003|56012099006|11063799006|38070700021|10067099003|4053099003;
x-microsoft-antispam-message-info: ps/wRtbPtF3rZ6DX58sSQgOWHLrRJrGsskuNGB0NQkq12LoTm5GLDMHEsF2uWE8+vWmrZ6I2FOXiYGi/jJrZ9ZZHlCAAhjEp8jk2zfu+XsQAv/ZZ9lOXNLsDa5BhfUVlTJ9TuL3UMT1la09phsAVeAzNKzsgnRHEeNKgG/E2hDNCFafBwsyYuQVCv8mYKVNRX6+98Mfowx0yxkIQHargPzak8pt///Jvf+O84LnQHioaTvMDsu/iRf+z1qqkUmuZ0JAol1Qi4ThgiWXRjRacbs3TmDRfzauC742Vdzvqg70HIemY4LTcSY4D8FkPnJuu0ppuHVLRseR3i8q/UtCreib80b+LVD9v1i88X/uFBZucCXWE05BQ1ElHa+g3Tar4ohYrgIXr6ssSN36RxfEYcjSOqtvIPc9hfNmxpFr74WERVM50F+1Z26UMCqyU7LZmb/XZEQhxme3pN8HnhEO+FZ8bB+fsSeivf+c8zJ8AskzgQ5gQt7MQNb98T+mlaal1oWgxqbXSBJpNeUkNp/CRs+KjIl6Q0+/38ivzxUlm+ELw81TpJuh3o0kbpIC8LrbgW02Th4eUjQtiRAf7IyNDLvUM3o07oKxZgcoJPSTWqLQ+j6qwnWaQ9D/JNnic05CNQ59jNfUR4Y9XS3FzrH5M/rI6wTaqrDcQjODVpcNjn2o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR07MB4377.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(786006)(23010399003)(10070799003)(376014)(6049299003)(6133799003)(8096899003)(18002099003)(56012099006)(11063799006)(38070700021)(10067099003)(4053099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bw0UNKy1neSblynfsX25KSYCYUypkpAExVhP7Jn0sB6ZK7JTGI5gk+opCI?=
 =?iso-8859-1?Q?XdJ+zr+86uK+QrgG+iCbVGE2eKJKZQqXkPMovhiiXFqkNOqF16MtU3nE1j?=
 =?iso-8859-1?Q?JpGDeCDzv5JIDDo2BYg7D9vNthcl12w6lCoGsauhYmBtAEH7H9PYEXfNHr?=
 =?iso-8859-1?Q?Pkg1Ggm5RmH7urO6KDYcTIr6ivDPFdxNH/yND6m1aIwG9VB5BBXre34d0X?=
 =?iso-8859-1?Q?ef9U+wEFJWKQBs7tR8j8/Q+syqWmptJ16OrcK7G9EPO6DYgEotasP1WOTm?=
 =?iso-8859-1?Q?n0uxfOduUVK+NgolCY2q/xboRgUQTIpRAI0iuWBw93gj12gjideKRYjnu+?=
 =?iso-8859-1?Q?TjjLDc4hQ5Ci3n9nQuLoHNpikgUoSSCWjHawUYPlglQZ0TVNIq4zlEiJF4?=
 =?iso-8859-1?Q?Kqlov6047p6xTTYi2cSlGnGQYUxbPPEDj3tvsTiZXkTmCJy3Bpf61LsfAI?=
 =?iso-8859-1?Q?FL1DD/Kf0dZNrgZY809E8uLrFZiZw9aPW1GEE+nNV+b8AuGyvGHdxkR9kN?=
 =?iso-8859-1?Q?RmvR8Xz1sxrMWD/eZkkCmwzrfuiEdyxZ4vmU4JGohyamZZt4aVZxhDy9YU?=
 =?iso-8859-1?Q?PinUg6kT/dZiCplSVSu76NCsMY9rPUVgSvUZQJebR1+KLq4zDxhY/qwU5U?=
 =?iso-8859-1?Q?H92h/to3/ZPP4bPsPNGZgFasQmY7XapTwxud/FcRWs04Z6yShoqERr023R?=
 =?iso-8859-1?Q?eIqxPx0eXLYjFHeqSahyFj7DoEf+M4ZOajBQVAw/NKM5OmO7jl3W8Q5ZIm?=
 =?iso-8859-1?Q?PkDlOPYb2D36wM6EutJcEKmBtZrq2jDO/GTFoEF5y5wn1c4Iv4ZksoJg5l?=
 =?iso-8859-1?Q?hYfFQwtl+U+lR0AO+T5pNzuWeUz2RQIlT4vh3W60uV43earhsMI522IfuZ?=
 =?iso-8859-1?Q?cxzc4l2nAjzI+RdzCxgBymFE1D4AgJ2F1B+Atkl5qPZwMoWeA4bfHGqj4o?=
 =?iso-8859-1?Q?OS4lNsgQmj4xUwateA0muhgF3blSYywP65kVUh9IggcOdYi+XP2l8Fis6s?=
 =?iso-8859-1?Q?BDPFWf2WJ04o6vcLb6y1TD0MN9lkvTrqor9mwlvRH2I34lUVyKQARg4lY8?=
 =?iso-8859-1?Q?Qo7LIDKmQ/CTY0CJnw2wRCOIUEVUVIaoa/fvZYlGMtT57pxNIkqV3kZTkR?=
 =?iso-8859-1?Q?wdwWNcOsxIoGXU58szk51nxr1/ITwcjC01QgeqV+oaQ5W1SEQYKcqfTc4n?=
 =?iso-8859-1?Q?jLYOE7nyBWsY9P5izyS+WoPM2tzQr/wPkTWR3XB4E/IqXCEzAdyrnc8227?=
 =?iso-8859-1?Q?II2IOzZxn8Wt3/TdsBPk7iFMmzYb6KN28KXeZhSJNbOY+kKmK3rlq+UHdR?=
 =?iso-8859-1?Q?eDSeyeffxXiMgY8cCG3cttJEA5HCaDL+DtTqOFP7UVmubHk8jPxAvtbE2s?=
 =?iso-8859-1?Q?vbvyU0Aj0pSAG0iyNomqYyshSzJbtDAo8tps6tHnkWUSzWQHMiIcZD1S2b?=
 =?iso-8859-1?Q?elzn8DOPymvIs3nVXRo30VEoem/yC87hn4KGo5sYP6OKF/Hy3+vMKeLglO?=
 =?iso-8859-1?Q?QddKUgtkaP0Yv8m1BbMG6AMaT9VkiO2sYD6AwfvNLfSqUqeQH8RimEgMuN?=
 =?iso-8859-1?Q?khNp8TDQJFO4OCxOLv1fZO+PWEpUJrClj+iqOF0tEddh1wfs0qO9P1KDbZ?=
 =?iso-8859-1?Q?hW8dzdEXuEhhnifLn3sL+DB0hIo318+wrrFuo0Bmdybxcw1mTJpbRLrgM7?=
 =?iso-8859-1?Q?vrFBZAike4UzHgPCrrnBjcEwypUa19Xp8KlofgizUNproCiQrnDapOMCU5?=
 =?iso-8859-1?Q?rJKqT6J9RadtUitKLNtA6dYNkN1TPNEhTkL0pD0w5cfMRVxeB2CGLMzCZn?=
 =?iso-8859-1?Q?Q17vAbZwEQ=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_004_DM6PR07MB4377345499126288E3256596F6F82DM6PR07MB4377namp_"
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB4377.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa24c1d9-a847-4bc5-1808-08dee2bf60d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 22:21:12.3974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKeywn3OC+CmvtlZ647deu/yb1MpwKWetZJPGV3lZB6E0R4sUaPz8N5QkLvAi5b8HCpsaGtGjmy9X64SbfjODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR07MB11761
X-Mailman-Approved-At: Thu, 16 Jul 2026 03:03:52 +0200
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

--_004_DM6PR07MB4377345499126288E3256596F6F82DM6PR07MB4377namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

My name is Brian Lee, and I am a PhD Security Researcher in SSLab at Georgi=
a Tech. I'd like to privately report a potential security bug in u-boot whe=
re the attacker can make a U-Boot NFS boot consume stack bytes as a pathnam=
e. In the non-slash branch, several uninitialized stack bytes can be copied=
 into the next NFS path value and exposed back to the same NFS peer in foll=
ow-up path operations.

Target:

  *
Project: u-boot
  *
Repo: https://github.com/u-boot/u-boot
  *
Pinned ref: 3cdce049f90d77c3f9221f1eb73922384c8972c3


Threat Model:
During an NFS boot, the bootloader sends an NFSv2 READLINK request for a sy=
mlinked path component. The attacker replies with a syntactically successfu=
l RPC/NFS response whose READLINK length says eight path bytes are present,=
 but whose UDP payload ends immediately after the length field. U-Boot acce=
pts the reply, reads the absent first path byte from its stack, and then ma=
y copy the absent path area into the global NFS path before continuing the =
boot state machine with a corrupted pathname.

Attached:
When reporting by email, for better readability of the email and for those =
who prefer private channels when discussing security bugs, we share the ful=
l writeup and PoC files via zip file attachment. If you don't want to downl=
oad an arbitrary zip file and use it, please let us know. The zip file cont=
ains:

  *
README.md : full writeup.
  *
poc : the relevant files and scripts for reproducing the PoC

I would like to get help from your expertise to clarify whether this is a v=
alid security threat or not. Thank you.

Best Regards,
Brian Lee

--_004_DM6PR07MB4377345499126288E3256596F6F82DM6PR07MB4377namp_
Content-Type: application/x-zip-compressed;
	name="INT-nfs-uboot-readlink-short-reply-uninit.zip"
Content-Description: INT-nfs-uboot-readlink-short-reply-uninit.zip
Content-Disposition: attachment;
	filename="INT-nfs-uboot-readlink-short-reply-uninit.zip"; size=6684;
	creation-date="Wed, 15 Jul 2026 22:20:50 GMT";
	modification-date="Wed, 15 Jul 2026 22:21:12 GMT"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAGWy71zAhbWZ1gcAAHATAAAzAAAASU5ULW5mcy11Ym9vdC1yZWFkbGluay1zaG9y
dC1yZXBseS11bmluaXQvUkVBRE1FLm1kxVjbctvIEX0Wv2KyropIEeBVK0p0MbWM7a2o4jiKJO/L
loocAgNyVgAGmRlIprdSlY/IF+ZLcnoG4E1UHnZTGz9A47n09fTplt6wz+EflbLs0/d37PbD9P3H
609/ZmaltGVaFOkaXx4bVuYyl1byVH4VMSu4XbHF2opG480bdldmGdfrhpd0avZleSkF10ZoxqNI
FNYwzqwu84hbCDMlNo1JyrS6+7xSRrBYRCnXtbJU5Ev8EF+syGHOQqxVHjO7Es4MCIxsyVNnbiTk
k4g77Dpn81zYbp6YMFJZpvJONA/wRhqIc0bg+FnpRxznVqs0hbYDu+F9tGI8PwiAsTx6dKFhKnFm
JFIbuw0MnjjzcndI21BSrNlC8zxaCRPASwnJEURHSuuysN4bygVdz3kmmNLwuKBoeIXe17jUMl+S
URRoetFxeZgmiYgQ0UbIbrT6CesxK0M6x86tKNSYrawtzLjbXUq7KhcdhKXrb3Q3F29knsNDLZIx
G0ZxJHrnV8lVLx6NomFyNRj0k75YjIZYDS/Po8ur0SAa4tmdeBJa2vWYvfvh7o4NO3123rns9nvs
3//8F5vT5hib3ekP40/d6bvxn7o3t1h9vsbnbvy5+278sUvr6fjj3HlzS5GIeGlE455CWC5SGdXp
9YGeI7Wz4tHOsPvUbM2Z5Y+IT4FQCVsDA3ngkIPk6tCURZFKeFfBKdEqc2GvgODEBu4N0pMKdxbh
RW4ZUPPMgQBEPkFeODPrLJU5ocAUKkeOpGWxNBBBCWbzu/vp/YdZjScs/javTDNM5lZ58wlDJGbm
8EZONF+gdjz6tgfkvty/HFzMWx12v+K2rjCgTEK7+IKKAH7n8HRehcIp5RWU5gYVGKHIi2hmIdwo
QFik29riFQvUoanrIePysBqOWHxxPjhq8cX5JVl8bavi0KVBOCjMm8LbrXeXoHnMLf+x/3A0NBcX
o3nLZQxRjx5JFoJxmN8FR35QqV5U7wG25YDX5tzTh69TusIKhWgRYdnqzeA19Vfkz7QKj1PuGEpm
mYglCA67PCFRWzegEeWlNMHYGOH9X5Zcx0F115ODpw6X1po3mPKMwheGQPmCdXbNpaBkfM0c8Wxd
9S/dG/Ar38Ei7R33cvRKNkdXx/cvK1yiaKR3zxCfbXLs8g7GKfMYnYOMgdc54wbs8SEc9PpXYf+8
fzUM2KJE6Xmfo1JrMj1Ssa9MD0aqSBc8pjJZgWmbSJUkRpAIYyu2pluujOliBRSHHSTOSo2EeToF
Y2oVo0akyhvz+RwYWjXowzrdQkVdNLAOdnDSoI9Fb2pgj/XHqD5pJ/3hObMSKJip0k6+5yk1tVJz
kjfpdc4HBtkhrogn97qEzSuAdKI0j1JqJ/lS6AJEbyenL3ni1Gka/Gaahr+JJhdKIvsjzDjffV6D
6i8iU3p9x4mLvqJKjFzmKGPiZzreZynXrbk9JBtXXgZ6PO+DxCsPqNTQNjCIAJsZJBlLDajMDdX7
opRpTA0a6CoLlnCZlijoZzRWhMYTwa7Fz6rEfSKdGEYDjQia8MPIolx6xF1n6A+2MSV+5SURJDS6
GYkavWcYFG8Mg+sZYHd8owYeMCGJXnzBqDyRy1JXAuAoejTZjNEBFUe9COsF9TnF0MTcKAO7/UUM
cp/f32zaW+BmFVJPrWE7sx0MTE5ANbuZLTOZitKw64JQ4BTuVRyhxd9LqSsijMWTjJxJCz8PkaMw
OlU8dktyYut2sD830btqaNt0aPS2nUYuiNiP9+egHts24Tk1tV8KufU8BDTjwpITp0DLE/AV18F1
l8krwTJpDNm74aKw4iJPVm4E9VxVjSvUDNwOtR5keTOmOA2uxgI3EVXT36sjKZwICL0VFHwSXAOB
g8yxLh5s24J7Gi7IjnivPzgGPegPbrCGmtTXA9WGCfZi5oCSYRTbZIZS52aT3JTZ/jDLzXbcJXUB
Wq8l4LtpHvNUlNL8a93vBP4JGUr5IOmE60JANnKTYIJXzyGq0RmvCuGJCeYp/V+mbMq5sarYmwTp
yltfn7GC0sPK5XohsdJr347EFxGVpKxT/Uq0XApDlZvIL8RrvV4/xLITyyRp0IeFIYZwxruHzZMt
Xmw1wjA8crPRbreP3f7uOxZenA+DS9amH/0Bww5iTukiKjoydpbRimt2hlk6AKyIRmE63QUCWw32
c4Od7M6L7ovLb7FPtzSuvW20T2oxiGx9BGVPwxlldlbBf8J6OMRtmbAmHrI/gH6/CpU0K6mtFg5P
NHgVI0GIDM9ub97N3t/+9QY6IDYTWVSsm82NoV5r6/fVe0CIPmQ6KWJOEUC8SmsNnbLjC1XGLain
Xax84C4uAvzS0r4Y9YJ+/1dH7qR7Bkg97w21Z13sU8gQiuNm+UmRtV9G78G5FDqXmrXyjef7AnoP
LGQv7kAq6Sa/nYntE2fb5OXNfWmDo+a8rfLoZLyurVbGXstr7dNZs/kLrGix303Yafe0BaS2KzmV
GGfY9hQGyIrdHGYJHgRttNlmTXEB+6b7DeLs4DAaBf1vAYfLQdAf/no4bIJFQaljM6kLoLZgtiiT
pOXuvxavk7oM6jeQVskNEMsT5v/9oqTuCtC+jNqbDR+hahtm1Pp/3Pfqoarzk38wQVPiz7Xz/0OX
/0+O7rtHteztxf/dBHtGf2vRRP6LNbsXPGNTm/Lc8s5Z4z9QSwMEFAAAAAgA4g7TXBUi21DJAgAA
NAYAADcAAABJTlQtbmZzLXVib290LXJlYWRsaW5rLXNob3J0LXJlcGx5LXVuaW5pdC9wb2MvaGFy
bmVzcy5jfVRtb9MwEP7c/Iqj+5JE3VraboDKkCYxEGJMwCYkNE2R4ziN1cQOtlNREP+du6Rpmq3b
l8i5e+65517sI6l4XiUC3jJTsrFUwp1k77yjndm6RKoDNv3IlMv4oc1ItSRbZxzWCYb7htQec10U
WpHdq5SVSyUSyLVagizYUkS5ZknEksQsPNQCSBHFWrsolbmIrPwjFp5nHXOSwy6cZ8xAE2gEu5tP
3pzdI2ytZQJhwcrIbmwhCr+fr6QsI+gbc6EC76838Ck4KBsh2z/04dkIVxnVpVt4/7apKrWXi2tl
HTQS1kSzR7tuaNs4U/LIiF8+1Uvn0ujlCPb+OKrE39k0chAmzLHGS6e+3jZ68cDAdwaK6f3URbVK
cD6oJDXCZpGThdCVa5CYAjGUtGBS7WyDpkoaC0pDKjiH2RT5+6MJy5VDT8HyXHOfJON0BjIF/wV6
Am/QNpVCsXlWOB8dI5iMoEG3VhJYMpdFcZWmtZ9y67TvCCgCN5KXm4cRwzFt05AArQeV9UCkjWda
W6EicqyFsVJTadcfbqIfpJHaiu06h8nv0+mcz8U83hLSagp03Nxe3F5G3y8v3l99uv6Mh29E6/vd
HAMq/W5yj+DMaZV3vqChJ42PA152AV9uPiLx16ufh5FTQk4WMA7BkKzKQjg+BJx1QKxVplKYJ5Dz
A8j19AnwaQdmz+Y/64DYYXgW+6or/3VQh7Q9pk1ZumwEcYXPhoZ6tPHGiZrKG4xDbwBhM+qVwzXn
az+ARFoE8gxRLpP4MZXiOMIEyirO8ZHZ0RtR5htweseCdx/fQbWKao8fnMBtJiATeYld4bqUyIk6
N/W9aIRgMRqkszUH1slX9RXHTWeci9KRCAExS8DqynBx3NQEy4qZZEROZDJM1Xq1qmkogsW4rA5S
iYPuCgfWvBG4CScEHW93vq2+vmLb+4V3XpAh6F64Cb0L/wFQSwMEFAAAAAgAPA/TXISWfntHCAAA
5hIAADQAAABJTlQtbmZzLXVib290LXJlYWRsaW5rLXNob3J0LXJlcGx5LXVuaW5pdC9wb2MvcnVu
LnNojVjbbhu7FX3XV+yMjdjqyUi+HJwkFpQen0RFjDa2YTtPaSCPZjgS4RE5ITl2XNtAn/oBRb/w
fEnXJqmbLQcJgkgakmvf1l7ck40X3caa7kiqrlDXNMrspLVB56Iq01wrl0klCjrV76nUho6OL1JV
2rQZae1SI7KikuoqtRNt+Gdd3aaNkkq6TmsDKGeNotLoKbmJtFRII3Knze0Blog6XdOojp3Qyp8N
ssI1Nf1Co0ZWBT6dkeOxMCRUkTqd4oO2AaSnU3wVRXsVLJyeg+WVVgIg+UTkV7pxVEvFARlRklbV
7erhYHLVk1dwXiiCvVpWosvxUjZGWqzjlWChIKsbk4tVuJnn6wKLsNjpUUbNOI3bpRqTVHXjfAov
OHM2N7J2hG9SOaGc1Cqrqlv61kjh6M9//2/maoTOkCNGjYhbFkB+Ka0nmRWERACfxpqcpoxqYeJC
pcdUIsyeT47HQFWNLpqcjQLGyjFs0zYvaZPllcABBSM1HHdsuQue8Gqh8wYlcpztBj5Pxey4a4zw
XteZkjl1yeLTyX8hVbAGKuHRjdFqnEZHkXTRxlqGMloGB5ITZirhSodOQLJMVgwaHK7EdQZfOBim
XTOt4QMita4QxqBUiJm5Kwxw8kyBmdlYacR/I92EWeJMdlNxIZj0MzZfALyprcPRqXeU0WP5EbtG
4QMLKAvUiFw7/3iIdEa3S2lAHC47F+ls8Pl88IFXbTOy4luDfPGiDQkOjAmlga2MlE51DZQb5s7C
XMXR3BL20cfB4Yen9tsd733oBiAdn1wApUCmuDxZ4/Q0czL3pOLCGDHV19jpaJqpxj/m1NClmVJq
ysj27iXJEji3uqEbzjhygM6sMjlFSu0V2TrLmSacRvYTq2nwQYnvPtCQ2cH3GsqwIMoSTXyksUNm
fLZBQLaVdmxPGy8DLWSLUtFoxF0LZgQe+cYZQnn6yeZ2XhD+xQ+VwUayeffH4fnH4fnJ57P3gy87
Xx+SdkIvX1J9U7STVggxHl3gxJwnrdbn0/OLs8Hhp+HZ4PRk+PnsH/1k4lxtD7rdMXLVjDrQjG6T
slTGj2Rx6PTo+HjwYYja9JP9vMjFzq9vy7c7xevX+X75dm9vt9wVo9f7+Lb/5tf8zdvXe/k+jAZN
zahslO9IZKoCZ6rbV57nXjuc9dRfEN73sp53CXJOfxei9p2EAsug8iYts5wBZp0FuohMHYCaeS6s
pT//818QEH+lFT2mcmw6fi6UbsYT4huDKwvbV0rfoHqg4sjoK+HpjmKy+WFwertNdy2Cr+AdVdlI
VMj0btIjO5GlW6zo8WoFOpt3fvdDB0sJ9smSXqCcvyf0Dh/8kPbevdzteYltsfiKfKIp+RJ0+Stt
+vM+AFH0gurpqtI39gAYL/f8mRyuR7TZI4N+NIp28aOUrQdPuaaOcWzQUSGmtWaB7tBRSZeXmwsS
XV7O21R8lxY18g211K4eYtGyr2Ctsb4HuSPnVw3KYa7lNXQwy41GWbxcjG7Rzdw1HgWdEYoH9YCU
1T348qhzLxedjWI97s92x+OcwKq5kV4Ya+GrKa75PmF3TKhpcKo0wk5AlUnGaaRSuHziIcp4G4jv
We68FAYF3IaUZ/Wiva0wQCZ/3DJOOrpNAwJjtXugfFU9vc9LnBhl+ZU3pCvwndB9rDnwCHqBLrkO
qW3qSme4AXkzeFrKse3QYQm2h+RGxFehJhBJ+CNLyfoYrnuP8kjX411yY6RD3QmXNQ848/uLt3Rx
zRknsypdykpsHdQSTYda+nSyETCEdIniWFwGJiu4ITOW/jCbxIMepEI1TCfw/8sXSlndFoTrdpCH
hL5+pX967rKyYRcEkPOTvl/ZnCCGa6TGoNQ+/L133UJcdxVyDlHs97F7jXQx/PNdxvxl9z3f+cuS
Qeb8WsTlPtsJfUY09H025LSb2G3YFAi9EoZfmF6xgbRes5QXax5yPnhmpfTb/DdfgA4EL1ANXDpS
LSdgJvjhOLLPJ3xxKU0LUaOvd9ccW85b+m05xUs5DObn9Ma+vw0u3n8cclVCkisr4s4QzVwYk/j4
2cREbN9CAF4X0bOnnhBm2cX1QfrTvn4zKUfLF/4nf+n/HBXb8yx79vLJhF78HCFnlPT0OfBwfY+A
bnLgZZw61iPNRJ+YwM6LfgznwVPS32FxRFsmaFBOJVKeWoPSGJ6ucAEvTbCLW5bVfSqN0cbOr4Gt
0/lrysGWH3/B0Nk4zgMyvP3wacDys3qH+3HWioDiNZdHt4nM+W6eTqW/aW63DAuyMLn0DToSEM8w
PGPWh/oIbLSsLE86OrwLeFGK70BPSUS/P9PauDC9isUWXu7Tpdvdb0mWUhyUD2MlrAYtS8vZG0N/
ikaF4D5+nobneKeC3KehF21/b76PB2kEmZYGo2Baa36vMrPVuZmT3dm3o9UZ0GFaT5bXFrKrhJut
rJyZZEZhiurkS6srp7r8Ys1F0mqxKdXrstMN7998YO07eK1zn+04L8d883z8CzPj0/nh8fDk9OLo
5Pi8z+Qe5roQ/Te/HeD6dkOthoLp2N89yEYAXTzYWRfYz7sUT797dD562ZkPbvPRzzq8BNj+5l+j
96lotRZSEFaDGLz57cd30exVPIx8YfZq1FwBfIdHwB/Pg886vn5GxL9jJIDS6S5tITnDWXKGPi1b
P0IM2bq/p7sYDQ/fTyBiy7I8xBjDS7P3qPcTXvfmLvegbGBNPmVtvts9SDFbPSStnF8/k008TmAm
lKKp2/P/sgkS2OthxVPh0UovNrDfEI3fA/k+SdorO3rzCPzWv7SXCtnYbCwOaHOH7vyRe3/ifgnu
YVECX83wFUjCZnnr/1BLAwQUAAAACADiDtNcNTShpUYAAABNAAAAOwAAAElOVC1uZnMtdWJvb3Qt
cmVhZGxpbmstc2hvcnQtcmVwbHktdW5pbml0L3BvYy9zdHVicy9pbWFnZS5oU85My0tJTVPw9HV0
d4334FIGcjLzUuH81IqS1KI8hdK84sz0vNQUhZz8vHSFzNzE9NT4nPzElPjElJQiay7l1LyUzDQu
AFBLAwQUAAAACADiDtNcNpl3YDoAAABHAAAAOQAAAElOVC1uZnMtdWJvb3QtcmVhZGxpbmstc2hv
cnQtcmVwbHktdW5pbml0L3BvYy9zdHVicy9sb2cuaFPOTMtLSU1T8PF3j/fgUgYyM/NS0XgpqUml
6Rp6enqaCin5CtUKtQrlGZk5qQoaBppcyql5KZlpXABQSwMEFAAAAAgA4g7TXAgJAr1iAAAAiQAA
ADwAAABJTlQtbmZzLXVib290LXJlYWRsaW5rLXNob3J0LXJlcGx5LXVuaW5pdC9wb2Mvc3R1YnMv
bWFwbWVtLmhTzkzLS0lNU/B1DPB19Y334FIG8jLzUhECZfmZKQpauYkF8cWVxbmpuRqlecWZ6Xmp
KQo5+XnpCgWJKSlFOgqogjmpeZrWEJ2leUhak/PziksUICaWgTQCVSmn5qVkpnEBAFBLAwQUAAAA
CADiDtNcW/oOxRwBAAAWAgAAOQAAAElOVC1uZnMtdWJvb3QtcmVhZGxpbmstc2hvcnQtcmVwbHkt
dW5pbml0L3BvYy9zdHVicy9uZXQuaG1QTWuEMBQ8N78i4EVBWnf3smBbKKKtsNWC7jnY5OkGbCKa
lH6w/71Jyra27iGPvJnMvHnxeCsYtLhIa/KAPHPlAk4dF7TXDPB1Mw7NlSHU5eF2Bk+KcbHEjMny
nfwPjVx0FlPvA9gEWky8E8AwPTQj1rbGS7KXosPa1hlpQmyJwnr7F9usLbhZxz97JWWR5fekyCpS
549pua/xKooiBEK/YLMe6aUcyKQaBfgTXZhv2JXlE8nu8h2+wVH4C1X7JEmryqCrEB1jBG8KRoHN
VOfzLKUiLe+BTPwDYmQtOTV0b2O8Ss7cs8keO80/l8DVAJkgvlUEro/R8ZybdhMHrahvM1Ana11P
Q+PEpFaB1Z6+4psK5kIj8kAw3qIvUEsBAhQDFAAAAAgAZbLvXMCFtZnWBwAAcBMAADMAAAAAAAAA
AAAAAIABAAAAAElOVC1uZnMtdWJvb3QtcmVhZGxpbmstc2hvcnQtcmVwbHktdW5pbml0L1JFQURN
RS5tZFBLAQIUAxQAAAAIAOIO01wVIttQyQIAADQGAAA3AAAAAAAAAAAAAAC0gScIAABJTlQtbmZz
LXVib290LXJlYWRsaW5rLXNob3J0LXJlcGx5LXVuaW5pdC9wb2MvaGFybmVzcy5jUEsBAhQDFAAA
AAgAPA/TXISWfntHCAAA5hIAADQAAAAAAAAAAAAAAO2BRQsAAElOVC1uZnMtdWJvb3QtcmVhZGxp
bmstc2hvcnQtcmVwbHktdW5pbml0L3BvYy9ydW4uc2hQSwECFAMUAAAACADiDtNcNTShpUYAAABN
AAAAOwAAAAAAAAAAAAAAtIHeEwAASU5ULW5mcy11Ym9vdC1yZWFkbGluay1zaG9ydC1yZXBseS11
bmluaXQvcG9jL3N0dWJzL2ltYWdlLmhQSwECFAMUAAAACADiDtNcNpl3YDoAAABHAAAAOQAAAAAA
AAAAAAAAtIF9FAAASU5ULW5mcy11Ym9vdC1yZWFkbGluay1zaG9ydC1yZXBseS11bmluaXQvcG9j
L3N0dWJzL2xvZy5oUEsBAhQDFAAAAAgA4g7TXAgJAr1iAAAAiQAAADwAAAAAAAAAAAAAALSBDhUA
AElOVC1uZnMtdWJvb3QtcmVhZGxpbmstc2hvcnQtcmVwbHktdW5pbml0L3BvYy9zdHVicy9tYXBt
ZW0uaFBLAQIUAxQAAAAIAOIO01xb+g7FHAEAABYCAAA5AAAAAAAAAAAAAAC0gcoVAABJTlQtbmZz
LXVib290LXJlYWRsaW5rLXNob3J0LXJlcGx5LXVuaW5pdC9wb2Mvc3R1YnMvbmV0LmhQSwUGAAAA
AAcABwDJAgAAPRcAAAAA

--_004_DM6PR07MB4377345499126288E3256596F6F82DM6PR07MB4377namp_--
