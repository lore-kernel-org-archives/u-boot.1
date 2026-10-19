Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD98CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C107B81062;
	Mon, 19 Oct 2026 13:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1KCg2KYyvRYB; Mon, 19 Oct 2026 13:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E38B780FB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416140;
	b=Xy2MmeLawhWQBSATpb741ISrG5f+y1sxuepHfZaa61yVuIKCt8f0QTjWPm33RfDfGrOp
	 M5dyS9joiAxrFPZS6+ktR7+DyYqHrUyYAMPhkAmyhd4uAY0T1Gb0QPH4npBCzjYR5S88y
	 a9lzxFQ0uc6uL2sSUKZDiAQuiIkk2bJH21u5XebrjiIf6EF2xbUieri1iajnELNxntv/s
	 BtV3PDHOC2dJ0QHjjYSlmwvweMU0UFg0uSkN65WoxxJYXY69x1BIXeDTAznBC8S95GwdT
	 oclK5PJQarYAMlsp4XqtB2wRfLcYZgyqm+eDxp1dG+6J4ExMRiGNIrwa8t40Snd0BIg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pN0lyxkzQhrj9oJi1geOHMJlzCNuVhKimK5JjNsavzU=;
	b=QnaowjAFlOOZ6HFW0AgADx22BQEqDBnPcMKbU3ii0CxaHsrXO2iY/Ha4QiRcP07lvuKw
	 i/lBd1dEzfLuJjYaXmnMM2q+z/lGDjmUdWs5IrfnSJmWdVewkaXja5d8tqDClXc15bFl3
	 jRAy8RUpV7H/lSgXl18uToIIF9PoOkAU/8e6QWDrhN64J6F8jAhDkpOlt//Dcmu57y/n2
	 uRpEv1TCfgQeLvgNPyxf3wGNP8GpRXcNYBDlggRSE+uux1umaHX8smTPxzXXK/5lXJpyt
	 0XL5qDaEFwpNyLK7tRjR2rT4gt1RYf8g9M4A8mcMiyp5Y/E4XlUEJ2o2qbJu2jhumsQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416140;
	bh=pN0lyxkzQhrj9oJi1geOHMJlzCNuVhKimK5JjNsavzU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hB82oo4yRLM8UEgjSJpO2f+rUZDp5fQrSatCxkyyCE9eI43QdtwMyDS1R8KfiTsZP
	 pdYZdUp+zQaKhQqTV8MWzoi9lQ1CDES8Ora4yOu2Nz7AssJyAR6pMrm3Kv365vUZah
	 +LgVKMkbEomDi7hqdiA1BvXZPwmBS8hch2qoKyhUE83pDq3QUQOaNNak8i/BHNO1Xl
	 Ojq4cAImZKZurw7giR4zBcut+oq5GnvKWXxlGbDtGGjZ+X9VSHPhD0qL9/NyiCHyXw
	 qwE2Nx3xXV8lmLBTu5fgRZFqVmxDjLDOvitzRvxhLJ5rO/p7kPziFRzgcNWDbo5PzA
	 Nj/B2u8UZbs9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E38B780FB2;
	Mon, 19 Oct 2026 13:22:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09A8023A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E30FC4068C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:22:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MO2S4y72Id2N for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:22:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1F2540688
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416136;
 b=X7IlJ9KzB7Brk+TH9msOlQz5SgTOjyp43gTPi3WldJr6+u0U23DASDd9dVhfD0ldQBVG
 UdQCa57vlTj2D0mFCCQTG5kUgxKRjFxDGZF/51yE1KNMgEyyAj7KiJOt6TRVzOVBVkJVq
 VJxd4QiMzukPLxl5hJiRTF5i+EYYGrTwKPsretEewv5ogpuhD7b2S2o5pkIMtaeOHgyE9
 /4Xo7x/auZDDgm3J8SE8Tj7yarEf0eLTDCJUszeFhh9WzkKmlmrrxuJoGptA/IgobPB7q
 +/xjmoNuTdNCborOYIRvLX1nVWg/SBvqwar4IvlaLoMyQqBCiknRSpkGY2IANnOXe1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416136;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=pN0lyxkzQhrj9oJi1geOHMJlzCNuVhKimK5JjNsavzU=;
 b=hV9oigo0sJexpDi5kR8fwgQlmzPmZCMizeyWktJt/mYNP0yfoSiXiiAZDSmADtiDyyNz
 dmgT9YkSjAaozEG4CNA9WAp7xVN4jkacupRANyVNPvj8+Q208BcScs0weY2jDTKAyHiFq
 +E75tqjDh5XIDBDYTTIVioIpof/DhJ79FwBqXw20fCyExJc0DfEwaeVf24bEKlrmpgsYa
 1nRRWTL5xQ9q/zAoca0p5Kho+Zdde0FCR85iFg0HINGbLgeaWlhWId0q7TkJwNNnSL8Ce
 pyCNPojixkvv+ifkEZ6C3yLuldkeEq3EwdDoVYz/2jLMD0nxuolyAhDFUj5JJdUGNhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MAhPSi4H; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MAhPSi4H
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1F2540688
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:22:15 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so2983446a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416133; cv=none;
 d=google.com; s=arc-20260327;
 b=Aj3oVfwmthG4Cpve6/zGMlW4DY0loxzTN20S6iICqPKcxCb+C/C2kILEYm+gHK6mCh
 /agi8Hpr3HvtL+uiIYiPW/bqTbIkXrGoW7iZIgpV5RSua+kk/NDwq+MAYGDgIotpn6QW
 H/yLFAsnzg+PlGiwGuGZ2kzjVF9El/ELdHjtkHgLWTZCCX3Y3DiF0/Q0tuxE8q8+V0zb
 uAPFBMMMGF2DhuO7ZX/1US9+tPQXPVnYDM4nn+YI4gNK/d55ZNXlCCNvCdyhGVaL+TB2
 C9KkgnsinIa4smzYQWw8i00w57ZOlJ7fb0m0wQi/4FsSmoZUktWlsrMBYOX8VE8cb8HB
 e/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=pN0lyxkzQhrj9oJi1geOHMJlzCNuVhKimK5JjNsavzU=;
 fh=HNvyiKdY0EVXoOVdehOWSAhbBVIvKB9921VBkS5FvAg=;
 b=sGaEKtR5Cqi/rXeX1nx4zGEsjTZP85sVxWusa4BPSu3naJsQFFL1V528GfK4LQXlm5
 IPsz8pO29/C9mUbwWG6iDGcGzTt72mGb/5IEOOt/dDgs0xTsgmyEfb7eZed4IqjsU2Vp
 aSJELhdXFraYhchdI6g0lL4D1+JcqCuAaxpd5wplNON5pT4voFc6BrpFaT2iW1GViszC
 lI8WjZLQZVEV/SozBRQ6ub7SwubdOWVB2qBtbNs+BcwIMWDM98tywBOP7rODdFvqkZAr
 W11Pulc9IQN5v1okbVj6c2PSGs4uQLjF08uHlvKfPRgYFmThNOTvS7k0i6uDEyRcili6
 onWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416133; x=1793020933;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pN0lyxkzQhrj9oJi1geOHMJlzCNuVhKimK5JjNsavzU=;
 b=MAhPSi4H7SW4PuU8CJmUXXtZh2XG772Ss0xTfmosKjYKSNI8PEQOnoFesgawWHKvQM
 IhnkKprAwL0uTP2b1d5//0vnZLV5NO1/Cv3ilC7ZPLg1XxcHZ4PDC9x0RX/kkgY8UZYS
 HSrqANrCQFPGwQ1N67uTvUCymuklTuBQh/h6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416133; x=1793020933;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pN0lyxkzQhrj9oJi1geOHMJlzCNuVhKimK5JjNsavzU=;
 b=L9z/n89jykr/ZsXyH9I3y9bDD3EUOXXBpVp1pVECEEdwHTQlNAgj/lONXQy7dDhAqW
 iwYAW+sZ6X4cubET2Kqf4lCE9QKzLrsPiSA3cPATw2/v13nO7kHyygXLj4HuOLLaGkao
 mlDHYFm/J7UnOLcmuiQR9l1xXuYpYgkjPSVPFz60dGBUoOZ0TfGp6/yyxUQ85cSLnk/B
 OMn0Gk5x3sun+EC0YH/FQJYTk7dHH7ElfNZ6K8hkRZbGx1g8Ja+zkp5bQo9+IQj+UCNv
 +wI+tnMn/Q+YRoSbahicuHCE2/JP+9Q8zZ2JsAIRMzHf6JjCOLQdN4zLQMNjTEShVcvc
 f8Qw==
X-Gm-Message-State: AFq9FYJ0XTbrhQL2Zv5dpKkTfkVW1YjJ4adq0Ebhppzuy9SyeCEogliT
 moc/5mAl2jfD6oVfl2TOK388MmPsyZ9Kiv0Lcsv2WX7lfnd8ziAglDL+JgWSilHJ+lf7KXR52db
 5XlyQsbX9E0TKbzzQZ4q7BgSomKVjBq5K/pVDncUq
X-Gm-Gg: AYBFou3Qfai8f8rHJDz1lHya1wAs+7AF11tCznyf+8LhFR8hPpSEiPJrQ8jJnK4ayfK
 8CrgUzSG/ik/gXrPEqOsPVZ52iPp7XqbWWrdzd700QJBn2dNTPM3TceHeDn6EBEONQj9yslBt/8
 xY1dGycBiu6jW5QBcd59gKhRaUehfOAq0d5dSiveyG/Hi+U27MaSRjP1U/3FmxponNXo+H5vnvi
 ZFoPsVRhCsNmd3v+099RDwi/9T11jlGPov9hTpELF7suT3V9oyzyawEXzEsk/qUOGcJITfqxWBg
 2m8Rh+hBOkaH3wgjFx0aYgSMZgHRsUMk1DdRDHLjh102QFRgCKq5Hw==
X-Received: by 2002:a05:6402:a550:20b0:6b1:e2f1:3930 with SMTP id
 4fb4d7f45d1cf-6b3a816fb10mr3518486a12.22.1792416131760; Mon, 19 Oct 2026
 06:22:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:22:10 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 07:10:46 -0500
MIME-Version: 1.0
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-5-961124989594@oss.tenstorrent.com>
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
 <20261017-aspeed_vbios_fixes-v3-5-961124989594@oss.tenstorrent.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:22:10 -0700
X-Gm-Features: AclHuK9JAdugBFS3wgOjf5LYCj8wE7tThzVy7vZHY2KmH6iIJpEoTPu89c8OyzI
Message-ID: <CAFLszTg9QBOtZLz2hsC0BjfTS51FEMj_MT-m15JK_yz9AT6bgg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] bios_emulator: extend VGA I/O ports to include
 ports 0x3B4-0x3DA
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-10-18T04:23:45, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA
>
> The IS_VGA_PORT macro currently doesn't cover the 0x3B4, 0x3B5 and 0x3BA
> I/O ports. Reads/writes to this currently fall through to LOG_inpb/outb
> which are unimplemented on non x86 architectures (which don't support
> I/O ports).
>
> Add these ports to the IS_VGA_PORT macro, and implement reads/writes to
> these ports. 0x3B4 and 0x3B5 are mirrors of 0x3D4 and 0x3D5 that are
> used in monochrome mode (bit 0 of 0x3C2 is not set), and 0x3BA is a
> mirror of 0x3DA in monochrome mode.
>
> A vga_port_active() helper is added to check the current mode so that
> the monochrome ports share the same logic and env state as the colour
> ports. Reads to 0x3BA/0x3DA also use this helper, so the 0x3C0 address
> flip-flop is reset and the 0x3DA status bits are toggled only when the
> accessed port is decoded in the current mode. This also means 0x3DA no
> longer decodes in monochrome mode, which matches real hardware.
>
> The extended range also covers the non-VGA ports 0x3B6-0x3B9 and
> 0x3BB-0x3BF (LPT1 on legacy PCs): reads return 0xff and writes are
> dropped instead of reaching the real inb/outb path, which is harmless
> from the VBIOS's perspective.
>
> While these changes are needed for the Aspeed AST2600 VBIOS to run,
> these VGA ports are part of the general VGA spec and might be useful for
> other VBIOSes.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
>  drivers/bios_emulator/besys.c | 50 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
