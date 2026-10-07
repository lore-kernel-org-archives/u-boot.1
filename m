Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0777ACA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 12:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2DB2606C6;
	Wed,  7 Oct 2026 12:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7W4swKqR58X; Wed,  7 Oct 2026 12:30:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9944260685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791376220;
	b=QCKq+sDbEEvxLTRXnbbSRjGRMeHH9KY6IHqPn4y+elLzGjTP5jPeDZZ1SYax2j/JUlw9
	 F7N7pBDAy/cqV0vMpkM1eoV1FlmGVmNm33adAJG40cnHANbT906EvglRk4fKq7GhTv7RO
	 vVY70BpxBD/mts6q62IO1NJffxIYk7ctKAwWQRoQikWbQZXRJPmW2OhgTBFJT7sbus7IQ
	 yfWwNY/GJVpPKORSGwwjUBQrB4qKIUNDN9695lnGAZZ4ajKIt7vC4mxyXiGjQ6wbhf8so
	 A1rrgg/cmesK/egkhxlcIBeEtltKB3Fifne/+XHEb3YeECGeCX6/U7Ygm5w7G6/Dp1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791376220;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WRcurHUTAGUKB63gn7AiVOQluqpH6+QSd3Yt/1XBJ2c=;
	b=jm7wnsgc9Lkr99GVflokH7JBFYznInoDFMX4rEL+lxXLX7UeDxEaoKHgYU/LDQBNccAR
	 2X5NqvUWo/+lyF3bokYLytMBsQWEKmKyV5CQklz3oQLJUQkAZP4XW43qp+8BbD49Toe4b
	 ehHtUyq+SkFKmpGK/959jC8GZ0pm3kvHbP3lJ6+JzHHpMPAYMddrkg7L1Jxh4kTtTv1zg
	 0UfetA0hBa2xb4QrRsSt1uw5TrikQYjK7M8PA03EBU1cYHCALd5h+N/LThMRvjg0lug2s
	 whuM219q0aTottoFgFnfLiPu1XU308aR1W0dXSgO6Z1M2taPwhYaRZc6D8E68m+wJLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791376220;
	bh=WRcurHUTAGUKB63gn7AiVOQluqpH6+QSd3Yt/1XBJ2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QkX7edxnbRC0sFBCT2sJLnu5imIWeK27sPEZYYqvpKBSBXY9PlkAeAqxKCwVb0XCf
	 i+bDiqczljOETIX2Jbmjgzttfjtdlz0LtZvPOaHNQHgd5emHiGPCKPwBYXkz1qUAhb
	 edXshQQixE1aNh9k/VsVcEItVGLPmdji8AYziAppRDhqV/FeQj9nIulvChBxsI8PuH
	 1OfMzT8tliNYp70VEeBlV/1rPrmVuSTBXndu2SX/0RvUs4d7+6IX9lCwMh9n9a+Flp
	 hTMVsvLiAESiQFXFx060E1VUWZ5zCPu3qe+H+hwAUicgCwePRtcVUJf4TQeYmc1NcA
	 pB1/ZT4KRr0xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9944260685;
	Wed,  7 Oct 2026 12:30:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EE2B1D2
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6513E40057
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Va6ooabBwW1O for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 12:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3AB4740080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791375426;
 b=qQgHcKH6khkgl5R5BIeOZnpFtZdcH3Kh9BQ4u/8xfGIC9Mu5AumDVHdzAn5quxVbFiAN
 ar0t88duFdLT8akWWQNna0FtWFIL5bCKIQp6uufiQJ4JHP6ia5e//C2S4Rgohzv1KVvHW
 hV0a/WFevSwt1XWArrQ1nBlCGfb3AWe9zqXbnVjCRUTYh/YtovumokOR9XMpIXuNnGZ8d
 /pxKUiZbNyz3ecAv6UDqlLueWafikwhjzYjeSx2uR/bXFQCb90YoDZnGZsMFNiq/7RsE8
 9iiSqrVpaocC3xXx7BgUoyVfHJtbawetCpjVeypc+6qc+7fPzozyxPP5qbCkR1zvkIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791375426;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=WRcurHUTAGUKB63gn7AiVOQluqpH6+QSd3Yt/1XBJ2c=;
 b=nSuP56RNfxxuQew9Kpzh3UdPuRA3ukbXaQmgeM49+Ai+qXP5reaiYyj28SWYhydt38OU
 SkxKTGYm4v0MIe+GGcJdG0L3rUH1rS+WxLzfikAAKtjAOCIWg2SwIWX3r79+EVS6oWtRs
 XjgjIvz/sJ0w+KQWEOoWiOWfwwHztBPEoSyU2gxI1F87KAe8lX5K/Y77p8coeoP8McMyT
 0MDdHCnNMRAoc9dpUlMbbP8nCL4+QMTpOaPN3FB4ClLS9Zzm4zAD6xTvb3AFKFlIaYtE3
 RfM6jArowQuvsDE+BbrsOPp0Kb6u2/ZI8N3Nq9vzS8tphTPNbrsac9+824tX1QpK3+A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HFtOSp2X; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HFtOSp2X
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AB4740080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:17:05 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e61ac64ec3so2371095ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 05:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791375425; x=1791980225;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WRcurHUTAGUKB63gn7AiVOQluqpH6+QSd3Yt/1XBJ2c=;
 b=HFtOSp2XVdPIewl5soJ2CcU7KsbUUHPPj1NqiNZGcJzygc+4YEvgLvbztHW4bDb8h5
 b2mQO7SQ4kzQXYFHIFacjI2dJFfV5V577RhooagNWgDP2Cee8WeKfGItcL8+mVHjJEU+
 hksvWCkw9AvdL8ezIro/0q+kKh5R7n0RU9ZYOJzqHyuo/8dCwFCkcfc4362gIkg9pwx7
 bvoBy5zCBnETuHL3C8OPT39aZmuJDtRBBs7I5a9CQ+L4O7M2ZoSr1i5abL55pWCCXEOZ
 9U9PfL0rnuHMwF0gxRoQPXTuPpR1Ha2eiiyDd1qPRRzJNZ+AaEQ72lNo8tn7ZgjSgJAp
 2OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791375425; x=1791980225;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WRcurHUTAGUKB63gn7AiVOQluqpH6+QSd3Yt/1XBJ2c=;
 b=fhPGT4cAVT5PsxtgHDEFqrTugOu6DERQnCndwBBuz/GWECknUDnVRNDeANFMI4OaWo
 sGaYCdqVGmHMgndmijkHN6rqqdiVbKJwMWhCyoeY9wn5DmKxjl7tq29cOULBxBeCzQ73
 OtlEVfLiFfJTWh5WfzdEfiEMa4dvwOCRKcSKk6Tmx7WHJpr/ztDD3feMgKfHf78AcRaF
 6nA7T+N30PRxNwaqdt7VnWBDkHqop7yTVRfyWUkvCm76kURRpd68xOs0FpGaYpRXk/+f
 jdxNjURtdcBrvkpjGi1VXCTCQOZ6G5bO8PKLUIeMTuxAJ+LUytfqABSmlKaDbyo7GXuL
 R6UA==
X-Gm-Message-State: AFq9FYL9mKIusz8ATUE+OmFrlw63C3f4GA7aEpe5Sf/zTnSBJvqj3YOX
 UG93zKW19TzqqskaM/JkaOKrZIPEnnGs48cByKwel19xYOOG5v0Oe2m1EA9ahul3Ir0=
X-Gm-Gg: AYBFou3QaLqfh23hI78zJl6qZw8pMufYNFAWPJKQ+JuL4oHVIBIokIt5WR3lAxaOCfS
 xTtDWK/90AoDn9Zg0X7Sj4g51yQy9dMsei13YKFBPYYiPD+tDdoR8tEJCfnB/xz8RErBZo2Y0O4
 f7Eg7fEM/LPH1J/wFOSL0GXiyWOFBrb28co42E1nmMVcl0PfGvbupFfh9KmiyXwg/jfQRHyyOAj
 T41zSXl7mIyzgE1icbkvX0JHQecfJaobprDRShMa7lV/LK8RnFb4MN5IMpr0K5owvO7HskPJcsf
 Wh/0KqMZK/6vt7Dbigrva0jTOKcuh68HZRClGis36F7fCHjMY3f/cxdUGvqObMCM0wtnSXpCeYU
 4xAKwuC/RFZYU52UkJXxjEKL1DSliRnb1GwcFHWBogiNWEsPvNT7KUQZ4XU1oFHEW9MzyW6avvL
 uebx8HXKKBxDdY/weoP+f+FPXDRtoVqSJTkoctoLX0NfYEKNfwvj3SLjLjP4R1XpNz5OG8FKyYS
 EcQTD/LDPRLgLG/fPjJ1baQ84+oidKK
X-Received: by 2002:a17:902:70cb:b0:2e2:c283:354f with SMTP id
 d9443c01a7336-2e6003c02e6mr15037865ad.28.1791375424829; 
 Wed, 07 Oct 2026 05:17:04 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e604b63d9bsm9024865ad.84.2026.10.07.05.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 05:17:04 -0700 (PDT)
Date: Wed, 7 Oct 2026 09:16:57 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Leo Yu-Chi Liang <leo.liang@sifive.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/3] rtc: cv1800b: Use the RTC node for time and
 system reset
Message-ID: <asY4AesoD7a9doj9@hiagonb>
References: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
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

On Wed, Oct 07, 2026 at 11:33:04AM +0800, Zhuxu Ran wrote:
> The CV1800B RTC subsystem contains a seconds counter and system reset
> controls in a shared register range. U-Boot currently binds the system
> reset driver from Milk-V Duo board code and accesses fixed MMIO addresses.
> The upstream devicetrees describe this subsystem with an RTC node, but
> U-Boot has no driver matching that node.
> 
> Add an RTC driver for the seconds counter, bind the existing system reset
> driver as its child, and obtain the reset register range from the shared
> devicetree node. Keep the existing reset requests unchanged, including
> the warm-reset sequence currently used for SYSRESET_COLD.
> 
> This series depends on the CV18xx upstream-devicetree conversion sent
> as v5.
> 
> Tested on Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>

Thanks for the patches. For the series:

Reviewed-by: Hiago De Franco <hfranco@baylibre.com>

> ---
> Changes in v3:
> - Rename the RTC driver file to cv1800b.c to match the RTC directory
>   convention.
> - Align the CV1800B sysreset register and request-bit definitions.
> - Use uppercase hexadecimal digits in the sysreset driver.
> - Link to v2: https://patch.msgid.link/20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com
> 
> Changes in v2:
> - Use CV1800B consistently in the RTC driver filename and identifiers.
> - Link to v1: https://patch.msgid.link/20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com
> 
> ---
> Zhuxu Ran (3):
>       rtc: cv1800b: Add seconds counter support
>       riscv: sophgo: Enable RTC-backed system reset
>       sysreset: cv1800b: Use the RTC device node for register access
> 
>  board/sophgo/milkv_duo/board.c         |   5 --
>  configs/milkv_duo_256m_defconfig       |   2 +
>  configs/milkv_duo_defconfig            |   2 +
>  configs/sipeed_licheerv_nano_defconfig |   2 +
>  drivers/rtc/Kconfig                    |   9 +++
>  drivers/rtc/Makefile                   |   1 +
>  drivers/rtc/cv1800b.c                  | 123 +++++++++++++++++++++++++++++++++
>  drivers/sysreset/Kconfig               |   6 +-
>  drivers/sysreset/sysreset_cv1800b.c    |  90 +++++++++++++++---------
>  9 files changed, 199 insertions(+), 41 deletions(-)
> ---
> base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
> change-id: 20260929-cv18xx-rtc-sysreset-b816e6306348
> prerequisite-message-id: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
> prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
> prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
> prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
> prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
> prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
> prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
> prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
> prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
> prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
> prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae
> 
> Best regards,
> --  
> Zhuxu Ran <zhuxu_ran@zohomail.com>
> 

Best regards,
-- 
Hiago
