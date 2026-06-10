Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1774DCD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 07:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC2580087;
	Wed, 10 Jun 2026 09:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jyuZD8u9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CEE80433; Wed, 10 Jun 2026 09:39:37 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D5780086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 09:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gZyN11tRhz9tyF;
 Wed, 10 Jun 2026 09:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781077170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Enfw1ulV6ED0RlJyfwEQCoFwPIvKOP3a+3P7w09kIDs=;
 b=jyuZD8u9nZVtJlaAKhyoByBUzYljtIEX81XYU2QH0sdc6gDWOh731OWkhGtpf3DL4XWwGl
 1njjGDE5Oa4Lxyqi78ekpzOwK0yMrjEXQFxU8p1nU8QhZuHPKe4mJeqy21iXSRQ1dAVAjH
 aDnLtUjI+jjK05w4a3Hwv4CeidFUE0n/r4CJ4d56tyPUzfpGVm24TaMedpqGVp7AZbXNww
 l2mm9/LCAB3hik/AjtM98LGfXVwqICKEGHZqcG/8hsGOt/PQFqnlsBg6vp5L8Lfj1Z+L1M
 xVCJWIYdq/2IQdk3WE+XnxTkrYEckDsW0U2cBWYsiZYfuxoOSkQpDI1P4fpD1A==
Message-ID: <34bc3866-fa6f-4aa9-8d2d-f9ece11f04c3@mailbox.org>
Date: Wed, 10 Jun 2026 09:39:23 +0200
MIME-Version: 1.0
Subject: Re:
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJaLiFx+ewfP3wfwdFnSapNcg+XaiMfmdw=xr6NL_BKt7AkTNA@mail.gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <CAJaLiFx+ewfP3wfwdFnSapNcg+XaiMfmdw=xr6NL_BKt7AkTNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fg54yy9pwfnbk9r4msi9rfscdrj3gw66
X-MBO-RS-ID: 72d38374a3da993dca7
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

Hi Tony,

On 6/10/26 09:37, Tony Dinh wrote:
> Hi Stefan,
> 
> Please don't forget about this patch!
> 
> https://lore.kernel.org/u-boot/20251210222754.23535-1-mibodhi@gmail.com/T/#m3530a5001aa66967da2f5005d608ed312ebbcfe1

Yes, on my list. Hopefully I can get the pull request out today.

Thanks,
Stefan

