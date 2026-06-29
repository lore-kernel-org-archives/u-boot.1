Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CA0C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 21:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2DA84AC1;
	Mon, 29 Jun 2026 23:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZcGNaJGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579DC84671; Mon, 29 Jun 2026 23:34:49 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44FA584AA2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4876d5335b2so2527560b6e.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782768886; x=1783373686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRBLUsNWOG6ta0GdDMLkMpursJB5tQJSWn2FzWxEJWw=;
 b=ZcGNaJGXow1kvcYSpA8MgIj4b1KOGrLPKcmIsgm96SVKyGzgHP4uz+7pkrsHip2bqt
 xwEl2Gd/rF2zadMAhty13j+Q6pcSkGP8b3c52Gc2f6a+wRTGKwOd2/PCLjiYioOZ5h4c
 K0jj0mW/FRIyOlN/RcE1AsSH4b5L4W0shugvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782768886; x=1783373686;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oRBLUsNWOG6ta0GdDMLkMpursJB5tQJSWn2FzWxEJWw=;
 b=kvrfpg/ianNCYFAhVpc+A2pYICYyVrPNng0n1ICNJ6eYsiO/ccL1EUr6ftpOX95qrA
 4qpHPydmdQAl9UqVV5bH96FzCqmKdNAzXDSdH/q6Y6I1Rz8IDOwx5VFbIKGgqsgLt79R
 6r7BUceN46SgdNe+cBigmX6NCDkboxRNPaWoTLDmq6UkAOcZgg5i0KYjisZ4uqs+J2R0
 8txA3MHZ1XuF6BD+z93tgSOvzQ1W6qgsqYk8gL65NuEJeejA+x0EjwQRd79gidJDuMAh
 A21Y+owL5vwEaX0KfQ8+DfMgWzum60+DtaRNsMUjfdAVIB5bKqZRmnq7Np7aEfrjVdE1
 xCXA==
X-Gm-Message-State: AOJu0Yx6vTYZ4HZvXdk+97J1UF+YxoAXIRjQbsPdD3HCCs6ZNsleNkxi
 I1ywYv9rVeJDPCCe72r1y8m9CSPQ1AbCgxP/4LX1aIzo+EUbpZw/MVVvUpnYp2vlfW8=
X-Gm-Gg: AfdE7cniGBxv3/g/0y3uDBnzLeWZ0pnsrU/lRKURkJrkMV5TfDLldnZp5nilvqtrdit
 o9JVpYusibi34+um8wXnJxebp6ABRBMMFVpMIcWu0KUbZheMcAnfxdnVk/7W0op+FPkgh4kLOws
 Iutqrp4S1N/CuLmvh5a8tgyuWBYIO/rOnpMaRyFVBOR5hDuAmdPN8enHhxocPE7i3OrVtciz+Ay
 hm0Lvh5Z3E8VphH62MXHnmmtJpYp1vHnQTOTDNld/O/6QvwmrhxTDl/gx4W64xAIgjf7ROTHbkd
 TBQJoWy0mt2FZkdrDWVsEXucnJvItsIKXwuSPNF5VeDk9Zm/vOjvK4hlUVuSYBE0F7S2OcWSK1s
 86h8oX6smeAjjP1U0qCz7kLDSCdLWwKkgvWDMDPWw94Gy1DLPYMIMpaX0EmN+Tmje5hPzyffom/
 R+w8urznSt4NQ+QiyoKTh8f2xHG7ndG7O4A60niDG1QiiSY3Jw7ZZmCUqHDeP0QPDhZbLhOtMzs
 g7U8tkPGipuzmhCNx/xarnnXHczE5XJPYvIuCc=
X-Received: by 2002:a05:6808:150e:b0:48a:7577:3f37 with SMTP id
 5614622812f47-495ead82e89mr1013259b6e.11.1782768885998; 
 Mon, 29 Jun 2026 14:34:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-494c3766f3esm5454697b6e.8.2026.06.29.14.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:34:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260612020606.284001-1-marek.vasut+renesas@mailbox.org>
References: <20260612020606.284001-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] treewide: Staticize and constify acpi ops
Message-Id: <178276888543.793204.80491307804138299.b4-ty@konsulko.com>
Date: Mon, 29 Jun 2026 15:34:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 12 Jun 2026 04:05:38 +0200, Marek Vasut wrote:

> Set the acpi_ops structure as static const where applicable. The
> The structure is not accessible from outside of drivers and is not
> going to be modified at runtime. The structure may be unused in a
> couple of drivers depending on their configuration, mark those
> sites with __maybe_unused .
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] treewide: Staticize and constify acpi ops
      commit: d5046398433e48e7b0b664c1ee3e4e2af6f861a8
-- 
Tom


