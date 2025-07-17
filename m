Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1331C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4449C83340;
	Thu, 17 Jul 2025 08:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752732108;
	bh=H2I3xXxloFSVWuziOeABiz3jgnCM4HH52URVUI4MqSA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xkbcDBN9QBNZrzXGQCfiz4zI6wqt4UyD8xaAP8S+y33U8z68D0Daw3e6Xis/HBF8s
	 73GsoAT8RW/NnkW4EWM6DCnOp3OWHoRg8UJDhofBjUm4mH3COKEWJqu5dSG7AOEcy2
	 6m0z1wdips30mJH3RQF0ij+xV+b3qvUSwnLBHVdNXnlb7H3DCefrJlmZXkMosRZ5Ph
	 OsLXLd803389MXwEk+SHRHWk+vjRfqlh7/jQA+H1Z0jXWC8oLQirZYZOzP6swEzcAy
	 3Yha3YXgGNtj18MCy+D+byQJFUweDG9PyFPA0hsB2H7WkaefGLDO9OpYawsDaz1FlU
	 NKZUGInoqehvg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8437383346; Thu, 17 Jul 2025 08:01:46 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD71583314
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="R7mJaQLe"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DA4FC10272379; 
 Thu, 17 Jul 2025 08:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752732104;
 h=from:reply-to:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=H2I3xXxloFSVWuziOeABiz3jgnCM4HH52URVUI4MqSA=;
 b=R7mJaQLeZeADDpl/fSGX4LIuQcEkwdUz661TrXmNTUb74NWagzn2SUDnFfqcf95AUAKgUT
 V/k9bIlQc2HB9c31lJnfLGK1UYx87RekrKx/KSzBlER//11ah9S/CFAhVT8o/IqJdZ46L0
 2E9aoAwroEUpFXRUfNc86Rfwx/iC7zR64sp6g/rwcKneYEt0FkIibEYUulpadr6dqTamr+
 Di0qvBRhSAy1C5/hzghOAix2YvklwUUE4wuwxMgSI162QnjYLXjuRq+LK4oMTQmcbwGGr5
 Ss/DHFRibWmy34m6vRN3h9JkqZ9M3wGZwHym/wiHJgO+kNRicDpo8aZIBbK08w==
Message-ID: <fb883d70-dbbf-bfbf-2bf7-006866b7cd40@denx.de>
Date: Thu, 17 Jul 2025 08:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: Add missing <linux/delay.h> to iproc_i2c.c
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250702010549.19289-1-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250702010549.19289-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 02.07.25 03:05, Tom Rini wrote:
> This driver makes delay function calls while relying on an indirection
> inclusion of <linux/delay.h>. Add the missing include directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   drivers/i2c/iproc_i2c.c | 1 +
>   1 file changed, 1 insertion(+)


applied to u-boot-i2c.git master, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
