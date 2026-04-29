Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD01CD13CF
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E560848B6;
	Wed, 29 Apr 2026 16:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PvZGMHxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A1A848BB; Wed, 29 Apr 2026 16:14:49 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21505848A9
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso1862996766b.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472086; cv=none;
 d=google.com; s=arc-20240605;
 b=Tna1XQOj8oZVrchmZsDEWwdHJHTjyOnBEBLLyVkLQADuW/xi57yxA/spMt+dNaL9+a
 qPi4RQCdi+JLgiDIECTSib/fY8cA8jng6YTocOQ91jybhL/YoOp9rbK/Y9OYQynRVdKE
 eJ5Wz6ZWMws/wpHRcAv6ImRxpBYabNxwTVrgNlNEUIcwvFEtBwIAp5R/710YbKW+U7RP
 5IfFUBIS6WpkYLpwiA4UhioGvbVRhsJG7I+j4Nhf1be+w6Sk3+4ehY11AifEMF1UT0Gb
 PydNZt+0tbmheDZK+sVQvNykp81jXcQ6XXIzq5hdygijW1+QGLHcUfjkK0YHFgySQage
 UVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SE49PdZH/5QSzdFROoBPqG4/nFXlLg51Q9ALXwNg21Q=;
 fh=naLizFPTiN3sw2H9rInwI9ZLe2ANU37jkFD9nAiu6hE=;
 b=SDEeUur4brHQfowAk89ZEoKiniJ+4I0Fw9NRb8Nhah7IAwKY0gMVoh7Amcq9ue5Ozr
 0EgAQb86EmfcCBlOMDvRVuWVwzK/WDN6gwbs0ECcRHGKsBxnkuVhFSLu5usXd4FpLxnp
 Vv/4WQ6cvnRmp12RsUMGItoXmeZ3LUxDjrML3xHL+Vz4jYm0BJSp8ICB0OsaI5GhbzTF
 iBw4BKssxnXUb4fQubqWlcxOsRMP5mhTaqURawYpXvwq5GlY11ko1Sz5ZnWzSjbfCxIP
 m1f7f0kkaMeASmeTZDbt23Fmh2CRSjCZ4SfqSupXD+fJW4JUC4vl9+jwsVH6DgVvFKvx
 NSvw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472086; x=1778076886; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SE49PdZH/5QSzdFROoBPqG4/nFXlLg51Q9ALXwNg21Q=;
 b=PvZGMHxSZJMprXbt8pV88YIkNXBEXpRe4QrwkVddDZwgjj609CfAHEPk6kh6wX2IlS
 Ok3EcMEgBZNx9oKsEy/K/O6CqZbnpgud2ispaL8/2oj3OqHNOMjCjcS9sIRYGePKDs1+
 vyJP1mHkL8PLyxtAhd6JO88VvNnIAXTvYFYbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472086; x=1778076886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SE49PdZH/5QSzdFROoBPqG4/nFXlLg51Q9ALXwNg21Q=;
 b=hqcJwCdvosnaRnbG1+h+NtY5+qAOLRDHlOunCb+6WLIS2syb29al4pnYTr2IsVV/YZ
 A9iFLRSWFKDH6rNe+OJhe2lwijjU4hirae8gMw5QNALgQkGY5RY7+lepdXboDAMNpz0X
 yNiCFL4I8smL+IfTaPG9bkcRR/NLSKn+T5pYLfhwQe6vpVbm2nt9NHW6Hq35NGXqMNtK
 4cvp2qonKwBCD/0RDUamCbprTWA8GDlySExtHiuUYp8dIzXpSQaHmsxXOsLb2naTRPTm
 jR5G1D1MD3xXhynBX2AbGqQeC1fCbBaJKfpIc7WFQTHXCAOd/fLydOdD/9iwl6kMa8IW
 nRVA==
X-Gm-Message-State: AOJu0Yx3fyecqjrGGY58aXmhlnvojvfs/4BOG+zQiOpUWp3x6ogcDhFZ
 ZATsX9++YEq51n235WvPQOxRaWvw/08uqg7ul1UJmkhbDygahKZF3cdtt+gYs2XBq7h5rHlHlzZ
 jIMs29Pq6pqG/5P1Kqglzxj7Hu8p1CisdqpKhLLOJUBORP2wsU4s=
X-Gm-Gg: AeBDieu+dCFKJZ6oKKfLKeBBPqk3URkbLn6CGPiin2dktWAB4kcF6UiqqRzgWRi95XL
 JusfJHOw0T4JP0AUgkOTmWBHWxwTYrCTskqzp+LIEHFJJp9JnW3/FPtjaVnDi+w/tz6+lFVkzop
 fOUWZfWZlvtRXkDTwL4W10z/W/+uU6o0nZb37KcjBRFs293e91OhyeXmTO3vDQDd9DOKOuxKaWi
 uPSXsY93C/ZiNl1vFRfIHz5Dk+rcjTuB5j6MKu1JEqeAyvZdQk6wCrtSqPzyqwz+QOgpHy5W3K7
 pzSGbMTKGNZGWkIY
X-Received: by 2002:a17:906:5186:10b0:bab:e307:7bdf with SMTP id
 a640c23a62f3a-bb801ad8aa3mr386949266b.19.1777472086476; Wed, 29 Apr 2026
 07:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <b5496d52e8093374b8c5b0ddd50d9943789885b4.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <b5496d52e8093374b8c5b0ddd50d9943789885b4.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:14:33 -0600
X-Gm-Features: AVHnY4IOv0P-tm6URZ2VPkg4aHJ_ynxOx4cFPpuu6eTJh54OPK6CHYfaGxEXmYA
Message-ID: <CAFLszTjDOw+Ci4nhX9waCn-t+ZvQq=5P_omLv0XsJ_n+1g8xkQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] arm: sc5xx: add missing boot env selectors
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Ozan Durgut <ozndrgt@gmail.com>, Ozan Durgut <ozan.durgut@analog.com>
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

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> arm: sc5xx: add missing boot env selectors
>
> Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
> environment includes the expected boot commands for this board.
>
> SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
> environment, but it does not define any of the USE_* boot mode selectors.
> Without those selectors, the shared env does not generate the board boot
> commands such as spiboot. This leaves the default bootcmd=run spiboot
> without a matching environment command and breaks autoboot.
>
> Fixes: c9e893d ("board: adi: Add support for SC598")
> Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
>
> board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
