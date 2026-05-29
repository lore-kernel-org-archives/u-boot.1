Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B851FCD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 13:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0112E844CF;
	Fri, 29 May 2026 15:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TjcTGcUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480A584671; Fri, 29 May 2026 15:43:55 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4877980087
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C84B93F2AF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780062232;
 bh=XWqn3dyPQHyiGu5o1IFl46qmWou7bKb7RiQV/pKbwL4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=TjcTGcUkV5hdRKcOqfkfGFWXMLSFRfrltXlZ9BNuOOelI1Cz8GzvR/DFcxMHSeZwl
 t/fwJYFmh3PdAcg6VElXBh3WWTxDMLVC2NJEVhWnCfLxwUPX572hSQgWbhws6t0EKJ
 aEDSQJDd3TCXcUVwZrP/9eKIUAuTMOwyPIaGvkD6zIu5bpzkp/vGXizafXe867N3rs
 b7Yv4mNfcYX56EuZeyIUTb4XEdMGBgOf3ZY/w6DIQBTzmokW03MEdZY5+YTVSvYkoV
 CEFHMH/geU/uBEVmUtSly0eGZEUUVA7d5g4gGtS0xwhONXecpf7YxGUHE3nXRcpbRa
 A60sVtJ8Ndk55bIklrtlX3dHAVvfvEpmqgihEIAaMfV/gqOe5anPNkWoKU1qsrhbo8
 b9ndQrmAZghx3jsfnyzsMgVHe1VhxEDl53k7oM/3gbV1aS848vGVLsSKy256EpkEJm
 Qlay6aaN4QzruXUMwEDZRtswMAyonaXuoykBtCj3epRS57dJhGr1sFWNW3ax5Dugif
 1IxbqV9GwKWA/KNgzGpBtE87+vu1JxIQyLKxo2mJ7SbITab+Dhd8SlDeT0cyD0x7K3
 WDyV4R5kHmqVx1eia4WQRfOZLnGetcRVa1TBmLYufKFYvkpDA/2e9Y2iu9FCzOLVp0
 vMFa8pJ82eARA0rr3K8C1Sn0=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48e79219704so94419765e9.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 06:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062232; x=1780667032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWqn3dyPQHyiGu5o1IFl46qmWou7bKb7RiQV/pKbwL4=;
 b=swhEA4t+u2VruKlNB1OqrAAvoUGcuziuUZn4K9LXEAa1jycFjQ6LfOuw783TdbaQNf
 EK0K1dK+ZuKiZlfNGEn1NRdNfQ5r02rvSdISTLUuCCI6aSemNjT97YVSAUd9lMkp6HHs
 2AnsEsszGrtVaFZ/xEbI5P0hWjiNAAmovsV2Cd2GRub8Qz4UXuOEb8Ow9TLbU9YZxxgl
 MF7VdpjXbjHHvrKVEK2P/mtWegcnJmPas34F1vUVBsKGo4vSsR4BS2BntQx1lCMQtjIY
 d4SUA23C8NHNA9xMn1uSC6nc7vJJwQKasQlAtVIgiwBI10Jt/qsTi9LkqsiAeCYuMDDf
 ZJ8Q==
X-Gm-Message-State: AOJu0YxgEdISbtzHCejD1+o8gtZ2XkN0kovXRL4Ug10r2c5kIMveqplZ
 RLHlGXxssDzkoGVMx1KnG1lzrqGOy84kEwxjdm5WSXxG39EZvnR+4p0K9LqommztjqwbuHo0jAn
 XH5Kd+CvxXTnlYnTrGCGcdMSLTeHkphudk4BY1Qw31DJq5CO6FbPh4lcUM5Gv8iCXPSA0ElM=
X-Gm-Gg: Acq92OHc1bbIJdBlWOiM/iIhjkcKggrKBPhKOMz/nraPfOhYIJJcjzcnpSIWPF8gOoJ
 LcC3BClGmTyEUVctdUwcM9Z7qtnWAoPxQe3MtiDrWWQdI95t+aevnC2LZ9kai+d8N/U80wxzv7Q
 LPS4oQqctjxH5qX7JOoZh33khzRPpH90vh4vuTH7TpKhCgrU4PESjIFXy6juKmEvR1l4nAp/bAn
 by8jxPT7osjoUgB9dd/th6CKXQv7GfQQmoeU1p+L6rBLqDtnXGMDK4hsbvg5jubvwVJKHhZBy3o
 0ec51UXYXvUz5qcyz6cFROLkZfk7OZTfFPQuiwpNlpcwaVAmeTnV/csVBgZPG72STUk3D1Ri+Fd
 R9n+egwgwknikEA4Dk++dR3+LPUhelRVRKdXnlMTSZ3GSPx3sDCXvQhgcykcBW9MWcX0kuFHro6
 grakSLzZQPoG+qQS0v8JUvLZaFIbKtsOqdzVjwyFtGsXHctEyBIwcraodKuvoK+3yrX5DAi0Fk
X-Received: by 2002:a05:600c:3f07:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-4909c0a73d3mr55952595e9.12.1780062232418; 
 Fri, 29 May 2026 06:43:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3f07:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-4909c0a73d3mr55952255e9.12.1780062232080; 
 Fri, 29 May 2026 06:43:52 -0700 (PDT)
Received: from [192.168.103.107]
 (dynamic-046-114-110-245.46.114.pool.telefonica.de. [46.114.110.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aecdfsm14980575e9.13.2026.05.29.06.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 06:43:51 -0700 (PDT)
Message-ID: <d5e70f97-2d9e-4ed4-a8af-d37bcec2486e@canonical.com>
Date: Fri, 29 May 2026 15:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] usb_kbd: remove match string
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
References: <20260102144715.185656-1-heinrich.schuchardt@canonical.com>
 <f205eb32-e090-498f-b9b3-cef50928e724@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <f205eb32-e090-498f-b9b3-cef50928e724@mailbox.org>
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

On 1/2/26 20:32, Marek Vasut wrote:
> On 1/2/26 3:47 PM, Heinrich Schuchardt wrote:
>> U-Boot has added a compatible match string "usb-keyboard" to bind the
>> USB keyboard driver. But this compatible string is neither used in U-Boot
>> nor defined in Linux.
>>
>> USB keyboards are identified via a USB interface descriptor or via USB
>> vendor and product IDs both in U-Boot and in Linux.
> It is always the USB descriptor which indicates it is a HID / keyboard 
> device, the VID/PID is used for quirks only.
> 

Do you only want the commit message to be updated or do you think the 
code change is wrong?

Best regards

Heinrich

