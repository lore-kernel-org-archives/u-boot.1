Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB660703AA
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wl2V4JwT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYSBS5DZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6F4860783;
	Thu,  5 Nov 2026 16:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-EMQyKfgx3E; Thu,  5 Nov 2026 16:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AA6106061E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793896395;
	b=pQZbdUyPbSBEvS6IkzuBS6ZpcJLBybC/Dv9js8su2aAkC+mPARpenOoj9P87dgNrySyq
	 ujoQXweDwZwNSRhETt6sWTD/v44ah7N6rR/96mcNMhi/JEaR/PysXJuNDkDxsnF6LsKv0
	 IGW+5zCblNGSVTdOSy8H594hvT0JgP8wnDvP+2FuaHGHX1MlDLaI1PGcKk4rqtEihL/3Q
	 quPKcRL1yWmSB37yKGk8ATTlR5UCZLC3uHiDA/QaJnF9chDU67SMKACiX1vtJlZh9jh0m
	 F883/UCLVLdVqtthNG7wdEWvjU2YttQYbpKwBlsyy/hG9VcX92klVJt3LbUGwUDOVEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a+2V/Tkn/h8g7yNqTCqDi0F1Fd/htw2D5jkS29XunA8=;
	b=AvuM4rSSwPFys2QW68kmHq+B+IWL26O1+2I039HYhl+3OmRdoIf1PYLGT1yISJMS5n4p
	 zDtygzndyBN543SP2CxLUe39D7Yz4Hb743bW0VuUyay6H2+ztv2t+jChlGp0meQiE16vV
	 5/Uu2IIrXPeQ2+u1cRVGbQXNGfxxSmOBCAgalHWV4uRkG1MyTIfFozvX3+aJgrpoMO5Qx
	 8Qwbn/IT9Az5E0cGIGKMqB6Abs5LcD08rNNIDnx0pp47m+1aG72ZIKK1s5hqkLB1b2Ell
	 s3r1WGGGXJ5WBLfquElY2Ua9u6544i3YZsXVglPC3Jqd++dundsYFpnETEhZ7lAAxDA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793896395;
	bh=a+2V/Tkn/h8g7yNqTCqDi0F1Fd/htw2D5jkS29XunA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wl2V4JwTAZ4+di3MetoG4Cu/veJqM0qV/bUWM6G/W50u57jTY28lTvNIfwYr2pNWl
	 1JUaRg01R3u5EqYMWgaQ/qfmNkofWaBeBIJeJsSjbl0YYh+SUScRnmSR7j3V/w2ISK
	 M6VqNE3FiioQdWyXUzUFmyGwVgWMfrqu2tapdCv9Hxv9YBfg0KgAVN6mH6MMOP8kjn
	 dp7VgimxPqVr4f62tnzuakngZJbHt9a0uk6rMbOQgUW8SvMpuzma9gZKk+KvjKbHsM
	 P1rrEnEI3BWApAhKrBh9NfM6pu2246NpUo7VJng3hq09NN28lDLC+3hARgBDllgCpS
	 T3j/C9XOE0M5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA6106061E;
	Thu,  5 Nov 2026 16:33:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAC49235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C4B981173
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSP4dtEI3MtA for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7A9081100
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bYSBS5DZ
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7A9081100
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:40:19 +0000 (UTC)
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-33fb4680717so3538797eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793889618; x=1794494418;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a+2V/Tkn/h8g7yNqTCqDi0F1Fd/htw2D5jkS29XunA8=;
 b=bYSBS5DZI0bvIEUztGdasNDJ1Q8nSv+T1nlKRdVtnCq+jpCZHoBA/ZFARyDZP+SJYR
 UAgykUXrvfECtTlTCtaseGlIYzeJyC5xYdVyG+cEpgYzbBpM5O9QLYGmCp5HZlrCBgf4
 8p8Dy7rSt1gqAucoujGFXu3Af8wSPddOspY2x2TcCcwd5nxC4tlCqrCHnk4yLjwdaZnY
 wLtqjyQR7vQZ+2k5F5MNOTuS4IkKMvuvvxg8yRcQA/XAKxON8Ju8sII0/e7CfVfGOd2O
 1RegMZZNnS9ri6mMz445722t1JbJetgirZgH+JLz1jQao2XQfXcmWISsct/wTQuCXQ0f
 oGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889618; x=1794494418;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a+2V/Tkn/h8g7yNqTCqDi0F1Fd/htw2D5jkS29XunA8=;
 b=2eptcNjE/DmXWNShDFercf9R11/9U9vNmf+r5odJAESeBcFUbolW+drxkfF1vIQgcH
 mtCjqD+JkdMBoG2Vf8H9cJopOaZoy9XURVhg0CUdIUT1E5ZHOn9lcoHU1VZgRrv824Mt
 AFY+u95zdkEVqtkrow2LJKRnKSdyM6RvDpVJw+omYfF4eDI0VEhihn6eihOsNJa6rAxM
 LyXY0WHblnbH7qNNylz/BA/cqWELD/7Rxdfc5XHVKVpdjsVW4KOr6FFC+3SiCt11sm+I
 zURVCYulBqnszBXbmDlkWDoGIvnIGgcoKqqU4B9MJIad67eD0FdxA6NkmO2d8iBaW/9l
 kHKA==
X-Gm-Message-State: APuU4Z940ul3u9uYhRRw3k5AKZRrliDGpga7tBQ3C2uEnEgISZVC/bQL
 ACI9F6Uin4UNg0yglOjv5kOXEabgFcSE0yuhrg2pWQvoYF1PT79lA23t
X-Gm-Gg: AYBFou2/WEinzKqOxXFCB9tbyRohqdYjFEO8aeE5SCEtQbdh64q+5g/2I8m1EpY/7sh
 JUhm+k+W3EUHVshp+zIX3/UOCjNSS79GaT95pPYAukfD/khGgl0xZObyLn2JEndvWZJgm6euwYg
 +mSS+uO+U7O6QC85BQGqrE4eCxqthPWK39vYkR9WiOiuyVt8vtfgPN1l3yluGM+JX7Q2b2LeiJx
 U0OufjcM3JfPFHYbamvlnje2/0AQ5sa3b0b6Cv5EtADpsxlanaSNIW2T1mLoxKvEdJecaQbOpsD
 CYRIHLjVhDIK2V79JdiGzfcOFzT0icV/36hgUBaZHzQqJEfqHy1FySPjvgE7wR9b4Rc5JljQ2xt
 04Xf7Scjg+cRdLPtduSpXqCADxm3050GZnA7EZZiwwCmHP3PByPrRlZVmE7xaOakDbhJyshS6mr
 rkvmPwq7PhGginoR1++ZhavKmXEatSsiDgediFgE3Eplcj/0QnZLW//CnWPJ1m7Qvo5JehS/Egi
 VNU8SGjwZMhBSU1Ale4nR/VtdQTLJBzbwkzf6Rsr3+KAjJQvbS0iF9wwhHUvqif/GFfrQmwhAZ9
 fPyuXTmO+jHVTcvFv/ZYahifRX7GM91L9Y7w/Mp1qVFSyG12yNE=
X-Received: by 2002:a05:7300:460a:b0:369:21a:dcca with SMTP id
 5a478bee46e88-36a42340b99mr28197434eec.10.1793889618181; 
 Thu, 05 Nov 2026 06:40:18 -0800 (PST)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38fa273sm20123503eec.16.2026.11.05.06.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 06:40:17 -0800 (PST)
Message-ID: <4b3f9200-ebbd-4e17-9205-58827c426edd@gmail.com>
Date: Thu, 5 Nov 2026 22:40:12 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mmc: k1: multi-block SD reads in SPL and a probe
 failure fix
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Anand Moon
 <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 05 Nov 2026 16:33:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/1 05:54, Tanmay Kathpalia wrote:
> I am taking this series over from Dave (thanks, Dave).
> 
> Testing v2 2/3 on a Banana Pi BPI-F3 and a Milk-V Jupiter showed that
> multi-block SD reads in the SPL fail because the SD I/O rail (PMIC
> aldo1) is at 1.8 V: set_vdd_mmc() sets it, and without
> SPL_MMC_IO_VOLTAGE the MMC core never sets it back to 3.3 V. Patch 1
> lets the MMC core set the rail, patch 2 drops set_vdd_mmc(), patch 3
> is Dave's multi-block change, and patch 4 is Dave's probe error path
> fix, narrowed to the resets because, as Yixun pointed out, the clocks
> are reference counted.
> 
> Not in this version:
> - v2 1/3 (missing max-frequency). As Yixun suggested, the io clock
>    should be set up with assigned-clock-parents/rates in the DT, which
>    also works for Linux; that will follow separately. Hung-Chun has
>    withdrawn his matching RFC.
> - SPL_PINCTRL. On its own it links no K1 pinctrl driver into the SPL
>    (there is no SPL Kconfig symbol for it yet), so it would not program
>    any pads. It will follow separately once it has been tested on
>    hardware.
> 
> Testing: I do not have a K1 board, so v3 itself is build-tested only.
> The changes were tested piecewise in the v2 thread, and in each case
> multi-block SD reads in the SPL worked: Zixian enabled
> SPL_MMC_IO_VOLTAGE on a BPI-F3, Yixun dropped set_vdd_mmc() alone on
> a BPI-F3, and Hung-Chun set aldo1 to 3.3 V on a Jupiter. Zixian,
> Yixun, Hung-Chun: a Tested-by on v3 would be much appreciated.
> 
> Thanks also to Anand for testing v2.
> 
> v2: https://lore.kernel.org/u-boot/20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com/
> 
> Changes in v3:
> - New: configs: k1: enable SPL_MMC_IO_VOLTAGE
> - New: spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
> - v2 2/3 -> 3/4: commit message explains the BPI-F3 and Jupiter
>    failures; code unchanged
> - v2 3/3 -> 4/4: keep clk_release_bulk(), only drop
>    reset_release_bulk()
> - Drop v2 1/3
> 
> Dave Klotz (2):
>    mmc: k1: let the SPL read SD cards more than one block at a time
>    mmc: k1: do not assert the shared AXI reset on probe failure
> 
> Tanmay Kathpalia (2):
>    configs: k1: enable SPL_MMC_IO_VOLTAGE
>    spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
> 
>   arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 10 ++++----
>   arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 +-
>   board/spacemit/k1/spl.c                   | 21 -----------------
>   configs/spacemit_k1_defconfig             |  1 +
>   doc/board/spacemit/k1-spl.rst             |  1 -
>   drivers/mmc/spacemit_sdhci.c              | 28 ++++++++---------------
>   6 files changed, 17 insertions(+), 46 deletions(-)
> 

Working fine, sorry for late testing.

Tested-by: Zixian Zeng <sycamoremoon376@gmail.com> # Babanapi-F3
