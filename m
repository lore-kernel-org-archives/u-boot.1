Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26BBCD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C97849CA;
	Thu,  4 Jun 2026 22:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="E1gLF1cZ";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="YGvdgAwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63D3848DC; Thu,  4 Jun 2026 22:41:55 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F330848BF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-9xt9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605713; 
 b=T8CplF6t9foRZ3aSHthytwBXcmiHUkLMvaZ0aHD5tnnoNeB6rThoyYn1Arv0OB52yN1LDWwvUz
 +O8bDtE3Hl30fATACKo/iD9Rz+e2QiRbOpk3jNsCuU+RaU7D096zuhO44fCurtPwmrGRZ+nJU2
 F4H+B+LQq9EmgkerYLo23mgTrebE0ZbDU5Iu7mh7+dCipJVnO/5+GJnFKpatwewDtVCEPWGrKP
 sOntKjlcQyVQYiYsl/R8HBUZYuPS+aS3OHjhfUV/hm0WQM3wwErlVR4RACD8qfbOGjiO13X2V6
 kZEPzgo0qzO4G3c77qB2TlKvWBZWiGpKOA0kDXv1BJbTQQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-9xt9.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-9xt9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605713; 
 bh=KJnCQQmsWCbGFMPJTh5TK+iM2H1s1y4Yf6lD2ViXb20=;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:From:DKIM-Signature:DKIM-Signature;
 b=bLZ2yvjFPanDY8leHy6zC7SfEUsOAtod8UV2RjDkLmLoZT3ry0WeFSKgfFM4E5XeDhnn6LP0r/
 kDJAoOlJGU2IEFSqmlwavWKdfSMJOvFecPlomfIUPgSjP3D33HiRGyujneWHfSGuX1wmp/EJvr
 /V6yaKSfcD/0ULU6v1vVGk3Y/qjj5GafRkjxiBTDLXFAtU9AK9zabxzyO6hnAivbMI73y24T4A
 Lm9K56UjfvSZgOoYWtF86zst8rZiCD+tEeo7HrYqf8KpXZqNz+8j7jnCLNQ0QGCc3ZNBYqU+LI
 r5lbZ00CpFIRkcnB7tsvY0efOTDjgBbRQTnhijs4PCf5Bw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:From:Reply-To:List-Unsubscribe;
 bh=x/zBNvOiSkVUHrm6hgzoU79TL1QGVafNKdgQ7WTpquA=; b=E1gLF1cZolX3guSDrav+zStF4S
 DC0+UJTLth9HWZBc4ydWOxakZh/bWQ9h46s9sZn5mHo7mh0E4pHuwPbI6qymtsFuKCHgbB/9n4nyW
 cFptL6/5eVA6MfKVSDc4n1xgNY+0GHmJy+RUtQx1exObDPp5yzUVse/a2Ha3IXwl/qjU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-9xt9.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <francesco@valla.it>) id 1wVEsx-00000003y5d-1PuL
 for u-boot@lists.denx.de; Thu, 04 Jun 2026 20:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=x/zBNvOiSkVUHrm6hgzoU79TL1QGVafNKdgQ7WTpquA=; b=YGvdgAwQHtWXAU+8JVgEfq1jYF
 y662nIbPTjjHoV44FvkwvOP8sBj+pjhgyKb53kiH7VcmjREC1+0hXGFR5JivSnXpXDMIUzb8S1JHF
 pTs7hSwGlGM/Qob+8fK5o+yXXqsGDEQTUrs8nlFVG5eD/9zaCyWPkZ4NMCyQHK9Ef2XY=;
Received: from [95.248.69.182] (port=60898 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wVEsj-00000000GnV-1njI; Thu, 04 Jun 2026 20:41:37 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/6] Fixes, cleanup and a test for the SPL FIT "full"
 loader
Date: Thu, 04 Jun 2026 22:41:34 +0200
Message-Id: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrA2MoUToVYqEGCc6JaQhY0pBv
 HtTu3yL/w8QKkwC9+6AQm8WfqWGoe/Aby6tpHhpBo3aoMGbkhxt4N2GGqP1kVyqWWkzj+icDyM
 u0NJcKPDn2j6mv6XOT/L77wXn+QVOA+0eeAAAAA==
X-Change-ID: 20260604-spl_fit_full_cleanup-26b70aacf70d
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=francesco@valla.it;
 h=from:subject:message-id; bh=KJnCQQmsWCbGFMPJTh5TK+iM2H1s1y4Yf6lD2ViXb20=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmKjxliEheHNvpKrPZ6N/+h84N/3KpMkr7ZJqd9fjqGB
 Z16ms7UUcrCIMbFICumyBKy7sa9PXPNv6VtYHwEM4eVCWQIAxenAEzkQxkjwxyfFd8iRXy4jl7R
 d0m3PHx88d5ntvLLHPgCdyopW7JXJzP8U+3QuPQ5f2LX6lte9q5Tix8c5IpaFfd3uajXTTuZ+2F
 a3AA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 5de9e5954cd67a0cf5c17cb529a91b30
X-AntiAbuse: ID - 5de9e5954cd67a0cf5c17cb529a91b30
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wVEsx-00000003y5d-1PuL-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-9xt9.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,

this patch set contains a collection of small fixes and cleanups for the
"full" FIT loader that can be used for the SPL. The main beneficiary is
the falcon boot flow, but the same loader can be used also for U-Boot
proper.

Patch 1 was part of another set [1], but I decided to put it here for a
better separation between plumbing (here) and new features (there).
I kept the Reviewed-by tag collected from Simon in that occasion.

Patch 6 introduces a new unit test covering most of the code that is
being cleaned up.

The set was tested on a i.MX93 FRDM, both with and without signature and
to boot both U-Boot proper and the Linux kernel directly (i.e., falcon
boot).

Thank you.

Regards,
Francesco

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (6):
      boot: fit: fix FIT verification in SPL
      spl: fit: fix loadables load under sandbox
      spl: fit: rework the FDT load hack
      spl: fit: drop the 'standalone' load attempt
      spl: fit: use CONFIG_IS_ENABLED whenever possible
      test: spl: add unit test for the "full" FIT loader

 arch/sandbox/cpu/spl.c         | 37 +++++++++++++++++++++++++++++++++
 arch/sandbox/include/asm/spl.h | 14 +++++++++++++
 boot/image-fit.c               |  2 +-
 common/spl/spl_fit.c           | 47 ++++++++++++++++--------------------------
 test/image/spl_load_os.c       | 11 ++++++++++
 5 files changed, 81 insertions(+), 30 deletions(-)
---
base-commit: 74007f24a3aca13b70da6a2c098b830ad9e60804
change-id: 20260604-spl_fit_full_cleanup-26b70aacf70d

Best regards,
--  
Francesco Valla <francesco@valla.it>

