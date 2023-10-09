Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F96ACD6102
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BECE86D29;
	Mon,  9 Oct 2023 18:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ltec.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE4486D2D; Mon,  9 Oct 2023 18:15:05 +0200 (CEST)
Received: from mail.ltec.ch (mail.ltec.ch [95.143.48.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CFB486C68
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ltec.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=fb@ltec.ch
Received: from nebula.ltec ([172.27.11.2] helo=[172.27.11.35])
 by mail.ltec.ch with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <fb@ltec.ch>)
 id 1qpsuM-000SlG-2S; Mon, 09 Oct 2023 18:15:02 +0200
Message-ID: <dfd15b28-adc6-49b4-a778-0e1d66799820@ltec.ch>
Date: Mon, 9 Oct 2023 18:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/38] spl: Use CONFIG_SPL... instead of
 CONFIG_..._SPL_...
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-2-sjg@chromium.org>
From: Felix Brack <fb@ltec.ch>
In-Reply-To: <20230924192536.1812799-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 24.09.23 21:24, Simon Glass wrote:
> We like to put the SPL first so it is clear that it relates to SPL. Rename
> various malloc-related options which have crept in, to stick to this
> convention.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
> 
> (no changes since v1)
> 
For the PDU001 board:

Tested-by: Felix Brack <fb@ltec.ch>
