Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF20EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 20:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 095EC86D33;
	Tue, 28 Nov 2023 21:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EcohHTpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4FA8719C; Tue, 28 Nov 2023 21:07:58 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4EE6842D0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 21:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35942cb9ef4so20044335ab.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 12:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701202075; x=1701806875; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zyt3AA9rAsrEEbanfY0RJVuBD8G7Bab+3ER5tFRgGnw=;
 b=EcohHTprYMh6YHVJM6HELm53JBS4OiZ+ewkgXdofc3S+KWQSot2IlC9b2Dwfnhre6+
 Nmc8hLBdVYwYzJ+qLzlTph4H+VEV7LmO+gsl6ywEj/lu+ylSrxWIFZ7RL9KJo4p0O8Pl
 YXRofR5JKTk5Z/3qlgPgI/cFYsMW2uwioQ4tBuWz0LzQS8j+l/nEIczcYCUHGdnrE3tp
 1wX2LCNwdnn0impmcAXRJXAYXg24TS1/s3Gnm/Kx5TM2D23GVvuAJV51Mchzxpvgo/hR
 KmZ9MJ3PZLEVkopMVKVdkeZRuWV4X15qBzp2Nitgx+GZfD3fVT4Dk+2Ra5uxaOF/rlsv
 vVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701202075; x=1701806875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zyt3AA9rAsrEEbanfY0RJVuBD8G7Bab+3ER5tFRgGnw=;
 b=lnNDio5IHedBIopKlyPeEKe62bBTSWddGH7Z4i/yW3yN6L7IcTiQPl4YIRaI9vHECF
 wBGqlM6B+AwqjFAynoHZudPh05PQCu3v43zYiy+lMpFcfakn5/Ke+JnS5fjMPAFxZzfZ
 uRrBNz+pHLyr0wljVa5PWhQcjdBEX/btftN6nYkBEUDz3WqFpE+HAMQ9nCpBBeqBN67m
 zsiFmix0EjNLx6lJTIZqISa+V5cC3BNYM1HkicPJ35JOKJydqBRsdn2eqE/mglfpsyyP
 2cWiLAlsZeiEiHfGZL0rM7eUgg2u5BDO4OYwG6xc6LheeF3EXXr/HABPB8C5WlqkFQ5t
 rYww==
X-Gm-Message-State: AOJu0YwKCHJ2C8EQ6KBesPwbKj4PSRyPbNyGM9QwVGhoTQ5vrJuCrCQF
 uxLZdK8Hgwt31GEQxVnawaM=
X-Google-Smtp-Source: AGHT+IFQme9ulTecymjfUGWzrk6/Wcnnu4qGKF32CqYFYV1jLahNY/c5ufGYsOOLoMGlGeDVTqATiQ==
X-Received: by 2002:a92:c603:0:b0:35c:debc:94f8 with SMTP id
 p3-20020a92c603000000b0035cdebc94f8mr7955462ilm.10.1701202075192; 
 Tue, 28 Nov 2023 12:07:55 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 fi35-20020a056a0039a300b006cb8ceeea62sm9258194pfb.55.2023.11.28.12.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 12:07:54 -0800 (PST)
Message-ID: <5d7ea381-2a57-46f7-85c6-2bcad339d1db@gmail.com>
Date: Tue, 28 Nov 2023 12:07:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: mdt_debug write
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
Content-Language: en-CA
From: Stephen Graf <stephen.graf@gmail.com>
In-Reply-To: <20231128013746.23648d39@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Below is the consol log from trying to use mtd_debug write. It returned 
immediately with a strange success message.

root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000 
/home/sysadmin/u-boot-sunxi-with-spl.bin
file_to_flash: fread, size 0xf0000, n 0xf0000
fread(): Success

I then used the cat command to write to the SPI flash which took a few 
seconds to execute:

root@orangepizero3:~# cat /home/sysadmin/u-boot-sunxi-with-spl.bin > 
/dev/mtd0



>>>
>>> I tried to follow the u-boot documentation on writing the SPI flash but
>>> had problems with the write command.  When issued it returned
>>> immediately. The erase command took about 5 sec to execute. I researched
>>> use of mtd commands and got a suggestion to use cat instead, which worked.
>>>
>>> "root@orangepizero3:~# mtdinfo
>>> Count of MTD devices:           1
>>> Present MTD devices:            mtd0
>>> Sysfs interface supported:      yes
>>> root@orangepizero3:~# mtd_debug erase /dev/mtd0 0 0xf0000
>>> Erased 983040 bytes from address 0x00000000 in flash
>>> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000
>>> /home/sysadmin/u-boot-sunxi-with-spl.bin
>>> file_to_flash: fread, size 0xf0000, n 0xf0000
>>> fread(): Success
>>> 
>>>
