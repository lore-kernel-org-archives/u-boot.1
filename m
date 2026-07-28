Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BF8C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17E4280F1A;
	Tue, 28 Jul 2026 11:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQsqJ_Y1zncO; Tue, 28 Jul 2026 11:59:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E61398132B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239958;
	bh=CltEJvFpTnXi2YdBZzZI7c9eSGis2XjzWD2QgSPaja8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AmLQHLUwu4duh3FziBHVlrV+QtZ8/+Qg2NVwM1tfih5uhB0mM41l6V0PMYKJs1WeU
	 apaHhzv3CeoxuqsTKFXd+JjrnWlnNhksSaU4OPLxpka2uYlAMtU0O6kytOSXEuJDw3
	 uCIyxG9c8ALKyL84m75iEhsmfVoHep9NMvS441lt+4h6yW8ZJj2n9us1JjT7W1Vg9x
	 mwmPcdvhLUs+7e9C89v4PFjomb+QzpBYV/xGT80GlHk5jXXRWD0mju2mNNx+bTk35k
	 V2PJla73EePMx94LCDwHmdQ1B+i4CgsGzL8/oDkxLIunKlOrUXUVQjowDJe+HNXXHU
	 2sTQIE01c2tfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E61398132B;
	Tue, 28 Jul 2026 11:59:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFA7545B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1563400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3FP7nijMS_EF for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:59:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EEDEF40085
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEDEF40085
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEDEF40085
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:59:14 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69fc856b00eso2949664a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239953; cv=none;
 d=google.com; s=arc-20260327;
 b=U5HLmt9LWFuzJKt5UL4y+LgDHOA8tO+2NvMVaORsz2GU3EJKLjO7SyecCJ7Wz5XAu0
 VHciaqZ9/rTl0S+7h5KZzFY4S63sSkcbA6tOIdzWswtjCdvMbUAXj9W7Cb+esDR9qGK5
 EcXRcyGLhfbApO8Nwxhq7VZNqsu7gR+7L49uuyaFA2OMlctFJXmXBPfKU9ORQKuwr/A5
 WL5KTXnzUW/ajSJ7+fFGqzRUy34eyRzu1qr/haJ2w+cdYFHh7yBUIXn7dH4TMDKzO6I8
 dtNMglQXRNnE1LMKDU4M4ai/PROTBL+cppws/7jlXltv0LIOhQMAH6qYkuRXQRhzoQOX
 ck0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CltEJvFpTnXi2YdBZzZI7c9eSGis2XjzWD2QgSPaja8=;
 fh=m+/eSa55FaGpgSozVLOm739jx7xTt+qVKPfcydVTKjM=;
 b=sAq6oUk8IC2+yn2RjMaCdpjCizWE6fA9yn/8xhl42FY0OC/kVr2kXC2oX9k7UUOkFx
 omFIFJFFTDwcfnX6I8MGUPum6E04jMo/alLMrOTbpMlE2/oBQBYQeJ9zjdr0uKXNUxx8
 iEnIv+GGPhEmtpc1WyzcHMiggMawpjBWIqErRezyuPmrx81m6U2Jx+oV1pQG45iBFIH5
 OPiko/2pKWhCftMTcGetmYvY1FMR882rgkko64Si7o1OStgWp/VnjXqPVIKOXMAX09ii
 pyJgN7z7jd073koHCUV7VyynMEP3dfb9j+HfquvNPpXEl3lD3HB2ftw0kK9ZBKemvSCt
 fccA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239953; x=1785844753;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CltEJvFpTnXi2YdBZzZI7c9eSGis2XjzWD2QgSPaja8=;
 b=S0sJMtmR4WKDFgEV2sGsxcCidRrOe/3T1tFCXXONPST/DoGGjM+4vmZ+Nh5CZSDmHl
 AMXKx7F7cckyuGfQYLkKd1i7NXafcK+Db2Q65iHDjsmxpzP4ui8PItZ5zWyMmfYjzCCV
 UMo7rDaMrka05sr/GdY8VyLVmh7sIPAwsaBuHocPmQcO2FUPbbRfLgC9hTOhB3CgH+Jw
 M7FybaokE8pT1zgU/xFONIpc4zmIZ34xsAOi4q5DJytSl0h5+VfBgfcuaCzBhpQ1oDXA
 MgZI/7v77oXNGamUl82IQkUmBJhY2DvFgmpiy2zr7gjCwOSnsYl2C+9HRyC+D2n0/7I7
 KFAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RooCPqhS5SYsc+hLb1X1JAlVWGqiTyS1vhLLKoUt05Li8toA8mpwUYLRsF2mODP772ACd3fjmc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyJrv8LxxBVp2gA7kyAiI6NRH0eL3146axOmRCuBVneQ18loRrE
 a5yAXcmsXZL9COXqdaf/OzSvNuh5VystYLG3flN/xpq2mMUS1OuLuge6wAFamYmK+dQFwMh2ctc
 z7SMkdKZyIwX2Zy6MtsJBrex4rIes4k9MugzpNo0U
X-Gm-Gg: AR+sD120PyHJbUEANiNXqPgHoEFFcBIUhYQMJsiF5M3/Usq7dUkig2y3YzyEUkzenFA
 bSBQXJN/S7Y7rCjjKE/pYPHpY+qPEcZD1b72DVe7dIo2weW6BY7ogTxLKtHpU7xbdg9hFSJy0Ct
 eKLcLTIc+ENG7IoMW1S0+PtBLJ4J9DSpbthv28hXEQLWSE2LhU0n1U6d4zHImyaqKei/fm4RlK3
 5/SkEN7sjmQrM/F5+C/pnL5EznMfFiagxichj+YW/VKRCjHgpPA5kuwlEBq
X-Received: by 2002:a17:907:c009:b0:c19:6a94:5bea with SMTP id
 a640c23a62f3a-c1f7223e5e3mr96771466b.40.1785239953005; Tue, 28 Jul 2026
 04:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <141397f1be56cf730a3222263c091347fa4cda4e.1784408712.git.daniel@makrotopia.org>
In-Reply-To: <141397f1be56cf730a3222263c091347fa4cda4e.1784408712.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:59:01 -0600
X-Gm-Features: AUfX_mzcKVH8d3mQKogASCCPGo6YtYPcoBUBF-ATlHMvAsDUbOkd_pL4D9pCFTw
Message-ID: <CAFLszTi3nVrjYq+8NH1wb0iv0oU9f41ZKum1ZoSAMMC=H9p0+Q@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: give SimpleTextInputEx its own WaitForKeyEx
 event
To: daniel@makrotopia.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Gregor Herburger <gregor.herburger@linutronix.de>,
 Casey Connolly <casey.connolly@linaro.org>, 
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239953; x=1785844753;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CltEJvFpTnXi2YdBZzZI7c9eSGis2XjzWD2QgSPaja8=;
 b=DIqRoAII4ZDcXvryWAnTa/MuodYuE4d6ewhfIqRmxKeC/lrOJTQ/sjlRjJhnDSlQmy
 r5QcYOsP68pP0eutrHZZraCahyfhGtenCzlAIGH8nyBYlZ1ocd+jKFX9enDorHb2hU3n
 kgZgQJqeVUYG52vx6NcnluaLsiV7TCw2uj3to=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=DIqRoAII
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

Hi Daniel,

On 2026-07-18T21:11:38, Daniel Golle <daniel@makrotopia.org> wrote:
> efi_loader: give SimpleTextInputEx its own WaitForKeyEx event
>
> The console input used a single wait event for both the
> EFI_SIMPLE_TEXT_INPUT_PROTOCOL and the EFI_SIMPLE_TEXT_INPUT_EX_PROTOCOL
> by aliasing wait_for_key_ex to wait_for_key. The UEFI specification
> describes these as separate events, and a client that opens ConInEx and
> drives WaitForKeyEx independently of the base protocol (the Windows Boot
> Manager does this) can then desynchronise against the shared object and
> never observe a keystroke, even though GRUB and systemd-boot, which lean
> on the base wait event, work.
>
> Create a distinct WaitForKeyEx event, and signal and clear both events
> together when a key becomes available or is consumed, so every client
> sees a consistent wait event regardless of which protocol it uses.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> lib/efi_loader/efi_console.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> @@ -681,6 +681,7 @@ struct efi_cin_notify_function {
>  static bool key_available;
>  static struct efi_key_data next_key;
>  static LIST_HEAD(cin_notify_functions);
> +static struct efi_simple_text_input_ex_protocol efi_con_in_ex;

This is a tentative definition that merges with the initialised one
further down, so a short comment here noting that the real definition
is below could be useful. In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
