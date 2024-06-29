Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED62C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 06:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD515885F1;
	Sat, 29 Jun 2024 08:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qeh3Wv8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E87C885F6; Sat, 29 Jun 2024 08:56:14 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05386885F1
 for <u-boot@lists.denx.de>; Sat, 29 Jun 2024 08:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6ad8243dba8so7769046d6.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719644171; x=1720248971; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmHxv+JMXmvde+9w/mOIkCjZ8aU+CBQUmY3AgjDLk60=;
 b=Qeh3Wv8KGFg8aSLBYGhk8UyLiumteCkjl5A1ReHhpI9Rg6K88m8sgFfJF3dag1KpBh
 ZTjKfKPFEIlKVBVL68SSTWpiT8tZdRwv/FkuI6aXMzFoHnfTCBmkePNyxkR7G5MIS31G
 6P5uKX7encwxjHpLIcp50I8nkrS7Ot2ywDwx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719644171; x=1720248971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZmHxv+JMXmvde+9w/mOIkCjZ8aU+CBQUmY3AgjDLk60=;
 b=cZRWfxjTQRgrYyuu+ziXccVwDbkJHepnG6aKwtgjfoNPzxxbLlkAI4PQohdr73o0BT
 u4UdV3kr8WkXuZx6+feRrhlHAz+pjOJr7GqppoM7y8TZb4dYxsgWwtJyQESQi13QSbva
 9xKukImPHIt1s5/VCUFiy0vZy3hD24uQdXehOkPYRvtmFSp95AjZGJ04kaCB8DdVIlNQ
 nmFArCco7M08O1jLT8/NgR4NWaLLLmqea7tfSdq7IdmyNU26AjwxhdboHQCaxEA6BEgp
 nqyZm5saSo3aSm6nOGODP9ipQLL54yYny9KiAL6MTmVPNxF6i/QjrUDlSvbhg7HjGjqW
 GUzg==
X-Gm-Message-State: AOJu0YwOzWTWRi2ajpp+zEA3k6NXIzcHUrVGw9lw56X1gqy950X9w7ot
 8FZDLJ1SVQrro7GRhQha+Ntdu7RWlIVh900BjJmmC0FekUtzwH0o4juPdS92BvugzANcW3AANKW
 /R3wC7xSo+vJjlETX7dXXK2LDy6lL96PKkGd6
X-Google-Smtp-Source: AGHT+IE/qNksFE1Nz7nAGgV/+qQ8qz5o7j2S3mH0ITJNQSy6KeeqKRSpzIlw65Y3TGsIJknVTotIbczZX0LVTJqQDZY=
X-Received: by 2002:ad4:5aa7:0:b0:6b5:9a8a:beb with SMTP id
 6a1803df08f44-6b5b71aa126mr4547776d6.65.1719644170852; Fri, 28 Jun 2024
 23:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240619123453.720600-1-sjg@chromium.org>
 <171945114145.3478677.13570700547612365560.b4-ty@konsulko.com>
In-Reply-To: <171945114145.3478677.13570700547612365560.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 29 Jun 2024 07:56:00 +0100
Message-ID: <CAFLszTiaqv7CXZg639JybryyaUerjJX=vn+gdh2nCeEPB2PH6Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] pxe: Add debugging for booting
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Menzel <paulepanter@mailbox.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
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

Hi Tom,

On Thu, 27 Jun 2024 at 02:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, 19 Jun 2024 06:34:50 -0600, Simon Glass wrote:
>
> > Show which boot protocol is being used.
> >
> >
>
> Applied to u-boot/next, thanks!

I wonder if this could go to -master since it is an important bugfix?

https://patchwork.ozlabs.org/project/uboot/list/?series=411595&state=*

Regards,
Simon
