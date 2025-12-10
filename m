Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C147D3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 09:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B0F83A71;
	Wed, 10 Dec 2025 10:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="q1SA5/7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3213683AEF; Wed, 10 Dec 2025 10:58:54 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5AB83A35
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 10:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F048B40182
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765360728;
 bh=fgT3O8I3xIPkHl5Nc4/3/N1SWYs+3Ox0Qg2sQy566T8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=q1SA5/7CfWnjs1f75d4Rof44WbktYrfQiNWIVs67JuPW5/oVaPfcRPNoSBX8TpHRT
 DnOBZsfnMlta5/tAS8SzGfKTu+9bsNj4CT6u5Tf5ttTHq7VA++x4o/1xW+jRFClzVp
 23nTc6sNDl4HgdGFAFbOIcUxKuXeo7VdUq4PU1xp5QRJUCyEFrkES2hFncc8ywQIEC
 YGyen3edeUeAswHID7WZERElc7wTV9zJl/O+2sk/FWVZkaDgZIGlEwXgyBk13KY3+J
 udcj2EuabW4+G0T9336yxz2/RJUqFBG8Uu4QJYiotgLMK75OISqXBSTgEv7bRBu/+P
 vTZmqT/DjPz6O9Duo7jP0wwQ2CjwT/r4sjHD1kyqwR1NQ4QFU1cbtD7CRGYSoD0XOy
 k7qPkTaMs0FXpTQddFP3okkKNTQdRosHZUyfHcuiRsE0PhWkO60J93oPxK/L2JrIMk
 WXdYUuuXEXzdQyMWktlyh3hHOSIYZtUqs5VeNNszFVf+J2t1y+4zvMYeXM6CKR1YsQ
 E0DS7I2CnGtsxhaAPWA0BbTktzexzoI9U3ljUmqhdChldt3HNF+FnhD6TSTWaNN0xL
 1ysdg7hCJe/xIldUo8Fma/9t0wNWliyVv11C9ZQ/nHK2P2ywiC+W/hbCCAQl/VEjcX
 3RepllVMa+VqhW3zf3ryECbs=
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b79f78b1dc7so139441566b.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 01:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765360728; x=1765965528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgT3O8I3xIPkHl5Nc4/3/N1SWYs+3Ox0Qg2sQy566T8=;
 b=bFOBsajoh4M1lfs5bpI/5XYuUGH2R3Ya+GgYnvGTcBp2wBA9BfO/0yp26cn8JK9bkN
 9gc2QM0a7y2EVlhJLs2E+zROL3cuX4TDiQ0VzSg7NZA8hjJwVUqA041gwWxbcJOkl2ga
 wyINVbjaiL5pxQR/VZwAXl2TE+QhDiXNKq2WE6ejyu1TRUlfxMubD4q23WdG0u9/WZbb
 dQXs2QY/QIaHWUM0AzuqcvoUDQ7XdJR1/d3O2ucMJrFYfw5vV+pJXAOXsuzpN3CAyhTR
 IQiiXv5V3b6ZkIgNJDUGa1qkhCyIl8EEUmG0ROc6MKVQ1GpHmJzikVlloIgr60GIb548
 DOkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUENpcBsivob67puJM5QGbfx9uv2Yv7FcXymTZEwm49TwQBDnlxPiMPBUzyMGk0EzPNdiiwgjg=@lists.denx.de
X-Gm-Message-State: AOJu0YyMKZHhCE+RVQruENhq9eg8286b6b15bR6o5JBd09I0zS4O/gpF
 HHXAb6GYZLu5bWHS3AzpMD2xBoY2M0EPeT88oxZZlzIZloLWp7DN4+5AVY3QZZTC3TMelxd7jXv
 WgZSdRyBmVXl55YR+YaGaZ/F3xa6ZTRsmorDCVgqv2D1ZrG3/a6bGGYigjC1yw7L/TtoOxxY=
X-Gm-Gg: ASbGncuQFCXeLrfOgzKnUXu0uuele6pZyy+cQ/iKuZEeDb5YPnR5c9iFJiCQgfcFnl3
 5EEQkuAqy1s2VFOq3mTebMv8O7l774ewRh1bkGjF5P6qLmvuNY7Gk5p7QYA1UgyJMYcWLeD6/3J
 7aabzaaoRVrdzZCquXkyjVI57Kh7zK8plHiKH9zPhhHUR3Bk6O9YarFjOy9euc12+DgXFMZlCod
 dHSnIgyDoMxWt5E9C6ERYmJfygWc0bvC+sYRziZs2iOXCsYV/cmlIFnZEdu2liDxIqRuNOQ364W
 ExI1wIRiuYiqkdbk159h5CXyFzpBqiBK/gscCX6FsKy3VsKAbic64dcYpalheCMwwDo5/R74KKw
 X0HuFsif75eu8tzO6PGdolziyaS7T5/GkFd7wEqxN2jAk9ekPJEyzDDGF8Vp7fxWUUeD+oI3U7C
 cElKwzO+A=
X-Received: by 2002:a17:907:724f:b0:b72:671:b2a5 with SMTP id
 a640c23a62f3a-b7a6e1b5f52mr568631366b.3.1765360727717; 
 Wed, 10 Dec 2025 01:58:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoJb8Xjl6rsh5x/T/YSWjv67WXMyrLLOznGxqCRrR6kJtrfKeEI5RLP1sGaNGILiwOq/+b5A==
X-Received: by 2002:a17:907:724f:b0:b72:671:b2a5 with SMTP id
 a640c23a62f3a-b7a6e1b5f52mr568630266b.3.1765360727340; 
 Wed, 10 Dec 2025 01:58:47 -0800 (PST)
Received: from [192.168.103.125]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4976027sm1610824466b.39.2025.12.10.01.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 01:58:46 -0800 (PST)
Message-ID: <8094db06-cd0e-4372-bf55-efd6407d2e9f@canonical.com>
Date: Wed, 10 Dec 2025 10:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-BOOT TESTHOOKS][PATCH 1/1] py/travis-ci: add
 u_boot_boardenv_qemu_riscv64_smode_(acpi_)na.py
To: Tom Rini <trini@konsulko.com>
Cc: Stephen Warren <swarren@nvidia.com>, u-boot@lists.denx.de
References: <20251209230318.416872-1-heinrich.schuchardt@canonical.com>
 <20251209230707.GD303283@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251209230707.GD303283@bill-the-cat>
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

On 12/10/25 00:07, Tom Rini wrote:
> On Wed, Dec 10, 2025 at 12:03:18AM +0100, Heinrich Schuchardt wrote:
>> Add missing boardenv files for
>>
>> * qemu-riscv64_smode_defconfig
>> * qemu-riscv64_smode_acpi_defconfig
>>
>> to enable network testing.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   .../u_boot_boardenv_qemu_riscv64_smode_acpi_na.py      | 10 ++++++++++
>>   py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py  | 10 ++++++++++
>>   2 files changed, 20 insertions(+)
>>   create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py
>>   create mode 100644 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py
> 
> These are identical yes? So they can be symlinks. Probably to
> u_boot_boardenv_qemu_riscv64_na.py ? I forget if the file
> "py/travis-ci/u_boot_boardenv_qemu_riscv64.py" would be read by all
> iterations of qemu_riscv64.
> 

Hello Tom,

My understanding is that the files are per boards. I am always irritated 
by the _na suffixes. Maybe we can get rid of these. Or at least we 
should document these.

I remember you being very hesitant about symlinks in git repos because 
they are not supported on all file-systems to which a user might check 
out at git repo (e.g. on Windows).

Best regards

Heinrich
