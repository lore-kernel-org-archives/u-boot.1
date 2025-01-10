Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7745AE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 14:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE428036B;
	Fri, 10 Jan 2025 15:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jLaU/SIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19943805E9; Fri, 10 Jan 2025 15:54:21 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8351801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 15:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d7e3f1fdafso4205700a12.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736520858; x=1737125658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l2v64/jmMxkBRwv9KSPIp8M7bWgYPRwflTzV3rpisSg=;
 b=jLaU/SIXIpV1oGw11DqiXDJvUUYUYAIxsQE+Ur6uprKo3WEKgkyc+5ViipED2yKBxx
 Bh9/vXWSmww47kRoS3AkLbgweQjXox8OEMwTKfsQvhtl4fPNi6hjDbY0gPdnNubA14KN
 414fC3QQy7GEZeA8xNlOwJrGzL5uy2BYKEV3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736520858; x=1737125658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2v64/jmMxkBRwv9KSPIp8M7bWgYPRwflTzV3rpisSg=;
 b=v99s3cVMat1bOUEEsN1gqTMwnqeU9sBGtVt9q+Brg76SqOjUqKF4FOmoY2zqbM/cJy
 zRcws50y66VOeW2gm366YHJZ9JcaAGFHJS3yM0sY69gm+IHQUWTlTX1f0YG3sN1Kuxk8
 WgNRPZG5Kd02fbhOsC/UUCFO5RK6Zt3S/0CTlCO0mOj89XEe8hdgUoa7w7EO1cVQb5eQ
 8+26s6/4eZEKvMcF8iJY/PMXF9QkZgl0g0QZHlB/rU1maUp7m7ijM5Bl6SpETkcH7Rt0
 xjN5LBjTsjN8k+7oO63qiH90OnykDH06z0ZMXMLxCG3Xqio1DWnYS8AHKczPZIK7pGs+
 3Uzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxyfbyKUl3P0Qi4m80NkhjoxkLKQpsZSfVoWLocfsOlqLt3f7YXrha7PvKJBBsOITVReT3fEA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxm/H5U26bIugdJxRT0w9yNTC0+ijdrU3vnVGA/KeFxcskbzpzE
 FJykFe92O5UivQpAf0D0+K24/kaIQUbS0+OFPOoXKkD+PA9tjl9qf/JBg7bPwmciSpDuIdAUubn
 96XAYY2jj+CeTjiqwMwHdK5Z5vy5uEA49l/Aj
X-Gm-Gg: ASbGnctZ2O/CMkOMuiov84Lzh/KWwq7WjjMZ3xuFARr6l/NMKiJb5uTxeyI5c3ldmkM
 GQDCjHL4+9qwy6sGBO0UtGtR/fPhhRx7f+Q9LXTc=
X-Google-Smtp-Source: AGHT+IHnU7Xk0Bfq4Co0/mSJxxCOWkC7KeBKjXkNznzomsZqymnswdjQafPBHAQE0Y8JWSxZQoqNFnv3FXFtH8eYDz4=
X-Received: by 2002:a17:907:7ea2:b0:aa6:7737:1991 with SMTP id
 a640c23a62f3a-ab2ab16a902mr1004253866b.2.1736520858239; Fri, 10 Jan 2025
 06:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
 <20241206173033.2403998-2-adriano.cordova@canonical.com>
 <9cc4a4e0-1a80-4bdc-9fd7-a04260ff7cb7@gmx.de>
 <CAFLszTiH9+avmapq8CEEr-tqybP9mWZGzqp52mVHsM87FGTfhw@mail.gmail.com>
 <CAC_iWjKmzfbWGD3URheJS4w0Bhr8K_Unwi0KpFV56b4gwwO3pg@mail.gmail.com>
In-Reply-To: <CAC_iWjKmzfbWGD3URheJS4w0Bhr8K_Unwi0KpFV56b4gwwO3pg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 07:54:06 -0700
X-Gm-Features: AbW1kvaWCUg2A28Q6WcB-zyGduFgoz4OpimdRh-rZjPztWeTM07_mfIGr-vcivg
Message-ID: <CAFLszTgkL4o6OoL_dMC45JmCc=YMroFUiLc2BbM8FYgKfSkRSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@linaro.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Fri, 10 Jan 2025 at 07:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 10 Jan 2025 at 15:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Fri, 3 Jan 2025 at 12:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 06.12.24 18:30, Adriano Cordova wrote:
> > > > The command bootefi calls efi_init_obj_list to do the efi set up
> > > > before launching an .efi payload, but efi_init_obj_list is called
> > > > only once. There are some initializations which depend on the
> > > > environment and should be done each time a payload gets launched and
> > > > not only once and can now be done in efi_start_obj_list(). A motivation
> > > > for this change is the following order of events:
> > > >
> > > > 1. Launch an EFI application (e.g. bootefi hello)
> > > > 2. Change the ip address
> > > > 3. Launch another application which uses the pxe protocol
> > >
> > > Hello Adriano,
> > >
> > > Thanks for addressing this issue.
> > >
> > > There are a number of events that can lead to updating the IP address:
> > >
> > > * EFI_PXE_BASE_CODE_PROTOCOL.Dhcp()
> > > * EFI_PXE_BASE_CODE_PROTOCOL.SetStationIp()
> > > * EFI_HTTP_PROTOCOL.Configure()
> > > * command set env ethaddr#
> > > * command dhcp
> > >
> > > All of these events require:
> > >
> > > * Updating the relevant ethaddr* variable.
> > > * Updating any other references to the IP address.
> > >
> > > When not only considering EFI applications but also EFI drivers
> > > installed via the bootefi command all of these events can occur during
> > > the runtime of EFI binaries.
> > >
> > > Function efi_init_obj_list() is used for setups that are needed only
> > > once before accessing the UEFI sub-system. It is not able to handle events.
> > >
> > > If we need to update any internal UEFI data structures, we should do
> > > this instantaneously when the event occurs and not when executing a UEFI
> > > related shell command.
> > >
> > > U-Boot already has callbacks invoked when variables are changed. These
> > > are set up with U_BOOT_ENV_CALLBACK(). There is even a command 'env
> > > callbacks' to list these callbacks.
> > >
> > > You could define a new function to handle changes of the IP address and
> > > invoke it via U_BOOT_ENV_CALLBACK(ipaddr, <function name>) or
> > > U_BOOT_ENV_CALLBACK(netmask, <function name>).
> > >
> > > With lwIP we can have multiple network interfaces. Each has a different
> > > variable ipaddr# assigned to it. We will have to extend the concept of
> > > U_BOOT_ENV_CALLBACK() to allow for wildcard matches by adjusting
> > > find_env_callback(). With CONFIG_REGEX=y regular expressions could be
> > > used for this purpose (cf. include/slre.h) but we should better avoid
> > > the code size increase.
> > >
> >
> > I have been saying for some time that EFI_LOADER should make use of
> > U-Boot's existing tables, rather than creating its own duplicate ones
> > with extra info.
> >
> > This seems to have been understood as 'hang the EFI tables onto
> > existing data structures', e.g. efi_disk_create_part(). But this leads
> > to duplication.
> >
> > Perhaps the EFI_LOADER init should be quite small, and be done each
> > time an app starts, to deal with the 'current' state of U-Boot?
>
> That would break all the command line tools that use the EFI subsystem
> -- e.g printenv -e, efidebug, eficonfig etc

Obviously we would not do it in such a way as to break anything! I'm
not quite sure if that is was a serious comment, or just a reminder
that we should not break things?

As a very simple example, somewhat unrelated to this patch, rather
than maintaining its own efi_cout_modes[], it could make use of
U-Boot's information.

There is quite a bit of effort involved in maintaining two separate
states. It started from a design to run independently of driver model
(which was a mistake), but has since become common in many areas. It
means that a special, heavyweight 'init' has to be done and we need to
pick when that is done and how to update it later. We should chart a
slightly different course and chip away at this problem.

Regards,
Simon
