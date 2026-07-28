Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B67AC54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36AE240A82;
	Tue, 28 Jul 2026 18:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XUF14PVjUoor; Tue, 28 Jul 2026 18:53:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6642F40A79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264807;
	bh=0sCeDPaavpP/Mm8upGLOifqI1fWRi/AdQGedK3sZ68M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7fbEPD/kNVSyZUg58FiCsMHxbYTNzFSuM4hdFTza1Z14iO+gxJLuaJMsJq16xELQ
	 zLqvIXMo/6dLCp31O82F8MXf6jWRwc5mk3FqVa75j15GKyqAwGsJMOhCHv93M85R/5
	 iiKlB+kIhCdZQDB3QX8tFuy4XLU2QJUBWmDZt43IAMUW30+pV6N09cBPueF4e/SiNJ
	 Rym+AhlEyEiuWLGv1HIPl6XWqGXo2rbnBzfDd/aR/2CriLUL+sr+ygw9ULk1HqXrq7
	 Rqz6MDIDGp+1E41AQxAILOgLBlVmzLr4uArS4e1ph7T+jJW1UzMhPwTrHTy0mvBG1G
	 Ok+FUdxkcKCpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6642F40A79;
	Tue, 28 Jul 2026 18:53:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E449350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0009A81296
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4aq-LZ2A-5D for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:53:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B8E6081316
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8E6081316
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8E6081316
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:24 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1womvZ-000000001Gq-1lvG; Tue, 28 Jul 2026 18:53:21 +0000
Date: Tue, 28 Jul 2026 19:53:19 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [v3,0/3] boot: fit: authenticate the dm-verity roothash
Message-ID: <amj6nyd_JNOQczLt@makrotopia.org>
References: <cover.1784601041.git.daniel@makrotopia.org>
 <CAFLszTgMxNnShY+WrNXxTwuZ2RMoqXDj7L5f0CofcDwNeehJOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgMxNnShY+WrNXxTwuZ2RMoqXDj7L5f0CofcDwNeehJOw@mail.gmail.com>
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=makrotopia.org
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

On Tue, Jul 28, 2026 at 12:45:38PM -0600, Simon Glass wrote:
> Hi Daniel,
> 
> On 2026-07-21T02:34:47, Daniel Golle <daniel@makrotopia.org> wrote:
> 
> > v3: address comments by Simon Glass
> 
> Thanks for the rework - the doc additions in signature.rst and
> dm-verity.rst read well, and the test fix is a good catch.
> 
> I still think we should state the compatibility break explicitly
> somehow: because U-Boot rebuilds the node list rather than trusting
> hashed-nodes, an image signed by an older mkimage that carries a
> dm-verity subnode stops verifying under this fix, and an image signed
> by the new mkimage does not verify on an older U-Boot.
> 
> The new language in dm-verity.rst documents the security property (the
> roothash can no longer be swapped out), but it doesn't warn that
> deployed images must be re-signed after upgrading and that mixed
> old/new fleets need care.
> 
> The break is unavoidable I think and I may be overthinking all this,
> but it would be nice to avoid people getting confused.

Technically you are right, there could be, but I strongly believe
there aren't any "deployments" of this right now.

The whole mechanism is built in order to be deployed as part of the
**upcoming** OpenWrt bootstd method. As of today, there aren't
currently any deployments using dm-verity on OpenWrt with this
mechanism (apart from some boards on my desk at least, and people
who have tried the PoC[1] -- which is/was a PoC and obviously subject
to changes as part of upstream review and standartization)

[1]: https://github.com/openwrt/openwrt/pull/22177
