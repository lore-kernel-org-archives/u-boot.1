Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA0AC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9810F405A5;
	Mon, 20 Jul 2026 08:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlKCsuC622qy; Mon, 20 Jul 2026 08:35:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CC7E4059A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784536545;
	bh=eMvmMIgH6II/eIaUo+EPp8VbxO06kOPl2E0PJOnzFF8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sRNeCCzIosBF2L1PCk9MKDcX/3DnoZGTTRJbbWyeUYNPm9R9CVUPcbUzT7ZmRNKxs
	 gMy5AIK4gU98HRJ0hGO0u3pmkPXqinD6AOEYW/0ys3LNcp4G8my0v1MoMk7ULdiye/
	 f6+n/WL0LXDi9uEgC078cg7Q49ep92H8gr34kHuImLYosZ6F3fTJkd+YKKL04PhyUf
	 dLhIoR7EoLf8fRK6GlC2ot13G4E/Sl6diADNX+BCzrzLkynMX74AMFac0PdnN7vWQJ
	 5/UxwSuc4Yj/3HMSn9aX1pIag24SBQ0WqAdf/tBN+Qo6XMJvV/AGlbG5ll0v6cxag0
	 KgMETXs1b+xCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CC7E4059A;
	Mon, 20 Jul 2026 08:35:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F27B0282
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F010A4059F
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ieqa94tdueJG for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 08:35:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C4AE840597
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4AE840597
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4AE840597
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:35:42 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-51c0ecfaee7so89377541cf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 01:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536541; cv=none;
 d=google.com; s=arc-20260327;
 b=VpmEIM3f9MeQakwQldVgpo0yPOwWdVJrmKQWeQ4Qf/2FCZ54teBXUTQdqYkzput7YJ
 lJE9mFKjoATJTwr+iDlXUMyqL4yXwfT8NXWcGNuFR8/nsO3JMbQUUlwABw832HC793ic
 1pHZQdm6nSl0YA566+VS1cNEUov773lLMR05LgFL0xIIFFFREToLS6ZamKSah+8RTW6O
 Fqtgd61fShrnbIcwxsC/rGiHIs7SRglWEpU63BNFWnSlGfH44i7T6cNlWMyGFwlo+8Ao
 +na9u9nNL6I3S7TR/MCKivzX9toxtbOW1boh1lc5fz21M2ZsG4hBXa1q7Qgech8oI4uJ
 Q2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eMvmMIgH6II/eIaUo+EPp8VbxO06kOPl2E0PJOnzFF8=;
 fh=FJNocD74GKmrEzZRCbawol6icJDV3ilG/7+czrr1PBo=;
 b=COUvVwMS15VHF8t5enM5lNocKBHrSHsJB7UyDNU8lLQhcH+xyZobucGEElI1b+/NBk
 aLcYzcmwEIFu+rY5eoutLKNkOxTNj6oS3VD1XHuKVDpf1eSQxIHFC5xAhg1r2HtjSvWj
 s2EVXTj00VtWx02B8jSKsupwS6npjmcBNgAtAh5LXv8MzKLixmflIdAzFH91mg68mf6X
 LAFztMwdJiCj+4qBx7VaNCBQJnyeLHLElj5bRze+pr6Mp5KjFvnSbHAUbLjwYfreTnVE
 EhcvPesaxMWPJOV/tETb6VOF10QH0McWXUDnk9WN9ZAARGoQaW987s9JWXURy9pCQf1n
 LWzw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536541; x=1785141341;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eMvmMIgH6II/eIaUo+EPp8VbxO06kOPl2E0PJOnzFF8=;
 b=hH65nRJVHdeaVFAgJ3Ol4u69YfM2MPPhcxdfPkRVH+Ze+I4Chk8rsW538O40gLyVhw
 MsOTnuMw+jL77cCc1j7Z3yWdCinIP8xpM7fTbtNdiXrWBkXXx+koz3wWJqvgxQmlYI6s
 NwqJfrjRRIY/T8tY1yD8ULLj9wp0dYR2BSq+ahh+ZEdPJcpbBSwMd0h4bAl67PlKrVQT
 RLNS0Xd9sqe2ezUWBjjYS+OJVijOump8Oo077LjQT4tcl4d2yP0HIUhXBOqZX6Be/Q4i
 cClRkV31AL/ueX2J8Dv8FG1BcGQNUpd7D954w7qschI+m27W2spOD22gUv1QHlBxahDf
 2RNg==
X-Gm-Message-State: AOJu0YxWu85n7JE6UMZuSHz/RF9urq7WnS4jkUoH9bfkQeV19E9dJhiK
 h/oHSHaUsnWSzZ7R9pV1Cd9TqAwYOZadAfokQR1JON/ACUcYh9sYURMNE6DZokQsovm65zY0ZTm
 fRqaa/F/8XZD5trzGOwHB8lQUwdWxnN4=
X-Gm-Gg: AfdE7clFMt/02x5k2h95qLPyzzNdSC8xjZqWm8stul86qniFYr9+aNGh6AIAH4cuaFo
 NXD9V2ipb4amCnx1WXFHb/xL2R5QY42H+3PNX5c+SFWOzE8O+8VEIVByw4SmelbAXGYmyT3SiiC
 +KF388sG533CFENdC+DEmibDiVA6zVSMbptVpVfubXFiUIno6MiNz0ZaFhVw2Neq5YJfCXt6F9Y
 ipbs1t9vctoJkab2Ay1zjibbtab+Mn4AWFE7tXF/m7Ii/wrnPBtTwvFqlWbkHE/KILplNuhDMiV
 IgzC5Qy+Z82NSVtVxZZWXWp+iRYbW4UEllcqJPl19sRh1efmHyY18A0PAYeekKPJ3UHb0uhVqFT
 LJhAtFVQ/cPijD0YqgVea1p0735y4hwy6EfrdSDL+NicjlzASumM1xz5q
X-Received: by 2002:a05:622a:4188:b0:516:d781:589a with SMTP id
 d75a77b69052e-5213c201617mr125345921cf.22.1784536541369; Mon, 20 Jul 2026
 01:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-3-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-3-20ec1c334dd2@linaro.org>
Date: Mon, 20 Jul 2026 09:35:28 +0100
X-Gm-Features: AUfX_mx49182u3JAUpcYkcvNhWyQzlcUapiueXfhLBn93hn5kKx81AD9SX1V_qA
Message-ID: <CALeDE9MdxKmGbkWstnNxnA5jRQ0rkmYjQbsxf_sRXeAL+yHAew@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] MAINTAINERS/README: Migrate mailing-list to
 lists.u-boot-project.org
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Heiko Stuebner <heiko@sntech.de>, David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784536541; x=1785141341;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eMvmMIgH6II/eIaUo+EPp8VbxO06kOPl2E0PJOnzFF8=;
 b=P25MnFw36RDr/SEw/dOGfYiH0hiIU24yrCjaSV74c65SUr5irNpt7bMqx0DhQQz12t
 m6dNy3yWNejX0jzRyBhS0XMb1lYKzVOY5X90cQ0z9UyDO9n/tPjr1NlvXf1t9kjlDO/8
 fgmWVskc1Ln+CMizSlyPJMa67ZAJlP5nTPpc943yZbDpCjtIkgjfoHCTYp8AUvtrPSk4
 TRiE4rz8H3cvQ1EfDG5jYuPr0AnwCB0KBCzbzIuJLKAddWzbDc6jecoHmvdSY+ZTuRhi
 hGMoB3P5fG8TtkzvBNuVSF7GQxeRNzPOxCK+pNXGkICxejxLptSUrFtzelJHpZahxePQ
 jBOA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=P25MnFw3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>
Message-ID: <20260720083528.jbTCDuPgDE70BjzBci2QtsP-5mAFYp87mgDjkuEYy3o@z>

On Mon, 20 Jul 2026 at 09:23, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> domain, so update all references of list.denx.de to the new
> domain in the main README and MAINTAINERS files.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  MAINTAINERS                   | 2 +-
>  README                        | 4 ++--
>  tools/u_boot_pylib/gitutil.py | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5b2a2e373c..177bc1fdc07 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2022,7 +2022,7 @@ F:        test/py/tests/test_xxd/
>
>  THE REST
>  M:     Tom Rini <trini@konsulko.com>
> -L:     u-boot@lists.denx.de
> +L:     u-boot@lists.u-boot-project.org
>  Q:     http://patchwork.ozlabs.org/project/uboot/list/
>  S:     Maintained
>  T:     git https://source.denx.de/u-boot/u-boot.git
> diff --git a/README b/README
> index 472cf37d9cc..51e98d0f4cf 100644
> --- a/README
> +++ b/README
> @@ -45,9 +45,9 @@ Where to get help:
>
>  In case you have questions about, problems with or contributions for
>  U-Boot, you should send a message to the U-Boot mailing list at
> -<u-boot@lists.denx.de>. There is also an archive of previous traffic
> +<u-boot@lists.u-boot-project.org>. There is also an archive of previous traffic
>  on the mailing list - please search the archive before asking FAQ's.
> -Please see https://lists.denx.de/pipermail/u-boot and
> +Please see https://lists.u-boot-project.org/pipermail/u-boot and
>  https://marc.info/?l=u-boot

Should we also add a reference to https://lore.kernel.org/u-boot/ here?

>  Where to get source code:
> diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
> index 34b4dbb4839..59688aa7147 100644
> --- a/tools/u_boot_pylib/gitutil.py
> +++ b/tools/u_boot_pylib/gitutil.py
> @@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
>                    "Please add something like this to a commit\n"
>                    "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
>                    "Or do something like this\n"
> -                  "git config sendemail.to u-boot@lists.denx.de")
> +                  "git config sendemail.to u-boot@lists.u-boot-project.org")
>              return None
>      cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
>                            alias, '--cc', warn_on_error)
>
> --
> 2.34.1
>
