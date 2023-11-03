Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAA8C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 01:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B8E86F31;
	Fri,  3 Nov 2023 02:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="CX1IPaOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E34D87525; Fri,  3 Nov 2023 02:07:42 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A858486F8A
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 02:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231103010733epoutp037e7bbcddb6cff0450a233bc9e5f3e712~T94lo8RYB1671016710epoutp03h
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:07:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231103010733epoutp037e7bbcddb6cff0450a233bc9e5f3e712~T94lo8RYB1671016710epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698973654;
 bh=QY+5KOjn4RTLy1BJ25P5YyXOS04ZfC65LXJ4Wepe7Ko=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=CX1IPaOwDXkP10KdvgynIvlUE5pDJPagoVO8Tu4G7G69+Yr2EHSKb+pIXjDSA59Wl
 iTzGrcHIYwvwdt13fLLCKhJiEQA7pREvBWKyLrouv6+5ocDZZJGQS3UJiVBt2fVTDP
 ops9vRBvh6AFiIZxGCgw2DwYZPe+BmNzRLkifK2A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231103010733epcas1p1a9890bb25ad5bcab6fa8c17d8306918c~T94lHrGQ42929329293epcas1p1j;
 Fri,  3 Nov 2023 01:07:33 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SM2fD07Phz4x9Px; Fri,  3 Nov
 2023 01:07:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 78.C6.08572.0D744456; Fri,  3 Nov 2023 10:07:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231103010728epcas1p29e8379746aa3fd34b0b1a9fc96b271fa~T94gHJQRz2641126411epcas1p2P;
 Fri,  3 Nov 2023 01:07:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231103010728epsmtrp262d99e825f46e3d3d2a25d1fe30e7364~T94gGdaTJ1320013200epsmtrp2P;
 Fri,  3 Nov 2023 01:07:28 +0000 (GMT)
X-AuditID: b6c32a33-f5ffd7000000217c-1c-654447d05082
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F5.D9.07368.FC744456; Fri,  3 Nov 2023 10:07:27 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231103010727epsmtip12e78552a1816e50e8ac029fa74bcfdb2~T94f8mwxE0894208942epsmtip1k;
 Fri,  3 Nov 2023 01:07:27 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Mattijs Korpershoek'" <mkorpershoek@baylibre.com>
Cc: <lukma@denx.de>, <u-boot@lists.denx.de>
In-Reply-To: <87h6m4zfbx.fsf@baylibre.com>
Subject: RE: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
Date: Fri, 3 Nov 2023 10:07:27 +0900
Message-ID: <056c01da0df2$1cd85fc0$56891f40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIPhsvHc8pCwIt4eyJoMgh6J8uRpgIEyzJBAVyJXtkCQLOwBq/Pw/Hg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmge4Fd5dUg20rzSyev7vMZPHi2Fx2
 i7d7O9kdmD3e32hl95g36wSLx9k7OxgDmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMWnykouCRVsfT/IsYGxnNiXYycHBICJhI7TzQw
 dTFycQgJ7GCUuNT4Esr5xChx6MsHVgjnG6PE/dW7WWBaPq04ygyR2Mso8XjtWaiWl4wS07oe
 gVWxCehJ/F+0kBnEFhEwl9gyfQ6YzSygLfGn6QEjiM0poCUxsfEbWFxYwEXi4qfZ7CA2i4CK
 xIFrIEdxcvAKWEo0PW5lhbAFJU7OfMICMUdeYvtbiJkSAgoSP58uY4XY5SZxc9MPJogaEYnZ
 nW1QNS/ZJebe54SwXSQePZ/MCGELS7w6voUdwpaS+PxuLxvIMxICzYwSS5ccZIVwehgl/jVc
 Z4OoMpbYv3Qy0AYOoA2aEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6JjjYhiBIViUuvXzLB
 7Lr75D/rBEalWUhem4XktVlIXpiFsGwBI8sqRrHUguLc9NRkwwJDeGwn5+duYgSnQi3jHYyX
 5//TO8TIxMF4iFGCg1lJhLdIyyVViDclsbIqtSg/vqg0J7X4EKMpMLAnMkuJJucDk3FeSbyh
 iaWBiZmRsYmFoZmhkjiv4oTZKUIC6YklqdmpqQWpRTB9TBycUg1Msoo2tbxmLVP4fHt23wwq
 zLv+iOXNXZvEWw63Z2rsVnql2jthgaKf+A2hRivOixuyf2s7bZ0xz2TqBcvI3PVrstut4pe8
 iA4yObtb3kN0V0V0mZfz8tvVCZ+f7Lwc2tphY6L85dmkL7y/w60PSffK6Oex5DavLTa8/Dkz
 x6Ffq49H42XnpetOP+xvqkyZeI3v9rXWtNd/M+tlJwv9eH7i3g32EA6VncYmi+4V/3dcb64b
 FvZh6dyO+o+RJ07n2Qt9nnaaX3vp4TV+340eKG1+mHVu1ov1PyZ+4BF52pJsUPo2/FprwcTQ
 lzdeVzOuN/sT1jZXY/9Zxvn3vaZuDTXhkxFvmvt22UTPGeIcC3JuKLEUZyQaajEXFScCADbB
 u98OBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO55d5dUg/03rS2ev7vMZPHi2Fx2
 i7d7O9kdmD3e32hl95g36wSLx9k7OxgDmKO4bFJSczLLUov07RK4MhafKSi4JFWx9P8ixgbG
 c2JdjJwcEgImEp9WHGXuYuTiEBLYzSix6t5rNoiElMTnp1OBbA4gW1ji8OFiiJrnjBJLPs9n
 BqlhE9CT+L9oIZgtImAusWX6HGaQemYBXYnj980h6l8wSmy4toMFpIZTQEtiYuM3sHphAReJ
 i59ms4PYLAIqEgeuNTCB2LwClhJNj1tZIWxBiZMzn7BAzNSTaNvICBJmFpCX2P52DjPEmQoS
 P58uY4U4wU3i5qYfTBA1IhKzO9uYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6yYYFh
 Xmq5XnFibnFpXrpecn7uJkZwNGhp7GC8N/+f3iFGJg7GQ4wSHMxKIrxFWi6pQrwpiZVVqUX5
 8UWlOanFhxilOViUxHkNZ8xOERJITyxJzU5NLUgtgskycXBKNTBxR1++1Wez6cuklb+tfV55
 8jQ2S6/wnbOQxZDps6/de8EWbhuXWmW5sosZf3pY7KSOLdO9Xczt9zlL8vONtiucbxtC8vZN
 6F2waW+l3cnANedccyt3/tOZrf7qlJXNKoc5m8qyKm4mhG2YvfV3p9T2f9piKueLLfx7TL9H
 ROqtzqnds/2RV2/y2cMvpy9VXpGjetGV60QR26uAlmmPRTVeP5coPBv3IC3B46+VQFVDQRLj
 r2Pr2D7ZFG/ZaTx1HXfmlYhTDzXTAr/87P4nGvnFeFJmylalGE2ttItx6rOE788qnmJeVFzr
 7+V/Kj7UVWNKraL9yh1c0UtXtXFcXLj0cGxXyVPB47a8VRmxOkosxRmJhlrMRcWJAHIMWID1
 AgAA
X-CMS-MailID: 20231103010728epcas1p29e8379746aa3fd34b0b1a9fc96b271fa
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
 <87h6m4zfbx.fsf@baylibre.com>
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

Hi Mathtjjs,

> -----Original Message-----
> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Sent: Thursday, November 2, 2023 6:15 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: lukma@denx.de; u-boot@lists.denx.de
> Subject: Re: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
> 
> Hi Jaehoon,
> 
> On mar., oct. 31, 2023 at 15:50, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
> 
> > Hi,
> >
> > On Mon, 20 Jun 2022 20:13:54 +0900, Jaehoon Chung wrote:
> >> Add CONFIG_DFU_NAME_MAX_SIZE to change the proper size.
> >> If name is longer than default size, it can do wrong behavior during updating
> >> image. So it need to change the proper maximum size.
> >>
> >> This patch is proviced the solution to change value with configuration.
> >>
> >>
> >> [...]
> >
> > Thanks, Applied to https://protect2.fireeye.com/v1/url?k=195a8ba3-78d19e99-195b00ec-74fe4860008a-
> e609da47a4bcadff&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> boot%2Fcustodians%2Fu-boot-dfu (u-boot-dfu-next)
> >
> > [1/1] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
> >       https://protect2.fireeye.com/v1/url?k=b04b2ae8-d1c03fd2-b04aa1a7-74fe4860008a-
> d8ec8502221dcca0&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fcommit%2Fde9b2e10f10996050a10998a0836abe2f9e425e3
> 
> 
> This patch breaks CI for both arm32 and arm64 platforms:
> 
> * https://protect2.fireeye.com/v1/url?k=3179f7cc-50f2e2f6-31787c83-74fe4860008a-
> a4f5d2c73833c4d5&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725163
> * https://protect2.fireeye.com/v1/url?k=22773f8e-43fc2ab4-2276b4c1-74fe4860008a-
> f6dc3d75fe9b283a&q=1&e=b6fd9ce6-85b6-46a3-81aa-8aa89d16a9ed&u=https%3A%2F%2Fsource.denx.de%2Fu-
> boot%2Fcustodians%2Fu-boot-dfu%2F-%2Fjobs%2F725164

I couldn't access the above CI URL.

> 
> It breaks because multiple boards which include dfu.h without having
> CONFIG_DFU being set.
> 
> Tom attempted to fix this with:
> https://protect2.fireeye.com/v1/url?k=452a9007-24a1853d-452b1b48-74fe4860008a-
> a88f870953497071&q=1&e=b6fd9ce6-85b6-46a3-81aa-
> 8aa89d16a9ed&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fuboot%2Flist%2F%3Fseries%3D369275
> 
> But that had some different issues, see:
> https://protect2.fireeye.com/v1/url?k=f1c007bd-904b1287-f1c18cf2-74fe4860008a-
> a305de1bab5bdff1&q=1&e=b6fd9ce6-85b6-46a3-81aa-
> 8aa89d16a9ed&u=https%3A%2F%2Flibera.irclog.whitequark.org%2Fu-boot%2F2023-10-31%2335154532;
> 
> I've fixed it up with the following diff:
> 
> diff --git a/include/dfu.h b/include/dfu.h
> index 4573f753c565..2c3ffa3f9297 100644
> --- a/include/dfu.h
> +++ b/include/dfu.h
> @@ -99,7 +99,12 @@ struct virt_internal_data {
>         int dev_num;
>  };
> 
> +
> +#if defined(CONFIG_DFU_NAME_MAX_SIZE)
>  #define DFU_NAME_SIZE                  CONFIG_DFU_NAME_MAX_SIZE
> +#else
> +#define DFU_NAME_SIZE                  32
> +#endif
>  #ifndef DFU_DEFAULT_POLL_TIMEOUT
>  #define DFU_DEFAULT_POLL_TIMEOUT 0
>  #endif
> 
> If you have a better idea to fix this, can you please let me know?

After checking this, let you inform.

> Otherwise, I will squash this to keep CI green.
> 
> Thank you
> 
> >
> > --
> > Mattijs

