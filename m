Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CBFCA5FAD
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 01:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6056810DE;
	Wed, 30 Sep 2026 01:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zI_orid6Z1Sj; Wed, 30 Sep 2026 01:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A8D5810D0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790730008;
	b=ClpMIDVoNFEvU+xwW+NYhTLSF5WNi37kKSIeZOghrmR4Ad5R6n/bN8ibpT0N4j5zsE+V
	 +kPVYFbGw7mCgoXr0ASzJG3h82sb1ugBghColvA7ckEhaeUDveFcCzMt7m8ZgjBaLqP6M
	 bL2MXmLwPmRR228uSFmK2s3/uz6Zm0b2kQbZ/ELF/R77ZV1S1QCL0e2iSIQi1sO1ShgWw
	 /w8WkpyqAvoGdzI9KfP4OqQFanJe+zVq0v/pJuprLRT44zOeJ3Ge+K3CjvUNzVVRvImYl
	 X3gKbfYqe9P3C2mvfnY1UsNPkrAJHGyr8W5gyt3f7P3sBtDno1UypmLKpX65yn6F+yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790730008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bjIeoCImtNNyXOBaOYEwElmAma6FtVXoJls+F+Yz6pc=;
	b=KX77gSFX4bNGYfUAvsFEpdIRj5JMhizVs9kW8cg81po4pegMyPvF+eFKjUbseURuKvLF
	 UbHLhPdWggkzdsIZocwzLK31p1yMCOi1M/TeE4tQBm7HNMbitBkC4Ed66flJwwVWmcWqL
	 ejURtpKd8j5xmfejeyBsJ/4xHNruQX0vOqCAFW5zcOZxELs1l1RxlZdwFWyP83h1YrnLF
	 yj/QtNlaLA2eTxWQCHLnvUl4L4AQleCb7IbG53/PTa2yIeu8wufgkKHDRA2tZ4Q+3/dhH
	 fVvZyeMScWALsbomboDQGDtqLandLRWGNIkxpkBrT1m5BUkV3y6RY8gSB5oGA4Sgjyw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="JI/qeLVp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790730008;
	bh=bjIeoCImtNNyXOBaOYEwElmAma6FtVXoJls+F+Yz6pc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0yPrB/xtWpTLQGh5HBRtMSbXHqiRcIuFsSt460hmdFr+9KL8q3NRjwPDpGe+cnVV/
	 vbN8jdbWOcJcGWLBNaAXcjgi0ySvRpvYCzRlbW+qC8Syknl/b9O8iR71vJiAlHukBK
	 CUVmX1kEJpWi37zYaQRIiZw8yphutve5YsGl4vc3IF/y5JlJ27MAcl15duTpmMmPeB
	 xqa+bhro8/TsG2N3S2op/8Leh/QYGKC3G8pYcg5yFlQGu2Vcy2a/wewoajkXfgPFSY
	 TqXqULb9NYT3hXBXKVqfX3heE5kbiD5ijVMuFo+Mctqb0NZoiEp4AZc/Z4dboEgG2z
	 OGcypoJoy2i7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A8D5810D0;
	Wed, 30 Sep 2026 01:00:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F3FC33B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60538810D0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VeVWLciPGGzn for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 01:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1C176810CA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790730005;
 b=jUWQVKAcxjFn9yentcvKGFsEqLUcWGBw1tObX7PgNF44CXjgF4tJ2bDj1Y4my1MdOS/6
 mdGHnLrXMdiHBCVoK1wctyUTRaePOlo1Lr5a7yKPsH625px8HrJ6HZfYgQplgIZ+wADNe
 RgJ34USLAL7nRGRlmflk8cYYFOXk6JzuxVvZD5XS7LgAGGAdNcc+9SB1GVjEnFf0YHesR
 Q3/kui3ZlKUItRrloxcKJTEb4zbmKDY9Cg8XWn0HiNIsrtiiBrtHZ5a8U2lSKxM7iEWes
 V7vsIW6JVI++qrSkC2EPIPQUpN2r8FoOHuJJVgrd9zweq92ly8tCwEPrzknGrKQ2V2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790730005;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=bjIeoCImtNNyXOBaOYEwElmAma6FtVXoJls+F+Yz6pc=;
 b=Un5tGe47SD26N7n+Bl8C56HJm6fe/JoAukrgktM2WescRw4uVj2suVpmD8d4MSPpddHO
 JAP+LZj4FXtI5h9us5l8GYw/gCVipTXgqf9JGUSEyi+P/AaHb5SAghAZkAc9vlOhrBYWu
 jGqyGgQxlkjhk9TanUAh5VW5Aq4idVnoM2HdxFjFgVI7WTO/XuleQn5iSq1FIEoROagHJ
 GBGorYK/eazg8FsHVft6OxnyuTpPQna5rrUME2KwGgTU6wCLV3xu60yaTOmcJgPkYCsyS
 /cR2PlDnkRcEBEAww0PKVsFzR4A3PmM+BY5Zy3JZ44PvMq29ul3lfuEzfjon2UzE4SQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="JI/qeLVp"; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=JI/qeLVp
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C176810CA
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 01:00:03 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hvcCM6Qs8z8v5T;
 Wed, 30 Sep 2026 02:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790729999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjIeoCImtNNyXOBaOYEwElmAma6FtVXoJls+F+Yz6pc=;
 b=JI/qeLVpkVevEnGgPVdHOfNRHcV9GKfnEAQrdOl93WzcUHIebNT+hnV5gZUAsl546X4iSO
 ULR7JTkNrv888iBevg6bfUFAMLfJfBzjEhgi16SVkjInSNlh/v1jaZ3uKgOQ6Q8nlDf9h/
 tmrZlY2/j/Ujobs/Xa+rskaQpUfGpJArlGVZUA2UbFAM2NLKb+G0xbVU1ikJuypzfalyy4
 d9D9JQpjx3b5aCq5D3w5Q//8CEtEWvxWsZ01QJuLCFtGKdx27OT7PdKCDlXCOgdblRzD/g
 XN09+skOaHDGCIr7BL2gt1E/2lSaRTat9KwOp0fY42AVNhdgYVgMzwq/nw+ohQ==
Message-ID: <26150591-3420-475b-9cbc-fcd2729495c9@mailbox.org>
Date: Wed, 30 Sep 2026 02:59:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
 <20260929225108.GD858934@bill-the-cat>
 <71a56a26-67a6-43eb-a90c-71231ec2cc0a@mailbox.org>
 <20260930001840.GE858934@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260930001840.GE858934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: i6amb3hu9ba8hcoggioyqw1e49aer7w5
X-MBO-RS-ID: 57e3982434a298329fe
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

On 9/30/26 2:18 AM, Tom Rini wrote:

Hello Tom,

>>>> Please note that this does increase the U-Boot binary size, and
>>>> therefore use with caution.

[...]

>>>> +config CMD_CONFIG_EXTRA_TEXT
>>>> +	string "Additional text embedded in .config variable"
>>>> +	depends on CMD_CONFIG
>>>> +	default ""
>>>> +	help
>>>> +	  This option can include additional text embedded in U-Boot .config,
>>>> +	  which is printed as part of the .config by the "config" command.
>>>> +	  This is useful for example for embedding build information into
>>>> +	  the U-Boot binary, e.g. content of OE /etc/buildinfo, but please
>>>> +	  do keep in mind that this does also increase the U-Boot binary size.
>>>> +
>>>>    config CMD_CONSOLE
>>>>    	bool "coninfo"
>>>>    	default y
>>>
>>> Is this just intended as a do-not-apply?
>>
>> No, but if there is a better way to bake /etc/buildinfo into U-Boot binary
>> and then print it, I am open to suggestions. I am looking for some way to
>> finally replace .scmversion with something more flexible.
>>
>>> Otherwise, it needs a gating
>>> option as well.
>> What kind of gating option ? This is gated by CMD_CONFIG already.
> 
> Yes, and there's platforms enabling it today. So yes I'd prefer an
> option asking if you want to add this string which depends on CMD_CONFIG
> and then this option depends on that new one.

That kind of option would actually make this patch worse, see the quoted 
part of commit message above.

If we add a gating option, we would end up with this in .config (which 
is included in the U-Boot binary and increases its size) for enabled:
CONFIG_CMD_CONFIG=y
CONFIG_CMD_CONFIG_EXTRA=y
CONFIG_CMD_CONFIG_EXTRA_TEXT="blah"
or disabled:
CONFIG_CMD_CONFIG=y
# CONFIG_CMD_CONFIG_EXTRA is not set

Without gating option, we end up with enabled and used case:
CONFIG_CMD_CONFIG=y
CONFIG_CMD_CONFIG_EXTRA_TEXT="blah"
or disabled case:
CONFIG_CMD_CONFIG=y
CONFIG_CMD_CONFIG_EXTRA_TEXT=""

Notice, that in the disabled case, '# CONFIG_CMD_CONFIG_EXTRA is not 
set' is actually longer than 'CONFIG_CMD_CONFIG_EXTRA_TEXT=""' and grows 
the U-Boot binary more, hence, worse.

(In case of the enabled case, it is obviously worse with gating option)

But in either case, this will grow the size of the embedded .config, and 
the only alternative I can come up with is to turn CONFIG_CMD_CONFIG 
into string itself, but that is awful.

Thoughts ?
