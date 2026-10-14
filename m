Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6769ACC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 075E040733;
	Wed, 14 Oct 2026 16:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhUqtM-3YgHe; Wed, 14 Oct 2026 16:25:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60A8540781
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791995144;
	b=gIINBn6UmHYQqx2B41OeDQCopGX9CtQhvVYhC9+qf9OwbWmFitJskAubX8ZA802Yl42I
	 I5un3aOwzOYmTa8XYE3qN4zOFKW9ej21Sy47P9VjK2K1C0mclW0/yxPHRoQcg6Aq0mqPQ
	 h/hLndi/AG+4EJvH60symNGJgauxwDkKE0HEorUxiYa+mXuhTzsiCuGeKq5IrUvPGt0+2
	 IryA/QQjsM74Al8sEeR/kL+V6n7oKm9YcaWKh7PXKi8XTmJY156t/qSBF9gAyqEv9jPuU
	 GAfmc1sid0xGFlD6fbhNVwTrpbaL8Ud6bHWsEe3qZI3AR+OopFz+gEUeYJzS1cpUqfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791995144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iKyxQjGzeamna9TBgXY/OW/5s+92shC+5VNMggAUmZE=;
	b=KJZqAHrFaRycbpCn55Eth3w7ZJdlD+3+v7la96zqq0XFmcw4MyrdDNzHU8VgdXXsmtnY
	 gipC737h55o8zW0j6ayjVMV6O/prgxTFvg2sA1FiLMeH/i2jYk8qNNlaLUIoxCaBMum75
	 r/LWagsS2OkwvldmouW/g4zcNcn5RpsBz3azMQssmM7uG2MQyf+JiwKQMgOd/UmJU0qOm
	 bLNxCLWhrkPLwgg78FyhmJkDQ/RdrKENpmB64cReRZDFBkZDYJDpSgDz70StILzDo7otz
	 xQFfWQZVmTumPh0h57JwePV2OT+Riz8da62YMzWKRijLUVOkNQ7wRe6PKtwLlNc2kNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791995144;
	bh=iKyxQjGzeamna9TBgXY/OW/5s+92shC+5VNMggAUmZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ABHEu7uYb/KinWzxvgvm/X/z/YWTUBFzTYZQlGIkGsVnMh42ef5bZGy6Yt+Hd7wce
	 NjfzU2/SzVMyC44MikUmzc01nuXhgGHIgEf4PT8ugB23CrEVRikjaNK++OcJD3+6TV
	 APPlC+0KF22QamXM6IY5dr/dfr2PoQliYfbCjPrCZuKv+XqJOvdXwobncI0MpJz6Vs
	 +TWxy7h8KC3ipOwDETHigdHoxb++zRWHMc3dbQ5ndN2ONgrKVaHEB7LUa3NNQYBiSG
	 VrhE+q7J/BzaBEBTP3mHlEks/w6T1gnPDKKONR6Im+msdadh9vHOZCGj2WGFv4/mMv
	 WoNBYgiKzOa6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60A8540781;
	Wed, 14 Oct 2026 16:25:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 432611DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28F09607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJtNUxQumJbP for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:25:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84998607C3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=84.16.66.173
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791995142;
 b=lK51oitEd056sadQiPblnCpqr+kauhLrAbwxsmZ9Pm1Z8z1fhO1wLfH5h5+fuxJEeVzx
 aHs4SezysBVERsXG+F1sGUHf/qRnxiOKlcyzAnky7jatX8tys/y31x6nWYRTSDbzsWy0N
 0p2kYn0McayJrK+p4JVQaDOponW/yntVgqppxKekThMtoJUC5U8cJpRVNg61GbUFFjel+
 zjXOxhZwTvLzntussxbSNbC2QNt2vC+Qmr8dyrwha4TELulkzw7mv8amLXjdZ6dLvue8B
 5Ewk9kLK4r42Jo2TCIgKsGOLn/p0YktO3TEEpa6tNB6k5CXONgxZe38ZoYwjWgtaCSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791995142;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=iKyxQjGzeamna9TBgXY/OW/5s+92shC+5VNMggAUmZE=;
 b=ZfiUBTor9g9OOd9gy/QR+wrCIJOB2BQOLQWuds9G6TQsClZEiMNCqhOlPErv1owWM3/2
 b6ij7xsWAENQlYjv5O7vosbjIYAhzwnpNhBv2tXkGKBbGNkLbpCQxVobyFRZQ1YMiEurV
 LNk9hWWO8V0m7xxbU3x7FHfGvUD1b6IVVEVmI6sSIooSeb0LaohvVF3MmHl6Jwk3qHUUj
 IvMQlrMtaHtEF2W/esvve4auhXJicZiw3vTS2BWZIJHpCIzUx2EKTDBibcYvCo/wVnM24
 sYgtgK5POsCZm8Wmho9VhJC7xhvG8bx+m6gK7h6DsAVy/OXm/Xsr0i1Gl9tYUZIi7HQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=IjnkY7wL; 
 arc=none smtp.remote-ip=84.16.66.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.173;
 helo=smtp-42ad.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=IjnkY7wL
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84998607C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:25:40 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4c4x431XzvJj;
 Wed, 14 Oct 2026 18:25:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791995137;
 bh=iKyxQjGzeamna9TBgXY/OW/5s+92shC+5VNMggAUmZE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IjnkY7wLEeVEzK24G5+rljh41ve8QHmIptY2d6ACbhOTPILdFTTZHrIEbBscuWVod
 liFXjiwUhmwSRPrfp7ZZKcsZHr++QCcGLGMxDms7kCOgcVxHU9jpxZ2HA7me7A9fRb
 N36tQnJbR0UEEhDw+tza9/4t0V9ayLOqQkvq3FTeikFbv8rpiyEvEkQdTAGe0Rp2un
 FcaaacmQFzOF5C2GrTKoYvO6eBEzMC590m7MS1rljvNflJMf6eEV3+QFDMxSFz5FvK
 91JOzzqNlrnrY47y/UclwvDtfAA6OVCrrORTC7/KArTNhLrZtS5cazYOFJdEUE9a1w
 o3zWmB5JNjwKw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j4c4v6PGtzBfF; Wed, 14 Oct 2026 18:25:35 +0200 (CEST)
Message-ID: <888f4840-7c54-4b24-85a0-b3cb645a94bc@0leil.net>
Date: Wed, 14 Oct 2026 18:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261002-config-v1-3-11bb20983682@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Massimo,

On 10/2/26 6:36 PM, Massimo Pegorer wrote:
> The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
> guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
> common/spl/Kconfig file where they are originally defined. Addition of
> a second config statement without 'depends on' guard causes these two
> options to be put in the configuration even when the guard is not
> selected, which is unneeded and sounds wrong.
> 

I'm sorry, I don't understand the issue. Can you clarify or provide a 
way to reproduce the issue? Multiple definitions of the same Kconfig 
symbol are "combined" as far as I know so this shouldn't be an issue.

Cheers,
Quentin

> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   arch/arm/mach-rockchip/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 1a2e7847c9e..5ed774159be 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
>   	default y if ARM64
>   
>   config SPL_BSS_START_ADDR
> +	depends on SPL_HAS_BSS_LINKER_SECTION
>   	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
>   	default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
>   	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_BSS_MAX_SIZE
> +	depends on SPL_BSS_LIMIT
>   	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
>   	default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
>   	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
> 

