Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C3E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 14:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8C380602;
	Thu,  9 Jan 2025 15:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOdT5eYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 395A5801F5; Thu,  9 Jan 2025 13:45:37 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24746800D0
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBfpmkPuu8UbUG4nDB91cEPro5pPFkqCZaePnfTiFovDetfDgcenes0TN5xDC6w7mp6RAwxITIQPgSz0qJHwpWLaA1NDZf3bvl6R/uqz38kpLSafvQkfWlqVTbmsPpbp9L0brwQpnG8NKayj6y7tjRhJinlOIUwvN1u9+HcGFKsufmD2AMeBdvAPsqJxzzLPn8HalYZYW2PpoZhMAk7SR1UyIlwQLCFtp5ErFHqegVbtyt4kQjyx29TOOF/lB0vQbRsclSgKRRcGqCMGTny9p28uube5EOr+PTbDdY+a0VIHdkYicyE3dlDiO9PhewMjNGcY0Ii4EB/D4r4k3mvrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpSfbhklZrI4qEOQQsJC2vzfxmXdlZtjYse7wltfGn8=;
 b=UXkjvEswjkK50pf7aQ31yII9c9RvBKFXJLRxVxGeywU2lIl19BYSHrubXrcKcILgzi5BtojTMrskrG4UPehELLvpGYD+GZELOHT0yTrBswAPrajoQSGFvq7vaHCYRzj5+a0ARN0WFfzkFN5mi6+9+Gb/ZUo3fxvJNfkXW7NfTTbCzLRcjecqnnJOnQ/yuviSvdIMkUDcA9VOxJ7xaTLbXnsry4hTrfgNvRrpgJk1BidLISf/0HN94VDiL1Hht2VW4oexYDkrOXsR7DBjHB3OUwowQa6TpvDqLIJLGzahsbMBCAcVKoX/F/jQOIsmtfNZ3peq35nBu1jFh5AWiQjDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpSfbhklZrI4qEOQQsJC2vzfxmXdlZtjYse7wltfGn8=;
 b=nOdT5eYCqej5XCqh7a0G/+SfJLxktzdoztjU2tssm6IrNmgZrB/qevFZv4jFeM+J5OLYKATJ3929qnL4ooFg4Et22a1CKGk6+u5SKyFbtWJCg9GTLFhQfZ8jUZpZOwCBqRW4ayKNo7eLNIQxcKM4ieTFChgKdTZuXc1uO5dgqnk=
Received: from MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 12:45:30 +0000
Received: from MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::8146:4908:c42d:7eb5]) by MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::8146:4908:c42d:7eb5%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 12:45:30 +0000
From: "Erkiaga Elorza, Ibai" <ibai.erkiaga-elorza@amd.com>
To: Alexander Dahl <ada@thorsis.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek, Michal"
 <michal.simek@amd.com>
Subject: Re: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info
Thread-Topic: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info
Thread-Index: AQHbYdY0LhM6gWKBdEOYldMYfJxxD7MOEyuAgABRs9Q=
Date: Thu, 9 Jan 2025 12:45:30 +0000
Message-ID: <MN0PR12MB600443410FBC58B96C973CD5A0132@MN0PR12MB6004.namprd12.prod.outlook.com>
References: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
 <20250108140357.969380-2-ibai.erkiaga-elorza@amd.com>
 <20250109-auction-blob-00a19a40dbb8@thorsis.com>
In-Reply-To: <20250109-auction-blob-00a19a40dbb8@thorsis.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-09T12:45:29.959Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6004:EE_|BL3PR12MB6643:EE_
x-ms-office365-filtering-correlation-id: 01d752b6-00a7-4389-80c3-08dd30ab800f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?R+ShFocTAsZ87qudO7RBc5tjh4CjZZiBpUHAFq8YLIzQN76hLygLplJRg2?=
 =?iso-8859-1?Q?VB/2kVX+y2m49W4Tqmhole9EM16/i1COj5Hhx3H6m80lYZq2j8dVJ73bCt?=
 =?iso-8859-1?Q?IqjPE0P/IbDJ9A7tSh5r6Dmpyv2RZVoa5MgIqJlTd0RK0xckSgMYEIk20A?=
 =?iso-8859-1?Q?gqQpIbZZOUW1R2GLoj6HupyAbGOGlQZ1e9fXDQQuxChsKPoejAMv2eE+2b?=
 =?iso-8859-1?Q?subAZ4EnRhsNw20/s7uzXywe7pYUXN4rOpqs4z1F4mLS2nj66Qt65uITnm?=
 =?iso-8859-1?Q?ljV0fKjURXpTcaikWGNAO9IIPTjIxge12FjFv/Ji/AacN+gdfOOvW8MrlP?=
 =?iso-8859-1?Q?R3oGKGbXkA6XeAtw1OarO/q/+dqr5QyFHy8Qt8jJZj/cFuglwttR08HBZ7?=
 =?iso-8859-1?Q?w/D1JDkP3MEipzGpegD2Ev1Oas57QYkibsx360P+0z9u+eIEpdgJ8RsMu4?=
 =?iso-8859-1?Q?7nR10+4xBluE+UeNBz4fLPL0rPafVzyp3Y2h1stKoWGTJKQ56z2G9vrI3W?=
 =?iso-8859-1?Q?3ktFhGx9Mhq09NwHu1rdHijFD5XZbz4Je0546/71MlN6DcB7Fdo3yTE0qQ?=
 =?iso-8859-1?Q?kf59Sa19nSdTGaYPB6854U6yRkJPBwYF8TWZY6bmjyx1R9a05eGsB67x1E?=
 =?iso-8859-1?Q?n5lb32KOVYVyab2wuroPhJOga53MPS0XxgCy4OQKUYuA3Y7kGeCZsL4ZGc?=
 =?iso-8859-1?Q?Cm7VIuuDr+MTKLwBQB6RNhbWkGZZFbO1/TW7vtAUIm5dgvEIlNOlktyBdE?=
 =?iso-8859-1?Q?MFHF/wpQ3y8nMvo6/EBgvNLVXFDGKo22zyHjUIbWQ1Q3izUTNQq+/MrdhN?=
 =?iso-8859-1?Q?sHbERFDU7hEN2L4xQYEIHBAl+RO1/UzInoj97yR8f5bgyl2r6kYBsLBKxT?=
 =?iso-8859-1?Q?u4Mk7FGpGMHnDkObnQJSlc0ZNYyuMXM2u8o9L570pwJX+Y1mwRlNxZuyjN?=
 =?iso-8859-1?Q?OQO7/u+NiC+Zswwq0nNbCBQOFmPtVzsYOvM80jamT5+XuWjm8jntmX9lNI?=
 =?iso-8859-1?Q?ZrkgYXTXWx2ZrwQJbfUaRMtDyUv1nVo4kC4hA0Ja6Xvn17P6hoEY8BOBxt?=
 =?iso-8859-1?Q?sExDmr8EtYUG+InaUpFVRkhXUIdZ3pwYi7z/NT+AD5fvblaZJZqxRS0SCW?=
 =?iso-8859-1?Q?ybfPbS7RZmeRVvxTTxCPMPX8Dok3MXvzKa0m3ZrcgT3muNM6Rt0EUGY3ZZ?=
 =?iso-8859-1?Q?JtObp9Yy7eAyAybuHMzJBNtm/FRfBPmPJHFXWH7FJNAh9RirOXjUZ5ctZx?=
 =?iso-8859-1?Q?of6fYwn15KpPO8CUFQLX3lOcrRnXNWhQLnhQCTpi5F72mhOhKRyIxs8ukS?=
 =?iso-8859-1?Q?L5SIp3xOc2eFUSI6/v6BCoqEseBC+18qBL0BGWSQJ25RwuJb6Xi715LYCR?=
 =?iso-8859-1?Q?3mgGnxbaV8ACUtMi5vE/xuro8ayzCazdKVLCJycAcoTBiH52uzlJSvNKX7?=
 =?iso-8859-1?Q?V3on20Qy7Xgg5r3P3hesR7urBglku/BnPc5LJLBNNv7p/nyQBc38NmAZ4v?=
 =?iso-8859-1?Q?osgj8d33+jo8dWymZ5E8Nk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7OT0zFz1oQ2CIjxN3lwMOooBJ4kjPwG4nsu52MhDbf3b2ec0BEGxQYLIiq?=
 =?iso-8859-1?Q?68FwPTiixvTtBT2HEd6xd3r5JLgKXP0pMfUwhrJcRrGH6TEh6cw3E5cX25?=
 =?iso-8859-1?Q?u60t2qk0Kk/tV03JS4LRYqm3QMPfvJ8pR4fHo6OEsgj9szHEVnExgTKTlq?=
 =?iso-8859-1?Q?GrG3YiIC10HqhCa8XlusYdN84y2yLC+dFYASTkjijDTYyAr6s/Svq4LDdb?=
 =?iso-8859-1?Q?WP3ElenJoxLY0fyCRO3NDp1rp4D1dly+JLlxn+trjjlqzuJa9k5crYL+a7?=
 =?iso-8859-1?Q?1njOvZKcU0WmhiQWrpKyWfUQOKpwObbxl4AN4gxKaB6RXlPDY8i2pHjFqN?=
 =?iso-8859-1?Q?GUdpZFXoCtgav2RUV0n40i6Rrt4Xu6s7E0s6E950j0PM5olHck1r40Mvnf?=
 =?iso-8859-1?Q?I3K631RRbrs/9CsbhBuwBAsWc8SiPx473GGNxL6QxE5pNsnXD70cuwC7o2?=
 =?iso-8859-1?Q?kADlSqQ0WDChhcblJ6RKQ43QF1d2mUGwLaJaTwaO0IucAIZr7KejoGHWci?=
 =?iso-8859-1?Q?neh3+LpJxz2W0TA/Y/MD73V3wwY8N2ciwX4e5hJ1klz14Zm3oFsMBjzpY1?=
 =?iso-8859-1?Q?4O5vdS/+uzcC4iAtwSRW/8snJymEArO/jBCO45pewQ0vnDKOqQsa/kIduq?=
 =?iso-8859-1?Q?dfkCftTNH4sTLmrsmvtqPQ1Wgf4Nm+PzNy8eJEoYTNl2/aOTrUOac5plb8?=
 =?iso-8859-1?Q?Zir/XcUe3wIEj90KyiBXIJtGuKczGN1peq6fCdNJqZJfDFNqCq/3QG5bR6?=
 =?iso-8859-1?Q?FUP9aCbHLCDKOCGYhBxHndC3Pbzzzol8M+o/A1BuJO/Vx3iV01PFfr3OQV?=
 =?iso-8859-1?Q?D/8SHlUe69/f9LAxuvBQM/N3pjo+otfvYcAvzLatVocbs+H8HHmGc0Eqzh?=
 =?iso-8859-1?Q?JnSOPf+IHd3EF/IMbdYlrMTKZEq/VdXfXc4GODhEn8L2ZCU9YsGQci4bJr?=
 =?iso-8859-1?Q?ogdPRMCL1UPGm4Sqy0fWvUmKjy+OquaBAPHUJWndBZ2qJCFsfyeBQMyGXd?=
 =?iso-8859-1?Q?IAWNCIq+V2XKLZ2Qz4BuRaLiF20L5RDZY07PRhpZTciLO9AIVKtaNUXFDD?=
 =?iso-8859-1?Q?2ddqZtxIixdyByEoqyg7yBv7XirKpxibY+3pXsZB6rJpytHULzG8bf/MWP?=
 =?iso-8859-1?Q?IgoSv7074HiMYiD+AdFoSEphBA6p4BdEgXblam6elulB6hP52dnHXFsDwB?=
 =?iso-8859-1?Q?W4HC4G/JQmE8nqke9jbH9VLxMQL6dAqpoXAaCSTsObxWrAYM34dOTNblR2?=
 =?iso-8859-1?Q?ENFdG50UtSDEje1hZnYCvVgeY59xm7FUPXVCUqLKFBv5laEiyMzAGJgvhA?=
 =?iso-8859-1?Q?+K8LJITI6N81Z5HFC57M3DqoN4rMM/uktuYWugfZtNYsAoZyVQIgWk9gd3?=
 =?iso-8859-1?Q?3YzatRwYV0bPUYG4BxlimM8wPy+2K7TG/LdCtMLBMoSPERcXqmiVP2B8zM?=
 =?iso-8859-1?Q?df6n953Zm1LNlIKf4obxD91D5JAT5bAG7arS5liSWT15ZPm2Fk5cI4MMGd?=
 =?iso-8859-1?Q?vaPmCE32K1uamVSdh2kbnia57/DoPXL5xQY2CgzwZcY7DgPHb2W9G4cmTa?=
 =?iso-8859-1?Q?4e5jRX58GFVsHShDTANrZbPIgVZuSs59bjU9SoJPyTUq+tunWbuhm6Jewb?=
 =?iso-8859-1?Q?ycTNa5MtOf4nc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d752b6-00a7-4389-80c3-08dd30ab800f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 12:45:30.2443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yL7CncGiohF+fOVBfbvvn05FQgWvrcsg/oL5bCVEIV/6ycibx7lrgw3sOkNO5kkw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-Mailman-Approved-At: Thu, 09 Jan 2025 15:10:50 +0100
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

[AMD Official Use Only - AMD Internal Distribution Only]

Agree Alex,

I just used /t to stick as much as possible to the current implementation, =
but I'm open to change to white spaces if Michal thinks it's better.

Regards
Ibai

________________________________
From: Alexander Dahl <ada@thorsis.com>
Sent: 09 January 2025 07:52
To: Erkiaga Elorza, Ibai <ibai.erkiaga-elorza@amd.com>
Cc: u-boot@lists.denx.de <u-boot@lists.denx.de>; Simek, Michal <michal.sime=
k@amd.com>
Subject: Re: [U-Boot][PATCH 1/2] fpga: fix alignment on fpga cmd usage info

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hello,

Am Wed, Jan 08, 2025 at 02:03:50PM +0000 schrieb Ibai Erkiaga:
> The current implementation generates some alignment issues as well as
> some overlapping when all the fpga command options are enabled. The fix
> is intended to improve readability of the usage info.

Alignment could indeed improved.  One question: the \t is dependent on
the terminal, right?  Would it be better to use spaces instead?  That
would also make the code more readable.

Greets
Alex

>
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
>
> ---
>
> The current output looks like this:
>   loadbp        [dev] [address] [size]  Load device from bitstream buffer=
 with partial bitstream(Xilinx only)
> Load device from filesystem (FAT by default) (Xilinx only)
>   loadfs [dev] [address] [image size] [blocksize] <interface>
>         [<dev[:part]>] <filename>
>   loadmk [dev] [address]        Load device generated with mkimage
>         For loadmk operating on FIT format uImage address must include
>         subimage unit name in the form of addr:<subimg_uname>Load encrypt=
ed bitstream (Xilinx only)
>   loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
>         [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
> Loads the secure bistreams(authenticated/encrypted/both
>
> The new output lools like this:
> loadb  [dev] [address] [size]  Load device from bitstream buffer (Xilinx =
only)
>  loadbp [dev] [address] [size]  Load device from bitstream buffer with pa=
rtial bitstream (Xilinx only)
>  loadfs [dev] [address] [size] [blocksize] <interface> [<dev[:part]>] <fi=
lename>
>         Load device from filesystem (FAT by default) (Xilinx only)
>  loadmk [dev] [address]         Load device generated with mkimage
>         NOTE: loadmk operating on FIT format uImage address must include
>         subimage unit name in the form of addr:<subimg_uname>
>  loads  [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]
>         [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]
>         Loads the secure bistreams(authenticated/encrypted/both
>
> ---
>  cmd/fpga.c | 51 ++++++++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
>
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 93f14098ccb..cba38662958 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -411,46 +411,43 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>          "loadable FPGA image support",
>          "[operation type] [device number] [image address] [image size]\n=
"
>          "fpga operations:\n"
> -        "  dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
> -        "  info\t[dev]\t\t\tlist known device information\n"
> -        "  load\t[dev] [address] [size]\tLoad device from memory buffer\=
n"
> +        " dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
> +        " info\t[dev]\t\t\tList known device information\n"
> +        " load\t[dev] [address] [size]\tLoad device from memory buffer\n=
"
>  #if defined(CONFIG_CMD_FPGA_LOADP)
> -        "  loadp\t[dev] [address] [size]\t"
> +        " loadp\t[dev] [address] [size]\t"
>          "Load device from memory buffer with partial bitstream\n"
>  #endif
> -        "  loadb\t[dev] [address] [size]\t"
> +        " loadb\t[dev] [address] [size]\t"
>          "Load device from bitstream buffer (Xilinx only)\n"
>  #if defined(CONFIG_CMD_FPGA_LOADBP)
> -        "  loadbp\t[dev] [address] [size]\t"
> -        "Load device from bitstream buffer with partial bitstream"
> +        " loadbp\t[dev] [address] [size]\t"
> +        "Load device from bitstream buffer with partial bitstream "
>          "(Xilinx only)\n"
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOADFS)
> -        "Load device from filesystem (FAT by default) (Xilinx only)\n"
> -        "  loadfs [dev] [address] [image size] [blocksize] <interface>\n=
"
> -        "        [<dev[:part]>] <filename>\n"
> +        " loadfs\t[dev] [address] [size] [blocksize] <interface> [<dev[:=
part]>] <filename>\n"
> +        "\tLoad device from filesystem (FAT by default) (Xilinx only)\n"
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOADMK)
> -        "  loadmk [dev] [address]\tLoad device generated with mkimage"
> +        " loadmk\t[dev] [address]\t\tLoad device generated with mkimage\=
n"
>  #if defined(CONFIG_FIT)
> -        "\n"
> -        "\tFor loadmk operating on FIT format uImage address must includ=
e\n"
> -        "\tsubimage unit name in the form of addr:<subimg_uname>"
> +        "\tNOTE: loadmk operating on FIT format uImage address must incl=
ude\n"
> +        "\tsubimage unit name in the form of addr:<subimg_uname>\n"
>  #endif
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
> -        "Load encrypted bitstream (Xilinx only)\n"
> -        "  loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
> -        "        [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
> -        "Loads the secure bistreams(authenticated/encrypted/both\n"
> -        "authenticated and encrypted) of [size] from [address].\n"
> -        "The auth-OCM/DDR flag specifies to perform authentication\n"
> -        "in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication=
.\n"
> -        "The enc flag specifies which key to be used for decryption\n"
> -        "0-device key, 1-user key, 2-no encryption.\n"
> -        "The optional Userkey address specifies from which address key\n=
"
> -        "has to be used for decryption if user key is selected.\n"
> -        "NOTE: the secure bitstream has to be created using Xilinx\n"
> -        "bootgen tool only.\n"
> +        " loads\t[dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
> +        "\t[enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
> +        "\tLoads the secure bistreams(authenticated/encrypted/both\n"
> +        "\tauthenticated and encrypted) of [size] from [address] (Xilinx=
 only)\n"
> +        "\t -The auth-OCM/DDR flag specifies to perform authentication\n=
"
> +        "\tin OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authenticati=
on.\n"
> +        "\t -The enc flag specifies which key to be used for decryption\=
n"
> +        "\t0-device key, 1-user key, 2-no encryption.\n"
> +        "\t -The optional Userkey address specifies from which address k=
ey\n"
> +        "\thas to be used for decryption if user key is selected.\n"
> +        "\tNOTE: the secure bitstream has to be created using Xilinx\n"
> +        "\tbootgen tool only.\n"
>  #endif
>  );
> --
> 2.42.0.325.g3a06386e31
>
