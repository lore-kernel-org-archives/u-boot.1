Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8FFC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 05:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3792A60791;
	Thu, 10 Sep 2026 05:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MgytqPfVDuLG; Thu, 10 Sep 2026 05:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 53DB3607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789016611;
	b=CEVbN0ihay2onIm9XKIk7SL0vYJr5X29vgO0YvlSFHuuvE1hg7Kqc1x6uJcKzX6Gni+f
	 16In+yJj238FgzTrycm9YOh2eJB7T3NMtMHE6KFLHQtXRIMd5nVHLT2EP2VwA68+g8u0n
	 cvht1A5hC16XfRhTPQ4kVC1LG4s/cca823O6XsbmgHbJMUJhO8mSDjU4jNry43tLlaIGS
	 UxcoSuGggMBDkTW9H8Z2/d8G3bqgDfi16T71JQgTj/kEauxzoGkVd7Hk9i0prFUlIbCO6
	 SnEyn0qZB9BFnUpAwFSvgZqF4ygRkNnNQz1Ke7abcv7Muho7SFJlPVS04wPkWrGtA9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789016611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=whluTodBfWyUEWOpTJL4ZiMZMbyrwZq3Mx5Dtsm2puI=;
	b=Fsl8FuH6JZkqcUk8GiELH7rfm1x4VNaOs8bJ4IPXVlsY6XkqnVOAqx70EBJRloCTgEZX
	 FdUd+PuXNYAjNSbF5IAQQVMIZtWpiuX8BjcH2pVfR99RKTkRgXKP1mkwizu62rYsonyNJ
	 hY1ckloQQ/7gpdhHb8thCoE66MZQip7/mblYchU1PL6HNTK1w0/dYIMmhTYgvG1CoA+C/
	 ZEGZxtBqWdN2g5KOhGZtgDvdDXUODi4ShISDEfV5V4UJINau/qQs17FsInLi2HSQNSCGT
	 rpK+JhsS9Z4rQk7YsDYCRBJghAxGCpI/fxgTlWcwcGlj/JJdFS1S2rA+zOnM0l2VplA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789016611;
	bh=whluTodBfWyUEWOpTJL4ZiMZMbyrwZq3Mx5Dtsm2puI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l38EDnVu5+W9P+GSJc3ZrDYtjpDDvw1c6vfwk7eA17G2dfU3DrPaml8vPjCdIJmo7
	 JeGdhbvkc4eedFC2JkaCmY1dVYV69XYAKrlKeTHIyiK9SJ87bLU2eM0Z8LMLSQNrrH
	 XkCJxAd5AEzNh5Z2zxcELw70cgv6o+jak7uUznVhjPIDAYrSamhnNd/gkJQvTvnkRN
	 cbtvObGy2BuTwmkPo0HWt3d/Feb5yjIpm1ojesqHpKHwzlHMALPYJKcGYRbK3lAMUx
	 3/fUpBqk1TsxgJ5b4SXJY3OK8V6lLSmq/t/8qZsz4yLrczFCU4MtbiLQSxJrW+Er6F
	 BEZRMDZKrKaSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53DB3607C4;
	Thu, 10 Sep 2026 05:03:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2ED02E3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8AD240868
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VUx1UrCnTEGi for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 05:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 266DD40863
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d500"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789016608;
 b=WJT6fPQhQZIL5nUwDbNfEDzYNPOL5pSyxraNdPkqv/FDH65vlWZb85qrFqWtEsbF1Gwi
 RqFErZkG6JjgY1r0zHDxo4+AOAUvlxZ/DCSOVwVE2k9Uq2OTPY5ifGiaghO+SfPt+1sHI
 bI64cfAx7+x5FMhkAOsrJyEH3xxL8a5QY+vSNwzObBPomXOLpO1N5RW0lT5eZff+SLfCR
 n91j6TK9fs3uqPdq5VblpDDmjNrhgEZ7Pn9A19QJZ9RZv5aVnhJ2qn15mGv9V9x4PPMh2
 oKu7+BTxx3Q4hPyy0LYkdtQBIR0btGGypsvHK/cYUCowba4iBZTIsBRfw7CBUotD7+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789016608;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=whluTodBfWyUEWOpTJL4ZiMZMbyrwZq3Mx5Dtsm2puI=;
 b=rW9OcIaxxLNbgi2SjoRbTFlbFHC/471TNaVyXvIepYWD35Z4Au0/YyKc+LBUM4Gu7IhF
 yPL/F9gURLKf6NSdVD4gyhNoZih1+opHKoVfIf7kcGz1oV1L2JTsFxPQYq+jVHjLBAWtu
 OQOT06CReRiYqlcT0+NhzlKaNh7hAk66DKtFScWvWASjRU0tS705UtufobriIubkHtNTN
 akPwli0zUDBNKy98yUa/KmWNNV1ffVibyiaYtVTQ2lnh07Th268a3BW11R5D6TcvAIAEJ
 audIVFmFMsl0SQyAK6e2GOQUcFwYaOAg3tnPdruwoLnuphkv52N+YgvRlaJO0RscDkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=SiB3lgpy; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d500"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d500; helo=forward500a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=SiB3lgpy
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 266DD40863
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:03:24 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward500a.mail.yandex.net (postfix) with ESMTPS id E2C53C25E6;
 Thu, 10 Sep 2026 08:03:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id B3HmLlfexKo0-x7lvZwOP; 
 Thu, 10 Sep 2026 08:03:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1789016598; bh=whluTodBfWyUEWOpTJL4ZiMZMbyrwZq3Mx5Dtsm2puI=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=SiB3lgpyhhE1kRiOGVXM8vLx36zSIU/BwYk8xNMiL6VKJqqjkcCN7IfDApsKKF0Xq
 OdoQdGQPEpp674igLMK/mNtjvIhFuGKAr4pn3mBLQYUphEl3peWWCEDQpWTS4lccPB
 OpqjrxSpVBWWr+T3oRR2CiRyVTMzHz+MJaoL9p6U=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <cb32e0b18e1c5de24042ee983b8e10755aa05f55.camel@maquefel.me>
Subject: Re: [PATCH v2 2/2] riscv: timer: Make RISCV_TIMER definitions weak
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Date: Thu, 10 Sep 2026 08:03:11 +0300
In-Reply-To: <aqIuasUoIlSaQX6L@pie>
References: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
 <20260909-riscv_fix_early_timer_mmode-v2-2-563bff2a50c5@maquefel.me>
 <aqIuasUoIlSaQX6L@pie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
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

Hi Yao Zi.

On Thu, 2026-09-10 at 04:13 +0000, Yao Zi wrote:
> On Wed, Sep 09, 2026 at 09:31:00AM +0300, Nikita Shubin wrote:
> > Mark timer_early_get_rate() and timer_early_get_count()
> > as __weak to avoid link conflict with other drivers
> > (e.g., ACLINT MTIMER) that also provide this function
> > when both are enabled.
>=20
> So with only the first patch applied, building of
> starfive_visionfive2_defconfig is still broken, isn't it? IOW this
> breaks bisectability and should be avoided.

Indeed, sorry about that. Will be fixed.

>=20
> Best regards,
> Yao Zi
