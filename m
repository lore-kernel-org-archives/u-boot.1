Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEED7E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED4A869C8;
	Sat,  7 Oct 2023 22:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hvMTmSog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498F4863CF; Sat,  7 Oct 2023 22:37:42 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3EC8694A
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5344d996bedso5835643a12.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711060; x=1697315860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TDya3hyMsAeF5E6Qh+IvPur94P2g1N0tU4vlFrU7Le4=;
 b=hvMTmSogIz/qdRqIiDfdMsm3lwDkWolM7+eSz6qx+OWEtzYTC8ZFZaJUrM70qDDUGz
 H43zM7Y7dCk0EzuojHTNWXKVPEY3wV/gnmE3CsAzRjpFKTxw3D4X0cLD2OJoYXa6YMbS
 NmV9yCp7yCmbhsh6UPu4qi8d/1vkWF6aIv6MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711060; x=1697315860;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TDya3hyMsAeF5E6Qh+IvPur94P2g1N0tU4vlFrU7Le4=;
 b=pdnAATzMeFemRSFK8tSyXo6ELpjOljQ5NXhq+FxzCLy69r2VTpj1qyOsX/bzeJ+ROJ
 mvSu3XmpeFlFZiNxR4+6lN8/7PD35nri2p5eFmSYLjZk3cTajOkg6+c+5NRC0z84nRTf
 dwBOKIAshRgds21INcgDzLnevTpMD5cJN6cho8U5VGmrm7bPvcfslUcDRUD48XbahsSX
 cuHZhNmXIyQJcV1/VZb9sEpBZfWFGqUk1Cvn2IHcQjOKebHDxlesA1eVkaBa/54bqB4w
 C97hibepYS6KXHSasUTAvDrrbFwOGoqoh5IIllQXaoO45K62nJrHPIWkaWMGQqj5TGit
 Te9g==
X-Gm-Message-State: AOJu0YzBZtpJo6ne4sodLkvWwpIhR5dOWFR0jDcYnVTG7DNIcIO5N6/c
 IrernG7ex2YaL14/zb/gQ2SSpRhrGwvcDObhjeyEmA==
X-Google-Smtp-Source: AGHT+IE3KHG/lkCiMmeQwo9LHKqarzBGQLBLq9mV0IFTJ621SRS1X1z9NnMMVn7xOZZT/ibPMUjfuTtj4xGYh9i3I9c=
X-Received: by 2002:a17:906:214:b0:9ba:113:553c with SMTP id
 20-20020a170906021400b009ba0113553cmr3916723ejd.71.1696711059619; Sat, 07 Oct
 2023 13:37:39 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:37 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3pMwp2_CmJ1dZmskgs2M-7M-uWQSJzfVp3a8qPJLJZ6A@mail.gmail.com>
References: <CAPnjgZ3pMwp2_CmJ1dZmskgs2M-7M-uWQSJzfVp3a8qPJLJZ6A@mail.gmail.com>
 <20230923194424.1739224-26-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:37 -0700
X-Google-Sender-Auth: h2b2ji7uQy_5yJwH8ORhBgTUOdI
Message-ID: <CAPnjgZ1gdBjBQNviv6ZWHEUT0uQF64ZRdkUwniQYBD7zFJciAw@mail.gmail.com>
Subject: Re: [PATCH v3 25/27] moveconfig: Rename the tool to qconfig
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

This does not move configs anymore, but queries them, based on a database
it can build. Rename the tool to better reflect its purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/{moveconfig.py => qconfig.py} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename tools/{moveconfig.py => qconfig.py} (99%)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
