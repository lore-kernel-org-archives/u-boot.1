Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4236DCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 07:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 282948460E;
	Tue, 19 May 2026 09:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QniN0JzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7842584659; Tue, 19 May 2026 09:25:43 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698EB84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EACD63F79C
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779175540;
 bh=5j4OGQByxO6buY1HNm2sEBzvCPdPOOjHFKfuFwzdMNI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=QniN0JzP+S+nWeCTTSa8Sq4PGxVQS95Xft3gov1eXRq08pa1v7AS5rwznnT3dAc93
 eaRCmRt0B9LYKwQoCIlQMOKi4dHcevsnhLpFXVlyhm0XJzjGKvLr+WM0Q/b85YVrpF
 aK5T+N2NsX74LQq/mgW4LWzOOwwfW6EyeyBZDMt1n8JgpmP7IVPbE9vGoPYLzJ3+64
 PFgldOsCvypX12erTEbBiH8EyoR7aopTXMfbELTZRIg4NMsHTRsk1JmZfZNJjLqV6V
 mtSn2eusls98yDfCAS7DLtkIuHBL/WdAH2+/pv8mraYmOE+/iE4bfDZRYRGfhWP+yO
 5PbEP1yCxT/+lzme9iQwzeDWLHFoiTarCqhgKx36MEIaAxzBDgtzEwVTf5XuYH+EZg
 PeLzPhEu0ClvMws6K1+RIKeGQl6XIWTWS0trI+x8+Bc1p3w7oqHX0pvwn8+x20I99F
 3qgs9Ni7w8Kt4aYTFen0ze8XHiDDXmxbrsKeebeUu4Ef2egMje9rBEnW+Ga4+ggbSa
 q3kB+v8sy8pqFV5Q2sdf4rsmyUUbPdYFURFIR+sueqs4KTllqYwsmeG3Mt9T3iFS83
 9WXBbuDaaz7uGcGxqKxeVDo1krvm7oEtSp+i6aUxlcDx9AmGdui7VpceD7dMkdWFNl
 iaO780lCrj+bmYOrDKkE6FxM=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso2779997f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175540; x=1779780340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5j4OGQByxO6buY1HNm2sEBzvCPdPOOjHFKfuFwzdMNI=;
 b=HzExyYnMoVku8HbwEFpIsS0qjVVKheXPhmrxr5uFyEmO/+LSzmuEOheA3GBhLIsLI+
 012K8Qayp0MgVnXZGihiKNC1of46Sw7G2lFZSj8Fsdxc932ZGcNCSY7f4SZF24n6fHz/
 biCfmgEovKplhT1tnMWujqvSKas/HFR8jYDe39UjZGzg71o7cH4y9r6ZyClQLYDKfqQj
 TLfFSoeU00Xz3TRLkMH7ybNoRW7KP4SKQvAhWIDxZ8AyDpSO168iQVazLu68HxLkHWHn
 KblWFsopqS+jqcyGJVOrUWiFTO7htVo4V3YTi/k4Vn3w7XDdIc3TT3kPt8+IhuowPMlc
 pQNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zdeAaE/MsOarU09Y3QfvWQ/mrhnA0f0BAUIir9YzPYyoiRLlwPX9v0p9jcI5CrW6nqvEx4xI=@lists.denx.de
X-Gm-Message-State: AOJu0YyxtoAQnzCrn4K7g8vmT6HWhO4EMM8d+a5ZmOY3k9JWF7tdOSOL
 VsSHWIO7ofAUgf0rjZ8XWiQoyOrHiTWVHaUAK416OgT39F8cauT+CPbaRvtVk+rTEP8pBRhkonr
 Zf2whj0hLFOvOnk7fZi9czJr8G9EML3kIQGCapl5+WpaqYJlPLoGMhxK4OL8bz0t2hF2FFEk=
X-Gm-Gg: Acq92OE6JzaSrtv5cmIkr+EaQVj65+pYy6iQLxtQDdFO1y9c3vYNZA5z/BUo7D4QAUR
 QNQLlGt02cfRTuvvJxDjW8lOcjEOkkJ752suzXVU75mR35ZaruYOW12qCasa9nuQpXUH0IGKA6C
 Zqm9B+eztDTeXMVWW2wMIKEV1F1UhDCAm4fzbtaT8jbNjdUy/BXVF0mb5Espvvs0FKkKCXbKulc
 Fauru9bYVzERuGI8kt8Ezyy0Z5Wd2JtZ4MUaeWIfYkZQXI5Fn5+RPXmTBGtnPj3Wu7jOAz/cOnv
 HRP0aVjWAsOnSrO4PlEUHyIavWd42oJzUK/VFw2l+anHUdtF7OZMPypEw2Wag+aWN9qdbHID6e0
 RSO8jhHDMkUMKD6PjyaKjqrUNUMPUPM5UjztDpQgguAV7USKjWvyRwxZd6DtB3SlfLpJGkFwsR1
 3p5xTi4VsPMduEdzZ0ZYqREACKAixS9FzEIA3G5Dplq1/X2qGI3z+8dHnSDI1jhJ8AOMc=
X-Received: by 2002:a05:6000:410d:b0:451:73c8:9101 with SMTP id
 ffacd0b85a97d-45d92797006mr26017316f8f.18.1779175540446; 
 Tue, 19 May 2026 00:25:40 -0700 (PDT)
X-Received: by 2002:a05:6000:410d:b0:451:73c8:9101 with SMTP id
 ffacd0b85a97d-45d92797006mr26017265f8f.18.1779175540087; 
 Tue, 19 May 2026 00:25:40 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm44905739f8f.32.2026.05.19.00.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:25:39 -0700 (PDT)
Message-ID: <aebdf20c-c93a-4711-8ea8-2b92334714bc@canonical.com>
Date: Tue, 19 May 2026 09:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] fs: add change date to ls output
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518181553.GU1858239@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518181553.GU1858239@bill-the-cat>
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

On 5/18/26 20:15, Tom Rini wrote:
> On Mon, May 18, 2026 at 07:57:19AM +0200, Heinrich Schuchardt wrote:
> 
>> The ls command currently only displays the size and name of files and
>> directories.
>>
>> * Add the change date to the output on FAT and ext2/3/4.
>> * Use the actual date when updating the change date in ext2/3/4
>>    file-systems.
> 
> What's the motivation for this change, and how much of a size impact
> does this have in general?
> 

For qemu_arm64_defconfig fs/fs.o shows a growth of 260 bytes in .text 
and .data sections.

Change times let users immediately spot which files were modified most 
recently (kernel images, device trees).

If a device stops booting, seeing a file’s change date helps determine 
whether a recent change could be the cause.

Best regards

Heinrich
