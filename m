Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39EFD41D65
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5DF830E4;
	Thu, 11 Dec 2025 17:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ok/xoyjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297B7835B3; Thu, 11 Dec 2025 17:24:28 +0100 (CET)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B250A8309A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 11 Dec 2025 16:21:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1765470258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r38he97nVLah3gLlVfTA5b99WZvv8SPkZkeQ+8s+8Kw=;
 b=ok/xoyjAhiLkFSECpJ1D05WZTNAjIdpFUyk7HcOWnjgvH4KZUr+wbNzVTO900IsuMrExFP
 mdYONU6H95u1929bILVbfYlDzSHnJTbyKqa7UMFzFsPKbFBZ/G4lrK2Z2+hhNuHLc/Fmo9
 KjM0fAA06cuQYepU4TF2gExTTsXCernihgf3GhL9e/SqmeNBy9A60+NiNPUaEpz1oxbFaK
 +/f4liTOTAIeDCeyUFj6hjObOof4/KklPUQSEwuodV9f3qaWsei8J8i4aNxEKGvw7TkQR0
 c+qjocZEh3kGZjEGAlui9ezAiUGFShK4cGzHfevLKJFdr5gtRXBIdLP2qr6cqQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ferass El Hafidi <funderscore@tauchgang.dev>,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 1/2] arm: meson: add support for EFI capsule updates
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
 <20251211-meson-capsule-v4-1-59f126ba4115@postmarketos.org>
 <7a30f8de-c87b-46e3-83e9-6d61484b2ecb@linaro.org>
In-Reply-To: <7a30f8de-c87b-46e3-83e9-6d61484b2ecb@linaro.org>
Message-ID: <t745kf.c5gbun7uixd9@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

On Thu, 11 Dec 2025 15:44, Neil Armstrong <neil.armstrong@linaro.org> wrote:
<snip>
>Wait this means all boards uses the same GUID ?

The GUID is generated at runtime based on the devicetree compatible
string and the fw_image name.
(https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#dynamic-firmware-update-guids)

So this means each board should get a unique GUID, based on the
compatible, and in addition, based on which storage device it is
booted from, as the fw_image name is different depending on the
boot device.

Best regards,
Ferass
