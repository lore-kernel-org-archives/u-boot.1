Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7106B109E529
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 04:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120D98409B;
	Thu, 26 Mar 2026 05:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Student.rmit.edu.au header.i=@Student.rmit.edu.au header.b="LFSZxTtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEDC83A1B; Thu, 26 Mar 2026 05:41:19 +0100 (CET)
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40d::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFCB81E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=student.rmit.edu.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=S4210155@student.rmit.edu.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYbRqOPG+t/S/yE7IorvizUhnlRRrQqXezT6iCag9SwotVkQZYrFwS3xkzOLCd93VoOD96AfXjUP8tCb4iYPLkNUCUmllCg+mOf2iFQOq1YxkSLDph9X/9gSPSi8AbQ4JGeyKH/gf6NBqhfHvym93dsOq3UvqWw8cGMCNyOGWm++fFAvBlwQtWoSGoQ0DLpbpBLBLwbIO/HSHtAk/lugGavuLrXN6SPdx1QTR0lc6bPR9XIuUeP0PFc+OJlSfdJbuzaOeJiB9796+/RpgZizOduDHUHFkrjIHR3+rVlfHiehlsXUYKR4epqxyl6sVNtickVyvEhlk/2RxLmf0dd5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hki1jvkYj+2AyDaDeFAJeIV5vjgN6FmjsDlWqFNep+E=;
 b=UVYGmdqBA20WqePY/gozcpVhFza/BC4nj/X/blvN3+DNOD/2x63PLBGSfDcvCpldlEXha56iJycUgfw5COzsi6XZMjLs0W8YlEzLLGmycZMXiFQh830BSylByD5+DfiOmmmjNF4ELh8VCwr5BiF+jc1zyIOXYDQ17lrnnD1L0YXQ1OUrIaLy9wkyM0L/iMwIhCEZP/ognfl9M2fSxm1RKkTrE0MGpjwJV82Jhdqe+6JfTmu9W1ODEJi/0yeNXz1Hdo4uupVZX+ebb6HzGMJQ47XgcVzldCHooE8eFZ786csd6Hx9t5l/hzQoOYGvNFCsL/xpY6mHvPVXLFDsPsyQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.rmit.edu.au; dmarc=pass action=none
 header.from=student.rmit.edu.au; dkim=pass header.d=student.rmit.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Student.rmit.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hki1jvkYj+2AyDaDeFAJeIV5vjgN6FmjsDlWqFNep+E=;
 b=LFSZxTtnJYB57rJVLUY+wRWQlsZskMJBU9J5IJSax44nsiKOsXjIHnpeGTfVebS7PzzDnBCLcSCUgJN63LTbMJgSZXkreNsE7z/yd+u2a8wH5Us24DnhcPM0BcjJXo8+dwxkl6r99NPhAM+7q3zGZOQb6eCWmirxKWXWm4G3meI=
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com (2603:10c6:10:10e::6)
 by SY7PR01MB9722.ausprd01.prod.outlook.com (2603:10c6:10:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Thu, 26 Mar
 2026 04:41:05 +0000
Received: from SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac]) by SY4PR01MB6316.ausprd01.prod.outlook.com
 ([fe80::4998:560d:aff9:c9ac%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 04:41:05 +0000
From: Tra Ngo <S4210155@student.rmit.edu.au>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "stefan_b@posteo.net" <stefan_b@posteo.net>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: [SECURITY][1/4] Stack buffer overflow in NanoPi2 board code
 (CONFIG_SYS_CBSIZE-dependent)
Thread-Topic: [SECURITY][1/4] Stack buffer overflow in NanoPi2 board code
 (CONFIG_SYS_CBSIZE-dependent)
Thread-Index: AQHcvNSfu1iLwOm/CU6jo9JOP4Qghg==
Date: Thu, 26 Mar 2026 04:41:04 +0000
Message-ID: <SY4PR01MB6316CA7533B4F9E6D5899EB09A56A@SY4PR01MB6316.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.rmit.edu.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4PR01MB6316:EE_|SY7PR01MB9722:EE_
x-ms-office365-filtering-correlation-id: 822441af-3b3e-4ddd-2b19-08de8af1e3ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|6049299003|1800799024|786006|376014|8096899003|4053099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: FkTiyUutPAz+50IvRqCgn53LZkSMrwqUQ9ugb5hSw6I9Rv1gh5Y+m6Tw4bC77xKo6D9xr6PPFYC3CHwc1Ppsi1P7Cc7tflCmZSwE4cGzP8cI+D417/Fs6cq8lgfXZ+ihO4V3pIqqO2gMN8hLuNyyX0yQ+vNk3GxHUc8HPonUfwF32M3AdwNY98YRL8uKaM3E9bNWH1nyq00XCtWjsXPA/yd64xjdalCvAMqyPVbTSG06mtVrgr0gAg1v5dxU5Z6avV9XWRlqUE+MuMG5d5NuNDmjTBRBhbK55f2cj1gXNR70lKXyWjnjKRqOe2P6mqh2wBITxtcgMD1abjQu9pEwVmeNk70T0OfbG60LuJ8Cagu/n0bEj7PY3CxPPAkGGVijyRj3LW94VxtRZcOGrgUwJM1mumdJYRA/DX9gLFLL6Z8DAer8IM3Fiam0kHpbnmtH8UVDcu0zfpuCWtmSm+vyUCNxC2rpBGbROXKBbzEr+bVqIYpAkPj9N4BOVGiJOBQ3lUD13OyB5oB0gNB46YLGkvWjbPlIoi3PzOiutf4nL1GI05yDzAr6dgrkeFR51TPYfkS8A9pU1xSfX6B3MNCQMbTTVXlnVuCw6iDbV0gCnycJcypF6JQrquKh2KXX70iWU7bP1xr++nbdTLNaH+pD6aJyQUJdKDWV0Ru/ij/HO4v9HmkE66GW5zbpbtgtQ0do17dxYSNdp0A7yVs+jZEMS78hRIAZI8jKuvtPHlQRQI4O0T0zbZRdywbaR7gGIVMDZ9GL0yAwt5UncMy5aKwpj2l6YPc+o97Xh9YJ3MNDgps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY4PR01MB6316.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(6049299003)(1800799024)(786006)(376014)(8096899003)(4053099003)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IrXVi5m6m5VDRlCDTuKDFESWlKo+8/LY7H5tyM/f/ztZG3CRiSGvyC/HlOBy?=
 =?us-ascii?Q?7rQnSoN+iiI9VRUKyWbZLWWwXrmsbavod5I4Va6GEKzCECs7DHxjoQ4u5Ggg?=
 =?us-ascii?Q?UdLpMEt8w9sZ99K13Z7eJJ2AZ/dhmWtnoqW2MuApbgIP+9E3NVC/RmLT9yEU?=
 =?us-ascii?Q?clkkLmQGTE8f0KYqV5Bpq5iY+6Gj/Hx0nZNJXZB2kOk9Py26dBkufi0JH5mV?=
 =?us-ascii?Q?KCqPi9SubVgw859ecPqIXAwKfFYhQCJX3xij2iWXhshg3Wrbc7D6sBsHwYbk?=
 =?us-ascii?Q?ycmVUNQLoeJQEXxZY2+BXvxU9aY3M9UsT1tos3EIGU9WZWBQtwJ7WXrJAv8k?=
 =?us-ascii?Q?ixuJpjNds7qaqGV3DtktGo79fpCuMyRZSLzPy4Vf8INnga7Q7G9tT3C9AbeC?=
 =?us-ascii?Q?xywMfCGjhgx5Snj50mlUqPW2+bNgKWfXJYL6HHGR5bPrsq7pbeu0gpVjzYbJ?=
 =?us-ascii?Q?Rv2X93v+CdPKTxTlUjcXKGpWm0ckTG8ZadjZG7lDfPURI2pBNlykekyaDNWZ?=
 =?us-ascii?Q?Pwkw6zuVJximSW+hbjtq7wnzAUNkQ/3+vYJxpWi4/2psfAaKbYcbLe6in0YQ?=
 =?us-ascii?Q?MRhInusNj2k+1honqOBGO8x3D20835Z3KCn2nr1PvfveY3K8VcnEc2Sv+hpz?=
 =?us-ascii?Q?CFMC3fCMK2PBfnpdmJgJadY1gCmJ518sAX9AAELEfcMq0tvOByMLV6F/hJ6X?=
 =?us-ascii?Q?hsTpOuFuoR9XWc/+ZsDKoZH19mdaXbOFzbfxPSLznAUSto9Jb9TyBltLcbVc?=
 =?us-ascii?Q?MCsQvIhPfShvr3X/qPVjEB7t80dUv+/Xc+VKrXcJqZOsPp2hWUtcs41Rh1Tn?=
 =?us-ascii?Q?9cPV2S5TzRBtoOIL2Idn9doDOXI+MzeG/bwFMwfochJbFcWdKRx6CbXjCWCB?=
 =?us-ascii?Q?l2lY8NYbJLyjGCNUkQ1Hx00kBiP1bGua0FHJSfNCofDVw3GIT09tf52Mh5KI?=
 =?us-ascii?Q?eNXwANKU0dKFcCH5mA41Bg39Lf/UABEVCw8zLKZ95DcA7xve37qp+ioP4Z/2?=
 =?us-ascii?Q?IHz48Xut/KkaplFwBbXEaXkP7JaSQ/297KdAtYiMZx5hOvuvdTlpss51mWIq?=
 =?us-ascii?Q?YUx13MlztD5pxqpZhbzFobnxUTj8lEfsEOhbN+I2zoxpRUcLZMYd0EtkieeA?=
 =?us-ascii?Q?nPCJ1IwMkJDuWBItKdwIZ/cw2OLl5vJJ7llbip3jJMMBpPGAstmYoul7lmmD?=
 =?us-ascii?Q?3fQQd5A5DuNUOlfyNiFeOFQmCUm92Mk9XFmkj06aVKX7wu+wgC842Xkg0ZwQ?=
 =?us-ascii?Q?VH+AER6y6o8aj9tdZADs6XTApr+PwlMh4/nPGXxej+81qTqlS32g6vlymrEi?=
 =?us-ascii?Q?TQutbqXDRsGppm6XteItSPzQQlLCZ3J97Bp104n6BFl3fKnBBREIuizMYVVO?=
 =?us-ascii?Q?EJU0X/lYgX1F+AlRPErjoHyQRgZqGHd1fiRnJOdAQ40qxcOu+2jqcWaL2XC4?=
 =?us-ascii?Q?qvVWuCAf4tKWJty97BwauTyrzD7t3MMdlZludsseOQoIp25Ut2K0NOvgqEOY?=
 =?us-ascii?Q?44vZJz4BEKX2KZMI9bXgmfHdM7j/zQt4K3lQCtzZdJWlZ8+WcgkifzVNM/sl?=
 =?us-ascii?Q?2eM9Jnc2+Bv8mtrJHMPB+/s80DMpCCxFsrVPHksSDOBtWG2+WMvwnS1+Omhz?=
 =?us-ascii?Q?AFYKwfKavbSgItx36qsQJSBQN6ZRD9Itk7cXQJVQccHL8SjAn05QM+sYRDsO?=
 =?us-ascii?Q?gCHkw8fgA21Jy0FyYHIG7owoj5ntRrEuFrf+KItIiWBg4JkKH4P8GKfgRKcb?=
 =?us-ascii?Q?z1gyafGAYNFOvPUvVlbf1V3vYl9PpAWyinftcMNmnaVP8B8Co3n+?=
Content-Type: multipart/mixed;
 boundary="_004_SY4PR01MB6316CA7533B4F9E6D5899EB09A56ASY4PR01MB6316ausp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W18pKuA2wGJw1s/6yesPTUP6K0tAAvXRtnOcWE9Y0fgxbamM77EAQ2u8WeHbu7fWKYZx83L6zQ+vEUoju0yBLpkdEkqTdHvgOzrIA0x5y5+cm8/3OaKyNvz9UEfsWRiu7kikFqMvBnwSCLKO8T4E4/9fYWN2YUSAfp+IptJ50MwrNZhWb4Wfv1Aubl8WoOvm+pVfXqaWWUme5VuMta5LmiQOeYRP0eujw6ma5AydeCWQzuY6BT7nHPA+slcaUeJj5J9fMaCxhAw0qPen7WSVly/6OYZlO8ehFvTdL3/sjOpGYCVu8viH0b5e2PM0OA4/DU9tzlHO8G8gJF6A13bwaQ==
X-OriginatorOrg: Student.rmit.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY4PR01MB6316.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822441af-3b3e-4ddd-2b19-08de8af1e3ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 04:41:04.6481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d1323671-cdbe-4417-b4d4-bdb24b51316b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onF5UE1F04vLAyfQTTCQ69hR+sT/+m75Tpa9bEQh+m1NbfB5WX+xE2w06iQX3iTA0BwWC2gthXFtdn0IT6arNc5Q4f3jF3EKIWh5QM8A028=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB9722
X-Mailman-Approved-At: Thu, 26 Mar 2026 05:56:45 +0100
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

--_004_SY4PR01MB6316CA7533B4F9E6D5899EB09A56ASY4PR01MB6316ausp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear U-Boot maintainers,

I would like to report a potential stack buffer overflow in the NanoPi2 boa=
rd code (board/friendlyarm/nanopi2/board.c, bd_update_env()).

The issue arises from unbounded sprintf()/strcpy() calls on a buffer sized =
by CONFIG_SYS_CBSIZE, where initial size checks do not account for subseque=
nt appends.

This is configuration-dependent and can lead to overflow under certain sett=
ings.

I have attached a detailed analysis, including root cause, reproduction, an=
d suggested fix.

This is part of a set of related configuration-dependent issues; I will rep=
ort others in separate emails.

Please let me know if you would like a patch or further details.

Best regards,
Ngo Tra


--_004_SY4PR01MB6316CA7533B4F9E6D5899EB09A56ASY4PR01MB6316ausp_
Content-Type: application/octet-stream; name="UCCG-UBOOT-01.md"
Content-Description: UCCG-UBOOT-01.md
Content-Disposition: attachment; filename="UCCG-UBOOT-01.md"; size=4918;
	creation-date="Thu, 26 Mar 2026 04:28:18 GMT";
	modification-date="Thu, 26 Mar 2026 04:28:18 GMT"
Content-Transfer-Encoding: base64

PT09IFtVQ0NHLVVCT09ULTAxXTogbmFub3BpMiBib290YXJncyBjbWRsaW5lIGJ1aWxkIGNhbiBv
dmVyZmxvdyAoU1lTX0NCU0laRS1kZXBlbmRlbnQpID09PQoKU3VtbWFyeQotLS0tLS0tCi0gVHlw
ZTogc3RhY2sgYnVmZmVyIG92ZXJmbG93IChjb25maWctZGVwZW5kZW50KQotIEFmZmVjdGVkIGNv
bXBvbmVudDogYm9hcmQtc3BlY2lmaWMgYm9vdGFyZ3MgY29uc3RydWN0aW9uIGZvciBGcmllbmRs
eUFSTSBOYW5vUGkyCi0gU2V2ZXJpdHkgKHJlcG9ydGVy4oCZcyBlc3RpbWF0ZSk6IEhpZ2ggKHN0
YWNrIG92ZXJmbG93IGluIFUtQm9vdCBjb250ZXh0KQoKRW52aXJvbm1lbnQgLyBWZXJzaW9uCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLQotIFUtQm9vdCB0cmVlOgogIC0gTG9jYWwgdHJlZTogdWNjZy91
LWJvb3QgKHdvcmtzcGFjZSkKLSBCb2FyZCAvIHRhcmdldDoKICAtIEZyaWVuZGx5QVJNIE5hbm9Q
aTIgKGJvYXJkL2ZyaWVuZGx5YXJtL25hbm9waTIpCgpGaWxlcyBhbmQgTG9jYXRpb25zCi0tLS0t
LS0tLS0tLS0tLS0tLS0KLSBTb3VyY2UgZmlsZTogYm9hcmQvZnJpZW5kbHlhcm0vbmFub3BpMi9i
b2FyZC5jCi0gRnVuY3Rpb246IGJkX3VwZGF0ZV9lbnYoKQotIEJ1ZmZlcjoKICAtIGJvYXJkLmM6
MzI5OiBjaGFyIGNtZGxpbmVbQ09ORklHX1NZU19DQlNJWkVdOwotIENvcHkvZm9ybWF0IHNpbmtz
ICh1bmJvdW5kZWQgdnMgcmVtYWluaW5nIGJ1ZmZlcik6CiAgLSBib2FyZC5jOjM2OC0zNjk6IHN0
cmNweShjbWRsaW5lICsgbiwgbmFtZSk7CiAgLSBib2FyZC5jOjM3MjogbiArPSBzcHJpbnRmKGNt
ZGxpbmUgKyBuLCAiLCVzZHBpIiwgbGNkZHBpKTsKICAtIGJvYXJkLmM6Mzc3OiBuICs9IHNwcmlu
dGYoY21kbGluZSArIG4sICIsJWRkcGkiLCBkcGkpOwogIC0gYm9hcmQuYzozODQtMzg1OiBzdHJj
cHkoY21kbGluZSArIG4sIHApOwogIC0gYm9hcmQuYzozOTEtMzkyOiBuICs9IHNwcmludGYoY21k
bGluZSArIG4sICIlczIiLCBDTURMSU5FX0JERVYpOwotIFJlbGV2YW50IGNvbmZpZyBvcHRpb24o
cyk6CiAgLSBDT05GSUdfU1lTX0NCU0laRSAoY29tbW9uL0tjb25maWcpCgogIGNvbW1vbi9LY29u
ZmlnCiAgYGBgCmNvbmZpZyBTWVNfQ0JTSVpFCglpbnQgIkNvbnNvbGUgaW5wdXQgYnVmZmVyIHNp
emUiCglkZWZhdWx0IDEwMjQKICBgYGAKCkNvbmZpZ3VyYXRpb24tZGVwZW5kZW50IGRhdGFmbG93
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi0gQ09ORklHX1NZU19DQlNJWkUKICDi
hpIgY29tcGlsZS10aW1lIHNpemUgb2Ygc3RhY2sgYnVmZmVyIGBjbWRsaW5lW11gCiAg4oaSIHVz
ZWQgdG8gaG9sZCByZWJ1aWx0IGBib290YXJnc2Agc3RyaW5nCi0gUnVudGltZSBpbnB1dHMgY29u
dHJpYnV0aW5nIHRvIHRvdGFsIGZvcm1hdHRlZCBsZW5ndGg6CiAgLSBlbnYgdmFyIGBib290YXJn
c2AgKHN0cmluZykKICAtIGVudiB2YXIgYGxjZHR5cGVgIChhZmZlY3RzIGBuYW1lYCkKICAtIGVu
diB2YXIgYGxjZGRwaWAgKHN0cmluZykKICAtIGNvbXB1dGVkIGBkcGlgIChpbnRlZ2VyKSB3aGVu
IGBsY2RkcGlgIHVuc2V0CiAgLSBhcHBlbmRlZCB0b2tlbnM6ICIgbGNkPSIsICIsJXNkcGkiLyIs
JWRkcGkiLCAocmVtYWluaW5nIGJvb3RhcmdzIHRhaWwpLCAiIGJvb3RkZXY9MiIKClZ1bG5lcmFi
aWxpdHkgZGVzY3JpcHRpb24KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotIEV4cGVjdGVkIGlu
dmFyaWFudDoKLSBUaGUgZnVuY3Rpb24gbXVzdCBuZXZlciB3cml0ZSBtb3JlIHRoYW4gYHNpemVv
ZihjbWRsaW5lKWAgYnl0ZXMgd2hpbGUgY29uc3RydWN0aW5nIHRoZSBuZXcgY29tbWFuZCBsaW5l
LgoKLSBBY3R1YWwgYmVoYXZpb3I6Ci0gVGhlIGZ1bmN0aW9uIGNyZWF0ZXMgYGNtZGxpbmVgIG9u
IHRoZSBzdGFjayBzaXplZCBieSBgQ09ORklHX1NZU19DQlNJWkVgLgotIEl0IHBlcmZvcm1zIG9u
ZSBzaXplIGNoZWNrIGJlZm9yZSBhcHBlbmRpbmcgYCIgbGNkPSJgIGFuZCBgbmFtZWA6CiAgLSBi
b2FyZC5jOjM1MCBjaGVja3MgYChuICsgc3RybGVuKG5hbWUpICsgc2l6ZW9mKENNRExJTkVfTENE
KSkgPiBzaXplb2YoY21kbGluZSlgIGFuZCBhYm9ydHMgaWYgdG9vIGxhcmdlLgotIEFmdGVyIHRo
YXQgY2hlY2ssIHRoZSBmdW5jdGlvbiBjb250aW51ZXMgdG8gYXBwZW5kIG1vcmUgZGF0YSB1c2lu
ZyBgc3ByaW50ZigpYCBhbmQgYHN0cmNweSgpYCBpbnRvIGBjbWRsaW5lICsgbmAgd2l0aG91dCBj
aGVja2luZyB0aGUgcmVtYWluaW5nIGNhcGFjaXR5LgotIFRoZXJlZm9yZSwgaXQgaXMgcG9zc2li
bGUgZm9yIHRoZSBwcmUtY2hlY2sgdG8gcGFzcywgd2hpbGUgdGhlIGxhdGVyIGZvcm1hdHRpbmcg
c3RlcCBvdmVyZmxvd3MgdGhlIHN0YWNrIGJ1ZmZlci4KCi0gQ29uY3JldGUgb3ZlcmZsb3cgY29u
ZGl0aW9uIGF0IGJvYXJkLmM6MzcyIChgc3ByaW50ZihjbWRsaW5lICsgbiwgIiwlc2RwaSIsIGxj
ZGRwaSlgKToKICAtIExldCBgUyA9IENPTkZJR19TWVNfQ0JTSVpFYCwgYG4wID0gaW5pdGlhbCBu
IGFmdGVyIGhhbmRsaW5nIGJvb3RhcmdzYCwgYE4gPSBzdHJsZW4obmFtZSlgLgogIC0gQWZ0ZXIg
YXBwZW5kaW5nIGAiIGxjZD0iYCBhbmQgYG5hbWVgLCBgbiA9IG4wICsgNSArIE5gIChzaW5jZSBz
dHJsZW4oIiBsY2Q9IikgPT0gNSkuCiAgLSBgc3ByaW50ZigiLCVzZHBpIiwgbGNkZHBpKWAgd3Jp
dGVzIGBzdHJsZW4obGNkZHBpKSArIDVgIGJ5dGVzIChpbmNsdWRlcyAiLCIsICJkcGkiLCBhbmQg
dGVybWluYXRpbmcgTlVMKS4KICAtIE92ZXJmbG93IG9jY3VycyB3aGVuIGBTIC0gbiA8IHN0cmxl
bihsY2RkcGkpICsgNWAuCgotIFdoeSBgQ09ORklHX1NZU19DQlNJWkUgPSAxYCBkb2VzIG5vdCBv
dmVyZmxvdyBhdCAzNzI6CiAgLSBUaGUgZWFybGllciBndWFyZCBhdCBib2FyZC5jOjM1MCB3aWxs
IHRyaWdnZXIgYW5kIGV4aXQgYmVmb3JlIHJlYWNoaW5nIGJvYXJkLmM6MzcyLgogIC0gSG93ZXZl
ciwgbWFueSBzbWFsbC1idXQtbm90LXRpbnkgc2l6ZXMgY2FuIHN0aWxsIG92ZXJmbG93IGF0IDM3
MiBiZWNhdXNlIHRoZSBndWFyZCBkb2VzIG5vdCBhY2NvdW50IGZvciBsYXRlciBhcHBlbmRzLgoK
SW1wYWN0Ci0tLS0tLQotIFBvdGVudGlhbCBpbXBhY3Q6Ci0gU3RhY2sgY29ycnVwdGlvbiAvIGNy
YXNoIC8gdW5kZWZpbmVkIGJlaGF2aW9yIGR1cmluZyBlbnZpcm9ubWVudCB1cGRhdGUgKGJvb3Rh
cmdzIHJlY29uc3RydWN0aW9uKS4KLSBQcml2aWxlZ2UvY29udGV4dDoKLSBFeGVjdXRlcyBpbiBV
LUJvb3QgYm9hcmQgaW5pdCBwYXRoOyBvdmVyZmxvdyBpcyBvbiBzdGFjayBpbiBgYmRfdXBkYXRl
X2VudigpYC4KClJlcHJvZHVjdGlvbiAoZXhhbXBsZSkKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQot
IEV4YW1wbGUgY29uZmlndXJhdGlvbiAvIGVudmlyb25tZW50IChjb25jZXB0dWFsKToKICAtIFNl
dCBgQ09ORklHX1NZU19DQlNJWkVgIHRvIGEgc21hbGwgdmFsdWUgKHNtYWxsIGVub3VnaCB0aGF0
IGBjbWRsaW5lW11gIGlzIHRpZ2h0LCBidXQgbGFyZ2UgZW5vdWdoIHRvIHBhc3MgdGhlIGd1YXJk
IGF0IGJvYXJkLmM6MzUwKS4KICAtIEVuc3VyZSBgYm9vdGFyZ3NgIGlzIHNldCBhbmQgbG9uZyBl
bm91Z2ggc28gdGhhdCBgbjAgPSBzdHJsZW4oYm9vdGFyZ3MpYCBtYWtlcyB0aGUgY2hlY2sgcGFz
cyBuZWFyIHRoZSBib3VuZGFyeS4KICAtIFNldCBgbGNkZHBpYCB0byBhbnkgc3RyaW5nIChldmVu
IGVtcHR5IHN0cmluZyBjYW4gYmUgZW5vdWdoKS4KCi0gT25lIGNvbmNyZXRlIG51bWVyaWMgZXhh
bXBsZSAoc2hvd2luZyBvdmVyZmxvdyBhdCBib2FyZC5jOjM3Mik6CiAgLSBgQ09ORklHX1NZU19D
QlNJWkUgKFMpID0gMjBgCiAgLSBgc3RybGVuKGJvb3RhcmdzKSAobjApID0gMTBgCiAgLSBgc3Ry
bGVuKG5hbWUpIChOKSA9IDRgCiAgLSBHdWFyZCB1c2VzIGBzaXplb2YoIiBsY2Q9IikgPT0gNmAs
IHNvIGl0IGNoZWNrcyBgMTAgKyA0ICsgNiA9IDIwYCBhbmQgcGFzc2VzLgogIC0gQWZ0ZXIgYXBw
ZW5kaW5nIGAiIGxjZD0iYCBhbmQgYG5hbWVgLCBgbiA9IDEwICsgNSArIDQgPSAxOWAsIHJlbWFp
bmluZyBjYXBhY2l0eSBpcyBgMWAuCiAgLSBgc3ByaW50ZigiLCVzZHBpIiwgbGNkZHBpKWAgbmVl
ZHMgYXQgbGVhc3QgYDVgIGJ5dGVzIGV2ZW4gd2hlbiBgbGNkZHBpPSIiYCAoIixkcGlcMCIpLgog
IC0gUmVzdWx0OiBvdmVyZmxvdy4KClN1Z2dlc3RlZCBmaXggKGNvbmNyZXRlKQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQotIFJlcGxhY2UgdW5ib3VuZGVkIGBzcHJpbnRmKClgL2BzdHJjcHkoKWAg
d2l0aCBib3VuZGVkIG9wZXJhdGlvbnMgdHJhY2tpbmcgcmVtYWluaW5nIHNpemUuCi0gUHJlZmVy
IGBzbnByaW50ZihjbWRsaW5lICsgbiwgc2l6ZW9mKGNtZGxpbmUpIC0gbiwgLi4uKWAgYW5kIGNo
ZWNrIHRoZSByZXR1cm4gdmFsdWU6CiAgLSBJZiByZXR1cm4gdmFsdWUgPCAwIG9yID49IHJlbWFp
bmluZywgYWJvcnQgKG9yIHRydW5jYXRlIHNhZmVseSkgYW5kIGRvIG5vdCB1cGRhdGUgYGJvb3Rh
cmdzYC4KLSBFbnN1cmUgdGhlIGluaXRpYWwgc2l6ZSBndWFyZCBhY2NvdW50cyBmb3IgKmFsbCog
bGF0ZXIgYXBwZW5kcyAoZHBpIHN1ZmZpeCwgcmVtYWluaW5nIGJvb3RhcmdzIHRhaWwsIGJvb3Rk
ZXYgdG9rZW4pLCBvciByZW1vdmUgdGhlIGFkLWhvYyBndWFyZCBhbmQgcmVseSBvbiBjb25zaXN0
ZW50IGJvdW5kZWQgYXBwZW5kcyBldmVyeXdoZXJlLgoKUmVwb3J0ZXIKLS0tLS0tLS0KLSBOYW1l
OiBOZ28gTHVvbmcgVGhhbmggVHJhCi0gRW1haWw6IFM0MjEwMTU1QHN0dWRlbnQucm1pdC5lZHUu
YXUKLSBUb29sIHVzZWQ6IFVuaWZpZWQgQ29uZmlnQ29kZSBHcmFwaCAoVUNDRyksIGEgY29uZmln
dXJhdGlvbi1hd2FyZSBzdGF0aWMgYW5hbHlzaXMgcHJvdG90eXBlLgotIERhdGUgb2YgZGlzY292
ZXJ5OiAyMDI2LTAzLTI1Cg==

--_004_SY4PR01MB6316CA7533B4F9E6D5899EB09A56ASY4PR01MB6316ausp_--
