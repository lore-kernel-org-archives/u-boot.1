Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD520CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F839813F8;
	Fri, 16 Oct 2026 08:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JnIZGu0BHTW; Fri, 16 Oct 2026 08:37:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A737813F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792139837;
	b=VWSmPoWvBfb8/U+7ZPD3MyTpkb3QFH/8gb0qZ812Ct6W2gK49vsYSQ5NRq1LPgQuU79n
	 eNZC46Cu6suBBYsjKZL7i/lP+TOJMFDhA9JrEKHP+aubjOWuchUu3dR0m6N1D0+yu4bpX
	 atwoq2ZDhDHfYRoA8fya0WeTvKY19NylBjAWnHnYBXho2VSDg7aNtRSaN3Gt723hohoec
	 cCbzyS/BlNuntDEIEN2K+tYPg0ElzQemxqZP3UQM0zN8KKz0h4nGso3SZ+AuDMahRZaLv
	 CC/M5/5nC10xt9EIWxkaNJq6OCRq2EP+ecyJkfFwADrZHJWfRgHB/k2nFi9N77+19kQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792139837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZY5ZfgrpvdVl1vlraqNyvcKVM266IKWyclcOSoayayI=;
	b=aUs8t5hOlnWpFxbdFpVuoLwgq8+kQ0ukX4UCFI1/+/o00qvZOYyJhIwqUiztmGQBv2qT
	 hcUO2XWiOVozzBEVMvl/WDWAm3f5xQknr1+/E0pZxlOV190c0mfGI7mW2sad+RhZR5piN
	 iSD4IADVX7kqkJfu7Oj/X+pscIU/QLAS2tzgmLWK9e5WekpnTwRqDRew2kav6X05Kx1Gd
	 SfA5rxNMu3+3BKy340zFHx0fXnDK4gO2uVTxmDWVWvuaohD1xdQ5DqiY1O9nNk7x56r7W
	 VHDA7pNkfBP3PxFb/rT6v9hKMONZSZSKa6AhEMDG6QQp+dSBSlBggtxyHOCNSbyhFvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792139837;
	bh=ZY5ZfgrpvdVl1vlraqNyvcKVM266IKWyclcOSoayayI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VFmWhjIF1t0QfIPOxuOtuH1aUYHN5kje9ZU1yI1mSrA+GL3O2+KsOO3k99n+WuwZV
	 FQjFYzNit1Ses99Svh51XeMotCXHci7kTEbxelVPnZol5Hewuam4+aRjj74Vr3A4ZH
	 yRp3gyp3E57e7F311SKIcb3W0CdlAMixF071mMuOeghzNXI5vx5tEcnVO18exlZAAg
	 CNdsraLMbjpJaHv12KGWlG6g6hxNzVe0vBTQky87Y/ALTY+LyfgFmdcUlSF44EN9yc
	 xWlMg6WrJVOTtLCvx91+RehwDujzsScTH+fuq3lbF1lGEmq3I/+Fqy5M50APpMjfD7
	 GOa23SCrW1IMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A737813F2;
	Fri, 16 Oct 2026 08:37:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B230920
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1135B409CF
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2BTQ3PnjrtxH for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:37:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F035409CB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792139833;
 b=d9bVPzLWG/nCkSzfjUiRpWNal4AZlh28fp/XFIs8vAQ32Gw7FdKZqgddohu35jv8+9YJ
 zYMwN+rPD9qZB24rhEfmoyXnkgsbAG2qxnkhLjn8Sx3z9RjV3u1cV+fNgReGTD/J9TvLQ
 iZQSDfYNIN9iXrepdPW/6MwvhOTGjZZ4apqgS7UG7F1PlodTbiwYOzzFJ2g+WuEbHYY31
 1AwjFJQqtrJcBn2aQGbRU9yKi+ksSQPNFSGBsPZ5lU53YJ+2UD1FNHhlmSkjoFcff1n6g
 k59j1PaOGvxuaVi17HicsXBzlgjUbA+IZcWGhFPcgQKLDx1/FqoJ6Z3vmj1Eg4O0DRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792139833;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=ZY5ZfgrpvdVl1vlraqNyvcKVM266IKWyclcOSoayayI=;
 b=Kf0UNqv2bOkgbP/ExTMUt86CYJbaG0FdihoMP4QwqusVsYYM0NvPJIxYeynIQCkreouq
 lOiatboV2ZcFsqwmHxSgHfFHs/Gt/L+Xz1jI1nfxK3xI44KyjBzSZfYdzFn8wd6UFr7+Z
 kU2DP7WeRo9p4o7WIBv/xC/NSPCvrpHWNz5/NxaUeRZqtTWt4Oy+nALcrjd44jtyvXosP
 XnsBW64W/SlimylMIkrVWPo/2KBP/dnI5CX/sFJWzeRuSjl0YcmEKWwK4eXCO9Do+rP0k
 pRCNL8hzb3DQBtgwYldLOKQ7ouiLBIgFt5D/P7K7+wok0uV9yV9daK2KU/GuPD/g89A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="Pm/Br5B6"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Pm/Br5B6
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F035409CB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:10 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so550486f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792139828; x=1792744628;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZY5ZfgrpvdVl1vlraqNyvcKVM266IKWyclcOSoayayI=;
 b=Pm/Br5B6sqwblUvvH/RoYE5Xtd6KhRtMMtOvZhJlbdnXyUVVImF8tRZSLOuCBTKCrL
 Fx2yttn5dx2wTQE1rqqtSKNLR+VrurSdRDNJlbJURsY92WFZCvqANNVpRkUnNqBJXWJl
 +r5yuQt5rX1kog7bm3mqY7dYh5zl3+k489grmajBiBRvmI8vo/Ahmaq/U6egV7arPJ0T
 1HNn9RJr+XqpfTzyKSVwX0Qh94OELax73MkN+jDoH3xmIMN1j21Up5NjkNkmL0A/aY6N
 n+sy3d8oaYcNrFCfteywGuDYZKWsPmGd5szmTwes3XdIzdyWwjh7apvNrzjbLlPrHfBf
 Zyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792139828; x=1792744628;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZY5ZfgrpvdVl1vlraqNyvcKVM266IKWyclcOSoayayI=;
 b=y9c50oRYgFc5Xz+klREi85sJtEDGHNZBUewP8ePhQviixAoUsYqxwoOv1HOz8LPwXu
 qtZTnjrfjpMxkcv5VO/NI8s0obwG5xMKgGY3tbie99JhmiQ8eKULbSh2WFwZB2NUtypr
 S7kfplU8XNKCf0inhGVDAyzg+6FYdHjKbgZxKEN8+mx0dFEvshMyHvcG8l/pP5LSPl0+
 HIQsAxvNJEmmQslSEjciZAiakr0zWVCCPb3D8Y6476tZkOWUNzmimnq1swFE1vXP2RSZ
 eVriD2nnqZ3xEHXRAZMXqony6QFPxsPEZ4LvtFv38FZRploY1np3RKp7pbsmwi7nZw1+
 fCUw==
X-Gm-Message-State: AFq9FYLbizL4rfsaHI4INO8Cia8z8RHeIM7mdsqOe7Js7/F5whj0BLSP
 dQSkQSoWd59Mg/dEUzwiYIKxo8eCgWlrJyb1AMx/4G71iE8/XFJbZs7bv3zjHFsjUcU=
X-Gm-Gg: AYBFou0xIl67VLrESvSGeFQ/4CwxPddS/d164+6U/GjD4Wv/q+JRbJh5S4OLR+uSILc
 KHtHDa6hJrYvc4doZo8qc/pemxqbML4ef3uCMwwXZIGtlnrikRnymf9E3q6h5yOLm6LDwxeRNY9
 9t9U12QED2a6KjP3wcuLeLoX2XJTmJLgeTeteFA97lIfYXUEdeHST+UQ0FUFd3428F5k/9nIMTh
 thogXjje/IO55AMw4JxK90gEQ84drwiKJmp8gUlXdlyXYSGmFHA0gW4FBa1ISlYShszV0wW7d/l
 ov4OOdhVTg9NyNq7/oMNxy4R+mlzl6AYK+BFK4LDzvS1ZKk4Urudn6dNmKiy6noe8ThFpkI2Fi2
 X8s1tllD8jIZUdGFLkSN8gmb+4tIZVdQgSmqRzeQzun6TZNR1LrQtKkxHm0vymIOmQMdK2J5L0G
 zaE3A71iYrFJcEjXBpxooU/i4/VMk8Ib6Ebbu1aNcwBDqCCypzDrN2oB2PUpVkNeBlViaDOc7dz
 +b4wA3VhCjbq4ADCDIC1bAu+134Sk/b4aNkek43iCA5kT/guuQZeC/gFMVF3tOKRt6yRWvWTYxy
 reeaLM5jgR/t0VI=
X-Received: by 2002:a05:6000:480d:b0:48d:eac6:5c2c with SMTP id
 ffacd0b85a97d-48dfae65e0cmr5774994f8f.15.1792139828348; 
 Fri, 16 Oct 2026 01:37:08 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm3100727f8f.3.2026.10.16.01.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:37:07 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/5] Prepare devicetrees from FIT configurations with fdt fit
Date: Fri, 16 Oct 2026 10:36:58 +0200
Message-Id: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBBFr9LM2omACVGvYlwMMLRjIm2AmiZN7
 y7o8v28/3YonIUL3IcdMn+kyJwa6NMAfqI0MkpoDEYZq5W26D01hXFdSs1Mb4yhYpSK5havl6A
 iWfLQ7kvmKNsv/Xj+uazuxb72XjccFUaXKfmpT3OWUdI58VbhOL4jpSwHmgAAAA==
X-Change-ID: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
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

Some boards keep a base devicetree and its overlays in a FIT, while the
kernel or EFI application comes from another source. Boot scripts need
a way to verify and assemble that tree without booting an OS from the FIT.

This series adds:

    fdt fit <addr>[#<conf>] <dest> [<len>]

The script loads the FIT into memory with an existing command. fdt fit
then prepares the devicetree described by one configuration, verifies it,
applies its overlays and copies the completed result to the chosen
destination. The script can pass that address to bootefi, booti or
another boot command, and must stop the boot if preparation fails.

The command reuses the FIT loader, always checks image hashes and
enforces any required configuration signatures, even with verify=no.
It rejects chained configurations: signing each configuration separately
does not authenticate their combination. FIT image load addresses are
ignored, so preparation does not write to them before checks complete.

The first three patches provide the loader support, including rejecting
missing or invalid overlays. The last two add the command, documentation
and sandbox tests.

This is a new, simpler approach to the firmware-owned devicetree work
previously submitted in the EBBR series [1]. Storage, configuration
selection and boot policy stay in the script. There is no new DT binding,
storage driver or automatic hook into the EFI boot paths.

[1] https://lore.kernel.org/all/20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com/

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (5):
      boot: fit: tell callers when a devicetree buffer must be freed
      boot: fit: reject configurations with missing or invalid overlays
      boot: fit: let callers choose where to place the devicetree
      cmd: fdt: add 'fdt fit' to prepare a devicetree for other boot commands
      test: py: cover fdt fit preparation and failure handling

 boot/image-fdt.c              |   4 +-
 boot/image-fit.c              |  84 +++++++---
 cmd/Kconfig                   |   9 +
 cmd/fdt.c                     |  83 ++++++++++
 configs/sandbox_defconfig     |   1 +
 doc/usage/cmd/fdt.rst         |  75 +++++++++
 include/image.h               |  10 +-
 test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 615 insertions(+), 22 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

