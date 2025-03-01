Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A0C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 14:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A347F810FE;
	Sat,  1 Mar 2025 15:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PXmWbjLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5A2810F6; Sat,  1 Mar 2025 15:54:35 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9893E810ED
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 15:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6e8965f8051so2995676d6.1
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740840872; x=1741445672; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReuEyRvsw505PgqqdP+zMju1IgTccOGxh1E7Pvw2NqY=;
 b=PXmWbjLuBwPlbdHdWbn7KvfXBbbaDmEA68GqQ7NaiRMZg4VcWDN4oPQmnUaMK0G8wT
 b8V9lAvmwNFPRZtE5uYInpOmhYXFJzZZByzMTxNpTT3Dxf2omUwz7ToAx6e16Zk86bMu
 174prNi6DD8s4VN1BJ90N8LohalanDUuRBx4D3Kz6orS3Nvye1afsHZeeHk4BwbPV6hO
 ewiGgZbbzLE/Xb7aS69wRBbFc98uQzQh0l1jxL30yXorhvZhfjg8ehzKtwjD5l3+uVW7
 YyDmqo+pxjw/BNXkIDobiYvIROybilWPi4ytmr8+lawRAHXCmu77Af+MhMnjQs/qYrlh
 p4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740840872; x=1741445672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReuEyRvsw505PgqqdP+zMju1IgTccOGxh1E7Pvw2NqY=;
 b=kzwCSsYsJVltCo38cT0cYoAndztQF7ObjzvS+0Vw8s+B39Q9mM4rH0ihrwX+K99pry
 GPFCGDAUADFRFLbGB0jZYXa5iWLbqWISd9JJiBtCWShSbGRepVHuCQzRoTB/3V8tMT2T
 DwPHiZ/YHbxA+YQVsuUaY92fBnUUT/c2RyhjurLzuZwHzQCl9yPUwG4QRxGjAEDbS4H8
 wb9YDrmVlr8FVnpWibr/osL8Wu38dUaOcC2pvuwaz6u4QvGiZHIdw8AyCZQjkZMzvadS
 oUxMKVTx9wVBb2lP4gljxVuOeZftiAY3o21RfhLTxPZDbwZH7LHKJywCl6jfSmU0EZ+W
 n2Dg==
X-Gm-Message-State: AOJu0Yy+gI3vUAJnnvaBIfGgYWQ1fDpMAxhh03GuQCvQx0ub+xn9DjPx
 NzZHjPz0mlrRODvbVr/cAcLjgUkAHYFQbhSEKUvLrnU0C+StfiZq
X-Gm-Gg: ASbGncuytcLMKl56Vu1Zk5cxVD0kcuBbvKCXtXxJBxIebMBT+DxC0rKzomnzvZGrC/0
 5/r9+LaOnbulI4CLOJJP9z4GXy+v7288IJgdjmoQIbGpnDG+Z4FYWBaf5HbXIRvWijVW7mQVIvm
 oy+vxkXE/o+ldeI9A4woNf4OsSTaqnWWyR7sfRPQb5J2CBNxDg58ayYr3B7afHX/b7lH4mYv+N9
 qjnFBER9ToRJDHESmmuRF2SbvMUuRVZOz0VNIEqfilDpLl7akr4vLpFzZ6eCq/khOgRiw/Qr8DN
 gmWruWVUv0czY9URAn9thnN6Fvbu5rBLtTEIN2GGnASuA4M22hqOyPUi9O3uZKhUQAGMrhiwFvy
 83MzmvGnMp3BpRJvTxhOS
X-Google-Smtp-Source: AGHT+IGwswDXishl+7Q7hVm8GEAzIjoeYSeGiy8i0BtfgBLschrHmWjqF6fFz7by5k3GnfV0u6uo0w==
X-Received: by 2002:a05:6214:5006:b0:6e8:9ac9:55b8 with SMTP id
 6a1803df08f44-6e8a0c7d646mr38303386d6.2.1740840872447; 
 Sat, 01 Mar 2025 06:54:32 -0800 (PST)
Received: from [192.168.1.201] (pool-108-28-192-105.washdc.fios.verizon.net.
 [108.28.192.105]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976346d4sm33287766d6.21.2025.03.01.06.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Mar 2025 06:54:31 -0800 (PST)
Message-ID: <db205890-ded8-56e1-6568-486945eb109e@gmail.com>
Date: Sat, 1 Mar 2025 09:54:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Invalid SPDX License Identifier for test/lib/strlcat.c
Content-Language: en-US
To: Diederik de Haas <didi.debian@cknow.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
References: <D84TW4NT583H.3Q01V3X7V3AX4@cknow.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <D84TW4NT583H.3Q01V3X7V3AX4@cknow.org>
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

Hi,

On 3/1/25 04:39, Diederik de Haas wrote:
> Hi,
> 
> The file ``test/lib/strlcat.c`` has "SPDX-License-Identifier: GPL-2.1+"
> and that SPDX identifier doesn't exist.
> As there is no indication this was a typo it needs to be relicensed by
> the copyright holders AFAIK.
> 
> Cheers,
>    Diederik

As noted in the comment, this is adapted from glibc. The referenced file is
licensed LGPL 2.1+. So license in this file should really be whatever the
compatible version of the GPL is (I guess 2.0+).

--Sean
