Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82559CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C1B580965;
	Tue, 13 Oct 2026 13:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YmDuUW7r7-Yt; Tue, 13 Oct 2026 13:16:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A77A80AE6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791897409;
	b=He0iJ357Qm24Z+sHYSXYLhYavFRAx1BXJsX1Ry9Muha7XUCvzaIDADKPmhOYw3eXBeei
	 eRQmS2Sxvu9rkR2nUsGYvxwZ/NqdNkxC+G50DSPcbKiYWwFsxiFsluzI4ifJbi1FqAm0U
	 qMKr9q5jCiaNuvROL2BuEbj53pvJ8MqcvQ5NGFSFQNyf8WBMbHVRu3hpire7OdE2Oew3S
	 Q5tCh/dkfX5/DSuoGDqE63RT7Rs0IyMWnD5QxrUc5QoQwdzDRNgDo75gCt0iO4gpLU8Yn
	 uRcg2uEVwB6iDf4viL8oqgD6JXzWFdHSwzn7ocYJA24kzHtVdgswdqFXvL66vnSOgtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791897409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5P+nkenQb7q+c+B3yBucfpQbQ1HG570ug8Opp2zQGXY=;
	b=m6s1dkWEQHYomKhmF/s2t+Y7Iwlj5wxrMNKgUrcvSvGtUauoGXaLNXj3Rk92VAKreCar
	 cwIV+3nCZb6yDs54bA4AaM+mYEORn90aUZreaZkocfW+GGRrogxpI/wVI96sSXrqPzvsy
	 PaaRNxaiNp+GIs7eNX08Bu8prn+BjnLmboDIxBiwW7vTos5UehrZi9LZB01oHuZNfWH0O
	 JVVNWiCV/GByJaHHhk1j/78P4LMsx6v0MaY2AXjIBKrXNLy6ycKhczfyef4ET11pKc8Ey
	 HlTaNWmPIBjzE4PQZfFDQncjb/kUpCMYivWlUdKbUmetE1rriqkMypb7QKQ6cdGaw8w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791897409;
	bh=5P+nkenQb7q+c+B3yBucfpQbQ1HG570ug8Opp2zQGXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hf1rZzN4VqFmW0+WGlVPW8PDnS0mhUMj7cS23WJwzwK1J3olT444Of4q1zpSJCxlP
	 uQPjAG4MGAT/DL4SgRJp5vi/AvCw7bV78tQ/SISazX8M3v+tt6otL8O8EMKt3NFKZT
	 Ucjw8K4tHFaqgdCyU4OPENIJzKOTszyZPHt4mZe8bTpZ7y+pazUr+Wwc1mJ/UCprF6
	 QvKgBLPHKusZ9Z4aVyOGm+bWuf6W9GlZEmWlnbD4u5FjqP3L2Yj1mDPXgXVoQyYr6E
	 0aTKWy/7Q5TeaUijGx+ojr/tIcRmZ3ONCr/3NSJZhxf9ko3ZeArjKakty/V6hVS74l
	 1EAsGArK3P1Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A77A80AE6;
	Tue, 13 Oct 2026 13:16:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82CCBDE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68E6940503
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XZzqgx3XShgQ for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F56D40500
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791897406;
 b=j3F+D17qMRaTNQXkQOyaVTdbHKxBUFgU7BjCdDW5PGcANGZ7ufMTW/61RRmhUAdJOkTw
 vqmYhM74+qdL6QNfFB1plxNjrKAcs5N9l2wtp3e92tjTU6qEb4rzPH7uStI9keEIwvn3c
 VLwLsXcDtU7sqv0fqaGu8GVSjWxOqZHV7SAEhqR8MaVaOOKYqihY0FUBs/lkfnYGw+M76
 YGIHX16hannDCGggFUMMqsNrTDyN7ikiTNctjH3M/PY7qtdJXKizRdqN4DADMTp6AB6J8
 Ke0uUlaFzaqRt0S7Lr4QyN0XpFmoLPBkk2v1288/PP8KhspkOjfE6GjZvLquUGu958w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791897406;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=5P+nkenQb7q+c+B3yBucfpQbQ1HG570ug8Opp2zQGXY=;
 b=jodQbh9Ogw1vXbyrvbCSl7JbHJiwTUTyxyDk3sOTK90cB1cQEJhPqTbBPzx+ZFfKFngr
 UiKSUd0pMhEA9H028/xW540dAlyIpEp/Z7mZT/P8R25soIS5nBG8OgM3UvUVg4UURY4gk
 NUr4LjFIjhQnLGXOxjNYD/JdvGsT5j5JOtcUivlBGMiD9gJDKeMOFOuzYxbV+P9BB3WzV
 D+5O6yHY6badM0wDQYrMt/Mrhz+uk/2gwDt+MWz54+59dJ+yrXyaVmckxzyD20G1Y3Wr9
 UUgAZs3OmG753Q3KkOGFwDfOfROYfhbIpW2s971pfnQYjqd5n4SH/2mgTyZ29gu/Pvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b="ScoDFRg/"; 
 arc=none smtp.remote-ip=220.197.31.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.5;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=ScoDFRg/
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F56D40500
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=5P+nkenQb7q+c+B3yBucfpQbQ1HG570ug8Opp2zQGXY=;
 b=ScoDFRg/c3ByE3qd66XjrZQQp8gPa74EYTkMNVwbv5bJQ2NTtPdma7Rxpx4IP5
 EC9RCfumFMUV36v3W7iUlyErfXr7Y0/5XRKx3LYpyTerzuWYMg0E5j6O0MDZq6va
 cZa/n6GuylObLz0kHRnFU+8833Xwkb75gbpvPaaQT5vjw=
Received: from nh50.. (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgD3xlITL85qB1WGEQ--.18855S2;
 Tue, 13 Oct 2026 21:16:04 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: Re: [PATCH] bootstd: Add a bootmeth for scripts in raw partitions
Date: Tue, 13 Oct 2026 21:16:03 +0800
Message-ID: <20261013131603.3196631-1-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTitXuRhtQkm7-xj6+9wwLGq_MQd_8ZVeYQx3fnxKS8qwA@mail.gmail.com>
References: <20261009151005.2870671-1-hyyoxhk@163.com>
 <CAFLszTitXuRhtQkm7-xj6+9wwLGq_MQd_8ZVeYQx3fnxKS8qwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgD3xlITL85qB1WGEQ--.18855S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF18XF4xCF15Jr43KF4fAFb_yoWrJFWxpa
 98J3W2q3s7JF1UZ34xCF1Iq34IkFs5Jay5XFn8GryFk3s8Ka92q3W3K34UZa9rWrZYga42
 vr4vvF9xArn8C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U66wtUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8hUf8WrOLxWodgAA3J
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

Hi Simon,

Thanks for the review. I have posted v2 as a two-patch series addressing
your comments:

https://lore.kernel.org/u-boot/20261013130235.3172204-1-hyyoxhk@163.com/

1. image: Bound legacy script parsing by the image size
2. bootstd: Add a bootmeth for scripts in raw partitions

> Rejecting external data is unexpected behaviour, but I suppose it is
> fair enough, since scripts are small and we don't expect any other
> images in the FIT.

I have retained this restriction and documented that the script FIT must
be self-contained, so its metadata and embedded data can be validated
within the loaded partition image.

> Philosophically speaking, it would be nice to extern the existing
> bootmeth_script - did you consider that.

Yes, I considered extending the existing script bootmeth. For now, I have
kept a separate method so raw partition-label lookup and filesystem
script lookup can be selected independently in the bootmeth order. Both
methods share script verification and execution. Would this approach be
acceptable to you?

> Please can you add the bounds checks to image_locate_script() instead,
> in a separate patch?

Done in patch 1. The shared legacy parser now checks known buffer sizes
before CRC verification, bounds the length-table walk by the declared
payload size, and checks the script length against the remaining data.
The existing script bootmeth and source command benefit from the same
checks, and the raw bootmeth no longer duplicates the parsing.

I retained genimg_get_format() and added a known-buffer header-size check
before format detection. The regression test is named
image_legacy_script_bounds to make its coverage explicit.

> Please drop these, so it is clearer which checks matter.

Done. I removed the redundant legacy data-size and header-CRC checks,
and the FIT totalsize equality check from the raw image validator.

> This only applies to FIT but also runs for legacy images. Please move
> it into the FIT branch above.

Done. The raw FIT minimum-size check is now in the FIT branch.

> Please use log_msg_ret() for error returns here and on the 'goto out'
> paths, as other bootmeths do.

Done. The rejection paths now have log_msg_ret() diagnostics identifying
the failed operation or check.

> The underline is one character short, so Sphinx warns and 'make
> htmldocs' fails in CI.

Fixed. The strict HTML documentation build now passes without warnings.

> No defconfig enables CONFIG_BOOTMETH_SCRIPT_RAW, so CI always skips
> this test. Please can you enable it for sandbox? Check that the
> existing bootflow/bootmeth tests still pass, since they count the
> auto-bound bootmeths. The test also needs
> @pytest.mark.requiredtool('sgdisk'), as in test_ab.py.

Done. CONFIG_BOOTMETH_SCRIPT_RAW is enabled in sandbox_defconfig, and
the image setup test requires sgdisk. The existing bootflow and bootmeth
tests have been updated for the additional method. The iterator test
retains BOOTFLOWIF_SKIP_GLOBAL coverage.

> bootmeths should be tested in C, in test/boot/bootflow.c, with a disk
> image created by test/py/img/

Done. The execution tests are now in test/boot/bootflow.c, using a GPT
image generated by test/py/img/script_raw.py. The C test covers legacy
and FIT execution and the invalid-image rejection cases.

The sandbox build and 40 selected tests passed. After renaming the legacy
parser test, I rebuilt sandbox and reran that test successfully. Both
patches pass checkpatch, and the strict documentation build passes.

v2 was also successfully tested on LCKFB Taishan Pi RK3566 using
lckfb-tspi-rk3566_defconfig with CONFIG_BOOTMETH_SCRIPT_RAW enabled.

Regards,
He Yong

