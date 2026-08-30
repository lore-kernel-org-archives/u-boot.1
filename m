Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91C6C61DD9
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 20:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99D0540583;
	Sun, 30 Aug 2026 20:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HjYImSlub1uI; Sun, 30 Aug 2026 20:48:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788122883;
	bh=H7yH8q1bJgU1at2tg+DERahKABOY/WSGxTLoGdQW7gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6hCHOwuOjRjferfDNaCnJGTJB5PiSvNyB8jquSyNfeK5M0rZNp/C/4IibhAIA28x
	 MfrGNm0MYGQqILwhHWqg39Y2g5SBOokLvMs/xlbfs5SXD8XC+TVSXqDXCk3ePAEsvA
	 i42FaEqB88AHsfdDZxAruAinsoDbO2guu06knoTj9emy/oEGLfyYWUea+C9yPpDX7+
	 L3bhFk1brrpQ33gDEd4BGxaLKEvMRsbIGz5vPtw4ofJ6cwZwr8FotQ0TQWsujuD3/v
	 EFAisufwCubMmLhks51KC1mIY0mD0xUCheCoC/cfz3grQzRw/jNJkri1/MWptjl/b4
	 2x2uaK/4tYrSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F6104057D;
	Sun, 30 Aug 2026 20:48:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80E712AA
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 20:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57BC64008E
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 20:48:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8IlcZ37QTKGk for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 20:48:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=ZnWzxG0D; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=U15VK/Q/
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9936740048
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 20:48:00 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hY42P0MXKzMlDk;
 Sun, 30 Aug 2026 22:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788122877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7yH8q1bJgU1at2tg+DERahKABOY/WSGxTLoGdQW7gg=;
 b=ZnWzxG0DVjY/cK+XFMkWd6aCG/0JO4ustRu2E+f04eZ0ffKuicVL9+jYehIQYIDm/sHAut
 NhYHWNa07Sh6s5ddXpYzyd14cGI3KIsyQd+y1D4gOBJUYuE70RKXa1uWau+xPyhtF3d55R
 aAq1SjRci/WbbtQZh/rC99KUMFDGuPcld3RcY/uRHF+BagjL2FqL07P6w15ZqwjSEunV5E
 p5daye0VxXo675SxN698Ns1mZ9jJx9BK+Yg1PyUK7EHZTgw/+Li1qPKJNkcb+bTn4tEHhz
 MxoHcml1vfCs07ZWmf7MP4Myy70JCfk9SQuXau2KFVG8MLp3w+d2yOr57ZcEYA==
Message-ID: <3aa3d789-3cfc-4913-9003-9a9d8dc81647@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788122875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7yH8q1bJgU1at2tg+DERahKABOY/WSGxTLoGdQW7gg=;
 b=U15VK/Q/3z/wii13ELXaTyQARQjuMcdO0M1jkoFzYd+OjleUZebAZqm6PfgSWrlTYdy92c
 AFn9iYgEaW+XGyT9Cs/ubFGbJ3f7zfW0DkWKbLuKJiPtTtykUPavwTQTtQNHhsF+HQFtXe
 P7c8cgWZUacR3bAqz2O1/xZE0gviZffGKbhFE+tfDT2RupNW73sXa7jD61TFyw9MIAnckk
 k5lBhj8CXLpx5xpZqatR4qix3Qt8lrQFMQMWhVJcDDnkskJV/qessBFaHAeHCeHnwbAxVW
 nuiajzDaFUnMdcku+40+K9FOUt5TkBoqogN0Hn4F9COIkKoVirVZGgHpOQch/g==
Date: Sun, 30 Aug 2026 18:33:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] Add RITY devicetree preparation support
To: Carlo Caione <ccaione@baylibre.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
 <CALeDE9O3Taz2Q-NgEM4Prjn_Q=z6mXduMR7y_iSvwgBR6yKGXw@mail.gmail.com>
 <DL2BE0LQPFRK.1IXQLUXGFDKAW@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DL2BE0LQPFRK.1IXQLUXGFDKAW@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xg6kqp4irdn75dbb53s3nkadp1saqnsg
X-MBO-RS-ID: 540988d1c6860775aba
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

On 8/30/26 3:32 PM, Carlo Caione wrote:
> On Sun Aug 30, 2026 at 12:56 PM CEST, Peter Robinson wrote:
>> On Sun, 30 Aug 2026 at 11:18, Carlo Caione <ccaione@baylibre.com> wrote:
>>>
>>> RITY images select a base devicetree and an ordered list of overlays
>>
>> What's an RITY image?
> 
> Fair enough. Since this is all MediaTek-specific code, I took the term
> for granted, sorry about that. Anyway, RITY is MediaTek’s Genio IoT
> Yocto SDK. By a "RITY image", I mean a boot image produced by that SDK.
Can this instead use fitImage core code which can already apply DTOs on 
top of base DT ?
