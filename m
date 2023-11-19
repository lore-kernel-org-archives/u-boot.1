Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A45C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 22:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090388751B;
	Sun, 19 Nov 2023 23:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="SMAyFR6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449B38751B; Sun, 19 Nov 2023 23:47:22 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E2986F6F
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 23:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso5256678e87.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 14:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700434039; x=1701038839;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0ZdObg+JPE57CQu5Vv/7QazWjDax7G8V2+iH6eEPEI=;
 b=SMAyFR6q3gXcwCDhALHtwOkasKGcsUVuXjXEZJtqjyT9EH3LZzcFvjSafT/gwZzZys
 lpUVPcYAHp65SwDSoq97+yakHJaGUJSDHqUP3IR/6XFgGryhnET2bPcBBwt+l4BBJoAf
 KlekBi3O9Du6jYW+tjWWxUF3a2F2s2vIP9lTY3QaER7nBFMIy+6q1f4GiR/CP8A0WIkN
 fdB/G9T/cauftZjSQ0ZR6X5fJK0+kgljxp9Xgz5zx9KVePs3Wot9tIzQdylXAA7efjtf
 /LhcAf7ByDAZtrn+wbZhZimHeIFVO9nKbrZ6UJndXcx+EBMUcxIWxqIFK7srZcme2NOn
 PqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700434039; x=1701038839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0ZdObg+JPE57CQu5Vv/7QazWjDax7G8V2+iH6eEPEI=;
 b=KwokKr78PDmx5LSgvxdAyFl6M9VPNkkMOCK6i4hSARvnGYqm4v540Eln5sGOZM4/Ze
 J93uoH3dfMk7CrG63AAqfV7zcdVO0z8Y9W1yvWGdeHJ+zCq7xFqjqLYzTQoKPgE8qXXb
 XNRXhtPMPL3gnsf179q1wdOkvYIRgrKBu+QjKqqOkMsbdXckuYvzq/e6ROI/5KIqoZtZ
 PpuQg2g3ihuRPPiYZmbM3ONkoOFMCxvVcjnTb+rA5X1QYjUrE3ehGOsJeGgRxQhTd32Y
 AUX3q5LsEVSmSHHHDGv55Bh8rmAMFroz7MMLB2lMmiQKhw3cWIrUSNsUjW1cD5vdZ54k
 rwVA==
X-Gm-Message-State: AOJu0YwnCyvmnbLyCXhULFg/h8Uyb0LSQoWNL4/d+D6wRSsehGuTNO6z
 kJ6IdjOMB0401ROyN+LkfoDGIIwzgrC9ubR0KH5k+Iag
X-Google-Smtp-Source: AGHT+IG2gX9s/JiMFvHZ6SYQvNAT5J80rE2nGiD9LryJo0enDbu7pNYt71Wucoqen7sHBMCDUpYfyg==
X-Received: by 2002:a05:6512:12d1:b0:50a:a991:7942 with SMTP id
 p17-20020a05651212d100b0050aa9917942mr4223468lfg.43.1700434038243; 
 Sun, 19 Nov 2023 14:47:18 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05651203e500b0050798543b9asm982423lfq.261.2023.11.19.14.47.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 14:47:17 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-507ad511315so5279801e87.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 14:47:17 -0800 (PST)
X-Received: by 2002:a05:6512:4006:b0:50a:a81e:469c with SMTP id
 br6-20020a056512400600b0050aa81e469cmr4533471lfb.64.1700434037104; Sun, 19
 Nov 2023 14:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20231119191202.667180-1-sjg@chromium.org>
 <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
In-Reply-To: <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 19 Nov 2023 22:47:06 +0000
X-Gmail-Original-Message-ID: <CAHc5_t0k+Kv9PoZuLiYaMpJAFOmz7OB_Q-eyKTCoa9LToceMNg@mail.gmail.com>
Message-ID: <CAHc5_t0k+Kv9PoZuLiYaMpJAFOmz7OB_Q-eyKTCoa9LToceMNg@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] usb: Avoid unbinding devices in use by bootflows
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Simon,

On Sun, Nov 19, 2023 at 7:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> When a USB device is unbound, it causes any bootflows attached to it to
> be removed, via a call to bootdev_clear_bootflows() from
> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> bootflow.
>
> However, when booting a bootflow that relies on USB, usb_stop() is
> called, which unbinds the device. At that point any information
> attached to the bootflow is dropped.
>
> This is quite risky since the contents of freed memory are not
> guaranteed to remain unchanged. Depending on what other options are
> done before boot, a hard-to-find bug may crop up.
>
> There is no need to unbind all the USB devices just to quiesce them.
> Add a new usb_pause() call which removes them but leaves them bound.
>

I am no UEFI / bootloader expert and while trying to gather more info
on EFI ExitBootServies I came across this
https://github.com/tianocore-docs/edk2-UefiDriverWritersGuide/blob/master/7=
_driver_entry_point/77_adding_the_exit_boot_services_feature.md

If I understand this correctly, EFI ( U-boot in this case) should be
halting all USB controllers like done in usb_stop()
Is my understanding correct?

 Kind regards
Shantur
