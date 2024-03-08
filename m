Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADF1C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3234887EDB;
	Fri,  8 Mar 2024 18:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XjCxj7nN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD0787EEB; Fri,  8 Mar 2024 18:13:11 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7196C87E96
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3IUfrZQYKBpIxwD9wE2AA270.yA8G-xAAF74EFE.z09J.z0@flex--barnas.bounces.google.com
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc74ac7d015so3029479276.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709917986; x=1710522786; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=AsSTtdBfjV4yvyFqJRoIy3u+GFLzKdOpYiHEt7kl2/M=;
 b=XjCxj7nNA4Em/rwrsOjgvBFBo+BWiNyUk8aCPyhqbjgz+WLW1vf9eYsVxHVf/EqX2j
 oh2+OICZclwPsIp7NZPp69/tXuHu8WgCKYIbxws0z+VLR3/c3NRq7C/DRgft6j9j4etb
 /rEFywL9C8/2DhDUGx+s6RmDqi58b/BkqViL0WbFDUFMeBEZxmnzV9TdrXwghPTdE+bu
 NpvDllh+k8UgpRbLAM1lRVaMKaa9Bri5jcWivPm51d4GqsoGG+tZj/Y207KxgNevbqMo
 GX27wb1RWdwa9ufj0kz9XaEEGG8hmpajzyaQdtRu/YY7vnm4w+8PXg0+8p00jNuG2QIp
 cQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709917986; x=1710522786;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AsSTtdBfjV4yvyFqJRoIy3u+GFLzKdOpYiHEt7kl2/M=;
 b=rX6GiqgTnCemLC3eZtA6DD7EilLx3YwirrlUjEoqTXmkzfQ9GWQlELDwd1uDvt+EsG
 PvEJ8OKeKlAuJxQFgShlw6J5io2/99Je/yLQthzV51+1IiKJwM7xul3SJ8uE78Fb3h0H
 ISP5HsRgKNIfWW07Xr529v59EHPEg9IswPrYkILYzbbSEFdxiX51VtlX+QMEO4TNAIUO
 a37350HRlaYnREd1FIGJIoXatURsQ5QW3O0rlfn4m2044czU0iakrd1DjUmPYMvBM8k0
 DM5X8vJJoP3vxb1nAOqRXEPm/AWWSMRAF1IBkoUQ69r2NOT2whZMFT9Shw5pB2c5G6Te
 +WMw==
X-Gm-Message-State: AOJu0YwVxl3phvkrdzUZAxBJsGDN51mGgR29KurSMUWBOwcBO059JElD
 JKCgP7SyzfzcqTYxq9h5nFjP039aAv9Arc43jMrMdLJ1AXA2bJLGSOoB4+xbpOYDt6Hj/epHBBk
 e3AeTfkG1hZPPlx5KvSTBFlq6hLyw5OezdqfehXDASNBAw91si5vzXKSt7faYSbFJzM389bWkbW
 TqJjcXdWb1EBAR3hB/QC7fwDztps7hEg==
X-Google-Smtp-Source: AGHT+IH6T6udu0F7cG+VqEKZ7N9MnvJAEeJLRs764eSbKgQydj+B/Sv/9hMkT/nb19d+8z87TQlL172krLw=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:6902:1549:b0:dc6:e647:3fae with SMTP id
 r9-20020a056902154900b00dc6e6473faemr968857ybu.2.1709917985845; Fri, 08 Mar
 2024 09:13:05 -0800 (PST)
Date: Fri,  8 Mar 2024 17:12:46 +0000
In-Reply-To: <6a69588a-7c50-425a-af7f-96caff727113@kernel.org>
Mime-Version: 1.0
References: <6a69588a-7c50-425a-af7f-96caff727113@kernel.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308171251.106144-1-barnas@google.com>
Subject: [PATCH v2 0/2] arm: socfpga: arria10: allow to reprogram FPGA with
 warm reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Dinh Nguyen <dinguyen@kernel.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <pan@semihalf.com>,
 Simon Glass <sjg@chromium.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 08 Mar 2024 18:37:36 +0100
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


By default, the board requires power cycle (cold boot) to program the
FPGA with bitstream. This change adds Kconfig that allows to enable
reprogramming the FPGA with every boot. This makes the update process
of the bitstream on the filesystem to be applied with simple system
reboot.

Changes in v2:
- Rebase on current master branch

Micha=C5=82 Barna=C5=9B (2):
  arm: socfpga: arria10: add option to reprogram the FPGA every reboot
  chameleonv3: set in defconfig for FPGA to reprogram every reboot

 arch/arm/mach-socfpga/Kconfig         | 8 ++++++++
 arch/arm/mach-socfpga/spl_a10.c       | 8 ++++++++
 configs/socfpga_chameleonv3_defconfig | 1 +
 3 files changed, 17 insertions(+)

--=20
2.44.0.278.ge034bb2e1d-goog

