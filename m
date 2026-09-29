Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A3C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 04:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D21E404DE;
	Tue, 29 Sep 2026 04:59:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XRuzkMWt5k_i; Tue, 29 Sep 2026 04:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B0BE34043A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790657944;
	b=p4nV6A8gziTpeBCslQ/wJr8LBviMMa7Zpc2lNTdxU1uMZdaTfjHRpa9qiv57C7eg3Zhg
	 8loXJC4cuGK4WHX9Hfq1s3x84cCuAKOLtHWUb2ZgDxOGl/BGczAj3GlZ8f16qm4Py1dUz
	 7THR29eYf/A+mdIk1Q8VzaQ3MHtXeynCfLeRJA+GBtuc3N0EVnAIa/N9ksti6Z6kCFsf7
	 wRq8LQUdpfW5dwEbAJwKJ76yHVpE7Ps+EcylQeB8bF2sA8JezAksvEAHrX4fo6sXwDOmV
	 ZFDglIwpusvhzXrtaxdTnOhiW5IA5F46Dg7Vi6CNdZoYJT7maoqaLxbqbzA3g82oDrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790657944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XdrmrNl8UyXgzdlNHIaX5cpKyL+rX33JlTwiaA8e0z0=;
	b=rpNkb66O/3bgphDjgA0i0cSMAX85V1YfUaaktucN5qCvT4OcRDL8ciG8Q4L2ii9MnVWK
	 PiaOnTNjwuRkiM9741DSKSJzSXaE+8O+I2poIplW93zTSDS+c5dWObocrvFmss9tOB6ZK
	 9lknnSLSW2it1YNgTL02BBw/kueqE8QAUkwcq1VuPiHVblZkJ9JvZUBaxbsg1kEXAREyp
	 5wuyedN3cAOtZtR+69hPXaB34nR2QEZOi8Fbld2HfY7czfV0AXSx7I6G9Ts3q8Ic+6Df/
	 0bFarcZMxq0dNsiA5XqAocVlLYVgwNc2OiZ3pNB8mv5lrAOYUKQ5c+Ds17JkFlv7xOQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790657944;
	bh=XdrmrNl8UyXgzdlNHIaX5cpKyL+rX33JlTwiaA8e0z0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ShTfWMFF/Kb9mjE43rJXVYHmRZwwIvKCzJ0A6UPMjxFnacP0EwUejDoGIbhBSeHiA
	 ADr8GI0pmD+Tld4fxiMQOmxf6ohIy4N7OHueJ7ziv0wavlqNME+54RcPd2yu2eakqm
	 0tGs6BMJtspt2RcrzpgM8uzm3Wz/X/fu0FjoIWc/w0Y1QIMFi1Eht8yToLJF8DANY7
	 7Wjf6LccQLePTZdqeHkkh9cowtku8Zzt4xgHhb+lyAhePg/ZeKir4hdMMAEdkBlvV+
	 NMWOgPSAAcz6XWCwPw4zM84A7cj845C5nZLqmUdPApNkrGHdExRfsMcDXsZBtqoJxn
	 /JE4KAonxqhcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0BE34043A;
	Tue, 29 Sep 2026 04:59:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AB9461
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 209006070F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U417bPzRaRQh for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 04:59:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3526F6070C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d501"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790657942;
 b=A6PYTikIyzXe+shte86Y3SfHDbN93c1R8TwLDl8TodYps6rBEJAfSFq+ruJT10J/1Ge9
 NrpsFIvloI3lOhadReCqp2XYW+SJc+mLAvT8kGRyFHUgkv71qgnZXWgtuX/2XuRprj4KF
 A0mw+mNtbtzdVCIHLGQttLPkxpzQpqWCefyp/8+GuWHXP9c0Ca2HL3w++/K9Ded8V5giQ
 CrdTVtJmhGskLzuavTcFf3mgQRo6JBhm1eF9BR6CAclNwj1fBiB6wUNfXwSZ7Lj+ViHE7
 KzrDcbnB8+SW1OU0GU5fiK6gn9W6tNnarampIddiX+dMR8wQqWnh4JVMkJHqyqxjkcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790657942;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=XdrmrNl8UyXgzdlNHIaX5cpKyL+rX33JlTwiaA8e0z0=;
 b=f9WJuI6QsWKU6dH3mPYsynpZfusdcW099voymxw/BrLAq5bvCVUwEo0jUS4kk2UfnX8j
 zNmOyctiTYgAWLu+iUxyty8o8+/v45ZaXzJ0lAn3lA7fempZ/sLXC4K55yb144tkfIeDj
 FJmbvygrd4n9Ti+2xU7+ciaF6oJvIiDuDpEUeMOzYMGL3bCOxsgXkMLf9MdWzysOnCTIy
 PKBOiTFM5lWxM3KD2nvfgVy6h3JesQNua4+DLhaSHVBNNjsY3CufXD4/hP+n8qmjjVrRC
 zPSly5nQ7bR20qUT2Jzg+ZG+o2NvnRcWmFWb/KVFmzOQy9307jnBpKGE0/xzuLcNC6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=RXuk4czo; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d501"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d501; helo=forward501a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=RXuk4czo
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3526F6070C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:58:59 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:638c:0:640:aae5:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id B90B4829CA;
 Tue, 29 Sep 2026 07:58:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id kwZ6f5wgYW20-eLXP4s3B; 
 Tue, 29 Sep 2026 07:58:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1790657934; bh=XdrmrNl8UyXgzdlNHIaX5cpKyL+rX33JlTwiaA8e0z0=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=RXuk4czoPx0o45j0I+xPfRika+SfDxHN//+UVpzZ6BWIupYOi47Ggy1ybsLfYdEGQ
 x9TQNKAvZrmg7drb2nKYoJ1kf3rYjryUjdPQjlrvA7wqGCKyOE8CTtUiouHCGHkpDm
 bBznIUmQLnxCfxY7e7AUhIxnekVWMSww8q3Q7lXY=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <b40e05037fa322d747ab6b48f7e38838f38370e2.camel@maquefel.me>
Subject: Re: [PATCH] riscv: Fix IPI not initialized in riscv_cpu_setup()
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>, Leo
 Liang <leo.liang@sifive.com>
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, Michal Simek
 <michal.simek@amd.com>
Date: Tue, 29 Sep 2026 07:58:46 +0300
In-Reply-To: <arZdGzVgm9ZtnSm_@pie>
References: <20260904-fix_skipped_ipi_init-v1-1-3f4e7a10efe8@maquefel.me>
 <972c116f-a430-4ed8-8b94-e4c1982e5f22@amd.com>
 <856f099441f717605de9be5456dde8c97bbd04d1.camel@maquefel.me>
 <arZdGzVgm9ZtnSm_@pie>
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

Hi Tim Ouyang and Leo Liang !

Any comments on this ?

Thanks !

On Fri, 2026-09-25 at 11:38 +0000, Yao Zi wrote:
> On Fri, Sep 25, 2026 at 01:19:15PM +0300, Nikita Shubin wrote:
> > Hi Yao Zi!
> >=20
> > A shy ping on this patch.
> >=20
> > Thanks !
>=20
> Sorry for the delay.
>=20
> > On Fri, 2026-09-04 at 08:20 +0200, Michal Simek wrote:
> > >=20
> > >=20
> > > On 9/4/26 08:07, Nikita Shubin wrote:
> > > > If riscv_cpu_setup() is skipped we end up with riscv_init_ipi()
> > > > not
> > > > being called.
> > > >=20
> > > > But we still use riscv_send_ipi() in spl_invoke_opensbi(), so
> > > > even
> > > > if
> > > > CONFIG_PHASE_CPU not set we still need init IPI and clear
> > > > pending
> > > > IPIs
> > > > on harts.
> > > >=20
> > > > Fixes: d8810e1d4f82 ("riscv: Skip riscv_cpu_setup() when CPU
> > > > driver
> > > > is disabled")
> > > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > > ---
> > > > =C2=A0 arch/riscv/cpu/cpu.c | 3 ++-
> > > > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> > > > index 3bec7c7cb6d..a65e6951384 100644
> > > > --- a/arch/riscv/cpu/cpu.c
> > > > +++ b/arch/riscv/cpu/cpu.c
> > > > @@ -639,7 +639,7 @@ int riscv_cpu_setup(void)
> > > > =C2=A0=C2=A0	struct udevice *dev;
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0	if (!CONFIG_IS_ENABLED(CPU))
> > > > -		return 0;
> > > > +		goto init_riscv_ipi;
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0	uclass_find_first_device(UCLASS_CPU, &dev);
> > > > =C2=A0=C2=A0	if (!dev) {
> > > > @@ -687,6 +687,7 @@ int riscv_cpu_setup(void)
> > > > =C2=A0 #endif
> > > > =C2=A0=C2=A0	}
> > > > =C2=A0=20
> > > > +init_riscv_ipi:
> > > > =C2=A0 #if CONFIG_IS_ENABLED(SMP)
> > > > =C2=A0=C2=A0	ret =3D riscv_init_ipi();
> > > > =C2=A0=C2=A0	if (ret)
> > > >=20
> > > > ---
> > > > base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> > > > change-id: 20260904-fix_skipped_ipi_init-aa5575f55bc4
> > > >=20
> > > > Best regards,
> > >=20
> > > There are 2 other approaches how to do it in the code but it is
> > > up to
> > > maintainer=20
> > > to decide. No issue from my side to solve it via goto. Obviously
> > > one
> > > big if=20
> > > (CONFIG_IS_ENABLED(CPU)) is another one. Or move it to own
> > > function.
> > >=20
> > > Anyway
> > > Acked-by: Michal Simek <michal.simek@amd.com>
>=20
> I think it's likely a bad idea to have IPI stuff in
> riscv_cpu_setup(),
> but this fix itself is okay. I should have noticed it when reviewing.
>=20
> Reviewed-by: Yao Zi <me@ziyao.cc>
>=20
> However, I'm RISC-V's reviewer instead of maintainer, so I couldn't
> pick
> the patch for you though.
>=20
> > > Thanks,
> > > Michal
>=20
> Best regards,
> Yao Zi
