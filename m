Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C50DCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52918846F9;
	Thu, 21 May 2026 17:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MNH9j7R2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB5F847B0; Thu, 21 May 2026 17:21:37 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D52F8056B
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 17:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=WCrR5oFO/KSfb0Ur9Wn2xCo3V1lHjMR25LPwcUKkXcA=; b=MNH9j7R2qKOxHFh8yaa5VzGbuF
 6laV1JBnjpEIVtNOfzwD77CHaaCtS4IIYwyXcFTXq4BNifQtv89TpTVFdEQlajwnVi5rFwxuGYNdY
 tn5S9VJcJ1hNNcZJVPIVgXWugDOzq5wkERJW+9ERsJ6JX31GKyhOfzktlc8pHuXbX15ESaKNPOLgk
 cmrJU85rrMCP5anDXTv2qAdbUZT67wShCkRwpFJqryyOdyQQGc7CEyU40uB8mCe2pTsAlaFrw23/f
 4VP8huNl4WVuGtv3eBUItYYfBWgD9UjdJlh/Q9d8EInsZuav9rP7H2YmF3Gx16w8nVkROZkbm01O8
 bCMb4lkA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wQ5DJ-000Gus-32; Thu, 21 May 2026 17:21:34 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wQ5DK-000BMh-1L; Thu, 21 May 2026 17:21:33 +0200
Message-ID: <6f3efbe8-df9a-4af7-86f1-9d3583bf647c@ew.tq-group.com>
Date: Thu, 21 May 2026 17:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] sysinfo: tq_eeprom: new driver
To: Simon Glass <sjg@chromium.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Max Merchel <Max.Merchel@ew.tq-group.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-4-Alexander.Feilke@ew.tq-group.com>
 <CAFLszTg7DHsiQHmLo19kDjLGNoKWqAzHOn559ANwS8T5mFM3-Q@mail.gmail.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <CAFLszTg7DHsiQHmLo19kDjLGNoKWqAzHOn559ANwS8T5mFM3-Q@mail.gmail.com>
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

On 08/05/2026 19:58, Simon Glass wrote:
> Hi Nora,
>
> On 2026-05-08T08:48:28, Feilke, Alexander
> <Alexander.Feilke@ew.tq-group.com> wrote:
>> diff --git a/drivers/sysinfo/tq_eeprom.c b/drivers/sysinfo/tq_eeprom.c
>> @@ -0,0 +1,223 @@
>> +     for (i = 0; i < sizeof(data->id); i++) {
>> +             if (!(isprint(data->id[i]) && isascii(data->id[i])))
>> +                     break;
>> +     }
> isprint() already implies the ASCII printable range - you can drop the
> isascii() check.
isprint() alone does not eliminate 0xff, which is the default value for an erased eeprom.
