Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54DFC10DCE
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 08:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF0186EF1;
	Thu,  7 Dec 2023 09:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eXqFpifD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB51C87124; Thu,  7 Dec 2023 09:37:40 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9020D86E5E
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 09:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332c0c32d19so771505f8f.3
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 00:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701938258; x=1702543058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MFYAQJcbliMGT3D4kBOifEL3kDjCqoAlJPtzq2V7r5s=;
 b=eXqFpifDIjy47KiMVuqAryH34i8k2a4zlUPQJBOJmSkWSBTg79yPhO6SYck61pw3R5
 vZyHL2WP7JzZR/1FdmZU+hl+9IwfNM5JoEctBiUzhkKl54ShOnjJNv0nFgPetoH1un4C
 I5fFCmU9NjptmU0nkvRqadaPf5DBLFZ8d8r8LD4Qi2m2UG76qRE2LsuCjFxtNzpqSieK
 toX+iUTsKOoaU82j2ocJ3fO/ERiLWrm8xhkbtD9SiNDVnwDih/GA9zpuvKbL0x+2KS28
 AOxgxrX8LNCeBvvZnR4h/fwwz7M9lvFfEA6GRg25PGU0ZnqhGWqFfLzJE8cc/YY8jrpW
 DdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701938258; x=1702543058;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFYAQJcbliMGT3D4kBOifEL3kDjCqoAlJPtzq2V7r5s=;
 b=hiKTKdPF5riCI6a0u542OzAOWF7ON3LQUQOczpmC560MzdiuAsHJGPPgMfJl7taTiS
 EfR9Oucwma0U7pbvBTybiZqEuWADis8/Z8XjvxqZgemzcsfDqfWZvuWZtcOUco6iHYSB
 Ovu1OiBvyMHK+bMlqH+ZPZAoI2ngRsaYGmPYf62nmctkMdHYXPW2N+OWgDeFr0TLSySe
 qJd9l+dul/9PYFRAEuOxYARdjTknGmJbEH9L5u8Gcnw2sfmgS7ofaOZ/CFpBCwLglaLK
 pnpLHFXap7qAzKdFkexK1eThWyfQgPiSeIZyGtgOqU29OxpUz00T6I5CPr8Lwd+5xM5M
 A3MQ==
X-Gm-Message-State: AOJu0YwZ0JYP5TdzOKrwxS4tJRtsmXeIE1i/6zFQ9e0wTscL7Kbb9j5z
 redYmbXoO0ATN4Me39gjHWPXf/azDLzw1taOO3K5kt1B
X-Google-Smtp-Source: AGHT+IGZoqe1Ds9m9O+sUhEjYW6tx5jHstgF/NpE6GJ/eQChBP+5qsHppkcAUAReWBBoli+W1uACAQ==
X-Received: by 2002:a05:6000:1e86:b0:332:ffaf:d215 with SMTP id
 dd6-20020a0560001e8600b00332ffafd215mr1098886wrb.22.1701938257970; 
 Thu, 07 Dec 2023 00:37:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 o13-20020adfe80d000000b003333d46a9e8sm813637wrm.56.2023.12.07.00.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 00:37:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231206-u-boot-m2s-fix-usb-gadget-v1-1-1c4c66cd10f3@linaro.org>
References: <20231206-u-boot-m2s-fix-usb-gadget-v1-1-1c4c66cd10f3@linaro.org>
Subject: Re: [PATCH] configs: meson: enable missing DM_USB_GADGET
Message-Id: <170193825733.516078.7333267804190703458.b4-ty@linaro.org>
Date: Thu, 07 Dec 2023 09:37:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

Hi,

On Wed, 06 Dec 2023 10:04:21 +0100, Neil Armstrong wrote:
> Since commit b96640cbfb ("ARM: meson: g12a: switch dwc2 otg to DM")
> and commit e327e2affd ("ARM: meson: switch AXG & GX dwc2 otg to DM")
> Amlogic boards now requires DM_USB_GADGET to have USB Gadget to work.
> 
> Add it to the boards configs as returned by:
> $ grep -L DM_USB_GADGET $(grep -l CONFIG_USB_GADGET $(grep -l MESON configs/*))
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] configs: meson: enable missing DM_USB_GADGET
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4005729c0de234ffcf36465f6471755617b42375

-- 
Neil

