Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768A2C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 19:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56C088003;
	Wed, 17 Apr 2024 21:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BpEnfAKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9924587FED; Wed, 17 Apr 2024 21:28:31 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F67887FED
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 21:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7eb7bfbc712so16059241.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713382108; x=1713986908; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9QWm6bYmdzmXX0Pq7zJpuDmhL6zfHXIr+owbPebWJA=;
 b=BpEnfAKVcy+a934tBfV4t5Wwh2L7e1XbYc5iyojGu8ZTaxIx23YpTpifhA4XVOjqvB
 HaHSd5293DmmvOQEEjhHRmN8pPIITHE9xe/WBBDVmjWLSF7P3dYRkJwVYRRwdguctrZ0
 NS9dy0rxBEJ6fUi0uP9BQYW6bOuqIUAe30ZoLK8VD33abPNE8XDCMKMaIT5jKqcsTyy6
 Bvp9oPWNMDERDVgrAJLTLdqMzoraWZDHLkKe2KyJo6NTz01qqiSs28MwDXTbftCaai+U
 3/STCivl8vVNzsLEFHxLx+lRh5gZod012RqeX44TkOzLICaE29wz+cg2dtTr4A3ptImq
 756A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713382108; x=1713986908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9QWm6bYmdzmXX0Pq7zJpuDmhL6zfHXIr+owbPebWJA=;
 b=wE3dkVLM8CGoIRd8FjV1ZyRJDpPp8ea11vFs5eJU5CfJusjn+LWNnDMgtyHanoYBT+
 0LB6kS0DqP41TjfQxIUNq/1ZuyZyA0KZbLpxth9kd5GXPJ/Mw+BTld7jh34ogXxCt2O9
 rcdftz+rSZvyU3+ATU/RMDw9fF0aZTXyV+WjGws0gV9JZmS5kWduV4mTqFbwes2nbbxL
 oy0rhiwGLKlF2mXz+yMpSgwnYnVm+yzvH5hkOKllBXmMRaztR8e0ZZUmReB8jDcC69oc
 GfIme77DXLvNPuKOW/zzOzCbr8OvxBvVsTyoFqg6ii6JW3OMTR28C6NakOJHVRl+KrtD
 NhWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3TMRML/KQNwQgU7I1K7JHDG2NNhrn17V2YiiybKrekSUNeSRBrd1sYCV94MhUPwmKaudn9CarLBUmFeat4U/oNdcE+Q==
X-Gm-Message-State: AOJu0YymhR0XL2vFOCsLZSEFUB+6mqmoDCXJwPCdib6EnMZ6rqY3TMDy
 Ap5GT11v6Y+28vpJ+FJnmrqdeYSi7YrJz+med1osZ9qEf/aMT7HUuPahuyG0COOEbUpwFE/sqXZ
 V9YQHyd0ZU1wgQBd81GGUMHAPqd4=
X-Google-Smtp-Source: AGHT+IF4/wtwq88ZtdJm91WPGfCacCUMj96/B8xY/GCk03dBaeKk9dzrt5YDVdQaYfFcmIPjw3yuhw5DRYaUISUn/M8=
X-Received: by 2002:a05:6122:169e:b0:4d4:1551:6ef6 with SMTP id
 30-20020a056122169e00b004d415516ef6mr735183vkl.2.1713382107939; Wed, 17 Apr
 2024 12:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-5-heinrich.schuchardt@canonical.com>
 <CANV2PTNLVMQQYugK4HB3Yv6WXmrbXBLB0FswKPHqq47OkX-DFQ@mail.gmail.com>
 <73cea290-b42d-468c-8525-c285fcc7810f@canonical.com>
In-Reply-To: <73cea290-b42d-468c-8525-c285fcc7810f@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 17 Apr 2024 12:28:16 -0700
Message-ID: <CANV2PTPsxrxBuJd=-GzXF5VBsWWA8LFcMvBwYDaX_QqJugD_BQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs: visionfive2: enable SPL_YMODEM_SUPPORT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de
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

On Wed, Apr 17, 2024 at 1:22=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 17.04.24 03:41, E Shattow wrote:
> > Successful in use w/ 'tio' serial tool and Adafruit CP2102N Friend
> > adapter on Mars CM Lite board in DFRobot mini router carrier.
> >
> > While SPL and u-boot.itb payload are sourced via UART the environment
> > variables are from the environment variable storage as-is. This makes
> > sense in the use case for development but may have side-effects in the
> > case of U-Boot as a JH7110 recovery tool. There is now 'env default -f
> > -a' which does not purge non-default variables and retains the
> > non-default variables when migrating from vendor firmware. Consider to
> > also build for U-Boot the commands that can aid in cleaning the stored
> > environment variable state CONFIG_CMD_ERASEENV=3Dy and in-memory state
> > CONFIG_CMD_NVEDIT_LOAD=3Dy. With these it can be done easily with: 'env
> > erase; env load; env save'.
>
> Thank you for testing.
>
> After erasing there is no need to save the environment. If there is no
> environment on flash, the default will be loaded anyway:
>
>    *** Warning - bad CRC, using default environment
>
> Instead of 'env erase' you could use 'sf erase 0xf0000 0x1000' which is
> already available. As adding CONFIG_CMD_ERASEENV=3Dy is not necessary in
> the scope of this patch series I would prefer leaving it to future
> discussion.
>
> Best regards
>
> Heinrich
>

The 'env erase; env load; env save' can be done at the same session
just before recovery write to provide a sanitized environment with the
defaults of the present U-Boot payload loaded via UART, so is not the
same as 'sf erase ...' waiting for a reboot (5 minutes more to
transfer via UART at 115200 baud) and needing to interrupt the boot to
further 'env save'. Having 'env load' allows to allow that reboot step
in-between. Point taken though, it's helpful for recovery but not
required. -E
