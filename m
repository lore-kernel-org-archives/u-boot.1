Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BB7CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 13:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3DC680325;
	Tue, 16 Sep 2025 15:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o8rDpnxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F8D683071; Tue, 16 Sep 2025 15:22:41 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18A08004F
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cR2d86jG2z9v3B;
 Tue, 16 Sep 2025 15:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758028957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ja2cWj0xMa++1CfQxWC4Q8oGeTPLfTtFS4U5+dTgi0=;
 b=o8rDpnxb7f/47wuVKy7RxZvwu3CKlcIZswXdrFnapANpScgUfYqyn4qDtO0JdDEwFqRmxt
 K+jJkP6bDKEYcUITF+o7b3rY2bVHGdiMEMaV2UGQ4ua/KWAFWZYSCx3AW97qM3zpB0XQEB
 yYJBgHnLXOzCKm6SFqPUXd/WSn2GUXj3UrlI0IDYNr4z73iFzhBPTaO0dpp1fCEkjgXZGw
 7k1JI4c0RKRo8Bc4iT0zMCthvdqjvT80mItDddQ9vfaZ8b0WJQ5vZdmYoix9lpSx85azX7
 hTjNUxGZR7vbi8zwKaCkN7pUjFic4S4Q+i/DKW/FaCUuy2E8ZLjKD9GoL4o5Ww==
Message-ID: <ca0e375d-2ce7-43ca-b770-9ed3691f30ad@mailbox.org>
Date: Tue, 16 Sep 2025 15:22:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: onboard-hub: Make i2c-bus option
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, fabrice.gasnier@foss.st.com
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <68478821d089fcf68a841dff4b0e303721442e70.1758014760.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <68478821d089fcf68a841dff4b0e303721442e70.1758014760.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h3niqayxcnx8dn693a33zaq3owgn8oxu
X-MBO-RS-ID: f372787d2cef71eab10
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

On 9/16/25 11:26 AM, Michal Simek wrote:
> DT binding doesn't mandate i2c-bus as required property because hub itself
> doesn't need to have i2c connected.
> It can be in standalone mode that only power regulator and reset should be
> handled.
> Or hub should be configured via spi interface.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
