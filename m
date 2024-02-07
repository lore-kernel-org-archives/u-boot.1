Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC99C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 17:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45CC87B3D;
	Wed,  7 Feb 2024 18:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="llNn5xYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6039F87CCF; Wed,  7 Feb 2024 18:44:32 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B3287B05
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 18:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bfd27f6dc0so573088b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707327869; x=1707932669; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pQf+AG8tGtMIqJSNM6+T/XBiOS6j6l8g+M9nNF9SG8o=;
 b=llNn5xYV8XKd+n7BZFwi5iEU/+48gQqekKE6oYu9A4sCWrxF8WISIWkqznTJlaxWbf
 +6nYpALsPWTW7O1F8a5VkAt8TZ7si9YkH21NXsZ1jzKK7p3oAHpC8poebaPIZhKRDhAx
 EvaQv483LTrMRSUzdfGlvAW3eju2TVrhKtdBFnQuW8A5Ev8bCv1lfWOx358+0ZBUHQpZ
 FC/5/aoX5zf2bY0h2b8YxIvUok/6Rcs79WCOmQN6S66oQ4Wr5sbvRthbnX9IAkJm14Dd
 AGP5/YsE39YgU6t6Z3dVOv0jSdaUSmGL6X3c247rSH/KiS1E+Bo8o4ChaLkAO7vLW0p3
 AWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707327869; x=1707932669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQf+AG8tGtMIqJSNM6+T/XBiOS6j6l8g+M9nNF9SG8o=;
 b=Nhzi4gTEtl1gmOa5Ukbt63C4snSqvaRWO3btafDZMrCbtkPyEtQ/Vm0rgNLzsDtk42
 BrEj/fsUcRq9NSOVPk+cerbEntdaSQpzQMwKNSuNbP+5hQAskGdRCLzpV4i36CWEUBJ9
 SR/+Ai7vG1sR1DjBsGhWoQ8OnPzo6yeY3JchQw28saMH+VB8Bi+3nXcbYflnJO0Gcgky
 XcEElq7ryoCeiz54AqYW635v7K9Z1O5TEDYmmva8WBpYsn5b0e5/X6AgPowzdeeYD2gQ
 n2xPQl1nci3IpgiH009vt/cbcaYGYhhtNWl/x9RavULf8aAStKVVeR5cYxJH/kijydJR
 pGaA==
X-Gm-Message-State: AOJu0YzmgPelqFzTF8g3jouoWwrWfV5f1w4eV+88jcdQYLQe5OYfjWqR
 YlWRexNQbTZv24ms4teW3ylDECebPu6G7cmbnGmhFiEyaUnEP4Th
X-Google-Smtp-Source: AGHT+IG+Y76fu8eVLCmqAe/wWkl9Khl7DJxFtQuqfpEig7zPp2qiAwqBBnwu2YsH70bSUT1ip+W/IQ==
X-Received: by 2002:a05:6808:3c4d:b0:3bf:dd2c:b9b8 with SMTP id
 gl13-20020a0568083c4d00b003bfdd2cb9b8mr8523333oib.20.1707327869018; 
 Wed, 07 Feb 2024 09:44:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2iHhtvH5yl+uImeQXf+eRrduUUnpQwBcsCYDBtUzc+lsuX1D7lAtAvzVqdu8XjSdAtGbk6RCOy40qbW4BC4VfBNIsmY1mmUQ9nxUoRkEaG1HLP6wzkiTa43sW8JfzxYNvIsdRWYCnQJnshh6pnr1rMC9V4AJ6N5X1I0cj8GbCj3+vt7wOpdRBzVvVU+BOq3Hst0bsFDuaRjroxqm9wdaJn+oOuN8eFqZ1/MpHYOq0ocjZaxYvthglAystWyoku8W4yukR4r7lATrC
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 kd3-20020a05622a268300b0042c08366ff9sm711639qtb.23.2024.02.07.09.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 09:44:28 -0800 (PST)
Message-ID: <bcbcf89e-f417-849d-ce2c-bcae8dc772fe@gmail.com>
Date: Wed, 7 Feb 2024 12:44:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Qu Wenruo <wqu@suse.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
References: <20240130062627.2344282-1-danishanwar@ti.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240130062627.2344282-1-danishanwar@ti.com>
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

On 1/30/24 01:26, MD Danish Anwar wrote:
> The fs-loader driver reads env storage_interface and uses it to load
> firmware file into memory using the medium set by env. Update the driver
> to use env fw_storage_interface as this variable is only used to load
> firmwares. The env storage_interface will act as fallback so that the
> existing implementations do not break.
> 
> Also update the FS Loader documentation accordingly.

So why do you want to do this? I don't see what the point of renaming the
variable is, since you are not e.g. adding any new functionality, and we
have to pay for the rename in code size.

--Sean
