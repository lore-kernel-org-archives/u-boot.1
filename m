Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E6D31765
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA317891B8;
	Tue,  5 Nov 2024 17:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="cp+k42Z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF6588EDE; Tue,  5 Nov 2024 17:39:44 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995F789001
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=ezra@easyb.ch
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f4d8ef84so7222289e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1730824781; x=1731429581;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aa7zMvLAhoZcEPZvyaGAtcuFJGfpaHaW0FBXNbJoYG8=;
 b=cp+k42Z2R+AWOumqiia49KRpP1cbMGIbB3QL/YpXp68Xk8cSeUa0NPmHU/I9V783cE
 WZb7KwBM+SffRuOvFSsq0q5jJM07jH5gejt9EZwFv6PWJMOQ2aniBwwf6gcbo2BytFcw
 DIAOGEoby10ZO8ID/Ld7ucqZ3WmcduYEeLkO4YJGx+7FrdrxuTe8ciHVlEkQuFomdmFP
 7Ok2CJNdsb+EMhxIySfjcZzOGMqHwLI4nI2xccfuKREKdHdQk4Iug6Tg6gDfGWZBXq1w
 paAblfaGRZEgXQkfIKW9zbGaS555pF54MU/2In/CScYtTMvI1npX5EFSmxKofufKadrv
 +cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730824781; x=1731429581;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aa7zMvLAhoZcEPZvyaGAtcuFJGfpaHaW0FBXNbJoYG8=;
 b=B8NQGRvM6NqrKy3cDwsy+JNdoVRRTzZQBexkzUDSc1yuH40KMQmeCqCI4rX62Hqbfb
 4ev0JopE23pWONuN0VsuopMtXS2h2I8eWd7YUNn8yw+GcTV6UAfnawZ0jSp8Wo92Yvgq
 4yWZ26EcfHrw3376+1wTkPmeXVLE9IoWnmcckUWJBI7ePUY1pxKq5vV41GFEHI388KaG
 Flwlt6TASJJmPGDVTzM8uDd4YTc5Gmn5Vx9QQGfQVin9Q6mBb9nbwLd2ODUMkDFcmrs7
 HWx6aEF5tN+RSDJPPWzBQ3iAVQbpNw9jVJWnUETRvsPvEQJ+cB3FwGLu2c0ilIO8O6Fu
 sOLA==
X-Gm-Message-State: AOJu0Yy36MhNtYIT6Dc2/UeCqiTDpsWfwnR9KMV6KbslU0MGJl9SrUUW
 WWaK2fLJqbvaq5kPTM8iW2OeHwjmiUtHhMB6DbWD/DJPdweQgAbrFDVJnTsqoBTFNTi8V66QN//
 HTv7PyGC/6pbhe2GS5DQ+Mo2/sN0SA6nuhl9h9+ELZk5FC4grujo=
X-Google-Smtp-Source: AGHT+IFi0Pr9gtQSssQ/nFet3rOe+DDkC2xhDsJlck7vQqvy/InvN3QbN3WpxRCxQgiZw19cg/mU04op59f4zIZviLs=
X-Received: by 2002:a2e:4619:0:b0:2fb:b59:8167 with SMTP id
 38308e7fff4ca-2fdecc2a016mr68737341fa.39.1730824781338; Tue, 05 Nov 2024
 08:39:41 -0800 (PST)
MIME-Version: 1.0
From: Ezra Buehler <ezra@easyb.ch>
Date: Tue, 5 Nov 2024 17:39:30 +0100
Message-ID: <CAM1KZSmui5=jLyDZah402oP=_7rAMrF6FOJ-jt7OxPoXvkZ9WA@mail.gmail.com>
Subject: SPL crashes when trying to load legacy image from NOR (on MIPS)
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Stefan Roese <sr@denx.de>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
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

Since commit 6cc2182c84a ("spl: nor: Don't allocate header on stack")
the MT7688/MIPS-based GARDENA smart Gateway no longer boots. The root
cause seems to be a read of an unaligned 32 bit value from the SPI NOR
flash (image_get_magic() called by spl_parse_image_header()). Before,
having the legacy image header at an unaligned address (directly after
the FDT) was not a problem, because the header was copied to the stack
first.

What is the desired behavior here? Is there some padding needed or
should the problematic code be changed? If so, any suggestions?

Cheers,
Ezra
