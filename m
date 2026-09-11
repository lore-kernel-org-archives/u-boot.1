Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8975C88E56
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 11:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DD6C80E6F;
	Fri, 11 Sep 2026 11:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Ct1geHBdxNR; Fri, 11 Sep 2026 11:45:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9D53F80D97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127113;
	b=Jf9keIxkXa2DbedczXvWL4Bp9M0PL3dN983/uEJKmPy3ecJ67bQ2r+tSEyL01xESEeMd
	 EacvQlEAbjLXYihfAqTFWynI6jSCA9lSKeVK2O7qXLJee4Gt6ZBBfk7oTUqEfR93SC4uF
	 37u5ur+fIiSZG8Gd4Zr3l3bn7WOx+XDzl7wBCte2ji2wPoZZDte0IZfT4vm8FmU8VnPuY
	 6ujTL28d9/0VrK45Yi4rsckvAvPyb+r1rfMkfuBeBQ064/D8ihvfX+R46XZUxTJWvkwae
	 xDFD0aCgdb5HTbjZwhU26hlKSq6mhRrRkQSYiRBGMTznnF+ICt4Dmkh8hA+5EpqejVg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789127113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XU5pAjjob/FnAmMVKXcsokXkb9db4jo7PLHZEm0SagM=;
	b=s+xQHhTFc7vvYBgTp02EJ16AzX4+uIfsXGG6My/5GItdyxPa/tnU25XZNqJoi2jVRohf
	 x31sIfSORnhwUjx1pd0x1qHAxUHBvqnI2U2yZGjjsickw0dRrYWGYLTbH3Y4eyOERK1L6
	 v5vPKNQUiUqByVLBMwCl/Bqjs7U6VVK4FaZjvX2F1gv8sBRN1S83QJmlh6Z3MCgG9Lggb
	 kB1bd3mmW5TC5cozh/KEqAmixmX/5vZUHgHEKFJfwTyg0HTyemrSeoUURfL3V2ohtzEo/
	 jGCcFFMiOOMpRLjxLc3ljcAuIhhhHuDRLHx95ZrUKhWVr3LBtDhzzl+r+CdprQ6ryfw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nQqM4kSG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789127113;
	bh=XU5pAjjob/FnAmMVKXcsokXkb9db4jo7PLHZEm0SagM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QVl3d+3YER31M3lSanLDm9ZsZtkFFq8YEsO1eo7X7Yi6gA8PYM2qfrAKtS0ZLlZ75
	 ml9ktDdu8Nsm+YrO3IrXQdvB2EcsObitg7BQ5phJgy9/+c5+cMgJC/kKXuwvT+c6CP
	 cqQFIUBlrrcznPnEEw9NEzGKDyaVM4+8n6F/7Ysj5PPEd1ar6WOvZAuqpWVwSuLRgS
	 byc88+PBzvLUR9XW3UGPina52Y1peHZk2chJxOz3v8M0tAQoWSlxFWM5ydoCvPVgrL
	 nfKsMcF1yU+DCY2f24pl4QcpyAmTzBidfnb6z90k52+BAALXC0CvvxBn3VRJ8fytmb
	 BT6LEKPcEsrbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D53F80D97;
	Fri, 11 Sep 2026 11:45:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 633AE29B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 547C580D97
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuNaKvDX4SIL for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 11:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 62AA380D86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127111;
 b=e43Gm9hUUtwXUBV8Jn8NE30bcE/8gk3uU68fxqB61VuMs21czcOZS99x63gak+45GqZf
 g4Fc458cAw9W0bZMBqOxS4ejECfXUY5cQyUl+qgzQCDinwq/uHKpIY+AQiNMAAQnOs+pK
 tGiXJlLMrDLjcjFYidOxSsqETieKdl0VzR+hGoU99LTJIxLuSTYFGJXTnmxOzjFddp9vx
 b32VRSBh8rcgc7I/9RTDYQFY/Z5u+/9bLNF0i+Bb2W/MSLliy+IFI48PC2osSvq1g0/Xv
 /l7S6vl1GsaME9pUxjrWiVTJzXpYzbO3r9YuNYT25OhIbfKIPPYUsLUCHYijSZimHuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789127111;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XU5pAjjob/FnAmMVKXcsokXkb9db4jo7PLHZEm0SagM=;
 b=Kq6Mc8Pkb6zQ9s/mfh1s9g73uwqgAEm1ocqkCY6b2+GXU8pQ9muLzT7nGhr6b3K1zAuT
 Eg4dDs0qSlxlM+SpcWb7TzRLNB1MLKBbie5nOHrTGUNjjedfW+c4NgMajXQ0h/IhtwOPP
 7xOf1KhFFAI6f73R+4TduWLU/NRjaTpRu3hGrz3JSgIQ9OWkgBPIf1oeSdgeUrzX39aaa
 r1eXImZvR3fOYcaM3SCX8Vdj/2TVltQXzReRbJQf1koqNTzvcYo2c0XllxvRLEE+jIXh1
 7A0PWNOAkBj/Rlsd78uMi6Lu/iDQovLGm5FnwWKOOLJPTVOrKqvSeGqabHLzAZiJpfw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nQqM4kSG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nQqM4kSG
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62AA380D86
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:10 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7daaso1031459a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789127109; cv=none;
 d=google.com; s=arc-20260327;
 b=QhaEBYuEpmtYUX9pDrnbpf/WGa89QtoeZEgbTQnQjbAnW1ROtENINX1HrZZFOlUf+Z
 0WABfdxdfCmQyZjoJKIVWu8XBPwqHL1zR2f+CtM5ifkrGIlKFl91dLFWrYLz3o8MVBc6
 qqZsh3njJXoBgyxTd+t9VHYGfAoly+Xsg9WA6yF3z6xXiKWlOJ9aYolfUep5QX3yigty
 Pbyds8e21esu9V8iTKxz66QWTDjo/0fQM5np8V263Vca7kDL8PjkZyGICQ1+fMYPruC+
 Ej4Kx8+4ZGwZIBQQi/lRT93pjsHWb23v35nIMxpigS4tPNbN0ngnTrlZrP73dJ2Em/XN
 128w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XU5pAjjob/FnAmMVKXcsokXkb9db4jo7PLHZEm0SagM=;
 fh=ueZmO91M8gS0vFxMc3gjY6aDCfwpyiQbjVf+iqYFoEU=;
 b=Bwh5xPDsM2K9C1Umnrsc5rHoiO29YNyTSSFXvT7a/B+xMQKBcB67m3S8MHcdnA9s5Q
 kLygggJVtesKOI6RjDFRvXW4uZ87j3pEHrC9z9YB44H52iIZ0Ktk65e5hROYPB7M6jCN
 GbprnvmDBHfeBPAtMpa1B94T/JSzZiDdBbKLzPKPRNH0IzQxF7Bp4L6El7O/W1mt579t
 hGEMthySYhBsXWwEhea5KPKfS1zfZ+RSG0rc4d1PRz4Q5J9AP/N393RNjMNQ57a3TsF7
 ja+cAl0DvER7vXrKDckQ814Vlegd+0qIP4OP6acaIfeh3bOKyPzso/KTCr3X/+tof5SD
 iIqQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789127109; x=1789731909;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XU5pAjjob/FnAmMVKXcsokXkb9db4jo7PLHZEm0SagM=;
 b=nQqM4kSGz1b/Y97yf9FTf6KHAh/rlb5ISJKldMmygMXQxsF2FagdXfLs+YH0AzYAmQ
 NJyJEJYRRXAukHOxioXXL6tBKoAQCNKRazFFGB4valrRq7l8WlH1VkrSAdDzOol5HeUG
 1MwuMK2dbTWAJroLZvTZ56qR1PsASUf+1ljZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127109; x=1789731909;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XU5pAjjob/FnAmMVKXcsokXkb9db4jo7PLHZEm0SagM=;
 b=Cx3FQmHeHejg7GG7bThRtRa97TjSTJnc0yPBbp3M3uUh13VAZgXQtVLRfdM1R+GX6V
 cjl4UnTcze208lfpep/dzVomR1Kwy6dwR6iIFlLzTAYuFvMttu7Auhm2b3tByvaWpbZE
 Z1WDOtZldACNgnVV5xmlZBvLuSLAV3zUnhiPV9qn7RdCYQKO2OexwzmFhe6/tY/7wVtN
 B/qHuGIXS8LtegZakw+rRvvwrNXg0bhMG9ApLGPgLSrNN7F/J3Vb9yXG4WeNB4PUd+ut
 n/r4KvWqss4qH8emA5G23lerTRw3ry+mdSHJB0Vb6RDVqGY8B/tw7oAuckGDaYz5gYJx
 8www==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfSKkkW+OjSs5y7LeQCw8Vr1AXPrsnrLsD5A0tTP+BVKgnzJ/DQCMYmuGOxyQAg4eKlTBtTGg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lZ+UuWLvk+EuYo2RF5dqVym2Ca27Jdqxt6FHdepD1hWXXWRE0B
 SFMfxqYQUmfG5+hVsaW86lxexNGiyoR5mvX+ZLdMgnQ3KPCH6GQChwJOtRlTXe40ov4qPtv8NVz
 qAppC2NDEi4z1uaFOa20aBYkoqL0m5bZcPllKGnon
X-Gm-Gg: AYBFou3Y9wUergEN7XqJy5epkLHjA3WmNfGLapAndGmiZRPUcQFgBjEXr0vY4swsQYL
 0pD1Byqkz51dl8Fpws1xWEV5nA3X3C6uBBsEAR+VA6t/ShKKq3NgzBO5DQdpft8VrejRnAOyrxm
 TA03WlSB9LLThksIpR+tCjKvcAx81dbwj12nM+MBXCS062+eynoSEVVStFMcxodWwQoted4G8ZH
 VwcK1Za2Pgu4BU6m5P7JXPXHrY7F7udoGYK5Qz8StkigqmDPTdK1cvCi0vgtHzjZ43HWRqtRzDS
 a2rxHQuKJvl6y+cKk1S2Lurg88wU43eDz9NtCguLYnhi808dvDew1DRg
X-Received: by 2002:a05:6402:f20:b0:6a9:c139:8640 with SMTP id
 4fb4d7f45d1cf-6a9c13987b6mr983193a12.11.1789127108891; Fri, 11 Sep 2026
 04:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-5-visitorckw@gmail.com>
In-Reply-To: <20260829192119.2658328-5-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Sep 2026 05:43:56 -0600
X-Gm-Features: AcwNN1WntYLkuwteEr-XW2fI-qX3nsPTXOuIeBWlvK9qrKJ17QPlAPL75fuSkrg
Message-ID: <CAFLszThz7YRToFRpp1pO21L8ktRQBycy0+mitqQ7im2bwn_Aqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] doc: 9p: Add 9P filesystem documentation
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
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

Hi Kuan-Wei,

On 2026-08-29T19:21:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> doc: 9p: Add 9P filesystem documentation
>
> Add documentation for 9P filesystem support, including configuration
> options, QEMU configuration, and basic usage examples.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> doc/usage/filesystems/9p.rst | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst          |  1 +
>  2 files changed, 56 insertions(+)

> diff --git a/doc/usage/filesystems/9p.rst b/doc/usage/filesystems/9p.rst
> @@ -0,0 +1,55 @@
> +For example, to share the host's `/tmp/shared` directory with the guest under
> +the mount tag `rootfs`:

Single backticks render as the default rST role (italic title
reference) rather than literal text. Please use double backticks here
to match the rest of the file.

Regards,
Simon
