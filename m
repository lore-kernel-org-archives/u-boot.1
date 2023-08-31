Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E13C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8EA8654A;
	Thu, 31 Aug 2023 04:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="dMRiC4n6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9167E8654D; Thu, 31 Aug 2023 04:21:17 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCEB862F1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230831022110epoutp01f52fb07e51d6514f2cbf7d3caf7b5201~AVmlaQvOB0115801158epoutp01f
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 02:21:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230831022110epoutp01f52fb07e51d6514f2cbf7d3caf7b5201~AVmlaQvOB0115801158epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693448470;
 bh=DqYy9ThbfLaY/zp/eeDpiDvlYguL/IF7chhOribJwlc=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=dMRiC4n6Q8Tmvh5EgZiAikXkY0MufStmvd9bKu1Q3YkMg/45nq1p9vn8OhWcfJz6k
 1D3GCcmLIyk29Sxwuz6zrpbSH/WO3hN8UWvN0f8Oc6jJSTgBDCy+C3TSfJb2JG5tIX
 JGn3SXWhVNjan8snvVcCLKJnmHq+xxYl8oj5oM5I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230831022110epcas2p432ceff853a56c39969d89199ca2a5838~AVmlMY5Lf0069500695epcas2p4d;
 Thu, 31 Aug 2023 02:21:10 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.97]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4RblJj32kGz4x9QC; Thu, 31 Aug
 2023 02:21:09 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1D.7E.19471.519FFE46; Thu, 31 Aug 2023 11:21:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20230831022108epcas2p1fa637643bc8cf2c7109190194b1cc9d6~AVmkD7vss1200412004epcas2p1E;
 Thu, 31 Aug 2023 02:21:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230831022108epsmtrp146a4cfff1618dba59d7ba6a5c04b8844~AVmkDZiJu0270802708epsmtrp1V;
 Thu, 31 Aug 2023 02:21:08 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-89-64eff915f5ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5A.CB.08788.419FFE46; Thu, 31 Aug 2023 11:21:08 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230831022108epsmtip109eee811e301baa71afe7b45132231ae~AVmj0ue-o0550805508epsmtip1R;
 Thu, 31 Aug 2023 02:21:08 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Michal Simek'" <michal.simek@amd.com>, <u-boot@lists.denx.de>
In-Reply-To: <84b747fb-f026-be06-aa0f-c3bab07c3ac4@amd.com>
Subject: RE: [PATCH] fpga: define dummy fpga_load function for debug build
Date: Thu, 31 Aug 2023 11:21:08 +0900
Message-ID: <000001d9dbb1$cd79b4a0$686d1de0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQaS1oa+dteXB5gcJdKTzVGSaDjQJCjYtbAlpiAjqu8amDIA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmma7oz/cpBrcPi1rsPX6R1eLt3k52
 ByaP1kt/2TzO3tnBGMAUlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZAzRfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCdcWVrUMEm5ooDD08wNzBeYupi5OCQEDCR+LCyoIuRi0NIYA+jxMed
 pxghnE+MEmtPXgJyOIGcb4wSrWecQWyQho/b57NBxPcyStxu8YZoeMEoseLXSnaQBJuAvsTL
 jm2sILaIgLPE2U3/wAZxClhLtL+aCBYXFvCSOHHgBQuIzSKgKnFvTxPYUF4BS4lPb3YxQtiC
 EidnPgGrYRbQlli28DUzxBEKEj+fLoOa7yTRs/0SG0SNiMTszjZmkIMkBO6xSxz/fZwdosFF
 4u6vj4wQtrDEq+NboOJSEi/729ghQVEusWNZEkRvC6NEc9seqGX2Ej9uTmEFqWEW0JRYv0sf
 olxZ4sgtqNP4JDoO/4WawivR0SYE0agucWD7dBYIW1aie85nVgjbQ6L920KWCYyKs5A8OQvJ
 k7OQPDMLYe8CRpZVjFKpBcW56anJRgWGunmp5fDITs7P3cQITnpavjsYX6//q3eIkYmD8RCj
 BAezkghvrNm7FCHelMTKqtSi/Pii0pzU4kOMpsCgn8gsJZqcD0y7eSXxhiaWBiZmZobmRqYG
 5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1MAU7v6wv4bm5I020e0k6p1ZXwIN7Ivo7nKes
 TFpf/VXmh578zGdVElIcZmfDj6q7/Uq4J+LdVR52y/fDJdmaSNZl+Rt/tLr6PmhocFV8Unrd
 oDGXcVmUVsL2/kLGwEk7T3ZM3Lfu9uOgw/8YTp+8mdN+acGyxWwfXBhDDR9+Lz0UXX2n+l3U
 Ru9up7W7lILX3GAWUjE97HLakuWxje4hk0MXTXzEb7/boauT43Yj69KDRJHWl0lTE2zfhnsU
 adw/lnOhQS14kemiVS+D5DiY647NmMjlO+PMY4X27Nx/ChrnN+i4hFsI+ptOudOSnJZ5aEmS
 4tcLbhqlF+p7ixxl11zedOFceOGRSxy7LmZMU2Ipzkg01GIuKk4EAK/ZiwgDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnK7Iz/cpBhPXG1rsPX6R1eLt3k52
 ByaP1kt/2TzO3tnBGMAUxWWTkpqTWZZapG+XwJWxYuoK9oIdzBWH3u1hbmC8wtTFyMkhIWAi
 8XH7fLYuRi4OIYHdjBJtTS/ZIBKyEs/e7WCHsIUl7rccYYUoesYoMX3LIrBuNgF9iZcd24AS
 HBwiAq4SL+7nQ9QcYJTY2PuLEaSGU8Baov3VRFYQW1jAS+LEgRcsIDaLgKrEvT1NYMt4BSwl
 Pr3ZxQhhC0qcnPkErIZZQFvi6c2ncPayha+ZIQ5SkPj5dBnYTBEBJ4me7ZfYIGpEJGZ3tjHD
 PNC9s4cN5oG7D16yT2AUmYVkxSwkK2YhWTELyagFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL
 89L1kvNzNzGCI0NLawfjnlUf9A4xMnEwHmKU4GBWEuGNNXuXIsSbklhZlVqUH19UmpNafIhR
 moNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVAMT65PpUQ2R7feexgltV7ZY4WidoLVxJf+8
 47nzmo893DtjiUid4qtbWydt0/tssb9s8yWFmGdmn2u3NzB3dE0Q0hD3L7Iyvv/o0unsj4vP
 Pxeo07+1X1KA6cKcL5bK8l26nryHb25cNPVgiMyHXPG1Il/eWd57Y/bOYurR2c2XmlurQ5n7
 C8p+Nrz/LGVy8sxan3UOS3bOVKpXXJ7O/MCBu7lo14KabAuGpFdhFp2Naa5/3h9y7Jq9ZJZn
 d6jl9/0Ck61XhSwN/egRVbawUsy05u46fab32k12+wwmeom9fVw2fVl70LyKXY18bkumupqm
 bJF2zXlWIyqtW/755fYLDOcvbH/e3rUh78H7KL8oJZbijERDLeai4kQAA1vapPsCAAA=
X-CMS-MailID: 20230831022108epcas2p1fa637643bc8cf2c7109190194b1cc9d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
 <20230816065437.836392-1-chanho61.park@samsung.com>
 <84b747fb-f026-be06-aa0f-c3bab07c3ac4@amd.com>
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

> On 8/16/23 08:54, Chanho Park wrote:
> > This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
> > CONFIG_SPL_FPGA is not enabled.
>=20
> I would rewrite this because the connection to SPL_FPGA is just one part
> of it.
> It is also taken when CONFIG_FPGA is not enabled.

Sure. Will you rewrite while you pick this patch in your tree or do you wan=
t me to post v2 patch?

Best Regards,
Chanho Park

