Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FE606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d0SHIVMR;
	dkim=pass (2048-bit key, unprotected) header.d=monstr-eu.20260707.gappssmtp.com header.i=@monstr-eu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dRtMeRKH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC6DC60AC4;
	Fri, 27 Nov 2026 08:38:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dD8RJQAWZhhh; Fri, 27 Nov 2026 08:38:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AD2B60AAC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795768732;
	b=h1cwHQ2R2WN3OjW+jnwCQ1uiDFssPazWTAiXJD/zOGjyjWBhTNRUElwhJJv2NP8MQ7wL
	 Iwx9fqOYIRWOKDa/fW3mOmrhsopQPqv4jzkH9rYmZs2WyYhguWDKFcTwF5KLJsdRO1o0w
	 5ak8/fDt4aXGqweUhMJx5iXLjokbiyYyVl1aM1smfQaskoA5PGAuXoMV0puf5ByNrzAwL
	 BMmEQH4e3BZ3EwVXbQWepcfBwCqKzpAiW7vyhODu+H8zFZ6t7Fzg4TWDnEYPDhVfAJA64
	 Uh+hC+5YnOaQjabsAr2AWm3cjr8Hbfe6d5OzFPmz0p1KnUAqIc30ZoaV6XfFf/jYUAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795768732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Vb53uRXmn7+i51wc+E52PKm9s+yd2ffdhze9UryJwqA=;
	b=k30IbAIBzQ27fYeGWXeCbq6S3UPGL0TtSAfZsobPxebS+kI2+ygxHyCP4aYgkLcf5qIg
	 uDWdM13Z7GDt/zIO3+E7qEMELq+QUE8cthVLIn7bn+nBg3D3QqP7EgAOrCOWPAVrS8HPx
	 w+KInXxtwqAhF2PVZMtHONNDLnew6GXNm6aG9YJfuwLRgycmVNage7VD3nJI+sgeo/zKr
	 PclQ5lV4FPg8KZ977ElZGvMtwfSwTgUPEp5NOKBlXx4dJfB1xJbcOg4XAM+KwRAuUhcSQ
	 ZLZ9wwpYfgcNmj0Jxt/pfi+zUk8g4d3plYXnrWryB0IT5LiIIwvbr2S5g2r9EJFAoEQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=monstr.eu;
	dkim=pass header.d=monstr-eu.20260707.gappssmtp.com header.i=@monstr-eu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dRtMeRKH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795768732;
	bh=Vb53uRXmn7+i51wc+E52PKm9s+yd2ffdhze9UryJwqA=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d0SHIVMRFzAkq81RSqBc6Z164KbyE2fxIvQrw+kODYyNCoNAzB09eFSwlj5yh8DSH
	 ilU1ugom87Pcq4Gd6sWRw6PDhJ5nyVs/GPAgcdGPwTxRdOYTz6UDnUJ0HTjf0ufr1C
	 DK11sayiupJ+A46sbEcfPLI++ew9UUyOpPuI+vLRyXMZZP0qH9dJbaFjdhNc8EPdWM
	 9Z28C+qnMYnfx5ja0hYB2GS71uNLC8VVVCGwCsU+CvODB96VeI7J6uETI2gDo1hviF
	 PsbJrd+KWLyr3Kp8pdibD1bR4ca3clqLezxO+qNhs5L/6b2/2HwFp2UrYdGwa33YZx
	 QHvhTe+1xK6MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AD2B60AAC;
	Fri, 27 Nov 2026 08:38:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF6A02BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1D3A60A63
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrmmzuasZJPm for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 08:38:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CFB2460AAC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20260707.gappssmtp.com
 header.i=@monstr-eu.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=dRtMeRKH
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFB2460AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:38:47 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c5133831027so1089788666b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 00:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20260707.gappssmtp.com; s=20260707; t=1795768725; x=1796373525;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vb53uRXmn7+i51wc+E52PKm9s+yd2ffdhze9UryJwqA=;
 b=dRtMeRKHNGZNZXA9FpBoUYaaeicEhOMY26O7cC8cffuZ/ytRBoVAH//Q1VAtb3NL0K
 TgHc/kyQLJo0a36y82jPOXSy5J1FFYTGSsw4MFs6+D8Tn9djnYYHXUhSFPogLHbp9hHY
 8doB5SgQ/M7+TFFio90JsNwU1QGvGrud94+fJRQ8oFPmMAlW2F6f+W0t7WvZIk1M2UtN
 lcPYcJ2T7pTwUDYQUp0iSxZLfABZCzTqHpNT7mK1Ppy0LCRrnBX4nkiyOpGbLQqohfSZ
 Bd1v6KHf6Z2dkagSO19Cv1kirxwGDxcY9bFQB4yLnD7bYmz7DMSKeuKgzXaHTez8T2dl
 FLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795768725; x=1796373525;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vb53uRXmn7+i51wc+E52PKm9s+yd2ffdhze9UryJwqA=;
 b=TcmPdLR7S0FJvlRN3NRl+haglHn3o51LDYKHm7hK7w97mxsg9z3L1ya8jsHpPbaqXp
 3JeYqSOhWMCc9wAGEJYN9iGuo8WHYo1PEwQ2qdFHw7Ie5FoP6T4q0jlWgSI1pCTMDWVf
 aWAVgLPrSYnG1jdedqL1C3Q2qWpzSCZ8zAdq5/Nc2eGYVHsASaBBCIy8pl2jiZwomBiq
 7+aSPkquWApaWNarLpSykJAAxT/AXAeVTsrQ8jqPrfit6ZRRFrANU/ORznZ7NDkddOAs
 CcAhlz2HRELmyjS7PXhQD0mh92+AeYwNiMqWCoBxmLZtQBw/5ZtYm7wqt/7Nl39tWiSG
 oYFQ==
X-Gm-Message-State: APuU4Z/f0hcIl8LS8NySdhKEpqtdnw8xIRKnqcQ1SCTpAktkrjz9zHch
 q+asRLf9DrpzrdJ1EK1n+s9DDcxaS8LeDlJEcN5YYmk3eRxEK2w3DTnfAEfES5qv9DOfatfjNfC
 SNcNzn3BW
X-Gm-Gg: AZFdTZdmZtbl88iqU/gkiUqkVdTW2nVYMwxEEvzdtq9b03gY4Dq9iHuEOilYQO/Lths
 OClEMeegPAC0S/pYTLIF1Oi4bNp/YLkwrXOfAmUf7VrGHL0O8dVIY6h/WMXK8hPQJ7dXOK8YRzx
 51WRRF7Rd8YDmGYRPUmq9vO80dfehv+xs3YkkYO8hFcqcd8nBxIEoAQldIQKiuVfI9vPrx1Tp6+
 0B5jdhM3VQ4uNgu3MRbiKW739gKpdNzmJNZNqUa7L/QqWnnKwGu4UwzloKzBb3PNQfWYhdTr6KE
 PFNNdDs5Jc7g9y39xG40RgYnWmGIjOmLPMoxdpbVnE8K5PeZgQjNy4PaAuhcNULdGzV9DjN/pGG
 nMmjfcuWUqNB/GOrTNtlAwhXNAb5YPvOeBG3Db09kxjCWZomtiAqs9YtBO2ACntsWSfxdiZWISP
 +7huSMZwrDKBHIKLg6reo+aBNg3MCPZj8X2X+8RHA2I+fWkwnxItCsEY1HZlX9H/HwcDdazJAav
 XhM04m5lZ69rHTUWb2kRN3xF/4tLBewA+ITeEztf7oro12Qj5TMfcbpwE90tGs0ih4UcrPFPTUy
 +auVCIlJs1QoDXhbc9Vw4Ki0hKv6HBpor1DJWCtoBl6c1MHVBw0JCbftgWbEuH4Gl8JD+d/t4bQ
 AFuWDVgmgBf9aWusQXFpkM2tDAK5uXCtek4qA5Q==
X-Received: by 2002:a17:906:1c08:b0:c50:95bd:e491 with SMTP id
 a640c23a62f3a-c513a84b2cfmr1459868566b.28.1795768724841; 
 Fri, 27 Nov 2026 00:38:44 -0800 (PST)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acff65bsm874397666b.4.2026.11.27.00.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 00:38:44 -0800 (PST)
Message-ID: <e0cb67af-02d7-43a3-8855-7f0403e00464@monstr.eu>
Date: Fri, 27 Nov 2026 09:38:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx/fpga patches for v2027.04-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

please pull these patches to your next branch. I can't see any issue in CI and I 
would like to get especially spi changes to next to see if concatenation support 
is causing any issue on other platforms (hopefully not).

Thanks,
Michal

The following changes since commit b7ed8d19d83d08d34b24b15c3dced7fd6c284939:

   Merge tag 'u-boot-dfu-next-20261123' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu into next 
(2026-11-23 12:28:12 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git 
tags/xilinx-for-v2027.04-rc1

for you to fetch changes up to 8f2337ca047506bea96d4b7bbe7d9940aac0e6c8:

   board: xilinx: mbv: Disable -fpic for SPL (2026-11-24 07:53:49 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2027.04-rc1

riscv/mbv:
- Disable fpic for SPL

xilinx:
- Remove CMD_NFS from all platforms

cadence_qspi:
- Fixes and improvements

mtd:
- Add virtual concatenation support

----------------------------------------------------------------
Michal Simek (2):
       xilinx: Remove CMD_NFS support on AMD/Xilinx platforms
       board: xilinx: mbv: Disable -fpic for SPL

Padmarao Begari (15):
       spi: cadence_qspi: Fix indirect write timeout
       spi: cadence_qspi: Clean up registers in init
       spi: cadence_qspi: Initialize read and write watermark registers
       spi: cadence_qspi: Enable ECO bit for higher frequencies
       spi: cadence_qspi: Write aligned byte length to ahbbase
       spi: cadence_ospi_versal: Enable the DMA DONE interrupt
       spi: cadence_ospi_versal: Remove explicit dummy cycle setting
       spi: zynqmp_gqspi: Use the device's chip select
       dm: core: Add ofnode_find_node_with_property()
       mtd: Add virtual concat support via device tree
       test: dm: nand: Probe the NAND controller in the test
       mtd: concat: Fix the lengths in the concat OOB functions
       test: dm: Add tests for MTD virtual concat
       doc: Add documentation for MTD virtual concat
       arm64: xilinx: Enable MTD virtual concat

  MAINTAINERS                              |   9 +
  arch/sandbox/dts/test.dts                |  23 +
  board/xilinx/mbv/config.mk               |   5 +
  configs/amd_versal2_virt_defconfig       |   2 +-
  configs/sandbox_defconfig                |   1 +
  configs/xilinx_versal_net_virt_defconfig |   2 +-
  configs/xilinx_versal_virt_defconfig     |   2 +-
  configs/xilinx_zynqmp_virt_defconfig     |   2 +-
  doc/usage/index.rst                      |   1 +
  doc/usage/mtd_concat.rst                 | 146 ++++++
  drivers/core/ofnode.c                    |  31 ++
  drivers/mtd/Kconfig                      |  17 +
  drivers/mtd/Makefile                     |   5 +-
  drivers/mtd/mtd_uboot.c                  |  48 +-
  drivers/mtd/mtd_virt_concat.c            | 457 ++++++++++++++++
  drivers/mtd/mtdconcat.c                  |   5 +-
  drivers/mtd/mtdcore.c                    |  12 +
  drivers/mtd/mtdpart.c                    |  17 +
  drivers/spi/cadence_ospi_versal.c        |  24 +-
  drivers/spi/cadence_qspi.h               |  19 +
  drivers/spi/cadence_qspi_apb.c           |  82 ++-
  drivers/spi/zynqmp_gqspi.c               |   6 +-
  include/dm/ofnode.h                      |  23 +
  include/linux/mtd/concat.h               |  86 +++-
  test/dm/Makefile                         |   1 +
  test/dm/mtd_concat.c                     | 543 ++++++++++++++++++++
  test/dm/nand.c                           |  10 +
  test/dm/ofnode.c                         |  55 ++
  28 files changed, 1608 insertions(+), 26 deletions(-)
  create mode 100644 board/xilinx/mbv/config.mk
  create mode 100644 doc/usage/mtd_concat.rst
  create mode 100644 drivers/mtd/mtd_virt_concat.c
  create mode 100644 test/dm/mtd_concat.c

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
