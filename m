Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F8FCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7BEE40507;
	Tue, 13 Oct 2026 13:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duDa1TjJ9eiz; Tue, 13 Oct 2026 13:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3972E40448
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896994;
	b=BJfwmRPptC6sEjjJ0H8NLDcusD+UTSKZBY17pfm3e19psLGMBIVxreVRvIss0Cr6ZQyC
	 B5y02BC1Kve2KaPDlkhhTzp/dQMg8hg1ChJhfbuX6WXuk/WNW+gxfqO3WzzXjwYjA3ZEG
	 73DOe7nV+9aqVN0NmFAyS+O3JehFkZmV8iPmspMg5RMqrQ8PWlvg0uGAdfl6WGOzhEIOF
	 8BPlvh/7+a2HWGhWLdA7af1+CYVecbJqELObgh9zqLa7G4Bv0Dymk0eWwxO7j2FCTgsaD
	 HVKrDQJTXDrwKaldqpGuUxKHFUq0fOkcBL8oeKStAucWzSsc38zJIcxkE8JTNwLVQQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896994;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6wIfcoG7iZKIC3r63jD8YpXdB2wUB7E/LqMBgi0NtIk=;
	b=XQsaWAPlwmQ014vLQH5xwdVApIGQ4FYwFwe8iWghubRer7e4fFlqtbRe2rinaeHf1LUh
	 RVGJOoH5PJjIvov6YMlIzgukBAhOD6Faxt+8VSdMDhllvBcTVxqum/PA8/vTjTkHnEloQ
	 ZrjoXEW1u+Fiu3P/2r7BrsAezAfcTQNhitArAAaFaoM/5pMx71mWvU83bSm+6oS0qgzyN
	 L/zjpOIWjZ1+KdwxZQqdCXprIDNUA12jUGrByded4zl5YGAxvHD/RcS6Fj4wXvW3KoXZ0
	 Kyqok2DeYKptn4J/6vzGSRlx9/fBjquF8FgOzqWSv2wg1jzF72KAbjp2604YLX8SKUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896994;
	bh=6wIfcoG7iZKIC3r63jD8YpXdB2wUB7E/LqMBgi0NtIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FfCeynIk0Gw7dPfCbZYNrwA/6K/fvsAcZqicFwPvCebOZ0q6NOp8UkJrpr8z4OwKj
	 u+fimbEXSjuhXuwbHoP7PTDiY6SJOSjC1UCg81azhjSfTj+QXc3QAD1NmxuQuIZ4Wt
	 f2aKfg0Ritfi+M5/OsUMvxay4qRlzDNUqNK9pPKewskO3vrAmr9UfFh6bo5cl0Z3lu
	 7k38gIDfRBDWDo1w3fQj70HXwAttzEPOK0a7RqBB67d5uheTqOb7HGZa4QQs8edMEG
	 MMzSx2pZWyOot9J8Zqgfww4MCFxNtMhaeKCwvE0s+S5BwIYvLvvJiqqFPC8hwEKGE8
	 IQqSmoAb1WSyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3972E40448;
	Tue, 13 Oct 2026 13:09:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D3E4788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F58E60681
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KLqqvdQJ4_gr for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D58F560652
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791896993;
 b=RJMJXeIwO1+a0K+07jG88cIQLF6Tsu9XgvYp1OzbWxiegls89j1YEzdVbvtrRfklfkhu
 NYFda58xSemZuC1+j5LpKJbCKpizQGAR3+976LgbS4QmysD5g/XYHAH6VLG6fvKa4r1Xv
 N02IHyjGmUBJPSx/hEL4XyyIe2NdsQSsaHt/OXBBEfEah+foTgLiAZ0p0BBzoEaPOr0fg
 BZY/kgjfmczoNpxn4Scf9pR0rpDnvBJWSAE9+XzcXqsQUJHsO4rOtJoSpI0W6+TNd2oNj
 1rd/BsIXNlioh1O4QLuKR08o4wXXRg4WU4pItpTPGG3ii5zYRR6/IfW+7Tk5fKOEigw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896993;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=6wIfcoG7iZKIC3r63jD8YpXdB2wUB7E/LqMBgi0NtIk=;
 b=sVe8pldzVr/Ww59GLgsPs2AzTKE7f+sB3l0a8wTLvCndSGUSikc4guDu1CD30C8emydL
 tSTnkD43ntx4ImbqwucAdV7yShh6Q0KH48f7+Nre4HNrc1T6RPoUagnPZ3N9WyuyUsCPd
 Ol6Vw7lfh/E/WvIqzYypNTQn3VMBw/1E70sBvLayyurCkFj8XpH2fClgWSilW1A9aBu/s
 Ai7pmNtanVufO5TZ+V7jmtHZeoH2XCn+jyiEmCth/YGIytNq7smIoOAZrPXP5i3wlh+g9
 7RkoeGcSfTO8FJ1IKeSovxzxdlLJQG+qmuJYmK9OyD+ZkJi4Ts4bSwyzM4+JlopOpkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UiBcZKKv; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UiBcZKKv
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D58F560652
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:09:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78D0B600D1;
 Tue, 13 Oct 2026 13:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19BB1F000FF;
 Tue, 13 Oct 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791896991;
 bh=6wIfcoG7iZKIC3r63jD8YpXdB2wUB7E/LqMBgi0NtIk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UiBcZKKvh9rWJfgpoilOQ3jnUjdLw1E/lDQrOsgQeC2BDDLWBkVWe/sdMIOuDWn7o
 aF8lB3H3OlWMMpfWKTMdD9ox0xN/0mGdOqpzL0NZjlEmd/b9jMf9gplWU5CLVTAGjH
 nfLZygaY4necaXo8XPMtnA6u/kFbQD1BMH/pO4zdd5PcL2S1tPSJJ/x05OwVaEGKX8
 XbUKUoY+Bw9slaB5zFcfaenle0pVfljhri7JhHd/tENa0Zha0ZLE/fPQBIsE1b33JR
 mZL9P+qzNy2YarHcD2k2ZX54wBKzAdp1t5ShB0Y6wi9NeIRfnQW6dlceo/Tfy/dJO+
 iXsnfw4bKICqQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, Petr
 Hodina <petr.hodina@protonmail.com>
Subject: Re: [PATCH] fastboot: scale download progress dots to video console
 width
In-Reply-To: <20261002-b4-fastboot-dot-width-v1-1-93bb3cb13179@protonmail.com>
References: <20261002-b4-fastboot-dot-width-v1-1-93bb3cb13179@protonmail.com>
Date: Tue, 13 Oct 2026 15:09:48 +0200
Message-ID: <xhkdbmrsh7nmr.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Petr,

Thank you for the patch.

On Fri, Oct 02, 2026 at 22:52, Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org> wrote:

> From: Petr Hodina <petr.hodina@protonmail.com>
>
> The download progress indicator wraps to a new line every 74 dots.
> On boards with a video console the row is usually a different width,
> so query the active video console's column count and use that instead,
> falling back to the old default when no video console is probed.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

