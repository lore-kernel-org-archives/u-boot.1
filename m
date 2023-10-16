Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8429CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8006686FA2;
	Mon, 16 Oct 2023 11:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZmUG2+xx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBB386FA2; Mon, 16 Oct 2023 11:28:53 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B29386E03
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63B2E2000A;
 Mon, 16 Oct 2023 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697448521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cB9YyJFPekauMqmT5IAfFQ+DrU/FcfXGDjW4V8YqQOQ=;
 b=ZmUG2+xx/8stKeIvalFYCjLGa0Vx4XxQo+/vbnIEaF4Nzqkq22FzfVZmpnt+OrwOkiV1QJ
 C24m9desM9hQpy+4l0VxMvxZjQFcmFO3tPOAQql+AOGWznNldzthNENtHf6aqUmn5lvTzl
 l/Z8sgAlWza+RiV5TaqDdAtp8wBUreQ9hfgmv2TTT5NHtN3ASy4TFuAKLgODrAuaTAhoz0
 eiStWnLxYCrGxKxyJ2HmbKNfA5UYOGLV+TxZ/40uWu+HtQLaiVBYtd5vR78BKpNkCGr4fI
 QuapSCnWa7Zh2GE85q1Gka7v0rLX3F8gYCxK+GDo2iPcwJXmnp4FvL8pAmUJDg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>,
	devicetree@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 U-Boot Mailing List <u-boot@lists.denx.de>, Rob Herring <robh@kernel.org>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Nick Terrell <terrelln@fb.com>,
 =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mtd: fixed-partitions: Add compression
 property
Date: Mon, 16 Oct 2023 11:28:36 +0200
Message-Id: <20231016092836.288939-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927180545.3522628-1-sjg@chromium.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8baba8d52ff5081e8c3c383132af269ba8e2f458'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

On Wed, 2023-09-27 at 18:05:43 UTC, Simon Glass wrote:
> Sometimes the contents of a partition are compressed. Add a property to
> express this and define the algorithm used.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
