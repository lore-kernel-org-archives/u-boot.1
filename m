Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB8CE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B64805CD;
	Fri, 20 Dec 2024 05:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eoTZ9qsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C74805D7; Fri, 20 Dec 2024 05:06:35 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACEE8037B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso299947666b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667592; x=1735272392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bKWM0Jdm9LsxH1+gt3VWkkVCXX063vvnljwZc/Hu1ow=;
 b=eoTZ9qsN5IO6/m8lszD8eKBUlbTUgqLi/RJEvF3Tf0LYveL6MlHbQT+98C3R4A6SB7
 l+zjgEt3ZBAjLQUZ14nA9HPGClbHSX3JCshqYz6pgl9p1cy6nKeMrQjCMw1taZN5V8nw
 ORK6lUqY9myw9GezhByKWOCeDj1W2buF/BvKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667592; x=1735272392;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKWM0Jdm9LsxH1+gt3VWkkVCXX063vvnljwZc/Hu1ow=;
 b=scJMX2Ydu/me8lOmY0Vg1QfQlM1VXEzsmAmSw/SB/0fS+4rMcb2FmImNW1qA4U1Tkr
 anibAELwufUZz3s6ukggzrJMRcTnyE7c/PRRf6PzezbuCErBjWNooBz/X73HIB/RB6km
 x+P3vZbpG0DPGV6grRzXAB+GJy+XTdbDidSV0LPtIzRbmWrW9MvskpKw1KkWqybeVm41
 UH189AAyYR93dBdtmjk7raWYi8OpIogGsu5SuJkdUXG1et4Wi4CAPilHFvH/A5a8t0ek
 /aHte1b25oyrv59aUISlsCBTQp4DjEf8rUuYsfrpxlRwZJl9HiV5lFLw0WUQKQUZgwMH
 5NAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm44B1coCybKCz4Tm4wSyXPNrlnCjevaSytb8VmLjqHfnuAGyij9nUN+u/9wV086FkMDCnuRE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz15Ub/qIrDguuKfUz5oUe1cgFNoO+dp27/CG5OtDFwTKXVzSG
 7qvzftpl9938AATm0km78y1oAlFO7LqAqVGZIS9w0u3xXKx5tLzm414/b9LvQOUQ54YYujDmuqt
 oYYgRFBW09rwvdxDBIr1WJ1TGe2qiizFirvnISmCX3tdEqiQ=
X-Gm-Gg: ASbGncsQ/n801G/hggOI34McUyK+8s6DILGkATk0tC/KDQO3uXOvjaUT9iEG0iNSBrg
 tEOkeNa/OC6533HmFPYxrCjD150Tq9Qq6H8ExuTU=
X-Google-Smtp-Source: AGHT+IFkx2sxpRc5P5VuQL7hkDHMzmzyKufjnET2M3cPJNGnc348r0N4Gvsd3aA/L1iKwNPQ2Z9JGC/dVFuZ305GC2I=
X-Received: by 2002:a17:907:9621:b0:aa6:6f92:74b1 with SMTP id
 a640c23a62f3a-aac2ad7fa01mr93888466b.13.1734667592584; Thu, 19 Dec 2024
 20:06:32 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:30 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-13-sjg@chromium.org>
References: <20241206023626.2456858-13-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:30 -0800
X-Google-Sender-Auth: 4ze1y68Sk_41JnYSi0WfGaAk3HM
Message-ID: <CAFLszTg-0s_D4zqvzgD_ihAoXjvFVijsYqtt+XBOzKeD9P78Xg@mail.gmail.com>
Subject: Re: [PATCH v3 12/46] boot: Pass just the FDT argument to
 label_process_fdt()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
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

Since this function only adjusts one element of the bootm command, pass
just that. This will make it easier to refactor things to remove the
bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/pxe_utils.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Applied to sjg/master, thanks!
