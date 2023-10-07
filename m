Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BE3E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3273C86EF1;
	Sat,  7 Oct 2023 22:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aZD/fi/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DCF863CF; Sat,  7 Oct 2023 22:38:01 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47E786DFE
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so722655766b.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711075; x=1697315875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YF/Zz4emXh4ZDoXdQ+QIYOFfruzzH+tndRZ/TYpRb80=;
 b=aZD/fi/Xq10aP1FvvejzXKbtP+Q6/OyIf5/TxM4dbh26HgSg/PPP7lSMckuuFmD9K7
 8rsJa3/jo6V0TsGzO9Z0B0o2G67i74otbsnkGHk7MmClEytshVGZDET4iNIfVPcLrCWO
 M9RQkPSBsMG7O/wBMMQOkmSLlATpOSCUxJJIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711075; x=1697315875;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YF/Zz4emXh4ZDoXdQ+QIYOFfruzzH+tndRZ/TYpRb80=;
 b=muuxhSk/T993zk55KcOLVSHDf+1CrA6blBaKrxx9QFE2rFFGMBMw9/196ZfdwGD5zW
 ehtoU0/PzmXLI2nsxOW5+qQNDLPKR4m3qQeTBNh3Spdeq9aAUAoO8A62JhhYg+uNVfbv
 DEC4STOpkrCWrwCllv/iRWAO10n/gdd4+fxx5sNGhvtAnCwvGwjwodYSRpjYhStSvbeC
 p8t+8XFPaNuKMz7nYryiapWeKRwY5kcnqMgmb3+aiEgoCV/3Yc8ScuGJbhXvNoXcFsPa
 fLJuY/bBlzIcuMMO9Gf7LVhSOl5SKuocGXv3i0Q3Oo+2PLAhFHyUB/pa7WpxeMbbuRJU
 dKoA==
X-Gm-Message-State: AOJu0YxPt7lMkojDxvxqIdd9oLnKgQ+B6rReYINS4NGkEa0PZWSYrD5F
 iLVLQ8V5IJ8S3MOz2pZzE0A3UvnrxxefeFSxbCRuNQ==
X-Google-Smtp-Source: AGHT+IFakyC31UhT3BPX4imIzsNZXZK4LUC8nXKI1bKzv7j0jOqsvLH4TDbmW4F9GQ9VilyUenAl5VbiTOIBJE+TSww=
X-Received: by 2002:a17:907:1c1e:b0:9a5:7dec:fab9 with SMTP id
 nc30-20020a1709071c1e00b009a57decfab9mr7116821ejc.9.1696711075345; Sat, 07
 Oct 2023 13:37:55 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:54 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3oE_iFqrsenJ-q4Ha0N0Q1CicCc8WN7RYzLZhYZ-cSmQ@mail.gmail.com>
References: <CAPnjgZ3oE_iFqrsenJ-q4Ha0N0Q1CicCc8WN7RYzLZhYZ-cSmQ@mail.gmail.com>
 <20230923194424.1739224-13-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:54 -0700
X-Google-Sender-Auth: gJPIGZu5yezZN5386W6_b6iRJJY
Message-ID: <CAPnjgZ25OP1_LPMLLL1+HuUU29xhajo2AQFv9DLUEBoRfNxFAA@mail.gmail.com>
Subject: Re: [PATCH v3 12/27] moveconfig: Correct non-snake variables names
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Correct some variable names that do not conform to snake case, with the
three-character minimum.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
