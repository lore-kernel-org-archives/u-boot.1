Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F50C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D6B9870B7;
	Wed, 20 Dec 2023 08:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KeTF5KR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F44871C3; Wed, 20 Dec 2023 08:29:50 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706348700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso3626950276.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 23:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703057387; x=1703662187;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aA/lXTE65T6Hxr6Ww+zTRVkAa0SFnalu36z84LvyACo=;
 b=KeTF5KR8XlmccYnsDRtbOFcm0mrpSSfqu9efeueOC73qpdW3Obn9/Cz+z4yNmI647g
 qZxkycHE2y3V3klFgOVkEJvDKK8NLgTa/m0Q5+4hGbrCvOhbEikQ8jrnWcxDT+yGFuAn
 mI6t8jwdh+5Sp1EU3fjW1iNEZLxqhbWnQ4NM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703057387; x=1703662187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aA/lXTE65T6Hxr6Ww+zTRVkAa0SFnalu36z84LvyACo=;
 b=UtKvM2BShvQf5haOZD+sSrAEXFkRD+F/raCwLp4aERN3+y2/Ernt/NfGauEwGP7xIM
 CGwI/4mx5n1AJGt+JPmTFtDhOXuOLwailGERHG72R/xu/o10VTl1Z4jOgoldfOSJkiIE
 l1oGiq41sNb8cFTRASQZZDbIpZq4GwJOff9nGsUXKfwlXZGZb5RdB2WUre8krQ0pPMLG
 pbuuIunJGQIDBE7ZwWbEykQ76oJl9YeaQE2rVrxGexl+cWAEvewg9jkTMJT/nG5o0iF1
 uqUtcohd7BpbJHjJ4wJvLxLq+SzgJaP6AkUGkZTmtqFhTOC+pvBilt0y1jucJT4Q6HrG
 LQRA==
X-Gm-Message-State: AOJu0YzidX52L1LpGzunWRqwtag2PE5YVmVlFbFV9bixmjUlH+bZHvmW
 1IInez7n1N6uTwi9dOZu2Vzw7UYC+Q9dKQ7g9RzQtxoclu0BStGEmOehGA==
X-Google-Smtp-Source: AGHT+IFfveRh3yh47Q144ZlixReIRY9aiVjq8/F8L/WjfCblyJdTYZBGN2nS6FwmnAICT27mYQatWBCRPuGcD4QYa+o=
X-Received: by 2002:a25:cecd:0:b0:dbd:6b23:2677 with SMTP id
 x196-20020a25cecd000000b00dbd6b232677mr1192487ybe.95.1703057387151; Tue, 19
 Dec 2023 23:29:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
 <86732ea5dfb703525e50bfbfbdeea188832611c1.1701853668.git.tejas.arvind.bhumkar@amd.com>
In-Reply-To: <86732ea5dfb703525e50bfbfbdeea188832611c1.1701853668.git.tejas.arvind.bhumkar@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 20 Dec 2023 12:59:35 +0530
Message-ID: <CAMty3ZDaZO_QCSx0MNUdtHqfzyDB-uRKc3QN+fRj02TzkCsMAA@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] mtd: spi-nor: Add config to enable flash DTR
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 michal.simek@amd.com, vigneshr@ti.com, git@xilinx.com, 
 T Karthik Reddy <t.karthik.reddy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 6, 2023 at 3:02=E2=80=AFPM Tejas Bhumkar
<tejas.arvind.bhumkar@amd.com> wrote:
>
> From: T Karthik Reddy <t.karthik.reddy@amd.com>
>
> The spi-nor framework will set up the flash parameters by
> reading the flash id table flags, which include cmd opcodes,
> address width, dummy bytes, and bus width. In case, flash
> supports octal DTR mode and the controller does not support
> the DTR. There is no process to switch back to SDR mode.
> To avoid this issue, create a Kconfig option SPI_FLASH_DTR_ENABLE
> to explicitly specify to enable/disable flash DTR support.
> This config is disabled by default.

We cannot control controller fixup in flash, DTR read based on the DTR
flag I don't think adding extra CONFIG to hack the controller with
impact is.

Jagan,
