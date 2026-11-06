Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA76606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GDHjs/zH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuyYuwJN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13D72608B0;
	Fri,  6 Nov 2026 13:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zgaw2WBGpFrj; Fri,  6 Nov 2026 13:29:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93FA1607C3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793971796;
	b=BP5Swaj+dp20hMC5WyvaMD7hEeFQ9E8eNIEXlrv7cY0Uso4Q78oZPrJhPZznQGn+VKuK
	 BgE7fPdJzkESYm/okCjF2QI3TGS6S33c5i5Jix83Jg7UT0IUPwwIot6ls62nJ3szOOtF2
	 t+jPUWjiRdQNvuJ6Csc9sRN/oHeuUDp1E29p5E1PVbXW4Qcc8dXT3o81X6bxWGvUN/NLM
	 5C59hTzIXy0ZvYC/qeD/2o6f7Q7EDvnrJlL2f18oAq64LOiNbYVVePQ9JsWvwMPPhw36x
	 O9LOK1ZQWKdZ+iNsQ1zSsW6UXKvtly0IB1Dvw30j81l2F8ix7VPToAm7v4ZyTj9GcIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793971796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uBPrI7iR+mG5vMtR81GkKILCFNuE+k88lIkfMD+bEjU=;
	b=o4Ozy5tyfToZdeWJyU1PpTCT8jyM0V9NpJ9REypt2RUX4/SXubpmGSUuX+oAoPPuDTsl
	 RZadcxD1ErI4cnORZm6AKcsS4E87KWkyUogcF/pevDhYjEpSjxb8QKvjgnWXQxdqOcSGF
	 S00ZE/GjFUtWzEN/QRZrSyfk5GWP1mVbAoj0FcwHT27ihq4Olk6gOD/pzZRF+5GJsWMm3
	 2mxZx3A1W7a+GMZ8wQhT/W0II2SRAg8spFv5u1n61dCMge7RQn6QIY/Yav/Oey+jj8E3l
	 fdwKTuydc2dpNeJ0FIw8+HIYeP/xcwAEOiWe+P8V38ahES5x9nTYB0FpPYAp3ZrfSww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793971796;
	bh=uBPrI7iR+mG5vMtR81GkKILCFNuE+k88lIkfMD+bEjU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDHjs/zH7o3slcoG3y8OCKTByHMpTjA1TDTsh090EMYJSTQGjix2aRgGI38n6jN+9
	 yTML60LNaLNOty7XoYQ8OQBfiEyhCUEeofVfzoXe1E226gG8WrY7ZIkiLGs5PCMeBB
	 xSXk3w/ZH7hEYno9MpsLOk5TXAL/GvCSQf0EKDMSzqMQB/fJaEy4wjlIBVej+VAEuv
	 bwF76w144OygEUXoMXjmoUYqQarCLQc6ZgQG182uyANVSA97r9TzubuOwJZPCrAVTf
	 SAC0kQd08HM2x2YRcn2qpxHX40uMrKFeXOc/CdMcLFB0Xycju4CxUkwhjQUJVjHYyW
	 hI2EM+Efi8aMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93FA1607C3;
	Fri,  6 Nov 2026 13:29:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94CDC2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A53E40927
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVRI7st5mWGH for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:29:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 152AB40802
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nuyYuwJN
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 152AB40802
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:29:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AE2843471;
 Fri,  6 Nov 2026 13:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8EB1F0089F;
 Fri,  6 Nov 2026 13:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971792;
 bh=uBPrI7iR+mG5vMtR81GkKILCFNuE+k88lIkfMD+bEjU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=nuyYuwJN+/awmgVYXqvadQg2dEOdjUZPUVGAeXvCGfkL2JgiY3+ktr2Ngz3zh0MQ8
 y9qcC1Mu15Yp+ip3UidOLBZuiQLyWm/ejMPNFT9t3TQh0uZcEwmfw6I5TyCHe3+obR
 MRBZYexCIm+RAnqFYmLcs9LwbV/tHIi88RFVz/YZcT/tKlvCrQPZOTF429K3pe0Qty
 a0U4kjar0dE5hb6cTrMoaINmnxhAkjrTSyehuFVvjCepritMUC03Rj955DwOVfPExY
 UUw4gOA3VSt2UCwQ0gfx5/iG5G2zvYQnGsxWRXYBhgBxt8Pn5X+TExKN4czo6DxO9d
 SRW9XTisMyHBA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20261104-maintainers-android-reviewer-v1-1-a239c7926351@baylibre.com>
References: <20261104-maintainers-android-reviewer-v1-1-a239c7926351@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: android: add myself as a reviewer
Message-Id: <179397178466.1028119.3728008637982663565.b4-ty@b4>
Date: Fri, 06 Nov 2026 14:29:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=403;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=CZOB0CnLrt/QaoJI01U+UU2aI1I889TMR133dZ03fns=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9bba75rFGMXR69/ns01j7d0rWj1xdyPs8qav6qynpwXX
 Zuv82p1J6MxCwMjF4OsmCKL3kun5dvks/YFC69lgBnEygQyhYGLUwAmssaD/a9MqnC0mpX/qbeh
 i3hTU5dezVyYwqzlbhAnd87P09a++Uz1h+cnzY94Fl2Xm9bpFFV2nDX8p8aCNN2Db4p+FVuWBgm
 Za6Q2OWReO/qzUXmrzzzthxd73Xd0K0xf6DmpNOda1mufvMV8Vqe3tbzMcg9t+7pROX1S5aYtyw
 QWznpzglts7rLw6e5xnoJx9XIPt1f0qopUZE2cvpK521D5XI3+ujuMftxMh6or7D+r1m3asO3NC
 cbQicv3+wdnfOqb4V9bKFFp3XLr2q6nb3l8Yx0eyUtcmNVeLJlV90fd3MGGU1NVbFrBlCkG34/v
 Urs9qTvPvfTkbXnZUk/HW21iSa31vRMfr1PaGPl3lf4NAA==
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, 04 Nov 2026 13:48:51 +0100, Guillaume La Roque wrote:
> MAINTAINERS: android: add myself as a reviewer

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] MAINTAINERS: android: add myself as a reviewer
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/0a3f609e295978520068dad76f2f4b2f4ac58e60

--
Mattijs
