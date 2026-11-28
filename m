Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13C606A31F
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HOsKO/Hx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=TJgcmEII
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD434409E4;
	Sat, 28 Nov 2026 09:54:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1bMrN7raAIuD; Sat, 28 Nov 2026 09:54:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD3BE409CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795859649;
	b=MAoXuBD1haY5mgYhjFGYcpG8tOMjEx2kP83CUH+Z0Pgexw1ymHSQPrChPA5E58noTNKv
	 mkGvuckeb1uIJiq+o5cPeIlnZPN42UhyaJ8B7hOknI28uW8tQPgC+WgErapQoPqc0xtbu
	 sjZWRYQv+gvROISb6jxQhPRlPxsxi3ubExwMjg/n3K+kdzt4g6DFin4gLqXdvn5CMY4pP
	 C5oVENH1ECag/bBMhZxJo4bir6+wWHfJyCLEE+HIOXJ4uK3SMNyHKoClIvO0gTtDcnRa5
	 zQZFfxSSXLxAY3oSXEQZMyoiRT+FOfxBQbMMxMqeMYZ8C7QQlgxpO2Vd9jz7mIbhpYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795859649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SZw5QyevldOFDyWOuv8nLm4+epfgLdnfA7fdYGdtZV4=;
	b=jvXR/rWp2IRVLiffHnZdoLeO1rLLhXFDL0d8AWFDpQz3ckA/A9oIKtvRRmNXTTA/WkXc
	 VEeFow6r6ouN2+Cy1R0QrlPfYpDAZ3BWDt+1jUAGBuu4hhtNnhsdYohaRS/1Znl7SMupR
	 IECjJbT0GDhKETQ5WaqdsLlfZFvwAnx4I33pnNMP415AujTxhitydVPcB4bK03tKNwSQj
	 XvRW3R6WaKacI7+oUcvQZYQZ/R+kPclcq7UvyyJUpMiV8qa7wti7rez1B3YSqCe/HFbva
	 0NFqxtgtE8O4psSsS3Liz04APRZ3aVi7X8dJVCAcfA8zszPkDJzGSX5x2sQS3z/3JTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=TJgcmEII;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795859649;
	bh=SZw5QyevldOFDyWOuv8nLm4+epfgLdnfA7fdYGdtZV4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HOsKO/HxRGtSa3cLcE9PePnMXbCMngXnPGfSFoNxWNpDlQqECYZzqH+qUuuDGYVNR
	 TIM0BVBSSINhQtDDRRDrya4Bypck5GkQEJ8Lgg7WrV3DNnx2uqn0EZETva+WUnZyff
	 V+frdJjz+n5hTAOSu+zRFUpc88oqKjndRVUvNMzblbx9GHYDLoDPaFKM6X/fMguKwW
	 m4h9gQr4tAyRsKnlxBw+WIGeGGqDzuVnkzsMA+cQ+xW9yuJNdkr0ozqz98jDOG/jQe
	 aNH7r41kZqD5ZeZKe5PAsvcEFvA84tSAVnRA4sPz11eMFEw6VJKkG/I6GO0Kyjs+NH
	 FaPl/U7n0EE8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD3BE409CF;
	Sat, 28 Nov 2026 09:54:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23E9A43
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 09:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 156AD409CF
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 09:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eCJWFS0XeJSa for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 09:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91A11409CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=TJgcmEII
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91A11409CB
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 09:54:04 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=TJgcmEII9sqxhp1Zt5NJ0kdgZYykibzKM6WSBN0I9S4oI+OwoUS134yMB3saUZn2RQs+RuLQ6D0DIr7W7ux/BaPJHYTTOPA1rS7uyrF6toTt7X2LE1TQPTgv3qsud0py5Xb/L12cOy0wEfMgS6YHyz0k7qdLjv1XMewuphNzM3M=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=SZw5QyevldOFDyWOuv8nLm4+epfgLdnfA7fdYGdtZV4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795859613761402.21356407194423; 
 Sat, 28 Nov 2026 01:53:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 17:53:24 +0800
Message-Id: <DN6R3KWX6RJQ.3LRDBRRIOFMO3@pigmoral.tech>
Cc: "Tom Rini" <trini@konsulko.com>, "Yixun Lan" <dlan@kernel.org>, "Tim
 Ouyang" <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>, "Huan
 Zhou" <pericycle.cc@gmail.com>, "Eric Chung" <eric.chung@riscstar.com>
Subject: Re: [PATCH 0/5] riscv: spacemit: k3: Add SPL LPDDR5 initialization
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "E Shattow" <e@freeshell.de>, "Junhui Liu" <junhui.liu@pigmoral.tech>,
 <u-boot@lists.u-boot-project.org>, "Yao Zi" <me@ziyao.cc>,
 <u-boot-spacemit@groups.io>
X-Mailer: aerc 0.22.0
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
 <c9981f92-c8b9-4fef-9944-61ca4de8c7f9@freeshell.de>
In-Reply-To: <c9981f92-c8b9-4fef-9944-61ca4de8c7f9@freeshell.de>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

On Fri Nov 27, 2026 at 12:46 PM CST, E Shattow wrote:
> Hi Junhui,
>
> On 11/5/26 08:40, Junhui Liu wrote:
>> Add initial SPL support for LPDDR5 initialization on the SpacemiT K3
>> SoC.
>>=20
>> The DDR driver follows the vendor initialization sequence, selects a
>> memory profile using the DDR part number read from the board's EEPROM,
>> and configures both DDR controllers and PHYs to perform LPDDR5 training.
>>=20
>> Loading the next boot stage is not implemented yet. SPL currently
>> returns BOOT_DEVICE_NONE and stops with "Unsupported Boot Device!"
>> after successful DRAM initialization. No LPDDR4X boards are currently
>> available for testing, so LPDDR4X support will be added in a separate
>> series in the future.
>>=20
>> Tested on 8 GiB and 16 GiB Pico-ITX boards and an 8 GiB COM260 board by
>> entering BootROM USB download mode and running:
>>=20
>> fastboot stage spl/u-boot-spl-mkimage.bin && fastboot continue
>>=20
>> ---
>> Junhui Liu (5):
>>       ram: spacemit: Add DDR driver for K3 SoC
>>       riscv: spacemit: k3: Add SPL initialization support
>>       riscv: dts: spacemit: k3: Add SPL device and image descriptions
>>       configs: spacemit: k3: Enable SPL support
>>       doc: spacemit: k3: Add SPL build instructions
>>=20
>>  arch/riscv/cpu/k3/Kconfig                      |    6 +-
>>  arch/riscv/cpu/k3/Makefile                     |    1 +
>>  arch/riscv/cpu/k3/spl.c                        |   52 +
>>  arch/riscv/dts/spacemit-k3-binman.dtsi         |   24 +
>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi         |   54 +
>>  arch/riscv/include/asm/arch-k3/csr.h           |   20 +
>>  arch/riscv/include/asm/arch-k3/spl.h           |   11 +
>>  board/spacemit/k3/Makefile                     |    5 +
>>  board/spacemit/k3/spl.c                        |  127 ++
>>  configs/spacemit_k3_defconfig                  |   22 +
>>  doc/board/spacemit/spacemit-pico-itx.rst       |   12 +-
>>  drivers/ram/Kconfig                            |    1 +
>>  drivers/ram/Makefile                           |    1 +
>>  drivers/ram/spacemit/Kconfig                   |    6 +
>>  drivers/ram/spacemit/Makefile                  |    3 +
>>  drivers/ram/spacemit/k3/Makefile               |    9 +
>>  drivers/ram/spacemit/k3/k3_ddr.c               |  134 ++
>>  drivers/ram/spacemit/k3/k3_ddr.h               |  169 +++
>>  drivers/ram/spacemit/k3/k3_ddr_ctrl.c          |   73 ++
>>  drivers/ram/spacemit/k3/k3_ddr_lpddr5.c        |  538 ++++++++
>>  drivers/ram/spacemit/k3/k3_ddr_lpddr5_tables.c | 1668 +++++++++++++++++=
+++++++
>>  drivers/ram/spacemit/k3/k3_ddr_phy.c           |  149 +++
>>  drivers/ram/spacemit/k3/k3_ddr_profile.c       |   54 +
>>  include/configs/spacemit-k3.h                  |    3 +
>>  include/soc/spacemit/k3-ddr.h                  |   13 +
>>  25 files changed, 3150 insertions(+), 5 deletions(-)
>> ---
>> base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
>> change-id: 20261104-k3-ddr-85685cac0f02
>>=20
>> Best regards,
>> -- =20
>> Junhui Liu <junhui.liu@pigmoral.tech>
>>=20
>
> Can we enable default YMODEM load of u-boot.itb in this series? I
> propose in your series:

That sounds good. I'll enable UART (YMODEM) loading of u-boot.itb as
the default in SPL in the next version, so we can test the full boot
flow with this series.

Best regards,
Junhui Liu

>
> 1. SPL with DDR init and boot U-Boot main app via UART YMODEM (this serie=
s)
>
> ... and then other series applied after this:
>
> 2. Add support in SPL to check for boot signal state. Replace
> unconditional YMODEM loading with depending on boot flag for BootROM
> UART mode, and keep default to YMODEM loading. Effectively no change in
> behavior and prepared for adding support of other boot methods.
>
> 3. Add SPI NOR boot support in SPL (Yixun)
>
> 4. Add SPL fastboot.
>
> 5. Add eMMC/SD boot (Yixun? I think mentioned this)
>
> -E

