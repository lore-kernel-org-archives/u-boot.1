Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFE606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b8HhkSYZ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Mm2km7M0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A2FD40B03;
	Sat, 31 Oct 2026 08:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbENfgaH_ttP; Sat, 31 Oct 2026 08:42:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC25240AD6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436163;
	b=U8yyHQ0yGM8kJR8VtwiT56KkmFtrTVBmXiRIneb2TNleLq4ptYQY38IuHQhuUmcHOhDJ
	 R0HoaTWTaYHMFYMeior2izPkDP0FWzGbi5wg6rToyL1meMwrUP4zKU3mmBjYVnsHo3Fef
	 mIHBlSWhhS0axL66s5kPJ5m+9nHtn24C4cFRsGgbbBPpH4+U3vZUeM3rahSGFoOXSbQ8i
	 jsiLRWUz5t8pyahKp7jZGL0+aTXuKjMgA8c2JLMS9UodCnZsrr7mZF6zyZ/sTdFM4F7iK
	 h1X4B1xWkR1E+0v31LwEIt99wes9OhyMyrwFPSqu2iIJDTbmDxZ+0LBN05OiXg9X6Zg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yo5M3ZTOYZRNpb0+7mNu+lgybtFnIo0ejeQk7OrGRYw=;
	b=JdHcWjWbrmdry0rhF0BnN4eHoE7JL/D6hTzwDksXUc1/fyixWDkvxlclt6Kf7e4fAZ/z
	 /Xz6ktgEKQ+TS17qbomUA4wJSZWarNYSPX1p9aEldzeR5yfhI4+RDmsnkD0he3TW63PDF
	 D3BIHRFCbNrP4DQQaVMCggw07/NS1CzJtmiRbtQYz3oEndeYDZxRYQK+VB2g5uz9H45jk
	 hDb5/SHyykHYnbDzBRjbEBjEeu23n7Zso59AQMlgg21l/YURwHkIpSyqI5gXulsL/BcIK
	 ymTj6s9t2EkSNq/xG95rDQXgRmUyh4IanbR+TCrPzJ9gYZkGtrFzmQmtXKcBFLUkGwQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Mm2km7M0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436163;
	bh=yo5M3ZTOYZRNpb0+7mNu+lgybtFnIo0ejeQk7OrGRYw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b8HhkSYZq8gMg8ryQdKWqutzibCjIxfDG6i0e//38PVE//4TFEoXfTxjwGiriV6Gr
	 SM6ycLMf3bLfJxs6K71kntwyuRYLbnnPSu7e1tsCIXIKSH8HswFMASRUhFAYYpCjrU
	 6K8+v7S+pK05zHAP72NJAbTZ6qxyHm9xwqzbx92oeoj2eHt2FWfRQuy01UlGDhDlkW
	 8d5ZukXjmLRIOdVqeS9jU/QQzxQH+Bk3+3X+0xlwb6a812xC7nkdBWegZjIXbZ83gK
	 dtzM8FM9at8zi13WEOXfNUX0OriI2P6ZTjw80wzO1HsEkZ/dZVaxcdag/b5DNs7lPi
	 VLhKfXNhmtptg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC25240AD6;
	Sat, 31 Oct 2026 08:42:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7DC91DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9980440AD6
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGnVJhup_zpe for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:42:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ECA8340AC5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436161;
 b=L6p9I3SzHNPCzcj31Qd4xLAaBM1Aa0A2uVoGCDBFKSAm+H4jqf+gi6hwX0+ggRmil5VS
 NoJfZbR/pNOSxA6PSiZE1fF55cbA9apJ7whRBVZS36XFGrlfurHiSlRl3UjoGOaw+dmKw
 jPdJFcaqunUCBVz4qhMurYVJ4qDSwEfqExYZAyPbO1AnTzP496g3s+l+kqO+kvmXsPn/k
 EThao1T5Oi++8H9+maHdf68PR7hpe65iwuyPxmAiuBD7c1WBXzFt4mNFzt1IUmeMU6h/i
 ko6QfCNdgl8MRev5GGThStYDz+Y4EAMbbaTZhCiPQCtWzNuFMO6ZLca1Pa+URBzuhQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436161;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=yo5M3ZTOYZRNpb0+7mNu+lgybtFnIo0ejeQk7OrGRYw=;
 b=odEG4hgkkS4z/G08EjhmwGUoJp+w9rEL4o8WWi8ixiSVw+PWTfRisHFgbGQe8/9KNgnY
 KImS2eOX0nQePM2urXP92YAwdHQkTmupCd7bayFShVr8jzEZFt0qQLcAJiFjYsWhWzw6b
 FZlYUt4BlO9Ami8VxFkKv0KffuowB89p4IFkI9pLpSCGEsxuugunRECKQBUrmGalHMTvL
 lE74754UxlZJ/y89hVH3N2MMJDRhrnJLzk6ysfLN742b1bGzIc/uRFG38jmSx3WRj5lKJ
 4a3clHf46PZLSlC8ToCs9r3nzbN+PpRT05k78k3mijC9loLDM7u16TM8kMkJbPLDk3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Mm2km7M0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Mm2km7M0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECA8340AC5
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:42:40 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e946155442so13264165ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436160; cv=none;
 d=google.com; s=arc-20260327;
 b=lYOlkzGGcfT8gb4EpwceMQMpVqU1zUnPPCPJfn6SgvUJJ03xzi06IuseUndQyGb1Y/
 Fe8gC0YvZXk24JxflEfR+6ob2XSFcX5alPHG3H0jvd8zJcrcNzrD9GCRtWAolvZkA3VB
 GWrFBtEMPZB4i9uzg2/hIoJJudx+ZwXM23yJ+hpQc99spEIAay/lbnLWUtiv6a8AIIYG
 Pqs4BhWjaysjTszjxcedDYYvNpXIxS0bX0OoqiweOS/2Utn2ubFCmtN2Uiec0Gw0Ph4D
 vePs0GPXvXt+3tsXmGZWsK4Oq/3w1nMYgDO3xW2EyHBfnqgvqrGM0esQO2BufwAQjNJt
 qYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=yo5M3ZTOYZRNpb0+7mNu+lgybtFnIo0ejeQk7OrGRYw=;
 fh=sBMGTz8ciWqgqW5bwgUDWXlzeBFEumZDkUVRBIqfH2I=;
 b=rY/MEPxqC5PvCEphOuCvb7wI8RlKEDaOtD/5wmYWWeOLzhYO/rjlAi8EjGFeKqfdRg
 BVXn9EPVwEQUtauwpyMNlKHBnq7EJydt8eOVnM1r4weQAIjh43peLdMY2C9eag5OWe5Q
 5PTLJljf2eV+mHpmg03vyUhJ/lm0TDa4UTLkbbOh052QWWv8LR3EH+jn1AQHCDYbb/4F
 HYwXzcbXvGoFHfUXwOnLdrT8mHWwVvKC10rm/l30DjxR3u+UI3bC3Rg5ZSX1pXK+QErj
 H4LpnGmRJAjjn16paEDVb+1AO3MmBUi4uJAacDuPiQxZDWeZuK4HeSeLdw/5x4wefQeZ
 Nd7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436160; x=1794040960;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yo5M3ZTOYZRNpb0+7mNu+lgybtFnIo0ejeQk7OrGRYw=;
 b=Mm2km7M0pladMOmLHM8yYWrG/fN5PPo+OdHdFM0CfZrWHZwnWq7QgEWyNMX0o0rXqg
 husNXQG5aq/wD7iJ9Exul7TTT/M47tAnwOY+tzzK7+Syv5JkLrTHCJdwJFB35UrxiJDJ
 xZ9vq9pqq/02gFyCOlbCMuPPeeiCDXZSsFZm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436160; x=1794040960;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yo5M3ZTOYZRNpb0+7mNu+lgybtFnIo0ejeQk7OrGRYw=;
 b=KijyHd8WstgIbuMjhSz1RrHZQAC3lEGUipU980NcY0ApkjkS6e66oZ7HSoufv1Y1Gt
 H09/VryuxNE2BJBnlKe+6Hl0WkzYOmdAtsoAJJgfvSPH/WTGUID2KDKSn8iL1N/YcFWr
 WK4Lx459fxi3kCWB9k2qTsQhCLG31MTD2weF2UzBomOugtsP0a2/dfkVeC0fMkKJMcSk
 5TTV+cJ7g3/GlkHBRp173lIDrFiyxsFfSkmS1+XuToPIBjbHKhnxqemPBputjF4xiHIt
 2u5ZAbBX/lJKbSABvd3c6EOqApVtIqQU5UrfGMRfo/Uol8mDv5Keou1kFtXPXjQ+V9sT
 yECw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTpwfuuVk9dNiAE7ra8bsynJ+8evNFG0Rl7+y7w+ZfMrSZ5ctnXoQ3MsVv2poqAh5IicN4UoU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIOwvhT/uHNAlNiEZMAtBgkugYwgGr3uU0cxMy/xGljjVbUV7Ur
 CeRvaVkkYv3g+yxw7kKXGjwI9GAY1SFC2smw0YPfW3Ak1n0aOXMNF+k2vcBFpb7p2KI+C+h+O/U
 eBXeGaAHmzu+VTrKiW7BxKKdrPlbzax9FkesAFpSD
X-Gm-Gg: AYBFou1+H5kvKvN97PmwRGy/CetPFf++8yY9VN3gadgdToHFcBYarN9swAAOvNVi1q/
 EGMxwYjZO6HQi5tOAjXpDBkGxOGc2TXj+YSaAScE7gGyoXepEk1k1vBcmyi9lfayltRJqHODY7d
 V53fCeXPxgzAj6Cjc929A/ceAF//6oIBH0d9S1avB+UThs4EGwFqL+J9bk/PwzHtkAfXQn7vXcD
 bO3CjQAKA6ai8sLCUcMkzCdE+wV0zK27BZQDGljZbQ6CAqmWlcz5E/C0JUwhSePjGTxVUGAnxkE
 l98gAt4dzz4LfKDjdkfKeUKGekuOCl5VybVXsWtT3QYaLfolaHIA1rA9s+uHhuv1LQ7eYMVbwOU
 tjVeASYyvBZ7ZRi/MysqgMZ9xgDMIqaHQwtxdlz+MmQFywbBPMomBw7pl1BwmQSjwSEAEesI=
X-Received: by 2002:a17:90b:17cd:b0:3ac:b7b9:6471 with SMTP id
 98e67ed59e1d1-3ae8987a7bfmr3851138a91.65.1793436159787; Sat, 31 Oct 2026
 01:42:39 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:42:37 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:41:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029050738.1107663-7-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-7-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:42:37 -0700
X-Gm-Features: AclHuK-to_PUTa3szEclcZdh5Kf214wWMJQEeanBeBpT1mgY9nkFtgb-PKP9bQQ
Message-ID: <CAFLszTimoGFOQmu21+5YjCU=TPnM3ER75ULgcUTT_dsJs6LNtA@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] LoongArch: skeleton and headers
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jiaxun,

On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: skeleton and headers
>
> Commit for directories, Kconfig, Makefile and headers, aiming to build
> for 64-bit LoongArch hardware with FPU.
>
> Some of them are copied from linux, some of them are derived
> from other architectures, the rest are written on my own.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> @@ -0,0 +1,40 @@
> +choice
> +	prompt "Target select"
> +
> +endchoice

Please can you move this empty choice into the qemu-loongarch patch,
which adds the first entry (TARGET_QEMU_LOONGARCH_VIRT)? Until then it
is just an empty menu.

In any case:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
