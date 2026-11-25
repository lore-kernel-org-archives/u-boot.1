Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C528606A32C
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kxEF5DZ9;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=QpVJQrFT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09AD340127;
	Wed, 25 Nov 2026 16:24:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIEwivcPhe0B; Wed, 25 Nov 2026 16:24:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FBD340838
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795623857;
	b=dly4yT2/qDwAFiw6jU7GdOtaz6M3MddM6lTijNvN5BE9XNL4WwCE1se+HgQU4wEOkyVj
	 3v4ygBeNDdzxJOPWj3aibE0e9YScBJJkACUHtQdKp1hBdV4ZOVVGsLIcxPTCEQmq6LvWs
	 vCeGKF7cWOF7BKMlXspfSp6jkujboI60xxoBmhoJwo4RzoOXxh3gD3FZY4Cqgl+chVZWQ
	 PLuOpXW4qOZTP4Vrvgs/OaZmiyNmm8Q9I2mOhgFQOPo2FKv67kcNeDbMfmCjzcV0/HqHG
	 iUs2336xW70b7Dagc5kBqngTOEPG9oh48ujWGahZPdgsQkfIiDKvjApuN0eBQsKSjCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795623857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=21S0w4o8whn8p2SOWEx+YIEZTVUkPxacYyczR6+wqOk=;
	b=orW7w3afwV1PDNbnP1SFt7R3RiPObC5O+IFkAIEBw3l53PaMv13rdIGtdTBuF482Gd/A
	 JwXsA/USaMInV509nPbGXeaeaC9a5weC9c3EWIM0Ytb/9RR+AyFhEVjaKwqzQfuAOWs+9
	 Dp+BuXjXO/F1xFwECsXZo2rscRZMXAcFHLQkH0Jt5Qv9ZfsjUMFrXAtNznuV7gpSZnXE+
	 B4ujuqreNdfapT6gEmIP+VSvm0Wq+RYzTyUmGwbm/FI3f+w/p0gkXpWof2vuwk1qAFgEz
	 bKrt37FssO0xpZmKPD7ofIpPQrH+1E/J4WA9kfc/62Ja1/7rtKfmm4nv+Ta8mwzTxAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795623857;
	bh=21S0w4o8whn8p2SOWEx+YIEZTVUkPxacYyczR6+wqOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kxEF5DZ9eysXgzrX7oZ0YQsutUejk/igi1afVTGW40LaNcX6kQ2Mlr81aZeDTcSDj
	 Z5sEQw3pVjSdYtZXAnmmaujbfZPFA2Ah+rdikN/Ek3EeSnZUNMhdS3xqAywH9vtcU1
	 ucvpgx8S31fFbkRN5576vjHEmIUvMu798LBZhsTWX0KCVfQmilKvSgn7PgVFOynRfs
	 E9GU8nxKe/2Drc1zzzJ5SCUWEuIAidZGblTURKkSyuRvYm291rbyC8EK2WIJ0+/rlW
	 SNwNcsxNwwoHq7GLKiZNCkaweirGP/8NnOOWFHOTPGch+mArN1IF1sYBHDnalKVg3f
	 Rjwd1Q6ahMtaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FBD340838;
	Wed, 25 Nov 2026 16:24:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A2A826D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BB3460755
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9YkNzmnFZKFA for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25F3B605D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=QpVJQrFT
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25F3B605D7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795623837;
 bh=21S0w4o8whn8p2SOWEx+YIEZTVUkPxacYyczR6+wqOk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QpVJQrFTHiG9nNlr5NhyuIeFCLJKJsJ19WFeyR8iJgKVj6nT+ngQQJcR2VAltChqE
 crNjq2K3P3V5lHmegKhPqlaR4+IsRxkp6zS4YPDK7nVJSL8XUT3+Jy1hgLq4Jy/ZCJ
 ecPfQqUGiU4nia02GAj+1EHa3fzjRBDocZrIczP3mV57UHZGHbyJBIzIJXYj02ajDl
 +Z91Gf6aR/0fY2VjDDLMQnlyU0xwr2s+01lfknbQ8b+UT3WUOSRjQmfS6nx6qNxSL8
 8MesFFlVOtFeg7IlvljKu2nO62+g3deboCf7HADbohVP9pBS5DiyNQQaRk8Lv3kxxJ
 c0blotnPXxoPw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 050A3B2203A5;
 Wed, 25 Nov 2026 17:23:56 +0100 (CET)
Message-ID: <20f0a389-8672-45df-b5fe-6593cab0e4e2@freeshell.de>
Date: Wed, 25 Nov 2026 08:23:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] riscv: spacemit: Add GPIO and pinctrl support in
 SPL
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Yixun Lan <dlan@kernel.org>, Zixian Zeng <sycamoremoon376@gmail.com>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
 <CANAwSgQ-vKfciZ+F+vAqmk-kJS1cqMxKWaUrRBbyYnwgWcygXQ@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CANAwSgQ-vKfciZ+F+vAqmk-kJS1cqMxKWaUrRBbyYnwgWcygXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

On 11/25/26 07:35, Anand Moon wrote:
> Hi All,
> 
> +Zixian Zeng
> 
> On Tue, 24 Nov 2026 at 01:07, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> This series consolidates common U-Boot device tree properties for
>> SpacemiT K1 boards and enables GPIO and pinctrl support in SPL.
>>
>> The device tree changes move common early boot properties into shared
>> DTSI files, reducing duplication between the Banana Pi BPI-F3 and
>> MusePi Pro boards.
>>
>> The remaining patches add SPL build support for the SpacemiT K1/K3
>> GPIO and pinctrl drivers and enable these drivers in the K1 SPL
>> configuration.
>>
>> The series consists of six patches:
>>
>> 1. Move common K1 U-Boot nodes into a shared DTSI.
>> 2. Remove redundant MusePi Pro device tree overrides.
>> 3. Move common K1 U-Boot properties into the shared DTSI.
>> 4. Add SPL support for the K1/K3 pinctrl driver.
>> 5. Add SPL support for the K1/K3 GPIO driver.
>> 6. Enable GPIO and pinctrl support in K1 SPL.
>>
> Following the description on the Linux mainline list:
> 
> [1] https://lore.kernel.org/all/20261123-fix-bpf3-eeprom-v1-1-df8cce6ef2b5@gmail.com/
> 
> I am currently working on enabling multi-DTB support in U-Boot SPL
> for SpacemiT K1 boards.
> 
> While investigating the board detection issue, I noticed that the EEPROM
> on my Banana Pi BPI-F3 does not contain a Product Name TLV entry.
> 
> alarm@k1:~$ sudo hexdump -C /sys/bus/i2c/devices/2-0050/eeprom
> 00000000  54 6c 76 49 6e 66 6f 00  01 00 20 24 06 fe fe fe  |TlvInfo... $....|
> 00000010  d5 52 bd 2a 02 00 02 23  0c 39 38 61 39 63 33 61  |.R.*...#.98a9c3a|
> 00000020  32 62 64 34 37 fe 04 3b  e3 ff bd ff ff ff ff ff  |2bd47..;........|
> 00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> *
> 00000100
> 
> Although the EEPROM is readable, the missing Product Name TLV entry
> explains why read_product_name() returns `-ENOENT` (-2), assuming the
> EEPROM read and validation succeed.
> 
> Consequently, automatic board detection fails, and U-Boot falls back to
> CONFIG_DEFAULT_DEVICE_TREE, which may select an incorrect device
> tree for the target board.
> 
> Since the SD card-detect GPIO polarity differs between the Banana Pi BPI-F3
> and MusePi Pro, selecting the incorrect device tree can result in SD
> card detection
> and boot failures.
> 
> The following SPL boot log shows the board detection failure, although
> DDR initialization completes successfully:
> 
> ```
> U-Boot SPL 2026.10-01060-gf3080abcfe92-dirty (Oct 24 2026 - 17:30:03 +0530)
> Fail to detect board:-2
> vdd_core, value:900000
> vdd_1v8, value:1800000
> vdd_1v8_mmc, value:1800000
> DDR firmware: [0xc0820900]:0xf0227179, size:0x8d98
> DDR is ready
> ```
> Could you please confirm whether the Product Name TLV entry is
> expected to be programmed into the EEPROM during manufacturing?
> 
> Also, is there a recommended approach for handling boards with missing
> product information in the EEPROM to ensure reliable automatic device
> tree selection?
> 

Is specialized equipment needed to pulldown the WP pin on these boards,
or would a common office paperclip (and a steady hand) do it?

In other examples we've just invented some reasonable-sounding product
ID and stuck that into the logic. Particularly several Milk-V
product-lines had wrong EEPROM values and majority of their sales
through a vendor that would swap product models without informing the
customer, and Pine64 shipped non-programmed EEPROM on early
manufacturing run of Star64 boards. There's several of the StarFive
JH-7110 SoC -having boards by third party (not StarFive) where the
manufacturer uses the same EEPROM product ID as the StarFive VisionFive
2 1.3b reference board even though the hardware is widely different.
With a steady hand and a paperclip...:

https://freeshell.de/e/riscv64/vf2eeprom/

...it's not too much trouble to pulldown the WP leg of that IC part on
the board and write a new product ID to EEPROM. For the integrated
products like Pine64 PineTab-V however it may require specialized
equipment and/or significant risk of physical damage to the product to
get access to the WP pin of EEPROM IC part.

Something I intend to do and haven't yet is a bare-minimum dts for
JH-7110 SoC -having boards which has just enough functionality to write
new EEPROM values and SPL fastboot by default through the on-SoC USB
interface. Currently in respect for an abundance of caution to prevent
data corruption and hardware breakage if the EEPROM ID does not match it
does not continue to boot. However, not being able to continue to boot
with a non-valid EEPROM also makes this software then useless for
updating EEPROM... so the way it is postured currently is that vendor
BSP is recommended for EEPROM setting actions. This is not a solved
problem in my opinion and it would be welcome to have a general document
that describes this.

>> Changes in v2:
>> - Consolidate additional common U-Boot properties into
>>   spacemit-k1-u-boot.dtsi.
>> - Reduce duplication in the board-specific DTSI files.
>> - Retain board-specific configuration where required.
>>
> 
> This current series is incomplete, I missed few code cnages
> But I am working on a few changes to fix
> 
> Please review the DTS changes and share your feedback.
> 
> Thanks
> -Anand

A note about spacemit-k1-u-boot.dtsi it does generally look good however
the per-board property overrides (as determined by Linux upstream
organization) should go in per-board -u-boot.dtsi files. When device
tree changes get merged in Linux upstream for e.g. bootph-pre-ram hints
or prior to being a proper cherry-pick in U-Boot then it's so much less
confusing if there is a 1:to:1 relationship between upstream where/when
something is merged and then looking at U-Boot to figure out if/when it
can be safely deleted as being redundant. I haven't looked at the K1
dtsi with much attention but I trust you're aware of this.

Best regards,

-E
