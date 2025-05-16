Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A95C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F4980107;
	Fri, 16 May 2025 18:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747413738;
	bh=Tlc+tJkVDcXT54rYS3mnQLmcKIn5AJGV7oh6xM1xXa4=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X3iff9PA3z/3Y6aLxbfZsuRq9XRPXP+BXosvaSs0GgeqWeak9HgzF+rJS4EIKGe5J
	 BJzoVuRWuXzeqecjRquTMlF5HB3QFIkzdTRZ49/0ctKQizVQwQYZRskTrLXzFYXAjx
	 K2ra9HreJsBteD9gPkaPKyeAlvdK2q+wA8SlgL/LXB44tEMNOS9IipMKVMcJ3Svp7v
	 vBOqQiDywJ6b2dNBekcSVsBkpfx98Ts7pU8zAa6hIRH1eqij9TflDkz62+YIDpWNpZ
	 z7+TLVK3yhPs13LY9f4g+ZbZeBQn3MBemxODwrPA/ao2a07ACkWFh43mhYPqbT9T+m
	 78ofeyivuKx/Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3182980FA8; Fri, 16 May 2025 18:42:17 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044908006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZzXtD305hz9tCH;
 Fri, 16 May 2025 18:42:12 +0200 (CEST)
Message-ID: <f5f977a1-34fe-4e2a-a604-0f0695f3bc7b@denx.de>
Date: Fri, 16 May 2025 18:42:11 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

please pull this next batch of mostly cyclic patches from Rasmus:

----------------------------------------------------------------
- make cyclic_(un)register idempotent
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=393&view=results

Thanks,
Stefan


The following changes since commit 1b5e435102aa29a665119430196cb366ce36a01b:

   Merge tag 'u-boot-imx-master-20250512' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2025-05-12 16:05:22 
-0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog 
tags/u-boot-watchdog-20250516

for you to fetch changes up to 6f0a3cd7bcdd4ce25b5ad253a6ebad88d4b94fbe:

   cyclic: document new guarantees for cyclic_(un)register (2025-05-16 
13:44:19 +0200)

----------------------------------------------------------------
Rasmus Villemoes (3):
       cyclic: make cyclic_unregister() idempotent
       cyclic: make cyclic_register safe to call on already-registered info
       cyclic: document new guarantees for cyclic_(un)register

  common/cyclic.c        | 17 +++++++++++++++++
  doc/develop/cyclic.rst | 13 +++++++++++++
  2 files changed, 30 insertions(+)

