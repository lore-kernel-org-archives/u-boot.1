Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB6DEC1430
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 12:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F95838BB;
	Tue,  3 Mar 2026 13:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XRL9Xshd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4A883F2D; Tue,  3 Mar 2026 13:56:17 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCA58063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 13:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fQG594wYSz9tvR;
 Tue,  3 Mar 2026 13:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772542573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVchXoVPYn3V0zubCDdykK+9I5Ou9/ZloTdzSTBGE3I=;
 b=XRL9XshdWgY6B5d1S+NdCVEc9Chb5pqndJ3Sshi3wNqLAhcm2S5gk63gGkiKEQncknGJ/2
 MdnaMffbpMRILUCglLepUn8D6FGEIJvntwL5KDoK6vIKp3go8QcCQ2ATV5MDzG4du58/EN
 tNFocmJoHuV/i9FSFHRs7dNog7r39bSsR/whGh5I6Fw47A/IX+xL7ejwde2nnuNY+KPY/b
 lwtTb8OzHqgl5VoFxcmDVpDUOvV+iK8ZF/Vlusc9W8O3zO0G/Kx8eKmbsfL71wQC7zMAZ4
 DSzoqqA8r0LdpYkmjcK8ws8rcnz04VtPh43B03+mbGVhxEh68Rj8H+FaKtUukg==
Message-ID: <a8d27ad8-1966-4262-bb8e-1770ecdff242@mailbox.org>
Date: Tue, 3 Mar 2026 13:56:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/4] iopoll: Improve handling of timeout_us param in
 read_poll_timeout macro
To: Ronan Dalton <Ronan.Dalton@alliedtelesis.co.nz>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "ariel.dalessandro@collabora.com" <ariel.dalessandro@collabora.com>
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
 <20260302044532.2891813-4-ronan.dalton@alliedtelesis.co.nz>
 <49be65da-0d6f-4a5c-9819-c2bfdd8894c3@mailbox.org>
 <433b8b32e46ae1ef47157473afa051322ba6955d.camel@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <433b8b32e46ae1ef47157473afa051322ba6955d.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 79623dbfbc851d5db68
X-MBO-RS-META: yxa85dzjsq36tkkkzp4urmhanitzx7qi
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/3/26 5:20 AM, Ronan Dalton wrote:
> On Mon, 2026-03-02 at 13:54 +0100, Marek Vasut wrote:
>> On 3/2/26 5:45 AM, Ronan Dalton wrote:
>>> Wrap the timeout_us parameter in brackets and assign to a variable
>>> with
>>> two leading underscores to follow macro definition best-practices.
>> Is there a matching Linux kernel fix ?
> 
> The initial commit that introduced the macro in Linux already did it
> correctly. This commit brings it more in line with what Linux does.

Ah, thanks !
