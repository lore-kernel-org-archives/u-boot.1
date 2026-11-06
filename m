Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90762606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WEAuKCtW;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gjdphiRT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2708A8135F;
	Fri,  6 Nov 2026 16:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fv_HpaCs19BW; Fri,  6 Nov 2026 16:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27FB88132D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980973;
	b=FfDJOl18el2K1MX8VRKN2pggz+CH/tnC9tetWTvz5i0GyaeWiqKgr2fPImvrNMjR+Vsf
	 U/qdhxvpN7DK9vvDlTGe/e3svriNcXnZi/7WrQ/wwO4XqRsR9d3EHb0p+cRmfB9dz5sed
	 8tznQNnqKZEndKEm1JoZ+BJLKwAdKKX+8/uXxg6N/gWLL5Xgeoqq1SeQEGnCmPrudj579
	 OxTQwn4Rsds0pcB/doHAp4fnyc6bwyXgUswId7oiRVJ73LZ9xaKP6oo8eD/mndUtjSaAy
	 Ze0ZZl+HXhOcXqwgoMFOL3nAWM8K8tRrzw1BDLtQDNnzUDLCZzhNtzwNye5mim0T1hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ov4gkRTEUevtBZURMOoLcxtdp2hIU6NbWiekHhXytAg=;
	b=RA1cN2k42VgJPzPSB//yM1h2VgabAQAibXmnJh4NZfHoGkZA9SK7YUYjrsGqAMy/koS7
	 cXERL6mWKwh5ubLc8m2VE4VsqMwAlV4ClZ1JsyWGKzKomd/27O871O9k9ORcP45r+0jbC
	 hGUkaqekdYYvL95nULZdpvp7gi1UAPgf8avrPbp7h2C9UIaJ1aGIbwpJkbr+oGh/oRJxW
	 SFCgQ5GhbNzCiPLxYigYu55xPdCzaD8zq9a5jJ3wwbK+78v3x/utvvERA2V3byXGcA49a
	 NrcemGiB0Xs8eX5Hr2CcYrV/rQz7aGVdy/zoFAvWPnbCzCIwo3d3sIBJ5grr39wetMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980973;
	bh=ov4gkRTEUevtBZURMOoLcxtdp2hIU6NbWiekHhXytAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEAuKCtWZVjMi4OaqCoxMaAIixgDAVsEsfuFFytZYLan3xSsVCGyYeFLnMtsMIG8c
	 fsshPEaSKAPaY3hLPmXF/ZuKZ79rvuy4AT37a4pOU9BrgT37s00qnMoLrESGNO4lPP
	 6/jYlrkN41LuCyILT84uSlo+RjzykZeKYNMULsNTCjebAQPuQQEbDXY3oEGXqYki9F
	 9b+pot83yNZ8rzOXko37N9XmX3iGPSLEl6c7VyUAMx/scwxNWuRoST5NBPi0XBNzL6
	 vFFE9HESpencKd9C9EhLYtXK99iC3Cvk5TWiXN3+JGa4skgJImn0JwXUf3Pv4KmN+b
	 KKujdov00AHDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27FB88132D;
	Fri,  6 Nov 2026 16:02:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4734449B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38CE0403D8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fk0JG38CsGuD for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3983D403CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=gjdphiRT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3983D403CB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:46 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jLkTv2475zMldj;
 Fri, 06 Nov 2026 17:02:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ov4gkRTEUevtBZURMOoLcxtdp2hIU6NbWiekHhXytAg=;
 b=gjdphiRT7lCTfBlYcaZ7E1zgQ1X9WKF22WQ14O3qy5Vepni4PrQRjsIRanyzkAKXy/R+MK
 juFbppWyi1/JVtrom8v2S2J0X9xS9jWYrE4Cu+i3jsm829/PekacZWn2TRnlGmPiTOTNW7
 qEs0XPWHXy29tEPyebCHZkYcI5OmuVz5LAq0RQvLAergj/QuMANrMoxj0HveNtBG/+2OJc
 sjsWgQG7U6WyDwN6QIiX7r+pM+z/h7TVRkdmFPxKEwnbKrluq//I19fX37i/O4+FVqFPYr
 9E9q64GZns50G3vNY2nK8vlzW3GYOvUuNAP+oZE7jTUivb2nRAfJqsi6UXj7aA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 5/9] watchdog: designware_wdt: add get_timeout operation
Date: Fri,  6 Nov 2026 17:02:31 +0100
Message-ID: <20261106160236.749429-5-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-5-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-5-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f9xis9hgubrhctqkp55bk1y833ypxmkf
X-MBO-RS-ID: af74de25eb2c3e08787
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 06.11.26 10:34, Juuso Rinta wrote:
> Implement the get_timeout operation for the designware watchdog driver.
>
> Add defines for the timeout shift (16) and for the mask (15) used by both
> the getter and the setter.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

[...]

> +	top = readl(priv->base + DW_WDT_TORR) & DM_WDT_TORR_TOP_MASK;

This doesn't compile (e.g. socfpga_stratix10_defconfig), the define
is DW_WDT_TORR_TOP_MASK. No need for a v3 because of this, I'll fix
it while applying. With this fixed:

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
