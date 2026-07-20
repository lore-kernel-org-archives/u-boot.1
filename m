Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F66C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1608D40715;
	Mon, 20 Jul 2026 18:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKD4vByLjn_u; Mon, 20 Jul 2026 18:17:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5381E406F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571427;
	bh=D0pkeQTuRzOrKSjadkx6Df191cd5B7iTKmSUsCzu7LM=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=neGkyR6ySl+nxqxMtT5PTXGmXdQdh6afr+wg0cVuOV9/OBDIvnpkCtYnXosk0mImW
	 jQRwUDR/a9DpLyuC4zK1IwLy4YxbEJceAmwMl2HvgCpP3gtwpclComTCy0gNMHC4Te
	 wlHO2FXPcLhIRIs+0a5hkTHtl25ZyX7ghfPDWO4CousVQqGB5wy/68VoWgjaxFSc4Z
	 I58upuaohKKzDlI5ONbMDV4skUb/Tu3EmeIa6wL7hdwOOYGAQgpqDybgUlDClN/NN9
	 FkK2mUpLBeeHeE15sRaGumgSXDP1/Kon4/vO1KZr1SeouXW83fV4nA9dlekV1ugm80
	 dYgkFFcnOkM/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5381E406F1;
	Mon, 20 Jul 2026 18:17:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E15A5224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C719780AAB
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFOU06cEWHtA for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:17:06 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 968FC80AC7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 968FC80AC7
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 968FC80AC7
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A6380433; Mon, 20 Jul 2026 20:17:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D30844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:17:01 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so19107658a12.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571421; cv=none;
 d=google.com; s=arc-20260327;
 b=lmKD86JtGUgcL/WCvnG6wxPAsiCPJARk0Y/4YoFINveLYcMt9uTyMOtYu9Wc8IjxHw
 s9LTh8OWQZvAs1WET5cykxqBth4vWgdzDvs/FOqBAOuK7Pv49rQK6U1kVaW7C2i6rOrq
 p9aDPqWvTof+yHFXrcneiimnxev1o/xtrEyX2zEWd6d4TscUGKNG/ATm3om0jIKOc8yq
 HvYUFdw2vWKJTIAwoRf8B94/R6L2ZQPQXsPilDBoM/y1oMLrw9xahkFSFSJMUxz4tMlR
 TZVCfQTpzV5IPt4M+/glDIC9LqTbTXpWNmqvtcauvyrGzqMVb4yDTw2y4/CXSwIuE7nY
 5VtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D0pkeQTuRzOrKSjadkx6Df191cd5B7iTKmSUsCzu7LM=;
 fh=HGFxqjW7EmEVgkuAAKalGIiLGTacmvL3ctiAmCo/d5o=;
 b=rG1JcqvMaXCLrFSHsmKJE6z4etKDXTx9wbypX9i7DHq0Uu1YbrbJLXblJzGmU6Gb5l
 l+P9DqK1JBfK0qYqYKqM75S2N3C4/s+kriIL0ZmcRwWrk80pCp2+j1a8WWYm7V1M6t5A
 C+EmsO5q4yr5DJXOzCYLV6juPnVcJaSSmUxh1/nClgv5qpLAcEjaKl6FEc4fTyC2P0U1
 wPJmVEHblPiMGswoRmc7ghTNgJj41YTRCwzCCsT0RwD8L3MI6PYQSoitqc/SsqbKcy95
 iCFRfn2ZyYPl2joQqWHZnNErieD4m3PftR5TQEk9mXSIZ36DFS8S/u7HiIzUzrPDWD8p
 X2KQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571421; x=1785176221;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D0pkeQTuRzOrKSjadkx6Df191cd5B7iTKmSUsCzu7LM=;
 b=kkmefqzJgbxsgbl7pCieLS8CwJK485WpDUu2PRr57M6kM+U+lLBKogLXYLGT1OEKXd
 /aw8JhgZ0+VIA4/FdXb2Xx5PpUpZOOK32BhLIoVbSh4KQPqk8cE1eQSg0wQg4Z2z4m1/
 sGUpYc6r9etVVyUypCBlLgP7QPletgluZTyMhyNt/QG9It07MzdIlH5CwZuhm+Vgj86J
 hwnTJwTwMfiId4kA+ZOWMWy7AnkdGUrfv7BkGa/7/GVDu6U9VApeypMMybj5Sw/4ihnv
 XZV4EOdDmQWx/vvBc6S639hC5dD3IviT0CqIEdaGwBUNDEUTn+tEajBBBsMrBZbfhxBl
 1qNA==
X-Gm-Message-State: AOJu0Yw4JddB07pApQujgJIOHZ02h44wRYHPMeLhY6lUU4dpKn0G4+34
 4qDFwShTU/tKWJLXCE3WFpMFnsEmrcssexcsaFebWtJs0gih87XKngZhy6IuwMzK4pXsbE4fyUy
 phrgAL4O4c8AGjUZJ/DobX35jprQeoEcIlUZoktLN
X-Gm-Gg: AR+sD11xVjjc9P4xBgqthht89BxjRlXKfyEHNx1ZAGlz4KpzugLRn5zXMuF+2Ba6lIB
 AT2CX36nm6sKlntgkuk6X7JYxy2UpsRqivD3FyQkhrj+zyGwgX25m3QzoxPVYIMt4iVRZ95yGHe
 cyI8dS7R+Ak9RUqRY92ncf3GFQ71R6HQeVuFiCe4Ny58VgRWWYAO+7VUEJvuGLlW5/RPNrf8Y8E
 GGioKmeVZTWpKQrBwImnsxHfHTp11xiL3xsGPaPj/abtD0LTu9zp/SNh1tB
X-Received: by 2002:a05:6402:50c8:b0:69c:7a1a:2f25 with SMTP id
 4fb4d7f45d1cf-69e652b0567mr5450831a12.19.1784571420964; Mon, 20 Jul 2026
 11:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <20260719-aspeed_vbios_fixes-v1-4-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-4-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:16:15 -0600
X-Gm-Features: AUfX_my0vP7Zbiv0asODNNmr348VOYR9hT1foBbD9PbIx0sQZ7UMlpCEZyjH2gk
Message-ID: <CAFLszTjDbi1ZtC9=+=P6fiw0D-ZqewuYH56LwY0U85wLAr+r9g@mail.gmail.com>
Subject: Re: [PATCH 4/8] bios_emulator: support 16-bit reads on VGA port
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571421; x=1785176221; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D0pkeQTuRzOrKSjadkx6Df191cd5B7iTKmSUsCzu7LM=;
 b=XrRvo5utSqVEORHgeWhqT3AlpuCAfDMPZWaWNjxdw46o5DvwkGhIvJo2rgicfMPLkc
 IPpKUhcEJvSI5h6OFlzoAHMMFx0CMU+tLDVOWUcYMabytY8PNz6239ZU0R7iL9Yngcfn
 ZQeR+Ov5Co9txUoJw4ShaoBpcj/T3bM3S9yVs=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XrRvo5ut
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="XrRvo5ut";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anirudh,

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: support 16-bit reads on VGA port
>
> BE_inw currently doesn't handle 16 bit reads on VGA ports and falls back
> to LOG_inpw, which doesn't do anything on non x86 architectures that
> don't support I/O ports. Implement this 16 bit read as 2 8 bit reads
> (similar to how BE_outw implements 16 bit writes).

Nit: '16-bit', '8-bit', 'non-x86', and 'two 8-bit reads' reads better
than '2 8 bit reads'.

>
> The Aspeed AST2600's VBIOS has these 16 bit read instructions in it, so
> this is needed to emulate that.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/besys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -612,7 +612,9 @@ u16 X86API BE_inw(X86EMU_pioAddr port)
>       u16 val = 0;
>
>  #if !defined(CONFIG_X86EMU_RAW_IO)
> -     if (IS_PCI_PORT(port))
> +     if (IS_VGA_PORT(port))
> +             val = VGA_inpb(port) | ((u16)VGA_inpb(port + 1) << 8);
> +     else if (IS_PCI_PORT(port))

BE_inb() has a special case for port 0x3c3 that falls back to
LOG_inpb() rather than VGA_inpb(). Calling VGA_inpb() directly here
skips that quirk when a 16-bit read straddles 0x3c2/0x3c3. Cleaner as:

    val = BE_inb(port) | ((u16)BE_inb(port + 1) << 8);

so the 0x3c3 handling stays in one place. That also mirrors the fact
that BE_outw()/VGA_outpb() have no such special case, whereas BE_inb()
does.

Regards,
Simon
