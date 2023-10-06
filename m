Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5AEE92FD0
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 00:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9868886BA2;
	Fri,  6 Oct 2023 02:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C7FWyTF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457D286BDF; Fri,  6 Oct 2023 02:45:13 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDDA186B68
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 02:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2791d5f1a09so339435a91.1
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696553109; x=1697157909; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iZiPzbI/2qESdTS+34dKn1XfDa97pbe1Ac3RsW/Tqk=;
 b=C7FWyTF3qmIre1BO4Pz9Szo/z9iKbUp/ssFOxjcfvPxkXJKvIC4Q1+SsfCD4i4cs6u
 bfBEq5pu6M24Rpv5q6LLHgcK3twwac5HckRB25BU5Vi/63q1gU/AQo2v9iGdeiP96AtU
 jyo1YjZxMduTQBfeTVwlDX7vKO8pQdLxIdkwI+ROKHMP6NPFajyqOBAx0E4t7EBo+GuX
 gUyva0C3D0QNIwmZtKcbve8n3bPIyS+eyDTw1uuj1zU3zzjqz7l6KIieeeAGzrXN7qCq
 mgPsIXLV3KDFWEv/9SyiTNE/LDNdWYSta0euMUFQDYHF0mqo1WiKrdrLCOzvrkCFBVkS
 kBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696553109; x=1697157909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8iZiPzbI/2qESdTS+34dKn1XfDa97pbe1Ac3RsW/Tqk=;
 b=RTI8wXtDfDLS8ETMtGtov3tjRa6EkhW7sTTP+QQY6FhKV30DnBFZ3FX4IBBKmKpXEq
 84AUujZBoZ+Mz01rmSNoSP8SkTkXidteE6kgpjefosEamat+s5kdAHo04KsOTE/S4PdL
 D0S+p5Ka8xEdUTDhyxolIB++AXkE8KYdsNds1RDEizLMmebA9tmXGz2iMJKERLAqMwMg
 nMn6mXKj0KfzyensUwz9+00nikIbft2eSdrc8sGWio4hWxzlYZlM4GAn6xKLqHsMoOv4
 kSpy/xl3tk7rQCHpX5y/f96X0wJgYtqtKAUtv1MM4JOgGBlfvx0tBcR68i3ZeWGjaQmX
 sQLA==
X-Gm-Message-State: AOJu0YwYMheL0nsDTRsJI8WT/Mr5B/CEuRFky17LTKFSCFMBVy88qgt0
 3lvJX4/n/f0UNCI9DFkGy4dLHeqNcBwMWsx7peXOQ+45WVo=
X-Google-Smtp-Source: AGHT+IHf4hfrAermG7DYsGBxKlue7wONhe3nFzRCILk+1mO0dtd6IDrVUzeEPVfQJmVqR+JGNCf4kop/MYnCIflcdDw=
X-Received: by 2002:a17:90a:1783:b0:279:e6f:2e4b with SMTP id
 q3-20020a17090a178300b002790e6f2e4bmr6195383pja.0.1696553108845; Thu, 05 Oct
 2023 17:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231005214018.299-1-egyszeregy@freemail.hu>
In-Reply-To: <20231005214018.299-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Oct 2023 21:44:56 -0300
Message-ID: <CAOMZO5BFvFtJeSCJWC0KW7TT-6uXE0e0wCc_0bhmZ6-7kaPuqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] [u-boot][master][PATCH v4] pico-imx7d: add baseboard
 SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 5, 2023 at 6:40=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Take over codes from Techenxion to support mmc autodetect boot for pico-i=
mx7d.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Still not good:

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#57:
Take over codes from Techenxion to support mmc autodetect boot for pico-imx=
7d.

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
where possible
#90: FILE: board/technexion/pico-imx7d/pico-imx7d.c:134:
+#if CONFIG_IS_ENABLED(FSL_ESDHC_IMX)

CHECK: Unnecessary parentheses around 'autodetect_str !=3D NULL'
#95: FILE: board/technexion/pico-imx7d/pico-imx7d.c:139:
+ if ((autodetect_str !=3D NULL) &&
+ (strcmp(autodetect_str, "yes") =3D=3D 0)) {

CHECK: Comparison to NULL could be written "autodetect_str"
#95: FILE: board/technexion/pico-imx7d/pico-imx7d.c:139:
+ if ((autodetect_str !=3D NULL) &&

CHECK: Alignment should match open parenthesis
#96: FILE: board/technexion/pico-imx7d/pico-imx7d.c:140:
+ if ((autodetect_str !=3D NULL) &&
+ (strcmp(autodetect_str, "yes") =3D=3D 0)) {

ERROR: switch and case should be at the same indent
#111: FILE: board/technexion/pico-imx7d/pico-imx7d.c:155:
+ switch (get_boot_device()) {
+ case SD3_BOOT:
+ case MMC3_BOOT:
[...]
+ case SD1_BOOT:
[...]
+ default:

ERROR: trailing whitespace
#127: FILE: board/technexion/pico-imx7d/pico-imx7d.c:171:
+^I$

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
where possible
#140: FILE: board/technexion/pico-imx7d/pico-imx7d.c:224:
+#if CONFIG_IS_ENABLED(FSL_ESDHC_IMX)

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
where possible
#141: FILE: board/technexion/pico-imx7d/pico-imx7d.c:225:
+#if defined(CONFIG_ENV_IS_IN_MMC) || defined(CONFIG_ENV_IS_NOWHERE)

WARNING: Move const after static - use 'static const iomux_v3_cfg_t'
#178: FILE: board/technexion/pico-imx7d/spl.c:165:
+static iomux_v3_cfg_t const usdhc1_pads[] =3D {

WARNING: Move const after static - use 'static const iomux_v3_cfg_t'
#189: FILE: board/technexion/pico-imx7d/spl.c:176:
+static iomux_v3_cfg_t const usdhc3_emmc_pads[] =3D {

CHECK: Lines should not end with a '('
#238: FILE: board/technexion/pico-imx7d/spl.c:225:
+ imx_iomux_v3_setup_multiple_pads(

CHECK: Lines should not end with a '('
#242: FILE: board/technexion/pico-imx7d/spl.c:229:
+ imx_iomux_v3_setup_multiple_pads(

ERROR: switch and case should be at the same indent
#246: FILE: board/technexion/pico-imx7d/spl.c:233:
+ switch (get_boot_device()) {
+ case SD1_BOOT:
[...]
+ case MMC3_BOOT:
[...]
+ case SD3_BOOT:
+ default:

total: 3 errors, 6 warnings, 5 checks, 220 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile
