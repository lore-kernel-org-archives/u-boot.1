Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B16FE94603
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C308341A;
	Mon,  9 Feb 2026 21:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aIg6Eppy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E8483C5E; Mon,  9 Feb 2026 21:42:00 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C4958341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d1890f5cafso1205165a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 12:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770669717; x=1771274517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWOjNB1v5p0j1zDFUcrexgu1qdhMEj/TtjNmGRzwRwc=;
 b=aIg6EppyZv3x+6Dkat98K9qiahDUOBVQj8NnhFtQn2uVYK31p1oTuv0nkAMZYKhbLX
 JtInFDovKBAiw4PvxJB2VMAv8hGAS1zFW5UZX3q6+rYP2HJFrcsZADIuJDlmeHiHBaDM
 28lwHo68YHkjiQhoVpiJPjZLG57A/s6RAaVy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770669717; x=1771274517;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uWOjNB1v5p0j1zDFUcrexgu1qdhMEj/TtjNmGRzwRwc=;
 b=fBOxfssvJ7xa6pXhUW8anuIwsu9JxbLJIX6b10W34aM7f/cAWB3mT3n28hny1mdFUT
 dHGnWthr0Zenhdlm6LJDY5sqnB627W/6xx+zvYG32AR7d3WcMBDjNxNMdJB1bKNgXpXh
 2oQ3V/5XGdGAuJ+yORhCmzP/k2C5ZWcYncZEbJsS1hJL8R4vAMsznXY/a5jOBOjRcckJ
 6KbC3wLodj2p9q6KMH8oeB2sML0pifR5NEmNZvxS7uOMsc+DnTuVAcHzvp/DeBIE9JOF
 dAEFwdVN/j5gFyswj6DTcl0aJvlxZD12xn1Pt9BmZwT9mGsLfjipwliqZvLVB3ExrV1I
 SPdA==
X-Gm-Message-State: AOJu0YyKnkpF8B5Anmv6ObMnqP02Yk3mYjWXlyqfkaUAppgoFBzmKPpg
 dWMqBsipmVgw/8So+zhRqewbC7rtAkt3zzKtm8e72CUlodqvtTpi5yZtVG0nsgAC1VY=
X-Gm-Gg: AZuq6aIOwjY2UAp01TJj8ITT2pn2SGI4ZBTfqXin2/housgc60Ge3z5uG6KPilyITaX
 i1KEsEvp7UcKOa9tn/vTPaJevqq6jL7YScmg0qRdVOQizgslIAoVtmMN2ZZ/8Xbrjbxx/li6SiW
 hEQ3akGZh5HX7ghHXE+cys9LZVAfp3c16ZDhkuiSXc7Ow5MZetdQi9njRj03yyMOSNo1H/FwpSg
 6iAQNDLjeTCs0aPjLZrlmUSmNddZUR7RHIKf5L3/wWVzvBQK9XpYiQKRZR6H6tEHIq6b/OZSxnF
 sCoKMZIHbkGSM7IH9X4+VlPsQ+8ihiM3Tfx71s+TJ8PGdrgGWn8aPlfHflVM8KQ9XTVy0N/mhqV
 0FlzMzeEq2I4nWnt9auEgpHJlIz3HvXK6cnvh9h3ATAEEBtpJuoHrZeHpxnU36xdtNHrCofQ+Ba
 bjR9v8Yrs0zkaREA80sa94nIY+Ce09bBTgXifRSUjQ3TeaVPlH0ePpq74Q8fA+G+RHwig4APGov
 C0OHNXnLNaOxbIsIr+hUfhNgFlf1tb/kSAkNg==
X-Received: by 2002:a05:6830:6318:b0:7cf:d1b7:c319 with SMTP id
 46e09a7af769-7d4643e8110mr5691476a34.2.1770669717393; 
 Mon, 09 Feb 2026 12:41:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d46479b9cesm7875341a34.24.2026.02.09.12.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 12:41:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Brian Sune <briansune@gmail.com>, Phil Phil Sutter <phil@nwl.cc>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
In-Reply-To: <20260205234158.3768337-1-trini@konsulko.com>
References: <20260130183635.2612933-1-trini@konsulko.com>
 <20260205234158.3768337-1-trini@konsulko.com>
Subject: Re: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB
 without separate BSS
Message-Id: <177066971625.2412163.2907692573004999359.b4-ty@konsulko.com>
Date: Mon, 09 Feb 2026 14:41:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 05 Feb 2026 17:41:58 -0600, Tom Rini wrote:

> Historically, when we have an appended device tree and also our
> resulting binary will contain the BSS section, we have ensured that
> everything will be where it's expected to be by declaring that the BSS
> is overlayed with a symbol matches the end of the port of the ELF binary
> that is objcopy'd to the binary we concatenate with. This in turn means
> that the logic to generate a "pad" file, which is the size found in the
> __bss_size symbol, will be correct and then we can concatenate the
> device tree and it will begin at __bss_size at run time.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: spl: Ensure 8 byte alignment of appended DTB without separate BSS
      commit: 89965b5eb597d50d052ee79b531f17495cff6f29
-- 
Tom


