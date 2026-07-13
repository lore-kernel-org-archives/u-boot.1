Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29785C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB7684ACF;
	Mon, 13 Jul 2026 14:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JNpMje2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E652284ADD; Mon, 13 Jul 2026 14:40:44 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8534984AA5
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so4805833a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783946442; cv=none;
 d=google.com; s=arc-20260327;
 b=cpRQonLKrwk7oumGfB1Ok10vSE/lw9CIC6UjrV/Eah4uiVAgvUjaAH8ZAE1A4ZszWZ
 fxAYbL7WP70ouje4H/6hMkANHLVGKvEh+rOeSTH5AXrpohPKitV9lodxYyriVsp7S0IU
 M0vwqkXKNs8TKCGHvdhn1RrsJwtJzUvw9n4pWmUGZXRBLQ/ViZaaqmu6dOdan4iajF3X
 hkcU5Ehr7+QevoNhVWSjIN9w2uh3xwaVrCSQEH4zURVTEUTm2sRSANgizpLpNJmtAupY
 wxBU1KbiETgmxCxDYYIM5BfkZ01DdHKsSrDklr5mTghvNvNiCmcVrh3sgEKe2m1I4LqW
 TJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A1zzPxeXWYRnE1dsfjHudSrOmviyUquuIRfFXWw+4ew=;
 fh=CcuDZmTrATCCWiOVlvhRNk3dyUsaw1UrvxWB/NarpSo=;
 b=W9eM2Bbpu0bsv93/ijvb1k447GxETpa3Y9D4jl+QbJnsfQnhHMCJUqj5wcPsFrcjnE
 /xmH0BGX48r+uMaMpTN5/0oRfx0rQX3nX1hyTpgP83Bun+7cvHQOL3X9+sXSXMbZwPSj
 9nKSBW9ZXmaxHx6qRvt8JK5OFFCQYD0/2DTbKtQ1bRzWzxZXi6KX1hElxIsumjYSJJo9
 Ns35x2xeClYNpKuxIk1kSn2K/hrWV590FNeWuaF/WPtV7IGHZ60LI6ZEFGWwf5gQ3O1V
 UXlf1flgdygo42fsQ4egG1zqW5rL6tiwDSD/PHF6tqU4LbBHNY2dmCtZfJKFjhlXqmX5
 aJ6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783946442; x=1784551242; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A1zzPxeXWYRnE1dsfjHudSrOmviyUquuIRfFXWw+4ew=;
 b=JNpMje2sG/qOE/JJ2515Ik3NAjeDdexv/lN0q/ZBxsX60AMaTE0fv6uyU+kimVJsnr
 D1YSQfulOBJrpDGmDmkuCOgv1P/X5ONki7GgIC9zlf0OjXBVM1IDkrVtpLDxwtse+Th9
 V5+HfHiWNGKF+zGZhEZfM9gjfNBZ4jcc7bDcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946442; x=1784551242;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A1zzPxeXWYRnE1dsfjHudSrOmviyUquuIRfFXWw+4ew=;
 b=HFRuI7cosPDekTW1uqVrppZGP/IuwTteRevp7y2jOWzWRGA9ppKl+fTVk6LxEu3wxw
 NxQxGebZG1bbV/42dCe6Ivbku/kzUeJa2pQk1E6EgpV4amEn50sZ72OKHAHT1GoaVovq
 llx8izJVKNaiI3QWXKPYTJ1g0mCtHJzcqenn64KpYdxCj3iTKGKvU2tJFcDQ1mXUfBuI
 iUnQTVKCfcWeVJwrjohbXi/6hDeyURlWQ9ir29E85w0yGqqm8QdG8/2xZOQr/ATYA9Pu
 oPxDmAPkuJ2RQo3/vs9L2KUVrjTD1E3XcCs2x6AvnkUx1SGkyi3h/oLlfeXvF+85qBMz
 YQDQ==
X-Gm-Message-State: AOJu0YwAvrxYHMF76rv83AdK4W3xtDeRxBWuW96HVLhYHSuiG9ItsOGs
 KNCmlvVwshnO4tPdOtW1hZdEN3MXuVtPTF7CQKkaX6WITScpmYJ8dDiLaCyOpIKg+5PlusaF4Dp
 /JLbVkbxfjlR+u5qQZQ5d3QabuVVNfF6Za3ADNsakPhI3HfPuf30y+w==
X-Gm-Gg: AfdE7cm+rxkYCvI6W473Z+IXra4J4oG3RPuRANBhgh9IIHUdKjmu3bpfNAVZK4v0z7O
 9J9qzH/Ro16HBWw2+PnkR4QiiGgPL06MBCBXJaptXcLgrHzRYl7nSkfk1YZyTwJMVgakGsba4Nb
 SWWr1RQObYagHQD7ByrWg3E43LHQlPGwxnmlC1hF8Y9uPLsQEnXvey+eYiYRatsMHerd02SU0Vv
 Y9bQ0tHlvPmdQz12P8tiNCOa+aiiQAjJk78mTfza38vHTLXdebwkBADDdWojTzw87OWLjNsW/Lj
 0B4pWw==
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr3831509a12.0.1783946441979; Mon, 13 Jul 2026
 05:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-2-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-2-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:40:29 -0600
X-Gm-Features: AUfX_mylgc28FEeV0ukGp8g0e88cuIMSOzZScCa6lVBlcjpd_x5gCP-MqHIa6Lo
Message-ID: <CAFLszThzh=i-+CdPs700saHEHGO3zM+qaO72ZRj87GyUGMgjKA@mail.gmail.com>
Subject: Re: [PATCH 1/6] binman: openssl: refactor creation of Distinguished
 Name section from dict
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
> binman: openssl: refactor creation of Distinguished Name section from dict
>
> Instead of manually expanding the req_dist_name_dict, create a helper
> function for creating a config section from any dict. That will also
> automatically allow other fields to be emitted.
>
> Eventually, we could allow the values to not necesssarily be a single
> string, but a list of strings, e.g. 'OU' -> ["First OU", "Secound OU"],
> and encode that in the config file using
>
>   1.OU = First OU
>   2.OU = Second OU
>
> as documented in 'man 5 config'.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> tools/binman/btool/openssl.py | 44 ++++++++++++++-----------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)

> Eventually, we could allow the values to not necesssarily be a single
> string, but a list of strings, e.g. 'OU' -> ["First OU", "Secound OU"],

Two typos: 'necesssarily' and 'Secound'

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -36,6 +36,14 @@ class Bintoolopenssl(bintool.Bintool):
> +    def dict_to_config_section(self, section_name, d):

Please can you add a docstring with Args and Returns, as with the
other methods in this file? Since the method does not use 'self' it
could be a @staticmethod, and a more descriptive name than 'd' would
help, e.g. data

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -36,6 +36,14 @@ class Bintoolopenssl(bintool.Bintool):
> +        if not d:
> +            return ''

At this point in the series no caller can pass an empty dict, since
ti_secure and ti_secure_rom always set up the full dict, so this
branch is dead code here - for me it shows up as uncovered in
'binman test -T', which requires 100% coverage.

Regards,
Simon
