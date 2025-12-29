Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E78FE92FE0
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 21:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C61A83EF9;
	Mon, 29 Dec 2025 22:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="llkrv44r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E0583F0A; Mon, 29 Dec 2025 22:16:29 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A12683EA6
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 22:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dg8Cs2j53z9tLX;
 Mon, 29 Dec 2025 22:16:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767042985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WLSBBEsJyI9oirX5r/GhurjzPMtx4wxD+9Lb39ijWI=;
 b=llkrv44rvMjWYZqmXRwbx/UZCGyC3+CcFM3VYbXUvywQrdV+kp8px9hk2p+9Q8oum1k1b/
 itJSqVBTPNfF/8wn4jRa8aT+JaLjwnHawFL4E2P78zyXqauwhy36Ik0tOhT3pY2syHtY+x
 A7AnefmZJ1b9RoTNw0Y3+benSpgqWeafF5S4RN0EdC0mVvZp30r5Q4Cw4vnRJMAjiFd8LO
 HeHw8OvNYcQdOdn3lFkk4RUF9FWD3Q7yC/l24eCS13+llZiV7ibccpuhT7pn/o0rs8rlWR
 i+ikFyfp7/mt6Ln903WdAc4cb/ejwP6IenqSCZ0osZ0N/+W1tqs1IfcmFsyRYw==
Message-ID: <9a56b395-3cc8-437a-b3d1-4629f1f47481@mailbox.org>
Date: Mon, 29 Dec 2025 22:16:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] clk: renesas: Do not enable MSTP4 extra modules on
 R8A77995 D3
From: Marek Vasut <marek.vasut@mailbox.org>
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
 <20251228220717.3630713-2-niklas.soderlund+renesas@ragnatech.se>
 <1fd09fd2-0603-4347-b27e-4c041069db48@mailbox.org>
Content-Language: en-US
In-Reply-To: <1fd09fd2-0603-4347-b27e-4c041069db48@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m6org69z1b98wucoiksf8qsnoy1ndtj9
X-MBO-RS-ID: ac2578db6f6c7c51384
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

On 12/29/25 12:07 AM, Marek Vasut wrote:
> On 12/28/25 11:07 PM, Niklas Söderlund wrote:
>> Since commit a2bd99549c61 ("clk: renesas: Tear clock controller down
>> last before booting OS") enabling the module gated by bit 8 in MSTP4
>> prevents Linux from booting. The bits 8 and 7 of MSTP4 where only
>> documented in early versions of the datasheet and have since been
>> removed.
>>
>> To allow Linux to boot update the MSTP4 enable value to reflect the
>> hardware default, 0x80.
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Applied both, thanks !
