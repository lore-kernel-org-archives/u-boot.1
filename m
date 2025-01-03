Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EF7E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 05:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A14580107;
	Fri,  3 Jan 2025 06:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C9A80196; Fri,  3 Jan 2025 06:41:05 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1119800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 06:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Fri, 3 Jan 2025 13:40:49 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Waldo Alvarez <waldoalvarez@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Secure boot on Milk V duo 256
Message-ID: <20250103054049-GYA2264892@gentoo>
References: <9gGp0Bj5BodfZFh9cs_TfmuEpCjka0pg9zw_0jHrGSgVaMRQWbjoI7rDHQ4tYsa3IIzqC3gYozVRk5s_wdiCTp5IuAb7A1wccavJbQxuLAI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9gGp0Bj5BodfZFh9cs_TfmuEpCjka0pg9zw_0jHrGSgVaMRQWbjoI7rDHQ4tYsa3IIzqC3gYozVRk5s_wdiCTp5IuAb7A1wccavJbQxuLAI=@protonmail.com>
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

Hi Waldo

On 13:28 Thu 02 Jan     , Waldo Alvarez wrote:
> Hello:
> 
> I am figuring out how to proceed on secure booting the Milk V DUO 256. Likely in this list I can get some help. It is ARM/Risc-V board with an SG2002 SOC. The SOC has OTP memory and some bootrom.
> 
> The current distribution uses u-boot and linux buildroot but doesn't do secure boot.
> 
> Therefore I am trying to start at the first part. Verify digital dignature of u-boot and have u-boot verify digital signature of the kernel.
> 
> Can someone point me here in the right direction no how to proceed.
> 
I'm no expert of secure boot area.. but you can search first,
there are quite a lot docs/articles about secure boot of uboot/linux

for the initial bootchain: from bootrom to bootloader, there is indeed
secure boot feature which documented in vendor datasheet, see chapter 14

https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf

> Regards
> 
> Waldo Alvarez
> Desarrollo de Software / Software Development
> https://pipflow.com
> https://tradingfuturo.com
> 
> Sent with [Proton Mail](https://proton.me/mail/home) secure email.

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
