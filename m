Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BB7C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 18:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39DC81FEE;
	Sun, 20 Jul 2025 20:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kaJLk3++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02328211F; Sun, 20 Jul 2025 20:19:50 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B646B81D6A
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 20:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4blWyp5DBbz9sSf;
 Sun, 20 Jul 2025 20:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753035586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVnKYVAWhoCZqHHNy0ep4RzepvkSqx4T4+03j0IRi7A=;
 b=kaJLk3++/znGw2q8lo8wpaevK0ZkKiow7PAiI0841fau2T1HnUsHydaVxd1MOYsE54hAAk
 y7mJ2+w/P8J2z8n8vLhZtC3oX/vS+O7oEbAd+UQs2RrWe7rlbppIAo279pPL4pdva6eXNS
 53DubgcFl+aslJTvdRFvaopLG0hBPkoDYJpvq8qcObaaG8guRrShCYQH2hrgqNVR5PPwOd
 e/RrkHLfwm1uSBS8JCtgAnuflykmhkfeWIm0A0z4cKXbL1kOD8H/wehkMwKmkcr0DksVw/
 1WkG3oIx+oWOFBiloz9Ck0VfLMzcQT6HlCerqxAa6f8h8xS7G0gS2fYdsNUZAw==
Message-ID: <b9a82175-df13-4674-9372-ce88efc75ad2@mailbox.org>
Date: Sun, 20 Jul 2025 20:19:43 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v1, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_env API for environment-based firmware loading
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 seanga2@gmail.com
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 albert-al.lee@airoha.com
References: <20250720150404.25844-1-lucienzx159@gmail.com>
 <D82B6BCE-BBA5-482D-9DF3-FAEC5E9C8122@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <D82B6BCE-BBA5-482D-9DF3-FAEC5E9C8122@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: w33ab8c1o4u5uktms4jpdydz1eihxz1d
X-MBO-RS-ID: e431443366f0e63dacf
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

On 7/20/25 5:31 PM, Heinrich Schuchardt wrote:
> Am 20. Juli 2025 17:04:04 MESZ schrieb "Lucien.Jheng" <lucienzx159@gmail.com>:
>> This commit adds request_firmware_into_buf_via_env() to the fs_loader driver,
>> enabling firmware loading into a buffer
>> using environment variables for path and size.
>> It supports multiple entries via indexed variable names
>> (e.g., "fw_dir0", "fw_size0").
>> This provides flexible, scriptable firmware loading without hardcoded details.
> 
> It is unclear where this function will be used. Is this a part of a larger patch series that you are planning to send?

I believe this will be used by the Airoha PHY driver.
