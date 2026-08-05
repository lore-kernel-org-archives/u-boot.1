Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD91C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 18:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78DA280E77;
	Wed,  5 Aug 2026 18:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sN7waWW7PXPy; Wed,  5 Aug 2026 18:59:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2377C80E75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785956356;
	bh=rku4NzuIs4LOXhWB6cYImZbXS4XyUTSUfWPZfWk6bIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E1/rGMnHPli7JxG585ScL7mpwjAliCt0585DumOc0G0SxlUIqK+8pAvYQPdxeBQY5
	 23LUrKlXXmVFy7kweo2uuPv57+4xQ4egy5oVl4WKQBAF5Sz+vKamP+1wWzLhLOZV9Z
	 OC2p9Or5kGHUp0nT9KBo8hbOVCZfYD5fHQgdTWQraEQ7kMkSdiT38EOXA834vLMfxI
	 5QxhPnQHiOmnIBuY5kNIv6tSPlx7HNlGPgKBRSr8wOmYaC2oyTJCR/9rPuVjzKmQBP
	 9YxbFTQx+2Mw/y4nLitodHcOG1hdsIZknXjyAF4hq0xSHbxwbJn1FYuXRZMq64+aH8
	 7u5Z5v0DGzO1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2377C80E75;
	Wed,  5 Aug 2026 18:59:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F398397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65E38607CE
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzdWdyU2amMe for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 18:59:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BEF136061C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEF136061C
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEF136061C
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:59:13 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so20717145ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 11:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956353; cv=none;
 d=google.com; s=arc-20260327;
 b=Ev+fGBFG18t3icHBOc+zCJKEOp6afjnR0KCH3POyYi7CQbqzQKsMFVFrw2RByUQKy4
 gELG0KiEyU1wDAB+4R1c64vcAGFjO/D1EuAM8G/sduDTxFVGNtBfIcmUswujmC+q8ayE
 gIslB4uVBqVl8uFoXSqza8liTgt+LOo8pSgZoZ4zY+EUW96X89B978l9FVYdiMLWA/sL
 JCe2vCNoftyXQiCNyt4Vbw+Ui1tY0+80qf1kr5nsvDoaPOYakdTsyV06kTqOddT8T4Un
 2+CuINFhMq+Lqn1W+B074Tadj67qgqJH2tPtCTHTFDrPyz0bNtLpBA66a0voCHqf7bPu
 yeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rku4NzuIs4LOXhWB6cYImZbXS4XyUTSUfWPZfWk6bIk=;
 fh=dIuMP7yJmQjppxFr53IJWMcMkhGHIU2yuf4NvIuroh8=;
 b=nrasIN5futSfvK/IogNpU1jg4vrk5WZY83kk6p/oJtc9U93qF9GOPotuCUj7tJtUqZ
 JFyIIsYttJgXMCVZk5LFUdVJzfM6kmP1x7fU3cgi8jooOQM27TrD9JblFlxNiuZfFlKh
 XTtDjRSbCuzG1AgcIw90ks2mkQ6O6NLlaBcYhXJQQtilL/KnBDyZyrC1F075Hd4R4EKs
 leaw3VtTTk4EjiAjIfhnQrBGVwWpbz1FYQ8uagyEHm4mWMCX27efsEDfbWusXMIf1tzX
 XdkWRWSH+SKwuBoQDbVOp5etck6sQOBaAKBqUiLP9kZxZYVp5ikR7NMqyfLb4LOLd1WT
 W0yw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785956353; x=1786561153;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rku4NzuIs4LOXhWB6cYImZbXS4XyUTSUfWPZfWk6bIk=;
 b=Lf7taTY7Z/j+OZ61Eu4kwFTz+2tSD3/sDT2aXJIcb/h0+Gl4IgBf/2765iBq0124FT
 NKLMKxpe5Qsd/9BFnMYchwdqv9hhqGp7fV/lY6HuQF32mxIYEsD3Lhz64ZHpteSmmtRb
 UiTVc0IgterH9ihla/d6Z0Tea30+twdOG3tpcKAX3wAYyF08XF9xFvODyRsEinlM9Itg
 I2ea1Qcy1KKAvqK9Uy7wh3NqdMwyWDZKUD9Hhs35FkRGRBsMmMyVEvii6s7niDxvFU18
 Gc4aUbqvvbk5TOmhBcg4swPTMf4Ha2CTg+GByayDxhxNFJEocmpHUFitNA4ZbDZfGVK8
 xtYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3EesNqnfQsPVCTerY/fct17Xt3sEazqcDdCA5JFMX+dPWRhu16RCUMOOAYnVBT4Px1ebSWQc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxE7espCNSoMYpLznUWcnPJ3ujaXwrpfDn5F9FuBWNAnPeDgVyK
 Jg3+Q71qC5y4/M1SNYumIywloSuhEgU2HZMY2Y0YSTyraySLBHfknVc2ZHOiU6Q9ZyGOXGQj+Q/
 9Ixu/9S0fEBhFEINi81axNPggmYs6ul5Fnw7pJ1kP
X-Gm-Gg: AR+sD133FLG8AFeQYPyUCElG35d1BUYmkBHao1OSto8x/qu262jl0jzJ2g1Vl5HFsuz
 BBrrtRbWQNjZar8AST7mjP9T5BRC0C7NTlyXC5J9AL/oQquWgHigKCrBNBkq6dAq2IJdNWD79hU
 ZhZm0iyXBGmiq+aR6faNePSCatqyXw0yiZJyIuugor5T/FFqBP9AxH19VwBnYrjrJ4Cx7OuKdAp
 SA1SkGG00pS0SfZmgQyyDgJyWA7W5EgbVFjAt7CkHOyeNuBiiOluSs5VLHCln0cIlzaRIytWe96
 oNRt1belmu9eSwaOgo1z+/FMUoVjgV/rG307SLq5vs8=
X-Received: by 2002:a17:903:244a:b0:2cf:ca89:4990 with SMTP id
 d9443c01a7336-2d0ca981bb0mr95205125ad.17.1785956353146; Wed, 05 Aug 2026
 11:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-6-sergio.prado@e-labworks.com>
In-Reply-To: <20260728113535.128601-6-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 12:58:52 -0600
X-Gm-Features: AUfX_mxhu0axchbf2p46Jd_MpdoH9ceWw5naIGupZcdu8k0BSJDPNlQ0aWQjwVo
Message-ID: <CAFLszTiqCWXD6=Ra5Sbd15GLv9GZ-eYAhp6c6mkaMtAovKoKug@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] binman: Add BINMAN_X509_KEYFILE to override the
 signing key
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, pbrobinson@gmail.com, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, xypron.glpk@gmx.de, quentin.schulz@cherry.de, 
 jj251510319013@gmail.com, Wojciech.Dubowik@mt.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785956353; x=1786561153;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rku4NzuIs4LOXhWB6cYImZbXS4XyUTSUfWPZfWk6bIk=;
 b=XeWh252Gum6xdQs4NlEqvJItNtDrEM1zHeFZQ587FzxKi+cFXjeSliHzIx4r0Pa5/d
 JNq4GCZdxjOkREvHCZoOMVaFWuaa3kmEiI0gUcll0V/KYPqfUtIx5/9Gh7JFkhu5e7fi
 8sV5VXGA7pL0MEoPjriufgc3xg9SRqZ5PdYh4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=XeWh252G
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

On 2026-07-28T11:35:30, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: Add BINMAN_X509_KEYFILE to override the signing key
>
> The key used to sign an x509 certificate entry comes from the image
> description, either as a 'keyfile' property or as a 'keyfile' entry
> argument. Neither is convenient for a build which must not carry the key,
> such as one signing with an HSM.
>
> Add a BINMAN_X509_KEYFILE make variable which, when set, passes
> '-a keyfile=<value>' to binman and so overrides the image description for
> every x509 certificate entry in the build::
>
>     URI="pkcs11:token=mytoken;object=mykey;type=private"
>     make BINMAN_X509_KEYFILE="$URI" OPENSSL_CONF=/path/to/openssl.cnf
>
> The variable is a plain keyfile override, so it takes a path to a PEM key
> file just as happily as a PKCS#11 URI; signing with an HSM is simply the
> case which needs it most.
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>
> Makefile                |  1 +
>  tools/binman/binman.rst | 12 ++++++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
