Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F408CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04ED683FBD;
	Tue, 11 Nov 2025 21:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TAROYbZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E68B83AB4; Tue, 11 Nov 2025 21:15:09 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD42F83C16
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c707e11e01so141641a34.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892100; x=1763496900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1udh0JY3HELnhfflTOzY0cWAkZDLjM7SabXna3+M10=;
 b=TAROYbZZhxPIUF2izZt3Di/Po5jnx6f/JI5zc9xQ5nMdWw6JQ7zblynGmDRAtOdG2Q
 5g8NGhI5EC3Adqkva4cKURBtirRSJZQ1FzuW8eSZnxjbSPK5m96wB+Ce4jVmpdFh8RDA
 pj6bpE2BOEDg+1VB1P7CbkuOXrS+VjlLQC6Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892100; x=1763496900;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q1udh0JY3HELnhfflTOzY0cWAkZDLjM7SabXna3+M10=;
 b=BM0kL8njLxuyH1CYhLBzHiHOjHix0ShbVtRcUvefvQAU8LEyhji2xDzpyVxQrXnx91
 iM+v65+4UXTqIULkrV5b7+ihBQcuUH5uohDGNSPrlLxfMkz2Zdg9QkicPe0Uk4OONBAP
 24ihdpmdebXYhO1jYXtHOI5BmceRw9Temm/WOJzoOr2oq5sT8vPq9p72kC/vynq+lYdC
 o3HMn59Qu/hmHXqrKAOHhzAr7IiSt1CoTtkMpJhOvWaFmzz+qzwciHEwgFsLKsvHq475
 +5eHSzVnf/TncsLrsc0UzlFz3AJ04+G0RYjxC2Razn8AOXhbgYENj9GxBXw/5fs6gazA
 Uu2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSdrmY++zYjn7UcnMDNZIgx6JfdkvpEFO8S0AWO2kl5nzNt2WZjOb4Mh76fVxMkpt9Q17pDjU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe4xfNr7bRoHv6psfqerwJEWi6gVBLm/B+AlMXkABgyC470lzE
 HsOA9V+zmvbFJiPXsFq1ReQ+2PSYgqJ0qBT2SUGXlIuwwQVhRc5/ycXmN5YuLsG6SHqdSe26v32
 y/IVa1bPe4w==
X-Gm-Gg: ASbGncsu/dMbg5146+EEbGQEV2pqWsgtG61RlCKXin2Zp9PSpVn2UhSkdAn7rTHfHj0
 a3so7DaKEfSzUdp/p8o3l8KSRcESL+E/iM+xauHnlO5JRKoxiQLBgTUnaFlNh5oSTBm9yySJXhs
 RF7qS9nOeGpHVkm8ze8GJgU9vekEn9xjXWkxdyzR6mRl+OkfuGWqHbCkxsVxQCuf8ca4gSIfMH7
 bIVSPRbbnYf97ojc946KiBmKG3SpPHVqmq5lwjvdsIF/7Wg0CM8ZMdQ2DOQUTA5Ufb74eLi8ipH
 JL9ud7MlnsoHyLyXiuHqAAbtJMUdC/A+skKNMBqzRjSDLBR1s2dcCSUfc242kIYAvy1Y3mEJFoB
 crOuxZPsoE5jTy/QsJguO3wrW0mheL4Fyij2nnwu3w9qf9yahQ+LEcNoayxn5Bx86/2gI1ytM82
 mmFQNGjJGE0mN+6IniuZd/J+59NjWolB2FuJgAUA==
X-Google-Smtp-Source: AGHT+IE+uWBMz2/CRL3LZaI0Ytz5yhinEbwlhY8NIMQ3itp3H/RtQ8XAzm3YTzYiP5d1TyPVAv4sIg==
X-Received: by 2002:a05:6808:2210:b0:442:9a9f:daa9 with SMTP id
 5614622812f47-45074629298mr241784b6e.45.1762892100499; 
 Tue, 11 Nov 2025 12:15:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:14:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
In-Reply-To: <20251109070521.142477-1-heinrich.schuchardt@canonical.com>
References: <20251109070521.142477-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] dm: typo programmaticaly
Message-Id: <176289209952.737015.11228133978351741380.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:14:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 09 Nov 2025 08:05:21 +0100, Heinrich Schuchardt wrote:

> %s/programmaticaly/programmatically/
> 
> 

Applied to u-boot/master, thanks!

[1/1] dm: typo programmaticaly
      commit: 307b0f03b97f021cc635f031aab98ae72a7e5a45
-- 
Tom


