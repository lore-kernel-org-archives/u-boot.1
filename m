Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14E606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BW8r1HPc;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OypMbb+W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70EE3811D4;
	Wed, 18 Nov 2026 13:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHm9zgyBkyy7; Wed, 18 Nov 2026 13:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 586B0811B1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007730;
	b=RwihiD/M+JShI8HcDNBIdlj1R3lyPPbv0H9XLtwkV2lXjQTinyT5paSiwAiKwzjlR74c
	 PuyTzw/q1k+utwdniRcwN9/m4D67p3bDFUmTIOk3mq11QEL7Eg4BwkWbORQwbsMsutkpN
	 8Hrwz1HPsOPxkTFKWGV5tvoUb2nZHuqBI1gkVhmt5eMFvlVt9Vt2x0oP7nZvuM2a4v6Kn
	 0qtqhMFYNDUW/l5xqu1YvY/BcEaEsZdt5AUi4LGQdSYhcIGFE29uWk+XncLCoGOen4PFr
	 7GI0aVfrqLIryOOHhLc3hSAldVwQrnIH3NYkE7N8Tlis1GwiOuDNtJMDTmc1GcqItqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007730;
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
	bh=2JQSr8Je2KNqG9wPJWU2+9sDzS6SL9sB6BFZYpj5Ys0=;
	b=RcIltBRiKGt5GuZIH4Aoc3rAR6ZnSSsVzeCsg9W+yHZ2pMbUzQSzjq0skiKgTcY7gUMt
	 fU1ojbthSDcFLpiXEqE7CRxy7QkqfgsH3qrhljJ3Faw61p7qzlsRBsq2aHOyYXC4ZNsSg
	 cYf/B3lwo0rNY0as63AvRm63Lhu8A3RpIV0dbDNpNvxvfxy42Gg2OqPFfADR6laFtfsUQ
	 M12eimgQ61l7CC4iqlwWnq1jk4ogS8ZoIprFbSl9lmReM03QbDIJipf+d6xNcaypGDzUb
	 mh50/bhnH325p+uhRFXqOAwgSNdhjjD1gJWFF8l2QiJzGXLZSD36iuq8oG/H3g+lUjg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007730;
	bh=2JQSr8Je2KNqG9wPJWU2+9sDzS6SL9sB6BFZYpj5Ys0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BW8r1HPcW5iBKXPoYhbBMAQ7UPJemcJL4t4arrb4+U9anwTs3r+vAZdPjgy3GWsWX
	 pP7fsD5t3z4O3OzNYfARdnZihcb41xkwgBKSenkSI7gZvyYE9W0+o8jpIqzmOh0ofY
	 pBPA/C44QJe4pPZE2RU32tKVgp3onCe/ugKBjsYH+34uZU0W1LmtdH28aStZuQzAkQ
	 aWjnBNlKaCeppKLNg23qYp3RJ+faOkmYk+nmAH+z/IP82Di2YuuJB2qL06TQddupRO
	 86xhYl5lYRmd2d1p5F2LE1DrCx9hj2ew6gWFVFW4hWCgLceJ86bzvs9CcfZc76bqIt
	 Qkij9pAnK2roQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 586B0811B1;
	Wed, 18 Nov 2026 13:15:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B8FCA0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 180464089D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:15:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AV3JE9-OAwX for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:15:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C84640895
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OypMbb+W
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C84640895
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:15:27 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so479698f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795007726; x=1795612526;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2JQSr8Je2KNqG9wPJWU2+9sDzS6SL9sB6BFZYpj5Ys0=;
 b=OypMbb+WKWMN7BouxyZd9h26YcOlzGz5PGaA6BtENgFBMSJG4rjn5Zk3F6UhD6J+k2
 /21XnnyNIkKxy+k6v94eSVfCMc1QbTLvQZ+hSpwjneIEQi9O5tyrBZ3H/V+cX0MCvsjv
 MT80GtL4gUZxg8BnjdA/d4Dih/LKx71rAfRvvNXjeEXJ/FiZdyrbZVtSBcvJIWkDuDvw
 ec908x1RCp7gkT0XUvHWHfrp2t3rCKnf/FQMSfatg/m+NXYjVj8sF3VvaxdmQ52DWHZ+
 65fljKxJWkR2f8SsELskTuus9JqurqVejUkZKzOGdtwgOIZFR2WCLYfOAy7MNZ9A2wIA
 9q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007726; x=1795612526;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2JQSr8Je2KNqG9wPJWU2+9sDzS6SL9sB6BFZYpj5Ys0=;
 b=YuNBHiuSDjI6PmYJWGUTRTrR1/u770qS8S+Ah15a23ay9kTjtU60wtIF+8T0EEDyAt
 Qfh+pVW5r1P9HSunoFHuDZAmK6/Z459okJENiwsegOGAiOjIPuG2tAXeis7YUU3ILNmP
 5eJ2sRCScNvq88Yf4YG0AP4s9EiE19jaJY0QbDFyXZcmxMKjF2u4zHyWcbmn7nte4owx
 rzy/Lx41N2tXJdFuLthRsxpfPOaxAX8ZTfW/yu2i6FN/z+ADCgPdsF6wgeK82aP1HdbL
 Ml6DuQeQGth62gtHn77U6e0EIrICyziWtfY9kPBwFpWbFQxYoK7gEolV7b6mP3SZYPKX
 uDYg==
X-Forwarded-Encrypted: i=1;
 AL+hErGMIQnPZQ8L2Y5eeErdB1WA18edhGXkpIRVZ4ObztRg867HGk3LVOeSdw5th/zu6tWiWBcZh1M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+rryi73cpchiiJVGMpqaKecWN/saP1DgMmtLraL58N4xt5/MbV
 Ndu7uLaKJ5ngx/46VzE/YWFU/B2UN+7LO5kgFUVZw4K6oC+8qV4RKNg4GazHBAVWxsQ=
X-Gm-Gg: AZFdTZc4I80tlaZXiQ1XC0lmYX4xnll/qCRlKsSHPao46xzKfGpWYhmdRTf/H+obyzL
 IduQzloaX/sFqDbRFZGPsPLJNEUPsgL47YqWSIpozpE9aoorvdTOFhbqlcgwZTS/TG++DvmOLGl
 5/kpEMnb2nhZBhNzZZ9xOel/1xA6DwUIRW6L33RPtoiylQUgIABTzIqCIlxz08Ov/LVYwcJePa2
 IlQ++sXDs03AJs3aOon0KAcgY91Z45GCElBCngYhZAZxpQ1kdC08ds6/chrAeDloFc883tt6aSs
 Zr+P1KLFkiRTZR2uNDBz2wafwbWntQKxhso6ilMZdDsKJypIPdFXwqqDV4VPOq33lDX4HgZssXW
 t/m+jBDChAlTvthVXzsHzvmjhcvDXtaZdKmtVGTy/I3r4NuLJH91MSCYIefqxqtXiqu/Ga+5YYn
 cHmKVvPeuGIEncrwK/2RPNmhmSj9isrn+2XL4bJDjuvAbA9jJHTc+Hm4wZu6D6hLg0d4bXvbH/o
 +PvHw9pEPr+RhaMgnab56tOPrzb+mquRw93qFM1YUum0E69cC/mYI9dzwXYLKKOb85yLSUIiKyY
 J/vyxJP0N4/E6zDyWHbgmEw2HPR3qwYR7FmCPY2SFUlUSW5nBn8=
X-Received: by 2002:a05:6000:258a:b0:48c:5304:5e50 with SMTP id
 ffacd0b85a97d-4a62d6d7305mr5731031f8f.0.1795007725681; 
 Wed, 18 Nov 2026 05:15:25 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4691305f8f.18.2026.11.18.05.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:15:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fastboot: spi_flash: fix getvar partition-size of raw
 partitions
From: Guillaume La Roque <glaroque@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261117-fastboot-spi-flash-blksz-v1-1-17965dcd19e1@baylibre.com>
References: <20261117-fastboot-spi-flash-blksz-v1-1-17965dcd19e1@baylibre.com>
Date: Wed, 18 Nov 2026 14:15:21 +0100
Message-Id: <179500772115.763411.8817762815229506674.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007725; l=389;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=pfSbHSu+5N1oMP1U/CDOg1hAQ9ohM62nSwES6m8Q8r4=;
 b=g1rSvOci2QBQU6GbAuiPtUqAz+HvSzyfb25QxPfBp5tisW7pudaf20ch52YC7nF4DLerwuX3H
 oeTb1tOWjrZCjkPsqg9ggo6VGJuK0AlfvEuBDJ/Q23m5sis98Lw1vcO
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 18:21:43 -0600, David Lechner <dlechner@baylibre.com> wrote:
> Set the block size of a raw SPI flash partition to one byte, the unit
> its offset and size are given in, so that getvar partition-size does not
> multiply the size by an uninitialized value.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
