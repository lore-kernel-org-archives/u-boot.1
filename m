Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD7FCD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A0284926;
	Wed, 27 May 2026 03:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DRMdAS9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B308491D; Wed, 27 May 2026 03:17:29 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 839F984869
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd0209f25c1so1720840666b.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844647; cv=none;
 d=google.com; s=arc-20240605;
 b=PzC/nxd9NwyeKJ5RTnHNTWYoG2/1iqzBq/vaa7/oYIX/WTZKxa1PRsPMp+g63Qzg+1
 h4oHJJ48LObF19QEnzIp+rma6o57vhCUabIna/nuhkFXK46GmblrTgBs/Mcqu8TH3fhM
 Y69k5yRzh9ykDlSbqLmq6h/u+8W22Zqz9jObOdvDqW9fCfrx5XXn6n1YJQ2zHPUC5t4P
 U5tDNoYVOWPovltSUT0k3VjETkf/hWpqPyiMexP8a6u6Jdwqn+Y2WLawO4RyukcL14iu
 722GwvvW4LxgVBzp+Rwi2TY/m7RcVjA14nGEerm5CUJ7u+mC5rkDie+gXcnez31GH2Gr
 2KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZxrGn8VA3/r4VsCOZ86M2gV4E3WjarJvlvFrD1l3Xr4=;
 fh=7HzJ9BBBx4iZa4XdRLXOksY74UmWuqL7h1CjcfaRqlM=;
 b=BIEXBpYcyQx6Npmi2uRt8JQWSlpmJ/WPmJMoB7lXzjjZ8LuAnNurUEgOr2mFhcoxc0
 e+1ZrO9WK7ZOTaX7XZxo77LU0yiXCzw+t7eqBlwIoooUi7takmm2h4ZLWALPOl2+IAuI
 mGMZeJFgOl07+YGZOXKONo2nPIQgqm1yu8CnY5U3fa3R7ExUakzJXUFPXbzg34YieDwx
 fF1xJkoPiPkiMyLgWKjNhY54b28q7Q4wxBHWYk92reGSgrDmfOhY1FzBw7a8bfrNRDoj
 glK97nvZteh62ytsQ8AsuhAnM+55k/+EaC6HNNPDgyv6SNAk7od/TGLF6McDb0HvtRc9
 gr2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844647; x=1780449447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxrGn8VA3/r4VsCOZ86M2gV4E3WjarJvlvFrD1l3Xr4=;
 b=DRMdAS9vSgYfOSbsbSGWGg3ocoOlGzJgr1hD7MN/EuaYYQL3zKdegy99JULHVktuxO
 J3xsn7ZJtP5aMDsv4U/Y4Ov06Gm9ayG5Q90FJ7DjvvemZVGXCoIzQ6JG4r8a+nK/s3Vi
 /ctdtl72yfqFMkpbnz/AacwPqAcehcKjIhvuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844647; x=1780449447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxrGn8VA3/r4VsCOZ86M2gV4E3WjarJvlvFrD1l3Xr4=;
 b=HLupNaTxVaGah6mfid/koHYvCW4iAkxkvvcvL9t1jU79P5VZ5fupjbWIf+S/P2nuAz
 u8M1GxKjmCRqmVMUoDcaiMKwzKh05KGnh2r6TNPpnwaJi2sfeboa5ZxAuBOQ5JxHRfcj
 BJsNG6V981uezVCZORR8bFU3Lo+ZzbbXieu02+gOZws7/V65KKUQCrusEbHOXjn286KY
 7b8QQOGExckHt8tr1b1gsbI4BkXcAvN2nm2AIme0MthAchVY7EKDDM3X2aQgf6Js6l5z
 9/vLBPTsWf+l+Q967iHGnlwsdJ4WvNz0ldtDjl5vic7IHNSIkLOHExgPd0oQMC1/LxrN
 98Ww==
X-Gm-Message-State: AOJu0YyBDZpQpf6+TOhgWfxmDNnhlhXP12ehupHVTQcS36PVyDWy65o+
 f4LyTylk1s/JywztAQJ3mtVnJdtBSx9oQNpxXh2gd2lA8hIH3ZiP4rvSFZuXnmxn81RxWhTcNMb
 RyZnM/6xKfS8itgzmvO1fAoBiRzuoxWkhlpxN7XtN
X-Gm-Gg: Acq92OEkvWfPFfAwRIcOxUTEoNkQDPQD0Fteo+ngXCEFPYyIcDiMbC+O+1zGg202z3e
 9M+23c6lKPAtwvgvfs7gZHHq9fGI/NvHAdcPX+SgWihHrztJ+Ye7yEvetDMfxdApN8udgmgs7iX
 Ge+gzdzvhZT8310ukuJlVL0NnqXpTJXE6K2L3uak+Lifi4pZQJuEMb1LFdKlfIN34wGC4pgMzb8
 P3bySAiIJAesookR9LPV9gfOfAeYSpZ5ZcB+/EATgmuRc+tmEv7XlWh9Orw7KFKpN33+b3vO+5S
 r9Fv7EIwKj/Tt2P3Q+QtlBrb3q4=
X-Received: by 2002:a17:907:3e0a:b0:bd8:f7f5:269f with SMTP id
 a640c23a62f3a-bdd282a7439mr1376265866b.6.1779844646990; Tue, 26 May 2026
 18:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-1-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-1-be3597b85b5e@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:17:10 -0500
X-Gm-Features: AVHnY4KTU6-n9BIKmcd7ndEz1TJbGirtXSNajuB6rNLsM8MV8RZkfoYeoLQYfME
Message-ID: <CAFLszTj2pOVzLNA_+qZS-j0_CLvjn1mN51sPz41=QSjnCMAr9A@mail.gmail.com>
Subject: Re: [PATCH 1/6] net: ethoc: Use dev_read_addr_index()
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
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

On 2026-05-26T07:25:09, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> net: ethoc: Use dev_read_addr_index()
>
> Use dev_read_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/net/ethoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
