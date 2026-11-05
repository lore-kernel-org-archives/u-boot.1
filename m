Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CB606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=blApVbmN;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=qxAW1VQ+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D45881094;
	Thu,  5 Nov 2026 06:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynfkv0RcXxLN; Thu,  5 Nov 2026 06:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 611C481083
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793859119;
	b=HK5tI25LVeJAwgju152kp45MOmN3GrCDN+QCopdUw531dphsm6JeJNDHch9lSFG63sUw
	 9gCxN1Bm7oPNVR6qminaKnTbjqpIPc0qAlLmfEVK14yWx7GzgsXyQD9UhEkGVuwuNtJUO
	 br7ypuNB8+zNc/BCjiEF/oxl0cflAhMO24SITFDA5ezdaiZ1g9Fepq7y1x1MQRt6HFxvt
	 kwQKdAnxTgEgZciyHYw2KFqTnTxzA3/uMipUQisxOgWpOO7v9KJo/Ab9wL6eYfeNPo1Ca
	 mtapbVGZx1YxiGTDl6LdfmkzeZL5mueXYfNk0J+WZCEltmXjU+J8JGrkMSgkIS6Bpfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793859119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VBU1jbJCgWJznycyA8UiKrRsegpj0Qqb5STOtppxE6o=;
	b=ZvtbKmqLqmXVlshc6Z4pQed7uftQiND9wN08b560Muz1SbvfZrX1l+5x3izMjY3/8Maa
	 yO4/aRnCJTMiapEYYgD3/yiUrLmTuYIG/EfnWWn4SGMpPeltynx6sTP+D73O0t8XXAZ3R
	 cMgWSk4Z78od3oRCyrhDKeWi4C2bojrZ2Yy0BPlXOgewBqvQ6iDmT2HniyKGySozzZpsB
	 H6/xk/ToHv7ugqlth0lEHiH/fBkjoht+DqJLUB+rByopHf/JLhRsctxTcOrEm1a/tUyYd
	 6uxGy23sKRaK/O6249QyNN3eGdTtLYrnWSUHbTQJ0gNEa+YtOxzz+RQyVvq6k6CgEmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793859119;
	bh=VBU1jbJCgWJznycyA8UiKrRsegpj0Qqb5STOtppxE6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blApVbmN+VsjrlEDDvFoERNyXG+jueIzHCUZ58jseJJMXsEM6czDFs4Yff1kfJyJL
	 yO5vUdPntDQXpfAX30PCCfAZNveTxAt5eCUT8Y1o7lKp0liiuePoBzn6ccWtone5tW
	 Q0o5PBCpC8Di/pi7ClMuyFjjizAnOT8UJ8eHEfvWFwpRtDRGCmqa471lv85pQWrOoY
	 pmgydA/6A5M4gnFpUFGZogHWRGY7Rz0xjyZA6wrL4afC2Iozs/u+tHqoTTr4Sbz0Fe
	 HsJkMIAzA9emfvYt0uyY5fNoidPZSmE/N0a0DBIxZq3GQHDrSYVe/WCg12oFD+xNoy
	 ZXOcg5kkumIPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 611C481083;
	Thu,  5 Nov 2026 06:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65121B00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5532D60768
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sp8j0vayhAjy for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 06:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22426606D3
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c41:1300:1:45:d181:d500"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c41:1300:1:45:d181:d500; helo=forward500d.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=qxAW1VQ+
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d500])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22426606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:11:56 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-97
 (mail-nwsmtp-smtp-production-main-97.yp-c.yandex.net)
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 9FC6681CFF;
 Thu, 05 Nov 2026 09:11:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-97 with ESMTPSA id
 lBG8TTmgS4Y0-Ch90ppbd; Thu, 05 Nov 2026 09:11:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793859109; bh=VBU1jbJCgWJznycyA8UiKrRsegpj0Qqb5STOtppxE6o=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=qxAW1VQ+aNyPi2Yafi50+gIjDKyUueXeOAzcUXC0DfZrD5hXIxxopvpCNFGIxaktH
 /11haP3F+xYGGgxSaOseeFWEES36yaEvmfvaCsexELewxBObWZGht0LTsAxpTvngPg
 950MJXJqv2pUNhrebGONOUykY32dCMV2sDBIQMBU=
Authentication-Results: mail-nwsmtp-smtp-production-main-97;
 dkim=pass header.i=@maquefel.me
Message-ID: <2a033193bc154d857ff569a4da5798c34751b5cd.camel@maquefel.me>
Subject: Re: [PATCH v3 0/6] RISC-V SPL: fix OpenSBI FULL FIT loading
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Daniel
 Golle <daniel@makrotopia.org>, James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen	 <aristo.chen@canonical.com>, Francesco Valla
 <francesco@valla.it>, Anton Ivanov	 <anton@binarly.io>
Date: Thu, 05 Nov 2026 09:11:47 +0300
In-Reply-To: <CAFLszTgi+QPnkB8i8eL1x7FY57TvD799RcL+kZdiwN38QSrJzA@mail.gmail.com>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
 <CAFLszTgi+QPnkB8i8eL1x7FY57TvD799RcL+kZdiwN38QSrJzA@mail.gmail.com>
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

On Tue, 2026-11-03 at 07:49 -0800, Simon Glass wrote:
> Hi Nikita,
>=20
> On 2026-11-03T09:53:01+11:00, Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
>=20
> > Tested with provided sandbox test with a grafted FIT image
> > containing OpenSBI (firmware), U-Boot (loadable) and a DTB.
>=20
> One thing I'd like to check.. the new test gives the FDT image a load
> address, but the in-tree RISC-V FIT in arch/riscv/dts/binman.dtsi
> does
> not, so the test misses the layout this series is aimed at.
>=20
> Without a load address, fit_image_load() leaves the FDT inside the
> FIT, or copies it to a buffer of exactly its own length if it is not
> 8-byte aligned. Patch 5 then adds 8K to the FDT's total size and
> writes the fit-images nodes into it.
>=20
> I tried both cases by dropping the load address from a scratch copy
> of
> your test, with two loadables. With an aligned FDT, the nodes
> overwrite the FIT that follows, so fit_conf_get_node() on 'config-1'
> fails after the load. With a misaligned FDT, the total size ends up
> at
> about 10K and the nodes go past the end of the small buffer. The test
> still passes as is, since neither problem shows up when the FDT has
> its own load address.
>=20
> Really you should copy the FDT somewhere with enough space before
> recording the loadables, and add this case to the test.
> spl_load_simple_fit() avoids this by loading the FDT to its own area.
> Perhap a follow-up?

Noted. I'll investigate this.

>=20
> > This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V,
> > primarily to enable loading OpenSBI as firmware and recording
> > loadable images (e.g., U-Boot) into the FDT passed to the next boot
> > stage.
>=20
> Just to note that this still reads as though the aim is OpenSBI and
> loadables, which the simple path already handles. Patch 2 now gives
> the real reason (CONFIG_SPL_FIT_FULL_CHECK) but this isn't worth a
> new
> version.
>=20
> Regards,
> Simon
