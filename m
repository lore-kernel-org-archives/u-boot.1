Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B62DC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 21:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D9E84ABC;
	Mon, 29 Jun 2026 23:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2MT9R/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E5784AAE; Mon, 29 Jun 2026 23:34:48 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8615484671
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-489f0c807c5so2513407b6e.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782768885; x=1783373685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v8UHKnDief3iwvPLmBs4xPywEDPblWgPnhBu7qYbag=;
 b=I2MT9R/Xuco6p1e7mf3XRhA6f9mZYzLKRuEKF/R8qn7DTTOyGWtYs/VIMztl7XNDJ7
 qEFK5C7q7O3kxx+cqsszGiktSNRhKHduOVub6anvLCaEt04lTYf7Qex2brnV1vZEpteS
 vWqsVrp/QV0zUPNyEhj2jxs8Fms/OQOOrLLeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782768885; x=1783373685;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9v8UHKnDief3iwvPLmBs4xPywEDPblWgPnhBu7qYbag=;
 b=W7Si7fQ1ekfj7l6GOw+boXvQi3Fsm0eBf8vln2nfkZ/JHVVeFwLQHknbne9Wt4sGCe
 l9Zt1rs1xujvV+Hxt+pNWqsw2dG20tpMSM/d5hA23fQMT2byEB7RA42rV/5ycgIXxVhd
 melIUl6rd9mUESm+6UBWCG6S9fVYoVDjcxnEZ/usT7PdNDvgIYpgw8LYEXCt6iEAm22b
 nnVwSdgzPo5zxsXG7d1vgNZ2MWh1dyz/VI6e3ShRaFPpQib9/vrS9f9PMb2/7+jXw9uY
 42zJfHD7Rd4PKpt+FyzVFYflnfiESNXAjtg51d4dn6A5lRKpyfWGVzXk0mHq/WDqPdFN
 ilBw==
X-Gm-Message-State: AOJu0Yx/+1EG1Qcdu3D3wZiVKYJPdQeyIreFr/p8VKiHnaodN02RaOwc
 5qGQNV+yApxgou0XiW5xXeCqY7Q6KIiBhb4MHpNpe3EKoFyDD+hwnWmxtUtPyz0oITk=
X-Gm-Gg: AfdE7cn3YsDO/nHhQ8/aYU2gccjp+5+CHqz1XrXWJjhxFbkY7RMSQdYd39ApNF3QYzd
 l1wVRIiEx1m3KDhaiAdJY4kCSJ1BGqW0IpYkOD74wTO9vemXA8+Gss9Id8gxJddYZwmGcqUbESf
 Nan1gGWWPXW44adKqAD13nH5caAtTzQnKT1pEtzsYmKrvIGGjM/Rmlbx+Y87UzkT11fOCbBLsHh
 m5WluxDTybOarv9lkB/oL0L3GNNt0LVsR90l1j9dugz4Ifp5dOFHMyRKULxB30Lbe4YU1U0SvKQ
 sxte+f/PQ8lzWXlPfsFiMFq3zhQkv2Fr6lJz0QD+JDH0evDjNJXF8fQzb8wSEwPa3JD1IVgcqZ3
 6RvBv8cXJ/o5Yfdk0z/r/MFTRcEi8zDutGJp+vQOmonMtD91gYmwYahbPihEjn/DK9htAMHvA+t
 bYHWtVXVh68mZXEkZ0+ELBrrRH3IdKb4MRqNjo751JL8vjd8REiQN51axJgHWHg767hkR/bnxHx
 v98rO0/4OQZwB6esjR6m7dZxoZ1L6lffi5MgN7CyAbaWnaVvA==
X-Received: by 2002:a05:6808:3847:b0:492:285c:4da3 with SMTP id
 5614622812f47-495eb91d9afmr767361b6e.21.1782768885311; 
 Mon, 29 Jun 2026 14:34:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-494c3766f3esm5454697b6e.8.2026.06.29.14.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:34:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260612015932.283341-1-marek.vasut+renesas@mailbox.org>
References: <20260612015932.283341-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] cros_ec: Convert dm_cros_ec_get_ops into an inline
 function and constify dm_cros_ec_ops
Message-Id: <178276888420.793204.12975631483576003231.b4-ty@konsulko.com>
Date: Mon, 29 Jun 2026 15:34:44 -0600
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

On Fri, 12 Jun 2026 03:59:06 +0200, Marek Vasut wrote:

> Convert dm_cros_ec_get_ops into an inline function to improve compiler
> code coverage, and constify struct dm_cros_ec_ops in a few places.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cros_ec: Convert dm_cros_ec_get_ops into an inline function and constify dm_cros_ec_ops
      commit: 4a0990218aa9185c2ccd7986dc1ad14b24aaaa9d
-- 
Tom


