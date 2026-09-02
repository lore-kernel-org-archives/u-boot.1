Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48D3C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A13EF8089E;
	Wed,  2 Sep 2026 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDVISSkLu95h; Wed,  2 Sep 2026 08:52:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339147;
	bh=/XrlnHYowlipoGQnGQwUpQiveAn9iKOYY8Gxpkwg6j0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wrs//452jXKaCT7dlkGlL8I1/sakGCLwqcpCpykG8wZFau/q4U51ZqRElWValvD7u
	 Orjf7pzMYe774DnKmVtX94Oi+UxQUflm+vjMQJnArpsLHO1yvZ6O8XgYynF1OH8EiG
	 mwzCsan7k5wWN3CpCpS2rRLhcoJ96gyGHKIhVB2yrWA4IkhLIAD9HgKMXHwCEi7tkX
	 WO4Qj23BfUqUWcXBddpigH+0e0i+P4TaWWWtB0jWbt84uGPWn/5kmucqOfkzBymSYc
	 nUT9vhYRobHmRAmNeDdLx7SKkUr4uIAYBTtTZMZ/ozepmWiPssUVdNIBX3vYAzTwDZ
	 9m3ZT7QxdgG7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C70DD808D8;
	Wed,  2 Sep 2026 08:52:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DEB0E2FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D01308089E
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9KtV1sZ7dHt for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:52:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=tim609@andestech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B223C808D8
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:52:20 +0000 (UTC)
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
 by Atcsqr.andestech.com with ESMTPS id 6828pWiZ001316
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 16:51:32 +0800 (+08)
 (envelope-from tim609@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Wed, 2 Sep
 2026 16:51:32 +0800
Received: from swlinux01 (10.0.15.55) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Sep
 2026 16:51:32 +0800
Date: Wed, 2 Sep 2026 16:51:25 +0800
From: Tim Ouyang <tim609@andestech.com>
To: Eric Chung <eric.chung@riscstar.com>
CC: <u-boot-spacemit@groups.io>, <u-boot@lists.u-boot-project.org>, Tom Rini
 <trini@konsulko.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Wei Fu <wefu@redhat.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, Yixun Lan
 <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, Alex Elder
 <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, <oyst.lnx@gmail.com>
Subject: Re: [PATCH v10 01/17] spacemit: k1: select boot device via config
 registers
Message-ID: <avkysazihbgjh2vsdad4mgw26zhj6y3pdtjbdrwghm5qko4ccg@mggxixrzezuo>
User-Agent: Mutt/2.2.12 (2023-09-09)
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
 <20260824-m4-v10-1-5e0adcb1edb9@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260824-m4-v10-1-5e0adcb1edb9@riscstar.com>
X-Originating-IP: [10.0.15.55]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs53.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 6828pWiZ001316
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

On Mon, Aug 24, 2026 at 04:50:36PM +0800, Eric Chung wrote:
> Add logic to determine the current boot device by reading the
> SoC's configuration registers, rather than using a hardcoded
> default.
>
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> ---
> v9:
> - Enhance detection on booting from SD card.
> v5:
> - Add blank lines around the switch statement.
> v2:
> - Use FIELD_GET() to parse boot strap mode.
> - Remove comments on hacking. Since the sequence between eMMC
>   and SD device is exchanged in the upstream DTS. So it isn't
>   a hacking any more.
> ---
>  board/spacemit/k1/spl.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
>
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index d749e21a2d57..b70eed14e6ed 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -13,6 +13,7 @@
>  #include <dm/device.h>
>  #include <dm/uclass.h>
>  #include <i2c.h>
> +#include <linux/bitfield.h>
>  #include <linux/ctype.h>
>  #include <linux/delay.h>
>  #include <log.h>
> @@ -22,6 +23,20 @@
>  #include <tlv_eeprom.h>
>  #include "tlv_codes.h"
>
> +/* boot mode configs */
> +#define BOOT_DEV_FLAG_REG      0xd4282d10
> +#define BOOT_PIN_SEL_REG       0xd4282c20
> +
> +#define BOOT_STRAP_MODE_OFFSET 9
> +#define BOOT_STRAP_MODE_MASK   3
> +#define BOOT_STRAP_MODE_EMMC   0
> +#define BOOT_STRAP_MODE_SPI    1
> +#define BOOT_STRAP_MODE_NAND   2
> +#define BOOT_STRAP_MODE_SD     3
> +
> +#define STORAGE_API_P_ADDR     0xc0838498
> +#define SDCARD_API_ENTRY       0xffe0a548
> +
>  #define MUX_MODE4              4
>  #define EDGE_NONE              BIT(6)
>  #define PULL_UP                        (6 << 13)       /* bit[15:13] 110 */
> @@ -46,6 +61,17 @@ typedef void (*puts_func_t)(const char *s);
>  typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
>                                puts_func_t puts);
>
> +enum board_boot_mode {
> +       BOOT_MODE_NONE = 0,
> +       BOOT_MODE_USB = 0x55a,
> +       BOOT_MODE_EMMC,
> +       BOOT_MODE_NAND,
> +       BOOT_MODE_SPI,
> +       BOOT_MODE_SD,
> +       BOOT_MODE_SHELL = 0x55f,
> +       BOOT_MODE_BOOTSTRAP,
> +};
> +
>  struct ddr_cfg {
>         u32     data_rate;
>         u32     cs_num;
> @@ -58,6 +84,69 @@ binman_sym_declare(ulong, ddr_fw, size);
>
>  char product_name[I2C_BUF_SIZE] = "k1";
>
> +u32 read_boot_mode(void)
> +{
> +       void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
> +       void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
> +       void __iomem *storage_api = (void __iomem *)STORAGE_API_P_ADDR;
> +       u32 mode, sel, ret = 0;
> +
> +       mode = readl(storage_api);
> +       if (mode == SDCARD_API_ENTRY)
> +               return BOOT_MODE_SD;
> +
> +       mode = readl(boot_dev);
> +       if (mode == BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
> +               sel = FIELD_GET(BOOT_STRAP_MODE_MASK << BOOT_STRAP_MODE_OFFSET,
> +                               readl(boot_strap));
> +               switch (sel) {
> +               case BOOT_STRAP_MODE_EMMC:
> +                       mode = BOOT_MODE_EMMC;
> +                       break;
> +               case BOOT_STRAP_MODE_NAND:
> +                       mode = BOOT_MODE_NAND;
> +                       break;
> +               case BOOT_STRAP_MODE_SPI:
> +                       mode = BOOT_MODE_SPI;
> +                       break;
> +               case BOOT_STRAP_MODE_SD:
> +               default:
> +                       mode = BOOT_MODE_SD;
> +                       break;
> +               }
> +       }
> +
> +       switch (mode) {
> +       case BOOT_MODE_EMMC:
> +               ret = BOOT_DEVICE_MMC1;
> +               break;
> +       case BOOT_MODE_NAND:
> +               ret = BOOT_DEVICE_NAND;
> +               break;
> +       case BOOT_MODE_SPI:
> +               ret = BOOT_DEVICE_SPI;
> +               break;
> +       case BOOT_MODE_USB:
> +               ret = BOOT_DEVICE_USB;
> +               break;
> +       case BOOT_MODE_SD:
> +               ret = BOOT_DEVICE_MMC2;
> +               break;
> +       default:
> +               ret = BOOT_DEVICE_MMC1;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +void write_boot_mode(u32 mode)
> +{
> +       void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
> +
> +       writel(mode, boot_dev);
> +}
> +
>  static void i2c_early_init(void)
>  {
>         struct udevice *bus;
> @@ -327,8 +416,12 @@ void nor_early_init(void)
>
>  void board_init_f(ulong dummy)
>  {
> +       u32 mode;
>         int ret;
>
> +       mode = read_boot_mode();
> +       write_boot_mode(mode);
> +
>         ret = spl_early_init();
>         if (ret)
>                 panic("spl_early_init() failed:%d\n", ret);
> @@ -354,7 +447,7 @@ void board_init_f(ulong dummy)
>
>  u32 spl_boot_device(void)
>  {
> -       return BOOT_DEVICE_SPI;
> +       return read_boot_mode();
>  }
>
>  void spl_board_init(void)

Hi Eric,

I previously said that I found no obvious issues, but after taking
another look, I noticed that read_boot_mode() is called twice: first
from board_init_f() and later from spl_boot_device().

The first call returns a BOOT_DEVICE_* value, which board_init_f()
writes back to BOOT_DEV_FLAG_REG. The second call then incorrectly
interprets that value as a BOOT_MODE_* value.

For example, BOOT_DEVICE_SPI is written as 8, which does not match
BOOT_MODE_SPI (0x55d), so the second call falls back to MMC1.

Please keep the BOOT_MODE_* and BOOT_DEVICE_* encodings separate.
Sorry for missing this in my initial review.
--
Best regards,
Tim Ouyang
