Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E116083611
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I0u4D/Ys;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMyrsVv2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10B1380E2D;
	Tue,  3 Nov 2026 10:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPuyBJF113qN; Tue,  3 Nov 2026 10:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EE1080BC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700592;
	b=BxJyRxIOI6o7DPMLj0B2LG+AlgocVHoadli7izKlVfDvog/NihLOTSfEp76TNJq9lElp
	 euD0RvVjCe5cjt0gS6wzAVVefCMsb3HVxbARbmaIpla+WhQahFEc6h9MLeX7JG9GQrb3a
	 fl8GH1c0nksj2XFv+yVuH6ssoAGU865b5uPbUlojNSGomAmS+cqu6IVaXJGS7PIONl+Xc
	 buMVkosbEc3Wm6Sk5MYy/OUzHX4IBjVo1s17/fYuzY+dhLB+0yvCtBCTunkHB/xXsZqdQ
	 KuseDvMdlCUooMUpdGbhHi6dEVQR7WH7iTEcDuRTTy0mxCFOeKW4JIgC1KVX/y11GcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XwXucnqYZmi+RElxcgJ15FdJ8aMaeg4XkHkl1ifpPDE=;
	b=dj0gN+xqGJejaYrmSt1+xYyC8XUQ2AG8HkoptJFu7ZIbtyPQ56tYZKxEa378ixopWGW0
	 8Z4TJYAGs8U79X+HlfTZBpH/Mr/PoE1z0GML0rD76MCRgAgVkpJKHzS5hlIq/zxCWflyl
	 AspTeYCKdXEGGBKLN7x09rB/zxpKXvTAzpfSaWbLbxFVm2aYZ+5no6bM75JQFhb3mkTaZ
	 JQxFEetcwAuUQCGL0EgNLHEWdMovEMpKGahy6eJ7VyKEc3OJWAunPvo0rl1K7an+kYFyE
	 i5z67FIsEbjyS3YM7nb6Qs+Va0lU/OXGOATjYsSDyJ2vYRMe3msxhe+FJRyQW6MMe9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMyrsVv2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793700592;
	bh=XwXucnqYZmi+RElxcgJ15FdJ8aMaeg4XkHkl1ifpPDE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I0u4D/YsfN5YDyeGiT43aM/bz+UZrUCBEqmOq6RnW3izQzr3+hJV19kwx0W2andiK
	 S/C5Jp4od7O+n8CqARH99KBW4nOb8tcsg5PrdDiRGPItw/Y3o1NQTbkAIOk4NT8XYl
	 jk6OJa9njss1bUwY946EtnDKkSTzG5gjYZwMoGboOsBKCoOCF4MV8I5ajIj6KyeE0v
	 LU0impMdhqKixYqgbirHgIZvxGnnwx10xrUwz3UvB6z2f4Mcj0LTYpsfImMjpd7MY9
	 2PgvZHR6PHv0yLfKtYhfMsniYJPGu/jrBrDQHwA+fgJSOT3zoZCo40cT5HTifYbgsJ
	 DreFDtDGvFQnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EE1080BC4;
	Tue,  3 Nov 2026 10:09:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B5A0356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31992809E7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IEzosxBj-moi for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:09:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B37380AC5
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700589;
 b=fid6f+cclDAhYHqo+/IbiR6nn3YGw6H5Htit4/3lJJOM96piodbKtTU/fTl9QMVx7ChQ
 a7ZrsOCVDsugCBp34eQjGk368AHMgD1guebQefo4OxoHdExu7aAi/5F6qXv1AwrRyFhtb
 OHquSyPVATvMcSNa5dE6b3PhmpZ6556alpsVJn9TxWWw1DtY+jgZQpGfDtY8gJUh4n12x
 y+9q6eYBzczoUMMsDVQan8jAzV55QepWhhvPSZZ2tHEaPJiqBRCrougH+FL83GtNqjRSl
 oTMCDCpR+4+VKMafUb8Gdgsff9qoP1nkj04YXBqz8zqI99uywAnTQR9hvyrCsNXF//g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700589;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=XwXucnqYZmi+RElxcgJ15FdJ8aMaeg4XkHkl1ifpPDE=;
 b=mq8V3DXiszJN+/1O1s3/c2t8QjGcV3hchIRyCoxIKsk71qe2HUFW0Rcwv2ePcjG6xY/w
 nrMTkDTwprcntkPvvIh9IoqLzAQCZ2+cYL/mDbu4NMABZXHDQmc/3pXdnWdsmfcyPYWOG
 TTw5FzSc/4EfWL3h/QSsr2ghcqpoKux3k5ftgv6zWlR3bBvdoalfVr3NpjSNZI0N5wD54
 cNLnn9DEF3FGSrql8bHJS5oca4vJKFpRQ4zgbqvHrgJxtihxW7FUM831rkifh3EwNJIyc
 jGc1YkYXtIJdzFEbJyAIpFkZUxDH2tAuaymbhavgFXM68fXOTQ1LYRNz4IdoyEaaBMQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RMyrsVv2; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RMyrsVv2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B37380AC5
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94698411B9;
 Tue,  3 Nov 2026 10:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094BB1F00919;
 Tue,  3 Nov 2026 10:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700588;
 bh=XwXucnqYZmi+RElxcgJ15FdJ8aMaeg4XkHkl1ifpPDE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=RMyrsVv2yhM5079ejDHF8SrD7suxT89xeLEu5MCtsYSgJHbx2SIsYHNty4KduQoZS
 WlH/IeLrV/iXDls8VVpuLCfEOWHMAaYxKANbbJip2v1jpuFm3SpHPWPT7WW1VKVgTL
 s0Jti2qXii5m5ruMAvbvZ6MTGMFoRLJdDV12BuSESkUAXrQGQmYMOD4FV10BAwBUY9
 rxU1w28ZLMwVtBoiPeJQX3inyTtnCAou0i+63Tku2pjRvp6HVCrTiGXKM0iS66/5VF
 PItrcFMi7nSlW7JUE0FoGzwXFEmN77SrMaJpGRxSaBgbTh0G/QnuivGD4Sm6lIYjNm
 7lFAmFehIbxEg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/6] spl: support booting FIT images downloaded with
 fastboot
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-4-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-4-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 11:09:31 +0100
Message-Id: <179370057187.349126.1249068431082363401.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=vlT/ZDk/eX6OCKSXSa/TycE7Ri6LZRm7iEve4h0bg5k=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq6bLi6JK4tehGHnESjlKCs1ipvuU50EKvyQEkM
 BKz2bN8SheJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaumy4gAKCRAZDR20Zk4Z
 NSqOCACyBFlfek5zFMC3NiFd/aIJ8IyGMXNw/JeVkCQn6jfh9V6caPai/kl+72SQET0Xsp9YFPx
 0kIU8FjF19IaYyH2LZAk01UPABgztPEvDTuso5PCcHNbm0MYCk0nz9AfQ2EDRwRDImHFRnfW/LI
 bTSvvR74gjkoz0g/+iBu93ePK0kuqei9Gs1rm44UwpKv3lg/6oQ7mGu70IHkPOt1wFnTXEeUAV+
 Bx16SZj1Jc/CLR1mV0OrF0CtXxLGn0Cx3cDlzZzHjF4wWRSA3LUZRZEZC4IXMEQa/n31Y6ZSyW1
 lsrSIQRWDBowhLvj4fsMPZu+if7LuT/B896zL9y8WAIWp7d4
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Test farms need to run successive U-Boot builds without rewriting boot
> storage. Add an optional RAM boot path for FIT images, including firmware
> needed to enter U-Boot.
> 
> Accept the Android v0 envelope used by the standard fastboot client so
> the same fastboot boot u-boot.itb workflow can be used with SPL.
> 
> Do not boot after a failed USB acknowledgment, in SPL or U-Boot proper,
> so the host can retry the command.

This looks like a bug fix on its own and should be in a dedicated patch. Please
split it out.
See the following
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#general-patch-submission-rules

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
