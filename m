Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BC9D3B7D8
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B642895F6;
	Mon, 25 Nov 2024 05:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IF/Pkwv5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g6pBfYqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFE9895E3; Mon, 25 Nov 2024 05:59:53 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4790489468
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XxYRB67WKz9sZL;
 Mon, 25 Nov 2024 05:59:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1732510790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpYoWf1u+J6SfcPZWY/TGGS6V91QiK4yh3IIPYabBBE=;
 b=IF/Pkwv5SVqKbgOcKhit9iGTX05qTFft1MbzB8ndZhbAjF188C5+UOK4ycV6yUXUrWRuHX
 AW5fiGB9w3gCtH13mlcTswivdQ4iYa86LpXpulHCYcPxSJ9sDvfQjI3GVBwVHdmwT9htdK
 SNPIRWd465X2Fo2V7NevdNqdupOclS0ywIoWVy7faibSTefnoe+BkL4Z91cTx77feYyoaD
 Se0N00grO/IB47JCKSrL18XAaiVeD27jsIGRe/2COvKvgFGT0yqoM02A2WH864fJk/5lPX
 DhdVMeonEECOd3aeIztwYJMt+/xkFGSJx8XDGVf+Q8VJ5WBjDzbKrHvWcuoxTw==
Message-ID: <d52a73b6-54fd-4f73-a826-e3cf287d69a4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1732510788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpYoWf1u+J6SfcPZWY/TGGS6V91QiK4yh3IIPYabBBE=;
 b=g6pBfYqyzuqmUzNBK4IFKngIiGagDagJpIwS04SMeVFp7jpvZbwe7adb+52ZopVNguWWlP
 PvNychqdZfprzjQsl90Amw71Jh+hB+zZyGemkL2nWzsMgMrTFbXTgcQYAKfIs4bQMW8Njd
 gdSzzhrfpUyywKP2lJ4RYw+a3fIvz+aeD0bfvZCfnYyhFEyHD+fcRMKIrVO2vZBdC0jvWN
 +fVtyZ4rco62i/WWIDxY4GnTPGiMCS8PmpkHQ/vk0gvGGSyFXovUqnGa4obZ+B1GaP8FKi
 d6Opq4af8e6aaKuLcI/v/g0AKw5XLhWwBRa3BGeJ2OvfeTFt7ipY43o/duGX8w==
Date: Mon, 25 Nov 2024 05:59:46 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
To: Dominik Wernberger <dominik.wernberger@gmx.de>, u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, jagan@amarulasolutions.com,
 michal.simek@amd.com, tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com
References: <20241123214708.44405-1-dominik.wernberger@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241123214708.44405-1-dominik.wernberger@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 902ce510fafbb96edaf
X-MBO-RS-META: zx9fd7mta9fuyq8t161z6kzcz9mwit9t
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

On 11/23/24 10:47 PM, Dominik Wernberger wrote:
> See https://lore.kernel.org/u-boot/20241026201741.171073-8-marek.vasut+renesas@mailbox.org/
> 
> Signed-off-by: Dominik Wernberger <dominik.wernberger@gmx.de>
Please add a proper commit message. Links go away, commit message does 
not. One liner similar to the subject is fine for this particular fix 
commit.

If you could even add Fixes: tag , that would be awesome.

Thanks !
