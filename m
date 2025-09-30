Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49E8CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6337483045;
	Tue, 30 Sep 2025 11:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tZZb0ed6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E204834D4; Tue, 30 Sep 2025 11:55:53 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E0A828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7432F409C8;
 Tue, 30 Sep 2025 09:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BDBC4CEF0;
 Tue, 30 Sep 2025 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759226149;
 bh=OxkNk0z5EDzmRJBBrs5vbnfu1vwCVsgxZVYUT9Wipvg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=tZZb0ed6GVEZDno/iG0tl9brpko7b7totmp0bJgrpbb/mCJ3wys2WPfR6yOc5xMS/
 fd4FLlkdM5IL4SivHwbEWBINh6EOkGLE+MMTRiidCyJyCIA98yFoPuCTetlpcx7Dq6
 CN/6DoMxSSCbCm/uzLYdA2ggOv7NUASWKXip0PTQ1SwQ0w/zD6CWRsV88JN1XVdL0k
 38ZVRGpIg6vTTg1lp+/fwqePWUeEAh2Nf1hcVoNt8KjkS38uFBMEZmKG2itb9E8Cgp
 1mvb3y9jO82LkKUmmd2VyfxapaQ9/HJgmI7g/sI993157AD/0uBpJ+XdBxqVCYlwP/
 JSTu/zjZiXSUw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>
In-Reply-To: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
References: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
Subject: Re: [PATCH RESEND] usb: dwc3: Remove redundant test
Message-Id: <175922614719.1440775.9299817809042976398.b4-ty@kernel.org>
Date: Tue, 30 Sep 2025 11:55:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Mon, 29 Sep 2025 10:11:57 +0100, Andrew Goodbody wrote:
> In dwc3_ep0_complete_data there is a test for 'r' being null and the
> code will return at that point if so. After that point 'r' is guaranteed
> to not be null and testing for that is redundant. Remove the test for
> 'r' being non-null.
> 
> This issue was found by Smatch.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: dwc3: Remove redundant test
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8cd4a5e94ba2ab73fde3301d6314549dd5a25cb4

--
Mattijs
