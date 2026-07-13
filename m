Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5DCC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2B284AE8;
	Mon, 13 Jul 2026 14:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NWFQGBpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE9684AEB; Mon, 13 Jul 2026 14:41:01 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C2884AA5
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso4327250a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783946459; cv=none;
 d=google.com; s=arc-20260327;
 b=kMnJsMTYQ4B1fFeQrIlR3I9d4O16JMpwOgd0S9OQiUp1j9XNUKhSCHBmDV5F2GE67S
 dskDLE7kSkqpjtxCboO6g2Sbwamq0Pw7FcKo3gUvdNOxRnRfzU8A8XR6LQrKY2f7hUbr
 5X6puVdQpSDgcIQQ70WMHI8/qyzK/xZSKSDUx2Ld/FsEouo8nFJsAbr7vzzx5MW547eJ
 Q1wmGpk4WkLt8pZjpnw02fAZMp2++mse9HE9cQrZLqIDjqPDEvx7mQq6XCObs+OiA2O3
 ydF0N3tQGm6wv69WF6852rNab34YLpPaxT5RtPG/qSi3Byt8HJOPXTPajuceY3na5kdd
 uFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xRMSmlNH9dw4Siso9J557BKyqFL3dY0XbhdZRsijzeg=;
 fh=CcuDZmTrATCCWiOVlvhRNk3dyUsaw1UrvxWB/NarpSo=;
 b=lFjykHbufrJQjBSayFTqrT3iUsSkhtShcIShFTand8VL7j2KeHd7HjpIs80L/59q+K
 iWqX0v8xPYIqFj/MZXHywFiva2/AFLCEzuiZKUJHs+hm0DC363uB31+XPGDqO02h3nhp
 oDmkurgrVvafC08J0GhhK0oYNbGHu4JyupEnNdUxoSdoaIG9lvxU2kis6Y+KlB5ZT1kA
 jvWuUltXPu115XS/ZJ23TQoqYzx+Z5wkMCeNtieCYj9TNHjU80C36oH9Za8o5NGGxQWn
 rI8j4rcOf+TTfKTnHGeXt3AephsT+RD/pnb5tp4PX4mvPueTpJZDHvqo63/oY8dU6hNI
 fB5w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783946459; x=1784551259; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xRMSmlNH9dw4Siso9J557BKyqFL3dY0XbhdZRsijzeg=;
 b=NWFQGBpUDX7azcOQI/6c3ON3zxrsvWusUYa9kny6V2ytUL9uIe3WDUqwMUXqdv1FMx
 wPsKUvDqca4Ro9u7C+oZP+DnyDIFncMCotY+xZQIPOoYgCD4LordMOHUxAtr834K7fY3
 QYTuB4H0yjq0Mt52Se7/evVtrtKeX7KPO3GcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946459; x=1784551259;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xRMSmlNH9dw4Siso9J557BKyqFL3dY0XbhdZRsijzeg=;
 b=AbzIleo/2763ca1EcJyDOuqrdeAWnJRtnK7KuOcHjp4Epwv4rj6x8VvRMVvu91C7+L
 2Wot0MJj5cNMJcDdF3igrnMEQ/IDuuSAtnRn83tdD9Rm7KZ7Q/goVw3QWgyyxW5PDatq
 sbYxdBzM0g4nR4BadEE6NotEV6+ptASisBJU6Hf5n6Kk0q7LO1nYbptgAS3PFo9E+8c9
 eGajtrHlEIw0AHnCmhP9YW+9f+z8jTNJv/08FW0WG+NrF9EILv0n4AH1H1SQoZDRx1up
 PtCxtRJG/XoxEmEQgx2A7kIjUdkaYd2BpC1l5nrz5WXJfucbbQj0xPfg2/tStIVUVMqq
 tbIA==
X-Gm-Message-State: AOJu0YyY5MSfeSnVbbJtdWOvXw6vR+PM9yZx+nu1U4uwFf2YQ+3neM2q
 61EZQC5Uw2716Iw7fsTWmp+AhmiEbE25ocMQhMsdoAAeK6o5HiDZXEGa0zAZqcJh7T3XXlvK+1N
 t3gkbEU3rGJj/3oZ49TAmjH4mbgLXre45dgLTzgff
X-Gm-Gg: AfdE7cle73hpq+4Dr9fQrU5JRzuqEPpxJ9+NjCLvM/bITSYCs1fyre73FsSogXpZ4xt
 kL94MznMgV1uTrB3p3NDsHXTfylP1J3mR3CKc6llaXWttKvif7TlavA/ri9KnUprL6LlN+8TO+n
 +mxeegOMDAGV27OwfIUrUX8UcyV71cgMWNOsuk0UWRxO3Nk1SRenC7RFEpfuRHcbMy3IzLM7B8d
 zeFNQ4ibVgJbjiRKGZ85F8ErFCtxxmZPPTIVjh9AN/49arrwFK1+8EW+AofW5N3vSh4kYE=
X-Received: by 2002:a05:6402:3511:b0:69a:9355:d1ca with SMTP id
 4fb4d7f45d1cf-69c5f24e448mr3931593a12.42.1783946459157; Mon, 13 Jul 2026
 05:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-3-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:40:46 -0600
X-Gm-Features: AUfX_mx2iRj8tqCRb8WFJQdf4L64CHSK2ck7g_Ekw0X1C5zD0aUfwZ5jnHD0niQ
Message-ID: <CAFLszTgr1p7GHEsdBG2ASjL0Vf2KDDzjji3=W49LVkF3wkng2g@mail.gmail.com>
Subject: Re: [PATCH 2/6] binman: x509_cert: allow and parse distinguished-name
 subnode
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Rasmus,

On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
> binman: x509_cert: allow and parse distinguished-name subnode
>
> Currently, the ti-secure and ti-secure-rom types hardcode the contents
> of the Distinguished Name section. Those values are not necessarily
> appropriate for all boards that just happen to include a SOC produced
> by TI.
>
> Allow placing a distinguished-name subnode inside the binman node
> representing the Entry_x509_cert (or derived classes), and if present,
> use that information.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> tools/binman/etype/ti_secure.py     | 3 ++-
>  tools/binman/etype/ti_secure_rom.py | 3 ++-
>  tools/binman/etype/x509_cert.py     | 5 +++++
>  3 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> @@ -61,6 +61,11 @@ class Entry_x509_cert(Entry_collection):
> +        dist_name_node = self._node.FindNode('distinguished-name')
> +        if dist_name_node:
> +            self.req_dist_name = dict()
> +            for pname, prop in dist_name_node.props.items():
> +                self.req_dist_name[pname] = prop.value

Please can you document the new distinguished-name subnode in the
class docstring, since the entry documentation is generated from
these docstrings?

The ti-secure and ti-secure-rom docstrings should mention it too,
along with a note that it overrides the default TI values.

Also, this iterates the raw props, so a property with no value (a
boolean) or one with multiple strings ends up formatted as 'True' or
as a Python list in the openssl config. I suspect it is worth
validating that each value is a single string and raising an error
otherwise, at least until the multi-value support mentioned in patch
1 is added. What do you think?

Regards,
Simon
