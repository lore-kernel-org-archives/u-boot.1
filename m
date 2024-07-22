Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E36C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B3E884B2;
	Mon, 22 Jul 2024 23:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nht3gBPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ABDD884BC; Mon, 22 Jul 2024 23:06:41 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DCC87F82
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f01db9f419so991501fa.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682391; x=1722287191; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/wF73R3lJ/MmR+fiwi/jb0KXNmT9ccmZD7EWj9BnF0=;
 b=Nht3gBPrvfHWsT3GJiEvtbWykoKr7xN5dAgB0c/+Br9veMoe9PtQrgdGE+0Ps+9uR7
 m05LV0igoWx1iPeMw+OR/kEIsKdh+xsOTX6ve68uyRs4oZ/nmeG7Vd6y+6AExjrK/aVv
 2sEhOu2Lr56m5cKNRMi0s6GcDVjUYzpbI9HkHhJTX2IcMUYOqhcjXk2JpCBbZ41kczSv
 9fB5s24emwrSgq6oF8ol7ut2JHaZmcABzoBXQrOfxHQUxihM2124A+/cScPmtTHIdDgg
 z8wNDYpimo2ldhKXaB03/xa0Ejnk7E789YqWqIRj4hpDuwCbNQvNVCwFyo/LodxBZlQ8
 /HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682391; x=1722287191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/wF73R3lJ/MmR+fiwi/jb0KXNmT9ccmZD7EWj9BnF0=;
 b=Bn1QsZweJHFw84rOCLhc0+inrGxUAK7bkWv5axZFYa8TpNiajORPd9et6Zf8EDgyT4
 acYdGGA8T0gCjUDDmkJZ7H8S32O7ev5LwvdP426VUoshJpv/l86Kj0x3WJJwmnliyes/
 0r0koH3VaMN9IQaTYH3MDdehDdWtPjxk5mIA5rp04YaJJ2+/ucWZrkdJbg5faXokdc+W
 28VkhWguCMiIK4pT666DUYeQyzMJCPYbCdWsRFJSziNWU63o3mHqNYhdD/FxdZ9vI4yG
 eGZ0Q1Q1gkuThp1oGHNZDDOZpmlSJmKaL9Gpx+pIRYryJ44rM6YviEUus6p3vLASdKr3
 Ubpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu9TfnyFA3ijLdHr1RS9b8T36NMHuU4Fa6+7vQA6nMMEs3kD8Hra6ROdf3JGzGAM/DrCQkRi426fdvAF1xbWOgh5pE6g==
X-Gm-Message-State: AOJu0Yz/wk9o0oObZpV/zl8NXyLOaBTzM/GwTgk0KvP4L03UgqVQjdrr
 TGfkJStEN+6y4n3TGZbXZz2ObfLltIHqmOO60PbP5Xmj7+0NX53i1qhS/lurfmIFvgaFcWPBf+7
 +/45NFFUjQbfC48QMBfJLPzRUDKjzxQ==
X-Google-Smtp-Source: AGHT+IFAIBOdnQPsVpRZ1nYHogs521VlUeWV5Kt5HHC9AQPvPAKQMcyoQkiys2gfKYodXwSocDqzLRRfTVb+piAAGHU=
X-Received: by 2002:a2e:a78d:0:b0:2ef:315c:67e1 with SMTP id
 38308e7fff4ca-2ef315c6937mr16964971fa.4.1721682390752; Mon, 22 Jul 2024
 14:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240719203311.1695523-1-festevam@gmail.com>
In-Reply-To: <20240719203311.1695523-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:06:19 -0300
Message-ID: <CAOMZO5ABaoaL2w_DU9=XNQpixxUZrqD4=DZTfpzA+NFOavPB-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] udoo_neo: Convert to watchdog driver model
To: breno.lima@nxp.com
Cc: francesco.montefoschi@udoo.org, u-boot@lists.denx.de
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

On Fri, Jul 19, 2024 at 5:33=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> With the watchdog driver model in place, it is no longer needed
> to have board code to initialize the watchdog, so remove
> its related board code.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Remove board wdog board code.

Applied all, thanks.
