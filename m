Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B4CC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 00:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916B8864C7;
	Tue, 29 Aug 2023 02:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="S68vLfcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE1C864BA; Tue, 29 Aug 2023 02:17:07 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD814864AD
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 02:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230829001657epoutp035c27a1d0c791c0947cc16acbbd48e7b4~-snjgI7A70491504915epoutp03u
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:16:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230829001657epoutp035c27a1d0c791c0947cc16acbbd48e7b4~-snjgI7A70491504915epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693268217;
 bh=LlAonKhUeFJRjO0LGsY5M8Zc/IBd3/pN9jclw3a4RDU=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=S68vLfcwtesjrGBBG8kyEiZi0oZIpZexQPmNgZr1bGva/w5B6gR9Kj6VXddWoDdZt
 r5bbl48XQt5nmvvsWdx5XjRFeWwNuZfEMSg85wvm841nlznNtdDd4VOm3fDWDIP0HQ
 ha06wWpiuMyVFPLBs4il2pbmLvJp6vNIPIuo1Zq0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20230829001656epcas2p320b16cd30ed069323a3a162f7706ba02~-snjT9vlt2155321553epcas2p36;
 Tue, 29 Aug 2023 00:16:56 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RZSfJ34z5z4x9Q2; Tue, 29 Aug
 2023 00:16:56 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 AC.45.09660.8F83DE46; Tue, 29 Aug 2023 09:16:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20230829001656epcas2p17bb1a7c8069fdbca1cf5a0d1e546cfc4~-sniiYWqi0509905099epcas2p1R;
 Tue, 29 Aug 2023 00:16:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230829001656epsmtrp19685cc6666c87b447bd23775b3563887~-snihsZ2w2342823428epsmtrp1T;
 Tue, 29 Aug 2023 00:16:56 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-95-64ed38f88010
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C4.3E.08742.7F83DE46; Tue, 29 Aug 2023 09:16:55 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230829001655epsmtip17bdab9e531066ade3bac9d213334b115~-sniSzQIg0568705687epsmtip11;
 Tue, 29 Aug 2023 00:16:55 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Eugen Hristev'" <eugen.hristev@collabora.com>, "'Michal Simek'"
 <michal.simek@amd.com>, <u-boot@lists.denx.de>, <sjg@chromium.org>
In-Reply-To: <d9986db9-0b75-3532-6eca-25c0a21aaab2@collabora.com>
Subject: RE: [PATCH RESEND v3] fpga: add inline stub for fpga_load
Date: Tue, 29 Aug 2023 09:16:55 +0900
Message-ID: <000001d9da0e$1e6b5c10$5b421430$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKXOROXO09LfKR47CUf53buhDxNgQI5yl5xAonZheoCTxB/Cq5NE5EQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQveHxdsUg1UvRC1aF91mtNh7/CKr
 xbct2xgt3u7tZHdg8Wi99JfNY3bDRRaPHXeXMHqcvbODMYAlKtsmIzUxJbVIITUvOT8lMy/d
 Vsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2inkkJZYk4pUCggsbhYSd/Opii/tCRV
 ISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o2tJH2PBJamKVz+fMTcwrhLt
 YuTkkBAwkfi76iR7FyMXh5DADkaJu9v/s0E4nxglvt/6yQLhfGOU+Nz4hAmm5c7C21CJvYwS
 5w5thOp/wSjxdNpkdpAqNgF9iZcd21hBEiICXYwSbc9WsYIkOAUcJTbMm8UIYgsLOEm8ejgZ
 aCEHB4uAqsSMc3ogYV4BS4kZU4+wQdiCEidnPmEBsZkF5CW2v53DDHGFgsTPp8vARooIuEnc
 73vIBlEjIjG7s40ZZK+EQCOHROunj1ANLhJPbxyCsoUlXh3fwg5hS0m87G9jB7lBQqBcYsey
 JIjeFkaJ5rY9UPX2Ej9uTmEFqWEW0JRYv0sfolxZ4sgtqNP4JDoO/4WawivR0SYE0agucWD7
 dBYIW1aie85nVgjbQ2LL9geMExgVZyF5chaSJ2cheWYWwt4FjCyrGMVSC4pz01OLjQqM4ZGd
 nJ+7iRGcHLXcdzDOePtB7xAjEwfjIUYJDmYlEd5Ljq9ShHhTEiurUovy44tKc1KLDzGaAkN9
 IrOUaHI+MD3nlcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXAZHHz
 yM53hd1JFw3PRf1Q/7ngZr/auf/57DK8b+63eHu3af0PU+CJfWLx820ir+5B5SlSxyc9fq86
 IZjX9daKD6fZfjQJpd3dwHK8Ij/u+pYPD5pe8bL1dNtODfRzil6d7cWR6B7SvKdh17mNIqnd
 17kKE4qvqYhuffv+Y4agnWHu71cv3kS9P5z7742Eh+2uKd/7RKaeurOdoczk5btFp6c/YV9x
 +3F1l/uPqLuuz+37VvFkHTPY72kgmPziumxuVdDiO842UyT5JF11E1f9Xf44qyNx24Gwyz6r
 Xpj250ZcYIw+Oqf9XZKWuubS/YaXHgWFWhzTdhQXSGZfzbSk3eE53+5LqkoXbcs/KzizKrEU
 ZyQaajEXFScCAM+b0jQXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnO53i7cpBtv+WVq0LrrNaLH3+EVW
 i29btjFavN3bye7A4tF66S+bx+yGiyweO+4uYfQ4e2cHYwBLFJdNSmpOZllqkb5dAldG15I+
 xoJLUhWvfj5jbmBcJdrFyMkhIWAicWfhbZYuRi4OIYHdjBKzrq9hhUjISjx7t4MdwhaWuN9y
 hBWi6BmjRO/CNWAJNgF9iZcd28ASIgJ9jBJdrXsYIaq+MUpc77nKCFLFKeAosWHeLDBbWMBJ
 4tXDyWxdjBwcLAKqEjPO6YGEeQUsJWZMPcIGYQtKnJz5hAXEZhbQlnh68ymULS+x/e0cZoiL
 FCR+Pl0GdqmIgJvE/b6HbBA1IhKzO9uYYT7o3tnDBvPB3Qcv2ScwisxCsmIWkhWzkKyYhWTU
 AkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwTGkpbmDcfuqD3qHGJk4GA8xSnAw
 K4nwXnJ8lSLEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qB
 afJEwSz+xP2fHX8f+iNaeD3Z2+83Q9lBmwlN+q6XVXluVl3o95y7nO2jZvh09QWBvyu+XJi4
 +MnDFY3mp2YePnX57r8XGduOx5fLah1+e7NQpb26w3qv3Gn5Q7bMRdKfr52588B48UbJTfEa
 mT+ljhWWBxb8chKap3kymftz4rIYGWmLXI3cFJtPzrNadjBb3VjIZZ7HWNT86nhM0QfzRc+3
 zBMUik5WK/n8XdYqp6c6+dMSu4UPX0yc3t3bPHGn+IvTu+qC+WR/rlrUsvavyXrWs6UlvaHv
 75/kWhh31+e3iefCnDVLtvz+opzCVt6yf1alwJ/r4nZT3pm/jC4+WLhWXqblz5G1AmwNbXr1
 S5VYijMSDbWYi4oTAdXEpogQAwAA
X-CMS-MailID: 20230829001656epcas2p17bb1a7c8069fdbca1cf5a0d1e546cfc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828114704epcas2p1c63e365fecd58d601535f1041ffc0563
References: <20230808102227.34233-1-eugen.hristev@collabora.com>
 <f7c04c73-c2f9-5ce4-5953-270e907d89f8@amd.com>
 <CGME20230828114704epcas2p1c63e365fecd58d601535f1041ffc0563@epcas2p1.samsung.com>
 <d9986db9-0b75-3532-6eca-25c0a21aaab2@collabora.com>
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

Hi Eugen,

> -----Original Message-----
> From: Eugen Hristev <eugen.hristev@collabora.com>
> Sent: Monday, August 28, 2023 8:47 PM
> To: Michal Simek <michal.simek@amd.com>; u-boot@lists.denx.de;
> sjg@chromium.org; Chanho Park <chanho61.park@samsung.com>
> Subject: Re: [PATCH RESEND v3] fpga: add inline stub for fpga_load
> 
> On 8/28/23 13:53, Michal Simek wrote:
> > Hi Eugen, + Chanho,
> >
> > On 8/8/23 12:22, Eugen Hristev wrote:
> >> In case CC_OPTIMIZE_FOR_DEBUG is set, unused code will not be
> >> optimized out, hence the reference to fpga_load will be compiled.
> >> if DM_FPGA and SPL_FPGA are not set, the build will fail with :
> >
> > this is not correct. It is not DM_FPGA but only FPGA.
> >
> >
> >>
> >> aarch64-none-linux-gnu-ld.bfd: common/spl/spl_fit.o: in function
> >> `spl_fit_upload_fpga':
> >> u-boot/common/spl/spl_fit.c:595: undefined reference to `fpga_load'
> >>
> >> To solve this, added an inline empty stub in the header if
> >> CC_OPTIMIZE_FOR_DEBUG is set such that the build will succeed.
> >>
> >> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> >> ---
> >> Changes in v3:
> >> - return -ENOSYS
> >> Changes in v2:
> >> - this is a rework as suggested by Simon of this previous patch :
> >> https://protect2.fireeye.com/v1/url?k=eed360f4-8f5875c2-eed2ebbb-74fe
> >> 485cbff1-6ddceb7720c8265c&q=1&e=f4039d69-e052-4de7-b3b0-f25e8f4581a3&
> >> u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Fpatch%2F2023
> >> 0619102839.277902-1-eugen.hristev%40collabora.com%2F
> >>
> >>   include/fpga.h | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/include/fpga.h b/include/fpga.h index
> >> ed688cc0fa3b..33d0dbbe2ba4 100644
> >> --- a/include/fpga.h
> >> +++ b/include/fpga.h
> >> @@ -60,8 +60,17 @@ int fpga_add(fpga_type devtype, void *desc);
> >>   int fpga_count(void);
> >>   const fpga_desc *const fpga_get_desc(int devnum);
> >>   int fpga_is_partial_data(int devnum, size_t img_len);
> >> +#if defined(CONFIG_CC_OPTIMIZE_FOR_DEBUG)
> >
> > And when you enable CONFIG_CC_OPTIMIZE_FOR_DEBUG and FPGA you get
> > compilation warnings.
> >
> > drivers/fpga/fpga.c:265:5: error: redefinition of 'fpga_load'
> >    265 | int fpga_load(int devnum, const void *buf, size_t bsize,
> > bitstream_type bstype,
> >        |     ^~~~~~~~~
> > In file included from include/xilinx.h:7,
> >                   from drivers/fpga/fpga.c:11:
> > include/fpga.h:64:19: note: previous definition of 'fpga_load' with
> > type 'int(int,  const void *, size_t,  bitstream_type,  int)' {aka
> > 'int(int, const void *, long unsigned int,  bitstream_type,  int)'}
> >     64 | static inline int fpga_load(int devnum, const void *buf,
> > size_t bsize,
> >        |                   ^~~~~~~~~
> > make[2]: *** [scripts/Makefile.build:257: drivers/fpga/fpga.o] Error 1
> >
> > I means please tune that condition properly not to create additional
> > compilation warnings for other combinations.
> >
> > Thanks,
> > Michal
> >
> 
> Hello Michal,
> 
> Thanks for reviewing .
> 
> Chanho, I cannot try this at the moment, if you are in a hurry you can
> send a v4 or v2 to your patch addressing this (or maybe your patch does
> not have this problem)

Sure. Actually, my patch does not have the problem.
Michal, could review my patch?

Best Regards,
Chanho Park

