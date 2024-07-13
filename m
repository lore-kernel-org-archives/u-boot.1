Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEF9C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EF0888CC;
	Sat, 13 Jul 2024 17:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oMe8SDtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469D988837; Sat, 13 Jul 2024 17:14:30 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BC388852
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb1c918860so28875335ad.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883666; x=1721488466; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5fd7N8jfV6JFNLEiJgCmggyFShSFMmTsdpKyy6SQ464=;
 b=oMe8SDttnO5esTo+yEXRldGVRMJonXP3yHoXxXojyjBfCZJqKWqXLOj3cUfDGcGhb2
 Y1/1Vz7JCnRenDEsPBSWV+iKNLBwBNpBbKpqq+bx3MjLPA8HqDNCE2E/Ye0pePUOw9iD
 6UgbVvymDKeX+R8K7NjQkd6UzjEDx6vqedomE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883666; x=1721488466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fd7N8jfV6JFNLEiJgCmggyFShSFMmTsdpKyy6SQ464=;
 b=r7IqV4dJzYagT2hNE8QS7vlwZ7mWj3IIhQRqwuOSZgMlII6dV0dVXDzqNgGO7810sv
 YWpTJ/Z8QplPcJNec2g5798XTGMO22P3/VtENMdJXHdkcniTx+OWmNWkE+s1Lj6iYwZy
 oJRAudNtCBgVo5UjrCtl6g5enH8vn9dh7btMKzRUoQDywNAlVyEHmNZsthTgI2OvONec
 G+Gmn4sHtyNRGmE5USESAIfDCsnK02URq6D9rGYQoMy9RWtYoV2g33CPzb4uwHC0Y3to
 0PGawJUVfmViSuW659I8ixe8adIaKYH8YxmZbefOCKpAtXD62v1/d2FuB+oDX2isYEzm
 IhBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9NKchFz/TmlFCJ/YpHMOSxjRRa22EzHw3FSSsgt8sYUXZd2NeaShi/baUZ5337L+9qKM56FsTiMV9vH+9U4/n/cPGFw==
X-Gm-Message-State: AOJu0Yz5stLl0dGWxpWvsBr+d+l7NLbw1Uir5hya77EXRR7tlsySk0oJ
 8ABc+X7nYsZSFgy5xRDJDrfZ8dFua6apJmrIff99k4EKK3XAa542NjllZ2RemXfmouTRY0XMnNZ
 7aMUbS4E/KlCgO5IAs4SExg59YEJlMSn8YhlLC+Ngfr6m82E=
X-Google-Smtp-Source: AGHT+IF1vLNuc1SqOfzvhaMV4VToaxSLTJpBSjrv37/vHDHHcaGI1OnwnIC59uVgg6CPhI5C1JbYdkWZDew/7dBGsqs=
X-Received: by 2002:a17:90b:4f90:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cac509b501mr9074508a91.19.1720883666723; Sat, 13 Jul 2024
 08:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240708164812.1205697-1-sam.povilus@amd.com>
 <20240708164812.1205697-3-sam.povilus@amd.com>
In-Reply-To: <20240708164812.1205697-3-sam.povilus@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:53 +0100
Message-ID: <CAFLszThjANTn5kiXR2vePkgbXa1SveJ7O+A6QJwG65O5TSC=Uw@mail.gmail.com>
Subject: Re: [RFC v4 2/2] doc: add missing table of content links
To: Sam Povilus <sam.povilus@amd.com>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, u-boot@lists.denx.de, git@amd.com
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

On Mon, 8 Jul 2024 at 17:48, Sam Povilus <sam.povilus@amd.com> wrote:
>
> add missing table of content links, make alphabetical
>
> Signed-off-by: Sam Povilus <sam.povilus@amd.com>
> ---
>  doc/usage/fit/index.rst | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
