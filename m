Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E8E8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A188183C4B;
	Sat, 27 Dec 2025 15:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RJIv5FXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6877F83C4B; Sat, 27 Dec 2025 15:53:17 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736D483BFE
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so1756075966b.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766847195; x=1767451995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D8eh/bD6cjkVT6HPGYd/Bu1lCYGLA+08USdLkud/p6g=;
 b=RJIv5FXbyMrhv6kdOXQ8sWku2UeL3LDIW9z1QiBf8U0+isQw2eFCpdB82AoiIVst42
 bSSFuIQ4mFxw/35gMe/8DLmnRHMBPlMQvTaL5H1nfKuBBnHXB2I2+FYlfDDUJGGY0Q7x
 fphCk4BlXGYtBgc/t2S+9OffuUoIiDeEqpcI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766847195; x=1767451995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8eh/bD6cjkVT6HPGYd/Bu1lCYGLA+08USdLkud/p6g=;
 b=KEFpZBK2XKLl2goV688oMUGdFW0OV96d+9u252zljfdleD3kxnE3a/2qaDAKFURnah
 AVWO+dUwT3brR/OllDAJnFEWvxH3nki0yij8B/vkXrNiaS3XzBc52x0OqZEfKCFW3nZ+
 rrOiNzBdgMfa77t65kyHHu9C8QpLSWRrnZf/yq2a4xfck5BxUtfVS6X5XI5k5ZFTajWJ
 RyL25L5bdfT/RtfWCFJ7V0lNdTiyuBqDoPzbiklQVEjeyjc8K7XUueMgxCVIsUT8SZ/o
 ewIgbXKpi4QJKsPf80q3nnb1lCtj4CTk1Ya51kRT8IbLX4ZyYFcxu6csSWBBFNyAydyu
 VL1Q==
X-Gm-Message-State: AOJu0YzYzGev7aT843m65Ytl/hnBuY/HI/zGE3wtZAFbJEjnbNXwjVgr
 39xM9Uym9w04wceM6wGX4mAwB0ig6/tYrj+9Y9JAhX5OWbKq3e3//6lGOvXzLYGn0SSRG8zZSKz
 ZTOxnf/zVmr0Mn2m71dwEM38qpJeBOBHRTwxT9TLsZaY2TruiUXM=
X-Gm-Gg: AY/fxX6zGhJrLuyvyr/W1y6jzwlDv7PmJdH60wM8T78eqzJy2rfD1ZgHtLm23e0stMY
 wka2u4q0c/f0vCYyBGUyK8eCjg+gn0wB/AGtbS6yYZwGJXPSkQTCRZBgAmzn00t9O24LHJRCvuT
 YFpJo63+2/7Kg2fKPVNi7kqBuagS7mStZgMfycvfRRjyIlUuHt/PjNasfwavmy6gGHCvk/5lGk9
 ZZ6NgPb4CulQjt47CV6WFpEM7hZqHrq6D6wz/x9DncSTEX8Ou8tteHTFIet4O3U2Z2aq212r/Ux
 wHuS
X-Google-Smtp-Source: AGHT+IH911Ph4/V9o5KM2jq7IvS3tSTSRYZ41KNw0osXp+4CtX0cwiJcW8CA7snfaMIfo+PSKe9dVTJbSQ1czL+mPM8=
X-Received: by 2002:a17:907:7f20:b0:b76:69d6:f9fe with SMTP id
 a640c23a62f3a-b80371f1939mr2786716066b.60.1766847194932; Sat, 27 Dec 2025
 06:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20251212102621.2888015-1-pranav.sanwal@amd.com>
 <20251212102621.2888015-2-pranav.sanwal@amd.com>
In-Reply-To: <20251212102621.2888015-2-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:52:41 -0700
X-Gm-Features: AQt7F2r9CM1LRA2mQKQdiNEyVtxh5Jjy3sKp-S2fl1BJZAwEnZp5kkaMN6CsShs
Message-ID: <CAFLszTh5mmWVMUP08XvP-f70X+GLUhfC_phBM0j=9Tb+LsnEHQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fdtdec: Add declaration for get_next_memory_node()
 helper
To: Pranav Sanwal <pranav.sanwal@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Pranav,

On Fri, 12 Dec 2025 at 05:50, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
>
> Add get_next_memory_node() function declaration to fdtdec.h to support
> iterating through multiple memory nodes in device tree. This function
> is used to enumerate memory banks when the system has non-contiguous
> or multiple memory regions defined with device_type = "memory".
>
> The function implementation already exists in lib/fdtdec.c (lines
> 1298-1305) but was missing the public declaration in the header file.
> This patch adds the declaration and includes dm/ofnode_decl.h for the
> ofnode type definition.
>
> This is needed for platforms that require early memory enumeration
> before standard fdtdec_setup_memory_banksize() is called, particularly
> for dynamic MMU page table size calculation based on actual DRAM
> configuration.
>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> ---
>  include/fdtdec.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/include/fdtdec.h b/include/fdtdec.h
> index d9fcd037ed2..87e97635ce1 100644
> --- a/include/fdtdec.h
> +++ b/include/fdtdec.h
> @@ -16,6 +16,7 @@
>
>  #include <linux/libfdt.h>
>  #include <pci.h>
> +#include <dm/ofnode_decl.h>
>
>  /*
>   * Support for 64bit fdt addresses.
> @@ -198,6 +199,28 @@ struct fdtdec_phandle_args {
>         uint32_t args[MAX_PHANDLE_ARGS];
>  };
>
> +/**
> + * get_next_memory_node() - Get the next enabled memory node from device tree

 * (blank line here)

> + * @mem: Current memory node to start search from, or ofnode_null() to get first node

If this is to be exported it should have a fdtdec_ prefix, e.g.
fdtdec_next_mem_node()

> + *
> + * This function iterates through device tree nodes with device_type = "memory"
> + * property, automatically skipping disabled nodes (status != "okay").
> + *
> + * It is used to enumerate multiple memory regions when the system has
> + * non-contiguous or multiple memory banks defined in the device tree.
> + * The function continues searching from the given node onwards, looking
> + * for the next node with the "memory" device_type property and checking
> + * its status property.
> + *
> + * Context: Can be called multiple times to iterate through all memory nodes.
> + *          Pass ofnode_null() on first call, then pass the returned node
> + *          on subsequent calls until an invalid node is returned.
> + *
> + * Return: Next valid, enabled memory ofnode, or invalid ofnode if no more
> + *         memory nodes exist
> + */
> +ofnode get_next_memory_node(ofnode mem);
> +
>  /**
>   * fdtdec_parse_phandle_with_args() - Find a node pointed by phandle in a list
>   *
> --
> 2.34.1
>

Regards,
Simon
