Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF78CFD4F34
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C4A84154;
	Tue, 10 Mar 2026 21:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HxWjPp38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C70840DF; Tue, 10 Mar 2026 21:45:31 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B8583FBC
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-466ebbf7ff7so1098367b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175528; x=1773780328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xj7tjufFLyDnPSuGaj3OVuFE3jrf5L5Wc1p193dtyj4=;
 b=HxWjPp38CJURqKdoAL7zjIC2tP9Iwf3PBcwZA6Ioiy4QO4d8NazFZWxPaH8bQuo9ho
 DCq6J7/AYFBdUDIOriu/WvN/9BYJrPtEVu1Rcwt09MjhM/iV1AX3Oyl14sC7QRAyR+OK
 g1kfaIhAPbNWuglXF8r4UWiN9gnMMMaLrV+uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175528; x=1773780328;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xj7tjufFLyDnPSuGaj3OVuFE3jrf5L5Wc1p193dtyj4=;
 b=chF7KV6yTxxplc3QE2+zpOKhjvd2yumPVFcXOM0PWBsJhfYxhsQeUHitxN89qpQIZr
 3PuTiLVxXQUNxibGuHUiSRRKCtY5klN5qtJMuIE9NAnOD1qsTVbj2vfH0HFJCC0+Bvju
 +jLmKy+sqeNFfvVFiSIh2gUWRmGab17xDuO7a+t8nlFyg8QVz7T0N9lKynTRcCB0x5rY
 VzVLQhR+DODm71YaL3gLJZrWd5fNOxVl5GfJaSBfPqbPoeKvPYFKZYSewI51czOJx/k/
 sxi4xNrN0y//L2a6F/d6cTalvs/oR/WfEnjFUZwXzTK6nsYL4UWdkWX3RH5iacK30Kh3
 WFUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU50qfgP3Ct7k4Ozo1rypBmSQEzwjZF9ep8RGwK4g8838p5/1Q0scHr8pPrUlulltQ0KRVHhto=@lists.denx.de
X-Gm-Message-State: AOJu0YwTQvsI7+C9YZo6pgJH1cMQLsRmXwJG6JaMiGNT32a4jyzWtDih
 LVyLk0nQCZbaWgbivRs0ROm2j9hsxn6qbb+dJDDjiCNwlMC9gn2DNdjFF+6xEptG3AQ=
X-Gm-Gg: ATEYQzwsgCWF2DH7G8YJMS0SkQDatmnP6tKZ4bLX6s6unysx/eHZfZJenZO3ftAU6yO
 xTo0EDKfy8INVyxE49sEFYZGB6PX1+yKeIW5FhaDwCUPuhm835LDlizAnpXBqCzq58H8urV4s+q
 y6cbMsJ6wsFF+jYELGXAV73ybu8vYKf3NypyiV+QIVBkKPkDrOxGcbLqylgDL5C8yxcBOqYLvmH
 94MmSAVc/Il9u0V8NM7SSU8S0lIVSNFcilNcV+j1UbCzJ9sVV8hxG2vlRt3P4GW195tycsat8TR
 mEre6o+LvMXT4KAySGE6+DQ35dpz2VLVVOCdHkgtvBBvw6589tiIQhDrLtBOvtLlZ35Evab0soL
 uGFjKXA8N01qibGGQBL1ePXabZSy+wU+o8KVk9i9JgIEF7z90U1VYQK6WUn5VHHITS746IQe8PZ
 4sZIjrF8WcXh29wldJvCTD0WvHUkGvaZVAPM2HVIkPbJaTVL1B+BhCRWBFnnVPKruoDJIE1ImWV
 Xr+n9WQLSdFK1W/yyG9lTYV+MUep4KUAqpF+u5RS4jc
X-Received: by 2002:a05:6808:181b:b0:465:d58:e942 with SMTP id
 5614622812f47-46733422f12mr50897b6e.9.1773175527963; 
 Tue, 10 Mar 2026 13:45:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de
In-Reply-To: <20260225072009.50434-1-heinrich.schuchardt@canonical.com>
References: <20260225072009.50434-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] dma: ti: don't use non-existent
 CONFIG_TI_K3_NAVSS_PSILCFG
Message-Id: <177317552699.23044.9817975695240940382.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 25 Feb 2026 08:20:09 +0100, Heinrich Schuchardt wrote:

> Symbol CONFIG_TI_K3_NAVSS_PSILCFG does not exist.
> Don't select it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] dma: ti: don't use non-existent CONFIG_TI_K3_NAVSS_PSILCFG
      commit: 65b776e6d230639d35bcb152d8f8ec2311e5c54b
-- 
Tom


