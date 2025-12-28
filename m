Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2211CE784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 04:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA4683981;
	Sun, 28 Dec 2025 05:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="DWdrhN6r";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="dy9SS5uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A8E83990; Sun, 28 Dec 2025 02:04:55 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 320AB83956
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 02:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niklas.soderlund@ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 0C03CEC00F2;
 Sat, 27 Dec 2025 20:04:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sat, 27 Dec 2025 20:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1766883891; x=1766970291; bh=69
 VDWvkf0/sgrHsJxZInaffAG0Mx4reXhfELS8ZIDis=; b=DWdrhN6rx1f0VarESJ
 yZfBH9JzXa/5yQoxxPLKxUSeKhdKN4bh0DA68I1QsQJWHhLQLI6XBO97NXtRdpEK
 ieMumilxD6tSjO0Bro6Jo3beWsmJSYPej8JrndyqSxOPNtxSPDPQdO4XxYwrcBzw
 uJhOvKak+D4N8VPFHgiZVcm7M0hDqFbuDLs4JgbbgDwmOwWaWGumhmCuz9mxRLoQ
 7ZANOp0jX4pzFEsXWbj+SKrFYQIvtai0Ny7bm0UFRkq8jdBI2e+d4KSzpe8VE7r8
 fBdyfde1meOoofO0Ozi3pOtHLkxUKYKa7bFtEA9FSbUV+fkJNZ8sqWqJNqOZBQMq
 2Adg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1766883891; x=1766970291; bh=69VDWvkf0/sgrHsJxZInaffAG0Mx
 4reXhfELS8ZIDis=; b=dy9SS5uzC+aI/5jcueKM4LESQYvwMXpsRIrKx//9Fuwl
 NbB2QWGrnOj+26UzVKmSrgaYtQgizM3X4F6pexMEQNc0ecwgObVTrq3e6nsGHrbf
 YsvliLNR8yLDLl5WcF4vb+H4hGa1D3OZzeTHgFIW6UhlE/BtG68SQ3qG2dqn7fNL
 uPY21h8Gtb6KUIOy1FY3MRxslflC5s7GUVtzDb5snO2E/a/09j6d3noIxQb6/+1E
 u9kHCeDsVIcZhUmZNjm5bVeTc+eS4ne/Kw/rW7cds8sxpkgGJUHI5q+M/ic6IXmS
 zctXQYeVQ46HYrs6NK6oJhrpGxpMLBbusiK/LcJUlw==
X-ME-Sender: <xms:MoJQaf99QN969EBQBdlPFXVp4jmUWVvoGLBH4HObrO2HzYdVhpCL8Q>
 <xme:MoJQafYALkA3CFARnNHoTrndTLWn0jn5LSFrt3h6L6yg14s7muoPRvuTGysOtqr6X
 Vc___kH_EzTNk46DlQjMsJ4e_3uFFebFjmliUiBCyT9c1kTHIe5VAM>
X-ME-Received: <xmr:MoJQaW3H_idGkJ48SO5pZBqnW8Y5VxSdlwpiseERfSj99v57tyCeekmOuXTl7kL7QxucT6xgopUM4rtwqMWByM1e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdeklecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:MoJQaSZHEDGW9XS6xHKc0l-CD97d-yuV7dQTs_cb5WDtoARuf5sTWg>
 <xmx:MoJQaWI-WHWFId9o1zKCWdYIOL8zAVG5g28Gcvbe-FyouNLNqbluLA>
 <xmx:MoJQaZG6JkwX2QIglzQQced3OKTc7P_P-cIBi7P7Ly6SVr8Y_6kmHA>
 <xmx:MoJQaVss0AHerc38fzo_2HNqE3ZaBHM6cDmlJSGwY5XwjgzQ4oyUQA>
 <xmx:M4JQafL4FR7aBilCCWKmitAFRt5dwGVlo7fVLySzccm6qaySXjmgWR2H>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:04:49 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/2] clk: renesas: Fix booting Linux on R8A77995 D3
Date: Sun, 28 Dec 2025 02:03:25 +0100
Message-ID: <20251228010327.2836161-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Dec 2025 05:21:18 +0100
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

Niklas Söderlund (2):
  clk: renesas: Do not enable MSTP4 modules on R8A77995 D3
  clk: renesas: Do not disable realtime modules on R8A77995 D3

 drivers/clk/renesas/r8a77995-cpg-mssr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.52.0

