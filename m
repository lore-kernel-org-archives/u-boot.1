Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5650606C56D
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c/vYKC3B;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1/pUazl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFFDC6077A;
	Tue,  3 Nov 2026 10:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rkizdwycy_B5; Tue,  3 Nov 2026 10:09:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C0BB60769
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700595;
	b=dUzn4lqTEwjLDyW6PMetqzDYJmaxJLD/9jFw8TnazivegK4aEOAq7WoPvWDbedWuuGRP
	 wpjR+r5Bbjlry/rCQ1SZztE/PRc51PM71PLPlyAKSn8u+Hw7zpeq5SjIhMgBJOryDDDfN
	 0s1yZs3dXGpfZGfIubdzgFi9/HelVkAzJHTn5QHMFpyoZE58reAqEv9YGW5XTvPZHXRnQ
	 QKyj5pBJ9KxxeAQZyJ4i8ADRyqD+eWyq1Roza1ALLuM300o78SRkKlh83ey92SLK7TSeY
	 iB+0rX6q2/Tp+p0+LLLTZ622CZMxmCsnxtk4epLI6csywKH4Nzonpf9IO2WFgQ37ttg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700595;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9BJckWBkIn2UgrU/nS6nVMfb1THT3tVgFW3c4Tf9kaY=;
	b=I+IaZL0KJ7tptNRSRaPEcGvraYT+8oQgJw4+EVzhY5yN13ISm6NGYvXW6HKB5WSakiEM
	 06W4nBsFHkgGjBCgV3QWEOsUDsap//mThqh9FECYnPT4FzBsG/JlPQo0vcwhIGv88bNVu
	 DL7ylfp8vxS0EImpSRNXUzLe2qU4cWXNnf/2g1aJCVIjTJPC8EOfP1L1oA8kfExC9o1g0
	 rXn3OjUp90CL8RdzJzPGCF1HwPYNTzcQ7G2EhJ4NPprQmb18kmEHaH+N6mZ7jsvOQsadH
	 NzhT8gypXAP5EdX4aNJ6kmdoPqqV5P1Q6eBLEeQJ4+h+3ZGY/w4245NQpHg7o9NJ1xA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793700595;
	bh=9BJckWBkIn2UgrU/nS6nVMfb1THT3tVgFW3c4Tf9kaY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/vYKC3BGAvm1A705YwpiiFunJZ94jx5MdED0hEqQXu6fsm+sNJhBSwu2Llak2uVe
	 l5nf5xdRNHCutwR31suHJ5wW+uPy04CvGlWUuXq2hCh7DSYN7CcSa0eBQ3ynzrBt4k
	 Nun5PSt8nrzfwr5Z4aZZtkSVRkpFZuGHQBbUzrfoPXfS/aGD2Mr9WrHPNI1Kqqsf02
	 +Gd85sfikhAFBFEa52sSohmhYzEN1+A6xgTAs8X7c7LnuHuGGGl1sqNC/oBxHN9Fz5
	 bYZunVhZuL75JN3uqgtwZo4UGxaAOL//xT5xVDS8d2xRIIHWStXYNp2s/wjE1ibx8p
	 OchDMoPETft3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0BB60769;
	Tue,  3 Nov 2026 10:09:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53E222AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 322D4405CD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zG6YF4cBqegl for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 577ED405C9
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700592;
 b=o5miONCcHm43HtPX2tQeCEbTueER8vziQhrLt6Th+i5BxOjciyPQPZIL8igWXvB7kizH
 aThVO68C3Hir+8s3V/6yRFrJYSICj19O8PjVFQ+ZCyMp1qCnXhINE8xEiBsrwynPTRjVS
 75ky6OqKlZbl4G6V0UpcHqcxOOrW2Y34K+ffrObyMe76Mv5do7NTKt9CrQWVbtHxRrruu
 IEtihxW9qdokiOqW9m5zf63BCGQ+pV0rBHNAfjQPh2XTQOzjvWRVUbIftYAn2Khhksz9Z
 2Zc2tZlfG+knnwhtp5TutIXD4Fse0VccLlHCDQH+K7fcKKmFXiOUq48MRnq5We0jERg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700592;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=9BJckWBkIn2UgrU/nS6nVMfb1THT3tVgFW3c4Tf9kaY=;
 b=dA6kgcy2VjyDi7hIjrtbcLg94NtnHw+02JL604uQ/7/YFFRbD0G/mi4O2BI6OxxLHA1T
 omtH9tqBUQkkCO7Hl5PSxRNuqzfz8fpq27oVTbA6AdX7vi8copnAvx9BgyC6v1odfp2H+
 DHxN6wxibjXToACsvxJqMOEnRXCc5+GtZLBYnerGUOhJvshEwinFVTWy08vkAF7raHBAj
 f7AG+5o8Gd5w9jqtjmoBMq80gSLIrV7aumx4Eal29sd7yfa72T5chOaPoxWpLhdwhuRO0
 ouuqbOHtERJ1SBkNwGcx/6+BRw4aGtbR0eFYtkhEN+m7BgQdEFr+q4BaJT6l5xYY/CA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="n1/pUazl"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n1/pUazl
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 577ED405C9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1433D60611;
 Tue,  3 Nov 2026 10:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2881F000C1;
 Tue,  3 Nov 2026 10:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700590;
 bh=9BJckWBkIn2UgrU/nS6nVMfb1THT3tVgFW3c4Tf9kaY=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=n1/pUazlnPAv3SivYEG3S4w4ZkZdLjJ0BPcG3X1xfa/s4ILRa/FcaGOX2LYi+AEWA
 lEqWTbgIa9JyYScWaCR3Bhbp8+PdZ7tkL73AKlypg9J723/ilj+NPnOs1oWK2KRU84
 vqnWSDLEmmNzkPYoiLvi08wNRA8DmA3f5oapyMssVD0xTQQYwW7weySeq6WgdIwHsD
 BWY662NUn/yw95BzLW4P6Q6Uv8zkROqlUYZaa/tju6hNjxA7uWS806+eLbHBmchbR+
 VlKjTUYp9/g21U5axNKaEUXmH0BC26si2RnOJ8yLYHZYtHz53Aumbkk47rA13sRkdw
 ckj327vfQzkdA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/6] spl: fastboot: support legacy U-Boot images
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
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-5-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-5-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 11:09:31 +0100
Message-Id: <179370057188.349126.10543381660332317698.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=558;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=cEXHCkHnYLHlDXMGAeGXqUxL6UDPtUGqARBn8BbLJrw=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq6bLin568MNE34T4+o8vrn4PN3klZcm3/v0d+Q
 r4Olpw8KKGJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaumy4gAKCRAZDR20Zk4Z
 NeABB/0THNaki+DcqCd/GB1hexs8rysBc+xFYCskVdYL6fEOUBqKNMMWw3/iGbyGKWWm55qMiEd
 f8/mKh2j3+2vJ3mG5SBxjUnfLI6iqL0gsuwGZmVVjUOzKfQNG6apVDLw1ZTuovj3n51wVcSgVKv
 aGKcrcGVtCqNZy8lwgNonX2XK4Juu96HTOKn126DR/8kMIUwSEep68xecTzcILY7hsTd+SBjLOL
 IG/oqE7s+IVDlupGf0GyYJem7BYgIpGuIexvcIVIeBJbNVjt2Erbc7bKaoNKZNkmahPCt9uKGrq
 SMqVlPjYIGB3Vx0b5HgHvl+clwYypkpshHzS+2Hk/etCwxvV
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 14:24:33 +0200, Carlo Caione <ccaione@baylibre.com> wrote:
> Boards using a single legacy U-Boot image should be able to test it over
> fastboot without changing their image format. Use the shared RAM reader
> and SPL loader, with the downloaded length limiting header and payload
> accesses.
> 
> Keep legacy support optional and reject compressed images, which this
> RAM path does not yet support.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
