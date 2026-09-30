Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81BFCA5FC7
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8811F40AD4;
	Wed, 30 Sep 2026 17:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iw-J2QV4cjsD; Wed, 30 Sep 2026 17:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DB93340ABD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788670;
	b=WiSsccPuajYcmVTxLZtFGiMMpUtjDG22UgYyOXDxVMoOMv1C85EA3RpHSz0WAk75HAol
	 ZwhjhI89eM/+R/raA81wVHlajStngo5q1rQzRi+AFsDwfwwQndrwXX8nkSxaInJ++hRDa
	 TFcUtHAeA3cZfB6GH8rUUDB2JCRBYgSRJ0Sx+ZYk9+tCGpZ8uzk+VKhsmkHna5pMqtsL/
	 XE7YodobyJUcfCAo7YdwOP4rPzPeA9T260NQOKXk6pruSjsrP8ktOf+tl2hFqUCPZRc6e
	 2VM8Afe/XSYXrM90Ro/wdK1+S+j+3Tlf0B0B8/V2L7RZQvTMZtWN4PcCupscEH2YV3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZdJGg7Ase5aUjB/iwJC8B8sQ6AnDVYpjZxHrjgUQBK8=;
	b=GMIfR0Hzr2WfWKFIVM95nInXstK2kTb1bhQBJ1BavfedtA+jZDxUYvH5x96VO83RBSqI
	 9fQqA+hl6h/QAx4L9dRgwhZQ1Zgqhwi35SVYESOR2a5JL7+LKYahq5ZKqnwwCaQLslqZJ
	 roVrR8aOcY6QQ6bpk0QIZNxnDI3dCkAzInjuOc4PfGgba2TA80wkP37IE80RUHw1sM3Qd
	 nTWNyC6CTYnwmG7bPDPleQUJkO02tRiQBgc8uoHdh1ETsaio9BTRtjXm5B2PJ+bW5EL7B
	 tkgESGl5fQ5PHFdNZie9LVFwDv93GmWSdv+2yTxarbpIf4h9SvMnQSATxiTakWRkC6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788670;
	bh=ZdJGg7Ase5aUjB/iwJC8B8sQ6AnDVYpjZxHrjgUQBK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JBOB8513YaoBQF7kAvRMQVOdeerfwKg3rtxEMcmsdGgzFwRgZ63EQU1R9g2KAdvVu
	 wlGCyFT90xodbakz/tK2O7EoDq06AhYz6ihMJ0F2x6zZf5jkDp9SBmLinVdQcgLJW8
	 6fpPE6Rp89zwTayE7jVJCG1OukqxqZ4HQ1K6931Ew5umSAj5GDuQ2RsYmUeGP/0Wj1
	 1TwWFtZDCqm99L5PAbfyjKze8YYwfk8/VtaVAY/qUqfincyjPT4aseJkvz5a44z2Ix
	 y+31RHc9S5tsNvQocUeOUDtT6E4MzAFXIB5mcYRRKxzBjOgd+GQC7C0SAsUwyI6NG6
	 /3aikSWcAsO3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB93340ABD;
	Wed, 30 Sep 2026 17:17:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6088534E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5715881138
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WssAq5Cqbnqe for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9DEE680E9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788655;
 b=jh1hAtzlVC9PINVTZIm/Ac+iEDrcg/q8cgY0kxU12BOJ2V60R8tUMcq6vjKV1+UBtzvl
 gVTte6NL72co0c4fnUt7AqzwCfCn5hN+KSmwtonrvxW0hI1t7NFP7EblaIbEmorW9f94H
 +Ope+Mm+KSSx+E7mfGSm5GQcV4Aqbx9GSxx4iLRRZ/F6bm5ScmlmAwqhAffE5PddOfYrj
 0he1SznO16VaNfXqOWPbv2AMLV+iN1IHciEskWfO2HhJphcQltKyGmeUGsuA2CKmGfUk6
 PLxx1abRtqsVb7Vgip4ujpYJDcYW2PX1Q+HPK8HB/+0caE0jruldWCJsJZQUciLELBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788655;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ZdJGg7Ase5aUjB/iwJC8B8sQ6AnDVYpjZxHrjgUQBK8=;
 b=ZAhNp0Q7rBDLSc7ySNrm21b1pDOhxRCTKmXTHCFWXpz2tKiBaDZoF8cduWfq8y93HVnX
 b20D3Sv13+mpdYhLfSLPG4e5zEq4MEMdVJaEvzNjyokwvU82Xk+WU7suKTT9djOZPqUsi
 GGuEVeafbNvywa2LQ7FpFfytldJZ9JePiqBSfSDawC301p458LF2uMtmfEMePdajBjPZh
 mkLcj2tWGkBoKWmWGHpkhmQ164Dyo5O8wPG8jZ/xT7Fqh7W47LASeBu4JCRFTnhqqBfoQ
 KcuDQMifYc1v5WMailRQbbPNQgoaApKlRZ84NqKdpnw9mtDoE30iduCWrLEgcOOBnsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iu5C5N9o; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=iu5C5N9o
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DEE680E9C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:34 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81bea216172so2485297a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788654; x=1791393454;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZdJGg7Ase5aUjB/iwJC8B8sQ6AnDVYpjZxHrjgUQBK8=;
 b=iu5C5N9oSbBw9MlyCVhFxPwRS5wmv+ZEp/06DqE4zc7u8Uf6SSSBebxFzsN1y9sZSF
 glFUvpyNi8YSlJQp7uMdJvHubASWx65nfMphFHJrOZT4/9Y1HlA15XEoh9cFw0cSfyIW
 3vxcFo9HjymZopZUWFBTfsRk+aopHmlAnZy48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788654; x=1791393454;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZdJGg7Ase5aUjB/iwJC8B8sQ6AnDVYpjZxHrjgUQBK8=;
 b=RoJd1mu1yXXxQEfPCn8F6XQP2JHhH2ZUuRBMxdKpIpLWVOUQeLD5FElxyJFcJY6BYL
 BKNpih2sltJuaGGIj2L7hoDRhEND5R1BfhwBBpH0KwqEdYZWSWcAWEmzRdEc4ZiVtoCO
 tCGo7eLeUJOgfhMhTEMXN8pCnrbLWexe5XZxlDaClDyX9TlEU6t92GdBEHKRLK80a/ks
 jYfcaQZa3LK6o+6LDHHMHzQsZ4IXB0Ow0MaU1yNj1xdJIN5fje4xxNijh8sZxBEF7Nii
 bbOrXKlbFuQrkrr6PY8jWZX4aNKfYolJ1bLP2Erp8VQyNuXiMHoeS+j091uXWZ+EE1ce
 2kXA==
X-Gm-Message-State: AFuF++lXRakZJACdjxAu8/0Z6R6ioQvHsijM1RVkDH4qSR80pL36QpIt
 fibwmKIwqsOD26lMjEX5SCgLLl8VdyOjODBclceDrjlvQygaGLDN9cGelmdwJJeoWWc=
X-Gm-Gg: AYBFou26G6Y70rPAeNBge2NlKKKIvEBrZKEHrbuKFaSGdUiregm/RrGsJ+JUEtJKGYT
 ZmTI/hhqOpOtIU9/X66wqG1AcRo3yx3JF2e/FMNLJ8vwS+tLjK4gFizdT+poGyh5DNpfnUkbQDJ
 KnNHKDfbGveTFAzhJ/XORXueDdB0x+o/TL7UIS+p90Ij89JODhsvbix95B4Cm+TqkEVDPzJr0qd
 4aVqc68U8VVnZNSmVHSZloRkvrO4jPVy1IzYuPYaQtgSPoP4pqgsM/g2NfdHD+KMVONXgnXepc4
 HIZq0XpYpL9E+omegaQ1gQm0zTKvytVVtXiXRflWJ9vn6XMOAYXJuIL5771d5WcoCLEWiUuwUiJ
 hJZDD49kIgTxDnrsfk1goGbtKkngux2nYFxOaxDAs5jxcXTDrXhcTPBaLMUhJYe2MT2WNcZ082c
 8GhEoiVj5hySVSWgrwn004FTS4pFCOYWGo+s9SX4/ofPMWXeJN9ilM8T5J4kOHOoW1ZrithJ2Qy
 r9CyQwtgaVQiuwZgX/IXcTfnx3kTLjYFQPK5uwkEGx8HvjC9x79pQ+eZMex6PwZf2AMF98E85Oj
 kbLdQnbhLHzs4nWCkw==
X-Received: by 2002:a05:6820:80c4:b0:6c7:af50:b2f2 with SMTP id
 006d021491bc7-6dcf573d3dbmr2181939eaf.45.1790788653649; 
 Wed, 30 Sep 2026 10:17:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20260913155242.84148-1-aford173@gmail.com>
References: <20260913155242.84148-1-aford173@gmail.com>
Subject: Re: [PATCH] board: davinci: Remove DA850 EVM support
Message-Id: <179078865294.467656.574958735300152767.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 13 Sep 2026 10:52:42 -0500, Adam Ford wrote:

> Remove the TI DA850 EVM board support along with its defconfigs,
> config header, U-Boot device tree overlay and Kconfig target. The
> OMAP-L138 LCDK continues to live in board/davinci/da8xxevm, so only
> the DA850 EVM specific pieces are dropped and the shared README files
> are updated to no longer describe the EVM.
> 
> The SPL linker script in the board directory is kept since it is used
> by every DaVinci board.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] board: davinci: Remove DA850 EVM support
      commit: 774283055ac6a030be36331e39b4be0c4a418184
-- 
Tom


