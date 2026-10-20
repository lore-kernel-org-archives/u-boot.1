Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EF606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xsDW7dOK;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pZ7A0VaU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D118607E2;
	Tue, 20 Oct 2026 10:44:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQxu3E3wfwAO; Tue, 20 Oct 2026 10:44:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF37F607AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792493076;
	b=RMQIIt+HI98X3r1x3NkX7ofSBpUy/xAHbUmThowvtL75tml9Kyj2ZSaI6XhiGsjXCrz8
	 WI1rXQaAdx5958WgovhyJNS4UbyT17xdL8xSr5NTy0UBO6k2ZWhwn64CscmPxBrylgq/E
	 K96NULaU8Zfx4ZT+UjS9et+gE+HfnkxIR+ydHPuY5MqKO2VMQ3LmrGPe8L8S3xHN5PHx8
	 Qyq6wW7PcF4usQEIzD9QPtjwbTRSFYkPxdsYtelEMRLyua+E7dZAd4BxEzheJ4oJ86T1O
	 gctMRqfTKhoAlwPIM2u/BGDCssF6bKpK1tlKtDwHJA1buza7/WyBN5z5VMkuwIh62tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792493076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jFYqfUrHx8mdXqLKQ6odkHTuLjMzqwkUxEInl9RPttQ=;
	b=eJbI+ubEWD/kf60Q9XZyH7v9iIyPdxCnulsiBcmjI1wSys2I/+PMIuDkCwtEzYXX1iLg
	 l9aIleCbFbCQgjSXPdxroUqVVyXL17v7LOpUVyn5djiN3XYM/EG0iWMNg6RYJy5RuARNI
	 SSisU6qqugj/hCwXME3pA3o1aOXNu5+/hiPGvP/Ep8zXY1h0sF/G4/oIzx+g2CyiqdGJn
	 odATCWIiOZoVjkERRo/LLy8sbiUcMJqsmA6Ru+ng8aga7ETAfKEHWlwJkjRuofL+QN8FJ
	 1FRgumVSwfcXopwlBoVUwRgWqGOBmdHIxNZU2mYoa19j9s5RvO3CQP4DRTC6KjOdKaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792493075;
	bh=jFYqfUrHx8mdXqLKQ6odkHTuLjMzqwkUxEInl9RPttQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xsDW7dOK5DJ3MVNykZxYG8BZa85CDc/IaG+xinA9iBZTOgAGMFMpll/omu4qwpHdT
	 K7kJLkeAPXwvGxyCivYtvNsjTGsaPG+Ye1jOi5EpR0xM/atQpJlpiJPT1Ya1zpm1v5
	 zlCxwBWHe621QQsxm8LYYrWhDDVF7LHn2uCNLt//Kp49YRVd/Qfp+U/c2yQlWseiT7
	 FLqIBnvAaX9ry/q4QR9Yt+dkpHjjnwNJ6kxg83Je+hWXz39bH/4llZrqvxIIlDCp2h
	 1gBsY98SiCvf+mveBzUuGa7LjmjTmYD+ZOfvl0e0HbhjoUBE6zaykb+sQ/vz5frI1C
	 nMEINDMdIrsTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF37F607AA;
	Tue, 20 Oct 2026 10:44:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 866971E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 784C440119
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bShpm8k6KDba for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:44:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1C5B9400FC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792493073;
 b=EpbcACpkzeSQHRZEuuTKmAEMaDdjD/vyDdWmFMAsF6Z4w0w9oLw8cE0Rot56dQk4QLhY
 2y4W6xguYEjHAlng1KP3tndWr0JHX41Q+U4iziRww7NeV0jYlHUQOc9AXY6OGlXpzsmzX
 TPJHntSX+jmxUNJ1K0jyInPYn9Vd4KVp71YqwiuXZ4OnaK23+wvxaHsR+sZNp7ZMHKk6u
 GrJKdnKEtYX/9MvkMbMNIMy/atKrflug+6valXgTbm8rLHeBA0lGwz8H/KmGnHpIH6shX
 CG6khhhI9+3nk5bQ5+TDf3+SFMEA9fKKChI1UoCcwFZqcaw3UMx7bCXPndKUNMuur5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792493073;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=jFYqfUrHx8mdXqLKQ6odkHTuLjMzqwkUxEInl9RPttQ=;
 b=Jm12reNDQyIODwK/HspeP2oIkFPxYg4auGOralo4yBbKSSqegVYjH38ZeYHbpuv35lB/
 45NgwD/NsIdlH5hScO/2J0TKz065Ml/SapV/rrJmeT0cOhfYKss81XuofjEpFrDiSN5IE
 nmIPe99XtCy3ca4a8GFZfh2zP/L4EtQJJEnNzLWI95TE2nAOBSsh8YQ5KLSOxmqPO46M1
 QLf4p8bjE1VUkRBgxA4gnB+jgih4uCfpmSMg7QWrdimC8ODWCgRGyV5Grm6qkZjW2vFGD
 McciYnVHGcbt+M1YRP6fhXI7HL9yBRMu7kYLabfEDIDwcwRzvT1V9XWyZN9QMx+rSmQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pZ7A0VaU; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pZ7A0VaU
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C5B9400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:44:32 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j88DY6cdWzKm5m;
 Tue, 20 Oct 2026 12:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792493069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFYqfUrHx8mdXqLKQ6odkHTuLjMzqwkUxEInl9RPttQ=;
 b=pZ7A0VaUqEb2Lc8XFzi6DF2o2ebowR384HooT2CiVU2uXIlC+GKdOXzFml4BJZwK7tARPX
 54/0po4tQOSncj05LSfGQzW/4F9RuKUa6RIC6wRxteCBYcIMOucirJmL8ll2FP8kwfIGl0
 WEH7k1+9q/bcJsl+E0RYQtp6c8YIx7ZI1yiujW8FxE5efCGCY4o0udjvRFLLypet3b6Ln9
 pV+1/l7SYARMULFJm6QI9y5sGyoYHuOf5+0UGvGZz8tXQeZJXrcJ2yt51cX6U+rC1KrbeF
 tnPmgS1QK38tdl3+ZMluDLfbGgqVsepDN6tGHMuto1suyOPgu43S/9oSw2jIhw==
Message-ID: <4030a7f1-c924-4d51-bf93-eaaaf8df2ed0@mailbox.org>
Date: Tue, 20 Oct 2026 12:28:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
To: Nimesh Acharya <nimeshacharya197@gmail.com>
Cc: u-boot@lists.u-boot-project.org, hsnaves@gmail.com,
 marek.vasut+socfpga@mailbox.org, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@altera.com, trini@konsulko.com
References: <20261019205932.28038-1-nimeshacharya197@gmail.com>
 <097d4df2-1142-4eaf-b23d-60f2f4e291cf@mailbox.org>
 <CAMb=oEaXycpsLz6wfxKVqucox+ZuJumMgaz3Q=+dfD8R3o804g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMb=oEaXycpsLz6wfxKVqucox+ZuJumMgaz3Q=+dfD8R3o804g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gwub9ydgkgfhrsnkngc6pzkxjs4ysxwg
X-MBO-RS-ID: 6f46cbbf5fc0aece975
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 10:35 AM, Nimesh Acharya wrote:
> Thanks for bringing that up. In fact, on running grep -E
> 'SPL_FS_LOAD_PAYLOAD_NAME|MMCSD_FS_BOOT_PARTITION|MMCSD_RAW_MODE|SPL_FS_FAT|SPL_FS_EXT4|SPL_LOAD_FIT|SPL_RAW_IMAGE'
> $B/*/.config
> 
> I get this output for the default config:
> 
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2
> # CONFIG_SPL_FS_FAT is not set
> # CONFIG_SPL_LOAD_FIT is not set
> CONFIG_SPL_RAW_IMAGE_SUPPORT=y
> CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
> # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set
> # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is not set
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x0
> # CONFIG_SPL_FS_EXT4 is not set
> CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=1
> 
> So, me adding CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2 again is
> indeed redundant. I'll fix this soon.
Please stop top-posting.

Is CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y the only option 
you have to add ?

In any case, please do a V2 and make sure the 
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is in the right 
place in the defconfig, not at the end.
