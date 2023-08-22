Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC4EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C558644D;
	Tue, 22 Aug 2023 17:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UH2bxva5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62578644E; Tue, 22 Aug 2023 17:32:12 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BF186439
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CE45B3F213
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692718329;
 bh=oN3CrZP20HZD0DvFDZvSLOpBoFOl+d2QBsx4vGdLiLc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=UH2bxva5pnq/rdUpEiCdviazxY5SGJy9QOEmO6Cs/rV6Xia1JppUSsX+I1+loc+XI
 Ja4Xlnt7GNmFjVLfaYvbVNXgXsq1lByO+dcvtpqsIcAJ88sXqy4PWMFP0eNpcj/fBv
 RmIUjffWqcoUXTuFAARudZyQedZQ/0q/8OYUyQk/eN0Mjz61QSLNY4aQcDQvYD16K+
 wbfIlN++BJvygHdO7qM+RF667DOb++o390OKYXn9frc5Kz01c26aXXPV0/M/fJrT/O
 RkIZyLKP0jPNgnoIcO/qx5d9awuVCF4ZUlo+xJVRgIkoIM8RO6tajGO2+9zIyVev/8
 U7A9PHhsRdewA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fee34b0eb8so22216785e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692718329; x=1693323129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oN3CrZP20HZD0DvFDZvSLOpBoFOl+d2QBsx4vGdLiLc=;
 b=BcZ4lZzKrjcUr6e4OC0o9QSTdZybJUYUOw9/MXQ+jkm9zGjH6dhhDZ6stwLM4ggVIe
 tnGsWaL051jLTuSjolLd1L/sWs4boXaYAWdTVCeFAf2wfJS9QZDJ0nhHTSy9UYbGQMeA
 AKQ7/nXIgL0JhHxk47BBqR1RAN1CgQeGQ7f3JzKfMJbqWItik+s2T1/9orYhdtbbgFce
 UVzX6elrPHMG+7MXWQPIy7j0Y0+jUHARDnEb2WynOQNl4QdmBkDi70ZX/BW5PCluPGqz
 ikXJNL+mXA2Q14Wjtw+xGjZ79hZ4hcHkT3VaZ2Ddq256qUIxsPWn5gZ9Nu5TQx4IAETi
 N+bA==
X-Gm-Message-State: AOJu0YyCEdipM7LA15i9I2BmgHsT9ewhzkBsIhuaPg9Yhmju+dF4dP2i
 o1XQ/5xWOD2hv89AvQXYfOZrDfYdnxOGOOrmeWc7d9m/WzY9ghW8TKe1rHrTgXft8hHi+0UTAey
 IZSrpFBwtCJEYc3bgcZhwtBtQzvCYDRM=
X-Received: by 2002:a05:600c:b53:b0:3f9:c82e:9d87 with SMTP id
 k19-20020a05600c0b5300b003f9c82e9d87mr7728394wmr.13.1692718329494; 
 Tue, 22 Aug 2023 08:32:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWm/PwlxLxnb/FDq7cgnQgJiFmVFSoX4DvSuguivUnh1aaEJKqC244+sE4QTWp40s7Pvx1YA==
X-Received: by 2002:a05:600c:b53:b0:3f9:c82e:9d87 with SMTP id
 k19-20020a05600c0b5300b003f9c82e9d87mr7728376wmr.13.1692718329094; 
 Tue, 22 Aug 2023 08:32:09 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fed78b03b4sm14399827wmc.20.2023.08.22.08.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 08:32:08 -0700 (PDT)
Message-ID: <21c8358b-c353-dd54-a37b-1c4b3ed5c324@canonical.com>
Date: Tue, 22 Aug 2023 17:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] doc: board: ti: k3: image alt texts
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de
References: <20230819024948.30103-1-heinrich.schuchardt@canonical.com>
 <20230822152751.2qz6uboxjupehkrr@enlarged>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230822152751.2qz6uboxjupehkrr@enlarged>
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

On 22.08.23 17:27, Nishanth Menon wrote:
> Heinrich,
> 
> If you don't mind,
> On 04:49-20230819, Heinrich Schuchardt wrote:
>> Provide alternative texts for images.
>>
>> Fixes: 6e8fa0611f19 ("board: ti: k3: Convert boot flow ascii flow to svg")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> I will pick this series up as part of documentation cleanup.
> 

I don't mind if you include alternative texts for the files I looked 
into in your patches. Maybe you come up with better descriptions.

Best regards

Heinrich
