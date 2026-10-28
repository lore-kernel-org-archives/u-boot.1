Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC45606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JhALhXX+;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=U523XsOs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 511C960665;
	Wed, 28 Oct 2026 12:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iWRGfI50QF8; Wed, 28 Oct 2026 12:41:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3ABEE605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793191279;
	b=KJWgwNNMJvixZtehe+RDTghRJLGS6JWJc826FSzGo2EyYkLuEF7s0Vulya29dly01u6w
	 DvlpqRaasiuuz2ibDReda3ZOp/s9ZZVv2QMa604frUjGu5XNSybRmp+ts1KlZ7F8d1+Sn
	 IhsESTAjnNeV3iKbv6Z62Lf2jFJeOeut8pYkTEYbOyqIlao/XWkdAY7c1cbMfpcWJvFYC
	 Q+p7edwqig/Mb3VzaCNskQXBz5MrdNrttvCObrAnvYbylUUgmYAS4RNakfEd7sNrJuB1i
	 l/xYxeELpV7xsHv/TkZDt6hU7if9rUok6dtJYliJdta17zKBtOawhQvdzioWH6NeoFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793191279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lDG9nTLL2mxKF+XBfGapTzKQ0IAOOWcAgzQlY4wlJMw=;
	b=sq0DMmD0ESww5REe8PoA8cJHq7s48cdBOiEnktX45Mp23JGvYCZ0RNp8RlsIBIWhvJkF
	 TINwsb9OLFzMDnrokGXlqpSg/aWY1YjirL+9NrjeqhhoBz+lhZ0wEdDqQol27bqfzpxK+
	 wJfDCtDFWxt+MTwAUosZI8T/85vZaagZ+sP9ZDWwj9LACHaulP+kWgrKoczrKNmWGeUK/
	 VYfjYbFMIQPsvzUxP/82kjrlXxETgSrUekLIaWisRYglIv0qhcvBepDPCmM7AC8jWj278
	 UVfnVS+nYkpUVUXhtBrqDEz8WelDGBLrx4/PLQzMOuolQFIVLCGk5IuORfrgW4pdFeg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793191279;
	bh=lDG9nTLL2mxKF+XBfGapTzKQ0IAOOWcAgzQlY4wlJMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JhALhXX+1texWC5wpEmvd6KheVtm+sXxreWZguKXXxeK1blWOY15WW/WIVr43xutx
	 WCyRe0GxMtkZgAbz/uVCH6rTBwl53tq8XlK1+ozwtuvsDVceh9Ene2KKYzOzcrgEPh
	 Ds9iW4fRaRxTnCeKzf+r6dmhJXQjej0KnJC72hW6CGtYbdFp+UIk9k30MBAYg9CjMq
	 9N1dv+gTDsWy6f4HWVJu/QHWxOwJqrssua3lAtmImHlU7F3U24U47vsXFZk0ihRYmQ
	 Nb4SD5UtHYP/QUwU+D7pPKGkbO1hPpgAREZYNBXe5ooBzy0N4J6o9AtB6TKBp3TFOp
	 MhM1W8AB+h6Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ABEE605F1;
	Wed, 28 Oct 2026 12:41:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EB272AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 800C54069C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JCRy6BxjMeiB for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:41:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BFED40635
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:fff0::42af"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793191277;
 b=YUk4cuoeZnmmVXc3ARvZcuTZqnFwl+odktYfdak7RZRb+kG0cotaJlVdpQF8RSt3W6rA
 LU/8YkZgZjdsrROjzQmlnGqEBrK7G0mJYUa3TuOYOmAMAgaSXp6GbHb6DSq2spmNlu2HL
 FtpCrSDK03TDKw31W6YGIC3/W+gijWYyBpHrlIs0LKnIBRgz2+Ty1QFBOqbDRV8BfU1WS
 Ci0YgESWH6WB3gcLcyei44xec8bEGnTSBdHa3uv1pdzjzhyHJQwT3MbRkIwZAezeChJNZ
 VZj+NT8JzrAWB0q2AlFQ3qH4a6epYuvcTGd3J1jdagZXYDvfMoHz4UaKWmvuPnvreDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793191277;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=lDG9nTLL2mxKF+XBfGapTzKQ0IAOOWcAgzQlY4wlJMw=;
 b=dvxMpnfcPGNyNM78mSoV+7D1NQSFd1zdLhZO44opAwdMjgcPyZOtMu8JEv0KLjkoL69n
 zwh+7C37k5CCF0uDvzaFewf0qLtHho+0S66wwv8bmqXLiXg5hmlzRJVJV0ILUOJjqjus2
 UQbOiq8oyhWzOHDPBLlfjTeTOaUSPEG2On3RLN3y6fkd/ryrFFZ6blxNIWzFeEtiJ33wq
 KdAEMUQvo6EkHyNsRrRDNe6kKhTpz2gRI6cyr0EuIWLbkG0wsHDZB/9gGLeDamC0DsMT+
 C85vxJ2HBQ8vpNciHLXhqvEiyW5PyPkMxnf0LkU5xxPfr2AQH064eB/IFGJ1+GXXz/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=U523XsOs; 
 arc=none smtp.remote-ip="2001:1600:19:fff0::42af"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::42af; helo=smtp-42af.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=U523XsOs
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::42af])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BFED40635
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:41:15 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jF6RX4nTwz1nQ2;
 Wed, 28 Oct 2026 13:41:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793191272;
 bh=lDG9nTLL2mxKF+XBfGapTzKQ0IAOOWcAgzQlY4wlJMw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U523XsOskcrIQraS5dD0K9SsXUl+ZlxVqmYm7wwusrp4oeNL64SmOnLn6fbqjG2QT
 S2VKLNNrOivabKni/p5hg66Nhi864Lj7wz2keM2dpgj7ICmu/l0k3sJzPNKYzYeBPR
 /CXhg9M07swHObXs+5ScO+WjttQHtj4Enqb2qKpPWIK8LMYlFJcutQqZIrvDsTqf59
 MHWlT1I7rzFgSHvZ2GA9cdWjXCxNu3FNKlHmtX/U6I3QbLoixJhr3LK3FJIZrMvUyc
 I61s6N5ANityjcmLKNoQiCNtZ3BorHh48lg7AKYThf4c10qsDo8EJMIwgeH1RmXdWS
 t1DKM6PzDQdSQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jF6RV4fkVz58Y; Wed, 28 Oct 2026 13:41:10 +0100 (CET)
Message-ID: <16574e5d-6d1f-4419-8519-b1cc356797a3@0leil.net>
Date: Wed, 28 Oct 2026 13:41:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks
 when PCI is enabled
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261015224222.1582607-1-jonas@kwiboo.se>
 <20261015224222.1582607-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261015224222.1582607-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/16/26 12:42 AM, Jonas Karlman wrote:
> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
> gated coming out from system reset. The probe() ops of the PMUCRU driver

Are they? I don't have an RK3568 board so cannot test this, but the TRM 
says the bitfields are 0 at reset with "When high, disable clock", so I 
am not sure what exactly this is for (except after a reboot where the 
Linux kernel has disabled the PCIe clocks maybe?).

> unconditionally ungate these clocks to help ensure PCIe works in U-Boot
> proper.
> 
> Change to only ungate these clocks when the PCI Kconfig option is
> enabled for current boot phase to delay the ungate as late as possible.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v3:
> - New optional patch to help delay the ungate of PCIe ref clocks until
>    U-Boot proper
> 
> This patch is strictly not needed, however it seems very unnecessary to
> ungate PCIe ref clocks in SPL when PCIe typically only is used in proper.
> 

Considering the kernel seems (I had a cursory look) to be able to 
control those clocks and have them handled via the pcie node, it seems 
fine to me to possibly not have the clock enabled by U-Boot (e.g. with 
U-Boot proper or xPL not enabling PCI).

So, I'm fine with the content of the patch, not the commit log. Can you 
please confirm that they are indeed not at 0 when reset (and/or that we 
do this to be safe when doing reboots) and rework the commit log?

If you want, I can merge patches 2-5 from this series for 2027.01 and we 
can defer patch 1 here to 2027.04 if you don't have time to send a v4 in 
the next couple of days.

Cheers,
Quentin
