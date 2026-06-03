Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8EFCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 05:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C987840ED;
	Wed,  3 Jun 2026 07:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RRXrq8I8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185BE84855; Wed,  3 Jun 2026 07:07:02 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BFBD83EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 07:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso446800266b.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 22:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780463216; cv=none;
 d=google.com; s=arc-20240605;
 b=Ay0OPdlJHFeNpSP++9GX7WS+HuqQIC+5PYtb17hDq0BsY7fMjyvfNw/3CoaCOJ9WkN
 dcWqOUoZc0SvaRdU8uBNEiqto/pRaAjR5YAWUwe/BYeZnOyP/A5DdQeFQh+LPiIinMQn
 EYMN2ZVBwWYE1eeeDMIixOj6wbQV73MQDiR1Cy6RPX8fk4b4qhSebhHR2jpiijrH2dsV
 skgcwudZapcSOSxHrExmaFng/bjX7+7BpQ3hmq1gjscJY/0cg6seLMUG9CKvQh1dOpf/
 1gT3lcp1dRrQb4Vjh1mYUExpexUwI+0g2437UAbbOHk+LvjAlGITzoXGUU7jsy4caVzu
 HnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=70R7lZCG+JLym9pkHFvMxxOqb9WW5QL44gHgd84cWjM=;
 fh=GQyKwPRr8dOXk65gAXuiKSXcuQM8h6Aog4njpiF9nLE=;
 b=X3xR49tLkfLe2/zbYaR5HDGiPCRKJQ3ETOjfJjj/xKMrQW//xHqrEBUuGodFcXRJvg
 ftIEf69ZD+LYG6Y0c9XpL1Q54P79xFDYM5wDyVdcI+2W9HKsRdBSJZkgUTM9rKhpS6ix
 A67gEeygyEnQsXhB7yUrqEu1Vb/7EsnpHTm4YakoVKpIn/1xqPJ1baKo/RQzIfNzF6z4
 Rm8lIhwJ7Yoq/GB12MoPk39/hYt9Nt1GwYlw3fv3NuhcBAFzspcwOepV3HKH7VGbhP+P
 VXwXYKuoa8WzAfTE7iGFAVqaZwEiM6fY4Kgs3Mt9q11Zi0ntygooghpEhiYiRlL9VO9k
 95QA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780463216; x=1781068016; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=70R7lZCG+JLym9pkHFvMxxOqb9WW5QL44gHgd84cWjM=;
 b=RRXrq8I8haYPwyNmeT2xl801tBvao8nq4S06YXrClZpE6bAsLVhX2FInCypB/w/ftR
 i0tg8jU/HtGiDHSVZq/aUPiTRNMw5EJGsMLOjKNOsztOOiZboaZtoGJ7/cvwt7PLhgir
 WiIBcTO8dI9w0bqw8q/j3u3w3xsNgzgun2eA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780463216; x=1781068016;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70R7lZCG+JLym9pkHFvMxxOqb9WW5QL44gHgd84cWjM=;
 b=PNHswuA6YrpGOdS3h627+aitX4QZK61qeOr5bsYjWOzxoOwrj9XzYDXG+tC53MHiS7
 ArYmKMFMsCCA0nDDShaCDwzA7Sqt9b2sRaRxj4llcDQfconNLNxmlDbQ019aJBj0WhRY
 nk9akYYuZ2nG/xQbts+X40LIvMf5Ee0NONBtIwEEkVV8sys7Er7hXT7UNjGuulTzc9RD
 P0I3piLSfFPd27f+uWjrUKdW1xEtsOVmvKwpdc/GU/oEI9CoSMbvocx/NMuYPdSr+2uF
 OnQ03ii5EGU/7zFoZ+YZUowy7eMO4kPW0oZ8wqOgKOqD7svx/4pHYQP54PJSrT8/Ht4D
 5EUQ==
X-Gm-Message-State: AOJu0YwlUfHP/80HVVKU6Xk76BP9qlZbKUfH2g6vCVevf5G+T0erj6k2
 tqdk3RQax4ZkM0Wu3fBeL4GtKprr0AblgSy7rzPj9nKJ1/60dYyvblder3seSGw2iJCmPOEiW2k
 CDFb+0XBEvt+H3wruRNh6t76sck9e93eUquaHq0q57cLnv3WN+GRzeA==
X-Gm-Gg: Acq92OE3Y1IB9MnW+pmcUhh8eOvBkbhGw8zvyGjN/EFIpgNBenuB2XgCSbh52V240mA
 WN05yV2f4oTRdSzftVhKnZs5hTJbfkMapeqZmSxjZusgwojrqXeX947Iomdz55Fbc7HYbnwf40b
 YRJLp++SaLuris27eb9kbUOLzdqonOkOdo797yhMaJ4FLzE7B20K4T+vy+1EO8dL+j/Nlr+8FGR
 G9eME5Kqk7488rollC89RAyMniOEDxO/ORrBPguix92lMWiAQeZEnw5AeA8qiBu/NHz0SsRkEhN
 CRVPO0611sgDmDC7
X-Received: by 2002:a17:906:4597:b0:bed:62c1:f6 with SMTP id
 a640c23a62f3a-bf0a912483amr47555666b.16.1780463216304; Tue, 02 Jun 2026
 22:06:56 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jun 2026 23:06:00 -0600
X-Gm-Features: AVHnY4ITBtZkFf1jrlLfA657isv0en-A4jsP62yYQWi4N1w3VctPc-7GYOtiWGY
Message-ID: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
Subject: U-Boot Concept Tree Proposal
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear U-Boot Contributors,

I would like to introduce the U-Boot Concept tree along with a few thoughts
on its role in U-Boot.

By way of background, I have been a contributor for about 15 years - around
10k commits and countless reviews. I have introduced many innovations into
the project: e.g. sandbox, device tree, C test infrastructure, Binman,
standard boot. Of course I could not have done any of this without the
U-Boot community (nor would there be any point).

As the U-Boot project has matured, the demands for mainline stability and
rigorous review have created a natural friction for landing complex,
large-scale feature and refactoring series at the necessary pace. This
structural reality, which has slowed the adoption of ambitious efforts like
bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the Concept
tree is designed to alleviate.

I strongly believe that projects must evolve in order to stay relevant in
the long term. This includes code-refactoring, new features and subsystems,
along with migration of old code to use them.  A look back at the U-Boot of
2010 shows how far the project has come. I don't think anyone would still
be using U-Boot if it had not evolved.

I have set up a 'Concept' tree, a possible future for U-Boot, as a way to
regain the old pace of innovation. This environment is a proving ground for
new features where we maintain a lower bar for risk tolerance and
completeness. We will accept partial and speculative features, provided the
underlying code remains robust and of high quality, with the shared
understanding that features may be dropped if they do not prove beneficial.

Another difference is AI. I believe that AI is the next step on from
compilers, which also took a long time to produce good code and find
acceptance. The Concept tree welcomes (and encourages) high-quality AI
contributions and reviews. It accepts PRs and allows reviews on PRs or the
mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) so
sets a high bar for testing. It uses a separate Gitlab instance for now and
of course uses a separate mailing list and Patchwork project to avoid
cluttering the main list. Concept runs an AI-powered cherry-picker so that
it keeps up with mainline. In no sense is it operated as a fork.

Once features are landed and functional in Concept I hope that many will
find their way to mainline, although inevitably some rework will be needed.

I recognise that introducing a new 'Concept' tree might initially cause
confusion or concern. This is an invitation to work together to define its
role. I welcome all feedback - positive or negative - here on the mailing
list, privately, or on irc. Let=E2=80=99s discuss how this initiative can h=
elp
U-Boot remain the defining firmware for the 2030s.

[1]
https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3DieT2oaHfgLf3=
_nC+xXA9g@mail.gmail.com/

Concept tree:
                       :
                       ::
                     ...:::.
                 ::  :. -
           .   ::::::-  - ::. ..
          .:: .:      -=3D=3D  =3D.:.
        ::.- ::::. ::. :=3D:. ::::
  ::. ::   =3D..  :.-::: =3D:
    .:-:-. -.::  ::=3D-:=3D:
  ::::::=3D.  -.::   =3D=3D=3D:       ::.
    ::.:::=3D::=3D:   -=3D=3D=3D:--=3D=3D-::--::
      :.    :-=3D-.:=3D=3D:.   .:  ::
               =3D=3D=3D:       ::  :
               =3D=3D:
               =3D=3D
              :=3D=3D
              -=3D=3D:
              -+=3D:
              =3D++=3D.
             .-=3D=3D=3D:
