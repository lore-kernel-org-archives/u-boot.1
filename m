Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230DECA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E042A41112;
	Sat,  3 Oct 2026 12:47:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VJQBMNd-Kugh; Sat,  3 Oct 2026 12:47:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF258410C8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031671;
	b=TsA0YdEmQHfz6ZngLyUTJ72iIyO/Ju4O1/MYXrgOTIcmd4cbPAoL6eswyI82lY4xlwp6
	 uwXAKSuFYpZbr1TP8xNZ0yw2CAadh8cOt59DS/0TkMRPv6iClHY3VNWSxK5GrMyCWZIj5
	 WozOY96wZbZ34A+DHjx1mO1Gi4/KpvrwMz2TIcdqK3tmSQW5uWitkaIWb07gWrP6CYYPp
	 +rMrpKsy7q9ox83ieUKqSePizYcQbeNGDayZCarqBFfNkbWGo14zspnfTG1bC5S36uAYt
	 gzHRQxeBkvwcw0a30g+/vJOCgamWnKZxfdOnHkmdavkHExNOhMgFxNYArhvPpLTKDdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9bR5hfki+kptUlT4vp1y1NwLPbbg8mD2ioCfz3p7VMw=;
	b=XeCnhp/bgdi32o0zY3nM/wo3k+fk310bN3vg4rdy1oCRm+6QDRUcAMe1Xv6CoBiKHwvu
	 qH66Bj28IZsDAr9cDJSQDvSEih2nLw1U0O3QWDYIQrgnjP7/K3J1HkpU7Zm6xDSbgoqvZ
	 Emmr1AiucjeMzJXnT7pFqZt2nHB0aSht6KtNETIWpWv9JJuZQF2q3tuwkAtyAZGLpS4ad
	 nK4WmK21yK932Y6tjdto0MTMV4pQVcHi04dCqusBTZ/c//lfQZJBOceogXwPL3hV6+xOI
	 QiRdzovmIjBmuEEzjq5ofNB+MAZ1eVMNw4pHVzeici1/dpLa6lmcer6+2JqHSov6JVw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031671;
	bh=9bR5hfki+kptUlT4vp1y1NwLPbbg8mD2ioCfz3p7VMw=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=syHUCQWRtLxd9COiRWzriPgf81+F50q+rPPm7XAkbL932JItPl6B2mTLH6TUomE5Y
	 QXT4481gJDIAllNyGPnAsum4EOcphVj0O69CtKwr3sUl3J8ZBcqImI7arpzcb7ajYC
	 jj1QkZxL1rN+zef4s53D3J/HCwlpzo9FIuCm7yv+70/LsdhOH82Ry1QypD23FlJb/k
	 7YLOPlpJWrMxNysr1UZLYUSwb2RABEMIxW27D69GkO6RC++ypIplXKL6bjzhjrV9t3
	 YQYxKrh3bNyxUWrTGU2V0ljRVGpfc/HvK34dau+gIfDRpp7upIUC7CCLx5bAkSzef/
	 ThvKOLMOgNifw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF258410C8;
	Sat,  3 Oct 2026 12:47:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAF8734D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 02:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0F118129A
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 02:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qS__UetuUukm for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 02:29:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2ACCD81298
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790994549;
 b=FkYvmzWGmAdi6sZL/p27m6nzyMmQI/tyTgAbAwPyW07+YqSVFsAysXD1By6j8buBsfle
 /o8rnmnpahnIhENkHdWMEfrsEF2H5giyUTw5wZaUvrNDpy8BzvZ8Vr/IvE54CF6Ub3/dW
 eFPU8y7X206oMjMqsmKiY0e1WCrdZIBdBJqIGlYIgPv9QGLAkeI6oIBc4VWVNItBzLyUk
 JNNvA+pCMEuJGNtoPyuHNV80L0xYfT8+6qumn71NMhKnAaVeQmzhVu9q9kAdSOlpp+FGT
 YhB3c/iI7cL6PYzHYWcCHum3TYEcQimuYYI5q4DHkUIA5wXa4fMxJPM9ceBcqbJqwrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790994549;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=9bR5hfki+kptUlT4vp1y1NwLPbbg8mD2ioCfz3p7VMw=;
 b=FAHBEfQXDV3lSDrEulEQFDbjo3UTW5cVrRtogKQAPS41PNGySs33JI5YYHUy2WfWuaOj
 Q1nKIBnRnot4GJQrs1obynFbGhRhh4SZnr8TKAs+adkJ7Ej+BssWVEPyeVAMMXhQiSTb5
 r7lVF7aVX76WKA0hQsXY2PKmKqSL+mWvmhb8bIuEJDnqiyyqMFj44u3zOhZh0vzFKRluI
 cRRAYmagfn0PPQ+kRO5mgLNwd0khXdYEnNNUNeKnKGz9PjKPYEuoGPBdYsQjPVOuzNxr9
 XS/fdhsG3C6pJrt3blhi1tC4VWwyfyRs0yxwFd4aDjMnkq8+MjcqB4Hh7lmlesSInjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=GVU5EzBI; 
 arc=none smtp.remote-ip=109.224.244.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.123;
 helo=mail-244123.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=GVU5EzBI
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch
 [109.224.244.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2ACCD81298
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 02:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790994546; x=1791253746;
 bh=9bR5hfki+kptUlT4vp1y1NwLPbbg8mD2ioCfz3p7VMw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GVU5EzBI3fFNoENnFHzsk+JkbcONmTg5DfraAbtPVlxJdD7XDAETvFVNDBKI5lvY/
 vyfx2jzAGwC6D5YPoUdSMccZAHQ3rMp1kWb8reHj2oPzkMxZLolePu8VjmluvUOWUc
 td8ZQQGKMCiYT+i6PWK9slt2N8xRhieVqgewrjK9w0Q4gO1bp7ZZwTVPBe7w6kNt9m
 uBvUhWajOPzJXmq/uuDcS7IVlEJuw7i6TYtjmSyYQpFx9frRXpycEHMZypT63ZpeSq
 ORmd/DUypEsEj/h2ab1JNSr0bLe0sr0K4NkgoiTj6s5FsPDc5T7mt9XBmSlKWaN1AJ
 q9eSdkwAvRWDQ==
Date: Sat, 03 Oct 2026 02:29:03 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH] clk: spacemit: program the mux when setting a mix clock's
 rate
Message-ID: <20261002222800.clkmux-v2-review-reply.DaveWK225@protonmail.com>
In-Reply-To: <20261003010452-GKG51329@kernel.org>
References: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
 <20261003010452-GKG51329@kernel.org>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 6c11592ef2aa02dbec7d2d8845795f602dffb4ec
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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

Hi Yixun,

On Sat, Oct 03, 2026 at 01:04:52AM +0000, Yixun Lan wrote:
> .. this will enable parent, would be it ok to combine below
> device_reparent() together? to simply use clk_set_parent(clk,
> parent)? it make sense to me to reparent first then program
> the divider

Yes, that is better. clk_set_parent() only enables the new parent when
the clock itself is enabled, which also fixes the unbalanced
clk_enable() in this version, and it matches Linux, where the core calls
ccu_mux_set_parent() and then ccu_mix_set_rate(), each latched by its
own frequency change.

The one difference from this version is that, between the two frequency
changes, the clock briefly runs from the new parent with the old
divider. Linux has the same window, so I'll keep it simple unless you
would rather have the divider written first whenever that window would
exceed both the old and the new rate.

v2 now reparents through clk_set_parent() first, then writes the divider
and triggers the frequency change, and still writes nothing when the mux
and divider already match. It also reparents when the hardware mux
selects a different source even if the framework already has the chosen
parent. The parent/divider selection algorithm is unchanged.

I have retested the integrated board-support lane on next bd2f5794b7e2,
with OpenSBI v1.9 and your FC fix from k3/for-next:

- OrangePi R2S: eMMC SPL boot, SDH2 I/O clock 204.8 MHz, U-Boot HS200
  at 200 MHz/8-bit, EFI and FreeBSD boot, and an unattended reboot.
- OrangePi RV2: microSD SPL boot, U-Boot SD High Speed at 50 MHz, EFI
  and FreeBSD boot with root on NVMe; two boots checked.

Both CPU clusters remain at 1600 MHz on both boards, and SSH works after
boot. The R2S, RV2, generic K1 and RV2 SPI configurations build SPL and
U-Boot proper without compiler warnings; the patch passes checkpatch.
Generic K1 and RV2 SPI are build-only checks for this revision. I have
not run before/after performance benchmarks.

Thanks,
Dave

