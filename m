Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B5AC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 19:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087AF80107;
	Thu, 15 May 2025 21:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzoOxe3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7922B8059D; Thu, 15 May 2025 21:45:42 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B2B80050
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 21:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-327ff195303so8090881fa.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747338340; x=1747943140; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTallaCzxPgQA+zdeofjk624OOytWrM0rVf+KKkBtl0=;
 b=OzoOxe3Nc94rec+z7fhqg0+8op9sSkzWCf9lArsC5oT+hjrQru03TNxKiZbu+w6mwm
 4QhCEJvsqlpP9i+0Sf0vt31FNny9R5d+Y6pU+btikRyCwiaEG2t2DvuH5HBDrKeo3+cn
 TBXZMP4Q9+J1jx0t3bnL7B2OOfXkwMDDjHJvVV9gzg/fIlRyZU19bDzUqjhsLywi3oIL
 dwZyxL6gmRwFL7bHEnbWxGyZed0qP0n3eckVp4fKYWF8Sci3lGRgKCZfAbGBALxE3X3E
 57B+uR2b91Ho1VO537awD3SYp1mrNx5+jhB4ZOCMiJeThPvM2tlj385k5H264NehY96a
 +Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747338340; x=1747943140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTallaCzxPgQA+zdeofjk624OOytWrM0rVf+KKkBtl0=;
 b=ao8PjZ2Pm7zPBW/pf60UefTe+IoKLfVjUe4GfUoYxaHO6zxN6n8mjQnXayFIFvqaHk
 fqO/2LFBT1+m01XizQWqg1D9/jsz26EmDEJJI8og3C/YhsfcbmzccTgSKwkrn4bb27x9
 8SuizfvvwMUZhOvaw6Smr8jjetk4ssgr9aL3tcln2/Z945vlbdGk1nBOzDHkoRCU14Cq
 0ZeiI4YzK96Laq/l7QlTEm9T9CCefSW2tlyknRLwOdwFMs/rX145AH7vOwPfJDyC/iHY
 aqf061ozRgGY5/n9vAuaaEiDc9N13TQaeQ9xtrmOjT+TdvThlrGKDiYTP3oVck01PaV5
 hNUw==
X-Gm-Message-State: AOJu0Yw82pW88tSqOP8tDz1J5vqmIYlGj1LUFscWiZnr7npkaIogAH1+
 2G0e4VJqUsHtxxr1rLVaTSNdkvASolnXxzFJKc3gKNHL+gVNpiXT/aXjY+ZD1E4ZiOHRM3rqMpv
 /RD3LloxEPHrfIBQHX9sGxS4qrDxYyHQ=
X-Gm-Gg: ASbGncu6sf8gQDPZZhYH7Qr1EM/GNvFHIh9W7JUm2SP8DukGNDaxIpWMyGJPQTcTP+1
 0P2va6wkYL++GjwL8A+tcfX1hmmzDFxnCzlLix66doAinAriRE/DvWCxt3E1Nj/R80BU9Bh4FQv
 jXHXknvtAH9eu4HsvWKCo6SOsOltfitdGmMdAub/GURxkZftnuh8VPLEF/TqVrSOd1PEWq8YPXo
 w==
X-Google-Smtp-Source: AGHT+IEGHLQluqENRsu9+b4uHhH8hyvCL7LM5KxU7HH1ulycPnsSLjl1UxjbWnn6bD9Djxl0bBZPh09vjPmGi+aXcxQ=
X-Received: by 2002:a2e:a98e:0:b0:30c:1d:b147 with SMTP id
 38308e7fff4ca-3280772b051mr3755261fa.19.1747338339568; 
 Thu, 15 May 2025 12:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 May 2025 16:45:27 -0300
X-Gm-Features: AX0GCFtetF0HrfAgh8EjnkQpYRbO_7GNszuVL81BKa-Op-6OdENyIsDX2MUFEV0
Message-ID: <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com, 
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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

On Thu, May 15, 2025 at 10:12=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The commit dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
> breaks the booting of the BSH SMM S2 board.
> Restore proper booting of the board even in case of failure of either
> clk_get_bulk() or clk_enable_bulk().

We need a better understanding of why the boot fails.

Does the failure come from clk_get_bulk() or clk_enable_bulk()?

Please investigate.
