Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222E6CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA24F83642;
	Sun,  2 Nov 2025 20:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZfTCF+kg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46945830A0; Sun,  2 Nov 2025 20:54:30 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE84E8391B
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b50206773adso866815966b.0
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113267; x=1762718067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dasx1mFZ5d4OTQh+gNM2YZr3Q6SQV83R1Zdq3G/LhOo=;
 b=ZfTCF+kguNJlAQ002FnaWQ91IKg1MNltgYgQuxyMhWHtJrYtsnNaiBjmZMt3bor1xu
 DIVqKT5xkQQtrG8cTGwUjHBGr9mnKN9+gw297Ml6m+NeWiAoBSng37Z0qFIu/Y8ZInWR
 SZY6j6yeK8YTnnkMRAhW1rF/uGjrqedqUuMnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113267; x=1762718067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dasx1mFZ5d4OTQh+gNM2YZr3Q6SQV83R1Zdq3G/LhOo=;
 b=jxCdoTQbLxdEhRdYSOZWKb/Srke+o1WJHe+/tN5o1MdhPHtBxXCPfnYtZtOneFzvD2
 AjT1sstwK7NzEpt8ilVZ7Shw3JVJMmB4wBFYMKah9uLhezQMHK38zbIiTn83E0z03gKG
 LjBYtBNyRhq4tmWcOmWIwTcM9VkmHE9L6fiHZI14G5IZOZX0O0Vt+wjCDvbO2JSCOGTu
 FeavGMR+R5/vo4wthaIu6Q/MNE34ROQ8TeWgw6yMf7COtDCePbVdUvxjsa9eQn7hQAdY
 sb+DFy4jvrbzt+mgFfzShRAOldiMWdJW6h8APV6xft9GEfCkgZuIYO17HVx+JKSRUp5X
 bGrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUl3gJoYnxrFwOZq6WyDGto54x+ZxO9tgzDrXsO06zw2uHBYq6sjTHSHwtDloeSD80o2qSCmg=@lists.denx.de
X-Gm-Message-State: AOJu0YzE3J68yGkgYDrjsb7sQkjUZ1+wrVLni3WvhAqV0tvSMq+0l/fn
 eY9ROpchRgKagZsZl/YErr7KMq5aDY6gXDez+Txc4yxIKLfrU2Vc6kvQaaCU4ve1cE3IA0i19mz
 sE51apnDQsbCciFrbxdJKrDcR5ksisWtZDsrQGd7F
X-Gm-Gg: ASbGnctjzP76ye22qfo5/hU4n7eKAGQqsfjW0nGZlDiKZTm+Gq9cwxiBUddDAhs1dkP
 aFWEc+9NPOeNTHSA6jhiXd2zRRLMAK/PYvPQgTjZUQXUVjjMi7+6zS/0rL1wMsfgcH0c6sYu7PO
 sFheFnoJlTLplQ1MytsmDpkCKunAUJtxbJA3uWobXiWBI5juagHKkHjQtzeOXbmt7Pym0N0x38D
 8fFDkkrdAXKmewDl1OqQHgPCWMWTK5GpuXojRzS9X/pBwQY1V+orXxqyRk0sA==
X-Google-Smtp-Source: AGHT+IGZPHliVnIuUF0XGOXtpmtcUOa4lb8czD/1Qf6CGiXzJ7p0LbhTUXJ4SfKH+jhsmanlc0ZA1aENkI4nOS/XAqM=
X-Received: by 2002:a17:907:7209:b0:b6d:ba71:a17f with SMTP id
 a640c23a62f3a-b705212b184mr1702166566b.18.1762113267171; Sun, 02 Nov 2025
 11:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:47 +0100
X-Gm-Features: AWmQ_bnEhxVgC-QdZCWPeV-dSKbk5clPBuQaBnE5O--hmYQuP5zUHJfh8tNEF2Q
Message-ID: <CAFLszTjh2E=TgmAZbeCLgPmZ6-Do75vOTkJc3d_Rw7Q4Nf_V9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] configs: CONFIG_CONSOLE_RECORD=y on
 qemu-riscv64_smode_acpi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 31 Oct 2025 at 20:59, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
>
> For testing ACPI on QEMU we need a defconfig that supports acpi command
> test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/qemu-riscv64_smode_acpi_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
