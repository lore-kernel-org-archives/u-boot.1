Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F035CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F161586E47;
	Fri, 13 Oct 2023 18:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DdMIurcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17F986E47; Fri, 13 Oct 2023 18:02:56 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1669E86A4C
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so3678891a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1697212973; x=1697817773;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=stYaVGhsNKeOLbx1bYUJU3HveNvR5ZRfC6hNL20VGrk=;
 b=DdMIurcMxqkJBh96RfsPAAq1QIMVVcWRNNLd7aimr/13e2IzN+m6VJ7DnnPlclBbnN
 /B3DJwHl05JfySndW9BmvHjGgFUirqMRitrG9YSq3HNYTaO2kRvJtGMJUce9Gj30B+hx
 0CDczTtOFv8QACOFkaBdVjwko5NMDTwVy8dtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697212973; x=1697817773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stYaVGhsNKeOLbx1bYUJU3HveNvR5ZRfC6hNL20VGrk=;
 b=fWR2N/ilw5EzHtpNzCU00Y3hZQuCLqt+dvet8VVZ+arPAXj3CpVwgqWsP0A+N3PIO6
 Iiuu8cKW3S5Z3OLGZ6XDTBP3NIgBw8+jJzOP3q3oXeAciYTxLp865fvH0/SmiLNKuYpD
 BqkGvy4YXfUC5i18A4YpKs4oxVRZ1FlsLb2BG7vmHBfDNLTyeSJS1nmLieKvNATLJC6W
 q48iqvoH2vbKhC8gCQvltaMGlXH9kIKrQ+nXTub9LLI6rTRiHgl6nnAQy9kbl1S1Q012
 +1wF8skr5RHjd6av3c5y4GVKK1Dg44hBSyh3MT9PWLe1pp+16ITfC2PMt8D9x+FakbQO
 7DsA==
X-Gm-Message-State: AOJu0YzYA1E8eMCp994CpL84vtgNbmXk4EjsbaTkNKjIyfq+h/WWONEm
 cRhTT3wUHZR1Eh8a5gTMAf5muD/AK1QgnAb0MDc=
X-Google-Smtp-Source: AGHT+IF0HcEKcH0l4Rp7QP6beyj432OS2mGSaxGU3SN2Jq3vV0m/P4Onl7ToPXLBp4RxjYocs7+Lsw==
X-Received: by 2002:a50:9352:0:b0:53e:4cd9:2df6 with SMTP id
 n18-20020a509352000000b0053e4cd92df6mr1533454eda.25.1697212973509; 
 Fri, 13 Oct 2023 09:02:53 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i (mob-5-91-24-118.net.vodafone.it.
 [5.91.24.118]) by smtp.gmail.com with ESMTPSA id
 i13-20020a056402054d00b005231e3d89efsm11680268edx.31.2023.10.13.09.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:02:52 -0700 (PDT)
Date: Fri, 13 Oct 2023 18:02:49 +0200
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com
Subject: Re: [PATCH v3 2/2] dfu: mtd: mark bad the MTD block on erase error
Message-ID: <ZSlqKfnRKxL6A4T8@dario-ThinkPad-T14s-Gen-2i>
References: <20230605075208.55221-1-patrick.delaunay@foss.st.com>
 <20230605095147.v3.2.I20e8d74ea2ff0a99c6c741846b46af89c4ee136a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605095147.v3.2.I20e8d74ea2ff0a99c6c741846b46af89c4ee136a@changeid>
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

Hello Patrick,

On Mon, Jun 05, 2023 at 09:52:08AM +0200, Patrick Delaunay wrote:
> In the MTD DFU backend, it is needed to mark the NAND block bad when the
> erase failed with the -EIO error, as it is done in UBI and JFFS2 code.
> 
> This operation is not done in the MTD framework, but the bad block
> tag (in BBM or in BBT) is required to avoid to write data on this block
> in the next DFU_OP_WRITE loop in mtd_block_op(): the code skip the bad
> blocks, tested by mtd_block_isbad().
> 
> Without this patch, when the NAND block become bad on DFU write operation
> - low probability on new NAND - the DFU write operation will always failed
> because the failing block is never marked bad.
> 
> This patch also adds a test to avoid to request an erase operation on a
> block already marked bad; this test is not performed in MTD framework
> in mtd_erase().
> 
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Applied to nand-next,
thanks and regards,

Dario

> ---
> 
> Changes in v3:
> - Split serie with trace fix and support of bad block in MTD erase
> - Fix trace for "bbt reserved" when mtd_block_isbad return 2
> 
> Changes in v2:
> - fix mtd_block_isbad offset parameter for erase check
> - Add trace when bad block are skipped in erase loop
> - Add remaining byte in trace "Limit reached"
> 
>  drivers/dfu/dfu_mtd.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
> index b764f091786d..271d485d1c9a 100644
> --- a/drivers/dfu/dfu_mtd.c
> +++ b/drivers/dfu/dfu_mtd.c
> @@ -91,22 +91,36 @@ static int mtd_block_op(enum dfu_op op, struct dfu_entity *dfu,
>  				return -EIO;
>  			}
>  
> +			/* Skip the block if it is bad, don't erase it again */
> +			ret = mtd_block_isbad(mtd, erase_op.addr);
> +			if (ret) {
> +				printf("Skipping %s at 0x%08llx\n",
> +				       ret == 1 ? "bad block" : "bbt reserved",
> +				       erase_op.addr);
> +				erase_op.addr += mtd->erasesize;
> +				continue;
> +			}
> +
>  			ret = mtd_erase(mtd, &erase_op);
>  
>  			if (ret) {
> -				/* Abort if its not a bad block error */
> -				if (ret != -EIO) {
> -					printf("Failure while erasing at offset 0x%llx\n",
> -					       erase_op.fail_addr);
> -					return 0;
> +				/* If this is not -EIO, we have no idea what to do. */
> +				if (ret == -EIO) {
> +					printf("Marking bad block at 0x%08llx (%d)\n",
> +					       erase_op.fail_addr, ret);
> +					ret = mtd_block_markbad(mtd, erase_op.addr);
> +				}
> +				/* Abort if it is not -EIO or can't mark bad */
> +				if (ret) {
> +					printf("Failure while erasing at offset 0x%llx (%d)\n",
> +					       erase_op.fail_addr, ret);
> +					return ret;
>  				}
> -				printf("Skipping bad block at 0x%08llx\n",
> -				       erase_op.addr);
>  			} else {
>  				remaining -= mtd->erasesize;
>  			}
>  
> -			/* Continue erase behind bad block */
> +			/* Continue erase behind the current block */
>  			erase_op.addr += mtd->erasesize;
>  		}
>  	}
