Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27140C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C80D819D2;
	Sun, 30 Mar 2025 16:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l/gAuYTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6D58171B; Sun, 30 Mar 2025 16:07:26 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6A880F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so33943975e9.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743343644; x=1743948444; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eNBwQDpFp8u7uOaVWAC+U/HbXaPaczRsc6RJgWUcId8=;
 b=l/gAuYTjZrF5RA6nUDdkzlX14gGOCg2swEHjrHZHkzOql6Skcg1CbF++VEyvEJi7sV
 ggkaKxGaklbgImKPmpthpxWcyTpbmm5vtpCUciq9jsC+kqJZnbyc0M1Ehy4bCcI1Hfnq
 WLP3EbI+gcf+r+iXomxNiHQyGy3Ba58entRWf46fPdi9HzIAnODzYBhneZ8OWJdMvr/b
 BJt5UIxFdTV/LJiNYfuI/EpjiBpfWd/sEomAAwEGNpHg3NhFJ2rj340vgmrsYcbzvbfP
 2W85nkih3x5RI0PpCF9NqsWXEmlrZ3L01zRw0vqu8sVpQ+z8T8xcOHlVTocCFvaIyTuY
 SBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743343644; x=1743948444;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eNBwQDpFp8u7uOaVWAC+U/HbXaPaczRsc6RJgWUcId8=;
 b=OrLj/f9epq2KGWnORf5wVn9S/yzEhFnjnLFnalVbyuEA32xAdsR+YUNBgpi8vzOftJ
 SvpeCcOCurtyqrbEdC2gGCjq20FLESx6jcFvBvtnR7XgHRmRsck2LEctq7hwSOYuJa75
 hbafbiGRIqrOawGdgcnBzzBUERwD07diCkXindcPnXGxWdwhHBxpvRTalMsxYSp2jMwx
 c4lUYQXfheyQ4YH4ofroKircoAU3TpMMs+YvpnrNtoWBeTvqphKZen1/5t+dZ0zBlfWb
 bVJTrzUzx1oFrxbppfR+EoKOzMB8N9XdpE9NDeIN9vGDCS/lpSYw3CN9j24vJpDQ71o8
 vdaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUal5xPnwcm17km3EzGkdrMPhjlgRbVT66GoDEw35oMGf8xMmNiJUBNdhlBuNXGaMB041TxPZQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyXHCno/jpDvtQM7EmhjvjVxk6L8uO4JK8/vQiBmCBUkEbCRL1J
 Hrn3vpqcQ0HGu+JyThEV7ShOGBGHEfRbtcTa6i9frOgJlKcpcH7BKpTXweWoLTM=
X-Gm-Gg: ASbGncvvGA610FwoIV2e/wjPz2ZO/tm5siylR0EaEoLCJJBxhlUsWK2RFpxl+wqaG+x
 gLgkwjBej0ZUcZCUW2gdFry0wiNLD3wVyrs9ri4/lnNeXSrh9yJzaB5dJUKU1tjIAzB5ocK0md2
 5NZjW9+ecrzUgkxiNXJe86TF1h3iLkiy7hVslnJvCchhaEpA4+M85sZTTi7KVhfg23OS482bXck
 aveltC7yFPhI0K5ukBHHpzSIWPhNkGHbN7+poHhdLw5Aq4+IjMeZZMVSQw5IH4uNn7zY3uwzT2w
 ePU0+S6x+2r+G7skIvx22dOQIdEncyfgWfR9oHzV5faahFr5spFEMDAu4FNwxi3xinGCljqN8PR
 pVMhCm+ix9TCohlppJOyeyz9EI542
X-Google-Smtp-Source: AGHT+IHQMbaGBTRlK9kXg9QOokVW9/yEBlT0mbnikDFIGzCB2guNnUowV3HADQAv0Mnw2QNEl5/VAQ==
X-Received: by 2002:a05:600c:21a:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-43dd09fd1c0mr48284895e9.17.1743343643988; 
 Sun, 30 Mar 2025 07:07:23 -0700 (PDT)
Received: from ?IPv6:2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f?
 ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e467sm8705021f8f.79.2025.03.30.07.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:07:23 -0700 (PDT)
Message-ID: <0e8e2669cd0c1f3588465002eadef64b37a3b15c.camel@linaro.org>
Subject: Re: [PATCH v4 4/5] rpi: Update environment to support booti and
 large initrd
From: Christopher Obbard <christopher.obbard@linaro.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Peter Robinson	 <pbrobinson@gmail.com>
Date: Sun, 30 Mar 2025 15:07:23 +0100
In-Reply-To: <20241220003447.2913443-5-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-5-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
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

Hi Simon,

[resending as I used the wrong e-mail address which isn't on the list,
oops]

On Thu, 2024-12-19 at 17:34 -0700, Simon Glass wrote:
> The existing values don't provide for decompressing an arm64 boot-
> image.
> Add those values and move things apart a bit so that a 50MB kernel
> can be
> accommodated.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G

> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Update the comment block with the new values, including compression
>=20
> =C2=A0board/raspberrypi/rpi/rpi.env | 27 ++++++++++++++++-----------
> =C2=A01 file changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env
> b/board/raspberrypi/rpi/rpi.env
> index 9b9fad82828..9ac9d6768ca 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -48,28 +48,33 @@ dfu_alt_info+=3DzImage fat 0 1
> =C2=A0 *
> =C2=A0 * scriptaddr and pxefile_addr_r can be pretty much anywhere that
> doesn't
> =C2=A0 * conflict with something else. Reserving 1M for each of them at
> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> + * 0x05400000-0x05500000 and 0x05500000-0x05600000 should be plenty.
> =C2=A0 *
> =C2=A0 * On ARM, both the DTB and any possible initrd must be loaded such
> that they
> =C2=A0 * fit inside the lowmem mapping in Linux. In practice, this usuall=
y
> means not
> =C2=A0 * more than ~700M away from the start of the kernel image but this
> number can
> =C2=A0 * be larger OR smaller depending on e.g. the 'vmalloc=3DxxxM' comm=
and
> line
> =C2=A0 * parameter given to the kernel. So reserving memory from low to
> high
> - * satisfies this constraint again. Reserving 1M at 0x02600000-
> 0x02700000 for
> - * the DTB leaves rest of the free RAM to the initrd starting at
> 0x02700000.
> - * Even with the smallest possible CPU-GPU memory split of the CPU
> getting
> - * only 64M, the remaining 25M starting at 0x02700000 should allow
> quite
> - * large initrds before they start colliding with U-Boot.
> + * satisfies this constraint again. Reserving 1M at 0x05600000-
> 0x05700000 for
> + * the DTB leaves rest of the free RAM to the initrd starting at
> 0x05700000.
> + * This means that the board must have at least 128MB of RAM
> available to
> + * U-Boot, more if the initrd is large.
> =C2=A0 *
> - * Limit bootm_size to 512MB so that all boot images stay within the
> bottom
> + * For compressed kernels, the maximum size is just under 32MB, with
> an area for
> + * decompression at 0x02000000 with space for 52MB, which is plenty
> for current
> + * kernels.
> + *
> + * limit bootm_size to 512MB so that all boot images stay within the
> bottom
> =C2=A0 * 512MB of memory
> =C2=A0 */
> =C2=A0bootm_size=3D0x20000000
> =C2=A0
> =C2=A0kernel_addr_r=3D0x00080000
> -scriptaddr=3D0x02400000
> -pxefile_addr_r=3D0x02500000
> -fdt_addr_r=3D0x02600000
> -ramdisk_addr_r=3D0x02700000
> +kernel_comp_addr_r=3D0x02000000
> +kernel_comp_size=3D0x03400000
> +scriptaddr=3D0x05400000
> +pxefile_addr_r=3D0x05500000
> +fdt_addr_r=3D0x05600000
> +ramdisk_addr_r=3D0x05700000
> =C2=A0
> =C2=A0boot_targets=3Dmmc usb pxe dhcp
