Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49AFC54E76
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 01:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142A28718B;
	Fri, 17 Nov 2023 02:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zvb7Bxp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1423186F67; Fri, 17 Nov 2023 02:45:25 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B23A86ED6
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 02:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so2086605a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700185520; x=1700790320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QSKk0bBoThsyCgH3KksQY6INIkjzidWayuOaRsquik0=;
 b=Zvb7Bxp8aHZKhP2Ss9szqQfKpNyqfBY4snFmEjy49t/rJOy1AcDLKUFzgvC2ix1LvW
 Kh55jaor7iAm7PP7+NuiPtLb1ugi3rZLHZX6IT3OxYeEwpv0fAOV4iIO49ZAD1z1xfjY
 WXnykcMtbFFH1nQwI3n4bs79Im+7xGbNmqDpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700185520; x=1700790320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QSKk0bBoThsyCgH3KksQY6INIkjzidWayuOaRsquik0=;
 b=tjdMHg7fmJHBvmbNLQcLJccNxYGShvcaKP8MKr0BMcfAOmmCWV9ALRY34usuHv7eKJ
 F5VVN5WXNpZcgcqWLMKMhzRqa4/fEay9TL99t7/RxQATCLevV4p3EQrvQRFP5cn4aRhz
 BHvEEVXH5tpQIIFzIaBCwYW9KLhwU4jXoLWZ4EFIVwoMZhsl/K121cly4WaqpvhflubP
 AbGk8oRhh+DVnfM3aKfDm9KXS8PBfE0SCwLKZZRc38eB8wtAzMB5bdmMMPHS6ZjkLHR+
 3BBahKquJaCDgVmHwAjxIUzSmOZY4WnZRHutWR9+R+626DnrRYFAtLyVfvmdb6Ww0oSZ
 sK2A==
X-Gm-Message-State: AOJu0YydlWT+Rp23V6oKYQXWxzQSn5xYE1lhtId3xf5mR8f7FglQ0yvk
 byJkNacB7SsWtUza6HpE3A9qIiTNt3tU991ZMoJo3Z9Gqfsfzxdt3zk=
X-Google-Smtp-Source: AGHT+IHiorW5IfHLAbRmZv8ffoWW1tfdHRyQW2ISzJap7BntM1Dvhbjr3r4ko0zZNdOO75cTCFeSV512CauI53V4+fA=
X-Received: by 2002:a17:906:e0d0:b0:9e4:160a:ef6e with SMTP id
 gl16-20020a170906e0d000b009e4160aef6emr13490008ejb.51.1700185520007; Thu, 16
 Nov 2023 17:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
 <CAHc5_t3AC7WWcJSajL6o-Kr1p92BfcWxSdCb6K-LBP980wQQNA@mail.gmail.com>
 <CAPnjgZ3qgJ+6RXLuHJESkXJCxfsj465pj2HoCEWhiqQxsqfUKg@mail.gmail.com>
 <CAHc5_t1fn6PNrsoTa_H7sRrEdP1xUVR8+gt0myE1kq2Vy9gd7w@mail.gmail.com>
In-Reply-To: <CAHc5_t1fn6PNrsoTa_H7sRrEdP1xUVR8+gt0myE1kq2Vy9gd7w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Nov 2023 18:45:02 -0700
Message-ID: <CAPnjgZ36AwGNOXv4k3OAxMOLQxkWwO41kp=W4q=QQQUK1EZgpA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Avoid freeing a non-allocated buffer
To: Shantur Rathore <i@shantur.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Shantur,

On Thu, 16 Nov 2023 at 09:45, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
>
> > [please can you avoid top-posting as it makes it had for people to read later]
> >
>
> Sure thing.

Thanks!

>
> > There is a pending series there which I haven't got to yet.
> >
> I can add that change to my bootmeth_efi dhcp fixes patch series if you want.

Yes please

>
> > BTW, for this patch we need a test which covers EFI on sandbox,
> > perhaps running the helloworld program. The current bootstd testing
> > does not extend into the efi_loader code, so there is really no
> > coverage of the code in efi_exit_boot_services() from bootstd.
>
> I am not sure how sandbox works.
> I was able to test my setup which was crashing and was fixed after
> these changes.

OK, good. In that case we normally send 'Tested-by: My Name
<my@email.com." response to the email. That is then picked up in
patchwork [1].

For sandbox see [1]. For testing see [2] [3]

Basically sandbox is U-Boot running on Linux as a normal app. Most
feature development and testing happens there. It uses primitive
emulators for devices so that things like the display, i2c and SPI
work. That allows us to write very simple and fast tests.

The standard boot tests are all prefixed with 'bootstd' so can be run
by themselves using that name.

[..]

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/arch/sandbox/sandbox.html
[2] https://docs.u-boot.org/en/latest/develop/testing.html
[3] https://docs.u-boot.org/en/latest/develop/tests_sandbox.html
