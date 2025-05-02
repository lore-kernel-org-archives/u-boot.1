Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064DFC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8301D81FDE;
	Fri,  2 May 2025 11:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m9ebke9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E77882075; Fri,  2 May 2025 11:30:30 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7732881E72
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so8449685e9.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746178228; x=1746783028; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HhKX25SRrbp9xBldUfbeVa50RsHazDQvegIH+OtqJQ=;
 b=m9ebke9w88GrmQiYOKeSQ9pASJCbnY8Uls7p40c3/BthfHcA1kNmC0BkG9Hpp/IzOR
 RvHYfKllofRABIXixmqhMOZqnteaj8vkV9sfK1MlT4oL7HaYN+Gtti+9286wJluJatvv
 B8RFrpv/dlNxCKFbA13izYuF7QumPjQ7yQfemNgfHdM3xirzRQeOLIrY8F7kuPVI/vtD
 TQsrlEbkeOJQvybegaElsScQGsJIiNoTLYfQ/yxXndrx0K0x/zflxnxgs2mheH6Z3Mv8
 4uM36sDCDep+ypk3EfLuMllDi39N2eqfBKZU7tF3gf6eEla4fW405FYLclL+dPcLeqWa
 3Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746178228; x=1746783028;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2HhKX25SRrbp9xBldUfbeVa50RsHazDQvegIH+OtqJQ=;
 b=ie2ysMWEt1FugVfWZM7nKEd4olJ3SDjcs4dWu4ZqebRbgDlydTjwT1KTCHZN7YoDHf
 nmX+axwtX68hnfy5JqxUOxW01AqFgIuc5v00RPhc7060H14LuaXqYf8AjhtncX3Cr7tp
 8Iz6pnQN47kpyb6+2hPR6lyNdPOYeINQKzmoe3rQuFmjbecWvoOWcH3s5NOBNm+Up/3k
 VIH8KnoXKoU5zjMJVN7oIQrSalBTN+JSi4VhsfCV6XORbGZqoeQXUm0s8l0cFJwba9u9
 uZWK7UyIKUirwiW8uza6Jo44DyBF9xydB2TTRqVexVWe+43uzG7PFyPa1dLLWZ2VeWQv
 zjZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXSSUpaZyIJ8S5GOJptHf+mFiNsILOLlYPKJ6cVcIXDHpWkmetFUO+SboXMEaxghPV3xa9Ka4=@lists.denx.de
X-Gm-Message-State: AOJu0YwaTnJ81kvTcbPLqn8srtvWdEJQeU21rSr0dnIF3jbbLlZWCoyg
 bo+lbbx/QN4OD5MelCnBgHNuEU7x6GJLZJ752UEM+v8lIKs/X02LycqlN13lv1Q=
X-Gm-Gg: ASbGncsHK3cggLJpfffPsvNi4WFftafZuAitHaNwDcFeILBW02FTU5v6jA4a77AHCIB
 KJ0ChPLZinkZYsLM5KcM8YZ4h2wrMy92EwN12l1XrImeDFrWYR9K++eHPzLLMsCW9hK5GRsmhyL
 8GSWlxJ89lhTo82c92HzBRDWOCmvHI5d24IojI283kW+zEVYn/n9F4c3Q3urFaLBjB+zDa92iuY
 E1Dtd2RtGl0bTsci9WTawxQTX7zY0rxtACAldm87CR7EYQMlpIz/cIDppk/WGzbVdjEuxy9PdPd
 Z8SFz3sGx6eO1vJ4vUrIhzUwCQ159peki06aygi1yBSW5GRw
X-Google-Smtp-Source: AGHT+IHo1ePllDKM4+bnrY6HNSzRX4Vaj48D98NBdZED0G9Ja1SvNlRTrJ7MU0RHXoEu12b34J9UtQ==
X-Received: by 2002:a05:600c:c3da:b0:43d:fa58:700e with SMTP id
 5b1f17b1804b1-441bbf37e12mr11610505e9.33.1746178227832; 
 Fri, 02 May 2025 02:30:27 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae82e4sm1644754f8f.58.2025.05.02.02.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 02:30:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 12:30:26 +0300
Message-Id: <D9LKIQSWR7PS.2BJXAMTOM24H5@linaro.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Tuomas Tynkkynen"
 <tuomas.tynkkynen@iki.fi>, "Patrick Rudolph"
 <patrick.rudolph@9elements.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, <u-boot@lists.denx.de>
Subject: Re: [RFC 3/8] boot: make BOOTMETH_EFILOADER default=n
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.20.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
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

On Mon Apr 21, 2025 at 7:25 PM EEST, Heinrich Schuchardt wrote:
> The boot method is deprecated as the EFI boot manager covers this
> functionality.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 71ddb37f6bb..b973d9eb0a7 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -595,7 +595,6 @@ config BOOTMETH_EFILOADER
>  	bool "Bootdev support for EFI boot"
>  	depends on EFI_BINARY_EXEC
>  	imply CMD_TFTPBOOT if CMD_NET
> -	default y
>  	help
>  	  This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>  	  launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

