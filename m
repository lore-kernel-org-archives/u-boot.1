Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62839CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA93183FF5;
	Tue, 26 May 2026 08:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VZMkEXob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574EF8404D; Tue, 26 May 2026 08:10:39 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F831803C6
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-366330b6751so8021836a91.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779775835; x=1780380635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y9RDd9saTcRoq+0tLaR7HI1wm15wyeyBGhfTv1e5p9g=;
 b=VZMkEXob9+0aMaGD0Z11Is5YR8q2l1IvjXO3cDV3qXmV7S+2UBgkh4AJalqwxAMO3M
 xmNkEiMG/y9/e9yGGQ3yOszQTYZ/EyIkJDFAeBnVSDxzuyFBuVj92egYthlfQF1kzB70
 zkarnaoOBprvXeoVEG1RJafcIUgcaxhlzy+xoHBjUGIpV2WpbPbn+h6RDhLUo2oMJVZx
 R82O+57Ir0zFidY9jO8Y5+QZSr+MdHw0xVdCYIAuQYWzo/Eog4O3Bjxge71taxApAt/q
 D+oq+g45RvwgLwy198FcPgkuP5I781mgrhtaH1VLoT16w68z76/bNkcGmvBG3cvaAU3f
 295w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779775835; x=1780380635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9RDd9saTcRoq+0tLaR7HI1wm15wyeyBGhfTv1e5p9g=;
 b=DXvCP3EA44VtZ6DKVtrj0+eYn+DWmHwPSytkyT5Avo46/nmDTJxmDoL2HqvUO4WYLR
 9NZ0CKeCiWpP4QpwrOrENNGlzxaSN/9DY/uVIt4I1baUxCc/Miw5VJCuFUMH6RDat0gc
 Yxrd/EjghPZdBqKm+FRxrbAWLYzG3kGZ7Nz/16cQsAnr0FuS6NGAgJVWjn8dmrWfpG4b
 H0NAQjPJfgYrnnDBSaMRvn/5zhaU9cZYpbdf2aN7di6ks4g9pWSjSY3ItYgZ66vigrNe
 ruRJ3ePKZlLCL2WuWYkzgWCKzp71+kfGILk6pvRItQOjkqVZCDDgegPLOkOA4W+HALPN
 ToOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Sfa1IysRauXxVogNB3qcD644Tyr6/ZKH/EiroabDMzMjivMFE5G9xq7iYR8a7y1+Im+qTmtA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx03FJARaESN9qU9OhUcK2wzXu1wlcpfcpH5QRcmOa4oHS+YzkS
 EljSdfjlWOkbFt0VSPQCsateFiF4U83v90wXF5VcGzVCNWE5lL3f3bGL
X-Gm-Gg: Acq92OET0EIMr5oYLPgM48JYuB5YSfwtXrgbBtEzDfLMWtUnwDPvRWoU6IakTd9XHPI
 BuxNkc7+7Ln9svbAvezWpq1mWsl4Kaq5kMljpx2Vcl/2YM4R1VqrvPsXPcucndJBC+6OGwat0K2
 K5nEJ9/SQoAq4jkgSSWkM1N1BP7vgFzCZdeRGuwgLPnQq+OdufTF9+gI1AUYa8XJA0nFkm2ZKSK
 xewYmJ2HhvfXlBdL8Oeagfw6c7d4ZI85SdeMs2l2Mp73+mtx/nq+D2qW1h4SytuNy3UH6yy3kIR
 kNdjbta+GFWAviVoFQa34nmCtgp/z4p9sWi4Di3LrRW6cEX/B5U5smIHXS2ST/vHU04GZxO4KeD
 TrxwQ4hZEj6imF+prh72IcFxfCDhjWNsigzKeN/LtcSy3ir+9q+tgTBhMP1tREONuiR8FbFSHbz
 Z7KB1WVcnNJj20xCvevn9dg1gBBVHXJFst
X-Received: by 2002:a17:90b:2290:b0:36a:72d6:8cc0 with SMTP id
 98e67ed59e1d1-36a72d6a600mr10166188a91.13.1779775835245; 
 Mon, 25 May 2026 23:10:35 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:c0f9:4c89:3cbe:3712])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b09698b0asm356279a91.3.2026.05.25.23.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 23:10:34 -0700 (PDT)
Date: Tue, 26 May 2026 14:10:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: bmeng.cn@gmail.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [RFC PATCH] virtio: Add driver for virtio gpu
Message-ID: <ahU5WIYwWLxeM9oY@google.com>
References: <20260523055000.1059981-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523055000.1059981-1-daniel@thingy.jp>
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

Hi Daniel,

On Sat, May 23, 2026 at 02:50:00PM +0900, Daniel Palmer wrote:
> Add a basic driver for virtio gpu. This allows for a video on
> qemu virt machines.

Cool! Thanks for doing this.

I was also planning to look into adding support for some other virtio
drivers, but I've been traveling recently and haven't had the time to
finish them up.

Video drivers aren't really my area of expertise, so my feedback is a
bit limited. I just have one minor comment below:

> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
> 
> Since the m68k virtio stuff is now in next I thought I'd send this.
> This patch is based on next.
> 
> This is a very simple driver for virtio gpu that works just enough
> to create a framebuffer that u-boot can use.
> 
> I've been playing with this on m68k and its shown that some of the
> framebuffer code has some endian issues.
> 
> I think this is useful for testing the framebuffer code on other
> arches like arm, riscv and so on.
> 
> Open to comments, ideas etc.
> 
> +static int virtio_gpu_resource_create_2d(struct virtqueue *vq,
> +					 u32 resource_id,
> +					 u32 format,
> +					 u32 width,
> +					 u32 height)
> +{
> +	struct virtio_gpu_resource_create_2d req = {
> +		.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D),
> +		.resource_id = cpu_to_le32(resource_id),
> +		.format	= cpu_to_le32(format),
> +		.width = cpu_to_le32(width),
> +		.height = cpu_to_le32(height),
> +	};
> +	struct virtio_gpu_ctrl_hdr resp;
> +
> +	return virtio_gpu_cmd(vq, &req, sizeof(req), &resp, sizeof(resp));

IIUC, req and resp here are used as dma buffers. I'm not sure if it's
safe to allocate them on the stack. Are there alignment requirements
for them?

Regards,
Kuan-Wei

