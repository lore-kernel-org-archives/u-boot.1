Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A31C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 21:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 919876061A;
	Fri, 11 Sep 2026 21:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xnP09XkbHHay; Fri, 11 Sep 2026 21:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A167760656
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160818;
	b=cXbS3KTtwX4bjHTKerI6ncF31edI03Eiftj2L9kJedQYwqhbRnDOPePWgBazh7CrrCDH
	 8EZddhbKXwT6DwcXvyutYth2WD+MQKDhXsfgkCU8Bk6DAWgRVw7Rwynl+/k4LEtZRUZJo
	 lcek8TEXXc5J72SPDIBFVBIhrFtLck3CXfq9DREDTbkdpcO8Y964u1aWT6HEJ/3CgwUDk
	 2PIUy6FeqD8Dgfvcfhz+jn8XDpm3EVC+4/joIpBzog9GnLu5jOjuSaFIrCssctbQIkc8Z
	 TMvhTo1N0312e0JNm30GrYn/xvOkTVThBf59XqRLL2NH5P/0Om96fuAXpNkYopF81oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FZLk7tysDQmmbarDbsfICbivi9Ud0Rht/HNq4ZrpwM4=;
	b=hMCzCDhpgeye8pdckuohJz+Bze1lsplyFTATlYD26p/ZSiJ1jEUW7l3OPLCXQpN3+AcX
	 FCg4fe3uUDi7un0HJ3xv96Q+Oh8V+yymPxS8jqJcMwimgsdIRSCDtRaNMNZ8FiEq8QU8W
	 lsS+piLvNMQi3wtLHRIVWAOQ6RlewYVqhlwcC/95PhZpK2P77n+ZOGogdorHUXWffBI0u
	 AvgPwm8bVJ2Z/YobVc3lV7Hm6fmV/Dllh2M4hm+YKzGaklcC3XJd9pvct/Xdnj4aneZDm
	 tYABuLvaOk35gxaF55j0erl6OowtrOjnr8rAl91nboIS4rC/TfTI24G5PkV/l+wwOjw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789160818;
	bh=FZLk7tysDQmmbarDbsfICbivi9Ud0Rht/HNq4ZrpwM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0eIa/iJY7ZXw4nHoFLoAYpnOybhMffG9XnqDxKX7jbTKAT6jK0FFLGIIilqW6IXwP
	 dOohZqHnVmZVE+fN7bp1SinATAIox3IwmCCkYUQ3DwIPmjozD/YIUPXBD671KninFV
	 jE0WlTu8/mTBLuxMe568B9bygf2miL5ocENf2j9fDJFpzryPaccMez9KYdyEdLfCOF
	 Y0WqoyuobKzujsKwBdQFzZIE4xKVoUJIknKFFDnrO3+S1K4OBZkkCm9xQBTI5mJJZf
	 EFL4qicpJO5DbrScJYsIJB90O6A/I0ujGnpqe2P4+HUBDAe8eecEC6CeZskIe/C2M0
	 1qlobhlMr61ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A167760656;
	Fri, 11 Sep 2026 21:06:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6207332F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5363A80F30
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvPiuEeTMVup for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 21:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A8F4980F11
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789160815;
 b=bUGIm7Ciw6c0owmcbu+OS8Tl1eOsG24fLlKeHfEMBaiNbVqtFm7SRWh9YWsDi5zyjmu8
 CuEyqAm6vCaj47KY6eWnNykH9gy283bEn1Dxh6ZTz/+5pVJjGjVDunj3tkUP/Qv8ac1Dl
 wrxF+YFwZfJcagb5UgNmbRj8rp4xqpiGC9g+J4FwdFzbpHnsdtyEaY71tSFrcWRhSZAxA
 1MJY++VVC6Mf2RuxEFfSk4vVOXLPXLcu762TqnhTXpnKDasdDBWVGcnL8rmevAhOE5Sk0
 Ta6jsOdQ0ZLqXHaRkkpVdbYvBWR/3efj2A+fqXpZwYJ2d3Sa1GzuXUWfAbMg7x4Kbew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160815;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=FZLk7tysDQmmbarDbsfICbivi9Ud0Rht/HNq4ZrpwM4=;
 b=gxNvWkvGPD0p/47FD6uLyTjrRDMnweo4wkcc6T2ZPLbhrYTkWAkDHfkV5IAngo+wEa4q
 z6HHOr2Ul1cq6+K1NW8MY83p+RAtUScDFcPDONtZFLxNEi69IWeXbwtqLUCHhHCaC8rEA
 paalgJtTU9HK9Tkk6nP9BoA3huSAWIaFt3L4IGtlKsbFpy0ZeF/IbV9bUOkWdEX0LMewi
 uz7G859b/4QUkpOkzPZSgI1NBHQTBTO05spaM6+1xWYl7EUaI7xTk9aDipS4X0+KAR0sO
 qyqgaR5vu68FcL94vj6qFzOBbVCLfKJbcRXtLnaz1hBcVy3RPq0xtLaZ5rX8ceOEyUw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mWWkTjRo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=mWWkTjRo
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8F4980F11
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 21:06:55 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a3c0d7aso50412b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789160814; x=1789765614;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FZLk7tysDQmmbarDbsfICbivi9Ud0Rht/HNq4ZrpwM4=;
 b=mWWkTjRo/Bp7yFd6Ho314+XJy1pcfKM4AuSyvq3CVR3JoR0o6A5be7GLPx2Xupl1bs
 WLWpjFg4TGe4aGfPSLXjcw4U14rePnOg+3b5xl+3lklt+oaSlaUNQvKJf23AtSxMaLNx
 tVdGf48XlbcFv6bmCxPofyzbYByJo9ID/gB0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789160814; x=1789765614;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FZLk7tysDQmmbarDbsfICbivi9Ud0Rht/HNq4ZrpwM4=;
 b=JKfDg64MCHbPjTb6c8giJ5bFz/RbNmXi8lWmb4eMjCVjzkbCmA6I4vBY7MBLpjOpOW
 0jzd0KYFdY31WyudH/6z4uXmWGHWVIz9zWLyxE0t1mv2e/wRq/n7638HjQUB1i57TgKf
 41VlpyQ4UGaRMUZ3eswo4Cqgt9JzL5/qkzONk9QrPgOAU99Z5jIAnG64cAJulIPsgbg6
 wHf8U8jZsvtB8AhHS5MNWF7yHGSKXqTW8GtJ1RWJhPNTvTwUmlXMGQQSoxDylRblh0nE
 DVLgvcQueDAi6vFUsY1aUNne0WD/H0K1vhaQUhvmzJE+nEnxpNfZ3o7HHkmYqFlYaRLp
 SHUA==
X-Gm-Message-State: AFuF++lZPDL+7u7/C2bdpbZ/tulzCghrCnrF2Z1xr4xsonZKrC6hMZ4I
 a5ogRpAdACQ4sFaYA+JwF39kwlQC30gluPmHOiTWSbNcCvoJSsA7zMdya/O493fbV6nS4U8QsEs
 rhUPwgrwHvUcd
X-Gm-Gg: AYBFou3+u551sDuG6FLRi9V7N9gkpGjPzzuODLOmarZiSFVLcDexHHBUDUGSTe4qj6U
 1KT0q7wYmuXMLH/pYF9uHP20eAevSkYuVYHJlPI3ECSNMVzRbbbyydQmZDBGILHhm5o4jA+lfiW
 vl1VZDbo/HNtvg/U+CFQTi/WPH/YZv3Jn+YhTM3/YtCoINpFXhOenpkvdgTXIXPH8Dx5K6IXMTi
 AFlcD8BUk2IWo5o3Tlg2c0SV5bSw7WIlQPRosi5MtU1tQTZ40P2YKlefa1/TGGTCOdXkFudzuC/
 KvCL4FuMX24OrthMZoVUf0G54xQbmb8+C7lqVS15Ky5qenenVrEBiHZOl8hbCihKI5GwG/ZNCcv
 JGAr2o9sjIj1Y5g6nmP4cDc7NXArh/8llrggPisxwYZvcOK1pGDGtXFoOgnackO1mYbsx41pQfm
 KPIvHu1IJ3UI8atlEyX0QmbVo/nTeOeOt1rqNfy93FCKJui8sZkjd8TBvXn7rtcLm2HSTWpexol
 gbeaML9u4Jx2HzR3U4SerFFLwEQay6DVMG+44zclHX2T6pLMcFDuIR9Hd+m+CHWi6Y0t6qkAY60
 Ozw2HKc2n5lT9spTUU4=
X-Received: by 2002:a05:6808:13ce:b0:4a3:cea7:4ab6 with SMTP id
 5614622812f47-4c307f67e6cmr3389950b6e.10.1789160814347; 
 Fri, 11 Sep 2026 14:06:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c32bde3858sm3197723b6e.0.2026.09.11.14.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 14:06:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <2c3fa641-08c5-4729-b06f-660a1167ccbb@linaro.org>
References: <2c3fa641-08c5-4729-b06f-660a1167ccbb@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-pci-fixes-20260911
Message-Id: <178916081353.3818440.13375139398335021898.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 15:06:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, 11 Sep 2026 15:59:45 +0200, Neil Armstrong wrote:

> This a set of 2 PCI fixes:
> - using proper DM function to iterate over PCI busses
> - fix pci_get_devfn with fdt_pci_addr is initialized
> 
> Thanks,
> Neil
> 
> The following changes since commit b4ac71db13a33c4e6532c60a781ddf34b7f4375a:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


