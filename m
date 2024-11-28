Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE8ED69119
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E08895E2;
	Thu, 28 Nov 2024 16:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V1fPH4NW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3585C89885; Thu, 28 Nov 2024 16:46:08 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F00893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7f46d5d1ad5so640465a12.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808764; x=1733413564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1YDGyIoAyII9g+3pZkF6oobVFAtOOxfZ7lNUPs7csxM=;
 b=V1fPH4NWxtzOjppNnaz4h7KLRbVT6IgyylBPeS6I0yovTap9tzC0KBs4Y2IVn8ySbQ
 DWcSXYxtuYLrgYseLeAsgMGU/J1kx8PCnH18EWp5smiXve0eWGIxTDVqtalCS/m0BJvP
 nYEsQCMrGwxf8Y6icT0BZv36MK74NeLqH3QjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808764; x=1733413564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YDGyIoAyII9g+3pZkF6oobVFAtOOxfZ7lNUPs7csxM=;
 b=hyRU4HP8nRfjkaL9zrx19oKIVSdlqLebdg43OP1LLByGaIylV0evmVpnwW007SQs1s
 pkip0BQlPw+oDeHVQwH1/flPW5nO3UNtnsD0NaUfI6j6Gj+8OSxGjhWIvYATU+pYlWUJ
 WmOYVAL4kEg3yvKiutqsze5HPIpzk1a7tHKFVU9MUMHy0hg2Vd+rqnYIhxapt+taKJQI
 FsIN8xpV2Dn20EOjcfXJ1n4AsMOJ85ErhCja+rOZ3RbTat4fqIqb7TlwZzKRXaYqaFvj
 Q6QzuRiAyasOumnUUR+PpxINjGWtYYxmNzEyWPYCrsrEp88OuxxFpTzYP8XVyxIp1Zrv
 MYjQ==
X-Gm-Message-State: AOJu0Yxr+MwW25D+OeAo4seDTMCPYmTphapfclwsfwmibVevtSyMdBba
 zKJt6hjicFIWteOY4bjQ71JALs7H5L8OSmVH3pce34+CtEod0eP8lQR7Fkn6ggOpNI+xwEN/1GS
 mhnC/ztbfmel2ZSwyCjWhOIn0r0Htar+9HPXOrqVRfzYS8L8=
X-Gm-Gg: ASbGncvywt/9v6WzZZIhi8Y/1jQTP91RC7BTZkOEWwtog6mZfk2DMvj4TY2PnbVH0ru
 SIRwVanrD76sNrd1Yfb6rqeteZWd8o/E=
X-Google-Smtp-Source: AGHT+IE8MAHiIhtKYut5px2rBL6e+tWD9aVhAkmDlJeV+c3wS+bDBX7QLL47Gl/hr9AaRnlSjE6K6n8t8Sq6e6bAwOc=
X-Received: by 2002:a17:90b:3e86:b0:2ea:9309:757e with SMTP id
 98e67ed59e1d1-2ee08e9fa32mr9804284a91.9.1732808764572; Thu, 28 Nov 2024
 07:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-7-trini@konsulko.com>
In-Reply-To: <20241127172247.1488685-7-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 08:45:48 -0700
Message-ID: <CAFLszTiB5p5MTM_qaCwrA7YfAcYzR7k1uz7X2RY-zb=Qkh-=YQ@mail.gmail.com>
Subject: Re: [v6 06/12] docker: Build grub for all architectures
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 27 Nov 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
>
> For consistency now, and future ease of testing with non-amd64 hosts,
> build grub for all architectures rather than relying on host binaries
> for i386/x86_64.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v6:
> - New patch
> ---
>  .azure-pipelines.yml    |  6 ++----
>  .gitlab-ci.yml          |  6 ++----
>  tools/docker/Dockerfile | 24 ++++++++++++++++++++++--
>  3 files changed, 26 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
