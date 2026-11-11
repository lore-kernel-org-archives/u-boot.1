Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82795606A32A
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x7Vywg0f;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ph/N89GG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 596AA60B34;
	Wed, 11 Nov 2026 19:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QrQykLh-aIB8; Wed, 11 Nov 2026 19:04:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36C8160B21
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794423858;
	b=dMnjrTq6bkuY0bG8YACk1t+MfKxIs0ZlwuBU1ULIEKuLxlWdwT9r6zoUY06142qTAGSm
	 /aq1OHXlgJeeeNRIxybfpU5poukF+WDviNkvVl68I2nmAhZkRBZXC24mGaKxUdMCJbcIt
	 9PO+Mxy16PVegulGWKsV4k3wrii6ZnWmWddnv9WL9Sjc9vvGbNmMt8WsAFlykEUFYb7Bi
	 i6lncg9jg+wqm7AmTBeZ3AoSQcvZBTw/C4aPoIKZNMDEqLUhgxi97rTohwbzR3CBE+jGZ
	 W1Kh8TBl4uev0XSNC0MYT9or5+U1gblddDcaOfwqvBtrNupghEYGAak31Jrz14eJjfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794423858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8tv2/VmF0ddR8bmgCdXI/Qv4bjiMKGyCAteXIh2Rhak=;
	b=taGfzHSHEkUe66KevbpMXDJCNvKm5LMQ6ekTNNptrB3H/8nHEZSSkV7D4RnFNstK5MMj
	 SmP+ovOqu7RmD7/Pf/VFpzwC4CkZnlb6DLSDCzf3wxKn0udgav50t6FFZQze196/ty3Ms
	 DRBSvw9CTa6przGGsLyXmvW8GQzXpeWRGQ6Baveyr7pQOsDiOzutbaxXJbZ2Fsx+KaFEW
	 NMHEgsAJhIbB9BQFKhVz5eCYzEbgkFZN0cjy42fffo9l+IPSsXTQjxmDHahWSp6RUH9T5
	 QYvwdHVNCpVU896bBgZxyx0OQHg7RZ3MgfdtFz/763H+oIfmGjBJM8ZPJCtHt4vruLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794423858;
	bh=8tv2/VmF0ddR8bmgCdXI/Qv4bjiMKGyCAteXIh2Rhak=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x7Vywg0f4bjrWL6l40WfmSr9W/7VU4QJ6B98LqU03UvAXO1KuWDjmds21AjqSz7mK
	 +arOkINFHtncbBIrCT0lQU7l6dPgb3IG8Vfjcyvu406x+G9mBms4++Wgal/8zrwAKY
	 kY7SazVyw7JvfYhw3RF1X2DjBkVfrKvSMGQCklEvAk6ifvSojso14Ulm6vjZ9kghRf
	 Q0F4lVpMyFgQP/7ZQJ1fKdWLALNpEEkUzEB8uIO6VvRyXPicjUylvYoeCgYLDAYVYH
	 Ycr7gTTzoNV2mdXC4WVZHl6F/odzV7KSZcIt0lSOmouOdn1AalN4uKhNAIz4r/kvxe
	 TmUZO+C4VjNig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36C8160B21;
	Wed, 11 Nov 2026 19:04:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3DC070B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFF4D8082B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mwe6IdvIaDAt for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 19:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD20E80FB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ph/N89GG
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD20E80FB2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:14 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so37440865e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794423853; x=1795028653;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8tv2/VmF0ddR8bmgCdXI/Qv4bjiMKGyCAteXIh2Rhak=;
 b=ph/N89GG9xJJM3iraR2sBcI2NcIk64wpvvxMrDiYCfZgDmm5q46d4lfGb1sTXqEbA7
 GaO5iIL+D4Fiz0/99rm1eqxV+GTMCViljdfGUfmd/syzsDpa79H/jsgPusdYZ/GBA4S4
 i1I/kAzGoOdtYzpMvLYiU3Q6d0uoXGma2pdKYmy9RIGhZuS/RXg+WSIlhUUX+l5uGMt0
 g2w3DXiBdAl42Mu3TT1RS+V/XPbYDgGt/AYLWwyC+PEUZ9cIndjEt1YIW+AtGDqU6Lz/
 jdYYt/gV5uHj1OPc7FAnjgrmobiBPus6SJwmxglWPk+eACNie+cFMVYrKiLTQdPrz5EN
 NxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794423853; x=1795028653;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8tv2/VmF0ddR8bmgCdXI/Qv4bjiMKGyCAteXIh2Rhak=;
 b=WEqhIJK2pOKDx2k5zREL7yMkWB6fX+xRsCdceMM9vBZ1ddpYBKDNDfzrSkpPT4l9b/
 fYvIT5aA3ot9belmhJ38nz2kH/EfRc5nTB+ZshNhF2JtDPjaI5ytsXMA3qiK0aljZ9sz
 AiEExExD9RyUQFSfRIRgEduxY9JprsR6HVSruuQDSVS/ZIXLQOJCKbyEOYN36xhJl4z+
 opmjmtKH/vrinzTf7SpEIintxjxFRiuEnvwNbfy80gXdVniEd2ZCe+fXjwUdrslljfJz
 JT7d5R5Q6s4xgBQYTLXNrAqznZSz1B6OWt682+D6h6Ewuly7CK3IOm6RlbnpgCxhQsWy
 o3DA==
X-Forwarded-Encrypted: i=1;
 AL+hErGmCs8Z+QtcNZnfCEwmgQpZQPuX9dmdksF1s43Rc11Q7OPNnvBKXBJDTan0+0S3GK48UG5cad0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8C4XHJiJ4rjZckQpqmfbpSlaoycmkL3BpHVJ0zRQMQZ2lxejqx
 T6kA4QCZY0THtDbZ6QzL5YQIIzwjerOpSgsg73R+WFi1IwoWTqo2sKgHIeJrnU9+k+Y=
X-Gm-Gg: AYBFou2kzH+TusF6jq2eFJb99OY/V8tfbxhwtO9ik/gW8j81EaHMz8v+nmrDlNVerMA
 /qUoSBhE/DbdfBCioUwJu9WWzPmuOPfaS9cSRj+cEXzUQgzULs5ouZ2DZXC/SlSlb22obCF1u8M
 HO+IJHDE1ot31BXorivlirOIaXN6x5hSMNTpBoIRoKkQwyl7cptIFzEieVhIQERxkkQ/D/tcg1u
 Sa//9vWQaRJV0li5iL37ScmSBSOiZSUTRzGl+98hByChnLI0W8Eusa3/NlUKjFg7Yg/eB6G/orb
 ymslJSzyaCqN4svv3OQ8pidyzdAFDCNu9zvJewPDjkA3dzx91dEEGu7DdMZFdPtp6dzJr4FWABP
 w1maEEGHJTfuwqloREAX2oLdx3ZY5ntYLEdxFB32aWBeg3xrMBshSozDd9gcrJne9y+mmjA4tyd
 l/eXlWP57hxeah6kWs9C1rCD+6Oxdnxo3ybBNERCrB3genjInqYABG/Q8PiD0cdYKyvQ8maUIWv
 //VjuB7CCcoJbyNnENro0+u4NUTtqf649K+DWfL6oYWUc8YVAy9WFrKHX+oUIWQx8hC5sA+HJ4m
 UY6yJAHHiVVAE1nAssq/a18JcLPWiVguttBxqWMYv/wg/hXbl99639CzNn8uLJZmocWGpri2kYg
 OuHPPSMl1NMtBuJNoX0v/hTMrpkPrmWGeFynb6nOIHeGW5Q==
X-Received: by 2002:a05:600c:64c6:b0:4b7:6aac:7406 with SMTP id
 5b1f17b1804b1-4ba0931e0cemr60895765e9.3.1794423852973; 
 Wed, 11 Nov 2026 11:04:12 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e251c26sm8622285e9.1.2026.11.11.11.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 11:04:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] tools: mtk_image: add UFS support
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-1-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
 <20261106-mtk-genio-720-spl-ufs-v1-1-90c578b6c43b@baylibre.com>
Date: Wed, 11 Nov 2026 20:04:09 +0100
Message-Id: <179442384949.26078.8404410379416781331.b4-review@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add support for generating images that can boot on UFS storage for
> MediaTek SoCs.
> 
> The UFS device header is 4 KiB instead of 1.5 KiB, and the size field
> of its generic boot header covers the whole device header.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [dlechner: rebase, fix header size check when verifying, document the
>  ufs media type, use mtk_image_verify_gfh()]
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/doc/README.mediatek b/doc/README.mediatek
> index 246579d4be2..d38709408b7 100644
> --- a/doc/README.mediatek
> +++ b/doc/README.mediatek
> @@ -107,6 +107,7 @@ To generate these two headers with mkimage:
>  		nor  : Serial NOR
>  		emmc : eMMC
>  		sdmmc: SD
> +		ufs  : UFS
>  
>  	   nandinfo: Desired NAND device type, a combination of page size, oob size and
>  		     optional device capacity. Valid types are:
> diff --git a/tools/mtk_image.c b/tools/mtk_image.c
> index 1b1aed59924..ac9c86df6bd 100644
> --- a/tools/mtk_image.c
> +++ b/tools/mtk_image.c
> @@ -36,6 +36,9 @@ static const struct brom_img_type {
>  	}, {
>  		.name = "spim-nand",
>  		.type = BRLYT_TYPE_SNAND
> +	}, {
> +		.name = "ufs",
> +		.type = BRLYT_TYPE_UFS
>  	}
>  };
>  
> @@ -262,6 +265,8 @@ static int mtk_image_vrec_header(struct image_tool_params *params,
>  
>  	if (hdr_media == BRLYT_TYPE_NAND || hdr_media == BRLYT_TYPE_SNAND)
>  		tparams->header_size = hdr_nand_size;
> +	else if (hdr_media == BRLYT_TYPE_UFS)
> +		tparams->header_size = sizeof(struct ufs_device_header);
>  	else
>  		tparams->header_size = sizeof(struct gen_device_header);
>  
> @@ -357,6 +362,65 @@ static int mtk_image_verify_gen_header(const uint8_t *ptr, int print)
>  	return mtk_image_verify_gfh(gfh, GFH_FLASH_TYPE_GEN, print);
>  }
>  
> +static int mtk_image_verify_ufs_header(const uint8_t *ptr, int print)
> +{
> +	union gen_boot_header *gbh = (union gen_boot_header *)ptr;
> +	uint32_t gfh_offset, total_size, devh_size;
> +	struct brom_layout_header *bh;
> +	struct gfh_header *gfh;
> +	const char *bootmedia;
> +
> +	if (!strcmp(gbh->name, UFS_BOOT_NAME))
> +		bootmedia = "UFS";
> +	else
> +		return -1;

This function is almost the same of mtk_image_verify_gen_header() is it
possible to unify both?


> +
> +	if (print)
> +		printf("Boot Media:   %s\n", bootmedia);
> +
> +	devh_size = sizeof(struct ufs_device_header);
> +
> +	if (le32_to_cpu(gbh->version) != 1 ||
> +	    le32_to_cpu(gbh->size) != devh_size)
> +		return -1;
> +
> +	bh = (struct brom_layout_header *)(ptr + sizeof(union gen_boot_header));
> +
> +	if (strcmp(bh->name, BRLYT_NAME))
> +		return -1;
> +
> +	if (le32_to_cpu(bh->magic) != BRLYT_MAGIC ||
> +	    le32_to_cpu(bh->type) != BRLYT_TYPE_UFS)
> +		return -1;
> +
> +	if (img_gen) {
> +		gfh_offset = devh_size;
> +	} else {
> +		gfh_offset = le32_to_cpu(bh->header_size);
> +
> +		if (gfh_offset + sizeof(struct gfh_header) > img_size) {
> +			/*
> +			 * This may happen if the hdr_offset used to generate
> +			 * this image is not zero.
> +			 * Since device header size is not fixed, we can't
> +			 * cover all possible cases.
> +			 * Assuming the image is valid only if the real
> +			 * device header size equals to devh_size.
> +			 */
> +			total_size = le32_to_cpu(bh->total_size);
> +
> +			if (total_size - gfh_offset > img_size - devh_size)
> +				return -1;
> +
> +			gfh_offset = devh_size;
> +		}
> +	}
> +
> +	gfh = (struct gfh_header *)(ptr + gfh_offset);
> +
> +	return mtk_image_verify_gfh(gfh, GFH_FLASH_TYPE_GEN, print);
> +}
> +
>  static int mtk_image_verify_nand_header(const uint8_t *ptr, int print)
>  {
>  	struct brom_layout_header *bh;
> @@ -504,6 +568,8 @@ static int mtk_image_verify_header(unsigned char *ptr, int image_size,
>  
>  	if (is_mtk_nand_header(ptr))
>  		return mtk_image_verify_nand_header(ptr, 0);
> +	else if (!strcmp((char *)ptr, UFS_BOOT_NAME))
> +		return mtk_image_verify_ufs_header(ptr, 0);
>  	else
>  		return mtk_image_verify_gen_header(ptr, 0);
>  
> @@ -530,6 +596,8 @@ static void mtk_image_print_header(const void *ptr, struct image_tool_params *pa
>  
>  	if (is_mtk_nand_header(ptr))
>  		mtk_image_verify_nand_header(ptr, 1);
> +	else if (!strcmp((char *)ptr, UFS_BOOT_NAME))
> +		mtk_image_verify_ufs_header(ptr, 1);
>  	else
>  		mtk_image_verify_gen_header(ptr, 1);
>  }
> @@ -658,6 +726,33 @@ static void mtk_image_set_gen_header(void *ptr, off_t filesize,
>  		 filesize - sizeof(struct gen_device_header) - SHA256_SUM_LEN);
>  }
>  
> +static void mtk_image_set_ufs_header(void *ptr, off_t filesize,
> +				     uint32_t loadaddr)
> +{
> +	struct ufs_device_header *hdr = (struct ufs_device_header *)ptr;
> +	struct gfh_header *gfh;
> +
> +	/* Generic device header */
> +	snprintf(hdr->boot.name, sizeof(hdr->boot.name), "%s", UFS_BOOT_NAME);
> +	hdr->boot.version = cpu_to_le32(1);
> +	hdr->boot.size = cpu_to_le32(sizeof(*hdr));
> +
> +	/* BRLYT header */
> +	put_brom_layout_header(&hdr->brlyt, hdr_media);
> +	hdr->brlyt.header_size = cpu_to_le32(hdr_offset + sizeof(*hdr));
> +	hdr->brlyt.total_size = cpu_to_le32(hdr_offset + filesize);
> +	hdr->brlyt.header_size_2 = hdr->brlyt.header_size;
> +	hdr->brlyt.total_size_2 = hdr->brlyt.total_size;
> +
> +	/* GFH header */
> +	gfh = (struct gfh_header *)(ptr + sizeof(*hdr));
> +	put_ghf_header(gfh, filesize, sizeof(*hdr),
> +		       loadaddr, GFH_FLASH_TYPE_GEN);
> +
> +	/* Generate SHA256 hash */
> +	put_hash((uint8_t *)gfh, filesize - sizeof(*hdr) - SHA256_SUM_LEN);
> +}

Same here, this is almost the same as mtk_image_set_gen_header()


> +
>  static void mtk_image_set_nand_header(void *ptr, off_t filesize,
>  				      uint32_t loadaddr)
>  {
> @@ -754,6 +849,8 @@ static void mtk_image_set_header(void *ptr, struct stat *sbuf, int ifd,
>  
>  	if (hdr_media == BRLYT_TYPE_NAND || hdr_media == BRLYT_TYPE_SNAND)
>  		mtk_image_set_nand_header(ptr, sbuf->st_size, params->addr);
> +	else if (hdr_media == BRLYT_TYPE_UFS)
> +		mtk_image_set_ufs_header(ptr, sbuf->st_size, params->addr);
>  	else
>  		mtk_image_set_gen_header(ptr, sbuf->st_size, params->addr);
>  }
> diff --git a/tools/mtk_image.h b/tools/mtk_image.h
> index 54a838de863..8b4a601aec6 100644
> --- a/tools/mtk_image.h
> +++ b/tools/mtk_image.h
> @@ -11,7 +11,7 @@
>  
>  /* Device header definitions, all fields are little-endian */
>  
> -/* Header for NOR/SD/eMMC */
> +/* Header for NOR/SD/eMMC/UFS */
>  union gen_boot_header {
>  	struct {
>  		char name[12];
> @@ -25,6 +25,7 @@ union gen_boot_header {
>  #define EMMC_BOOT_NAME		"EMMC_BOOT"
>  #define SF_BOOT_NAME		"SF_BOOT"
>  #define SDMMC_BOOT_NAME		"SDMMC_BOOT"
> +#define UFS_BOOT_NAME		"UFS_BOOT"
>  
>  /* BootROM layout header */
>  struct brom_layout_header {
> @@ -48,7 +49,8 @@ enum brlyt_img_type {
>  	BRLYT_TYPE_EMMC = 0x10005,
>  	BRLYT_TYPE_NOR = 0x10007,
>  	BRLYT_TYPE_SDMMC = 0x10008,
> -	BRLYT_TYPE_SNAND = 0x10009
> +	BRLYT_TYPE_SNAND = 0x10009,
> +	BRLYT_TYPE_UFS = 0x1000c
>  };
>  
>  /* Combined device header for NOR/SD/eMMC */
> @@ -61,6 +63,16 @@ struct gen_device_header {
>  	};
>  };
>  
> +/* Device header for UFS */
> +struct ufs_device_header {
> +	union gen_boot_header boot;
> +
> +	union {
> +		struct brom_layout_header brlyt;
> +		uint8_t brlyt_pad[0xE00];

Can you add a comment about the odd size 0xE00?

-- 
Carlo Caione <ccaione@baylibre.com>
