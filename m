Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D40BF99C86
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 15:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91E1383BC8;
	Sat, 18 Apr 2026 17:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="x4LLddLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F27383B99; Sat, 18 Apr 2026 17:02:52 +0200 (CEST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F290D83B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 17:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4fyZk03RjSzyQ6;
 Sat, 18 Apr 2026 18:02:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1776524569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxHUgldWFR+3oK1Os31ftjbL27S8pEaLXppruCFz9MQ=;
 b=x4LLddLWRFqDBmMfKtCw3m6hG8LZIacb4Ke+7f3LGF8aOPlLzRtUmzUN4AS/yfvL1RpTXU
 diEazSBBfmE0cbKKWWzH1nR11MEjBa1jN7AtdjPjk9L+XpBeNjTAtcOc3kBTFog9iNyPr4
 4YhFdgLYv6XZGwNydo1CCTgVIywhJNg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1776524569;
 b=Jk6PGOoRBCM3Azhh16uoSFZ/5XGysHBV+XlHOaPUy2gxqAKTsIYGtb3IyK6hnSsCVCbmY9
 a9VsQudfV24tdx5PzHzBil/GHv7vhWGHCNfRzaUqwZQl2icp///n8qx7FIPqJlB9aV3+ux
 crQHt2uLeYOX0qqUt1YU8qjtBEdKnus=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1776524569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxHUgldWFR+3oK1Os31ftjbL27S8pEaLXppruCFz9MQ=;
 b=S1ubbwwH3lJ30OBJ0zKK48WfOhqLHosYbv3AWksuTGsbkijz3lB1tx9fOqSBwG+NTnZe5t
 AWRIpXRntCuycxd5Sc0yEtB89WH9ug7OqDRxIAjdwtSKFsF8sx+n2xhHoQSwG+kyMV92P5
 bLi2xEdgAp19VmAejsAWT+2hTN+0rzA=
Date: Sat, 18 Apr 2026 18:02:47 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <aeOdF46Ny1AfNsMi@kehys.lan>
References: <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
 <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com> <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
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

Hi Robert,

I found some time to spend on this again.

Sat, Mar 28, 2026 at 11:39:00AM -0500, Robert Nelson wrote:
>Side note, here's my ci builder for u-boot.. :
>https://github.com/beagleboard/u-boot-pocketbeagle2

I got a little further by adopting a few changes from your 
build_u-boot.sh script, namely the UART 0x6
and the DRAM start address 0x80080000 for both OPTEE and TF-A.

Previously, the UART output stopped right after switching to a 64-bit 
core. Now I am getting some further messages, but nothing for the 64-bit 
U-boot itself:

U-Boot SPL 2026.01 (Apr 18 2026 - 14:03:05 +0000)
SYSFW ABI: 4.0 (firmware rev 0x000c '12.0.2--v12.00.02 (Clever Cat)')
Changed A53 CPU frequency to 1400000000Hz (T grade) in DT
SPL initial stack usage: 13416 bytes
Trying to boot from MMC2
Authentication passed
Authentication passed
Authentication passed
Authentication passed
Authentication passed
Starting ATF on ARM64 core...

I/TC: 
I/TC: OP-TEE version: Unknown_4.10 (gcc version 14.2.0 (Debian 14.2.0-19)) #1 Sat Apr 18 14:03:00 UTC 2026 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: GIC redistributor base address not provided
I/TC: Assuming default GIC group status and modifier
I/TC: SYSFW ABI: 4.0 (firmware rev 0x000c '12.0.2--v12.00.02 (Clever Cat)')
I/TC: HUK Initialized
I/TC: Disabling output console

I am using the ti-linux-firmware branch (tag 12.00.00.07) of 
https://git.ti.com/git/processor-firmware/ti-linux-firmware.git; I 
couldn't access the repository in your script. I pointed both the 32-bit 
and the 64-bit U-boot build to it via the BINMAN_INDIRS variable.

I am using the most recent OPTEE (tag: 4.10.0) and TF-A (dated April 9).

Initially I was copying the file tiboot3.bin from my build container. I 
tried to mimic your script and switched to copying 
tiboot3-am62x-hs-fs-evm.bin instead (named tiboot3.bin on the MicroSD 
card), but it did not make any difference to the above output.

The U-boot source I am trying to build is your clone 
ef03e35488377a32cdd4f76d1a03ef7f60c798ef (January 30).

Can you give any hint where it could be stuck or how to enable the UART 
output in U-boot? As far as I can tell, my build is passing similar 
options to the U-boot build as yours, with the main one being 
am62_pocketbeagle2_*_defconfig. I'm editing a build script that was 
working for the PHYTEC phyBOARD Lyra. I see that your script is setting 
CONFIG_BOOTCOMMAND in the USB DFU version. I am attempting to build the 
normal version.

With best regards,

	Marko
