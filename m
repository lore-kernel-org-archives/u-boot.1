Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2F9CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 484A98493F;
	Tue, 19 May 2026 18:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="BuzJx+UW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCD684942; Tue, 19 May 2026 18:34:32 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71F5D8490A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vDDYgCqJV0X7w7aPoNAY/0LR8i/cFjBHwPAe7uB5wC4=; b=BuzJx+UW92XwxmF5KUf/iiKLtz
 9gEF46Z+MxkbuowpaPrkgc7vhQYsxqrAZeu2X4KuXL9qu+rYfcwbKIIU1mlqAplBDUwjoB2YvFsNY
 5wpxwEbGZSTM0hXFGugAE1P3UBMDIcOvwuSU1NmeYPtiovSXF/djUMekSM8Fh0nmFnWQBaqmi1WnF
 OAf2xutaZJNfG0m8b9DpsF66RH1ddXCzY4XrStaENNVlMf/TS8JhV3ARfFCDkbkEwwFAAl7mXDTXg
 v4/wCFyauoAUSXr2kK4mTWa7pFqFlpNqAhBrQy75b/AWgfGazrQQotFBTHE0Jy0xccOIe/J+pHeCp
 NRxxZ9og==;
Received: from [81.57.40.39] (port=52252 helo=superkali.me)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPNOp-00000001v6q-224F; Tue, 19 May 2026 18:34:30 +0200
From: Daniele Briguglio <hello@superkali.me>
To: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 1/2] clk: add gated-fixed-clock driver
Date: Tue, 19 May 2026 18:34:29 +0200
Message-ID: <20260519163429.1296229-1-hello@superkali.me>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <fe4af92b-ccfa-412e-8786-efc34f575ff3@baylibre.com>
References: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-0-738b67857cac@superkali.me>
 <20260519-rock-5-itx-pcie-refclk-dtsi-v2-1-738b67857cac@superkali.me>
 <fe4af92b-ccfa-412e-8786-efc34f575ff3@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

On 5/19/26 4:09 PM, David Lechner wrote:
> It seems a bit odd to use regulator_set_enable_if_allowed()
> since the point of the binding is to provide a clock that
> is gated by a regulator. Why would someone use this binding
> with a regulator that can't be enabled/disabled?

Hi David, Jonas,

Two concrete data points for the choice in this driver, on top of the general pattern Jonas mentioned:

- pcie_dw_rockchip, the consumer that will drive this clock on rock-5-itx, uses regulator_set_enable_if_allowed() itself for its own vpcie3v3 supply, so the gated-fixed-clock driver runs the exact same code path through the regulator core.

- vcc3v3_mkey on rock-5-itx is currently marked regulator-always-on in the u-boot dtsi, so the strict variant would surface -EACCES on every probe.

Thanks for the review.

Daniele
