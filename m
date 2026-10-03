Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C458FCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A8C9813EA;
	Sat,  3 Oct 2026 13:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7eObXL_5-aDA; Sat,  3 Oct 2026 13:05:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B8B09813CC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032714;
	b=c4DmtnUUBT2dbZ40+cRopkW2RgiRZ/LEdVaGW3Rkyhd2EXqP/+VgX+HGzqo76YcleROL
	 LfJOwb42usqk674+yqUDk/ZECdY9xE6VcVehRZGNVFeUkGPvEuQBIrOsDyA36Eu4ljzEg
	 CK2nV0xAqXGE2ipfvvQNHqHnKjvcYyBAMIuRMMWqTBjyFuBipboIzzQj305U6wNX3SOl2
	 7PFEi1mpc5IwPpGZZPKjAZNcBW1lKx2DLaRAuw0FpDFUrND7tf7vZh3hXPoDEpzcHg579
	 qYm04AnsuQ+z3chxHnq5XueLwy2RCMrPPsEqOBiPeq7n7oTcqdQHmA44XpGXJxgnW2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wYHmcdk8jd2wqAGrCv3HjDUX/oceP5o1Y14NdNcvZ7E=;
	b=cYN8GglStHvu/5ezU5EfQbIaGXkjHl4W/Z/rFGJFbE6QCTef9HCG13hJ/brZrutMi+IO
	 BBpt9coTyTll/bmi0RHu2vNUoC3K8MsA96t0GpPsgD5lU20yvQ/zdL5CnK+Tac9FF3WVl
	 H15hw+ssxMmSJ1Dpeqcefx588eqFEjVAcFLZhcCjh9cW5/NSwx4ZaDSVXFZUaJp54AY8+
	 UF4IFIPdkRAV6/AGTXH3Ct9m1+Hwqr460CgM6ual82PZqBVh4E+4brY5HrG5ibTUA/4sH
	 hYoETCSSU5BtGNlsY324xhF25VMSq8MeZc8seHWdXUzayP0wk3+ztAbJ87BUfboSgIg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032714;
	bh=wYHmcdk8jd2wqAGrCv3HjDUX/oceP5o1Y14NdNcvZ7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYO3MSetg+xT7MCVxlgGWnvHHAAlq7crAjXhf4wFl+j8r8qaMwddA3YH2d07Kl3xV
	 6ExXoxE4SdnT3JKftOBM8G2eeWtZ2cNWkBVmm1HCjovXH6Ta6gg6r6feqYPQh9sujy
	 N9lBGz45y3TywN8MmvS5piAEoTXTCwpm+4MpNLB+RM35bI72Z2Ep94Py5tseLLv1qY
	 0g0nRvrarB5Ta7JvuepVn6+F150FCGp7IELfZnhY6i5+OwA6iyOFT5uinnCCrEa7jW
	 OJ1ZUV8hVWG40ivQvKXu1eC7CKTeYYfGZUH8JR3Hu0OuRIAmjiDesHQHg8c8GuVAbE
	 wXF2lSMg1Qj0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8B09813CC;
	Sat,  3 Oct 2026 13:05:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C8C02E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E11941424
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kQBVOfYM8_nh for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 40C7741417
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032712;
 b=TxpgRjRnRsJ9VH5bA5R6m5OMn2yWUDUL5eq6c66vjg7iKa+HF6mTLvAXNweAfB5CRFTA
 EEQEh6J6J2Evgpf6e3p5Qo52XHIwwQjwZq2ZCRkO1JuuUZ52FY9xGVQZRzsxVMpXt9iO5
 aTmcKjT3R2r5AdV2Ik1lo2537SWOTwYEtvt+0nCerux7iqj9ebgcGPKDJJVVVdVr2pl6h
 LURy6+NMKWqITfFYKFtNbB5W6qrxxnQTFBzjcUFMv72zcs89vBjMxPQ9d6EG/F4DDucCX
 5QZ2IPC7S+1e4BHNtMclYXNBbp1yYzGDG/qkEDb09jHER8hNWAzRG/k9AZUdOpjeh0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032712;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=wYHmcdk8jd2wqAGrCv3HjDUX/oceP5o1Y14NdNcvZ7E=;
 b=UhAIBDfItsIcsEGquzKd7a+soLYLLbqJF8buopSXHZ05iwlVPc5cefUA+oHcoZLmjzCs
 wlP8be+3AXYjA6vfAY+cnryWHoAn3N3pvbpl0jH+jaJZS6UpCEp2zpiifpIUd2QgwbsXI
 TwzUko/a8qR/d0YuxSTo2DHqzi38AQ9L614cBWOrIiN9FuLatLIZ+Nys4+TkOmUMa5U3o
 J+L0IhRO+mr1zFVZm24V/6JhrXim7F+53Z4gT16sGDu7wBwKg+Gg3sh7XHjD2Ox19Lz3g
 ChRoJFKauLDADTP8VNFbYnhep5iyprbd9PEOpTQSCbXWSwn/xoRPVAGEfKc8JrW7f5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=C8JrRM9d; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=C8JrRM9d
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40C7741417
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:05:10 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so541587a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032708; cv=none;
 d=google.com; s=arc-20260327;
 b=KECma1efSXZbmnUpj+1qQ32StjeuM6BofX8JkD7FWF2C5XAZmMYLESm1X+Aryy3F+a
 fBhnJh2QFJvCZHZoJj7hYA+gdijFeOycJyR9EhSE42ndU9C3R9skblkwrBbqHWBZSxQc
 px58h1Wte1l+RDzpridYWaLbz+5/B/0VFpRxrchdls+RrWu/lSWH06fcaHPmdeOXbQz2
 VYlehLLbA1eSVXaqbzdWRWivp6skMiCjM6sFIaXeOs0lylP8cPPaLWaUSsjCvu5fNUGS
 rywOGf1re0nSWPAZibt5ep/27YzUQ/5/DbkdnhPHS4WK/WLoxUaY4TUclmI8Yesf8KEJ
 SEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wYHmcdk8jd2wqAGrCv3HjDUX/oceP5o1Y14NdNcvZ7E=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=bIBGJaG4hh8f7DjIWqom7q6N+2bZZhBQBoYy9Olpp1BSPvtwkngYEliV6HU8MA6Upq
 975EpL5MSegbD/AELAKj4g/WQVsuwjLnCEE7Asot7OCTASqtDN4N37Rb7GABL2+B4lQa
 yhnWetCmZBv0oxQixQTusTdu+dUfmJucNzOd6uCx3HpCmNrtPAvrdC+W/Wv1F8P+qhMR
 cJDA3QVvmp6ozUk+LGb0bf/SyU3mvcdEMODrWosUtGxpkS6Z6eCUQPMj3VH0nRcRFaqW
 c3z+/NVi2j80M4fZMQm23qaQccWORzn0hQO0XBo3xFmUPrGI5MRzzL3UaI1NAFLWLu91
 PoMw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032708; x=1791637508;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wYHmcdk8jd2wqAGrCv3HjDUX/oceP5o1Y14NdNcvZ7E=;
 b=C8JrRM9dwBj+eXGaxIZ3Bb9r9zLDpB4h0KGuN3jQCgPARjXYAaKR99p12oDinardu/
 fXuzJFS3dQjm3oCnNc6LpmZ+2/GcZTuaNA11cL2CaOMgeBW+WEcjCAIP72uFUy/4lgCY
 H2n/YsoIGdANK8izJJxLfYrIq7AjLZZ+I6pjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032708; x=1791637508;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wYHmcdk8jd2wqAGrCv3HjDUX/oceP5o1Y14NdNcvZ7E=;
 b=D6f/WcfvqDJRA7W9ap9C3qV1R7o2r4vfefxcJN8HjfzFowoJZL+k14nMh2lTIR6wgX
 9IhhWTwEiT3kr7AIJfcquxNcLZ2EUlvqahfeOiKrVLagr3jgDwdAdox/Z33Fz7HlEFwo
 GSHz6J+7I1ArCq99BsIY/toVl8dIBLO/ogQgJPU5oRdtUKKEAjzL5ZOfLYNV0kwGol7K
 hLB4abAY/j6XJWjXDcqIHQIDse1L6ag4v5co0fa1XLOYmBUnIIlASnnof+mQEZ9yN6lM
 0rjbrK6gLhSNMIzZ8gDfhGuGl0wNvHUgjNc46JeGdhjhlJIhKvP60S3YLmIA6h1ZIwJo
 jVww==
X-Gm-Message-State: AFq9FYIdK3LT7mTfCbu+c3Frm+1NHVfV/9cSWVUGazSElhsuW6Kfh1uo
 A3S1/PE4NKYusHutIWK5bXLbBTCy7jaPVic4+mO2X4IHxKKEqbnpUtQCn/jEEQ/Btrp0pqcPHgW
 hWfGUM2Pu+TjXUWXqyXL2YvaKJXTC02Rr8JmPsYw8
X-Gm-Gg: AYBFou0WGdlOCkIDXqij7RSH0s2SUrSQjtFS/+BLoX0QqfRaC7i1D7ijVC9Xczl8gYK
 DNBzSTQ4Kd+I861dvR+0G554SPVlnkpkFO9jBPqt7eVOPxGyh0BxVGgwcfboI5tTDHyXCxJL9IT
 Qdrv3XxHYeuP3t5cA+nRRg8PL+NPFau3viUlvdhEI5ht7IJ0WzD4Y68X2o656cSGuHWA0EAiM5P
 Lynlyk86ttO5gbKQb+30LHlEXAqVqUgvNd5GX5c2AFY1eeRBdCiGArQ0JwxaDKF/I0RwsHAOY+6
 rrChmG3KGrJ9Mj98FH3MpqonFb76ULqpBVuEGHsPk+HaojzL3rUPORpGOgjbq7+Mjaw=
X-Received: by 2002:a05:6402:13cd:b0:6aa:f187:26b8 with SMTP id
 4fb4d7f45d1cf-6afada1c3e6mr2009143a12.37.1791032708121; Sat, 03 Oct 2026
 06:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-9-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-9-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:04:55 +0100
X-Gm-Features: AclHuK_UV6NKsyteM8Cn4XCFL98XYSbJ4Xl2txeyx_KA1crhn0A48rP2WAtbXdc
Message-ID: <CAFLszTiiU9U9hDgUtPyvU+b5JtirdK1yJHvcwchPH9wqsk5yXg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ufs: expose the boot logical unit as a block
 device
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> ufs: expose the boot logical unit as a block device
>
> The boot W-LU aliases whichever logical unit bBootLunEn currently selects,
> so reading through it follows an A/B switch made by the device itself
> rather than one U-Boot has to work out.
>
> Leave the device and RPMB well known units alone: neither is a block
> device, so probing them would only cost two failed round trips.

Please can you also mention that this applies to every UFS board, in
both SPL and U-Boot proper, and that the new device only appears when
bBootLunEn is non-zero? At present the message reads as though nothing
changes for existing users.

>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/ufs/ufs-uclass.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> @@ -2211,6 +2218,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>       scsi_plat->max_bytes_per_req = UFS_MAX_BYTES;
> +     scsi_plat->wluns = ufs_wluns;
> +     scsi_plat->wlun_count = ARRAY_SIZE(ufs_wluns);

This is unconditional, so every board with boot enabled on its UFS
device gets a second block device presenting the same medium as an
existing LU. The only user in this series is the SPL option in the
next patch. I have a few concerns with that:

1. do_scsi_scan_one() calls bootdev_setup_for_sibling_blk() for the
new device, so bootstd scans the same medium twice and EFI gets two
disks with identical contents. I suspect that matters where the boot
LUs carry a GPT, since the partition UUIDs are then duplicated.

2. The block cache is keyed on uclass and devnum, so blk_dwrite() to
the real LU only invalidates that devnum. A later read through the
W-LU (or the other way around) can return stale data.

3. The renumbering described on patch 4 can break boot_targets and
'scsi dev N' in existing environments, and it depends on whether
bBootLunEn is set on the particular device.

How about putting this behind a Kconfig option (with an SPL variant)
which SPL_UFS_RAW_U_BOOT_USE_BOOT_WLUN selects, so that only boards
which want the boot W-LU get it? With IS_ENABLED() the table can stay
as it is. What do you think?

BTW, as far as I know Linux registers the W-LUs as SCSI devices but sd
does not bind to them, so they never appear as disks there.

Regards,
Simon
