Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E388C83F27
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 09:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C85833C8;
	Sat, 19 Jul 2025 11:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752918822;
	bh=/uArhr3XlYlKkRrdSboqKGm3xgyFfkeRe9Z+pGaASec=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=RgJ1b3LWpzer0IIenByf00pxQ1SZ6sNcXDB8aDS3k0lQ0f9iU7IbF7s/OZNR6+bVq
	 AYEkqYIKerI+kWe5fyQ4Wfp2kJezqoBANZ5UbwJIAcLsQlSUysZdIdLhkdtqyTJYRI
	 o9dYxBifIWa0nmM2T8P+avh3/YgaYcvNH3vZOAuC0owfhLiPy/u7MsatwfDddTut/7
	 Xth1/vgb0cYr8D97VIbGl7iUs5JKE3qd9eeRFSU5l3Db+awuzN5z3i1RefYa3ZewxR
	 h6NiLI0tqRBGnmDULN1GdqIPNxJWMwyCjfKhGWOftn/fD4zIa7nnwSzGQGR5cejMXg
	 VSiw3n7P6XzoQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18AB833ED; Sat, 19 Jul 2025 11:53:40 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84953833AD
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 11:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aLh7M+F3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B363F103AF666; 
 Sat, 19 Jul 2025 11:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752918817;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=/uArhr3XlYlKkRrdSboqKGm3xgyFfkeRe9Z+pGaASec=;
 b=aLh7M+F3gMxA6GjJSX55aH9/GNE1YdbPWotBhURfpO/lmRM4aIHLwlGfnvSKOAk3SnMs+d
 ho/9HPrPQ8OK33+0ne4YVINJH+xNW8SM6qBebrTOcO0FpTgkxzrm/gjXXyhxEJG6gVSX3/
 zKV+8JQMCD2+NtgEh9xKjy1V03A/2U8MtFkoPPIoFlorWKQ+qv2w5FZ0BepNKun0tYC0Fg
 +qNacePsS7Io7FK0hB4gUwQGuOYfmXsmC8f0a2qZXhDf/wFYl5DYal/+mc11Og6jlQdcmz
 wiy74jGjeWa8MDREzpQUiwDHEjBK4f+aEC+NZejI5aIbUU9JPmJDD4TstGMJeA==
Message-ID: <fd74ef18-ae9f-7650-cb08-98f090c05a3a@denx.de>
Date: Sat, 19 Jul 2025 11:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Frank Wunderlich <linux@fw-web.de>, Padmarao Begari
 <padmarao.begari@amd.com>, Holger Brunck <holger.brunck@hitachienergy.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

The following changes since commit 53bd87651e45b32efa398dd5e433d8b93d781445:

   block: sandbox: Add support for SYS_64BIT_LBA (2025-07-11 11:33:25 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-for-2025.10-take2

for you to fetch changes up to 070c48fdb648716682cc7db8887856ce4d247a9a:

   cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with DM_I2C (2025-07-16 09:21:03 +0200)

----------------------------------------------------------------
i2c updates for v2025.10

- i2c Kconfig updates from Tom
   - add some driver dependencies
   - added missing include delay.h in iproc_i2c.c

- i2c: muxes: Add PCA9541 i2c arbitrator driver
   from Padmarao Begari

- pca954x: add pca9545 support
   from Frank Wunderlich

- cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with DM_I2C
   From Holger Brunck

----------------------------------------------------------------
Frank Wunderlich (1):
       i2c: muxes: pca954x: add pca9545 support

Holger Brunck (1):
       cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with DM_I2C

Padmarao Begari (1):
       i2c: muxes: Add PCA9541 i2c arbitrator driver

Tom Rini (2):
       i2c: Add missing <linux/delay.h> to iproc_i2c.c
       i2c: Kconfig: Tighten some i2c driver dependencies

  cmd/i2c.c                   |   6 ++--
  drivers/i2c/Kconfig         |  11 ++++--
  drivers/i2c/iproc_i2c.c     |   1 +
  drivers/i2c/muxes/Kconfig   |   7 ++++
  drivers/i2c/muxes/Makefile  |   1 +
  drivers/i2c/muxes/pca9541.c | 297 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/i2c/muxes/pca954x.c |   6 ++++
  7 files changed, 323 insertions(+), 6 deletions(-)
  create mode 100644 drivers/i2c/muxes/pca9541.c

Azure build is now fine!

https://dev.azure.com/hs0298/hs/_build/results?buildId=182&view=results

and gitlab CI pipeline, is fine too:

https://source.denx.de/u-boot/custodians/u-boot-i2c/-/pipelines/27120

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
