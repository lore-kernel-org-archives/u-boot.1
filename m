Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D960CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEBFB606F3;
	Fri,  9 Oct 2026 13:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wO3GNChXDBlK; Fri,  9 Oct 2026 13:42:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1F186069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791553330;
	b=iYfbetr/kmXuggAGKme3gGz5hq5xuVc7KbgP/oAptmkLtVOxACW5TScWIW7vvtjkU8SE
	 0Zb0o4+ebQh12q5sH9wySa6cweuo6CjyD/3RXdHZJkNvz/Mvu7I4DOCigcx92QlmI5gJ9
	 a8gy4Xqz6btL3/OVytUlrhRH/B4UwzI8OcsAP2CCzQKCf2xA/9mKWw01ppDR62HAFnh/w
	 myCz3wRhRjdJDw494z4QDCrsbjxVdGPDaLhxSgzw+1NMTjOFbqsx2m+RDaPv0TQbFZ+Fy
	 U8wtIu4aOGWfawOk6/o1TD0JIlKrgHdLDGu8xxR04qpkReYkuraP4Rt024Tj8J7kTuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791553330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rIUm2Jd05pWj/56E5mR2bmAp1xCvbRS4ZzRWtj1/pK4=;
	b=ijV5pKd9q7cuJUx4VHDPRGLi0R8vuC9ZjEEmezfyUvzNgDafiHe+DG6TllIdf5vit+3g
	 oqhAwii1l7U9WxJsvUWPcaPkdvZ7j3lN4gOEShNbDRfRPRrNT4BJ/3EG7frcQcRfOJ/PT
	 khHh8gR31dNP3oZggSNZGH//2rXQUo5tY4TH7gJbXb20DsTP9Xv7rVRsQi/ahwwx5EaZl
	 2ThcWWQ0CJYmWpEIoHxoLKnqcxM23sTslg255vB6MhcG24VCDs7hntVj3whFKH0HrORLl
	 VsEF4MXggdQGgUXbp5cizNYZ131d8ETPZqV0c3aXFBXNqques3gzu1L5tzbAZicVNLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791553330;
	bh=rIUm2Jd05pWj/56E5mR2bmAp1xCvbRS4ZzRWtj1/pK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXZnzfGA1T/KH5k1tl50HnSQVkEimo3HhbKoQITfdB3ySfXFdrrbx2u5LYsNlWuTr
	 3mH+BjZMWzTPacLnbyF9DmfzJv2vgxiSB4L7iYb5iRJqkCGD3vit5cGgiB88ndiVFm
	 A+s5H2iufFnJfXgXGLM7RzMGHFOppuhF4430bpP4mKLQ7yMSJ4DGV71y80q3prV3nA
	 L6Fr4rVVlXfLoSLe84uK06Be5oHmKc0UH9X4Jj5IBRjFoggRMu8Qkhtxy+A1FJojhc
	 uqGpG8xDPdzGxeE1ykbCWHHTtTpClOzVMwBAcktIV13lzVJkwGPMnbveT3MJR6qzxX
	 ujmJHoxv0+/yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1F186069F;
	Fri,  9 Oct 2026 13:42:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5ED3184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABDAB4090C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UW6UzlnsykGs for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:04:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BB5B40917
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791547459;
 b=e21eaazF4UkRO8a/nZw0kxRmHprTWscG15HHAk90EGpEhywxrmEguzQVc5MELp59eM+v
 cqqBK9ppWiVmRGEhkkc8Mh4nI5Lscmxh1jQjC+WLYb5sxKyKOCEc2DZYODYcJRuW+8UlT
 c5v1wIaWHcMF41PYxBRLkoWqlGOW7ZS3apibujDaawglRO3goPobaIkqjBO+hzzEjT1Fm
 ZpqqKCzAQgkvn/fjbsU9QMH0rtFFU2FWYk89W+0/VJq22t6ej5I9HuN+yIqseIsvs/2n6
 Ffdv9z5V/p5L6wgjGd2cXisrVFVbxwJoHTP+2MMaqMCUvVzzkmTtVIFdrm14jXe5EZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791547459;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=rIUm2Jd05pWj/56E5mR2bmAp1xCvbRS4ZzRWtj1/pK4=;
 b=rqwrJIzUO6mZPZU5JYrGjHL/y5AueFWEc/0VBLSXUiR5xh8f9JH1VIo8WCLNWtVubtK9
 Jq2kgFXYu0t5F3ThGC0kA41tymRp8Sa52Vq+C63a02ngdUasRuyhLVNsM/SBiAZy4HTy5
 o8M7qVrgyLN2sZqxknj4PwjjPAR3w0+c1GSgRrqf/EMP2v0Bc72Z6PuvHuWtCWeQ8rG+E
 NngagKNNYAmOzWKhTFiwivY5tXwtn9zD2wNe56vYau+nA+dNzbX03MC9ZF3IPHEjyY3J0
 z+O+eNAgCxwu7kVrnmD/WlBwE/ti3Fi7+aH3EDOUxhnk20ZFLtoZdEZGZgOqsR17b9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=H3HhQKkQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=H3HhQKkQ
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BB5B40917
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:04:18 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1419d3416ceso12258315c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791547458; x=1792152258;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rIUm2Jd05pWj/56E5mR2bmAp1xCvbRS4ZzRWtj1/pK4=;
 b=H3HhQKkQEO30z353LGxfu5dJwPMYUQBSscivUjnoSSIcd9R8sm+yQTo1Y1/7dvt5x1
 W/vSZXPLHErv69vJZBXuzbDc9+8Nc7jG9PJcBjHXc6EBPIpdUWNC/KBb0SSIoUALjk21
 umBzIICfHJnM5n72i7NKiA5vc+HK33DZ3jG8CDsc2eZdJdFn1NLo8M8vyDF6Q/7+2f2S
 3rQgT8OYna7X5FC3MuCmtCV7QCMWihDbAqfzwNy66uvEx/7q6aQNac4U2kPTGxeHDTA4
 W+GAA/LzjRQYs7wLe/pYS+J/JfypHJE064DP8u7TBoiuwA8+w5gveSbv4TxT/8g/ruDE
 8keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791547458; x=1792152258;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rIUm2Jd05pWj/56E5mR2bmAp1xCvbRS4ZzRWtj1/pK4=;
 b=nCZnzbTuomAfnh1aBdoRadX3sZ9pWFvzgoPM7Jvo18GMcbZhKVmAcy0hzHQmD5coNU
 5zVT7PsA3W8vJ8/ofZaJUYUfD0Te0slF8Qc6nXiHIbo87+dlbbnIPmGTNfcPbKDg/m7z
 284T/yIYP/O8cRDZufHaRAJUUkDjxMqBX99emHk3HEZa7xsXLaqzaURfha0qxweIZ7rT
 ZRXlNQ8La6ZLRQfaSrWDlSEK2ksLy7y70DGPae6dnCohJuFTIMXimq7BIp1cuLQZeXdW
 Tms1/IGVMslXKJDT/3WJ8cU+BqbB1ORhfZYhbSaWAEkw+mFXrYwspEEQOPdzVNpN56Qt
 ilow==
X-Forwarded-Encrypted: i=1;
 AKwUvBx06Jx1lKo4jBB5CWrQxvsqgL8fjrRuEAX1DI7UKDMkqqyHMwtxWhjoJmmoc/xKN6EQRxHWE2M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nJtqIG/sPr4d9koXkqMJTTw1PZmBN0O/DZSE6WhL/Odxt12mq2
 2o7wFerLzxFBprfnRloNC2/q+QfHdFLbSepkpDGtfW+zyWYVqVyri/9Q
X-Gm-Gg: AYBFou1PcYutZacAO2X62CqoBuLjuNt1HhARts50enMRvqIdEPYuHBNR2pq5cAEZBMl
 9ZbfEHZrHZ/rMtAoVYuxBEw+Vd0dDksdMVIcFS5umRxwwWSiiU63NxsnIUEGM9kBFAvTfX9Pq3u
 15i9iUQgPhrNqbH25+albRDJ2i3b4wsjGNzeSBKOAtzpdxKGuFRpjl1piIKTYeJCzLn4XKhQe/l
 TZ2L/eWoEtx5b1aCoD9RuB0xY1bcGw67+V3FLRIAK5T8sobN8jQhQfjQqmbTaiMxL2HhQ+QBFQS
 2qhY+NfPR9By9XWcxyFzgSzwA/3Atoc041AsAKe88uoaZ4uvJtePhsi00QGTyWtSGXGh6H+l9Qr
 iv2Lf3DkLW5U/JeYap5a1TnwRjazu3OAJyGBmMSHZATm4Eh/JMT3+daNWpEq17ZPNoPWLzLouph
 PI8+VmMnFH98BQw90zwonXAhuTW+ZqJGG+2frQaOW++/WtZiu9XwwU/pKDPk57ROslI/0QGmfrK
 hy4kjqW7GTzJhJgz6BFaChRHNhjTAcqcUFchGjijYewV9gu9YNGbPaK4a3o+Nd8tPniQcl4pBoC
 Ovh419c=
X-Received: by 2002:a05:7023:908:b0:143:8860:afa1 with SMTP id
 a92af1059eb24-16a63386a1emr2265270c88.46.1791547457414; 
 Fri, 09 Oct 2026 05:04:17 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becf08sm7294837c88.5.2026.10.09.05.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:04:16 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.u-boot-project.org,
 linux-sunxi@lists.linux.dev, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/9] sunxi: Add support for A733 SoC
Date: Fri,  9 Oct 2026 09:03:55 -0300
Message-ID: <20261009120356.194364-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 13:42:07 +0000
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

Hi Yixun, Andre,

I'm porting U-Boot to the Radxa Cubie A7Z (A733, 1 GiB LPDDR4) and have
a board series (DTS, defconfig, MAINTAINERS, doc) on top of your A733
work. Before posting it I'd like to settle the base and the boot flow.

With A733/next (165f07a69706), TF-A A733 (f4c0b0dba78a) and sunxi-tools
PR #223, the SPL/FIT flow works here: boot0 trains DRAM, drops into FEL
on "2" over UART, and the SPL loads BL31 and U-Boot. I had to clamp the
SPL's fixed 2 GiB to the board's 1 GiB, and BL31 was linked for DRAM at
0x48000000, which the vendor kernel needed.

Andre's suggestion from January works too: load BL31 and U-Boot proper
directly over FEL, no FIT. I used BL31 at 0x48000000 and U-Boot at
0x4a000000, then reset64 into BL31. The RMR request gets the core to
AArch64 EL3 without an SPL, and the same BL31 and U-Boot binaries reach
the prompt.

What's missing there is the RAM size. I couldn't find a usable size
from boot0 in SRAM after entering FEL. Without it U-Boot falls back to
get_ram_size(), whose probe range covers BL31 and goes past the 1 GiB,
so I didn't let it run. I added a "reset64-dram" command to sunxi-tools
on top of #223: the thunk writes the usual SPL header with dram_size at
0x47000 once FEL has handed over, right before the RMR request. U-Boot
reads it as is. The A7Z U-Boot came up that way with 1 GiB from the
header and a working SD card.

The default SRAM BL31 layout clashes with that header. BL31 at 0x62000
has its .bss at 0x46000-0x48400 and clears it at startup, header
included, in the SPL flow as well. I ran that layout on October 7 and
got 1 GiB at the prompt, but didn't trace where the size came from.

Questions:

1. Which base should the A7Z series go on: A733/next, boot-2026.04 or
   your next revision? The A7A defconfig differs between them (FIT at
   0x4d000000 vs 0x48200000). Would SPL_LOAD_FIT_ADDRESS and
   SPL_RAM_DEVICE fit better as SoC defaults?

2. Andre, is direct FEL with an explicit size header something you'd
   take as a documented boot path, or do you prefer SPL/FIT?

3. For the size handoff, would you rather keep the header out of the
   BL31 SRAM range, or use another interface? I'd also like to replace
   the SPL's fixed 2 GiB without a board-specific hack.

Everything ran from RAM on a single board. Linux, secondary CPUs and
UHS are untested with these binaries. If nobody else is on an A7Z port,
I'll send the board series and the sunxi-tools change separately once
we agree on the approach.

Thanks,
Vinicius
