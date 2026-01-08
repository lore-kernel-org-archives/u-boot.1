Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252A1D1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 15:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FFE841E7;
	Thu,  8 Jan 2026 16:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="ntACOryc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A3683885; Thu,  8 Jan 2026 16:00:42 +0100 (CET)
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch
 [109.224.244.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCEF80077
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 16:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=alqnks3fkfhcbpzask4oxz3okm.protonmail; t=1767884439; x=1768143639;
 bh=eLGpNwSjX4KYGlukxsbYCKCytygqd26+EOUM+vgf4Wk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ntACOryc+jN1/ChGyVBJIcjXmKhmctLhcWQrEYaCyVPYmnsONmbiSRvnl21qiOLKM
 aYQmDmNet242v0D9e54JwaTVaUqy6bq6uFBggNSS6Avk8gK1AiFYid1HpM1KODEGP6
 w2JH6p8TNBr7TdGLi7kIuxxygx3I9VxGbVLOFRDYhEr1KzezTlz/hXTM/pShWOP8ZS
 EZ/1wwcjfbKLiLMtgmc1JyKnmCUQ1JzpNaIv4+T1tTFISbsgiuBm0YO8ZMdmu8wB1L
 krMlyoU2oBf38UMPchz8aCGUf5uffCsxbkqfeOqtIy3A1snZVGBQNsXQsPOxM4/OUG
 Ze6AfSLhf3ZHg==
Date: Thu, 08 Jan 2026 15:00:32 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: Re: [PATCH v2 0/4] fix integer overflows in filesystem code
Message-ID: <20260108150025.50206-1-t.preissl@proton.me>
In-Reply-To: <20251231015450.GW710860@bill-the-cat>
References: <20251228164500.313817-1-t.preissl@proton.me>
 <20251229144813.GP710860@bill-the-cat>
 <CAFLszTjFP4N1v-=Uob+DRpG_Fc3szkt+yziG+cbLQ7nxaM5mvQ@mail.gmail.com>
 <20251231015450.GW710860@bill-the-cat>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: ee05e16cd8345eb2e14cbe1958e5c2e84604fc10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 08 Jan 2026 16:58:06 +0100
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

Hi,

this is a gentle reminder for the v2 patch series fixing integer
overflows in filesystem code, sent on Dec 31.

Any feedback would be appreciated.

Thanks,
Timo

