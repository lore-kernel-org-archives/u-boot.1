Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0948C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1021660838;
	Fri, 31 Jul 2026 08:21:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3I_RGVUxj0vG; Fri, 31 Jul 2026 08:21:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB93A6081B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486067;
	bh=Bl2EKV4YFewAGdJ3Iym9bw8hGHdjwqyJQMQdpsbmMzs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ykrot5d30rpXk/7JxvpQY/yCnhbgOas2upcs1mJwpQCTGz+oUoBbuMXACx8gN8sWN
	 opCgxl2b54ddHXrzL+/RIhHSnXHpye661+xSMjSUWT8bsA9wQPOMoUHUQAXjWz+Ic8
	 XtoTuKx6f2fUqAxx/q93xJnuXRSSGF4vGEbPA5XQjDgvlVKVFGZMjJ3aO0DqiFXhGt
	 zOEqr0CJS054SaJjT6WwJllwd5C/QqrweVFfyx7krZrcTAKzE9KWgQCkCHzZE6NmMo
	 +nUZAK531zjqzpQiEW8YkIgSyjuQRKfF++/+SPNmBlTYd4aJyzALm20uFiwQ95uSV6
	 BwAPazewwTRlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB93A6081B;
	Fri, 31 Jul 2026 08:21:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E2F7197
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:21:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4082A407E5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IqebfqKj44Hz for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:21:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E54B340573
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E54B340573
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E54B340573
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:21:04 +0000 (UTC)
X-Forward-Email-ID: 6a6c5aeafa390259fe06c854
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f8b7f22f-e68d-43e3-b29b-905586790e84@kwiboo.se>
Date: Fri, 31 Jul 2026 10:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] rockchip: doc: add more eMMC program examples
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.u-boot-project.org,
 eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <44039d61-ca43-4f12-8051-66fcbe0ce5a3@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <44039d61-ca43-4f12-8051-66fcbe0ce5a3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785486063;
 bh=Bl2EKV4YFewAGdJ3Iym9bw8hGHdjwqyJQMQdpsbmMzs=;
 b=Kt9Y+fEF7vM8W15sNzbsA5UlqASF8+rkD4n8XHEEiXDaqQOfYH1lR33kITWcVSsRFzzx9Ghn7
 ORBYVHd4oTrar/3c2mOP1OMuV+IQSE4uPnUDoAeYcWthlHVY6l/O9AOYCLusLJb4grntU2rI4p0
 l+VLYtLLGo/TFdKpMJNPjRIQJbr5dVnkIZt0vxy5sU633zpN7Gy/hSrJs69RXdo0EGRbnziyTFp
 CspcsRY7ODwqCp+ESmV3xIyYY60jzouGS+jUreAy6igs92jtR3fQ80yOWMWVz3AYiSi1o7v6WoL
 60oMwKoSPeRcQ1IaAtaQStX/LwRp4Okk3RA/V7u2raDQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Kt9Y+fEF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/30/2026 3:34 PM, Johan Jonker wrote:
> There are more tools that can program a eMMC.
> Add more eMMC program examples.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V3:
> use eMMC
> use list per example
> mention loader matching to SoC
> ---
>  doc/board/rockchip/rockchip.rst | 47 +++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> 
> --
> 2.39.5
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index af5c00591234..c089419b65e5 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -393,36 +393,49 @@ To write an image that boots from a SD card (assumed to be /dev/sda):
>  eMMC
>  """"
> 
> -eMMC flash would probe on mmc0 in most of the Rockchip platforms.
> +* Program example with fastboot for rk3399 and full U-Boot:
> 
> -Create GPT partition layout as defined in $partitions:
> +  eMMC flash would probe on mmc0 in most of the Rockchip platforms.
> 
> -.. code-block:: bash
> +  Create GPT partition layout as defined in $partitions:

We should really discourage users from using this legacy GPT partition
layout, nothing in mainline U-Boot depends on it beside the use of the
loader1 and loader2 partition names in this docs.

Vendor U-Boot SPL even look up partition names for FIT payload, but
not the legacy names we have here.

And newer RK35xx SoCs we thankfully no longer define the this legacy
layout in a partitions env var :-)

> 
> -        mmc dev 0
> -        gpt write mmc 0 $partitions
> +  .. code-block:: bash
> 
> -Connect the USB-OTG cable between the host and a target device.
> +          mmc dev 0
> +          gpt write mmc 0 $partitions
> 
> -Launch fastboot on the target with:
> +  Connect the USB-OTG cable between the host and a target device.
> 
> -.. code-block:: bash
> +  Launch fastboot on the target with:
> 
> -        fastboot 0
> +  .. code-block:: bash
> 
> -Upon a successful gadget connection the host shows the USB device with:
> +          fastboot 0
> 
> -.. code-block:: bash
> +  Upon a successful gadget connection the host shows the USB device with:
> 
> -        lsusb
> -        # Bus 001 Device 020: ID 2207:330c Fuzhou Rockchip Electronics Company RK3399 in Mask ROM mode
> +  .. code-block:: bash
> 
> -Program the flash with:
> +          lsusb
> +          # Bus 001 Device 020: ID 2207:330c Fuzhou Rockchip Electronics Company RK3399 in Mask ROM mode
> 
> -.. code-block:: bash
> +  Program the flash with:
> +
> +  .. code-block:: bash
> +
> +          sudo fastboot -i 0x2207 flash loader1 idbloader.img
> +          sudo fastboot -i 0x2207 flash loader2 u-boot.itb
> +
> +* Program example with rkdeveloptool for rk3308 in BootROM mode:
> +
> +  Use a loader binary that matches the SoC.

I do not really like that we are adding new instructions that depends
on proprietary loader blobs.

The loader blobs (for newer SoCs) is typically just vendor ddr init and
vendor U-Boot SPL blobs running rockusb protocol.

If you insist on adding this section, please add instructions on where
you can get and build a new loaders, e.g. from rkbin repo by running

  tools/boot_merger RKBOOT/RK3308MINIALL.ini

> +
> +  .. code-block:: bash
> 
> -        sudo fastboot -i 0x2207 flash loader1 idbloader.img
> -        sudo fastboot -i 0x2207 flash loader2 u-boot.itb
> +          rkdeveloptool db rk3308_loader_v1.26.117.bin
> +          rkdeveloptool wl 0x40 idbloader.img
> +          rkdeveloptool wl 0x4000 u-boot.itb

I was hoping we could remove references to idbloader.img and u-boot.itb,
not adding more.

Maybe adding instructions on how you can use U-Boot proper to run 'ums'
or 'rockusb' command to write boot firmware to eMMC could be added
instead? :-)

Or my favorite way is to just load u-boot-rockchip.bin onto a SD-card
and just use 'load mmc' and 'mmc write' commands from U-Boot proper
itself, see [1].

[1] https://github.com/Kwiboo/u-boot-build

Regards,
Jonas

> +          rkdeveloptool rd
> 
>  Note:
> 

