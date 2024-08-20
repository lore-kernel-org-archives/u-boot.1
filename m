Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492D5C531DC
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 12:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAE688A21;
	Tue, 20 Aug 2024 14:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tQCygi1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C65888A21; Tue, 20 Aug 2024 14:14:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19DED8657F
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 14:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1724156048; x=1724760848; i=xypron.glpk@gmx.de;
 bh=C9m9q7OEZ8/Thal5MeAkiQsytnBFVBG3HxSxJvlVLlk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tQCygi1xZAUNhE7CGDtGtWtnUrH2PKZiSbAP7I+owdnwUhu/DS8bA7OYHk+plETd
 5vuvjKnpBT0gQxOeT4e1JgMLwoN5fBcbPV0giACFvv403yFqmyM7MCqYkAi0KImS+
 wl4W4crSZtPiefdaF1o82MtE9kQh5XGU8X1lpHM0mlVbJfLWWZSSQGASm6VJizPTG
 HEu4h/GjfGrUcmhzRyFenZUD8g9e1HJfE3A8y6725Zuxf5oDxabrgLoqccKOlan4f
 RjX9Bwhw5ZnpjDYJMnK1fPqH+zYxHYkYY2WAyr1zE+SYF4G9a59xv/SLFaG7mk2wU
 bKiTX2DSr4gutS15GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([46.114.216.77]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1sGyZI1DES-00i7bx; Tue, 20
 Aug 2024 14:14:08 +0200
Message-ID: <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
Date: Tue, 20 Aug 2024 14:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] riscv: cache: Add CBO instructions
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-3-mchitale@ventanamicro.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240820093800.5436-3-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tQsGRYDzYmtXJcTdyZCUnHjXAqExaHaTcuRdtcM2ywjyupqTDeV
 bMEIPahsPLqLby6mIdoblyxqrSvHtCIjKRGtOJNUFstdSZLAZ6zlreEhbUbfEA6P5fRmklt
 3XZPZ8hE5FrEwLl+9JiUqlTo9e9MviWxXZ6BCTpo+jJMD78mIrKhpkJ6z1xgQlE7rCqUme/
 n3I66shCDW5wEOPw/YYzQ==
UI-OutboundReport: notjunk:1;M01:P0:GCAWHpqhuiI=;0apGW6ppTJmiwkWMvN8+2tgjxbo
 1FSUMOba+f8YrZKcepvLEotk2RtusbFYRbVMaOEtEWIQ7CvvD0vlkhxPlH1dIrqYgNSWwV6Di
 QMQFdp3POa5NHFlW0PzIf3k1MnHYeb6iQs/WX9NgIe/VmdXPbrTxv2xaYpR86PX/sPQPdsi/s
 UwEz6vT9Bw2EwOpKawl93WLmt9DVl8PasGxmCRENO7yl83TaoE8OD/E6H8qVu7p1oXDK0R1bK
 PWVMqkgpxiOElkseruX9MGqw+ior3ww/XATIvk8Xc+ZjqM0M9v4mzll0wUJkO39KJCDmDLjo7
 jF+xolfujTOXKTkqaIf4/bCXfAibZdPGdYDCnyjFyD3sy1TBb8BKJrw68PeFmXO3Pi5hiNP4q
 qURwyrzsHsruodoxNnFbo5LMhZ9dX9+S05Buh7jfQrjD5TWvc3BvVYo0v5thwJUtLq8mMRYMA
 wmkYVbN0Qkos4tt9AGZlrUvv2mGFdPyqWLQeB9bAZnZFAfMGZcXrSWGacXWBtBzawQ4Cgiyk2
 aU8IQ699gJe0gxQZQKpgusykIXwAgj9KH3RzSErWq63+baJh+PVuS9My2DakaNxdYrkLfx+R8
 yfPn6orYmOPla/WQXSrsWABW8ADh1qDvt9vFaz81Ppc8J80GHqWNoduMkUFIq+i+2mDlVoQZ/
 HwOvz4jYsQ8LkuMmI92NR2DTbP2Qi/61ZDZmpCzqjE+BZZtLDMKCu4Ev4viWO/pnCIKiHPdZr
 wOA/sJRmFpS9OnvvOog/q10CLGVtTnKJ/eZJi78Z/lKm8f0Tt0PM6J5Ka/M7NF3Dfc4ET1yMu
 LFy7SS0JGkBAkkxYOT0WmTRw==
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

On 20.08.24 11:37, Mayuresh Chitale wrote:
> Define CBO inval and flush instructions and use those for the
> dcache inval and flush operations respectively.
>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   arch/riscv/Kconfig             |  4 ++
>   arch/riscv/include/asm/cache.h |  3 ++
>   arch/riscv/lib/cache.c         | 90 ++++++++++++++++++++++++++++++++++
>   3 files changed, 97 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa3b016c52..0f89d07be7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -310,6 +310,10 @@ endmenu
>   config RISCV_ISA_A
>   	def_bool y
>
> +config RISCV_ISA_ZICBOM
> +	bool "Zicbom support"
> +	depends on !SYS_DISABLE_DCACHE_OPS
> +
>   config DMA_ADDR_T_64BIT
>   	bool
>   	default y if 64BIT
> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cac=
he.h
> index 874963d731..42dbce5b4f 100644
> --- a/arch/riscv/include/asm/cache.h
> +++ b/arch/riscv/include/asm/cache.h
> @@ -9,6 +9,9 @@
>
>   /* cache */
>   void cache_flush(void);
> +void riscv_zicbom_init(void);
> +void cbo_flush(unsigned long start, unsigned long end);
> +void cbo_inval(unsigned long start, unsigned long end);
>
>   /*
>    * The current upper bound for RISCV L1 data cache line sizes is 32 by=
tes.
> diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
> index afad7e117f..456353d9c1 100644
> --- a/arch/riscv/lib/cache.c
> +++ b/arch/riscv/lib/cache.c
> @@ -5,6 +5,95 @@
>    */
>
>   #include <cpu_func.h>
> +#include <dm.h>
> +#include <asm/insn-def.h>
> +#include <linux/const.h>
> +
> +#define CBO_INVAL(base)						\
> +	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> +	       RS1(base), SIMM12(0))
> +#define CBO_CLEAN(base)						\
> +	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> +	       RS1(base), SIMM12(1))
> +#define CBO_FLUSH(base)						\
> +	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> +	       RS1(base), SIMM12(2))
> +enum {
> +	CBO_CLEAN,
> +	CBO_FLUSH,
> +	CBO_INVAL
> +} riscv_cbo_ops;
> +static int zicbom_block_size;
> +
> +static inline void do_cbo_clean(unsigned long base)
> +{
> +	asm volatile ("add a0, %0, zero\n" CBO_CLEAN(%0) ::
> +		      "r"(base) : "memory");
> +}
> +
> +static inline void do_cbo_flush(unsigned long base)
> +{
> +	asm volatile ("add a0, %0, zero\n" CBO_FLUSH(%0) ::
> +		      "r"(base) : "memory");
> +}
> +
> +static inline void do_cbo_inval(unsigned long base)
> +{
> +	asm volatile ("add a0, %0, zero\n" CBO_INVAL(%0) ::
> +		      "r"(base) : "memory");
> +}
> +
> +static void cbo_op(int op_type, unsigned long start,
> +		   unsigned long end)
> +{
> +	unsigned long op_size =3D end - start, size =3D 0;
> +	void (*fn)(unsigned long base);
> +
> +	switch (op_type) {
> +	case CBO_CLEAN:
> +		fn =3D do_cbo_clean;
> +		break;
> +	case CBO_FLUSH:
> +		fn =3D do_cbo_flush;
> +		break;
> +	case CBO_INVAL:
> +		fn =3D do_cbo_inval;
> +		break;
> +	}
> +	start &=3D ~(UL(zicbom_block_size - 1));
> +	while (size < op_size) {
> +		fn(start + size);
> +		size +=3D zicbom_block_size;
> +	}
> +}
> +
> +void cbo_flush(unsigned long start, unsigned long end)
> +{
> +	if (zicbom_block_size)
> +		cbo_op(CBO_FLUSH, start, end);
> +}
> +
> +void cbo_inval(unsigned long start, unsigned long end)
> +{
> +	if (zicbom_block_size)
> +		cbo_op(CBO_INVAL, start, end);
> +}
> +
> +void riscv_zicbom_init(void)
> +{
> +	struct udevice *dev;
> +
> +	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
> +		return;
> +
> +	uclass_first_device(UCLASS_CPU, &dev);
> +	if (!dev) {
> +		log_err("Failed to get cpu device!\n");
> +		return;

Please, return an error code.

> +	}
> +
> +	(void)dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size);

Please, do not ignore errors.

Best regards

Heinrich

> +}
>
>   void invalidate_icache_all(void)
>   {
> @@ -72,4 +161,5 @@ __weak int dcache_status(void)
>
>   __weak void enable_caches(void)
>   {
> +	puts("WARNING: Caches not enabled\n");
>   }

