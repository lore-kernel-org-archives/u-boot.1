Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C631D1D48A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DC08415E;
	Thu,  8 Jan 2026 21:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZB2Ptcsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D2FE842B6; Thu,  8 Jan 2026 21:35:48 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9665183A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dnGrJ4h3kz9v6c;
 Thu,  8 Jan 2026 21:35:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767904544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGtDJ1IsRBOufD8tEGD/2VQHp1STlNn0LPjsTynU3ZQ=;
 b=ZB2PtcsijJcvgVVfUvKqrHk4fv7dqrL3PBiQCKqaUR7SFDwjqgPNgmM7OPHURQ2ZSszA7Z
 djJllD2cq1u/fWrJRtxRkaAjlcamkdLlrxd4PwG2hddltdFJU4QvxHmOKlf7l3NqoDCjjg
 Ah17AXvlHU8uq4kb0qaNr6/9zHKIWP3R0eFhB8Fr4BkimTHh0KAg7oaNp+NdNBgn7Kgt0N
 gFLKmNRJv5GyN0+d9MbRxKlKWjw2IVpXqy/oBEww8eUH1u9lRnbpzeL8XuQGK+Loz3Q26s
 SpLeMR7RPYukQEoaUQgljFyd18J6KAVkNL/qXU6eHvYYzGDf2g4MWLP5xxMwsw==
Message-ID: <6b3bc053-ebee-4188-8e73-ec0d7dad5345@mailbox.org>
Date: Thu, 8 Jan 2026 21:35:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] ufs: uclass: fix potential unitialised use
To: Casey Connolly <casey.connolly@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260108201452.3171709-1-casey.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260108201452.3171709-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9d849e06f492d378498
X-MBO-RS-META: sa3irdzg7n1uy9f4gymgcjo96m76i1i4
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

On 1/8/26 9:14 PM, Casey Connolly wrote:

[...]

>   	host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
> -	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
> +	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL) {
>   		dev_err(hba->dev,
>   			"invalid ref_clk setting = %ld\n", clk_get_rate(ref_clk));
> -
> -	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
> -		goto out;
> +		/* FIXME: qcom platforms don't have this wired up yet but seem to work anyway */
> +		return 0;
> +	}
Please see my comment on V1.

The rest of the patch is OK, thank you !
