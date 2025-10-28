Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE60CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C27E82A9E;
	Tue, 28 Oct 2025 15:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="luenaZIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890A482A9E; Tue, 28 Oct 2025 15:25:44 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E7D80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwt2X5qWGz9tjl;
 Tue, 28 Oct 2025 15:25:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRuCoF6JL1NwXvEkIV5F89VBe30vWGNveqRZEYbPFJc=;
 b=luenaZIJ8mD00tVzMU7T+QTYvb7Ts/c0cp7UOMRYMKGMSxlE92iR/vTCywQvoSL+1SSiRN
 YRlDE/WSaTeOqw9u7CF0jn0neXQ+SFo0ZR3IDnbthBzjzjJL/Sw7LtJWfHvXyZsvi6rTXN
 yZSfaCcnQZIHEZPSXhni2LXi6y4VtUR4i2FauQVe2E6mMfbsRx+H5EQPU7782zHh+AbRPj
 89uM8561T3DMBzMiNMFjsbD/+PH00TDTtj0cDJc7JL4tmX75V37DmrnYwm7GdH5wkFpFPi
 9N2iu03kcJHWeN+g8C8Azf3ZWVW1qzrBjTWFhocD2B0/0XTJr87UzrqDGtOFoA==
Message-ID: <69298582-0ac4-46de-9339-09600e42d238@mailbox.org>
Date: Tue, 28 Oct 2025 15:25:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] ufs: core: Fold ufs-uclass into ufs
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
 <20251027170706.29302-2-marek.vasut+renesas@mailbox.org>
 <9b134447-f653-4521-a559-9510d3d02d33@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9b134447-f653-4521-a559-9510d3d02d33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6abdf070882b63dff37
X-MBO-RS-META: af74g1ngtn7arhwqybeqnottma19zuo4
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

On 10/28/25 9:14 AM, Neil Armstrong wrote:

Hello Neil,

>> +UCLASS_DRIVER(ufs) = {
>> +    .id            = UCLASS_UFS,
>> +    .name            = "ufs",
>> +    .per_device_auto    = sizeof(struct ufs_hba),
>> +};
> 
> This breaks the implicit rule to have a <uclass>-uclass.c file, but I'm 
> fine with that
I tried to move the ufs.c to ufs-uclass.c in V2 , but the resulting diff 
was unreadable. I therefore kept this patch and added a follow up patch 
into V2, which moves back ufs.c to ufs-uclass.c , that is readable 
again. Those two patches are 2/7 and 3/7 in V2. I hope this helps.
