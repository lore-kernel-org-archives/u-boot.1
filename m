Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C20AC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7536F88860;
	Sat, 20 Jul 2024 14:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T0WWymhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803FE88859; Sat, 20 Jul 2024 14:36:23 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3278788669
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b797a2384cso16162206d6.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478980; x=1722083780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h3++tc1/yadXnhKuHGTeNqx5C+IVTH4Atu9NtAU1RjQ=;
 b=T0WWymhNTD7nnRra07uNgeh8rvIQUkOAO858u5UJQS05gorkZ3jllJz7lKUkMRrnQ4
 bqS33V4JUvK1anjqzUUhrGN72a3+aAsfRx0jU2N1hO2KfBCjRPvmGD6rvVwty1sJdpl+
 ki8XDCy/DbJQHvG0Z+F6tiN4xL3Z56s7PcLaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478980; x=1722083780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h3++tc1/yadXnhKuHGTeNqx5C+IVTH4Atu9NtAU1RjQ=;
 b=lJMAeJEjYcwXtl4QS16yKfx+5grkistawUJXltV2xOiC38b2iTCmWfAfNTTiMci809
 c0Yl8ooivLHDMpaIAAxRgzE5vuyHfsUjn8B1xx55EqHoKeGxgFmxhSq/YqA0fSUPBrJC
 ef3pIhgMHip+QprjRVegSmjU2frjxj2Ce+DPVkDR+/Facf5AZPIbVq53AFtcE3yuTQmR
 JhN0M6noCuxeiVPyplcjEmrS5zru82+Hem0+EjZ4f9ycrkaTqActBg1ZgJRcmNQecXZs
 KoLRqUi3riPS1t79SSjFwHPwAzuk5AYYT24s46n9WGTQLgyS+PhCwXS9zweVb89YZva4
 ZP8A==
X-Gm-Message-State: AOJu0YyC6wcQQLGpna9Xih1s44zjQCOj9Eg3d9P5/+IqrmL/PRe5o56d
 xeib+kXhAvSY27QKnjgdz689HUToNk4S+J7r4R3KKP5H/vl/+uQFM3pvKPI/dlZHfhuiDfWHelf
 srZ+8Atr5sBNP8arh/SAPpVKirobNKR7SJrrNa9b04sQGrT8=
X-Google-Smtp-Source: AGHT+IFhIUFu4+8t8qSQMJRpr8aYbCYJqapnD1ZiQIRbIzEDWtDJM2u9A/v4lY2MFXJYGX5HUumDvUoAwaj9IXsdT4o=
X-Received: by 2002:a05:6214:21c9:b0:6b4:f9b0:e8c4 with SMTP id
 6a1803df08f44-6b94f02a935mr32491746d6.10.1721478980183; Sat, 20 Jul 2024
 05:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240717174118.845390-1-trini@konsulko.com>
In-Reply-To: <20240717174118.845390-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:09 +0100
Message-ID: <CAFLszTgjmoB-7S2SemHCPmP_A4GGKfs0N+GLMz_LT=Svp2T_YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] test/py/requirements.txt: Bump setuptools to 70.3.0
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sebastian Kropatsch <seb-dev@mail.de>
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

On Wed, 17 Jul 2024 at 18:41, Tom Rini <trini@konsulko.com> wrote:
>
> There is some potential security issue resolved by upgrading to v70.0.0
> here and the latest is now v70.3.0.
>
> Reported-by: GitHub dependabot
> Suggested-by: Sebastian Kropatsch <seb-dev@mail.de>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  test/py/requirements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
