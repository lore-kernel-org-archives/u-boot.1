Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0E606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0XFu/Id1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHRQOjwk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D565B60B3F;
	Thu, 19 Nov 2026 08:49:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rVMLzLEqCGfZ; Thu, 19 Nov 2026 08:49:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B370160AE2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795078195;
	b=PYPGkLz3wgI8MeJcBZqJQ9CQDX++VPR1dfsf9Exxz7OnMNVWYr8iyxTYmq1w9C7THhpC
	 gmN3FbqEagzBL2pP8Woo4UrHKFZZKrYcwCHXUQFuro5kE9Sa0M29kiwjlogsXUFZENcFt
	 0DB4yKHolqAoj9p99QVZyDfiTeJMkNm4jHQdVn9KiAT3LcgkEtPtgs+fK685t/pGkksXJ
	 q6kyoZpgIWj15alwWVjZk+VH8ka7/4QgJCb1hE3N9sCEV6ax01aJKjfPn8xqrf4Re0vYV
	 jHgL/U1Cg/FqcoIeXmZA3DAs8tIWQG4eNdi4RgHflB2ZwZr2GAMx1BstJ64LbeQCfpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795078195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YtrtocRylrCzTQb9c8xu01uQg/VD6QNQ/95r5CceASc=;
	b=TXm6K2wZo8VAy7df91aXHE2nAOb7YAs51ZX1SJfgPFUpplG3+N+jXu1q1iQgOJYXHnD+
	 Axzn/5SGiin/+9vLF+eUZJi0W2y9e+mhTMU2ehPSYgO9pd840YBE9GNyXbfy7XXq3xDSB
	 OzTePyJ1k/Xpl5HU77c76AJMGJCEikm0u6hyEsYVNaOW1G0aMN6Zf3TcjSnK/KdJBARkn
	 tPMOEJe/P51tNucTLJnf7hYhng7eAqSxshvEmJLgup/dR5L/DsvTimC03Iu53zAvRoxMk
	 n/sf1H1+LG1p9P5kdUhIBI/T/GREC17PVC9PRo6ULS7sREqciSebB/ipH6NwIKnRiiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795078195;
	bh=YtrtocRylrCzTQb9c8xu01uQg/VD6QNQ/95r5CceASc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0XFu/Id1+Pp9TI0cRN/TmRIKHN1zDrE+cjx36TsfiOdHOoRE5kycY7BItqZWrjqrr
	 q8jW6eeDJSuyyLbl9ka0O3MwurABy4ARJ6FAOWMmVQklg2+tsfOZLd7XMMn7pEKBlw
	 Q3B7yIYyt/9FgDaAgAEpMQBBn6GhtPU/9sgtdibkGBUp6m8INqC055JRRDJj+LB1si
	 P/ql/aFQXU4et/N0cI0RoTZH9CFnxUTurHk88LhlPjHXMosp3Ynsa0vAkwwyouskNx
	 HtnQTsIIio4mzQ+DLIdBf3IcCqCz/E4X3/mz9zZWv76EYlo3nkZy9ZzRhhhmU6rTpJ
	 ZKMLYjzqcx54Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B370160AE2;
	Thu, 19 Nov 2026 08:49:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 66BA370B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64AD5404E2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bXMlWAXf_RNC for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 08:49:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 73143400AF
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NHRQOjwk
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73143400AF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:49:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AE9460F8B;
 Thu, 19 Nov 2026 08:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3641F000C4;
 Thu, 19 Nov 2026 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078190;
 bh=YtrtocRylrCzTQb9c8xu01uQg/VD6QNQ/95r5CceASc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=NHRQOjwk3GV2/owImZoBX0lBeR8lFkdyTCYXe50F1mHk8AYZQlpV0nSbXN+KP5eiO
 NbCk1cEfPaMZ234uvXZ1HmUVTKvJQ1sxD82VKcMvERi+M4gDKitEyMB2cT3jiqfir9
 4sArTipBYPanIaUb8CUdyRQW2UlkI49jvutSkRlwW2tGwNdGlxr9SrDRAoe3BTFNar
 uSebc4CqHw+aQ98pZw7nIzb2vYqSyom257AtMVNInmFzCkbzEtSphYg873sFbn0KVh
 /OTQhUGpLSDvdz2XqR8vnGAGOgU41AIEzpnp91FA2xIIcDzOS1YULJJHSukTHkgU0I
 3UD5Q/Io+YKtg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, Tanmay
 Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>,
 Carlo Caione <ccaione@baylibre.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Julien Masson <jmasson@baylibre.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Igor Opaniuk
 <igor.opaniuk@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Francois Berder <fberder@outlook.fr>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>
Subject: Re: [PATCH v3 5/6] test: fastboot: Add test for block partition
 table targets
In-Reply-To: <179501884043.2226612.13667335390914530195.b4-review@b4>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-5-7ddd7ef832f6@oss.qualcomm.com>
 <179501884043.2226612.13667335390914530195.b4-review@b4>
Date: Thu, 19 Nov 2026 09:49:47 +0100
Message-ID: <xhkdbmrr5p5n8.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 17:20, Guillaume La Roque <glaroque@baylibre.com> wrote:

> On Sun, 15 Nov 2026 16:35:12 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi,
>
> your tests no really cover all new feature you add, in sandbox
> FASTBOOT_FLASH_BLOCK is not set so you test part of your change not all.
>
> i don't see some equal to fastboot flash or erase command , i don't know
> if it's possible to do it in sandbox test.

It's possible. Igor has submitted a series recently which does so. It's
a clever trick but it works.

See:
https://lore.kernel.org/all/20261107-upstream-avb_tests_b4-v1-5-9177277458f9@oss.qualcomm.com/

>
> Regards,
> Guillaume
>
> -- 
> Guillaume La Roque <glaroque@baylibre.com>
