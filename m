Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58364C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 19:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B73440B8F;
	Fri, 24 Jul 2026 19:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FeU-A4qldrnr; Fri, 24 Jul 2026 19:58:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D917940B4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784923102;
	bh=fp6KFvlnpYxqZrDb4Nh1ogyUjtR+70nnq0oGCd0JbJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=esKjv0E2xL9N4WRQMs77gGRVx92ABvpSnWZKVqI13kxmcYEPB8/JAvg6QyLtKfrBQ
	 WZAEHzDauLbBZZcm/rXqdp04PolzAghjCjEVMGyZy02+9We4It4S2YZCJpQiNdQL/i
	 mTwjAEtFQIlcNmkPLg0Z+jICuEf75k6QBIX6ekIkGZz6wG9ZSMwfZneNWRlcVtFyQE
	 XKJi9b12c2bwWqsq9m5UsvjEmnd521QlfZNLLgKNRoEVRM1B5zAi5vIL64i+kKc1A3
	 UC6Qjguqa5TCOgHvOOyN95x6B9dCPNGHywMmI62jzX/3cB6c8e+qYPfMK6tTuzLw89
	 r2FFZuygx/D9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D917940B4C;
	Fri, 24 Jul 2026 19:58:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09F51EB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 19:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E492760684
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 19:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfxVXLeI7M_d for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 19:58:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 19A74605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19A74605CA
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19A74605CA
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 19:58:17 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so472367fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784923097; x=1785527897;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fp6KFvlnpYxqZrDb4Nh1ogyUjtR+70nnq0oGCd0JbJY=;
 b=Ka1MDSptWzT4bFrCKk/GJq78JIXCwEHfbE/bcPnVez+4amNLKBkijUDVh3rWtofEXJ
 0dWiSp2WDi/xRzpsiAgGGx2nOl8CZ8VTPUoW8SbQ2aiwBXV2Yi72IIDaUju5t8Hz5+HW
 hk/uo0TgJg+mmZQi9+ZWsK4P6yKMVDdhG5v3KiGY2Tlr7AeRNCNZjXzi9Eo8o1qORzQY
 B8PSEsiiJd+3vdy5spmaV3vyrPW2Z8gwNQYOM6odJSwHNP8Npaa9lSqzuthxGiF+87qx
 F5o3UBmPefstpf/upNAGPlu1/oRF8yE/fH9pS+ekOywdnjgsXYdFkBtojQE2SYamhhik
 Vmag==
X-Gm-Message-State: AOJu0YxjT571F/QIgbjLJ6WDVqJ/2vJ+QITD+gI+g35DdMHU8AsfJx9U
 DEdWmAeG9Jw6nlg9+z/DGoht4Xhcbo2ZTzQDTekjj1fCc14m5uSszo3sezK/YA+H7v8=
X-Gm-Gg: AR+sD11lINt2zhKeNNXdOr+gnDgjeHIy5BSVoxkvHWl+3BuCWepaGk5uxKSSZOwtPdx
 4HLEE5eY6sD+kptLyQSsQ+AUXPE2cR2R/XV+CH3/TukWXyFXlMT5/llRLPMFaWj2PrPVvAzxiwQ
 yYbK1GIbeIXm18k5warne6rCltScm0Cqh3phOQXDcPfuEP3+HPBAcPW2X/hFFuMnJG/M5jIihpZ
 a7EEmGNVc/5GKjXmwidsd6djfPux8BfPlPdmhUNSi4ZtPXhoOFiV9VEJlkvl7XvgBAHGpAvDBV4
 Dl5jhTnocsm6rXbfrtdD1HqTU045lmCrzzcQtlf77d3jr/IgKI7mKFB4oWFMb/5AIa7P1lvAwHq
 +ndFp8alIFcpmpzAUexpL41c+Ys3kdiqDlA14xWxF3q5mx1+qSviyAmUdqEOdNljrptIrWDv2bw
 HYgG8zcUBK1IVJyvipAddI0Ehkl5znWEvHMT0U/X1C9eQNEuv0IPqn3MnyXKs5klRE0YV/rwZDN
 3yXpX60iot19h9/1DYRX41GtME=
X-Received: by 2002:a05:6870:9627:b0:456:9b53:c6bd with SMTP id
 586e51a60fabf-457a1023307mr5275932fac.30.1784923096889; 
 Fri, 24 Jul 2026 12:58:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766e7d8cdsm7222988fac.1.2026.07.24.12.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 12:58:16 -0700 (PDT)
Date: Fri, 24 Jul 2026 13:58:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] .mailmap: map the old U-Boot mailing list address to the
 new one
Message-ID: <20260724195814.GG749385@bill-the-cat>
References: <20260724-new-ml-mailmap-v1-1-b65a436e23a1@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-new-ml-mailmap-v1-1-b65a436e23a1@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784923097; x=1785527897;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fp6KFvlnpYxqZrDb4Nh1ogyUjtR+70nnq0oGCd0JbJY=;
 b=iUOiwtAh/JyNXy5f0ytznBsNqt1OLUdzz3UpzwuwBRefcKEjafyiU3rIUXGAAYQF99
 UyaY7P3feyd9rJz+5bndvbcn73MQNQSv7N5h7Mzv4kAhlneT5NKdehR8FeE4Z/5WMWOc
 nb9uBG4wCqfmiJYmM6rfhTPkfON5gkDhXDPIY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=iUOiwtAh
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

On Fri, Jul 24, 2026 at 12:54:45PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> We have a new mailing list but the old one still forwards to the new
> one, although some people (including me) have issues with the forward
> and their mails to the old mailing list being dropped due to SPF policy.
> 
> Add an entry in .mailmap so that Cc: u-boot@lists.denx.de in "old"
> cover letters and patches use the new mailing list address.
> 
> Tested with b4 ty --dry-run on a series from the old mailing list.
> 
> Tested with a Cc: u-boot@lists.denx.de in a commit log with b4 (b4
> send), git-format-patch and git-send-email somehow don't seem to be
> respecting this mapping. At least one tool (the one we now recommend)
> does the right thing, so it's progress :)
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to u-boot/master, thanks!

-- 
Tom
