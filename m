Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96459C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1808840B;
	Thu,  2 May 2024 15:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=skidata.com header.i=@skidata.com header.b="gDQXNeHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC5088D24; Thu,  2 May 2024 08:57:23 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2856B88CA4
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 08:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Johannes.Kirchmair@skidata.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6TlNKhroFZfOBkHTKXZSRk2Ps6HqDFTMTLpIjdEiH0T6FRoEy4UQ+iU6eAfGaqO5CWX4P6ZAgFMtHA7SqUWwq5VNP7Q/R/dDUuZ5zIOyz+E4yPCnGy+5QUVt0WWfKYJdLCpVC6LXnayE81y9y9cc95xYobHwBKWHIJpaebg/KFq+x4gtO6P1TIJUpynfhrv5wznW7t/EPXJXTCJ9MI3m5DtVf7rkBavlYQoGqFLxN6r6htwuMR2wEUqjQvrWyrMWkDdaXVQQr3oKRHXpkJUqhoDryTDkRHV2cLRZy+apyhqIVT6MrMg18FA9pZHYvgzIO66GHiDQxsZh27MUkJxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPdnR7m1CJ7A+O1luG7gyCOjUByP0KEOg8fFdmucE/s=;
 b=esWYqV3TtcHkGrGqSv53ZkTnAVBVEUOEZxpygEAEraQZquJv7LNbmEtpjka3JdEbRY2qAMvzzewv//dHTdzVgKU9QBG0jE0b7rSRKsdbZ8YsD91nsP0iu+q+SI/rXzBRn2N/XOJKeKmpVH22agPO9OdJu/ZGCAMvqpC4tRtirN5Qeer5A5ZRs3KuTBSYKtF59ikabPOYwsryZE7iirmDQwaj8IDwtHqmrZhWYOp0abhuZ9G2NX9mwAGPMRhI7USLa95iQqYSZqDlKYgcIYpco1xPBNPWA71jYpQcJnnvOdpRzDUzXADaDeRH1gmowKTpCBy2GWqMz2EL44jRlPzxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skidata.com; dmarc=pass action=none header.from=skidata.com;
 dkim=pass header.d=skidata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skidata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPdnR7m1CJ7A+O1luG7gyCOjUByP0KEOg8fFdmucE/s=;
 b=gDQXNeHnRg+KjkzDD6ylfVMHK4+0K+wE1lhbAD4WI8Ir4MkoA0pqX/P1PvpYGvkKIDXmW2/KdD3AUIqPtQx5gZpmHDteOfv2eQL1Me/BBSgomKX06l3XCyW+u+yeKyETKKMRRzs60cg0G+2VlUZZ5lkuDpAoCEUvXwFENFnZAUpTtBM3o7irXNh9lAx+ArG8oUsIWU5VIIo0YoqlRxs/sZOBtr9Q52EOmDyqyL8mQfs2Plmya+93zx2ey2lIUbEDcXjvgLO0MNvfvUa/myvjciW76HnNLu8J0L8U9jR2zqJ6HGm83tzLU8CkjBoynApvvJ/ZImS08rQJMaO07Rs9DA==
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:39::5) by
 ZR1P278MB1151.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:59::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.29; Thu, 2 May 2024 06:57:19 +0000
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c]) by GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c%7]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 06:57:19 +0000
From: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>
Subject: Use header file from external library in u-boot
Thread-Topic: Use header file from external library in u-boot
Thread-Index: AdqcXMbl8x5Zl2WnTWOSMsLTSOB/SQ==
Date: Thu, 2 May 2024 06:57:19 +0000
Message-ID: <GVAP278MB0456BCDA64C66C434932AF388C182@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 2ac9ea74-1406-4992-a0fb-179e7d00499f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skidata.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0456:EE_|ZR1P278MB1151:EE_
x-ms-office365-filtering-correlation-id: f5c08215-873e-466a-70c4-08dc6a751c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?QL8jnTXfvZhJrb0ocm/0IW1mrVkMt//zxuV6RBMOwqj+DUkVLSrCMohU5Ye4?=
 =?us-ascii?Q?ABOG+gZDgu0BaqcSmsmlyYChGSt1MVqe+/dXazEox15WNUN2VgXsM6MEZP+P?=
 =?us-ascii?Q?Boif9jn3h71AlT4AzmYNLkYY9nfZddrz2ptF8NL/0MqJuM+ix270blTBhoZM?=
 =?us-ascii?Q?ThUIhhbwzhBsoiGLc+/MEfX25CUqaYa4bqSZCvvyRymntsjTvVUX8mOHseR8?=
 =?us-ascii?Q?aOQLXoKTa4UugnH+lb16HvNF4ksi9DAWYuLDrzO7AQ4c1UpPwlqpj3tvkEyS?=
 =?us-ascii?Q?XCAkYPFJyL0l7SE6WTiLiI0Q1s2PVgZ1nYw7jEnqRXKKmuh5juW7Y1dcpv1Y?=
 =?us-ascii?Q?aiB65QtNphu7EE3x2EQ63T+RheSdr3PEodCCeRjbqTnseutyTxjnAMVeWdY1?=
 =?us-ascii?Q?7+lRpNSDJrC/3mMi+lKm5FDAHKIhwv5yqTUxI6HgbPWqb9PB5bpihY+ua1mf?=
 =?us-ascii?Q?QZOMXENaAKrPDuj80UvqqtQX5Q3kcPjref8I/F184ERac4oTkZRYQGLQRaVQ?=
 =?us-ascii?Q?IwiNrHwhLl3onEsUStPOULyXT6bU1FtJ5F674+7EOdDIutcMEdjyRN/JasEB?=
 =?us-ascii?Q?LJOFNLkhAeJWYjq0j3nYEqOeHMhrSEJplbRFFhSkgdDPowc90w67bnZmvUlu?=
 =?us-ascii?Q?HtFANUXhMljGSV7sSKa38BHWjLpthsY/HuRjuBTR8Vu++JBCRSB6MnOpdGfj?=
 =?us-ascii?Q?Ylm6S2uMzOBM+wAQ6pfvDUQNP8rovNyfRj0++NnkoDn65ludhmB0viHhllBX?=
 =?us-ascii?Q?wmxo5FaJENaXiGe4eEHZLBQNPqIb1Dc3mHhqK3BncMD7vHWA2e/bDoWfSAtJ?=
 =?us-ascii?Q?J+5rhG+w1nB07WMb6s4ZC60oSQ/ziujLiDhISP8BndRtnwKIklIbuw1HWuyT?=
 =?us-ascii?Q?yDxwg/MDtPVwsKsP7ytYfXDwtkO3ASQ9twaGjwFeyJYqT+AQyQppxmRVUBln?=
 =?us-ascii?Q?luojjb+oDy/me5xyPX90MR9j7m2NIt9tGdaD46xS0T3TU3baxeZ1fFjxzODx?=
 =?us-ascii?Q?fHIGAtS8l09c0y4nrTIDe5pCAEgUB0zOeVYCZGwqzZI0ODVJ3Ynrjk4ez78i?=
 =?us-ascii?Q?92QWxVMbuk+Vzx4sTOGZaDukcHF8kanAV2S+9ik0xYWqdBqMleUk2Ao3uQaW?=
 =?us-ascii?Q?ixkRRfpuPyljEP1LhMw0l9w3blVo16KbhKJyivDaXNSvDgisTgYvhsYHVleE?=
 =?us-ascii?Q?8kadkbHy2pNYuwQjTa4QR5MCwIDltyIuBGxi3iB1dFFZhDst0lT8iq4cXUDu?=
 =?us-ascii?Q?outB/XXEAnW6AEec0UkyrzKr6/PHlyn8ZbQN4sT5gVsp5zzZMIKztIYPuKNL?=
 =?us-ascii?Q?qCzh3MTdCxRwDWkPRjMz7J/qi4fHauN/8hH3sOJgB6Oe0A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f2mDQL2+X6R7hZU6tkSHxef5cRc+aggLG2alyDz19/oyFqSxNUHzMT/z03/z?=
 =?us-ascii?Q?uwZqRjaUptF1oaOnOQH9bbBvlEhT2WsiXf+LkLzHWBMpp4HzkDgAAuXkrFUR?=
 =?us-ascii?Q?31vj6+RyznkOtjwc0r1zhzaKBZG/yi8IAO66ybrCMafbu9zZpQXALnVFFllT?=
 =?us-ascii?Q?mmYve1aaEXIguxg5tyd3uGrpSzpL6KcEHYYAAo1CFfSA2hReStPm36j/ql9h?=
 =?us-ascii?Q?5UVWHgZt07eZ4CmuXEJjYXGnFU4GPQyQjL+BiPpninsATI30umaqktnjMUE+?=
 =?us-ascii?Q?TVQfbG93y+hw2R1zyP4mU/4wjQ/TTinLglrtY/KMigIZGDd1tF2O8zHrbvvH?=
 =?us-ascii?Q?2ulLpGQIiI+2JViZR3RNvkdbodlnAyylEtG63x42QpWy3itFv8ddEPaYHAV9?=
 =?us-ascii?Q?G7eOpBzkCKEwCdoAu6LZ0uwTTIAYQW/gRnTaix/Es97++MZvKwIyU9c8KLi+?=
 =?us-ascii?Q?dCXHQI8eMRocdfbm2YcFEaWEphxRv5SYmm+G0QMBDa5rwSakqR38lOM0C9HM?=
 =?us-ascii?Q?L3EGq/IomYcazDXgGt53OjZcXVxhDwitrs+MGQY4QIcAqHM7n+5jd7sMsiwh?=
 =?us-ascii?Q?5/UFSqY3yaTxTqBCRJ8Rsi7QgC6VlW3UsMmdfLFaNF5Og09bGnzPyQwz24D8?=
 =?us-ascii?Q?owIJPJEEl+hwTNBqTGWotB12K6khGYFN7fEAISvrdFzHVVQT8qNzvYoN7U9j?=
 =?us-ascii?Q?c7L0zrQcO3YX4E4ASxvBsEKxETJLeXuKvNjxDelkHqNXTVwbztJQm8omoKsF?=
 =?us-ascii?Q?q3b+wbxy6jOqMGPHbV75IN5vDawZpS0AjpynNmV8bKEtwKviJaOKve9wcP2D?=
 =?us-ascii?Q?t9vkmDU+FAudIogNG8zPr3j+gSO2tC/Fr4B7PUaHiCSiyVu1+JlVnd/Lg4Wf?=
 =?us-ascii?Q?wqAYw/OPbOQv5HgdKyFGIEn2lfxXfkbpun+RnFWzgwflolmHR2iLtMCblua6?=
 =?us-ascii?Q?UvfLQPP7Z41tegJk84QdUM3S7HG7ZhLRuuZsCGJxPH11sMDZZVyWp0xOgGS3?=
 =?us-ascii?Q?pjCVu9NH4ItZPhRD8zsUv99YB7Y+tfyBl2bRRAXWMVlicvQS7FktTHB3j5Tv?=
 =?us-ascii?Q?2/hiPWlGuspNeJ94cTEayY3Lvo7UYCmp46RKhQrP+qYM9EGv761YqOX1QT6w?=
 =?us-ascii?Q?abPsY0WBhjOWkXM7osw2SP2vLFDr+vWRgXrBh5DJx0pjAQsArGPJED0QStoM?=
 =?us-ascii?Q?4esYluauna6/faBbDvN4o9Y6dwZNNM7VSEBUwceUE3ftwpJa+QSI8JsNoYI8?=
 =?us-ascii?Q?P7OdXGzxF6+6Fnk+4DUcfqDYSb6urwph/HwqhL5F/EZH4tGGhC6a7KGEeRTm?=
 =?us-ascii?Q?ABqsKgQmH6LGKL8CROkl+19By9LgwsQvvMXyOkBykGiCVK7iwK3DH6Ps1P+y?=
 =?us-ascii?Q?keH3XGhmNB07ItsPl14r922WCjg8kC21QFVN8dW/Mu7nWYUu/KXGoV4PYTly?=
 =?us-ascii?Q?wcz6EZV0CVp7HBGqjbLj1B7/jFv4H+3185WuuGd6BgA0ERoRMp6S/SL5SUVv?=
 =?us-ascii?Q?rted6kBkvzWm4O/ivT4AbFiXURubk3JPH53hmCKCBn+iURLkR9b45xie65gG?=
 =?us-ascii?Q?2xlNp4O2XZWgqlH/MkXhFrzM1tIKUu+1YBkv+BKaaH03h6WUogMfsZgIIRD4?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: skidata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c08215-873e-466a-70c4-08dc6a751c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 06:57:19.5350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5733095-4425-4f08-b6ba-487b9a46a425
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4ilUygDFgDeOuc2jvQwYheHFMHjhe8PdVLPr1cDy9EapPSh75sPAvwjZyujNoot+crW3ZGnWxMFLoxa3TecQZrdDYr/IqJ6Q4y7FntKO3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1151
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

Dear u-boot folks,

we are trying to share some information between u-boot and a Linux user spa=
ce tool. For this we place some information in a FRAM. This information is =
just some numeric values, indicating some wanted behaviour. I thought of us=
ing a header file to keep these values aligned between the user space tool =
and u-boot. This header is provided by a library.  Including it into the us=
er space tool is straight forward, but into u-boot does seem complicated, a=
s the build system is not meant to include external libraries. Is there a p=
referred way to do this kind of alignment or a suggestion on how to handle =
this?

Best regards
Johannes
