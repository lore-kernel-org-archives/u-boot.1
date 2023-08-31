Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90554C83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06358664A;
	Thu, 31 Aug 2023 14:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OO6ujoKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9766A8652C; Thu, 31 Aug 2023 07:49:14 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 560C786561
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34c5fec2a95so1656765ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693460949; x=1694065749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/el5IGv2uX36MUoookPdSV62iLWGVe01UEpk4rRMpcU=;
 b=OO6ujoKLN0K+GlHEG78r6AYFUORdsp2drtB9MJzV9CsEpccr2XwHv6YNnKX+TGx/qX
 iCNi28H6NPAh/l95Qe/ptbKbrpTSovWF/bdlhwzavZ/uBsCZAW/xPp2QDPi2zxPgBvRN
 yYV6nd+sA42Je0YczOm9romsmjztMxrNIrXMmtDVvJ7yPsba6Ieh/OLK5uxZQoA72jp7
 hVnou8XMovAtgkQOxaGakvo1IFr+y7l2aQnfThSSSzklth3H5EuTH6Xxqkx+PZmOALZu
 yMNqAiBTYSZ7U08vs7S2nV6h+/gwGoM1uyrz2srHmSoPnu5NXUHw7gXRU0nIu+ZFc+WI
 qIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693460949; x=1694065749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/el5IGv2uX36MUoookPdSV62iLWGVe01UEpk4rRMpcU=;
 b=TrH+gAMNqFmUEKNCeLea5Wsk2e4EoUkP+YKO1av6zH1c40ur8nU7fMrrHWBzPxLoPj
 ALzRoR07T2o8nWETVdfVACgteIs1iU+xBLi4wu2EVvjp4v5BzMKHJN+H1pLsYfJl6c1Y
 dvr7WX/cjnRoHMPaMl+JLukiQQ4m/hHBLf/Ttdoaqm3y/3hG7dCnyXbksxukXi5u//Gt
 TKzOO+c0rZpG3o4YDGSRSyS37PUw3aq4T9C8sB+I1TJdFFuO3d1RZenrQtRej4yjO8v/
 UPdF4wLTZpIQiqAuFAidRftsPSAqZaOcH/2igJVAbMTubjgC86dQaVi7RUve/IZDI1oW
 IRUA==
X-Gm-Message-State: AOJu0YxG11AoynMXrj5IinMM6iHpwJP3HhOUK4Ij7I7bHnI0BfdJlckx
 ueMBiRuawji5B9LjfiSZbhw=
X-Google-Smtp-Source: AGHT+IGnUQBvJiNA/nO/8yN44w7Sfp03vQr89KSr1eRR1zfT+xY0vL9rDwCA6YLYRaZn6SPyROeyWg==
X-Received: by 2002:a92:d5ca:0:b0:34b:191:8444 with SMTP id
 d10-20020a92d5ca000000b0034b01918444mr4640214ilq.15.1693460948979; 
 Wed, 30 Aug 2023 22:49:08 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
 by smtp.gmail.com with ESMTPSA id
 ed17-20020a056638291100b0041ab9b6f5b0sm205267jab.128.2023.08.30.22.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 22:49:08 -0700 (PDT)
From: SSunk <ssunkkan@gmail.com>
To: ssunkkan@gmail.com
Cc: chiawei_wang@aspeedtech.com, jagan@amarulasolutions.com, sjg@google.com,
 u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH] Add support for more XMC series
Date: Thu, 31 Aug 2023 13:48:56 +0800
Message-Id: <20230831054856.3176-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABjXDjFvFp33phD2Kwog8oo8H1XsquU7UBGLVLKKaemeawrbrg@mail.gmail.com>
References: <CABjXDjFvFp33phD2Kwog8oo8H1XsquU7UBGLVLKKaemeawrbrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

>Hi Simon,
>I just want to apply:
>https://patchwork.ozlabs.org/project/uboot/patch/20230812031846.3958-1-ssunkkan@gmail.com
>
>Thanks,
>SSunk
>
>Simon Glass <sjg@google.com> 于2023年8月15日周二 06:43写道：
>
>> Hi,
>>
>> On Sun, 13 Aug 2023 at 21:19, Clus Tom <ssunkkan@gmail.com> wrote:
>>>
>>> Hi Simon,
>>> I'm not quite sure what you mean by v2, if it's the previous email, it
>> only removes the XM25QH128C part of the commit message compared to the
>> previous one.
>>>
>>
>> Right, so it is v2.
>>
>> Your emails seem to have generated 3 patches:
>>
>>
>> https://patchwork.ozlabs.org/project/uboot/patch/20230811082000.4277-1-ssunkkan@gmail.com/
>>
>>
>> https://patchwork.ozlabs.org/project/uboot/patch/20230812031846.3958-1-ssunkkan@gmail.com/
>>
>>
>> https://patchwork.ozlabs.org/project/uboot/patch/20230812030731.3711-1-ssunkkan@gmail.com/
>>
>> The version number helps the maintainer figure out which one to apply.
>>
>> Regards,
>> Simon
>>
>>
>>
>> - Simon
>>
>>
--
Hi Simon,

When will this patch be merged into the master branch?

Thanks,
SSunk
