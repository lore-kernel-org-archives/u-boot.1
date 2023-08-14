Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A5AC001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 16:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50D686679;
	Mon, 14 Aug 2023 18:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eWS3kfZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2C886637; Mon, 14 Aug 2023 18:16:16 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF29686679
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 18:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyA/iYNpEkYPD0AWbUKp8r7aW5GmAl4Y1YPBLWlSPlYHqAiX/6eWxddnmNR4EPdRSWsR8bDpbGG85akXR2Zdm8iPgvZCYnL8gkCz5NXP4nyByJiwl7ow7Zbgk5GQ/RFmMm4Bjz+X89AAi2BXSe36V8XoUNqTNfg09rhtSKld/ii88+JzLxACfuGfuPxxzCXyRpV3Lg6i5zKEWzY2/Vfo9fUNtuNir/ozDyM2a67RAjba7oqF45C6ZSXhvfnHqTHP6nziZH8aKrcDsSWAxfmO7iCxbEUXWwyXEobi7KRBBLzMSlfxMgHfjTClmv5rIdNH2dkrCqyVRhsgk+3NMMko6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUw5eAuW+VFV/c60tbsPkZQ0Ljs8QyG6CRvgg+rqx9Y=;
 b=Xh0mkhOOmEt4THqWYD/3UPybNGJX7ezofM9R+u+mRjKYtvwaAP6vx2Uy6xi9AnnarTbCV/8uV815ellk0RU03eGT+AjexGMtHNMy4ZMmb3ESoh0yWh590Pl7kRN8AOvA6dY/EtWv5DEIrvFyxLMV/IosYklEfXd3G0ZFctQ7JuaQpKdcZqhAiZkmp1dXBg1L0jNMxR+Gubr4Wm4JlUWKrx31reOrfh81XnaB8U/q27tJ8dp12IRVyA+pEJBnYAtdpiQrcAOeq8U6aUkSnKCOgd2jGdswplUCvGZ9cZMUnCK6JpLeNjUFMlYCU8ar+bklQILFHjdM0Z4m8GrcZvnA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUw5eAuW+VFV/c60tbsPkZQ0Ljs8QyG6CRvgg+rqx9Y=;
 b=eWS3kfZXIsGSxZv6pLvkwiB8D3sV4m6ISCjvnQsaYx/8M9uh6y50TJ/t9nLhhI3ccQws0VcK9NV4mCvNmAgl0VZGDBkj1ahNSCreba4bYAfrK/pegKa/oMrxk1GTgRyV7mQQeVl8seUZ3bnVxdo/LJwSU4MO/FNFoLZaY3y9vJFNNp90fDQkyIoPQEr4KK5vtdmqrqxQlV9BXMa0kz9m/jtqgJq45qZA64+aegmxJgZjn3B/c7USvImPhl/Kmppym2VY57jrdlNVhOjMKL/b4cHyh7loe7i9vTQuh+mBFV3tNN5r/FhMm6kyMtVIyhsahxil6Hq8EXNDOqdcj4Oddw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Mon, 14 Aug 2023 16:16:09 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::c35a:155b:336f:13a3]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::c35a:155b:336f:13a3%6]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 16:16:09 +0000
Date: Mon, 14 Aug 2023 18:16:02 +0200
From: Thierry Reding <treding@nvidia.com>
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 0/7] Tegra: add ASUS/Google Nexus 7 (2012) support
Message-ID: <ZNpTQqj7WHIyLv2u@orome>
References: <20230630072906.22255-1-clamor95@gmail.com>
 <5C22C431-FBAD-4359-A74A-9BD7B8FC3656@gmail.com>
 <20230731152919.GW3630934@bill-the-cat>
 <20230807134907.GO3630934@bill-the-cat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U486Tk9d5mTV4cK2"
Content-Disposition: inline
In-Reply-To: <20230807134907.GO3630934@bill-the-cat>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.10 (2023-03-25)
X-ClientProxiedBy: BE1P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::12) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 25950482-4970-4e80-d149-08db9ce1c4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x40tZV3EIKW6uZMtEFsIUgTmOUsiiIJiIRfv4IKsvzXS/2lXGCG5QrameLENsfKUldqomAWdOhhoAdDkyNAO7kElLpUBGu+n3v7tGwOFtHfWYyGuxgbRkprYQgq6LhNLwdk3510YHFpcLlNDI03Py4ksDPSEd1d4l1mXaVh/bjhFe75YqDPuv4vkZrgjSZGaqlxyOwoMrDWER25ghiWRu8ZqXJsKTFf0CxQGDCdeubcA1/pd7T3KrRz/JFIqWGQsTh9Yr5LjmCWy9NpqDCzgDvniILXvspD8iASy57/W+EQRhckpKKTw2PT9AUoFl0+fajVlCWs/E9FzbKOasod5mUYIBicFW3V1uZbWNmAlsJMgZvorwhRHDMXXk5Xh/Q5ORVKxIm0ekMdSy8GinwF01Qy5jLScp0bIL4tCdchwPJnBi5iHHjCRiJIvi8P6QdJhQNmB2C705+20EYJ93zbJ0HWWha0X7E/41Y7LNKUN25QvCFIGZ4gH1nK3wG69d+rcWchXtZeHB4hr53hX2vjFqqugoAeA+teUtrFKQbA1WTMlIWqvUzKO52NvkNAA1NbfLoVu2l0//Lvdg/KjJa1cjRwLZf9vndPXwYP8OMQCt7S24gX8Xz0qqzp3UiM+ZXeA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(54906003)(6486002)(44144004)(6666004)(478600001)(5660300002)(2906002)(86362001)(33716001)(6916009)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(21480400003)(6506007)(83380400001)(9686003)(6512007)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saIIkSs/YilZ/DJ4v+3HYYyszjvJhOWjBnjFY/q2DfBBWuidbr91Lfb5P6fr?=
 =?us-ascii?Q?/5molueZPR+3ZqGh8tmnYARwcbEn7rTrYbXQQbIIvmMvJMOE2M0jWx7MdO72?=
 =?us-ascii?Q?jd6sldDXFXv5I1fdj1vuqw2/DIFYAkf+imgpfTvMxSVn/zD1R6Xtv4VQbxXV?=
 =?us-ascii?Q?jZYmdFejAdNBqZo4fteokxqR5HJbOBgjMV/zLOFdLY8C74jDcS7MpU0aj7vH?=
 =?us-ascii?Q?okGBP34LOK7ecVYXtpcxX06L3geBrlbDeIPmmYx3L201sKoGC5Z0PviqEe4U?=
 =?us-ascii?Q?pqNT2l72x3H3REfMw2bayPUemtsmgeS4FX21kqqchnY0F0bsQN9jLbhohl49?=
 =?us-ascii?Q?TWcysfmx6K6wxte9xZFZWraWAZcxNEgD1XP5+smHEbPSoSjS+H5EUEoZX+4i?=
 =?us-ascii?Q?e3CSHA4FqyDm8TDYuVtJZfTj/sOyTsgGz5nlvzyvpCsxL+dayM6DW5vGxTsV?=
 =?us-ascii?Q?4BIPdzF0cDElDg8pu7dZwMuTQ6VskrL4u0TGooshZfZxYPX0Nxk2MQxq0Ikd?=
 =?us-ascii?Q?JIISGDKf94oi7IJyUGuESO+aynS7e/dTyQIBFLDOTyr6qSWgKFIpxvkPtQc6?=
 =?us-ascii?Q?01K0daixhruH+ayTEmOM7mFGRlXhDZEPo6b7/j5FSWlmkt1ODOC6DGcm/KUP?=
 =?us-ascii?Q?+cxUfM+P9EC6kBcKADxSakbTuEInmtAravc+gOUgmrxXHuKyg9hwoEdibR4C?=
 =?us-ascii?Q?HhqDefMO/+HVeg8tg64Wm5JXzpLl7QE6QR6P15C3HKBUeGBrQvKKQfqHtUas?=
 =?us-ascii?Q?zWc5OTSbQCd2ENDTS7cD9VWxB3pdRA4UtS4PZWstfkzExrLgdPpR7lCcFPqy?=
 =?us-ascii?Q?FM0X9Vtn7aPVQjI6S3/059B3EbpCuzTpYjH8fib2hGB1ZQD6Rz3wZTPWn5Rr?=
 =?us-ascii?Q?R20emX/M43wIZqjzJdppIj9YWLC3TqExRYDL1w1cZa+4SQGGe4NunESJQ1Op?=
 =?us-ascii?Q?MZrjZb3hUr7nrdjp+T/6raVw0Jq46JfVKi6Wu8tu76TX7BnyG6+fltzEEfXK?=
 =?us-ascii?Q?UHNTRdhSQC4QQd3pLVkl54OQPvHZzk+x4bzrszj6Wlh0OaFdyZ7H7eatp7m+?=
 =?us-ascii?Q?ohYCSbbqNrr6ECJPZYcOgIqbLJydzmPdgPLZ9wo78XVglZ+zSPH+96Itzyiq?=
 =?us-ascii?Q?8c70tgDylb13NCY08LqrmOXWOdPXvTsCnVniNyaE572GJ7rYJmME0FLV4x0N?=
 =?us-ascii?Q?clAJtzUrAlM51Y56dPtdx6t0MguntidxSHcPiLwYJH1dqOHIVIiAUPv53Fkj?=
 =?us-ascii?Q?mxN3AVhAOAhjtqxZ37Ih9nS2wuazk3PIBV1LTqRtJc+pKjVr9QVc4m+MrmB1?=
 =?us-ascii?Q?zbHvS/gny44dQiRqcLgcWgxTuydnd2C6bizbJ7Gb97ytYXw3vWcwF04gIdZZ?=
 =?us-ascii?Q?y/6acRl+cc5u3CdmJA5qatBeJmEoOSgZSbzv38csfSvoNVaRuqxoKBITSM6M?=
 =?us-ascii?Q?JHSky4P+rqgZOawKnCjg0emZgaC9m7vESp+f1IpgiRehAGVsWbrM2cpi15u6?=
 =?us-ascii?Q?N/CTIENed/ROog5Tzkovu31kugCG7oEOUq3tFqSXN72OWRUgEISSY1q1kZzL?=
 =?us-ascii?Q?HFBxzR7/6gVGlT8/hm+S9NP2fMPFZTE0i5Y/qsTYxXbNzv2fMkt8DHtmiabq?=
 =?us-ascii?Q?L1zm9xe93Oh3PzpGb1nhwRkxBejLWZcT3ci1Fya8+RwM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25950482-4970-4e80-d149-08db9ce1c4e6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:16:08.9651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nwAJ5FVSQj3VVkb+2T14y1OQnQDUI8UiuKVs4NtgEJv+U6e99wNx6W2yw3cC9+hh6SD8mGzH1nZF4yx9EJZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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

--U486Tk9d5mTV4cK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 09:49:07AM -0400, Tom Rini wrote:
> On Mon, Jul 31, 2023 at 11:29:19AM -0400, Tom Rini wrote:
> > On Mon, Jul 31, 2023 at 03:19:08PM +0300, Svyatoslav Ryhel wrote:
> > > Hello!
> > >=20
> > > It has been a month since the last patchset was sent. Should I re-sen=
d them?
> >=20
> > Not unless things don't apply.  Thierry, can you put together a pull
> > request soon? Thanks!
>=20
> Thierry? I'm OK with taking these boards after -rc2 if that helps move
> things along, thanks.

Sorry, I've been out of office for the last couple of weeks. Let me put
this high up on my list of things to get back to once I'm all caught up
with email.

Thierry

--U486Tk9d5mTV4cK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTaU0IACgkQ3SOs138+
s6GGOw/+Ik/3CLXEN+nCApFbEcIG1ET8hXOS9sFteYtHWibBDNihqhvE+hxdxBMB
wDIqZdlfdtIW9Cx5Atw+Wtxxyo8cDwbPXuSFqlKngJ5ycTvzjgVWDsFUxSChAcfW
uFnapI4UUOoxBEWIclovoOubRTaoQydr3v2Mf2+WwfsFUqrIT4d4cFQkKuCL9pxO
/Z5PXhdT+DMkEJSYYYX6RwvpsTuluGR1J+jGF6J7gcNS+vJWIPFoXm0fpqtrvaZb
wtuyYurwWf3u5EyPaeJG4KQZfVoMhRuLI1IvCFalECVT2v313KWzXEYKopiDgFRz
wl3W8ZNzYSMdCdPHMZMMfu8xsv/pxyCGQT4znB/ad7bFuTJMZitObC0P6jImAG2T
OqFYHyjWbAxr7iuF0nBe6F+Cv6HEQQw5VrAJu5pTNHOTNA2zXOuvtLr9XuEKElPe
41e9Y6yhJz99yug7JukZ37ardMa0LwA0aeHHr1QAGQsnjrXC1c69yIR6I3OPLESy
lG1oyaRKvvcBApv1ucRQO2qKSJv9x4o7LetqYo+e08YyanMjycCbjwKcJ3XKfIYD
A38oOuonk1XsjHf4bG6waHRVLIrIRbCc2bTVEKrRYqpuxbzE/15SVkW1hyTewJSR
6Pesk4JWXz6RukyYm65pxyKSO3NS9Qc1Fzt5qxCyMrSEfcc1gwA=
=UDj4
-----END PGP SIGNATURE-----

--U486Tk9d5mTV4cK2--
