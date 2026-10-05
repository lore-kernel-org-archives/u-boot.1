Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6AACA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15E4C406E4;
	Mon,  5 Oct 2026 11:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hs4jejLP8VZ6; Mon,  5 Oct 2026 11:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EE50F406DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791199245;
	b=XV5RT2RICwX/mCa6cwHl2geftEA7fQb/SI4l2DM/t/1f5qhR83eg4kEwxoyWtuXPLzjY
	 mScBtV6rC/cfxXUDplSLN2UMnQQ3L4Lw+sMADvUDjrAbfMQWG4ePt7/4q582VpFL9CEti
	 XkSJl9Ea7w6h+wma4zAegoaZkJzjFuE3Yzi6KqqsTLnUE/QnzLWin2ZyQ7rtfF0a7fhdI
	 7sqDLJnZe18LD2///1QyWtsDTNoB1OTSxKiU5G3922exnALAg4xIYtycQjra30MJYnjOw
	 4CZ4DhEYjEGZaqCVQx9Km6Zdyjx/Doy3/ghPqItB5JzIK4DROrrgzL/Wk6q5z8n4GcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791199245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yVLxiWFixs86m2TUsa3xBNf+FvDzQ/k4vzBbmZ/OEjE=;
	b=pYJcF9jMFfhSDTp2nXxVrJVfaSwen7nwZwOX/IVKMOzu6phYYo78h94v9ua1w9+wNZY1
	 JsOB+d00uGoHl4HENpSCxN7CmLCBK76zD16mG3HrDklYjI/ainWWjknYLIeg0taR/9Djv
	 dalK/7jbz4OzOQ/OFaDe5wUNoTyI9kWtqBydeb2kGedcOMyDlpKU1eOIGT1jl8up9dLJw
	 +7SMfsp8VtgMiJCqgEtBMUUuQqYIsdz16QnGYcJxCQYFyX/edOltRHHu8RFng71edkHfD
	 ziwBCGGGkGWSPqjhuAg+Z/qPgHBmGmYqyjY5CvP0N7NQLH9Zejt9Kzx1VoBUl5egYrw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791199245;
	bh=yVLxiWFixs86m2TUsa3xBNf+FvDzQ/k4vzBbmZ/OEjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zzy+EkovHLv/p1YfFOKPwgbpOupdiqC52k/yAhZT3zrAkgB0pJbelCIxL631/Oy1Q
	 yZLHne7k0B6MZIum1mvQri/RZPc1weR3JkAXYCtW0epaJJZSSm/p4qgiN6sEzjvTfO
	 5AqZ1tjuQnZqmnZfDW8HDB3bOTaw2GNDQ0+UZvnx6xmDQW+WdBv4pUySNQtfHTj2/p
	 l2zU/AGa6VoD0gctD2Nf2AH3JeXQLSy88SwUegzFS8eieT+cz5/Mn3cDdjw7kjvNG3
	 Q+IaNNwwX9h9sE23/BIwkpRV9hMxg6UkFdvhNT7WByvqY4BndRx5UORWIbITeaB69w
	 4ky/bFTsOglmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE50F406DA;
	Mon,  5 Oct 2026 11:20:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AF1E282
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0096C60611
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMFNfOXHC_lb for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4859560606
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791198811;
 b=Hq6vx5ESIO7TIkhisnbCR5VsKYL0PrtrCVs2+opz9tcbiAOyj1g0tZKX9YXwJZPHA0Dn
 lpyyPvUizxVej57oeiITjvhaUUFxk3E1KBUWid7y+VVvwdXn+uIiqzgDnFsyHJ4tVbw5p
 W83yEsp49Vv8krI1bJbQj79Ews9efkQlPZEz6b9mi2v/fsGcDNG7v/I82dAcyqQ5BMyFj
 fPRAxSB/FyWluFN12M6kQOx5AxZCSDftIB6CXvTlDTOmdz49T/HmmZMzfvdQDKdOSQnma
 FgdITJKsv0odOMEHNbxiR83e4RskTPtSuU5auC6Eu0U6SDbzNmP5mnBElYAPaiw3u7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198811;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=yVLxiWFixs86m2TUsa3xBNf+FvDzQ/k4vzBbmZ/OEjE=;
 b=asgW7EQk2x3z63ApycWQWsoxo/Cuytlbt1UpD4gxFQfH2zMjYIGxJbVeLaKhK40Kmuvn
 pLK0pJk7MHbzvphzGUYxrDkLNSNA25AuXxFrRIpXS1Z2LRAjebCkjc+jyWNyypQ4PH3Am
 j1DcgPyiE6HIPrvo4G0Ohl9CuFv+5FHEyLbXPV/Uye6vlIaDabx3ObXhEE3o0gGXoxYoT
 q7M+T81tM13V7LkElfV+ooiPbJzRIU6JoEQHX1bKLcHfIwjo8cRyToblKeX1hpGyj1YSz
 77yss8Ys7nTtU/eYB1K27kBlerIwOORPp+4raFxBuOv0MKVTfX0oATeK4M3dcqFVa1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=n98yv71P; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=n98yv71P
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4859560606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:30 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hyxZv6DBbzKmd0;
 Mon, 05 Oct 2026 13:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791198807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVLxiWFixs86m2TUsa3xBNf+FvDzQ/k4vzBbmZ/OEjE=;
 b=n98yv71Pib0BXyp0ifAD21Xuv+H7APjt1XS0PiSgMPqrkcG941vYuHzETgn47t3ekNFDxx
 rd8YPY0E3RGmaX5TtJSvxMFvVRrQ5xc2Ee7QBmQt2cfKjFXVMJrrP7YB4UrswjKPGAg0XC
 X08v+Hff9ZRTUvgU4AmzaofSr/u9bs9bM3IubMQhCAzpQy4ZByQHc3VNIy2pM/DenoeWJJ
 nUAQCd+LItbmA66kGjL00muEhPjYcn4M7PwzmgJ++wlbu5z9r21yh6u9NYB6dFpFXr5qRS
 Tu3zZIeK6nU0xQToFE7Pb/G69+fNiNpumfDeyiSpIbczomCn91nNxdoHrZ+QIA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Yuri Zaporozhets <yuriz@vodafonemail.de>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Yuri Zaporozhets <yuriz@qsoe.net>
Subject: Re: [PATCH] wdt: unregister the cyclic when the device is removed
Date: Mon,  5 Oct 2026 13:11:57 +0200
Message-ID: <20261005111314.719129-6-stefan.roese@mailbox.org>
In-Reply-To: <20260823180437.152740-1-yuriz@vodafonemail.de>
References: <20260823180437.152740-1-yuriz@vodafonemail.de>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qdzzmp68rtwcn78rrndha3ttssdpc73c
X-MBO-RS-ID: 70004da394191097825
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

On 8/23/26 20:04, Yuri Zaporozhets wrote:

> wdt_start() registers a cyclic_info that lives inside the watchdog
> device's uclass private data, and nothing ever takes it off
> gd->cyclic_list again. device_remove() frees that private data
> (per_device_auto), so from the moment a watchdog device is removed the
> cyclic list holds a node in freed memory. The next schedule() walks it
> and calls through cyclic->func, which by then contains whatever the
> allocator has since put there.
>
> efi_exit_boot_services() makes that reliable rather than rare: it calls
> dm_remove_devices_active(), and U-Boot keeps running for a good while
> afterwards, so on a board with a watchdog every EFI payload hand-off
> leaves a dangling cyclic behind. Whether it is fatal depends only on
> whether something reuses the chunk, which is what lets it hide on a
> board that is otherwise perfectly healthy.
>
> On a SpacemiT K3 it stayed invisible until an unrelated controller was
> switched on in the firmware's setup. That changed the heap enough for
> the ExitBootServices teardown to reuse the freed wdt_priv and zero
> cyclic->func, and the next schedule() jumped to address 0:
>
>   Unhandled exception: Instruction access fault
>   EPC: 0000000000000000 RA: 00000004fdf4c242 TVAL: 0000000000000000
>   EPC: fffffffc040d3000 RA: 000000010201f242 reloc adjusted
>
> with the return address inside cyclic_run(). Switching that unrelated
> controller back off made the boot work again, which is most of why it
> looked like anything but a use-after-free.
>
> Add a wdt uclass .pre_remove that unregisters the cyclic before the
> memory goes, mirroring what the mmc uclass already does through
> mmc_remove() -> mmc_deinit(). The hardware watchdog is deliberately left
> running: whether an OS should inherit an armed watchdog is a separate
> policy question, not part of fixing a dangling pointer.
>
> Signed-off-by: Yuri Zaporozhets <yuriz@qsoe.net>

Applied to u-boot-watchdog/next, with a fixup while applying:

  [sr: use the vodafonemail.de address in the SoB, as requested by Yuri]

Thanks,
Stefan
