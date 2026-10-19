Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33935CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEDE681155;
	Mon, 19 Oct 2026 13:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j3ExWg4g4mGq; Mon, 19 Oct 2026 13:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3850981131
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416805;
	b=HLaYOlN/Qq65panIVYTD+YSYNB4thRkSWy7MzK1XmQdMR/Yv1Ql2Ex8QEaCOAXs28qZo
	 Frkn8F2Fubxyr3ooP+PVcKKZywB8TAEuJ0zEIPTq2xez+cCv9/tmbySyJyn3+/lEgxWq8
	 vJeCvY83Nq0CpSCU9n1w9rIlvLuLIv/Rep5FtOoa+R0YR9WPxhRB8XuBy62mziiRJ/AF8
	 U4eHK+s7DD45S14C12OWEqdHQ4ODoYMDt5sJix/DuQ0t39rboOIZvKSXRrAxiYdswH36e
	 DNTTlcftvz6N0c8HXElmFYhIr2qnTo9TVlMQtZNnpiDnEGPEP7Lrt9thkmKxEi3711A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IGIQv4p9dwdXV6X/F2yzQpJlXfkcDwQM2T668kaA0nE=;
	b=QNAnZYNZkfjXXVZT7g4ClzBDX0SE5TVvsIK3Gxr6IXVYRpscNurIZhoO+jWWwvfZqDFt
	 9zu2ehlmDFLt5Xp8Pa2qGh9wzoVr//bIb7k/O//6e/kmi3wfxTot3N/aRTdabHVScwFnK
	 qVtiG4MLY6uRHZ0nqWNsX44BLZFl+iJyUhA0xs/qsxSXgSj8MQHJgqXOVoGe6EcrasiMS
	 9NKWRQDa0j+Nz8YaWWo1nmu2R9c/RyTC+yzxO36nrch2WepdL/pY7ykILmYD+eHmsoZml
	 cIzzY0FPPKA+UAaRV4X34WSOvxDVxpc14sT+VczzXMj2XhAGB5CpJmCF1kfN9Cgs7QA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416805;
	bh=IGIQv4p9dwdXV6X/F2yzQpJlXfkcDwQM2T668kaA0nE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r7fCxTOQWgW9Ggqa/ApHmIP2z36EAF9yAaP81bVhFzjrZOw16o+W0YzXdu5MuUedH
	 h0KGEI+GLDNQoZDGVibLnIgvdtqN1xlzuOqvt52pCd3uPFi9EDciSUFLHNmRUhWI/M
	 JGu1mXFKfhhjE5pSnCoUKz3VtHhlveBwo9zuwIrTo4i67Pjauf3KhUcJoizvAzn+8x
	 eQG+nUlX9pCBkW8J5uxc+Jx9TQd/pZM2vOFxWS31YSS2wSD85zUE97AosP9pjd6BUg
	 4ytDbshucpBo7EF3A+o/nIA4siVuPq4o/UgwQplSYDpdLnrv6UG0mQnUEgFcQjnmOo
	 xdzpj8DRe0Xvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3850981131;
	Mon, 19 Oct 2026 13:33:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D09D2263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6C8440670
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUwGsu-KmtEG for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D5C8405B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416802;
 b=CW7zbZPGGqldGeasXrrxPwc7q0Q5GPz5nySkZmv8IxhZhNgef2FyAEW3nTJc+skyJ1HP
 iTk+G8mBMxcmdx1JzI+6/V7zUMNI75HlGbbL+0HGvKSVkFQybbdCmS943LZr/tpFZS11c
 RvPXZbqMkMSVnJJfK+fKoOeppF8H4nbz0HZ64TbbZsitGs7EEKlaJ3AuigKkalCCDGymP
 /YgZE0TJOmLsDBfdE318xocMDyEOsDSFlTqFkG84MtAI7S8h6bnSy7X9jtbUC8wpcjwcW
 nINyPh0/rM68DVBP4kGhrE9jkC4TYcbZcK7+Mr52zsZz/Lti/XRAeMoJ0tLksZc9i0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416802;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=IGIQv4p9dwdXV6X/F2yzQpJlXfkcDwQM2T668kaA0nE=;
 b=K4EFxFvWbBHZws2/REgYk228WXLCIC/G4p33B74Wq8YuIC5yYbaMjJ1lxesL/t5bHC3e
 Bg7p8+qQBQQizUqOsLJOCr/n0UPZic3SJSkA/iTv8z+FhRCMPF/PgDRiX9I7+wAA92rBm
 arTORDnqBRw6cf48xQTcpQcuahjiC6WBY20MNgch2YkAqj3q840CNbhz3jchPiWzKnwWE
 2eppov1mi/eugppRLhn1gumLW777tVh7d+U0D1qzFw+LAtSYIVTC6CFTlEUebo6pLC6a/
 x+2O8OQqCr8uqic31vCU+s+AdTuzHGmcLb56YuTUOCCwRVTgMIbdsWxuUhALUxuPqbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MT6egMA0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MT6egMA0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D5C8405B9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:21 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so643320a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416801; cv=none;
 d=google.com; s=arc-20260327;
 b=UiCnfDrSE3hsSCuhy3V73xdXKSp7SKsuLbxfFmb85P8/Opp2YD3X7FBz8vRhC9vIAR
 K3Gsbp3JDkOKU1rVRZAaq760VqLWUdcbjhzDxlRmKm9eAmfhf1RZjZfllLngfXDNZmfR
 Qo5CJuGX+arojSrj87Z5qMunCFIMeGTbI1gRVANxuXOP/LCn27UBM/gx/I7DV/0jy27T
 IB8Vt3SuBHZgh3GKp/AUpzNxPLUcmQowwW5tva4smezzFL78XZM/XMqvFShFli1nzBfo
 UfY9XQQcTdORSVJO65BvSbiYsT7nV2uD2p4itZ26S+MRDc0B+lP7Rl8QWGy5SaHlHg27
 pYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=IGIQv4p9dwdXV6X/F2yzQpJlXfkcDwQM2T668kaA0nE=;
 fh=i2tQHTfbjxCsmvhnoxB9qnRhfzM8iCx7s7bfzE6Yn9Q=;
 b=nEcYzbDsT6AUT9ipWEGaiXvii+kwCUlY0SXEiQhIghSUPYE5DsZ21oLk/HFOSQM61g
 fRL1DBDiJrKfgZq4bpuEK/7u41EyTZ2neodptG3sF6OAuIPjduqoSSeBwKiCKvzVqFCU
 pshRnIfg7DiOWt3J0OVP8md4mh09KjM7UYsNC9h4MCmVgjt0Vb7wJjGVuflYjKSCFaO+
 uHjlZP0pORXVB8XAkZyxHCfhHkKwkKe+FWJQPzYqSyDha1Nlg4AJC0/K2fM9N6iHnz2+
 A5KVqNpx6ZH8AdaHjXUggeKe4WEYnnJjfm7gCwIuJZTJdnuzmsZ0XAn1ly9axsPo+UlT
 vHPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416801; x=1793021601;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IGIQv4p9dwdXV6X/F2yzQpJlXfkcDwQM2T668kaA0nE=;
 b=MT6egMA0YjA839d5we74tkvNShcEsVsQtW4wvVxbTYX/q88dJ3GpRkT9Rwthhywn0x
 OBSMroYkOL85znrC4f8CGlhXC4mxOnzmjWSgEyNoqb3SkOIgTd2W1h0ftjauVyvKz3/x
 TbX1CLYNIZ4wM0I66pFhWlj8eY5fg5XVkcPjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416801; x=1793021601;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IGIQv4p9dwdXV6X/F2yzQpJlXfkcDwQM2T668kaA0nE=;
 b=i3lj6xWyvDCTLi6Al9I5pUTfmz7wlDFeGEmtaijUQJHEMDyryrAKsiO887mkmJbm/4
 d8rdgFTF9Fks5OFsWgK8YoveAPXmXF8du9azI9y0lRheyNEV22CJcp5739VopzqtHZXh
 L3e5+xilcKs5hE7AECSPnvm/8EZ+6HJXf191119nc4yxGTYMDFfwY9iSSe6d1f9yr6RJ
 owlt88qWL2uGUCqIfqH+vh6Jt6t1B380C3qPicpDtv74ndA0voYQfyjc48Rjff3cot2G
 4zHqR1I7HCRh+EsvOQst4bhnTxi9Vi+8I4EQ/63gy0JxkclXj9MTDKZXh1689/vmn9R/
 PGIA==
X-Gm-Message-State: AFq9FYJUqish3z1+NORziqkAuzKnr0MDKKOJoDLvxK+ixoDxyofeh+Bz
 UEnZoUiVqQqoM/0d43kBUG1OYQ/20GlDzaWuJ5dLnmuSgE0nmytId6LK+JuWXGrvUnPaiDlbWJv
 LL5MReDPzxfdo2Jqux1mcGE/4jhstoejC0mZXHvjR
X-Gm-Gg: AYBFou3FIrNKATG/5s/RPMAJr4J2wWVTQrB2LjewrR2p2I5NQVRcLeR6cL3qhBwon1y
 QSapj51D3ynQ2ZYH38VCeragCweI24UvLNNOSwrQvKT3w+FS3VtPOfwi1Bib1qsQVtxDiS4BjBM
 1LpPQmdPrKKbktWAtitx179NyUDpBVyPVx+9xxpwcNvNi4y/TnhYSVMC3l9ginrEHBMv8GpFIlM
 BV4LFAE6BV2RL1gd/EGrxSKhc/2i/WFyYsvM80oqxnm731WQaPtrFUHySP0D8YM3lj5fi9kma/V
 FOucxtc93n3cYFxt0ug4zwwno98OXm5D/Jdon1x0OUpEkMLR+mzjxQ==
X-Received: by 2002:a17:90b:3c8c:b0:3ac:7449:40b4 with SMTP id
 98e67ed59e1d1-3acef5060efmr6639176a91.45.1792416801057; Mon, 19 Oct 2026
 06:33:21 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 15:33:17 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 13:37:59 +0200
MIME-Version: 1.0
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-2-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
 <20261016-ccaione-upstream-fdt-fit-v1-2-f6286ef82364@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 15:33:17 +0200
X-Gm-Features: AclHuK-6Br7WbWdq7egRKmz8JZWNZisrQQMFk0mDJ2DbwLuxkhsbUE2hFEUz9X8
Message-ID: <CAFLszThHbn9Rkh5xZ4u960tdarVoeOcVyBusbRPShzj0mA2gfw@mail.gmail.com>
Subject: Re: [PATCH 2/5] boot: fit: reject configurations with missing or
 invalid overlays
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-16T08:36:59, Carlo Caione <ccaione@baylibre.com> wrote:
> boot: fit: reject configurations with missing or invalid overlays
>
> An overlay listed in a FIT configuration is part of the requested
> devicetree, not an optional addition. Currently, a failed load or hash
> check can be ignored and boot continues with that overlay missing.
> For signed configurations, this also means using a combination that
> was not signed.
>
> Reject the devicetree if any listed overlay cannot be loaded or
> verified. A missing image must be treated as an error too, rather
> than falling back to the default configuration's base devicetree.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
>  boot/image-fit.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
