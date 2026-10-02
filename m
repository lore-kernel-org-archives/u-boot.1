Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921FBCA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 05:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41DB18115D;
	Sat,  3 Oct 2026 05:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VdfKZ3bnDz_w; Sat,  3 Oct 2026 05:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 90F4E81160
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791006369;
	b=TgGin/TCxSk4ICFREjMUnNaAEKsRYkZtu0IhBQ1tBjjfpoyaLdmZZ7ZF+vLPQtXXJCui
	 eP8Uw7jrTwl5BpkYntgszQmiX82df1Ubzd9ewg05Nouenyl80L464qvvnizMDVnNIcS+P
	 KqXLPvbLq6NE+3H0f///rVIt5xOnWZM47holKccWDcVbTsocwQNgA6cZxA65Ur64ioJvn
	 FfkNjCC1r3jNz3FV+UgXvAki6dCFRzvTjG9C4CD7hWrz6EkCt4CWfsMo9y/PpuLlGjhm/
	 asloagVvO4r9mGuWOGM7cXp+ttWnQ1xoHFec2CM+0bpp0QBgeK/JMOo7b3xvYIBv8zQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791006369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4gtkg9QJvZ/vU2x57SS7uYpI1LlDTYbknvXPtJWkD+o=;
	b=HevHrLojVqH2xe20s9H86ekWe2x1J460BD9VixaBELbj190dgZIWNekFBiAISFbuR0PO
	 xRow7EhGq8lYapqx4L+ip1cHidtfF1dSbanu5u2D+zMkhi+FG7qjZC+4fhYSWkou6T29Y
	 sGJKhM2G+s29SJlL9SMpiccgSBEJFtVpwGQu2Qvqz4OAZqZ90yVL4W4E/SCkOgWFQr/uS
	 0ucIpiJWAkAvUb3IbZ7kp3OHwaqzb2j+n4LYcxqo1/98p8O2GjJpk2Cr507BaaW9V07q7
	 sfon5sgelMBvpG76LVjR1GmK0P5IJUF/sCzvqpB10Xuym2bsUaK9hTfj86MA+MeR1uQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=WsqW+i53;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791006369;
	bh=4gtkg9QJvZ/vU2x57SS7uYpI1LlDTYbknvXPtJWkD+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OBZzccOTiH05dE/sk1sQHAJ6VIUqkQhDcnMzUUwIE4cvRTwLttbbtrkwfXDta10Gw
	 BG61tTj1pfLeyZHvFHyYnrf8m3nZ3wwQRqJjZEWOtYDO272iMbAzMax5QzhEL+ctZE
	 sNPVdUcfc3+awNBSw2i05DQHr4tYoSJtf/t/JZ82GpfS6P3WnuB/SmkDmO++jMe22O
	 T0DtYU9a4ZG/fYrhwKGoOaIN496PWNVOvVI/6e4KYf/znewvl0L5lSr2MgYZtBYXvA
	 /Xv0jVmw7/nDodzFQBeVtgj7Fk9QdB11YWK/eHLKbnzxa5dJZGqiGmIKuYHYWFib/b
	 YJmU+4O37/ZQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90F4E81160;
	Sat,  3 Oct 2026 05:46:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56BD834E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C62081160
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:46:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jpknE41Zl6Gw for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 05:46:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CE59F8115D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791006367;
 b=SUWJrHzbN010TN+aLMNhwGtxbzVqr3770iT/lNko5lwzA88wzC2fMJMM9mDcE0qeR9I2
 Q7aQ14eOxMgt2/o4cXvTcG4gv8lWQZvqLwyyYzlCgVGGJV6+PvS/qq0+PbKH3F8tS9+wp
 my9C734RI9+Od7p3ZVlsemt/JzDVNwhWnOZoSU03kGis3bNztJ9biHqOMvhXdyAEUeHfd
 O8+7fR0oKkHbXZInPDWD3bWC27joCW6sIE3aIDuHMy/FfnEYxoONyYrCig2VMULFGOkmH
 wYRoUUGMdZ2G3SXLShOaCfcYjKFwJWRv7sx9JhwCz8Z9c13Tom7HHPcmTWbVTHqnemA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791006367;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=4gtkg9QJvZ/vU2x57SS7uYpI1LlDTYbknvXPtJWkD+o=;
 b=b57yOcRMjOAj02BzE3eDy3LkJBSjZw22miqAqKPmMXfmpQMnyXj0O+lxL6H8lTjFIojB
 HqcYjksqeZEcxxW9abMSyCwVNV2cKkIPNnzb5fSa5BHq/0k+RyVqIF0ZThMCGBs8Wny/x
 ljKvAHOBiCOrfvS4sNmotNGOM9UqLsnfnfVu3YOtKbD7x+pwlqtq4T2xvkqYnjMFASvZH
 zZx6zNhCqRimm9h6FZjUEd82+yYFxpearhWJQi3BX+pKYLg+gvo1C86vNrOXVk2WYc7CJ
 Djm7B3DeXeulmf2BN8m6KEh5Qp0FyyfbcKBNMjoC8jg9cmJi//WW86y8PyalwLXtP0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=WsqW+i53; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=WsqW+i53
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE59F8115D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:46:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D298010767B; Sat, 03 Oct 2026 07:45:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791006359;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4gtkg9QJvZ/vU2x57SS7uYpI1LlDTYbknvXPtJWkD+o=;
 b=WsqW+i533XIoKzsYpSS7GriTW02F2YaGQJSWbU3hWsYKo/bYwcs15OtJW55x2AAZcguZKH
 JeAhPaCSY9Xy4JLXNE79B9/ayqa7oFcSifFN1AOgr8BqRD1OGpI8kE0oGgv6FzwiPemNLB
 dFXKOYgQK+L5YTOOL0eJpNHecgZV6eUc8YC1KSu/yB9WkpJyfo/dlJmoFVWQG7jCuJ2Tvh
 3yHMizwbYNO8S5REU8T8inFOnineA+FfUY1CZdiQ00lmggaSbvNqXgF4n+iqydGfVXuKD1
 NEqAtlvd7NN8CNN7zHJSxqViNKytr0Z1VtVEVCAeWIhkSDzeRlhUt4cvYbI5qw==
Message-ID: <9b19abb4-026e-43f4-96d6-283461b123d9@nabladev.com>
Date: Fri, 2 Oct 2026 20:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: Add rdreg and wrreg subcommands for SPI NOR
 register access
To: Takahiro.Kuwano@infineon.com, u-boot@lists.u-boot-project.org
Cc: jbx6244@gmail.com, js07.lee@samsung.com, trini@konsulko.com,
 tudor.ambarus@microchip.com, vigneshr@ti.com
References: <20260924211708.108526-1-marex@nabladev.com>
 <1629bc58ddad414fb223ed7348c4cbbc@infineon.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <1629bc58ddad414fb223ed7348c4cbbc@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 10/2/26 9:16 AM, Takahiro.Kuwano@infineon.com wrote:

Hello Kuwano-san,

>> Add two subcommands, rdreg and wrreg, to read and write SPI NOR
>> registers respectively. The registers are always accessed using
>> register specific access opcode and arbitrary amount of data are
>> read from SPI NOR register and stored to memory or loaded from
>> memory and written to SPI NOR register. This is useful in case
>> the SPI NOR non-volatile registers have to be configured in some
>> non-standard way, or when debugging the SPI NOR configuration.
>>
>> Example usage:
>>
>> Read 6 Bytes of SPI NOR ID (Read ID opcode is 0x9e):
>> "
>> => sf rdreg 0x9e $loadaddr 6
>> => md.b $loadaddr 6
>> 00000000: 20 ba 20 10 44 00
>> "
>>
>> Read Micron Nonvolatile Configuration Register (opcode 0xb5):
>> "
>> => sf rdreg 0xb5 $loadaddr 2
>> => md.b $loadaddr 2
>> 00000000: ff ff
>> "
>>
>> Write 0xfffe (LSByte first) into Micron Nonvolatile Configuration
>> Register (opcode 0xb1):
>> "
>> => mw.b 0x00000000 0xfe
>> => mw.b 0x00000001 0xff
>> => sf wrreg 0xb1 $loadaddr 2
>> "
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
> 
> I understand register access from CLI is useful for developing and debugging.
> However, if we want to make this a generic debugging feature, we need to
> consider many vendor/chip-specific variations. For example, non-volatile
> register write require polling the status until completion (which is currently
> missing from your implementation)

Isn't polling only a matter of reading the status register, so it should 
be easy to script using "sf rdreg"/"setexpr var *address"/"while test 
var -eq ..." already ?

> . Some registers require address cycles for
> access. Some registers require latency cycles for reads, and so on.

The spi_nor_read_reg() passes SPI_MEM_OP_NO_ADDR to the operation, so 
maybe what we would need here is separate generic issuer of SPI NOR ops 
subcommand ? That is, something like "sf op <parameters passed to 
SPI_MEM_OP>" ?

> Unless we can support these known variations, I think this feature should
> remain a temporary local modification.
I would really like to avoid having to maintain downstream patches, 
those do not help anyone. But maybe there is a way to expand this patch 
to make it upstreamable ?

-- 
Best regards,
Marek Vasut
