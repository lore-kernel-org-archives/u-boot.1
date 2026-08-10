Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8894C5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 09:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BE1140582;
	Mon, 10 Aug 2026 09:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXKWNKiY-ZEn; Mon, 10 Aug 2026 09:41:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E83F040545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786354918;
	bh=HjU0IG7mH1IvdSutcRKZyGa6czHyccJf1JeKc8nL0po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZe5D5i9x9AJkcKJfUvQnd+Fy4xZW+8Qre30Q6T9OSJSJgUO/phO+DE4sGEOtVwSO
	 AQhaOTY1dh8A6Wcbe/8to1otPmNoRn9+F0ECQdALpmPPw9Q5oTX7ElY2wxO5f+t0Wx
	 hpcC7IZQVbRFMpmbFoeqqBDuscHDHjQ4jXx9inFdIC2oHHFZr4jzao4Wpc3RWn7CI/
	 jaWgbFlOdPSDrjuoGstX3RzO6SePyZFt/Ydqycj98ZbJA7/K5ObuJe6h7YRmM/ESZj
	 JQ92ST0pbbtuNzCmfohyJ4A9kDrnpS4Ogneq/KXNvmU7poHcz1B30qQAVI2JFluqdL
	 EFFcWTfvlfVqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E83F040545;
	Mon, 10 Aug 2026 09:41:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E991C198
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBC62400F1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hknBPmwpojxa for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 09:41:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4FF09400E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FF09400E9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FF09400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:41:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 593EA40DC7;
 Mon, 10 Aug 2026 09:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D68E1F000E9;
 Mon, 10 Aug 2026 09:41:54 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, Igor
 Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 1/4] avb: make the AVB root key source pluggable
In-Reply-To: <20260727-avb-root-key-pluggable-v1-1-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
 <20260727-avb-root-key-pluggable-v1-1-7e27b2b92cc0@gmail.com>
Date: Mon, 10 Aug 2026 11:41:51 +0200
Message-ID: <87ldae2ty8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786354915;
 bh=HjU0IG7mH1IvdSutcRKZyGa6czHyccJf1JeKc8nL0po=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=m4WPEbQu0TIN9fRlP64s6kg3tk1AFyXAPM1W837pn9gK51jVvoU5XC6SjYbYTKNq7
 pd7kt/rIYNX4JmRMk0JuEUskHEOxqa1zPgyN7N4zqTfs1StfqBPFMs9yaeT8s2tF2r
 5HTz5W/Fif+XVNPCv40E5OaQHwyWi0R+kg/67uPu/NadUG2x6AP2Q4O02H/iYo6N+x
 EPHQTfNoCyMWrr1ElcZgDfEpJpW1i1kD4S+f99k/o1/7eCjrfUMEGWFfWOPcIvlDvH
 4U5XY3xgZricokzfGPzVXMPeIeP7qNCcnYKkE1dGCFnt4GTlXPfEit8V61MOQHKUhr
 RUdj4Cbiug+kA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=m4WPEbQu
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

Hi Igor,

Thank you for the patch.

On Mon, Jul 27, 2026 at 19:14, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> AVB's whole chain of trust reduces to a single public key, and that key is
> currently hard-coded in U-Boot as the AVB reference/test key, whose private
> half is public. That is fine for bring-up but unusable for a locked
> product, which must anchor its root of trust in something an attacker
> cannot swap out -- a hash fused into the SoC, a secure element -- rather
> than a blob compiled into the bootloader.
>
> Make the source of the trusted key digest selectable so a board can decide
> where its root of trust lives, without touching the verification logic and
> with any lookup failure treated as untrusted. The built-in key remains the
> default, so existing users are unaffected; the sources a production device
> actually needs are added in the following patches.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
