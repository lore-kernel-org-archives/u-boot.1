Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B2FC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5021B86A19;
	Tue, 15 Aug 2023 00:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HsEADt6A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NQLUpt+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E31869F9; Tue, 15 Aug 2023 00:46:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC251869E3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RPqHr2JZcz9sRV;
 Tue, 15 Aug 2023 00:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692053160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VztaJFpo2HAHDT14g1VHP80sekpvej9EniRcz8JL/Bw=;
 b=HsEADt6A0XmIO/s7eizc8C0XRNXtXImYVWlb065rF/z0sZXBaXuX/sOxJ7ueg/7R34a/Am
 FYRPaX6PcLi2cQQP/gMymsVDXEDJnMUTlnQe7YfF3sInD942bpYS1lDgZcQHWEvphOcmww
 VBptthTTH2uMzuo5N6E96uVuaBnRW9qwlMSnfu8dnCVJEW1xi6QlVu7RUhWfAc5tlY4EjL
 Ig2Sc7sBYMMz82N/i7UvnPvXboBsJFsEGgkJzxINUL2qQbmHcooaFcbS0Vz9oquCkAVT2+
 CNI6uqH9ao+Kl0sto7eneq4Pvc1M9eKjIkFrF4bwX91S7r7/bDTOeBbUhCmpyg==
Message-ID: <85390ee0-acf3-8e39-1074-250e07bf5e5f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692053158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VztaJFpo2HAHDT14g1VHP80sekpvej9EniRcz8JL/Bw=;
 b=NQLUpt+cX++fnPCe+T5BhGbwinQIZRWyqKFuXy3SY+iYWzuPAbrR3jg4gku3DNUQQcHCl1
 QKrH6YzdULjKkJUAQq4Nlg+DrpZEmtE/WIbOPex6FXWxqJ0D5jm98QiaHZTKNF+HpWFDcG
 TySg8jCbrkCdGNo2vUQHpIM5o/8QTTbiSgFOK4BeenIjgaKpWMPdoNg4YCVbC/tPxOzQL4
 ztuuu/kFekS+1RfHJU+ak86y8PP2DvQIBmL75oUOyTgxG/MSJ3co2/NTk0+fSvdweTotFi
 0JEjnGDnVF6916zA/LgSzVN4l9kCd2+JMa1Rc5dkx+2AfLkKiIYCSM2v8yuXNg==
Date: Tue, 15 Aug 2023 00:45:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] configs: sandbox: test: dm: blk: Enable NVMXIP QSPI
 and update test
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20230813214659.441964-1-marek.vasut+renesas@mailbox.org>
 <20230813214659.441964-2-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ0rCX+hUn2rtH-gpVB9X+Rfv-FTGoxGsB8tKa0e_QEBGA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPnjgZ0rCX+hUn2rtH-gpVB9X+Rfv-FTGoxGsB8tKa0e_QEBGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f2f9021851f5184ea88
X-MBO-RS-META: ipogd1ac1abf5jdj5g5zutgkxh4mijbm
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

On 8/15/23 00:42, Simon Glass wrote:
> On Sun, 13 Aug 2023 at 15:47, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Enable NVMXIP QSPI driver on sandbox, since it is already enabled
>> on sandbox64. Update blk tests to match.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> ---
>>   configs/sandbox_defconfig |  1 +
>>   test/dm/blk.c             | 63 +++++++++++++++++++++++++++++++--------
>>   2 files changed, 52 insertions(+), 12 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

NAK, this one has to wait. All of this NVMXIP stuff needs closer look, I 
think it is really weirdly broken and doesn't even pass sandbox and 
sandbox64 tests. Can Abdellatif try and check whether ALL sandbox and 
sandbox64 tests pass with this enabled ?
