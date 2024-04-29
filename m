Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ACCC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 22:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3063D889A1;
	Tue, 30 Apr 2024 00:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YkKFZrVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2A288988; Tue, 30 Apr 2024 00:36:49 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF01A87ED1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 00:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240429223639epoutp0304450cbde0f017b608a83dea2d56739a~K4S6_tnFd0917009170epoutp03Q
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 22:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240429223639epoutp0304450cbde0f017b608a83dea2d56739a~K4S6_tnFd0917009170epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714430199;
 bh=0Qpn1gSAg1dFF1spJZF3gIh1i5b0zlSIPK7S8uPsiKA=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=YkKFZrVESEJCi7Q79AwJF4NNRm1u2dKpfKZmFZxJvuZwwT5mLKogDMDkmia3Rzkpq
 Tq24TcJTV+Vg32gWZKcYESOVFOiKVPuE+jb9bL4BhmHb1wCOLS/Mo+QTB3XTYnk9K7
 QJTfwqW5HViJIAjUyQ/IgpGb1jlsNVGXRW93m198=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240429223638epcas1p4574581561fb9825c6e854c22426fc0c2~K4S6r5HwO0368703687epcas1p4v;
 Mon, 29 Apr 2024 22:36:38 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.133]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VSyqT639rz4x9Pq; Mon, 29 Apr
 2024 22:36:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 DA.BB.08627.5F020366; Tue, 30 Apr 2024 07:36:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240429223637epcas1p394372e0e5d0a99041e95c7fb694808f7~K4S5nQ0xe1504515045epcas1p3Y;
 Mon, 29 Apr 2024 22:36:37 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240429223637epsmtrp1d4077156f5af8c95f1a7cdf509d657f7~K4S5mmQbk1606116061epsmtrp1Y;
 Mon, 29 Apr 2024 22:36:37 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-f7-663020f57cc4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 DE.A0.19234.5F020366; Tue, 30 Apr 2024 07:36:37 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240429223637epsmtip130f95460ed348b214d0eac6d3b1a0b61~K4S5ZWQkv1996619966epsmtip1J;
 Mon, 29 Apr 2024 22:36:37 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Marek Vasut'" <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
Cc: "'Peng Fan'" <peng.fan@nxp.com>, "'Simon Glass'" <sjg@chromium.org>
In-Reply-To: <e55e21af-7208-4b4d-9398-ee1e4825f69b@mailbox.org>
Subject: RE: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
Date: Tue, 30 Apr 2024 07:36:37 +0900
Message-ID: <050401da9a85$b24539a0$16cface0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFhA7XuusjSORLPiS0WG04V0LW/BwFhpEL9AsAUzzUDa45HcgLqm2/Tsh9ETMA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7bCmvu5XBYM0gxl/9S067t5it/ix6gur
 xbct2xgt3u7tZHdg8ZjdcJHF4+ydHYweO2fvY/LY+G4HUwBLVLZNRmpiSmqRQmpecn5KZl66
 rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBOJYWyxJxSoFBAYnGxkr6dTVF+aUmq
 QkZ+cYmtUmpBSk6BaYFecWJucWleul5eaomVoYGBkSlQYUJ2xq7Lj9gK9nNXzGn5w9jAuJSz
 i5GTQ0LARGLVjVlMXYxcHEICOxglHu5axALhfGKUWNJ3lxXOOdK8kw2mpbNtDRtEYiejxPdJ
 76H6XwJVvb7OBFLFJqAn8X/RQmYQW0TAVWLXtsWMIDazgLvE3wVLWUFsTgF7iVuLfwPZHBzC
 Ah4Sjw6bg4RZBFQlvk64AbaMV8BSovXVO3aIxQoSP58uY4UY6Sdx5ucTdoiRIhKzO9uYQW6Q
 ENjFLnH97XZWiAYXiedPpkLZwhKvjm+BGiQl8bK/jR2ioZlRYumSg6wQTg+jxL+G61B/Gkvs
 XzqZCeQ6ZgFNifW79CG28Um8+9oDdrSEAK9ER5sQRLWKxKXXL5lg5t998h9qr4fE9olbGSEB
 tJlJ4tLDnewTGOVnITl8FsKGBYxMqxjFUguKc9NTkw0LDOFxmZyfu4kRnNq0jHcwXp7/T+8Q
 IxMH4yFGCQ5mJRHeKQv104R4UxIrq1KL8uOLSnNSiw8xmgKDciKzlGhyPjC55pXEG5pYGpiY
 GRmbWBiaGSqJ8565UpYqJJCeWJKanZpakFoE08fEwSnVwLRk82MvvimXso+VLZjjybTv34vj
 lml2M4WuObdXcIpO+T/JpfuifPGhHXXnJ/ye48Hju6cj/cO/NY2cSZI7z80X7tzcJKx9u9aA
 LaCt5vHxp0rZMz2OOC8/0t6yc92Bv76RwmWu9cwsjULsAtx531f+kzj3gu/Y76RZuZ2zbbtz
 D/++mZm4fd77l7uDJ6mFzlPb84gr2q3o0OwZXyN2eqz5NG+TvJ19ffmpRRF+jKJJ4SFVxy4J
 G8+0uVmky55+9dP57tYj3M4tckz3l70p+Hzd6uKzl39lZb6fPFzuarZD/W/0pLUd5rnqCRXv
 GE12CAQv+XWwas2/CN5l9+Xq7JoEAkqeMjBOejx7iWty4FslluKMREMt5qLiRACKLwG49gMA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnO5XBYM0g5NXpS067t5it/ix6gur
 xbct2xgt3u7tZHdg8ZjdcJHF4+ydHYweO2fvY/LY+G4HUwBLFJdNSmpOZllqkb5dAlfGrsuP
 2Ar2c1fMafnD2MC4lLOLkZNDQsBEorNtDRuILSSwnVFi6lZjiLiUxOenU4HiHEC2sMThw8UQ
 Jc8ZJb4u0QOx2QT0JP4vWsgMYosIuEusffCRBcRmFvCU2LhwKgtE/Womib6GRBCbU8Be4tbi
 36wgI4UFPCQeHTYHCbMIqEp8nXAD7AJeAUuJ1lfv2CEuUJD4+XQZK8R4P4kzP5+wQ4wXkZjd
 2cY8gVFgFhJ3ASPjKkbR1ILi3PTc5AJDveLE3OLSvHS95PzcTYzgQNQK2sG4bP1fvUOMTByM
 hxglOJiVRHinLNRPE+JNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl
 4uCUamDyqsl0mz8z6XCU+BX2Gs1vX0Xs6u/oBmZs/l7cV/spOOJyW8mqlzrrTrIZllt6fjhf
 KdzXrr4uvOejFdO5Iy0tvMkMmdkHGq6fS5Thqo7/aTrvwLPFB/Py29pLT9zboxnikrB+brSB
 5GmBV2uuHm7VWC9R86zT4MzJJWy3vSRD5k7X1JtmckBMvLva+LzZLoufqwqEXky93u1oVP1I
 2XH+emMvF9/P9aZ+NyYuupx09swnA2XDbgutdUU2qXcnKX95/2KH4pxpbXK7NH6b7Kwtnu97
 ndmsyvjl2X4PyR86ES/lz830ZeP3P+rkui3jc/oWV+1tN86qyr7qNZBbsTNLVblsasSxtVHi
 nt4xXkosxRmJhlrMRcWJADTPnaizAgAA
X-CMS-MailID: 20240429223637epcas1p394372e0e5d0a99041e95c7fb694808f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240423231800epcas1p4e21bd06153b2394afd9a8696a4df6470
References: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
 <CGME20240423231800epcas1p4e21bd06153b2394afd9a8696a4df6470@epcas1p4.samsung.com>
 <fab40e09-1ac4-45c3-8dda-f0a1544d2d39@mailbox.org>
 <000001da97a2$d3247950$796d6bf0$@samsung.com>
 <e55e21af-7208-4b4d-9398-ee1e4825f69b@mailbox.org>
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



> -----Original Message-----
> From: Marek Vasut <marek.vasut@mailbox.org>
> Sent: Friday, April 26, 2024 8:41 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de
> Cc: 'Peng Fan' <peng.fan@nxp.com>; 'Simon Glass' <sjg@chromium.org>
> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
>
> On 4/26/24 8:27 AM, Jaehoon Chung wrote:
> > Dear Marek,
> >
> >> -----Original Message-----
> >> From: Marek Vasut <marek.vasut@mailbox.org>
> >> Sent: Wednesday, April 24, 2024 8:18 AM
> >> To: u-boot@lists.denx.de; Jaehoon Chung <jh80.chung@samsung.com>
> >> Cc: Peng Fan <peng.fan@nxp.com>; Simon Glass <sjg@chromium.org>
> >> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
> >>
> >> On 3/16/24 9:13 PM, Marek Vasut wrote:
> >>> In case the cyclic framework is enabled, poll the card detect of already
> >>> initialized cards and deinitialize them in case they are removed. Since
> >>> the card initialization is a longer process and card initialization is
> >>> done on first access to an uninitialized card anyway, avoid initializing
> >>> newly detected uninitialized cards in the cyclic callback.
> >>
> >> Any input on this ?
> >
> > When I have applied your patch from patchwork, it didn't apply directly.
> > If you're ok, I will apply after touch your patch. Is it ok?
>
> Sure.

After touching your patch, I will inform again to you.

Best Regards,
Jaehoon Chung


