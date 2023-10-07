Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB721E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3851086E03;
	Sat,  7 Oct 2023 22:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FYixMTBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D007186DCB; Sat,  7 Oct 2023 22:37:44 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56B7863CF
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso5746801a12.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711062; x=1697315862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=276+bmYJXjgtztfbQVHZ5+lTD2M9BUIbZwvtVFffPMA=;
 b=FYixMTBH1lFIwqXFKCLMwPUnv0UR3jX9ESALGVEwHaBA0DX5rgJa4wzI1JalwI1lzg
 4O2QVOvRE8Xskin6Fu1eMHp9cEURfuVFMSH7MGKTr/UY6sb5067MVwziwdbjPKdsjOfS
 BZQczSDHV2R5Q9FHXjCHWyPWf/5ZdEn7o60RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711062; x=1697315862;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=276+bmYJXjgtztfbQVHZ5+lTD2M9BUIbZwvtVFffPMA=;
 b=iS6eCZwRDHHxqTNvNUuGrdzDpNWGceyuBH0BtDhCB/WEH/9PdrnrDbQPeZtn+dm1JM
 6jnhESLyOUILFcNKfvke1MWeJR2yGZPzOiekiBUhxpz2S8AzTweVQttE7+LANhFFLEkj
 3tLYSQEmK2Ukdq7Fu9fxddQ9Jzk4rksINtxONx6XpuJgq295LuVKIzApb2tAqMr7D9a2
 UuOUtRCiuOIHcJTcH3X9bZdKxh7e9sx/Tpd0qS+s8mx5Q4z1o9sfSclVF/Vgla6a4yj/
 0Wimwf5FZA3K/JIg9yAlYcIBedafKokU6zSACRMMQ8eLqqaT3wUq2J3jLyxqNIHoLgHr
 0faA==
X-Gm-Message-State: AOJu0YxByoPCg2s/VaY1aqvhInANWvV2XzH/tRl/MYowFjmfLv5i7Opg
 k2ai4QD53igS0hggxcDhFtUaWP9j8b8wG+JrBt26wg==
X-Google-Smtp-Source: AGHT+IGszi+nU+Br/NyMV9Fv4H4Rrmow8Fkmosp6NSyS675s7JGq2ocu7XkGsz3p9mNYZ2Sge/FLdqyTNWb3LVvuhaI=
X-Received: by 2002:a05:6402:12c3:b0:533:310b:a8aa with SMTP id
 k3-20020a05640212c300b00533310ba8aamr10453203edx.13.1696711062360; Sat, 07
 Oct 2023 13:37:42 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:41 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ12sWToa9GCT3MakQT8Rh0C-uszfCLRsqj2PX-vXwUF2Q@mail.gmail.com>
References: <CAPnjgZ12sWToa9GCT3MakQT8Rh0C-uszfCLRsqj2PX-vXwUF2Q@mail.gmail.com>
 <20230923194424.1739224-24-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:41 -0700
X-Google-Sender-Auth: _icvpk-B1hSfWf-G6tVUHNia4a0
Message-ID: <CAPnjgZ0dccz6qygeR=2p7_52ru1zLkSvQ0heAAn5D41FpkcYJA@mail.gmail.com>
Subject: Re: [PATCH v3 23/27] moveconfig: Drop the initial output
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Since moveconfig now just does what it is told (build database or sync
defconfigs) we don't need to print what it is doing. Drop this info, which
is of very little use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ------
 1 file changed, 6 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
