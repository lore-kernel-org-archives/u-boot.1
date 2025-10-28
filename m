Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA22CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3627581D6A;
	Tue, 28 Oct 2025 15:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mXKqXT7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1754682A9E; Tue, 28 Oct 2025 15:14:07 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A32780422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cwsn71N6pz9t7p;
 Tue, 28 Oct 2025 15:14:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761660843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lg36i0xoy7uMgfN1ioTOO5qo1HYooFKAMaH7h8TZjPg=;
 b=mXKqXT7uDIcYEqtuZ5QGmPiyfsyC6uoGfWO8J4ojwaOj4i23dZZG996vKITm2s7nPwyNqe
 PEAkAqQJ0u8R29t1pj68YBWlvFWF/NfSufc7ERuVwM0JWQz3O2LkxpV9dfxxzTqOEVhgII
 QLwdGgNVp8ra0BTTM1q1mPRu77PBxdETS35vH22XT9B7FNsiT/EMLNS+/IkAGL6/o6IWke
 OjGaH8PF3lNNdnExaTGlABMSNo5GUIxSOGS7ak/z5CctSDj9XT/aAL8TS38Zp9zkaphuSs
 aoyUw5ft2cIn7Sw99RvIGdlLMNfOtW7jsoKEPPGhQaqNkzpVrdILZk9MAY7M0A==
Message-ID: <cae0e8cf-5abe-4cb7-b867-a3e314210f4e@mailbox.org>
Date: Tue, 28 Oct 2025 15:13:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 6/6] ufs: Add UFS driver for Renesas R-Car X5H
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot-qcom@groups.io
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
 <20251027170706.29302-6-marek.vasut+renesas@mailbox.org>
 <425461f4-8be2-4e47-91a6-7424950afbe1@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <425461f4-8be2-4e47-91a6-7424950afbe1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 827dba5599a5d2f42d3
X-MBO-RS-META: ffac5u4ua1u7edcdkdipmdkzag9d56u6
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

On 10/28/25 9:17 AM, Neil Armstrong wrote:

Hello Neil,

>> +static int ufs_renesas_pre_init(struct ufs_hba *hba)
>> +{
>> +    struct ufs_renesas_priv *priv = dev_get_priv(hba->dev);
>> +    u32 val32;
>> +    u16 val16;
>> +    int ret;
>> +
>> +    writew(0x0001, priv->phy_base + 0x20000);
> 
> The driver looks good, but it's a shame there's not a single
> register or field define to use instead of magic numbers !
I'm sorry about that, the init procedure comes from the hardware team.
