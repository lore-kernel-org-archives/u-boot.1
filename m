Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FDCC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 297F660ADA;
	Wed, 29 Jul 2026 04:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJ_4tSNBz35C; Wed, 29 Jul 2026 04:56:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17B4460AC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300959;
	bh=Mqh2Bsrop/q9QNV92wGC35oUutspZjFH67MZUiy5wss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xD7JEP6JFLo23jW3ec7cWlsau+8ZC8r4HwZc2z6yf+TCR4RwsT5mniJOIMinFWpvQ
	 IMhFFAVw9grABE7lHxk6/I4T0d0WotaC7eLslAEz3x140wtEPjktnqIBuDz3Xw8j5X
	 L2B1eCzOnGPZDUGT0Nrn3MEx1Et11L3KDx8+ZCA9QW9bAhq5S/RPXHxAzxS9U0pYGC
	 zzrmxcgR+0JuEY3utjV2MloapwQSE+VenWBIjRo82Q7vEYdJrSK2AuoWHsFkuvKRtG
	 HpYS1A97KdC/9tYYz4N8isGHH2tAa1y+N5W0BXjS3zB6Ipk9LhHwCf4S4r3H54gUHF
	 C7aVu2bY35clQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17B4460AC7;
	Wed, 29 Jul 2026 04:55:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A4AAD788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96DBC40362
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:02:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsLAeWp1uRvO for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:02:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mail@conchuod.ie; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0ECB440176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0ECB440176
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0ECB440176
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:02:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78B38494B; Tue, 28 Jul 2026 20:02:07 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA738404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 20:02:05 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so741605e9.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785261725; x=1785866525;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mqh2Bsrop/q9QNV92wGC35oUutspZjFH67MZUiy5wss=;
 b=iq+Ip8exbblqY1uh+mtVKs7q9C5Ul4ULq2qk+ttqZpKUcvSDd7rIdSZTbn424hFa4e
 ggJwhuiNtq9hxGH/26P7ejy2CsUB6WfXD2GguCQrPXZcVss/OT9H+yB8yUpfS2GNFsbz
 3u782EblC1XkY0C5SNQHCBNbw+VauQXARRtNt9AGoIfhuWXqCHltexfwCuGgUTg/9h0D
 ioYEewtRAVMsBCzTpg1JrXWEW4/v3b7fhnJNHyc2b3fEx9B5eFy0+MHr33uuU+c4aw/f
 asvt1f2aJCEeNgVY+QXO/Ggl6Dbkz31vp167jyBQl5GDIurNlmSWnfdgXbbyv6bIIH9v
 rU9A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9EpZLxPYuFziW2iEm9/UXw7pXagcCnRHY3NrdKeqxw9aDEqLcjWI0ONLsOt92KC+KT81NQv8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz688ZKKs+b9teLmMk1+YgMwD50JzBbGgVxowpfDRQolgukQXaL
 wc0oVj1d11x21Rx0nUofW4U/8JnGcV1xSXES/JSrVsMsVHU94jSd2NdVYRnK8K/hTLI=
X-Gm-Gg: AR+sD12nonA5ctSvuBDp5oiCRy59MPE0PzHwnDWz0DshdN4PMm/XbO6kk5K8BNAvDHq
 K+8KvcFkVIzaCZoFbNyIl8edQxvs+2Tedlmql0CFl5SZEKjuu2diDtI5utpe0j5X6GwMLujRyGw
 XqAkIoY+P/i48Mkmi8xra7tzDZ0WoGbSwOcA5DqcEI1Vb9UBQw0wQ6WYynwN2bJq22jJqLp3EpZ
 BthtQk6T0fJ6RzmPFYShA6x5KruLqaEoG9R//2muoCDEaedtbwPA3FDZ1AXmyBKZmMrJn4+sX2Y
 3jGb0Mxhyt251GPs6r/xaDOLBCY1eYuM01kiuzHG4nTzRDhEqRF3EJa9cye6jg7GvHQoEiNhuT8
 fJsmVxi/Gh7suDFPP8llJsc/y7GnJcTJ9FwqMy/v4aXDRmp+MVlmcVYzUHDVRUqbq8cyJE18vh8
 PFaw17Y+2ky0ouIMMTeZnWd+Vl4rd/vWA2AAVTKlFfhm+T6fa4yYfjCvXU+w==
X-Received: by 2002:a05:600c:c16d:b0:493:c8a6:b517 with SMTP id
 5b1f17b1804b1-496c6588c3cmr37096235e9.38.1785261724479; 
 Tue, 28 Jul 2026 11:02:04 -0700 (PDT)
Received: from ?IPV6:2a06:5900:80e6:5500:6eb3:11ff:fe1c:7575?
 ([2a06:5900:80e6:5500:6eb3:11ff:fe1c:7575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c338fsm95591865e9.8.2026.07.28.11.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 11:02:03 -0700 (PDT)
Message-ID: <7ec9c425-53c5-41a2-95e7-f185e8d340c5@conchuod.ie>
Date: Tue, 28 Jul 2026 19:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VisionFive 2 eMMC boot issues.
To: Milad <miladh1539@gmail.com>, u-boot@lists.denx.de
Cc: minda.chen@starfivetech.com, rick@andestech.com,
 yunhui.liang@starfivetech.com
References: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
Content-Language: en-US
From: Conor Dooley <mail@conchuod.ie>
In-Reply-To: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conchuod.ie; s=google; t=1785261725; x=1785866525; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mqh2Bsrop/q9QNV92wGC35oUutspZjFH67MZUiy5wss=;
 b=O262jlurWEQQjG4U8ETNTw+t8bBm/lwbxTdZ+KWkq3Mb+XlGjzDeL3quJfIG+I830j
 C3vRWBZBr2fv9syKeadZOIc3bn6SifJ5pRIypgIHoMyquAtLjfU8F1Z4bA/FCrBb8ZXx
 3I/J4rVoXLIBm7rgfecy/Ebz2Vrbnpeiy+9XflydoQjI8wqcvWsqHYZqbE82k1k3n/jV
 pOo17QICsYtS9nZWX/0f89uIIWLU4w/iR6oHiKHCjaIINfBNq22O3uTaolz1NmoxqoOQ
 UngWaT+IUiWqiR7NMsWTD8ux8Pt00n4vnmSf033ehvJGXJ8LeCEc29PIoFk5k0vFSygb
 JpWQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=conchuod.ie
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=conchuod.ie
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=conchuod.ie header.i=@conchuod.ie header.a=rsa-sha256
 header.s=google header.b=O262jlur
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=conchuod.ie
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mail@conchuod.ie
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=conchuod.ie header.i=@conchuod.ie header.b="O262jlur"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 28/07/2026 15:42, Milad wrote:
> Hello everyone,
> 
> Little reminder on this thread regarding my VisionFive 2 MMC boot issue.
> 
> Archive link:
> https://lists.u-boot-project.org/pipermail/u-boot/2026-July/624724.html
> 
> Just following up to see if anyone has had a chance to look at the details
> in my original message on the link.
> 
> Thanks!

I don't think you CCed anyone that cares about the platform on that
patch so that's probably the problem there.

Is this the same issue that Ilya attempted to fix in the upstream version
of the devicetree for this platform?
https://lore.kernel.org/all/20260306171939.84568-1-k0tran@altlinux.org/

My subsequent PR for that lead to issues and it never got applied.
https://lore.kernel.org/soc/4dd4ffe6-307a-442b-ae99-50c88d4e5b84@freeshell.de/

This happened back in March, and I just have not had the time nor
inclination to actually sort it out, and nobody else has stepped up.

I think I will just pick that one patch back up again and resubmit
it for this cycle. After all, it doesn't change the configuration, just
the point at which the configuration should be done.

If you could let me know if that patch helps, then it would be another
argument for actually (finally) getting it merged.

Thanks,
Conor.
