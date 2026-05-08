Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE7CCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED6F84CFD;
	Fri,  8 May 2026 17:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F9/kvhz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13A384D00; Fri,  8 May 2026 17:26:41 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E520884CFD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bc3582acc23so324284366b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778253999; cv=none;
 d=google.com; s=arc-20240605;
 b=aDRwH6wx/CpzJOgicJ1NEZTd9zQv7OrDMALnkNrtwqm5ljQNqThVa3KA8p75jsvwQ/
 ouI20ibjP4ePfSFuLHFyrIAf9xWOQy90CIlKWtDzFPvRLSc2EDiYMwnCKaliM1MkGldN
 LQTbr4peewvjD33feALG6dEf/eIuo2Zu6GFS5Xc916JesnIw1pBf564TiWmXgD9q/25Z
 T/A8FVpdHB9CodOBgKywhwNXMKErhnOadBtb904aOBKMtD+wF2BUUYwRQL9mM7+cxV7e
 YXIm2crJdSsbLvJI93NVVA3dowg+JxUBqGVqi1sRj9k/hK/WCStxsDd1ciqIeQ8xSDfJ
 rU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4Reapv2T5RAxeZJ03Uztty4mH27/ygDugU8kMj/oWrg=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=T1e7B9P4H1MZsHrWCwEOcoYzeAjs7W1CH/XKkRMnuSHYa2O89RzOp/b3MY8T3FzifO
 EQqxUAJmNzjiO5j81DIV15ifR3Fy5bFRKbGBYOsBndM5ijSMBV1UuIWGHFQL0+Z49k/U
 naRD5nRx3tqouLwxHBD8BhoEiE/5AG9RTFjLrEYAJpVYjeGNfFeBgANXbwEiPQkVktNL
 2IL0ET3XYVBo4h3kb/la93+Jie0BuhRO6I/1/U5ZKyk70tbbaV2fsHE4A4hwZvHcClVL
 MhjaDI3cGZX3abciHP7O3NMiZ6Saylo5MYw0mjcgVcUyHLzyyRWsneuZm3Y+F3F9Brko
 4qUA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778253999; x=1778858799; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Reapv2T5RAxeZJ03Uztty4mH27/ygDugU8kMj/oWrg=;
 b=F9/kvhz6fHJKH3UjTApzaYGtaiyy771FvtkHrPGNow6tfCDhidA5rd9ppo2mLRAa1k
 7CtSaXpD3Nn5KEwF5h6XNa72jtmuhfw6iboSqsBDrm0TgTW63tykYpNBI+6IrAGQDAQY
 mgvxl8Kv6fEO8bAw3SZit3Kvi/gU2ofZXGvwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253999; x=1778858799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Reapv2T5RAxeZJ03Uztty4mH27/ygDugU8kMj/oWrg=;
 b=DLCbfeGU3uJ/j3ajjJa9BQdsmJz/6IK4qpM+qR5gGNrtFRg7BrEMjGXOFpj+8Anlxg
 QVisqcBkEyHjNboXerSb9InIVFO6fMc5rxV5WtdTineVq73COLcB5to78IU0IdbG/gwU
 UQsNEysCLiDFpp8oFXvuTlvejA0NnglxdayKl/7+Dot6wyhcP/mnbC9bqbgW/+nmgFg5
 DPDcZC9KeKoQtMwWJi1pK6c2JHIxpf4mA3deeMANe5tiJe4rjeuThXOITPiX/72Ilh9K
 NCG3Ac6LjKHytxCYtouJrp3LCvfmtQVoHTHQGd47zc1UKjIAvqfe4F5kQ3uHnsYDreYt
 g+Iw==
X-Gm-Message-State: AOJu0YyaaarW4081Wsd1GF7qRs/0O6/apb/LYkbZYfyH36ACOc3c1BKX
 RjorVy+aU28NX+XML/Pav/0ey2b57EBQHqD4gWuJWrw21KGWQZs/ioFTpM4boZK1fR9MmsYk65j
 k0rjtabuoK9H0Bd4u5yoavvX/QTsg5ZXuFdyxCCjz
X-Gm-Gg: Acq92OFES7Po7LcrYxKrV+001dtfDwuR0sDVf7huA65sQhV0aHTXYWBx34eR8OzWgwk
 c2ZNWf7yUjks6wrNX1yy5JFtI1OF4mXQr5Jy2Gfd0GciUouP/lZOUdjuUQgsgHsGx4pIhwfVuvr
 wNHstjhtuid8y5luCFKAlibyamEDp/wSu1TJ581xAQIiCNBHUt8vFFui2m3wtBYpOIgazaAGeUL
 P3rHoo3qX22Scl2sDkDfiL9W6Ye7hnBQ09PlQKzUPCEJEkuCLKBQNRUhQgXrfDHI8WoUic/naa9
 a7BT9Z2WzMgJtAbx
X-Received: by 2002:a17:907:1ca8:b0:bc3:783f:1da9 with SMTP id
 a640c23a62f3a-bc56d13123amr721920266b.33.1778253999246; Fri, 08 May 2026
 08:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-8-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-8-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:12 -0600
X-Gm-Features: AVHnY4LCnpE7MVYqRc92Yltt9ngrf2CmuxfAvbx-1X71YzZZydpB3rTyrEJtuoU
Message-ID: <CAFLszTiQhg6cLyFGzok3kNESEez===QtEgzGSvnpvj-skr6Gwg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/64] usb: dwc3: import from kernel v4.4
To: jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
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

Hi Jens,

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v4.4

Reviewed-by: Simon Glass <sjg@chromium.org>
