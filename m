Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC724CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A560186E0F;
	Thu, 12 Oct 2023 05:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BG7FXYUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC15686F06; Thu, 12 Oct 2023 05:45:00 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95B286EB9
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d9a5adc8cefso592271276.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082286; x=1697687086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1CoGa5ugLC9A1kk4tc8VtiK0WxtB93xdthj2/iieT2A=;
 b=BG7FXYUuKCl/7LOvvbGHmkxGvHTnbuxuiRFrae2+UU0IFsBWPdPGe0reMYH3eiz7R4
 j2RqKIp/2V2OhU0R1vq5oySKpuctOjEULv8PTxQ0NyvJdPGyXiLZWE+cVNcAf5qU79Au
 /8Y8Q7vQl6LW4G0WAM7FDlOMYlTEYr9Ji8jwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082286; x=1697687086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1CoGa5ugLC9A1kk4tc8VtiK0WxtB93xdthj2/iieT2A=;
 b=qYefkRWwViF7Xhsw4ibXGTXOBNr/rmWnDwQEiQmahTKUQv9/citT9e3CDfrbfZ070G
 FgruQENtIQ2yVcOrG0PvplHMKLWAzD587KIhkTM4LkDd6FEEZws/VIgVNx/tQo73zICu
 4eTbyJlcRU+MqO4sUBPIL4cjqoirsQFzbzI09DImIqyV/Bn7inCdapnB2KPJ10WOpuHM
 6fsUX5mCAHo1JExy23yKuTbmuHMon+v2AaxcaVW9dCgIcPCN14EU0eRDaEy1gz1TgBrO
 q8QQtUg0xAZK6hwnu1c/KoF8Lrg03UP2lymez8u6pZYiwEc8/4eAzA40g9vEPr4FlWu4
 KETQ==
X-Gm-Message-State: AOJu0YyQEGL7qnfhnLsbmJAWGx39Qq8P4ZF3B8lr/3RwlZg21HpXpmhh
 KE51hrR0ogK/QtYdpxW6MFEq/PiO/PZW0l9dmf2+nA==
X-Google-Smtp-Source: AGHT+IHMnC1CGwuXr3np0+WFG7fV4/wmJOwPZtxgNHi7crJAirWCfh6Dhtwfh06JC9ntAJTJHcETAo4sSew5G1g1eOU=
X-Received: by 2002:a05:6902:1003:b0:d7b:3917:460b with SMTP id
 w3-20020a056902100300b00d7b3917460bmr26565562ybt.52.1697082286043; Wed, 11
 Oct 2023 20:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-6-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-6-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:38 -0700
Message-ID: <CAPnjgZ2xurcAbPWnEdCvTAY+g3oeZtnjriOxfa9SvJZNrgvv6w@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] pci_ids: Add Red Hat vendor and device IDs
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> Red Hat, Inc. donates a part of its device ID range [1] to QEMU,
> to be used for virtual devices. This commit adds several typical
> devices that are useful in U-Boot.
>
> [1] https://www.qemu.org/docs/master/specs/pci-ids.html
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
> (no changes since v1)
>
>  include/pci_ids.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
