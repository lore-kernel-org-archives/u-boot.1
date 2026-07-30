Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C563C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 11:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E108640975;
	Thu, 30 Jul 2026 11:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teTAUngVqGiT; Thu, 30 Jul 2026 11:32:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20D264091F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785411143;
	bh=kjlMhlZMPpoTjd/4B0VHCGcul8fRsTonPS/GVnDtkCA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lIoD2L7HCAnRAqNfdP74207NuD79lcjEoj7RtgFz2OBT8IxZf2RChofkxycTnhagp
	 xUCEk1/y3MnTkysVeahSe44J25WKgFgJyzFqbHhWwcpa+UUWPueVY6nyRTgqaIU4qR
	 RG5tSJhY1wdtkeeGYYVoNgy5+X5SHW1JeN8Dz+ARh8N/KnZeC8KmoocIzqE/UFZ05E
	 AlKKFVdfTkV7DoGWNjotJitQ/5Qu8eHhm2DtRDvRvM/DK3jH6NYzZBGToKDDT2wiEy
	 fiLBfsNz87RnhLovtbGwgjvckzUrAPY5Zc+V4tydbHfiiCQfGqaXD21n3A6++kUmtB
	 te7t93dYsNFow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20D264091F;
	Thu, 30 Jul 2026 11:32:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1362526E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 053744091F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVwlqb7Wq-Xo for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 11:32:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 918C54064D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 918C54064D
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 918C54064D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:32:19 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47362928f65so1737891f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 04:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785411137; x=1786015937;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kjlMhlZMPpoTjd/4B0VHCGcul8fRsTonPS/GVnDtkCA=;
 b=DJb+FJJFtFoUk8Mb79phnTA6jj84d1s3/o5aJ45nn70Uufe9sTeyFOstPFr50p2Dby
 gsOU1QqzgIwUuAMvfbNfooT+63+pQRWWf5g6uwkZI788TmjlofNUVAj+QhOkUc+AvHbc
 Yz0XYtWVLvjUXgW+BX6LnQ5sfcMFCl1HNUtn0ts+Ofn6Vwv3OqDswXPz8o4+kAPBEM9n
 1zA/qq39Oy79HySosnDovsp9aPm9t53x/Jq3FFpRUYS7lyQgCBG497AWRFPYGp+vjAzN
 uZsxGQoPr/NrQkCBK5tqQfOoiGZJ0upKkQY4iFua52sUiQpxUmL6LPatC4ZXD3A3QgDk
 1opw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtNAySbui7FC23rs1YfvszB4ERKeHTKO3SfHqtRcMG2fK8btOd0gHUXM1Hhbv3HAj8bVcgICE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzvqM3cOZ/2pL2KZ5Be9XwOyv2V+QJKtWCjPpQ1SqvivTiuy3kn
 cIWslbQSmJFSUSftwpFRLVIqanSQ4wF8Mr/YdnX7HnC5stzqPveJxu9aizX84oK+zNo=
X-Gm-Gg: AR+sD13/LzNH5fpP1MJDrsIaTHrdLvZH3n3esl06ntvhgyUv30q8HxuajITGSv90jBA
 +TzAiX0rg9Tj+XshvlDD8XXSQqHCwbq8PQT7OUH1OQ1QJ70b8R0EFHNgV6Nu/5A8vnzLBKsUQjo
 FUNje/NR/oq/gLceLF+Jv8j3r5qWh4Lhnuwx8J5/699bDSIkxsFh1NRXUduLTz7jnqHnGe27QS0
 jEwZtpJIVZd7hhoK40OYa9sBuzxohK76GunuL4dKlmpCVQbtUWI5Lo6vJiSE3ujwNP9rKPXoQBh
 qRH84bpmF7jXeFb2O8334T5dKFr2e5ZGROdpugfMHfMwPpvrcnfuNQbU4rytww6IfrGpv+mLx9e
 EI8tIa8EOpNQv2fdy2hGsngRkX9C8bkI3N90uL47+BP0BiWZllYuQTsVpMg9c+cmf5oHhb/2dJO
 1vpghMeBmkj3Broqfb3PZ7g7rYAYLwYuBhM7ty+jJds7AGMTE8zTDho+irG0nKgxVb8eZi8VOkc
 ffUsfOy0jk5GGvqNnpROp5zqurKvi8KdAv1dPoevBRLBdfoaMlHvL2j
X-Received: by 2002:a05:6000:258a:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-47fc80c1418mr3341261f8f.12.1785411137114; 
 Thu, 30 Jul 2026 04:32:17 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cc49sm5504101f8f.17.2026.07.30.04.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 04:32:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 13:32:15 +0200
Message-Id: <DKBVFCI80GJC.1MHZF0Q3E55VX@baylibre.com>
To: "Julien Stephan" <jstephan@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v2 4/4] doc: board: mediatek: document Genio 700 SPL boot
Cc: "GSS_MTK_Uboot_upstream" <GSS_MTK_Uboot_upstream@mediatek.com>,
 <u-boot@lists.u-boot-project.org>, "Ryder Lee" <ryder.lee@mediatek.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun"
 <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Vitor Sato Eschholz" <vsatoes@baylibre.com>,
 "Macpaul Lin" <Macpaul.Lin@mediatek.com>, "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Julien Masson"
 <jmasson@baylibre.com>, "Johan Jonker" <jbx6244@gmail.com>, "Quentin
 Schulz" <u-boot@0leil.net>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>
X-Mailer: aerc 0.21.0
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
 <20260722-ccaione-upstream-mt8390-spl-v2-4-7aa005345711@baylibre.com>
 <CAEHHSvaVY4XB0v6qgopgdyJYNmJqDPMOexdEsFhd3Dztr21CAQ@mail.gmail.com>
In-Reply-To: <CAEHHSvaVY4XB0v6qgopgdyJYNmJqDPMOexdEsFhd3Dztr21CAQ@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785411137; x=1786015937;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kjlMhlZMPpoTjd/4B0VHCGcul8fRsTonPS/GVnDtkCA=;
 b=VDQ5ttofcp6/8f17hn8CA8e3TOJZCUWWuUbKKjuQQJJtChDnLLcj7HI5388O8YqoQn
 NugOa1qMLEWoOKOF0XpDX1bUqyDb87jMuPUimu4va3RcRR5qsUz2d7Uqc2V8LF+o5Yd7
 oWfS0nKZrNKMoBx29bWuhXEvMS3u6xpKrUc3XKcZZNs0RLjoAP9YQl81NFJ9+QwxHhMc
 IxC3JF1a0xyQhPjhpjxx1mN8H+YsNjReIDyxWxAVL0tE+4CfNbQ0YNTUyR566U4Wyrjt
 DKwpqApJRNqxW75D6Ud3Thm/k4HKwfh36bputKELziJebVVmz3iXvCaNexN4wdrIVe/x
 rmVQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VDQ5ttof
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue Jul 28, 2026 at 6:13 PM CEST, Julien Stephan wrote:
> Le mer. 22 juil. 2026 =C3=A0 23:36, Carlo Caione <ccaione@baylibre.com> a=
 =C3=A9crit :
>>
>> Document the normal eMMC boot chain, external firmware prerequisites,
>> binman build invocation and generated images.
>>
>> Also describe storage mapping, handoff details, verification steps, and
>> current security and recovery limitations.
>>
>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> Hi Carlo,

Hey Julien,

> Thank you very much for starting this doc.
> This was already requested few months ago  [1]. MediaTek, wanted to
> handle this internally. Did you sync with them?

Oh TIL. No, I didn't sync explicitly on this point but that thread is
several months old and nothing was done about that so I think we can add
a bit of documentation, we can revise it later if needed or if MediaTek
wants to chime in (in CC).

> Also a lot of stuff in this documentation is quite generic, maybe it
> worth refactoring a bit to share it with other Genio EVKs?

That is unfortunatel not exactly true. We are currently relying
on an ABI contract between the loader and the SPL that is not yet
standardized (I'll document it in the next revision).

There is a conversation going on with several parties involved about
this but this is still pretty much WIP. So also in this case I prefer
to keep this contained for G510 and G700, we can revisit this once the
contract has been formalized and extended to all the Gevio platforms.

Cheers,

--
Carlo Caione
