Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C9AE9D80D
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 17:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97DCF8352B;
	Sun,  5 Apr 2026 19:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zx4dVbZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3428394E; Sun,  5 Apr 2026 19:06:58 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7218341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 19:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d9b1c57a4cso2808462a34.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775408814; x=1776013614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=euRJyv/uSnJKmmIWfJ1kNAv990o30CQ45CYfroVghsk=;
 b=Zx4dVbZhZ0eWeUx83m/2rjqlT1nK9Hzc09MZtpmRCJE/+uWUlLfW4YD60gVOrfMmUZ
 m1Sr9IMhTKvc/Aa5qFNtvLgZCEpkxHHyUrhk/gibbYX7JagpCxe/QCuaVNcNxorZszPL
 r09O/PgG0VQ7iUmwsd81iuGmpnW22TrHJUGFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775408814; x=1776013614;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=euRJyv/uSnJKmmIWfJ1kNAv990o30CQ45CYfroVghsk=;
 b=MD6I4J3v2sQjmCBjgstxS2HooQyvT8H8FgY7bXV7kFLv+GipPtPF9h/CI8/dG+Ck6M
 Wk2g8TA2GRDSePuXbKGxkvqRixI1miHz40AdAKlRDtXjpZr6agFOToNfJ1lqUdKcttYn
 1ddYVpfzzK0FurrOxo8IYDqLUiwwGoW40z63EJ4oInVZwSFLHsgkMhYApxs7Dim8eRnr
 Qq8LN5Ew8CzKV8t2gZf9GVRa6ucemuo9VE+5aUy0MNihUjf3ucv5TfEoinSvXX0SFdQY
 SvBHeC+r1zoXh0EMOWb19ygDLN2WZV55Uv7HpXvf7MiDcG1yGEN3hTXoiSEi/to0NoVj
 b56A==
X-Gm-Message-State: AOJu0YyiOWaOhVPvXPs+PDAt4FUJkYFfwKSNRn3KjZE8Q7MuUKXWhlAo
 M1igBF3+rTPB3pxJOKfK5AMNtYbFPN3AlofROxKTzmffvSauu5pKMrBXMw8Y/3OSu5ZoQAPIXID
 Y0ljGs7M=
X-Gm-Gg: AeBDieuJVr/I3Z1UN5Eu/OkVrjS985FXC70V6yAULiswtS9p5JlqnHBN9p71WUqSib/
 F7I5z8v95fWOw+oaGDb7CUPQgwJDqptfYntXzkOf4VsVEbFE/mSra4Dv/EbLL0X+1STHWUely8I
 xELa50mTcPs7CUpH1EM0GX0uaR4X/HenO2WcgExAnzF6odBMLTmKh4th2CKw/ktViYovZHglnST
 /ypXk/LSB6GnXEBdOlPHGb1QvUpudMaSFW0tSnb89AePQMOURUBLBdpIisLygX11rf9Kl1Ff3fA
 ctITQunkKbaUuWOzsWQ4CkwvsESkYrnBO5dO1YIUdbOqod84fx8FnHPDbtp7i+WUq/d4DnaiQZ2
 Oa1NnIKdUDl3VNrpKDUruqzwWccdoCZzuhS6qyAEAfooI73D/4ThYXYm3+G1rXIFEctNQRA+v4L
 46k+zvsP8CtmR/8JBgjy9dICY3+TnE8qx1i05txE61EaSeQieV5lYLsZ86h432BKCZ5t/uictAY
 KZ8YUk4D3n+NenUFQk/otxB3rfMpZMUAFNBvxfPf8IyqNc=
X-Received: by 2002:a05:6830:2aa7:b0:7d7:e245:d597 with SMTP id
 46e09a7af769-7dbb732febcmr5534474a34.2.1775408814431; 
 Sun, 05 Apr 2026 10:06:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba715bd95sm8482788a34.8.2026.04.05.10.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 10:06:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260405043751.350594-1-marek.vasut+renesas@mailbox.org>
References: <20260405043751.350594-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <177540881358.2885227.4293725961823267486.b4-ty@konsulko.com>
Date: Sun, 05 Apr 2026 11:06:53 -0600
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

On Sun, 5 Apr 2026 06:33:57 +0200, Marek Vasut wrote:

> Two trivial fixes for 2026.04 , one fix for possible NULL pointer dereference
> which was not triggered thus far but got detected on Gen5 RSIP, and one basic
> disablement of SCIF1 in DT to which a driver was never bound. But it would be
> nice to have them corrected.
> 
> The following changes since commit 214aababe07de0598bd26ecb0c8fb2e2843ff7d5:
> 
>   Revert "usb: cdns3: use VBUS Valid to determine role for dr_mode OTG" (2026-04-03 17:50:16 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


