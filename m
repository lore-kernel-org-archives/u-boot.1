Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F1EC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A265407D6;
	Mon, 17 Aug 2026 16:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8QfdvSSHSxK; Mon, 17 Aug 2026 16:47:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03D59405E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786985226;
	bh=+uh01OEJOI7vDld2upqovsGCbZFx7dpk/5dB1rxkOiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bq0PChhjAZwC/RC1XxbwUDDQqPKF12i5lFLdQrZ4dYZYo7gnLfZdlF7DVt/rAp69B
	 SaK72eGCFtYNC/alOLdrhzGSpr2n1UjMLg9zM91pPG2c7XFlY0Ag3Ydj+dv9/C9pfW
	 rzrsx1Kak1ZjtBfELNAZ5mx9Ujp4Ki6jT/Z/iym9yjOjicjRvG09zURzk8eJf5zFUx
	 uDllC0RNnV2v/Va9edhOH5jaNJRf7foVolAcI/BVSQFaTyZVELsFBtMfJS3FBVRKpj
	 B9LwTzdi7mzZbFkz3WgsklQI7MoX3k030xvDcxlykb9fcf5JfatiBbSi9r9p1V54zW
	 BfxS6uT6ngm9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03D59405E2;
	Mon, 17 Aug 2026 16:47:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 758A5333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67AA140214
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZmQngchUd3MW for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:47:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6060F40229
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6060F40229
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NIodTUtS
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6060F40229
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:47:04 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so40169425e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786985222; x=1787590022;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+uh01OEJOI7vDld2upqovsGCbZFx7dpk/5dB1rxkOiU=;
 b=NIodTUtSzFyAEar/wEMF8cbPwUzMZi2oexJFMfU8fCPvAPeVgxmxBLHxfJqNhRi3ax
 DEGzI9ALYTbGV4CW4l9elrqvapQhsCnIEVCS2qTyYwFJNLsW4g/M4/kXZjEKX5OsSpi/
 KDzHWbjJIR8JCfLz+0E18AB6myK0ER4fXhkgg9GxlCKqP8Rqa56GSPlFNmNFma6IMsVa
 M2Ol/ZVFTegmb66BjQuo9AXsB3fW+ELZ7UyFMrd9Ra9hFFyAJsupwlWjwx0Mk/ICjeXe
 j02fWQNk2sGzX79X/IxHqqpCs4XzFhicpkZWMV18blbzFHlfbPT0WyzPMK5rOlQdMIWP
 iRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786985222; x=1787590022;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+uh01OEJOI7vDld2upqovsGCbZFx7dpk/5dB1rxkOiU=;
 b=cDs3bgV0bkERhpX0mqC6LPxsGdyxjTqlmTRG89wBvdlUFYkOYLTj80j4nBBCDaAmjI
 Y734qAPTabYIhkGJblJ+oWR0COoenu1zXJYfW/KL8Rq3t2csR9k7SHMuD1hNAoBNCPmT
 hTxkvmqFs+VeluY2xp5xhF5YGrjIBv4UUKo+61HjKSkDxtPYxt4e0ttwo48ZtlITWC9o
 Q5BXKUvV6W2ThA6g8IWJHtBD2h16iz6qOouQar0DMF9lLZNEjV41+2+9BLwi7E3JLW+K
 f9u5ph81/sy3VAEA+P5nx4EUTo+TOkcPdGvKkjCj1T4yY7gzIcS4PTj8xh17Bq8OrY+f
 nxxw==
X-Gm-Message-State: AOJu0YzPj/GX5gcliFT2GpTEqMepId4yGF9keLgZ/n5ZBjKyhy1eXIuC
 RXgxN1iCsv5m1Yt7ev7cRlVohdIbSnyiYA/2chSJg0Ndu9mMM00FZrukmTXwmK/03X/xzQpI60U
 6yeC0oPw=
X-Gm-Gg: AR+sD12jC3lPeu6vpR4IjiJI6glGlnmqdutQBoq9zlJx5cHIHTLJB0cmsnz8XehK98c
 7LpCLo8rpQSWkAJAHvt9sALnOo7joJYYOYImBt3WfTzWt9/czVITXLt+s9r3KGUWgbcopVbFKn6
 HcnFREQc8+x/uLvLRYdQnB1gNAQhPhLEDy4FLTzs9TwdSUW53zn0sPgnzi5nA/7jNj6yscGggIa
 Z3h9Lft0JloPtLkHQVS9u8ZXH+W4HgGsmEycVvaJ1U2Ubyg/1aIoGZNaUstOfINAlYy5eZcB4MF
 lQrw1YvU6hKeUmCNekeg43eIWQbcpz3VDg7D/zXUXMtR54hCnO+5mUDbcn2x2nmC2We8diJXvWg
 3owbVm/l752IxtWZYE6k8PnoQVQXrJPk7hfAVW3hu5keytVAPDGdP6ALdt0g0aJtOrkdmBGXoPt
 K1SVSZhiygsyJmDIcjjzbIfiXV7cXR7aYZWb9EfxIn6c+XpsPTlijPClycNYGtfRMoHaGGdCfQ
X-Received: by 2002:a05:600c:1d1a:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-49987937fa8mr391029725e9.7.1786985222092; 
 Mon, 17 Aug 2026 09:47:02 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:7281:1989:ca4f:c9c9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm245247445e9.3.2026.08.17.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:47:01 -0700 (PDT)
Date: Mon, 17 Aug 2026 18:47:00 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 8/8] arm: u8500: Give Golden panel regulators unique
 names
Message-ID: <aoM7BEBLYau0Y_ux@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org>
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

On Mon, Aug 17, 2026 at 11:31:57AM +0200, Linus Walleij wrote:
> The Golden device tree gives both fixed panel supplies the same
> regulator-name. U-Boot requires regulator names to be unique and aborts
> driver-model initialization when binding the second supply.
> 
> Add a U-Boot overlay assigning distinct names to the 1.8 V and 3.0 V
> supplies. Include the common U8500 overlay since a board-specific
> overlay takes precedence over it.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

I think it's a bit awkward to have multiple regulators with the same
name, even on Linux when looking at debugfs for example.

Can you make this change on the Linux side and backport it here?

Or maybe we can use the regulator names from the schematics if we have
that (I don't remember :') ).

Thanks,
Stephan
