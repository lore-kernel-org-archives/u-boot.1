Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D071CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBEF8846B1;
	Mon,  8 Jun 2026 10:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NXdyvrXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A640084701; Mon,  8 Jun 2026 10:24:58 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38798466E
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25C4643F6B;
 Mon,  8 Jun 2026 08:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6821F00893;
 Mon,  8 Jun 2026 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780907093;
 bh=aMYS2rY0z0UfUQk7k3oc1qNTTSOSHWV/PoVhtRywEbI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=NXdyvrXMYyyPTXqhqfCyz3brBN0ujW5lNh3IN2qjkd6529a/1eo8HTbpuUm58ElCn
 O1td8gx1qTQmNU2A4bhSjqGjkTGhBG0KrfzxgkdQYBQnvZ59cotunozuTi0waJwKex
 Yp7Ru5CmO4D+0wlKfi1wwbXUMTO6V9O8g557hKenIZQCAenZlniN1JIqz2DVbsTrnq
 w+w6IVB9fw4lP57IE5kGuJ/ayn9GNv29Eh6xCHaQIA0eHTWWMyPIUX8p68Rf7vLHH+
 sGYdc3O2X6lTeoXhkYknR4AWHcHeGREX0cswLcwgBEQ72Bv9tJUTgo+FgdP2RJ0T5E
 B4SXMp+kMgtxQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 08/11] test: Add Args docstrings to img setup functions
In-Reply-To: <20260523085455.750591-9-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-9-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:24:50 +0200
Message-ID: <87tsrdxwvh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> The image-setup functions in test/py/img/ have terse docstrings from
> their original location in test_ut.py
>
> Add an Args block describing the ubman parameter so each function is
> self-documenting.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

