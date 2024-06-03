Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4898FC25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 16:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31BA88366;
	Mon,  3 Jun 2024 18:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PhZ51CzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926568835E; Mon,  3 Jun 2024 18:45:36 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7302388378
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 18:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c1a272c96cso773705a91.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717433133; x=1718037933; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Os4pwIVI8F0zzdoU3HVlSjLOUEexegIKOExepDgc/Vw=;
 b=PhZ51CzJNj9Vj8xvvXISlkwMhqxOAtqow58nuFmQdk8Xp/jgASoaUM52ujZmos9WMw
 5f54eGtK6ITi6dLxnWBTXVlrYz4lQJ9LnxkSOeMF6iP4U6B8hR0Ps9DgNLdOqaQvOoIR
 6dg5zbdtt+SMG4XqKhP/eIx+ES8IGvBDTVU9dR54KvMdc52Gr18HNuONZ1pmZslIqwYF
 O9n18yhuF6WaOW+N4nBanJf5IYNExvXnqCrZ8jbQzsuRnRWNV5Apyi+Rjrktym5iY/EE
 X06piuYdIyMBwsfgwZb7UuzifUzTBIZDegDcf/By5A0OLFKq3DZIZEDDR72EDlMNYvmY
 b8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717433133; x=1718037933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Os4pwIVI8F0zzdoU3HVlSjLOUEexegIKOExepDgc/Vw=;
 b=xNBus5KbZ7kI+5IGkQn+vcaT15GSgBHZtEkzpKctaASzX0t6C5rmAmdx289V/xJAGy
 Orz+7wdyeCgUFHNa7/70B54UdOwNlzZYPAaJgGkcewuL7Ln8Msg8YubTSypOJG9L/wCR
 IE+4fqpqGOPyCHHxmBVB4FI2PsEdvr7bwvJ3cwWu2k/qJqYhCy1I73ISjsDTyF2jG5xr
 3RhqRjclmgYKWzXeAuO2u8giKhIBWfrpnFK7R9pIgqS88wRqHvMoTtV/ai6+sWNWCk9W
 05K28DrjxOQUz2LSMnj5Qnx2C6Bgvp1PtitxhgkEEMQdzSFKfl/xqxX+KpZEf3RM9tym
 SX/g==
X-Gm-Message-State: AOJu0YxvfQdgKNhbvEaequ2WaUOK4psLPjY+7J3/C/IHK3VTrM2ha7a4
 YG7ZsCn596Oqx3SsT155WvJbdORmfDaVVnlfVEHGTWbGeDyXh8VsEl6spCmY1DMlUkqZ9TtYSRI
 4a3Or7m7IVW3RDJ20znCRqeII14o=
X-Google-Smtp-Source: AGHT+IHV3Mn9wfUnC9s9Zcmqce5MgDcAtlc/teQZA8ITi+tD1RkPFzX138+5TuA99IcDNVC+GvC8pl4cPwRW3iLglfo=
X-Received: by 2002:a17:90a:12c9:b0:2bf:9370:5a55 with SMTP id
 98e67ed59e1d1-2c1dc5be130mr8755061a91.2.1717433133047; Mon, 03 Jun 2024
 09:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240528133515.307315-1-t.remmet@phytec.de>
In-Reply-To: <20240528133515.307315-1-t.remmet@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Jun 2024 13:45:21 -0300
Message-ID: <CAOMZO5CHOFp8BsVPs7d10NS_xQPaebFvqUEzpec+M+jZ7iYHBA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support all phyCORE-i.MX8MP RAM variants
To: Teresa Remmet <t.remmet@phytec.de>
Cc: u-boot@lists.denx.de, Yannic Moog <y.moog@phytec.de>,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, upstream@lists.phytec.de
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

On Tue, May 28, 2024 at 10:35=E2=80=AFAM Teresa Remmet <t.remmet@phytec.de>=
 wrote:
>
> Add support for several RAM sizes and speed grades for phyCORE-i.MX8MP.
>
> We have support with this series for:
> - 1GB 1.5GHz
> - 1GB 2GHz
> - 2GB 1.5GHz (was supported before)
> - 2GB 2GHz (was supported before)
> - 4GB 1.5GHz
> - 4GB 2GHz
> - 8GB 2GHz
>
> RAM size and speed grade is detected and set using EEPROM data on default=
.
> Alternative it is possible to set fix RAM size and speed over Kconfig.

Applied all to u-boot-imx/next, thanks.
