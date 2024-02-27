Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754E3C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 14:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE19187971;
	Tue, 27 Feb 2024 15:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Baydg4qa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD1D87E01; Tue, 27 Feb 2024 15:04:00 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C332F86FCE
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 15:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-42a31b90edcso30303651cf.0
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709042637; x=1709647437; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hFfQNzkMR2nqKG5NSyIG+dFnVZQeVZzlKOVaGigrv4I=;
 b=Baydg4qam3zd32ozyyWNugvoiIIZpKDPHj9ENHlsK0zYYwlJmnH2LcnHtbS3CTjExQ
 pijSjQ8QbbRRHYSgxqnjLjg3Bhc1rqPgx5SOfLKEwwdY/Bz2CyIfJ5QvtpCvshs1VlUN
 dBK0+duXPJEOCDJACVfIJphFy/d2MJugYo0AuMI2ktbdbiRn5TF6F4EPJJzMyVgvTxyq
 XE+CYcdK0B15ANimHpV7uFknTZPDzCvRmCJoUkFams+QIl7EOVccteHgoSKkcGMFgVBT
 xnLdt82Ug2mPnFu5G++JV0ZpjKghnBxEi+kWgBrFlCm+imcU8zLA/IEpxiiYD8WsEGlo
 6suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709042637; x=1709647437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hFfQNzkMR2nqKG5NSyIG+dFnVZQeVZzlKOVaGigrv4I=;
 b=deOMalVlKK34qgvc0OAx9OYTP6D2QKZVBMhCWuulKNP2sK/0ygXgVNmiaCIfD1ivSq
 xr968rE8JgP9MqqrOuzj1v0Rb//F6jqvuA0XOvQWSE1Qyplso7kQm3kVkbAb2iDGAVHQ
 Fu+TDSL+Vm7KBe2m3XJ9SM8DYl5aMpYnVnKiw4ycYQFnOHWQGsypPb2lC6AVALnrx79I
 lu8+kld22fnuf1DmHpfPUMBoaAO9tZZCFvk+wCJ8810copmyYp6O5nPOJzVkzoXThzxv
 m1k+42sT30IbYsLeBjehVXMOs6uuk/+jA9+US8NGQUzNh6m7CdDciiBnkCiEFXkpwQjL
 ut9A==
X-Gm-Message-State: AOJu0YzvNTB+0mBun+uPvnqvkyrG3TxJTn0pPN9Xj/P4OC/wzvF7MW7q
 k1ByUDfl1/oKrDRajzjw6YTQOOZqrexG5s+H3D1fTLuUbjaO/74b
X-Google-Smtp-Source: AGHT+IFI0ifcM6OpOShDK8gAXc3uJQ/RMyUoTiAXr8vpbCoM8moqChfANuqK7Yx4zhvtCqTidEqcAA==
X-Received: by 2002:a05:6214:2a4c:b0:68e:f75c:59ba with SMTP id
 jf12-20020a0562142a4c00b0068ef75c59bamr2492969qvb.47.1709042637431; 
 Tue, 27 Feb 2024 06:03:57 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 om24-20020a0562143d9800b0068f5da018e3sm4196390qvb.9.2024.02.27.06.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 06:03:57 -0800 (PST)
Message-ID: <04e7a4b8-a264-5d9c-a0b5-c985d5f35cb8@gmail.com>
Date: Tue, 27 Feb 2024 09:03:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
References: <20240209100829.1079401-1-danishanwar@ti.com>
 <40bd8620-9fad-4c7b-9f28-4ab8a3e0365a@ti.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <40bd8620-9fad-4c7b-9f28-4ab8a3e0365a@ti.com>
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

Hi Danish,

On 2/27/24 05:26, MD Danish Anwar wrote:
> On 09/02/24 3:38 pm, MD Danish Anwar wrote:
>> The fs-loader driver reads env storage_interface and uses it to load
>> firmware file into memory using the medium set by env. Update the driver
>> to use env fw_storage_interface as this variable is only used to load
>> firmwares. This is to keep all variables used by fs-loader driver with
>> 'fw_' prefix. All other variables have 'fw_' prefix except for
>> storage_interface.
>>
>> The env storage_interface will act as fallback so that the
>> existing implementations do not break.
>>
>> Also update the FS Loader documentation accordingly.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
> 
> Hi Tom / Sean, can you please pick this patch if there is no pending
> comments to address.
> 

Sorry, I forgot to respond to this earlier.

To be honest, I'm not really convinced. We have plenty of environmental
variables which are inconsistent (e.g. ethaddr, eth2addr, eth3addr) and it
doesn't cause any issues. While fixing code has no cost, the environment
is an ABI which we can't break. So we'd have to support both of these
variables forever. I'm not really a fan of doing that without good reason,
and I think aesthetics of the variable name isn't really compelling.

--Sean
