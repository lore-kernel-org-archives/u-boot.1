Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0538EEB580
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 15:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6960868C1;
	Sat,  9 Sep 2023 17:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WCbGcBg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3888691A; Sat,  9 Sep 2023 17:58:28 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77ED886053
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 17:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401da71b7faso35321455e9.2
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694275105; x=1694879905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2nN4tFG1r9zt8NY5NhrZk/S74cTe6sYO2Qga0UR6d5E=;
 b=WCbGcBg07rlUpgRlxht2L5vjU6HLgW+XYZ4E6SaMdqgMhDZ7YCGsySFvVsF77YdfjL
 Wszrqnntk9jQgZONvCG3MXv6+xkzE5k3GrQZVkzUCEz1CnASIalzKCp5NUE1R3uoIOyc
 qECq68JsN1ZFs44QhBiG0S+4oXyBNuaIqoVlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694275105; x=1694879905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nN4tFG1r9zt8NY5NhrZk/S74cTe6sYO2Qga0UR6d5E=;
 b=eOtHfcvEoOYHI3mqIivpHC8WQeLZUexOGPGaA6www4TmpqefUGTQ3MksNEHrUGNAOQ
 IwfXTLpVC5ozlHHJMRnP/vuO/KKFf6TDlIbMuYsan4oopGWvtGbnijKhcEfjFcH5QEy5
 9xlQNyWjUum25b6IUdOPhQLe1WkSXHkhiRgem+jkGEPxEof3FhwGtDdGeCzogjI4sb0a
 kwB3S8uiOilpoQ/BpwPWnBk+tz7h0RTqATstlHtvgtWuRGVPbePC29fE+efqpQ9OxMyi
 JTB16mgxrSaNg+tkZbuBMq/p3+RIjWNkrRluuVqGtdgb2wJZEhcBDXiC2rHorLpW1EXt
 k9JA==
X-Gm-Message-State: AOJu0YwY8WXp6SgmF2obbe7adRii8EDrRZF0dISTvugffo//LsxHp1Mj
 1bpjSXays+4cRdCLKdCE8rI1NVp0bbfrL1I2WLjHFA==
X-Google-Smtp-Source: AGHT+IGxsOu99zdHv9jlmuTbiMLJ5jeShwBlXy+FfboRz8HgwXHPo1DKFfGxn3wTNZ13Chiqga3K2OT5TupPESHZt8I=
X-Received: by 2002:a5d:43c5:0:b0:314:152d:f8db with SMTP id
 v5-20020a5d43c5000000b00314152df8dbmr4557176wrr.58.1694275104603; Sat, 09 Sep
 2023 08:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230908080001.31231-1-jw.jung@navercorp.com>
In-Reply-To: <20230908080001.31231-1-jw.jung@navercorp.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Sep 2023 09:58:07 -0600
Message-ID: <CAPnjgZ2MSWWHhjAtxUjyU4oTF18FCe8UABZj_Vv8rR+wt4aRjA@mail.gmail.com>
Subject: Re: [PATCH] doc: delete unused values kernel command line
To: Jaewon Jung <jaewon8868@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaewon Jung <jw.jung@navercorp.com>
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

On Fri, 8 Sept 2023 at 02:00, Jaewon Jung <jaewon8868@gmail.com> wrote:
>
> Delete "boot=local", "noswap" unused values in kernel command line
>
> Signed-off-by: Jaewon Jung <jw.jung@navercorp.com>
> ---
>  doc/board/google/chromebook_coral.rst | 4 ++--
>  doc/usage/cmd/bootflow.rst            | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
