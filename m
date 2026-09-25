Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45892C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 10:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3ABB60BC2;
	Fri, 25 Sep 2026 10:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-nG9hCCp5ai; Fri, 25 Sep 2026 10:19:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 08E0C60BDA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790331575;
	b=hlXe3sCs9bi0SoTFh85MmB6/3oWAokAEGvJanbi10toL3FJbcEiakQ/Ru7aBCi9tkDvp
	 OmovKBdMEuSSgowF0ZwRLXkpVrUEb55pt/+epwphFXtcpgPXzCUL9DBZh6PgkgRonkNhW
	 QFKkHkYgTq9FGbgAwIcpnwOLcgTgSeDNHTItcU7qqG9Ub1+XSPIJT4ERZ4CeJU8gLEZjf
	 ZckyB9rAwgxIUlcOuOdEB8TZ1tMQZjfbURrPfYMeTyjgFdsuLDvCZ3GneI3NZIPlkyaQP
	 YsGhrKKdgorGjSsLxT9OZA4uBdkgL31wcfEid7QNTFyoM3kdKS9P3Cj1FhsH4fkSf0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790331575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZGTtCc+gRoOhXWcJpNvZEr55ozmY8M1zZl8iThrmsUo=;
	b=bZph/CVdUmrnsOVBA5Wc1NyjSnOg4q3rMFLAsKMLZk+9NYm5h7fT/1dXpUyo9JfUuFLx
	 DPtemiaCWEL+41B+cP95Ss3QQlgOI8onXzVqsQV1FWz07H6f6ksC21nHHYQG1cYA+atkh
	 lGJQ6AoOg3IeGDCG8Qlv1cNUGGma9FnhE64lEo92JQUbDk8bIpRQ5F/y1THYa8rLwgb+Z
	 Nvlqsv0HjSnvuP2v8b54B8vyGKVknTHWU2jx00Qn7zpJ7wVcbh45gmBG1k+Uld+db7YD5
	 FCkaiW2KCOWqg6QldnBiGInDFKlMurO0IbPOXifEJvdi3mubrQFlL+zC3RcmWK+U9IQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=pCJxkfNR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790331575;
	bh=ZGTtCc+gRoOhXWcJpNvZEr55ozmY8M1zZl8iThrmsUo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3A7s/mff2f19lFLpFhEva0auhNys7jIO2F/djs19oCsFNEXkjy1C9Lm956FkaDfn
	 nJGGPA4iYv7iZnDgIkCZybvF9qeBiZ+qdyp0yUdMnxYI3dIyQb0fN3FXxtcpz7jnLw
	 +9mrG1clcNntK5nKVlu6vU9aPO3buKesiRkT4GGU6R5Tjhp1Tublh/UQFT00yaFZPr
	 HgCCpkzUgohMSDSKq2JYtcoN6n76BoGfw/yY+X171c6WlyG9UNaXlwA/WDqXn5JyDt
	 1brXW9cnu0vbk0aemSkW3bAUJbzztNKVDnVbJ1fxSVInfufQYKlpM8JslVv7UEfyat
	 jjJh6c5S6LVqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08E0C60BDA;
	Fri, 25 Sep 2026 10:19:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5B2232F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7E7B60BE0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:19:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDqmt4ec5AQS for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 10:19:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9C0B7606BD
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d502"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790331572;
 b=lBB6VAzhXfB1nhb6z7upl2AaPPiQkN+x7ZGQbkWnyE+LFvlWdXyvhf+etoSGmEiEd+8q
 lajpAAylL8pOvfGHryj06zFz8zZ0aoD0ThsGzHRwgrTRyaEyrBxOLkyZzmcAdF/w790oE
 /a50r75JNCGGPVAhsO96MtTsaWegV/broTs0QGpsq8bOvTDWUE87t7eWcSbEkCcUPbDyY
 zp7eKb/gqF/khpFkGPR4sCqpvTxRKT4l8EtIjwmSQYYxtAiMnpU/92B8+3rJuz/UylubX
 +2OB98lj+v9+6Qnaaxs221lZjb8s3jaahXjevZmYTKoT2orpppoY3vab4Sjybt7oorA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790331572;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=ZGTtCc+gRoOhXWcJpNvZEr55ozmY8M1zZl8iThrmsUo=;
 b=ge4BkTe0taS/KNV7oqikqOpdTiJD/jG1PUHZdKtiT1jKyDoLkBlKtD2dYg2yvdPjBnX5
 q9p17Cm9SKCOxJvNshaHUXu35ysHJ2eLliIMY8fT+JAgiRtIKpXSC2/cxf+w4tU/4ewF7
 AxyyomuN8lCR/A3QtzczCzfcjKDOma9SroHoJqjCKkTL9J5ZtL/+QHU3zwDWOp8ExQQYS
 XHuP4bC7POq9Q00ZUMfSnvkIPHpYCdwHM1fjzTQNmO07YaAZAK8J1gCTdioHwHbkFh5RD
 7ADWI4XrH+3pjEufXr3wLs9Y9qSXGnzT7FFgRolGPjTfoXb72MdfZ9AD70H7iEkSqxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=pCJxkfNR; 
 arc=none smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d502"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c41:1300:1:45:d181:d502; helo=forward502d.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=pCJxkfNR
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d502])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C0B7606BD
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:19:29 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:7ba3:0:640:5ad4:0])
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 0252DC0527;
 Fri, 25 Sep 2026 13:19:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id EJbjfR9nJeA0-LLlxCzKa; 
 Fri, 25 Sep 2026 13:19:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1790331563; bh=ZGTtCc+gRoOhXWcJpNvZEr55ozmY8M1zZl8iThrmsUo=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=pCJxkfNRWsWYKA5eNXvV+GAVFyQ416fIYJ4sp+9u9M/PT7EaF2+2PdDccscUMsRjw
 Wh1wtfhmwpDm+p7v0y2xIV11DlGXD9BvuA1RcRbR+Lf7BP4bVDGl3RpPTvDTDEklTO
 y/ySMUL+NoRtOmxdJS6UTmLyTmUKypEXrdbPHRyI=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <856f099441f717605de9be5456dde8c97bbd04d1.camel@maquefel.me>
Subject: Re: [PATCH] riscv: Fix IPI not initialized in riscv_cpu_setup()
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, Tom
 Rini <trini@konsulko.com>
Date: Fri, 25 Sep 2026 13:19:15 +0300
In-Reply-To: <972c116f-a430-4ed8-8b94-e4c1982e5f22@amd.com>
References: <20260904-fix_skipped_ipi_init-v1-1-3f4e7a10efe8@maquefel.me>
 <972c116f-a430-4ed8-8b94-e4c1982e5f22@amd.com>
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

Hi Yao Zi!

A shy ping on this patch.

Thanks !

On Fri, 2026-09-04 at 08:20 +0200, Michal Simek wrote:
>=20
>=20
> On 9/4/26 08:07, Nikita Shubin wrote:
> > If riscv_cpu_setup() is skipped we end up with riscv_init_ipi() not
> > being called.
> >=20
> > But we still use riscv_send_ipi() in spl_invoke_opensbi(), so even
> > if
> > CONFIG_PHASE_CPU not set we still need init IPI and clear pending
> > IPIs
> > on harts.
> >=20
> > Fixes: d8810e1d4f82 ("riscv: Skip riscv_cpu_setup() when CPU driver
> > is disabled")
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0 arch/riscv/cpu/cpu.c | 3 ++-
> > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> > index 3bec7c7cb6d..a65e6951384 100644
> > --- a/arch/riscv/cpu/cpu.c
> > +++ b/arch/riscv/cpu/cpu.c
> > @@ -639,7 +639,7 @@ int riscv_cpu_setup(void)
> > =C2=A0=C2=A0	struct udevice *dev;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (!CONFIG_IS_ENABLED(CPU))
> > -		return 0;
> > +		goto init_riscv_ipi;
> > =C2=A0=20
> > =C2=A0=C2=A0	uclass_find_first_device(UCLASS_CPU, &dev);
> > =C2=A0=C2=A0	if (!dev) {
> > @@ -687,6 +687,7 @@ int riscv_cpu_setup(void)
> > =C2=A0 #endif
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > +init_riscv_ipi:
> > =C2=A0 #if CONFIG_IS_ENABLED(SMP)
> > =C2=A0=C2=A0	ret =3D riscv_init_ipi();
> > =C2=A0=C2=A0	if (ret)
> >=20
> > ---
> > base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> > change-id: 20260904-fix_skipped_ipi_init-aa5575f55bc4
> >=20
> > Best regards,
>=20
> There are 2 other approaches how to do it in the code but it is up to
> maintainer=20
> to decide. No issue from my side to solve it via goto. Obviously one
> big if=20
> (CONFIG_IS_ENABLED(CPU)) is another one. Or move it to own function.
>=20
> Anyway
> Acked-by: Michal Simek <michal.simek@amd.com>
>=20
> Thanks,
> Michal
