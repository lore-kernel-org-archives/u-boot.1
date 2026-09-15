Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B03AC88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 06:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0C6F4055E;
	Tue, 15 Sep 2026 06:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dfx2KZJZpj1Y; Tue, 15 Sep 2026 06:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E10C0404D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789454166;
	b=BWwRyjJBBp5D3XYfPqSG/9q9e7kPNCuBnwjgCOww9a6fJjusYcaXRBHrUITzrjYUYgpX
	 sDfA9oZ4wDFzbz/qL/jv2kCd+g+Tq0C0VMRBeXGr3aH0zqbMLSVBU6Z2gaPTnXyhIVdvg
	 khiWgi5Q4EVKjospVBR7QGbMH44hj5vnDyy8BW/ZbMRmB5UB4AbENmuBgSFFHgv9DCBbc
	 K+o08DDLQaSvlAYT8mBZ6lJi2ulIBbESD47AlZ9VeiHSMOx2yCS7I9RyE4LkqJ/Yo3EKF
	 IwjV6pGrEVWTc0yYWMRt9Ll/7icNoCM6FLRLxY5t0TlKdFXE7lyCBjPHjxeHUnYZ9GA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789454166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V0WVJD6SNWRMI0XPWu9XT7uyviHUWb0AWrHazlk1Vj4=;
	b=Bd8tUklUUrmqG2tYZeL/dmoNErsqAVHMIdisQpMn4G6QVfhozZQ12PL5oAhC2OmZ4alp
	 xUVQzai4+p8yiyPYgfgXC5mGupkACWNbwUHDUetR6wg3RwSijMkgw53yc0NPRgy04Xzvc
	 Y/8h3OTPyqmpWS2rDXqxABeAEYRT3swYrhsqxMHGgD1PbDau+Cwfmc1EjTwgEDv+5nABM
	 hkKHmHAvACWs/bQ5dedfQDnWnajxwvu/h0SnHIiTr9+4wn2fZHJxNxgjJdRglVhS4js6a
	 2iPkz2DOBg4DBoybOPi3i+QtDv5CQkelY/CSzHWsfqs7jr7Leer/63MnOnoW1sik6JQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789454166;
	bh=V0WVJD6SNWRMI0XPWu9XT7uyviHUWb0AWrHazlk1Vj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFcT1oP986auUMYNSEYk62El4YmHuhzbKLWbws/xLnB78nIWPkMhL9XXe34+x4gWD
	 8MlfoChEpmA9PFS25vZy43h+56jfZgX6Hl6JCKj5+O2h+yT5g/aWQNT3SHtJgojfqs
	 zdWdNawpRgc5MhbbJxJDx6haJD/Je7XKcgos2Kme0IEzxkgMTwf6FP/a8Scx3CEgeB
	 S5Hd6X/NW+iDp4xXDZagemvA6lYGjApXbDfyqn/n8Uxy1FQwbloR3AC73fC1wgElJs
	 O+s6dN7+aEYkoeD+blQpuzCTXruQ/mSPCg+wd0TheIPN2eJfAs/3shxVF6S/5G6JXD
	 hOY1pxH17OdRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E10C0404D0;
	Tue, 15 Sep 2026 06:36:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 201E7362
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05D5E60708
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0DfJsfH4zIt for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 06:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A923D605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789454164;
 b=XxlSEZPUFs+t6Kqzv5SLi2Y69eVCYjLYGnqKl/iBf+e3LP5kl5/iWY6caGAuUd0MKRwo
 tsBlLYklH8i6a7RCxsUBswqls5FTX/2H6fgp76GQY7pJD6HCHXCKwiVGs3SrTzGo7c1c0
 1aPrkn0iIxKXtS9vwERY+rPmFrRFluv6lYMfLpYI72q9XddTV+SKiV1gMfiJxCf0Nd7lL
 QIT1SJsr4XrTHmSohw0jGa8gcp/x3sE8Bs8dTZHxqVfwxBR5CqwyaX6P9Y1LrP9ZpocFy
 0cAr4g6+M/G/WoQxO1pYuLVgwk1y6iW5Hx6V6mM34gdNtK+XK91UHWyCFrmN3jtH6LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789454164;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=V0WVJD6SNWRMI0XPWu9XT7uyviHUWb0AWrHazlk1Vj4=;
 b=gO882R+G0DieQl6AICQqAdpjp6OZr8s3XgomVI7dMMBOzLf4+zH2PWMN9xfEqwtGQ/kP
 4XF7E22iiF6/M/BfB6KfXhbFWvkXDcBx+uqBgs3qRX8FfqOb76FvDqcyiM//nV+q48ND0
 NDkAlJm5DMQuvVO5YpTs0mGCkNSxCP4QRRR92haMbEI2K/XfxE9h/qQz+QAlrFk+NkKY+
 mx84jFHdDZtK5FHyHY7CiNxBFDhTNnhVg1rqYU594CWevAFEh9NI3T5LmiRAxQ+kLLQkf
 DjgZQk7FO58y8GH4gXvlXula+6lOMH8lLNiTQ+VJcXvoNtR0CYPOFZ2iCoM6BXOHgLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=O4M+sbbL; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=O4M+sbbL
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A923D605EA
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:36:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D479F10333C; Tue, 15 Sep 2026 08:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1789454156;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=V0WVJD6SNWRMI0XPWu9XT7uyviHUWb0AWrHazlk1Vj4=;
 b=O4M+sbbL1uOmbjfXRNeOxvoHW0dgN3csM/cECiWMiAk8pQRN4CretQvvZ2zML9w9f/Rjn3
 IXkEhi6u/EH9VBnFyHZGHULgHiYIbDFvOY4Svr9YavjawYG5KcFVt4WdaABXF/IldDT9Ay
 goN43weUDqOW2/5aZ8XeZzbGAA8miGWJPY258k2QGRgbkwvgqhn11Gm82SIQpBKF5RNF+V
 F8OaOe5UoB/iTrdYsIG3uSJe7LwogUcFNxkyP7rNRnoHayTOd9BE93YtTMEMzu5bQVNwo2
 ud3lbNAnesBOpJJBu8vTMca3goEM5i4CHK7CFay5hbtOsG2m2rUN6DpHPR++Lg==
Message-ID: <665f2a1a-664c-2c94-ac65-d1a913df3497@nabladev.com>
Date: Tue, 15 Sep 2026 08:35:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH] vpl: make I2C and PCH options effective
Content-Language: en-US
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260904132046.45008-1-pengpeng@iscas.ac.cn>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260904132046.45008-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Pengpeng Hou,

On 04.09.26 15:20, Pengpeng Hou wrote:
> The VPL options are named VPL_I2C_SUPPORT and VPL_PCH_SUPPORT, but neither
> symbol has a consumer. The driver build uses CONFIG_$(PHASE_)I2C and
> CONFIG_$(PHASE_)PCH, which expand to VPL_I2C and VPL_PCH for this phase.
> 
> Rename the options to the names consumed by the build and update their
> defaults to the current SPL_I2C and TPL_PCH symbols. No in-tree defconfig
> sets the orphaned option names.
> 
> Fixes: 747093dd4089 ("vpl: Add Kconfig options for VPL")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   common/spl/Kconfig.vpl | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Good catch, thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
