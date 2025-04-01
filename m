Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD76C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79E982132;
	Tue,  1 Apr 2025 14:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ipxe.org header.i=@ipxe.org header.b="oTfWRFlB";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="Ez/BQAFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBB281FBC; Tue,  1 Apr 2025 12:30:03 +0200 (CEST)
Received: from a7-18.smtp-out.eu-west-1.amazonses.com
 (a7-18.smtp-out.eu-west-1.amazonses.com [54.240.7.18])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04BBC801FB
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020195f0e69d3d-62bda5e5-5a41-49e5-9e2b-714265943efa-000000@eu-west-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=fvumhlyyi2m7uxyrun4agiymlewwagjt; d=ipxe.org; t=1743503400;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=DPiudnVL5k+/5K7yzqUrasd/B9P4AAidcZA6SxruEiU=;
 b=oTfWRFlBuiJWtkGAdXzVrHVvqVzyVLNhAI/T1oyk5G3tKPk2SKFR/7fhuDhUE1l4
 SCUcHuSAzzSxxoKCWacWebKdUvBoeJRjptCzjIgels/ZjFcC3S0n39Hxa8wYB7wP/Sx
 qsAn6QzvVCuMGj+9ABNNwtF1MSgQQ/8FFFDKNDx/43NJyRQcrkZ/dFNifBhzJYOgrww
 3SPXyj24pYAOqosNxTy6ksV+PCTHgjYtO4+wUnm4tIBDZE6L4mWka2bUBpTZckb/1ni
 Uj8KJeRgGKlYElsrFUCjkE+JO3HrZa9BwR8Gr3bGc+OH4vKFXcLdyAyOmpiaBtzFaFI
 +vC4C+tZmA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1743503400;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=DPiudnVL5k+/5K7yzqUrasd/B9P4AAidcZA6SxruEiU=;
 b=Ez/BQAFYE+12BfRtFHiioYCgSvYPXIX7kefmupwf02NMtuT8q1sWSMQAX+9VGS54
 NsSoBqplD/PBxvAo6e5g0pwAGOjqan0ouX/TphGWCHkVeyiKB482ACk+6Daag9iLAp0
 pybJ2eracdc9Mjc93o2UApipUDlXUems0gQ82XWQ=
Message-ID: <01020195f0e69d3d-62bda5e5-5a41-49e5-9e2b-714265943efa-000000@eu-west-1.amazonses.com>
Date: Tue, 1 Apr 2025 10:30:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Brown <mcb30@ipxe.org>
Subject: =?UTF-8?Q?Re=3A_U-Boot_interferes_with_initrd_binary_=E2=80=94_Reve?=
 =?UTF-8?Q?rt_=22efi=3A_Correct_smbios-table_installation=22_=3F?=
To: =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
Content-Language: en-US
Autocrypt: addr=mcb30@ipxe.org; keydata=
 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
In-Reply-To: <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2025.04.01-54.240.7.18
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:32:32 +0200
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

On 31/03/2025 18:31, Christian Kohlschütter wrote:
> Whoa! Good eyes, Michael!
> 
> What is my Fritzbox doing to my initrd, and why does reverting the commit fix it?
> 
> FWIW, I also have a capture with an ethernet frame from another device on my network (ARP, ethertype 0x0806), so this is probably the content of some ethernet receive buffer...

I've taken a quick look through the U-Boot codebase, and I can't 
immediately see where the Ethernet device gets disabled as a result of 
calling ExitBootServices().  It's possibly worth noting that U-Boot may 
have relied upon iPXE's behavior prior to commit 
https://github.com/ipxe/ipxe/commit/562c74e1e:

   [efi] Run ExitBootServices shutdown hook at TPL_NOTIFY

   ... <snip lengthy explanation as to why we need to do this> ...

   Avoid calling into an underlying SNP protocol instance from within our
   shutdown hook at TPL_NOTIFY, since the underlying SNP driver may
   attempt to raise the TPL to TPL_CALLBACK (which would cause a fatal
   error).  Failing to shut down the underlying SNP device is safe to do
   since the underlying device must, in any case, have installed its own
   ExitBootServices hook if any shutdown actions are required.

So, older versions of iPXE would have called Snp->Stop(), which in 
U-Boot's efi_net_stop() will call eth_halt().  Current versions of iPXE 
will not call Snp->Stop(), and will rely on the underlying SNP driver to 
have dealt with its own ExitBootServices() requirements.

I can't find any evidence of U-Boot installing an 
EVT_SIGNAL_EXIT_BOOT_SERVICES event to call eth_halt() when 
ExitBootServices() is called.

The closest I can find is a block of code in U-Boot's 
efi_exit_boot_services():

   bootm_disable_interrupts();
   if (IS_ENABLED(CONFIG_USB_DEVICE))
      udc_disconnect();
   board_quiesce_devices();
   dm_remove_devices_active();

but I don't know precisely what these various functions are supposed to 
do, and I can't find any path that leads from any of these to eth_halt().

Is it possible that U-Boot is failing to call eth_halt() in response to 
ExitBootServices(), and is therefore leaving the network device active 
and performing DMA while the kernel starts up?

Michael

