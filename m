Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CB0606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V5teMmqv;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=l/k5jdtY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E9B060768;
	Thu,  5 Nov 2026 06:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DO0r3tXo7JG; Thu,  5 Nov 2026 06:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29011606F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793859009;
	b=QWBEzUiM4IzhqftZI9W1eji4miu3UrzExYDmii6L3Www+CusI6ZmsLea7VnsfcrGQs5x
	 1sGbviRnW3I4h2XRD4VtMnN7PSFDU9xaaNW6hQ9mnTGlV5F9PArCVtfiNeLcxSQnyjKEi
	 06WCXm7xt5FvFriofmzJX5dxh48yU2GHz59gIB0DOeccICpI7ssEAKaF97eGge0ZSSETr
	 D/Jz616RaBM+RPrYd+7JD4OOo4cFbXp13QdlL2SuVovrGW6xc844KBAZQ53BOgMaZNqGX
	 FjxRW4yqTtmDVznZ13KBdMYUHldUjLJxnYrZLlsZ0JV2btHiIUUxZ47BaCVr+xXg8oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793859009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v8GhzB3aEGO/A8LdWKyPlnIAFSkJowStONVxchlTZgg=;
	b=AKxZuSYa8kyVGCJ6Uy02rGngTO9pvVkav3LA8EEiL869Rdz8sBd84kHq1xoCXYOHFBG0
	 F2SgBm6/z70iXgReTbWry9slkwChHTkAYXLUFj3KK5LLnGulnsMHjOFZphikEd8UUaSnw
	 1zWPsHkDAF6vcnCRF6k8Dsp+LnwxXLMzKBcugqOLpig5OyhwcDXTbFZgifRdT7lX5r14B
	 kfa4tGf7demj+CLBrHR+je3LUZYRJv5Xg7ae6p0hgUlXC4l9Rls2vWND7uJvYtxqUpXEs
	 QVxhEf/P0ZBFv6o8p0pua6Drey04ZWsWKQGFOETlIDjHZ8r8moUshbTCJwVBEsNeeyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793859009;
	bh=v8GhzB3aEGO/A8LdWKyPlnIAFSkJowStONVxchlTZgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V5teMmqvCxuTyv9qt4yaUaDdCE0k3NXVxnGbV8DjDdMDPO8lSM41zYJRS003KZk6u
	 FnKbCeWUUxDt2nB84HOJ7YwbCrTNvfLVVgLYW7bDMI7/xJpyVN8wkSOkFhNL3fsFIM
	 Evs3P3i06qLUXFDm1kY11gACC/LN/FH/GGcUt3PTtIr4IgjviLNUiyGNQ0Tsd3Gw7N
	 WqqdBglM0b8KueRZN6aarkz9Hd8+hmzkBvHnJaqgOXeNbXgLAEdHP9NzstfaWQ9Lkx
	 BsrEDUpSWynlnmancOV2cpZ2obbBbD7orjtW6vLqGf/SyazrXPnDdDh9+/wA1pS9PP
	 KPw6dOepDp4kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29011606F7;
	Thu,  5 Nov 2026 06:10:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37C761779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23649400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e2FWo2WVSL9f for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 06:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 63F9440076
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d503"
X-Greylist: delayed 159384 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 05 Nov 2026 06:10:02 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=l/k5jdtY
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c41:1300:1:45:d181:d503; helo=forward503d.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Received: from forward503d.mail.yandex.net (forward503d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d503])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63F9440076
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:10:01 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-84
 (mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net)
 by forward503d.mail.yandex.net (postfix) with ESMTPS id A00251000C5;
 Thu, 05 Nov 2026 09:09:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84 with ESMTPSA id
 s9GS4RmeXqM0-JX5JCcX2; Thu, 05 Nov 2026 09:09:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793858996; bh=v8GhzB3aEGO/A8LdWKyPlnIAFSkJowStONVxchlTZgg=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=l/k5jdtYKBGvjkxNat0LIOBXFkjbXfPbvOmV/6I4xrDJW5jMr8RgdQGJ4EMx5q/2x
 L1bfneRVvcw5zaifmeZBYv2WzkRT9kVQt6ldHJT14geHyYdT35+tCuLYLY1A9ktmvi
 57LIpobKom64wRbOuWZfM/eBFZN0nIyp+qTp0rEw=
Authentication-Results: mail-nwsmtp-smtp-production-main-84;
 dkim=pass header.i=@maquefel.me
Message-ID: <81a131b11b292f8be61e1a756a2f03e28816cc4f.camel@maquefel.me>
Subject: Re: [PATCH v3 4/6] test: spl: Zero spl_image_info
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: E Shattow <e@freeshell.de>, u-boot@lists.u-boot-project.org, Simon Glass
 <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Aristo Chen
 <aristo.chen@canonical.com>, Francesco Valla	 <francesco@valla.it>, Anton
 Ivanov <anton@binarly.io>
Date: Thu, 05 Nov 2026 09:09:54 +0300
In-Reply-To: <5b2c35e1-8dff-44fa-9f3b-81f0fca530b5@freeshell.de>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
 <20261103-riscv-full-fit-support-v3-4-e1dcdc9638e5@maquefel.me>
 <5b2c35e1-8dff-44fa-9f3b-81f0fca530b5@freeshell.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 2026-11-03 at 08:41 -0800, E Shattow wrote:
> Hi Nikita,
>=20
> On 11/3/26 01:53, Nikita Shubin wrote:
> > The next patch makes spl_load_fit_image() check spl_image->fdt_addr
> > and
>=20
> What is "The next patch" is it this patch? or the next one that is
> not
> this one... confusing. The whole description could instead be
> "Zero-initialize spl_image_info on the stack in preparation for any
> writes to spl_image->fdt_addr" or however this is.

Simon please advise, should i roll v4 ?

>=20
> The "next" patch will appear in git history and explain further.
>=20
> > write the loadables into that FDT. With an uninitialised
> > spl_image_info
> > on the stack this could end up writing to a random address.
> >=20
> > Use memset() to make sure spl_image_info is initialised before
> > passing
> > it, as board_init_r() does.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0test/image/spl_load_os.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
> > index ba9d7979a09..e2b55d66394 100644
> > --- a/test/image/spl_load_os.c
> > +++ b/test/image/spl_load_os.c
> > @@ -15,6 +15,7 @@ static int spl_test_load(struct unit_test_state
> > *uts)
> > =C2=A0	struct spl_image_info image;
> > =C2=A0	char fname[256];
> > =C2=A0
> > +	memset(&image, 0, sizeof(image));
> > =C2=A0	ut_assertok(sandbox_spl_load_fit(fname, sizeof(fname),
> > &image));
> > =C2=A0
> > =C2=A0	return 0;
> > @@ -26,6 +27,7 @@ static int spl_test_load_fit_full(struct
> > unit_test_state *uts)
> > =C2=A0	struct spl_image_info image;
> > =C2=A0	char fname[256];
> > =C2=A0
> > +	memset(&image, 0, sizeof(image));
> > =C2=A0	ut_assertok(sandbox_spl_load_fit_full(fname,
> > sizeof(fname), &image));
> > =C2=A0
> > =C2=A0	return 0;
> >=20
>=20
> -E
