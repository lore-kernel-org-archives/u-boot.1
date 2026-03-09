Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401CCF41812
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB0483F53;
	Mon,  9 Mar 2026 17:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LwtIqEQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9699483A8C; Mon,  9 Mar 2026 17:57:26 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 804FB83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1872504cbso8536646a34.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773075441; x=1773680241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk7MieXlL8fEifawAJb9JG3xr5DwRFIeW9SUUC5/7cI=;
 b=LwtIqEQdUJiZYbDX6d99w87OPYV/YVUFOUFSq4fpTpPWkEdeR9//01LE8oSqfImS4g
 C+8B/RjVCWOsFRXr3v0ppI+F8XdWBgb95boLEsPMzDKOCfBe8oxMPrMo69ACcP2nQ5N6
 HMkrFYpOLAC54A5CwHMdNQF+fiVL+GqIzvdRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773075441; x=1773680241;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fk7MieXlL8fEifawAJb9JG3xr5DwRFIeW9SUUC5/7cI=;
 b=hjUrR/PnARHW9jh8MyAheJYj9GI5VE9pDbbM2a1iQ7ytjiWv/nf6HbzA2C63gfFQt8
 TnEeCfjFxeFeAM+jFoE21NocvxaEZ2KRSbcCR8wVQ8BUUTHcPJjD0AcqD4eZdwU5Qn0S
 ZxU7wUE/Dq2Uspy6w6cAjf6iGCnyFVPo8Spzf+LYF0pQqFaiXBvEmi45CIQM3IObup/G
 iMNksGOpPt+xirWrKQtYOBF+iw4m4S6RkcOgnjUUqctkfDwrlj49B63h8eScFJHoeTnn
 4xzWC4tpZR7vyRqtIRQVST+ua8gMFv1MKcOR5Jzlnd31DOqL/rTtKZhJEj02EdEB9g0Q
 0d3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW57JHs5FA8BqsKO4cIR5cgYRZKzMsrhlV3nMXEfIM20hPVAV2Cvin4qL8w1IE3ovqDajcBYBI=@lists.denx.de
X-Gm-Message-State: AOJu0YzNq0Zjau979wH9OR21wgGX0lRSdQZnqOg4301nOKIB3kHji1dk
 6XswoLQ8+QaD0nEUw5695wDSF9rbe0Rmds5Iz97JuTsneY4WvrlKngMSC77ydoGMWcg=
X-Gm-Gg: ATEYQzzS5qZ0AjEueApZEfo6FzfFWDJ3BwQ4JVxjTD3gOswVFMcy3ThtrF1Nje7IjOz
 I8TyvmIkDWfMXAL1vxFqm0DWY++a0eBR4suQoDGzmdEwL3ib+iJocAPuiJ4wHGASUrXPkf43uuy
 mejIeXIVx8R91nI/wWc4YCl14cnBXxW3sO0ccdXxfFFKh45t+9BS9KpHE9vYGg5aUISWGVjFM5Y
 YDvXVyscL6rUDqFF6XoMQPZpd8deZcdShiiAxPNjQ8lQNSNVanct6BFE+3rlFeyHD91lO/KOuKA
 lKlqiYHXNWaKTkvEydlxEKxs36uQpdo956HqFfSFkjuVPaSnlfiRQyLiDnhwaZcshDjULQwaJSe
 F6f44QZ4yB3iUPqNNENtJfyJdjKrK0bnpZiQtC1dvnj0zKAoEjWkUX3oE8b2XgQC/x3kJK+avH4
 xL63kDs6HLx1dUV8w+Wl3CPpOjqaQADORoZ4sfxCMAOyJzHr2VWGoFxYp1HofP7tdTauJYytqlo
 F4d4Um7iorap/XWRV2MNoIgxH4AWI+n3QJKunG6TlnU
X-Received: by 2002:a05:6830:7092:10b0:7d7:4eaa:8b82 with SMTP id
 46e09a7af769-7d759ba8e9fmr94341a34.17.1773075441096; 
 Mon, 09 Mar 2026 09:57:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d74885b5a4sm2690201a34.23.2026.03.09.09.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:57:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20260205-dsi-v1-1-eb5805068e97@gmail.com>
References: <20260205-dsi-v1-1-eb5805068e97@gmail.com>
Subject: Re: [PATCH] video: stm32: dsi: add .of_to_plat callback
Message-Id: <177307544022.3622694.5493452468697889151.b4-ty@konsulko.com>
Date: Mon, 09 Mar 2026 10:57:20 -0600
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

On Thu, 05 Feb 2026 00:35:40 +0100, Raphael Gallais-Pou wrote:

> Drivers should extract device-tree data before probing via the
> .of_to_plat hook.
> 
> Implement it for stm32_dsi driver.  By doing so, it also solve a
> variable shadowing in stm32_dsi_probe() where &clk was used as
> peripheral clock and ref clock.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] video: stm32: dsi: add .of_to_plat callback
      commit: 0b429f7c6b9de24eb4b8d8ddab74b0020994c405
-- 
Tom


