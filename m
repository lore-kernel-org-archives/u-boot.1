Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B93C87FCA
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 04:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D76682CFA;
	Tue, 29 Jul 2025 06:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P4/N8knH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF12D82D21; Tue, 29 Jul 2025 06:29:33 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF9A82CBB
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 06:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so8001419a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 21:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753763371; x=1754368171; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRf/66VZqrmO2DV4z2uMBNii/LRHk34ShrFrj9O1hYM=;
 b=P4/N8knHlGl15sKwUrMCQWCyPFaOEzLF994OelKhKZBfnB4iYwoZZDz4IWBLa2BmVV
 wj1412hzV0kovTv6MOJYldchUPo8YkBpDAKk69efRI+NP13ByJdnj6kuQUgMGhVEtBQX
 aCQZp2Q9jE4HTd9Uzw96N0x3sYdSBU78jDDd0rpBXEe8t0DM/9SYOIzlDdBSe1a/3SUx
 VdrSBE0B48VXSt1h9zOVqfbS4HQKou/edfI/VPM+V/7lfuM/A2GKLYJCKPPBqKaTC0vX
 G6/UoG04ZH+C46br+kjQqTFDMxaIy27Eg477hXlwc/uZ+e/k11BUDwSH/yDrBcqUpMYE
 S/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753763371; x=1754368171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRf/66VZqrmO2DV4z2uMBNii/LRHk34ShrFrj9O1hYM=;
 b=cz8Ka5YX6yZDhs9+Q0BsiuoX4rD7mrrlu9cEJ5vQ+QcaZvAvg9HBihq13mo7SjaKKh
 aSEvHsQnNQwBZMsKvUkKaQs1UEdSPZG64WDDoTsnRAmkYLuidMbUPjt/YlG7U0KBpyay
 PcMTId4Jm4HMOk8YMa3HvOiXwf/PExc3PhLrgpIXgXMqaUqJaOfKfvl6nVORC5iccJlO
 yd5zZcW+W4DxBeDbu6/bHkxJjo2VmcUialSp3X1cDff8gYasDcH9G8Hyqsj/OfXRZZez
 CsJvTW/OArK000H/zW/CPHcPAaKmJOrlNkHqhABsh3KXRfDKFcte4thZBv/Ct8cVZ9+y
 P2OQ==
X-Gm-Message-State: AOJu0YyikfFbWIJRLp3xsFmIfGuhgaynZbxMJE+IUBmpdcK/V+bOLbta
 Dqtq99U5UEkyQo/EgCSvmpUnfSxjDLAQkvztE60yjwJ9T4HP4qT8r31I3SU8bpmLsh6XdFrC47z
 BHqAaTF8j7kqfhnXEJSoOSmzJ9EgY6Q==
X-Gm-Gg: ASbGnct0JucW4ErI19cWqATUuaecYvFnx2XgDlTJieArb4TVfkwLT7F27Jz/oQmmrMa
 lMSuoE5qeV71kkdLadMvd8BdeU6yVppIcbWZc0muTP7YSiE9sV2SylOtJsIVkMH7G/BZHYxAusI
 Qghoq1mFNeQdit5J19qSYv2DuAtphdL7DtoONlo/8WqljMhhu0/f1C4WEpUaHJH0FOLGgpHAUZi
 A+UPGUZkaV1m1ltOJSQoZ9ZxKvhRNOuiwn2KWdEJ+//b0Mycw==
X-Google-Smtp-Source: AGHT+IGIn2gLLWeNyISuzlTktNhL2HwfjT5phqiN/1RodTtNHHDx/FrxDZmkvetMQG8njxReDIU8bl/9BAl4w3M+QIA=
X-Received: by 2002:a05:6402:274d:b0:615:778a:a88d with SMTP id
 4fb4d7f45d1cf-615778aa8c5mr111865a12.16.1753763370791; Mon, 28 Jul 2025
 21:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250728150333.1716886-1-philip@philipmolloy.com>
 <20250728150333.1716886-2-philip@philipmolloy.com>
In-Reply-To: <20250728150333.1716886-2-philip@philipmolloy.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Tue, 29 Jul 2025 00:25:27 -0400
X-Gm-Features: Ac12FXxseJwcbFqqwgev_v-tzYVcA466uu6iKpxXY10ktnQydDTuzYBsXpMYFf8
Message-ID: <CABdDSeVBkk0yBtnaeZPjFQPV+bZCodHqxjFS9Cih1d1kd+5qqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Makefile: Remove expansion of undefined variable
To: Philip Molloy <philip@philipmolloy.com>
Cc: u-boot@lists.denx.de, Michael Hennerich <michael.hennerich@analog.com>, 
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>
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

On Mon, Jul 28, 2025 at 9:04=E2=80=AFAM Philip Molloy <philip@philipmolloy.=
com> wrote:
>
> From: Philip Molloy <philip.molloy@analog.com>
>
> The U-Boot environment was previously stored in the boot loader stream
> using ldr, but it has been replaced by the default environment built
> into the U-Boot executable or an environment on external storage
>
> Fixes: ea3310e8aafa ("Blackfin: Remove")
>
> Signed-off-by: Philip Molloy <philip.molloy@analog.com>
> ---
>  Makefile             | 1 -
>  scripts/Makefile.xpl | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1a5c77d7caf..e57594aa755 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1370,7 +1370,6 @@ u-boot-nodtb.bin: u-boot FORCE
>         $(BOARD_SIZE_CHECK)
>
>  u-boot.ldr:    u-boot
> -               $(CREATE_LDR_ENV)
>                 $(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
>                 $(BOARD_SIZE_CHECK)
>
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 43f27874f9f..408d5cde7a6 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -390,7 +390,6 @@ $(obj)/$(BOARD)-spl.bin: $(obj)/u-boot-spl.bin
>  endif
>
>  $(obj)/u-boot-spl.ldr: $(obj)/u-boot-spl
> -       $(CREATE_LDR_ENV)
>         $(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
>         $(BOARD_SIZE_CHECK)
>
> --
> 2.50.1
>
>

Reviewed-by: Greg Malysa <malysagreg@gmail.com>
