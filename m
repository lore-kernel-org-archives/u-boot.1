Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803ABCD80D5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFD38654A;
	Tue, 10 Oct 2023 15:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kqie0jq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CC98654A; Tue, 10 Oct 2023 15:54:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9ABB805CA
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 15:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rob@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D6634616D1;
 Tue, 10 Oct 2023 13:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4631CC433C9;
 Tue, 10 Oct 2023 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696946070;
 bh=cpr5M03mDBi9QYzoamwhalraoyUpzQ9rzlWPtaN31MI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kqie0jq2vyoogMWRvJAmCpy0XZrj9Id0YaSWZ1cVu9uj2jqa9HjL5/o+RZKnFs+J+
 n1OrbDDi5PUiu3gzfu0qXLRxnf8Q6Zu/qRHVdLk3NEv9O+tgrJke+c8x0iCyKdoQ9i
 i+P13VS1iV9RAAmduOe/MrmxozQOzzchuipQvY7uJo8HjXk0qdnc4gLPMFhKLglKin
 +FPWB30sL+qxyBzwOs8B4qD4dGeKLRBz+QPlL67lHBO8VGroXjMEg48a+YDxyYP+T7
 B1NV5D5a94pZGL2142t6I0ZRLKSJBAWXgAfzTXylQizxTdKH3/L6KsE44EFYcQzrRF
 jHbGiZnC6rPrw==
Received: (nullmailer pid 661704 invoked by uid 1000);
 Tue, 10 Oct 2023 13:54:28 -0000
Date: Tue, 10 Oct 2023 08:54:28 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 Nick Terrell <terrelln@fb.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: mtd: fixed-partitions: Add compression
 property
Message-ID: <169694606700.661639.10236902968461331107.robh@kernel.org>
References: <20230927180545.3522628-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927180545.3522628-1-sjg@chromium.org>
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


On Wed, 27 Sep 2023 12:05:43 -0600, Simon Glass wrote:
> Sometimes the contents of a partition are compressed. Add a property to
> express this and define the algorithm used.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Add an example
> 
> Changes in v3:
> - Just add a compression property for now
> 
> Changes in v2:
> - Use "binman" for compatible instead of "u-boot,binman"
> - Significantly rework the patch
> - Use make dt_binding_check DT_SCHEMA_FILES=Documentation/../partitions
> 
>  .../mtd/partitions/fixed-partitions.yaml      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

