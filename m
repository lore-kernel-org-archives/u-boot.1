Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1075C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 19:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9871E80E94;
	Wed,  5 Mar 2025 20:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xpFK0alA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sSUTG9Sy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0550811C1; Wed,  5 Mar 2025 20:56:22 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E722D80FE2
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 20:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z7NbS4ZkCz9t7y;
 Wed,  5 Mar 2025 20:56:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymCXT4Fz/cGkTkuzgRrBpD2GV3c9zDBmsxOH46Q+ET4=;
 b=xpFK0alAuTnJHGUnssBXvXV7zVzwdTsCWvwVXrAjE2pKdlhyWRwLMCfjzF+9OaoUVDb7SI
 AXpdpRjNUlO9BwbP5FptPgMZCEHB3y7Mv2yVIH5Ld8FEPMKm09IaOtQRwlYxJU2xM863bR
 /mKjzpCk3ofgWD9EwaCk1UQYiF+EohDfMwGVyFMdRyIUOng2qlRG+Cp8z2rejeTt2OkV3b
 qebd50PeI6bm+/ccN3FKWib2ecPvPCHS6k36vBQCSt9RfzmqJAL8NQRiXk5pp11hSOThLK
 b8kVcM937hr618KevvQjuGjzukVbtbtSUPOGhPNTr4No9puAy7EaE8s1F200qg==
Message-ID: <f3374568-3902-4327-b091-83e2639a5f58@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymCXT4Fz/cGkTkuzgRrBpD2GV3c9zDBmsxOH46Q+ET4=;
 b=sSUTG9SyvPgtab2BaLuQLPrwyHHj1pdt+PNV50c8Z1Ayyth7hMMyVVMX3v/cZ2yXud86yh
 fwYNdSrpbvYd2/IXX0mgkYSdgWAVtaPoUNjcpaQA9sa/QCF/mTVf/Nb7f703JiHd9p+ii3
 +MTpR20z1VO4SRGl1dwZFz8cdfwWS7hlHiH0JGusopWaBka+0tuk3idotY7bedrF33UyTt
 xmOSfC/xDGxC084cBoAaclFOZdZI5kXXNrbfFtWBpuRMCbPbtEi47/nFcoNNNqEISn6wQ0
 Nux+A5nySZxI3h/25PPWfXR0UbwPVgU4avXwC7hhTQu5eKJM8WFIC+iCjs0sMA==
Date: Wed, 5 Mar 2025 20:52:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] net: ravb: Add dependency on CONFIG_BITBANGMII
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
 <20250304200712.92514-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304200712.92514-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4a2b335edd4aaa35abf
X-MBO-RS-META: myrfbcb18jcyenzgbxdmssrgcpsmhh4h
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

On 3/4/25 9:07 PM, Paul Barker wrote:
> The Renesas RAVB driver always requires bitbang MDIO bus support.
> 
> Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
