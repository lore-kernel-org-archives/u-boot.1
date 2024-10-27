Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D92BD1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1760089079;
	Sun, 27 Oct 2024 17:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BNbx8xiL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qWj97fCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4562989057; Sun, 27 Oct 2024 17:32:07 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A6888E78
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Xc29F5YvFz9sjc;
 Sun, 27 Oct 2024 17:32:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgglfI6WqvK8x6gxGZC02YXlDuP50Q/241fkn4+wMtk=;
 b=BNbx8xiLuxe3ou1nwI/Ga1wbDjtpEDFhH9/yktx48QAX+5Nmat+kkTJu7KlXtbcixvTBoa
 Mx74I2s1dcSh8D8LxfrGn+GZ6YQKI/f7A6Snv+B+WKiLpCKmuHzfQ1ca3HdMA20Wz/73mg
 nr+czIHOduoODTdYx+RZVsvHARIZxyOCTlYPq6AyJ1gMLurzZFQjZjxuFZXU+8KQPnbQBm
 apXpu0p9HqgEmTQ1OyO6WP5Hm5e6FNdDP5SooqNQcRS2Uw/aIVkg7clOil4GzjZZx1QgXz
 XaYWjQjNMNx54PQFPs6TTNcTmKATFEnrV/uQtFVio4zGAoilIS/cqR7w5BTMyA==
Message-ID: <d88f090e-90cf-4b3d-9aa5-f9b211e74bfe@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgglfI6WqvK8x6gxGZC02YXlDuP50Q/241fkn4+wMtk=;
 b=qWj97fCxWav7KHgfYzxBq4F0D9KeEqwdv7FfkLhLfjSGDZvxq9oq+hDqVXYyId6BCU5NSQ
 j2vfVoDSB5eGrzZZ0aoP4G3iU+vQxeRIFNORMNEt5s+2gjgJljqZBNQRXWt0IW6qSoQX53
 AiQggj9QcyC+auk4Br6tOSbL8IzDeLawKxrosFYhCIHae/7YSCOHITgK5y79YAYZLYYYPy
 DrMGpuCotQm+IoT4jzKD5S0HY397prCSQI0sQKibT3dC+auOcvlNHPHkkuCXK/d6sDwBwd
 o+E7D+RMN7Kt5d1ZL4q+ZNCXaT4uE38z8PY90vIjtwCyndsIouswC13KP1FjxQ==
Date: Sun, 27 Oct 2024 17:16:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 04/14] pinctrl: rzg2l: Drop unnecessary scope
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-5-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: eg7sbipkd1sbd9bmpe96uqgp557z35me
X-MBO-RS-ID: 02991a856ade00e0ac1
X-Rspamd-Queue-Id: 4Xc29F5YvFz9sjc
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> In rzg2l_pinconf_set(), there are no new variables defined in the case
> statement for PIN_CONFIG_INPUT_ENABLE so no additional scope is needed.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

btw. it might make sense to split the series per subsystem so it can go 
in piece by piece.
