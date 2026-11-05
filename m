Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE36606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WfSQ30i0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNScGX6G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B07C0810EF;
	Thu,  5 Nov 2026 09:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4q0QaZujbc-e; Thu,  5 Nov 2026 09:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2F70810F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793870354;
	b=Z25wNVOEpVGiVv28gSgpxQQdiceFK3ShGqYJPG1BalyBwDs300udlhbZ2WKSYIgvHnmU
	 m5BGf9H8SeehEvpvt45DhVQ3VFSjHWHHeNopJILqdF/jecf/AbZcaZ7p6MeLtY44ErF67
	 f1gt4bYSsj+uhtXHVsZnoPiHBl6hLYyI8XINXaI+xGKkBUTMfxFKrU6wIiyoIioG4Il2I
	 FU4/z1BsXD/TY5F26AwbyA8Xoiu7wWKTsZm+Ea/JTQJRyoHelXCa3SjaceeSscYt0mW2v
	 QzcUqLoAfeoXv4AEuGOU1Z/NYkbR4PjRmEudTAZrKB4hv5XYGMm0K/fiS2ik+dLJSoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793870354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8dSUV7wjVyJJR26cj6lse9Y6cZn0Wisc5kIgpRlfMmQ=;
	b=jv9GDt09VkzbWxUog+MLpZ/VNBELMOK/QuVmsW22JjxTZdXkXH3E/OiFqBQwddTsgu33
	 N38hR/rrQzOroPhSHGLj1qF0I5AplRR8sDEEjwh7PPOw5ueF0/1U8UujLVlI5ZArWkPYt
	 QceTzk9ztSLi62W2X3ut9jWH/2iUfHKkLyuRueqBa3cGzIHsCntGSPacBxcKpZd9bA7Vb
	 DdFmpftINCDcaQPjdtro6BnAmOUSG5+BNtMPFv1VWRJzQ9OsTMt2m7YmuVDJG8CwWXaYK
	 r1JVEfzkAbiYiaPR52D+HGYzJ7Ao/PEcjc9nmCXlZJR0uxSBQL/7dybSxTaUFqgqQOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNScGX6G;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793870354;
	bh=8dSUV7wjVyJJR26cj6lse9Y6cZn0Wisc5kIgpRlfMmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WfSQ30i0a9Dml9Q9oH5i7zdn88TK7nVMY8VQmRH6F+/gEgPYew0shI74uaECI4r6E
	 T7Szq87u68yAtrs0qrenr2XcKSDgKHeG1KMKB8jsCSjqQeBCXQD3b0o4E3G1gk3Ecx
	 HHeIHFuI+QPgkwXG0bYPTeRdpy3tT9G4cKfe9bZTSPbMwGleZqG5xPw82dkfzonrwE
	 o93kMT5FrRC2K/rVdx77QT/Hh37gphXXLTudvCeTHZSHvYLc2jEXez80ku9Hk895EV
	 DSBH4NVhXAHZ5is2hIJJB5vipZd/bWrl0d42rJGstMjQGi+AdJ8b5Tdgso4LpwolWJ
	 LOYTeehgzSoZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2F70810F1;
	Thu,  5 Nov 2026 09:19:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56935177B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 480C0810EF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzVBwD35DliF for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58F6A80A8C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TNScGX6G
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58F6A80A8C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:19:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86DE26062F;
 Thu,  5 Nov 2026 09:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8471F00919;
 Thu,  5 Nov 2026 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793870348;
 bh=8dSUV7wjVyJJR26cj6lse9Y6cZn0Wisc5kIgpRlfMmQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=TNScGX6G5m3mCHUoG4YbZE9c3ZQ8Dk2G798lRU/emVGYwnubxG5sPLJdzXeaI071u
 qLk1wu91lbyh1CCaHUh+gC5xUBEjwrmnAMJbn0mFNXtEiiLQvgx3I0RcKMr8/jvf3c
 zHKv2T3BcYs6MWE0j4p1g4D8VPCS6ONeCIDrHXPqWbT1y3EI4miwbmOcB5Nwr5BdOA
 qS0DI2drnTGvfk3nbVf8NnLXhkD4AGgiseUr6TX7D/qUPiX4Z+0U5P7lw/f5QOjG6z
 Yxzio7HCVLSAkWx8HxNQI8iZXm71QHhYVoYLcVGM0E3OGztrfUKHxAWsZ0SblxOL28
 UgNuz4f5wlR8g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 ricardo.salveti@oss.qualcomm.com, Sumit Garg
 <sumit.garg@oss.qualcomm.com>, andersson@kernel.org,
 nicolas.dechesne@oss.qualcomm.com
Subject: Re: [RFC] Qualcomm Firehose flashing protocol support in U-Boot
In-Reply-To: <20261104191539.GB1164024@bill-the-cat>
References: <CAPzfCAaR_oeEQW61U9Pf0ahS3pBm=tcMPbDeXQeoKffMB_vWQQ@mail.gmail.com>
 <20261104191539.GB1164024@bill-the-cat>
Date: Thu, 05 Nov 2026 10:19:05 +0100
Message-ID: <xhkdbtslvws8m.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Wed, Nov 04, 2026 at 13:15, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Nov 04, 2026 at 04:57:03PM +0100, Igor Opaniuk wrote:
>> Hi all,
>> 
>> I'd like to run an idea past the U-Boot community before writing any code.
>> It touches the USB gadget layer, block devices and a protocol U-Boot
>> has never spoken, and I'm sure your feedback can save us from wrong
>> turns early on.
>> 
>> Some background first. Every Qualcomm SoC has an Emergency Download
>> (EDL) mode in its boot ROM (PBL). It is entered when no valid
>> bootloader is found, or on request (button, test point, reboot
>> reason). In EDL the SoC enumerates on USB as 05c6:9008 and speaks
>> Sahara, a simple protocol for uploading an image into On-Chip RAM. The host
>> uses Sahara to upload a "programmer", a SoC-specific
>> Qualcomm binary (prog_firehose_*.elf) that sets up DDR and storage
>> and then serves Firehose. Firehose is the actual flashing protocol:
>> the host sends small XML commands (<configure>, <program>, <read>,
>> <erase>, <patch>, ...) over USB bulk, the device answers with
>> <response value="ACK|NAK"/> and <log/>, and sector data goes in raw
>> binary between them. This is how Qualcomm boards are flashed in the
>> factory and unbricked in the field with qdl [1].
>> 
>> We are moving Qualcomm boards to an open boot stack: after the stock
>> XBL, TF-A (BL2/BL31), OP-TEE and U-Boot replace the proprietary TZ
>> and UEFI stages. The Arduino UNO Q (QRB2210) PoC boots this way,
>> and the platform support is going upstream in each project. With
>> U-Boot in the boot chain anyway, we'd like to reuse it as the
>> programmer image too, instead of shipping a separate closed one. The
>> code that boots the board would then also flash it.
>> 
>> Hence this RFC, before I write the code: would a Firehose server in
>> U-Boot (a "firehose" command) be welcome
>> U-Boot community, so that the existing host tools can flash a board with
>> U-Boot as the programmer?
>> 
>> Why not fastboot: Firehose works on raw storage, not on named
>> partitions. It addresses any physical partition or UFS LUN by sector,
>> creates the GPT from scratch (rawprogram/patch XML, sized to the
>> device), provisions UFS, reads back and verifies with SHA-256, and
>> selects the boot partition. Qualcomm's build and factory flows already
>> produce these XML files, so a board flashes the same way from EDL or
>> from U-Boot.
>> 
>> Two ways in:
>> 1. Recovery, as snagrecover does it: the PBL loads a DDR-init-only XBL
>>    over Sahara, that XBL loads U-Boot, and U-Boot runs the Firehose "server".
>> 2. From an installed U-Boot, like ums:
>>      => firehose 0
>> and then on the host machine:
>>      $ qdl --storage emmc <devprg image> rawprogram0.xml patch0.xml
>> 
>> The first version covers configure/program/read/erase/patch/
>> getsha256digest/power over the blk API, with eMMC hardware partitions
>> as physical partitions. UFS provisioning would come later.
>> 
>> Main concern is XML. Firehose only needs one element per document,
>> with attributes and no nesting:
>>   <?xml version="1.0" ?><data><program A="v" ... /></data>
>> I'd write a small in-place parser for exactly this subset (about 150
>> lines, input capped at 4 KiB, sandbox tests with malformed input)
>> instead of importing a library.

Thanks for the details. This is very helpful.

>> 
>> Questions:
>> 1. Is a Firehose server acceptable next to ums/fastboot/rockusb?
>
> Yes.

I agree with Tom here. This is a welcome addition.
We already have vendor specific U-Boot commands for flashing
(rockusb/thordown).

>
>> 2. Is a subset parser like this OK, or would you prefer a generic
>>    one in lib/?
>
> I think a subset is likely safer to validate than a generic one, so
> that's the better direction.

I agree, I'd prefer a subset as well. It will be easier to review and it
won't be yet another project we need to sync from another location
every release.

>
> -- 
> Tom
