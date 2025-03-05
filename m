Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226ECC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 20:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88EA80ECC;
	Wed,  5 Mar 2025 21:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V2HHuKLn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q6rCj669";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60418121A; Wed,  5 Mar 2025 21:34:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6FF80BAA
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 21:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z7PRV4wtyz9tnj;
 Wed,  5 Mar 2025 21:34:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QJVBAeb4zjuAAwC8qtiFEKkZ3C3WhYgZBnfiOpOei4=;
 b=V2HHuKLnQ3bdrcnumJZ8VMcEy94RjnJJo/d8UrcLDg2hlDFjfq3q6cDr/WkRlRleyW6Zwq
 NEop/NLBbGGu42PZf1S+2+oQafXAnXuehzWVjWM+qss+XwRs+PY0pSUqciF9yrUsE1elWI
 w+YcHOyyt3wDezR1i5/qR3acJEQO3dzH0HQtGZGZ2lWKG3/DokSmWDjEKsuLJ6FGatch/e
 68UnT6sqVHK7ITdBzSeUh85CEiOvTDK3kAdJQFycDlYEHdOVPO1zZFU+mVg42DrORYmVsh
 nuHF9VEc/GNIJFnmqzfJKDH6Sy2FSaC36IeNtfFJCmN07qkVviypJZ0bD/4nfQ==
Message-ID: <2c028ec4-93c7-4810-a618-0e6b392c853b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741206868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QJVBAeb4zjuAAwC8qtiFEKkZ3C3WhYgZBnfiOpOei4=;
 b=Q6rCj669b2N+v2xMxvh3n6JcF3PjpfysBrbBLVUrWYk2cr46ufMZ165ryNTQWH4HL0IDIM
 0YaHCx8+ooBlGNeunz+QE4jYbL9MUHmgP1CCm7mn1owKvm8/dIbGZQ5iEy+D4xziWoRIH4
 MdbKkslOMtUAjWk3oIxKAInOexv2nkoCs/+y9oRUaAsqzfvNMaSRypIUgxv6dEhQeRWGrO
 73ER6fLDkpijlO+hQjc1pEp0b0KU0QpJhrBFLswpl/AGBHrnzoait0nUJapQUqlbWW3Em0
 XgK5NWcwDkpyTUouSz38Y6jiPfP6enU3TPAwh7nH26S/cBBrmTIlBzTxWnaaSw==
Date: Wed, 5 Mar 2025 21:07:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] regulator: rzg2l-usbphy: Add new driver
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-3-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304163736.89326-3-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 62bd1d3a3a2365bf806
X-MBO-RS-META: 7iejjsbggrca98fcpxnbmwqnopazr173
X-Rspamd-Queue-Id: 4Z7PRV4wtyz9tnj
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

On 3/4/25 5:37 PM, Paul Barker wrote:
> Add a new regulator driver to control the USB VBUS supply on the Renesas
> RZ/G2L and related SoCs.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
