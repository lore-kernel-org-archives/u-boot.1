Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC81ACDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FE886B68;
	Sun, 15 Oct 2023 08:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Me4G+9NX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E1986E47; Sun, 15 Oct 2023 08:42:46 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74DA86F68
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b0dcbf3672so2111474b6e.1
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697352117; x=1697956917; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0XUgE0fj2gUC6mx0oCpXiSIOPuGkN6snCJqnAu76lZE=;
 b=Me4G+9NXv0E0uOra0uPgB01999ofu7jfQTcBzEcfQHa0QMKlcT/jhpmFu2KWI9Rvkz
 ZTvnMUjUB5JO7GpHS/2zACQLskaS1/JvvvEC/SQTLfdtGQENEQtOpsslpkIwVmWgik/R
 7xW9/Ym0OoNPMxMv2u7lHhtpjDJqpTL3WcAEFFM0/OUiePgZ3Mwk/tAK3k9xv1epd/rZ
 MWJvYzfTutj9pe2tMnypOyZ69Zxpe1AvG7ssNjTvqmYaL4bk72/1/go3gvpyhEJJC8MS
 lVILHSAjfqVXlActiTtw8molNap9033jYEt7B1iqXOU1folyk5gET6VgtUgwaR1dUjQK
 lbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352117; x=1697956917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0XUgE0fj2gUC6mx0oCpXiSIOPuGkN6snCJqnAu76lZE=;
 b=bvv88SDaEqSYRrVLm7F80aNMOuEYuXfOHaiKnmYzOXqwNCPqr+FRmiTXEPvyXz7y69
 zfZ04XBclNfkhvRQhPw8Zihbxo/1hMz64suI0zg9UD9X/ez9M7OEGnUDWmYIC1IXzOH2
 gp7GlHGV4fR4MCo2AzNAH7GxZgkcnGc5cDexr5u4Iz6NDnQFKFVhc0qi7op7BP9UwG6T
 hVdQCuY0bcVVC8FcAdcYR2TWCgnO2a3PJp5KZ6NG4PFpDw6IadV1RsbqhcbVWQhVGGjO
 jMCDYKqe9LSuFSLFRGDljfSba7rzfc0rvTY1eLahZjx2LioCyGXTcTgHm+YgiVHKKAz/
 o5TQ==
X-Gm-Message-State: AOJu0YyVTcx9ClLIItXmn6b5SHKtkFfggJ4SRrVCE/KyFgxDq1PcP2Xz
 RolaWTGOqfGVIVsOwxLtrRT08qUTv4gqGw==
X-Google-Smtp-Source: AGHT+IH/AraGmfqvX9IH2UQWmTE6CQvgliw/w42xXRZTtMdFzip5IyRWX0L4jCc3gjjzJftHKwCrlw==
X-Received: by 2002:a05:620a:4048:b0:775:cf5e:a66d with SMTP id
 i8-20020a05620a404800b00775cf5ea66dmr37035821qko.24.1697318876463; 
 Sat, 14 Oct 2023 14:27:56 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 c1-20020ae9e201000000b0076d25b11b62sm1754310qkc.38.2023.10.14.14.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 14:27:56 -0700 (PDT)
Message-ID: <f3fa804c-0c6b-f31d-6bd6-d5e3408a3861@gmail.com>
Date: Sat, 14 Oct 2023 17:27:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 17/29] net: bootp: Fall back to BOOTP from DHCP when
 unit testing
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-18-seanga2@gmail.com>
 <1365B46D-6CCA-4064-ABC1-97CF581564C7@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <1365B46D-6CCA-4064-ABC1-97CF581564C7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/14/23 17:22, Heinrich Schuchardt wrote:
> 
> 
> Am 14. Oktober 2023 22:47:53 MESZ schrieb Sean Anderson <seanga2@gmail.com>:
>> If we sent a DHCP packet and get a BOOTP response from the server, we
>> shouldn't try to send a DHCPREQUEST packet, since it won't be DHCPACKed.
>> Transition straight to BIND. This is only enabled for UNIT_TEST to avoid
>> bloat, since I suspect the number of BOOTP servers in the wild is
>> vanishingly small.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> (no changes since v1)
>>
>> net/bootp.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/net/bootp.c b/net/bootp.c
>> index 2053cce88c6..7b0f45e18a9 100644
>> --- a/net/bootp.c
>> +++ b/net/bootp.c
>> @@ -1073,6 +1073,11 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>> 			    CONFIG_SYS_BOOTFILE_PREFIX,
>> 			    strlen(CONFIG_SYS_BOOTFILE_PREFIX)) == 0) {
>> #endif	/* CONFIG_SYS_BOOTFILE_PREFIX */
>> +			if (CONFIG_IS_ENABLED(UNIT_TEST) &&
>> +			    dhcp_message_type((u8 *)bp->bp_vend) == -1) {
> 
> As written before, please, do not add unit test specific code paths.

While it is convenient for tests to implement a BOOTP server, there are
effectively no BOOTP servers in the wild. However, BOOTP is commonly enabled
in U-Boot. In an effort to avoid growing most U-Boots for testing purposes,
I enabled this path just for unit tests. That said, only 6 boards enable SPL_ETH,
so maybe it is not too bad.

--Sean
