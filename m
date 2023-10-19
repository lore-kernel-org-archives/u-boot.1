Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AA3CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 07:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38308718C;
	Thu, 19 Oct 2023 09:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eNVSSMPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620558718F; Thu, 19 Oct 2023 09:40:41 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313DC87183
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 09:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-323168869daso6753765f8f.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697701238; x=1698306038;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nJUxsEEsR0pwzstKec+89Y6agHLUW9SmU8RH7E0CcrY=;
 b=eNVSSMPkW1Zv/VeaZI3pa0jB6x/5wZ/fX1bJdS6WBObXB9a7gdlxfvk/2m1gbXl69v
 LojB5WL/FWMMFd0rJeM0wWY9iuHuf3s9/MlW3x2P/3WiOtdwgGPJZ32kKvkni2akdOl8
 3siqjyO+oHFIHXOkf670EjemnoJlzQ7sA9AeNjSxbp9DTtIrtapeb0RVulPk/WTl3aq6
 42NccPnSIhgiZHTkax5as4OtYbWMAYLctvnEnMTyUfk5uCay+O+5uqC4V2eXRdt5VRCa
 lJVhnu8UcQ2fKdEn9GqEhQQgT6UiyK+uNaMZh3X4V7KvtDeFsJMZa1covsuTDLK20CS/
 7Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697701238; x=1698306038;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJUxsEEsR0pwzstKec+89Y6agHLUW9SmU8RH7E0CcrY=;
 b=DsD0Y5jQdTFKrVrWLNSkLXHW3aey1r9vc/An3o50r+ezrV64rVQb6QidDpFdItXaNw
 uChGI8uYZo39CdEYzhLtH+MnzuIR0j/eY5RxolRVqzwwebrM96H44ftYzT6Y0ziMCZ8W
 YBC8manzrVLe4RUMKcfNOe3XOKc1zkiHaOnfjmf3vnudB2KrYF8VVtc/B9Kvu3QQ71t7
 H+nx8ctrsZb0RpqbJHM3uV7AVAGptYHC6AOqfvO8RVxQLiFC1OrlJpj+qwaCPWMQnOnS
 yEFAyfQujcJFoZcLCYjXnbpGaduuGg3j/CQ0HZHOjFaDA32ZgtF/iPI8HU+JkUdfyYVM
 T2ng==
X-Gm-Message-State: AOJu0Yz0fgsUDRGtfrh7/7s46AHCHQQ3T9P6CvBRtd1150WSvzAc3Lyc
 hPJmLJujOPpZ1l3hQEQgoVB+sQ==
X-Google-Smtp-Source: AGHT+IHRX4WHsHyEXwv+FGEbm04XZAVGlbx8QIg9PP8kDUUXgsFo3kjW2UzU9E+CyZ4oH+qYlPF6qA==
X-Received: by 2002:a5d:51cf:0:b0:32d:9740:5a22 with SMTP id
 n15-20020a5d51cf000000b0032d97405a22mr870079wrv.3.1697701238546; 
 Thu, 19 Oct 2023 00:40:38 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d28-20020adfa35c000000b0031ad5fb5a0fsm3848229wrb.58.2023.10.19.00.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 00:40:38 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] MAINTAINERS: Add Mattijs to USB/fastboot maintainers
In-Reply-To: <20231018125220.4b08c62c@wsk>
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
 <20231018125220.4b08c62c@wsk>
Date: Thu, 19 Oct 2023 09:40:37 +0200
Message-ID: <87h6mnnjpm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Lukasz, Marek,

On mer., oct. 18, 2023 at 12:52, Lukasz Majewski <lukma@denx.de> wrote:

> Hi Mattijs,
>
>> From discussions with Marek at Kernel Recipes, it seems that the USB
>> subsystem in U-boot need some help.
>> 
>> Since I've been asked and I'm willing to help, I've added myself to
>> the maintainers entry.
>> 
>> I have also added myself for fastboot since I'm interested in keeping
>> that functional as well.
>> 
>> Note that I have no previous (open-source) maintainer experience so I
>> will do my best to learn.
>> 
>
> Thanks for willing to help with maintaining the code. If you need any
> help - then just ask :-)
>
> Acked-by: Lukasz Majewski <lukma@denx.de>

Thank you for acknowledging. I'm both very happy and a bit nervous to
start :)

Do we still use the following custodian tree:
https://source.denx.de/u-boot/custodians/u-boot-dfu ?

If yes, I imagine I would need write access to it.


>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>> Mattijs Korpershoek (2):
>>       MAINTAINERS: usb gadget: add Mattijs
>>       MAINTAINERS: fastboot: add Mattijs
>> 
>>  MAINTAINERS | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> ---
>> base-commit: 65b9b3462bec2966911658836983819ab4e4823e
>> change-id: 20231005-mattijs-usb-6b83dde256f0
>> 
>> Best regards,
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
