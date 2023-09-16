Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DA9CD37BC
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 11:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82EA4866DC;
	Sat, 16 Sep 2023 13:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694864672;
	bh=R9S7Rwsa0pDsT4PJvXKuMpm2aF3v4LYpPlqpfV3KH6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UAp4ue6UVgB192M4PmgHFsyA4xtljdK6xk5p52uRshuonpt+VpbV18YAaeXjtOQPv
	 Zle7dUYIUFDXGXX80BUcMNnOwBriBwl4Ha+Wf2cFtH+60/hgazykhUSgmZFRBE/hh2
	 teEA/XcOYzI7TZEBk2c7zR2kHLEGBgaafcUdZvTzSAOkpfKYndXgqSxPd2UpUnkKro
	 3GpHC9lBwIieHZmAoa2fU0ePVKDX5OcXlSZL07aVZNwq5bMe977QgsF78r9II3lQOs
	 QWTerkWyNJW5gijrT3ioE3zvV2VFlDMkJwc3njTLa+gaS17ibG2dcr9tXj3b06jQUb
	 xNews05XHmZNQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BACD686672;
 Sat, 16 Sep 2023 13:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1694864671;
 bh=R9S7Rwsa0pDsT4PJvXKuMpm2aF3v4LYpPlqpfV3KH6s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wQ2Yw8wD9n4ND5N4ZjD3sEglRkD5+qFXAiS90veCy62F42tzbsV7koCdOGkmNnP/w
 kiXoHB/EgH6NRCLDsO3GFT9DrLSkqOn81z6HbQvP259Qw2Wje99MHCUYtZ/B82VU1z
 OLgg2uY5w8pj/RTxAnV3P3Jd8YkFF/v2utE9Rp2drUAmGyGyudjCHHkuhSyYCVBOux
 gUZGKpKKvqqC6DmSAdcjkULJbEK97Y+nadXl+KdNtnFf8NIAL+tidKIIlsAa2eH7yL
 XA/2wkNab6KQUdEPKavgczcZDn2xt0TX0cprGcwYYHcXW1WxU0UpcKipeiWjhlX+w1
 7dYvUCec/Lz6w==
Message-ID: <fca28e8d-7bec-ee90-2bb6-8bc8928363bc@denx.de>
Date: Sat, 16 Sep 2023 13:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] USB: gadget: atmel: fix transfer of queued requests
Content-Language: en-US
To: Artur Rojek <artur@conclusive.pl>, Lukasz Majewski <lukma@denx.de>
Cc: Jakub Klama <jakub@conclusive.pl>,
 Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de
References: <20230913150058.38972-1-artur@conclusive.pl>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230913150058.38972-1-artur@conclusive.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/13/23 17:00, Artur Rojek wrote:
> In the existing implementation, multiple requests queued up on an
> endpoint are subject to getting evicted without transmission.
> 
> For both control and bulk endpoints, their respective logic found in
> usba_control_irq()/usba_ep_irq() guarantees that TX FIFO is empty before
> data is sent out, and that request_complete() gets called once the
> transaction has been finished. At this point however, if any additional
> requests are found on the endpoint queue, they will be processed by
> submit_next_request(), which makes no checks against the above
> conditions, trashing data on a busy FIFO and neglecting completion
> handlers.
> 
> Fix the above issues by removing the calls to submit_next_request(),
> and thus forcing the pending requests to be processed on the next pass
> of the respective endpoint logic. While at it, remove a DBG message, as
> that branch becomes part of regular flow.
> 
> This restores mass storage mode operation on Microchip ATSAMA5D27 SoC.

Updated subject prefix to lowercase usb: and applied to usb/next, thanks.
