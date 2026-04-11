Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE92F3ED59
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 17:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1263D8416F;
	Sat, 11 Apr 2026 19:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ie9U20uJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A4CC8418C; Sat, 11 Apr 2026 19:19:18 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D52183DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 19:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-66bb6eb28acso2880150a12.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 10:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775927956; cv=none;
 d=google.com; s=arc-20240605;
 b=F/mNn8B51uIQVcsc6/VujmBRb2mtI/givHsAnavoSkwZe7QfDid+otYF/kf7KUxHmX
 EulOx5QZjTsdgC5Oqb4Rh95cQZ9s3t1EmuCTvHYwwSPx8a3RGFM4tml8A7Pt1u7xZLVy
 eyxSpKPOExKkwHrIe2DS5tNNjXUO54b3ujiso3gSx88ULnNV144iBmrDd4eJ5VtAD0dv
 K6YRmV3qFpehsUWXmfUxghbs6cYtShjpp7QD41jgjjr/3feebvxY/CPmbTX+zfgUeNEm
 W2w8pOZZcV1JBUqHi8gS9ys1er5md9e4sKXB67dzvl8o0eBI3cob01xLFsKPDjxC+QtM
 wHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uwHdEuUmYdTkUEqEhe4i+Dd0txBfGieN/qaioveKL9U=;
 fh=RvSU79DiZ4bHpSNYYfwBgNgCzAZbCwEaePHR4DnxM44=;
 b=Htpqiq767k9mnI+L2s82WOOCbMCn+NJ00rFp2BUAPoi6MiA313C8AVpW0Ru1LGC+Jl
 xn+Xtg5QMq8bWOn8d1iL38fgQ6QH81rStu/Vnx0FiI5huA0E7CP+PNyCjnxZbvtVdM4Q
 WcQKi7VBPb3fZb0CQsxrfTuSW+ltB5XaM1do/FDZVwOYhPV7CZzYr5Lav8oIKy2PDfH8
 8wuEyWC4lnS79BtpxknNHIuzXRtsidnT2wzTDAs0U97D6Lep3/Fq3mx9zMvHaTjbT1fv
 GXLlhUOUaDnGOi+IsNw6/OYnm+zv3IMoJU/LZK6dDqRwlvlZ/FC9afj/yYMEetsr5TLH
 LOOQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775927956; x=1776532756; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uwHdEuUmYdTkUEqEhe4i+Dd0txBfGieN/qaioveKL9U=;
 b=Ie9U20uJPciqBzhBumHJDRzltucGd26+UhEIEhjmPme2QeQgvHkRRDQ7KYUWNyAXsb
 mqqo6LyY0sg1ZFxWoWEfjLuuJb/gBarQ+yblBDOAwxs9fwM9DeoGhpg4zojDIeU+Ks/h
 naLGHwsn6SKC9mPOp7m+2VaMvFqDpH5p/vpyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775927956; x=1776532756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwHdEuUmYdTkUEqEhe4i+Dd0txBfGieN/qaioveKL9U=;
 b=FVuZaPs8xXHcAdKtJcPYvcWn3ellTeKSgCoqQLuIoeAj6Q62fTWMy0Hq6J4qNF5zU/
 Fbx7DSZ2YkMsbIubXGyRzgDH3Psm45kvn/IGoYe1gtvFDiKq90WkZYoTUe23lM36NPIT
 SMSeTDGlgbwomRX5mv5OypaDJxHNTXk/NvalHOZIsjLmeEvuYJChSjUp/FgPMENqRQZT
 OS+tXthuHwUpcgM9SnLwy3Ii/ZPFQl57AT+8qWGHi0sAMmvzNvd2ggL0OycLDYV9d+PZ
 Z95ke7kA02jw0M+2pJzOCnD8ys1kfN62dkTkWgIr71eoEcy7DH7hqIcoQ18jYDKPbvxT
 mBQQ==
X-Gm-Message-State: AOJu0YxaKwy3Xk94Iq7e3lIeBHuHE8CGKI07jqzV0QM2reLL9cg9UCT7
 0o8kLlwdJY5sLpp7yBLBdvtPQMGLWJT2Kl3jQ9B3AMPygpCPkOHJ2j4eX8jHunMLmKw4OQY/RS+
 cGkE0YwHczesEBJSrY3JN2xYymq1kc1Hzs/rLZQLj
X-Gm-Gg: AeBDietYvBG37YGut3V8wGZGEOmMtsHkOXrIE57N57GEDgNMNhta1IwnEfIxJP98SyW
 JMrjYfY17NzgIyfnlHNsWCKJxXDiDSb/A+aoT4KC9ulWS827DpKORGPSMA7I59h/B+WKdA7t6j7
 7U7bdLNYCmWcp++gTu6EizxBu4D4e+enLYGZGosgaj84XjHVct93JIPf2ou7agBqsLzu3ZHp2ZT
 R5/KYj+AFp8eJa6mcwp8T2NfmDFFEfggmoFVBnrPz7VdDoEU5qZrJOs9cfZYW+0MMc6YAyd5cZx
 NBW+Uw==
X-Received: by 2002:a17:907:1b1b:b0:b9d:3c22:b2c8 with SMTP id
 a640c23a62f3a-b9d724f0c56mr466234966b.1.1775927955627; Sat, 11 Apr 2026
 10:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
 <20260408150201.217942-1-paul.henrys_ext@softathome.com>
 <20260408150201.217942-3-paul.henrys_ext@softathome.com>
In-Reply-To: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 11:18:59 -0600
X-Gm-Features: AQROBzA4_0iUGkFjiae9iF0VUxV5yTMenITg6Jqu5_eyoleQ6b15165Lfn16Ol4
Message-ID: <CAFLszTjgtx_jPjW9bJh11+kgzJd9i0Zchnxq_JY1NMW_UrA-og@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] binman: collection: Set build_done on referenced
 entries
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org, 
 trini+nodisclaimer@konsulko.com, alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 yan wang <yan.wang@softathome.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Yan,

On 2026-04-08T15:02:01, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
> binman: collection: Set build_done on referenced entries
>
> The collection etype uses phandles in the 'content' property to
> reference other entries. Mark each referenced entry with build_done
> to avoid rebuilding the same entry data multiple times.
>
> This is important for cases where rebuilding may change the data
> content, e.g. due to timestamps or random IVs in encryption.
>
> Refactor GetContentsByPhandle() to return both the entry object and
> its data.
>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
> tools/binman/etype/collection.py | 8 ++++++--
>  tools/binman/etype/section.py    | 5 +++--
>  2 files changed, 9 insertions(+), 4 deletions(-)

> diff --git a/tools/binman/etype/collection.py b/tools/binman/etype/collection.py
> @@ -45,12 +45,16 @@ class Entry_collection(Entry):
> +            # Mark referenced entries as build_done to avoid rebuilding
> +            entry.build_done = True

Just a thought - have you tested this against testCollectionSection
and testMkimageCollection?

An alternative would be to set build_done only when required=True, so
it happens during ProcessContents() rather than ObtainContents():

    if required:
        entry.build_done = True

What do you think?

At some point we should try to come up with a better algorithm for
when Binman rebuilds the contents of an entry.

Regards,
Simon
