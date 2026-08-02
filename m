Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5AFC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 04:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEDAF80D91;
	Sun,  2 Aug 2026 04:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WeoTwBIDn3jE; Sun,  2 Aug 2026 04:35:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0118180D7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785645325;
	bh=R/cxStdI/h4Ki9O/nuRGDglS8dyQCuvL1fQp+CKPkrs=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Qtux/9S9u2k01mft1U4k18g0ajzMmhzDB0obfBA67VVQ0QkftGv8CIofHqSexm03A
	 FWpvRZH2xA16rwvHTHuBt72LqF8xlA/Akr6/lG5ke05PWx9rkTAzjfymCxgDwzl4ma
	 xZQbW3ycjNmsEVAblvWuUKbQ4aczwa164aj22KjpL9qqPo74I+JAwth1JyZn/2FGoS
	 gQUF85pSwWpGW//39iyK3VziPNxEsOmRYAn+fmr3kmtXJFZvqXRrVCdjgC7H60CpmR
	 baEMvxJ9L8+ZdQP45FauUsGAc/ZsnzI/e89kVAjMxAb/p5VVou7jECfY/NDPTZkDlQ
	 8EDlMlq5i+xGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0118180D7F;
	Sun,  2 Aug 2026 04:35:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70E7D26C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5709E60635
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 16aUcqeRzcQF for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 03:35:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E95760633
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E95760633
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E95760633
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:46 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCQSG6gppz8tCT;
 Sun, 02 Aug 2026 05:35:42 +0200 (CEST)
Message-ID: <4718adba-a598-4bc3-a347-a54750a5fef0@mailbox.org>
Date: Sun, 2 Aug 2026 05:31:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 02/17] spi: cadence_qspi: enable clock
To: Ralph Siemsen <ralph.siemsen@linaro.org>, "Kumar, Udit" <u-kumar1@ti.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, Stanley Chu
 <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>,
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>,
 Simon Glass <sjg@chromium.org>, Julien Stephan <jstephan@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-2-af2ce80db9d8@linaro.org>
 <cb7eccde-b811-4572-8c30-7be4ab3fb7df@ti.com>
 <CANp-EDaEsWN2spSbSsd66mLfy9hARpvZOafcsZXnjQOpoKODUA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANp-EDaEsWN2spSbSsd66mLfy9hARpvZOafcsZXnjQOpoKODUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6q6nkezjzokufr4swfydtcqdbfu3zmwz
X-MBO-RS-ID: 286e3dfe00a302a3943
X-Rspamd-Queue-Id: 4hCQSG6gppz8tCT
X-Mailman-Approved-At: Sun, 02 Aug 2026 04:35:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/cxStdI/h4Ki9O/nuRGDglS8dyQCuvL1fQp+CKPkrs=;
 b=py2i5fvhRwQBCad67C4LFeo0zGtQnNAlwl6yhlPiPko1Jc29EVByhBCfWsZljf1UFzC9VP
 1GhEqsvArnedc4tax8UFeYtk1KxGt1Wj781cBlQ++E+/sWrGAYHG7WqaQUPVNzxfGE1uZj
 cm+GkEMWKzir+4830VMOBQlPnpqe+nSAIzM3jnJK+/oxO6jIJmEVXIWd9FiS5Y87e2DJ2V
 fZzPCmlIM1UYFmg9wKiOYDplw9yogrgfUjTLvgu1ExJmfUkZZLkc0sahuQsF5fUjg6eS5+
 rhIpNe80WTOV/RsObaXoVCV6bMlpYDCCludNYTFagRGMmG99FG0AjIOANEyMYg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/cxStdI/h4Ki9O/nuRGDglS8dyQCuvL1fQp+CKPkrs=;
 b=TgdVVtW2tTRLRto5bA8PHgW0Ibu7uV+hApaRhFtHxvT/Au8h6a4267Dy+V2MH3gtUMk1WC
 Rnann0jDEt4pWD+uBxkh/8vGFMoZBOQM91+MOU4KGAAxS5P/M7IKcmuXa1l/Tksi04Ci0y
 MtHaIryFWbju+naAxXEhh7Is+22rr0PTiEo7XcRYVnI6geKJbK0uqOzmGh0mN3/+x3skBj
 931uW3+OKS+6+LtuQYG+G3rGwDzkpmpa5gObdAL2I1ogve4kqfnGERInts9z9VwwEbGRoh
 lMS3n+f92byOyiNJ40P8y2FkkzYAj9TEw6W9DJdWQ8DqPQe5n5JM5QIfnBzGSQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=py2i5fvh; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=TgdVVtW2
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TgdVVtW2;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/1/26 2:04 PM, Ralph Siemsen wrote:
> On Fri, Jul 31, 2026 at 11:07 PM Kumar, Udit <u-kumar1@ti.com> wrote:
>>
>> On 7/31/2026 10:03 PM, Ralph Siemsen wrote:
>>> --- a/drivers/spi/cadence_qspi.c
>>> +++ b/drivers/spi/cadence_qspi.c
>>> @@ -253,6 +253,7 @@ static int cadence_spi_probe(struct udevice *bus)
>>>                        priv->ref_clk_hz = clk_get_rate(&clk);
>>>                        if (IS_ERR_VALUE(priv->ref_clk_hz))
>>>                                return priv->ref_clk_hz;
>>> +                     clk_enable(&clk);
>>
>> you should enable clock, before calling get_rate
> 
> Good point. I will move it up.
And while you do, send the patches separately so the CC list doesn't 
include everyone who ever contributed to U-Boot and then some.
