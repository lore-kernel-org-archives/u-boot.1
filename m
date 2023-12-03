Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96687C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 20:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068D787575;
	Sun,  3 Dec 2023 21:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="koMYsQIP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PLJany9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305D68770C; Sun,  3 Dec 2023 21:44:13 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB35087538
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 21:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SjzL22jdSz9spj;
 Sun,  3 Dec 2023 21:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701636250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kW3I9u+CvclnSloDrNXvnqr0FdoSMYpizag83xOvUO4=;
 b=koMYsQIPyBCUgp0bnaCT51Fh1KcKkDx64mRuHPoVqAyLPI6Nknyl/hWk75tMfwL23j/nXh
 xCcvkAALAELOZr1rLsk0BNOVWs8q/HPYWL6YyvLD4adtCi89EdEPEBDc6sJIBVPsMDIAoB
 s+siQNQzpeSupyCADz4g3u+sxFVRZ3eCzBx9Vjf5e1ki9JkNRJuEuegtM2XWeUSbASELU6
 c1JoO85VbuGBH93DioH9Pkp0oF31PNsT1YygNfUjiuqcu5AzuoX/uusfX0DnI8v+wcrASp
 ykmurpPKAv8mUNP8T4L+4q1IjcJIzNDjB7mVNvE/7NH9pAC0aDO9st5cX42uyA==
Message-ID: <cfd0c67c-adfd-4dae-9341-1ce0ed3f70d0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701636248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kW3I9u+CvclnSloDrNXvnqr0FdoSMYpizag83xOvUO4=;
 b=PLJany9gnLjPG2uzw1bnuwYchJa3fbgBTACCnA0jBzJx6s4KOTg4rYtc1us81q9C+NHaTB
 Ixrcob+78Eb7KhlpVILz/HLqftTF/n5wY+wvRB/SKE40qN4R2CfjZqVJ+CufhKDd2u/bUB
 OqSB9lUtDof3GRIDugrRBwPEdMUKEWhqqsVcdV0kVGeB8N/lJMNlpbozPWu91SxyfmfYmI
 2ziY5OEyvTxI2sOKbxyaNMPa6E9MNWkDnIS71paG6ZS1JMswEvbt9tfJ2YbBQHy3YiI/rJ
 zJhKwyLiZXjBlssdn2rZsfNFaPtFhutHCW9sbb5/6QwI2n3hUb6mg4AGb/rNNA==
Date: Sun, 3 Dec 2023 21:44:07 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] command: Allocate history buffer using calloc()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
References: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ0zNGCiPUaEZ3NTdebm8a9uApBWasZa+=WHewpSVWcVuw@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPnjgZ0zNGCiPUaEZ3NTdebm8a9uApBWasZa+=WHewpSVWcVuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 066cc24e3a167a9dc73
X-MBO-RS-META: dwdserd4zt3esi6wg8ac93i4wnqgmhed
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

On 12/3/23 18:44, Simon Glass wrote:
> Hi Marek,
> 
> On Sat, 2 Dec 2023 at 13:53, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> The history buffer is currently a static array which can be some
>> 10-40 kiB depending on configuration, and so adds considerably to
>> the U-Boot binary size. Allocate it dynamically instead to reduce
>> the U-Boot binary size.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Simon Glass <sjg@chromium.org>
>> ---
>>   common/cli_readline.c | 26 +++++++++++++++++---------
>>   1 file changed, 17 insertions(+), 9 deletions(-)
> 
> This is very intriguing...
> 
> I would expect this to end up in BSS, so not part of the image, but
> allocated when U-Boot starts.
> 
> What do you mean by U-Boot binary size? Which architecture is this?

ARM64 , I spotted it at rcar3_salvator-x_defconfig but it has been a 
while since I created those patches , they were on hold for a while .
