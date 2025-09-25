Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0511CAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0F7809A5;
	Thu, 25 Sep 2025 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oz6faLsj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kIVJHQNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325DA82ADA; Thu, 25 Sep 2025 16:14:00 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59B9380107
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cXbLG0KSrz9sTZ;
 Thu, 25 Sep 2025 16:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758809638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0QOIEE4yV6TEoB7XQBKI/gvpwAtyrGt9h71QhHQVGE=;
 b=oz6faLsj97QkBjo5Z787H5R3AYU1KNugfGtES0t0zAoPr7fOhy1SN3m5RvyS9fyTSME+FC
 TAeJtI/weaZ+j5gwGtyHDNBbT6bmlqLX+W3c3a8iVPv4/zxmI5zYS7Vh1aMO/Qa6BI9JqF
 2RQUxkY9TP6aoeYWPydiDQqlXw6yKmtY0+UA9D1IfJQreHV8y/up9X7Dke0CLtrDmgm96f
 WCvtQ2Ktp8ev/YUS8v5ncf6ojoJv6go96NcJCcMnfKHXydtrUlE8tR9ZvgBp5o6InO9YtU
 J1vayNxyzSe8PQ1+s7axahiYglAC4EdH1fx0lguZHNphLjrkZQnU9tBcpxoAHw==
Message-ID: <7fdf6e61-0b05-4ee3-96bd-abf9aa7ed737@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758809635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0QOIEE4yV6TEoB7XQBKI/gvpwAtyrGt9h71QhHQVGE=;
 b=kIVJHQNG9d1R1iGTaxJG3xjdaf84zrmHltst15njMY6aJn2i8teh9pQeZRibLSD/Pas1to
 vpma0CvCMPYpXynOwfICjJeJGNg9noSW8eKJXvyEElVTL5gE1K4i1IeGmgI+QDd9w4WNCk
 IX8ONAKsdLjuOHrqWHOFBwZ3Gn9DrTR2l4C3pRVqnJ6ESv/ZD03uBDBkiLZ0a20MHChelB
 U/yYTrQV9YCDRx2ItEaghZFfMPJ6SbR5DqVGDIGEZODNLB4kdvJs+QhoAEietR0t7BTpmv
 TXWR82TdgpqPFYXhPNrQwoG3Iy2bmyPipUWRF43TIzT7KUNKBnj0O54haS674w==
Date: Thu, 25 Sep 2025 16:13:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "tools: mkimage: detect overlapping load regions
 in FIT configurations"
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Carlos_L=C3=B3pez?=
 <carlos.lopezr4096@gmail.com>, Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
References: <20250925134212.59709-1-marek.vasut+renesas@mailbox.org>
 <20250925140802.GL197373@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250925140802.GL197373@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9f1eygcmoxo3fidpwdbsubhcpsx9u8z1
X-MBO-RS-ID: 14ba0e5599d380e0651
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

On 9/25/25 4:08 PM, Tom Rini wrote:
> On Thu, Sep 25, 2025 at 03:41:43PM +0200, Marek Vasut wrote:
> 
>> This reverts commit 588094f2c8ec9a4f7d2dcda11ffae8db8462149c.
>>
>> This introduces warnings on valid fitImages which do not set load
>> address for fdt-1 DT node. This is valid, because DT can be loaded
>> to suitable location as determined by the fitImage loader.
>>
>> Warning: not able to get `load` of node 'fdt-1'
>>
>> Furthermore, do not add C++ style comments into C code.
>>
>> Either send a fix or apply this revert.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Sorry you hit this during the window before I reverted the series.
Just keeping my bootloader up to date ... :)
