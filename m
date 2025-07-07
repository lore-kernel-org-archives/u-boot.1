Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26544C83F0C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9A2830E4;
	Mon,  7 Jul 2025 17:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LkyaWt9n";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dM122a6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49CE83189; Mon,  7 Jul 2025 17:26:31 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04711830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bbSks5Qz5z9t2V;
 Mon,  7 Jul 2025 17:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751901989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGuParIQjFcKti7vwqf3GVcuFZpF6IUw7ft1/7gB5cY=;
 b=LkyaWt9nUGKJxvW9D3i10usve1pHZ5KRGV4fcHkPt4I7fbhhoXvFbb5YdikyoydD//uBRr
 QYh4NphLifwa0uQT4OwMeZRXQiVFCyQITFpQpIdAxp0CzSpZRmAy0ScXH4GQB/LhKKCER1
 3+yPEX9+CJOHTY0ZQILplSRcuu4i66PqAz3gr4aWmtxAeQBVRdfyJHvsYIaWta7f0BFTxQ
 cwL5vNwQLoJ/14v6pp/vQNXroycUatPimngQALrrOoxIx9al+ilAxUr6BVlFjJ0jya3yOG
 /JLc/57rY/W7mSqrq62ZtlfWzidFpKLYwzozKOjMtMwXPrkvdBSc81nCvsWYNQ==
Message-ID: <42250b5f-ef4b-417d-936b-ad2a9f96d783@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751901987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGuParIQjFcKti7vwqf3GVcuFZpF6IUw7ft1/7gB5cY=;
 b=dM122a6s705IQq7OI2I86oaJ92lz7bNzHKPW5cpnx9tayGIeKYUpluTIqrilpBbtX7iJo8
 UFETSc8jJJAkusrVH63aBiP31wOSyayMONu1G6TqT5MwEb21iCqTk8ieBuV3aUa9XXgV/E
 +8aWBRlvbupnwnGcZtPsCe73qXY9mQkzBDlL1TMvIvdpgaQlSGkl/aYnb1b458z6Fz2PAX
 N1O8CWtr3d9leWwp+kU8LLuXvS8OdVTInuzTKTT6tZdKUU81CxCxpcMlacZFmH05jqOGLz
 jPLVL3GvM0BI+MDDF6OrhWfFYyibeiC1aToLUZcHUo+uCTGLQSxIiUCyy7fBkg==
Date: Mon, 7 Jul 2025 17:26:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] serial: sh: Initial RZ/A2 R7S9210 support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org
References: <175135060199.63074.4714042121815587151.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175135060199.63074.4714042121815587151.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zcyg1nmt7y9my5yikid7rdkqty3ju5i3
X-MBO-RS-ID: a3aa1002d799cb71887
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

On 7/1/25 8:16 AM, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add SCIF support for RZ/A2 r7s9210 including a work around to prevent
> the driver from hanging on boot due to TEND flag handling.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you
