Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B735E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBD180196;
	Wed,  8 Jan 2025 16:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=liwest.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=liwest.at header.i=@liwest.at header.b="QwYHFyRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9428800D7; Wed,  8 Jan 2025 09:30:16 +0100 (CET)
Received: from so.liwest.at (so.liwest.at [212.33.55.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FAB18005B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 09:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=liwest.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanjadeu@liwest.at
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=liwest.at; 
 s=20140502;
 h=Content-Type:MIME-Version:Subject:Message-ID:To:From:Date:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uBoKIGsZFhvszofpliylpe7Hp2rMQgB5fUcd5YGQZuc=; b=QwYHFyRtr6nAdCH0Fx6c0N3EL4
 smfVMOcuLPOQVh+5fSrZNotfgxLUVJNCMcJdasjNH/VkHHRCSpb1EcrFYf1tG1TvlD4Z4dW9XsDLu
 niO6a0QRv5Bt5jMI7JSiT5PgFVtsNu+SIVrbhr0r6LtAzDlYR4BYrLquUfxyBGqYNZOaO8XAj/epL
 SWFcfjdzWsENiKniveAIeFHi6hpLIFtJGUGdoTH4xGlINJVhAuqzL4SAjxua5lZro3T3aUqrrWgUN
 oitlUvlEBzv+jGjS1QmtjtjuaiWef8S72SWQrl2+F0Y+ZKKO9Qa5oJoYH+gFtZMMYbQPOQoRkxdxP
 pi0FSShg==;
Received: from [192.168.224.101] (helo=ox111.liwestmail.local)
 by so.liwest.at with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <tanjadeu@liwest.at>)
 id 1tVRRz-00AhO1-5z
 for u-boot@lists.denx.de; Wed, 08 Jan 2025 09:30:11 +0100
Date: Wed, 8 Jan 2025 09:30:10 +0100 (CET)
From: tanjadeu@liwest.at
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Message-ID: <416280384.272214.1736325010687@webmail.liwest.at>
Subject: Issue JTAG debugging U-Boot
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev30
X-Originating-Client: open-xchange-appsuite
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

I am trying to debug the NAND driver (U-boot 2016.09) and ran into the foll=
owing issue:
After changing target CC options to -Og -g in the Makefile and building U-B=
oot the debugger doesn=E2=80=99t show the value for the nand_chip structure=
 and tells me that is has been optimized out.
Also, I can view all values of the MTD structure, but the pointer to the ch=
ip structured shows the same.
Marking the chip structure as volatile does not change the behavior.
So, why is just this structure optimized out and how can I fix this?

BTW: I do not have such problems debugging U-Boot 2013.

