Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C62606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TJ4Pm818;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=cumPX4EE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BBA080B5F;
	Thu,  5 Nov 2026 06:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0tyjd8_1eLx; Thu,  5 Nov 2026 06:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA0308108C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793860567;
	b=nhiIQbJTMiGYGxk4Djv6mXB/DQ7HSWIWQfRHe4VJ1IERl+7zsLXx6y8d4jHqoFJD5dRj
	 RN1S7NfiduVQIxErvTQjrJDCgf6vZUl4ozVG1fGxq7IoDGL4Wwj5VSUw4B9GICqaLR73M
	 y+krIRqt6ppxwH4rWIx8O/8FwVIHVx50DuaIkdJsP46dsvdE89W0rE4egJ/e1GFcU6ews
	 ughSIomCl5or52C+tc0lsH6zOe8ClOkWR8aJMFVX7Q5YK9h+OxXs+AFzcFcf+0mygPyKK
	 UxmqWz4OfIiRjnPfkWDWs7bjY7Fk7dOZhZrtfQ2uRPjK3j4ooESJWfQsG4lAwPXzrjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793860567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L3XLL5NzLtiQKykL1ARAr1A92+J4mjzSIsygoW61+Nk=;
	b=jd+Qn0kePVg78njc3uQd8ZoZqwYXbAm6BGKQSFlfJfHVMbG8wUWqKjmispFmxnDicwFx
	 BXEnSWzJNWSqLW5RSOAESD4qLoeX/aiJsTr021uJx4hb3b6WhiSGla0GmYigxcXhsE/Ci
	 zULjUefJqkS/f275nPvQ2KoJoTOzfqt6+UK1yWzF/OXHeFrHqk+jgYCKAHvwg241g1VxX
	 xOjq03Q3gf1Xjxq+X9W77Pv1gPznctuq0Y2aS3QvRbqjdsB5RR4qPArWv8ENAE5ssoTA4
	 EIL/C7vVZmB4tZbUmjLFES3X+AjvPDYpQ3uuPeuCZhAsnqSqEBSJXnfG/2BPSPaul4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793860566;
	bh=L3XLL5NzLtiQKykL1ARAr1A92+J4mjzSIsygoW61+Nk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJ4Pm818eLNGJpq0nub1bwLbEEqAYerRrI+71AcBmsHWYfVN3snQAQKqKOD/SrPDa
	 7xGzWyvNFmM2ZtYllqmCCuwXcfV2jmBZvyIvIfqrVTytYqjMIUdS/3v1NGzEbI5XXG
	 iIs8ESrLI5cxvdsX+9Jt6W4S9RpfYy3cH0cftw9lIJAw0KEkixGqmFMqqvaj2gya+V
	 liCqjGJ11Vvlz7VG8Cw3aInUKClcokBWAGTBXF8t/2QnU94y8cJFzlrO3lZrThnfgP
	 v12I23Na0Kv99bT7AJV3sPayTB+5EgfY5mMZ+UMeiq9OvVYW8u0nlVgvODc7WUYhup
	 g/XNyxP6esx+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA0308108C;
	Thu,  5 Nov 2026 06:36:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7203D362
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58181606F7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UayAJ_Zv3R_w for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 06:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A2A1606E1
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c32:0:1:45:d181:d504"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c32:0:1:45:d181:d504; helo=forward504e.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=cumPX4EE
Received: from forward504e.mail.yandex.net (forward504e.mail.yandex.net
 [IPv6:2a02:6b8:c32:0:1:45:d181:d504])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A2A1606E1
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:36:02 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-69
 (mail-nwsmtp-smtp-production-main-69.yp-c.yandex.net)
 by forward504e.mail.yandex.net (postfix) with ESMTPS id 3B744C028C;
 Thu, 05 Nov 2026 09:35:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69 with ESMTPSA id
 tZG0d14kXmI0-p61TcPyy; Thu, 05 Nov 2026 09:35:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793860557; bh=L3XLL5NzLtiQKykL1ARAr1A92+J4mjzSIsygoW61+Nk=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=cumPX4EE++gAp9zXfbJG3HFh6Q07kMYf+3tgZUmMClXhox6xJNe3P0s4aGlpw/fCs
 e2EkzUvV8vl9F4jRo/bOLCCIKE7wV6oJZxNO43xj0Axr1WnIz3umrSH1dyy1xvhnnn
 RiDzxv58RZz/SMLRu4wNCufKZIrCQLKFk/acnB8E=
Authentication-Results: mail-nwsmtp-smtp-production-main-69;
 dkim=pass header.i=@maquefel.me
Message-ID: <894ccf3ae2bdbe028e9e713e3d85bd2ce5fc73a7.camel@maquefel.me>
Subject: Re: [PATCH v3 0/6] RISC-V SPL: fix OpenSBI FULL FIT loading
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Daniel
 Golle <daniel@makrotopia.org>, James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen	 <aristo.chen@canonical.com>, Francesco Valla
 <francesco@valla.it>, Anton Ivanov	 <anton@binarly.io>
Date: Thu, 05 Nov 2026 09:35:56 +0300
In-Reply-To: <2a033193bc154d857ff569a4da5798c34751b5cd.camel@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
 <CAFLszTgi+QPnkB8i8eL1x7FY57TvD799RcL+kZdiwN38QSrJzA@mail.gmail.com>
 <2a033193bc154d857ff569a4da5798c34751b5cd.camel@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Thanks for testing this. You're right, the FDT is written in place
inside the FIT when it has no load address, so this needs fixing in
this series rather than in a follow-up.

Please don't apply v3, I'll send v4 which copies the FDT to its own
area before recording the loadables and adds that case to the test.

I'll also reword the 4/6 commit message as E Shattow suggested.

On Thu, 2026-11-05 at 09:11 +0300, Nikita Shubin wrote:
> Hi Simon,
>=20
> On Tue, 2026-11-03 at 07:49 -0800, Simon Glass wrote:
> > Hi Nikita,
> >=20
> > On 2026-11-03T09:53:01+11:00, Nikita Shubin
> > <nikita.shubin@maquefel.me> wrote:
> >=20
> > > Tested with provided sandbox test with a grafted FIT image
> > > containing OpenSBI (firmware), U-Boot (loadable) and a DTB.
> >=20
> > One thing I'd like to check.. the new test gives the FDT image a
> > load
> > address, but the in-tree RISC-V FIT in arch/riscv/dts/binman.dtsi
> > does
> > not, so the test misses the layout this series is aimed at.
> >=20
> > Without a load address, fit_image_load() leaves the FDT inside the
> > FIT, or copies it to a buffer of exactly its own length if it is
> > not
> > 8-byte aligned. Patch 5 then adds 8K to the FDT's total size and
> > writes the fit-images nodes into it.
> >=20
> > I tried both cases by dropping the load address from a scratch copy
> > of
> > your test, with two loadables. With an aligned FDT, the nodes
> > overwrite the FIT that follows, so fit_conf_get_node() on 'config-
> > 1'
> > fails after the load. With a misaligned FDT, the total size ends up
> > at
> > about 10K and the nodes go past the end of the small buffer. The
> > test
> > still passes as is, since neither problem shows up when the FDT has
> > its own load address.
> >=20
> > Really you should copy the FDT somewhere with enough space before
> > recording the loadables, and add this case to the test.
> > spl_load_simple_fit() avoids this by loading the FDT to its own
> > area.
> > Perhap a follow-up?
>=20
> Noted. I'll investigate this.
>=20
> >=20
> > > This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V,
> > > primarily to enable loading OpenSBI as firmware and recording
> > > loadable images (e.g., U-Boot) into the FDT passed to the next
> > > boot
> > > stage.
> >=20
> > Just to note that this still reads as though the aim is OpenSBI and
> > loadables, which the simple path already handles. Patch 2 now gives
> > the real reason (CONFIG_SPL_FIT_FULL_CHECK) but this isn't worth a
> > new
> > version.
> >=20
> > Regards,
> > Simon
