Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1543AF45A12
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 23:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A33DE84099;
	Sat, 11 Apr 2026 01:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hq0WpfDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FEC84181; Sat, 11 Apr 2026 01:05:12 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C89083DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 01:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c6680aaf8so456065866b.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775862309; cv=none;
 d=google.com; s=arc-20240605;
 b=LqLN/Ina3aG67vypro5uCO8yTnpwSG5O4OrvU/WWQVi2Ij7nCPluLxtJgOXnyXceya
 cbqGHpObXnqpzuM0V8WwePDBACV4sVepRqk7sLL+KRwNbRD4EtGYbmTv617GUHXx7HvI
 ccDRnMOZWmOiMZtS0Ifyr/J6WU+Z3rjnLkOnKdXqqNhw9eBLWkeHSuuwab15pLd+GI07
 f0x+4q257yKJyDoaB95jdCbzgu5cfelBkUIajKhAiSyufU8TvZUpwXG4T+T+bbuz0ObA
 zlipxZO8ouW89o5InZc3jfl6O4Ezrml6TdnrbuW/E7nenbzwhFZsJxFEaLD8CzASictc
 w+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YHWRrZYu1zI4NCLOelP8cJKWsH2qei3q/OjT57VTYcU=;
 fh=rxUXMUnI0gG0DhNDkrNyJLq+8iTVswOAIk3gtS+8yoo=;
 b=iHSnVLmVkpF+ke2TD3sK6usjFl47hSVg63NobUEjbMRDZKA/xdv/0caufhhS29RLJc
 UfGgwap+gS0ny7YR3w23qZb83ZRPCqa8mX0etovp8qUjK0+ydGtgc9CAtdjhyL4FDJOF
 /sUVnKCHYRicYU/iLfttYVeQBnpUEh/RCXLswES7TYJwYRMqWITIY87jdbDyGifGp3oo
 0RByfW+zntV+TReSJfJst0jyCD9iTRPSTdKh6GPpYnUvBZOUMU0qSaSj3SD+BSlAwEdy
 tdzj6roJhyVC3Wal6D0jXtdkyr01qVQy9/ghVZgRQVx7EcAC37X/YAiBMH0pH4cs6BXH
 vyYQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775862309; x=1776467109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YHWRrZYu1zI4NCLOelP8cJKWsH2qei3q/OjT57VTYcU=;
 b=Hq0WpfDjurhe78RyC+ouFtjNi8pJ1DLdOD2z0XIFBU2GeRPquSuK/X2ZAApMBX3PIg
 3d0Ganc33q49KnY+pHbxaXCi0fPK8PL1DrGF53ljFa4H/DzaUpQKWyD0QjvQbbwRUWsu
 9Bcq/CWh69thJO+hNhGtlrsnTT6Sq7Hbt8W28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775862309; x=1776467109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHWRrZYu1zI4NCLOelP8cJKWsH2qei3q/OjT57VTYcU=;
 b=qboF9FSvFXALcPFnB7u7vDNGjObvkghK1tYD8oLpqxb3hisPe1s5Z63M1SSgAGmSGC
 hkJl+LwiDwqVYcLVsA03BeNOvDo/d8bFjYDM3mwVvBDk0q/rKwfddYmM47hmtJZIco6o
 L88e3F1wNUGnw3l+ubMg6cShY90vf3CC2rd8VLkBZ3plpdGnJzLqihu8p9LnM4MuALGO
 zKe1FHuQx/YUPBgSI5RfF9tmOaSpA4dXfVzdXLaBUcxWIWy/lTwsCEE/rEuO8Ei2Xn07
 bORMIrUSupx+HVbPTTd85fB04P/J0WpIP7TMaZW8BzKb+tid8X9xX7A9AmpJ9fDBXBj0
 SygA==
X-Gm-Message-State: AOJu0YyRXqCb+bZbouo9d5+H+0Xa2LM9wuMT7TynlzqN6CzKs2C6yDzW
 ekRoOyk5lOrEvZBC81jlrCC83o0RLFWckGpJxL+rmgsOR6v5qnzRANsuBaaee3v8yThZkYkMyCY
 HclmzU0Pu51ShVHECSnhNggEUVojKNVWKaOWXAQD8
X-Gm-Gg: AeBDieu5dKW0H68LqfuzJN2tYzIJVOKlCdNJEA2/qF9CWUyViIy3wEqk2svEEjB00i1
 KW4V7JR6oRhL/mL5Wc8pnqV4Y/xXPbHX1TOkPGZqHvNRkcHS9HrzVyJzmyIfkLXzZAbZnNnZtr1
 cKMnwaV06eQpTVJ2rNUsQmzRqW+G9NUqq+qKY0k89QtCcDFaPwqRW6byNcpiU6+Wl6kFDuoq/X3
 e+NRcprm4irsMtupHgCKjNSQveuQgpuiMuuTAB/qHgTGgu2yk+wyLjG/QfhcgOKYOiA3T32cWsb
 g8Gg5g==
X-Received: by 2002:a17:907:25cb:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9d7248ab3bmr284883166b.18.1775862308877; Fri, 10 Apr 2026
 16:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
 <20260404152640.3297713-8-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260404152640.3297713-8-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 17:04:56 -0600
X-Gm-Features: AQROBzA9zZktph614RgZ4_5ahrCioK5KwO69O-4fAtEnRZv0EzOL68RoHA6Eks0
Message-ID: <CAFLszTj3SL0qiXsqa31UhAyf+XZEdV_0QBf6Ly0QVhMjNMD5=Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] board: st: stm32mp25: support dynamic A/B bank
 bootup
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
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

Hi Dario,

On 2026-04-04T15:23:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> board: st: stm32mp25: support dynamic A/B bank bootup
>
> Enable automatic detection of the active A/B bank by retrieving
> partition GUIDs from FWU metadata.
>
> This ensures the system correctly identifies the bootable partitions
> even in multi-bank scenarios, falling back to a standard bootable flag
> scan if the UUIDs are missing.
>
> To enable A/B bank bootup on stm32mp25 boards, add the following Kconfig
> options to the stm32mp25_defconfig:
>
>  CONFIG_FWU_MULTI_BANK_UPDATE=y
>  CONFIG_FWU_MDATA=y
>  CONFIG_FWU_NUM_BANKS=2
>  CONFIG_FWU_NUM_IMAGES_PER_BANK=3
>  CONFIG_CMD_FWU_METADATA=y
>  CONFIG_FWU_MDATA_V2=y
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> board/st/stm32mp2/stm32mp2.c          | 25 +++++++++++++++++++++++++
>  include/configs/stm32mp25_st_common.h | 15 +++++++++++++++
>  2 files changed, 40 insertions(+)

> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
> @@ -208,4 +208,29 @@ void fwu_plat_get_bootidx(uint *boot_idx)
> +     if (!fwu_mdata_get_image_guid(&boot_uuid, &boot_type_guid,
> +                                   boot_idx) &&
> +         !fwu_mdata_get_image_guid(&root_uuid, &root_type_guid,
> +                                   boot_idx)) {

Just to check - if fwu_mdata_get_image_guid() fails for boot_type_guid
but would have succeeded for root_type_guid, there is no log message
and the function silently succeeds with no environment variables set.
Is this the intended fallback behaviour? A log_debug() might help when
debugging boot issues.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
