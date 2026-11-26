Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9E606A33F
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yCbsSLE/;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Vpy5fZ9M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F7DE6064E;
	Thu, 26 Nov 2026 08:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C3GLlow6pdrb; Thu, 26 Nov 2026 08:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E87C60690
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795681454;
	b=ZPSU35CEIuwgdRioSxAwG4cyq8SdJM4Z4E81Smig3fR5etumPEUJ3QwcZ1pvsuSZ1Rbz
	 VxgmpGiML19Nlz6eUxW1368uuqRn8zI/kbm3BJDvuSHbdDD8DpoQIOQV+SBeWiTB57TmX
	 8fUfR7azisguaMh/BXzn92J1QEQputXj23T9UG2//oGNzkxseLQaxZiXmpJmWdKOdMSD9
	 8qLS1++qwet6K/SCw0dSjw7xaiPGuedgjp7ZQlf/nxC7wuN3Cp/rWLxLZdCddewPiUUCW
	 fViNx86RQ5ODmJ9uLkDSE1raCsQ/0Ja1Tuzy2sclwO0ITygwWNN1xz6o7gUyEP99Txg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795681454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=s1KsFGTNncI6AqdCzVT3fVVJBm4MBS2b1UNWN0yfB9o=;
	b=SjXLhNm4SRwYzjisVYijbSEaECt1DvRqp9LaPfryTEOJWOP6sywCmMF9VOJkgd3GlQx+
	 L+JagNsCWFEXjMfO31KbQ9OWGFFIGzUh1AS6l48buLRpUDn/MCRxTI/KmelGO8g0+Fgse
	 DKY90zLfnwlVbiewFKjdsCPNWax0QsnX3eYdy6xR0kisFAnFfp5/EzNmzVmr7nY1t4GqV
	 0Ya8t/kKgnHxqckq0BnOoNmwiZ+rm6ssh3vLLxD1kPn87kufq5/ewKbKEMd3GjRCL5Pkx
	 bsAXmkGwZJ1zEdTJSilrdisgTqiuIBvzC3ug5Kt2Tv10cFjWGzaO7wxr39HXN/zaNOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795681454;
	bh=s1KsFGTNncI6AqdCzVT3fVVJBm4MBS2b1UNWN0yfB9o=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yCbsSLE/BLBulzBc0LYFIB1+ZiHxAUcpS7Tjf9EjopgWYxY8hh3SCXTh3FRVf8xnO
	 IPBQDMr8Y+aXaHCvdPMapC/jf5utDVPEN6Cgd1IowN9xc3HnmerRD4gSCWR6RuhUUB
	 fDwcmq3P3tNXWuqKUtRoI1KXojMAQDY1dzsNjGJbSwSg6wbitv/PRfI8iTaM0VNJGG
	 PwLa0B6EAE5taGJ5p+CFtplXy5WMK/E5KVUTrx3JjTvTQ26XGnTB3Knrrlyxs1dBA+
	 y4+uQ56lSyYx7xnIq3uYBhagxh4tWktT+Ny7SQ5UHhyO3xI0lK/Q/ZJZ1OAlBr4kTc
	 9QY/lfvQ8e2AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E87C60690;
	Thu, 26 Nov 2026 08:24:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 271D226D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0CFF740493
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Haid9TWzi09 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 08:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DFF8B4048E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Vpy5fZ9M
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFF8B4048E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:24:09 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so4730223f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795681447; x=1796286247;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s1KsFGTNncI6AqdCzVT3fVVJBm4MBS2b1UNWN0yfB9o=;
 b=Vpy5fZ9MRjUCJwn5RXaHEoyaJx5f1x+N57EoRGlUqL1KzJvVYcmGgCF1YPqAk4ziC1
 QQ9cwKiroYH6BeL6zYbjJxby+r4PshjMfgCZVMptf4NiBjDpW6V6lB7TIa6rCDY9PVOy
 +3dDGYMMHRmrdAmZACja5EzsBUHVB0zNqOqh2v03UKqv59FrvgixSH0ljGzDQqvUCysa
 SSoLucd7pduyY/UpwmN+EEb1H3Sab9aD8FFmBt0i1324PCkEJzbRdwrcUgM58tV63iR7
 Tltk4UDZVW9eBXDoCxgCn0WBOYZoPA/saJRwQvj3EJ/I/lVNqp8Nxlhjm3nDgqmALV5F
 p4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795681448; x=1796286248;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s1KsFGTNncI6AqdCzVT3fVVJBm4MBS2b1UNWN0yfB9o=;
 b=tak9yGNWQbW4gP/WDRs81xU7NvRQL9yuxvOv+FhVlfK8YUu6sCII3yrd28d0MEgWsv
 XYk/8/BoVuIxZGVyGP39ehBExZJ9uZZd3b1SUuZt0yAHpbKFLbpnaBy+tAHZXdnGooIy
 PGpVO3xaWfJGtJdRiF1ew/dVHjsPgSJJeayRX3kSmOs4rw7Z4oPv2NTfu2NQ5dXJnQW3
 Lf+ZqkUVKuyq3dK6jkbPl2YJDGYTSDHj62ck1pRmim+aUejXPBbcDK1JHf4eBjSEqwY/
 Sqyina5KjTVuXCcP0/gJ3QtqNi7/so4yfDVZDXHdCr+2gdtnk40AryFUVM5DlmrPNXgH
 0soA==
X-Forwarded-Encrypted: i=1;
 AL+hErE6MBlluj4t7pvkrx2LVX5ft3Esh6zfKGr5UIcwv60XMkbmqknHwH6P+rYnqaL4UhRMBhdxkpg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9CeS9NE1OyvCE9EG+xn/mmfesxfx7TBQpkjCd9TCRl40zTfHv1
 oltqdaqF1q7OUlE1/Gu8XUdzGz/1mmNe5pPDbd/Tc6Q9AFqo+2e4XJpP/N6fYyWRugo=
X-Gm-Gg: AZFdTZd4KbcLynHpKZ/8OIPa21FeaFi8pwcgekchXAiB6ZVZbtsIg8qbo5L/e9nideS
 0KXE0vFCIczbf/1KzkHXPyOdp6E1mVo8et8pCsgCAOjNK8Xy57l/hVOfQSpfwdzDxEhMOa2qo/z
 dGDzYW6YTli9SdpWPpUPpYQwpW8mDMlPpqm7ioftTVy0PMhCe0gFjc5qcGdrIYpy/BnxSKUOXU3
 542SKWIxn0+3ZUNWa4rEkq9l+RM3naRPWb67H8cycYm1cFDtH/WEGMJzZ0EUavtuBaH/eCKnpMs
 Ntl9RD8FBhZJu0c/HsnuDwwdiUNTq5r/STw6lRPgpXJOb5pS6LTZNugkBHZOqmcG92VTNhmu+iM
 86RiNBAMqiyie7L11TSwukvUPdbYtCR+Yhuv1GeXrDgHWbXtJD8UEr2Gg2QSFpu+ajhM94S2VFR
 DNfvYjzP9NY8WobiFBIqpqhzp45x+rs757MtiCU4pxeJfVLliOC+mgyViXSEIVz4Vgarq4TIXTE
 7NxcQ0rC8zoUmU9RmxIUqdzhqX91ZeyrGHIsH3s0DcC4tUYKVraM2QmWH18ivLoZZajvK6ZUq1x
 7WvZtB+ffOLPW6T7qDeSGLX3P5nUU5ye8+evNHw/CeBsGXBym80=
X-Received: by 2002:a5d:5888:0:b0:487:1ac0:32af with SMTP id
 ffacd0b85a97d-4abb47b0fb1mr38731966f8f.51.1795681447566; 
 Thu, 26 Nov 2026 00:24:07 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm40358827f8f.11.2026.11.26.00.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 00:24:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] fastboot: spi_flash: fix error handling
From: Guillaume La Roque <glaroque@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
References: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
Date: Thu, 26 Nov 2026 09:24:03 +0100
Message-Id: <179568144304.358187.12667213342241957650.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795681446; l=417;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=mC+BUFCzfVIR0Whh0vqt+d6YYnzldXRHirfuC1jX4vQ=;
 b=l1A3TthVJulSQzlaUZll+s92PagUiCrnUG3yzV+NHTrwXx++Ey2oiGrfptn4AaxnMhJiDxkn3
 9udCzJrHQWmDv6BM9ICX+mPW0+slHCLIadiNl6tHCcZorh4bCXj11qz
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 11:33:09 -0600, David Lechner <dlechner@baylibre.com> wrote:
> fastboot: spi_flash: fix error handling
> 
> While working on fastboot SPI flash support on a MediaTek board, I
> managed to trigger some error paths that revealed some bugs. So here
> are some fixes.
> 
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
