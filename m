Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7399BD12D53
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 20:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6328918D;
	Sun, 10 Nov 2024 21:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JzF5l9aD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TKwVKRij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7806789190; Sun, 10 Nov 2024 21:56:42 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0289789185
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 21:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XmlN75QsLz9v99;
 Sun, 10 Nov 2024 21:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731272199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8K+f0FXV2LUDODjbInYPgO16BWpj+oJvsiOejSxIYK4=;
 b=JzF5l9aDNgKqYUD6p3wvje715YyCt+ylZALAjhg9GXRg8iqFLQOiVdAYJc365U8AEQ/J1G
 MmhrmyR1ukbOtSMg3nCVkQ3m7HUy0RI6oM92x0aGtTK+tzPSUtp841Ul359LhV4ojQlFDC
 OYuWLXrz3T3BrhlgtXt3mX3d+1Z7GTyGu+ylmj21XN5voXSVFkVt67uLh5Wvs7sXbSvqPB
 BbDj4mVNyNbOjK/mPEFnVHEnSKAnnHHnWDSoWZodklklZe7FO+4ot1dL4YqpicW0FiMuyI
 ebBnMRnxtZElJT/ZpeOa3ADDRg2x4LITFy6AvEl3ZUMi7R+b3ZUzf06J0KZhmw==
Message-ID: <cdcdb1fa-e0f5-4623-b26f-a47d4b462710@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731272197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8K+f0FXV2LUDODjbInYPgO16BWpj+oJvsiOejSxIYK4=;
 b=TKwVKRijnQxel3knIUOAm9MRcTwzipfFqElinix9OAwdCrz/m0PCbANTmFL62686HS1+PE
 2d74V0ggHZTlmbXhpOpMyQTfdHM3dWMHH1C6DpJfVXhKWQlX5XLNcQP7VQcbfvmP0ZUX5a
 t6pPlxU1+5w34+YTFWdAdfAevi9E1QTzdCErGPpHzxU2iO2ksY4k1KvweDY8dQbHsFVCjW
 FZraWhxkKWiyxCAl1rIgAuekYuZLPNcj0TKvYBO5NawqKp0+lqMg667N9R7r4c+xdynrb4
 eKfTR+rG7QFoyD7eDQHyKl+Hs+OaT+FDgrIYi9wZhh3D+MIwvvDVpC2l1BQGEA==
Date: Sun, 10 Nov 2024 19:33:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 04/14] pinctrl: rzg2l: Drop unnecessary scope
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-5-paul.barker.ct@bp.renesas.com>
 <d88f090e-90cf-4b3d-9aa5-f9b211e74bfe@mailbox.org>
 <87259717-60fe-447d-8f1d-5c71f2e276be@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87259717-60fe-447d-8f1d-5c71f2e276be@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c68a694b02c884f90dc
X-MBO-RS-META: wtbrsaozwk7f7e358hi39drd6cc8jjum
X-Rspamd-Queue-Id: 4XmlN75QsLz9v99
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

On 10/28/24 9:27 AM, Paul Barker wrote:
> On 27/10/2024 16:16, Marek Vasut wrote:
>> On 10/24/24 5:24 PM, Paul Barker wrote:
>>> In rzg2l_pinconf_set(), there are no new variables defined in the case
>>> statement for PIN_CONFIG_INPUT_ENABLE so no additional scope is needed.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> btw. it might make sense to split the series per subsystem so it can go
>> in piece by piece.
> 
> I could split this into clk (patch 1), pinctrl (patch 2-4), Ethernet phy
> (patch 5-8) and ravb prep patches (9-10), sent as independent series.

Yes please.

> The support for RZ/G2L Ethernet (patches 11 & 12) would have to wait
> until all those series are merged. The devicetree changes (patches 13 &
> 14) could be sent once the pinctrl patches are merged.

Or just include a patchwork links to the dependencies.

> I think that this would delay things and prevent RZ/G2L Ethernet support
> from landing in v2024.01, so I sent this as one series. I can break it
> up if needed though. Let me know what you would prefer.

Please break it up, I'll try to pick it into 2025.01 still.
It is easier to pick it in more manageable chunks.

-- 
Best regards,
Marek Vasut
