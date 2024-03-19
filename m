Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6418C54E58
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 00:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09F487F8B;
	Tue, 19 Mar 2024 01:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="olGMyp9r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gV1zpj5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCDC888044; Tue, 19 Mar 2024 01:24:15 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722AC8718A
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 01:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TzCC12FCsz9sZS;
 Tue, 19 Mar 2024 01:24:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710807853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLkunIuO05uXIpaj1EyIARhbJbKCELKiZdV/4VJKJjY=;
 b=olGMyp9rQE4drvSFEEIMU2cSUAynSNyUk0fns1sqq4NDb2+S5THqETeLdlmjeMZVvwKVTB
 Hyz5S2p19GkNPHviYLs0exBox7xckQ+PGJapnvhUvwr6PA7gdWm8RWc0qHMXasdL2jIVK3
 Asxr/d9N0qBbriJVzYHP/IKYIy5r1D1tMkpqoOKTxxdQeYyWJRUW/5vSMxXo996fjOs6lD
 qCo+eZnt52xEM8nJw/KDBXbbGv6En8vUiGmlKL5BzINQRG3KKQpcAOh1R4yEg+6jdPsMcB
 Aab2kBbksSa6sWhpWjWGgHtmrZNL3q0i5ivJz7t4iGjABKOzScXD2F+YUse9hw==
Message-ID: <a060d545-6e58-4bb2-a5ed-bfad96c6c789@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710807851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLkunIuO05uXIpaj1EyIARhbJbKCELKiZdV/4VJKJjY=;
 b=gV1zpj5kNYP3UBt6VoU7VP24NcDt9iQ6uJ0TI8TPj0Bymhz3lwqZ9EHay9df4iHONiGuKk
 eq0CulcPjJYaFbAPMzwl1/Z88b73XlY2JA49QB/uL6n4jd+T1Qxqwrk3IweDjfMq6HCbRQ
 SnbkYdysAJ8GDTq0v/r6og3YQuhyS4qwm2miUw+ZRj3fTMN3IqIgn467Xi4Dc8rNXntRmA
 GslLHCYY+TJAXBR6iARweY4/OAMALh9kbFbXsHzK09k9WmGxdXLmHZ0YkvNXJtpNGu2PWt
 0LpYLc57GOKEqQ65B4TWOUvKxWWp3l12lndXXFNnkKxHX+KNro6dD4/8JKWOcA==
Date: Tue, 19 Mar 2024 01:24:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ARM: dts: renesas: Switch to using upstream DT on
 64bit Renesas SoCs
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240318145958.8099-1-marek.vasut+renesas@mailbox.org>
 <20240318145958.8099-2-marek.vasut+renesas@mailbox.org>
 <6071517a-6c6d-41f3-895b-29abcfea78a3@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6071517a-6c6d-41f3-895b-29abcfea78a3@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2be70cd1e108f004425
X-MBO-RS-META: wormc6tfm8sb3serqom5ugs8mfcc4c71
X-Rspamd-Queue-Id: 4TzCC12FCsz9sZS
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

On 3/18/24 7:15 PM, Paul Barker wrote:
> On 18/03/2024 14:59, Marek Vasut wrote:
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
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>      (for RZ/G2L only)
> 
> Do we also plan to drop the corresponding .dts & .dtsi files from
> arch/arm/dts?

Yes, once I'm done switching everything, I will drop them in bulk.

-- 
Best regards,
Marek Vasut

