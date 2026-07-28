Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6BDC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DDB740A57;
	Tue, 28 Jul 2026 18:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GotpGCkPtfMe; Tue, 28 Jul 2026 18:53:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48C8740A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264804;
	bh=pF9Ka0GRgZWOBczBuH91vr9VM2voqeyNVuxhpio3xB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMeLzFkAycnoF/kFPxDpxeRnZukf2QTOAXVAPxOUXnE8sFijQN8Myj0EmK5Wl+ZZn
	 hJGo8CJoJQsAE+8K5cp08t3LJtpJn+py7PPfEuo7aMF+kEeWWUqtma13yq7qkKafxM
	 DjTmx7laeXGs264MuFZBl8MqdEvyyfI3dLX6IvHO44A93PTm6oFy56lboG+ATeL64o
	 rO50j6jf3x2yvlXdocRzphcDtZQwjA1vXORxZRdF7QlfK7RDmHL1j0fhIlPlmLYUJk
	 blNiqiQDHWu9B9G5Zcwrz0olabcpSBvGRu7TKMKASZSKCCd2CsGWxj0Dw3ajUYkOO6
	 UxqdxknhhUCRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48C8740A4A;
	Tue, 28 Jul 2026 18:53:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0565426C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBF9460A43
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_EkssVuEKNK for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:53:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B71FC608FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B71FC608FD
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B71FC608FD
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:21 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fe400c14aso124394a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264800; cv=none;
 d=google.com; s=arc-20260327;
 b=DCdhnNYMdVCubGUs9OCwHLYR7nWQPW6a/Q4Cp620b+TUgNYYAZ8q4adyzF6N1q+vaY
 pCPZQJ+UYN3pysJPnUXtWqYJ0g65tKPf2LA9pEnAyFsiH67SilDOel1Ohq6U8xBkAeJp
 DQWv1jaEVN4GWfpANCYNY7jYK3vUKuB8PDV2DeF8AMe9fevjdkEcOCTHjtXqGjFOTPdE
 +haRhqu9Y2BWfjjFQ+qlo1Ahp8BZmXXJ4Aqm0D6yRjpiOHR0lFw5S0l2oXlPOCgh2Sj2
 Astf3WhGeVQYnzS8WKvSAxlqLVm5a+k0336a5EUhi/k2gwMQld3ozmz1yMONSlIlPHbW
 qOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pF9Ka0GRgZWOBczBuH91vr9VM2voqeyNVuxhpio3xB0=;
 fh=bgUFEcBYfJUCcOuYSy1UFwg9ErLTm4lhm55UpG/JFtw=;
 b=nmosmFGq64/f//B2yxqwHoSGEQQIw0h7U0c6S/SkJ0y+YbVNa1cxAwzs5/Go3dRqDt
 Djq5gS2jzzAuvKguXSMUEs6UDa0emS9e6JHlNFVJP2nML7MAlgRaD70HJWw7n+IGZkz4
 IhKCJ9Zr2CIJoxkIoeJg+QfJvPBDA9koyvHDxBvmPxX4Hti/Uit1YwCPzDZB0b/7f9nl
 pDD5IhpJPzbM3pHhXyeWpf/4figPDMtln2y8fv+VFnZlQB+IaaL8ABE7sVlfXpwp57UJ
 S+voaBAaUM1Epm2TyslSPK4k/AYCWKS1PAGGcOJsnS7y+Udzl9jdQzTNsvLIUVvrOL/A
 GsIQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264800; x=1785869600;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pF9Ka0GRgZWOBczBuH91vr9VM2voqeyNVuxhpio3xB0=;
 b=EPgXYDQP740KvyFke/wmLFbIJ4JqBX4bEOk5T6RKk+/U2/GLWe+QfRm5Ax8QCQWrKh
 4G9HogPHUyhMsOh4z/ctglxkOHJRBXHz/7duJssykzcPtsZuuo5xOUKK/Gjs7xjMkm1r
 mLewSFSSho8Cn3tXJvJ0/vMhpuMWufhUGAwODWB1xgRNFl+3cGdohBTNsOhr2SQ6Txlk
 tPruTC2KuhN8/vk1oY2N6Wkjf5II5cS1eZdqGhVrqHgDXVw+Q/zQqvDMK9mLjllFPgah
 HMpIDf3BRsFgG5doqGBUAKeUUoXSQl738HAlU8rB8YtRZZ196L4WNP1IXAwJxwJued/Q
 39Gw==
X-Gm-Message-State: AOJu0YweCW5/BvbEn8zsFZqnW/E1uWQuypCyz0/SwSxcVNY+9EmFSkRd
 iloCJQHzkEre2V5pRmNQM6SHe/CRmGwJgAw0HtEmswjS/r8CvXSjk25Z5crLC1WBVm3PvzeLMDU
 Jo7h0CnU2Ww/1MQOdF2uIro6gOkvLF/ZgnxQScnDy
X-Gm-Gg: AR+sD13MADGlvTgUj+IluY/xRbdt41Mpa3RI7L/p5g9ImZJNiHGzWwPy+JOXq38gHQ4
 usLU3KZYesg4BwGYFaCpbsNpZmBwnZS1LPUZn06aZOge8VYioFl5/X5zeAEEBE8rxYgzVrkc3Ur
 Wzs1ltFNKSYaUQivkb1fk0JAMlVOGdYWjucs8oJ2CZMqRYNEVrICPDkuuqY+CMO4t7eZYm/kKCR
 CQMByE589O3WLa4lY3yc6ItBmGwsxNllF1dmGiu/TKuU6xmq7+oCchBOmIEVadSEd+kJDk=
X-Received: by 2002:a05:6402:241f:b0:697:cec5:d056 with SMTP id
 4fb4d7f45d1cf-6a034942cffmr1955135a12.0.1785264799810; Tue, 28 Jul 2026
 11:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260728175333.90971-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260728175333.90971-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:53:05 -0600
X-Gm-Features: AUfX_mxoTgmMgRJiv7BdKtqGPaPF02Z4GNNYZ5_VgKC5wWumuvOjucTeHv3gTUA
Message-ID: <CAFLszThuErS-TiPwiC-AoK0n1_8nwvn82-uTf0tV7-oHUzFzYw@mail.gmail.com>
Subject: Re: [PATCH] README: Slightly rephrase env set and env print paragraph
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264800; x=1785869600;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pF9Ka0GRgZWOBczBuH91vr9VM2voqeyNVuxhpio3xB0=;
 b=OOyEq5eeZkKlGT/4RCVBodPxB/zePkYLRXp6KlnQwxTpRgonPMCTN8dNFDPqw1Og2W
 X0BdC/6PjvS5vstN+2sIUTiTGvtY5sx6E5aBUj2uDoraKC5tzs0BHcc9LUlM9I6dWLN0
 7S8IsKKG8LQAZGdYel/5xb6bnnn5UiBQni5z4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OOyEq5ee
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

On Tue, 28 Jul 2026 at 11:53, Marek Vasut via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> Adjust the paragraph to make it a bit more readable.
> No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/README b/README
> index d6dd6c74619..f740188a4bb 100644
> --- a/README
> +++ b/README
> @@ -753,8 +753,8 @@ The following options need to be configured:
>                 `${name}'; to execute the contents of a variable
>                 directly type `$name' at the command prompt.
>
> -               Global environment variables are those you use
> -               env set/env print to work with. To run a command stored
> +               Global environment variables are those you use "env set"
> +               or "env print" to work with. To run a command stored
>                 in such a variable, you need to use the run command,
>                 and you must not use the '$' sign to access them.
>
> --
> 2.53.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>
