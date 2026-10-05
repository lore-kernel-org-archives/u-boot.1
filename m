Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E967CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7E2C40435;
	Mon,  5 Oct 2026 11:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7c4BSAIhgcqG; Mon,  5 Oct 2026 11:48:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1ACB340536
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200895;
	b=CYTRFLll890FhMxF/DMi8FNdcYb5icmoF71yBbSVupJ+515M8OoYlCDhiRqLb8rMkzMQ
	 5JrJVjUHaIGw3UUThC0xvyez+i1VFCZ0dCjKpe/j+AX/rJBw3sWwxYpWt0ha9DWLhbQMX
	 L8i+bkMp2zACoB+8nA5KSmAW+rlZKzggELpf3qTZGVkmF0PUM1WfRT5sOqvb8iq3EfUkq
	 mVS4xP913VSIDpsZ+jexAvq44rQWfAgsPLi4kKtO7Uac7p5eZ3/DX3eZciyEZR4+fbWqR
	 cEHdPXQRU7ePR3CFjQI3CttYeZrQjg7TEO7PgbPZPMWXV1L10ulX+5feyMFyLVrk08g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wTAefzmGdzz74BQhoEmpQxt5cuJZ/GrPug4nc4z/d1c=;
	b=IQoNNqREcZpcyEaPyVPmoGoXdAronXt0x65kMPA5GQcVE35nAFRc56HIoF0dwKQCmbAq
	 eu0qUS9ma9adaOWj44DXXFE3dnBVetYw2vfoiHU7VUrAuC4xT3zk90ZDtpBtWoW2rCd0d
	 T5xyOwxwNafm3YWzvwoQSqD2sEN5aHEPHXhC3G1UdwQ0XFaq/5W9khz/sE7AaiuLEEnnH
	 4JBJUtY+j0q8ROKQmo6pQBnJ3+H2TRMslg8WuMUcxUvGPjSegrZovLCnGFjGq+M7HQyjo
	 AYXQFP8qkagjDRuutUNR8mKn3LOlQmv1ooSueNpqEHAub/1Q4c3u+/Q5Cc4YUDJFrqw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dnjKqWR5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200895;
	bh=wTAefzmGdzz74BQhoEmpQxt5cuJZ/GrPug4nc4z/d1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQRfNYYaugMNJcMpnmk1MvGXtbj1ZqxIjkesKIwW3L7RNqcBH3l38uw2WfEMUjcqZ
	 MLDoe4TqBQCSZe46+tAoaaHUMzYyVZ+H+MlHzo7vbWCMG69K39Jb0dtGuWyeaBZsvm
	 Io+3JXayq6LilZUnfSP/5DLWA+5OOgpJuDlwuv/xHX4qgsgjhTnWp1xaWtp3W9yJc3
	 K4k6V+v+BkR/3fqPD054tYAN/+0jifNp+lLf7VNTz9ctSjWnBImXFwq5LQTx8fVP50
	 e/nvLzqRLkKQ/LjKo4vzklWUSIWrO1uyTEpVD+C7Zopve6oFWt704QX/ynbPtaPsGB
	 Cbrha+q8ZEJPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ACB340536;
	Mon,  5 Oct 2026 11:48:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5099D32F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 420E140609
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsOxdtEYI5-A for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 94B0940608
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791200778;
 b=btGJm3HLXKma57L8tjNg32OQIPoFxf7jyEL3Qw/PF8cvbZKGnWL/DQxx0s/yplLxerbJ
 bZ/H+u3bHrXESAvQtIVPLAs6M1qE19rD5VCbkLd7Y6SO2at381jSr25HazN2w+jSUwJuf
 Lc+JKZ4918x6FGvImZhufImFWNgHX0GCBQbgigTBde64g9hp+sLeLizv5QQvLqsPzsbmC
 rJvroExgo74ij2zK6CsVXDVEnKJXH4GBxfhp2y3R2BsBz0mExPSPmZat0T8tvvbK8Q2R/
 rDZVQKl4mRhOsZnDZynVtyFsEUD4iS2jceHZao0kWCG0C2EC06W9k0KTdTXup4nLImQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200778;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=wTAefzmGdzz74BQhoEmpQxt5cuJZ/GrPug4nc4z/d1c=;
 b=bnCiLrkBxWv0XbwJo8tTTPIOEEf9UXZ9coyOpPvZriSzZowCHeFvku02miZ/RhyJsbZj
 wmR91hq3avFrAWy2f7eiABeS7s7fuEyY5sQL/THGsvqbIimW4wNiFpbkJnsCXzN48QbbK
 g9KJpjmhG99Lr5y7BAAgEZvruYFydd4G02BBk8Cc8Z1hnVWUeruCzt1/M2fZAlNflWFiN
 Jxgs4gQkAOxumFtc9YSu1OpTNY2/4CR2qKnInJgajZw978+xbGx1m+r/Cu1kev9U65iby
 9PFzEYauQykqdOE8hH2hznYIPRI/zNomH9fz0aKLb8Loc/YCTLp4lwEMJir9dlLE1pA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dnjKqWR5; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=dnjKqWR5
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94B0940608
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:18 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyyJl2FFFzMlVR;
 Mon, 05 Oct 2026 13:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTAefzmGdzz74BQhoEmpQxt5cuJZ/GrPug4nc4z/d1c=;
 b=dnjKqWR5UHpoY5TK6mCX9/fG0DacgIKOUKekK7STIK+BIxImHA0GNbqq/Fy4XQY2U9XOWa
 jAK8bY7z3pDtHH8Qx18rnvGeESzSXRtNWDkjUbTqousRpIUwf+79ls3k5JiBTNjiD8rHdg
 QrYGvUI69HH2vT6OA+pPIjTVZoZdpZBE6O7SpSaA8+vuWSIIpbbUnvH1eGgnTpBweX++Ip
 +JckI+MEv7YIwOVJ4S4xM3/W4lvaLECRJuejHLkSjvKcJt0sCYfgVDNiJx8wU19aP6UD/i
 UmOfCPLxjb7CH0bpEGfNG1OJssTQ0MJuNV0mPnBFBlhhlju+qDKR9il/0tCX9g==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Pengpeng Hou <hppiscas@163.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: Re: [PATCH] ddr: Fix the SPD EEPROM dependency for Armada XP
Date: Mon,  5 Oct 2026 13:46:07 +0200
Message-ID: <20261005114611.743343-2-stefan.roese@mailbox.org>
In-Reply-To: <20260906045032.28384-1-hppiscas@163.com>
References: <20260906045032.28384-1-hppiscas@163.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1efyaekkasobh89wnei9ya8nzmxi5s63
X-MBO-RS-ID: 7f002eb0cbe6ea1600b
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

On 9/6/26 12:50, Pengpeng Hou wrote:

> Kconfig expressions use symbol names without the generated CONFIG_
> prefix.  SPD_EEPROM currently depends on the undefined
> CONFIG_ARMADA_XP symbol, so the Armada XP branch of the dependency can
> never be satisfied.
>
> Use ARMADA_XP, which is selected by the supported Armada XP SoC types.
> This restores the option for boards whose DDR setup reads DIMM timing
> from the SPD EEPROM without enabling it by default.
>
> Fixes: 8ce59b593294 ("Convert CONFIG_SPD_EEPROM to Kconfig")
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
