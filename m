Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC083C982D1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7721283015;
	Fri, 16 Jan 2026 18:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eBNERVAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D384F83935; Fri, 16 Jan 2026 18:32:58 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E6E82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-40429b1d8baso780214fac.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768584775; x=1769189575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+aKf1Vcmkjv2UbUd58KCojo/zjEz+N3BYmWIQu2yEI=;
 b=eBNERVAiVi8M22nIImxE+pEGEs5gPvcl4NJTE41w7ScC5CngJIPv3QJfyo82gXxwcy
 4pLD9FzEhMXc2OrFNs5wVXBLstxKk0NvMYELzz68YpNM8h/hqRXkiSmCbSXDy/MJF4j/
 Qd42d8LwzH7JtCZyKIhuMbCSC90ePXIYZcfhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584775; x=1769189575;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a+aKf1Vcmkjv2UbUd58KCojo/zjEz+N3BYmWIQu2yEI=;
 b=fxkHdOeTYm70aHGE+0umRZ1h7Ncz0uOqGEskgCtNq1aCL2T86f7V3o0A/o1NwboQFd
 dY2YfphZ5/x7d4YWrffB1T4x+1mKyTrFFVLUHVtdVtw7I7ytYpY9yTjaMoszMBL5ZOyD
 WSWtsM3FyDskuXTF14twgTmxFmI4GrFJo7AwS2SDeE8VfWbZe0H4dBXHgW/Q8wBVfKTz
 pyh9mxr75+WDeIb5zjc1GMYFBkPEU3/i9thCEQvq9y3KRneOtgVchctAYtOUQyAwDsCf
 cEPbeWrXhhLByNaFQVcnuXskBSlyHZSrfDuUjKfiARL3grMIChFktSt7su7ZKEsGl60/
 ct+A==
X-Gm-Message-State: AOJu0YzlqROaZl4G1dbWBraWy8kpAxRAqSLcnnFxpOaMXxZ1aixgnvGg
 UzcusBiTcuwgGAjCscOjaMjCkiqt0I2MC9KC9C/R6razM5qZ0hYlWtlzs+UAU0B2hy4=
X-Gm-Gg: AY/fxX4rkJSn+3Ln9GRqy9nOcKgd79Ygvyd65+POC3s5Lluc4n8r8ersQz5HzxDEKYu
 Xd/cQvLXJfvdmQpHigbFFSnLDavvrZM+/crU2Zz+4D+bGQeZDYh2Q0kfQgVK9Up5Nbgov1lzNT3
 DmJPeBKHg7MoyOLeL/lTFdVRh8OE60a11s+iwxMBK2IPaNs5TFCeL3ztStHEx4Rtl8OR/dZfEIz
 UnKxam0YiTI4NA8NclsYxcSvnD/hBJxuayDUzYC4hJB1bxX7Ch8rRri/PA51B4VckHgxxhjj9cF
 dxvIfkWR5r/F9pwvowNzqx6/QsG3veDIR06ca+Z3/mQW+zDAx4DXuA1kIOMSt6yosipCZcxyBGH
 3VjdW4YlD6uM07XAnY0LcCQ0eR5qd85+jlkLDlMIq9qZJXIcchAF0BZdJormbDBJX0C1rWvnqYk
 5l4gziU2jCtg76qKWi1G46SqVTCwXsUVCI0/e5/6MuGlSLujsTczGnXYofzG1Zt1L5XS1btL71B
 vDMWR/LbwJxlRJpBoypsHc6awtkik7cInxjL3elh1ZAsNDn
X-Received: by 2002:a05:6820:229e:b0:65d:3c7:b63 with SMTP id
 006d021491bc7-661179c3ef1mr1403450eaf.39.1768584775380; 
 Fri, 16 Jan 2026 09:32:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186ca7aasm1494068eaf.2.2026.01.16.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:32:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
References: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
Subject: Re: [PATCH v4 0/4] video: simple_panel support for am335x evm
 panel
Message-Id: <176858477451.4075554.12235045641218267787.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 11:32:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 05 Jan 2026 10:36:25 +0100, Markus Schneider-Pargmann (TI.com) wrote:

> this series adds the capability to define hardcoded panel settings to
> the simple_panel driver similar to the Linux Kernel and adds the panel
> used on am335x evm. panel-uclass.c is extended to support get_modes()
> for panels and drm_display_mode conversion. In a second step the tilcdc
> is extended to support OF graph to be able to connect to the simple
> panel devicetree node.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] panel: Add missing comment for the timing argument
      commit: 60f5170c1fe2a438e36b71eea0237ca166e6ef23
[2/4] panel: Lightweight support of get_modes()
      commit: 36829e951bfeddb7b2e9eaa93223d646577fcc02
[3/4] video: simple_panel: Add tfc_s9700rtwv43tr_01b
      commit: fe2547b78d0eb6b1a2157c735d92bf2a55dc0443
[4/4] video: ti: am335x: Support OF graph
      commit: de3f687e6e85ab07be4488a2ccfb5077da121652
-- 
Tom


