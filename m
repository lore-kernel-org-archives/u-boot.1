Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700D60A3815
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eiv9zNfe;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=B8W/ZO80
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E35E607E7;
	Wed, 21 Oct 2026 12:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uX9LxOFYkf0H; Wed, 21 Oct 2026 12:35:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 57BF1607E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586145;
	b=kPv6DTrDY9541pzFTU7lG9W/xc+3FV7uhdieQOe4xr1u3StM9W2v8V/b01fLJJDbrbjh
	 lP4pCVnxbMNza3EbCM77YRRCSql9BQwFvnPPCvM6Ww6TvlU+v+WS+izoPqe2a1Me+x4bS
	 baQHziNUyjnK2H0LqQiOoqcsxcPQlt1eH2WEVKeTF9FK8/KGltUJQZEv2a2mrhK4LxYUU
	 o7PEAt2X+M6Q3kXW1yujHQLSSAuNRtPkBg7GGu4DTs6fDnw0d/Va9F5bWXHachonKEvAg
	 ofqjmEmKRfeM1D/2LEr/sQw4EEGm0N3hjc5EflamicTrSSU9WGWt+FG/OnNHVYvocjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W1WEeA/4ckbmQxayvL6hpRC4g6xhX9Z9SDPBste9ye4=;
	b=IC4rFUCpuiHJjJtwfYlTrnYnvceJzaVu3Wiz3cx4VYdlClF849fe3s6XX685XBCA5JUK
	 I5DkMfxeTeGz8N2FIrcoFBY7Jsqnuog/dsuG6vZBu3ZAcbB188xdvBKn9NUz2Ckh2R9Ag
	 XMaJrokFXzFbsr/1Hs0xWDzB2Jb32FmZg/KRVuKmZ/wGx5jqnBZrbqD4rCFISHE4JCFhF
	 o+dVpWcpkfzK99wqjfyu1/cS/4sZFLUnHOcArllDMv8/MVJI8c9JksWvsS4WE9kw5Ydj3
	 t1bJJPOBLdrJ+88S7+rMjq6J2C8PuAxPAye8m4xJVrNVaNCeQVlo3vaSpz0p1zehjfA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586145;
	bh=W1WEeA/4ckbmQxayvL6hpRC4g6xhX9Z9SDPBste9ye4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eiv9zNfeb7ivB33kaQNT/1sLrrzC3jd9rZH07Ax9EM7Aj2Cepg8G1ZL/2Sev1/Bpb
	 kswQgVdT4WqPxZLFu471CUSl+3Gw3D7YE7TkeCmbuGUE/UjA8tMuGEEwRxVx47sO4o
	 xjdYVUIrJLy9xQQF28UctEzX/rbxpqcAQGdcg6p1fn/5x2QTkyo8HY6Wxczec1KeL9
	 FMFUaRfurLFv5rQTGSEVuJMFahiO6u/CRCM/4BQ55Vx1AQPW2555ShMgYQ/HG7g01b
	 BxWoxO/ysTXduE8QvCg26szEi838kunHxPCH7HTMCpYhvq3gQWQ0S/9a635aWCChQV
	 mc2X9rIcOJfPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57BF1607E9;
	Wed, 21 Oct 2026 12:35:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09627930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41A8A40649
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fyugFNjO-Ufj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5500E40631
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586133;
 b=P06LdogEpWDP1h6k6lCdP+CWtULhxCBMY03L3CwLQTiv/K4jt51FZbSRk4s2xuaASfVr
 3W1hpRIgs53o0kKISEJUTpVQh3tzjV6yb1d6CekPFXcRCTA+ArPxs3hbD8r/oIUzouyUt
 bOCpVxDZdKgvbKvf63P8NVvQWu0f6x4AMm12gDfLWG1oPP5UmwyirFRUDJz1i+QmXKqiO
 zhFpcMj5+klN4NuP8TL9djRXh8dBA/0k51SY/qrOGpSfMGpuY4e1nwRLu18iiyITs5Eji
 2+z5g0whBgjbrAtp6tquWNJTrDlU4bOAbn95J3uTDQ8fUnN09LazPHa61xyHgWDLVFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792586133;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=W1WEeA/4ckbmQxayvL6hpRC4g6xhX9Z9SDPBste9ye4=;
 b=WX7yTEiIMjyJ/J/8hnddnnFwvtjudObKQlixTAAwzPyxi11peXAM1nKxdyApSBnANSJt
 OiXQYX46NEwchleyIwr5AkTSTSvcs5IWSiRQuicTDljd2xw7vyzwk7Fw+d2SQJMS4gTVP
 7O6YomCu935brDN/howWHBxn51wURWCGR1YbseJr1T5xWvo7IbLRqvvQfj94lApEWyvcK
 DHH45byzR2sq8h4QyCbjK0wU/9MbnJkvRZoQ7ClhOeBOK/Qhg20/S+HbpgZVycvYpgn+e
 uHWsNPfDn4/UpBHdfVI4j6Ucx7drJxag7C8kE9649O62gToCqMBx1VaUqqg6UzQrRFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="B8W/ZO80"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.12;
 helo=sender6-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=B8W/ZO80
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com
 [165.173.180.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5500E40631
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792586127; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BVNcsVRjP5nzOv65iU9352VD55YYScBpQlKDPQ/K7Qbj1z9XxR5dLN+rPXtaIS0WQWOdMbTes361jobwtv1F+auXVVqqkUzmZkWKRvJ4e9KOpOJ0KxebYiqrVfMtE6J0V05oq745V0IjCrgx4l21r2zpRawmNJKMsi+1Oj+lwi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792586127;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=W1WEeA/4ckbmQxayvL6hpRC4g6xhX9Z9SDPBste9ye4=; 
 b=WArQxmoxGoUeobxQdwzPcu87hTdyBQc76k1RxbFtWh0bPBRhXfFsSdzeQZCkYQ1idMTe+dPwKjhUE2RIN1YFT+3QJY+O83wX/7jy19W4p5QWE0YHtZugz2uk4MjOrq4ATfxOGw9ZYu8wsdazW6I+mAEiEQ1bFUQ+xy2dFDZebas=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792586127; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=W1WEeA/4ckbmQxayvL6hpRC4g6xhX9Z9SDPBste9ye4=;
 b=B8W/ZO80z4jPq88CdXJDn7pEbUCBLM0Y/ZCpi3w/p3rU7TDZvvSVylSl7/cILcA1
 E7H9B1s0A3hZO6YSCfPpHSYFJ36LFKy0R7vXiCKfICkW3sI1GWOzqte/RoEtJdstIyz
 W+koYui36bLDJhVjhM634C08hzty49VDf4hdJ8AU=
Received: by smtp.zohomail.com with SMTPS id 1792586124819755.5717752811571;
 Wed, 21 Oct 2026 05:35:24 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:35:21 +0000
From: Yao Zi <me@ziyao.cc>
To: Umut Tezduyar Lindskog <umut@tezduyar.com>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: Re: U-Boot UEFI implementation vs EDK II UEFI Payload
Message-ID: <atixibbQNFPiLJ57@pie>
References: <CAFKnvs4jwfemfGE0i0zvg3LyjePU0KZU_1fb68PVeOBD+nqZDw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFKnvs4jwfemfGE0i0zvg3LyjePU0KZU_1fb68PVeOBD+nqZDw@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.565.41
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 02:15:44PM +0200, Umut Tezduyar Lindskog wrote:
> Hi,
> 
> I have been looking into U-Boot’s UEFI implementation and trying to
> understand some of the architectural decisions behind it.
> 
> I noticed that EDK II has a UefiPayloadPkg component, which is intended to
> provide UEFI services on top of an existing bootloader. This made me
> curious why U-Boot maintains its own UEFI implementation rather than using
> EDK II’s.
> 
> I am not suggesting that one approach is better than the other. I am just
> trying to understand the history and the trade-offs.
> 
> I have a few questions:
> 
> 1. Was integrating EDK II’s UefiPayloadPkg ever considered for U-Boot? If
> so, what were the main reasons for choosing a native implementation?
> 2. What are the main advantages of U-Boot’s native UEFI implementation
> compared to using EDK II? Is it primarily about binary size, complexity,
> dependencies, or having better control over the implementation?

A point which I could come up with, is that one doesn't need to
re-implement drivers already available in U-Boot on EDK2 with U-Boot
EFI. And porting drivers from Linux to U-Boot would be easier than
targetting EDK2, I think.

And personally speaking, to me it's easier to work with U-Boot :)

> 3. Are there any significant disadvantages to maintaining a separate UEFI
> implementation? For example, keeping up with UEFI specifications,
> compatibility with EFI applications, or implementing features such as
> Secure Boot.
> 4. Would there be any technical advantages to using EDK II’s UefiPayloadPkg
> on top of U-Boot today (instead of it's own UEFI implementation)?
> 
> I realize some of these questions might have obvious answers for people
> familiar with U-Boot’s history. I am mainly interested in understanding the
> design decisions and the reasoning behind having two independent
> implementations.
> 
> Thanks!
> Umut

Regards,
Yao Zi
