Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA2ECA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E409E6064B;
	Sat,  3 Oct 2026 15:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rB4aQcb6pRYQ; Sat,  3 Oct 2026 15:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1B0116063A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791040814;
	b=qQgmPS4N9/V/+rNkBV3tBtSHLQEEP8fGqgMLfkXn9IXtTWYL7GjdwS29AGpoLA+wcuwT
	 pcHKX2d2/iW1MFOlnhIiXMZJf+FvW5OIfvEm0FyKkX1yKobo4z6PtknjcHD3KVZIv7+bp
	 fb/VQ48Ez6qe0Vk4gglVR8dr9g6/RyoSK/dger0+i4xNchm3SuO7oiLhr4w1XS5fdBWRF
	 aXAj5fHQ1m414HGtv7tjVwEzO6jsz/DchykLj4PclXwtadZNM7G27HJ/RVTV52avGtTnA
	 H2gUSPQZrabW3N+OBbfxi5yvxs9s38W5Gfy+fElmHDyBMI4JqOgmoxCYfskGXazg9yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791040814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gzoemOYGTgVfuQP9BFQESUVLPWiS0tjOIQHI+E4Y7x0=;
	b=g26MaAg1KD0ic3oCMK/NcEa3U3govYuI3beVsbJwmiVh7CpYEpRJ12LlN+qKhD/Oa5Wv
	 8PXZTWPJUb8fl/WzVXoe+xkWUNW+ieWvqjVhB6EJKyObVLFMN8buERM+6/5kqc2tIRIFr
	 H+T6pSjBrtowQftTRCximUIRSDH20BPiarhzPdVmMnIRakt1QdRCACEYVX/jNJ/y1NmCi
	 bsh3lv9EFm98/Rhg/ATjJlpNFJbi74801AcqAMmuKsuz/32Ow16ysB1/zvMKtFNqZ7sAF
	 U6bv2iXOa92QQlMHi6+pWA2Gzm7H/ht0GqdXhtBMIdejiJwmiRw+JlbJnBilNoWJ3Aw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791040814;
	bh=gzoemOYGTgVfuQP9BFQESUVLPWiS0tjOIQHI+E4Y7x0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OZOpVyKr+NGWzko6ykD4gvQc2EI3c5ifiLUGbUG+n0PmcugOAPsq8r7eLYWXsrXiW
	 ymXe+u5/alW3TwmQkJZyvZqyEqPB3q7RfbgKmgrCLRNm13+IQw1gawaZna2LBUUGu5
	 DrDzPnbwiLPW7/5nI0rJU2zMGpCG35Cn8iiuH4C0WueZwpStTKwAQTYIULoDqmH4xL
	 rTGMv5+3xlwht5Wwxymw/j7rUBJq4V7JvPAmcAKYw+hCn2sAcB1pK7dy4pk3ihFtAu
	 yimuvKJ+DcQv1E9R6j5pRFOBprOIWUOWsFH+ZpZDzqWd0T1HwHofagTLcn2Ej04kXy
	 CHhIctEMZzlJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B0116063A;
	Sat,  3 Oct 2026 15:20:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 892602E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBCC8400D2
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fqWAe6YpaW2 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:45:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D6E9940024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791038717;
 b=AhieQbhehAYMLmeTQKDhhAL8pevHiAZsF+e4A90DBjN4FXU3it/x6pKtkVN1U6b4RtA3
 ZJU2FBv6Ti6OnKWaTv6pT8xQw9Eq24xEJ20hjDD3apTLI9En3Opa63wZCjZ0Z+UyCFalT
 m53PKHeCUwZJILqPNPoAOhGY7NqkBYYTaeT9i0rDvDNjSRu6h5G6yIs1/Gpt0TtPhXVpP
 FQODFLtU9Chkn3lktmzwrNhnym+o5rpfjkf9iMBB38+6RsM2xwaDkYS5V5hmRxiobUxlj
 r/eF3eIgkK6M/QzNtpdQlKTnIk9tFyWzFf9NlXxm+cHGEXcT1q9N9H3RHqz5bBx2Wtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791038717;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=gzoemOYGTgVfuQP9BFQESUVLPWiS0tjOIQHI+E4Y7x0=;
 b=SkLQ0ld9gS2DcNliYcHlrt8Dwfs4IgQ2FGtyc5Uzr4tiFu52y4mBUF5HtGvB4oWnp9r0
 sa8VgNDJDbVFG7MsmN93jr6Dtp5eynV2XTwE8Wuz79LH3UW7NCtVZ6DP61x/zGrf1xstt
 i0zSQ00xpKlIRp0Y99121GJpnRgefX4zmYPI0mE6GhgElbup5pzRjgeNxoAAsA74hc5uJ
 y/P2zFEAhB9bw++C51neNW7QsFlAvrPXFQKB6+930c5Oye0IPraV3P3PuvqSqst5lB9Ku
 qwIBKThiMg2GjqIerco8t/baotRn00bvJsuCj5y/pRaG3hqpBHsIPROl2Bqkam8uA9w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LKB0x+xW; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LKB0x+xW
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6E9940024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:14 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so3945265e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791038713; x=1791643513;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gzoemOYGTgVfuQP9BFQESUVLPWiS0tjOIQHI+E4Y7x0=;
 b=LKB0x+xWCLwLRK6UFgjaKpe5Wt4Tsb4jBQSk0UsF3cujoFwsDPpGyxACr8VpAJK5KH
 GPABJUJldIrv0V2xrSg/QxnNN2pCOxcL3AoEthO08SxiKrWduuwQ1gr7rNg80OaUKm6m
 GKq+WpOb7/3Am1X3WgAXTtpbJXq7hesMBPFxSVvj/Qly6JmJDwLFpFa8SnG+au2+TZfs
 2C5kRjgftSR3qIZl4QrPPQPRQvBI2RPRtxrYfaf1/xk1vWLWR9cmhmYnfg39olFQhZSp
 1idx1uXc4fjLchOqSDuD9rTxg6rTsMDlF3h8TugUO67YI5qGLI1iBUivrAMXq+8QUv20
 hSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791038713; x=1791643513;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gzoemOYGTgVfuQP9BFQESUVLPWiS0tjOIQHI+E4Y7x0=;
 b=ElspXYBN96+oWfqubo04s2YGMMMb44ruY6/fKZR+ff7Dc9XyhrNp2lo2IwbEjYYlWL
 siRi18vetwof8ImGGcZMmyw/O19OZ7HMsglLWM3VjTIYoyIfUl2HwDaMzwndZJ4YVlkL
 OODx/qBmX6stn1CRnBLfzeR3DR+ZBEvJ/vXsDLa8vPvHeWqbWvA3viUnyIApa5EBTeOe
 Wb8+VIb8l9cdjOf/7z7qs/mSjLNlawmD8ZAO19J2MTJKx0MPa9SteL/Fcu2IYjMXQx2n
 UtNGvQ1bHyYndVci5ZmVlckECt1KBTEvwuTctqGvqCBmW5zUuNDMZc7cb+G3B1VSq8AU
 Lcpg==
X-Gm-Message-State: AFuF++kpMjlohvXal+eQ9A7TbM79GAX8vVyTeSNoZRIdm335y3U1cAJZ
 k+Fcd/SKESbk9j+Gr7YahWxZln8+WU02srJYTRmgxwQ7JnJwOt2LbEKqYXab/A==
X-Gm-Gg: AYBFou1MWEvrYT2nGDvw5nv+AdTqaohf6VlNoUJ4oxZEG+ybgYfnKHbSp6zUiZ9/zXP
 46hax+IWK3KpWvH/S8p61Z6qQ2pTXuxrwFxjPfXw/ENkDwwEsE798wBPdRiJizp8WWmQdZq04HN
 hJ/kFfmIMysiXkPHZJoFay/4/bO6iW0TK4Mu/b0t2o7/x2jpHLMdpu6QMIQy1U9cLZ91jxG4fE8
 QojXE+8877Lc4qMsATfqUnRj0LHnpPymI6S9vJbL2NIW/Z/H158R9QCX65ZynkhAlzFUyWpVzk2
 mOyhjHkBKsssF/ff+OVQmvyhmmA1iANoTFDthSV0tBjh+vehFwrUPLltP+BTjlpxHH74sRfACQ8
 s9quvObzJJZauIQdovM4t7BRba/HfTUtlDHgRaQ5An0KUCyOsBXxak8kot8D+D8TpJp4aIjyxAi
 1EXin1BM60LC2SFPi6lc0s+LF2m0HUtupPff1QjWcC6Rc2iJ+Gcw2SBpsZjf0xyuBynifZASQ5V
 JipVXR4Mg0Ldgpvd7vdZN/BCINAdYgKZiJiz4DiY6aoT22HfMT4pajzKqhIt2kORg6/OXISs2x9
 ao7H
X-Received: by 2002:a05:600c:3501:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a0276b78f7mr98321235e9.34.1791038712421; 
 Sat, 03 Oct 2026 07:45:12 -0700 (PDT)
Received: from lap.lan (xdsl-31-165-251-31.adslplus.ch. [31.165.251.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm186553995e9.8.2026.10.03.07.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 07:45:11 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v7 0/3] spi: Introduce driver-model support for SPI EEPROMs
Date: Sat,  3 Oct 2026 16:45:04 +0200
Message-ID: <cover.1791038319.git.joaofl@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Oct 2026 15:20:09 +0000
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

v7 addresses Simon's review of v6 2/3 and picks up his Reviewed-by on
patches 1 and 2. Thanks, Simon.

On the status-register read in probe(): it was diagnostic, not a
presence check - and on SPI it cannot be one. There is no acknowledge,
so an unpopulated socket does not make the transfer fail; MISO just
floats and the read returns 0x00 or 0xff. The only way the read could
fail is a controller or bus-claim error, and failing probe() for that
was, as you say, too strong. probe() now ignores a failed read and only
logs the value at debug level, with a comment saying why. Any real bus
problem still surfaces on the first spi_eeprom_read().

Testing on sandbox, against unpatched v2026.10-rc5: "ut dm" runs 583
tests to rc5's 582 with an identical list of failures (all
environment/fixture related), and the new spi_eeprom test passes. The
sandbox_vpl CI selection ("vpl or test_spl") passes 12/12 on both.

Changes in v7:
- Patch 2: the status-register read in probe() is diagnostic only and
  can no longer fail probe(); comment explains why SPI cannot detect
  presence this way.
- Patch 2: fix the comment above spi_eeprom_read_status(), which
  described the return value wrongly.
- Patch 2: commit message nit, "the faster of the two".
- Patches 1 and 2: add Simon's Reviewed-by.

Changes in v6:
- Patch 3: build the sandbox SPI EEPROM emulator only in U-Boot
  proper (not in TPL/VPL/SPL), fixing the sandbox_vpl CI failure.
- Resent as a new, correctly threaded series.

Changes in v5:
- New patch 1: test/dm/sf.c now asks for the emulator attached to its
  own slave rather than the first one in UCLASS_SPI_EMUL, fixing a
  heap corruption once a second SPI emulator exists.
- Patch 2 commit message reworded: imperative mood, "driver model"
  rather than "driver mode", and it now explains the motivation.
- SPI_EEPROM_CMD_SIZE removed. Address length is an addr_len field in
  driver data, overridable from the device tree, so 8-, 16- and 24-bit
  addressed parts are handled.
- AT25_CMD_* opcodes moved to a private header,
  drivers/misc/spi_eeprom_priv.h.
- Read path no longer computes "offset + size"; probe() rejects a
  "size" that does not fit the configured address width.
- of_to_plat() dropped; geometry read in probe().
- "size", "pagesize" and "address-width" follow the in-tree atmel,at25
  binding (dts/upstream/Bindings/eeprom/at25.yaml).
- Compatible list taken from that binding, plus the "atmel,at25"
  fallback.
- Kconfig: "depends on MISC" dropped, help text expanded.
- include/spi_eeprom.h converted to kerneldoc.
- Sandbox EEPROM node in test.dts follows the binding.

Changes in v4:
- Emulator frees its backing store in a remove() method.
- Full kerneldoc for sandbox_spi_emul_get().

Changes in v3:
- Reindented with tabs; the series is now checkpatch-clean.
- Dropped the no-op write stub in favour of returning -ENOSYS.
- Removed dead code, fixed the read bounds check, corrected the
  AT25160 geometry, switched to u8 types and added a MAINTAINERS entry.
- Added the sandbox emulator and the DM test.

João Loureiro (3):
  test: dm: sf: Get the emulator attached to the flash slave
  spi: Introduce initial driver-model support for SPI EEPROMs
  sandbox: spi: Add SPI EEPROM emulator and DM test

 MAINTAINERS                    |   9 ++
 arch/sandbox/dts/test.dts      |  16 +-
 configs/sandbox_defconfig      |   1 +
 drivers/misc/Kconfig           |  15 ++
 drivers/misc/Makefile          |   2 +
 drivers/misc/spi_eeprom.c      | 266 +++++++++++++++++++++++++++++++++
 drivers/misc/spi_eeprom_emul.c | 130 ++++++++++++++++
 drivers/misc/spi_eeprom_priv.h |  18 +++
 drivers/spi/sandbox_spi.c      |  37 ++++-
 include/dm/uclass-id.h         |   1 +
 include/spi_eeprom.h           |  95 ++++++++++++
 test/dm/Makefile               |   1 +
 test/dm/sf.c                   |   9 +-
 test/dm/spi_eeprom.c           |  46 ++++++
 14 files changed, 642 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 drivers/misc/spi_eeprom_priv.h
 create mode 100644 include/spi_eeprom.h
 create mode 100644 test/dm/spi_eeprom.c


base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
-- 
2.55.0

