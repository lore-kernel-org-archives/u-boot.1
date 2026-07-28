Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8022CC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45ECE409DB;
	Tue, 28 Jul 2026 11:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSEKOVthqyAw; Tue, 28 Jul 2026 11:19:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80E4B409BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237549;
	bh=ZYSVtPQ45r92GL/qs7b4Sa+C3+GwaOxcTdoAIe/eFRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ipzCYHUXs2SVk6JtHNd1U4pwl1fVk/lpqHAgBMAEgIysLAjV8n+jLKEKInI4ZeAk8
	 HmkZOu5o62XiSeVwS6ZwEoJTagMa/64HlIiDJLzOLmbV5uDQwjji5SOnKM1yGXP2ZL
	 QrvvAn+XvYmZzWnKY3nKoTykQLJA+/cdV58GZcT7bqZkH2h0poBRBh26pf2/tdLuGh
	 Yo2PxScSahI8Elht9BdpT01GxCxoQMsPNBY0MkhrzS/Ggu6BzanrIcDwdiLAc8RSCm
	 1600befejPxW/DNPywX/+mPaRpxhQzwLKMfbRL7PsMjuhICs8d1odofAxBTJ9jNcUm
	 qLp0FinIFbEnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80E4B409BE;
	Tue, 28 Jul 2026 11:19:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70239350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5695040964
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0fwBZKbeVfV for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:19:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5F9C9409BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F9C9409BD
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F9C9409BD
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:19:07 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69ffbd2a277so3124709a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237545; cv=none;
 d=google.com; s=arc-20260327;
 b=oMCoy3phAcmfS1H4JZbQRSIJH+iN/mWxScUCHMKk4Gefg6RuowxGaqZYs5sAcGbks2
 Sluj7TNGfPqJ6waoF1JvUWZH6xP5ayigWoouo3yuDahHv6jt0M+dK/6l0gkWPH+pa551
 RSUoWUVpBEFdoyA25GDFdelRhSyEEev6+3NsLcqqu5zqz80yY3TZTV2wJaHpIuhVL9X+
 sCvS061XCbH/mwe/pD4OyIARJrXsB3DwjOXUPwQOKhMDDZmVvpy712cH4cK1DlT51RwG
 WahUm9aVKAqJC3Jdu0W/BMMqhtjM94NyTrX1AGrTdx29mWeBmfAf6KGNWdQUsxmsirTG
 BhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZYSVtPQ45r92GL/qs7b4Sa+C3+GwaOxcTdoAIe/eFRU=;
 fh=sEHNQHnqauSXEkz2lF0GiwYL6QtoGoxXgwJAlLUDaxw=;
 b=hxI92jYj4xnjn/M8C2VQ73nq0MZTmx+Jc7iw6/G0CIQUThg2kO7Js29ZJeojp1l2IM
 13KKRA4vRl5Co//c3ApEvKuYe3yN89vdFswiMAH5FCtbr+MP/j1hq2rxA4gM42L9P7aB
 4Pjg7Y5C29SIlzSVSPR9oYPT10NMWIg1d3cfP6ZZl0SINIrFBHo97/J7QhmBMKN/PE6n
 GTDmuxsnCRn/nTBHL9MG0F51UoLkffbk3NhrdfZDE5W9R8DIT3MghOf8XxE4X715lD2X
 Uis8h1zPyD9cWeN6pIOCof1LHm73fSp/PSZxMDxyKL8As7dCqCYC/tzCrQKMAl8tf3OT
 Rezg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237545; x=1785842345;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZYSVtPQ45r92GL/qs7b4Sa+C3+GwaOxcTdoAIe/eFRU=;
 b=Wfakei+JXpJ4ps+2CrCvYf4oVpn3rfG/rP3q9MdNIz0X4lNcZ0IdfZnCyuzT/4ktst
 A/4S2EnHHLahOyJ88OIu/5nFyDvQTrmzLovGXdkc7Qyrw2dI/Dg6ksmvKxaDYb7vCXzb
 ItP7U0ZBSk3LP9gKuwCFYxpaCjx0CXxkU0U31dorR+ez8wFJran6qPDBH8xDFXMzaVs1
 CPBOfxzwN7OjH8J1AS9pF6o5W4oTf4ejx5yyutM1EfCMJG8zC75zHBt/SiGngEX1hHQ+
 IVb0umCLR4b9db3BZ81I1KJczfXL3uKLRXWFkucd6LkcE+16rPT7vntAWdlhFqmoNPPe
 om3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RquZ6KApAT5OMzni2Gta3yC7EXfN8P+8YL0akXfN9bkSt3cDH2esPH5msn0Tj8em+Y9w5K0QDY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxTigvsUEnxTTfLNykJZ3PPQsK0I/AewXuAx2njRAx9rXcKNC2K
 qPlEp4dKQ24efPWcSTSPhWx2LnTHykqkQsbRLySnWP3pAE6IllN3EA4cztiRkZxlvbZ5pmxRibG
 3oxUa1Y8i+C+nDUtAOGSuGo4Z6p4RQCQpxilVW4/x
X-Gm-Gg: AR+sD13fvacWgQ9NwK2tKH14tXxhHa6rkm//1la5wxDyfBBPlKM31xgpecHAoxxiFRk
 4JYkJsIeoVmh5nLm95CI6PwENX21jZeN5TkT/LpMer/Pk/gKS0r4bRgRQyE54x5GFxhZz99C/NZ
 s/DytJbbzDkyej3qbNI6PQKi+ZSk3fhNYylLIcE15B8uYqleHMPJhTZCwxOpG/TlpyoB7WmFB6l
 9CAIh6EByPoZK377V09NkghSnqlhWDZqGr9ALTo8ONmqw7sLcP+YaTznYre
X-Received: by 2002:a05:6402:1941:b0:69f:3e6e:f63d with SMTP id
 4fb4d7f45d1cf-6a034a98e45mr919389a12.40.1785237544651; Tue, 28 Jul 2026
 04:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-8-aristo.chen@canonical.com>
In-Reply-To: <20260721152110.283998-8-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:18:52 -0600
X-Gm-Features: AUfX_mxn-xB9Fh9OZAr2U35rXNHwJe63jkgv1OFSnW2gWjjjNU8CCjviEkUtaZE
Message-ID: <CAFLszTi2Jf=A5QterOJrd8X22SWakD0CQmXxkowiBkGw5B7vOg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] binman: fit: document how ELF load addresses are
 determined
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237545; x=1785842345;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYSVtPQ45r92GL/qs7b4Sa+C3+GwaOxcTdoAIe/eFRU=;
 b=PpXgpQLAZ6TW5A5AiklW8S1u2zd6mXOmTVrkKS99xPJht7K/fcvI1tTcS8aORxBjZt
 vvXTbpFffQL/yEWT5BvE8XeGYSSzU8N3MY4wL2gJxj4tketrg6cMZWiS1ykTc5on5AiP
 /gb46wuN78Bhh2V3mujNTfe2I1psfSbX696T0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PpXgpQLA
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

Hi Aristo,

On 2026-07-21T15:21:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> binman: fit: document how ELF load addresses are determined
>
> The fit,load property confuses users because the load address is
> taken from the ELF file rather than being specified in the binman
> node. Document how to inspect an ELF file to find out where its
> segments will be loaded, using readelf, the linker script or objdump,
> and point at the elf_sections and elf_sections_tee test linker
> scripts as examples of two components placed to avoid overlapping
> memory.
>
> Compared to the previously applied version of this change, the text
> now lives in the fit etype docstring. The entry documentation is
> produced from docstrings by the binman_docs Sphinx extension at
> documentation build time, so no pre-generated file needs updating.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/binman/etype/fit.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -317,6 +317,24 @@ class Entry_fit(Entry_section):
> +            1. Use readelf to examine the program headers:
> +               ``readelf -l your_elf_file.elf``
> +               Look for the LOAD segments and their VirtAddr (Virtual Address)

With no blank lines between them, RST treats these as one paragraph, so
the output collapses to a single run-on line: "Use readelf to examine the
program headers: readelf -l your_elf_file.elf Look for the LOAD segments
...". The same happens in items 2 and 3. Please can you put a blank line
before and after each command so it renders on its own line? It reads
fine as source but the generated docs are what matters.

Regards,
Simon
