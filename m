Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03D6EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB35486A18;
	Sun, 20 Aug 2023 23:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mzy0ph0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6429386BDA; Sun, 20 Aug 2023 23:57:33 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20D8869B1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so3422624a12.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568650; x=1693173450;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xxzTwhlK+VYCfMY0yYvSMQQzufBF/jGLbCG2FbnqRag=;
 b=Mzy0ph0xtRuVz62YCpQANoXRCu0bzETVWHcA2qYQqzFyKvuHJu1e0Hv8zfq9Pxj7r4
 I4ITITiuhNtHgDif4XV58unP18eAF1I4Zd2iE6Au32kYhVxwYhUZL2Ht3YlB7DFUqJMQ
 QyFo2lvmqOoVXsQKJDRm+EjXxCw6HlDGLrVoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568650; x=1693173450;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xxzTwhlK+VYCfMY0yYvSMQQzufBF/jGLbCG2FbnqRag=;
 b=gouGnqk71f2ImyFzEezrrNGbR3ju1fkXgpBjpvbU1Wl7U3VWBXV5Dwj9Vk7KYC6n7F
 pjZGEKqezY+ksJBfllwXQav1D9ibxdwAB/OGmqwyffXa5ZKMWyV3dGRa4ZH0Mdy6tKEE
 sxJTQMeTVTLFjeAJmeUbDdRIUzZouis8P7aQrvagwrE2vkw0PYCpdRuoWG6lpSJBHV3w
 m8mV6euU6hOLE2MbFeqgD2/flOhlxS7L+6iOI2lxNHa+1TxAM2WRAvx2OwAfAxuToxg8
 HR6+0fzj0W1WfLCjEEGt3o/bLFN+YU/ToUVzygiXC4PSYcQ8kb6/MiD6gEUFaMC1oFr8
 ai+A==
X-Gm-Message-State: AOJu0YwlgcrAk0OmrwfY2cMYJRuIghP5b3uPK8Ar7OYafLZlv53bxJLE
 g+TjdiBvWvRqJpdfIcsZJ1fmfjPN9IRs0UPZ1htTVA==
X-Google-Smtp-Source: AGHT+IHZcxTCyZK9cQm4OzCdGtfDebr80UEU8LhixSnpXGJJrP644LxnMwVioVy32YS8NY4rBBT5wDF/HcJ4u8/BpP8=
X-Received: by 2002:aa7:d9cd:0:b0:523:4025:49f0 with SMTP id
 v13-20020aa7d9cd000000b00523402549f0mr3240971eds.26.1692568650106; Sun, 20
 Aug 2023 14:57:30 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:29 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3ahTmHPwa8bESuiZbjapA05m_+My3QXv4yWP-KhM7G4Q@mail.gmail.com>
References: <CAPnjgZ3ahTmHPwa8bESuiZbjapA05m_+My3QXv4yWP-KhM7G4Q@mail.gmail.com>
 <20230813195219.159629-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:29 -0700
X-Google-Sender-Auth: 2z32tLdwGr1q0HSE0J8zzAPu6Cc
Message-ID: <CAPnjgZ0MeC-gNzoUXXgQ-ifjzX321XH2T7Qxs+v-dqLkoHypTA@mail.gmail.com>
Subject: Re: [PATCH] test: cpu: Handle both 32bit and 64bit CPUs
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sun, 13 Aug 2023 at 13:52, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Handle both 32bit and 64bit systems, i.e. sandbox and sandbox64
> the same way drivers/cpu/cpu_sandbox.c does, that is in case
> CONFIG_PHYS_64BIT is enabled, assume 64bit address width, else
> assume 32bit address width. This fixes ut_dm_dm_test_cpu test
> failure on sandbox64.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/dm/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
