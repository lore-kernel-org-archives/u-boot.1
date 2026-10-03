Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13855CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E428F80F5D;
	Sat,  3 Oct 2026 13:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zOWzzFRJdIIS; Sat,  3 Oct 2026 13:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 92F3480ECF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034420;
	b=lrIIr1Nz4jKkjlR3lP+jXgtPbh5jmjbHqBxexcBX5w0mqSM5GglnF9KfVrLPc9r+CW9y
	 fgpPvPJfW2+uWK4VW4RrYevH1UqdZnuI1p9rAvP7Rnjob5/P0wiKs2/iW7aACbZNNbKph
	 6qz8meXZNdgHfSPhFRed1Fvg2hSMt4QWDdhPYyEubkAo8mzWFzsI6R65v5rsAOpA/ucsp
	 YhVYUVW4+t6pLrPJqE0vWYgh/GtTbOcMK6WWq0J5vnOQyFD2Fk6oPSHeD3XtMZcdbtMXC
	 O7BOLw9TRIgYMsuXnJF2ZX19TH09vomltdeXnih/QacVTCB1JkDCnU5knp7fZB8X2Vw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d7+J6ENWLjU72HHNpiNxL2L3VR+bAcDyBAcAbTumr9Q=;
	b=E7I0v8YDl4IzBDcbUOgqpVDs7xykHaEEmIlLXB4/EmLEQ7K7Ix/eWiroD7Zevy1Fk4za
	 2fpEFU00qdiP4L0dPEEGCZYfD0Hju+kuIX/oEzHGFDBUk8SC6bHrqwbKdVrWaqX+0WbhX
	 8XQ4ac8N98KxVq6KujsWOPgHOxaqNnXsiMqCmjUnZy6zGN69/i09afBP2xpg/EsZ5ffSI
	 IRO80s4sXYAwEBWDObQoC/V4oLjzxZk9C1Bc6R556AXzU+t1j+AiA08/whEUjxoVwYEEB
	 R7qPMnsIZhwhphD9SmbTUmUDZ9jnFJHOSa4l+xjrCxJtPLhH4D+zvwULO7LfmNCirnQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034420;
	bh=d7+J6ENWLjU72HHNpiNxL2L3VR+bAcDyBAcAbTumr9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yRJ7j9p+kA1WFXkCfX7RoeEKJv73gmYHmbQ28RYhp48zmaO+A9ec4/IOyBpWpCwSn
	 i4Rw4pNgGzBiVwcAiWSbmZDFKjx3qegQ4Xqp/Rzk2KmtVHOavrjCK0l7klsKJuR6qB
	 WQrMoaxFtSdwN7cOvKTNDUsjMUPDxDFV9bhHDBWHSiM+N5lo8RCx8isM2OANaqjd7S
	 RjjWcbxiihATnfLyM4Zz8DxnKsSYCNsrwY8go83R5eEYV7Y6Fes721C26vOWC5z242
	 GM/1pnYZ5/9w96jB/bOth+Erc3tkJGRRd47FGfDGu8WO7A8w4qguw7+0k/IB7NHzhL
	 nyXSXlvzf+UnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92F3480ECF;
	Sat,  3 Oct 2026 13:33:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BA3C282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E436A40FAA
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wp9ZZAmTyqh9 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CAF7D40F9C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034414;
 b=oU8YAskmk203/VFNNZ45pIHWWji4taqlYvgKW2Rhx4ExoDVqYMA7Zdrqs2Y7nGep6I/E
 GDhMVs7kyW71Egu2vk5Y8Y3OB9Sgbml3q/a3m8gk2+NiVnJ7ARtIStTdPRKBJ+2XM8zLE
 ZUShdVYxTvQlALunjjGDG4RL7CvBGtGblpdQqyYa7wCE64xFkXsynOYf82fpPdGwi7BkS
 Cdao/BbIV4HJ6T0gf4rQjRi7PrDDZUeTr5qg++JfQkuOrSbX+8p39KUBaK3Ijj5f1eHUM
 L6/RjmIPVakwBibf9GuA1guJxS+d/fgzRlPgl5/8j/cAneCoMmCZT/GG1jjFFyGZynA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034414;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=d7+J6ENWLjU72HHNpiNxL2L3VR+bAcDyBAcAbTumr9Q=;
 b=nxFLio84vEL7Sre7dHV4kE2v6R+ERPNSGe0cyXjdy/XOsxJxAacBWXKubT7cSAS6PZJS
 MR9q1L8HKxiwybod+aCwWqAOg8GfGu7UoxOeisR2Q4bTRpnhUpWJ9+CfFshch6BC1Gauc
 FmcoHge1npG15UDrGNxK3kK/FqCSPSncWWxycJvBEDNWlYLCrC5BuYJMmG9cQVQlfLeS+
 C0ItIWbw3belvWFhthSBPKP7TYgqIuhPi8hkh54UCCjkImwgAj914egv1yNO9+I+hjNYZ
 MLc7IB5WP8hBrnPQ9/tMHCPHJaR9nuPxcf7H/MxE1+zkg4BYdflHQbw/MAPDPke4ryQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U4eGrjCC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U4eGrjCC
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CAF7D40F9C
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:33:32 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a605c198fdso528321a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034410; cv=none;
 d=google.com; s=arc-20260327;
 b=KNr/F1i2xqdFeQoAd0o9OVfa0YRcbJp3eIv/yQjzW9vIsGCG+47by3Sooo4YGltxkS
 mcJmPE0oVHvQ1OS5P9x/t31oyAyYto7dFhu57nhisYbsQbFcxP/htWPhiOHDaOXy5Svl
 +8F45vlCHOBa2nPz7cLQNRyV/VAooFBxA0CMm/BZJkh9oqfenseeFs3Qm0iXAGfwnDXA
 sbrh0/6LPfKf7yUIbpHTJsh2JSYWfHJxkYzYRhQz3OAHzEzRHCFNnecYexdWNmffvBmg
 PYO9qOF2PXfPIREQ4dT492u3CAFXtn+xQMFZK7OakT9y9lnTpwOzNSo1diKXBKqiiLwE
 FQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d7+J6ENWLjU72HHNpiNxL2L3VR+bAcDyBAcAbTumr9Q=;
 fh=3S9UjrE94HLbD5EkWIkZRH9CSfb/GA79SqMjCr4jlaU=;
 b=HvlGdk3ucQj2f+5zCBc+oFQA55KXEunGaNXUZGewJlV6eLqvU1L4/9kajkD2dQ3WJx
 Ja/h25xTpRBMKk4XPkhuLLKWrSRk15q2/1RmmUPzzA+CxkLDblC4I2ohyVbAAPvbVO/J
 qDOql3Rm4gYgeToFBsbZCk4zPJ1RAw+26wGqm4lAzISz3RpN06pAiQz3V8UqjvrsWRDr
 qYghWoP2ojceEZajm/JCZB0oeC8JlDX3ysYjFH0kFDmDFq0zHWXmAKkfPuSjTgBKr4qC
 0k950sw4ZyNexxfEjAXUqq7pcwQYb+7z9OvxiLsdqYj+xyeHkkYOOVMsaqWW/2E7tACa
 XMUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034410; x=1791639210;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d7+J6ENWLjU72HHNpiNxL2L3VR+bAcDyBAcAbTumr9Q=;
 b=U4eGrjCCK2f433JgrJ8euwd8EQ5K2phpGPO7mXgBcetNDzpZ0MdsVqmy3iu3dP72nu
 +TUI/8x6epayIlFSjxdFqTj0sdzDdxe2K7AX3NF6SL/0mtjGoJfu6bo+zSWfSo51GNdE
 +71mSxL4J83O9OC9kdDCisd4347o7CYU62sMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034410; x=1791639210;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d7+J6ENWLjU72HHNpiNxL2L3VR+bAcDyBAcAbTumr9Q=;
 b=iwITyZs5RAFbnhTvBtko1XpGE9wTrKW9ynSoVqRVgXv/9HRw6s2J4/tYRU/adS92kw
 /lKV6SYRRqokZrqX6x2dx2uq4B50jcfjG+C6eXqHR0GbQOucfAZSBMn4Qmd6sW3+ndOZ
 ugjIHkng58Fx1c4XUAEG2rsrGjEj0bCuH4e6sbfg+GC8+bvagF6V2Y/A7HeoS49mlczd
 DxS7LumCq3LIXsVdb6jZjpOvZTMCeLwxj/XhfcI5+0Cyme00F/GvOZCkz9wI8QSuJ622
 I72E4wagyrpPJiCBl5wxDT43ICisUfILvUiNuQ/ChHimXIKdz41klORR90VZYV2orIkt
 BnmQ==
X-Gm-Message-State: AFq9FYIL6/r19J6QdeRIsda7wk++EvsWd6+7NC5UMdkc2eXqLEoxel1d
 wFUpBfU+nziadvQ93LUWP7Ky4bj35+fMfCeQDbieSl2mrx6OVdB9Z4os6bUHzjVJczieWWmHwf9
 DiiJiZZw256dFzTWXT/u3DA37fDWkOOIY7LzDyi08
X-Gm-Gg: AYBFou1Vv6TTWOaXxxw4nwik2CWZnLXErcIxnbZeImt/YYMAC0+n4HrfdyztRwiN7Q/
 8pH/3WFGajGgYj7UAZVDH6k1Iv6iQLHonDrYozNYnUJ/VE5tWvwcvgy5wq11AHf4OgWmGithKmT
 unL22Y7QvLL7BjSuarUf1pVCoBitDx0vlvI32vJ2rfSZGmi+BiBJ1j7m73QYUgZulrAXDuNyzsR
 DPf4xnFtdCJ3Qt7joHk//RJcpGDCotc4zANgsnZaXRb8BUG+KbR/8X9ipmq6p7twdufU2YvX8B3
 Bp64T3lFZb0ZkTNEVeYbbUQXkuq51wpryNHV6ep9gaa27lgPhRHK9nE=
X-Received: by 2002:a05:6402:2788:b0:6aa:924d:8f2 with SMTP id
 4fb4d7f45d1cf-6af9e33ecb3mr4680382a12.28.1791034410302; Sat, 03 Oct 2026
 06:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261002073357.382228-1-aristo.chen@canonical.com>
 <20261002073357.382228-6-aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-6-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:28:49 +0100
X-Gm-Features: AclHuK8I4unzxLdJYAOqJLOPFzl89G3eFRX7BOTi_omDWBTpvLxtFBn8ip7Gxz0
Message-ID: <CAFLszTg8gYTkbPoFBpSBT=2yPOw78=9KZLbO9K-aBKmL8XrqvQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] dt-bindings: soc: imx8_pd: drop the duplicate
 PD_LVDS0_PWM definition
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
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

On 2026-10-02T07:31:50, Aristo Chen <aristo.chen@canonical.com> wrote:
> dt-bindings: soc: imx8_pd: drop the duplicate PD_LVDS0_PWM definition
>
> PD_LVDS0_PWM is defined twice in a row with the same value. The LVDS1
> block lists the same resources with a single PD_LVDS1_PWM, so this is a
> plain duplicate, not a typo for a missing LVDS0 resource.
>
> Drop the second copy. No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> include/dt-bindings/soc/imx8_pd.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
