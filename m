Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDBFCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 04:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401EB8722E;
	Fri, 20 Oct 2023 06:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gallagher.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gallagher.com header.i=@gallagher.com header.b="AL5kVBhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F0748719D; Thu, 19 Oct 2023 23:42:32 +0200 (CEST)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com
 (mail-me3aus01on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7004::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591068716C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 23:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gallagher.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Afshin.Pir@gallagher.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyw8Jaq40V+17qFP4Naf0s4XS/k7tdQys1CD22zqfOo20APD3JffQWGKEU/1ApRuewIxJ/SwLhOdqeBfdRSxzR/UWkzAxUNOur4yTH8bL0Trj2klefCKDX/3jUkYIBvBipzpMjwKuqs+mS7Mx0Bt8Fj5dgbLsPFJmjQzi6OHRETPzmSPEY3j1UAuQqOihwElXxgSqQozDZ0TEu92ggDhOPFmdNvw604aX3xld+qWO69adtnPQTiWRKW6ITmlYQxc3pUNPqqeEq0YAxikfT2uvrcYJIN7JXGklqyo1uuzaVS9rJ2my/jT+26JlKv5SxZ9DOC7x0WzwJwSXAVoCVMgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5phHWs4+kqSd1P0yG2ICsMa4Jb9eB31I8E/F0B60fo=;
 b=g1ctgasLZpbFg0jFhD0Gnfe2mB167GYuCokXJ6x/mf6OLR7rBWIY/jsNz71T3r5Pt1eNZjtK/kQm+UAfT4/WBoRAhX9Tf6FjIb8fduf6Y5xlTIdaNU5IHwGL3nCaLQDplCCRec/J4L+W32S6mmnJdpjiNjPkFJkYkj0r7BW0y0hHjn3mU8NEaoEUkOQl07lwqUllDebBdB/vE/ZsakAfeG5tXBmeBOnzOvtcSllV7KlKa1qcu/xPdqjYkG4vnUigLikBteWQ+SrkdbyNlBflWxWZBxhI3ubSu9k9b9zb8yS8kxiCs5Rc/VbwlJddt7JQeo666W/CQUNS5IKqOUMlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gallagher.com; dmarc=pass action=none
 header.from=gallagher.com; dkim=pass header.d=gallagher.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gallagher.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5phHWs4+kqSd1P0yG2ICsMa4Jb9eB31I8E/F0B60fo=;
 b=AL5kVBhKPOiOa/Vlg0fUmDXY8B09RZtnC7T3P4E5ucQJ5ddoB3ZLcXett/Dop4D0U7jO8B/0jhA7FOGJ99mbWAv4FaB0f93tUoYe0BM6FMHik9Zu0pWt/gvCG3/KBIXBXrmJHFSWVcIWWXXS2aKNINcxR1IrT5Cgh0U+hIA/aNBg7bJKKM4piS+F5TWG1tEues847FOuHeHxKZoiTYLad1gH4oRg8qsEHWUyg86qfT5rKtthJ8Vcfwf/AiTKQvx81Mcf8TL64VWZe8/SaMi2XLqJaflf/t/xSfUB8yrTdVcqlBXyNQvAt6EUG1uPAhhyqOoyhIUvikuSqklxer787A==
Received: from SY2PR01MB2778.ausprd01.prod.outlook.com (2603:10c6:1:25::22) by
 SYBPR01MB6652.ausprd01.prod.outlook.com (2603:10c6:10:12f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Thu, 19 Oct 2023 21:42:22 +0000
Received: from SY2PR01MB2778.ausprd01.prod.outlook.com
 ([fe80::f43:f53b:8160:60]) by SY2PR01MB2778.ausprd01.prod.outlook.com
 ([fe80::f43:f53b:8160:60%4]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 21:42:22 +0000
From: Afshin Pir <Afshin.Pir@gallagher.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: How to use USB_HOST for at91 OHCI USB
Thread-Topic: How to use USB_HOST for at91 OHCI USB
Thread-Index: AdoC1J83nt4j1L7IRZ2a+q+oaDg3ug==
Date: Thu, 19 Oct 2023 21:42:22 +0000
Message-ID: <SY2PR01MB27787A7D5C4D8B39BB7E6E1D94D4A@SY2PR01MB2778.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gallagher.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY2PR01MB2778:EE_|SYBPR01MB6652:EE_
x-ms-office365-filtering-correlation-id: 2ce9d16f-00a9-4d46-1fac-08dbd0ec46d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DhGLFXFqSd0Glf0oVOZ9tA59b6Rrd0jwP4J1GcFFdOKH4o9rOjrvSGpYFzyl3x0xb26i/PiULx1nDSm7ZQuhguamSJLogKQuIdAadrZRzQeEPOpIJjHGmgijfx+ShWprEY20p9XKjdSNZq/XuMROCAVWJOSLi0Sm1nUXYVvp4BXt6Qo11q/T3aK5JpvD1+VJq9pbz8QO5zPNGN5Re7u+MZtmgvStS9A9IEsgHZmB7ZOBRW936tNwkXzjbW70KvP5UdMiKCe3cgcyERidl4SHgWMGgp8wQjIlDQRS4AImxD6ZPshqJ133JinzGWWwVF2kOBh80o5YLRHvMDGWaJ0dshZPV98hQOzkLBpKXnLkNO0pi8OXCz/y9xpFoU/0UWFroeZ0HNF5/B7CbOfHqIpOonek44Ht9F7qQ1jdEfHm2I7aZ4OiZFwnEY2by30ThXeDkc9ugZJ4TYhV2u6GR8iLLD2ZbFTYUNW0aTHF2sMxXTY06lEZn074iwtv+0em1E/TY5229UCKgwcg/MHzbg8rvUBWEoPK44n/+4HazFeDrXjlRuyEDy6bnoMiNR324IvfviO644PRjCPY8JAFvK6uId9uypLNZYdFufZ1y/STq6rtRp3r9sHdVQm5Rc757/fk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY2PR01MB2778.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(39850400004)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38070700009)(478600001)(41300700001)(6506007)(9686003)(7696005)(86362001)(316002)(8676002)(8936002)(5660300002)(52536014)(66446008)(76116006)(66556008)(66946007)(66476007)(64756008)(6916009)(83380400001)(33656002)(122000001)(38100700002)(55016003)(26005)(2906002)(4744005)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vYYnxU8v5x/v+44VjQIi9wQvSwZbobBHAw4uLgSOaKIzHmq7m3LfWAjvJqpZ?=
 =?us-ascii?Q?0JPGocZDphB8jh6A9I0+MS9ddXTrTvE807vVo2ggkThDWrU3EZI+Xn8BfdPZ?=
 =?us-ascii?Q?38TV7MXNKYjkVB35ImLuHCJQY7OByqSRLyMuNmUbr6YJ3HvwUzkaFUQ1WZgn?=
 =?us-ascii?Q?OVXj4EZwwuh6BTRPchrU4wurqhPtg8iN3ejmEsyLbXC41iAxpLIxKy9FoisW?=
 =?us-ascii?Q?TNq9HLG8mr6kUqMBs0CCsb0KSHgTSc+Dh14Owk2vhuzbJX1YQ+T5DsqJzXmJ?=
 =?us-ascii?Q?03XBLs+YvvUz4cMG2Y9LOmajqQmCxguEHOLvujHXdsn81BiVr8Lr/J0Up6ZT?=
 =?us-ascii?Q?AbGy5ZwWyP+Hx7UzBgJFbqiQ5Y4D7CzqHj1vfNMHqbacqTXcHW5jC22BDFAX?=
 =?us-ascii?Q?VOKPWHe6eTqo65Tz7yu1rSRl8AlNwOVKQPLyeuerqlFV6QF4kz9Pc76TSPsX?=
 =?us-ascii?Q?0ASP4LMtv7d9Mennk67XVyXmr1LPb7HcuuFIFWAyMrsS5XU89mOSjpt37NK0?=
 =?us-ascii?Q?c36Ldf2vY58wZJ8oLA0vMDxUK0AbObFklC5mTu7A9hoiAyManEChCSA3y/A2?=
 =?us-ascii?Q?PeIHdqWQpmP3ZzUaLr8nt09CjYzGi6oBsNVO1s6UMQGSdIzQ8G+XgNKZSLEr?=
 =?us-ascii?Q?XqU2XdzffJqaCn42BVeWslEj3U3ge5D7kqqX2FduBrQzaMJqYJMILMNM3b65?=
 =?us-ascii?Q?qeocaTWMXhzper+5uDmCd1BjrrA58IPDab7VH7gkIbOp6QfMfgFupg+2eFF9?=
 =?us-ascii?Q?PXMupMp0UbSj5NLeFczbx0ubhpwFiWNaMg8qOCWRtileaA7wGaobaIvodejX?=
 =?us-ascii?Q?D+HDYSr7A4+hkjN81C8yfmq1v+iHwN727tgIorjG7ZoyzuQ1peFIfEJo8CXs?=
 =?us-ascii?Q?a6RtniF1nxtWhYgT2fIZtoiWaPJaF+FmUi+8RLatK37NKleZm+o4/3x4PIsV?=
 =?us-ascii?Q?QD+yEc+ky/HSpedvqWcRFbzEyOOlDMH7eJI37Av04Wz14NEpEmPbutbpkCRH?=
 =?us-ascii?Q?F39NkIusmf1kwv6I6+I0v7Lsz7MpxAO/A/mFfnMC5dS59N0ws4yxWBIiXLjs?=
 =?us-ascii?Q?EXDZ4HAX708APBmgKCS/63hKYtFwyYlNAQwOFRC0Sg7flXSrgMB/hvtx1Qqs?=
 =?us-ascii?Q?4Aj9mW1nnPY6HV0b/2g3sK9G/G1KhqM2PILqfiVvxj2U51R6e26xXhp6/6LL?=
 =?us-ascii?Q?23/X3BjuR7Wbt7W2YaLQ8ne6qoSzs7g8UNk2ooQbbMndR4hkzDoKs/0W/BUR?=
 =?us-ascii?Q?d1Ws4CM6rsnYjaWIP9pNsYN3WyKG3mueENjoPhRZh+7CBBz/xZNQZlpiY0AF?=
 =?us-ascii?Q?RJGRanqT9EwAx6wY7eTXyo5rvCugIp6eeJV8M/L+gZvkRoKiEJ1OwG5X3hZK?=
 =?us-ascii?Q?9IvFSuQQEvGgA+43x81i8uzbNOGIVCurULV5wlF8PkGEQA2pitaENd8zjWdg?=
 =?us-ascii?Q?uwIVNOR6rV1JKApgh6PgLmqrKsZvD7CBlBkxI5oK5zWoFTKDLdm3x8O84FBf?=
 =?us-ascii?Q?JhwaqJg0iHoCSk+YMawakEOkeV+Os3/PlWQZWe6a5AxKFn82BgQhjDZN7hZb?=
 =?us-ascii?Q?dsed86AGbHibPyPvx86qrGpemKivYTNgnw00ms6p?=
MIME-Version: 1.0
X-OriginatorOrg: gallagher.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY2PR01MB2778.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce9d16f-00a9-4d46-1fac-08dbd0ec46d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 21:42:22.1535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2156b869-431f-4815-b2ce-b4893b5c9aaa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etToDmRji3oo7dwl2Bm54PVSViMbkK2XoMsicthLusa3Ueq5/aVQ4frPp20S4STPg8pN8dX+lqKwRNjrTSi+j4J0I6eHg7y0kj2ZujQC10I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6652
X-Mailman-Approved-At: Fri, 20 Oct 2023 06:13:21 +0200
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

Hi all

I want to use usb command and usb mass storage with at91 ohci. These featur=
es depend on USB_HOST, but I found that USB_ATMEL option does not select US=
B_HOST and I don't know why. How can I do this?

Best Regards
________________________________
This email is confidential and may contain information subject to legal pri=
vilege. If you are not the intended recipient please advise us of our error=
 by return e-mail then delete this email and any attached files. You may no=
t copy, disclose or use the contents in any way. The views expressed in thi=
s email may not be those of Gallagher Group Ltd or subsidiary companies the=
reof.
________________________________
