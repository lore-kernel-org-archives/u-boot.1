Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC583C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A5984C20;
	Thu,  9 Jul 2026 21:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YQdDE5ag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A7284C1F; Thu,  9 Jul 2026 21:15:28 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98EC984B3B
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so345099a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624526; cv=none;
 d=google.com; s=arc-20260327;
 b=RJ7Z9PFq8oSRb2ZENzGjNYMFVKJEftDxoPRmVVkFqOYBEN80FXlXM4sg1b4CwbC9s3
 xItyAA0AXM+3ersEx96SIZh95FAOACVC33KSM6nVPAW4Jkk+DHLPZmqZdNsPNQoKi3af
 De+sn8ljF2I729FrPE0i112g1hUwYtDtt/9uPPbiKYD7sepJDnj5te6sJcLeCi+5OVJu
 pkC0UZhPR31Zpd+UDgcQ3RLCNKYKuQkBVSIfzVjGphEIiEKsF1/YKgKFIIRJLdYhHtAd
 drAu3OCTRn+vo5zEcJxIDlkxZLMavzSJsKi1EMceXho0bUPmMQqhHcTCe59/PXC9KJ7N
 nFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eQXAqFZSpC8vRdB8GYOZ/ssq3mcrhvSNlMKgluKwgb8=;
 fh=cX2a5uS3m9+hU+YaZez7ihgAHbtevX6/NcttqBcYz7Q=;
 b=rnihzU/ol6l8Miqt0jC6AlXQjW03+nZMKKPEB6nDiBzGUD0Q7nEGvZqN4K8sJtu0No
 Ski6tgxCyQa1JP8SnMxR6hXq7km0frO1wyNzyNSqOmUw/4yWXDK/h8Cfb9oTbvmRwGOF
 B9v/BEGFvY+HqCvlRRBDjBQfsrHD5IS9VCEhIUz/NIHmZT1NiOvoZbDikUbrVt3kuwHx
 i+Y/u88HJUAbD7wpEbHBeepbrxLYS6gXTLHM6xndm73y/Fo/Kl2NuqkGqOI7NRzKmIXX
 8Yro0RLk29eMgX7VyLqJZZR5pqK8uuFlqtuo4RyEg5F0tdus7LtH7NCshFyHh8ioWeBE
 Ld+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624526; x=1784229326; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eQXAqFZSpC8vRdB8GYOZ/ssq3mcrhvSNlMKgluKwgb8=;
 b=YQdDE5agx1alMsT4yVfoOvGmL3AraxEbCe+slqSE6AdyRmEn5C2TuCpSqNjftT+MAO
 a4fRhVJE/njQtcjZNtT0S56SaA347WNavladqF+0jrBN/pMCCAuD0ddSBt8kNw9e8bWV
 lbIus/mj6mIHdLlIWOiEgD5Y5by3opZULyCTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624526; x=1784229326;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eQXAqFZSpC8vRdB8GYOZ/ssq3mcrhvSNlMKgluKwgb8=;
 b=IQ0TMkUglc2dLalzzUdWEWCd3YL6Cd5ug+2J2xZuzL5mlmuQlTNIz7CWcmH7cGwUc/
 uQwspJ7jhya8jY6wZwVJfeaCVmurWQ2q2qGhu5jqqhWCDzWBSVOzvkR6rAI5kn3FH130
 AgkK4mZf9Q6ZdDygkWSRCWOHr9T+BKIaWACbCE37MuGo6BUeQpwxiZlGXkltKkyNGko/
 SrFum2Maqw1uPPf1Tp2ZnsHDN2aiSVDQI5eW6VL7a6B+lW+Y3V0cpujXTKD2zCtJn7hu
 jXEHkRpUg2V/k5MG5s0EwwliwiWvVgPQaeZOnUQsGa9hxkDn0AkHQHLo7aImB/ycBEfp
 9QsQ==
X-Gm-Message-State: AOJu0YzQ23kBzGH6JRZkEcaa9cPq7HXxHH+0qC5e6Ij0Yi367D1j5FI4
 06Znzgx1awp92ylal0VErxtLJPlj0LpJeUmhhdlTWNy/HRbKFyvIHMobO7nDSoE3oXEdBaDWTl9
 FNqLbBGNEE55qIDAYU411v4G0twKkdTA1ChXmjvlowzMDsiJ1THhSlg==
X-Gm-Gg: AfdE7cknOKtfpkV5BkiXYLhScW3ce5bWOxSzhdJzAHCMuhXHABJQV2PCx9tc5dpfZd7
 lOdVdW5f9RDYXawfgyvN8Hx9RVqcjJxaaX89hD0FYn3ZBZZVP0A4p+VRTCyFxCqJg+VUBXJ6v9q
 CTCU0FXSpgea+Yiq8Q6tAvnhsYXy6eXeCyPmTrxsKYhoWQp/5ofKXPQ5mvhgCiAuRNmgy2OhMMA
 U3RKQ/lXfcFkojz1MaHmtKR2oH1Grc7aI2xw212Z3F1Xq+zOsS7Nc53EUWUGWxsDiDyA2E=
X-Received: by 2002:a05:6402:388d:b0:69a:aa19:9df with SMTP id
 4fb4d7f45d1cf-69ab44af54cmr3683731a12.32.1783624526123; Thu, 09 Jul 2026
 12:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
 <20260703-dm-core-v1-2-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-2-076d395bded4@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:15:06 -0600
X-Gm-Features: AUfX_mzF4JvRLBrF-PjvSResXIVAC-BZoHx2eIXS-_GKeq_6zY2J54NMWA0k1oE
Message-ID: <CAFLszTiDS07b+mxCiGLJBPGUn_oQCLYApsgRMu_UDczL0HDBKw@mail.gmail.com>
Subject: Re: [PATCH 2/4] dm: core: fix wrong strlen check in of_add_subnode
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-07-03T09:11:23, Peng Fan <peng.fan@oss.nxp.com> wrote:
> dm: core: fix wrong strlen check in of_add_subnode
>
> The duplicate-name check uses strlen on the search name instead of the
> child name, so a child named 'trevor' would falsely match a search
> for 'trev'. Fix by checking strlen of child->name.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Rapha=C3=ABl Gallais-Pou <raphael.gallais-pou@foss.st.com>
>
> drivers/core/of_access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
