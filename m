Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF460A6F7B
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wTZ813nk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WAyD5eVu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD34C608A3;
	Wed, 25 Nov 2026 15:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxXuRBqyDHa7; Wed, 25 Nov 2026 15:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 26CAD60891
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795620956;
	b=kpTBUGdHjZLGm/HVJaSfn8T9LO+oTu1GHtQln1KEtl+KZQIe37STAnO8SBI+5rtsHQLq
	 rKA/N2ipD85wfRTfQqeypC+R4YwyiYNyfBkdvjcz85cgdxrLnixKLAQvJA1dJ1WRUiS6s
	 qw16nOC8G3WVQjtZGCKH7gg8MSYYCWgin4bgPzGAEIUoePEAm5Dhnd1TGvF4fd2GAh0kV
	 aeG5yoi8nOdKyk6WxRg3LoF1wOfLPxLdza7joL2qXU4gMcDq9MKn5xrs2JJqETHO5ziqn
	 /xUvSHdGeJpwJt9oci8Qrc2VAIq+n0ebEN8WtroCE4V9wm10uppQau5NXMlmyv1JYjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795620956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZDp5UCLgm1702EhMO313O9xYBrTTuCNsMBsJDqkChWw=;
	b=GWPtUDyD/ZQlHvIHOiY6jhXJbGnj8MAj/jSVx86U4LQ/gc9jbDYiTl/OveBdtsZUwWpP
	 lAKp2iVQ+89IEawWP2UGqq8U/3ojMewQsesDFAjCyXDbgjlbOQR2XnHNmFLmJEyjLk6t9
	 qGQdXYvesmbdLgOV6cVGAXdhJrrwmRNhqygCdvZj38fy418phLgVpKSwCW1/1+NfsVw56
	 1dqtwv8feZzkFG1Y7ZaFq/nmBCXIR0mEttp3oCm/5jmG0sjSduN5z+lQNeI8WeRQ5QnFR
	 +j6Jctv5IuB7dTaxRj9efDKkNmBXWm+qVyy2Kjy9Hxb68q300hNLZRJ3eHiKc3dCW1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795620956;
	bh=ZDp5UCLgm1702EhMO313O9xYBrTTuCNsMBsJDqkChWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTZ813nkiE/sqlh9RFYfdI7OD6OUx9wnvCD8UilKLpor1kIlLzQwdzrIV8OEDO6Qa
	 n9uOJMggle+UefQWYavnCX0/kPeUx4IqqGbbK5L9Yno0oZBIJp1GdJnLcWSkdqZgwL
	 fptD8m8x7GykNieLZdQJovd09jO3Vx/qeOQx2Tqbu8aItv6n916EK4DB5+9XAesyBn
	 SV96GL4wDlCS8XG+5fDQFuFPQl30fCyxhHmSipc1EKCxvBJCMFGxpeQukdtAQperXH
	 2Nnpojqo12mgCewIRHzKIbdVVLqTZrixAB9W4Qn3BgqL49b/ZlWiOzKyM662VmqtBs
	 EeTNkIHw3niQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26CAD60891;
	Wed, 25 Nov 2026 15:35:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 276D643
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24D6540521
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gePMvbAklIf9 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:35:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 352454051C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WAyD5eVu
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 352454051C
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:35:52 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b8786bb305so7176266a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795620951; x=1796225751;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZDp5UCLgm1702EhMO313O9xYBrTTuCNsMBsJDqkChWw=;
 b=WAyD5eVuhV9P0600uAjvYB2W8E/eB7/6igFfgTObTbFmqxeLWhu5DSIUyG45vPJgBt
 yCn+ec5GIiMPWhUbL0XmxAvND+HBi1T3PTPYw8kg/OzAJGzkLHApiQKwRDvmSMoU9rwq
 rCU+ocCTeEiIU/Og/kpOa/tacF0xxAWk+PSldts6dcdJ245FpomuKTq64i2NV/sFz/Lw
 1G4z8j4jYi4tmrNqDt35gHBotKuzKSE9O1tLmysMzdgm7CZr/QhkLKYw9D+EYEKc8aY7
 E6infGthRxxQ4lI1crTQnDoRKHj1ZaEp+qXLir0aiPjpDyTXRGqWgT+oG7KxTINsCuWJ
 ijaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795620951; x=1796225751;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZDp5UCLgm1702EhMO313O9xYBrTTuCNsMBsJDqkChWw=;
 b=B+HO/9nmVbuDTIS4BIWICS162YS8NjhxQuhSE9x8PvcwA4s3IUNfK1FzaNWUmNsmeu
 oVNXPfJCCcjySbhJWQV/ErWGAqepdjErwlvqBfARbHw52HAPYsaHTdEXDIpffel2ua5W
 IDOxmNY/x11MVbIODSN22nfGkn3i5llIDNWHTVwfyb7mPbxffVW8LQMxCFMCpFoOO9B/
 QU+ZUByVy4MG9ZYPi8POwl633Fqeu5B6s6SQ2+KGl/iVi88JQYK/Xouqjx5DUedybuXT
 bDje5DD/indhQ/rDLMaEkKZ5xk51Syv7AzEly443fWL4x89EXLvHumADTeAqB3ulGRPF
 ldkA==
X-Gm-Message-State: APuU4Z/CudtY4R6VeRtU6P/yN1FBvlci89tj3QVedS97fnTsSgBUWIQi
 hVIBZcB+Dh9GYGIrgGuDQcc4fR44D4FjFqPIuYFBL31JtfHRRAy0NqK6UNBbYB4TpGVEQQ3I292
 MM01zrhnOje6RlTfDaaz4MDv/0bcrWJFPcf2s
X-Gm-Gg: AZFdTZctKrwgs5Ow7H4+V+h7XDND/hr2JDTghceIzYEYu0v8m5qzqOnooJUPmkS9fgc
 f0QYpPlujx4HSiO68JEtt3/CQDdxsZ9wlhBxa+meam+LwiTEPLBGBSP6LwioeprHn2Hyo1HNMGE
 A8aB1+/pEJVyMvi6opsZKmNX74+nFmg0DCb70Bziz1scKIemze/Fj/98iPIYsaA0t6qRy9LBtl1
 hDi3FNviw/kkbsDIe50/US8Xf9OazYvICRNwAPhGH7DP6waArlzCA9C7gH70XLUT9RC+tsQtDBR
 uVck1T9tHAmvBlYNzckBNMaZBOAsR0672r6I7RffHcekoMnqMkN9NoQ9IjY8vcOFTNYUsO0qxxp
 wTL2KHlY6PxsTCnaSVQZGXyh2/ncb5RbtHJI=
X-Received: by 2002:aa7:d155:0:b0:6b5:913f:4de6 with SMTP id
 4fb4d7f45d1cf-6ba37c7c38fmr9339671a12.4.1795620950658; Wed, 25 Nov 2026
 07:35:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123193714.5096-1-linux.amoon@gmail.com>
In-Reply-To: <20261123193714.5096-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 25 Nov 2026 21:05:38 +0530
X-Gm-Features: Aa3M54qiU5EeeYWL5amcmit7YpVjPg755ACRYyTHxNV0ZdUORaFF0XPjyKlUnfA
Message-ID: <CANAwSgQ-vKfciZ+F+vAqmk-kJS1cqMxKWaUrRBbyYnwgWcygXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] riscv: spacemit: Add GPIO and pinctrl support in
 SPL
To: u-boot@lists.u-boot-project.org
Cc: Yixun Lan <dlan@kernel.org>, Zixian Zeng <sycamoremoon376@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

+Zixian Zeng

On Tue, 24 Nov 2026 at 01:07, Anand Moon <linux.amoon@gmail.com> wrote:
>
> This series consolidates common U-Boot device tree properties for
> SpacemiT K1 boards and enables GPIO and pinctrl support in SPL.
>
> The device tree changes move common early boot properties into shared
> DTSI files, reducing duplication between the Banana Pi BPI-F3 and
> MusePi Pro boards.
>
> The remaining patches add SPL build support for the SpacemiT K1/K3
> GPIO and pinctrl drivers and enable these drivers in the K1 SPL
> configuration.
>
> The series consists of six patches:
>
> 1. Move common K1 U-Boot nodes into a shared DTSI.
> 2. Remove redundant MusePi Pro device tree overrides.
> 3. Move common K1 U-Boot properties into the shared DTSI.
> 4. Add SPL support for the K1/K3 pinctrl driver.
> 5. Add SPL support for the K1/K3 GPIO driver.
> 6. Enable GPIO and pinctrl support in K1 SPL.
>
Following the description on the Linux mainline list:

[1] https://lore.kernel.org/all/20261123-fix-bpf3-eeprom-v1-1-df8cce6ef2b5@gmail.com/

I am currently working on enabling multi-DTB support in U-Boot SPL
for SpacemiT K1 boards.

While investigating the board detection issue, I noticed that the EEPROM
on my Banana Pi BPI-F3 does not contain a Product Name TLV entry.

alarm@k1:~$ sudo hexdump -C /sys/bus/i2c/devices/2-0050/eeprom
00000000  54 6c 76 49 6e 66 6f 00  01 00 20 24 06 fe fe fe  |TlvInfo... $....|
00000010  d5 52 bd 2a 02 00 02 23  0c 39 38 61 39 63 33 61  |.R.*...#.98a9c3a|
00000020  32 62 64 34 37 fe 04 3b  e3 ff bd ff ff ff ff ff  |2bd47..;........|
00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
00000100

Although the EEPROM is readable, the missing Product Name TLV entry
explains why read_product_name() returns `-ENOENT` (-2), assuming the
EEPROM read and validation succeed.

Consequently, automatic board detection fails, and U-Boot falls back to
CONFIG_DEFAULT_DEVICE_TREE, which may select an incorrect device
tree for the target board.

Since the SD card-detect GPIO polarity differs between the Banana Pi BPI-F3
and MusePi Pro, selecting the incorrect device tree can result in SD
card detection
and boot failures.

The following SPL boot log shows the board detection failure, although
DDR initialization completes successfully:

```
U-Boot SPL 2026.10-01060-gf3080abcfe92-dirty (Oct 24 2026 - 17:30:03 +0530)
Fail to detect board:-2
vdd_core, value:900000
vdd_1v8, value:1800000
vdd_1v8_mmc, value:1800000
DDR firmware: [0xc0820900]:0xf0227179, size:0x8d98
DDR is ready
```
Could you please confirm whether the Product Name TLV entry is
expected to be programmed into the EEPROM during manufacturing?

Also, is there a recommended approach for handling boards with missing
product information in the EEPROM to ensure reliable automatic device
tree selection?

> Changes in v2:
> - Consolidate additional common U-Boot properties into
>   spacemit-k1-u-boot.dtsi.
> - Reduce duplication in the board-specific DTSI files.
> - Retain board-specific configuration where required.
>

This current series is incomplete, I missed few code cnages
But I am working on a few changes to fix

Please review the DTS changes and share your feedback.

Thanks
-Anand
