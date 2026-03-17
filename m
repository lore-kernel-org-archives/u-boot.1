Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD0FB5EAF
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 05:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69FC8840B5;
	Tue, 17 Mar 2026 06:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Lqfrjfc0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IoA0s2V1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47A7840B1; Tue, 17 Mar 2026 06:07:19 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78DD84056
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fZg1d0kZHz9t1d;
 Tue, 17 Mar 2026 06:07:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773724037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFo4dnWQ/T9gMdIV1qZOedvixcd71N0fSw4ONbNXOnI=;
 b=Lqfrjfc0Fmiz1kf5zaZ1YLfIgRdKiYRplg2AuhEf2pUS0E4ldnjB7S2YklZasZQtGH9iF+
 0+3dvXSTKMPe6WrixAtqrjg5oI9tF/QcxFZaRGDUw+4fITOY/y3thWdBhQSXp4fGVZ6rG0
 bomeIbjX7W/LDls3jetUK+mmY4ueHqwGm25ZXAZlTUI7YxfwdNO9/xYBOftfJY2HzkmToX
 VT0IdL0eGBRjzYL37ViiL6jP6L42MoZZFTXY9kUxzoY0um51PRNuRhah2FUs1EBgaiXtKk
 Hp8eTIRDt9u8GlhGayOO4aE1PeZ/QExBmdY+1BlAq/ylwSkF8mwulCKEMMMwnA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=IoA0s2V1;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773724035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFo4dnWQ/T9gMdIV1qZOedvixcd71N0fSw4ONbNXOnI=;
 b=IoA0s2V1AiMuG7FgIZuZCfbzm+hbUMTA0MHwzZeeKqDTYjD4LS7PPBwro52FzxoX6ZMjCk
 zDzq3Bz2zI2HY8fFWZQO964Pa8CVzx4HpEB0JphjJx5ikB1eXOKiY/CZglLCw1cCrZqphp
 iBUuDCs5VSCoGfUn5BgwR8DmYP0bVsicy3jdvbeYeEz5kOXo0VIfYOwPE00Y26+PdqdaSa
 ELx7nMhmmC84DcweuQbax+yU8wJTf0GAwmdCtTc/sNsL2B8/8n94Qqvt9zt5PACsIXBIx+
 2AwyW1pduZKmX37X1GOhdDWnAnRy2uv5IB3AGBfHKDYEhM0tYatXYi8LB/4tKQ==
Date: Tue, 17 Mar 2026 03:34:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
References: <20260317012433.4162524-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260317012433.4162524-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f8377575e112389ee46
X-MBO-RS-META: yfn11bn1fpt6zo4tsof76711qcmduycc
X-Rspamd-Queue-Id: 4fZg1d0kZHz9t1d
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

On 3/17/26 2:24 AM, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue around
> USB_GADGET_DUALSPEED. It is possible to select this symbol (via
> SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency. As
> this is a hidden symbol, move it up within the menu.
What is the issue this is fixing ?
