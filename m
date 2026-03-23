Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12A5F4613A
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2A084082;
	Mon, 23 Mar 2026 16:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hSun5JsN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Qe2XZAn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7C1841DF; Mon, 23 Mar 2026 16:05:50 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A96368408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ffc1S2T0tz9tRx;
 Mon, 23 Mar 2026 16:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774278348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS8TDLTxeCjCMWJaDxKaiTBDkblQTmCq8Da24g5JUMQ=;
 b=hSun5JsNVv3TheDvqsXqRAJnt9/OOGCivlb/MksqlP4H/YcQie3Z+AQMCRU6a3aj02myG9
 df0Y8oezRzHVOWJYGGC0O4YHIr7K4Rta+pKvRKtmrz+BHyt3Fy/BZYsYzokeASW/HKTra6
 JTquZ9eTtUqrXtuPDS8ts0Yz+SyPwXa5yyyPt5A2mOUD7Tus8UrrC+3TWOrSk0eOqqfDxA
 Xs8WX70Cd4mJy9bTZH7PrDb8/Rna/RutFGljAVOvXQiBhtpXiVpT4Kb9UU7x4tzgLiowYm
 N5taiGtpTBANbsyvjsdFj2l6SSQG8CYXmfmZ1LM77NsRWcaz6a21OokqApCXCw==
Message-ID: <9fee707f-f641-4acb-8c4e-98a7ae979173@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774278346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS8TDLTxeCjCMWJaDxKaiTBDkblQTmCq8Da24g5JUMQ=;
 b=Qe2XZAn3nRjw7VZieeWl+vy6KmXN+03A0M9FS/n+q6JKfiVmRFjYLLCXIGwEpTUk5O2lgT
 ZOmlTU2scz6ZtKERtHYU4yxu6+dbH679W72ygkaUfzhdWK6o0fVesa8mVFWvDLBjwpSjXv
 iPQFE1z0CCVI/B9HZFGITRFPE2/T85UiwH0c/RRiQayxJKNrJGRGPXM1rPIDwLkswgLXni
 6AVkr06N9JPy6tJAyUC7Sff115YzFHaYMDkkoACSxmzCUaTEnn7ZFg+GBnn6Kg3iq3DG2x
 n1QWhkxVJBQLERPsFuOrRueqRIeoYZ3AUsQq6+BQqZxIm5fTfE1slAbnebqw6Q==
Date: Mon, 23 Mar 2026 16:05:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <20260323143253.2272167-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260323143253.2272167-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4ab03269538d9f3b0de
X-MBO-RS-META: wb6944ach5eyxz1ibgpgeeebxrfxbbp1
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

On 3/23/26 3:32 PM, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue around
> USB_GADGET_DUALSPEED. It is possible to select this symbol (via
> SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency due to
> how this symbol is placed today. Move this to it's own section of the
> file guarded by USB_GADGET || SPL_USB_GADGET.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
