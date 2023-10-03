Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592D0E7AD41
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6DA86E26;
	Tue,  3 Oct 2023 15:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kyJgvAPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D216987257; Tue,  3 Oct 2023 15:26:05 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B9D8634D
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jaswinder.singh@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d8181087dc9so943830276.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696339562; x=1696944362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VKvN9yiZH6xOqoXAQQ0tYudaznEMQTVupcnMD5i5q7c=;
 b=kyJgvAPps1CxsoPTM8OYQsIRYcdGWP50iV7NjfZywYbOouLOEetvSPD/XQlOa5Ili+
 M6RSeTEE4orzSWw2k3NcdIOaN9GriiHxTlIPUhaaIzJKCK89b+PHhohF2g8ZF2baQ3TF
 /ZMLPjsGvz0NcZUIVxnEl4GXG/0HFD0RTABP67Ti4dPQm5uYeCD72/1VoRXgRfebrwzz
 BLjNHZhYpB3vsmbsjSZ0tt8sICpBvcHmt/mCW6HMmIPLMvfkgph7tpLIlblXWNakowkY
 c1F5/YHXrJs2XjxCn91FxDUCGPVxf5G+woWS4Pch43ll0S/dEuU5xMNJgIdGPSn9WD0A
 xo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339562; x=1696944362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VKvN9yiZH6xOqoXAQQ0tYudaznEMQTVupcnMD5i5q7c=;
 b=m1WkVfKByDW0CysKPsHT09oqgEGybs30rcUZPG+NAbq+AOvUyFl+ds/LdcdINtHYe9
 1UsNSEWJhZAs2i49XT0H7zVo7ungWvurQowBkg6DD9C2yilNlpz6fu8x1+cZRp/fKb5W
 YDl0NFOJUuzFx5CyT2JHvP1i3tCraKzRRdSknCITzhcoVQTOqYf0N69j0OtBSm7y3bgr
 xLD9uw9VgB2fS10lLwp59VdJwRT1U/qUXogbrHzZjhN3e6rKAjMysRFa72vP/2MeHH5Z
 1G/gbfrX/y4aEPDysW1pBkPuKEhWCvyS/rPbHY/PKGeAu0lR2fNMIIV863iVlzJTPnPs
 CQ1w==
X-Gm-Message-State: AOJu0YzZkQanXwX2dVnVhnW8jee/YstdR9CK1kZq3D9oS2Nw11TbisSD
 vnyZXAHG4kwrSVypZ0euz1AvgfwoAWmyobgSGbus4w==
X-Google-Smtp-Source: AGHT+IHX3uR0SbLFguyk2Sg5wRlhbVKoOvmGsYfBTe2p+1EegtB4u1B1dNAMad0fGG+5IGLPidPZfEzxDxa6nHo07Do=
X-Received: by 2002:a25:6086:0:b0:d8d:4913:9f39 with SMTP id
 u128-20020a256086000000b00d8d49139f39mr7544197ybb.46.1696339562297; Tue, 03
 Oct 2023 06:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231003022957.1743493-1-masahisa.kojima@linaro.org>
In-Reply-To: <20231003022957.1743493-1-masahisa.kojima@linaro.org>
From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Tue, 3 Oct 2023 08:25:51 -0500
Message-ID: <CAJe_ZhfRhscaYFkqKYFUCu=vxYDBpuSk_KDdSgpG9MN5LP-CkA@mail.gmail.com>
Subject: Re: [PATCH] board: synquacer: set actual gd->ram_top and gd->ram_size
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Ryosuke Saito <ryosuke.saito@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, 2 Oct 2023 at 21:31, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> Current gd->ram_size and gd->ram_top reflect only the
> first DRAM bank even if the SynQuacer Developerbox could
> have up to three DRAM banks.
> With the commit 06d514d77c37 ("lmb: consider EFI memory map"),
> the first DRAM bank indicates <4GB address, so whole >4GB memory
> is marked as EFI_BOOT_SERVICES_DATA and it results that
> U-Boot can not access >4GB memory.
>
> Since 64-bits DRAM address is fully available on the SynQuacer
> Developerbox, let's set the installed DIMM information to
> gd->ram_top and gd->ram_size.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
