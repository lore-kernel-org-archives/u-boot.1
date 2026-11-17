Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E98606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qn/jShNL;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=K6vEgCOK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44FC3409BB;
	Tue, 17 Nov 2026 20:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtcrdFhwjmeY; Tue, 17 Nov 2026 20:03:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 994D4409C1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794945795;
	b=OZ43FXuU9KD20S0sX+cxRUxumBNYgQNaQdL5985eulJnifWe0aNKH1BS6B/ZP0/HfgDx
	 VRPyWWoPmItAgd0H25EqL4gDhB048l3h0id5vcw6PkxXIsf2uhLIGkiDsv8K7G2gk0Ygb
	 2NYg2rUhGCSOTk09Cx+igQfIEZwU0tXmO+XlgDROh7xZbtrr4XGkwoGkHuukkou0OeOCs
	 oR9vtPcZMW7avz2eXcFmUAwohKpf/Bd4NgKjmSYqrvU8Df1016LlHX+0u9bVecNg/5Gwn
	 TWem3n0CPhtNk5f00nII1jP4p+3BNJTu193dX6aM18qN2m5TXfJ6Pdpu7dxfmyipoqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794945795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JPKBlnEf3phrUVSdUy50oT6Zz8tOjC/VoatS38PFI7w=;
	b=Obpgtdz9oAwE4/xWmkYBg1jWlKsazU8eav6wGeF1L+MdTy7XHY3aAq2ADDzf6psmmIzg
	 cd3kaO5CoTo40VCQU3Ixgoc+WI7wGpVGtc79NdzORNoiybfxzHEo4tvglwYFSoHCrPU+d
	 Yb8fv+LKG2PPH4YANEtOYXFviQW4Vyd17UoXcG+HQ1Vpc21nrus9/poxmuS1CtZJMhTEz
	 l+Heq6PmkWnrB8+/fXD1pXuzGEScz74gDeM1azF7vCuorOWrkq0g28+AoUz2yYfPslk5m
	 5ofJIX+Q4IpHBYVBV21dJV/kpiUVTnW9Ix3E93GuVmxuZbx9QTDpQgYNkoyCuCyu37w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794945795;
	bh=JPKBlnEf3phrUVSdUy50oT6Zz8tOjC/VoatS38PFI7w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qn/jShNLFJftk8XzRyDza3YAaNzAIFegQ8WJfBaoavl+Hir8BLNuPwhJAxpmUqcfs
	 gr2jsyUriU5sMujSzknWUa2uuvHy/PwykWQWFjLR7zq5I+QHmU+DSi5if7ax14OX+2
	 7Ft+7HOCAxVHitcOEg+Tgl/eF5V1Gewix3168W66LPx6r/YpIc2B4kVr7jko2ktQ6C
	 1EY8aEWx/6S+4hh4NyU3xkR70nHJDiGGkpsVZrtM88gTo5lR+FFn8eXesYlhSZcwGf
	 0lslLa+2zuyX+Mh+TorxvyYQI83Cd4efgHX3GALvh+AVa5iljKCQrtEExkNEBhKWLb
	 pCGse+FJ5XBYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 994D4409C1;
	Tue, 17 Nov 2026 20:03:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA4F01A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 903226076A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aP21NUcfb0PE for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 20:03:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C856860739
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K6vEgCOK
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C856860739
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:09 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-845788309b4so83182a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794945788; x=1795550588;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JPKBlnEf3phrUVSdUy50oT6Zz8tOjC/VoatS38PFI7w=;
 b=K6vEgCOKtFoMpQS22E4FhP/Z2OHRlSIKFJljg9OswR0CLNuUWlItvmt1xG3sU1VnIO
 B0kl6v0x01uPOIQgNdnHKrkpn3UBU62bG6lPX4Kby7e2TsRrsqpnM9kqK9/n7fbXELvV
 awFUCiPFTJTHDUOu8JiRmcmZwcbNNDk+jH63E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945788; x=1795550588;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JPKBlnEf3phrUVSdUy50oT6Zz8tOjC/VoatS38PFI7w=;
 b=NEnxqNtdsJ71h0BcbYc7xVBEaFptMk4vFFfQWN1UoXzMPy2wM24CosBBUQEpbH2dMr
 V4x0ijwn+7qRisvD9CoM+21NEPqjF8IrpuSj2D9jlxTjQiTCwI8Mynuiw5eYqwIo40Cn
 FFSOKPMQTucDNr8C/TTX4MsoUEHYZEuh+TNoNjQiQtQvLM0WeiInCSizYM1EY2GBgKXy
 wfR71dlVpqL13SmDvu6PhS14FdatUAZq8eSf3Bz3VvdV6zxwdc5NkXBx+6MtMrzRgGpV
 pT2fDzEHTo+t9MC6NTitodfRb52WwuTTlVOERW5ONwcaB7L5V0aS8QsVhQ5whaCv9FAW
 K7Kw==
X-Gm-Message-State: APuU4Z9xkEfW2+8rOtsMkKn3q2v/hqEdosaCWN5xldgD/K5FyHjwA/cf
 GFaUSYdf4tJe41/7QVXHqKpXHp+lzwTNqLFIsROXg6QpW9M2sLbZN3uNvcgWt2mw1WerVcCSvO0
 41eUi5PEgMw==
X-Gm-Gg: AYBFou04d8+5/ilpF6ytHyQUDa3TzRuuKi0SDXGRGbdsVuFMZmPTOxBf5kBf7DbEDmC
 db889arK1Yv+QDJMhiTJZmIRh8uA63HBKZeSjOGwSH3RcCH0rZsfDgrNCEUrE96ZtqiAUWKbav0
 vjKSAWEbYqPWJgmU6V2RsbGVWf/AlAG1H19clrU5NbCAicqp8qRfAWjBrzhe2IAPXvLsN5dnzkT
 3OBrdtT8ZBNjQMA6UbRo1LWtPHeaUQHrcj291rPAhFf7t9f8ZFVeMbpz7BF2N7Y+ecaYXuXZxql
 DhU5N7dbJbDjDblITcmcCYaR0CU5kJ78OzTFu2ow8OU4PyDCPA4A6LXyvAOFV6zX4sCsXjuj1+c
 X9MlF7EnBb/U9lu00R4zDz+VOTHpMHsK2vY9y7Si4UXiXaQaaJRzba8ao+Or7KS5A82frYR7Ocx
 ruVrcDy/SnJ0L7wf8tMEcXOAszilLT7/0zkAy5Os+nPFDuWCiqXiUwXKrvaT+s+iErowVyeLJVI
 oNAhDfvYmNj7PaIe+wNuA0t9f7Exq+EgSCsyDqCY4EAgYs7sULrbqh1nTgnrXgUBF94pEyycsfh
 J3/4EKO/5m9WljyX2Bg7PF+G/f3XiP8GsQ7QAgbKFhEXf27LPsNkzF17xu/b9XfEWqSyhIlOZHt
 0qUk7bWs8GSKdXpTP5hthzZZhZRrKC2vhmiiSDlYQQdUh2nsfbXnLHZ6j+Q0CdeIDsepbsQJ2fU
 ckhz2x/EdEwIeMn6Zh2w1lxca/EpJxNg==
X-Received: by 2002:a05:6808:11c8:b0:4c4:28a5:1885 with SMTP id
 5614622812f47-5773a00be79mr940028b6e.9.1794945788025; 
 Tue, 17 Nov 2026 12:03:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb0esm248119fac.3.2026.11.17.12.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:03:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261113170759.1231845-1-trini@konsulko.com>
References: <20261113170759.1231845-1-trini@konsulko.com>
Subject: Re: [PATCH] google: Take over maintainership of
 coral/link/samus/panther
Message-Id: <179494578725.2846501.4401312740802788339.b4-ty@konsulko.com>
Date: Tue, 17 Nov 2026 14:03:07 -0600
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

On Fri, 13 Nov 2026 11:07:59 -0600, Tom Rini wrote:

> These boards no longer have an active maintainer. Take over these boards
> for now, with the intention of dropping them if no one wishes to claim
> them instead.
> 
> 

Applied to u-boot/main, thanks!

[1/1] google: Take over maintainership of coral/link/samus/panther
      commit: 6877c99910fc627b8b70dec0f974586a31f2fe27
-- 
Tom


