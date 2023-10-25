Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2874BC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 03:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA3786D0E;
	Wed, 25 Oct 2023 05:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="xB6oMUhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7781186E75; Wed, 25 Oct 2023 05:01:03 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CD386BD4
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 05:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so842281a12.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698202859; x=1698807659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0cs7qZuvAA0zk1Xa58tN+KEmlNz3dGnQTdFf7gPDD2A=;
 b=xB6oMUhXgBwYqLujQBAjnSeqi2+s10Zo49aLuZ348H1aeXW5sAe1NlfS5RHQa/ufZ1
 uvBcANDgz1GO4DYkZF5to1WyXOuNzGmDrCxL493Jhcxb+fZ6q5Tx0lVJR3eD2UnxZ4Dr
 RrpjugVl2DNPTfsTg7m/aUsst45Ch2VkXR9EdEKJdCsPJ7M0m9HyMg+l2GLJzcxg2oWI
 vupUvcoslI3l7+vOE7Qcexnyar0gRvXnEGYqnV5XlpxgyApKQs0WgzGDT7XIAvB4fJwl
 FzCxMO9U2SDxe+kKUndSZv2/aGKkCEbAMr9Za8qg+laZweD2OCKCpRJipw5KRry1bAa9
 i4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698202859; x=1698807659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cs7qZuvAA0zk1Xa58tN+KEmlNz3dGnQTdFf7gPDD2A=;
 b=eYqlx8rfKxPre+E4MNu7kRqNtv2hWe6PDlLo6Nmkveu8Hj1jlbT5Xw+zKL/naxLUMb
 XbtJf7eh8CkBb59GbMwKEXg5nE+eyXV0aN9Uq3CGExvfYxQQQzL78A5aAZUUIzHYXkbT
 dAhofAVGM5Wi6qOJ1tJ9v+1+ppAeVUui3hUhaujfMY0ir2XgEEFS+3IhSc3zEUWOZGeY
 917NjH865SnuEdTo/lFsPg7iFNGP2j/Is3IVgbvCoo7y4KSQ9Om91cgJ4R9UvPxWki0l
 MgjwyI8P0turik3DU/8ljK6R5ieyI/qc7E2k/7ZEKtdpEjnPrZU6ErQDtsX0BHywCaMu
 Uxsw==
X-Gm-Message-State: AOJu0YxzqYYtdpecVItjvWDqtpsgYD3KIezYT4MNPJPkRaYHL0LfIH6Q
 RMt91xTPEtpE4lUSEuKD1+JNtfQB4AvvXKSyJDog3Q==
X-Google-Smtp-Source: AGHT+IEu1AMiAWAL0dz8Qj52phoNZJtEeeTytFPH4P6S01CQ7pxVqB0Waa9Lb8YVh7Y9UVy6lP+cVd5R0AjwFPAO8Fw=
X-Received: by 2002:aa7:c54d:0:b0:52c:f73:3567 with SMTP id
 s13-20020aa7c54d000000b0052c0f733567mr14158859edr.13.1698202859247; Tue, 24
 Oct 2023 20:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <279f2b49.1e2.18b6422157c.Coremail.simitel@163.com>
In-Reply-To: <279f2b49.1e2.18b6422157c.Coremail.simitel@163.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 24 Oct 2023 20:00:47 -0700
Message-ID: <CAPnjgZ1cRPTCc6SX5-htrH=RCVD52CxjGKP_=c_9dZBNnd3MtQ@mail.gmail.com>
Subject: Re: Failedto read big file with "Invald FAT entry' from USB disk
 (FAT16)
To: simitel@163.com, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

+Heinrich Schuchardt

On Tue, 24 Oct 2023 at 19:34, target <simitel@163.com> wrote:
>
> I am using u-boot 2017.03 in my system and enabled the debug in fs/fat/fat.c
> I had a USB disk formatted in FAT16 in Linux, I put a bigfile.bin into / in the USB disk and plugged the disk into by board.
> Then I want to read/load the bigfile.bin into RAM with u-boot's fatload command, I did followings.
>
>
> # usb reset
> # fatls usb 0, it showd,
> VFAT Support enabled
> FAT16, fat_sect: 128, fatlength: 128
> Rootdir begins at cluster: 0, sector: 384, offset: 30000
> Data begins at: 256
> Sector size: 512, cluster size: 128
> FAT read(sect=384, cnt:2), clust_size=128, DIRENTSPERBLOCK=16
>  36438016   bigfile.bin
>      1012   s01syslogd
>      1004   s02klogd
>      1876   s02sysctl
>      1684   s20urandom
>       214   s21mount
> END LOOP: buffer_blk_cnt=0   clust_size=128
> FAT read(sect=385, cnt:2), clust_size=128, DIRENTSPERBLOCK=16
>      1635   s30dbus
>       438   s40network
> RootDentname == NULL - 13
>
>
> 8 file(s), 0 dir(s)
> # fatload usb 0 0x100000 bigfile.bin
> reading bigile.bin
> VFAT Support enabled
> FAT16, fat_sect: 128, fatlength: 128
> Rootdir begins at cluster: 0, sector: 384, offset: 30000
> Data begins at: 256
> Sector size: 512, cluster size: 128
> FAT read(sect=384, cnt:2), clust_size=128, DIRENTSPERBLOCK=16
> Rootvfatname: |bigfile.bin|
> RootName: bigfile.bin, start: 0x3, size:  0x22c0000
> Filesize: 36438016 bytes
> 36438016 bytes
> FAT16: entry: 0x0003 = 3, offset: 0x0003 = 3
> FAT16: ret: 00000004, offset: 0003
> FAT16: entry: 0x0004 = 4, offset: 0x0004 = 4
> FAT16: ret: 00000005, offset: 0004
> FAT16: entry: 0x0005 = 5, offset: 0x0005 = 5
> FAT16: ret: 00000006, offset: 0005
> FAT16: entry: 0x0006 = 6, offset: 0x0006 = 6
> FAT16: ret: 00000007, offset: 0006
> FAT16: entry: 0x0007 = 7, offset: 0x0007 = 7
> FAT16: ret: 00000008, offset: 0007
> FAT16: entry: 0x0008 = 8, offset: 0x0008 = 8
> FAT16: ret: 00000009, offset: 0008
> FAT16: entry: 0x0009 = 9, offset: 0x0009 = 9
> FAT16: ret: 0000000a, offset: 0009
> .....
> .....
> FAT16: entry: 0x020e = 526, offset: 0x020e = 526
> FAT16: ret: 0000020f, offset: 020e
> FAT16: entry: 0x020f = 527, offset: 0x020f = 527
> FAT16: ret: 00000210, offset: 020f
> FAT16: entry: 0x0210 = 528, offset: 0x0210 = 528
> FAT16: ret: 0000ffff, offset: 0210
> gc - clustnum: 3, startsect: 640
> FAT16: entry: 0x0210 = 528, offset: 0x0210 = 528
> FAT16: ret: 0000ffff, offset: 0210
> curclust: 0xffff
> Invalid FAT entry
> Size: 36438016, got: 34471936
>
>
> I have tried many times, even with "fatload usb 0 0x100000 bigfile.bin 2000000", it still failed with above error.
> I can not test newer version of u-boot, since there are lots of old drivers I am using.
>
>
>
>
>
