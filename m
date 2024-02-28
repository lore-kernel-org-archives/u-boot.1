Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2B7C5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 17:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9A388074;
	Wed, 28 Feb 2024 18:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KpigcVEF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wqzZzgET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A8468806E; Wed, 28 Feb 2024 18:41:38 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3DC5875E9
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 18:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TlM9C4nY6z9t15;
 Wed, 28 Feb 2024 18:41:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709142095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKA9T3acqqjg2N+cN/aF7jFw8W9BmlhpWedZMQ2/cpc=;
 b=KpigcVEFZMayiwR71yWCQLX5qrMQ6GSmzjslzGc0CVWsPLt78iM/COuUOHp7YeuQgQ7Pt2
 drDfBLeqKoszkNbe/pas7QMLFHQ1BQYqDtrXwLbSsNYod4ZCE98+tvZYq6gAbnUncTI6gQ
 4y9qrL0QHyGYZY53FDDv8idLbgkY+EGHJd/y2iBQqQ33U+BH8RqdETHu/kk0hmV0JfM9At
 NSjt9rWt5GXRcaubPOXg9dc2Sn8/QKDgkfG2TDJKdAjj1XALdtP4KHOOxJkSyCAnCvBHtY
 3k8QRty0h7HtSioXuSiRlagY595iLcAW1s2TsOATQ86Y/jaqYrpS6ToT21u8mA==
Message-ID: <70c7bb89-c1ff-4b6e-bf1f-036114c7d400@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709142093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKA9T3acqqjg2N+cN/aF7jFw8W9BmlhpWedZMQ2/cpc=;
 b=wqzZzgETnrNUBAc/2HEz/AF9aMKb/Cem31Cq9EI6KbFtU5dbpJm6z49UXpWMoA87tRhwG1
 qndgPg5LNo3efIv2WhkyT7VCJ7/YKl4fER6IQn4qrEFtFs5jRGNhkDyogZ2213YhzOySLH
 1wmbGnjsagIWH+5seOJrwesFk74vmKFspUcTAfsMRc2ohJNdIZJ8Eq55dYn4PW3N47oNK1
 9/9ed8PpKiz3b7XsXpFpNAKKATSH+t9bieKOKALvoV5HiV4nce+6XNkF4jxZnlAC6deT77
 bBMMs8O+dDCIALW8JOli39KYv5k9UYlXxJRahUQ31Imdh4GAaM0x94nPDFl+Ow==
Date: Wed, 28 Feb 2024 18:41:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/8] pmic: Add Renesas RAA215300 PMIC driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
 <20240227204035.3761-5-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240227204035.3761-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 37gad8d1o11gg49drkaszsypmiohwos9
X-MBO-RS-ID: 958d3c58f79f81e1914
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

On 2/27/24 9:40 PM, Paul Barker wrote:
> The RZ/G2L SMARC module is powered via a Renesas RAA215300 PMIC which
> provides several voltage converters, a real time clock (RTC) and reset
> control. A basic driver is implemented for this device so that we can
> read, write and dump the PMIC registers.
> 
> The raa215300_bind() function is added as a stub, binding of the
> sysreset driver will be added in a later patch.
> 
> Additional features of this PMIC (such as reset control) may be
> supported by future patches.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
