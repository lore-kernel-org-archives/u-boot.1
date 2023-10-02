Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A40E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2556871DB;
	Mon,  2 Oct 2023 20:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NxPqoQFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239B5871C7; Mon,  2 Oct 2023 20:56:59 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D209869C8
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so9962966b.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273017; x=1696877817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=atuDs1R48W9XzsoI/J2MUYTDzCK8/i5+G8f95WLc9cI=;
 b=NxPqoQFar135VV6t08qpjmv3ErqOWOFJ3mD31BWfmp50JuxO1rFR5rMGeCzM1yMSt/
 Fy3TEtj2WZolb1CSDb7sxa7OyBY+SNFE5K9ddMdOWhIosH4yrVnBW8ZUV7xASzZJ1Zrw
 EDqdi1oXPliQRez3TWBLq3OIN6z6uBR4JHYmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273017; x=1696877817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=atuDs1R48W9XzsoI/J2MUYTDzCK8/i5+G8f95WLc9cI=;
 b=a3s0zM6/vVQhEsR1nNW8NVpr0H+Zyk+ubDP4BVGuaFheUqInUl+5CauOzsUw1Z6DqX
 EtqIeQcAjxBC5j0JRfAPNa7LzFe7N/PImZGcS5R2/FgjUefiB4j9lW4CFNLp8SvJ0MYc
 8uA5Q/m89EtBiAmLA7EEh/lnITJ3WP1Ix4l9o//OsXRr0e6F6x80nAwxWv1QIlIiUSH8
 aP9FHLGp+oO18WQSQYV25BbhYYn029cLkF/0yD5CYRUX7kePUgQmO+aK1v6Eo4iInUML
 munP9RlUAfyZ/IJXOHEaO8eONM6HgmlBZ/elPkawwLM4aYbbDzMuA2OwyAJUD0gGu25R
 u1JA==
X-Gm-Message-State: AOJu0YyOK4LxpWox8A3Su974p0HuiN80VmuVQh1IX62dfWlkJEU8Sq7N
 zlo9RsnWWmlBNbZDYVUii0QGCuxWYX+ZGUqKXTCmwg==
X-Google-Smtp-Source: AGHT+IEk8k4QE0p3wUmtNQbAtynasqoEbCiOmjMevhoKEqy19wA6u5+GdojfA+pVuf5URjrXojXodKtbhPTiTj0xn8A=
X-Received: by 2002:a17:907:2711:b0:9b2:6b4f:d5ab with SMTP id
 w17-20020a170907271100b009b26b4fd5abmr10865051ejk.29.1696273016752; Mon, 02
 Oct 2023 11:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231002124217.68220-1-artur@conclusive.pl>
 <20231002124217.68220-2-artur@conclusive.pl>
In-Reply-To: <20231002124217.68220-2-artur@conclusive.pl>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:36 -0600
Message-ID: <CAPnjgZ2E7LgCovBqKv4eWrPcYPNS9JfYYfBpaQ+fLV1MFs+EWA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] common: Add generic function for reading serial
 number
To: Artur Rojek <artur@conclusive.pl>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, 
 Marcin Jabrzyk <marcin@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?Q?Rados=C5=82aw_Adamczyk?= <radoslaw.adamczyk@conclusive.pl>, 
 u-boot@lists.denx.de
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

Hi Artur,

On Mon, 2 Oct 2023 at 06:42, Artur Rojek <artur@conclusive.pl> wrote:
>
> Provide a generic way for boards to read their serial number from EEPROM
> at init.
>
> If CONFIG_ID_EEPROM is set, the new serial_read_from_eeprom() function
> will now be called during the post-relocation part of the board init.
>
> Provided is the tlv eeprom implementation of the above function, making
> use of the existing, yet never utilized, populate_serial_number().
> Boards which use custom logic for interaction with their EEPROMs need to
> supply their own implementation.
>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
>
> v3: - restore original function name and make it static
>     - provide a generic function for reading EEPROM serial number and
>       wrap it around the existing tlv logic
>     - move the env var check out of populate_serial_number() and into
>       the new serial_read_from_eeprom() in order to stay consistent with
>       the documentation
>
> v2: - rename the function
>     - move function documentation from .c file to the prototype location
>
>  cmd/tlv_eeprom.c | 25 +++++++++----------------
>  common/board_r.c |  8 ++++++++
>  include/init.h   | 14 ++++++++++++++
>  3 files changed, 31 insertions(+), 16 deletions(-)

Can you please use events for this? Something like EVT_SETTINGS_R ?

See the one recently added for how to do this:

INITCALL_EVENT(EVT_LAST_STAGE_INIT),

Regards,
Simon
