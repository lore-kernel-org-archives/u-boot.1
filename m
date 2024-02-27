Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906E7C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0574887FDE;
	Tue, 27 Feb 2024 16:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IR+eHVke";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W2iKHR23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A767987FE8; Tue, 27 Feb 2024 16:55:59 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D7A87F73
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Tkhsn4b2kz9sWm;
 Tue, 27 Feb 2024 16:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTCpb1otYYx++XG/0kYQfD2dYd/fwYdTKhe0awymDnk=;
 b=IR+eHVkevkd3k7IKV2disfjBzd2A6EIuIze3zAC+NV4QbpXxKGk9eo/0uAp662Hjwp8oTr
 TNsNeJeIEJfdMN87IH4yfgXav1JriT8XrM9Xlc/2q6A1rZ5aWts7UHkrNO7FqSwn0cETT9
 q3G4bJlNIoAABuZxTJD41E8V6mqF/olCwAaQn2CtFahhlbJke09f2pGIVWBfQt1lBrxn4L
 fnihKM7t/UxOM7EQSeFUAVn5nc9VtYRQLSnbyX/cuwAvvcVt63eRBbjaNPVJkBaBlr2FC2
 /pl16DLc/oGkem0tnji37h0+f5M2q0cH9Kg2HlO7dvpxi7sIvK9T+MdpCodxeQ==
Message-ID: <673bf670-fbb8-4cf0-95cc-22a1db4451d5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTCpb1otYYx++XG/0kYQfD2dYd/fwYdTKhe0awymDnk=;
 b=W2iKHR23SNXAWMlNSGlenIy7m2X46Ky+jJK6kqfY20GOLepaR1sh28DE79OmtokZzgdmOu
 T9gHu3T7nrrwWQ+3TXImiJyW4VlYoF5dCBeGKyFMeE3as4pwKtRnlNEj4M0By+6i3TnmTv
 V7rd6HOLLG/96vREnoq3GU9sduraPjPeB054ZKs0fdyCRPxlx8kz+YKea3gf2CeySe8U4o
 AUVQxm4/OZ3305bkpiSxSBvfqguD1u9vC8mc0hnoJWsnZ5QH0zdq1wdjwaxq6vusvdrU2O
 eW/PxgbHKt+TH/vQhi5U2LqzaM3haK5x6R5XaUNJ1NhDv9RNxNCreQM9k47dXg==
Date: Tue, 27 Feb 2024 16:55:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/7] pmic: raa215300: Bind sysreset driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
 <20240226150536.1690-7-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240226150536.1690-7-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gb7ojk5x6kf7niuadprsje1a3boottuu
X-MBO-RS-ID: 21c58fb5620250ed118
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

On 2/26/24 4:05 PM, Paul Barker wrote:
> If SYSRESET support is enabled for the RAA215300 PMIC, we need to bind
> the raa215300_sysreset driver as a child device of the PMIC.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Marek Vasut <marek.vasut+renesas@mailbox.org>
