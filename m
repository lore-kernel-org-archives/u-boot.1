Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DFE606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tNeo2W76;
	dkim=pass (2048-bit key, unprotected) header.d=writeme.com header.i=sinan@writeme.com header.a=rsa-sha256 header.s=s1089575 header.b=H2A1aNyC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 490FA40979;
	Thu, 22 Oct 2026 01:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tUmg9SScEwOn; Thu, 22 Oct 2026 01:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 85D0B4097A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792632653;
	b=n5jVIi4prvd5tprKRdNSZUnbRzVmdfmlaAbfHm6fd9RSs0Zk6DTAqA8SEDthijDOjDBl
	 7NoP6N5NQ7CIo3YJFwBH7nWMb+OFK19EOyIQF2+yJZ/y+1hFqo0xc8bzfIHQNmC9gZnFR
	 6psq5/xVWPrMUFGn9d6Gvu+jGCb3KbVf9YWMBxtLFBDilzrEtH4fsPoHYz6eM4u4tHbdo
	 lbYYtbgZInzBVUKf8+tJVRxHL3tFVuq5nauf9/P5HjDUhXy4JM77SGqVPfgbs/a6NY0uR
	 2jDNHKNFdi+2Jea5Gi8T6dQYG+YcQjE8xfEaqnuakyRBRTxWF2CbuSjmN+j4XqXfG/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792632653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+E5alWe5ZGNcWPXM2Rd9M2lkytGdBhJ4oWrm0TAHKNA=;
	b=OT3h70Ke2LpOgP6hkVGSux9GoYTnHPpEXHLVA1Pn3ZtaDcUzaaEozvbU++lV4+cqFnNv
	 wogw0X6r/0BvqQIA4siKtWiWcBcSJ52c4DuM8CJOCAtPHb3rfDoN6G3F9/8DSnyO6ebko
	 dZHRdHFrxTJ96mYGGGs36yh43UXNwCYrHk5DOVPFUSjopAO+bVr95vEU0m0AMJm6vzsxY
	 LDl8YXb2YHukRQCbuphdl/731BMFI3oNAUjP46xF9dvS4vqwRPrPo69tF7hx8d2f9H4qW
	 3QwFP4pIFASBDqRNv1jykVTXJDTlRedlVXNRmKmcm5sfg13nRme8gf4DQGe9AzVDI8A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792632653;
	bh=+E5alWe5ZGNcWPXM2Rd9M2lkytGdBhJ4oWrm0TAHKNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tNeo2W76vj80y8ZYl+zLZykGrnqnJdJe9ErQkF8p+7XyID506op8lW5asXBl2CaQ1
	 OIttRQwMqd5RGL02BVusOimVltLV8pUgm5oPTeHdTtjLxOjujUiYDvUnGGD/gp2ZoB
	 gJmAQYZo5iuxwn/84nXrbTkKo1HXFxNXYYHS1B431RItGd86qRV59kBJCP2Qu+Fot1
	 KthhQ5KVufOalD+tF9B/lyF5aUEYq97Bf8EYAubkNs+vcncc4OPSuCyFb7SDNJDIIT
	 g7yXxBA3THTDo3qTcarr4LZTA3vKUPb3g/Dw3If7xLow+kD5V2aKWKt6kbI6Qteccf
	 3ZZjn/Op1W8AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85D0B4097A;
	Thu, 22 Oct 2026 01:30:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B47F371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5103561153
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMDBOOSToouV for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 01:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C14156124C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=74.208.4.200
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792632651;
 b=QZr1H7WST+XSoD8WEGFfIFYid4GNyqHCyIeTURv+4djzCkdDaj9O0EFk4utLRGvWBikH
 zWT67bcKJyW/L3eo/MeVGHGUx1pvCaJqY7IL3+zPSCvS68fvWmy3pJ7cKMAVZw4s0MzM3
 L4BOkP+z+uE8MYI86J7SVMj4/I/DmSl2EZHFHmzFhmbOQtq0sXJgoVl1Dud0qpHudnG4C
 uDaAJkQPuo6aC9tYpBkCRSRbMELdZl6NQN72/UnGbxgXWvkgk3Uu274O1mscI9KPQWcsJ
 xOMKX1xXkO+SNXlJZNO0y3p2BQg3JlqNjhmNTsmdhUGXcf2Mzw5ImERPGLYc/16jREA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792632651;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=+E5alWe5ZGNcWPXM2Rd9M2lkytGdBhJ4oWrm0TAHKNA=;
 b=ayEmjWomHZIcCicDtu2GX4KqpGQRzvqXBtouHB0uBWfvARIxdwwuqCp4QgCKdqVuq9NM
 toK8L5u39uYW9Py89cFGX3CdL3r4ajUQN1rlu0o5WJ3yPgcajOnmu3RWp1uUyzVlYrRt3
 LVcFqU1nBlorbDnl/B/5Mq8rXTf8KWb4mG4kODkZVSCth0yvC6KCslDipXzen069hpTmS
 TNLuJNOKPGCcr6bWr6VEcE2wVrZNX2CFSncvHa7YmpdC3w3fzyoRMzU6bkd3hO4wOWLa7
 fIyfs2gWqY/Y9KaoDCoDLqaxotQzPTgZBJ79tfiTqemH7hr21ELweqgdvGB9j+b518g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=writeme.com;
 dkim=pass header.d=writeme.com header.i=sinan@writeme.com header.a=rsa-sha256
 header.s=s1089575 header.b=H2A1aNyC; 
 arc=none smtp.remote-ip=74.208.4.200
X-Greylist: delayed 307 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 22 Oct 2026 01:30:50 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=writeme.com header.i=sinan@writeme.com
 header.a=rsa-sha256 header.s=s1089575 header.b=H2A1aNyC
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.208.4.200;
 helo=mout.mail.com; envelope-from=sinan@writeme.com; receiver=<UNKNOWN> 
Received: from mout.mail.com (mout.mail.com [74.208.4.200])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C14156124C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1792632649; x=1793237449; i=sinan@writeme.com;
 bh=+E5alWe5ZGNcWPXM2Rd9M2lkytGdBhJ4oWrm0TAHKNA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=H2A1aNyCLnkhSdF+q9kBdu9AW/P18uHsLSYjZOICAbQOeDoo4evdNLVoeun5UV53
 giGrrQ2ImCj2PYucZJDS5dON6JEsonZg0dtg2Bnj+hp93JV/5wzy2vMGMADnyRIAm
 3zCxiE4P3ek0DmBNHwXwN9Ifj2kZMUJ+2GGYuq4+Gf9/7RWCyyxqskA3G2vc34szk
 gSIy+fd9cBK3Fyn+p4FnLAM9lX5mFYoF/dcGlrVPnbnIff2UKnpL6UFRyaGZMecxo
 3kEdS80vN7pYqfeqvoZY1jCPBbJZxhVykZ2v1DJdHw7I2brjf7eW0+/nbbptnYyIu
 bT0W5hE9agSI9HJ3jg==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from client.hidden.invalid by smtp.mail.com (mrgmxus003
 [74.208.114.75]) with ESMTPSA (Nemesis) id 0M4XZC-1wNUpz35G0-00yA5L; Thu, 22
 Oct 2026 03:25:31 +0200
Message-ID: <9c11fc28-0397-4667-8e9e-823838781a63@writeme.com>
Date: Wed, 21 Oct 2026 21:25:18 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/26] board: powerpc: Remove MPC837XERDB support
To: Tom Rini <trini@konsulko.com>, Bradley Morgan <brads@mainlining.org>
Cc: u-boot@lists.u-boot-project.org, Mario Six <mario.six@gdsys.cc>
References: <20261021160145.10430-1-brads@mainlining.org>
 <20261021160145.10430-3-brads@mainlining.org>
 <20261021180946.GG3275858@bill-the-cat>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <20261021180946.GG3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b+CMhLGooWLv8alpdP0Xky677VVWGxuJR9fHBu8AUqYxAUBt+PH
 lq7ELPyW85V+OPT3/JSup/iQOtuigXywYnIP9j8HwDFVtp0BW8bP2S+VCokrYYhudTzASkD
 ZQ2yzoMqD2pkSpTFk4pVp2UhlNDd07Ol1Oqus0M8l/DFvfRWie+2EuTnPNlai+zEeVXz9I6
 /ESlW6n49U0DGlgl/39+A==
UI-OutboundReport: notjunk:1;M01:P0:gMh7PVWa4FY=;rZZyPHdit+JRNssddQASeIvDSWU
 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
 4h0NJEDCSTyOKGJrwOxpFTebOISlU=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom

On 2026-10-21 14:09, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 04:00:58PM +0000, Bradley Morgan wrote:
>
>> The MPC837XERDB board is unmaintained and lacks active community
>> testing. Drop this target and its board files.
>>
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> ---
>>   arch/powerpc/cpu/mpc83xx/Kconfig    |   7 -
>>   arch/powerpc/dts/Makefile           |   1 -
>>   arch/powerpc/dts/mpc8379erdb.dts    | 153 ------------------
>>   board/nxp/mpc837xerdb/Kconfig       |  15 --
>>   board/nxp/mpc837xerdb/MAINTAINERS   |   6 -
>>   board/nxp/mpc837xerdb/Makefile      |   6 -
>>   board/nxp/mpc837xerdb/README        |  97 -----------
>>   board/nxp/mpc837xerdb/mpc837xerdb.c | 242 ---------------------------=
-
>>   configs/MPC837XERDB_defconfig       | 193 ----------------------
>>   include/configs/MPC837XERDB.h       | 218 -------------------------
>>   10 files changed, 938 deletions(-)
> As we had talked on IRC the other day, you still care about this
> platform, right Sinan?
>

Yes, I would like to keep it for now especially if there are other=20
powerpc boards that are staying.

Thanks
=2D- sinan
