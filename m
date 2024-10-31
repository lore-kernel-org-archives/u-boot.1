Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6106BD767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EFD88B8F;
	Thu, 31 Oct 2024 18:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PWI7+yCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302AE88DB6; Thu, 31 Oct 2024 18:59:52 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E2DA88B55
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a156513a1so197725066b.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397590; x=1731002390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=waSN1DVdbRUm7lpYO6vpbtrwdEOakpvqVtR1azCJ4zQ=;
 b=PWI7+yCY6A784evCeROQWikXwFHfF1gmyzNDVgQBIlUJKuA1Lzhd+pBLq63dEIBHsd
 /Wt7Nrlh+P5BK2D2mAQf8jis20rL3las3NWdesEEtIUVwyWXMW7vfAuBRFc5VSpemWUv
 VzYGvR4D0JrwY1a/3gcnlWHCPJPby4sYElwwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397590; x=1731002390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=waSN1DVdbRUm7lpYO6vpbtrwdEOakpvqVtR1azCJ4zQ=;
 b=KKpTmT0LSEVLlSLSiThkFxFLem2D6CfqMhZ+BHWDNyDleN0+9xmWriVVgNCPxYK+7V
 enVf+abH/agAaV/w0EkPD/OYrzReAl+Fe8nAI748CQnl+xh466T/xQFDF+w+pFaqb3Wu
 HzY7UfrFH7O9h/KK9L+bMgaHW2/wLdMVpJAMv0wFDiOt4Yx2Q5gnp3QccjAJ3mYeXwHL
 TxQ+7oMLWIrgcDZNPcWEmtqs32tKPlilyEWb4bNsfG7/llf0GLVz6YoS/BXEo5/WdCxq
 y51OXxvARb+NuzIhuXqnYlgKkW+hYlCIU9/nVv1UPKDwadY4iQoNWsytkggmmSDUs4pQ
 uYPw==
X-Gm-Message-State: AOJu0YyyBJroYhPbVs8WYoUunyYiHkKsgAnzTrNyQWJjiqo2Xk5LKJxH
 ofEv0ZgbmEJfwkbWOXHyN2NEYQY26GWpu1k/Chm3qIY1HUcPwllohbCl8AJ5JjymJbozC5bJaXR
 bpjgxqqsls9jx1z57c0PWJEWzc4qjlgaBWVRTpZiAv/gFJ9kSXA==
X-Google-Smtp-Source: AGHT+IH9kRHyWPpmXs0ezUoMMXmQ/ksZwcQkEvBpDSyXMk01ROQbocoBXsh1AHE9B3YR//lIO0EGl7i9eI5Dx9L1EXk=
X-Received: by 2002:a17:906:dc95:b0:a99:f28f:687 with SMTP id
 a640c23a62f3a-a9de61d1a52mr1883622466b.40.1730397589669; Thu, 31 Oct 2024
 10:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-11-sjg@chromium.org>
 <20241029235250.GA2558755@bill-the-cat>
In-Reply-To: <20241029235250.GA2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 18:59:37 +0100
Message-ID: <CAFLszTgVbwiiuwyynfY5ZKOy-r9oqhnTvPSqaEuBadFQofO4oA@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] test: Support testing with two board-builds
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 30 Oct 2024 at 00:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 07:51:44PM -0600, Simon Glass wrote:
>
> > The Beagleplay board uses two entirely separate builds to produce an
> > image, rather than using an SPL build for this purpose.
>
> JFTR, this is an incorrect explanation of what's going on. The TI K3
> families have both a Cortex-R core and a Cortex-A core and the R core
> needs to come up before the A core. But in both cases we have U-Boot SPL
> and then U-Boot proper being used.

Yes, I understand that. I will reword the commit message.

>
> This is aside from having come back to re-review the series and still
> feel like this is taking the wrong approach to the problem. We wouldn't
> add a --optee-build-directory for going off and building OP-TEE and so
> forth. It's just the case that we need assorted binaries for the system
> and some of them come from building U-Boot for another platform.

Yes, and that is supported by this integration. For example my rk3399
board brings in optee as a binary.

Regards,
Simon
