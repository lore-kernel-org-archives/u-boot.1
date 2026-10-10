Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DDDCA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 20:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0F6E60643;
	Sat, 10 Oct 2026 20:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ms2TR_u1ooHh; Sat, 10 Oct 2026 20:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71E2B60622
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791662481;
	b=LbbRMOfQl6wK1TaKb3ZPk6m5naBiVIff8wd0I6qZ4rXJgHEtPc19EGEjiS0e2C2H118S
	 tgx6/CqLl9pkLvq0I/nJYrPfe9PEFTmTbGVUF839QfZwHiLFsPfpn4bs4vsT95LzVANV+
	 SLfBHXra5UXMv2bE/wSDou5d96+IY0pFkyd2yfCMQOKto4aGCqAqucPhHP7DxrRurtUpj
	 fwG/qKNR5xs4M0VjHK67hSPYW30QvFSZyZOXdu9OqHJbBWGVb11wMxNSsoxxMtG6OHIp/
	 oAA0ko1SOFfZmXBswL05tMpA+GRnDStF8fl4U0pVTRlKYPJPIqxZc5jIsMX+A2xRO5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791662481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a/g4jiDwfskv7oSg5X07IeRMD98Ma/cU0SAJBNCBuDQ=;
	b=q+GheVGwyfLICT/t0w8os2CIC1XNF72e6FZlp4sT2B795q76yjyo5+kDEu9vRFjJRwWM
	 lbTeNsjaQdGkz2JUZUeQyyG3yUcXB29GEQFCqSZ/8KDUEkInbk0d4fsOElpms0MP4b/kR
	 ClDkParKuJJBBKB046Zxfv3Y8sL7XjP1Sy+ctlz+440YA0t+QMXJiY+dMsFaR27cA9qKH
	 VWqfShT9s3VmmlsYYaeeatuLDLvZfyfFScN9ktXI5WimRjydyAaGBIRi0+mjZ3/GB19Dp
	 WpiSY7vLnrQD/38k6MtAMTT9TPGZWyok4m48qQ+OCYGcOXCzeC4L+3n0T6+fuVXp/Iw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791662481;
	bh=a/g4jiDwfskv7oSg5X07IeRMD98Ma/cU0SAJBNCBuDQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PM+z8S/axBtxZ8LsdmoQ7BdikiHLjmoV/9xbl/KVtDXciv99r0uPyS2Gn8DzAh/CL
	 Qqe4t5+MqMpFHc5qTgIiteaD5TjuMDUnyGa+Cag0wOxZgWNNgctEKjJj1ltW5rRuYT
	 uvPXkEW+nNmwxRU7yx3tRpocRQv9IDq1MbBkQY9ZyWy1XllE4rhIilnTd3ODx+OqKa
	 YzS1QKAKv0oabXuot8KaGDC86sfJmSRYlyATuoGz89Z/m/zp5fNl2kOlKAx6gTWSxu
	 2OsnqMVL3U1BQhKoTgZ0+xSSr2jyg+0IrC/Z7XgCLD/xnWWIUiyNZMCCWoMjj36gWX
	 O9FJEytpT5MYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71E2B60622;
	Sat, 10 Oct 2026 20:01:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4276E105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 20:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 043A340068
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 20:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McQZS2JlqMJD for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 20:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C7D240004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=74.208.4.197
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791662478;
 b=HXe2JBJhBtPb7fcKKQ1oYl2FAhrsMll01T/77wd1f4ooN4Z1z1qquEvioS2+53buABg5
 3MI3uA16tRSpuxSbJbXrvpnIphqg6gAa4Bwgtk2TgQzadvnoS3ujvya5VhpM568K+SOkL
 /OuFQr9C822TMV05+tF824F9Dn+S3k3Uuigy1sAr3XbahBLJDOLVBAEYkklvM+U8gQZq1
 fEcOEkY/3vAWhIYyt+fvDokRtLFTFgqrzddzbXLJZDxyxfjiw7SUQDSVx0KN2RU7ZTpiK
 jpDrGOb61RnFP8kYnVzzRV/Ey5BatK+HP5+LTQhGoQwBQ9+9lfYx8JsM5s7F6ozwLFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791662478;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version:
 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=a/g4jiDwfskv7oSg5X07IeRMD98Ma/cU0SAJBNCBuDQ=;
 b=GqdyirbzOiRwoSg1Homa4wQ2lz0D7/P3+6hvrkXz0sZKSX1D4Xko5nMLynZwVWKaKV0O
 TESttFpDPFR4jhniXixM20oY5Rj72YdTP4seZ9U7gJZWRwzOd2rzxaWLMPO8PBC9jha7u
 6byf7MyAMJl4DLBYKf5eeh6CsrWMmhC5TgY+KQxRYXVzEyEhCRpf78GY0ybtQ7FBXmsfv
 KyEWcvKD9d28rXWMCvBjga6HNZ3xQcfZ+5k5C0+J99Fq57Y4WEMJvqZ4AwDlGSeJ2DDtK
 phag3XGK0HJuKQfhtdOJDBkCXxzJy2JKzWUUWI4oFulnpCHjbPusELgIFolA0pttlBw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=ziswiler.com;
 dkim=pass header.d=ziswiler.com header.i=marcel@ziswiler.com
 header.a=rsa-sha256 header.s=s1-ionos header.b=tU5N16M7; 
 arc=none smtp.remote-ip=74.208.4.197
X-Greylist: delayed 324 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 10 Oct 2026 20:01:18 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=ziswiler.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com
 header.a=rsa-sha256 header.s=s1-ionos header.b=tU5N16M7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.208.4.197;
 helo=mout.perfora.net; envelope-from=marcel@ziswiler.com; receiver=<UNKNOWN> 
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C7D240004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1791662476; x=1792267276; i=marcel@ziswiler.com;
 bh=a/g4jiDwfskv7oSg5X07IeRMD98Ma/cU0SAJBNCBuDQ=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tU5N16M71tAoSwrcRRemt3QkxmiCMS6LC+PHpdzIUIUhaBkepKz0GNERZoGUVHau
 ic7NIDwwhKJV2b53s6TfkKbp/U3oSaSMTD3dGIjTKSpB3w9Vx5xmLV7tqpXGYqZhV
 07i3OOXX3jfcv4/5dxvqlhiSVo2QQRk+tLXU/Hx0W611E71VFN514i+30PMPqovsT
 gPIApq+n59xkU26SVuQJrIKQhTkyAhsHtUtrN13AzDTyshIq91KKg30JgGjgmh39C
 /Jskj5aBHZohoqQA7y7MFwYtnTXBgtv/6pM+JDLrRRFmUCHQ2Ac000NWzg4x0/yYK
 tMtu6SfC0Q4CMvTPhw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelay.perfora.net (mreueus002
 [74.208.114.78]) with ESMTPSA (Nemesis) id 0MTjFe-1x6w0L1xxo-00LSnD; Sat, 10
 Oct 2026 21:55:42 +0200
Message-ID: <f9aa30050d6700625bcd0ca9c54bfe2ceabe3572.camel@ziswiler.com>
Subject: [REGRESSION] Re: [PATCH v4 3/4] spl: fit: Harden external-data
 offset and size arithmetic
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Anton Ivanov <anton@binarly.io>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, James
 Hilliard	 <james.hilliard1@gmail.com>, Aristo Chen
 <aristo.chen@canonical.com>,  Francesco Valla <francesco@valla.it>, Anshul
 Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>, Binarly Research	
 <vr@binarly.io>
Date: Sat, 10 Oct 2026 21:55:31 +0200
In-Reply-To: <20260902-b4-fit-ext-data-hardening-v4-3-a884a5de96ea__14255.2231832937$1788386356$gmane$org@binarly.io>
References: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
 <20260902-b4-fit-ext-data-hardening-v4-3-a884a5de96ea__14255.2231832937$1788386356$gmane$org@binarly.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:jyapPE5uZw93nsGgiTb2d+zorDYDE9mAnoTOi5dPK2CbfXVH0xX
 IluIHFaLT+19Ua1RbU6LFkYwHIGvoUPGgoyPJdiQBAK7rr1B0N+oJS8nHevQ7ORjbdHsga0
 B7En8HA4qYCAx4a6zHoM0VoGUaKkmT876PJwMYTZQ2BTASnISpCdvsAF5HoAk9GXL0ezKJj
 cqTJpu47SOx/KXiG84+3g==
UI-OutboundReport: notjunk:1;M01:P0:lRAtkKzPxNQ=;Ri6Hy3COnUqgU3zxGJbgylcxcjq
 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
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

Hi Anton, et. al.

On Wed, 2026-09-02 at 22:23 +0100, Anton Ivanov wrote:
> The data-offset, data-position and data-size FIT properties are
> excluded from the configuration signature, so they are attacker
> controlled even when signature verification succeeds. The offset and
> size arithmetic in load_simple_fit() can wrap on hostile values:
>=20
> =C2=A0- adding the external-data base offset to data-offset can wrap past
> =C2=A0=C2=A0 UINT32_MAX,
> =C2=A0- get_aligned_image_size() adds the block-alignment overhead and
> =C2=A0=C2=A0 rounds up to the block length, which can wrap past ULONG_MAX=
,
> =C2=A0- adding the FIT's device offset to the aligned external-data offse=
t
> =C2=A0=C2=A0 can wrap past ULONG_MAX.
>=20
> Make get_aligned_image_size() return the aligned size through an out
> parameter and fail with -EOVERFLOW when the computation would wrap,
> check the two offset additions explicitly, and compare the
> block-aligned size (the amount info->read() actually transfers)
> against max_size before reading. Do the same for the FIT header read
> in spl_simple_fit_read().

I bisected this commit to regress on the LicheePi 4A in the sense that the =
SPL is no longer able to
load/execute OpenSBI/U-Boot proper:

U-Boot SPL 2026.10 (Oct 10 2026 - 21:45:55 +0200)
Trying to boot from RAM
=3D> hangs

My fix reverting this and a second patch [1] got accepted in meta-riscv, se=
e:

https://github.com/riscv/meta-riscv/pull/711

Before I dig deeper, I would welcome any insight anybody could have. Thanks=
!

Cheers

Marcel

[1] https://lore.kernel.org/all/20260421075439.16696-6-ravi@prevas.dk

> Signed-off-by: Anton Ivanov <anton@binarly.io>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> ---
> Changed since v3: the new diagnostics use log_debug() instead of
> printf(), which compiles out in a non-debug SPL build.
>=20
> Code size, from buildman -S in the u-boot-gitlab-ci-runner container
> (gcc 14.2.0). The 413 boards that build spl_fit.c cover seven
> combinations of CONFIG_SPL_LOAD_BLOCK (BLK), CONFIG_SPL_FIT_SIGNATURE
> (SIG) and bitness, one board each below. SPL only; U-Boot proper is
> unchanged:
>=20
> =C2=A0 BLK SIG bit=C2=A0 board=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 text=C2=A0 rodata=C2=A0 data=C2=A0=C2=A0=C2=A0 all
> =C2=A0=C2=A0 y=C2=A0=C2=A0 n=C2=A0=C2=A0 32=C2=A0 am335x_evm=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +24=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0 -4=C2=A0=
=C2=A0=C2=A0 -29
> =C2=A0=C2=A0 y=C2=A0=C2=A0 y=C2=A0=C2=A0 32=C2=A0 firefly-rk3288=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +20=
=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 -2=
9
> =C2=A0=C2=A0 n=C2=A0=C2=A0 n=C2=A0=C2=A0 32=C2=A0 am335x_evm_spiboot=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +4=C2=A0=C2=A0=C2=
=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 -45
> =C2=A0=C2=A0 n=C2=A0=C2=A0 y=C2=A0=C2=A0 32=C2=A0 evb-ast2600=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -8=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=
=A0=C2=A0=C2=A0 -57
> =C2=A0=C2=A0 y=C2=A0=C2=A0 n=C2=A0=C2=A0 64=C2=A0 imx8mm_evk=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 +16=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=
=C2=A0=C2=A0=C2=A0 -33
> =C2=A0=C2=A0 y=C2=A0=C2=A0 y=C2=A0=C2=A0 64=C2=A0 orangepi-5-ultra-rk3588=
=C2=A0=C2=A0=C2=A0=C2=A0 +28=C2=A0=C2=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 -21
> =C2=A0=C2=A0 n=C2=A0=C2=A0 n=C2=A0=C2=A0 64=C2=A0 r8a779g0_whitehawk=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0 -49=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 -49
>=20
> The rodata drop is the "FIT image too large" printf() this patch
> removes.
> ---
> =C2=A0common/spl/spl_fit.c=C2=A0 | 98 +++++++++++++++++++++++++++++------=
----------------
> =C2=A0test/image/spl_load.c | 57 ++++++++++++++++++++++++++++++
> =C2=A02 files changed, 112 insertions(+), 43 deletions(-)
>=20
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 9b16f91cc6f..65934674b6c 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -175,22 +175,32 @@ static int spl_fit_get_image_node(const struct spl_=
fit_info *ctx,
> =C2=A0	return node;
> =C2=A0}
> =C2=A0
> -static int get_aligned_image_offset(struct spl_load_info *info, int offs=
et)
> +static u32 get_aligned_image_offset(struct spl_load_info *info, u32 offs=
et)
> =C2=A0{
> =C2=A0	return ALIGN_DOWN(offset, spl_get_bl_len(info));
> =C2=A0}
> =C2=A0
> -static int get_aligned_image_overhead(struct spl_load_info *info, int of=
fset)
> +static u32 get_aligned_image_overhead(struct spl_load_info *info, u32 of=
fset)
> =C2=A0{
> =C2=A0	return offset & (spl_get_bl_len(info) - 1);
> =C2=A0}
> =C2=A0
> -static int get_aligned_image_size(struct spl_load_info *info, int data_s=
ize,
> -				=C2=A0 int offset)
> +static int get_aligned_image_size(struct spl_load_info *info, ulong data=
_size,
> +				=C2=A0 u32 offset, ulong *aligned_size)
> =C2=A0{
> -	data_size =3D data_size + get_aligned_image_overhead(info, offset);
> +	u32 overhead =3D get_aligned_image_overhead(info, offset);
> =C2=A0
> -	return ALIGN(data_size, spl_get_bl_len(info));
> +	if (data_size > ULONG_MAX - overhead)
> +		return -EOVERFLOW;
> +	data_size +=3D overhead;
> +
> +	if (data_size > ULONG_MAX - (spl_get_bl_len(info) - 1))
> +		return -EOVERFLOW;
> +	data_size =3D ALIGN(data_size, spl_get_bl_len(info));
> +
> +	*aligned_size =3D data_size;
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -223,17 +233,16 @@ static int load_simple_fit(struct spl_load_info *in=
fo, ulong fit_offset,
> =C2=A0	ulong load_addr;
> =C2=A0	void *load_ptr;
> =C2=A0	void *src;
> -	ulong overhead;
> =C2=A0	uint8_t image_comp =3D -1, type =3D -1;
> =C2=A0	const void *data;
> =C2=A0	const void *fit =3D ctx->fit;
> =C2=A0	bool external_data =3D false;
> +	int ret;
> =C2=A0
> =C2=A0	log_debug("starting\n");
> =C2=A0	if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 xpl_get_phase(info) !=3D IH_PHASE_NONE) {
> =C2=A0		enum image_phase_t phase;
> -		int ret;
> =C2=A0
> =C2=A0		ret =3D fit_image_get_phase(fit, node, &phase);
> =C2=A0		/* if the image is for any phase, let's use it */
> @@ -273,13 +282,19 @@ static int load_simple_fit(struct spl_load_info *in=
fo, ulong fit_offset,
> =C2=A0	if (!fit_image_get_data_position(fit, node, &offset)) {
> =C2=A0		external_data =3D true;
> =C2=A0	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
> -		log_debug("read offset %x =3D offset from fit %lx\n",
> -			=C2=A0 offset, (ulong)offset + ctx->ext_data_offset);
> +		/* The resulting offset cannot exceed UINT32_MAX */
> +		if (ctx->ext_data_offset > UINT32_MAX - offset) {
> +			log_debug("Invalid external data offset: %u\n", offset);
> +			return -EINVAL;
> +		}
> +		log_debug("read offset %x =3D offset from fit %x\n", offset,
> +			=C2=A0 (u32)(offset + ctx->ext_data_offset));
> =C2=A0		offset +=3D ctx->ext_data_offset;
> =C2=A0		external_data =3D true;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (external_data) {
> +		u32 aligned_offset;
> =C2=A0		ulong read_offset;
> =C2=A0		void *src_ptr;
> =C2=A0
> @@ -300,16 +315,26 @@ static int load_simple_fit(struct spl_load_info *in=
fo, ulong fit_offset,
> =C2=A0		 * controlled even after fit_config_verify() succeeds. The
> =C2=A0		 * image hash is only verified after the device read below, so
> =C2=A0		 * an oversized value has to be rejected here.
> -		 *
> -		 * Bail out before get_aligned_image_size() runs on a hostile
> -		 * len: that helper does its arithmetic in int and would
> -		 * invoke signed-integer overflow on a value close to or above
> -		 * INT_MAX. The block-aligned check further down is the
> -		 * mathematically binding one, since size is len rounded up to
> -		 * the device block length.
> =C2=A0		 */
> -		if ((ulong)len > max_size)
> -			goto too_big;
> +		ret =3D get_aligned_image_size(info, len, offset, &size);
> +		if (ret) {
> +			log_debug("Invalid external data size: %u\n", len);
> +			return ret;
> +		}
> +
> +		if (size > max_size) {
> +			log_debug("Image too large: aligned size %lu, max %lu (data-size %u)\=
n",
> +				=C2=A0 size, max_size, len);
> +			return -EFBIG;
> +		}
> +
> +		aligned_offset =3D get_aligned_image_offset(info, offset);
> +		if (aligned_offset > ULONG_MAX - fit_offset) {
> +			log_debug("Invalid aligned external data offset: %u\n",
> +				=C2=A0 aligned_offset);
> +			return -EINVAL;
> +		}
> +		read_offset =3D fit_offset + aligned_offset;
> =C2=A0
> =C2=A0		if (spl_decompression_enabled() &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (image_comp =3D=3D IH_COMP_GZIP || image_comp =
=3D=3D IH_COMP_LZMA))
> @@ -318,19 +343,6 @@ static int load_simple_fit(struct spl_load_info *inf=
o, ulong fit_offset,
> =C2=A0			src_ptr =3D map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len)=
;
> =C2=A0		length =3D len;
> =C2=A0
> -		overhead =3D get_aligned_image_overhead(info, offset);
> -		size =3D get_aligned_image_size(info, length, offset);
> -		read_offset =3D fit_offset + get_aligned_image_offset(info,
> -							=C2=A0=C2=A0=C2=A0 offset);
> -
> -		/*
> -		 * info->read() transfers the block-aligned size into the
> -		 * destination, so this is the bound that actually matters;
> -		 * len was rejected above only to keep this computation safe.
> -		 */
> -		if (size > max_size)
> -			goto too_big;
> -
> =C2=A0		log_debug("reading from offset %x / %lx size %lx to %p: ",
> =C2=A0			=C2=A0 offset, read_offset, size, src_ptr);
> =C2=A0
> @@ -339,7 +351,7 @@ static int load_simple_fit(struct spl_load_info *info=
, ulong fit_offset,
> =C2=A0
> =C2=A0		debug("External data: dst=3D%p, offset=3D%x, size=3D%lx\n",
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src_ptr, offset, (unsigned long)le=
ngth);
> -		src =3D src_ptr + overhead;
> +		src =3D src_ptr + get_aligned_image_overhead(info, offset);
> =C2=A0	} else {
> =C2=A0		/* Embedded data */
> =C2=A0		if (fit_image_get_emb_data(fit, node, &data, &length)) {
> @@ -401,11 +413,6 @@ static int load_simple_fit(struct spl_load_info *inf=
o, ulong fit_offset,
> =C2=A0	upl_add_image(fit, node, load_addr, length);
> =C2=A0
> =C2=A0	return 0;
> -
> -too_big:
> -	printf("%s: FIT image too large (data-size %u, max %lu)\n",
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, (u32)len, max_size);
> -	return -EFBIG;
> =C2=A0}
> =C2=A0
> =C2=A0static bool os_takes_devicetree(uint8_t os)
> @@ -737,8 +744,9 @@ static int spl_simple_fit_read(struct spl_fit_info *c=
tx,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spl_load_info *info,=
 ulong offset,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *fit_header)
> =C2=A0{
> -	unsigned long count, size;
> +	unsigned long aligned_size, count, size;
> =C2=A0	void *buf;
> +	int ret;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * For FIT with external data, figure out where the external image=
s
> @@ -756,8 +764,12 @@ static int spl_simple_fit_read(struct spl_fit_info *=
ctx,
> =C2=A0	 * For FIT with data embedded, data is loaded as part of FIT image=
.
> =C2=A0	 * For FIT with external data, data is not loaded in this step.
> =C2=A0	 */
> -	size =3D get_aligned_image_size(info, size, 0);
> -	buf =3D board_spl_fit_buffer_addr(size, size, 1);
> +	ret =3D get_aligned_image_size(info, size, 0, &aligned_size);
> +	if (ret) {
> +		log_debug("Invalid FIT size: %lu\n", size);
> +		return ret;
> +	}
> +	buf =3D board_spl_fit_buffer_addr(aligned_size, aligned_size, 1);
> =C2=A0	if (!buf) {
> =C2=A0		/*
> =C2=A0		 * We assume that none of the board will ever use 0x0 as a
> @@ -767,7 +779,7 @@ static int spl_simple_fit_read(struct spl_fit_info *c=
tx,
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0
> -	count =3D info->read(info, offset, size, buf);
> +	count =3D info->read(info, offset, aligned_size, buf);
> =C2=A0	if (!count) {
> =C2=A0		/*
> =C2=A0		 * FIT could not be read. This means we should free the
> @@ -800,7 +812,7 @@ static int spl_simple_fit_read(struct spl_fit_info *c=
tx,
> =C2=A0
> =C2=A0	ctx->fit =3D buf;
> =C2=A0	debug("fit read offset %lx, size=3D%lu, dst=3D%p, count=3D%lu\n",
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, size, buf, count);
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, aligned_size, buf, count);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> index 49bfce15c08..557362ba113 100644
> --- a/test/image/spl_load.c
> +++ b/test/image/spl_load.c
> @@ -426,6 +426,63 @@ static int spl_test_fit_external_oversize(struct uni=
t_test_state *uts)
> =C2=A0}
> =C2=A0SPL_TEST(spl_test_fit_external_oversize, 0);
> =C2=A0
> +/*
> + * A data-offset which wraps past UINT32_MAX once the external-data base
> + * offset is added must be rejected before it is used as a read offset.
> + */
> +static int spl_test_fit_data_offset_overflow(struct unit_test_state *uts=
)
> +{
> +	if (!image_supported(FIT_EXTERNAL))
> +		return -EAGAIN;
> +
> +	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0xffffffff, 1,
> +				=C2=A0 spl_test_read, 0, -EINVAL);
> +}
> +SPL_TEST(spl_test_fit_data_offset_overflow, 0);
> +
> +/*
> + * A data-size whose block-aligned read size wraps past ULONG_MAX must b=
e
> + * rejected. Since data-size is a 32-bit property, the wrap is only reac=
hable
> + * when ulong is 32 bits wide, so skip the test on other targets.
> + */
> +static int spl_test_fit_data_size_overflow(struct unit_test_state *uts)
> +{
> +	if (!image_supported(FIT_EXTERNAL) || sizeof(ulong) !=3D 4)
> +		return -EAGAIN;
> +
> +	return check_fit_ext_prop(uts, FIT_DATA_SIZE_PROP, 0xffffffff, 2,
> +				=C2=A0 spl_test_read, 0, -EOVERFLOW);
> +}
> +SPL_TEST(spl_test_fit_data_size_overflow, 0);
> +
> +/* Device offset the reader pretends the FIT was loaded from */
> +static ulong spl_test_fit_offset;
> +
> +static ulong spl_test_read_fit_offset(struct spl_load_info *load, ulong =
sector,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ulong count, void *buf)
> +{
> +	return spl_test_read(load, sector - spl_test_fit_offset, count, buf);
> +}
> +
> +/*
> + * An aligned external-data offset which wraps past ULONG_MAX once the F=
IT's
> + * offset on the device is added must be rejected before it is used as a=
 read
> + * offset.
> + */
> +static int spl_test_fit_read_offset_overflow(struct unit_test_state *uts=
)
> +{
> +	if (!image_supported(FIT_EXTERNAL))
> +		return -EAGAIN;
> +
> +	/* So that ULONG_MAX - fit_offset < the aligned external-data offset */
> +	spl_test_fit_offset =3D ULONG_MAX - 0xfff;
> +
> +	return check_fit_ext_prop(uts, FIT_DATA_OFFSET_PROP, 0x1000, 1,
> +				=C2=A0 spl_test_read_fit_offset, spl_test_fit_offset,
> +				=C2=A0 -EINVAL);
> +}
> +SPL_TEST(spl_test_fit_read_offset_overflow, 0);
> +
> =C2=A0/*
> =C2=A0 * LZMA is too complex to generate on the fly, so let's use some da=
ta I put in
> =C2=A0 * the oven^H^H^H^H compressed earlier
