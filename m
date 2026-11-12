Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D0606A89D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zssF1fQe;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IH+mNh4q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF35580C2D;
	Thu, 12 Nov 2026 18:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2uan0Y44yUJg; Thu, 12 Nov 2026 18:32:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82A4180DB8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794508347;
	b=paQRpp6sdBSWMKZrrWRfG4LqtUveTUPqWZAXfp+FBIUii053PvOZK3610opmrphkddE0
	 0JlPqE4McdrKrllo7d80McFvCKtiRsLlfUNMEtNcb8e5a62wKS3Vx15XgCHIRAPHIy3hF
	 xC5YnyjwJoHaU32DDCYihYG8pUDCpo9jqiIeDpxnbG2H83q2LgCjadiMsZRDIMkkNjUKt
	 wiZDfqARaWEgFuyHfk/qDaNwoltW0sItIrLCdXiyPltZuyW+3bXbJ06mCe8xfcNxmHCtZ
	 wgNys5bgSjP3TDx6XghQUyNEKHrxU5yw1OMNrvvBcRzzB1FwszH+qGalvZJpHeeGCHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794508347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bAcZBauUDH7A1xx9QLbMz4LiVwzbkp+rbOweDDF9mfY=;
	b=n0sqxDtFdnHh1QyVze78d7XiDdPdCfpCns+q7R4jGMuEwHqhyImd8+G1YndYuCI/yq9n
	 NS1Zkzvav0muFaVYqHukhKpJJqLGW1pVb4hkZcJZnnuUsEoJxpxxmJ/ZtLw4+BkPDKf5Y
	 YtFFOAxRcclvqjT1okku5PEi2clcGjHUw2QF6IeOPIlcuHEk/qGoKfSo+x3y7qqxlWHUg
	 0BLq+MkvEYcgdX9l+p87b7iB66/KyLEWQsFeOeTIeUB9JL0ObWOQboLR6nrVRXLLgtjmj
	 LIk4pO8iwUjjqG3YjsTrlTKW4cO2v7fz5+NhB5NwWPUpYjmPApCS5URL7sr7dsuhacw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IH+mNh4q;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794508347;
	bh=bAcZBauUDH7A1xx9QLbMz4LiVwzbkp+rbOweDDF9mfY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zssF1fQedVXGVL6jEIorb5kDjNUZJ4dxt9IiiQoNj/npy5bYzd9hmzVRuMkLNy6R9
	 SY2aLgOIM0ERZ3Uy7/eJdDidZCyECDRe0u6kfhy0fvXHDAeufex9AoeNkKPiYfALZC
	 sqboOCbxLEHTy+ed8npAOIdbXyKHuqoUWPZp5nnudiEPHghbMfBgcYXODdXnc/v2fL
	 ZrI7iBPaIMUayd7bNDtt58uNzdKzbfBbWgoWUYKxfVYPtYGEksB//ziuqxfheNq37u
	 skhxtFqn8OWEBAGigoo/GjhDmi/pKIdZ9V4De04xDfSsQqZcVjSlAff6+J/z7dQj0U
	 TWoLxh/EZyrNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82A4180DB8;
	Thu, 12 Nov 2026 18:32:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C302F46
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 17:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6179B81488
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 17:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQN5mYJaMTBz for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 17:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE2AB81213
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=oryjkov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=IH+mNh4q
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE2AB81213
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 17:43:27 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso472505e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794505405; x=1795110205;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bAcZBauUDH7A1xx9QLbMz4LiVwzbkp+rbOweDDF9mfY=;
 b=IH+mNh4q7fahD9c+X5lAyBnnrLm7kvNqAM+iEeAWFpK/6ORYk5/zuxZTIJ86zjQKw+
 Wriu2fcog+8rxHBP+qJghzUZoFsWkgIXlT/zkRgqq0yJMp5uPLpDeVeamCPWDOJAVNUn
 zZbFdGb/lBtIXKqSG1qGonxfE2OWuKFHZjwE1qRo1+BCFDm2J4bknYIuxl0CXO/jSvCm
 jLeAVXEnXrdJRBSbZUGULcpR5wpqY30Ca9+bPFHO8bY4JxsmX7GfLemf9KnfCjtx/KV2
 7THB2Iv4dKxgdRR8OVvWbk2SFoON2563LIumsch+6IUeWC6KcDEu+i9hcVFUhmPjKkgR
 VHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505405; x=1795110205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bAcZBauUDH7A1xx9QLbMz4LiVwzbkp+rbOweDDF9mfY=;
 b=1QLeOOceI5607IXwEfbjxQkGm12/BElJ/BZZf6Ln7triv/z3aCqCS5y1c/JJJQAjSd
 YKSvZV+7BMBh9BxHxbrp27mGMouB7Kgk+p2QAgyC9Xg6HUePh8ekYybDlSDiIhUBHEyN
 YvrPzrYzybBVMag2QGzSktNkMf/G1+9VSkQTOp0a72hh+LItSQiCHNz5ndLCimXNIuBT
 dvNawNzdS4IPaSlQzVVwTghnO2a1tTAjZiQB0wX8YXMX/nqTYDHUDHrMEefLt0sXwYXB
 /98mG8lIsgZiNQy22VdFoUQqFpWAX4RO0XZIpeL07jo4IAXmaM/rzt+xoWaLv8NlKXtn
 7N3g==
X-Gm-Message-State: APuU4Z+PRvw3tySf2Z/jwd16XMjERf/jqdWcEEzrZtUV/UYg2rMEuGik
 CWs+XD6i8V2ageeSu3JPKMkpmfEQQyWVgt+tslFTPiWiT/fZxr5E68ruoZeg6kF3
X-Gm-Gg: AYBFou3p38WJst7g216KI4SgNVGF8sZ0BEbVW2D9h73D35CJKAryTcBsrYdswQX4typ
 UzIHMbZ/ijirtfpTtjcDUHhcY/hLEFTHB3581BZW6EBYEM/ZlimWsL0Dh3wvisONdiDqM75Y/Tv
 +C6dyX3cm3MxIbpWeNGcOFwq7yXo3CNZH6xkoOgayAR+b8S38FXHj3vZU877SgMNu0DUC4GVjwF
 kbm/BYSUJxzIrxJ3go6swizT/WlR+RsCGdlO6a5vaG914tJmLlfKR4APfPswqBVPsRpU5pRzPvf
 oEnX3Wh2BX0IXm9nCMJyhDkhomoiC5o6/NTRFhq11UE+69dNE7I0YKWYWNH2zpb1rrVdMA5Wh82
 o0iBgBVpXMZEMbywHNJ4IPfzNbcmmThKh8pcCmkNDVg4DFxAumiIrnjeIQ0PiAtP3MDmBO4vhdc
 vmykFzAwIbWU68Io0yQk8++1dSLkq3hH8ji6LdbkWh81dHk4Ln0SR92aBvkxFsYUGaOBPzkmrtb
 MwG9QJtwetVB9KSzkob7x+aFWlh+xzxjlcfoGzqvXDhU1He5zsfPI7cE71y75lGPD036HKGN6Ge
 jKWiI4cQymWsN7LkbNKpruyedHcDFEXh4dKhEfiuywoK8qonhRwa4HdhFjQK8aZhd1GQovxtxr6
 jg4in3kq03B4eciFWmA66uL9IhfFDdHSkdKQEZjdOUhAxo/B0AO9UPpZHJaJ5Lad08aMRZb/UAX
 29nogSrbPaj58J
X-Received: by 2002:a05:600c:a311:b0:4ba:2bfc:c8ab with SMTP id
 5b1f17b1804b1-4ba2bfcc988mr87904795e9.15.1794505404912; 
 Thu, 12 Nov 2026 09:43:24 -0800 (PST)
Received: from dsk.tail9b1f8.ts.net ([109.202.219.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28d0b2sm68403125e9.7.2026.11.12.09.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:43:24 -0800 (PST)
From: Oleg Ryjkov <oryjkov@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Oleg Ryjkov <oryjkov@gmail.com>
Subject: [PATCH] rockchip: Enable MMU and caches before relocation
Date: Thu, 12 Nov 2026 18:42:53 +0100
Message-ID: <20261112174253.7457-1-oryjkov@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 18:32:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Turn on the MMU and both caches at the start of U-Boot proper instead of
after relocation. This saves 1.1 to 1.6 s per boot on RK3566, RK3399 and
RK3588 boards:

                                  board_init_f to       dm_f
                                  board_init_r
  RK3588  ROCK 5B+, SPI flash     1.698 -> 0.085 s   0.999 -> 0.032 s
  RK3588  ROCK 5B+, SD card       1.711 -> 0.085 s   1.005 -> 0.032 s
  RK3399  ROCK Pi 4A, SD card     1.358 -> 0.081 s   0.941 -> 0.024 s
  RK3566  Radxa ZERO 3W, SD card  1.131 -> 0.056 s   0.688 -> 0.020 s

These are means of three boots per column from U-Boot's bootstage
report, with the option off and on in alternating boots. The kernel
starts 1.61, 1.63, 1.25 and 1.08 s earlier.

U-Boot proper is entered with the MMU and both caches off: the SPL turns
them on for itself and off again before it hands over to TF-A. They come
back only in initr_caches() after relocation, so everything in
board_init_f() runs uncached, above all the driver model scanning the
device tree and binding devices (dm_f) and the serial console probe with
its pinctrl and clock lookups. Turning on only the instruction cache
changes nothing; it is the data accesses.

mach_cpu_init() now turns both caches on, with page tables taken from
the pre-relocation malloc area. SYS_MALLOC_F_LEN grows by about their
size (PGTABLE_SIZE is 120 KiB on RK3588, 32 to 56 KiB on the others),
and the tables are taken only if at least 32 KiB of the area remain for
driver model and the rest of board_init_f(), which use about 10 KiB on
these boards. Without that room the caches stay off as before, without
a message. After relocation enable_caches() turns the caches off, which
cleans them, and dcache_enable() builds the final tables where
arch_reserve_mmu() has put them, as i.MX8M does since commit
ac9153c74f30 ("ARM: imx: Enable MMU and dcache very early on i.MX8M").

The mechanism is not specific to Rockchip: most TF-A platforms enter
U-Boot proper with the caches off. What is per platform is the size of
the early malloc area, and so the room for the tables. This starts with
the Rockchip SoCs it could be tested on; STM32MP and i.MX do the same in
their own code, and a generic ARMv8 option could replace these copies
later.

Risks:
- U-Boot entered with the MMU already on now moves to its own page
  tables in enable_caches(); before, it kept the ones it was handed.
- From arch_reserve_mmu() until enable_caches(), gd->arch.tlb_addr names
  tables that do not exist yet, so nothing may change MMU attributes in
  that window. Nothing on Rockchip does today.
- It is on by default only for the SoC families it was tested on. PX30,
  RK3308, RK3328, RK3528 and RK3576 build with it but have not run it;
  RK3368 boards have too small an early malloc area and keep the caches
  off.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oleg Ryjkov <oryjkov@gmail.com>
---

Notes:
    How it was tested, on master (3cb2cbbc75a):
    
    - Boards: Radxa ROCK 5B+ (RK3588, 8 GiB; from SPI flash and from SD
      card), Radxa ROCK Pi 4A (RK3399, 1 GiB, SD card, mainline TPL) and
      Radxa ZERO 3W (RK3566, 2 GiB, SD card), mainline TF-A, Armbian userland.
    - Measurement: CONFIG_BOOTSTAGE, BOOTSTAGE_REPORT and BOOTSTAGE_FDT;
      three boots per variant, alternating off and on; each column of the
      table is the mean, the boots of a column agree within 0.1 ms
      (board_init_f to board_init_r) and 40 ms (kernel start).
    - Early malloc use, before / after mach_cpu_init() / end of
      board_init_f: RK3588 0x648 / 0x1f000 / 0x21988 of 0x30000,
      RK3399 0x648 / 0x9000 / 0xb520 of 0x20000, RK3566 0x648 / 0xb000 /
      0xd4e8 of 0x20000. With the option off the same boards use 0x2988,
      0x2520 and 0x24e8 bytes after the first 0x648.
    - Room check: the tables are taken only if, placed the way memalign()
      will place them, at least 32 KiB of the early malloc area remain. That
      leaves 36 KiB to spare on RK3588 (0x30000 area, 120 KiB tables) and on
      RK3576 (0x20000, 56 KiB), more on the others.
    - Fallback: the option on with SYS_MALLOC_F_LEN 0x10000 boots like the
      option off, without a message, on all three.
    - Entry with the MMU on: the image started with "go" from a running
      U-Boot with the caches on (after dcache/icache flush) boots Linux on
      all three, with the option on and off.
    - 20 boots in a row of the option on per board: all came back, U-Boot
      times within 0.1 ms, no new kernel log errors.
    - All 132 ARM64 Rockchip defconfigs configure; one per SoC family
      (evb-px30, rock-pi-s-rk3308, rock64-rk3328, geekbox,
      rock-pi-4-rk3399, generic-rk3528, rock-3a-rk3568,
      radxa-zero-3-rk3566, generic-rk3576, rock5b-rk3588) builds with
      -Werror, the untested ones also with the option turned on.
    
    Tested-by tags for PX30, RK3308, RK3328, RK3528 or RK3576 boards would
    let the default cover them too.
    
    Others have hit this phase:
    - "Rockchip RK3399 SOC is very slow" (December 2025): the RK3399 log
      there shows 1.4 s between the BL31 and U-Boot banners, which is this
      phase.
      https://lore.kernel.org/u-boot/0d8cb0a2-5581-4885-b7bc-34402a4ec3c8@arturia.com/
    - Simon Glass and Casey Connolly on the slow uncached pre-relocation FDT
      scan, in the "clk: port full Linux Common Clock Framework" RFC thread
      (March 2026).
      https://lore.kernel.org/u-boot/20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org/
    - "rockchip: Skip serial pinctrl at pre-reloc phase" (August 2024)
      addressed one part of it, about 150 ms on a ROCK 5B; with the caches
      on the console probe takes about 12 ms.
      https://lore.kernel.org/u-boot/20240805084350.3895788-1-jonas@kwiboo.se/

 arch/arm/mach-rockchip/Kconfig | 20 +++++++++
 arch/arm/mach-rockchip/board.c | 79 ++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e..d133c88894f 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -628,6 +628,24 @@ config ROCKCHIP_COMMON_BOARD
 	  in charge of common process of board_init() and board_late_init() for
 	  U-Boot proper.
 
+config ROCKCHIP_EARLY_CACHES
+	bool "Enable the MMU and caches before relocation"
+	depends on ARM64 && ROCKCHIP_COMMON_BOARD && SYS_MALLOC_F
+	depends on !SYS_DCACHE_OFF && !SYS_ICACHE_OFF
+	default y if ROCKCHIP_RK3399 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
+	help
+	  Turn on the MMU and both caches at the start of U-Boot proper,
+	  instead of after relocation. Everything before relocation, the
+	  driver model setup and the console probe among it, then runs with
+	  the data cache on. The page tables for this time come from the
+	  pre-relocation malloc area, which grows by about their size
+	  (128 KiB on RK3588). Without that room, for example with a
+	  smaller SYS_MALLOC_F_LEN set by the board, the caches stay off
+	  until relocation, without a message.
+
+	  On by default for RK3399, RK356x and RK3588, where it was tested;
+	  nothing in it is specific to those SoCs.
+
 config SPL_ROCKCHIP_COMMON_BOARD
 	bool "Rockchip SPL common board file"
 	depends on SPL
@@ -806,6 +824,8 @@ config CUSTOM_SYS_INIT_SP_ADDR
 	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
 
 config SYS_MALLOC_F_LEN
+	default 0x30000 if ROCKCHIP_EARLY_CACHES && ROCKCHIP_RK3588
+	default 0x20000 if ROCKCHIP_EARLY_CACHES
 	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
 	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
 	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 98c890d3bdc..367d0315386 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -19,6 +19,7 @@
 #include <hash.h>
 #include <init.h>
 #include <log.h>
+#include <malloc.h>
 #include <mmc.h>
 #include <dm/uclass-internal.h>
 #include <misc.h>
@@ -29,11 +30,16 @@
 #include <u-boot/crc.h>
 #include <u-boot/sha256.h>
 #include <asm/cache.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/boot_mode.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/periph.h>
 #include <power/regulator.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION) && \
 	IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)
@@ -215,6 +221,79 @@ void enable_caches(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_ROCKCHIP_EARLY_CACHES)
+/*
+ * U-Boot proper is entered with the MMU and caches off (SPL turns them off
+ * before it hands over to TF-A) and turns them on only after relocation,
+ * in initr_caches(). Until then every access to the device tree goes to
+ * uncached DRAM, which makes binding the devices and probing the console
+ * very slow. Turn the caches on here instead, with page tables from the
+ * pre-relocation malloc area; enable_caches() moves to the tables reserved
+ * by arch_reserve_mmu() after relocation.
+ */
+int mach_cpu_init(void)
+{
+	ulong size, start, limit;
+	void *tables;
+
+	if (mmu_status())
+		return 0;
+
+	size = PGTABLE_SIZE;
+	start = ALIGN(gd->malloc_base + gd->malloc_ptr, SZ_4K);
+	limit = gd->malloc_base + gd->malloc_limit;
+
+	/*
+	 * SYS_MALLOC_F_LEN is raised by about the size of the tables when
+	 * this option is on. Take them only if at least 32 KiB of the area
+	 * remain for driver model and the rest of board_init_f(), which use
+	 * about 10 KiB on RK3399, RK356x and RK3588. Check first, the way
+	 * memalign() will place them, so that a board without the room
+	 * skips this without an error.
+	 */
+	if (start + size + SZ_32K > limit) {
+		log_debug("No room for early page tables: %lx bytes free\n",
+			  limit - (gd->malloc_base + gd->malloc_ptr));
+		return 0;
+	}
+
+	tables = memalign(SZ_4K, size);
+	if (!tables)
+		return 0;
+
+	gd->arch.tlb_addr = (ulong)tables;
+	gd->arch.tlb_size = size;
+	icache_enable();
+	dcache_enable();
+
+	return 0;
+}
+
+void enable_caches(void)
+{
+	/*
+	 * The early page tables live in the pre-relocation malloc area,
+	 * which is left behind after relocation. Turn the caches off, which
+	 * cleans the data cache, and have dcache_enable() build the tables
+	 * at the place arch_reserve_mmu() has set in gd->arch.tlb_addr.
+	 *
+	 * From arch_reserve_mmu() until here, gd->arch.tlb_addr names the
+	 * final tables, which do not exist yet, while the MMU still runs on
+	 * the early ones that tlb_fillptr and tlb_emerg point into. Nothing
+	 * may change MMU attributes in that window
+	 * (mmu_set_region_dcache_behaviour() and the like).
+	 *
+	 * U-Boot entered with the MMU already on keeps running on the tables
+	 * it was handed until here; this moves it to its own as well.
+	 */
+	dcache_disable();
+	gd->arch.tlb_fillptr = 0;
+
+	icache_enable();
+	dcache_enable();
+}
+#endif
+
 #if IS_ENABLED(CONFIG_USB_GADGET)
 #include <usb.h>
 
-- 
2.54.0

