Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507A6E83856
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 05:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CA783AA9;
	Tue, 17 Feb 2026 06:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GRQUhIKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2205D83B8A; Tue, 17 Feb 2026 06:26:39 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCEE83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 06:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH9BIqUSAoGDdNbUo2dDq6hROkwy085f8qm+JDvRoNed//qlUiA+kBVrc7fYhf8/YQT6VZD9AG7I7PKbu7IPdvKX546ppSIJgswLhLT7DANZyt4Y3999lVG5XnF8yEO00EEbKV2hTlNUEHP0LU3l4yYKmG4BLkCG5msnDDiAH5khiyzcE6dn9/lpXYRsrPipb0h4iUhzgwOHn/leZjNSOqe46/RB5MmF5MdFOP5KvBaSgPJKpNT6bKx/q3LfDKaga7Yx5iSShL+Qxy8DxqjvQPOPNjXbb9lAHtj/AxdA2Y6LUYbNw6kh+yKGRK+0t/wM1+Gl9P1ef1jqSuyqvEvS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W8dKa3+O5Hxxs3QqvocVfx7X/DO1eHs2nrQfyI1Fnc=;
 b=D33X75iwTcXgbhy1pYn2jpvppAtOtViepGzJeCs2Dj3P68jviDqq+roT5IuOBSrY55KH5rbRGoapoaHJX0ID6GxAHjeJ/i/ZMfJhWvatp4JM0RzwRUwR0sg3YzR/Pz7w4Ed3LCkuhZ3cmtdIZedT8Oo9dhXutHWYNXeLJRcn78/frJdanpjv7WUf2dkE38JkKd11p5J5wiEV4TP12j7J86+jJokRI5wOUEG4JfFLtI2Ztn8zCVf5+KDak5k3Hq9VQl0TalBF02QB5yxEYa6h9tizkiG/Pq84JUDGSOQKC3gcH1r9XJcXIuK/2L53LW6IVmeFIhgy2jMxXwP0iMxS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W8dKa3+O5Hxxs3QqvocVfx7X/DO1eHs2nrQfyI1Fnc=;
 b=GRQUhIKGxcuREuHwf1NxGxwKF4/Y8CUA8kt0C4QjWz/10vJqPFATl0wImh+NWtP1+oWT0IcvSJ7LAaQzCsPSAJmQW73wHak/kjY9TnvzjLLTcBXt9AeTItShXH+cqGDEQ0TaRk9wTJvt7bu2z/GkyxL7BtmjGYqSJNwoIs82RpE=
Received: from PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Tue, 17 Feb
 2026 05:26:31 +0000
Received: from PH7PR12MB7428.namprd12.prod.outlook.com
 ([fe80::e99b:6a9d:278c:f034]) by PH7PR12MB7428.namprd12.prod.outlook.com
 ([fe80::e99b:6a9d:278c:f034%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 05:26:31 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek, Michal"
 <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>, "Toomey, John"
 <john.toomey@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>, Rasmus
 Villemoes <ravi@prevas.dk>
Subject: RE: [RFC PATCH] cmd: part: add dupcheck command to detect duplicate
 PARTUUIDs
Thread-Topic: [RFC PATCH] cmd: part: add dupcheck command to detect duplicate
 PARTUUIDs
Thread-Index: AQHcnny6wvJCIRWi10Cs5q2ljeQwHbWFdgmAgADoAOA=
Date: Tue, 17 Feb 2026 05:26:31 +0000
Message-ID: <PH7PR12MB7428ECA4885D64FA3FA9C07AEC6DA@PH7PR12MB7428.namprd12.prod.outlook.com>
References: <20260215131115.3352282-1-padmarao.begari@amd.com>
 <20260216153249.GW2747538@bill-the-cat>
In-Reply-To: <20260216153249.GW2747538@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-17T05:23:27.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7428:EE_|IA0PPFAF4999BF6:EE_
x-ms-office365-filtering-correlation-id: a99bb2b4-f824-4afb-8971-08de6de51bd2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?E0UW9rNd4chVyx/j/OVnH2Gv1xx7009FpHOSQkNNNenxeXPKJyBskAE1jpB5?=
 =?us-ascii?Q?VN2iVXpUIot/o1Ml6lJXyMDicPg9Z6UGxP1ZJhJjSYpQq/QQDxfV7KqNre4i?=
 =?us-ascii?Q?crBIOhGXLtZh09CjZpENujoaCcwkuFROYi9/WM3E+pIkyOXdomFb+OQyBU0t?=
 =?us-ascii?Q?rushlMvhOuGIHkY6LeFumKLy+cPeTryVRNCypBzdW3ZdGAjS7lHrFBu1rBrC?=
 =?us-ascii?Q?0r6ZLFWr62a1g9i3RQ+Dk5pyU+RA1W/sBHEbeNYduTag/LFKRSik5e9dk3ZU?=
 =?us-ascii?Q?3/Nuf7il6IWKJkau0hNAP4Uvuzxkr+A1ozkbtSEIM5zJ4KPfVVE+QKRVDQp4?=
 =?us-ascii?Q?SOIW25IybtUEuE1wk+IyHbtvR1td/Mt78chnfByrNhv61vheTSQmPKqkRIr1?=
 =?us-ascii?Q?vk9avOcbqkOFwf079lokh7ISrXPBNfrWF0+tBP3L1VtmEwrnbMdH3f2+tFoh?=
 =?us-ascii?Q?Vp2KoNMf2Y09SSFynQMvxkH6OrauwbJq7oyXU/tZ5Zm4Kow5J0kBcuzUKeZY?=
 =?us-ascii?Q?4VH+RJ42D4YDksYha5cyBqYU0Krpvp96d4aUQvb1ZCeDFnYpxncIDwe48VZY?=
 =?us-ascii?Q?yYejkwHeSx2mRhwwCDSuwEupzMgi82yPlnuE3XEoUyQlR3lHaFqZ2LRmKOS+?=
 =?us-ascii?Q?g2PWJVw9pXy2agaEM15NvzW8W+d8PrL5N9jbLTWH9bwF1zA076yLDpCYGI1T?=
 =?us-ascii?Q?Wngw8WGbmG8AwJVvdLQWASUikgtfmeuWDdQqkAn1adonfPO9VP0Y8jsmtWn9?=
 =?us-ascii?Q?dxsmTW15HgNxeNzzvw2yagXY5UeD3Wnq3r7pYJPyJdkGVP0UjHp/AELY8EAj?=
 =?us-ascii?Q?lsOJFErCdomonQIGjRy2m3ot+ArP9n/eUbw2LJch73XGl4G15h0uaY7Fcg3Y?=
 =?us-ascii?Q?Syr2RcqMGDIba6EmmskMpabMQhqGjTucJrAoknSU88ZOK4XfX5QEbvgjRbzO?=
 =?us-ascii?Q?IJb68sgguY3RArLZftmVFeWxQ99B9+bUt3FWtTeblTdTWqmto0mEzGizDybX?=
 =?us-ascii?Q?AglJIUorgFrR3bRuEmssa3lvBjXKUltFGa0M3M948gd/0fyD0tqM7hLh+kOS?=
 =?us-ascii?Q?uxDKnwSjY7RSSiBDpvEIWh85UV7ieO+VJFs3vKxrV87o0wYk6kFaoOoB3ywr?=
 =?us-ascii?Q?R2Z6nZ1uGnz7/rCWwF1K21kfEx1Dr8WTRPgi3YpX3Pcqo42QezHBIPHegtFG?=
 =?us-ascii?Q?3vkpNUmriWcU5AZdyMzncQoiQSpiydYFUtDyLpyUC0OJSy2pnaW//u033lkj?=
 =?us-ascii?Q?BaMjiAeCw5bpCcWrARysQuopLmUloEBctZbPz/ZAl00KOAHpKZ0UkoXOJ6kV?=
 =?us-ascii?Q?P+56UJBYkWcgf25eUNDZE3i/FXHsEFvAZgT2HIByuuNI/HN/VrNpV0V9GL9i?=
 =?us-ascii?Q?SjT37+xbIY7b1Y/0SJZukxRg8SBTCeZ6fQC139o3cfK8Mwa56WQ34Ksrq7Sm?=
 =?us-ascii?Q?zQ1s5HBT4ilaPbbADEUaJi0vKnTmzuKJRO1U5DWLfaTPe5kVoMEz6J/nbK0D?=
 =?us-ascii?Q?WsPcDAP0aKr26WA6bQ4i4MkrEpLQQLy0mgRaaHFac3j4VLwHIO9ebaKJAJUZ?=
 =?us-ascii?Q?gWYkN9uHI2f9ezPT3JYs2nhbY/1Rkc9bW4N2Nv5aeMvdggCRBbfjwaK05qmx?=
 =?us-ascii?Q?dw/BNvdsRFD0D8PeqmpuWCk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7428.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SAvo9UuPvuF9NJNKdzUGVYdCFABuATxB9U8N8x+EZSYz7+IDPoGWkv5jXuYl?=
 =?us-ascii?Q?BXV7yILUg//INnkS/SayVq546Je2yid07SkLEC/AX3VJVQRYoB/mkLjzuuk6?=
 =?us-ascii?Q?xRWDaIsdMv74VOhAqJSv5N6ttvgtabuelDLyb5jPAtWJg88Vxjh2VApNLCPp?=
 =?us-ascii?Q?9QSw+FZLA1WjnPh0EXsdO4jHQwB2adD43iiXMrLdKkfmBhanOWdNZid58+WJ?=
 =?us-ascii?Q?b4+RKevWxynKToG75umuwOv4M5yaTRo+CrnwlttJqn0RPnx8PzeJeHcyCEy2?=
 =?us-ascii?Q?5EwJTjaMx0c0pjnWUgqhPalGKpreioqjBpP44H4vhbx0/XY6lpjLOsw85fSw?=
 =?us-ascii?Q?g8TbrhknG5nYL64AbKNPewNhXLS/aW5+pjYxk1QzdPTdL13Z/gvZxGu4MzE+?=
 =?us-ascii?Q?CsNgQhqsYtfRnFOR3OQKc0ySHbPZAMBiuvPta4EAnclzT2J4yU3IuSlARd3l?=
 =?us-ascii?Q?XMPeBbEp6vrpHpPAufYVHxnKQf5lwybp5hUV8kSnGi1aAMDNd4uYlE3W2Gu7?=
 =?us-ascii?Q?FpAa7t6DEdA0NRnTriFtN8Ld74HwYA0FwZVZYJD/IGk/jGfAJZbL2HXQuWqb?=
 =?us-ascii?Q?N1rD9UfP9wEYnVYz/yo9joizvMyIbC29jhWgDPDWeJRnmH+Uj4lDL17gXM34?=
 =?us-ascii?Q?61YhAZRnY5wq0CKTq56/FnvxWjR7FOBE0nrT51AjcHElEEELJKFq/a5xy3tE?=
 =?us-ascii?Q?9Rik2Dnt+hUSNodn9EzHhKDipQc/pUvZmUOtJQX8xaZqyy+rxNE3nroXCFCo?=
 =?us-ascii?Q?YbKDCbb9wx0kh0PVc1/xmRBnH7cnz2IwLa/T8GaCeKsPlVGFhehHkyVAY6+j?=
 =?us-ascii?Q?Cc/BrE7GT9uKrzmBh4D9WkxZLq7RVQYPmrBEIpvXTxtiaOjv6Zw61qcBYNm0?=
 =?us-ascii?Q?dJTKYWUj5bFLP/3mEXVdQ3WOAQUlfRVyiEoqoD3cCumRZdMKo6JGTmvmDdcS?=
 =?us-ascii?Q?FmL8wm7+LjcEfXWCXDptuxH0wouGno6N2VyuAizBUsV8WISq/itIkgamuyaW?=
 =?us-ascii?Q?SR74Y0oizaunmI/6bMK34tyalFjxuwOSgpq4iJ3DI9CNs+kZtp+enH/Rt025?=
 =?us-ascii?Q?YXUcALBJnbW76UsBh1/Pty+xaIFR1m4V3+iZxw53cl8U8Kgu/x+A+jbbFMQy?=
 =?us-ascii?Q?ZOktzu7tM/8UpmSURCc3qV+E8xCUh4hr5N9APZmKyzV+r6HNA/sdql+L/GO/?=
 =?us-ascii?Q?iUDO2cclCUzRh8lf/+l/g1R/TYdU6sZbAl0EGrP89r1qahhXeHFGckFrVvDn?=
 =?us-ascii?Q?j6IRTHe9NHqn7qvu1iUUs618dRnACqsWx/G6zv7YbWAEP4ywBqEl8tDXq6gU?=
 =?us-ascii?Q?TMdJrcz/R0bDBJGu+WnRFdy0EkWO87Zc4iU0Vt3HtC2Y/f+TUcvMr7GXCm0j?=
 =?us-ascii?Q?zHJZsvzaYhrK8yb9w8rm2ouL6tpJQkqLbFTX2ccFRSStrPwxa8yRAqZLUEjt?=
 =?us-ascii?Q?prfZhzUTnUBM730L/cncN/kXMRcsr4of92FiNmbTgV/yNN7aAQ7YM7Aj45kg?=
 =?us-ascii?Q?pgXVjTwY9rDAdfhhjEHBO5m0kroNbmHW3jucq7UlGgf8jiADzj03cFrydIVk?=
 =?us-ascii?Q?9dvDCUxopuP1ZeKFOjH3zV0R2LQfJp9rGHPFAZzk2M76pa9CajOmHxkkJA48?=
 =?us-ascii?Q?mzxkX3ndcSUrZj/KWKb+w6O5ERz6DWMx0fttCfooaUfscs9EPggyBm47y6Ob?=
 =?us-ascii?Q?Qbo/fGaKIOeKg4j7nT/jXa2MlaVlsc/v2l3Q8Xo8VSN2R3oZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7428.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99bb2b4-f824-4afb-8971-08de6de51bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 05:26:31.4247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgcAeBwt0kZs8zaOoifqQF+Giky61nHCDD3PdHuFsJjCLUR1Px7xM3UUCHRrLXjdkByr+zydBOnAl8fDjGH/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6
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

[Public]

> From: Tom Rini <trini@konsulko.com>
> Sent: Monday, February 16, 2026 9:03 PM
> To: Begari, Padmarao <Padmarao.Begari@amd.com>
> Cc: u-boot@lists.denx.de; Simek, Michal <michal.simek@amd.com>; git (AMD-
> Xilinx) <git@amd.com>; Toomey, John <john.toomey@amd.com>; Quentin Schulz
> <quentin.schulz@cherry.de>; Rasmus Villemoes <ravi@prevas.dk>
> Subject: Re: [RFC PATCH] cmd: part: add dupcheck command to detect duplic=
ate
> PARTUUIDs
>
> On Sun, Feb 15, 2026 at 06:40:47PM +0530, Padmarao Begari wrote:
>
> > Add a 'part dupcheck' subcommand (gated by CONFIG_PARTITION_UUIDS)
> > that scans all block devices for duplicate partition UUIDs. This helps
> > detect situations where the same disk image has been flashed to
> > multiple boot devices (e.g., USB stick and UFS), which can lead to
> > unpredictable boot behavior when using PARTUUID-based root filesystem
> > specifications. It iterates all block devices using
> > blk_foreach_probe() and checks partition UUIDs via part_get_info().
> >
> > When duplicates are found, a warning is printed for each occurrence:
> >
> > Warning: duplicate PARTUUID 20c5fba5-0171-457f-b9cd-f5129cd07228
> >   first seen on usb_mass_storage.lun0:3
> >   also on ufs_scsi.id0lun0:3
> >
> > Signed-off-by: John Toomey <john.toomey@amd.com>
> > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> > ---
> >  cmd/part.c | 104
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 103 insertions(+), 1 deletion(-)
>
> I see this as useful, but I think it needs to be its own Kconfig symbol.
> This is going to be enabled on something like 1100 boards today, if only =
gating on
> CONFIG_PARTITION_UUIDS. Thanks.

Ok Tom got it, will guard it with own Kconfig symbol.

Regards
Padmarao
>
> --
> Tom
