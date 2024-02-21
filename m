Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850B0C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1209E87DCF;
	Wed, 21 Feb 2024 08:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="ILJQXor4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9nodK1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA9F87CAB; Wed, 21 Feb 2024 08:31:28 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AF18802C
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 0786432009F9;
 Wed, 21 Feb 2024 02:31:05 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Wed, 21 Feb 2024 02:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1708500665; x=1708587065; bh=Gt+73d06FG
 ipc2R55gHZidZibt3m74DoHlbg+66jDEY=; b=ILJQXor4HXdtegYiyz1a0M/A+V
 N3gsx/UVY/d2fQ4FJ94vXHd8MiS88n7TIZtgQAPJjLsq+GlcOAsGS/uMlshRLjx0
 UwRpveNLIC5gPNVtgOsoApr1UgEHL61CMUMCJz+atvCWcfognoyxZ/c7SbuSJ6YE
 MWWgvz6Gu4lqShgY9O233V3BdCdFd9mjRmeq65iDsXnLKKQA0OauBe4/22dHvQFN
 +ZJHhes5kTA/89FdsPJP/L5Qe8rbef1WeEdflvmLYcuyQY9ZaKulEAtD0EbIx/3Q
 FgKiLlBUmOxgpXolFNiRqI1ka9xyZa10POjgpoNbv/0ZREdQVQ4I9uXGuC1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708500665; x=1708587065; bh=Gt+73d06FGipc2R55gHZidZibt3m
 74DoHlbg+66jDEY=; b=G9nodK1QpA19wtyR5kRU5vMxD3/ZKVtcbYEJevss4v5z
 TWOr1+GXgIIiukvFTY06In8QrBPYDlRvKUar450VIi3nMeyAMNVxsamXhv30caEL
 IsQBopWm378Qh6wJ0vhghn/zbZFJh2vXJGKK0Do6AovfGaKYtwpM/Ld9FLvNPJku
 M0R5nLkg9urbmZlPIHPd4mlLfYESa1WcwrY2KvrfPl/SaLzGUCbISCP3RQxY19Xk
 A1hQUIFEakwq7PJrFZ5ReCwcRdJBIrwhAj/DB8/+17LjmF3EOZtTeKCnRpIHjtr+
 TGQMMpgrtZBqivSIQ4Tq/yZ+MwWFTAxgKHsCp+i/iQ==
X-ME-Sender: <xms:uabVZV47mvI0HY_H7I7aMcVg9mi6OK216BpvCbebW5-3MMvCvPtXGw>
 <xme:uabVZS7Xn2PBNwGY94f3js39-2n_8RkaqFcjnu0Hzs1JivJL-0VeovZMUI-tNvMd8
 ACFGpMDLOLINUJaw6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfgr
 nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepvedvhfdtvddvtdfggffgueetudfhieegveefffeukeehteffkeejheejfefhiedt
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjh
 grnhhnrghurdhnvght
X-ME-Proxy: <xmx:uabVZcdKKkBNqdWT6F7JV79JTbhUpvCKmO3g4qGvl1vsZU6VVnQ6kg>
 <xmx:uabVZeIMiBe77sKkSOmWPHInUFP9-I7-4vrHB0xv2wAG79o37EW4aA>
 <xmx:uabVZZJMHFnaiiv1ej-1SlA__bZKD4Eywt9VMj56je-3-HfvafGuSA>
 <xmx:uabVZZ0b4gh9bhVpzMJFbRk_wvAWLXcHPV-HjV-ZtdfWxo2--bT5nQ>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 19A50364006F; Wed, 21 Feb 2024 02:31:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
MIME-Version: 1.0
Message-Id: <5bb35b42-8328-45bb-96e4-0e9ee518e101@app.fastmail.com>
In-Reply-To: <9f9c2e53-1639-48e6-b441-1c73abbe48b8@gmx.de>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
 <20240210-vidconsole-utf8-uefi-v2-5-88c03db60de2@jannau.net>
 <9f9c2e53-1639-48e6-b441-1c73abbe48b8@gmx.de>
Date: Wed, 21 Feb 2024 08:30:43 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: "Simon Glass" <sjg@chromium.org>,
 "Andre Przywara" <andre.przywara@arm.com>, u-boot@lists.denx.de,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Anatolij Gustschin" <agust@denx.de>
Subject: Re: [PATCH v2 5/6] efi_selftest: Add box drawing character selftest
Content-Type: text/plain
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

Hej,

On Mon, Feb 12, 2024, at 17:07, Heinrich Schuchardt wrote:
> On 10.02.24 13:46, Janne Grunau via B4 Relay wrote:
>> From: Andre Przywara <andre.przywara@arm.com>
>>
>> UEFI applications rely on Unicode output capability, and might use that
>> for drawing pseudo-graphical interfaces using Unicode defined box
>> drawing characters.
>>
>> Add a simple test to display the most basic box characters, which would
>> need to be checked manually on the screen for correctness.
>> To facilitate this, add a three second delay after the output at this
>> point.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Signed-off-by: Janne Grunau <j@jannau.net>
>> ---
>>   lib/efi_selftest/efi_selftest_textoutput.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
>> index 2aa81b0a80..cc11a22eee 100644
>> --- a/lib/efi_selftest/efi_selftest_textoutput.c
>> +++ b/lib/efi_selftest/efi_selftest_textoutput.c
>> @@ -33,6 +33,19 @@ static int execute(void)
>>   	const u16 text[] =
>>   u"\u00d6sterreich Edelwei\u00df Sm\u00f8rrebr\u00f8d Sm\u00f6rg"
>>   u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u03ac\u03c2<\n";
>> +	const u16 boxes[] =
>> +u"This should render as four boxes with text\n"
>> +u"\u250c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
>> +u"\u2500\u2500\u2500\u252c\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
>> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510\n\u2502"
>> +u" left top    \u2502 right top     \u2502\n\u251c\u2500"
>> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
>> +u"\u2500\u253c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
>> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2524\n\u2502 "
>> +u"left bottom \u2502 right bottom  \u2502\n\u2514\u2500\u2500\u2500"
>> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2534"
>> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
>> +u"\u2500\u2500\u2500\u2500\u2518\n";
>>
>>   	/* SetAttribute */
>>   	efi_st_printf("\nColor palette\n");
>> @@ -126,6 +139,13 @@ u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u03ac\u03c2<\n";
>>   		efi_st_error("OutputString failed for international chars\n");
>>   		return EFI_ST_FAILURE;
>>   	}
>> +	ret = con_out->output_string(con_out, boxes);
>> +	if (ret != EFI_ST_SUCCESS) {
>> +		efi_st_error("OutputString failed for box drawing chars\n");
>> +		return EFI_ST_FAILURE;
>> +	}
>> +	con_out->output_string(con_out, u"waiting for admiration...\n");
>> +	EFI_CALL(systab.boottime->stall(3000000));
>
> We don't want to add any unnecessary waiting times in the unit tests. If
> somebody wants to see the output, he can scroll up.

I'll remove this but this series is adding UTF-8 support to the video consoles which do not have scrollback. This is also the reason for the terse test lines.

best regards
Janne
