Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2E5C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 10:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 514A0878AA;
	Fri, 26 Jan 2024 11:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h4nQD2u0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E27B287BFD; Fri, 26 Jan 2024 11:54:00 +0100 (CET)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE8C87BBC
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 11:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4bd81be18a1so56627e0c.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706266437; x=1706871237; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NoPaxkSl2fdNYgPpynpM/9OCbrxcNrAjyr51GS3aQqk=;
 b=h4nQD2u076xnlc1W+L0Zi6Rjhw9Vawhf9LO14Yq+ZiK0G76yaOVzA2Q31wlBrENYzx
 sd6JOSCrFxkdcnn4l+z+c43xYLb5V2JbHoMYgMfzsrWXeFHDqIBCcJfSk5xDsNVJXlSL
 vc+KAjUsly6b0YWd7X2UPXsGey3PIc50BTqdcyFKG58Tnu7roHbAQzX/N0+v5pj3qyEN
 J5vLv0a3Ntt4ma0qjw3PAMw6/lGZhAAkMOwmPplahF7c9sBPIHfEP++XgqOOyRo8YpNq
 wpRUIU3NWVPkg+Xb3PLmuPLMX/OibwUNNK8kbKv2lADA5AgG5/fzEXBeEWLUspcXoOPd
 2CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706266437; x=1706871237;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NoPaxkSl2fdNYgPpynpM/9OCbrxcNrAjyr51GS3aQqk=;
 b=aEvL/4jGjmJ4EHW1BUHmHFdGD3pw3iGP+WPhYh1fsH8on/v/uK8aH9bmeyegMBDmCg
 ltjQB/Lr6Dgcis7AdGpSm7X1gF6RUTbPN9H8qUIzmYkrHFVubeUL1uySTHDIqacho0sn
 xxNF7fU6Gib5di8HZ3eXydyHZu42fMz6MNyRmuFLSymj2KykNpTWPR7+JUooS7oMcQmc
 WdvsVnE9Yuvcph4hf3a/trivW18YSImKT2LIxLz6k+AhTPO1io+UfgGzexd/pTBCyIV6
 0VXqQrcONGSamEGYykasqMoGJf4eS6tfLpC9Eq5/LhWpU49L1Mie795K7OZGw8L4Tgso
 tcvA==
X-Gm-Message-State: AOJu0YybsDZmo8pSf966lTmHh+mq7DivluAj830Z6AKVrqM+Jod9A/US
 fcNq4lx15k0ws8tIjz/265GrdhxaMV7iyHajb/jMg6sA0m8AxXIPwsE5L90dKeVbOvFrmWrI2j1
 hKm3+FesHif55/WlzpG6IGHTfxhzn+Et5E4E=
X-Google-Smtp-Source: AGHT+IEIbEGXcbiGetm2/AoQHD4GcbWUZ013T1u+7/sW9ANP198ugU2sqYOpvPfAJ5l6kco+AFVRBqIxZcisO7tQ7N0=
X-Received: by 2002:a05:6122:c88:b0:4bd:774d:d7ea with SMTP id
 ba8-20020a0561220c8800b004bd774dd7eamr605342vkb.7.1706266436988; Fri, 26 Jan
 2024 02:53:56 -0800 (PST)
MIME-Version: 1.0
From: E Shattow <lucent@gmail.com>
Date: Fri, 26 Jan 2024 02:53:45 -0800
Message-ID: <CANV2PTO9aVPxkvWp_PY+NwB+bzzNtJ211NxQLHxi_uz_1Gce4w@mail.gmail.com>
Subject: riscv defconfig starfive visionfive2 env is nowhere, missing axp15060
 regulator, misc vendor hacks for Milk-V Mars CM Lite
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

ENV_IS_NOWHERE=y when it should not be, on make
starfive_visionfive2_defconfig. I guess that riscv is forgotten in some of
the logic there. TL;DR the env is supposed to save in SPI flash as the
defconfig provides (but then also ENV_IS_NOWHERE=y appears ?  strange).

There is missing the AXP15060 power regulation in u-boot needed for SDCard
and networking. As it is happens to work for some variants and not others,
and not always. The AXP15060 driver exists in mainline Linux as a variant
of AXP20x and there are corresponding devicetree entries of the StarFive
JH7110-based VisionFive2 variants queued up (ref: *1 Patchwork series
806238). Milk-V Mars CM Lite variant ships with a hack substituting GPIO22
MIPI_PWR_EN in dts (what would be GPIO62 SDIO0_RSTN_GPIO62) as a trick to
get mmc0 doing something. I don't understand the details of why it works
just that it was there in the SDK git repo change log and I see results.
There's a possibility this was actually changed in how it is routed on the
Mars CM Lite PCB but I find it would be more likely this is just some kind
of hack.

^1:
https://patchwork.kernel.org/project/linux-riscv/list/?series=806238&state=%2A&archive=both

The other notable vendor Milk-V Mars hacks are to specify an eeprom 24c02
as compatible on the Mars CM Lite board instead of the 24c04 what is on the
StarFive VisionFive 2. I can't find references to this anymore in mainline
Linux, was it abstracted in some way that should be also done for u-boot?
Finally there is possibly a 2GB RAM version of the Milk-V Mars which
conflicts the StarFive VisionFive2 dts assumptions of at least 4GB RAM. I
note some adjustments to the linux,cma dts node accordingly from vendor
SDK. I failed to reproduce the vendor SDK build and this is my best guess
from that SDK git repo commit log notes.
