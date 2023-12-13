Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F42C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844BC8783E;
	Wed, 13 Dec 2023 20:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KKrb5Nea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555D7877B0; Wed, 13 Dec 2023 20:52:20 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B9E87831
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5e35e1dfb99so1595587b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497136; x=1703101936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cr8shdRWV/FTK5bDknskPEsNujbtW+sAWjFPQvMNRkI=;
 b=KKrb5NeaJuwL8RmGq7loVUyQVqbrcetrkuK6ql9xaTrQ4KZp79D8FgGoZspBsBfud5
 l7aoNWEJIbIumYiguDun/LJsvTmZTg5BKPWGVUlAnEW70Qz5WKeCp/PDNKrLyeySTYMI
 /GCzgIB6V52mVdGacJZs6emwq/GcrZ4S1K4jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497136; x=1703101936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cr8shdRWV/FTK5bDknskPEsNujbtW+sAWjFPQvMNRkI=;
 b=d8VBMRqli8PTy+swmlFEkb51cW2e8nOCQHpSanI28B3R5V03hspzt57a9FwMcZSXJW
 LhHmUZ3CndADN5Lw+6iu00GlpehemLnCh5C423VySwVu9VwwYoSbFfJ5gzLV4/YhzExy
 5vf5Iznc8M7wFEI2p/24aOebX++7UB1ngmuRM78u5C3yRnZRJDoZ9fMQaPOsG/0pueke
 FIUmsr8+QuplQFqly5PBFM5qstuCyMlX10PYZ9fNzYyskXNQiEzn2J+NuaeZyvOrhx6k
 XKQs4HsbE17AMeglUF1LdhVghiTLiQyCme6472O8gV+aeb86itNszYRpW/yRbRrpSMsD
 t3kA==
X-Gm-Message-State: AOJu0YzwEarUD/ZoGOxhxul/dI5OGS0+9HZrQUhv7vKab2U7uaOJfwoF
 r1VK1EvW16CYMvA0J3CpgIEkiH3uipgMDctAxEeiwA==
X-Google-Smtp-Source: AGHT+IGkWQaP7kZBMeQ3vTOO1Uz8h3JEGtSDuHrNa1ouv1HRYi4GzWvgPZbUkl/G8ZI26Jn2SyBh7lJzhQE4bpWE88g=
X-Received: by 2002:a25:c088:0:b0:db9:7695:75e2 with SMTP id
 c130-20020a25c088000000b00db9769575e2mr5075845ybf.29.1702497135967; Wed, 13
 Dec 2023 11:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
 <20231211122051.1240855-4-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20231211122051.1240855-4-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:04 -0700
Message-ID: <CAPnjgZ3YhS8NvBHm0aRFUTP8=oXJ58tPcpjXjy9uQBD9R96Ykw@mail.gmail.com>
Subject: Re: [PATCH 3/5] test: cmd: setexptr: Add tests for bitmap string
 format
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>
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

On Mon, 11 Dec 2023 at 05:21, <lukas.funke-oss@weidmueller.com> wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Add test to test the bitmap format specifier
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
>  test/cmd/setexpr.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
