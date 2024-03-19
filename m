Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76743C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 00:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7FD87EE0;
	Tue, 19 Mar 2024 01:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FkjfE3nw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jfP4KPRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC2B87EE0; Tue, 19 Mar 2024 01:27:02 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61B8788020
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 01:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TzCGC5d0Hz9scY;
 Tue, 19 Mar 2024 01:26:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710808019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4u4I/oeTipEavlgsvVAVQOU9YGo36LFhhRl/duMsUUE=;
 b=FkjfE3nw9qE7TO5V6fTlyIiaDTOpdvY3X5vGidEkc7B2sANP/B8nfpB4Ko7YfdjW8njeo9
 cgB1t3ByPacfGUGsqHqVVR0Xj0Sck8cPkOgF3I+rlXYtWqaQxhk77R4jruyMoHz5Sf2l9p
 srMt0q8Rah2W+oGKY1KvpcqKx1QrvBRSdN7NhnjrZfD7Ge0LmQgUDt1YDDIdSsp7ZYBsyA
 b8cZTFmfMG4qjan5KMMlT472/2uB5cfMJ1khX4vPGvU4G0uVOI00jUszTAXxRGdC3AhzL7
 e/iwl/vIFpoJqzCItB1qH27FxvQTZ7LODkoKdavfss5ggQo8dBZf5jpymDnRlw==
Message-ID: <2ed5917d-54e7-4ce9-b1bd-d55878de4471@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710808018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4u4I/oeTipEavlgsvVAVQOU9YGo36LFhhRl/duMsUUE=;
 b=jfP4KPRD+37IUB0U4cninZ2GJ8zLyJHD2xL7a+p4v0myV2Cxn2tnQ/tvKJ/xFDu1/hluRa
 TFQaCaelEnO7j3wpCTNCYdxmqH3kreraSPTytfCniNvJXGIyyrL3g7VgfmvlaSwx9FPCgp
 QRaD7PSFypADt1ueIlBee7P3sHiz5xh1tYtPzguNiSFtoE43K4nkkX6u0b1rFQNMS9jRt3
 EsmCqrfsIUX2E/0zajRVaUNp6dfYBYZQ7coKCuDe2pQTPe3V1eGe64KvoMM/ANZrjGsFLW
 6BODzCYoLr0gnF4tMLQHROsai5QUMFIxS78oLBQvipJWNsD/hBoqFNHBLV4KNw==
Date: Tue, 19 Mar 2024 01:26:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ARM: dts: renesas: Switch to using upstream DT on
 64bit Renesas SoCs
Content-Language: en-US
To: Adam Ford <aford173@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240318145958.8099-1-marek.vasut+renesas@mailbox.org>
 <20240318145958.8099-2-marek.vasut+renesas@mailbox.org>
 <CAHCN7x+b1XZKhQzOcLm9bj+sAbB_JVU8_c7MYxKb7CRKpPau4Q@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7x+b1XZKhQzOcLm9bj+sAbB_JVU8_c7MYxKb7CRKpPau4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: erzxipuiw6j19iyyowr9rphjct46qbyg
X-MBO-RS-ID: e579a717d7ca9a809dd
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

On 3/18/24 5:14 PM, Adam Ford wrote:
> On Mon, Mar 18, 2024 at 10:00 AM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
>> DEFAULT_DEVICE_TREE and OF_LIST. And thereby directly build DTB from
>> dts/upstream/src/ including *-u-boot.dtsi files from arch/$(ARCH)/dts/
>> directory.
>>
>> The configuration update has been done using the following script:
>> ```
>> sed -i '/^CONFIG_DEFAULT_DEVICE_TREE/ s@="@&renesas/@' `git grep -li renesas configs`
>> sed -i '/^CONFIG_OF_LIST/ s@r8a@renesas/&@g' `git grep -li renesas configs`
>> ```
>>
>> There are SoCs which are not included in this patch. The 32bit SoCs
>> require further infrastructure work. R8A779H0 is coming during the
>> next upstream DT synchronization cycle as it is not included in
>> current upstream DTs yet.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> LTGM!  Thanks for doing that.  I was going to do that after the April
> release was done, but you beat me to it.

Glad I could help. This will go into next release of course, i.e. 2024.07 .
