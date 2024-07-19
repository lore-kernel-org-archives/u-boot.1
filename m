Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89823C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137E087E96;
	Fri, 19 Jul 2024 12:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lANWZ2k9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B287D87DEA; Fri, 19 Jul 2024 12:47:31 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8045C87F51
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRFq3bfyz9sNY;
 Fri, 19 Jul 2024 12:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKBX7gnzAaJR4UMlO6PFthwDz6F3oXKQyZJD/SMoIKI=;
 b=lANWZ2k9dXFPTe8b7bAJx6+CEuTMlYcAaesbyGlihELjJ/fMlWOIOPNQbx4X5s0+XUQwux
 qprDvSbc8Eza6xiRSflKzYeVR5MQUy/EZ2o5ReELeXo59VOR4xJT0YXSSFKum2WF9vCgDW
 +t3bI1+hdIljqde08IoIHg1Jga5fpdxHcaO0fntZHnUJJnnzzz1qRMuFeL2JFmqlpZ0MXC
 gawejSpz4bOv3Zog6gUbZ+NfXLNQhgouKMz0E+a5jk4FGeWBbaGMafsk8D1HTLiHRuRvlA
 0FL2wVQwkvJkVWXB1/RVOsGJndxpe/OoDwWqvicrYdiVMLFu4KKuWK+ZLpIT9w==
Message-ID: <75dfe963-4663-40ce-97e1-c3401d414702@mailbox.org>
Date: Fri, 19 Jul 2024 12:47:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/37] board: BuS: Remove duplicate newlines
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rmfnzz34za7ho1bx9i3th7efos8ep6f5
X-MBO-RS-ID: 13313d429f58345a46f
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

On 7/19/24 12:27 PM, Marek Vasut wrote:
> Drop all duplicate newlines. No functional change.

Please ignore, my ISP sucks, I have to resend this.
