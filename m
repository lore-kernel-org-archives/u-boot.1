Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822FEC88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 18:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA65360656;
	Fri, 11 Sep 2026 18:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RT3bf6MMGwpk; Fri, 11 Sep 2026 18:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF4A960617
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789152404;
	b=jZULeRQN5zJiacqPzSCtt1r/jaKp+FdLcSqZ5TH9zRkY/V9i7geKC3xjrxNAm/6ldgJs
	 A9UdCA+6bXgtr1ecQgblgG23W4jOKza/GIKAoviCivbGbtV31JQnhYcthF8+E3QidQs5s
	 WvW5Vud9OQYuTdvNDhKb0sCOTQtJYxOpumyvXhLIq21fwEAuUrF6g8C/MC1sU7MENtwmt
	 uz80N/aq1z1yFJvMpQ29GXfWM/lM9H0TeGcmPJxYFuzAxmtdePCWvM5a7cxiEidfr6pjf
	 tHWS4Wp6PuZD1xOt0EZp8h5HBQxCuIAF5IMlVsifVJAIG4sAwaIGD1FOQvp0AHMCtag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789152404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PADBEY0Z5VdsVRWDuDPllUgdwAtJj5uhr8RM3GLd5SI=;
	b=WNmhfgnf4HeXITj8VR+Mk+IuVAAl1fxjN90aHXNUa0U021g3u1nbxx2zeNDpxMxPlhU8
	 ufFooikXrRfZcAj6LAWScCFqmm+qwV4t9tRx9EYxLvVfPf4Qsnca8H+PW3e+rdez1W/9B
	 dBAlv/3KBBDxLIaMppBK2bfGI50frQmTMX0SNPsW53JjaIcSniHbIQWhQ2dlC5sF16kO4
	 VP8dPGZCbS4jD4sq7CUyb7XyFJoYzjeHS0xtjUub0mgMAypEH7HIGFCHPGJwffSPnBPWM
	 yG/CbTLgtUK2mbF57doA2Cp7Ob6U9oiAs7EOeZaYd1XMIqcgDzCfosAtjWQEauwEtLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789152404;
	bh=PADBEY0Z5VdsVRWDuDPllUgdwAtJj5uhr8RM3GLd5SI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ifSP5N+CCqAFhUZ5Tx1qUDUXCjnrvimrmAYhrsLj7tbJhlL27aoI11rkxQyr3vNKr
	 ZVOusa62e3+r/bMAXk/UDAcv7+A49erFbKRo6TBD8xNb0vVN6WBvuhgNKiK409R5r9
	 BKmm8RANAM6xOSrWg8dEqvlgRdLdoV8kpg95cfPAYw1zxizdgXupT5Pe9FRIdVADrl
	 Z8oCpd8erKgtt1VVnAOy7MdQ+Tu9rrXTDQr+m2S5r9ukEDy6uXar/OTwTom/TEH0mi
	 YGZXZodxerJwhotlFI7G5qv21qKbr+LXmLpAlVEr0kOyYDnUx7wQab322inCPRhqo2
	 gPLvBmTqHeOMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF4A960617;
	Fri, 11 Sep 2026 18:46:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6AD33AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B49AF401F0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9J4o-byAQOl for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:46:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7283440061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789152400;
 b=aL17D2AVenOIeezn/I70mhWnxXN4/XUtGP3s0yiAg187e6CATUJsvi7RLqJjDxvaxYq/
 bJhAn6FTYKTOmipMWI5PnUZpJHeW68dmJRA/OzWBiT9b7fCyjqMkUT6QmOnIiutOX7Pvc
 c/70k/u6SKmWeA7897fPrNbHYL2aiz87cYgAjJzl19l4i0trgDmwZreU39Sq7Wx12VJlF
 DYsU1HpZInbq4b1TWnqPgzfYkc2VrzekNFHFjzmPPWW1O5JHeoOtnDr6FlG+a6t4fPtE/
 MtTeX26+IwBwd4ATQl+deqdMko65UzwkPtu2L1o41Y3OIt/dehd2D+AI4eb3E56sl7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789152400;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META:X-Rspamd-Queue-Id;
 bh=PADBEY0Z5VdsVRWDuDPllUgdwAtJj5uhr8RM3GLd5SI=;
 b=OHT1y3qqwhhbDNAkKTdW0QMSCL/BapQ4v1P6grRcDMdPQcMJGOPw2xXkEfj1+VfyhYmS
 zc8k6JBiSZ6XCt3ZLVUTgOZqQqbyEYP/lYqWB+0LyzmgJz4aZJ+Y9AeBqkQxFk2jKfacT
 M2K06d3FmCgFeQmMPEWLbfuf/tYjKyYttiv/DszqRCWm1SU8dXOcoTrKrEv3bd3YeYQl5
 HH4YS1dgczbIjih4Ymn0Oe0m4BWH6ZnHKw45T7J4nClsXhYGLMcRbw/+kczwd60PWh4Vf
 Y3OZXpBqSCPfMwyOgwvXYjB+LPC6R1cq56FkkVNkXoUIdHCCF97Do+Jn/TAykr9jeaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=oOtiQROH; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Yr+7Y69Q; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=oOtiQROH; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Yr+7Y69Q
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7283440061
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:46:40 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hhNmt0203zMkxw;
 Fri, 11 Sep 2026 20:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789152398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PADBEY0Z5VdsVRWDuDPllUgdwAtJj5uhr8RM3GLd5SI=;
 b=oOtiQROHpJfRDnyTV6q/K0fiFbLuyq3+UX/jIarKGpVhqL6dAAhmWkxzRVJ/0vgW7IuN6u
 JLvj6bpa3HHqDa/kOzkV/nGrW0YjiwdoIzaaAaMSgaLiKlw+/BR9itxrPrZ+lhXm7YwA6j
 B/2oz6xqB9LLPrzGUsG+Ndbt/D/vXvVS0/tUTvPSPARgd11a+BaTuAmlj0vHU9JPdeGmfg
 Lv971MSu20oFtLkJ1aBZ5/xNspmv2FRTkxBraA7QdRnpUBGJ3xRCD+ecIKG//PFlRYSQ/f
 XTbLDgZcMqiAhIwy8/bqA8NGhIXLJ10iawU1LxkZ8MxN682CIf3D2oeHoHaXSg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Yr+7Y69Q;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <49a1bcfe-1aec-465d-b138-52b6803ce9c0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789152396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PADBEY0Z5VdsVRWDuDPllUgdwAtJj5uhr8RM3GLd5SI=;
 b=Yr+7Y69Q3Qh2uIROBte198XDKHrK+0ECBYHonxF+z1ZhkFtDMDNHpgcBT3fRND8KwwxXiV
 qLrRg8lCeaxc7PRwmB616AU7CsR1PGHEPdvmG33J/BpT4cwGu4//S1mdw6dE+19NnrbzEU
 Cp7KYEofnyYUeyTJcKjaR7GkOROuv+Bb4yzq6h1jhfw1oOMz3Z5e8XReK5ROQzW7/xOL1I
 r2D6rflfjudqeWp9b+lqD3LAS0MOH008DZGA6yNsF2PLUrhefh2c8pSxUviquI38qVCXZC
 TnGxnPV5v9gK3w2jxn58J35Xn9VvKMLd2kavcg0obQyCz+jvYAoIi1Yr+E66Rw==
Date: Fri, 11 Sep 2026 20:46:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
To: phodina <petr.hodina@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Anshul Dalal
 <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
 <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
 <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f8db198f51e53327c3b
X-MBO-RS-META: t1m8rh54mu899w99dr88wtufzqmrrsay
X-Rspamd-Queue-Id: 4hhNmt0203zMkxw
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

On 9/11/26 8:39 PM, phodina wrote:
> On Friday, September 11th, 2026 at 8:30 PM, Marek Vasut <marek.vasut@mailbox.org> wrote:
> 
>> On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
>>> From: Petr Hodina <petr.hodina@protonmail.com>
>>>
>>> Add a new utility library for parsing command line parameters in
>>> key=value format.
>> Is this reinventing environment or UPL ?
>>
> 
> The target is a chainloaded environment. In this case u-boot running on Android devices where you unfortunately don't have the possibility to use UPL.
> 
> As stated above it's purpose is to simplify the operations on the command line arguments from the previous stage and pass them to the next.
> 
> Typical example is to remove the skip initramfs or extract the value for the panel to pick the right dtb (not part of this patch series)

Is this something you could do in an U-Boot script using setexpr 
sub/gsub instead ?
