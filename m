Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA0DD3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4611283CBD;
	Mon, 29 Dec 2025 02:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="QlNBqYof";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="yPpD+CXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3CF83B72; Sun, 28 Dec 2025 23:07:52 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D435083B63
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 23:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niklas.soderlund@ragnatech.se
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 557EC7A0381;
 Sun, 28 Dec 2025 17:07:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 28 Dec 2025 17:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1766959668; x=1767046068; bh=ns
 MGQ5F37ipp8johsbTHS3Xg+xLBLl82w0rB8lsK/tU=; b=QlNBqYofUe44gBnP5N
 VlZTd+ba67UsqI5g834KLwNPV6mszqxIRoEBxCOwIHvQk+IymmNTtQzn99zJkKAx
 qUTIeqlh+gpk8xv8GS4ctmraHaL4Zf7tIYeDGr+x0NR8qbS0DrVOF4gHkUDjwv+N
 DVl3NQ0aKbMnsUHRFGq71br+pYI6F0UmTN4Y7o7IKxW68A1ZGtiPlnwHy08xPipY
 0E4ySszfeVbtcAg1/vxR90SSiaKiKfyoGLVC2hvN665N+CTnsX2aozOA773P3s1n
 ek7SJjniavv/LCKYol004JK8hNHX+mTe7vLPhs5mjhYzVA+WdfeMWzAvbD5ichD2
 aq5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1766959668; x=1767046068; bh=nsMGQ5F37ipp8johsbTHS3Xg+xLB
 Ll82w0rB8lsK/tU=; b=yPpD+CXyK0yDW8mQZ6sYCIOxmJeCM3OOGfcsFf58HGqO
 R4dxLVhylsbOAsBWcAU5t5F7V9UjHC6bKjCcY8Ise9RyXb/HBlKYvNOCdeIv2ZZ+
 3WmuVfW9cErqPU2y0+Jzs1+jFWNia19208Km0UlOWnfO7UD+rR27f0eLFFst7qMd
 oV/jUACG3umaUWZn/MbOLphUdLsocOi5gvDbbsYxhG0K8IVVDi7UcFWZ90x1kIhV
 LG1QBzKgDd2TMVV6bvqTCtV2+xWRXBM31yWLB5QceA0+JvlHROMThCB3nxWiPpQ6
 5BunjaHP4GbALaB1W7sZSzGksMjap5AAVNPFfJE5ww==
X-ME-Sender: <xms:M6pRaca1yVGZTevdwegtoTrURwxIaYIejUEYuMx5Mh7q1Y4Nnn-UVA>
 <xme:M6pRabGKK0pSmG6NrqhcZcU8T8Q9Hg5yMsgZiVdFTx7mZnS4jHPmbHRUUg33BTT1A
 jGhhAcpyN6p_3Tdd3BvCLHWCD6-djuaJLHwwFnSuFTyu-k76cM7Tiw>
X-ME-Received: <xmr:M6pRaQxuFFU_nvZi3Nj7Cc5yykhEkGoXoAo-4E4dGDB11j9lQONkx2lseWDL6h8f-3UcKSXEFON7MEu_S1scVkK7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejheegvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheppfhikhhlrghsucfu
 npguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrghsse
 hrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepheduleetteekgffffedu
 feeuvdejiedvkefhveeifeegffehledtvdevhfefteegnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhgu
 sehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
 houhhtpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthdorhgvnhgvshgrshesmhgrihhl
 sghogidrohhrghdprhgtphhtthhopehifigrmhgrthhsuhesnhhighgruhhrihdrohhrgh
 dprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepthhrihhnihes
 khhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvg
 hngidruggvpdhrtghpthhtohepnhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghs
 rghssehrrghgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:M6pRadkSj1OuS9mpYuq_GXWp0ABF38i679IgbXfbIN50DW0R7UHqMg>
 <xmx:M6pRaZnLWxMRWTYpIhdepD8bdyhwa1ID8SMiN56q96d1Zog3vUSXTQ>
 <xmx:M6pRafxEPaXKu0LGqOXqIlJR3vxZePTzDQ54H31RidkCvhpiTY1jXA>
 <xmx:M6pRaeo9aZXSknyHMHhm1Znkiaj4JBTbJiY3oGkCwRxjRpSqxu8PFA>
 <xmx:NKpRaeH3HF9tjLbsVo71tOtsdOrmGEpgXZxYMfu_3jltDfHZnULZIT-5>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 17:07:46 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/2] clk: renesas: Fix booting Linux on R8A77995 D3
Date: Sun, 28 Dec 2025 23:07:15 +0100
Message-ID: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:49:04 +0100
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

While trying to update stock U-Boot to latest upstream I ran into
trouble as anything after v2023.07 failed to boot Linux. U-Boot itself
function as it should.

        NOTICE:  BL2: R-Car Gen3 Initial Program Loader(CA53) Rev.4.0.0
        NOTICE:  BL2: PRR is R-Car D3 Ver.1.0
        NOTICE:  BL2: PLL1 SSCG Clock select
        NOTICE:  BL2: Board is Draak Rev.1.0
        NOTICE:  BL2: Boot device is HyperFlash(80MHz)
        NOTICE:  BL2: LCM state is CM
        NOTICE:  BL2: DDR1866(rev.0.02)
        NOTICE:  BL2: QoS is default setting(rev.0.05)
        NOTICE:  BL2: CH0: 400000000 - 41fffffff, 512 MiB
        NOTICE:  BL2: FDT at 0xe6313e80
        NOTICE:  BL2: v2.14.0(release):sandbox/v2.14
        NOTICE:  BL2: Built : 00:36:13, Dec 27 2025
        NOTICE:  BL2: Normal boot
        NOTICE:  BL2: dst=0xe6313500 src=0x8180000 len=512(0x200)
        NOTICE:  BL2: dst=0x43f00000 src=0x8180400 len=6144(0x1800)
        NOTICE:  rcar_file_len: len: 0x0003e000
        NOTICE:  BL2: dst=0x44000000 src=0x81c0000 len=253952(0x3e000)
        NOTICE:  rcar_file_len: len: 0x00100000
        NOTICE:  BL2: dst=0x50000000 src=0x8640000 len=1048576(0x100000)
        NOTICE:  BL2: Booting BL31


        U-Boot 2026.01-rc5-00004-ga434270faaa2 (Dec 28 2025 - 01:38:34 +0100)

        CPU:   Renesas Electronics R8A77995 rev 1.0
        Model: Renesas Draak board rev 1.0
        DRAM:  384 MiB
        Core:  60 devices, 23 uclasses, devicetree: separate
        Flash: 64 MiB
        MMC:   mmc@ee140000: 0
        Loading Environment from MMC... Reading from MMC(0)... OK
        In:    serial@e6e88000
        Out:   serial@e6e88000
        Err:   serial@e6e88000
        Net:   eth0: ethernet@e6800000
        Hit any key to stop autoboot: 0
        ethernet@e6800000 Waiting for PHY auto negotiation to complete...... done
        BOOTP broadcast 1
        BOOTP broadcast 2
        DHCP client bound to address 10.0.1.14 (255 ms)
        Using ethernet@e6800000 device
        TFTP from server 10.0.1.1; our IP address is 10.0.1.14
        Filename 'gen3/gen3.itb'.
        Load address: 0x58000000
        Loading: ##################################################  11.5 MiB
                 14.2 MiB/s
        done
        Bytes transferred = 12020010 (b7692a hex)
        ## Loading kernel (any) from FIT Image at 58000000 ...
           Using 'conf-r8a77995-draak.dtb' configuration
           Trying 'kernel' kernel subimage
             Description:  Linux kernel
             Type:         Kernel Image
             Compression:  gzip compressed
             Data Start:   0x580000cc
             Data Size:    11650399 Bytes = 11.1 MiB
             Architecture: AArch64
             OS:           Linux
             Load Address: 0x51000000
             Entry Point:  0x51000000
             Hash algo:    crc32
             Hash value:   7d1cb66c
             Hash algo:    sha1
             Hash value:   7d7bfeb112fea08c86f8a67caf08b74d021ef7d6
           Verifying Hash Integrity ... crc32+ sha1+ OK
        ## Loading fdt (any) from FIT Image at 58000000 ...
           Using 'conf-r8a77995-draak.dtb' configuration
           Trying 'fdt-r8a77995-draak.dtb' fdt subimage
             Description:  Flattened Device Tree r8a77995-draak.dtb
             Type:         Flat Device Tree
             Compression:  gzip compressed
             Data Start:   0x58b3c5d4
             Data Size:    10124 Bytes = 9.9 KiB
             Architecture: AArch64
             Load Address: 0x48000000
             Hash algo:    crc32
             Hash value:   916adb0b
             Hash algo:    sha1
             Hash value:   499bee16ef678e98a3d1de25860c9221657a4301
           Verifying Hash Integrity ... crc32+ sha1+ OK
           Loading fdt from 0x58b3c5d4 to 0x48000000
           Uncompressing Flat Device Tree to 48000000
           Booting using the fdt blob at 0x48000000
        Working FDT set to 48000000
           Uncompressing Kernel Image to 51000000
           Loading Device Tree to 0000000057ff1000, end 0000000057fff2dd ... OK
        Working FDT set to 57ff1000

        Starting kernel ...

        [ SYSTEM IS DEAD ]

Turns out changes to properly turn modules on/off had uncovered a bug in
the tables in r8a77995-cpg-mssr driver. Never versions of the datasheet
have made it clear some module its are not available on D3, and setting
them (as U-Boot do since v2023.10) prevents the system from booting
Linux. Fixing this and the system boots as it should.

A huge thanks to Marek Vasut who helped me debug this and aided me to
get up to speed with the U-Boot drivers!

See individual patches for changelog.

Niklas Söderlund (2):
  clk: renesas: Do not enable MSTP4 extra modules on R8A77995 D3
  clk: renesas: Do not disable realtime modules on R8A77995 D3

 drivers/clk/renesas/r8a77995-cpg-mssr.c | 24 ++++++++++++------------
 drivers/clk/renesas/renesas-cpg-mssr.c  |  3 ++-
 2 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.52.0

