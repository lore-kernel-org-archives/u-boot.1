Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AB8C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DBF481117;
	Fri, 14 Aug 2026 18:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6nYYRGQTakX; Fri, 14 Aug 2026 18:39:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DC0D81118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732744;
	bh=zYcR0WWYAhCjY3Td2uH8OLZq2RGVdFnp+5n6x9ubzgA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jUtlmLtwfEPC2ZzPdLZcTlw6Ri+pvmfKRGdijxKR78kW8WLWOz+y5mVi57lqWr2Ft
	 hrEf3isSk/os5l6Y7UMsnRDVY0vrrEIZVB8yRkn0mz6/qTIUmJ/MOL9kARb8/gju42
	 Ul+V+1I7i06pJJ7+Eo6tLB1t3ExPsBfrj1wdBzo1uRJ2J0Uxx3gfDSx/J7VXVQw9ZA
	 o0KXvFF6TcYVO8+tXOFUKQrPmgdXqvfXV6mUTef4gmkHAYlN/0DNcrTKahsy4xOeCQ
	 us4v8jqC1VeJd7ObHkT2OoqN5MZ789NCq2OKqxjwepTozwIfFWRc8Kmo9AvK/e/+/a
	 DKWdYWHI+p4bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DC0D81118;
	Fri, 14 Aug 2026 18:39:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C8AD53A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA63540C9A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXrFyhLbjlcI for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B0CD940C7A
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0CD940C7A
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GxSPct5o
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0CD940C7A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:01 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-51c149c5722so9219131cf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732740; x=1787337540;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zYcR0WWYAhCjY3Td2uH8OLZq2RGVdFnp+5n6x9ubzgA=;
 b=GxSPct5o5zxlpMGOz/gT/xI9qVeWANqbpgY255vfdYj3/f7hEYVEac9AUBaHcJuJ7O
 1QcL9IYkPVxMJaOZWwMeOuz+exKUP8WXGSmej+Ru0LTYhyTdqo8eKGXd+8tAjExBgh/c
 WwLFVqOpbLPHDJMZIov+DysQM5dTXItNtOFkaKuQSZu4JicPI3zeYCBp3EmosddEAH05
 6gQMz6qZwMJQf6Vono30a/tihXMcnd5p4dmhvZqDHVfWNwdq9Iuk+0yC+fABo9tQUpcY
 hD5lj6Smvv7rn6V/6xuxor5zos245QFUfHoYIiO4L3Bwo3V/zm5pUmkIAmFuv/lDb3DU
 ZTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732740; x=1787337540;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zYcR0WWYAhCjY3Td2uH8OLZq2RGVdFnp+5n6x9ubzgA=;
 b=Jr/ZoiymJtV1mFbPY/2Rlo5Vz0w0l/KxzIx20QLnXp9JHumFOMgxD+aCGKSaPjWkwT
 jg/Tzg6xjoRZWqJezRLlx6DltXb98j4R0A+U1rvBOTp/3lnKdySVWH9cr6QEaGt5kBJC
 OCuZpM8/MkqWLGLoefnqWD677yIiOE4RsGKoKtBHCZkbHrtcgoV7Tn5EX6tuUSHchU5P
 3Hvx0aaf3Aoy2g0b95/xR+upDtfbkqs6IacWufaQZN/K14HuSCJ33qRV9+BaWiyHw8UF
 vfZqrESuAAAjUSMoW5L/WeM0/oPe0sR83tE36gOv1EW4IN5+tI5Tu8tVXcvCxMEGOWmo
 5irw==
X-Gm-Message-State: AOJu0Yzk7CDAB9FY96RljpD7ms5yTeBddu93Hpf77Bm2eUCzz87nVREy
 w3WszBeTYf8L75NpSo9t1h0PoeajV7eos6y0iHMVois/BUkCWs/xlUOcKFMSWXrX6n2scQ80DYy
 iwYa2P6I=
X-Gm-Gg: AR+sD13Nag/mzRz9+DNwR0Euxw/XP+qw1ZeRy7VCHqZZ/SxH2VpgmySJ+1ogoS639Lv
 SnA05fdZY85ivri0dE05+ECqeuA/n5pvf5nNxa8FpJwbzf6PhdxbvNprjqdj82oheIPOYO4FlB3
 pe6lP/8fz5k3GiQ9E8uEv0uE+j75QEZfHFhlFUVR1SkyjabvwJ7rUUTKPBpaBPUsX5lIhA8DtIr
 JPIlo8KCDtxkdaiP5/zZ2zMX0JoCL3yrBb5x7zCSMirWVFCHwds9gaHax+ggWHeGnZcqpgAQyys
 STcEsW5OoUxaTJd7RcNjsQb2TEMNCOvprbbYVW5mH4PoM7NAw/f33XM1wOooVHXXdbP0nwpeHRL
 2PsS7yq1KgVgkKc0pmFQy4pJXxV05HHW1f7w9cavJrZTPVNEe8Av5KuHkyEcKj76CE7IxOAqQlY
 +yHpWb5K0v0qJKnHD7j7CkO1GOKj5fbfGKlq02pW6hP6ZsagRcW7e25Hs2hHgU2xbsk2/GjpFlR
 rCmMJwusKoqw6I5mLwAqD5lhLpbNJL1GBK+J/PSCGzX9Ptgg6/wulT4
X-Received: by 2002:a05:622a:5813:b0:51b:9873:e37b with SMTP id
 d75a77b69052e-52d84f2199dmr99260961cf.9.1786732740208; 
 Fri, 14 Aug 2026 11:39:00 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:38:59 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v2 0/8] Renesas RZ/N1 additional drivers
Date: Fri, 14 Aug 2026 14:38:52 -0400
Message-Id: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALxgf2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ND3aKqPENdEE/X0EA31TzV0szSNCU1KSlNCailoCg1LbMCbFx0LIR
 fXJqUlZpcAjJDqbYWAJOYwG1wAAAA
X-Change-ID: 20260811-rzn1-2026-10-e7e9695debbf
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=2796;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=pt6UriWep1oC06FOPM4LHKOpA3WEpxgMEtMFJHvQEgk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK5lSKNSGrjkJKDJryCDQuVe+dNEOSA2FLSmkxd/g/O0BXvzq5ypBc5WNuBSlZtpvTkzn1v5fX4
 Jf6b+JWJKuQo=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable many more of the peripherals found on Renesas RZ/N1 SoC,
including GPIO, MMC, QSPI, NAND, Ethernet GMAC/switch/converters.

This builds on top of the basic support that was added in May 2023:
https://lists.u-boot-project.org/pipermail/u-boot/2023-May/518098.html

It has been tested on the Schneider RZ/N1 board, including support
for USB (DFU/fastboot/UMS) using the driver from Romain Gantois:
https://lists.u-boot-project.org/pipermail/u-boot/2026-July/623625.html

This patch series is based on v2026.10-rc2.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- subsystem changes were split into separate patches:
  https://lore.kernel.org/u-boot/20260814-rzn1-2026-10-pinctrl-v2-1-95dec872b1ca@linaro.org/T/#u
  https://lore.kernel.org/u-boot/20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org/T/#t
  https://lore.kernel.org/u-boot/20260814-rzn1-2026-10-gpio-v2-1-7490cc61b337@linaro.org/
  https://lore.kernel.org/u-boot/20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org/T/#t
  https://lore.kernel.org/u-boot/20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org/T/#u
  https://lore.kernel.org/u-boot/20260814-rzn1-2026-10-nand-v2-1-7aadfa5ca3d4@linaro.org/
- also depends on the USB driver from Romain Gantois:
  https://lists.u-boot-project.org/pipermail/u-boot/2026-July/623625.html

To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Udit Kumar <u-kumar1@ti.com>

---
Ralph Siemsen (8):
      board: schneider: rzn1-snarc: set serial number
      board: schneider: rzn1-snarc: add rzn1.env
      board: schneider: rzn1-snarc: update MAINTAINERS
      ARM: renesas: RZ/N1 QSPI controller features
      ARM: dts: r9a06g032: sync with upstream
      ARM: dts: r9a06g032: add QSPI controller
      ARM: dts: r9a06g032-rzn1-snarc: enable new drivers
      configs: rzn1_snarc_defconfig: enable new drivers

 arch/arm/dts/r9a06g032-rzn1-snarc.dts  | 376 ++++++++++++++++++++++++++++++++-
 arch/arm/dts/r9a06g032.dtsi            | 282 +++++++++++++++++++++++--
 arch/arm/mach-renesas/Kconfig          |   4 +
 board/schneider/rzn1-snarc/MAINTAINERS |   3 +
 board/schneider/rzn1-snarc/rzn1.c      |  25 +++
 board/schneider/rzn1-snarc/rzn1.env    |  21 ++
 configs/rzn1_snarc_defconfig           |  76 +++++++
 include/configs/rzn1-snarc.h           |   5 +
 8 files changed, 771 insertions(+), 21 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-rzn1-2026-10-e7e9695debbf

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

