Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EDAC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 18:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111AA8209C;
	Mon, 28 Apr 2025 20:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NqNTH6Xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1089820EB; Mon, 28 Apr 2025 20:46:46 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8288180FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 20:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6065251725bso2290407eaf.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745866003; x=1746470803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4YTUikSdDcQoRngYAG6qfBrIxrK/uA0E5nBb7XxepM=;
 b=NqNTH6XrDPhHDYS2ccmTw7LOFLBQ6/nZ57fo8PY+hcexRKxN4ULamK/pdI8aATrn9E
 rHgCKa3MrV6RW3jckGtzQ/8au2U0E4Kz6IcxWXtbOqJfROHeY7Icf5u/ydaYqroCHa9e
 wZWA5tFEij2oMp3pqEFfmj3TgzT7SuGTWo/14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745866003; x=1746470803;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4YTUikSdDcQoRngYAG6qfBrIxrK/uA0E5nBb7XxepM=;
 b=XIRAv7SpAdTiy2IrIkYFATSCLMEDzMOQTWomjnVEkvqQ4PSOxRRgWjxThnn/5GHO5n
 Xp1z651rwFQqj/ydZQZRl1z1nQ1ZlFerttaK/tK9j+KoAyYmW5Sl919lrZxIrIOhFOG9
 j/z2tOSS3Z1ewlsv9AzJHlaTVaI1vZRRXzvvdsdwWZq/ENB42irx9rE8A1NHrP9abnY9
 txpbwfU2lOEog+1f1hikqKBPlkvPsZApEW/Js9DoY5wVazCe3vQLSGm7fjB6BbDm6MU2
 WKtczhoDdtMwKCX4vRWYuMduNmUanfMK0OpwpfT0mgbSooRMI8ecf8GpJGEbHSGED7mb
 4AMQ==
X-Gm-Message-State: AOJu0Yx4+pwRM8XGKIQVyLghpbdm4HSnR0EzoT/5ZWepJ0Egj2S72qHE
 cC044yClQXWoS3HaRl2vLx4LK3+aqQ8txiZMeyu1/6GBbVeTvMPLksCQ6aVSaKs=
X-Gm-Gg: ASbGncuyqRfepbkmIobGzt/Roy3j0AX/ZfPK36fBAICy5uMEZF/z/26cO2qCQLtxiry
 ZMGMYB3u8RmhuqhD4ZRIViJq5NxXY1Y5+bhtHkOHPY4VvEu2DaSXrOxFs4eCojkFMqKl9U/A1FR
 OmdX3E2pIeRUaZnfjJ+KZcEvSqcTlLqq16X4zusLMtqSbpHq4IQ6l0URkQWqdQAdCKmFTbLaANM
 5gArRBF2xGUPFMk0ouWFWrtJ7WwSCbMXdeWx8rL7Wpz/yerz+4Kj4ErEpLdS57q7iqb14HkfngA
 iGMlEB5lGYZyjHDI7wooWAxci5kCEs82nqKa+1TPYJmial9kqMSfrg8+1B3pYnV4DcACHdbk9fH
 X
X-Google-Smtp-Source: AGHT+IFfzGRV6m8gJkWrd8yDgXqSjYli3LZ4xrRbdCahVq2vhmJTGM+vVljVQmk08mZ/WpqqdmmQOQ==
X-Received: by 2002:a05:6820:201:b0:606:2d5b:de98 with SMTP id
 006d021491bc7-60683cbf18cmr575879eaf.2.1745866003287; 
 Mon, 28 Apr 2025 11:46:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6064692d4fcsm2025167eaf.40.2025.04.28.11.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 11:46:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Lionel Debieve <lionel.debieve@foss.st.com>
In-Reply-To: <e7fc1441-c4a6-4173-bf7f-974f347f9f67@foss.st.com>
References: <e7fc1441-c4a6-4173-bf7f-974f347f9f67@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2025.07 =
 u-boot-stm32-20250428
Message-Id: <174586600211.1100739.5354625454636048782.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 12:46:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 28 Apr 2025 15:35:03 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/master, v2025.07 = u-boot-stm32-20250428
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/25970
> 
> 
> The following changes since commit 9d3f1ebaf8751f0287b5d02158cc706435f8fb19:
> 
>   tools/make_pip: Use venv when invoking pip (2025-04-24 16:30:37 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


