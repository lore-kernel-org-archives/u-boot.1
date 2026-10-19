Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5C60B5070
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oiJc2K+M;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=QhPX5UVo;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=nlZWhd8c
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7ED180E57;
	Mon, 19 Oct 2026 15:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlCRIcGnEKCD; Mon, 19 Oct 2026 15:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36AED80E6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423667;
	b=Is+xEOV9/hHwzWeV9nIrbEFM6fYKaIkhh1uIlCCye9/THX7hibqfh3hnHzaEhwALgzhf
	 03bmyA8Tn6HxKDK75usTXMcKVHhBFBbrFWOLExel9CI0S3jermpIpBeyeSs/CQLZ11WBl
	 VlQINNcBMnxyF/5gALRLaRiKC3eEKzyexLexQvPUlSOU3JI1TplF/DQeMeQKl7Rno14dJ
	 3F5df2xYm4HQCRMPqhLHQufGPHBbuU+GbXlLg7sEiO5Bwlm4njRUGK+UXJXIalwrBMej3
	 3050T4YHA3yMEKuKRuxTnPnag/1KnLWrdkTlIb8L+1b2uHcvuXez8eFIauEd8FHFbKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t6nCbvSd9RGgS1gsptn/yWZmaHyscCaJZMKy1olVDbE=;
	b=eG0xp5wsLxaNfuqyKqEreL8ZWxeSUNhGypoVtbBP4nz2qPSABjDOFzHaRD6WeSJGCYY7
	 ArsZ6k5pFStR/RkcISlyad57zb05FHb7Bppiaesb2bn4OPwvjB06agaLVamPqpxBSrSNa
	 aikf0v+TBYxJwK5WQfIboN8ogJjNmpcXIpNzYj7tK3fgAZzxCJwFj2LE+JgsZAnevV3qe
	 z9D1VQoo6vrnAm/4M8lnHUEw2GdesAtd4BTy1bDDQh3BFv3lWSyalb1IPD7V7U2DSFrL+
	 Hed7rwe9L0XGtcRe7WKNXhy4T8DQu9U1WHZ3eAwKdywDdiANGByeBv6s/uw7FTTh+gQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=QhPX5UVo;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=nlZWhd8c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423667;
	bh=t6nCbvSd9RGgS1gsptn/yWZmaHyscCaJZMKy1olVDbE=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=oiJc2K+MHJFBluBELAdUmFKTSD0ZbXyBlY2EjccSYAn20PY5u+ZG9nIvenL6mtDM4
	 2PAN800dEOCrvFKvQFfI1If6jR4Sktw2LoS1lKdQQqdJQV4GW9bt+yvEqk5HrpKqY1
	 xUN50jYXHstbfUhASqe7NTWNi7BrNdPVIjKkD35P02ZABMoGBDeDIjTIgRNRJsJAQM
	 qal5i46OTMKSaUqTWCBt+OqEr2VmCex2xhR1gqpEwfe9VpDyhSoU87wEYAjo1tTap0
	 RoCEw9shmHaip2CsVmh7SyZ3bSibCIcQDXN/o6gzee3ZYN+qLlMWXBfYs3X2Fabuy8
	 chccFkh/8Uw/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36AED80E6B;
	Mon, 19 Oct 2026 15:27:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9448279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B72480DA9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XysF2w42NTjP for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:20:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E62A80C6F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423225;
 b=HP17kvj3CSLt+lTA+XemYPqKmQmYaOsC/hlXXUGQn/+0tqR3iji/qykHefNSrECdImm8
 TuEP9ljCnYJwKx72kaO8TleEYCbCcfeZQrjrV42vsHFo4SuqT3va7UG95Be2rUe78Ayzb
 PkcApcBcoreuKYw9kjtfGaNieb6Dlab4VKYm4AvSbxwQSuKEuEnJFb86ATWDmS/TAwIBc
 j3BjBSdLPvGPiBf+aybsPHmfIfJ6PtSNVKLZKnGz59nN9Rhpbx1mJWDBWcKBAAuL9l4Z7
 B+xuq4nsUG3ayxnggFvwrZlal6Cv+kiEgdDCWGa23uqkwzrRSFaubzrpUmKoxmqZcSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423225;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=t6nCbvSd9RGgS1gsptn/yWZmaHyscCaJZMKy1olVDbE=;
 b=IUY09h8WxNmbPbCRwsodqLwh88JbCT5IxE4gTD8nrq/RkTXlKzUfXNaKO+uuhZKLJNtZ
 UorV9WdqDLvmrYmbpGP0XSkC+ndcPLUQGvX0WBRXYAe6urYmkx/1AvgXqUgm6n1bo8ybm
 j3RfrcfrP/jrvUNT0FU0RGpZAV3b2KyTJGLTbIPH9jtyIb299FdyxTCbFa83HI4ANQTPy
 eswXOcS0+ayWlKuyJQ/ipJ6KTQqWCfeszBZDbrJv3TL4PWWRqghpiIaCEnVv6LwWFy7Mp
 hTOjx93PbTkkeROVL6Ac1qAkhSSU7K+4NJ6AEp6hTcr1HVUuiDLZM/SHU0xJfD4eBWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=QhPX5UVo; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=nlZWhd8c; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=QhPX5UVo; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=nlZWhd8c
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E62A80C6F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423202; bh=t6nCbvSd9RGgS1gsptn/yWZ
 maHyscCaJZMKy1olVDbE=; b=QhPX5UVosOmG/ZQ7YchNg+Qxb3TdR3UXChJRVtpC1uuS+fpmd5
 D4cOTFqBevPd2bZXQhKFtc0efYQhWw4y3Wame23noJJpv1nFMlrMZTe33cDabPje6qlwTDbJF8E
 j6VxGFTr5eysxqIv1VHxbA/r/L6lBIyLqkV3e+qrDjOkgdL0L4amdJqhR25KLs6K2eshZrrQiWm
 kXu5yYdKnZnvEpsPehgJbDzJ+LV3pycbfckHXv8EPPQd30BxM1o2ItCk49/OwhqksXrRAViMQ54
 7AEVEbZtAclD0J9xKCtKYwyacLjn8R4LoD6w0hkhlRt++7YJbtOUIEQjTPoaZpmJPgg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423202; bh=t6nCbvSd9RGgS1gsptn/yWZ
 maHyscCaJZMKy1olVDbE=; b=nlZWhd8cS2TMXdFuWVzHOukIhsNhFxKcop5Uq6M8cH6J52ulgg
 xY857WqVYED/JcMAS0K3iaLx7wV/vHDUk2Ag==;
Date: Mon, 19 Oct 2026 16:20:02 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 10/14] configs: turris_1x: Enable LTO
In-Reply-To: <20261018083516.49229-11-pepe.schlehofer@gmail.com>
Message-ID: <8518978C-FCDF-4BDA-B0DB-F035B9EBCA85@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 15:27:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:12 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>Enable LTO in both Turris 1.x builds. The NOR build needs the space for
>the ubi command next to the BCH code. The SD card build needs it even
>without the BCH code: with Debian's GCC 14.2, its u-boot.bin, device
>tree included, is 1049419 bytes, more than the 1 MiB
>(CFG_SYS_MMC_U_BOOT_SIZE) that its SPL loads from the card. With LTO,
>it is 984523 bytes.
>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
>Cc: Marek Mojík <marek.mojik@nic.cz>
>---
>Changes in v2:
>- give the size of the SD card build, which is too large already
>  without the BCH code
>
>The Reviewed-by of v1 is kept: the diff is the same, only the commit
>message changed.
>
>The build does not catch an SD card image that is too large: here
>BOARD_SIZE_CHECK covers only u-boot-nodtb.bin, while the SPL loads
>u-boot.bin, device tree included. That is left for a follow-up.
>---
> configs/turris_1x_nor_defconfig    | 1 +
> configs/turris_1x_sdcard_defconfig | 1 +
> 2 files changed, 2 insertions(+)
>
>diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
>index 070428ae25e..d8ce4aed4a7 100644
>--- a/configs/turris_1x_nor_defconfig
>+++ b/configs/turris_1x_nor_defconfig
>@@ -19,6 +19,7 @@ CONFIG_PCIE1=y
> CONFIG_PCIE2=y
> CONFIG_PCIE3=y
> CONFIG_OPTIMIZE_INLINING=y
>+CONFIG_LTO=y
> CONFIG_ENV_VARS_UBOOT_CONFIG=y
> CONFIG_HAS_BOARD_SIZE_LIMIT=y
> CONFIG_BOARD_SIZE_LIMIT=786432
>diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
>index dbeb34dacfb..982a6cb0703 100644
>--- a/configs/turris_1x_sdcard_defconfig
>+++ b/configs/turris_1x_sdcard_defconfig
>@@ -29,6 +29,7 @@ CONFIG_OF_BOARD_FIXUP=y
> CONFIG_PCIE1=y
> CONFIG_PCIE2=y
> CONFIG_PCIE3=y
>+CONFIG_LTO=y
> CONFIG_HAS_BOARD_SIZE_LIMIT=y
> CONFIG_BOARD_SIZE_LIMIT=1048576
> CONFIG_MP=y
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
