Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5022CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A9BC6067D;
	Mon, 12 Oct 2026 14:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5eFQ_lTSTs9l; Mon, 12 Oct 2026 14:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1E45605E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813717;
	b=mcHuZbKx+e3lN1e0FgXgB5wgzH/zFUh5iol1MPJH5iuk65Hivup7EIABDlpygaCNXi+R
	 1TX9473lkldcXbqLLFp3LYxo0WaXoTmza8nMiqi0B9cqOoy3XhuR5RWIOrr0CmfAflbmE
	 eGKC4O/0ee+JydsjzI1Q9s8gOsQAWnNn7jB3bKJwT8qKSST5Qy+QO7K6GexOkbFqrkt2K
	 TA2Q/iGWhwAh6RQqAjQIx6RHaZx9jHDQXC32kVO3WWh3hkkDV1em26eM+BxMbbQFNLGwg
	 7UANHVsem40wPouUnlYy3pZ9t+3dGTe4622DdBjSOhbF7xFTy9ZJjo71BE7BuyNp30Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oIm1p2Zo8ADj2C2Ob/2DJ9EL+ZHDC1b6knSQTmiZDSY=;
	b=W9ob2M199UrBeYj/8XkbfUPbDjcXp6dqzd7RyzZbg50Yr4aFw2EeoVfLKWRGZnVdOvBS
	 WfV+IJZvzG/WqzKvp9wnAbX37ZlKB60S1E0RuyevOvKiO3pQJh/Qou1IjSzmvDGXPumMH
	 4uqLPrZ6vlLfzL2DtnhiEQJh3M/l283cbIrAM4TvDfoDHbwBTq4C4sfl24e5gkHxyALKh
	 eK/E9q6WstT15R1dXaKghkSbQ3qVf2jl6bLgzC5kHiWrSoYfNdlGuTkOObnOXwoYnGDZJ
	 +V+UJm3zFTEv0q8vXVyzRiuBJYUxlfZQ7DQOB/yZ//uSgxyNzXIi7CRaj87vJT352Og==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="d+Mg//F4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813717;
	bh=oIm1p2Zo8ADj2C2Ob/2DJ9EL+ZHDC1b6knSQTmiZDSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ewREVRWDMc3yepeW+4BJV4TM1E7u6l1SJFXdx5l7+4l04BUd91Wx5N5bzehK31CmV
	 qzmsAsjrWQe37FvALb++T6/XSjYxU/jT/OmcPXsdUF2SH11pra2o2cQ2YwwufL3JQ8
	 rx8ooBbRpzn7m1k0+kGOcUuqhcNIg1a7QVGnKudp0P+B6YVzmZiWFLrxBxLqrU2tyg
	 3QdrqfXNgBsH7NRkJmKaFvOR3Zkd7gdxHyG4Ca2pvHE2YhRvk93+52HH3zw5T6mlQe
	 54d8pTqxZG9DVMeDni1NWj9XnOC+gSFj3HZzGmsSPE9yawbs7PCAO/UF2MyqRSQZOY
	 4qcMESDInX16g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1E45605E5;
	Mon, 12 Oct 2026 14:01:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D086E179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C26096066D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDZuXRWY3IFf for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B4D6D60664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813716;
 b=r+8vm7Eqt7nf4CTuxTk3gA8gP9jB0bEDrQYakYOpGc2G+/+GWZPE/mY/xyNnlYXO8nj3
 tV1z8HL2JBkSLxJCuCf8+SfN6RFNdyOuNfv9Uk06UqmzpeDAaGURB5Kn5xwFMHj1t+3dt
 kJxfChLB74mlEcvvzh2krJWEcbOW0wzjzzex7arclGm3+ifIPPq0Ektol7XWTW2dWH04L
 6okpjnVYz6BQk7AZcEkFYD239vYLrXayJ9j92DZfiaAuvXv+Cg0MNpU0EhnDw/BWtc04M
 n0WoW79fixUO6g9d9YJrPf1yYKIW+Ng+eqEQdHdugzpxY2p1Bx/hGWRS1iPCvelnzlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813716;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=oIm1p2Zo8ADj2C2Ob/2DJ9EL+ZHDC1b6knSQTmiZDSY=;
 b=PJh+Q/Wp+eOotcuJhO0kGIljxs6M2BP/tC8V1C8tHfPzQVAulgKd5HSAKx2IaK9xs0Rw
 q/1DLZLnPtNcjxzDZ6wU9gDUTDfnjGbDScO8kx0SoWjthHTCqccwTwoxE9D6o/Fo+RXBQ
 ObDGqo5j/mPGN7EVU/d7CHEFnF1eYod/e3bRoA1GToTfRdPoDGdvPQcVolMkwBYGytF3K
 RTxeK2CZm+TWUh93H1l+GCZtsEugzVP5CwHL2ZSA+b3rmwjkCkUF6qE7ofl2G76KeZhc7
 H316pyNv08Qed+q/gTbkogh6AOdhmf+EtTITsXUAkWGdyGo1L/9Kf6GNNlTkdHfm5Ig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="d+Mg//F4"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=d+Mg//F4
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4D6D60664
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:55 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1cc392d8bso876528a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813713; cv=none;
 d=google.com; s=arc-20260327;
 b=b/knS86/OUbqL2BZI1jBfQxC4veUQTvuz7KqVlTS9HpH1M1kVVPsDem3tXcsaIwO5R
 Jp6fYM0iWu3cQsJPHD/iUKcMyRVKx8BuTuzpJ3k67XhHtCnXRLnE77OkC774lThhvShH
 0XjX/sqB4nxWXlYpFw4jaqE4R1H3NOTR+ydjNrBhpQastpYS1MZhiqPYoNPt+49ryN+E
 v9XxHS1MhiMAEWgnluhpB9KtDtK+qUfZmmaw4G9Ky+YUshPRvPArxxtZSTYK5Ahu/t8B
 yYPVm4ynzkyIgEzA2mtzHdgKYUktOOP8qQCjfeFwk3FkX6Lq3j/yZBldopX33m/RMx+g
 KGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oIm1p2Zo8ADj2C2Ob/2DJ9EL+ZHDC1b6knSQTmiZDSY=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=fgM/LCgvW1uUwjIXYjvN0IGUQYND3C2q9UQaPjiMvrdhPhLeYy1lpU/maZQJr208h3
 xGb0p0L93//BZs3Fw6fl2DrmLWRZVm93giLFLdbclZpCbvcW9WIKWkGcbm+F7WZEQ1CA
 TrG4Grl7juNe+71CbuEOu5tVUqhMDtn6+0W/XtIlZemJFGfZJ4mxO7km8qQ2W0owJ4gH
 e1lT93ZwvH8LUWuEnmZ0/zNv3X9KmYV2rsAR7fAxjMfBb0Se0euWklTOVvfj7l2sr6Wv
 tLJjwZb5nFYO5Dt3wPsnAGBFtDNFCGSjy4QzT3Sx9qRPPMZjVZ7v/Vf0CE/EbJNNGBSU
 aeyA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813713; x=1792418513;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oIm1p2Zo8ADj2C2Ob/2DJ9EL+ZHDC1b6knSQTmiZDSY=;
 b=d+Mg//F4PlwlPG0z1UC5aAIsP3zYorXWbxEEHOtUyYyAD/PjTt/194P7ZhrPFVbN5u
 cWvXpC164q5S5zTzlP9SpYBioQJF/wJ5YaT4VJ4K49uhBNDsIqPVvzmCZghpbqFWgbO+
 IvNkKtqcJUjdd6fL8cN4O6aDjXxotEir8Og3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813713; x=1792418513;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oIm1p2Zo8ADj2C2Ob/2DJ9EL+ZHDC1b6knSQTmiZDSY=;
 b=capwSrAhPs5CnE0pzS9E3usIogt3J9Q5ZQxfW7T6Iv8VBRp6DUe+h9V1ptuoTZGPys
 YKNAqADcYpZ+M/D+gMWOfsXmufqcY6cJPZahR1T1ahIk/CENfBl8Ily/ABpbFjgzuz4P
 7MnT4jY8d89/eP68QgDApMw5cFcI2TieeYTzWPzMXeF7a4gCQLKADktDvhg1+doFFIec
 51iAXWBIHasyozZ9t2yQNSP2inkhv0WfkQOOncfhOz9DMliDJdoa9aVpNzYcv0fMHgUy
 Hzb0weVaEG/QSXlJ4I+XUBvacFxUlWd3jTkAZT9tan6ec6/eNDZh9mWnT4IOARBgEaYa
 0dRQ==
X-Gm-Message-State: AFq9FYL8R/M8jxjdjwGKDWq84XIBUIwYCTkNHPXSyQMolzMY3Vrf5RvH
 ctDHDaU5/k1oKX4m9pZfeNBcGpkjcDw176n3dBn9w9YM2qMkxmFUK89hsOPWHCGgBqflZLmf40z
 qmSPo1eyPDtelNJMU4dRfs/Jo56ID73OhNGyfb+6u
X-Gm-Gg: AYBFou26OsL/60iVByVo77XsgVbbk0ItfulxfB6Shp6MwJrLH1itMLcd9/ESJ1SLbLJ
 WPv53wcGC91QCR7f6IAODy7cgpGYYDA2qVz5Kav1BeUQUDIv3gbrw7KhpRNQdjbFc5TY+/n6Btw
 cjG9vijoAo07NlGQcJh/yWOnVrwmB761qgB/9EC5qfu7eydKV6ZAAa6en/Ki8qLoUBdKMpX+gUW
 1Msih5dIFLpyIFtsf19RubgrLJ2JIjWeIGlvZrbo8VbfA9j7cxW3J4bxsoJh2XH1yFth9xCqbQa
 AnqjIcKoupNBvFRM7zLfGRjEymaEtUGJhCiwWUxB63nWAe8gsriOpAA=
X-Received: by 2002:a05:6402:21c2:b0:6ac:404a:51a with SMTP id
 4fb4d7f45d1cf-6b17c21bf8bmr7290434a12.6.1791813713232; Mon, 12 Oct 2026
 07:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
 <20261010-b4-button-live-monitor-v2-2-004f47a4a7b1@protonmail.com>
In-Reply-To: <20261010-b4-button-live-monitor-v2-2-004f47a4a7b1@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:01:38 +0100
X-Gm-Features: AclHuK-1eQxXkxLozyiiD63U4ctC8DCS7N1jvem9kgoIrc-c7zDqZcKcGmBisZs
Message-ID: <CAFLszTjFj=M5gWUykYX533kA0zugnr5pctC4G4=cWk7aNskKig@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] doc: button: document monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
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

Hi Petr,

On 2026-10-10T12:27:54, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> doc: button: document monitor subcommand
>
> Add the monitor subcommand to the synopsis, description and return
> value table of the button command page.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> doc/usage/cmd/button.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

> diff --git a/doc/usage/cmd/button.rst b/doc/usage/cmd/button.rst
> @@ -43,6 +44,19 @@ A list of all available buttons and their status can be displayed using
> +This probes all buttons, clears the screen and shows a table of their status
> +in the same format as *button list* (*on*, *off*, *<inactive>* if probing failed,
> +or an error code), refreshed every 100ms together with the remaining time. The

The second line is 81 columns, so please can you rewrap this paragraph?

The command uses ANSI escapes to clear the screen and move the cursor,
so please can you say that it needs an ANSI-capable terminal? On a
plain serial log, or on a terminal that ignores the escapes, the
output is just one table after another. Please also add a short
Example section with typical output, as other pages in doc/usage/cmd
do.

Otherwise the description matches patch 1. Since uclass_probe_all()
runs first, '<inactive>' does mean the probe failed, and a bad timeout
and Ctrl-C both give the return values in the table.

Regards,
Simon
