Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83BCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 19:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B818071F;
	Mon, 16 Oct 2023 21:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA56086BA4; Mon, 16 Oct 2023 21:57:34 +0200 (CEST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3975186D4A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 21:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robherring2@gmail.com
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-6c65d096c96so2581145a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 12:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697486251; x=1698091051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgQIgwOXkE8+0o51RaJzdyOkFFFWSreK0o8H4z9cVpQ=;
 b=lxBTRTnJJYa0cuSojIgCYeJUvojO+NyAgWO9IHrdbPqN9RyyuChPbwl1HcGi72MOQ3
 EZY2w2ZAycaaEwGyXg9auB6ZvPIRPtNNkkfzXloCpIJjJIhGQTb9abNzob2jp7Pqvoj0
 Fyh0GDY9ExBgBEkcVyiZdUmoqOQlU60nX/cxIphA7tM3b0FPQ0TjJQM2AJhwf2xpNTvI
 QMAgPuctoqhfYfPKgHyREdYBtUeARFggWnPxVDdCfnOxOcP266iz3wDMLy0q+bHroAjB
 W8oomUz5eoLlcJOYBSDwySoK3GVxJV/hchNzzJXc3IIqhZLBYBS39rIT0N8d978xoN8O
 D7Hw==
X-Gm-Message-State: AOJu0Yw+1ZOkbRWH+T3gsEsY8o1jQfvieLRmodiigC0ix9iVuzG/s861
 Iwb/O92CuLGKNieO6OMQnA==
X-Google-Smtp-Source: AGHT+IGoyMGj6H9sD/fs05ifW6mHn46aUoo5Qt+hMR2U+JvUvpzoojkGcwQxcXOLaOmM0ug4oQUITg==
X-Received: by 2002:a9d:4d17:0:b0:6b9:cfc3:65d1 with SMTP id
 n23-20020a9d4d17000000b006b9cfc365d1mr218237otf.17.1697486250789; 
 Mon, 16 Oct 2023 12:57:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 d26-20020a0568301b7a00b006b9348b6f51sm1813787ote.54.2023.10.16.12.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 12:57:30 -0700 (PDT)
Received: (nullmailer pid 3575170 invoked by uid 1000);
 Mon, 16 Oct 2023 19:57:28 -0000
Date: Mon, 16 Oct 2023 14:57:28 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, lkml <linux-kernel@vger.kernel.org>,
 Dhaval Sharma <dhaval@rivosinc.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, Guo Dong <guo.dong@intel.com>,
 Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>,
 Gua Guo <gua.guo@intel.com>, Chiu Chasel <chasel.chiu@intel.com>,
 linux-acpi@vger.kernel.org, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v7 1/2] schemas: memory: Add ECC properties
Message-ID: <20231016195728.GA3574754-robh@kernel.org>
References: <20230926194242.2732127-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926194242.2732127-1-sjg@chromium.org>
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

On Tue, Sep 26, 2023 at 01:42:38PM -0600, Simon Glass wrote:
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
> 
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v7:
> - Drop unnecessary |
> - Add a blank line between properties
> 
> Changes in v6:
> - Use a number of bits instead of a string property
> - Fix inidcates typo
> 
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
> 
> Changes in v3:
> - Add new patch to update the /memory nodes
> 
>  dtschema/schemas/memory.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied this patch.

Rob
