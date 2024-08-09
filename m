Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078B0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 14:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B3F88BC4;
	Fri,  9 Aug 2024 16:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723212605;
	bh=a3f/K8x1A0URoBIM78Sylwg3/J35BBMtwMuunC95GCw=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=S93gh1wChP0DVx5UdB4T1ZV/h+is1K2TmdBQQiN101ID5VDhU636zpjhiMuYa0Orw
	 wglUSg3CJxKrldw9m4tIKh1LME0oCKfHVwkPN2plh9I31HRA0ScGkXCKJlwjZxiviQ
	 FLtMNjClJCe41HQVqEgjDBjXCj72n9VQb3hjeMEsBBmLOQRRuI7Q2M8+nd/DZsfN+B
	 adIjXvddX5gttIlcKldydsju4ayW/KCpotGjX3jVtjcTcwhpdi8VwTzUDqhuCBNnWi
	 +IRjtx32120odiEsjX1YRoCw54Qb9Vd1ZIyJ3Hr2sMEsxT98f58Cf2fhAKJurz924l
	 av9ZlVn7Ux4mQ==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 40ED088B99;
 Fri,  9 Aug 2024 16:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723212603;
 bh=a3f/K8x1A0URoBIM78Sylwg3/J35BBMtwMuunC95GCw=;
 h=Date:To:Cc:Reply-To:From:Subject:From;
 b=KRc3Aal34cgHEHJDH0ScJmQrR/k00LpbJbGk54bTTPbI1DgScmEPwIVQ8z3QLM78q
 Re2HOFXuIcsDeiip1eoFPqOPghT86lqrzLNTabfSiZpJT7BuKxnQWFDeHYWzi0TilC
 8IPx936lNIR3zSyoDtz/MFywm88CwdiW/FOySDF99SwJmeCBPPJ137gd9ncuB5lNuE
 H9RdwW3zyBtEDEMfW8ZX4j+NbOFZHsKvU19emLN7WcAseN/RkG1AvGTsMcYme9UsSj
 p+l/KwQ7ip3CF1NJFn+EFKjPPEqlET6iobGciUBAgpWGQDlf+GVxOgmXCfeiZixiWw
 16WFoxTcDZSvA==
Message-ID: <9152974c-7022-1db7-19ed-9576b88d3630@denx.de>
Date: Fri, 9 Aug 2024 16:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c next
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

please pull from u-boot-i2c next

The following changes since commit 2078abaf00b63fc4f70f8a599b61a476e22352f3:

   Merge patch series "alist: Implement a pointer list / array of structs" (2024-08-07 08:51:25 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cupdates-for-v2024-10-next

for you to fetch changes up to b08ee931ba55cf6196faf7f9d0613e325971f31f:

   board: vining_2000: convert to DM_I2C (2024-08-09 06:27:27 +0200)

----------------------------------------------------------------
i2c updates for v2024.10 next

- DM_I2C conversion for some remaining boards
   from Anatolij

----------------------------------------------------------------
Anatolij Gustschin (10):
       board: shc: convert to DM_I2C
       board: chiliboard: convert to DM_I2C
       board: cm-t43: convert to DM_I2C
       board: igep003x: convert to DM_I2C
       board: sl50: convert to DM_I2C
       board: rut: convert to DM_I2C
       board: novena: convert to DM_I2C
       board: vf610twr: convert to DM_I2C
       board: cm_fx6: convert to DM_I2C
       board: vining_2000: convert to DM_I2C

  board/bosch/shc/board.c                 |  22 +++++++++++-----------
  board/compulab/cm_fx6/cm_fx6.c          |   3 ++-
  board/compulab/cm_t43/cm_t43.c          |   2 --
  board/compulab/common/Makefile          |   8 +++++++-
  board/compulab/common/eeprom.c          |  14 +++++---------
  board/compulab/common/eeprom.h          |   2 +-
  board/kosagi/novena/novena.c            |  10 +++++-----
  board/kosagi/novena/video.c             | 140 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
  board/softing/vining_2000/vining_2000.c |  25 -------------------------
  configs/am335x_igep003x_defconfig       |   2 +-
  configs/am335x_shc_defconfig            |   4 +++-
  configs/am335x_shc_ict_defconfig        |   4 +++-
  configs/am335x_shc_netboot_defconfig    |   4 +++-
  configs/am335x_shc_sdboot_defconfig     |   4 +++-
  configs/am335x_sl50_defconfig           |   2 +-
  configs/chiliboard_defconfig            |   2 +-
  configs/cm_fx6_defconfig                |   2 +-
  configs/cm_t43_defconfig                |   3 ++-
  configs/novena_defconfig                |   2 +-
  configs/rut_defconfig                   |   2 +-
  configs/vf610twr_defconfig              |   2 +-
  configs/vf610twr_nand_defconfig         |   2 +-
  configs/vining_2000_defconfig           |   2 +-
  23 files changed, 129 insertions(+), 134 deletions(-)

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=118&view=results

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
