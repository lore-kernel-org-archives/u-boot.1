Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D219606A335
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f6wlodO3;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=fB1z9uOf;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=W+8T34nE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91F3D80C2D;
	Wed,  4 Nov 2026 16:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bPCZSfAbU49l; Wed,  4 Nov 2026 16:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF55D80B97
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810736;
	b=T7eHZZlIlreK9Hipa87tY1kVTCBW+a25sbwf89IbYeciJiVOO4Ei31xCATPNpIo41oF6
	 gFGJLEcQ3Nx43DtY2kxCFIwHx0c7mUENFqBjX0yOmR0NmqlCU66TKhU51tY74dmN6rfY/
	 9ROoccnLKS/Hx7+RwZDz/w6myCnxWmrVq3fyjvxLdqKvGhm36cpxLqQGNdFV6mqXEl76J
	 bqr+T0uVf4nhAme7uzeBeNTna7QocEuioOrhiNN2D4m+fVz31m0bEn22g8yEZ50AjGuIN
	 8YQubkbyvq+2qQ9kDwQYv6N3sVn7EQ67xWN6yaoj4hocfM81xULoKnMOhM7X5Ajrgmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XI5ZQzkGlPbSA+DatL3WwDGgPMPk/sZyMiR4db/72Xk=;
	b=R2nJgwE+RUFrA9le9AVEOHkPQ7AnTx1UtgCC1aqKaKUwACSAPBFWUdU6HUAi2Na7kcsl
	 MwU9RuZ7B3G9SPnXzKchMFdP1UTyZ//cZbgsQl0MMVnFu+meACr7L0r9ekzSFqa4rAqgm
	 05BQx5PHtr822MKHmExnHgHUhjTowonBvwtCa0336CvA/GHYXDZrQgbQJoRfzmZ2mC+by
	 ARDFKNNSn7A5aZrnqu758kf9PlYjntaVJDppHRntHOg6faoE7rx81syG1Q2oPDCptUjev
	 CPtTVmyF8qDPvnXo0hhp8hJ4nuSr07UbIuI5yk8Xc64Qi31cXpl+McMCRKFqxIq2hew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810736;
	bh=XI5ZQzkGlPbSA+DatL3WwDGgPMPk/sZyMiR4db/72Xk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f6wlodO3BifdgsoY/Jimgoxv3WMTFuoaqhbfSnjUvCiyg37EYomiEgKDqcRoRXZBV
	 9cPjlZa0s4n9TwbZq7omCzxDQLG26Mio8N65pr6967Ohnf3+bXg7SXkVndeVmRNY5A
	 9hNXbQfRVF1bRgoJAOf6BxLprIRRPtx/gtcRb3PXTtIQpZV3K8z7jPOIXsMNYLLBmm
	 Xcct+mUbBSQB35x8rdArBbPiDsMgF5KpFLs4wda/4BAEnx5s1NCutFg3x3caf98dXe
	 IHkZXDmy9h3//djmV8u0sXdtx9Wlq6s6p7O2INUJOqEP3lVVdByU2zTEv8AOxi0E+b
	 LlGafE4P+p9Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF55D80B97;
	Wed,  4 Nov 2026 16:45:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 9BF42435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 8D2AE40752
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 4IAxZMQclmCo for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:45:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44E9740719
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=fB1z9uOf; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=W+8T34nE
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 44E9740719
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793810731; bh=XI5ZQzkGlPbSA+DatL3WwDG
 gPMPk/sZyMiR4db/72Xk=; b=fB1z9uOfFkiOkXLk3a16N5Q25qAeHa/H5wH8VIzogb+I15rhEa
 sAj7t7eZ4jnCEPveNE0RPJCa2IzUWgmSjz7+rBjS/g/NPjwC017ynyKINX5Yj7OE63U72A7VbWM
 fJsVIwPzh8srzS/+M3bkXAbNOwvYn6epbB+Es7bLwD85faue6ln3QLHWIf5iZ3DBGKUdDd/JWKx
 5Fe7bebPrh/cOLlNcN5UTW4Q++g9HH6J5KiM1T/amR05Ef3tJ1pGBf3alwZTigJL1IUnAP/PYAO
 rax/Z4UeUO+Sw6v3B4MnT+5Y3LP4Q4wLtMpA5ysW8hrgeK0CD9VCDkAGfXiNiJm3s6w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793810731; bh=XI5ZQzkGlPbSA+DatL3WwDG
 gPMPk/sZyMiR4db/72Xk=; b=W+8T34nEzeiLY9kJzvTpXop1lswhcN9z9WnTffVh0SrM+NnEax
 rvFxHW6+eWm3E4HxevpuCIxSRUceqM68iFAQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Bradley Morgan <brads@mainlining.org>,
 Christophe Leroy <chleroy@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [GIT PULL] Please pull u-boot-ppc-main-20261104
Date: Wed, 04 Nov 2026 16:45:00 +0000
Message-ID: <20261104164500.pr.u-boot-ppc@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull the following PowerPC maintainer updates for main.

Highlights:
- Add my tree to the POWERPC entry:
  Records the official PowerPC custodian repository URL
  (https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc.git) in MAINTAINERS.
- Add mpc8 regex to match drivers:
  Adds an N: regex entry to ensure PowerPC and MPC8 driver directories match
  properly when running scripts/get_maintainer.pl.
- Update Christophe Leroy email address:
  Updates his email address to chleroy@kernel.org across MAINTAINERS,
  board/cssi/MAINTAINERS, doc/git-mailrc, and .mailmap.

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/pipelines/1839

Thanks,
Bradley

The following changes since commit ca397fed3948483c4708054d3e73a51962f2b27c:

  Merge patch series "omap4-var-som: extract MAC address from EEPROM" (2026-11-03 17:03:35 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc.git tags/u-boot-ppc-main-20261104

for you to fetch changes up to 981fecdc340851776d571bea43454a223e27d94e:

  MAINTAINERS: Add my tree to the POWERPC entry (2026-11-04 16:19:57 +0000)

----------------------------------------------------------------
PowerPC maintainer updates for main

- Add my tree to the POWERPC entry:
  Records the official PowerPC custodian repository URL.
- Add mpc8 regex to match drivers:
  Adds an N: regex entry so get_maintainer.pl routes MPC8 driver patches.
- Update Christophe Leroy email address:
  Updates email to chleroy@kernel.org across MAINTAINERS, board/cssi,
  git-mailrc, and .mailmap.

----------------------------------------------------------------
Bradley Morgan (2):
      MAINTAINERS: powerpc: Add mpc8 regex to match drivers
      MAINTAINERS: Add my tree to the POWERPC entry

Christophe Leroy (CS GROUP) (1):
      MAINTAINERS: Update my email address

 .mailmap               | 2 ++
 MAINTAINERS            | 4 +++-
 board/cssi/MAINTAINERS | 2 +-
 doc/git-mailrc         | 3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)
