Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A7ACD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD7086D21;
	Thu, 21 Sep 2023 03:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z+jy7n4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E21E86D27; Thu, 21 Sep 2023 03:06:12 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DC486D27
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59ea6064e2eso5589987b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258365; x=1695863165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oGr8/S64zJkjAbHeyeoGAPKBEhTXXl8KhaB6KzYkLjI=;
 b=Z+jy7n4WMqQeVGC5berzxuQHhklvpOWi4wKqPAfUPIUZVPqT7JQm7sLoKH9uN+90+U
 hkAUvpGv+OsVPDf1CBW1+uBxd26GFRCHS/ED8Mt5EHGBFbjUHEYO2ARX0RXm/hNbIq3d
 PhmtoFVa4402SR/Qj91ezXgO9ytWN8CXTRY2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258365; x=1695863165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGr8/S64zJkjAbHeyeoGAPKBEhTXXl8KhaB6KzYkLjI=;
 b=poDV00SxmYyDAanx0GVlK8CIMi8uVMViz3sPj2WAFqvZpMN5ONV2WCjTPl1jkMvYwP
 Oy6LqwOIaSauBU/l68N8B8h1+MNO0HIlVzlfgoX9sRlNYAHG4iwpUwYO+9/ZdD3hTIof
 +hK0ErACYDD3yMOSMCc0byvqCoyI9Qm3IxSU2tI0B0CgmW9cGccq8VqRqzB1IqZEgd34
 1A7t/3jAHc4smbaTkJtAjTFzrWUIhGshA8Iwr3MiJe0nBz/LYgR2chGTiS79CQYZ8GTD
 tVv0inTtsTygS84vQHwv/Uai1mIznV8kyZFIFgEpGoyIfQHleVFRgybIGwxsLgJBfia6
 saCg==
X-Gm-Message-State: AOJu0YyuX4Qgk+JKq2T41u/4ITV+1ni4g/h0Rug7Mf8fkMPqkLY202ZV
 HUkz/A1scJOw/0jOLB3iET9xBQW4zVpPtzWXdReF30CCMkUncf3bddw=
X-Google-Smtp-Source: AGHT+IGJyyrJQQ99GjT1viheReGRqsxmX5ayviz5t17PgVbe3PzPt0dth9Zq3p5QLA+gyRR4X7Tj7CqdGTqVNqb6nuQ=
X-Received: by 2002:a0d:c0c7:0:b0:561:206a:ee52 with SMTP id
 b190-20020a0dc0c7000000b00561206aee52mr4938446ywd.24.1695258365289; Wed, 20
 Sep 2023 18:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230916082507.583405-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230916082507.583405-1-massimo.pegorer+oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:53 -0600
Message-ID: <CAPnjgZ3byYBoG5sARtnWRTm8cBcFz4wC4n3UGKqe5Qew4zKg5g@mail.gmail.com>
Subject: Re: [PATCH 4/4] spl: atf: Reduce SPL code size
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
> Previous fix commit increases code size of a few bytes. This minor
> rework finally reduces SPL size of about 64-72 bytes (tested with
> buildman on several aarch64 boards).
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  common/spl/spl_atf.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

It would be nice to have test coverage of this code, in a sandbox_spl test
