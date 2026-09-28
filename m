Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECC8CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90B9180E55;
	Mon, 28 Sep 2026 17:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RcseHIKPDQy0; Mon, 28 Sep 2026 17:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2ADD880DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615687;
	b=ix7cyxeoFamubQkhm3t2+NQKGhGVMwXayl8bJAyCJjyHA46kvfJy++0cZ5MbulzIzpqf
	 rYR4a7qgGTlSJMDhK+bTLfmEgsV+Q7ds3SSpkPCgSJ1MJNNlM8QH+dqWPTpX0UKck45h/
	 Tr572pCWyJptWhJCOLqnwxpZXkRNDzqGzqWRdg6jJthCZcvPxA8DoRubrqB97oPhK4NSO
	 u1z/KMEg2IbxWMNJ3XnV0zUSQwWSdjGLMea6zd5OQJsGvifu+Jqb2WsZFk4ZfYq3swhaF
	 gRcZJJsyomg/MbQZhgahDOth3/NNnKDPs9pvjLvl6QOYAaHGCbD7WWqdZCvmGzM9G6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jlJVuO2Q89oj+1lRjURbgWkOxmqZrIcmlyLUTd88QeM=;
	b=JEQuUpzZjde7uUxh7frZ7xZepGh19A6vu/4L6DTr1FAtNHoaRA423Ae+MbQ5R6or3Gif
	 Yrp6vJ4W9Bu7ecj1y2Z/Du11AOOw0Ecu06N26FQsvYLDVwLRnByz7j3ubb+0STUQSWEoI
	 pxw9RgOpAlnm2ITb08oiXLO9Urvx3JB5s4zsEb4uJ9qscrfO9nvcf+qgZNXnfjZ9H07D9
	 A3HvAafsCtP1fkYjfeYnCv6h1f07MMIxG41UU5A/bOqu/s5mw5nSDPicZLt1kK3LrS7Zy
	 C947rcw5FE98sIt0h0ZYRq3NPCHcZdD1KLyb6RY8hAEkTsfaziu+owD59GhpxJZ3aOg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615687;
	bh=jlJVuO2Q89oj+1lRjURbgWkOxmqZrIcmlyLUTd88QeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfd09XsU2WWDqwyZcqFrXRQS3x3aHGiWrgWPpG95aBqjt7WdLUKyG7Y6e6zbeIRy8
	 aDslphvfacvNW/2qRuMIMXumROn4C6yheMzEsIf9XkNChIDW2Lv9lTzo2zQiRA0Upz
	 HIyD26WTM22nWZ6r7hRFmauAos2oCBS1e+Xom/GpCNKGKWSjCAVSMxNtV/RNfcQtlA
	 2HO/ECKubTFDlLkkdKMOGbNAqWTvbLtKutDMKiEF7S9ESpvWvpIOTTVtAF6eDG1y/d
	 RaEzE3+syV3YzsD2T35DuL+sZjn8QB4fPXFjb+pk6Fvv2Z1CCLGXJmEHmH/c0s/AjL
	 TswFSg9LkEh1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ADD880DBA;
	Mon, 28 Sep 2026 17:14:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DDEE72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7F1F606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYbi4lGeTllM for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 51FC0606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615685;
 b=ZgTBBFE7H/gpKk9S9UHTbodoQs++SImLOzutWrSBJepEgVqqVkEmQGkn+tPKXoQ1+LBp
 nrrZcuX8qwNi5ecfERLMTt+4i89zfui19LvkPMMZp8b8O0EBaxU2Cr5evn5yO3S08DFg2
 31EppW8L7Rb0QxUL4fHHFdIABS/zrSy+P9ZLZc4huLRNENGzZxZnN7MojCUkvJj2EW6SS
 6qzgtzlQx5RPmQQ48wf1CSHNV81MjkJpF09gPMoVJCqoEwhnCdIjCfdDkSXco9ZzZ5B2Y
 rN3LXKX4YKzZwk4xLken0x5z5TmPffkS7mUeWitZmUpHMXKMCU9Tny9xYVj8t839N6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615685;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=jlJVuO2Q89oj+1lRjURbgWkOxmqZrIcmlyLUTd88QeM=;
 b=iPZqarwRxccev+JiEaC46RErpx4y3bJHipABKP+D2MVW08MhltgMx0EUqhtuGzKRuzxi
 DBejFCOd0ZJl0fNdj18OjcTpbBdgS/etv1S/4WeVo6Ms9ZX0OCDzKMrJcx0/ELnsQeFGl
 HgHVKuEE0q3FRejKk4okZoMthn+8IO4DUqFu6F689b6ARO/F7q6QOoK+RlWUQ7nZCzy8M
 NFFVl1nLeyIOklGchTanHrEjVA7B89zUn7X9d1DtHxDtwjRWA3wdSREBld7O8icoN6LkP
 gC8TALl/LduLGPFPLPZYB6IyBCb/uaaXH6XdCkhx6kpQaxFu5RaYqs+RHczI5L/2B2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=M7cpPeYx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=M7cpPeYx
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51FC0606A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:14:44 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b910bdf2eso1653746a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615684; cv=none;
 d=google.com; s=arc-20260327;
 b=aC+u+ucBQOl8t190IcnKg7V8FVGvIzyVybWYREclII9x2v0sWD/dWm9bCNwJmPozSw
 ezzdLrbiXr+y+64V33AxN4GmeLrAaEXmPHjAUzL6/vA7C8xElUiYQUI+WfLCpseIX+Ol
 8mhKshYMHjtFnpAz9a7p9tULkopsekNktEGUboT3rjo5xvMCeF6185ix9AsYtJuhLgXx
 1c8bd1Av0KKR53tM5jQX0ZgqrMkE9KYFini7dOpvVdR/GQkLMqhxm1Xl6DiVHGNTqyoo
 YCreYsXpRCYHLH6nd+V/icA2e0PgEJrD5sAcT23G4dEwd2EPcqaSx3H5ARxbwN5hflJ5
 Lihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jlJVuO2Q89oj+1lRjURbgWkOxmqZrIcmlyLUTd88QeM=;
 fh=hrv2kaYc242Of4WIzTenbrrZYw4FsQk+E+4XMqx+HVU=;
 b=aDaOtdWhoeA4keXjY3Sku8yEi+hxq5VUSnvnTtn1szPXT4YF32VjnjlLeFBvQGSy3H
 R8LbN4vh2Q6zlySTHioplRhiZa5zC/oe80xI0FXHIOgd0skSZHetWQx7cCJ2y9K21uNk
 EIzaA2muU97Q3O40+RNAYziKaPKBNW1sUH9G5A/tzg67khj7NtZ4W1fUXiLe4csrKuBQ
 ng4r3tCYi/xAFcXR3W2O5hnSc2gU1dlUt3jYH1wg5LcaB0T/BteIF4axHV4wMxDCtbMm
 t8ie0H1CBw78TvIol0LyKdQ9k1bol6CFhGA8Ho/IcMKWjO6x2MF+a/+I+pdXxSPCgXEd
 UCWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615684; x=1791220484;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jlJVuO2Q89oj+1lRjURbgWkOxmqZrIcmlyLUTd88QeM=;
 b=M7cpPeYxd79GdZKt3wA4Mi4GvIhnNc7UIxBUmrPwz6EPvynkIIbdBPn11zbdCvRhHh
 0URrBW9qQK3MHwe7AfZd3+1ZIup5l4bV2VqRKadWEUltdhxOYwig8z8TwjSzYQiEJxqh
 1w+NBqNj9Oy3eMMPeol4j2ckv8yDuQebnS6Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615684; x=1791220484;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jlJVuO2Q89oj+1lRjURbgWkOxmqZrIcmlyLUTd88QeM=;
 b=zgPatHT9FvWEwYKYvpZlea2M4wjf2od1JCTY6t0NIp+QK7zc1LZnFFvlYqA/fOHQKU
 LyX3MJR9z3DUjBcoDrTehqicRQc6vS1jBI68ZEzlaNBLaRHNoF95V9pXsEy5jZ2CbjlY
 74S5soeCFld4eofJyiU7mNCMeul1OT/kZvLpQa9Sn9rOBHPT9LACEBNEZAYhY+XN87zK
 7wlnGTfBqBt5MSlzf1fP6rbR+6CRIfFAdm23ULwN8DKUzJpifzrOegQxUbowfTPDkUvC
 9akWAHmyXFyyQuCc9oM/66aBZSp+FzyDnf8Ml5SrT/19R6PO5O4SvjCv89lvsXtXVDF4
 z2Rw==
X-Gm-Message-State: AFq9FYI3J+ErLVgpbAe7+J9ZnYY1OyPJm260xK9Prwi645CmR8KBO6fW
 F9HUkmkgzkvYlAnAC1H7+UIjqj+yrF55HlChCYOBOaH+hW8XN/SL8+KCOSzYVsVKcAZozunEKZc
 7fjHCbYdXMl5CsbBF/oTDeFgNVNIYw81899m6T4EE
X-Gm-Gg: AYBFou0QdGHnSUV4PajRlz0DxVcwQHX+bcod6jnBboqbBYrsGsYzBTpuSfXvlmtRft/
 ZGr12KOYwPn/0BkMFzqYePFa9PuXTeXSePr+gLR+Foh+IeydBJpUznNO0Ig7TC46oy0ODtADKVf
 gzR1rONuc44FJFrwPppCffGEfzIBJbCUgZ0XV4umMizR5TdF7dDshnn+oBfhyZxwX/ChhW7hLFS
 NwblW8lZupBACwt3ILAl304H7KnN5s7C7YUS9p2P4mawbUGjuCoxJ04XwkoKgSUfB7Pc8DrIOZS
 WCDaJXgPiHMIuB7pkYuWA0jnTyxj88KSWrIgG7s+eMdrX9wAZlNiwi+rXyN2PtWm
X-Received: by 2002:a17:90b:4d07:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-3a0985700c8mr12699466a91.1.1790615683927; Mon, 28 Sep 2026
 10:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <arI2cncDYOGXucjb@macbook.homenet.telecomitalia.it>
In-Reply-To: <arI2cncDYOGXucjb@macbook.homenet.telecomitalia.it>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:14:27 -0600
X-Gm-Features: AclHuK8jSU9ygOzj244qTM71m7n51kvx1xaJlGKn__27w062JDgN8Gl8lyPuLFU
Message-ID: <CAFLszTg5HES_KgZy-9D31xQ1RKgvT+0OhyRT=tyYLZDr6eYe3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] firmware-owned devicetree for EBBR / SystemReady
 DeviceTree
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Carlo,

On Tue, 22 Sept 2026 at 02:05, Carlo Caione <ccaione@baylibre.com> wrote:
>
> On Thu, Sep 03, 2026 at 15:09:47 +0100, Carlo Caione wrote:
> > EBBR-style firmware owns the devicetree: the OS is booted via UEFI and
> > receives the devicetree from the firmware through the EFI configuration
> > table instead of shipping its own. U-Boot has the handoff mechanism
> > (efi_install_fdt()), but no generic way to describe and load the
> > firmware-owned source. As a result, platforms carry downstream commands
> > to provide it.
>
> Hi Simon,
> before pushing v4 to address Ilias comments do you have anything for me
> to fix on your side?

I've sent some more thoughts. I'll keep an eye out for v5, patchwork permitting.

Regards,
Simon
