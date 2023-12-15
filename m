Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1522FC46CA2
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 12:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D44C87150;
	Fri, 15 Dec 2023 13:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Qth3Vsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422ED87A7F; Fri, 15 Dec 2023 13:02:44 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA5B8713C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c68c1990dso6518335e9.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702641761; x=1703246561;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eZ2d3K0EsnSLlVOqC8WzfQIA9zBDJLHgnjUyRMt78Yc=;
 b=0Qth3VsuYcxAN7m1CJVKwxtEqJiLP313eCl/Tgzu0O7hRB+0FwGFmY3NqvGDcvTyGv
 o7tY3nDrkjvYLv4KSTMntq/51SAx8JNttL1emzsqZOFQLh2TdZOF6Ivf3TiauGNfWBPY
 b4yfcYMciTGetiNe/oH7KTEkrcx72BPclHEO4qalLTHtkXSuKxKtxVbAkh/zBIF5VXmM
 F5TWY9mjpxaRoIzpWWuGBSUvrhiiPbD0+yeFlxv+0DQDpECqKLbnW2WYnrcjeVMezXSN
 aYKocjgNiOQ+6UfqGU26rW8IDTmcK+R00LNvGk/Fs2abV0S4FwLuBMreV4b5g+XpFlfY
 YZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641761; x=1703246561;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZ2d3K0EsnSLlVOqC8WzfQIA9zBDJLHgnjUyRMt78Yc=;
 b=OhfhzkNcSC6aJeoFg02wdrgElmvAn/BaOMXgdQAf36pk5yNeUQTY5RUPzqHOsm7LLz
 4vqWSFDeHOvcIOAxfjWd2uzCzrlpAAU1SpsvZ9nDxFSbOIRTZ69SGGuNFiwgsx7VRrPf
 KXS6ZKu59bgTog9W2eG5hpCcavQNLvR6/InayPRTXTvnPsS4hUSwddWVeoQsJEFvLeTQ
 JjEgDnp4s6/dgLlsOmAHVgoKhsg2ionrkIj+jeXfw82+9rwL01+lykqfOLobmtOvyDld
 ls1u24IaaRpk8+FVGQ0QPtiydhXIvhe2qe2mVBXhk/yXJiKMRiyO6tf+O+UvsnW6hWBu
 Ey0A==
X-Gm-Message-State: AOJu0YwEYC2eVSYoGSvI3eQMBM0KJBwnnHi5xU3Ap2dmHrxbN+0Nekta
 jipxhmQrxWowd1jfJ2rbnt8CzA==
X-Google-Smtp-Source: AGHT+IE5HmajKkOrWKe2ierNN0M1hzdt7E4umHRKXsCr/m2ee7o6ujy1R5l5BEUOxJGlzPPyrIVbMw==
X-Received: by 2002:a05:600c:3093:b0:40b:5433:17ef with SMTP id
 g19-20020a05600c309300b0040b543317efmr4257004wmn.30.1702641761453; 
 Fri, 15 Dec 2023 04:02:41 -0800 (PST)
Received: from localhost ([89.207.171.106]) by smtp.gmail.com with ESMTPSA id
 u21-20020a05600c139500b00405d9a950a2sm30787280wmf.28.2023.12.15.04.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:02:41 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Eddie
 James <eajames@linux.ibm.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 11/21] bootm: Move do_bootm_states() comment to
 header file
In-Reply-To: <20231214165112.2182274-7-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-7-sjg@chromium.org>
Date: Fri, 15 Dec 2023 13:02:38 +0100
Message-ID: <87il4zu10h.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

Thank you for the patch.

On jeu., d=C3=A9c. 14, 2023 at 09:50, Simon Glass <sjg@chromium.org> wrote:

> This is an exported function, so move the function comment to the
> bootm.h header file.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Split out patch to move do_bootm_states() comment to header
>
>  boot/bootm.c    | 25 -------------------------
>  include/bootm.h | 25 +++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 9e42fa5117d0..875f8a1c2a56 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -990,31 +990,6 @@ unmap_image:
>  	return ret;
>  }
>=20=20
> -/**
> - * Execute selected states of the bootm command.
> - *
> - * Note the arguments to this state must be the first argument, Any 'boo=
tm'
> - * or sub-command arguments must have already been taken.
> - *
> - * Note that if states contains more than one flag it MUST contain
> - * BOOTM_STATE_START, since this handles and consumes the command line a=
rgs.
> - *
> - * Also note that aside from boot_os_fn functions and bootm_load_os no o=
ther
> - * functions we store the return value of in 'ret' may use a negative re=
turn
> - * value, without special handling.
> - *
> - * @param cmdtp		Pointer to bootm command table entry
> - * @param flag		Command flags (CMD_FLAG_...)
> - * @param argc		Number of subcommand arguments (0 =3D no arguments)
> - * @param argv		Arguments
> - * @param states	Mask containing states to run (BOOTM_STATE_...)
> - * @param images	Image header information
> - * @param boot_progress 1 to show boot progress, 0 to not do this
> - * Return: 0 if ok, something else on error. Some errors will cause this
> - *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
> - *	then the intent is to boot an OS, so this function will not return
> - *	unless the image type is standalone.
> - */
>  int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
>  		    char *const argv[], int states, struct bootm_headers *images,
>  		    int boot_progress)
> diff --git a/include/bootm.h b/include/bootm.h
> index c9ab55f18d39..950ce5181f1d 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -131,6 +131,31 @@ int bootm_find_images(ulong img_addr, const char *co=
nf_ramdisk,
>   */
>  int bootm_measure(struct bootm_headers *images);
>=20=20
> +/**
> + * Execute selected states of the bootm command.
> + *
> + * Note the arguments to this state must be the first argument, Any 'boo=
tm'
> + * or sub-command arguments must have already been taken.
> + *
> + * Note that if states contains more than one flag it MUST contain
> + * BOOTM_STATE_START, since this handles and consumes the command line a=
rgs.
> + *
> + * Also note that aside from boot_os_fn functions and bootm_load_os no o=
ther
> + * functions we store the return value of in 'ret' may use a negative re=
turn
> + * value, without special handling.
> + *
> + * @param cmdtp		Pointer to bootm command table entry
> + * @param flag		Command flags (CMD_FLAG_...)
> + * @param argc		Number of subcommand arguments (0 =3D no arguments)
> + * @param argv		Arguments
> + * @param states	Mask containing states to run (BOOTM_STATE_...)
> + * @param images	Image header information
> + * @param boot_progress 1 to show boot progress, 0 to not do this
> + * Return: 0 if ok, something else on error. Some errors will cause this
> + *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
> + *	then the intent is to boot an OS, so this function will not return
> + *	unless the image type is standalone.
> + */
>  int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
>  		    char *const argv[], int states, struct bootm_headers *images,
>  		    int boot_progress);
> --=20
> 2.43.0.472.g3155946c3a-goog
