Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA19E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B835D80384;
	Fri,  3 Jan 2025 02:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JdpLVw51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A387D8036D; Fri,  3 Jan 2025 02:41:36 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288A98034E
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so250023466b.3
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 17:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735868493; x=1736473293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/BITMFlTJwEjo8D67afFTWqrimz35/w7wdZ5bFgC2oc=;
 b=JdpLVw51dxI5rKt9FATih+VMMy6tB4V9/FESTZF+qFvAQCTo0mRKJm9cEJKEHG3rLY
 rGasGEC2nIm36mZT++GnJuWhX0mknwOAEYUGyQw3Wj9qWXh4Vim05/+8JXTnV7Rj5inC
 n5FiCgCHlllZ+ItY9vQc5u1gXqEeY81utmuRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868493; x=1736473293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/BITMFlTJwEjo8D67afFTWqrimz35/w7wdZ5bFgC2oc=;
 b=YuyXnfyP6Mw7qUNpnS7+xZUrW3ZWTw1PPRlL/N79PCX8Z72K/R8YVKFhj66dL/TZA1
 9jvFP2MmQSgCnit7jvTrAbKFd1tkrAViLiOriC6851cBSD1+vk9+ywtcxWFhTn1d40DD
 l7tzkG1ebcIupZmDuJv0HzcjUZXPHSNigl/vu/KrFfwG8zYea2Gtlr6w9Sw1HG8wFp5J
 1iJDU00QWSbvp60PRyXzAO9PmRZe8xEccA8CUgLCxr7HkXPKXbSiclRtdklEAgaqPCIe
 J7SNtqWEOyl3KZhiCW8YHY82D9VWMlGX/pX9H54NfhD8bcMd34LSoYZjvGMDQeqQAOvV
 j2ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl6ksTJKV2yb1A4JhGIJz/iEerGlCr+5mVFRc9NLCKU5BTL3NiU89AX8F6gB3O8bHfr0T5k6U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7vXS+0uTKc/7osONctIjzqmxqQOGMqzoqdTsVFgJSkyTJ8Gc9
 YetvTRuD3pE7eP+PkHIXvA6CaLVWKlWlfsoeZe9xQHSnbLmxn88ffFQXt0IiwTz5mZy5qGxeK9I
 Y1e0rq0AV6eunrFoXakyJ8H6gWt74aFaCOJAk
X-Gm-Gg: ASbGnctILcmfdTyZuNFDckOTpEmMV6eU/X2Na5BqRj9dNPXVtYwO2urJFky8JoFScsa
 xJpl3Ee0ltXz879RAsBB+l+MFUksOy0rvNF9hYQNQ
X-Google-Smtp-Source: AGHT+IETFIhLVW7oYammPThgpDVjZ8jeKSShiXtLQOByd5StEdDZKbPlI0M9AgmhNT8WpLHuiedIoL+c+n9XfMk/0Iw=
X-Received: by 2002:a17:907:7f8e:b0:aa6:9198:75a2 with SMTP id
 a640c23a62f3a-aac334e51afmr4218685866b.44.1735868493667; Thu, 02 Jan 2025
 17:41:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <20250101175518.GA1682161@bill-the-cat>
In-Reply-To: <20250101175518.GA1682161@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Jan 2025 14:41:23 +1300
Message-ID: <CAFLszTjryDVBwn-RxfgTOneUBBUsE-3sS+Y1ykk5BOKzeFc9Gg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Static initcalls
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
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

Hi Jerome,

On Thu, 2 Jan 2025 at 06:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 18, 2024 at 04:53:53PM +0100, Jerome Forissier wrote:
>
> > This series replaces the dynamic initcalls (with function pointers) with
> > static calls, and gets rid of initcall_run_list(), init_sequence_f,
> > init_sequence_f_r and init_sequence_r. This makes the code simpler and the
> > binary slighlty smaller: -2507 bytes/-0.23 % with LTO enabled and -1232
> > bytes/-0.11 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> >
> > Execution time doesn't seem to change noticeably. There is no impact on
> > the SPL.
>
> This leads to run-time failures on SH:
> https://source.denx.de/u-boot/u-boot/-/jobs/986701

I'm not a huge fan of this series in terms of the style, but this is a
significant code-size reduction!

For the board_init_f() etc. functions, can you do a follow-up with a
comment indicating that logic must not be added?...i.e. that we don't
end up with variables, if(), etc. in these functions. I think that
would be a good rule to have.

Regards,
Simon
