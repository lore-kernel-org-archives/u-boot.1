Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3855EEDF176
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F1383C4B;
	Fri, 13 Feb 2026 16:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hq/Gy+th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9FF83015; Fri, 13 Feb 2026 16:46:47 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092F483015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-5032e59c8d3so1144461cf.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770997604; x=1771602404; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+/kLyY/7hxaIH+mHrPOHGgwrLvxdjshEB8qD1NlbYxU=;
 b=Hq/Gy+thHb8KmTPRCeeOCFg+BquMyomc2+o8GRzQK1IbxlXILqPhaa3YQMVfVdFhTk
 Zlwx66J6iulODFwBFHANjrnpSrXp2ut8mrUjzLNkcoj6lTvSkq9sjmVy/MH+WHbWRWRg
 cX//gGRXBC0jaCcJq36dKnz00LPkmE+dYrN2VeN3iR2COLJlEdZ2hnNq8X9QwcXi1Xzx
 xZfmKMGr4dfZ47FiJ0o+9qk9T+PeXj+ZkGkvWk3HX0nsZrArxZ+mvR8A439+6M5bbryN
 mDdDlEcTemADsi8mUBqH8+uOfp8w13tQ2QWtFuDfvG8XO8Fh/vkkvVdBHrGC/1mHZg/K
 y4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770997604; x=1771602404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/kLyY/7hxaIH+mHrPOHGgwrLvxdjshEB8qD1NlbYxU=;
 b=kU4trKrZYBIHy0pRQsLpvKXgMImqfIFbayMgd9i5edwhtEyXFjgiONPUsH/tUhttAW
 SauzpXWezASeW+E85mu8RO4Tc47ox40tVlQy1wXGNmORuU7/am9NtI8dxrG3oLbDty+5
 sqTWujLAf2N0lymyUNgLIDg9qJ9DFE6PnZOYXtmnZftiqrsdGZ/vaFw4MWoVtCQxLXfD
 qNwZCG3GohV0Zd0LNvdIBs9auDgW4GXuK3vfX0wV9/VZKpNJy9PQwLcUpDeN423OKKa5
 ZYtSJ6ItH6t27NAlpYJLk96Mov0orHauU6aDa9qICOXA6X7RcvmSMLxja8ld45/1mbiW
 HoMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvaCWVNdKmHd705SIdwicPylxs6UCX0WWUZLyUtiniRQcETH9ylJxMVsx6PFStSX3My+0BuCY=@lists.denx.de
X-Gm-Message-State: AOJu0YycIwdQGef7pSDB/HaoIiGh2ZilyznOO+aarCAWLarW6Fv0btVn
 G4RqtlErSza2p0nP+IrmVA2BB6m0ygiSA5NZgRsSwxqSS3brmeNDV8ZE
X-Gm-Gg: AZuq6aJM0khM3bx93BBLJqkNEd7WavHrwIKpjIn4JdhhDgG5bvox5sHtF51nEK/wn0y
 NOWbd+gpwve/KR037WGjVT1RxRhMlEFYJlDsGTKjKyjjsT9RYFWl9uQ9C5i9a3G7YO4PtgIgPkh
 SNZgZNRF5x9WxZVNdQjslmOLitEQVkfWeB1h9+3nOfyCiMS11eklwNAkCteBd12jOc237tmFpIC
 Cu+sFyZN5sWopvtefQJb71jqftZDTbOliVDu5TrjhLnGU51EXP7ZjD5InACNnEE21G2dMYN1o4X
 3ZJCPyu8dtOfhWE4sNFIEcTd9Wt/huonF36TpU88ciYakrqW3XkcOoOel1RBgvuM1zhSkKlmj0P
 adKRB3giBWuq5LNa6nk7ETedJ9JwHCsoHHvInYUlUPWR8KANpL7zxJ/VcUqQkSAJHXnwbYPXMLt
 AE1Ob+8pZ70qNAOV0AyXtOnpouobtd9JWBuz6s6b/6NdJr+omUJur/FcrHVfmDwoXKN87tL8KC7
 RUyRA==
X-Received: by 2002:ac8:7f0e:0:b0:4f1:840a:c90f with SMTP id
 d75a77b69052e-506a677c49amr27994891cf.2.1770997603652; 
 Fri, 13 Feb 2026 07:46:43 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b20f240sm633932985a.40.2026.02.13.07.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 07:46:43 -0800 (PST)
Message-ID: <f66468a3-724f-2666-c043-84132ba84e3f@gmail.com>
Date: Fri, 13 Feb 2026 10:46:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] reboot-mode: Use actual cell size instead of
 sizeof(u32)
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, u-boot@lists.denx.de,
 sumit.garg@kernel.org, casey.connolly@linaro.org, u-boot-qcom@groups.io
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-2-aswin.murugan@oss.qualcomm.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260213112717.1256823-2-aswin.murugan@oss.qualcomm.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/13/26 06:27, Aswin Murugan wrote:
> The nvmem reboot-mode driver hardcodes sizeof(u32) for NVMEM read/write
> operations. This fails on platforms where the reboot reason storage is
> smaller than 4 bytes.
> 
> On Qualcomm platforms with single-byte PMIC register storage, attempting
> to read 4 bytes from a 1-byte cell causes the NVMEM subsystem to return
> -EINVAL, breaking reboot-mode functionality.
> 
> Replace sizeof(*mode) and sizeof(mode) with priv->cell.size to use the
> actual NVMEM cell size. Also initialize *mode to 0 in reboot_mode_get()
> to ensure a clean state for cells smaller than u32.
> 
> This allows the driver to work with cells of any size, from single bytes
> to multi-byte words.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/reboot-mode/reboot-mode-nvmem.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reboot-mode/reboot-mode-nvmem.c b/drivers/reboot-mode/reboot-mode-nvmem.c
> index b9af242520a..60307cce49f 100644
> --- a/drivers/reboot-mode/reboot-mode-nvmem.c
> +++ b/drivers/reboot-mode/reboot-mode-nvmem.c
> @@ -18,15 +18,16 @@ struct nvmem_reboot_mode_priv {
>   static int reboot_mode_get(struct udevice *dev, u32 *mode)
>   {
>   	struct nvmem_reboot_mode_priv *priv = dev_get_priv(dev);
> +	*mode = 0;
>   
> -	return nvmem_cell_read(&priv->cell, mode, sizeof(*mode));
> +	return nvmem_cell_read(&priv->cell, mode, priv->cell.size);
>   }
>   
>   static int reboot_mode_set(struct udevice *dev, u32 mode)
>   {
>   	struct nvmem_reboot_mode_priv *priv = dev_get_priv(dev);
>   
> -	return nvmem_cell_write(&priv->cell, &mode, sizeof(mode));
> +	return nvmem_cell_write(&priv->cell, &mode, priv->cell.size);
>   }
>   
>   static const struct reboot_mode_ops nvmem_reboot_mode_ops = {

I'm not sure about this. drivers/power/reset/nvmem-reboot-mode.c in Linux
always writes sizeof(unsigned long), and this is checked against the nvmem
cell length in __nvmem_cell_entry_write. We should try to keep our behavior
close to Linux's.

--Sean
