Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE87CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E848489032;
	Wed,  9 Oct 2024 03:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BJxT4tGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97EE18905C; Wed,  9 Oct 2024 03:51:38 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C558903A
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso307408a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438695; x=1729043495; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ivWlL46QbFrMyyUPZL1W/0nfabQpO9M/+SIKuwPgoWM=;
 b=BJxT4tGzUxZsf7sGB5KJ0PTAINHNlqH739rleyrqJtJKUHrpsIFn+2JIviBlznKoee
 UCXrwn7ZLtLK4RGpg38esDKafGdkaRD4NLybTLVPUumL9DeqDB1CtpzcQ03z31lqb9MV
 rvbrD7ezP9QRPYa8toHWpT/Ik/d7lOnrQQnag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438695; x=1729043495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivWlL46QbFrMyyUPZL1W/0nfabQpO9M/+SIKuwPgoWM=;
 b=mIe2mnTBNTgcpCYTPfpA2zFUHlpgNvndM6/jA70QWXhfpX2bydiZjwdCLhDc8FL6TR
 uKgFrcdeyEPSyk81bglnraBg4aaNjr+yo5zVaj0Fj6Cy/GIYmvvVGRpHM9qPsYDQQ5I+
 jqgASSiclHjiqiE2CqydwP6pumShK2LdXWJYWH1+c8OIs0VsL6xPCRMRg8nWF+Gu5bZw
 JhTArMIVjmzFx/OZF4YszqPqXQ+jj3JTT1hDt8gWhfsitgssYAjiUdf8BG6ckGk97DaK
 ALk/8Cox8JjAO2Sz5QoEfZcFovYQEFtOX67qPjXExI4RbE564piuU2cHq8htwAY+pS+D
 a6fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkrL1yyXvWfP5VDHNbEqUq/7HLLl7Ge0DWBzHHh6MfRiodnoloZDPxuVyCyZvghl+qj3OEm9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyJ7tWI1Hz0SaMcoih6iw7UUur1mjtz5SYefz7tOOPnx5kNoIOo
 8K/jjUmE+zmlFEZX0kh3CYSlX1FCZmcuedduR3kQwledkRwFl1OEOw7e43NFHTxEQLpIceAfkHt
 KfofVDy4kMOWGqYGBUV+yXwbL1EQPZ2RbPVw8
X-Google-Smtp-Source: AGHT+IFTlC3Pqxq0y/G+AWjjo8VoDYxfKzuNo9eqlBRbs7j7mfhwnyauYjs0iUVi9GoDM42NhL7/v7DWXQ6xkRojsqE=
X-Received: by 2002:a05:6a21:a4ca:b0:1cc:d9dc:5637 with SMTP id
 adf61e73a8af0-1d8a35411b9mr1254690637.23.1728438695051; Tue, 08 Oct 2024
 18:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241002132633.246942-1-martyn.welch@collabora.com>
In-Reply-To: <20241002132633.246942-1-martyn.welch@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:08 -0600
Message-ID: <CAFLszTgzYA9GA9j6pjiQKR3naaCYAYheaOf7_Z8maP5nejJvrg@mail.gmail.com>
Subject: Re: [PATCH 1/4] boot: pxe_utils: Add fallback support
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 2 Oct 2024 at 07:26, Martyn Welch <martyn.welch@collabora.com> wrote:
>
> When configured correctly, we can detect when boot fails after the boot
> process has been handed over to the kernel through the use of U-Boot's
> bootcount support. In some instances, such as when we are performing
> atomic updates via a system such as OSTree, it is desirable to provide a
> fallback option so that we can return to a previous (hopefully working)
> state.
>
> Add a "fallback" option to the supported extlinux configuration options
> that points to a label like "default" so that we can utilise this in
> later commits.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>  boot/pxe_utils.c    | 15 +++++++++++++++
>  doc/README.pxe      |  5 +++++
>  include/pxe_utils.h |  2 ++
>  3 files changed, 22 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
