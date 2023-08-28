Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E934C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 10:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B970E864DB;
	Mon, 28 Aug 2023 12:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="AjMXqcwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B0D864DB; Mon, 28 Aug 2023 12:00:29 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDFF8645F
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230828100020epoutp0107c836226dd221002f1556d6d04b444f~-g7pHIeXX1874518745epoutp01G
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:00:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230828100020epoutp0107c836226dd221002f1556d6d04b444f~-g7pHIeXX1874518745epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693216821;
 bh=ljSjTfOCWmnNK+fLfIptR/tj/6f68gro6KJafs5mmq0=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=AjMXqcwHwNEeW9NzC1NbWMQGrFI9Pk09LvhJdSzjH06fVJ78lg8YY5yByggHD6Py4
 womYPeJMFIWpFg7GFfafQR6ne08or1CWpZBBZ/pqg8Vj764GzeGu2I2QLIPPRqVACg
 ruYUqiq6l49SpvjG7VKkk4u1qQo/b3DPDhSMutN0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230828100020epcas2p14922d1b72d86e60bbc1d7102b3b89d94~-g7o6V8922864728647epcas2p1Y;
 Mon, 28 Aug 2023 10:00:20 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.97]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RZ5dw0Vfqz4x9Q1; Mon, 28 Aug
 2023 10:00:20 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D6.BB.19471.3307CE46; Mon, 28 Aug 2023 19:00:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20230828100019epcas2p266ded2035829ca142811725333c6b2a2~-g7nyibtY1563515635epcas2p2P;
 Mon, 28 Aug 2023 10:00:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230828100019epsmtrp2f48b85cc1b947893d3033c0aa0203f0a~-g7nx7UP61902719027epsmtrp2i;
 Mon, 28 Aug 2023 10:00:19 +0000 (GMT)
X-AuditID: b6c32a4d-dc5ff70000004c0f-2c-64ec70331e7b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E9.25.08788.3307CE46; Mon, 28 Aug 2023 19:00:19 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20230828100019epsmtip29f9ba539d866253d035a60545c41e2c8~-g7nk-S-V1341713417epsmtip2X;
 Mon, 28 Aug 2023 10:00:19 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Eugen Hristev'" <eugen.hristev@collabora.com>, "'Michal Simek'"
 <michal.simek@amd.com>, <u-boot@lists.denx.de>
Cc: "'Simon Glass'" <sjg@chromium.org>
In-Reply-To: <7d288a5d-2d8e-39fa-2b18-327452a4cdbd@collabora.com>
Subject: RE: [PATCH] fpga: define dummy fpga_load function for debug build
Date: Mon, 28 Aug 2023 19:00:19 +0900
Message-ID: <000001d9d996$73b90f50$5b2b2df0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQaS1oa+dteXB5gcJdKTzVGSaDjQJCjYtbAfJ1MfwCTdQ8GwFrvofRrtLlH7A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTVNek4E2KQWeSReui24wWe49fZLX4
 tmUbo8XbvZ3sDiwerZf+snnMbrjI4rHj7hJGj7N3djAGsERl22SkJqakFimk5iXnp2Tmpdsq
 eQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
 5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdM27uRvWC6dEXj3W6WBsZ/ol2M
 nBwSAiYSJ27NZ+ti5OIQEtjDKLF+yUUWCOcTo8SWxd8ZIZxvjBL33k9hhmn5PeMLK0RiL6PE
 1QWtUM4LRomZT5YyglSxCehLvOzYxgpiiwiUSTRPvwbUzcHBLKAm8WurLkiYU8BR4tSk70wg
 trCAl8SJAy9YQGwWAVWJQ/3/2UBsXgFLiV+XHrFD2IISJ2c+AathFpCX2P52DtRBChI/ny6D
 WuUn0dL7kx2iRkRidmcbM8htEgKdHBIPny5hhGhwkVjT3AbVLCzx6vgWdghbSuLzu71sIHdK
 CJRL7FiWBNHbwijR3LYHqt5e4sfNKawQv2hKrN+lD1GuLHHkFtRpfBIdh/+yQ4R5JTrahCAa
 1SUObJ/OAmHLSnTP+cw6gVFpFpLHZiF5bBaSB2Yh7FrAyLKKUSq1oDg3PTXZqMBQNy+1HB7f
 yfm5mxjBCVLLdwfj6/V/9Q4xMnEwHmKU4GBWEuG95PgqRYg3JbGyKrUoP76oNCe1+BCjKTC4
 JzJLiSbnA1N0Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTGrf
 xBpOBzXV8P0W2RN98HhZnSfr3ohJrf7B9dzt5xQ///9quaHJb9LJ4rD/ylnrunsnyzR/MklW
 9bKMv7vkQ2j28f+ffkmmTdK52vSOVVeW2Sj3wvNf2naBR97PsJq0d8pd5pN/75qYNJkUCUou
 1YlbefdgMtc3iYy6KVLLl5v8mzB59vzkIJP6d6cW2T2LXre+LXulw5a450FJzL9X7e2/YCa2
 bpHV1QVq3m0Ju7MObLYNef5mjcj7HfL3q9e+u1XRyTaPc++xQ8Lv/6+vl3p6Ts+3ZWGr124v
 TyaFQwemRRxlU7iffeKQhaa1k3ABT8+rYr8EydfvNvYxa3j+23GpXuOzdumivy8un5sWf1uJ
 pTgj0VCLuag4EQC01EmuGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXte44E2KwfX90hati24zWuw9fpHV
 4tuWbYwWb/d2sjuweLRe+svmMbvhIovHjrtLGD3O3tnBGMASxWWTkpqTWZZapG+XwJUxbe9G
 9oLp0hWNd7tZGhj/iXYxcnJICJhI/J7xhRXEFhLYzSjRtcMdIi4r8ezdDnYIW1jifssRoBou
 oJpnjBK/LjwBa2AT0Jd42bENzBYRqJD49WkFUAMHB7OAmsSvrboQ9YuZJLZv/MYIUsMp4Chx
 atJ3JhBbWMBL4sSBFywgNouAqsSh/v9sIDavgKXEr0uP2CFsQYmTM5+A1TALaEs8vfkUypaX
 2P52DjPEcQoSP58ug7rBT6Kl9yc7RI2IxOzONmaYZ7p39rDBPHP3wUv2CYyis5CsmIVkxSwk
 K2YhGbWAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwXGlp7WDcs+qD3iFGJg7G
 Q4wSHMxKIryXHF+lCPGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbL
 xMEp1cBkGLghov0XB//LQ4Ib2TuLrgbUfPpblNHa/zPkzg/uS2Hz2Foywuecu1x80DApgz9W
 /9gpt/tpi9gyP/jy3PTa2bs4gPHKmXK57ztrNKvbM+6k3zb25a0IUPmz7P5vi+lL1pzyqE0r
 ntZo9FTx8ZYjZx8XJIin//x5tD6x/NH5y4f8578Xa9gwccnjqYbvZgf4dL8Nj/A5wV8Sl7pa
 4pD8zxssD/7M3nU1YM05+3/FhhMC51pLb3D2f+V+viT+TNNZpzk7/XKqTtqzXK5I+5AdJ7/I
 OnNJoktf6cJFO2Y8ZWe+f8p/jRvfl1lmh093CKslTJq+at9itb7mDF/Lxec+djusFN2QZ81W
 FtxpcfKHEktxRqKhFnNRcSIA4C3PIhoDAAA=
X-CMS-MailID: 20230828100019epcas2p266ded2035829ca142811725333c6b2a2
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
 <000001d9d945$95ebf520$c1c3df60$@samsung.com>
 <7d288a5d-2d8e-39fa-2b18-327452a4cdbd@collabora.com>
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
> From: Eugen Hristev <eugen.hristev@collabora.com>
> Sent: Monday, August 28, 2023 5:47 PM
> To: Chanho Park <chanho61.park@samsung.com>; 'Michal Simek'
> <michal.simek@amd.com>; u-boot@lists.denx.de
> Cc: Simon Glass <sjg@chromium.org>
> Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
> 
> On 8/28/23 03:21, Chanho Park wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Michal Simek <michal.simek@amd.com>
> >> Sent: Friday, August 25, 2023 4:23 PM
> >> To: Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de
> >> Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug
> >> build
> >>
> >> Hi,
> >>
> >> On 8/16/23 08:54, Chanho Park wrote:
> >>> This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled
> >>> and CONFIG_SPL_FPGA is not enabled.
> >>>
> >>> ../common/spl/spl_fit.c:591: undefined reference to `fpga_load'
> >>> collect2: error: ld returned 1 exit status
> >>>
> >>> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> >>> ---
> >>>    include/fpga.h | 8 ++++++++
> >>>    1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/include/fpga.h b/include/fpga.h index
> >>> ed688cc0fa3b..44f2755a3f10 100644
> >>> --- a/include/fpga.h
> >>> +++ b/include/fpga.h
> >>> @@ -60,8 +60,16 @@ int fpga_add(fpga_type devtype, void *desc);
> >>>    int fpga_count(void);
> >>>    const fpga_desc *const fpga_get_desc(int devnum);
> >>>    int fpga_is_partial_data(int devnum, size_t img_len);
> >>> +#if CONFIG_IS_ENABLED(FPGA)
> >>>    int fpga_load(int devnum, const void *buf, size_t bsize,
> >>>    	      bitstream_type bstype, int flags);
> >>> +#else
> >>> +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
> >>> +	      bitstream_type bstype, int flags) {
> >>> +	return FPGA_FAIL;
> >>> +}
> >>> +#endif
> >>>    int fpga_fsload(int devnum, const void *buf, size_t size,
> >>>    		fpga_fs_info *fpga_fsinfo);
> >>>    int fpga_loads(int devnum, const void *buf, size_t size,
> >>
> >> There is another patch targeting the same code.
> >> Please take a look at
> >> https://lore.kernel.org/r/20230808102227.34233-1-
> >> eugen.hristev@collabora.com
> >
> > I wasn't aware that there was an attempt to fix the issue. If I knew it,
> I would reply the patch...
> >
> >>
> >> and work together to come up with the patch which covers both cases.
> >
> > Yes. I also tried to make the patch with CONFIG_CC_OPTIMIZE_FOR_DEBUG
> guard but I couldn't find any codes that uses the guard.
> > And I was also worried about the CC_OPTIMIZE_FOR_DEBUG's behavior. It
> could be related with the optimization level of the compiler.
> > That's why I put the guard with #if CONFIG_IS_ENABLED(FPGA).
> >
> > Best Regards,
> > Chanho Park
> >
> 
> 
> Hi Chanho,
> 
> Simon suggested to use CONFIG_CC_OPTIMIZE_FOR_DEBUG in this case here:
> 
> https://protect2.fireeye.com/v1/url?k=a911b2cb-c86a1843-a9103984-
> 74fe4860018a-146c33e2b586dc8a&q=1&e=e288ab48-75e8-400b-91c9-
> e8bd95520918&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Fpatc
> h%2F20230619102839.277902-1-eugen.hristev%40collabora.com%2F
> 
> As I told Michal, basically your patch and my patch do the same thing.
> I suggested him to pick the one that he thinks it's best. (or even suggest
> another way)

I agree. Either way, I'm fine with it.

Best Regards,
Chanho Park

