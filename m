Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89D3E7AD4C
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D5A87253;
	Tue,  3 Oct 2023 15:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u5kiEk93";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mg6/gUxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8A586E28; Tue,  3 Oct 2023 15:40:45 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1EB86E26
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0Jqb0Wk2z9sqM;
 Tue,  3 Oct 2023 15:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+UOzWJv7HSBaqDRMfQxCmHzYEZahQSR2TDN4ZrZq4Y=;
 b=u5kiEk93+6vMvlbx2k+T1apyk7ypAjKWNXwTwnqDERvhUkn/YkGTrcXG5ueuD5A4bUhxUM
 EYlx56mjiXpZw2bw6EmHOvyKEhFjZ557AnSC+tAdAPrZzLdnUHnnvGR+NOpexxmaTYNARj
 Pwzw0rdwy5Uo8C0OrBpN30w5u+ZEVOmQci7D3QaT0xgAr/e9uZp99ljDMOc8b6yDvZQrgA
 8HpJxUg6YdVDueNJeGalDDxe5Jpp+h2/o2e7WzpWSB2T/i+d38EmK4m3LhOUSIMohLxBAM
 6P/1V795KL3zOd5KRq65pMtbxQZazrVT7sXn8Pw38dryxdt0xXbbCrDtMdRwhA==
Message-ID: <f4f89fc4-d797-55a3-b76e-8dd99970c3d4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+UOzWJv7HSBaqDRMfQxCmHzYEZahQSR2TDN4ZrZq4Y=;
 b=mg6/gUxm7G0UzNvBYUE09Rn8EePGFWFFwfS4nzk/5Y0RgojG69dOKbuhwZkkxyYMmWZZfk
 IWUnaY01VVTybEG0j74Yq0SwsSHJwZLoKNmg7CGs+uXbQNV66BFb4qZr6rMK+DfY23bPFY
 gWUNzKI1obIYOcOhDsRVRqYjLid0nu2S29WLl160828AKupgVOTWIa1YFH5aXFH72VnBb5
 mnDpSNvwDwvKy4yX3iIk4XlyrgPGZrBBaykq4xQAa7MGH7tH4i2WsRdnAHW3y8n7u4AM6v
 0+m/ZQYCEkWOE4AkOlspcEhXezuCLsiUBqVmaJ90CU7HnVR/VMftdv3cW3I6OQ==
Date: Tue, 3 Oct 2023 14:42:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 02/16] dt-bindings: Add RZ/G2L CPG bindings
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-3-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-3-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 835114e8736a9a4976b
X-MBO-RS-META: tz5rgwjrdyojdb1suq8qbi74jpyz8iu5
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

On 9/20/23 14:41, Paul Barker wrote:
> Import bindings for the Clock Pulse Generator (CPG) module in the
> Renesas RZ/G2L SoC family.
> 
> This patch is based on the dt-bindings in Linux v6.5.

Please also include the exact commit ID in the remote project when 
importing files from it, see example in e.g.:

a7be3fb54a65 ("ARM: dts: renesas: Synchronize R-Car R8A77990 E3 DTs with 
Linux 6.5.3")

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
