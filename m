Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2857CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 11:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E30F846AC;
	Tue, 26 May 2026 13:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="SeV5+M1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D95846AE; Tue, 26 May 2026 13:48:10 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49908844CF
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0A5E826B12;
 Tue, 26 May 2026 13:48:08 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84wF5gbDRgcb; Tue, 26 May 2026 13:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779796087; bh=BSlEvtBLupn1PKLhq70dO4AsBXdmpGd+QH0i7RqP9ps=;
 h=Date:From:To:CC:Subject:In-Reply-To:References;
 b=SeV5+M1nD44u/FjvUPw5p3Uue0KR7mdyER+qeFOZ2Tj7HtkiHEVcW7vuMPfd0oI0R
 49E0wLO7c5jyiArt+QnjAbFUKybcXu0vEHkn8qpNdpuzQbNb2vwrEiyipXjrFURApS
 Q+C9LDi6EHmhsGZ1fAk6XLu+LMCgPflZibsxeZfTbcvlMcrgOFYgrYTlTV64rGlCzE
 XWp5SHp0PnIb1svdWHw0eqVuzbOOCfWo6OxRe7/yWrj4Xhe0pKKETC9wwXaZa/20qE
 IQB0MbEDQvIP3GMDfh7J9bLhiRlnizt+AJ3CjlsIfSAoOshhE4RP+iEV0D7NJnDgcV
 L5I2PDhRcH6iA==
Date: Tue, 26 May 2026 12:48:07 +0100
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/1] armv8: reduce core errata dispatch work
In-Reply-To: <CAC_iWjJh-6TNd+nYRAbp5Dx4SPs7zivoUJsYtCvugUuz8V+mLw@mail.gmail.com>
References: <20260524123822.7244-1-josh2@disroot.org>
 <c67720e2-bb73-43ab-9d75-851ef1f4afaf@kernel.org>
 <CAC_iWjJh-6TNd+nYRAbp5Dx4SPs7zivoUJsYtCvugUuz8V+mLw@mail.gmail.com>
Message-ID: <96101A77-29EE-4612-B161-DB192C9E30F8@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On May 26, 2026 12:11:06 PM GMT+01:00, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>Thanks for the heads up Krzysztof


Hey Ilias, Could you please review the patch "code wise"?

I did put the testing I had in patch 1s commit description 

I know it may not be sufficient enough, but unfortunately my machine 
isn't the strongest, so sometimes KVM crashes booting u-boot

Proof:

josh@armbox:~# uname -m
aarch64

josh@armbox:~# ls /dev/kvm
/dev/kvm

josh@armbox:~/contrib/u-boot#  qemu-system-aarch64 \
>     -machine virt,accel=kvm \
>     -cpu host \
>     -m 1024 \
>     -display none \
>     -serial stdio \
>     -monitor none \
>     -no-reboot \
>     -bios build-qemu-arm64/u-boot.bin
qemu-system-aarch64: Failed to put registers after init: Invalid argument


Note: ^ I did get tcg sort of working + a KVM small test, (for the results) but u-boot doesn't like me :(


If you would like to still pursue this, I'll try to build it. And give
correct numbers

It's fine if you don't.

If there is a bug in the diff or if the test coverage is not
enough for this path I will take care of it. If you are concerned about
authorship, provenance, or how I tested it, please ask me directly what you
need for this submission. 

I get that the U-Boot team wants a tad more oversight here. Id rather
be judged on the patch itself, on the basis of the diff
and the evidence in this thread, not on history from a different project.
 
[Snip extras! :)]

Thanks! :)
