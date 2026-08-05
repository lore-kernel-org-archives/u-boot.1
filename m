Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DD2C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 11:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D3AE80AD5;
	Wed,  5 Aug 2026 11:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfVDGVkTdwb4; Wed,  5 Aug 2026 11:40:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 230F880B8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785930037;
	bh=PebiNkZoHdji+egClSmol7K+QqO6PDOinDTGtodSiN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IafojfPM0pR9cD3tQXjyi9kK1HomLbo9GgFigSZYELIQaNd8bZLKy6cb5HAFlFxNb
	 iM2BHfY2Ouy/O3XQ4R7k+GklmU61FNA4VUAEJ7x3FjUppqi9He24qNuursrzw59LcE
	 g2a8d7Ia6ucLIcS7otq/t0JO8VZpNRaC1iwOqWpTYRmiH2kF1ylmGbaPpBZ7cwNwEW
	 Co/SGbrVwWxXpjGTESLd3wIzVTAFln4AWoVNY2bcL0eH/1bX/KxPYY5x9U6Oz1Iqjt
	 KF4LbmyUN22HXA4lniHBaYs9amM/QM5FhJ4NZrke/9ig6nA0QuIcquVohNj1riQhSq
	 jakwD8OYlKtNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 230F880B8C;
	Wed,  5 Aug 2026 11:40:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEE0E23F
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 11:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1D05406EF
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 11:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZAYEPwezmzH for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 11:40:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 90AD6406B2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90AD6406B2
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90AD6406B2
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 11:40:34 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8f23e851626so4818056d6.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 04:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785930033; cv=none;
 d=google.com; s=arc-20260327;
 b=sCEblXSayBTiplL2NKcWmXCF6EiKaHPcDcc7gq9siLql91K5gAJRK+6hnnzzm/L8ac
 A2f7JpfPX+xRTp92uPt6Ixy0jIieFmeE5kWWlgylaOc5jSjFUqZPXSnyUJnBj87opgw1
 YKrFVJ0SPJgrOeZwdcZFZfjkXISAItkLG1eqxSa8cNJz9cb+Kw4/zitW0mcGe+QUUbA2
 VuOxlEG0sIb3ED1gFZ1GvVzgXbI7ku2yINnsjmZYqJuAYKxJlxVl4eODNYXxFF1OX3Ce
 dISLij7yXHx7ti07hc00wGKkWvNDKcJyUgkFIV2doRSP9Ivfw6mAMOKPycGY2mMmEhe1
 B/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PebiNkZoHdji+egClSmol7K+QqO6PDOinDTGtodSiN8=;
 fh=ng9IPAskjaqNl8F9JMBmRFIDjWoyq94UpMn4A5ZM6lE=;
 b=Hf44eZd2ATSrDrjlsYASkUrDfswtaC0N1CuC6Wiv7iIdMtaEiP2R+9UEqo96ZRoyVX
 SasQK2orUC9kciAOJ7ZaVCU1w45ytBT8g3f5VjMWkB0KBuTNa5+I2PgRgCS8hIB8JDgF
 JOtzDk/ZW4E/TsA5v6toQInmHN9Drass98JG9TIdfc/4Ma1oVICbKtPjYPKhqlYkv+Fi
 V/erFmm2+ylA5ZNqUy2f4WVv4/i3fP7lVnUnWufhEp022N2jTJPnaFQcF3yO8uxTsloX
 vWEQ8BnQqbD2Uy2oA9xjMBND5AuasCcH/segv3YQ11HDoSQ+LXZtSkF/Spdz9bXlwPGk
 By9Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785930033; x=1786534833;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PebiNkZoHdji+egClSmol7K+QqO6PDOinDTGtodSiN8=;
 b=dWAiKEphcEtI5boIz+4s12m8jES+jzOCHvs0j2qgnCli5IuxcIrDVmN78TxNplSmCW
 NWPHgHWRsUqKC1cKfzlMLAyJ0rh+5iTEpsBGlTiU/twLdzfTcZSvs37/D5qIXXrTm69g
 n4HpMLd0T8aOoCGYf66iNI52Kwr9qPa/8qo88enX0W+BFzrjfl/I6PaGzNFxK05NqMOG
 ngzBy+Brm49wEjalZ+iYQgSOYKVw+2z1qSPEpemlanp+f8nvc7Ai8PToO+1uKgNRcXxI
 krKrwg7QoTpFvon/T5vRnGFvZCvBt0ERK8eYE5KcCHyTSIoWgmGOLm3OxybPsNHuodCV
 vKug==
X-Gm-Message-State: AOJu0Yy0oHnjjSAQV5BaIcQvC8NBtHbBTFljqe/jGzgNr9SLeoQiAvJ/
 X1xybYK+7x4cc/kw9+w0kRSKnS4TVlTinj2a5NujftH/CdJuMiBTEb7wY9HYBPGd+bBz90HQad3
 3d16ep49hVJy/u0fTOR9DFtuuMhnAkpw=
X-Gm-Gg: AR+sD11gk7pm/P+8L+UVRgZ9iegQX5An8VJ/LM99iMZwTn0qCcNrhRz8sIbS9xozx5k
 xUT50ceqvMeJPJJ9d1WU/x3tFxV5zLv1YfHS5uBmw7rx7chyJcVPPoSXkYsOzwdhLx+8zZUTIxi
 lTqML/EM/SA8IGnbKu8waZpMwJFB1xYBo2wRB9Q0EWIbsRCRPvWUtdUNNyw8DA9WbLHqm6shSAR
 7yltA3VPHZ/cs9137O9B8fvjNigSjieVvLZLR4qcOU+2T+5bOUSTrfF2avFtA4AsX62e3MbHXIm
 DVw8eTGkRl5jdvGCrpJP2L8iQBjeB0P+woL3/BpIPQ1JUWHehuefI2DD3hvItNNIFGJIupHS+Ie
 RS0F82cmpSfTOLgenzUlLvUopc4h9C3en0fr1hq4ZxOdNPkzgbOlbcirp7+c0Nts6vLbbf4CMnv
 dHHw83FLH13mmhR9O1SvpDU0manVrnlko0pqvg/R4=
X-Received: by 2002:ad4:5942:0:b0:8e9:61e9:8d9 with SMTP id
 6a1803df08f44-9088126d60dmr64993936d6.23.1785930032979; Wed, 05 Aug 2026
 04:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-tryboot2-v3-1-b0bc282a923b@linutronix.de>
In-Reply-To: <20260804-tryboot2-v3-1-b0bc282a923b@linutronix.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 5 Aug 2026 12:40:19 +0100
X-Gm-Features: AUfX_myLGmGgL4m7Omf73tOjZZxTJo7qCRY3FxOXDczheMLCyYnQk3Ll62XObDM
Message-ID: <CALeDE9NJ7oxNkFe02e913OXiMd=WYQiPzvQoBs98SzL_w2D8ag@mail.gmail.com>
Subject: Re: [PATCH v3] rpi: copy /chosen/bootloader partition and set
 boot_partition
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: u-boot@lists.u-boot-project.org, Matthias Brugger <mbrugger@suse.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785930033; x=1786534833;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PebiNkZoHdji+egClSmol7K+QqO6PDOinDTGtodSiN8=;
 b=ff30LqcF0tUkjGRpvqZWq7ngJQy6pDMAeC5zNFEhqCqynU37tqoUZKZumKdaa+LNf4
 RYt5WZl7XG9gsIPtx5LYfJpd68ihjc/WQNK9pAskpTUF9dkSvz2JtyEdc4/a+3G24n28
 rHjWc21bVxOsbMx8BmXNPtDUA3OwU6wu/yZ/9peCNFmS4WlzLK6eW9w7q1AUCvu57mzY
 hdrUdcR9nbkfA1w0Fv0CfTZwCUKiNY0euaZ7OXtRs/HqJ8d+Nm4Esqq6d/7mMyIevI0R
 NjWWVaSVqaMqk0oXCfrxsvzYkEuQyLD67tLXd+KCNorikMCPbhneYhCjT0DmEqMc6/uh
 4E6w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ff30LqcF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Gregor,

On Tue, 4 Aug 2026 at 14:39, Gregor Herburger
<gregor.herburger@linutronix.de> wrote:
>
> The Raspberry Pi has the "tryboot" feature where it can boot from a
> different partition enabling failsafe A/B updates. After boot the
> firmware sets 'partition' property in /chosen/bootloader.

I think the title and this needs to be updated to cover the fact we're
now taking the whole chosen/bootloader/ branch of the tree not just
tryboot or partition.

> Copy the /chosen/bootloader node to the device tree.
>
> Set the env variable boot_partition accordingly to allow boards to
> create a bootcmd based on the boot partition.
>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Given the patch has changed quite a bit you should drop this review tag.

> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

Tested-by: Peter Robinson <pbrobinson@gmail.com>

This works for me to copy all of bootloader/ so I'm adding a tested, I
think there's a few other minor bits needed.

Thanks,
Peter

> ---
> Changes in v3:
> - Copy the complete '/chosen/bootloader' node instead of only the
>   partition property
> - Link to v2: https://patch.msgid.link/20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de
>
> Changes in v2:
> - update Reviewed-by tag
> ---
>  board/raspberrypi/rpi/rpi.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 1da5df92351c..ba8a2c1ba4cf 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -480,6 +480,20 @@ static void set_serial_number(void)
>         env_set("serial#", serial_string);
>  }
>
> +static void set_boot_partition_fdt(void)
> +{
> +       void *fdtp = (void *)gd->fdt_blob;
> +       u32 partition;
> +
> +       partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
> +       if (!partition) {
> +               printf("Failed to the get partition property.\n");
> +               return;
> +       }
> +
> +       env_set_ulong("boot_partition", partition);
> +}
> +
>  int misc_init_r(void)
>  {
>         set_fdt_addr();
> @@ -489,6 +503,7 @@ int misc_init_r(void)
>         set_board_info();
>  #endif
>         set_serial_number();
> +       set_boot_partition_fdt();
>
>         return 0;
>  }
> @@ -579,6 +594,39 @@ int board_fdt_blob_setup(void **fdtp)
>         return 0;
>  }
>
> +int copy_node_all_properties(void *dst, void *src, const char *path, const char *node)

Should we split this to two patches?

> +{
> +       int src_parent, dst_parent;
> +       int src_node, dst_node;
> +       int prop;
> +       int len;
> +
> +       src_parent = fdt_path_offset(src, path);
> +       dst_parent = fdt_path_offset(dst, path);
> +       if (src_parent < 0 || dst_parent < 0)
> +               return -1;
> +
> +       src_node = fdt_subnode_offset(src, src_parent, node);
> +       if (src_node < 0)
> +               return -1;
> +
> +       dst_node = fdt_find_or_add_subnode(dst, dst_parent, node);
> +       if (dst_node < 0)
> +               return -1;
> +
> +       fdt_for_each_property_offset(prop, src, src_node) {
> +               const char *name;
> +               const void *value = fdt_getprop_by_offset(src, prop, &name, &len);
> +
> +               if (!value || !name)
> +                       continue;
> +
> +               fdt_setprop(dst, dst_node, name, value, len);
> +       }
> +
> +       return 0;
> +}
> +
>  int copy_property(void *dst, void *src, char *path, char *property)
>  {
>         int dst_offset, src_offset;
> @@ -641,6 +689,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>
>         /* copy uart clk as provided by the firmware */
>         copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
> +
> +       /* Copy the bootloader node */
> +       copy_node_all_properties(fdt, fw_fdt, "/chosen", "bootloader");
>  }
>
>  int ft_board_setup(void *blob, struct bd_info *bd)
>
> ---
> base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> change-id: 20260803-tryboot2-8c5221376e5a
>
> Best regards,
> --
> Gregor Herburger <gregor.herburger@linutronix.de>
>
