Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2305C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 09:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5718882F0;
	Tue,  7 May 2024 11:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bzgWAYHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEFB88738; Tue,  7 May 2024 11:01:16 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FBA487E62
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 11:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51ff65b1e14so3434197e87.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715072472; x=1715677272;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=COlF3KI3pyVjPQ9hIkKMWj56bunwjWESINSyYwSIFfo=;
 b=bzgWAYHbUzz4rkgRPuHbmEbB9q3Ft8nxqcJjb4e4d12q34JsFv04u0EyR44xXHQxlI
 s5uCzPtCwYjCywFCrahAMdNoYF8kTE5vuErlPH2P7wA7fsVn8enqJFEtuaF7Rv3ld2v2
 N2iLribGoicAbKoQCMrpLM8mSZf34V+0nLjHf9SZPEIpwruUBsiIei7zPUp4qgGALoXo
 FCLtnOaHvQgsQawgQvvOv9AUN/+x23voVeXscczKy21Un/nsqu5Bkadz4YHDglpnZojA
 ZJCyqhGmsNcuXe7E/2NEPHYwkB9HJEb2ZNO0nDt3h+ra0lhaKxVQm6zlUBzZxbLNlbF/
 xybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715072472; x=1715677272;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=COlF3KI3pyVjPQ9hIkKMWj56bunwjWESINSyYwSIFfo=;
 b=UAb4CnGXu9fJ1uZfwc+BW8mkytHgFUny6sAVkUI6nGApo6RuuWZPCHX3wQZKeHwCph
 qiHacmqpgcIHH4tfuHAdius1TOh+r5eJRE4Ib8e/h8PV3AQlB7+/cXIisnfAcRP6unEu
 iprC4ly8ctilFSE0c1XzZRQYEhzPIaC337Di+x6mlAQuNUsbhIFDjCX37Cg70OW04qMH
 N2ZqRfgai+aom2RMW7rg8nT+6vJruSv/lN1kKWOJTP7ShwImjpTY2ziMfFNWnJek/1ac
 FyS6FSX6rIW0itEiqoJ3gvSNg9eYjIt26RJmXmtdTaXLMQRaGnRIAfJYY68bSy66gSLA
 YZnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXivxAcZr8WEssaAqbY+P9sdTErRWiCw2JCmaRxmW37XKWCes2E3PRKAUB6q88AkuLEpOquRNhHAfoncY0pyfuWOvt5hw==
X-Gm-Message-State: AOJu0Yw3SrRhbn/cqyF/rEtB3eP8I9S+WbvPYMJZL2+k9cv76oEctwU+
 iRo8JFCgO3KtEeGqLTSrRaPU6ylUC0Apl72S19O85lyB9iqH0zz9dzB8FkatPO0=
X-Google-Smtp-Source: AGHT+IGs56p3f36ermoSCtyFXYsVNeEu6JgxgC51ZwwkIjQhUKLhYWI40bYSjqXF7uO8oiyyLKKVAQ==
X-Received: by 2002:ac2:4a6d:0:b0:51d:162e:bf9e with SMTP id
 q13-20020ac24a6d000000b0051d162ebf9emr8162416lfp.15.1715072471718; 
 Tue, 07 May 2024 02:01:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c4ec900b0041c542636bcsm22476873wmq.44.2024.05.07.02.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 02:01:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Martyn Welch <martyn.welch@collabora.com>, Dave Gerlach
 <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Martyn Welch
 <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 3/6] arm: dts: k3-am625-sk: Enable usb port in u-boot
In-Reply-To: <20240506143846.1252377-4-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-4-martyn.welch@collabora.com>
Date: Tue, 07 May 2024 11:01:07 +0200
Message-ID: <87msp2c7xo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Martyn,

Thank you for the patch.

On lun., mai 06, 2024 at 15:38, Martyn Welch <martyn.welch@collabora.com> wrote:

> From: Sjoerd Simons <sjoerd@collabora.com>
>
> Enable usb0 in all boot phases for use with DFU
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes in v5:
> - Forcing usb0 into peripheral mode reinstated
>
> Changes in v4:
> - Don't force usb0 into peripheral mode
>
> Changes in v3:
> - Enable usb nodes in all boot phases
>
> Changes in v2:
> - Only enable usb port 0 DFU in SPL
>
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index fa778b0ff4..1fc0d407cb 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -46,3 +46,12 @@
>  &cpsw_port2 {
>  	status = "disabled";
>  };
> +
> +&usbss0 {
> +	bootph-all;
> +};
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +	bootph-all;
> +};
> -- 
> 2.43.0
