Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBF3C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CC687D82;
	Tue, 20 Feb 2024 12:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=reposit.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mailprotect.be header.i=@mailprotect.be header.b="O5DWswAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A942D87F52; Tue, 20 Feb 2024 11:48:21 +0100 (CET)
Received: from com-out001.mailprotect.be (com-out001.mailprotect.be
 [83.217.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFB987D4D
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=reposit.be
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=spamsink@reposit.be
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 reply-to:sender:bcc; bh=bZcXCyQlz5fDhwCyJP+v3MVcWc6NaUMyLdlHsGdVfMQ=; b=O5DWs
 wAGoZy8CUlI7wi8XYDi/i8HFIDHRzClprR8MphjOHYVBkEkG1jSA0SaFAHeJjOvZDz99HsFRjCHoy
 uiNDBcmEw5ETI8zQBsFmex9Ps0Ujl/VgWtWKP6cdnnQneyG7wDPXboplVNBL6sDguvzIjz8Fayukp
 9s1bJuJEu0c670RzSBYAy6nd+q+cgt1qPDlVSuTTTlWG+vuTksnK9QLf7xUtruV0YP6SUaLx2OArl
 JAsB0ACb7pZLp1HBpNE9/7QaS9AsxnEGR+rRJ16nm320jHLljrIL8d+TDT+psqfNUns5g5n9/NiLa
 mbag1Izy5mForuNA6sO8IAMIT2few==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
 by com-mpt-out001.mailprotect.be with esmtp (Exim 4.92)
 (envelope-from <spamsink@reposit.be>)
 id 1rcNfD-00FMMA-Fz; Tue, 20 Feb 2024 11:47:52 +0100
Received: from [192.168.2.116] (120.249-131-109.adsl-dyn.isp.belgacom.be
 [109.131.249.120])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 2E8B1C0145;
 Tue, 20 Feb 2024 11:47:51 +0100 (CET)
Message-ID: <444b4db5-b762-4599-99ac-5827f6de7f81@reposit.be>
Date: Tue, 20 Feb 2024 11:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How To Move Root Partition From eMMC to SSD
Content-Language: en-US
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <eb9a091f-9f8e-401a-bd71-a9a3511a21b0@reposit.be>
 <CALeDE9Oy3YgAE1rW6kVimYybQpq-h4PEPKkvG7WuwHv1zFZ2+Q@mail.gmail.com>
From: Spam Sink <spamsink@reposit.be>
In-Reply-To: <CALeDE9Oy3YgAE1rW6kVimYybQpq-h4PEPKkvG7WuwHv1zFZ2+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be;
 auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/LclLF+d5qBKpOuliEyEgrPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zLxcsAtc0AxbM7NAq0eoKJhm7Wn5RPv9bU7t0vZ9aIQH1a
 0DJ+b/SgCu+AdGqtMFGceEiKFEfUYPWZ0gk+PNKAxaK45aVeAEKQk278CLO1KlGavff7/jlq6fkm
 O4krnmvBLjX540LEall2D33XsAZHsN9dFtaDdX4G2JtSh1MW4DKi2t+FYZlHRQpKkcY41094/Odx
 ovv9CJ8DeAu6sHFBdnrLabUgNzEO/QU0BfnnNOd+WLFOM0So3rJR5cRvcK50w9Wr3qLZYKKaXd/z
 pCPr3ukajz0++WUAVTHPi4utW+nE6wHyAbSyVXutrqMjgFLX7D3r+yzaf09FesHDYiVhb9lLcno8
 +LMWQktE6OGVK+l085HUneNJLb49A9kZ4q0bCRPFibWJLI3C/DG3imYUL4QFy0eB/isP83e9uHLE
 BeHTPI/rzJIRbhotX0RECi73tAkKkqOraDjBQ0V6Jl6cNXf0xLkfge9mzM1qtvMzGiYxT7p/s9HY
 sq8PpN/9QE7dZh03ExTqDquACpNsmDrlcntZzD+8euQ3PTJH+fGZGHMcN6qoXPjenLhIOF1oeRZi
 w/asA3gqiCsSahbDNh51lfj9j/UgQbPDs81InVAWXhQ+D7uUqWW7lr71mUAnQK0O4VWXDfBpByWd
 e7nT/lT4MzfVS2F5zx6Xv1wYD5pggF9L2zldRguLVknTBH19KmbWXGH5SDG2kyRsdcYPy9St+qJK
 V/NvwbV06JaLnkml7NEyvDkN3AfUBddcu9g0UhykBJTycjSXYBbCRRLP/dzFIBlzvTEDJe7e8l++
 Pz+86OQJyPsBMRItmV2XMBZo/xvRvV1DAYDQzvjZDRqMBVvkRDdj0FLm1Ou4eCELljzGeByrLEiV
 YnZBEe1WauMnlc/KATDDBZ7fFc0FDw0l2bg+/rVyvOTVreAmAaNpe76fU4XjPD5cu1DZPbPiUdvQ
 5iKkASe0zzIoSVH5jzhBWWljqBsEh5wxUOD+GA7ZQVwcq03nFL4yr42TjbS14OCo2rmWn8fjrynD
 skL1KLEvQjvy
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
X-Mailman-Approved-At: Tue, 20 Feb 2024 12:03:22 +0100
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

It's very kind of you to get back to me.  I got it working in the 
meantime.  I am working with a U-Boot fork from FriendlyElec 
(manufacturer of the NanoPi R6C), I think that might be different from 
the rockchip fork.

Yes by SSD I mean NVMe.  I wanted to put boot and root partitions on 
NVMe but my understanding is that the R6C is not capable of finding the 
boot partition on NVMe, so the best you can do is to put the boot 
partition on eMMC and root partition on NVMe.

FriendlyElec package for the R6C half a dozen OS images, all of which 
share the same custom kernel image.  I am using one of their ubuntu images.

In the U-Boot monitor, I tried to override bootargs to change 
"root=/dev/mmcblk2p8" to "root=/dev/nvme0n1p1".  It didn't work.  I 
looked at the source code of FriendlyElec's fork of U-Boot and it 
appears that it ignores input from the monitor.

Instead I modified the source code of the FriendlyElec U-Boot fork, and 
hard coded the change:

     env_update("bootargs", "root=/dev/nvme0n1p1");

This worked and now it loads the root partition from NVMe.

You say that upstream U-Boot can boot a Linux OS from NVMe on an RK3588 
device, so I don't know why the FriendlyElec build is incapable of doing 
the same.  I might try to use upstream U-Boot.

Regards,
Eric

On 2/17/24 17:36, Peter Robinson wrote:
>> I am running the NanoPi R6C.  The device is not capable of booting from
>> the SSD, the next best thing is to load the root filesystem from the SSD.
> 
> By booting you mean loading the firmware from SSD (by which I think
> you mean NVME right).
> 
>> Using rockchip's repos, I compile from source the images to boot 1) from
>> the microSD card and 2) from eMMC.  I install to the eMMC.  Then, so as
>> not to mount any partitions from eMMC, I boot from the microSD card, and
>> I clone the root partition from the eMMC (/dev/mmcblk2p8) to the SSD
>> (/dev/nvme0n1p1).
>>
>> I boot from the eMMC, the output of "cat /proc/cmdline" is:
>>
>> storagemedia=emmc androidboot.storagemedia=emmc androidboot.mode=normal
>> androidboot.dtbo_idx=0 androidboot.verifiedbootstate=orange
>> earlycon=uart8250,mmio32,0xfeb50000 console=ttyFIQ0 coherent_pool=1m
>> irqchip.gicv3_pseudo_nmi=0 rw root=/dev/mmcblk2p8 rootfstype=ext4
>> rootflags=discard data=/dev/mmcblk2p9 consoleblank=0
>> cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1
>> androidboot.fwver=uboot-a83a7263ef-01/09/2024
>>
>> How do I change "root=/dev/mmcblk2p8" to "root=/dev/nvme0n1p1"?
>>
>> I connect to the serial port and get to the U-Boot monitor.  I examine
>> the variables.  "bootcmd" runs "bootrkp" which boots the system.
>> "bootrkp" ignores "bootargs", I confirm this by deleting "bootargs"
>> before running "bootrkp", the system boots up as before with no change
>> in behavior.  "bootrkp" is implemented in file "cmd/bootrkp.c".  That
>> code emits the equivalent of:
>>
>> setenv bootm-no-reloc y
>> booti 0x400000 0xa200000:0x7b2bc0 0x8300000
>>
>> Can I tell U-Boot to load the root partition from /dev/nvme0n1p1, either
>> by entering commands at the monitor, or by modifying the source code of
>> U-Boot, or through any other means?
> 
> You don't mention what OS you're trying to load, is it Android?
> 
> So upstream U-Boot can boot a Linux OS from NVME on a rk3588 device,
> but it appears you're using the Rockchip fork and I have no idea of
> the state of that.
> 
> The upstream U-Boot doesn't yet have the R6C.
> 
> Generally if a device doesn't have something like a SPI flash where
> you can put firmware it's fine to use the eMMC for firmware and it
> should be able to run an OS from NVME.
> 
> If you're not using Android and are using a standard Linux distro I
> would look at enabling "distro boot" in the rockchip fork which will
> give you a standard UEFI boot interface and things should work. I have
> no idea if the U-Boot fork you're using includes PCI or NVME support
> but obviously make sure the appropriate drivers are enabled for that
> (look at the upstream Rock5B config).
> 
> Unfortunately I can't offer much more help from there as I generally
> only deal with upstream.
> 
> Peter
