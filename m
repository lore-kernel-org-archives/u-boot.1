Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0F6CA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 20:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A70781FEE;
	Wed, 20 Aug 2025 22:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h4uQs5G5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s4jDtEYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4071682B07; Wed, 20 Aug 2025 22:59:12 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24BB3801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 22:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c6f2N6Q2Fz9vMV;
 Wed, 20 Aug 2025 22:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755723548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SakPdjbwlTFA62uulmMuLdbIgHAG9KWu8ZU7v+ZcCvo=;
 b=h4uQs5G5RD+ZHm5TYWQ9r5AZNbTxAVusODRIEn9vvYx6BGmifg9AwXigasGPL9RZBMl43D
 RV33vuydik1A3lRov//SHZwSjUabYdEujqPWb18Kvh1Snh55rIpF2UOPDAV3KqLQxU5dOK
 YGeieHYc5MelmXEMyP21vddM6lDpQ9zhCzwEt4AbDEjz4gExrgIVRYMjdVU6ARhV82XvTa
 b4Gb6PwIRgnyHlQAQpKhysEToBOkDgJ2IkYSFfYEI4zmOrlCT5JHajYsMhainR510NOg16
 +dUg10Fr7yAAS1NgX19mvIE8ru5ilCzuN04ROBSc+gv5r+KKs8nkzkBOdBPfkg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=s4jDtEYA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5046fa19-eab6-47fc-a740-d8f3268070f2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755723547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SakPdjbwlTFA62uulmMuLdbIgHAG9KWu8ZU7v+ZcCvo=;
 b=s4jDtEYAtsPxANdputsukQyvivgoDZlhcVnO9zv/2JPUX3BKmI+mQSd2AMB20G5Aq4oU9J
 B0+aF82E8grrhDBE+lX9cPahtBR+eGTv/Cw3SapVSig4HWwMogsWh6+9Gzsske0APfs1ii
 QlxKfDQNFsaPLtsEIFHU/Igy1jBWVYGP3ZwiDJwYiHJXxthBQ4GcsShcXTlTiv81jjYTka
 FGtXhMHZlRUUu2rQ7phNzYU5ipPPJFBNgz6VLuzD4bqIvSzljjrBcL6PQ2ZN9S/PT3Ci5p
 B1Me5Hw4olFo8q0UQezHJ0kE2htC0oJPHtvTa5RRJTAbQErTFXXLe+tkeK/ZcA==
Date: Wed, 20 Aug 2025 22:59:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8267be66b7758ca2250
X-MBO-RS-META: icxfadbhznxr6ip9n9rnmkp3fszs5bdf
X-Rspamd-Queue-Id: 4c6f2N6Q2Fz9vMV
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

On 8/19/25 4:25 PM, Michal Simek wrote:
[...]

> ZynqMP> mtd read "U-Boot storage variables" 1000

It would be better to spray the 0x1000 area with pattern first, 
otherwise, if the 'mtd read' fails, such failure might go undetected.

> Reading 131072 byte(s) at offset 0x00000000
> ZynqMP> md 1000
> 00001000: ffffffff ffffffff ffffffff ffffffff  ................
> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
> 00001020: ffffffff ffffffff ffffffff ffffffff  ................

[...]

> ZynqMP> savee

"env save" is the modern equivalent.

> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2200000
> done
> Valid environment: 2
> OK
> ZynqMP> mtd read "U-Boot storage variables" 1000
> Reading 131072 byte(s) at offset 0x00000000

This here looks odd:
- Where is the "offset 2200000" print coming from ?
- The valid environment is indicated to be 2 , shouldn't that be 1
   (primary copy = 1, redundant copy = 2) ?
- The dump of what looks like primary copy also seems valid, so
   shouldn't Valid environment be 1 (see previous bullet)

> ZynqMP> md 1000
> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
> ZynqMP> mtd read "U-Boot storage variables backup" 1000
> Reading 131072 byte(s) at offset 0x00000000
> ZynqMP> md 1000
> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
> ZynqMP> savee
> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2200000
> done
> Valid environment: 1
> OK
> ZynqMP> mtd read "U-Boot storage variables" 1000

This behavior here looks correct .

> Reading 131072 byte(s) at offset 0x00000000
> ZynqMP> md 1000
> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
> ZynqMP> mtd read "U-Boot storage variables backup" 1000
> Reading 131072 byte(s) at offset 0x00000000
> ZynqMP> md 1000
> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
> ZynqMP> savee
> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2220000
> done
> Valid environment: 2
> OK
> ZynqMP> savee
> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2200000
> done
> Valid environment: 1
It would be good to validate that both copies of the env are actually 
written where they are supposed to be written . This part is missing 
from this test. And in fact -- it would be good if this fix did have a 
proper test .
