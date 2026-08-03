Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548B7C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D15F6075A;
	Mon,  3 Aug 2026 19:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jwFUMXuv76-j; Mon,  3 Aug 2026 19:26:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49872606B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785785199;
	bh=RgunFNPb9kR2PO4TclQcYgVZCRb4QzxZlpi5KHH8QQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SNbknYU0hoiVhuZA1cLU4Lo/oaiby3734d+0MN5uYQS8Zc1qL81gTRQ2g2tes9kQQ
	 +MsyG1vqI6Uja6fpSlMdjev3G8X6sEB4Qnqojn7x//Ofsh9ssfNNy/bdyQFXpufz8J
	 cHDRzm3MNkbkojfqVjtOwMtw6yApqOag8oKo5as6/WVvEQgUe2E3JM4Pu74vkAJgHV
	 QJ9Kw8D6plzVuxJEciZrtSuWcflFWnztdpIg/bfEQUhh2Hoaq6EfsGyRTUMA0EmUHb
	 TD3Vb+B2HJPd5AIdMA7SAhYZ8+x3vCWlyDjmicU+CvxRGXlwCVWSOezFeFZUZYAcKu
	 kRCLwWESABymw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49872606B8;
	Mon,  3 Aug 2026 19:26:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21DFD194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0885740185
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TaDQ7z282Zq for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:26:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 419AA4010D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 419AA4010D
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 419AA4010D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:37 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a0cb6e96dcso3158163a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785195; cv=none;
 d=google.com; s=arc-20260327;
 b=VGTlwCCsJNhkRPDeMa0K9QCd0qnp22ZziabT8cqL3YQUSNZamEALIESsTwxMoQN66S
 kFhS+zX294RKxxE33TLd7KMpMAYUlHspiKMJExk2hPsNmdQsaTFXEul6nix71utcJwj5
 1LwqA63uRhEc8lm9sexdRgCtJ9xQIRRcNOI4zdTfjmjj6RehzVVT0UwNw/2C+jaia1kl
 ZuoBl9Vtq3rFo+j2OAsOZi2m8IfFKzy2/G3FYAx7B4QtrPjivAjNW10g8f7hTULPWOEX
 0NUXCg8t1LkUA8BdDQue2UK/LVcjIit6/++AHTRcOFdZNTXo6vdGZ9ctq6EujyiueIox
 2Bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RgunFNPb9kR2PO4TclQcYgVZCRb4QzxZlpi5KHH8QQs=;
 fh=PyegyMV1jf5/MicfHcrKysAaAtPVdaTa7g6iemhQKMg=;
 b=prjYUbnQENfFiFiNLIUHMHsLzpPrjA8PBy0aCn7bwPAzwbdJ7ZMH5oApCOGPo+MvF+
 LkA4Hxz6agUy/7asnkrOAn1Vd7NYvgM06ds4tXCtS+eG0cRfc3jYD4esNoHUs/+1wOsu
 GNHhVjLNJAnhTzxSIgIdM+7n2p9Gdbf8FVwyCsvhft0U7kSJ8gqmF6sIZMj2Ajg+DUJc
 fAv8d/yKjbPr1QWRX0YFflpyKkBX+GkudGQxbVk4nBAe9QUnQMT+Y7+w8UpN0/eaUb+0
 i8cTKQ54LKJQ3X1vaK1OlpUGHRjuz9joda+sX0WAEjZuHRx6aSaBtD8MQh7ZQRY3iuaE
 FbTg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785195; x=1786389995;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RgunFNPb9kR2PO4TclQcYgVZCRb4QzxZlpi5KHH8QQs=;
 b=seV9KbE2pNL1P4zs5sStsjTsSt9o1Ue5KbaCbaE24+i4UyEJTcZxrL+UgLw1f0YnyS
 pDuZmGz29cpUAqH3Tkb5/xJ0IfI7kkaTT9/1Tk+t5VHGF9f4EXL74O5rhIPix4/XgZhd
 u87hLS/hpNFw8+aRTNsmocM+YvFErzPjTIrVxFWwIP5EZXi24CPguYtg3hlD3vcg/Joc
 VtsXGYiKoa6nTlSZ3IlNZ2pnvDEdP6X0OdDzoRlQIDCAa99/Kfk2NOLI/xg52x4TYcWR
 lFO9yhR238ERsZBqBpYmt4IGytd3wkIZQE5w3tmQAaWK0iJJo1+8f8eN2Ww7qJjRbHuX
 8bLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RolTYRmO87+l4nM9JEu4W7i8TL7lqtPnnGq0QOGWAg8Ox1/5/y6Kb2wRys4HCdi1vCyNQZJzQU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwB7XWPVyGHX4L1AbKzV75sRjeESJi93ykumq0AGfwM+XseiLAw
 xS79oMa7aGgMeiMNas5YFZvY47ileCPydukPLVMhILzvGw5uKdgC00VpnVXS3hFsuLJWhrHwZ6I
 s3Hda4hkLvakzIPczs9WqMvgkd64B7CSRz7M8UxxA
X-Gm-Gg: AR+sD11qs5KGIu/vY1pIGehADBeE+VsT1to8IXwrQQMMLtchWWYfaO0W31MwLmUeqMr
 L/+lGuJfQ6EnNA6TXwqkoiBKlX3AYKo0g52uqYMKYIMzoUE/BOmj5cmzjZqYa4I1BFLLLGTGZM+
 BU0o1obXggjTpFOBL2bxJ26EyG4t8RRrYcwPJxAcm3KIpzp3NInHh0CQARdITBh6+ka3+6k4hAQ
 efEsxyNKqsA1YFuMiktxz2wo+0t6IXRhVuFZHVxFNnKRcG0c90ls7jZfQi/9KbVUggVegw+tbNL
 gqN/FoUQYggbeUcl1UxQmjsWi0AVMm8t9CDAJAqtrLY=
X-Received: by 2002:a05:6402:24c3:b0:69f:b1d3:3903 with SMTP id
 4fb4d7f45d1cf-6a0a7c6117cmr7690391a12.8.1785785195393; Mon, 03 Aug 2026
 12:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260731001347.35624-1-aristo.chen@canonical.com>
 <20260731001347.35624-8-aristo.chen@canonical.com>
In-Reply-To: <20260731001347.35624-8-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Aug 2026 13:26:13 -0600
X-Gm-Features: AUfX_mzvW567_7QPLMdilDTmC72NM1q2axXrIAB_VUqeDGzVSSPR0zFq6CHh3Ak
Message-ID: <CAFLszTijV2z9zKxv08s6g+sWV9HdbasT91UV1bPTRdKK6wu0cA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] binman: fit: document how ELF load addresses are
 determined
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 sjg@chromium.org, nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, 
 e@freeshell.de, jonas@kwiboo.se,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785785195; x=1786389995;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RgunFNPb9kR2PO4TclQcYgVZCRb4QzxZlpi5KHH8QQs=;
 b=NigYPaU+MGWqJuo59jlTVHbmYL2yn3eHVIGICEqK8rvFQC+LgJ4fiuTbpeVcWTPc1F
 h2hK0HqH2FEIo7CPPR4s/F1giF0d3cJU6yxKPy2H/DS8lP5bLx5xvZwmWUxj0PgijyCE
 kyHvyMvXP2UZ8+73YFO1PH/f/zZpgB3Vmmiy0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=NigYPaU+
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

On 2026-07-31T00:13:34, Aristo Chen <aristo.chen@canonical.com> wrote:
> binman: fit: document how ELF load addresses are determined
>
> The fit,load property confuses users because the load address is
> taken from the ELF file rather than being specified in the binman
> node. Document how to inspect an ELF file to find out where its
> segments will be loaded, using readelf, the linker script or objdump,
> and point at the elf_sections and elf_sections_tee test linker
> scripts as examples of two components placed to avoid overlapping
> memory. Also note that the mkimage load address overlap check works
> on packaged data sizes and therefore assumes uncompressed images.
>
> Compared to the previously applied version of this change, the text
> now lives in the fit etype docstring. The entry documentation is
> produced from docstrings by the binman_docs Sphinx extension at
> documentation build time, so no pre-generated file needs updating.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/binman/etype/fit.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
