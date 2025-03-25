Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737E6C3600C
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 16:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E4F8186D;
	Tue, 25 Mar 2025 17:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUfemumr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9788B8186D; Tue, 25 Mar 2025 17:13:50 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A66C810E8
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 17:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so3246379f8f.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742919228; x=1743524028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/TYpWG8Tu95bi+rSvHSLhGf06sfL2qUKyVTKktd0ZM=;
 b=OUfemumr2QtSbHEAV5GWy05PCTmyRE+gzkSSgIDJ04Gdg96C54+MGe1Rfh2QS+tsIe
 tqlhxZSeaeVcMU1wtqL9oh26OjVzqmmu+TAn1ur8wS3hxmezZhmEvmyF4OHUbF3fTFpy
 1FGb7UoxtH19UcakyzbmmZf8QAqLqMJfgkw3QJw3NAtmdW9Atygtf403k/sWUf/QSNDc
 hZ9W878JU4HffbK5l38qaa70KWgefeMpRDO5mEdLKHpja0816IJMkFHyQ9g93VjnVht6
 s97QNzWQxWnxQFXO4p6dstzgqUqHRDKDJtiqQFQy30vjptGnDe5kI5EbKp+zoLOYm97E
 N1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742919228; x=1743524028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/TYpWG8Tu95bi+rSvHSLhGf06sfL2qUKyVTKktd0ZM=;
 b=gtopT1Hn41x0AbxfrEF614uDnUqRQ201fTrnz5Jk1C1Z6hsycZ8Lhtr8llLLr2F63U
 04QyFcQJ8ScefItxJDC0z8Uol9iVF+ZjTDc6Ku9dIp0VDIhQjXAiDzj7uBwNxdAXA/E0
 eTmBg8aNZwslyLAt6Kc/bSGCtFTKGh1K1lopRkUCVR39v+UpFY+fMmKrTeFVain629fW
 fTnQ1V88mrazMZ7QEgm65HgbB3z3jxihjhlLz42DOhxABLQtJc9ih0HuUrk+2Ylkrtu0
 Q+m0UGt6eysT37v7fsnnhmQCWjPErvzsM5MpSVJnRXSmhIbFqyZn6CSZTAsa6Kc608XD
 9b3w==
X-Gm-Message-State: AOJu0YzMU0U9FBaMWJXJTquMGMtuM74bDtExnTK1dyhG0n3/N9TbS74M
 nvR/h29ROZ+N12nqJKcVK/Wow8DcWUIvNakW6Dgiu1OZ/GBsx7W5xxjGh+4G
X-Gm-Gg: ASbGncugSVujFYH+og02OFcGZTuMvvq3jTRIC0d5h7BneOQI2hVvzEjssFXPl7iba+y
 XQnzWYn1m9fK02Dz+fya7BbpqSLuVCHBVvj0ouZ05QS9NkahW+ZwPl90xMKEsxAbkOt3xZ0PJsW
 GKBH9EPKZkZinhhR05J0dlJfszXmvzDlw4CdrUnAMjOuN7J2/olpb1Q6hG/7I5CFGNKMzqA11qn
 NH2l85hxNaUPYfH5blIZw4BwUJ8Q+XZeyA5x2Z2VLhQk83wx4hOT1yYSeE06x6r5Rqp+eZieBOE
 yDGtQhQXe9asvbmsaKrdN0EgFsJeird1L6ay8c6aDsUep6/mcJqqEJOOsI+lxldaggT+uvWVYaq
 9lzR2wc8vASzcirSPq5HTTxl/Xb16dLE=
X-Google-Smtp-Source: AGHT+IE5K5+KWhyMqNd/oWylDaIWUAKFAV+sWpCvLcUBmvZaXCmZvQtYds//Ndv9HXrwn1/j5n9rSQ==
X-Received: by 2002:a5d:5f92:0:b0:391:4389:f363 with SMTP id
 ffacd0b85a97d-3997f91bc76mr14013562f8f.21.1742919227412; 
 Tue, 25 Mar 2025 09:13:47 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdbd1c7sm157742995e9.40.2025.03.25.09.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:13:47 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: FIXUP! sunxi: mmc: Improve reset procedure
Date: Tue, 25 Mar 2025 17:13:46 +0100
Message-ID: <2772552.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250325142737.1702796-1-andre.przywara@arm.com>
References: <20250325133953.1dab37c8@donnerap.manchester.arm.com>
 <20250325142737.1702796-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne torek, 25. marec 2025 ob 15:27:37 Srednjeevropski standardni =C4=8Das j=
e Andre Przywara napisal(a):
> Hi Jernej,
>=20
> what do you think about this solution the A10 compilation problem?
> That looks like a simple change, somewhat half of the way to the proper
> solution.
> If you agree, I'd squash that into your patch, then push it for U-Boot
> next.

Sure, I'm all for it.  Sorry for missing this, it seems so obvious now.

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mmc/sunxi_mmc.c | 10 +++++-----
>  drivers/mmc/sunxi_mmc.h |  4 ++++
>  2 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 31dbfb10c59..951e6acd34d 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -449,23 +449,23 @@ out:
>  	return error;
>  }
> =20
> -static void sunxi_mmc_reset(struct sunxi_mmc *regs)
> +static void sunxi_mmc_reset(void *regs)
>  {
>  	/* Reset controller */
> -	writel(SUNXI_MMC_GCTRL_RESET, &regs->gctrl);
> +	writel(SUNXI_MMC_GCTRL_RESET, regs + SUNXI_MMC_GCTRL);
>  	udelay(1000);
> =20
>  	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCA=
T2)) {
>  		/* Reset card */
> -		writel(SUNXI_MMC_HWRST_ASSERT, &regs->hwrst);
> +		writel(SUNXI_MMC_HWRST_ASSERT, regs + SUNXI_MMC_HWRST);
>  		udelay(10);
> -		writel(SUNXI_MMC_HWRST_DEASSERT, &regs->hwrst);
> +		writel(SUNXI_MMC_HWRST_DEASSERT, regs + SUNXI_MMC_HWRST);
>  		udelay(300);
> =20
>  		/* Setup FIFO R/W threshold. Needed on H616. */
>  		writel(SUNXI_MMC_THLDC_READ_THLD(512) |
>  		       SUNXI_MMC_THLDC_WRITE_EN |
> -		       SUNXI_MMC_THLDC_READ_EN, &regs->thldc);
> +		       SUNXI_MMC_THLDC_READ_EN, regs + SUNXI_MMC_THLDC);
>  	}
>  }
> =20
> diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
> index 9d55904c213..bc313dcabe0 100644
> --- a/drivers/mmc/sunxi_mmc.h
> +++ b/drivers/mmc/sunxi_mmc.h
> @@ -12,6 +12,10 @@
> =20
>  #include <linux/types.h>
> =20
> +#define SUNXI_MMC_GCTRL		0x000
> +#define SUNXI_MMC_HWRST		0x078
> +#define SUNXI_MMC_THLDC		0x100
> +
>  struct sunxi_mmc {
>  	u32 gctrl;		/* 0x00 global control */
>  	u32 clkcr;		/* 0x04 clock control */
>=20




