Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8186ECD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 13:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A15B8341A;
	Tue, 12 May 2026 15:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qy7teBko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165788394E; Tue, 12 May 2026 15:21:08 +0200 (CEST)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B623D803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-694891f8f62so2916474eaf.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778592064; x=1779196864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=few1BVagtJSWWi7Tl/AFI8RJqcFuRGGfLsuTlISD2rc=;
 b=Qy7teBkot/0IlTszLj0UrrzLP1uGBmDXdbUeKcTj91kIYTudeLRSIQFRgjuxTUoFYI
 Sd7tm3zf2RFWJMD+d0L8TAXbMqVfFaiZ7GXWRRV5w2hBRACVuPauVV0ErxyqBY6gnCjS
 KMwlIpOAuzJtNZAQNYa4cJpzv1OPGQnHaPI90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778592064; x=1779196864;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=few1BVagtJSWWi7Tl/AFI8RJqcFuRGGfLsuTlISD2rc=;
 b=qAuQfohhOJza1bscn40gHUDKmLBfkFRQ/RHsQye64nZRD2EloRb92YwX+Kz8EL3vKY
 Zj4/qGy79eHzPk+aYluxmSB9++K0v9hsFRlMlmy/gW95S3KhLKkToE+moH2cG0ek/suq
 tKl6smM/GzC0NLO0SLn0PWu17R4XpsnWass1vz0YKBtUrbl3Ubqq3ZTONwts/OURpwTm
 ts7KB2tQqacXbf9IVnHOJLW6zhBvon8SSr8Zk3Voy3B1XKme+MtGVFA2cqrbr27eVNpw
 S7qQxgnls8QfPhAP9Ey7xRWYz1k7XdLlV/QSx4uIGJa9+hukLORQYpELXMUgN3jSorSW
 EZ0A==
X-Gm-Message-State: AOJu0YwEMWzSxImyhB59bK9DjP1zwhDncv2EwONwDhqRHqB7v11w3hFA
 SvxNEj8+TAAiCXYDtoFcoSnCFVB+HQqO+uYja4LQysMX9cj7CdsBjPlVbPS2jxpOPqHize288FV
 jp8+QglfNl8q99Nc=
X-Gm-Gg: Acq92OEXP0zsYg+6L8Tu/3gbm3beW5rejzoGMxSJ+P48xgQUmOy9GCBp/ZJjwUcEpcF
 rrnmAigGP/NSDI8V3BfrbsHt7WJf8XqgEGs3ezh+BzrZXT5R4i54K9YGrKTEzssWFQj5MZ+xmo0
 gqMpDWICzH2FkPeX81ezVpWE6441xMrkYdGxY/cUWfdq7SXPk9CCW4wwjpehgugx/3MydDqIJth
 MQU4Hv9ojKS2XpCBgwqPGH9R788u40u3OPWfP2AiY/SZ4RvvSK1o+i9lMDqQT421xsLfWvXuFMu
 OW+HUk92uEs+exmqh0nTcSTRaG1SNoV4UA2IJ+Yu616lK16SJLb0ukRpzOct+vVnEQ1wliMZ5oz
 +NtiWPQfg9EnXG1qFjkmstpDnX7E7mKQu7S7Ut9vhChPXf1gpLaz7I4njM++Rb1WnxKKivfwETH
 Pm1oyv64BXRAr1cZ+H4dm06s4iYqDPHh5B2dHdtY/EzJgTTMRiBQC6DfXAGphS8LBNTqXDbSdrt
 QDUTWYijUu0qGASZp2w4VkJhAFc8Byux5+cbf9UtRe8bpCKe3CKda0DEt/o
X-Received: by 2002:a05:6820:339b:10b0:69b:3a3b:de68 with SMTP id
 006d021491bc7-69b3a3bea75mr4876081eaf.23.1778592064339; 
 Tue, 12 May 2026 06:21:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25e0d124sm7111667eaf.12.2026.05.12.06.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:21:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThRPTPUs7H-2Cy2v2hw78uLGHrG2r9TFWZFdBkomUtGMg@mail.gmail.com>
References: <CAFLszThRPTPUs7H-2Cy2v2hw78uLGHrG2r9TFWZFdBkomUtGMg@mail.gmail.com>
Subject: Re: Please pull u-boot-dm
Message-Id: <177859206359.3198063.6788590545010828759.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 07:21:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 11 May 2026 14:15:26 -0600, Simon Glass wrote:

> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/30065
> 
> 
> The following changes since commit 22a285380e35a31d0a882af66278bc1edc1b917e:
> 
>   Merge tag 'u-boot-at91-fixes-2026.07-a' of
> https://source.denx.de/u-boot/custodians/u-boot-at91 (2026-05-09
> 07:31:55 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


