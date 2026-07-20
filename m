Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB3BC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 19:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F59860736;
	Mon, 20 Jul 2026 19:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rc-Dhl2ddEiY; Mon, 20 Jul 2026 19:15:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAE5B606FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784574923;
	bh=OR8xbkw08jSBZQt1JKgwipgvjQvfdHzEZNR8r4EHRuo=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VKiLVRkjyYcc+66if31onJESTWOIvcHMc81SPEfEwwxlSjpj7Yi3u9mXKAPYlB1Q4
	 IrD5147HFybt/epxYJldxaMt5CLN/L2dPDbGpxKHQGK5M1gPdycpOeYf1Z540/TtUQ
	 iMQDM3xKN8kIpyFgoqgG1R0iSTn2s/GyHZ2XSWC9N9p3N3Lf+5v9hTJyyZKNe+K5sW
	 jZb18Lhz+ol+hyX5H5BhPdKlWohpYsfg6X4vbSf3cCRThHNqgAHpCq4aZpy7xnDmzE
	 mAoEfvWbwqM3esroVOhSfsNp/8+CYibX3GH/hG3y9vx9JJiEkvVJjxL3nicHnkoQ1I
	 MPx93ieA700EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAE5B606FA;
	Mon, 20 Jul 2026 19:15:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05FF8DB4
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBC8580AE3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9DATg26oB8WO for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 19:15:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4774780AAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4774780AAE
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4774780AAE
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:15:21 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4a43c2a126fso3931655b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 12:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784574920; x=1785179720;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OR8xbkw08jSBZQt1JKgwipgvjQvfdHzEZNR8r4EHRuo=;
 b=pU/vLONshhPAtp06diyrJp6OhmNLGcgjZqFjGRaaj1w7EHy/k1A5Mv0ctOH00gG4De
 /GQtzYWF+6EOHWD1ZrvR5sNCmGJwHe8W45lt5VkvkQY9voZU5DMjQdYKkoGQMkMGJQVM
 X4IHqDkQLT4WLip6XnO7rfzIE3NkQH1Nf9BWVYcdh/xX6L1wsR8EYSaDMjTHnhMN/lUM
 rcn+P1BWTb+pGvBJWw/IawGJJ8I4cRo5RK30fhaBxpQSNCfOp+Q/TSGFGJjc6TwBw97X
 U1ITKRMTgpmxvFxt803qeK1mNNUIi++7Oz9ienh79X8Ywe88NtBYkly3GxzlN4cMVBY0
 yR3g==
X-Gm-Message-State: AOJu0YyMkPPfunbkxxEGOcDkUJREuW0CJhhYjGtRqmMhprMMNx8+xXYL
 NXm4ud+WxntqsYaJ1Czen47AXDS/eWD+dZmSEBF3lZ47Zs4liC3kvoDt6LEORtl8VxqI4krgxIo
 Odu3qhoc=
X-Gm-Gg: AfdE7cm33Xf/ybbkj8m0uqP9G1tik4V5JhVIEIbORyIbf74iT5+0WzcDuoXi9E03L8L
 nZnp4uEq6Ggg+wuHIYKRTsszihP7+rReg/Po2p4CavD50xKSbul9qIgSLom3Lf3fbHexbsceLkI
 B+umW/mX3NkECXViQ0b58jElUlQh7ftFNIhnan55ezhUl/WCh+xkYWTA1Dc0VdyYiCkk3YjjWrE
 1w8IIAEm9fUyKcAoNhueV3r3SRmQUQHJMdoeuB7Gu23EHwa/xrQsUim5pQnXUzP9+T287MiNX/G
 pJ66Nf+Hm+51BkiTXtusXqkNBFA8qYMs3Z0FQjnXayqHpLwVK0xwXHlRGTdm3JOKIk1Spix41ZW
 m8s94tKMGUICIS8niAwG1/f9liZAhDbUwNpZkX5t7m+hCUMEXYgl2aIs5X+68AOcEZ7GE0b5qzi
 5t32qZ0hjvskdVqIuAhkxAXSAbkPuBNOXTuS73OQnXzhZRFGdy18lVn6oR3PGYCfrHZ8aCrKeBo
 XQkX7ETswWZzNbMpEJQBeNdskMUqADQGGWopkm9JfHf1DB6u/c=
X-Received: by 2002:a05:6808:1811:b0:4a4:c608:508e with SMTP id
 5614622812f47-4a4d039bad2mr10794770b6e.33.1784574920192; 
 Mon, 20 Jul 2026 12:15:20 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3d06e08sm7830651b6e.14.2026.07.20.12.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:15:19 -0700 (PDT)
To: u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>,
 David Lechner <dlechner@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v4 0/3] treewide: migrate to the new mailing-list domain
Date: Mon, 20 Jul 2026 13:14:55 -0600
Message-ID: <178457117584.2414914.7944879479540947779.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784574920; x=1785179720;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OR8xbkw08jSBZQt1JKgwipgvjQvfdHzEZNR8r4EHRuo=;
 b=X3SdZq4uYiQWdGXy3gmqgr19NhGnIzmT3opIXN0Tn+/b7orhgOYZtPa7/06mkNIOw0
 4oCoslK/ZL1wVAN6VXN0ECBClubCDHujfaOHaY1E49ku6EtDSMoiYuWhEzICbv2Wy3iz
 CPkZpzlnyaHJp0EZTP8V/sd20nqeBwbDRor3E=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=X3SdZq4u
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 20 Jul 2026 10:23:28 +0200, Neil Armstrong wrote:

> We are migrating to the new U-Boot mailing-list server hosted by
> OSU-OSL on the new lists.u-boot-project.org domain.
> 
> This changes all references of lists.denx.de in code, comments,
> documentation and MAINTAINERS/README files.
> 
> Please review closely to ensure the transition goes smoothly.
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] tools/patman: Migrate mailing-list to lists.u-boot-project.org
      commit: 6e316df3b7a8706c5be900ad39a4f672aa1d85a6
[2/3] doc: Migrate mailing-list to lists.u-boot-project.org
      commit: 1a5b1ce0722bfca256bf770b32370d4f2373e7e2
[3/3] MAINTAINERS/README: Migrate mailing-list to lists.u-boot-project.org
      commit: 910385cacb8878007da2011bbf8733ee30bab7f9
-- 
Tom

