Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77001C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B58AF812B3;
	Tue, 28 Jul 2026 11:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wh7rCTLIZY70; Tue, 28 Jul 2026 11:41:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EC3F80F7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238882;
	bh=5XjEm3SBwvu+d8L8AF9hQZHndkMsZmBvX9CnIrRWPcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q6ICWSF/ePFO1EGUGOQLArOGPzjxz2wtSF3PEpmdcldUsqs372Ouey8poPfZjZjVP
	 vG0prfIYMdmmoQ+Ruoxqppykn7nKeaiAkJf9uehWlO00MLMx28UVA4hGP2FcmEUcJo
	 6REy/lt2dZP+WDs+8IXbD8kjoTqzaoY2vta2cGH0oR7JV+wMalN0y5OmqyhRBg5JYW
	 7Wua7xSU5GGEp4k7IM9Tr708GRBzf1s2yO6Iy7/TKefKZZD6HSn94S2HLkAWj4Dw5v
	 pdTStjGXzXgJlMoIOGpojmLg6o7G6Kisb2cGm6b2B+i0FlOf4B6bNNl6SvtL3ZuJT1
	 ZVI/uyoVzMDig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EC3F80F7F;
	Tue, 28 Jul 2026 11:41:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B0DA788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D8F240933
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqFluTlhSMho for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:41:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 43FC040929
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43FC040929
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43FC040929
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:41:20 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69e2266b07fso5080457a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238878; cv=none;
 d=google.com; s=arc-20260327;
 b=kaqpTfItbC3FYjrUUlj4CAV56mnZ5uOo7Nf2f//IeN6UGkPNSs7muX2fg355ekTKkv
 qnJhE731Oqx3Zfyy00w5JqZrFbGe81V/wdjcJ87GB+lsyhkTu72MYHyYA8XYhR1mJchy
 6Jg4bridBW2irFlAz8UOlMMPnzcILw3+WshuAjXvtpEfk1Ad0eERbs6guWhhhVvB5LjS
 YcS+nHBNR7OwU34WiEYIoNq6gWjYVmsMfKuTT6Xz3WQuddOPzclHcwRMF1xUKOBmSnDI
 iuHyAtvsLUxBvnVWiAxljt5jFkW/WpOowrXMA7OdTJCOQfus18GxFeij85zN+GWOm0U2
 0GFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5XjEm3SBwvu+d8L8AF9hQZHndkMsZmBvX9CnIrRWPcs=;
 fh=dqtlzSPyegpf+eKXwenDbqqOp1b2A7belzRHN7qMHV4=;
 b=f8751ApgD1FJL8nCcBK9JWWdtr4gHRzjAxb4d6tEm4zv8FyuETDcl/PynGfLDadmBz
 QSpkJsNaPfAvEBXVmZxK6nLgkk0kE/2ilfxf2RIi/VFpJ6weXljGhBB9NSN3hTdF75dA
 o7MvoqwvKosQgiblXYEyOOFmp+wD6OHDMcqUTKZ/fyI0JhyMfp1nGUR94PTG9k/va84Z
 c2DwlEL1CGzyvzXALqqaJa/IGu+gVRJTi43tlnsoPMNcfgAQxMwfPmlm9gFEXfGZm/CH
 vrKwYK5S+90u4K4GEgdoOAIx32hDpzF6HTPG0brkTiOeEDoFi28kJbmnNQoS506TfK2Z
 yB2w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238878; x=1785843678;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5XjEm3SBwvu+d8L8AF9hQZHndkMsZmBvX9CnIrRWPcs=;
 b=Y/fIZV2/9ZceFwRsSCzwb5xooZeI62I1vIUHfNqIhHdiSLarspVrVXXXMFfMZma4eL
 5PSELcfQyG7nSRCv8lfuwcWTEgu0zKfTAuyoeGKlF1iXH5uLeICg5/44vuc0ZyeMS+yp
 +Lzp0XKMzzec1q9o0QfNOe5/8VRfebp7z0EiIGIfemWNkgMRgJy9VbAl1zto97//nXF8
 ehYQ7LmkGIeiPON+c7+7du8DeplGQ6gupEhB2Al7FsDoWCKyuUEFbhZoGR0GLUZN2dm+
 KEUglFPLwH8DjJ7Vbcy+Wd68U2ya94x419Fy8DPJhbXBJPJgGoftfidKQHtdGTUqSOHi
 FZ7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq82UdkgQot3JdvJpFrqMvO31yoor2IFxSeZcxH/fpkB0mQkWuTQQbvkP5dhs1hGC7SCi+g2aM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwLnroL42VP27YGssz5+3KSZZXzGV2JXZKM+4q4zhtBVNaFeQTk
 EyAA9gMPWFhsSe9uCNeAikEqON+mHaQOBgDXLRu70tiVu96pRTdhYNbfdRPL+e2yj4BS2y1auiB
 lrwcPZ7EUq8AijpwhEbax/49if76Tjvwy8q1gM+B8
X-Gm-Gg: AR+sD132WWsxoWbugJYtwwXK5jyNl8lY1hoGo3fGVcZ8IGX5dHXy1d7Rb0Xvd3FZQuX
 5vUvJEb7jg8fv1K5W2fEYcqIE1bPCOvauIbSJLhQgYh2mleEh3rGyQDNDbut5I/cTjzCzP43rLN
 on7oiVpozQYpw6jM7Tc08iu4Dkk87CZz+WSr7mCXFGa0tlAN+hC+j8gjrJXspuhZUiN0fZPeTdC
 Ae5UjiFC+iT+v3BW81IOGDGaPZ2Dy42AMvrlw0SdFdRKlKDzl5QI4/sbKIf
X-Received: by 2002:a05:6402:21d8:b0:69f:c7ff:a742 with SMTP id
 4fb4d7f45d1cf-6a034ae3ac9mr978163a12.32.1785238878346; Tue, 28 Jul 2026
 04:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-2-aristo.chen@canonical.com>
In-Reply-To: <20260721152110.283998-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:41:05 -0600
X-Gm-Features: AUfX_mxIsew651ugYIVPMqOa1D-mvqlNSQo2G-iJLY8t8vd_SJqR9EtCaEv7bcw
Message-ID: <CAFLszThwW2wS5v0=xAP37t+iVpnbkbmZR_fF7++Zy5k9NoT1_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] binman: Fix typo for the test case name
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Dhruva Gole <d-gole@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238878; x=1785843678;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5XjEm3SBwvu+d8L8AF9hQZHndkMsZmBvX9CnIrRWPcs=;
 b=R5MbdzBsb39lA4VugTz4GzWmRlOgldTvhAGM/WdaOSKchwSJluO9JHllvq/laWs1fG
 Pjk7q+b4miRuC6PfQr3uA9a1Viv4XWnmd83IyGiLKWOW0b0/g3LAiAimoAU5vbzmXHeg
 /DN/trgcxHv70gDIwaK515dRkdEutlLzhRJMw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=R5MbdzBs
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-21T15:21:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> binman: Fix typo for the test case name
>
> Fix typo from `Singature` to `Signature`
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>
> tools/binman/ftest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
