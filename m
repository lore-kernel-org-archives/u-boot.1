Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1C9CA5FE3
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 23:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CB9240E01;
	Fri,  2 Oct 2026 23:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQy-GeqEfaIG; Fri,  2 Oct 2026 23:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 80A8B40D98
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790984968;
	b=Q6ZGPGk6g3GUrjtjjpMrFnsmSuw6XmIqSNUqKk9n5khpUIeXR1G896u3TqNz7V5Of9Qw
	 CbIyponV531CaOGHEK54m4li7EP9JMeO0XuPkb2SpEN5VZwVn81jDObxPMkOwveC8ovPt
	 u3+e6sduiMevIFIMZEtcGxMTIK86Dpd0ukeS6y3mkAytS7M5vb+Owax2ifhPQKUsXfeGq
	 enzW/mgtDiGO6bGYNvh2+DQgU9sOc+BYMgEVRaGdRUyHmqfkw+ka6CPqt8tllZqdHWv17
	 ohsjx13JmRuFZ1ySb05yo08tRt7cxh+zK6r6qiLGQuLXN32pF5c07LRocbZBz9HXIaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790984968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7EjDmL1jjzLjH3LA7X78zDpNHQP1PeEoAhU61MLm8pw=;
	b=kHv+Co54C+SLi4ouWIGL4gm6GRyjEe9Z+ENhhiXFPK0ib9WPEe8cJKdxM1GiDSmxUs98
	 ltpheyVrXNxX6mLt3sdpoDVN6dW8PzGecKfINs2MQMFeSy1+hRgTWR8Gw4vCkiwR7AsSK
	 zwnzSr1b7Np+YFzcSDKm6DFH0kaWaVTZjD/QfnyXNdu16ZzuQE49xnehJx4JZs61QtTWy
	 ceryf+ZSGgLsdOBi5IY5KPFvAf/iScYFeEnMnQyvHcqZENLdzHQ94TTnSSLIjJL2sEUwA
	 gpZx1M1tLFWjRZR9uo3QxOC1iFGXBKzi9Ns3s6nFQLNm80xJcbX9C4kRQ2tI8DXykew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790984968;
	bh=7EjDmL1jjzLjH3LA7X78zDpNHQP1PeEoAhU61MLm8pw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jzOgKqjnlQAfbLlBWj2+5SZE8c6c65CyU7OZTXM4K4EFEpK9JgZUQWjhzGgXywr4F
	 YLDs7qxep0uIiBYLyOrGrHB6NnGJ53uRpEbz7Z8lg+sPKhMMWlnQUESlQiW+ljedFL
	 PUxadnQY5k79m5TRvrbpWbs6VZ+Dp4TVT1CkD1arwmF7ecEq2rNCrTkvKT/o8qqgxf
	 BOO79QqdxYsyxaqGcrpp20iK9k5wcB6lBo08fyN7la9VzBjSnGNs9Wadv1BycczXlI
	 6f7rsfdqkRdusi7nOCyLJeX4KaemhHmKEr6z0TuL6mQ4wPx/W/yAIRujgcr3MliG1Q
	 U0QAiOT9qDVUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80A8B40D98;
	Fri,  2 Oct 2026 23:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1618D32F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 23:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13345812F9
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 23:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LyQDNg9L9dhs for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 23:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C7A2812F6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790984966;
 b=HyAVsFCjH20Pf1uB2IcMmwCTmQSQlzJscD5D5KQfXbJfGakDQ/uM4Ixru9NqTkrJt4YF
 ITfE80rl30hg33D4VeF2plM6zVe5Unla6VzIgPG3txbdPqhf22oegvvyLXjK/ZBnC1U2z
 +VvSeyldcnKUvWzyijI0e2NJv5aiZmMXJ6tFoLhACEI2WQRGYPLOVhpqQ4xzLm0pbqm4e
 0Tm24ToELW547bMaKW7/ATIQmYasQYiIs5vfUwXNBuhM2h6co9Uj8p0Xe9o7saPpe1Oc/
 DGrgPcTxnE8kInXf27igoVx73cuR4XnrPG1bGzrNgcvwBBWf5VojuZFZc7e0NjcGMhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790984966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=7EjDmL1jjzLjH3LA7X78zDpNHQP1PeEoAhU61MLm8pw=;
 b=H1V26E7LSzgUbahtYl2SsGQ7sTDmliISRX/R7X1UXW7eZml4+77iFBTXDxzyV2PxTnpx
 DAWAJK5+ZSy8Dspcl4zKMxY1CfQT7KSA3MSYrKTuR4DUUbsXsYIBxAXUDpUvOcqKPJxTl
 Zrdu7MIxlGi137XF2011fvy1Pq5S4xU62Ve7J6ioPPL+MaAUGNVTe7irpb80htiKYCCrm
 lgFwaYW/USW95238AO4fPz2tewaud4i0Ol4GWklWZ5Gq/zUoIeBXnVOdveX8SNpLCIVxK
 lFGtQ6GB65rvHRp7UExOqhmgPO5QfmzSG4Pu4GucvW7/XTRoyQlvk5P2oz6uJpZ7ELA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NIHaL7ZM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::;
 helo=mail-oo2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NIHaL7ZM
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C7A2812F6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 23:49:25 +0000 (UTC)
Received: by mail-oo2-x00.google.com with SMTP id
 006d021491bc7-6a3900cb2b5so214540eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790984965; x=1791589765;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7EjDmL1jjzLjH3LA7X78zDpNHQP1PeEoAhU61MLm8pw=;
 b=NIHaL7ZMUgsSyBaZW+b9fyTvLgbi5DcZI0qPtoAVjDh/poUH/vRBTTqvARzt48yiJz
 VwzHuA0svyyrpTG6rvM/qqZCmK/djKO5QtIqbpD3u/mfIp9lozgCUv7Z2HHJsK/LKW6b
 ihCMNqNjh1uSd50yxzUb4t0Bcs72XauSg+HIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790984965; x=1791589765;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7EjDmL1jjzLjH3LA7X78zDpNHQP1PeEoAhU61MLm8pw=;
 b=CWDPPMDfGbKlnkxeZ3jKvOCj+K+Dcn7uhf0MILq1IUFc24paLpR8KP5uzjILv89J/8
 W2AWZh3QnjrKVHhhQoPJ386y4x/i+/Eg34vBbmieYDa1m5MITk47ihuaUQ0IKMKkHrDy
 4jQ3mP5HdPtaGyciAwHfixFYjn/pb10FY8IpM5PLwL4mikm97ho38i2doSlG2h5YTpfn
 /KKfaGuKOMFfHKM48Sc51d0zZjtnUoL1d6YBHxDk9ZzlBtjgqOuT8QuDCwiyssLxTo5i
 XtvpJi/hCHGuMOV+GY81B9a/iJeWXMFuu+nXOHRLd9+G775wHRJtVhgGcYswzjRBXplG
 lgXg==
X-Gm-Message-State: AFuF++mjsEot+t54g1+PxhklA4+8QWktjwLqw3WDtBN0n2ungFAHCIgr
 ZT73zu3KnV7wq5vFAvww1RGWMEeHA6Elkc0ri9AcLiZ/WTaQEx43Pq6iLUhmt7GPujqOidx9Giw
 BFjppTJFmXaDvVhY=
X-Gm-Gg: AYBFou1TewKbFWDb4b8Re45gJPJcOy8h0/yI0YZxInR8lEumkjusdqoFr4CGcxs6rqU
 eLTviiYzNDQ9h+WcuxwPK7cr4rapvMd6NZQGbc2s4nnJQAoQZ1TS8+eskYHbnDLikH0PJcp520M
 I1WInfeMEOLwEu4BVRKbolv1AjCfukKZGbwt4NXgMxyPB60MZFmR1Y8voII5JLT/Nq18xqG+TWN
 F/4pI478aV4PKqMXdWQ62tABgCC3ZRAlq1ost9Uwktz/R44Dniyd8U/1rGednOZN+c1yu3DBNoU
 QEZyPoQyqaUxvi80BqAxbTdk2ywfwaSP8gDffurTmjPPKpB0MphQN4W9LzDyhX19uIoP//hUiFn
 7ynyB3+zCPGMXtqniEAqlxAfBvpghW/n5DBVq0yOh/9d5+YM1vqU2JSOZlj6MNbZn04viyutFFE
 3mbV9S7h3hr1mhnt7aTqiNsBPhW9hyuzZMU/FZw2MzyfxYho1ypSZSiLuQX+U9KYrs91VvXB0Op
 bpK3KeErtCuFjHH93zfbmPSgsf8W2IedGoq5jjCmIsUTkxgWwXvfLiXBcaZ5LGF820VkfXC9Fnv
 s7jSy92ocBYjN10GzpA=
X-Received: by 2002:a05:6820:1626:b0:6d7:ee8f:50e5 with SMTP id
 006d021491bc7-6e09e189f26mr733689eaf.38.1790984964826; 
 Fri, 02 Oct 2026 16:49:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16e1d0fesm3575316fac.8.2026.10.02.16.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 16:49:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261002174218.250429-1-u-boot@0leil.net>
References: <20261002174218.250429-1-u-boot@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2027.01-20261002 into next
Message-Id: <179098496376.3139846.16685724461245239200.b4-ty@konsulko.com>
Date: Fri, 02 Oct 2026 17:49:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 2 Oct 2026 19:41:31 +0200, Quentin Schulz wrote:

> CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1442
> 
> The following changes since commit b8e0086b585791a771416ce51b58ce0097bc0b28:
> 
>   Merge patch series "Cleanup MAINTAINERS entries" (2026-09-17 15:13:22 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


