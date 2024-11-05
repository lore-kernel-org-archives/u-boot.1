Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1554D31761
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC1288FD2;
	Tue,  5 Nov 2024 17:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9DD789001; Tue,  5 Nov 2024 17:20:13 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B702E88DFE
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter@korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6364A60008;
 Tue,  5 Nov 2024 16:20:10 +0000 (UTC)
Message-ID: <649bcf3d-5d95-450c-8c0e-149092faa299@korsgaard.com>
Date: Tue, 5 Nov 2024 17:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot/image-board.c: boot_get_fpga(): pass compatible flag
 to fpga_load()
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
References: <20241028165557.3061852-1-peter@korsgaard.com>
Content-Language: en-US
From: Peter Korsgaard <peter@korsgaard.com>
In-Reply-To: <20241028165557.3061852-1-peter@korsgaard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: peter@korsgaard.com
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

On 10/28/24 17:55, Peter Korsgaard wrote:
> For E.G.  signed FPGA bitstreams, similar to how it is done for the FPGA
> loading from SPL since commit 282eed50ecb7 ("fpga: pass compatible flags to
> fpga_load()").

Ups, that should have been commit 71f1a5392aad ("spl: fit: pass real 
compatible flags to fpga_load()"). I'll send a v2.

-- 
Bye, Peter Korsgaard

