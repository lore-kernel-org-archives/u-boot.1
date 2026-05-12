Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13F8CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4973B8460C;
	Tue, 12 May 2026 21:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iue+e4a/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F82083E76; Tue, 12 May 2026 21:31:55 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0293284099
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7dc85b74so4978198a34.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614312; x=1779219112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+WHLFcTI77GS/0JJnRR+4WcZ/Jqh2wXDRXyte/CYkc=;
 b=iue+e4a/FcRfumkhZEo30TIsc1cJLgnQl6zclHU+EAQSHoqvdWZOdvt798a5B5AB96
 37ZG0MeDSWfnPS37ZNlq1N57leCW0t5LJPaOE4PFYQMhpzPAtQJ/XtJobn7NNX+WktFg
 5RKJyDnxlfuVLKlhuohqAu3Q2Npk1fnOd+XmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614312; x=1779219112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+WHLFcTI77GS/0JJnRR+4WcZ/Jqh2wXDRXyte/CYkc=;
 b=o4veb2smmKOS7ol5nN9/5OwzNKcdK7wnRtP77UGfSZs/gy/6hvFv8P+Qp9pYwA9wW+
 kd0jQ6QXbkMLfukd0Urpdn6Mmd99LzCZttjWBKGh+vs2wZzsI1rokV23JSb1XFo/5ot7
 XP784gDGAyxshKs6lW5EGtFxpkloj6iXl51fe/ikKtZnitQFQ6dRV3Y83fKhLu8felwr
 ZG0aORoe9yKdCp2HpQ7uXoKyi5oNBGzWu+byrzsJpy/wzK6z5cuK3yS4xaVRhwbF6Jfz
 eL6eqS0tKLfhObUUTvboydC7QwC7y/1faHrA2WPnccUeRfYwGTxmy+lvOJqzbHUAW0XL
 FxUA==
X-Gm-Message-State: AOJu0YxvP8GkXC5zEYuE+bmY5FLy2ZIviQL15TUwHj7BV2nihlXW9qDI
 JcUgOPJgSFgF9XQSXTICdRbl2K7o3Es+247vn4Jnv7fLYsWEWQk8BkbjGtxPzzRP2D2bOIg2opW
 FTV1bSI2pKPuf
X-Gm-Gg: Acq92OEaCS6Mp8hi/zgXd79yuMXsLk18qQBJ+i20jswhvoG9aT0JqQKBzjYWuolZvUU
 rV9bIScGgjzXi4ZuyJoWiNGBdRsKcoTHy7f0V6MOAEjG7WwgZCtSvaRby/sf2SHv7+K8IkpxjCB
 j/6IJULbj63uZtVJXN+NpaADIb4ehiQTiCIiacKwRwPm8yArfHqoag2qACs246d1uYhRDe/2xU5
 jxbJf2wdmnLYhnxNuDYedLTJJvO+9h9yH6L45XMYdX6uZhtrUZCCFwI8Z0D29UPt+dgLIDDvfFf
 R/1usB23RJp9+pf2U1CCkyBKay+pL7nz+o2CqG1DL/IKGt3WFZ3RffM/UX5kTwR9c0GbDWhGKMj
 xWLF3Gn0nvhQe5yEDYFktLVnWjN4ZjZ+lTwYiycsfXud3P7sM0etUya+hutgiM++F+tny1uFO2z
 zflVxURstkMy7rzvWxVF0gVRkaxhAuJOCF268gFMCnE4S1KSZPhSYJnpZUroePjlTRD4mHQpnSY
 2F+haQyRVrF09Bu//NDthDHO2AXkcAgm3oUZ/yWqHNUFT2E2w==
X-Received: by 2002:a05:6830:6488:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7e3da0cb403mr47809a34.9.1778614311609; 
 Tue, 12 May 2026 12:31:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
In-Reply-To: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
References: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
Subject: Re: [PATCH v2 0/3] Switch Apple silicon boards to upstream device
 trees
Message-Id: <177861431099.3279584.7416693653944228140.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:50 -0600
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

On Thu, 07 May 2026 10:05:48 +0200, Janne Grunau wrote:

> The Linux device trees for Apple silicon devices cover now most of the
> hardware as u-boot's internal device trees for M1 devices. Linux has in
> addition device trees M2 and M1 and M2 Pro/Max/Ultra devices which were
> never added in u-boot.
> The most common use case for u-boot on Apple silicon devices does not
> use DTBs from u-boot but passes runtime modified device trees from an
> earlier boot loader (m1n1).
> This change regresses support for the SPI on M1 and M1 Pro/Max notebooks
> as SPI keyboard support is not in upstream Linux. This regression is in
> my opinion acceptable due to the limited use of u-boot's DTBs for these
> targets.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] doc: board: apple: Mention M2 and M2 Pro/Max/Ultra SoCs
      commit: 4587d7180b08085779203ac6ea015c1c1750d523
[2/3] doc: device-tree-bindings: Remove apple,pinctrl.yaml
      commit: fad7b438f00ecbccde11e7bcd777e72dca161400
[3/3] arm: dts: Switch Apple silicon devices to dts/upstream
      commit: 5aec4e746f9ef2421c2078ab93f4d3dbb81a519f
-- 
Tom


