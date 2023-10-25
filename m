Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9934C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 02:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A62F87A1F;
	Wed, 25 Oct 2023 04:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K5zNknZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A07E87A22; Wed, 25 Oct 2023 04:50:14 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1ED879E5
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 04:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso7821580a12.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 19:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698202211; x=1698807011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lvZdoFfzkZiSQnOKQDYZq091xS+4BEgppnlbY/Qf0lo=;
 b=K5zNknZdINFmvZffcQEgNbNdeO3sLzri/Eiv+vYr8lopj9cgBHXuS/OqqMiGegYYGa
 fNtEJOr+AYodBUfbK7Zj4Lz73P4IqaCW7tik3nzjN8fIYhPBlmMLlm5igqCJDNEA6qWi
 W7Y6Bdaxv1SRqpn73oqtW2zyo7aqJSWXv8FQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698202211; x=1698807011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lvZdoFfzkZiSQnOKQDYZq091xS+4BEgppnlbY/Qf0lo=;
 b=ADk1qbro+fh40esFGykBbWsetEdoXeNIeNJhsh4WgVCGYMaXToYDHg3nCX97noSv6h
 G9E4Z96V1YYv7Pyb32Fmmp2oURRpZJn4tH0FlhjrF4wzYrZfBfzxTg3old6dzlkm8L/B
 fO3voTNMGGHqUzn4UqPDGvlqh1qtIy9S+n0lABkl+gk3SMTK2C26aCuMaJBGQhvgEfV/
 dO4tsUfkf7cGD0nFjkYBEmhsl8Q2mdIHOocrbZtu/QZGtKn5zaPIVKs9xRUou2HU6lRZ
 sl9EwB7wuOrI28l1Z7b78D0TzLsEO3CHSi0lRdjRvowjKlAhk/qNQAIV3U6122S9TIdj
 INHw==
X-Gm-Message-State: AOJu0Yy2FLahFEZ3CwdWR4alLZR6dXalOnZ3mKRLozfht/Wh6lho6kIf
 VAF0ooE9Zc0APoAjmKKA6aGNxJuD3Eei5J7cUxf1/A==
X-Google-Smtp-Source: AGHT+IHYwbUUGWjoTYZ3HuXGntSbj10VHmp/+bH87dofUcsaN6QmbpNLe4slWKk7dFJSEvoPVcaXthXf1OtHU9dk2BA=
X-Received: by 2002:a05:6402:2693:b0:531:11fa:eacf with SMTP id
 w19-20020a056402269300b0053111faeacfmr11105913edd.2.1698202210891; Tue, 24
 Oct 2023 19:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
In-Reply-To: <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 19:49:59 -0700
Message-ID: <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
Subject: Re: [PATCH v2] smbios: arm64: Allow table to be written at a fixed
 addr
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

Hi Heinrich,

On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >U-Boot typically sets up its malloc() pool near the top of memory. On
> >ARM64 systems this can result in an SMBIOS table above 4GB which is
> >not supported by SMBIOSv2.
> >
> >Work around this problem by providing a new option to choose an address
> >below 4GB (but as high as possible), if needed.
>
> You must not overwrite memory controlled by the EFI subsystem without calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fallback for outdated tools.

That is not my intention and I don't believe this code does that. EFI
is not running at this point, is it?

The bit I am confused about is that we don't support SMBIOS3 in
U-Boot. I am trying to fix an introduced bug...

Regards,
Simon
