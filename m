Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EB2D49780
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A8B8914D;
	Sun,  1 Dec 2024 19:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MRgQ0EKu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UDB3/XSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F31D893D2; Sun,  1 Dec 2024 19:59:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B98C89442
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 19:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y1bmj0GfCz9t2g;
 Sun,  1 Dec 2024 19:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfOrKLi7ixYhMYjXRzM9Dk53gris+oVGvKXGh+1diAg=;
 b=MRgQ0EKuLGGLqZ9Gv6PSmROLYLC5+uDjnrxj+mAPQ2qwHt12w5POS+y4UsUDHzRPm0o8d6
 6OyiDaVfaFGw69+0kml/geA+znZb+470gpFQ68IU8if57fVkw/pzDIgEmZs+VOsedx5VWp
 v9/sXI1xdr7j7Non8pjLxtB9diaeiWpT6AAN6tDzkMoQeC2vKhKXZAQJOUvi8Pp2TG//Nc
 fOsYSv1BKj6Dk2U+SrP9pUQgHFWtKKxGJRiFiZgGYA6UrwU+yshvXJoguuO8SjvHlIUDsW
 ygxsAlQH9wc5BJ7fbDL8+BbLqdHGJK5YAvwym9XjNIW1eczLR6NW/IbqSZdphg==
Message-ID: <86a68f71-86d5-48d1-a67d-1bb253b7f4b5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfOrKLi7ixYhMYjXRzM9Dk53gris+oVGvKXGh+1diAg=;
 b=UDB3/XSlrktVHCl6URws8G9gqpCEtOkh4EjvL6pGDkDkBcrpxEpU/UDkzupgnBSsc0/2Cj
 ZXcwTe5YXgKOmRGyVRlMlmkv4xUQNDAEGoKy0q4dOh1FpA9ivuLRtZH9P1CkxcmtHM1OhJ
 zLlKpPpcUJu+if73Id5S3mOrTCn/NxOLQ/VLBq2OZZoAzumSzGC8/B2kII8OmW1PMfs5vF
 1xTviCjM3K0d3cNpgF+98TAE3M3RQ3upoqgQE88kRoFDfRIyf40Oh88LqDaTxPV0ObUd5r
 7+AZJHZHNbW9uMVq3HwCqZsUe/lv8/PQA/1X+dk3v5F94tHMtr5BI9gsXRu7Bw==
Date: Sun, 1 Dec 2024 19:58:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] net: phy: ksz90x1: Simplify
 ksz9131_config_rgmii_delay
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
 <20241120094903.94-4-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241120094903.94-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f2420fce41e8a67efab
X-MBO-RS-META: dtbq6rymui3375etqwqzai5bg6swqnxf
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

On 11/20/24 10:49 AM, Paul Barker wrote:
> We can call phy_modify_mmd() instead of manually calling drv->readext()
> and drv->writeext().
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
