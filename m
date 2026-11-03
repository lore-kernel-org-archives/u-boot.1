Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6F606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BST8eLdB;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gGTdLquJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 815D6606C2;
	Tue,  3 Nov 2026 21:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZ4CLULpshwl; Tue,  3 Nov 2026 21:35:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C72F6606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741715;
	b=N5F2PdAEksgAqFcxO200raqIsVKVsH/eCbBDgvjKr2rEfe9bVPbzmflzP7yRVMxluMgz
	 I96rfwRHLRljB+0Whzy8Nqa3iWqipJ+P/VHRnTG8FIG0J6N5cwGdLCOCiazZwCheMjYcp
	 W93/CItVk7DZrd1ltCK/zZLjX2M8Miw0ucrsDIeABIyJHZwaZVQtn8TZWz+WqETwUSeOf
	 9TPSI0soWNMMT9ROktGVwfMwLeco/keyk+qcHM+7SbOal1sRRtHhnsnWQYcTlGx1t58lo
	 sxj3CklZ9wsevBGrEonOq/8tvAW5bF4xZDpdJmkptp4iMUBjtUjgRDNi44JbnUwTGCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mC7oIWvPAFzDmWCIqwtVlZCcGwMRnltfcEhA/o25XQo=;
	b=SKgC9ccW7rHr5lqm3cPHEZNxNUKr2mOWfEU+3BijKtley3PgWkmrzkF8g0Ov4TBm4lfk
	 lflzN2lg2t/+dYcY3HHAxe7YREuhZof7usw0hfvzax3OTYee+HbkcvtMJiRexsG7Ot8Wb
	 bBmRArmDRuoPOZomWVeyVxvJiv1GnZkKWAz/9UixcS6+sW+8Ay22gGVsD1BVuEL0O0pjJ
	 9zyQiuG71U+Ta4OvZwIhhC8Oyxt/qwifLaIaaXQO/BKJ8PncCsnZ3gfUbWtXQWFDFaOGU
	 rqwIwvQmQyWy5e2yM4RVv1OMEKr/9Qem3/kZWohCtEkb0ZyHqkQYu1wCyWOzLc42cKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741714;
	bh=mC7oIWvPAFzDmWCIqwtVlZCcGwMRnltfcEhA/o25XQo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BST8eLdBGJRw8jekJONXc/8AADUFDSkp85WkIQDgXEJcX90+wDwZU7/l/2OIMqKvN
	 hTRfUFaaGodr+57cQzqqgqXrHUOECM/I7PQU4b4yUpRsqzQC7/nSbo3arhPSnU3sXr
	 kykQL0FIOqtOxTHUAggl2dAxQupBqAWFcC0U1sVUAot/ol5Ky5w5whPGqwVDurupXN
	 ZBrAudRBZLN3mDIKJdJEJruxUod/n2Jb6e+LuVK85OqTwe3pPhhLrcLZXRn5gzlsFM
	 l5FzELJgUDRgiaNqaPvcMZ7pBDsdGyOwK2fvp8icuywjnrYGP2C9R9+w56KtXkhbAP
	 YqSIp9v8CpiWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C72F6606A0;
	Tue,  3 Nov 2026 21:35:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B08E6235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0E1A80D30
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8sVpKpiqM60w for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:35:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6696880D13
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741712;
 b=fOdBcfu9r7le5kZL9jZi2JDzWKAvcFfQLKseTSji0qRuopklllmcgVa5dvh+C8ljtjss
 Uz01N/xyUbss0G9AlVdpqc35bE6Y3jJWfGAe40i+cFdxXCnyaVhIcWsM8Q7/u0zOjG32m
 qMOpZBcGkzgZF2ic2EjBm4t109m9RcqzOnnbqFF6S5eOZPw5fIx7O6afkJZeDbyy9qWDy
 y1fo4m5e0QduZi3DxgMVqAVYwZ489c0gkeo1RotQh8utgJX/imbBwh45R+2HnhZZWkDHp
 vY7oS+n48k5LFwTuCe7lW1ZOIoHCJzqe3OyKXHadfQKCaGQ0Q8lYapfw8zfb+L2O7rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741712;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=mC7oIWvPAFzDmWCIqwtVlZCcGwMRnltfcEhA/o25XQo=;
 b=r8CAeyh96CSEZ6sWYDcB3ADnBM2wVO5CnyZaUeb8t9mdr+Xylk8oHicvywDrGfJfr4Hx
 HoWpiGUcbwDshLIn24B92SR7+j14yoaeIeYux5yoysY7vaBTZkxHAVGJ24hUfHfod2YZt
 2t0PqxY9ziKa9L6+ukVIqL0iWBLDBecnh9UssQYMXx4f+csx8rM1pmj8fvnOfWvgkCiSl
 Cl0bblaV28MQ4vM2YOUrzcuM6KAlgcSanH7wiVD7H9LN7TMzhxnclN5Yl+uUy/kZnvo/M
 98n0eK1WBU9RuGdOfBjZWjMp2Pfe5DB/OdxfjleE+ivZWX9TvjqlelW1tVk4CgrZDuw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gGTdLquJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gGTdLquJ
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6696880D13
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:11 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so49772f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741709; x=1794346509;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mC7oIWvPAFzDmWCIqwtVlZCcGwMRnltfcEhA/o25XQo=;
 b=gGTdLquJi3htcobq7VtWa5qt9taPm4o8jXEQm2nYEWo7HQ2mAYqIU2YYicgO3uxn0N
 JWEHrHnVtPsGPZlK9Tp+qHN1bK2ptNYF7qs1d9NJGdF9vqNxZ/eIIFY7FnEiRX0TYSRU
 Ux62UCOKGRNeXnsrD7877PYnT2K+9UiXagwcR/osDLF7FAs2/myK+XLrt6KbVsnxCdXG
 wPY75j+KTpioB8Nqf4l9lKwad8Hgk3y/PAYZs2c9A2iMa9n88w7N0UvbAIpGSnj/Nf8c
 RYuWAZ9JIsHepzbKDN1bQvaemDEIQT0bmTo78v237mFF83LNDMkz/prjW2pfZURBI2LV
 tSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741709; x=1794346509;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC7oIWvPAFzDmWCIqwtVlZCcGwMRnltfcEhA/o25XQo=;
 b=LbG/A4btoGOymv/dPUL4LZTLTu9vnEk34H05eXCiJmgxopzTlHtKljBqkJmGmWCtwf
 zAWERHY4JZxrdvmcfkOomdag0n0SmSpRQemHPdAG5VC7c6XJE8dU7vx3AdYHoWIx/1Qs
 u8ZN0G0pIW0y30yTNT+6EuMQZYwXMNFGd0MVySxEsMMRr4931Itvw9MW8Va+5ledHkok
 hjNbk6p6eg8In0A65HHzQcNpUMF+ud2yzIKrapvfC3RGK+gy2eR8gbN4aXcD9m499JN7
 pKdwxVSHvWeK4w1S+bAIykpAZh59uEPmFP7jnNCS3XWTleGED88P/ZagmIUT5j4Ihknm
 EkNg==
X-Gm-Message-State: APuU4Z+GI6XD/0VM50DIwM/W9iez44MelqdSQ9WspwBqN1mVsj5DHn80
 rcDyoS72iQuAvriwzbVynzqLjHNrr30mZV2QXdvAK/7Krf7LTC5qkHRz8G9+QcO233Q=
X-Gm-Gg: AYBFou2Tf94d7j9YIcquXJFNIYb8mgWa9JRFH/FA3KppdyQ7BFzQja/ntQYRrjQ3SZQ
 EnhJEQz44MNNros0Wel+fCzjDbLc8hkuMoqTKf5cV6C8XGmAqrejR4jee/KxVzqAhAqsgYBIzjR
 LFnMg5+Z131t7w3bwVLYDKCShtlLzr9bXfbrOPkYo4g7rM9WU39WEDIJxGLYe9tf/HhBdRfbUoF
 Np+ZKiFxaAgEPBEipJpwB3IWiwouMXGAi3vdIfivFk87Q94tNz0Ot4+FVP7ZdzVF7uUtI7VCI5T
 hM8qF2moTo8vSH/KeW0WX20E99+zPXuaEso2t2YWlhc/mfCGitLC0XEsw0mEK73N2EiPkZ/uU43
 4SrJiVvUsc1mDoc7BeMaKuAKCbwkOQwDjN3DNrhkNquNhPrN8cYrn/o3L1EJRWM3v50bNWorknE
 86TnI5eDQncPcqTg3s2Qpy1+QwyzvLargFqku9s6nJZQUkDuNMcrqO8+Gp5fQJkqEoJ6OvqQ4DA
 xC8YW6ygNBW4Sdg7betk+bQo0onqSHPbp0mhyygHlVep4Gw5ki2Y9GU0bDhpH0AFEujepUNq2CC
 FsQ/kd/mdps6IIWblyXc9U1ZmsXaQhEkJvW9Fv1biGtRDb55OCk=
X-Received: by 2002:a05:6000:4b0b:b0:48d:db77:d124 with SMTP id
 ffacd0b85a97d-48e6e2db9e1mr32029152f8f.6.1793741709089; 
 Tue, 03 Nov 2026 13:35:09 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm179941f8f.14.2026.11.03.13.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:35:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/6] spl: fastboot: support legacy U-Boot images
From: Guillaume La Roque <glaroque@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-5-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-5-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 22:35:01 +0100
Message-Id: <179374170194.3704535.8700153829816133860.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793741707; l=552;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=YxfXCbAS1eqVDSz8P1wes7grJRtgZTBNj657ubZotRk=;
 b=QdjCaBZvfqscD4F6Rb5KiomIQSTZcjs2YidA/hhYmqYCstJT+8eXGajCkyzLlRDxvGjI71q6L
 Z2eTadq9S/2CVt62AoidUAbQE86q5AFbNPoFLVZaheKVNnYGufaXyGn
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

On Wed, 14 Oct 2026 14:24:33 +0200, Carlo Caione <ccaione@baylibre.com> wrote:
> Boards using a single legacy U-Boot image should be able to test it over
> fastboot without changing their image format. Use the shared RAM reader
> and SPL loader, with the downloaded length limiting header and payload
> accesses.
> 
> Keep legacy support optional and reject compressed images, which this
> RAM path does not yet support.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
