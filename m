Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A59C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A0DC40644;
	Mon, 20 Jul 2026 18:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yFpOrpgDzzDD; Mon, 20 Jul 2026 18:05:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54F744053C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570717;
	bh=5mcFJjXfAflgWKgdbxQ3gyA816ln0Jzd7gUYHGOLKeI=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RvRppINHaI4mh8mblHs8kF4xhGCFDiDs83vsSfnWpVrfuH0HhkMTJ8FwHPoEy4+cC
	 8DuDVXUAceuiLKWHpSTslEeyre4cB/zxPnX/FvkalI5yQP1z4ij8RjIe2oCkdxSA2j
	 YHP+XvxKXTnwjxumbi6tMD64Y7Omb8pKErqElanBnvIH4cIu1jTNpNLzsku73+EdXv
	 e1eQ/ZOFajmgavio8Jh5FtR0g/zkui1Sv/+P3XNJCQQueCw/LagNdoQ0aBruWoU50E
	 8wEcPi8YYzHBCG7TL0z6LQE09p+xFkqRoN7dC7NswtVX3Ak0Bghq4zdFXTRcab+xa7
	 J5HgOTvrv11fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54F744053C;
	Mon, 20 Jul 2026 18:05:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABBE0313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A904C80AAF
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihLCig-CbZqd for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:05:15 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6610A80AD3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6610A80AD3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6610A80AD3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C86842FC; Mon, 20 Jul 2026 20:05:13 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C9D80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:05:11 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so11672389a12.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570710; cv=none;
 d=google.com; s=arc-20260327;
 b=VMrXILwLVx3SStdLDtxz5PGvFnDgsL76irFHXlEqA5xOta9RUVCj57AsXsXj375Zih
 NS6qq03nN/PVrTgnx47qjmRLYV+P2HuzxGYl4HfYYqQoO4QdY7bMfmR1uymFvNyH0g0N
 IRG/yS/ewHkaA7KI1HAzZZbqHG7kdp0lR0T/KzfYsTBELBowY6w+0EXDif9DgC1UZRsz
 J9iGaRQaeb/lL9Kh/C9WVZ/I3dLjFbvouRSc+vIK/ooRfpZXtMLVGMixlM1V9ZGr7Vqw
 DfnlkiuoxG2OvPAEQJDTVwwpLDXb1Zzq7JOZi1HhMk0Tx6PP+nzg96TDnLWuWfTNxGPL
 dWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5mcFJjXfAflgWKgdbxQ3gyA816ln0Jzd7gUYHGOLKeI=;
 fh=S5IsS0p2q/mDhy6CofKU3XdI4SX18ALJnocWEeQR4Xw=;
 b=dw+tvJoF01COy/SDJ7RI6TviYQQ4nj2eL4B9tajsOBozoA6IFY9m40rV03uBfgmH5f
 cxovRun0q+RBQf+oXdz327mDc9ed93WKVFqxmtZreRAMa7/bC8uAk9zWQUTYck3Lwc0c
 M82CrTNpChO3qS51/PyIi0Q0kWqBLARCAOrke0kV9NTFp3ciz3PjKbkyflQwC7/njM62
 RYkNkom2cnqa1A4z0OLxdbFqeFSiSJMCSa7F9Q5zKiRQrmMfH0MfudKyLP3Ag3GX49Ot
 1tWzYGo+loQ388DcEnJDhjMGj4jJfqrffjhjYRsNqIIpfLFuejRZwGOBESCvTzrmOnN3
 cpow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570710; x=1785175510;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5mcFJjXfAflgWKgdbxQ3gyA816ln0Jzd7gUYHGOLKeI=;
 b=pbeKURLiBAyel2kfQTrNXVc3UBZ/b01jhbhb6GUMNxGGiglHCOeLMDLshX7UiOSRPb
 QzTmzXLlCxA/zzfVP0/Vm6UAaE6SpoxfqVMNh4mRClBnWYuzIRsKTk/q+S3qAwhH0Lpd
 qA/T2d11x/p2TtUYIpPvavfBrRy4jCwJ/LKqeTjdPIkWrHp6uadVjX1OU11m51AWKo+L
 8Slh4Y+f8zU0zpnSYu70fNDCvZsb7VIyVxYwEv5GcWoMQ8gJpB93YgACrNViQoge3ien
 j5+15n/iDmdCQ3D/7DgdoZ1D4Idmb4tPTG/drdJKNBiX8I94ys680ZP900V3f3skpy3r
 FtIw==
X-Gm-Message-State: AOJu0YxRVNzWBRGkXzv6KCE/BtdgUBgKIp0pt9Eh34smHouvbogBaIfD
 697i+dXj2I2rIhZbTXYxJjQwHH0/FUipGF5gGsuk1v2WGVRoH7oO6U5CUtTCBqNXMdy2pTAjv9p
 mdAWJoluhsB0ifSKkvnvjWghEHjTmT0XxSXS98X/B
X-Gm-Gg: AfdE7clKYfutqcDtk1Wk8tsvR22NNnkSPxiX02yVTFVsaw6BxQpGD2ZkT/qlyAYHE75
 Dpu+wp7LzX8SqEHs0trLAScz7ln+uP3SEUM9J/I8WQ1u4ZEjIr9FjauM42qLdQTsyfQkI9ih0Gu
 rjq2hw4U7S9gE9bphVz/1iYgAb+903NdqCAa8wBKCT9flj7qfAX3i2gEjlpDj81yjPbSGggnoAq
 O3xh6CSymN+JkcZoXIUOlpHoKFO0R/mtn1qgrmmGA+ZyMUo3930AZ2C4gtE7Grx623u2k0=
X-Received: by 2002:a17:907:960b:b0:c16:a2d4:7bb8 with SMTP id
 a640c23a62f3a-c16b472ab71mr657684666b.22.1784570710319; Mon, 20 Jul 2026
 11:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-2-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-2-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:04:57 -0600
X-Gm-Features: AUfX_mw5QZJK1b-vlAPs-NqfZ083RzC4RpykQcx--SgIvVIo5qMQqYoP3eS_pvI
Message-ID: <CAFLszTjbZs+zy2oGT+4b1=ejxP+=9VgU045vHQQcnVN210vnBg@mail.gmail.com>
Subject: Re: [PATCH 2/7] rockchip: mkimage: Print image information for all
 embedded images
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784570710; x=1785175510; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5mcFJjXfAflgWKgdbxQ3gyA816ln0Jzd7gUYHGOLKeI=;
 b=PSKT4r+GrYdM7zGvvEDPOEVcKHypiCgvZId2N1BU+W5QieLLQPosA2mThDsdmLbxHe
 RYy6phFxjoCBJMVg2jqQ7WJ+ATtvEa20dC1aRCMv35u+PdJtdshP1Xm5kCM0OAN7QrgX
 zROoYGhF98EL3QxD28F1Z7DrPtSeQ85XiNkRQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PSKT4r+G
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="PSKT4r+G";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 2026-07-13T10:02:41, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: mkimage: Print image information for all embedded images
>
> The v2 image format can embed up to 4 data files compared to the two
> init and boot data files using the older image format.
>
> Add support for displaying more of the image header information that
> exists in the v2 image format, e.g. image load address and flag.
>
> Example for v2 image format:
>
>   > tools/mkimage -l rk3576_idblock_v1.09.107.img
>   Rockchip Boot Image (v2)
>   Image 1: 4096 @ 0x1000
>   - Load address: 0x3ffc0000
>   Image 2: 77824 @ 0x2000
>   - Load address: 0x3ff81000
>   Image 3: 262144 @ 0x15000
>
> Example for older image format:
>
> [...]
>
> tools/rkcommon.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -505,6 +503,29 @@ int rkcommon_verify_header(unsigned char *buf, int size,
> +     for (i = 0; i < le16_to_cpu(hdr->num_images); i++) {

rkcommon_parse_header_v2() only checks the magic, so num_images comes
straight from the file and can be anything up to 65535, meaning this
loop can read well past the 4-entry images array for a malformed image.
Please can you clamp the loop bound to ARRAY_SIZE(hdr->images), as the
boot0/boot1 loops in patch 3 do?

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -505,6 +503,29 @@ int rkcommon_verify_header(unsigned char *buf, int size,
> +             printf("Image %u: %u @ 0x%x\n",
> +                    le32_to_cpu(hdr->images[i].counter),

Just to check, is counter guaranteed to be set by all tools that
produce these images? It is documented as 'no use' in patch 1, so a
header with counter left at zero would list every image as 'Image 0'.
Printing i + 1 would be more robust, unless the vendor tools rely on
this field.

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -540,15 +560,16 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
> +             printf("Init Data: %d @ 0x%x\n", init_size,
> +                    le16_to_cpu(header0.init_offset) * RK_BLK_SIZE);

For IH_TYPE_RKSPI the data does not live at this flat offset in the
file - rkcommon_parse_header() has to use rkcommon_offset_to_spi() to
find it due to the 2K-in-4K padding. Since the image type is printed as
SD/MMC or SPI just above, should these offsets (and Boot Data below) be
passed through rkcommon_offset_to_spi() in the SPI case, so they match
the file layout? What do you think?

Regards,
Simon
