Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36B1E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 11:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4C989220;
	Tue, 10 Dec 2024 12:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XZpYZa1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E67892A4; Tue, 10 Dec 2024 12:16:55 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E2B891C4
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 12:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241210111648epoutp0403034c47d338207e667036aae1618830~PzKkZ1S-d2434224342epoutp04d
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 11:16:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241210111648epoutp0403034c47d338207e667036aae1618830~PzKkZ1S-d2434224342epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733829408;
 bh=+scBT2jxzMQoRKL4UKnas74xENR9jeToo7ikUOop10w=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=XZpYZa1AMtSP6JL120HTwzy6bvHzI0bYqJjFqZYen7zoNDwLhWaIKP/dRzX/a2W8F
 Ur+GjL9Yg8W62cOvh3NVA5hIyMNcYjJFVc0wW6q0RQVDxXdJChxfTcEchZ0hG7j4lK
 VOGz1u1yo5iDC364gK+c3ZXhkvntah6wIo3dHmxI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241210111647epcas1p3b5678a4e8390f2e210a15a772f1b3fc0~PzKj6Jl2q3095230952epcas1p3D;
 Tue, 10 Dec 2024 11:16:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.132]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Y6x5B55lGz4x9Q0; Tue, 10 Dec
 2024 11:16:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 6E.D8.21650.E1328576; Tue, 10 Dec 2024 20:16:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241210111646epcas1p1ec366993a224712e907e7377e0e5dba0~PzKieOIKl1345813458epcas1p1t;
 Tue, 10 Dec 2024 11:16:46 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241210111646epsmtrp28305bd8ac530568e51f9564a0fa1fa2c~PzKidjtMX2621126211epsmtrp2-;
 Tue, 10 Dec 2024 11:16:46 +0000 (GMT)
X-AuditID: b6c32a35-093de70000005492-9b-6758231e6b40
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 48.FA.33707.E1328576; Tue, 10 Dec 2024 20:16:46 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241210111645epsmtip18a72d771f6210a8a177ff7d27466f97e~PzKiSS7Xq1344413444epsmtip1m;
 Tue, 10 Dec 2024 11:16:45 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'U-Boot Mailing List'"
 <u-boot@lists.denx.de>
Cc: "'Tom Rini'" <trini@konsulko.com>, "'Stephen Warren'"
 <swarren@wwwdotorg.org>, "'Stephen Warren'" <swarren@nvidia.com>, "'Matthias
 Brugger'" <mbrugger@suse.com>, "'Peter Robinson'" <pbrobinson@gmail.com>
In-Reply-To: <20241209195528.730260-4-sjg@chromium.org>
Subject: RE: [PATCH v3 3/5] rpi: Drop fdt_high and initrd_high
Date: Tue, 10 Dec 2024 20:16:45 +0900
Message-ID: <0b9201db4af4$ffa59940$fef0cbc0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWHE+rJGlG6nTqz0NZt5G0ftzdLQFpv2XQALO/Mqay2MVhwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmvq6cckS6QfMDNYsFk5+wWqxbtYbN
 4tuWbYwWN6a3sFq8OtjGYjF10mZ2i7d7O9kd2D1mN1xk8dg56y67x6sDq9g9zt7ZwejR2/yO
 zWP9lqssHhvnhgawR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
 ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fL
 Sy2xMjQwMDIFKkzIzmhY/56x4DJPxfxzTxgbGI9zdTFyckgImEj8PXmDtYuRi0NIYAejxM41
 19khnE+MEnOfvWKDc57NbmGDaVn7oR+qaiejxI9Zf5khnJeMEtcad7CCVLEJ6En8X7QQKMHB
 ISIQIXH2hh9ImFngMqPEuyeJIGFOAXOJ3f1JIGFhATuJO8uWgHWyCKhKTFv8BGwXr4ClxLuj
 /YwQexUkfj5dxgox0UniwVx+iIkiErM728AukBD4yS5xdPtcFoh6F4n3h7YxQ9jCEq+Ob2GH
 sKUkPr/bywbR0MwosXTJQVYIp4dR4l/DdagvjSX2L53MBLKNWUBTYv0ufYhtfBLvvvaAHSEh
 wCvR0SYEUa0icen1SyaY+Xef/GeFsD0kVtxfAg2r7YwSM380sk9glJ+F5PBZCBsWMDKtYhRL
 LSjOTU8tNiwwhMdkcn7uJkZwQtQy3cE48e0HvUOMTByMhxglOJiVRHg5vEPThXhTEiurUovy
 44tKc1KLDzGaAkNyIrOUaHI+MCXnlcQbmlgamJgZGZtYGJoZKonznrlSliokkJ5YkpqdmlqQ
 WgTTx8TBKdXAZK7jNulQSVzSnTMpuSE+S/5pq2n84tE8+D0ziKlrjw2b7Ie8I98zxV0ned6a
 zyZxjbPr57SSH3uNUh1V1JYwm387XhQsuGFHgM2EuR17/8+eZ2r+saG1xvPc+onrtv0+eH7u
 5QeH4y+lx3/y2rBjw6RXHN7dG8vqAs4dZ/tse0xzkr3J/+IbawUE7b8J/Z7yq8TPm3He9g8f
 uzfHVXk2fbrVO1XN1aw0sHqOCrfeWUvvzsPcSwo4C5reLuxeWqs1YbnH+5JlP+/uPRG695zG
 /5qTZsyl52P/hnBuu/Dk8MqsQsnN6zsbea9+bX3BrxEec8HddK3075Pb15b4nMw65hLqu+Of
 2qvwE6yObBPW71ZiKc5INNRiLipOBACC256qEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnK6cckS6wde3LBYLJj9htVi3ag2b
 xbct2xgtbkxvYbV4dbCNxWLqpM3sFm/3drI7sHvMbrjI4rFz1l12j1cHVrF7nL2zg9Gjt/kd
 m8f6LVdZPDbODQ1gj+KySUnNySxLLdK3S+DKaFj/nrHgMk/F/HNPGBsYj3N1MXJySAiYSKz9
 0M8OYgsJbGeU2D5ZAiIuJfH56VS2LkYOIFtY4vDhYoiS54wSzb+VQWw2AT2J/4sWMoPYIgIR
 EnN/LWLqYuTiYBa4ziix4XwTO4gjJLCZUeLH9EnsIIM4BcwldvcngTQIC9hJ3Fm2hBXEZhFQ
 lZi2+AkbiM0rYCnx7mg/I8QNChI/ny5jBWkVEXCSeDCXHyTMLCAiMbuzjXkCo8AsJO4CRsZV
 jKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMFBrBW0g3HZ+r96hxiZOBgPMUpwMCuJ8HJ4h6YL
 8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MPU75c5xz/4b
 5fDuTI/Y4+aG9G02/x7bzGWc3xvGFrby69zA17GvuHie7LhndpXN4fcZTYOtVzrFGxlNbjid
 q14/c+efaXOXqzKWuTV89Py4T/6agEi68Im+uw9z2ne6f0jfwvjy/NMtKc//Vj9Q4Y/gOc1V
 uqMpUsbTX1fsquaX06s/LbMpsbmhpKPcZnV2ySMO77f72JcHRcZxTZIIXamUcK1ba5plqdnH
 jndB/HdvZ3E6/9+y9sfWqzwcX1c8f5K5MaLMkUvpauo9tV9bQgvOt+26Utvfc1KYQUfjzJ41
 /wy28vg+2vup0+D498ZpEXNNHy9U2vCu+xDDzpI/TyvapNsfP30fpfHWm+XFpAglluKMREMt
 5qLiRABa1ze80QIAAA==
X-CMS-MailID: 20241210111646epcas1p1ec366993a224712e907e7377e0e5dba0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209195615epcas1p31ff3283b2be65477025a43d02d0ece4d
References: <20241209195528.730260-1-sjg@chromium.org>
 <CGME20241209195615epcas1p31ff3283b2be65477025a43d02d0ece4d@epcas1p3.samsung.com>
 <20241209195528.730260-4-sjg@chromium.org>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Simon Glass
> Sent: Tuesday, December 10, 2024 4:55 AM
> To: U-Boot Mailing List <u-boot@lists.denx.de>
> Cc: Tom Rini <trini@konsulko.com>; Stephen Warren <swarren@wwwdotorg.org>; Stephen Warren
> <swarren@nvidia.com>; Matthias Brugger <mbrugger@suse.com>; Simon Glass <sjg@chromium.org>; Peter
> Robinson <pbrobinson@gmail.com>
> Subject: [PATCH v3 3/5] rpi: Drop fdt_high and initrd_high
>
> These are not needed now since there is a bootm_size setting to keep
> things within the lower part of memory.
>
> Drop them.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch to drop fdt_high and initrd_high
>
>  board/raspberrypi/rpi/rpi.env | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index a327fccc77f..9b9fad82828 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -66,13 +66,6 @@ dfu_alt_info+=zImage fat 0 1
>   */
>  bootm_size=0x20000000
>
> -#ifdef CONFIG_ARM64
> -fdt_high=ffffffffffffffff
> -initrd_high=ffffffffffffffff
> -#else
> -fdt_high=ffffffff
> -initrd_high=ffffffff
> -#endif
>  kernel_addr_r=0x00080000
>  scriptaddr=0x02400000
>  pxefile_addr_r=0x02500000
> --
> 2.34.1



