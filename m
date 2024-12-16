Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2707DE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 19:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32667800D7;
	Mon, 16 Dec 2024 20:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="QexVn4M1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93D280104; Mon, 16 Dec 2024 20:03:02 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E15C800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9DC221F93C;
 Mon, 16 Dec 2024 20:02:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1734375779;
 bh=N+g3Cm8RACAVGQlq5NwThkxd2qP7emLNIDYe3fTIUxA=; h=From:To:Subject;
 b=QexVn4M15CU6AXW7iLbwnpUf+J2euOz9DNwTfa7uAptgw80LTY55w+N0ll9IXMlfS
 TaDRWoOZeEAEzoyE4oWgpEuQOybMkNVBdbSVxoSEiEfXEi8WJMC33JD+xKrueHittN
 8VZkGixiMpgQ2C4GrqDCdD8759vbptoFy245ZkEwRsv+AZaYS2cUmyn9FT9zhQSbGW
 BGp7kpBR/jrZkbbEDI79K0kavZ0sePAeUxg0MXUMZUz+wVQv6Iv/E8AiGkEhdr5voU
 BvxGFLZBBJh+uRafBAtCqBhMoWFzD3ZyLZNvlYM4zcDtgfI6USDv39uCLla+9gRFRc
 GzOkmKODrDUwA==
Date: Mon, 16 Dec 2024 20:02:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 u-boot@lists.denx.de
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
Message-ID: <20241216190255.GA55577@francesco-nb>
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
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

Hello,

On Mon, Dec 16, 2024 at 11:28:42AM -0300, João Paulo Gonçalves wrote:
> Hi Sughosh,
> 
> > Can you show the output of bdinfo. And also print the value of ram_top
> > while booting the board.
> >
> 
> Below are ram_top and bdinfo:

We briefly discussed this off list, what is likely happen is that our
heap is after 0xFFFFFFFF, or said in a simpler way in the 64-bit address
space, while ram top is at the 4GB boundary.

The solution seems to either move the heap down or move ram top up.


> 
> U-Boot 2025.01-rc4-00025-g4ff8ecd9b14e-dirty (Dec 16 2024 - 11:21:18 -0300)
> 
> CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> CPU:   Industrial temperature grade (-40C to 105C) at 51C
> Reset cause: POR
> DRAM:  Ram top: FFFFFFFF
> 8 GiB
> ...
> Verdin iMX8MP # bdinfo
> boot_params = 0x0000000000000000
> DRAM bank   = 0x0000000000000000
> -> start    = 0x0000000040000000
> -> size     = 0x00000000c0000000
> DRAM bank   = 0x0000000000000001
> -> start    = 0x0000000100000000
> -> size     = 0x0000000140000000
> flashstart  = 0x0000000000000000
> flashsize   = 0x0000000000000000
> flashoffset = 0x0000000000000000
> baudrate    = 115200 bps
> relocaddr   = 0x00000000ffece000
> reloc off   = 0x00000000bfcce000
> Build       = 64-bit
> current eth = ethernet@30bf0000
> ethaddr     = 6e:79:12:b6:72:24
> IP addr     = <NULL>
> fdt_blob    = 0x00000000ffab8450
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
>  reserved.count = 0x1
>  reserved[0]    [0xffffffff-0x23fffffff], 0x140000001 bytes, flags: no-overwrite
> devicetree  = separate
> arch_number = 0x0000000000000000
> TLB addr    = 0x00000000fffd0000
> irq_sp      = 0x00000000ffab8440
> sp start    = 0x00000000ffab8440
> Early malloc usage: d620 / 10000
> 
> 
> Best Regards,
> João Paulo Gonçalves
