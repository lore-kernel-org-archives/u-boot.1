Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AD606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oPykF6qt;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ycl7InSl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E148A60853;
	Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CD3LV4gzizTl; Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E155606BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018851;
	b=E3Rchqn7EWIdawe1WRX2+4sUFR6KLY9482MDiwYyORPao0FP4xGmq/uQOatXOb9ygr/7
	 vrm03IA8mLzcUEhk6wfgLxH23wRwTqvv9lIXn4k5A5YQWdwehZX812KCHfaVC9yPAAby6
	 niB6Ew3NnBECs/xjn1BGVTv6EYSwLi9tSezSkaRrxUo55ZD35PdCVl91/xL4GgURzYEnY
	 fJmHTlYsh9egtpxZZoJdbLirKzeUxCvm1AW6RfxqeTuARvKg75ul6sUHlLfRKrDuEMD3M
	 EMZ5+ievHdM3SrX0EDNhaACuB2B5DqgqBcnhf2hiToVzJeH1ikDv1j1EKUcq5nqeOeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018851;
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
	bh=v2nlGFRX5Ot5gnfJ2UNxvtEjm5ZEvtga4XA1ADvZ2Zc=;
	b=A0GFr/3SLOKj8PbC7R1qlORr1Mdok0kjCRcYlK/769pd34TluwmDJJGSyBkBjUxRLPXn
	 jw7s7631zxU6N5UrjcatSx/22wxeP5OS5oGEKemK1b5udiACpwwmVcdd6y0WrudjvdRhk
	 hu3LuySea72a8Urlk8l8aiynjni4q48y+pqE8WAJ+mjG4uogQruKAN4Gi5N7cwb8tDpUZ
	 K870vjCmuYMnOo4WZFmEMiKZrkj8jkPqPsFFCwSPxeRTQ8FVuPERk3kLNO8asRv6gBE1Z
	 ZqpxhmTc53Y1+XUVRip2RoMDxhFSrchanStBszp1Qu3MKEAmBXGYExr3i9uyvup48iA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ycl7InSl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795018851;
	bh=v2nlGFRX5Ot5gnfJ2UNxvtEjm5ZEvtga4XA1ADvZ2Zc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPykF6qtOmaQP1ZNobzr2Ebs5uohV3Ap6u0k9FNeM+pPlYMWuZCRc+UQeOxsHRU1R
	 fE8fxa0Ec8Rzto6nYhde/27LQpD95tKcaYqr10DvlaBgTsipImci926Keg8cJ7SSCS
	 4AHOaE9MSNz85dnrTFX0n9zdv0USI+9bYnUnlbpddzPgpSz7zyp8B+960ma69DOF3g
	 C8GsbgOFoTcm0VwTGy9uW2L/Y7PKOgOfnWzxAadFT0JkMMtEpZt63V9Fqo+O3YNQIr
	 rCBg8o8m3lEUMenpF0A55KwxV6w3fbMoDJUB650aTMtHECwYKMfc7pHj0acvlA6mV6
	 ZgoY9IS6a7okQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E155606BA;
	Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32970977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 186CE606BA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m430_FzEX31b for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:20:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0CB2C60640
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ycl7InSl
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CB2C60640
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:47 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so682576f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795018845; x=1795623645;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v2nlGFRX5Ot5gnfJ2UNxvtEjm5ZEvtga4XA1ADvZ2Zc=;
 b=Ycl7InSlh1PNJ2rbWb6JRpBgP1L4fCrfq+ARH2IFS26cIzS9VCLeyryEXEfnEm1y6Y
 u3YK0nXZM5tRW8swpdrUAe6oMFedHv+u+bYr8/AWYRuxfq9YzhozOn33n+L1+o0874G1
 8dUaogFek49SNa70XotakdIABLkqlLa/ZGmoEJLrgBh3MqJnXPm3UjyRVVh9jJ5xo7sE
 aKr6rBd6z9tJylPo+VkSJwx/VfXZlHpGJT28IP2p2c7rW9ai4SYM80CuQrB94H0c+/fT
 AebD1Fllk57R3X1339MG3cR0tgLxCthHOSaPCYOFe0RhTmpKzYhljYxU391jTjZa7LjG
 OvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018845; x=1795623645;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v2nlGFRX5Ot5gnfJ2UNxvtEjm5ZEvtga4XA1ADvZ2Zc=;
 b=npesASF+o/VSYYADC9+y7da9S/WFtNxkYFR7jiQML1W9WB031eu3XxgfEGn+dj0uuZ
 SjuuqpSzc3tAWm2ii6pfEG6h9GE89Jyc0qhBgzCjottflTRwK9CT00D2F0IcMjsGmYNX
 ZcmoGsb55b1QPqdQzdJttP1ACCpGBPwRtVl0d44QHrCFj9ch6HXlakZxlKdExtSUn3Es
 DjsvezqG0N5izDGDvYxPt3myx2jKGPK9zU65ekFYlu3FmYIl6iTaLkIFOEw6M2cYYsC2
 7wk7zYIN+Y9mSoIzvWb3BXOqoPrm+OYynVls23uqW4Q3bGRtQAnbgNykcUFyAU109Ugn
 v6wg==
X-Forwarded-Encrypted: i=1;
 AL+hErEca76AGG0uQ+4W9YKG36WIZohNLbM1piUH4HewhlsSbrgpzz32iElA2IR5rhGzrWwNLr2eu0I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/8sRZvGAsclh8X7TC9egRkAvKnveJfGava2diXRyl5XK56NKq6
 42iLUxxDgiqqPcplJ+Kz6ZNI50ZHIBtwft0+UDgnjCDA3+fRgOWInStePxt2g+/G79E=
X-Gm-Gg: AYBFou0fk31EEs9DuS1Ofb7QkIsMCFrjC3R+jWDTxVPSaekL4olatI+jNCkYDchQedD
 E4acBSP5YRy8locDaPm29CVrMxxzFanljMQIuQJaRiLIreR6sTPlBvG1FZyvYJHTnBW7PRfQGWv
 CFJDJKK7aDBH85v2K4FDZMwpPWP7uAbMM8NMoL1BeOjvkymBpsrOpBE7lkMVGO3Q7QX78OLSg6T
 KRaahtWzUB/16Zx9leUCzTm3yEwLYbF1/o6dhtEWouH+nZ4JL59dcJncRjCKVZ612AKbWqw+ox1
 sTIi2DCr5MjfwQk+f1wIZgZ6WJyBRWHkMAFYQ/8ZmH7VroI9+EOQFlsbUTD4FVDP9pl4Mn0hpFU
 +ZytuKQW3Wqg6d8S3xySNl7VI8y2sN7wa1g1N5SPdrFlynpB/S9FuqLK1rsiyQEswOYqiZU9YiT
 uHZll+mazefPyZCc1lU4gZ2aPLXuBSFWwiDziTxx2PyAoIr/pT2Z5cJTMmJVz9Bu8EoTkKESaj2
 Zh54I3BUkp1pmhQ9UVZBvDTxKRgclhGY7bGH020KQJlGBcvfaHKBmZ1Fnsn/4iX+e5SJv/lAmI6
 1OeCXuDBnlk6e9jDiKequEDx2FjWo3YuAwP8caB02ar+pGyAETI=
X-Received: by 2002:a05:600c:4e53:b0:4a2:526b:d3fd with SMTP id
 5b1f17b1804b1-4bb7da1be3cmr67718345e9.15.1795018845256; 
 Wed, 18 Nov 2026 08:20:45 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efcdsm5537874f8f.5.2026.11.18.08.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:20:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/6] fastboot: block: Fix NULL check on
 blk_get_dev() result
From: Guillaume La Roque <glaroque@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-1-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-1-7ddd7ef832f6@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 17:20:40 +0100
Message-Id: <179501884039.2226612.2512113540144200195.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795018844; l=540;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=6ajIg3GbvuClg/qtVdTEYLWAzhSz+Z3ayKQo+iRL74c=;
 b=6PbpIJ8412yVOsx0JYSMhxS9dPEP070WS3JOgAMd3cHi6rq4eKPzoP/3EmOirOmAt17rpALDI
 8TECwoWUxJMCzUVwAQsPugaOXDbj/UMEQFH7mpXGrwefLN+t9Fcyh9M
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

On Sun, 15 Nov 2026 16:35:08 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> fastboot_block_get_part_info() stores the result of blk_get_dev() in
> *dev_desc but then tests dev_desc, which is the caller's pointer and
> never NULL. If the configured device does not exist, the error is
> missed and part_get_info_by_name() is called with a NULL descriptor.
> 
> Test *dev_desc instead.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
