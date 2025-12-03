Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB48D12D6A
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 20:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791C583BBE;
	Wed,  3 Dec 2025 21:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QcSTwo7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4E383BF1; Wed,  3 Dec 2025 21:32:45 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE3483B6C
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 21:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso130916a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 12:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764793962; x=1765398762; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmfGfCLC5RJCmZnbnDk6eb5rgh7nECb6THqfmaSkzZU=;
 b=QcSTwo7q1WyYx+JK5Sj7PnuS1TK2rKiEp6SZmqGDotYeBKe3KVgqrNU/WA+BCmH2+P
 yjOYOG6AH8KJjUJW6MlfrhpI2cOI6+GbSwRRMDu9bihPhWpx8x7EoeFZYqWGiNRlJ7ET
 7WWd23y+KhGM5Baj4ka820t6FTG0F4EsPjsYliF5XKGIdFVJm7r2oqvNTyKjjeVAQC3Q
 YNbkzlUpI9T8+Q5xIfcxeVHt4mCPgC5fwVE0AwjMmTC683VUNSgDoWXINurwgazodpqN
 38t9OHGELa0eU0oZ34lSX8RzZk3DFRyMF7qtdqGJaW3t8jVfNAeLLRpdwUSbCbQnxW4s
 SEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764793962; x=1765398762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmfGfCLC5RJCmZnbnDk6eb5rgh7nECb6THqfmaSkzZU=;
 b=U4RmO4h9iOny2z2zyvuLtUD1ZJM3IVFDky9K0oqPcs2mxOTmC7Lc5RLCqkl1wtTznx
 4k/yWlDOuBjhhOaFVXdgDOXZ0QqY09/hdFmpgojmO70rxXTMZ/pY/0FGbFTuv3qpDqdc
 tOB/XEiw4NSrLqEynjCOKPb2NLREyXomkhZpW9JH7TOERMLSdB9FmH+Zf4v9DwXNYQJc
 nRcY9nFzYYSvLpovAIoy44XaQEbr9yjIhy3NZl1mZG5IhcTAlN1Xw79uMK1pBdpbkOF4
 QYToH9ARlZ6BHi5trxgFuTB6+juE0QEQ5lKRCj5AYtKYZ6Mwi3IkHEcN7cGEHRxthhvz
 OirQ==
X-Gm-Message-State: AOJu0YxITM2bVeKowVl/ZLqOTc3sMjsD3u0D6jF7C5kx+21p1JeQfXnY
 C+GRYGOdJhFX1lvhP1RF4T9L/DsEY217lz8wF7fyguSXF1XiHZDZ/JqbyH+WILhws2eDgY8WaOE
 ixiTwR+SfJd7QMqgfZ9DO9Wpwd6C1PEnFhoKwhhAt5Q==
X-Gm-Gg: ASbGnct77COE6HkB5hXE2fT5LS7pSAvNzRh4QIlpyJXDekUJ+ejGKpZSpMb4XJOGSBk
 hxRhR794tfmWNpiIXZlIGAa/djQgAk24eh28DTwjRvCnkIGTVvAkXhXILNqKqbRQnU6TKKMyZvO
 tgJ0lSRxeBzGveamXnPsKNkMZxdLeat7dfwx6SUJtrlklVXh3NNkil+Lr0d9xyomi1WovuIbHlB
 wVQWmrgpmiAKvNkkHaqegt/jkhZy6gyCPTeNSYQ9ZqF+iSCYjjs8aW81/J11vACR+1KMfTNuw==
X-Google-Smtp-Source: AGHT+IGI5YFD7MneY0Pqdx9wCDOQc/SI3e6RjIYE+o4qAKZ6f5SWpzfKm54JXmTmBvUzaoFax+4IwO0EWJ9MvCoGAdQ=
X-Received: by 2002:a05:7300:471f:b0:2ab:9cf9:4a8c with SMTP id
 5a478bee46e88-2aba451b667mr285426eec.35.1764793962037; Wed, 03 Dec 2025
 12:32:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <ada2fc90d01cb54e178853b766896f0f69b26451.1764574369.git.jan.kiszka@siemens.com>
 <CANp-EDadXjDxHKTZDUSCSmdxruGKUk3CEFRB2tN6LCQnuPfKGQ@mail.gmail.com>
In-Reply-To: <CANp-EDadXjDxHKTZDUSCSmdxruGKUk3CEFRB2tN6LCQnuPfKGQ@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 3 Dec 2025 15:32:30 -0500
X-Gm-Features: AWmQ_bkYRSMPKnRm2gBKDNGnwAZ8Nz70_NsvNWDEBgmtVeuI_kr0rWqOyKMgVVg
Message-ID: <CANp-EDbmUxaviTO69HmWEYcFJDCDtOHXMgs_CfT-rE88ykGFvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 Sune Brian <briansune@gmail.com>
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

On Wed, Dec 3, 2025 at 2:42=E2=80=AFPM Ralph Siemsen <ralph.siemsen@linaro.=
org> wrote:

> The reason is because the sector offset is zero, rather than the
> expected value (0x200 for socfpga gen 5).

Actually I see now that your subsequent patch in
arch/arm/mach-socfpga/board.c should handle this, but there's a
problem with the #if defined tests. I'll reply to that email.

Ralph
