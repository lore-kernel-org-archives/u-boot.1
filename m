Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31543C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 19:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9763A88ABE;
	Wed, 31 Jul 2024 21:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wb8zW8lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9317F88A9B; Wed, 31 Jul 2024 21:38:50 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5268A88A8F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 21:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db1270da60so4322645b6e.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722454727; x=1723059527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXwdj8EKWACLPNn8IAzTa3m7YY807hOad03a6LA6xw0=;
 b=Wb8zW8lqAcrv5RW9lpn0OgV1pgZMUG21RQ3hYnh8yLWcrNz7Kz4sj0NkJpTGmrnHqv
 IZq92YSpogM7wjUfJEStm5t5Xx+fJVUJV/1oAA66JnPUvEhkpPvvIjMZbjg1LqWz+nRP
 iE+BD58Iov6Ro5trSTNS3yYWYc0dQmxqrt2mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722454727; x=1723059527;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXwdj8EKWACLPNn8IAzTa3m7YY807hOad03a6LA6xw0=;
 b=TMhCwDmR8kX+r4H4gHeWoYbOC9IX4Nd3IeNVWdQ5TsNwApRyG79RVHVufhPqt65IxV
 htFh/3XtfMW8uJeWmkr7KzZ123UT/N2iprpNbSSVcVqYiCHcM5mDWv5Jv0Tr/RXlQ4AD
 x3qIe6L/0SGI0UoG6ll1K9U8fwBHaU50V7oJPJMSKc/5HSqen55EtyAvaM8sIIA7OYG3
 +Es+db+A8tS6Ikxl3l8KEQfynei3ySl1PrD83wP8QdiV7dT7M294WFLa01mxQhKLOoYo
 IxbEKE2QQoTBDZ02MPb8emYyaeDcgItrJ+0zFhdSDtv5Ss8YAA6zsC4IQU/xEUxaIKbT
 bi7g==
X-Gm-Message-State: AOJu0YzkL4yiaMQqzYuOFSNp8SpWzLEhqC7/gByHagtJWaM38igtNnwi
 8thP99t9ZRIjffnkDZu4HTfte7mjg4cnlQiW22gMdDKXuYTbE6xfsAXE3ZUmtWQ=
X-Google-Smtp-Source: AGHT+IFT6c57nzYj/1DID7OTnpvfufouQp9hSw5giezwvCzcvA3+OT0bsOVFNqB/tK2yOAqJOSMLRw==
X-Received: by 2002:a05:6808:1917:b0:3d9:2dfd:275d with SMTP id
 5614622812f47-3db5121294bmr160753b6e.31.1722454727083; 
 Wed, 31 Jul 2024 12:38:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db41806da0sm817377b6e.31.2024.07.31.12.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 12:38:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, Eddie James <eajames@linux.ibm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
In-Reply-To: <20240726123609.57191-1-sjg@chromium.org>
References: <20240726123609.57191-1-sjg@chromium.org>
Subject: Re: [PATCH] usb: bootm: Drop old USB-device-removal code
Message-Id: <172245472589.3951333.17802975368117483132.b4-ty@konsulko.com>
Date: Wed, 31 Jul 2024 13:38:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 26 Jul 2024 06:36:09 -0600, Simon Glass wrote:

> USB is stopped using driver model now, in dm_remove_devices_flags() in
> announce_and_cleanup() at the top of this file.
> 
> The usb_stop() call actually unbinds devices.
> 
> When a USB device is unbound, it causes any bootflows attached to it to
> be removed, via a call to bootdev_clear_bootflows() from
> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> bootflow.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


