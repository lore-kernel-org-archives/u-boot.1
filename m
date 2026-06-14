Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1AACD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94F983EEF;
	Sun, 14 Jun 2026 14:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VqC0mX49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA19D8466E; Sun, 14 Jun 2026 14:16:54 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 906FE800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c85825bbc4fso1509344a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781439411; cv=none;
 d=google.com; s=arc-20240605;
 b=gtudqJnk7dVexixHCSDJA//SV6ZgPDqIr/Kv9Sl10P9rziUOJzpyhlWnReKiRB6I31
 xZfdIr30JAThcL/q+i788IfNX6FqDmnJfzU6OnZkMZWeKlqvJf3SWwQuBHpNPRnaTKu8
 DHIcHQwND6mQxdJWmvg2axbBP3q8/2fLH4dY6cp+eCMROE51KPoM1ltupCDhjxURSPPD
 Wx7sdJSgN/Qi9t9PxcWkIBiOdHPP4gGOzjTkNUG2LaofivzpBQOBnxPuqQnctbA9Ue7h
 wPvxcoHOR/hmL0QmGc2/9dSe7x6Z9jtFZb4fK8xQYVvTwz1MJCDyFddJnqSJaKqnzif0
 VfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r8jMmwHPkXA6Dm+18qcrh0hACSmMI0JvXBYzKXjbBjo=;
 fh=wQ7Vo7TLGcUv367K8AhgiyoA7QlooXfrljZKfVA5kQk=;
 b=aRTiF90OJgeT17uAjiGZiSfUpuGhjmjBaH8nolsRuAztUjWakCi+MRiGWYWbLVZCnD
 N0qwt/3k9tT+4mtmhkL2O6hVwEvKpNYbPCvY/gjwsRLdImJ7BDejkL3/ROrs3SDruium
 3wNwB9E7Si8B7V6ky8mCQAZGURkduM2x4Ubk8gV/dsNAJsUJEqD3kLGTOlvY4fMaeCyH
 ywvNm5h52iVGsieYhrUMToa/p3zlYQpjEk+OokCygTACJXsDkkhGR2eMY1w/8w1En/OY
 n/PWDnryQ6tOEr/ukJ4347A2N+moH61KQPPHyESX0oPzEmwULiGFHhoTUELTCiGMid6a
 NMpw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781439411; x=1782044211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r8jMmwHPkXA6Dm+18qcrh0hACSmMI0JvXBYzKXjbBjo=;
 b=VqC0mX4947dZ+KfgZpvUWWLiwqo41H/aHupOLhQwukDLNUT+amAD5YyZo0QR2gwcLi
 qwKofGuvDyhM+A56ObMvhk860JCwDsOyy0mWhz5/y49fNJ3e3eass0mYjAPUHY7l2pBk
 Rs3yILg77LWbD8oRWQVpeOPkxy2rPo9qkTqBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781439411; x=1782044211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8jMmwHPkXA6Dm+18qcrh0hACSmMI0JvXBYzKXjbBjo=;
 b=q3NzIPr5Jl5/vkl6n9K2PHRspGo4g0hUky4NH3DN62+FmA7iE4D7Od9Qqs5T7TnNo+
 6c3RDoimtWY//FLZocsnKk/zNl86VaihTv9jznbblDFCokbwmzIbOkjBgb/VOVq+dxNV
 gudzNg6NNPZzz1LwV8FUridQVvojMhcNA9OXAfkjSC4pXqz/wqA4ql3BQ6qcjG+C4hK4
 ojB0GcVYJmwyckw9Dw20vZ+Y5I1IROLsoEQZmFSn3efy6KtZsc4lIHK5pUwtABgD0sIl
 SCZiIx0DE9uH7kVAPPnCUa4j3pyg02AG7JdC0z/Sbb+XDa5O6Z/e8zaNsX4qYaQM+nA5
 fVfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zGspoxoFKT6uGtpuFmrsTPYi42S1DWdRwhZyLtGhbdch7W18L2gY4EY76c3CCLX6h5cV2BxU=@lists.denx.de
X-Gm-Message-State: AOJu0YzrGWvccI0ZdpCJzpYIm3IiNOzA3DUKpx4r/o7YsPTYqtiiy8sJ
 ZNlFaUgXrtq61/HWYbJHf2Hf2YOOdBKwtYJNihkjo4uO7pYG4lF+RAfHpmXW68/gwd5eb4pYLc9
 h2fmlLkMnYzN1oiPJvMdyBCTGnVqkzVI3FzYHgSEeJcTZft3y08VJug==
X-Gm-Gg: Acq92OGkh3CCHxEsRUBUmXMQ1fc80qKD0QVP6izAgXcrYwBvS06VYI3ubav1azSEBrg
 1PDpBVBIMfPw5x3UMrf2ijzs8rw6UET5hFBbQ9hD4fRQ8WXE7yZqqXKvqqkkc0aXlWIMmgwX0sD
 y2sEkuonucHE+cNpX5U8lTrioUdKTXPf3b9x23rLijCWgrugpXxFKfcpVIq5elhq4kLN6ldcTid
 0Veb1UCS2TqIxzcJAG2wmvNy/54n7Yjto/FcNtWNJ+G3SoExJeBz7jfUuxc6kTEinGNVYo/WQMG
 xMepxQ==
X-Received: by 2002:a05:6a00:1404:b0:836:3f6a:3e77 with SMTP id
 d2e1a72fcca58-8434cd4b0abmr10277476b3a.17.1781439410982; Sun, 14 Jun 2026
 05:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
 <20260610-ip_defrag-v2-2-060f6eeaeaa1@nokia.com>
In-Reply-To: <20260610-ip_defrag-v2-2-060f6eeaeaa1@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:16:31 -0600
X-Gm-Features: AVVi8CcLVaon8TVFmRrNHWLp806mgSBCyr1TtPC3hPpZQntiG7zFjVy_XkpL6KY
Message-ID: <CAFLszTiiBtrthYHEAeppEqUoksW3fv7j9UNmztPOVd0MVCV8Mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: net: add IP defragmentation
 duplicate-fragment regression test
To: mateusz.furdyna@nokia.com
Cc: Ben Warren <biggerbadderben@gmail.com>,
 Alessandro Rubini <rubini-list@gnudd.com>, 
 u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Mariusz Madej <mariusz.madej@nokia.com>, 
 Mikko Heinonen <mikko.heinonen@nokia.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alessandro Rubini <rubini@gnudd.com>, Simon Glass <sjg@chromium.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mateusz,

On 2026-06-10T14:25:33, Mateusz Furdyna <mateusz.furdyna@nokia.com> wrote:
> test: net: add IP defragmentation duplicate-fragment regression test
>
> Add a unit test for the IP datagram reassembler (CONFIG_IP_DEFRAG) that
> covers the duplicate-last-fragment scenario.
>
> Without the fix the last fragment will re-trigger datagram delivery,
> increasing udp_rx_count to 2 and effectively failing the test; with it
> applied the test passes with udp_rx_count == 1.
>
> Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
>
> test/dm/Makefile     |  1 +
>  test/dm/net_defrag.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/test/dm/net_defrag.c b/test/dm/net_defrag.c
> @@ -0,0 +1,82 @@
> +DM_TEST(dm_test_net_ip_defrag_dup_last, 0);

Just to check, does this test actually use driver model?

Regards,
Simon
