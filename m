Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCD5CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22C1040715;
	Tue, 13 Oct 2026 08:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqipH4C_EahG; Tue, 13 Oct 2026 08:45:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14D2C406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881113;
	b=MIxClV+bT+CTrzp3puYYk+u+au3ypVkKi0anUo17e9yMfwRwEiqqwJgb7CnQxQ8p4Mry
	 FAJ8Vd5qPdaDqDxw4tySQ3AQilSxyyUqF7lXFTczyz0LuxfDUFGlnVbw11Yg5sqb+7hSk
	 HvXYAPCiTPFNuWsz3nnU0NeULKpDiJrPbxBdUOxy4IMISm8BaptUPTG6jlDjgn/GyneZC
	 r8sWVxr0HQZ5kGs/Nd5SiYUeSi8X3sIxFD3tn67kEw26MDFUnq1Jy7qbaj8wGDyeXjK7d
	 hQWo8KNpZeYEBc0RJV500Ut0cPEq+M1WbX0iuWqraBKQueZa3qW+fjrwKR+H91fUvFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7r1gr/oBEog8j7NJRCxvKEzRK2vw90snxSR/ewoaRG8=;
	b=CKg6XUtW+u8fv7SdH5ynGTgDih8s2WZLg2/EuuZzi9YBEz27xWPBapsEdu+fVZKmTfvh
	 f7fEGEKAaGmf/G3KUzDjPbOMbBjHAXsoqjb379JocraBmD3G25Kxz1rIiH9KeHtC9X7dy
	 L3ymZOQYxfVrV8QoaoqUbDShRq/J5psVr3OpTpeHfDwOpdWHgPn4OHjyUEVmY1I619I3A
	 AbVKtwYT1szMRhwq18b+37FVWVT1lfH4kYJqrmbwWtPt/A4zqsQjhPchbCsOV8mGelnHe
	 WXlta2Cg2rkWCMQ6y5B2UjMLfWdWPPRtj1FB3BIfA/QCs+PFyFc2zRplBeU/DtrXMfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881113;
	bh=7r1gr/oBEog8j7NJRCxvKEzRK2vw90snxSR/ewoaRG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cDaYJWEuwcWfgWobAHLnQVO9Z4iPiDA/XxIfJvqkShPpk7npNDNrarzjvYuQdCxz3
	 8/DwQMszDzVxlHa5hrFqFmaqnLgjr4xNIdupAXtRiPIzjzbcP7qzkKlPXgtEwkauNS
	 CwxGhJrVb6mybdYWyzlMleEXGMlZEqi4RleUd3BU2spBzmcpG9KO13pVX5LZbWuuWm
	 oRoPi6WIBcmkXQbDc+iqylDxafq5LN2WmczHP9BgJYLvD5OJTDXoeqXwa10s4ODdF1
	 blQFkS/ypltBxAme8Hxy7Ikhxe2fD/1ExfN1JDXpA0LKVxniH9tupkSperFZri9FB7
	 bQnOFhbHQokTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14D2C406CF;
	Tue, 13 Oct 2026 08:45:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00155788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE0A980D07
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNJ2eNTinIJg for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD10E80BB6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881111;
 b=OV8WOE3FLUGUeJLmgdHYg77eniuGK5hedEQ5tTq/vXwTsZGRmnlqD+UesE6L/mnZJY7/
 5IwJrrIcpkxPInXcRqPx0uJ4yZhy60vauHYbBkCudJI1AE4kpdrhDKaslh5SKE5Ky22rS
 ys77OG76GSZYnpre+VwjromDoe0/ygKa5iR21eXofPOM9FYbRzNuGknDi7rUt/lm5JcJE
 CfqWg5zVxdLnquv1sM/YX+SEtodxeH7bvS29ib5o3VTJsao+JwCmKMdhAjfVmFf7PpS/l
 yJ1ykDeC41BNCFnbt3mAH9tdeOO5ADMdiy4xhbPtpjzlPwj2CqSJRY0ewXWeIdPSgPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881111;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
 bh=7r1gr/oBEog8j7NJRCxvKEzRK2vw90snxSR/ewoaRG8=;
 b=obAuvULdQkoLP765pRcNRaxDIUR23LmPimGSpuA+gn5jfcwo/Jhvs6qBYS4eZ/TwhjhQ
 WkCHt/sYKDIM7zfwHnyqjx7OvV5qSwNyncZzJDhOyvVPzwZpWs+g0UrNn43YPn2qStjnc
 21S3iB7CB7nbIZZlUyb5PThO6ZkoIMxRuOsNdD6fa+k6+rJ8lsabGzFpg4kqQwNDseGXi
 1kCm+C0JD77aSG6gGObIfEk5eLgT8ewjWhDKK4AbICJAH8iU90uclml2oE8CgFU572AsP
 2hqs/vXX2u8My+wnl5Z8ZZXLPGVAJV+Sj5rplgqlZkphAflE5Wa1BwXGiimPQFW+gTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=uKimPWaT; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=uKimPWaT
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD10E80BB6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 447C64E4120A;
 Tue, 13 Oct 2026 08:45:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0FEC060362;
 Tue, 13 Oct 2026 08:45:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8BCDD11D701C2; 
 Tue, 13 Oct 2026 10:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791881105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7r1gr/oBEog8j7NJRCxvKEzRK2vw90snxSR/ewoaRG8=;
 b=uKimPWaTShbZue7gvQoFuZCNhhvZKF6ugd6xxFlh0wRsOmh7ZyF4KL5XY3rmraI8U8upTb
 BxgGjxtGNAKE9KaVEnZZVI1bYYoBaQ4fVEa9cRIyzn4ZQ2ynpiFDZS/ltJ237qR2OaXgqW
 B/orAB61qiN/KxnNp3GGEU2cJXp0AhPE4zRCcGA3wd2q6Q8Ik6PZkBahb9lInQzv6Hqx4L
 0jsx2fB+W2WK3+6GSbG4dtQakJDz5+qNFRrndlP7qd/47AkmnMjEcRzjaYUEY5IRWgx2Hg
 gsQjAOhF6iRxU5Zau+4xTpW3B6j0tkJ7fYqe+kcJf4++tQkENXgLDMQUf0YIEA==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>,
 Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?UTF-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 03/10] disk: efi: Reuse the GPT entries buffer with simple
 malloc
Date: Tue, 13 Oct 2026 10:45:00 +0200
Message-ID: <0QsgRw8RTAyVBggNhJIj0A@bootlin.com>
In-Reply-To: <20261002152605.GT858934@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-3-bc44cf0e0289@bootlin.com>
 <20261002152605.GT858934@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
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

On Friday, 2 October 2026 at 17:26:05 CEST, Tom Rini wrote:
[...]
> > +      size =3D PAD_TO_BLOCKSIZE(count, desc);
> > +
> >        /* Allocate memory for PTE, remember to FREE */
> > -      if (count !=3D 0) {
> > -              pte =3D memalign(ARCH_DMA_MINALIGN,
> > -                             PAD_TO_BLOCKSIZE(count, desc));
> > +      if (CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)) {
> > +              /*
> > +               * The simple malloc has a no-op free(): keep one
> > +               * buffer and reuse it. The entries are re-read on
> > +               * every call, so the buffer is device- and LBA-agnostic.
> > +               */
> > +              static gpt_entry *cache;
> > +              static size_t cache_size;
> > +
> > +              if (cache && cache_size =3D=3D size) {
> > +                      pte =3D cache;
> > +              } else {
> > +                      pte =3D memalign(ARCH_DMA_MINALIGN, size);
> > +                      cache =3D pte;
> > +                      cache_size =3D size;
> > +              }
> > +      } else {
> > +              pte =3D memalign(ARCH_DMA_MINALIGN, size);
> >        }
> > =20
> >        if (count =3D=3D 0 || pte =3D=3D NULL) {
>=20
> This doesn't seem identical in the non-SPL case, since now pte is always
> assigned. Or am I missing something?
>=20
I did overlook the count=3D=3D0 case, will fix that.

=2D-=20
Beno=C3=AEt


