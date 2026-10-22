Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAEF606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q0PXvCO7;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=YaZs7maz;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=2E3v545C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 977006069A;
	Thu, 22 Oct 2026 16:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JiqHq5OJ0Gu7; Thu, 22 Oct 2026 16:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD7FE606A5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686247;
	b=JQzSBv12PSgfbXzRUmQv21yyP1txEcvPc+o0dmF7fbZnqgl1E3gIa4Tt3Uer/2VsBotO
	 gUDgW8TbB6/r0fjzAwGESSAKFfqnFImxJhfdNqqTlBDJM2xdjZP7zyMSKoh55clUZ6S9X
	 RY9F+AwpX1lkHSdw7GmqKIPW06mdlJeVvqxHmy+qBznamOqSdE7nZm4OE73CcPWtDdr4u
	 a5V/wf2NhLAK5de+S/4hGkPqkRPN+qeMxNfgbJ1vEZ0PfX01wRom3PRU4tGW2oWNGo7LS
	 6DT0PLpgxvqqsTyv/4/A3UOEQimdnYfUQeeFnbqYzhGjJcJbV9ksL5b/H80+XoTWtSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ip08FKgXabUe+9wrCJTMOoamo/ocAEB+q/x6wO0Ddz0=;
	b=W3rnKhkkUOdNclDcCl+djRQuWXflB1AFo1uggRPieRJa6TMn+9WYLDCu52UahHtmFmz+
	 QUtrCjjjZCOWKoKip0yskFOY/SPrX7DQhM4rHNtRA/1mLQlH7Ry+sBO25M+VBL4vgqPd9
	 X7LpRDrweV1tBIcjn5wOqB1KRKJkTqLCme3wnnJUyR79hPQ/7PClICw5UNPLjYUqDL4Em
	 qZ4fFhJcEgMglhPGY7DG0AO/1eOCkeshhITtSNTQWfKmwvnaF86EKlR9aEfTZ3KTEr8+r
	 w7LsNTijy1p+lv6cisZvFvfHWFfDzUaBSCV/bMMlljXwFkQL/H7Zu+JSKsgGTSjUgLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686247;
	bh=ip08FKgXabUe+9wrCJTMOoamo/ocAEB+q/x6wO0Ddz0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0PXvCO7wQSfhRW906Bywn0lGjuLTd9/c9JtKHeookD9RbdLa3M9aSSS8ivYjjrxf
	 IJup1sb1By/iORmUgBRZUM3sJYKImzMSV28BpPirGS9ftDG5h6K0QiFqvMxmIt/jEa
	 McaNt569uTblx2+p4JTNDopog8QjUvxWywq6f0MVljubx55VeZbyyidjpaTMymbrKh
	 dPMcaboCysCz7uJV9q9o/YyiCtdize6NgYGdoJegilAdHNNNGk8wDWhZJivTSzHLlN
	 hS3LvsrZFxGi4IThCRg/Q8IBxYCucJDO4J0z+15SirLIiN0aAVY8HqtcumuXQsAa40
	 NuEq2ldDpC7lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD7FE606A5;
	Thu, 22 Oct 2026 16:24:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92A273AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 847A3811F3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXxxzXB-roIu for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:42:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8415B80D58
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792680148;
 b=YN9qPL5/HVZwwF/s5eVW8+DNvqPk4PWQMO04S75cPb7OyaABUcaxVXXAMIgNRhHhrSpt
 gokt1IusqjonjX/+wd0CF5kgqisN25egS+19AIcpTnau8aigxz8lfLz/sabEuWn35ammy
 ukiFlj5hbYb2INqHVIirEAzJhV+A8kyuZtCZyOssmzznUdUHsmgMCG2eornAZ1D0qct/j
 EmrLX3fdtrd3LyCYjG/I1nP2pbwKF4z2spoyDhDNKo4XDCcySQh/kqNYO09g373oEMgYg
 bW/m81WiqySSnITO+aoqJMZdP8PaGuMZIeUnSCZYy3sBpZmqhf7j0e2Djfpj1pQ1bSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792680148;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=ip08FKgXabUe+9wrCJTMOoamo/ocAEB+q/x6wO0Ddz0=;
 b=k0YdNmC5rYib6XM59unl6Is+TPGr4g0bQvdNvybF6imgwh9ekh+64/BjADXiUhiB09UN
 abWzzx0S8yKF5+SBUk4agNLE+7v1Qnt0QlAxOmUex5oi7zkJNqdN3UqN10pq/A/DeWbV9
 jNolEMpBuomKhL17k4+kanTuY7IRTxb99+SrZw7/ppOWPgJ0dHK/hLRc4OAVhIfXFB3ul
 8VHIjq7GV4qTcJ2FtJSjD1YEDQO7YvMDiKggvhK0W7k+MW0p7YD4H9l2+bX/9tXt9JeVw
 CS4MPx9PWTBF34CBDUIZNVlVZsqPx3YUoYFG6y1s4jaPDlkNldLURdUWb384ZEzGhkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=YaZs7maz; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=2E3v545C; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=YaZs7maz; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=2E3v545C
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8415B80D58
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792680127; bh=ip08FKgXabUe+9wrCJTMOoa
 mo/ocAEB+q/x6wO0Ddz0=; b=YaZs7mazAOJNF73xWK0OL4ExiGCMqxdhaBQeutSoo6/DaXRHu/
 vu/pFo7wzl+VKU2AxMK82PVWRt8zdvL3OidXhouaGkOy5ZLKwSHKvDFGV6YDJbIz7khUmxUkDPw
 N50kW+GaMTFK7vxxmEH0yDtYigSE7MXfPLF0j+YpMI+ntBH/7zAsoYzHNRx6E19gVaqp5gQgnvi
 1erg1YdOaz5eyaQf4mCGNUDhUJzMJl9f2NiXuaG0eKE8PLGcwJeSH/tXoxGAUMNJXngZd5/rtd1
 7QpQROKOjKoh4luE6eQ16GelDUrSSHXs3/JoYYCwj62/ILkresJN8mb5BmSGQDzSSzQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792680127; bh=ip08FKgXabUe+9wrCJTMOoa
 mo/ocAEB+q/x6wO0Ddz0=; b=2E3v545C9vSgGB1heQBjIwUtCmgdqpzGmg8kFjbRLLIo2yHk1M
 dLmZc/kSk6Qnc1vHrI7k/tV2tgs6pJzpEnBA==;
Date: Thu, 22 Oct 2026 15:42:07 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>,
 Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
In-Reply-To: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
Message-ID: <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 16:24:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22 October 2026 08:34:37 BST, Peng Fan <peng.fan@oss.nxp.com> wrote:
>Hi Tom,
>
>Please pull fsl-qoriq-for-2027-01-rc1
>
>---------------------------------------------------
>Drop various legacy powerpc support from Bradley
>Make BASE_DISCOVER_AGENT it optional following spec
>Various update for lx2160a serdes from Vincent
>Check LSB_FIRST for fsl_espi
>---------------------------------------------------
>
>CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1672
>
>Thanks
>Peng
>
>The following changes since commit
>e36b675ebc4c41f1f4187c46d363d581c371d538:
>
>  Merge patch series "rsa: fix rsa_gen_key_prop() buffer-sizing and zero-modulus handling" (2026-10-19 16:52:34 -0600)
>
>are available in the Git repository at:
>
>  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2027-01-rc1
>
>for you to fetch changes up to 20adeef914d05628583138733449596f17450b3d:
>
>  MAINTAINERS: powerpc: Add me as PowerPC maintainer (2026-10-22 07:32:56 +0800)
>
>----------------------------------------------------------------
>Bradley Morgan (26):
>      board: powerpc: Remove MPC8548CDS support
>      board: powerpc: Remove MPC837XERDB support

Sinan (the maintainer) NAKed this ^

>      board: powerpc: Remove P2020RDB-PC support
>      board: powerpc: Remove P3041DS support
>      board: powerpc: Remove P4080DS support
>      board: powerpc: Remove P5040DS support
>      board: powerpc: Remove T1042D4RDB support
>      powerpc: mpc85xx: Remove P3041 support
>      powerpc: mpc85xx: Remove P4080 support
>      powerpc: mpc85xx: Remove P5040 support
>      powerpc: mpc83xx: Remove MPC837x support
>      powerpc: mpc85xx: Remove C29x support
>      powerpc: mpc85xx: Remove P1011 support
>      powerpc: mpc85xx: Remove P1023 support
>      powerpc: mpc85xx: Remove P1025 support
>      powerpc: mpc85xx: Remove MPC8536 support
>      powerpc: mpc85xx: Remove MPC8540 support
>      powerpc: mpc85xx: Remove MPC8560 support
>      powerpc: mpc85xx: Remove BSC9132 support
>      powerpc: mpc83xx: Remove MPC831x support
>      powerpc: mpc83xx: Remove MPC834x support
>      powerpc: mpc85xx: Remove P1024 support
>      powerpc: mpc85xx: Remove BSC9131 support
>      powerpc: mpc83xx: Remove MPC8309 support
>      powerpc: Remove MPC86xx support
>      MAINTAINERS: powerpc: Add me as PowerPC maintainer
>
>Bryan Brattlof (1):
>      firmware: scmi: check if BASE_DISCOVER_AGENT is implemented
>
>Tomas Alvarez Vanoli (1):
>      spi: fsl_espi: check user's LSB_FIRST
>
>Vincent Jardin (18):
>      power: regulator: pmbus: check the device in the exported helpers
>      power: regulator: pmbus: read back the VOUT_COMMAND setpoint
>      test: dm: pmbus: test pmbus_regulator_read_vout_command()
>      board: nbxv3: VID handoff writes table value, no droop compensation
>      armv8: fsl-layerscape: icid: also find DWC3 nodes as fsl, ls1028a-dwc3
>      board: lx2160a: serdes: drop the split subcommand
>      board: lx2160a: serdes: rename serdes1:split to serdes1:100g4x25g
>      board: lx2160a: serdes: rename SPLIT_POLL_US to SRDS_POLL_US
>      board: lx2160a: serdes: move the SD1 halt and reset into helpers
>      board: lx2160a: serdes: set SD1 with a table
>      board: lx2160a: serdes: report unknown SD1 cases
>      board: lx2160a: serdes: no SD1 config once MC runs
>      board: lx2160a: serdes: add serdes1:2x40g
>      board: lx2160a: serdes: enter a SD1 mode through the mode it starts from
>      board: lx2160a: serdes: add serdes1:40g4x10g
>      board: lx2160a: serdes: add serdes1:100g4x10g
>      doc: lx2160a: document the sd1 hwconfig option
>      board: nbxv3: apply sd1 hwconfig before MC starts
>
> MAINTAINERS                                        |   3 +-
> README                                             |   2 +-
> api/api_platform-powerpc.c                         |   2 +-
> arch/Kconfig                                       |   7 +-
> arch/Kconfig.nxp                                   |   9 +-
> arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc   |   7 +
> arch/arm/cpu/armv8/fsl-layerscape/icid.c           |  18 +-
> arch/powerpc/cpu/Makefile                          |   1 -
> arch/powerpc/cpu/mpc83xx/Kconfig                   |  44 --
> arch/powerpc/cpu/mpc83xx/cpu.c                     |  17 +-
> arch/powerpc/cpu/mpc83xx/cpu_init.c                |  24 -
> arch/powerpc/cpu/mpc83xx/fdt.c                     |  47 +-
> arch/powerpc/cpu/mpc83xx/hid/Kconfig               |   4 +-
> arch/powerpc/cpu/mpc83xx/hid/hid.h                 |   5 -
> arch/powerpc/cpu/mpc83xx/hrcw/Kconfig              |  82 +--
> arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr      |   6 +-
> arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr      |   2 +-
> arch/powerpc/cpu/mpc83xx/pci.c                     |   2 -
> arch/powerpc/cpu/mpc83xx/spd_sdram.c               |   4 +-
> arch/powerpc/cpu/mpc83xx/speed.c                   | 112 +---
> arch/powerpc/cpu/mpc83xx/traps.c                   |   1 -
> arch/powerpc/cpu/mpc85xx/Kconfig                   | 443 +-------------
> arch/powerpc/cpu/mpc85xx/Makefile                  |  14 -
> arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c          | 101 ----
> arch/powerpc/cpu/mpc85xx/c29x_serdes.c             |  70 ---
> arch/powerpc/cpu/mpc85xx/cmd_errata.c              |  43 +-
> arch/powerpc/cpu/mpc85xx/cpu.c                     |  17 -
> arch/powerpc/cpu/mpc85xx/cpu_init.c                |  49 +-
> arch/powerpc/cpu/mpc85xx/fdt.c                     |  28 +-
> arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c      | 665
> ---------------------
> arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h      |   4 -
> arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c          | 250 --------
> arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c          |  57 --
> arch/powerpc/cpu/mpc85xx/p1023_serdes.c            |  59 --
> arch/powerpc/cpu/mpc85xx/p3041_ids.c               | 112 ----
> arch/powerpc/cpu/mpc85xx/p3041_serdes.c            | 133 -----
> arch/powerpc/cpu/mpc85xx/p4080_ids.c               | 112 ----
> arch/powerpc/cpu/mpc85xx/p4080_serdes.c            |  80 ---
> arch/powerpc/cpu/mpc85xx/p5040_ids.c               | 111 ----
> arch/powerpc/cpu/mpc85xx/p5040_serdes.c            |  99 ---
> arch/powerpc/cpu/mpc85xx/release.S                 |  23 +-
> arch/powerpc/cpu/mpc85xx/speed.c                   |   6 +-
> arch/powerpc/cpu/mpc8xxx/Makefile                  |   1 -
> arch/powerpc/cpu/mpc8xxx/cpu.c                     |  23 +-
> arch/powerpc/cpu/mpc8xxx/fdt.c                     |   8 +-
> arch/powerpc/cpu/mpc8xxx/srio.c                    |   6 -
> arch/powerpc/dts/Makefile                          |   7 -
> arch/powerpc/dts/mpc8379erdb.dts                   | 153 -----
> arch/powerpc/dts/mpc8548-post.dtsi                 |  36 --
> arch/powerpc/dts/mpc8548.dtsi                      |  27 -
> arch/powerpc/dts/mpc8548cds.dts                    |  29 -
> arch/powerpc/dts/mpc8548cds_36b.dts                |  29 -
> arch/powerpc/dts/p2020rdb-pc.dts                   |  59 --
> arch/powerpc/dts/p2020rdb-pc.dtsi                  |  50 --
> arch/powerpc/dts/p2020rdb-pc_36b.dts               |  59 --
> arch/powerpc/dts/p3041.dtsi                        | 149 -----
> arch/powerpc/dts/p3041ds.dts                       | 158 -----
> arch/powerpc/dts/p3041si-post.dtsi                 |  43 --
> arch/powerpc/dts/p4080.dtsi                        | 148 -----
> arch/powerpc/dts/p4080ds.dts                       | 220 -------
> arch/powerpc/dts/p4080si-post.dtsi                 |  62 --
> arch/powerpc/dts/p5040.dtsi                        | 137 -----
> arch/powerpc/dts/p5040ds.dts                       | 281 ---------
> arch/powerpc/dts/p5040si-post.dtsi                 |  70 ---
> arch/powerpc/dts/t1042d4rdb-u-boot.dtsi            |  12 -
> arch/powerpc/dts/t1042d4rdb.dts                    |  89 ---
> arch/powerpc/dts/t104x.dtsi                        | 148 -----
> arch/powerpc/include/asm/arch-mpc83xx/gpio.h       |   4 +-
> arch/powerpc/include/asm/arch-mpc83xx/soc.h        |  37 +-
> arch/powerpc/include/asm/config.h                  |   1 -
> arch/powerpc/include/asm/config_mpc85xx.h          |  56 +-
> arch/powerpc/include/asm/fsl_law.h                 |   8 -
> arch/powerpc/include/asm/fsl_lbc.h                 |  15 +-
> arch/powerpc/include/asm/fsl_pci.h                 |   7 -
> arch/powerpc/include/asm/fsl_secure_boot.h         |   1 -
> arch/powerpc/include/asm/fsl_serdes.h              |   3 -
> arch/powerpc/include/asm/global_data.h             |  19 +-
> arch/powerpc/include/asm/immap_83xx.h              | 123 +---
> arch/powerpc/include/asm/immap_85xx.h              | 253 +-------
> arch/powerpc/include/asm/mpc8349_pci.h             | 165 -----
> arch/powerpc/include/asm/mpc8xxx_spi.h             |   5 +-
> arch/powerpc/include/asm/ppc.h                     |  14 +-
> arch/powerpc/include/asm/processor.h               |  36 +-
> arch/powerpc/lib/bdinfo.c                          |   2 +-
> arch/powerpc/lib/bootm.c                           |   7 -
> arch/powerpc/lib/ppccache.S                        |   4 +-
> arch/powerpc/lib/stack.c                           |   2 +-
> board/nxp/common/Makefile                          |  11 -
> board/nxp/common/cds_pci_ft.c                      |  17 -
> board/nxp/common/cds_via.c                         |  95 ---
> board/nxp/common/ics307_clk.c                      | 149 -----
> board/nxp/common/ics307_clk.h                      |  14 -
> board/nxp/common/ngpixis.c                         | 247 --------
> board/nxp/common/ngpixis.h                         |  60 --
> board/nxp/common/sdhc_boot.c                       |   2 +-
> board/nxp/lx2160a/eth_lx2160aqds.c                 |   4 +-
> board/nxp/lx2160a/nbxv3/eth_nbxv3.c                |   3 +
> board/nxp/lx2160a/nbxv3/vid_handoff.c              |  77 +--
> board/nxp/lx2160a/serdes_split.c                   | 532
> ++++++++++++++---
> board/nxp/lx2160a/serdes_split.h                   |  16 +-
> board/nxp/mpc837xerdb/Kconfig                      |  15 -
> board/nxp/mpc837xerdb/MAINTAINERS                  |   6 -
> board/nxp/mpc837xerdb/Makefile                     |   6 -
> board/nxp/mpc837xerdb/README                       |  97 ---
> board/nxp/mpc837xerdb/mpc837xerdb.c                | 242 --------
> board/nxp/mpc8548cds/Kconfig                       |  24 -
> board/nxp/mpc8548cds/MAINTAINERS                   |   8 -
> board/nxp/mpc8548cds/Makefile                      |  10 -
> board/nxp/mpc8548cds/ddr.c                         |  51 --
> board/nxp/mpc8548cds/law.c                         |  18 -
> board/nxp/mpc8548cds/mpc8548cds.c                  | 170 ------
> board/nxp/mpc8548cds/tlb.c                         |  87 ---
> board/nxp/p1_p2_rdb_pc/Kconfig                     |   3 +-
> board/nxp/p1_p2_rdb_pc/MAINTAINERS                 |   8 -
> board/nxp/p1_p2_rdb_pc/README                      |   7 +-
> board/nxp/p1_p2_rdb_pc/ddr.c                       |  68 ---
> board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c              |   2 -
> board/nxp/t104xrdb/Kconfig                         |  12 -
> board/nxp/t104xrdb/MAINTAINERS                     |  13 -
> board/nxp/t104xrdb/Makefile                        |  13 -
> board/nxp/t104xrdb/README                          | 386 ------------
> board/nxp/t104xrdb/cpld.c                          | 116 ----
> board/nxp/t104xrdb/cpld.h                          |  45 --
> board/nxp/t104xrdb/ddr.c                           | 148 -----
> board/nxp/t104xrdb/ddr.h                           |  56 --
> board/nxp/t104xrdb/law.c                           |  31 -
> board/nxp/t104xrdb/spl.c                           | 131 ----
> board/nxp/t104xrdb/t1040_nand_rcw.cfg              |   7 -
> board/nxp/t104xrdb/t1040_sd_rcw.cfg                |   7 -
> board/nxp/t104xrdb/t1040_spi_rcw.cfg               |   7 -
> board/nxp/t104xrdb/t1040d4_nand_rcw.cfg            |   7 -
> board/nxp/t104xrdb/t1040d4_sd_rcw.cfg              |   7 -
> board/nxp/t104xrdb/t1040d4_spi_rcw.cfg             |   7 -
> board/nxp/t104xrdb/t1042_nand_rcw.cfg              |   7 -
> board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg           |   7 -
> board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg             |   7 -
> board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg            |   7 -
> board/nxp/t104xrdb/t1042_sd_rcw.cfg                |   7 -
> board/nxp/t104xrdb/t1042_spi_rcw.cfg               |   7 -
> board/nxp/t104xrdb/t1042d4_nand_rcw.cfg            |   7 -
> board/nxp/t104xrdb/t1042d4_sd_rcw.cfg              |   7 -
> board/nxp/t104xrdb/t1042d4_spi_rcw.cfg             |   7 -
> board/nxp/t104xrdb/t104x_pbi.cfg                   |  36 --
> board/nxp/t104xrdb/t104x_pbi_sb.cfg                |  38 --
> board/nxp/t104xrdb/t104xrdb.c                      | 159 -----
> board/nxp/t104xrdb/t104xrdb.h                      |  11 -
> board/nxp/t104xrdb/tlb.c                           | 132 ----
> boot/Kconfig                                       |   4 +-
> common/board_r.c                                   |   2 +-
> configs/MPC837XERDB_defconfig                      | 193 ------
> configs/MPC8548CDS_36BIT_defconfig                 | 108 ----
> configs/MPC8548CDS_defconfig                       | 106 ----
> configs/MPC8548CDS_legacy_defconfig                | 106 ----
> configs/P2020RDB-PC_36BIT_NAND_defconfig           | 164 -----
> configs/P2020RDB-PC_36BIT_SDCARD_defconfig         | 145 -----
> configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig       | 147 -----
> configs/P2020RDB-PC_36BIT_defconfig                | 125 ----
> configs/P2020RDB-PC_NAND_defconfig                 | 162 -----
> configs/P2020RDB-PC_SDCARD_defconfig               | 142 -----
> configs/P2020RDB-PC_SPIFLASH_defconfig             | 145 -----
> configs/P2020RDB-PC_defconfig                      | 123 ----
> configs/T1042D4RDB_NAND_defconfig                  | 144 -----
> configs/T1042D4RDB_SDCARD_defconfig                | 138 -----
> configs/T1042D4RDB_SPIFLASH_defconfig              | 141 -----
> configs/T1042D4RDB_defconfig                       | 114 ----
> doc/README.fsl-hwconfig                            |  70 +++
> doc/README.mpc83xxads                              |  97 ---
> doc/README.mpc85xx-sd-spi-boot                     |   8 -
> doc/README.mpc85xxcds                              | 225 -------
> doc/README.pblimage                                |   6 +-
> doc/README.sata                                    |  68 ---
> doc/README.srio-pcie-boot-corenet                  | 118 ----
> doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt |   7 +-
> doc/device-tree-bindings/cpu/fsl,mpc83xx.txt       |  13 +-
> .../gpio/fsl,mpc83xx-spisel-boot.txt               |   4 +-
> drivers/clk/mpc83xx_clk.c                          |  19 +-
> drivers/clk/mpc83xx_clk.h                          |  30 +-
> drivers/cpu/mpc83xx_cpu.c                          |  62 +-
> drivers/cpu/mpc83xx_cpu.h                          |  44 --
> drivers/crypto/fsl/jr.c                            |  14 +-
> drivers/ddr/fsl/Kconfig                            |   8 +-
> drivers/ddr/fsl/ctrl_regs.c                        |   1 -
> drivers/dma/fsl_dma.c                              |   4 -
> drivers/firmware/scmi/base.c                       |   5 +
> drivers/gpio/mpc83xx_spisel_boot.c                 |   1 -
> drivers/gpio/mpc8xxx_gpio.c                        |   1 -
> drivers/mmc/Kconfig                                |   3 +-
> drivers/net/Kconfig                                |   4 -
> drivers/net/fm/Makefile                            |   6 +-
> drivers/net/fm/fm.h                                |   4 -
> drivers/net/fm/p1023.c                             |  72 ---
> drivers/net/fm/p4080.c                             |  98 ---
> drivers/net/fm/p5040.c                             | 106 ----
> drivers/pci/Kconfig                                |   2 +-
> drivers/pci/pci_auto.c                             |  14 -
> drivers/pci/pcie_fsl.c                             |  23 -
> drivers/power/regulator/pmbus_helper.c             |  64 +-
> drivers/qe/Kconfig                                 |   3 +-
> drivers/qe/qe.c                                    |   1 -
> drivers/ram/mpc83xx_sdram.c                        |  14 +-
> drivers/spi/fsl_espi.c                             |   7 +-
> drivers/usb/common/fsl-errata.c                    |  15 -
> drivers/usb/host/Kconfig                           |   2 +-
> env/Kconfig                                        |   3 +-
> include/asm-generic/u-boot.h                       |   2 +-
> include/configs/MPC837XERDB.h                      | 218 -------
> include/configs/MPC8548CDS.h                       | 312 ----------
> include/configs/T104xRDB.h                         | 397 ------------
> include/configs/p1_p2_rdb_pc.h                     |  21 -
> include/dt-bindings/clk/mpc83xx-clk.h              |   1 -
> include/fsl_immap.h                                |   2 +-
> include/fsl_sec.h                                  |   3 -
> include/mpc83xx.h                                  | 319 +---------
> include/pci_ids.h                                  |   4 -
> include/pmbus.h                                    |  14 +
> include/serial.h                                   |   1 -
> test/dm/pmbus.c                                    |  41 ++
> 217 files changed, 860 insertions(+), 13052 deletions(-)
> delete mode 100644 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/c29x_serdes.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/p1023_serdes.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_ids.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_serdes.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_ids.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_serdes.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_ids.c
> delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_serdes.c
> delete mode 100644 arch/powerpc/dts/mpc8379erdb.dts
> delete mode 100644 arch/powerpc/dts/mpc8548-post.dtsi
> delete mode 100644 arch/powerpc/dts/mpc8548.dtsi
> delete mode 100644 arch/powerpc/dts/mpc8548cds.dts
> delete mode 100644 arch/powerpc/dts/mpc8548cds_36b.dts
> delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dts
> delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dtsi
> delete mode 100644 arch/powerpc/dts/p2020rdb-pc_36b.dts
> delete mode 100644 arch/powerpc/dts/p3041.dtsi
> delete mode 100644 arch/powerpc/dts/p3041ds.dts
> delete mode 100644 arch/powerpc/dts/p3041si-post.dtsi
> delete mode 100644 arch/powerpc/dts/p4080.dtsi
> delete mode 100644 arch/powerpc/dts/p4080ds.dts
> delete mode 100644 arch/powerpc/dts/p4080si-post.dtsi
> delete mode 100644 arch/powerpc/dts/p5040.dtsi
> delete mode 100644 arch/powerpc/dts/p5040ds.dts
> delete mode 100644 arch/powerpc/dts/p5040si-post.dtsi
> delete mode 100644 arch/powerpc/dts/t1042d4rdb-u-boot.dtsi
> delete mode 100644 arch/powerpc/dts/t1042d4rdb.dts
> delete mode 100644 arch/powerpc/dts/t104x.dtsi
> delete mode 100644 arch/powerpc/include/asm/mpc8349_pci.h
> delete mode 100644 board/nxp/common/cds_pci_ft.c
> delete mode 100644 board/nxp/common/cds_via.c
> delete mode 100644 board/nxp/common/ics307_clk.c
> delete mode 100644 board/nxp/common/ics307_clk.h
> delete mode 100644 board/nxp/common/ngpixis.c
> delete mode 100644 board/nxp/common/ngpixis.h
> delete mode 100644 board/nxp/mpc837xerdb/Kconfig
> delete mode 100644 board/nxp/mpc837xerdb/MAINTAINERS
> delete mode 100644 board/nxp/mpc837xerdb/Makefile
> delete mode 100644 board/nxp/mpc837xerdb/README
> delete mode 100644 board/nxp/mpc837xerdb/mpc837xerdb.c
> delete mode 100644 board/nxp/mpc8548cds/Kconfig
> delete mode 100644 board/nxp/mpc8548cds/MAINTAINERS
> delete mode 100644 board/nxp/mpc8548cds/Makefile
> delete mode 100644 board/nxp/mpc8548cds/ddr.c
> delete mode 100644 board/nxp/mpc8548cds/law.c
> delete mode 100644 board/nxp/mpc8548cds/mpc8548cds.c
> delete mode 100644 board/nxp/mpc8548cds/tlb.c
> delete mode 100644 board/nxp/t104xrdb/Kconfig
> delete mode 100644 board/nxp/t104xrdb/MAINTAINERS
> delete mode 100644 board/nxp/t104xrdb/Makefile
> delete mode 100644 board/nxp/t104xrdb/README
> delete mode 100644 board/nxp/t104xrdb/cpld.c
> delete mode 100644 board/nxp/t104xrdb/cpld.h
> delete mode 100644 board/nxp/t104xrdb/ddr.c
> delete mode 100644 board/nxp/t104xrdb/ddr.h
> delete mode 100644 board/nxp/t104xrdb/law.c
> delete mode 100644 board/nxp/t104xrdb/spl.c
> delete mode 100644 board/nxp/t104xrdb/t1040_nand_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1040_sd_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1040_spi_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042_nand_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042_sd_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042_spi_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
> delete mode 100644 board/nxp/t104xrdb/t104x_pbi.cfg
> delete mode 100644 board/nxp/t104xrdb/t104x_pbi_sb.cfg
> delete mode 100644 board/nxp/t104xrdb/t104xrdb.c
> delete mode 100644 board/nxp/t104xrdb/t104xrdb.h
> delete mode 100644 board/nxp/t104xrdb/tlb.c
> delete mode 100644 configs/MPC837XERDB_defconfig
> delete mode 100644 configs/MPC8548CDS_36BIT_defconfig
> delete mode 100644 configs/MPC8548CDS_defconfig
> delete mode 100644 configs/MPC8548CDS_legacy_defconfig
> delete mode 100644 configs/P2020RDB-PC_36BIT_NAND_defconfig
> delete mode 100644 configs/P2020RDB-PC_36BIT_SDCARD_defconfig
> delete mode 100644 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
> delete mode 100644 configs/P2020RDB-PC_36BIT_defconfig
> delete mode 100644 configs/P2020RDB-PC_NAND_defconfig
> delete mode 100644 configs/P2020RDB-PC_SDCARD_defconfig
> delete mode 100644 configs/P2020RDB-PC_SPIFLASH_defconfig
> delete mode 100644 configs/P2020RDB-PC_defconfig
> delete mode 100644 configs/T1042D4RDB_NAND_defconfig
> delete mode 100644 configs/T1042D4RDB_SDCARD_defconfig
> delete mode 100644 configs/T1042D4RDB_SPIFLASH_defconfig
> delete mode 100644 configs/T1042D4RDB_defconfig
> delete mode 100644 doc/README.mpc83xxads
> delete mode 100644 doc/README.mpc85xxcds
> delete mode 100644 doc/README.sata
> delete mode 100644 doc/README.srio-pcie-boot-corenet
> delete mode 100644 drivers/net/fm/p1023.c
> delete mode 100644 drivers/net/fm/p4080.c
> delete mode 100644 drivers/net/fm/p5040.c
> delete mode 100644 include/configs/MPC837XERDB.h
> delete mode 100644 include/configs/MPC8548CDS.h
> delete mode 100644 include/configs/T104xRDB.h
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
