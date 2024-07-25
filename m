Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD09CC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E92987C86;
	Thu, 25 Jul 2024 16:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JoKpaBM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487B387876; Thu, 25 Jul 2024 16:02:58 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A65186463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7163489149eso687988a12.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721916174; x=1722520974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=91lZhilelJ56H5mAzT36jFI91+vfoLM6T5SL7LlJN1U=;
 b=JoKpaBM6Gq8RXAnPRV72h6+mSe3kH0qBfTaUScUn7iH9vOcesML1kdE+DnebwwzT2O
 LECIVhw0zFGALa1pQc4vwHqZUjwzNr832eEcX0ZTJ6SVp26zKUTBc84E3dyKsXT5gThn
 0Lm6JKEbEZ1jpBPEVYizaSELHWYME3n72l6U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916174; x=1722520974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=91lZhilelJ56H5mAzT36jFI91+vfoLM6T5SL7LlJN1U=;
 b=cYTxoajevf0oLabybImUDgRzfeb9T7HfMpUk2I20dE9+sqU6KE5oE6NL4UUa2xRvQF
 qpv6TS1voXSpOLJ2sayTvQzsZ/wvn1OviOxEARjTjdc6ZLO7NC5fa5Z0O0C4zdHcadGa
 Uj+7TE/vrUOaCLf6zWTqFl2UkBLuHYHtSlxz//WKGjlX8r9k27t1s3nWNlhhmbhUgr0A
 r4qcbonWWaussabrYlAVuLmexfACu+K3H2YcT5awnbjQFvGasphqaEgPS43HjlY65U/X
 lyF7elRxpQD3NVoEQd7zUw3YhFcguOEXU0OJpV3CKNhbpqjHTuLxHuJr681in8cDPLKv
 yuvQ==
X-Gm-Message-State: AOJu0YzJJTnIogxNyKVTR8MTKuBl28VIpwzcEOkSxiqDrbHU5hNp9emZ
 DH7p6QjZcPInmJFxYa/RzTRPERob8ezankC6J7AgX7xg3qPBdoYNWgcsKhQme5REYQNy+Z8pGV7
 NMnaCfW1m7uOXdCroOyxx/OUfSNpA5zTRmbzX
X-Google-Smtp-Source: AGHT+IHYHFxFeN2lYezy7DDz2GZAnVkStt3mEXyNObsTRXqMnVx1qmV17XyA6M5z1ZXzzUrwRjDuD/mYVWlTWWYIJxw=
X-Received: by 2002:a17:90b:296:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2cf2ec03be6mr2126859a91.37.1721916174597; Thu, 25 Jul 2024
 07:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
 <20240725095331.14245-3-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240725095331.14245-3-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 08:02:43 -0600
Message-ID: <CAFLszTgGxvqeUY5kHrv3r8U7F2xMT2tXW+3Km2n58h-wi5mZ3g@mail.gmail.com>
Subject: Re: [PATCHv2 2/9] cpu: sandbox: implement release_core callback
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com
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

On Thu, 25 Jul 2024 at 03:32, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add empty release CPU core function for testing.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - New patch.
>
>  drivers/cpu/cpu_sandbox.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
