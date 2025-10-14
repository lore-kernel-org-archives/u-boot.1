Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83267CCD194
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5159836A3;
	Tue, 14 Oct 2025 16:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J5+H6Aph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F2283303; Tue, 14 Oct 2025 16:20:44 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4CC833F6
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6502b1c3d72so988918eaf.1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451641; x=1761056441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gNfetHHUg3hpc3LIF6hEW7SmZoz9vDCm3epB9uwkDkg=;
 b=J5+H6AphF0wGDZBQIUxlod7riUamwgEm4edSaq19b7JsbYHxfueqFGmPqkZSiLcHIX
 nLjMA/N5MDV79OIaocX3N4NVkV6nSGh8AIa+NJuLboBHyMy4v8l3qCI7ddrcjQm/mIks
 qDu+JqTaq6ghOaoq1diNWhe8fdOB8iJPo+cJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451641; x=1761056441;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNfetHHUg3hpc3LIF6hEW7SmZoz9vDCm3epB9uwkDkg=;
 b=YEabbXHEzmEDpjsv8CeqiaHCN5MHTwLYGhJETKWw/LTtnZKSwIXy7wahY56jCWh9Ox
 TT6FXBiAMgceaaF0cWok+wHsvjMg0tPYo9PAZCOEbDs+H/hMXpKVH7oARfIxrWUIbTFs
 pbMdjOVVVDlPFs5euhDAlCmVJxVxkNXoGp3umRuytGYQ5bQItJsD5zizmUstzWSiPibz
 YKV3IurFVr8Uq/Gl//mbWV/pXKFfP1XDZU0FOYH/So9NE96Z0RATYpr65W6h2ph68GMo
 xPljp6llmoi6/PoOYxFsnhKBoM4YnL658Am7jBrHQ033L2biKe2B54kvwzAPLaMKyqdW
 GVWw==
X-Gm-Message-State: AOJu0YwXQQxlKVThJTmkILWiIsXTPrsrvP++uDcQh0CTnF/n2y+fh1Sd
 AjFw46ui3j/iQvHOB6zHiJ38bulX1THtNGCEkuvdjfLlm+DrAIiXEbi75BO+d++2SgSBxl4SAJf
 sgjumNCA=
X-Gm-Gg: ASbGncvqrw+ShfpW6HrsLHV5dFxZ4OMLkfwM7rJO9V6ouQkB/wUSPMIvH9ZP01mLjZr
 /OGFpGWYAkEskIcyFGaTdTwACChJPpKX8X8wNcKnILCmm7UTKd/s1UNwtzf9whk/Be0qrHrxaQt
 0dRiJaqyo8WjhcEQ+6uXoEGx+UYz07j2VAZxM7D8B1j/go4R40p1YK6nWElEy/0DLDVeu4HEI9W
 tQurcw7aqHYEwBidWPqHb4UJp61zZ1Y4sWUXSCeDQVbJDHX+4TAdaaFdhKloJphZYoRors1k8vN
 AAhukLAAqGia0DqUelP2LK6hCzJuRZhqqkelR3wMyPkKNMakRoVh18GYietx1esfQt1mQ3MP1zS
 fwGarsuENFL4bYVNmrBMwU1Mw6QuS14I3x9ISNJ/PbWnVKXYJGJQRb/C10APitHnAslE4UqnEjV
 dCB8fSBkiMw70T7g==
X-Google-Smtp-Source: AGHT+IF3NXtHu0ndO0nUaNpnxIDIP90Bv0s8Oj+vUFl0bQboIuDROv1DI14FTlS809kwVOYaO25ceQ==
X-Received: by 2002:a05:6870:c1cf:b0:332:1b00:6d5 with SMTP id
 586e51a60fabf-3c0fac557c0mr12704780fac.39.1760451640970; 
 Tue, 14 Oct 2025 07:20:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251009143055.3161450-1-trini@konsulko.com>
References: <20251009143055.3161450-1-trini@konsulko.com>
Subject: Re: [u-boot-test-hooks][PATCH] labgrid-trini: Quick update for
 labgrid v25.0.x and later
Message-Id: <176045164032.284655.13515743574487054740.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 09 Oct 2025 08:30:55 -0600, Tom Rini wrote:

> Starting with v25.0.0 LG_CROSSBAR has been replaced with LG_COORDINATOR
> (and the whole crossbar to coordinator transition is well documented
> upstream). Update our usage.
> 
> 

Applied to u-boot/master, thanks!

[1/1] labgrid-trini: Quick update for labgrid v25.0.x and later
      (no commit info)
-- 
Tom


