Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8499D13592
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A908862E;
	Mon, 28 Oct 2024 03:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CtUH/dOs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Uoxpms6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD9E88EAE; Mon, 28 Oct 2024 03:34:05 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B3E8841E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 03:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XcHWl5Sqcz9shl;
 Mon, 28 Oct 2024 03:33:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730082835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1g8vqySVWR71CzraRnNELBChL3r+TFDjkVBxy1qX5T4=;
 b=CtUH/dOsbGZjFB0WRxn8oQcdT/KEBeOtX7JDbTHNqSPebFpE+GF8j6H9K7cHu9JdbC2nnh
 4KBIo5wBvWcgZM0U65dKl18Axgzg/hJTcn3UW6FYg0VnGFnZNei4U3zrr9xInbGKoEhRuN
 MgJ/MPtVr1Rw+F82l9bIs5iWNyBtaDzfn1BP5wpcfPjA5zp2ID6VDvIim2VejoKz48J9PI
 sAjoSzokhUhHTR7ZYUwd3vjiwSXaNoRiTQo0KlkqXSFFKmsHeLObbaPyz5Hc4BaoZzaFmu
 Y4pPZYl/62ruvFGr60Q+CKnFtuagxAXfn5rd9/8XjMFvgeHyDcJB8RDoEMz8NQ==
Message-ID: <d00691ed-815e-4db9-b5d7-b09c32ead593@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730082833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1g8vqySVWR71CzraRnNELBChL3r+TFDjkVBxy1qX5T4=;
 b=Uoxpms6noXNiRBMfaQ2irWzY5s438FxBnD9p/5v7Y74npOrX2qV9gUF97K0uN8jt8d690Q
 Fra2iuyCsZSfMEcZyr7+hbgchTSTj7Xxu3nnwPr4eg1FeA2qqQ+2VjFOaiXLqdsIZgaQLV
 5MZh6u9zdxtw3o1V+x59xz+bIJkmFOz69axK3XtnOPHuDg2B9GM5IfgB+tuw0XnvCEbTap
 ongN9hPJlO2iM/DZ+zalM3/dCJ75CYDxSjQrSUOcB1ck4QNNrBm60sF1xCx1v7DN+uoAnT
 CJ7Xt1RRmq1APw0rEwYewkT6koAfJdg+qBC9AoaXVtqLxef9NKb8PW6kqXrUlw==
Date: Mon, 28 Oct 2024 03:33:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
To: Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, John Crispin <john@phrozen.org>
References: <20241021005642.153511-1-weijie.gao@mediatek.com>
 <Zx1Bpb7_9TEqBeyB@pidgin.makrotopia.org>
 <37e445c29de0c1ef020d56a7d4da2916d692545b.camel@mediatek.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <37e445c29de0c1ef020d56a7d4da2916d692545b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: k46s33ep9usk5qojc6t6jjzmys4yr94g
X-MBO-RS-ID: a3b8fc51d9c26bf7390
X-Rspamd-Queue-Id: 4XcHWl5Sqcz9shl
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

On 10/28/24 1:25 AM, Weijie Gao wrote:
> Hi Daniel,
> 
> On Sat, 2024-10-26 at 20:23 +0100, Daniel Golle wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Hi!
>>
>> On Mon, Oct 21, 2024 at 08:56:42AM +0800, Weijie Gao wrote:
>>> It's observed that the bootmenu on a serial console sometimes
>>> incorrectly quitted with superfluous characters filled to command
>>> line input:
>>>
>>>>   *** U-Boot Boot Menu ***
>>>>
>>>>       1. Startup system (Default)
>>>>       2. Upgrade firmware
>>>>       3. Upgrade ATF BL2
>>>>       4. Upgrade ATF FIP
>>>>       5. Load image
>>>>       0. U-Boot console
>>>>
>>>>
>>>>   Press UP/DOWN to move, ENTER to select, ESC to quit
>>>> MT7988> [B
>>>
>>> Analysis shows it was caused by the wrong logic of bootmenu_loop:
>>>
>>> At first the bootmenu_loop received the first ESC char correctly.
>>>
>>> However, during the second call to bootmenu_loop, there's no data
>>> in the UART Rx FIFO. Due to the low baudrate, the second char of
>>> the down array key sequence hasn't be fully received.
>>>
>>> But bootmenu_loop just did a mdelay(10), and then treated it as a
>>> single ESC key press event. It didn't even try tstc() again after
>>> the 10ms timeout.
>>>
>>> This patch fixes this issue by letting bootmenu_loop check tstc()
>>> twice.
>>
>> The patch helps to fix the problem when dealing with single key
>> presses. However, apparently this is not enough to fix the issue in
>> all situations. I still manage to drop into U-Boot console with an
>> extra '[A' when simply holding down the arrow-up key for a while.
>>
> 
> Holding down the arrow-up key for a while can cause the PC to send
> large amounts of data to the UART Rx FIFO. Since filogic UARTs usually
> have only 32 bytes FIFO, it's very easy to cause Rx FIFO overflow,
> and then you'll still be dropped into U-Boot console due to data loss.
> I've already confirmed this during solving this issue and this can only
> be solved by increasing the baudrate.
Does CONFIG_SERIAL_RX_BUFFER help with those overflows ?
