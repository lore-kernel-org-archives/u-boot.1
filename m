Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6210DC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C21E3810D8;
	Thu,  3 Sep 2026 13:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CFYaIo25xDQO; Thu,  3 Sep 2026 13:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99D9381090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441005;
	b=dyRkmkuJ6CgsKrx31gjfIw/dNEL4y6TTFRslgHvfFqutIuTtLkMIM/4tW22lQQZKBD6G
	 ZnRVprXhO/KtlZbuO01DEhRPTmwA0VcqPH+9vLJK+h20JDkUzj/v9EGVaMbITJgvAyXwr
	 ns9SQ+G1GXPm/DtIxQ0Y6VFHZy6LXOkA4G5mdP2LDV0/z/denDJ3HZ36F20w8GX+2Ze6C
	 ArW2Z9Vn5UOQaaPuDEQx7WUBf/NRGGpDso4Euk14V0CA1TKsJfofOdtUlsV4gX+A+NmoO
	 MIVp8HEd043xTtzkQShgPqFrgXpPw3NkWWpBO+6PfSH/DaoYwZ9iH0EZ5URbswRhzDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cmidAeEAP7Qjtl31cRZdGIijSwx+AU5qtUa+1n6cs3E=;
	b=haY9CFZ163gFdthhEM8bQb6DlLw0+wd//9rSuu9fmervyuyfphH0oUbGDw4fC36FvERO
	 iuUaSzKHNzs2nRLW0KU+8ZD7R9m1h2mNeeNUo+FqwammckLyU+M7pEBKu2wsvi751uGTC
	 w6n+Jq8FisgMDfAvTn4aiZQukPd6ORWlY7XV7x/vQJvce01kDeXhCZF2aIXqUi7qzpROL
	 L68DJlAyBFyBW984B9ZGh2O9S6E+8ivFQxj1DMXjByBFOrt3EYPfo9hGxEBsO9jI1XEfp
	 C7OCdgjyyx7oyMLfXB79DgD5/7lM/wN98E9M3VAnqbZZN5C6QLbUWDrQ+hXjAUsoXPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788441005;
	bh=cmidAeEAP7Qjtl31cRZdGIijSwx+AU5qtUa+1n6cs3E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fN/q/nw5DM3pDduLYOz8xHTtpkJjrmfPzpZHmFpp1lOJqhR93Siwhg/JDIC3ZeYhR
	 lPQVmGON8kZ/kiYqVDxHyxRCXmp/MpgXVeBvOYCabqB7dB/QUd1LbpcnmrA198qxe7
	 xxee2vAdfpcx1n27+JH5N0gL3JAKggYQ4UTXcqrF20X+zKo1abH+xe6hwBrQ6f3pqJ
	 tY/W6ZtHC/PlfIMXMo+QYVQfjN/QMSTeOAaClk4JARg1Cx+zfuH4EstTpASE+qti4Z
	 k7t090apEg9qLhgg5PjqmxzxdPZpE/8NL1Cv6bktDEq/1k6n8zrzLZhWr5Kyy6tTx1
	 EPvWbfzqNzOxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99D9381090;
	Thu,  3 Sep 2026 13:10:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DEF7FD5C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C32E540469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7MXrYrtBRoHQ for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D11BE40454
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788441001;
 b=JypJFnB2S9nC4Q3qkso3gMgDOSd7kMZHXF72ybg3st6CBkZ75DFf601HDFTVfzJuuiEp
 CZBYFwW2eyi/9Imo4n7P9cDMZX/v1YZIhDaEsJplhRs8kZxU6I/kdlRbTJtchGDyO8qm5
 tbVx/SaCODejbKlMqV5Tfy2iUPLMuoxIZLBZmCEnNC6DZAft/Cscbb+v11bxGMfz/r7ct
 dp009zaiRPf374Ucrbuiuv0HOAwAGAKdC1FDWk30Tei53PyFwOx99XykleBXLDMbW4j1c
 WFKhBUdRirhaxHarcnnWRhCX6KkKBiaOuxUA6njxZXpnY9Aq+at1eKBuRm/68SPToOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441001;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=cmidAeEAP7Qjtl31cRZdGIijSwx+AU5qtUa+1n6cs3E=;
 b=hksLJ3BJhojQ4aa+bMayjt68FCAf4yXjVVttDqGhQLWS+ecbZPuI+5hpwSovMY4l1Nax
 jR8b+BF++sMxGPd1hT5MKW08DLpODxiQcsWolyk2OiFxvcb2RDm6yAFcjVGIhGJNrFuGE
 XbhO4jZLtZzTZkXBUUTaKqKcrL49wZmdFd9sflW1YjFgryTTk8dsanXqVA3wLi70kLjoD
 wKYp6VxfulGQm/6KDQFl8Npqg12TgqDeiqBLF1/cpMUoYOdW8s3C4JMShAWSl8WEdcVmx
 zCYl3tvzv550aZsVw7bKaaIX7yCF2t1Z4qI+WjxrvYj+yla9m7OYFHDvnqy0qxwCK1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=A1d6Bf2A; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=A1d6Bf2A
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D11BE40454
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:09:59 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-485850cbac3so183020f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788440998; x=1789045798;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cmidAeEAP7Qjtl31cRZdGIijSwx+AU5qtUa+1n6cs3E=;
 b=A1d6Bf2AIEyaC8Y/u3QYqRolHARq+zGun8WWwFbGNZEFkgGBU5OJ83Ejad2DqDF3Er
 5gSZIRPEWjTWochQfgID0W1lvbpmssvAHr5zS2x99CEWF83i3ReA1R0tCD00l3Un+8wr
 6fvpA+8RDFa2ANOm/ZBAWMOEoNfsTicx6ZfQMzhX1LZaRFZnnpfqNwK8F/U5YV2FX2FI
 mQYVYdjsHzIhoGcEETa45Wt2s5z93b+Ew8QPP0Xy39ZFVgD48DMoQxhiTvWv+kNq1wyV
 BTQ5Pe+A8/Ws1LX/PxfKGT7n50ttxaFLiHcSBdPWzGJoiaNLNvSd9RSKONsspu+Ck1EY
 LWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440998; x=1789045798;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cmidAeEAP7Qjtl31cRZdGIijSwx+AU5qtUa+1n6cs3E=;
 b=FC+D5SardmIXxL0nosaUHABctzJocCu8YXums3NtdQQe36Wmp9WrbNrqauP/ws4y5M
 W4h9SlsWyV4u0ymfY2nZas5wVE6mKR76jCdiqJKAtz+3/k/v+IPdt9yi0yjeJHBNb/ku
 Y9J//a6ZMccvg4vqdJkkEQvARu5lFr96nWFzd7zvsftINCVaaswKfN5m7+WZJxQWuuxX
 NlEtAeq1ZtYJVs2SRxhGj7VIV6VSOUhEaig13N8xvGoRNe3I8c4yJvmga8DTIa38gIbe
 f1XItcO1Bo98/q3SN6lE9V5ZG9gGRtJdugUr0oE/weePDekag8OLWo25+4nh4WVhGybo
 1nDA==
X-Gm-Message-State: AFuF++n+aBLBd1bP/y/3CtyKOZxIHKisQzcoN3B9p8MUyqpWsQLz9BDK
 xSzZKYTgx6L3Bcy+xhbVf/t+Ww4Wv2kiHeRhvJOSNfujcmOoUU1zo5YCxxlywR/qlNuHW78Z3Jd
 1Wr6mfN4=
X-Gm-Gg: AYBFou3LWc8yGTo1/AGvXSkM38LIvvm/s3/4uB7xSTAYVdAWxSmOv0xw0TtzU8ZrsBu
 +ft2whaT+J6T1uXWYBKzzbUfdvEb/AnXRDgqUtUnEgnF5gCN/eRoeT388k9aHee3BGnQ8UpF1cR
 vRrDps5DKKGp9YBphuMMbyACHbWTsDteHO0OdBOAhmUoihN4DvhJpert4ipqIzjYq6ZtuT36LSt
 ev63Cc8LpkyupYh/v9dptuemuZaNt5gR/KT6+f2rcKrdn2k3EMpQlKOU1OcvvOb3Ggn4sRTPisv
 QtuLtVyB9JDzW0iS2huh6sAtv7wCEa1kQwzF4bu7SqGd3L+EhrpPh3+3Xsl7i0T5LhczFH1zC/3
 dJU4qVxVIIgg2FRLMOpuFwUVdM6mvwlOUFHpwZ+anrb4CXYiUq5zQ2rJakKHvx2CksuQSjU4aBq
 6c0UOj6OJUF9em54OQgbN/f2Ejh8rf4ASlBgUnqn+DoCBPV1KmW/AHhQtE+FII5S4veaI+OMcVY
 EsIriGZQjO8Bj18IrTDV/0HqLArEc04DLQRundiOQdtV5GT3tTgYBUzKXnekd5yccZCxGGqE+2A
 qgrTu6H6OUknpeRc
X-Received: by 2002:a05:6000:601:b0:484:36c8:ffb9 with SMTP id
 ffacd0b85a97d-48586022058mr432194f8f.4.1788440997865; 
 Thu, 03 Sep 2026 06:09:57 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm12755807f8f.19.2026.09.03.06.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:09:57 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v3 0/5] firmware-owned devicetree for EBBR / SystemReady
 DeviceTree
Date: Thu, 03 Sep 2026 15:09:47 +0200
Message-Id: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBQFf4V0bU25haKu/A/joo+L1MgjLTQSw
 r/b4saYGJeTzJmzEI/OoienbCEOg/W27yLwXUZ0I7sbUmsiE2AgWMUE1VpGBek0+NGhbCkq5Sg
 woTlTyCWXJG4Hh7V9bt3L9c1+UnfUY4olo7F+7N28HYc8ef8+Qk4ZxaoAbYyQCsuzkvPDKod73
 bck3QT4CMHhVwhiqMBalXDMC2bEV2hd1xeCgu+uGAEAAA==
X-Change-ID: 20260706-ccaione-upstream-ebbr-206c30be3a3a
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

EBBR-style firmware owns the devicetree: the OS is booted via UEFI and
receives the devicetree from the firmware through the EFI configuration
table instead of shipping its own. U-Boot has the handoff mechanism
(efi_install_fdt()), but no generic way to describe and load the
firmware-owned source. As a result, platforms carry downstream commands
to provide it.

This series adds a firmware-FDT uclass with storage-specific source
drivers and common FIT selection, verification, overlay assembly and
caching:

- one FIT ("fdt.itb" by default) carries the base devicetree and its
  overlays. FIT configurations describe valid combinations, so a signed
  configuration authenticates the base, overlay set and ordering;

- the first backend, selected by a standalone
  'u-boot,firmware-fdt-block' control-DT node, reads the FIT from a
  filesystem on a GPT partition. The compatible suffix leaves room for
  drivers which obtain the same FIT from other firmware storage;

- 'fw_fdt_part' can override the partition for A/B firmware selection,
  while 'fw_fdt_config' can select the configuration for the current boot
  policy. Otherwise compatible best-match against the control devicetree
  is used, falling back to the FIT default;

- the source device caches the assembled result by those two selectors,
  avoiding repeated reads and verification while the EFI bootmeth scans
  bootflow candidates;

- once a source is configured, any failure to assemble the devicetree is
  fatal rather than silently falling back to an unverified source. Every
  image is verified up front so a corrupt overlay cannot be silently
  skipped.

The loader does not depend on standard boot. EFI is its first consumer,
but the source drivers, FIT handling and staging interface are generic.
Both the EFI bootmeth and EFI boot manager use the same staging helper.

Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
as an independent behaviour fix. Patch 2 adds the uclass, block backend,
documentation and staging interface. Patches 3 and 4 integrate the EFI
bootmeth and boot manager. Patch 5 adds sandbox coverage.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v3:
- Model firmware-FDT sources as a uclass with storage backend drivers;
  split out the block backend and reject multiple enabled sources.
- Cache the verified, assembled devicetree by the partition and
  configuration runtime selectors.
- Rename efi_stage_firmware_fdt() to the generic firmware_fdt_stage().
- Add separate configurable size limits for the input FIT and assembled
  devicetree.
- Validate the assembled devicetree before publishing it and avoid
  duplicating the internal FIT filename.
- Keep EFI and firmware-FDT sizes separate in the boot manager and retain
  the FIT filename for failure diagnostics.
- Extend sandbox coverage for caching and selector invalidation, a missing
  FIT and multiple configured sources.
- Use the current SystemReady DeviceTree name.
- Clarify fw_fdt_part as the A/B partition override and fw_fdt_config as
  the per-boot-target configuration override accepted in the v2 review.
- Add Reviewed-by tags from Ilias Apalodimas and Simon Glass to patch 1.
- Link to v2: https://patch.msgid.link/20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com

Changes in v2:
- Make the loader independent of bootstd and describe EFI as its first
  consumer.
- Describe the source with a standalone compatible node which points to
  the backing media through a phandle.
- Rename 'boot_dtb' to 'fw_fdt_part' and document both environment
  variables in doc/usage/environment.rst.
- Factor EFI staging and fail-closed policy into one helper used by all
  three call sites.
- Track the assembled FDT's ownership explicitly and own the FIT filename.
- Select FIT_BEST_MATCH and add explicit compatible-selection coverage.
- Split the passed-FDT precedence change into its own first patch.
- Build the entire sandbox source topology at runtime, store mmc11.img in
  persistent_data_dir and add staging, configuration-chaining and corrupt
  base/overlay fail-closed coverage.
- Link to v1: https://patch.msgid.link/20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com

---
Carlo Caione (5):
      efi_loader: bootmgr: preserve a passed devicetree
      boot: add a firmware-owned devicetree source
      bootmeth: efi: use the firmware-owned devicetree
      efi_loader: bootmgr: install the firmware-owned devicetree
      test: boot: add firmware-FDT source tests

 MAINTAINERS                               |   3 +
 boot/Kconfig                              |  49 +++
 boot/Makefile                             |   2 +
 boot/bootmeth_efi.c                       |  45 ++-
 boot/firmware_fdt.c                       | 303 ++++++++++++++++++
 boot/firmware_fdt_block.c                 | 143 +++++++++
 boot/image-fdt.c                          |   3 +-
 boot/image-fit.c                          |   9 +-
 configs/sandbox_defconfig                 |   1 +
 doc/develop/uefi/firmware_fdt.rst         | 118 +++++++
 doc/develop/uefi/index.rst                |   1 +
 doc/device-tree-bindings/firmware-fdt.txt | 160 ++++++++++
 doc/usage/environment.rst                 |  13 +
 include/dm/uclass-id.h                    |   1 +
 include/firmware_fdt.h                    | 106 +++++++
 include/image.h                           |   5 +-
 lib/efi_loader/efi_bootmgr.c              |  45 ++-
 test/boot/Makefile                        |   1 +
 test/boot/firmware_fdt.c                  | 498 ++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py                  | 183 +++++++++++
 20 files changed, 1670 insertions(+), 19 deletions(-)
---
base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
change-id: 20260706-ccaione-upstream-ebbr-206c30be3a3a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

