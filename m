Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1D0C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C44868D3;
	Mon,  4 Sep 2023 11:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="vCvIN3jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DB9868D9; Mon,  4 Sep 2023 11:30:33 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E598857BF
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230904093025epoutp03eef526520be8a0ca0ccff25be01ee4a9~BqCgxCppW2323623236epoutp03f
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:30:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230904093025epoutp03eef526520be8a0ca0ccff25be01ee4a9~BqCgxCppW2323623236epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693819825;
 bh=6j/FJfHE0liSoeunCsJc5EldouuePyFAetzAXIrYBak=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=vCvIN3jgkfskN/A1X+lMMkWrn83kkwkpFShDvvUtK8nVb3DFcHIFbYV4Y0tSbf9ql
 s3/dRaHd9OoUSJ5Ja4PYqGWfnSBoLxLDyaqTuRoufzymSOeKJGk5u757L9OlzdrsmV
 uguOumzu2iQf0WTUUgjxU6HpuY7mx6Ty0bTmo/Uw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230904093025epcas2p2a3b572fecbe736547f7c8cf1de61cf51~BqCgiEK-Y0816308163epcas2p2K;
 Mon,  4 Sep 2023 09:30:25 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RfNf846Zkz4x9QC; Mon,  4 Sep
 2023 09:30:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 93.99.09649.0B3A5F46; Mon,  4 Sep 2023 18:30:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230904093024epcas2p46053e90e86ff06c72dcfeba536c489b8~BqCfgxw4_3253232532epcas2p4G;
 Mon,  4 Sep 2023 09:30:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230904093024epsmtrp22cf4e6d773216c11d516e0f2ff378256~BqCfgDFTH1186911869epsmtrp2G;
 Mon,  4 Sep 2023 09:30:24 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-94-64f5a3b0f57b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 44.85.08788.FA3A5F46; Mon,  4 Sep 2023 18:30:24 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230904093023epsmtip17d691f0663639108c9b314a8a68862f1~BqCfVmFui0098500985epsmtip1f;
 Mon,  4 Sep 2023 09:30:23 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>, "'Rick
 Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>
Cc: "'Bin Meng'" <bmeng.cn@gmail.com>, "'Anup Patel'"
 <apatel@ventanamicro.com>, <u-boot@lists.denx.de>
In-Reply-To: <20230819131250.10251-3-heinrich.schuchardt@canonical.com>
Subject: RE: [PATCH 2/2] risc-v: implement DBCN based debug console
Date: Mon, 4 Sep 2023 18:30:23 +0900
Message-ID: <004301d9df12$6e749600$4b5dc200$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQDpAsHOP8aGy9YqEgKlPsQRNCZ1hQKd0QYUAgfUdMaxxvD0IA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmue6GxV9TDN5slbOYdek4o8XUnniL
 C4032S3evjjLaPF2bye7xeNDr5kc2Dz2nJ7F7DGroZfNY+esu+weZ+/sYPT4+3MrSwBrVLZN
 RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
 QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjPb2
 BUwFi6Uqms/eZG9g/CvaxcjJISFgInH09Ta2LkYuDiGBHYwSy9asYodwPjFKHNiwgBHC+cYo
 sWT/CXaYlu/7rjKC2EICexklri1Ogyh6wSjx5MM9FpAEm4C+xMuObawgCRGBNkaJs5O3g3Uz
 C2RKbOxsYQOxOQXcJbp7z4BNEhZwlpjy+R9YnEVAReLc3llANgcHr4ClRM+7RJAwr4CgxMmZ
 T1ggxshLbH87hxniIAWJn0+XsULExSVeHj0CtkpEwEliccM3sBskBBZySDxZ+ZUNosFFYvus
 EywQtrDEq+NboD6Tkvj8bi/YXgmBcokdy5IgelsYJZrb9kAts5f4cXMKK0gNs4CmxPpd+hDl
 yhJHbkGdxifRcfgvO0SYV6KjTQiiUV3iwPbpUEtlJbrnfGadwKg0C8ljs5A8NgvJM7MQdi1g
 ZFnFKJZaUJybnlpsVGAEj+vk/NxNjOC0qeW2g3HK2w96hxiZOBgPMUpwMCuJ8Mppf0oR4k1J
 rKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnAxJ1XEm9oYmlgYmZmaG5kamCuJM57r3VuipBAemJJ
 anZqakFqEUwfEwenVANTYVizbbxqbHV4a10/c21nwbONXbr+9y41e3MI5cf1tX4Oc5n55D5f
 KLdRTPeHm7Nubu/ft09sPmuy46lsr+/yfW269XxrxKd6rn4fMmuX123Zg922zX9T3A48fZAT
 23RcOJzJT7hu97NiyakTDJ+zvkivjv/yNvR1zJqY+Ss2fZj/5GjoMud4zZfciQ89dtW9aJh+
 x+7kHLP4z4WLnouW5cy1cTw286Bdfn7xJ7n70rdOl8rE7T2zX9jZ6AarzWe9Ne4H1FXLxMwE
 5DiXvlXc+vXGeb2PDuLZP9Z0SE7fbs9btMv6dBiHpnDD/wNzLTs0Kz2Z9P9oHd77d/LM87uu
 /tj2cu9/he5Pc36XCN5QYinOSDTUYi4qTgQAar8kUyQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnO6GxV9TDJaeYLSYdek4o8XUnniL
 C4032S3evjjLaPF2bye7xeNDr5kc2Dz2nJ7F7DGroZfNY+esu+weZ+/sYPT4+3MrSwBrFJdN
 SmpOZllqkb5dAldGe/sCpoLFUhXNZ2+yNzD+Fe1i5OSQEDCR+L7vKmMXIxeHkMBuRomGZfPZ
 IBKyEs/e7WCHsIUl7rccYYUoesYoMenLclaQBJuAvsTLjm1gCRGBDkaJvZ3PGEESzALZEi+a
 lkKNvcwoMXP1W7CxnALuEt29Z8CKhAWcJaZ8/gcWZxFQkTi3dxaQzcHBK2Ap0fMuESTMKyAo
 cXLmExaQMLOAnkTbRqjx8hLb385hhjhOQeLn02WsEHFxiZdHj7DDPPDn6Fyw6SICThKLG76x
 wjzz6vgW9gmMorOQbJiFsGEWkg2zkExdwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/
 dxMjOOa0tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeOe1PKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
 v73uTRESSE8sSc1OTS1ILYLJMnFwSjUw9bxW0GK7+oVhgfEePonMmqd3us/9O+7m0BzSaLTq
 8fTz6YtzP07MNVCedifm7ITF6c35U8w+Hzpg9Hzyq8CHcUwJueH9s3lsLqQoW6/40PqURYE5
 9uNHpeNaE7QmxZRtD9gdf2L/v9/sl05FW+zKumm3+6DA/O6WzZXnE1WOJX3YaunK5HLWdLvI
 H06PAknVxYtjTi2dUfWsYCvrols9H3s/nNcyuOvFtpQ3LHL2K820H7IiDvNqqhaW6eWt5ZZ+
 Uib/LMgjWCXevna6u2AxX+ICrrIvHp6inrO5Wur+6b343v/eVJ5VZT+TyS3nxRNOvXR5OV9x
 7oTb03h+zY94HSUrol5SvyNw9cvP/tUVSizFGYmGWsxFxYkAnOgiLCgDAAA=
X-CMS-MailID: 20230904093024epcas2p46053e90e86ff06c72dcfeba536c489b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230819131306epcas2p115da29b1053ca3f7d852317e7c61b831
References: <20230819131250.10251-1-heinrich.schuchardt@canonical.com>
 <CGME20230819131306epcas2p115da29b1053ca3f7d852317e7c61b831@epcas2p1.samsung.com>
 <20230819131250.10251-3-heinrich.schuchardt@canonical.com>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Heinrich
> Schuchardt
> Sent: Saturday, August 19, 2023 10:13 PM
> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>; Anup Patel <apatel@ventanamicro.com>;
> u-boot@lists.denx.de; Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>
> Subject: [PATCH 2/2] risc-v: implement DBCN based debug console
> 
> Use the DBCN SBI extension to implement a debug console.
> Make it the default for S-mode RISC-V.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/serial/Kconfig      |  3 ++-
>  drivers/serial/serial_sbi.c | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig index
> a1e089962a..8421c5c047 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -218,6 +218,7 @@ config DEBUG_UART
>  choice
>  	prompt "Select which UART will provide the debug UART"
>  	depends on DEBUG_UART
> +	default DEBUG_SBI_CONSOLE if RISCV_SMODE
>  	default DEBUG_UART_NS16550
> 
>  config DEBUG_UART_ALTERA_JTAGUART
> @@ -289,7 +290,7 @@ config DEBUG_EFI_CONSOLE
> 
>  config DEBUG_SBI_CONSOLE
>  	bool "SBI"
> -	depends on SBI_V01
> +	depends on RISCV_SMODE
>  	help
>  	  Select this to enable a debug console which calls back to SBI to
>  	  output to the console. This can be useful for early debugging of
> diff --git a/drivers/serial/serial_sbi.c b/drivers/serial/serial_sbi.c
> index b9f35ed36e..093c7309d3 100644
> --- a/drivers/serial/serial_sbi.c
> +++ b/drivers/serial/serial_sbi.c
> @@ -3,6 +3,8 @@
>  #include <debug_uart.h>
>  #include <asm/sbi.h>
> 
> +#ifdef CONFIG_SBI_V01
> +
>  static inline void _debug_uart_init(void)  {  } @@ -13,4 +15,21 @@ static
> inline void _debug_uart_putc(int c)
>  		sbi_console_putchar(c);
>  }
> 
> +#else
> +
> +static int sbi_dbcn_available;
> +
> +static inline void _debug_uart_init(void) {
> +	sbi_dbcn_available = sbi_probe_extension(SBI_EXT_DBCN);
> +}
> +
> +static inline void _debug_uart_putc(int ch) {
> +	if (sbi_dbcn_available)
> +		sbi_dbcn_write_byte(ch);
> +}
> +
> +#endif
> +
>  DEBUG_UART_FUNCS
> --
> 2.40.1

I've got below error when I tried to build it with VisionFive2 board
configuration(starfive_visionfive2_defconfig).
To test this patch, I enabled CONFIG_DEBUG_SBI_CONSOLE. Seems like spl also
includes the driver when DEBUG_SBI_CONSOLE is enabled.
Do I need to do any more configurations to test this?

LD      spl/u-boot-spl
riscv64-unknown-linux-gnu-ld.bfd: drivers/serial/serial_sbi.o: in function
`_debug_uart_putc':
/data/risc-v/vf2/mainline/u-boot/drivers/serial/serial_sbi.c:30: undefined
reference to `sbi_dbcn_write_byte'
riscv64-unknown-linux-gnu-ld.bfd:
/data/risc-v/vf2/mainline/u-boot/drivers/serial/serial_sbi.c:30: undefined
reference to `sbi_dbcn_write_byte'
riscv64-unknown-linux-gnu-ld.bfd: drivers/serial/serial_sbi.o: in function
`_debug_uart_init':
/data/risc-v/vf2/mainline/u-boot/drivers/serial/serial_sbi.c:24: undefined
reference to `sbi_probe_extension'
make[2]: *** [/data/risc-v/vf2/mainline/u-boot/scripts/Makefile.spl:527:
spl/u-boot-spl] Error 1

Best Regards,
Chanho Park

