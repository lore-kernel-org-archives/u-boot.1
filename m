Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E9CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 19:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868B584928;
	Wed, 10 Jun 2026 21:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EXIq73qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E88E80087; Wed, 10 Jun 2026 21:59:36 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD31848A1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-48611ccd5aeso4280466b6e.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781121573; x=1781726373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zstZ7TM1vuPgDfqx85ONC5hd///SRjU6kBlbr1BtxxQ=;
 b=EXIq73qn24shOVoJItDgj+e1Aj/iYqLovgA9Nh/ymsj5tns7M1c5TypyUoZW+/hb+0
 sjoFBt6CxIRQMCjkT8M3CdvvbbN2pKIRMTLs4ETcriUdlWCPuqtxsBqga5jaYCQujwhL
 srhTtkjPLeIOmolG535nsrkWOalTrOr3JwDWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781121573; x=1781726373;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zstZ7TM1vuPgDfqx85ONC5hd///SRjU6kBlbr1BtxxQ=;
 b=ob4UgBIdwYRsL/L9X9wK8TauOavq89b1qW1djIFOipSpAt6GFDUyqOO+B0bAVv3BPU
 6cTAxVgOd5mMRxTBOJ4rqoCX09Vnr7MSDhInkZexrhf8p/31HjIx7rYpk3rJUZMT4d/b
 oCx6L2vgQj7Ud3M7GeyVAGV/7RR4uOIbxphHp4/E+FCBNDatvH6/joopyu2glqTPSsmy
 ahBt43bfaBTRCRxA8Q0rvOx94P6ickYpp4siFTw4TU0TJB37sRmCp/znlgd8bQ/RNssW
 xAPsIXkeqqHXDOawQ2hcF9DiGoTBF5IY7c+knyra8nJhbs7uTI42jAwwvKle9JqWyIr4
 jygg==
X-Gm-Message-State: AOJu0YyZzJnUmaPPv6/0co4XR6HBYhhqVCDfv7qLdyhnBagqb5mteqBe
 3gEkcJ/jXJMlp+Ucj54NrK8YnYV0YtJR8Cz3eM/tg9BjKrPThvwq7UkubKi5rXYX5jBgstDkn9O
 Qdn+wQR4=
X-Gm-Gg: Acq92OEQ8X+rr63PTpVg+fxH4EVGRzAmdWna+SGUdXe7+63So3JudoynHxEoPG+1LAB
 +2tK0kcOIUbdTeKzSAIkKk4wmVMMbyH5J/UHnvgTYCOqGgjefwgxfb0usyXA67jp3u08VBJCNl9
 XCq/kzgJgdQzP2wD25rRHvBdOlB0S8UPX7jvz3PwjA3NAxSRbv1sQ4WVqtcRO2uWABux98kAXMX
 ix9XK2JjnNiWkvENOq0jQnSDKIDHZx6eZVvGsev6b5qnitf2235Dge//syUBHc+XlEvWmb0Fmdc
 zRq36stIPki6yo1BzrdHmv0qJkusMdyy+Vp/2S8GLXRc0qaAxti7RkwF9p/+czcyjxB1lCO0ooK
 srR37xV+Qb96QBxCaa/johkR2MGywHmEvRWYH70gLylKjQPdL5Tjp76lIu2S4B6yRb6EjPaTcgZ
 PdursdJJNpA0ztc4UugMjM2pYANewbZtNcLqzCgj9nTNqiBlwRxJJzs2jMntVQI2Ox6jmfPgQOM
 GC1sBiavruJV0SkidQSr/pgSCBp0BvfVi/qs0Fae6G27Ku29/bR43L6dT5v
X-Received: by 2002:a05:6808:1521:b0:482:a7bf:dbf with SMTP id
 5614622812f47-48716464045mr457517b6e.15.1781121572942; 
 Wed, 10 Jun 2026 12:59:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7263efcsm22911144fac.0.2026.06.10.12.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:59:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260610122155.2674504-1-stefan.roese@mailbox.org>
References: <20260610122155.2674504-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-marvell/next
Message-Id: <178112157229.295957.18287485310385855613.b4-ty@konsulko.com>
Date: Wed, 10 Jun 2026 13:59:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 10 Jun 2026 14:21:55 +0200, Stefan Roese wrote:

> please pull the following marvell changes for the next branch:
> 
> - arm: kirkwood: Remove unnecessary watchdog GPIO for ZyXEL NSA325 board (Tony)
> - net: mvpp2: fix NULL pointer dereference in mvpp2_phy_connect (Vincent)
> - mtd: nand: pxa3xx: Pass valid dev to dev_err() (Chris)
> - arm: mvebu: db-xc3-24g4xg: Remove marvell, nand-keep-config (Chris)
> - arm: mvebu: Add Allied Telesis x220 (Chris)
> - board: Synology: legacy.c: Include asm/io.h (Phil)
> - board: Synology: common: Fix typo in Makefile (Phil)
> - serial: serial_octeon_bootcmd.c: use correct Kconfig symbol (Heinrich)
> - arm: mvebu: Drop unnecessary BOARD_EARLY_INIT_F usage (Tom)
> - pinctrl: armada-38x: Staticize and constify driver ops (Marek)
> - arm: mach-mvebu: armada8k: cpuinfo and SAR (Vincent)
> - board: freebox: add Nodebox 10G board support (Vincent)
> - board: freebox: nbx10g: add emmcboot for dual-bank eMMC boot (Vincent)
> - board: freebox: nbx10g: add device serial and MAC address initialization (Vincent)
> - arm: dts: armada-8040-nbx: add U-Boot dtsi for conditional OP-TEE (Vincent)
> - timer: orion: Use dev_remap_addr_index() (Peng)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


