Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51CBC83F10
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 00:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD9F863E1;
	Mon, 28 Aug 2023 02:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YqAAp/yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1657C863E3; Mon, 28 Aug 2023 02:21:37 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9919A863B2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 02:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230828002129epoutp034fadaa620a3e62e58e9f6c9b67a2f857~-ZCO4Vygt1647416474epoutp03X
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 00:21:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230828002129epoutp034fadaa620a3e62e58e9f6c9b67a2f857~-ZCO4Vygt1647416474epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693182089;
 bh=jf/OvNyAOIVM7/SFbEOn3yTBRO+8tidOXoXKGCkzj1Q=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=YqAAp/yu5wL2kxf4VZTr6y/iTuaFyxVZ9ekTz8F1i7VBJULfHb9HaBOnU8HQgR6NG
 yjFLGndruQBrsZ9/zfyHjgbAtlINkWfJL4nMPDUyQqSuJU2XY+FSue5NEB4oWa99na
 BncEBKvHORguTihRzvldteB+QHhumvYDpNAGD2N0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230828002128epcas2p49e2b57deb0a1ab33d892decdaafcc881~-ZCOaE0Pg1800818008epcas2p4v;
 Mon, 28 Aug 2023 00:21:28 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.91]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RYrp01LG9z4x9Q9; Mon, 28 Aug
 2023 00:21:28 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 68.82.19471.888EBE46; Mon, 28 Aug 2023 09:21:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230828002127epcas2p4b327ba702394efe05c6e0e00469903d7~-ZCNPdEsk1800818008epcas2p4n;
 Mon, 28 Aug 2023 00:21:27 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230828002127epsmtrp1668dff86d14df05146584d7d0da92749~-ZCNO2hLZ2200922009epsmtrp1L;
 Mon, 28 Aug 2023 00:21:27 +0000 (GMT)
X-AuditID: b6c32a4d-dc5ff70000004c0f-ab-64ebe8883b27
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D5.EF.18916.788EBE46; Mon, 28 Aug 2023 09:21:27 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230828002127epsmtip11427e3b3d98fbc2d5ca285b133dd418f~-ZCNBkMHa1659616596epsmtip1Y;
 Mon, 28 Aug 2023 00:21:27 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Michal Simek'" <michal.simek@amd.com>, <u-boot@lists.denx.de>,
 <eugen.hristev@collabora.com>
In-Reply-To: <c0e49c05-a5f8-2759-33b5-946bf2283b34@amd.com>
Subject: RE: [PATCH] fpga: define dummy fpga_load function for debug build
Date: Mon, 28 Aug 2023 09:21:27 +0900
Message-ID: <000001d9d945$95ebf520$c1c3df60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQaS1oa+dteXB5gcJdKTzVGSaDjQJCjYtbAfJ1Mfyu69YUUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmqW7Hi9cpBg3z2CxaF91mtNh7/CKr
 xdu9newOzB6tl/6yeey4u4TR4+ydHYwBzFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaG
 uoaWFuZKCnmJuam2Si4+AbpumTlAm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
 BeYFesWJucWleel6eaklVoYGBkamQIUJ2RmvD61jK5grVNF69QdrA+MNvi5GTg4JAROJbXc2
 sncxcnEICexhlDjT0s4K4XxilOh+tJcJzrnXdI4NpuXYwf9QiZ2MEssef2SGcF4wSqz6uIQR
 pIpNQF/iZcc2VhBbRCBForX9NAuIzSlgLXGz9wMTiC0s4CVx4sALsDiLgKrEgcbXYBt4BSwl
 bnWfYISwBSVOznwCVsMsoC2xbOFrZogrFCR+Pl0GNd9J4smGTawQNSISszvbwA6SELjHLvFr
 xgWgZRxAjotE0ycPiF5hiVfHt7BD2FISL/vb2CFKyiV2LEuCaG1hlGhu2wO1y17ix80prCA1
 zAKaEut36UOUK0scuQV1GZ9Ex+G/UFN4JTrahCAa1SUObJ/OAmHLSnTP+cwKYXtItH9byDKB
 UXEWkh9nIflxFpJfZiHsXcDIsopRKrWgODc9NdmowFA3L7UcHt/J+bmbGMHpUMt3B+Pr9X/1
 DjEycTAeYpTgYFYS4b3k+CpFiDclsbIqtSg/vqg0J7X4EKMpMOQnMkuJJucDE3JeSbyhiaWB
 iZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1MSy89uFoat3K/uJ6u17zY9sC4
 /f4zzc2m9So5LGc8NvXRRR+XGefnFrkGqs1jcs6eqlB1wHZeBY+y9cnPb3i0DvCvO6nDdMZi
 5dTFUo0H9hzdnbOrpk/9Le8L4/y1r925u6YKMt4+FnXJMe/tfMbc382fbHjEnesXVLzIKi7e
 d+LXNREOccHtLZu/Raf55B6b5GzfYC19/8gyZV1Rl4i+QNu6iX+NXgjY6P6ZxF824/ZWb776
 KZYms+pmFbOcOTKnfvLjj6XiBnfmV52tD3X0n2xh5rb94PRJE/9qrdgp+/WBhNpB2bX7DpY/
 SzZq+3I5IMX2xtT3T6cUCW08Z/MyXu9T3CUmo7bPPWvNp1gfVGIpzkg01GIuKk4EACE2jZkQ
 BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnG77i9cpBi8Xqli0LrrNaLH3+EVW
 i7d7O9kdmD1aL/1l89hxdwmjx9k7OxgDmKO4bFJSczLLUov07RK4Ml6s+sNU8FewYsXuF8wN
 jFv4uhg5OSQETCSOHfzP1MXIxSEksJ1R4sv9fewQCVmJZ+92QNnCEvdbjrBCFD1jlFh97BVY
 gk1AX+JlxzZWEFtEIE3i9qaLUEUHGCUWTVvCBpLgFLCWuNn7gQnEFhbwkjhx4AULiM0ioCpx
 oPE1WA2vgKXEre4TjBC2oMTJmU/AapgFtCWe3nwKZy9b+JoZ4iIFiZ9Pl0EtdpJ4smETK0SN
 iMTszjZmmA+6d/awwXxw98FL9gmMIrOQrJiFZMUsJCtmIRm1gJFlFaNoakFxbnpucoGhXnFi
 bnFpXrpecn7uJkZwnGgF7WBctv6v3iFGJg7GQ4wSHMxKIryXHF+lCPGmJFZWpRblxxeV5qQW
 H2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTCFqb68kzc3cHN3r1jWoYRanrWT/Cp0
 znj8nsC34aFnaPjt5pk82rz3Eif2BdaVrN/8IDbZzWF7ocId4/mzfcNl6jvvN7cl8Cdl6vXs
 uFS1sDVQp7TgvsMbub2th/5OvRwQYHRh7fy7rcq5oQVfVF7wzvCxuPZF41uRwu41S4sqP613
 nHqxoT9PwntfSJH3jFU+auKHdzt0zVvKctHulMm2aIHFBqt7W4sXpMuqVyTdFspx2XivJmNb
 67Q+135GLXeJ5j9vNAS/f2mO255ySyDRILxqLd+NkAtuKXZsT7scE787HGsWap0dKWp77PMv
 1bYJjZn3779UaVu6zO3I6+f6DqzRTkzbQ2pOZzzIUGIpzkg01GIuKk4EAOr1HqwCAwAA
X-CMS-MailID: 20230828002127epcas2p4b327ba702394efe05c6e0e00469903d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
 <20230816065437.836392-1-chanho61.park@samsung.com>
 <c0e49c05-a5f8-2759-33b5-946bf2283b34@amd.com>
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

Hi,

> -----Original Message-----
> From: Michal Simek <michal.simek=40amd.com>
> Sent: Friday, August 25, 2023 4:23 PM
> To: Chanho Park <chanho61.park=40samsung.com>; u-boot=40lists.denx.de
> Subject: Re: =5BPATCH=5D fpga: define dummy fpga_load function for debug =
build
>=20
> Hi,
>=20
> On 8/16/23 08:54, Chanho Park wrote:
> > This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
> > CONFIG_SPL_FPGA is not enabled.
> >
> > ../common/spl/spl_fit.c:591: undefined reference to =60fpga_load'
> > collect2: error: ld returned 1 exit status
> >
> > Signed-off-by: Chanho Park <chanho61.park=40samsung.com>
> > ---
> >   include/fpga.h =7C 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/include/fpga.h b/include/fpga.h index
> > ed688cc0fa3b..44f2755a3f10 100644
> > --- a/include/fpga.h
> > +++ b/include/fpga.h
> > =40=40 -60,8 +60,16 =40=40 int fpga_add(fpga_type devtype, void *desc);
> >   int fpga_count(void);
> >   const fpga_desc *const fpga_get_desc(int devnum);
> >   int fpga_is_partial_data(int devnum, size_t img_len);
> > +=23if CONFIG_IS_ENABLED(FPGA)
> >   int fpga_load(int devnum, const void *buf, size_t bsize,
> >   	      bitstream_type bstype, int flags);
> > +=23else
> > +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
> > +	      bitstream_type bstype, int flags) =7B
> > +	return FPGA_FAIL;
> > +=7D
> > +=23endif
> >   int fpga_fsload(int devnum, const void *buf, size_t size,
> >   		fpga_fs_info *fpga_fsinfo);
> >   int fpga_loads(int devnum, const void *buf, size_t size,
>=20
> There is another patch targeting the same code.
> Please take a look at
> https://lore.kernel.org/r/20230808102227.34233-1-
> eugen.hristev=40collabora.com

I wasn't aware that there was an attempt to fix the issue. If I knew it, I =
would reply the patch...

>=20
> and work together to come up with the patch which covers both cases.

Yes. I also tried to make the patch with CONFIG_CC_OPTIMIZE_FOR_DEBUG guard=
 but I couldn't find any codes that uses the guard.
And I was also worried about the CC_OPTIMIZE_FOR_DEBUG's behavior. It could=
 be related with the optimization level of the compiler.
That's why I put the guard with =23if CONFIG_IS_ENABLED(FPGA).

Best Regards,
Chanho Park

