Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFAACD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB75486D4E;
	Thu, 21 Sep 2023 03:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="heJozM29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A8F86D38; Thu, 21 Sep 2023 03:06:30 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CE686D2D
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59bcd927b45so5699437b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258386; x=1695863186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MoT5ee+CEUMhdPrEoV+eITOFr6DwHo60npYJb6dihw0=;
 b=heJozM29pEFsepU37Fr2M13dCXPf4Zp/7XOzcQbDhy/TlGdR2tOZtXroBZN9ujg9s0
 EPjvBwGkIyzqv8MGFYVF/arKk16a4+Srnz7+L14neoQsgdQIAZboRK1R9+63TkA5hh8p
 V2l7zJ+1GsWCUDT5oNECyN6td5/cRdM1saF/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258386; x=1695863186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MoT5ee+CEUMhdPrEoV+eITOFr6DwHo60npYJb6dihw0=;
 b=DPdch8YBPcAtpKKDs0bX/BkNniddcpiog9W1EFNsoX2PpuOyluCqfwjUD3P2OalZ6h
 RCHG3Zo2NQK17+680as+W5iu+4jRVKHL8IsnYI/jwhu0t2ycENa/HiJ49I6ylmwGVWLk
 DMwt26f0Ms9d5pKXiFPRjB1BtfSghi5BU9Sxy6bO7wbh3Yv678ALgVc6pAB3jVRlQ7p5
 dPLHrjIJVi5MdLoNH28a6JUAqwZaQfnYwfMRXyFKh2NmBDJNaqTvLY3dyV125pkWYEJI
 OjzN3SpCf8Wpew0Jf7qLlZhLLSY04NEzZhMepxZYO+j8CACjzzBFWkqQubd83o/9uOMC
 Zk2A==
X-Gm-Message-State: AOJu0YwvGg6jnC4uf5COnCr5D9o9K3EHmHvW7ca3RcpWoFl4jgCclOpL
 g4XoLN+meUdhHumfpBGOdOSv58YUmATUoANn0tKrZA==
X-Google-Smtp-Source: AGHT+IGzgfbfYIGZwtEe8dR+L3icwAdPMCF5bilrNF4RtSeRGEHpjvc748uHHHP2I0Ejnr+9e4w2axGE2XuQmsEm6Fk=
X-Received: by 2002:a0d:dd13:0:b0:56f:fffc:56ff with SMTP id
 g19-20020a0ddd13000000b0056ffffc56ffmr4194145ywe.42.1695258385898; Wed, 20
 Sep 2023 18:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230916082457.583383-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230916082457.583383-1-massimo.pegorer+oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:50 -0600
Message-ID: <CAPnjgZ0KWeATa_vdvjJ370qXQ1zpHH=DxqvmaY2_mEzgBXZVxQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] spl: atf: Fix potential but not occurring bug
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
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

On Sat, 16 Sept 2023 at 02:25, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Bug: function spl_fit_images_get_entry returns uninitialized variable
> val if both fit_image_get_entry() and fit_image_get_load() fail (note
> that both of them do not set val on failure). Fix: use val only if
> entry or load address has been retrieved successfully.
>
> Note: in real world a failure of fit_image_get_load() will make current
> SPL flow to break on loading images, see spl_load_fit_image(), before
> entering spl_invoke_atf().
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  common/spl/spl_atf.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
