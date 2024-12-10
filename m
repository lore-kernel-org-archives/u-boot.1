Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8DEE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 11:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4222892A4;
	Tue, 10 Dec 2024 12:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uQi4jDmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4B38938D; Tue, 10 Dec 2024 12:17:09 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F10891C4
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 12:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241210111704epoutp04a3e34340eb28f90f3469c4b2e37d7c3d~PzKz9ZhE_2670826708epoutp04R
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 11:17:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241210111704epoutp04a3e34340eb28f90f3469c4b2e37d7c3d~PzKz9ZhE_2670826708epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733829424;
 bh=KykxBSKPu3YO5HmbGEWxOvpjf7R/sNhhmfl2D9MmOEE=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=uQi4jDmwOTZr0vQXLUP7Bf+yKTL1+6vB5Bcrg56dJirUkpjrwhB3BG7NK5NpwHTI/
 N1n9ebaxdLYOKQPjSPYVBjf2w8XTzLEwSCfAdaSQ1pUbnXwij0vLc2945C0uDJbW9x
 OOh9jgyzz4/mNrMIltPooROykFXtPE6ZGR0u0ORw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241210111704epcas1p272c6052ec06285e9a42e64cf0f718da6~PzKzr3IF31975419754epcas1p21;
 Tue, 10 Dec 2024 11:17:04 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.236]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Y6x5W46Wkz4x9Q0; Tue, 10 Dec
 2024 11:17:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 52.E8.21650.F2328576; Tue, 10 Dec 2024 20:17:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241210111703epcas1p2b2074fa1e02c9bcab0c7586ba2a317ce~PzKydhvWM2082520825epcas1p2w;
 Tue, 10 Dec 2024 11:17:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241210111703epsmtrp16871f51343ff7676469d9d1a7bf85d2b~PzKycqeEO3212132121epsmtrp1s;
 Tue, 10 Dec 2024 11:17:03 +0000 (GMT)
X-AuditID: b6c32a35-09bdf70000005492-bc-6758232fa71d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 94.68.18729.F2328576; Tue, 10 Dec 2024 20:17:03 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241210111703epsmtip11c494c875b973ad1b772a93923e00a06~PzKyTYPVB1343813438epsmtip14;
 Tue, 10 Dec 2024 11:17:03 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'U-Boot Mailing List'"
 <u-boot@lists.denx.de>
Cc: "'Tom Rini'" <trini@konsulko.com>, "'Stephen Warren'"
 <swarren@wwwdotorg.org>, "'Stephen Warren'" <swarren@nvidia.com>, "'Matthias
 Brugger'" <mbrugger@suse.com>, "'Peter Robinson'" <pbrobinson@gmail.com>
In-Reply-To: <20241209195528.730260-5-sjg@chromium.org>
Subject: RE: [PATCH v3 4/5] rpi: Update environment to support booti and
 large initrd
Date: Tue, 10 Dec 2024 20:17:02 +0900
Message-ID: <0b9301db4af5$09e46e90$1dad4bb0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWHE+rJGlG6nTqz0NZt5G0ftzdLQGH9LDYAoA+ZOWyyW/QEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmga6+ckS6wbXVChYLJj9htVi3ag2b
 xbct2xgtbkxvYbV4dbCNxWLqpM3sFm/3drI7sHvMbrjI4rFz1l12j1cHVrF7nL2zg9Gjt/kd
 m8f6LVdZPDbODQ1gj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
 cvEJ0HXLzAE6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFqgV5yYW1yal66X
 l1piZWhgYGQKVJiQnXGp5xh7wTLpipkPjrA3MC4S62Lk5JAQMJE4sP0RcxcjF4eQwA5GiRu3
 Z0I5nxgl1h87xgThfGOUuH9qORtMy/4Xy6ASexklFiybzgrhvGSU+HDwIwtIFZuAnsT/RQuB
 ZnFwiAhESJy94QcSZha4zCjx7kkiiM0pYC6xb9k/sHJhgXCJ7Y/amUBsFgFViWlzFoDZvAKW
 Es9a57JALFaQ+Pl0GSuILSLgJPH65ClWiJkiErM725ghan6ySxzYUAJhu0i8ebQAKi4s8er4
 FnYIW0riZX8bO8jNEgLNjBJLlxxkhXB6GCX+NVyHetNYYv/SyUwgDzALaEqs36UPsYxP4t3X
 HlaQsIQAr0RHmxBEtYrEpdcvmWDm333ynxXC9pBonH0GGqTbGSVW/GlmnsAoPwvJ3bMQNixg
 ZFrFKJZaUJybnlpsWGAIj8rk/NxNjOCUqGW6g3Hi2w96hxiZOBgPMUpwMCuJ8HJ4h6YL8aYk
 VlalFuXHF5XmpBYfYjQFhuREZinR5HxgUs4riTc0sTQwMTMyNrEwNDNUEuc9c6UsVUggPbEk
 NTs1tSC1CKaPiYNTqoGplt/vj/+t5wJNvzkstCeVqCW9SOjhbFp4QvqfL+OD37pXt1Ve9GuW
 LTda9cDy1cc/mZk5/WoJDxZfv/S21ZRh+bZneis5K9eWNZ14ujl88R+nv5UMaw5tVc3drW1W
 /cDhXKz4RNOZc4yanySmKj7JqgxIvDXn8jcHt968APl77xSEWGx3z7l66AGb9+GjpfIXZJJP
 HpLYIX4sqmjvpPVNxgyL/Mz4b53c8VE75coiHYWZWpsaDvcZSXcy5xw+Yn9CvH0378P2krXb
 ruSdP+7b9+XHz7XODdtS0w+K8DzUK7grbT/PJjrkgpL291mcLL8F9l8REjg7y06Ne7bonZOx
 r0pnL534zMZ7+8wZc4INlViKMxINtZiLihMBUNx0/BIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnK6+ckS6weVr/BYLJj9htVi3ag2b
 xbct2xgtbkxvYbV4dbCNxWLqpM3sFm/3drI7sHvMbrjI4rFz1l12j1cHVrF7nL2zg9Gjt/kd
 m8f6LVdZPDbODQ1gj+KySUnNySxLLdK3S+DKuNRzjL1gmXTFzAdH2BsYF4l1MXJySAiYSOx/
 sYypi5GLQ0hgN6PE60en2CESUhKfn05l62LkALKFJQ4fLoaoec4ocfT1VVaQGjYBPYn/ixYy
 g9giAhESc38tAhvELHCdUWLD+SZ2iI7NjBKb5+0A6+AUMJfYt+wfC4gtLBAqsXTmArBuFgFV
 iWlzFjCB2LwClhLPWueyQFyhIPHz6TJWiA1OEq9PngKzmQVEJGZ3tjFPYBSYhcRdwMi4ilEy
 taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOKi1NHcwbl/1Qe8QIxMH4yFGCQ5mJRFeDu/Q
 dCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MrqoTEiwy
 rVbN49dc+DM7y+Fm2rWVTuJerMJlD/9LpMnc15Ioe3m74VyN3Oma+3s6lu6UWJ4/69Dea+0c
 ks7VD371PVm2TTmCseDz/5un7F2+B094e+zN7eVp3Cd79mwX2Xa3lsdzjvLZWYvj5NxWfzs4
 Y0ZbjWPT159CxldPSCXMmJTLk10tfXLPoj/lHC75VopbigqPb5wZJmXsMa/OqPZ29oaL75uu
 rDcM38vQtiuyS0jaZNakyntzTX2YbmfdcHIK3fD3R960PjPJhaZadx6L9S0uDM3h7jWZOKfo
 pb+EXLC21JGTFWKSPMvNy1a0KAbuZdkSuF0o0FdlK5eWVstHFp3/7+Wt2h/uNz2mxFKckWio
 xVxUnAgAPmHJCtkCAAA=
X-CMS-MailID: 20241210111703epcas1p2b2074fa1e02c9bcab0c7586ba2a317ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209195624epcas1p2f22b12954d0d3a1a40c8fa37cf3b6e00
References: <20241209195528.730260-1-sjg@chromium.org>
 <CGME20241209195624epcas1p2f22b12954d0d3a1a40c8fa37cf3b6e00@epcas1p2.samsung.com>
 <20241209195528.730260-5-sjg@chromium.org>
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
> Subject: [PATCH v3 4/5] rpi: Update environment to support booti and large initrd
>
> The existing values don't provide for decompressing an arm64 boot-image.
> Add those values and move things apart a bit so that a 50MB kernel can be
> accommodated.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>
> Changes in v3:
> - Update the comment block with the new values, including compression
>
>  board/raspberrypi/rpi/rpi.env | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 9b9fad82828..9ac9d6768ca 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -48,28 +48,33 @@ dfu_alt_info+=zImage fat 0 1
>   *
>   * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
>   * conflict with something else. Reserving 1M for each of them at
> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> + * 0x05400000-0x05500000 and 0x05500000-0x05600000 should be plenty.
>   *
>   * On ARM, both the DTB and any possible initrd must be loaded such that they
>   * fit inside the lowmem mapping in Linux. In practice, this usually means not
>   * more than ~700M away from the start of the kernel image but this number can
>   * be larger OR smaller depending on e.g. the 'vmalloc=xxxM' command line
>   * parameter given to the kernel. So reserving memory from low to high
> - * satisfies this constraint again. Reserving 1M at 0x02600000-0x02700000 for
> - * the DTB leaves rest of the free RAM to the initrd starting at 0x02700000.
> - * Even with the smallest possible CPU-GPU memory split of the CPU getting
> - * only 64M, the remaining 25M starting at 0x02700000 should allow quite
> - * large initrds before they start colliding with U-Boot.
> + * satisfies this constraint again. Reserving 1M at 0x05600000-0x05700000 for
> + * the DTB leaves rest of the free RAM to the initrd starting at 0x05700000.
> + * This means that the board must have at least 128MB of RAM available to
> + * U-Boot, more if the initrd is large.
>   *
> - * Limit bootm_size to 512MB so that all boot images stay within the bottom
> + * For compressed kernels, the maximum size is just under 32MB, with an area for
> + * decompression at 0x02000000 with space for 52MB, which is plenty for current
> + * kernels.
> + *
> + * limit bootm_size to 512MB so that all boot images stay within the bottom
>   * 512MB of memory
>   */
>  bootm_size=0x20000000
>
>  kernel_addr_r=0x00080000
> -scriptaddr=0x02400000
> -pxefile_addr_r=0x02500000
> -fdt_addr_r=0x02600000
> -ramdisk_addr_r=0x02700000
> +kernel_comp_addr_r=0x02000000
> +kernel_comp_size=0x03400000
> +scriptaddr=0x05400000
> +pxefile_addr_r=0x05500000
> +fdt_addr_r=0x05600000
> +ramdisk_addr_r=0x05700000
>
>  boot_targets=mmc usb pxe dhcp
> --
> 2.34.1



