Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51C3C624D3
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 13:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60D07605ED;
	Sat,  5 Sep 2026 13:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7iFbgugJNcIk; Sat,  5 Sep 2026 13:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 718466060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788613327;
	b=RZcmpUbbtwkSbyDChw/M9JsvKcJ8RWE2alNBdscTygIhU2BJBBdoiIwZS+PWu6M3tDeC
	 rQh5JXa1CLes8qGvWTs2Y31cBZEmPnJQASH262dWul6VRLMlWtMyq9HnqMdANTop80SLI
	 RXTz1Fblp+mHWg4qOuqEvoVvh6rQITIdBZBFf+11IL/ZIlzsl4sGgcUBjDgmldp/NiE4p
	 wI3gL/KI4qtrIoz1zHHZrfRjysOl699/cvadEmIRjKJe0vkw7l2gsNktTwlHk2Vxwrc4V
	 qvx7+zu3qd3BXsgPwi9E1jjFYIKFbd17WIZgiwF/3w90i0Z1KfaycbJvHWr4MpMSphQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788613327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nIYUs85K8F3zzyHc5xxWwG1eCA9VuPJeQf7biBhAnDg=;
	b=pOtS8tdJYWv8XTnpXGzebf2X6eG6eusaTTRMtQa0RFpbONXXRaL7+E9Mz1tbGxSRoksd
	 BtXSwVlmf616v/UdqQmz4hmSKUudRXfV1jb8ztWmiHK1AT81RolnO3wWvQXaDM5zX6P1f
	 jyaqwXIQms44pa75hSEkxyAVotrPmVjgiG2rzrJyCL5I3UGPTB+11YMw6OzdNYFqfbvnl
	 xNoUVc0H5bvGFOXalD1TN5caiJgnkCQDylIMX3mZbadnhnnhymOELVThWSKcxO3YbOdrJ
	 JYn0Q3BVZgGDZF9QTM7ZFQE0sEhw4kAw2qwA2sbTDDykJgJuEuIdEF04HJUyMaMRQaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788613327;
	bh=nIYUs85K8F3zzyHc5xxWwG1eCA9VuPJeQf7biBhAnDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kZJXX23SZ7GsLvgx4FbpUMIIVLkdQCA8R95lxWkCDZyxdjpWMcmMnEDoWHkZ1Les5
	 70XHcZSWuvojoTH9ee+uebNykR/BXLb5bSq6tmxsXgxUSd7yXWkquOtP3xI3S3Ztvk
	 GSs31JsfFLf1EgDGk6q/0hRB6a/fWSJfNxbURtsKmZTe2c9pIrk0PtwUpuswrUDaxb
	 Auq53CSbf3yrPXQ/up/zsc6nhIQ1GZgF7z37Db6bqa+VIvF3xYVBHdpqS/TBtGVEkD
	 lWlNmjeEt93sRmo/tZqzWV7Ihqw8n4SBDEG/LGyfQ1oAvJzi835YuyNkATAVn4H8zx
	 ZC6MJ7t1hCa0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 718466060E;
	Sat,  5 Sep 2026 13:02:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4685B2FC
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BEA781106
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLFYXc0wrWbW for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 10:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DE35681101
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788603894;
 b=AWegJ5S5ZSVqKHjx2ONKT8Qvq+J7bhTw8Cxgi+wrrpObvf6nucbtL5G79jpajYv5Tg3N
 OsJGRkTj+h+24wTZ+1d2l88VbPhdpjNiAsnaM25hMmP/HlYLs4vV4aukyUYiquenppQU8
 HO8NWG6IovBFG1e/zbPU0CGq2ME7DcAKK7qpHM26mFeuJXjzSZLWKKz7LtnoMnE9etamg
 4yq54eguSWbJG7LH1RYFNQQ9fwGfl2KOBrwrW+j9k1AOzkeOINztfRa7uq8ydpG0IEAqE
 QLTK/qKlw5Gu3G/HHyy2DWDgOq5iKnCsGOnRUa9nfe+/Qqf7Fk3wIN5Ifd/f+DTJNiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788603894;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=nIYUs85K8F3zzyHc5xxWwG1eCA9VuPJeQf7biBhAnDg=;
 b=J6mdlT2+pofvPO0gUpRg2gplxCZvipJZNvxH7shHtH3Owrz0AB/12Pl5nSAithYCCy0S
 lG+2T2BOH6EA8t4cDimTEtgmq2nvPHNB0EI2B0rZCPV3dDP87aZ0x2TPOkHGEZWWroqFM
 o5BWLKUIc6OTfQXLqlLbGT9l/565X2JYLjoW4JUTfmcPnUknRDNm/flYyEFPGKfy3uk2G
 4f70YJ5QIoWiUjMCd7PpDyOA5KzMALUMddP8ZcpNms9NtTjQmSlWWkCpDtY3KZAN16qOh
 Vm88lIAVeV0O2zP9zbPfFiFzTtzo9Zxo5+KxFd0jGPWix3LvSYBGdG3H81DbjZckA0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lgEHB6+c; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lgEHB6+c
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE35681101
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:51 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so21361965e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788603889; x=1789208689;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYUs85K8F3zzyHc5xxWwG1eCA9VuPJeQf7biBhAnDg=;
 b=lgEHB6+cihKtmvGFNhV2RuqrDOA2p118oT23z8yncpfXvSe2WMKZH4WYfa5Vxs+DK1
 DkTCldtoHnX++KOlR0Kun9JaDhDsaf+J2raqjDryiLpOP2Kz8LAg3OF6enqP9bgVb2Sy
 PmhNrgM6SJlq8FwLMWjcCbKiD4aa6aiBwsDbHSJiKnWgs1B85B6zJmuUFUNGgze9ajM+
 PWRTzM/PNVC1RmdBj4WZKs31NKfI/QkEsmdMy0SnKgQWkcgcADAo/1vseRZvGxS7jKTZ
 btSSZHorNDupwcN5NgGiMXJh43bR998TnXqPuw+IEx12YD9p4IPTKZJ6V2bkO4i04ti+
 qR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788603889; x=1789208689;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nIYUs85K8F3zzyHc5xxWwG1eCA9VuPJeQf7biBhAnDg=;
 b=Gvj6rlDPr54Fn0Fbnhu3G2gOkxr1FYS9bsfRyZUrQ/LZLMkDacL1A3h3EikeiKZOCZ
 00F9OKtts+Wwthe5SJKInTyV39WAy+ljHWxpKin9rTX/WehUmJqekXWisets+Vd38YHm
 vlJtK0Yu9HgbR8y7CEgd8ji5ckPqGYxcoK45+IxcwZ3Qs0H4UJKIwqhLXrXGrrOl0fpE
 ziNz+RaNopzO0GhLcyvYCQl91TBDDXmpmNQNrsOeZ3/NqnClQte4REAGezqxAKdUX+EL
 qj2Gp4yfGIT1nRf504VOikQ+fhNvoZgT3fAnGT/osMm5i3RmYWGXy371LhcYbmH+7H4+
 hp6w==
X-Gm-Message-State: AFuF++kH73uJ7iUDlNMIGUQDVligox2z+Ti2ReXS41re1LCe1CrXrpNN
 I55kRHaAhjX5dmIZjQcdX3lF1S61sIJojMbRRK2ThrdndqfKxfiHa0U2pyq0Jg==
X-Gm-Gg: AYBFou0jWW/sTCVx4I79jBDwZ4nx852i35f/j60dzvHR87xL3rekUeeC72zD+7VjpHP
 SoKQ0/vfw1+QPeBjaWaVoV0Jhln1jhcowImKFvI/WR4nyD2eHSGj6Afj+ZD7oxxvKERAHafUoXt
 uQxA/juGeHQEC6tNHVXicphlwuckAqAtfoxZbALo7zThoaldBco29kThZneZklB6q5C+7a2/+bo
 SfcNFGPVT8KJk3VryFLiTSXQMhFoU9RK9mscYremFcTehAMXYdn9JbDpgJ9dIB32nVt2U2Cpokk
 CDpaXrcXeZn5cKPueKmjvejV6OEdUyeO9Z7iLMuoFA4zVgBGIieC4ClZqh9++CR0ZProG7E9FqL
 07Q1sMRKIHGj1Ycx2cW6kRxx18l+jWblkQ3j4ZAN0aSXNeUj+0uePHE8pTInXsXz25lFsm6w8zF
 B1SY+b7csLzqlxxl6azptpcFG13xr8SBXhYf7XW1W2+mRbBw4ygj6mze0Ldsni6d+9POwcc8hs5
 f+oKCbtpmQRZXhDsVkILFe4kTHxY561oQtN8AzBSxIYHKgcQEQGSZIOvebOnGYKlf1l3rpciLTQ
 sAFRvdY=
X-Received: by 2002:a05:600c:4685:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49cf7f32214mr120211245e9.0.1788603889239; 
 Sat, 05 Sep 2026 03:24:49 -0700 (PDT)
Received: from lap.lan (xcpe-178-82-236-193.dyn.res.sunrise.net.
 [178.82.236.193]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm164424635e9.10.2026.09.05.03.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 03:24:48 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v5 0/3] spi: Introduce driver-model support for SPI EEPROMs
Date: Sat,  5 Sep 2026 12:24:28 +0200
Message-ID: <20260905102431.426747-1-joaofl@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615175118.53720-1-joaofl@gmail.com>
References: <20260615175118.53720-1-joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 13:02:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds a UCLASS_SPI_EEPROM uclass, a driver for AT25-style
parts, a sandbox emulator and a DM test.

Simon, thank you for the detailed review of v4 - it was a genuinely
useful read. The point about the hard-coded 16-bit address in
particular sent this somewhere better than where I had it, and chasing
your comment about the non-standard 'size' and 'pagesize' properties is
what turned up the atmel,at25 binding already sitting in the tree,
which now drives the whole geometry.

v5 addresses that review. The main change is that the driver
is no longer hard-wired to a single 16-bit-addressed part: the address
length now comes from driver data and can be overridden from the device
tree, so 8-, 16- and 24-bit addressed devices all work.

It also fixes a crash that v3 and v4 both had, and that I only spotted
while re-testing this round. Adding the EEPROM emulator to test.dts
makes "ut dm" segfault in dm_test_spi_flash: that test picks up its
emulator with uclass_first_device_err(UCLASS_SPI_EMUL), assuming the
sandbox SPI flash emulator is the only one. The flash emulator is bound
lazily on first transfer, so a second emulator described in the device
tree is bound during the devicetree scan and lands first in the uclass.
sandbox_sf_set_block_protect() then casts a struct sandbox_spi_eeprom
to struct sandbox_spi_flash and writes past the end of it, which trips
the dlmalloc heap check. Sorry for shipping that in v3/v4 - my testing
had been running "ut dm spi_eeprom" rather than the whole suite. New
patch 1 fixes the test; with it, "ut dm" on sandbox reports the same 28
failures as an unpatched v2026.10-rc3 tree here (all fixture-related),
plus the new spi_eeprom test passing.

Changes in v5:

- New patch 1: test/dm/sf.c now asks for the emulator attached to its
  own slave rather than the first one in UCLASS_SPI_EMUL, fixing the
  segfault described above.

- Commit message on patch 2 reworded: imperative mood, "driver model"
  rather than "driver mode", and it now explains the motivation - what
  these EEPROMs are used for and why the uclass is wanted.

- SPI_EEPROM_CMD_SIZE is gone. Address length is an addr_len field in
  driver data, overridable from the device tree, so parts larger than
  64 KiB are handled and adding one later does not need an API change.

- The AT25_CMD_* opcodes have moved out of include/spi_eeprom.h into a
  new private header, drivers/misc/spi_eeprom_priv.h, shared by the
  driver and the emulator.

- The read path no longer computes "offset + size", which could
  overflow; the two ranges are checked independently as suggested.
  probe() additionally rejects a "size" that does not fit the
  configured address width, so an offset can no longer be silently
  truncated.

- of_to_plat() dropped; the geometry is read in probe() instead.

- "size" and "pagesize" are kept, and "address-width" added, because
  they are documented -- and in fact required for non-FRAM parts -- by
  the atmel,at25 binding in dts/upstream/Bindings/eeprom/at25.yaml,
  which is already in tree. The commit message and Kconfig help now
  point at it.

- Compatible list expanded, taking the strings from that binding rather
  than inventing them: microchip,25aa010a, microchip,at25160bn,
  atmel,at25256B, st,m95640, st,m95256 and st,m95m02, plus the generic
  "atmel,at25" fallback the binding requires every node to carry. A
  node matching only the fallback is fully described by its device
  tree. The at25010b/020b/040b/080b/640b strings suggested in review
  are not part of the binding so I left them out, and microchip,25lc040
  is in the binding but uses 9-bit addressing, which this driver does
  not implement yet.

- Kconfig: "depends on MISC" dropped -- the misc uclass really is not
  used here. (For the record, I2C_EEPROM in tree does still carry it.)
  The help text now describes the uclass, the AT25 driver, the
  supported address widths and the read-only limitation.

- include/spi_eeprom.h converted to kerneldoc, and the outer #endif is
  now commented.

- The sandbox EEPROM node in test.dts follows the binding: it carries
  the "atmel,at25" fallback compatible and the required size, pagesize
  and address-width properties.

- Added my own copyright line alongside the existing Philips one on the
  new files. The first version of this series was posted while I worked
  at Philips; the rework since is my own.

Patch 3 (the emulator and test) is otherwise unchanged, and I have kept
Simon's Reviewed-by and Tested-by on it.

Simon - please do re-test rather than let those tags stand. The tree
you tested for v4 segfaulted on a full "ut dm"; only "ut dm spi_eeprom"
on its own passes, which I assume is what we both ran. New patch 1 is
what makes the full suite pass again. Patch 3 has also changed since
v4: its DT node now follows the atmel,at25 binding, and the emulator
includes the new private header instead of the uclass one. Happy to
drop the tags if you would rather re-review from scratch.

Changes in v4:
- Emulator frees its backing store in a remove() method.
- Full kerneldoc for sandbox_spi_emul_get().

Changes in v3:
- Reindented with tabs; the series is now checkpatch-clean.
- Dropped the no-op write stub in favour of returning -ENOSYS.
- Removed dead code, fixed the read bounds check, corrected the
  AT25160 geometry, switched to u8 types and added a MAINTAINERS entry.
- Added the sandbox emulator and the DM test (patch 2).

João Loureiro (3):
  test: dm: sf: Get the emulator attached to the flash slave
  spi: Introduce initial driver-model support for SPI EEPROMs
  sandbox: spi: Add SPI EEPROM emulator and DM test

 MAINTAINERS                    |   9 ++
 arch/sandbox/dts/test.dts      |  16 +-
 configs/sandbox_defconfig      |   1 +
 drivers/misc/Kconfig           |  15 ++
 drivers/misc/Makefile          |   2 +
 drivers/misc/spi_eeprom.c      | 267 +++++++++++++++++++++++++++++++++
 drivers/misc/spi_eeprom_emul.c | 130 ++++++++++++++++
 drivers/misc/spi_eeprom_priv.h |  18 +++
 drivers/spi/sandbox_spi.c      |  37 ++++-
 include/dm/uclass-id.h         |   1 +
 include/spi_eeprom.h           |  95 ++++++++++++
 test/dm/Makefile               |   1 +
 test/dm/sf.c                   |   9 +-
 test/dm/spi_eeprom.c           |  46 ++++++
 14 files changed, 643 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 drivers/misc/spi_eeprom_priv.h
 create mode 100644 include/spi_eeprom.h
 create mode 100644 test/dm/spi_eeprom.c

-- 
2.55.0

