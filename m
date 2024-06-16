Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C81CC27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 04:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47ADF88286;
	Mon, 17 Jun 2024 06:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TRFeTSo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595B480E9A; Sun, 16 Jun 2024 20:20:59 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3991F80E9A
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 20:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6ef8bf500dso411132766b.0
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718562057; x=1719166857; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+EJv9aecYd9atfI66MQObhx4yLDnaJJvgiUQSPA05rI=;
 b=TRFeTSo/9fRSManXrnHLHL/H/+X93jw7qa10yb/6AERwaShrOX0ghEQFSLeIluV5cz
 IwMF+Gkju/ae5GGwKVn5fkOFK3dBouT9N3SIabPg2cEGBGL7RkcO/Os5izE8HSDqrKzZ
 1RB+agzTGHGA6puBt8/gI3Qt26TmscDEkPnCSRziEjnqkUAtxZrUDDxPCkicRaS4WGuB
 aPSjQ4r5yFvWW9QQwIXjD4DBLl0gDS7AjkEamXj3yEWcWamCcbcbEYTQQKlxEl4lhy+L
 KZB6/KrLe0t0bXufhroxOXL6uVbfXKt3un0XxdzUVgYJoeXkARrfhhIUH2/ZTbYesIrZ
 5+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718562057; x=1719166857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EJv9aecYd9atfI66MQObhx4yLDnaJJvgiUQSPA05rI=;
 b=UFmsZxVra/lvSp2ufHWM1HJaUDwtGP45k1xVOTr+zHVMqWcJ76jAB2aNDQ2lIYU8l8
 dTRvgM4eJ8CuwgXCTGFtEy2la5+LyHsp4N3QbZEAuMYGCEbNv7VsXJw1/p7SZUVEaP6y
 Sv83Q7XF+etmH4XYVb5xWC8J6XdqTwURkmzmDDAnPxt2GXawxOkiRnFmc2z1y3IRwHqg
 vNuqsUtOPSJvQ4f5V9X1TWSOzxXDCTL2124WcYnU3qgEmQiC40A+6FT1WOQsb7wJqBrG
 skkFwqEfuEC3jC5ASORoNkDkQN/3YsIuX+WaFUhQ95jteImJJKbrIiRyVp/E76mK/dn1
 nTNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYtx7WxzNz0EHbZGwfyXgY2fZ8ybCPYdPzLlFuQWtNVDX6lyDbOhWnYP7v6EBAAHfFDyCwtXRYjBaaozE1mtfn6IetkQ==
X-Gm-Message-State: AOJu0YyScEF1pJfKYyks1aPxoLTX1gDL9o0aJpESrgYA9ZG4XMe0PpM4
 L6z8Wy6A+9Cj0uUPiYUg0uWhKbX8ygKVkZ5Ua1rBLmcmN7CnYqdj0m1HgA==
X-Google-Smtp-Source: AGHT+IFfRQAqzoD56G1A1ufYQoNNxS3DEuVRDjmVF1yxlvCH95/PCk0XSU88C28da1NiQKwWPFmTUA==
X-Received: by 2002:a17:907:874e:b0:a6f:69fc:76bf with SMTP id
 a640c23a62f3a-a6f69fc7ee3mr502500966b.55.1718562056368; 
 Sun, 16 Jun 2024 11:20:56 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:46f6:b2ed:b2db:8fc])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed357asm431395566b.125.2024.06.16.11.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 11:20:55 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 16 Jun 2024 20:20:53 +0200
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] doc: api: bootcount: Convert to rST documentation
Message-ID: <20240616182053.GA4275@vamoiridPC>
References: <20240613220212.37078-1-vassilisamir@gmail.com>
 <20240613220212.37078-3-vassilisamir@gmail.com>
 <6cf18006-bed8-43cb-aff8-591781f8c3ac@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf18006-bed8-43cb-aff8-591781f8c3ac@cherry.de>
X-Mailman-Approved-At: Mon, 17 Jun 2024 06:48:41 +0200
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

On Fri, Jun 14, 2024 at 10:43:09AM +0200, Quentin Schulz wrote:
> Hi Vasileios,
> 
> On 6/14/24 12:02 AM, Vasileios Amoiridis wrote:
> > Move to the new documentation style with rST formatting.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >   doc/README.bootcount  | 53 ---------------------------------------
> >   doc/api/bootcount.rst | 58 +++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 58 insertions(+), 53 deletions(-)
> >   delete mode 100644 doc/README.bootcount
> >   create mode 100644 doc/api/bootcount.rst
> > 
> > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > deleted file mode 100644
> > index 0f4ffb6828..0000000000
> > --- a/doc/README.bootcount
> > +++ /dev/null
> > @@ -1,53 +0,0 @@
> > -.. SPDX-License-Identifier: GPL-2.0+
> > -
> > -Boot Count Limit
> > -================
> > -
> > -This is enabled by CONFIG_BOOTCOUNT_LIMIT.
> > -
> > -This allows to detect multiple failed attempts to boot Linux.
> > -
> > -After a power-on reset, the "bootcount" variable will be initialized to 1, and
> > -each reboot will increment the value by 1.
> > -
> > -If, after a reboot, the new value of "bootcount" exceeds the value of
> > -"bootlimit", then instead of the standard boot action (executing the contents of
> > -"bootcmd"), an alternate boot action will be performed, and the contents of
> > -"altbootcmd" will be executed.
> > -
> > -If the variable "bootlimit" is not defined in the environment, the Boot Count
> > -Limit feature is disabled. If it is enabled, but "altbootcmd" is not defined,
> > -then U-Boot will drop into interactive mode and remain there.
> > -
> > -It is the responsibility of some application code (typically a Linux
> > -application) to reset the variable "bootcount" to 0 when the system booted
> > -successfully, thus allowing for more boot cycles.
> > -
> > -CONFIG_BOOTCOUNT_FS
> > ---------------------
> > -
> > -This adds support for maintaining boot count in a file on a filesystem.
> > -Supported filesystems are FAT and EXT. The file to use is defined by:
> > -
> > -CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > -CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > -CONFIG_SYS_BOOTCOUNT_FS_NAME
> > -
> > -The format of the file is:
> > -
> > -==== =================
> > -type entry
> > -==== =================
> > -u8   magic
> > -u8   version
> > -u8   bootcount
> > -u8   upgrade_available
> > -==== =================
> > -
> > -To prevent unattended usage of "altbootcmd", the "upgrade_available" variable is
> > -used.
> > -If "upgrade_available" is 0, "bootcount" is not saved.
> > -If "upgrade_available" is 1, "bootcount" is saved.
> > -So a userspace application should take care of setting the "upgrade_available"
> > -and "bootcount" variables to 0, if the system boots successfully.
> > -This also avoids writing the "bootcount" information on all reboots.
> > diff --git a/doc/api/bootcount.rst b/doc/api/bootcount.rst
> > new file mode 100644
> > index 0000000000..9435a7ef15
> > --- /dev/null
> > +++ b/doc/api/bootcount.rst
> > @@ -0,0 +1,58 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Boot Count Limit
> > +================
> > +
> > +This is enabled by CONFIG_BOOTCOUNT_LIMIT.
> > +
> > +This allows to detect multiple failed attempts to boot Linux.
> > +
> > +After a power-on reset, the ``bootcount`` variable will be initialized to 1, and
> > +each reboot will increment the value by 1.
> > +
> > +If, after a reboot, the new value of ``bootcount`` exceeds the value of
> > +``bootlimit``, then instead of the standard boot action (executing the contents
> > +of ``bootcmd``), an alternate boot action will be performed, and the contents of
> > +``altbootcmd`` will be executed.
> > +
> > +If the variable ``bootlimit`` is not defined in the environment, the Boot Count
> > +Limit feature is disabled. If it is enabled, but ``altbootcmd`` is not defined,
> > +then U-Boot will drop into interactive mode and remain there.
> > +
> > +It is the responsibility of some application code (typically a Linux
> > +application) to reset the variable ``bootcount`` to 0 when the system booted
> > +successfully, thus allowing for more boot cycles.
> > +
> > +CONFIG_BOOTCOUNT_FS
> > +--------------------
> > +
> > +This adds support for maintaining boot count in a file on a filesystem.
> > +Tested filesystems are FAT and EXT. The file to use is defined by:
> > +
> > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > +CONFIG_SYS_BOOTCOUNT_FS_NAME
> > +
> > +The format of the file is:
> > +
> > +.. list-table::
> > +   :header-rows: 1
> > +
> > +   * - type
> > +     - entry
> > +   * - u8
> > +     - magic
> > +   * - u8
> > +     - version
> > +   * - u8
> > +     - bootcount
> > +   * - u8
> > +     - upgrade_available
> > +
> > +To prevent unattended usage of ``altbootcmd``, the ``upgrade_available``
> 
> I think what was meant here is likely "unintended" (not deliberate) rather
> than "unattended" (unsupervised)?
> 
> I understand you didn't introduce this and just migrated it to rST, so free
> patch to whoever feels like sending one :)
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Well if Tom agrees also with the previous patch then maybe I can send a v4
correcting those 2 issues it's fine for me!

Cheers,
Vasilis
