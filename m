Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BA1CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED6584A1E;
	Fri, 19 Jun 2026 14:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="fH0IcXH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0EB84A1E; Fri, 19 Jun 2026 14:53:27 +0200 (CEST)
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77CD08005D
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:99a0:0:640:85e0:0])
 by forward100d.mail.yandex.net (Yandex) with ESMTPS id 93AD6C009E;
 Fri, 19 Jun 2026 15:53:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id HrSguQJd9Gk0-W2hd7xuu; 
 Fri, 19 Jun 2026 15:53:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1781873602; bh=cl65vBt9vYPCTK8OUvylKBWE4KZfLB0a4Lzat7hPHO4=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=fH0IcXH+hkwjsFNow75FztsF8xuwa0Z9ZT89r9uD1Kwvg9hgwk8EtEKO6GU09kxD0
 0OVpR7vbwI0X1Rt/gbO2EPS0wGur+i/saatbXeM2hLqRbAfWn+MqGb2IH2S1miLiDv
 kP1IKIJoPHUI9UPXKOT90AAuDpjPYBoWrAFKh02g=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH RFC 0/2] RISC-V SPL: fix OpenSBI FIT loading and OS entry
 point retrieval
Date: Fri, 19 Jun 2026 15:52:56 +0300
Message-Id: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQrCMBCFr1Jm7cgktZW6EgQP4Fa6KM3EDqQ/J
 m1QSu9u6Alcfu89vrdCYC8c4JKt4DlKkHFIoA4ZtF0zvBjFJAZNuqRSVegltBHt4hxamVH6Jm3
 CMk2jn5EUU6Up15ZKSIrJs5XPrn/C436DOoWdhHn03/0yqr36zx4VEhangrVWbPKzufbNe2HL7
 tgz1Nu2/QBw44P5zwAAAA==
X-Change-ID: 20260619-riscv-full-fit-image-support-01e092032f06
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>, 
 Michael Walle <mwalle@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781873599; l=1899;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=fSn+XlixghRIr497P32EeTmZDgZeNHLreErwJ1qFG5I=;
 b=wIgjUYyYRaoz4yLc+Tr8UIUDMf6o+iSANr1tgJ3/1yJWdN3PU/PwZIb5DvVZrhX53g59/JQO4
 HX56GuQ6apVACw7xOqEm6Qh8VRfuT+Run780xaV+/gSJgAMcK410BBQ
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

Hi all !

I've recetly tried enabling CONFIG_SPL_LOAD_FIT_FULL on RISC-V and
encountered some minor issues, fixed as following:

Patch 1 adds IH_OS_OPENSBI to fit_image_load() so OpenSBI firmware
can be loaded without error.

Patch 2 fixes spl_invoke_opensbi() which currently tries to locate the
next-stage OS (U-Boot or Linux) by parsing spl_image->fdt_addr. That
FDT is device tree for next stage, not the FIT image itself. The fix
stores uboot_addr and kernel_addr in spl_image_info during loadables
phase and uses these in spl_invoke_opensbi(), falling back to FDT parsing
only if no address is stored.

Tested with FIT containing OpenSBI, U-Boot, and DTB (also kernel and
ramsidk but that's not important).

Question is - if Full FIT wasn't tested with RISC-V U-Boot SPL or i am
doing something wrong ?

Configuration is quite simple and is working without CONFIG_SPL_LOAD_FIT_FULL
just fine:

```
conf1 {
    description = "U-Boot+OpenSBI";
    fdt = "fdt1";
    firmware = "opensbi";
    loadables = "uboot";
};
```

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260619-riscv-full-fit-image-support-v1-0-545e221ed37d@maquefel.me

---
Nikita Shubin (2):
      image: fit: allow IH_OS_OPENSBI in fit_image_load()
      spl: opensbi: fix OS image address retrieval from FIT

 boot/image-fit.c         |  1 +
 common/spl/spl_fit.c     |  8 ++++++++
 common/spl/spl_opensbi.c | 33 +++++++++++++++++++--------------
 include/spl.h            |  8 ++++++++
 4 files changed, 36 insertions(+), 14 deletions(-)
---
base-commit: 922cf29dd8045f7348ce0f20145f46e8235faf21
change-id: 20260619-riscv-full-fit-image-support-01e092032f06

Best regards,
-- 
Nikita Shubin

