Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196DCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 371AA404F8;
	Mon, 12 Oct 2026 14:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SkI_KyGHU_b8; Mon, 12 Oct 2026 14:11:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8616240503
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814278;
	b=iWHCXyVWNbfWozapZl0dZZl4gIfhKvePO4xikj5KogBu8RylR/GHDMt9t00Zz5iJZzRc
	 lN8rXy7hXuie7NXaRByfoonELN+7nyxjg597NMXuu9OBTz52Xf+CKpSxp6QTx9/j1I4kN
	 jiLsA295JlW2y0utFwNueJjiRKTUY7LyDMAvhEdkJQXutvBfAKDjvwp54jjoRzNtuIrpB
	 y+3qIa4+YD1p+VkqyTKwtCVRujmJf8FJmmCE2xu6RHiTPVZMtw8dc2r7MS64wS/dnQ/+L
	 qENdxEh7TERvsFDiK3QD6goKaFf9PECntjvxbbw1Im9mZy1m+5gDHw9cseBEDv4LhOg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791814278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EESBOW/wopWMlhNdYe7eDizwYkA/7U3HxWa75QJ+Cys=;
	b=E/OX/l4b/s5U+Pl6ApFRpA2/RhcUvyjAa42DueeT0VPi8O+21ZD7qXHjaVqTOya7iq4y
	 4wWBJecHG1ardJ6sfYyrTOvBN1vu2PuPSCj7GZjQ4/FVD8/yASYQnLAAmo3YYoBBmmWfP
	 D/G8Alo+JD83djfDI8DUUeoQNhjlA55Z6f0CaXDMkqBLvrPxgOmf8lOvAqFPXnCHmo/vT
	 2W8jnI1QmK0W/RX15QsjbV6vG/AD5NOCh1zfaQpp6kQubNf3kJ5vPDW4L2DCXTbOCrPU0
	 JAGovtCkD9UJ/m5gwT80SrP7CxxK7zDNU+ePlnizMnVxVVRgAZ0UGXiHb3JN03yfhvw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791814278;
	bh=EESBOW/wopWMlhNdYe7eDizwYkA/7U3HxWa75QJ+Cys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iBq1Cz1J8HX5cpLQBVniHBn5RRNxg5xGELxWK8fSzdvMn7OxyuqlKYz+pSMfhR3o2
	 6gYeZBaJqmJ1WXMgMebEDHzFbVQKGARqUWrVW0W5xZlte+sGvMHP9OcGvI8hY0IpvV
	 uXfs486OdAcQrd3WuHwMUARFMH9XcGViKghoMoPZBF3QTjOGNYsCua6F8swwPYicNr
	 5RVEc0n+wDZjfw4umAg0WZCCvynJci5Vr3pL2SuNDF8kolmghNPHVOgYncZiPwqpn9
	 94uMIUwRa4bl0GPge8+ANM3mwdaC1466sj+N0upx75B+OWc9D+cUuYkyBpnZjJdvs4
	 GCbyVXy0EZgXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8616240503;
	Mon, 12 Oct 2026 14:11:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FFC6156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64F7D40057
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ky22otJnzeks for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:11:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD8D54004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814276;
 b=jKddyiTQJZdRwEov4MihGhFUjXquBkuFitwlYPrahitsl+6TlsyIlGsFvkYHMzTO12El
 wuGsc2BpcnX2lUQhyz0PVOoyFmJjmpQbcwOUkM2tU0eBxy9wACQi92vmtHiX1Yxa3ypP4
 mWj6JKOSS81KGET6rH9kx7gWrCZCMMiiS1Z0UZnyFrTjQsn+1TPjoVUoCvaPKv80o7Tzp
 Tnghjj8zOn2VvPIKc1hWWE2Gw2Xt+n6V6D0xKG821FNKSA1Pzbsr4c7H3KdxxcssDGBlQ
 +azEAi8r+bNwBZttcZg92+vHswamheTMSGDZW1QNxVlFpiGWTw5qgdj0qIj+9rseZpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791814276;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=EESBOW/wopWMlhNdYe7eDizwYkA/7U3HxWa75QJ+Cys=;
 b=pChqfeTQbK0QRJVc2DPyjjmsQj8kwmpPTm+G3MhuBxZKxUd+/+FXXcAMeXy3wZuIuBHj
 9S0L9dYB/m7CcNOEPFIzbZRQY9n0htHVd5EiptiKdiEj9JfkNUBtHiArFH7wsS7cFDU+M
 o9oMQYtBZ/QnOTO+qgEoa+NOSx5eMKZh/wAzPyjw57mR9Yqn6P5v26Kqu44puzJdX6kt/
 1U4rD6aO6e9alPw2VjG9LpHdB+KiJJIc2ykfc4o4jb0GKbUl82SrAZdwYAuEKUub8Fi2M
 KXBy8e5Lg5sSYYzihpiGG/sUajmMjWQ/MjP8QnIQdEDSxGM6BKanZPN4ZDw8J40HsCg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TJ1C7ry9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TJ1C7ry9
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD8D54004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:11:16 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3a4b9732d5aso1427288a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814276; cv=none;
 d=google.com; s=arc-20260327;
 b=P56ktgDR5d5IBGqaMaeVhLHBO167K1kW9UKPYi06kusVaMHbxfldr8JKfpSdtcfzpX
 zKaCYRFzUqxZiCyYuT4KtzHlvP+xvZDTbJlfVnH2vGAh9qmVcn0ryxW2ebhtoilwS7h8
 WmOUL7kr42ptgi5LGqNqN8D7TlZegjB+pXAJtIgjZdCbzAoY00Oii65iVxfEw39zgLlQ
 yPJy5OFeY1+K3d/l8YYXOrcBdqODfZND/rwwegvHpAC2/U4dOlU7EhJtGotxNUBc5qEq
 FmfQFHYrwp7bSrFkMBuqxk523+pZQilTQXF/U2kblbQbKQhn8QmdOHk8bu/XOax/UbvG
 OKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EESBOW/wopWMlhNdYe7eDizwYkA/7U3HxWa75QJ+Cys=;
 fh=o79Ys6qSfYhucdRfX9Bbxhi9KPfCU326REIue5zaU3M=;
 b=g4sImEWktu2pZ+qpplkKpIHuC1z1dgqTvWq23bNcnoFtT9Lju/vBgJCb3fJUad4U9H
 yBVLAX33FB5RMJH+zU9i68tBJVJOduYXab1zI4FuIkdhZpjZPrP4svDl52UUazACQh9l
 nsF63j8sVWu8VOFi/X4QkGFWD2CFPG86+kL8tIW9qfTTnpw2CkdxwEfQdxhprPG+gotY
 H5714masmf55lgH6bHz2dJ3bqROrEph+8QkNsBxk6LmqBJt5Nv89nhPY3E8ujTviPuNT
 c7pAZTiJtM2j00seCmXogIAIWzMZeLrFuu+qMzY5K9W7UB801bCn1X/rgefvYK9/+K2y
 mpNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791814276; x=1792419076;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EESBOW/wopWMlhNdYe7eDizwYkA/7U3HxWa75QJ+Cys=;
 b=TJ1C7ry972tgTDDPdOMT6s/3A9vKwPbo6ODPrhmlxFQzC96Kgk4NLlWFLqwSgK6bCS
 /YjHXL5O/AmtNT08Ww3G2F1/Yds+7v0gg2LArFK6NVBPuTasy0R49NjuC7xKrF7bM3lK
 M9TczXVUrXqDkxyl6R8DiExumD8NFBh+sJv7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814276; x=1792419076;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EESBOW/wopWMlhNdYe7eDizwYkA/7U3HxWa75QJ+Cys=;
 b=QMuwZXpieyXrVwayd8c2yQABZnZPdKV7BVPuNViZOI9Q8fi/5Aazo7tEerS114tRJ1
 S5HW0rosZMqiayNLNnFcE4S7rnqhy7uMcJR4dXOQVqbwGJahW/aNqi08bvNovl3DikCO
 VfoWjXAXEadZ6xSdbbPozhmi//C7z4DudOuHIJDPJf/pOUj7xhsVFCxzCsQ1hCKzPqL4
 Cm4uvJDDxrLWtRF13071BNv9DBEYNSq4HjGZE0/xeKE3FchDyoNC22WPFe5TGm7J9/H+
 Z6ZoiPPNupO159FVygudUWUUdKfjm7FySNzLw690aUA6WDP9C4f6+f6cOtSXSWAhkioT
 wKUA==
X-Gm-Message-State: AFq9FYL9n/dtghfODbVFe7LLR9XIStDI75dgeE7TYNrzDRtpzwQAy776
 Su9M6cnHk7ZGSzJ/LPnVOS8vGcM5ZwVkjPBjR/J3aTEd3sh4CcqCr+M2sr2OaXM3RhNKmQE/i9w
 yE/C27U1IxZJ5lcHS5tx0PzhsLppNp6q+giGrbk71
X-Gm-Gg: AYBFou0+9XIJ/8FbQ/EV6c4pWIg/orCKV6d3mcG99ok7WUoLE2W8u0LxcWOBgj5rlY1
 +TL1AhqTB7DLkk8oodwrhRGVQngNGkAQYRI3PErm88b1x5keiQD9RP1SK6jYgY7HnngCLHDVOxU
 Zl31/ds3zRUKb1Ws+Sr0MUb6EA+uKexiKugYFiR4XC7dcp9sHHfF0ooOKKMlGVE+5SeQxF+a16C
 7lW2NWHx8TZP1nK8kXk4RXidd/XRHzeJzLG7OcEj6HAuizBUOXEsbUgeCsmuzRN+V90RQZj3/o/
 KIgZBC0vCLM+2bHynGTLiWh79VV1xtf4TSJ0jMrltEk8G5GQusbg1u0=
X-Received: by 2002:a17:90b:1c8e:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3abf2aa161dmr2676045a91.49.1791814275760; Mon, 12 Oct 2026
 07:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261011152235.8842-4-aristo.chen@canonical.com>
In-Reply-To: <20261011152235.8842-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:10:31 +0100
X-Gm-Features: AclHuK-zzTCVjDuSpginciDR9BFw5uKjtALXQHrSVhkm9krb8RM7hIw5wQvGcwY
Message-ID: <CAFLszTgTrtkFEgMp2LVRekW+WttBUejVuadeN8EQHyaHEtu4SA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] test: boot: check the length of the external data
 properties
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 anton@binarly.io, pranavkasthuri@gmail.com, 
 Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-11T15:21:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: boot: check the length of the external data properties
>
> Build a minimal FIT with libfdt and check that
> fit_image_get_data_offset(), fit_image_get_data_position() and
> fit_image_get_data_size() return -EINVAL for an empty property and for
> one of two cells instead of reading them, while a single cell is still
> read and a missing property still gives -ENOENT.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/boot/image.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
