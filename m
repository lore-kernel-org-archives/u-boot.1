Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94974C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9835587447;
	Tue,  5 Dec 2023 14:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qg8FR5WY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C448D8753E; Tue,  5 Dec 2023 14:16:14 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94143871AD
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a00c200782dso773141066b.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701782172; x=1702386972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wmd0nOTWruV8F9ixR8SgQp7dPWfsrSOux4rOORoG7OQ=;
 b=Qg8FR5WY2LMtFeRoI9GO+Eb/9977XdSFpNgQFjKYcoFcrTqhKKc0GPsg31QI+j3vst
 Peq8ytF8M/rn8D7t5UD2wsFTfjICHM4wMIX98QWeMW4YTlNoGrsF8p2Zjd+ZHMRSe/cB
 sDDtkpesRgFP7zt2ukNgC3edeJJK4ne6A6K4z0KUtObumqSTKsc8Cpdjye1WBODrfLzk
 VSefnkeyYspMdS2gT+tVUDNANW4wuMeNSnJKVYgHb82buNWPmKx4mUTxvxX1mAuZgxi3
 t5MMftb57fUF2GdP0G3QUHp7Utom3I/baBAvgQCA2N5C9LZD6d3bPnTeca4m2h+caVZ9
 Cjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701782172; x=1702386972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wmd0nOTWruV8F9ixR8SgQp7dPWfsrSOux4rOORoG7OQ=;
 b=XcQm+Zst3GZ6YJimEGBJeV8nrIR86uaBMnFuEoy2M/aNVUHJYaVVOU+CTNpKIHkiaq
 pMtRmmQAiB0c0WuHqPTp8WjnDeVTTSn5JZNFLX5jO5VLpYg2rL/R1ky7jQb3jspuLds1
 +OQbZTDMUFxLY+5IAJMPa9EY73bErlI33ebAHjUWVx0qtGEoO2tTwynv1A2J8K8yyozu
 PFHL6H25i+7dsqrmSE0HBgVWqAHF8B6CQmxMf0RZ7sMN69om7B/MLtaVV5TiZ4O3YogA
 8iO6jbrlgw5KiN+C+zAoqfcXl1oXRuO6EnfLzAqh3xP8uuPtJLlj2b59pyjBD138Hpry
 0gBA==
X-Gm-Message-State: AOJu0Yw2kaYruB/cXskvDxeLhsxHHyYMUb+uqV/R0ncznSijnWnVMzzt
 4aGSS+a8eKJ3Qm0G+/RxWtp84/J8i+bpZyeChX0IrQ==
X-Google-Smtp-Source: AGHT+IGImWcp1WD7nMu4Patmec0bJuKkQKh75PF++YGJQ2Z4XoXy6sG63IKPi3YjJTihleaZzc9qHu9tCGiG7H8I+Uk=
X-Received: by 2002:a17:907:2950:b0:a19:d40a:d217 with SMTP id
 et16-20020a170907295000b00a19d40ad217mr1556292ejc.227.1701782172060; Tue, 05
 Dec 2023 05:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
 <20231127131129.GD2513409@bill-the-cat>
 <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
 <CAD8XO3aVLzpqV=MDVO2mJBP=sLzSieXhrV8GUPYPpu76mRKjeQ@mail.gmail.com>
In-Reply-To: <CAD8XO3aVLzpqV=MDVO2mJBP=sLzSieXhrV8GUPYPpu76mRKjeQ@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 5 Dec 2023 19:15:59 +0600
Message-ID: <CAD8XO3Y4_=8wDQcFNJW1MT1yiyDmbQxP3UCRWWWPZzuJkZp88g@mail.gmail.com>
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
To: Soeren Moch <smoch@web.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I think I solved the size issue on all the boards.

Key changes:
1. remove compilation of original ping.c and tftp.c (tftp had also server
code, so I will partially bring it back.)
2. LTO=y
3. CONFIG_LOGLEVEL=3 instead of 4.
4. CONFIG_CMD_DATE is not set
5. CONFIG_CMD_LICENSE is not set
6. CONFIG_CMD_PING (if 1-6 did not help).

And these changes were enough for CI tagrets to build.
I also tested that Raspberry PI 4B works fine (dhcp, ping). Looking for
other boards to test.

For example for this tbs2910 board changes are:

--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MEMTEST_END=0x2f400000
 CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=392192
+CONFIG_TIMESTAMP=y (this was added by savedefconfig)
 # CONFIG_BOOTSTD is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_BOOTDELAY=3
@@ -26,6 +27,7 @@ CONFIG_BOOTCOMMAND="mmc rescan; if run bootcmd_up1; then
run bootcmd_up2; else r
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="echo PCI:; pci enum; pci 1; usb start"
 CONFIG_DEFAULT_FDT_FILE="imx6q-tbs2910.dtb"
+CONFIG_LOGLEVEL=3
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Matrix U-Boot> "
@@ -52,7 +54,7 @@ CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_TIME=y
+# CONFIG_CMD_DATE is not set
 CONFIG_CMD_SYSBOOT=y
 # CONFIG_CMD_VIDCONSOLE is not set
 CONFIG_CMD_EXT2=y

BR,
Maxim.


On Tue, 28 Nov 2023 at 13:09, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:

>
>
> On Tue, 28 Nov 2023 at 03:20, Soeren Moch <smoch@web.de> wrote:
>
>> On 27.11.23 14:11, Tom Rini wrote:
>> > On Mon, Nov 27, 2023 at 06:57:09PM +0600, Maxim Uvarov wrote:
>> >
>> >> Increase allowed binary size to fit lwip code.
>> >>
>> >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> >> ---
>> >>   configs/tbs2910_defconfig | 2 +-
>> >>   1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
>> >> index 8fbe84f1d2..ce40efa9ab 100644
>> >> --- a/configs/tbs2910_defconfig
>> >> +++ b/configs/tbs2910_defconfig
>> >> @@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=0x10000000
>> >>   CONFIG_SYS_MEMTEST_END=0x2f400000
>> >>   CONFIG_LTO=y
>> >>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
>> >> -CONFIG_BOARD_SIZE_LIMIT=392192
>> >> +CONFIG_BOARD_SIZE_LIMIT=417792
>> >>   # CONFIG_BOOTSTD is not set
>> >>   CONFIG_SUPPORT_RAW_INITRD=y
>> >>   CONFIG_BOOTDELAY=3
>> > This is another case where the binary size is a fairly hard limit. You
>> > forgot to cc the board maintainer here (and I assume the rest of the
>> > series too) for these config changes.
>> ThanksTom for sending a notification to me.
>>
>> Yes, the CONFIG_BOARD_SIZE_LIMIT is a hard limit and this patch in its
>> current form will break tbs2910 support and even brick the board for
>> some configurations. So NAK for this patch.
>> > I think on this platform it's not
>> > impossible (like it is on am335x where I just replied) but really
>> > difficult. I'll let Soeren comment on if switching the network stack to
>> > lwip is the kind of feature enhancement that warrants the pain of
>> > dealing with the size change here or not.
>> Network boot is no important feature for this board and not used in
>> the default boot configuration. But network support always was part
>> of the config, may be used by some users, and is at least required
>> to communicate the ethernet address to linux.
>>
>> So I'm not interested in a new network stack for this board, but
>> also cannot disable network support completely. This seems to be a
>> problem for this patch series, since networking support implies LWIP
>> now.
>>
>>
> Thanks Soeren for the explanation. Then yes, something more advanced is
> needed
> to be done here.
>
>
>
>> The question for me is, why is the new network stack consuming so
>> much space, with only a few enabled commands? Is the whole library
>> linked in with some unused features (the cover letter mentions much
>> more than what seems to be used in the converted commands). Or is
>> the old network stack linked in in parallel to the new one? Can
>> we save space here?
>>
>
> Yes, the old code is still there. I decided to not touch it for the first
> integration (arp.o, bootp.o, ping.o and
> mostly all from net/Makefile).  Those files also have reference code in
> net/net.c. Not compiling
> and not linking this code will save some space, but It's larger than the
> current version.
> Like for EVM SPL code with usb+net+ext4 and etc have very minimal space
> for network stack.
> I will take a look at this more closely...
>
>
>>
>> NFS support in the old networking code is quite big, enabled by default,
>> and probably still there in parallel to this new lwip library. If there
>> is really no other option to save space, and lwip in general is agreed
>> to be the way forward for U-Boot, and only tbs2910 is blocking that,
>> then from my point of view disabling NFS for tbs2910 could be a way
>> to stay within the size limit.
>>
>> ok. I think that by default we need something very minimal (dhcp, tftp),
> probably ping is even not needed.
>
>
>
>> Regards,
>> Soeren
>>
>>
