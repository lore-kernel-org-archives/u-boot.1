Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0F606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yj+KOYP/;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qbtmL6ev
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F98940E19;
	Fri, 13 Nov 2026 18:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H02icjFK5qKH; Fri, 13 Nov 2026 18:49:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A8CE40E1A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794595753;
	b=Zxy0HAMe62U9Uoha1A7U6pP7oP2bJ/a4rVSXO+ea5tS7+TzNgWszpWU7p3DO8i7TCltT
	 NdvlT13jb+GpSVrIv678rO12kwHL/da6IwdNXkFsXCZkThNQwAgF0aVsH+Tao2mEjQLzM
	 6nTNCI7bTBrNgSjx65i0ISw2z30pK9eMpfljIwagB6fO72mEXgJZYhxQ+Wo8V0NLjE050
	 lKbzGFOJjTxSH9pGEHZeTht/wUmmNTWAqeS8961Ab+W9D7RIepaZM5ZGrm+u+vZumsCnu
	 tsbZPLs1Yafcr3D+VUwGjhQ2b37XStkhw5KOt1QS5QpBv3topGbamoNGbm/jTVNqR8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794595753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=P/VlSPV4IAIAllTA+9iLU7bc+Yb+1p3ePP87TXhThYU=;
	b=XVBd14dvYdK8yFLsrKMFOIT4dN/BD7qGN/5gTgFdUaNQFDHs79tRKo+BUTF/nIFvaxsF
	 uuQHe9NsX6UwOTOXgfpCQMn0DiNnoLPwseiC/HtSiW2p7w6qVQwFby+vlvMCsXOK5obL7
	 9agkdi2WVhDTz5RFmkn4w5UdWFOhUMaRUTdk5gSapLtcAtEM61cCsrvQRC3WZJLBkAVeM
	 hafDobowWGJdpAEoVKbCoid7Mumzq0At069Kv5VJQF+RQ/IKilns90dxUIBCPoW887jZJ
	 SIgby6M8RfBqJIwcNiDIP8XbugTcdQXtXN8LDyJ22UGlctCsR7gvb8EPSiXzzP1Ic4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qbtmL6ev;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794595753;
	bh=P/VlSPV4IAIAllTA+9iLU7bc+Yb+1p3ePP87TXhThYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yj+KOYP/+ujBWwTQqrbZXoFgkXrWprcCUGOu6nR8xaUh7A9BBdset2p7UlOyqVDmy
	 UsmCRypc2xKgP6rSGEDO78ML7Y2MoLD+tTbh1doKDW3sZvtcJLoKz6yDgehCd6fTak
	 5h4s2CFrRugACdGrPf2kahGOCMEHeCEfWzw/ScTIuxliBZF0Y3bijcGatF0XbOM+Hz
	 Jw4Qt0FOfA0PboS1Zz7ba9/VhM+ryU2cl+WnTNg5wbe0xnApe+QyF4lXzmeOr5oMkj
	 0NhG2Z8L5VBlw2WtDeIgpWJv8AhZ9PuFGg7t42ChAydPE/1WzuNuRWFPRsQkduGdnQ
	 4ydXdzKymXJyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A8CE40E1A;
	Fri, 13 Nov 2026 18:49:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8E06150
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C89B040E1A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OhFx4Q_jeE-7 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D77D40E19
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qbtmL6ev
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D77D40E19
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:09 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4af81963f35so1571566b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794595748; x=1795200548;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/VlSPV4IAIAllTA+9iLU7bc+Yb+1p3ePP87TXhThYU=;
 b=qbtmL6evSfYSZ8PYt3XQ+sUqCHP/dR48m/Mf7NWimi0Q8KyKSI+udNO/z/lAqscwZl
 ZllDUwWv/q0ugNgwPe/xc+fXaPDkEE/tTdaNAhLKpIRP1TUnBA/wdruxDXrxJNWNVi/X
 EMLFyVVo5xV5QU7jdenerHQbuYoDXI7lXou4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794595748; x=1795200548;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P/VlSPV4IAIAllTA+9iLU7bc+Yb+1p3ePP87TXhThYU=;
 b=TD8KXLA577VaZ6DYwiOW9eLb9hCOZWjhvSrR8F04wwnHeP0JzQKoyBNUSfOd+aR39K
 S5cy8VmGRBgublPsmKt9RAbWDdwc7Ouj6YEEbdw5epHDjmz0+zfLptDBWBs3axdre6DP
 Uq0DgmL3cZS71Gtodtx+aIVxNUdzb6qHWEwckxdhukAjnGUQfYKJpQdq3v3GRSgWLfQv
 ijTFp0OFDznmQX/WF17f3LX+TgFiyl2HxvpI6f5UHqN6ziqwBF/EM1sfCGssLWoqVRTl
 MGGbMT3syQr/ziRCJXIV2qwpruFjh5fy1HXLT4jnhzS38A522H58GFjOM3hfYHK66eQg
 2PUw==
X-Gm-Message-State: APuU4Z/wrC9lDGHIPFkmifcbg7TH/raM0Ld5TdSFsznftOnX7p1ip/DT
 ZslTM70yF7f6X2OPP5ge2dotSGIYi+/9C8Xv2jp7ZcKWhGgKg2AwNKta36enBWaySbpwuEDSIs3
 d4Z2OKHgbZg==
X-Gm-Gg: AYBFou0E4toMj5jMQnpM04QwSREZvDkJ0Sb/mT7GNQBMmPMpoMVG8k8lUJRn/z6IqfD
 dzB+IC/KjDTr4Ggl/NK87AZB96PUVdth3l1nfmZgeWRY6i1boV0VpnBTI84wU17XM5gZ/YfP2PT
 QoI4q3JJSxxCi8fYGnZZjIAk7UuR0k37V2p2u0bOaFbZiDYaJAyW2zz3QW9gFKDCHVAoo0KSuv5
 77LJd4PvxNTOpTb7y0d49c6ohSO8VE6tZND9eiJ0TKAB8wLZXIuecYRWPBG2kx2/ypLwfoHn3pz
 +qCl4YKew9gFsWT/yMmtiX1wA4Em4mMzRjelRNY8OPWlIG7Zta8w6S57wC/IHf+Vx/KxCSFAX3B
 eT+vsvFL7HxKOG78M8QXlty5ygWS2EHyEt433YwnEaJWGpRWOegTpJewPChQrRiSNZ1OHVcVj4q
 eFXLXhDIxwRUkPy8wyWp4MdmTZosC/NzSGBdueNFeHuP7/rFOoSR8pS/yprgMFwZcK6zWwlR+Xj
 rtblSmBZMcsmEKDEsulYRT0OzE4rcxtDsp/Dm+9vKNYYj+pxp32IUEt0ZEsWcFQ2VqfqwSJPrxI
 xsg9EO/yNQQSuUXXpB6/wwiTlDgiSghrwXBqdjXlzULogL3QeYx1A7dPK7ZfS6ak8Y/XJ8uAA/G
 nROyMUc7kRPGLUZVYlckC+elILwTwQY8YK5Iu43Ni06YSQgNvd83t58AqqXVtDWgGxysP09SGma
 cMoHBCRLWM9VpGKvnDjzK1HtBYtJOssxegjmgtNtuoWZYB1x98RPA=
X-Received: by 2002:a05:6808:3010:b0:54c:7bef:90d6 with SMTP id
 5614622812f47-56e605b7520mr2868218b6e.4.1794595748615; 
 Fri, 13 Nov 2026 10:49:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e7094aafcsm2747435b6e.12.2026.11.13.10.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:49:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Caleb Ethridge <Caleb.Ethridge@analog.com>
Cc: malysagreg@gmail.com, linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
In-Reply-To: <cover.1793368074.git.caleb.ethridge@analog.com>
References: <cover.1793368074.git.caleb.ethridge@analog.com>
Subject: Re: [PATCH 0/3] SC5xx Carrier Board Kconfig Cleanup
Message-Id: <179459574753.1254556.18394680726667493435.b4-ty@konsulko.com>
Date: Fri, 13 Nov 2026 12:49:07 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 10:01:19 -0400, Caleb Ethridge wrote:

> From: Caleb Ethridge <caleb.ethridge@analog.com>
> 
> This patch series does some small cleanup of the Kconfig options for the
> sc5xx boards. Common code for the SOMCRR carrier boards is now only built
> when one of the carrier boards is selected. Previously, it was built
> unconditionally which resulted in dead code.
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] board: adi: Build SOMCRR common code only with a carrier board
      commit: 1dcd01dafa01f3c370cf74182ac7e8c11d1492e9
[2/3] arm: mach-sc5xx: Make the SC5xx board target select the carrier board
      commit: 839ecedcc34e8f94c06fd1d9fa20cbd1febd3f8d
[3/3] configs: sc598-som-ezlite: drop explicit carrier board option
      commit: c940d79c0acb1d5a951eefac089021475bd45077
-- 
Tom


