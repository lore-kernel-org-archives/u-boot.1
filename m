Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B3C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 22:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAD5C407CE;
	Tue, 11 Aug 2026 22:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rMH2naxWl_F; Tue, 11 Aug 2026 22:50:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C95C5407BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786488618;
	bh=q0K+QWC2QwJ0IIJCnYgy8sXfK29wU2YCskvIYGkZkxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P7jadud/YFJgI4fttXY564slXhxdweZe65vLmGU1siInGlnsWVUyJxCbmt6vVmPAl
	 LmZxByS8SYMrzQCEePR+bfX1L3R1Ty50d0mP3uGDRLRV8pNUF8zOOQmaKQlAEEtv7Y
	 nUZIUjg02MxiwTcM6EIw4PPH1rCkP7MZRPucgQEfni7cdvj8b5OfYz+HBhroelblRe
	 AMExPqUeXZn6cKF3nDu+G//ty1ZuILOk4wqc/cPxu5LAf1VY0ng2k0Mgf7/Hd1cGXy
	 vgLevUqTMUe6Sp1ox2fV4APYCluZT1C/va5VUCrbHsyc30tNE1R8qNj709sZZBdRTD
	 3muBHOkWbB2zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C95C5407BC;
	Tue, 11 Aug 2026 22:50:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55B6028A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 453B5608BA
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7l6RMP1-psO for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6B1E7608D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B1E7608D7
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B1E7608D7
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so422491a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488614; x=1787093414;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q0K+QWC2QwJ0IIJCnYgy8sXfK29wU2YCskvIYGkZkxE=;
 b=jShbypxz68njcRN8zMpgxD0OVlG3EThoHU8Fi1YbljdyajsR/RFJvK7xBvznOPp9dm
 j9dXk2XdSV734VPukQg00xJ47ywKOXoItio71eIn1unKjYf9zbmgECImnmHe+tZrpFrL
 UXszInD16BhuISsUCb7+lvOMItNo9Wmiw4N1fVFWwU8tQ53D6R4gbOGVy23NSNQK/ywt
 BXiTsAvGaQ7bt76FzpD26NvSzfWb5eQssGBTz4BHM86k2/A8W/05N/jSTM88vQVat/pI
 WUpM/pPlC+RmyeknaUWkyRZZXG8tQdmwk7d8fTlHC3eKP8jPsLOug665GTSfTb2vIs/X
 T2jQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwOWDC+CTib2+nNcwGHcNOgHaZw6FUW4skF7eEUPK4zymHsydfnPsCfpnMdqvuaWIrn5cS00g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz9unGjVpOz/FZzQNpehWuT0fxwJ9vWItdfCUjfEEyfyzZGO+ah
 rDM+GnIOvm+NY5GH+FlQQls+gRN89NraSVf+G4js7e2r/xJdbqrlgEbgXqMVQ3XvFTelYE2wmyN
 cKHrFisU=
X-Gm-Gg: AR+sD12yPysC9JbJCMp9BkTOyhAsg5DYNT7CsDb7vwEGfkd59lTdISNvjuuehTfE65j
 W62zizUdy7HxblzDr5UHWcObF2SZ9jX9Ng6fi/Ms4ZjYiHkD2xju3lFCYwV8+vroytw2iIAnJ+X
 9JY/dpk7a7+9SuaI239FFee/u9QONwRvFJwKnj9VzcpWmPHt3y6eDi9WYn0Ibu5f0hKCbZCiNHW
 kQRDtzKQJzsKq/b66k60Y6uWOyctZF+KwdN9tLD1gjIdcpwQYQFynzzVuxtdFWXsXZAV/jNEqUv
 xqxGlpiH3ayQ0RsDF9PMGGEIZ0/pB/Q56ZosQmYEeHNv7/wZJiKBKRxl6faBe6ImVpEK8AOfD5x
 sdXB2NSqp3ZHEURyukJOmKJiEBvNKv+CIRga/ZKHVExkO4DFLTCjswZZ/E74R/A4S/jsv8GE9og
 ChwCdNahRfWXWvP/VMl7tZk9KLopMzClXGCo4epOgW0r5mEZvIMBPWBSCj1xPUWjQ2tQgOVdIpy
 nvM8jGX7WvmSn+k9LmKrpoiSOnMHd4g2kOmqKn2+8wudJaIgixYnjj+INIUbQl2isFRfUCG70Tw
 hHX/qUXQ
X-Received: by 2002:a05:6820:f00f:b0:6aa:d13c:a709 with SMTP id
 006d021491bc7-6b0b2827244mr341916eaf.31.1786488614211; 
 Tue, 11 Aug 2026 15:50:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad500d37sm972541eaf.7.2026.08.11.15.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:50:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260731120750.2212394-1-me@ziyao.cc>
References: <20260731120750.2212394-1-me@ziyao.cc>
Subject: Re: [RESEND PATCH v2 0/2] Add LoongArch support for CI image
Message-Id: <178648861345.3127030.13752325250840471153.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 16:50:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786488614; x=1787093414;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q0K+QWC2QwJ0IIJCnYgy8sXfK29wU2YCskvIYGkZkxE=;
 b=jcYIgLqEqHOv/40w1lCU+N96eiz0FDFaywKGlCQ5EBPV+vK7LjIG9tLC041udWDWyv
 kaJ94om5GD9z4gMJC7NjjA2CBO11hB4SEBBTFmSS80j7sjv5ZroRl3xNIYQUC6Ol7BBp
 zKfgtAtGapDvQfk+XHPRvZKKbM7ZmYr5wvwuY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=jcYIgLqE
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

On Fri, 31 Jul 2026 12:07:48 +0000, Yao Zi wrote:

> I somehow forgot to cc the list when sending v2, sorry for the noise.
> 
> This originates the series "New CI image and fixes" sent by Jiaxun Yang
> back to Jul. 2024, though only one PATCH remains since the Ubuntu image
> used as CI's base has been bumped to noble-20251013.
> 
> I also found the upstream added new dependencies to swtpm, breaking
> docker image build as we build the latest branch HEAD instead of a
> specified version, so in this series swtpm is locked to v0.10.1, the
> latest version without newly introduced dependencies.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] CI: Dockerfile: Lock the version of swtpm to v0.10.1
      commit: 5ddc3158591e1bc1d9a9a18e2bc3bac06d4ec971
[2/2] CI: Dockerfile: Add LoongArch64 support
      commit: 68c978fe5c57d4833849b3d29ebf6f671a7754e2
-- 
Tom


