Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D363CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1F584659;
	Thu, 28 May 2026 08:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="NgfjTvQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FA4846A5; Thu, 28 May 2026 08:46:08 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0952803C6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD60711327E; Thu, 28 May 2026 08:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779950765;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=0Pwbrk6SpOsXTf/JFQhcjhiWBsUyEL0u3KP7k3beqrk=;
 b=NgfjTvQIbWCrUTYl+Y8qO72ZGhgJ+Q7W/to8HcL9u1qssckQsjeaqhtDAK/aU4AgIVNVif
 pUR5qKtiUuTPXNglrDKSbFdGs3p8hRmrf7u6w8ayN6QSz+PS7+9Mhq+UKg5WIPfgV8Ye36
 SXxmUCJIWNytNNQkovx6BhsZq07stmUhfezU29FaJixlOXo26+Z042wVcqh4tgzXVAGvTO
 ikx9aJL1di5qyxM5ex9NcFhRBCp1zZKPDaf8h7pQPtu2bq1BcyXHuQDn4s0cz3cuqWdOCy
 O0cIztX5syMhMXo5VIZI6H5Swgq3JnmKJj3b1f3LeVT2p+Kz3xb3Gazo23S1Tw==
Message-ID: <307aad15-8285-60ce-f7e4-39bbf09a333c@nabladev.com>
Date: Thu, 28 May 2026 08:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/6] net: qe: dm_qe_uec: Use dev_read_addr()
Content-Language: en-US
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
References: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
 <20260528-devfdt-net-v2-2-dc6f20b82611@nxp.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260528-devfdt-net-v2-2-dc6f20b82611@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Peng,

On 28.05.26 10:00, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_read_addr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/net/qe/dm_qe_uec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
