Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE204C4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 14:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D3387707;
	Sun, 14 Jan 2024 15:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=ik.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=ik.me header.i=@ik.me header.b="STl4ZU/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0085D87933; Sat, 13 Jan 2024 20:30:27 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:3:17::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A93487883
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 20:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.coval@ik.me
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TC7ly6TyZzMq0PH;
 Sat, 13 Jan 2024 19:30:22 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TC7lx6Frjz3Y; Sat, 13 Jan 2024 20:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ik.me; s=20200325;
 t=1705174222; bh=CXaHd5Rc7VhT2R3ykqrzPUViELzewjef899gS2glkrM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=STl4ZU/vGLEwnZZGb9jNnt92VVfc6N3/JvbN9YqCa2qIc4+XnRllofkmlYS6Pncn4
 6nl3rKVs3Yi7A9moh+Wbk2vLN++SgXWbmoXvngn/vqjcMbEm9rhLyADi2e+c+03CiP
 OHU39trbVfbas+MFMWBWBx38SWge+/wXPddJUo+M=
Message-ID: <ff57cae8-efc4-4e30-abce-83e7d43bde28@ik.me>
Date: Sat, 13 Jan 2024 20:30:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: sunxi: Reduce inrush current on Olimex
 A20-OLinuXino_MICRO
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>, Philippe Coval <rzr@users.sf.net>
Cc: u-boot@lists.denx.de, Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Sam Edwards <CFSworks@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Olliver Schinagl <oliver@schinagl.nl>
References: <20240106222142.170219-1-rzr@users.sf.net>
 <20240112160100.274ff616@donnerap.manchester.arm.com>
From: Philippe Coval <philippe.coval@ik.me>
In-Reply-To: <20240112160100.274ff616@donnerap.manchester.arm.com>
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Sun, 14 Jan 2024 15:50:38 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 1/12/24 5:01 PM, Andre Przywara wrote:

> On Sat,  6 Jan 2024 23:21:34 +0100
> Philippe Coval<rzr@users.sf.net>  wrote:
>
(...)
> thanks for taking care of upstreaming this!

yea I should have done this earlier !

>> This change fix reboot, it was tested on debian-12
> So I am wondering why this only comes up now. Was that always broken,

I assume yes, it has been reported a couple of time elsewhere:

https://forum.openwrt.org/t/rebot-issue-with-a20-olinuxino-micro/56720/2?u=rzr

Also, I just filed (And shared patch):

https://bugs.debian.org/1060752

I've been using armbian's lime images on micro that had the fix , and 
forgot about this problem
until  I gave a try at freedom box images for micro

> It would be good if you can elaborate about that in the commit message, to
> show *why* your patch is needed.

OK I'll improve commit message with details I know
and also apply to the eMMC defconfig (testers welcome?)
waiting for Olivier feedback then I'll push a V2 of patch to:

http://patchwork.ozlabs.org/project/uboot/list/?series=389169 
<http://patchwork.ozlabs.org/project/uboot/list/?series=389169>

then feel free to annotate if you have more details to share

Keep in touch


