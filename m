Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0595EEDEBF0
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 20:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C2F83E7F;
	Tue,  3 Mar 2026 21:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="J2OaW/VX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FB883F61; Tue,  3 Mar 2026 21:31:47 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C01839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 21:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fQSBm0Ghfz9vCF;
 Tue,  3 Mar 2026 21:31:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772569904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1FROsNBM87QvhEbbWy+3QiUPjF+iaMFF3DIjEy9q5qY=;
 b=J2OaW/VXj2QS0HVvSL28E4+jfpsBp/0/PpOXEjmvZWixoA7V1RvHrzfN2Zg72FTmHKyTiV
 BXBT4twMWMyJstf/Q1+Lv3+gDhzaZso705Dmil2jfAhcVjxNbZpXeb8RfJc+YsfUywWsj6
 d8r2UA0KpfVUpthK8z+5X82RXiWR4ZQ0qTPQQe5996P7kxeKZraPzo1nwKaUz8qzCFXU2/
 MWbj22YW8Ar5CdeZbHoiNFOGi3H3srDJbgagIUFAu03joMAI2TtbVt8lkg/VcL6FPVvlgh
 eoJk1BQV8QjmTQKqSTYDjA8srDlok/W1XEpl7w3eZkGqcIf9bvX31xPtzvQ9lQ==
Message-ID: <72b88d4b-adbd-444e-a4f6-7109fd59992d@mailbox.org>
Date: Tue, 3 Mar 2026 21:31:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/4] usb: Add code spacing in usb_bulk_msg function
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
 <20260303062503.3392544-6-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260303062503.3392544-6-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a476d3dec09a0039178
X-MBO-RS-META: 6htepha3qtes7kpii9ugebycnbi4is8k
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
> The code in this function is bunched up with no spacing between logical
> parts. A following commit will modify the code in this function, so fix
> the formatting prior to that change.
> 
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
