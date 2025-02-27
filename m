Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826A4C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 19:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC4D8164D;
	Thu, 27 Feb 2025 20:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="X6V52/MQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68818164E; Thu, 27 Feb 2025 20:51:43 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7DDB8118A
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 20:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30918c29da2so15180431fa.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1740685901; x=1741290701;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kFN69xd7U0DSjgLyGPeIZ0LX85zW876tO6myKybeJrc=;
 b=X6V52/MQ4YGDYfnaAz2bI9S2uHF5f+ediHCkVGcpzrD/fQ3eHRpLMepuuttoPwRJNg
 YP8rbsJx8LkF1MAu7qCg8dtPqRTApdM/xXZw2j9QYlxXX5YP2nEm5hfzjVTwmb5/Fiyu
 enIsFLZ4GJ49g9DFZr6YJ9GmH15x1W/sGPoor+ij7SXUr7K0bsuXTE5NTUR8fB0qqTH5
 FT//GKvaJkzkfvEHz8ZOg7kFXlRMof1rVlDKxTvrZTDlPIVE9Tm0eP4OxERiuR8HFhsk
 wR1eXoC3NFWtfBnkl1a5IMu+6R9S+UrEPVW7U/usPAPbehlxjm41aA4qr/8Pq/P7Berq
 yjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740685901; x=1741290701;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kFN69xd7U0DSjgLyGPeIZ0LX85zW876tO6myKybeJrc=;
 b=sJz8JBYu5ryvJ72KzKpZLTM7wTd8AU5xo9Z/t8875INAF+mgWTH0EtCJR0ZGpxL02r
 2qEeTd8JpfLFtqPqz5POR42g9COMHaZtLYI+ttmmcPrBWDTlDroIkcanTWq0EVz3atrz
 kr8FAuSrp1UjT7WsHjWeQmlWW9PMniBJAiaJ7SRwbB8J3DKYMKIGrSRx9Q4xWjTXf5uB
 jfw/oPLl0wKocKR4m4wunvX7TfFMITT82KIP50zQTZ47ke1vxvix9NhaDjGHkAtUyieR
 pOBKwhtxZ1sg1pZ/0C3ZlbboaCLkAlHaqEeHBqwTIx8fDB4npGKzWUt4IOwYNeqmYaOE
 7xMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHei+3UupvwP2AxHEvsuJaHVCCWaHDniWANX2xi+NZjZ/yXhd2MpS4Tmzp3b0ZCErvpwFuB7s=@lists.denx.de
X-Gm-Message-State: AOJu0YxyHRa6MWGUfFpz8peRJ8dnNEgiWlDtfEJK9ot8JR667mFGIOkZ
 Mu7zjGOZRGlSAtSoBKVxUoyRyaRBZTnBi4IWpmG/8KAyaTLUPrRfvldWVgxJO7yAKxBfjgz111i
 R
X-Gm-Gg: ASbGnctkRHyGGvsRjtRugmRrXE/43t/Uk+6bF8KkLmMRGBZbCk2lmYqKSu9KrK2m2SE
 qPYYtQBmJo4zeOEt05esGr/NyCTKN2Js5xspXk8FDcB0GC5vZAX86jvkAVHG3/TMHQpx8d0VGHl
 XlXNnJjP9dQqD7LY7nG7HQrTg9QzVFV+UNQlv+lqDmySxYUTd2B3cyZSam3SSVAsS4r9C/MmAdk
 y1XjVThIqY09kZVoGce9UcHbkRm9Wuy5R9PfJjHmrNXwk//TPIYQSdUhM21HIg92zsX/eoQDWYD
 9sf3UEgiJVnNQikkSoUzazC39TLhqYVuNuemG0g51O9EwbWE6p1qSRA4rMU=
X-Google-Smtp-Source: AGHT+IHoTm5HbXakDPhs9GxsAsPbMolHehfzBYsV3x1INbwAK1aTyfMuROdulJGesNGqW9Senp0AoQ==
X-Received: by 2002:a05:651c:512:b0:307:2b3e:a4a9 with SMTP id
 38308e7fff4ca-30b932532eamr1827381fa.20.1740685900915; 
 Thu, 27 Feb 2025 11:51:40 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30b867bfc37sm2547021fa.40.2025.02.27.11.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 11:51:40 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Anton Antonov
 <Anton.Antonov@arm.com>, Bin Meng <bmeng@tinylab.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v5 5/6] blkmap: add an attribute to preserve the mem
 mapping
In-Reply-To: <20250227111519.45787-6-sughosh.ganu@linaro.org>
References: <20250227111519.45787-1-sughosh.ganu@linaro.org>
 <20250227111519.45787-6-sughosh.ganu@linaro.org>
Date: Thu, 27 Feb 2025 20:51:38 +0100
Message-ID: <87eczjb1yt.fsf@waldekranz.com>
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

On tor, feb 27, 2025 at 16:45, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> Some blkmap memory mapped devices might have to be be relevant even
> after U-Boot passes control to the next image as part of the platform
> boot. An example of such a mapping would be an OS installer ISO image,
> information for which has to be provided to the OS kernel. Use the
> 'preserve' attribute for such mappings. The code for adding a pmem
> node to the device-tree then checks if this attribute is set, and adds
> a node only for mappings which have this attribute.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---

This turned out great!

Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
