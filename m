Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD738C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 05:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FAF87652;
	Fri,  3 Nov 2023 06:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="PyAC6wqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4248760F; Fri,  3 Nov 2023 06:49:53 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E4787663
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 06:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231103054941epoutp044637d7f80ad9f7fe658f3edabefa03c8~UBu6wLsfX0325603256epoutp04c
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 05:49:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231103054941epoutp044637d7f80ad9f7fe658f3edabefa03c8~UBu6wLsfX0325603256epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698990581;
 bh=vJR8mEVlowayB1uqFcY38W7/t30qwPSspvtkfT5xrLU=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=PyAC6wqoIEgHSdClzSGL/2/Y7/3h0F46qLUEvP7coFgevR+SV9qWK32PaacO4mf15
 jogACgyjv1nISgNsLGDHqntG4s9dORSGMrhgIOXYiulo4yRlkYsvky5zN5t0Phh/xC
 RMoyTyrKD9PNby1PGRt7iYtiYQl8qjFJqYRnzT0Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231103054941epcas1p423c91fc5386377281ecf1008618ab29d~UBu6htS5x2777027770epcas1p4B;
 Fri,  3 Nov 2023 05:49:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.135]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SM8vm2BYDz4x9Q1; Fri,  3 Nov
 2023 05:49:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 9C.24.10211.2F984456; Fri,  3 Nov 2023 14:49:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231103054937epcas1p2a71620a09d60cb180d0876f340c34c6a~UBu3NxVLF0042700427epcas1p2V;
 Fri,  3 Nov 2023 05:49:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231103054937epsmtrp2c2b40c658e30089e580639ac2d7c650a~UBu3NKGtu1055210552epsmtrp2A;
 Fri,  3 Nov 2023 05:49:37 +0000 (GMT)
X-AuditID: b6c32a38-463ff700000027e3-83-654489f2262f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FE.E9.08817.1F984456; Fri,  3 Nov 2023 14:49:37 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231103054937epsmtip2da76b1e67feec33ee60ddf2e80c57956~UBu2v6S9h0057900579epsmtip2M;
 Fri,  3 Nov 2023 05:49:37 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Mattijs Korpershoek'" <mkorpershoek@baylibre.com>
Cc: <lukma@denx.de>, <u-boot@lists.denx.de>
In-Reply-To: <056c01da0df2$1cd85fc0$56891f40$@samsung.com>
Subject: RE: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
Date: Fri, 3 Nov 2023 14:49:36 +0900
Message-ID: <000801da0e19$87c90380$975b0a80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIPhsvHc8pCwIt4eyJoMgh6J8uRpgIEyzJBAVyJXtkCQLOwBgIsNP5sr76sYaA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmru6nTpdUg22rBS2ev7vMZPHi2Fx2
 i7d7O9kdmD3e32hl95g36wSLx9k7OxgDmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjM2d/xhLvipUbHzzya2BsZuxS5GTg4JAROJV3Nv
 sIPYQgI7GCXePM7vYuQCsj8xSnTsvc0E4XxjlLh0+xMTTMeN/XdYIRJ7GSWWnexkhmh/ySgx
 4aghiM0moCfxf9FCsLiIgLnElulzwGxmAW2JP00PGEFsTgEriffbe8FsYQEXiYufZoOdwSKg
 IrF0/1JWEJtXwFJi6vavzBC2oMTJmU9YIObIS2x/CzFTQkBB4ufTZawQcRGJ2Z1tUHv9JK5+
 bgP7QELgI7vE8uXzgBIcQI6LxNVz8hC9whKvjm9hh7ClJD6/28sGUd/MKLF0yUFWCKeHUeJf
 w3U2iCpjif1LJzOBDGIW0JRYv0sfIqwosfP3XEaII/gk3n3tYYXYxSvR0SYEUaIicen1SyaY
 XXef/GedwKg0C8lrs5C8NgvJO7MQli1gZFnFKJZaUJybnlpsWGACj+zk/NxNjOBEqGWxg3Hu
 2w96hxiZOBgPMUpwMCuJ8Dp6u6QK8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5HxgKs4riTc0
 sTQwMTMyNrEwNDNUEuc99qo3RUggPbEkNTs1tSC1CKaPiYNTqoEpbMO684d3TbkltV5n01rH
 z6+2imzKWbHxpGPMFZVPugtTfn5ZHDx9zcSp5sUODXMW1rJmzs9VzWK2nmYddCKApezSuz/6
 1kslVB2S1sx5o35cLIPbcJFTqrvilOML25dfFiyV/Tj/8aVNtZJ2KkWhs/siqt6+dvwoPMGi
 bcE3P7+Qb1ONn8o1ez5ODrZfyLjl2HpHvQCWoPC7RRODLx47Z1qw/ObT7FkCbSuX2T3n7Ouc
 2FWdYJAWkH5qTbu8zduDGRemFnLLRSSbXxK7oBjLcLjiHfek77GOQqXajg92SsjLqpy7+PvX
 4WlJ02azaifufzFlzhrnt0dedAt37bAPbN/56NEPGc/JCusLRVgeK7EUZyQaajEXFScCAGAa
 pTsNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO7HTpdUg7WPdSyev7vMZPHi2Fx2
 i7d7O9kdmD3e32hl95g36wSLx9k7OxgDmKO4bFJSczLLUov07RK4MjZ3/GEu+KlRsfPPJrYG
 xm7FLkZODgkBE4kb+++wdjFycQgJ7GaUOPvpMhNEQkri89OpbF2MHEC2sMThw8UQNc8ZJU71
 nGcDqWET0JP4v2ghM4gtImAusWX6HGaQemYBXYnj980h6qcxSSy6sYAVpIZTwEri/fZeRhBb
 WMBF4uKn2ewgNouAisTS/UvBangFLCWmbv/KDGELSpyc+YQFxGYW0JbofdjKCGHLS2x/O4cZ
 4k4FiZ9Pl7FCxEUkZne2Qd3jJ3H1cxvTBEbhWUhGzUIyahaSUbOQtC9gZFnFKJlaUJybnlts
 WGCUl1quV5yYW1yal66XnJ+7iREcE1paOxj3rPqgd4iRiYPxEKMEB7OSCK+jt0uqEG9KYmVV
 alF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUznhMt2i+s6vry++MkK
 7TiLeRda5zCoJW+p0bnKFqdW5Sb9/7r/xczbgSsOt8Wd1vt/4vDsIxOuz6t/e1A48O9ie5m3
 O7tiVrM7yLIKa2hLp5fO+OG0t8fM2tBDK9tLRJvJTWCDakuG/M/I85+D9GyOv8j4FPvvs+aj
 Er10lTMFGVoNsk9y/CyMJDyf1d1919RntCvyf++JaQVigX+cd7gIfDrbtMxc5NR0R/u49w1P
 fvG8X3XKWybjTcu7U82ndQKn+4QWrOqQCbde9Vo79SKP15uG2T83OrmHvVQJde5Ie5tqZp94
 ReP275N7Jh8W4FglxHhP8uqe2l0rVN33P1/++oCd1xlO/68vreI7DyixFGckGmoxFxUnAgC1
 uowh+AIAAA==
X-CMS-MailID: 20231103054937epcas1p2a71620a09d60cb180d0876f340c34c6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220620111357epcas1p103474818319b5dc45260e043b4ffe3cc
References: <CGME20220620111357epcas1p103474818319b5dc45260e043b4ffe3cc@epcas1p1.samsung.com>
 <20220620111354.448512-1-jh80.chung@samsung.com>
 <169876380794.37728.2863914527348419844.b4-ty@baylibre.com>
 <87h6m4zfbx.fsf@baylibre.com> <056c01da0df2$1cd85fc0$56891f40$@samsung.com>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> Sent: Friday, November 3, 2023 10:07 AM
> To: 'Mattijs Korpershoek' <mkorpershoek@baylibre.com>
> Cc: lukma@denx.de; u-boot@lists.denx.de
> Subject: RE: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
> 
> Hi Mathtjjs,
> 
> > -----Original Message-----
> > From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > Sent: Thursday, November 2, 2023 6:15 PM
> > To: Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: lukma@denx.de; u-boot@lists.denx.de
> > Subject: Re: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
> >
> > Hi Jaehoon,
> >
> > On mar., oct. 31, 2023 at 15:50, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
> >
> > > Hi,
> > >
> > > On Mon, 20 Jun 2022 20:13:54 +0900, Jaehoon Chung wrote:
> > >> Add CONFIG_DFU_NAME_MAX_SIZE to change the proper size.
> > >> If name is longer than default size, it can do wrong behavior during updating
> > >> image. So it need to change the proper maximum size.
> > >>
> > >> This patch is proviced the solution to change value with configuration.
> > >>
> > >>
> > >> [...]
> > >
> > > Thanks, Applied to https://protect2.fireeye.com/v1/url?k=195a8ba3-78d19e99-195b00ec-74fe4860008a-
> > e609da47a4bcadff&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> > boot%2Fcustodians%2Fu-boot-dfu (u-boot-dfu-next)
> > >
> > > [1/1] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
> > >       https://protect2.fireeye.com/v1/url?k=b04b2ae8-d1c03fd2-b04aa1a7-74fe4860008a-
> > d8ec8502221dcca0&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> > boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fcommit%2Fde9b2e10f10996050a10998a0836abe2f9e425e3
> >
> >
> > This patch breaks CI for both arm32 and arm64 platforms:
> >
> > * https://protect2.fireeye.com/v1/url?k=3179f7cc-50f2e2f6-31787c83-74fe4860008a-
> > a4f5d2c73833c4d5&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> > boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725163
> > * https://protect2.fireeye.com/v1/url?k=22773f8e-43fc2ab4-2276b4c1-74fe4860008a-
> > f6dc3d75fe9b283a&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> > boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725164
> 
> I couldn't access the above CI URL.
> 
> >
> > It breaks because multiple boards which include dfu.h without having
> > CONFIG_DFU being set.
> >
> > Tom attempted to fix this with:
> > https://protect2.fireeye.com/v1/url?k=452a9007-24a1853d-452b1b48-74fe4860008a-
> > a88f870953497071&q=1&e=b6fd9ce6-85b6-46a3-81aa-
> > 8aa89d16a9ed&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Flist%2F%3Fseries%3D369275
> >
> > But that had some different issues, see:
> > https://protect2.fireeye.com/v1/url?k=f1c007bd-904b1287-f1c18cf2-74fe4860008a-
> > a305de1bab5bdff1&q=1&e=b6fd9ce6-85b6-46a3-81aa-
> > 8aa89d16a9ed&u=https%3A%2F%2Flibera.irclog.whitequark.org%2Fu-boot%2F2023-10-31%2335154532;
> >
> > I've fixed it up with the following diff:
> >
> > diff --git a/include/dfu.h b/include/dfu.h
> > index 4573f753c565..2c3ffa3f9297 100644
> > --- a/include/dfu.h
> > +++ b/include/dfu.h
> > @@ -99,7 +99,12 @@ struct virt_internal_data {
> >         int dev_num;
> >  };
> >
> > +
> > +#if defined(CONFIG_DFU_NAME_MAX_SIZE)
> >  #define DFU_NAME_SIZE                  CONFIG_DFU_NAME_MAX_SIZE
> > +#else
> > +#define DFU_NAME_SIZE                  32
> > +#endif
> >  #ifndef DFU_DEFAULT_POLL_TIMEOUT
> >  #define DFU_DEFAULT_POLL_TIMEOUT 0
> >  #endif
> >
> > If you have a better idea to fix this, can you please let me know?
> 
> After checking this, let you inform.

It seems that it is depended on USB_GADGET and SPL_USB_GADGET. How about this?
About <dfu.h> is included in some board files, It needs to check more.

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 6502aba96f54..9922da56e704 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -13,6 +13,14 @@ config DFU_OVER_TFTP
        bool
        depends on NET

+config DFU_NAME_MAX_SIZE
+       int "Size of the name to be added in dfu entity"
+       default 32
+       depends on DFU || USB_GADGET_DOWNLOAD || SPL_USB_GADGET
+       help
+         This value is used to maximum size. If name is longer than default size,
+         we need to change the proper maximum size.
+
 if DFU
 config DFU_WRITE_ALT
        bool
@@ -112,13 +120,5 @@ config SYS_DFU_MAX_FILE_SIZE
          this to the maximum filesize (in bytes) for the buffer.
          If undefined it defaults to the CONFIG_SYS_DFU_DATA_BUF_SIZE.

-config DFU_NAME_MAX_SIZE
-       int "Size of the name to be added in dfu entity"
-       default 32
-       depends on DFU
-       help
-         This value is used to maximum size. If name is longer than default size,
-         we need to change the proper maximum size.

I'm running CI with some patch. After checked, I will inform.

Best Regards,
Jaehoon Chung

> 
> > Otherwise, I will squash this to keep CI green.
> >
> > Thank you
> >
> > >
> > > --
> > > Mattijs


