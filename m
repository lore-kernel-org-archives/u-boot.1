Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A561C369DC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 03:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BFC8059D;
	Fri,  2 May 2025 05:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EVCMqSQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F8C88070C; Fri,  2 May 2025 05:26:54 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03261801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 05:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5f4d28d9fd8so2099241a12.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 20:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156411; x=1746761211; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vzbxe9vsWWDgCuiLLHU3x1RDLoFRvm2M9AgCuxSM+A0=;
 b=EVCMqSQfKp8W6qT0g+sediIyfK3r7ePMbjOoZE7l9PvTCpsrTx9RGeZdw0wfy8r7a7
 bync12krZoj+GHN66wXk9rRrX9tLAGIt0tRAowctlMUf/JuTHGSjSeZZMjLY94Z5/Cvy
 o6LNKgk0WTP0Yvj4LmGWm9HE4lYHbvQi5e/mGWC1R4Ef5TLdES4K7uBW3VrK/zKODPNf
 cGGEs7/dpUVfJa+Hq7fq+D0kJ083ZokVKjzmbAq515GIoRAmgtFqCUTJkYOaJaqbSfp9
 uM3HGwP2TBz8wTXPo7LXnrsWVx/RClAysDgzxfP18yyX+57yPEuwcxnKMY2AAMvYeUVv
 7lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156411; x=1746761211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vzbxe9vsWWDgCuiLLHU3x1RDLoFRvm2M9AgCuxSM+A0=;
 b=HDhxIoqFXZCy/6cz4Uc1KDP9ThKzsiHBy8TUCcHj5wiR2Q79ktGktb6oiEse15cu0n
 jzHwGtPsOsQmgu/Op9m3xQKNAQGk6G+KwaPTzmd8XdRP3lxD4qG702VLKbawR7Qrvolb
 ypXq1TpYi+ib3/h31VeFKFkiQVfZx1BamCre++wcCL3LXR6Xu0fv/ga56G2YXEf8Ivb+
 d+uK+2TXaenIJbfzLVoFahf/egDx/CySGgDH5R3tChBAIKggxKuc3aNpsSGdVtJOkCNI
 IeIoO8legiAfsU+0j7ekL/ef+MLoe7h0KDIIcw3OaQQqg2DKzIAu4bnQweXacpIaEjIy
 UeFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/hGgY4/piGo7e9mntEf5ruBU9MPijiwA1gl3G+ITztrcL3bRDL+Nl5nTOqrChToBedxeYyd4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyew7cDD726bcKSkgstSJQ7d02D3oFnSfW8IEsETEEyJDQCE2EC
 ycVApiICm1SC/xfTXj2+cQkwSpT0VhLDyOA8P37cLZrxuUZzJxveWC+wggGdjbBK+vOnkhMkqSH
 inQBjmjj02dp9ev3QxSH6D9qIOfZOkw==
X-Gm-Gg: ASbGncufgwfCvmhzkmUKehMLILljpTosvWL56n9bmrs/CEd1E82Hn+Kv1JcJaq6LZbP
 TJu3o4ScS+50p+5FpanesYj05U6ExGmg9oi6qNK0fgMzx1lV6nqgfu6KwspUBBSoq5oEvxAscwY
 uSdv9KrLMR8HCRN5mxnXs4e0o=
X-Google-Smtp-Source: AGHT+IHC+cAoyQ7N3z5MApmULyNAekjA0cCtoUeuSvfoYY4togv6bt7hv1zO4PnHWXyBEvZiYATovgVYpDD/DFdnvGo=
X-Received: by 2002:a05:6402:1d50:b0:5f6:c4ae:d0cd with SMTP id
 4fb4d7f45d1cf-5fa7881e12fmr752327a12.20.1746156411177; Thu, 01 May 2025
 20:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250501230530.GN1261075@bill-the-cat>
In-Reply-To: <20250501230530.GN1261075@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 1 May 2025 20:26:39 -0700
X-Gm-Features: ATxdqUHxWx6Fb3SFUHq0zalEi3w1fxAtOjFXlGxiMfbx7vCmcuEP94rVh0gRDiA
Message-ID: <CAJaLiFw-TQtgw8_ru9G2MtDwUTz=+_S6ykmBmwW0T5NGxgwxgg@mail.gmail.com>
Subject: Re: Convert DS109 in U-Boot to DM_SERIAL
To: Tom Rini <trini@konsulko.com>
Cc: Walter Schweizer <swwa@users.sourceforge.net>, u-boot@lists.denx.de
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

Hi Tom,

On Thu, May 1, 2025 at 4:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Hey,
>
> Do you have time to look in to converting the ds109 platform in U-Boot
> to using DM_SERIAL? The code for triggering a reset via special serial
> commands is the harder part of the conversion (and I don't think it's
> likely that hard). Thanks!

Let's wait a few days to hear from Walter. If not, even though I don't
have this Kirkwood board but can give it a try to keep it maintained.

All the best,
Tony

> --
> Tom
