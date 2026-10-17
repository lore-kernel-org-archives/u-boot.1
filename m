Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BEFCCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C7F660690;
	Sat, 17 Oct 2026 17:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NKsOXcmOcNL; Sat, 17 Oct 2026 17:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2880606C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258397;
	b=Uk2tOxTNCm4h4y9jkl4WRdUa6AHcucDXbwHynQM25aiBliGgAJ6IwMb9mngq+1JGdARX
	 5zcYzUmUvX1nP0oGuxkj6jYUzjRZVhhoUYEfNVPeAcuJyr2AtKq/HlSaldZFPGA2S/aDi
	 iBlATY3RnkUk/c6Sz3eOjYmm7yy+rsHYNnDRXmB08BilVCPZLXW0kC2KyRSJrJtitAcIH
	 Vk4B6PkPYewSr4jfcLVN+leL719XvwJHtmwSu4yzz/2sdeuV5gu6pk0vMvPFXwzwjc7Dp
	 Crb9v+DO7+9T+vQUL3ltL66PHe75vnBATboHzY5sj0DHRcSxf4QiBqcGjyVV5QhVekg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vx9tQU5UVPo+KcVzbOoGqG4h3oaiFNDfM6VZOSr4kM4=;
	b=WwjtzYkLbu5MuxlOPh7eS6/WTPYfGMUOCCEUq99co9hxrpyAbJy1AEGlG9EXBJR5sZ/w
	 FXalDeUhI3JAZgTlsxSLJkdJAteVWZ/lt1FcUZ8OJuIH5BlXEDbQfO5AdrWLqryFSIJTJ
	 9LA/X34yU9vfCs1HkKWRoKL1eM98H1IqhCqjrOH7yfwm0V412tc2aD6nrnGkO0hPRBSyJ
	 jC2o6bIg8/acrkSdPjft/6fXPWF4LVy4C3elq25pLFteKi3P6Sz22LbHxUZ2VKyVSEn6b
	 n1nB8tQFeSSl/xMKOT92qaxCTr6trMOwpyLG5kUlvrqwfj7r1icVrvfgPjSiB9JpOEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258397;
	bh=vx9tQU5UVPo+KcVzbOoGqG4h3oaiFNDfM6VZOSr4kM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TB53M7wYZZXMoNfiWbE1/7KghOjmObuh3IIfjRW2nlRQLYatO+GoNtq912ATBX6Do
	 euvdzwGaecbAm31LGg8sghdNl8Aa3yJOWdFEOSR5c6HHE8seez49QjpNXKCz9PsEIN
	 ivWWWkY0HGtF01oYI154KQybFekjtw+0/PdLUpljsuGk/DimTt7s6tHviml2cV4eTj
	 GZAwn6jnfsEA2ZeMYHtcLEjBNRRh3wSyktgN0L9itzv7i0nCv8wJSUFIpPxDrn1diC
	 1X5iCk0u73HbrhFBmMgcYkGQ4ZpGaIXeh9IKfo+uGFiee1On5xhOwFlXCNO2WAs0gl
	 5eesU2NlottLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2880606C0;
	Sat, 17 Oct 2026 17:33:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 060921AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE4BD8121B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzjypcCNM-MT for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E589481221
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258390;
 b=BLbH/V3inesVqTGHX2fpOJCcfVt79F+5bUwzXWHNC1/+L5tSZVdhy1KM8j6vAl36NM9k
 h7h8r8UB9qR1ttXyTp+SR7EZ+XO3rVfLM6A0uBmpPNHNihRMPTOd0Pp86rc6xOzXQzsCe
 36yGHArkcAQD2J+IYuoU7JXu65ZP++G87xIELNW8AKMbi2aLUkhDOhfZGUfptPj4N+Qo6
 9H+ZbEs7+7UxLnr+4/JjFXW3nJfue/xjSPYg0HlNUpiYAjIw2mHpzh+oCTZyIVoyAhUmK
 TPKtCbrbXO2/DosMu7L/toOoD+ZRmXHeVypu5Pshk06wyvlg4BnZygkGKjRf+wqwB1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258390;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=vx9tQU5UVPo+KcVzbOoGqG4h3oaiFNDfM6VZOSr4kM4=;
 b=INS9DARJq/9cbZnnXd4md2IW8oTNK1EXCBKYaQxqQvQ39ojQLlos8uX0fY/IplsW/s/H
 pI85MDYjfsZg6+qshckCdYtEQvAN9DqFFzRm34Bcr2cSuG7swe/wAJi1T6NAHDc6+8Ql0
 ybj/iN3kQrjgdl5NEcufwWrXyEvhgH4KKLepyktXfy4LZMHqIvosj5w9mTqL9h0pQ/Zj4
 hP/450CnvJ1h8Mk3kVLVp3Zuaer9sTtkMRoqAEErpeJSXdaWC//6F0l4LTMD9QVF5vXNU
 MUCorrUHpsBY3m0GcWXI5qahpP4bdJ4+EUv/lE5LyG56hmIf0JDgyHWcaEUjkSI+a+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=EEn3SxAU; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=EEn3SxAU
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E589481221
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:09 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6TRN6Jj7zKnTD;
 Sat, 17 Oct 2026 19:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx9tQU5UVPo+KcVzbOoGqG4h3oaiFNDfM6VZOSr4kM4=;
 b=EEn3SxAUuPvF3o1qd1sYe/EZwTFi4lJKM1vHLbNtMZm4FtHn4tD1fIuGCeZCmEVJM8F6yJ
 YIcBgFZtoRU4awVY+mS+12AL6iFHPQ1T55D/d+iOBqhpi3i5RzbtrRyepQJozGz0mgTZCr
 Tzs2DsdobDS0668+IAur90ztY3Fsp/1giQ0VXTOw4IVnqrCs/7ZtonfR3PeLURlavmKwr0
 ySBKOk42NxjoR1OEuAmkdwp2rYkQoYg64TsCRsQ3YfrswODFkxZi92E4K0VXeV/KzHKUr3
 WpLE7sUIQBjgpbYl4S1RVefcCHnLUbInFJdNvAIR0zOTvD1TCtjYr9fY2o6dQg==
Message-ID: <154369a8-9922-48eb-bf1f-777ed8113c36@mailbox.org>
Date: Sat, 17 Oct 2026 13:42:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/26] usb: dwc3: make the core driver build in U-Boot
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@denx.de, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-7-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260916123826.517181-7-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d5a93f89168495b930e
X-MBO-RS-META: bqaw5aeu5iy3su9cbbi3e3scoqo4mpb7
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

On 9/16/26 2:38 PM, Anders Roxell wrote:
> Adapt the DWC3 core files to U-Boot: core, io, Makefile and the omap and
> ti phy glue.
> 
> core.c is a big diff because the kernel file is trimmed to what U-Boot
> builds. The main changes: rename struct device to udevice, use
> generic_phy_init() instead of phy_init(), and drop the host-only and DRD
> paths U-Boot does not use.
> 
> U-Boot gets the dwc3 clocks in the glue driver through the DM clock
> framework, not in the core. So dwc3_clk_enable() is dropped. We kept
> dwc3_clk_disable() in dwc3_core_exit(), but the core never gets these
> clocks, so it does nothing. It can go in a follow-up.
> 
> Keep the U-Boot Makefile instead of the kernel one. The kernel Makefile
> lists glue drivers and core files that we do not import, like dwc3-qcom,
> dwc3-pci, host.c, drd.c and ulpi.c. The source files are not there and
> the CONFIG symbols do not exist in our Kconfig, so those lines are dead
> text. Only keep the entries we can build.
> 
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   drivers/usb/dwc3/Makefile     |   17 +-
>   drivers/usb/dwc3/core.c       | 1761 ++++++++-------------------------
How do you think I can review this ?
