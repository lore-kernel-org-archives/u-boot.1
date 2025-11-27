Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84611CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3674842A7;
	Thu, 27 Nov 2025 18:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qnIO2QjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A0384459; Thu, 27 Nov 2025 18:18:15 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E746B842A7
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dHNRm0Qdwz9tJ6;
 Thu, 27 Nov 2025 18:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764263892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=em1ful1q2BatXiGiyzUCoNtfPy7huiJWZ0Wib5E1DuA=;
 b=qnIO2QjCBQEDG1dGav00mgxx4kbV1YkBIyUws8mbHW8qdlxsRHI6gQMMx4geVkNx8FCKKw
 hO+SKSTgbTaRiYSCcffjx7s1x0DSYdm663FvdR+EgLN5o+inmVEd+V4s70a1kDo4/09mmE
 DTRCjGRFo2Nx+Uht2m74JfbX+xtYwLfvz21grYyLheasPyoYBBRo3jLHujpDi5PynpGOXb
 1u7XAFilSu+1pxBPkDJVOn21wrbTz3jBD6o/I4wsAvCVvpYMPL1/3yoBcSr1vwYb+fDnJc
 ML8jNU1cf2ua8MW6nlj9B0vOnUOQh6mio93ta2eXs8uJeJdYJ3o49tXu8PC3Gg==
Message-ID: <fc7af0b9-dbab-4aa1-8233-31fefb7adb3b@mailbox.org>
Date: Thu, 27 Nov 2025 17:25:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] usb/xhci: debug message Register NbrPorts
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
References: <20251127160643.568577-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251127160643.568577-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 87ed1a75f4c53edd173
X-MBO-RS-META: nfa1biidup6hu3p4gw4keymaqnt59q7g
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

On 11/27/25 5:06 PM, Heinrich Schuchardt wrote:
> This is a debug message for EHCI. Do the same for XHCI.
Please tweak the commit subject and commit message at least a little 
bit, the commit subject barely makes any sense, the commit message is 
not helping much. The change is obviously OK.
