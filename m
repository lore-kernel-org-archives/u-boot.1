Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B9CC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 01:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9914886BFF;
	Fri, 18 Aug 2023 03:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="R707QHCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D34086C0E; Fri, 18 Aug 2023 03:25:42 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A75A86BF8
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 03:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692321926; x=1692926726; i=xypron.glpk@gmx.de;
 bh=ljdmsywNQpDImx8o/RROtsgk41f/zK6Qh6Fb0XFxNhE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=R707QHCugAWWnt3AXhfZ9PyMLrkySBVvowlEUDJ7E/upFaJMKZMK96ocDw/XdQsyZ6iqJU4
 U2/lV1cyfsmcrR2/HNaui6ZDPSAkE6dLBzIL7uuFvCbg2XBYwRNxR/8SzndksZfy6g9XssjXr
 /Eq2JGv4XItD8t4Q4tr9h/NihET6ZYJPaQlfQcRWhnZduobfrm+XIeLeiVjJYO5dZ/dYlXNh/
 r6skhIH5wZR4xCL6ot+klyjZMgNzR7N5MasJC+0RINgaIu9K4PvI4IfI2MtZzCra/qmmNQ4hi
 lgRdwHrb28NV/5U1ma+l3ASwUYkd+mll13/IJjQYK4Ztk0ZW3QhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1q1eZ32rC7-00nQH5; Fri, 18
 Aug 2023 03:25:26 +0200
Date: Fri, 18 Aug 2023 03:25:28 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>, 
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_12/20=5D_x86=3A_smbios=3A_Add_a_?=
 =?US-ASCII?Q?Kconfig_indicating_SMBIOS-table_presence?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230818002706.853550-13-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
 <20230818002706.853550-13-sjg@chromium.org>
Message-ID: <D09E8ACF-FC40-43C5-97E5-08A49E078BFE@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3bo3pWerFJjhA1Jy+6rXaEiKpWn4lrbWfKy4VuMuE7mkVAfchtR
 TMknA3nAqjY8+BRl2Pw1QevqlxAx3KY224R7lWFj81q4uxDM2CN8J5hiSSn6lMvnfUQ1tUc
 64fPFTYL1MMcpvDmJGK5zeB/cejlv9Gpm5eLI3wlpLZ+VVj2G7m2U7PFKEbz6IJzY6tkTTZ
 /Nx1CtWNwD9VFyN/5INyA==
UI-OutboundReport: notjunk:1;M01:P0:jeLjCkClWjk=;zo3ak9RW1hHJM6sZkG0uK12NrRO
 NxCXcq8E3TKdRyOfzrgMGd9o8/7d2JAGZI7Sl0PeTqIbqlYuA4EHfbIGtAdKNqRBLv1AC0ZDe
 usSpjLvjCkZraJFDl+APLdF5tyvx0CyyYWbM8YBEThyj6m27KD0MkUoFK0VIYt8veDXJkfG//
 SyYAHy/P+Wu6CpW0EOOea5d7dNR+8drrqCCEExGSWSvxolVr/Lmm7pDPGz2mplABqoKKMx8pW
 lUCeU3HAbqXjHS+dzoTJUgwil/U14oG6G7gfY5Bx33Di+UgRa0pkQabCUSJS06plyg/oNpatO
 IhjFBVn0I2U/0FjFCm3WC3tAqfP2uJWRiFqNL9UHg0sK8z/VMOVMBMS76UExlb2E78FKjiAft
 hxUYC9vVCNEUHrCIkoeoU5MNi+HXpQuNIBmvksIJNC28Cki0MkiqghdnZUu5v9jK7DUouznHk
 uXT9WhE81GEnhAk65vEAXr7NUaUhlIqvQALE8LiIMnaVxBiCAf/xni9G/uIIaStqMFuXOhTDH
 OysDDmCPxQg9rCUpHERdUXhg5ZgOuMOdAWw1xXhbImbbwF6NZAFjcWWRhYcHlyHjYsqOiiNfX
 QwVFgr38IfcObmZ5oaDZwt34H8QaxjLbqLGlkhcQjK7hCYD/eXhZ5HavxAi0l/RrKWz1TYz8r
 0lWnhTxXqaP2KCLrD+d/epv3qwSjoSWrU48iaNh891eK5BILF5VQQjej8LQQ2LatMZ0MOzNQw
 2rX4G55OLoLjvMlxAY2zMOPu43xpLu+2npUWJJ2q3qo/RCsyNtfLr7gssTaEBW4pE8iy9fS4W
 KmW+0pHr30xE7O75OWwpnZfk+/JZAASDdsWM3yYcqHEbNtEp+N30nKpXphfMFRhTlB3r2/RFC
 dpoKL8QmnGc6DIuAWt7c1QkKD4XWZcWAzNspseMKEnNqzO6bV/ZN5iZ+gMoaZwavCWoIqG16/
 Ghn37FYxjzLHCgU1G+tGJILVbkY=
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



Am 18=2E August 2023 02:26:51 MESZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>When booted from coreboot, U-Boot does not build the SMBIOS tables, but
>it should still pass them on to the OS=2E Add a new option which indicate=
s
>whether SMBIOS tables are present, however they were built=2E
>
>Flip the ordering so that the dependency is listed first, which is less
>confusing=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v2:
>- Add new patch
>
> lib/Kconfig | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/lib/Kconfig b/lib/Kconfig
>index a9dca5f52b5a=2E=2Eb7bbf3f81c56 100644
>--- a/lib/Kconfig
>+++ b/lib/Kconfig
>@@ -984,8 +984,9 @@ config BLOBLIST_TABLES
>=20
> config GENERATE_SMBIOS_TABLE
> 	bool "Generate an SMBIOS (System Management BIOS) table"
>-	default y
> 	depends on X86 || EFI_LOADER
>+	default y
>+	imply SMBIOS

Is there any use case for GENERATE_SMBIOD_TABLE=3Dy and SMBIOS=3Dn?  I wou=
ld have expected 'depends on SMBIOS' here=2E

> 	help
> 	  The System Management BIOS (SMBIOS) specification addresses how
> 	  motherboard and system vendors present management information about
>@@ -1054,6 +1055,15 @@ config SPL_OID_REGISTRY
> 	  unambiguous persistent name (https://en=2Ewikipedia=2Eorg/wiki/Object=
_identifier)=2E
> 	  Enable fast lookup object identifier registry in the SPL=2E
>=20
>+config SMBIOS
>+	bool "SMBIOS support"
>+	depends on X86

We need SMBIOS tables on all EFI architectures=2E

>+	default y
>+	help
>+	  Indicates that this platform can create System Management BIOS

This is very confusing: create and generate are just synonyms=2E Given thi=
s description I would not know what is the difference between the symbols=
=2E

Best regards

Heinrich


>+	  (SMBIOS) tables=2E These provide various pieces of information about
>+	  the board, such as the manufacturer and the model name=2E
>+
> config SMBIOS_PARSER
> 	bool "SMBIOS parser"
> 	help
