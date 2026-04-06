Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C807F46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB36383FA3;
	Mon,  6 Apr 2026 19:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YmxyTt2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA10E83936; Mon,  6 Apr 2026 19:10:30 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF3483FA3
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso650479666b.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775495427; cv=none;
 d=google.com; s=arc-20240605;
 b=bKEIyvG96nVBlh/wZFwdlZXXhEON7affVKQci8uEut7mvHER109bWQuRzjNE0GND3m
 dpYI25hkWSDo5uHjh/m6NqJAKiL5KxYcIr6KfQpV4b8TGWfIxHCJYzoe6NEYTl97U8l7
 DHPm7W4fDSH8b43xcB4RzAIWcOUHKuFTUctAHfrZyMh1S8/mOEFdXG4WmWUyesD/MK1a
 YQnhuLOe4JbOEGD1EmTXBvQkVtF4JCW5Tqw+tqfMAfw5TQECWdoggz/HqXlw+hwuSEE/
 Bpc2+f/tyFFQVs0L8zgYCGn6H4DJXafXa0A44PwTX/uuOYYYG9YsBf85wO0BmDp72DLv
 K7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tNzVZ+vGl37EIsUnH6zPmgm/IUWIjX+bgJcpkXjNlBw=;
 fh=DiOx7Ir4jGNTpOGrhALn9nRvEnFQT9HdPASzXprLy2w=;
 b=O2Ucq3C+Vdml8w/xYky9WulFb8GCuQRUfCXi+e5S7X716DlzWEvXnJptV5luntRP9J
 r26qORUBQLAqG84fsaMydwpgDuFESXL3jjRy/zFh5tMzPTiMSel6ScDyNSHlPxtKxWU4
 ehviog7J+4cOs7aS5QR9Ej5aGnDGQHy4g/CvOShkFpuedeYuvkrILlzNc+T7pBjLuzGC
 RbGK+gu47nB8pBn4CXABLoJayuMXz/tgqHcyPA/T3u/iBvwnhFdJtKbGZf/FRlgKseY+
 CLkqfok57ju5rHCqq06vq4Zlctcz8WKIh//qOlonaUJLI5oVvC3RJpuU+sXs8WidT4BP
 YeRA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775495427; x=1776100227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tNzVZ+vGl37EIsUnH6zPmgm/IUWIjX+bgJcpkXjNlBw=;
 b=YmxyTt2ApX0nevQh/PKX11zQzmtk8kIJ+AMH6bhJ8dkEMzSeEBgWY3vDeg+VISzS2j
 Vvt1po+7IMXYSXa0dSUh91sldnULzzuKFQVIz0VvLIFJIv6+98c9R4baJceayKDgT060
 TNxnuoghe+tFi81iJh0dyNm93hDQmlf2lC2EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775495427; x=1776100227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNzVZ+vGl37EIsUnH6zPmgm/IUWIjX+bgJcpkXjNlBw=;
 b=ASYlKoGQ+Qr2HJZ9Ib2j5HbyvnldELQuO9pbMJ+LFia6t7f3SRdevpTAWZHDS+QG+P
 QMVjTagf7TrQcD63PtVC/GjpfztTpdr4R1w1nXBMHxqYBirZZAblRgZn7TPXA4s+rwBv
 dDW/YH/bM8N5lZn4c1sksZZ3i85RExDMiydeQHtLJQs5pJiT0kiTTef6K56SBVswbajr
 Pts0rIig9wgE3mPrqHFZUXDMJGpV9zPFPxQviu8dwcwQ4s83aMNDEtYeDuefyQ2VKA2f
 MPtUxi3k2T+6JGFmoWth97p7DgAaXdNopHbW+T45KTqp/tbZUMQmwFm9R5b0oZtriaTW
 Gi7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4XVkjVJNGMiWp8xIT2k+PGuZiOZuh7oaj8LaicXmK7YSB221QrsrUrmDn1oZ2RE0wTcB8Tyo=@lists.denx.de
X-Gm-Message-State: AOJu0YwRs27XbGDnm+lGw3M7wSVGCP07FOHm6+eGV97B5lZZid0oC1n9
 Hh0PoB7hYgsTVKph/JyroUAirtR+DnuXX0YJZE9N42+CwZ5qr65rVDKOC1AO/063QHYjh6qIiW8
 QdlRp4JQ3cZ0HBXHFSkjK++d0aPa5t90okxrbzEUd
X-Gm-Gg: AeBDiet5bcKc4sRTYpVbZskSrt2D+skbFcb8ypPVNwjwVV/ua+qrBozY0x2uSSLjFut
 SP56jDZRrgt/Pllle56srLjpAa0xoQotrV49ZtxcLw8IGBdd33zkVs4dXV2qZ6mHr0YsSbboP4u
 BbgVPhPd98fHJUuunX5XApvGoIbBBaj4pSroTOKMs8isigh1eJJBAWtGvYB9CZ+YuwKfutTEIyT
 n5EWsUgPL9UA7PCyr08n2tmtP1F5xMs8gOfwRgKHjqODB//du3usYpSxV1NrInpkJ6o52cn4mjY
 3EUOXQ==
X-Received: by 2002:a17:907:ea8:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9c676881bemr655846866b.18.1775495426933; Mon, 06 Apr 2026
 10:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
 <20260403135205.26979-4-ansuelsmth@gmail.com>
In-Reply-To: <20260403135205.26979-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 11:10:14 -0600
X-Gm-Features: AQROBzDIcmlnCFlyKwD2-PlolE4AUz68SvXPtgjkIBNcepu_VO4-ZahMHC7WJMM
Message-ID: <CAFLszTg=CXczoktNG_6HY+7PCjzcFqv-xn9mQm9tGYjEb=ZMiQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] misc: fw_loader: implement generic
 get_fw_loader_from_node()
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Justin Klaassen <justin@tidylabs.net>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-04-03T13:51:57, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement generic get_fw_loader_from_node()
>
> Implement a generic function to get a FW loader dev from a node.
>
> There is currently only get_fs_loader() but that is limited to chosen
> node and is limited only to FS loader.
>
> Introduce get_fw_loader_from_node() that will parse the
> "firmware-loader" from a specified node and will search and probe a
> matching FW loader device, if found.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

> diff --git a/include/fw_loader.h b/include/fw_loader.h
> @@ -6,8 +6,23 @@
> + * Loop over all the supported FW loader and find a matching
> + * one.

Is there a compatible string for this node? Is it in the DT schema?

The comment says it loops over all supported FW loaders but the
implementation does a direct lookup by ofnode with
device_find_global_by_ofnode(). Please can you update the comment to
match.

Regards,
Simon
