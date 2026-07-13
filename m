Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3183AC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A2984A3C;
	Mon, 13 Jul 2026 02:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TxOi1p2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1FE84A49; Mon, 13 Jul 2026 02:18:56 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7680584A3A
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so4228503a12.1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901934; cv=none;
 d=google.com; s=arc-20260327;
 b=FRuTwfHkULVOBzZ8sWFk9OX8SjIPpZVzDqCdQdtREK/IAKtitwD5q4cd3yJ+sqyuPo
 vMB26A21DQi4USEBs2XJDBGVrtbRNo22poKaPaGvN95HEXJwQ2dZSg6/fUlQcdhwC5md
 LeWbv/A3b1D6L6bRswgqnv3jbdZCW2XTMxgv5/qXh4f4BVO/fYtc62m4grk3+vdAuGqn
 cEzvP5ejgEFVusp3GFF/Dsq+IVTIu0dJcb+RlhCmUCT9MnOO2Ug7OMcEafPe7ExvLwlQ
 KpVV2s7AOg9hK2QZUUKOxN445LAbr5QxKHAEH6rIVQeZTsdCfgcbYq3hV5+rcRE2PmBk
 VHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+4Q0rhNeHUOKikBLeTKt4Wynv097cSeDd9ai2PumY+Q=;
 fh=EEQIRgfuMtwQmXdjfdH5RZ1j5rBzQhaEFZ9mu3M+W/M=;
 b=IGdhXX0pg4rkzgaux5CA3yNFBFl5r09UbYOHHdKNQLetK+FOTMIioUoOUAzkJYCO8e
 eCPmKI3wQFkX+PL0DsUpCw8C3oBFD5QGM8VbeUzaiTTgqMZzfqy9rVM2FnLEbcPG7eV1
 CARtzvZZe5ZCYglwi4mId//YTuDyeJnrp/uMQSDDnvNBPHY5mxvJBzxJ+6VuiphuuiFd
 081YhiW8y5nNjUo76ABIKXF8T2DTpTDjoORIHfN/NVDE2d5o2fDkDkXj5YVHH9dfZVy4
 /9C7i/WQc7+p0sM9dt+6Nd1kmSstXOfLwSSTBDTXwPuvbbgYdZJnlzK7k9KQ1EkM71HN
 5pcw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901934; x=1784506734; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+4Q0rhNeHUOKikBLeTKt4Wynv097cSeDd9ai2PumY+Q=;
 b=TxOi1p2CFerv5uDKCMnnxmHkr+YauwMgG68buxKGMoRoczloKPuxeeLnSwzYWuPEgL
 DcHKIOPArj05qPS6IXpUoMjw9Aprqk1B1c1CrXshoC3xqsewgm/QPiU//WUxx5Vijx5v
 BZzJ9B0mn88slnqZxjhDkz54NYxHeS06i/2as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901934; x=1784506734;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+4Q0rhNeHUOKikBLeTKt4Wynv097cSeDd9ai2PumY+Q=;
 b=S5A0R7eKJPqaBLHg0oDWb0W5XvenzhtbAavQ6RntaPLOXmOVEJ5OOVZpbWKcchkCmu
 Pa5a7ZkkdudB2hoP9CY930AerJucAi80AwKDsWQzajAU9tx/+5CBqvWn03GogeSHolpe
 lEgPwc9TGTBfIGWk2CeMqkY769D2magdrcEEA2TcgCgTUspmSbDW5SeI7PWa/pnQkdp0
 AFZYiSmnuKZDq6vz46EWsvZUqNHDeMqYnKObBRVUIg6f7Rv8QOz+Sc12sQNkXenGOgWr
 7ucns0Bc5wxJ7SgLAuf4fvg3YE0Tqwrp0HHB0RIxSvga9CoJi6fcl5PtesdoPGxtq9kJ
 CAAw==
X-Gm-Message-State: AOJu0YzQw1EVIpXfTMsWCGqqaWpSidPPtidOFuBj2sXDIjtZ7vXiv6sx
 aCY5ebkbIfe7+Rj7IcFd1y4316fp6LVCdK77yUz/3htKT3cDPNyRj+AQKuf7NjPI+TXcr6Bqo1B
 EFqY/s4qn0DLpR8r0xGryFQoi+J55VTmHZ1m9XlLw
X-Gm-Gg: AfdE7ck8gIpNL5dwQ7Hb5J50A+XfoBE3u0wsm5cVBgjIdLUyzMK4Bh5zaWwEtisGkEE
 1Z9c9MFx8In0aSH7aGg/w3IncmRe/DZ0u57RdYldQ8JsjPBNcviXsNwLqafDIeKVS+LbjRiaIf/
 TrWYOIJ+ryE6lPsA26Tb79uxjbRFCYgEnB1NAbBnTllPj7JHC7yXNR9MqoIcxu2laMmOhK9xUEQ
 5+dBAXoPoyBVjCJx89PLc+I3DofxlqmtHTPwKnlebmJGkm4yNZayd8tGIk6HYS5xAamPhU=
X-Received: by 2002:a05:6402:3513:b0:699:ed7e:3574 with SMTP id
 4fb4d7f45d1cf-69c5f10548fmr3100250a12.20.1783901933909; Sun, 12 Jul 2026
 17:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
 <20260708-other-contrib-v1-1-8b3bd4d265ef@cherry.de>
In-Reply-To: <20260708-other-contrib-v1-1-8b3bd4d265ef@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:18:41 -0600
X-Gm-Features: AUfX_mx48HxVA4ka5Zbt9roQe5LdEIXM7vgkK1M6KJN_2bWkvwgd0bPNsMalRQU
Message-ID: <CAFLszTi9Oi6zfDzP1AV1FHzcnpCmUJZY8RBaAcHWwKqxPuV5kw@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: CONTRIBUTE: use internal link instead of
 hardcoded external URL
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tony Dinh <mibodhi@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-07-08T17:21:12, Quentin Schulz <foss+uboot@0leil.net> wrote:
> doc: CONTRIBUTE: use internal link instead of hardcoded external URL
>
> This way we don't need to make sure this link still points to something
> that exists, as Sphinx will enforce it at build time. It also has the
> added benefit that if someone builds the docs they will point at their
> docs (though that is debatable whether that's useful, but at least you
> stay on the same website).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> doc/CONTRIBUTE.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
