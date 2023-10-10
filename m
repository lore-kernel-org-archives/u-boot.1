Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281AECD68F6
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 07:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA86C86D20;
	Tue, 10 Oct 2023 09:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MRIgGzwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5F286D62; Tue, 10 Oct 2023 09:14:39 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB4786489
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 09:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-536b39daec1so8969751a12.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696922076; x=1697526876; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y2M/R5vLO28oe6UkztbGQ4+qV9QbINQOKsAlC19vM04=;
 b=MRIgGzwG9JHK719PVUJvwuFGI7qCoGCYbGDBVdbzz+bkKdnSNq6Jb5c9Qu43vEojVi
 /xzTDQmW6g9C+RoPVxmvQ2r5YvHzGxCKoQLcaiMvzjpkDsPE4iuUZjzqc7GLRGSd4wMR
 uFSn+nrMbXh1thIcDc8NfAshR6aQTOh23uwK6gHNqODgRbVpLrrErZHep0PCNtORZcKn
 W41hOeSCVbYrcawJOMnFxLGuJfKgnDt03ggmw3UCKaPuiE8Pb+/B7bMjaCGC+ZFcibrE
 u39aju/x83iUaJ5Tiq7lwfa+uQqp9/kgpgUsCG/13hwcC5JTzhBjGrmysmC0a0htNvFe
 2Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696922076; x=1697526876;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y2M/R5vLO28oe6UkztbGQ4+qV9QbINQOKsAlC19vM04=;
 b=tRJX8flEaAtljlzLUnDA2SV+bKeaMXK9atAvokoZ59bKrUw4WYE4CaacP9gd3AGkyB
 C67IKr+06zPDuItEt8oYgZIa2SSOYUVg3irwczANnpjS08xOzVbQtNEQB+VBKl6n+lzN
 Fle3m97t7C/eUF/Er0wtfWiEQU9RN4n3E1hdYEhGfpAGuMLkef3Yl809GYefQthBbQWd
 NSjX0RkuKR8FXSDIdOubaIoPwZbJAw9wlLISCRQdzKAZZScq1dLIC9rWU+GZYZ3cZWGO
 Wu+cV08Zo8Bzpj/3IcxaXX4SMJ7z72dnq4iIyLwT+vSvTh9YWSpLAamedDPh8oB7Snsv
 SUgQ==
X-Gm-Message-State: AOJu0YzPPoGGpkDOS8u8sVS0ZVZJbaXFrO86S7zY1nc9RGUQaA4bTbWh
 vOJ9YH8xPxmMAq6wAMeZ/GeMWyU1TkQuRfbkYhU=
X-Google-Smtp-Source: AGHT+IF8mM6xe4TrdAX/gj4olo/Jkm6M1m6bAx+cEWLxkAZas0iqaWLv42jmN3TbuF2SuLNqyK+tEaduPhtUcHz9NGc=
X-Received: by 2002:aa7:dcd1:0:b0:537:7811:855f with SMTP id
 w17-20020aa7dcd1000000b005377811855fmr14803931edu.12.1696922076232; Tue, 10
 Oct 2023 00:14:36 -0700 (PDT)
MIME-Version: 1.0
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 10 Oct 2023 00:14:24 -0700
Message-ID: <CAJaLiFxGVdoa0wGbir-0kq8w9ZQUsDtN+FgXhaLfJ5_1yjJikg@mail.gmail.com>
Subject: When do we merge bug fixes and new functionality
To: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom, Simon, Stefan,

I have a few people waiting for these patches to get merged. So I hope
you don't mind (I'm not sure about the merging schedule), I'd bug you
guys about these patches. Wondering if these will be in v2024.01-rc1
or subsequence rc?

bootstd: sata: bootdev scanning for ahci sata with no drive attached
https://patchwork.ozlabs.org/project/uboot/patch/20231007033429.25109-1-mibodhi@gmail.com/

bootstd: use ARCH_DMA_MINALIGN in memalign() when allocating memory
https://patchwork.ozlabs.org/project/uboot/patch/20230919212722.16216-1-mibodhi@gmail.com/

bootstd: sata: Add bootstd support for ahci sata
https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/

arm: mvebu: Enable bootstd for Synology DS116 board
https://patchwork.ozlabs.org/project/uboot/patch/20231007213548.20276-1-mibodhi@gmail.com/

arm: mvebu: Enable bootstd for Thecus N2350 board
https://patchwork.ozlabs.org/project/uboot/patch/20231007220814.30783-1-mibodhi@gmail.com/

arm: mvebu: sata_mv: Add bootstd hook to enable sata_bootdev
https://patchwork.ozlabs.org/project/uboot/patch/20230906052242.21568-1-mibodhi@gmail.com/

arm: kirkwood: Add support for ZyXEL NSA325 board
https://patchwork.ozlabs.org/project/uboot/patch/20230826033330.7827-1-mibodhi@gmail.com/

arm: kirkwood: Pogo v4: Enable LTO
https://patchwork.ozlabs.org/project/uboot/patch/20230824190713.30866-1-mibodhi@gmail.com/

All the best,
Tony
