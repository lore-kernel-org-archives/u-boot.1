Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D19EDEBF3
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 20:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C9383E7F;
	Tue,  3 Mar 2026 21:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e7w9swgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B41383F64; Tue,  3 Mar 2026 21:37:15 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A7F839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 21:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fQSK31X2pz9ssd;
 Tue,  3 Mar 2026 21:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772570231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gx9MmrgZxCqM0U1FmBanKT5cwSzxKHklWIsmD9kQdUA=;
 b=e7w9swgFPxOsm+scMzPxOxA1MLyoQ4jAeQ4ekdjga6FOhvFAvwk9Io80Hjd/XcLuJsxCE5
 9KfsnTafoiktBEvRB0PUDFXTY18Hgxm6dL/weI/cuXc5TmpUre9OkyOT5FQSei83Em4lM0
 Me9LqSjqAsYnbHKs2Ff+mW/aahOvnmemyDu3neSC/trAscP4ZYLE9zIonrT8ucUp2PbquE
 FB4uIANIn4h/vGsPe+ip74fej10arUs2spbr4Wq+Yhoax4UJ3f6kTaipx5FHt2xZr6cV1f
 K76+PUC4cWYg6RIIj9goQb2jBS8A+H1+unILakzLp2R9kiL4sEsv4dOfoGH8GQ==
Message-ID: <6f2b7ff3-2b59-4b63-8021-0d7be790e2b1@mailbox.org>
Date: Tue, 3 Mar 2026 21:37:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] usb: Convert ad-hoc poll/timeout sequences in
 usb.c to iopoll
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
 <20260303062503.3392544-8-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260303062503.3392544-8-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2074bcaef2e79421080
X-MBO-RS-META: w1gr3b7b7cgzspbbtgzn5t1si6fkijsp
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

On 3/3/26 7:25 AM, Ronan Dalton wrote:
> The usb_control_msg and usb_bulk_msg functions in usb.c use a while loop
> and delay to wait for a USB control message to be processed. iopoll
> provides a macro to do this for us which can be used instead.
> 
> Replace the while loops with calls to the read_poll_timeout macro. Also
> add a check for timeout being negative at the start of the functions and
> return -EINVAL in that case, since a negative timeout doesn't make
> sense.
> 
> This also fixes a bug where usb_control_msg would check if timeout was
> equal to 0 to determine if a timeout occurred, when it should have been
> checking if it was -1 instead. This caused -1 to be returned by the
> function in most cases when a timeout occurred instead of the correct
> error code of -ETIMEDOUT.
> 
> usb_bulk_msg now returns -ETIMEDOUT instead of -EIO on timeout.
> 
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
