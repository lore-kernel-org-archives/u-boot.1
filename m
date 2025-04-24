Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E55C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 17:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35C480079;
	Thu, 24 Apr 2025 19:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvqHzTlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496888056A; Thu, 24 Apr 2025 19:36:22 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A38A8003E
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 19:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3105ef2a071so14272961fa.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745516179; x=1746120979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wzNkeIbwNMTNpZhJpRgxTJnUCEmJe5ED8i488X9Tysg=;
 b=bvqHzTlSi57LB26JuNb6Uy4kxkT2nSfsQp028bBGxT13maq6+eUO57eLZefXVDA2us
 AKnJLZ5dESKFyrcm0YKIuc13EE3jEyUQSEAYCDTqlYESy17qQLNHNCsq/pAqv4ywKSUC
 zq4YDiIDQxbJ0fqK7JIQNK9vPegRW/5e9EoCHunHz+M116a2DVC3zgdKts6lRR9/x3u1
 Zfj0i0dT5bfWCwDct9VBNbLDUbJo+VSSDaAa+rXu+ri7LEiukq/ABww1FgTIJdSzUqXb
 6MwC88eEEUAeQ9F93Jqp3+9RR2zsAo1EirMS2FPBBC53mUVdJl+nZvlwFA50Yt8/+xcv
 Ojtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745516179; x=1746120979;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wzNkeIbwNMTNpZhJpRgxTJnUCEmJe5ED8i488X9Tysg=;
 b=WsB4bPffK3fq0t8BSnCgDrJqRgsTxXnogeF7S/0ilvFHGNSp/bwPFoGA44nehyrtxb
 iXKFld0ubIGB4tAbnCTKEk2hMylHdhUYscMFQPvGq5agg6fZJGFqqEavBpL5JdnWszNt
 qAjCSz79bE/7zuaVO/Orr71ANi9AEfAYvbecEuaVQcNB4UA2BS4R25mObrQdy58jyJYb
 F+Es9/qTZVAIMTQZgagKC9sSO+OYDRhrQz236sNPSpMDZzjX8Ql71jjZNu6gVvmB8Id9
 bnGlAAvApr7jAUb2bG/WnyxRMdyqflW3RUJYEMLVsvTyXPg0EU9/njzuNSqasQy8rNAN
 FA+w==
X-Gm-Message-State: AOJu0YyuBlKW8FDKb3tkQQFXr+Ahps9kiv1XXFveXq0N1CVaCjQc1nh8
 sjZzrmtcZ3DHvPsIfLFtYOCG+kdwQCfpZj4lsjq83xe+oU4Jc9hy3wff/1VqIjO40gr6SwB/b1M
 oQMqO4nHLTh6YzF6booMlHuZT5xBxWKNV
X-Gm-Gg: ASbGncvPsdC+Y/y9ug4lG3V9cqa++9k5SuFIter5uVHxU9KA6050sKA9/nCoCHMTLdw
 SmJRnVTSSdAmbVXx6bZXKhgJdNP0KDNx/aFD2dEFDraHx8VabSk35DZwaRw4TGc3jDsgvd4d/Bi
 OUDP7naxVzYT3gtU/ZTWhtmgmtiiWjQ9LzrklhxXwNDp3d33tG2uulrAZn
X-Google-Smtp-Source: AGHT+IGDi6wQp/dO7bqZshKEHifpHsKLNglzG7Pp+B6W7hiDX9bbXwnZ7bZnbdfOBz3whwUfXTR7JemtM5PFxFvE89I=
X-Received: by 2002:a05:651c:12ca:b0:30b:c22d:83b3 with SMTP id
 38308e7fff4ca-318a7ef27f1mr1597171fa.15.1745516178879; Thu, 24 Apr 2025
 10:36:18 -0700 (PDT)
MIME-Version: 1.0
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Thu, 24 Apr 2025 19:36:06 +0200
X-Gm-Features: ATxdqUFuzGE9R9jmfjiyAxSrOW-di3IWcM7D6AxEVXeiA-WEz-q2m_WOKFiqNOw
Message-ID: <CAEyMn7b90ybqMOgb4ViAaQVqvTuma-HyYkwEvSVHfowfvEd3tA@mail.gmail.com>
Subject: bootflow: extlinux and menu
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi,

I tried bootflow for the first time and wanted to test my extlinux
configuration with separate menu entries. But I don't see that the
menu is shown. The default value is always selected. Am I right in
thinking that this is not supported with extlinux?

BR
--
Heiko
